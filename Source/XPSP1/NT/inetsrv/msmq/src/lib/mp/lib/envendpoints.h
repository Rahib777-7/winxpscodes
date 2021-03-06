/*++

Copyright (c) 1995-97  Microsoft Corporation

Module Name:
    envendpoints.h

Abstract:
    Header for serialization\deserialization of the smxp element to\from the  srmp envelop.


Author:
    Gil Shafriri(gilsh) 11-DEC-00

--*/

#pragma once

#ifndef _MSMQ_envendpoints_H_
#define _MSMQ_envendpoints_H_
class CQmPacket;
class XmlNode;
class CMessageProperties;
class SmXpPathElement
{
public:
	explicit SmXpPathElement(const CQmPacket& pkt):m_pkt(pkt){}
	friend  std::wostream& operator<<(std::wostream& wstr, const SmXpPathElement& SmXpPath);

private:
	const CQmPacket& m_pkt;
};

void SmXpPathToProps(XmlNode& Node, CMessageProperties* pMessageProperties);





#endif

