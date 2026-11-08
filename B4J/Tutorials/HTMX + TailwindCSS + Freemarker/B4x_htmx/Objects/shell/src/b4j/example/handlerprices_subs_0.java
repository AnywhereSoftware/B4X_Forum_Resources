package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class handlerprices_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 4;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _handle(RemoteObject __ref,RemoteObject _req,RemoteObject _resp) throws Exception{
try {
		Debug.PushSubsStack("Handle (handlerprices) ","handlerprices",3,__ref.getField(false, "ba"),__ref,10);
if (RapidSub.canDelegate("handle")) { return __ref.runUserSub(false, "handlerprices","handle", __ref, _req, _resp);}
RemoteObject _root = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
Debug.locals.put("req", _req);
Debug.locals.put("resp", _resp);
 BA.debugLineNum = 10;BA.debugLine="Sub Handle(req As ServletRequest, resp As ServletR";
Debug.ShouldStop(512);
 BA.debugLineNum = 11;BA.debugLine="Dim root As Map = Main.htmx_middleware(req)";
Debug.ShouldStop(1024);
_root = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
_root = handlerprices._main.runMethod(false,"_htmx_middleware" /*RemoteObject*/ ,(Object)(_req));Debug.locals.put("root", _root);Debug.locals.put("root", _root);
 BA.debugLineNum = 13;BA.debugLine="root.Put(\"prices\", CreateMap(\"basic\": 10, \"ultra\"";
Debug.ShouldStop(4096);
_root.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("prices"))),(Object)((handlerprices.__c.runMethod(false, "createMap", (Object)(new RemoteObject[] {RemoteObject.createImmutable(("basic")),RemoteObject.createImmutable((10)),RemoteObject.createImmutable(("ultra")),RemoteObject.createImmutable((30)),RemoteObject.createImmutable(("super_ultra")),RemoteObject.createImmutable((50))})).getObject())));
 BA.debugLineNum = 14;BA.debugLine="Main.answer(resp, \"/prices.html\", root)";
Debug.ShouldStop(8192);
handlerprices._main.runVoidMethod ("_answer" /*RemoteObject*/ ,(Object)(_resp),(Object)(BA.ObjectToString("/prices.html")),(Object)(_root));
 BA.debugLineNum = 15;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
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
		Debug.PushSubsStack("Initialize (handlerprices) ","handlerprices",3,__ref.getField(false, "ba"),__ref,6);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "handlerprices","initialize", __ref, _ba);}
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