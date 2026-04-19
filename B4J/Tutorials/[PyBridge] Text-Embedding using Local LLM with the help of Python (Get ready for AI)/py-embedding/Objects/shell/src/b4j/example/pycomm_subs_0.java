package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class pycomm_subs_0 {


public static RemoteObject  _astream_error(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("AStream_Error (pycomm) ","pycomm",5,__ref.getField(false, "ba"),__ref,111);
if (RapidSub.canDelegate("astream_error")) { return __ref.runUserSub(false, "pycomm","astream_error", __ref);}
 BA.debugLineNum = 111;BA.debugLine="Private Sub AStream_Error";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 112;BA.debugLine="AStream_Terminated";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pycomm.class, "_astream_terminated" /*RemoteObject*/ );
 BA.debugLineNum = 113;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _astream_newdata(RemoteObject __ref,RemoteObject _buffer) throws Exception{
try {
		Debug.PushSubsStack("AStream_NewData (pycomm) ","pycomm",5,__ref.getField(false, "ba"),__ref,60);
if (RapidSub.canDelegate("astream_newdata")) { return __ref.runUserSub(false, "pycomm","astream_newdata", __ref, _buffer);}
RemoteObject _o = null;
RemoteObject _task = RemoteObject.declareNull("b4j.example.pybridge._pytask");
Debug.locals.put("Buffer", _buffer);
 BA.debugLineNum = 60;BA.debugLine="Private Sub AStream_NewData (Buffer() As Byte)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 61;BA.debugLine="Dim o() As Object = ser.ConvertBytesToObject(Buff";
Debug.JustUpdateDeviceLine();
_o = (__ref.getField(false,"_ser" /*RemoteObject*/ ).runMethod(false,"ConvertBytesToObject",(Object)(_buffer)));Debug.locals.put("o", _o);Debug.locals.put("o", _o);
 BA.debugLineNum = 62;BA.debugLine="Dim Task As PyTask = mBridge.Utils.CreatePyTask(o";
Debug.JustUpdateDeviceLine();
_task = __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_createpytask" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, _o.getArrayElement(false,BA.numberCast(int.class, 0)))),(Object)(BA.numberCast(int.class, _o.getArrayElement(false,BA.numberCast(int.class, 1)))),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), _o.getArrayElement(false,BA.numberCast(int.class, 2))));Debug.locals.put("Task", _task);Debug.locals.put("Task", _task);
 BA.debugLineNum = 63;BA.debugLine="If WaitingTasks.ContainsKey(Task.TaskId) Then";
Debug.JustUpdateDeviceLine();
if (__ref.getField(false,"_waitingtasks" /*RemoteObject*/ ).runMethod(true,"ContainsKey",(Object)((_task.getField(true,"TaskId" /*RemoteObject*/ )))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 64;BA.debugLine="jME.RunMethod(\"raiseEventWithSenderFilter\", Arra";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_jme" /*RemoteObject*/ ).runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("raiseEventWithSenderFilter")),(Object)(RemoteObject.createNewArray("Object",new int[] {4},new Object[] {(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ )),RemoteObject.createImmutable(("asynctask_received")),__ref.getField(false,"_waitingtasks" /*RemoteObject*/ ).runMethod(false,"Remove",(Object)((_task.getField(true,"TaskId" /*RemoteObject*/ )))),(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(_task)}))})));
 }else {
 BA.debugLineNum = 66;BA.debugLine="CallSub2(mBridge, \"Task_Received\", Task)";
Debug.JustUpdateDeviceLine();
pycomm.__c.runMethodAndSync(false,"CallSubNew2",__ref.getField(false, "ba"),(Object)((__ref.getField(false,"_mbridge" /*RemoteObject*/ ))),(Object)(BA.ObjectToString("Task_Received")),(Object)((_task)));
 };
 BA.debugLineNum = 68;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _astream_terminated(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("AStream_Terminated (pycomm) ","pycomm",5,__ref.getField(false, "ba"),__ref,115);
if (RapidSub.canDelegate("astream_terminated")) { return __ref.runUserSub(false, "pycomm","astream_terminated", __ref);}
 BA.debugLineNum = 115;BA.debugLine="Private Sub AStream_Terminated";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 116;BA.debugLine="ChangeState(STATE_DISCONNECTED)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pycomm.class, "_changestate" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_state_disconnected" /*RemoteObject*/ )));
 BA.debugLineNum = 117;BA.debugLine="BufferedTasks.Clear";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_bufferedtasks" /*RemoteObject*/ ).runVoidMethod ("Clear");
 BA.debugLineNum = 118;BA.debugLine="srvr.Close";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_srvr" /*RemoteObject*/ ).runVoidMethod ("Close");
 BA.debugLineNum = 119;BA.debugLine="If astream.IsInitialized Then astream.Close";
Debug.JustUpdateDeviceLine();
if (__ref.getField(false,"_astream" /*RemoteObject*/ ).runMethod(true,"IsInitialized").<Boolean>get().booleanValue()) { 
__ref.getField(false,"_astream" /*RemoteObject*/ ).runVoidMethod ("Close");};
 BA.debugLineNum = 120;BA.debugLine="mBridge.Utils.PyLog(mBridge.Utils.B4JPrefix, mBri";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_pylog" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_b4jprefix" /*RemoteObject*/ )),(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"B4JColor" /*RemoteObject*/ )),(Object)((RemoteObject.createImmutable("disconnected"))));
 BA.debugLineNum = 121;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _changestate(RemoteObject __ref,RemoteObject _newstate) throws Exception{
try {
		Debug.PushSubsStack("ChangeState (pycomm) ","pycomm",5,__ref.getField(false, "ba"),__ref,123);
if (RapidSub.canDelegate("changestate")) { return __ref.runUserSub(false, "pycomm","changestate", __ref, _newstate);}
RemoteObject _oldstate = RemoteObject.createImmutable(0);
Debug.locals.put("NewState", _newstate);
 BA.debugLineNum = 123;BA.debugLine="Private Sub ChangeState (NewState As Int)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 124;BA.debugLine="If NewState = State Then Return";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_newstate,BA.numberCast(double.class, __ref.getField(true,"_state" /*RemoteObject*/ )))) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 125;BA.debugLine="Dim OldState As Int = State";
Debug.JustUpdateDeviceLine();
_oldstate = __ref.getField(true,"_state" /*RemoteObject*/ );Debug.locals.put("OldState", _oldstate);Debug.locals.put("OldState", _oldstate);
 BA.debugLineNum = 126;BA.debugLine="State = NewState";
Debug.JustUpdateDeviceLine();
__ref.setField ("_state" /*RemoteObject*/ ,_newstate);
 BA.debugLineNum = 127;BA.debugLine="CallSub3(mBridge, \"state_changed\", OldState, Stat";
Debug.JustUpdateDeviceLine();
pycomm.__c.runMethodAndSync(false,"CallSubNew3",__ref.getField(false, "ba"),(Object)((__ref.getField(false,"_mbridge" /*RemoteObject*/ ))),(Object)(BA.ObjectToString("state_changed")),(Object)((_oldstate)),(Object)((__ref.getField(true,"_state" /*RemoteObject*/ ))));
 BA.debugLineNum = 128;BA.debugLine="End Sub";
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
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 3;BA.debugLine="Private srvr As ServerSocket";
pycomm._srvr = RemoteObject.createNew ("anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper");__ref.setField("_srvr",pycomm._srvr);
 //BA.debugLineNum = 4;BA.debugLine="Public const STATE_DISCONNECTED = 1, STATE_CONNEC";
pycomm._state_disconnected = BA.numberCast(int.class, 1);__ref.setField("_state_disconnected",pycomm._state_disconnected);
pycomm._state_connected = BA.numberCast(int.class, 2);__ref.setField("_state_connected",pycomm._state_connected);
pycomm._state_waiting_for_connection = BA.numberCast(int.class, 3);__ref.setField("_state_waiting_for_connection",pycomm._state_waiting_for_connection);
 //BA.debugLineNum = 5;BA.debugLine="Public State As Int";
pycomm._state = RemoteObject.createImmutable(0);__ref.setField("_state",pycomm._state);
 //BA.debugLineNum = 6;BA.debugLine="Public Port As Int";
pycomm._port = RemoteObject.createImmutable(0);__ref.setField("_port",pycomm._port);
 //BA.debugLineNum = 7;BA.debugLine="Private mBridge As PyBridge";
pycomm._mbridge = RemoteObject.createNew ("b4j.example.pybridge");__ref.setField("_mbridge",pycomm._mbridge);
 //BA.debugLineNum = 8;BA.debugLine="Private astream As AsyncStreams";
pycomm._astream = RemoteObject.createNew ("anywheresoftware.b4a.randomaccessfile.AsyncStreams");__ref.setField("_astream",pycomm._astream);
 //BA.debugLineNum = 9;BA.debugLine="Private ser As B4XSerializator";
pycomm._ser = RemoteObject.createNew ("anywheresoftware.b4a.randomaccessfile.B4XSerializator");__ref.setField("_ser",pycomm._ser);
 //BA.debugLineNum = 10;BA.debugLine="Private WaitingTasks As Map";
pycomm._waitingtasks = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");__ref.setField("_waitingtasks",pycomm._waitingtasks);
 //BA.debugLineNum = 11;BA.debugLine="Private jME As JavaObject";
pycomm._jme = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");__ref.setField("_jme",pycomm._jme);
 //BA.debugLineNum = 12;BA.debugLine="Public BufferedTasks As List";
pycomm._bufferedtasks = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");__ref.setField("_bufferedtasks",pycomm._bufferedtasks);
 //BA.debugLineNum = 13;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _closeserver(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("CloseServer (pycomm) ","pycomm",5,__ref.getField(false, "ba"),__ref,50);
if (RapidSub.canDelegate("closeserver")) { return __ref.runUserSub(false, "pycomm","closeserver", __ref);}
 BA.debugLineNum = 50;BA.debugLine="Public Sub CloseServer";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 51;BA.debugLine="If State = STATE_CONNECTED Or State = STATE_WAITI";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_state" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(true,"_state_connected" /*RemoteObject*/ ))) || RemoteObject.solveBoolean("=",__ref.getField(true,"_state" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(true,"_state_waiting_for_connection" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 52;BA.debugLine="If astream.IsInitialized Then";
Debug.JustUpdateDeviceLine();
if (__ref.getField(false,"_astream" /*RemoteObject*/ ).runMethod(true,"IsInitialized").<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 53;BA.debugLine="astream.Close";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_astream" /*RemoteObject*/ ).runVoidMethod ("Close");
 };
 BA.debugLineNum = 55;BA.debugLine="srvr.Close";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_srvr" /*RemoteObject*/ ).runVoidMethod ("Close");
 BA.debugLineNum = 56;BA.debugLine="ChangeState(STATE_DISCONNECTED)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pycomm.class, "_changestate" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_state_disconnected" /*RemoteObject*/ )));
 };
 BA.debugLineNum = 58;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _flush(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Flush (pycomm) ","pycomm",5,__ref.getField(false, "ba"),__ref,84);
if (RapidSub.canDelegate("flush")) { return __ref.runUserSub(false, "pycomm","flush", __ref);}
RemoteObject _flattasks = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _task = RemoteObject.declareNull("b4j.example.pybridge._pytask");
RemoteObject _res = RemoteObject.createImmutable(false);
 BA.debugLineNum = 84;BA.debugLine="Public Sub Flush";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 85;BA.debugLine="If BufferedTasks.Size > 0 Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",__ref.getField(false,"_bufferedtasks" /*RemoteObject*/ ).runMethod(true,"getSize"),BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 86;BA.debugLine="Dim FlatTasks As List";
Debug.JustUpdateDeviceLine();
_flattasks = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("FlatTasks", _flattasks);
 BA.debugLineNum = 87;BA.debugLine="FlatTasks.Initialize";
Debug.JustUpdateDeviceLine();
_flattasks.runVoidMethod ("Initialize");
 BA.debugLineNum = 88;BA.debugLine="For Each Task As PyTask In BufferedTasks";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group4 = __ref.getField(false,"_bufferedtasks" /*RemoteObject*/ );
final int groupLen4 = group4.runMethod(true,"getSize").<Integer>get()
;int index4 = 0;
;
for (; index4 < groupLen4;index4++){
_task = (group4.runMethod(false,"Get",index4));Debug.locals.put("Task", _task);
Debug.locals.put("Task", _task);
 BA.debugLineNum = 89;BA.debugLine="If Task.TaskType = mBridge.Utils.TASK_TYPE_RUN";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_task.getField(true,"TaskType" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_task_type_run" /*RemoteObject*/ ))) || RemoteObject.solveBoolean("=",_task.getField(true,"TaskType" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_task_type_run_async" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 90;BA.debugLine="mBridge.Utils.UnwrapBeforeSerialization(Task.E";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_unwrapbeforeserialization" /*RemoteObject*/ ,(Object)(_task.getField(false,"Extra" /*RemoteObject*/ )));
 };
 BA.debugLineNum = 92;BA.debugLine="FlatTasks.AddAll(Array(Task.TaskId, Task.TaskTy";
Debug.JustUpdateDeviceLine();
_flattasks.runVoidMethod ("AddAll",(Object)(pycomm.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {3},new Object[] {(_task.getField(true,"TaskId" /*RemoteObject*/ )),(_task.getField(true,"TaskType" /*RemoteObject*/ )),(_task.getField(false,"Extra" /*RemoteObject*/ ).getObject())})))));
 }
}Debug.locals.put("Task", _task);
;
 BA.debugLineNum = 94;BA.debugLine="Dim res As Boolean = astream.Write(ser.ConvertOb";
Debug.JustUpdateDeviceLine();
_res = __ref.getField(false,"_astream" /*RemoteObject*/ ).runMethod(true,"Write",(Object)(__ref.getField(false,"_ser" /*RemoteObject*/ ).runMethod(false,"ConvertObjectToBytes",(Object)((_flattasks.getObject())))));Debug.locals.put("res", _res);Debug.locals.put("res", _res);
 BA.debugLineNum = 95;BA.debugLine="If astream.OutputQueueSize > 100 Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",__ref.getField(false,"_astream" /*RemoteObject*/ ).runMethod(true,"getOutputQueueSize"),BA.numberCast(double.class, 100))) { 
 BA.debugLineNum = 96;BA.debugLine="mBridge.Utils.PyLog(mBridge.Utils.B4JPrefix, mB";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_pylog" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_b4jprefix" /*RemoteObject*/ )),(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"B4JColor" /*RemoteObject*/ )),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Output queue size: "),__ref.getField(false,"_astream" /*RemoteObject*/ ).runMethod(true,"getOutputQueueSize")))));
 };
 BA.debugLineNum = 98;BA.debugLine="If res = False And astream.OutputQueueSize > 0 T";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_res,pycomm.__c.getField(true,"False")) && RemoteObject.solveBoolean(">",__ref.getField(false,"_astream" /*RemoteObject*/ ).runMethod(true,"getOutputQueueSize"),BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 99;BA.debugLine="LogError(\"Queue is full!\")";
Debug.JustUpdateDeviceLine();
pycomm.__c.runVoidMethod ("LogError",(Object)(RemoteObject.createImmutable("Queue is full!")));
 };
 BA.debugLineNum = 101;BA.debugLine="BufferedTasks.Clear";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_bufferedtasks" /*RemoteObject*/ ).runVoidMethod ("Clear");
 };
 BA.debugLineNum = 103;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _bridge,RemoteObject _localport) throws Exception{
try {
		Debug.PushSubsStack("Initialize (pycomm) ","pycomm",5,__ref.getField(false, "ba"),__ref,15);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "pycomm","initialize", __ref, _ba, _bridge, _localport);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
RemoteObject _jo = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _correctclassesnames = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
Debug.locals.put("ba", _ba);
Debug.locals.put("Bridge", _bridge);
Debug.locals.put("LocalPort", _localport);
 BA.debugLineNum = 15;BA.debugLine="Public Sub Initialize (Bridge As PyBridge, LocalPo";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 16;BA.debugLine="InitializeWithLoopback(srvr, \"srvr\", LocalPort)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pycomm.class, "_initializewithloopback" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_srvr" /*RemoteObject*/ )),(Object)(BA.ObjectToString("srvr")),(Object)(_localport));
 BA.debugLineNum = 17;BA.debugLine="Dim jo As JavaObject";
Debug.JustUpdateDeviceLine();
_jo = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");Debug.locals.put("jo", _jo);
 BA.debugLineNum = 18;BA.debugLine="Dim correctClassesNames As Map = jo.InitializeSta";
Debug.JustUpdateDeviceLine();
_correctclassesnames = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
_correctclassesnames = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _jo.runMethod(false,"InitializeStatic",(Object)(RemoteObject.createImmutable("anywheresoftware.b4a.randomaccessfile.RandomAccessFile"))).runMethod(false,"GetField",(Object)(RemoteObject.createImmutable("correctedClasses"))));Debug.locals.put("correctClassesNames", _correctclassesnames);Debug.locals.put("correctClassesNames", _correctclassesnames);
 BA.debugLineNum = 19;BA.debugLine="correctClassesNames.Put(\"_pyobject\", GetType(Brid";
Debug.JustUpdateDeviceLine();
_correctclassesnames.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("_pyobject"))),(Object)((RemoteObject.concat(pycomm.__c.runMethod(true,"GetType",(Object)((_bridge))),RemoteObject.createImmutable("$_pyobject")))));
 BA.debugLineNum = 20;BA.debugLine="jME = Me";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_jme" /*RemoteObject*/ ).setObject (__ref);
 BA.debugLineNum = 21;BA.debugLine="WaitingTasks.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_waitingtasks" /*RemoteObject*/ ).runVoidMethod ("Initialize");
 BA.debugLineNum = 22;BA.debugLine="Port = srvr.As(JavaObject).GetFieldJO(\"ssocket\").";
Debug.JustUpdateDeviceLine();
__ref.setField ("_port" /*RemoteObject*/ ,BA.numberCast(int.class, (RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), __ref.getField(false,"_srvr" /*RemoteObject*/ ))).runMethod(false,"GetFieldJO",(Object)(RemoteObject.createImmutable("ssocket"))).runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getLocalPort")),(Object)((pycomm.__c.getField(false,"Null"))))));
 BA.debugLineNum = 23;BA.debugLine="mBridge = Bridge";
Debug.JustUpdateDeviceLine();
__ref.setField ("_mbridge" /*RemoteObject*/ ,_bridge);
 BA.debugLineNum = 24;BA.debugLine="mBridge.Utils.PyLog(mBridge.Utils.B4JPrefix, mBri";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_pylog" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_b4jprefix" /*RemoteObject*/ )),(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"B4JColor" /*RemoteObject*/ )),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Server is listening on port: "),__ref.getField(true,"_port" /*RemoteObject*/ )))));
 BA.debugLineNum = 25;BA.debugLine="srvr.Listen";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_srvr" /*RemoteObject*/ ).runVoidMethod ("Listen");
 BA.debugLineNum = 26;BA.debugLine="BufferedTasks.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_bufferedtasks" /*RemoteObject*/ ).runVoidMethod ("Initialize");
 BA.debugLineNum = 27;BA.debugLine="State = STATE_WAITING_FOR_CONNECTION";
Debug.JustUpdateDeviceLine();
__ref.setField ("_state" /*RemoteObject*/ ,__ref.getField(true,"_state_waiting_for_connection" /*RemoteObject*/ ));
 BA.debugLineNum = 28;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initializewithloopback(RemoteObject __ref,RemoteObject _server,RemoteObject _eventname,RemoteObject _vport) throws Exception{
try {
		Debug.PushSubsStack("InitializeWithLoopback (pycomm) ","pycomm",5,__ref.getField(false, "ba"),__ref,30);
if (RapidSub.canDelegate("initializewithloopback")) { return __ref.runUserSub(false, "pycomm","initializewithloopback", __ref, _server, _eventname, _vport);}
RemoteObject _ia = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _s = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _socket = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
Debug.locals.put("Server", _server);
Debug.locals.put("EventName", _eventname);
Debug.locals.put("vPort", _vport);
 BA.debugLineNum = 30;BA.debugLine="Private Sub InitializeWithLoopback(Server As Serve";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 31;BA.debugLine="Server.Initialize(-1, EventName)";
Debug.JustUpdateDeviceLine();
_server.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(BA.numberCast(int.class, -(double) (0 + 1))),(Object)(_eventname));
 BA.debugLineNum = 32;BA.debugLine="Dim ia As JavaObject";
Debug.JustUpdateDeviceLine();
_ia = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");Debug.locals.put("ia", _ia);
 BA.debugLineNum = 33;BA.debugLine="ia = ia.InitializeStatic(\"java.net.InetAddress\").";
Debug.JustUpdateDeviceLine();
_ia = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _ia.runMethod(false,"InitializeStatic",(Object)(RemoteObject.createImmutable("java.net.InetAddress"))).runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getLoopbackAddress")),(Object)((pycomm.__c.getField(false,"Null")))));Debug.locals.put("ia", _ia);
 BA.debugLineNum = 34;BA.debugLine="Dim s As JavaObject = Server";
Debug.JustUpdateDeviceLine();
_s = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_s = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _server);Debug.locals.put("s", _s);Debug.locals.put("s", _s);
 BA.debugLineNum = 35;BA.debugLine="Dim socket As JavaObject";
Debug.JustUpdateDeviceLine();
_socket = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");Debug.locals.put("socket", _socket);
 BA.debugLineNum = 36;BA.debugLine="socket.InitializeNewInstance(\"java.net.ServerSock";
Debug.JustUpdateDeviceLine();
_socket.runVoidMethod ("InitializeNewInstance",(Object)(BA.ObjectToString("java.net.ServerSocket")),(Object)(RemoteObject.createNewArray("Object",new int[] {3},new Object[] {(_vport),RemoteObject.createImmutable((50)),(_ia.getObject())})));
 BA.debugLineNum = 37;BA.debugLine="s.SetField(\"ssocket\", socket)";
Debug.JustUpdateDeviceLine();
_s.runVoidMethod ("SetField",(Object)(BA.ObjectToString("ssocket")),(Object)((_socket.getObject())));
 BA.debugLineNum = 38;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _movetasktolast(RemoteObject __ref,RemoteObject _task) throws Exception{
try {
		Debug.PushSubsStack("MoveTaskToLast (pycomm) ","pycomm",5,__ref.getField(false, "ba"),__ref,75);
if (RapidSub.canDelegate("movetasktolast")) { return __ref.runUserSub(false, "pycomm","movetasktolast", __ref, _task);}
RemoteObject _i = RemoteObject.createImmutable(0);
Debug.locals.put("Task", _task);
 BA.debugLineNum = 75;BA.debugLine="Public Sub MoveTaskToLast(Task As PyTask)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 76;BA.debugLine="If BufferedTasks.Get(BufferedTasks.Size - 1) = Ta";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_bufferedtasks" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_bufferedtasks" /*RemoteObject*/ ).runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1))),(_task))) { 
 BA.debugLineNum = 77;BA.debugLine="Return";
Debug.JustUpdateDeviceLine();
if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 79;BA.debugLine="Dim i As Int = BufferedTasks.IndexOf(Task)";
Debug.JustUpdateDeviceLine();
_i = __ref.getField(false,"_bufferedtasks" /*RemoteObject*/ ).runMethod(true,"IndexOf",(Object)((_task)));Debug.locals.put("i", _i);Debug.locals.put("i", _i);
 BA.debugLineNum = 80;BA.debugLine="BufferedTasks.RemoveAt(i)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_bufferedtasks" /*RemoteObject*/ ).runVoidMethod ("RemoveAt",(Object)(_i));
 BA.debugLineNum = 81;BA.debugLine="BufferedTasks.Add(Task)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_bufferedtasks" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)((_task)));
 BA.debugLineNum = 82;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _sendtask(RemoteObject __ref,RemoteObject _task) throws Exception{
try {
		Debug.PushSubsStack("SendTask (pycomm) ","pycomm",5,__ref.getField(false, "ba"),__ref,70);
if (RapidSub.canDelegate("sendtask")) { return __ref.runUserSub(false, "pycomm","sendtask", __ref, _task);}
Debug.locals.put("Task", _task);
 BA.debugLineNum = 70;BA.debugLine="Public Sub SendTask (Task As PyTask)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 71;BA.debugLine="If BufferedTasks.Size = 0 Then CallSubDelayed(Me,";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_bufferedtasks" /*RemoteObject*/ ).runMethod(true,"getSize"),BA.numberCast(double.class, 0))) { 
pycomm.__c.runVoidMethod ("CallSubDelayed",__ref.getField(false, "ba"),(Object)(__ref),(Object)(RemoteObject.createImmutable("Flush")));};
 BA.debugLineNum = 72;BA.debugLine="BufferedTasks.Add(Task)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_bufferedtasks" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)((_task)));
 BA.debugLineNum = 73;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _sendtaskandwait(RemoteObject __ref,RemoteObject _task) throws Exception{
try {
		Debug.PushSubsStack("SendTaskAndWait (pycomm) ","pycomm",5,__ref.getField(false, "ba"),__ref,105);
if (RapidSub.canDelegate("sendtaskandwait")) { return __ref.runUserSub(false, "pycomm","sendtaskandwait", __ref, _task);}
Debug.locals.put("Task", _task);
 BA.debugLineNum = 105;BA.debugLine="Public Sub SendTaskAndWait (Task As PyTask)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 106;BA.debugLine="WaitingTasks.Put(Task.TaskId, Task)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_waitingtasks" /*RemoteObject*/ ).runVoidMethod ("Put",(Object)((_task.getField(true,"TaskId" /*RemoteObject*/ ))),(Object)((_task)));
 BA.debugLineNum = 107;BA.debugLine="SendTask(Task)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pycomm.class, "_sendtask" /*RemoteObject*/ ,(Object)(_task));
 BA.debugLineNum = 108;BA.debugLine="Flush";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pycomm.class, "_flush" /*RemoteObject*/ );
 BA.debugLineNum = 109;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static void  _srvr_newconnection(RemoteObject __ref,RemoteObject _successful,RemoteObject _newsocket) throws Exception{
try {
		Debug.PushSubsStack("Srvr_NewConnection (pycomm) ","pycomm",5,__ref.getField(false, "ba"),__ref,40);
if (RapidSub.canDelegate("srvr_newconnection")) { __ref.runUserSub(false, "pycomm","srvr_newconnection", __ref, _successful, _newsocket); return;}
ResumableSub_Srvr_NewConnection rsub = new ResumableSub_Srvr_NewConnection(null,__ref,_successful,_newsocket);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_Srvr_NewConnection extends BA.ResumableSub {
public ResumableSub_Srvr_NewConnection(b4j.example.pycomm parent,RemoteObject __ref,RemoteObject _successful,RemoteObject _newsocket) {
this.parent = parent;
this.__ref = __ref;
this._successful = _successful;
this._newsocket = _newsocket;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.pycomm parent;
RemoteObject _successful;
RemoteObject _newsocket;

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("Srvr_NewConnection (pycomm) ","pycomm",5,__ref.getField(false, "ba"),__ref,40);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
Debug.locals.put("_ref", __ref);
Debug.locals.put("Successful", _successful);
Debug.locals.put("NewSocket", _newsocket);
 BA.debugLineNum = 41;BA.debugLine="If Successful Then";
Debug.JustUpdateDeviceLine();
if (true) break;

case 1:
//if
this.state = 4;
if (_successful.<Boolean>get().booleanValue()) { 
this.state = 3;
}if (true) break;

case 3:
//C
this.state = 4;
 BA.debugLineNum = 42;BA.debugLine="mBridge.Utils.PyLog(mBridge.Utils.B4JPrefix, mBr";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_pylog" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_b4jprefix" /*RemoteObject*/ )),(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"B4JColor" /*RemoteObject*/ )),(Object)((RemoteObject.createImmutable("connected"))));
 BA.debugLineNum = 44;BA.debugLine="astream.InitializePrefix(NewSocket.InputStream,";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_astream" /*RemoteObject*/ ).runVoidMethod ("InitializePrefix",__ref.getField(false, "ba"),(Object)(_newsocket.runMethod(false,"getInputStream")),(Object)(parent.__c.getField(true,"True")),(Object)(_newsocket.runMethod(false,"getOutputStream")),(Object)(RemoteObject.createImmutable("astream")));
 BA.debugLineNum = 45;BA.debugLine="Sleep(100)";
Debug.JustUpdateDeviceLine();
parent.__c.runVoidMethod ("Sleep",__ref.getField(false, "ba"),anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pycomm", "srvr_newconnection"),BA.numberCast(int.class, 100));
this.state = 5;
return;
case 5:
//C
this.state = 4;
;
 BA.debugLineNum = 46;BA.debugLine="ChangeState(STATE_CONNECTED)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pycomm.class, "_changestate" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_state_connected" /*RemoteObject*/ )));
 if (true) break;

case 4:
//C
this.state = -1;
;
 BA.debugLineNum = 48;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
if (true) break;

            }
        }
    }
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}
}