package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class pybridgeworker_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 1;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 2;BA.debugLine="Private py As PyBridge";
pybridgeworker._py = RemoteObject.createNew ("b4j.example.pybridge");__ref.setField("_py",pybridgeworker._py);
 //BA.debugLineNum = 3;BA.debugLine="Public AILogic As PyWrapper ' Python script";
pybridgeworker._ailogic = RemoteObject.createNew ("b4j.example.pywrapper");__ref.setField("_ailogic",pybridgeworker._ailogic);
 //BA.debugLineNum = 4;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static void  _get_embedding_request(RemoteObject __ref,RemoteObject _callback,RemoteObject _texttoembed) throws Exception{
try {
		Debug.PushSubsStack("Get_Embedding_Request (pybridgeworker) ","pybridgeworker",1,__ref.getField(false, "ba"),__ref,37);
if (RapidSub.canDelegate("get_embedding_request")) { __ref.runUserSub(false, "pybridgeworker","get_embedding_request", __ref, _callback, _texttoembed); return;}
ResumableSub_Get_Embedding_Request rsub = new ResumableSub_Get_Embedding_Request(null,__ref,_callback,_texttoembed);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_Get_Embedding_Request extends BA.ResumableSub {
public ResumableSub_Get_Embedding_Request(b4j.example.pybridgeworker parent,RemoteObject __ref,RemoteObject _callback,RemoteObject _texttoembed) {
this.parent = parent;
this.__ref = __ref;
this._callback = _callback;
this._texttoembed = _texttoembed;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.pybridgeworker parent;
RemoteObject _callback;
RemoteObject _texttoembed;
RemoteObject _embedtask = RemoteObject.declareNull("b4j.example.pywrapper");
RemoteObject _base64result = RemoteObject.declareNull("b4j.example.pywrapper");

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("Get_Embedding_Request (pybridgeworker) ","pybridgeworker",1,__ref.getField(false, "ba"),__ref,37);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = -1;
Debug.locals.put("_ref", __ref);
Debug.locals.put("Callback", _callback);
Debug.locals.put("TextToEmbed", _texttoembed);
 BA.debugLineNum = 39;BA.debugLine="Dim EmbedTask As PyWrapper = AILogic.Run(\"get_emb";
Debug.ShouldStop(64);
_embedtask = __ref.getField(false,"_ailogic" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("get_embedding"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)((_texttoembed)));Debug.locals.put("EmbedTask", _embedtask);Debug.locals.put("EmbedTask", _embedtask);
 BA.debugLineNum = 42;BA.debugLine="Wait For (EmbedTask.Fetch) Complete (Base64Result";
Debug.ShouldStop(512);
parent.__c.runVoidMethod ("WaitFor","complete", __ref.getField(false, "ba"), anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pybridgeworker", "get_embedding_request"), _embedtask.runClassMethod (b4j.example.pywrapper.class, "_fetch" /*RemoteObject*/ ));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_base64result = (RemoteObject) result.getArrayElement(false,RemoteObject.createImmutable(1));Debug.locals.put("Base64Result", _base64result);
;
 BA.debugLineNum = 45;BA.debugLine="CallSubDelayed2(Callback, \"Embedding_Response\", B";
Debug.ShouldStop(4096);
parent.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)(_callback),(Object)(BA.ObjectToString("Embedding_Response")),(Object)(_base64result.runClassMethod (b4j.example.pywrapper.class, "_getvalue" /*RemoteObject*/ )));
 BA.debugLineNum = 48;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
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
public static void  _complete(RemoteObject __ref,RemoteObject _base64result) throws Exception{
}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (pybridgeworker) ","pybridgeworker",1,__ref.getField(false, "ba"),__ref,6);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "pybridgeworker","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 6;BA.debugLine="Public Sub Initialize";
Debug.ShouldStop(32);
 BA.debugLineNum = 7;BA.debugLine="Main.PyWorker = Me";
Debug.ShouldStop(64);
pybridgeworker._main._pyworker /*RemoteObject*/  = (__ref);
 BA.debugLineNum = 8;BA.debugLine="Start";
Debug.ShouldStop(128);
__ref.runClassMethod (b4j.example.pybridgeworker.class, "_start" /*void*/ );
 BA.debugLineNum = 9;BA.debugLine="StartMessageLoop";
Debug.ShouldStop(256);
pybridgeworker.__c.runVoidMethod ("StartMessageLoop",__ref.getField(false, "ba"));
 BA.debugLineNum = 10;BA.debugLine="End Sub";
Debug.ShouldStop(512);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static void  _py_disconnected(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("py_Disconnected (pybridgeworker) ","pybridgeworker",1,__ref.getField(false, "ba"),__ref,50);
if (RapidSub.canDelegate("py_disconnected")) { __ref.runUserSub(false, "pybridgeworker","py_disconnected", __ref); return;}
ResumableSub_py_Disconnected rsub = new ResumableSub_py_Disconnected(null,__ref);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_py_Disconnected extends BA.ResumableSub {
public ResumableSub_py_Disconnected(b4j.example.pybridgeworker parent,RemoteObject __ref) {
this.parent = parent;
this.__ref = __ref;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.pybridgeworker parent;

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("py_Disconnected (pybridgeworker) ","pybridgeworker",1,__ref.getField(false, "ba"),__ref,50);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = -1;
Debug.locals.put("_ref", __ref);
 BA.debugLineNum = 51;BA.debugLine="Log(\"PyBridge disconnected!!!\")";
Debug.ShouldStop(262144);
parent.__c.runVoidMethod ("LogImpl","2393217",RemoteObject.createImmutable("PyBridge disconnected!!!"),0);
 BA.debugLineNum = 52;BA.debugLine="Sleep(5000)";
Debug.ShouldStop(524288);
parent.__c.runVoidMethod ("Sleep",__ref.getField(false, "ba"),anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pybridgeworker", "py_disconnected"),BA.numberCast(int.class, 5000));
this.state = 1;
return;
case 1:
//C
this.state = -1;
;
 BA.debugLineNum = 53;BA.debugLine="Start";
Debug.ShouldStop(1048576);
__ref.runClassMethod (b4j.example.pybridgeworker.class, "_start" /*void*/ );
 BA.debugLineNum = 54;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
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
public static void  _start(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Start (pybridgeworker) ","pybridgeworker",1,__ref.getField(false, "ba"),__ref,12);
if (RapidSub.canDelegate("start")) { __ref.runUserSub(false, "pybridgeworker","start", __ref); return;}
ResumableSub_Start rsub = new ResumableSub_Start(null,__ref);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_Start extends BA.ResumableSub {
public ResumableSub_Start(b4j.example.pybridgeworker parent,RemoteObject __ref) {
this.parent = parent;
this.__ref = __ref;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.pybridgeworker parent;
RemoteObject _opt = RemoteObject.declareNull("b4j.example.pybridge._pyoptions");
RemoteObject _success = RemoteObject.createImmutable(false);
RemoteObject _inittask = RemoteObject.declareNull("b4j.example.pywrapper");
RemoteObject _result = RemoteObject.declareNull("b4j.example.pywrapper");

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("Start (pybridgeworker) ","pybridgeworker",1,__ref.getField(false, "ba"),__ref,12);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
Debug.locals.put("_ref", __ref);
 BA.debugLineNum = 13;BA.debugLine="py.Initialize(Me, \"py\")";
Debug.ShouldStop(4096);
__ref.getField(false,"_py" /*RemoteObject*/ ).runClassMethod (b4j.example.pybridge.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"),(Object)(__ref),(Object)(RemoteObject.createImmutable("py")));
 BA.debugLineNum = 14;BA.debugLine="Dim opt As PyOptions = py.CreateOptions(\"python\")";
Debug.ShouldStop(8192);
_opt = __ref.getField(false,"_py" /*RemoteObject*/ ).runClassMethod (b4j.example.pybridge.class, "_createoptions" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("python")));Debug.locals.put("opt", _opt);Debug.locals.put("opt", _opt);
 BA.debugLineNum = 15;BA.debugLine="py.Start(opt)";
Debug.ShouldStop(16384);
__ref.getField(false,"_py" /*RemoteObject*/ ).runClassMethod (b4j.example.pybridge.class, "_start" /*RemoteObject*/ ,(Object)(_opt));
 BA.debugLineNum = 17;BA.debugLine="Wait For py_Connected (Success As Boolean)";
Debug.ShouldStop(65536);
parent.__c.runVoidMethod ("WaitFor","py_connected", __ref.getField(false, "ba"), anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pybridgeworker", "start"), null);
this.state = 5;
return;
case 5:
//C
this.state = 1;
_success = (RemoteObject) result.getArrayElement(true,RemoteObject.createImmutable(1));Debug.locals.put("Success", _success);
;
 BA.debugLineNum = 18;BA.debugLine="If Success = False Then";
Debug.ShouldStop(131072);
if (true) break;

case 1:
//if
this.state = 4;
if (RemoteObject.solveBoolean("=",_success,parent.__c.getField(true,"False"))) { 
this.state = 3;
}if (true) break;

case 3:
//C
this.state = 4;
 BA.debugLineNum = 19;BA.debugLine="py_Disconnected";
Debug.ShouldStop(262144);
__ref.runClassMethod (b4j.example.pybridgeworker.class, "_py_disconnected" /*void*/ );
 BA.debugLineNum = 20;BA.debugLine="Return";
Debug.ShouldStop(524288);
if (true) return ;
 if (true) break;

case 4:
//C
this.state = -1;
;
 BA.debugLineNum = 23;BA.debugLine="Log(\"PyBridge Connected! Loading LLM - please wai";
Debug.ShouldStop(4194304);
parent.__c.runVoidMethod ("LogImpl","2262155",RemoteObject.createImmutable("PyBridge Connected! Loading LLM - please wait..."),0);
 BA.debugLineNum = 26;BA.debugLine="AILogic = py.ImportModule(\"text_embedding\")";
Debug.ShouldStop(33554432);
__ref.setField ("_ailogic" /*RemoteObject*/ ,__ref.getField(false,"_py" /*RemoteObject*/ ).runClassMethod (b4j.example.pybridge.class, "_importmodule" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("text_embedding"))));
 BA.debugLineNum = 29;BA.debugLine="Dim InitTask As PyWrapper = AILogic.Run(\"init_mod";
Debug.ShouldStop(268435456);
_inittask = __ref.getField(false,"_ailogic" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("init_model")));Debug.locals.put("InitTask", _inittask);Debug.locals.put("InitTask", _inittask);
 BA.debugLineNum = 30;BA.debugLine="Wait For (InitTask.Fetch) Complete (Result As PyW";
Debug.ShouldStop(536870912);
parent.__c.runVoidMethod ("WaitFor","complete", __ref.getField(false, "ba"), anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pybridgeworker", "start"), _inittask.runClassMethod (b4j.example.pywrapper.class, "_fetch" /*RemoteObject*/ ));
this.state = 6;
return;
case 6:
//C
this.state = -1;
_result = (RemoteObject) result.getArrayElement(false,RemoteObject.createImmutable(1));Debug.locals.put("Result", _result);
;
 BA.debugLineNum = 31;BA.debugLine="Log(\"AI Status: \" & Result.Value)";
Debug.ShouldStop(1073741824);
parent.__c.runVoidMethod ("LogImpl","2262163",RemoteObject.concat(RemoteObject.createImmutable("AI Status: "),_result.runClassMethod (b4j.example.pywrapper.class, "_getvalue" /*RemoteObject*/ )),0);
 BA.debugLineNum = 32;BA.debugLine="End Sub";
Debug.ShouldStop(-2147483648);
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
public static void  _py_connected(RemoteObject __ref,RemoteObject _success) throws Exception{
}
}