package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class clienthandler_subs_0 {


public static RemoteObject  _ast_error(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("AST_Error (clienthandler) ","clienthandler",1,__ref.getField(false, "ba"),__ref,54);
if (RapidSub.canDelegate("ast_error")) { return __ref.runUserSub(false, "clienthandler","ast_error", __ref);}
 BA.debugLineNum = 54;BA.debugLine="Sub AST_Error";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 55;BA.debugLine="Log(\"Stream error: \" & ID)";
Debug.ShouldStop(4194304);
clienthandler.__c.runVoidMethod ("LogImpl","3720897",RemoteObject.concat(RemoteObject.createImmutable("Stream error: "),__ref.getField(true,"_id" /*RemoteObject*/ )),0);
 BA.debugLineNum = 56;BA.debugLine="Close";
Debug.ShouldStop(8388608);
__ref.runClassMethod (b4j.example.clienthandler.class, "_close" /*RemoteObject*/ );
 BA.debugLineNum = 57;BA.debugLine="End Sub";
Debug.ShouldStop(16777216);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _ast_newdata(RemoteObject __ref,RemoteObject _buffer) throws Exception{
try {
		Debug.PushSubsStack("AST_NewData (clienthandler) ","clienthandler",1,__ref.getField(false, "ba"),__ref,21);
if (RapidSub.canDelegate("ast_newdata")) { return __ref.runUserSub(false, "clienthandler","ast_newdata", __ref, _buffer);}
RemoteObject _msg = RemoteObject.createImmutable("");
RemoteObject _text = RemoteObject.createImmutable("");
Debug.locals.put("Buffer", _buffer);
 BA.debugLineNum = 21;BA.debugLine="Sub AST_NewData (Buffer() As Byte)";
Debug.ShouldStop(1048576);
 BA.debugLineNum = 22;BA.debugLine="Dim msg As String = BytesToString(Buffer, 0, B";
Debug.ShouldStop(2097152);
_msg = clienthandler.__c.runMethod(true,"BytesToString",(Object)(_buffer),(Object)(BA.numberCast(int.class, 0)),(Object)(_buffer.getField(true,"length")),(Object)(RemoteObject.createImmutable("UTF8"))).runMethod(true,"trim");Debug.locals.put("msg", _msg);Debug.locals.put("msg", _msg);
 BA.debugLineNum = 23;BA.debugLine="Log(\"From \" & ID & \": \" & msg)";
Debug.ShouldStop(4194304);
clienthandler.__c.runVoidMethod ("LogImpl","3524290",RemoteObject.concat(RemoteObject.createImmutable("From "),__ref.getField(true,"_id" /*RemoteObject*/ ),RemoteObject.createImmutable(": "),_msg),0);
 BA.debugLineNum = 26;BA.debugLine="Select True";
Debug.ShouldStop(33554432);
switch (BA.switchObjectToInt(clienthandler.__c.getField(true,"True"),BA.ObjectToBoolean(RemoteObject.solveBoolean("=",_msg.runMethod(true,"toLowerCase"),BA.ObjectToString("who"))),_msg.runMethod(true,"toLowerCase").runMethod(true,"startsWith",(Object)(RemoteObject.createImmutable("broadcast "))))) {
case 0: {
 BA.debugLineNum = 28;BA.debugLine="Send(\"You are \" & ID)";
Debug.ShouldStop(134217728);
__ref.runClassMethod (b4j.example.clienthandler.class, "_send" /*RemoteObject*/ ,(Object)(RemoteObject.concat(RemoteObject.createImmutable("You are "),__ref.getField(true,"_id" /*RemoteObject*/ ))));
 break; }
case 1: {
 BA.debugLineNum = 31;BA.debugLine="Dim text As String = msg.SubString(10)";
Debug.ShouldStop(1073741824);
_text = _msg.runMethod(true,"substring",(Object)(BA.numberCast(int.class, 10)));Debug.locals.put("text", _text);Debug.locals.put("text", _text);
 BA.debugLineNum = 32;BA.debugLine="CallSub2(Main, \"Broadcast\", ID & \": \"";
Debug.ShouldStop(-2147483648);
clienthandler.__c.runMethodAndSync(false,"CallSubNew2",__ref.getField(false, "ba"),(Object)((clienthandler._main.getObject())),(Object)(BA.ObjectToString("Broadcast")),(Object)((RemoteObject.concat(__ref.getField(true,"_id" /*RemoteObject*/ ),RemoteObject.createImmutable(": "),_text))));
 break; }
default: {
 BA.debugLineNum = 36;BA.debugLine="Send(\"Echo: \" & msg)";
Debug.ShouldStop(8);
__ref.runClassMethod (b4j.example.clienthandler.class, "_send" /*RemoteObject*/ ,(Object)(RemoteObject.concat(RemoteObject.createImmutable("Echo: "),_msg)));
 break; }
}
;
 BA.debugLineNum = 38;BA.debugLine="End Sub";
Debug.ShouldStop(32);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _ast_terminated(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("AST_Terminated (clienthandler) ","clienthandler",1,__ref.getField(false, "ba"),__ref,49);
if (RapidSub.canDelegate("ast_terminated")) { return __ref.runUserSub(false, "clienthandler","ast_terminated", __ref);}
 BA.debugLineNum = 49;BA.debugLine="Sub AST_Terminated";
Debug.ShouldStop(65536);
 BA.debugLineNum = 50;BA.debugLine="Log(\"Disconnected: \" & ID)";
Debug.ShouldStop(131072);
clienthandler.__c.runVoidMethod ("LogImpl","3655361",RemoteObject.concat(RemoteObject.createImmutable("Disconnected: "),__ref.getField(true,"_id" /*RemoteObject*/ )),0);
 BA.debugLineNum = 51;BA.debugLine="Close";
Debug.ShouldStop(262144);
__ref.runClassMethod (b4j.example.clienthandler.class, "_close" /*RemoteObject*/ );
 BA.debugLineNum = 52;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 1;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 2;BA.debugLine="Private fx As JFX";
clienthandler._fx = RemoteObject.createNew ("anywheresoftware.b4j.objects.JFX");__ref.setField("_fx",clienthandler._fx);
 //BA.debugLineNum = 3;BA.debugLine="Private ClientSocket As Socket";
clienthandler._clientsocket = RemoteObject.createNew ("anywheresoftware.b4a.objects.SocketWrapper");__ref.setField("_clientsocket",clienthandler._clientsocket);
 //BA.debugLineNum = 4;BA.debugLine="Private AST As AsyncStreams					'Requires jRandom";
clienthandler._ast = RemoteObject.createNew ("anywheresoftware.b4a.randomaccessfile.AsyncStreams");__ref.setField("_ast",clienthandler._ast);
 //BA.debugLineNum = 5;BA.debugLine="Public ID As String";
clienthandler._id = RemoteObject.createImmutable("");__ref.setField("_id",clienthandler._id);
 //BA.debugLineNum = 6;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _close(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Close (clienthandler) ","clienthandler",1,__ref.getField(false, "ba"),__ref,59);
if (RapidSub.canDelegate("close")) { return __ref.runUserSub(false, "clienthandler","close", __ref);}
 BA.debugLineNum = 59;BA.debugLine="Public Sub Close";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 60;BA.debugLine="Try";
Debug.ShouldStop(134217728);
try { BA.debugLineNum = 61;BA.debugLine="If AST.IsInitialized Then AST.Close";
Debug.ShouldStop(268435456);
if (__ref.getField(false,"_ast" /*RemoteObject*/ ).runMethod(true,"IsInitialized").<Boolean>get().booleanValue()) { 
__ref.getField(false,"_ast" /*RemoteObject*/ ).runVoidMethod ("Close");};
 BA.debugLineNum = 62;BA.debugLine="If ClientSocket.IsInitialized Then ClientS";
Debug.ShouldStop(536870912);
if (__ref.getField(false,"_clientsocket" /*RemoteObject*/ ).runMethod(true,"IsInitialized").<Boolean>get().booleanValue()) { 
__ref.getField(false,"_clientsocket" /*RemoteObject*/ ).runVoidMethod ("Close");};
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e5) {
			BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e5.toString()); BA.debugLineNum = 64;BA.debugLine="Log(\"Could not close AST or ClientSocket - No bi";
Debug.ShouldStop(-2147483648);
clienthandler.__c.runVoidMethod ("LogImpl","3786437",RemoteObject.createImmutable("Could not close AST or ClientSocket - No big deal"),0);
 };
 BA.debugLineNum = 68;BA.debugLine="CallSub2(Main, \"RemoveClient\", ID)";
Debug.ShouldStop(8);
clienthandler.__c.runMethodAndSync(false,"CallSubNew2",__ref.getField(false, "ba"),(Object)((clienthandler._main.getObject())),(Object)(BA.ObjectToString("RemoveClient")),(Object)((__ref.getField(true,"_id" /*RemoteObject*/ ))));
 BA.debugLineNum = 69;BA.debugLine="End Sub";
Debug.ShouldStop(16);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _s,RemoteObject _clientid) throws Exception{
try {
		Debug.PushSubsStack("Initialize (clienthandler) ","clienthandler",1,__ref.getField(false, "ba"),__ref,10);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "clienthandler","initialize", __ref, _ba, _s, _clientid);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
Debug.locals.put("s", _s);
Debug.locals.put("ClientId", _clientid);
 BA.debugLineNum = 10;BA.debugLine="Public Sub Initialize (s As Socket, ClientId As St";
Debug.ShouldStop(512);
 BA.debugLineNum = 11;BA.debugLine="ClientSocket = s";
Debug.ShouldStop(1024);
__ref.setField ("_clientsocket" /*RemoteObject*/ ,_s);
 BA.debugLineNum = 12;BA.debugLine="ID = ClientId";
Debug.ShouldStop(2048);
__ref.setField ("_id" /*RemoteObject*/ ,_clientid);
 BA.debugLineNum = 14;BA.debugLine="AST.Initialize(ClientSocket.InputStream, Clien";
Debug.ShouldStop(8192);
__ref.getField(false,"_ast" /*RemoteObject*/ ).runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_clientsocket" /*RemoteObject*/ ).runMethod(false,"getInputStream")),(Object)(__ref.getField(false,"_clientsocket" /*RemoteObject*/ ).runMethod(false,"getOutputStream")),(Object)(RemoteObject.createImmutable("AST")));
 BA.debugLineNum = 15;BA.debugLine="Log(\"ClientHandler started: \" & ID)";
Debug.ShouldStop(16384);
clienthandler.__c.runVoidMethod ("LogImpl","3458757",RemoteObject.concat(RemoteObject.createImmutable("ClientHandler started: "),__ref.getField(true,"_id" /*RemoteObject*/ )),0);
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
public static RemoteObject  _send(RemoteObject __ref,RemoteObject _text) throws Exception{
try {
		Debug.PushSubsStack("Send (clienthandler) ","clienthandler",1,__ref.getField(false, "ba"),__ref,43);
if (RapidSub.canDelegate("send")) { return __ref.runUserSub(false, "clienthandler","send", __ref, _text);}
Debug.locals.put("Text", _text);
 BA.debugLineNum = 43;BA.debugLine="Public Sub Send(Text As String)";
Debug.ShouldStop(1024);
 BA.debugLineNum = 44;BA.debugLine="If AST.IsInitialized Then";
Debug.ShouldStop(2048);
if (__ref.getField(false,"_ast" /*RemoteObject*/ ).runMethod(true,"IsInitialized").<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 45;BA.debugLine="AST.Write(Text.GetBytes(\"UTF8\"))";
Debug.ShouldStop(4096);
__ref.getField(false,"_ast" /*RemoteObject*/ ).runVoidMethod ("Write",(Object)(_text.runMethod(false,"getBytes",(Object)(RemoteObject.createImmutable("UTF8")))));
 };
 BA.debugLineNum = 47;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}