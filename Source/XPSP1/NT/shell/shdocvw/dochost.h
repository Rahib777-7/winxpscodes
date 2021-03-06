#include "dhuihand.h"
#include "iface.h"
#include "dspsprt.h"
#include "privacyui.hpp"

#ifdef UNIX
#define MAIL_ACTION_SEND    1
#define MAIL_ACTION_READ    2
#endif

#define MAX_SCRIPT_ERR_CACHE_SIZE   20

class CDocObjectHost;
interface IToolbarExt;
interface IHTMLPrivateWindow;
interface IPrivacyServices;

//
// script error handling
// support for caching errors and displaying them when the script error icon
// on the status bar is clicked by the user
//

class CScriptErrorList : public CImpIDispatch,
                         public IScriptErrorList
{
public:
    CScriptErrorList();
    ~CScriptErrorList();

    BOOL    IsEmpty()
        { return _hdpa != NULL && DPA_GetPtrCount(_hdpa) == 0; }
    BOOL    IsFull()
        { return _hdpa != NULL && DPA_GetPtrCount(_hdpa) >= MAX_SCRIPT_ERR_CACHE_SIZE; }

    HRESULT AddNewErrorInfo(LONG    lLine,
                            LONG    lChar,
                            LONG    lCode,
                            BSTR    strMsg,
                            BSTR    strUrl);
    void    ClearErrorList();

    // IUnknown
    STDMETHODIMP            QueryInterface(REFIID, void **);
    STDMETHODIMP_(ULONG)    AddRef();
    STDMETHODIMP_(ULONG)    Release();

    // IDispatch
    STDMETHODIMP GetTypeInfoCount(UINT * pctinfo)
        { return CImpIDispatch::GetTypeInfoCount(pctinfo); }
    STDMETHODIMP GetTypeInfo(UINT itinfo, LCID lcid, ITypeInfo * * pptinfo)
        { return CImpIDispatch::GetTypeInfo(itinfo, lcid, pptinfo); }
    STDMETHODIMP GetIDsOfNames(REFIID riid, OLECHAR * * rgszNames, UINT cNames, LCID lcid, DISPID * rgdispid)
        { return CImpIDispatch::GetIDsOfNames(riid, rgszNames, cNames, lcid, rgdispid); }
    STDMETHODIMP Invoke(DISPID dispidMember, REFIID riid, LCID lcid, WORD wFlags, DISPPARAMS * pdispparams, VARIANT * pvarResult, EXCEPINFO * pexcepinfo, UINT * puArgErr)
        { return CImpIDispatch::Invoke(dispidMember, riid, lcid, wFlags, pdispparams, pvarResult, pexcepinfo, puArgErr); }

    // IScriptErrorList
    STDMETHODIMP    advanceError();
    STDMETHODIMP    retreatError();
    STDMETHODIMP    canAdvanceError(BOOL * pfCanAdvance);
    STDMETHODIMP    canRetreatError(BOOL * pfCanRetreat);
    STDMETHODIMP    getErrorLine(LONG * plLine);
    STDMETHODIMP    getErrorChar(LONG * plChar);
    STDMETHODIMP    getErrorCode(LONG * plCode);
    STDMETHODIMP    getErrorMsg(BSTR * pstrMsg);
    STDMETHODIMP    getErrorUrl(BSTR * pstrUrl);
    STDMETHODIMP    getAlwaysShowLockState(BOOL * pfAlwaysShowLock);
    STDMETHODIMP    getDetailsPaneOpen(BOOL * pfDetailsPaneOpen);
    STDMETHODIMP    setDetailsPaneOpen(BOOL fDetailsPaneOpen);
    STDMETHODIMP    getPerErrorDisplay(BOOL * pfPerErrorDisplay);
    STDMETHODIMP    setPerErrorDisplay(BOOL fPerErrorDisplay);

private:
    class _CScriptErrInfo
    {
    public:
        ~_CScriptErrInfo();

        HRESULT Init(LONG lLine, LONG lChar, LONG lCode, BSTR strMsg, BSTR strUrl);

        LONG    _lLine;
        LONG    _lChar;
        LONG    _lCode;
        BSTR    _strMsg;
        BSTR    _strUrl;
    };

    HDPA    _hdpa;
    LONG    _lDispIndex;
    ULONG   _ulRefCount;
};

// The dochost and docview need to talk to eachother. We can't use the IOleCommandTarget
// because there's no direction associated with that. Create two different interfaces
// for now becuz that'll probably be useful if we ever make dochost a CoCreateable thing
// so we can share hosting code with shell32.
// (We can coalesce them into one interface later if they don't diverge.)

//
// IDocHostObject
//
EXTERN_C const GUID IID_IDocHostObject;   //67431840-C511-11CF-89A9-00A0C9054129

#undef  INTERFACE
#define INTERFACE  IDocHostObject
DECLARE_INTERFACE_(IDocHostObject, IUnknown)
{
    // *** IUnknown methods ***
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, void **ppv) PURE;
    STDMETHOD_(ULONG,AddRef)(THIS) PURE;
    STDMETHOD_(ULONG,Release)(THIS) PURE;

    // *** IDocHostObject methods ***
    virtual STDMETHODIMP OnQueryStatus(const GUID *pguidCmdGroup,
        ULONG cCmds, OLECMD rgCmds[], OLECMDTEXT *pcmdtext, HRESULT hres) PURE;
    virtual STDMETHODIMP OnExec(const GUID *pguidCmdGroup,
        DWORD nCmdID, DWORD nCmdexecopt, VARIANTARG *pvarargIn, VARIANTARG *pvarargOut) PURE;
    virtual STDMETHODIMP QueryStatusDown(const GUID *pguidCmdGroup,
        ULONG cCmds, OLECMD rgCmds[], OLECMDTEXT *pcmdtext) PURE;
    virtual STDMETHODIMP ExecDown(const GUID *pguidCmdGroup,
        DWORD nCmdID, DWORD nCmdexecopt, VARIANTARG *pvarargIn, VARIANTARG *pvarargOut) PURE;
} ;


//
//  This is a proxy IOleInPlaceActiveObject class. The interface to this
// object will be passed to the IOleInPlaceUIWindow interface of the browser
// if it support it.
//
class CProxyActiveObject : public IOleInPlaceActiveObject
{
public:
    // *** IUnknown methods ***
    STDMETHODIMP QueryInterface(REFIID riid, void ** ppvObj);
    virtual STDMETHODIMP_(ULONG) AddRef(void) ;
    virtual STDMETHODIMP_(ULONG) Release(void);

    // *** IOleWindow methods ***
    STDMETHODIMP GetWindow(HWND * lphwnd);
    STDMETHODIMP ContextSensitiveHelp(BOOL fEnterMode);

    // *** IOleInPlaceActiveObject ***
    STDMETHODIMP TranslateAccelerator(LPMSG lpmsg);
    STDMETHODIMP OnFrameWindowActivate(
        BOOL fActivate);
    STDMETHODIMP OnDocWindowActivate(
        BOOL fActivate);
    STDMETHODIMP ResizeBorder(
        LPCRECT prcBorder,
        IOleInPlaceUIWindow *pUIWindow,
        BOOL fFrameWindow);
    STDMETHODIMP EnableModeless(
        BOOL fEnable);

    void Initialize(CDocObjectHost* pdoh) { _pdoh = pdoh; }

    IOleInPlaceActiveObject *GetObject() { return _piact;}
    HWND GetHwnd() {return _hwnd;}
    void SetActiveObject(IOleInPlaceActiveObject * );
protected:


    CDocObjectHost* _pdoh;
    IOleInPlaceActiveObject*    _piact; // non-NULL while UI-active
    HWND _hwnd;
};


//  This is a proxy IOleInPlaceFrame class. The interfaces to this object
// will be passed to in-place active object.
//
class CDocObjectFrame : public IOleInPlaceFrame
                      , public IOleCommandTarget
                      , public IServiceProvider
                      , public IInternetSecurityMgrSite
{
public:
    // *** IUnknown methods ***
    STDMETHODIMP QueryInterface(REFIID riid, void ** ppvObj);
    virtual STDMETHODIMP_(ULONG) AddRef(void) ;
    virtual STDMETHODIMP_(ULONG) Release(void);

    // *** IOleWindow methods ***
    STDMETHODIMP GetWindow(HWND * lphwnd);
    STDMETHODIMP ContextSensitiveHelp(BOOL fEnterMode);

    // IOleInPlaceUIWindow (also IOleWindow)
    STDMETHODIMP GetBorder(LPRECT lprectBorder);
    STDMETHODIMP RequestBorderSpace(LPCBORDERWIDTHS pborderwidths);
    STDMETHODIMP SetBorderSpace(LPCBORDERWIDTHS pborderwidths);
    STDMETHODIMP SetActiveObject(
        IOleInPlaceActiveObject *pActiveObject, LPCOLESTR pszObjName);

    // IOleInPlaceFrame (also IOleInPlaceUIWindow)
    STDMETHODIMP InsertMenus(HMENU hmenuShared, LPOLEMENUGROUPWIDTHS lpMenuWidths);
    STDMETHODIMP SetMenu(HMENU hmenuShared, HOLEMENU holemenu, HWND hwndActiveObject);
    STDMETHODIMP RemoveMenus(HMENU hmenuShared);
    STDMETHODIMP SetStatusText(LPCOLESTR pszStatusText);
    STDMETHODIMP EnableModeless(BOOL fEnable);
    STDMETHODIMP TranslateAccelerator(LPMSG lpmsg, WORD wID);

    // IOleCommandTarget
    STDMETHODIMP QueryStatus(const GUID *pguidCmdGroup,
        ULONG cCmds, OLECMD rgCmds[], OLECMDTEXT *pcmdtext);
    STDMETHODIMP Exec(const GUID *pguidCmdGroup,
        DWORD nCmdID, DWORD nCmdexecopt, VARIANTARG *pvarargIn, VARIANTARG *pvarargOut);

    // IServiceProvider (must be QI'able from IOleClientSite)
    STDMETHODIMP QueryService(REFGUID guidService,
                                    REFIID riid, void **ppvObj);

    // *** IInternetSecurityMgrSite methods ***
    // STDMETHODIMP GetWindow(HWND * lphwnd) { return IOleWindow::GetWindow(lphwnd); }
    // STDMETHODIMP EnableModeless(BOOL fEnable) { return IOleInPlaceFrame::EnableModeless(fEnable); }

public:
    void Initialize(CDocObjectHost* pdoh) { _pdoh = pdoh; }
protected:
    CDocObjectHost* _pdoh;
};

//
// LATER: Move it to a private, but shared header later.
//
//   BROWSERFLAG_OPENCOPY               - make a copy of object (Excel)
//   BROWSERFLAG_OPENVERB               - use OLEIVERB_OPEN instead of PRIMARY
//   BROWSERFLAG_SETHOSTNAME            - set HostName
//   BROWSERFLAG_DONTINPLACE            - Never in-place activate
//   BROWSERFLAG_CANOPENFILEMULTIPETIMES- 
//   BROWSERFLAG_DONTUIDEACTIVATE       - Never UI-deactivate 
//   BROWSERFLAG_NEVERERASEBKGND        - Never erase background (Trident)
//   BROWSERFLAG_PRINTPROMPTUI          - Don't pass DONPROMPTUI for PRINT (PPT)
//   BROWSERFLAG_SUPPORTTOP             - Handles Navigate("#top")
//   BROWSERFLAG_INITNEWTOKEEP          - IPS::InitNew to keep it running
//   BROWSERFLAG_DONTAUTOCLOSE          - Don't auto close on first navigate w/ no OLE object
//   BROWSERFLAG_REPLACE                - Don't use hard-coded flags
//   BROWSERFLAG_DONTCACHESERVER        - Don't cache the server.
//   BROWSERFLAG_ENABLETOOLSBUTTON      - Ignore when QueryStatus doesn't set enabled flag (Visio)
//   BROWSERFLAG_SAVEASWHENCLOSING      - Show the Save As dialog instead of attempting to save (Visio)  
//
#define BROWSERFLAG_OPENCOPY                0x00000001
#define BROWSERFLAG_OPENVERB                0x00000002
#define BROWSERFLAG_SETHOSTNAME             0x00000004
#define BROWSERFLAG_DONTINPLACE             0x00000008
#define BROWSERFLAG_CANOPENFILEMULTIPETIMES 0x00000010
#define BROWSERFLAG_DONTUIDEACTIVATE        0x00000020
#define BROWSERFLAG_NEVERERASEBKGND         0x00000040
#define BROWSERFLAG_PRINTPROMPTUI           0x00000080
#define BROWSERFLAG_SUPPORTTOP              0x00000100
#define BROWSERFLAG_INITNEWTOKEEP           0x00000200
#define BROWSERFLAG_DONTAUTOCLOSE           0x00000400
#define BROWSERFLAG_DONTDEACTIVATEMSOVIEW   0x00000800
#define BROWSERFLAG_MSHTML                  0x40000000
#define BROWSERFLAG_REPLACE                 0x80000000 
#define BROWSERFLAG_DONTCACHESERVER         0x00001000
#define BROWSERFLAG_ENABLETOOLSBTN          0x00002000
#define BROWSERFLAG_SAVEASWHENCLOSING       0x00004000

#ifdef FEATURE_PICS
class CPicsRootDownload;
#endif

// CMenuList:  a small class that tracks whether a given hmenu belongs
//             to the frame or the object, so the messages can be
//             dispatched correctly.
class CMenuList
{
public:
    CMenuList(void);
    ~CMenuList(void);

    void Set(HMENU hmenuShared, HMENU hmenuFrame);
    void AddMenu(HMENU hmenu);
    void RemoveMenu(HMENU hmenu);
    BOOL IsObjectMenu(HMENU hmenu);

#ifdef DEBUG
    void Dump(LPCTSTR pszMsg);
#endif

private:
    HDSA    _hdsa;
};

#define ERRORPAGE_DNS               1
#define ERRORPAGE_SYNTAX            2
#define ERRORPAGE_NAVCANCEL         3
#define ERRORPAGE_OFFCANCEL         4
#define ERRORPAGE_CHANNELNOTINCACHE	5

// Array of http error codes and file names.
//
struct ErrorUrls
{
    DWORD   dwError;
    LPCTSTR pszUrl;
};

class CDocObjectHost :
                  /* public CDocHostUIHandler */
                     public IDocHostUIHandler2
                   , public IDocHostShowUI
    /* Group 2 */  , public IOleClientSite, public IOleDocumentSite
                   , public IOleCommandTarget
    /* Group 3 */  , public IOleInPlaceSiteEx
    /* VBE */      , public IServiceProvider
                   , public IDocHostObject

    /* palette */  , public IViewObject, public IAdviseSink
                   , public IDispatch // ambient properties (from container/iedisp)
                   , public IPropertyNotifySink // for READYSTATE
                   , public IOleControlSite // forward to container/iedisp
                   , protected CImpWndProc
{
  /*typedef CDocHostUIHandler super;*/
    friend class CDocObjectView;
    friend CDocObjectFrame;
    friend CProxyActiveObject;
    friend void CDocObjectHost_GetCurrentPage(LPARAM that, LPTSTR szBuf, UINT cchMax);
public:
    CDocObjectHost(BOOL fWindowOpen = FALSE);

    // *** IUnknown methods ***
    STDMETHODIMP QueryInterface(REFIID riid, void ** ppvObj);
    virtual STDMETHODIMP_(ULONG) AddRef(void) ;
    virtual STDMETHODIMP_(ULONG) Release(void);


    // IOleClientSite
    STDMETHODIMP SaveObject(void);
    STDMETHODIMP GetMoniker(DWORD, DWORD, IMoniker **);
    STDMETHODIMP GetContainer(IOleContainer **);
    STDMETHODIMP ShowObject(void);
    STDMETHODIMP OnShowWindow(BOOL fShow);
    STDMETHODIMP RequestNewObjectLayout(void);

    // IServiceProvider (must be QI'able from IOleClientSite)
    STDMETHODIMP QueryService(REFGUID guidService,
                                    REFIID riid, void **ppvObj);

    // IViewObject
    STDMETHODIMP Draw(DWORD, LONG, void *, DVTARGETDEVICE *, HDC, HDC,
        const RECTL *, const RECTL *, BOOL (*)(ULONG_PTR), ULONG_PTR);
    STDMETHODIMP GetColorSet(DWORD, LONG, void *, DVTARGETDEVICE *,
        HDC, LOGPALETTE **);
    STDMETHODIMP Freeze(DWORD, LONG, void *, DWORD *);
    STDMETHODIMP Unfreeze(DWORD);
    STDMETHODIMP SetAdvise(DWORD, DWORD, IAdviseSink *);
    STDMETHODIMP GetAdvise(DWORD *, DWORD *, IAdviseSink **);

    // IAdviseSink
    virtual STDMETHODIMP_(void) OnDataChange(FORMATETC *, STGMEDIUM *);
    virtual STDMETHODIMP_(void) OnViewChange(DWORD dwAspect, LONG lindex);
    virtual STDMETHODIMP_(void) OnRename(IMoniker *);
    virtual STDMETHODIMP_(void) OnSave();
    virtual STDMETHODIMP_(void) OnClose();

    // *** IOleWindow methods ***
    STDMETHODIMP GetWindow(HWND * lphwnd);
    STDMETHODIMP ContextSensitiveHelp(BOOL fEnterMode);

    // IOleInPlaceSite (also IOleWindow)
    STDMETHODIMP CanInPlaceActivate( void);
    STDMETHODIMP OnInPlaceActivate( void);
    STDMETHODIMP OnUIActivate( void);
    STDMETHODIMP GetWindowContext(
        IOleInPlaceFrame **ppFrame, IOleInPlaceUIWindow **ppDoc,
        LPRECT lprcPosRect, LPRECT lprcClipRect, LPOLEINPLACEFRAMEINFO lpFrameInfo);
    STDMETHODIMP Scroll(SIZE scrollExtant);
    STDMETHODIMP OnUIDeactivate(BOOL fUndoable);
    STDMETHODIMP OnInPlaceDeactivate( void);
    STDMETHODIMP DiscardUndoState( void);
    STDMETHODIMP DeactivateAndUndo( void);
    STDMETHODIMP OnPosRectChange(LPCRECT lprcPosRect);

    // IOleInPlaceSiteEx
    STDMETHODIMP OnInPlaceActivateEx(BOOL *pfNoRedraw, DWORD dwFlags);
    STDMETHODIMP OnInPlaceDeactivateEx(BOOL fNoRedraw);
    STDMETHODIMP RequestUIActivate( void);

    // IOleDocumentSite
    STDMETHODIMP ActivateMe(IOleDocumentView *pviewToActivate);

    // IDocHostUIHandler
    STDMETHODIMP ShowContextMenu( 
        DWORD dwID, POINT *ppt, IUnknown *pcmdtReserved, IDispatch *pdispReserved);
    STDMETHODIMP GetHostInfo(DOCHOSTUIINFO *pInfo);
    STDMETHODIMP ShowUI( 
        DWORD dwID, IOleInPlaceActiveObject *pActiveObject,
        IOleCommandTarget *pCommandTarget, IOleInPlaceFrame *pFrame,
        IOleInPlaceUIWindow *pDoc);
    STDMETHODIMP HideUI(void);
    STDMETHODIMP UpdateUI(void);
    STDMETHODIMP EnableModeless(BOOL fEnable);
    STDMETHODIMP OnDocWindowActivate(BOOL fActivate);
    STDMETHODIMP OnFrameWindowActivate(BOOL fActivate);
    STDMETHODIMP ResizeBorder( 
        LPCRECT prcBorder, IOleInPlaceUIWindow *pUIWindow, BOOL fRameWindow);
    STDMETHODIMP TranslateAccelerator( 
        LPMSG lpMsg, const GUID *pguidCmdGroup, DWORD nCmdID);
    STDMETHODIMP GetOptionKeyPath(BSTR *pbstrKey, DWORD dw);
    STDMETHODIMP GetDropTarget( 
        IDropTarget *pDropTarget, IDropTarget **ppDropTarget);
    STDMETHODIMP GetExternal(IDispatch **ppDisp);
    STDMETHODIMP TranslateUrl(DWORD dwTranslate, OLECHAR *pchURLIn, OLECHAR **ppchURLOut);
    STDMETHODIMP FilterDataObject(IDataObject *pDO, IDataObject **ppDORet);

    // IDocHostUIHandler2
    STDMETHODIMP GetOverrideKeyPath(LPOLESTR *pchKey, DWORD dw);

    // IDocHostShowUI
    STDMETHODIMP ShowMessage(HWND hwnd, LPOLESTR lpstrText, LPOLESTR lpstrCaption,
            DWORD dwType, LPOLESTR lpstrHelpFile, DWORD dwHelpContext, LRESULT *plResult);
    STDMETHODIMP ShowHelp(HWND hwnd, LPOLESTR pszHelpFile, UINT uCommand, DWORD dwData,
            POINT ptMouse, IDispatch *pDispatchObjectHit);

    // IOleInPlaceFrame equivalent (non-virtual)
    HRESULT _InsertMenus(HMENU hmenuShared, LPOLEMENUGROUPWIDTHS lpMenuWidths);
    HRESULT _SetMenu(HMENU hmenuShared, HOLEMENU holemenu, HWND hwndActiveObject);
    HRESULT _RemoveMenus(HMENU hmenuShared);
    HRESULT _SetStatusText(LPCOLESTR pszStatusText);
    HRESULT _EnableModeless(BOOL fEnable);
    HRESULT _TranslateAccelerator(LPMSG lpmsg, WORD wID);

    // IOleCommandTarget equivalent (virtual / both direction)
    STDMETHODIMP QueryStatus(const GUID *pguidCmdGroup,
        ULONG cCmds, OLECMD rgCmds[], OLECMDTEXT *pcmdtext);
    STDMETHODIMP Exec(const GUID *pguidCmdGroup,
        DWORD nCmdID, DWORD nCmdexecopt, VARIANTARG *pvarargIn, VARIANTARG *pvarargOut);

    // *** IDocHostObject methods ***
    STDMETHODIMP OnQueryStatus(const GUID *pguidCmdGroup, ULONG cCmds, OLECMD rgCmds[], OLECMDTEXT *pcmdtext, HRESULT hres);
    STDMETHODIMP OnExec(const GUID *pguidCmdGroup, DWORD nCmdID, DWORD nCmdexecopt, VARIANTARG *pvarargIn, VARIANTARG *pvarargOut);
    STDMETHODIMP QueryStatusDown(const GUID *pguidCmdGroup, ULONG cCmds, OLECMD rgCmds[], OLECMDTEXT *pcmdtext);
    STDMETHODIMP ExecDown(const GUID *pguidCmdGroup, DWORD nCmdID, DWORD nCmdexecopt, VARIANTARG *pvarargIn, VARIANTARG *pvarargOut);

    // *** IDispatch methods ***
    STDMETHOD(GetTypeInfoCount) (unsigned int *pctinfo)
        { return E_NOTIMPL; };
    STDMETHOD(GetTypeInfo) (unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo)
        { return E_NOTIMPL; };
    STDMETHODIMP GetIDsOfNames(REFIID riid, OLECHAR * * rgszNames, unsigned int cNames, LCID lcid, DISPID * rgdispid)
        { return E_NOTIMPL; };
    STDMETHODIMP Invoke(DISPID dispidMember, REFIID iid, LCID lcid, WORD wFlags, DISPPARAMS * pdispparams,
                        VARIANT * pvarResult,EXCEPINFO * pexcepinfo,UINT * puArgErr);

    // *** IPropertyNotifySink methods ***
    STDMETHODIMP OnChanged(DISPID dispid);
    STDMETHODIMP OnRequestEdit(DISPID dispid);

    // *** IOleControlSite ***
    STDMETHODIMP OnControlInfoChanged();
    STDMETHODIMP LockInPlaceActive(BOOL fLock)
        { return E_NOTIMPL; };
    STDMETHODIMP GetExtendedControl(IDispatch **ppDisp)
        { *ppDisp = NULL; return E_NOTIMPL; };
    STDMETHODIMP TransformCoords(POINTL *pPtlHimetric, POINTF *pPtfContainer,DWORD dwFlags)
        { return E_NOTIMPL; };
    STDMETHODIMP TranslateAccelerator(MSG *pMsg,DWORD grfModifiers);

    STDMETHODIMP OnFocus(BOOL fGotFocus)
        { return E_NOTIMPL; };
    STDMETHODIMP ShowPropertyFrame(void)
        { return E_NOTIMPL; };



    HRESULT SetTarget(IMoniker* pmk, UINT uiCP, LPCTSTR pszLocation, LPITEMIDLIST pidlKey, IShellView* psvPrev, BOOL fFileProtocol);
    HRESULT UIActivate(UINT uState, BOOL fPrevViewIsDocView);
    
    //Helper function for initing History related privates
    IUnknown *get_punkSFHistory();
    BOOL InitHostWindow(IShellView* psv, IShellBrowser* psb, LPRECT prcView);
    void DestroyHostWindow();
    BOOL _OperationIsHyperlink();
    void _ChainBSC();
    HRESULT TranslateHostAccelerators(LPMSG lpmsg);
    HRESULT AddPages(LPFNADDPROPSHEETPAGE lpfnAddPage, LPARAM lParam);
    BOOL _IsMenuShared(HMENU hmenu);
    void _SetPriorityStatusText(LPCOLESTR pszPriorityStatusText);

    BOOL DocCanHandleNavigation() const
        { return (_fPrevDocHost && _fDocCanNavigate); }

    void OnInitialUpdate();
    void ResetRefreshUrl();
    void HideBrowser() const;

protected:
    virtual ~CDocObjectHost();

    // Private method
    void _InitOleObject();
    void _ResetOwners();
    virtual LRESULT v_WndProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam);
    void _OnMenuSelect(UINT id, UINT mf, HMENU hmenu);
    void _OnInitMenuPopup(HMENU hmInit, int nIndex, BOOL fSystemMenu);
    void _OnCommand(UINT wNotify, UINT id, HWND hwndControl);
    void _OnNotify(LPNMHDR lpnm);
    void _OnSave(void);
    void _OnBound(HRESULT hres);
    static BOOL_PTR CALLBACK s_RunDlgProc(HWND hDlg, UINT uMsg, WPARAM wParam, LPARAM lParam);
    void _OnOpen(void);
    void _OnClose() const;
    BOOL _HideBrowserBar() const;
    void _OnImportExport(HWND hwnd);
    HRESULT _PrepFileOpenAddrBand(IAddressEditBox ** ppaeb, IWinEventHandler ** ppweh, IBandSite ** ppbs);
    void _OnPaint(HDC hdc);
    void _OnSetFocus(void);
    void _GetClipRect(RECT* prc);
    void _RegisterWindowClass(void);
    void _PlaceProgressBar(BOOL fForcedLayout=FALSE);
    void _OnSetProgressPos(DWORD dwPos, DWORD state);
    void _OnSetProgressMax(DWORD dwRange);
    HRESULT _OnContentDisposition();
    void _OnSetStatusText(VARIANTARG *pvarIn);
    void _Navigate();
#ifndef UNIX
    void _NavigateFolder(BSTR bstrUrl);
#endif // UNIX

    // IE Media Bar functions
    BOOL _DelegateToMediaBar(IBindCtx * pbc, LPCWSTR pwzMimeType);
    void _ForceCreateMediaBar();
    static INT_PTR CALLBACK s_MimeDlgProc(HWND hDlg, UINT uMsg, WPARAM wParam, LPARAM lParam);


    void _CancelPendingNavigation(BOOL fDownloadAsync,
                                  BOOL fSyncReally = FALSE,
                                  BOOL fDontShowNavCancelPage = FALSE,
                                  BOOL fForceClose = FALSE);

    void _DoAsyncNavigation(LPCTSTR pwzURL);
    IOleInPlaceSite* _GetParentSite(void);
    HRESULT _GetCurrentPage(LPTSTR szBuf, UINT cchMax, BOOL fURL=FALSE);
    HRESULT _GetCurrentPageW(LPOLESTR * ppszDisplayName, BOOL fURL=FALSE);
    BOOL _IsDirty(IPersistFile** pppf);
    HRESULT _OnSaveAs(void);
    void _MergeToolbarSB();
    void _OnHelpGoto(UINT idRes);
    void _Navigate(LPCWSTR pwszURL);
    HRESULT _OnMaySaveChanges(void);
    void _OnCodePageChange(const VARIANTARG* pvarargIn);
    void _MappedBrowserExec(DWORD nCmdID, DWORD nCmdexecopt);
#ifdef DEBUG
    void _DumpMenus(LPCTSTR pszMsg, BOOL bBreak);
#endif

    HRESULT _BindSync(IMoniker* pmk, IBindCtx* pbc, IShellView* psvPrev);
    void    _PostBindAppHack(void);
    void    _AppHackForExcel95(void);
    HRESULT _GetOfflineSilent(BOOL *pbIsOffline, BOOL *pbIsSilent);
    HRESULT _StartAsyncBinding(IMoniker* pmk, IBindCtx* pbc, IShellView* psvPrev);
    HRESULT _BindWithRetry(IMoniker* pmk, IBindCtx* pbc, IShellView* psvPrev);
    void    _UnBind(void);
    void    _ReleaseOleObject(BOOL fIfInited = TRUE);
    void    _ReleasePendingObject(BOOL fIfInited = TRUE);
    HRESULT _GetUrlVariant(VARIANT *pvarOut);
    HRESULT _CreatePendingDocObject(BOOL fMustInit, BOOL fWindowOpen = FALSE);
    void    _ActivateOleObject(void);
    HRESULT _CreateMsoView(void);
    void    _CloseMsoView(void);
    HRESULT _EnsureActivateMsoView(void);
    void    _ShowMsoView(void);
    void    _HideOfficeToolbars(void);
    HRESULT _ActivateMsoView(void);
    HRESULT _DoVerbHelper(BOOL fOC);
    void    _InitToolbarButtons(void);
    void    _UIDeactivateMsoView(void);
    BOOL    _BuildClassMapping(void);
    HRESULT _RegisterMediaTypeClass(IBindCtx* pbc);
    void    _IPDeactivateMsoView(IOleDocumentView* pmsov);
    void    _CompleteHelpMenuMerge(HMENU hmenu);
    BOOL    _ShouldForwardMenu(UINT uMsg, WPARAM wParam, LPARAM lParam);
    LRESULT _ForwardObjectMsg(UINT uMsg, WPARAM wParam, LPARAM lParam);
    HRESULT _MayHaveVirus(REFCLSID rclsid);
    HRESULT _ForwardSetSecureLock(int lock);
    void    _ResetStatusBar();

    BOOL _ToolsButtonAvailable();
    BYTE _DefToolsButtonState(DWORD dwRest);

    BYTE _DefFontsButtonState(DWORD dwRest);

    DWORD _DiscussionsButtonCmdf();
    BOOL _DiscussionsButtonAvailable();
    BYTE _DefDiscussionsButtonState(DWORD dwRest);

    BOOL _MailButtonAvailable();
    BYTE _DefMailButtonState(DWORD dwRest);

    BOOL _EditButtonAvailable();
    BYTE _DefEditButtonState(DWORD dwRest);

    void _MarkDefaultButtons(PTBBUTTON tbStd);
    const GUID* _GetButtonCommandGroup();
    void _AddButtons(BOOL fForceReload);

    HRESULT _OnChangedReadyState();
    void    _OnReadyState(long lVal, BOOL fUpdateHistory = TRUE);
    BOOL    _SetUpTransitionCapability(BOOL fWindowOpen = FALSE);
    BOOL    _RemoveTransitionCapability();
    void    _UpdateHistoryAndIntSiteDB(LPCWSTR pszTitle);
    HRESULT _CoCreateHTMLDocument(REFIID riid, LPVOID* ppvOut);

    void    _RemoveFrameSubMenus(void);
    HRESULT _DestroyBrowserMenu(void);
    HRESULT _CreateBrowserMenu(LPOLEMENUGROUPWIDTHS pmw);
    void    _SetStatusText(LPCSTR pszText);
    void    _OnSetTitle(VARIANTARG *pvTitle);
    DWORD   _GetAppHack(void);
    void    _CleanupProgress(void);

    // Trident Native Frames Support
    //

    VOID    ClearScriptError();
    
    HRESULT _HandleFailedNavigation(VARIANTARG * varargIn, VARIANTARG * varargOut = NULL );

    HRESULT _DisplayHttpErrorPage(IHTMLWindow2 * pCurrentWindow,
                                  BSTR           bstrUrl,
                                  DWORD          dwError,
                                  BOOL           fAddrBarNav,
                                  BOOL           fRefresh = FALSE );

    HRESULT _DoAutoSearch(VARIANTARG   * pvarargIn,
                          long           lStartIdx,
                          DWORD          dwStatusCode,
                          BOOL           fAddMRU,
                          BOOL         * pfShouldDisplayError);

    HRESULT _HandleDocHostCmds(DWORD nCmdID,
                               DWORD nCmdexecopt,
                               VARIANTARG * pvarargIn,
                               VARIANTARG * pvarargOut,
                               BOOL       * pfHandled);

    HRESULT _HandleDocHostCmdPriv(DWORD nCmdID,
                                  DWORD nCmdexecopt,
                                  VARIANTARG * pvarargIn,
                                  VARIANTARG * pvarargOut,
                                  BOOL       * pfHandled);

    HRESULT _NavigateDocument(BSTR bstrUrl, BSTR bstrLocation);
    void    _GetShortCutPath(BSTR * bstrShortCutPath);
    void    _GetDocNavFlags(DWORD * pdwDocNavFlags);

    BOOL    _HandleShdocvwCmds(DWORD        nCmdID,
                               DWORD        nCmdexecopt,
                               VARIANTARG * pvarargIn,
                               VARIANTARG * pvarargOut);

    void _StartPicsForWindow(VARIANTARG * pvarargIn, VARIANTARG * pvarargOut);
    void _CancelPicsForWindow(VARIANTARG * pvarargIn);
    void _IsPicsEnabled(VARIANTARG * pvarIsPicsEnabled);

    HRESULT _UpdateState(LPITEMIDLIST pidl, BOOL fIsErrorUrl);
    void    _Init();

    BOOL _IsInBrowserBand() const;

    DEBUG_CODE(void _TraceMonikerDbg(IMoniker * pmk, TCHAR * pszCaller) const;)

    HRESULT _LoadDocument();

    void _FireNavigateErrorHelper(IHTMLWindow2 * pHTMLWindow2,
                                  DWORD          dwStatusCode,
                                  BOOL         * pfCancelAutoSearch,
                                  BSTR           bstrPendingURL = NULL);

    static LRESULT s_IconsWndProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

    static UINT _MapCommandID(UINT id, BOOL fToMsoCmd);
    inline static UINT _MapToMso(UINT id) { return _MapCommandID(id, TRUE); }
    inline static UINT _MapFromMso(UINT idMso) { return _MapCommandID(idMso, FALSE); }

    inline IOleInPlaceActiveObject *_ActiveObject() { return _xao.GetObject(); }
    inline HWND _ActiveHwnd() { return _xao.GetHwnd(); }

    inline IOleObject * GetOleObject() { return _pole; }


    // internal class objects
    CDocObjectFrame         _dof;
    CProxyActiveObject      _xao;
    CDocHostUIHandler       _dhUIHandler;

    IToolbarExt *           _pBrowsExt;
    int                     _iString;       // start index for toolbar button strings

    UINT                    _cRef;

    // parent references
    IShellView * _psv;
    IOleCommandTarget*      _pmsoctView;
    IDocViewSite*           _pdvs;

    //
    IShellBrowser*          _psb;
    IOleCommandTarget*      _pmsoctBrowser;
    IBrowserService*        _pwb;
    
    IServiceProvider*       _psp;
    IOleInPlaceUIWindow*    _pipu; // Optional interface from IShellBrowser
    IExpDispSupport *       _peds;
    IExpDispSupportOC *     _pedsHelper;

    // for pre-merged menu
    IOleCommandTarget*      _pcmdMergedMenu;

    // Pointer to the WebBrowserOC's DocHostUIHandler, if any.
    IDocHostUIHandler         * _pWebOCUIHandler;
    IDocHostUIHandler2        * _pWebOCUIHandler2;

    // Pointer to the WebBrowserOC's ShowUI handler, if any.
    IDocHostShowUI            * _pWebOCShowUI;

    // Pointer to the WebBrowserOC's InPlaceSiteEx, if any.
    IOleInPlaceSiteEx         * _pWebOCInPlaceSiteEx;

    // we created...
    UINT        _uState;
    HWND        _hwndProgress;
    HWND        _hwndIcons;
    HWND        _hwndTooltip;
    WNDPROC     _pfnStaticWndProc;

    HACCEL      _hacc;

    // Menus: the final menu bar the user sees (_hmenuCur, _hmenuSet) is the product 
    //        of merging the object's menu with the browser's menu.  The browser's menu
    //        (_hmenuBrowser) is the result of combining the browser's
    //        menu (owned by mshtml, obtained via IShellBrowser) with the 
    //        frame's menu (_hmenuFrame).

    HMENU       _hmenuFrame;    // menu to be merged when we have focus
    HMENU       _hmenuBrowser;  // Menu from IShellBrowser
    HMENU       _hmenuSet;      // set by ::SetMenu
    HMENU       _hmenuCur;      // currently set menu
    HMENU       _hmenuMergedHelp;   // Merged help menu
    HMENU       _hmenuObjHelp;  // Hosted object's help menu

    CMenuList   _menulist;      // Menu list for dispatching

    LPCTSTR      _pszLocation;
    UINT        _uiCP;

    LPOLESTR    _pwszRefreshUrl;  // Url to refresh when intrenal error page is dispalyed.

    BOOL        _fNeedToActivate:1;     //  this is set when we do a LoadHistory on the _pole
    BOOL        _fClientSiteSet:1;
    BOOL        _fDontInplaceActivate:1;
    BOOL        _fDrawBackground:1;
    BOOL        _fCanceledByBrowser:1;
    BOOL        _fForwardMenu:1;            // TRUE: forward the menu message
    BOOL        _fHaveParentSite:1;     // pretty much "we're in a frame"
    BOOL        _fhasLastModified;    // object has Last-Modified header
    BOOL        _fIPDeactivatingView:1;
    BOOL        _fCantSaveBack:1;       // We can't call IPSFile::Save(NULL)
    BOOL        _fHaveAppHack:1;
    BOOL        _fReadystateInteractiveProcessed:1;
    BOOL        _fFileProtocol:1;
    BOOL        _fConfirmed:1;            // _MayHaveVirus already confirmed
    BOOL        _fCycleFocus:1;           // 1=got callback to do CycleFocus
    BOOL        _fCreatingPending:1;      // we are creating _punkPending
    BOOL        _fAbortCreatePending:1;   // abort create due to reentrant free
    BOOL        _fCalledMayOpenSafeDlg:1; // Already called MayOpenSafeOpenDialog. 
    BOOL        _fPendingNeedsInit:1;     // does _punkPending need to be inited?
    BOOL        _fPendingWasInited:1;     // _punkPending was inited
    BOOL        _fSetSecureLock:1;        // indicates we should update the browser with fSecureLock
    BOOL        _fProgressTimer:1;        //  progress timer is active
    BOOL        _fProgressTimerFull:1;    //  wait a quarter sec with a full progress bar
    BOOL        _fIsHistoricalObject:1;   //  this item was retrieved from GetHistoryObject() and successfully took LoadHistory()
    BOOL        _fSyncBindToObject:1;     //  to detect when the call backs are on the sync thread
    BOOL        _fUIActivatingView:1;     // Indicates if we're UIActivating or Showing our DocObj view.
    BOOL        _fShowProgressCtl:1;      // Show the progress control on the status bar.
    BOOL        _fWebOC:1;                // are we a web oc?
#ifdef DEBUG
    BOOL        _fFriendlyError:1;        // So we know we're going to an error page.
#endif

    BOOL        _fDocCanNavigate:1;       // TRUE indicates that the hosted document can navigate itself.
    BOOL        _fPrevDocHost:1;          // TRUE if there was a previous doc object host.
    BOOL        _fClosing:1;              // The browser is being closed.
    BOOL        _fRefresh:1;              // the browser is being refreshed (ie we are handling refresh).
    BOOL        _fDelegatedNavigation:1;  // TRUE if the navigation was delegated from the document.
    BOOL        _fErrorPage : 1;        // True if we're navigating to some sort of error page.
    BOOL        _fWindowOpen:1;
    
    IHTMLWindow2 * _pHTMLWindow;        // Navigation interface of the hosted document.    
    LPITEMIDLIST   _pidl;               // Current pidl.
    
    HRESULT     _hrOnStopBinding;       // set in onstopbinding when _fSyncBindToObject
    DWORD       _dwPropNotifyCookie;

    DWORD       _dwAppHack;
    DWORD       _dwSecurityStatus;      // Return from QueryOptions(INTERNET_OPTION_SECURITY_FLAGS)
    int         _eSecureLock;           // one of the SECURELOCK_* values

    HINSTANCE   _hinstInetCpl;          // Inetcpl

    TBBUTTON*   _ptbStd;                // buffer for button array (used for ETCMDID_GETBUTTONS)
    int         _nNumButtons;

    VARIANT     _varUserEnteredUrl;     // The URL entered by the user in the address bar.
                                        // Needed for AutoSearch when initiated by Trident.
    BOOL        _fDontInPlaceNavigate() { ASSERT(_fHaveAppHack); return (_dwAppHack & BROWSERFLAG_DONTINPLACE); }
    BOOL        _fCallSetHostName()     { ASSERT(_fHaveAppHack); return (_dwAppHack & BROWSERFLAG_SETHOSTNAME); }
    BOOL        _fUseOpenVerb()         { ASSERT(_fHaveAppHack); return (_dwAppHack & BROWSERFLAG_OPENVERB); }
    BOOL        _fAppHackForExcel()     { ASSERT(_fHaveAppHack); return (_dwAppHack & BROWSERFLAG_OPENCOPY); }

    UINT        posOfflineIcon;

    enum {
        PROGRESS_RESET,
        PROGRESS_FINDING,
        PROGRESS_TICK,
        PROGRESS_SENDING,
        PROGRESS_RECEIVING,
        PROGRESS_FULL
    };

#define PROGRESS_REBASE     100
#define PROGRESS_FINDMAX    30 * PROGRESS_REBASE    //  maximum amount of status on find
#define PROGRESS_SENDMAX    40 * PROGRESS_REBASE    //  maximum amount of status on send
#define PROGRESS_TOTALMAX   100 * PROGRESS_REBASE   //  the total size of the progress bar in find/send
#define PROGRESS_INCREMENT  50          //  default progress increment

#define ADJUSTPROGRESSMAX(dw)   (PROGRESS_REBASE * (dw) )
#define ADJUSTPROGRESSPOS(dw)   ((dw) * PROGRESS_REBASE + ((_dwProgressBase * _dwProgressMax) / PROGRESS_REBASE))

    DWORD       _dwProgressMax; // max progress range for progress bar
    DWORD       _dwProgressPos;
    DWORD       _dwProgressInc;
    DWORD       _dwProgressTicks;
    DWORD       _dwProgressMod;
    DWORD       _dwProgressBase;

#define IDTIMER_PROGRESS        88
#define IDTIMER_PROGRESSFULL    89


#ifdef HLINK_EXTRA
    // Navigation
    IHlinkBrowseContext* _pihlbc;
#endif // HLINK_EXTRA

    // Data associated
    IMoniker*   _pmkCur;
    IBindCtx*   _pbcCur;
    IOleObject* _pole;
    IViewObject* _pvo;
    IStorage*   _pstg;
    IUnknown*   _punkPending;

    IHlinkFrame *_phf;
    IOleCommandTarget*_pocthf;
    IUnknown *_punkSFHistory;

    // Advisory connection
    IAdviseSink *_padvise;
    DWORD _advise_aspect;
    DWORD _advise_advf;

    // View associated (only used when the object is active)
    IOleDocumentView*           _pmsov;
    IOleCommandTarget*          _pmsot;
    IOleControl*                _pmsoc;
    IHlinkSource*               _phls;
    BORDERWIDTHS _bwTools;
    RECT        _rcView;

    int _iZoom;
    int _iZoomMin;
    int _iZoomMax;
    class CDOHBindStatusCallback : public IBindStatusCallback
            , public IAuthenticate
            , public IServiceProvider
            , public IHttpNegotiate
            , public IHttpSecurity

    {
        friend CDocObjectHost;
    protected:
        // *** IUnknown methods ***
        STDMETHODIMP QueryInterface(REFIID riid, void ** ppvObj);
        virtual STDMETHODIMP_(ULONG) AddRef(void) ;
        virtual STDMETHODIMP_(ULONG) Release(void);

        // *** IAuthenticate ***
        STDMETHODIMP Authenticate(
            HWND *phwnd,
            LPWSTR *pszUsername,
            LPWSTR *pszPassword);

        // *** IServiceProvider ***
        STDMETHODIMP QueryService(REFGUID guidService,
                                    REFIID riid, void **ppvObj);

        // *** IBindStatusCallback ***
        STDMETHODIMP OnStartBinding(
            /* [in] */ DWORD grfBSCOption,
            /* [in] */ IBinding *pib);

        STDMETHODIMP GetPriority(
            /* [out] */ LONG *pnPriority);

        STDMETHODIMP OnLowResource(
            /* [in] */ DWORD reserved);

        STDMETHODIMP OnProgress(
            /* [in] */ ULONG ulProgress,
            /* [in] */ ULONG ulProgressMax,
            /* [in] */ ULONG ulStatusCode,
            /* [in] */ LPCWSTR szStatusText);

        STDMETHODIMP OnStopBinding(
            /* [in] */ HRESULT hresult,
            /* [in] */ LPCWSTR szError);

        STDMETHODIMP GetBindInfo(
            /* [out] */ DWORD *grfBINDINFOF,
            /* [unique][out][in] */ BINDINFO *pbindinfo);

        STDMETHODIMP OnDataAvailable(
            /* [in] */ DWORD grfBSCF,
            /* [in] */ DWORD dwSize,
            /* [in] */ FORMATETC *pformatetc,
            /* [in] */ STGMEDIUM *pstgmed);

        STDMETHODIMP OnObjectAvailable(
            /* [in] */ REFIID riid,
            /* [iid_is][in] */ IUnknown *punk);

        /* *** IHttpNegotiate ***  */
        STDMETHODIMP BeginningTransaction(LPCWSTR szURL, LPCWSTR szHeaders,
                DWORD dwReserved, LPWSTR *pszAdditionalHeaders);

        STDMETHODIMP OnResponse(DWORD dwResponseCode, LPCWSTR szResponseHeaders,
                            LPCWSTR szRequestHeaders,
                            LPWSTR *pszAdditionalRequestHeaders);

        /* *** IHttpSecurity ***  */
        STDMETHODIMP  GetWindow(REFGUID rguidReason, HWND* phwnd);

        STDMETHODIMP OnSecurityProblem(DWORD dwProblem);

    protected:
        ~CDOHBindStatusCallback();
        IBinding*       _pib;
        IBindCtx*       _pbc;
        IBindStatusCallback* _pbscChained;
        IHttpNegotiate* _pnegotiateChained;
        IShellView*     _psvPrev;
        ULONG           _bindst;
        HGLOBAL _hszPostData;
        int _cbPostData;
        LPSTR _pszHeaders;
        LPTSTR _pszRedirectedURL;
        LPTSTR _pszCacheFileName;
        DWORD           _dwBindVerb;            // the verb requested
        DWORD           _dwBindf;               // last set of bind flags returned as a response to the GetBindInfo call...
        DWORD           _cbContentLength;
        BOOL            _fSelfAssociated:1;     //
        BOOL            _fBinding:1;        // downloading
        BOOL            _bFrameIsOffline:1;
        BOOL            _bFrameIsSilent:1;
        BOOL            _fDocWriteAbort:1;      // abort to use _punkPending
        BOOL            _fBoundToMSHTML:1;      // if bound to TRIDENT
        BOOL            _fBoundToNoOleObject:1; // the object does not support IOleObject
        BOOL            _fAborted:1;            // TRUE when AbortBinding called when IDCANCEL for BINDSTATUS_CONTENTDISPOSITIONATTACH

        //Privacy data
        LPTSTR          _pszPolicyRefURL;
        LPTSTR          _pszP3PHeader;
        DWORD           _dwPrivacyFlags;

        CPrivacyQueue   _privacyQueue;
        
        void _Redirect(LPCWSTR pwzNew);
        HRESULT _HandleSelfAssociate(void);
        void _UpdateSSLIcon(void);
        BOOL _DisplayFriendlyHttpErrors(void);
        void _HandleHttpErrors(DWORD dwError, DWORD cbContentLength, CDocObjectHost* pdoh);
        
        HRESULT _HandleFailedNavigationSearch (LPBOOL           pfShouldDisplayError,
                                               DWORD            dwStatusCode,
                                               CDocObjectHost * pdoh,
                                               HRESULT          hrDisplay,
                                               TCHAR          * szURL,
                                               LPCWSTR          szError,
                                               IBinding       * pib,
                                               BOOL             fAddMRU = TRUE,
                                               BOOL             fFromTrident = FALSE);
                                               
        void _CheckForCodePageAndShortcut(void);
        void _DontAddToMRU(CDocObjectHost* pdoh);
        void _UpdateMRU(CDocObjectHost* pdoh, LPCWSTR pszUrl);
        HRESULT _SetSearchInfo(CDocObjectHost *pdoh, DWORD dwIndex, BOOL fAllowSearch, BOOL fContinueSearch, BOOL fSentToEngine);
        void ResetPrivacyInfo();
        HRESULT BuildRecord();
        HRESULT AddToPrivacyQueue(LPTSTR * ppszUrl, LPTSTR * ppszPolicyRef, LPTSTR * ppszP3PHeader, DWORD dwFlags);

    public:
        void AbortBinding(void);
        CDOHBindStatusCallback() : _pib(NULL) {}
        void _RegisterObjectParam(IBindCtx* pbc);
        void _RevokeObjectParam(IBindCtx* pbc);
        void _NavigateToErrorPage(DWORD dwError, CDocObjectHost* pdoh, BOOL fInPlace);
    };

    friend class CDOHBindStatusCallback;
    CDOHBindStatusCallback _bsc;

#ifdef FEATURE_PICS
#define PICS_WAIT_FOR_ASYNC 0x01        /* waiting for async rating query */
#define PICS_WAIT_FOR_INDOC 0x02        /* waiting for in-document rating */
#define PICS_WAIT_FOR_ROOT  0x04        /* waiting for root document */
#define PICS_WAIT_FOR_END   0x08        /* waiting for end of document */

#define PICS_MULTIPLE_FLAGS PICS_WAIT_FOR_INDOC     /* sources which can produce multiple results */

#define PICS_LABEL_FROM_HEADER 0        /* label was obtained from the http header */
#define PICS_LABEL_FROM_PAGE   1        /* label was obtained from the page itself */

    /*
     * _fPicsBlockLate - TRUE if we're using a DocObject which we have
     *                   to allow to download completely because we may
     *                   need to get ratings out of it.  FALSE if we
     *                   just want to block it as early as possible
     *                   (usually at OnProgress(CLASSIDAVAILABLE)).
     * _fSetTarget - bug 29364: this indicates we are calling _StartAsyncBinding
     *               and we shouldn't do any activation, even if we're told to.
     *               Has URLMON changed how it binds to objects? (GregJ claims
     *               that URLMON never called OnObjectAvailable synchronously
     *               with the _StartAsyncBinding call...) It also seems that
     *               both Trident and this PICS stuff use the
     *               message SHDVID_ACTIVATEMENOW which might confuse
     *               the delayed activation stuff CDTurner put in... [mikesh]
     */

    BOOL        _fSetTarget:1;
    BOOL        _fPicsBlockLate:1;

    class CPicsProcessor : public IOleCommandTarget
    {
    // Everything public because the _bsc needs to get at base proc
    public:
        friend class CDocObjectHost;

        CPicsProcessor();
        ~CPicsProcessor() { _ReInit(); }
        void _ReInit();

        // *** IUnknown methods ***
        STDMETHODIMP QueryInterface(REFIID riid, void ** ppvObj);
        virtual STDMETHODIMP_(ULONG) AddRef(void) ;
        virtual STDMETHODIMP_(ULONG) Release(void);

        // IOleCommandTarget equivalent (virtual / both direction)
        STDMETHODIMP QueryStatus(const GUID *pguidCmdGroup,
            ULONG cCmds, OLECMD rgCmds[], OLECMDTEXT *pcmdtext);
        STDMETHODIMP Exec(const GUID *pguidCmdGroup,
            DWORD nCmdID, DWORD nCmdexecopt, VARIANTARG *pvarargIn, VARIANTARG *pvarargOut);

        /* PICS state flags:
         *
         * _fPicsAccessAllowed - Whether the most significant rating we've
         *                       found so far (that actually applies to the
         *                       thing we're browsing to) would allow access.
         *                       Once all rating sources report in, this flag
         *                       indicates whether the user can see the content.
         */
        BYTE            _fPicsAccessAllowed:1;
        BYTE            _fInDialog:1;
        BYTE            _fTerminated:1;

        /* The following flags are a separate bitfield so I can easily test
         * "if (!_fbPicsWaitFlags)" to see if I'm done waiting.
         *
         * IMPORTANT: The flags are in order of precedence.  That is, ASYNC
         * is more important than INDOC, which is more important than ROOT.
         * This way, given any flag which specifies the source of a rating,
         * if that rating applies to the content, then
         *
         *  _fbPicsWaitFlags &= (flag - 1);
         *
         * will turn off that flag and all flags above it, causing the code
         * to not consider any further ratings from that source or less
         * important sources.
         */
        BYTE        _fbPicsWaitFlags;

        DWORD       _dwPicsLabelSource;
        LPVOID      _pRatingDetails;
        DWORD       _dwPicsSerialNumber;    /* serial number for async query */
        DWORD       _dwKey;                 /* Key for identifying CPicsProcs */
        HANDLE      _hPicsQuery;            /* handle to async query event */
        LPTSTR      _pszPicsURL;            /* result of CoInternetGetSecurityUrl */

        IHTMLPrivateWindow *    _pPrivWindow;       /* Private Window on behalf of which this proccessing is being done */
        CPicsRootDownload *     _pRootDownload;     /* object managing root document download */
        CDocObjectHost *        _pdoh;          

        CPicsProcessor *        _pPicsProcNext;     /* the next pics proc in the chain */

        LONG_PTR _GetKey() { return (LONG_PTR)_dwKey; }
        UINT    _PicsBlockingDialog();
        HRESULT _StartPicsQuery(LPCOLESTR pwszRawURL);
        void    _HandlePicsChecksComplete();
        void    _GotLabel(HRESULT hres, LPVOID pDetails, BYTE bfSource);
        void    _HandleInDocumentLabel(LPCTSTR pszLabel);
        void    _HandleDocumentEnd(void);
        void    _StartPicsRootQuery(LPCTSTR pszURL);
        void    _Terminate();
    };

    friend class CPicsProcessor;
    CPicsProcessor _PicsProcBase;
    DWORD          _dwPicsKeyBase;

    CPicsProcessor* _GetPicsProcessorFromKey(LONG_PTR lKey);
    CPicsProcessor* _GetPicsProcessorFromSerialNumber( DWORD dwPicsSerialNumber );
    void            _StartBasePicsProcessor();
    HRESULT         _StartSecondaryPicsProcessor(IHTMLPrivateWindow * pPrivWindow);
    HRESULT         _RemovePicsProcessorByKey(LONG_PTR lKey);
    HRESULT         _RemovePicsProcessorByPrivWindowUnk(IUnknown* pUnkFind);
    HRESULT         _RemoveAllPicsProcessors();

#endif

    BSTR                _strPriorityStatusText;

    // support for caching of script errors
    CScriptErrorList *  _pScriptErrList;
    BOOL                _fScriptErrDlgOpen;
    BOOL                _fShowScriptErrDlgAgain;
    HRESULT             _ScriptErr_CacheInfo(VARIANTARG *pvarIn);
    void                _ScriptErr_Dlg(BOOL fOverrridePerErrorMode);
};


#ifdef FEATURE_PICS

//#include <brwsectl.h>   /* for IBrowseControl */

class CPicsRootDownload : public IBindStatusCallback,
                                 IOleClientSite, IServiceProvider,
                                 IDispatch
{
protected:
    UINT m_cRef;
    long m_lFlags;
    IOleCommandTarget *m_pctParent;
    IOleObject *m_pole;
    IOleCommandTarget *m_pctObject;
    IBinding *m_pBinding;
    IBindCtx *m_pBindCtx;

    void _NotifyEndOfDocument(void);
    HRESULT _Abort(void);
    BOOL m_fFrameIsSilent:1;
    BOOL m_fFrameIsOffline:1;

public:
    CPicsRootDownload(IOleCommandTarget *pctParent, BOOL fFrameIsOffline, BOOL fFrameIsSilent);
    ~CPicsRootDownload();

    HRESULT StartDownload(IMoniker *pmk);
    void CleanUp(void);

    // IUnknown members
    STDMETHODIMP         QueryInterface(REFIID riid, void **punk);
    STDMETHODIMP_(ULONG) AddRef(void);
    STDMETHODIMP_(ULONG) Release(void);

    // IBindStatusCallback methods
    STDMETHODIMP    OnStartBinding(DWORD dwReserved, IBinding* pbinding);
    STDMETHODIMP    GetPriority(LONG* pnPriority);
    STDMETHODIMP    OnLowResource(DWORD dwReserved);
    STDMETHODIMP    OnProgress(ULONG ulProgress, ULONG ulProgressMax, ULONG ulStatusCode,
                        LPCWSTR pwzStatusText);
    STDMETHODIMP    OnStopBinding(HRESULT hrResult, LPCWSTR szError);
    STDMETHODIMP    GetBindInfo(DWORD* pgrfBINDF, BINDINFO* pbindinfo);
    STDMETHODIMP    OnDataAvailable(DWORD grfBSCF, DWORD dwSize, FORMATETC *pfmtetc,
                        STGMEDIUM* pstgmed);
    STDMETHODIMP    OnObjectAvailable(REFIID riid, IUnknown* punk);

    // IOleClientSite
    STDMETHODIMP SaveObject(void);
    STDMETHODIMP GetMoniker(DWORD, DWORD, IMoniker **);
    STDMETHODIMP GetContainer(IOleContainer **);
    STDMETHODIMP ShowObject(void);
    STDMETHODIMP OnShowWindow(BOOL fShow);
    STDMETHODIMP RequestNewObjectLayout(void);

    // IServiceProvider (must be QI'able from IOleClientSite)
    STDMETHODIMP QueryService(REFGUID guidService,
                                    REFIID riid, void **ppvObj);

    // *** IDispatch methods ***
    STDMETHOD(GetTypeInfoCount) (unsigned int *pctinfo)
        { return E_NOTIMPL; };
    STDMETHOD(GetTypeInfo) (unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo)
        { return E_NOTIMPL; };
    STDMETHODIMP GetIDsOfNames(REFIID riid, OLECHAR * * rgszNames, unsigned int cNames, LCID lcid, DISPID * rgdispid)
        { return E_NOTIMPL; };
    STDMETHODIMP Invoke(DISPID dispidMember, REFIID iid, LCID lcid, WORD wFlags, DISPPARAMS * pdispparams,
                        VARIANT * pvarResult,EXCEPINFO * pexcepinfo,UINT * puArgErr);
};

// IID_IsPicsBrowser is a way we can use pClientSite->QueryService to find out
// if the top-level browser is a PICS root document download or not, so we can
// avoid navigating sub-frames.  No real interface corresponds to this IID, we
// just return an IUnknown pointer.
EXTERN_C const GUID IID_IsPicsBrowser;   // F114C2C0-90BE-11D0-83B1-00C04FD705B2

#endif


void DeleteFileSent(LPTSTR *ppszTempFile);
BOOL ShouldShellExecURL( LPTSTR pszURL );
DWORD GetSyncMode (DWORD dwDefault);

// in Dochost.cpp
BOOL _ValidateURL(LPTSTR pszName, DWORD dwFlags);
void GetAppHackFlags(IOleObject* pole, const CLSID* pclsid, DWORD* pdwAppHack);

BOOL _IsDesktopItem(CDocObjectHost * pdoh);
BOOL IsAssociatedWithIE(LPCWSTR pwszFileName);
UINT OpenSafeOpenDialog(HWND hwnd, UINT idRes, LPCTSTR pszFileClass, LPCTSTR pszURL, LPCTSTR pszRedirURL, LPCTSTR pszCacheName, LPCTSTR pszDisplay, UINT uiCP, IUnknown *punk = NULL, BOOL fDisableOpen = FALSE);

void CDownLoad_OpenUI(IMoniker* pmk, 
                      IBindCtx *pbc, 
                      BOOL fSync, 
                      BOOL fSaveAs=FALSE, 
                      BOOL fSafe=FALSE, 
                      LPWSTR pwzHeaders = NULL, 
                      DWORD dwVerb=BINDVERB_GET, 
                      DWORD grfBINDF = (BINDF_ASYNCHRONOUS | BINDF_PULLDATA), 
                      BINDINFO* pbinfo = NULL,
                      LPCTSTR pszRedir=NULL,
                      UINT uiCP = CP_ACP,
                      IUnknown *punk = NULL,
                      BOOL fConfirmed=FALSE
                      );

HRESULT CDownLoad_OpenUIURL(LPCWSTR pwszURL, IBindCtx *pbc, LPWSTR pwzHeaders, BOOL fSync, BOOL fSaveAs=FALSE, BOOL fSafe=FALSE, DWORD dwVerb=BINDVERB_GET, DWORD grfBINDF=(BINDF_ASYNCHRONOUS | BINDF_PULLDATA), BINDINFO* pbinfo=NULL,
                    LPCTSTR pszRedir=NULL, UINT uiCP=CP_ACP, IUnknown *punk = NULL, BOOL fConfirmed=FALSE);

HRESULT _GetRequestFlagFromPIB(IBinding *pib, DWORD *pdwOptions);
HRESULT _SetSearchInfo (IServiceProvider *psp, DWORD dwIndex, BOOL fAllowSearch, BOOL fContinueSearch, BOOL fSentToEngine);
HRESULT _GetSearchInfo (IServiceProvider *psp, LPDWORD pdwIndex, LPBOOL pfAllowSearch, LPBOOL pfContinueSearch, LPBOOL pfSentToEngine);


// Values for automatically scanning common net suffixes

#define NO_SUFFIXES     0
#define SCAN_SUFFIXES   1
#define DONE_SUFFIXES   2

// Registry values for automatically sending request to search engine

#define NEVERSEARCH     0
#define PROMPTSEARCH    1
#define ALWAYSSEARCH    2

#define SHOULD_DO_SEARCH(x,y) (y || (x && x != DONE_SUFFIXES))
