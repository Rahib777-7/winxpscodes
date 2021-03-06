/*++

WARNING!!!

	This file is automatically generated and should never be changed.
	All changes should be made to the NTFRSCON.int file.

Copyright (c) 1998-1999  Microsoft Corporation

Module Name:

	NTFRSCON.h

Abstract

	This is the offset definition file for the REPLICACONN Object.

Environment:

	User Mode Service

Revision History:

--*/


#ifndef _NTFRSCON_H_
#define _NTFRSCON_H_

//
// The offset definitions follow
//
#define OBJREPLICACONN 0 // REPLICACONN Object

#define DEV_CTR_1 2  // Packets Sent in Bytes            
#define DEV_CTR_2 4  // Fetch Blocks Sent in Bytes       
#define DEV_CTR_3 6  // Fetch Blocks Received in Bytes   
#define DEV_CTR_4 8  // Local Change Orders Sent         
#define DEV_CTR_5 10  // Local Change Orders Sent At Join 
#define DEV_CTR_6 12  // Remote Change Orders Sent        
#define DEV_CTR_7 14  // Remote Change Orders Received    
#define DEV_CTR_8 16  // Inbound Change Orders Dampened   
#define DEV_CTR_9 18  // Outbound Change Orders Dampened  
#define DEV_CTR_10 20  // Packets Sent                     
#define DEV_CTR_11 22  // Packets Sent in Error            
#define DEV_CTR_12 24  // Communication Timeouts           
#define DEV_CTR_13 26  // Fetch Requests Sent              
#define DEV_CTR_14 28  // Fetch Requests Received          
#define DEV_CTR_15 30  // Fetch Blocks Sent                
#define DEV_CTR_16 32  // Fetch Blocks Received            
#define DEV_CTR_17 34  // Join Notifications Sent          
#define DEV_CTR_18 36  // Join Notifications Received      
#define DEV_CTR_19 38  // Joins                            
#define DEV_CTR_20 40  // Unjoins                          
#define DEV_CTR_21 42  // Bindings                         
#define DEV_CTR_22 44  // Bindings in Error                
#define DEV_CTR_23 46  // Authentications                  
#define DEV_CTR_24 48  // Authentications in Error         

#endif
