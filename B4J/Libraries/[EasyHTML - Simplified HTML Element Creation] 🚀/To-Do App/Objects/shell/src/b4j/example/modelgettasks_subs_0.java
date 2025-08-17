package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class modelgettasks_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 4;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _handle(RemoteObject __ref,RemoteObject _req,RemoteObject _resp) throws Exception{
try {
		Debug.PushSubsStack("Handle (modelgettasks) ","modelgettasks",4,__ref.getField(false, "ba"),__ref,10);
if (RapidSub.canDelegate("handle")) { return __ref.runUserSub(false, "modelgettasks","handle", __ref, _req, _resp);}
RemoteObject _method = RemoteObject.createImmutable("");
Debug.locals.put("req", _req);
Debug.locals.put("resp", _resp);
 BA.debugLineNum = 10;BA.debugLine="Sub Handle(req As ServletRequest, resp As ServletR";
Debug.ShouldStop(512);
 BA.debugLineNum = 11;BA.debugLine="Dim Method As String = req.Method";
Debug.ShouldStop(1024);
_method = _req.runMethod(true,"getMethod");Debug.locals.put("Method", _method);Debug.locals.put("Method", _method);
 BA.debugLineNum = 12;BA.debugLine="Log(\"Method: \"&Method)";
Debug.ShouldStop(2048);
modelgettasks.__c.runVoidMethod ("LogImpl","61900546",RemoteObject.concat(RemoteObject.createImmutable("Method: "),_method),0);
 BA.debugLineNum = 13;BA.debugLine="If Method == \"GET\" Then";
Debug.ShouldStop(4096);
if (RemoteObject.solveBoolean("=",_method,BA.ObjectToString("GET"))) { 
 BA.debugLineNum = 14;BA.debugLine="resp.Write(Main.GetListTask)";
Debug.ShouldStop(8192);
_resp.runVoidMethod ("Write",(Object)(modelgettasks._main.runMethod(true,"_getlisttask" /*RemoteObject*/ )));
 };
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
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (modelgettasks) ","modelgettasks",4,__ref.getField(false, "ba"),__ref,6);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "modelgettasks","initialize", __ref, _ba);}
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