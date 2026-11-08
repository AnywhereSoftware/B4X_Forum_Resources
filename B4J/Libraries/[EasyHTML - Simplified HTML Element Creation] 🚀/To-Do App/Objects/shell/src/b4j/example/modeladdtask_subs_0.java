package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class modeladdtask_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 4;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _handle(RemoteObject __ref,RemoteObject _req,RemoteObject _resp) throws Exception{
try {
		Debug.PushSubsStack("Handle (modeladdtask) ","modeladdtask",2,__ref.getField(false, "ba"),__ref,10);
if (RapidSub.canDelegate("handle")) { return __ref.runUserSub(false, "modeladdtask","handle", __ref, _req, _resp);}
RemoteObject _method = RemoteObject.createImmutable("");
RemoteObject _task = RemoteObject.createImmutable("");
Debug.locals.put("req", _req);
Debug.locals.put("resp", _resp);
 BA.debugLineNum = 10;BA.debugLine="Sub Handle(req As ServletRequest, resp As ServletR";
Debug.ShouldStop(512);
 BA.debugLineNum = 11;BA.debugLine="Dim Method As String = req.Method";
Debug.ShouldStop(1024);
_method = _req.runMethod(true,"getMethod");Debug.locals.put("Method", _method);Debug.locals.put("Method", _method);
 BA.debugLineNum = 14;BA.debugLine="Dim Task As String = req.GetParameter(\"task\")";
Debug.ShouldStop(8192);
_task = _req.runMethod(true,"GetParameter",(Object)(RemoteObject.createImmutable("task")));Debug.locals.put("Task", _task);Debug.locals.put("Task", _task);
 BA.debugLineNum = 15;BA.debugLine="Log(\"Method: \"&Method)";
Debug.ShouldStop(16384);
modeladdtask.__c.runVoidMethod ("LogImpl","61507333",RemoteObject.concat(RemoteObject.createImmutable("Method: "),_method),0);
 BA.debugLineNum = 16;BA.debugLine="If Method == \"POST\" Then";
Debug.ShouldStop(32768);
if (RemoteObject.solveBoolean("=",_method,BA.ObjectToString("POST"))) { 
 BA.debugLineNum = 17;BA.debugLine="Try";
Debug.ShouldStop(65536);
try { BA.debugLineNum = 18;BA.debugLine="Main.OpenDB";
Debug.ShouldStop(131072);
modeladdtask._main.runVoidMethod ("_opendb" /*RemoteObject*/ );
 BA.debugLineNum = 19;BA.debugLine="Main.db.ExecNonQuery2(\"INSERT INTO tasks (task)";
Debug.ShouldStop(262144);
modeladdtask._main._db /*RemoteObject*/ .runVoidMethod ("ExecNonQuery2",(Object)(BA.ObjectToString("INSERT INTO tasks (task) VALUES (?)")),(Object)(modeladdtask.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(_task)})))));
 BA.debugLineNum = 20;BA.debugLine="Main.db.Close";
Debug.ShouldStop(524288);
modeladdtask._main._db /*RemoteObject*/ .runVoidMethod ("Close");
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e10) {
			BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e10.toString()); BA.debugLineNum = 22;BA.debugLine="Log(LastException)";
Debug.ShouldStop(2097152);
modeladdtask.__c.runVoidMethod ("LogImpl","61507340",BA.ObjectToString(modeladdtask.__c.runMethod(false,"LastException",__ref.getField(false, "ba"))),0);
 };
 };
 BA.debugLineNum = 26;BA.debugLine="resp.Write(Main.GetListTask)";
Debug.ShouldStop(33554432);
_resp.runVoidMethod ("Write",(Object)(modeladdtask._main.runMethod(true,"_getlisttask" /*RemoteObject*/ )));
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
		Debug.PushSubsStack("Initialize (modeladdtask) ","modeladdtask",2,__ref.getField(false, "ba"),__ref,6);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "modeladdtask","initialize", __ref, _ba);}
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