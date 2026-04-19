package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class pywrapper extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.pywrapper", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.pywrapper.class).invoke(this, new Object[] {null});
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
public b4j.example.pybridge._pyobject _internalkey = null;
public b4j.example.pybridge _mbridge = null;
public boolean _mfetched = false;
public boolean _merror = false;
public Object _mvalue = null;
public b4j.example.pybridge._internalpymethodargs _lastargs = null;
public b4j.example.main _main = null;
public b4j.example.b4xcollections _b4xcollections = null;
public b4j.example.pywrapper  _run(b4j.example.pywrapper __ref,String _method) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "run", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "run", new Object[] {_method}));}
RDebugUtils.currentLine=6291456;
 //BA.debugLineNum = 6291456;BA.debugLine="Public Sub Run(Method As String) As PyWrapper";
RDebugUtils.currentLine=6291457;
 //BA.debugLineNum = 6291457;BA.debugLine="Return RunArgs(Method, Null, Null)";
if (true) return __ref._runargs /*b4j.example.pywrapper*/ (null,_method,(anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(__c.Null)),(anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(__c.Null)));
RDebugUtils.currentLine=6291458;
 //BA.debugLineNum = 6291458;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _arg(b4j.example.pywrapper __ref,Object _parameter) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "arg", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "arg", new Object[] {_parameter}));}
RDebugUtils.currentLine=6553600;
 //BA.debugLineNum = 6553600;BA.debugLine="Public Sub Arg(Parameter As Object) As PyWrapper";
RDebugUtils.currentLine=6553601;
 //BA.debugLineNum = 6553601;BA.debugLine="LastArgs.Args.Add(Parameter)";
__ref._lastargs /*b4j.example.pybridge._internalpymethodargs*/ .Args /*anywheresoftware.b4a.objects.collections.List*/ .Add(_parameter);
RDebugUtils.currentLine=6553602;
 //BA.debugLineNum = 6553602;BA.debugLine="Return AfterArg";
if (true) return __ref._afterarg /*b4j.example.pywrapper*/ (null);
RDebugUtils.currentLine=6553603;
 //BA.debugLineNum = 6553603;BA.debugLine="End Sub";
return null;
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _fetch(b4j.example.pywrapper __ref) throws Exception{
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "fetch", true))
	 {return ((anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) Debug.delegate(ba, "fetch", null));}
ResumableSub_Fetch rsub = new ResumableSub_Fetch(this,__ref);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_Fetch extends BA.ResumableSub {
public ResumableSub_Fetch(b4j.example.pywrapper parent,b4j.example.pywrapper __ref) {
this.parent = parent;
this.__ref = __ref;
this.__ref = parent;
}
b4j.example.pywrapper __ref;
b4j.example.pywrapper parent;
b4j.example.pybridge._internalpytaskasyncresult _result = null;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="pywrapper";

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.ReturnFromResumableSub(this,null);return;}
case 0:
//C
this.state = -1;
RDebugUtils.currentLine=6881281;
 //BA.debugLineNum = 6881281;BA.debugLine="Wait For (mBridge.Utils.Fetch(InternalKey)) Compl";
parent.__c.WaitFor("complete", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pywrapper", "fetch"), __ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._fetch /*anywheresoftware.b4a.keywords.Common.ResumableSubWrapper*/ (null,__ref._internalkey /*b4j.example.pybridge._pyobject*/ ));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_result = (b4j.example.pybridge._internalpytaskasyncresult) result[1];
;
RDebugUtils.currentLine=6881282;
 //BA.debugLineNum = 6881282;BA.debugLine="Return Wrap(Result)";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(__ref._wrap /*b4j.example.pywrapper*/ (null,_result)));return;};
RDebugUtils.currentLine=6881283;
 //BA.debugLineNum = 6881283;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public Object  _getvalue(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "getvalue", true))
	 {return ((Object) Debug.delegate(ba, "getvalue", null));}
RDebugUtils.currentLine=7274496;
 //BA.debugLineNum = 7274496;BA.debugLine="Public Sub getValue As Object";
RDebugUtils.currentLine=7274497;
 //BA.debugLineNum = 7274497;BA.debugLine="If mError Then";
if (__ref._merror /*boolean*/ ) { 
RDebugUtils.currentLine=7274498;
 //BA.debugLineNum = 7274498;BA.debugLine="Me.As(JavaObject).RunMethod(\"raiseError\", Array(";
((anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(this))).RunMethod("raiseError",new Object[]{__ref._mvalue /*Object*/ });
 };
RDebugUtils.currentLine=7274500;
 //BA.debugLineNum = 7274500;BA.debugLine="If mFetched = False Then";
if (__ref._mfetched /*boolean*/ ==__c.False) { 
RDebugUtils.currentLine=7274501;
 //BA.debugLineNum = 7274501;BA.debugLine="Me.As(JavaObject).RunMethod(\"raiseError\", Array(";
((anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(this))).RunMethod("raiseError",new Object[]{(Object)("Value not fetched")});
 };
RDebugUtils.currentLine=7274503;
 //BA.debugLineNum = 7274503;BA.debugLine="Return mValue";
if (true) return __ref._mvalue /*Object*/ ;
RDebugUtils.currentLine=7274504;
 //BA.debugLineNum = 7274504;BA.debugLine="End Sub";
return null;
}
public String  _initialize(b4j.example.pywrapper __ref,anywheresoftware.b4a.BA _ba,b4j.example.pybridge _bridge,b4j.example.pybridge._pyobject _key) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "initialize", true))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba,_bridge,_key}));}
RDebugUtils.currentLine=6225920;
 //BA.debugLineNum = 6225920;BA.debugLine="Public Sub Initialize (Bridge As PyBridge, Key As";
RDebugUtils.currentLine=6225921;
 //BA.debugLineNum = 6225921;BA.debugLine="InternalKey = Key";
__ref._internalkey /*b4j.example.pybridge._pyobject*/  = _key;
RDebugUtils.currentLine=6225922;
 //BA.debugLineNum = 6225922;BA.debugLine="mBridge = Bridge";
__ref._mbridge /*b4j.example.pybridge*/  = _bridge;
RDebugUtils.currentLine=6225923;
 //BA.debugLineNum = 6225923;BA.debugLine="End Sub";
return "";
}
public b4j.example.pywrapper  _get(b4j.example.pywrapper __ref,Object _key) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "get", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "get", new Object[] {_key}));}
RDebugUtils.currentLine=7733248;
 //BA.debugLineNum = 7733248;BA.debugLine="Public Sub Get (Key As Object) As PyWrapper";
RDebugUtils.currentLine=7733249;
 //BA.debugLineNum = 7733249;BA.debugLine="Return Run(\"__getitem__\").Arg(mBridge.Utils.Conve";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__getitem__")._arg /*b4j.example.pywrapper*/ (null,__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._converttointifmatch /*Object*/ (null,_key));
RDebugUtils.currentLine=7733250;
 //BA.debugLineNum = 7733250;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _getfield(b4j.example.pywrapper __ref,String _field) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "getfield", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "getfield", new Object[] {_field}));}
RDebugUtils.currentLine=6946816;
 //BA.debugLineNum = 6946816;BA.debugLine="Public Sub GetField (Field As String) As PyWrapper";
RDebugUtils.currentLine=6946817;
 //BA.debugLineNum = 6946817;BA.debugLine="Return mBridge.Builtins.RunArgs(\"getattr\", Array(";
if (true) return __ref._mbridge /*b4j.example.pybridge*/ ._builtins /*b4j.example.pywrapper*/ ._runargs /*b4j.example.pywrapper*/ (null,"getattr",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(__ref._internalkey /*b4j.example.pybridge._pyobject*/ ),(Object)(_field)}),(anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(__c.Null)));
RDebugUtils.currentLine=6946818;
 //BA.debugLineNum = 6946818;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _call(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "call", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "call", null));}
RDebugUtils.currentLine=6356992;
 //BA.debugLineNum = 6356992;BA.debugLine="Public Sub Call As PyWrapper";
RDebugUtils.currentLine=6356993;
 //BA.debugLineNum = 6356993;BA.debugLine="Return Run(\"__call__\")";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__call__");
RDebugUtils.currentLine=6356994;
 //BA.debugLineNum = 6356994;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _args(b4j.example.pywrapper __ref,anywheresoftware.b4a.objects.collections.List _parameters) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "args", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "args", new Object[] {_parameters}));}
RDebugUtils.currentLine=6422528;
 //BA.debugLineNum = 6422528;BA.debugLine="Public Sub Args(Parameters As List) As PyWrapper";
RDebugUtils.currentLine=6422529;
 //BA.debugLineNum = 6422529;BA.debugLine="LastArgs.Args.AddAll(Parameters)";
__ref._lastargs /*b4j.example.pybridge._internalpymethodargs*/ .Args /*anywheresoftware.b4a.objects.collections.List*/ .AddAll(_parameters);
RDebugUtils.currentLine=6422530;
 //BA.debugLineNum = 6422530;BA.debugLine="Return AfterArg";
if (true) return __ref._afterarg /*b4j.example.pywrapper*/ (null);
RDebugUtils.currentLine=6422531;
 //BA.debugLineNum = 6422531;BA.debugLine="End Sub";
return null;
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _runawait(b4j.example.pywrapper __ref,String _method,anywheresoftware.b4a.objects.collections.List _positionalargs,anywheresoftware.b4a.objects.collections.Map _namedargs) throws Exception{
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "runawait", true))
	 {return ((anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) Debug.delegate(ba, "runawait", new Object[] {_method,_positionalargs,_namedargs}));}
ResumableSub_RunAwait rsub = new ResumableSub_RunAwait(this,__ref,_method,_positionalargs,_namedargs);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_RunAwait extends BA.ResumableSub {
public ResumableSub_RunAwait(b4j.example.pywrapper parent,b4j.example.pywrapper __ref,String _method,anywheresoftware.b4a.objects.collections.List _positionalargs,anywheresoftware.b4a.objects.collections.Map _namedargs) {
this.parent = parent;
this.__ref = __ref;
this._method = _method;
this._positionalargs = _positionalargs;
this._namedargs = _namedargs;
this.__ref = parent;
}
b4j.example.pywrapper __ref;
b4j.example.pywrapper parent;
String _method;
anywheresoftware.b4a.objects.collections.List _positionalargs;
anywheresoftware.b4a.objects.collections.Map _namedargs;
b4j.example.pybridge._internalpymethodargs _a = null;
b4j.example.pybridge._internalpytaskasyncresult _result = null;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="pywrapper";

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.ReturnFromResumableSub(this,null);return;}
case 0:
//C
this.state = -1;
RDebugUtils.currentLine=7143425;
 //BA.debugLineNum = 7143425;BA.debugLine="Dim a As InternalPyMethodArgs = PrepareArgs(Posit";
_a = __ref._prepareargs /*b4j.example.pybridge._internalpymethodargs*/ (null,_positionalargs,_namedargs);
RDebugUtils.currentLine=7143426;
 //BA.debugLineNum = 7143426;BA.debugLine="Wait For (mBridge.Utils.RunAsync(InternalKey, Met";
parent.__c.WaitFor("complete", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pywrapper", "runawait"), __ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._runasync /*anywheresoftware.b4a.keywords.Common.ResumableSubWrapper*/ (null,__ref._internalkey /*b4j.example.pybridge._pyobject*/ ,_method,_a));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_result = (b4j.example.pybridge._internalpytaskasyncresult) result[1];
;
RDebugUtils.currentLine=7143427;
 //BA.debugLineNum = 7143427;BA.debugLine="Return Wrap(Result)";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(__ref._wrap /*b4j.example.pywrapper*/ (null,_result)));return;};
RDebugUtils.currentLine=7143428;
 //BA.debugLineNum = 7143428;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public b4j.example.pywrapper  _runargs(b4j.example.pywrapper __ref,String _method,anywheresoftware.b4a.objects.collections.List _positionalargs,anywheresoftware.b4a.objects.collections.Map _namedargs) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "runargs", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "runargs", new Object[] {_method,_positionalargs,_namedargs}));}
b4j.example.pybridge._internalpymethodargs _a = null;
b4j.example.pybridge._pyobject _py = null;
b4j.example.pywrapper _w = null;
RDebugUtils.currentLine=6750208;
 //BA.debugLineNum = 6750208;BA.debugLine="Public Sub RunArgs (Method As String, PositionalAr";
RDebugUtils.currentLine=6750209;
 //BA.debugLineNum = 6750209;BA.debugLine="Dim a As InternalPyMethodArgs = PrepareArgs(Posit";
_a = __ref._prepareargs /*b4j.example.pybridge._internalpymethodargs*/ (null,_positionalargs,_namedargs);
RDebugUtils.currentLine=6750210;
 //BA.debugLineNum = 6750210;BA.debugLine="Dim py As PyObject = mBridge.Utils.run(InternalKe";
_py = __ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._run /*b4j.example.pybridge._pyobject*/ (null,__ref._internalkey /*b4j.example.pybridge._pyobject*/ ,_method,_a);
RDebugUtils.currentLine=6750211;
 //BA.debugLineNum = 6750211;BA.debugLine="Dim w As PyWrapper";
_w = new b4j.example.pywrapper();
RDebugUtils.currentLine=6750212;
 //BA.debugLineNum = 6750212;BA.debugLine="w.Initialize(mBridge, py)";
_w._initialize /*String*/ (null,ba,__ref._mbridge /*b4j.example.pybridge*/ ,_py);
RDebugUtils.currentLine=6750213;
 //BA.debugLineNum = 6750213;BA.debugLine="w.LastArgs = a";
_w._lastargs /*b4j.example.pybridge._internalpymethodargs*/  = _a;
RDebugUtils.currentLine=6750214;
 //BA.debugLineNum = 6750214;BA.debugLine="a.Task = mBridge.Utils.Comm.BufferedTasks.Get(mBr";
_a.Task /*b4j.example.pybridge._pytask*/  = (b4j.example.pybridge._pytask)(__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._comm /*b4j.example.pycomm*/ ._bufferedtasks /*anywheresoftware.b4a.objects.collections.List*/ .Get((int) (__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._comm /*b4j.example.pycomm*/ ._bufferedtasks /*anywheresoftware.b4a.objects.collections.List*/ .getSize()-1)));
RDebugUtils.currentLine=6750215;
 //BA.debugLineNum = 6750215;BA.debugLine="Return w";
if (true) return _w;
RDebugUtils.currentLine=6750216;
 //BA.debugLineNum = 6750216;BA.debugLine="End Sub";
return null;
}
public String  _set(b4j.example.pywrapper __ref,Object _key,Object _value) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "set", true))
	 {return ((String) Debug.delegate(ba, "set", new Object[] {_key,_value}));}
RDebugUtils.currentLine=7929856;
 //BA.debugLineNum = 7929856;BA.debugLine="Public Sub Set(Key As Object, Value As Object)";
RDebugUtils.currentLine=7929857;
 //BA.debugLineNum = 7929857;BA.debugLine="Run(\"__setitem__\").Arg(mBridge.Utils.ConvertToInt";
__ref._run /*b4j.example.pywrapper*/ (null,"__setitem__")._arg /*b4j.example.pywrapper*/ (null,__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._converttointifmatch /*Object*/ (null,_key))._arg /*b4j.example.pywrapper*/ (null,_value);
RDebugUtils.currentLine=7929858;
 //BA.debugLineNum = 7929858;BA.debugLine="End Sub";
return "";
}
public b4j.example.pywrapper  _afterarg(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "afterarg", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "afterarg", null));}
RDebugUtils.currentLine=6488064;
 //BA.debugLineNum = 6488064;BA.debugLine="Private Sub AfterArg As PyWrapper";
RDebugUtils.currentLine=6488065;
 //BA.debugLineNum = 6488065;BA.debugLine="mBridge.Utils.Comm.MoveTaskToLast(LastArgs.Task)";
__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._comm /*b4j.example.pycomm*/ ._movetasktolast /*String*/ (null,__ref._lastargs /*b4j.example.pybridge._internalpymethodargs*/ .Task /*b4j.example.pybridge._pytask*/ );
RDebugUtils.currentLine=6488066;
 //BA.debugLineNum = 6488066;BA.debugLine="Return Me";
if (true) return (b4j.example.pywrapper)(this);
RDebugUtils.currentLine=6488067;
 //BA.debugLineNum = 6488067;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _argnamed(b4j.example.pywrapper __ref,String _name,Object _parameter) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "argnamed", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "argnamed", new Object[] {_name,_parameter}));}
RDebugUtils.currentLine=6619136;
 //BA.debugLineNum = 6619136;BA.debugLine="Public Sub ArgNamed (Name As String, Parameter As";
RDebugUtils.currentLine=6619137;
 //BA.debugLineNum = 6619137;BA.debugLine="LastArgs.KWArgs.Put(Name, Parameter)";
__ref._lastargs /*b4j.example.pybridge._internalpymethodargs*/ .KWArgs /*anywheresoftware.b4a.objects.collections.Map*/ .Put((Object)(_name),_parameter);
RDebugUtils.currentLine=6619138;
 //BA.debugLineNum = 6619138;BA.debugLine="Return AfterArg";
if (true) return __ref._afterarg /*b4j.example.pywrapper*/ (null);
RDebugUtils.currentLine=6619139;
 //BA.debugLineNum = 6619139;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _argsnamed(b4j.example.pywrapper __ref,anywheresoftware.b4a.objects.collections.Map _parameters) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "argsnamed", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "argsnamed", new Object[] {_parameters}));}
String _k = "";
RDebugUtils.currentLine=6684672;
 //BA.debugLineNum = 6684672;BA.debugLine="Public Sub ArgsNamed (Parameters As Map) As PyWrap";
RDebugUtils.currentLine=6684673;
 //BA.debugLineNum = 6684673;BA.debugLine="For Each k As String In Parameters.Keys";
{
final anywheresoftware.b4a.BA.IterableList group1 = _parameters.Keys();
final int groupLen1 = group1.getSize()
;int index1 = 0;
;
for (; index1 < groupLen1;index1++){
_k = BA.ObjectToString(group1.Get(index1));
RDebugUtils.currentLine=6684674;
 //BA.debugLineNum = 6684674;BA.debugLine="LastArgs.KWArgs.Put(k, Parameters.Get(k))";
__ref._lastargs /*b4j.example.pybridge._internalpymethodargs*/ .KWArgs /*anywheresoftware.b4a.objects.collections.Map*/ .Put((Object)(_k),_parameters.Get((Object)(_k)));
 }
};
RDebugUtils.currentLine=6684676;
 //BA.debugLineNum = 6684676;BA.debugLine="Return AfterArg";
if (true) return __ref._afterarg /*b4j.example.pywrapper*/ (null);
RDebugUtils.currentLine=6684677;
 //BA.debugLineNum = 6684677;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _asfloat(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "asfloat", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "asfloat", null));}
RDebugUtils.currentLine=8716288;
 //BA.debugLineNum = 8716288;BA.debugLine="Public Sub AsFloat As PyWrapper";
RDebugUtils.currentLine=8716289;
 //BA.debugLineNum = 8716289;BA.debugLine="Return mBridge.Builtins.Run(\"float\").Arg(Internal";
if (true) return __ref._mbridge /*b4j.example.pybridge*/ ._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"float")._arg /*b4j.example.pywrapper*/ (null,(Object)(__ref._internalkey /*b4j.example.pybridge._pyobject*/ ));
RDebugUtils.currentLine=8716290;
 //BA.debugLineNum = 8716290;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _asint(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "asint", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "asint", null));}
RDebugUtils.currentLine=8781824;
 //BA.debugLineNum = 8781824;BA.debugLine="Public Sub AsInt As PyWrapper";
RDebugUtils.currentLine=8781825;
 //BA.debugLineNum = 8781825;BA.debugLine="Return mBridge.Builtins.Run(\"int\").Arg(Me)";
if (true) return __ref._mbridge /*b4j.example.pybridge*/ ._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"int")._arg /*b4j.example.pywrapper*/ (null,this);
RDebugUtils.currentLine=8781826;
 //BA.debugLineNum = 8781826;BA.debugLine="End Sub";
return null;
}
public String  _class_globals(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
RDebugUtils.currentLine=6160384;
 //BA.debugLineNum = 6160384;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=6160385;
 //BA.debugLineNum = 6160385;BA.debugLine="Public InternalKey As PyObject";
_internalkey = new b4j.example.pybridge._pyobject();
RDebugUtils.currentLine=6160386;
 //BA.debugLineNum = 6160386;BA.debugLine="Private mBridge As PyBridge";
_mbridge = new b4j.example.pybridge();
RDebugUtils.currentLine=6160387;
 //BA.debugLineNum = 6160387;BA.debugLine="Private mFetched As Boolean";
_mfetched = false;
RDebugUtils.currentLine=6160388;
 //BA.debugLineNum = 6160388;BA.debugLine="Private mError As Boolean";
_merror = false;
RDebugUtils.currentLine=6160389;
 //BA.debugLineNum = 6160389;BA.debugLine="Private mValue As Object";
_mvalue = new Object();
RDebugUtils.currentLine=6160390;
 //BA.debugLineNum = 6160390;BA.debugLine="Private LastArgs As InternalPyMethodArgs";
_lastargs = new b4j.example.pybridge._internalpymethodargs();
RDebugUtils.currentLine=6160391;
 //BA.debugLineNum = 6160391;BA.debugLine="End Sub";
return "";
}
public b4j.example.pywrapper  _contains(b4j.example.pywrapper __ref,Object _item) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "contains", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "contains", new Object[] {_item}));}
RDebugUtils.currentLine=8060928;
 //BA.debugLineNum = 8060928;BA.debugLine="Public Sub Contains(Item As Object) As PyWrapper";
RDebugUtils.currentLine=8060929;
 //BA.debugLineNum = 8060929;BA.debugLine="Return Run(\"__contains__\").Arg(mBridge.Utils.Conv";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__contains__")._arg /*b4j.example.pywrapper*/ (null,__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._converttointifmatch /*Object*/ (null,_item));
RDebugUtils.currentLine=8060930;
 //BA.debugLineNum = 8060930;BA.debugLine="End Sub";
return null;
}
public String  _delitem(b4j.example.pywrapper __ref,Object _key,Object _value) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "delitem", true))
	 {return ((String) Debug.delegate(ba, "delitem", new Object[] {_key,_value}));}
RDebugUtils.currentLine=7995392;
 //BA.debugLineNum = 7995392;BA.debugLine="Public Sub DelItem(Key As Object, Value As Object)";
RDebugUtils.currentLine=7995393;
 //BA.debugLineNum = 7995393;BA.debugLine="Run(\"__detitem__\").Arg(mBridge.Utils.ConvertToInt";
__ref._run /*b4j.example.pywrapper*/ (null,"__detitem__")._arg /*b4j.example.pywrapper*/ (null,__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._converttointifmatch /*Object*/ (null,_key))._arg /*b4j.example.pywrapper*/ (null,_value);
RDebugUtils.currentLine=7995394;
 //BA.debugLineNum = 7995394;BA.debugLine="End Sub";
return "";
}
public b4j.example.pywrapper  _wrap(b4j.example.pywrapper __ref,b4j.example.pybridge._internalpytaskasyncresult _result) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "wrap", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "wrap", new Object[] {_result}));}
b4j.example.pywrapper _w = null;
b4j.example.pybridge._pyobject _key = null;
boolean _error = false;
Object _value = null;
RDebugUtils.currentLine=7208960;
 //BA.debugLineNum = 7208960;BA.debugLine="Private Sub Wrap (Result As InternalPyTaskAsyncRes";
RDebugUtils.currentLine=7208961;
 //BA.debugLineNum = 7208961;BA.debugLine="Dim w As PyWrapper";
_w = new b4j.example.pywrapper();
RDebugUtils.currentLine=7208962;
 //BA.debugLineNum = 7208962;BA.debugLine="Dim key As PyObject = Result.PyObject";
_key = _result.PyObject /*b4j.example.pybridge._pyobject*/ ;
RDebugUtils.currentLine=7208963;
 //BA.debugLineNum = 7208963;BA.debugLine="Dim error As Boolean = Result.Error";
_error = _result.Error /*boolean*/ ;
RDebugUtils.currentLine=7208964;
 //BA.debugLineNum = 7208964;BA.debugLine="Dim value As Object = Result.Value";
_value = _result.Value /*Object*/ ;
RDebugUtils.currentLine=7208965;
 //BA.debugLineNum = 7208965;BA.debugLine="w.Initialize(mBridge, key)";
_w._initialize /*String*/ (null,ba,__ref._mbridge /*b4j.example.pybridge*/ ,_key);
RDebugUtils.currentLine=7208966;
 //BA.debugLineNum = 7208966;BA.debugLine="w.mError = error";
_w._merror /*boolean*/  = _error;
RDebugUtils.currentLine=7208967;
 //BA.debugLineNum = 7208967;BA.debugLine="w.mValue = value";
_w._mvalue /*Object*/  = _value;
RDebugUtils.currentLine=7208968;
 //BA.debugLineNum = 7208968;BA.debugLine="w.mFetched = True";
_w._mfetched /*boolean*/  = __c.True;
RDebugUtils.currentLine=7208969;
 //BA.debugLineNum = 7208969;BA.debugLine="Return w";
if (true) return _w;
RDebugUtils.currentLine=7208970;
 //BA.debugLineNum = 7208970;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _get2d(b4j.example.pywrapper __ref,Object _key1,Object _key2) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "get2d", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "get2d", new Object[] {_key1,_key2}));}
RDebugUtils.currentLine=7798784;
 //BA.debugLineNum = 7798784;BA.debugLine="Public Sub Get2D (Key1 As Object, Key2 As Object)";
RDebugUtils.currentLine=7798785;
 //BA.debugLineNum = 7798785;BA.debugLine="Return Get(Array(Key1, Key2))";
if (true) return __ref._get /*b4j.example.pywrapper*/ (null,(Object)(new Object[]{_key1,_key2}));
RDebugUtils.currentLine=7798786;
 //BA.debugLineNum = 7798786;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _get3d(b4j.example.pywrapper __ref,Object _key1,Object _key2,Object _key3) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "get3d", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "get3d", new Object[] {_key1,_key2,_key3}));}
RDebugUtils.currentLine=7864320;
 //BA.debugLineNum = 7864320;BA.debugLine="Public Sub Get3D (Key1 As Object, Key2 As Object,";
RDebugUtils.currentLine=7864321;
 //BA.debugLineNum = 7864321;BA.debugLine="Return Get(Array(Key1, Key2, Key3))";
if (true) return __ref._get /*b4j.example.pywrapper*/ (null,(Object)(new Object[]{_key1,_key2,_key3}));
RDebugUtils.currentLine=7864322;
 //BA.debugLineNum = 7864322;BA.debugLine="End Sub";
return null;
}
public String  _geterrormessage(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "geterrormessage", true))
	 {return ((String) Debug.delegate(ba, "geterrormessage", null));}
RDebugUtils.currentLine=7471104;
 //BA.debugLineNum = 7471104;BA.debugLine="Public Sub getErrorMessage As String";
RDebugUtils.currentLine=7471105;
 //BA.debugLineNum = 7471105;BA.debugLine="If mError Then Return mValue";
if (__ref._merror /*boolean*/ ) { 
if (true) return BA.ObjectToString(__ref._mvalue /*Object*/ );};
RDebugUtils.currentLine=7471106;
 //BA.debugLineNum = 7471106;BA.debugLine="Return \"\"";
if (true) return "";
RDebugUtils.currentLine=7471107;
 //BA.debugLineNum = 7471107;BA.debugLine="End Sub";
return "";
}
public boolean  _getisfetched(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "getisfetched", true))
	 {return ((Boolean) Debug.delegate(ba, "getisfetched", null));}
RDebugUtils.currentLine=7405568;
 //BA.debugLineNum = 7405568;BA.debugLine="Public Sub getIsFetched As Boolean";
RDebugUtils.currentLine=7405569;
 //BA.debugLineNum = 7405569;BA.debugLine="Return mFetched";
if (true) return __ref._mfetched /*boolean*/ ;
RDebugUtils.currentLine=7405570;
 //BA.debugLineNum = 7405570;BA.debugLine="End Sub";
return false;
}
public boolean  _getissuccess(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "getissuccess", true))
	 {return ((Boolean) Debug.delegate(ba, "getissuccess", null));}
RDebugUtils.currentLine=7340032;
 //BA.debugLineNum = 7340032;BA.debugLine="Public Sub getIsSuccess As Boolean";
RDebugUtils.currentLine=7340033;
 //BA.debugLineNum = 7340033;BA.debugLine="If mFetched = False Then";
if (__ref._mfetched /*boolean*/ ==__c.False) { 
RDebugUtils.currentLine=7340034;
 //BA.debugLineNum = 7340034;BA.debugLine="Me.As(JavaObject).RunMethod(\"raiseError\", Array(";
((anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(this))).RunMethod("raiseError",new Object[]{(Object)("Value not fetched")});
 };
RDebugUtils.currentLine=7340036;
 //BA.debugLineNum = 7340036;BA.debugLine="Return Not(mError)";
if (true) return __c.Not(__ref._merror /*boolean*/ );
RDebugUtils.currentLine=7340037;
 //BA.debugLineNum = 7340037;BA.debugLine="End Sub";
return false;
}
public b4j.example.pywrapper  _iter(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "iter", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "iter", null));}
RDebugUtils.currentLine=9502720;
 //BA.debugLineNum = 9502720;BA.debugLine="Public Sub Iter As PyWrapper";
RDebugUtils.currentLine=9502721;
 //BA.debugLineNum = 9502721;BA.debugLine="Return Run(\"__iter__\")";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__iter__");
RDebugUtils.currentLine=9502722;
 //BA.debugLineNum = 9502722;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _len(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "len", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "len", null));}
RDebugUtils.currentLine=8257536;
 //BA.debugLineNum = 8257536;BA.debugLine="Public Sub Len As PyWrapper";
RDebugUtils.currentLine=8257537;
 //BA.debugLineNum = 8257537;BA.debugLine="Return mBridge.Builtins.Run(\"len\").Arg(InternalKe";
if (true) return __ref._mbridge /*b4j.example.pybridge*/ ._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"len")._arg /*b4j.example.pywrapper*/ (null,(Object)(__ref._internalkey /*b4j.example.pybridge._pyobject*/ ));
RDebugUtils.currentLine=8257538;
 //BA.debugLineNum = 8257538;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _opradd(b4j.example.pywrapper __ref,Object _other) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "opradd", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "opradd", new Object[] {_other}));}
RDebugUtils.currentLine=8388608;
 //BA.debugLineNum = 8388608;BA.debugLine="Public Sub OprAdd (Other As Object) As PyWrapper";
RDebugUtils.currentLine=8388609;
 //BA.debugLineNum = 8388609;BA.debugLine="Return Run(\"__add__\").Arg(Other)";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__add__")._arg /*b4j.example.pywrapper*/ (null,_other);
RDebugUtils.currentLine=8388610;
 //BA.debugLineNum = 8388610;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _oprand(b4j.example.pywrapper __ref,Object _other) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "oprand", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "oprand", new Object[] {_other}));}
RDebugUtils.currentLine=9240576;
 //BA.debugLineNum = 9240576;BA.debugLine="Public Sub OprAnd (Other As Object) As PyWrapper";
RDebugUtils.currentLine=9240577;
 //BA.debugLineNum = 9240577;BA.debugLine="Return Run(\"__and__\").Arg(Other)";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__and__")._arg /*b4j.example.pywrapper*/ (null,_other);
RDebugUtils.currentLine=9240578;
 //BA.debugLineNum = 9240578;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _oprequal(b4j.example.pywrapper __ref,Object _other) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "oprequal", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "oprequal", new Object[] {_other}));}
RDebugUtils.currentLine=8847360;
 //BA.debugLineNum = 8847360;BA.debugLine="Public Sub OprEqual (Other As Object) As PyWrapper";
RDebugUtils.currentLine=8847361;
 //BA.debugLineNum = 8847361;BA.debugLine="Return Run(\"__eq__\").Arg(Other)";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__eq__")._arg /*b4j.example.pywrapper*/ (null,_other);
RDebugUtils.currentLine=8847362;
 //BA.debugLineNum = 8847362;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _oprgreater(b4j.example.pywrapper __ref,Object _other) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "oprgreater", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "oprgreater", new Object[] {_other}));}
RDebugUtils.currentLine=9109504;
 //BA.debugLineNum = 9109504;BA.debugLine="Public Sub OprGreater (Other As Object) As PyWrapp";
RDebugUtils.currentLine=9109505;
 //BA.debugLineNum = 9109505;BA.debugLine="Return Run(\"__gt__\").Arg(Other)";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__gt__")._arg /*b4j.example.pywrapper*/ (null,_other);
RDebugUtils.currentLine=9109506;
 //BA.debugLineNum = 9109506;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _oprgreaterequal(b4j.example.pywrapper __ref,Object _other) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "oprgreaterequal", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "oprgreaterequal", new Object[] {_other}));}
RDebugUtils.currentLine=9175040;
 //BA.debugLineNum = 9175040;BA.debugLine="Public Sub OprGreaterEqual (Other As Object) As Py";
RDebugUtils.currentLine=9175041;
 //BA.debugLineNum = 9175041;BA.debugLine="Return Run(\"__ge__\").Arg(Other)";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__ge__")._arg /*b4j.example.pywrapper*/ (null,_other);
RDebugUtils.currentLine=9175042;
 //BA.debugLineNum = 9175042;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _oprless(b4j.example.pywrapper __ref,Object _other) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "oprless", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "oprless", new Object[] {_other}));}
RDebugUtils.currentLine=8978432;
 //BA.debugLineNum = 8978432;BA.debugLine="Public Sub OprLess (Other As Object) As PyWrapper";
RDebugUtils.currentLine=8978433;
 //BA.debugLineNum = 8978433;BA.debugLine="Return Run(\"__lt__\").Arg(Other)";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__lt__")._arg /*b4j.example.pywrapper*/ (null,_other);
RDebugUtils.currentLine=8978434;
 //BA.debugLineNum = 8978434;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _oprlessequal(b4j.example.pywrapper __ref,Object _other) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "oprlessequal", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "oprlessequal", new Object[] {_other}));}
RDebugUtils.currentLine=9043968;
 //BA.debugLineNum = 9043968;BA.debugLine="Public Sub OprLessEqual (Other As Object) As PyWra";
RDebugUtils.currentLine=9043969;
 //BA.debugLineNum = 9043969;BA.debugLine="Return Run(\"__le__\").Arg(Other)";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__le__")._arg /*b4j.example.pywrapper*/ (null,_other);
RDebugUtils.currentLine=9043970;
 //BA.debugLineNum = 9043970;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _oprmod(b4j.example.pywrapper __ref,Object _other) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "oprmod", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "oprmod", new Object[] {_other}));}
RDebugUtils.currentLine=8585216;
 //BA.debugLineNum = 8585216;BA.debugLine="Public Sub OprMod (Other As Object) As PyWrapper";
RDebugUtils.currentLine=8585217;
 //BA.debugLineNum = 8585217;BA.debugLine="Return Run(\"__mod__\").Arg(Other)";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__mod__")._arg /*b4j.example.pywrapper*/ (null,_other);
RDebugUtils.currentLine=8585218;
 //BA.debugLineNum = 8585218;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _oprmul(b4j.example.pywrapper __ref,Object _other) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "oprmul", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "oprmul", new Object[] {_other}));}
RDebugUtils.currentLine=8519680;
 //BA.debugLineNum = 8519680;BA.debugLine="Public Sub OprMul (Other As Object) As PyWrapper";
RDebugUtils.currentLine=8519681;
 //BA.debugLineNum = 8519681;BA.debugLine="Return Run(\"__mul__\").Arg(Other)";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__mul__")._arg /*b4j.example.pywrapper*/ (null,_other);
RDebugUtils.currentLine=8519682;
 //BA.debugLineNum = 8519682;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _oprnot(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "oprnot", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "oprnot", null));}
RDebugUtils.currentLine=9371648;
 //BA.debugLineNum = 9371648;BA.debugLine="Public Sub OprNot As PyWrapper";
RDebugUtils.currentLine=9371649;
 //BA.debugLineNum = 9371649;BA.debugLine="Return Run(\"__invert__\")";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__invert__");
RDebugUtils.currentLine=9371650;
 //BA.debugLineNum = 9371650;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _oprnotequal(b4j.example.pywrapper __ref,Object _other) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "oprnotequal", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "oprnotequal", new Object[] {_other}));}
RDebugUtils.currentLine=8912896;
 //BA.debugLineNum = 8912896;BA.debugLine="Public Sub OprNotEqual (Other As Object) As PyWrap";
RDebugUtils.currentLine=8912897;
 //BA.debugLineNum = 8912897;BA.debugLine="Return Run(\"__ne__\").Arg(Other)";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__ne__")._arg /*b4j.example.pywrapper*/ (null,_other);
RDebugUtils.currentLine=8912898;
 //BA.debugLineNum = 8912898;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _opror(b4j.example.pywrapper __ref,Object _other) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "opror", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "opror", new Object[] {_other}));}
RDebugUtils.currentLine=9306112;
 //BA.debugLineNum = 9306112;BA.debugLine="Public Sub OprOr (Other As Object) As PyWrapper";
RDebugUtils.currentLine=9306113;
 //BA.debugLineNum = 9306113;BA.debugLine="Return Run(\"__or__\").Arg(Other)";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__or__")._arg /*b4j.example.pywrapper*/ (null,_other);
RDebugUtils.currentLine=9306114;
 //BA.debugLineNum = 9306114;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _oprpow(b4j.example.pywrapper __ref,Object _other) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "oprpow", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "oprpow", new Object[] {_other}));}
RDebugUtils.currentLine=8650752;
 //BA.debugLineNum = 8650752;BA.debugLine="Public Sub OprPow (Other As Object) As PyWrapper";
RDebugUtils.currentLine=8650753;
 //BA.debugLineNum = 8650753;BA.debugLine="Return Run(\"__pow__\").Arg(Other)";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__pow__")._arg /*b4j.example.pywrapper*/ (null,_other);
RDebugUtils.currentLine=8650754;
 //BA.debugLineNum = 8650754;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _oprsub(b4j.example.pywrapper __ref,Object _other) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "oprsub", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "oprsub", new Object[] {_other}));}
RDebugUtils.currentLine=8454144;
 //BA.debugLineNum = 8454144;BA.debugLine="Public Sub OprSub (Other As Object) As PyWrapper";
RDebugUtils.currentLine=8454145;
 //BA.debugLineNum = 8454145;BA.debugLine="Return Run(\"__sub__\").Arg(Other)";
if (true) return __ref._run /*b4j.example.pywrapper*/ (null,"__sub__")._arg /*b4j.example.pywrapper*/ (null,_other);
RDebugUtils.currentLine=8454146;
 //BA.debugLineNum = 8454146;BA.debugLine="End Sub";
return null;
}
public b4j.example.pybridge._internalpymethodargs  _prepareargs(b4j.example.pywrapper __ref,anywheresoftware.b4a.objects.collections.List _args1,anywheresoftware.b4a.objects.collections.Map _kwargs) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "prepareargs", true))
	 {return ((b4j.example.pybridge._internalpymethodargs) Debug.delegate(ba, "prepareargs", new Object[] {_args1,_kwargs}));}
b4j.example.pybridge._internalpymethodargs _a = null;
RDebugUtils.currentLine=7077888;
 //BA.debugLineNum = 7077888;BA.debugLine="Private Sub PrepareArgs (Args1 As List, KWArgs As";
RDebugUtils.currentLine=7077889;
 //BA.debugLineNum = 7077889;BA.debugLine="Dim a As InternalPyMethodArgs";
_a = new b4j.example.pybridge._internalpymethodargs();
RDebugUtils.currentLine=7077890;
 //BA.debugLineNum = 7077890;BA.debugLine="a.Initialize";
_a.Initialize();
RDebugUtils.currentLine=7077891;
 //BA.debugLineNum = 7077891;BA.debugLine="a.Args = B4XCollections.CreateList(Args1)";
_a.Args /*anywheresoftware.b4a.objects.collections.List*/  = _b4xcollections._createlist /*anywheresoftware.b4a.objects.collections.List*/ (_args1);
RDebugUtils.currentLine=7077892;
 //BA.debugLineNum = 7077892;BA.debugLine="a.KWArgs = B4XCollections.MergeMaps(KWArgs, Null)";
_a.KWArgs /*anywheresoftware.b4a.objects.collections.Map*/  = _b4xcollections._mergemaps /*anywheresoftware.b4a.objects.collections.Map*/ (_kwargs,(anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(__c.Null)));
RDebugUtils.currentLine=7077893;
 //BA.debugLineNum = 7077893;BA.debugLine="Return a";
if (true) return _a;
RDebugUtils.currentLine=7077894;
 //BA.debugLineNum = 7077894;BA.debugLine="End Sub";
return null;
}
public String  _print(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "print", true))
	 {return ((String) Debug.delegate(ba, "print", null));}
RDebugUtils.currentLine=7536640;
 //BA.debugLineNum = 7536640;BA.debugLine="Public Sub Print";
RDebugUtils.currentLine=7536641;
 //BA.debugLineNum = 7536641;BA.debugLine="Print2(\"\", \"\", False)";
__ref._print2 /*String*/ (null,"","",__c.False);
RDebugUtils.currentLine=7536642;
 //BA.debugLineNum = 7536642;BA.debugLine="End Sub";
return "";
}
public String  _print2(b4j.example.pywrapper __ref,String _prefix,String _suffix,boolean _stderr) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "print2", true))
	 {return ((String) Debug.delegate(ba, "print2", new Object[] {_prefix,_suffix,_stderr}));}
RDebugUtils.currentLine=7667712;
 //BA.debugLineNum = 7667712;BA.debugLine="Public Sub Print2 (Prefix As String, Suffix As Str";
RDebugUtils.currentLine=7667713;
 //BA.debugLineNum = 7667713;BA.debugLine="If mFetched Then";
if (__ref._mfetched /*boolean*/ ) { 
RDebugUtils.currentLine=7667714;
 //BA.debugLineNum = 7667714;BA.debugLine="Log(mValue)";
__c.LogImpl("97667714",BA.ObjectToString(__ref._mvalue /*Object*/ ),0);
 }else {
RDebugUtils.currentLine=7667716;
 //BA.debugLineNum = 7667716;BA.debugLine="mBridge.PrintJoin(Array(Prefix, Me, Suffix), Std";
__ref._mbridge /*b4j.example.pybridge*/ ._printjoin /*String*/ (null,anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(_prefix),this,(Object)(_suffix)}),_stderr);
 };
RDebugUtils.currentLine=7667718;
 //BA.debugLineNum = 7667718;BA.debugLine="End Sub";
return "";
}
public String  _printerror(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "printerror", true))
	 {return ((String) Debug.delegate(ba, "printerror", null));}
RDebugUtils.currentLine=7602176;
 //BA.debugLineNum = 7602176;BA.debugLine="Public Sub PrintError";
RDebugUtils.currentLine=7602177;
 //BA.debugLineNum = 7602177;BA.debugLine="Print2(\"\", \"\", True)";
__ref._print2 /*String*/ (null,"","",__c.True);
RDebugUtils.currentLine=7602178;
 //BA.debugLineNum = 7602178;BA.debugLine="End Sub";
return "";
}
public String  _setfield(b4j.example.pywrapper __ref,String _field,Object _value) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "setfield", true))
	 {return ((String) Debug.delegate(ba, "setfield", new Object[] {_field,_value}));}
RDebugUtils.currentLine=7012352;
 //BA.debugLineNum = 7012352;BA.debugLine="Public Sub SetField(Field As String, Value As Obje";
RDebugUtils.currentLine=7012353;
 //BA.debugLineNum = 7012353;BA.debugLine="mBridge.Builtins.RunArgs(\"setattr\", Array(Interna";
__ref._mbridge /*b4j.example.pybridge*/ ._builtins /*b4j.example.pywrapper*/ ._runargs /*b4j.example.pywrapper*/ (null,"setattr",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(__ref._internalkey /*b4j.example.pybridge._pyobject*/ ),(Object)(_field),_value}),(anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(__c.Null)));
RDebugUtils.currentLine=7012354;
 //BA.debugLineNum = 7012354;BA.debugLine="End Sub";
return "";
}
public b4j.example.pywrapper  _shape(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "shape", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "shape", null));}
RDebugUtils.currentLine=8323072;
 //BA.debugLineNum = 8323072;BA.debugLine="Public Sub Shape As PyWrapper";
RDebugUtils.currentLine=8323073;
 //BA.debugLineNum = 8323073;BA.debugLine="Return GetField(\"shape\")";
if (true) return __ref._getfield /*b4j.example.pywrapper*/ (null,"shape");
RDebugUtils.currentLine=8323074;
 //BA.debugLineNum = 8323074;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _str(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "str", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "str", null));}
RDebugUtils.currentLine=8126464;
 //BA.debugLineNum = 8126464;BA.debugLine="Public Sub Str As PyWrapper";
RDebugUtils.currentLine=8126465;
 //BA.debugLineNum = 8126465;BA.debugLine="Return mBridge.Builtins.Run(\"str\").Arg(InternalKe";
if (true) return __ref._mbridge /*b4j.example.pybridge*/ ._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"str")._arg /*b4j.example.pywrapper*/ (null,(Object)(__ref._internalkey /*b4j.example.pybridge._pyobject*/ ));
RDebugUtils.currentLine=8126466;
 //BA.debugLineNum = 8126466;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper[]  _toarray(b4j.example.pywrapper __ref,int _length) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "toarray", true))
	 {return ((b4j.example.pywrapper[]) Debug.delegate(ba, "toarray", new Object[] {_length}));}
b4j.example.pywrapper[] _res = null;
int _i = 0;
b4j.example.pywrapper _w = null;
int _start = 0;
b4j.example.pywrapper _p = null;
RDebugUtils.currentLine=6815744;
 //BA.debugLineNum = 6815744;BA.debugLine="Public Sub ToArray (Length As Int) As PyWrapper()";
RDebugUtils.currentLine=6815745;
 //BA.debugLineNum = 6815745;BA.debugLine="Dim res(Length) As PyWrapper";
_res = new b4j.example.pywrapper[_length];
{
int d0 = _res.length;
for (int i0 = 0;i0 < d0;i0++) {
_res[i0] = new b4j.example.pywrapper();
}
}
;
RDebugUtils.currentLine=6815746;
 //BA.debugLineNum = 6815746;BA.debugLine="If Length = 0 Then Return res";
if (_length==0) { 
if (true) return _res;};
RDebugUtils.currentLine=6815747;
 //BA.debugLineNum = 6815747;BA.debugLine="For i = 0 To Length - 2";
{
final int step3 = 1;
final int limit3 = (int) (_length-2);
_i = (int) (0) ;
for (;_i <= limit3 ;_i = _i + step3 ) {
RDebugUtils.currentLine=6815748;
 //BA.debugLineNum = 6815748;BA.debugLine="Dim w As PyWrapper";
_w = new b4j.example.pywrapper();
RDebugUtils.currentLine=6815749;
 //BA.debugLineNum = 6815749;BA.debugLine="w.Initialize(mBridge, mBridge.Utils.CreatePyObje";
_w._initialize /*String*/ (null,ba,__ref._mbridge /*b4j.example.pybridge*/ ,__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._createpyobject /*b4j.example.pybridge._pyobject*/ (null,(int) (0)));
RDebugUtils.currentLine=6815750;
 //BA.debugLineNum = 6815750;BA.debugLine="res(i) = w";
_res[_i] = _w;
 }
};
RDebugUtils.currentLine=6815752;
 //BA.debugLineNum = 6815752;BA.debugLine="Dim Start As Int = IIf(Length = 1, mBridge.Utils.";
_start = (int)(BA.ObjectToNumber(((_length==1) ? ((Object)(__ref._mbridge /*b4j.example.pybridge*/ ._utils /*b4j.example.pyutils*/ ._pyobjectcounter /*int*/ +1)) : ((Object)(_res[(int) (0)]._internalkey /*b4j.example.pybridge._pyobject*/ .Key /*int*/ )))));
RDebugUtils.currentLine=6815753;
 //BA.debugLineNum = 6815753;BA.debugLine="Dim p As PyWrapper = mBridge.Bridge.RunArgs(\"to_a";
_p = __ref._mbridge /*b4j.example.pybridge*/ ._bridge /*b4j.example.pywrapper*/ ._runargs /*b4j.example.pywrapper*/ (null,"to_array",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{this,(Object)(_start),(Object)(_length)}),(anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(__c.Null)));
RDebugUtils.currentLine=6815754;
 //BA.debugLineNum = 6815754;BA.debugLine="res(Length - 1) = p";
_res[(int) (_length-1)] = _p;
RDebugUtils.currentLine=6815755;
 //BA.debugLineNum = 6815755;BA.debugLine="Return res";
if (true) return _res;
RDebugUtils.currentLine=6815756;
 //BA.debugLineNum = 6815756;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _tolist(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "tolist", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "tolist", null));}
RDebugUtils.currentLine=9437184;
 //BA.debugLineNum = 9437184;BA.debugLine="Public Sub ToList As PyWrapper";
RDebugUtils.currentLine=9437185;
 //BA.debugLineNum = 9437185;BA.debugLine="Return mBridge.Builtins.Run(\"list\").Arg(Me)";
if (true) return __ref._mbridge /*b4j.example.pybridge*/ ._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"list")._arg /*b4j.example.pywrapper*/ (null,this);
RDebugUtils.currentLine=9437186;
 //BA.debugLineNum = 9437186;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _typeof(b4j.example.pywrapper __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pywrapper";
if (Debug.shouldDelegate(ba, "typeof", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "typeof", null));}
RDebugUtils.currentLine=8192000;
 //BA.debugLineNum = 8192000;BA.debugLine="Public Sub TypeOf As PyWrapper";
RDebugUtils.currentLine=8192001;
 //BA.debugLineNum = 8192001;BA.debugLine="Return mBridge.Builtins.Run(\"type\").Arg(InternalK";
if (true) return __ref._mbridge /*b4j.example.pybridge*/ ._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"type")._arg /*b4j.example.pywrapper*/ (null,(Object)(__ref._internalkey /*b4j.example.pybridge._pyobject*/ ));
RDebugUtils.currentLine=8192002;
 //BA.debugLineNum = 8192002;BA.debugLine="End Sub";
return null;
}
public void raiseError(String desc) {
	throw new RuntimeException (desc);
}
}