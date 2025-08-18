package hr.splitterexample;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _appstart(RemoteObject _form1,RemoteObject _args) throws Exception{
try {
		Debug.PushSubsStack("AppStart (main) ","main",0,main.ba,main.mostCurrent,11);
if (RapidSub.canDelegate("appstart")) { return hr.splitterexample.main.remoteMe.runUserSub(false, "main","appstart", _form1, _args);}
RemoteObject _pagesmanager = RemoteObject.declareNull("hr.splitterexample.b4xpagesmanager");
Debug.locals.put("Form1", _form1);
Debug.locals.put("Args", _args);
 BA.debugLineNum = 11;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
Debug.ShouldStop(1024);
 BA.debugLineNum = 12;BA.debugLine="MainForm = Form1";
Debug.ShouldStop(2048);
main._mainform = _form1;
 BA.debugLineNum = 13;BA.debugLine="MainForm.Show";
Debug.ShouldStop(4096);
main._mainform.runVoidMethodAndSync ("Show");
 BA.debugLineNum = 14;BA.debugLine="Dim PagesManager As B4XPagesManager";
Debug.ShouldStop(8192);
_pagesmanager = RemoteObject.createNew ("hr.splitterexample.b4xpagesmanager");Debug.locals.put("PagesManager", _pagesmanager);
 BA.debugLineNum = 15;BA.debugLine="PagesManager.Initialize(MainForm)";
Debug.ShouldStop(16384);
_pagesmanager.runClassMethod (hr.splitterexample.b4xpagesmanager.class, "_initialize" /*RemoteObject*/ ,main.ba,(Object)(main._mainform));
 BA.debugLineNum = 16;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_closed() throws Exception{
try {
		Debug.PushSubsStack("MainForm_Closed (main) ","main",0,main.ba,main.mostCurrent,28);
if (RapidSub.canDelegate("mainform_closed")) { return hr.splitterexample.main.remoteMe.runUserSub(false, "main","mainform_closed");}
 BA.debugLineNum = 28;BA.debugLine="Sub MainForm_Closed";
Debug.ShouldStop(134217728);
 BA.debugLineNum = 29;BA.debugLine="B4XPages.Delegate.MainForm_Closed";
Debug.ShouldStop(268435456);
main._b4xpages._delegate /*RemoteObject*/ .runClassMethod (hr.splitterexample.b4xpagesdelegator.class, "_mainform_closed" /*RemoteObject*/ );
 BA.debugLineNum = 30;BA.debugLine="End Sub";
Debug.ShouldStop(536870912);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_closerequest(RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("MainForm_CloseRequest (main) ","main",0,main.ba,main.mostCurrent,32);
if (RapidSub.canDelegate("mainform_closerequest")) { return hr.splitterexample.main.remoteMe.runUserSub(false, "main","mainform_closerequest", _eventdata);}
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 32;BA.debugLine="Sub MainForm_CloseRequest (EventData As Event)";
Debug.ShouldStop(-2147483648);
 BA.debugLineNum = 33;BA.debugLine="B4XPages.Delegate.MainForm_CloseRequest(EventData";
Debug.ShouldStop(1);
main._b4xpages._delegate /*RemoteObject*/ .runClassMethod (hr.splitterexample.b4xpagesdelegator.class, "_mainform_closerequest" /*RemoteObject*/ ,(Object)(_eventdata));
 BA.debugLineNum = 34;BA.debugLine="End Sub";
Debug.ShouldStop(2);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_focuschanged(RemoteObject _hasfocus) throws Exception{
try {
		Debug.PushSubsStack("MainForm_FocusChanged (main) ","main",0,main.ba,main.mostCurrent,20);
if (RapidSub.canDelegate("mainform_focuschanged")) { return hr.splitterexample.main.remoteMe.runUserSub(false, "main","mainform_focuschanged", _hasfocus);}
Debug.locals.put("HasFocus", _hasfocus);
 BA.debugLineNum = 20;BA.debugLine="Sub MainForm_FocusChanged (HasFocus As Boolean)";
Debug.ShouldStop(524288);
 BA.debugLineNum = 21;BA.debugLine="B4XPages.Delegate.MainForm_FocusChanged(HasFocus)";
Debug.ShouldStop(1048576);
main._b4xpages._delegate /*RemoteObject*/ .runClassMethod (hr.splitterexample.b4xpagesdelegator.class, "_mainform_focuschanged" /*RemoteObject*/ ,(Object)(_hasfocus));
 BA.debugLineNum = 22;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_iconifiedchanged(RemoteObject _iconified) throws Exception{
try {
		Debug.PushSubsStack("MainForm_IconifiedChanged (main) ","main",0,main.ba,main.mostCurrent,36);
if (RapidSub.canDelegate("mainform_iconifiedchanged")) { return hr.splitterexample.main.remoteMe.runUserSub(false, "main","mainform_iconifiedchanged", _iconified);}
Debug.locals.put("Iconified", _iconified);
 BA.debugLineNum = 36;BA.debugLine="Public Sub MainForm_IconifiedChanged (Iconified As";
Debug.ShouldStop(8);
 BA.debugLineNum = 37;BA.debugLine="B4XPages.Delegate.MainForm_IconifiedChanged(Iconi";
Debug.ShouldStop(16);
main._b4xpages._delegate /*RemoteObject*/ .runClassMethod (hr.splitterexample.b4xpagesdelegator.class, "_mainform_iconifiedchanged" /*RemoteObject*/ ,(Object)(_iconified));
 BA.debugLineNum = 38;BA.debugLine="End Sub";
Debug.ShouldStop(32);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_resize(RemoteObject _width,RemoteObject _height) throws Exception{
try {
		Debug.PushSubsStack("MainForm_Resize (main) ","main",0,main.ba,main.mostCurrent,24);
if (RapidSub.canDelegate("mainform_resize")) { return hr.splitterexample.main.remoteMe.runUserSub(false, "main","mainform_resize", _width, _height);}
Debug.locals.put("Width", _width);
Debug.locals.put("Height", _height);
 BA.debugLineNum = 24;BA.debugLine="Sub MainForm_Resize (Width As Double, Height As Do";
Debug.ShouldStop(8388608);
 BA.debugLineNum = 25;BA.debugLine="B4XPages.Delegate.MainForm_Resize(Width, Height)";
Debug.ShouldStop(16777216);
main._b4xpages._delegate /*RemoteObject*/ .runClassMethod (hr.splitterexample.b4xpagesdelegator.class, "_mainform_resize" /*RemoteObject*/ ,(Object)(_width),(Object)(_height));
 BA.debugLineNum = 26;BA.debugLine="End Sub";
Debug.ShouldStop(33554432);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}

private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main_subs_0._process_globals();
b4xpages_subs_0._process_globals();
b4xcollections_subs_0._process_globals();
main.myClass = BA.getDeviceClass ("hr.splitterexample.main");
b4xmainpage.myClass = BA.getDeviceClass ("hr.splitterexample.b4xmainpage");
csplitter.myClass = BA.getDeviceClass ("hr.splitterexample.csplitter");
b4xpages.myClass = BA.getDeviceClass ("hr.splitterexample.b4xpages");
b4xbitset.myClass = BA.getDeviceClass ("hr.splitterexample.b4xbitset");
b4xbytesbuilder.myClass = BA.getDeviceClass ("hr.splitterexample.b4xbytesbuilder");
b4xcollections.myClass = BA.getDeviceClass ("hr.splitterexample.b4xcollections");
b4xorderedmap.myClass = BA.getDeviceClass ("hr.splitterexample.b4xorderedmap");
b4xset.myClass = BA.getDeviceClass ("hr.splitterexample.b4xset");
b4xpagesdelegator.myClass = BA.getDeviceClass ("hr.splitterexample.b4xpagesdelegator");
b4xpagesmanager.myClass = BA.getDeviceClass ("hr.splitterexample.b4xpagesmanager");
keyvaluestore.myClass = BA.getDeviceClass ("hr.splitterexample.keyvaluestore");
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 6;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 7;BA.debugLine="Private fx As JFX";
main._fx = RemoteObject.createNew ("anywheresoftware.b4j.objects.JFX");
 //BA.debugLineNum = 8;BA.debugLine="Private MainForm As Form";
main._mainform = RemoteObject.createNew ("anywheresoftware.b4j.objects.Form");
 //BA.debugLineNum = 9;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}