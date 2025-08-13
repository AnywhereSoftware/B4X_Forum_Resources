package b4a.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xpagesdelegator_subs_0 {


public static RemoteObject  _activity_actionbarhomeclick(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Activity_ActionBarHomeClick (b4xpagesdelegator) ","b4xpagesdelegator",12,__ref.getField(false, "ba"),__ref,35);
if (RapidSub.canDelegate("activity_actionbarhomeclick")) { return __ref.runUserSub(false, "b4xpagesdelegator","activity_actionbarhomeclick", __ref);}
 BA.debugLineNum = 35;BA.debugLine="Public Sub Activity_ActionBarHomeClick";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 36;BA.debugLine="B4XPages.GetManager.Activity_ActionBarHomeClick";
Debug.JustUpdateDeviceLine();
b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ,__ref.runMethod(false,"getActivityBA")).runClassMethod (b4a.example.b4xpagesmanager.class, "_activity_actionbarhomeclick" /*RemoteObject*/ );
 BA.debugLineNum = 37;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _activity_keypress(RemoteObject __ref,RemoteObject _keycode) throws Exception{
try {
		Debug.PushSubsStack("Activity_KeyPress (b4xpagesdelegator) ","b4xpagesdelegator",12,__ref.getField(false, "ba"),__ref,27);
if (RapidSub.canDelegate("activity_keypress")) { return __ref.runUserSub(false, "b4xpagesdelegator","activity_keypress", __ref, _keycode);}
Debug.locals.put("KeyCode", _keycode);
 BA.debugLineNum = 27;BA.debugLine="Public Sub Activity_KeyPress (KeyCode As Int) As B";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 28;BA.debugLine="Return B4XPages.GetManager.Activity_KeyPress (Key";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ,__ref.runMethod(false,"getActivityBA")).runClassMethod (b4a.example.b4xpagesmanager.class, "_activity_keypress" /*RemoteObject*/ ,(Object)(_keycode));
 BA.debugLineNum = 29;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _activity_pause(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Activity_Pause (b4xpagesdelegator) ","b4xpagesdelegator",12,__ref.getField(false, "ba"),__ref,52);
if (RapidSub.canDelegate("activity_pause")) { return __ref.runUserSub(false, "b4xpagesdelegator","activity_pause", __ref);}
 BA.debugLineNum = 52;BA.debugLine="Public Sub Activity_Pause";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 53;BA.debugLine="B4XPages.GetManager.Activity_Pause";
Debug.JustUpdateDeviceLine();
b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ,__ref.runMethod(false,"getActivityBA")).runClassMethod (b4a.example.b4xpagesmanager.class, "_activity_pause" /*RemoteObject*/ );
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
public static RemoteObject  _activity_permissionresult(RemoteObject __ref,RemoteObject _permission,RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Activity_PermissionResult (b4xpagesdelegator) ","b4xpagesdelegator",12,__ref.getField(false, "ba"),__ref,31);
if (RapidSub.canDelegate("activity_permissionresult")) { return __ref.runUserSub(false, "b4xpagesdelegator","activity_permissionresult", __ref, _permission, _result);}
Debug.locals.put("Permission", _permission);
Debug.locals.put("Result", _result);
 BA.debugLineNum = 31;BA.debugLine="Sub Activity_PermissionResult (Permission As Strin";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 32;BA.debugLine="B4XPages.GetManager.RaiseEvent(B4XPages.GetManage";
Debug.JustUpdateDeviceLine();
b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ,__ref.runMethod(false,"getActivityBA")).runClassMethod (b4a.example.b4xpagesmanager.class, "_raiseevent" /*RemoteObject*/ ,(Object)(b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ,__ref.runMethod(false,"getActivityBA")).runClassMethod (b4a.example.b4xpagesmanager.class, "_gettoppage" /*RemoteObject*/ )),(Object)(BA.ObjectToString("B4XPage_PermissionResult")),(Object)(RemoteObject.createNewArray("Object",new int[] {2},new Object[] {(_permission),(_result)})));
 BA.debugLineNum = 33;BA.debugLine="End Sub";
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
		Debug.PushSubsStack("Activity_Resume (b4xpagesdelegator) ","b4xpagesdelegator",12,__ref.getField(false, "ba"),__ref,48);
if (RapidSub.canDelegate("activity_resume")) { return __ref.runUserSub(false, "b4xpagesdelegator","activity_resume", __ref);}
 BA.debugLineNum = 48;BA.debugLine="Public Sub Activity_Resume";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 49;BA.debugLine="B4XPages.GetManager.Activity_Resume";
Debug.JustUpdateDeviceLine();
b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ,__ref.runMethod(false,"getActivityBA")).runClassMethod (b4a.example.b4xpagesmanager.class, "_activity_resume" /*RemoteObject*/ );
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
public static RemoteObject  _create_menu(RemoteObject __ref,RemoteObject _menu) throws Exception{
try {
		Debug.PushSubsStack("Create_Menu (b4xpagesdelegator) ","b4xpagesdelegator",12,__ref.getField(false, "ba"),__ref,39);
if (RapidSub.canDelegate("create_menu")) { return __ref.runUserSub(false, "b4xpagesdelegator","create_menu", __ref, _menu);}
Debug.locals.put("Menu", _menu);
 BA.debugLineNum = 39;BA.debugLine="Public Sub Create_Menu (Menu As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 40;BA.debugLine="B4XPages.GetManager.CreateMenu(Menu)";
Debug.JustUpdateDeviceLine();
b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ,__ref.runMethod(false,"getActivityBA")).runClassMethod (b4a.example.b4xpagesmanager.class, "_createmenu" /*RemoteObject*/ ,(Object)(_menu));
 BA.debugLineNum = 41;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (b4xpagesdelegator) ","b4xpagesdelegator",12,__ref.getField(false, "ba"),__ref,4);
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
public static RemoteObject  _mainform_resize(RemoteObject __ref,RemoteObject _width,RemoteObject _height) throws Exception{
try {
		Debug.PushSubsStack("MainForm_Resize (b4xpagesdelegator) ","b4xpagesdelegator",12,__ref.getField(false, "ba"),__ref,44);
if (RapidSub.canDelegate("mainform_resize")) { return __ref.runUserSub(false, "b4xpagesdelegator","mainform_resize", __ref, _width, _height);}
Debug.locals.put("Width", _width);
Debug.locals.put("Height", _height);
 BA.debugLineNum = 44;BA.debugLine="Public Sub MainForm_Resize(Width As Double, Height";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 45;BA.debugLine="B4XPages.GetManager.MainForm_Resize(Width, Height";
Debug.JustUpdateDeviceLine();
b4xpagesdelegator._b4xpages.runMethod(false,"_getmanager" /*RemoteObject*/ ,__ref.runMethod(false,"getActivityBA")).runClassMethod (b4a.example.b4xpagesmanager.class, "_mainform_resize" /*RemoteObject*/ ,(Object)(_width),(Object)(_height));
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