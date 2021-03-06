//
//  REGFFMT.H
//
//  Copyright (C) Microsoft Corporation, 1995
//
//  Defines the physical format of a Windows VMM registry file.
//

#ifndef _REGFFMT_
#define _REGFFMT_

#ifdef WIN32
#include <pshpack1.h>
#else
#pragma pack(1)
#endif

#define REG_NULL                    0xFFFFFFFF

typedef struct _FILE_HEADER {
    DWORD Signature;                            //  FH_SIGNATURE
    DWORD Version;                              //  FH_VERSION_*
    DWORD Size;                                 //  of file header, all keynodes
    DWORD Checksum;                             //  of file header
    WORD BlockCount;
    DWORD Flags;                                //  FHF_* bits
    WORD Type;                                  //  FHT_* constant
    BYTE Reserved[8];
}   FILE_HEADER, UNALIGNED FAR* LPFILE_HEADER;

#define FH_SIGNATURE                0x47455243  //  "CREG"
#define FH_VERSION10                0x00010000  //  Win95 compatible
#define FH_VERSION20                0x00020000  //  Supports compact keynodes (never used)

#define FHF_DIRTY                   0x00000001  //  Must rewrite to disk
#define FHF_RESERVED1               0x00000002  //  Dead bit from VERY old files
#define FHF_HASCHECKSUM             0x00000004  //  Checksum member is valid
#define FHF_FILEDIRTY               0x00000008  //  File is in the process of being updated (checked by win.com)
#define FHF_CORRUPT                 0x00000010  //  File is corrupt (detected by scanregw.exe)
#define FHF_SUPPORTSDIRTY           0x00000020  //  The registry supports FHF_CORRUPT and FHF_FILEDIRTY
#define FHF_BOOTFAILED              0x00000040  //  Failed to boot and verify the integrity of the registry

#define FHT_PRIMARY                 0x0001      //  System hives
#define FHT_SECONDARY               0x0080      //  User/application hives

typedef struct _KEYNODE_HEADER {
    DWORD Signature;                            //  KH_SIGNATURE
    DWORD FileKnSize;				//  of entire keynode table inc header
    DWORD RootIndex;				// Index into keynode array of the root key node
    DWORD FirstFreeIndex;			// Index into keynode array of the root of the key node free list
    DWORD Flags;                                //  KHF_* bits
    DWORD Checksum;                             //  of entire keynode table
    BYTE Reserved[8];
}   KEYNODE_HEADER, UNALIGNED FAR* LPKEYNODE_HEADER;

#define KH_SIGNATURE                0x4E4B4752  //  "RGKN"

#define KHF_DIRTY                   0x00000001  //  Win95: Must rewrite to disk
#define KHF_EXTENDED                0x00000002  //  Win95: Table has grown
#define KHF_HASCHECKSUM             0x00000004  //  Win95: Checksum is valid
#define KHF_NEWHASH                 0x00000008  //  Always expect

typedef struct _VERSION20_HEADER_PAGE {
    union {
        struct {
            FILE_HEADER FileHeader;
            KEYNODE_HEADER KeynodeHeader;
        };
        struct {
            BYTE Page[4096];
        };
    };
}   VERSION20_HEADER_PAGE, UNALIGNED FAR* LPVERSION20_HEADER_PAGE;

typedef struct _W95KEYNODE {
    DWORD W95State;				//  KNS_* constant
    union {
        //  State == KNS_USED or KNS_BIGUSED
        struct {
	    DWORD W95Hash;
	    DWORD W95Reserved1;
	    DWORD W95ParentOffset;              // offset from start of keynode header
	    DWORD W95ChildOffset;               // offset from start of keynode header
	    DWORD W95NextOffset;                // offset from start of keynode header
	    DWORD W95DatablockAddress;          // HIWORD: block #, LOWORD: Index in block
        };
        //  State == KNS_FREE or KNS_ALLFREE
        struct {
	    DWORD W95FreeRecordSize;
	    DWORD W95NextFreeOffset;
	    DWORD W95Reserved2[4];
        };
    };
}   W95KEYNODE, UNALIGNED FAR* LPW95KEYNODE;

#define KNS_USED                    0x00000000UL  //  Normal Keynode
#define KNS_BIGUSED                 0x00000001UL  //  Big key node root
#define KNS_BIGUSEDEXT              0x00000002UL  //  Big key node extension
#define KNS_FREE                    0x80000000UL
#define KNS_ALLFREE                 0xFFFFFFFFUL

typedef struct _KEYNODE {
    DWORD NextIndex:24,
          Flags:8;
    union {
        //  Flags & KNF_INUSE
	struct {
	    DWORD ChildIndex:24,
		  BinNumber:8;
	    DWORD ParentIndex:24,
                  KeyRecordIndex:8;
            WORD  BlockIndex;
	    WORD  Hash;
        };
        //  !(Flags & KNF_INUSE)
	struct {
            DWORD Reserved;
            DWORD FreeRecordSize;
        };
    };
}   KEYNODE, FAR* LPKEYNODE;

#define KNF_INUSE           0x01        // Block is in use
#define KNF_BIGKEYROOT      0x02        // Keynode represents a big key root
#define KNF_BIGKEYEXT       0x04        // Keynode represents a big key extension

#define IsNullKeynodeIndex(kni)     ((kni) >= 0x00FFFFFF)

typedef struct _DATABLOCK_HEADER {
    DWORD Signature;                            //  DH_SIGNATURE
    DWORD BlockSize;                            //  size of block including header
    DWORD FreeBytes;                            //  total of free bytes in block
    WORD Flags;                                 //  DHF_* bits
    WORD BlockIndex;
    DWORD FirstFreeOffset;                      //  offset of first free record from start of data block header
    WORD MaxAllocatedIndex;                     //  maximum index already allocated in the block
    WORD FirstFreeIndex;                        //  first available index in the block
    DWORD Reserved;
    DWORD Checksum;                             //  of entire datablock
}   DATABLOCK_HEADER, UNALIGNED FAR* LPDATABLOCK_HEADER;

#define DH_SIGNATURE                0x42444752  //  "RGDB"

#define DHF_DIRTY                   0x0001      //  Must rewrite to disk
#define DHF_EXTENDED                0x0002      //  Datablock size has grown
#define DHF_HASCHECKSUM             0x0004      //  Checksum member is valid
#define DHF_HASBLOCKNUMBERS         0x0008      //  Keys contain block numbers

#define DATABLOCKS_PER_FILE         0xFFFE      //  0xFFFF is 'null' block index

//  Arbitrary size pulled from the old registry code.  Oh well, makes it
//  convenient when we do 16-bit math to extend a datablock by 4K.
#define MAXIMUM_DATABLOCK_SIZE      ((DWORD)(60L*1024L))

//  Win95 registry files may not always have a key record for the root key of
//  a file.
#define NULL_BLOCK_INDEX            0xFFFF
#define IsNullBlockIndex(bi)        ((bi) == NULL_BLOCK_INDEX)

typedef struct _KEY_RECORD {
    DWORD AllocatedSize;            // bytes allocated for the record
    union {
        DWORD DatablockAddress;     // corresponds to W95KEYNODE.W95DatablockAddress
        struct {
            WORD KeyRecordIndex;    // index into the data block for this key
            WORD BlockIndex;        // data block index that this key resides in
        };
    };
    DWORD RecordSize;               // bytes used in the record
    WORD NameLength;
    WORD ValueCount;                // Count of value name records
    WORD ClassLength;
    WORD Reserved;
    char Name[ANYSIZE_ARRAY];
}   KEY_RECORD, UNALIGNED FAR* LPKEY_RECORD;

typedef struct _FREEKEY_RECORD {
    DWORD AllocatedSize;
    DWORD DatablockAddress;                     //  REG_NULL for free records
    DWORD NextFreeOffset;
}   FREEKEY_RECORD, UNALIGNED FAR* LPFREEKEY_RECORD;

typedef struct _VALUE_RECORD {
    DWORD DataType;
    DWORD Reserved;
    WORD NameLength;
    WORD DataLength;
    char Name[ANYSIZE_ARRAY];
}   VALUE_RECORD, UNALIGNED FAR* LPVALUE_RECORD;

#define KEY_RECORDS_PER_DATABLOCK   255

//  Arbitrary size pulled from the old registry code.  Oh well, makes it
//  convenient when we do 16-bit math to extend a datablock by 4K.
#define MAXIMUM_KEY_RECORD_SIZE     \
    ((DWORD)(MAXIMUM_DATABLOCK_SIZE-sizeof(DATABLOCK_HEADER)))

#ifdef WIN32
#include <poppack.h>
#else
#pragma pack()
#endif

#endif // _REGFFMT_
