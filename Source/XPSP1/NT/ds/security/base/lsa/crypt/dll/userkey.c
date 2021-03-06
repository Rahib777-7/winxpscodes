/*++

Copyright (c) 1989  Microsoft Corporation

Module Name:

    userkey.c

Abstract:

    Implentation of the functions that get and generate user session keys

        RtlCalculateUserSessionKeyLm
        RtlCalculateUserSessionKeyNt
        RtlGetUserSessionKeyClient
        RtlGetUserSessionKeyServer


Author:

    David Chalmers (Davidc) 10-21-91

Revision History:

--*/

#include <nt.h>
#include <ntrtl.h>
#include <nturtl.h>
#include <ntddnfs.h>
#include <rpc.h>
#include <rpcndr.h>
#include <crypt.h>
#include <srvfsctl.h>       // Server definitions
#include <status.h>         // Server return codes

#ifdef WIN32_CHICAGO
#include <assert.h>
#undef ASSERT
#define ASSERT(exp) assert(exp)
#endif
//
// Define this if you want to know all about user session keys
//

// #define DEBUG_USER_SESSION_KEYS



#define REDIRECTOR_DEVICENAME L"\\Device\\LanmanRedirector\\"
#define REDIRECTOR_IPC_FILENAME L"\\IPC$"


//
// Define the user session key to be used for local connections
// Make sure the initial data fills the structure completely !
//

USER_SESSION_KEY LocalSessionKey = { 'S', 'y', 's', 't', 'e', 'm', 'L', 'i',
                                     'b', 'r', 'a', 'r', 'y', 'D', 'T', 'C'
                                   };

//
// Define the user session key that represents an error.
// This value will be generated by other parts of the system on failure.
// We will check for it in our query code and return an error if it's found.
//

USER_SESSION_KEY ErrorSessionKey = { 0, 0, 0, 0, 0, 0, 0, 0,
                                     0, 0, 0, 0, 0, 0, 0, 0
                                   };



NTSTATUS
RtlCalculateUserSessionKeyLm(
    IN PLM_RESPONSE LmResponse,
    IN PLM_OWF_PASSWORD LmOwfPassword,
    OUT PUSER_SESSION_KEY UserSessionKey)

/*++

Routine Description:

    Takes the passed Response and OwfPassword and generates a UserSessionKey.

    The current implementation takes the one-way-function of the OwfPassword
    and returns this as the key.

Arguments:

    LmResponse - The response sent during session setup.

    LmOwfPassword - The hashed version of the user's password.

Return Values:

    STATUS_SUCCESS - The function was completed successfully.
                     The UserSessionKey is in UserSessionKey.

    STATUS_UNSUCCESSFUL - Something failed. The UserSessionKey is undefined.
--*/

{
    NTSTATUS Status;
    NT_PASSWORD NtPassword;

    //
    // Make the Owf password look like an NT password
    //

    NtPassword.Buffer = (PWSTR)LmOwfPassword; // We can do this cast because we
                                              // know the OWF routine treats this
                                              // pointer as a byte pointer.
    NtPassword.Length = sizeof(*LmOwfPassword);
    NtPassword.MaximumLength = sizeof(*LmOwfPassword);


    //
    // Calculate the OWF of the OwfPassword
    //

    ASSERT(sizeof(NT_OWF_PASSWORD) == sizeof(*UserSessionKey));

    Status = RtlCalculateNtOwfPassword( &NtPassword,
                                        (PNT_OWF_PASSWORD)UserSessionKey
                                        );
    if (!NT_SUCCESS(Status)) {
        KdPrint(("RtlCalculateUserSessionKeyLm : OWF calculation failed, status = 0x%lx\n", Status));
        return(Status);
    }

    //
    // Check if we've generated the error session key
    //

    if (RtlCompareMemory(UserSessionKey, &ErrorSessionKey,
                       sizeof(*UserSessionKey)) == sizeof(*UserSessionKey)) {

#ifdef DEBUG_USER_SESSION_KEYS
        KdPrint(("RtlCalculateSessionKeyLm - generated error session key, modifying it\n"));
#endif
        //
        // Move away from the error session key
        //

        UserSessionKey->data[0].data[0] ++;

        ASSERT(RtlCompareMemory(UserSessionKey, &ErrorSessionKey,
                       sizeof(*UserSessionKey)) != sizeof(*UserSessionKey));
    }

#ifdef DEBUG_USER_SESSION_KEYS
    KdPrint(("RtlCalculateUserSessionKeyLm : Key = 0x%lx : %lx : %lx : %lx\n",
            ((PULONG)UserSessionKey)[0], ((PULONG)UserSessionKey)[1],
            ((PULONG)UserSessionKey)[2], ((PULONG)UserSessionKey)[3]));
#endif

    return(STATUS_SUCCESS);

    UNREFERENCED_PARAMETER(LmResponse);
}



NTSTATUS
RtlCalculateUserSessionKeyNt(
    IN PNT_RESPONSE NtResponse,
    IN PNT_OWF_PASSWORD NtOwfPassword,
    OUT PUSER_SESSION_KEY UserSessionKey)

/*++

Routine Description:

    Takes the passed Response and OwfPassword and generates a UserSessionKey.

Arguments:

    NtResponse - The response sent during session setup.

    NtOwfPassword - The hashed version of the user's password.

Return Values:

    STATUS_SUCCESS - The function was completed successfully.
                     The UserSessionKey is in UserSessionKey.

    STATUS_UNSUCCESSFUL - Something failed. The UserSessionKey is undefined.
--*/

{
    // Just call the LM version

    ASSERT(sizeof(NT_RESPONSE) == sizeof(LM_RESPONSE));
    ASSERT(sizeof(NT_OWF_PASSWORD) == sizeof(LM_OWF_PASSWORD));

    return(RtlCalculateUserSessionKeyLm((PLM_RESPONSE)NtResponse,
                                        (PLM_OWF_PASSWORD)NtOwfPassword,
                                        UserSessionKey));
}


NTSTATUS
RtlGetUserSessionKeyClientBinding(
    IN PVOID RpcBindingHandle,
    OUT HANDLE *RedirHandle,
    OUT PUSER_SESSION_KEY UserSessionKey)

/*++

Routine Description:

    Returns the user session key associated with an rpc connection.
    This function should be called by the client side of the connection only.

Arguments:

    RpcBindingHandle - The rpc connection we're interested in

    RedirHandle - Returns a handle to the redir.  Since RpcBindingHandles don't represent
        and open connection to the server, we have to ensure the connection stays open
        until the server side has a chance to get this same UserSessionKey.  The only
        way to do that is to keep the connect open.

        Returns NULL if no handle is needed.

        This handle should be closed by calling NtClose.

    UserSessionKey - The user session key is returned here

Return Values:

    STATUS_SUCCESS - The function was completed successfully.
                     The UserSessionKey is in UserSessionKey.

    STATUS_LOCAL_USER_SESSION_KEY - An informational status value.
                   - The rpc connection is local, the usersessionkey returned
                   - is constant and not unique to this connection.
                   - There is little to be gained by encrypting data over
                   - this connection

    STATUS_NO_USER_SESSION_KEY - No session key exists for this session.

    ------ these come from parsebinding -------

    RPC_NT_OUT_OF_MEMORY - Insufficent memory is available to allocate
        space for the fields of the string binding.

    RPC_NT_INVALID_STRING_BINDING - The string binding is syntactically
        invalid.

    RPC_NT_INVALID_ARG - The string binding is not specified
        (ie. ARGUMENT_PRESENT(StringBinding) is false).
--*/

{
    NTSTATUS Status, IgnoreStatus;
    WCHAR    *StringBinding;
    WCHAR    *ServerNameZ;
    WCHAR    *BareServerNameZ; // Points to server name minus leading '\'s
    OBJECT_ATTRIBUTES Attributes;
    UNICODE_STRING ServerName;
    UNICODE_STRING RedirDevice;
    UNICODE_STRING IpcFileName;
    UNICODE_STRING ServerIpcFileName;
    USHORT  LengthRequired;
    IO_STATUS_BLOCK IoStatusBlock;
    LMR_REQUEST_PACKET RdrRequestPacket;
    LMR_CONNECTION_INFO_2 ConnectionInfo;


    //
    // Get the string description of the binding from the rpc handle
    //

    *RedirHandle = NULL;
    Status = (NTSTATUS)I_RpcMapWin32Status(
            RpcBindingToStringBindingW(RpcBindingHandle, &StringBinding));
    if (!NT_SUCCESS(Status)) {
        KdPrint(("RtlGetUserSessionKeyClient - failed to get stringbinding, Status = 0x%lx\n\r", Status));
        ASSERT(FALSE);
        return(Status);
    }

    //
    // Parse the stringbinding to get the server name
    //

    Status = (NTSTATUS)I_RpcMapWin32Status(RpcStringBindingParseW(
                                StringBinding,
                                NULL,                // object uid
                                NULL,                // protseq !
                                &ServerNameZ,        // network address
                                NULL,                // endpoint
                                NULL                 // network options
                                ));

    //
    // We're finished with the string binding
    //

    IgnoreStatus = I_RpcMapWin32Status(RpcStringFreeW(&StringBinding));
    ASSERT(NT_SUCCESS(IgnoreStatus));

    //
    // Check the result of binding parse
    //

    if (!NT_SUCCESS(Status)) {
        KdPrint(("RtlGetUserSessionKeyClient - failed to parse stringbinding, status = 0x%lx\n\r", Status));
        ASSERT(FALSE);
        return(Status);
    }

    //
    // Check for a local connection
    //

    if ( (ServerNameZ == NULL) || (ServerNameZ[0] == UNICODE_NULL) ) {

#ifdef DEBUG_USER_SESSION_KEYS
        KdPrint(("RtlGetUserSessionKeyClient - server name is NULL, returning local key\n"));
#endif
        //
        // Use a constant, default session key
        //

        *UserSessionKey = LocalSessionKey;

        IgnoreStatus = I_RpcMapWin32Status(RpcStringFreeW(&ServerNameZ));
        ASSERT(NT_SUCCESS(IgnoreStatus));

        return(STATUS_LOCAL_USER_SESSION_KEY);
    }

    //
    // Strip the leading '\'s from the server name
    //

    BareServerNameZ = ServerNameZ;
    while (*BareServerNameZ == L'\\') {
        BareServerNameZ ++;
    }

    //
    // Set up a counted string for out server name
    //

    RtlInitUnicodeString(&ServerName, BareServerNameZ);


    //
    // Check for the local server name '.'
    //

    if ( (ServerName.Length == sizeof(*ServerName.Buffer)) &&
         (ServerName.Buffer[0] == L'.') ) {

#ifdef DEBUG_USER_SESSION_KEYS
        KdPrint(("RtlGetUserSessionKeyClient - server name is '.', returning local key\n"));
#endif
        //
        // Use a constant, default session key
        //

        *UserSessionKey = LocalSessionKey;

        IgnoreStatus = I_RpcMapWin32Status(RpcStringFreeW(&ServerNameZ));
        ASSERT(NT_SUCCESS(IgnoreStatus));

        return(STATUS_LOCAL_USER_SESSION_KEY);
    }


    //
    // Create a redirector ipc file name for the referenced server
    //

    RtlInitUnicodeString(&RedirDevice, REDIRECTOR_DEVICENAME);
    RtlInitUnicodeString(&IpcFileName, REDIRECTOR_IPC_FILENAME);

    LengthRequired = RedirDevice.Length + ServerName.Length + IpcFileName.Length;


    //
    // Allocate space for the ipc file name we will create
    //

    ServerIpcFileName.Buffer = RtlAllocateHeap(RtlProcessHeap(), 0, LengthRequired);
    if (ServerIpcFileName.Buffer == NULL) {

        KdPrint(("RtlGetUserSessionKeyClient - failed to allocate space for server name (%d bytes)\n", LengthRequired));

        IgnoreStatus = I_RpcMapWin32Status(RpcStringFreeW(&ServerNameZ));
        ASSERT(NT_SUCCESS(IgnoreStatus));

        return(STATUS_INSUFFICIENT_RESOURCES);
    }

    ServerIpcFileName.Length = 0;
    ServerIpcFileName.MaximumLength = LengthRequired;


    //
    // ServerIpcFileName = \Device\LanmanRedirector\ + servername + \ipc$
    //

    RtlCopyUnicodeString(&ServerIpcFileName, &RedirDevice);

    IgnoreStatus = RtlAppendUnicodeStringToString(&ServerIpcFileName, &ServerName);
    ASSERT(NT_SUCCESS(IgnoreStatus));

    IgnoreStatus = RtlAppendUnicodeStringToString(&ServerIpcFileName, &IpcFileName);
    ASSERT(NT_SUCCESS(IgnoreStatus));

    //
    // Don't need the server name any more
    //

    IgnoreStatus = I_RpcMapWin32Status(RpcStringFreeW(&ServerNameZ));
    ASSERT(NT_SUCCESS(IgnoreStatus));




    //
    // Open up the redirector ipc file
    //

    InitializeObjectAttributes( &Attributes,
                                &ServerIpcFileName,
                                OBJ_CASE_INSENSITIVE,
                                NULL,
                                NULL );

    Status = NtOpenFile( RedirHandle,
                         FILE_READ_DATA |   // access required to get connection info
                         SYNCHRONIZE,       // access required to wait on object
                         &Attributes,
                         &IoStatusBlock,
                         FILE_SHARE_READ,
                         FILE_CREATE_TREE_CONNECTION );
    //
    // We're finished with the ipc filename
    //

    RtlFreeHeap( RtlProcessHeap(), 0, ServerIpcFileName.Buffer );
    ServerIpcFileName.Buffer = NULL;

    //
    // Check the result of the open
    //

    if (!NT_SUCCESS(Status)) {
        KdPrint(("RtlGetUserSessionKeyClient - failed to open redirector, status = 0x%lx\n\r", Status));
        *RedirHandle = NULL;
        return(Status);
    }



    //
    // Get the connection info for this link
    //

    RdrRequestPacket.Version = REQUEST_PACKET_VERSION;
    RdrRequestPacket.Level = 2; // We want the session key.

    Status = NtFsControlFile( *RedirHandle,
                              NULL,                     // Event
                              NULL,                     // APC routine
                              NULL,                     // APC context
                              &IoStatusBlock,
                              FSCTL_LMR_GET_CONNECTION_INFO,
                              &RdrRequestPacket,        // Input buffer
                              sizeof(RdrRequestPacket), // Input buffer length
                              &ConnectionInfo,          // Output buffer
                              sizeof(ConnectionInfo)    // Output buffer length
                              );

    //
    // remove the reference created on the existing connection.
    // this logic assumes the caller of RtlGetUserSessionKeyClientXXX()
    // has already established a connection.
    //

    {
        LMR_REQUEST_PACKET Rrp;            // Redirector request packet
        NTSTATUS           TempStatus;
 
        RtlZeroMemory(&Rrp,sizeof(LMR_REQUEST_PACKET));
        Rrp.Level = USE_FORCE;  // this tells rdr2 to take away the extra reference
                                // to connection strucutre even when files are open.
        Rrp.Version = REQUEST_PACKET_VERSION;
 
        TempStatus = NtFsControlFile(
                            *RedirHandle,                   // handle
                            NULL,                           // no event
                            NULL,                           // no APC routine
                            NULL,                           // no APC context
                            &IoStatusBlock,                 // I/O stat blk (set)
                            FSCTL_LMR_DELETE_CONNECTION,    // func code
                            &Rrp,
                            sizeof(LMR_REQUEST_PACKET),
                            NULL,
                            0
                            );

        //
        // block on the delete if necessary.
        //

        if( TempStatus == STATUS_PENDING )
        {
            NtWaitForSingleObject( *RedirHandle, TRUE, NULL );
        }
    }



    //
    // Check the result of the control file call
    //

    if (!NT_SUCCESS(Status)) {
        IgnoreStatus = NtClose(*RedirHandle);
        ASSERT(NT_SUCCESS(IgnoreStatus));
        *RedirHandle = NULL;
        KdPrint(("RtlGetUserSessionKeyClient - failed to get connection info, status = 0x%lx\n\r", Status));
        ASSERT(FALSE);
        return(Status);
    }

    //
    // Copy the session key into the passed buffer
    //

    *UserSessionKey = *(PUSER_SESSION_KEY)(ConnectionInfo.UserSessionKey);


    //
    // Check for the error session key
    //

    if (RtlCompareMemory(UserSessionKey, &ErrorSessionKey,
                       sizeof(*UserSessionKey)) == sizeof(*UserSessionKey)) {

#ifdef DEBUG_USER_SESSION_KEYS
        KdPrint(("RtlGetUserSessionKeyClient - got error session key, returning error\n"));
#endif
        Status = STATUS_NO_USER_SESSION_KEY;
        IgnoreStatus = NtClose(*RedirHandle);
        ASSERT(NT_SUCCESS(IgnoreStatus));
        *RedirHandle = NULL;
    }


#ifdef DEBUG_USER_SESSION_KEYS
    KdPrint(("RtlGetUserSessionKeyClient : Key = 0x%lx : %lx : %lx : %lx\n",
            ((PULONG)UserSessionKey)[0], ((PULONG)UserSessionKey)[1],
            ((PULONG)UserSessionKey)[2], ((PULONG)UserSessionKey)[3]));
#endif

    return(Status);
}






NTSTATUS
RtlGetUserSessionKeyClient(
    IN PVOID RpcContextHandle,
    OUT PUSER_SESSION_KEY UserSessionKey)

/*++

Routine Description:

    Returns the user session key associated with an rpc connection.
    This function should be called by the client side of the connection only.

Arguments:

    RpcContextHandle - The rpc connection we're interested in
        This can also be an RPC binding handle.

    UserSessionKey - The user session key is returned here

Return Values:

    STATUS_SUCCESS - The function was completed successfully.
                     The UserSessionKey is in UserSessionKey.

    STATUS_LOCAL_USER_SESSION_KEY - An informational status value.
                   - The rpc connection is local, the usersessionkey returned
                   - is constant and not unique to this connection.
                   - There is little to be gained by encrypting data over
                   - this connection

    STATUS_NO_USER_SESSION_KEY - No session key exists for this session.

    ------ these come from parsebinding -------

    RPC_NT_OUT_OF_MEMORY - Insufficent memory is available to allocate
        space for the fields of the string binding.

    RPC_NT_INVALID_STRING_BINDING - The string binding is syntactically
        invalid.

    RPC_NT_INVALID_ARG - The string binding is not specified
        (ie. ARGUMENT_PRESENT(StringBinding) is false).
--*/

{
    NTSTATUS Status;
    HANDLE RedirHandle = NULL;

    //
    // Call the worker routine.
    //

    Status = RtlGetUserSessionKeyClientBinding(
                NDRCContextBinding((NDR_CCONTEXT)RpcContextHandle),
                &RedirHandle,
                UserSessionKey );

    if ( RedirHandle != NULL ) {
        NtClose( RedirHandle );
    }

    return Status;
}



NTSTATUS
RtlGetUserSessionKeyServer(
    IN PVOID RpcContextHandle OPTIONAL,
    OUT PUSER_SESSION_KEY UserSessionKey)

/*++

Routine Description:

    Returns the user session key associated with an rpc connection.
    This function should be called by the server side of the connection only.

Arguments:

    RpcBindingHandle - The rpc connection we're interested in
                     - Note this parameter is ignored for now

    UserSessionKey - The user session key is returned here

Return Values:

    STATUS_SUCCESS - The function was completed successfully.
                     The UserSessionKey is in UserSessionKey.

    STATUS_LOCAL_USER_SESSION_KEY - An informational status value.
                   - The rpc connection is local, the usersessionkey returned
                   - is constant and not unique to this connection.
                   - There is little to be gained by encrypting data over
                   - this connection

    STATUS_NO_USER_SESSION_KEY - No session key exists for this session.

--*/

{
    NTSTATUS Status, IgnoreStatus;
    HANDLE  TokenHandle;
    TOKEN_STATISTICS TokenInfo;
    ULONG ReturnedLength;
    UNICODE_STRING ServerDevice;
    ANSI_STRING AnsiString;
    OBJECT_ATTRIBUTES Attributes;
    IO_STATUS_BLOCK IoStatusBlock;
    HANDLE  ServerHandle;
    RPC_BINDING_HANDLE RpcBindingHandle;
    unsigned int RpcClientLocalFlag;


    //
    // Get the binding handle for this connection
    //

    // LATER RpcBindingHandle = (RPC_BINDING_HANDLE) RpcContextHandle;
    RpcBindingHandle = NULL;


    //
    // If this is a local connection then we can immediately
    // return the local session key.
    //

    Status = I_RpcBindingIsClientLocal(RpcBindingHandle, &RpcClientLocalFlag);
    if (!NT_SUCCESS(Status)) {
        KdPrint(("RtlGetUserSessionKeyServer: RpcBindingIsClientLocal failed, status = 0x%lx\n", Status));
        return(Status);
    }

    if (RpcClientLocalFlag != 0) {
        *UserSessionKey = LocalSessionKey;
#ifdef DEBUG_USER_SESSION_KEYS
        KdPrint(("RtlGetUserSessionKeyServer: client is local, returning local key\n"));
#endif
        return (STATUS_LOCAL_USER_SESSION_KEY);
    }




    //
    // Get a handle to the client's token
    //

    Status = NtOpenThreadToken(NtCurrentThread(),
                               TOKEN_QUERY,
                               TRUE,
                               &TokenHandle);
    //
    // If we couldn't open the thread token because we weren't impersonating
    // then impersonate and try again.
    //

    if (!NT_SUCCESS(Status)) {

        //
        // Check we failed only because we weren't impersonating
        //

        if (Status != STATUS_NO_TOKEN) {
            KdPrint(("RtlGetUserSessionKeyServer - failed to open thread token, status = 0x%lx\n", Status));
            ASSERT(FALSE);
            return(Status);
        }

        //
        // Impersonate the client ourselves
        //

        Status = I_RpcMapWin32Status(RpcImpersonateClient(RpcBindingHandle));
        if (!NT_SUCCESS(Status)) {
            KdPrint(("RtlGetUserSessionKeyServer - RpcImpersonateClient failed, status = 0x%lx\n", Status));
            ASSERT(FALSE);
            return(Status);
        }

        //
        // Try to get a token handle now we're impersonating
        //

        Status = NtOpenThreadToken(NtCurrentThread(),
                                   TOKEN_QUERY,
                                   TRUE,
                                   &TokenHandle);
        if (!NT_SUCCESS(Status)) {

            KdPrint(("RtlGetUserSessionKeyServer - failed to open thread token after impersonating, status = 0x%lx\n", Status));
            ASSERT(FALSE);

            IgnoreStatus = I_RpcMapWin32Status(RpcRevertToSelf());
            ASSERT(NT_SUCCESS(IgnoreStatus));

            return(Status);
        }

        //
        // We've got a token handle, stop impersonating
        //

        Status = I_RpcMapWin32Status(RpcRevertToSelf());

        if (!NT_SUCCESS(Status)) {

            KdPrint(("RtlGetUserSessionKeyServer - RpcRevertToSelf failed, status = 0x%lx\n", Status));
            ASSERT(FALSE);

            IgnoreStatus = NtClose(TokenHandle);
            ASSERT(NT_SUCCESS(IgnoreStatus));

            return(Status);
        }

    }

    //
    // We've now got a token handle, get the authentication id from it.
    //

    Status = NtQueryInformationToken(
                    TokenHandle,
                    TokenStatistics,
                    &TokenInfo,
                    sizeof(TokenInfo),
                    &ReturnedLength
                    );

    //
    // We're done with the token
    //

    IgnoreStatus = NtClose(TokenHandle);
    ASSERT(NT_SUCCESS(IgnoreStatus));

    //
    // Check result of token query
    //

    if (!NT_SUCCESS(Status)) {

        KdPrint(("RtlGetUserSessionKeyServer - Failed to query token statistics from token, status = 0x%lx\n", Status));
        ASSERT(FALSE);

        return(Status);
    }



    //
    // Open the server device
    //

    RtlInitAnsiString(&AnsiString, SERVER_DEVICE_NAME);

    Status = RtlAnsiStringToUnicodeString(&ServerDevice, &AnsiString, TRUE);
    if (!NT_SUCCESS(Status)) {

        KdPrint(("RtlGetUserSessionKeyServer - RtlAnsiToUnicodeString failed, status = 0x%lx\n", Status));
        ASSERT(FALSE);

        return(Status);
    }

    InitializeObjectAttributes( &Attributes,
                                &ServerDevice,
                                OBJ_CASE_INSENSITIVE,
                                NULL,
                                NULL );

    Status = NtOpenFile( &ServerHandle,
                         GENERIC_READ | GENERIC_WRITE, // LATER use correct access
                         &Attributes,
                         &IoStatusBlock,
                         FILE_SHARE_READ,
                         0 );

    RtlFreeUnicodeString(&ServerDevice);

    if (!NT_SUCCESS(Status)) {

        //
        // Check for the case when the server driver is not present
        //

        if (Status == STATUS_OBJECT_NAME_NOT_FOUND) {

#ifdef DEBUG_USER_SESSION_KEYS
            KdPrint(("RtlGetUserSessionKeyServer - server driver not present, returning local key\n"));
#endif
            *UserSessionKey = LocalSessionKey;
            Status = STATUS_LOCAL_USER_SESSION_KEY;

        } else {
            KdPrint(("RtlGetUserSessionKeyServer - Failed to open the server, status = 0x%lx\n", Status));
            ASSERT(FALSE);
        }

        return(Status);
    }


    //
    // Get the session key for this client from the server
    //

    Status = NtFsControlFile( ServerHandle,
                              NULL,                 // Event
                              NULL,                 // APC
                              NULL,                 // APC Context
                              &IoStatusBlock,
                              FSCTL_SRV_GET_CHALLENGE,
                              &TokenInfo.AuthenticationId,
                              sizeof(TokenInfo.AuthenticationId),
                              (PVOID)UserSessionKey,
                              sizeof(*UserSessionKey));
    //
    // We're done with the file handle
    //

    IgnoreStatus = NtClose(ServerHandle);
    ASSERT(NT_SUCCESS(IgnoreStatus));



    if (NT_SUCCESS(Status)) {

        //
        // Check for the error session key
        //

        if (RtlCompareMemory(UserSessionKey, &ErrorSessionKey,
                           sizeof(*UserSessionKey)) == sizeof(*UserSessionKey)) {

#ifdef DEBUG_USER_SESSION_KEYS
            KdPrint(("RtlGetUserSessionKeyServer - got error session key, returning error\n"));
#endif
            Status = STATUS_NO_USER_SESSION_KEY;
        }

    } else {

        //
        // If the server is not started or the token couldn't be found in the
        // list of server connections, then assume it's a local connection
        //

        if ( (Status == STATUS_SERVER_NOT_STARTED) ||
             (Status == STATUS_NO_TOKEN) ) {

#ifdef DEBUG_USER_SESSION_KEYS
            KdPrint(("RtlGetUserSessionKeyServer - server not started or logon id not found (Status = 0x%lx), returning local key\n", Status));
#endif
            *UserSessionKey = LocalSessionKey;
            Status = STATUS_LOCAL_USER_SESSION_KEY;

        } else {
            KdPrint(("RtlGetUserSessionKeyServer - Failed to query the user session key from the server, status = 0x%lx\n", Status));
            ASSERT(FALSE);
        }
    }


#ifdef DEBUG_USER_SESSION_KEYS
    KdPrint(("RtlGetUserSessionKeyServer : Key = 0x%lx : %lx : %lx : %lx, status = 0x%lx\n",
            ((PULONG)UserSessionKey)[0], ((PULONG)UserSessionKey)[1],
            ((PULONG)UserSessionKey)[2], ((PULONG)UserSessionKey)[3], Status));
#endif


    return(Status);
}
