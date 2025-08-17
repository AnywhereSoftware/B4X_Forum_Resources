package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class handlerlandingpage_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 4;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _handle(RemoteObject __ref,RemoteObject _req,RemoteObject _resp) throws Exception{
try {
		Debug.PushSubsStack("Handle (handlerlandingpage) ","handlerlandingpage",1,__ref.getField(false, "ba"),__ref,10);
if (RapidSub.canDelegate("handle")) { return __ref.runUserSub(false, "handlerlandingpage","handle", __ref, _req, _resp);}
RemoteObject _root = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
Debug.locals.put("req", _req);
Debug.locals.put("resp", _resp);
 BA.debugLineNum = 10;BA.debugLine="Sub Handle(req As ServletRequest, resp As ServletR";
Debug.ShouldStop(512);
 BA.debugLineNum = 11;BA.debugLine="Dim root As Map = Main.htmx_middleware(req)";
Debug.ShouldStop(1024);
_root = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
_root = handlerlandingpage._main.runMethod(false,"_htmx_middleware" /*RemoteObject*/ ,(Object)(_req));Debug.locals.put("root", _root);Debug.locals.put("root", _root);
 BA.debugLineNum = 12;BA.debugLine="root.Put(\"user\", GetSystemProperty(\"user.name\", \"";
Debug.ShouldStop(2048);
_root.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("user"))),(Object)((handlerlandingpage.__c.runMethod(true,"GetSystemProperty",(Object)(BA.ObjectToString("user.name")),(Object)(RemoteObject.createImmutable("Just a ghost"))))));
 BA.debugLineNum = 14;BA.debugLine="Main.answer(resp, \"/landingpage.html\", root)";
Debug.ShouldStop(8192);
handlerlandingpage._main.runVoidMethod ("_answer" /*RemoteObject*/ ,(Object)(_resp),(Object)(BA.ObjectToString("/landingpage.html")),(Object)(_root));
 BA.debugLineNum = 17;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
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
		Debug.PushSubsStack("Initialize (handlerlandingpage) ","handlerlandingpage",1,__ref.getField(false, "ba"),__ref,6);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "handlerlandingpage","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 6;BA.debugLine="Public Sub Initialize";
Debug.ShouldStop(32);
 BA.debugLineNum = 8;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}