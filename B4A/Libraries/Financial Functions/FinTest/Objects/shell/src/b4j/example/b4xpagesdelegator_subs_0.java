package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xpagesdelegator_subs_0 {


public static RemoteObject  _activity_pause(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Activity_Pause (b4xpagesdelegator) ","b4xpagesdelegator",8,__ref.getField(false, "ba"),__ref,52);
if (RapidSub.canDelegate("activity_pause")) { return __ref.runUserSub(false, "b4xpagesdelegator","activity_pause", __ref);}
 BA.debugLineNum = 52;BA.debugLine="Public Sub Activity_Pause";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 53;BA.debugLine="B4XPages.GetManager.Activity_Pause";
Debug.JustUpdateDeviceLine();
b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xpagesmanager.class, "_activity_pause" /*RemoteObject*/ );
 BA.debugLineNum = 54;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _activity_resume(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Activity_Resume (b4xpagesdelegator) ","b4xpagesdelegator",8,__ref.getField(false, "ba"),__ref,48);
if (RapidSub.canDelegate("activity_resume")) { return __ref.runUserSub(false, "b4xpagesdelegator","activity_resume", __ref);}
 BA.debugLineNum = 48;BA.debugLine="Public Sub Activity_Resume";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 49;BA.debugLine="B4XPages.GetManager.Activity_Resume";
Debug.JustUpdateDeviceLine();
b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xpagesmanager.class, "_activity_resume" /*RemoteObject*/ );
 BA.debugLineNum = 50;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 1;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 2;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (b4xpagesdelegator) ","b4xpagesdelegator",8,__ref.getField(false, "ba"),__ref,4);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "b4xpagesdelegator","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 4;BA.debugLine="Public Sub Initialize";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 6;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_closed(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("MainForm_Closed (b4xpagesdelegator) ","b4xpagesdelegator",8,__ref.getField(false, "ba"),__ref,13);
if (RapidSub.canDelegate("mainform_closed")) { return __ref.runUserSub(false, "b4xpagesdelegator","mainform_closed", __ref);}
 BA.debugLineNum = 13;BA.debugLine="Public Sub MainForm_Closed";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 14;BA.debugLine="B4XPages.GetManager.MainForm_Closed";
Debug.JustUpdateDeviceLine();
b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xpagesmanager.class, "_mainform_closed" /*RemoteObject*/ );
 BA.debugLineNum = 15;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_closerequest(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("MainForm_CloseRequest (b4xpagesdelegator) ","b4xpagesdelegator",8,__ref.getField(false, "ba"),__ref,17);
if (RapidSub.canDelegate("mainform_closerequest")) { return __ref.runUserSub(false, "b4xpagesdelegator","mainform_closerequest", __ref, _eventdata);}
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 17;BA.debugLine="Public Sub MainForm_CloseRequest (EventData As Eve";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 18;BA.debugLine="B4XPages.GetManager.MainForm_CloseRequest (EventD";
Debug.JustUpdateDeviceLine();
b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xpagesmanager.class, "_mainform_closerequest" /*RemoteObject*/ ,(Object)(_eventdata));
 BA.debugLineNum = 19;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_focuschanged(RemoteObject __ref,RemoteObject _hasfocus) throws Exception{
try {
		Debug.PushSubsStack("MainForm_FocusChanged (b4xpagesdelegator) ","b4xpagesdelegator",8,__ref.getField(false, "ba"),__ref,9);
if (RapidSub.canDelegate("mainform_focuschanged")) { return __ref.runUserSub(false, "b4xpagesdelegator","mainform_focuschanged", __ref, _hasfocus);}
Debug.locals.put("HasFocus", _hasfocus);
 BA.debugLineNum = 9;BA.debugLine="Public Sub MainForm_FocusChanged (HasFocus As Bool";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 10;BA.debugLine="B4XPages.GetManager.MainForm_FocusChanged (HasFoc";
Debug.JustUpdateDeviceLine();
b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xpagesmanager.class, "_mainform_focuschanged" /*RemoteObject*/ ,(Object)(_hasfocus));
 BA.debugLineNum = 11;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_iconifiedchanged(RemoteObject __ref,RemoteObject _iconified) throws Exception{
try {
		Debug.PushSubsStack("MainForm_IconifiedChanged (b4xpagesdelegator) ","b4xpagesdelegator",8,__ref.getField(false, "ba"),__ref,21);
if (RapidSub.canDelegate("mainform_iconifiedchanged")) { return __ref.runUserSub(false, "b4xpagesdelegator","mainform_iconifiedchanged", __ref, _iconified);}
Debug.locals.put("Iconified", _iconified);
 BA.debugLineNum = 21;BA.debugLine="Public Sub MainForm_IconifiedChanged (Iconified As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 22;BA.debugLine="B4XPages.GetManager.MainForm_IconifiedChanged(Ico";
Debug.JustUpdateDeviceLine();
b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xpagesmanager.class, "_mainform_iconifiedchanged" /*RemoteObject*/ ,(Object)(_iconified));
 BA.debugLineNum = 23;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_resize(RemoteObject __ref,RemoteObject _width,RemoteObject _height) throws Exception{
try {
		Debug.PushSubsStack("MainForm_Resize (b4xpagesdelegator) ","b4xpagesdelegator",8,__ref.getField(false, "ba"),__ref,44);
if (RapidSub.canDelegate("mainform_resize")) { return __ref.runUserSub(false, "b4xpagesdelegator","mainform_resize", __ref, _width, _height);}
Debug.locals.put("Width", _width);
Debug.locals.put("Height", _height);
 BA.debugLineNum = 44;BA.debugLine="Public Sub MainForm_Resize(Width As Double, Height";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 45;BA.debugLine="B4XPages.GetManager.MainForm_Resize(Width, Height";
Debug.JustUpdateDeviceLine();
b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xpagesmanager.class, "_mainform_resize" /*RemoteObject*/ ,(Object)(_width),(Object)(_height));
 BA.debugLineNum = 46;BA.debugLine="End Sub";
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