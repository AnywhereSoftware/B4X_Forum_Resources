package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class handlercontactus_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 4;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _handle(RemoteObject __ref,RemoteObject _req,RemoteObject _resp) throws Exception{
try {
		Debug.PushSubsStack("Handle (handlercontactus) ","handlercontactus",2,__ref.getField(false, "ba"),__ref,10);
if (RapidSub.canDelegate("handle")) { return __ref.runUserSub(false, "handlercontactus","handle", __ref, _req, _resp);}
RemoteObject _root = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _client = RemoteObject.createImmutable("");
Debug.locals.put("req", _req);
Debug.locals.put("resp", _resp);
 BA.debugLineNum = 10;BA.debugLine="Sub Handle(req As ServletRequest, resp As ServletR";
Debug.ShouldStop(512);
 BA.debugLineNum = 11;BA.debugLine="Dim root As Map = Main.htmx_middleware(req)";
Debug.ShouldStop(1024);
_root = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
_root = handlercontactus._main.runMethod(false,"_htmx_middleware" /*RemoteObject*/ ,(Object)(_req));Debug.locals.put("root", _root);Debug.locals.put("root", _root);
 BA.debugLineNum = 12;BA.debugLine="If req.Method = \"GET\" Then";
Debug.ShouldStop(2048);
if (RemoteObject.solveBoolean("=",_req.runMethod(true,"getMethod"),BA.ObjectToString("GET"))) { 
 BA.debugLineNum = 13;BA.debugLine="Main.answer(resp, \"/contactus.html\", root)";
Debug.ShouldStop(4096);
handlercontactus._main.runVoidMethod ("_answer" /*RemoteObject*/ ,(Object)(_resp),(Object)(BA.ObjectToString("/contactus.html")),(Object)(_root));
 }else {
 BA.debugLineNum = 15;BA.debugLine="Dim client As String = req.GetParameter(\"name\")";
Debug.ShouldStop(16384);
_client = _req.runMethod(true,"GetParameter",(Object)(RemoteObject.createImmutable("name")));Debug.locals.put("client", _client);Debug.locals.put("client", _client);
 BA.debugLineNum = 16;BA.debugLine="root.Put(\"client\", client)";
Debug.ShouldStop(32768);
_root.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("client"))),(Object)((_client)));
 BA.debugLineNum = 17;BA.debugLine="Main.answer(resp, \"/contactus_answer.html\", root";
Debug.ShouldStop(65536);
handlercontactus._main.runVoidMethod ("_answer" /*RemoteObject*/ ,(Object)(_resp),(Object)(BA.ObjectToString("/contactus_answer.html")),(Object)(_root));
 };
 BA.debugLineNum = 19;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
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
		Debug.PushSubsStack("Initialize (handlercontactus) ","handlercontactus",2,__ref.getField(false, "ba"),__ref,6);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "handlercontactus","initialize", __ref, _ba);}
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