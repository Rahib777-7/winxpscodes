/*++

 Copyright (c) 2000 Microsoft Corporation

 Module Name:

    BizPlanBuilder.cpp

 Abstract:

    App does not repaint after a WM_SETTEXT message.

 Notes:
    
    This is an app specific shim.

 History:

    01/03/2001 linstev  Created

--*/

#include "precomp.h"

IMPLEMENT_SHIM_BEGIN(BizPlanBuilder)
#include "ShimHookMacro.h"

APIHOOK_ENUM_BEGIN
    APIHOOK_ENUM_ENTRY(SetWindowTextA) 
APIHOOK_ENUM_END

/*++

 Subclass the windowproc for this call and fix the pointer that comes out in 
 the WM_SETTEXT message that is generated by SetWindowTextA.

--*/

BOOL 
APIHOOK(SetWindowTextA)(
    HWND hWnd,         
    LPCSTR lpString   
    )
{
    BOOL bRet = ORIGINAL_API(SetWindowTextA)(hWnd, lpString);

    //
    // Redraw the window
    //

    InvalidateRect(hWnd, NULL, TRUE);

    return bRet;
}

/*++

 Register hooked functions

--*/

HOOK_BEGIN

    APIHOOK_ENTRY(USER32.DLL, SetWindowTextA)

HOOK_END

IMPLEMENT_SHIM_END

