
#include "priv.h"

#define DBCS_CHARSIZE   (2)

//  N versions of wsprintf and wvsprintf which take an output buffer size to prevent overflow
//  bugs.  Taken from the NT wsprintf source code.

//  _MBToWCS and _WCSToMB are actually macros which call ntrtl functions in the NT version.
int _MBToWCS(LPSTR pszIn, int cchIn, LPWSTR *ppwszOut)
{
    int cch = 0;
    int cbAlloc;

    if ((0 != cchIn) && (NULL != ppwszOut))
    {
        cchIn++;
        cbAlloc = cchIn * sizeof(WCHAR);

        *ppwszOut = (LPWSTR)LocalAlloc(LMEM_FIXED, cbAlloc);

        if (NULL != *ppwszOut)
        {
            cch = MultiByteToWideChar(CP_ACP, 0, pszIn, cchIn, *ppwszOut, cchIn);

            if (!cch)
            {
                LocalFree(*ppwszOut);
                *ppwszOut = NULL;
            }
            else
            {
                cch--;  //  Just return the number of characters
            }
        }
    }

    return cch;
}

int _WCSToMB(LPCWSTR pwszIn, int cchIn, LPSTR *ppszOut)
{
    int cch = 0;
    int cbAlloc;

    if ((0 != cchIn) && (NULL != ppszOut))
    {
        cchIn++;
        cbAlloc = cchIn * DBCS_CHARSIZE;

        *ppszOut = (LPSTR)LocalAlloc(LMEM_FIXED, cbAlloc);

        if (NULL != *ppszOut)
        {
            cch = WideCharToMultiByte(CP_ACP, 0, pwszIn, cchIn,
                                      *ppszOut, cbAlloc, NULL, NULL);

            if (!cch)
            {
                LocalFree(*ppszOut);
                *ppszOut = NULL;
            }
            else
            {
                cch--;  //  Just return the number of characters
            }
        }
    }

    return cch;
}

/****************************** Module Header ******************************\
* Module Name: wsprintf.c
*
* Copyright (c) 1985-91, Microsoft Corporation
*  sprintf.c
*
*  Implements Windows friendly versions of sprintf and vsprintf
*
*  History:
*   2-15-89  craigc     Initial
*  11-12-90  MikeHar    Ported from windows 3
\***************************************************************************/

/* Max number of characters. Doesn't include termination character */

#define out(c) if (cchLimit) {*lpOut++=(c); cchLimit--;} else goto errorout

/***************************************************************************\
* SP_PutNumber
*
* Takes an unsigned long integer and places it into a buffer, respecting
* a buffer limit, a radix, and a case select (upper or lower, for hex).
*
*
* History:
*  11-12-90  MikeHar    Ported from windows 3 asm --> C
*  12-11-90  GregoryW   need to increment lpstr after assignment of mod
\***************************************************************************/

int SP_PutNumber(
    LPSTR lpstr,
    ULONG64 n,
    int   limit,
    DWORD radix,
    int   uppercase,
    int   *pcch)
{
    DWORD mod;
    *pcch = 0;

    /* It might not work for some locales or digit sets */
    if(uppercase)
        uppercase =  'A'-'0'-10;
    else
        uppercase = 'a'-'0'-10;

    if (limit) {
        do  {
            mod =  (ULONG)(n % radix);
            n /= radix;

            mod += '0';
            if (mod > '9')
                mod += uppercase;
            *lpstr++ = (char)mod;
            (*pcch)++;
        } while((*pcch < limit) && n);
    }

    return (n == 0) && (*pcch > 0);
}

/***************************************************************************\
* SP_Reverse
*
*  reverses a string in place
*
* History:
*  11-12-90  MikeHar    Ported from windows 3 asm --> C
*  12-11-90  GregoryW   fixed boundary conditions; removed count
\***************************************************************************/

void SP_Reverse(
    LPSTR lpFirst,
    LPSTR lpLast)
{
    char ch;

    while(lpLast > lpFirst){
        ch = *lpFirst;
        *lpFirst++ = *lpLast;
        *lpLast-- = ch;
    }
}

/***************************************************************************\
* SP_GetFmtValue
*
*  reads a width or precision value from the format string
*
* History:
*  11-12-90  MikeHar    Ported from windows 3
\***************************************************************************/

LPCSTR SP_GetFmtValue(
    LPCSTR lpch,
    int *lpw)
{
    int ii = 0;

    /* It might not work for some locales or digit sets */
    while (*lpch >= '0' && *lpch <= '9') {
        ii *= 10;
        ii += (int)(*lpch - '0');
        lpch++;
    }

    *lpw = ii;

    /*
     * return the address of the first non-digit character
     */
    return lpch;
}

/***************************************************************************\
* SP_GetFmtValueW
*
*  reads a width or precision value from the format string
*
* History:
*  11-12-90  MikeHar    Ported from windows 3
*  07-27-92  GregoryW   Created Unicode version (copied from SP_GetFmtValue)
\***************************************************************************/

LPCWSTR SP_GetFmtValueW(
    LPCWSTR lpch,
    int *lpw)
{
    int ii = 0;

    /* It might not work for some locales or digit sets */
    while (*lpch >= L'0' && *lpch <= L'9') {
        ii *= 10;
        ii += (int)(*lpch - L'0');
        lpch++;
    }

    *lpw = ii;

    /*
     * return the address of the first non-digit character
     */
    return lpch;
}

/***************************************************************************\
* wvsprintfA (API)
*
* Windows version of vsprintf().  Does not support floating point or
* pointer types, and all strings are assumed to be FAR.  Supports only
* the left alignment flag.
*
* Takes pointers to an output buffer, where the string is built, a
* pointer to an input buffer, and a pointer to a list of parameters.
*
* The cdecl function wnsprintf() calls this function.
*
* History:
* 11-12-90 MikeHar      Ported from windows 3
* 12-11-90 GregoryW     after %d format is parsed lpParms needs to be aligned
*                       to a dword boundary.
* 09-Aug-1991 mikeke    no it doesn't
* 11-19-91 DarrinM      Now wvsprintf and wsprintf treat parameters the same
*                       (as if they originated from a DWORD-aligned stack).
* 1-22-97 tnoonan       Converted to wvnsprintfA
\***************************************************************************/

LWSTDAPI_(int) wvnsprintfA(
    LPSTR lpOut,
    int cchLimitIn,
    LPCSTR lpFmt,
    va_list arglist)
{
    BOOL fAllocateMem = FALSE;
    char prefix, fillch;
    int left, width, prec, size, sign, radix, upper, hprefix;
    int cchLimit = --cchLimitIn, cch, cchAvailable;
    LPSTR lpT, lpTMB = NULL;
    LPWSTR pwsz;
    va_list varglist = arglist;
    union {
        LONG64 l;
        ULONG64 ul;
        char sz[2];
        WCHAR wsz[2];
    } val;

    if (cchLimit < 0)
        return 0;

    while (*lpFmt != 0) {
        if (*lpFmt == '%') {

            /*
             * read the flags.  These can be in any order
             */
            left = 0;
            prefix = 0;
            while (*++lpFmt) {
                if (*lpFmt == '-')
                    left++;
                else if (*lpFmt == '#')
                    prefix++;
                else
                    break;
            }

            /*
             * find fill character
             */
            if (*lpFmt == '0') {
                fillch = '0';
                lpFmt++;
            } else
                fillch = ' ';

            /*
             * read the width specification
             */
            lpFmt = SP_GetFmtValue((LPCSTR)lpFmt, &cch);
            width = cch;

            /*
             * read the precision
             */
            if (*lpFmt == '.') {
                lpFmt = SP_GetFmtValue((LPCSTR)++lpFmt, &cch);
                prec = cch;
            } else
                prec = -1;

            /*
             * get the operand size
             * default size: size == 0
             * long number:  size == 1
             * wide chars:   size == 2
             * 64bit number: size == 3
             * It may be a good idea to check the value of size when it
             * is tested for non-zero below (IanJa)
             */
            hprefix = 0;
            if (*lpFmt == 'w') {
                size = 2;
                lpFmt++;
            } else if (*lpFmt == 'l') {
                size = 1;
                lpFmt++;
            } else if (*lpFmt == 't') {
                size = 0;
                lpFmt++;
            } else if (*lpFmt == 'I') {
                if (*(lpFmt+1) == '3' && *(lpFmt+2) == '2') {
                    size = 1;
                    lpFmt += 3;
                } else if (*(lpFmt+1) == '6' && *(lpFmt+2) == '4') {
                    size = 3;
                    lpFmt += 3;
                } else {
                    size = (sizeof(INT_PTR) == sizeof(LONG)) ? 1 : 3;
                    lpFmt++;
                }
            } else {
                size = 0;
                if (*lpFmt == 'h') {
                    lpFmt++;
                    hprefix = 1;
                } else if ((*lpFmt == 'i') || (*lpFmt == 'd')) {
                    // %i or %d specified (no modifiers) - use long
                    // %u seems to have always been short - leave alone
                    size = 1;
                }
            }

            upper = 0;
            sign = 0;
            radix = 10;

            switch (*lpFmt) {
            case 0:
                goto errorout;

            case 'i':
            case 'd':
                sign++;

                /*** FALL THROUGH to case 'u' ***/

            case 'u':
                /* turn off prefix if decimal */
                prefix = 0;
donumeric:
                /* special cases to act like MSC v5.10 */
                if (left || prec >= 0)
                    fillch = ' ';

                /*
                 * if size == 1, "%lu" was specified (good);
                 * if size == 2, "%wu" was specified (bad)
                 * if size == 3, "%p" was specified
                 */
                if (size == 3) {
                    val.l = va_arg(varglist, LONG64);
                } else if (size) {
                    val.l = va_arg(varglist, long);
                } else if (sign) {
                    val.l = (long)va_arg(varglist, short);
                } else {
                    val.ul = va_arg(varglist, unsigned);
                }

                if (sign && val.l < 0L)
                    val.l = -val.l;
                else
                    sign = 0;

                /*
                 * Unless printing a full 64-bit value, ensure values
                 * here are not in canonical longword format to prevent
                 * the sign extended upper 32-bits from being printed.
                 */
                if (size != 3) {
                    val.l &= MAXDWORD;
                }

                lpT = lpOut;

                /*
                 * blast the number backwards into the user buffer
                 * SP_PutNumber returns false if it runs out of space
                 */
                if (!SP_PutNumber(lpOut, val.l, cchLimit, radix, upper, &cch))
                {
                    break;
                }

                //  Now we have the number backwards, calculate how much
                //  more buffer space we'll need for this number to
                //  format correctly.
                cchAvailable = cchLimit - cch;

                width -= cch;
                prec -= cch;
                if (prec > 0)
                {
                    width -= prec;
                    cchAvailable -= prec;
                }

                if (width > 0)
                {
                    cchAvailable -= width - (sign ? 1 : 0);
                }

                if (sign)
                {
                    cchAvailable--;
                }

                if (cchAvailable < 0)
                {
                    break;
                }

                //  We have enough space to format the buffer as requested
                //  without overflowing.

                lpOut += cch;
                cchLimit -= cch;

                /*
                 * fill to the field precision
                 */
                while (prec-- > 0)
                    out('0');

                if (width > 0 && !left) {
                    /*
                     * if we're filling with spaces, put sign first
                     */
                    if (fillch != '0') {
                        if (sign) {
                            sign = 0;
                            out('-');
                            width--;
                        }

                        if (prefix) {
                            out(prefix);
                            out('0');
                            prefix = 0;
                        }
                    }

                    if (sign)
                        width--;

                    /*
                     * fill to the field width
                     */
                    while (width-- > 0)
                        out(fillch);

                    /*
                     * still have a sign?
                     */
                    if (sign)
                        out('-');

                    if (prefix) {
                        out(prefix);
                        out('0');
                    }

                    /*
                     * now reverse the string in place
                     */
                    SP_Reverse(lpT, lpOut - 1);
                } else {
                    /*
                     * add the sign character
                     */
                    if (sign) {
                        out('-');
                        width--;
                    }

                    if (prefix) {
                        out(prefix);
                        out('0');
                    }

                    /*
                     * reverse the string in place
                     */
                    SP_Reverse(lpT, lpOut - 1);

                    /*
                     * pad to the right of the string in case left aligned
                     */
                    while (width-- > 0)
                        out(fillch);
                }
                break;

            case 'p':
                size = (sizeof(PVOID) == sizeof(LONG)) ? 1 : 3;
                if (prec == -1) {
                    prec = 2 * sizeof(PVOID);
                }

                /*** FALL THROUGH to case 'X' ***/

            case 'X':
                upper++;

                /*** FALL THROUGH to case 'x' ***/

            case 'x':
                radix = 16;
                if (prefix)
                    if (upper)
                        prefix = 'X';
                    else
                        prefix = 'x';
                goto donumeric;

            case 'C':
                /*
                 * explicit size specifier overrides case
                 */
                if (!size && !hprefix) {
                    size = 1;           // force WCHAR
                }

                /*** FALL THROUGH to case 'c' ***/

            case 'c':
                /*
                 * if size == 0, "%c" or "%hc" or "%tc" was specified (CHAR)
                 * if size == 1, "%C" or "%lc" was specified (WCHAR);
                 * if size == 2, "%wc" was specified (WCHAR)
                 */
                cch = 1; /* One character must be copied to the output buffer */
                if (size) {
                    val.wsz[0] = va_arg(varglist, WCHAR);
                    val.wsz[1] = 0x0000;
                    pwsz = val.wsz;
                    goto putwstring;
                } else {
                    val.sz[0] = va_arg(varglist, CHAR);
                    val.sz[1] = 0;
                    lpT = val.sz;
                    goto putstring;
                }

            case 'S':
                /*
                 * explicit size specifier overrides case
                 */
                if (!size && !hprefix) {
                    size = 1;           // force LPWSTR
                }

                /*** FALL THROUGH to case 's' ***/

            case 's':
                /*
                 * if size == 0, "%s" or "%hs" or "%ts" was specified (LPSTR);
                 * if size == 1, "%S" or "%ls" was specified (LPWSTR);
                 * if size == 2, "%ws" was specified (LPWSTR)
                 */
                if (size) {
                    pwsz = va_arg(varglist, LPWSTR);
                    if (pwsz == NULL) {
                        cch = 0;
                    } else {
                        cch = wcslen(pwsz);
                    }
putwstring:
                    cch = _WCSToMB(pwsz, cch, &lpTMB);
                    fAllocateMem = (BOOL) cch;
                    lpT = lpTMB;
                } else {
                    lpT = va_arg(varglist, LPSTR);
                    if (lpT == NULL) {
                        cch = 0;
                    } else {
                        cch = strlen(lpT);
                    }
                }
putstring:
                if (prec >= 0 && cch > prec)
                    cch = prec;
                width -= cch;

                if (left) {
                    while (cch--)
                        out(*lpT++);
                    while (width-- > 0)
                        out(fillch);
                } else {
                    while (width-- > 0)
                        out(fillch);
                    while (cch--)
                        out(*lpT++);
                }

                if (fAllocateMem) {
                     LocalFree(lpTMB);
                     fAllocateMem = FALSE;
                }
                break;

            default:
normalch:
                if (IsDBCSLeadByte(*lpFmt)) {
                    out(*lpFmt++);
                    if (!*lpFmt)
                        break;      // lead byte with no trail byte
                }
                out(*lpFmt);
                break;
            }  /* END OF SWITCH(*lpFmt) */
        }  /* END OF IF(%) */ else
            goto normalch;  /* character not a '%', just do it */

        /*
         * advance to next format string character
         */
        lpFmt++;
    }  /* END OF OUTER WHILE LOOP */

errorout:
    *lpOut = 0;

    if (fAllocateMem)
    {
        LocalFree(lpTMB);
    }

    return cchLimitIn - cchLimit;
}

/***************************************************************************\
* StringPrintfA (API)
*
* Windows version of sprintf
*
* History:
* 11-12-90 MikeHar      Ported from windows 3
* 02-05-90 DarrinM      Cleaned up with STDARG.h vararg stuff.
* 1-22-97 tnoonan       Converted to wnsprintfA
\***************************************************************************/

LWSTDAPIV_(int) wnsprintfA(
    LPSTR lpOut,
    int cchLimitIn,
    LPCSTR lpFmt,
    ...)
{
    va_list arglist;
    int ret;

    va_start(arglist, lpFmt);
    ret = wvnsprintfA(lpOut, cchLimitIn, lpFmt, arglist);
    va_end(arglist);
    return ret;
}

/***************************************************************************\
* SP_PutNumberW
*
* Takes an unsigned long integer and places it into a buffer, respecting
* a buffer limit, a radix, and a case select (upper or lower, for hex).
*
*
* History:
*  11-12-90  MikeHar    Ported from windows 3 asm --> C
*  12-11-90  GregoryW   need to increment lpstr after assignment of mod
*  02-11-92  GregoryW   temporary version until we have C runtime support
\***************************************************************************/

int SP_PutNumberW(
    LPWSTR lpstr,
    ULONG64 n,
    int   limit,
    DWORD radix,
    int   uppercase,
    int   *pcch)
{
    DWORD mod;
    *pcch = 0;

    /* It might not work for some locales or digit sets */
    if(uppercase)
        uppercase =  'A'-'0'-10;
    else
        uppercase = 'a'-'0'-10;

    if (limit) {
        do  {
            mod =  (ULONG)(n % radix);
            n /= radix;

            mod += '0';
            if (mod > '9')
            mod += uppercase;
            *lpstr++ = (WCHAR)mod;
            (*pcch)++;
        } while((*pcch < limit) && n);
    }

    return (n == 0) && (*pcch > 0);
}

/***************************************************************************\
* SP_ReverseW
*
*  reverses a string in place
*
* History:
*  11-12-90  MikeHar    Ported from windows 3 asm --> C
*  12-11-90  GregoryW   fixed boundary conditions; removed count
*  02-11-92  GregoryW   temporary version until we have C runtime support
\***************************************************************************/

void SP_ReverseW(
    LPWSTR lpFirst,
    LPWSTR lpLast)
{
    WCHAR ch;

    while(lpLast > lpFirst){
        ch = *lpFirst;
        *lpFirst++ = *lpLast;
        *lpLast-- = ch;
    }
}


/***************************************************************************\
* wvsprintfW (API)
*
* wsprintfW() calls this function.
*
* History:
*    11-Feb-1992 GregoryW copied xwvsprintf
*         Temporary hack until we have C runtime support
* 1-22-97 tnoonan       Converted to wvnsprintfW
\***************************************************************************/

LWSTDAPI_(int) wvnsprintfW(
    LPWSTR lpOut,
    int cchLimitIn,
    LPCWSTR lpFmt,
    va_list arglist)
{
    BOOL fAllocateMem = FALSE;
    WCHAR prefix, fillch;
    int left, width, prec, size, sign, radix, upper, hprefix;
    int cchLimit = --cchLimitIn, cch, cchAvailable;
    LPWSTR lpT, lpTWC = NULL;
    LPBYTE psz;
    va_list varglist = arglist;
    union {
        LONG64 l;
        ULONG64 ul;
        char sz[2];
        WCHAR wsz[2];
    } val;

    if (cchLimit < 0)
        return 0;

    while (*lpFmt != 0) {
        if (*lpFmt == L'%') {

            /*
             * read the flags.  These can be in any order
             */
            left = 0;
            prefix = 0;
            while (*++lpFmt) {
                if (*lpFmt == L'-')
                    left++;
                else if (*lpFmt == L'#')
                    prefix++;
                else
                    break;
            }

            /*
             * find fill character
             */
            if (*lpFmt == L'0') {
                fillch = L'0';
                lpFmt++;
            } else
                fillch = L' ';

            /*
             * read the width specification
             */
            lpFmt = SP_GetFmtValueW(lpFmt, &cch);
            width = cch;

            /*
             * read the precision
             */
            if (*lpFmt == L'.') {
                lpFmt = SP_GetFmtValueW(++lpFmt, &cch);
                prec = cch;
            } else
                prec = -1;

            /*
             * get the operand size
             * default size: size == 0
             * long number:  size == 1
             * wide chars:   size == 2
             * 64bit number: size == 3
             * It may be a good idea to check the value of size when it
             * is tested for non-zero below (IanJa)
             */
            hprefix = 0;
            if ((*lpFmt == L'w') || (*lpFmt == L't')) {
                size = 2;
                lpFmt++;
            } else if (*lpFmt == L'l') {
                size = 1;
                lpFmt++;
            } else if (*lpFmt == L'I') {
                if (*(lpFmt+1) == L'3' && *(lpFmt+2) == L'2') {
                    size = 1;
                    lpFmt += 3;
                } else if (*(lpFmt+1) == L'6' && *(lpFmt+2) == L'4') {
                    size = 3;
                    lpFmt += 3;
                } else {
                    size = (sizeof(INT_PTR) == sizeof(LONG)) ? 1 : 3;
                    lpFmt++;
                }
            } else {
                size = 0;
                if (*lpFmt == L'h') {
                    lpFmt++;
                    hprefix = 1;
                } else if ((*lpFmt == L'i') || (*lpFmt == L'd')) {
                    // %i or %d specified (no modifiers) - use long
                    // %u seems to have always been short - leave alone
                    size = 1;
                }
            }

            upper = 0;
            sign = 0;
            radix = 10;

            switch (*lpFmt) {
            case 0:
                goto errorout;

            case L'i':
            case L'd':
                sign++;

                /*** FALL THROUGH to case 'u' ***/

            case L'u':
                /* turn off prefix if decimal */
                prefix = 0;
donumeric:
                /* special cases to act like MSC v5.10 */
                if (left || prec >= 0)
                    fillch = L' ';

                /*
                 * if size == 1, "%lu" was specified (good);
                 * if size == 2, "%wu" was specified (bad)
                 * if size == 3, "%p" was specified
                 */
                if (size == 3) {
                    val.l = va_arg(varglist, LONG64);
                } else if (size) {
                    val.l = va_arg(varglist, LONG);
                } else if (sign) {
                    val.l = va_arg(varglist, SHORT);
                } else {
                    val.ul = va_arg(varglist, unsigned);
                }

                if (sign && val.l < 0L)
                    val.l = -val.l;
                else
                    sign = 0;

                /*
                 * Unless printing a full 64-bit value, ensure values
                 * here are not in canonical longword format to prevent
                 * the sign extended upper 32-bits from being printed.
                 */
                if (size != 3) {
                    val.l &= MAXDWORD;
                }

                lpT = lpOut;

                /*
                 * blast the number backwards into the user buffer
                 * SP_PutNumberW returns FALSE if it runs out of space
                 */
                if (!SP_PutNumberW(lpOut, val.l, cchLimit, radix, upper, &cch))
                {
                    break;
                }

                //  Now we have the number backwards, calculate how much
                //  more buffer space we'll need for this number to
                //  format correctly.
                cchAvailable = cchLimit - cch;

                width -= cch;
                prec -= cch;
                if (prec > 0)
                {
                    width -= prec;
                    cchAvailable -= prec;
                }

                if (width > 0)
                {
                    cchAvailable -= width - (sign ? 1 : 0);
                }

                if (sign)
                {
                    cchAvailable--;
                }

                if (cchAvailable < 0)
                {
                    break;
                }

                //  We have enough space to format the buffer as requested
                //  without overflowing.

                lpOut += cch;
                cchLimit -= cch;

                /*
                 * fill to the field precision
                 */
                while (prec-- > 0)
                    out(L'0');

                if (width > 0 && !left) {
                    /*
                     * if we're filling with spaces, put sign first
                     */
                    if (fillch != L'0') {
                        if (sign) {
                            sign = 0;
                            out(L'-');
                            width--;
                        }

                        if (prefix) {
                            out(prefix);
                            out(L'0');
                            prefix = 0;
                        }
                    }

                    if (sign)
                        width--;

                    /*
                     * fill to the field width
                     */
                    while (width-- > 0)
                        out(fillch);

                    /*
                     * still have a sign?
                     */
                    if (sign)
                        out(L'-');

                    if (prefix) {
                        out(prefix);
                        out(L'0');
                    }

                    /*
                     * now reverse the string in place
                     */
                    SP_ReverseW(lpT, lpOut - 1);
                } else {
                    /*
                     * add the sign character
                     */
                    if (sign) {
                        out(L'-');
                        width--;
                    }

                    if (prefix) {
                        out(prefix);
                        out(L'0');
                    }

                    /*
                     * reverse the string in place
                     */
                    SP_ReverseW(lpT, lpOut - 1);

                    /*
                     * pad to the right of the string in case left aligned
                     */
                    while (width-- > 0)
                        out(fillch);
                }
                break;

            case L'p':
                size = (sizeof(PVOID) == sizeof(LONG)) ? 1 : 3;
                if (prec == -1) {
                    prec = 2 * sizeof(PVOID);
                }

                /*** FALL THROUGH to case 'X' ***/

            case L'X':
                upper++;

                /*** FALL THROUGH to case 'x' ***/

            case L'x':
                radix = 16;
                if (prefix)
                    if (upper)
                        prefix = L'X';
                    else
                        prefix = L'x';
                goto donumeric;

            case L'c':
                if (!size && !hprefix) {
                    size = 1;           // force WCHAR
                }

                /*** FALL THROUGH to case 'C' ***/

            case L'C':
                /*
                 * if size == 0, "%C" or "%hc" was specified (CHAR);
                 * if size == 1, "%c" or "%lc" was specified (WCHAR);
                 * if size == 2, "%wc" or "%tc" was specified (WCHAR)
                 */
                cch = 1; /* One character must be copied to the output buffer */
                if (size) {
                    val.wsz[0] = va_arg(varglist, WCHAR);
                    val.wsz[1] = 0;
                    lpT = val.wsz;
                    goto putwstring;
                } else {
                    val.sz[0] = va_arg(varglist, CHAR);
                    val.sz[1] = 0;
                    psz = val.sz;
                    goto putstring;
                }

            case L's':
                if (!size && !hprefix) {
                    size = 1;           // force LPWSTR
                }

                /*** FALL THROUGH to case 'S' ***/

            case L'S':
                /*
                 * if size == 0, "%S" or "%hs" was specified (LPSTR)
                 * if size == 1, "%s" or "%ls" was specified (LPWSTR);
                 * if size == 2, "%ws" or "%ts" was specified (LPWSTR)
                 */
                if (size) {
                    lpT = va_arg(varglist, LPWSTR);
                    if (lpT == NULL) {
                        cch = 0;
                    } else {
                        cch = wcslen(lpT);
                    }
                } else {
                    psz = va_arg(varglist, LPBYTE);
                    if (psz == NULL) {
                        cch = 0;
                    } else {
                        cch = strlen(psz);
                    }
putstring:
                    cch = _MBToWCS(psz, cch, &lpTWC);
                    fAllocateMem = (BOOL) cch;
                    lpT = lpTWC;
                }
putwstring:
                if (prec >= 0 && cch > prec)
                    cch = prec;
                width -= cch;

                if (left) {
                    while (cch--)
                        out(*lpT++);
                    while (width-- > 0)
                        out(fillch);
                } else {
                    while (width-- > 0)
                        out(fillch);
                    while (cch--)
                        out(*lpT++);
                }

                if (fAllocateMem) {
                     LocalFree(lpTWC);
                     fAllocateMem = FALSE;
                }

                break;

            default:
normalch:
                out((WCHAR)*lpFmt);
                break;
            }  /* END OF SWITCH(*lpFmt) */
        }  /* END OF IF(%) */ else
            goto normalch;  /* character not a '%', just do it */

        /*
         * advance to next format string character
         */
        lpFmt++;
    }  /* END OF OUTER WHILE LOOP */

errorout:
    *lpOut = 0;

    if (fAllocateMem)
    {
        LocalFree(lpTWC);
    }

    return cchLimitIn - cchLimit;
}

LWSTDAPIV_(int) wnsprintfW(
    LPWSTR lpOut,
    int cchLimitIn,
    LPCWSTR lpFmt,
    ...)
{
    va_list arglist;
    int ret;

    va_start(arglist, lpFmt);
    ret = wvnsprintfW(lpOut, cchLimitIn, lpFmt, arglist);
    va_end(arglist);
    return ret;
}
