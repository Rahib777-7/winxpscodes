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
        ComponentVSGUID="{730386D6-D71F-4336-959B-270F410F960C}"
        ComponentVIGUID="{2C35CF01-F44F-4972-9FDC-9EC0BA7A4988}"
        Revision="620"
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
          src="X:\nt\net\diagnostics\wmi\dll\dgnet_Network_Diagnostics.htm"
        ><![CDATA[<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML DIR="LTR"><HEAD>
<META HTTP-EQUIV="Content-Type" Content="text/html; charset=Windows-1252">
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
<TITLE>DGNet Network Diagnostics Component Description</TITLE>
</HEAD>
<body topmargin="0">

The Network Diagnostics (DGNet) component comprises a Web page, an ActiveX control, and a Windows Management Instrumentation (WMI) provider. The ActiveX control and the WMI provider are contained within the same physical dynamic-link library (DLL) called dgnet.dll. The main Web page is named dglogs.htm. The Web page makes calls into the ActiveX control to start and stop, as well as check the progress of the diagnostic tests. The ActiveX control performs a series of operations mostly using WMI. Some WMI calls are made to a Microsoft Win32 provider for general computer information and some are made to the DGNet provider to perform specific tests. The DGNet provider performs PING and TCP connection tests. The PING tests are used to test connectivity to the default gateway, Dynamic Host Configuration Protocol (DHCP), Domain Name System (DNS) and Windows Internet Naming Service (WINS) servers. TCP connection tests are also used to check the availability of Internet e-mail and newsgroup services.</P>

<P>The Web page resides within the PCHealth framework and can be invoked from a number of places in the user interface (UI) and from the Uniform Resource Identifier (URI) hcp:\\system\netdiag\dglogs.htm. The DGNet WMI provider functionality can be invoked separately from the Web page using standard WMI access methods, such as Component Object Model (COM), scripting, or the command line.</P>

<H3>Component Configuration</H3>

<P>The Web page does contain configurable properties under Set Scanning Options. These are documented in the actual Web page, called dglogs.htm, with ToolTip Help on each configuration item. These scanning options set the actions, such as PING and connection, and the categories, such as Mail Service and Network Adapters, that the DGNet scanning operation will perform. The options are not independent since each category only has certain actions that may be applied to it.</P>


</div>
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
            Name="File(273):&quot;%11%&quot;,&quot;dgnet.dll&quot;"
            ResTypeVSGUID="{E66B49F6-4A35-4246-87E8-5C1A468315B5}"
            BuildTypeMask="273"
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
              >dgnet.dll</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>Network Diagnostics Provider</DISPLAYNAME>

            <DESCRIPTION>Collects and performs Network Diagnostics test</DESCRIPTION>
          </RESOURCE>

          <RESOURCE
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{8dabe793-23d9-45df-a3db-f442883bb479}&quot;,&quot;&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{8dabe793-23d9-45df-a3db-f442883bb479}</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >DgnetCom Class</PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{8dabe793-23d9-45df-a3db-f442883bb479}\InprocServer32&quot;,&quot;&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{8dabe793-23d9-45df-a3db-f442883bb479}\InprocServer32</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >dgnet.dll</PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{8dabe793-23d9-45df-a3db-f442883bb479}\InprocServer32&quot;,&quot;ThreadingModel&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{8dabe793-23d9-45df-a3db-f442883bb479}\InprocServer32</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >ThreadingModel</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Both</PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{8dabe793-23d9-45df-a3db-f442883bb479}\ProgID&quot;,&quot;&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{8dabe793-23d9-45df-a3db-f442883bb479}\ProgID</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Dgnet.DgnetCom.1</PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{8dabe793-23d9-45df-a3db-f442883bb479}\Programmable&quot;,&quot;&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{8dabe793-23d9-45df-a3db-f442883bb479}\Programmable</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{8dabe793-23d9-45df-a3db-f442883bb479}\VersionIndependentProgID&quot;,&quot;&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{8dabe793-23d9-45df-a3db-f442883bb479}\VersionIndependentProgID</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Dgnet.DgnetCom</PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}&quot;,&quot;&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >DglogsCom Class</PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\Implemented Categories&quot;,&quot;&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\Implemented Categories</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\Implemented Categories\{7DD95801-9882-11CF-9FA9-00AA006C42C4}&quot;,&quot;&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\Implemented Categories\{7DD95801-9882-11CF-9FA9-00AA006C42C4}</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\Implemented Categories\{7DD95802-9882-11CF-9FA9-00AA006C42C4}&quot;,&quot;&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\Implemented Categories\{7DD95802-9882-11CF-9FA9-00AA006C42C4}</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\InprocServer32&quot;,&quot;&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\InprocServer32</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >dgnet.dll</PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\InprocServer32&quot;,&quot;ThreadingModel&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\InprocServer32</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >ThreadingModel</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Free</PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\ProgID&quot;,&quot;&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\ProgID</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Dgnet.DglogsCom.1</PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\Programmable&quot;,&quot;&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\Programmable</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\TypeLib&quot;,&quot;&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\TypeLib</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >{01D0A772-4346-4186-94F5-A1A120BC3401}</PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\VersionIndependentProgID&quot;,&quot;&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_CLASSES_ROOT\CLSID\{76FF3452-E474-4032-BED5-BBE4E96B6D2F}\VersionIndependentProgID</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              ></PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Dgnet.DglogsCom</PROPERTY>

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
            Name="RegKey(273):&quot;HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NetSh&quot;,&quot;dglogs&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="273"
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
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="KeyPath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NetSh</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >dglogs</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >dgnet.dll</PROPERTY>

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
            Name="FBRegDLL(819):&quot;%11%\dgnet.dll&quot;,&quot;&quot;"
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
              >True</PROPERTY>

              <PROPERTY
                Name="FilePath"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%11%\dgnet.dll</PROPERTY>

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

            <DISPLAYNAME>dgnet</DISPLAYNAME>

            <DESCRIPTION>dgnet registration</DESCRIPTION>
          </RESOURCE>

          <RESOURCE
            Name="File(819):&quot;%11%\wbem&quot;,&quot;dgnet.mof&quot;"
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
              >%11%\wbem</PROPERTY>

              <PROPERTY
                Name="DstName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >dgnet.mof</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>DGNET mof file</DISPLAYNAME>

            <DESCRIPTION>DGNET properties and methods</DESCRIPTION>
          </RESOURCE>
        </RESOURCES>

        <GROUPMEMBERS
        >
          <GROUPMEMBER
            GroupVSGUID="{0778E781-871A-4E95-9915-7E3EE9E6C7B6}"
          ></GROUPMEMBER>
        </GROUPMEMBERS>

        <DEPENDENCIES
          Context="1"
          PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
        >
          <DEPENDENCY
            Class="Include"
            Type="All"
            DependOnGUID="{061AB9C1-9BBD-425E-89BC-D55FF69BF330}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >            </PROPERTIES>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="All"
            DependOnGUID="{9FD7C4B9-D47B-4463-A0A4-5049DDF4C265}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >            </PROPERTIES>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="All"
            DependOnGUID="{CB6FD864-D64C-4BD7-A55E-DF05F1975711}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >            </PROPERTIES>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="All"
            DependOnGUID="{7E34D737-6FF4-4EB5-8DF6-97B321FEC915}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >            </PROPERTIES>
          </DEPENDENCY>
        </DEPENDENCIES>

        <DISPLAYNAME>Network Diagnostics</DISPLAYNAME>

        <VERSION>1.0</VERSION>

        <DESCRIPTION>Performs common networking and connectivity tests</DESCRIPTION>

        <COPYRIGHT>2000 Microsoft Corp.</COPYRIGHT>

        <VENDOR>Microsoft Corp.</VENDOR>

        <OWNERS>omiller</OWNERS>

        <AUTHORS>omiller; willzi</AUTHORS>

        <DATECREATED>7/27/2000</DATECREATED>

        <DATEREVISED>6/5/2001</DATEREVISED>
      </COMPONENT>
    </COMPONENTS>

    <RESTYPES
      Context="1"
      PlatformGUID="{00000000-0000-0000-0000-000000000000}"
    >    </RESTYPES>
  </DCARRIER>
