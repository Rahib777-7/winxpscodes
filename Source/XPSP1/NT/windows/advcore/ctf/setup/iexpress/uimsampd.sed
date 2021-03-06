[Version]
Class=IEXPRESS
SEDVersion=3
[Options]
PackagePurpose=InstallApp
ShowInstallProgramWindow=0
HideExtractAnimation=0
UseLongFileName=0
InsideCompressed=0
CAB_FixedSize=0
CAB_ResvCodeSigning=0
RebootMode=I
InstallPrompt=%InstallPrompt%
DisplayLicense=%DisplayLicense%
FinishMessage=%FinishMessage%
TargetName=%TargetName%
FriendlyName=%FriendlyName%
AppLaunched=%AppLaunched%
PostInstallCmd=%PostInstallCmd%
AdminQuietInstCmd=%AdminQuietInstCmd%
UserQuietInstCmd=%UserQuietInstCmd%
SourceFiles=SourceFiles
[Strings]
InstallPrompt=This will install the CTF (Cicero) Sample Text Processors.   You must first install CTF.  Continue?
DisplayLicense=
FinishMessage=Setup Complete
TargetName=..\uimsampd.exe
FriendlyName=CTF (Cicero) Sample Text Processor Installation
AppLaunched=uimsampd.inf
PostInstallCmd=readme.exe
AdminQuietInstCmd=
UserQuietInstCmd=
FILE1="ctb.pdb"
FILE2="ctb.sym"
FILE3="cicero.txt"
FILE6="kimx.dic"
FILE7="kimx.dll"
FILE8="kimx.pdb"
FILE9="kimx.sym"
FILE18="ctb.exe"
FILE19="uimsampd.inf"
FILE20="moreinfo.txt"
FILE21="readme.exe"
FILE23="Aimeapps.exe"
FILE24="Aimmmsgs.exe"
FILE25="Aimmmsgs.pdb"
FILE26="Aimeapps.pdb"
FILE27="Aimmmsgs.sym"
FILE28="Aimeapps.sym"
FILE33="TestimeA.exe"
FILE34="TestimeW.exe"
FILE37="TestimeA.pdb"
FILE38="TestimeW.pdb"
FILE39="msuimui.dll"
FILE40="msuimui.pdb"
FILE41="msuimui.sym"

[SourceFiles]
SourceFiles0=..\srcd\
SourceFiles1=..\samples\
[SourceFiles0]
%FILE1%=
%FILE2%=
%FILE3%=
%FILE6%=
%FILE7%=
%FILE8%=
%FILE9%=
%FILE18%=
%FILE23%=
%FILE24%=
%FILE25%=
%FILE26%=
%FILE27%=
%FILE28%=
%FILE33%=
%FILE34%=
%FILE37%=
%FILE38%=
%FILE39%=
%FILE40%=
%FILE41%=

[SourceFiles1]
%FILE19%=
%FILE20%=
%FILE21%=
