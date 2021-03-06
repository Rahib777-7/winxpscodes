

#ifndef _NMMKCERT_
#define _NMMKCERT_

// Flags
#define NMMKCERT_F_DELETEOLDCERT        0x00000001
#define NMMKCERT_F_LOCAL_MACHINE        0x00000002
#define NMMKCERT_F_CLEANUP_ONLY         0x00000004

// NetMeeting certificate store
#define SZNMSTORE       "_RDSTR"
#define WSZNMSTORE      L"_RDSTR"

// Magic constant in user properties
#define NMMKCERT_MAGIC    0x2389ABD0

// RDN name of issuing root cert...
#define SZ_NMROOTNAME TEXT("Remote Desktop Root")

// When issuer obtained using these flags
#ifndef CERT_NAME_STR_REVERSE_FLAG
#define CERT_NAME_STR_REVERSE_FLAG      0x02000000
#endif // CERT_NAME_STR_REVERSE_FLAG

#define CERT_FORMAT_FLAGS (CERT_SIMPLE_NAME_STR|CERT_NAME_STR_NO_PLUS_FLAG|\
    CERT_NAME_STR_REVERSE_FLAG)

// Library Name
#define SZ_NMMKCERTLIB TEXT("RDMKCERT.DLL")

// Prototype typedef
typedef DWORD (WINAPI *PFN_NMMAKECERT)(LPCSTR, LPCSTR, LPCSTR, LPCSTR, LPCSTR, DWORD);

// Loadlibrary constant
#define SZ_NMMAKECERTFUNC "RDMakeCert"

// Static prototype
extern
DWORD
WINAPI
NmMakeCert (
    LPCSTR szFirstName,
    LPCSTR szLastName,
    LPCSTR szEmailName,
    LPCSTR szCity,
    LPCSTR szCountry,
    DWORD dwFlags );

extern
void
CALLBACK
NmMakeCertCleanup (
    HWND hwnd,
    HINSTANCE hinst,
    LPSTR lpszCmdLine,
    int nCmdShow );

#endif // _NMMKCERT_

