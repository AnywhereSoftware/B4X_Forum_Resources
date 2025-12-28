package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;

public class main extends javafx.application.Application{
public static main mostCurrent = new main();

public static BA ba;
static {
		ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.main", null);
		ba.loadHtSubs(main.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			anywheresoftware.b4a.shell.ShellBA.delegateBA = new anywheresoftware.b4j.objects.FxBA("b4j.example", null, null);
			ba.raiseEvent2(null, true, "SHELL", false);
			ba.raiseEvent2(null, true, "CREATE", true, "b4j.example.main", ba);
		}
	}
    public static Class<?> getObject() {
		return main.class;
	}

 
    public static void main(String[] args) {
    	launch(args);
    }
    public void start (javafx.stage.Stage stage) {
        try {
            if (!false)
                System.setProperty("prism.lcdtext", "false");
            anywheresoftware.b4j.objects.FxBA.application = this;
		    anywheresoftware.b4a.keywords.Common.setDensity(javafx.stage.Screen.getPrimary().getDpi());
            anywheresoftware.b4a.keywords.Common.LogDebug("Program started.");
            initializeProcessGlobals();
            anywheresoftware.b4j.objects.Form frm = new anywheresoftware.b4j.objects.Form();
            frm.initWithStage(ba, stage, 600, 600);
            ba.raiseEvent(null, "appstart", frm, (String[])getParameters().getRaw().toArray(new String[0]));
        } catch (Throwable t) {
            BA.printException(t, true);
            System.exit(1);
        }
    }


private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4j.objects.JFX _fx = null;
public static anywheresoftware.b4j.objects.Form _mainform = null;
public static anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public static anywheresoftware.b4a.objects.B4XViewWrapper _button1 = null;
public static anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _textfield1 = null;
public static anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _textfield2 = null;
public static anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper _server = null;
public static int _listenport = 0;
public static anywheresoftware.b4a.objects.collections.Map _clients = null;
public static int _nextclientid = 0;
public static String  _appstart(anywheresoftware.b4j.objects.Form _form1,String[] _args) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "appstart", false))
	 {return ((String) Debug.delegate(ba, "appstart", new Object[] {_form1,_args}));}
RDebugUtils.currentLine=65536;
 //BA.debugLineNum = 65536;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
RDebugUtils.currentLine=65538;
 //BA.debugLineNum = 65538;BA.debugLine="MainForm = Form1";
_mainform = _form1;
RDebugUtils.currentLine=65539;
 //BA.debugLineNum = 65539;BA.debugLine="MainForm.RootPane.LoadLayout(\"Layout1\")";
_mainform.getRootPane().LoadLayout(ba,"Layout1");
RDebugUtils.currentLine=65540;
 //BA.debugLineNum = 65540;BA.debugLine="MainForm.Show";
_mainform.Show();
RDebugUtils.currentLine=65541;
 //BA.debugLineNum = 65541;BA.debugLine="Clients.Initialize";
_clients.Initialize();
RDebugUtils.currentLine=65542;
 //BA.debugLineNum = 65542;BA.debugLine="NextClientId = 1";
_nextclientid = (int) (1);
RDebugUtils.currentLine=65543;
 //BA.debugLineNum = 65543;BA.debugLine="RndSeed(DateTime.Now)";
anywheresoftware.b4a.keywords.Common.RndSeed(anywheresoftware.b4a.keywords.Common.DateTime.getNow());
RDebugUtils.currentLine=65545;
 //BA.debugLineNum = 65545;BA.debugLine="Server.Initialize(ListenPort, \"Server\")";
_server.Initialize(ba,_listenport,"Server");
RDebugUtils.currentLine=65546;
 //BA.debugLineNum = 65546;BA.debugLine="Server.Listen";
_server.Listen();
RDebugUtils.currentLine=65548;
 //BA.debugLineNum = 65548;BA.debugLine="Log(\"TCP Server listening on port \" & ListenPort)";
anywheresoftware.b4a.keywords.Common.LogImpl("365548","TCP Server listening on port "+BA.NumberToString(_listenport),0);
RDebugUtils.currentLine=65549;
 //BA.debugLineNum = 65549;BA.debugLine="End Sub";
return "";
}
public static String  _broadcast(String _message) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "broadcast", false))
	 {return ((String) Debug.delegate(ba, "broadcast", new Object[] {_message}));}
b4j.example.clienthandler _ch = null;
RDebugUtils.currentLine=262144;
 //BA.debugLineNum = 262144;BA.debugLine="Public Sub Broadcast(Message As String)";
RDebugUtils.currentLine=262145;
 //BA.debugLineNum = 262145;BA.debugLine="For Each ch As ClientHandler In Clients.Values";
{
final anywheresoftware.b4a.BA.IterableList group1 = _clients.Values();
final int groupLen1 = group1.getSize()
;int index1 = 0;
;
for (; index1 < groupLen1;index1++){
_ch = (b4j.example.clienthandler)(group1.Get(index1));
RDebugUtils.currentLine=262146;
 //BA.debugLineNum = 262146;BA.debugLine="ch.Send(\"[Broadcast] \" & Message & CRLF)";
_ch._send /*String*/ (null,"[Broadcast] "+_message+anywheresoftware.b4a.keywords.Common.CRLF);
 }
};
RDebugUtils.currentLine=262148;
 //BA.debugLineNum = 262148;BA.debugLine="End Sub";
return "";
}
public static String  _button1_click() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "button1_click", false))
	 {return ((String) Debug.delegate(ba, "button1_click", null));}
RDebugUtils.currentLine=851968;
 //BA.debugLineNum = 851968;BA.debugLine="Sub Button1_Click";
RDebugUtils.currentLine=851970;
 //BA.debugLineNum = 851970;BA.debugLine="If TextField2.Text = \"Client-x\" Then";
if ((_textfield2.getText()).equals("Client-x")) { 
RDebugUtils.currentLine=851971;
 //BA.debugLineNum = 851971;BA.debugLine="Broadcast(TextField1.Text)";
_broadcast(_textfield1.getText());
 }else {
RDebugUtils.currentLine=851973;
 //BA.debugLineNum = 851973;BA.debugLine="SendToClient(TextField2.Text,TextField1.Text)";
_sendtoclient(_textfield2.getText(),_textfield1.getText());
 };
RDebugUtils.currentLine=851976;
 //BA.debugLineNum = 851976;BA.debugLine="End Sub";
return "";
}
public static String  _sendtoclient(String _clientid,String _message) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "sendtoclient", false))
	 {return ((String) Debug.delegate(ba, "sendtoclient", new Object[] {_clientid,_message}));}
b4j.example.clienthandler _ch = null;
RDebugUtils.currentLine=196608;
 //BA.debugLineNum = 196608;BA.debugLine="Public Sub SendToClient(ClientId As String, Messag";
RDebugUtils.currentLine=196609;
 //BA.debugLineNum = 196609;BA.debugLine="If Clients.ContainsKey(ClientId) Then";
if (_clients.ContainsKey((Object)(_clientid))) { 
RDebugUtils.currentLine=196610;
 //BA.debugLineNum = 196610;BA.debugLine="Dim ch As ClientHandler = Clients.Get(ClientId)";
_ch = (b4j.example.clienthandler)(_clients.Get((Object)(_clientid)));
RDebugUtils.currentLine=196611;
 //BA.debugLineNum = 196611;BA.debugLine="ch.Send(Message & CRLF)";
_ch._send /*String*/ (null,_message+anywheresoftware.b4a.keywords.Common.CRLF);
 }else {
RDebugUtils.currentLine=196613;
 //BA.debugLineNum = 196613;BA.debugLine="Log(\"SendToClient: Client not found -> \" & Clien";
anywheresoftware.b4a.keywords.Common.LogImpl("3196613","SendToClient: Client not found -> "+_clientid,0);
 };
RDebugUtils.currentLine=196615;
 //BA.debugLineNum = 196615;BA.debugLine="End Sub";
return "";
}
public static String  _removeclient(String _clientid) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "removeclient", false))
	 {return ((String) Debug.delegate(ba, "removeclient", new Object[] {_clientid}));}
RDebugUtils.currentLine=327680;
 //BA.debugLineNum = 327680;BA.debugLine="Public Sub RemoveClient(ClientId As String)";
RDebugUtils.currentLine=327681;
 //BA.debugLineNum = 327681;BA.debugLine="If Clients.ContainsKey(ClientId) Then";
if (_clients.ContainsKey((Object)(_clientid))) { 
RDebugUtils.currentLine=327682;
 //BA.debugLineNum = 327682;BA.debugLine="Clients.Remove(ClientId)";
_clients.Remove((Object)(_clientid));
RDebugUtils.currentLine=327683;
 //BA.debugLineNum = 327683;BA.debugLine="Log(\"Client removed: \" & ClientId)";
anywheresoftware.b4a.keywords.Common.LogImpl("3327683","Client removed: "+_clientid,0);
RDebugUtils.currentLine=327684;
 //BA.debugLineNum = 327684;BA.debugLine="Broadcast(ClientId & \" disconnected\")";
_broadcast(_clientid+" disconnected");
 };
RDebugUtils.currentLine=327686;
 //BA.debugLineNum = 327686;BA.debugLine="End Sub";
return "";
}
public static String  _server_newconnection(boolean _successful,anywheresoftware.b4a.objects.SocketWrapper _newsocket) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "server_newconnection", false))
	 {return ((String) Debug.delegate(ba, "server_newconnection", new Object[] {_successful,_newsocket}));}
String _id = "";
b4j.example.clienthandler _ch = null;
RDebugUtils.currentLine=131072;
 //BA.debugLineNum = 131072;BA.debugLine="Sub Server_NewConnection (Successful As Boolean, N";
RDebugUtils.currentLine=131073;
 //BA.debugLineNum = 131073;BA.debugLine="If Successful = False Then";
if (_successful==anywheresoftware.b4a.keywords.Common.False) { 
RDebugUtils.currentLine=131074;
 //BA.debugLineNum = 131074;BA.debugLine="Log(\"Connection failed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("3131074","Connection failed",0);
RDebugUtils.currentLine=131075;
 //BA.debugLineNum = 131075;BA.debugLine="Return";
if (true) return "";
 };
RDebugUtils.currentLine=131078;
 //BA.debugLineNum = 131078;BA.debugLine="Dim id As String = \"Client-\" & NextClientId";
_id = "Client-"+BA.NumberToString(_nextclientid);
RDebugUtils.currentLine=131079;
 //BA.debugLineNum = 131079;BA.debugLine="NextClientId = NextClientId + 1";
_nextclientid = (int) (_nextclientid+1);
RDebugUtils.currentLine=131081;
 //BA.debugLineNum = 131081;BA.debugLine="Log(\"New connection from \" & NewSocket.RemoteAddr";
anywheresoftware.b4a.keywords.Common.LogImpl("3131081","New connection from "+_newsocket.getRemoteAddress()+" as "+_id,0);
RDebugUtils.currentLine=131083;
 //BA.debugLineNum = 131083;BA.debugLine="Dim ch As ClientHandler";
_ch = new b4j.example.clienthandler();
RDebugUtils.currentLine=131084;
 //BA.debugLineNum = 131084;BA.debugLine="ch.Initialize(NewSocket, id)";
_ch._initialize /*String*/ (null,ba,_newsocket,_id);
RDebugUtils.currentLine=131085;
 //BA.debugLineNum = 131085;BA.debugLine="Clients.Put(id, ch)";
_clients.Put((Object)(_id),(Object)(_ch));
RDebugUtils.currentLine=131088;
 //BA.debugLineNum = 131088;BA.debugLine="ch.Send(\"Welcome \" & id & CRLF)";
_ch._send /*String*/ (null,"Welcome "+_id+anywheresoftware.b4a.keywords.Common.CRLF);
RDebugUtils.currentLine=131090;
 //BA.debugLineNum = 131090;BA.debugLine="Server.Listen			'Listen for next connection";
_server.Listen();
RDebugUtils.currentLine=131091;
 //BA.debugLineNum = 131091;BA.debugLine="End Sub";
return "";
}
}