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
public static anywheresoftware.b4j.objects.LabelWrapper _label1 = null;
public static anywheresoftware.b4a.objects.B4XViewWrapper _textarea1 = null;
public static String  _appstart(anywheresoftware.b4j.objects.Form _form1,String[] _args) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "appstart", false))
	 {return ((String) Debug.delegate(ba, "appstart", new Object[] {_form1,_args}));}
RDebugUtils.currentLine=65536;
 //BA.debugLineNum = 65536;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
RDebugUtils.currentLine=65537;
 //BA.debugLineNum = 65537;BA.debugLine="MainForm = Form1";
_mainform = _form1;
RDebugUtils.currentLine=65538;
 //BA.debugLineNum = 65538;BA.debugLine="MainForm.RootPane.LoadLayout(\"Layout1\")";
_mainform.getRootPane().LoadLayout(ba,"Layout1");
RDebugUtils.currentLine=65539;
 //BA.debugLineNum = 65539;BA.debugLine="MainForm.Show";
_mainform.Show();
RDebugUtils.currentLine=65544;
 //BA.debugLineNum = 65544;BA.debugLine="End Sub";
return "";
}
public static String  _button1_click() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "button1_click", false))
	 {return ((String) Debug.delegate(ba, "button1_click", null));}
String _server = "";
String _utente = "";
String _password = "";
String _porta = "";
RDebugUtils.currentLine=131072;
 //BA.debugLineNum = 131072;BA.debugLine="Sub Button1_Click";
RDebugUtils.currentLine=131073;
 //BA.debugLineNum = 131073;BA.debugLine="Dim server As String = \"imap.navico-online.com\" '";
_server = "imap.navico-online.com";
RDebugUtils.currentLine=131075;
 //BA.debugLineNum = 131075;BA.debugLine="Dim utente As String = \"infovendite@navico-online";
_utente = "infovendite@navico-online.com";
RDebugUtils.currentLine=131076;
 //BA.debugLineNum = 131076;BA.debugLine="Dim password As String = \"2021!Siricomincia\"";
_password = "2021!Siricomincia";
RDebugUtils.currentLine=131077;
 //BA.debugLineNum = 131077;BA.debugLine="Dim porta As String = \"143\" ' Porta IMAP";
_porta = "143";
RDebugUtils.currentLine=131079;
 //BA.debugLineNum = 131079;BA.debugLine="EstrarreIndirizziEmail(server, utente, password,";
_estrarreindirizziemail(_server,_utente,_password,_porta);
RDebugUtils.currentLine=131080;
 //BA.debugLineNum = 131080;BA.debugLine="End Sub";
return "";
}
public static String  _estrarreindirizziemail(String _server,String _utente,String _password,String _porta) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "estrarreindirizziemail", false))
	 {return ((String) Debug.delegate(ba, "estrarreindirizziemail", new Object[] {_server,_utente,_password,_porta}));}
anywheresoftware.b4j.object.JavaObject _props = null;
anywheresoftware.b4j.object.JavaObject _session = null;
anywheresoftware.b4j.object.JavaObject _store = null;
anywheresoftware.b4j.object.JavaObject _folder = null;
Object[] _messages = null;
anywheresoftware.b4a.objects.collections.List _indirizzi_email = null;
int _conta = 0;
anywheresoftware.b4j.object.JavaObject _msg = null;
String _content = "";
anywheresoftware.b4j.object.JavaObject _multipart = null;
anywheresoftware.b4a.objects.collections.List _unici_indirizzi_email = null;
String _indirizzo = "";
String _email = "";
RDebugUtils.currentLine=196608;
 //BA.debugLineNum = 196608;BA.debugLine="Sub EstrarreIndirizziEmail(server As String, utent";
RDebugUtils.currentLine=196609;
 //BA.debugLineNum = 196609;BA.debugLine="Try";
try {RDebugUtils.currentLine=196610;
 //BA.debugLineNum = 196610;BA.debugLine="Log(\"Inizio configurazione JavaMail\")";
anywheresoftware.b4a.keywords.Common.LogImpl("8196610","Inizio configurazione JavaMail",0);
RDebugUtils.currentLine=196613;
 //BA.debugLineNum = 196613;BA.debugLine="Dim props As JavaObject";
_props = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=196614;
 //BA.debugLineNum = 196614;BA.debugLine="props.InitializeNewInstance(\"java.util.Propertie";
_props.InitializeNewInstance("java.util.Properties",(Object[])(anywheresoftware.b4a.keywords.Common.Null));
RDebugUtils.currentLine=196615;
 //BA.debugLineNum = 196615;BA.debugLine="props.RunMethod(\"put\", Array(\"mail.store.protoco";
_props.RunMethod("put",new Object[]{(Object)("mail.store.protocol"),(Object)("imaps")});
RDebugUtils.currentLine=196616;
 //BA.debugLineNum = 196616;BA.debugLine="props.RunMethod(\"put\", Array(\"mail.imap.port\", p";
_props.RunMethod("put",new Object[]{(Object)("mail.imap.port"),(Object)(_porta)});
RDebugUtils.currentLine=196618;
 //BA.debugLineNum = 196618;BA.debugLine="Dim session As JavaObject";
_session = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=196619;
 //BA.debugLineNum = 196619;BA.debugLine="session.InitializeStatic(\"javax.mail.Session\")";
_session.InitializeStatic("javax.mail.Session");
RDebugUtils.currentLine=196620;
 //BA.debugLineNum = 196620;BA.debugLine="session = session.RunMethod(\"getInstance\", Array";
_session = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_session.RunMethod("getInstance",new Object[]{(Object)(_props.getObject()),anywheresoftware.b4a.keywords.Common.Null})));
RDebugUtils.currentLine=196622;
 //BA.debugLineNum = 196622;BA.debugLine="Log(\"Configurazione JavaMail completata\")";
anywheresoftware.b4a.keywords.Common.LogImpl("8196622","Configurazione JavaMail completata",0);
RDebugUtils.currentLine=196625;
 //BA.debugLineNum = 196625;BA.debugLine="Dim store As JavaObject = session.RunMethod(\"get";
_store = new anywheresoftware.b4j.object.JavaObject();
_store = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_session.RunMethod("getStore",new Object[]{(Object)("imaps")})));
RDebugUtils.currentLine=196626;
 //BA.debugLineNum = 196626;BA.debugLine="store.RunMethod(\"connect\", Array(server, utente,";
_store.RunMethod("connect",new Object[]{(Object)(_server),(Object)(_utente),(Object)(_password)});
RDebugUtils.currentLine=196627;
 //BA.debugLineNum = 196627;BA.debugLine="Log(\"Connessione al server IMAP completata\")";
anywheresoftware.b4a.keywords.Common.LogImpl("8196627","Connessione al server IMAP completata",0);
RDebugUtils.currentLine=196630;
 //BA.debugLineNum = 196630;BA.debugLine="Dim folder As JavaObject = store.RunMethod(\"getF";
_folder = new anywheresoftware.b4j.object.JavaObject();
_folder = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_store.RunMethod("getFolder",new Object[]{(Object)("inbox")})));
RDebugUtils.currentLine=196631;
 //BA.debugLineNum = 196631;BA.debugLine="folder.RunMethod(\"open\", Array(2)) ' 2 = READ_ON";
_folder.RunMethod("open",new Object[]{(Object)(2)});
RDebugUtils.currentLine=196632;
 //BA.debugLineNum = 196632;BA.debugLine="Log(\"Apertura cartella 'inbox' completata\")";
anywheresoftware.b4a.keywords.Common.LogImpl("8196632","Apertura cartella 'inbox' completata",0);
RDebugUtils.currentLine=196635;
 //BA.debugLineNum = 196635;BA.debugLine="Dim messages() As Object";
_messages = new Object[(int) (0)];
{
int d0 = _messages.length;
for (int i0 = 0;i0 < d0;i0++) {
_messages[i0] = new Object();
}
}
;
RDebugUtils.currentLine=196636;
 //BA.debugLineNum = 196636;BA.debugLine="messages = folder.RunMethod(\"getMessages\", Null)";
_messages = (Object[])(_folder.RunMethod("getMessages",(Object[])(anywheresoftware.b4a.keywords.Common.Null)));
RDebugUtils.currentLine=196638;
 //BA.debugLineNum = 196638;BA.debugLine="Dim indirizzi_email As List";
_indirizzi_email = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=196639;
 //BA.debugLineNum = 196639;BA.debugLine="indirizzi_email.Initialize";
_indirizzi_email.Initialize();
RDebugUtils.currentLine=196642;
 //BA.debugLineNum = 196642;BA.debugLine="Log(\"Numero di messaggi nella inbox: \" & message";
anywheresoftware.b4a.keywords.Common.LogImpl("8196642","Numero di messaggi nella inbox: "+BA.NumberToString(_messages.length),0);
RDebugUtils.currentLine=196643;
 //BA.debugLineNum = 196643;BA.debugLine="Dim conta As Int";
_conta = 0;
RDebugUtils.currentLine=196644;
 //BA.debugLineNum = 196644;BA.debugLine="For Each msg As JavaObject In messages";
_msg = new anywheresoftware.b4j.object.JavaObject();
{
final Object[] group23 = _messages;
final int groupLen23 = group23.length
;int index23 = 0;
;
for (; index23 < groupLen23;index23++){
_msg = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(group23[index23]));
RDebugUtils.currentLine=196646;
 //BA.debugLineNum = 196646;BA.debugLine="If msg.RunMethod(\"isMimeType\", Array(\"text/plai";
if (BA.ObjectToBoolean(_msg.RunMethod("isMimeType",new Object[]{(Object)("text/plain")}))) { 
RDebugUtils.currentLine=196647;
 //BA.debugLineNum = 196647;BA.debugLine="conta=conta+1";
_conta = (int) (_conta+1);
RDebugUtils.currentLine=196648;
 //BA.debugLineNum = 196648;BA.debugLine="Log(conta)";
anywheresoftware.b4a.keywords.Common.LogImpl("8196648",BA.NumberToString(_conta),0);
RDebugUtils.currentLine=196649;
 //BA.debugLineNum = 196649;BA.debugLine="Dim content As String = msg.RunMethod(\"getCont";
_content = BA.ObjectToString(_msg.RunMethod("getContent",(Object[])(anywheresoftware.b4a.keywords.Common.Null)));
RDebugUtils.currentLine=196650;
 //BA.debugLineNum = 196650;BA.debugLine="indirizzi_email.AddAll(EstraiEmail(content))";
_indirizzi_email.AddAll(_estraiemail(_content));
 }else 
{RDebugUtils.currentLine=196651;
 //BA.debugLineNum = 196651;BA.debugLine="Else If msg.RunMethod(\"isMimeType\", Array(\"mult";
if (BA.ObjectToBoolean(_msg.RunMethod("isMimeType",new Object[]{(Object)("multipart/*")}))) { 
RDebugUtils.currentLine=196652;
 //BA.debugLineNum = 196652;BA.debugLine="conta=conta+1";
_conta = (int) (_conta+1);
RDebugUtils.currentLine=196653;
 //BA.debugLineNum = 196653;BA.debugLine="Log(conta)";
anywheresoftware.b4a.keywords.Common.LogImpl("8196653",BA.NumberToString(_conta),0);
RDebugUtils.currentLine=196654;
 //BA.debugLineNum = 196654;BA.debugLine="Dim multipart As JavaObject = msg.RunMethod(\"g";
_multipart = new anywheresoftware.b4j.object.JavaObject();
_multipart = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_msg.RunMethod("getContent",(Object[])(anywheresoftware.b4a.keywords.Common.Null))));
RDebugUtils.currentLine=196655;
 //BA.debugLineNum = 196655;BA.debugLine="indirizzi_email.AddAll(EstraiEmailFromMultipar";
_indirizzi_email.AddAll(_estraiemailfrommultipart(_multipart));
 }}
;
 }
};
RDebugUtils.currentLine=196660;
 //BA.debugLineNum = 196660;BA.debugLine="Dim unici_indirizzi_email As List";
_unici_indirizzi_email = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=196661;
 //BA.debugLineNum = 196661;BA.debugLine="unici_indirizzi_email.Initialize";
_unici_indirizzi_email.Initialize();
RDebugUtils.currentLine=196662;
 //BA.debugLineNum = 196662;BA.debugLine="For Each indirizzo As String In indirizzi_email";
{
final anywheresoftware.b4a.BA.IterableList group38 = _indirizzi_email;
final int groupLen38 = group38.getSize()
;int index38 = 0;
;
for (; index38 < groupLen38;index38++){
_indirizzo = BA.ObjectToString(group38.Get(index38));
RDebugUtils.currentLine=196663;
 //BA.debugLineNum = 196663;BA.debugLine="If unici_indirizzi_email.IndexOf(indirizzo) = -";
if (_unici_indirizzi_email.IndexOf((Object)(_indirizzo))==-1) { 
RDebugUtils.currentLine=196664;
 //BA.debugLineNum = 196664;BA.debugLine="unici_indirizzi_email.Add(indirizzo)";
_unici_indirizzi_email.Add((Object)(_indirizzo));
 };
 }
};
RDebugUtils.currentLine=196669;
 //BA.debugLineNum = 196669;BA.debugLine="ScriviFileIndirizziEmail(unici_indirizzi_email)";
_scrivifileindirizziemail(_unici_indirizzi_email);
RDebugUtils.currentLine=196672;
 //BA.debugLineNum = 196672;BA.debugLine="For Each email As String In unici_indirizzi_emai";
{
final anywheresoftware.b4a.BA.IterableList group44 = _unici_indirizzi_email;
final int groupLen44 = group44.getSize()
;int index44 = 0;
;
for (; index44 < groupLen44;index44++){
_email = BA.ObjectToString(group44.Get(index44));
RDebugUtils.currentLine=196673;
 //BA.debugLineNum = 196673;BA.debugLine="Log(email)";
anywheresoftware.b4a.keywords.Common.LogImpl("8196673",_email,0);
 }
};
 } 
       catch (Exception e48) {
			ba.setLastException(e48);RDebugUtils.currentLine=196677;
 //BA.debugLineNum = 196677;BA.debugLine="Log(LastException.Message)";
anywheresoftware.b4a.keywords.Common.LogImpl("8196677",anywheresoftware.b4a.keywords.Common.LastException(ba).getMessage(),0);
 };
RDebugUtils.currentLine=196679;
 //BA.debugLineNum = 196679;BA.debugLine="End Sub";
return "";
}
public static anywheresoftware.b4a.objects.collections.List  _estraiemail(String _content) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "estraiemail", false))
	 {return ((anywheresoftware.b4a.objects.collections.List) Debug.delegate(ba, "estraiemail", new Object[] {_content}));}
anywheresoftware.b4a.objects.collections.List _emaillist = null;
String _pattern = "";
anywheresoftware.b4a.keywords.Regex.MatcherWrapper _matcher = null;
RDebugUtils.currentLine=262144;
 //BA.debugLineNum = 262144;BA.debugLine="Sub EstraiEmail(content As String) As List";
RDebugUtils.currentLine=262145;
 //BA.debugLineNum = 262145;BA.debugLine="Dim emailList As List";
_emaillist = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=262146;
 //BA.debugLineNum = 262146;BA.debugLine="emailList.Initialize";
_emaillist.Initialize();
RDebugUtils.currentLine=262147;
 //BA.debugLineNum = 262147;BA.debugLine="Dim pattern As String = \"([a-zA-Z0-9._%+-]+@[a-zA";
_pattern = "([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6})";
RDebugUtils.currentLine=262148;
 //BA.debugLineNum = 262148;BA.debugLine="Dim matcher As Matcher";
_matcher = new anywheresoftware.b4a.keywords.Regex.MatcherWrapper();
RDebugUtils.currentLine=262149;
 //BA.debugLineNum = 262149;BA.debugLine="matcher = Regex.Matcher(pattern, content)";
_matcher = anywheresoftware.b4a.keywords.Common.Regex.Matcher(_pattern,_content);
RDebugUtils.currentLine=262150;
 //BA.debugLineNum = 262150;BA.debugLine="Do While matcher.Find";
while (_matcher.Find()) {
RDebugUtils.currentLine=262151;
 //BA.debugLineNum = 262151;BA.debugLine="emailList.Add(matcher.Match)";
_emaillist.Add((Object)(_matcher.getMatch()));
 }
;
RDebugUtils.currentLine=262153;
 //BA.debugLineNum = 262153;BA.debugLine="Return emailList";
if (true) return _emaillist;
RDebugUtils.currentLine=262154;
 //BA.debugLineNum = 262154;BA.debugLine="End Sub";
return null;
}
public static anywheresoftware.b4a.objects.collections.List  _estraiemailfrommultipart(anywheresoftware.b4j.object.JavaObject _multipart) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "estraiemailfrommultipart", false))
	 {return ((anywheresoftware.b4a.objects.collections.List) Debug.delegate(ba, "estraiemailfrommultipart", new Object[] {_multipart}));}
anywheresoftware.b4a.objects.collections.List _emaillist = null;
int _count = 0;
int _i = 0;
anywheresoftware.b4j.object.JavaObject _part = null;
String _content = "";
anywheresoftware.b4j.object.JavaObject _submultipart = null;
RDebugUtils.currentLine=327680;
 //BA.debugLineNum = 327680;BA.debugLine="Sub EstraiEmailFromMultipart(multipart As JavaObje";
RDebugUtils.currentLine=327681;
 //BA.debugLineNum = 327681;BA.debugLine="Dim emailList As List";
_emaillist = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=327682;
 //BA.debugLineNum = 327682;BA.debugLine="emailList.Initialize";
_emaillist.Initialize();
RDebugUtils.currentLine=327683;
 //BA.debugLineNum = 327683;BA.debugLine="Dim count As Int = multipart.RunMethod(\"getCount\"";
_count = (int)(BA.ObjectToNumber(_multipart.RunMethod("getCount",(Object[])(anywheresoftware.b4a.keywords.Common.Null))));
RDebugUtils.currentLine=327684;
 //BA.debugLineNum = 327684;BA.debugLine="For i = 0 To count - 1";
{
final int step4 = 1;
final int limit4 = (int) (_count-1);
_i = (int) (0) ;
for (;_i <= limit4 ;_i = _i + step4 ) {
RDebugUtils.currentLine=327685;
 //BA.debugLineNum = 327685;BA.debugLine="Dim part As JavaObject = multipart.RunMethod(\"ge";
_part = new anywheresoftware.b4j.object.JavaObject();
_part = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_multipart.RunMethod("getBodyPart",new Object[]{(Object)(_i)})));
RDebugUtils.currentLine=327686;
 //BA.debugLineNum = 327686;BA.debugLine="If part.RunMethod(\"isMimeType\", Array(\"text/plai";
if (BA.ObjectToBoolean(_part.RunMethod("isMimeType",new Object[]{(Object)("text/plain")}))) { 
RDebugUtils.currentLine=327687;
 //BA.debugLineNum = 327687;BA.debugLine="Dim content As String = part.RunMethod(\"getCont";
_content = BA.ObjectToString(_part.RunMethod("getContent",(Object[])(anywheresoftware.b4a.keywords.Common.Null)));
RDebugUtils.currentLine=327688;
 //BA.debugLineNum = 327688;BA.debugLine="emailList.AddAll(EstraiEmail(content))";
_emaillist.AddAll(_estraiemail(_content));
 }else 
{RDebugUtils.currentLine=327689;
 //BA.debugLineNum = 327689;BA.debugLine="Else If part.RunMethod(\"isMimeType\", Array(\"mult";
if (BA.ObjectToBoolean(_part.RunMethod("isMimeType",new Object[]{(Object)("multipart/*")}))) { 
RDebugUtils.currentLine=327690;
 //BA.debugLineNum = 327690;BA.debugLine="Dim subMultipart As JavaObject = part.RunMethod";
_submultipart = new anywheresoftware.b4j.object.JavaObject();
_submultipart = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_part.RunMethod("getContent",(Object[])(anywheresoftware.b4a.keywords.Common.Null))));
RDebugUtils.currentLine=327691;
 //BA.debugLineNum = 327691;BA.debugLine="emailList.AddAll(EstraiEmailFromMultipart(subMu";
_emaillist.AddAll(_estraiemailfrommultipart(_submultipart));
 }}
;
 }
};
RDebugUtils.currentLine=327694;
 //BA.debugLineNum = 327694;BA.debugLine="Return emailList";
if (true) return _emaillist;
RDebugUtils.currentLine=327695;
 //BA.debugLineNum = 327695;BA.debugLine="End Sub";
return null;
}
public static String  _scrivifileindirizziemail(anywheresoftware.b4a.objects.collections.List _indirizzi) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "scrivifileindirizziemail", false))
	 {return ((String) Debug.delegate(ba, "scrivifileindirizziemail", new Object[] {_indirizzi}));}
anywheresoftware.b4a.objects.streams.File.OutputStreamWrapper _outputstream = null;
String _email = "";
RDebugUtils.currentLine=393216;
 //BA.debugLineNum = 393216;BA.debugLine="Sub ScriviFileIndirizziEmail(indirizzi As List)";
RDebugUtils.currentLine=393217;
 //BA.debugLineNum = 393217;BA.debugLine="Dim outputStream As OutputStream";
_outputstream = new anywheresoftware.b4a.objects.streams.File.OutputStreamWrapper();
RDebugUtils.currentLine=393218;
 //BA.debugLineNum = 393218;BA.debugLine="outputStream = File.OpenOutput(File.DirApp, \"indi";
_outputstream = anywheresoftware.b4a.keywords.Common.File.OpenOutput(anywheresoftware.b4a.keywords.Common.File.getDirApp(),"indirizzi_email.txt",anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=393219;
 //BA.debugLineNum = 393219;BA.debugLine="For Each email As String In indirizzi";
{
final anywheresoftware.b4a.BA.IterableList group3 = _indirizzi;
final int groupLen3 = group3.getSize()
;int index3 = 0;
;
for (; index3 < groupLen3;index3++){
_email = BA.ObjectToString(group3.Get(index3));
RDebugUtils.currentLine=393220;
 //BA.debugLineNum = 393220;BA.debugLine="outputStream.WriteBytes(email.GetBytes(\"UTF8\"),";
_outputstream.WriteBytes(_email.getBytes("UTF8"),(int) (0),_email.length());
RDebugUtils.currentLine=393221;
 //BA.debugLineNum = 393221;BA.debugLine="outputStream.WriteBytes(CRLF.GetBytes(\"UTF8\"), 0";
_outputstream.WriteBytes(anywheresoftware.b4a.keywords.Common.CRLF.getBytes("UTF8"),(int) (0),anywheresoftware.b4a.keywords.Common.CRLF.length());
RDebugUtils.currentLine=393222;
 //BA.debugLineNum = 393222;BA.debugLine="Log(email) ' Aggiunto per il log";
anywheresoftware.b4a.keywords.Common.LogImpl("8393222",_email,0);
RDebugUtils.currentLine=393224;
 //BA.debugLineNum = 393224;BA.debugLine="TextArea1.Text = TextArea1.Text & email & CRLF";
_textarea1.setText(_textarea1.getText()+_email+anywheresoftware.b4a.keywords.Common.CRLF);
 }
};
RDebugUtils.currentLine=393227;
 //BA.debugLineNum = 393227;BA.debugLine="outputStream.Close";
_outputstream.Close();
RDebugUtils.currentLine=393229;
 //BA.debugLineNum = 393229;BA.debugLine="Label1.Text=\"Finito\"";
_label1.setText("Finito");
RDebugUtils.currentLine=393230;
 //BA.debugLineNum = 393230;BA.debugLine="End Sub";
return "";
}
}