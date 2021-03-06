/******************************Module*Header*******************************\
* Module Name: fastdib.h
*
* CreateCompatibleDIB definitions.
*
* Created: 02-Feb-1996 19:30:45
* Author: Gilman Wong [gilmanw]
*
* Copyright (c) 1995 Microsoft Corporation
*
\**************************************************************************/

/*
This application draws a spinning RGB color cube into a bitmap and
copies this bitmap to the display window, demonstrating the use
of optimized DIBs with OpenGL.  Note that pressing any of the number
keys from 2-9 while the app is running will set a zoom factor which
will cause the app to shrink the bitmap and to use StretchBlt to copy
the bitmap to the display.

The FastDIB API functions are implemented in fastdib.c.  It is
merely an interface layer to existing Win32 functions.  It goal is
to encapsulate some of the complexity of determing formats, initializing
color tables, etc.

Note that use of optimized DIBs on palettized (i.e., 8bpp) display devices
on OpenGL/95 version 1.0 is broken.  If running on Win95, the following
line in timecube.c should be commented out:

    #define _COMPATIBLE_DIB_FIX_

------------------------------------------------------------------------------

CreateCompatibleDIB
-------------------

HBITMAP APIENTRY CreateCompatibleDIB(hdc, hpal, ulWidth, ulHeight, ppvBits)
HDC hdc;
HPALETTE hpal;
ULONG ulWidth;
ULONG ulHeight;
PVOID *ppvBits;

Create a DIB section bitmap with an optimized format with respect to the
specified display DC.  Optimized in this case means that the bitmap format
(and palette, if applicable) are matched to the display and will ensure
the highest possible Blt performance.

Parameters

    hdc

        Specifies display DC used to determine format.  If hpal is NULL,
        this hdc is used to retrieve the system palette entries with which
        the DIB color table is initialized (on palettized display devices
        only).

    hpal

        Optional palette that, if specified, is used to initialize the DIB
        color table.  If NULL, the system palette is used.  Ignored for
        non-palettized display devices.

    ulWidth

        Specifies the width of the bitmap.

    ulHeight

        Specifies the height of the bitmap.

    ppvBits

        Returns a pointer to the DIB section bits with which the application
        can draw directly into the bitmap.

Return Value

    The return value is the handle to the bitmap created.  If the function
    fails, the return value is NULL.

------------------------------------------------------------------------------

UpdateDIBColorTable
-------------------

BOOL APIENTRY UpdateDIBColorTable(hdcMem, hdc, hpal)
HDC hdcMem;
HDC hdc;
HPALETTE hpal;

Synchronize the color table of DIB bitmap selected into the specified
memory DC with either the current system palette or the optionally
specified logical palette.

This function need only be invoked on palettized display devices.

Parameters

    hdcMem

        Specified the memory DC into which the DIB of interest is selected.

    hdc

        Specifies the display DC for which the DIB is formatted.  If hpal
        is NULL this hdc is used to retrieve the system palette entries
        with which the DIB color table is initialized (on palettized display
        devices only).

    hpal

        Optional palette that, if specified, is used to initialize the DIB
        color table.  If NULL, the system palette is used.  Ignored for
        non-palettized display devices.

Return Value

    The return value is TRUE if the DIB color table is successfully updated.
    If the function fails, the return value is FALSE.

Comments

    Typically, this function is called only if the logical palette in the
    display DC changes.  For OpenGL apps, the logical palette is set only
    once for RGB modes, which implies that this function normally does not
    need to be used with RGB modes.  Color index modes, however, may change
    the logical palette at any time.  If that happens, then the application
    should invoke this function after the new palette has been realized.

------------------------------------------------------------------------------

GetCompatibleDIBInfo
--------------------

BOOL APIENTRY GetCompatibleDIBInfo(hbm, ppvBase, plStride)
HBITMAP hbm;
PVOID *ppvBase;
LONG *plStride;

Returns information about the specified DIB section that allows the
application to compute the address of a desired (x, y) pixel within
the bitmap.

Parameters

    hbm

        Specifies the DIB section bitmap of interest.

    ppvBase

        Returns a pointer to the origin of the bitmap.  If the DIB
        is top-down, then this is the same as the ppvBits returned
        by the intial call to CreateCompatibleDIB.  The default,
        however, is bottom-up.

    plStride

        Returns the stride or pitch of the bitmap (i.e., the difference
        in address between two vertically adjacent pixels).  If the bitmap
        is top-down, this value is positive; if the bitmap is bottom-up,
        this value is negative.

Return Value

    The return value is TRUE if the DIB color table is successfully updated.
    If the function fails, the return value is FALSE.

Comments

    The ppvBase and plStride value returned will allow the application to
    compute the address any given pixel (x, y) in the bitmap as follows:

    PIXEL *ppix;

    ppix = (PIXEL *) (((BYTE *)*ppvBase) + (y * *plStride) + (x * sizeof(PIXEL)));

------------------------------------------------------------------------------

GetDIBTranslationVector
-----------------------

BOOL APIENTRY GetDIBTranslationVector(HDC hdcMem, HPALETTE hpal, BYTE *pbVector)
HDC hdcMem;
HPALETTE hpal;
BYTE *pbVector;

Returns the translation vector that maps colors in the specified palette,
hpal, to the DIB selected into the specified DC, hdcMem.  This information
is needed so that applications that draw directly into the DIB can translate
the logical color indices into physical bitmap indices.

This function should only be invoked on palettized display devices.

Parameters

    hdcMem

        Specified the memory DC into which the DIB of interest is selected.

    hpal

        Specifies the logical palette which will be mapped to the DIB.

    pbVector

        Points to a buffer into which the translation vector will be copied.

Return Value

    The return value is TRUE if the DIB color table is successfully updated.
    If the function fails, the return value is FALSE.


Comments

    This function does not try to validate the buffer size.  It is up to
    the application to allocate enough memory for the call.  The amount of
    memory required in bytes equal in value to the number of entries
    in the logical palette:

        bufferSize = GetPaletteEntries(hpal, 0, 1, NULL) * sizeof(BYTE);

*/

#ifndef SERVICES__FastDib_h__INCLUDED
#define SERVICES__FastDib_h__INCLUDED

HBITMAP APIENTRY CreateCompatibleDIB(HDC hdc, HPALETTE hpal, ULONG ulWidth, ULONG ulHeight, PVOID *ppvBits, BITMAPINFOHEADER * pbmih = NULL);
BOOL APIENTRY UpdateDIBColorTable(HDC hdcMem, HDC hdc, HPALETTE hpal);
BOOL APIENTRY GetCompatibleDIBInfo(HBITMAP hbm, PVOID *ppvBase, LONG *plStride);
BOOL APIENTRY GetDIBTranslationVector(HDC hdcMem, HPALETTE hpal, BYTE *pbVector);

#endif //SERVICES__FastDib_h__INCLUDED
