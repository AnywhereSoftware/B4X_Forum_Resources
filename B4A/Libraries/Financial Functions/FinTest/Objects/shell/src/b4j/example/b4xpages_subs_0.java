package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xpages_subs_0 {


public static RemoteObject  _addpage(RemoteObject _id,RemoteObject _b4xpage) throws Exception{
try {
		Debug.PushSubsStack("AddPage (b4xpages) ","b4xpages",2,b4xpages.ba,b4xpages.mostCurrent,37);
if (RapidSub.canDelegate("addpage")) { return b4j.example.b4xpages.remoteMe.runUserSub(false, "b4xpages","addpage", _id, _b4xpage);}
Debug.locals.put("Id", _id);
Debug.locals.put("B4XPage", _b4xpage);
 BA.debugLineNum = 37;BA.debugLine="Public Sub AddPage (Id As String, B4XPage As Objec";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 38;BA.debugLine="GetManager.AddPage(Id, B4XPage)";
Debug.JustUpdateDeviceLine();
_getmanager().runClassMethod (b4j.example.b4xpagesmanager.class, "_addpage" /*RemoteObject*/ ,(Object)(_id),(Object)(_b4xpage));
 BA.debugLineNum = 39;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _addpageandcreate(RemoteObject _id,RemoteObject _b4xpage) throws Exception{
try {
		Debug.PushSubsStack("AddPageAndCreate (b4xpages) ","b4xpages",2,b4xpages.ba,b4xpages.mostCurrent,42);
if (RapidSub.canDelegate("addpageandcreate")) { return b4j.example.b4xpages.remoteMe.runUserSub(false, "b4xpages","addpageandcreate", _id, _b4xpage);}
Debug.locals.put("Id", _id);
Debug.locals.put("B4XPage", _b4xpage);
 BA.debugLineNum = 42;BA.debugLine="Public Sub AddPageAndCreate (Id As String, B4XPage";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 43;BA.debugLine="GetManager.AddPageAndCreate(Id, B4XPage)";
Debug.JustUpdateDeviceLine();
_getmanager().runClassMethod (b4j.example.b4xpagesmanager.class, "_addpageandcreate" /*RemoteObject*/ ,(Object)(_id),(Object)(_b4xpage));
 BA.debugLineNum = 44;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _closepage(RemoteObject _b4xpage) throws Exception{
try {
		Debug.PushSubsStack("ClosePage (b4xpages) ","b4xpages",2,b4xpages.ba,b4xpages.mostCurrent,62);
if (RapidSub.canDelegate("closepage")) { return b4j.example.b4xpages.remoteMe.runUserSub(false, "b4xpages","closepage", _b4xpage);}
Debug.locals.put("B4XPage", _b4xpage);
 BA.debugLineNum = 62;BA.debugLine="Public Sub ClosePage (B4XPage As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 63;BA.debugLine="GetManager.ClosePage (B4XPage)";
Debug.JustUpdateDeviceLine();
_getmanager().runClassMethod (b4j.example.b4xpagesmanager.class, "_closepage" /*RemoteObject*/ ,(Object)(_b4xpage));
 BA.debugLineNum = 64;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getmanager() throws Exception{
try {
		Debug.PushSubsStack("GetManager (b4xpages) ","b4xpages",2,b4xpages.ba,b4xpages.mostCurrent,14);
if (RapidSub.canDelegate("getmanager")) { return b4j.example.b4xpages.remoteMe.runUserSub(false, "b4xpages","getmanager");}
 BA.debugLineNum = 14;BA.debugLine="Public Sub GetManager As B4XPagesManager";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 15;BA.debugLine="Return mPM";
Debug.JustUpdateDeviceLine();
if (true) return (b4xpages._mpm);
 BA.debugLineNum = 16;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getnativeparent(RemoteObject _b4xpage) throws Exception{
try {
		Debug.PushSubsStack("GetNativeParent (b4xpages) ","b4xpages",2,b4xpages.ba,b4xpages.mostCurrent,82);
if (RapidSub.canDelegate("getnativeparent")) { return b4j.example.b4xpages.remoteMe.runUserSub(false, "b4xpages","getnativeparent", _b4xpage);}
Debug.locals.put("B4XPage", _b4xpage);
 BA.debugLineNum = 82;BA.debugLine="Public Sub GetNativeParent (B4XPage As Object) As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 87;BA.debugLine="Return GetManager.FindPIFromB4XPage(B4XPage).Pare";
Debug.JustUpdateDeviceLine();
if (true) return _getmanager().runClassMethod (b4j.example.b4xpagesmanager.class, "_findpifromb4xpage" /*RemoteObject*/ ,(Object)(_b4xpage)).getField(false,"Parent" /*RemoteObject*/ ).getField(false,"NativeType" /*RemoteObject*/ );
 BA.debugLineNum = 88;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getpage(RemoteObject _id) throws Exception{
try {
		Debug.PushSubsStack("GetPage (b4xpages) ","b4xpages",2,b4xpages.ba,b4xpages.mostCurrent,27);
if (RapidSub.canDelegate("getpage")) { return b4j.example.b4xpages.remoteMe.runUserSub(false, "b4xpages","getpage", _id);}
Debug.locals.put("Id", _id);
 BA.debugLineNum = 27;BA.debugLine="Public Sub GetPage (Id As String) As Object";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 28;BA.debugLine="Return GetManager.GetPage(Id)";
Debug.JustUpdateDeviceLine();
if (true) return _getmanager().runClassMethod (b4j.example.b4xpagesmanager.class, "_getpage" /*RemoteObject*/ ,(Object)(_id));
 BA.debugLineNum = 29;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getpageid(RemoteObject _b4xpage) throws Exception{
try {
		Debug.PushSubsStack("GetPageId (b4xpages) ","b4xpages",2,b4xpages.ba,b4xpages.mostCurrent,32);
if (RapidSub.canDelegate("getpageid")) { return b4j.example.b4xpages.remoteMe.runUserSub(false, "b4xpages","getpageid", _b4xpage);}
Debug.locals.put("B4XPage", _b4xpage);
 BA.debugLineNum = 32;BA.debugLine="Public Sub GetPageId (B4XPage As Object) As String";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 33;BA.debugLine="Return GetManager.FindPIFromB4XPage(B4XPage).Id";
Debug.JustUpdateDeviceLine();
if (true) return _getmanager().runClassMethod (b4j.example.b4xpagesmanager.class, "_findpifromb4xpage" /*RemoteObject*/ ,(Object)(_b4xpage)).getField(true,"Id" /*RemoteObject*/ );
 BA.debugLineNum = 34;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _internalsetpagesmanager(RemoteObject _pm) throws Exception{
try {
		Debug.PushSubsStack("InternalSetPagesManager (b4xpages) ","b4xpages",2,b4xpages.ba,b4xpages.mostCurrent,19);
if (RapidSub.canDelegate("internalsetpagesmanager")) { return b4j.example.b4xpages.remoteMe.runUserSub(false, "b4xpages","internalsetpagesmanager", _pm);}
Debug.locals.put("PM", _pm);
 BA.debugLineNum = 19;BA.debugLine="Public Sub InternalSetPagesManager(PM As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 20;BA.debugLine="Delegate.Initialize";
Debug.JustUpdateDeviceLine();
b4xpages._delegate.runClassMethod (b4j.example.b4xpagesdelegator.class, "_initialize" /*RemoteObject*/ ,b4xpages.ba);
 BA.debugLineNum = 21;BA.debugLine="mPM = PM";
Debug.JustUpdateDeviceLine();
b4xpages._mpm = _pm;
 BA.debugLineNum = 22;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _isinitialized() throws Exception{
try {
		Debug.PushSubsStack("IsInitialized (b4xpages) ","b4xpages",2,b4xpages.ba,b4xpages.mostCurrent,9);
if (RapidSub.canDelegate("isinitialized")) { return b4j.example.b4xpages.remoteMe.runUserSub(false, "b4xpages","isinitialized");}
 BA.debugLineNum = 9;BA.debugLine="Public Sub IsInitialized As Boolean";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 10;BA.debugLine="Return mPM Is B4XPagesManager";
Debug.JustUpdateDeviceLine();
if (true) return BA.ObjectToBoolean(RemoteObject.solveBoolean("i",b4xpages._mpm, RemoteObject.createImmutable("b4j.example.b4xpagesmanager")));
 BA.debugLineNum = 11;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainpage() throws Exception{
try {
		Debug.PushSubsStack("MainPage (b4xpages) ","b4xpages",2,b4xpages.ba,b4xpages.mostCurrent,73);
if (RapidSub.canDelegate("mainpage")) { return b4j.example.b4xpages.remoteMe.runUserSub(false, "b4xpages","mainpage");}
 BA.debugLineNum = 73;BA.debugLine="Public Sub MainPage As B4XMainPage";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 74;BA.debugLine="Return GetManager.MainPage";
Debug.JustUpdateDeviceLine();
if (true) return _getmanager().getField(false,"_mainpage" /*RemoteObject*/ );
 BA.debugLineNum = 75;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 1;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 2;BA.debugLine="Private mPM As Object";
b4xpages._mpm = RemoteObject.createNew ("Object");
 //BA.debugLineNum = 3;BA.debugLine="Public Delegate As B4XPagesDelegator";
b4xpages._delegate = RemoteObject.createNew ("b4j.example.b4xpagesdelegator");
 //BA.debugLineNum = 4;BA.debugLine="Public GlobalContext As Object";
b4xpages._globalcontext = RemoteObject.createNew ("Object");
 //BA.debugLineNum = 5;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _settitle(RemoteObject _b4xpage,RemoteObject _title) throws Exception{
try {
		Debug.PushSubsStack("SetTitle (b4xpages) ","b4xpages",2,b4xpages.ba,b4xpages.mostCurrent,68);
if (RapidSub.canDelegate("settitle")) { return b4j.example.b4xpages.remoteMe.runUserSub(false, "b4xpages","settitle", _b4xpage, _title);}
Debug.locals.put("B4XPage", _b4xpage);
Debug.locals.put("Title", _title);
 BA.debugLineNum = 68;BA.debugLine="Public Sub SetTitle (B4XPage As Object, Title As O";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 69;BA.debugLine="GetManager.SetTitle(B4XPage, Title)";
Debug.JustUpdateDeviceLine();
_getmanager().runClassMethod (b4j.example.b4xpagesmanager.class, "_settitle" /*RemoteObject*/ ,(Object)(_b4xpage),(Object)(_title));
 BA.debugLineNum = 70;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _showpage(RemoteObject _id) throws Exception{
try {
		Debug.PushSubsStack("ShowPage (b4xpages) ","b4xpages",2,b4xpages.ba,b4xpages.mostCurrent,50);
if (RapidSub.canDelegate("showpage")) { return b4j.example.b4xpages.remoteMe.runUserSub(false, "b4xpages","showpage", _id);}
Debug.locals.put("Id", _id);
 BA.debugLineNum = 50;BA.debugLine="Public Sub ShowPage (Id As String)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 51;BA.debugLine="GetManager.ShowPage(Id)";
Debug.JustUpdateDeviceLine();
_getmanager().runClassMethod (b4j.example.b4xpagesmanager.class, "_showpage" /*RemoteObject*/ ,(Object)(_id));
 BA.debugLineNum = 52;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _showpageandremovepreviouspages(RemoteObject _id) throws Exception{
try {
		Debug.PushSubsStack("ShowPageAndRemovePreviousPages (b4xpages) ","b4xpages",2,b4xpages.ba,b4xpages.mostCurrent,56);
if (RapidSub.canDelegate("showpageandremovepreviouspages")) { return b4j.example.b4xpages.remoteMe.runUserSub(false, "b4xpages","showpageandremovepreviouspages", _id);}
Debug.locals.put("Id", _id);
 BA.debugLineNum = 56;BA.debugLine="Public Sub ShowPageAndRemovePreviousPages (Id As S";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 57;BA.debugLine="GetManager.ShowPageAndRemovePreviousPages (Id)";
Debug.JustUpdateDeviceLine();
_getmanager().runClassMethod (b4j.example.b4xpagesmanager.class, "_showpageandremovepreviouspages" /*RemoteObject*/ ,(Object)(_id));
 BA.debugLineNum = 58;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}