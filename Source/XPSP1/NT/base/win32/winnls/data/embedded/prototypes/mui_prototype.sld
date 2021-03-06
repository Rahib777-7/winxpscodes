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
    >
      <GROUP
        GroupVSGUID="{AA7B4D8D-9808-45A7-8E6E-92BFC609BF6E}"
        Revision="1000"
        GroupClass="Dependency"
        DefaultDependencyType="All"
        Context="1"
        PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
      >
        <PROPERTIES
          Context="1"
          PlatformGUID="{00000000-0000-0000-0000-000000000000}"
        >        </PROPERTIES>

        <DISPLAYNAME>Windows XP Embedded MUI Resources</DISPLAYNAME>

        <VERSION>1.0</VERSION>

        <DESCRIPTION>This group contains all Windows XP Embedded MUI resource components. Language Support Prototype component depends on at least one of the members of this group, and English is one of the members.</DESCRIPTION>

        <COPYRIGHT>Microsoft (C) 2001</COPYRIGHT>

        <VENDOR>Microsoft</VENDOR>

        <OWNERS>SJang, JohnMcco</OWNERS>

        <AUTHORS>SJang, JohnMcco</AUTHORS>

        <DATECREATED>9/25/2001 6:28:05 AM</DATECREATED>

        <DATEREVISED>10/17/2001 9:33:51 AM</DATEREVISED>
      </GROUP>
    </GROUPS>

    <COMPONENTS
      Context="1"
      PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
    >
      <COMPONENT
        ComponentVSGUID="{02632E3A-8E2B-4C35-97F7-129D2F420D73}"
        ComponentVIGUID="{4BBD543A-98EC-46AE-B9E1-7AD2585D8B23}"
        Revision="1000"
        PrototypeVIGUID="{8F98D77A-42FD-430D-A86E-E68D2A255ECE}"
        RepositoryVSGUID="{00000000-0000-0000-0000-000000000000}"
        Visibility="250"
        MultiInstance="True"
        Released="False"
        Editable="False"
        HTMLFinal="False"
        IsMacro="False"
        Opaque="False"
        Context="1"
        PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
      >
        <SCRIPTTEXT
          language="VBScript"
          src=".\mui_prototype.vbs"
          encoded="False"
        ><![CDATA['////////////////////////////////////////////////////////////////////////////
' $Header:$
' Windows Embedded MUI Prototype
' Version: 1.00
' Author: sjang
' Copyright (c) 1999-2001 Microsoft Corp. All Rights Reserved.
'////////////////////////////////////////////////////////////////////////////

'**************************************************************************************************************************
' CONSTANTS AND GLOBAL VARIABLES
'**************************************************************************************************************************
Option Explicit

'
' Script error codes (1000..1999=exceptions, 2000..2999=ReportStatus errors)
' 5800..5899=error codes for language-related scripts
' [From XpeSysShared.vbs]
'
Public Const errLangInvalidComponentData   = 5800
Public Const errLangInvalidPropertyFormat  = 5801
Public Const errLangInvalidPropertyValue   = 5802
Public Const errLangDepTargetNotFound      = 5803
Public Const errLangInternalError          = 5899 ' programming error

Public Const cMuiFolder = "%10%\mui\FALLBACK\"
Public Const cHelpMuiFolder = "%18%\mui\"
Public Const cMuiInstallRegKey = "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Nls\MUILanguages"
Public Const cMuiSettingRegKey = "HKEY_USERS\.DEFAULT\Control Panel\Desktop"

Dim oPL : Set oPL = cmiThis.Configuration.Script.oPL

'**************************************************************************************************************************
' ULITITY FUNCTIONS
'**************************************************************************************************************************

'////////////////////////////////////////////////////////////////////////////
' GetProp
' Returns an extended property object based on a property name
' or returns Nothing if no such property exists
' properties.
' oOwner    - object to get extended property from
' sName     - name of the extended property to Get
'
Public Function GetProp(oOwner,sName)
   On Error Resume Next
   Dim oProps
   Set GetProp = Nothing   
   Set oProps = oOwner.Properties
   On Error Goto 0
   If Err.Number <> 0 Then
      Err.Raise errLangInvalidComponentData, "GetProp", _
                MakeMsg(oOwner," does not have property collection.")
      Exit Function
   End If
   If oProps.Exists(sName) Then
      Set GetProp = oProps.Item(sName)
   End If
End Function

'////////////////////////////////////////////////////////////////////////////
' IsValidLangMuiProp
'
' sOwner - owner of property object
' oProp  - property object
'
' Returns True if a language extended property has the proper format and
' value range. This function needs to be called only on the properties that
' were entered by the user manually.
'
' Valid Language-related extended Properties
'
' cmiLangModuleType              (integer)   0 - 5 (0 = valid but reserved value)
' cmiLangId                      (integer)   non-zero
' cmiLangName                    (string)    non-empty
' cmiLangEnableMui               (boolean)   True or False
' cmiLangLocaleGroup             (boolean)   True or False
' cmiLangMuiOwner                (guid)      a valid guid (assumed)
' 
' The following extended properties will be validated separately
' cmiLangGeoLocation[nnnn]    (string)    non-empty;<GEOID in decimal>
'
Public Function IsValidLangMuiProp(oOwner, oProp)

   IsValidLangMuiProp = True
    
   If oProp Is Nothing Then
      IsValidLangMuiProp = False
      Exit Function
   End If
      
   Select Case LCase(oProp.Name)
      Case LCase("cmiLangModuleType")
         If (oProp.Format <> cmiInteger) Or _
            (oProp.Value > cLangMaxModuleType) or _
            (oProp.Value < cLangModuleTypeInvalid) Then IsValidLangMuiProp = False
      Case LCase("cmiLangId")
         If (oProp.Format <> cmiInteger) Or (oProp.Value = 0) Then IsValidLangMuiProp = False
      Case LCase("cmiLangName")
         If (oProp.Format <> cmiString) Or (Trim(oProp.Value) = "") Then IsValidLangMuiProp = False
      Case LCase("cmiLangEnableMui")
         If (oProp.Format <> cmiBoolean) Then IsValidLangMuiProp = False
      Case LCase("cmiLangMuiOwner")
         If (oProp.Format <> cmiGuid) Then IsValidLangMuiProp = False
      Case LCase("cmiLangMuiCustomGroup")
         If (oProp.Format <> cmiGuid) Then IsValidLangMuiProp = False
      Case LCase("cmiLangMUILCID")
         If (oProp.Format <> cmiString) Then IsValidLangMuiProp = False
      Case Else
            IsValidLangMuiProp = True     ' If not in our list to check, pass the check
   End Select

   If Not IsValidLangMuiProp Then
      ' Error is raised by the caller as appropriate
      oPL.ReportWarning errLangInvalidComponentData, "IsValidLangMuiProp", _
                        MakeMsg(oOwner, "Extended property " & _
                                oProp.Name & " contains invalid format or value.")
   End If
End Function

'////////////////////////////////////////////////////////////////////////////
' MakeMsg
' Construct a standard message text to pass to oPL.ReportError or
' ReportWarning or ReportInfo
'
Public Function MakeMsg(oSource,sText)
   Select Case LCase(TypeName(oSource))
      Case "component"
         MakeMsg = "[" & oSource.DisplayName & "] " & sText
      Case "instance"
         MakeMsg = "[" & oSource.DisplayName & "] " & sText
      Case "dependency"
         MakeMsg = "[" & oSource.DisplayName & "] " & sText
      Case "resource"
         MakeMsg = "[" & oSource.Name & "] " & sText
      Case "extproperty"
         MakeMsg = "[" & oSource.Name & "] " & sText
      Case "string"
         MakeMsg = "[" & oSource & "] " & sText
      Case Else
         MakeMsg = "[Object of type " & TypeName(oSource) & "] " & sText
   End Select
End Function

'////////////////////////////////////////////////////////////////////////////
' GetHexLangId
' Returns a 4-digit hex representation of cmiLangId of this component.
'
Function GetHexLangId(n)
   Dim s : s = Hex(n)
   If Len(s) < 5 Then
      GetHexLangId = String(4 - Len(s), "0") & s
   Else
      GetHexLangId = s
   End If
End Function

'////////////////////////////////////////////////////////////////////////////
' IsDefaultMUILanguage
' Returns True if this language is selected as the default UI language.
'
Function IsDefaultMUILanguage(oInst)
   Dim oConfigProp
   Dim oInstProp
   IsDefaultMUILanguage = False
   Set oConfigProp = GetProp(oInst.Configuration, "cmiLangDefaultUILanguage")
   Set oInstProp = GetProp(oInst, "cmiLangId")
   If (Not oConfigProp Is Nothing) And (Not oInstProp Is Nothing) Then
      IsDefaultMUILanguage = (oInstProp.Value = oConfigProp.Value)
   End If
End Function

'**************************************************************************************************************************
' EVENT HANDLERS AND RELATED SUBROUTINES
'**************************************************************************************************************************

'////////////////////////////////////////////////////////////////////////////
' BuildMuiRes
' An MUI resource is a file that contains translated strings and artwork.
' We try to find the file in our MUI repository. If file is found, copy it
' to the appropriate destination. Otherwise, not much we can do...
'
' oInst        - cmiThis
' sFilePath    - full path to the owner of the resource file
'
Sub BuildMuiRes(oInst, sFilePath)
   Dim aFilePath
   Dim sFileName
   Dim sSrcFileName
   Dim sSrcPath
   Dim sDestPath
   Dim sExt
   Dim oSLProp : Set oSLProp = GetProp(oInst, "cmiLangMUILCID")
   If oSLProp Is Nothing Then Exit Sub
   Dim sHexLangId : sHexLangId = oSLProp.Value

   '
   ' sSrcFileName is the name of the file in our repository (stored in extended properties)
   ' for a given English file.
   '
   aFilePath = Split(sFilePath, "\")
   sFileName = aFilePath(UBound(aFilePath))
   If oInst.Properties.Exists("cmiSrcFor_" & sFileName) Then
      sSrcFileName = oInst.Properties.Item("cmiSrcFor_" & sFileName).Value
   Else
      sSrcFileName = sFileName
   End If

   '
   ' a generic MUI file always goes to the same folder, and we only need dst name
   '
   aFilePath = Split(sFileName, ".")
   sExt = aFilePath(UBound(aFilePath))
   sSrcPath = oPL.FindSrcFile(sSrcFileName & ".mui", oInst)

   If Not IsEmpty(sSrcPath) Then
      ' Typical .MUI file
      sDestPath = cMUIFolder & sHexLangId & "\" & sFileName & ".mui"
      sDestPath = oPL.TargetToAbsPath(sDestPath)
      On Error Resume Next
      oPL.CopySrcFile sSrcFileName & ".mui", sDestPath, oInst, True
      If Err.Number <> 0 Then oPL.ReportWarning 1, oInst.DisplayName, " failed to copy file [code: " & CStr(Err.Number) & "]"
      On Error Goto 0
   Else
      sSrcPath = oPL.FindSrcFile(sSrcFileName, oInst)
      If Not IsEmpty(sSrcPath) Then
         ' Help file or some other case
         Select Case LCase(sExt)
         Case LCase("CHM")
            sDestPath = cHelpMuiFolder & sHexLangId & "\" & sFileName
         Case LCase("HLP")
            sDestPath = cHelpMuiFolder & sHexLangId & "\" & sFileName
         Case LCase("CNT")
            sDestPath = cHelpMuiFolder & sHexLangId & "\" & sFileName
         Case LCase("MFL")
            sDestPath = cMuiFolder & sHexLangId & "\" & sFileName
         Case Else
            sDestPath = cMuiFolder & sHexLangId & "\" & sFileName
         End Select
         sDestPath = oPL.TargetToAbsPath(sDestPath)
         On Error Resume Next
         oPL.CopySrcFile sSrcFileName, sDestPath, oInst, True
         If Err.Number <> 0 Then oPL.ReportWarning 1, oInst.DisplayName, " failed to copy file [code: " & CStr(Err.Number) & "]"
         On Error Goto 0
      End If
   End If
End Sub

'////////////////////////////////////////////////////////////////////////////
' InitializeCustomMuiDependencies
'
' This routine creates a depedency for each member of the group indicated by
' the guid passed in. These components are custom MUI components that need
' to be pulled in to support components that require additional MUI resources.
'
' oInst        - MUI Res instance object
' guidGroup    - GUID of the custom MUI group
'
Sub InitializeCustomMuiDependencies(oInst, guidGroup)
   Dim oCustomMuiSet
   Dim oComp
   Dim oCompProps
   Dim oCompProp
   Dim oDep
   Dim oDepProp
	'
	' If the GUID is zero GUID, there is no custom MUI components
	'
	If guidGroup <> cZeroGUID Then
      On Error Resume Next
	   Set oCustomMuiSet = Nothing   ' in case we fail
		Set oCustomMuiSet = oPL.CreateFromDB(cmiComponents, _
						                         cmiFTGetGroupMembers Or cmiFTNoAttachments, _
						                         guidGroup)
      On Error Goto 0
		If Not oCustomMuiSet Is Nothing Then
			For each oComp in oCustomMuiSet
            '
				' Create a dependency and attach it to the language support
				'
				Set oDep = oPL.CMI.CreateObject(cmiDependency, oInst.PlatformVSGUID)
				oDep.TargetGUID = oComp.VIGUID
				oDep.Class = cmiInclude
				oDep.Type = cmiAtLeastOne
				oDep.MinRevision = 0
				oDep.Disabled = True    ' These dependencies are disabled by default.
				oDep.DisplayName = oComp.DisplayName
				oDep.Description = "Dependency on custom MUI component."
            '
				' Get properties for the component
				'
      		Set oCompProps = oPL.CreateFromDB(cmiExtProperties, _
								                      cmiFTGetComponentData, _
								                      oComp.VSGUID)
				'
				' Create extended properties to be used during dependency checking
				'
				If oCompProps.Exists("cmiLangMuiOwner") Then
				   Set oCompProp = oCompProps.Item("cmiLangMuiOwner")    ' find the owner component
				   If IsValidLangMuiProp( oComp, oCompProp) Then
					   Set oDepProp = oPL.CreateProp(oCompProp.Name, oCompProp.Format, oCompProp.Value)
					   oDep.Properties.Add oDepProp
   				End If
            End If
  				'
				' Finally add the dependency object
				'
				cmiThis.Dependencies.Add oDep
   		Next	' Next extended support component
		End If
	End If
End Sub


'////////////////////////////////////////////////////////////////////////////
' cmiOnActivateInstance (virtual)
' Called from Config::cmiOnActivateInstance
'
' oOldInstance		Old Instance for upgrade, else Nothing
' Returns			True to allow activation, False to disallow
'
' This routine does:
'
' Initializes oConfigData so that the basic objects are set up in this object,
' and the avaialbe geographical location list is available for DHTML.
'
Function cmiOnActivateInstance(oOldInstance)
   Dim oProp
   ' First call super
	If Not cmiSuper.cmiOnActivateInstance(Nothing) Then
	   Exit Function
	End If
   '
   ' Identify custom MUI component dependencies, and
   ' create conditional dependencies on them.
   '
   Set oProp = GetProp(cmiThis,"cmiLangMuiCustomGroup")
   If IsValidLangMuiProp(cmiThis, oProp) Then
      InitializeCustomMuiDependencies cmiThis, oProp.Value
   End If
	cmiOnActivateInstance = True
End Function

'////////////////////////////////////////////////////////////////////////////
' cmiOnBeginCheckDependencies (virtual)
' Called from Config::cmiOnCheckDependencies
'
' dwFlags			Arbitrary flags passed from Config.CheckDeps method
'
Sub cmiOnBeginCheckDependencies(dwFlags)
   Dim oDep
   Dim oDepProp
   Dim guidComp
   Dim aInstList, i                                      ' instance guids
   Dim oInst
   Dim oInstProp
   '
   ' Adjust dependencies according to the properties set by the DHTML 
   '
   For Each oDep In cmiThis.Dependencies
      oDep.Disabled = True                ' only enable if we need to
      Set oDepProp = GetProp(oDep,"cmiLangMuiOwner")
      If Not oDepProp Is Nothing Then
         guidComp = oDepProp.Value
         If oPL.GToI.PrimaryExists(guidComp) Then        ' if instance is present
            aInstList = oPL.GToI.Keys(guidComp)       
            For i = 0 to UBound(aInstList)
               Set oInst = cmiThis.Configuration.Instances(aInstList(i))
               Set oInstProp = GetProp(oInst, "cmiLangEnableMui")
               If oInstProp.Value Then
                  oDep.Disabled = False                  ' enable only if Mui was
                  Exit For                               ' enabled for the owner of this resource
               End If
            Next
         End If
      End If
   Next
   ' Lastly call super
   cmiSuper.cmiOnBeginCheckDependencies dwFlags
End Sub

'////////////////////////////////////////////////////////////////////////////
' cmiOnEndBuild (virtual)
' Called from Config::cmiOnEndBuild
'
' dwFlags			Arbitrary flags passed from Config.Build method
Sub cmiOnEndBuild(dwFlags)
	Dim oInst
	Dim oProp
	Dim oDictEnableMui      ' Key = instance guid, value = True or false
	Set oDictEnableMui = CreateObject("Scripting.Dictionary")
	Set oProp = GetProp(cmiThis, "cmiLangMUILCID")
	If oProp Is Nothing Then
	   oPL.ReportError errLangInvalidComponentData, "cmiOnEndBuild", MakeMsg(cmiThis, " cmiLangMUILCID is missing.")
	   Exit Sub      ' this is not a well formed MUI Resource component
	End If
	Dim sHexLangId : sHexLangId = oProp.Value    ' 4-digit hex value identifying the language
	'
	' Construct oDictEnableMui
	'
	For Each oInst in cmiThis.Configuration.Instances
	   Set oProp = GetProp(oInst,"cmiLangEnableMui")
	   If oProp Is Nothing Then
              oDictEnableMui.Add oInst.VSGUID, False ' assume false if the property doesn't exists
           Else
              oDictEnableMui.Add oInst.VSGUID, oProp.Value
	   End If
	Next
	'
	' Process each file, if it belongs to an instance that has MUI enabled
	'
	Dim aFileList, i
	Dim aInstList
	aFileList = oPL.FileList.Keys
	For i = 0 To UBound(aFileList)
	   aInstList = oPL.FileList(aFileList(i))
	   If oDictEnableMui(aInstList(0)) Then
	      BuildMuiRes cmiThis, aFileList(i)
	   End If
	Next
	'
	' Indicate that we are installed on the system
	'
	Dim nRegOp
	Dim nRegCond
	Dim nRegType
	Dim sKeyPath
	Dim sValueName
	Dim vRawValue
	Dim nRawFormat
	nRegOp = cRegOpWrite
	nRegCond = cRegCondAlways
	nRegType = cmiREG_SZ
	sKeyPath = cMuiInstallRegKey
	sValueName = sHexLangId
	vRawValue = "1"
	nRawFormat = cmiString
   oPL.TargetRegEdit nRegOp, nRegCond, nRegType, sKeyPath, sValueName, vRawValue, nRawFormat

	'
	' Check if we are the default UI language, if so, set up the default user
	' with our language.
	'
	If IsDefaultMUILanguage(cmiThis) Then
	   '
	   ' Set some default settings in SYSTEM hive
	   '
	   nRegOp = cRegOpWrite
	   nRegCond = cRegCondAlways
	   nRegType = cmiREG_DWORD
	   sKeyPath = cMuiInstallRegKey
	   sValueName = "MatchSystemLocale"
	   vRawValue = 0
	   nRawFormat = cmiInteger
      oPL.TargetRegEdit nRegOp, nRegCond, nRegType, sKeyPath, sValueName, vRawValue, nRawFormat	   

	   nRegOp = cRegOpWrite
	   nRegCond = cRegCondAlways
	   nRegType = cmiREG_DWORD
	   sKeyPath = cMuiInstallRegKey
      sValueName = "UIFontSubstitute"
	   vRawValue = 0
	   nRawFormat = cmiInteger
      oPL.TargetRegEdit nRegOp, nRegCond, nRegType, sKeyPath, sValueName, vRawValue, nRawFormat	   
	   '
	   ' change settings for the default user
	   '
	   sKeyPath = cMuiSettingRegKey
   	nRegOp = cRegOpWrite
	   nRegCond = cRegCondAlways
	   nRegType = cmiREG_SZ
	   vRawValue = "0000" & sHexLangId
	   nRawFormat = cmiString
	   sValueName = "MuiLanguagePending"
      oPL.TargetRegEdit nRegOp, nRegCond, nRegType, sKeyPath, sValueName, vRawValue, nRawFormat
	   sValueName = "MultiUILanguageId"
      oPL.TargetRegEdit nRegOp, nRegCond, nRegType, sKeyPath, sValueName, vRawValue, nRawFormat
	End If
End Sub
]]></SCRIPTTEXT>

        <PROPERTIES
          Context="1"
          PlatformGUID="{00000000-0000-0000-0000-000000000000}"
        >
          <PROPERTY
            Name="cmiSrcFor_Diamond Compatible 6500K G1.8.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >dg18d65.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Diamond Compatible 5000K G1.8.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >dg18d50.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_defrag.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >defragP.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_cpanel.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >cpanelw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_compmgmt.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >compmgtW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_comsetup.inf"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >comntwks.inf</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_comnt5.inf"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >comntwks.inf</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_cmconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >cmconW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows Classic.theme"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >classic.the</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_View Channels.scf"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >channels.scf</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_certmgr.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >certmgrW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_bootcons.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >bootconP.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_shellstyle.dll"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >blue_ss.dll</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_audit.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >auditW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_admtools.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >admtoolW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_eventcreate.exe"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >evcreate.exe</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_evconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >evcon.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_encrypt.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >encryptW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_dwintl.dll"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >dwil1033.dll</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_dtcsetup.inf"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >dtcntwks.inf</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_dtcnt5.inf"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >dtcntwks.inf</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_dskquoui.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >dskquoP.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_driverquery.exe"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >drvqry.exe</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_dkconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >dkconP.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_display.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >displayw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_diskmgmt.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >diskmgtW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_diagboot.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >diagbtP.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Diamond Compatible 9300K G2.2.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >dg22d93.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Diamond Compatible 6500K G2.2.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >dg22d65.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Diamond Compatible 5000K G2.2.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >dg22d50.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Diamond Compatible 9300K G1.8.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >dg18d93.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Hitachi Compatible 9300K G2.2.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >hg22d93.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Hitachi Compatible 6500K G2.2.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >hg22d65.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Hitachi Compatible 5000K G2.2.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >hg22d50.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Hitachi Compatible 9300K G1.8.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >hg18d93.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Hitachi Compatible 6500K G1.8.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >hg18d65.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Hitachi Compatible 5000K G1.8.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >hg18d50.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_gpresult.exe"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >gprslt.exe</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_gpedit.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >gpeditW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Glossary.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >glosW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_gen.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >genW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_find.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >findw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_filefold.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >filefldw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_eventtriggers.exe"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >evtrig.exe</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_CmdEvTgProv.mof"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >evtgprov.mof</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_CmdEvTgProv.dll"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >evtgprov.dll</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_eventquery.vbs"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >evtquery.vbs</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_misc.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >miscw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Luna.theme"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >luna.the</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_luna.msstyles"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >luna.mst</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_lpeconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >lpecon.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_localsec.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >locsecw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_isconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >isconW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_is.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >isW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Ipv6.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >ipv6P.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_ipsecsnp.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >ipsecW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_ipsecconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >ipseconW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_intellimirror.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >intellim.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_iismmc.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >iiswmmc.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_iis.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >iisntw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_iasnew.mdb"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >ias.mdb</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_hschelp.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >hschelpw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_howto.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >howtow.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_ntbackup.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >ntbckupW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_ntart.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >ntartW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_NEC Compatible 9300K G2.2.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >ng22d93.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_NEC Compatible 6500K G2.2.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >ng22d65.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_NEC Compatible 5000K G2.2.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >ng22d50.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_NEC Compatible 9300K G1.8.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >ng18d93.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_NEC Compatible 6500K G1.8.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >ng18d65.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_NEC Compatible 5000K G1.8.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >ng18d50.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_netcfg.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >netcfgW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_mstask.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >mstaskW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_msmqocm.inf"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >msmqocmW.inf</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_msmqconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >msmqconW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_msmq.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >msmqW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_msjetoledb40.dll"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >msjetol1.dll</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_mpconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >mpconW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_mode.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >modeW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_rsop.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >rsopW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_rsm.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >rsmW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_rsmconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >rsmconW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_rrc.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >rrcW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_reskit.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >reskitW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_rdesktop.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >rdsktpW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_qosconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >qosconw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_pwrmn.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pwrmnw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_printing.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >printW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_password.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >passwrdw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_pagefileconfig.vbs"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pagefile.vbs</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_openfiles.exe"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >opnfiles.exe</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_offlinefolders.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >offlfdrW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nwdoc.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >nwdocW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nusrmgr.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >nusrmgrW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_ntcmds.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >ntcmdsW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_3"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >Splat.wmz</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_spconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >spconW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_snmpconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >snmpcon.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_smlogcfg.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >smlgcfgW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_setup.inf"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >setup16.inf</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_setup.bmp"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >setup_w.bmp</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_secsettings.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >secsetW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_secsetconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >secsconW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_schtasks.exe"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >sctasks.exe</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_scmconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >scmcon.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_sceconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >sceconW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_sce.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >sceW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_sc.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >scW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_saferconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >safrconW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_safer.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >saferW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_rsopsnp.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >rsopsnpW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Trinitron Compatible 9300K G1.8.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >tg18d93.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Trinitron Compatible 6500K G1.8.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >tg18d65.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Trinitron Compatible 5000K G1.8.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >tg18d50.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_telnet.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >telnetW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_tcpip.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >tcpipW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_taskmgr.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >taskmgrw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_taskbar.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >taskbarw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_tapi.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >tapiP.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_sysrestore.hlp"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >sysrestr.hlp</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_sysrestore.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >sysrestW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_sysmon.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >sysmonW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_systeminfo.exe"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >sysinfo.exe</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_sysdm.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >sysdmw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_sRGB Color Space Profile.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >srgb.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_sr_ui.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >sr_uiW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_spolsconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >spolconW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Error.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPError.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Ding.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPDing.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Default.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPDef.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Critical Stop.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPCrtStp.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Battery Low.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPBatLow.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Battery Critical.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPBatCrt.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Balloon.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPBalln.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_wshconcepts.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >wshcon.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_wpa.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >wpaW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_wmifltr.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >wmifltrW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_wininstl.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >wininstP.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_winhlp32.exe"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >winhstb.exe</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_whatsnew.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >whatnewW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Trinitron Compatible 9300K G2.2.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >tg22d93.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Trinitron Compatible 6500K G2.2.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >tg22d65.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Trinitron Compatible 5000K G2.2.icm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >tg22d50.icm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Start.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPStart.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Shutdown.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPShutdn.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Ringout.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPRngout.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Ringin.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPRingin.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Restore.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPRestor.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Recycle.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPRecycl.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Print complete.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPPrint.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Notify.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPNotify.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Minimize.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPMin.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Menu Command.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPMenu.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Logon Sound.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPLogon.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Logoff Sound.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPLogoff.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Hardware Remove.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPHdRem.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Hardware Insert.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPHdInst.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Hardware Fail.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPHdFail.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Exclamation.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPExcl.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_segment3.txt"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pro_seg3.txt</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_segment3.swf"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pro_seg3.swf</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_segment2.txt"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pro_seg2.txt</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_segment2.swf"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pro_seg2.swf</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_segment1.txt"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pro_seg1.txt</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_segment1.swf"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pro_seg1.swf</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nav.txt"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pro_nav.txt</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nav.swf"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pro_nav.swf</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_intro.txt"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pro_intr.txt</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_intro.swf"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pro_intr.swf</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_ntdef.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >ntdefW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_network.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >networkw.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_migwiz.exe.manifest"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >migwiz.man</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_1"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >elnk3.sys</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_cpanel.chq"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >cpanel_w.chq</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_Windows XP Startup.wav"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >XPStartU.wav</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_multiple_ghost.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht07D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_multiple_big.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht06D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_multiple.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht05D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_data_ghost.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht04D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_data_big.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht03D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_data.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht02D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_bot_bar.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht01D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_bluearrow.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht00D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_windows.chq"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >wind_w.chq</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_windows.chm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >windW.chm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_tour.exe"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >tourW.exe</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_tourstart.exe"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >tourstrt.exe</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_segment5.txt"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pro_seg5.txt</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_segment5.swf"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pro_seg5.swf</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_segment4.txt"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pro_seg4.txt</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_segment4.swf"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >pro_seg4.swf</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img033.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht23D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img014.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht22D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img004b.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht21D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_icon_up.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht20D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_gradient.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht19D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_folder_up.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht18D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_end_up.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht17D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_desktop_up.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht16D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_desktop_screen_shot.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht15D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_control_up.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht14D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_wizard_ghost.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht13D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_wizard_big.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht12D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_wizard.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht11D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_networks_ghost.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht10D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_networks_big.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht09D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_networks.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht08D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img126.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht39D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img123.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht38D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img121.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht37D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img116.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht36D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img110.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht35D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img109.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht34D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img103.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht33D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img100.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht32D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img089.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht31D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img072.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht30D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img068.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht29D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img060.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht28D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img046.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht27D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img040.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht26D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img034.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht25D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img033a.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht24D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nav_unlock_down.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht55D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nav_unlock.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht54D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nav_start_here_down.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht53D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nav_start_here.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht52D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nav_safe_easy_down.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht51D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nav_safe_easy.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht50D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nav_gray.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht49D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nav_connected_down.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht48D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nav_connected.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht47D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nav_blank.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht46D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nav_best_down.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht45D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_nav_best.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht44D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_logo.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht43D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_intro_logo.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht42D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img149.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht41D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img136.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht40D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_ul_logo.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht71D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_taskbar_up.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht70D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_start_up.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht69D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_spacer.gif"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht68D.gif</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_safe_easy_faster_ghost.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht67D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_safe_easy_faster_big.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht66D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_safe_easy_faster.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht65D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_safe_easy_easier_ghost.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht64D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_safe_easy_easier_big.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht63D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_safe_easy_easier.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht62D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_safe_easy_better_ghost.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht61D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_safe_easy_better_big.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht60D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_safe_easy_better.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht59D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_read_icon.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht58D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_question_icon.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht57D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_pen_icon.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht56D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_best_robust.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht05W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_best_road_ghost.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht04W.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_best_road_big.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht03W.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_best_road.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht02W.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_best_road.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht01W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_best_fr.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht00W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_window_up.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht81D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_unlock_playing_ghost.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht80D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_unlock_playing_big.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht79D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_unlock_playing.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht78D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_unlock_optimized_ghost.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht77D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_unlock_optimized_big.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht76D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_unlock_optimized.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht75D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_unlock_built_ghost.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht74D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_unlock_built_big.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht73D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_unlock_built.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht72D.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_safe_better.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht23W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_img074a.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht20W.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_footer.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht19W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_default.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht18W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_wizard.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht17W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_networks.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht16W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_multiple.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht15W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_fr.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht14W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_connected_data.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht13W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_best_secure_ghost.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht12W.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_best_secure_big.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht11W.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_best_secure.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht10W.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_best_secure.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht09W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_best_robust_ghost.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht08W.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_best_robust_big.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht07W.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_best_robust.jpg"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht06W.jpg</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_unlock_fr.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht39W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_unlock_built.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht38W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_style.css"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht37W.css</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_start_windows.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht36W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_start_taskbar.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht35W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_start_menu.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht34W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_start_icons.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht33W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_start_fr.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht32W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_start_files.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht31W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_start_ending.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht30W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_start_desktop.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht29W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_start_control.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht28W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_scripts.js"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht27W.js</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_safe_fr.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht26W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_safe_faster.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht25W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_safe_easier.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht24W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_unlock_playing.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht41W.htm</PROPERTY>

          <PROPERTY
            Name="cmiSrcFor_unlock_optimized.htm"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >xptht40W.htm</PROPERTY>
        </PROPERTIES>

        <RESOURCES
          Context="1"
          PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
        >        </RESOURCES>

        <GROUPMEMBERS
        >
          <GROUPMEMBER
            GroupVSGUID="{719FF4F5-55C2-4A87-A744-19E6C9B3089F}"
          ></GROUPMEMBER>

          <GROUPMEMBER
            GroupVSGUID="{8180C915-788C-473C-80BB-BB6DF8FFA263}"
          ></GROUPMEMBER>

          <GROUPMEMBER
            GroupVSGUID="{E01B4103-3883-4FE8-992F-10566E7B796C}"
          ></GROUPMEMBER>
        </GROUPMEMBERS>

        <DEPENDENCIES
          Context="1"
          PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
        >        </DEPENDENCIES>

        <DISPLAYNAME>MUI Prototype</DISPLAYNAME>

        <VERSION>1.0</VERSION>

        <DESCRIPTION>All MUI resource components inherit from this prototype. This prototype contains component script that will build MUI resource files into run-time image.</DESCRIPTION>

        <COPYRIGHT>Microsoft (C) 2001</COPYRIGHT>

        <VENDOR>Microsoft</VENDOR>

        <OWNERS>SJang, JohnMcco</OWNERS>

        <AUTHORS>SJang, JohnMcco</AUTHORS>

        <DATECREATED>9/24/2001 6:40:06 PM</DATECREATED>

        <DATEREVISED>7/30/2002 10:08:26 AM</DATEREVISED>
      </COMPONENT>
    </COMPONENTS>

    <RESTYPES
      Context="1"
      PlatformGUID="{00000000-0000-0000-0000-000000000000}"
    >    </RESTYPES>
  </DCARRIER>
