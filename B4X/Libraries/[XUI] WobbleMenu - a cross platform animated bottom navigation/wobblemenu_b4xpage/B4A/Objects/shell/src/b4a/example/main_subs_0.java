package b4a.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _activity_actionbarhomeclick() throws Exception{
try {
		Debug.PushSubsStack("Activity_ActionBarHomeClick (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,31);
if (RapidSub.canDelegate("activity_actionbarhomeclick")) { return b4a.example.main.remoteMe.runUserSub(false, "main","activity_actionbarhomeclick");}
 BA.debugLineNum = 31;BA.debugLine="Sub Activity_ActionBarHomeClick";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 32;BA.debugLine="B4XPages.Delegate.Activity_ActionBarHomeClick";
Debug.ShouldStop(-2147483648);
main.mostCurrent._b4xpages._delegate /*RemoteObject*/ .runClassMethod (b4a.example.b4xpagesdelegator.class, "_activity_actionbarhomeclick" /*RemoteObject*/ );
 BA.debugLineNum = 33;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _activity_create(RemoteObject _firsttime) throws Exception{
try {
		Debug.PushSubsStack("Activity_Create (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,23);
if (RapidSub.canDelegate("activity_create")) { return b4a.example.main.remoteMe.runUserSub(false, "main","activity_create", _firsttime);}
RemoteObject _pm = RemoteObject.declareNull("b4a.example.b4xpagesmanager");
Debug.locals.put("FirstTime", _firsttime);
 BA.debugLineNum = 23;BA.debugLine="Sub Activity_Create(FirstTime As Boolean)";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 24;BA.debugLine="Dim pm As B4XPagesManager";
Debug.ShouldStop(8388608);
_pm = RemoteObject.createNew ("b4a.example.b4xpagesmanager");Debug.locals.put("pm", _pm);
 BA.debugLineNum = 25;BA.debugLine="pm.Initialize(Activity)";
Debug.ShouldStop(16777216);
_pm.runClassMethod (b4a.example.b4xpagesmanager.class, "_initialize" /*RemoteObject*/ ,main.mostCurrent.activityBA,(Object)(main.mostCurrent._activity));
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
public static RemoteObject  _activity_keypress(RemoteObject _keycode) throws Exception{
try {
		Debug.PushSubsStack("Activity_KeyPress (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,35);
if (RapidSub.canDelegate("activity_keypress")) { return b4a.example.main.remoteMe.runUserSub(false, "main","activity_keypress", _keycode);}
Debug.locals.put("KeyCode", _keycode);
 BA.debugLineNum = 35;BA.debugLine="Sub Activity_KeyPress (KeyCode As Int) As Boolean";
Debug.ShouldStop(4);
 BA.debugLineNum = 36;BA.debugLine="Return B4XPages.Delegate.Activity_KeyPress(KeyCod";
Debug.ShouldStop(8);
if (true) return main.mostCurrent._b4xpages._delegate /*RemoteObject*/ .runClassMethod (b4a.example.b4xpagesdelegator.class, "_activity_keypress" /*RemoteObject*/ ,(Object)(_keycode));
 BA.debugLineNum = 37;BA.debugLine="End Sub";
Debug.ShouldStop(16);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _activity_pause(RemoteObject _userclosed) throws Exception{
try {
		Debug.PushSubsStack("Activity_Pause (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,43);
if (RapidSub.canDelegate("activity_pause")) { return b4a.example.main.remoteMe.runUserSub(false, "main","activity_pause", _userclosed);}
Debug.locals.put("UserClosed", _userclosed);
 BA.debugLineNum = 43;BA.debugLine="Sub Activity_Pause (UserClosed As Boolean)";
Debug.ShouldStop(1024);
 BA.debugLineNum = 44;BA.debugLine="B4XPages.Delegate.Activity_Pause";
Debug.ShouldStop(2048);
main.mostCurrent._b4xpages._delegate /*RemoteObject*/ .runClassMethod (b4a.example.b4xpagesdelegator.class, "_activity_pause" /*RemoteObject*/ );
 BA.debugLineNum = 45;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _activity_permissionresult(RemoteObject _permission,RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Activity_PermissionResult (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,47);
if (RapidSub.canDelegate("activity_permissionresult")) { return b4a.example.main.remoteMe.runUserSub(false, "main","activity_permissionresult", _permission, _result);}
Debug.locals.put("Permission", _permission);
Debug.locals.put("Result", _result);
 BA.debugLineNum = 47;BA.debugLine="Sub Activity_PermissionResult (Permission As Strin";
Debug.ShouldStop(16384);
 BA.debugLineNum = 48;BA.debugLine="B4XPages.Delegate.Activity_PermissionResult(Permi";
Debug.ShouldStop(32768);
main.mostCurrent._b4xpages._delegate /*RemoteObject*/ .runClassMethod (b4a.example.b4xpagesdelegator.class, "_activity_permissionresult" /*RemoteObject*/ ,(Object)(_permission),(Object)(_result));
 BA.debugLineNum = 49;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _activity_resume() throws Exception{
try {
		Debug.PushSubsStack("Activity_Resume (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,39);
if (RapidSub.canDelegate("activity_resume")) { return b4a.example.main.remoteMe.runUserSub(false, "main","activity_resume");}
 BA.debugLineNum = 39;BA.debugLine="Sub Activity_Resume";
Debug.ShouldStop(64);
 BA.debugLineNum = 40;BA.debugLine="B4XPages.Delegate.Activity_Resume";
Debug.ShouldStop(128);
main.mostCurrent._b4xpages._delegate /*RemoteObject*/ .runClassMethod (b4a.example.b4xpagesdelegator.class, "_activity_resume" /*RemoteObject*/ );
 BA.debugLineNum = 41;BA.debugLine="End Sub";
Debug.ShouldStop(256);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _create_menu(RemoteObject _menu) throws Exception{
try {
		Debug.PushSubsStack("Create_Menu (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,51);
if (RapidSub.canDelegate("create_menu")) { return b4a.example.main.remoteMe.runUserSub(false, "main","create_menu", _menu);}
Debug.locals.put("Menu", _menu);
 BA.debugLineNum = 51;BA.debugLine="Sub Create_Menu (Menu As Object)";
Debug.ShouldStop(262144);
 BA.debugLineNum = 52;BA.debugLine="B4XPages.Delegate.Create_Menu(Menu)";
Debug.ShouldStop(524288);
main.mostCurrent._b4xpages._delegate /*RemoteObject*/ .runClassMethod (b4a.example.b4xpagesdelegator.class, "_create_menu" /*RemoteObject*/ ,(Object)(_menu));
 BA.debugLineNum = 53;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _globals() throws Exception{
 //BA.debugLineNum = 19;BA.debugLine="Sub Globals";
 //BA.debugLineNum = 21;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}

public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main_subs_0._process_globals();
starter_subs_0._process_globals();
b4xpages_subs_0._process_globals();
b4xcollections_subs_0._process_globals();
main.myClass = BA.getDeviceClass ("b4a.example.main");
b4xmainpage.myClass = BA.getDeviceClass ("b4a.example.b4xmainpage");
starter.myClass = BA.getDeviceClass ("b4a.example.starter");
wobblemenu.myClass = BA.getDeviceClass ("b4a.example.wobblemenu");
b4xpages.myClass = BA.getDeviceClass ("b4a.example.b4xpages");
b4xbitset.myClass = BA.getDeviceClass ("b4a.example.b4xbitset");
b4xbytesbuilder.myClass = BA.getDeviceClass ("b4a.example.b4xbytesbuilder");
b4xcollections.myClass = BA.getDeviceClass ("b4a.example.b4xcollections");
b4xorderedmap.myClass = BA.getDeviceClass ("b4a.example.b4xorderedmap");
b4xset.myClass = BA.getDeviceClass ("b4a.example.b4xset");
b4xpagesdelegator.myClass = BA.getDeviceClass ("b4a.example.b4xpagesdelegator");
b4xpagesmanager.myClass = BA.getDeviceClass ("b4a.example.b4xpagesmanager");
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 15;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 17;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}