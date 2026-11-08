package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _appstart(RemoteObject _form1,RemoteObject _args) throws Exception{
try {
		Debug.PushSubsStack("AppStart (main) ","main",0,main.ba,main.mostCurrent,22);
if (RapidSub.canDelegate("appstart")) { return b4j.example.main.remoteMe.runUserSub(false, "main","appstart", _form1, _args);}
Debug.locals.put("Form1", _form1);
Debug.locals.put("Args", _args);
 BA.debugLineNum = 22;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 24;BA.debugLine="MainForm = Form1";
Debug.ShouldStop(8388608);
main._mainform = _form1;
 BA.debugLineNum = 25;BA.debugLine="MainForm.RootPane.LoadLayout(\"Layout1\")";
Debug.ShouldStop(16777216);
main._mainform.runMethod(false,"getRootPane").runMethodAndSync(false,"LoadLayout",main.ba,(Object)(RemoteObject.createImmutable("Layout1")));
 BA.debugLineNum = 26;BA.debugLine="MainForm.Show";
Debug.ShouldStop(33554432);
main._mainform.runVoidMethodAndSync ("Show");
 BA.debugLineNum = 27;BA.debugLine="Clients.Initialize";
Debug.ShouldStop(67108864);
main._clients.runVoidMethod ("Initialize");
 BA.debugLineNum = 28;BA.debugLine="NextClientId = 1";
Debug.ShouldStop(134217728);
main._nextclientid = BA.numberCast(int.class, 1);
 BA.debugLineNum = 29;BA.debugLine="RndSeed(DateTime.Now)";
Debug.ShouldStop(268435456);
main.__c.runVoidMethod ("RndSeed",(Object)(main.__c.getField(false,"DateTime").runMethod(true,"getNow")));
 BA.debugLineNum = 31;BA.debugLine="Server.Initialize(ListenPort, \"Server\")";
Debug.ShouldStop(1073741824);
main._server.runVoidMethod ("Initialize",main.ba,(Object)(main._listenport),(Object)(RemoteObject.createImmutable("Server")));
 BA.debugLineNum = 32;BA.debugLine="Server.Listen";
Debug.ShouldStop(-2147483648);
main._server.runVoidMethod ("Listen");
 BA.debugLineNum = 34;BA.debugLine="Log(\"TCP Server listening on port \" & ListenPort)";
Debug.ShouldStop(2);
main.__c.runVoidMethod ("LogImpl","365548",RemoteObject.concat(RemoteObject.createImmutable("TCP Server listening on port "),main._listenport),0);
 BA.debugLineNum = 35;BA.debugLine="End Sub";
Debug.ShouldStop(4);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _broadcast(RemoteObject _message) throws Exception{
try {
		Debug.PushSubsStack("Broadcast (main) ","main",0,main.ba,main.mostCurrent,73);
if (RapidSub.canDelegate("broadcast")) { return b4j.example.main.remoteMe.runUserSub(false, "main","broadcast", _message);}
RemoteObject _ch = RemoteObject.declareNull("b4j.example.clienthandler");
Debug.locals.put("Message", _message);
 BA.debugLineNum = 73;BA.debugLine="Public Sub Broadcast(Message As String)";
Debug.ShouldStop(256);
 BA.debugLineNum = 74;BA.debugLine="For Each ch As ClientHandler In Clients.Values";
Debug.ShouldStop(512);
{
final RemoteObject group1 = main._clients.runMethod(false,"Values");
final int groupLen1 = group1.runMethod(true,"getSize").<Integer>get()
;int index1 = 0;
;
for (; index1 < groupLen1;index1++){
_ch = (group1.runMethod(false,"Get",index1));Debug.locals.put("ch", _ch);
Debug.locals.put("ch", _ch);
 BA.debugLineNum = 75;BA.debugLine="ch.Send(\"[Broadcast] \" & Message & CRLF)";
Debug.ShouldStop(1024);
_ch.runClassMethod (b4j.example.clienthandler.class, "_send" /*RemoteObject*/ ,(Object)(RemoteObject.concat(RemoteObject.createImmutable("[Broadcast] "),_message,main.__c.getField(true,"CRLF"))));
 }
}Debug.locals.put("ch", _ch);
;
 BA.debugLineNum = 77;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _button1_click() throws Exception{
try {
		Debug.PushSubsStack("Button1_Click (main) ","main",0,main.ba,main.mostCurrent,90);
if (RapidSub.canDelegate("button1_click")) { return b4j.example.main.remoteMe.runUserSub(false, "main","button1_click");}
 BA.debugLineNum = 90;BA.debugLine="Sub Button1_Click";
Debug.ShouldStop(33554432);
 BA.debugLineNum = 92;BA.debugLine="If TextField2.Text = \"Client-x\" Then";
Debug.ShouldStop(134217728);
if (RemoteObject.solveBoolean("=",main._textfield2.runMethod(true,"getText"),BA.ObjectToString("Client-x"))) { 
 BA.debugLineNum = 93;BA.debugLine="Broadcast(TextField1.Text)";
Debug.ShouldStop(268435456);
_broadcast(main._textfield1.runMethod(true,"getText"));
 }else {
 BA.debugLineNum = 95;BA.debugLine="SendToClient(TextField2.Text,TextField1.Text)";
Debug.ShouldStop(1073741824);
_sendtoclient(main._textfield2.runMethod(true,"getText"),main._textfield1.runMethod(true,"getText"));
 };
 BA.debugLineNum = 98;BA.debugLine="End Sub";
Debug.ShouldStop(2);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}

private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main_subs_0._process_globals();
main.myClass = BA.getDeviceClass ("b4j.example.main");
clienthandler.myClass = BA.getDeviceClass ("b4j.example.clienthandler");
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 6;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 7;BA.debugLine="Private fx As JFX";
main._fx = RemoteObject.createNew ("anywheresoftware.b4j.objects.JFX");
 //BA.debugLineNum = 8;BA.debugLine="Private MainForm As Form";
main._mainform = RemoteObject.createNew ("anywheresoftware.b4j.objects.Form");
 //BA.debugLineNum = 9;BA.debugLine="Private xui As XUI";
main._xui = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");
 //BA.debugLineNum = 10;BA.debugLine="Private Button1 As B4XView";
main._button1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");
 //BA.debugLineNum = 11;BA.debugLine="Private TextField1 As TextField";
main._textfield1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
 //BA.debugLineNum = 12;BA.debugLine="Private TextField2 As TextField";
main._textfield2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
 //BA.debugLineNum = 14;BA.debugLine="Public Server As ServerSocket		'Requires jNetwork";
main._server = RemoteObject.createNew ("anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper");
 //BA.debugLineNum = 15;BA.debugLine="Public ListenPort As Int = 5000   ' change as nee";
main._listenport = BA.numberCast(int.class, 5000);
 //BA.debugLineNum = 16;BA.debugLine="Public Clients As Map             ' holds all con";
main._clients = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
 //BA.debugLineNum = 17;BA.debugLine="Private NextClientId As Int";
main._nextclientid = RemoteObject.createImmutable(0);
 //BA.debugLineNum = 20;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _removeclient(RemoteObject _clientid) throws Exception{
try {
		Debug.PushSubsStack("RemoveClient (main) ","main",0,main.ba,main.mostCurrent,82);
if (RapidSub.canDelegate("removeclient")) { return b4j.example.main.remoteMe.runUserSub(false, "main","removeclient", _clientid);}
Debug.locals.put("ClientId", _clientid);
 BA.debugLineNum = 82;BA.debugLine="Public Sub RemoveClient(ClientId As String)";
Debug.ShouldStop(131072);
 BA.debugLineNum = 83;BA.debugLine="If Clients.ContainsKey(ClientId) Then";
Debug.ShouldStop(262144);
if (main._clients.runMethod(true,"ContainsKey",(Object)((_clientid))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 84;BA.debugLine="Clients.Remove(ClientId)";
Debug.ShouldStop(524288);
main._clients.runVoidMethod ("Remove",(Object)((_clientid)));
 BA.debugLineNum = 85;BA.debugLine="Log(\"Client removed: \" & ClientId)";
Debug.ShouldStop(1048576);
main.__c.runVoidMethod ("LogImpl","3327683",RemoteObject.concat(RemoteObject.createImmutable("Client removed: "),_clientid),0);
 BA.debugLineNum = 86;BA.debugLine="Broadcast(ClientId & \" disconnected\")";
Debug.ShouldStop(2097152);
_broadcast(RemoteObject.concat(_clientid,RemoteObject.createImmutable(" disconnected")));
 };
 BA.debugLineNum = 88;BA.debugLine="End Sub";
Debug.ShouldStop(8388608);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _sendtoclient(RemoteObject _clientid,RemoteObject _message) throws Exception{
try {
		Debug.PushSubsStack("SendToClient (main) ","main",0,main.ba,main.mostCurrent,61);
if (RapidSub.canDelegate("sendtoclient")) { return b4j.example.main.remoteMe.runUserSub(false, "main","sendtoclient", _clientid, _message);}
RemoteObject _ch = RemoteObject.declareNull("b4j.example.clienthandler");
Debug.locals.put("ClientId", _clientid);
Debug.locals.put("Message", _message);
 BA.debugLineNum = 61;BA.debugLine="Public Sub SendToClient(ClientId As String, Messag";
Debug.ShouldStop(268435456);
 BA.debugLineNum = 62;BA.debugLine="If Clients.ContainsKey(ClientId) Then";
Debug.ShouldStop(536870912);
if (main._clients.runMethod(true,"ContainsKey",(Object)((_clientid))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 63;BA.debugLine="Dim ch As ClientHandler = Clients.Get(ClientId)";
Debug.ShouldStop(1073741824);
_ch = (main._clients.runMethod(false,"Get",(Object)((_clientid))));Debug.locals.put("ch", _ch);Debug.locals.put("ch", _ch);
 BA.debugLineNum = 64;BA.debugLine="ch.Send(Message & CRLF)";
Debug.ShouldStop(-2147483648);
_ch.runClassMethod (b4j.example.clienthandler.class, "_send" /*RemoteObject*/ ,(Object)(RemoteObject.concat(_message,main.__c.getField(true,"CRLF"))));
 }else {
 BA.debugLineNum = 66;BA.debugLine="Log(\"SendToClient: Client not found -> \" & Clien";
Debug.ShouldStop(2);
main.__c.runVoidMethod ("LogImpl","3196613",RemoteObject.concat(RemoteObject.createImmutable("SendToClient: Client not found -> "),_clientid),0);
 };
 BA.debugLineNum = 68;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _server_newconnection(RemoteObject _successful,RemoteObject _newsocket) throws Exception{
try {
		Debug.PushSubsStack("Server_NewConnection (main) ","main",0,main.ba,main.mostCurrent,37);
if (RapidSub.canDelegate("server_newconnection")) { return b4j.example.main.remoteMe.runUserSub(false, "main","server_newconnection", _successful, _newsocket);}
RemoteObject _id = RemoteObject.createImmutable("");
RemoteObject _ch = RemoteObject.declareNull("b4j.example.clienthandler");
Debug.locals.put("Successful", _successful);
Debug.locals.put("NewSocket", _newsocket);
 BA.debugLineNum = 37;BA.debugLine="Sub Server_NewConnection (Successful As Boolean, N";
Debug.ShouldStop(16);
 BA.debugLineNum = 38;BA.debugLine="If Successful = False Then";
Debug.ShouldStop(32);
if (RemoteObject.solveBoolean("=",_successful,main.__c.getField(true,"False"))) { 
 BA.debugLineNum = 39;BA.debugLine="Log(\"Connection failed\")";
Debug.ShouldStop(64);
main.__c.runVoidMethod ("LogImpl","3131074",RemoteObject.createImmutable("Connection failed"),0);
 BA.debugLineNum = 40;BA.debugLine="Return";
Debug.ShouldStop(128);
if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 43;BA.debugLine="Dim id As String = \"Client-\" & NextClientId";
Debug.ShouldStop(1024);
_id = RemoteObject.concat(RemoteObject.createImmutable("Client-"),main._nextclientid);Debug.locals.put("id", _id);Debug.locals.put("id", _id);
 BA.debugLineNum = 44;BA.debugLine="NextClientId = NextClientId + 1";
Debug.ShouldStop(2048);
main._nextclientid = RemoteObject.solve(new RemoteObject[] {main._nextclientid,RemoteObject.createImmutable(1)}, "+",1, 1);
 BA.debugLineNum = 46;BA.debugLine="Log(\"New connection from \" & NewSocket.RemoteAddr";
Debug.ShouldStop(8192);
main.__c.runVoidMethod ("LogImpl","3131081",RemoteObject.concat(RemoteObject.createImmutable("New connection from "),_newsocket.runMethod(true,"getRemoteAddress"),RemoteObject.createImmutable(" as "),_id),0);
 BA.debugLineNum = 48;BA.debugLine="Dim ch As ClientHandler";
Debug.ShouldStop(32768);
_ch = RemoteObject.createNew ("b4j.example.clienthandler");Debug.locals.put("ch", _ch);
 BA.debugLineNum = 49;BA.debugLine="ch.Initialize(NewSocket, id)";
Debug.ShouldStop(65536);
_ch.runClassMethod (b4j.example.clienthandler.class, "_initialize" /*RemoteObject*/ ,main.ba,(Object)(_newsocket),(Object)(_id));
 BA.debugLineNum = 50;BA.debugLine="Clients.Put(id, ch)";
Debug.ShouldStop(131072);
main._clients.runVoidMethod ("Put",(Object)((_id)),(Object)((_ch)));
 BA.debugLineNum = 53;BA.debugLine="ch.Send(\"Welcome \" & id & CRLF)";
Debug.ShouldStop(1048576);
_ch.runClassMethod (b4j.example.clienthandler.class, "_send" /*RemoteObject*/ ,(Object)(RemoteObject.concat(RemoteObject.createImmutable("Welcome "),_id,main.__c.getField(true,"CRLF"))));
 BA.debugLineNum = 55;BA.debugLine="Server.Listen			'Listen for next connection";
Debug.ShouldStop(4194304);
main._server.runVoidMethod ("Listen");
 BA.debugLineNum = 56;BA.debugLine="End Sub";
Debug.ShouldStop(8388608);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}