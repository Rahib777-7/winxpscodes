/*++

Copyright (c) 1997  Microsoft Corporation

Module Name:

    fsm.cxx

Abstract:

    Contains CFsm class implementation

    Contents:
        ContainingFsm
        DoFsm
        StartFsmChain
        CFsm::CFsm
        CFsm::~CFsm
        CFsm::Push
        CFsm::Pop
        CFsm::QueueWorkItem
        CFsm::RunWorkItem
        CFsm::Run
        [CFsm::MapType]
        [CFsm::StateName]

Author:

     Richard L Firth (rfirth) 11-Apr-1997

Environment:

    Win32 user-mode DLL

Revision History:

    11-Apr-1997 rfirth
        Created

--*/

#include <wininetp.h>
#include <perfdiag.hxx>

#ifdef USE_DINARES_FSM_ALLOC_CACHE

CCritSec                FsmAllocCritSec;
void *                  FsmAllocList;
size_t                  FsmAllocSize;

#endif

#if INET_DEBUG

struct { int size; char* name; } class_sizes[] = {
    sizeof(CFsm), "CFsm",
    sizeof(CFsm_ResolveHost), "CFsm_ResolveHost",
    sizeof(CFsm_InternetParseUrl), "CFsm_InternetParseUrl",
    sizeof(CFsm_InternetQueryDataAvailable), "CFsm_InternetQueryDataAvailable",
    sizeof(CFsm_InternetWriteFile), "CFsm_InternetWriteFile",
    sizeof(CFsm_InternetReadFile), "CFsm_InternetReadFile",
    sizeof(CFsm_SocketConnect), "CFsm_SocketConnect",
    sizeof(CFsm_SocketSend), "CFsm_SocketSend",
    sizeof(CFsm_SocketReceive), "CFsm_SocketReceive",
    //sizeof(CFsm_SocketDataAvailable), "CFsm_SocketDataAvailable",
    sizeof(CFsm_SecureConnect), "CFsm_SecureConnect",
    sizeof(CFsm_SecureHandshake), "CFsm_SecureHandshake",
    sizeof(CFsm_SecureNegotiate), "CFsm_SecureNegotiate",
    sizeof(CFsm_NegotiateLoop), "CFsm_NegotiateLoop",
    sizeof(CFsm_SecureSend), "CFsm_SecureSend",
    sizeof(CFsm_SecureReceive), "CFsm_SecureReceive",
    sizeof(CFsm_GetConnection), "CFsm_GetConnection",
    sizeof(CFsm_HttpSendRequest), "CFsm_HttpSendRequest",
    sizeof(CFsm_MakeConnection), "CFsm_MakeConnection",
    sizeof(CFsm_OpenConnection), "CFsm_OpenConnection",
    sizeof(CFsm_OpenProxyTunnel), "CFsm_OpenProxyTunnel",
    sizeof(CFsm_SendRequest), "CFsm_SendRequest",
    sizeof(CFsm_ReceiveResponse), "CFsm_ReceiveResponse",
    sizeof(CFsm_HttpReadData), "CFsm_HttpReadData",
    sizeof(CFsm_HttpWriteData), "CFsm_HttpWriteData",
    sizeof(CFsm_ReadData), "CFsm_ReadData",
    sizeof(CFsm_HttpQueryAvailable), "CFsm_HttpQueryAvailable",
    sizeof(CFsm_DrainResponse), "CFsm_DrainResponse",
    sizeof(CFsm_Redirect), "CFsm_Redirect",
    sizeof(CFsm_ReadLoop), "CFsm_ReadLoop",
    sizeof(CFsm_ParseHttpUrl), "CFsm_ParseHttpUrl",
    sizeof(CFsm_OpenUrl), "CFsm_OpenUrl",
    sizeof(CFsm_ParseUrlForHttp), "CFsm_ParseUrlForHttp",
    sizeof(CFsm_ReadFile), "CFsm_ReadFile",
    sizeof(CFsm_ReadFileEx), "CFsm_ReadFileEx",
    //sizeof(CFsm_WriteFile), "CFsm_WriteFile",
    sizeof(CFsm_BackgroundTask), "CFsm_BackgroundTask",
    sizeof(CFsm_QueryAvailable), "CFsm_QueryAvailable"
};

void dump_class_sizes() {
    for (int i = 0; i < ARRAY_ELEMENTS(class_sizes); ++i) {
        DEBUG_PRINT(ASYNC,INFO,("%s = %d\n", class_sizes[i].name, class_sizes[i].size));
    }
}

#endif

//
// functions
//

//
// This is Dinarte's experiement for reducing Mem alloc on
//  creating FSMs.
//

#ifdef USE_DINARES_FSM_ALLOC_CACHE


VOID
FsmInitialize(
    VOID
    )

/*++

Routine Description:

    Performs initialization required by functions in this module

Arguments:

    None.

Return Value:

    DWORD
        Success - ERROR_SUCCESS

        Failure - return code from LocalAlloc

--*/

{
    DEBUG_ENTER((DBG_ASYNC,
                None,
                "FsmInitialize",
                NULL
                ));

    FsmAllocCritSec.Init();

    FsmAllocSize = sizeof(CFsm);
    if (FsmAllocSize < sizeof(CFsm_ResolveHost))
        FsmAllocSize = sizeof(CFsm_ResolveHost);
    if (FsmAllocSize < sizeof(CFsm_SocketConnect))
        FsmAllocSize = sizeof(CFsm_SocketConnect);
    if (FsmAllocSize < sizeof(CFsm_SocketSend))
        FsmAllocSize = sizeof(CFsm_SocketSend);
    if (FsmAllocSize < sizeof(CFsm_SocketReceive))
        FsmAllocSize = sizeof(CFsm_SocketReceive);
    if (FsmAllocSize < sizeof(CFsm_SecureConnect))
        FsmAllocSize = sizeof(CFsm_SecureConnect);
    if (FsmAllocSize < sizeof(CFsm_SecureHandshake))
        FsmAllocSize = sizeof(CFsm_SecureHandshake);
    if (FsmAllocSize < sizeof(CFsm_SecureNegotiate))
        FsmAllocSize = sizeof(CFsm_SecureNegotiate);
    if (FsmAllocSize < sizeof(CFsm_NegotiateLoop))
        FsmAllocSize = sizeof(CFsm_NegotiateLoop);
    if (FsmAllocSize < sizeof(CFsm_SecureSend))
        FsmAllocSize = sizeof(CFsm_SecureSend);
    if (FsmAllocSize < sizeof(CFsm_SecureReceive))
        FsmAllocSize = sizeof(CFsm_SecureReceive);
    if (FsmAllocSize < sizeof(CFsm_GetConnection))
        FsmAllocSize = sizeof(CFsm_GetConnection);
    if (FsmAllocSize < sizeof(CFsm_HttpSendRequest))
        FsmAllocSize = sizeof(CFsm_HttpSendRequest);
    if (FsmAllocSize < sizeof(CFsm_MakeConnection))
        FsmAllocSize = sizeof(CFsm_MakeConnection);
    if (FsmAllocSize < sizeof(CFsm_OpenConnection))
        FsmAllocSize = sizeof(CFsm_OpenConnection);
    if (FsmAllocSize < sizeof(CFsm_OpenProxyTunnel))
        FsmAllocSize = sizeof(CFsm_OpenProxyTunnel);
    if (FsmAllocSize < sizeof(CFsm_SendRequest))
        FsmAllocSize = sizeof(CFsm_SendRequest);
    if (FsmAllocSize < sizeof(CFsm_ReceiveResponse))
        FsmAllocSize = sizeof(CFsm_ReceiveResponse);
    if (FsmAllocSize < sizeof(CFsm_HttpReadData))
        FsmAllocSize = sizeof(CFsm_HttpReadData);
    if (FsmAllocSize < sizeof(CFsm_HttpWriteData))
        FsmAllocSize = sizeof(CFsm_HttpWriteData);
    if (FsmAllocSize < sizeof(CFsm_ReadData))
        FsmAllocSize = sizeof(CFsm_ReadData);
    if (FsmAllocSize < sizeof(CFsm_HttpQueryAvailable))
        FsmAllocSize = sizeof(CFsm_HttpQueryAvailable);
    if (FsmAllocSize < sizeof(CFsm_DrainResponse))
        FsmAllocSize = sizeof(CFsm_DrainResponse);
    if (FsmAllocSize < sizeof(CFsm_Redirect))
        FsmAllocSize = sizeof(CFsm_Redirect);
    if (FsmAllocSize < sizeof(CFsm_ReadLoop))
        FsmAllocSize = sizeof(CFsm_ReadLoop);
    if (FsmAllocSize < sizeof(CFsm_ParseHttpUrl))
        FsmAllocSize = sizeof(CFsm_ParseHttpUrl);
    if (FsmAllocSize < sizeof(CFsm_OpenUrl))
        FsmAllocSize = sizeof(CFsm_OpenUrl);
    if (FsmAllocSize < sizeof(CFsm_ParseUrlForHttp))
        FsmAllocSize = sizeof(CFsm_ParseUrlForHttp);
    if (FsmAllocSize < sizeof(CFsm_ReadFile))
        FsmAllocSize = sizeof(CFsm_ReadFile);
    if (FsmAllocSize < sizeof(CFsm_ReadFileEx))
        FsmAllocSize = sizeof(CFsm_ReadFileEx);
    if (FsmAllocSize < sizeof(CFsm_QueryAvailable))
        FsmAllocSize = sizeof(CFsm_QueryAvailable);

    //
    // Pre-allocate a pool of state-machines for locality of reference
    //

    for (int cPreAlloc = 8192 / FsmAllocSize; cPreAlloc > 0; --cPreAlloc)
    {
        void * pFsm = (void *)ALLOCATE_FIXED_MEMORY(FsmAllocSize);

        if (pFsm == NULL)
            break;

        *(void **)pFsm = FsmAllocList;
        FsmAllocList = pFsm;
    }
}


VOID
FsmTerminate(
    VOID
    )

/*++

Routine Description:

    Obverse of FsmInitialize - frees any system resources allocated by
    FsmInitialize

Arguments:

    None.

Return Value:

    None.

--*/

{
    DEBUG_ENTER((DBG_ASYNC,
                None,
                "FsmTerminate",
                NULL
                ));

    //
    // there shouldn't be any other threads active when this function is called
    // but we'll grab the critical section anyway, just to make sure
    //

    if (FsmAllocCritSec.Lock())
    {

        while (FsmAllocList)
        {
            void * pFsm = FsmAllocList;
            FsmAllocList = *(void **)pFsm;
            FREE_MEMORY((HLOCAL)pFsm);
        }

        FsmAllocCritSec.Unlock();
    }

    //
    // delete the critical section
    //

    FsmAllocCritSec.FreeLock();

    DEBUG_LEAVE(0);
}

#endif


CFsm *
ContainingFsm(
    IN LPVOID lpAddress
    )

/*++

Routine Description:

    Returns address of start of CFsm object, including vtable

Arguments:

    lpAddress   - pointer to list inside CFsm object

Return Value:

    CFsm *  - pointer to start of object

--*/

{
    return CONTAINING_RECORD(lpAddress, CFsm, m_ListEntry);
}


//DWORD
//RunAll(
//    VOID
//    )
//{
//    DWORD error;
//    LPINTERNET_THREAD_INFO lpThreadInfo = InternetGetThreadInfo();
//
//    if (lpThreadInfo != NULL) {
//        while (lpThreadInfo->Fsm != NULL) {
//            lpThreadInfo->Fsm->Run();
//        }
//    } else {
//        error = ERROR_WINHTTP_INTERNAL_ERROR;
//    }
//    return error;
//}


DWORD
DoFsm(
    IN CFsm * pFsm
    )

/*++

Routine Description:

    Common FSM run processing

Arguments:

    pFsm    - FSM to run (maybe NULL if new failed)

Return Value:

    DWORD   - return code from running FSM

--*/

{
    DEBUG_ENTER((DBG_ASYNC,
                 Dword,
                 "DoFsm",
                 "%#x (%s)",
                 pFsm,
                 pFsm->MapType()
                 ));

    DWORD error;
    BOOL bDeleteFsm = TRUE;
    LPINTERNET_THREAD_INFO lpThreadInfo = InternetGetThreadInfo();

    //informational INET_ASSERT(lpThreadInfo != NULL);

    if (lpThreadInfo != NULL)
    {
        if (pFsm != NULL)
        {
            error = pFsm->GetError();
            if (error == ERROR_SUCCESS) 
            {
                bDeleteFsm = FALSE;
                error = pFsm->Run(lpThreadInfo);
            }
            else 
            {
                INET_ASSERT(FALSE);
            }
        }
        else
        {
            error = ERROR_NOT_ENOUGH_MEMORY;
        }
    }
    else
    {
        error = ERROR_WINHTTP_INTERNAL_ERROR;
    }

    if (bDeleteFsm && pFsm)
    {
        delete pFsm;
    }
    
    DEBUG_LEAVE(error);
    return error;
}


DWORD
StartFsmChain(
    IN CFsm * pFsm,
    IN HTTP_REQUEST_HANDLE_OBJECT *pRequest,
    IN BOOL bQueue, /* = FALSE */
    IN BOOL bAsync  /* = TRUE  */
    )

/*++

Routine Description:

    Common FSM run processing for requests which
    are starting new fsm chains.  This pathway also ensures
    that no other FSM chain has already been initiated on
    the request handle.

Arguments:

    pFsm     - FSM to run (maybe NULL if new failed)

    pRequest - When not NULL, the FSM will be checked and placed
               into a blocked queue if an async work item on the
               request item is already in progress.  It's assumed
               this is only called for async request objects.

    bQueue   - When TRUE and bAsync is also TRUE, the FSM is
               queued to run in a worker thread.  If either are
               FALSE, the FSM chain is started on this thread.

    bAsync   - Indicates whether API that initiated this FSM
               chain is asynchronous.

Return Value:

    DWORD   - return code from running FSM

--*/

{
    DEBUG_ENTER((DBG_ASYNC,
                 Dword,
                 "StartFsmChain",
                 "%#x (%s) %B",
                 pFsm,
                 pFsm->MapType(),
                 bQueue,
                 bAsync
                 ));

    DWORD error;
    BOOL bDeleteFsm = TRUE;
    LPINTERNET_THREAD_INFO lpThreadInfo = InternetGetThreadInfo();

    //informational INET_ASSERT(lpThreadInfo != NULL);

    if (lpThreadInfo != NULL)
    {
        if (pFsm != NULL)
        {
            error = pFsm->GetError();
            if (error == ERROR_SUCCESS)
            {
                DWORD dwStatus = 0;
                LPVOID lpvStatusInformation = NULL;
                DWORD dwStatusInformationLength = 0; 
                WINHTTP_ASYNC_RESULT asyncResult;
                DWORD dwFailureAPI = (DWORD)-1;

                if (pRequest)
                {
                    if (pRequest->SetWorkItemInProgressAtomic(TRUE))
                    {
                        //bad time to call async api, 
                        //wait for completion.
                        error = ERROR_INVALID_OPERATION;
                    }
                    else
                    {
                        if (bAsync)
                        {
                            if (bQueue)
                            {
                                error = pFsm->QueueWorkItem();
                                if (error == ERROR_IO_PENDING)
                                {
                                    //this is the ONLY success case from QWI.
                                    bDeleteFsm = FALSE;
                                }
                            }
                            else
                            {
                                bDeleteFsm = FALSE;
                                error = pFsm->Run(lpThreadInfo, &dwStatus, &lpvStatusInformation, 
                                                &dwStatusInformationLength, &asyncResult, &dwFailureAPI);
                            }

                            if (error != ERROR_IO_PENDING)
                            {
                                pRequest->SetWorkItemInProgressAtomic(FALSE);
                            }
                        }
                        else
                        {
                            bDeleteFsm = FALSE;
                            error = pFsm->Run(lpThreadInfo);
                            pRequest->SetWorkItemInProgressAtomic(FALSE);
                        }
                    }
                }
                else
                {
                    if (bAsync)
                    {
                        INET_ASSERT (FALSE);

                        error = pFsm->Run(lpThreadInfo, &dwStatus, &lpvStatusInformation, 
                                        &dwStatusInformationLength, &asyncResult, &dwFailureAPI);
                    }
                    else
                    {
                        error = pFsm->Run(lpThreadInfo);
                    }
                    bDeleteFsm = FALSE;
                }
            }
            else
            {
                INET_ASSERT(FALSE);
            }
        }
        else
        {
            error = ERROR_NOT_ENOUGH_MEMORY;
        }
    }
    else
    {
        error = ERROR_WINHTTP_INTERNAL_ERROR;
    }

    if (bDeleteFsm && pFsm)
    {
        delete pFsm;
    }
    
    DEBUG_LEAVE(error);

    return error;
}


//
// methods
//


//
// This is Dinarte's experiement for reducing Mem alloc on
//  creating FSMs. Not used right now.
//

#ifdef USE_DINARES_FSM_ALLOC_CACHE


void *
CFsm::operator new(
    IN size_t Size
    )

/*++

Routine Description:

    Allocates memory for the new state-machine from a special memory pool.

Arguments:

    Size        - size of the state-machine

Return Value:

    None.

--*/

{
    VOID * pFsm = NULL;

    if (FsmAllocCritSec.Lock())
    {
        // Only alloc from the list if we can synchronize access to it.

        pFsm = FsmAllocList;

        if (pFsm)
        {
            FsmAllocList = *(void **)pFsm;
        }

        FsmAllocCritSec.Unlock();
    }

    if (pFsm == NULL)
    {
        INET_ASSERT(Size <= FsmAllocSize);

        pFsm = (void *)ALLOCATE_FIXED_MEMORY(FsmAllocSize);
    }

    return(pFsm);
}


VOID
CFsm::operator delete(
    IN VOID * pFsm
    )

/*++

Routine Description:

    Deallocates memory for the state-machine by adding it to a special
    memory pool.

Arguments:

    pFsm        - pointer to the state-machine

Return Value:

    None.

--*/

{
    if (pFsm)
    {
        if (FsmAllocCritSec.Lock())
        {
            *(void **)pFsm = FsmAllocList;
            FsmAllocList = pFsm;

            FsmAllocCritSec.Unlock();
        }
        // else leak?
    }
}
#endif


CFsm::CFsm(
    IN DWORD (* lpfnHandler)(CFsm *),
    IN LPVOID lpvContext
    ) : CPriorityListEntry(0)

/*++

Routine Description:

    CFsm constructor. This gets called many times since its the base of all the
    derived FSMs

Arguments:

    lpfnHandler - state-machine handler

    lpvContext  - callee context

Return Value:

    None.

--*/

{
#if INET_DEBUG
    static bool b = TRUE;
    if (b) {
        dump_class_sizes();
        b=FALSE;
    }
#endif

    DEBUG_ENTER((DBG_OBJECTS,
                 None,
                 "CFsm::CFsm",
                 "{%#x}",
                 this
                 ));

    INIT_FSM();

    m_lpThreadInfo = InternetGetThreadInfo();
    if (m_lpThreadInfo == NULL) {

        //informational INET_ASSERT(m_lpThreadInfo != NULL);

        SetError(ERROR_WINHTTP_INTERNAL_ERROR);

        DEBUG_LEAVE(0);

        return;
    }
    m_hObject = m_lpThreadInfo->hObject;
    m_hObjectMapped = (INTERNET_HANDLE_OBJECT *)m_lpThreadInfo->hObjectMapped;
    m_dwContext = m_hObjectMapped->GetContext();
    m_dwMappedErrorCode = m_lpThreadInfo->dwMappedErrorCode;
    m_State = FSM_STATE_INIT;
    m_NextState = FSM_STATE_CONTINUE;
    m_FunctionState = FSM_STATE_BAD;
    m_lpfnHandler = lpfnHandler;
    m_lpvContext = lpvContext;
    SetError(ERROR_SUCCESS);
    m_bPop = TRUE;
    Push();
    m_Hint = FSM_HINT_SLOW;
    m_Socket = INVALID_SOCKET;
    m_Action = FSM_ACTION_NONE;
    m_dwBlockId = 0;
    m_dwTimeout = INFINITE;
    m_fTimeoutWraps = FALSE;
    m_dwTimer = 0;
    m_bTimerStarted = FALSE;
    m_bIsBlockingFsm = FALSE;
    m_bIsApi = FALSE;
    m_ApiType = ApiType_None;
    m_dwApiData = 0;
    m_ApiResult.Handle = NULL;
    m_bHasTimeout = FALSE;
#ifdef USE_OLD_SENDRECV_SYNC
    m_bOnAsyncList = FALSE;
#endif
    DEBUG_LEAVE(0);
}


CFsm::~CFsm()

/*++

Routine Description:

    CFsm desctructor

Arguments:

    None.

Return Value:

    None.

--*/

{
    DEBUG_ENTER((DBG_OBJECTS,
                 None,
                 "CFsm::~CFsm",
                 "{%#x}",
                 this
                 ));

    CHECK_FSM();

    if (m_bPop)
    {
        CHECK_OWNED();
        Pop();    
    }
    
#ifdef STRESS_BUG_DEBUG
    m_Link = (CFsm *) (DWORD_PTR) 0xFEFEFEFE;
    m_dwError = 0xFEFEFEFE;
    m_lpThreadInfo = (LPINTERNET_THREAD_INFO) (DWORD_PTR) 0xFEFEFEFE;
    m_dwContext = 0xFEFEFEFE;
    m_hObject = (HINTERNET)(DWORD_PTR) 0xFEFEFEFE;
#endif

    DEBUG_LEAVE(0);
}


VOID
CFsm::Push(
    VOID
    )

/*++

Routine Description:

    Adds this FSM to the head of the queue

Arguments:

    None.

Return Value:

    None.

--*/

{
    DEBUG_ENTER((DBG_ASYNC,
                 None,
                 "CFsm::Push",
                 "{%#x (%s:%s)}",
                 this,
                 MapState(),
                 MapFunctionState()
                 ));

    CHECK_FSM();
    CHECK_UNOWNED();
    INET_ASSERT(m_lpThreadInfo != NULL);
    CHECK_INTERNET_THREAD_INFO(m_lpThreadInfo);

    m_Link = m_lpThreadInfo->Fsm;
    m_lpThreadInfo->Fsm = this;

    CHECK_FSM_OWNED(m_Link);
    RESET_FSM_OWNED(m_Link);

    DEBUG_PRINT(ASYNC,
                INFO,
                ("!!! FSM %#x unowned\n", m_Link
                ));

    SET_OWNED();

    DEBUG_PRINT(ASYNC,
                INFO,
                ("!!! FSM %#x owned by %#x\n",
                this,
                GetCurrentThreadId()
                ));

    DEBUG_LEAVE(0);
}


VOID
Pop(
    CFsm * pNextFsm,
    INTERNET_THREAD_INFO * lpThreadInfo,
    DWORD dwError
    )

/*++

Routine Description:

    Puts the next FSM (if any) at the head of the queue

Arguments:

    None.

Return Value:

    None.

--*/

{
    DEBUG_ENTER((DBG_ASYNC,
                 None,
                 "Pop",
                 "%#x",
                 pNextFsm
                 ));

    INET_ASSERT(lpThreadInfo != NULL);
    
    CHECK_INTERNET_THREAD_INFO(lpThreadInfo);
    CHECK_FSM_UNOWNED(pNextFsm);

    lpThreadInfo->Fsm = pNextFsm;

    SET_FSM_OWNED(pNextFsm);

    DEBUG_PRINT(ASYNC,
                INFO,
                ("!!! FSM %#x owned by %#x\n",
                pNextFsm,
                GetCurrentThreadId()
                ));

    if (pNextFsm != NULL) 
    {
        pNextFsm->SetState(pNextFsm->GetNextState());
        pNextFsm->SetError(dwError);

        DEBUG_PRINT(ASYNC,
                    INFO,
                    ("next FSM %#x (%s), state %s, function-state %s\n",
                    pNextFsm,
                    pNextFsm->MapType(),
                    pNextFsm->MapState(),
                    pNextFsm->MapFunctionState()
                    ));
    }
    else
    {
        DEBUG_PRINT(ASYNC,
                    INFO,
                    ("last FSM\n"
                    ));
    }

    DEBUG_LEAVE(0);
}


VOID
CFsm::Pop(
    VOID
    )

/*++

Routine Description:

    Puts the next FSM (if any) at the head of the queue

Arguments:

    None.

Return Value:

    None.

--*/

{
    DEBUG_ENTER((DBG_ASYNC,
                 None,
                 "CFsm::Pop",
                 "{%#x (%s:%s)}",
                 this,
                 MapState(),
                 MapFunctionState()
                 ));

    INET_ASSERT(m_lpThreadInfo != NULL);
    CHECK_FSM();
    CHECK_OWNED();

    ::Pop(m_Link, m_lpThreadInfo, GetError());

    DEBUG_LEAVE(0);
}


DWORD
CFsm::QueueWorkItem(
    DWORD dwCompletionBytes,
    LPVOID lpCompletionKey 
    )

/*++

Routine Description:

    Queues this FSM to worker thread for processing. Worker thread callback is
    CFsm::RunWorkItem

Arguments:

    None.

Return Value:

    DWORD
        Success - ERROR_SUCCESS

        Failure - return code from SHQueueUserWorkItem

--*/

{
    DEBUG_ENTER((DBG_ASYNC,
                 Dword,
                 "CFsm::QueueWorkItem",
                 "{%#x [%s, socket %#x, block id %#x, timeout %#x, error %d, state %s:%s]}",
                 this,
                 MapType(),
                 GetSocket(),
                 GetBlockId(),
                 GetTimeout(),
                 GetError(),
                 MapState(),
                 MapFunctionState()
                 ));

    DWORD error = ERROR_IO_PENDING;

    RESET_OWNED();
    
    DEBUG_PRINT(SOCKETS,
                INFO,
                ("Posting IO completion with 0x%x\n",
                this
                ));

    DEBUG_PRINT(SOCKETS,
                     INFO,
                     ("***PostQueuedCompletionStatus: "
                     "(hComp)%#x, (# bytes)%#x, (completionkey)%#x, (overlapped)%#x",
                     g_hCompletionPort,
                     dwCompletionBytes ? dwCompletionBytes : COMPLETION_BYTES_CUSTOM,
                     lpCompletionKey ? ULONG_PTR (lpCompletionKey) : ULONG_PTR (this),
                     g_lpCustomOverlapped
                     ));

    if (PostQueuedCompletionStatus(g_hCompletionPort,
                                    dwCompletionBytes ? dwCompletionBytes : COMPLETION_BYTES_CUSTOM,
                                    lpCompletionKey ? ULONG_PTR (lpCompletionKey) : ULONG_PTR (this),
                                    g_lpCustomOverlapped
                                    ))
    {
        DEBUG_PRINT(SOCKETS,
                         INFO,
                         ("***PostQueuedCompletionStatus: "
                         "returned TRUE"
                         ));
#if INET_DEBUG
        InterlockedIncrement(&g_cCustomCompletions);
    
        DEBUG_PRINT(SOCKETS,
                    INFO,
                    ("!!!g_cCustomCompletions = 0x%x\n",
                    g_cCustomCompletions
                    ));
#endif
        LPINTERNET_THREAD_INFO lpThreadInfo = InternetGetThreadInfo();

        //informational INET_ASSERT(lpThreadInfo != NULL);

        if (lpThreadInfo != NULL)
            lpThreadInfo->Fsm = NULL;
    }
    else
    {
        DEBUG_PRINT(SOCKETS,
                         INFO,
                         ("***PostQueuedCompletionStatus: "
                         "returned FALSE"
                         ));
        
        error = GetLastError();
        INET_ASSERT (error != ERROR_SUCCESS);
    }

    //informational INET_ASSERT(error == ERROR_IO_PENDING);

    DEBUG_LEAVE(error);
    return error;
}


DWORD
CFsm::RunWorkItem(
    IN CFsm * pFsm
    )

/*++

Routine Description:

    Run the current work item to the next block state or completion. This
    (class static) function is called in the context of a system thread pool
    callback function

Arguments:

    pFsm    - pointer to FSM to run

Return Value:

    DWORD
        Success - ERROR_SUCCESS

        Failure - ERROR_WINHTTP_INTERNAL_ERROR

--*/

{
    LPINTERNET_THREAD_INFO lpThreadInfo = InternetGetThreadInfo();

    //informational INET_ASSERT(lpThreadInfo != NULL);

    if (lpThreadInfo == NULL) {

        //informational INET_ASSERT(FALSE);

        return ERROR_WINHTTP_INTERNAL_ERROR;
    }

    lpThreadInfo->IsAsyncWorkerThread = TRUE;

    DEBUG_ENTER((DBG_ASYNC,
                 Dword,
                 "RunWorkItem",
                 "%#x",
                 pFsm
                 ));

    PERF_ENTER(Worker);

    DWORD error;

    DEBUG_PRINT(ASYNC,
                INFO,
                ("%s Fsm %#x: socket %#x, block id %#x, timeout %#x, error %d\n",
                pFsm->MapType(),
                pFsm,
                pFsm->GetSocket(),
                pFsm->GetBlockId(),
                pFsm->GetTimeout(),
                pFsm->GetError()
                ));

    INTERNET_HANDLE_BASE *pSession = (INTERNET_HANDLE_BASE *)(pFsm->GetMappedHandleObject());
    HANDLE ThreadToken = pSession->GetThreadToken();
    HANDLE ThreadHandle = GetCurrentThread();
    
    if (ThreadToken)
    {
        if (::SetThreadToken(&ThreadHandle,
                         &ThreadToken) == FALSE)
        {
            ThreadToken = 0;
        }

    }

    while (TRUE)
    {
        INET_ASSERT(pFsm != NULL);

        BOOL bIsApi = pFsm->IsApi();
        API_TYPE apiType = pFsm->GetApiType();

        lpThreadInfo->Fsm = pFsm;

        SET_FSM_OWNED(pFsm);

        DWORD dwStatus = 0;
        LPVOID lpvStatusInformation = NULL;
        DWORD dwStatusInformationLength = 0; 
        WINHTTP_ASYNC_RESULT asyncResult;
        DWORD dwFailureAPI = (DWORD)-1;
        DWORD dwResultValue;

        if (pFsm->IsInvalid())
        {
            pFsm->SetErrorState(ERROR_WINHTTP_OPERATION_CANCELLED);
            pFsm->Run(lpThreadInfo, &dwStatus, &lpvStatusInformation, 
                    &dwStatusInformationLength, &asyncResult, &dwFailureAPI);
            error = ERROR_WINHTTP_OPERATION_CANCELLED;
        }
        else
        {
            error = pFsm->Run(lpThreadInfo, &dwStatus, &lpvStatusInformation, 
                    &dwStatusInformationLength, &asyncResult, &dwFailureAPI);
        }
        
        if (error == ERROR_IO_PENDING) 
        {
            break;
        }
        
        pFsm = lpThreadInfo->Fsm;
        
        if (pFsm == NULL) 
        {
            if (bIsApi
            && ((INTERNET_HANDLE_BASE *)lpThreadInfo->hObjectMapped)->IsAsyncHandle()) 
            {
                DEBUG_PRINT(ASYNC,
                            INFO,
                            ("dwStatus = %d [%#x], lpvStatusInformation=%#x, dwStatusInformationLength = %d [%#x],"
                            "apiType = %s, error = %d\n",
                            dwStatus, dwStatus,
                            lpvStatusInformation, 
                            dwStatusInformationLength, dwStatusInformationLength,
                            (apiType==ApiType_Handle)?"HANDLE":"BOOL",
                            error));

                UNREFERENCED_PARAMETER(apiType);
                INET_ASSERT((apiType == ApiType_Handle)
                            || (apiType == ApiType_Bool));

                SetLastError(error);

                if(error != ERROR_SUCCESS)
                {
                    dwStatus = WINHTTP_CALLBACK_STATUS_REQUEST_ERROR;
                    asyncResult.dwResult = dwFailureAPI;
                    // asyncResult.dwError contains the error code as appropriate.
                    DEBUG_PRINT(ASYNC,
                                INFO,
                                ("WINHTTP_CALLBACK_STATUS_REQUEST_ERROR: Error Function=%s\n",
                                InternetMapRequestError(dwFailureAPI)
                                ));
                }
                else if (lpvStatusInformation)
                {
                    if ((dwStatus == WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE)
                        // || (dwStatus == WINHTTP_CALLBACK_STATUS_READ_COMPLETE)   // bug 505983
                        || (dwStatus == WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE))    // bug 496469
                    {
                        dwResultValue = asyncResult.dwError;
                        lpvStatusInformation = (LPVOID)&dwResultValue;
                        dwStatusInformationLength = sizeof (DWORD);
                    }
                }
                
                if (((INTERNET_HANDLE_BASE *)lpThreadInfo->hObjectMapped)->GetHandleType() == TypeHttpRequestHandle)
                {
                    ((HTTP_REQUEST_HANDLE_OBJECT *)lpThreadInfo->hObjectMapped)->SetWorkItemInProgressAtomic(FALSE);
                }

                InternetIndicateStatus(dwStatus,
                                       lpvStatusInformation,
                                       dwStatusInformationLength
                                       );

                //INET_ASSERT(((INTERNET_HANDLE_OBJECT *)lpThreadInfo->hObjectMapped)
                //            ->GetObjectType() == TypeHttpRequestHandle);

                DereferenceObject((LPVOID)lpThreadInfo->hObjectMapped);
            }
            break;
        }
        else if (bIsApi)
        {
            //
            // completing an async API that is not the last in the chain.
            // Typically, HttpSendRequest() within InternetOpenUrl()
            //

            DereferenceObject((LPVOID)lpThreadInfo->hObjectMapped);
        }
    }

    if (ThreadToken)
    {
        RevertToSelf();
    }
    
    // Must stay marked as being on an async worker thread until after
    // releasing the reference in order to prevent confusion in the async count.
    lpThreadInfo->IsAsyncWorkerThread = FALSE;

    PERF_LEAVE(Worker);

    DEBUG_LEAVE(error);

    return error;
}


DWORD
CFsm::Run(
    IN LPINTERNET_THREAD_INFO lpThreadInfo,
    OUT DWORD *pdwStatus OPTIONAL, 
    OUT LPVOID *ppvStatusInformation OPTIONAL, 
    OUT DWORD *pdwStatusInformationLength OPTIONAL, 
    OUT WINHTTP_ASYNC_RESULT *pAsyncResult OPTIONAL, 
    OUT DWORD *pdwFailureAPI OPTIONAL
    )

/*++

Routine Description:

    Runs the state handler for this FSM

Arguments:

    lpThreadInfo    - INTERNET_THREAD_INFO for this thread

    lpdwApiResult   - where optional API result is written

    lpdwApiData     - where optional API data iswritten

Return Value:

    DWORD   - return code from state handler

--*/

{

    DEBUG_ENTER((DBG_ASYNC,
                 Dword,
                 "CFsm::Run",
                 "%#x, %#x [%#x], %#x [%#x], %#x [%#x], %#x, %#x [%#x]",
                 lpThreadInfo,
                 pdwStatus,
                 (pdwStatus?*pdwStatus:NULL),
                 ppvStatusInformation,
                 (ppvStatusInformation?*ppvStatusInformation:NULL),
                 pdwStatusInformationLength,
                 (pdwStatusInformationLength?*pdwStatusInformationLength:NULL),
                 pAsyncResult,
                 pdwFailureAPI,
                 (pdwFailureAPI?*pdwFailureAPI:NULL)
                 ));

    CHECK_FSM();
    CHECK_OWNED();
    INET_ASSERT(lpThreadInfo != NULL);
    INET_ASSERT(lpThreadInfo->Fsm != NULL);

    DWORD error = ERROR_SUCCESS;

    _InternetSetObjectHandle(lpThreadInfo, m_hObject, m_hObjectMapped);

    m_lpThreadInfo = lpThreadInfo;

    while (TRUE) {

        DEBUG_PRINT(ASYNC,
                    INFO,
                    ("%s Fsm %#x state %s (%d) function-state %s (%d) error %s (%d)\n",
                    MapType(),
                    this,
                    MapState(),
                    GetState(),
                    MapFunctionState(),
                    GetFunctionState(),
                    InternetMapError(GetError()),
                    GetError()
                    ));

        error = (*m_lpfnHandler)(this);

        if (error == ERROR_IO_PENDING) {
            break;
        }
        
        SetError(error);
        SetMappedError(lpThreadInfo->dwMappedErrorCode);
        if (IsDone()) {

            DEBUG_PRINT(ASYNC,
                        INFO,
                        ("%s Fsm %#x done, next is %s %#x\n",
                        MapType(),
                        this,
                        m_Link ? m_Link->MapType() : "",
                        m_Link
                        ));

            if (pdwStatus)
            {
                // Populate these values in preparation for InternetIndicateStatus if needed:
                if (GetStatusValues(pdwStatus, ppvStatusInformation, 
                    pdwStatusInformationLength, pAsyncResult, pdwFailureAPI))
                {
                    INET_ASSERT(*pdwStatus);
                }
            }

            DEBUG_PRINT(ASYNC,
                        INFO,
                        ("Fsm %#x finished with GetApiResult() = %#x, GetApiData() = %#x\n",
                        this,
                        GetApiResult(),
                        GetApiData()
                        ));

#ifdef USE_OLD_SENDRECV_SYNC
            INET_ASSERT (!IsOnAsyncList());
#endif
            CFsm* pNext;
            DWORD dwError;
            
            if ((pNext = Dereference(&dwError)) != NULL)
                ::Pop(pNext, lpThreadInfo, dwError);

            break;
        }
        SetState(GetNextState());
    }

    DEBUG_LEAVE(error);

    return error;
}

#if INET_DEBUG

#if !defined(CASE_OF)
#define CASE_OF(x) case x: return #x
#endif

DEBUG_FUNCTION
LPSTR
CFsm::MapType(
    VOID
    ) {
    switch (m_Type) {
    case FSM_TYPE_NONE:                     return "NONE";
    case FSM_TYPE_WAIT_FOR_COMPLETION:      return "WAIT_FOR_COMPLETION";
    case FSM_TYPE_RESOLVE_HOST:             return "RESOLVE_HOST";
    case FSM_TYPE_SOCKET_CONNECT:           return "SOCKET_CONNECT";
    case FSM_TYPE_SOCKET_SEND:              return "SOCKET_SEND";
    case FSM_TYPE_SOCKET_RECEIVE:           return "SOCKET_RECEIVE";
    case FSM_TYPE_SOCKET_QUERY_AVAILABLE:   return "SOCKET_QUERY_AVAILABLE";
    case FSM_TYPE_SECURE_CONNECT:           return "SECURE_CONNECT";
    case FSM_TYPE_SECURE_HANDSHAKE:         return "SECURE_HANDSHAKE";
    case FSM_TYPE_SECURE_NEGOTIATE:         return "SECURE_NEGOTIATE";
    case FSM_TYPE_NEGOTIATE_LOOP:           return "NEGOTIATE_LOOP";
    case FSM_TYPE_SECURE_SEND:              return "SECURE_SEND";
    case FSM_TYPE_SECURE_RECEIVE:           return "SECURE_RECEIVE";
    case FSM_TYPE_GET_CONNECTION:           return "GET_CONNECTION";
    case FSM_TYPE_HTTP_SEND_REQUEST:        return "HTTP_SEND_REQUEST";
    case FSM_TYPE_MAKE_CONNECTION:          return "MAKE_CONNECTION";
    case FSM_TYPE_OPEN_CONNECTION:          return "OPEN_CONNECTION";
    case FSM_TYPE_OPEN_PROXY_TUNNEL:        return "OPEN_PROXY_TUNNEL";
    case FSM_TYPE_SEND_REQUEST:             return "SEND_REQUEST";
    case FSM_TYPE_RECEIVE_RESPONSE:         return "RECEIVE_RESPONSE";
    case FSM_TYPE_HTTP_READ:                return "HTTP_READ";
    case FSM_TYPE_HTTP_WRITE:               return "HTTP_WRITE";
    case FSM_TYPE_READ_DATA:                return "READ_DATA";
    case FSM_TYPE_HTTP_QUERY_AVAILABLE:     return "HTTP_QUERY_AVAILABLE";
    case FSM_TYPE_DRAIN_RESPONSE:           return "DRAIN_RESPONSE";
    case FSM_TYPE_REDIRECT:                 return "REDIRECT";
    case FSM_TYPE_READ_LOOP:                return "READ_LOOP";
    case FSM_TYPE_PARSE_HTTP_URL:           return "PARSE_HTTP_URL";
    case FSM_TYPE_PARSE_URL_FOR_HTTP:       return "PARSE_URL_FOR_HTTP";
    case FSM_TYPE_READ_FILE:                return "READ_FILE";
    case FSM_TYPE_READ_FILE_EX:             return "READ_FILE_EX";
    case FSM_TYPE_WRITE_FILE:               return "WRITE_FILE";
    case FSM_TYPE_QUERY_DATA_AVAILABLE:     return "QUERY_DATA_AVAILABLE";
    case FSM_TYPE_FTP_CONNECT:              return "FTP_CONNECT";
    case FSM_TYPE_FTP_FIND_FIRST_FILE:      return "FTP_FIND_FIRST_FILE";
    case FSM_TYPE_FTP_GET_FILE:             return "FTP_GET_FILE";
    case FSM_TYPE_FTP_PUT_FILE:             return "FTP_PUT_FILE";
    case FSM_TYPE_FTP_DELETE_FILE:          return "FTP_DELETE_FILE";
    case FSM_TYPE_FTP_RENAME_FILE:          return "FTP_RENAME_FILE";
    case FSM_TYPE_FTP_OPEN_FILE:            return "FTP_OPEN_FILE";
    case FSM_TYPE_FTP_CREATE_DIRECTORY:     return "FTP_CREATE_DIRECTORY";
    case FSM_TYPE_FTP_REMOVE_DIRECTORY:     return "FTP_REMOVE_DIRECTORY";
    case FSM_TYPE_FTP_SET_CURRENT_DIRECTORY:    return "FTP_SET_CURRENT_DIRECTORY";
    case FSM_TYPE_FTP_GET_CURRENT_DIRECTORY:    return "FTP_GET_CURRENT_DIRECTORY";
    case FSM_TYPE_GOPHER_FIND_FIRST_FILE:   return "GOPHER_FIND_FIRST_FILE";
    case FSM_TYPE_GOPHER_OPEN_FILE:         return "GOPHER_OPEN_FILE";
    case FSM_TYPE_GOPHER_GET_ATTRIBUTE:     return "GOPHER_GET_ATTRIBUTE";
    case FSM_TYPE_INTERNET_PARSE_URL:       return "INTERNET_PARSE_URL";
    case FSM_TYPE_INTERNET_FIND_NEXT_FILE:  return "INTERNET_FIND_NEXT_FILE";
    case FSM_TYPE_INTERNET_QUERY_DATA_AVAILABLE:    return "INTERNET_QUERY_DATA_AVAILABLE";
    case FSM_TYPE_INTERNET_WRITE_FILE:      return "INTERNET_WRITE_FILE";
    case FSM_TYPE_INTERNET_READ_FILE:       return "INTERNET_READ_FILE";
    }
    return "?";
}

DEBUG_FUNCTION
LPSTR
CFsm::StateName(
    IN DWORD State
    ) {
    switch (State) {
    CASE_OF(FSM_STATE_BAD);
    CASE_OF(FSM_STATE_INIT);
    CASE_OF(FSM_STATE_WAIT);
    CASE_OF(FSM_STATE_DONE);
    CASE_OF(FSM_STATE_ERROR);
    CASE_OF(FSM_STATE_CONTINUE);
    CASE_OF(FSM_STATE_FINISH);
    CASE_OF(FSM_STATE_1);
    CASE_OF(FSM_STATE_2);
    CASE_OF(FSM_STATE_3);
    CASE_OF(FSM_STATE_4);
    CASE_OF(FSM_STATE_5);
    CASE_OF(FSM_STATE_6);
    CASE_OF(FSM_STATE_7);
    CASE_OF(FSM_STATE_8);
    CASE_OF(FSM_STATE_9);
    CASE_OF(FSM_STATE_10);
    }
    return "?";
}

#endif // INET_DEBUG
