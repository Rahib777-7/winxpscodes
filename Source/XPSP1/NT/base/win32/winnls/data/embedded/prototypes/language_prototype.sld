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
        GroupVSGUID="{A1A56917-46F2-492E-A544-C4EB1B95F61E}"
        Revision="3"
        GroupClass="Dependency"
        DefaultDependencyType="AtLeastOne"
        Context="1"
        PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
      >
        <PROPERTIES
          Context="1"
          PlatformGUID="{00000000-0000-0000-0000-000000000000}"
        >        </PROPERTIES>

        <DISPLAYNAME>Windows XP Embedded Language Support Group</DISPLAYNAME>

        <VERSION>1.0</VERSION>

        <DESCRIPTION>This group contains all language support components for Windows XP Embedded.</DESCRIPTION>

        <COPYRIGHT>Microsoft (C) 2001</COPYRIGHT>

        <VENDOR>Microsoft</VENDOR>

        <OWNERS>SJang, JohnMcco</OWNERS>

        <AUTHORS>SJang, JohnMcco</AUTHORS>

        <DATECREATED>9/24/2001 9:49:08 PM</DATECREATED>

        <DATEREVISED>10/17/2001 9:35:44 AM</DATEREVISED>
      </GROUP>

      <GROUP
        GroupVSGUID="{CF894FAA-B4C4-4F9E-8409-162FABDDD189}"
        Revision="2"
        GroupClass="Dependency"
        DefaultDependencyType="All"
        Context="1"
        PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
      >
        <PROPERTIES
          Context="1"
          PlatformGUID="{00000000-0000-0000-0000-000000000000}"
        >        </PROPERTIES>

        <DISPLAYNAME>Windows XP Embedded Language Core Group</DISPLAYNAME>

        <VERSION>1.0</VERSION>

        <DESCRIPTION>All components required to support languages on Windows XP Embedded.</DESCRIPTION>

        <COPYRIGHT>Microsoft (C) 2001</COPYRIGHT>

        <VENDOR>Microsoft</VENDOR>

        <OWNERS>SJang, JohnMcco</OWNERS>

        <AUTHORS>SJang, JohnMcco</AUTHORS>

        <DATECREATED>9/24/2001 9:51:43 PM</DATECREATED>

        <DATEREVISED>9/25/2001 6:27:56 AM</DATEREVISED>
      </GROUP>

      <GROUP
        GroupVSGUID="{B463E505-2792-45FA-9EF0-02D364AC234F}"
        Revision="2"
        GroupClass="Dependency"
        DefaultDependencyType="AtLeastOne"
        Context="1"
        PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
      >
        <PROPERTIES
          Context="1"
          PlatformGUID="{00000000-0000-0000-0000-000000000000}"
        >        </PROPERTIES>

        <DISPLAYNAME>Windows XP Embedded Extended Support Shared</DISPLAYNAME>

        <VERSION>1.0</VERSION>

        <DESCRIPTION>This dependency group contains optional extended support components that are common across all language support components. Any NLS components that are members of this group will appear in the same list as the predefined component dependencies.</DESCRIPTION>

        <COPYRIGHT>Microsoft (c) 2001</COPYRIGHT>

        <VENDOR>Microsoft</VENDOR>

        <OWNERS>SJang</OWNERS>

        <AUTHORS>SJang</AUTHORS>

        <DATECREATED>10/18/2001 8:40:11 PM</DATECREATED>

        <DATEREVISED>10/18/2001 8:46:17 PM</DATEREVISED>
      </GROUP>

      <GROUP
        GroupVSGUID="{9DA4F02A-E8A7-4BAC-AB1E-7C7E4CB62795}"
        Revision="3"
        GroupClass="Dependency"
        DefaultDependencyType="AtLeastOne"
        Context="1"
        PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
      >
        <PROPERTIES
          Context="1"
          PlatformGUID="{00000000-0000-0000-0000-000000000000}"
        >        </PROPERTIES>

        <DISPLAYNAME>Windows XP Embedded UI Languages</DISPLAYNAME>

        <VERSION>1.0</VERSION>

        <DESCRIPTION>All languages that can provide user interface resources. English language can always provide user interface resources.</DESCRIPTION>

        <COPYRIGHT>Microsoft (c) 2001</COPYRIGHT>

        <VENDOR>Microsoft</VENDOR>

        <OWNERS>SJang</OWNERS>

        <AUTHORS>SJang</AUTHORS>

        <DATECREATED>11/2/2001 5:16:19 PM</DATECREATED>

        <DATEREVISED>11/2/2001 5:19:07 PM</DATEREVISED>
      </GROUP>
    </GROUPS>

    <COMPONENTS
      Context="0"
      PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
    >
      <COMPONENT
        ComponentVSGUID="{F911162A-CF0C-4C14-92A9-0926741673FC}"
        ComponentVIGUID="{87899248-F1AA-4037-99A7-81B6DD1AFEB4}"
        Revision="700"
        RepositoryVSGUID="{8E0BE9ED-7649-47F3-810B-232D36C430B4}"
        Visibility="250"
        MultiInstance="True"
        Released="False"
        Editable="True"
        HTMLTitle="Language Support"
        HTMLFinal="False"
        IsMacro="False"
        Opaque="False"
        Context="1"
        PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
      >
        <SCRIPTTEXT
          language="VBScript"
          src=".\language_prototype.vbs"
          encoded="False"
        ><![CDATA['////////////////////////////////////////////////////////////////////////////
' $Header:$
' Windows Embedded Language Support Prototype
' Version: 1.00
' Author: sjang
' Copyright (c) 1999-2001 Microsoft Corp. All Rights Reserved.
'////////////////////////////////////////////////////////////////////////////

'**************************************************************************************************************************
' CONSTANTS AND GLOBAL VARIABLES
'**************************************************************************************************************************
Option Explicit
'
' VSGUID of Windows XP Embedded Language Support Group (dependency group)
' All instances of Language Support Components must belong to this group.
'
Public Const guidLangSupportGroup = "{A1A56917-46F2-492E-A544-C4EB1B95F61E}"
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

'
' Module Type Constants
'
Public Const cLangModuleTypeInvalid     = 0  ' indicates invalid value
Public Const cLangModuleTypeFont        = 1
Public Const cLangModuleTypeCodepage    = 2
Public Const cLangModuleTypeKeyboard    = 3
Public Const cLangModuleTypeMUIRes      = 4
Public Const cLangModuleTypeFeature     = 5
Public Const cLangModuleTypeUserLocale  = 6
Public Const cLangModuleTypeSystemLocale= 7
Public Const cLangMaxModuleType         = 7 ' the same as the last enum value above

'
' AccessDepState constants
' Used by AccessDepStates function.
'
Public Const cLangAccessDepStateInvalid    = 0  ' indicates invalid value 
Public Const cLangAccessDepStateGetCurrent = 1
Public Const cLangAccessDepStateSetDefault = 2
Public Const cLangAccessDepStateSetTrue    = 3
Public Const cLangAccessDepStateSetFalse   = 4

'
' Global variables used to access extended property prefixes
' names for each module type
'
Dim sPrefix : sPrefix = Array()
ReDim sPrefix(cLangMaxModuleType)
sPrefix(cLangModuleTypeInvalid)     = "cmiLangUndefined"
sPrefix(cLangModuleTypeFont)        = "cmiLangFont"
sPrefix(cLangModuleTypeCodepage)    = "cmiLangCp"
sPrefix(cLangModuleTypeKeyboard)    = "cmiLangKbd"
sPrefix(cLangModuleTypeMUIRes)      = "cmiLangMUIRes"
sPrefix(cLangModuleTypeFeature)     = "cmiLangFeature"
sPrefix(cLangModuleTypeSystemLocale)= "cmiLangSystemLocale"
sPrefix(cLangModuleTypeUserLocale)  = "cmiLangUserLocale"

'
' 0 based indices for creating unique property name.
' Incremented by 1 after each use.
' These are initialized and used on every activation.
'
Const cMaxPropIndex = 9999
Dim aIndex()
ReDim aIndex(cLangMaxModuleType)

'
' Global variables
'
Dim oPL : Set oPL = cmiThis.Configuration.Script.oPL

'
' The following objects are available for other script engines
' to interact with us.
'
Dim oLS : Set oLS = New LanguageSupportData  ' based on current instance
Dim oAL : Set oAL = New AvailableLocales     ' at configuration level

'**************************************************************************************************************************
' UTILITY FUNCTIONS
'**************************************************************************************************************************

'////////////////////////////////////////////////////////////////////////////
' vuQuickSort
' The standard quick sort algorithm. This code sorts any collection via the
' usual "swap" and "compare" user-supplied functions. As examples, vuDefComp
' and vuDefSwap (following) are provided for sorting arrays of variants, but
' any collection or partial collection can be sorted using this function.
'
' vData				Data item to pass to swap & compare functions
' nLeftIndex		Index of first item to sort (use LBound for all)
' nRightIndex		Index of last item to sort (use UBound for all)
' oCompFunc			User compare routine (via GetRef)
' oSwapFunc			User swap function (via GetRef)
'
'Sub vuQuickSort(ByRef vData, nLeftIndex, nRightIndex, oCompFunc, oSwapFunc)
'	Dim nPivot, ix
'	If nLeftIndex >= nRightIndex Then Exit Sub	' Recurse end test
'	nPivot = nLeftIndex							' Start pivot point
'	For ix = nLeftIndex + 1 To nRightIndex		' Scan array
'		If oCompFunc(vData, ix, nLeftIndex) < 0  Then	' If swap..
'			nPivot = nPivot + 1					' Make room in LHS
'			oSwapFunc vData, nPivot, ix			' Swap the data
'		End If
'	Next
'	oSwapFunc vData, nPivot, nLeftIndex			' Move pivot to final
'	vuQuickSort vData, nLeftIndex, nPivot - 1, oCompFunc, oSwapFunc
'	vuQuickSort vData, nPivot + 1, nRightIndex, oCompFunc, oSwapFunc
'End Sub
'

Function vuDefComp(ByRef vData, nLeft, nRight)
	Select Case VarType(vData(nLeft))
		Case vbString
			vuDefComp = StrComp(vData(nLeft), vData(nRight), vbTextCompare)
		Case Else
			vuDefComp = vData(nLeft) - vData(nRight)	' Subtract numbers etc
	End Select
End Function

Sub vuDefSwap(ByRef vData, nLeft, nRight)
	Dim vTemp
	If IsObject(vData(nLeft)) Then
		Set vTemp = vData(nLeft)				' Swap objects
		Set vData(nLeft) = vData(nRight)
		Set vData(nRight) = vTemp
	Else
		vTemp = vData(nLeft)					' Swap data
		vData(nLeft) = vData(nRight)
		vData(nRight) = vTemp
	End If
End Sub


'**************************************************************************************************************************
' CLASSES TO BE USED INTERNALLY AND EXTERNALLY
'**************************************************************************************************************************
'
' The following structures are used in our sorting tables
'
Class NameAndProp
   Public Name          ' name string for the entry
   Public PropName      ' associated instance extended property for the entry
End Class
'
' Compare name function used by vuQuickSort
' Applied to both NameAndProp and LocaleData
'
' vData     Data collection to sort
' nLeft		Left item index
' nRight		Right item index
' Returns	0 if equal, 1 if left > right, -1 if left < right
'
Function CompareName(ByRef vData, nLeft, nRight)	' Flipped for descending
	CompareName = StrComp(vData(nLeft).Name, vData(nRight).Name, vbTextCompare)
End Function

Class PropAndState
   Public PropName      ' extended property name
   Public State         ' true or false
End Class

Class LocaleData
   Public ModuleType          ' 6 = user locale, 7 = system locale
   Public Name                ' name string for the entry
   Public LocID               ' associated locale ID (integer) for the entry
   Public DefaultUserLocale   ' boolean
   Public DefaultSystemLocale ' boolean
   Public DefaultInputLocale  ' boolean
End Class

'////////////////////////////////////////////////////////////////////////////
' vuDDict class
' Double-dictionary class (dictionary of dictionaries)
'
' Reset				(M) Initialize or reinitialize dictionary
' LoadINI			(M) Load from INI file
' SaveINI			(M) Save to INI file
' Add				(M) Add a new item to the DDict
' AddArray			(M) Add array of keys/items by primary key
' AddArray2			(M) Add array of keys/items by secondary key
' Remove			(M) Remove an item from the DDict
' RemoveAll			(M) Remove all items by primary key
' RemoveAll2		(M) Remove all entries by secondary key
' Exists			(M) Check for existence of item in DDict
' Item				(M) Get/set/let item to/from dictionary
' Count				(P) Count of secondary keys by primary key (RO)
' CountAll			(P) Count of all items in DDict (RO)
' Keys				(M) Get all secondary keys by primary
' MultiKeys			(M) Get all secondary keys by primary array (once only)
' Items				(M) Get all secondary items by primary
' PrimaryExists		(M) Check if primary key exists
' PrimaryKeys		(M)	Get all primary keys
Class vuDDict
	Private m_oDict								' Primary dictionary
	
	'////////////////////////////////////////////////////////////////////////
	' Reset
	' Reset dictionary, removing all contents
	Public Sub Reset
		Set m_oDict = CreateObject("Scripting.Dictionary")
		m_oDict.CompareMode = vbTextCompare		' Ignore case of keys
	End Sub

	'////////////////////////////////////////////////////////////////////////
	' LoadINI and SaveINI
	' Save/load to/from INI/INF file as series of sections & name=value items
	'
	' oStr				Stream object from FSO for save/load operation
	Public Sub LoadINI(oStr)
		Dim sLine, oMatches, sSection
		Dim oREComm : Set oREComm = New RegExp	' Comment RE
		Dim oRESect : Set oRESect = New RegExp	' Section RE
		Dim oREItem : Set oREItem = New RegExp	' Item RE
		oREComm.IgnoreCase = True : oREComm.Pattern = "^\s*;.*$"
		oRESect.IgnoreCase = True : oRESect.Pattern = "^\s*\[(.+)\]\s*$"
		oREItem.IgnoreCase = True : oREItem.Pattern = "^\s*(\S+)\s*=(.*)$"
		sSection = ""							' No section yet
		Do Until oStr.AtEndOfStream
			sLine = Trim(oStr.ReadLine)			' Read next line
			If Not oREComm.Test(sLine) Then		' If not a comment..
				Set oMatches = oRESect.Execute(sLine)	' Match sections
				If oMatches.Count <> 0 Then		' If section match..
					sSection = Trim(oMatches(0).SubMatches(0))	' Get section name
				Else
					Set oMatches = oREItem.Execute(sLine)	' Match items
					If (oMatches.Count <> 0) And (sSection <> "") Then		' If item match..
						Add sSection, oMatches(0).SubMatches(0), Trim(oMatches(0).SubMatches(1))
					End If
				End If
			End If
		Loop		
	End Sub
	Public Sub SaveINI(oStr)
		Dim sPKey, sSKey, oDict
		For Each sPKey In m_oDict.Keys			' For each primary key..
			oStr.WriteLine "[" & sPKey & "]"	' Emit section header
			Set oDict = m_oDict(sPKey)			' Get secondary dictionary
			For Each sSKey In oDict.Keys		' For each secondary key..
				oStr.WriteLine sSKey & "=" & CStr(oDict(sSKey))	' Emit data
			Next
			oStr.WriteLine						' Emit separator line
		Next
	End Sub
	
	'////////////////////////////////////////////////////////////////////////
	' Add, AddArray & AddArray2
	' Add new item(s) to DDict
	'
	' sPKey				Primary key
	' sSKey				Secondary key
	' vItem				Data item to add to dictrionary
	' aSKeys			Array of secondary keys
	' aItems			Array of items (or Empty)
	Public Sub Add(sPKey, sSKey, vItem)
		If Not m_oDict.Exists(sPKey) Then		' If no primary key yet..
			m_oDict.Add sPKey, CreateObject("Scripting.Dictionary")
		End If
		m_oDict(sPKey).Add sSKey, vItem			' Go add the new item
	End Sub
	Public Sub AddArray(sPKey, aSKeys, aItems)
		Dim ix
		For ix = 0 To UBound(aSKeys)			' For each secondary..
			If Not IsEmpty(aItems) Then			' If some items..
				Add sPKey, aSKeys(ix), aItems(ix)	' Add the item
			Else
				Add sPKey, aSKeys(ix), Empty	' Add the empty item
			End If
		Next
	End Sub
	Public Sub AddArray2(sSKey, aPKeys, aItems)
		Dim ix
		For ix = 0 To UBound(aPKeys)			' For each primary..
			If Not IsEmpty(aItems) Then			' If some items..
				Add aPKeys(ix), sSKey, aItems(ix)	' Add the item
			Else
				Add aPKeys(ix), sSKey, Empty	' Add the item
			End If
		Next
	End Sub

	'////////////////////////////////////////////////////////////////////////
	' Remove, RemoveAll & RemoveAll2
	' Remove item from DDict
	'
	' sPKey				Primary key
	' sSKey				Secondary key
	Public Sub Remove(sPKey, sSKey)
		m_oDict(sPKey).Remove sSKey				' Go remove the item
		If m_oDict(sPKey).Count = 0 Then		' If secondary is empty..
			m_oDict.Remove sPKey				' ..also remove primary
		End If
	End Sub
	Public Sub RemoveAll(sPKey)
		m_oDict.Remove sPKey					' Remove entire primary
	End Sub
	Public Sub RemoveAll2(sSKey)
		Dim sPKey
		For Each sPKey In m_oDict.Keys			' For each primary
			If m_oDict(sPKey).Exists(sSKey) Then	' If found..
				Remove sPKey, sSKey				' Remove the item
			End If
		Next
	End Sub
	
	'////////////////////////////////////////////////////////////////////////
	' Exists
	' Check to see if item exists in DDict
	'
	' sPKey				Primary key
	' sSKey				Secondary key
	' Returns			True if (PKey,SKey) pair exists
	Public Function Exists(sPKey, sSKey)
		Exists = False							' Assume not found
		If m_oDict.Exists(sPKey) Then			' If primary found..
			Exists = m_oDict(sPKey).Exists(sSKey)	' Check existence
		End If
	End Function
	
	'////////////////////////////////////////////////////////////////////////
	' Item (RW, default)
	' Get/set/let item
	'
	' sPKey				Primary key
	' sSKey				Secondary key
	' Returns			Item value
	Public Default Property Get Item(sPKey, sSKey)
		Dim CurrValue
		vuSuperAssign CurrValue, m_oDict(sPKey).Item(sSKey)
		If IsObject(CurrValue) Then	Set Item = CurrValue Else Item = CurrValue
	End Property
	Public Property Let Item(sPKey, sSKey, vValue)
		m_oDict(sPKey).Item(sSKey) = vValue		' Set new value
	End Property
	Public Property Set Item(sPKey, sSKey, vValue)
		Set m_oDict(sPKey).Item(sSKey) = vValue	' Set new value
	End Property

	'////////////////////////////////////////////////////////////////////////
	' Count & CountAll properties (RO)
	' Count of items by primary key, or all items in DDict
	'
	' sPKey				Primary key
	' Returns			Count of items in the DDict
	Public Property Get Count(sPKey)
		Count = m_oDict(sPKey).Count			' Get count by primary
	End Property
	Public Property Get CountAll
		Dim nCount : nCount = 0
		Dim oDict
		For Each oDict In m_oDict.Items			' For each dictionary..
			nCount = nCount + oDict.Count		' Add item count
		Next
		CountAll = nCount						' Return result
	End Property
	
	'////////////////////////////////////////////////////////////////////////
	' Keys & Items
	' Get secondary keys and items based on primary key
	'
	' sPKey				Primary key
	' Returns			Array of keys or items
	Public Function Keys(sPKey)
		Keys = m_oDict(sPKey).Keys				' Get the secondary keys
	End Function
	Public Function Items(sPKey)
		Items = m_oDict(sPKey).Items			' Get the secondary items
	End Function
	
	'////////////////////////////////////////////////////////////////////////
	' MultiKeys
	' Get secondary keys by array of primary keys (no duplicates in result)
	'
	' sPKeys			Primary key array
	' Returns			Array of keys
	Public Function MultiKeys(aPKeys)
		Dim oDict : Set oDict = CreateObject("Scripting.Dictionary")
		oDict.CompareMode = vbTextCompare
		Dim sPKey, sSKey
		For Each sPKey In aPKeys				' For each primary key..
			If m_oDict.Exists(sPKey) Then		' If found..
				For Each sSKey In m_oDict(sPKey).Keys	' For each key..
					If Not oDict.Exists(sSKey) Then
						oDict.Add sSKey, Empty	' Add unique secondary key
					End If
				Next
			End If
		Next	
		MultiKeys = oDict.Keys					' Get unique keylist
	End Function	
	
	'////////////////////////////////////////////////////////////////////////
	' PrimaryExists
	' Check primary key status
	'
	' sPKey				Primary key
	' Returns			True if primary key exists
	Public Function PrimaryExists(sPKey)
		PrimaryExists = m_oDict.Exists(sPKey)	' Check for key exists
	End Function
	
	'////////////////////////////////////////////////////////////////////////
	' PrimaryKeys
	' Get all primary keys in DDict
	'
	' Returns			Array of primary keys
	Public Function PrimaryKeys
		PrimaryKeys = m_oDict.Keys				' Get all primary keys
	End Function
End Class


'***************************************************************************************
' LanguageSupportData
'
' An object of this class is used internally and externally to retrieve data about
' a language support component instance. It also contains a set of utility functions
' that can be called regardless of instance data.
'
' [Variables]
' These variables are valid only after InitData(oInst) is called (InitData is called
' as part of instance activation, so these variables are always valid for active
' instances):
'
' bInitialized          - indicates that the rest of the public variables are usable
' nLangId               - language ID (integer)
' sLangName             - language name (string)
' aFonts                - a sorted array of supported fonts (NameAndProp objects)
' aCodepages            - a sorted array of supported codepages (NameAndProp objects)
' aKeyboards            - a sorted array of supported keyboard layouts (NameAndProp objects)
' aUserLocales          - an unsorted array of supported user locales (LocaleData objects)
' aSystemLocales        - an unsorted array of supported system locales (LocaleData objects)
' nDefaultUserLocale    - Locale ID for the default user locale for this language
' nDefaultInputLocale   - Locale ID for the default input locale for this language
' nDefaultSystemLocale  - Locale ID for the default system locale for this language
' guidMuiComponent      - the MUI resource component VIGUID for this language
'                        (empty if there is no MUI resource for this language)
'
' [Methods]
' The following methods are pure utility functions that can be called before calling
' InitData of this class:
'
' GetLocaleData         - Get locale data from a locale component (LocaleData object)
' LangPropToModuleType  - Convert a property name in to a module type integer
' PropToDep             - Find a dependency object activated by a given property name
' IsValidLangProp       - Check if a given property is in valid format and range
' MakeMsg               - Make a string to display in oPL.ReportError or oPL.ReportWarning
' GetProp               - Get an extended property object from an owner by the prop name
' IsMuiEnabled          - Return if MUI resource dependency is enabled for this language
' RemoveProp            - Remove an extended property from an owner by the prop name
' SetLangSupportChanged - Indicate that language support was changed on the configuration
' GetLangSupportChanged - Check if language support was changed
' ResetLangSupportChanged - Reset the changed bit for language support
' SetConfigDefaultLocales - Based on the current language, adjust default locale settings
' ClearConfigDefaultLocales - Clear all default locale settings
' ResetConfigDefaultLocales - Adjust default locale settings after the current language
'                             is removed
'
' InitData              - Initialize all public member variables
' AccessDepStates       - Get or change the NLS component dependency states (called by DHTML)
'                         (this can be called only after InitData happens)
'
' NOTE: Do not use "Dim arr()" style declaration.
'       Use arr = Array() instead, which will set the UBound to -1, and not generate
'       an exception when used with UBound.
'
Class LanguageSupportData

   Public bInitialized  ' indicates that the rest of the public variables are initialized
   Public nLangId
   Public sLangName
   Public aFonts
   Public aCodepages
   Public aKeyboards
   Public aSystemLocales
   Public aUserLocales
   Public nDefaultUserLocale
   Public nDefaultInputLocale
   Public nDefaultSystemLocale
   Public guidMuiComponent
   
   Private m_oInst
   Private m_oDictPropToDep
   
   '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ' PUBLIC METHODS
   '///////////////////////////////////////////////////////////////////////////////////////////////////////////////

   '////////////////////////////////////////////////////////////////////////////
   ' InitData(oInst)
   ' Initialize LanguageSupportData object by traversing various extended properties
   ' and other properties of the given instance.
   '
   Public Sub InitData(oInst)
      Dim oDep
      Dim oProp
      '
      ' Record instance info
      '
      Set m_oInst = oInst
      Set oProp = GetProp(oInst, "cmiLangId")
      If IsValidLangProp(oInst, oProp) Then
         nLangId = oProp.Value
      Else
         Err.Raise errLangInvalidComponentData, "InitData", _
                   oInst.DisplayName & " does not contain valid cmiLangId property."
      End If
      Set oProp = GetProp(oInst, "cmiLangName")
      If IsValidLangProp(oInst, oProp) Then
         sLangName = oProp.Value
      Else
         Err.Raise errLangInvalidComponentData, "InitData", _
                   oInst.DisplayName & " does not contain valid cmiLangName property."
      End If
      '
      ' Reset indices to be used in arrays we are constructing.
      '
      aIndex(cLangModuleTypeFont)         = 0
      aIndex(cLangModuleTypeCodepage)     = 0
      aIndex(cLangModuleTypeKeyboard)     = 0
      aIndex(cLangModuleTypeSystemLocale) = 0
      aIndex(cLangModuleTypeUserLocale)   = 0
      aFonts = Array()
      aCodepages = Array()
      aKeyboards = Array()
      aSystemLocales = Array()
      aUserLocales = Array()
      Set m_oDictPropToDep = CreateObject("Scripting.Dictionary")
      '
      ' Enumerate all dependency objects, and handle each of them.
      '
   	For each oDep In oInst.Dependencies
   	   If IsNlsCompDependency(oDep) Then
	         ProcessNlsCompDependency oDep
         ElseIf IsMuiResDependency(oDep) Then
  	         ProcessMuiResDependency oDep
         ElseIf IsLocaleCompDependency(oDep) Then
  	         ProcessLocaleCompDependency oDep.TargetGUID
         ElseIf IsLocaleGroupDependency(oDep) Then
  	         ProcessLocaleGroupDependency oDep.TargetGUID
  	      End If
      Next
   	'
	   ' Sort each array we built.
	   ' We don't need to sort locales, since they get sorted by oAL.
	   '
      vuQuickSort aFonts, LBound(aFonts), UBound(aFonts), GetRef("CompareName"), GetRef("vuDefSwap")
      vuQuickSort aCodepages, LBound(aCodepages), UBound(aCodepages), GetRef("CompareName"), GetRef("vuDefSwap")
      vuQuickSort aKeyboards, LBound(aKeyboards), UBound(aKeyboards), GetRef("CompareName"), GetRef("vuDefSwap")
	   bInitialized = True
   End Sub

   '////////////////////////////////////////////////////////////////////////////
   ' GetLocaleData
   '
   ' Given a component VIGUID or VSGUID, return a new LocaleData object based on
   ' its extended properties data:
   '     cmiLangModuleType [Integer]   6 if user locale, 7 if system locale
   '     cmiLangLocaleName [String]
   '     cmiLangLocaleId [Integer]
   '     cmiLangDefaultUserLocale [Boolean]
   '     cmiLangDefaultSystemLocale [Boolean]
   '     cmiLangDefaultInputLocale [Boolean]
   ' Returns Nothing, if the GUID is invalid.
   '
   Public Function GetLocaleData(guidComp)
      Dim oComp
      Dim oProp
      On Error Resume Next
      Set oComp = Nothing
      Set oComp = oPL.CreateFromLAB(cmiComponent, cmiFTGetByObjGUID, guidComp)
      On Error Goto 0
      If oComp Is Nothing Then
         GetLocaleData = Nothing
      Else
         Set GetLocaleData = New LocaleData
         Set oProp = GetProp(oComp, "cmiLangModuleType")
         If IsValidLangProp(oComp, oProp) Then
            GetLocaleData.ModuleType = oProp.Value
         Else
            Err.Raise errLangInvalidComponentData, "GetLocaleData", _
                      oComp.DisplayName & " does not contain valid cmiLangModuleType property."
         End If
         Set oProp = GetProp(oComp, "cmiLangLocaleName")
         If IsValidLangProp(oComp, oProp) Then
            GetLocaleData.Name = oProp.Value
         Else
            GetLocaleData.Name = oComp.DisplayName
         End If
         Set oProp = GetProp(oComp, "cmiLangLocaleId")
         If IsValidLangProp(oComp, oProp) Then
            GetLocaleData.LocID = oProp.Value
         Else
            Err.Raise errLangInvalidComponentData, "GetLocaleData", _
                      oComp.DisplayName & " does not contain valid cmiLangLocaleId property."
         End If
         Set oProp = GetProp(oComp, "cmiLangDefaultUserLocale")
         If IsValidLangProp(oComp, oProp) Then
            GetLocaleData.DefaultUserLocale = oProp.Value
         Else
            GetLocaleData.DefaultUserLocale = False
         End If
         Set oProp = GetProp(oComp, "cmiLangDefaultSystemLocale")
         If IsValidLangProp(oComp, oProp) Then
            GetLocaleData.DefaultSystemLocale = oProp.Value
         Else
            GetLocaleData.DefaultSystemLocale = False
         End If
         Set oProp = GetProp(oComp, "cmiLangDefaultInputLocale")
         If IsValidLangProp(oComp, oProp) Then
            GetLocaleData.DefaultInputLocale = oProp.Value
         Else
            GetLocaleData.DefaultInputLocale = False
         End If
      End If
   End Function

   '////////////////////////////////////////////////////////////////////////////
   ' LangPropToModuleType
   '
   ' Converts a lang prop name to a module type constant.
   ' Returns cLangModuleTypeInvalid if the property name does not map to any
   ' extended property names we create for dependency-related ext. properties.
   '
   Public Function LangPropToModuleType(sPropName)
      Dim i
      LangPropToModuleType = cLangModuleTypeInvalid
      For i = cLangModuleTypeFont to cLangModuleTypeUserLocale
         If InStr(sPropName, sPrefix(i)) = 1 Then
            LangPropToModuleType = i
            Exit Function
         End If
      Next
   End Function

   '////////////////////////////////////////////////////////////////////////////
   ' PropToDep
   ' Given a property name, return a dependency object that corresponds to
   ' that property. Returns Empty if no match.
   '
   ' sPropName = extended property name (such as "cmiLangFont0005")
   '
   Function PropToDep(sPropName)
      If m_oDictPropToDep.Exists(sPropName) Then
         Set PropToDep = m_oDictPropToDep.Item(sPropName)
      End If
   End Function

   '////////////////////////////////////////////////////////////////////////////
   ' IsValidLangProp
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
   ' cmiLangModuleType              (integer)   0 - 7 (0 = valid but reserved value)
   ' cmiLangRequired                (boolean)   True or False
   ' cmiLangId                      (integer)   non-zero
   ' cmiLangName                    (string)    non-empty
   ' cmiLangExtendedSupport         (guid)      a valid guid (assumed)
   ' cmiLangExtendedSupportShared   (guid)      a valid guid (assumed)
   ' cmiLangLocaleId                (integer)   non-zero
   ' cmiLangLocaleName              (string)    non-empty
   ' cmiLangLocaleType              (integer)   1 or 2
   ' cmiLangDefaultInputLocale      (boolean)   True or False
   ' cmiLangDefaultUserLocale       (boolean)   True or False
   ' cmiLangDefaultSystemLocale     (boolean)   True or False
   ' cmiLangEnableMui               (boolean)   True or False
   ' cmiLangLocaleGroup             (boolean)   True or False
   ' cmiLangDependOnSystemLocale    (boolean)   True or False
   ' cmiLangMuiOwner                (guid)      a valid guid (assumed)
   ' 
   ' The following extended properties will be validated separately
   ' cmiLangGeoLocation[nnnn]    (string)    non-empty;<GEOID in decimal>
   '
   Public Function IsValidLangProp(oOwner, oProp)

      IsValidLangProp = True
      
      If oProp Is Nothing Then
         IsValidLangProp = False
         Exit Function
      End If
      
      Select Case LCase(oProp.Name)
         Case LCase("cmiLangModuleType")
            If (oProp.Format <> cmiInteger) Or _
               (oProp.Value > cLangMaxModuleType) or _
               (oProp.Value < cLangModuleTypeInvalid) Then IsValidLangProp = False
         Case LCase("cmiLangRequired")
            If (oProp.Format <> cmiBoolean) Then IsValidLangProp = False
         Case LCase("cmiLangId")
            If (oProp.Format <> cmiInteger) Or (oProp.Value = 0) Then IsValidLangProp = False
         Case LCase("cmiLangName")
            If (oProp.Format <> cmiString) Or (Trim(oProp.Value) = "") Then IsValidLangProp = False
         Case LCase("cmiLangExtendedSupport")
            If (oProp.Format <> cmiGuid) Then IsValidLangProp = False
         Case LCase("cmiLangExtendedSupportShared")
            If (oProp.Format <> cmiGuid) Then IsValidLangProp = False
         Case LCase("cmiLangLocaleId")
            If (oProp.Format <> cmiInteger) Or (oProp.Value = 0) Then IsValidLangProp = False
         Case LCase("cmiLangLocaleName")
            If (oProp.Format <> cmiString) Or (Trim(oProp.Value) = "") Then IsValidLangProp = False
         Case LCase("cmiLangDefaultInputLocale")
            If (oProp.Format <> cmiBoolean) Then IsValidLangProp = False
         Case LCase("cmiLangDefaultUserLocale")
            If (oProp.Format <> cmiBoolean) Then IsValidLangProp = False
         Case LCase("cmiLangDefaultSystemLocale")
            If (oProp.Format <> cmiBoolean) Then IsValidLangProp = False
         Case LCase("cmiLangEnableMui")
            If (oProp.Format <> cmiBoolean) Then IsValidLangProp = False
         Case LCase("cmiLangLocaleGroup")
            If (oProp.Format <> cmiBoolean) Then IsValidLangProp = False
         Case LCase("cmiLangMuiOwner")
            If (oProp.Format <> cmiGuid) Then IsValidLangProp = False
         Case LCase("cmiLangMuiCustomGroup")
            If (oProp.Format <> cmiGuid) Then IsValidLangProp = False
         Case LCase("cmiLangDependOnSystemLocale")
            If (oProp.Format <> cmiBoolean) Then IsValidLangProp = False
         Case Else
               IsValidLangProp = True     ' If not in our list to check, pass the check
      End Select

      If Not IsValidLangProp Then
         ' Error is raised by the caller as appropriate
         oPL.ReportWarning errLangInvalidComponentData, "IsValidLangProp", _
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
   ' RemoveProp
   ' Remove a property of a given name from the owner, if exists.
   ' oOwner    - object to remove extended property from
   ' sName     - name of the extended property to remove
   '
   Public Sub RemoveProp(oOwner,sName)
      On Error Resume Next
      Dim oProps
      Set oProps = oOwner.Properties
      On Error Goto 0
      If Err.Number <> 0 Then
         Err.Raise errLangInvalidComponentData, "GetProp", _
                   MakeMsg(oOwner," does not have property collection.")
         Exit Sub
      End If
      If oProps.Exists(sName) Then
         oProps.Remove sName
      End If
   End Sub

   '////////////////////////////////////////////////////////////////////////////
   ' IsMuiEnabled
   ' Returns true if this language support component has cmiLangEnableMUI
   ' extended property set to true.
   '
   Public Function IsMuiEnabled(oInst)
      Dim oProp
      IsMuiEnabled = False
      Set oProp = GetProp(oInst, "cmiLangEnableMui")
      If Not oProp Is Nothing Then IsMuiEnabled = oProp.Value
   End Function

   '////////////////////////////////////////////////////////////////////////////
   ' AccessDepStates
   '
   ' Accesses the dependency-related extended properties, such as cmiLangFont[n]
   ' according to the nOp specified.
   '
   ' Returns an array of PropAndState objects that contain property name and
   '         the latest boolean value. (used by our DHTML)
   ' Returns Empty if no operation was performed (due to invalid arg, etc.)
   '
   ' nOp          cLangAccessDepStateGetCurrent
   '                 -just retrieve the current values
   '              cLangAccessDepStateSetTrue
   '                 - sets the values of all ext. properties in the list to true
   '              cLangAccessDepStateSetFalse
   '                 - sets the values of all ext. properties in the list to true
   '              cLangAccessDepStateSetDefault
   '                 - change the property values to the default values recorded
   '                   in each corresponding dependency object. (cmiLangRequired)
   '                   Return the default values (from dependency object).
   ' oInst        the instance that contains the extended properties
   ' aNameProp    An array containing valid NameAndProp objects
   '              Dependency property access is performed on this array
   '
   ' The caller can access the actual dependency linked to a particular extended
   ' property by using oDicPropToDep dictionary object.
   '
   Public Function AccessDepStates(nOp, aNameProp)
      Dim oProp
      Dim aResult
      '
      ' If non-array aNameProp or invalid nOp we bail with Empty value
      '
      AccessDepStates = aResult
      If Not IsArray(aNameProp) or (nOp < 1) or (nOp > 4) Then
            Exit Function
      End If
      '
      ' Create an array PropAndState objects
      '
      Dim i
      Dim upper : upper = UBound(aNameProp)
      ReDim aResult(upper)
      For i = 0 to upper
         Set aResult(i) = New PropAndState
         aResult(i).PropName = aNameProp(i).PropName
         aResult(i).State = False       ' initialize it with false
      Next
      '
      ' Perform access operations
      '
      Select Case nOp
      Case cLangAccessDepStateSetTrue
         ' Set all properties to true
         ' record true for all returned array entries
         For i = 0 to upper
            aResult(i).State = True
            Set oProp = GetProp(m_oInst,aResult(i).PropName)
            If Not oProp Is Nothing Then oProp.Value = True
         Next
      Case cLangAccessDepStateSetFalse
         ' Set all properties to false
         ' record false for all returned array entries
         For i = 0 to upper
            aResult(i).State = False
            Set oProp = GetProp(m_oInst,aResult(i).PropName)
            If Not oProp Is Nothing Then oProp.Value = False
         Next
      Case cLangAccessDepStateGetCurrent
         ' Get the curernt values, and that's it
         For i = 0 to upper
            Set oProp = GetProp(m_oInst,aResult(i).PropName)
            If Not oProp Is Nothing Then aResult(i).State = oProp.Value
         Next
      Case cLangAccessDepStateSetDefault
         ' Get the default value, and set that as the value of properties
         ' Record the default values in the returned array
         Dim oDep
         Dim oDepProp
         For i = 0 to upper
            ' First Set the return values'
            ' To do: change this to just access member variables later
            '        (by changing NameAndProp)
            Set oDep = PropToDep(aResult(i).PropName)
            Set oDepProp = GetProp(oDep, "cmiLangRequired")
            If IsValidLangProp(oDep, oDepProp) Then aResult(i).State = oDepProp.Value
            ' Also reset the actual component property value back to default value
            Set oProp = GetProp(m_oInst,aResult(i).PropName)
            If Not oProp Is Nothing Then oProp.Value = aResult(i).State
         Next
      End Select
      AccessDepStates = aResult
   End Function

   '////////////////////////////////////////////////////////////////////////////
   ' SetLangSupportChanged
   ' Add or change a configuration property to indicate that a language support
   ' component was added or removed from the active configuration.
   '
   ' oConfig = the current configuration
   '
   Public Sub SetLangSupportChanged(oConfig)
      Dim oProp
      Set oProp = GetProp( oConfig, "cmiLangChanged" )
      If oProp Is Nothing Then
         Set oProp = oPL.CreateProp("cmiLangChanged", cmiBoolean, True)
         oConfig.Properties.Add oProp
      End If
      oProp.Value = True
   End Sub

   '////////////////////////////////////////////////////////////////////////////
   ' ResetLangSupportChanged
   ' Change a configuration property to indicate the last change in language
   ' support component was processed by the language settings component.
   '
   ' oConfig = the current configuration
   '
   Public Sub ResetLangSupportChanged(oConfig)
      Dim oProp
      Set oProp = GetProp( oConfig, "cmiLangChanged" )
      If Not oProp Is Nothing Then
         oProp.Value = False
      End If
   End Sub

   '////////////////////////////////////////////////////////////////////////////
   ' GetLangSupportChanged
   ' Return true if a language support component was added or removed. Return
   ' false otherwise.
   '
   Public Function GetLangSupportChanged(oConfig)
      Dim oProp
      Set oProp = GetProp( oConfig, "cmiLangChanged" )
      If oProp Is Nothing Then
         GetLangSupportChanged = False
      Else
         GetLangSupportChanged = oProp.Value
      End If
   End Function

   '////////////////////////////////////////////////////////////////////////////
   ' SetConfigDefaultLocales
   ' Based on the current language support instance, set the default locale
   ' settings of the configuration. If there are existing settings, do not
   ' change them.
   '
   ' oInst  - Language Support instance object (not necessarily m_oInst)
   '
   Public Sub SetConfigDefaultLocales(oInst)
      Dim oConfig : Set oConfig = oInst.Configuration
      Dim oILS : Set oILS = oInst.Script.oLS ' get lang support data for the instance
      Dim oConfigProp
      Dim oInstTemp
      Dim oInstProp
      '
      ' If we are adding the instance, we need to try to set the default locale
      ' properties of the configuration with the default locale settings of the
      ' instance.
      '
      Set oConfigProp = GetProp( oConfig, "cmiLangDefaultUILanguage" )
      If oConfigProp Is Nothing Then
         Set oConfigProp = oPL.CreateProp("cmiLangDefaultUILanguage", _
                                           cmiInteger, oILS.nLangId)
         oConfig.Properties.Add oConfigProp
      End If
         
      Set oConfigProp = GetProp( oConfig, "cmiLangDefaultUserLocale" )
      If oConfigProp Is Nothing Then
         Set oConfigProp = oPL.CreateProp("cmiLangDefaultUserLocale", _
                                           cmiInteger, oILS.nDefaultUserLocale)
         oConfig.Properties.Add oConfigProp
      End If
       
      Set oConfigProp = GetProp( oConfig, "cmiLangDefaultInputLocale" )
      If oConfigProp Is Nothing Then
         Set oConfigProp = oPL.CreateProp("cmiLangDefaultInputLocale", _
                                           cmiInteger, oILS.nDefaultInputLocale)
         oConfig.Properties.Add oConfigProp
      End If

      Set oConfigProp = GetProp( oConfig, "cmiLangDefaultSystemLocale" )
      If oConfigProp Is Nothing Then
         Set oConfigProp = oPL.CreateProp("cmiLangDefaultSystemLocale", _
                                           cmiInteger, oILS.nDefaultSystemLocale)
         oConfig.Properties.Add oConfigProp
      End If
   End Sub

   '////////////////////////////////////////////////////////////////////////////
   ' ResetConfigDefaultLocales
   ' After the current instance is removed from a configuration, reset the
   ' locale settings of the current configuration, based on any remaining language
   ' support component instances. (the current instance = m_oInst)
   '
   Public Sub ResetConfigDefaultLocales(oConfig)
      Dim oProp
      Dim aLSGuids
      '
      ' Reconstruct available locale list and remove all entries related to
      ' the current instance (as the instance is going away)
      '
      oAL.Construct(oConfig)
      oAL.RemoveLanguage(m_oInst.VSGUID)
      '
      ' If no more language support is present, clear all settings and
      ' exit.
      '
      aLSGuids = oAL.AvailableLanguages      ' Get an array of instance VSGUID
      If UBound(aLSGuids) = -1 Then          ' If empty
         ClearConfigDefaultLocales oConfig
         Exit Sub
      End If
      '
      ' If there is at least one remaining language support, clear
      ' only the settings that had belonged to us. But we are gone now...
      '
      Set oProp = GetProp(oConfig,"cmiLangDefaultUILanguage")
      If Not oProp Is Nothing Then
         If oProp.Value = nLangId Then
            '
            ' Check if there is another language support instance
            ' that supports the same language. (in practice, this
            ' will never happen)
            '
            Dim guidTemp : guidTemp = oAL.LangIdToGuid(nLangId)
            If IsEmpty(guidTemp) Then
               RemoveProp oConfig,"cmiLangDefaultUILanguage"
               RemoveProp oConfig,"cmiLangDefaultSystemLocale"
            End If
         End If
      End If
      Set oProp = GetProp(oConfig,"cmiLangDefaultUserLocale")
      If Not oProp Is Nothing Then
         If Not oAL.IsAvailableAsUL(oProp.Value) Then
            RemoveProp oConfig, "cmiLangDefaultUserLocale"
         End If
      End If
      Set oProp = GetProp(oConfig,"cmiLangDefaultInputLocale")
      If Not oProp Is Nothing Then
         If Not oAL.IsAvailableAsUL(oProp.Value) Then
            RemoveProp oConfig, "cmiLangDefaultInputLocale"
         End If
      End If
      Set oProp = GetProp(oConfig,"cmiLangDefaultSystemLocale")
      If Not oProp Is Nothing Then
         If Not oAL.IsAvailableAsSL(oProp.Value) Then
            RemoveProp oConfig, "cmiLangDefaultSystemLocale"
         End If
      End If
      '
      ' Now that we got rid of the stale settings, adjust the settings
      ' again with a fresh active instance. Take the first guy in line.
      ' (we already checked to make sure there is one)
      '
      SetConfigDefaultLocales oConfig.Instances.Item(aLSGuids(0))
      '
      ' No need to keep this object around, since we have to
      ' recreate it every time we use it.
      '
      oAL.Destroy
   End Sub

   '////////////////////////////////////////////////////////////////////////////
   ' ClearConfigDefaultLocales
   ' After a language support instance is removed from a configuration,
   ' reset the locale settings of the current configuration, based on any
   ' remaining language support component instances.
   '
   Public Sub ClearConfigDefaultLocales(oConfig)
      RemoveProp oConfig,"cmiLangDefaultUILanguage"
      RemoveProp oConfig,"cmiLangDefaultUserLocale"
      RemoveProp oConfig,"cmiLangDefaultInputLocale"
      RemoveProp oConfig,"cmiLangDefaultSystemLocale"
   End Sub

   '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ' PRIVATE SUBROUTINES
   '///////////////////////////////////////////////////////////////////////////////////////////////////////////////

   '////////////////////////////////////////////////////////////////////////////
   ' ProcessNlsCompDependency
   ' Based on the properties of the dependency, construct NLS component arrays.
   ' Assume oDep is a valid NLS component dependency.
   '
   Private Sub ProcessNlsCompDependency(oDep)
      Dim oProp
      Dim nType
      Dim nTblIndex        ' Current index into aFonts or aCodepages or aKeyboards sorting table
      Dim oTblEntry        ' NameAndProp object to insert into the appropriate sorting table
      '
      ' Create an entry to add to sorting table
      '
      Set oProp = GetProp(oDep, "cmiLangModuleType")
      nType = oProp.Value
      nTblIndex = aIndex(nType)
      Set oTblEntry = New NameAndProp
      Set oProp = GetProp(oDep, "cmiLangInputProp")
      oTblEntry.PropName = oProp.Value
      oTblEntry.Name = Trim(oDep.DisplayName)
      If oTblEntry.Name = "" Then               ' get the name from the target component
         On Error Resume Next
         Dim oTargComp : Set oTargComp = Nothing
         Set oTargComp = oPL.CreateFromLAB(cmiComponent, cmiFTGetByObjGUID, oDep.TargetGUID)
         On Error Goto 0
         If oTargComp Is Nothing Then
            oPL.ReportError errLangDepTargetNotFound, "HandleNlsCompDependency",_
                            MakeMsg( oDep, "Dependency target not found.")
            oTblEntry.Name = "(no name)"
         Else
            oTblEntry.Name = oTargComp.DisplayName
         End If
      End If
      '
      ' Now add this entry to the appropriate sorting table
      ' (create arrays here too)
      '
      Select Case nType
      Case cLangModuleTypeFont
         If Not IsArray(aFonts) Then aFonts = Array()
         ReDim Preserve aFonts(nTblIndex)
         Set aFonts(nTblIndex) = oTblEntry
      Case cLangModuleTypeCodepage
         If Not IsArray(aCodepages) Then aCodepages = Array()
         ReDim Preserve aCodepages(nTblIndex)
         Set aCodepages(nTblIndex) = oTblEntry
      Case cLangModuleTypeKeyboard
         If Not IsArray(aKeyboards) Then aKeyboards = Array()
         ReDim Preserve aKeyboards(nTblIndex)
         Set aKeyboards(nTblIndex) = oTblEntry
      End Select
      aIndex(nType) = aIndex(nType) + 1

      ' Also, prepare oDictPropToDep
      m_oDictPropToDep.Add oTblEntry.PropName, oDep   ' cache the relationship
   End Sub

   '////////////////////////////////////////////////////////////////////////////
   ' ProcessMuiResDependency
   ' Set guidMuiComponent member variable. This variable is used by our DHTML.
   '
   ' This sub assumes that oDep was evaluated true using IsMuiResDependency.
   ' This happens on every activation of an instance.
   '
   Private Sub ProcessMuiResDependency(oDep)
      guidMuiComponent = oDep.TargetGUID  ' set global variable
   End Sub
   
   '////////////////////////////////////////////////////////////////////////////
   ' ProcessLocaleCompDependency
   ' Get locale data from a component specified by guidComp, and put the data
   ' in a array which will later be picked up by the language settings component.
   ' Find out what locales were intended to be the default locale settings for
   ' this language (well, there has to be one default at least...) and set the
   ' following member variables:
   ' nDefaultUserLocale     ' Locale ID for the standarads and formats settings
   ' nDefaultInputLocale    ' Locale ID for input method and keyboard layout
   ' nDefaultSystemLocale   ' Locale ID to determine code page settings
   '
   Private Sub ProcessLocaleCompDependency(guidComp)
      Dim oTblEntry
      Dim nTblIndex
      Dim nType
      '
      ' Get locale data from the component
      '
      Set oTblEntry = GetLocaleData(guidComp)
      If oTblEntry Is Nothing Or _
         IsEmpty(oTblEntry.ModuleType) Or _
         IsEmpty(oTblEntry.Name) Or _
         IsEmpty(oTblEntry.LocID) Then
         Exit Sub ' do nothing if the data is invalid
      End If
      '
      ' Put locale data into the array
      '
      nType = oTblEntry.ModuleType
      nTblIndex = aIndex(nType)
      Select Case nType
         Case cLangModuleTypeUserLocale
   	      If Not IsArray(aUserLocales) Then aUserLocales = Array()
   	      ReDim Preserve aUserLocales(nTblIndex)
   	      Set aUserLocales(nTblIndex) = oTblEntry
         Case cLangModuleTypeSystemLocale
   	      If Not IsArray(aSystemLocales) Then aSystemLocales = Array()
   	      ReDim Preserve aSystemLocales(nTblIndex)
   	      Set aSystemLocales(nTblIndex) = oTblEntry
   	   Case Else
   	      Exit Sub
      End Select
      aIndex(nType) = aIndex(nType) + 1
      '
      ' Also set the default locale ID if this happens to be
      ' the default one. Last man in wins.
      '
      If (oTblEntry.ModuleType = cLangModuleTypeUserLocale) Then
         If IsEmpty(nDefaultUserLocale) or oTblEntry.DefaultUserLocale Then
            nDefaultUserLocale = oTblEntry.LocID
         End If
         If IsEmpty(nDefaultInputLocale) or oTblEntry.DefaultInputLocale Then
            nDefaultInputLocale = oTblEntry.LocID
         End If
      End If
      If (oTblEntry.ModuleType = cLangModuleTypeSystemLocale) Then
         If IsEmpty(nDefaultSystemLocale) or oTblEntry.DefaultSystemLocale Then
            nDefaultSystemLocale = oTblEntry.LocID
         End If
      End If
      
   End Sub

   '////////////////////////////////////////////////////////////////////////////
   ' ProcessLocaleGroupDependency
   '
   ' Examine all user and system locales that belong to this particular dependency
   ' group. (Assume everything in this group to be valid locale components)
   '
   Private Sub ProcessLocaleGroupDependency(guidGroup)
      Dim oLocales
      Dim oLocale
      On Error Resume Next
      Set oLocales = Nothing   ' in case we fail
   	Set oLocales = oPL.CreateFromDB(cmiComponents, _
   					                    cmiFTGetGroupMembers Or cmiFTNoAttachments, _
   					                    guidGroup)
      On Error Goto 0
      '
      ' Loop through each entry in this group
      '
      If Not oLocales Is Nothing Then
         For Each oLocale In oLocales
            ProcessLocaleCompDependency oLocale.VIGUID
         Next
      End If
   End Sub
End Class

'****************************************************************************************
' AvailableLocales Class
'
' This class keeps track of available locales at configuration level. This is a utility
' class, and the caller should Destroy after use so that we don't have one entry per
' Language Support component.
'
' Methods:
' Construct(oConfig)       - Initialize this object against a given configuration
' Destroy                  - Release most of the memory
' LangIdToGuid             - Given a Language Id, return Language Support instance VSGUID
' RemoveLanguage(guidInst) - Remove all entries related to a given instance
' AddUL(guidInst,nLocID,sLocName) - Add a user locale to AvailableLocales object
' AddSL(guidInst,nLocID,sLocName) - Add a system locale to AvailableLocales object
' IsAvailableAsUL(nLocID)  - Return true if nLocID is available as user locale
' IsAvailableAsSL(nLocID)  - Return true if nLocID is available as system locale
' IsAvailableAsSLFor(nLangId,nLocID) - Return true if nLocID is available as system
'                                      locale for language indicated by nLangId
' AvailableLanguages       - Get an VSGUID array of active language support instances
' AvailableULocales        - Return all user locales available (sorted, LocaleData)
' AvailableSLocales        - Return all system locales available (sorted, LocaleData)
' AvailableSLocalesFor(nLangID) - return all system locales available for the given
'                                 language support component instance (sorted, LocaleData)
'
Class AvailableLocales

   Private m_oConfig
   Private m_aLSInstances  ' an array of Instance VSGUIDs
   Private m_oULocalesDDict
      ' vuDDict object
      ' Primary key     = Instance VSGUID
      ' Secondary key   = User Locale IDs that belong to the instance
      ' Item            = Locale Name
   Private m_oSLocalesDDict
      ' vuDDict object
      ' Primary key     = Instance VSGUID
      ' Secondary key   = System Locale IDs that belong to the instance
      ' Item            = Locale Name

   '////////////////////////////////////////////////////////////////////////////
   ' Construct
   ' Initialize ULocalesDDict and SLocalesDDict against oConfig
   ' oConfig   - configuration object to initialize against
   '
   Public Sub Construct(oConfig)
      Dim oInst               ' Language Support Instance
      Dim i, j
      Dim oILS                ' LanguageSupportData object for an instance

      Set m_oConfig = oConfig
      If IsEmpty(m_oULocalesDDict) Then Set m_oULocalesDDict = New vuDDict
      If IsEmpty(m_oSLocalesDDict) Then Set m_oSLocalesDDict = New vuDDict
      m_oULocalesDDict.Reset
      m_oSLocalesDDict.Reset
      m_aLSInstances = oPL.GToI.Keys(guidLangSupportGroup)
      
      For i = 0 to UBound(m_aLSInstances)  ' UBound is -1 if the array is empty (doesn't raise exception)
         '
         ' Get instance language support data
         '
         Set oInst = oConfig.Instances.Item(m_aLSInstances(i))
         Set oILS = oInst.Script.oLS
         '
         ' Add all user and system locales to dictionary from this instance
         '
         For j = 0 To UBound(oILS.aUserLocales)
            oAL.AddUL m_aLSInstances(i), oILS.aUserLocales(j).LocID, oILS.aUserLocales(j)
         Next
         For j = 0 To UBound(oILS.aSystemLocales)
            oAL.AddSL m_aLSInstances(i), oILS.aSystemLocales(j).LocID, oILS.aSystemLocales(j)
         Next
      Next
   End Sub
   
   '////////////////////////////////////////////////////////////////////////////
   ' Destroy
   ' Release most of the memories
   '
   Public Sub Destroy
      m_oULocalesDDict.Reset
      m_oSLocalesDDict.Reset
   End Sub
   
   '////////////////////////////////////////////////////////////////////////////
   ' LangIdToGuid
   ' Given a Language ID, return the instance vsguid of the Langauge Support
   ' component that owns it.
   ' If not found, return Empty.
   '
   Public Function LangIdToGuid(nLangId)
      Dim i
      Dim oILS
      For i = 0 To UBound(m_aLSInstances)
         Set oILS = m_oConfig.Instances.Item(m_aLSInstances(i)).Script.oLS
         If oILS.nLangId = nLangId Then
            LangIdToGuid = m_aLSInstances(i)
            Exit Function
         End If
      Next
   End Function

   '////////////////////////////////////////////////////////////////////////////
   ' RemoveLanguage
   ' Remove all locale and LangID entries that belong to a particular instance.
   '
   Public Sub RemoveLanguage(guidInst)
      Dim aNew : aNew = Array()
      Dim i, j
      j = 0
      For i = 0 to UBound(m_aLSInstances)
         If  StrComp(m_aLSInstances(i), guidInst, vbTextCompare) <> 0 Then
            ReDim Preserve aNew(j)
            aNew(j) = m_aLSInstances(i)
            j = j + 1
         End If
      Next
      m_aLSInstances = aNew
      m_oULocalesDDict.RemoveAll guidInst
      m_oSLocalesDDict.RemoveAll guidInst
   End Sub
   
   '////////////////////////////////////////////////////////////////////////////
   ' AddUL
   ' Add a user locale to the available locale list
   ' guidInst     - VSGUID of the instance that this locale belongs to
   ' nLocID       - integer ID of the user locale
   ' oLocData     - LocaleData object for the locale
   '
   Public Sub AddUL(guidInst,nLocID,oLocData)
      m_oULocalesDDict.Add guidInst, nLocID, oLocData
   End Sub

   '////////////////////////////////////////////////////////////////////////////
   ' AddSL
   ' Add a system locale to the available locale list
   ' guidInst     - language support instance VSGUID, to which this locale belongs
   ' nLocID       - integer ID of the system locale
   ' oLocData     - LocaleData object for the locale
   '
   Public Sub AddSL(guidInst,nLocID,oLocData)
      m_oSLocalesDDict.Add guidInst, nLocID, oLocData
   End Sub

   '////////////////////////////////////////////////////////////////////////////
   ' AvailableLanguages
   ' Return an array of instance VSGUIDs for language support instances in the
   ' current configuration.
   '
   Public Function AvailableLanguages
      AvailableLanguages = m_aLSInstances
   End Function
   
   '////////////////////////////////////////////////////////////////////////////
   ' IsAvailableAsUL
   ' Return true if nLocID is available as user locale
   '
   Public Function IsAvailableAsUL(nLocID)
      IsAvailableAsUL = IsAvailable(nLocID, m_oULocalesDDict)
   End Function

   '////////////////////////////////////////////////////////////////////////////
   ' IsAvailableAsSL
   ' Return true if nLocID is available as system locale
   '
   Public Function IsAvailableAsSL(nLocID)
      IsAvailableAsSL = IsAvailable(nLocID, m_oSLocalesDDict)
   End Function

   '////////////////////////////////////////////////////////////////////////////
   ' IsAvailable
   ' Return true if nLocID is available in the given locales double dictionary
   '
   Private Function IsAvailable(nLocID,oLocalesDDict)
      Dim i
      IsAvailable = False
      For i = 0 To UBound(m_aLSInstances)
         If oLocalesDDict.Exists(m_aLSInstances(i), nLocID) Then
            IsAvailable = True
            Exit Function
         End If
      Next
   End Function
   
   '////////////////////////////////////////////////////////////////////////////
   ' AvailableULocales
   ' Return all user locales available (array of LocaleData objects)
   '
   Public Function AvailableULocales
      AvailableULocales = AvailableLocales(m_oULocalesDDict)
   End Function
   
   '////////////////////////////////////////////////////////////////////////////
   ' AvailableSLocales
   ' Return all system locales available (array of LocaleData objects)
   '
   Public Function AvailableSLocales
      AvailableSLocales = AvailableLocales(m_oSLocalesDDict)
   End Function
   
   '////////////////////////////////////////////////////////////////////////////
   ' AvailableLocales
   ' Return all locales available based on the input double dictionary
   ' 1. The input double dictionary can either be m_oULocalesDDict
   '    or m_oSLocalesDDict
   ' 2. Returns an array of LocaleData objects
   '
   Private Function AvailableLocales(oLocalesDDict)
      Dim aResult : aResult = Array()
      Dim aMergedKeys
      Dim i, j
      aMergedKeys = oLocalesDDict.MultiKeys(m_aLSInstances)
      For i = 0 To UBound(aMergedKeys)
         For j = 0 To UBound(m_aLSInstances)
            If oLocalesDDict.Exists(m_aLSInstances(j),aMergedKeys(i)) Then
               ReDim Preserve aResult(i)
               Set aResult(i) = oLocalesDDict.Item(m_aLSInstances(j),aMergedKeys(i))
               Exit For
            End If
         Next
      Next
      vuQuickSort aResult, LBound(aResult), UBound(aResult), GetRef("CompareName"), GetRef("vuDefSwap")
      AvailableLocales = aResult
   End Function
   
   '////////////////////////////////////////////////////////////////////////////
   ' AvailableSLocalesFor
   ' Return a sorted array of all system locales available for the given
   ' language. Returns array of LocaleData objects.
   ' nLangId   - Language ID (integer)
   '
   Public Function AvailableSLocalesFor(nLangId)
      Dim aResult : aResult = Array()
      Dim aSKeys
      Dim guidInst
      Dim i
      guidInst = LangIdToGuid(nLangId)
      If Not IsEmpty(guidInst) And m_oSLocalesDDict.PrimaryExists(guidInst) Then
         aSKeys = m_oSLocalesDDict.Keys(guidInst)
         For i = 0 to UBound(aSKeys)
            ReDim Preserve aResult(i)
            Set aResult(i) = m_oSLocalesDDict.Item(guidInst,aSKeys(i))
         Next
      End If
      vuQuickSort aResult, LBound(aResult), UBound(aResult), GetRef("CompareName"), GetRef("vuDefSwap")
      AvailableSLocalesFor = aResult
   End Function

   '////////////////////////////////////////////////////////////////////////////
   ' IsAvailableSLocalesFor
   ' Return true if nLocID is an available system locale Id for the given
   ' language.
   ' nLangId   - Language ID (integer)
   ' nLocID    - Locale Id to check (integer)
   '
   Public Function IsAvailableAsSLFor(nLangId,nLocID)
      Dim guidInst
      guidInst = LangIdToGuid(nLangId)
      If Not IsEmpty(guidInst) Then
         IsAvailableAsSLFor = m_oSLocalesDDict.Exists(guidInst,nLocID)
      End If
   End Function

End Class


'**************************************************************************************************************************
' EVENT HANDLERS AND RELATED SUBROUTINES
'**************************************************************************************************************************

'////////////////////////////////////////////////////////////////////////////
' Instance activation and deactivation events
'////////////////////////////////////////////////////////////////////////////

'////////////////////////////////////////////////////////////////////////////
' GetExtendedSupportDependencies
'
' This routine adds a dependency for each member of a group. This routine is
' used to pick up any NLS components in the database that were added after we
' released the language support components.
'
' For example, the author of a new Font component can define his/her component,
' and make it a member of an extended support dependency group for a Japanese
' Language Support. The new font will appear as an optional or required
' dependency for Japanese Language Support component after it is imported into
' the database.
'
' The reason we add component dependency for each member rather than using
' group dependency is because we actually have a UI that allows the user to pick
' and choose individual dependencies using checkboxes. Each dependency will be
' either enabled or disabled according to the checkbox.
'
' oInst        - Language Support instance object
' guidGroup    - GUID of the extended support dependency group we want to include
'
Sub GetExtendedSupportDependencies(oInst, guidGroup)
   Dim oExtendedSupportSet
   Dim oComp
   Dim oCompProps
   Dim oCompProp
   Dim oDep
   Dim oDepProp
	'
	' If the GUID is zero GUID, this language support component is not extensible
	'
	If guidGroup <> cZeroGUID Then
      On Error Resume Next
	   Set oExtendedSupportSet = Nothing   ' in case we fail
		Set oExtendedSupportSet = oPL.CreateFromDB(cmiComponents, _
						                               cmiFTGetGroupMembers Or cmiFTNoAttachments, _
						                               guidGroup)
      On Error Goto 0
		If Not oExtendedSupportSet Is Nothing Then
			For each oComp in oExtendedSupportSet
            '
				' Create a dependency and attach it to the language support
				' regardless of the module type of the component
				'
				Set oDep = oPL.CMI.CreateObject(cmiDependency, oInst.PlatformVSGUID)
				oDep.TargetGUID = oComp.VIGUID
				oDep.Class = cmiInclude
				oDep.Type = cmiAtLeastOne
				oDep.MinRevision = 0
				oDep.Disabled = False
				oDep.DisplayName = oComp.DisplayName
				oDep.Description = "Dependency on language infrastructure component."
            '
				' Get properties for the component
				'
      		Set oCompProps = oPL.CreateFromDB(cmiExtProperties, _
								                      cmiFTGetComponentData, _
								                      oComp.VSGUID)
				'
				' Move special extended properties for language support over to
				' the dependencies we are creating (if exists)
				'
				If oCompProps.Exists("cmiLangModuleType") Then
				   Set oCompProp = oCompProps.Item("cmiLangModuleType")
				   If oLS.IsValidLangProp( oComp, oCompProp) Then
					   Set oDepProp = oPL.CreateProp(oCompProp.Name, oCompProp.Format, oCompProp.Value)
					   oDep.Properties.Add oDepProp
   				End If
            End If
				If oCompProps.Exists("cmiLangRequired") Then
				   Set oCompProp = oCompProps.Item("cmiLangRequired")
				   If oLS.IsValidLangProp( oComp, oCompProp) Then
					   Set oDepProp = oPL.CreateProp(oCompProp.Name, oCompProp.Format, oCompProp.Value)
					   oDep.Properties.Add oDepProp
   				End If
            End If
				'
				' Finally add the dependency object
				'
				cmiThis.Dependencies.Add oDep
				Set oCompProps = Nothing
   		Next	' Next extended support component
		End If
	End If
End Sub

'////////////////////////////////////////////////////////////////////////////
' IsNlsCompDependency
' If the oDep contains a cmiLangModuleType property with the value for
' font, codepage or keyboard layout, return true.
'
Function IsNlsCompDependency(oDep)
   Dim oPropModuleType
   IsNlsCompDependency = False
   Set oPropModuleType = oLS.GetProp(oDep,"cmiLangModuleType")
   If oLS.IsValidLangProp(oDep, oPropModuleType) Then
      Select Case oPropModuleType.Value
      Case cLangModuleTypeFont
         IsNlsCompDependency = True
      Case cLangModuleTypeCodepage
         IsNlsCompDependency = True
      Case cLangModuleTypeKeyboard
         IsNlsCompDependency = True
      Case Else
         IsNlsCompDependency = False
      End Select
   End If
End Function

'////////////////////////////////////////////////////////////////////////////
' InitializeNlsCompDependency
' Add extended properties for dependencies that points to infrastructure components
' Font dependencies add boolean extended properties:
'     cmiLangFont0001 through cmiLangFont9999
' Codepage dependencies add boolean extended properties:
'     cmiLangCp0001 through cmiLangCp9999
' Keyboard layout dependencies add boolean extended properties:
'     cmiLangKbd0001 through cmiLangKbd9999
' Assumes that oDep was evaluated true using IsNlsCompDependency.
' This happens only once at instance creation.
'
Sub InitializeNlsCompDependency(oDep)
   Dim oCompProp
   Dim oDepProp
   Dim oPropModuleType
   Dim nType
   Dim oPropRequired
   Dim bDefaultState    ' Enable or disable the dependency by default
   '
   ' Get module type
   '
   Set oPropModuleType = oLS.GetProp(oDep,"cmiLangModuleType")
	nType = oPropModuleType.Value
	'
	' Get the default value (only the required dependencies are enabled by default)
	'
	Set oPropRequired = oLS.GetProp(oDep,"cmiLangRequired")
	If Not oLS.IsValidLangProp(oDep, oPropRequired) Then
	   bDefaultState = False ' the author forgot to put in this property correctly, forgive him
	Else
	   bDefaultState = oPropRequired.Value
	End If
	'
	' Add extended property for DHTML
	'
	If aIndex(nType) < cMaxPropIndex Then
	   '
	   ' Synthesize the name of the ext. property and attach it to the current instance
	   '
      Set oCompProp = oPL.CreateProp( _
                       sPrefix(nType) & String(4 - Len(CStr(aIndex(nType))), "0") & CStr(aIndex(nType)), _
                       cmiBoolean, bDefaultState)
	   cmiThis.Properties.Add oCompProp
      Set oDepProp = oPL.CreateProp("cmiLangInputProp", cmiString, oCompProp.Name)
      oDep.Properties.Add oDepProp
      aIndex(nType) = aIndex(nType) + 1
   End If
End Sub

'////////////////////////////////////////////////////////////////////////////
' IsMuiResDependency
' If a dependency has the following property, it is a MUI resource component
' dependency:
'    cmiLangModuleType = cLangModuleTypeMuiRes
'
' HandleMuiResDependency
' If the property indicates module type = MUI, handle the dependency object
' in a special way:
' 1. populate its cmiLangInputProp with "cmiLangEnableMui"
' 2. populate guidMuiComponent global variable
'    (this variable is Empty if there is no MUI resource component for this
'    language. DHTML will test this variable with IsEmpty() and decide whether
'    to add a checkbox)
'
Function IsMuiResDependency(oDep)
   Dim oDepProp
   IsMuiResDependency = False
   Set oDepProp = oLS.GetProp(oDep, "cmiLangModuleType")
   If oLS.IsValidLangProp(oDep, oDepProp) Then
      If oDepProp.Value = cLangModuleTypeMUIRes Then
         IsMuiResDependency = True
      End If
   End If
End Function

'////////////////////////////////////////////////////////////////////////////
' InitializeMuiResDependency
' Create a property in oDep, so that the dependency is enabled based on
' our DHTML.
'
' Assumes that oDep was evaluated true using IsMuiResDependency
' This happens on the first activation of an instance
'
Sub InitializeMuiResDependency(oDep)
   Dim oDepProp
   Set oDepProp = oPL.CreateProp("cmiLangInputProp", cmiString, "cmiLangEnableMui")
   oDep.Properties.Add oDepProp
End Sub

'////////////////////////////////////////////////////////////////////////////
' IsLocaleCompDependency
' We leave a room for adding locale dependencies directly to the component.
' If a component dependency is of type cLangModuleTypeUserLocale or
' cLangModuleTypeSystemLocale, it is a locale depedency.
'
Function IsLocaleCompDependency(oDep)
   Dim oDepProp
   IsLocaleCompDependency = False
   Set oDepProp = oLS.GetProp(oDep, "cmiLangModuleType")
   If oLS.IsValidLangProp(oDep, oDepProp) Then
      If (oDepProp.Value = cLangModuleTypeUserLocale) or _
         (oDepProp.Value = cLangModuleTypeSystemLocale) Then
         IsLocaleCompDependency = True
      End If
   End If
End Function

'////////////////////////////////////////////////////////////////////////////
' IsLocaleGroupDependency
'
' If this dependency contains the extended property "cmiLangLocaleGroup",
' this is a dependency to a group that contains User/System locale
' components for this language.
'
Function IsLocaleGroupDependency(oDep)
   Dim oDepProp
   IsLocaleGroupDependency = False
   Set oDepProp = oLS.GetProp(oDep, "cmiLangLocaleGroup")
   If oLS.IsValidLangProp(oDep, oDepProp) Then
      IsLocaleGroupDependency = oDepProp.Value
   End If
End Function

'////////////////////////////////////////////////////////////////////////////
' cmiOnActivateInstance (virtual)
' Called from Config::cmiOnActivateInstance
'
' oOldInstance		Old Instance for upgrade, else Nothing
' Returns			True to allow activation, False to disallow
'
' This routine does:
'
' Set cmiLangChanged to true. This property is defined in the
' configuration object, and used by the language settings component
'
' Gather all components that belong to our extended language support
' sets (dependency groups), and create one dependency for each of those guys.
' 
' Create one extended property for each dependency for infrastructure
' component. Make each dependency conditional on that extended
' property.
'
' Generate sorted table of available locales for this language.
'
Function cmiOnActivateInstance(oOldInstance)
	Dim sLanguage              ' Name of the language
	Dim guidExtendedSupport    ' GUID of the group that contains extended set of NLS components
	Dim oExtendedSupportSet    ' A component collection containing members of the Ext.Support grp
	Dim oComp                  ' Component obj
	Dim oCompProps             ' Component property collection
	Dim oCompProp              ' Component property obj
	Dim oDepProp               ' Ext. property in a dependency object
	Dim oDep                   ' Dependency obj
	Dim nFontIndex
	Dim nCodepageIndex
	Dim nKeyboardIndex
	
	' Assume failure
	cmiOnActivateInstance = False

	' First call super
	If Not cmiSuper.cmiOnActivateInstance(Nothing) Then
	   Exit Function
	End If

   '
   ' ON INSTANCE CREATION
   ' This gets executed only once in the life time of an instance. During this time
   ' we create instance data that can be persisted across Target Designer sessions.
   '	
	If cmiThis.Context And cmiNew Then	' only do this once at creation
	   '
	   ' Initialize property indices to be used for generating
	   ' unique property names
	   '
      aIndex(cLangModuleTypeFont)      = 0
      aIndex(cLangModuleTypeCodepage)  = 0
      aIndex(cLangModuleTypeKeyboard)  = 0
		'
		' HANDLING EXTENDED SUPPORT SET
		' Read Extended Support Set group of components, and create dependencies for each member.
		' This is the way you can add a new font or code page to a specific Language Support
		' component after we RTM.
		'
		Set oCompProp = oLS.GetProp(cmiThis,"cmiLangExtendedSupport")
		If oLS.IsValidLangProp(cmiThis, oCompProp) Then
		   GetExtendedSupportDependencies cmiThis, oCompProp.Value
		End If
		Set oCompProp = oLS.GetProp(cmiThis,"cmiLangExtendedSupportShared")
		If oLS.IsValidLangProp(cmiThis, oCompProp) Then
		   GetExtendedSupportDependencies cmiThis, oCompProp.Value		   
		End If

		'
		' INITIALIZING DEPENDENCIES
		' Set up internal extended properties to support language support component UI
		' and language settings UI. Happens only once at instance creation.
		'      
		For each oDep In cmiThis.Dependencies
		   If IsNlsCompDependency(oDep) Then
		      InitializeNlsCompDependency oDep
	      ElseIf IsMuiResDependency(oDep) Then
   	      InitializeMuiResDependency oDep
   	   End If
      Next
   End If

   '
   ' ON INSTANCE ACTIVATION
   ' This portion gets executed on every activation. Here we create objects
   ' that are used during script run-time, and change any persistable data that
   ' is affected by activating this instance.
   '
   If IsEmpty(oLS.bInitialized) Then oLS.InitData cmiThis
	'
	' Adjust default locales (if we have to)
	'
   oLS.SetLangSupportChanged cmiThis.Configuration
   oLS.SetConfigDefaultLocales cmiThis
	'
	' If we made it to here, we activated the instance successfully!
	'
	cmiOnActivateInstance = True
End Function

'////////////////////////////////////////////////////////////////////////////
' cmiOnDeactivateInstance (virtual)
' Called from Config::cmiOnDeactivateInstance
Sub cmiOnDeactivateInstance
   '
	' Call super (GToI still contains the current instance after this call)
	'
	cmiSuper.cmiOnDeactivateInstance

   '
   ' Indicate the something changed about language support and
   ' adjust configuration's default locales
   '
   oLS.ResetConfigDefaultLocales cmiThis.Configuration
   oLS.SetLangSupportChanged cmiThis.Configuration
End Sub

'////////////////////////////////////////////////////////////////////////////
' cmiOnBeginCheckDependencies (virtual)
' Called from Config::cmiOnCheckDependencies
'
' dwFlags			Arbitrary flags passed from Config.CheckDeps method
'
' To do:
' Validate oCompProp after GetProp (should be boolean)
'
Sub cmiOnBeginCheckDependencies(dwFlags)
   
   Dim oDep
   Dim oDepProp
   Dim oDepMType
   Dim oDepLocaleId
   Dim oDepDependOnSL
   Dim oCompProp
   Dim oConfig : Set oConfig = cmiThis.Configuration
   
   '
   ' Adjust dependencies according to the properties set by the DHTML 
   '
   For Each oDep In cmiThis.Dependencies
      Set oDepProp = oLS.GetProp(oDep,"cmiLangInputProp")
      If Not oDepProp Is Nothing Then
         Set oCompProp = oLS.GetProp(cmiThis,oDepProp.Value)
         If Not oCompProp Is Nothing Then
            oDep.Disabled = Not oCompProp.Value
         End If
      End If
   Next

   '
   ' Enforce other dependency rules (construct locale list before this)
   '
   oAL.Construct(oConfig)
   For Each oDep In cmiThis.Dependencies
      '
      ' If we find a dependency to system locale that is currently
      ' set as default, reenable it.
      '
      Set oDepMType = oLS.GetProp(oDep,"cmiLangModuleType")
      Set oDepLocaleId = oLS.GetProp(oDep,"cmiLangLocaleId")
      If oLS.IsValidLangProp(oDep, oDepMType) And _
         oLS.IsValidLangProp(oDep, oDepLocaleId) Then
         If oDepMType.Value = cLangModuleTypeSystemLocale And _
            oDepLocaleId.Value = cmiThis.Configuration.Properties("cmiLangDefaultSystemLocale").Value Then
            oDep.Disabled = False
         End If
      End If
      '
      ' If there are any components that depend on system locale,
      ' and if the current language does not own the system locale,
      ' disable dependencies.
      '
      Set oDepDependOnSL = oLS.GetProp(oDep,"cmiLangDependOnSystemLocale")
      If oLS.IsValidLangProp(cmiThis, oDepDependOnSL) Then
         If oDepDependOnSL.Value Then
            If oAL.IsAvailableAsSLFor(oLS.nLangId,oConfig.Properties("cmiLangDefaultSystemLocale").Value) Then
               oDep.Disabled = False
            Else
               oDep.Disabled = True
            End If
         End If
      End If
   Next
   
   ' Lastly call super
   cmiSuper.cmiOnBeginCheckDependencies dwFlags
   
End Sub

]]></SCRIPTTEXT>

        <HTMLTEXT
          src=".\language_prototype.asp"
        ><![CDATA[<%asp%>
<%= ASP.Header %>
<%= ASP.PropHandlers %>
<% Dim oILS : Set oILS = ASP.Instance.Script.oLS %>
<% Dim aFontList : aFontList = oILS.aFonts %>
<% Dim aCpList : aCpList = oILS.aCodepages %>
<% Dim aKbdList : aKbdList = oILS.aKeyboards %>
<% Dim i %>

<SCRIPT LANGUAGE="VBScript">
<!--

Option Explicit

'
' Global variables for this script block
'
Dim oHostInst: Set oHostInst = window.external.Instance
Dim oILS : Set oILS = oHostInst.Script.oLS

'
' AccessDepStates constants
'
Dim nLangAccessDepStateInvalid : nLangAccessDepStateInvalid       = oHostInst.Script.cLangAccessDepStateInvalid
Dim nLangAccessDepStateGetCurrent : nLangAccessDepStateGetCurrent = oHostInst.Script.cLangAccessDepStateGetCurrent
Dim nLangAccessDepStateSetDefault : nLangAccessDepStateSetDefault = oHostInst.Script.cLangAccessDepStateSetDefault
Dim nLangAccessDepStateSetTrue : nLangAccessDepStateSetTrue       = oHostInst.Script.cLangAccessDepStateSetTrue
Dim nLangAccessDepStateSetFalse : nLangAccessDepStateSetFalse     = oHostInst.Script.cLangAccessDepStateSetFalse

'/////////////////////////////////////////////////////////////////
' Handle Button clicks
'
' 1. Call the component script to get a list of elements to set
'    with their default values
' 2. Go through the returned array setting the values as specified 
'

'/////////////////////////////////////////////////////////////////
' CheckItems
'
' aNameAndProp    array of NameAndProp objects to apply the
'                 operation to
'
' nOp             Operation:
'                 cLangAccessDepStateSetTrue
'                    Check all the checkboxes corresponding to
'                    the list passed in, and also set all
'                    corresponding properties in the instance
'                    to True.
'                 cLangAccessDepStateSetFalse
'                    Uncheck all the checkboxes corresponding to
'                    the list passed in, and also set all
'                    corresponding properties in the instance
'                    to False.
'                 cLangAccessDepStateSetDefault
'                    Check only the required checkboxes. Also
'                    set the corresponding instance properties
'                    to true, and the non-required ones to false.
'
Sub CheckItems(nOp, aNameAndProp)
   Dim aResult
   Dim oElem
   Dim i
   aResult = oILS.AccessDepStates(nOp, aNameAndProp)
   If IsArray(aResult) Then
      For i = 0 to UBound(aResult)
         '
         ' aResult is an array of PropAndState objects
         '
         Set oElem = window.document.all(aResult(i).PropName)
         oElem.checked = aResult(i).State
      Next
   End If
End Sub

'
' Font buttons
'
Sub ButtonFontAll_onClick
   CheckItems nLangAccessDepStateSetTrue, oILS.aFonts
End Sub
Sub ButtonFontNone_onClick
   CheckItems nLangAccessDepStateSetFalse, oILS.aFonts
End Sub
Sub ButtonFontMinimum_onClick
   CheckItems nLangAccessDepStateSetDefault, oILS.aFonts
End Sub

'
' Code page buttons
'
Sub ButtonCpAll_onClick
   CheckItems nLangAccessDepStateSetTrue, oILS.aCodepages
End Sub
Sub ButtonCpNone_onClick
   CheckItems nLangAccessDepStateSetFalse, oILS.aCodepages
End Sub
Sub ButtonCpMinimum_onClick
   CheckItems nLangAccessDepStateSetDefault, oILS.aCodepages
End Sub

'
' Keyboard layout buttons
'
Sub ButtonKbdAll_onClick
   CheckItems nLangAccessDepStateSetTrue, oILS.aKeyboards
End Sub
Sub ButtonKbdNone_onClick
   CheckItems nLangAccessDepStateSetFalse, oILS.aKeyboards
End Sub
Sub ButtonKbdMinimum_onClick
   CheckItems nLangAccessDepStateSetDefault, oILS.aKeyboards
End Sub

-->
</SCRIPT>

<DIV STYLE="WIDTH: 370px;">


<DIV Style="FLOAT: left;
            MARGIN-LEFT: 0px;
            MARGIN-RIGHT: 0px;
            MARGIN-BOTTON: 25px;
            FONT: 8pt Tahoma;
            WIDTH: 352px">
<p class="callout">
Select fonts, code pages and keyboard layouts to add to the run-time image.
The check box lists below do not represent the final set of fonts, code pages, and keyboard layouts included in the target runtime image.
In addition to the selected items in these lists, other fonts, code pages or keyboard layouts may be added if components express dependency on them.
</p>
</DIV>

<!------------------------------------------------------------->
<!-- Fonts related to the current language support component -->
<!------------------------------------------------------------->

<FIELDSET STYLE="FLOAT: left;
                 FONT: 8pt Tahoma;
                 MARGIN-TOP: 10;
                 WIDTH: 355px;">
<LEGEND>Fonts</LEGEND>
<DIV STYLE="BORDER: gray 1px solid;
            FLOAT: left;
            MARGIN: 5px;
            MARGIN-RIGHT: 10px;
            FONT: 8pt Tahoma;
            OVERFLOW: scroll;
            WIDTH: 330px;
            HEIGHT: 100px"
     ALIGN=left
     NOWRAP>
<% If IsArray(aFontList) Then %>
<%    For i = LBound(aFontList) To UBound(aFontList) %>
         <INPUT type="checkbox" name="cmixDefPropHandler" checked="0"
                ID='<%= aFontList(i).PropName %>'><%= aFontList(i).Name %><BR>
<%    Next %>
<% End If %>
</DIV>

<DIV Style="MARGIN-TOP:5; MARGIN-RIGHT:4; MARGIN-BOTTOM:10; FLOAT:right">
   <INPUT STYLE="FONT: 8pt Tahoma;WIDTH:85;HEIGHT:22"
          NAME="ButtonFontAll" TYPE="button" value="Select All">
   <INPUT STYLE="FONT: 8pt Tahoma;WIDTH:85;HEIGHT:22"
          NAME="ButtonFontNone" TYPE="button" value="Select None">
   <INPUT STYLE="FONT: 8pt Tahoma;WIDTH:85;HEIGHT:22"
          NAME="ButtonFontMinimum" TYPE="button" value="Select Minimum">
</DIV>
</FIELDSET>

<!----------------------------------------------------------------->
<!-- Codepages related to the current language support component -->
<!----------------------------------------------------------------->
<FIELDSET STYLE="FLOAT: left;
                 FONT: 8pt Tahoma;
                 MARGIN-TOP: 10;
                 WIDTH: 355px;">
<LEGEND>Code pages conversion tables</LEGEND>

<DIV STYLE="BORDER: gray 1px solid;
            FLOAT: left;
            MARGIN: 5px;
            MARGIN-RIGHT: 10px;
            FONT: 8pt Tahoma;
            OVERFLOW: scroll;
            WIDTH: 330px;
            HEIGHT: 100px"
     ALIGN=left
     NOWRAP>
<% If IsArray(aCpList) Then %>
<%    For i = LBound(aCpList) To UBound(aCpList) %>
         <INPUT type="checkbox" name="cmixDefPropHandler" checked="0"
                ID='<%= aCpList(i).PropName %>'><%= aCpList(i).Name %><BR>
<%    Next %>
<% End If %>
</DIV>
<DIV Style="MARGIN-TOP:5; MARGIN-RIGHT:4; MARGIN-BOTTOM:10; FLOAT:right">
   <INPUT STYLE="FONT: 8pt Tahoma;WIDTH:85;HEIGHT:22"
          NAME="ButtonCpAll" TYPE="button" value="Select All">
   <INPUT STYLE="FONT: 8pt Tahoma;WIDTH:85;HEIGHT:22"
          NAME="ButtonCpNone" TYPE="button" value="Select None">
   <INPUT STYLE="FONT: 8pt Tahoma;WIDTH:85;HEIGHT:22"
          NAME="ButtonCpMinimum" TYPE="button" value="Select Minimum">
</DIV>
</FIELDSET>

<!------------------------------------------------------------------------>
<!-- Keyboard layouts related to the current language support component -->
<!------------------------------------------------------------------------>
<FIELDSET STYLE="FLOAT: left;
                 FONT: 8pt Tahoma;
                 MARGIN-TOP: 10;
                 WIDTH: 355px;">
<LEGEND>Keyboard layouts</LEGEND>

<DIV STYLE="BORDER: gray 1px solid;
            FLOAT: left;
            MARGIN: 5px;
            MARGIN-RIGHT: 10px;
            FONT: 8pt Tahoma;
            OVERFLOW: scroll;
            WIDTH: 330px;
            HEIGHT: 100px"
     ALIGN=left
     NOWRAP>
<% If IsArray(aKbdList) Then %>
<%    For i = LBound(aKbdList) To UBound(aKbdList) %>
         <INPUT type="checkbox" name="cmixDefPropHandler" checked="0"
            ID='<%= aKbdList(i).PropName %>'><%= aKbdList(i).Name %><BR>
<%    Next %>
<% End If %>
</DIV>
<DIV Style="MARGIN-TOP:5; MARGIN-RIGHT:4; MARGIN-BOTTOM:10; FLOAT:right">
   <INPUT STYLE="FONT: 8pt Tahoma;WIDTH:85;HEIGHT:22"
          NAME="ButtonKbdAll" TYPE="button" value="Select All">
   <INPUT STYLE="FONT: 8pt Tahoma;WIDTH:85;HEIGHT:22"
          NAME="ButtonKbdNone" TYPE="button" value="Select None">
   <INPUT STYLE="FONT: 8pt Tahoma;WIDTH:85;HEIGHT:22"
          NAME="ButtonKbdMinimum" TYPE="button" value="Select Minimum">
</DIV>
</FIELDSET>

<!---------------------------------------------------------------------->
<!-- This checkbox determines whether to pull in all system locales   -->
<!---------------------------------------------------------------------->
<DIV Style="MARGIN-TOP:15; MARGIN-BOTTOM:5;">
   <INPUT type="checkbox" name="cmixDefPropHandler" checked="0"
          ID="cmiLangEnableAllSystemLocales">Support all system locales for <%= oILS.sLangName %>.<BR>
</DIV>

<!---------------------------------------------------------------------->
<!-- The checkbox to decide whether to include MUI resource component -->
<!---------------------------------------------------------------------->
<% If Not IsEmpty( oILS.guidMuiComponent ) Then %>
<%    If oILS.nLangId = 9 Then %>
      <DIV Style="MARGIN-TOP:5; MARGIN-BOTTOM:15;">
            <INPUT type="checkbox" name="cmixDefPropHandler" checked="1" disabled
               ID="cmiLangEnableMui">Include multilanguage user interface resources.<BR>
      </DIV>
<%    Else %>
      <DIV Style="MARGIN-TOP:5; MARGIN-BOTTOM:15;">
            <INPUT type="checkbox" name="cmixDefPropHandler" checked="0"
               ID="cmiLangEnableMui">Include multilanguage user interface resources.<BR>
      </DIV>
<%    End If %>
<% End If %>

</DIV>

<%= ASP.Footer %>
]]></HTMLTEXT>

        <PROPERTIES
          Context="1"
          PlatformGUID="{00000000-0000-0000-0000-000000000000}"
        >
          <PROPERTY
            Name="cmiLangEnableMui"
            Format="Boolean"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >True</PROPERTY>
        </PROPERTIES>

        <RESOURCES
          Context="1"
          PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
        >        </RESOURCES>

        <GROUPMEMBERS
        >
          <GROUPMEMBER
            GroupVSGUID="{8180C915-788C-473C-80BB-BB6DF8FFA263}"
          ></GROUPMEMBER>

          <GROUPMEMBER
            GroupVSGUID="{719FF4F5-55C2-4A87-A744-19E6C9B3089F}"
          ></GROUPMEMBER>

          <GROUPMEMBER
            GroupVSGUID="{E01B4103-3883-4FE8-992F-10566E7B796C}"
          ></GROUPMEMBER>
        </GROUPMEMBERS>

        <DEPENDENCIES
          Context="1"
          PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
        >
          <DEPENDENCY
            Class="Include"
            Type="All"
            DependOnGUID="{CF894FAA-B4C4-4F9E-8409-162FABDDD189}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >            </PROPERTIES>

            <DISPLAYNAME>Language Support Prototype depends on Windows XP Embedded Language Core</DISPLAYNAME>

            <DESCRIPTION></DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Before"
            Type="All"
            DependOnGUID="{39B5CBD1-6933-4224-92C0-0EF1F57A5044}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >            </PROPERTIES>

            <DISPLAYNAME>Build ClsInstall: FloppyDisk before Language Support Prototype</DISPLAYNAME>

            <DESCRIPTION></DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Before"
            Type="All"
            DependOnGUID="{4A528426-0094-4542-865C-6B571EDBA950}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >            </PROPERTIES>

            <DISPLAYNAME>Build Font Object Embedding Library before Language Support Prototype</DISPLAYNAME>

            <DESCRIPTION></DESCRIPTION>
          </DEPENDENCY>
        </DEPENDENCIES>

        <DISPLAYNAME>Language Support Prototype</DISPLAYNAME>

        <VERSION>1.0</VERSION>

        <DESCRIPTION>All language support components inherit from this prototype. This prototype contains DHTML script for customizing each language support component, and component script to construct the configuration UI.</DESCRIPTION>

        <COPYRIGHT>Microsoft (C) 2001</COPYRIGHT>

        <VENDOR>Microsoft</VENDOR>

        <OWNERS>SJang, JohnMcco</OWNERS>

        <AUTHORS>SJang, JohnMcco</AUTHORS>

        <DATECREATED>9/24/2001 6:40:06 PM</DATECREATED>

        <DATEREVISED>11/5/2001 4:43:36 AM</DATEREVISED>
      </COMPONENT>
    </COMPONENTS>

    <RESTYPES
      Context="1"
      PlatformGUID="{00000000-0000-0000-0000-000000000000}"
    >    </RESTYPES>
  </DCARRIER>
