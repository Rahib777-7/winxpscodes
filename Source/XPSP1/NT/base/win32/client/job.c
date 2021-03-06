/*++

Copyright (c) 1992  Microsoft Corporation

Module Name:

    job.c

Abstract:

    Support for the Job Object

Author:

    Mark Lucovsky (markl) 12-Jun-1997

Revision History:

--*/

#include "basedll.h"
#pragma hdrstop

HANDLE
WINAPI
CreateJobObjectA(
    LPSECURITY_ATTRIBUTES lpJobAttributes,
    LPCSTR lpName
    )
{
    PUNICODE_STRING Unicode;
    ANSI_STRING AnsiString;
    NTSTATUS Status;
    LPCWSTR NameBuffer;

    NameBuffer = NULL;
    if ( ARGUMENT_PRESENT(lpName) ) {
        Unicode = &NtCurrentTeb()->StaticUnicodeString;
        RtlInitAnsiString(&AnsiString,lpName);
        Status = RtlAnsiStringToUnicodeString(Unicode,&AnsiString,FALSE);
        if ( !NT_SUCCESS(Status) ) {
            if ( Status == STATUS_BUFFER_OVERFLOW ) {
                SetLastError(ERROR_FILENAME_EXCED_RANGE);
                }
            else {
                BaseSetLastNTError(Status);
                }
            return NULL;
            }
        NameBuffer = (LPCWSTR)Unicode->Buffer;
        }

    return CreateJobObjectW(
                lpJobAttributes,
                NameBuffer
                );
}

HANDLE
WINAPI
CreateJobObjectW(
    LPSECURITY_ATTRIBUTES lpJobAttributes,
    LPCWSTR lpName
    )
{
    NTSTATUS Status;
    OBJECT_ATTRIBUTES Obja;
    POBJECT_ATTRIBUTES pObja;
    HANDLE Handle;
    UNICODE_STRING ObjectName;

    if ( ARGUMENT_PRESENT(lpName) ) {
        RtlInitUnicodeString(&ObjectName,lpName);
        pObja = BaseFormatObjectAttributes(&Obja,lpJobAttributes,&ObjectName);
        }
    else {
        pObja = BaseFormatObjectAttributes(&Obja,lpJobAttributes,NULL);
        }

    Status = NtCreateJobObject(
                &Handle,
                JOB_OBJECT_ALL_ACCESS,
                pObja
                );
    if ( NT_SUCCESS(Status) ) {
        if ( Status == STATUS_OBJECT_NAME_EXISTS ) {
            SetLastError(ERROR_ALREADY_EXISTS);
            }
        else {
            SetLastError(0);
            }
        return Handle;
        }
    else {
        BaseSetLastNTError(Status);
        return NULL;
        }
}

HANDLE
WINAPI
OpenJobObjectA(
    DWORD dwDesiredAccess,
    BOOL bInheritHandle,
    LPCSTR lpName
    )
{
    PUNICODE_STRING Unicode;
    ANSI_STRING AnsiString;
    NTSTATUS Status;

    if ( ARGUMENT_PRESENT(lpName) ) {
        Unicode = &NtCurrentTeb()->StaticUnicodeString;
        RtlInitAnsiString(&AnsiString,lpName);
        Status = RtlAnsiStringToUnicodeString(Unicode,&AnsiString,FALSE);
        if ( !NT_SUCCESS(Status) ) {
            if ( Status == STATUS_BUFFER_OVERFLOW ) {
                SetLastError(ERROR_FILENAME_EXCED_RANGE);
                }
            else {
                BaseSetLastNTError(Status);
                }
            return NULL;
            }
        }
    else {
        BaseSetLastNTError(STATUS_INVALID_PARAMETER);
        return NULL;
        }

    return OpenJobObjectW(
                dwDesiredAccess,
                bInheritHandle,
                (LPCWSTR)Unicode->Buffer
                );
}

HANDLE
WINAPI
OpenJobObjectW(
    DWORD dwDesiredAccess,
    BOOL bInheritHandle,
    LPCWSTR lpName
    )
{
    OBJECT_ATTRIBUTES Obja;
    UNICODE_STRING ObjectName;
    NTSTATUS Status;
    HANDLE Object;

    if ( !lpName ) {
        BaseSetLastNTError(STATUS_INVALID_PARAMETER);
        return NULL;
        }
    RtlInitUnicodeString(&ObjectName,lpName);

    InitializeObjectAttributes(
        &Obja,
        &ObjectName,
        (bInheritHandle ? OBJ_INHERIT : 0),
        BaseGetNamedObjectDirectory(),
        NULL
        );

    Status = NtOpenJobObject(
                &Object,
                dwDesiredAccess,
                &Obja
                );
    if ( !NT_SUCCESS(Status) ) {
        BaseSetLastNTError(Status);
        return NULL;
        }
    return Object;
}

BOOL
WINAPI
AssignProcessToJobObject(
    HANDLE hJob,
    HANDLE hProcess
    )
{
    NTSTATUS Status;
    BOOL rv;

    rv = TRUE;
    Status = NtAssignProcessToJobObject(hJob,hProcess);
    if ( !NT_SUCCESS(Status) ) {
        rv = FALSE;
        BaseSetLastNTError(Status);
        }
    return rv;
}

BOOL
WINAPI
TerminateJobObject(
    HANDLE hJob,
    UINT uExitCode
    )
{
    NTSTATUS Status;
    BOOL rv;

    rv = TRUE;
    Status = NtTerminateJobObject(hJob,uExitCode);
    if ( !NT_SUCCESS(Status) ) {
        rv = FALSE;
        BaseSetLastNTError(Status);
        }
    return rv;
}

BOOL
WINAPI
QueryInformationJobObject(
    HANDLE hJob,
    JOBOBJECTINFOCLASS JobObjectInformationClass,
    LPVOID lpJobObjectInformation,
    DWORD cbJobObjectInformationLength,
    LPDWORD lpReturnLength
    )
{
    NTSTATUS Status;
    BOOL rv;
    JOBOBJECT_EXTENDED_LIMIT_INFORMATION ExtendedLimitInfo;
    PVOID LimitInfo;

    if ( JobObjectInformationClass == JobObjectBasicLimitInformation ) {
        LimitInfo = &ExtendedLimitInfo;
        if ( cbJobObjectInformationLength != sizeof(JOBOBJECT_BASIC_LIMIT_INFORMATION) ) {
            BaseSetLastNTError(STATUS_INFO_LENGTH_MISMATCH);
            return FALSE;
            }
        }
    else if ( JobObjectInformationClass == JobObjectExtendedLimitInformation ) {
        LimitInfo = &ExtendedLimitInfo;
        if ( cbJobObjectInformationLength != sizeof(JOBOBJECT_EXTENDED_LIMIT_INFORMATION) ) {
            BaseSetLastNTError(STATUS_INFO_LENGTH_MISMATCH);
            return FALSE;
            }
        }
    else {
        LimitInfo = lpJobObjectInformation;
        }

    rv = TRUE;
    Status = NtQueryInformationJobObject(
                hJob,
                JobObjectInformationClass,
                LimitInfo,
                cbJobObjectInformationLength,
                lpReturnLength
                );
    if ( !NT_SUCCESS(Status) ) {
        rv = FALSE;
        BaseSetLastNTError(Status);
        }
    else {
        if (LimitInfo == &ExtendedLimitInfo ) {
            switch (ExtendedLimitInfo.BasicLimitInformation.PriorityClass) {
                case PROCESS_PRIORITY_CLASS_IDLE :
                    ExtendedLimitInfo.BasicLimitInformation.PriorityClass = IDLE_PRIORITY_CLASS;
                    break;
                case PROCESS_PRIORITY_CLASS_BELOW_NORMAL:
                    ExtendedLimitInfo.BasicLimitInformation.PriorityClass = BELOW_NORMAL_PRIORITY_CLASS;
                    break;
                case PROCESS_PRIORITY_CLASS_NORMAL :
                    ExtendedLimitInfo.BasicLimitInformation.PriorityClass = NORMAL_PRIORITY_CLASS;
                    break;
                case PROCESS_PRIORITY_CLASS_ABOVE_NORMAL:
                    ExtendedLimitInfo.BasicLimitInformation.PriorityClass = ABOVE_NORMAL_PRIORITY_CLASS;
                    break;
                case PROCESS_PRIORITY_CLASS_HIGH :
                    ExtendedLimitInfo.BasicLimitInformation.PriorityClass = HIGH_PRIORITY_CLASS;
                    break;
                case PROCESS_PRIORITY_CLASS_REALTIME :
                    ExtendedLimitInfo.BasicLimitInformation.PriorityClass = REALTIME_PRIORITY_CLASS;
                    break;
                default:
                    ExtendedLimitInfo.BasicLimitInformation.PriorityClass = NORMAL_PRIORITY_CLASS;

                }
            CopyMemory(lpJobObjectInformation,&ExtendedLimitInfo,cbJobObjectInformationLength);
            }
        }
    return rv;
}

BOOL
WINAPI
SetInformationJobObject(
    HANDLE hJob,
    JOBOBJECTINFOCLASS JobObjectInformationClass,
    LPVOID lpJobObjectInformation,
    DWORD cbJobObjectInformationLength
    )
{
    NTSTATUS Status;
    BOOL rv;
    JOBOBJECT_EXTENDED_LIMIT_INFORMATION ExtendedLimitInfo;
    PVOID LimitInfo;
    NTSTATUS PrivStatus = STATUS_UNSUCCESSFUL;
    PVOID State;

    rv = TRUE;
    if (JobObjectInformationClass == JobObjectBasicLimitInformation ||
        JobObjectInformationClass == JobObjectExtendedLimitInformation ) {

        if ( JobObjectInformationClass == JobObjectBasicLimitInformation ) {
            if ( cbJobObjectInformationLength != sizeof(JOBOBJECT_BASIC_LIMIT_INFORMATION) ) {
                BaseSetLastNTError(STATUS_INFO_LENGTH_MISMATCH);
                return FALSE;
            }
        } else {
            if ( cbJobObjectInformationLength != sizeof(JOBOBJECT_EXTENDED_LIMIT_INFORMATION) ) {
                BaseSetLastNTError(STATUS_INFO_LENGTH_MISMATCH);
                return FALSE;
            }
        }

        LimitInfo = &ExtendedLimitInfo;

        CopyMemory(&ExtendedLimitInfo,lpJobObjectInformation,cbJobObjectInformationLength);

        if ( ExtendedLimitInfo.BasicLimitInformation.LimitFlags & JOB_OBJECT_LIMIT_PRIORITY_CLASS ) {
            switch (ExtendedLimitInfo.BasicLimitInformation.PriorityClass) {

                case IDLE_PRIORITY_CLASS :
                    ExtendedLimitInfo.BasicLimitInformation.PriorityClass = PROCESS_PRIORITY_CLASS_IDLE;
                    break;
                case BELOW_NORMAL_PRIORITY_CLASS :
                    ExtendedLimitInfo.BasicLimitInformation.PriorityClass = PROCESS_PRIORITY_CLASS_BELOW_NORMAL;
                    break;
                case NORMAL_PRIORITY_CLASS :
                    ExtendedLimitInfo.BasicLimitInformation.PriorityClass = PROCESS_PRIORITY_CLASS_NORMAL;
                    break;
                case ABOVE_NORMAL_PRIORITY_CLASS :
                    ExtendedLimitInfo.BasicLimitInformation.PriorityClass = PROCESS_PRIORITY_CLASS_ABOVE_NORMAL;
                    break;
                case HIGH_PRIORITY_CLASS :
                    ExtendedLimitInfo.BasicLimitInformation.PriorityClass = PROCESS_PRIORITY_CLASS_HIGH;
                    break;
                case REALTIME_PRIORITY_CLASS :
                    ExtendedLimitInfo.BasicLimitInformation.PriorityClass = PROCESS_PRIORITY_CLASS_REALTIME;
                    break;
                default:
                    ExtendedLimitInfo.BasicLimitInformation.PriorityClass = PROCESS_PRIORITY_CLASS_NORMAL;

            }
        }
        if (ExtendedLimitInfo.BasicLimitInformation.LimitFlags & JOB_OBJECT_LIMIT_WORKINGSET) {
            //
            // Attempt to acquire the appropriate privilege.  If this
            // fails, it's no big deal -- we'll attempt to make the
            // NtSetInformationProcess call anyway, in case it turns out
            // to be a decrease operation (which will succeed anyway).
            //

            PrivStatus = BasepAcquirePrivilegeEx( SE_INC_BASE_PRIORITY_PRIVILEGE, &State );
        }
    } else {
        LimitInfo = lpJobObjectInformation;
    }

    Status = NtSetInformationJobObject(
                hJob,
                JobObjectInformationClass,
                LimitInfo,
                cbJobObjectInformationLength
                );

    if (NT_SUCCESS(PrivStatus)) {
        //
        // We successfully acquired the privilege above; we need to relinquish it.
        //
        ASSERT (State != NULL);
        BasepReleasePrivilege (State);
        State = NULL;
    }

    if ( !NT_SUCCESS(Status) ) {
        rv = FALSE;
        BaseSetLastNTError(Status);
    }
    return rv;
}

BOOL
WINAPI
IsProcessInJob (
    IN HANDLE ProcessHandle,
    IN HANDLE JobHandle,
    OUT PBOOL Result
    )
/*++

Routine Description:

    This routine finds out if a process is in a specific or any job

Arguments:

    ProcessHandle - Handle to process to be checked
    JobHandle     - Handle of job to check process against, May be NULL to do general query.
    Result        - TRUE if the process is part of the job FALSE otherwise.

Return Value:

    BOOL - TRUE the call was successfull, FALSE the call failed

--*/
{
    NTSTATUS Status;

    Status = NtIsProcessInJob (ProcessHandle,
                               JobHandle);
    if (!NT_SUCCESS (Status)) {
        BaseSetLastNTError (Status);
        return FALSE;
    }
    if (Status == STATUS_PROCESS_NOT_IN_JOB) {
        *Result = FALSE;
    } else {
        *Result = TRUE;
    }
    return TRUE;
}

BOOL
WINAPI
CreateJobSet (
    IN ULONG NumJob,
    IN PJOB_SET_ARRAY UserJobSet,
    IN ULONG Flags)
/*++

Routine Description:

    This function creates a job set from multiple job objects.
    
Arguments:

    NumJob     - Number of jobs in JobSet
    UserJobSet - Pointer to array of jobs to combine
    Flags      - Flags mask for future expansion

Return Value:

    BOOL - TRUE the call was successfull, FALSE the call failed

--*/
{
    NTSTATUS Status;

    Status = NtCreateJobSet (NumJob,
                             UserJobSet,
                             Flags);
    if (!NT_SUCCESS (Status)) {
        BaseSetLastNTError (Status);
        return FALSE;
    }
    return TRUE;
}