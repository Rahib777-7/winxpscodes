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
        ComponentVSGUID="{BBD8D7D4-E7A4-4ABE-871A-8A8DA04C7B3F}"
        ComponentVIGUID="{A4DF49B5-2327-4A86-9E6E-94FB242C340C}"
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
          src="..\..\..\..\..\net\tapi\NTE\tapisrv.htm"
        ><![CDATA[<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 9">
<meta name=Originator content="Microsoft Word 9">
<link rel=File-List href="./tapisrv_files/filelist.xml">
<title>Telephony Server Component</title>

<style>
<!--
 /* Font Definitions */
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:536871559 0 0 0 415 0;}
@font-face
	{font-family:"Microsoft Logo 95";
	panose-1:0 0 0 0 0 0 0 0 0 0;
	mso-font-alt:Symbol;
	mso-font-charset:2;
	mso-generic-font-family:auto;
	mso-font-format:other;
	mso-font-pitch:variable;
	mso-font-signature:0 0 0 0 0 0;}
 /* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:yellow;}
h1
	{mso-style-parent:"";
	mso-style-next:"Text\,t";
	margin-top:9.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:18.0pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:1;
	font-size:16.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	color:black;
	mso-font-kerning:12.0pt;
	mso-bidi-font-weight:normal;}
h2
	{mso-style-parent:"Heading 1";
	mso-style-next:"Text\,t";
	margin-top:9.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:18.0pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:2;
	font-size:16.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	color:gray;
	mso-font-kerning:12.0pt;
	mso-bidi-font-weight:normal;}
h3
	{mso-style-parent:"Heading 1";
	mso-style-next:"Text\,t";
	margin-top:9.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:18.0pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:3;
	font-size:16.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	color:silver;
	mso-font-kerning:12.0pt;
	mso-bidi-font-weight:normal;}
h4
	{mso-style-parent:"Heading 1";
	mso-style-next:"Text\,t";
	margin-top:9.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:16.0pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:4;
	font-size:14.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	color:black;
	mso-font-kerning:12.0pt;
	mso-bidi-font-weight:normal;}
h5
	{mso-style-parent:"Heading 1";
	mso-style-next:"Text\,t";
	margin-top:9.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:15.0pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:5;
	font-size:13.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	color:black;
	mso-font-kerning:12.0pt;
	mso-bidi-font-weight:normal;}
h6
	{mso-style-parent:"Heading 1";
	mso-style-next:"Text\,t";
	margin-top:9.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:12.0pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:6;
	font-size:10.0pt;
	font-family:Verdana;
	color:black;
	mso-font-kerning:12.0pt;
	mso-bidi-font-weight:normal;}
p.MsoIndex1, li.MsoIndex1, div.MsoIndex1
	{mso-style-parent:"Text\,t";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:9.0pt;
	text-indent:-9.0pt;
	line-height:11.0pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:maroon;}
p.MsoIndex2, li.MsoIndex2, div.MsoIndex2
	{mso-style-parent:"Index 1";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:27.0pt;
	text-indent:-9.0pt;
	line-height:11.0pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:maroon;}
p.MsoIndex3, li.MsoIndex3, div.MsoIndex3
	{mso-style-parent:"Index 1";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:45.0pt;
	text-indent:-9.0pt;
	line-height:11.0pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:maroon;}
p.MsoToc1, li.MsoToc1, div.MsoToc1
	{mso-style-parent:"Heading 1";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:12.0pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	tab-stops:.25in;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:maroon;
	mso-font-kerning:12.0pt;
	font-weight:bold;
	mso-bidi-font-weight:normal;}
p.MsoToc2, li.MsoToc2, div.MsoToc2
	{mso-style-parent:"Text\,t";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.25in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:maroon;}
p.MsoToc3, li.MsoToc3, div.MsoToc3
	{mso-style-parent:"TOC 2";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.5in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:maroon;}
p.MsoToc4, li.MsoToc4, div.MsoToc4
	{mso-style-parent:"TOC 2";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.75in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:maroon;}
p.MsoFootnoteText, li.MsoFootnoteText, div.MsoFootnoteText
	{mso-style-parent:"Text\,t";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:red;}
p.MsoCommentText, li.MsoCommentText, div.MsoCommentText
	{mso-style-parent:"Text\,t";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{mso-style-parent:Footer;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:right;
	line-height:11.0pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:maroon;}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	text-align:right;
	line-height:11.0pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:maroon;}
p.MsoIndexHeading, li.MsoIndexHeading, div.MsoIndexHeading
	{mso-style-parent:"Heading 1";
	mso-style-next:"Index 1";
	margin-top:9.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:15.0pt;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:5;
	font-size:13.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:maroon;
	mso-font-kerning:12.0pt;
	font-weight:bold;
	mso-bidi-font-weight:normal;}
span.MsoFootnoteReference
	{color:red;
	vertical-align:super;}
span.MsoPageNumber
	{mso-ansi-font-size:8.0pt;
	mso-ascii-font-family:Verdana;
	mso-hansi-font-family:Verdana;
	color:maroon;
	font-weight:bold;}
p.Text, li.Text, div.Text
	{mso-style-name:"Text\,t";
	mso-style-parent:"";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.Figure, li.Figure, div.Figure
	{mso-style-name:"Figure\,fig";
	mso-style-parent:"Text\,t";
	mso-style-next:"Text\,t";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:9.0pt;
	margin-left:0in;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.Code, li.Code, div.Code
	{mso-style-name:"Code\,c";
	mso-style-parent:"";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:15.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.TextinList2, li.TextinList2, div.TextinList2
	{mso-style-name:"Text in List 2\,t2";
	mso-style-parent:"Text\,t";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.5in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.Label, li.Label, div.Label
	{mso-style-name:"Label\,l";
	mso-style-parent:"Text\,t";
	mso-style-next:"Text\,t";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;
	font-weight:bold;
	mso-bidi-font-weight:normal;}
p.NumberedList2, li.NumberedList2, div.NumberedList2
	{mso-style-name:"Numbered List 2\,nl2";
	mso-style-parent:"Text in List 2\,t2";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.5in;
	text-indent:-.25in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	mso-list:l1 level1 lfo2;
	tab-stops:list .5in;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.Syntax, li.Syntax, div.Syntax
	{mso-style-name:"Syntax\,s";
	mso-style-parent:"Code\,c";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:15.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.TableFootnote, li.TableFootnote, div.TableFootnote
	{mso-style-name:"Table Footnote\,tf";
	mso-style-parent:"Text\,t";
	mso-style-next:"Text\,t";
	margin-top:2.0pt;
	margin-right:0in;
	margin-bottom:4.0pt;
	margin-left:0in;
	line-height:11.0pt;
	mso-pagination:widow-orphan;
	border:none;
	mso-border-top-alt:solid windowtext .5pt;
	padding:0in;
	mso-padding-alt:1.0pt 0in 0in 0in;
	font-size:8.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.TableSpacingAfter, li.TableSpacingAfter, div.TableSpacingAfter
	{mso-style-name:"Table Spacing After\,tsa";
	mso-style-parent:"Text\,t";
	mso-style-next:"Text\,t";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:0in;
	margin-bottom:.0001pt;
	line-height:6.0pt;
	mso-pagination:widow-orphan;
	font-size:6.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:yellow;}
p.CodeinList2, li.CodeinList2, div.CodeinList2
	{mso-style-name:"Code in List 2\,c2";
	mso-style-parent:"Code\,c";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.5in;
	line-height:15.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.FigureinList2, li.FigureinList2, div.FigureinList2
	{mso-style-name:"Figure in List 2\,fig2";
	mso-style-parent:"Figure\,fig";
	mso-style-next:"Text in List 2\,t2";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:9.0pt;
	margin-left:.5in;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.FigureEmbedded, li.FigureEmbedded, div.FigureEmbedded
	{mso-style-name:"Figure Embedded\,fige";
	mso-style-parent:"Text\,t";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:9.0pt;
	margin-left:0in;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.TableFootnoteinList2, li.TableFootnoteinList2, div.TableFootnoteinList2
	{mso-style-name:"Table Footnote in List 2\,tf2";
	mso-style-parent:"Text in List 2\,t2";
	mso-style-next:"Text in List 2\,t2";
	margin-top:2.0pt;
	margin-right:0in;
	margin-bottom:4.0pt;
	margin-left:.5in;
	line-height:11.0pt;
	mso-pagination:widow-orphan;
	border:none;
	mso-border-top-alt:solid windowtext .5pt;
	padding:0in;
	mso-padding-alt:1.0pt 0in 0in 0in;
	font-size:8.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.TextinList1, li.TextinList1, div.TextinList1
	{mso-style-name:"Text in List 1\,t1";
	mso-style-parent:"Text\,t";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.25in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.CodeinList1, li.CodeinList1, div.CodeinList1
	{mso-style-name:"Code in List 1\,c1";
	mso-style-parent:"Code\,c";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.25in;
	line-height:15.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.FigureinList1, li.FigureinList1, div.FigureinList1
	{mso-style-name:"Figure in List 1\,fig1";
	mso-style-parent:"Figure\,fig";
	mso-style-next:"Text in List 1\,t1";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:9.0pt;
	margin-left:.25in;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.TableFootnoteinList1, li.TableFootnoteinList1, div.TableFootnoteinList1
	{mso-style-name:"Table Footnote in List 1\,tf1";
	mso-style-parent:"Text in List 1\,t1";
	mso-style-next:"Text in List 1\,t1";
	margin-top:2.0pt;
	margin-right:0in;
	margin-bottom:4.0pt;
	margin-left:.25in;
	line-height:11.0pt;
	mso-pagination:widow-orphan;
	border:none;
	mso-border-top-alt:solid windowtext .5pt;
	padding:0in;
	mso-padding-alt:1.0pt 0in 0in 0in;
	font-size:8.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.AlertText, li.AlertText, div.AlertText
	{mso-style-name:"Alert Text\,at";
	mso-style-parent:"Text\,t";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.25in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.AlertTextinList1, li.AlertTextinList1, div.AlertTextinList1
	{mso-style-name:"Alert Text in List 1\,at1";
	mso-style-parent:"Text in List 1\,t1";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.5in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.AlertTextinList2, li.AlertTextinList2, div.AlertTextinList2
	{mso-style-name:"Alert Text in List 2\,at2";
	mso-style-parent:"Text in List 2\,t2";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.75in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.RevisionHistory, li.RevisionHistory, div.RevisionHistory
	{mso-style-name:"Revision History\,rh";
	mso-style-parent:"Text\,t";
	margin-top:3.0pt;
	margin-right:1.0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:purple;
	display:none;
	mso-hide:all;
	font-style:italic;
	mso-bidi-font-style:normal;}
p.BulletedList1, li.BulletedList1, div.BulletedList1
	{mso-style-name:"Bulleted List 1\,bl1";
	mso-style-parent:"Text in List 1\,t1";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.25in;
	text-indent:-.25in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	mso-list:l0 level1 lfo4;
	tab-stops:.25in;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.TextIndented, li.TextIndented, div.TextIndented
	{mso-style-name:"Text Indented\,ti";
	mso-style-parent:"Text\,t";
	margin-top:3.0pt;
	margin-right:.25in;
	margin-bottom:3.0pt;
	margin-left:.25in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.BulletedList2, li.BulletedList2, div.BulletedList2
	{mso-style-name:"Bulleted List 2\,bl2";
	mso-style-parent:"Text in List 2\,t2";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.5in;
	text-indent:-.25in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	mso-list:l2 level1 lfo6;
	tab-stops:.5in;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.Definition, li.Definition, div.Definition
	{mso-style-name:"Definition\,d";
	mso-style-parent:"Text\,t";
	mso-style-next:"Defined Term\,dt";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.25in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.DefinedTerm, li.DefinedTerm, div.DefinedTerm
	{mso-style-name:"Defined Term\,dt";
	mso-style-parent:"Text\,t";
	mso-style-next:"Definition\,d";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:0in;
	margin-bottom:.0001pt;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.NumberedList1, li.NumberedList1, div.NumberedList1
	{mso-style-name:"Numbered List 1\,nl1";
	mso-style-parent:"Text in List 1\,t1";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.25in;
	text-indent:-.25in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	mso-list:l3 level1 lfo8;
	tab-stops:.25in;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.GlueLinkText, li.GlueLinkText, div.GlueLinkText
	{mso-style-name:"Glue Link Text\,glt";
	mso-style-parent:"Text\,t";
	mso-style-next:"Text\,t";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.IndexTag, li.IndexTag, div.IndexTag
	{mso-style-name:"Index Tag\,it";
	mso-style-parent:"Text\,t";
	margin-top:3.0pt;
	margin-right:1.0in;
	margin-bottom:0in;
	margin-left:0in;
	margin-bottom:.0001pt;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:olive;
	display:none;
	mso-hide:all;}
p.Copyright, li.Copyright, div.Copyright
	{mso-style-name:"Copyright\,copy";
	mso-style-parent:"Text\,t";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:11.0pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;}
p.PrintDivisionTitle, li.PrintDivisionTitle, div.PrintDivisionTitle
	{mso-style-name:"Print Division Title\,pdt";
	mso-style-parent:"";
	margin-top:9.0pt;
	margin-right:0in;
	margin-bottom:9.0pt;
	margin-left:0in;
	text-align:right;
	line-height:20.0pt;
	mso-pagination:widow-orphan;
	font-size:18.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:maroon;
	font-weight:bold;
	mso-bidi-font-weight:normal;}
p.PrintMSCorp, li.PrintMSCorp, div.PrintMSCorp
	{mso-style-name:"Print MS Corp\,pms";
	mso-style-parent:"";
	mso-style-next:"Text\,t";
	margin-top:9.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	text-align:right;
	line-height:15.0pt;
	mso-pagination:widow-orphan;
	font-size:13.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:"Microsoft Logo 95";
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:maroon;}
p.Slugline, li.Slugline, div.Slugline
	{mso-style-name:"Slugline\,slug";
	mso-style-parent:Footer;
	margin:0in;
	margin-bottom:.0001pt;
	line-height:9.0pt;
	mso-pagination:widow-orphan;
	mso-element:frame;
	mso-element-frame-height:40.0pt;
	mso-element-frame-hspace:9.0pt;
	mso-element-frame-vspace:9.0pt;
	mso-element-wrap:around;
	mso-element-anchor-vertical:page;
	mso-element-anchor-horizontal:margin;
	mso-element-top:730.05pt;
	font-size:6.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:maroon;}
p.MultilanguageMarkerExplicitBegin, li.MultilanguageMarkerExplicitBegin, div.MultilanguageMarkerExplicitBegin
	{mso-style-name:"Multilanguage Marker Explicit Begin\,mmeb";
	mso-style-parent:"Text\,t";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:11.0pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:fuchsia;}
p.MultilanguageMarkerExplicitEnd, li.MultilanguageMarkerExplicitEnd, div.MultilanguageMarkerExplicitEnd
	{mso-style-name:"Multilanguage Marker Explicit End\,mmee";
	mso-style-parent:"Multilanguage Marker Explicit Begin\,mmeb";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:11.0pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:purple;}
p.LabelSpecial, li.LabelSpecial, div.LabelSpecial
	{mso-style-name:"Label Special\,ls";
	mso-style-parent:"Label\,l";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;
	font-weight:bold;
	mso-bidi-font-weight:normal;}
p.PrintDivisionNumber, li.PrintDivisionNumber, div.PrintDivisionNumber
	{mso-style-name:"Print Division Number\,pdn";
	mso-style-parent:"Print Division Title\,pdt";
	margin-top:9.0pt;
	margin-right:-6.0pt;
	margin-bottom:0in;
	margin-left:0in;
	margin-bottom:.0001pt;
	text-align:right;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:maroon;
	text-transform:uppercase;
	letter-spacing:6.0pt;}
span.CodeEmbedded
	{mso-style-name:"Code Embedded\,ce";
	mso-ansi-font-size:10.0pt;
	mso-ascii-font-family:"Courier New";
	mso-hansi-font-family:"Courier New";}
span.LabelEmbedded
	{mso-style-name:"Label Embedded\,le";
	mso-ansi-font-size:10.0pt;
	mso-ascii-font-family:Verdana;
	mso-hansi-font-family:Verdana;
	mso-text-animation:none;
	font-weight:bold;
	text-decoration:none;
	text-underline:none;
	text-decoration:none;
	text-line-through:none;}
span.LinkText
	{mso-style-name:"Link Text\,lt";
	color:green;
	text-decoration:underline;
	text-underline:double;}
span.LinkTextPopup
	{mso-style-name:"Link Text Popup\,ltp";
	color:green;
	text-decoration:underline;
	text-underline:single;}
span.LinkID
	{mso-style-name:"Link ID\,lid";
	color:red;
	display:none;
	mso-hide:all;}
span.ConditionalMarker
	{mso-style-name:"Conditional Marker\,cm";
	mso-ansi-font-size:10.0pt;
	mso-ascii-font-family:"Courier New";
	mso-hansi-font-family:"Courier New";
	color:black;
	display:none;
	mso-hide:all;
	border:none windowtext 0in;
	padding:0in;
	background:#FFFFBF;
	mso-shading:windowtext;
	mso-pattern:gray-375 yellow;}
span.HTML
	{mso-style-name:HTML;
	mso-ansi-font-size:10.0pt;
	mso-ascii-font-family:"Courier New";
	mso-hansi-font-family:"Courier New";
	color:black;
	display:none;
	mso-hide:all;
	border:none windowtext 0in;
	padding:0in;
	background:#DDFFDD;
	mso-shading:windowtext;
	mso-pattern:gray-25 lime;}
span.CodeFeaturedElement
	{mso-style-name:"Code Featured Element\,cfe";
	mso-ansi-font-size:10.0pt;
	mso-ascii-font-family:"Courier New";
	mso-hansi-font-family:"Courier New";
	font-weight:bold;}
span.MultilanguageMarkerAuto
	{mso-style-name:"Multilanguage Marker Auto\,mma";
	mso-ansi-font-size:8.0pt;
	mso-ascii-font-family:Verdana;
	mso-hansi-font-family:Verdana;
	color:fuchsia;}
span.Bold
	{mso-style-name:"Bold\,b";
	font-weight:bold;}
span.BoldItalic
	{mso-style-name:"Bold Italic\,bi";
	font-weight:bold;
	font-style:italic;}
span.Italic
	{mso-style-name:"Italic\,i";
	font-style:italic;}
span.Strikethrough
	{mso-style-name:"Strikethrough\,strike";
	text-decoration:line-through;}
span.Subscript
	{mso-style-name:"Subscript\,sub";
	vertical-align:sub;}
span.Superscript
	{mso-style-name:"Superscript\,sup";
	vertical-align:super;}
p.LabelinList1, li.LabelinList1, div.LabelinList1
	{mso-style-name:"Label in List 1\,l1";
	mso-style-parent:"Text in List 1\,t1";
	mso-style-next:"Text in List 1\,t1";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.25in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;
	font-weight:bold;
	mso-bidi-font-weight:normal;}
p.LabelinList2, li.LabelinList2, div.LabelinList2
	{mso-style-name:"Label in List 2\,l2";
	mso-style-parent:"Text in List 2\,t2";
	mso-style-next:"Text in List 2\,t2";
	margin-top:3.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.5in;
	line-height:13.0pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Verdana;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";
	color:black;
	font-weight:bold;
	mso-bidi-font-weight:normal;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 70.5pt 1.0in 91.5pt;
	mso-header-margin:.75in;
	mso-footer-margin:.75in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
 /* List Definitions */
@list l0
	{mso-list-id:1161654485;
	mso-list-type:simple;
	mso-list-template-ids:520143332;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-style-link:Copyright;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.25in;
	mso-level-number-position:left;
	margin-left:.25in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1
	{mso-list-id:1809861688;
	mso-list-type:simple;
	mso-list-template-ids:1656119020;}
@list l1:level1
	{mso-level-style-link:"Numbered List 2";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2
	{mso-list-id:1892156636;
	mso-list-type:simple;
	mso-list-template-ids:2143072124;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-style-link:"Index 1";
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l3
	{mso-list-id:1908110580;
	mso-list-type:simple;
	mso-list-template-ids:-1994478282;}
@list l3:level1
	{mso-level-style-link:"Numbered List 1";
	mso-level-tab-stop:.25in;
	mso-level-number-position:left;
	margin-left:.25in;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=EN-US style="tab-interval: 5.0in">

<div class=Section1>

<h1 style="LINE-HEIGHT: 18pt; mso-line-height-rule: exactly">Telephony Server
Component</h1>

<p class=Text style="LINE-HEIGHT: 13pt; mso-line-height-rule: exactly">The Telephony Server component is a service module that provides access through an API to one or more Telephony Service Provider components. Using&nbsp; a TAPI (Telephony Application Programming Interface) 2.2 client or TAPI 3.1 client, this component supports the development of telephony communication applications on the Microsoft&reg; Windows&reg; platform&nbsp;.</p>

<h2 style="LINE-HEIGHT: 18pt; mso-line-height-rule: exactly"><span
 style="COLOR: black">Configuring the Component<o:p></o:p></span></h2><![if !supportEmptyParas]><![endif]><![if !supportEmptyParas]><![endif]><![if !supportEmptyParas]><![endif]><![if !supportEmptyParas]><![endif]><![if !supportEmptyParas]><![endif]><![if !supportEmptyParas]><![endif]><![if !supportEmptyParas]><![endif]><![if !supportEmptyParas]><![endif]><![if !supportEmptyParas]><![endif]><![if !supportEmptyParas]><![endif]><![if !supportEmptyParas]><![endif]><![if !supportEmptyParas]><![endif]>

<p class=Text style="LINE-HEIGHT: 13pt; mso-line-height-rule: exactly">There are no configurable requirements for this component.</p>

<h3 style="LINE-HEIGHT: 18pt; mso-line-height-rule: exactly"><span
 style="COLOR: black">Design 
Issues</span></h3>
<P class=Text style="LINE-HEIGHT: 13pt; mso-line-height-rule: exactly">Normally, 
you should also include one or more Telephony Service Provider components in 
order for this component to be useful. </P>
<p class=Text style="LINE-HEIGHT: 13pt; mso-line-height-rule: exactly">The TAPI 2.2 client API should be used with C applications, and the TAPI 3.1 API should be used with COM applications. </p><!-- Contact name: xzhang --></div> 

</body>

</html>]]></HELPCONTEXT>

        <PROPERTIES
          Context="1"
          PlatformGUID="{00000000-0000-0000-0000-000000000000}"
        >        </PROPERTIES>

        <RESOURCES
          Context="1"
          PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
        >
          <RESOURCE
            Name="File(819):&quot;%11%&quot;,&quot;tapisrv.dll&quot;"
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
              >tapisrv.dll</PROPERTY>

              <PROPERTY
                Name="SrcFileSize"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >0</PROPERTY>

              <PROPERTY
                Name="NoExpand"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >False</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>Tapisrv</DISPLAYNAME>

            <DESCRIPTION>TAPI Server</DESCRIPTION>
          </RESOURCE>

          <RESOURCE
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Telephony&quot;"
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
              >HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Telephony</PROPERTY>

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
            Name="RawDep(819):&quot;File&quot;,&quot;NTDLL.DLL&quot;"
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
              >NTDLL.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;MSVCRT.DLL&quot;"
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
              >MSVCRT.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;ADVAPI32.DLL&quot;"
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
              >ADVAPI32.DLL</PROPERTY>
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
            Name="RawDep(819):&quot;File&quot;,&quot;RPCRT4.DLL&quot;"
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
              >RPCRT4.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;USER32.DLL&quot;"
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
              >USER32.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;ACTIVEDS.DLL&quot;"
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
              >ACTIVEDS.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;OLE32.DLL&quot;"
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
              >OLE32.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;OLEAUT32.DLL&quot;"
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
              >OLEAUT32.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;SECUR32.DLL&quot;"
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
              >SECUR32.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;PSAPI.DLL&quot;"
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
              >PSAPI.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;RTUTILS.DLL&quot;"
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
              >RTUTILS.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;GDI32.DLL&quot;"
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
              >GDI32.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;ADSLDPC.DLL&quot;"
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
              >ADSLDPC.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;ATL.DLL&quot;"
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
              >ATL.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;NETAPI32.DLL&quot;"
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
              >NETAPI32.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;WLDAP32.DLL&quot;"
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
              >WLDAP32.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;IMAGEHLP.DLL&quot;"
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
              >IMAGEHLP.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RawDep(819):&quot;File&quot;,&quot;TSEC.DLL&quot;"
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
              >TSEC.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>

          <RESOURCE
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv&quot;,&quot;DependOnService&quot;"
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
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >DependOnService</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="Multi"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >50006C007500670050006C00610079000000520070006300530073000000</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >7</PROPERTY>

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
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv&quot;,&quot;Description&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="True"
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
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Description</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Provides Telephony API (TAPI) support for programs that control telephony devices and IP based voice connections on the local computer and, through the LAN, on servers that are also running the service.</PROPERTY>

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
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv&quot;,&quot;DisplayName&quot;"
            ResTypeVSGUID="{2C10DB69-39AB-48A4-A83F-9AB3ACBA7C45}"
            BuildTypeMask="819"
            BuildOrder="1000"
            Localize="True"
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
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >DisplayName</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Telephony</PROPERTY>

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
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv&quot;,&quot;ErrorControl&quot;"
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
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >ErrorControl</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >4</PROPERTY>

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
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv&quot;,&quot;ImagePath&quot;"
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
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >ImagePath</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%SystemRoot%\System32\svchost.exe -k tapisrv</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >2</PROPERTY>

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
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv&quot;,&quot;ObjectName&quot;"
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
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >ObjectName</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >LocalSystem</PROPERTY>

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
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv&quot;,&quot;Start&quot;"
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
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Start</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >2</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >4</PROPERTY>

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
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv&quot;,&quot;Type&quot;"
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
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Type</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >32</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >4</PROPERTY>

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
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv\Parameters&quot;,&quot;ServiceDll&quot;"
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
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv\Parameters</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >ServiceDll</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >%SystemRoot%\System32\tapisrv.dll</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >2</PROPERTY>

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
            Name="RegKey(819):&quot;HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv\Security&quot;,&quot;Security&quot;"
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
              >HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TapiSrv\Security</PROPERTY>

              <PROPERTY
                Name="ValueName"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >Security</PROPERTY>

              <PROPERTY
                Name="RegValue"
                Format="Binary"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >010014806C000000780000001400000034000000020020000100000002801800FF010F0001010000000000010000000020020000020038000200000000031800FF010F0001020000000000052000000020020000000318009D00000001020000000000052000000021020000010100000000000512000000010100000000000512000000</PROPERTY>

              <PROPERTY
                Name="RegType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >3</PROPERTY>

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
            Name="RawDep(819):&quot;File&quot;,&quot;VERSION.DLL&quot;"
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
              >VERSION.DLL</PROPERTY>
            </PROPERTIES>
          </RESOURCE>
        </RESOURCES>

        <GROUPMEMBERS
        >
          <GROUPMEMBER
            GroupVSGUID="{388249D2-1897-44ff-86F2-E159A27AA037}"
          ></GROUPMEMBER>
        </GROUPMEMBERS>

        <DEPENDENCIES
          Context="1"
          PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
        >        </DEPENDENCIES>

        <DISPLAYNAME>Telephony</DISPLAYNAME>

        <VERSION>1.0</VERSION>

        <DESCRIPTION>Telephony Components</DESCRIPTION>

        <COPYRIGHT>2000 Microsoft Corp.</COPYRIGHT>

        <VENDOR>Microsoft Corp.</VENDOR>

        <OWNERS>emanp</OWNERS>

        <AUTHORS>xzhang;elenaap</AUTHORS>

        <DATECREATED>7/14/2000</DATECREATED>

        <DATEREVISED>10/10/2001 7:52:41 AM</DATEREVISED>
      </COMPONENT>
    </COMPONENTS>

    <RESTYPES
      Context="1"
      PlatformGUID="{00000000-0000-0000-0000-000000000000}"
    >    </RESTYPES>
  </DCARRIER>
