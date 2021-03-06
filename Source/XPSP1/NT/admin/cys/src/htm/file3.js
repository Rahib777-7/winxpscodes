//***********************    Localization variable    *****************
var L_strAlert_Message = "You have not selected any configuration options.";

var L_IndexServiceOFF_TEXT = "Indexing Service catalogs the contents of the files in shared folders so that users can search them. Indexing Service is currently turned off.";

var L_IndexServiceOnYes_TEXT = "<U>Y</U>es, leave Indexing Service on";
var L_IndexServiceOnNo_TEXT = "N<U>o</U>, turn Indexing Service off";

var L_IndexServiceOffYes_TEXT = "<U>Y</U>es, turn Indexing Service on";
var L_IndexServiceOffNo_TEXT = "N<U>o</U>, leave Indexing Service off";
//***********************    Localization variable    *****************
var diskQuotas		= false;
	
function loadForm()
// --------------------------------------------------------------------------------------
// function performed at page load; load the values stored in oDataStore
// --------------------------------------------------------------------------------------
{
	divMain2.load("oDataStore");
	
	// delete this section
	//var P_cb_file2		= noNull(divMain2.getAttribute("P_cb_file2"));
	//var P_fileFolders	= noNull(divMain2.getAttribute("P_fileFolders"));
	//var arrCB			= P_cb_file2.split(",");
	//iskQuotas			= convertBol(arrCB[0]);
	
	var P_file3Index = divMain2.getAttribute("P_file3Index");
	
	if ((P_file3Index=="")||(P_file3Index == null))
	{
		// option "NO, turn Off" always default
		form.rd_file3[1].checked = true;
	}
	else
	{
		// otherwise make selection according to data stored
		form.rd_file3[0].checked=(convertBol(P_file3Index))?false:true;
		form.rd_file3[1].checked=(form.rd_file3[0].checked)?false:true;
	}
	
	var objAdminIS 	= new ActiveXObject("Microsoft.ISAdm")
	if(objAdminIS.IsRunning()) 
	{
		labelFile3Yes.innerHTML = L_IndexServiceOnYes_TEXT;
		labelFile3No.innerHTML = L_IndexServiceOnNo_TEXT;
	}
	else
	{
		p1.innerHTML = L_IndexServiceOFF_TEXT;
		labelFile3Yes.innerHTML = L_IndexServiceOffYes_TEXT;
		labelFile3No.innerHTML = L_IndexServiceOffNo_TEXT;
	}
	loadFocus();
}

function back()
// --------------------------------------------------------------------------------------
// process when click on BACK button (persist data and load previous file2.htm page if NTFS, else member.htm)
// --------------------------------------------------------------------------------------
{
	saveForm();
	var P_JumpNTFS	= convertBol(noNull(divMain2.getAttribute("P_JumpNTFS")));
	self.location.href=((P_JumpNTFS)?"member.htm":"file2.htm");
}
	
function next()
// --------------------------------------------------------------------------------------
// process when NEXT button clicked ; check entries made and proceed to next page (confirm.htm) 
// --------------------------------------------------------------------------------------
{
	saveForm(); self.location.href="confirm.htm"; 
}

function saveForm()
// --------------------------------------------------------------------------------------
// process before exiting the page; saves the selection and entries made
// --------------------------------------------------------------------------------------
{
	divMain2.setAttribute("P_install","fileServer");
	divMain2.setAttribute("P_file3Index",form.rd_file3[1].checked);
	divMain2.save("oDataStore");
}

function check(intPos)
// --------------------------------------------------------------------------------------
// function used at OnClick;
// --------------------------------------------------------------------------------------
{ form.rd_file3[intPos].checked=true; }

//function checkLabel(pos)
// --------------------------------------------------------------------------------------
// function apparently unused;
// --------------------------------------------------------------------------------------
//{ form.rd_TSAppMode[pos].checked=true; }
	