<?xml version="1.0" encoding="UTF-16"?>
<!DOCTYPE DCARRIER SYSTEM "Mantis.DTD">

  <DCARRIER
    CarrierRevision="1"
    DTDRevision="16"
  >
    <TASKS
      Context="1"
      PlatformGUID="{00000000-0000-0000-0000-000000000000}"
    >    </TASKS>

    <PLATFORMS
      Context="1"
    >    </PLATFORMS>

    <REPOSITORIES
      Context="1"
      PlatformGUID="{00000000-0000-0000-0000-000000000000}"
    >    </REPOSITORIES>

    <GROUPS
      Context="1"
      PlatformGUID="{00000000-0000-0000-0000-000000000000}"
    >    </GROUPS>

    <COMPONENTS
      Context="0"
      PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
    >
      <COMPONENT
        ComponentVSGUID="{20AC4A9A-7120-442D-8502-69E58B47A6DA}"
        ComponentVIGUID="{868D63F1-245B-461F-A1C8-84ECE73A1EBE}"
        Revision="620"
        PrototypeVIGUID="{E4A44BD2-D0C1-4C53-AB0C-D10A5C4E55B5}"
        RepositoryVSGUID="{8E0BE9ED-7649-47F3-810B-232D36C430B4}"
        Visibility="1000"
        MultiInstance="False"
        Released="False"
        Editable="True"
        HTMLFinal="False"
        IsMacro="False"
        Opaque="False"
        Context="1"
        PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
      >
        <HELPCONTEXT
          src=".\help\_microsoft_korean_ime_core_component_description.htm"
        ><![CDATA[<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML DIR="LTR"><HEAD>
<META HTTP-EQUIV="Content-Type" Content="text/html; charset=Windows-1252">
<TITLE>Microsoft Korean IME Core Component Description</TITLE>
<STYLE TYPE="text/css">
<!--
BODY         { font: normal  8pt Tahoma; background-color: #FFFFFF; }
P            { font: normal  8pt Tahoma; }
.showhide    { color: blue; text-decoration: underline; cursor: hand; }
.callout     { font: normal  8pt Tahoma; background-color: #E0E0E0; padding: 10pt; }
.code        { font: normal  8pt Courier New; }
UL           { font: normal  8pt Tahoma; list-style: square outside; margin-left: 0.25in; }
OL           { font: normal  8pt Tahoma; list-style: decimal outside; margin-left: 0.25in; }
H1           { font: bold   12pt Tahoma; margin-bottom: -12pt; }
H2           { font: bold   10pt Tahoma; margin-bottom: -12pt; }
H3           { font: bold    8pt Tahoma; margin-bottom: -12pt; }
H4           { font: italic  8pt Tahoma; margin-bottom: -12pt; }
TABLE        { font: normal  8pt Tahoma; text-align: left; padding: 2px; }
CAPTION      { font: bold    8pt Tahoma; text-align: left; padding: 2px; }
THEAD        { font: bold    8pt Tahoma; text-align: left; padding: 2px; background-color: #F0F0F0 }
TH           { font: bold    8pt Tahoma; text-align: left; padding: 2px; background-color: #F0F0F0 }
TBODY        { font: normal  8pt Tahoma; text-align: left; padding: 2px; }
TD           { font: normal  8pt Tahoma; text-align: left; padding: 2px; }
TR           { font: normal  8pt Tahoma; text-align: left; padding: 2px; }
CODE         { font-family: Courier New; }
TT           { font-family: Courier New; }
KBD          { font-family: Courier New; font-weight: bold; }
VAR          { font-family: Courier New; font-style: italic; }
EM           { font-style: italic; }
I            { font-style: italic; }
STRONG       { font-weight: bold; }
B            { font-weight: bold; }
-->
</STYLE>
</HEAD>
<BODY TOPMARGIN="0">

The Microsoft Korean IME Core component includes the Korean Input Method Editor (IME) and Korean keyboard text input processor (TIP) for the text services framework, which allows users to input Korean text using the keyboard.</P>

<H3>Component Configuration</H3>

<P>There are no configuration requirements for this component.</P>

<H3>Special Notes</H3>

<P>To enable handwriting functionality in IME through the handwriting IME pad applet, you must install the following components:

<UL>
	<LI>Microsoft IME pad</li>

	<LI>Korean handwriting recognizer</li>

	<LI>Microsoft Korean IME handwriting applet</li>
</UL>

</BODY>
</HTML>
]]></HELPCONTEXT>

        <PROPERTIES
          Context="1"
          PlatformGUID="{00000000-0000-0000-0000-000000000000}"
        >        </PROPERTIES>

        <RESOURCES
          Context="1"
          PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
        >
          <RESOURCE
            Name="File(819):&quot;%11%&quot;,&quot;imekr61.ime&quot;"
            ResTypeVSGUID="{E66B49F6-4A35-4246-87E8-5C1A468315B5}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="DstPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%11%</PROPERTY>

              <PROPERTY
                Name="DstName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imekr61.ime</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="File(819):&quot;%10%\IME\IMKR6_1&quot;,&quot;imekrcic.dll&quot;"
            ResTypeVSGUID="{E66B49F6-4A35-4246-87E8-5C1A468315B5}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="DstPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%10%\IME\IMKR6_1</PROPERTY>

              <PROPERTY
                Name="DstName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imekrcic.dll</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="File(819):&quot;%10%\IME\IMKR6_1\Dicts&quot;,&quot;imekr.lex&quot;"
            ResTypeVSGUID="{E66B49F6-4A35-4246-87E8-5C1A468315B5}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="DstPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%10%\IME\IMKR6_1\Dicts</PROPERTY>

              <PROPERTY
                Name="DstName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imekr.lex</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="File(819):&quot;%10%\IME\IMKR6_1&quot;,&quot;imkrinst.exe&quot;"
            ResTypeVSGUID="{E66B49F6-4A35-4246-87E8-5C1A468315B5}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="DstPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%10%\IME\IMKR6_1</PROPERTY>

              <PROPERTY
                Name="DstName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imkrinst.exe</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="File(819):&quot;%10%\IME\IMKR6_1&quot;,&quot;imkrinst.ini&quot;"
            ResTypeVSGUID="{E66B49F6-4A35-4246-87E8-5C1A468315B5}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="DstPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%10%\IME\IMKR6_1</PROPERTY>

              <PROPERTY
                Name="DstName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imkrinst.ini</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="File(819):&quot;%10%\IME\IMKR6_1&quot;,&quot;imekrmig.exe&quot;"
            ResTypeVSGUID="{E66B49F6-4A35-4246-87E8-5C1A468315B5}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="DstPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%10%\IME\IMKR6_1</PROPERTY>

              <PROPERTY
                Name="DstName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imekrmig.exe</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\E0010412&quot;,&quot;Layout Text&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\E0010412</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Layout Text</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Korean Input System (MS-IME2002)</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegOp"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegCond"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\Software\Microsoft\IMEKR\6.1\Directories&quot;,&quot;DictionaryPath&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_LOCAL_MACHINE\Software\Microsoft\IMEKR\6.1\Directories</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >DictionaryPath</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%WINDIR%\IME\IMKR6_1\Dicts</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegOp"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegCond"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\Software\Microsoft\IMEKR\6.1\Directories&quot;,&quot;IMEPadPath&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_LOCAL_MACHINE\Software\Microsoft\IMEKR\6.1\Directories</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >IMEPadPath</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%WINDIR%\IME\IMKR6_1\Applets</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegOp"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegCond"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\Software\Microsoft\IMEKR\6.1\Directories&quot;,&quot;ModulePath&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_LOCAL_MACHINE\Software\Microsoft\IMEKR\6.1\Directories</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >ModulePath</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%WINDIR%\IME\IMKR6_1</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegOp"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegCond"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\Software\Microsoft\IMEKR\6.1&quot;,&quot;Dictionary&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_LOCAL_MACHINE\Software\Microsoft\IMEKR\6.1</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Dictionary</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegOp"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegCond"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%WINDIR%\IME\IMKR6_1\Dicts\imekr.lex</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>HKEY_LOCAL_MACHINE\Software\Microsoft\IMEKR\6.1\Dictionary</DISPLAYNAME>

            <DESCRIPTION></DESCRIPTION>
          </RESOURCE>

          <RESOURCE
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\E0010412&quot;,&quot;Layout File&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\E0010412</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Layout File</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >KBDKOR.DLL</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegOp"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegCond"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\E0010412&quot;,&quot;Layout Display Name&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\E0010412</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Layout Display Name</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >@%SystemRoot%\system32\input.dll,-5064</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegOp"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegCond"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\E0010412&quot;,&quot;IME file&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\E0010412</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >IME file</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imekr61.ime</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegOp"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegCond"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\Software\Microsoft\IMEKR&quot;,&quot;Version&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_LOCAL_MACHINE\Software\Microsoft\IMEKR</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Version</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >6.1</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegOp"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegCond"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;CLSID&quot;,&quot;{33C53A50-F456-4884-B049-85FD643ECFED}&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >CLSID</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >{33C53A50-F456-4884-B049-85FD643ECFED}</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;CLSID&quot;,&quot;{93AC9CB8-27D5-4482-BFDF-68F21C7454A3}&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >CLSID</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >{93AC9CB8-27D5-4482-BFDF-68F21C7454A3}</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;KERNEL32.DLL&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >KERNEL32.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;RegKey&quot;,&quot;HKEY_CURRENT_USER\Keyboard Layout\Preload&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >RegKey</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CURRENT_USER\Keyboard Layout\Preload</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;RegKey&quot;,&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >RegKey</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;user32.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >user32.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;advapi32.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >advapi32.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;gdi32.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >gdi32.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;shell32.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >shell32.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;comctl32.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >comctl32.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;ole32.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >ole32.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;version.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >version.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;mscandui.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >mscandui.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;kbdkor.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >kbdkor.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="FBRegDLL(819):&quot;%10%\IME\IMKR6_1\imkrinst.exe&quot;,&quot;&quot;"
            ResTypeVSGUID="{322D2CA9-219E-4380-989B-12E8A830DFFA}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="Arguments"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="DLLEntryPoint"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="DLLInstall"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>

              <PROPERTY
                Name="DLLRegister"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>

              <PROPERTY
                Name="FilePath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%10%\IME\IMKR6_1\imkrinst.exe</PROPERTY>

              <PROPERTY
                Name="Flags"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >0</PROPERTY>

              <PROPERTY
                Name="Timeout"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >0</PROPERTY>
            </PROPERTIES>

            <DESCRIPTION>This will run IME custom Setup EXE</DESCRIPTION>
          </RESOURCE>

          <RESOURCE
            Name="File(819):&quot;%10%\IME\Shared\Res&quot;,&quot;padrs412.dll&quot;"
            ResTypeVSGUID="{E66B49F6-4A35-4246-87E8-5C1A468315B5}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="DstPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%10%\IME\Shared\Res</PROPERTY>

              <PROPERTY
                Name="DstName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >padrs412.dll</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;softkbd.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >softkbd.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="File(819):&quot;%10%\IME\IMKR6_1\Help&quot;,&quot;korpaden.chm&quot;"
            ResTypeVSGUID="{E66B49F6-4A35-4246-87E8-5C1A468315B5}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="DstPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%10%\IME\IMKR6_1\Help</PROPERTY>

              <PROPERTY
                Name="DstName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >korpaden.chm</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;oleaut32.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >oleaut32.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;imm32.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imm32.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;msctf.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >msctf.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="File(819):&quot;%10%\IME\IMKR6_1\Help&quot;,&quot;imkr61.chm&quot;"
            ResTypeVSGUID="{E66B49F6-4A35-4246-87E8-5C1A468315B5}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="DstPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%10%\IME\IMKR6_1\Help</PROPERTY>

              <PROPERTY
                Name="DstName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imkr61.chm</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="File(819):&quot;%10%\IME\IMKR6_1\Help&quot;,&quot;imkren61.chm&quot;"
            ResTypeVSGUID="{E66B49F6-4A35-4246-87E8-5C1A468315B5}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="DstPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%10%\IME\IMKR6_1\Help</PROPERTY>

              <PROPERTY
                Name="DstName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imkren61.chm</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="File(819):&quot;%10%\IME\IMKR6_1\Help&quot;,&quot;impdko61.chm&quot;"
            ResTypeVSGUID="{E66B49F6-4A35-4246-87E8-5C1A468315B5}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="DstPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%10%\IME\IMKR6_1\Help</PROPERTY>

              <PROPERTY
                Name="DstName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >impdko61.chm</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="File(819):&quot;%10%\IME\IMKR6_1\Help&quot;,&quot;imkr61.hlp&quot;"
            ResTypeVSGUID="{E66B49F6-4A35-4246-87E8-5C1A468315B5}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="DstPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%10%\IME\IMKR6_1\Help</PROPERTY>

              <PROPERTY
                Name="DstName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imkr61.hlp</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="File(819):&quot;%10%\IME\IMKR6_1\Help&quot;,&quot;imkren61.hlp&quot;"
            ResTypeVSGUID="{E66B49F6-4A35-4246-87E8-5C1A468315B5}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="DstPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%10%\IME\IMKR6_1\Help</PROPERTY>

              <PROPERTY
                Name="DstName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imkren61.hlp</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;imepadsm.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imepadsm.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;imepadsv.exe&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imepadsv.exe</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;imlang.dll&quot;"
            ResTypeVSGUID="{90D8E195-E710-4AF6-B667-B1805FFC9B8F}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="False"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="RawType"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >File</PROPERTY>

              <PROPERTY
                Name="Value"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >imlang.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>
        </RESOURCES>

        <GROUPMEMBERS
        >
          <GROUPMEMBER
            GroupVSGUID="{E01B4103-3883-4FE8-992F-10566E7B796C}"
          ></GROUPMEMBER>

          <GROUPMEMBER
            GroupVSGUID="{719FF4F5-55C2-4A87-A744-19E6C9B3089F}"
          ></GROUPMEMBER>
        </GROUPMEMBERS>

        <DEPENDENCIES
          Context="1"
          PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
        >
          <DEPENDENCY
            Class="Include"
            Type="All"
            DependOnGUID="{8F917DBC-51E1-401A-8178-A01BB6C0394F}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >            </PROPERTIES>

            <DISPLAYNAME>Microsoft Korean IME Core depends on Keyboard: Korean</DISPLAYNAME>

            <DESCRIPTION></DESCRIPTION>
          </DEPENDENCY>
        </DEPENDENCIES>

        <DISPLAYNAME>Microsoft Korean IME Core</DISPLAYNAME>

        <VERSION>6.1</VERSION>

        <DESCRIPTION>Microsoft Korean IME Core</DESCRIPTION>

        <COPYRIGHT>2000 Microsoft Corp.</COPYRIGHT>

        <VENDOR>Microsoft Corp.</VENDOR>

        <OWNERS>CSLIM</OWNERS>

        <AUTHORS>CSLIM</AUTHORS>

        <DATECREATED>3/9/2001</DATECREATED>

        <DATEREVISED>11/3/2001 5:04:00 AM</DATEREVISED>
      </COMPONENT>
    </COMPONENTS>

    <RESTYPES
      Context="1"
      PlatformGUID="{00000000-0000-0000-0000-000000000000}"
    >    </RESTYPES>
  </DCARRIER>
