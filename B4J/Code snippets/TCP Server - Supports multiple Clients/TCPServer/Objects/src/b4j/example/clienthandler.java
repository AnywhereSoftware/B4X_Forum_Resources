package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class clienthandler extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.clienthandler", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.clienthandler.class).invoke(this, new Object[] {null});
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
public anywheresoftware.b4j.objects.JFX _fx = null;
public anywheresoftware.b4a.objects.SocketWrapper _clientsocket = null;
public anywheresoftware.b4a.randomaccessfile.AsyncStreams _ast = null;
public String _id = "";
public b4j.example.main _main = null;
public String  _send(b4j.example.clienthandler __ref,String _text) throws Exception{
__ref = this;
RDebugUtils.currentModule="clienthandler";
if (Debug.shouldDelegate(ba, "send", false))
	 {return ((String) Debug.delegate(ba, "send", new Object[] {_text}));}
RDebugUtils.currentLine=589824;
 //BA.debugLineNum = 589824;BA.debugLine="Public Sub Send(Text As String)";
RDebugUtils.currentLine=589825;
 //BA.debugLineNum = 589825;BA.debugLine="If AST.IsInitialized Then";
if (__ref._ast /*anywheresoftware.b4a.randomaccessfile.AsyncStreams*/ .IsInitialized()) { 
RDebugUtils.currentLine=589826;
 //BA.debugLineNum = 589826;BA.debugLine="AST.Write(Text.GetBytes(\"UTF8\"))";
__ref._ast /*anywheresoftware.b4a.randomaccessfile.AsyncStreams*/ .Write(_text.getBytes("UTF8"));
 };
RDebugUtils.currentLine=589828;
 //BA.debugLineNum = 589828;BA.debugLine="End Sub";
return "";
}
public String  _initialize(b4j.example.clienthandler __ref,anywheresoftware.b4a.BA _ba,anywheresoftware.b4a.objects.SocketWrapper _s,String _clientid) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="clienthandler";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba,_s,_clientid}));}
RDebugUtils.currentLine=458752;
 //BA.debugLineNum = 458752;BA.debugLine="Public Sub Initialize (s As Socket, ClientId As St";
RDebugUtils.currentLine=458753;
 //BA.debugLineNum = 458753;BA.debugLine="ClientSocket = s";
__ref._clientsocket /*anywheresoftware.b4a.objects.SocketWrapper*/  = _s;
RDebugUtils.currentLine=458754;
 //BA.debugLineNum = 458754;BA.debugLine="ID = ClientId";
__ref._id /*String*/  = _clientid;
RDebugUtils.currentLine=458756;
 //BA.debugLineNum = 458756;BA.debugLine="AST.Initialize(ClientSocket.InputStream, Clien";
__ref._ast /*anywheresoftware.b4a.randomaccessfile.AsyncStreams*/ .Initialize(ba,__ref._clientsocket /*anywheresoftware.b4a.objects.SocketWrapper*/ .getInputStream(),__ref._clientsocket /*anywheresoftware.b4a.objects.SocketWrapper*/ .getOutputStream(),"AST");
RDebugUtils.currentLine=458757;
 //BA.debugLineNum = 458757;BA.debugLine="Log(\"ClientHandler started: \" & ID)";
__c.LogImpl("3458757","ClientHandler started: "+__ref._id /*String*/ ,0);
RDebugUtils.currentLine=458758;
 //BA.debugLineNum = 458758;BA.debugLine="End Sub";
return "";
}
public String  _ast_error(b4j.example.clienthandler __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="clienthandler";
if (Debug.shouldDelegate(ba, "ast_error", false))
	 {return ((String) Debug.delegate(ba, "ast_error", null));}
RDebugUtils.currentLine=720896;
 //BA.debugLineNum = 720896;BA.debugLine="Sub AST_Error";
RDebugUtils.currentLine=720897;
 //BA.debugLineNum = 720897;BA.debugLine="Log(\"Stream error: \" & ID)";
__c.LogImpl("3720897","Stream error: "+__ref._id /*String*/ ,0);
RDebugUtils.currentLine=720898;
 //BA.debugLineNum = 720898;BA.debugLine="Close";
__ref._close /*String*/ (null);
RDebugUtils.currentLine=720899;
 //BA.debugLineNum = 720899;BA.debugLine="End Sub";
return "";
}
public String  _close(b4j.example.clienthandler __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="clienthandler";
if (Debug.shouldDelegate(ba, "close", false))
	 {return ((String) Debug.delegate(ba, "close", null));}
RDebugUtils.currentLine=786432;
 //BA.debugLineNum = 786432;BA.debugLine="Public Sub Close";
RDebugUtils.currentLine=786433;
 //BA.debugLineNum = 786433;BA.debugLine="Try";
try {RDebugUtils.currentLine=786434;
 //BA.debugLineNum = 786434;BA.debugLine="If AST.IsInitialized Then AST.Close";
if (__ref._ast /*anywheresoftware.b4a.randomaccessfile.AsyncStreams*/ .IsInitialized()) { 
__ref._ast /*anywheresoftware.b4a.randomaccessfile.AsyncStreams*/ .Close();};
RDebugUtils.currentLine=786435;
 //BA.debugLineNum = 786435;BA.debugLine="If ClientSocket.IsInitialized Then ClientS";
if (__ref._clientsocket /*anywheresoftware.b4a.objects.SocketWrapper*/ .IsInitialized()) { 
__ref._clientsocket /*anywheresoftware.b4a.objects.SocketWrapper*/ .Close();};
 } 
       catch (Exception e5) {
			ba.setLastException(e5);RDebugUtils.currentLine=786437;
 //BA.debugLineNum = 786437;BA.debugLine="Log(\"Could not close AST or ClientSocket - No bi";
__c.LogImpl("3786437","Could not close AST or ClientSocket - No big deal",0);
 };
RDebugUtils.currentLine=786441;
 //BA.debugLineNum = 786441;BA.debugLine="CallSub2(Main, \"RemoveClient\", ID)";
__c.CallSubDebug2(ba,(Object)(_main.getObject()),"RemoveClient",(Object)(__ref._id /*String*/ ));
RDebugUtils.currentLine=786442;
 //BA.debugLineNum = 786442;BA.debugLine="End Sub";
return "";
}
public String  _ast_newdata(b4j.example.clienthandler __ref,byte[] _buffer) throws Exception{
__ref = this;
RDebugUtils.currentModule="clienthandler";
if (Debug.shouldDelegate(ba, "ast_newdata", false))
	 {return ((String) Debug.delegate(ba, "ast_newdata", new Object[] {_buffer}));}
String _msg = "";
String _text = "";
RDebugUtils.currentLine=524288;
 //BA.debugLineNum = 524288;BA.debugLine="Sub AST_NewData (Buffer() As Byte)";
RDebugUtils.currentLine=524289;
 //BA.debugLineNum = 524289;BA.debugLine="Dim msg As String = BytesToString(Buffer, 0, B";
_msg = __c.BytesToString(_buffer,(int) (0),_buffer.length,"UTF8").trim();
RDebugUtils.currentLine=524290;
 //BA.debugLineNum = 524290;BA.debugLine="Log(\"From \" & ID & \": \" & msg)";
__c.LogImpl("3524290","From "+__ref._id /*String*/ +": "+_msg,0);
RDebugUtils.currentLine=524293;
 //BA.debugLineNum = 524293;BA.debugLine="Select True";
switch (BA.switchObjectToInt(__c.True,(_msg.toLowerCase()).equals("who"),_msg.toLowerCase().startsWith("broadcast "))) {
case 0: {
RDebugUtils.currentLine=524295;
 //BA.debugLineNum = 524295;BA.debugLine="Send(\"You are \" & ID)";
__ref._send /*String*/ (null,"You are "+__ref._id /*String*/ );
 break; }
case 1: {
RDebugUtils.currentLine=524298;
 //BA.debugLineNum = 524298;BA.debugLine="Dim text As String = msg.SubString(10)";
_text = _msg.substring((int) (10));
RDebugUtils.currentLine=524299;
 //BA.debugLineNum = 524299;BA.debugLine="CallSub2(Main, \"Broadcast\", ID & \": \"";
__c.CallSubDebug2(ba,(Object)(_main.getObject()),"Broadcast",(Object)(__ref._id /*String*/ +": "+_text));
 break; }
default: {
RDebugUtils.currentLine=524303;
 //BA.debugLineNum = 524303;BA.debugLine="Send(\"Echo: \" & msg)";
__ref._send /*String*/ (null,"Echo: "+_msg);
 break; }
}
;
RDebugUtils.currentLine=524305;
 //BA.debugLineNum = 524305;BA.debugLine="End Sub";
return "";
}
public String  _ast_terminated(b4j.example.clienthandler __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="clienthandler";
if (Debug.shouldDelegate(ba, "ast_terminated", false))
	 {return ((String) Debug.delegate(ba, "ast_terminated", null));}
RDebugUtils.currentLine=655360;
 //BA.debugLineNum = 655360;BA.debugLine="Sub AST_Terminated";
RDebugUtils.currentLine=655361;
 //BA.debugLineNum = 655361;BA.debugLine="Log(\"Disconnected: \" & ID)";
__c.LogImpl("3655361","Disconnected: "+__ref._id /*String*/ ,0);
RDebugUtils.currentLine=655362;
 //BA.debugLineNum = 655362;BA.debugLine="Close";
__ref._close /*String*/ (null);
RDebugUtils.currentLine=655363;
 //BA.debugLineNum = 655363;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4j.example.clienthandler __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="clienthandler";
RDebugUtils.currentLine=393216;
 //BA.debugLineNum = 393216;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=393217;
 //BA.debugLineNum = 393217;BA.debugLine="Private fx As JFX";
_fx = new anywheresoftware.b4j.objects.JFX();
RDebugUtils.currentLine=393218;
 //BA.debugLineNum = 393218;BA.debugLine="Private ClientSocket As Socket";
_clientsocket = new anywheresoftware.b4a.objects.SocketWrapper();
RDebugUtils.currentLine=393219;
 //BA.debugLineNum = 393219;BA.debugLine="Private AST As AsyncStreams					'Requires jRandom";
_ast = new anywheresoftware.b4a.randomaccessfile.AsyncStreams();
RDebugUtils.currentLine=393220;
 //BA.debugLineNum = 393220;BA.debugLine="Public ID As String";
_id = "";
RDebugUtils.currentLine=393221;
 //BA.debugLineNum = 393221;BA.debugLine="End Sub";
return "";
}
}