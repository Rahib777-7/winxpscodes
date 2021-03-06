/*++

Copyright (c) 1992  Microsoft Corporation

Module Name:

    strings.h

Abstract:

    Contains all localizable strings for startup.com

Author:

    John Vert (jvert) 4-Jan-1994

Revision History:

    John Vert (jvert) 4-Jan-1994
        created

--*/

#define SU_NO_LOW_MEMORY \
" Windows NT คซๆง ฉค ฃๆคฆ %dK ซช ฃคใฃช low.  512k ซช ฃคใฃช low\n"  \
"ง ซฆ็คซ    ซค กซโขฉ ซเค Windows NT.  ฉเช ฎจ แซ  ค\n"       \
"คฃๅฉซ ซฆค ฌงฆขฆ ฉซใ ฉช ใ ค กซโขฉซ โค งจๆจฃฃ จ็ฃ ฉช\n" \
"งจฃโซจเค งฆฌ ฉช ๆก งๆ ซฆค กซฉกฌฉซใ\n"

#define SU_NO_EXTENDED_MEMORY \
" Windows NT ค คซๆง ฉค จกซใ ฃคใฃ extended.  7Mb ซช ฃคใฃช extended\n"       \
"ง ซฆ็คซ    ซค กซโขฉ ซเค Windows NT.  ฉเช ฎจ แซ  ค \n"                \
"คฃๅฉซ ซฆค ฌงฆขฆ ฉซใ ฉช ใ ค กซโขฉซ โค งจๆจฃฃ จ็ฃ ฉช\n"           \
"งจฃโซจเค งฆฌ ฉช ๆก งๆ ซฆค กซฉกฌฉซใ\n"                                   \
"\n\nง กๆค ฉ ฃคใฃช:\n"

#define SU_NTLDR_CORRUPT \
"ฆ NTLDR ๅค  กซฉซจฃฃโคฆ.  ฆ ฉ็ฉซฃ ค ฃงฆจๅ ค ฅก คใฉ ."

#define PG_FAULT_MSG    " ===================   ============================= \n\n"
#define DBL_FAULT_MSG   " ====================   ============================== \n\n"
#define GP_FAULT_MSG    " ==============    ======================== \n\n"
#define STK_OVERRUN_MSG " =====    ใ   =========== \n\n"
#define EX_FAULT_MSG    " =====================  ================================= \n\n"
#define DEBUG_EXCEPTION "\N      "
#define PG_FAULT_ADDRESS "** ซ จฃฃ กใ  ็ฌคฉ %lx\n"
