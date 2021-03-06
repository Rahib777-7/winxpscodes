/*********************************************************
   DllData file -- partially generated by MIDL compiler 

  We are building the .idls over in multimedia\Published\DXMDev\dshowdev\idl but we want the actual 
  proxy stub to live in MSTvE.dll *not* quartz.dll 
  This is because registering the typelibs wipes out the proxy stub registration and
  we want to avoid any registration order dependencies.  so , we must register the proxy/stubs in 
  the MSTvE.dl after the typelib registration and it wouldn't be good to do it in both places and
  make quartz.dll unecessarily larger.

  consequently, we are manually maintaining this file.  if you add a new .idl to the MSTvE you
  must update these entries

  for simplicity sake since we know we're always merging the proxy stub we're combining dlldata.c and
  dlldatax.c as well.  -- Also, dlldata.c  over in Published\DXMDev\dshowdev\idl\objd\i386 is totally
  the wrong one...

*********************************************************/

// wrapper for dlldata.c

#ifdef _MERGE_PROXYSTUB // merge proxy stub DLL

#define REGISTER_PROXY_DLL //DllRegisterServer, etc.

//#define _WIN32_WINNT 0x0400     //for WinNT 4.0 or Win95 with DCOM (not for NT)
#define USE_STUBLESS_PROXY        //defined only with MIDL switch /Oicf

#pragma comment(lib, "rpcndr.lib")
#pragma comment(lib, "rpcns4.lib")
#pragma comment(lib, "rpcrt4.lib")

#define DllMain             PrxDllMain
#define DllRegisterServer   PrxDllRegisterServer
#define DllUnregisterServer PrxDllUnregisterServer
#define DllGetClassObject   PrxDllGetClassObject
#define DllCanUnloadNow     PrxDllCanUnloadNow

// -------------------------------
//  it was this
//#include "dlldata.c"
// -------------------------------
//  it's now this...
#define PROXY_DELEGATION

#include <rpcproxy.h>

#ifdef __cplusplus
extern "C"   {
#endif

EXTERN_PROXY_FILE( mstve )


PROXYFILE_LIST_START
/* Start of list */
  REFERENCE_PROXY_FILE( mstve ),
/* End of list */
PROXYFILE_LIST_END


DLLDATA_ROUTINES( aProxyFileList, GET_DLL_CLSID )

#ifdef __cplusplus
}  /*extern "C" */
#endif

// ----------------------------
#include "MSTvE_p.c"

#ifdef _NOPROXY //no midl generated dlldata.c

#define STRICT 1
#include <ole2.h>

BOOL WINAPI PrxDllMain(HINSTANCE hInstance, DWORD dwReason, LPVOID lpReserved)
{return TRUE;}

STDAPI PrxDllCanUnloadNow(void){return S_OK;}

STDAPI PrxDllGetClassObject(REFCLSID rclsid, REFIID riid, LPVOID* ppv)
{return CLASS_E_CLASSNOTAVAILABLE;}

STDAPI PrxDllRegisterServer(void){return S_OK;}

STDAPI PrxDllUnregisterServer(void){return S_OK;}

#endif //!PROXY_DELEGATION

#endif //_MERGE_PROXYSTUB

