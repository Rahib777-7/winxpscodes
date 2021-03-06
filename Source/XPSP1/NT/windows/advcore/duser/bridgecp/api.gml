<outfile:BridgeCP.def>
LIBRARY DUserCP

EXPORTS

; DLL entry point
DllMain
BuildBridgeGadget
InitBridge

; Api's
<repeat:iClass,$<num_class>>
Override$<class>Message
<repeat:iFunc,$<num_funcs>>
<if:$<func_isInherited>=="false">
$<class>$<func>
</if>           ; !isInherited
</repeat>       ; iFunc

<repeat:iFunc,$<num_funcs>>
<if:$<func_isInherited>=="false">
S$<class>$<func>
</if>           ; !isInherited
</repeat>       ; iFunc

</repeat>       ; iClass
</outfile>

<outfile:Api.h>
/***************************************************************************\\
*
* Generated by GIDL on $<date> at $<time>
*
* Flat-Api portion
* Target = $<target>
* 
\***************************************************************************/

#pragma once

#include "Gadget.h"

</outfile>

<outfile:Api.cpp>
/***************************************************************************\\
*
* Generated by GIDL on $<date> at $<time>
*
* Flat-Api portion
* Target = $<target>
* 
\***************************************************************************/

#include "stdafx.h"
<if:"$<project>"!="">
#include "$<project>"
</if>

#include "super.h"
#include "stub.h"
#include <stddef.h>

#pragma warning(disable:4100)   // unreferenced formal parameter

/***************************************************************************\\
*
* class DLL entry points for flat API's
* 
\***************************************************************************/

<repeat:iClass,$<num_class>>
<repeat:iFunc,$<num_funcs>>
<if:$<func_isInherited>=="false">
//---------------------------------------------------------------------------
extern "C"
$<func_type> CALLBACK $<class>$<func>($<class> * p\
<if:"$<num_params>"!="0">
, \
</if>
$<func_params>)
{
<if:"$<func_type>"!="void">
    return p->$<func>(\
</if>
<if:"$<func_type>"=="void">
    p->$<func>(\
</if>
<repeat:iParam,$<num_params>>
$<param>\
<if:! #last iParam>
, \
</if>
</repeat>
);
}

</if>           ; !isInherited
</repeat>       ; iFunc

<repeat:iFunc,$<num_funcs>>
<if:$<func_isInherited>=="false">
//---------------------------------------------------------------------------
extern "C"
$<func_type> CALLBACK S$<class>$<func>($<class> * p\
<if:"$<num_params>"!="0">
, \
</if>
$<func_params>)
{
    S$<class> s;
    s.m_pgad = p;
<if:"$<func_type>"!="void">
    return s.Api$<func>(\
</if>
<if:"$<func_type>"=="void">
    s.Api$<func>(\
</if>
<repeat:iParam,$<num_params>>
$<param>\
<if:! #last iParam>
, \
</if>
</repeat>
);
}

</if>           ; !isInherited
</repeat>       ; iFunc
</repeat>       ; iClass

</outfile>


<outfile:Bridge.h>
/***************************************************************************\\
*
* Generated by GIDL on $<date> at $<time>
*
* COM+ Bridge class portion
* Target = $<target>
* 
\***************************************************************************/

#if !defined(BRIDGECP__Bridge_h__INCLUDED)
#define BRIDGECP__Bridge_h__INCLUDED
#pragma once

#include "Gadget.h"
#include "stub.h"
#include "super.h"

BOOL InitBridges();
BOOL IsMsgOverride(int idxFunc, BYTE rgMsg[]);
void SetMsgOverride(int idxFunc, BOOL fOverride, BYTE rgMsg[]);

<repeat:iClass,$<num_class>>
//------------------------------------------------------------------------------
class $<class>Bridge : $<class>Impl<$<class>Bridge, S$<class>>
{
// Construction
public:
    $<class>Bridge()
    {
        m_pfnEvent = NULL;
        m_pfnMethod = NULL;
        ZeroMemory(m_rgMsg, sizeof(m_rgMsg));
    }

// Public API
public:
<repeat:iFunc,$<num_funcs>>
    dapi    $<func_type> Api$<func>($<func_params>);
</repeat>

// Implementation
public:
    static BOOL Init$<class>()
    {
<if:"$<super>"!="">
        if (!S$<super>::Init$<super>()) {
            return FALSE;
        }
</if>

        ZeroMemory(&s_mc, sizeof(s_mc));
        s_mc.cbSize         = sizeof(s_mc);
        s_mc.nClassVersion  = $<class.version>;
        s_mc.pszClassName   = L"$<class>Bridge";
        s_mc.pszSuperName   = L"$<class>";
        s_mc.rgMsgInfo      = s_rgmi;
        s_mc.cMsgs          = $<num_funcs>;
        s_mc.pfnPromote     = Promote$<class>;
        s_mc.pfnDemote      = Demote$<class>;
   
        return DUserRegisterGuts(&s_mc) != NULL;
    }


    static HRESULT CALLBACK
    Promote$<class>(DUser::ConstructProc pfnCS, HCLASS hclCur, DUser::Gadget * pgad, DUser::Gadget::ConstructInfo * pciData)
    {
        HRESULT hr;

        BridgeData * pbd = GetBridgeData();

        hr = (pfnCS)(DUser::Gadget::ccSuper, s_hclSuper, pgad, pciData);
        if (FAILED(hr)) {
            return hr;
        }

        $<class>Bridge * pc = new $<class>Bridge;
        if (pc == NULL) {
            return E_OUTOFMEMORY;
        }
        pc->m_pgad      = pgad;
        pc->m_pfnEvent  = pbd->pfnEvent;
        pc->m_pfnMethod = pbd->pfnMethod;

        hr = (pfnCS)(DUser::Gadget::ccSetThis, hclCur, pgad, pc);
        if (FAILED(hr)) {
            return hr;
        }

        return S_OK;
    }


    inline BOOL IsMsgOverride(int idxMsg)
    {
        return ::IsMsgOverride(idxMsg, m_rgMsg);
    }

    inline void SetMsgOverride(int idxMsg, BOOL fOverride)
    {
        ::SetMsgOverride(idxMsg, fOverride, m_rgMsg);
    }

// Data
protected:
            EventProc   m_pfnEvent;
            MethodProc  m_pfnMethod;
            BYTE        m_rgMsg[($<num_funcs>+7)/8];

    static  DUser::MessageInfoGuts s_rgmi[];
public:
    static  DUser::MessageClassGuts s_mc;
}; // class $<class>Bridge


</repeat>;      ; iClass

<repeat:iClass,$<num_class>>
#define IMPLEMENT_BRIDGE_$<class>(me) \\
    DUser::MessageClassGuts $<class>Bridge::s_mc; \\
    DUser::MessageInfoGuts $<class>Bridge::s_rgmi[] = { \\
<repeat:iFunc,$<num_funcs>>
        { member(me::Api$<func>), NULL, L"$<func>" }, \\
</repeat>       ; iFunc
    };

</repeat>;      ; iClass
#endif // BRIDGECP__Bridge_h__INCLUDED
</outfile>

<outfile:Bridge.cpp>
/***************************************************************************\\
*
* Generated by GIDL on $<date> at $<time>
*
* COM+ Bridge class portion
* Target = $<target>
* 
\***************************************************************************/

#include "stdafx.h"
<if:"$<project>"!="">
#include "$<project>"
</if>

#include "Bridge.h"

<repeat:iClass,$<num_class>>
IMPLEMENT_BRIDGE_$<class>($<class>Bridge)
</repeat>       ; iClass


//------------------------------------------------------------------------------
BOOL InitBridges()
{
    return 
<repeat:iClass,$<num_class>>
        $<class>Bridge::Init$<class>() &&
</repeat>       ; iClass
        TRUE;
}


//------------------------------------------------------------------------------
BOOL IsMsgOverride(int idxFunc, BYTE rgMsg[])
{
    //
    // NOTE: idxFunc is NOT the same as the message ID.  idxFunc is determined
    // at COMPILE time, where-as the message ID is determined at RUNTIME.
    //

    UINT idxMajor = (UINT) idxFunc / 8;
    return (rgMsg[idxMajor]) & ((BYTE) (1 << (idxFunc & 7)));
}


//------------------------------------------------------------------------------
void SetMsgOverride(int idxFunc, BOOL fOverride, BYTE rgMsg[])
{
    //
    // NOTE: idxFunc is NOT the same as the message ID.  idxFunc is determined
    // at COMPILE time, where-as the message ID is determined at RUNTIME.
    //

    UINT idxMajor = idxFunc / 8;
    BYTE idxMinor = (BYTE) (1 << (idxFunc & 7));
    BYTE b = rgMsg[idxMajor];

    if (fOverride) {
        // Turn on
        b |= idxMinor;
    } else {
        // Turn off
        b &= ~idxMinor;
    }

    rgMsg[idxMajor] = b;
}


<repeat:iClass,$<num_class>>
/***************************************************************************\\
*
* class $<class>Bridge
* 
\***************************************************************************/

//------------------------------------------------------------------------------
extern "C" 
BOOL WINAPI
Override$<class>Message($<class> * pg, LPCWSTR pszMessage, BOOL fOverride)
{
    $<class>Bridge * pb = reinterpret_cast<$<class>Bridge *>
            (DUserGetGutsData(pg, $<class>Bridge::s_mc.hclNew));
    if (pb == NULL) {
        SetError(E_INVALIDARG);
        return FALSE;
    }

<repeat:iFunc,$<num_funcs>>
    if (wcscmp(pszMessage, L"$<func>") == 0) {
        pb->SetMsgOverride($<iFunc>, fOverride);
        return TRUE;
    }
</repeat>

    SetError(DU_E_MESSAGENOTFOUND);
    return FALSE;
}


<repeat:iFunc,$<num_funcs>>
//------------------------------------------------------------------------------
$<func_type> 
$<class>Bridge::Api$<func>($<func_params>)
{
    Assert(m_pfnMethod != NULL);

    if (IsMsgOverride($<iFunc>)) {
<if:"$<func>"=="OnEvent">
        return (m_pfnEvent)(\
<repeat:iParam,$<num_params>>
$<param>\
<if:! #last iParam>
, \
</if>       ; ! #last iParam
</repeat>
);
</if>       ; $<func> == OnEvent
<if:"$<func>"!="OnEvent">
        $<class>::GMSG_$<func> msg;
        ZeroMemory(&msg, sizeof(msg));
        msg.cbSize = sizeof(msg);
        msg.nMsg = s_rgmi$<class>[$<iFunc>].cbSlotOffset;
        msg.hgadMsg = GetHandle();
<repeat:iParam,$<num_params>>
        msg.m_$<param> = $<param>;
</repeat>
        (m_pfnMethod)(&msg);
<if:"$<func_type>"!="void">
        return msg.m_result;
</if>
</if>           ; $<func> != OnEvent
    } else {
<if:"$<func_type>"!="void">
        return \
</if>
S$<class>::Api$<func>(\
<repeat:iParam,$<num_params>>
$<param>\
<if:! #last iParam>
, \
</if>
</repeat>
);
    };
}

</repeat>       ; iFunc
</repeat>       ; iClass
</outfile>
