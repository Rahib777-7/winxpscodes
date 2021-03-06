
#include "stdafx.h"
#include "trapreg.h"
#include "lcsource.h"
#include "lcevents.h"

CTrapReg g_reg;

// The default value for the comma separator is a comma.  This is replaced by the
// thousands separator generated by GetNumberFormat.
TCHAR g_chThousandSep = _T(','); 

// An array of boolean value to indicate whether the columns of the source and events list controls
// should be sorted in ascending or descending order.
BOOL g_abLcSourceSortAscending[ICOL_LcSource_MAX] = {TRUE, TRUE, TRUE, TRUE};        
BOOL g_abLcEventsSortAscending[ICOL_LcEvents_MAX] = {TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE};


