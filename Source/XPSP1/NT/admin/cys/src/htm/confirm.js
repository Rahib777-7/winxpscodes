//**************************************    Localization variable    *****************************************************
var L_strInfo_Message			= "Your machine will be restarted once Terminal Services has been installed. ";
var L_DHCPWarningMsg_Message	= "Another server on this network is already running DHCP.  You cannot have more than one authorized DHCP server on a network.  Click OK to choose another role for this server. ";
var L_RestartMsg_Message 		= "During this installation, Configure Your Server restarts your computer. Before continuing, close any open programs. ";
var L_strAlertNoChanges_Message = "You have not selected any configuration options.\nNo changes will be made to this server. ";
//**************************************    Localization variable    *****************************************************

var srvWiz	= new ActiveXObject("ServerAdmin.ConfigureYourServer"); 
var oFS 	= new ActiveXObject("Scripting.FileSystemObject");		// create FileSystem object for log creation
var helpfile= "cys_topnode.htm";									// default helpfile link
var sysPath	= oFS.GetSpecialFolder(1);								// System folder
var strLog	= ""; 			// string initialization; to be appended to CYS Log File
var err		= false;

var bolPublishAllowed = noNull(getReg(SZ_PublishPolicy));  //If that value is present, and is set to 0, then publishing is disabled.
if (bolPublishAllowed == 0) bolPublishAllowed = false;
if (bolPublishAllowed == "") bolPublishAllowed = true;

function loadForm()
// --------------------------------------------------------------------------------------
// function performed at page load; load the values stored in oDataStore
// --------------------------------------------------------------------------------------
{
	// reset scroll area width & height
	divScr.style.width	= 350;	
	divScr.style.height	= 100;	
				
	divContent.load("oDataStore");
	var varInstall = divContent.getAttribute("P_install");
				
	switch(varInstall)		// Display appropriate text
	{
		case "firstServer":
				dispFirstServer();
				helpfile = "cys_configuring_first_server.htm";				
				break;
		case "dcOnly":
				dispDCOnly();
				helpfile = "cys_configuring_domain_controller.htm";
				break;
		case "clusterServer":
				dispClusterServer(); 
				helpfile = "cys_configuring_clustered_server.htm";
				break;		
		case "fileServer":
				dispFileServer(); 
				helpfile = "cys_configuring_file_server.htm";
				break;
		case "printServer":
				dispPrintServer(); 
				helpfile = "cys_configuring_print_server.htm";
				break;
		case "netWorkServer": 
				dispNetWorkServer();
				helpfile = "cys_configuring_networking_infrastructure.htm";
				break;
		case "webServer": 
				dispWebServer();
				helpfile = "cys_configuring_web_server.htm";
				break;					
		case "streamingMediaServer": 
				dispSteamingMediaServer();
				helpfile = "cys_configuring_streaming_media_server.htm";
				break;
		case "appServer": 
				dispAppServer();
				helpfile = "cys_configuring_application_server.htm";
				break;
		case "officeWebServer": 
				dispOfficeWebServer();
				helpfile = "cys_configuring_sharepoint_server.htm"; 
				break;
		default:
				dispFileServer();
				helpfile= "cys_topnode.htm";
				break;		
	}
	L_help_Button.onclick = displayHelp ;	// display help information if requested	
	document.all.L_finish_Button.focus();
}

function displayHelp()
// --------------------------------------------------------------------------------------
// used in loadForm() to display help information if requested
// --------------------------------------------------------------------------------------
{
	help('cys.chm::/' + helpfile);
}
	
function back()
// --------------------------------------------------------------------------------------
// process when click on BACK button (persist data and load previous page)
// --------------------------------------------------------------------------------------
{
	divContent.load("oDataStore");
	var varInstall = divContent.getAttribute("P_install");
	switch(varInstall)
	{
		case "firstServer":
			self.location.href="pass.htm"; break;
		case "dcOnly":
			self.location.href="server.htm"; break;
		case "appServer":
			var strSKU = srvWiz.GetProductSku();	// 3="Server";4="Advanced Server";5="Datacenter Server";1="Personal";2="Professional";
			if (strSKU > 3)
			{
				self.location.href=(getReg(SZ_TSApplicationMode)==1)?"member.htm":"app.htm"; 
			}
			else
			{
				self.location.href = "member.htm";
			}
			break;
		case "fileServer":
			var P_JumpIndex	= convertBol(noNull(divContent.getAttribute("P_JumpIndex")));
			if (P_JumpIndex)
			{
				var P_JumpNTFS	= convertBol(noNull(divContent.getAttribute("P_JumpNTFS")));
				strBackPage = (P_JumpNTFS)?"member.htm":"file2.htm";		
			}
			else
			{	
				strBackPage = "file3.htm";
			}	
			self.location.href = strBackPage; break;
		case "printServer": 
			self.location.href="print.htm"; break;
		case "officeWebServer":
			var IISInstalled = srvWiz.IsServiceInstalled("IIS");
		 	if (IISInstalled)
		 	{
				// calling the SPAskReplace method; returns true if a file default.htm exist in wwwroot
				var srvOWS	= new ActiveXObject("SpCyscom.SpCys");
				var changeHomePage	= srvOWS.SPAskReplace();		//alert (changeHomePage);	
				if (changeHomePage)	
				{
					self.location.href="owshome.htm";	// there was a homepage to replace, go to Change Home Page to SharePoint Home Page (owshome.htm)	
				}
				else
				{
					self.location.href="member.htm";	// no need to replace homepage, go back directly to member Page
				}
			}
			else
			{
				self.location.href="member.htm";	// no need to replace homepage, go back directly to member Page
			}
			break;	
		default:
			self.location.href="member.htm"; break;	
	}	
}
	
function next()
// --------------------------------------------------------------------------------------
// process when NEXT button clicked ; separation neccessary because of Finish<>Next
// --------------------------------------------------------------------------------------
{ finish(); }

function finish()
// --------------------------------------------------------------------------------------
// used in next() (when FINISH button is clicked)
// --------------------------------------------------------------------------------------
{		
	// Disable all buttons for configuration stage
	document.all.L_back_Button.disabled 	= true;
	document.all.L_finish_Button.disabled 	= true;
	document.all.L_cancel_Button.disabled 	= true;
	document.all.L_back_Button.style.cursor = "wait";
	document.all.L_finish_Button.style.cursor = "wait";
	document.all.L_cancel_Button.style.cursor = "wait";
	//document.all.divButtons.style.cursor 	= "wait";
	//document.all.divContent.style.cursor	= "wait";
	//document.all.divImg.style.cursor		= "wait";
	document.body.style.cursor = "wait";
			
	logEvent();													// Log event in nt event log (fct logEvent() last in confirm.js)
	divContent.load("oDataStore");								// load content of oDataStore
	var varInstall 	= divContent.getAttribute("P_install");		// which services to install
	var bolRunCYS	= form.cbRunCYS.checked;					// checkbox to restart CYS or no
	document.all.cbRunCYS.disabled 	= true;						// disable access to cbRunCYS checkbox
	var varSetupMsg	= "";
		
	switch(varInstall)			// proceed to desired path/installation 
	{
		case "firstServer":
			helpfile="cys_configuring_first_server.htm";
			if(!srvWiz.CheckDhcpServer())
			{
				varSetupMsg = vb_OkCancel(L_RestartMsg_Message);
				if(varSetupMsg) setUpFirstServer();
				else break
			}
			else
				showAlert(L_DHCPWarningMsg_Message);				
			break;
		case "dcOnly":
			helpfile="cys_configuring_domain_controller.htm";
			varSetupMsg = vb_OkCancel(L_RestartMsg_Message);
			if(varSetupMsg) setupDCOnly();
			else break
			break;
		case "clusterServer":
			helpfile="cys_configuring_clustered_server.htm"; 
			setUpClusterServer();
			break;	
		case "fileServer":
			helpfile="cys_configuring_file_server.htm";
			setupFileServer();
			break;
		case "printServer":
			helpfile="cys_configuring_print_server.htm";			
			setUpPrintServer();
			break;
		case "netWorkServer":
			helpfile="cys_configuring_networking_infrastructure.htm"; 
			setUpNetWorkServer();				
			break;
		case "webServer":
			helpfile="cys_configuring_web_server.htm"; 
			setUpWebServer();
			break;					
		case "streamingMediaServer":
			helpfile="cys_configuring_streaming_media_server.htm"; 
			setUpMediaServer();
			break;
		case "appServer":
			helpfile="cys_configuring_application_server.htm"; 
			setUpAppServer();
			break;
		case "officeWebServer":
			helpfile="cys_configuring_sharepoint_server.htm"; 
			setUpOfficeWebServer();
			break;

		default:
			break;		
	}
		
	// Enable all buttons
	document.all.L_back_Button.disabled			= false;
	document.all.L_cancel_Button.disabled		= false;
	document.all.L_back_Button.style.cursor		= "default";
	document.all.L_finish_Button.style.cursor	= "default";
	document.all.L_cancel_Button.style.cursor	= "default";
	//document.all.divButtons.style.cursor		= "default";
	//document.all.divContent.style.cursor		= "default";
	//document.all.divImg.style.cursor			= "default";
	document.body.style.cursor = "default";
		
	if((varInstall=="firstServer"||varInstall=="dcOnly"||varInstall=="terminalServer"||varInstall=="appServer")&&(varSetupMsg==true))
	{
		// disable buttons while processing DCPromo or TS
		document.all.L_back_Button.disabled = varSetupMsg;
		document.all.L_finish_Button.disabled = varSetupMsg;
		document.all.L_cancel_Button.disabled = varSetupMsg;		
	}
	else if(bolRunCYS)		// if user chooses to show CYS at restart
	{
		setReg2(SZ_ShowStartup,1)			// Set ShowStartup in case of a reboot.
		self.location.href="welcome.htm";	// Redirects in lieu of a reboot.  cys.hta will reset ShowStartup to FALSE
		divContent.removeAttribute("P_install"); // remove (clean) from oDataStore	
		divContent.save("oDataStore");			// save to oDataStore
		reset();								// actually clean entire oDataStore; reset() in util.js	
	}	
	else					// otherwise, simply close CYS and clean P_install
	{
		top.window.close();
		divContent.removeAttribute("P_install");
		divContent.save("oDataStore");		
	}			
}

function dispOfficeWebServer()
// --------------------------------------------------------------------------------------
// used in loadForm() to display info/settings for Office Web Server path
// --------------------------------------------------------------------------------------
{
	//**********************************    Localization variable    **************************************
	var L_OWSLine1_TEXT = "Install Internet Information Services (IIS)";
	var L_OWSLine2_TEXT = "Install SharePoint Team Services";
	var L_OWSLine3_TEXT = "Replace the server home page with the following team Web site: ";		// If user selected to replace home page
	var L_OWSLine4_TEXT = "Create the following team Web site: ";									// if user selected not to replace home page
	var L_OWSLine4b_TEXT = "Create the following team Web site as the server home page: ";			// If user is not given the option to replace the home page because
																									// no default home page has yet been configured for this server
	var L_OWSLine5_TEXT = "Add Microsoft SharePoint Administrator to the Start menu under Administrative Tools";
	var L_OWSLine6_TEXT = "Turn Indexing Service on";
	//**********************************    Localization variable    **************************************
	
	try 
	{
		var IISInstalled = srvWiz.IsServiceInstalled("IIS");
		
		span.innerHTML		+= "<UL COMPACT>";
		if (!IISInstalled) span.innerHTML	+= "<LI>" + L_OWSLine1_TEXT ;	// Internet Information Services (IIS)
	
		// find out if change home page accepted
		divContent.load("oDataStore");
		var P_OWSChangeHomePage = convertBol(divContent.getAttribute("P_OWSChangeHomePage"));
	
		span.innerHTML		+= "<LI>" + L_OWSLine2_TEXT ;					//Install SharePoint Team Services
	
		if (IISInstalled)
		{
			// find out the new URL
			var srvOWS	= new ActiveXObject("SpCyscom.SpCys");
			try 
			{	
				var OWSHomePage = srvOWS.SPNonDefaultHomePage();	
				
				// calling the SPAskReplace method; returns true if a file default.htm exist in wwwroot
				// to check if user was asked about page replacement
				var askToChangeHomePage	= srvOWS.SPAskReplace();					
			}
			catch(e)	{	var OWSHomePage = "";	}
		}
		else
		{	var OWSHomePage = "";	}
	
		if (P_OWSChangeHomePage)
		{		
			if (OWSHomePage != "") 
			{
				if (!askToChangeHomePage)		// If user is not given the option to replace the home page because no default home page has yet been configured for this server
				{
					span.innerHTML += "<LI>" + L_OWSLine4b_TEXT;		// Create the following team Web site as the server home page: <http://machinename>
					OWSHomePage = OWSHomePage.replace(/SharePoint.htm/g, "");
					span.innerHTML += "<P>&nbsp;&nbsp;&nbsp;&nbsp;" + OWSHomePage + "</P>";
				}
				else	// the user was asked and elected to replace the server home page
				{
					span.innerHTML += "<LI>" + L_OWSLine3_TEXT;					// Replace the server home page with the following team Web site:
					OWSHomePage = OWSHomePage.replace(/SharePoint.htm/g, "");	//  remove "SharePoint.htm" from the returned url string when the response was "yes, replace my homepage. "
					span.innerHTML += "<P>&nbsp;&nbsp;&nbsp;&nbsp;" + OWSHomePage + "</P>";
				}
			}
		}
		else	// the user was asked and elected not to replace
		{
			if (OWSHomePage != "") 
			{
				span.innerHTML += "<LI>" + L_OWSLine4_TEXT;			// Create the following team Web site:
				span.innerHTML += "<P>&nbsp;&nbsp;&nbsp;&nbsp;" + OWSHomePage + "</P>";
			}
		}
		span.innerHTML += "<LI>" + L_OWSLine5_TEXT;			// "Add Microsoft SharePoint Administrator to the Start menu under Administrative Tools" 

		//If indexing service is currently turned off, this line should also appear "Turn Indexing Service on"
		var objAdminIS 	= new ActiveXObject("Microsoft.ISAdm")
		if(!objAdminIS.IsRunning()) span.innerHTML += "<LI>" + L_OWSLine6_TEXT ;
		
		span.innerHTML += "</UL>";		
	}	
	catch(e)
	{
		var strError = e + "\n" + e.number + "\n" + e.description;
		alert(strError);
	}
}

function setUpOfficeWebServer()
// --------------------------------------------------------------------------------------
// used in loadForm() to install Office Web Server
// --------------------------------------------------------------------------------------
{
   //**********************************    Localization variable    **************************************	
	var L_strOWSLog1_TEXT = "Configurations for SharePoint Team Services";
	var L_strOWSLog2_TEXT = "The SharePoint Team Services component installed successfully. ";
	var L_strOWSLog3_TEXT = "Server home page replaced with team Web site: %1. ";		// If the server's home page was replaced
	var L_strOWSLog4_TEXT = "SharePoint team Web site created at %1. ";					// Also, if the server's home page was not replaced
	var L_strOWSLog4b_TEXT = "Server home page created at %1. ";						// If we created a new server default home page because one did not exist
	var L_strOWSLog5_TEXT = "Configure Your Server has encountered an error trying to install SharePoint Team Services. ";
	var L_strOWSLog6_TEXT = "  Setup files not found. ";
	var L_strOWSLog7_TEXT = "  The error reported was: %1 ";
	var L_strOWSLog8_TEXT = "Added Microsoft SharePoint Administrator to the Start menu under Administrative Tools. ";
	var L_strOWSLog9_TEXT = "IIS not installed. SharePoint Team Services installation aborted. ";
	var L_strOWSLog10_TEXT = "Indexing Service started. ";
	
	var L_strOWSSKU3_TEXT = "Windows Whistler Server CD-ROM";
	var L_strOWSSKU4_TEXT = "Windows Whistler Advanced Server CD-ROM";
	var L_strOWSSKU5_TEXT = "Windows Whistler Datacenter Server CD-ROM";
	var L_strOWSSKU6_TEXT = "Windows CD-ROM";
	//**********************************    Localization variable    **************************************	

	var strLocation = "";
	strLog = L_strOWSLog1_TEXT + "#";
	var IISInstalled = srvWiz.IsServiceInstalled("IIS");
	
	try
	{
		if (!IISInstalled)
		{
			setUpWebServer(1);
		}
	
		// call SPInstall(replaceHomepage, hardcoded path to setupse.exe)
		var P_OWSChangeHomePage = convertBol(divContent.getAttribute("P_OWSChangeHomePage"));
		
		if (srvWiz.IsServiceInstalled("IIS"))
		{		
			//If Indexing Service was turned on during this process, the log file should include "Indexing Service started. "
			var objAdminIS 	= new ActiveXObject("Microsoft.ISAdm")
			if(!objAdminIS.IsRunning()) var IndexSrvWasOff = true;
			
			var strSKU = srvWiz.GetProductSku();	// 3="Server";4="Advanced Server";5="Datacenter Server";1="Personal";2="Professional";
			switch (strSKU)
			{					
				case 3:			//- SERVER -
					strLocation	= L_strOWSSKU3_TEXT; break;				
				case 4:			//- ADVANCED SERVER -
					strLocation	= L_strOWSSKU4_TEXT; break;						
				case 5:			//- Data Center -
					strLocation	= L_strOWSSKU5_TEXT; break;						 
				default:		// - default case -
					strLocation	= L_strOWSSKU6_TEXT; break;	
			}
		
			// The SPInstall method of spcyscom starts the installation of OWS. This method it will look in
			// "HKLM\Software\Microsoft\Windows\CurrentVersion\Setup\" for SourcePath key and it will add 
			// "valueadd\ms\sharepoint\setupse.exe" to it; the method will call the command "setupse.exe /q /wait". 
			// If errors are returned, is returning any error strings that resulted from the install of SharePoint.
			var srvOWS	= new ActiveXObject("SpCyscom.SpCys");  // instantiate SP object
			var OWSResult = srvOWS.SPInstall(P_OWSChangeHomePage, strLocation);		//alert (OWSResult);
		
			if ((OWSResult=="")||(OWSResult==0))
			{
				if (OWSResult == "") 
				{
					strLog = L_strOWSLog2_TEXT + "#";	// The SharePoint Team Services installed successfully.
					strLog += L_strOWSLog8_TEXT + "#";	// Added Microsoft SharePoint Administrator to the Start menu under Administrative Tools.
				}

				// find out the new URL
				try 
				{
					var OWSHomePage = srvOWS.SPNonDefaultHomePage();	
					var askToChangeHomePage	= srvOWS.SPAskReplace();					// check if user was asked about page replacement
				}
				catch(e)	{	var OWSHomePage = "";	}
				
				if (P_OWSChangeHomePage)
				{	
					if (OWSHomePage != "") 
					{
						if (askToChangeHomePage)		// If user was given the option to replace the home page 
						{
							OWSHomePage = OWSHomePage.replace(/SharePoint.htm/g, "");			//  remove "SharePoint.htm" from the returned url string when the response was "yes, replace my homepage. "
							strLog += L_strOWSLog3_TEXT.replace(/%1/g, OWSHomePage);			// log the new homepage replaced
						}
						else		// If user is not given the option to replace the home page because no default home page has yet been configured for this server
						{
							strLog += L_strOWSLog4b_TEXT.replace(/%1/g, OWSHomePage);			// log the Team Site homepage created
						}					
					}
				}
				else	// the user was asked and elected not to replace
				{
					if (OWSHomePage != "") 
					{
						strLog += L_strOWSLog4_TEXT.replace(/%1/g, OWSHomePage);			// log the Team Site homepage created
					}					
				}
				
				//If Indexing Service was turned on during this process, the log file should include "Indexing Service started. "
				if(objAdminIS.IsRunning() && IndexSrvWasOff) strLog += "#" + L_strOWSLog10_TEXT;		
			}
			else
			{
				strLog += L_strOWSLog5_TEXT + "#";
				strLog += L_strOWSLog7_TEXT.replace(/%1/g, OWSResult) + "#";
			}
		}
		else
		{
			strLog += L_strOWSLog9_TEXT + "#";
			err = true;
		}
	}
	catch(e)
	{
		strLog += L_strOWSLog5_TEXT + "#";
		strLog += failLog(e, e.number, e.description);			// create the failure log entry error description
		if (e.number == -2147023570) strLog += L_strOWSLog6_TEXT;
		err=true;
	}
	
	//strLog += "#" + "Used SPInstall(" + P_OWSChangeHomePage + "," + strLocation + "). " + "#";
		
	var log = createLogFile(strLog);	// write the log file
	if(!err) openTasks();				// if no problem offer to user the help & log
	else failDialog();					// if problems display failure dialog
}
	
function dispFirstServer()
// --------------------------------------------------------------------------------------
// used in loadForm() to display info/settings for Express path
// --------------------------------------------------------------------------------------
{
	var DomainNetBiosName	= getReg(SZ_DomainNetBiosName);
	var DomainDNSName 		= getReg(SZ_DomainDNSName);
		
	divContent.load("oDataStore");
	var P_dc2=noNull(divContent.getAttribute("P_dc2"));
	var P_dc3=noNull(divContent.getAttribute("P_dc3"));
		
	if(P_dc2!="")
	{
		var arr_dc2 	= P_dc2.split(".");					
		var Subnets		= arr_dc2[0] + "." + arr_dc2[1] + "." + arr_dc2[2] + "." + arr_dc2[3];
		var SubnetMask	= arr_dc2[4] + "." + arr_dc2[5] + "." + arr_dc2[6] + "." + arr_dc2[7];
		var DNSServer	= arr_dc2[8] + "." + arr_dc2[9] + "." + arr_dc2[10] + "." + arr_dc2[11];
	}	
	else
	{
		var Subnets		= "192.168.16.2"; 
		var SubnetMask	= "255.255.255.0";
		var DNSServer	= "192.168.16.2"; 
	}
		
	if(P_dc3!="")
	{
		var arr_dc3 	= P_dc3.split(".");					
		var StartIP		= arr_dc3[0] + "." + arr_dc3[1] + "." + arr_dc3[2] + "." + arr_dc3[3];
		var EndIP		= arr_dc3[4] + "." + arr_dc3[5] + "." + arr_dc3[6] + "." + arr_dc3[7];
	}
	else
	{
		var StartIP		= "192.168.16.3"; 
		var EndIP		= "192.168.16.254"; 
	}
	
	//**********************************    Localization variable    **************************************
	var L_firstServerLine1_TEXT = "Install Active Directory, DNS, and DHCP";
	
	var L_firstServerLine2Part1_TEXT = "Create full domain name: %1";
	var firstServerLine2Part2 = DomainDNSName;				// do not try to localize
	var firstServerLine2 = L_firstServerLine2Part1_TEXT.replace(/%1/g, firstServerLine2Part2);
	
	var L_firstServerLine3Part1_TEXT = "Assign static IP address: %1";
	var firstServerLine3Part2 = Subnets;						// do not try to localize
	var firstServerLine3 = L_firstServerLine3Part1_TEXT.replace(/%1/g, firstServerLine3Part2);

	var L_firstServerLine4Part1_TEXT = "Assign subnet mask: %1";
	var firstServerLine4Part2 = SubnetMask;					// do not try to localize
	var firstServerLine4 = L_firstServerLine4Part1_TEXT.replace(/%1/g, firstServerLine4Part2);

	var L_firstServerLine5Part1_TEXT = "Assign preferred DNS server: %1";
	var firstServerLine5Part2 = DNSServer;					// do not try to localize
	var firstServerLine5 = L_firstServerLine5Part1_TEXT.replace(/%1/g, firstServerLine5Part2);
 
	var L_firstServerLine6Part1_TEXT = "Create DHCP scope: %1 - %2";
	var firstServerLine6Part2 = StartIP;
	var firstServerLine6Part3 = EndIP;		// do not try to localize
	var firstServerLine6 = L_firstServerLine6Part1_TEXT.replace(/%1/g, firstServerLine6Part2);
	firstServerLine6 = firstServerLine6.replace(/%2/g, firstServerLine6Part3);
	
	var L_firstServerLine7_TEXT = "Set up an Application Naming Context in Active Directory with DNS name mstapi.%1 on this domain controller for use by TAPI client applications";
	var firstServerLine7 = L_firstServerLine7_TEXT.replace(/%1/g, DomainDNSName);

	var L_firstServerLine8_TEXT = "This process might take several minutes and restarts your computer. ";
	//**********************************    Localization variable    **************************************
	
	span.innerHTML		+= "<UL COMPACT>"
	span.innerHTML		+= "<LI>" + L_firstServerLine1_TEXT ;
	span.innerHTML		+= "<LI>" + firstServerLine2 ;
	span.innerHTML		+= "<LI>" + firstServerLine3 ;
	span.innerHTML		+= "<LI>" + firstServerLine4 ;		
	span.innerHTML		+= "<LI>" + firstServerLine5 ;
	span.innerHTML		+= "<LI>" + firstServerLine6 ; 
	span.innerHTML		+= "<LI>" + firstServerLine7 + "</UL>";
	p3.innerHTML 	 = "<TABLE><TR><TD><IMG SRC='alert.gif' ALIGN='absmiddle'></TD><TD>" + L_firstServerLine8_TEXT + "</TD></TR></TABLE>";
	rowRestartCYS.style.visibility = "hidden";
}	
	
function setUpFirstServer()
// --------------------------------------------------------------------------------------
// used in finish() to process Express path
// --------------------------------------------------------------------------------------
{
	//**********************************    Localization variable    **************************************
	var L_firstServerLogLine1_TEXT = "Configurations for machine as Domain Controller";
	//**********************************    Localization variable    **************************************
	
	strLog = L_firstServerLogLine1_TEXT + "#";	
	divContent.load("oDataStore");
	var P_dc2				= noNull(divContent.getAttribute("P_dc2"));
	var P_dc3				= noNull(divContent.getAttribute("P_dc3"));
	var SafeModeAdminPass	= noNull(divContent.getAttribute("P_pass"));
	var DomainNetBiosName	= getReg(SZ_DomainNetBiosName);
	var DomainDNSName 		= getReg(SZ_DomainDNSName);	
	var strInf, strUnattend;
		
	if(P_dc2!="")
	{
		var arr_dc2 	= P_dc2.split(".");					
		var Subnets		= arr_dc2[0] + "." + arr_dc2[1] + "." + arr_dc2[2] + "." + arr_dc2[3];
		var SubnetMask	= arr_dc2[4] + "." + arr_dc2[5] + "." + arr_dc2[6] + "." + arr_dc2[7];
		var DNSServer	= arr_dc2[8] + "." + arr_dc2[9] + "." + arr_dc2[10] + "." + arr_dc2[11];
	}	
	else
	{
		var Subnets		= "192.168.16.2"; 
		var SubnetMask	= "255.255.255.0";
		var DNSServer	= "192.168.16.2"; 
	}
		
	if(P_dc3!="")
	{
		var arr_dc3 	= P_dc3.split(".");					
		var StartIP		= arr_dc3[0] + "." + arr_dc3[1] + "." + arr_dc3[2] + "." + arr_dc3[3];
		var EndIP		= arr_dc3[4] + "." + arr_dc3[5] + "." + arr_dc3[6] + "." + arr_dc3[7];
	}
	else
	{
		var StartIP		= "192.168.16.3"; 
		var EndIP		= "192.168.16.254"; 
	}
		
	strInf  = '[Version]\n';
	strInf 	+= 'Signature = "$Windows NT$"\n';
	strInf 	+= '[Components]\n';
	strInf 	+= 'NetOC=netoc.dll,NetOcSetupProc,netoc.inf\n';
	strInf 	+= '[Global]\n';
	strInf 	+= 'WindowTitle=Installing DHCP Server\n';  
	strInf 	+= '[Strings]\n';  
	strInf 	+= ';(empty)\n';     
		
	strUnattend 	= '[NetOptionalComponents]\n';
	strUnattend 	+= 'DHCPServer=1\n';
	strUnattend 	+= '[dhcpserver]\n';
	strUnattend 	+= 'Subnets=' + Subnets + '\n';
	strUnattend 	+= 'StartIp=' + StartIP + '\n';
	strUnattend 	+= 'EndIp=' + EndIP + '\n';
	strUnattend 	+= 'SubnetMask=' + SubnetMask + '\n';
	strUnattend 	+= 'LeaseDuration=874800\n';
	strUnattend 	+= 'DnsServer=' + DNSServer + '\n';
	strUnattend 	+= 'DomainName=' + DomainDNSName + '\n';
	
	//**********************************    Localization variable    **************************************
	var L_firstServerLogLine2_TEXT = 'Install Active Directory, DNS and DHCP';
	
	var L_firstServerLogLine3Part1_TEXT = 'Full domain name: %1';
	var firstServerLogLine3Part2 = DomainDNSName;		// do not try to localize
	var firstServerLogLine3 = L_firstServerLogLine3Part1_TEXT.replace(/%1/g, firstServerLogLine3Part2);
	
	var L_firstServerLogLine3bPart1_TEXT = 'NetBIOS domain name: %1';
	var firstServerLogLine3bPart2 = DomainNetBiosName;		// do not try to localize
	var firstServerLogLine3b = L_firstServerLogLine3bPart1_TEXT.replace(/%1/g, firstServerLogLine3bPart2);
	
	var L_firstServerLogLine4Part1_TEXT = 'Static IP address: %1';
	var firstServerLogLine4Part2 = Subnets;				// do not try to localize
	var firstServerLogLine4 = L_firstServerLogLine4Part1_TEXT.replace(/%1/g, firstServerLogLine4Part2);
		
	var L_firstServerLogLine5Part1_TEXT = 'Subnet mask: %1';
	var firstServerLogLine5Part2 = SubnetMask;			// do not try to localize
	var firstServerLogLine5 = L_firstServerLogLine5Part1_TEXT.replace(/%1/g, firstServerLogLine5Part2);
	
	var L_firstServerLogLine6Part1_TEXT = 'New DHCP scope: %1 - %2';
	var firstServerLogLine6Part2 = StartIP;
	var firstServerLogLine6Part3 = EndIP;			// do not try to localize
	var firstServerLogLine6 = L_firstServerLogLine6Part1_TEXT.replace(/%1/g, firstServerLogLine6Part2);
	firstServerLogLine6 = firstServerLogLine6.replace(/%2/g, firstServerLogLine6Part3);
	var L_firstServerLogLine6DHCPOk_TEXT = "DHCP installed successfully. ";
	var L_firstServerLogLine6DHCPFailed_TEXT = "DHCP could not be installed on this server. See Windows codename Whistler Help for more information. ";
	
	var L_firstServerLogDHCPDNSErr1_TEXT = "   Problems encountered creating DHCP DNS server option. ";
	var L_firstServerLogDHCPDNSErr2_TEXT = "   Problems encountered updating DHCP server with DNS information.  Please open the DHCP snap-in to set the DNS option manually. ";
	var L_firstServerLogDHCPDNSOk_TEXT   = "   Successfully updated DNS information in the DHCP Server. ";
	
	var L_firstServerLogDHCPScopeOk_TEXT = "DHCP Scope created successfully. ";
	var L_firstServerLogDHCPScopeFailed_TEXT = "A problem occurred during the creation of the DHCP scope. Please open the DHCP snap-in and follow the instructions to  run the New Scope wizard. ";
	var L_firstServerLogDHCPScopeErrLine1_TEXT = "   Problems encountered adding DHCP scope. ";
	var L_firstServerLogDHCPScopeErrLine2_TEXT = "   Problems encountered setting up DHCP IP range. ";
	var L_firstServerLogDHCPScopeErrLine3_TEXT = "   Problems encountered creating DHCP lease time option. ";
	var L_firstServerLogDHCPScopeErrLine4_TEXT = "   Problems encountered setting up DHCP lease time value. ";
			
	var L_firstServerLogLine8_TEXT = "Configure Your Server has encountered an error. ";	
	//**********************************    Localization variable    **************************************
				
	strLog	 = L_firstServerLogLine2_TEXT + '#';
	strLog	+= firstServerLogLine3 + '#';
	strLog	+= firstServerLogLine3b + '#';	
	strLog	+= firstServerLogLine4 + '#';	
	strLog	+= firstServerLogLine5 + '#';	
	strLog	+= firstServerLogLine6 + '#';	
				
	try
	{
		setReg(SZ_Home, "DCPromo");										// Show success/failure dialog at startup.
		setReg(SZ_FirstDC, 1);											// First DC - Express Path
		setReg2(SZ_ShowStartup, 1);										// Show CYS at startup
		setReg2(SZ_CYSMustRun, 1); 										// CYS must show at startup whatever the user before and after DC promo
		setReg(SZ_DomainDNSIP, DNSServer);								// Store DNS IP for DHCP Scope authorization
		srvWiz.SetStaticIpAddressAndSubNetMask(Subnets, SubnetMask);	// Set StaticIP and Subnet Mask
		
		var bolDHCPInstallResult = srvWiz.InstallService("DHCPFirstServer", strInf, strUnattend);	// Install DHCP Server

		if ((bolDHCPInstallResult)&&(srvWiz.IsServiceInstalled("DHCP")))		// If this succeeds, add a dhcp scope and set a lease time on it.
		{
			strLog += L_firstServerLogLine6DHCPOk_TEXT + '#';			// log entry "DHCP installed successfully. "
			
			// Create the DNS option, and set it globally. (This line has no variables.)
			var strDnsOption = "netsh dhcp server add optiondef 6 \"DNS Servers\" IPADDRESS 1";
			
			// Run this command, or log fail.
			rVal = ExecCmd(strDnsOption);
			if (rVal==1)
			{
				// If this succeeds, run the following.
				strDnsOption = "netsh dhcp server set optionvalue 6 IPADDRESS " + DNSServer;		// This line has one variable.
				
				rVal = ExecCmd(strDnsOption);	// Run this command, log success / fail.
				if (rVal==1)
				{
				   strLog += L_firstServerLogDHCPDNSOk_TEXT + '#';			// log success entry "Successfully updated DNS information in the DHCP Server."
				}
				else
				{
				   // Failure = "Problems encoutered updating DHCP server with DNS information.  Please set DNS option manually, using the DHCP snapin (Start -> Programs -> Administrative Tools -> DHCP), or by Start -> Run -> dhcpmgmt.msc."
				   strLog += L_firstServerLogDHCPDNSErr2_TEXT + '#';		// "Problems encoutered updating DHCP server with DNS information.  Please set DNS option manually. ";
				}				
			}
			else
			{
				// Failure = "Problems encountered creating DHCP DNS server option."
				strLog += L_firstServerLogDHCPDNSErr1_TEXT + '#';
			}
			
			// Whether or not the above two commands succeed, still create the scope below.			
			
			var scope1 = GetSubnet(StartIP, SubnetMask);
			var strDebugInfo = "Scope1 value = " + scope1 + '#';
			// *********************************** setting up a scope **********************************
			var strScopeConfigZero = "netsh dhcp server 127.0.0.1 add scope " + scope1 + " " + SubnetMask + "  Scope1";
			strDebugInfo += "   strScopeConfigZero = " + strScopeConfigZero + '#';
			rVal = ExecCmd(strScopeConfigZero);

			// check success/failure above
			if (rVal==1)
			{
				var strScopeConfigOne = "netsh dhcp server 127.0.0.1 scope " + scope1 + " add iprange " + StartIP + " " + EndIP + " both";
				strDebugInfo += "   strScopeConfigOne = " + strScopeConfigOne + '#';
				rVal = ExecCmd(strScopeConfigOne);
				if (rVal==1)
				{
					// *************************************setting up lease time *******************************
					var strOptionConfigZero = "netsh dhcp server 127.0.0.1 add optiondef 51 LeaseTime DWORD";
					strDebugInfo += "   strOptionConfigZero = " + strOptionConfigZero + '#';
					rVal = ExecCmd(strOptionConfigZero);
					if (rVal==1)
					{ 
						var strOptionConfigOne = "netsh dhcp server 127.0.0.1 scope " + scope1 + " set optionvalue 51 dword 874800";					
						strDebugInfo += "   strOptionConfigOne = " + strOptionConfigOne + '#';
						rVal = ExecCmd(strOptionConfigOne);
						if (rVal==1)
							{ strLog += L_firstServerLogDHCPScopeOk_TEXT + '#'; }			//"DHCP Scope created successfully. "
						else
							{ strDebugInfo += L_firstServerLogDHCPScopeErrLine4_TEXT + '#';}	//"Problems encountered setting up DHCP lease time value. "			
					}
					else
					{	strDebugInfo += L_firstServerLogDHCPScopeErrLine3_TEXT + '#';}			//"Problems encountered creating DHCP lease time option. "						
				}
				else
				{ strDebugInfo += L_firstServerLogDHCPScopeErrLine2_TEXT + '#';}				//"Problems encountered setting up DHCP IP range. "	
			}
			else
			{	strDebugInfo += L_firstServerLogDHCPScopeErrLine1_TEXT + '#';}					//"Problems encountered adding up DHCP scope. "
				
			if (rVal!=1)
			{
				strLog += L_firstServerLogDHCPScopeFailed_TEXT + '#';
				strLog += strDebugInfo + '#';
			}
		}
		else
		{
			strLog += L_firstServerLogLine6DHCPFailed_TEXT + '#';
		}
			
		var dcpromoInf 	= createDCAnswerFile(DomainNetBiosName,DomainDNSName,SafeModeAdminPass);	// Create dcpromo.inf in %systemroot%/system32/
		var dcpromo		= dcPromo();									// Call dcpromo.exe with answer file as arg
	} 
	catch(e)
	{	
		strLog += L_firstServerLogLine8_TEXT + '#';
		strLog += failLog(e, e.number, e.description);		// create the failure log entry error description
		setReg(SZ_Home, "DCPromo");
		err=true;
	}
	
	var log = createLogFile(strLog);				// write the log file
	if ((dcpromo!=1)||(err))	
	{
		failDialog();						//	*** This portion of script runs if user elects NOT    
											//      to reboot machine after DCPromo or problems occur *** //		
		self.location.href="welcome.htm";	// Redirects in lieu of a reboot.  cys.hta will reset ShowStartup to FALSE
		divContent.removeAttribute("P_install"); // remove (clean) from oDataStore	
		divContent.save("oDataStore");		// save to oDataStore
		reset();							// actually clean entire oDataStore; reset() in util.js	
	}
}

function dispDCOnly()
// --------------------------------------------------------------------------------------
// used in loadForm() to display DC member server path
// --------------------------------------------------------------------------------------
{
	//**********************************    Localization variable    **************************************
	//var L_DCOnlyLineTT1_TEXT = "Set up this server as a domain controller using the Active";
	//var L_DCOnlyLineTT2_TEXT = "Directory Installation Wizard";
	var L_DCOnlyLine1_TEXT = "Set up this server as a domain controller using the Active Directory Installation Wizard";
	
	//var L_DCOnlyLineTT3_TEXT = "The Active Directory Installation Wizard will start when you";
	//var L_DCOnlyLineTT4_TEXT = "click Finish. ";
	var L_DCOnlyLine3_TEXT = "The Active Directory Installation Wizard will start when you click Finish. ";
	//**********************************    Localization variable    **************************************
	
	//span.innerHTML += "<LI>" + L_DCOnlyLineTT1_TEXT + "<BR>&nbsp;&nbsp;&nbsp;&nbsp; " + L_DCOnlyLineTT2_TEXT + "<LI>" + L_DCOnlyLine5_TEXT;
	//p3.innerHTML = "<TABLE><TR><TD><IMG SRC='alert.gif' ALIGN='absmiddle'></TD><TD>" + L_DCOnlyLineTT3_TEXT + "<BR>" + L_DCOnlyLineTT4_TEXT + "</TD></TR></TABLE>";
	span.innerHTML += "<LI>" + L_DCOnlyLine1_TEXT;
	p3.innerHTML = "<TABLE><TR><TD><IMG SRC='alert.gif' ALIGN='absmiddle'></TD><TD>" + L_DCOnlyLine3_TEXT + "</TD></TR></TABLE>";
	rowRestartCYS.style.visibility = "hidden";
}
	
function setupDCOnly()
// --------------------------------------------------------------------------------------
// used in finish() to process DC member server path
// --------------------------------------------------------------------------------------
{
	//**********************************    Localization variable    **************************************
	var L_DCOnlyLogLine1_TEXT = 'Set up this server as a domain controller using the Active Directory Installation Wizard';
	var L_DCOnlyLogLine2_TEXT = "Configure Your Server has encountered an error. ";
	var L_DCOnlyLogLine3_TEXT = "Configure Your Server has encountered an error using the Active Directory Installation Wizard. The wizard was not completed successfully or was cancelled. ";
	var L_DCOnlyLogLine4_TEXT = "Configure Your Server completed successfully the Active Directory Installation Wizard, but the user choose not to reboot the machine. ";
	//**********************************    Localization variable    **************************************
	
	strLog	+= L_DCOnlyLogLine1_TEXT + '#';
	try
	{
		setReg(SZ_Home, "DCPromo"); 		// Show success/failure dialog at startup.
		setReg(SZ_FirstDC, 0);				// First DC - Custom member Path
		setReg2(SZ_ShowStartup, 1); 		// always show CYS at startup	
		setReg2(SZ_CYSMustRun, 1); 			// CYS must show at startup whatever the user before and after DC promo
				
		var dcpromo = srvWiz.CreateAndWaitForProcess("dcpromo.exe")	;
	}
	catch(e)
	{	
		strLog += L_DCOnlyLogLine2_TEXT + '#';
		strLog += failLog(e, e.number, e.description);		// create the failure log entry error description
		setReg(SZ_Home, "DCPromo");
		err=true;
	}
	
	if ((dcpromo!=1)||(err))	
	{
		//change CYS to detect that exit code, and log dcpromo successful completion, then close (a-cosio)
		if (dcpromo ==2)
		{
			strLog += L_DCOnlyLogLine4_TEXT + '#';		//"Configure Your Server completed successfully the Active Directory Installation Wizard, but the user choose not to reboot the machine."
		}
		else
		{	
			strLog += L_DCOnlyLogLine3_TEXT + '#';		//"Configure Your Server has encountered an error using the Active Directory Installation Wizard. The wizard was cancelled."
		}
		
		var log = createLogFile(strLog);	// write the log file
		failDialog();						//	*** This portion of script runs if user elects NOT    
											//      to reboot machine after DCPromo or problems occur *** //		
				
		divContent.removeAttribute("P_install"); // remove (clean) from oDataStore	
		divContent.save("oDataStore");		// save to oDataStore
		reset();							// actually clean entire oDataStore; reset() in util.js					
		top.window.close();					// simply close CYS and clean P_install	
	}	
} 
	
function dispFileServer()
// --------------------------------------------------------------------------------------
// used in loadForm() to display File server path
// --------------------------------------------------------------------------------------
{
	//**********************************    Localization variable    **************************************
	var L_FileLine3_TEXT = "Set default disk quotas";
	var L_FileLine4IxSrvOffTurnOn_TEXT = "Turn Indexing Service on";
	var L_FileLine4IxSrvOnTurnOff_TEXT = "Turn Indexing Service off";
	var L_FileLine4IxSrvOnLeaveOn_TEXT = "Leave Indexing Service on";
	var L_FileLine4IxSrvOffLeaveOff_TEXT = "Leave Indexing Service off";
	var L_FileLine0_TEXT = "No changes have been selected. ";
	//**********************************    Localization variable    **************************************
	
	// Disk Quotas
	divContent.load("oDataStore");
	var P_cb_file2		= noNull(divContent.getAttribute("P_cb_file2"));
	var P_txt_file2		= noNull(divContent.getAttribute("P_txt_file2"));
	var P_select_file2	= noNull(divContent.getAttribute("P_select_file2"));
	var P_JumpNTFS		= convertBol(noNull(divContent.getAttribute("P_JumpNTFS")));		
	var arrCB			= P_cb_file2.split(",");
	var bolDisk			= convertBol(arrCB[0]);
	if((bolDisk)&&(P_txt_file2!="")&&(P_select_file2!="")) span.innerHTML += "<LI> " + L_FileLine3_TEXT ;
	
	var P_JumpIndex	= convertBol(noNull(divContent.getAttribute("P_JumpIndex")));
	if (!P_JumpIndex)
	{	
		// Index Service
		// check user option - true if "No, turn/leave off" selected, false if "Yes, turn/leave on" selected
		var userOption = (convertBol(noNull(divContent.getAttribute("P_file3Index"))));	
	
		// check current status for Indexing Service
		var currentIxSrvStatus = false;
		var objAdminIS 	= new ActiveXObject("Microsoft.ISAdm")
		if(objAdminIS.IsRunning()) 	currentIxSrvStatus = true;		// Indexing Service already ON
	
		// compare if changes
		//if (currentIxSrvStatus && !userOption) span.innerHTML += "<LI>" + L_FileLine4IxSrvOnLeaveOn_TEXT;			// was ON, leaved ON (true&&!false)
		if (currentIxSrvStatus && !userOption) span.innerHTML += "";												// was ON, leaved ON (true&&!false)
		//else if (!currentIxSrvStatus && userOption) span.innerHTML += "<LI>" + L_FileLine4IxSrvOffLeaveOff_TEXT;	// was OFF, leaved OFF (!false&&true)
		else if (!currentIxSrvStatus && userOption) span.innerHTML += "";											// was OFF, leaved OFF (!false&&true)
		else if (currentIxSrvStatus && userOption) span.innerHTML += "<LI>" + L_FileLine4IxSrvOnTurnOff_TEXT;		// was ON, turned OFF (true&&true)
		else if (!currentIxSrvStatus && !userOption) span.innerHTML += "<LI>" + L_FileLine4IxSrvOffTurnOn_TEXT;	// was OFF, turned ON (!false&&!false)
	}
	
		// if nothing changed or selected
		if (((!bolDisk)&&(P_txt_file2 == ",")&&(P_select_file2 == "0,0"))||P_JumpNTFS||(!bolDisk)) var noDiskQuotasChanges = true;
		if (!currentIxSrvStatus == userOption) var wasOFFleavedOFF = true;
		if (currentIxSrvStatus == !userOption) var wasONleavedON = true;
		if (noDiskQuotasChanges && ((wasOFFleavedOFF||wasONleavedON)||P_JumpIndex))
		{	
			span.innerHTML += "<LI>" + L_FileLine0_TEXT;	
			wizMsg(L_strAlertNoChanges_Message);
		}	
}
	
function setupFileServer()
// --------------------------------------------------------------------------------------
// used in finish() to process File server path (create shared folders, disk quotas and indexing)
// --------------------------------------------------------------------------------------
{	
		//**********************************    Localization variable    **************************************
			var L_FileServerLogTitle_TEXT = "Configurations for File Server";
			var L_FileQuotasLogLine1_TEXT = "Set default disk quotas. ";
			var L_FileQuotasFailLogLine1_TEXT = 'Disk quota was not set.';
		//**********************************    Localization variable    **************************************

	divContent.load("oDataStore");	
	strLog += L_FileServerLogTitle_TEXT + "#";
	
	var noDiskQuotasChanges = false;	// assume that will be changes made for DiskQuotas	
	var noIndexSrvChanges = false;		// assume that will be changes made	for Indexing Service
	
	//***********************************************  Disk Quotas Creation ***************************************************
	var P_cb_file2		= noNull(divContent.getAttribute("P_cb_file2"));
	var P_txt_file2		= noNull(divContent.getAttribute("P_txt_file2"));
	var P_select_file2	= noNull(divContent.getAttribute("P_select_file2"));
			
	if((P_txt_file2!="")&&(P_select_file2!=""))
	{
		var arrCB		= P_cb_file2.split(",");
		var arrTxt		= P_txt_file2.split(",");
		var arrSelect	= P_select_file2.split(",");			
		var bolDisk		= convertBol(arrCB[0]);
			
		if(bolDisk)
		{
			strLog 	+= L_FileQuotasLogLine1_TEXT + "#";					
			for(i=0;i<arrSelect.length;i++)
			{
				switch(arrSelect[i])
				{
					case "1":
						arrSelect[i] = 1048576; break;
					case "2":
						arrSelect[i] = 1073741824; break;
					default:
						arrSelect[i] = 1024; break;
				}
			}			
			var defaultLimit		= parseInt(arrTxt[0]) * arrSelect[0];
			var defaultThreshold	= parseInt(arrTxt[1]) * arrSelect[1];		
			var denyDiskSpace		= (convertBol(arrCB[1]))?1:0;	
			var LogQuotaLimit		= (convertBol(arrCB[2]))?1:0;
			var LogQuotaThreshold	= (convertBol(arrCB[3]))?1:0;
			
			var oEnum			= new Enumerator(oFS.Drives);		
			for (;!oEnum.atEnd();oEnum.moveNext()){		
				var oDrv=oEnum.item();
				if((oDrv.IsReady)&&(oDrv.FileSystem=="NTFS")&&(oDrv.DriveType==2)){
					try{
						var volume 						= new ActiveXObject("Microsoft.DiskQuota.1")
						volume.Initialize(oDrv.DriveLetter + ":\\", true);
						volume.QuotaState 				= denyDiskSpace;
						volume.DefaultQuotaLimit 		= defaultLimit;
						volume.DefaultQuotaThreshold 	= defaultThreshold;
						volume.LogQuotaLimit  			= LogQuotaLimit;
						volume.LogQuotaThreshold 		= LogQuotaThreshold;
						
						//**********************************    Localization variable    **************************************
						var L_FileQuotasLogLine2Part1_TEXT = ' Disk quota set successfully on drive %1:\\.';
						var FileQuotasLogLine2Part2 = oDrv.DriveLetter		// do not try to localize
						var FileQuotasLogLine2 = L_FileQuotasLogLine2Part1_TEXT.replace(/%1/g, FileQuotasLogLine2Part2);
						
						var L_FileQuotasLogLine3Part1_TEXT = '   Disk space limited to %1 bytes.';
						var FileQuotasLogLine3Part2 = defaultLimit;				// do not try to localize
						var FileQuotasLogLine3 = L_FileQuotasLogLine3Part1_TEXT.replace(/%1/g, FileQuotasLogLine3Part2);
						
						var L_FileQuotasLogLine4Part1_TEXT = '   Warning level set to %1 bytes.';
						var FileQuotasLogLine4Part2 = defaultThreshold;			// do not try to localize
						var FileQuotasLogLine4 = L_FileQuotasLogLine4Part1_TEXT.replace(/%1/g, FileQuotasLogLine4Part2);
						
						var L_FileQuotasLogLine5DenySpaceYESPart1_TEXT = '   Disk space is denied to users exceeding disk space limit of %1 bytes.';
						var FileQuotasLogLine5DenySpaceYESPart2 = defaultLimit;	// do not try to localize
						var FileQuotasLogLine5DenySpaceYES = L_FileQuotasLogLine5DenySpaceYESPart1_TEXT.replace(/%1/g, FileQuotasLogLine5DenySpaceYESPart2);
						var L_FileQuotasLogLine5DenySpaceNo_TEXT = '   Disk space is not denied to users exceeding disk space limit.';
						
						var L_FileQuotasLogLine6_TEXT = '   When the user exceeds disk space limit an event will be logged.';
						var L_FileQuotasLogLine7_TEXT = '   When the user exceeds warning level an event will be logged.';
						//**********************************    Localization variable    **************************************	
						
						strLog += FileQuotasLogLine2 + '#';
						strLog += FileQuotasLogLine3 + '#';
						strLog += FileQuotasLogLine4 + '#';
						strLog += (denyDiskSpace? FileQuotasLogLine5DenySpaceYES + '#':L_FileQuotasLogLine5DenySpaceNo_TEXT + '#'); 
						strLog += (LogQuotaLimit?L_FileQuotasLogLine6_TEXT + '#':'');
						strLog += (LogQuotaThreshold?L_FileQuotasLogLine7_TEXT + '#':'');										
					}
					catch(e)
					{					
						strLog += L_FileQuotasFailLogLine1_TEXT + '#';
						strLog += failLog(e, e.number, e.description);		// create the failure log entry error description
						err=true;
					}
				}
			}	
		}
		else
		{
			var noDiskQuotasChanges = true;		// no changes made, not even tried, otherwise will keep the false value 
		}		
	}
	//************************************** Disk Quotas Creation Section End ****************************************************	
		
	//********************************* Stop/Start Indexing Service Section Start  ************************************************
	//**********************************    Localization variable    **************************************	
	var L_FileIndexLogLineStop_TEXT = "Indexing Services stopped. ";
	var L_FileIndexLogLineStart_TEXT = "Indexing Services started. ";
	var L_FileIndexFailLogLine1Stop_TEXT = "Indexing Services was not stopped. ";
	var L_FileIndexFailLogLine1Start_TEXT = "Indexing Services was not started. ";
	//**********************************    Localization variable    **************************************	

	var P_JumpIndex	= convertBol(noNull(divContent.getAttribute("P_JumpIndex")));
	if (!P_JumpIndex)
	{
		var stopIndexing=(convertBol(divContent.getAttribute("P_file3Index")))?true:false;
		if(stopIndexing)
		{
			try
			{
				var objAdminIS 	= new ActiveXObject("Microsoft.ISAdm")
				if(objAdminIS.IsRunning()) 	
				{
					objAdminIS.Stop();
					strLog 	+= L_FileIndexLogLineStop_TEXT + "#";
					showStatus();					// display progress indication
				}
				else 
				{
					noIndexSrvChanges = true;		// was off, leaved off, no change
				}
				
			}
			catch(e)
			{		
				strLog += L_FileIndexFailLogLine1Stop_TEXT + "#";
				strLog += failLog(e, e.number, e.description);		// create the failure log entry error description
				err=true;
			}	
		}	
		else
		{
			try
			{
				var objAdminIS 	= new ActiveXObject("Microsoft.ISAdm")
				if(!objAdminIS.IsRunning())
				{
					objAdminIS.Start();
					strLog 	+= L_FileIndexLogLineStart_TEXT + "#";
					showStatus();					// display progress indication
				}
				else 
				{
					noIndexSrvChanges = true;		// was on, leaved on, no change
				}
			}
			catch(e)
			{		
				strLog += L_FileIndexFailLogLine1Start_TEXT + "#";
				strLog += failLog(e, e.number, e.description);		// create the failure log entry error description
				err=true;
			}
		}
	}
	else
	{
		noIndexSrvChanges = true;		// no changes made, not even tried, otherwise will keep the false value
	}
	//********************************* Stop/Start Indexing Service Section End  ************************************************
	
	if (noDiskQuotasChanges && noIndexSrvChanges);		// if no changes, just go to welcome page 
	else
	{
		var log = createLogFile(strLog);	// write the log file
		if(!err) openTasks();							// if no problem offer to user the help & log
		else failDialog();									// if problems display failure dialog	
	}
}
	
function showStatus()
// --------------------------------------------------------------------------------------
// used in setupFileServer() to emulate a progress bar to display progress indication;
// --------------------------------------------------------------------------------------
{
	var x 			= ((((window.screen.width-636)/2)<0)?0:(window.screen.width-360)/2);
	var y 			= ((((window.screen.height-450)/2)<0)?0:(window.screen.height-240)/2);		 
	var sFeatures 	= "dialogHeight:90px;dialogLeft:" + x + ";dialogTop:" + y + ";dialogWidth:400px;help:no;status:no;"		
	window.showModalDialog("finish.htm","",sFeatures);	
}

function dispNetWorkServer()
// --------------------------------------------------------------------------------------
// used in loadForm() to display NetWork server path finish
// --------------------------------------------------------------------------------------
{
	//**********************************    Localization variable    **************************************	
	var L_strNetWorkSrvLine1_TEXT = "Install DHCP, and then start the New Scope Wizard";
	var L_strNetWorkSrvLine2_TEXT = "Install DNS, and then start the Configure a DNS Server Wizard";
	var L_strNetWorkSrvLine3_TEXT = "Install WINS";
	var L_strNetWorkSrvLine4_TEXT = "Start the Routing and Remote Access Server Setup Wizard";
	//**********************************    Localization variable    **************************************	
	
	divContent.load("oDataStore");
	var L_strMsg_TEXT	= "";
	var installDHCP	= convertBol(divContent.getAttribute("P_selectDHCP"));
	var installDNS	= convertBol(divContent.getAttribute("P_selectDNS"));
	var installWINS	= convertBol(divContent.getAttribute("P_selectWINS"));
	var installRRAS	= convertBol(divContent.getAttribute("P_selectRRAS"));
		
	if(installDHCP) L_strMsg_TEXT += "<LI>" + L_strNetWorkSrvLine1_TEXT;
	if(installDNS)  L_strMsg_TEXT += "<LI>" + L_strNetWorkSrvLine2_TEXT;
	if(installWINS) L_strMsg_TEXT += "<LI>" + L_strNetWorkSrvLine3_TEXT;
	if(installRRAS) L_strMsg_TEXT += "<LI>" + L_strNetWorkSrvLine4_TEXT;
	span.innerHTML += L_strMsg_TEXT ;
}
	
function setUpNetWorkServer()
// --------------------------------------------------------------------------------------
// used in finish() to setup Network server path 
// --------------------------------------------------------------------------------------
{
	//**********************************    Localization variable    **************************************	
	var L_strNetWorkSrvLog1_TEXT = "Install DHCP and start the New Scope Wizard";
	var L_strNetWorkSrvLog2DHCPFail_TEXT = "DHCP could not be installed on this server. See Windows codename Whistler Help for more information. ";
	var L_strNetWorkSrvLog3DHCPCfgYes_TEXT = "DHCP installed and the New Scope Wizard completed successfully. ";
	var L_strNetWorkSrvLog3DHCPCfgNo_TEXT = "DHCP installed successfully, but a problem occurred during the New Scope Wizard. Please open the DHCP snap-in and follow the instructions to run the wizard again. ";
	
	var L_strNetWorkSrvLog4_TEXT = "Install DNS and start the Configure DNS Server Wizard. ";
	var L_strNetWorkSrvLog5DNSFail_TEXT = "DNS could not be installed on this server. See Windows codename Whistler Help for more information. ";
	var L_strNetWorkSrvLog6DNSCfgYes_TEXT = "DNS installed and the Configure DNS Server Wizard completed successfully. ";
	var L_strNetWorkSrvLog6DNSCfgNo_TEXT = "DNS installed successfully, but a problem occurred during the Configure DNS Server Wizard. Please open the DNS snap-in and follow the instructions to run the wizard again. ";
	var L_strNetWorkSrvLog7DNSCfgNo_TEXT = "Error returned was: %1";
	var L_strNetWorkSrvLog8DNSCfgNo_TEXT = "The operation was cancelled by the user. ";

	var L_strNetWorkSrvLog7_TEXT = "Install WINS";
	var L_strNetWorkSrvLog8WINSSuccess_TEXT = "WINS installed successfully. ";
	var L_strNetWorkSrvLog8WINSFail_TEXT = "WINS could not be installed on this server. See Windows codename Whistler Help for more information. ";
	
	var L_strNetWorkSrvLog9_TEXT = "Start the Routing and Remote Access Server Setup Wizard. ";
	var L_strNetWorkSrvLog9RRASSuccess_TEXT = "The Routing and Remote Access Server Setup Wizard completed successfully. ";
	var L_strNetWorkSrvLog9RRASFail_TEXT = "A problem occurred during the Routing and Remote Access Server Setup Wizard. Please open the Routing and Remote Access snap-in and follow the instructions to run the wizard again. ";
	var L_strNetWorkSrvLog9RRASError_TEXT = "Configure Your Server has encountered an error executing RRAS Wizard:";	
	//**********************************    Localization variable    **************************************	
	
	divContent.load("oDataStore");		
	var installDHCP	= convertBol(divContent.getAttribute("P_selectDHCP"));
	var installDNS	= convertBol(divContent.getAttribute("P_selectDNS"));
	var installWINS	= convertBol(divContent.getAttribute("P_selectWINS"));
	var installRRAS	= convertBol(divContent.getAttribute("P_selectRRAS"));
	
	// not used ???...
	//var wizDNS 		= getReg(SZ_DNSConfig);
	//var wizRRAS		= getReg(SZ_RRASConfig);
	//var wizDHCP		= false;			
		
	if(installDHCP)		// ****************************** DHCP Installation *********************************************
	{
		// "Install DHCP and start the New Scope Wizard"
		strLog += L_strNetWorkSrvLog1_TEXT + '#';
		
		var strInf	= '[Version]\n';
			strInf	+= 'Signature = "$Windows NT$"\n';
			strInf	+= '[Components]\n';
			strInf	+= 'NetOC=netoc.dll,NetOcSetupProc,netoc.inf\n';
			strInf	+= '[Global]\n';
			strInf	+= 'WindowTitle=Windows Server Setup -- Installing DHCP Server\n';
			strInf	+= '[Strings]\n';
			strInf	+= ';(empty)';
				
		var strUnattend  = "[NetOptionalComponents]\nDHCPServer=1";
						
		try
		{
			var bolDHCPInstallResult = srvWiz.InstallService("DHCP", strInf, strUnattend);
			if ((bolDHCPInstallResult)&&(srvWiz.IsServiceInstalled("DHCP")))
			{
				strLog += srvWiz.ExecuteWizard("DHCP") + "#";				
			
				// "DHCP installed and the New Scope Wizard completed successfully. " OR
				// "DHCP installed successfully, but a problem occurred during the New Scope Wizard. Please open the DHCP snap-in and follow the instructions to run the wizard again. "
				strLog += (srvWiz.IsDhcpConfigured()) ? L_strNetWorkSrvLog3DHCPCfgYes_TEXT + "##" : L_strNetWorkSrvLog3DHCPCfgNo_TEXT + "##";
			}
			else
			{
				// "DHCP could not be installed on this server. See Windows codename Whistler Help for more information. "
				strLog += L_strNetWorkSrvLog2DHCPFail_TEXT + '#';
			}
		}
		catch(e){err=true;}		
	}
			
	if(installDNS)		// ****************************** DNS Installation *********************************************
	{
		strLog += L_strNetWorkSrvLog4_TEXT + '#';
		
		var strInf 	= '[Version]\n';
			strInf	+= 'Signature = "$Windows NT$"\n';
			strInf	+= '[Components]\n';
			strInf	+= 'NetOC=netoc.dll,NetOcSetupProc,netoc.inf\n';
			strInf	+= '[Global]\n';
			strInf	+= 'WindowTitle=Windows Server Setup -- Installing DNS Server\n';
			strInf	+= '[Strings]\n';
			strInf	+= ';(empty)';
				
		var strUnattend  = "[NetOptionalComponents]\nDNS=1";
			
		try
		{
			var bolDNSInstallResult = srvWiz.InstallService("DNS", strInf, strUnattend);
			if ((bolDNSInstallResult)&&(srvWiz.IsServiceInstalled("DNS")))
			{
				strLog += srvWiz.ExecuteWizard("DNS") + "#";
					
				// check "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion\\srvWiz\\DnsWizResult" reg key, set by Jones;
				var strDNSConfigResult = getReg(SZ_DNSConfig);	
								
				// check "HKLM\\SYSTEM\\CurrentControlSet\\Services\\DNS\\Parameters\\AdminConfigured", set by DNS;
				if (getReg(SZ_DNSConfig))				
				{
					// everything ok, "DNS installed and the Configure DNS Server Wizard completed successfully. "
					strLog 	+= L_strNetWorkSrvLog6DNSCfgYes_TEXT + "##";  
				}
				else
				{
					// "DNS installed successfully, but a problem occurred during the Configure DNS Server Wizard. Please open the DNS snap-in and follow the instructions to run the wizard again. ";
					strLog 	+= L_strNetWorkSrvLog6DNSCfgNo_TEXT + "#";
					
					// The cancel will be if the AdminConfigured flag is 0 and the DnsWizResult is blank. 
					if (strDNSConfigResult == "")	
					{
						// "The operation was cancelled by the user. "
						strLog 	+= L_strNetWorkSrvLog8DNSCfgNo_TEXT + "#";	
					}
					else
					{		
						// "Error returned was: " and add value put in \HKLM\...\srvWiz\\DnsWizResult" reg key, set by Jones
						strLog 	+= L_strNetWorkSrvLog7DNSCfgNo_TEXT.replace(/%1/g, strDNSConfigResult) + "##";					
					}
				}
			}
			else
			{
				// "DNS could not be installed on this server. See Windows codename Whistler Help for more information. "
				strLog 	+= L_strNetWorkSrvLog5DNSFail_TEXT + "##";							
			}
		}		
		catch(e){err=true;}
	}
		
	if(installWINS)		// ****************************** WINS Installation *********************************************
	{
		strLog += L_strNetWorkSrvLog7_TEXT + '#';
		
		var strInf	= '[Version]\n';
			strInf	+= 'Signature = "$Windows NT$"\n';
			strInf	+= '[Components]\n';
			strInf	+= 'NetOC=netoc.dll,NetOcSetupProc,netoc.inf\n';
			strInf	+= '[Global]\n';
			strInf	+= 'WindowTitle=Windows Server Setup -- Installing WINS Server\n';
			strInf	+= '[Strings]\n';
			strInf	+= ';(empty)';				
				
		var strUnattend  = "[NetOptionalComponents]\nWINS=1";
			
		try 
		{ 
			var bolWINSInstallResult = srvWiz.InstallService("WINS", strInf, strUnattend);
		}			
		catch(e) { err=true; }	
		
		if ((bolWINSInstallResult)&&(srvWiz.IsServiceInstalled("WINS")))
		{
			// "WINS installed successfully. "
			strLog += L_strNetWorkSrvLog8WINSSuccess_TEXT + "##";
		}
		else
		{
			// "WINS could not be installed on this server. See Windows codename Whistler Help for more information. "
			strLog += L_strNetWorkSrvLog8WINSFail_TEXT + "##";
		}					  
	}
			
	if(installRRAS)		// ****************************** RRAS Installation *********************************************
	{
		strLog += L_strNetWorkSrvLog9_TEXT + '#';
		try { strLog += srvWiz.ExecuteWizard("RRAS") + "#";	}
		catch(e)
		{			
			err=true;
			strLog += L_strNetWorkSrvLog9RRASError_TEXT + '\n';
			strLog += failLog(e, e.number, e.description);			// create the failure log entry error description
		}		
			
		strLog += (srvWiz.IsServiceInstalled("RRAS")) ? L_strNetWorkSrvLog9RRASSuccess_TEXT + "##": L_strNetWorkSrvLog9RRASFail_TEXT + "##";
	}
	var log = createLogFile(strLog);	// write the log file
	if(!err) openTasks();				// if no problem offer to user the help & log
	else failDialog();					// if problems display failure dialog
}
		
function dispPrintServer()
// --------------------------------------------------------------------------------------
// used in loadForm() to display Print server path finish
// --------------------------------------------------------------------------------------
{
	divContent.load("oDataStore");
	var P_printer	= (divContent.getAttribute("P_printer")==null)?0:parseInt(divContent.getAttribute("P_printer"));
		
	//**********************************    Localization variable    **************************************	
	var L_strAddPrinter_TEXT 		= "<LI>Add printers to this server using the Add Printer Wizard";
	var L_strAddPrintDrivers_TEXT 	= "<LI>Add printer drivers to this server using the Add Printer Driver <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Wizard";
	//**********************************    Localization variable    **************************************	
		
	switch(P_printer)
	{
		case 2:
			span.innerHTML = L_strAddPrinter_TEXT + L_strAddPrintDrivers_TEXT; break; 		//DCR: p3.innerHTML  = "<TABLE><TR><TD><IMG SRC='alert.gif' ALIGN='absmiddle'></TD><TD>The Add Printer Wizard and the Add Printer Driver Wizard will start after you click Finish.</TD></TR></TABLE>";
		default:
			span.innerHTML = L_strAddPrinter_TEXT; break;		//DCR: p3.innerHTML  = "<TABLE><TR><TD><IMG SRC='alert.gif' ALIGN='absmiddle'></TD><TD>The Add Printer Wizard will start after you click Finish.</TD></TR></TABLE>";						 
	}	
}
	
function setUpPrintServer()
// --------------------------------------------------------------------------------------
// used in finish() to setup Printer server path 
// --------------------------------------------------------------------------------------
{
	//**********************************    Localization variable    **************************************	
	var L_strPrintSrvLog1_TEXT = "Configurations for Print Server#";
	var L_strPrintSrvLog2_TEXT = "Printers and drivers for both Windows codename Whistler and non-Windows codename Whistler clients.#";
	var L_strPrintSrvLog3_TEXT = "Install printers and drivers for Windows codename Whistler clients.#";
	var L_strPrintSrvLog4_TEXT = "Configure Your Server has encountered an error trying to install printers.#";
	//**********************************    Localization variable    **************************************	
	
	var strLog = L_strPrintSrvLog1_TEXT;
	divContent.load("oDataStore");
	var P_printer	= (divContent.getAttribute("P_printer")==null)?0:parseInt(divContent.getAttribute("P_printer"));
	
	try
	{
		switch(P_printer)
		{
			case 2:
				strLog += L_strPrintSrvLog2_TEXT;
				strLog += srvWiz.ExecuteWizard("AddPrinter") + "#";
				strLog += srvWiz.ExecuteWizard("AddPrinterDriver") + "#";
				break;
			default:
				strLog += L_strPrintSrvLog3_TEXT;
				strLog += srvWiz.ExecuteWizard("AddPrinter") + "#";
				break;				 
		}	
	}
	catch(e)
	{
		strLog += L_strPrintSrvLog4_TEXT;
		strLog += failLog(e, e.number, e.description);			// create the failure log entry error description
		err=true;
	}	
	var log = createLogFile(strLog);	// write the log file
	if(!err) openTasks();				// if no problem offer to user the help & log
	else failDialog();					// if problems display failure dialog
}	

function dispWebServer()
// --------------------------------------------------------------------------------------
// used in loadForm() to display Print server path finish
// --------------------------------------------------------------------------------------
{
	var L_strWebSrvLine1_TEXT = "Install Internet Information Services (IIS)";		//*********    Localization variable    *************	
	span.innerHTML	+= "<LI>" + L_strWebSrvLine1_TEXT;
}
	
function setUpWebServer(varPath)
// --------------------------------------------------------------------------------------
// used in finish() to setup WEB server path 
// --------------------------------------------------------------------------------------
{
	//**********************************    Localization variable    **************************************	
	var L_strWebSrvLog1_TEXT = "Configurations for Web Server";
	var L_strIISOWSLog1_TEXT = "Configurations for SharePoint";
	
	var L_strWebSrvLog3Error_TEXT = "Configure Your Server has encountered an error trying to install IIS. ";
	var L_strWebSrvLog3InstalledOk_TEXT = "installed successfully. ";
	var L_strWebSrvLog3InstalledNo_TEXT = "could not be installed on this server. Please run the Configure Your Server Wizard again or see Windows codename Whistler Help for more information. ";
	//**********************************    Localization variable    **************************************	

	strLog = (varPath!=1)?(L_strWebSrvLog1_TEXT + "#"):(L_strIISOWSLog1_TEXT + "#"); 
	
	var strUnattend   = '[Components]\n';
		strUnattend  += 'iis_common=ON\n'; 
		strUnattend  += 'iis_inetmgr=ON\n'; 
		strUnattend  += 'iis_www=ON\n'; 
		strUnattend  += 'iis_doc=ON\n'; 
		strUnattend  += 'iis_htmla=ON\n'; 
		strUnattend  += 'iis_www_vdir_msadc=ON\n';  
		strUnattend  += 'iis_www_vdir_scripts=ON\n';  
		strUnattend  += 'iis_www_vdir_printers=ON\n';  
		strUnattend  += 'iis_smtp=ON\n';  
		strUnattend  += 'iis_smtp_docs=ON\n';  
		strUnattend  += 'fp_extensions=ON\n';  
				
	try	{	var bolIISInstallResult = srvWiz.InstallService("IIS", "", strUnattend);	}
	catch(e)
	{
		strLog += L_strWebSrvLog3Error_TEXT + "#";
		strLog += failLog(e, e.number, e.description);			// create the failure log entry error description
		err=true;
	}
	
	if ((bolIISInstallResult)&&(srvWiz.IsServiceInstalled("IIS")))
	{
		// "IIS installed successfully. "
		var strInstalled = L_strWebSrvLog3InstalledOk_TEXT; 
	}
	else
	{
		// "IIS could not be installed on this server. Please run the Configure Your Server Wizard again or see Windows codename Whistler Help for more information. "
		var strInstalled = L_strWebSrvLog3InstalledNo_TEXT;
	}	
	
	//**********************************    Localization variable    **************************************	
	var L_strWebSrvLog3Part1_TEXT = "IIS %1";
	var strWebSrvLog3Part2 = strInstalled;		// do not try to localize
	var strWebSrvLog3 = L_strWebSrvLog3Part1_TEXT.replace(/%1/g, strWebSrvLog3Part2);
	//**********************************    Localization variable    **************************************	
	
	strLog += strWebSrvLog3 + "#";
	
	var log = createLogFile(strLog);						// write the log file
	if (varPath!=1)
	{
		if(srvWiz.IsServiceInstalled("IIS")) openTasks();		// if no problem offer to user the help & log
		else failDialog();										// if problems display failure dialog
	}
}

function dispSteamingMediaServer()
// --------------------------------------------------------------------------------------
// used in loadForm() to display Media server path finish
// --------------------------------------------------------------------------------------
{
	var L_strMediaSrvLine1_TEXT = "Install Windows Media Services";		//*********    Localization variable    *************
	span.innerHTML		+= "<LI>" + L_strMediaSrvLine1_TEXT;
}
	
function setUpMediaServer()
// --------------------------------------------------------------------------------------
// used in finish() to setup Media server path 
// --------------------------------------------------------------------------------------
{
	//**********************************    Localization variable    **************************************
	var L_strMediaSrvLog1_TEXT = "Configurations for Streaming Media Server";
	var L_strMediaSrvLog2Error_TEXT = "Configure Your Server has encountered an error trying to install Windows Media Services. ";	
	var L_strMediaSrvLog3InstalledOk_TEXT = "installed successfully. ";
	var L_strMediaSrvLog3InstalledNo_TEXT = "could not be installed on this server. Please run the Configure Your Server Wizard again or see Whistler Help for more information. ";
	//**********************************    Localization variable    **************************************	
		
	strLog = L_strMediaSrvLog1_TEXT + "#"; 
	var strUnattend  = "[components]\nWMS=ON\nWMS_Admin=ON\nWMS_SERVER=ON";		
	
	try	
	{ 
		var bolStreamMediaInstallResult = srvWiz.InstallService("StreamingMedia", "", strUnattend);
	}
	catch(e)
	{
		strLog += L_strMediaSrvLog2Error_TEXT + "#";
		strLog += failLog(e, e.number, e.description);			// create the failure log entry error description
		err=true;
	}
	
	if ((bolStreamMediaInstallResult)&&(srvWiz.IsServiceInstalled("StreamingMedia")))
	{
		// "Streaming Media Server installed successfully. "
		var varInstalled = L_strMediaSrvLog3InstalledOk_TEXT; 
	}
	else
	{
		// "Streaming Media Server could not be installed on this server. Please run the Configure Your Server Wizard again or see Windows codename Whistler Help for more information. "
		var varInstalled = L_strMediaSrvLog3InstalledNo_TEXT;
	}	
	
	//**********************************    Localization variable    **************************************
	var L_strMediaSrvLog3Part1_TEXT = "Windows Media Services %1";
	var strMediaSrvLog3Part2 = varInstalled;		// do not try to localize
	var strMediaSrvLog3 = L_strMediaSrvLog3Part1_TEXT.replace(/%1/g, strMediaSrvLog3Part2);
	//**********************************    Localization variable    **************************************	
		
	strLog += strMediaSrvLog3 + "#";
	
	var log = createLogFile(strLog);						// write the log file
	if(srvWiz.IsServiceInstalled("StreamingMedia")) openTasks();	// if no problem offer to user the help & log
	else failDialog();												// if problems display failure dialog
}

function dispAppServer()
// --------------------------------------------------------------------------------------
// used in loadForm() to display Application server path finish
// --------------------------------------------------------------------------------------
{
	//**********************************    Localization variable    **************************************
	var L_strAppSrvLine1_TEXT = "Optimize this server for applications";
	var L_strAppSrvLine2_TEXT = "Install Terminal Server";
	var L_strAppSrvLine3_TEXT = "No changes have been selected";
	//**********************************    Localization variable    **************************************
	
	
	divContent.load("oDataStore");	
	var strMsg = "";
	if ((getReg(SZ_AppServerSize)!=3)||(getReg(SZ_AppServerCache)!=0)) strMsg = "<LI>" + L_strAppSrvLine1_TEXT + "<BR>";
	
	if (convertBol(divContent.getAttribute("P_TSAppMode"))) 
	{
		rowRestartCYS.style.visibility = "hidden";
		strMsg += "<LI>" + L_strAppSrvLine2_TEXT ;
	}
	else strMsg += "";
	
	if (strMsg == "") 
	{
		strMsg = "<LI>" + L_strAppSrvLine3_TEXT + "<BR>";
		wizMsg(L_strAlertNoChanges_Message);
		L_finish_Button.onclick = FinishApp;
	}
	span.innerHTML += strMsg;
}

function FinishApp()
// --------------------------------------------------------------------------------------
// used in dispAppServer() to finalize Application server path without changes
// --------------------------------------------------------------------------------------
{
	if(form.cbRunCYS.checked)		// if user chooses to show CYS at restart
	{
		self.location.href="welcome.htm";	// Redirects in lieu of a reboot.  cys.hta will reset ShowStartup to FALSE					
	}	
	else				// otherwise, simply close CYS and clean P_install
	{
		top.window.close();	
	}			
	divContent.removeAttribute("P_install"); // remove (clean) from oDataStore	
	divContent.save("oDataStore");			// save to oDataStore
	reset();
}
	
function setUpAppServer()
// --------------------------------------------------------------------------------------
// used in finish() to setup Application server path 
// --------------------------------------------------------------------------------------
{
	//**********************************    Localization variable    **************************************
	var L_strAppSrvLog1_TEXT = "Configurations for Application Server";
	var L_strAppSrvLog2_TEXT = "This server is optimized for applications. ";
	var L_strAppSrvLog2Error_TEXT = "Configure Your Server has encountered an error trying to optimize the performance of the server. ";	
	var L_strAppSrvLog3Error_TEXT = "This server is not optimized for applications. ";
	var L_strAppSrvLog4Error_TEXT = "Terminal Server installation aborted. ";
	//**********************************    Localization variable    **************************************	
	
	strLog 	= L_strAppSrvLog1_TEXT + "#";
	try
	{
		if ((getReg(SZ_AppServerSize)!=3)||(getReg(SZ_AppServerCache)!=0))
		{
			setReg2(SZ_AppServerSize, 3);
			setReg2(SZ_AppServerCache, 0);			
			strLog 	+= L_strAppSrvLog2_TEXT + "#";
		}
	}
	catch(e)
	{
		strLog += L_strAppSrvLog2Error_TEXT + "#";
		strLog += failLog(e, e.number, e.description);			// create the failure log entry error description
		strLog += L_strAppSrvLog3Error_TEXT + "#";
		err=true;
	}
	
	// Terminal Services in Application mode
	divContent.load("oDataStore");		
	var P_TSAppMode = convertBol(divContent.getAttribute("P_TSAppMode"));
	if(P_TSAppMode)
	{
		varSetupMsg = vb_OkCancel(L_RestartMsg_Message);
		if(varSetupMsg) 
		{
			if (setUpTerminalServer())
			{
					top.window.close();					// OCManager will reboot machine
					return false;
			}				
		}
		else strLog += L_strAppSrvLog4Error_TEXT + "#";
	}
	var log = createLogFile(strLog);
	if(getReg(SZ_AppServerSize)==3)		// write the log file
	{
		if((P_TSAppMode&&(getReg(SZ_AppServerCache)==0)&&(getReg(SZ_TSApplicationMode)==1))||(!P_TSAppMode))
		{		
			openTasks();		// if no problem offer to user the help & log
			
			if(form.cbRunCYS.checked)		// if user chooses to show CYS at restart
			{
				setReg2(SZ_ShowStartup,1)			// Set ShowStartup in case of a reboot.
				self.location.href="welcome.htm";	// Redirects in lieu of a reboot.  cys.hta will reset ShowStartup to FALSE					
			}	
			else				// otherwise, simply close CYS and clean P_install
			{
				top.window.close();	
			}			
			divContent.removeAttribute("P_install"); // remove (clean) from oDataStore	
			divContent.save("oDataStore");			// save to oDataStore
			reset();								// actually clean entire oDataStore; reset() in util.js
			
		}
		else 
		{
			failDialog();						// if problems display failure dialog
		}
	}
	else 
	{
		failDialog();							// if problems display failure dialog
	}
}

function setUpTerminalServer()
// --------------------------------------------------------------------------------------
// used in setUpAppServer() to setup Terminal server  
// --------------------------------------------------------------------------------------
{
	//**********************************    Localization variable    **************************************
	var L_strTSSrvLog1_TEXT = "Configurations for Application Server";
	var L_strTSSrvLog2Error_TEXT = "Configure Your Server has encountered an error trying to install Terminal Server. ";
	var L_strTSSrvLog3InstalledOk_TEXT = "installed successfully. ";
	var L_strTSSrvLog3InstalledNo_TEXT = "could not be installed on this server. Please run the Configure Your Server Wizard again or see Windows codename Whistler Help for more information. ";
	//**********************************    Localization variable    **************************************	

	setReg2(SZ_ShowStartup,1); 				// Show CYS at startup
	setReg2(SZ_CYSMustRun, 1);				// CYS must show at startup whatever the user before and after 
	
	strUnattend  = '[Components]\n';
	strUnattend += 'TerminalServer=ON';
	
	try
	{
		setReg(SZ_Home, "terminalServer"); 	// Check for TS success/failure dialog at startup.
		var bolTSInstallResult = srvWiz.InstallService("TerminalServices", "", strUnattend);
		return true;
	}
	catch(e)
	{
		strLog 	= L_strTSSrvLog1_TEXT + "#";
		strLog += L_strTSSrvLog2Error_TEXT + "#";
		strLog += failLog(e, e.number, e.description);		// create the failure log entry error description
		setReg(SZ_Home, "terminalServer"); 					// Show success/failure dialog at startup.		
		var log = createLogFile(strLog);
		err=true;
		return false;
	}
}	


function dispClusterServer()
// --------------------------------------------------------------------------------------
// UNused in loadForm() to display Clustering server path finish
// --------------------------------------------------------------------------------------
{
	var L_strClusterSrvLine1_TEXT = "Install Cluster Service";		//*********    Localization variable    *************
	span.innerHTML += "<LI>" + L_strClusterSrvLine1_TEXT;
}
	

function setUpClusterServer()
// --------------------------------------------------------------------------------------
// UNused in finish() to setup Clustering server path finish
// --------------------------------------------------------------------------------------
{
	//**********************************    Localization variable    **************************************
	var L_strClusterSrvLog1_TEXT = "Configurations for Clustering";
	var L_strClusterSrvLog2Error_TEXT = "Configure Your Server has encountered an error trying to install Clustering. ";	
	var L_strClusterSrvLog3InstalledOk_TEXT = "installed successfully. ";
	var L_strClusterSrvLog3InstalledNo_TEXT = "could not be installed on this server. Please run the Configure Your Server Wizard again or see Windows codename Whistler Help for more information. ";
	//**********************************    Localization variable    **************************************	
	
	strLog = L_strClusterSrvLog1_TEXT + "#"; 
//	try { srvWiz.InstallService("Clustering"); }
//	catch(e)
//	{
//		strLog += L_strClusterSrvLog2Error_TEXT;
//		strLog += failLog(e, e.number, e.description);			// create the failure log entry error description
//		err=true;
//	}
//	var varInstalled 	= (srvWiz.IsServiceInstalled("Clustering"))? L_strClusterSrvLog3InstalledOk_TEXT : L_strClusterSrvLog3InstalledNo_TEXT ;
//	
//	//**********************************    Localization variable    **************************************
//	var L_strClusterSrvLog3Part1_TEXT = "Clustering %1";
//	var strClusterSrvLog3Part2 = varInstalled;		// do not try to localize
//	var strClusterSrvLog3 = L_strClusterSrvLog3Part1_TEXT.replace(/%1/g, strClusterSrvLog3Part2);
//	//**********************************    Localization variable    **************************************	
//	
//	strLog += strClusterSrvLog3 + "#";
//	
	var log = createLogFile(strLog);							// write the log file
	//if(srvWiz.IsServiceInstalled("Clustering"))	openTasks();	// if no problem offer to user the help & log
	//else failDialog();											// if problems display failure dialog
	openTasks();
}


function failLog(varError, varErrorNumber, varErrorDescription)
// --------------------------------------------------------------------------------------
// used to create the failure log entry error description 
// --------------------------------------------------------------------------------------
{
	try 
	{
		//**********************************    Localization variable    **************************************			
		var L_FailLogLine2Part1_TEXT = '  Error : %1';
		var FailLogLine2Part2 = varError;							// do not try to localize
		var FailLogLine2 = L_FailLogLine2Part1_TEXT.replace(/%1/g, FailLogLine2Part2);
							
		var L_FailLogLine3Part1_TEXT = '  Error Number: %1';
		var hexString = "0x" + varErrorNumber.toString(16); 	// hex is base 16
		var FailLogLine3Part2 = varErrorNumber + ' (' + hexString + ')';		// do not try to localize
		var FailLogLine3 = L_FailLogLine3Part1_TEXT.replace(/%1/g, FailLogLine3Part2);
							
		var L_FailLogLine4Part1_TEXT = '  Error Description: %1';
		var FailLogLine4Part2 = varErrorDescription;				// do not try to localize
		var FailLogLine4 = L_FailLogLine4Part1_TEXT.replace(/%1/g, FailLogLine4Part2);
		
		var L_FailLogError_TEXT = "  ErrorLog: Unable to log error";
		//**********************************    Localization variable    **************************************	
		var failLog = FailLogLine2 + '#' + FailLogLine3 + '#' + FailLogLine4 + '#';
	}
	catch(e)
	{
		var failLog = L_FailLogError_TEXT + '#';
	}
	return(failLog); 
}

function openTasks()
// --------------------------------------------------------------------------------------
// used in all setup*() functions ; displays help&log or failure dialog at the end when reboot is not required 
// --------------------------------------------------------------------------------------
{
	// Open success or fail modal dialog
	var x = ((((window.screen.width-636)/2)<0)?0:(window.screen.width-360)/2);
	var y = ((((window.screen.height-450)/2)<0)?0:(window.screen.height-240)/2);
		
	if(!err)
	{
		// offer to display Help & Log information if no problems encountered
		var sFeatures2 = "dialogHeight:150px;dialogLeft:" + x + ";dialogTop:" + y + ";dialogWidth:360px;help:no;status:no;unadorned:no;"
		window.showModalDialog("success.htm",sysPath,sFeatures2);		
		divContent.load("oDataStore");		// Retrieve checkbox values from sucess.htm
		var bolOpenTask	= convertBol(divContent.getAttribute("P_openTask"));	
		var bolViewConfig = convertBol(divContent.getAttribute("P_viewConfig"));		
		if(bolOpenTask) { help('cys.chm::/' + helpfile); }	// display help information if requested
		if(bolViewConfig) { exec(sysPath + '\\cys.log'); }	// display log information if requested
	}
	else
	{
		// if problems encountered offer to display only Log information 
		var sFeatures2 = "dialogHeight:135px;dialogLeft:" + x + ";dialogTop:" + y + ";dialogWidth:360px;help:no;status:no;unadorned:no;"
		window.showModalDialog("fail.htm",sysPath,sFeatures2);
		divContent.load("oDataStore");
		var bolViewConfig = convertBol(divContent.getAttribute("P_viewConfig"));		
		if(bolViewConfig) exec(sysPath + '\\cys.log');
	}		
}

function logEvent()
// --------------------------------------------------------------------------------------
// used in finish() function ; Log event in nt event log 
// --------------------------------------------------------------------------------------
{
	try
	{
		var WshShell 	= new ActiveXObject("WScript.Shell"); var machineName = getMachineName();
		
		//**********************************    Localization variable    **************************************
		var L_strLogPart1_TEXT = "The Configure Your Server Wizard was completed on %1.  See the log file at %2";
		var strLogPart2 = machineName;						// do not try to localize							
		var strLogPart4 = sysPath + "\\cys.log. ";			// do not try to localize
		var strLogEvent = L_strLogPart1_TEXT.replace(/%1/g, strLogPart2);
		strLogEvent = strLogEvent.replace(/%2/g, strLogPart4);
		//**********************************    Localization variable    **************************************			
		
		WshShell.LogEvent(4, strLogEvent);
	}
	catch(e){}	
}