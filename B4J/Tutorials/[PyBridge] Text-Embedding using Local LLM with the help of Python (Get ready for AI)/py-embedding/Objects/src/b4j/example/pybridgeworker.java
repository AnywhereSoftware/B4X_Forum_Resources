package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class pybridgeworker extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.pybridgeworker", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.pybridgeworker.class).invoke(this, new Object[] {null});
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
public b4j.example.pybridge _py = null;
public b4j.example.pywrapper _ailogic = null;
public b4j.example.main _main = null;
public b4j.example.b4xcollections _b4xcollections = null;
public String  _class_globals(b4j.example.pybridgeworker __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridgeworker";
RDebugUtils.currentLine=131072;
 //BA.debugLineNum = 131072;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=131073;
 //BA.debugLineNum = 131073;BA.debugLine="Private py As PyBridge";
_py = new b4j.example.pybridge();
RDebugUtils.currentLine=131074;
 //BA.debugLineNum = 131074;BA.debugLine="Public AILogic As PyWrapper ' Python script";
_ailogic = new b4j.example.pywrapper();
RDebugUtils.currentLine=131075;
 //BA.debugLineNum = 131075;BA.debugLine="End Sub";
return "";
}
public void  _get_embedding_request(b4j.example.pybridgeworker __ref,Object _callback,String _texttoembed) throws Exception{
RDebugUtils.currentModule="pybridgeworker";
if (Debug.shouldDelegate(ba, "get_embedding_request", false))
	 {Debug.delegate(ba, "get_embedding_request", new Object[] {_callback,_texttoembed}); return;}
ResumableSub_Get_Embedding_Request rsub = new ResumableSub_Get_Embedding_Request(this,__ref,_callback,_texttoembed);
rsub.resume(ba, null);
}
public static class ResumableSub_Get_Embedding_Request extends BA.ResumableSub {
public ResumableSub_Get_Embedding_Request(b4j.example.pybridgeworker parent,b4j.example.pybridgeworker __ref,Object _callback,String _texttoembed) {
this.parent = parent;
this.__ref = __ref;
this._callback = _callback;
this._texttoembed = _texttoembed;
this.__ref = parent;
}
b4j.example.pybridgeworker __ref;
b4j.example.pybridgeworker parent;
Object _callback;
String _texttoembed;
b4j.example.pywrapper _embedtask = null;
b4j.example.pywrapper _base64result = null;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="pybridgeworker";

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = -1;
RDebugUtils.currentLine=327682;
 //BA.debugLineNum = 327682;BA.debugLine="Dim EmbedTask As PyWrapper = AILogic.Run(\"get_emb";
_embedtask = __ref._ailogic /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"get_embedding")._arg /*b4j.example.pywrapper*/ (null,(Object)(_texttoembed));
RDebugUtils.currentLine=327685;
 //BA.debugLineNum = 327685;BA.debugLine="Wait For (EmbedTask.Fetch) Complete (Base64Result";
parent.__c.WaitFor("complete", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pybridgeworker", "get_embedding_request"), _embedtask._fetch /*anywheresoftware.b4a.keywords.Common.ResumableSubWrapper*/ (null));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_base64result = (b4j.example.pywrapper) result[1];
;
RDebugUtils.currentLine=327688;
 //BA.debugLineNum = 327688;BA.debugLine="CallSubDelayed2(Callback, \"Embedding_Response\", B";
parent.__c.CallSubDelayed2(ba,_callback,"Embedding_Response",_base64result._getvalue /*Object*/ (null));
RDebugUtils.currentLine=327691;
 //BA.debugLineNum = 327691;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public String  _initialize(b4j.example.pybridgeworker __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="pybridgeworker";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=196608;
 //BA.debugLineNum = 196608;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=196609;
 //BA.debugLineNum = 196609;BA.debugLine="Main.PyWorker = Me";
_main._pyworker /*b4j.example.pybridgeworker*/  = (b4j.example.pybridgeworker)(this);
RDebugUtils.currentLine=196610;
 //BA.debugLineNum = 196610;BA.debugLine="Start";
__ref._start /*void*/ (null);
RDebugUtils.currentLine=196611;
 //BA.debugLineNum = 196611;BA.debugLine="StartMessageLoop";
__c.StartMessageLoop(ba);
RDebugUtils.currentLine=196612;
 //BA.debugLineNum = 196612;BA.debugLine="End Sub";
return "";
}
public void  _start(b4j.example.pybridgeworker __ref) throws Exception{
RDebugUtils.currentModule="pybridgeworker";
if (Debug.shouldDelegate(ba, "start", false))
	 {Debug.delegate(ba, "start", null); return;}
ResumableSub_Start rsub = new ResumableSub_Start(this,__ref);
rsub.resume(ba, null);
}
public static class ResumableSub_Start extends BA.ResumableSub {
public ResumableSub_Start(b4j.example.pybridgeworker parent,b4j.example.pybridgeworker __ref) {
this.parent = parent;
this.__ref = __ref;
this.__ref = parent;
}
b4j.example.pybridgeworker __ref;
b4j.example.pybridgeworker parent;
b4j.example.pybridge._pyoptions _opt = null;
boolean _success = false;
b4j.example.pywrapper _inittask = null;
b4j.example.pywrapper _result = null;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="pybridgeworker";

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
RDebugUtils.currentLine=262145;
 //BA.debugLineNum = 262145;BA.debugLine="py.Initialize(Me, \"py\")";
__ref._py /*b4j.example.pybridge*/ ._initialize /*String*/ (null,ba,parent,"py");
RDebugUtils.currentLine=262146;
 //BA.debugLineNum = 262146;BA.debugLine="Dim opt As PyOptions = py.CreateOptions(\"python\")";
_opt = __ref._py /*b4j.example.pybridge*/ ._createoptions /*b4j.example.pybridge._pyoptions*/ (null,"python");
RDebugUtils.currentLine=262147;
 //BA.debugLineNum = 262147;BA.debugLine="py.Start(opt)";
__ref._py /*b4j.example.pybridge*/ ._start /*String*/ (null,_opt);
RDebugUtils.currentLine=262149;
 //BA.debugLineNum = 262149;BA.debugLine="Wait For py_Connected (Success As Boolean)";
parent.__c.WaitFor("py_connected", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pybridgeworker", "start"), null);
this.state = 5;
return;
case 5:
//C
this.state = 1;
_success = (boolean) result[1];
;
RDebugUtils.currentLine=262150;
 //BA.debugLineNum = 262150;BA.debugLine="If Success = False Then";
if (true) break;

case 1:
//if
this.state = 4;
if (_success==parent.__c.False) { 
this.state = 3;
}if (true) break;

case 3:
//C
this.state = 4;
RDebugUtils.currentLine=262151;
 //BA.debugLineNum = 262151;BA.debugLine="py_Disconnected";
__ref._py_disconnected /*void*/ (null);
RDebugUtils.currentLine=262152;
 //BA.debugLineNum = 262152;BA.debugLine="Return";
if (true) return ;
 if (true) break;

case 4:
//C
this.state = -1;
;
RDebugUtils.currentLine=262155;
 //BA.debugLineNum = 262155;BA.debugLine="Log(\"PyBridge Connected! Loading LLM - please wai";
parent.__c.LogImpl("2262155","PyBridge Connected! Loading LLM - please wait...",0);
RDebugUtils.currentLine=262158;
 //BA.debugLineNum = 262158;BA.debugLine="AILogic = py.ImportModule(\"text_embedding\")";
__ref._ailogic /*b4j.example.pywrapper*/  = __ref._py /*b4j.example.pybridge*/ ._importmodule /*b4j.example.pywrapper*/ (null,"text_embedding");
RDebugUtils.currentLine=262161;
 //BA.debugLineNum = 262161;BA.debugLine="Dim InitTask As PyWrapper = AILogic.Run(\"init_mod";
_inittask = __ref._ailogic /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"init_model");
RDebugUtils.currentLine=262162;
 //BA.debugLineNum = 262162;BA.debugLine="Wait For (InitTask.Fetch) Complete (Result As PyW";
parent.__c.WaitFor("complete", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pybridgeworker", "start"), _inittask._fetch /*anywheresoftware.b4a.keywords.Common.ResumableSubWrapper*/ (null));
this.state = 6;
return;
case 6:
//C
this.state = -1;
_result = (b4j.example.pywrapper) result[1];
;
RDebugUtils.currentLine=262163;
 //BA.debugLineNum = 262163;BA.debugLine="Log(\"AI Status: \" & Result.Value)";
parent.__c.LogImpl("2262163","AI Status: "+BA.ObjectToString(_result._getvalue /*Object*/ (null)),0);
RDebugUtils.currentLine=262164;
 //BA.debugLineNum = 262164;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public void  _py_disconnected(b4j.example.pybridgeworker __ref) throws Exception{
RDebugUtils.currentModule="pybridgeworker";
if (Debug.shouldDelegate(ba, "py_disconnected", false))
	 {Debug.delegate(ba, "py_disconnected", null); return;}
ResumableSub_py_Disconnected rsub = new ResumableSub_py_Disconnected(this,__ref);
rsub.resume(ba, null);
}
public static class ResumableSub_py_Disconnected extends BA.ResumableSub {
public ResumableSub_py_Disconnected(b4j.example.pybridgeworker parent,b4j.example.pybridgeworker __ref) {
this.parent = parent;
this.__ref = __ref;
this.__ref = parent;
}
b4j.example.pybridgeworker __ref;
b4j.example.pybridgeworker parent;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="pybridgeworker";

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = -1;
RDebugUtils.currentLine=393217;
 //BA.debugLineNum = 393217;BA.debugLine="Log(\"PyBridge disconnected!!!\")";
parent.__c.LogImpl("2393217","PyBridge disconnected!!!",0);
RDebugUtils.currentLine=393218;
 //BA.debugLineNum = 393218;BA.debugLine="Sleep(5000)";
parent.__c.Sleep(ba,new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pybridgeworker", "py_disconnected"),(int) (5000));
this.state = 1;
return;
case 1:
//C
this.state = -1;
;
RDebugUtils.currentLine=393219;
 //BA.debugLineNum = 393219;BA.debugLine="Start";
__ref._start /*void*/ (null);
RDebugUtils.currentLine=393220;
 //BA.debugLineNum = 393220;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
}