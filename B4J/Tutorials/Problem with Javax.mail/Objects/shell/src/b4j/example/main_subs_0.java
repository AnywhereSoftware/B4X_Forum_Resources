package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _appstart(RemoteObject _form1,RemoteObject _args) throws Exception{
try {
		Debug.PushSubsStack("AppStart (main) ","main",0,main.ba,main.mostCurrent,18);
if (RapidSub.canDelegate("appstart")) { return b4j.example.main.remoteMe.runUserSub(false, "main","appstart", _form1, _args);}
Debug.locals.put("Form1", _form1);
Debug.locals.put("Args", _args);
 BA.debugLineNum = 18;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
Debug.ShouldStop(131072);
 BA.debugLineNum = 19;BA.debugLine="MainForm = Form1";
Debug.ShouldStop(262144);
main._mainform = _form1;
 BA.debugLineNum = 20;BA.debugLine="MainForm.RootPane.LoadLayout(\"Layout1\")";
Debug.ShouldStop(524288);
main._mainform.runMethod(false,"getRootPane").runMethodAndSync(false,"LoadLayout",main.ba,(Object)(RemoteObject.createImmutable("Layout1")));
 BA.debugLineNum = 21;BA.debugLine="MainForm.Show";
Debug.ShouldStop(1048576);
main._mainform.runVoidMethodAndSync ("Show");
 BA.debugLineNum = 26;BA.debugLine="End Sub";
Debug.ShouldStop(33554432);
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
		Debug.PushSubsStack("Button1_Click (main) ","main",0,main.ba,main.mostCurrent,28);
if (RapidSub.canDelegate("button1_click")) { return b4j.example.main.remoteMe.runUserSub(false, "main","button1_click");}
RemoteObject _server = RemoteObject.createImmutable("");
RemoteObject _utente = RemoteObject.createImmutable("");
RemoteObject _password = RemoteObject.createImmutable("");
RemoteObject _porta = RemoteObject.createImmutable("");
 BA.debugLineNum = 28;BA.debugLine="Sub Button1_Click";
Debug.ShouldStop(134217728);
 BA.debugLineNum = 29;BA.debugLine="Dim server As String = \"imap.navico-online.com\" '";
Debug.ShouldStop(268435456);
_server = BA.ObjectToString("imap.navico-online.com");Debug.locals.put("server", _server);Debug.locals.put("server", _server);
 BA.debugLineNum = 31;BA.debugLine="Dim utente As String = \"infovendite@navico-online";
Debug.ShouldStop(1073741824);
_utente = BA.ObjectToString("infovendite@navico-online.com");Debug.locals.put("utente", _utente);Debug.locals.put("utente", _utente);
 BA.debugLineNum = 32;BA.debugLine="Dim password As String = \"2021!Siricomincia\"";
Debug.ShouldStop(-2147483648);
_password = BA.ObjectToString("2021!Siricomincia");Debug.locals.put("password", _password);Debug.locals.put("password", _password);
 BA.debugLineNum = 33;BA.debugLine="Dim porta As String = \"143\" ' Porta IMAP";
Debug.ShouldStop(1);
_porta = BA.ObjectToString("143");Debug.locals.put("porta", _porta);Debug.locals.put("porta", _porta);
 BA.debugLineNum = 35;BA.debugLine="EstrarreIndirizziEmail(server, utente, password,";
Debug.ShouldStop(4);
_estrarreindirizziemail(_server,_utente,_password,_porta);
 BA.debugLineNum = 36;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _estraiemail(RemoteObject _content) throws Exception{
try {
		Debug.PushSubsStack("EstraiEmail (main) ","main",0,main.ba,main.mostCurrent,111);
if (RapidSub.canDelegate("estraiemail")) { return b4j.example.main.remoteMe.runUserSub(false, "main","estraiemail", _content);}
RemoteObject _emaillist = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _pattern = RemoteObject.createImmutable("");
RemoteObject _matcher = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Regex.MatcherWrapper");
Debug.locals.put("content", _content);
 BA.debugLineNum = 111;BA.debugLine="Sub EstraiEmail(content As String) As List";
Debug.ShouldStop(16384);
 BA.debugLineNum = 112;BA.debugLine="Dim emailList As List";
Debug.ShouldStop(32768);
_emaillist = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("emailList", _emaillist);
 BA.debugLineNum = 113;BA.debugLine="emailList.Initialize";
Debug.ShouldStop(65536);
_emaillist.runVoidMethod ("Initialize");
 BA.debugLineNum = 114;BA.debugLine="Dim pattern As String = \"([a-zA-Z0-9._%+-]+@[a-zA";
Debug.ShouldStop(131072);
_pattern = BA.ObjectToString("([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6})");Debug.locals.put("pattern", _pattern);Debug.locals.put("pattern", _pattern);
 BA.debugLineNum = 115;BA.debugLine="Dim matcher As Matcher";
Debug.ShouldStop(262144);
_matcher = RemoteObject.createNew ("anywheresoftware.b4a.keywords.Regex.MatcherWrapper");Debug.locals.put("matcher", _matcher);
 BA.debugLineNum = 116;BA.debugLine="matcher = Regex.Matcher(pattern, content)";
Debug.ShouldStop(524288);
_matcher = main.__c.getField(false,"Regex").runMethod(false,"Matcher",(Object)(_pattern),(Object)(_content));Debug.locals.put("matcher", _matcher);
 BA.debugLineNum = 117;BA.debugLine="Do While matcher.Find";
Debug.ShouldStop(1048576);
while (_matcher.runMethod(true,"Find").<Boolean>get().booleanValue()) {
 BA.debugLineNum = 118;BA.debugLine="emailList.Add(matcher.Match)";
Debug.ShouldStop(2097152);
_emaillist.runVoidMethod ("Add",(Object)((_matcher.runMethod(true,"getMatch"))));
 }
;
 BA.debugLineNum = 120;BA.debugLine="Return emailList";
Debug.ShouldStop(8388608);
if (true) return _emaillist;
 BA.debugLineNum = 121;BA.debugLine="End Sub";
Debug.ShouldStop(16777216);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _estraiemailfrommultipart(RemoteObject _multipart) throws Exception{
try {
		Debug.PushSubsStack("EstraiEmailFromMultipart (main) ","main",0,main.ba,main.mostCurrent,123);
if (RapidSub.canDelegate("estraiemailfrommultipart")) { return b4j.example.main.remoteMe.runUserSub(false, "main","estraiemailfrommultipart", _multipart);}
RemoteObject _emaillist = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _count = RemoteObject.createImmutable(0);
int _i = 0;
RemoteObject _part = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _content = RemoteObject.createImmutable("");
RemoteObject _submultipart = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
Debug.locals.put("multipart", _multipart);
 BA.debugLineNum = 123;BA.debugLine="Sub EstraiEmailFromMultipart(multipart As JavaObje";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 124;BA.debugLine="Dim emailList As List";
Debug.ShouldStop(134217728);
_emaillist = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("emailList", _emaillist);
 BA.debugLineNum = 125;BA.debugLine="emailList.Initialize";
Debug.ShouldStop(268435456);
_emaillist.runVoidMethod ("Initialize");
 BA.debugLineNum = 126;BA.debugLine="Dim count As Int = multipart.RunMethod(\"getCount\"";
Debug.ShouldStop(536870912);
_count = BA.numberCast(int.class, _multipart.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getCount")),(Object)((main.__c.getField(false,"Null")))));Debug.locals.put("count", _count);Debug.locals.put("count", _count);
 BA.debugLineNum = 127;BA.debugLine="For i = 0 To count - 1";
Debug.ShouldStop(1073741824);
{
final int step4 = 1;
final int limit4 = RemoteObject.solve(new RemoteObject[] {_count,RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step4 > 0 && _i <= limit4) || (step4 < 0 && _i >= limit4) ;_i = ((int)(0 + _i + step4))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 128;BA.debugLine="Dim part As JavaObject = multipart.RunMethod(\"ge";
Debug.ShouldStop(-2147483648);
_part = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_part = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _multipart.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getBodyPart")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {RemoteObject.createImmutable((_i))}))));Debug.locals.put("part", _part);Debug.locals.put("part", _part);
 BA.debugLineNum = 129;BA.debugLine="If part.RunMethod(\"isMimeType\", Array(\"text/plai";
Debug.ShouldStop(1);
if (BA.ObjectToBoolean(_part.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("isMimeType")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(RemoteObject.createImmutable("text/plain"))})))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 130;BA.debugLine="Dim content As String = part.RunMethod(\"getCont";
Debug.ShouldStop(2);
_content = BA.ObjectToString(_part.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getContent")),(Object)((main.__c.getField(false,"Null")))));Debug.locals.put("content", _content);Debug.locals.put("content", _content);
 BA.debugLineNum = 131;BA.debugLine="emailList.AddAll(EstraiEmail(content))";
Debug.ShouldStop(4);
_emaillist.runVoidMethod ("AddAll",(Object)(_estraiemail(_content)));
 }else 
{ BA.debugLineNum = 132;BA.debugLine="Else If part.RunMethod(\"isMimeType\", Array(\"mult";
Debug.ShouldStop(8);
if (BA.ObjectToBoolean(_part.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("isMimeType")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(RemoteObject.createImmutable("multipart/*"))})))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 133;BA.debugLine="Dim subMultipart As JavaObject = part.RunMethod";
Debug.ShouldStop(16);
_submultipart = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_submultipart = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _part.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getContent")),(Object)((main.__c.getField(false,"Null")))));Debug.locals.put("subMultipart", _submultipart);Debug.locals.put("subMultipart", _submultipart);
 BA.debugLineNum = 134;BA.debugLine="emailList.AddAll(EstraiEmailFromMultipart(subMu";
Debug.ShouldStop(32);
_emaillist.runVoidMethod ("AddAll",(Object)(_estraiemailfrommultipart(_submultipart)));
 }}
;
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 137;BA.debugLine="Return emailList";
Debug.ShouldStop(256);
if (true) return _emaillist;
 BA.debugLineNum = 138;BA.debugLine="End Sub";
Debug.ShouldStop(512);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _estrarreindirizziemail(RemoteObject _server,RemoteObject _utente,RemoteObject _password,RemoteObject _porta) throws Exception{
try {
		Debug.PushSubsStack("EstrarreIndirizziEmail (main) ","main",0,main.ba,main.mostCurrent,38);
if (RapidSub.canDelegate("estrarreindirizziemail")) { return b4j.example.main.remoteMe.runUserSub(false, "main","estrarreindirizziemail", _server, _utente, _password, _porta);}
RemoteObject _props = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _session = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _store = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _folder = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _messages = null;
RemoteObject _indirizzi_email = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _conta = RemoteObject.createImmutable(0);
RemoteObject _msg = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _content = RemoteObject.createImmutable("");
RemoteObject _multipart = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _unici_indirizzi_email = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _indirizzo = RemoteObject.createImmutable("");
RemoteObject _email = RemoteObject.createImmutable("");
Debug.locals.put("server", _server);
Debug.locals.put("utente", _utente);
Debug.locals.put("password", _password);
Debug.locals.put("porta", _porta);
 BA.debugLineNum = 38;BA.debugLine="Sub EstrarreIndirizziEmail(server As String, utent";
Debug.ShouldStop(32);
 BA.debugLineNum = 39;BA.debugLine="Try";
Debug.ShouldStop(64);
try { BA.debugLineNum = 40;BA.debugLine="Log(\"Inizio configurazione JavaMail\")";
Debug.ShouldStop(128);
main.__c.runVoidMethod ("LogImpl","8196610",RemoteObject.createImmutable("Inizio configurazione JavaMail"),0);
 BA.debugLineNum = 43;BA.debugLine="Dim props As JavaObject";
Debug.ShouldStop(1024);
_props = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");Debug.locals.put("props", _props);
 BA.debugLineNum = 44;BA.debugLine="props.InitializeNewInstance(\"java.util.Propertie";
Debug.ShouldStop(2048);
_props.runVoidMethod ("InitializeNewInstance",(Object)(BA.ObjectToString("java.util.Properties")),(Object)((main.__c.getField(false,"Null"))));
 BA.debugLineNum = 45;BA.debugLine="props.RunMethod(\"put\", Array(\"mail.store.protoco";
Debug.ShouldStop(4096);
_props.runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("put")),(Object)(RemoteObject.createNewArray("Object",new int[] {2},new Object[] {RemoteObject.createImmutable(("mail.store.protocol")),(RemoteObject.createImmutable("imaps"))})));
 BA.debugLineNum = 46;BA.debugLine="props.RunMethod(\"put\", Array(\"mail.imap.port\", p";
Debug.ShouldStop(8192);
_props.runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("put")),(Object)(RemoteObject.createNewArray("Object",new int[] {2},new Object[] {RemoteObject.createImmutable(("mail.imap.port")),(_porta)})));
 BA.debugLineNum = 48;BA.debugLine="Dim session As JavaObject";
Debug.ShouldStop(32768);
_session = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");Debug.locals.put("session", _session);
 BA.debugLineNum = 49;BA.debugLine="session.InitializeStatic(\"javax.mail.Session\")";
Debug.ShouldStop(65536);
_session.runVoidMethod ("InitializeStatic",(Object)(RemoteObject.createImmutable("javax.mail.Session")));
 BA.debugLineNum = 50;BA.debugLine="session = session.RunMethod(\"getInstance\", Array";
Debug.ShouldStop(131072);
_session = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _session.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getInstance")),(Object)(RemoteObject.createNewArray("Object",new int[] {2},new Object[] {(_props.getObject()),main.__c.getField(false,"Null")}))));Debug.locals.put("session", _session);
 BA.debugLineNum = 52;BA.debugLine="Log(\"Configurazione JavaMail completata\")";
Debug.ShouldStop(524288);
main.__c.runVoidMethod ("LogImpl","8196622",RemoteObject.createImmutable("Configurazione JavaMail completata"),0);
 BA.debugLineNum = 55;BA.debugLine="Dim store As JavaObject = session.RunMethod(\"get";
Debug.ShouldStop(4194304);
_store = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_store = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _session.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getStore")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(RemoteObject.createImmutable("imaps"))}))));Debug.locals.put("store", _store);Debug.locals.put("store", _store);
 BA.debugLineNum = 56;BA.debugLine="store.RunMethod(\"connect\", Array(server, utente,";
Debug.ShouldStop(8388608);
_store.runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("connect")),(Object)(RemoteObject.createNewArray("Object",new int[] {3},new Object[] {(_server),(_utente),(_password)})));
 BA.debugLineNum = 57;BA.debugLine="Log(\"Connessione al server IMAP completata\")";
Debug.ShouldStop(16777216);
main.__c.runVoidMethod ("LogImpl","8196627",RemoteObject.createImmutable("Connessione al server IMAP completata"),0);
 BA.debugLineNum = 60;BA.debugLine="Dim folder As JavaObject = store.RunMethod(\"getF";
Debug.ShouldStop(134217728);
_folder = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_folder = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _store.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getFolder")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(RemoteObject.createImmutable("inbox"))}))));Debug.locals.put("folder", _folder);Debug.locals.put("folder", _folder);
 BA.debugLineNum = 61;BA.debugLine="folder.RunMethod(\"open\", Array(2)) ' 2 = READ_ON";
Debug.ShouldStop(268435456);
_folder.runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("open")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {RemoteObject.createImmutable((2))})));
 BA.debugLineNum = 62;BA.debugLine="Log(\"Apertura cartella 'inbox' completata\")";
Debug.ShouldStop(536870912);
main.__c.runVoidMethod ("LogImpl","8196632",RemoteObject.createImmutable("Apertura cartella 'inbox' completata"),0);
 BA.debugLineNum = 65;BA.debugLine="Dim messages() As Object";
Debug.ShouldStop(1);
_messages = RemoteObject.createNewArray ("Object", new int[] {0}, new Object[]{});Debug.locals.put("messages", _messages);
 BA.debugLineNum = 66;BA.debugLine="messages = folder.RunMethod(\"getMessages\", Null)";
Debug.ShouldStop(2);
_messages = (_folder.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getMessages")),(Object)((main.__c.getField(false,"Null")))));Debug.locals.put("messages", _messages);
 BA.debugLineNum = 68;BA.debugLine="Dim indirizzi_email As List";
Debug.ShouldStop(8);
_indirizzi_email = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("indirizzi_email", _indirizzi_email);
 BA.debugLineNum = 69;BA.debugLine="indirizzi_email.Initialize";
Debug.ShouldStop(16);
_indirizzi_email.runVoidMethod ("Initialize");
 BA.debugLineNum = 72;BA.debugLine="Log(\"Numero di messaggi nella inbox: \" & message";
Debug.ShouldStop(128);
main.__c.runVoidMethod ("LogImpl","8196642",RemoteObject.concat(RemoteObject.createImmutable("Numero di messaggi nella inbox: "),_messages.getField(true,"length")),0);
 BA.debugLineNum = 73;BA.debugLine="Dim conta As Int";
Debug.ShouldStop(256);
_conta = RemoteObject.createImmutable(0);Debug.locals.put("conta", _conta);
 BA.debugLineNum = 74;BA.debugLine="For Each msg As JavaObject In messages";
Debug.ShouldStop(512);
_msg = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
{
final RemoteObject group23 = _messages;
final int groupLen23 = group23.getField(true,"length").<Integer>get()
;int index23 = 0;
;
for (; index23 < groupLen23;index23++){
_msg = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), group23.getArrayElement(false,RemoteObject.createImmutable(index23)));Debug.locals.put("msg", _msg);
Debug.locals.put("msg", _msg);
 BA.debugLineNum = 76;BA.debugLine="If msg.RunMethod(\"isMimeType\", Array(\"text/plai";
Debug.ShouldStop(2048);
if (BA.ObjectToBoolean(_msg.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("isMimeType")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(RemoteObject.createImmutable("text/plain"))})))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 77;BA.debugLine="conta=conta+1";
Debug.ShouldStop(4096);
_conta = RemoteObject.solve(new RemoteObject[] {_conta,RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("conta", _conta);
 BA.debugLineNum = 78;BA.debugLine="Log(conta)";
Debug.ShouldStop(8192);
main.__c.runVoidMethod ("LogImpl","8196648",BA.NumberToString(_conta),0);
 BA.debugLineNum = 79;BA.debugLine="Dim content As String = msg.RunMethod(\"getCont";
Debug.ShouldStop(16384);
_content = BA.ObjectToString(_msg.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getContent")),(Object)((main.__c.getField(false,"Null")))));Debug.locals.put("content", _content);Debug.locals.put("content", _content);
 BA.debugLineNum = 80;BA.debugLine="indirizzi_email.AddAll(EstraiEmail(content))";
Debug.ShouldStop(32768);
_indirizzi_email.runVoidMethod ("AddAll",(Object)(_estraiemail(_content)));
 }else 
{ BA.debugLineNum = 81;BA.debugLine="Else If msg.RunMethod(\"isMimeType\", Array(\"mult";
Debug.ShouldStop(65536);
if (BA.ObjectToBoolean(_msg.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("isMimeType")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(RemoteObject.createImmutable("multipart/*"))})))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 82;BA.debugLine="conta=conta+1";
Debug.ShouldStop(131072);
_conta = RemoteObject.solve(new RemoteObject[] {_conta,RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("conta", _conta);
 BA.debugLineNum = 83;BA.debugLine="Log(conta)";
Debug.ShouldStop(262144);
main.__c.runVoidMethod ("LogImpl","8196653",BA.NumberToString(_conta),0);
 BA.debugLineNum = 84;BA.debugLine="Dim multipart As JavaObject = msg.RunMethod(\"g";
Debug.ShouldStop(524288);
_multipart = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_multipart = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _msg.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getContent")),(Object)((main.__c.getField(false,"Null")))));Debug.locals.put("multipart", _multipart);Debug.locals.put("multipart", _multipart);
 BA.debugLineNum = 85;BA.debugLine="indirizzi_email.AddAll(EstraiEmailFromMultipar";
Debug.ShouldStop(1048576);
_indirizzi_email.runVoidMethod ("AddAll",(Object)(_estraiemailfrommultipart(_multipart)));
 }}
;
 }
}Debug.locals.put("msg", _msg);
;
 BA.debugLineNum = 90;BA.debugLine="Dim unici_indirizzi_email As List";
Debug.ShouldStop(33554432);
_unici_indirizzi_email = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("unici_indirizzi_email", _unici_indirizzi_email);
 BA.debugLineNum = 91;BA.debugLine="unici_indirizzi_email.Initialize";
Debug.ShouldStop(67108864);
_unici_indirizzi_email.runVoidMethod ("Initialize");
 BA.debugLineNum = 92;BA.debugLine="For Each indirizzo As String In indirizzi_email";
Debug.ShouldStop(134217728);
{
final RemoteObject group38 = _indirizzi_email;
final int groupLen38 = group38.runMethod(true,"getSize").<Integer>get()
;int index38 = 0;
;
for (; index38 < groupLen38;index38++){
_indirizzo = BA.ObjectToString(group38.runMethod(false,"Get",index38));Debug.locals.put("indirizzo", _indirizzo);
Debug.locals.put("indirizzo", _indirizzo);
 BA.debugLineNum = 93;BA.debugLine="If unici_indirizzi_email.IndexOf(indirizzo) = -";
Debug.ShouldStop(268435456);
if (RemoteObject.solveBoolean("=",_unici_indirizzi_email.runMethod(true,"IndexOf",(Object)((_indirizzo))),BA.numberCast(double.class, -(double) (0 + 1)))) { 
 BA.debugLineNum = 94;BA.debugLine="unici_indirizzi_email.Add(indirizzo)";
Debug.ShouldStop(536870912);
_unici_indirizzi_email.runVoidMethod ("Add",(Object)((_indirizzo)));
 };
 }
}Debug.locals.put("indirizzo", _indirizzo);
;
 BA.debugLineNum = 99;BA.debugLine="ScriviFileIndirizziEmail(unici_indirizzi_email)";
Debug.ShouldStop(4);
_scrivifileindirizziemail(_unici_indirizzi_email);
 BA.debugLineNum = 102;BA.debugLine="For Each email As String In unici_indirizzi_emai";
Debug.ShouldStop(32);
{
final RemoteObject group44 = _unici_indirizzi_email;
final int groupLen44 = group44.runMethod(true,"getSize").<Integer>get()
;int index44 = 0;
;
for (; index44 < groupLen44;index44++){
_email = BA.ObjectToString(group44.runMethod(false,"Get",index44));Debug.locals.put("email", _email);
Debug.locals.put("email", _email);
 BA.debugLineNum = 103;BA.debugLine="Log(email)";
Debug.ShouldStop(64);
main.__c.runVoidMethod ("LogImpl","8196673",_email,0);
 }
}Debug.locals.put("email", _email);
;
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e48) {
			BA.rdebugUtils.runVoidMethod("setLastException",main.ba, e48.toString()); BA.debugLineNum = 107;BA.debugLine="Log(LastException.Message)";
Debug.ShouldStop(1024);
main.__c.runVoidMethod ("LogImpl","8196677",main.__c.runMethod(false,"LastException",main.ba).runMethod(true,"getMessage"),0);
 };
 BA.debugLineNum = 109;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
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
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 8;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 9;BA.debugLine="Private fx As JFX";
main._fx = RemoteObject.createNew ("anywheresoftware.b4j.objects.JFX");
 //BA.debugLineNum = 10;BA.debugLine="Private MainForm As Form";
main._mainform = RemoteObject.createNew ("anywheresoftware.b4j.objects.Form");
 //BA.debugLineNum = 11;BA.debugLine="Private xui As XUI";
main._xui = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");
 //BA.debugLineNum = 12;BA.debugLine="Private Button1 As B4XView";
main._button1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");
 //BA.debugLineNum = 14;BA.debugLine="Private Label1 As Label";
main._label1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");
 //BA.debugLineNum = 15;BA.debugLine="Private TextArea1 As B4XView";
main._textarea1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");
 //BA.debugLineNum = 16;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _scrivifileindirizziemail(RemoteObject _indirizzi) throws Exception{
try {
		Debug.PushSubsStack("ScriviFileIndirizziEmail (main) ","main",0,main.ba,main.mostCurrent,140);
if (RapidSub.canDelegate("scrivifileindirizziemail")) { return b4j.example.main.remoteMe.runUserSub(false, "main","scrivifileindirizziemail", _indirizzi);}
RemoteObject _outputstream = RemoteObject.declareNull("anywheresoftware.b4a.objects.streams.File.OutputStreamWrapper");
RemoteObject _email = RemoteObject.createImmutable("");
Debug.locals.put("indirizzi", _indirizzi);
 BA.debugLineNum = 140;BA.debugLine="Sub ScriviFileIndirizziEmail(indirizzi As List)";
Debug.ShouldStop(2048);
 BA.debugLineNum = 141;BA.debugLine="Dim outputStream As OutputStream";
Debug.ShouldStop(4096);
_outputstream = RemoteObject.createNew ("anywheresoftware.b4a.objects.streams.File.OutputStreamWrapper");Debug.locals.put("outputStream", _outputstream);
 BA.debugLineNum = 142;BA.debugLine="outputStream = File.OpenOutput(File.DirApp, \"indi";
Debug.ShouldStop(8192);
_outputstream = main.__c.getField(false,"File").runMethod(false,"OpenOutput",(Object)(main.__c.getField(false,"File").runMethod(true,"getDirApp")),(Object)(BA.ObjectToString("indirizzi_email.txt")),(Object)(main.__c.getField(true,"False")));Debug.locals.put("outputStream", _outputstream);
 BA.debugLineNum = 143;BA.debugLine="For Each email As String In indirizzi";
Debug.ShouldStop(16384);
{
final RemoteObject group3 = _indirizzi;
final int groupLen3 = group3.runMethod(true,"getSize").<Integer>get()
;int index3 = 0;
;
for (; index3 < groupLen3;index3++){
_email = BA.ObjectToString(group3.runMethod(false,"Get",index3));Debug.locals.put("email", _email);
Debug.locals.put("email", _email);
 BA.debugLineNum = 144;BA.debugLine="outputStream.WriteBytes(email.GetBytes(\"UTF8\"),";
Debug.ShouldStop(32768);
_outputstream.runVoidMethod ("WriteBytes",(Object)(_email.runMethod(false,"getBytes",(Object)(RemoteObject.createImmutable("UTF8")))),(Object)(BA.numberCast(int.class, 0)),(Object)(_email.runMethod(true,"length")));
 BA.debugLineNum = 145;BA.debugLine="outputStream.WriteBytes(CRLF.GetBytes(\"UTF8\"), 0";
Debug.ShouldStop(65536);
_outputstream.runVoidMethod ("WriteBytes",(Object)(main.__c.getField(true,"CRLF").runMethod(false,"getBytes",(Object)(RemoteObject.createImmutable("UTF8")))),(Object)(BA.numberCast(int.class, 0)),(Object)(main.__c.getField(true,"CRLF").runMethod(true,"length")));
 BA.debugLineNum = 146;BA.debugLine="Log(email) ' Aggiunto per il log";
Debug.ShouldStop(131072);
main.__c.runVoidMethod ("LogImpl","8393222",_email,0);
 BA.debugLineNum = 148;BA.debugLine="TextArea1.Text = TextArea1.Text & email & CRLF";
Debug.ShouldStop(524288);
main._textarea1.runMethod(true,"setText",RemoteObject.concat(main._textarea1.runMethod(true,"getText"),_email,main.__c.getField(true,"CRLF")));
 }
}Debug.locals.put("email", _email);
;
 BA.debugLineNum = 151;BA.debugLine="outputStream.Close";
Debug.ShouldStop(4194304);
_outputstream.runVoidMethod ("Close");
 BA.debugLineNum = 153;BA.debugLine="Label1.Text=\"Finito\"";
Debug.ShouldStop(16777216);
main._label1.runMethod(true,"setText",BA.ObjectToString("Finito"));
 BA.debugLineNum = 154;BA.debugLine="End Sub";
Debug.ShouldStop(33554432);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}