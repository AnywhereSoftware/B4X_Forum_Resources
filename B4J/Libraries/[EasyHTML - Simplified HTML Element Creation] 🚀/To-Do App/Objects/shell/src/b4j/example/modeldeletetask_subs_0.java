package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class modeldeletetask_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 4;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _handle(RemoteObject __ref,RemoteObject _req,RemoteObject _resp) throws Exception{
try {
		Debug.PushSubsStack("Handle (modeldeletetask) ","modeldeletetask",3,__ref.getField(false, "ba"),__ref,10);
if (RapidSub.canDelegate("handle")) { return __ref.runUserSub(false, "modeldeletetask","handle", __ref, _req, _resp);}
RemoteObject _method = RemoteObject.createImmutable("");
RemoteObject _id = RemoteObject.createImmutable("");
Debug.locals.put("req", _req);
Debug.locals.put("resp", _resp);
 BA.debugLineNum = 10;BA.debugLine="Sub Handle(req As ServletRequest, resp As ServletR";
Debug.ShouldStop(512);
 BA.debugLineNum = 11;BA.debugLine="Dim Method As String = req.Method";
Debug.ShouldStop(1024);
_method = _req.runMethod(true,"getMethod");Debug.locals.put("Method", _method);Debug.locals.put("Method", _method);
 BA.debugLineNum = 12;BA.debugLine="Dim Id As String = req.GetParameter(\"id\")";
Debug.ShouldStop(2048);
_id = _req.runMethod(true,"GetParameter",(Object)(RemoteObject.createImmutable("id")));Debug.locals.put("Id", _id);Debug.locals.put("Id", _id);
 BA.debugLineNum = 13;BA.debugLine="Log(\"Method: \"&Method)";
Debug.ShouldStop(4096);
modeldeletetask.__c.runVoidMethod ("LogImpl","61703939",RemoteObject.concat(RemoteObject.createImmutable("Method: "),_method),0);
 BA.debugLineNum = 14;BA.debugLine="Log(\"[ID Task] \"&Id)";
Debug.ShouldStop(8192);
modeldeletetask.__c.runVoidMethod ("LogImpl","61703940",RemoteObject.concat(RemoteObject.createImmutable("[ID Task] "),_id),0);
 BA.debugLineNum = 15;BA.debugLine="If Method == \"POST\" Then";
Debug.ShouldStop(16384);
if (RemoteObject.solveBoolean("=",_method,BA.ObjectToString("POST"))) { 
 BA.debugLineNum = 16;BA.debugLine="Try";
Debug.ShouldStop(32768);
try { BA.debugLineNum = 17;BA.debugLine="Main.OpenDB";
Debug.ShouldStop(65536);
modeldeletetask._main.runVoidMethod ("_opendb" /*RemoteObject*/ );
 BA.debugLineNum = 18;BA.debugLine="Main.db.ExecNonQuery2(\"DELETE FROM tasks WHERE";
Debug.ShouldStop(131072);
modeldeletetask._main._db /*RemoteObject*/ .runVoidMethod ("ExecNonQuery2",(Object)(BA.ObjectToString("DELETE FROM tasks WHERE id = ?")),(Object)(modeldeletetask.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(_id)})))));
 BA.debugLineNum = 19;BA.debugLine="Main.db.Close";
Debug.ShouldStop(262144);
modeldeletetask._main._db /*RemoteObject*/ .runVoidMethod ("Close");
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e11) {
			BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e11.toString()); BA.debugLineNum = 21;BA.debugLine="Log(LastException)";
Debug.ShouldStop(1048576);
modeldeletetask.__c.runVoidMethod ("LogImpl","61703947",BA.ObjectToString(modeldeletetask.__c.runMethod(false,"LastException",__ref.getField(false, "ba"))),0);
 };
 };
 BA.debugLineNum = 26;BA.debugLine="resp.Write(Main.GetListTask)";
Debug.ShouldStop(33554432);
_resp.runVoidMethod ("Write",(Object)(modeldeletetask._main.runMethod(true,"_getlisttask" /*RemoteObject*/ )));
 BA.debugLineNum = 27;BA.debugLine="End Sub";
Debug.ShouldStop(67108864);
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
		Debug.PushSubsStack("Initialize (modeldeletetask) ","modeldeletetask",3,__ref.getField(false, "ba"),__ref,6);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "modeldeletetask","initialize", __ref, _ba);}
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