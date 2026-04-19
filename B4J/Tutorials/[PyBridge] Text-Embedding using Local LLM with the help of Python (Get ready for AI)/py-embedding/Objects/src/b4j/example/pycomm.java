package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class pycomm extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.pycomm", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.pycomm.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 
    public void  innerInitializeHelper(anywheresoftware.b4a.BA _ba) throws Exception{
        innerInitialize(_ba);
    }
    public Object callSub(String sub, Object sender, Object[] args) throws Exception {
        return BA.SubDelegator.SubNotFound;
    }
public anywheresoftware.b4a.keywords.Common __c = null;
public anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper _srvr = null;
public int _state_disconnected = 0;
public int _state_connected = 0;
public int _state_waiting_for_connection = 0;
public int _state = 0;
public int _port = 0;
public b4j.example.pybridge _mbridge = null;
public anywheresoftware.b4a.randomaccessfile.AsyncStreams _astream = null;
public anywheresoftware.b4a.randomaccessfile.B4XSerializator _ser = null;
public anywheresoftware.b4a.objects.collections.Map _waitingtasks = null;
public anywheresoftware.b4j.object.JavaObject _jme = null;
public anywheresoftware.b4a.objects.collections.List _bufferedtasks = null;
public b4j.example.main _main = null;
public b4j.example.b4xcollections _b4xcollections = null;
public String  _closeserver(b4j.example.pycomm __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pycomm";
if (Debug.shouldDelegate(ba, "closeserver", true))
	 {return ((String) Debug.delegate(ba, "closeserver", null));}
RDebugUtils.currentLine=3473408;
 //BA.debugLineNum = 3473408;BA.debugLine="Public Sub CloseServer";
RDebugUtils.currentLine=3473409;
 //BA.debugLineNum = 3473409;BA.debugLine="If State = STATE_CONNECTED Or State = STATE_WAITI";
if (__ref._state /*int*/ ==__ref._state_connected /*int*/  || __ref._state /*int*/ ==__ref._state_waiting_for_connection /*int*/ ) { 
RDebugUtils.currentLine=3473410;
 //BA.debugLineNum = 3473410;BA.debugLine="If astream.IsInitialized Then";
if (__ref._astream /*anywheresoftware.b4a.randomaccessfile.AsyncStreams*/ .IsInitialized()) { 
RDebugUtils.currentLine=3473411;
 //BA.debugLineNum = 3473411;BA.debugLine="astream.Close";
__ref._astream /*anywheresoftware.b4a.randomaccessfile.AsyncStreams*/ .Close();
 };
RDebugUtils.currentLine=3473413;
 //BA.debugLineNum = 3473413;BA.debugLine="srvr.Close";
__ref._srvr /*anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper*/ .Close();
RDebugUtils.currentLine=3473414;
 //BA.debugLineNum = 3473414;BA.debugLine="ChangeState(STATE_DISCONNECTED)";
__ref._changestate /*String*/ (null,__ref._state_disconnected /*int*/ );
 };
RDebugUtils.currentLine=3473416;
 //BA.debugLineNum = 3473416;BA.debugLine="End Sub";
return "";
}
public String  _initialize(b4j.example.pycomm __ref,anywheresoftware.b4a.BA _ba,b4j.example.pybridge _bridge,int _localport) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="pycomm";
if (Debug.shouldDelegate(ba, "initialize", true))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba,_bridge,_localport}));}
anywheresoftware.b4j.object.JavaObject _jo = null;
anywheresoftware.b4a.objects.collections.Map _correctclassesnames = null;
RDebugUtils.currentLine=3276800;
 //BA.debugLineNum = 3276800;BA.debugLine="Public Sub Initialize (Bridge As PyBridge, LocalPo";
RDebugUtils.currentLine=3276801;
 //BA.debugLineNum = 3276801;BA.debugLine="InitializeWithLoopback(srvr, \"srvr\", LocalPort)";
__ref._initializewithloopback /*String*/ (null,__ref._srvr /*anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper*/ ,"srvr",_localport);
RDebugUtils.currentLine=3276802;
 //BA.debugLineNum = 3276802;BA.debugLine="Dim jo As JavaObject";
_jo = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=3276803;
 //BA.debugLineNum = 3276803;BA.debugLine="Dim correctClassesNames As Map = jo.InitializeSta";
_correctclassesnames = new anywheresoftware.b4a.objects.collections.Map();
_correctclassesnames = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_jo.InitializeStatic("anywheresoftware.b4a.randomaccessfile.RandomAccessFile").GetField("correctedClasses")));
RDebugUtils.currentLine=3276804;
 //BA.debugLineNum = 3276804;BA.debugLine="correctClassesNames.Put(\"_pyobject\", GetType(Brid";
_correctclassesnames.Put((Object)("_pyobject"),(Object)(__c.GetType((Object)(_bridge))+"$_pyobject"));
RDebugUtils.currentLine=3276805;
 //BA.debugLineNum = 3276805;BA.debugLine="jME = Me";
__ref._jme /*anywheresoftware.b4j.object.JavaObject*/  = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(this));
RDebugUtils.currentLine=3276806;
 //BA.debugLineNum = 3276806;BA.debugLine="WaitingTasks.Initialize";
__ref._waitingtasks /*anywheresoftware.b4a.objects.collections.Map*/ .Initialize();
RDebugUtils.currentLine=3276807;
 //BA.debugLineNum = 3276807;BA.debugLine="Port = srvr.As(JavaObject).GetFieldJO(\"ssocket\").";
__ref._port /*int*/  = (int)(BA.ObjectToNumber(((anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(__ref._srvr /*anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper*/ ))).GetFieldJO("ssocket").RunMethod("getLocalPort",(Object[])(__c.Null))));
RDebugUtils.currentLine=3276808;
 //BA.debugLineNum = 3276808;BA.debugLine="mBridge = Bridge";
__ref._mbridge /*b4j.example.pybridge*/  = _bridge;
RDebugUtils.currentLine=3276809;
 //BA.debugLineNum = 3276809;BA.debugLine="mBridge.Utils.PyLog(mBridge.Utils.B4JPrefix, mBri";
__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._pylog /*String*/ (null,__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._b4jprefix /*String*/ ,__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._moptions /*b4j.example.pybridge._pyoptions*/ .B4JColor /*int*/ ,(Object)("Server is listening on port: "+BA.NumberToString(__ref._port /*int*/ )));
RDebugUtils.currentLine=3276810;
 //BA.debugLineNum = 3276810;BA.debugLine="srvr.Listen";
__ref._srvr /*anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper*/ .Listen();
RDebugUtils.currentLine=3276811;
 //BA.debugLineNum = 3276811;BA.debugLine="BufferedTasks.Initialize";
__ref._bufferedtasks /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=3276812;
 //BA.debugLineNum = 3276812;BA.debugLine="State = STATE_WAITING_FOR_CONNECTION";
__ref._state /*int*/  = __ref._state_waiting_for_connection /*int*/ ;
RDebugUtils.currentLine=3276813;
 //BA.debugLineNum = 3276813;BA.debugLine="End Sub";
return "";
}
public String  _sendtask(b4j.example.pycomm __ref,b4j.example.pybridge._pytask _task) throws Exception{
__ref = this;
RDebugUtils.currentModule="pycomm";
if (Debug.shouldDelegate(ba, "sendtask", true))
	 {return ((String) Debug.delegate(ba, "sendtask", new Object[] {_task}));}
RDebugUtils.currentLine=3604480;
 //BA.debugLineNum = 3604480;BA.debugLine="Public Sub SendTask (Task As PyTask)";
RDebugUtils.currentLine=3604481;
 //BA.debugLineNum = 3604481;BA.debugLine="If BufferedTasks.Size = 0 Then CallSubDelayed(Me,";
if (__ref._bufferedtasks /*anywheresoftware.b4a.objects.collections.List*/ .getSize()==0) { 
__c.CallSubDelayed(ba,this,"Flush");};
RDebugUtils.currentLine=3604482;
 //BA.debugLineNum = 3604482;BA.debugLine="BufferedTasks.Add(Task)";
__ref._bufferedtasks /*anywheresoftware.b4a.objects.collections.List*/ .Add((Object)(_task));
RDebugUtils.currentLine=3604483;
 //BA.debugLineNum = 3604483;BA.debugLine="End Sub";
return "";
}
public String  _astream_error(b4j.example.pycomm __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pycomm";
if (Debug.shouldDelegate(ba, "astream_error", true))
	 {return ((String) Debug.delegate(ba, "astream_error", null));}
RDebugUtils.currentLine=3866624;
 //BA.debugLineNum = 3866624;BA.debugLine="Private Sub AStream_Error";
RDebugUtils.currentLine=3866625;
 //BA.debugLineNum = 3866625;BA.debugLine="AStream_Terminated";
__ref._astream_terminated /*String*/ (null);
RDebugUtils.currentLine=3866626;
 //BA.debugLineNum = 3866626;BA.debugLine="End Sub";
return "";
}
public String  _astream_terminated(b4j.example.pycomm __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pycomm";
if (Debug.shouldDelegate(ba, "astream_terminated", true))
	 {return ((String) Debug.delegate(ba, "astream_terminated", null));}
RDebugUtils.currentLine=3932160;
 //BA.debugLineNum = 3932160;BA.debugLine="Private Sub AStream_Terminated";
RDebugUtils.currentLine=3932161;
 //BA.debugLineNum = 3932161;BA.debugLine="ChangeState(STATE_DISCONNECTED)";
__ref._changestate /*String*/ (null,__ref._state_disconnected /*int*/ );
RDebugUtils.currentLine=3932162;
 //BA.debugLineNum = 3932162;BA.debugLine="BufferedTasks.Clear";
__ref._bufferedtasks /*anywheresoftware.b4a.objects.collections.List*/ .Clear();
RDebugUtils.currentLine=3932163;
 //BA.debugLineNum = 3932163;BA.debugLine="srvr.Close";
__ref._srvr /*anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper*/ .Close();
RDebugUtils.currentLine=3932164;
 //BA.debugLineNum = 3932164;BA.debugLine="If astream.IsInitialized Then astream.Close";
if (__ref._astream /*anywheresoftware.b4a.randomaccessfile.AsyncStreams*/ .IsInitialized()) { 
__ref._astream /*anywheresoftware.b4a.randomaccessfile.AsyncStreams*/ .Close();};
RDebugUtils.currentLine=3932165;
 //BA.debugLineNum = 3932165;BA.debugLine="mBridge.Utils.PyLog(mBridge.Utils.B4JPrefix, mBri";
__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._pylog /*String*/ (null,__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._b4jprefix /*String*/ ,__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._moptions /*b4j.example.pybridge._pyoptions*/ .B4JColor /*int*/ ,(Object)("disconnected"));
RDebugUtils.currentLine=3932166;
 //BA.debugLineNum = 3932166;BA.debugLine="End Sub";
return "";
}
public String  _astream_newdata(b4j.example.pycomm __ref,byte[] _buffer) throws Exception{
__ref = this;
RDebugUtils.currentModule="pycomm";
if (Debug.shouldDelegate(ba, "astream_newdata", true))
	 {return ((String) Debug.delegate(ba, "astream_newdata", new Object[] {_buffer}));}
Object[] _o = null;
b4j.example.pybridge._pytask _task = null;
RDebugUtils.currentLine=3538944;
 //BA.debugLineNum = 3538944;BA.debugLine="Private Sub AStream_NewData (Buffer() As Byte)";
RDebugUtils.currentLine=3538945;
 //BA.debugLineNum = 3538945;BA.debugLine="Dim o() As Object = ser.ConvertBytesToObject(Buff";
_o = (Object[])(__ref._ser /*anywheresoftware.b4a.randomaccessfile.B4XSerializator*/ .ConvertBytesToObject(_buffer));
RDebugUtils.currentLine=3538946;
 //BA.debugLineNum = 3538946;BA.debugLine="Dim Task As PyTask = mBridge.Utils.CreatePyTask(o";
_task = __ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._createpytask /*b4j.example.pybridge._pytask*/ (null,(int)(BA.ObjectToNumber(_o[(int) (0)])),(int)(BA.ObjectToNumber(_o[(int) (1)])),(anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_o[(int) (2)])));
RDebugUtils.currentLine=3538947;
 //BA.debugLineNum = 3538947;BA.debugLine="If WaitingTasks.ContainsKey(Task.TaskId) Then";
if (__ref._waitingtasks /*anywheresoftware.b4a.objects.collections.Map*/ .ContainsKey((Object)(_task.TaskId /*int*/ ))) { 
RDebugUtils.currentLine=3538948;
 //BA.debugLineNum = 3538948;BA.debugLine="jME.RunMethod(\"raiseEventWithSenderFilter\", Arra";
__ref._jme /*anywheresoftware.b4j.object.JavaObject*/ .RunMethod("raiseEventWithSenderFilter",new Object[]{(Object)(__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ),(Object)("asynctask_received"),__ref._waitingtasks /*anywheresoftware.b4a.objects.collections.Map*/ .Remove((Object)(_task.TaskId /*int*/ )),(Object)(new Object[]{(Object)(_task)})});
 }else {
RDebugUtils.currentLine=3538950;
 //BA.debugLineNum = 3538950;BA.debugLine="CallSub2(mBridge, \"Task_Received\", Task)";
__c.CallSubDebug2(ba,(Object)(__ref._mbridge /*b4j.example.pybridge*/ ),"Task_Received",(Object)(_task));
 };
RDebugUtils.currentLine=3538952;
 //BA.debugLineNum = 3538952;BA.debugLine="End Sub";
return "";
}
public String  _changestate(b4j.example.pycomm __ref,int _newstate) throws Exception{
__ref = this;
RDebugUtils.currentModule="pycomm";
if (Debug.shouldDelegate(ba, "changestate", true))
	 {return ((String) Debug.delegate(ba, "changestate", new Object[] {_newstate}));}
int _oldstate = 0;
RDebugUtils.currentLine=3997696;
 //BA.debugLineNum = 3997696;BA.debugLine="Private Sub ChangeState (NewState As Int)";
RDebugUtils.currentLine=3997697;
 //BA.debugLineNum = 3997697;BA.debugLine="If NewState = State Then Return";
if (_newstate==__ref._state /*int*/ ) { 
if (true) return "";};
RDebugUtils.currentLine=3997698;
 //BA.debugLineNum = 3997698;BA.debugLine="Dim OldState As Int = State";
_oldstate = __ref._state /*int*/ ;
RDebugUtils.currentLine=3997699;
 //BA.debugLineNum = 3997699;BA.debugLine="State = NewState";
__ref._state /*int*/  = _newstate;
RDebugUtils.currentLine=3997700;
 //BA.debugLineNum = 3997700;BA.debugLine="CallSub3(mBridge, \"state_changed\", OldState, Stat";
__c.CallSubDebug3(ba,(Object)(__ref._mbridge /*b4j.example.pybridge*/ ),"state_changed",(Object)(_oldstate),(Object)(__ref._state /*int*/ ));
RDebugUtils.currentLine=3997701;
 //BA.debugLineNum = 3997701;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4j.example.pycomm __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pycomm";
RDebugUtils.currentLine=3211264;
 //BA.debugLineNum = 3211264;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=3211265;
 //BA.debugLineNum = 3211265;BA.debugLine="Private srvr As ServerSocket";
_srvr = new anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper();
RDebugUtils.currentLine=3211266;
 //BA.debugLineNum = 3211266;BA.debugLine="Public const STATE_DISCONNECTED = 1, STATE_CONNEC";
_state_disconnected = (int) (1);
_state_connected = (int) (2);
_state_waiting_for_connection = (int) (3);
RDebugUtils.currentLine=3211267;
 //BA.debugLineNum = 3211267;BA.debugLine="Public State As Int";
_state = 0;
RDebugUtils.currentLine=3211268;
 //BA.debugLineNum = 3211268;BA.debugLine="Public Port As Int";
_port = 0;
RDebugUtils.currentLine=3211269;
 //BA.debugLineNum = 3211269;BA.debugLine="Private mBridge As PyBridge";
_mbridge = new b4j.example.pybridge();
RDebugUtils.currentLine=3211270;
 //BA.debugLineNum = 3211270;BA.debugLine="Private astream As AsyncStreams";
_astream = new anywheresoftware.b4a.randomaccessfile.AsyncStreams();
RDebugUtils.currentLine=3211271;
 //BA.debugLineNum = 3211271;BA.debugLine="Private ser As B4XSerializator";
_ser = new anywheresoftware.b4a.randomaccessfile.B4XSerializator();
RDebugUtils.currentLine=3211272;
 //BA.debugLineNum = 3211272;BA.debugLine="Private WaitingTasks As Map";
_waitingtasks = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=3211273;
 //BA.debugLineNum = 3211273;BA.debugLine="Private jME As JavaObject";
_jme = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=3211274;
 //BA.debugLineNum = 3211274;BA.debugLine="Public BufferedTasks As List";
_bufferedtasks = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=3211275;
 //BA.debugLineNum = 3211275;BA.debugLine="End Sub";
return "";
}
public String  _flush(b4j.example.pycomm __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pycomm";
if (Debug.shouldDelegate(ba, "flush", true))
	 {return ((String) Debug.delegate(ba, "flush", null));}
anywheresoftware.b4a.objects.collections.List _flattasks = null;
b4j.example.pybridge._pytask _task = null;
boolean _res = false;
RDebugUtils.currentLine=3735552;
 //BA.debugLineNum = 3735552;BA.debugLine="Public Sub Flush";
RDebugUtils.currentLine=3735553;
 //BA.debugLineNum = 3735553;BA.debugLine="If BufferedTasks.Size > 0 Then";
if (__ref._bufferedtasks /*anywheresoftware.b4a.objects.collections.List*/ .getSize()>0) { 
RDebugUtils.currentLine=3735554;
 //BA.debugLineNum = 3735554;BA.debugLine="Dim FlatTasks As List";
_flattasks = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=3735555;
 //BA.debugLineNum = 3735555;BA.debugLine="FlatTasks.Initialize";
_flattasks.Initialize();
RDebugUtils.currentLine=3735556;
 //BA.debugLineNum = 3735556;BA.debugLine="For Each Task As PyTask In BufferedTasks";
{
final anywheresoftware.b4a.BA.IterableList group4 = __ref._bufferedtasks /*anywheresoftware.b4a.objects.collections.List*/ ;
final int groupLen4 = group4.getSize()
;int index4 = 0;
;
for (; index4 < groupLen4;index4++){
_task = (b4j.example.pybridge._pytask)(group4.Get(index4));
RDebugUtils.currentLine=3735557;
 //BA.debugLineNum = 3735557;BA.debugLine="If Task.TaskType = mBridge.Utils.TASK_TYPE_RUN";
if (_task.TaskType /*int*/ ==__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._task_type_run /*int*/  || _task.TaskType /*int*/ ==__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._task_type_run_async /*int*/ ) { 
RDebugUtils.currentLine=3735558;
 //BA.debugLineNum = 3735558;BA.debugLine="mBridge.Utils.UnwrapBeforeSerialization(Task.E";
__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._unwrapbeforeserialization /*String*/ (null,_task.Extra /*anywheresoftware.b4a.objects.collections.List*/ );
 };
RDebugUtils.currentLine=3735560;
 //BA.debugLineNum = 3735560;BA.debugLine="FlatTasks.AddAll(Array(Task.TaskId, Task.TaskTy";
_flattasks.AddAll(anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(_task.TaskId /*int*/ ),(Object)(_task.TaskType /*int*/ ),(Object)(_task.Extra /*anywheresoftware.b4a.objects.collections.List*/ .getObject())}));
 }
};
RDebugUtils.currentLine=3735562;
 //BA.debugLineNum = 3735562;BA.debugLine="Dim res As Boolean = astream.Write(ser.ConvertOb";
_res = __ref._astream /*anywheresoftware.b4a.randomaccessfile.AsyncStreams*/ .Write(__ref._ser /*anywheresoftware.b4a.randomaccessfile.B4XSerializator*/ .ConvertObjectToBytes((Object)(_flattasks.getObject())));
RDebugUtils.currentLine=3735563;
 //BA.debugLineNum = 3735563;BA.debugLine="If astream.OutputQueueSize > 100 Then";
if (__ref._astream /*anywheresoftware.b4a.randomaccessfile.AsyncStreams*/ .getOutputQueueSize()>100) { 
RDebugUtils.currentLine=3735564;
 //BA.debugLineNum = 3735564;BA.debugLine="mBridge.Utils.PyLog(mBridge.Utils.B4JPrefix, mB";
__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._pylog /*String*/ (null,__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._b4jprefix /*String*/ ,__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._moptions /*b4j.example.pybridge._pyoptions*/ .B4JColor /*int*/ ,(Object)("Output queue size: "+BA.NumberToString(__ref._astream /*anywheresoftware.b4a.randomaccessfile.AsyncStreams*/ .getOutputQueueSize())));
 };
RDebugUtils.currentLine=3735566;
 //BA.debugLineNum = 3735566;BA.debugLine="If res = False And astream.OutputQueueSize > 0 T";
if (_res==__c.False && __ref._astream /*anywheresoftware.b4a.randomaccessfile.AsyncStreams*/ .getOutputQueueSize()>0) { 
RDebugUtils.currentLine=3735567;
 //BA.debugLineNum = 3735567;BA.debugLine="LogError(\"Queue is full!\")";
__c.LogError("Queue is full!");
 };
RDebugUtils.currentLine=3735569;
 //BA.debugLineNum = 3735569;BA.debugLine="BufferedTasks.Clear";
__ref._bufferedtasks /*anywheresoftware.b4a.objects.collections.List*/ .Clear();
 };
RDebugUtils.currentLine=3735571;
 //BA.debugLineNum = 3735571;BA.debugLine="End Sub";
return "";
}
public String  _initializewithloopback(b4j.example.pycomm __ref,anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper _server,String _eventname,int _vport) throws Exception{
__ref = this;
RDebugUtils.currentModule="pycomm";
if (Debug.shouldDelegate(ba, "initializewithloopback", true))
	 {return ((String) Debug.delegate(ba, "initializewithloopback", new Object[] {_server,_eventname,_vport}));}
anywheresoftware.b4j.object.JavaObject _ia = null;
anywheresoftware.b4j.object.JavaObject _s = null;
anywheresoftware.b4j.object.JavaObject _socket = null;
RDebugUtils.currentLine=3342336;
 //BA.debugLineNum = 3342336;BA.debugLine="Private Sub InitializeWithLoopback(Server As Serve";
RDebugUtils.currentLine=3342337;
 //BA.debugLineNum = 3342337;BA.debugLine="Server.Initialize(-1, EventName)";
_server.Initialize(ba,(int) (-1),_eventname);
RDebugUtils.currentLine=3342338;
 //BA.debugLineNum = 3342338;BA.debugLine="Dim ia As JavaObject";
_ia = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=3342339;
 //BA.debugLineNum = 3342339;BA.debugLine="ia = ia.InitializeStatic(\"java.net.InetAddress\").";
_ia = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_ia.InitializeStatic("java.net.InetAddress").RunMethod("getLoopbackAddress",(Object[])(__c.Null))));
RDebugUtils.currentLine=3342340;
 //BA.debugLineNum = 3342340;BA.debugLine="Dim s As JavaObject = Server";
_s = new anywheresoftware.b4j.object.JavaObject();
_s = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_server));
RDebugUtils.currentLine=3342341;
 //BA.debugLineNum = 3342341;BA.debugLine="Dim socket As JavaObject";
_socket = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=3342342;
 //BA.debugLineNum = 3342342;BA.debugLine="socket.InitializeNewInstance(\"java.net.ServerSock";
_socket.InitializeNewInstance("java.net.ServerSocket",new Object[]{(Object)(_vport),(Object)(50),(Object)(_ia.getObject())});
RDebugUtils.currentLine=3342343;
 //BA.debugLineNum = 3342343;BA.debugLine="s.SetField(\"ssocket\", socket)";
_s.SetField("ssocket",(Object)(_socket.getObject()));
RDebugUtils.currentLine=3342344;
 //BA.debugLineNum = 3342344;BA.debugLine="End Sub";
return "";
}
public String  _movetasktolast(b4j.example.pycomm __ref,b4j.example.pybridge._pytask _task) throws Exception{
__ref = this;
RDebugUtils.currentModule="pycomm";
if (Debug.shouldDelegate(ba, "movetasktolast", true))
	 {return ((String) Debug.delegate(ba, "movetasktolast", new Object[] {_task}));}
int _i = 0;
RDebugUtils.currentLine=3670016;
 //BA.debugLineNum = 3670016;BA.debugLine="Public Sub MoveTaskToLast(Task As PyTask)";
RDebugUtils.currentLine=3670017;
 //BA.debugLineNum = 3670017;BA.debugLine="If BufferedTasks.Get(BufferedTasks.Size - 1) = Ta";
if ((__ref._bufferedtasks /*anywheresoftware.b4a.objects.collections.List*/ .Get((int) (__ref._bufferedtasks /*anywheresoftware.b4a.objects.collections.List*/ .getSize()-1))).equals((Object)(_task))) { 
RDebugUtils.currentLine=3670018;
 //BA.debugLineNum = 3670018;BA.debugLine="Return";
if (true) return "";
 };
RDebugUtils.currentLine=3670020;
 //BA.debugLineNum = 3670020;BA.debugLine="Dim i As Int = BufferedTasks.IndexOf(Task)";
_i = __ref._bufferedtasks /*anywheresoftware.b4a.objects.collections.List*/ .IndexOf((Object)(_task));
RDebugUtils.currentLine=3670021;
 //BA.debugLineNum = 3670021;BA.debugLine="BufferedTasks.RemoveAt(i)";
__ref._bufferedtasks /*anywheresoftware.b4a.objects.collections.List*/ .RemoveAt(_i);
RDebugUtils.currentLine=3670022;
 //BA.debugLineNum = 3670022;BA.debugLine="BufferedTasks.Add(Task)";
__ref._bufferedtasks /*anywheresoftware.b4a.objects.collections.List*/ .Add((Object)(_task));
RDebugUtils.currentLine=3670023;
 //BA.debugLineNum = 3670023;BA.debugLine="End Sub";
return "";
}
public String  _sendtaskandwait(b4j.example.pycomm __ref,b4j.example.pybridge._pytask _task) throws Exception{
__ref = this;
RDebugUtils.currentModule="pycomm";
if (Debug.shouldDelegate(ba, "sendtaskandwait", true))
	 {return ((String) Debug.delegate(ba, "sendtaskandwait", new Object[] {_task}));}
RDebugUtils.currentLine=3801088;
 //BA.debugLineNum = 3801088;BA.debugLine="Public Sub SendTaskAndWait (Task As PyTask)";
RDebugUtils.currentLine=3801089;
 //BA.debugLineNum = 3801089;BA.debugLine="WaitingTasks.Put(Task.TaskId, Task)";
__ref._waitingtasks /*anywheresoftware.b4a.objects.collections.Map*/ .Put((Object)(_task.TaskId /*int*/ ),(Object)(_task));
RDebugUtils.currentLine=3801090;
 //BA.debugLineNum = 3801090;BA.debugLine="SendTask(Task)";
__ref._sendtask /*String*/ (null,_task);
RDebugUtils.currentLine=3801091;
 //BA.debugLineNum = 3801091;BA.debugLine="Flush";
__ref._flush /*String*/ (null);
RDebugUtils.currentLine=3801092;
 //BA.debugLineNum = 3801092;BA.debugLine="End Sub";
return "";
}
public void  _srvr_newconnection(b4j.example.pycomm __ref,boolean _successful,anywheresoftware.b4a.objects.SocketWrapper _newsocket) throws Exception{
RDebugUtils.currentModule="pycomm";
if (Debug.shouldDelegate(ba, "srvr_newconnection", true))
	 {Debug.delegate(ba, "srvr_newconnection", new Object[] {_successful,_newsocket}); return;}
ResumableSub_Srvr_NewConnection rsub = new ResumableSub_Srvr_NewConnection(this,__ref,_successful,_newsocket);
rsub.resume(ba, null);
}
public static class ResumableSub_Srvr_NewConnection extends BA.ResumableSub {
public ResumableSub_Srvr_NewConnection(b4j.example.pycomm parent,b4j.example.pycomm __ref,boolean _successful,anywheresoftware.b4a.objects.SocketWrapper _newsocket) {
this.parent = parent;
this.__ref = __ref;
this._successful = _successful;
this._newsocket = _newsocket;
this.__ref = parent;
}
b4j.example.pycomm __ref;
b4j.example.pycomm parent;
boolean _successful;
anywheresoftware.b4a.objects.SocketWrapper _newsocket;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="pycomm";

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
RDebugUtils.currentLine=3407873;
 //BA.debugLineNum = 3407873;BA.debugLine="If Successful Then";
if (true) break;

case 1:
//if
this.state = 4;
if (_successful) { 
this.state = 3;
}if (true) break;

case 3:
//C
this.state = 4;
RDebugUtils.currentLine=3407874;
 //BA.debugLineNum = 3407874;BA.debugLine="mBridge.Utils.PyLog(mBridge.Utils.B4JPrefix, mBr";
__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._pylog /*String*/ (null,__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._b4jprefix /*String*/ ,__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._moptions /*b4j.example.pybridge._pyoptions*/ .B4JColor /*int*/ ,(Object)("connected"));
RDebugUtils.currentLine=3407876;
 //BA.debugLineNum = 3407876;BA.debugLine="astream.InitializePrefix(NewSocket.InputStream,";
__ref._astream /*anywheresoftware.b4a.randomaccessfile.AsyncStreams*/ .InitializePrefix(ba,_newsocket.getInputStream(),parent.__c.True,_newsocket.getOutputStream(),"astream");
RDebugUtils.currentLine=3407877;
 //BA.debugLineNum = 3407877;BA.debugLine="Sleep(100)";
parent.__c.Sleep(ba,new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pycomm", "srvr_newconnection"),(int) (100));
this.state = 5;
return;
case 5:
//C
this.state = 4;
;
RDebugUtils.currentLine=3407878;
 //BA.debugLineNum = 3407878;BA.debugLine="ChangeState(STATE_CONNECTED)";
__ref._changestate /*String*/ (null,__ref._state_connected /*int*/ );
 if (true) break;

case 4:
//C
this.state = -1;
;
RDebugUtils.currentLine=3407880;
 //BA.debugLineNum = 3407880;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public void raiseEventWithSenderFilter(B4AClass target, String eventName, Object senderFilter, Object[] params) {
	target.getBA().raiseEventFromUI(senderFilter, eventName, params);
}
}