package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class searchws extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.searchws", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.searchws.class).invoke(this, new Object[] {null});
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
public anywheresoftware.b4j.object.WebSocket _ws = null;
public boolean _isclientconnected = false;
public b4j.example.main _main = null;
public b4j.example.b4xcollections _b4xcollections = null;
public String  _class_globals(b4j.example.searchws __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="searchws";
RDebugUtils.currentLine=16711680;
 //BA.debugLineNum = 16711680;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=16711681;
 //BA.debugLineNum = 16711681;BA.debugLine="Private ws As WebSocket";
_ws = new anywheresoftware.b4j.object.WebSocket();
RDebugUtils.currentLine=16711683;
 //BA.debugLineNum = 16711683;BA.debugLine="Private IsClientConnected As Boolean = False";
_isclientconnected = __c.False;
RDebugUtils.currentLine=16711684;
 //BA.debugLineNum = 16711684;BA.debugLine="End Sub";
return "";
}
public void  _get_vector(b4j.example.searchws __ref,anywheresoftware.b4a.objects.collections.Map _params) throws Exception{
RDebugUtils.currentModule="searchws";
if (Debug.shouldDelegate(ba, "get_vector", false))
	 {Debug.delegate(ba, "get_vector", new Object[] {_params}); return;}
ResumableSub_get_vector rsub = new ResumableSub_get_vector(this,__ref,_params);
rsub.resume(ba, null);
}
public static class ResumableSub_get_vector extends BA.ResumableSub {
public ResumableSub_get_vector(b4j.example.searchws parent,b4j.example.searchws __ref,anywheresoftware.b4a.objects.collections.Map _params) {
this.parent = parent;
this.__ref = __ref;
this._params = _params;
this.__ref = parent;
}
b4j.example.searchws __ref;
b4j.example.searchws parent;
anywheresoftware.b4a.objects.collections.Map _params;
String _txt = "";
String _base64string = "";

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="searchws";

    while (true) {
try {

        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
RDebugUtils.currentLine=16973825;
 //BA.debugLineNum = 16973825;BA.debugLine="Dim txt As String = Params.Get(\"text\")";
_txt = BA.ObjectToString(_params.Get((Object)("text")));
RDebugUtils.currentLine=16973826;
 //BA.debugLineNum = 16973826;BA.debugLine="Log(\"Request: \" & txt)";
parent.__c.LogImpl("216973826","Request: "+_txt,0);
RDebugUtils.currentLine=16973829;
 //BA.debugLineNum = 16973829;BA.debugLine="CallSubDelayed3(Main.PyWorker, \"Get_Embedding_Req";
parent.__c.CallSubDelayed3(ba,(Object)(parent._main._pyworker /*b4j.example.pybridgeworker*/ ),"Get_Embedding_Request",parent,(Object)(_txt));
RDebugUtils.currentLine=16973832;
 //BA.debugLineNum = 16973832;BA.debugLine="Wait For Embedding_Response (Base64String As Stri";
parent.__c.WaitFor("embedding_response", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "searchws", "get_vector"), null);
this.state = 10;
return;
case 10:
//C
this.state = 1;
_base64string = (String) result[1];
;
RDebugUtils.currentLine=16973834;
 //BA.debugLineNum = 16973834;BA.debugLine="If IsClientConnected = False Then";
if (true) break;

case 1:
//if
this.state = 4;
if (__ref._isclientconnected /*boolean*/ ==parent.__c.False) { 
this.state = 3;
}if (true) break;

case 3:
//C
this.state = 4;
RDebugUtils.currentLine=16973835;
 //BA.debugLineNum = 16973835;BA.debugLine="Log(\"Python responsed, but client left.\")";
parent.__c.LogImpl("216973835","Python responsed, but client left.",0);
RDebugUtils.currentLine=16973836;
 //BA.debugLineNum = 16973836;BA.debugLine="Return";
if (true) return ;
 if (true) break;
;
RDebugUtils.currentLine=16973840;
 //BA.debugLineNum = 16973840;BA.debugLine="Try";

case 4:
//try
this.state = 9;
this.catchState = 8;
this.state = 6;
if (true) break;

case 6:
//C
this.state = 9;
this.catchState = 8;
RDebugUtils.currentLine=16973841;
 //BA.debugLineNum = 16973841;BA.debugLine="ws.RunFunction(\"receiveVector\", Array As Object(";
__ref._ws /*anywheresoftware.b4j.object.WebSocket*/ .RunFunction("receiveVector",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(_base64string)}));
RDebugUtils.currentLine=16973842;
 //BA.debugLineNum = 16973842;BA.debugLine="ws.Flush";
__ref._ws /*anywheresoftware.b4j.object.WebSocket*/ .Flush();
RDebugUtils.currentLine=16973843;
 //BA.debugLineNum = 16973843;BA.debugLine="Log(\"result at Browser!\")";
parent.__c.LogImpl("216973843","result at Browser!",0);
 if (true) break;

case 8:
//C
this.state = 9;
this.catchState = 0;
RDebugUtils.currentLine=16973845;
 //BA.debugLineNum = 16973845;BA.debugLine="Log(\"Something wrong: \" & LastException.Message)";
parent.__c.LogImpl("216973845","Something wrong: "+parent.__c.LastException(ba).getMessage(),0);
 if (true) break;
if (true) break;

case 9:
//C
this.state = -1;
this.catchState = 0;
;
RDebugUtils.currentLine=16973847;
 //BA.debugLineNum = 16973847;BA.debugLine="End Sub";
if (true) break;
}} 
       catch (Exception e0) {
			
if (catchState == 0)
    throw e0;
else {
    state = catchState;
ba.setLastException(e0);}
            }
        }
    }
}
public String  _initialize(b4j.example.searchws __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="searchws";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=16777216;
 //BA.debugLineNum = 16777216;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=16777217;
 //BA.debugLineNum = 16777217;BA.debugLine="End Sub";
return "";
}
public String  _websocket_connected(b4j.example.searchws __ref,anywheresoftware.b4j.object.WebSocket _websocket1) throws Exception{
__ref = this;
RDebugUtils.currentModule="searchws";
if (Debug.shouldDelegate(ba, "websocket_connected", false))
	 {return ((String) Debug.delegate(ba, "websocket_connected", new Object[] {_websocket1}));}
RDebugUtils.currentLine=16842752;
 //BA.debugLineNum = 16842752;BA.debugLine="Private Sub WebSocket_Connected (WebSocket1 As Web";
RDebugUtils.currentLine=16842753;
 //BA.debugLineNum = 16842753;BA.debugLine="ws = WebSocket1";
__ref._ws /*anywheresoftware.b4j.object.WebSocket*/  = _websocket1;
RDebugUtils.currentLine=16842754;
 //BA.debugLineNum = 16842754;BA.debugLine="IsClientConnected = True";
__ref._isclientconnected /*boolean*/  = __c.True;
RDebugUtils.currentLine=16842755;
 //BA.debugLineNum = 16842755;BA.debugLine="Log(\"client connect to WebSocket!\")";
__c.LogImpl("216842755","client connect to WebSocket!",0);
RDebugUtils.currentLine=16842756;
 //BA.debugLineNum = 16842756;BA.debugLine="End Sub";
return "";
}
public String  _websocket_disconnected(b4j.example.searchws __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="searchws";
if (Debug.shouldDelegate(ba, "websocket_disconnected", false))
	 {return ((String) Debug.delegate(ba, "websocket_disconnected", null));}
RDebugUtils.currentLine=16908288;
 //BA.debugLineNum = 16908288;BA.debugLine="Private Sub WebSocket_Disconnected";
RDebugUtils.currentLine=16908289;
 //BA.debugLineNum = 16908289;BA.debugLine="IsClientConnected = False";
__ref._isclientconnected /*boolean*/  = __c.False;
RDebugUtils.currentLine=16908290;
 //BA.debugLineNum = 16908290;BA.debugLine="Log(\"client disconnected.\")";
__c.LogImpl("216908290","client disconnected.",0);
RDebugUtils.currentLine=16908291;
 //BA.debugLineNum = 16908291;BA.debugLine="End Sub";
return "";
}
}