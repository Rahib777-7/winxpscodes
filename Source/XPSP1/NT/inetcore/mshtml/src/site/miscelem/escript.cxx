//+---------------------------------------------------------------------------
//
//  Microsoft Forms
//  Copyright (C) Microsoft Corporation, 1994-1996
//
//  File:       escript.cxx
//
//  Contents:   CScriptElement, CScriptParser
//
//  History:    15-Jul-1996     AnandRa     Created
//
//----------------------------------------------------------------------------

#include "headers.hxx"

#pragma MARK_DATA(__FILE__)
#pragma MARK_CODE(__FILE__)
#pragma MARK_CONST(__FILE__)

#ifndef X_ESCRIPT_HXX_
#define X_ESCRIPT_HXX_
#include "escript.hxx"
#endif

#ifndef X_FORMKRNL_HXX_
#define X_FORMKRNL_HXX_
#include "formkrnl.hxx"
#endif

#ifndef X_COLLECT_HXX_
#define X_COLLECT_HXX_
#include "collect.hxx"
#endif

#ifndef X_OLESITE_HXX_
#define X_OLESITE_HXX_
#include "olesite.hxx"
#endif

#ifndef X_PEER_HXX_
#define X_PEER_HXX_
#include "peer.hxx"
#endif

#ifndef X_WINDOW_HXX_
#define X_WINDOW_HXX_
#include "window.hxx"
#endif

#ifndef X_ACTIVSCP_H_
#define X_ACTIVSCP_H_
#include <activscp.h>
#endif

#ifndef X_SHOLDER_HXX_
#define X_SHOLDER_HXX_
#include "sholder.hxx"
#endif

#ifndef X_DOWNLOAD_HXX_
#define X_DOWNLOAD_HXX_
#include "download.hxx"
#endif

#ifndef X_STRBUF_HXX_
#define X_STRBUF_HXX_
#include "strbuf.hxx"
#endif

#ifndef X_SCRIPT_HXX_
#define X_SCRIPT_HXX_
#include "script.hxx"
#endif

#ifndef X_QI_IMPL_H_
#define X_QI_IMPL_H_
#include "qi_impl.h"
#endif

#ifndef X_HTC_HXX_
#define X_HTC_HXX_
#include "htc.hxx"
#endif

#ifndef X_MARKUPCTX_HXX_
#define X_MARKUPCTX_HXX_
#include "markupctx.hxx"
#endif

#ifndef X_DEBUGGER_HXX_
#define X_DEBUGGER_HXX_
#include "debugger.hxx"
#endif

#ifndef X_DMEMBMGR_HXX_
#define X_DMEMBMGR_HXX_
#include <dmembmgr.hxx>       // for CDataMemberMgr
#endif

#ifndef X_INTL_HXX_
#define X_INTL_HXX_
#include <intl.hxx>
#endif

#define _cxx_
#include "script.hdl"

extern BOOL IsSpecialUrl(LPCTSTR pszURL);
extern MIMEINFO *  GetMimeInfoFromData(void * pb, ULONG cb, const TCHAR *pchProposed, CStr * pcstrMimeType);

#ifndef NO_SCRIPT_DEBUGGER
extern interface IProcessDebugManager * g_pPDM;
extern interface IDebugApplication *g_pDebugApp;
#endif // ndef NO_SCRIPT_DEBUGGER

MtDefine(CScriptElement, Elements, "CScriptElement")
MtDefine(CScriptElement_pchSrcCode, CScriptElement, "CScriptElement::_pchSrcCode")
MtDefine(CScriptElementOnDwnChan_pbBuffer, Locals, "CScriptElement::OnDwnChan pbBuffer")
MtDefine(TokenizeEventDescription_ppchEventName, Utilities, "TokenizeEventDescription *ppchEventName")
MtDefine(TokenizeEventDescription_ppchFormalParams, Utilities, "TokenizeEventDescription *ppchFormalParams")

const CElement::CLASSDESC CScriptElement::s_classdesc =
{
    {
        &CLSID_HTMLScriptElement,       // _pclsid
        0,                              // _idrBase
#ifndef NO_PROPERTY_PAGE
        s_apclsidPages,                 // _apClsidPages
#endif // NO_PROPERTY_PAGE
        s_acpi,                         // _pcpi
        ELEMENTDESC_NOLAYOUT,           // _dwFlags
        &IID_IHTMLScriptElement,        // _piidDispinterface
        &s_apHdlDescs,                  // _apHdlDesc
    },
    (void *)s_apfnpdIHTMLScriptElement, // _apfnTearOff
    NULL                                // _pAccelsRun
};

DeclareTag(tagHtmSrcTest, "Dwn", "! Test Unicode Source Access")

//+------------------------------------------------------------------------
//
//  Member:     CScriptElement::CreateElement
//
//  Synopsis:   standard element creator
//
//  Arguments:  pht             Info about the tag
//              pElementParent  The parent element of the script
//              ppElement       Ptr to returned element
//
//-------------------------------------------------------------------------

HRESULT 
CScriptElement::CreateElement(CHtmTag *pht,
                              CDoc *pDoc, CElement **ppElement)
{
    HRESULT         hr = S_OK;
    CScriptElement *pElement;

    Assert(ppElement);

    pElement = new CScriptElement(pht, pDoc);
    if (!pElement)
    {
        hr = E_OUTOFMEMORY;
        goto Cleanup;
    }

    *ppElement = pElement;
    pElement = NULL;
   
Cleanup:

    delete pElement;
    
    RRETURN(hr);
}


//+------------------------------------------------------------------------
//
//  Member:     CScriptElement::CScriptElement
//
//-------------------------------------------------------------------------

CScriptElement::CScriptElement (CHtmTag *pht, CDoc *pDoc) 
     : CElement(pht->GetTag(), pDoc)
{
    _ulScriptOffset = pht->GetOffset();
    _ulScriptLine = pht->GetLine();

    _dwScriptCookie = NO_SOURCE_CONTEXT;

    Assert (!_fCodeConstructed);
}

//+------------------------------------------------------------------------
//
//  Member:     CScriptElement::PrivateQueryInterface, per IPrivateUnknown
//
//-------------------------------------------------------------------------

HRESULT
CScriptElement::PrivateQueryInterface(REFIID iid, void ** ppv)
{
    *ppv = NULL;

    switch (iid.Data1)
    {
        QI_HTML_TEAROFF(this, IHTMLElement2, NULL)
        QI_HTML_TEAROFF(this, IHTMLScriptElement2, NULL)

    default:
        if (iid == CLSID_HTMLScriptElement)
        {
            *ppv = this;    // weak ref
            return S_OK;
        }
    }

    if (*ppv)
    {
        ((IUnknown *) *ppv)->AddRef();
        RRETURN(S_OK);
    }

    RRETURN(super::PrivateQueryInterface(iid, ppv));
}

//+------------------------------------------------------------------------
//
//  Member:     CScriptElement::Save
//
//  Synopsis:   standard element saver
//
//  Arguments:  pStreamWriteBuff    The stream to write into
//              fEnd                If this is the end tag
//
//-------------------------------------------------------------------------

HRESULT
CScriptElement::Save(CStreamWriteBuff * pStreamWriteBuff, BOOL fEnd)
{
    HRESULT hr = S_OK;

    // Do not write out the script when saving in plaintext mode, or when
    // writing for the rtf converter.
    if (!pStreamWriteBuff->TestFlag(WBF_SAVE_PLAINTEXT) &&
        !pStreamWriteBuff->TestFlag(WBF_FOR_RTF_CONV))
    {
        DWORD   dwOld;

        if (!fEnd)
        {
            //
            // New line for the <SCRIPT> tag
            //

            hr = THR(pStreamWriteBuff->NewLine());
            if(hr)
                goto Cleanup;
        }

        //
        // Save tagname and attributes.
        //

        hr = THR(super::Save(pStreamWriteBuff, fEnd));
        if (hr)
            goto Cleanup;

        if (fEnd)
        {
            //
            // New line after </SCRIPT>
            //

            hr = THR(pStreamWriteBuff->NewLine());
            goto Cleanup;
        }

        // Turn of entitizing within the script
        dwOld = pStreamWriteBuff->ClearFlags(WBF_ENTITYREF);
    
        // Turn off fancy indenting/formatting
        pStreamWriteBuff->BeginPre();

        hr = THR(pStreamWriteBuff->Write((LPTSTR)_cstrText));
        if (hr)
            goto Cleanup;
        
        pStreamWriteBuff->EndPre();
        pStreamWriteBuff->SetFlags(dwOld);
    }
    
Cleanup:
    RRETURN(hr);
}


//+------------------------------------------------------------------------
//
//  Member:     CScriptElement::CommitCode
//
//  Synopsis:   Commits the code that it has into a script engine
//              holder.  This could potentially cause code to execute.
//
//-------------------------------------------------------------------------

HRESULT
CScriptElement::CommitCode(BOOL fCommitOutOfMarkup, CHtmlComponent *pComponent, CElement * pElementContext)
{
    const static TCHAR      achDelimiter[] = _T("</SCRIPT>");
    HRESULT                 hr = S_OK;
    CExcepInfo              ExcepInfo;
    CVariant                Var;
    CDoc  *                 pDoc = Doc();
    BSTR                    bstrFuncName = NULL;
    TCHAR *                 pchCleanSource = NULL;
    TCHAR *                 pchSource = NULL;
    LPTSTR                  pchNamespace;
    LPCTSTR                 pchScope = NULL;
    LPCTSTR                 pchLang;
    LPCTSTR                 pchEvent;
    LPCTSTR                 pchFor;
    LPCTSTR                 pchType;
    CMarkup *               pMarkup = GetMarkup();
    CMarkup *               pScriptCollectionMarkup;
    CScriptCollection *     pScriptCollection;
    CMarkupScriptContext *  pScriptContext;

    CDoc::CLock Lock(pDoc);

    Assert(!_fDeferredExecution);

    if (!pMarkup && !fCommitOutOfMarkup)
        goto Cleanup;

    if (!CMarkup::CanCommitScripts(fCommitOutOfMarkup ? NULL : pMarkup, this))
        goto Cleanup;

    // assert correctness of params setup
#if DBG == 1
    if (!fCommitOutOfMarkup)
    {
        // most typical case
        Assert (!pComponent && !pElementContext);
        Assert (pMarkup);
    }
    else
    {
        // script in lightweight HTCs
        Assert (pComponent && pElementContext);
        Assert (pMarkup);
    }

#endif

    pchLang = GetAAlanguage();
    pchEvent = GetAAevent();
    pchFor = GetAAhtmlFor();
    pchType = GetAAtype();
    
    SetReadyStateScript(READYSTATE_INTERACTIVE);
        
    if (!pchFor)
    {
        pchFor = DEFAULT_OM_SCOPE;
    }

    if (pComponent)
    {
        // lightweight htc
        pchNamespace = pComponent->GetNamespace();
    }
    else
    {
        hr = THR(pMarkup->EnsureScriptContext(&pScriptContext));
        if (hr)
            goto Cleanup;

        pchNamespace = pScriptContext->GetNamespace();
    }

    Assert(pchNamespace);

    pchScope = NameOrIDOfParentForm();

    pchSource = _fSrc ? _pchSrcCode : _cstrText;

#if DBG==1
    if (IsTagEnabled(tagHtmSrcTest))
    {
        TCHAR achSrc[512];
        ULONG cch;

        HRESULT hrT;

        hrT = pDoc->GetHtmSourceText(_ulScriptOffset, ARRAY_SIZE(achSrc) - 1,
                achSrc, &cch);

        if (hrT == S_OK)
        {
            cch = min(cch, (ULONG)_tcslen(STRVAL(pchSource)));
            achSrc[cch] = 0;

            TraceTag((tagHtmSrcTest, "Expect \"%.64ls\", (ln=%ld pos=%ld) \"%.64ls\"",
                pchSource, _ulScriptLine, _ulScriptOffset, achSrc));
        }
    }
#endif

#define MAX_SCRIPT_INCLUDES 0 // feature disabled - see CLIENT_SIDE_INCLUDES

#if MAX_SCRIPT_INCLUDES
    if (!pchEvent && pchLang && !StrCmpIC(pchLang, _T("include")) && pDoc->_cIncludes < MAX_SCRIPT_INCLUDES)
    {
        if (pchSource && pDoc->HtmCtx() && pMarkup->IsInInline() && (!_fSrc || _pBitsCtx && pDoc->AccessAllowed(_pBitsCtx->GetUrl())))
        {
            hr = THR(pDoc->HtmCtx()->Write(pchSource, FALSE));
        }

        pDoc->_cIncludes += 1;

        goto Cleanup;
    }
#endif

    if (!fCommitOutOfMarkup)
    {
        // most typical case

        pScriptCollectionMarkup = GetNearestMarkupForScriptCollection();
    }
    else
    {
        // lightweight HTCs case

        pScriptCollectionMarkup = pElementContext->GetNearestMarkupForScriptCollection();
    }

    Assert (pScriptCollectionMarkup);

    pScriptCollection = pScriptCollectionMarkup->GetScriptCollection();

    if (pScriptCollection)
    {
        // hold on to the script collection until the end of the cycle,
        pScriptCollection->AddRef();

        //
        // If the event attribute is set, then treat this as
        // a scriptlet.  Otherwise, just parse it in as script text as
        // long as we're not an event tag.
        //

        if (pchEvent)
        {
            hr = THR(pScriptCollection->AddScriptlet(
                    (LPTSTR)pchLang,                                    // pchLanguage
                    pMarkup,                                            // pScriptMarkup
                    (LPTSTR)pchType,                                    // pchType
                    (LPTSTR)pchSource,                                  // pchCode
                    (LPTSTR)(pchScope ? pchScope : DEFAULT_OM_SCOPE),   // pchItemName
                    (LPTSTR)pchFor,                                     // pchSubItemName
                    (LPTSTR)pchEvent,                                   // pchEventName
                    (LPTSTR)achDelimiter,                               // pchDelimiter
                    _fSrc ? 0 : _ulScriptOffset,                        // ulOffset
                    _fSrc ? 0 : _ulScriptLine,                          // ulStartingLine
                    NULL,                                               // pSourceObject
                    0,                                                  // dwFlags
                    &bstrFuncName,                                      // pbstrName
                    pComponent));                                       // instance of lightweight htc
            
        }
        else
        {
//$ WIN64: CScriptElement::CommitCode is passing a pointer through the ulSourceContextCookie parameter
//$ WIN64:   of the CScriptCollection::ParseScriptText method.

#ifndef NO_SCRIPT_DEBUGGER
            CBase *pBase = (!g_pPDM || !g_pDebugApp) ? pMarkup : (CBase *)this;          // pSourceObject
#else
            CBase *pBase = pMarkup;
#endif

            hr = THR(pScriptCollection->ParseScriptText(
                        (LPTSTR)pchLang,            // pchLanguage
                        pMarkup,                    // pScriptMarkup
                        (LPTSTR)pchType,            // pchType
                        (LPTSTR)pchSource,          // pchCode
                        (LPTSTR)pchNamespace,       // pchItemName
                        (LPTSTR)achDelimiter,       // pchDelimiter
                        _ulScriptOffset,            // ulOffset
                        _ulScriptLine,              // ulStartingLine
                        pBase,                      // pSourceObject
                        SCRIPTTEXT_ISVISIBLE | SCRIPTTEXT_HOSTMANAGESSOURCE, // dwFlags
                        &Var,                       // pvarResult
                        &ExcepInfo,                 // pExcepInfo
                        fCommitOutOfMarkup,         // For shared htc's        
                        pComponent));               // instance of lightweight htc
        }
        if (hr)
            hr = S_OK;

        // release the reference we added at the top of this if' s scope.
        pScriptCollection->Release();
    }

    SetReadyStateScript(READYSTATE_COMPLETE);

Cleanup:
    FormsFreeString(bstrFuncName);
    delete [] pchCleanSource;
    RRETURN(hr);
}

//+------------------------------------------------------------------------
//
//  Function:   CScriptElement::EnsureScriptDownloadLeft
//
//-------------------------------------------------------------------------

HRESULT
CScriptElement::EnsureScriptDownloadLeft()
{
    HRESULT     hr = S_OK;

    if (_dwScriptDownloadCookie)
    {
        if (IsInMarkup())
            IGNORE_HR(GetMarkup()->UnblockScriptExecution(&_dwScriptDownloadCookie));
        _dwScriptDownloadCookie = NULL;
    }

    RRETURN (hr);
}

//+------------------------------------------------------------------------
//
//  Function:   CScriptElement::EnsureSourceObjectRevoked
//
//-------------------------------------------------------------------------

HRESULT
CScriptElement::EnsureSourceObjectRevoked()
{
    HRESULT     hr = S_OK;
    CDoc *      pDoc = Doc();

    if (pDoc->_pScriptCookieTable && NO_SOURCE_CONTEXT != _dwScriptCookie)
    {
        IGNORE_HR(pDoc->_pScriptCookieTable->RevokeSourceObject(_dwScriptCookie, this));
        _dwScriptCookie = NO_SOURCE_CONTEXT;
    }

    RRETURN (hr);
}

//+------------------------------------------------------------------------
//
//  Member:   CScriptElement::Passivate
//
//-------------------------------------------------------------------------

void
CScriptElement::Passivate()
{
    IGNORE_HR(EnsureSourceObjectRevoked());

    if (_pScriptDebugDocument)
    {
        _pScriptDebugDocument->Release();
    }

    if (_fSharedCode)
        _cstrText.SetPch(NULL);

    SetBitsCtx(NULL);
    if (!_fSharedCode)
        delete _pchSrcCode;
    delete _pchEventName;
    _pchEventName = NULL;
    ClearInterface (&_pDispCode);
    super::Passivate();
}

//+------------------------------------------------------------------------
//
//  Function:   helper for CScriptElement::CommitFunctionPointersCode
//
//-------------------------------------------------------------------------

HRESULT
TokenizeEventDescription (TCHAR * pchEvent, TCHAR ** ppchEventName, TCHAR ** ppchFormalParams)
{
    HRESULT     hr = S_OK;
    TCHAR *     pchStart;
    TCHAR *     pchEnd;
    long        l;

    Assert (ppchEventName);
    Assert (ppchFormalParams);
    
    delete [] *ppchEventName;
    *ppchEventName    = NULL;
    *ppchFormalParams = NULL;

    //
    // get event name
    //

    // skip leading spaces
    pchStart = pchEvent;
    while (_T(' ') == *pchStart)
        pchStart++;

    if (0 == *pchStart) // if no name specified
        goto Cleanup;

    // find the end of name
    pchEnd = pchStart;
    while (_T(' ') != *pchEnd && _T('(') != *pchEnd && *pchEnd)
        pchEnd++;

    // alloc and copy event name

    Assert (pchStart && pchEnd);

    l = PTR_DIFF(pchEnd, pchStart);

    *ppchEventName = new(Mt(TokenizeEventDescription_ppchEventName)) TCHAR [l + 1];
    if (!*ppchEventName)
    {
        hr = E_OUTOFMEMORY;
        goto Cleanup;
    }

    _tcsncpy (*ppchEventName, pchStart, l);
    (*ppchEventName)[l] = 0;

    //
    // get formal params
    //

    pchStart = _tcschr (pchEnd, _T('('));
    if (!pchStart)
        goto Cleanup; // no open bracket so no params

    pchEnd = _tcschr (pchStart, _T(')'));
    if (!pchEnd)
        goto Cleanup; // invalid syntax - there was open bracket and no closing bracket

    // alloc and copy formal params

    Assert (pchStart && pchEnd);

    l = PTR_DIFF(pchEnd, pchStart) - 1;

    if (l)
    {
        *ppchFormalParams = new(Mt(TokenizeEventDescription_ppchFormalParams)) TCHAR [l + 1];
        if (!*ppchFormalParams)
        {
            hr = E_OUTOFMEMORY;
            goto Cleanup;
        }

        _tcsncpy (*ppchFormalParams, pchStart + 1, l);
        (*ppchFormalParams)[l] = 0;
    }

Cleanup:
    if (hr)
    {
        delete *ppchEventName;
        delete *ppchFormalParams;
    }

    RRETURN (hr);
}

//+------------------------------------------------------------------------
//
//  Member:     CScriptElement::CommitFunctionPointersCode
//
//-------------------------------------------------------------------------

HRESULT
CScriptElement::CommitFunctionPointersCode(CBase *pelTarget, BOOL fHookup)
{
    HRESULT                 hr = S_OK;
    TCHAR *                 pchEvent;
    TCHAR *                 pchFor;
    TCHAR *                 pchLanguage;
    TCHAR *                 pchType;
    int                     iObject;
    int                     cObjects;
    CBase *                 pObject;
    CElementAryCacheItem    cacheItem;
    CElement *              pElem;
    TCHAR *                 pchFormalParams = NULL;
    CBase *                 pNonElementPropHost = NULL;
    CBase **                ppBase = NULL;
    CScriptHolder *         pHolder;
    ITypeInfo *             pTIEvent = NULL;
    DISPID                  dispid = DISPID_UNKNOWN;
    COleSite *              pOleSite = NULL;
    CMarkup *               pMarkup = GetMarkup();
    TCHAR *                 pchSource = _fSrc ? _pchSrcCode : _cstrText;
    BOOL                    fAnyDeleted;
    CScriptCollection *     pScriptCollection;

    pchEvent = (TCHAR*) GetAAevent();
    pchFor   = (TCHAR*) GetAAhtmlFor();
    pchType  = (TCHAR*) GetAAtype();

    Assert(pMarkup);

    // if the script element is for/event type
    if (pchEvent && *pchEvent && pchFor && *pchFor && pchSource && *pchSource)
    {
        //
        // get objects specified in pchFor
        //

        pchLanguage = (TCHAR*)GetAAlanguage();
        pScriptCollection = pMarkup->GetScriptCollection();

        if (!pScriptCollection)
            goto Cleanup;

        hr = THR(pScriptCollection->GetHolderForLanguage(pchLanguage, pMarkup, pchType, NULL, &pHolder));
        if (hr)
            goto Cleanup;

        if (pelTarget)
        {
            if ((0 == FormsStringCmpCase(DYNCAST(CElement, pelTarget)->GetAAname(), pchFor, pHolder->_fCaseSensitive)) ||
                (0 == FormsStringCmpCase(DYNCAST(CElement, pelTarget)->GetAAid(), pchFor, pHolder->_fCaseSensitive)))
            {
                cObjects = 1;
                ppBase = &pelTarget;
            }
            else
                goto Cleanup;
        }
        else if (0 == FormsStringCmpCase(_T("document"), pchFor, pHolder->_fCaseSensitive))
        {
            hr = pMarkup->EnsureDocument();
            if (hr)
                goto Cleanup;

            pNonElementPropHost = pMarkup->Document();
            cObjects = 1;
            ppBase = &pNonElementPropHost;
        }
        else if (0 == FormsStringCmpCase(_T("window"), pchFor, pHolder->_fCaseSensitive))
        {
            if (!pMarkup->HasWindow())
            {
                hr = S_OK;
                goto Cleanup;
            }

            pNonElementPropHost = pMarkup->Window();
            cObjects = 1;
            ppBase = &pNonElementPropHost;            
        }
        else
        {
            hr = THR(pMarkup->EnsureCollectionCache(CMarkup::ELEMENT_COLLECTION));
            if (hr)
                goto Cleanup;

            hr = THR_NOTRACE(pMarkup->CollectionCache()->BuildNamedArray(
                CMarkup::ELEMENT_COLLECTION,
                pchFor,
                FALSE,
                &cacheItem,
                0,  // iStartFrom
                pHolder->_fCaseSensitive));
            if (hr)
                goto Cleanup;

            cObjects = cacheItem.Length();
        }

        if (!cObjects)
            goto Cleanup;

        //
        // construct code
        //
        if (!_fCodeConstructed) 
        {
            //
            // get pchEventName and pchFormalParams from pchEvent
            //
            TCHAR *pchNamespace = NULL;

            hr = THR(TokenizeEventDescription((TCHAR*)pchEvent, &_pchEventName, &pchFormalParams));
            if (hr || !_pchEventName)
                goto Cleanup;

            if (!pMarkup->HasWindowPending())
            {
                CMarkupScriptContext *pScriptContext;
                hr = THR(pMarkup->EnsureScriptContext(&pScriptContext));
                if (!hr)
                    pchNamespace = pScriptContext->GetNamespace();
            }

            hr = THR_NOTRACE(pScriptCollection->ConstructCode(
                pchNamespace,       // pchScope
                pchSource,          // pchCode
                pchFormalParams,    // pchFormalParams
                pchLanguage,        // pchLanguage
                pMarkup,            // pMarkup
                pchType,            // pchType
                _ulScriptOffset,    // ulOffset
                _ulScriptLine,      // ulStartingLine
                pMarkup,            // pSourceObject
                0,                  // dwFlags
                &_pDispCode,        // ppDispCode result
                FALSE));            // fSingleLine

            if (hr)
            {                   // if the language does not support code construction
                                // or failed to construct because of syntax error
                hr = S_OK;
                goto Cleanup;
            }

            _fCodeConstructed = TRUE;
        }

        //
        // for each object set the property
        //
        for (iObject = 0; iObject < cObjects; iObject++)
        {
            if(ppBase)
            {
                pObject = ppBase[iObject];
                pElem = NULL;
            }
            else
            {
                pElem = cacheItem.GetAt(iObject);
                pObject = (CBase*)pElem;
            }

            hr = E_FAIL;

            //
            // Get the dispid to use for storing the function pointer.
            //

            //
            // If this object is an olesite, ask the control's event
            // typeinfo if it knows about the name.
            // We need to do this first in order to catch the event as
            // defined by the control rather than by us. (e.g. onclick)
            //
            if (pObject->BaseDesc()->_dwFlags & CElement::ELEMENTDESC_OLESITE)
            {
                pOleSite = DYNCAST(COleSite, pObject);

                pTIEvent = pOleSite->GetClassInfo()->_pTypeInfoEvents;
                if (pTIEvent)
                {
                    hr = THR_NOTRACE(pTIEvent->GetIDsOfNames(
                            &_pchEventName,
                            1,
                            &dispid));
                }
            }

            // if not an olesite or could not find dispid from object in olesite
            if (hr)
            {
                // Note: for special IE3 compatibility we allow case insensitive
                // matching for the EVENT OnLoad attribute.  This is because IE3
                // implemented it as onLoad, and we correctly implement it as
                // onload.  So that sites can use onLoad & work with IE3 until
                // it is gone for good this hack allows us to use onLoad with
                // any case whatsoever.  -TomSn
                hr = THR_NOTRACE(pObject->GetDispID(
                    _pchEventName,
                    (pHolder->_fCaseSensitive && _tcsicmp( _T("onload"), _pchEventName )) ?
                        fdexNameCaseSensitive : 0,
                    &dispid));

                // if could not get a standard event
                if (hr || IsExpandoDispid(dispid))
                {
                    if (!pNonElementPropHost)
                    {
                        CElement * pElement = DYNCAST(CElement, pObject);

                        if (pElement->HasPeerHolder())
                        {
                            hr = THR_NOTRACE(pElement->GetPeerHolder()->GetEventDispidMulti(
                                _pchEventName, &dispid));
                        }
                    }
                    else
                        hr = E_FAIL;

                    if (hr)
                    {
                        hr = S_OK;

                        if (pelTarget)      // this is important so that _fScriptCommitted does not get set
                            goto Cleanup;   // and we force the script element to be recommitted again later

                        continue;
                    }
                }
            }
            Assert(_pDispCode);
            hr = THR(pObject->SetCodeProperty(dispid, fHookup ? _pDispCode : NULL, &fAnyDeleted));
            if (hr)
                goto Cleanup;

            if (pElem && !fAnyDeleted && dispid == DISPID_EVPROP_ONLOAD)
            {
                IHTMLElement2  *pElem2 = NULL;
                long            lRetValue;

                hr = THR(pElem->QueryInterface(IID_IHTMLElement2, (void **)&pElem2));
                if (hr)
                    continue;

                IGNORE_HR(pElem2->get_readyStateValue(&lRetValue));

                ReleaseInterface(pElem2);
                
                if (lRetValue == READYSTATE_COMPLETE)
                {
                    // All onload propdesc's are same, so use any in the absence of one on CElement
                    pElem->FireEvent(&s_propdescCWindowonload);
                }
            }

            //
            // Ensure the private sink from oc's *after* setting the
            // code property so that if the oc immediately fires an
            // event, we can correctly refire into the script engine.
            //
            
            if (pOleSite && fHookup)
            {
                pOleSite->EnsurePrivateSink();
                pOleSite->SetEventsShouldFire();
            }

            // if we add a data event to an element, make sure the event can fire
            CDataMemberMgr::EnsureDataEventsFor(pObject, dispid);
        }
    }

    _fScriptCommitted = TRUE;

Cleanup:
    delete pchFormalParams;

    RRETURN (hr);
}


//+------------------------------------------------------------------------
//
//  Member:     CScriptElement::SetBitsCtx
//
//  Synopsis:   Attaches the script element to a bitsctx to download
//
//-------------------------------------------------------------------------

void CScriptElement::SetBitsCtx(CBitsCtx * pBitsCtx)
{
    CBitsCtx *  pBitsCtxOld = _pBitsCtx;
    
    if (pBitsCtxOld)
    {
        _pBitsCtx = NULL;
        pBitsCtxOld->SetProgSink(NULL); // detach download from document's load progress
        pBitsCtxOld->Disconnect();
        pBitsCtxOld->Release();
    }

    _pBitsCtx = pBitsCtx;

    if (pBitsCtx)
    {
        pBitsCtx->AddRef();

        if (pBitsCtx->GetState() & (DWNLOAD_COMPLETE | DWNLOAD_ERROR | DWNLOAD_STOPPED))
            OnDwnChan(pBitsCtx);
        else
        {
            pBitsCtx->SetProgSink(CMarkup::GetProgSinkHelper(GetMarkup()));
            pBitsCtx->SetCallback(OnDwnChanCallback, this);
            pBitsCtx->SelectChanges(DWNCHG_COMPLETE, 0, TRUE);
        }
    }
}

//+------------------------------------------------------------------------
//
//  Member:     CScriptElement::OnDwnChan
//
//  Synopsis:   Called by the bitsctx to notify of download progress
//
//-------------------------------------------------------------------------

void
CScriptElement::OnDwnChan(CDwnChan * pDwnChan)
{
    HRESULT         hr;
    CDoc *          pDoc = Doc();
    ULONG           ulState;
    char *          pbBuffer = NULL;
    IStream *       pStream = NULL;
    STATSTG         statstg;
    ULONG           cbLen;
    int             cchLen;
    BOOL            fEndCR;
    ULONG           cbRead;
    TCHAR *         pchEnd;
    TCHAR *         pchUrl;
    CMarkup *       pMarkup = GetMarkup();

    Assert(_fSrc);

    // Stress bug fix for # 28132.  CScriptElement seems to be getting destructed
    // half-way through this call.
    Assert(!(IsPassivating() || IsPassivated() || IsDestructing()));
    PrivateAddRef();

    ulState = _pBitsCtx->GetState();
    
    if (ulState & DWNLOAD_COMPLETE)
    {
        pchUrl = (LPTSTR) _pBitsCtx->GetRedirectedUrl();
        if (pchUrl == NULL)
            pchUrl = (LPTSTR) _pBitsCtx->GetUrl();

        BOOL fPendingRoot = FALSE;

        if (IsInMarkup())
            fPendingRoot = pMarkup->IsPendingRoot();

        // If unsecure download, may need to remove lock icon on Doc
        pDoc->OnSubDownloadSecFlags(fPendingRoot, pchUrl, _pBitsCtx->GetSecFlags());
    
        // if load completed OK, load file and convert to unicode
        hr = THR(_pBitsCtx->GetStream(&pStream));

        if (hr)
            goto Cleanup;

        hr = THR(pStream->Stat(&statstg, STATFLAG_NONAME));
        if (hr)
            goto Cleanup;

        cbLen = statstg.cbSize.LowPart;
        if (statstg.cbSize.HighPart || cbLen == 0xFFFFFFFF)
            goto Cleanup;

        pbBuffer = new(Mt(CScriptElementOnDwnChan_pbBuffer)) char[cbLen];
        if (!pbBuffer)
            goto Cleanup;

        hr = THR(pStream->Read(pbBuffer, cbLen, &cbRead));

        if (hr == S_FALSE)
            hr = S_OK;
        else if (hr || cbRead != cbLen)
            goto Cleanup;

        delete [] _pchSrcCode;

        if (cbLen)
        {
            // TODO/NB (cthrash) In IE4, we loaded linked script files by converting the source
            // to Unicode using CP_ACP.  This implied that how the script file was interpreted
            // depended on the system codepage of the UA, i.e. the author had no control over
            // how it was read into the browser.  This was bad.  So for IE5.1, we will load the
            // script file in the document's codepage, usually set in the form of a META tag.
            // This change will surely cause some incompatibilities, but hopefully not in cases
            // we care about.
            //
            // The quirk to this change which may not be immediately obvious to authors is that
            // immediately following a document.write, the document's codepage switches to Unicode
            // (cp1200).  This implies that subsequent linked script files would be loaded in
            // Unicode.  That would be a significant departure from IE4 (in IE4 you could not load
            // a Unicode-encoded script file under any circumstance.)   So the hack here is to load
            // the script file in the 'navigatable' codepage which is the same as the codepage in
            // all cases except Unicode.  The navigateable codepage for Unicode is UTF-8.  This is
            // clearly a hack, but at least all ASCII content is guaranteed to be loaded reliably,
            // and after all, that's the only kind of content you could predictably load in IE4
            // anyway.

//TODO (lmollico): fix this (CScriptElement::put_src in script2.htm)
            LPCTSTR szCharset = GetAAcharset();
            CODEPAGE cp = szCharset ? CodePageFromAlias(szCharset) : CP_UNDEFINED;

            if (cp == CP_UNDEFINED)
            {
                pMarkup = IsInMarkup() ? pMarkup : pDoc->PrimaryMarkup();
                cp = NavigatableCodePage(pMarkup->GetCodePage());
            }

            CToUnicodeConverter tuc(cp);
            HRESULT hr;

#ifdef PERFMETER
            tuc.SetMt(Mt(CScriptElement_pchSrcCode));
#endif

            hr = THR( tuc.Convert( pbBuffer, cbLen, &_pchSrcCode, &cchLen ) );
            if (hr)
                goto Cleanup;
        }
        else
        {
            // Commit code can't deal with NULL _pchSrcCode, so allocate a single-char buffer with NUL.

            _pchSrcCode = new(Mt(CScriptElement_pchSrcCode)) TCHAR[1];

            if (!_pchSrcCode)
                goto Cleanup;

            cchLen = 0;
        }

        fEndCR = FALSE;
        pchEnd = _pchSrcCode + cchLen;
        cchLen -= NormalizerChar(_pchSrcCode, &pchEnd);
        _pchSrcCode[cchLen] = _T('\0');
        
        // these variable are not set correctly in case of <script src = >
        _ulScriptOffset = 0;
        _ulScriptLine = 1;

        if (_pScriptDebugDocument)
        {
            _pScriptDebugDocument->Release();
        }
        {
            CScriptDebugDocument::CCreateInfo   createInfo(IsInMarkup() ? GetMarkup() : pDoc->PrimaryMarkup(), pchUrl, _pchSrcCode);

            hr = THR(CScriptDebugDocument::Create(&createInfo, &_pScriptDebugDocument));
            if (hr)
                goto Cleanup;
        }

        if ((!ParserWillExecute() || _fPastedOrInjected) && IsInMarkup())
        {
            if (!_fPastedOrInjected)
                Execute();
            _fPastedOrInjected = FALSE;
            CommitFunctionPointersCode();
        }
    }
    
Cleanup:
    // even if download failed, tell the cdoc that it's done
    if (ulState & (DWNLOAD_COMPLETE | DWNLOAD_ERROR | DWNLOAD_STOPPED))
    {
        SetReadyStateScript(READYSTATE_LOADED);

        IGNORE_HR(EnsureScriptDownloadLeft());
        
        // stress fix check - bug # 556759
        if (_pBitsCtx != NULL)
        {
            _pBitsCtx->SetProgSink(NULL); // detach download from document's load progress
            SetBitsCtx( NULL );           // No reason to hold on to the data anymore
        }
    }
    
    delete pbBuffer;
    ReleaseInterface(pStream);

    // PrivateRelease() to match the PrivateAddRef() at the beginning of the function.
    PrivateRelease();
}


//+------------------------------------------------------------------------
//
//  Member:     CScriptElement::Notify
//
//  Synopsis:   Handle the STOP message - stop downloading inline script
//
//-------------------------------------------------------------------------

void
CScriptElement::Notify(CNotification *pNF)
{
    HRESULT     hr = S_OK;
    TCHAR      *pchEvent;
    TCHAR      *pchFor;
    CDoc       *pDoc;
    
    super::Notify(pNF);
    switch (pNF->Type())
    {
    case NTYPE_STOP_1:
    case NTYPE_MARKUP_UNLOAD_1:
        if (_pBitsCtx)
            _pBitsCtx->SetLoad(FALSE, NULL, FALSE);
        break;

    case NTYPE_ELEMENT_ENTERTREE:
        if(!_fFirstEnteredTree)
        {
            CMarkup *pMarkup = GetMarkup();
            pDoc = Doc();
            BOOL fRunScript;

            _fFirstEnteredTree = TRUE;

            // TODO (alexz) it is not safe to call SetReadyStateScript or ProcessUrlAction
            // from EnterTree. The first one may fire events, which will execute external code,
            // and the second one may push a message loop for a security message box. These
            // scenarios will lead to crashing bugs in the tree and parser code.
            // This code should be move to Execute phase

            SetReadyStateScript(READYSTATE_LOADING);

            if (IsSpecialUrl(CMarkup::GetUrl(pMarkup)))
            {
                DWORD dwPolicyTo;

                hr = THR(pMarkup->ProcessURLAction(URLACTION_SCRIPT_RUN, 
                                                    &fRunScript,
                                                    0, 
                                                    &dwPolicyTo, 
                                                    pMarkup->GetAAcreatorUrl()));
            }
            else
            {
                hr = THR(pMarkup->ProcessURLAction(URLACTION_SCRIPT_RUN, &fRunScript));
            }

            if (!hr && fRunScript)
            {
                // Do not download script if already done so in put_src
                if (!_fScriptDownloaded)
                {
                    hr = THR(DownLoadScript(TRUE));
                    if (hr)
                        break;
                }

                // commit script only when a newly created\removed script elem enters some tree
                // and it has no src or an already downloaded src as a result of a put_src
                if (!_fSrc || (_pchSrcCode && _fScriptDownloaded))
                {
                    // Commit only dynamically created script elems on behalf of parser.
                    if (!ParserWillExecute())
                    {
                        Execute();
                    }
                }

                pchEvent = (TCHAR *)GetAAevent();
                pchFor = (TCHAR *)GetAAhtmlFor();

                if (pchEvent && *pchEvent && pchFor && *pchFor)
                {
                    //
                    // Set bit on doc telling it to walk script collection.
                    //

                    if (!pMarkup->_fHasScriptForEvent) 
                        pMarkup->_fHasScriptForEvent = TRUE;

                    // commit script only when a newly created\removed script elem enters some tree
                    // and it has no src or an already downloaded src  as a result of a put_src
                    if ((!ParserWillExecute() || _fPastedOrInjected) && (!_fSrc || (_pchSrcCode && _fScriptDownloaded)))
                    {
                        Assert(!pMarkup->_fMarkupServicesParsing);
                        Assert(!_fPastedOrInjected || ParserWillExecute());
                        _fPastedOrInjected = FALSE;
                        CommitFunctionPointersCode();
                    }
        
                    if (pMarkup->_fMarkupServicesParsing)
                        _fPastedOrInjected = TRUE;
                }
            }
        }

        break;

    case NTYPE_ELEMENT_EXITTREE_1:
        {
            // No longer under parser control, once removed from tree after being committed once.
            BOOL fMarkupDestroy = pNF->DataAsDWORD() & EXITTREE_DESTROY;

            // No longer under parser control, once removed from tree after being committed once
            if (_fScriptCommitted)
                SetParserWillExecute(FALSE);

            // unhook code on all objects associated with this (user created, not by parser)
            // script elem 
            if (!fMarkupDestroy)
            {
                if (!ParserWillExecute())
                {
                    pchEvent = (TCHAR *)GetAAevent();
                    // For now, don't allow inline script block to be reexecuted if it enters
                    // another markup later.
                    if (!pchEvent)
                        break;

                    CommitFunctionPointersCode(NULL, FALSE);
            
                    // Allow hook up when it enters some tree again.
                    _fScriptCommitted = FALSE;
                }

                // unblock script execution - stress fix check - bug # 556786
                CMarkup * pMarkup = GetMarkup();

                if (_dwScriptDownloadCookie && pMarkup)
                {
                    _markupCookie = pMarkup;
                    _markupCookie->AddRef();
                    pNF->SetSecondChanceRequested();
                }
            }
            else
            {
                SetBitsCtx(NULL);
                _fScriptCommitted = FALSE;
            }

            IGNORE_HR(EnsureSourceObjectRevoked());

            _fFirstEnteredTree = FALSE;
        }
        break;

    case NTYPE_ELEMENT_EXITTREE_2:

        if (_dwScriptDownloadCookie)
        {
            Assert(_markupCookie);
            _markupCookie->UnblockScriptExecution(&_dwScriptDownloadCookie);
            _dwScriptDownloadCookie = NULL;
            _markupCookie->Release();
            _markupCookie = NULL;
        }
        break;
    }
}

HRESULT
CScriptElement::DownLoadScript(BOOL fShare)
{
    HRESULT         hr = S_OK;
    CDoc *          pDoc = Doc();
    const TCHAR *   pchUrl = GetAAsrc();
    CBitsCtx *      pBitsCtx = NULL;

    if (pchUrl && *pchUrl)
    {
        _fSrc = TRUE;

        CHtmlComponent *pComponent = NULL;
        CMarkup *pMarkup = GetMarkup();

        if (fShare && pMarkup && pMarkup->HasBehaviorContext())
        {
            pComponent = pMarkup->BehaviorContext()->_pHtmlComponent;
        }

        if (!pComponent || pComponent->_fFactoryComponent || !pComponent->_pConstructor->_pelFactoryScript)
        {
            BOOL fPendingRoot = FALSE;

            if (IsInMarkup())
                fPendingRoot = pMarkup->IsPendingRoot();

            hr = THR(pDoc->NewDwnCtx(DWNCTX_BITS, pchUrl, this,
                        (CDwnCtx **)&pBitsCtx, fPendingRoot, FALSE, PROGSINK_CLASS_CONTROL));
            if (hr)
                goto Cleanup;

            // IE5: don't block parser for script download if DEFER attribute is present
            // (we leave _dwScriptCookie NULL in this case)
        
            Assert(!_dwScriptDownloadCookie);
        
            if (VB_FALSE == GetAAdefer())
            {
                if (IsInMarkup())
                {
                    pMarkup->BlockScriptExecution(&_dwScriptDownloadCookie);
                    Assert(_dwScriptDownloadCookie);
                }
            }
        
            SetBitsCtx(pBitsCtx);
        }
        else
        {
            Assert(!pComponent->_fFactoryComponent);
            Assert(pComponent->_pConstructor->_pFactoryComponent->_fClonedScript);
            Assert(pComponent->_pConstructor->_pelFactoryScript);
            Assert(pComponent->_pConstructor->_pFactoryComponent->_pMarkup == pComponent->_pConstructor->_pelFactoryScript->GetMarkup());
            Assert(pComponent->_pConstructor->_pelFactoryScript->_pchSrcCode);
            _pchSrcCode = pComponent->_pConstructor->_pelFactoryScript->_pchSrcCode;
            _fSharedCode = TRUE;

            // these variable are not set correctly in case of <script src = >
            _ulScriptOffset = 0;
            _ulScriptLine = 1;

            if (_pScriptDebugDocument)
            {
                _pScriptDebugDocument->Release();
            }
            {
                CScriptDebugDocument::CCreateInfo   createInfo(IsInMarkup() ? pMarkup : pDoc->PrimaryMarkup(), (LPTSTR)pchUrl, _pchSrcCode);

                hr = THR(CScriptDebugDocument::Create(&createInfo, &_pScriptDebugDocument));
                if (hr)
                    goto Cleanup;
            }

            if ((!ParserWillExecute() || _fPastedOrInjected) && IsInMarkup())
            {
                if (!_fPastedOrInjected)
                    Execute();
                _fPastedOrInjected = FALSE;
                CommitFunctionPointersCode();
            }

            SetReadyStateScript(READYSTATE_LOADED);
        }
    }
    else
        _fSrc = FALSE;

Cleanup:
    if (pBitsCtx)
        pBitsCtx->Release();

    return hr;
}

HRESULT
CScriptElement::Execute()
{
    HRESULT         hr = S_OK;
    HRESULT         hr2;
    VARIANT_BOOL    vbDefer = GetAAdefer();
    CDoc *          pDoc = Doc();
    CMarkup *       pMarkup = GetMarkup();

    CDoc::CLock Lock(pDoc);

    if (!pMarkup)
        goto Cleanup;

    // if no defer attribute set, or we're not inside the parser, commit code now
    if (VB_FALSE == vbDefer || !ParserWillExecute())
    {
        //
        // Any script tags that don't have the defer attribute specified
        // are not sent to the script engine when pasting.  This is to
        // prevent document.write problems and more seriously exposing
        // the paste tree to object model before it's been spliced into
        // the main tree.
        //

        if (pMarkup->_fMarkupServicesParsing)
            return S_OK;

        if (_fSrc && pMarkup->IsInScriptExecution())
        {
            // commit after inline scripts are complete
            RRETURN(THR(pMarkup->EnqueueScriptToCommit(this)));
        }
        else
        {
            CWindow *pWindow = NULL;

            // execute should not be called on a script element that is not in a markup
            Assert (pMarkup);

            // Abort script execution in print mode
            // This scenario only appears to come up for HTCs
            if ( pMarkup->DontRunScripts() )
                goto Cleanup;

            // commit immediately
            hr = THR(pMarkup->EnterScriptExecution(&pWindow));
            if (hr)
                goto Cleanup;

            hr2 = THR(CommitCode());

            hr = THR(pMarkup->LeaveScriptExecution(pWindow));
            if (hr2)
                hr = hr2;

            if (hr)
                goto Cleanup;
        }
    }
    else
    {
        // when parsing a script tag with the defer attribute, we want to
        // commit after all downloads are complete
        RRETURN(THR(pDoc->DeferScript(this)));
    }

    Assert(VB_FALSE != vbDefer || !pMarkup->_fMarkupServicesParsing);

Cleanup:
    RRETURN(hr);
}

//+---------------------------------------------------------------------------
//
//  Member:     CScriptElement::OnReadyStateChange
//
//----------------------------------------------------------------------------

void
CScriptElement::OnReadyStateChange()
{   // do not call super::OnReadyStateChange here - we handle firing the event ourselves
    SetReadyStateScript(_readyStateScript);
}

void
CScriptElement::FireOnReadyStateChange(DWORD_PTR dwContext)
{
    Fire_onreadystatechange();
}

//+------------------------------------------------------------------------
//
//  Member:     CScriptElement::SetReadyStateScript
//
//  Synopsis:   Use this to set the ready state;
//              it fires OnReadyStateChange if needed.
//
//  Returns:    void
//
//-------------------------------------------------------------------------
void
CScriptElement::SetReadyStateScript(long readyStateScript)
{
    long readyState;

    _readyStateScript = readyStateScript;

    readyState = min ((long)_readyStateScript, super::GetReadyState());

    if ((long)_readyStateFired != readyState)
    {
        _readyStateFired = readyState;

        GWPostMethodCall(this, ONCALL_METHOD(CScriptElement, FireOnReadyStateChange, fireonreadystatechange), 0, FALSE, "CScriptElement::FireOnReadyStateChange");
    }
}


//+----------------------------------------------------------------------------
//
//  Member:     CScriptElement:get_readyState
//
//+------------------------------------------------------------------------------

HRESULT
CScriptElement::get_readyState(BSTR * p)
{
    HRESULT hr = S_OK;

    if (!p)
    {
        hr = E_POINTER;
        goto Cleanup;
    }

    hr=THR(s_enumdeschtmlReadyState.StringFromEnum(_readyStateFired, p));

Cleanup:
    RRETURN(SetErrorInfo(hr));
}

HRESULT
CScriptElement::get_readyState(VARIANT * pVarRes)
{
    HRESULT hr = S_OK;

    if (!pVarRes)
    {
        hr = E_POINTER;
        goto Cleanup;
    }

    hr = get_readyState(&V_BSTR(pVarRes));
    if (!hr)
        V_VT(pVarRes) = VT_BSTR;

Cleanup:
    RRETURN(SetErrorInfo(hr));
}

STDMETHODIMP CScriptElement::put_src(BSTR v)
{
    HRESULT hr;
    BOOL fRunScript;
    CMarkup *pMU;

    hr = THR(put_StringHelper(v, (const PROPERTYDESC *)&s_propdescCScriptElementsrc));
    if (hr)
        goto Cleanup;

    pMU = GetMarkupPtr();
    if ( !pMU )
        pMU = Doc()->PrimaryMarkup();

    Assert( pMU );
    
    hr = THR(pMU->ProcessURLAction(URLACTION_SCRIPT_RUN, &fRunScript));
    if (hr)
        goto Cleanup;

    if (!fRunScript)
        goto Cleanup;
    
    _fCodeConstructed = FALSE;
    if (!_fSharedCode)
        delete [] _pchSrcCode;
    _pchSrcCode = NULL;


//    if (_fDownloadContent) // TODO(sramani)
    {
        // Make sure script will be committed\executed after download is finished.
        SetParserWillExecute(FALSE);

        hr = THR(DownLoadScript());
        if (hr)
            goto Cleanup;

        // flag that we have already downloaded script: in case script elem is
        // removed from some tree and inserted back in, or a newly created script
        // elem enters some tree, we don't want to download again on SN_ENTERTREE
        _fScriptDownloaded = _fSrc;
    }
//    else
//        _fScriptDownloaded = FALSE;

    // if the src is being removed, hook up again if the script elem
    // is in some tree and it has code.
    if (IsInMarkup() && !_fSrc && _cstrText)
    {
        hr = THR(Execute());
        if (hr)
            goto Cleanup;
        
        hr = THR(CommitFunctionPointersCode());
    }
    else
        _fSharedCode = FALSE;

Cleanup:
    return SetErrorInfo(hr);
}

STDMETHODIMP CScriptElement::put_htmlFor(BSTR v)
{
    // unhook current event sink for the old htmlFor
    if (IsInMarkup())
        CommitFunctionPointersCode(NULL, FALSE);

    // hook up this sink as the new one for <v>
    return SetPropertyHelper(v, (const PROPERTYDESC *)&s_propdescCScriptElementhtmlFor);
}

STDMETHODIMP CScriptElement::put_event(BSTR v)
{
    // TODO: don't allow inline script blocks to be converted to event handlers,
    // until namespace movement support is provided by script engine in IE6
    if (_fScriptCommitted && !GetAAevent())
        return SetErrorInfo(E_UNEXPECTED);

    // unhook event sink for all objects listening to current event.
    if (IsInMarkup())
        CommitFunctionPointersCode(NULL, FALSE);

    _fCodeConstructed = FALSE;
    return SetPropertyHelper(v, (const PROPERTYDESC *)&s_propdescCScriptElementevent);
}

STDMETHODIMP CScriptElement::put_text(BSTR v)
{
    _fCodeConstructed = FALSE;
    if (_fSharedCode)
    {
        _cstrText.SetPch(NULL);
        _fSharedCode = FALSE;
    }
    return SetPropertyHelper(v, (const PROPERTYDESC *)&s_propdescCScriptElementtext);
}

STDMETHODIMP CScriptElement::SetPropertyHelper(BSTR v, const PROPERTYDESC *pPropDesc)
{
    HRESULT hr;
    BOOL fRunScript;
    CMarkup *pMU;

    hr = THR(put_StringHelper(v, pPropDesc));
    if (hr)
        goto Cleanup;

    pMU = GetMarkupPtr();
    if ( !pMU )
        pMU = Doc()->PrimaryMarkup();

    Assert( pMU );
    
    hr = THR(pMU->ProcessURLAction(URLACTION_SCRIPT_RUN, &fRunScript));
    if (hr)
        goto Cleanup;

    if (!fRunScript)
        goto Cleanup;

    // Allow code to be committed\executed if not yet done, but script tag
    // is present on the page.
    SetParserWillExecute(FALSE);

    // if script elem in any tree, then commit its code now, else
    // do it when it enters some tree
    if (IsInMarkup())
    {
        hr = THR(Execute());
        if (hr)
            goto Cleanup;

        hr = THR(CommitFunctionPointersCode());
    }

Cleanup:
    return hr;
}

STDMETHODIMP CScriptElement::get_src(BSTR *p)
{
    HRESULT hr = get_PropertyHelper(p, (const PROPERTYDESC *)&s_propdescCScriptElementsrc);

    if (SUCCEEDED(hr) && (*p != NULL) && (_pBitsCtx != NULL) && (_pBitsCtx->GetRedirectedUrl() != NULL))
    {
        if (SysReAllocString(p, (OLECHAR*) _pBitsCtx->GetRedirectedUrl()))
            hr = S_OK;
        else
            hr = E_OUTOFMEMORY;
    }

    return hr;
}

STDMETHODIMP CScriptElement::get_htmlFor(BSTR *p)
{
    return get_PropertyHelper(p, (const PROPERTYDESC *)&s_propdescCScriptElementhtmlFor);
}

STDMETHODIMP CScriptElement::get_event(BSTR *p)
{
    return get_PropertyHelper(p, (const PROPERTYDESC *)&s_propdescCScriptElementevent);
}

STDMETHODIMP CScriptElement::get_text(BSTR *p)
{
    return get_PropertyHelper(p, (const PROPERTYDESC *)&s_propdescCScriptElementtext);
}
