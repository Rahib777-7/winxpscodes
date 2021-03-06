//+-------------------------------------------------------------------------
//
//  Microsoft Windows
//
//  Copyright (C) Microsoft Corporation, 1997 - 1999
//
//  File:       drts.cxx
//
//--------------------------------------------------------------------------

#include <windows.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include "drt.h"   // header file generated by MIDL compiler

void __cdecl main(int argc, char * argv[])
{
    RPC_STATUS status;
    RPC_BINDING_VECTOR * pBindingVector = NULL;
    WCHAR * pszEntryName            = L"/.:/drtsrv_01";
    WCHAR * pszGrpEntryName1        = L"/.:/drtgrp_01";
    WCHAR * pszPrfEntryName1        = L"/.:/drtprf_01";
    unsigned char * pszSecurity     = NULL;
    unsigned int    cMinCalls       = 1;
    unsigned int    cMaxCalls       = 20;
    unsigned int    fDontWait       = 0;
    unsigned int    fNameSyntaxType = RPC_C_NS_SYNTAX_DEFAULT;
    unsigned int    fRegistered     = 0;
    unsigned int    fEndpoint       = 0;
    unsigned int    fExported       = 0;
      // abcdefab-abcd-abcd-abcd-abcdefabcdef
    RPC_IF_ID       ifid            = {{ 0xabcdefab, 0xabcd, 0xabcd, { 0xab, 0xcd, 0xab, 0xcd, 0xef, 0xab, 0xcd, 0xef } },
                                      1, 0};
    int             i;

    printf("CallingRpcServerUseAllProtseqs...\n");

    status = RpcServerUseAllProtseqs(cMaxCalls,     // max concurrent calls
                                     pszSecurity);  // Security descriptor
    printf("RpcServerUseAllProtseqs returned 0x%x\n", status);
    if (status) {
        goto cleanup;
    }

    status = RpcServerRegisterIf(drtsrv_01_v1_0_s_ifspec, // interface to register
                                 NULL,                    // MgrTypeUuid
                                 NULL);                   // MgrEpv; null means use default
    printf("RpcServerRegisterIf returned 0x%x\n", status);
    if (status) {
        goto cleanup;
    }
    else
        fRegistered = 1;

    status = RpcServerInqBindings(&pBindingVector);
    printf("RpcServerInqBindings returned 0x%x\n", status);
    if (status) {
        goto cleanup;
    }

    status = RpcEpRegister(drtsrv_01_v1_0_s_ifspec,
                           pBindingVector,
                           NULL,
                           L"");
    printf("RpcEpRegister returned 0x%x\n", status);
    if (status) {
        goto cleanup;
    }
    else
        fEndpoint = 1;

     status = RpcNsBindingExport(fNameSyntaxType,  // name syntax type
				 pszEntryName,     // nsi entry name
				 drtsrv_01_v1_0_s_ifspec,
				 pBindingVector,   // set in previous call
				 NULL);            // UUID vector
     printf("RpcNsBindingExport returned 0x%x\n", status);
    if (status) {
        goto cleanup;
    }
    else
        fExported = 1;


    printf("Calling RpcServerListen: Case 1:\n");
    status = RpcServerListen(cMinCalls,
                             cMaxCalls,
                             fDontWait);  // wait flag
    printf("RpcServerListen returned: 0x%x\n", status);
    if (status) {
        goto cleanup;
    }

    if (fDontWait) {
        printf("Calling RpcMgmtWaitServerListen\n");
        status = RpcMgmtWaitServerListen();  //  wait operation
        printf("RpcMgmtWaitServerListen returned: 0x%x\n", status);
    }

  cleanup:

    if ( fExported )
    {
        status = RpcNsBindingUnexport(RPC_C_NS_SYNTAX_DEFAULT,  // name syntax type
                                       pszEntryName,            // nsi entry name
                                       drtsrv_01_v1_0_s_ifspec,
                                       NULL);                   // UUID vector
        printf( "RpcNsBindingUnexport returned 0x%x\n", status);
    }


    if ( fEndpoint )
    {
        status = RpcEpUnregister(drtsrv_01_v1_0_s_ifspec,
                                  pBindingVector,
                                  NULL);
        printf( "RpcEpUnregister returned 0x%x\n", status);
    }

    if ( pBindingVector )
    {
        status = RpcBindingVectorFree(&pBindingVector);
        printf( "RpcBindingVectorFree returned 0x%x\n", status);
    }

    if ( fRegistered )
    {
        status = RpcServerUnregisterIf(drtsrv_01_v1_0_s_ifspec, // interface to register
                                       NULL,   // MgrTypeUuid
                                       1);     // wait for outstanding calls
        printf( "RpcServerUnregisterIf returned 0x%x\n", status);
    }


}  // end main()



/*********************************************************************/
/*                 MIDL allocate and free                            */
/*********************************************************************/

void __RPC_FAR * __RPC_USER midl_user_allocate(size_t len)
{
    return(malloc(len));
}

void __RPC_USER midl_user_free(void __RPC_FAR * ptr)
{
    free(ptr);
}

/* end file drts.c */
