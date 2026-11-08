package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class searchws_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 3;BA.debugLine="Private ws As WebSocket";
searchws._ws = RemoteObject.createNew ("anywheresoftware.b4j.object.WebSocket");__ref.setField("_ws",searchws._ws);
 //BA.debugLineNum = 5;BA.debugLine="Private IsClientConnected As Boolean = False";
searchws._isclientconnected = searchws.__c.getField(true,"False");__ref.setField("_isclientconnected",searchws._isclientconnected);
 //BA.debugLineNum = 6;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static void  _get_vector(RemoteObject __ref,RemoteObject _params) throws Exception{
try {
		Debug.PushSubsStack("get_vector (searchws) ","searchws",2,__ref.getField(false, "ba"),__ref,25);
if (RapidSub.canDelegate("get_vector")) { __ref.runUserSub(false, "searchws","get_vector", __ref, _params); return;}
ResumableSub_get_vector rsub = new ResumableSub_get_vector(null,__ref,_params);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_get_vector extends BA.ResumableSub {
public ResumableSub_get_vector(b4j.example.searchws parent,RemoteObject __ref,RemoteObject _params) {
this.parent = parent;
this.__ref = __ref;
this._params = _params;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.searchws parent;
RemoteObject _params;
RemoteObject _txt = RemoteObject.createImmutable("");
RemoteObject _base64string = RemoteObject.createImmutable("");

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("get_vector (searchws) ","searchws",2,__ref.getField(false, "ba"),__ref,25);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
try {

        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
Debug.locals.put("_ref", __ref);
Debug.locals.put("Params", _params);
 BA.debugLineNum = 26;BA.debugLine="Dim txt As String = Params.Get(\"text\")";
Debug.ShouldStop(33554432);
_txt = BA.ObjectToString(_params.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("text")))));Debug.locals.put("txt", _txt);Debug.locals.put("txt", _txt);
 BA.debugLineNum = 27;BA.debugLine="Log(\"Request: \" & txt)";
Debug.ShouldStop(67108864);
parent.__c.runVoidMethod ("LogImpl","216973826",RemoteObject.concat(RemoteObject.createImmutable("Request: "),_txt),0);
 BA.debugLineNum = 30;BA.debugLine="CallSubDelayed3(Main.PyWorker, \"Get_Embedding_Req";
Debug.ShouldStop(536870912);
parent.__c.runVoidMethod ("CallSubDelayed3",__ref.getField(false, "ba"),(Object)((parent._main._pyworker /*RemoteObject*/ )),(Object)(BA.ObjectToString("Get_Embedding_Request")),(Object)(__ref),(Object)((_txt)));
 BA.debugLineNum = 33;BA.debugLine="Wait For Embedding_Response (Base64String As Stri";
Debug.ShouldStop(1);
parent.__c.runVoidMethod ("WaitFor","embedding_response", __ref.getField(false, "ba"), anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "searchws", "get_vector"), null);
this.state = 10;
return;
case 10:
//C
this.state = 1;
_base64string = (RemoteObject) result.getArrayElement(true,RemoteObject.createImmutable(1));Debug.locals.put("Base64String", _base64string);
;
 BA.debugLineNum = 35;BA.debugLine="If IsClientConnected = False Then";
Debug.ShouldStop(4);
if (true) break;

case 1:
//if
this.state = 4;
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_isclientconnected" /*RemoteObject*/ ),parent.__c.getField(true,"False"))) { 
this.state = 3;
}if (true) break;

case 3:
//C
this.state = 4;
 BA.debugLineNum = 36;BA.debugLine="Log(\"Python responsed, but client left.\")";
Debug.ShouldStop(8);
parent.__c.runVoidMethod ("LogImpl","216973835",RemoteObject.createImmutable("Python responsed, but client left."),0);
 BA.debugLineNum = 37;BA.debugLine="Return";
Debug.ShouldStop(16);
if (true) return ;
 if (true) break;
;
 BA.debugLineNum = 41;BA.debugLine="Try";
Debug.ShouldStop(256);

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
 BA.debugLineNum = 42;BA.debugLine="ws.RunFunction(\"receiveVector\", Array As Object(";
Debug.ShouldStop(512);
__ref.getField(false,"_ws" /*RemoteObject*/ ).runVoidMethod ("RunFunction",(Object)(BA.ObjectToString("receiveVector")),(Object)(parent.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(_base64string)})))));
 BA.debugLineNum = 43;BA.debugLine="ws.Flush";
Debug.ShouldStop(1024);
__ref.getField(false,"_ws" /*RemoteObject*/ ).runVoidMethod ("Flush");
 BA.debugLineNum = 44;BA.debugLine="Log(\"result at Browser!\")";
Debug.ShouldStop(2048);
parent.__c.runVoidMethod ("LogImpl","216973843",RemoteObject.createImmutable("result at Browser!"),0);
 Debug.CheckDeviceExceptions();
if (true) break;

case 8:
//C
this.state = 9;
this.catchState = 0;
 BA.debugLineNum = 46;BA.debugLine="Log(\"Something wrong: \" & LastException.Message)";
Debug.ShouldStop(8192);
parent.__c.runVoidMethod ("LogImpl","216973845",RemoteObject.concat(RemoteObject.createImmutable("Something wrong: "),parent.__c.runMethod(false,"LastException",__ref.getField(false, "ba")).runMethod(true,"getMessage")),0);
 if (true) break;
if (true) break;

case 9:
//C
this.state = -1;
this.catchState = 0;
;
 BA.debugLineNum = 48;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
if (true) break;
}} 
       catch (Exception e0) {
			
if (catchState == 0)
    throw e0;
else {
    state = catchState;
BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e0.toString());}
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
public static void  _embedding_response(RemoteObject __ref,RemoteObject _base64string) throws Exception{
}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (searchws) ","searchws",2,__ref.getField(false, "ba"),__ref,8);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "searchws","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 8;BA.debugLine="Public Sub Initialize";
Debug.ShouldStop(128);
 BA.debugLineNum = 9;BA.debugLine="End Sub";
Debug.ShouldStop(256);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _websocket_connected(RemoteObject __ref,RemoteObject _websocket1) throws Exception{
try {
		Debug.PushSubsStack("WebSocket_Connected (searchws) ","searchws",2,__ref.getField(false, "ba"),__ref,12);
if (RapidSub.canDelegate("websocket_connected")) { return __ref.runUserSub(false, "searchws","websocket_connected", __ref, _websocket1);}
Debug.locals.put("WebSocket1", _websocket1);
 BA.debugLineNum = 12;BA.debugLine="Private Sub WebSocket_Connected (WebSocket1 As Web";
Debug.ShouldStop(2048);
 BA.debugLineNum = 13;BA.debugLine="ws = WebSocket1";
Debug.ShouldStop(4096);
__ref.setField ("_ws" /*RemoteObject*/ ,_websocket1);
 BA.debugLineNum = 14;BA.debugLine="IsClientConnected = True";
Debug.ShouldStop(8192);
__ref.setField ("_isclientconnected" /*RemoteObject*/ ,searchws.__c.getField(true,"True"));
 BA.debugLineNum = 15;BA.debugLine="Log(\"client connect to WebSocket!\")";
Debug.ShouldStop(16384);
searchws.__c.runVoidMethod ("LogImpl","216842755",RemoteObject.createImmutable("client connect to WebSocket!"),0);
 BA.debugLineNum = 16;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _websocket_disconnected(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("WebSocket_Disconnected (searchws) ","searchws",2,__ref.getField(false, "ba"),__ref,19);
if (RapidSub.canDelegate("websocket_disconnected")) { return __ref.runUserSub(false, "searchws","websocket_disconnected", __ref);}
 BA.debugLineNum = 19;BA.debugLine="Private Sub WebSocket_Disconnected";
Debug.ShouldStop(262144);
 BA.debugLineNum = 20;BA.debugLine="IsClientConnected = False";
Debug.ShouldStop(524288);
__ref.setField ("_isclientconnected" /*RemoteObject*/ ,searchws.__c.getField(true,"False"));
 BA.debugLineNum = 21;BA.debugLine="Log(\"client disconnected.\")";
Debug.ShouldStop(1048576);
searchws.__c.runVoidMethod ("LogImpl","216908290",RemoteObject.createImmutable("client disconnected."),0);
 BA.debugLineNum = 22;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}