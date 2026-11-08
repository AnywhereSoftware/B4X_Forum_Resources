package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class pyutils_subs_0 {


public static RemoteObject  _addconverters(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("AddConverters (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,62);
if (RapidSub.canDelegate("addconverters")) { return __ref.runUserSub(false, "pyutils","addconverters", __ref);}
RemoteObject _converters = RemoteObject.declareNull("b4j.example.pywrapper");
 BA.debugLineNum = 62;BA.debugLine="Private Sub AddConverters";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 63;BA.debugLine="IO = mBridge.ImportModule(\"io\")";
Debug.JustUpdateDeviceLine();
__ref.setField ("_io" /*RemoteObject*/ ,__ref.getField(false,"_mbridge" /*RemoteObject*/ ).runClassMethod (b4j.example.pybridge.class, "_importmodule" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("io"))));
 BA.debugLineNum = 64;BA.debugLine="Dim converters As PyWrapper = mBridge.Bridge.GetF";
Debug.JustUpdateDeviceLine();
_converters = __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_bridge" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_getfield" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("comm"))).runClassMethod (b4j.example.pywrapper.class, "_getfield" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("serializator"))).runClassMethod (b4j.example.pywrapper.class, "_getfield" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("converters")));Debug.locals.put("converters", _converters);Debug.locals.put("converters", _converters);
 BA.debugLineNum = 65;BA.debugLine="converters.Set(IO.GetField(\"BytesIO\"), mBridge.La";
Debug.JustUpdateDeviceLine();
_converters.runClassMethod (b4j.example.pywrapper.class, "_set" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_io" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_getfield" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("BytesIO"))))),(Object)((__ref.getField(false,"_mbridge" /*RemoteObject*/ ).runClassMethod (b4j.example.pybridge.class, "_lambda" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("x: x.getvalue()"))))));
 BA.debugLineNum = 66;BA.debugLine="mBridge.RunNoArgsCode(\"from b4x_bridge.bridge imp";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mbridge" /*RemoteObject*/ ).runClassMethod (b4j.example.pybridge.class, "_runnoargscode" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("from b4x_bridge.bridge import bridge_instance")));
 BA.debugLineNum = 67;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _checkforerrorsandreturn(RemoteObject __ref,RemoteObject _task,RemoteObject _pyobject) throws Exception{
try {
		Debug.PushSubsStack("CheckForErrorsAndReturn (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,238);
if (RapidSub.canDelegate("checkforerrorsandreturn")) { return __ref.runUserSub(false, "pyutils","checkforerrorsandreturn", __ref, _task, _pyobject);}
Debug.locals.put("TASK", _task);
Debug.locals.put("PyObject", _pyobject);
 BA.debugLineNum = 238;BA.debugLine="Private Sub CheckForErrorsAndReturn (TASK As PyTas";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 240;BA.debugLine="Return CreateInternalPyTaskAsyncResult(PyObject,";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pyutils.class, "_createinternalpytaskasyncresult" /*RemoteObject*/ ,(Object)(_pyobject),(Object)(_task.getField(false,"Extra" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(BA.numberCast(int.class, 0)))),(Object)(BA.ObjectToBoolean(RemoteObject.solveBoolean("=",_task.getField(true,"TaskType" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(true,"_task_type_error" /*RemoteObject*/ ))))));
 BA.debugLineNum = 241;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static void  _checkkeysneedtobecleaned(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("CheckKeysNeedToBeCleaned (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,253);
if (RapidSub.canDelegate("checkkeysneedtobecleaned")) { __ref.runUserSub(false, "pyutils","checkkeysneedtobecleaned", __ref); return;}
ResumableSub_CheckKeysNeedToBeCleaned rsub = new ResumableSub_CheckKeysNeedToBeCleaned(null,__ref);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_CheckKeysNeedToBeCleaned extends BA.ResumableSub {
public ResumableSub_CheckKeysNeedToBeCleaned(b4j.example.pyutils parent,RemoteObject __ref) {
this.parent = parent;
this.__ref = __ref;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.pyutils parent;
RemoteObject _myindex = RemoteObject.createImmutable(0);

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("CheckKeysNeedToBeCleaned (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,253);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
Debug.locals.put("_ref", __ref);
 BA.debugLineNum = 254;BA.debugLine="CleanerClass.RunMethod(\"getKeys\", Null) 'clear an";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_cleanerclass" /*RemoteObject*/ ).runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("getKeys")),(Object)((parent.__c.getField(false,"Null"))));
 BA.debugLineNum = 255;BA.debugLine="CleanerIndex = CleanerIndex + 1";
Debug.JustUpdateDeviceLine();
__ref.setField ("_cleanerindex" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_cleanerindex" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "+",1, 1));
 BA.debugLineNum = 256;BA.debugLine="Dim MyIndex As Int = CleanerIndex";
Debug.JustUpdateDeviceLine();
_myindex = __ref.getField(true,"_cleanerindex" /*RemoteObject*/ );Debug.locals.put("MyIndex", _myindex);Debug.locals.put("MyIndex", _myindex);
 BA.debugLineNum = 257;BA.debugLine="CleanerClass.SetField(\"currentCleanerIndex\", MyIn";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_cleanerclass" /*RemoteObject*/ ).runVoidMethod ("SetField",(Object)(BA.ObjectToString("currentCleanerIndex")),(Object)((_myindex)));
 BA.debugLineNum = 258;BA.debugLine="Do While MyIndex = CleanerIndex";
Debug.JustUpdateDeviceLine();
if (true) break;

case 1:
//do while
this.state = 4;
while (RemoteObject.solveBoolean("=",_myindex,BA.numberCast(double.class, __ref.getField(true,"_cleanerindex" /*RemoteObject*/ )))) {
this.state = 3;
if (true) break;
}
if (true) break;

case 3:
//C
this.state = 1;
 BA.debugLineNum = 259;BA.debugLine="KeysImpl";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_keysimpl" /*RemoteObject*/ );
 BA.debugLineNum = 260;BA.debugLine="Sleep(200)";
Debug.JustUpdateDeviceLine();
parent.__c.runVoidMethod ("Sleep",__ref.getField(false, "ba"),anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pyutils", "checkkeysneedtobecleaned"),BA.numberCast(int.class, 200));
this.state = 5;
return;
case 5:
//C
this.state = 1;
;
 if (true) break;

case 4:
//C
this.state = -1;
;
 BA.debugLineNum = 262;BA.debugLine="End Sub";
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
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 3;BA.debugLine="Public TASK_TYPE_RUN = 1, TASK_TYPE_GET = 2, TASK";
pyutils._task_type_run = BA.numberCast(int.class, 1);__ref.setField("_task_type_run",pyutils._task_type_run);
pyutils._task_type_get = BA.numberCast(int.class, 2);__ref.setField("_task_type_get",pyutils._task_type_get);
pyutils._task_type_run_async = BA.numberCast(int.class, 3);__ref.setField("_task_type_run_async",pyutils._task_type_run_async);
pyutils._task_type_clean = BA.numberCast(int.class, 4);__ref.setField("_task_type_clean",pyutils._task_type_clean);
pyutils._task_type_error = BA.numberCast(int.class, 5);__ref.setField("_task_type_error",pyutils._task_type_error);
pyutils._task_type_event = BA.numberCast(int.class, 6);__ref.setField("_task_type_event",pyutils._task_type_event);
pyutils._task_type_ping = BA.numberCast(int.class, 7);__ref.setField("_task_type_ping",pyutils._task_type_ping);
pyutils._task_type_flush = BA.numberCast(int.class, 8);__ref.setField("_task_type_flush",pyutils._task_type_flush);
 //BA.debugLineNum = 6;BA.debugLine="Public PythonBridgeCodeVersion As String = \"1.00\"";
pyutils._pythonbridgecodeversion = BA.ObjectToString("1.00");__ref.setField("_pythonbridgecodeversion",pyutils._pythonbridgecodeversion);
 //BA.debugLineNum = 7;BA.debugLine="Public PyOutPrefix = \"(pyout) \", PyErrPrefix = \"(";
pyutils._pyoutprefix = BA.ObjectToString("(pyout) ");__ref.setField("_pyoutprefix",pyutils._pyoutprefix);
pyutils._pyerrprefix = BA.ObjectToString("(pyerr) ");__ref.setField("_pyerrprefix",pyutils._pyerrprefix);
pyutils._b4jprefix = BA.ObjectToString("(b4j) ");__ref.setField("_b4jprefix",pyutils._b4jprefix);
 //BA.debugLineNum = 8;BA.debugLine="Public EvalGlobals As PyWrapper";
pyutils._evalglobals = RemoteObject.createNew ("b4j.example.pywrapper");__ref.setField("_evalglobals",pyutils._evalglobals);
 //BA.debugLineNum = 9;BA.debugLine="Public ImportLib As PyWrapper";
pyutils._importlib = RemoteObject.createNew ("b4j.example.pywrapper");__ref.setField("_importlib",pyutils._importlib);
 //BA.debugLineNum = 11;BA.debugLine="Private mBridge As PyBridge";
pyutils._mbridge = RemoteObject.createNew ("b4j.example.pybridge");__ref.setField("_mbridge",pyutils._mbridge);
 //BA.debugLineNum = 12;BA.debugLine="Public TaskIdCounter, PyObjectCounter As Int";
pyutils._taskidcounter = RemoteObject.createImmutable(0);__ref.setField("_taskidcounter",pyutils._taskidcounter);
pyutils._pyobjectcounter = RemoteObject.createImmutable(0);__ref.setField("_pyobjectcounter",pyutils._pyobjectcounter);
 //BA.debugLineNum = 13;BA.debugLine="Public CleanerClass As JavaObject";
pyutils._cleanerclass = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");__ref.setField("_cleanerclass",pyutils._cleanerclass);
 //BA.debugLineNum = 14;BA.debugLine="Public CleanerIndex As Int";
pyutils._cleanerindex = RemoteObject.createImmutable(0);__ref.setField("_cleanerindex",pyutils._cleanerindex);
 //BA.debugLineNum = 15;BA.debugLine="Public Comm As PyComm";
pyutils._comm = RemoteObject.createNew ("b4j.example.pycomm");__ref.setField("_comm",pyutils._comm);
 //BA.debugLineNum = 16;BA.debugLine="Public mOptions As PyOptions";
pyutils._moptions = RemoteObject.createNew ("b4j.example.pybridge._pyoptions");__ref.setField("_moptions",pyutils._moptions);
 //BA.debugLineNum = 17;BA.debugLine="Public cleaner As JavaObject";
pyutils._cleaner = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");__ref.setField("_cleaner",pyutils._cleaner);
 //BA.debugLineNum = 18;BA.debugLine="Public RegisteredMembers As B4XSet";
pyutils._registeredmembers = RemoteObject.createNew ("b4j.example.b4xset");__ref.setField("_registeredmembers",pyutils._registeredmembers);
 //BA.debugLineNum = 19;BA.debugLine="Public Epsilon As Double = 0.0000001";
pyutils._epsilon = BA.numberCast(double.class, 0.0000001);__ref.setField("_epsilon",pyutils._epsilon);
 //BA.debugLineNum = 20;BA.debugLine="Private KeysThatNeedToBeRegistered As List";
pyutils._keysthatneedtoberegistered = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");__ref.setField("_keysthatneedtoberegistered",pyutils._keysthatneedtoberegistered);
 //BA.debugLineNum = 21;BA.debugLine="Private ObjectsThatNeedToBeRegistered As List";
pyutils._objectsthatneedtoberegistered = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");__ref.setField("_objectsthatneedtoberegistered",pyutils._objectsthatneedtoberegistered);
 //BA.debugLineNum = 22;BA.debugLine="Private System As JavaObject";
pyutils._system = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");__ref.setField("_system",pyutils._system);
 //BA.debugLineNum = 23;BA.debugLine="Private MemorySlots As Map";
pyutils._memoryslots = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");__ref.setField("_memoryslots",pyutils._memoryslots);
 //BA.debugLineNum = 24;BA.debugLine="Private LastMemorySize As Int";
pyutils._lastmemorysize = RemoteObject.createImmutable(0);__ref.setField("_lastmemorysize",pyutils._lastmemorysize);
 //BA.debugLineNum = 25;BA.debugLine="Public MEMORY_INCREASE_THRESHOLD As Int = 500000";
pyutils._memory_increase_threshold = BA.numberCast(int.class, 500000);__ref.setField("_memory_increase_threshold",pyutils._memory_increase_threshold);
 //BA.debugLineNum = 26;BA.debugLine="Public PackageName As String";
pyutils._packagename = RemoteObject.createImmutable("");__ref.setField("_packagename",pyutils._packagename);
 //BA.debugLineNum = 27;BA.debugLine="Public IO As PyWrapper";
pyutils._io = RemoteObject.createNew ("b4j.example.pywrapper");__ref.setField("_io",pyutils._io);
 //BA.debugLineNum = 28;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _connected(RemoteObject __ref,RemoteObject _vimportlib,RemoteObject _options) throws Exception{
try {
		Debug.PushSubsStack("Connected (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,48);
if (RapidSub.canDelegate("connected")) { return __ref.runUserSub(false, "pyutils","connected", __ref, _vimportlib, _options);}
Debug.locals.put("vImportLib", _vimportlib);
Debug.locals.put("options", _options);
 BA.debugLineNum = 48;BA.debugLine="Public Sub Connected (vImportLib As PyObject, opti";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 49;BA.debugLine="mOptions = options";
Debug.JustUpdateDeviceLine();
__ref.setField ("_moptions" /*RemoteObject*/ ,_options);
 BA.debugLineNum = 50;BA.debugLine="PyObjectCounter = 100";
Debug.JustUpdateDeviceLine();
__ref.setField ("_pyobjectcounter" /*RemoteObject*/ ,BA.numberCast(int.class, 100));
 BA.debugLineNum = 51;BA.debugLine="ImportLib.Initialize(mBridge, vImportLib)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_importlib" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ )),(Object)(_vimportlib));
 BA.debugLineNum = 52;BA.debugLine="EvalGlobals = mBridge.Builtins.Run(\"dict\")";
Debug.JustUpdateDeviceLine();
__ref.setField ("_evalglobals" /*RemoteObject*/ ,__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("dict"))));
 BA.debugLineNum = 53;BA.debugLine="RegisteredMembers.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_registeredmembers" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"));
 BA.debugLineNum = 54;BA.debugLine="KeysThatNeedToBeRegistered.Clear";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_keysthatneedtoberegistered" /*RemoteObject*/ ).runVoidMethod ("Clear");
 BA.debugLineNum = 55;BA.debugLine="ObjectsThatNeedToBeRegistered.Clear";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_objectsthatneedtoberegistered" /*RemoteObject*/ ).runVoidMethod ("Clear");
 BA.debugLineNum = 56;BA.debugLine="MemorySlots.Clear";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_memoryslots" /*RemoteObject*/ ).runVoidMethod ("Clear");
 BA.debugLineNum = 57;BA.debugLine="LastMemorySize = 0";
Debug.JustUpdateDeviceLine();
__ref.setField ("_lastmemorysize" /*RemoteObject*/ ,BA.numberCast(int.class, 0));
 BA.debugLineNum = 58;BA.debugLine="CheckKeysNeedToBeCleaned";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_checkkeysneedtobecleaned" /*void*/ );
 BA.debugLineNum = 59;BA.debugLine="AddConverters";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_addconverters" /*RemoteObject*/ );
 BA.debugLineNum = 60;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _convertlambdaifmatch(RemoteObject __ref,RemoteObject _o) throws Exception{
try {
		Debug.PushSubsStack("ConvertLambdaIfMatch (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,299);
if (RapidSub.canDelegate("convertlambdaifmatch")) { return __ref.runUserSub(false, "pyutils","convertlambdaifmatch", __ref, _o);}
Debug.locals.put("o", _o);
 BA.debugLineNum = 299;BA.debugLine="Public Sub ConvertLambdaIfMatch (o As Object) As P";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 300;BA.debugLine="If o Is PyWrapper Then Return o";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("i",_o, RemoteObject.createImmutable("b4j.example.pywrapper"))) { 
if (true) return (_o);};
 BA.debugLineNum = 301;BA.debugLine="Return mBridge.RunStatement(o)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_mbridge" /*RemoteObject*/ ).runClassMethod (b4j.example.pybridge.class, "_runstatement" /*RemoteObject*/ ,(Object)(BA.ObjectToString(_o)));
 BA.debugLineNum = 302;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _converttointifmatch(RemoteObject __ref,RemoteObject _o) throws Exception{
try {
		Debug.PushSubsStack("ConvertToIntIfMatch (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,290);
if (RapidSub.canDelegate("converttointifmatch")) { return __ref.runUserSub(false, "pyutils","converttointifmatch", __ref, _o);}
RemoteObject _d = RemoteObject.createImmutable(0);
RemoteObject _i = RemoteObject.createImmutable(0);
Debug.locals.put("o", _o);
 BA.debugLineNum = 290;BA.debugLine="Public Sub ConvertToIntIfMatch (o As Object) As Ob";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 291;BA.debugLine="If o Is Float Or o Is Double Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("i",_o, RemoteObject.createImmutable("Float")) || RemoteObject.solveBoolean("i",_o, RemoteObject.createImmutable("Double"))) { 
 BA.debugLineNum = 292;BA.debugLine="Dim d As Double = o";
Debug.JustUpdateDeviceLine();
_d = BA.numberCast(double.class, _o);Debug.locals.put("d", _d);Debug.locals.put("d", _d);
 BA.debugLineNum = 293;BA.debugLine="Dim i As Int = d";
Debug.JustUpdateDeviceLine();
_i = BA.numberCast(int.class, _d);Debug.locals.put("i", _i);Debug.locals.put("i", _i);
 BA.debugLineNum = 294;BA.debugLine="If Abs(d - i) < Epsilon Then Return i";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("<",pyutils.__c.runMethod(true,"Abs",(Object)(RemoteObject.solve(new RemoteObject[] {_d,_i}, "-",1, 0))),__ref.getField(true,"_epsilon" /*RemoteObject*/ ))) { 
if (true) return (_i);};
 };
 BA.debugLineNum = 296;BA.debugLine="Return o";
Debug.JustUpdateDeviceLine();
if (true) return _o;
 BA.debugLineNum = 297;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createextra(RemoteObject __ref,RemoteObject _target,RemoteObject _method,RemoteObject _args,RemoteObject _res) throws Exception{
try {
		Debug.PushSubsStack("CreateExtra (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,82);
if (RapidSub.canDelegate("createextra")) { return __ref.runUserSub(false, "pyutils","createextra", __ref, _target, _method, _args, _res);}
Debug.locals.put("Target", _target);
Debug.locals.put("Method", _method);
Debug.locals.put("Args", _args);
Debug.locals.put("res", _res);
 BA.debugLineNum = 82;BA.debugLine="Private Sub CreateExtra(Target As PyObject, Method";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 83;BA.debugLine="If mOptions.TrackLineNumbers Then";
Debug.JustUpdateDeviceLine();
if (__ref.getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"TrackLineNumbers" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 84;BA.debugLine="Return Array(Target.Key, Method, Args.Args, Args";
Debug.JustUpdateDeviceLine();
if (true) return RemoteObject.createNewArray("Object",new int[] {8},new Object[] {(_target.getField(true,"Key" /*RemoteObject*/ )),(_method),(_args.getField(false,"Args" /*RemoteObject*/ ).getObject()),(_args.getField(false,"KWArgs" /*RemoteObject*/ ).getObject()),(_res.getField(true,"Key" /*RemoteObject*/ )),RemoteObject.createImmutable(("")),RemoteObject.createImmutable(("")),RemoteObject.createImmutable((0))});
 }else {
 BA.debugLineNum = 86;BA.debugLine="Return Array(Target.Key, Method, Args.Args, Args";
Debug.JustUpdateDeviceLine();
if (true) return RemoteObject.createNewArray("Object",new int[] {5},new Object[] {(_target.getField(true,"Key" /*RemoteObject*/ )),(_method),(_args.getField(false,"Args" /*RemoteObject*/ ).getObject()),(_args.getField(false,"KWArgs" /*RemoteObject*/ ).getObject()),(_res.getField(true,"Key" /*RemoteObject*/ ))});
 };
 BA.debugLineNum = 88;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createinternalpytaskasyncresult(RemoteObject __ref,RemoteObject _pyobject,RemoteObject _value,RemoteObject _error) throws Exception{
try {
		Debug.PushSubsStack("CreateInternalPyTaskAsyncResult (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,336);
if (RapidSub.canDelegate("createinternalpytaskasyncresult")) { return __ref.runUserSub(false, "pyutils","createinternalpytaskasyncresult", __ref, _pyobject, _value, _error);}
RemoteObject _t1 = RemoteObject.declareNull("b4j.example.pybridge._internalpytaskasyncresult");
Debug.locals.put("PyObject", _pyobject);
Debug.locals.put("Value", _value);
Debug.locals.put("Error", _error);
 BA.debugLineNum = 336;BA.debugLine="Private Sub CreateInternalPyTaskAsyncResult (PyObj";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 337;BA.debugLine="Dim t1 As InternalPyTaskAsyncResult";
Debug.JustUpdateDeviceLine();
_t1 = RemoteObject.createNew ("b4j.example.pybridge._internalpytaskasyncresult");Debug.locals.put("t1", _t1);
 BA.debugLineNum = 338;BA.debugLine="t1.Initialize";
Debug.JustUpdateDeviceLine();
_t1.runVoidMethod ("Initialize");
 BA.debugLineNum = 339;BA.debugLine="t1.PyObject = PyObject";
Debug.JustUpdateDeviceLine();
_t1.setField ("PyObject" /*RemoteObject*/ ,_pyobject);
 BA.debugLineNum = 340;BA.debugLine="t1.Value = Value";
Debug.JustUpdateDeviceLine();
_t1.setField ("Value" /*RemoteObject*/ ,_value);
 BA.debugLineNum = 341;BA.debugLine="t1.Error = Error";
Debug.JustUpdateDeviceLine();
_t1.setField ("Error" /*RemoteObject*/ ,_error);
 BA.debugLineNum = 342;BA.debugLine="Return t1";
Debug.JustUpdateDeviceLine();
if (true) return _t1;
 BA.debugLineNum = 343;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createpyobject(RemoteObject __ref,RemoteObject _key) throws Exception{
try {
		Debug.PushSubsStack("CreatePyObject (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,225);
if (RapidSub.canDelegate("createpyobject")) { return __ref.runUserSub(false, "pyutils","createpyobject", __ref, _key);}
RemoteObject _t1 = RemoteObject.declareNull("b4j.example.pybridge._pyobject");
Debug.locals.put("Key", _key);
 BA.debugLineNum = 225;BA.debugLine="Public Sub CreatePyObject (Key As Int) As PyObject";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 226;BA.debugLine="Dim t1 As PyObject";
Debug.JustUpdateDeviceLine();
_t1 = RemoteObject.createNew ("b4j.example.pybridge._pyobject");Debug.locals.put("t1", _t1);
 BA.debugLineNum = 227;BA.debugLine="t1.Initialize";
Debug.JustUpdateDeviceLine();
_t1.runVoidMethod ("Initialize");
 BA.debugLineNum = 228;BA.debugLine="If Key = 0 Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_key,BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 229;BA.debugLine="PyObjectCounter = PyObjectCounter + 1";
Debug.JustUpdateDeviceLine();
__ref.setField ("_pyobjectcounter" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_pyobjectcounter" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "+",1, 1));
 BA.debugLineNum = 230;BA.debugLine="Key = PyObjectCounter";
Debug.JustUpdateDeviceLine();
_key = __ref.getField(true,"_pyobjectcounter" /*RemoteObject*/ );Debug.locals.put("Key", _key);
 };
 BA.debugLineNum = 232;BA.debugLine="t1.Key = Key";
Debug.JustUpdateDeviceLine();
_t1.setField ("Key" /*RemoteObject*/ ,_key);
 BA.debugLineNum = 233;BA.debugLine="RegisterForCleaning(t1)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_registerforcleaning" /*RemoteObject*/ ,(Object)(_t1));
 BA.debugLineNum = 234;BA.debugLine="Return t1";
Debug.JustUpdateDeviceLine();
if (true) return _t1;
 BA.debugLineNum = 235;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createpytask(RemoteObject __ref,RemoteObject _taskid,RemoteObject _tasktype,RemoteObject _extra) throws Exception{
try {
		Debug.PushSubsStack("CreatePyTask (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,212);
if (RapidSub.canDelegate("createpytask")) { return __ref.runUserSub(false, "pyutils","createpytask", __ref, _taskid, _tasktype, _extra);}
RemoteObject _t1 = RemoteObject.declareNull("b4j.example.pybridge._pytask");
Debug.locals.put("TaskId", _taskid);
Debug.locals.put("TaskType", _tasktype);
Debug.locals.put("Extra", _extra);
 BA.debugLineNum = 212;BA.debugLine="Public Sub CreatePyTask (TaskId As Int, TaskType A";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 213;BA.debugLine="Dim t1 As PyTask";
Debug.JustUpdateDeviceLine();
_t1 = RemoteObject.createNew ("b4j.example.pybridge._pytask");Debug.locals.put("t1", _t1);
 BA.debugLineNum = 214;BA.debugLine="t1.Initialize";
Debug.JustUpdateDeviceLine();
_t1.runVoidMethod ("Initialize");
 BA.debugLineNum = 215;BA.debugLine="If TaskId = 0 Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_taskid,BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 216;BA.debugLine="TaskIdCounter = TaskIdCounter + 1";
Debug.JustUpdateDeviceLine();
__ref.setField ("_taskidcounter" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_taskidcounter" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "+",1, 1));
 BA.debugLineNum = 217;BA.debugLine="TaskId = TaskIdCounter";
Debug.JustUpdateDeviceLine();
_taskid = __ref.getField(true,"_taskidcounter" /*RemoteObject*/ );Debug.locals.put("TaskId", _taskid);
 };
 BA.debugLineNum = 219;BA.debugLine="t1.TaskId = TaskId";
Debug.JustUpdateDeviceLine();
_t1.setField ("TaskId" /*RemoteObject*/ ,_taskid);
 BA.debugLineNum = 220;BA.debugLine="t1.TaskType = TaskType";
Debug.JustUpdateDeviceLine();
_t1.setField ("TaskType" /*RemoteObject*/ ,_tasktype);
 BA.debugLineNum = 221;BA.debugLine="t1.Extra = Extra";
Debug.JustUpdateDeviceLine();
_t1.setField ("Extra" /*RemoteObject*/ ,_extra);
 BA.debugLineNum = 222;BA.debugLine="Return t1";
Debug.JustUpdateDeviceLine();
if (true) return _t1;
 BA.debugLineNum = 223;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _detectos(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("DetectOS (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,345);
if (RapidSub.canDelegate("detectos")) { return __ref.runUserSub(false, "pyutils","detectos", __ref);}
RemoteObject _os = RemoteObject.createImmutable("");
 BA.debugLineNum = 345;BA.debugLine="Public Sub DetectOS As String";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 346;BA.debugLine="Dim os As String = GetSystemProperty(\"os.name\", \"";
Debug.JustUpdateDeviceLine();
_os = pyutils.__c.runMethod(true,"GetSystemProperty",(Object)(BA.ObjectToString("os.name")),(Object)(RemoteObject.createImmutable(""))).runMethod(true,"toLowerCase");Debug.locals.put("os", _os);Debug.locals.put("os", _os);
 BA.debugLineNum = 347;BA.debugLine="If os.Contains(\"win\") Then";
Debug.JustUpdateDeviceLine();
if (_os.runMethod(true,"contains",(Object)(RemoteObject.createImmutable("win"))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 348;BA.debugLine="Return \"windows\"";
Debug.JustUpdateDeviceLine();
if (true) return BA.ObjectToString("windows");
 }else 
{ BA.debugLineNum = 349;BA.debugLine="Else If os.Contains(\"mac\") Then";
Debug.JustUpdateDeviceLine();
if (_os.runMethod(true,"contains",(Object)(RemoteObject.createImmutable("mac"))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 350;BA.debugLine="Return \"mac\"";
Debug.JustUpdateDeviceLine();
if (true) return BA.ObjectToString("mac");
 }else {
 BA.debugLineNum = 352;BA.debugLine="Return \"linux\"";
Debug.JustUpdateDeviceLine();
if (true) return BA.ObjectToString("linux");
 }}
;
 BA.debugLineNum = 354;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _disconnected(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Disconnected (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,69);
if (RapidSub.canDelegate("disconnected")) { return __ref.runUserSub(false, "pyutils","disconnected", __ref);}
 BA.debugLineNum = 69;BA.debugLine="Public Sub Disconnected";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 70;BA.debugLine="CleanerIndex = CleanerIndex + 1";
Debug.JustUpdateDeviceLine();
__ref.setField ("_cleanerindex" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_cleanerindex" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "+",1, 1));
 BA.debugLineNum = 71;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fetch(RemoteObject __ref,RemoteObject _pyobject) throws Exception{
try {
		Debug.PushSubsStack("Fetch (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,175);
if (RapidSub.canDelegate("fetch")) { return __ref.runUserSub(false, "pyutils","fetch", __ref, _pyobject);}
ResumableSub_Fetch rsub = new ResumableSub_Fetch(null,__ref,_pyobject);
rsub.remoteResumableSub = anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSubForFilter();
rsub.resume(null, null);
return RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.keywords.Common.ResumableSubWrapper"), rsub.remoteResumableSub);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_Fetch extends BA.ResumableSub {
public ResumableSub_Fetch(b4j.example.pyutils parent,RemoteObject __ref,RemoteObject _pyobject) {
this.parent = parent;
this.__ref = __ref;
this._pyobject = _pyobject;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.pyutils parent;
RemoteObject _pyobject;
RemoteObject _task = RemoteObject.declareNull("b4j.example.pybridge._pytask");

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("Fetch (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,175);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,RemoteObject.createImmutable(null));return;}
case 0:
//C
this.state = -1;
Debug.locals.put("_ref", __ref);
Debug.locals.put("PyObject", _pyobject);
 BA.debugLineNum = 176;BA.debugLine="Dim TASK As PyTask = CreatePyTask(0, TASK_TYPE_GE";
Debug.JustUpdateDeviceLine();
_task = __ref.runClassMethod (b4j.example.pyutils.class, "_createpytask" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(true,"_task_type_get" /*RemoteObject*/ )),(Object)(parent.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(_pyobject.getField(true,"Key" /*RemoteObject*/ ))})))));Debug.locals.put("TASK", _task);Debug.locals.put("TASK", _task);
 BA.debugLineNum = 177;BA.debugLine="Comm.SendTaskAndWait(TASK)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_comm" /*RemoteObject*/ ).runClassMethod (b4j.example.pycomm.class, "_sendtaskandwait" /*RemoteObject*/ ,(Object)(_task));
 BA.debugLineNum = 178;BA.debugLine="Wait For (TASK) AsyncTask_Received (TASK As PyTas";
Debug.JustUpdateDeviceLine();
parent.__c.runVoidMethod ("WaitFor","asynctask_received", __ref.getField(false, "ba"), anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pyutils", "fetch"), (_task));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_task = (RemoteObject) result.getArrayElement(false,RemoteObject.createImmutable(1));Debug.locals.put("TASK", _task);
;
 BA.debugLineNum = 179;BA.debugLine="Return CheckForErrorsAndReturn(TASK, PyObject)";
Debug.JustUpdateDeviceLine();
if (true) {
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,(__ref.runClassMethod (b4j.example.pyutils.class, "_checkforerrorsandreturn" /*RemoteObject*/ ,(Object)(_task),(Object)(_pyobject))));return;};
 BA.debugLineNum = 180;BA.debugLine="End Sub";
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
public static void  _asynctask_received(RemoteObject __ref,RemoteObject _task) throws Exception{
}
public static RemoteObject  _flush(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Flush (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,162);
if (RapidSub.canDelegate("flush")) { return __ref.runUserSub(false, "pyutils","flush", __ref);}
ResumableSub_Flush rsub = new ResumableSub_Flush(null,__ref);
rsub.remoteResumableSub = anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSubForFilter();
rsub.resume(null, null);
return RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.keywords.Common.ResumableSubWrapper"), rsub.remoteResumableSub);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_Flush extends BA.ResumableSub {
public ResumableSub_Flush(b4j.example.pyutils parent,RemoteObject __ref) {
this.parent = parent;
this.__ref = __ref;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.pyutils parent;
RemoteObject _task = RemoteObject.declareNull("b4j.example.pybridge._pytask");

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("Flush (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,162);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,RemoteObject.createImmutable(null));return;}
case 0:
//C
this.state = 1;
Debug.locals.put("_ref", __ref);
 BA.debugLineNum = 163;BA.debugLine="Dim task As PyTask = CreatePyTask(0, TASK_TYPE_FL";
Debug.JustUpdateDeviceLine();
_task = __ref.runClassMethod (b4j.example.pyutils.class, "_createpytask" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(true,"_task_type_flush" /*RemoteObject*/ )),(Object)(parent.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {0},new Object[] {})))));Debug.locals.put("task", _task);Debug.locals.put("task", _task);
 BA.debugLineNum = 164;BA.debugLine="Comm.SendTaskAndWait(task)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_comm" /*RemoteObject*/ ).runClassMethod (b4j.example.pycomm.class, "_sendtaskandwait" /*RemoteObject*/ ,(Object)(_task));
 BA.debugLineNum = 165;BA.debugLine="Wait For (task) AsyncTask_Received (task As PyTas";
Debug.JustUpdateDeviceLine();
parent.__c.runVoidMethod ("WaitFor","asynctask_received", __ref.getField(false, "ba"), anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pyutils", "flush"), (_task));
this.state = 7;
return;
case 7:
//C
this.state = 1;
_task = (RemoteObject) result.getArrayElement(false,RemoteObject.createImmutable(1));Debug.locals.put("task", _task);
;
 BA.debugLineNum = 166;BA.debugLine="If task.TaskType = TASK_TYPE_ERROR Then";
Debug.JustUpdateDeviceLine();
if (true) break;

case 1:
//if
this.state = 6;
if (RemoteObject.solveBoolean("=",_task.getField(true,"TaskType" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(true,"_task_type_error" /*RemoteObject*/ )))) { 
this.state = 3;
}else {
this.state = 5;
}if (true) break;

case 3:
//C
this.state = 6;
 BA.debugLineNum = 167;BA.debugLine="mBridge.PyLastException = task.Extra.Get(0)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mbridge" /*RemoteObject*/ ).setField ("_pylastexception" /*RemoteObject*/ ,BA.ObjectToString(_task.getField(false,"Extra" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(BA.numberCast(int.class, 0)))));
 BA.debugLineNum = 168;BA.debugLine="Return False";
Debug.JustUpdateDeviceLine();
if (true) {
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,(parent.__c.getField(true,"False")));return;};
 if (true) break;

case 5:
//C
this.state = 6;
 BA.debugLineNum = 170;BA.debugLine="Return True";
Debug.JustUpdateDeviceLine();
if (true) {
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,(parent.__c.getField(true,"True")));return;};
 if (true) break;

case 6:
//C
this.state = -1;
;
 BA.debugLineNum = 172;BA.debugLine="End Sub";
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
public static RemoteObject  _forcegc(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("ForceGC (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,276);
if (RapidSub.canDelegate("forcegc")) { return __ref.runUserSub(false, "pyutils","forcegc", __ref);}
 BA.debugLineNum = 276;BA.debugLine="Public Sub ForceGC";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 277;BA.debugLine="LastMemorySize = MemorySlots.Size";
Debug.JustUpdateDeviceLine();
__ref.setField ("_lastmemorysize" /*RemoteObject*/ ,__ref.getField(false,"_memoryslots" /*RemoteObject*/ ).runMethod(true,"getSize"));
 BA.debugLineNum = 278;BA.debugLine="PyLog(B4JPrefix, mOptions.B4JColor, \"ForceGC: mem";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_pylog" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_b4jprefix" /*RemoteObject*/ )),(Object)(__ref.getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"B4JColor" /*RemoteObject*/ )),(Object)((RemoteObject.concat(RemoteObject.createImmutable("ForceGC: memory slots - "),__ref.getField(true,"_lastmemorysize" /*RemoteObject*/ )))));
 BA.debugLineNum = 279;BA.debugLine="System.RunMethod(\"gc\", Null)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_system" /*RemoteObject*/ ).runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("gc")),(Object)((pyutils.__c.getField(false,"Null"))));
 BA.debugLineNum = 280;BA.debugLine="KeysImpl";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_keysimpl" /*RemoteObject*/ );
 BA.debugLineNum = 281;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _bridge,RemoteObject _vcomm) throws Exception{
try {
		Debug.PushSubsStack("Initialize (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,31);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "pyutils","initialize", __ref, _ba, _bridge, _vcomm);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
Debug.locals.put("bridge", _bridge);
Debug.locals.put("vComm", _vcomm);
 BA.debugLineNum = 31;BA.debugLine="Public Sub Initialize (bridge As PyBridge, vComm A";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 32;BA.debugLine="mBridge = bridge";
Debug.JustUpdateDeviceLine();
__ref.setField ("_mbridge" /*RemoteObject*/ ,_bridge);
 BA.debugLineNum = 33;BA.debugLine="CleanerClass = CleanerClass.InitializeStatic(GetT";
Debug.JustUpdateDeviceLine();
__ref.setField ("_cleanerclass" /*RemoteObject*/ ,__ref.getField(false,"_cleanerclass" /*RemoteObject*/ ).runMethod(false,"InitializeStatic",(Object)(RemoteObject.concat(pyutils.__c.runMethod(true,"GetType",(Object)(__ref)),RemoteObject.createImmutable("$CleanRunnable")))));
 BA.debugLineNum = 34;BA.debugLine="cleaner = cleaner.InitializeStatic(\"java.lang.ref";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_cleaner" /*RemoteObject*/ ).setObject (__ref.getField(false,"_cleaner" /*RemoteObject*/ ).runMethod(false,"InitializeStatic",(Object)(RemoteObject.createImmutable("java.lang.ref.Cleaner"))).runMethod(false,"RunMethod",(Object)(BA.ObjectToString("create")),(Object)((pyutils.__c.getField(false,"Null")))));
 BA.debugLineNum = 35;BA.debugLine="System.InitializeStatic(\"System\")";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_system" /*RemoteObject*/ ).runVoidMethod ("InitializeStatic",(Object)(RemoteObject.createImmutable("System")));
 BA.debugLineNum = 36;BA.debugLine="PackageName = GetType(Me)";
Debug.JustUpdateDeviceLine();
__ref.setField ("_packagename" /*RemoteObject*/ ,pyutils.__c.runMethod(true,"GetType",(Object)(__ref)));
 BA.debugLineNum = 37;BA.debugLine="PackageName = PackageName.SubString2(0, PackageNa";
Debug.JustUpdateDeviceLine();
__ref.setField ("_packagename" /*RemoteObject*/ ,__ref.getField(true,"_packagename" /*RemoteObject*/ ).runMethod(true,"substring",(Object)(BA.numberCast(int.class, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_packagename" /*RemoteObject*/ ).runMethod(true,"length"),RemoteObject.createImmutable(".pyutils").runMethod(true,"length")}, "-",1, 1))));
 BA.debugLineNum = 38;BA.debugLine="KeysThatNeedToBeRegistered.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_keysthatneedtoberegistered" /*RemoteObject*/ ).runVoidMethod ("Initialize");
 BA.debugLineNum = 39;BA.debugLine="ObjectsThatNeedToBeRegistered.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_objectsthatneedtoberegistered" /*RemoteObject*/ ).runVoidMethod ("Initialize");
 BA.debugLineNum = 40;BA.debugLine="MemorySlots.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_memoryslots" /*RemoteObject*/ ).runVoidMethod ("Initialize");
 BA.debugLineNum = 41;BA.debugLine="If GetSystemProperty(\"b4j.ide\", False) = True The";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",pyutils.__c.runMethod(true,"GetSystemProperty",(Object)(BA.ObjectToString("b4j.ide")),(Object)(BA.ObjectToString(pyutils.__c.getField(true,"False")))),BA.ObjectToString(pyutils.__c.getField(true,"True")))) { 
 BA.debugLineNum = 42;BA.debugLine="PyErrPrefix = \"\"";
Debug.JustUpdateDeviceLine();
__ref.setField ("_pyerrprefix" /*RemoteObject*/ ,BA.ObjectToString(""));
 BA.debugLineNum = 43;BA.debugLine="PyOutPrefix = \"\"";
Debug.JustUpdateDeviceLine();
__ref.setField ("_pyoutprefix" /*RemoteObject*/ ,BA.ObjectToString(""));
 BA.debugLineNum = 44;BA.debugLine="B4JPrefix = \"\"";
Debug.JustUpdateDeviceLine();
__ref.setField ("_b4jprefix" /*RemoteObject*/ ,BA.ObjectToString(""));
 };
 BA.debugLineNum = 46;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _isarray(RemoteObject __ref,RemoteObject _obj) throws Exception{
try {
		Debug.PushSubsStack("IsArray (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,136);
if (RapidSub.canDelegate("isarray")) { return __ref.runUserSub(false, "pyutils","isarray", __ref, _obj);}
Debug.locals.put("obj", _obj);
 BA.debugLineNum = 136;BA.debugLine="Private Sub IsArray(obj As Object) As Boolean";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 137;BA.debugLine="Return obj <> Null And \"[Ljava.lang.Object;\" = Ge";
Debug.JustUpdateDeviceLine();
if (true) return BA.ObjectToBoolean(RemoteObject.solveBoolean("N",_obj) && RemoteObject.solveBoolean("=",RemoteObject.createImmutable("[Ljava.lang.Object;"),pyutils.__c.runMethod(true,"GetType",(Object)(_obj))));
 BA.debugLineNum = 138;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _keysimpl(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("KeysImpl (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,264);
if (RapidSub.canDelegate("keysimpl")) { return __ref.runUserSub(false, "pyutils","keysimpl", __ref);}
RemoteObject _keys = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _key = RemoteObject.createImmutable(0);
 BA.debugLineNum = 264;BA.debugLine="Private Sub KeysImpl";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 265;BA.debugLine="Dim keys As List = CleanerClass.RunMethod(\"getKey";
Debug.JustUpdateDeviceLine();
_keys = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");
_keys = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), __ref.getField(false,"_cleanerclass" /*RemoteObject*/ ).runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getKeys")),(Object)((pyutils.__c.getField(false,"Null")))));Debug.locals.put("keys", _keys);Debug.locals.put("keys", _keys);
 BA.debugLineNum = 266;BA.debugLine="If keys.Size > 0 Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",_keys.runMethod(true,"getSize"),BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 267;BA.debugLine="Comm.SendTask(CreatePyTask(0, TASK_TYPE_CLEAN, k";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_comm" /*RemoteObject*/ ).runClassMethod (b4j.example.pycomm.class, "_sendtask" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.pyutils.class, "_createpytask" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(true,"_task_type_clean" /*RemoteObject*/ )),(Object)(_keys))));
 BA.debugLineNum = 268;BA.debugLine="For Each key As Int In keys";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group4 = _keys;
final int groupLen4 = group4.runMethod(true,"getSize").<Integer>get()
;int index4 = 0;
;
for (; index4 < groupLen4;index4++){
_key = BA.numberCast(int.class, group4.runMethod(false,"Get",index4));Debug.locals.put("key", _key);
Debug.locals.put("key", _key);
 BA.debugLineNum = 269;BA.debugLine="MemorySlots.Remove(key)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_memoryslots" /*RemoteObject*/ ).runVoidMethod ("Remove",(Object)((_key)));
 }
}Debug.locals.put("key", _key);
;
 BA.debugLineNum = 271;BA.debugLine="LastMemorySize = MemorySlots.Size";
Debug.JustUpdateDeviceLine();
__ref.setField ("_lastmemorysize" /*RemoteObject*/ ,__ref.getField(false,"_memoryslots" /*RemoteObject*/ ).runMethod(true,"getSize"));
 };
 BA.debugLineNum = 273;BA.debugLine="RegisterKeys";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_registerkeys" /*RemoteObject*/ );
 BA.debugLineNum = 274;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _pylog(RemoteObject __ref,RemoteObject _prefix,RemoteObject _clr,RemoteObject _o) throws Exception{
try {
		Debug.PushSubsStack("PyLog (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,183);
if (RapidSub.canDelegate("pylog")) { return __ref.runUserSub(false, "pyutils","pylog", __ref, _prefix, _clr, _o);}
RemoteObject _s = RemoteObject.createImmutable("");
RemoteObject _lines = null;
RemoteObject _line = RemoteObject.createImmutable("");
Debug.locals.put("Prefix", _prefix);
Debug.locals.put("Clr", _clr);
Debug.locals.put("O", _o);
 BA.debugLineNum = 183;BA.debugLine="Public Sub PyLog(Prefix As String, Clr As Int, O A";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 185;BA.debugLine="If o Is PyWrapper Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("i",_o, RemoteObject.createImmutable("b4j.example.pywrapper"))) { 
 BA.debugLineNum = 186;BA.debugLine="mBridge.PrintJoin(Array(o), Clr = mOptions.PyErr";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mbridge" /*RemoteObject*/ ).runClassMethod (b4j.example.pybridge.class, "_printjoin" /*RemoteObject*/ ,(Object)(pyutils.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {_o})))),(Object)(BA.ObjectToBoolean(RemoteObject.solveBoolean("=",_clr,BA.numberCast(double.class, __ref.getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"PyErrColor" /*RemoteObject*/ ))))));
 }else {
 BA.debugLineNum = 188;BA.debugLine="Dim s As String = o";
Debug.JustUpdateDeviceLine();
_s = BA.ObjectToString(_o);Debug.locals.put("s", _s);Debug.locals.put("s", _s);
 BA.debugLineNum = 189;BA.debugLine="If s.Length > 3900 Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",_s.runMethod(true,"length"),BA.numberCast(double.class, 3900))) { 
 BA.debugLineNum = 190;BA.debugLine="s = s.SubString2(0, 3900) & CRLF & \"(message tr";
Debug.JustUpdateDeviceLine();
_s = RemoteObject.concat(_s.runMethod(true,"substring",(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 3900))),pyutils.__c.getField(true,"CRLF"),RemoteObject.createImmutable("(message truncated)"));Debug.locals.put("s", _s);
 };
 BA.debugLineNum = 192;BA.debugLine="s = s.Trim.Replace(Chr(13), \"\")";
Debug.JustUpdateDeviceLine();
_s = _s.runMethod(true,"trim").runMethod(true,"replace",(Object)(BA.ObjectToString(pyutils.__c.runMethod(true,"Chr",(Object)(BA.numberCast(int.class, 13))))),(Object)(RemoteObject.createImmutable("")));Debug.locals.put("s", _s);
 BA.debugLineNum = 193;BA.debugLine="Dim lines() As String = Regex.Split(\"\\n+\", s)";
Debug.JustUpdateDeviceLine();
_lines = pyutils.__c.getField(false,"Regex").runMethod(false,"Split",(Object)(BA.ObjectToString("\\n+")),(Object)(_s));Debug.locals.put("lines", _lines);Debug.locals.put("lines", _lines);
 BA.debugLineNum = 194;BA.debugLine="For Each line As String In lines";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group10 = _lines;
final int groupLen10 = group10.getField(true,"length").<Integer>get()
;int index10 = 0;
;
for (; index10 < groupLen10;index10++){
_line = group10.getArrayElement(true,RemoteObject.createImmutable(index10));Debug.locals.put("line", _line);
Debug.locals.put("line", _line);
 BA.debugLineNum = 195;BA.debugLine="line = line.Trim";
Debug.JustUpdateDeviceLine();
_line = _line.runMethod(true,"trim");Debug.locals.put("line", _line);
 BA.debugLineNum = 196;BA.debugLine="If line.StartsWith(\"~de:\") Then";
Debug.JustUpdateDeviceLine();
if (_line.runMethod(true,"startsWith",(Object)(RemoteObject.createImmutable("~de:"))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 197;BA.debugLine="mBridge.ErrorHandler.UntangleError(line)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_errorhandler" /*RemoteObject*/ ).runClassMethod (b4j.example.pyerrorhandler.class, "_untangleerror" /*RemoteObject*/ ,(Object)(_line));
 }else 
{ BA.debugLineNum = 198;BA.debugLine="Else If Clr <> 0 Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("!",_clr,BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 199;BA.debugLine="If Comm.State = Comm.STATE_DISCONNECTED And li";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_comm" /*RemoteObject*/ ).getField(true,"_state" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(false,"_comm" /*RemoteObject*/ ).getField(true,"_state_disconnected" /*RemoteObject*/ ))) && RemoteObject.solveBoolean(".",_line.runMethod(true,"startsWith",(Object)(RemoteObject.createImmutable("Unhandled exception in task"))))) { 
 BA.debugLineNum = 200;BA.debugLine="Return";
Debug.JustUpdateDeviceLine();
if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 202;BA.debugLine="LogColor(Prefix & line, Clr)";
Debug.JustUpdateDeviceLine();
pyutils.__c.runVoidMethod ("LogImpl","95308435",RemoteObject.concat(_prefix,_line),_clr);
 }else {
 BA.debugLineNum = 204;BA.debugLine="Log(Prefix & line)";
Debug.JustUpdateDeviceLine();
pyutils.__c.runVoidMethod ("LogImpl","95308437",RemoteObject.concat(_prefix,_line),0);
 }}
;
 }
}Debug.locals.put("line", _line);
;
 };
 BA.debugLineNum = 209;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _registerforcleaning(RemoteObject __ref,RemoteObject _py) throws Exception{
try {
		Debug.PushSubsStack("RegisterForCleaning (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,244);
if (RapidSub.canDelegate("registerforcleaning")) { return __ref.runUserSub(false, "pyutils","registerforcleaning", __ref, _py);}
Debug.locals.put("Py", _py);
 BA.debugLineNum = 244;BA.debugLine="Private Sub RegisterForCleaning (Py As PyObject)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 245;BA.debugLine="ObjectsThatNeedToBeRegistered.Add(Py)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_objectsthatneedtoberegistered" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)((_py)));
 BA.debugLineNum = 246;BA.debugLine="KeysThatNeedToBeRegistered.Add(Py.Key)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_keysthatneedtoberegistered" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)((_py.getField(true,"Key" /*RemoteObject*/ ))));
 BA.debugLineNum = 247;BA.debugLine="MemorySlots.Put(Py.Key, Null)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_memoryslots" /*RemoteObject*/ ).runVoidMethod ("Put",(Object)((_py.getField(true,"Key" /*RemoteObject*/ ))),(Object)(pyutils.__c.getField(false,"Null")));
 BA.debugLineNum = 248;BA.debugLine="If MemorySlots.Size - LastMemorySize > MEMORY_INC";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_memoryslots" /*RemoteObject*/ ).runMethod(true,"getSize"),__ref.getField(true,"_lastmemorysize" /*RemoteObject*/ )}, "-",1, 1),BA.numberCast(double.class, __ref.getField(true,"_memory_increase_threshold" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 249;BA.debugLine="ForceGC";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_forcegc" /*RemoteObject*/ );
 };
 BA.debugLineNum = 251;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _registerkeys(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("RegisterKeys (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,283);
if (RapidSub.canDelegate("registerkeys")) { return __ref.runUserSub(false, "pyutils","registerkeys", __ref);}
 BA.debugLineNum = 283;BA.debugLine="Private Sub RegisterKeys";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 284;BA.debugLine="CleanerClass.RunMethod(\"registerMultipleKeys\", Ar";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_cleanerclass" /*RemoteObject*/ ).runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("registerMultipleKeys")),(Object)(RemoteObject.createNewArray("Object",new int[] {3},new Object[] {(__ref.getField(false,"_objectsthatneedtoberegistered" /*RemoteObject*/ ).getObject()),(__ref.getField(false,"_keysthatneedtoberegistered" /*RemoteObject*/ ).getObject()),(__ref.getField(false,"_cleaner" /*RemoteObject*/ ).getObject())})));
 BA.debugLineNum = 285;BA.debugLine="ObjectsThatNeedToBeRegistered.Clear";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_objectsthatneedtoberegistered" /*RemoteObject*/ ).runVoidMethod ("Clear");
 BA.debugLineNum = 286;BA.debugLine="KeysThatNeedToBeRegistered.Clear";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_keysthatneedtoberegistered" /*RemoteObject*/ ).runVoidMethod ("Clear");
 BA.debugLineNum = 287;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _run(RemoteObject __ref,RemoteObject _target,RemoteObject _method,RemoteObject _args) throws Exception{
try {
		Debug.PushSubsStack("Run (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,74);
if (RapidSub.canDelegate("run")) { return __ref.runUserSub(false, "pyutils","run", __ref, _target, _method, _args);}
RemoteObject _res = RemoteObject.declareNull("b4j.example.pybridge._pyobject");
RemoteObject _task = RemoteObject.declareNull("b4j.example.pybridge._pytask");
Debug.locals.put("Target", _target);
Debug.locals.put("Method", _method);
Debug.locals.put("Args", _args);
 BA.debugLineNum = 74;BA.debugLine="Public Sub Run (Target As PyObject, Method As Stri";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 75;BA.debugLine="Dim res As PyObject = CreatePyObject(0)";
Debug.JustUpdateDeviceLine();
_res = __ref.runClassMethod (b4j.example.pyutils.class, "_createpyobject" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 0)));Debug.locals.put("res", _res);Debug.locals.put("res", _res);
 BA.debugLineNum = 76;BA.debugLine="Dim TASK As PyTask = CreatePyTask(0, TASK_TYPE_RU";
Debug.JustUpdateDeviceLine();
_task = __ref.runClassMethod (b4j.example.pyutils.class, "_createpytask" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(true,"_task_type_run" /*RemoteObject*/ )),(Object)(pyutils.__c.runMethod(false, "ArrayToList", (Object)(__ref.runClassMethod (b4j.example.pyutils.class, "_createextra" /*RemoteObject*/ ,(Object)(_target),(Object)(_method),(Object)(_args),(Object)(_res))))));Debug.locals.put("TASK", _task);Debug.locals.put("TASK", _task);
 BA.debugLineNum = 77;BA.debugLine="mBridge.ErrorHandler.AddDataToTask(TASK)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_errorhandler" /*RemoteObject*/ ).runClassMethod (b4j.example.pyerrorhandler.class, "_adddatatotask" /*RemoteObject*/ ,(Object)(_task));
 BA.debugLineNum = 78;BA.debugLine="Comm.SendTask(TASK)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_comm" /*RemoteObject*/ ).runClassMethod (b4j.example.pycomm.class, "_sendtask" /*RemoteObject*/ ,(Object)(_task));
 BA.debugLineNum = 79;BA.debugLine="Return res";
Debug.JustUpdateDeviceLine();
if (true) return _res;
 BA.debugLineNum = 80;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _runasync(RemoteObject __ref,RemoteObject _target,RemoteObject _method,RemoteObject _args) throws Exception{
try {
		Debug.PushSubsStack("RunAsync (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,91);
if (RapidSub.canDelegate("runasync")) { return __ref.runUserSub(false, "pyutils","runasync", __ref, _target, _method, _args);}
ResumableSub_RunAsync rsub = new ResumableSub_RunAsync(null,__ref,_target,_method,_args);
rsub.remoteResumableSub = anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSubForFilter();
rsub.resume(null, null);
return RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.keywords.Common.ResumableSubWrapper"), rsub.remoteResumableSub);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_RunAsync extends BA.ResumableSub {
public ResumableSub_RunAsync(b4j.example.pyutils parent,RemoteObject __ref,RemoteObject _target,RemoteObject _method,RemoteObject _args) {
this.parent = parent;
this.__ref = __ref;
this._target = _target;
this._method = _method;
this._args = _args;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.pyutils parent;
RemoteObject _target;
RemoteObject _method;
RemoteObject _args;
RemoteObject _res = RemoteObject.declareNull("b4j.example.pybridge._pyobject");
RemoteObject _task = RemoteObject.declareNull("b4j.example.pybridge._pytask");

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("RunAsync (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,91);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,RemoteObject.createImmutable(null));return;}
case 0:
//C
this.state = -1;
Debug.locals.put("_ref", __ref);
Debug.locals.put("Target", _target);
Debug.locals.put("Method", _method);
Debug.locals.put("Args", _args);
 BA.debugLineNum = 92;BA.debugLine="Dim res As PyObject = CreatePyObject(0)";
Debug.JustUpdateDeviceLine();
_res = __ref.runClassMethod (b4j.example.pyutils.class, "_createpyobject" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 0)));Debug.locals.put("res", _res);Debug.locals.put("res", _res);
 BA.debugLineNum = 93;BA.debugLine="Dim TASK As PyTask = CreatePyTask(0, TASK_TYPE_RU";
Debug.JustUpdateDeviceLine();
_task = __ref.runClassMethod (b4j.example.pyutils.class, "_createpytask" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(true,"_task_type_run_async" /*RemoteObject*/ )),(Object)(parent.__c.runMethod(false, "ArrayToList", (Object)(__ref.runClassMethod (b4j.example.pyutils.class, "_createextra" /*RemoteObject*/ ,(Object)(_target),(Object)(_method),(Object)(_args),(Object)(_res))))));Debug.locals.put("TASK", _task);Debug.locals.put("TASK", _task);
 BA.debugLineNum = 94;BA.debugLine="mBridge.ErrorHandler.AddDataToTask(TASK)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_errorhandler" /*RemoteObject*/ ).runClassMethod (b4j.example.pyerrorhandler.class, "_adddatatotask" /*RemoteObject*/ ,(Object)(_task));
 BA.debugLineNum = 95;BA.debugLine="Comm.SendTaskAndWait(TASK)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_comm" /*RemoteObject*/ ).runClassMethod (b4j.example.pycomm.class, "_sendtaskandwait" /*RemoteObject*/ ,(Object)(_task));
 BA.debugLineNum = 96;BA.debugLine="Wait For (TASK) AsyncTask_Received (TASK As PyTas";
Debug.JustUpdateDeviceLine();
parent.__c.runVoidMethod ("WaitFor","asynctask_received", __ref.getField(false, "ba"), anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pyutils", "runasync"), (_task));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_task = (RemoteObject) result.getArrayElement(false,RemoteObject.createImmutable(1));Debug.locals.put("TASK", _task);
;
 BA.debugLineNum = 97;BA.debugLine="Return CheckForErrorsAndReturn(TASK, res)";
Debug.JustUpdateDeviceLine();
if (true) {
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,(__ref.runClassMethod (b4j.example.pyutils.class, "_checkforerrorsandreturn" /*RemoteObject*/ ,(Object)(_task),(Object)(_res))));return;};
 BA.debugLineNum = 98;BA.debugLine="End Sub";
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
public static RemoteObject  _unwrapbeforeserialization(RemoteObject __ref,RemoteObject _extra) throws Exception{
try {
		Debug.PushSubsStack("UnwrapBeforeSerialization (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,100);
if (RapidSub.canDelegate("unwrapbeforeserialization")) { return __ref.runUserSub(false, "pyutils","unwrapbeforeserialization", __ref, _extra);}
Debug.locals.put("Extra", _extra);
 BA.debugLineNum = 100;BA.debugLine="Public Sub UnwrapBeforeSerialization (Extra As Lis";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 101;BA.debugLine="UnwrapList(Extra.Get(2))";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_unwraplist" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), _extra.runMethod(false,"Get",(Object)(BA.numberCast(int.class, 2)))));
 BA.debugLineNum = 102;BA.debugLine="UnwrapMap(Extra.Get(3))";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_unwrapmap" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _extra.runMethod(false,"Get",(Object)(BA.numberCast(int.class, 3)))));
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
public static RemoteObject  _unwraplist(RemoteObject __ref,RemoteObject _lst) throws Exception{
try {
		Debug.PushSubsStack("UnwrapList (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,105);
if (RapidSub.canDelegate("unwraplist")) { return __ref.runUserSub(false, "pyutils","unwraplist", __ref, _lst);}
int _i = 0;
RemoteObject _v = RemoteObject.declareNull("Object");
Debug.locals.put("Lst", _lst);
 BA.debugLineNum = 105;BA.debugLine="Private Sub UnwrapList (Lst As List)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 106;BA.debugLine="If NotInitialized(Lst) Then Return";
Debug.JustUpdateDeviceLine();
if (pyutils.__c.runMethod(true,"NotInitialized",(Object)((_lst))).<Boolean>get().booleanValue()) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 107;BA.debugLine="For i = 0 To Lst.Size - 1";
Debug.JustUpdateDeviceLine();
{
final int step2 = 1;
final int limit2 = RemoteObject.solve(new RemoteObject[] {_lst.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step2 > 0 && _i <= limit2) || (step2 < 0 && _i >= limit2) ;_i = ((int)(0 + _i + step2))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 108;BA.debugLine="Dim v As Object = Lst.Get(i)";
Debug.JustUpdateDeviceLine();
_v = _lst.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i)));Debug.locals.put("v", _v);Debug.locals.put("v", _v);
 BA.debugLineNum = 109;BA.debugLine="If v Is PyWrapper Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("i",_v, RemoteObject.createImmutable("b4j.example.pywrapper"))) { 
 BA.debugLineNum = 110;BA.debugLine="Lst.Set(i, v.As(PyWrapper).InternalKey)";
Debug.JustUpdateDeviceLine();
_lst.runVoidMethod ("Set",(Object)(BA.numberCast(int.class, _i)),(Object)((((_v)).getField(false,"_internalkey" /*RemoteObject*/ ))));
 }else 
{ BA.debugLineNum = 111;BA.debugLine="Else If v Is List Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("i",_v, RemoteObject.createImmutable("java.util.List"))) { 
 BA.debugLineNum = 112;BA.debugLine="UnwrapList(v)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_unwraplist" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), _v));
 }else 
{ BA.debugLineNum = 113;BA.debugLine="Else If v Is Map Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("i",_v, RemoteObject.createImmutable("java.util.Map"))) { 
 BA.debugLineNum = 114;BA.debugLine="UnwrapMap(v)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_unwrapmap" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _v));
 }else 
{ BA.debugLineNum = 115;BA.debugLine="Else If IsArray(v) Then";
Debug.JustUpdateDeviceLine();
if (__ref.runClassMethod (b4j.example.pyutils.class, "_isarray" /*RemoteObject*/ ,(Object)(_v)).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 116;BA.debugLine="UnwrapTuple(v)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_unwraptuple" /*RemoteObject*/ ,(Object)((_v)));
 }}}}
;
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 119;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _unwrapmap(RemoteObject __ref,RemoteObject _map) throws Exception{
try {
		Debug.PushSubsStack("UnwrapMap (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,140);
if (RapidSub.canDelegate("unwrapmap")) { return __ref.runUserSub(false, "pyutils","unwrapmap", __ref, _map);}
RemoteObject _keysthatneedtobeunwrapped = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _key = RemoteObject.declareNull("Object");
RemoteObject _value = RemoteObject.declareNull("Object");
Debug.locals.put("Map", _map);
 BA.debugLineNum = 140;BA.debugLine="Private Sub UnwrapMap (Map As Map)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 141;BA.debugLine="If NotInitialized(Map) Then Return";
Debug.JustUpdateDeviceLine();
if (pyutils.__c.runMethod(true,"NotInitialized",(Object)((_map))).<Boolean>get().booleanValue()) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 142;BA.debugLine="Dim KeysThatNeedToBeUnwrapped As List";
Debug.JustUpdateDeviceLine();
_keysthatneedtobeunwrapped = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("KeysThatNeedToBeUnwrapped", _keysthatneedtobeunwrapped);
 BA.debugLineNum = 143;BA.debugLine="KeysThatNeedToBeUnwrapped.Initialize";
Debug.JustUpdateDeviceLine();
_keysthatneedtobeunwrapped.runVoidMethod ("Initialize");
 BA.debugLineNum = 144;BA.debugLine="For Each key As Object In Map.Keys";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group4 = _map.runMethod(false,"Keys");
final int groupLen4 = group4.runMethod(true,"getSize").<Integer>get()
;int index4 = 0;
;
for (; index4 < groupLen4;index4++){
_key = group4.runMethod(false,"Get",index4);Debug.locals.put("key", _key);
Debug.locals.put("key", _key);
 BA.debugLineNum = 145;BA.debugLine="Dim value As Object = Map.Get(key)";
Debug.JustUpdateDeviceLine();
_value = _map.runMethod(false,"Get",(Object)(_key));Debug.locals.put("value", _value);Debug.locals.put("value", _value);
 BA.debugLineNum = 146;BA.debugLine="If value Is PyWrapper Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("i",_value, RemoteObject.createImmutable("b4j.example.pywrapper"))) { 
 BA.debugLineNum = 147;BA.debugLine="KeysThatNeedToBeUnwrapped.Add(key)";
Debug.JustUpdateDeviceLine();
_keysthatneedtobeunwrapped.runVoidMethod ("Add",(Object)(_key));
 }else 
{ BA.debugLineNum = 148;BA.debugLine="Else If value Is List Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("i",_value, RemoteObject.createImmutable("java.util.List"))) { 
 BA.debugLineNum = 149;BA.debugLine="UnwrapList(value)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_unwraplist" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), _value));
 }else 
{ BA.debugLineNum = 150;BA.debugLine="Else If value Is Map Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("i",_value, RemoteObject.createImmutable("java.util.Map"))) { 
 BA.debugLineNum = 151;BA.debugLine="UnwrapMap(value)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_unwrapmap" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _value));
 }else 
{ BA.debugLineNum = 152;BA.debugLine="Else If IsArray(value) Then";
Debug.JustUpdateDeviceLine();
if (__ref.runClassMethod (b4j.example.pyutils.class, "_isarray" /*RemoteObject*/ ,(Object)(_value)).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 153;BA.debugLine="UnwrapTuple(value)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_unwraptuple" /*RemoteObject*/ ,(Object)((_value)));
 }}}}
;
 }
}Debug.locals.put("key", _key);
;
 BA.debugLineNum = 156;BA.debugLine="For Each key As Object In KeysThatNeedToBeUnwrapp";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group16 = _keysthatneedtobeunwrapped;
final int groupLen16 = group16.runMethod(true,"getSize").<Integer>get()
;int index16 = 0;
;
for (; index16 < groupLen16;index16++){
_key = group16.runMethod(false,"Get",index16);Debug.locals.put("key", _key);
Debug.locals.put("key", _key);
 BA.debugLineNum = 157;BA.debugLine="Dim value As Object = Map.Get(key)";
Debug.JustUpdateDeviceLine();
_value = _map.runMethod(false,"Get",(Object)(_key));Debug.locals.put("value", _value);Debug.locals.put("value", _value);
 BA.debugLineNum = 158;BA.debugLine="Map.Put(key, value.As(PyWrapper).InternalKey)";
Debug.JustUpdateDeviceLine();
_map.runVoidMethod ("Put",(Object)(_key),(Object)((((_value)).getField(false,"_internalkey" /*RemoteObject*/ ))));
 }
}Debug.locals.put("key", _key);
;
 BA.debugLineNum = 160;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _unwraptuple(RemoteObject __ref,RemoteObject _obj) throws Exception{
try {
		Debug.PushSubsStack("UnwrapTuple (pyutils) ","pyutils",7,__ref.getField(false, "ba"),__ref,121);
if (RapidSub.canDelegate("unwraptuple")) { return __ref.runUserSub(false, "pyutils","unwraptuple", __ref, _obj);}
int _i = 0;
RemoteObject _o = RemoteObject.declareNull("Object");
Debug.locals.put("Obj", _obj);
 BA.debugLineNum = 121;BA.debugLine="Private Sub UnwrapTuple (Obj() As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 122;BA.debugLine="For i = 0 To Obj.Length - 1";
Debug.JustUpdateDeviceLine();
{
final int step1 = 1;
final int limit1 = RemoteObject.solve(new RemoteObject[] {_obj.getField(true,"length"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step1 > 0 && _i <= limit1) || (step1 < 0 && _i >= limit1) ;_i = ((int)(0 + _i + step1))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 123;BA.debugLine="Dim o As Object = Obj(i)";
Debug.JustUpdateDeviceLine();
_o = _obj.getArrayElement(false,BA.numberCast(int.class, _i));Debug.locals.put("o", _o);Debug.locals.put("o", _o);
 BA.debugLineNum = 124;BA.debugLine="If o Is PyWrapper Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("i",_o, RemoteObject.createImmutable("b4j.example.pywrapper"))) { 
 BA.debugLineNum = 125;BA.debugLine="Obj(i) = o.As(PyWrapper).InternalKey";
Debug.JustUpdateDeviceLine();
_obj.setArrayElement ((((_o)).getField(false,"_internalkey" /*RemoteObject*/ )),BA.numberCast(int.class, _i));
 }else 
{ BA.debugLineNum = 126;BA.debugLine="Else If o Is List Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("i",_o, RemoteObject.createImmutable("java.util.List"))) { 
 BA.debugLineNum = 127;BA.debugLine="UnwrapList(o)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_unwraplist" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), _o));
 }else 
{ BA.debugLineNum = 128;BA.debugLine="Else If o Is Map Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("i",_o, RemoteObject.createImmutable("java.util.Map"))) { 
 BA.debugLineNum = 129;BA.debugLine="UnwrapMap(o)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_unwrapmap" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _o));
 }else 
{ BA.debugLineNum = 130;BA.debugLine="Else If IsArray(o) Then";
Debug.JustUpdateDeviceLine();
if (__ref.runClassMethod (b4j.example.pyutils.class, "_isarray" /*RemoteObject*/ ,(Object)(_o)).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 131;BA.debugLine="UnwrapTuple(o)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pyutils.class, "_unwraptuple" /*RemoteObject*/ ,(Object)((_o)));
 }}}}
;
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 134;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}