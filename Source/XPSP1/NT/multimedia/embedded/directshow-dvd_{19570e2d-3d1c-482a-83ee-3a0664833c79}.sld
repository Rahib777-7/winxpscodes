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
        ComponentVSGUID="{F0841156-C62A-4D93-B072-E9947617381B}"
        ComponentVIGUID="{13E54D59-5375-4BC4-B27D-0EA60B7C8680}"
        Revision="620"
        RepositoryVSGUID="{8E0BE9ED-7649-47F3-810B-232D36C430B4}"
        Visibility="1000"
        MultiInstance="False"
        Released="False"
        Editable="True"
        HTMLTitle="DirectShow DVD Settings"
        HTMLFinal="False"
        IsMacro="False"
        Opaque="False"
        Context="1"
        PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
      >
        <SCRIPTTEXT
          language="VBScript"
          src=".\DirectShow-DVD.vbs"
          encoded="False"
        ><![CDATA['////////////////////////////////////////////////////////////////////////////
' $Header:$
' Windows Embedded DirectShow-DVD configuration Script
' Version: 1.00
' Author: jomorris
' Copyright (c) 1999-2001 Microsoft Corp. All Rights Reserved.
'////////////////////////////////////////////////////////////////////////////

Option Explicit

'//event fired as part of the processing of method calls on CMI objects
Sub cmiOnEndBuild(dwFlags)

    '//Trace Enter
    Dim sProcName : sProcName = "DirectShow-DVD::cmiOnEndBuild"
    oPL.TraceEnter sProcName '                 //oPL - global object present in Platform Script


    '//DVD Drive Spin Down Timeout 
    Dim nDVDDriveSpinDown
    nDVDDriveSpinDown = cmiThis.Properties("cmiDVDDriveSpinDown").Value

    if (Len(nDVDDriveSpinDown) > 0) then
        oPL.TargetRegEdit cRegOpWrite, cRegCondAlways, cmiREG_DWORD, "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DVDNavigator", "DriveSpindown", nDVDDriveSpinDown, cmiInteger
    end if

    '//Trace Exit
    oPL.TraceLeave sProcName

End Sub
]]></SCRIPTTEXT>

        <HTMLTEXT
          src=".\DirectShow-DVD.asp"
        ><![CDATA[<%asp%>
<%= ASP.Header %>
<%= ASP.PropHandlers %>


<h1> </h1>
<p> </p>

	<table>
		<caption> </caption>
		<tr>
			<td><label for="cmiDVDDriveSpinDown">DVD Drive Spin Down Timeout:</label></td>
			<td><input type="text" name="cmixDefPropHandler" Value="" ID="cmiDVDDriveSpinDown"></td>
		</tr>

	</table>

<p>Note: On portable devices, to conserve battery life it may be desirable to reduce the length of time that a DVD drive will continue to spin after the user 
has paused playback. By default, the disc keeps spinning for two minutes. This value can be modified to set the spin down time in seconds.</p>


<!-- Display custom properties -->
<h3>Custom Properties in DirectShow DVD</h3>
<p>| <%= ASP.ShowSpan("cprops", False) %> |</p>

<div id="cprops" style="display: none;">
<table border="0" bgcolor="#E0E0E0">
	<caption>Custom Properties</caption>
	<thead>
	<tr>
		<th>Name</th>
		<th>Format</th>
		<th>Value</th>
	</tr>
	</thead>
<% Dim oProp %>
<% For Each oProp In ASP.Instance.Properties %>
	<tr valign="top">
		<td><b><%= oProp.Name %></b></td>
		<td><%= oProp.Format %></td>
		<td><%= vuVarToString(oProp.Value, 10) %></td>
	</tr>
<% Next %>
</table>
</div>

<!-- Display all resources -->
<h3>Resources in DirectShow DVD</h3>
<p>| <%= ASP.ShowSpan("res", False) %> |</p>

<div id="res" style="display: none;">
<table border="0" bgcolor="#E0E0E0">
	<caption>Resources</caption>
	<tr>
		<th>Name</th>
		<th>DisplayName</th>
		<th>Disabled</th>
	</tr>
<% Dim oRes
For Each oRes In ASP.Instance.Resources %>
	<tr valign="top">
		<td><b><%= oRes.Name %></b></td>
		<td><%= oRes.DisplayName %></td>
		<td><%= oRes.Disabled %></td>
	</tr>
<% Next %>
</table>
</div>

<%= ASP.Footer %>
]]></HTMLTEXT>

        <PROPERTIES
          Context="1"
          PlatformGUID="{00000000-0000-0000-0000-000000000000}"
        >
          <PROPERTY
            Name="cmiDVDDriveSpinDown"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          ></PROPERTY>
        </PROPERTIES>

        <RESOURCES
          Context="1"
          PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
        >
          <RESOURCE
            Name="File(273):&quot;%11%&quot;,&quot;qdvd.dll&quot;"
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
              >qdvd.dll</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;quartz.dll&quot;"
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
              >quartz.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;devenum.dll&quot;"
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
              >devenum.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="FBRegDLL(819):&quot;%11%\qdvd.dll&quot;,&quot;&quot;"
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
              >%11%\qdvd.dll</PROPERTY>

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
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;ddraw.dll&quot;"
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
              >ddraw.dll</PROPERTY>
            </PROPERTIES>
          </RESOURCE>
        </RESOURCES>

        <GROUPMEMBERS
        >
          <GROUPMEMBER
            GroupVSGUID="{E01B4103-3883-4FE8-992F-10566E7B796C}"
          ></GROUPMEMBER>

          <GROUPMEMBER
            GroupVSGUID="{B35B9EAE-5644-4BFA-877D-DB971CEC0E0C}"
          ></GROUPMEMBER>
        </GROUPMEMBERS>

        <DEPENDENCIES
          Context="1"
          PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
        >        </DEPENDENCIES>

        <DISPLAYNAME>DirectShow DVD</DISPLAYNAME>

        <VERSION>1.0</VERSION>

        <DESCRIPTION>DirectShow DVD</DESCRIPTION>

        <COPYRIGHT>Microsoft Corporation</COPYRIGHT>

        <OWNERS>jayraja</OWNERS>

        <AUTHORS>jayraja</AUTHORS>

        <DATECREATED>2/13/2001</DATECREATED>

        <DATEREVISED>9/19/2001 4:18:08 PM</DATEREVISED>
      </COMPONENT>
    </COMPONENTS>

    <RESTYPES
      Context="1"
      PlatformGUID="{00000000-0000-0000-0000-000000000000}"
    >    </RESTYPES>
  </DCARRIER>
