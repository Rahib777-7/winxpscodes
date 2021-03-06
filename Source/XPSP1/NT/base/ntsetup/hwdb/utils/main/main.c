/*++

Copyright (c) 1996 Microsoft Corporation

Module Name:

    main.c

Abstract:

    Main source file of migutil.dll

Author:

    Jim Schmidt (jimschm)   01-Aug-1996

Revision History:

    marcw       2-Sep-1999  Moved over from Win9xUpg project.
    jimschm     23-Sep-1998 Start thread
    marcw       23-Sep-1998 Locale fix
    jimschm     03-Nov-1997 Added TextAlloc routines
    marcw       22-Jul-1997 Added IS<platform> functions.

--*/


#include "pch.h"
#include "utilsp.h"
#include "locale.h"

//#define DEBUG_ALL_FILES

HINSTANCE g_hInst;
HANDLE g_hHeap;

OSVERSIONINFOA g_OsInfo;
OUR_CRITICAL_SECTION g_MemDbCs;

#define TEXT_GROWTH_SIZE    65536


//
// OS-dependent flags for MultiByteToWideChar
//

DWORD g_MigutilWCToMBFlags = 0;


//
// g_ShortTermAllocTable is the default table used for resource string
// management.  New strings are allocated from the table.
//
// Allocation tables are very simple ways to store strings loaded in from
// the exe image.  The loaded string is copied into the table and kept
// around until it is explicitly freed.  Multiple attempts at getting the
// same resource string return the same string, inc'ing a use counter.
//
// g_OutOfMemoryTable is the table used to hold out-of-memory text.  It
// is loaded up at init time and is kept in memory for the whole time
// migutil is in use, so out-of-memory messages can always be displayed.
//

PGROWBUFFER g_ShortTermAllocTable;
PGROWBUFFER g_OutOfMemoryTable;

//
// We make sure the message APIs (GetStringResource, ParseMessageID, etc)
// are thread-safe
//

OUR_CRITICAL_SECTION g_MessageCs;

//
// The PoolMem routines must also be thread-safe
//

OUR_CRITICAL_SECTION g_PmCs;

//
// MemAlloc critical section
//

OUR_CRITICAL_SECTION g_MemAllocCs;

//
// The following pools are used for text management.  g_RegistryApiPool is
// for reg.c, g_PathsPool is for the JoinPaths/DuplicatePath/etc routines,
// and g_TextPool is for AllocText, DupText, etc.
//
PMHANDLE g_RegistryApiPool;
PMHANDLE g_PathsPool;
PMHANDLE g_TextPool;

VOID
UtInitialize (
    IN      HANDLE Heap             OPTIONAL
    )
{
    //
    // Set globals
    //

    if (Heap) {
        g_hHeap = Heap;
    } else {
        g_hHeap = GetProcessHeap();
    }

    g_hInst = GetModuleHandle (NULL);

    //
    // Load in OSVERSION info.
    //
    g_OsInfo.dwOSVersionInfoSize = sizeof(OSVERSIONINFOA);

    GetVersionExA (&g_OsInfo);

    //
    // Initialize log
    //

    Init_Log (NULL);

    //
    // Create critical sections
    //

    InitializeOurCriticalSection (&g_MemAllocCs);
    InitializeOurCriticalSection (&g_MemDbCs);
    InitializeOurCriticalSection (&g_PmCs);
    InitializeOurCriticalSection (&g_MessageCs);

    //
    // Now that MemAlloc will work, initialize allocation tracking
    //

    InitAllocationTracking();

    //
    // Create the short-term alloc table for string resource utils
    //

    g_ShortTermAllocTable = CreateAllocTable();

    //
    // MultiByteToWideChar has desirable flags that only function on NT
    //
    g_MigutilWCToMBFlags = (ISNT()) ? WC_NO_BEST_FIT_CHARS : 0;

#ifdef _lint

    g_MigutilWCToMBFlags = g_MigutilWCToMBFlags;

#endif


    //
    // Create pools used by utils.lib code
    //

    g_RegistryApiPool = PmCreateNamedPool ("Registry API");
    g_PathsPool = PmCreateNamedPool ("Paths");
    g_TextPool = PmCreateNamedPool ("Text");

    PmSetMinimumGrowthSize (g_TextPool, TEXT_GROWTH_SIZE);

    ObsInitialize ();
    ElInitialize ();

    //
    // The "out of memory" message
    //

    g_OutOfMemoryTable = CreateAllocTable();

    g_OutOfMemoryRetry  = GetStringResourceExA (
                                g_OutOfMemoryTable,
                                10001 /* MSG_OUT_OF_MEMORY_RETRY */
                                );

    g_OutOfMemoryString = GetStringResourceExA (
                                g_OutOfMemoryTable,
                                10002 /* MSG_OUT_OF_MEMORY */
                                );

    if (!g_OutOfMemoryString || !g_OutOfMemoryRetry) {
        DEBUGMSG ((
            DBG_WARNING,
            "Cannot load out of memory messages; resources 10001 and 10002 do not exist"
            ));
    }

    //
    // set the locale to the system locale. Not doing this can cause isspace
    // to AV in certain MBSCHR circumstances.
    //
    setlocale(LC_ALL,"");
}


VOID
UtTerminate (
    VOID
    )
{
    //
    // Free utility pools
    //

    ElTerminate ();
    ObsTerminate ();

    if (g_RegistryApiPool) {
        PmDestroyPool (g_RegistryApiPool);
    }

    if (g_PathsPool) {
        PmDestroyPool (g_PathsPool);
    }

    if (g_TextPool) {
        PmDestroyPool (g_TextPool);
    }

    if (g_ShortTermAllocTable) {
        DestroyAllocTable (g_ShortTermAllocTable);
    }

    if (g_OutOfMemoryTable) {
        DestroyAllocTable (g_OutOfMemoryTable);
    }

    FreeAllocationTracking();

    //
    // Clean up handles used by critical sections
    //

    DeleteOurCriticalSection (&g_MemAllocCs);
    DeleteOurCriticalSection (&g_MemDbCs);
    DeleteOurCriticalSection (&g_PmCs);
    DeleteOurCriticalSection (&g_MessageCs);

    //
    // MUST BE VERY LAST CODE TO RUN
    //

    DumpHeapStats();
    Exit_Log ();
}



#define WIDTH(rect) (rect.right - rect.left)
#define HEIGHT(rect) (rect.bottom - rect.top)

void
CenterWindow (
    IN  HWND hwnd,
    IN  HWND Parent
    )
{
    RECT WndRect, ParentRect;
    int x, y;

    if (!Parent) {
        ParentRect.left = 0;
        ParentRect.top  = 0;
        ParentRect.right = GetSystemMetrics (SM_CXFULLSCREEN);
        ParentRect.bottom = GetSystemMetrics (SM_CYFULLSCREEN);
    } else {
        GetWindowRect (Parent, &ParentRect);
    }

    MYASSERT (IsWindow (hwnd));

    GetWindowRect (hwnd, &WndRect);

    x = ParentRect.left + (WIDTH(ParentRect) - WIDTH(WndRect)) / 2;
    y = ParentRect.top + (HEIGHT(ParentRect) - HEIGHT(WndRect)) / 2;

    SetWindowPos (hwnd, NULL, x, y, 0, 0, SWP_NOZORDER|SWP_NOSIZE);
}


static INT g_MigUtilWaitCounter = 0;
static HCURSOR g_MigUtilWaitCursor = NULL;

VOID
TurnOnWaitCursor (
    VOID
    )

/*++

Routine Description:

  TurnOnWaitCursor sets the cursor to IDC_WAIT.  It maintains a use
  counter, so code requring the wait cursor can be nested.

Arguments:

  none

Return Value:

  none

--*/

{
    if (g_MigUtilWaitCounter == 0) {
        g_MigUtilWaitCursor = SetCursor (LoadCursor (NULL, IDC_WAIT));
    }

    g_MigUtilWaitCounter++;
}


VOID
TurnOffWaitCursor (
    VOID
    )

/*++

Routine Description:

  TurnOffWaitCursor decrements the wait cursor counter, and if it
  reaches zero the cursor is restored.

Arguments:

  none

Return Value:

  none

--*/

{
    if (!g_MigUtilWaitCounter) {
        DEBUGMSG ((DBG_WHOOPS, "TurnOffWaitCursor called too many times"));
    } else {
        g_MigUtilWaitCounter--;

        if (!g_MigUtilWaitCounter) {
            SetCursor (g_MigUtilWaitCursor);
        }
    }
}


/*++

Routine Description:

  Win9x does not support TryEnterOurCriticalSection, so we must implement
  our own version because it is quite a useful function.

Arguments:

  pcs - A pointer to an OUR_CRITICAL_SECTION object

Return Value:

  TRUE if the function succeeded, or FALSE if it failed.  See Win32
  SDK docs on critical sections, as these routines are identical to
  the caller.

--*/

BOOL
InitializeOurCriticalSection (
    OUR_CRITICAL_SECTION *pcs
    )
{
    // Create initially signaled, auto-reset event
    pcs->EventHandle = CreateEvent (NULL, FALSE, TRUE, NULL);
    if (!pcs->EventHandle) {
        return FALSE;
    }

    return TRUE;
}


VOID
DeleteOurCriticalSection (
    OUR_CRITICAL_SECTION *pcs
    )
{
    if (pcs->EventHandle) {
        CloseHandle (pcs->EventHandle);
        pcs->EventHandle = NULL;
    }

}


BOOL
EnterOurCriticalSection (
    OUR_CRITICAL_SECTION *pcs
    )
{
    DWORD rc;

    // Wait for event to become signaled, then turn it off
    rc = WaitForSingleObject (pcs->EventHandle, INFINITE);
    if (rc == WAIT_OBJECT_0) {
        return TRUE;
    }

    return FALSE;
}

VOID
LeaveOurCriticalSection (
    OUR_CRITICAL_SECTION *pcs
    )
{
    SetEvent (pcs->EventHandle);
}

BOOL
TryEnterOurCriticalSection (
    OUR_CRITICAL_SECTION *pcs
    )
{
    DWORD rc;

    rc = WaitForSingleObject (pcs->EventHandle, 0);
    if (rc == WAIT_OBJECT_0) {
        return TRUE;
    }

    return FALSE;
}




HANDLE
StartThread (
    IN      PTHREAD_START_ROUTINE Address,
    IN      PVOID Arg
    )
{
    DWORD DontCare;

    return CreateThread (NULL, 0, Address, Arg, 0, &DontCare);
}


