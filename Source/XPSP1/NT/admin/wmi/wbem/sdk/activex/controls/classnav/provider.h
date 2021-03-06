// Copyright (c) 1997-2001 Microsoft Corporation, All Rights Reserved
/* This header file machine-generated by mktyplib.exe */
/* Interface to type library: MosProvider_v1 */

#ifndef _MosProvider_v1_H_
#define _MosProvider_v1_H_

DEFINE_GUID(LIBID_MosProvider_v1,0x027947F3L,0xD731,0x11CE,0xA3,0x57,0x00,0x00,0x00,0x00,0x00,0x01);

typedef enum {
    OLEMS_FLAG_KEYS_ONLY = 1,
    OLEMS_FLAG_ALWAYS,
    OLEMS_FLAG_ONLY_IF_TRUE,
    OLEMS_FLAG_ONLY_IF_FALSE,
    OLEMS_FLAG_ONLY_IF_IDENTICAL,
    OLEMS_FLAG_INCLUDE_ATTR,
    OLEMS_FLAG_CLASS_ATTRIB,
    OLEMS_FLAG_PRIVATE_ATTRIB,
    OLEMS_FLAG_TEMP_ATTRIB,
    OLEMS_FLAG_NAMESPACE_ATTRIB,
    OLEMS_FLAG_SHALLOW,
    OLEMS_FLAG_DEEP,
    OLEMS_FLAG_NO_EXPANSION,
    OLEMS_FLAG_PREFER_THIS,
    OLEMS_FLAG_PREFER_SOURCE
} OLEMS_FLAG_TYPE;

typedef enum {
    OLEMS_NO_ERROR = 0,
    OLEMS_S_NO_MORE_DATA = 262145,
    OLEMS_E_FAILED = -2147217407,
    OLEMS_E_NOT_FOUND,
    OLEMS_E_ACCESS_DENIED,
    OLEMS_E_PERMISSION_DENIED,
    OLEMS_E_PROVIDER_FAILURE,
    OLEMS_E_TYPE_MISMATCH,
    OLEMS_E_INVALID_ENV_VAR,
    OLEMS_E_OUT_OF_MEMORY,
    OLEMS_E_UNSUPPORTED_VARIANT,
    OLEMS_E_NETWORK_ERROR,
    OLEMS_E_INVALID_CONTEXT,
    OLEMS_E_INVALID_PARAMETER,
    OLEMS_E_NOT_AVAILABLE,
    OLEMS_E_CRITICAL_ERROR,
    OLEMS_E_INVALID_STREAM,
    OLEMS_E_NOT_SUPPORTED,
    OLEMS_E_INVALID_SUPERCLASS,
    OLEMS_E_INVALID_NAMESPACE,
    OLEMS_E_INVALID_OBJECT,
    OLEMS_E_INVALID_CLASS,
    OLEMS_E_PROVIDER_NOT_FOUND,
    OLEMS_E_INVALID_PROVIDER_REGISTRATION,
    OLEMS_E_PROVIDER_LOAD_FAILURE
} OLEMS_STATUS;

DEFINE_GUID(IID_IMosAttributeSet,0xDC12A680L,0x737F,0x11CF,0x88,0x4D,0x00,0xAA,0x00,0x4B,0x2E,0x24);

/* Definition of interface: IMosAttributeSet */
#undef INTERFACE
#define INTERFACE IMosAttributeSet

DECLARE_INTERFACE_(IMosAttributeSet, IUnknown)
{
#ifndef NO_BASEINTERFACE_FUNCS

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, LPVOID FAR* ppvObj) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;
#endif

    /* IMosAttributeSet methods */
    STDMETHOD_(SCODE, Get)(THIS_ BSTR Name, long lFlags, long FAR* plType, VARIANT FAR* pVal) PURE;
    STDMETHOD_(SCODE, Put)(THIS_ BSTR Name, long lType, VARIANT FAR* pVal) PURE;
    STDMETHOD_(SCODE, Delete)(THIS_ BSTR Name) PURE;
    STDMETHOD_(SCODE, GetNames)(THIS_ SAFEARRAY FAR* FAR* pNames) PURE;
    STDMETHOD_(SCODE, Reset)(THIS) PURE;
    STDMETHOD_(SCODE, Next)(THIS_ long lFlags, BSTR FAR* pName, long FAR* plType, VARIANT FAR* pVal) PURE;
};

DEFINE_GUID(IID_IMosClassObject,0xDC12A681L,0x737F,0x11CF,0x88,0x4D,0x00,0xAA,0x00,0x4B,0x2E,0x24);

/* Definition of interface: IMosClassObject */
#undef INTERFACE
#define INTERFACE IMosClassObject

DECLARE_INTERFACE_(IMosClassObject, IUnknown)
{
#ifndef NO_BASEINTERFACE_FUNCS

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, LPVOID FAR* ppvObj) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;
#endif

    /* IMosClassObject methods */
    STDMETHOD_(SCODE, GetAttributeSet)(THIS_ IMosAttributeSet FAR* FAR* pAttribSet) PURE;
    STDMETHOD_(SCODE, Get)(THIS_ BSTR Name, long lFlags, VARIANT FAR* pVal) PURE;
    STDMETHOD_(SCODE, Put)(THIS_ BSTR Name, long lFlags, VARIANT FAR* pVal) PURE;
    STDMETHOD_(SCODE, Delete)(THIS_ BSTR Name) PURE;
    STDMETHOD_(SCODE, GetNames)(THIS_ SAFEARRAY FAR* FAR* pNames, BSTR AttrName, long lFlags, VARIANT FAR* pVal) PURE;
    STDMETHOD_(SCODE, GetType)(THIS_ BSTR Name, long FAR* plType) PURE;
    STDMETHOD_(SCODE, Reset)(THIS) PURE;
    STDMETHOD_(SCODE, Next)(THIS_ long lFlags, BSTR FAR* pName, VARIANT FAR* pVal) PURE;
    STDMETHOD_(SCODE, GetPropAttributeSet)(THIS_ BSTR pProperty, IMosAttributeSet FAR* FAR* pAttribSet) PURE;
    STDMETHOD_(SCODE, Clone)(THIS_ IMosClassObject FAR* FAR* pCopy) PURE;
    STDMETHOD_(SCODE, CopyHere)(THIS_ IMosClassObject FAR* pSrc) PURE;
    STDMETHOD_(SCODE, Merge)(THIS_ long lFlags, IMosClassObject FAR* pSrc) PURE;
    STDMETHOD_(SCODE, PutAttribForAllProps)(THIS_ BSTR Name, long lType, VARIANT FAR* pVal) PURE;
    STDMETHOD_(SCODE, DeleteAttribForAllProps)(THIS_ BSTR Name, long lFlags, VARIANT FAR* pVal) PURE;
    STDMETHOD_(SCODE, DeleteProps)(THIS_ BSTR Attrib, long lFlags, VARIANT FAR* pVal) PURE;
    STDMETHOD_(SCODE, GetObjectText)(THIS_ BSTR FAR* pMofSyntax) PURE;
};

DEFINE_GUID(IID_IMosNotify,0x7C857801L,0x7381,0x11CF,0x88,0x4D,0x00,0xAA,0x00,0x4B,0x2E,0x24);

/* Definition of interface: IMosNotify */
#undef INTERFACE
#define INTERFACE IMosNotify

DECLARE_INTERFACE_(IMosNotify, IUnknown)
{
#ifndef NO_BASEINTERFACE_FUNCS

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, LPVOID FAR* ppvObj) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;
#endif

    /* IMosNotify methods */
    STDMETHOD_(SCODE, Notify)(THIS_ long lObjectCount, IMosClassObject FAR* FAR* pObjArray) PURE;
};

DEFINE_GUID(IID_IEnumMosClassObject,0x027947E1L,0xD731,0x11CE,0xA3,0x57,0x00,0x00,0x00,0x00,0x00,0x01);

/* Definition of interface: IEnumMosClassObject */
#undef INTERFACE
#define INTERFACE IEnumMosClassObject

DECLARE_INTERFACE_(IEnumMosClassObject, IUnknown)
{
#ifndef NO_BASEINTERFACE_FUNCS

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, LPVOID FAR* ppvObj) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;
#endif

    /* IEnumMosClassObject methods */
    STDMETHOD_(SCODE, Reset)(THIS) PURE;
    STDMETHOD_(SCODE, Next)(THIS_ ULONG uCount, IMosClassObject FAR* FAR* pProp, ULONG FAR* puReturned) PURE;
    STDMETHOD_(SCODE, Clone)(THIS_ IEnumMosClassObject FAR* FAR* pEnum) PURE;
    STDMETHOD_(SCODE, Skip)(THIS_ ULONG nNum) PURE;
};

DEFINE_GUID(IID_IMosProvider,0x9556DC99L,0x828C,0x11CF,0xA3,0x7E,0x00,0xAA,0x00,0x32,0x40,0xC7);

/* Definition of interface: IMosProvider */
#undef INTERFACE
#define INTERFACE IMosProvider

DECLARE_INTERFACE_(IMosProvider, IUnknown)
{
#ifndef NO_BASEINTERFACE_FUNCS

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, LPVOID FAR* ppvObj) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;
#endif

    /* IMosProvider methods */
    STDMETHOD_(SCODE, OpenNamespace)(THIS_ BSTR ObjectPath, BSTR User, BSTR Password, IMosProvider FAR* FAR* pNewContext) PURE;
    STDMETHOD_(SCODE, QueryNotificationHandler)(THIS_ IMosNotify FAR* FAR* pHandler) PURE;
    STDMETHOD_(SCODE, CreateClass)(THIS_ long lFlags, BSTR Parent, IMosClassObject FAR* FAR* pObj) PURE;
    STDMETHOD_(SCODE, DeleteClass)(THIS_ BSTR Class, long lFlags) PURE;
    STDMETHOD_(SCODE, CreateClassEnum)(THIS_ BSTR Parent, long lFlags, IEnumMosClassObject FAR* FAR* pEnum) PURE;
    STDMETHOD_(SCODE, CreateClassEnumAsync)(THIS_ BSTR RefClass, long lFlags, IMosNotify FAR* pHandler) PURE;
    STDMETHOD_(SCODE, UpdateClass)(THIS_ long lFlags, IMosClassObject FAR* pObj) PURE;
    STDMETHOD_(SCODE, GetClass)(THIS_ BSTR Class, long lFlags, IMosClassObject FAR* FAR* pObj) PURE;
    STDMETHOD_(SCODE, GetClassAsync)(THIS_ BSTR Class, long lFlags, IMosNotify FAR* pHandler) PURE;
    STDMETHOD_(SCODE, CreateInstance)(THIS_ BSTR Class, long lFlags, IMosClassObject FAR* FAR* pInst) PURE;
    STDMETHOD_(SCODE, UpdateInstance)(THIS_ long lFlags, IMosClassObject FAR* pInst) PURE;
    STDMETHOD_(SCODE, DeleteInstance)(THIS_ BSTR ObjectPath) PURE;
    STDMETHOD_(SCODE, CreateInstanceEnum)(THIS_ long lFlags, BSTR Class, IEnumMosClassObject FAR* FAR* pEnum) PURE;
    STDMETHOD_(SCODE, CreateInstanceEnumAsync)(THIS_ BSTR Class, long lFlags, IMosNotify FAR* pHandler) PURE;
    STDMETHOD_(SCODE, LockInstance)(THIS_ long lFlags, BSTR ObjectPath) PURE;
    STDMETHOD_(SCODE, UnlockInstance)(THIS_ BSTR ObjectPath) PURE;
    STDMETHOD_(SCODE, RefreshInstance)(THIS_ long lFlags, IMosClassObject FAR* pObj) PURE;
    STDMETHOD_(SCODE, RefreshInstanceAsync)(THIS_ long lFlags, IMosClassObject FAR* pObj, IMosNotify FAR* pHandler) PURE;
    STDMETHOD_(SCODE, GetObjectByPath)(THIS_ BSTR ObjectPath, IMosClassObject FAR* FAR* pObj) PURE;
    STDMETHOD_(SCODE, GetObjectByPathAsync)(THIS_ BSTR ObjectPath, IMosNotify FAR* pHandler) PURE;
    STDMETHOD_(SCODE, ExecQuery)(THIS_ BSTR QueryFormat, BSTR Query, IEnumMosClassObject FAR* FAR* pEnum) PURE;
    STDMETHOD_(SCODE, ExecQueryAsync)(THIS_ BSTR QueryFormat, BSTR Query, IMosNotify FAR* pHandler) PURE;
    STDMETHOD_(SCODE, ExecQueryIndirect)(THIS_ BSTR QueryObjectPath, IEnumMosClassObject FAR* FAR* pEnum) PURE;
    STDMETHOD_(SCODE, ExecQueryIndirectAsync)(THIS_ BSTR QueryObjectPath, IMosNotify FAR* pHandler) PURE;
    STDMETHOD_(SCODE, ExecMethod)(THIS_ BSTR Object, BSTR MethodEncodingFormat, void FAR* InboundEncoding, void FAR* FAR* OutboundEncoding) PURE;
    STDMETHOD_(SCODE, GetErrorInformation)(THIS_ long LocaleId, BSTR FAR* pErrorInfo) PURE;
};

DEFINE_GUID(IID_IMosLocator,0xDC12A687L,0x737F,0x11CF,0x88,0x4D,0x00,0xAA,0x00,0x4B,0x2E,0x24);

/* Definition of interface: IMosLocator */
#undef INTERFACE
#define INTERFACE IMosLocator

DECLARE_INTERFACE_(IMosLocator, IUnknown)
{
#ifndef NO_BASEINTERFACE_FUNCS

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, LPVOID FAR* ppvObj) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;
#endif

    /* IMosLocator methods */
    STDMETHOD_(SCODE, ConnectServer)(THIS_ BSTR ObjectPath, BSTR User, BSTR Password, long lFlags, IMosProvider FAR* FAR* pNamespace) PURE;
};

DEFINE_GUID(CLSID_MosLocator,0xD85ADEF1L,0xDD7F,0x11CE,0xA3,0x57,0x00,0x00,0x00,0x00,0x00,0x01);

#ifdef __cplusplus
class MosLocator;
#endif

DEFINE_GUID(CLSID_MosClassObject,0xD85ADEF2L,0xDD7F,0x11CE,0xA3,0x57,0x00,0x00,0x00,0x00,0x00,0x01);

#ifdef __cplusplus
class MosClassObject;
#endif

#endif
