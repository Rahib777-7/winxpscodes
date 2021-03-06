// Functions stolen from shdocvw\util.cpp

#include "stdafx.h"
#pragma hdrstop
#include "dsubscri.h"


//+-----------------------------------------------------------------
//
// Helper function for getting the TopLeft point of an element from
//      mshtml.dll, and have the point reported in inside relative
//      coordinates (inside margins, borders and padding.)
//-----------------------------------------------------------------
HRESULT CSSOM_TopLeft(IHTMLElement * pIElem, POINT * ppt) 
{
    HRESULT       hr = E_FAIL;
    IHTMLStyle    *pistyle;

    if (SUCCEEDED(pIElem->get_style(&pistyle)) && pistyle) {
        VARIANT var = {0};

        if (SUCCEEDED(pistyle->get_top(&var)) && var.bstrVal) {
            ppt->y = StrToIntW(var.bstrVal);
            VariantClear(&var);

            if (SUCCEEDED(pistyle->get_left(&var)) && var.bstrVal) {
                ppt->x = StrToIntW(var.bstrVal);
                VariantClear(&var);
                hr = S_OK;
            }
        }

        pistyle->Release();
    }

    return hr;
}

HRESULT GetHTMLElementStrMember(IHTMLElement *pielem, LPTSTR pszName, DWORD cchSize, BSTR bstrMember)
{
    HRESULT hr;
    VARIANT var = {0};

    if (!pielem)
        hr = E_INVALIDARG;
    else if (SUCCEEDED(hr = pielem->getAttribute(bstrMember, TRUE, &var)))
    {
        if ((VT_BSTR == var.vt) && (var.bstrVal))
        {
#ifdef UNICODE          
            StrCpyNW(pszName, (LPCWSTR)var.bstrVal, cchSize);
#else // UNICODE
            SHUnicodeToAnsi((BSTR)var.bstrVal, pszName, cchSize);
#endif // UNICODE
        }
        else
            hr = E_FAIL; // Try VariantChangeType?????

        VariantClear(&var);
    }

    return hr;
}

/******************************************************************\
    FUNCTION: IElemCheckForExistingSubscription()

    RETURN VALUE:
    S_OK    - if the IHTMLElement points to a TAG that has a "subscribed_url" property
              that is subscribed. 
    S_FALSE - if the IHTMLElement points to a TAG that has a
              "subscribed_url" property but the URL is not subscribed.
    E_FAIL  - if the IHTMLElement points to a TAG that does not
              have a  "subscribed_url" property.
\******************************************************************/
HRESULT IElemCheckForExistingSubscription(IHTMLElement *pielem)
{
    HRESULT hr = E_FAIL;
    TCHAR szHTMLElementName[MAX_URL_STRING];

    if (!pielem)
        return E_INVALIDARG;

    if (SUCCEEDED(GetHTMLElementStrMember(pielem, szHTMLElementName, SIZECHARS(szHTMLElementName), (BSTR)(s_sstrSubSRCMember.wsz))))
        hr = (CheckForExistingSubscription(szHTMLElementName) ? S_OK : S_FALSE);

    return hr;
}

HRESULT IElemCloseDesktopComp(IHTMLElement *pielem)
{
    HRESULT hr = E_INVALIDARG;
    TCHAR szHTMLElementID[MAX_URL_STRING];

    ASSERT(pielem);
    if (pielem &&
        SUCCEEDED(hr = GetHTMLElementStrMember(pielem, szHTMLElementID, SIZECHARS(szHTMLElementID), (BSTR)(s_sstrIDMember.wsz))))
    {
        hr = UpdateComponentFlags(szHTMLElementID, COMP_CHECKED | COMP_UNCHECKED, COMP_UNCHECKED) ? S_OK : E_FAIL;
        ASSERT(SUCCEEDED(hr));
        if (SUCCEEDED(hr))
        {
            //
            // This IElemCloseDesktopComp() is called from DeskMovr code when a component is
            // closed. If this component is the only active desktop component, then calling
            // REFRESHACTIVEDESKTOP() here will result in ActiveDesktop being turned off.
            // This will free the DeskMovr, which is an ActiveX control on the desktop web page.
            // So, when IElemCloseDesktopComp() returns to the caller, the DeskMovr code continues
            // to execute; but the object had been freed and hence a fault occurs soon.
            // The fix for this problem is to avoid refreshing the active desktop until a better
            // time. So, we post a private message to the desktop window. When that window receives
            // this message, we call REFRESHACTIVEDESKTOP().
            
            PostMessage(GetShellWindow(), DTM_REFRESHACTIVEDESKTOP, (WPARAM)0, (LPARAM)0);
        }
    }

    return hr;
}

HRESULT IElemGetSubscriptionsDialog(IHTMLElement *pielem, HWND hwnd)
{
    HRESULT hr;
    TCHAR szHTMLElementName[MAX_URL_STRING];

    ASSERT(pielem);
    if (SUCCEEDED(hr = GetHTMLElementStrMember(pielem, szHTMLElementName, SIZECHARS(szHTMLElementName), (BSTR)(s_sstrSubSRCMember.wsz))))
    {
        ASSERT(CheckForExistingSubscription(szHTMLElementName)); // We should not have gotten this far.
        hr = ShowSubscriptionProperties(szHTMLElementName, hwnd);
    }

    return hr;
}

HRESULT IElemSubscribeDialog(IHTMLElement *pielem, HWND hwnd)
{
    HRESULT hr;
    TCHAR szHTMLElementName[MAX_URL_STRING];

    ASSERT(pielem);
    hr = GetHTMLElementStrMember(pielem, szHTMLElementName, SIZECHARS(szHTMLElementName), (BSTR)(s_sstrSubSRCMember.wsz));
    if (SUCCEEDED(hr))
    {
        ASSERT(!CheckForExistingSubscription(szHTMLElementName)); // We should not have gotten this far.
        hr = CreateSubscriptionsWizard(SUBSTYPE_DESKTOPURL, szHTMLElementName, NULL, hwnd);
    }

    return hr;
}

HRESULT IElemUnsubscribe(IHTMLElement *pielem)
{
    HRESULT hr;
    TCHAR szHTMLElementName[MAX_URL_STRING];

    ASSERT(pielem);
    hr = GetHTMLElementStrMember(pielem, szHTMLElementName, SIZECHARS(szHTMLElementName), (BSTR)(s_sstrSubSRCMember.wsz));
    if (SUCCEEDED(hr))
    {
        ASSERT(CheckForExistingSubscription(szHTMLElementName)); // We should not have gotten this far.
        hr = DeleteFromSubscriptionList(szHTMLElementName) ? S_OK : S_FALSE;
    }

    return hr;
}

HRESULT IElemUpdate(IHTMLElement *pielem)
{
    HRESULT hr;
    TCHAR szHTMLElementName[MAX_URL_STRING];

    ASSERT(pielem);
    hr = GetHTMLElementStrMember(pielem, szHTMLElementName, SIZECHARS(szHTMLElementName), (BSTR)(s_sstrSubSRCMember.wsz));
    if (SUCCEEDED(hr))
    {
        ASSERT(CheckForExistingSubscription(szHTMLElementName)); // We should not have gotten this far.
        hr = UpdateSubscription(szHTMLElementName) ? S_OK : S_FALSE;
    }

    return hr;
}

HRESULT IElemOpenInNewWindow(IHTMLElement *pielem, IOleClientSite *piOCSite, BOOL fShowFrame, LONG width, LONG height)
{
    HRESULT hr;
    TCHAR szTemp[MAX_URL_STRING];
    BSTR bstrURL;

    ASSERT(pielem);

    hr = GetHTMLElementStrMember(pielem, szTemp, SIZECHARS(szTemp), (BSTR)(s_sstrSubSRCMember.wsz));

    if (SUCCEEDED(hr) && (bstrURL = SysAllocStringT(szTemp)))
    {
        IHTMLWindow2 *pihtmlWindow2, *pihtmlWindow2New = NULL;
        BSTR bstrFeatures = 0;

        if (!fShowFrame)
        {
            wnsprintf(szTemp, ARRAYSIZE(szTemp), TEXT("height=%li, width=%li, status=no, toolbar=no, menubar=no, location=no, resizable=no"), height, width);
            bstrFeatures = SysAllocString((OLECHAR FAR *)szTemp);
        }

        hr = IUnknown_QueryService(piOCSite, SID_SHTMLWindow, IID_IHTMLWindow2, (LPVOID*)&pihtmlWindow2);

        if (SUCCEEDED(hr) && pihtmlWindow2)
        {
            pihtmlWindow2->open(bstrURL, NULL, bstrFeatures, NULL, &pihtmlWindow2New);
            pihtmlWindow2->Release();
            ATOMICRELEASE(pihtmlWindow2New);
        }

        SysFreeString(bstrURL);
        if (bstrFeatures)
            SysFreeString(bstrFeatures);
    }

    return hr;
}

HRESULT ShowSubscriptionProperties(LPCTSTR pszUrl, HWND hwnd)
{
    HRESULT hr;
    ISubscriptionMgr *psm;

    if (SUCCEEDED(hr = CoCreateInstance(CLSID_SubscriptionMgr, NULL,
                          CLSCTX_INPROC_SERVER, IID_ISubscriptionMgr,
                          (void**)&psm)))
    {
        WCHAR wszUrl[MAX_URL_STRING];

        SHTCharToUnicode(pszUrl, wszUrl, ARRAYSIZE(wszUrl));

        hr = psm->ShowSubscriptionProperties(wszUrl, hwnd);
        psm->Release();
    }

    return hr;
}

HRESULT CreateSubscriptionsWizard(SUBSCRIPTIONTYPE subType, LPCTSTR pszUrl, SUBSCRIPTIONINFO *pInfo, HWND hwnd)
{
    HRESULT hr;
    ISubscriptionMgr *psm;

    if (SUCCEEDED(hr = CoCreateInstance(CLSID_SubscriptionMgr, NULL,
                          CLSCTX_INPROC_SERVER, IID_ISubscriptionMgr,
                          (void**)&psm)))
    {
        WCHAR wzURL[MAX_URL_STRING];
        LPCWSTR pwzURL = wzURL;

#ifndef UNICODE
        SHAnsiToUnicode(pszUrl, wzURL, ARRAYSIZE(wzURL));
#else // UNICODE
        pwzURL = pszUrl;
#endif // UNICODE

        hr = psm->CreateSubscription(hwnd, pwzURL, pwzURL, CREATESUBS_ADDTOFAVORITES, subType, pInfo);
        psm->UpdateSubscription(pwzURL);
        psm->Release();
    }

    return hr;
}
