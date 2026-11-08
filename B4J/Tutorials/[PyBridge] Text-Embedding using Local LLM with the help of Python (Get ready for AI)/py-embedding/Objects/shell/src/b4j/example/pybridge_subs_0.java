package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class pybridge_subs_0 {


public static RemoteObject  _afterconnection(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("AfterConnection (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,143);
if (RapidSub.canDelegate("afterconnection")) { return __ref.runUserSub(false, "pybridge","afterconnection", __ref);}
 BA.debugLineNum = 143;BA.debugLine="Private Sub AfterConnection";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 144;BA.debugLine="Bridge.Initialize(Me, Utils.CreatePyObject(1))";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_bridge" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"),(Object)((__ref)),(Object)(__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_createpyobject" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 1)))));
 BA.debugLineNum = 145;BA.debugLine="Builtins.Initialize(Me, Utils.CreatePyObject(3))";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"),(Object)((__ref)),(Object)(__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_createpyobject" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 3)))));
 BA.debugLineNum = 146;BA.debugLine="Utils.Connected(Utils.CreatePyObject(2), mOptions";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_connected" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_createpyobject" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 2)))),(Object)(__ref.getField(false,"_moptions" /*RemoteObject*/ )));
 BA.debugLineNum = 147;BA.debugLine="Sys = ImportModule(\"sys\")";
Debug.JustUpdateDeviceLine();
__ref.setField ("_sys" /*RemoteObject*/ ,__ref.runClassMethod (b4j.example.pybridge.class, "_importmodule" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("sys"))));
 BA.debugLineNum = 148;BA.debugLine="Itertools = ImportModule(\"itertools\")";
Debug.JustUpdateDeviceLine();
__ref.setField ("_itertools" /*RemoteObject*/ ,__ref.runClassMethod (b4j.example.pybridge.class, "_importmodule" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("itertools"))));
 BA.debugLineNum = 149;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asfloat(RemoteObject __ref,RemoteObject _o) throws Exception{
try {
		Debug.PushSubsStack("AsFloat (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,307);
if (RapidSub.canDelegate("asfloat")) { return __ref.runUserSub(false, "pybridge","asfloat", __ref, _o);}
Debug.locals.put("o", _o);
 BA.debugLineNum = 307;BA.debugLine="Public Sub AsFloat (o As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 308;BA.debugLine="Return Builtins.Run(\"float\").Arg(o)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("float"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_o));
 BA.debugLineNum = 309;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asint(RemoteObject __ref,RemoteObject _o) throws Exception{
try {
		Debug.PushSubsStack("AsInt (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,297);
if (RapidSub.canDelegate("asint")) { return __ref.runUserSub(false, "pybridge","asint", __ref, _o);}
Debug.locals.put("o", _o);
 BA.debugLineNum = 297;BA.debugLine="Public Sub AsInt (o As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 298;BA.debugLine="Return Builtins.Run(\"int\").Arg(o)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("int"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_o));
 BA.debugLineNum = 299;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asstr(RemoteObject __ref,RemoteObject _o) throws Exception{
try {
		Debug.PushSubsStack("AsStr (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,302);
if (RapidSub.canDelegate("asstr")) { return __ref.runUserSub(false, "pybridge","asstr", __ref, _o);}
Debug.locals.put("o", _o);
 BA.debugLineNum = 302;BA.debugLine="Public Sub AsStr (o As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 303;BA.debugLine="Return Builtins.Run(\"str\").Arg(o)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("str"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_o));
 BA.debugLineNum = 304;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 4;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 5;BA.debugLine="Type PyObject (Key As Int)";
;
 //BA.debugLineNum = 6;BA.debugLine="Type PyTask (TaskId As Int, TaskType As Int, Extr";
;
 //BA.debugLineNum = 7;BA.debugLine="Type InternalPyTaskAsyncResult (PyObject As PyObj";
;
 //BA.debugLineNum = 8;BA.debugLine="Type PyOptions (PythonExecutable As String, Local";
;
 //BA.debugLineNum = 12;BA.debugLine="Type InternalPyMethodArgs (Args As List, KWArgs A";
;
 //BA.debugLineNum = 13;BA.debugLine="Private comm As PyComm";
pybridge._comm = RemoteObject.createNew ("b4j.example.pycomm");__ref.setField("_comm",pybridge._comm);
 //BA.debugLineNum = 14;BA.debugLine="Private mCallback As Object";
pybridge._mcallback = RemoteObject.createNew ("Object");__ref.setField("_mcallback",pybridge._mcallback);
 //BA.debugLineNum = 15;BA.debugLine="Private mEventName As String";
pybridge._meventname = RemoteObject.createImmutable("");__ref.setField("_meventname",pybridge._meventname);
 //BA.debugLineNum = 16;BA.debugLine="Public Utils As PyUtils";
pybridge._utils = RemoteObject.createNew ("b4j.example.pyutils");__ref.setField("_utils",pybridge._utils);
 //BA.debugLineNum = 17;BA.debugLine="Public Builtins As PyWrapper";
pybridge._builtins = RemoteObject.createNew ("b4j.example.pywrapper");__ref.setField("_builtins",pybridge._builtins);
 //BA.debugLineNum = 18;BA.debugLine="Public Bridge As PyWrapper";
pybridge._bridge = RemoteObject.createNew ("b4j.example.pywrapper");__ref.setField("_bridge",pybridge._bridge);
 //BA.debugLineNum = 19;BA.debugLine="Public Itertools As PyWrapper";
pybridge._itertools = RemoteObject.createNew ("b4j.example.pywrapper");__ref.setField("_itertools",pybridge._itertools);
 //BA.debugLineNum = 20;BA.debugLine="Public Sys As PyWrapper";
pybridge._sys = RemoteObject.createNew ("b4j.example.pywrapper");__ref.setField("_sys",pybridge._sys);
 //BA.debugLineNum = 21;BA.debugLine="Private Shl As Shell";
pybridge._shl = RemoteObject.createNew ("anywheresoftware.b4j.objects.Shell");__ref.setField("_shl",pybridge._shl);
 //BA.debugLineNum = 22;BA.debugLine="Private mOptions As PyOptions";
pybridge._moptions = RemoteObject.createNew ("b4j.example.pybridge._pyoptions");__ref.setField("_moptions",pybridge._moptions);
 //BA.debugLineNum = 23;BA.debugLine="Private ShlReadLoopIndex As Int";
pybridge._shlreadloopindex = RemoteObject.createImmutable(0);__ref.setField("_shlreadloopindex",pybridge._shlreadloopindex);
 //BA.debugLineNum = 24;BA.debugLine="Public ErrorHandler As PyErrorHandler";
pybridge._errorhandler = RemoteObject.createNew ("b4j.example.pyerrorhandler");__ref.setField("_errorhandler",pybridge._errorhandler);
 //BA.debugLineNum = 25;BA.debugLine="Public PyLastException As String";
pybridge._pylastexception = RemoteObject.createImmutable("");__ref.setField("_pylastexception",pybridge._pylastexception);
 //BA.debugLineNum = 26;BA.debugLine="Private EventMapper As Map";
pybridge._eventmapper = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");__ref.setField("_eventmapper",pybridge._eventmapper);
 //BA.debugLineNum = 27;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _convertunserializable(RemoteObject __ref,RemoteObject _list) throws Exception{
try {
		Debug.PushSubsStack("ConvertUnserializable (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,366);
if (RapidSub.canDelegate("convertunserializable")) { return __ref.runUserSub(false, "pybridge","convertunserializable", __ref, _list);}
RemoteObject _code = RemoteObject.createImmutable("");
Debug.locals.put("List", _list);
 BA.debugLineNum = 366;BA.debugLine="Private Sub ConvertUnserializable (List As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 367;BA.debugLine="Dim Code As String = $\" def ConvertUnserializable";
Debug.JustUpdateDeviceLine();
_code = (RemoteObject.concat(RemoteObject.createImmutable("\n"),RemoteObject.createImmutable("def ConvertUnserializable (bridge, list1):\n"),RemoteObject.createImmutable("	l = map(lambda x: bridge.comm.serializator.is_serializable(x), list1)\n"),RemoteObject.createImmutable("	return [x if y is None else str(y)[:100] for x, y in zip(list1, l)]\n"),RemoteObject.createImmutable("")));Debug.locals.put("Code", _code);Debug.locals.put("Code", _code);
 BA.debugLineNum = 372;BA.debugLine="Return RunCode(\"ConvertUnserializable\", Array(Bri";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pybridge.class, "_runcode" /*RemoteObject*/ ,(Object)(BA.ObjectToString("ConvertUnserializable")),(Object)(pybridge.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {2},new Object[] {(__ref.getField(false,"_bridge" /*RemoteObject*/ )),_list})))),(Object)(_code));
 BA.debugLineNum = 373;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createoptions(RemoteObject __ref,RemoteObject _pythonexecutable) throws Exception{
try {
		Debug.PushSubsStack("CreateOptions (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,106);
if (RapidSub.canDelegate("createoptions")) { return __ref.runUserSub(false, "pybridge","createoptions", __ref, _pythonexecutable);}
RemoteObject _opt = RemoteObject.declareNull("b4j.example.pybridge._pyoptions");
RemoteObject _jo = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _allenvvars = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _key = RemoteObject.createImmutable("");
Debug.locals.put("PythonExecutable", _pythonexecutable);
 BA.debugLineNum = 106;BA.debugLine="Public Sub CreateOptions (PythonExecutable As Stri";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 107;BA.debugLine="Dim opt As PyOptions";
Debug.JustUpdateDeviceLine();
_opt = RemoteObject.createNew ("b4j.example.pybridge._pyoptions");Debug.locals.put("opt", _opt);
 BA.debugLineNum = 108;BA.debugLine="opt.Initialize";
Debug.JustUpdateDeviceLine();
_opt.runVoidMethod ("Initialize");
 BA.debugLineNum = 109;BA.debugLine="opt.PythonExecutable = PythonExecutable";
Debug.JustUpdateDeviceLine();
_opt.setField ("PythonExecutable" /*RemoteObject*/ ,_pythonexecutable);
 BA.debugLineNum = 110;BA.debugLine="opt.PyBridgePath = File.Combine(File.DirData(\"pyb";
Debug.JustUpdateDeviceLine();
_opt.setField ("PyBridgePath" /*RemoteObject*/ ,pybridge.__c.getField(false,"File").runMethod(true,"Combine",(Object)(pybridge.__c.getField(false,"File").runMethod(true,"DirData",(Object)(RemoteObject.createImmutable("pybridge")))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("b4x_bridge_"),pybridge.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((__ref.getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_pythonbridgecodeversion" /*RemoteObject*/ )))),RemoteObject.createImmutable(".zip"))))));
 BA.debugLineNum = 111;BA.debugLine="opt.B4JColor = 0xFF727272";
Debug.JustUpdateDeviceLine();
_opt.setField ("B4JColor" /*RemoteObject*/ ,BA.numberCast(int.class, ((int)0xff727272)));
 BA.debugLineNum = 112;BA.debugLine="opt.PyErrColor = 0xFFF74479";
Debug.JustUpdateDeviceLine();
_opt.setField ("PyErrColor" /*RemoteObject*/ ,BA.numberCast(int.class, ((int)0xfff74479)));
 BA.debugLineNum = 113;BA.debugLine="opt.PyOutColor = 0xFF446EF7";
Debug.JustUpdateDeviceLine();
_opt.setField ("PyOutColor" /*RemoteObject*/ ,BA.numberCast(int.class, ((int)0xff446ef7)));
 BA.debugLineNum = 114;BA.debugLine="opt.WatchDogSeconds = 30";
Debug.JustUpdateDeviceLine();
_opt.setField ("WatchDogSeconds" /*RemoteObject*/ ,BA.numberCast(int.class, 30));
 BA.debugLineNum = 115;BA.debugLine="opt.PyCacheFolder = File.DirData(\"pybridge\")";
Debug.JustUpdateDeviceLine();
_opt.setField ("PyCacheFolder" /*RemoteObject*/ ,pybridge.__c.getField(false,"File").runMethod(true,"DirData",(Object)(RemoteObject.createImmutable("pybridge"))));
 BA.debugLineNum = 116;BA.debugLine="opt.EnvironmentVars =  CreateMap(\"PYTHONUTF8\": 1)";
Debug.JustUpdateDeviceLine();
_opt.setField ("EnvironmentVars" /*RemoteObject*/ ,pybridge.__c.runMethod(false, "createMap", (Object)(new RemoteObject[] {RemoteObject.createImmutable(("PYTHONUTF8")),RemoteObject.createImmutable((1))})));
 BA.debugLineNum = 117;BA.debugLine="Dim jo As JavaObject";
Debug.JustUpdateDeviceLine();
_jo = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");Debug.locals.put("jo", _jo);
 BA.debugLineNum = 118;BA.debugLine="jo.InitializeStatic(\"java.lang.System\")";
Debug.JustUpdateDeviceLine();
_jo.runVoidMethod ("InitializeStatic",(Object)(RemoteObject.createImmutable("java.lang.System")));
 BA.debugLineNum = 119;BA.debugLine="Dim AllEnvVars As Map = jo.RunMethod(\"getenv\", Nu";
Debug.JustUpdateDeviceLine();
_allenvvars = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
_allenvvars = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _jo.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getenv")),(Object)((pybridge.__c.getField(false,"Null")))));Debug.locals.put("AllEnvVars", _allenvvars);Debug.locals.put("AllEnvVars", _allenvvars);
 BA.debugLineNum = 120;BA.debugLine="For Each key As String In AllEnvVars.Keys";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group14 = _allenvvars.runMethod(false,"Keys");
final int groupLen14 = group14.runMethod(true,"getSize").<Integer>get()
;int index14 = 0;
;
for (; index14 < groupLen14;index14++){
_key = BA.ObjectToString(group14.runMethod(false,"Get",index14));Debug.locals.put("key", _key);
Debug.locals.put("key", _key);
 BA.debugLineNum = 121;BA.debugLine="opt.EnvironmentVars.Put(key, AllEnvVars.Get(key)";
Debug.JustUpdateDeviceLine();
_opt.getField(false,"EnvironmentVars" /*RemoteObject*/ ).runVoidMethod ("Put",(Object)((_key)),(Object)(_allenvvars.runMethod(false,"Get",(Object)((_key)))));
 }
}Debug.locals.put("key", _key);
;
 BA.debugLineNum = 123;BA.debugLine="opt.PythonPath = \"\"";
Debug.JustUpdateDeviceLine();
_opt.setField ("PythonPath" /*RemoteObject*/ ,BA.ObjectToString(""));
 BA.debugLineNum = 124;BA.debugLine="opt.TrackLineNumbers = True";
Debug.JustUpdateDeviceLine();
_opt.setField ("TrackLineNumbers" /*RemoteObject*/ ,pybridge.__c.getField(true,"True"));
 BA.debugLineNum = 125;BA.debugLine="If Utils.DetectOS = \"windows\" Then opt.Environmen";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_detectos" /*RemoteObject*/ ),BA.ObjectToString("windows"))) { 
_opt.getField(false,"EnvironmentVars" /*RemoteObject*/ ).runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("MPLCONFIGDIR"))),(Object)((pybridge.__c.runMethod(true,"GetEnvironmentVariable",(Object)(BA.ObjectToString("USERPROFILE")),(Object)(RemoteObject.createImmutable(""))))));};
 BA.debugLineNum = 126;BA.debugLine="Return opt";
Debug.JustUpdateDeviceLine();
if (true) return _opt;
 BA.debugLineNum = 127;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fetchobjects(RemoteObject __ref,RemoteObject _objects) throws Exception{
try {
		Debug.PushSubsStack("FetchObjects (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,355);
if (RapidSub.canDelegate("fetchobjects")) { return __ref.runUserSub(false, "pybridge","fetchobjects", __ref, _objects);}
ResumableSub_FetchObjects rsub = new ResumableSub_FetchObjects(null,__ref,_objects);
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
public static class ResumableSub_FetchObjects extends BA.ResumableSub {
public ResumableSub_FetchObjects(b4j.example.pybridge parent,RemoteObject __ref,RemoteObject _objects) {
this.parent = parent;
this.__ref = __ref;
this._objects = _objects;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.pybridge parent;
RemoteObject _objects;
RemoteObject _list = RemoteObject.declareNull("b4j.example.pywrapper");
RemoteObject _result = RemoteObject.declareNull("b4j.example.pywrapper");

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("FetchObjects (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,355);
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
Debug.locals.put("Objects", _objects);
 BA.debugLineNum = 356;BA.debugLine="Dim List As PyWrapper = IIf(Objects Is PyWrapper,";
Debug.JustUpdateDeviceLine();
_list = (((RemoteObject.solveBoolean("i",_objects, RemoteObject.createImmutable("b4j.example.pywrapper"))) ? (_objects) : ((__ref.runClassMethod (b4j.example.pybridge.class, "_wrapobject" /*RemoteObject*/ ,(Object)(_objects))))));Debug.locals.put("List", _list);Debug.locals.put("List", _list);
 BA.debugLineNum = 357;BA.debugLine="Wait For (ConvertUnserializable(List).Fetch) Comp";
Debug.JustUpdateDeviceLine();
parent.__c.runVoidMethod ("WaitFor","complete", __ref.getField(false, "ba"), anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pybridge", "fetchobjects"), __ref.runClassMethod (b4j.example.pybridge.class, "_convertunserializable" /*RemoteObject*/ ,(Object)((_list))).runClassMethod (b4j.example.pywrapper.class, "_fetch" /*RemoteObject*/ ));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_result = (RemoteObject) result.getArrayElement(false,RemoteObject.createImmutable(1));Debug.locals.put("Result", _result);
;
 BA.debugLineNum = 358;BA.debugLine="Return Result.Value.As(List)";
Debug.JustUpdateDeviceLine();
if (true) {
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,((RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), _result.runClassMethod (b4j.example.pywrapper.class, "_getvalue" /*RemoteObject*/ )))));return;};
 BA.debugLineNum = 359;BA.debugLine="End Sub";
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
public static void  _complete(RemoteObject __ref,RemoteObject _result) throws Exception{
}
public static RemoteObject  _filter(RemoteObject __ref,RemoteObject _predicate,RemoteObject _iterable) throws Exception{
try {
		Debug.PushSubsStack("Filter (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,327);
if (RapidSub.canDelegate("filter")) { return __ref.runUserSub(false, "pybridge","filter", __ref, _predicate, _iterable);}
Debug.locals.put("Predicate", _predicate);
Debug.locals.put("Iterable", _iterable);
 BA.debugLineNum = 327;BA.debugLine="Public Sub Filter (Predicate As Object, Iterable A";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 328;BA.debugLine="Return Builtins.Run(\"filter\").Arg(Utils.ConvertLa";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("filter"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_convertlambdaifmatch" /*RemoteObject*/ ,(Object)(_predicate))))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_iterable));
 BA.debugLineNum = 329;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _flush(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Flush (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,154);
if (RapidSub.canDelegate("flush")) { return __ref.runUserSub(false, "pybridge","flush", __ref);}
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
public ResumableSub_Flush(b4j.example.pybridge parent,RemoteObject __ref) {
this.parent = parent;
this.__ref = __ref;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.pybridge parent;
RemoteObject _success = RemoteObject.createImmutable(false);

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("Flush (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,154);
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
 BA.debugLineNum = 155;BA.debugLine="Wait For (Utils.Flush) Complete (Success As Boole";
Debug.JustUpdateDeviceLine();
parent.__c.runVoidMethod ("WaitFor","complete", __ref.getField(false, "ba"), anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pybridge", "flush"), __ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_flush" /*RemoteObject*/ ));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_success = (RemoteObject) result.getArrayElement(true,RemoteObject.createImmutable(1));Debug.locals.put("Success", _success);
;
 BA.debugLineNum = 156;BA.debugLine="Return Success";
Debug.JustUpdateDeviceLine();
if (true) {
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,(_success));return;};
 BA.debugLineNum = 157;BA.debugLine="End Sub";
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
public static RemoteObject  _getmember(RemoteObject __ref,RemoteObject _member) throws Exception{
try {
		Debug.PushSubsStack("GetMember (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,268);
if (RapidSub.canDelegate("getmember")) { return __ref.runUserSub(false, "pybridge","getmember", __ref, _member);}
Debug.locals.put("Member", _member);
 BA.debugLineNum = 268;BA.debugLine="Public Sub GetMember(Member As String) As PyWrappe";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 269;BA.debugLine="Return Utils.EvalGlobals.Get(Member)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_utils" /*RemoteObject*/ ).getField(false,"_evalglobals" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_get" /*RemoteObject*/ ,(Object)((_member)));
 BA.debugLineNum = 270;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _handleoutanderr(RemoteObject __ref,RemoteObject _out,RemoteObject _err) throws Exception{
try {
		Debug.PushSubsStack("HandleOutAndErr (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,84);
if (RapidSub.canDelegate("handleoutanderr")) { return __ref.runUserSub(false, "pybridge","handleoutanderr", __ref, _out, _err);}
Debug.locals.put("out", _out);
Debug.locals.put("Err", _err);
 BA.debugLineNum = 84;BA.debugLine="Private Sub HandleOutAndErr (out As String, Err As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 85;BA.debugLine="If out.Length > 0 Then Utils.PyLog(Utils.PyOutPre";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",_out.runMethod(true,"length"),BA.numberCast(double.class, 0))) { 
__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_pylog" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_pyoutprefix" /*RemoteObject*/ )),(Object)(__ref.getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"PyOutColor" /*RemoteObject*/ )),(Object)((_out)));};
 BA.debugLineNum = 86;BA.debugLine="If Err.Length > 0 Then Utils.PyLog(Utils.PyErrPre";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",_err.runMethod(true,"length"),BA.numberCast(double.class, 0))) { 
__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_pylog" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_pyerrprefix" /*RemoteObject*/ )),(Object)(__ref.getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"PyErrColor" /*RemoteObject*/ )),(Object)((_err)));};
 BA.debugLineNum = 87;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _importmodule(RemoteObject __ref,RemoteObject _module) throws Exception{
try {
		Debug.PushSubsStack("ImportModule (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,273);
if (RapidSub.canDelegate("importmodule")) { return __ref.runUserSub(false, "pybridge","importmodule", __ref, _module);}
RemoteObject _res = RemoteObject.declareNull("b4j.example.pywrapper");
Debug.locals.put("Module", _module);
 BA.debugLineNum = 273;BA.debugLine="Public Sub ImportModule (Module As String) As PyWr";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 274;BA.debugLine="RunNoArgsCode(\"import \" & Module)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pybridge.class, "_runnoargscode" /*RemoteObject*/ ,(Object)(RemoteObject.concat(RemoteObject.createImmutable("import "),_module)));
 BA.debugLineNum = 275;BA.debugLine="Dim res As PyWrapper = Utils.ImportLib.Run(\"impor";
Debug.JustUpdateDeviceLine();
_res = __ref.getField(false,"_utils" /*RemoteObject*/ ).getField(false,"_importlib" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("import_module"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)((_module)));Debug.locals.put("res", _res);Debug.locals.put("res", _res);
 BA.debugLineNum = 276;BA.debugLine="Return res";
Debug.JustUpdateDeviceLine();
if (true) return _res;
 BA.debugLineNum = 277;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _importmodulefrom(RemoteObject __ref,RemoteObject _frommodule,RemoteObject _importmember) throws Exception{
try {
		Debug.PushSubsStack("ImportModuleFrom (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,280);
if (RapidSub.canDelegate("importmodulefrom")) { return __ref.runUserSub(false, "pybridge","importmodulefrom", __ref, _frommodule, _importmember);}
RemoteObject _res = RemoteObject.declareNull("b4j.example.pywrapper");
Debug.locals.put("FromModule", _frommodule);
Debug.locals.put("ImportMember", _importmember);
 BA.debugLineNum = 280;BA.debugLine="Public Sub ImportModuleFrom(FromModule As String,";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 281;BA.debugLine="RunNoArgsCode(\"from \" & FromModule & \" import \" &";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pybridge.class, "_runnoargscode" /*RemoteObject*/ ,(Object)(RemoteObject.concat(RemoteObject.createImmutable("from "),_frommodule,RemoteObject.createImmutable(" import "),_importmember)));
 BA.debugLineNum = 282;BA.debugLine="Dim res As PyWrapper = ImportModule(FromModule).G";
Debug.JustUpdateDeviceLine();
_res = __ref.runClassMethod (b4j.example.pybridge.class, "_importmodule" /*RemoteObject*/ ,(Object)(_frommodule)).runClassMethod (b4j.example.pywrapper.class, "_getfield" /*RemoteObject*/ ,(Object)(_importmember));Debug.locals.put("res", _res);Debug.locals.put("res", _res);
 BA.debugLineNum = 283;BA.debugLine="Return res";
Debug.JustUpdateDeviceLine();
if (true) return _res;
 BA.debugLineNum = 284;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _callback,RemoteObject _eventname) throws Exception{
try {
		Debug.PushSubsStack("Initialize (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,30);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "pybridge","initialize", __ref, _ba, _callback, _eventname);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
Debug.locals.put("Callback", _callback);
Debug.locals.put("EventName", _eventname);
 BA.debugLineNum = 30;BA.debugLine="Public Sub Initialize (Callback As Object, EventNa";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 31;BA.debugLine="mCallback = Callback";
Debug.JustUpdateDeviceLine();
__ref.setField ("_mcallback" /*RemoteObject*/ ,_callback);
 BA.debugLineNum = 32;BA.debugLine="mEventName = EventName";
Debug.JustUpdateDeviceLine();
__ref.setField ("_meventname" /*RemoteObject*/ ,_eventname);
 BA.debugLineNum = 33;BA.debugLine="mOptions.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_moptions" /*RemoteObject*/ ).runVoidMethod ("Initialize");
 BA.debugLineNum = 34;BA.debugLine="ErrorHandler.Initialize(Utils)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_errorhandler" /*RemoteObject*/ ).runClassMethod (b4j.example.pyerrorhandler.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_utils" /*RemoteObject*/ )));
 BA.debugLineNum = 35;BA.debugLine="Utils.Initialize(Me, comm)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"),(Object)((__ref)),(Object)(__ref.getField(false,"_comm" /*RemoteObject*/ )));
 BA.debugLineNum = 36;BA.debugLine="EventMapper.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_eventmapper" /*RemoteObject*/ ).runVoidMethod ("Initialize");
 BA.debugLineNum = 37;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _killprocess(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("KillProcess (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,184);
if (RapidSub.canDelegate("killprocess")) { return __ref.runUserSub(false, "pybridge","killprocess", __ref);}
 BA.debugLineNum = 184;BA.debugLine="Public Sub KillProcess";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 185;BA.debugLine="Try";
Debug.JustUpdateDeviceLine();
try { BA.debugLineNum = 186;BA.debugLine="ShlReadLoopIndex = ShlReadLoopIndex + 1";
Debug.JustUpdateDeviceLine();
__ref.setField ("_shlreadloopindex" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_shlreadloopindex" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "+",1, 1));
 BA.debugLineNum = 187;BA.debugLine="If Initialized(comm) Then";
Debug.JustUpdateDeviceLine();
if (pybridge.__c.runMethod(true,"Initialized",(Object)((__ref.getField(false,"_comm" /*RemoteObject*/ )))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 188;BA.debugLine="comm.CloseServer";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_comm" /*RemoteObject*/ ).runClassMethod (b4j.example.pycomm.class, "_closeserver" /*RemoteObject*/ );
 };
 BA.debugLineNum = 190;BA.debugLine="If mOptions.PythonExecutable <> \"\" And Initializ";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("!",__ref.getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"PythonExecutable" /*RemoteObject*/ ),BA.ObjectToString("")) && RemoteObject.solveBoolean(".",pybridge.__c.runMethod(true,"Initialized",(Object)((__ref.getField(false,"_shl" /*RemoteObject*/ )))))) { 
 BA.debugLineNum = 191;BA.debugLine="Shl.KillProcess";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_shl" /*RemoteObject*/ ).runVoidMethod ("KillProcess");
 };
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e10) {
			BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e10.toString()); BA.debugLineNum = 194;BA.debugLine="Log(LastException)";
Debug.JustUpdateDeviceLine();
pybridge.__c.runVoidMethod ("LogImpl","91441802",BA.ObjectToString(pybridge.__c.runMethod(false,"LastException",__ref.getField(false, "ba"))),0);
 };
 BA.debugLineNum = 196;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _lambda(RemoteObject __ref,RemoteObject _code) throws Exception{
try {
		Debug.PushSubsStack("Lambda (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,337);
if (RapidSub.canDelegate("lambda")) { return __ref.runUserSub(false, "pybridge","lambda", __ref, _code);}
Debug.locals.put("Code", _code);
 BA.debugLineNum = 337;BA.debugLine="Public Sub Lambda(Code As String) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 338;BA.debugLine="Return RunStatement(\"lambda \" & Code)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pybridge.class, "_runstatement" /*RemoteObject*/ ,(Object)(RemoteObject.concat(RemoteObject.createImmutable("lambda "),_code)));
 BA.debugLineNum = 339;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _map_(RemoteObject __ref,RemoteObject _function,RemoteObject _iterable) throws Exception{
try {
		Debug.PushSubsStack("Map_ (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,317);
if (RapidSub.canDelegate("map_")) { return __ref.runUserSub(false, "pybridge","map_", __ref, _function, _iterable);}
Debug.locals.put("Function", _function);
Debug.locals.put("Iterable", _iterable);
 BA.debugLineNum = 317;BA.debugLine="Public Sub Map_(Function As Object, Iterable As Ob";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 318;BA.debugLine="Return Builtins.Run(\"map\").Arg(Utils.ConvertLambd";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("map"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_convertlambdaifmatch" /*RemoteObject*/ ,(Object)(_function))))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_iterable));
 BA.debugLineNum = 319;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _open(RemoteObject __ref,RemoteObject _filepath,RemoteObject _mode) throws Exception{
try {
		Debug.PushSubsStack("Open (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,397);
if (RapidSub.canDelegate("open")) { return __ref.runUserSub(false, "pybridge","open", __ref, _filepath, _mode);}
Debug.locals.put("FilePath", _filepath);
Debug.locals.put("Mode", _mode);
 BA.debugLineNum = 397;BA.debugLine="Public Sub Open (FilePath As Object, Mode As Objec";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 398;BA.debugLine="Return Builtins.Run(\"open\").Arg(FilePath).Arg(Mod";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("open"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_filepath)).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_mode));
 BA.debugLineNum = 399;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _print(RemoteObject __ref,RemoteObject _obj) throws Exception{
try {
		Debug.PushSubsStack("Print (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,199);
if (RapidSub.canDelegate("print")) { return __ref.runUserSub(false, "pybridge","print", __ref, _obj);}
Debug.locals.put("Obj", _obj);
 BA.debugLineNum = 199;BA.debugLine="Public Sub Print(Obj As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 200;BA.debugLine="PrintJoin(Array(Obj), False)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pybridge.class, "_printjoin" /*RemoteObject*/ ,(Object)(pybridge.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {_obj})))),(Object)(pybridge.__c.getField(true,"False")));
 BA.debugLineNum = 201;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _printjoin(RemoteObject __ref,RemoteObject _objects,RemoteObject _stderr) throws Exception{
try {
		Debug.PushSubsStack("PrintJoin (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,204);
if (RapidSub.canDelegate("printjoin")) { return __ref.runUserSub(false, "pybridge","printjoin", __ref, _objects, _stderr);}
RemoteObject _code = RemoteObject.createImmutable("");
Debug.locals.put("Objects", _objects);
Debug.locals.put("StdErr", _stderr);
 BA.debugLineNum = 204;BA.debugLine="Public Sub PrintJoin (Objects As List, StdErr As B";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 205;BA.debugLine="Dim Code As String = $\" def _print(obj, StdErr):";
Debug.JustUpdateDeviceLine();
_code = (RemoteObject.concat(RemoteObject.createImmutable("\n"),RemoteObject.createImmutable("def _print(obj, StdErr):\n"),RemoteObject.createImmutable("	print(*obj, file=sys.stderr if StdErr else sys.stdout)\n"),RemoteObject.createImmutable("")));Debug.locals.put("Code", _code);Debug.locals.put("Code", _code);
 BA.debugLineNum = 209;BA.debugLine="RunCode(\"_print\", Array(Objects, StdErr), Code)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pybridge.class, "_runcode" /*RemoteObject*/ ,(Object)(BA.ObjectToString("_print")),(Object)(pybridge.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {2},new Object[] {(_objects.getObject()),(_stderr)})))),(Object)(_code));
 BA.debugLineNum = 210;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _pyiif(RemoteObject __ref,RemoteObject _condition,RemoteObject _truevalue,RemoteObject _falsevalue) throws Exception{
try {
		Debug.PushSubsStack("PyIIf (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,376);
if (RapidSub.canDelegate("pyiif")) { return __ref.runUserSub(false, "pybridge","pyiif", __ref, _condition, _truevalue, _falsevalue);}
Debug.locals.put("Condition", _condition);
Debug.locals.put("TrueValue", _truevalue);
Debug.locals.put("FalseValue", _falsevalue);
 BA.debugLineNum = 376;BA.debugLine="Public Sub PyIIf (Condition As Object, TrueValue A";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 377;BA.debugLine="Return RunCode(\"PyIIF\", Array(Condition, TrueValu";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pybridge.class, "_runcode" /*RemoteObject*/ ,(Object)(BA.ObjectToString("PyIIF")),(Object)(pybridge.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {3},new Object[] {_condition,_truevalue,_falsevalue})))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("\n"),RemoteObject.createImmutable("def PyIIF(condition, TrueValue, FalseValue):\n"),RemoteObject.createImmutable("	res = TrueValue if condition else FalseValue\n"),RemoteObject.createImmutable("	if callable(res):\n"),RemoteObject.createImmutable("		return res()\n"),RemoteObject.createImmutable("	else:\n"),RemoteObject.createImmutable("		return res\n"),RemoteObject.createImmutable("")))));
 BA.debugLineNum = 385;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _pynext(RemoteObject __ref,RemoteObject _iter) throws Exception{
try {
		Debug.PushSubsStack("PyNext (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,349);
if (RapidSub.canDelegate("pynext")) { return __ref.runUserSub(false, "pybridge","pynext", __ref, _iter);}
Debug.locals.put("Iter", _iter);
 BA.debugLineNum = 349;BA.debugLine="Public Sub PyNext(Iter As PyWrapper) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 350;BA.debugLine="Return Builtins.Run(\"next\").Arg(Iter)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("next"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)((_iter)));
 BA.debugLineNum = 351;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _range(RemoteObject __ref,RemoteObject _firstparam) throws Exception{
try {
		Debug.PushSubsStack("Range (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,362);
if (RapidSub.canDelegate("range")) { return __ref.runUserSub(false, "pybridge","range", __ref, _firstparam);}
Debug.locals.put("FirstParam", _firstparam);
 BA.debugLineNum = 362;BA.debugLine="Public Sub Range (FirstParam As Object) As PyWrapp";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 363;BA.debugLine="Return Builtins.Run(\"range\").Arg(FirstParam)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("range"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_firstparam));
 BA.debugLineNum = 364;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _registermember(RemoteObject __ref,RemoteObject _keyname,RemoteObject _classcode,RemoteObject _overwrite) throws Exception{
try {
		Debug.PushSubsStack("RegisterMember (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,213);
if (RapidSub.canDelegate("registermember")) { return __ref.runUserSub(false, "pybridge","registermember", __ref, _keyname, _classcode, _overwrite);}
Debug.locals.put("KeyName", _keyname);
Debug.locals.put("ClassCode", _classcode);
Debug.locals.put("Overwrite", _overwrite);
 BA.debugLineNum = 213;BA.debugLine="Private Sub RegisterMember (KeyName As String, Cla";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 214;BA.debugLine="If Utils.RegisteredMembers.Contains(KeyName) = Fa";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_utils" /*RemoteObject*/ ).getField(false,"_registeredmembers" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_contains" /*RemoteObject*/ ,(Object)((_keyname))),pybridge.__c.getField(true,"False")) || RemoteObject.solveBoolean(".",_overwrite)) { 
 BA.debugLineNum = 215;BA.debugLine="RunNoArgsCode(ClassCode)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pybridge.class, "_runnoargscode" /*RemoteObject*/ ,(Object)(_classcode));
 BA.debugLineNum = 216;BA.debugLine="Utils.RegisteredMembers.Add(KeyName)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_utils" /*RemoteObject*/ ).getField(false,"_registeredmembers" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_add" /*RemoteObject*/ ,(Object)((_keyname)));
 };
 BA.debugLineNum = 218;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _runcode(RemoteObject __ref,RemoteObject _membername,RemoteObject _args,RemoteObject _functioncode) throws Exception{
try {
		Debug.PushSubsStack("RunCode (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,222);
if (RapidSub.canDelegate("runcode")) { return __ref.runUserSub(false, "pybridge","runcode", __ref, _membername, _args, _functioncode);}
Debug.locals.put("MemberName", _membername);
Debug.locals.put("Args", _args);
Debug.locals.put("FunctionCode", _functioncode);
 BA.debugLineNum = 222;BA.debugLine="Public Sub RunCode (MemberName As String, Args As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 223;BA.debugLine="RegisterMember(MemberName, FunctionCode, False)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pybridge.class, "_registermember" /*RemoteObject*/ ,(Object)(_membername),(Object)(_functioncode),(Object)(pybridge.__c.getField(true,"False")));
 BA.debugLineNum = 224;BA.debugLine="Return GetMember(MemberName).Call.Args(Args)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pybridge.class, "_getmember" /*RemoteObject*/ ,(Object)(_membername)).runClassMethod (b4j.example.pywrapper.class, "_call" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_args" /*RemoteObject*/ ,(Object)(_args));
 BA.debugLineNum = 225;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _runcodeawait(RemoteObject __ref,RemoteObject _membername,RemoteObject _args,RemoteObject _functioncode) throws Exception{
try {
		Debug.PushSubsStack("RunCodeAwait (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,243);
if (RapidSub.canDelegate("runcodeawait")) { return __ref.runUserSub(false, "pybridge","runcodeawait", __ref, _membername, _args, _functioncode);}
ResumableSub_RunCodeAwait rsub = new ResumableSub_RunCodeAwait(null,__ref,_membername,_args,_functioncode);
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
public static class ResumableSub_RunCodeAwait extends BA.ResumableSub {
public ResumableSub_RunCodeAwait(b4j.example.pybridge parent,RemoteObject __ref,RemoteObject _membername,RemoteObject _args,RemoteObject _functioncode) {
this.parent = parent;
this.__ref = __ref;
this._membername = _membername;
this._args = _args;
this._functioncode = _functioncode;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.pybridge parent;
RemoteObject _membername;
RemoteObject _args;
RemoteObject _functioncode;
RemoteObject _result = RemoteObject.declareNull("b4j.example.pywrapper");

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("RunCodeAwait (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,243);
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
Debug.locals.put("MemberName", _membername);
Debug.locals.put("Args", _args);
Debug.locals.put("FunctionCode", _functioncode);
 BA.debugLineNum = 244;BA.debugLine="RegisterMember(MemberName, FunctionCode, False)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pybridge.class, "_registermember" /*RemoteObject*/ ,(Object)(_membername),(Object)(_functioncode),(Object)(parent.__c.getField(true,"False")));
 BA.debugLineNum = 245;BA.debugLine="Wait For (GetMember(MemberName).RunAwait(\"__call_";
Debug.JustUpdateDeviceLine();
parent.__c.runVoidMethod ("WaitFor","complete", __ref.getField(false, "ba"), anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pybridge", "runcodeawait"), __ref.runClassMethod (b4j.example.pybridge.class, "_getmember" /*RemoteObject*/ ,(Object)(_membername)).runClassMethod (b4j.example.pywrapper.class, "_runawait" /*RemoteObject*/ ,(Object)(BA.ObjectToString("__call__")),(Object)(_args),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), parent.__c.getField(false,"Null"))));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_result = (RemoteObject) result.getArrayElement(false,RemoteObject.createImmutable(1));Debug.locals.put("Result", _result);
;
 BA.debugLineNum = 246;BA.debugLine="Return Result";
Debug.JustUpdateDeviceLine();
if (true) {
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,(_result));return;};
 BA.debugLineNum = 247;BA.debugLine="End Sub";
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
public static RemoteObject  _runnoargscode(RemoteObject __ref,RemoteObject _code) throws Exception{
try {
		Debug.PushSubsStack("RunNoArgsCode (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,250);
if (RapidSub.canDelegate("runnoargscode")) { return __ref.runUserSub(false, "pybridge","runnoargscode", __ref, _code);}
Debug.locals.put("Code", _code);
 BA.debugLineNum = 250;BA.debugLine="Public Sub RunNoArgsCode (Code As String)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 251;BA.debugLine="Builtins.RunArgs(\"exec\", Array(Code, Utils.EvalGl";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_runargs" /*RemoteObject*/ ,(Object)(BA.ObjectToString("exec")),(Object)(pybridge.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {3},new Object[] {(_code),(__ref.getField(false,"_utils" /*RemoteObject*/ ).getField(false,"_evalglobals" /*RemoteObject*/ )),pybridge.__c.getField(false,"Null")})))),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), pybridge.__c.getField(false,"Null")));
 BA.debugLineNum = 252;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _runstatement(RemoteObject __ref,RemoteObject _code) throws Exception{
try {
		Debug.PushSubsStack("RunStatement (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,256);
if (RapidSub.canDelegate("runstatement")) { return __ref.runUserSub(false, "pybridge","runstatement", __ref, _code);}
Debug.locals.put("Code", _code);
 BA.debugLineNum = 256;BA.debugLine="Public Sub RunStatement (Code As String) As PyWrap";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 257;BA.debugLine="Return RunStatement2(Code, Null)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pybridge.class, "_runstatement2" /*RemoteObject*/ ,(Object)(_code),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), pybridge.__c.getField(false,"Null")));
 BA.debugLineNum = 258;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _runstatement2(RemoteObject __ref,RemoteObject _code,RemoteObject _locals) throws Exception{
try {
		Debug.PushSubsStack("RunStatement2 (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,262);
if (RapidSub.canDelegate("runstatement2")) { return __ref.runUserSub(false, "pybridge","runstatement2", __ref, _code, _locals);}
Debug.locals.put("Code", _code);
Debug.locals.put("Locals", _locals);
 BA.debugLineNum = 262;BA.debugLine="Public Sub RunStatement2 (Code As String, Locals A";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 263;BA.debugLine="If NotInitialized(Locals) Then Locals = B4XCollec";
Debug.JustUpdateDeviceLine();
if (pybridge.__c.runMethod(true,"NotInitialized",(Object)((_locals))).<Boolean>get().booleanValue()) { 
_locals = pybridge._b4xcollections.runMethod(false,"_getemptymap" /*RemoteObject*/ );Debug.locals.put("Locals", _locals);};
 BA.debugLineNum = 264;BA.debugLine="Return Builtins.RunArgs (\"eval\", Array(Code, Util";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_runargs" /*RemoteObject*/ ,(Object)(BA.ObjectToString("eval")),(Object)(pybridge.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {3},new Object[] {(_code),(__ref.getField(false,"_utils" /*RemoteObject*/ ).getField(false,"_evalglobals" /*RemoteObject*/ )),(_locals.getObject())})))),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), pybridge.__c.getField(false,"Null")));
 BA.debugLineNum = 265;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _seteventmapping(RemoteObject __ref,RemoteObject _pythoneventname,RemoteObject _callback,RemoteObject _b4xeventname) throws Exception{
try {
		Debug.PushSubsStack("SetEventMapping (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,179);
if (RapidSub.canDelegate("seteventmapping")) { return __ref.runUserSub(false, "pybridge","seteventmapping", __ref, _pythoneventname, _callback, _b4xeventname);}
Debug.locals.put("PythonEventName", _pythoneventname);
Debug.locals.put("Callback", _callback);
Debug.locals.put("B4XEventName", _b4xeventname);
 BA.debugLineNum = 179;BA.debugLine="Public Sub SetEventMapping(PythonEventName As Stri";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 180;BA.debugLine="EventMapper.Put(PythonEventName, Array(Callback,";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_eventmapper" /*RemoteObject*/ ).runVoidMethod ("Put",(Object)((_pythoneventname)),(Object)((RemoteObject.createNewArray("Object",new int[] {2},new Object[] {_callback,(_b4xeventname)}))));
 BA.debugLineNum = 181;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _shl_processcompleted(RemoteObject __ref,RemoteObject _success,RemoteObject _exitcode,RemoteObject _stdout,RemoteObject _stderr) throws Exception{
try {
		Debug.PushSubsStack("shl_ProcessCompleted (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,91);
if (RapidSub.canDelegate("shl_processcompleted")) { return __ref.runUserSub(false, "pybridge","shl_processcompleted", __ref, _success, _exitcode, _stdout, _stderr);}
Debug.locals.put("Success", _success);
Debug.locals.put("ExitCode", _exitcode);
Debug.locals.put("StdOut", _stdout);
Debug.locals.put("StdErr", _stderr);
 BA.debugLineNum = 91;BA.debugLine="Private Sub shl_ProcessCompleted (Success As Boole";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 92;BA.debugLine="HandleOutAndErr(StdOut, StdErr)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pybridge.class, "_handleoutanderr" /*RemoteObject*/ ,(Object)(_stdout),(Object)(_stderr));
 BA.debugLineNum = 93;BA.debugLine="Utils.PyLog(Utils.B4JPrefix, mOptions.B4JColor, $";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_pylog" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_b4jprefix" /*RemoteObject*/ )),(Object)(__ref.getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"B4JColor" /*RemoteObject*/ )),(Object)(((RemoteObject.concat(RemoteObject.createImmutable("Process completed. ExitCode: "),pybridge.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_exitcode))),RemoteObject.createImmutable(""))))));
 BA.debugLineNum = 94;BA.debugLine="Dim Shl As Shell";
Debug.JustUpdateDeviceLine();
pybridge._shl = RemoteObject.createNew ("anywheresoftware.b4j.objects.Shell");__ref.setField("_shl",pybridge._shl);
 BA.debugLineNum = 95;BA.debugLine="comm.CloseServer";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_comm" /*RemoteObject*/ ).runClassMethod (b4j.example.pycomm.class, "_closeserver" /*RemoteObject*/ );
 BA.debugLineNum = 96;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static void  _shlreadloop(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("ShlReadLoop (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,75);
if (RapidSub.canDelegate("shlreadloop")) { __ref.runUserSub(false, "pybridge","shlreadloop", __ref); return;}
ResumableSub_ShlReadLoop rsub = new ResumableSub_ShlReadLoop(null,__ref);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_ShlReadLoop extends BA.ResumableSub {
public ResumableSub_ShlReadLoop(b4j.example.pybridge parent,RemoteObject __ref) {
this.parent = parent;
this.__ref = __ref;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.pybridge parent;
RemoteObject _myindex = RemoteObject.createImmutable(0);

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("ShlReadLoop (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,75);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
Debug.locals.put("_ref", __ref);
 BA.debugLineNum = 76;BA.debugLine="ShlReadLoopIndex = ShlReadLoopIndex + 1";
Debug.JustUpdateDeviceLine();
__ref.setField ("_shlreadloopindex" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_shlreadloopindex" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "+",1, 1));
 BA.debugLineNum = 77;BA.debugLine="Dim MyIndex As Int = ShlReadLoopIndex";
Debug.JustUpdateDeviceLine();
_myindex = __ref.getField(true,"_shlreadloopindex" /*RemoteObject*/ );Debug.locals.put("MyIndex", _myindex);Debug.locals.put("MyIndex", _myindex);
 BA.debugLineNum = 78;BA.debugLine="Do While MyIndex = ShlReadLoopIndex And Initializ";
Debug.JustUpdateDeviceLine();
if (true) break;

case 1:
//do while
this.state = 4;
while (RemoteObject.solveBoolean("=",_myindex,BA.numberCast(double.class, __ref.getField(true,"_shlreadloopindex" /*RemoteObject*/ ))) && RemoteObject.solveBoolean(".",parent.__c.runMethod(true,"Initialized",(Object)((__ref.getField(false,"_shl" /*RemoteObject*/ )))))) {
this.state = 3;
if (true) break;
}
if (true) break;

case 3:
//C
this.state = 1;
 BA.debugLineNum = 79;BA.debugLine="HandleOutAndErr(Shl.GetTempOut2(True), Shl.GetTe";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pybridge.class, "_handleoutanderr" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_shl" /*RemoteObject*/ ).runMethod(true,"GetTempOut2",(Object)(parent.__c.getField(true,"True")))),(Object)(__ref.getField(false,"_shl" /*RemoteObject*/ ).runMethod(true,"GetTempErr2",(Object)(parent.__c.getField(true,"True")))));
 BA.debugLineNum = 80;BA.debugLine="Sleep(50)";
Debug.JustUpdateDeviceLine();
parent.__c.runVoidMethod ("Sleep",__ref.getField(false, "ba"),anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pybridge", "shlreadloop"),BA.numberCast(int.class, 50));
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
 BA.debugLineNum = 82;BA.debugLine="End Sub";
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
public static RemoteObject  _slice(RemoteObject __ref,RemoteObject _startvalue,RemoteObject _stopvalue) throws Exception{
try {
		Debug.PushSubsStack("Slice (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,287);
if (RapidSub.canDelegate("slice")) { return __ref.runUserSub(false, "pybridge","slice", __ref, _startvalue, _stopvalue);}
Debug.locals.put("StartValue", _startvalue);
Debug.locals.put("StopValue", _stopvalue);
 BA.debugLineNum = 287;BA.debugLine="Public Sub Slice (StartValue As Object, StopValue";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 288;BA.debugLine="Return Builtins.RunArgs(\"slice\", Array(Utils.Conv";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_runargs" /*RemoteObject*/ ,(Object)(BA.ObjectToString("slice")),(Object)(pybridge.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {2},new Object[] {__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_converttointifmatch" /*RemoteObject*/ ,(Object)(_startvalue)),__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_converttointifmatch" /*RemoteObject*/ ,(Object)(_stopvalue))})))),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), pybridge.__c.getField(false,"Null")));
 BA.debugLineNum = 289;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _sliceall(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("SliceAll (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,292);
if (RapidSub.canDelegate("sliceall")) { return __ref.runUserSub(false, "pybridge","sliceall", __ref);}
 BA.debugLineNum = 292;BA.debugLine="Public Sub SliceAll As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 293;BA.debugLine="Return Slice(Null, Null)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pybridge.class, "_slice" /*RemoteObject*/ ,(Object)(pybridge.__c.getField(false,"Null")),(Object)(pybridge.__c.getField(false,"Null")));
 BA.debugLineNum = 294;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _start(RemoteObject __ref,RemoteObject _options) throws Exception{
try {
		Debug.PushSubsStack("Start (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,41);
if (RapidSub.canDelegate("start")) { return __ref.runUserSub(false, "pybridge","start", __ref, _options);}
RemoteObject _exe = RemoteObject.createImmutable("");
RemoteObject _globalpath = RemoteObject.createImmutable("");
RemoteObject _path = RemoteObject.createImmutable("");
Debug.locals.put("Options", _options);
 BA.debugLineNum = 41;BA.debugLine="Public Sub Start (Options As PyOptions)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 42;BA.debugLine="KillProcess";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pybridge.class, "_killprocess" /*RemoteObject*/ );
 BA.debugLineNum = 43;BA.debugLine="mOptions = Options";
Debug.JustUpdateDeviceLine();
__ref.setField ("_moptions" /*RemoteObject*/ ,_options);
 BA.debugLineNum = 44;BA.debugLine="comm.Initialize(Me, Options.LocalPort)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_comm" /*RemoteObject*/ ).runClassMethod (b4j.example.pycomm.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"),(Object)((__ref)),(Object)(_options.getField(true,"LocalPort" /*RemoteObject*/ )));
 BA.debugLineNum = 45;BA.debugLine="Utils.Comm = comm";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_utils" /*RemoteObject*/ ).setField ("_comm" /*RemoteObject*/ ,__ref.getField(false,"_comm" /*RemoteObject*/ ));
 BA.debugLineNum = 46;BA.debugLine="If Options.PythonExecutable <> \"\" Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("!",_options.getField(true,"PythonExecutable" /*RemoteObject*/ ),BA.ObjectToString(""))) { 
 BA.debugLineNum = 47;BA.debugLine="If File.Exists(Options.PyBridgePath, \"\") = False";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",pybridge.__c.getField(false,"File").runMethod(true,"Exists",(Object)(_options.getField(true,"PyBridgePath" /*RemoteObject*/ )),(Object)(RemoteObject.createImmutable(""))),pybridge.__c.getField(true,"False")) || RemoteObject.solveBoolean(".",__ref.getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"ForceCopyBridgeSrc" /*RemoteObject*/ ))) { 
 BA.debugLineNum = 48;BA.debugLine="File.Copy(File.DirAssets, \"b4x_bridge.zip\", Opt";
Debug.JustUpdateDeviceLine();
pybridge.__c.getField(false,"File").runVoidMethod ("Copy",(Object)(pybridge.__c.getField(false,"File").runMethod(true,"getDirAssets")),(Object)(BA.ObjectToString("b4x_bridge.zip")),(Object)(_options.getField(true,"PyBridgePath" /*RemoteObject*/ )),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 49;BA.debugLine="Utils.PyLog(Utils.B4JPrefix, mOptions.B4JColor,";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_pylog" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_b4jprefix" /*RemoteObject*/ )),(Object)(__ref.getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"B4JColor" /*RemoteObject*/ )),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Python package copied to: "),_options.getField(true,"PyBridgePath" /*RemoteObject*/ )))));
 };
 BA.debugLineNum = 51;BA.debugLine="Dim exe As String = Options.PythonExecutable";
Debug.JustUpdateDeviceLine();
_exe = _options.getField(true,"PythonExecutable" /*RemoteObject*/ );Debug.locals.put("exe", _exe);Debug.locals.put("exe", _exe);
 BA.debugLineNum = 52;BA.debugLine="If File.Exists(exe, \"\") = False Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",pybridge.__c.getField(false,"File").runMethod(true,"Exists",(Object)(_exe),(Object)(RemoteObject.createImmutable(""))),pybridge.__c.getField(true,"False"))) { 
 BA.debugLineNum = 53;BA.debugLine="Dim GlobalPath As String = File.Combine(GetEnvi";
Debug.JustUpdateDeviceLine();
_globalpath = pybridge.__c.getField(false,"File").runMethod(true,"Combine",(Object)(pybridge.__c.runMethod(true,"GetEnvironmentVariable",(Object)(BA.ObjectToString("B4J_PYTHON")),(Object)(RemoteObject.createImmutable("")))),(Object)(RemoteObject.createImmutable("python.exe")));Debug.locals.put("GlobalPath", _globalpath);Debug.locals.put("GlobalPath", _globalpath);
 BA.debugLineNum = 54;BA.debugLine="If File.Exists(GlobalPath, \"\") Then";
Debug.JustUpdateDeviceLine();
if (pybridge.__c.getField(false,"File").runMethod(true,"Exists",(Object)(_globalpath),(Object)(RemoteObject.createImmutable(""))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 55;BA.debugLine="exe = GlobalPath";
Debug.JustUpdateDeviceLine();
_exe = _globalpath;Debug.locals.put("exe", _exe);
 }else {
 BA.debugLineNum = 57;BA.debugLine="LogError(\"Python executable not found!\")";
Debug.JustUpdateDeviceLine();
pybridge.__c.runVoidMethod ("LogError",(Object)(RemoteObject.createImmutable("Python executable not found!")));
 BA.debugLineNum = 58;BA.debugLine="comm.CloseServer";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_comm" /*RemoteObject*/ ).runClassMethod (b4j.example.pycomm.class, "_closeserver" /*RemoteObject*/ );
 BA.debugLineNum = 59;BA.debugLine="Return";
Debug.JustUpdateDeviceLine();
if (true) return RemoteObject.createImmutable("");
 };
 };
 BA.debugLineNum = 62;BA.debugLine="Log($\"Python path: ${exe}\"$)";
Debug.JustUpdateDeviceLine();
pybridge.__c.runVoidMethod ("LogImpl","9786453",(RemoteObject.concat(RemoteObject.createImmutable("Python path: "),pybridge.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_exe))),RemoteObject.createImmutable(""))),0);
 BA.debugLineNum = 63;BA.debugLine="Dim Shl As Shell";
Debug.JustUpdateDeviceLine();
pybridge._shl = RemoteObject.createNew ("anywheresoftware.b4j.objects.Shell");__ref.setField("_shl",pybridge._shl);
 BA.debugLineNum = 64;BA.debugLine="Shl.Initialize(\"shl\", exe, Array As String(\"-u\",";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_shl" /*RemoteObject*/ ).runVoidMethod ("Initialize",(Object)(BA.ObjectToString("shl")),(Object)(_exe),(Object)(pybridge.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("String",new int[] {5},new Object[] {BA.ObjectToString("-u"),BA.ObjectToString("-m"),BA.ObjectToString("b4x_bridge"),BA.NumberToString(__ref.getField(false,"_comm" /*RemoteObject*/ ).getField(true,"_port" /*RemoteObject*/ )),BA.NumberToString(__ref.getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"WatchDogSeconds" /*RemoteObject*/ ))})))));
 BA.debugLineNum = 65;BA.debugLine="Dim path As String = IIf(Options.PythonPath = \"\"";
Debug.JustUpdateDeviceLine();
_path = BA.ObjectToString(((RemoteObject.solveBoolean("=",_options.getField(true,"PythonPath" /*RemoteObject*/ ),BA.ObjectToString(""))) ? ((_options.getField(true,"PyBridgePath" /*RemoteObject*/ ))) : ((RemoteObject.concat(_options.getField(true,"PythonPath" /*RemoteObject*/ ),RemoteObject.createImmutable(";"),_options.getField(true,"PyBridgePath" /*RemoteObject*/ ))))));Debug.locals.put("path", _path);Debug.locals.put("path", _path);
 BA.debugLineNum = 66;BA.debugLine="Options.EnvironmentVars.Put(\"PYTHONPATH\", path)";
Debug.JustUpdateDeviceLine();
_options.getField(false,"EnvironmentVars" /*RemoteObject*/ ).runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("PYTHONPATH"))),(Object)((_path)));
 BA.debugLineNum = 67;BA.debugLine="If Options.PyCacheFolder <> \"\" Then Options.Envi";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("!",_options.getField(true,"PyCacheFolder" /*RemoteObject*/ ),BA.ObjectToString(""))) { 
_options.getField(false,"EnvironmentVars" /*RemoteObject*/ ).runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("PYTHONPYCACHEPREFIX"))),(Object)((_options.getField(true,"PyCacheFolder" /*RemoteObject*/ ))));};
 BA.debugLineNum = 68;BA.debugLine="Shl.SetEnvironmentVariables(Options.EnvironmentV";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_shl" /*RemoteObject*/ ).runVoidMethod ("SetEnvironmentVariables",(Object)(_options.getField(false,"EnvironmentVars" /*RemoteObject*/ )));
 BA.debugLineNum = 69;BA.debugLine="Shl.Run(-1)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_shl" /*RemoteObject*/ ).runVoidMethod ("Run",__ref.getField(false, "ba"),(Object)(BA.numberCast(long.class, -(double) (0 + 1))));
 BA.debugLineNum = 70;BA.debugLine="ShlReadLoop";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pybridge.class, "_shlreadloop" /*void*/ );
 };
 BA.debugLineNum = 72;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _state_changed(RemoteObject __ref,RemoteObject _oldstate,RemoteObject _newstate) throws Exception{
try {
		Debug.PushSubsStack("State_Changed (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,129);
if (RapidSub.canDelegate("state_changed")) { return __ref.runUserSub(false, "pybridge","state_changed", __ref, _oldstate, _newstate);}
Debug.locals.put("OldState", _oldstate);
Debug.locals.put("NewState", _newstate);
 BA.debugLineNum = 129;BA.debugLine="Private Sub State_Changed (OldState As Int, NewSta";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 130;BA.debugLine="If NewState = comm.STATE_CONNECTED Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_newstate,BA.numberCast(double.class, __ref.getField(false,"_comm" /*RemoteObject*/ ).getField(true,"_state_connected" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 131;BA.debugLine="AfterConnection";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pybridge.class, "_afterconnection" /*RemoteObject*/ );
 }else {
 BA.debugLineNum = 133;BA.debugLine="Utils.Disconnected";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_disconnected" /*RemoteObject*/ );
 BA.debugLineNum = 134;BA.debugLine="KillProcess";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pybridge.class, "_killprocess" /*RemoteObject*/ );
 };
 BA.debugLineNum = 136;BA.debugLine="If NewState = comm.STATE_CONNECTED Or (OldState =";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_newstate,BA.numberCast(double.class, __ref.getField(false,"_comm" /*RemoteObject*/ ).getField(true,"_state_connected" /*RemoteObject*/ ))) || RemoteObject.solveBoolean(".",BA.ObjectToBoolean((RemoteObject.solveBoolean("=",_oldstate,BA.numberCast(double.class, __ref.getField(false,"_comm" /*RemoteObject*/ ).getField(true,"_state_waiting_for_connection" /*RemoteObject*/ ))) && RemoteObject.solveBoolean("=",_newstate,BA.numberCast(double.class, __ref.getField(false,"_comm" /*RemoteObject*/ ).getField(true,"_state_disconnected" /*RemoteObject*/ ))))))) { 
 BA.debugLineNum = 137;BA.debugLine="CallSubDelayed2(mCallback, mEventName & \"_connec";
Debug.JustUpdateDeviceLine();
pybridge.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback" /*RemoteObject*/ )),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname" /*RemoteObject*/ ),RemoteObject.createImmutable("_connected"))),(Object)(RemoteObject.createImmutable((RemoteObject.solveBoolean("=",_newstate,BA.numberCast(double.class, __ref.getField(false,"_comm" /*RemoteObject*/ ).getField(true,"_state_connected" /*RemoteObject*/ )))))));
 }else 
{ BA.debugLineNum = 138;BA.debugLine="Else if SubExists(mCallback, mEventName & \"_disco";
Debug.JustUpdateDeviceLine();
if (pybridge.__c.runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback" /*RemoteObject*/ )),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname" /*RemoteObject*/ ),RemoteObject.createImmutable("_disconnected")))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 139;BA.debugLine="CallSubDelayed(mCallback, mEventName & \"_disconn";
Debug.JustUpdateDeviceLine();
pybridge.__c.runVoidMethod ("CallSubDelayed",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback" /*RemoteObject*/ )),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname" /*RemoteObject*/ ),RemoteObject.createImmutable("_disconnected"))));
 }}
;
 BA.debugLineNum = 141;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _task_received(RemoteObject __ref,RemoteObject _task) throws Exception{
try {
		Debug.PushSubsStack("Task_Received (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,159);
if (RapidSub.canDelegate("task_received")) { return __ref.runUserSub(false, "pybridge","task_received", __ref, _task);}
RemoteObject _eventname = RemoteObject.createImmutable("");
RemoteObject _params = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _cc = null;
Debug.locals.put("TASK", _task);
 BA.debugLineNum = 159;BA.debugLine="Private Sub Task_Received(TASK As PyTask)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 160;BA.debugLine="If TASK.TaskType = Utils.TASK_TYPE_PING Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_task.getField(true,"TaskType" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_task_type_ping" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 161;BA.debugLine="comm.SendTask(Utils.CreatePyTask(0, Utils.TASK_T";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_comm" /*RemoteObject*/ ).runClassMethod (b4j.example.pycomm.class, "_sendtask" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_createpytask" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_task_type_ping" /*RemoteObject*/ )),(Object)(pybridge.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {0},new Object[] {})))))));
 }else 
{ BA.debugLineNum = 162;BA.debugLine="Else If TASK.TaskType <> Utils.TASK_TYPE_EVENT Th";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("!",_task.getField(true,"TaskType" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_task_type_event" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 163;BA.debugLine="LogError(\"Unexpected message: \" & TASK)";
Debug.JustUpdateDeviceLine();
pybridge.__c.runVoidMethod ("LogError",(Object)(RemoteObject.concat(RemoteObject.createImmutable("Unexpected message: "),_task)));
 }else {
 BA.debugLineNum = 165;BA.debugLine="Dim EventName As String = TASK.Extra.Get(0)";
Debug.JustUpdateDeviceLine();
_eventname = BA.ObjectToString(_task.getField(false,"Extra" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(BA.numberCast(int.class, 0))));Debug.locals.put("EventName", _eventname);Debug.locals.put("EventName", _eventname);
 BA.debugLineNum = 166;BA.debugLine="Dim Params As Map = TASK.Extra.Get(1)";
Debug.JustUpdateDeviceLine();
_params = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
_params = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _task.getField(false,"Extra" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(BA.numberCast(int.class, 1))));Debug.locals.put("Params", _params);Debug.locals.put("Params", _params);
 BA.debugLineNum = 167;BA.debugLine="If EventMapper.ContainsKey(EventName) Then";
Debug.JustUpdateDeviceLine();
if (__ref.getField(false,"_eventmapper" /*RemoteObject*/ ).runMethod(true,"ContainsKey",(Object)((_eventname))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 168;BA.debugLine="Dim cc() As Object = EventMapper.Get(EventName)";
Debug.JustUpdateDeviceLine();
_cc = (__ref.getField(false,"_eventmapper" /*RemoteObject*/ ).runMethod(false,"Get",(Object)((_eventname))));Debug.locals.put("cc", _cc);Debug.locals.put("cc", _cc);
 BA.debugLineNum = 169;BA.debugLine="CallSubDelayed2(cc(0), cc(1).As(String) & \"_\" &";
Debug.JustUpdateDeviceLine();
pybridge.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)(_cc.getArrayElement(false,BA.numberCast(int.class, 0))),(Object)(RemoteObject.concat((BA.ObjectToString(_cc.getArrayElement(false,BA.numberCast(int.class, 1)))),RemoteObject.createImmutable("_"),_eventname)),(Object)((_params)));
 }else {
 BA.debugLineNum = 171;BA.debugLine="CallSubDelayed2(mCallback, mEventName & \"_\" & E";
Debug.JustUpdateDeviceLine();
pybridge.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback" /*RemoteObject*/ )),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname" /*RemoteObject*/ ),RemoteObject.createImmutable("_"),_eventname)),(Object)((_params)));
 };
 }}
;
 BA.debugLineNum = 174;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _wrapobject(RemoteObject __ref,RemoteObject _obj) throws Exception{
try {
		Debug.PushSubsStack("WrapObject (pybridge) ","pybridge",4,__ref.getField(false, "ba"),__ref,388);
if (RapidSub.canDelegate("wrapobject")) { return __ref.runUserSub(false, "pybridge","wrapobject", __ref, _obj);}
RemoteObject _code = RemoteObject.createImmutable("");
Debug.locals.put("Obj", _obj);
 BA.debugLineNum = 388;BA.debugLine="Public Sub WrapObject (Obj As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 389;BA.debugLine="Dim Code As String = $\" def WrapObject(obj): 	ret";
Debug.JustUpdateDeviceLine();
_code = (RemoteObject.concat(RemoteObject.createImmutable("\n"),RemoteObject.createImmutable("def WrapObject(obj):\n"),RemoteObject.createImmutable("	return obj\n"),RemoteObject.createImmutable("")));Debug.locals.put("Code", _code);Debug.locals.put("Code", _code);
 BA.debugLineNum = 393;BA.debugLine="Return RunCode(\"WrapObject\", Array(Obj), Code)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pybridge.class, "_runcode" /*RemoteObject*/ ,(Object)(BA.ObjectToString("WrapObject")),(Object)(pybridge.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {_obj})))),(Object)(_code));
 BA.debugLineNum = 394;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}