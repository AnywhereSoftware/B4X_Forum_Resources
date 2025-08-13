package b4a.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xmainpage_subs_0 {


public static RemoteObject  _b4xpage_created(RemoteObject __ref,RemoteObject _root1) throws Exception{
try {
		Debug.PushSubsStack("B4XPage_Created (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,50);
if (RapidSub.canDelegate("b4xpage_created")) { return __ref.runUserSub(false, "b4xmainpage","b4xpage_created", __ref, _root1);}
Debug.locals.put("Root1", _root1);
 BA.debugLineNum = 50;BA.debugLine="Private Sub B4XPage_Created (Root1 As B4XView)";
Debug.ShouldStop(131072);
 BA.debugLineNum = 51;BA.debugLine="Root = Root1";
Debug.ShouldStop(262144);
__ref.setField ("_root" /*RemoteObject*/ ,_root1);
 BA.debugLineNum = 52;BA.debugLine="Root.LoadLayout(\"MainPage\")";
Debug.ShouldStop(524288);
__ref.getField(false,"_root" /*RemoteObject*/ ).runVoidMethodAndSync ("LoadLayout",(Object)(RemoteObject.createImmutable("MainPage")),__ref.getField(false, "ba"));
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
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 37;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 38;BA.debugLine="Private Root As B4XView";
b4xmainpage._root = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_root",b4xmainpage._root);
 //BA.debugLineNum = 39;BA.debugLine="Private xui As XUI";
b4xmainpage._xui = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");__ref.setField("_xui",b4xmainpage._xui);
 //BA.debugLineNum = 42;BA.debugLine="Private TD_SwipePanel1 As TD_SwipePanel";
b4xmainpage._td_swipepanel1 = RemoteObject.createNew ("b4a.example.td_swipepanel");__ref.setField("_td_swipepanel1",b4xmainpage._td_swipepanel1);
 //BA.debugLineNum = 44;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,46);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "b4xmainpage","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 46;BA.debugLine="Public Sub Initialize";
Debug.ShouldStop(8192);
 BA.debugLineNum = 48;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _td_swipepanel1_scrollchanged(RemoteObject __ref,RemoteObject _posx,RemoteObject _posy) throws Exception{
try {
		Debug.PushSubsStack("TD_SwipePanel1_ScrollChanged (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,59);
if (RapidSub.canDelegate("td_swipepanel1_scrollchanged")) { return __ref.runUserSub(false, "b4xmainpage","td_swipepanel1_scrollchanged", __ref, _posx, _posy);}
Debug.locals.put("PosX", _posx);
Debug.locals.put("PosY", _posy);
 BA.debugLineNum = 59;BA.debugLine="Private Sub TD_SwipePanel1_ScrollChanged(PosX As I";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 60;BA.debugLine="Log(PosY & \"/\" & PosY)";
Debug.ShouldStop(134217728);
b4xmainpage.__c.runVoidMethod ("LogImpl","211468801",RemoteObject.concat(_posy,RemoteObject.createImmutable("/"),_posy),0);
 BA.debugLineNum = 61;BA.debugLine="End Sub";
Debug.ShouldStop(268435456);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}