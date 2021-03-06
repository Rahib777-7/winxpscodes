#include <stdlib.h>
#include <stdio.h>
#include <windows.h>
#include <string.h>


#define FIVEK   5000
#define TENK    10000
#define ONEHUNK 100000
#define ONEMIL  1000000
#define MEMORY_TEST 200000000

VOID
_fastcall
MemToReg (
    IN ULONG Count,
    IN PULONG Address
    );

VOID
_fastcall
RegToMem (
    IN ULONG Count,
    IN PULONG Address
    );

//
// Define local types.
//

typedef struct _PERFINFO {
    DWORD StartTime;
    DWORD StopTime;
    LPSTR Title;
    DWORD Iterations;
} PERFINFO, *PPERFINFO;

VOID
FinishBenchMark (
    IN PPERFINFO PerfInfo
    )

{

    DWORD ContextSwitches;
    DWORD Duration;
    DWORD Performance;


    //
    // Print results and announce end of test.
    //

    PerfInfo->StopTime = GetTickCount();

    Duration = PerfInfo->StopTime - PerfInfo->StartTime;
    printf("        Test time in milliseconds %d\n", Duration);
    printf("        Number of iterations      %d\n", PerfInfo->Iterations);

    Performance = PerfInfo->Iterations * 1000 / Duration;
    printf("        Iterations per second     %d\n", Performance);


    printf("*** End of Test ***\n\n");
    return;
}

VOID
StartBenchMark (
    IN PCHAR Title,
    IN DWORD Iterations,
    IN PPERFINFO PerfInfo
    )

{

    //
    // Announce start of test and the number of iterations.
    //

    printf("*** Start of test ***\n    %s\n", Title);
    PerfInfo->Title = Title;
    PerfInfo->Iterations = Iterations;
    PerfInfo->StartTime = GetTickCount();
    return;
}

VOID
VqTest(
    VOID
    )

{

    PERFINFO PerfInfo;
    int i;
    PVOID Pv;
    DWORD dw;
    MEMORY_BASIC_INFORMATION BasicInfo;

    //
    // Reserve 64k and commit one page
    //
    Pv = VirtualAlloc(NULL,65536,MEM_RESERVE,PAGE_READWRITE);
    if ( !Pv ) {
        printf("Virtual Alloc(a) Failed %d\n",GetLastError());
        ExitProcess(1);
        }
    Pv = VirtualAlloc(Pv,4096,MEM_COMMIT,PAGE_READWRITE);
    if ( !Pv ) {
        printf("Virtual Alloc(b) Failed %d\n",GetLastError());
        ExitProcess(1);
        }

    SetPriorityClass(GetCurrentProcess(),REALTIME_PRIORITY_CLASS);

    StartBenchMark(
        "Virtual Query Test",
        5*ONEHUNK,
        &PerfInfo
        );

    for ( i=0;i<5*ONEHUNK;i++) {
        dw = VirtualQuery(Pv,&BasicInfo,sizeof(BasicInfo));
        }

    FinishBenchMark(&PerfInfo);

    SetPriorityClass(GetCurrentProcess(),NORMAL_PRIORITY_CLASS);
}

VOID
MulDivTest(
    VOID
    )

{

    PERFINFO PerfInfo;
    int i;

    SetPriorityClass(GetCurrentProcess(),REALTIME_PRIORITY_CLASS);

    StartBenchMark(
        "MulDiv(4,2,5) Test",
        5*ONEMIL,
        &PerfInfo
        );

    for ( i=0;i<5*ONEMIL;i++) {
        MulDiv(4,2,5);
        }

    FinishBenchMark(&PerfInfo);

    StartBenchMark(
        "MulDiv(-4,2,5) Test",
        5*ONEMIL,
        &PerfInfo
        );

    for ( i=0;i<5*ONEMIL;i++) {
        MulDiv(-4,2,5);
        }

    FinishBenchMark(&PerfInfo);


    StartBenchMark(
        "MulDiv(4,-2,5) Test",
        5*ONEMIL,
        &PerfInfo
        );

    for ( i=0;i<5*ONEMIL;i++) {
        MulDiv(4,-2,5);
        }

    FinishBenchMark(&PerfInfo);


    StartBenchMark(
        "MulDiv(-4,-2,5) Test",
        5*ONEMIL,
        &PerfInfo
        );

    for ( i=0;i<5*ONEMIL;i++) {
        MulDiv(-4,-2,5);
        }

    FinishBenchMark(&PerfInfo);

    StartBenchMark(
        "MulDiv(0x10,0x400,0) Test",
        5*ONEMIL,
        &PerfInfo
        );

    for ( i=0;i<5*ONEMIL;i++) {
        MulDiv(0x10,0x400,0);
        }

    FinishBenchMark(&PerfInfo);


    StartBenchMark(
        "MulDiv(0x10,0x40000000,2) Test",
        5*ONEMIL,
        &PerfInfo
        );

    for ( i=0;i<5*ONEMIL;i++) {
        MulDiv(0x10,0x40000000,2);
        }

    FinishBenchMark(&PerfInfo);

    SetPriorityClass(GetCurrentProcess(),NORMAL_PRIORITY_CLASS);
}

VOID
GfaTest(
    LPSTR Str
    )

{

    PERFINFO PerfInfo;
    int i;

    StartBenchMark(
        "GetFileAttributes Test",
        FIVEK,
        &PerfInfo
        );

    for ( i=0;i<FIVEK;i++) {
        GetFileAttributes(Str);
        }

    FinishBenchMark(&PerfInfo);
}

VOID
GmhTest(
    VOID
    )

{

    PERFINFO PerfInfo;
    int i;

    StartBenchMark(
        "GetModuleHandle Test",
        ONEHUNK,
        &PerfInfo
        );

    for ( i=0;i<ONEHUNK;i++) {
        GetModuleHandle("kernel32.dll");
        }

    FinishBenchMark(&PerfInfo);
}

LPVOID Fibers[2];

VOID
FiberRoutine1(
    LPVOID lpParameter
    )
{
    for(;;) {
        SwitchToFiber(Fibers[0]);
        }
}

VOID
FiberRoutine0(
    LPVOID lpParameter
    )
{
    PERFINFO PerfInfo;
    int i;

    StartBenchMark(
        "Fiber Switch Test",
        ONEMIL,
        &PerfInfo
        );

    for ( i=0;i<ONEMIL;i++) {
        SwitchToFiber(Fibers[1]);
        }

    FinishBenchMark(&PerfInfo);
}

VOID
FibTst(
    VOID
    )

{

    Fibers[0] = ConvertThreadToFiber((LPVOID)0);
    Fibers[1] = CreateFiber(0,FiberRoutine1,(LPVOID)1);
    FiberRoutine0((LPVOID)1);
}

VOID
MemoryTest (
    VOID
    )

{

    PULONG Address;
    CHAR Buffer[512];
    ULONG Count;
    PERFINFO PerfInfo;

    //
    // Memory to register - aligned.
    //

    Address = (PULONG)(((ULONG)(&Buffer[128]) + 3) & ~3);
    StartBenchMark("Memory To Register Aligned Test",
                   MEMORY_TEST,
                   &PerfInfo);

    MemToReg(MEMORY_TEST, Address);
    FinishBenchMark(&PerfInfo);

    //
    // Memory to register - unaligned within cache line
    //

    Address = (PULONG)((((ULONG)(&Buffer[256]) + 127) & ~127) + 1);
    StartBenchMark("Memory To Register Unaligned Within Cache Line Test",
                   MEMORY_TEST,
                   &PerfInfo);

    MemToReg(MEMORY_TEST, Address);
    FinishBenchMark(&PerfInfo);

    //
    // Memory to register - unaligned across cache line
    //

    Address = (PULONG)((((ULONG)(&Buffer[256]) + 127) & ~127) - 1);
    StartBenchMark("Memory To Register Unaligned Across Cache Line Test",
                   MEMORY_TEST / 2,
                   &PerfInfo);

    MemToReg(MEMORY_TEST, Address);
    FinishBenchMark(&PerfInfo);

    //
    // Register to memory - aligned.
    //

    Address = (PULONG)(((ULONG)(&Buffer[256]) + 3) & ~3);
    StartBenchMark("Register To Memory Aligned Test",
                   MEMORY_TEST,
                   &PerfInfo);

    RegToMem(MEMORY_TEST, Address);
    FinishBenchMark(&PerfInfo);

    //
    // Register to Memory - unaligned within cache line
    //

    Address = (PULONG)((((ULONG)(&Buffer[256]) + 127) & ~127) + 1);
    StartBenchMark("Register To Memory Unaligned Within Cache Line Test",
                   MEMORY_TEST,
                   &PerfInfo);

    RegToMem(MEMORY_TEST, Address);
    FinishBenchMark(&PerfInfo);

    //
    // Register to Memory - unaligned across cache line
    //

    Address = (PULONG)((((ULONG)(&Buffer[256]) + 127) & ~127) - 1);
    StartBenchMark("Register To Memory Unaligned Across Cache Line Test",
                   MEMORY_TEST / 2,
                   &PerfInfo);

    RegToMem(MEMORY_TEST, Address);
    FinishBenchMark(&PerfInfo);

    return;
}

DWORD
_cdecl
main(
    int argc,
    char *argv[],
    char *envp[]
    )
{

//    VqTest();
//    MulDivTest();
//    GmhTest();
//    if ( argc > 1 ) {
//        GfaTest(argv[1]);
//        }

//    FibTst();


    MemoryTest();
    return 0;
}
