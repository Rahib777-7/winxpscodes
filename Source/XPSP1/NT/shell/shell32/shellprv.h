#ifndef _SHELLPRV_H_
#define _SHELLPRV_H_

// We now always rely on Win2k or Millennium at least.
#define OVERRIDE_SHLWAPI_PATH_FUNCTIONS     // see comment in shsemip.h

#define _SHELL32_
#define _WIN32_DCOM     // for COINIT_DISABLE_OLE1DDE

#ifdef __cplusplus
#define NO_INCLUDE_UNION
#endif  /* __cplusplus */

#define NOWINDOWSX
#ifndef STRICT
#define STRICT
#endif
#define OEMRESOURCE // FSMenu needs the menu triangle

#define INC_OLE2
#define CONST_VTABLE

// Disable a few warnings so we can include the system header files at /W4.
#include "w4warn.h"
#pragma warning(disable:4706) // assignment within conditional expression
#pragma warning(disable:4127) // conditional expression is constant
#pragma warning(disable:4131) // 'CreateInfoFile' : uses old-style declarator
#pragma warning(disable:4221) // nonstandard extension used : 'pFrom' : cannot be initialized using address of automatic variable 'szBBPathToNuke'
#pragma warning(disable:4245) // 'initializing' : conversion from 'const int' to 'const DWORD', signed/unsigned mismatch
#pragma warning(disable:4057) // '=' : 'CHAR *' differs in indirection to slightly different base types from 'PBYTE '
#pragma warning(disable:4189) // 'fWrite' : local variable is initialized but not referenced
#pragma warning(disable:4701) // local variable 'lListIndex' may be used without having been initialized
#pragma warning(disable:4213) // nonstandard extension used : cast on l-value
#pragma warning(disable:4702) // unreachable code
#pragma warning(disable:4127) // conditional expression is constant
#pragma warning(disable:4210) // nonstandard extension used : function given file scope
#pragma warning(disable:4055) // 'type cast' : from data pointer 'IDataObject *' to function pointer 'FARPROC '
#pragma warning(disable:4267) // '=' : conversion from 'size_t' to 'UINT', possible loss of data
#pragma warning(disable:4328) // indirection alignment of formal parameter 4 (2) is greater than the actual argument alignment (1)

//  These NT headers must come before <windows.h> or you get redefinition
//  errors!  It's a miracle the system builds at all...
#ifdef __cplusplus
extern "C" {
#endif  /* __cplusplus */
#include <nt.h>         // Some of the NT specific code needs Rtl functions
#include <ntrtl.h>      // which requires all of these header files...
#include <nturtl.h>
#include <ntseapi.h>
#include <dfsfsctl.h>

#ifdef __cplusplus
}       /* End of extern "C" */
#endif  /* __cplusplus */

#define CC_INTERNAL   // this is because docfind uses the commctrl internal prop sheet structures

//--------------------------------------------------------------------------
//
//  The order of these is critical for ATL.
//
//  1.  ATL has its own definition of InlineIsEqualGUID that conflicts with
//      the definition in <objbase.h>, so we must explicitly include
//      <ole2.h> to get the <objbase.h> definition, then use a hacky macro
//      to disable the ATL version so it doesn't conflict with the OLE one.
//
//  2.  ATL has methods called SubclassWindow, which conflicts with a
//      macro in <windowsx.h>, so we must include <windowsx.h> after ATL.
//
//  3.  We want ATL to use the shell debug macros, so we must include
//      <debug.h> before ATL so it can see the shell debug macros.
//
//  4.  VariantInit is such a trivial function that we inline it in order
//      to avoid pulling in OleAut32.
//
//  5.  We want ATL to use the shell version of the ANSI/UNICODE conversion
//      functions (because the shell versions can be called from C).
//

#include <oaidl.h>
#include <docobj.h>

#include <windows.h>
#include "shfusion.h"
#include <ole2.h>           // Get the real InlineIsEqualGUID
#define _ATL_NO_DEBUG_CRT   // Use the shell debug macros
#include <stddef.h>
#include <debug.h>          // Get the shell debug macros
#include <shconv.h>         // Shell version of <atlconv.h>
 

#define VariantInit(p) memset(p, 0, sizeof(*(p)))

#ifdef __cplusplus

#define _ATL_APARTMENT_THREADED

#ifndef _SYS_GUID_OPERATORS_
// Re-route the ATL version of InlineIsEqualGUID
#define InlineIsEqualGUID ATL_InlineIsEqualGUID
#endif

#include <atlbase.h>
//You may derive a class from CComModule and use it if you want to override
//something, but do not change the name of _Module
extern CComModule _Module;

#include <atlcom.h>
#include <atlhost.h>
#include <atlctl.h>
#include <atliface.h>
#include <atlwin.h>

#ifndef _SYS_GUID_OPERATORS_
#undef InlineIsEqualGUID    // Return InlineIsEqualGUID to its normal state
#endif

#include <memt.h>

#endif  /* __cplusplus */

// end of ATL Stuff
//--------------------------------------------------------------------------
#ifndef _SYS_GUID_OPERATORS_
#ifdef _OLE32_ // {
// turning on _OLE32_ (which we did for delay load stuff) gives us f-a-t
// versions of IsEqualGUID.  undo that here (hack on top of a hack...)
#undef IsEqualGUID
#ifdef __cplusplus
__inline BOOL IsEqualGUID(IN REFGUID rguid1, IN REFGUID rguid2)
{
    return !memcmp(&rguid1, &rguid2, sizeof(GUID));
}
#else   //  ! __cplusplus
#define IsEqualGUID(rguid1, rguid2) (!memcmp(rguid1, rguid2, sizeof(GUID)))
#endif  //  __cplusplus
#endif // }
#endif

#ifdef __cplusplus
extern "C" {            /* Assume C declarations for C++ */
#endif  /* __cplusplus */

// This flag indicates that we are on a system where data alignment is a concern

#if (defined(UNICODE) && (defined(_MIPS_) || defined(_ALPHA_) || defined(_PPC_)))
#define ALIGNMENT_SCENARIO
#endif

#include <windowsx.h>
#include <winnetp.h>

//  Dependencies among header files:
//
//      <oaidl.h> must come before <shlwapi.h> if you want to have
//      OLE command target helper functions.
//
#include <hlink.h> // must include before shellp in order to get IBrowserService2!
#include <commctrl.h>
#include <shellapi.h>
#include <wininet.h>
#include <shlobj.h>

#include <shlwapi.h>
#include <commdlg.h>
#include <port32.h>         // in    shell\inc
#define DISALLOW_Assert
#include <linkinfo.h>
#include <shlobjp.h>
#include <shsemip.h>
#include <docobj.h>
#include <shguidp.h>
#include <ieguidp.h>
#include <shellp.h>
#include <shdocvw.h>
#include <iethread.h>
#include "browseui.h"
#include <ccstock.h>
#include <ccstock2.h>
#include <objidl.h>
#include "apithk.h"
#define SECURITY_WIN32
#include <security.h>
#include <mlang.h>
#include <krnlcmn.h>    // GetProcessDword
#include <regapix.h>        // MAXIMUM_SUB_KEY_LENGTH, MAXIMUM_VALUE_NAME_LENGTH, MAXIMUM_DATA_LENGTH
#include <heapaloc.h>
#include <fmifs.h>


#include "util.h"
#include "varutil.h"
#include "cstrings.h"
#include "securent.h"
#include "winprtp.h"

#include "qistub.h"
#ifdef DEBUG
#include "dbutil.h"
#endif

#define CP_HEBREW        1255
#define CP_ARABIC        1256

EXTERN_C const ITEMIDLIST c_idlDesktop;   // NULL IDList

#undef CharNext
#undef CharPrev

#define CharNext(x) ((x)+1)
#define CharPrev(y,x) ((x)-1)
#define IsDBCSLeadByte(x) ((x), FALSE)

// these functions are not available on NT
#undef ReinitializeCriticalSection
#undef LoadLibrary16
#undef FreeLibrary16
#undef GetProcAddress16
#define ReinitializeCriticalSection #error_ReinitializeCriticalSection_not_available_on_NT
#define LoadLibrary16 #error_LoadLibrary16_not_available_on_NT
#define FreeLibrary16 #error_FreeLibrary16_not_available_on_NT
#define GetProcAddress16 #error_GetProcAddress16_not_available_on_NT
#define GetModuleHandle16(sz) (0)
#define GetModuleFileName16(hinst, buf, cch) buf[0]='\0'

DWORD
SetPrivilegeAttribute(
    IN  LPCTSTR PrivilegeName,
    IN  DWORD   NewPrivilegeAttributes,
    OUT DWORD   *OldPrivilegeAttribute
    );


// drivesx.c
BOOL IsUnavailableNetDrive(int iDrive);
BOOL IsDisconnectedNetDrive(int iDrive);
BOOL IsAudioDisc(LPTSTR pszDrive);
BOOL IsDVDDisc(int iDrive);

// futil.c
BOOL  IsShared(LPNCTSTR pszPath, BOOL fUpdateCache);
DWORD GetConnection(LPCTSTR lpDev, LPTSTR lpPath, UINT cbPath, BOOL bConvertClosed);

// rundll32.c
HWND _CreateStubWindow(POINT* ppt, HWND hwndParent);
#define STUBM_SETDATA       (WM_USER)
#define STUBM_GETDATA       (WM_USER + 1)
#define STUBM_SETICONTITLE  (WM_USER + 2)

#define STUBCLASS_PROPSHEET     1
#define STUBCLASS_FORMAT        2

// shlexe.c
BOOL IsDarwinEnabled();
STDAPI ParseDarwinID(LPTSTR pszDarwinDescriptor, LPTSTR pszDarwinCommand, DWORD cchDarwinCommand);

// shprsht.c
typedef struct {
    HWND    hwndStub;
    HANDLE  hClassPidl;
    HICON   hicoStub;
} UNIQUESTUBINFO;
STDAPI_(BOOL) EnsureUniqueStub(LPITEMIDLIST pidl, int iClass, POINT *ppt, UNIQUESTUBINFO *pusi);
STDAPI_(void) FreeUniqueStub(UNIQUESTUBINFO *pusi);
STDAPI_(void) SHFormatDriveAsync(HWND hwnd, UINT drive, UINT fmtID, UINT options);

// bitbuck.c
void  RelayMessageToChildren(HWND hwnd, UINT uMessage, WPARAM wParam, LPARAM lParam);
BOOL IsFileInBitBucket(LPCTSTR pszPath);

BOOL CreateWriteCloseFile(HWND hwnd, LPCTSTR pszFileName, void *pv, DWORD cbData);

// idlist.c
STDAPI_(BOOL) SHIsValidPidl(LPCITEMIDLIST pidl);

STDAPI_(BOOL) IsExeTSAware(LPCTSTR pszExe);

// exec stuff

/* common exe code with error handling */
#define SECL_USEFULLPATHDIR     0x00000001
#define SECL_NO_UI              0x00000002
#define SECL_SEPARATE_VDM       0x00000004
#define SECL_LOG_USAGE          0x00000008
BOOL ShellExecCmdLine(HWND hwnd, LPCTSTR lpszCommand, LPCTSTR lpszDir,
        int nShow, LPCTSTR lpszTitle, DWORD dwFlags);
#define ISSHELLEXECSUCCEEDED(hinst) ((UINT_PTR)hinst>32)
#define ISWINEXECSUCCEEDED(hinst)   ((UINT_PTR)hinst>=32)
void _ShellExecuteError(LPSHELLEXECUTEINFO pei, LPCTSTR lpTitle, DWORD dwErr);

// fsnotify.c (private stuff) ----------------------

BOOL SHChangeNotifyInit();
STDAPI_(void) SHChangeNotifyTerminate(BOOL bLastTerm, BOOL bProcessShutdown);
void SHChangeNotifyReceiveEx(LONG lEvent, UINT uFlags, LPCITEMIDLIST pidl, LPCITEMIDLIST pidlExtra, DWORD dwEventTime);
LRESULT SHChangeNotify_OnNotify(WPARAM wParam, LPARAM lParam);
LRESULT SHChangeNotify_OnChangeRegistration(WPARAM wParam, LPARAM lParam);
LRESULT SHChangeNotify_OnNotifySuspendResume(WPARAM wParam, LPARAM lParam);
LRESULT SHChangeNotify_OnDeviceChange(ULONG_PTR code, struct _DEV_BROADCAST_HDR *pbh);
void    SHChangeNotify_DesktopInit();
void    SHChangeNotify_DesktopTerm();
STDAPI_(void) SHChangeNotifyRegisterAlias(LPCITEMIDLIST pidlReal, LPCITEMIDLIST pidlAlias);

void _Shell32ThreadAddRef(BOOL fLeaveSuspended);
void _Shell32ThreadRelease(UINT nClients);
void _Shell32ThreadAwake(void);

// Entry points for managing registering name to IDList translations.
void NPTRegisterNameToPidlTranslation(LPCTSTR pszPath, LPCITEMIDLIST pidl);
LPWSTR NPTMapNameToPidl(LPCWSTR pszPath, LPCITEMIDLIST *ppidl);

// path.c (private stuff) ---------------------

#define PQD_NOSTRIPDOTS 0x00000001

STDAPI_(void) PathQualifyDef(LPTSTR psz, LPCTSTR szDefDir, DWORD dwFlags);

STDAPI_(BOOL) PathIsRemovable(LPCTSTR pszPath);
STDAPI_(BOOL) PathIsRemote(LPCTSTR pszPath);
STDAPI_(BOOL) PathIsTemporary(LPCTSTR pszPath);
STDAPI_(BOOL) PathIsWild(LPCTSTR pszPath);
STDAPI_(BOOL) PathIsLnk(LPCTSTR pszFile);
STDAPI_(BOOL) PathIsSlow(LPCTSTR pszFile, DWORD dwFileAttr);
STDAPI_(BOOL) PathIsInvalid(LPCTSTR pPath);
STDAPI_(BOOL) PathIsBinaryExe(LPCTSTR szFile);
STDAPI_(BOOL) PathMergePathName(LPTSTR pPath, LPCTSTR pName);
STDAPI_(BOOL) PathGetMountPointFromPath(LPCTSTR pcszPath, LPTSTR pszMountPoint, int cchMountPoint);
STDAPI_(BOOL) PathIsShortcutToProgram(LPCTSTR pszFile);

#if (defined(UNICODE) && (defined(_MIPS_) || defined(_ALPHA_) || defined(_PPC_)))

#else

#define uaPathFindExtension PathFindExtension

#endif

void SpecialFolderIDTerminate();
void ReleaseRootFolders();
extern HINSTANCE g_hinst;

// get the desktop HWND if it is this process...
HWND GetInProcDesktop();

// Is Mirroring APIs enabled (BiDi Memphis and NT5 only)
extern BOOL g_bMirroredOS;

// Is DATE_LTRREADING supported by GetDateFormat() API?  (it is supported in all the BiDi platforms.)
extern BOOL g_bBiDiPlatform;

// for control panel and printers folder:
extern TCHAR const c_szNull[];
extern TCHAR const c_szDotDot[];
extern TCHAR const c_szRunDll[];
extern TCHAR const c_szNewObject[];


// lang platform
extern UINT g_uCodePage;


// other stuff
#define HINST_THISDLL   g_hinst

//
// Trace/dump/break flags specific to shell32.
//   (Standard flags defined in shellp.h)
//

// Trace flags
#define TF_IMAGE            0x00000010      // Image/icon related stuff
#define TF_PROPERTY         0x00000020      // Property traces
#define TF_PATH             0x00000040      // Path whacking traces
#define TF_MENU             0x00000080      // Menu stuff
#define TF_ALLOC            0x00000100      // Allocation traces
#define TF_REG              0x00000200      // Registry traces
#define TF_DDE              0x00000400      // Shell progman DDE message tracing
#define TF_HASH             0x00000800      // Hash table stuff
#define TF_ASSOC            0x00001000      // File/URL Association traces
#define TF_FILETYPE         0x00002000      // File Type stuff
#define TF_SHELLEXEC        0x00004000      // ShellExecute stuff
#define TF_OLE              0x00008000      // OLE-specific stuff
#define TF_DEFVIEW          0x00010000      // Defview
#define TF_PERF             0x00020000      // Performance timings
#define TF_FSNOTIFY         0x00040000      // FSNotify stuff
#define TF_LIFE             0x00080000      // Object lifetime traces
#define TF_IDLIST           0x00100000      // "PIDLy" things
#define TF_FSTREE           0x00200000      // FSTree traces
#define TF_PRINTER          0x00400000      // Printer traces
//#define TF_QISTUB          0x00800000      // defined in unicpp\shellprv.h
#define TF_DOCFIND          0x01000000      // DocFind
#define TF_MENUBAND         0x02000000      // menubands
#define TF_CPANEL           0x10000000      // Control Panel
#define TF_CUSTOM1          0x40000000      // Custom messages #1
#define TF_CUSTOM2          0x80000000      // Custom messages #2


// "Olde names"
#define DM_ALLOC            TF_ALLOC
#define DM_REG              TF_REG

// Function trace flags
#define FTF_DEFVIEW         0x00000004      // DefView calls
#define FTF_DDE             0x00000008      // DDE functions
#define FTF_CPANEL          0x00000010      // Control Panel

// Dump flags
#define DF_INTSHCUT         0x00000001      // Internet shortcut structures
#define DF_HASH             0x00000002      // Hash table
#define DF_FSNPIDL          0x00000004      // Pidl for FSNotify
#define DF_URLPROP          0x00000008      // URL property structures
#define DF_DEBUGQI          0x00000010
#define DF_DEBUGQINOREF     0x00000020
#define DF_ICONCACHE        0x00000040      // Icon cache
#define DF_CLASSFLAGS       0x00000080      // File class cache
#define DF_DELAYLOADDLL     0x00000100      // Delay load

// Break flags
#define BF_ONLOADED         0x00000010      // Stop when loaded
#define BF_COCREATEINSTANCE 0x10000000      // On CoCreateInstance failure

// Debugging strings
#define GEN_DEBUGSTRW(str)  ((str) ? (str) : L"<Null Str>")
#define GEN_DEBUGSTRA(str)  ((str) ? (str) : "<Null Str>")

#ifdef UNICODE
#define GEN_DEBUGSTR  GEN_DEBUGSTRW
#else // UNICODE
#define GEN_DEBUGSTR  GEN_DEBUGSTRA
#endif // UNICODE

// Note:  raymondc - ATOMICRELEASE isn't particularly atomic.  There is a race
// condition if two people try to ATOMICRELEASE the same thing simultaneously.

// shorthand
#ifndef ATOMICRELEASE
#ifdef __cplusplus
#define ATOMICRELEASET(p, type) { if(p) { type* punkT=p; p=NULL; punkT->Release();} }
#else
#define ATOMICRELEASET(p, type) { if(p) { type* punkT=p; p=NULL; punkT->lpVtbl->Release(punkT);} }
#endif

// doing this as a function instead of inline seems to be a size win.
//
#ifdef NOATOMICRELESEFUNC
#define ATOMICRELEASE(p) ATOMICRELEASET(p, IUnknown)
#else
#   ifdef __cplusplus
#       define ATOMICRELEASE(p) IUnknown_SafeReleaseAndNullPtr(p)
#   else
#       define ATOMICRELEASE(p) IUnknown_AtomicRelease((void **)&p)
#   endif
#endif
#endif //ATOMICRELEASE

#ifdef SAFERELEASE
#undef SAFERELEASE
#endif
#define SAFERELEASE(p) ATOMICRELEASE(p)


// fileicon.c
void    FileIconTerm(void);


#define CCH_KEYMAX      64          // DOC: max size of a reg key (under shellex)

void ReplaceParams(LPTSTR szDst, LPCTSTR szFile);


#ifdef __IPropertyStorage_INTERFACE_DEFINED__
WINSHELLAPI HRESULT SHPropVariantClear(PROPVARIANT * ppropvar);
WINSHELLAPI HRESULT SHFreePropVariantArray(ULONG cel, PROPVARIANT * ppropvar);
WINSHELLAPI HRESULT SHPropVariantCopy(PROPVARIANT * ppropvar, const PROPVARIANT * ppropvarFrom);
#endif


//
// fsassoc.c
//

#define GCD_MUSTHAVEOPENCMD     0x0001
#define GCD_ADDEXETODISPNAME    0x0002  // must be used with GCD_MUSTHAVEOPENCMD
#define GCD_ALLOWPSUDEOCLASSES  0x0004  // .ext type extensions

// Only valid when used with FillListWithClasses
#define GCD_MUSTHAVEEXTASSOC    0x0008  // There must be at least one extension assoc

BOOL GetClassDescription(HKEY hkClasses, LPCTSTR pszClass, LPTSTR szDisplayName, int cbDisplayName, UINT uFlags);

//
// Registry key handles
//
extern HKEY g_hklmApprovedExt;      // For approved shell extensions

// always zero, see init.c
extern const LARGE_INTEGER g_li0;
extern const ULARGE_INTEGER g_uli0;


// from link.c
BOOL PathSeperateArgs(LPTSTR pszPath, LPTSTR pszArgs);

// from fstree.cpp and drives.cpp

STDAPI SFVCB_OnAddPropertyPages(IN DWORD pv, IN SFVM_PROPPAGE_DATA * ppagedata);

//
// this used to be in shprst.c
//

#define MAX_FILE_PROP_PAGES 32

HKEY NetOpenProviderClass(HDROP);
void OpenNetResourceProperties(HWND, HDROP);

// msgbox.c
// Constructs strings like ShellMessagebox "xxx %1%s yyy %2%s..."
LPTSTR WINCAPI ShellConstructMessageString(HINSTANCE hAppInst, LPCTSTR lpcText, ...);

//  Copy.c
#define SPEED_SLOW  400
DWORD GetPathSpeed(LPCTSTR pszPath);


// SharedFldr.cpp
STDAPI_(BOOL) SHShowSharedFolders();


// mulprsht.c

STDAPI_(BOOL) SHEncryptFile(LPCTSTR pszPath, BOOL fEncrypt);
// wuutil.c
void cdecl SetFolderStatusText(HWND hwndStatus, int iField, UINT ids,...);

#ifdef DEBUG
extern BOOL  g_bInDllEntry;

#undef SendMessage
#define SendMessage  SendMessageD
LRESULT WINAPI SendMessageD(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);

//
//  The DEBUG build validates that every class we register is in the
//  unregister list so we don't leak classes at unload.
//
#undef RegisterClass
#undef RegisterClassEx
#define RegisterClass       RegisterClassD
#define RegisterClassEx     RegisterClassExD
ATOM WINAPI RegisterClassD(CONST WNDCLASS *lpWndClass);
ATOM WINAPI RegisterClassExD(CONST WNDCLASSEX *lpWndClass);
#endif // DEBUG

#ifdef UNICODE
#define RealRegisterClass   RegisterClassW
#define RealRegisterClassEx RegisterClassExW
#else
#define RealRegisterClass   RegisterClassA
#define RealRegisterClassEx RegisterClassExA
#endif

//
//  In DEBUG, send FindWindow through a wrapper that ensures that the
//  critical section is not taken.  FindWindow sends interthreadmessages,
//  which is not obvious.
//
#ifdef DEBUG
#undef  FindWindow
#undef  FindWindowEx
#define FindWindow              FindWindowD
#define FindWindowEx            FindWindowExD

STDAPI_(HWND) FindWindowD  (LPCTSTR lpClassName, LPCTSTR lpWindowName);
STDAPI_(HWND) FindWindowExD(HWND hwndParent, HWND hwndChildAfter, LPCTSTR lpClassName, LPCTSTR lpWindowName);
#ifdef UNICODE
#define RealFindWindowEx        FindWindowExW
#else
#define RealFindWindowEx        FindWindowExA
#endif // UNICODE
#endif // DEBUG

// our wrapper for GetCompressedFileSize, which is NT only
STDAPI_(DWORD) SHGetCompressedFileSizeW(LPCWSTR pszFileName, LPDWORD pFileSizeHigh);

#undef GetCompressedFileSize
#define GetCompressedFileSize SHGetCompressedFileSize

#ifdef UNICODE
#define SHGetCompressedFileSize SHGetCompressedFileSizeW
#else
#define SHGetCompressedFileSize #error // not implemented, because its an nt only API
#endif // UNICODE

#define ASSERTDLLENTRY      ASSERT(g_bInDllEntry);

//
// STATIC macro
//
#ifndef STATIC
#ifdef DEBUG
#define STATIC
#else
#define STATIC static
#endif
#endif

//
// Debug helper functions
//


//
// Validation functions
//

BOOL IsValidPSHELLEXECUTEINFO(LPSHELLEXECUTEINFO pei);


// Defining FULL_DEBUG allows us debug memory problems.
#if defined(FULL_DEBUG)
#include <deballoc.h>
#endif // defined(FULL_DEBUG)

#define FillExecInfo(_info, _hwnd, _verb, _file, _params, _dir, _show) \
        (_info).hwnd            = _hwnd;        \
        (_info).lpVerb          = _verb;        \
        (_info).lpFile          = _file;        \
        (_info).lpParameters    = _params;      \
        (_info).lpDirectory     = _dir;         \
        (_info).nShow           = _show;        \
        (_info).fMask           = 0;            \
        (_info).cbSize          = SIZEOF(SHELLEXECUTEINFO);

STDAPI_(LONG) SHRegQueryValueA(HKEY hKey, LPCSTR lpSubKey, LPSTR lpValue, LONG *lpcbValue);
STDAPI_(LONG) SHRegQueryValueW(HKEY hKey, LPCWSTR lpSubKey, LPWSTR lpValue, LONG *lpcbValue);

#ifdef UNICODE
#define SHRegQueryValue     SHRegQueryValueW
#else
#define SHRegQueryValue     SHRegQueryValueA
#endif

#ifdef DEBUG
#if 1
    __inline DWORD clockrate() {LARGE_INTEGER li; QueryPerformanceFrequency(&li); return li.LowPart;}
    __inline DWORD clock()     {LARGE_INTEGER li; QueryPerformanceCounter(&li);   return li.LowPart;}
#else
    __inline DWORD clockrate() {return 1000;}
    __inline DWORD clock()     {return GetTickCount();}
#endif

    #define TIMEVAR(t)    DWORD t ## T; DWORD t ## N
    #define TIMEIN(t)     t ## T = 0, t ## N = 0
    #define TIMESTART(t)  t ## T -= clock(), t ## N ++
    #define TIMESTOP(t)   t ## T += clock()
    #define TIMEFMT(t)    ((DWORD)(t) / clockrate()), (((DWORD)(t) * 1000 / clockrate())%1000)
    #define TIMEOUT(t)    if (t ## N) TraceMsg(TF_PERF, #t ": %ld calls, %ld.%03ld sec (%ld.%03ld)", t ## N, TIMEFMT(t ## T), TIMEFMT(t ## T / t ## N))
#else
    #define TIMEVAR(t)
    #define TIMEIN(t)
    #define TIMESTART(t)
    #define TIMESTOP(t)
    #define TIMEFMT(t)
    #define TIMEOUT(t)
#endif

// in extract.c
STDAPI_(DWORD) GetExeType(LPCTSTR pszFile);
STDAPI_(UINT)  ExtractIcons(LPCTSTR szFileName, int nIconIndex, int cxIcon, int cyIcon, HICON *phicon, UINT *piconid, UINT nIcons, UINT flags);

/*
in pickicon.c
Return Values for PickIconDlgWithTitle()

User Operation       Return Values
Cancel            -> HRESULT_FROM_WIN32(ERROR_CANCELLED) 
Ok                -> S_OK
RestoreDefault    -> S_FALSE
*/
STDAPI PickIconDlgWithTitle(HWND hwnd, LPCTSTR pszTitle, BOOL bShowRestoreButton, LPTSTR pszIconPath, UINT cbIconPath, int *piIconIndex);


// defxicon.c

STDAPI SHCreateDefExtIconKey(HKEY hkey, LPCTSTR pszModule, int iIcon, int iIconOpen, int iDefIcon, int iShortcutIcon, UINT uFlags, REFIID riid, void **pxiconOut);
STDAPI SHCreateDefExtIcon(LPCTSTR pszModule, int iIcon, int iIconOpen, UINT uFlags, int iDefIcon, REFIID riid, void **pxiconOut);


STDAPI_(UINT) SHSysErrorMessageBox(HWND hwnd, LPCTSTR pszTitle, UINT idTemplate, DWORD err, LPCTSTR pszParam, UINT dwFlags);

//======Hash Item=============================================================
typedef struct _HashTable **HHASHTABLE;
#define PHASHITEM LPCTSTR

typedef void (CALLBACK *HASHITEMCALLBACK)(HHASHTABLE hht, LPCTSTR sz, UINT wUsage, DWORD_PTR param);

STDAPI_(LPCTSTR) FindHashItem  (HHASHTABLE hht, LPCTSTR lpszStr);
STDAPI_(LPCTSTR) AddHashItem   (HHASHTABLE hht, LPCTSTR lpszStr);
STDAPI_(LPCTSTR) DeleteHashItem(HHASHTABLE hht, LPCTSTR lpszStr);
STDAPI_(LPCTSTR) PurgeHashItem (HHASHTABLE hht, LPCTSTR lpszStr);

#define     GetHashItemName(pht, sz, lpsz, cch)  lstrcpyn(lpsz, sz, cch)

HHASHTABLE  WINAPI CreateHashItemTable(UINT wBuckets, UINT wExtra);
void        WINAPI DestroyHashItemTable(HHASHTABLE hht);

void        WINAPI SetHashItemData(HHASHTABLE hht, LPCTSTR lpszStr, int n, DWORD_PTR dwData);
DWORD_PTR   WINAPI GetHashItemData(HHASHTABLE hht, LPCTSTR lpszStr, int n);
void *      WINAPI GetHashItemDataPtr(HHASHTABLE hht, LPCTSTR lpszStr);

void        WINAPI EnumHashItems(HHASHTABLE hht, HASHITEMCALLBACK callback, DWORD_PTR dwParam);

#ifdef DEBUG
void        WINAPI DumpHashItemTable(HHASHTABLE hht);
#endif


//======== Text thunking stuff ===========================================================
typedef struct _THUNK_TEXT_
{
    LPTSTR m_pStr[1];
} ThunkText;

#ifdef UNICODE
    typedef CHAR        XCHAR;
    typedef LPSTR       LPXSTR;
    typedef const XCHAR * LPCXSTR;
    #define lstrlenX(r) lstrlenA(r)
#else // unicode
    typedef WCHAR       XCHAR;
    typedef LPWSTR      LPXSTR;
    typedef const XCHAR * LPCXSTR;
    #define lstrlenX(r) lstrlenW(r)
#endif // unicode

ThunkText * ConvertStrings(UINT cCount, ...);

#include "uastrfnc.h"
#ifdef __cplusplus
}       /* End of extern "C" { */
#endif /* __cplusplus */

#include <help.h>


//======== Discriminate inclusion ========================================

#ifndef NO_INCLUDE_UNION        // define this to avoid including all
                                // of the extra files that were not
                                // previously included in shellprv.h
#include <wchar.h>
#include <tchar.h>

#include <process.h>
#include <wowshlp.h>
#include <vdmapi.h>
#include "shell.h"
#include "dde.h"
#include <regstr.h>
#include "findhlp.h"
#include <krnlcmn.h>
#include <dlgs.h>
#include <err.h>
#include <msprintx.h>
#include <pif.h>
#include <windisk.h>
#include <brfcasep.h>
#include <trayp.h>
#include <brfcasep.h>
#include <wutilsp.h>
#include "bitbuck.h"
#include "drawpie.h"
#include "fileop.h"
#include "pidl.h"
#include "ids.h"
#include <newexe.h>
#include "newres.h"
#include "ole2dup.h"
#include "os.h"
#include "privshl.h"
#include "reglist.h"
#include "shell32p.h"
#include "shitemid.h"
#include "undo.h"
#include "vdate.h"
#include "views.h"

// NT shell uses 32-bit version of this pifmgr code.
#ifndef NO_PIF_HDRS
#include "pifmgrp.h"
#include "piffntp.h"
#include "pifinfp.h"
#include "doshelp.h"
#include "machinep.h"   // Japanese domestic machine (NEC) support
#endif

#endif // NO_INCLUDE_UNION

#include "shdguid.h"

#define SetWindowBits SHSetWindowBits
#define IsSameObject SHIsSameObject
#define IsChildOrSelf SHIsChildOrSelf
#define MenuIndexFromID  SHMenuIndexFromID
#define _GetMenuFromID  SHGetMenuFromID
#define GetCurColorRes SHGetCurColorRes
#define WaitForSendMessageThread SHWaitForSendMessageThread

#define MAX_URL_STRING      INTERNET_MAX_URL_LENGTH

// Stack allocated BSTR (to avoid calling SysAllocString)
typedef struct _SA_BSTR {
    ULONG   cb;
    WCHAR   wsz[MAX_URL_STRING];
} SA_BSTR;

// A "fake" variants for use on the stack - usable for [in] parameters only!!!
typedef struct _SA_BSTRGUID {
    UINT  cb;
    WCHAR wsz[39];
} SA_BSTRGUID;
#define InitFakeBSTR(pSA_BSTR, guid) SHStringFromGUIDW((guid), (pSA_BSTR)->wsz, ARRAYSIZE((pSA_BSTR)->wsz)), (pSA_BSTR)->cb = (38*sizeof(WCHAR))

//
//  The cb field of a BSTR is the count of bytes, not including the
//  terminating L('\0').
//
//
//  DECLARE_CONST_BSTR - Goes into header file (if any)
//  DEFINE_CONST_BSTR  - Creates the variable, must already be declared
//  MAKE_CONST_BSTR    - Combines DECLARE and DEFINE
//
#define DECLARE_CONST_BSTR(name, str) \
 extern const struct BSTR##name { ULONG cb; WCHAR wsz[sizeof(str)/sizeof(WCHAR)]; } name

#define DEFINE_CONST_BSTR(name, str) \
        const struct BSTR##name name = { sizeof(str) - sizeof(WCHAR), str }

#define MAKE_CONST_BSTR(name, str) \
        const struct BSTR##name { ULONG cb; WCHAR wsz[sizeof(str)/sizeof(WCHAR)]; } \
                                name = { sizeof(str) - sizeof(WCHAR), str }

DECLARE_CONST_BSTR(s_sstrIDMember,         L"id");
DECLARE_CONST_BSTR(s_sstrSubSRCMember,     L"subscribed_url");
DECLARE_CONST_BSTR(s_sstrSRCMember,        L"src");

//======== Header file hacks =============================================================

//
//  The compiler will tell us if we are defining these NT5-only parameters
//  incorrectly.  If you get "invalid redefinition" errors, it means that
//  the definition in windows.h changed and we need to change to match.
//

#define ASFW_ANY    ((DWORD)-1)

#define CMIDM_LINK      0x0001
#define CMIDM_COPY      0x0002
#define CMIDM_MOVE      0x0003

// Downlevel shutdown dialog function
DWORD DownlevelShellShutdownDialog(HWND hwndParent, DWORD dwItems, LPCTSTR szUsername);

// from shell32\unicode\format.c
STDAPI_(DWORD) SHChkDskDriveEx(HWND hwnd, LPWSTR pszDrive);

//
// On NT, sometimes CreateDirectory succeeds in creating the directory, but, you can not do
// anything with it that directory. This happens if the directory name being created does
// not have room for an 8.3 name to be tagged onto the end of it,
// i.e., lstrlen(new_directory_name)+12 must be less or equal to MAX_PATH.
//
// the magic # "12" is 8 + 1 + 3 for and 8.3 name.
// 
// The following macro is used in places where we need to detect this to make
// MoveFile to be consistent with CreateDir(files  os.c and copy.c use this)
//

#define  IsDirPathTooLongForCreateDir(pszDir)    ((lstrlen(pszDir) + 12) > MAX_PATH)

// call the shlwapi version of this, note we have an export from shell32 that forwards to this
#define ShellMessageBoxW    ShellMessageBoxWrapW

#define REGSTR_EXPLORER_ADVANCED (REGSTR_PATH_EXPLORER TEXT("\\Advanced"))

#define RECTHEIGHT(rc) ((rc).bottom - (rc).top)
#define RECTWIDTH(rc) ((rc).right - (rc).left)

STDAPI_(BOOL) IsGuimodeSetupRunning();

#endif // _SHELLPRV_H_
