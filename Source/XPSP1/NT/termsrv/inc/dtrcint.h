/**INC+**********************************************************************/
/* Header:    dtrcint.h                                                     */
/*                                                                          */
/* Purpose:   Internal tracing functions header - Windows 3.1 specific      */
/*                                                                          */
/* Copyright(C) Microsoft Corporation 1997                                  */
/*                                                                          */
/****************************************************************************/
/** Changes:
 * $Log:   Y:/logs/h/dcl/dtrcint.h_v  $
 * 
 *    Rev 1.3   22 Sep 1997 15:11:36   KH
 * SFR1368: Keep the Win16 INI file in Windows, not Ducati, directory
 *
 *    Rev 1.2   09 Jul 1997 17:06:58   AK
 * SFR1016: Initial changes to support Unicode
 *
 *    Rev 1.1   19 Jun 1997 15:28:30   ENH
 * Win16Port: 16 bit specifics
**/
/**INC-**********************************************************************/
#ifndef _H_DTRCINT
#define _H_DTRCINT

/****************************************************************************/
/*                                                                          */
/* CONSTANTS                                                                */
/*                                                                          */
/****************************************************************************/
/****************************************************************************/
/* Default values for kernel tracing - off for Win16                        */
/****************************************************************************/
#define TRC_DFLT_KERNEL_DEBUG 0
#define TRC_DFLT_KERNEL_TO_USER 0

/****************************************************************************/
/*                                                                          */
/* MACROS                                                                   */
/*                                                                          */
/****************************************************************************/

/****************************************************************************/
/* Macro to create the mutex which protects the shared data memory mapped   */
/* file.                                                                    */
/****************************************************************************/
#define TRCCreateMutex(a,b,c) ((HANDLE)1)

/****************************************************************************/
/* Macro to get the mutex which protects the shared data memory mapped      */
/* file.  Not used by Win16.                                                */
/****************************************************************************/
#define TRCGrabMutex() (0)

/****************************************************************************/
/* Macro to free the mutex.  Not used by Win16.                             */
/****************************************************************************/
#define TRCReleaseMutex() (TRUE)

/****************************************************************************/
/* Macro to close the mutex object. Not used by Win16.                      */
/****************************************************************************/
#define TRCCloseHandle(handle) (TRUE)

/****************************************************************************/
/* Trace a string out to the debugger.                                      */
/****************************************************************************/
#define TRCDebugOutput(pText)                                                \
{                                                                            \
    OutputDebugString(pText);                                                \
}

/****************************************************************************/
/* Get the current process Id using the Win32 GetCurrentProcessId function. */
/****************************************************************************/
#define TRCGetCurrentProcessId()   ((DCUINT32)(PDCVOID)GetCurrentTask())

/****************************************************************************/
/* No thread IDs on Win16                                                   */
/****************************************************************************/
#define TRCGetCurrentThreadId()    0

/****************************************************************************/
/* Define our own beep macro.                                               */
/****************************************************************************/
#define TRCBeep()                  MessageBeep(0)

/****************************************************************************/
/* Define our debug break macro.                                            */
/****************************************************************************/
DCVOID DCINTERNAL TRCDebugBreak(DCVOID);

/****************************************************************************/
/* Macro to create a registry key.                                          */
/****************************************************************************/
#define TRC_MAKE_SUBKEY(BUFFER) DC_ASTRCPY(BUFFER, DC_REG_PREFIX);           \
                                DC_ASTRCAT(BUFFER, TRC_INI_SECTION_NAME)

/****************************************************************************/
/*                                                                          */
/* FUNCTION PROTOTYPES                                                      */
/*                                                                          */
/****************************************************************************/

#endif /* _H_DTRCINT */
