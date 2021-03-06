// This is a part of the Microsoft Foundation Classes C++ library.
// Copyright (C) 1992-1995 Microsoft Corporation
// All rights reserved.
//
// This source code is only intended as a supplement to the
// Microsoft Foundation Classes Reference and related
// electronic documentation provided with the library.
// See these sources for detailed information regarding the
// Microsoft Foundation Classes product.

// STDAFX.H is the header that includes the standard includes that are used
//  for most of the project.  These are compiled into a pre-compiled header
#include "w4warn.h"
#pragma warning (disable:4706)  // assignment within conditional expression

#define _SHELL32_

#include <windows.h>
#include <windef.h>
#include <tchar.h>
#include <stddef.h>
#include <limits.h>
#include <malloc.h>
#include <new.h>

#include "ddraw.h"
#include <atlbase.h>
extern CComModule _Module;
#include <atlcom.h>
#include "ImgUtil.h"
#include "ocmm.h"
#include "ctngen.h"
#include "shlwapi.h"

#include "objbase.h"

#ifdef _DEBUG
void __cdecl TraceProc(DWORD lwLevel, CHAR *pszFormat, ...);
#define Trace	TraceProc
#else
#define Trace
#endif
#define TRACE0(sz)              Trace(-1,_T("%s"), _T(sz))
#define TRACE1(sz, p1)          Trace(-1,_T(sz), p1)
#define TRACE2(sz, p1, p2)      Trace(-1,_T(sz), p1, p2)
#define TRACE3(sz, p1, p2, p3)  Trace(-1,_T(sz), p1, p2, p3)

#ifndef EXPORT
#define EXPORT
#endif
