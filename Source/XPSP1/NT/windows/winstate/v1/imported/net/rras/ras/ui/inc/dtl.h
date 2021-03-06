// Copyright (c) 1992, Microsoft Corporation, all rights reserved
//
// dtl.h
// Double-threaded linked list header
//
// 06/28/92 Steve Cobb

#ifndef _DTL_H_
#define _DTL_H_


#include <nouiutil.h>  // Heap definitions

// Forward declarations
//
typedef struct _DTLNODE DTLNODE;
typedef struct _DTLLIST DTLLIST;


// Double-threaded linked list node control block.  There is one node for each
// entry in a list.
//
// Applications should not access this structure directly.
//
typedef struct
_DTLNODE
{
    DTLNODE* pdtlnodePrev; // Address of previous node or NULL if none
    DTLNODE* pdtlnodeNext; // Address of next node or NULL if none
    VOID*    pData;        // Address of user's data
    LONG_PTR lNodeId;      // User-defined node identification code
}
DTLNODE;


// Double-threaded linked list control block.  There is one for each list.
//
// Applications should not access this structure directly.
//
typedef struct
_DTLLIST
{
    DTLNODE* pdtlnodeFirst; // Address of first node or NULL if none
    DTLNODE* pdtlnodeLast;  // Address of last node or NULL if none
    LONG     lNodes;        // Number of nodes in list
    LONG_PTR lListId;       // User-defined list identification code
}
DTLLIST;


// List node duplication function.  See DuplicateList.
//
typedef DTLNODE* (*PDUPNODE)( IN DTLNODE* );

// List node free function.  See FreeList.
//
typedef VOID (*PDESTROYNODE)( IN DTLNODE* );

// List node comparison function.  See MergeSort.
//
typedef IN (*PCOMPARENODE)( IN DTLNODE*, IN DTLNODE* );


// Macros and function prototypes.
//
#define DtlGetData( pdtlnode )        ((pdtlnode)->pData)
#define DtlGetNodeId( pdtlnode )      ((pdtlnode)->lNodeId)
#define DtlGetFirstNode( pdtllist )   ((pdtllist)->pdtlnodeFirst)
#define DtlGetListId( pdtllist )      ((pdtllist)->lListId)
#define DtlGetNextNode( pdtlnode )    ((pdtlnode)->pdtlnodeNext)
#define DtlGetNodes( pdtllist )       ((pdtllist)->lNodes)
#define DtlGetPrevNode( pdtlnode )    ((pdtlnode)->pdtlnodePrev)
#define DtlGetLastNode( pdtllist )    ((pdtllist)->pdtlnodeLast)
#define DtlPutData( pdtlnode, p )     ((pdtlnode)->pData = (p))
#define DtlPutNodeId( pdtlnode, l )   ((pdtlnode)->lNodeId = (LONG )(l))
#define DtlPutListCode( pdtllist, l ) ((pdtllist)->lListId = (LONG )(l))

DTLNODE* DtlAddNodeAfter( DTLLIST*, DTLNODE*, DTLNODE* );
DTLNODE* DtlAddNodeBefore( DTLLIST*, DTLNODE*, DTLNODE* );
DTLNODE* DtlAddNodeFirst( DTLLIST*, DTLNODE* );
DTLNODE* DtlAddNodeLast( DTLLIST*, DTLNODE* );
DTLLIST* DtlCreateList( LONG );
DTLNODE* DtlCreateNode( VOID*, LONG_PTR );
DTLNODE* DtlCreateSizedNode( LONG, LONG_PTR );
VOID     DtlDestroyList( DTLLIST*, PDESTROYNODE );
VOID     DtlDestroyNode( DTLNODE* );
DTLNODE* DtlDeleteNode( DTLLIST*, DTLNODE* );
DTLLIST* DtlDuplicateList( DTLLIST*, PDUPNODE, PDESTROYNODE );
VOID     DtlMergeSort( DTLLIST*, PCOMPARENODE );
VOID     DtlSwapLists( DTLLIST*, DTLLIST* );

DTLNODE* DtlNodeFromIndex( DTLLIST*, LONG );
DTLNODE* DtlRemoveNode( DTLLIST*, DTLNODE* );


#endif // _DTL_H_
