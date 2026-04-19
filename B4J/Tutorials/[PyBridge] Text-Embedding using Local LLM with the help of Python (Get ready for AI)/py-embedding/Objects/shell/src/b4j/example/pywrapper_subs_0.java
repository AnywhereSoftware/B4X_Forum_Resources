package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class pywrapper_subs_0 {


public static RemoteObject  _afterarg(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("AfterArg (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,32);
if (RapidSub.canDelegate("afterarg")) { return __ref.runUserSub(false, "pywrapper","afterarg", __ref);}
 BA.debugLineNum = 32;BA.debugLine="Private Sub AfterArg As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 33;BA.debugLine="mBridge.Utils.Comm.MoveTaskToLast(LastArgs.Task)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).getField(false,"_comm" /*RemoteObject*/ ).runClassMethod (b4j.example.pycomm.class, "_movetasktolast" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_lastargs" /*RemoteObject*/ ).getField(false,"Task" /*RemoteObject*/ )));
 BA.debugLineNum = 34;BA.debugLine="Return Me";
Debug.JustUpdateDeviceLine();
if (true) return (__ref);
 BA.debugLineNum = 35;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _arg(RemoteObject __ref,RemoteObject _parameter) throws Exception{
try {
		Debug.PushSubsStack("Arg (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,38);
if (RapidSub.canDelegate("arg")) { return __ref.runUserSub(false, "pywrapper","arg", __ref, _parameter);}
Debug.locals.put("Parameter", _parameter);
 BA.debugLineNum = 38;BA.debugLine="Public Sub Arg(Parameter As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 39;BA.debugLine="LastArgs.Args.Add(Parameter)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_lastargs" /*RemoteObject*/ ).getField(false,"Args" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)(_parameter));
 BA.debugLineNum = 40;BA.debugLine="Return AfterArg";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_afterarg" /*RemoteObject*/ );
 BA.debugLineNum = 41;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _argnamed(RemoteObject __ref,RemoteObject _name,RemoteObject _parameter) throws Exception{
try {
		Debug.PushSubsStack("ArgNamed (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,43);
if (RapidSub.canDelegate("argnamed")) { return __ref.runUserSub(false, "pywrapper","argnamed", __ref, _name, _parameter);}
Debug.locals.put("Name", _name);
Debug.locals.put("Parameter", _parameter);
 BA.debugLineNum = 43;BA.debugLine="Public Sub ArgNamed (Name As String, Parameter As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 44;BA.debugLine="LastArgs.KWArgs.Put(Name, Parameter)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_lastargs" /*RemoteObject*/ ).getField(false,"KWArgs" /*RemoteObject*/ ).runVoidMethod ("Put",(Object)((_name)),(Object)(_parameter));
 BA.debugLineNum = 45;BA.debugLine="Return AfterArg";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_afterarg" /*RemoteObject*/ );
 BA.debugLineNum = 46;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _args(RemoteObject __ref,RemoteObject _parameters) throws Exception{
try {
		Debug.PushSubsStack("Args (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,27);
if (RapidSub.canDelegate("args")) { return __ref.runUserSub(false, "pywrapper","args", __ref, _parameters);}
Debug.locals.put("Parameters", _parameters);
 BA.debugLineNum = 27;BA.debugLine="Public Sub Args(Parameters As List) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 28;BA.debugLine="LastArgs.Args.AddAll(Parameters)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_lastargs" /*RemoteObject*/ ).getField(false,"Args" /*RemoteObject*/ ).runVoidMethod ("AddAll",(Object)(_parameters));
 BA.debugLineNum = 29;BA.debugLine="Return AfterArg";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_afterarg" /*RemoteObject*/ );
 BA.debugLineNum = 30;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _argsnamed(RemoteObject __ref,RemoteObject _parameters) throws Exception{
try {
		Debug.PushSubsStack("ArgsNamed (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,48);
if (RapidSub.canDelegate("argsnamed")) { return __ref.runUserSub(false, "pywrapper","argsnamed", __ref, _parameters);}
RemoteObject _k = RemoteObject.createImmutable("");
Debug.locals.put("Parameters", _parameters);
 BA.debugLineNum = 48;BA.debugLine="Public Sub ArgsNamed (Parameters As Map) As PyWrap";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 49;BA.debugLine="For Each k As String In Parameters.Keys";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group1 = _parameters.runMethod(false,"Keys");
final int groupLen1 = group1.runMethod(true,"getSize").<Integer>get()
;int index1 = 0;
;
for (; index1 < groupLen1;index1++){
_k = BA.ObjectToString(group1.runMethod(false,"Get",index1));Debug.locals.put("k", _k);
Debug.locals.put("k", _k);
 BA.debugLineNum = 50;BA.debugLine="LastArgs.KWArgs.Put(k, Parameters.Get(k))";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_lastargs" /*RemoteObject*/ ).getField(false,"KWArgs" /*RemoteObject*/ ).runVoidMethod ("Put",(Object)((_k)),(Object)(_parameters.runMethod(false,"Get",(Object)((_k)))));
 }
}Debug.locals.put("k", _k);
;
 BA.debugLineNum = 52;BA.debugLine="Return AfterArg";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_afterarg" /*RemoteObject*/ );
 BA.debugLineNum = 53;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asfloat(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("AsFloat (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,251);
if (RapidSub.canDelegate("asfloat")) { return __ref.runUserSub(false, "pywrapper","asfloat", __ref);}
 BA.debugLineNum = 251;BA.debugLine="Public Sub AsFloat As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 252;BA.debugLine="Return mBridge.Builtins.Run(\"float\").Arg(Internal";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("float"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_internalkey" /*RemoteObject*/ ))));
 BA.debugLineNum = 253;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asint(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("AsInt (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,256);
if (RapidSub.canDelegate("asint")) { return __ref.runUserSub(false, "pywrapper","asint", __ref);}
 BA.debugLineNum = 256;BA.debugLine="Public Sub AsInt As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 257;BA.debugLine="Return mBridge.Builtins.Run(\"int\").Arg(Me)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("int"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(__ref));
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
public static RemoteObject  _call(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Call (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,22);
if (RapidSub.canDelegate("call")) { return __ref.runUserSub(false, "pywrapper","call", __ref);}
 BA.debugLineNum = 22;BA.debugLine="Public Sub Call As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 23;BA.debugLine="Return Run(\"__call__\")";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__call__")));
 BA.debugLineNum = 24;BA.debugLine="End Sub";
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
 //BA.debugLineNum = 1;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 2;BA.debugLine="Public InternalKey As PyObject";
pywrapper._internalkey = RemoteObject.createNew ("b4j.example.pybridge._pyobject");__ref.setField("_internalkey",pywrapper._internalkey);
 //BA.debugLineNum = 3;BA.debugLine="Private mBridge As PyBridge";
pywrapper._mbridge = RemoteObject.createNew ("b4j.example.pybridge");__ref.setField("_mbridge",pywrapper._mbridge);
 //BA.debugLineNum = 4;BA.debugLine="Private mFetched As Boolean";
pywrapper._mfetched = RemoteObject.createImmutable(false);__ref.setField("_mfetched",pywrapper._mfetched);
 //BA.debugLineNum = 5;BA.debugLine="Private mError As Boolean";
pywrapper._merror = RemoteObject.createImmutable(false);__ref.setField("_merror",pywrapper._merror);
 //BA.debugLineNum = 6;BA.debugLine="Private mValue As Object";
pywrapper._mvalue = RemoteObject.createNew ("Object");__ref.setField("_mvalue",pywrapper._mvalue);
 //BA.debugLineNum = 7;BA.debugLine="Private LastArgs As InternalPyMethodArgs";
pywrapper._lastargs = RemoteObject.createNew ("b4j.example.pybridge._internalpymethodargs");__ref.setField("_lastargs",pywrapper._lastargs);
 //BA.debugLineNum = 8;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _contains(RemoteObject __ref,RemoteObject _item) throws Exception{
try {
		Debug.PushSubsStack("Contains (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,201);
if (RapidSub.canDelegate("contains")) { return __ref.runUserSub(false, "pywrapper","contains", __ref, _item);}
Debug.locals.put("Item", _item);
 BA.debugLineNum = 201;BA.debugLine="Public Sub Contains(Item As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 202;BA.debugLine="Return Run(\"__contains__\").Arg(mBridge.Utils.Conv";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__contains__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_converttointifmatch" /*RemoteObject*/ ,(Object)(_item))));
 BA.debugLineNum = 203;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _delitem(RemoteObject __ref,RemoteObject _key,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("DelItem (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,196);
if (RapidSub.canDelegate("delitem")) { return __ref.runUserSub(false, "pywrapper","delitem", __ref, _key, _value);}
Debug.locals.put("Key", _key);
Debug.locals.put("Value", _value);
 BA.debugLineNum = 196;BA.debugLine="Public Sub DelItem(Key As Object, Value As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 197;BA.debugLine="Run(\"__detitem__\").Arg(mBridge.Utils.ConvertToInt";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__detitem__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_converttointifmatch" /*RemoteObject*/ ,(Object)(_key)))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_value));
 BA.debugLineNum = 198;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fetch(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Fetch (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,84);
if (RapidSub.canDelegate("fetch")) { return __ref.runUserSub(false, "pywrapper","fetch", __ref);}
ResumableSub_Fetch rsub = new ResumableSub_Fetch(null,__ref);
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
public ResumableSub_Fetch(b4j.example.pywrapper parent,RemoteObject __ref) {
this.parent = parent;
this.__ref = __ref;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.pywrapper parent;
RemoteObject _result = RemoteObject.declareNull("b4j.example.pybridge._internalpytaskasyncresult");

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("Fetch (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,84);
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
 BA.debugLineNum = 85;BA.debugLine="Wait For (mBridge.Utils.Fetch(InternalKey)) Compl";
Debug.JustUpdateDeviceLine();
parent.__c.runVoidMethod ("WaitFor","complete", __ref.getField(false, "ba"), anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pywrapper", "fetch"), __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_fetch" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_internalkey" /*RemoteObject*/ ))));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_result = (RemoteObject) result.getArrayElement(false,RemoteObject.createImmutable(1));Debug.locals.put("Result", _result);
;
 BA.debugLineNum = 86;BA.debugLine="Return Wrap(Result)";
Debug.JustUpdateDeviceLine();
if (true) {
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,(__ref.runClassMethod (b4j.example.pywrapper.class, "_wrap" /*RemoteObject*/ ,(Object)(_result))));return;};
 BA.debugLineNum = 87;BA.debugLine="End Sub";
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
public static RemoteObject  _get(RemoteObject __ref,RemoteObject _key) throws Exception{
try {
		Debug.PushSubsStack("Get (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,176);
if (RapidSub.canDelegate("get")) { return __ref.runUserSub(false, "pywrapper","get", __ref, _key);}
Debug.locals.put("Key", _key);
 BA.debugLineNum = 176;BA.debugLine="Public Sub Get (Key As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 177;BA.debugLine="Return Run(\"__getitem__\").Arg(mBridge.Utils.Conve";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__getitem__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_converttointifmatch" /*RemoteObject*/ ,(Object)(_key))));
 BA.debugLineNum = 178;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get2d(RemoteObject __ref,RemoteObject _key1,RemoteObject _key2) throws Exception{
try {
		Debug.PushSubsStack("Get2D (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,181);
if (RapidSub.canDelegate("get2d")) { return __ref.runUserSub(false, "pywrapper","get2d", __ref, _key1, _key2);}
Debug.locals.put("Key1", _key1);
Debug.locals.put("Key2", _key2);
 BA.debugLineNum = 181;BA.debugLine="Public Sub Get2D (Key1 As Object, Key2 As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 182;BA.debugLine="Return Get(Array(Key1, Key2))";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_get" /*RemoteObject*/ ,(Object)((RemoteObject.createNewArray("Object",new int[] {2},new Object[] {_key1,_key2}))));
 BA.debugLineNum = 183;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get3d(RemoteObject __ref,RemoteObject _key1,RemoteObject _key2,RemoteObject _key3) throws Exception{
try {
		Debug.PushSubsStack("Get3D (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,186);
if (RapidSub.canDelegate("get3d")) { return __ref.runUserSub(false, "pywrapper","get3d", __ref, _key1, _key2, _key3);}
Debug.locals.put("Key1", _key1);
Debug.locals.put("Key2", _key2);
Debug.locals.put("Key3", _key3);
 BA.debugLineNum = 186;BA.debugLine="Public Sub Get3D (Key1 As Object, Key2 As Object,";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 187;BA.debugLine="Return Get(Array(Key1, Key2, Key3))";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_get" /*RemoteObject*/ ,(Object)((RemoteObject.createNewArray("Object",new int[] {3},new Object[] {_key1,_key2,_key3}))));
 BA.debugLineNum = 188;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _geterrormessage(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getErrorMessage (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,151);
if (RapidSub.canDelegate("geterrormessage")) { return __ref.runUserSub(false, "pywrapper","geterrormessage", __ref);}
 BA.debugLineNum = 151;BA.debugLine="Public Sub getErrorMessage As String";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 152;BA.debugLine="If mError Then Return mValue";
Debug.JustUpdateDeviceLine();
if (__ref.getField(true,"_merror" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
if (true) return BA.ObjectToString(__ref.getField(false,"_mvalue" /*RemoteObject*/ ));};
 BA.debugLineNum = 153;BA.debugLine="Return \"\"";
Debug.JustUpdateDeviceLine();
if (true) return BA.ObjectToString("");
 BA.debugLineNum = 154;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getfield(RemoteObject __ref,RemoteObject _field) throws Exception{
try {
		Debug.PushSubsStack("GetField (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,90);
if (RapidSub.canDelegate("getfield")) { return __ref.runUserSub(false, "pywrapper","getfield", __ref, _field);}
Debug.locals.put("Field", _field);
 BA.debugLineNum = 90;BA.debugLine="Public Sub GetField (Field As String) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 91;BA.debugLine="Return mBridge.Builtins.RunArgs(\"getattr\", Array(";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_runargs" /*RemoteObject*/ ,(Object)(BA.ObjectToString("getattr")),(Object)(pywrapper.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {2},new Object[] {(__ref.getField(false,"_internalkey" /*RemoteObject*/ )),(_field)})))),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), pywrapper.__c.getField(false,"Null")));
 BA.debugLineNum = 92;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getisfetched(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getIsFetched (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,146);
if (RapidSub.canDelegate("getisfetched")) { return __ref.runUserSub(false, "pywrapper","getisfetched", __ref);}
 BA.debugLineNum = 146;BA.debugLine="Public Sub getIsFetched As Boolean";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 147;BA.debugLine="Return mFetched";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(true,"_mfetched" /*RemoteObject*/ );
 BA.debugLineNum = 148;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getissuccess(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getIsSuccess (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,139);
if (RapidSub.canDelegate("getissuccess")) { return __ref.runUserSub(false, "pywrapper","getissuccess", __ref);}
 BA.debugLineNum = 139;BA.debugLine="Public Sub getIsSuccess As Boolean";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 140;BA.debugLine="If mFetched = False Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_mfetched" /*RemoteObject*/ ),pywrapper.__c.getField(true,"False"))) { 
 BA.debugLineNum = 141;BA.debugLine="Me.As(JavaObject).RunMethod(\"raiseError\", Array(";
Debug.JustUpdateDeviceLine();
(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), __ref)).runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("raiseError")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(RemoteObject.createImmutable("Value not fetched"))})));
 };
 BA.debugLineNum = 143;BA.debugLine="Return Not(mError)";
Debug.JustUpdateDeviceLine();
if (true) return pywrapper.__c.runMethod(true,"Not",(Object)(__ref.getField(true,"_merror" /*RemoteObject*/ )));
 BA.debugLineNum = 144;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getvalue(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getValue (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,128);
if (RapidSub.canDelegate("getvalue")) { return __ref.runUserSub(false, "pywrapper","getvalue", __ref);}
 BA.debugLineNum = 128;BA.debugLine="Public Sub getValue As Object";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 129;BA.debugLine="If mError Then";
Debug.JustUpdateDeviceLine();
if (__ref.getField(true,"_merror" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 130;BA.debugLine="Me.As(JavaObject).RunMethod(\"raiseError\", Array(";
Debug.JustUpdateDeviceLine();
(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), __ref)).runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("raiseError")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {__ref.getField(false,"_mvalue" /*RemoteObject*/ )})));
 };
 BA.debugLineNum = 132;BA.debugLine="If mFetched = False Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_mfetched" /*RemoteObject*/ ),pywrapper.__c.getField(true,"False"))) { 
 BA.debugLineNum = 133;BA.debugLine="Me.As(JavaObject).RunMethod(\"raiseError\", Array(";
Debug.JustUpdateDeviceLine();
(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), __ref)).runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("raiseError")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(RemoteObject.createImmutable("Value not fetched"))})));
 };
 BA.debugLineNum = 135;BA.debugLine="Return mValue";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_mvalue" /*RemoteObject*/ );
 BA.debugLineNum = 136;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _bridge,RemoteObject _key) throws Exception{
try {
		Debug.PushSubsStack("Initialize (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,11);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "pywrapper","initialize", __ref, _ba, _bridge, _key);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
Debug.locals.put("Bridge", _bridge);
Debug.locals.put("Key", _key);
 BA.debugLineNum = 11;BA.debugLine="Public Sub Initialize (Bridge As PyBridge, Key As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 12;BA.debugLine="InternalKey = Key";
Debug.JustUpdateDeviceLine();
__ref.setField ("_internalkey" /*RemoteObject*/ ,_key);
 BA.debugLineNum = 13;BA.debugLine="mBridge = Bridge";
Debug.JustUpdateDeviceLine();
__ref.setField ("_mbridge" /*RemoteObject*/ ,_bridge);
 BA.debugLineNum = 14;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _iter(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Iter (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,303);
if (RapidSub.canDelegate("iter")) { return __ref.runUserSub(false, "pywrapper","iter", __ref);}
 BA.debugLineNum = 303;BA.debugLine="Public Sub Iter As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 304;BA.debugLine="Return Run(\"__iter__\")";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__iter__")));
 BA.debugLineNum = 305;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _len(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Len (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,216);
if (RapidSub.canDelegate("len")) { return __ref.runUserSub(false, "pywrapper","len", __ref);}
 BA.debugLineNum = 216;BA.debugLine="Public Sub Len As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 217;BA.debugLine="Return mBridge.Builtins.Run(\"len\").Arg(InternalKe";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("len"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_internalkey" /*RemoteObject*/ ))));
 BA.debugLineNum = 218;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _opradd(RemoteObject __ref,RemoteObject _other) throws Exception{
try {
		Debug.PushSubsStack("OprAdd (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,226);
if (RapidSub.canDelegate("opradd")) { return __ref.runUserSub(false, "pywrapper","opradd", __ref, _other);}
Debug.locals.put("Other", _other);
 BA.debugLineNum = 226;BA.debugLine="Public Sub OprAdd (Other As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 227;BA.debugLine="Return Run(\"__add__\").Arg(Other)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__add__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_other));
 BA.debugLineNum = 228;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _oprand(RemoteObject __ref,RemoteObject _other) throws Exception{
try {
		Debug.PushSubsStack("OprAnd (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,287);
if (RapidSub.canDelegate("oprand")) { return __ref.runUserSub(false, "pywrapper","oprand", __ref, _other);}
Debug.locals.put("Other", _other);
 BA.debugLineNum = 287;BA.debugLine="Public Sub OprAnd (Other As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 288;BA.debugLine="Return Run(\"__and__\").Arg(Other)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__and__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_other));
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
public static RemoteObject  _oprequal(RemoteObject __ref,RemoteObject _other) throws Exception{
try {
		Debug.PushSubsStack("OprEqual (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,261);
if (RapidSub.canDelegate("oprequal")) { return __ref.runUserSub(false, "pywrapper","oprequal", __ref, _other);}
Debug.locals.put("Other", _other);
 BA.debugLineNum = 261;BA.debugLine="Public Sub OprEqual (Other As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 262;BA.debugLine="Return Run(\"__eq__\").Arg(Other)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__eq__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_other));
 BA.debugLineNum = 263;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _oprgreater(RemoteObject __ref,RemoteObject _other) throws Exception{
try {
		Debug.PushSubsStack("OprGreater (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,277);
if (RapidSub.canDelegate("oprgreater")) { return __ref.runUserSub(false, "pywrapper","oprgreater", __ref, _other);}
Debug.locals.put("Other", _other);
 BA.debugLineNum = 277;BA.debugLine="Public Sub OprGreater (Other As Object) As PyWrapp";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 278;BA.debugLine="Return Run(\"__gt__\").Arg(Other)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__gt__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_other));
 BA.debugLineNum = 279;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _oprgreaterequal(RemoteObject __ref,RemoteObject _other) throws Exception{
try {
		Debug.PushSubsStack("OprGreaterEqual (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,282);
if (RapidSub.canDelegate("oprgreaterequal")) { return __ref.runUserSub(false, "pywrapper","oprgreaterequal", __ref, _other);}
Debug.locals.put("Other", _other);
 BA.debugLineNum = 282;BA.debugLine="Public Sub OprGreaterEqual (Other As Object) As Py";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 283;BA.debugLine="Return Run(\"__ge__\").Arg(Other)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__ge__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_other));
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
public static RemoteObject  _oprless(RemoteObject __ref,RemoteObject _other) throws Exception{
try {
		Debug.PushSubsStack("OprLess (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,269);
if (RapidSub.canDelegate("oprless")) { return __ref.runUserSub(false, "pywrapper","oprless", __ref, _other);}
Debug.locals.put("Other", _other);
 BA.debugLineNum = 269;BA.debugLine="Public Sub OprLess (Other As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 270;BA.debugLine="Return Run(\"__lt__\").Arg(Other)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__lt__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_other));
 BA.debugLineNum = 271;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _oprlessequal(RemoteObject __ref,RemoteObject _other) throws Exception{
try {
		Debug.PushSubsStack("OprLessEqual (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,273);
if (RapidSub.canDelegate("oprlessequal")) { return __ref.runUserSub(false, "pywrapper","oprlessequal", __ref, _other);}
Debug.locals.put("Other", _other);
 BA.debugLineNum = 273;BA.debugLine="Public Sub OprLessEqual (Other As Object) As PyWra";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 274;BA.debugLine="Return Run(\"__le__\").Arg(Other)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__le__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_other));
 BA.debugLineNum = 275;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _oprmod(RemoteObject __ref,RemoteObject _other) throws Exception{
try {
		Debug.PushSubsStack("OprMod (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,241);
if (RapidSub.canDelegate("oprmod")) { return __ref.runUserSub(false, "pywrapper","oprmod", __ref, _other);}
Debug.locals.put("Other", _other);
 BA.debugLineNum = 241;BA.debugLine="Public Sub OprMod (Other As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 242;BA.debugLine="Return Run(\"__mod__\").Arg(Other)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__mod__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_other));
 BA.debugLineNum = 243;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _oprmul(RemoteObject __ref,RemoteObject _other) throws Exception{
try {
		Debug.PushSubsStack("OprMul (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,236);
if (RapidSub.canDelegate("oprmul")) { return __ref.runUserSub(false, "pywrapper","oprmul", __ref, _other);}
Debug.locals.put("Other", _other);
 BA.debugLineNum = 236;BA.debugLine="Public Sub OprMul (Other As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 237;BA.debugLine="Return Run(\"__mul__\").Arg(Other)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__mul__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_other));
 BA.debugLineNum = 238;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _oprnot(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("OprNot (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,295);
if (RapidSub.canDelegate("oprnot")) { return __ref.runUserSub(false, "pywrapper","oprnot", __ref);}
 BA.debugLineNum = 295;BA.debugLine="Public Sub OprNot As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 296;BA.debugLine="Return Run(\"__invert__\")";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__invert__")));
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
public static RemoteObject  _oprnotequal(RemoteObject __ref,RemoteObject _other) throws Exception{
try {
		Debug.PushSubsStack("OprNotEqual (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,265);
if (RapidSub.canDelegate("oprnotequal")) { return __ref.runUserSub(false, "pywrapper","oprnotequal", __ref, _other);}
Debug.locals.put("Other", _other);
 BA.debugLineNum = 265;BA.debugLine="Public Sub OprNotEqual (Other As Object) As PyWrap";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 266;BA.debugLine="Return Run(\"__ne__\").Arg(Other)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__ne__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_other));
 BA.debugLineNum = 267;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _opror(RemoteObject __ref,RemoteObject _other) throws Exception{
try {
		Debug.PushSubsStack("OprOr (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,291);
if (RapidSub.canDelegate("opror")) { return __ref.runUserSub(false, "pywrapper","opror", __ref, _other);}
Debug.locals.put("Other", _other);
 BA.debugLineNum = 291;BA.debugLine="Public Sub OprOr (Other As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 292;BA.debugLine="Return Run(\"__or__\").Arg(Other)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__or__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_other));
 BA.debugLineNum = 293;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _oprpow(RemoteObject __ref,RemoteObject _other) throws Exception{
try {
		Debug.PushSubsStack("OprPow (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,246);
if (RapidSub.canDelegate("oprpow")) { return __ref.runUserSub(false, "pywrapper","oprpow", __ref, _other);}
Debug.locals.put("Other", _other);
 BA.debugLineNum = 246;BA.debugLine="Public Sub OprPow (Other As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 247;BA.debugLine="Return Run(\"__pow__\").Arg(Other)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__pow__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_other));
 BA.debugLineNum = 248;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _oprsub(RemoteObject __ref,RemoteObject _other) throws Exception{
try {
		Debug.PushSubsStack("OprSub (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,231);
if (RapidSub.canDelegate("oprsub")) { return __ref.runUserSub(false, "pywrapper","oprsub", __ref, _other);}
Debug.locals.put("Other", _other);
 BA.debugLineNum = 231;BA.debugLine="Public Sub OprSub (Other As Object) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 232;BA.debugLine="Return Run(\"__sub__\").Arg(Other)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__sub__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_other));
 BA.debugLineNum = 233;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _prepareargs(RemoteObject __ref,RemoteObject _args1,RemoteObject _kwargs) throws Exception{
try {
		Debug.PushSubsStack("PrepareArgs (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,99);
if (RapidSub.canDelegate("prepareargs")) { return __ref.runUserSub(false, "pywrapper","prepareargs", __ref, _args1, _kwargs);}
RemoteObject _a = RemoteObject.declareNull("b4j.example.pybridge._internalpymethodargs");
Debug.locals.put("Args1", _args1);
Debug.locals.put("KWArgs", _kwargs);
 BA.debugLineNum = 99;BA.debugLine="Private Sub PrepareArgs (Args1 As List, KWArgs As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 100;BA.debugLine="Dim a As InternalPyMethodArgs";
Debug.JustUpdateDeviceLine();
_a = RemoteObject.createNew ("b4j.example.pybridge._internalpymethodargs");Debug.locals.put("a", _a);
 BA.debugLineNum = 101;BA.debugLine="a.Initialize";
Debug.JustUpdateDeviceLine();
_a.runVoidMethod ("Initialize");
 BA.debugLineNum = 102;BA.debugLine="a.Args = B4XCollections.CreateList(Args1)";
Debug.JustUpdateDeviceLine();
_a.setField ("Args" /*RemoteObject*/ ,pywrapper._b4xcollections.runMethod(false,"_createlist" /*RemoteObject*/ ,(Object)(_args1)));
 BA.debugLineNum = 103;BA.debugLine="a.KWArgs = B4XCollections.MergeMaps(KWArgs, Null)";
Debug.JustUpdateDeviceLine();
_a.setField ("KWArgs" /*RemoteObject*/ ,pywrapper._b4xcollections.runMethod(false,"_mergemaps" /*RemoteObject*/ ,(Object)(_kwargs),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), pywrapper.__c.getField(false,"Null"))));
 BA.debugLineNum = 104;BA.debugLine="Return a";
Debug.JustUpdateDeviceLine();
if (true) return _a;
 BA.debugLineNum = 105;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _print(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Print (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,157);
if (RapidSub.canDelegate("print")) { return __ref.runUserSub(false, "pywrapper","print", __ref);}
 BA.debugLineNum = 157;BA.debugLine="Public Sub Print";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 158;BA.debugLine="Print2(\"\", \"\", False)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pywrapper.class, "_print2" /*RemoteObject*/ ,(Object)(BA.ObjectToString("")),(Object)(BA.ObjectToString("")),(Object)(pywrapper.__c.getField(true,"False")));
 BA.debugLineNum = 159;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _print2(RemoteObject __ref,RemoteObject _prefix,RemoteObject _suffix,RemoteObject _stderr) throws Exception{
try {
		Debug.PushSubsStack("Print2 (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,166);
if (RapidSub.canDelegate("print2")) { return __ref.runUserSub(false, "pywrapper","print2", __ref, _prefix, _suffix, _stderr);}
Debug.locals.put("Prefix", _prefix);
Debug.locals.put("Suffix", _suffix);
Debug.locals.put("StdErr", _stderr);
 BA.debugLineNum = 166;BA.debugLine="Public Sub Print2 (Prefix As String, Suffix As Str";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 167;BA.debugLine="If mFetched Then";
Debug.JustUpdateDeviceLine();
if (__ref.getField(true,"_mfetched" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 168;BA.debugLine="Log(mValue)";
Debug.JustUpdateDeviceLine();
pywrapper.__c.runVoidMethod ("LogImpl","97667714",BA.ObjectToString(__ref.getField(false,"_mvalue" /*RemoteObject*/ )),0);
 }else {
 BA.debugLineNum = 170;BA.debugLine="mBridge.PrintJoin(Array(Prefix, Me, Suffix), Std";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mbridge" /*RemoteObject*/ ).runClassMethod (b4j.example.pybridge.class, "_printjoin" /*RemoteObject*/ ,(Object)(pywrapper.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {3},new Object[] {(_prefix),__ref,(_suffix)})))),(Object)(_stderr));
 };
 BA.debugLineNum = 172;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _printerror(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("PrintError (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,161);
if (RapidSub.canDelegate("printerror")) { return __ref.runUserSub(false, "pywrapper","printerror", __ref);}
 BA.debugLineNum = 161;BA.debugLine="Public Sub PrintError";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 162;BA.debugLine="Print2(\"\", \"\", True)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pywrapper.class, "_print2" /*RemoteObject*/ ,(Object)(BA.ObjectToString("")),(Object)(BA.ObjectToString("")),(Object)(pywrapper.__c.getField(true,"True")));
 BA.debugLineNum = 163;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _run(RemoteObject __ref,RemoteObject _method) throws Exception{
try {
		Debug.PushSubsStack("Run (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,17);
if (RapidSub.canDelegate("run")) { return __ref.runUserSub(false, "pywrapper","run", __ref, _method);}
Debug.locals.put("Method", _method);
 BA.debugLineNum = 17;BA.debugLine="Public Sub Run(Method As String) As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 18;BA.debugLine="Return RunArgs(Method, Null, Null)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_runargs" /*RemoteObject*/ ,(Object)(_method),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), pywrapper.__c.getField(false,"Null")),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), pywrapper.__c.getField(false,"Null")));
 BA.debugLineNum = 19;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _runargs(RemoteObject __ref,RemoteObject _method,RemoteObject _positionalargs,RemoteObject _namedargs) throws Exception{
try {
		Debug.PushSubsStack("RunArgs (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,56);
if (RapidSub.canDelegate("runargs")) { return __ref.runUserSub(false, "pywrapper","runargs", __ref, _method, _positionalargs, _namedargs);}
RemoteObject _a = RemoteObject.declareNull("b4j.example.pybridge._internalpymethodargs");
RemoteObject _py = RemoteObject.declareNull("b4j.example.pybridge._pyobject");
RemoteObject _w = RemoteObject.declareNull("b4j.example.pywrapper");
Debug.locals.put("Method", _method);
Debug.locals.put("PositionalArgs", _positionalargs);
Debug.locals.put("NamedArgs", _namedargs);
 BA.debugLineNum = 56;BA.debugLine="Public Sub RunArgs (Method As String, PositionalAr";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 57;BA.debugLine="Dim a As InternalPyMethodArgs = PrepareArgs(Posit";
Debug.JustUpdateDeviceLine();
_a = __ref.runClassMethod (b4j.example.pywrapper.class, "_prepareargs" /*RemoteObject*/ ,(Object)(_positionalargs),(Object)(_namedargs));Debug.locals.put("a", _a);Debug.locals.put("a", _a);
 BA.debugLineNum = 58;BA.debugLine="Dim py As PyObject = mBridge.Utils.run(InternalKe";
Debug.JustUpdateDeviceLine();
_py = __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_run" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_internalkey" /*RemoteObject*/ )),(Object)(_method),(Object)(_a));Debug.locals.put("py", _py);Debug.locals.put("py", _py);
 BA.debugLineNum = 59;BA.debugLine="Dim w As PyWrapper";
Debug.JustUpdateDeviceLine();
_w = RemoteObject.createNew ("b4j.example.pywrapper");Debug.locals.put("w", _w);
 BA.debugLineNum = 60;BA.debugLine="w.Initialize(mBridge, py)";
Debug.JustUpdateDeviceLine();
_w.runClassMethod (b4j.example.pywrapper.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ )),(Object)(_py));
 BA.debugLineNum = 61;BA.debugLine="w.LastArgs = a";
Debug.JustUpdateDeviceLine();
_w.setField ("_lastargs" /*RemoteObject*/ ,_a);
 BA.debugLineNum = 62;BA.debugLine="a.Task = mBridge.Utils.Comm.BufferedTasks.Get(mBr";
Debug.JustUpdateDeviceLine();
_a.setField ("Task" /*RemoteObject*/ ,(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).getField(false,"_comm" /*RemoteObject*/ ).getField(false,"_bufferedtasks" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).getField(false,"_comm" /*RemoteObject*/ ).getField(false,"_bufferedtasks" /*RemoteObject*/ ).runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1)))));
 BA.debugLineNum = 63;BA.debugLine="Return w";
Debug.JustUpdateDeviceLine();
if (true) return _w;
 BA.debugLineNum = 64;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _runawait(RemoteObject __ref,RemoteObject _method,RemoteObject _positionalargs,RemoteObject _namedargs) throws Exception{
try {
		Debug.PushSubsStack("RunAwait (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,109);
if (RapidSub.canDelegate("runawait")) { return __ref.runUserSub(false, "pywrapper","runawait", __ref, _method, _positionalargs, _namedargs);}
ResumableSub_RunAwait rsub = new ResumableSub_RunAwait(null,__ref,_method,_positionalargs,_namedargs);
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
public static class ResumableSub_RunAwait extends BA.ResumableSub {
public ResumableSub_RunAwait(b4j.example.pywrapper parent,RemoteObject __ref,RemoteObject _method,RemoteObject _positionalargs,RemoteObject _namedargs) {
this.parent = parent;
this.__ref = __ref;
this._method = _method;
this._positionalargs = _positionalargs;
this._namedargs = _namedargs;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.pywrapper parent;
RemoteObject _method;
RemoteObject _positionalargs;
RemoteObject _namedargs;
RemoteObject _a = RemoteObject.declareNull("b4j.example.pybridge._internalpymethodargs");
RemoteObject _result = RemoteObject.declareNull("b4j.example.pybridge._internalpytaskasyncresult");

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("RunAwait (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,109);
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
Debug.locals.put("Method", _method);
Debug.locals.put("PositionalArgs", _positionalargs);
Debug.locals.put("NamedArgs", _namedargs);
 BA.debugLineNum = 110;BA.debugLine="Dim a As InternalPyMethodArgs = PrepareArgs(Posit";
Debug.JustUpdateDeviceLine();
_a = __ref.runClassMethod (b4j.example.pywrapper.class, "_prepareargs" /*RemoteObject*/ ,(Object)(_positionalargs),(Object)(_namedargs));Debug.locals.put("a", _a);Debug.locals.put("a", _a);
 BA.debugLineNum = 111;BA.debugLine="Wait For (mBridge.Utils.RunAsync(InternalKey, Met";
Debug.JustUpdateDeviceLine();
parent.__c.runVoidMethod ("WaitFor","complete", __ref.getField(false, "ba"), anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "pywrapper", "runawait"), __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_runasync" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_internalkey" /*RemoteObject*/ )),(Object)(_method),(Object)(_a)));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_result = (RemoteObject) result.getArrayElement(false,RemoteObject.createImmutable(1));Debug.locals.put("Result", _result);
;
 BA.debugLineNum = 112;BA.debugLine="Return Wrap(Result)";
Debug.JustUpdateDeviceLine();
if (true) {
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,(__ref.runClassMethod (b4j.example.pywrapper.class, "_wrap" /*RemoteObject*/ ,(Object)(_result))));return;};
 BA.debugLineNum = 113;BA.debugLine="End Sub";
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
public static RemoteObject  _set(RemoteObject __ref,RemoteObject _key,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("Set (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,191);
if (RapidSub.canDelegate("set")) { return __ref.runUserSub(false, "pywrapper","set", __ref, _key, _value);}
Debug.locals.put("Key", _key);
Debug.locals.put("Value", _value);
 BA.debugLineNum = 191;BA.debugLine="Public Sub Set(Key As Object, Value As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 192;BA.debugLine="Run(\"__setitem__\").Arg(mBridge.Utils.ConvertToInt";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("__setitem__"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_converttointifmatch" /*RemoteObject*/ ,(Object)(_key)))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(_value));
 BA.debugLineNum = 193;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setfield(RemoteObject __ref,RemoteObject _field,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("SetField (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,95);
if (RapidSub.canDelegate("setfield")) { return __ref.runUserSub(false, "pywrapper","setfield", __ref, _field, _value);}
Debug.locals.put("Field", _field);
Debug.locals.put("Value", _value);
 BA.debugLineNum = 95;BA.debugLine="Public Sub SetField(Field As String, Value As Obje";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 96;BA.debugLine="mBridge.Builtins.RunArgs(\"setattr\", Array(Interna";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_runargs" /*RemoteObject*/ ,(Object)(BA.ObjectToString("setattr")),(Object)(pywrapper.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {3},new Object[] {(__ref.getField(false,"_internalkey" /*RemoteObject*/ )),(_field),_value})))),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), pywrapper.__c.getField(false,"Null")));
 BA.debugLineNum = 97;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _shape(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Shape (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,221);
if (RapidSub.canDelegate("shape")) { return __ref.runUserSub(false, "pywrapper","shape", __ref);}
 BA.debugLineNum = 221;BA.debugLine="Public Sub Shape As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 222;BA.debugLine="Return GetField(\"shape\")";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.pywrapper.class, "_getfield" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("shape")));
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
public static RemoteObject  _str(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Str (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,206);
if (RapidSub.canDelegate("str")) { return __ref.runUserSub(false, "pywrapper","str", __ref);}
 BA.debugLineNum = 206;BA.debugLine="Public Sub Str As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 207;BA.debugLine="Return mBridge.Builtins.Run(\"str\").Arg(InternalKe";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("str"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_internalkey" /*RemoteObject*/ ))));
 BA.debugLineNum = 208;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _toarray(RemoteObject __ref,RemoteObject _length) throws Exception{
try {
		Debug.PushSubsStack("ToArray (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,67);
if (RapidSub.canDelegate("toarray")) { return __ref.runUserSub(false, "pywrapper","toarray", __ref, _length);}
RemoteObject _res = null;
int _i = 0;
RemoteObject _w = RemoteObject.declareNull("b4j.example.pywrapper");
RemoteObject _start = RemoteObject.createImmutable(0);
RemoteObject _p = RemoteObject.declareNull("b4j.example.pywrapper");
Debug.locals.put("Length", _length);
 BA.debugLineNum = 67;BA.debugLine="Public Sub ToArray (Length As Int) As PyWrapper()";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 68;BA.debugLine="Dim res(Length) As PyWrapper";
Debug.JustUpdateDeviceLine();
_res = RemoteObject.createNewArray ("b4j.example.pywrapper", new int[] {_length.<Integer>get().intValue()}, new Object[]{});Debug.locals.put("res", _res);
 BA.debugLineNum = 69;BA.debugLine="If Length = 0 Then Return res";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_length,BA.numberCast(double.class, 0))) { 
if (true) return _res;};
 BA.debugLineNum = 70;BA.debugLine="For i = 0 To Length - 2";
Debug.JustUpdateDeviceLine();
{
final int step3 = 1;
final int limit3 = RemoteObject.solve(new RemoteObject[] {_length,RemoteObject.createImmutable(2)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step3 > 0 && _i <= limit3) || (step3 < 0 && _i >= limit3) ;_i = ((int)(0 + _i + step3))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 71;BA.debugLine="Dim w As PyWrapper";
Debug.JustUpdateDeviceLine();
_w = RemoteObject.createNew ("b4j.example.pywrapper");Debug.locals.put("w", _w);
 BA.debugLineNum = 72;BA.debugLine="w.Initialize(mBridge, mBridge.Utils.CreatePyObje";
Debug.JustUpdateDeviceLine();
_w.runClassMethod (b4j.example.pywrapper.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ )),(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).runClassMethod (b4j.example.pyutils.class, "_createpyobject" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 0)))));
 BA.debugLineNum = 73;BA.debugLine="res(i) = w";
Debug.JustUpdateDeviceLine();
_res.setArrayElement ( /*RemoteObject*/ _w,BA.numberCast(int.class, _i));
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 75;BA.debugLine="Dim Start As Int = IIf(Length = 1, mBridge.Utils.";
Debug.JustUpdateDeviceLine();
_start = BA.numberCast(int.class, ((RemoteObject.solveBoolean("=",_length,BA.numberCast(double.class, 1))) ? ((RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_utils" /*RemoteObject*/ ).getField(true,"_pyobjectcounter" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "+",1, 1))) : ((_res.getArrayElement(false, /*RemoteObject*/ BA.numberCast(int.class, 0)).getField(false,"_internalkey" /*RemoteObject*/ ).getField(true,"Key" /*RemoteObject*/ )))));Debug.locals.put("Start", _start);Debug.locals.put("Start", _start);
 BA.debugLineNum = 76;BA.debugLine="Dim p As PyWrapper = mBridge.Bridge.RunArgs(\"to_a";
Debug.JustUpdateDeviceLine();
_p = __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_bridge" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_runargs" /*RemoteObject*/ ,(Object)(BA.ObjectToString("to_array")),(Object)(pywrapper.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {3},new Object[] {__ref,(_start),(_length)})))),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), pywrapper.__c.getField(false,"Null")));Debug.locals.put("p", _p);Debug.locals.put("p", _p);
 BA.debugLineNum = 77;BA.debugLine="res(Length - 1) = p";
Debug.JustUpdateDeviceLine();
_res.setArrayElement ( /*RemoteObject*/ _p,RemoteObject.solve(new RemoteObject[] {_length,RemoteObject.createImmutable(1)}, "-",1, 1));
 BA.debugLineNum = 78;BA.debugLine="Return res";
Debug.JustUpdateDeviceLine();
if (true) return _res;
 BA.debugLineNum = 79;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _tolist(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("ToList (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,299);
if (RapidSub.canDelegate("tolist")) { return __ref.runUserSub(false, "pywrapper","tolist", __ref);}
 BA.debugLineNum = 299;BA.debugLine="Public Sub ToList As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 300;BA.debugLine="Return mBridge.Builtins.Run(\"list\").Arg(Me)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("list"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)(__ref));
 BA.debugLineNum = 301;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _typeof(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("TypeOf (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,211);
if (RapidSub.canDelegate("typeof")) { return __ref.runUserSub(false, "pywrapper","typeof", __ref);}
 BA.debugLineNum = 211;BA.debugLine="Public Sub TypeOf As PyWrapper";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 212;BA.debugLine="Return mBridge.Builtins.Run(\"type\").Arg(InternalK";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_mbridge" /*RemoteObject*/ ).getField(false,"_builtins" /*RemoteObject*/ ).runClassMethod (b4j.example.pywrapper.class, "_run" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("type"))).runClassMethod (b4j.example.pywrapper.class, "_arg" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_internalkey" /*RemoteObject*/ ))));
 BA.debugLineNum = 213;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _wrap(RemoteObject __ref,RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Wrap (pywrapper) ","pywrapper",8,__ref.getField(false, "ba"),__ref,115);
if (RapidSub.canDelegate("wrap")) { return __ref.runUserSub(false, "pywrapper","wrap", __ref, _result);}
RemoteObject _w = RemoteObject.declareNull("b4j.example.pywrapper");
RemoteObject _key = RemoteObject.declareNull("b4j.example.pybridge._pyobject");
RemoteObject _error = RemoteObject.createImmutable(false);
RemoteObject _value = RemoteObject.declareNull("Object");
Debug.locals.put("Result", _result);
 BA.debugLineNum = 115;BA.debugLine="Private Sub Wrap (Result As InternalPyTaskAsyncRes";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 116;BA.debugLine="Dim w As PyWrapper";
Debug.JustUpdateDeviceLine();
_w = RemoteObject.createNew ("b4j.example.pywrapper");Debug.locals.put("w", _w);
 BA.debugLineNum = 117;BA.debugLine="Dim key As PyObject = Result.PyObject";
Debug.JustUpdateDeviceLine();
_key = _result.getField(false,"PyObject" /*RemoteObject*/ );Debug.locals.put("key", _key);Debug.locals.put("key", _key);
 BA.debugLineNum = 118;BA.debugLine="Dim error As Boolean = Result.Error";
Debug.JustUpdateDeviceLine();
_error = _result.getField(true,"Error" /*RemoteObject*/ );Debug.locals.put("error", _error);Debug.locals.put("error", _error);
 BA.debugLineNum = 119;BA.debugLine="Dim value As Object = Result.Value";
Debug.JustUpdateDeviceLine();
_value = _result.getField(false,"Value" /*RemoteObject*/ );Debug.locals.put("value", _value);Debug.locals.put("value", _value);
 BA.debugLineNum = 120;BA.debugLine="w.Initialize(mBridge, key)";
Debug.JustUpdateDeviceLine();
_w.runClassMethod (b4j.example.pywrapper.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mbridge" /*RemoteObject*/ )),(Object)(_key));
 BA.debugLineNum = 121;BA.debugLine="w.mError = error";
Debug.JustUpdateDeviceLine();
_w.setField ("_merror" /*RemoteObject*/ ,_error);
 BA.debugLineNum = 122;BA.debugLine="w.mValue = value";
Debug.JustUpdateDeviceLine();
_w.setField ("_mvalue" /*RemoteObject*/ ,_value);
 BA.debugLineNum = 123;BA.debugLine="w.mFetched = True";
Debug.JustUpdateDeviceLine();
_w.setField ("_mfetched" /*RemoteObject*/ ,pywrapper.__c.getField(true,"True"));
 BA.debugLineNum = 124;BA.debugLine="Return w";
Debug.JustUpdateDeviceLine();
if (true) return _w;
 BA.debugLineNum = 125;BA.debugLine="End Sub";
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