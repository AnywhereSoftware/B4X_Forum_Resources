package hr.splitterexample;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;

public class b4xpages extends Object{
public static b4xpages mostCurrent = new b4xpages();

public static BA ba;
static {
		ba = new  anywheresoftware.b4a.shell.ShellBA("hr.splitterexample", "hr.splitterexample.b4xpages", null);
		ba.loadHtSubs(b4xpages.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			
			ba.raiseEvent2(null, true, "SHELL", false);
			ba.raiseEvent2(null, true, "CREATE", true, "hr.splitterexample.b4xpages", ba);
		}
	}
    public static Class<?> getObject() {
		return b4xpages.class;
	}

 
public static anywheresoftware.b4a.keywords.Common __c = null;
public static Object _mpm = null;
public static hr.splitterexample.b4xpagesdelegator _delegate = null;
public static Object _globalcontext = null;
public static hr.splitterexample.main _main = null;
public static hr.splitterexample.b4xcollections _b4xcollections = null;
public static String  _settitle(Object _b4xpage,Object _title) throws Exception{
RDebugUtils.currentModule="b4xpages";
if (Debug.shouldDelegate(ba, "settitle", true))
	 {return ((String) Debug.delegate(ba, "settitle", new Object[] {_b4xpage,_title}));}
RDebugUtils.currentLine=2621440;
 //BA.debugLineNum = 2621440;BA.debugLine="Public Sub SetTitle (B4XPage As Object, Title As O";
RDebugUtils.currentLine=2621441;
 //BA.debugLineNum = 2621441;BA.debugLine="GetManager.SetTitle(B4XPage, Title)";
_getmanager()._settitle /*String*/ (null,_b4xpage,_title);
RDebugUtils.currentLine=2621442;
 //BA.debugLineNum = 2621442;BA.debugLine="End Sub";
return "";
}
public static hr.splitterexample.b4xmainpage  _mainpage() throws Exception{
RDebugUtils.currentModule="b4xpages";
if (Debug.shouldDelegate(ba, "mainpage", true))
	 {return ((hr.splitterexample.b4xmainpage) Debug.delegate(ba, "mainpage", null));}
RDebugUtils.currentLine=2686976;
 //BA.debugLineNum = 2686976;BA.debugLine="Public Sub MainPage As B4XMainPage";
RDebugUtils.currentLine=2686977;
 //BA.debugLineNum = 2686977;BA.debugLine="Return GetManager.MainPage";
if (true) return _getmanager()._mainpage /*hr.splitterexample.b4xmainpage*/ ;
RDebugUtils.currentLine=2686978;
 //BA.debugLineNum = 2686978;BA.debugLine="End Sub";
return null;
}
public static String  _addpage(String _id,Object _b4xpage) throws Exception{
RDebugUtils.currentModule="b4xpages";
if (Debug.shouldDelegate(ba, "addpage", true))
	 {return ((String) Debug.delegate(ba, "addpage", new Object[] {_id,_b4xpage}));}
RDebugUtils.currentLine=2293760;
 //BA.debugLineNum = 2293760;BA.debugLine="Public Sub AddPage (Id As String, B4XPage As Objec";
RDebugUtils.currentLine=2293761;
 //BA.debugLineNum = 2293761;BA.debugLine="GetManager.AddPage(Id, B4XPage)";
_getmanager()._addpage /*String*/ (null,_id,_b4xpage);
RDebugUtils.currentLine=2293762;
 //BA.debugLineNum = 2293762;BA.debugLine="End Sub";
return "";
}
public static hr.splitterexample.b4xpagesmanager  _getmanager() throws Exception{
RDebugUtils.currentModule="b4xpages";
if (Debug.shouldDelegate(ba, "getmanager", true))
	 {return ((hr.splitterexample.b4xpagesmanager) Debug.delegate(ba, "getmanager", null));}
RDebugUtils.currentLine=2031616;
 //BA.debugLineNum = 2031616;BA.debugLine="Public Sub GetManager As B4XPagesManager";
RDebugUtils.currentLine=2031617;
 //BA.debugLineNum = 2031617;BA.debugLine="Return mPM";
if (true) return (hr.splitterexample.b4xpagesmanager)(_mpm);
RDebugUtils.currentLine=2031618;
 //BA.debugLineNum = 2031618;BA.debugLine="End Sub";
return null;
}
public static String  _addpageandcreate(String _id,Object _b4xpage) throws Exception{
RDebugUtils.currentModule="b4xpages";
if (Debug.shouldDelegate(ba, "addpageandcreate", true))
	 {return ((String) Debug.delegate(ba, "addpageandcreate", new Object[] {_id,_b4xpage}));}
RDebugUtils.currentLine=2359296;
 //BA.debugLineNum = 2359296;BA.debugLine="Public Sub AddPageAndCreate (Id As String, B4XPage";
RDebugUtils.currentLine=2359297;
 //BA.debugLineNum = 2359297;BA.debugLine="GetManager.AddPageAndCreate(Id, B4XPage)";
_getmanager()._addpageandcreate /*String*/ (null,_id,_b4xpage);
RDebugUtils.currentLine=2359298;
 //BA.debugLineNum = 2359298;BA.debugLine="End Sub";
return "";
}
public static String  _closepage(Object _b4xpage) throws Exception{
RDebugUtils.currentModule="b4xpages";
if (Debug.shouldDelegate(ba, "closepage", true))
	 {return ((String) Debug.delegate(ba, "closepage", new Object[] {_b4xpage}));}
RDebugUtils.currentLine=2555904;
 //BA.debugLineNum = 2555904;BA.debugLine="Public Sub ClosePage (B4XPage As Object)";
RDebugUtils.currentLine=2555905;
 //BA.debugLineNum = 2555905;BA.debugLine="GetManager.ClosePage (B4XPage)";
_getmanager()._closepage /*String*/ (null,_b4xpage);
RDebugUtils.currentLine=2555906;
 //BA.debugLineNum = 2555906;BA.debugLine="End Sub";
return "";
}
public static anywheresoftware.b4j.objects.Form  _getnativeparent(Object _b4xpage) throws Exception{
RDebugUtils.currentModule="b4xpages";
if (Debug.shouldDelegate(ba, "getnativeparent", true))
	 {return ((anywheresoftware.b4j.objects.Form) Debug.delegate(ba, "getnativeparent", new Object[] {_b4xpage}));}
RDebugUtils.currentLine=2752512;
 //BA.debugLineNum = 2752512;BA.debugLine="Public Sub GetNativeParent (B4XPage As Object) As";
RDebugUtils.currentLine=2752517;
 //BA.debugLineNum = 2752517;BA.debugLine="Return GetManager.FindPIFromB4XPage(B4XPage).Pare";
if (true) return _getmanager()._findpifromb4xpage /*hr.splitterexample.b4xpagesmanager._b4xpageinfo*/ (null,_b4xpage).Parent /*hr.splitterexample.b4xpagesmanager._b4xpageparent*/ .NativeType /*anywheresoftware.b4j.objects.Form*/ ;
RDebugUtils.currentLine=2752518;
 //BA.debugLineNum = 2752518;BA.debugLine="End Sub";
return null;
}
public static Object  _getpage(String _id) throws Exception{
RDebugUtils.currentModule="b4xpages";
if (Debug.shouldDelegate(ba, "getpage", true))
	 {return ((Object) Debug.delegate(ba, "getpage", new Object[] {_id}));}
RDebugUtils.currentLine=2162688;
 //BA.debugLineNum = 2162688;BA.debugLine="Public Sub GetPage (Id As String) As Object";
RDebugUtils.currentLine=2162689;
 //BA.debugLineNum = 2162689;BA.debugLine="Return GetManager.GetPage(Id)";
if (true) return _getmanager()._getpage /*Object*/ (null,_id);
RDebugUtils.currentLine=2162690;
 //BA.debugLineNum = 2162690;BA.debugLine="End Sub";
return null;
}
public static String  _getpageid(Object _b4xpage) throws Exception{
RDebugUtils.currentModule="b4xpages";
if (Debug.shouldDelegate(ba, "getpageid", true))
	 {return ((String) Debug.delegate(ba, "getpageid", new Object[] {_b4xpage}));}
RDebugUtils.currentLine=2228224;
 //BA.debugLineNum = 2228224;BA.debugLine="Public Sub GetPageId (B4XPage As Object) As String";
RDebugUtils.currentLine=2228225;
 //BA.debugLineNum = 2228225;BA.debugLine="Return GetManager.FindPIFromB4XPage(B4XPage).Id";
if (true) return _getmanager()._findpifromb4xpage /*hr.splitterexample.b4xpagesmanager._b4xpageinfo*/ (null,_b4xpage).Id /*String*/ ;
RDebugUtils.currentLine=2228226;
 //BA.debugLineNum = 2228226;BA.debugLine="End Sub";
return "";
}
public static String  _internalsetpagesmanager(Object _pm) throws Exception{
RDebugUtils.currentModule="b4xpages";
if (Debug.shouldDelegate(ba, "internalsetpagesmanager", true))
	 {return ((String) Debug.delegate(ba, "internalsetpagesmanager", new Object[] {_pm}));}
RDebugUtils.currentLine=2097152;
 //BA.debugLineNum = 2097152;BA.debugLine="Public Sub InternalSetPagesManager(PM As Object)";
RDebugUtils.currentLine=2097153;
 //BA.debugLineNum = 2097153;BA.debugLine="Delegate.Initialize";
_delegate._initialize /*String*/ (null,ba);
RDebugUtils.currentLine=2097154;
 //BA.debugLineNum = 2097154;BA.debugLine="mPM = PM";
_mpm = _pm;
RDebugUtils.currentLine=2097155;
 //BA.debugLineNum = 2097155;BA.debugLine="End Sub";
return "";
}
public static boolean  _isinitialized() throws Exception{
RDebugUtils.currentModule="b4xpages";
if (Debug.shouldDelegate(ba, "isinitialized", true))
	 {return ((Boolean) Debug.delegate(ba, "isinitialized", null));}
RDebugUtils.currentLine=1966080;
 //BA.debugLineNum = 1966080;BA.debugLine="Public Sub IsInitialized As Boolean";
RDebugUtils.currentLine=1966081;
 //BA.debugLineNum = 1966081;BA.debugLine="Return mPM Is B4XPagesManager";
if (true) return _mpm instanceof hr.splitterexample.b4xpagesmanager;
RDebugUtils.currentLine=1966082;
 //BA.debugLineNum = 1966082;BA.debugLine="End Sub";
return false;
}
public static String  _showpage(String _id) throws Exception{
RDebugUtils.currentModule="b4xpages";
if (Debug.shouldDelegate(ba, "showpage", true))
	 {return ((String) Debug.delegate(ba, "showpage", new Object[] {_id}));}
RDebugUtils.currentLine=2424832;
 //BA.debugLineNum = 2424832;BA.debugLine="Public Sub ShowPage (Id As String)";
RDebugUtils.currentLine=2424833;
 //BA.debugLineNum = 2424833;BA.debugLine="GetManager.ShowPage(Id)";
_getmanager()._showpage /*String*/ (null,_id);
RDebugUtils.currentLine=2424834;
 //BA.debugLineNum = 2424834;BA.debugLine="End Sub";
return "";
}
public static String  _showpageandremovepreviouspages(String _id) throws Exception{
RDebugUtils.currentModule="b4xpages";
if (Debug.shouldDelegate(ba, "showpageandremovepreviouspages", true))
	 {return ((String) Debug.delegate(ba, "showpageandremovepreviouspages", new Object[] {_id}));}
RDebugUtils.currentLine=2490368;
 //BA.debugLineNum = 2490368;BA.debugLine="Public Sub ShowPageAndRemovePreviousPages (Id As S";
RDebugUtils.currentLine=2490369;
 //BA.debugLineNum = 2490369;BA.debugLine="GetManager.ShowPageAndRemovePreviousPages (Id)";
_getmanager()._showpageandremovepreviouspages /*String*/ (null,_id);
RDebugUtils.currentLine=2490370;
 //BA.debugLineNum = 2490370;BA.debugLine="End Sub";
return "";
}
}