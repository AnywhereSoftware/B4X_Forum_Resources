package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _application_error(RemoteObject _error,RemoteObject _stacktrace) throws Exception{
try {
		Debug.PushSubsStack("Application_Error (main) ","main",0,main.ba,main.mostCurrent,26);
if (RapidSub.canDelegate("application_error")) { return b4j.example.main.remoteMe.runUserSub(false, "main","application_error", _error, _stacktrace);}
Debug.locals.put("Error", _error);
Debug.locals.put("StackTrace", _stacktrace);
 BA.debugLineNum = 26;BA.debugLine="Sub Application_Error (Error As Exception, StackTr";
Debug.ShouldStop(33554432);
 BA.debugLineNum = 27;BA.debugLine="Return True";
Debug.ShouldStop(67108864);
if (true) return main.__c.getField(true,"True");
 BA.debugLineNum = 28;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _appstart(RemoteObject _args) throws Exception{
try {
		Debug.PushSubsStack("AppStart (main) ","main",0,main.ba,main.mostCurrent,14);
if (RapidSub.canDelegate("appstart")) { return b4j.example.main.remoteMe.runUserSub(false, "main","appstart", _args);}
Debug.locals.put("Args", _args);
 BA.debugLineNum = 14;BA.debugLine="Sub AppStart (Args() As String)";
Debug.ShouldStop(8192);
 BA.debugLineNum = 15;BA.debugLine="BANano.Initialize(\"BANano\", \"BANanoWYSIWYG\",1)";
Debug.ShouldStop(16384);
main._banano.runVoidMethod ("Initialize",(Object)(BA.ObjectToString("BANano")),(Object)(BA.ObjectToString("BANanoWYSIWYG")),(Object)(BA.numberCast(long.class, 1)));
 BA.debugLineNum = 17;BA.debugLine="BANano.Header.AddCSSFile(\"index.css\")";
Debug.ShouldStop(65536);
main._banano.getField(false,"Header").runVoidMethod ("AddCSSFile",(Object)(RemoteObject.createImmutable("index.css")));
 BA.debugLineNum = 18;BA.debugLine="BANano.Header.AddCSSFile(\"Untitled1.css\")";
Debug.ShouldStop(131072);
main._banano.getField(false,"Header").runVoidMethod ("AddCSSFile",(Object)(RemoteObject.createImmutable("Untitled1.css")));
 BA.debugLineNum = 20;BA.debugLine="BANano.Build(File.DirApp)";
Debug.ShouldStop(524288);
main._banano.runVoidMethod ("Build",(Object)(main.__c.getField(false,"File").runMethod(true,"getDirApp")));
 BA.debugLineNum = 22;BA.debugLine="ExitApplication";
Debug.ShouldStop(2097152);
main.__c.runVoidMethod ("ExitApplication");
 BA.debugLineNum = 23;BA.debugLine="End Sub";
Debug.ShouldStop(4194304);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _banano_ready() throws Exception{
try {
		Debug.PushSubsStack("BANano_Ready (main) ","main",0,main.ba,main.mostCurrent,31);
if (RapidSub.canDelegate("banano_ready")) { return b4j.example.main.remoteMe.runUserSub(false, "main","banano_ready");}
RemoteObject _body = RemoteObject.declareNull("com.ab.banano.BANanoElement");
RemoteObject _init = RemoteObject.declareNull("com.ab.banano.BANanoFetchOptions");
RemoteObject _response = RemoteObject.declareNull("com.ab.banano.BANanoFetchResponse");
RemoteObject _text = RemoteObject.createImmutable("");
RemoteObject _gethtml = RemoteObject.declareNull("com.ab.banano.BANanoFetch");
 BA.debugLineNum = 31;BA.debugLine="Sub BANano_Ready()";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 32;BA.debugLine="Dim body As BANanoElement";
Debug.ShouldStop(-2147483648);
_body = RemoteObject.createNew ("com.ab.banano.BANanoElement");Debug.locals.put("body", _body);
 BA.debugLineNum = 33;BA.debugLine="body.Initialize(\"#body\")";
Debug.ShouldStop(1);
_body.runVoidMethod ("Initialize",(Object)((RemoteObject.createImmutable("#body"))));
 BA.debugLineNum = 36;BA.debugLine="Dim init As BANanoFetchOptions";
Debug.ShouldStop(8);
_init = RemoteObject.createNew ("com.ab.banano.BANanoFetchOptions");Debug.locals.put("init", _init);
 BA.debugLineNum = 37;BA.debugLine="init.Initialize";
Debug.ShouldStop(16);
_init.runVoidMethod ("Initialize");
 BA.debugLineNum = 38;BA.debugLine="init.Mode = \"no-cors\"";
Debug.ShouldStop(32);
_init.runMethod(true,"setMode",BA.ObjectToString("no-cors"));
 BA.debugLineNum = 40;BA.debugLine="Dim response As BANanoFetchResponse";
Debug.ShouldStop(128);
_response = RemoteObject.createNew ("com.ab.banano.BANanoFetchResponse");Debug.locals.put("response", _response);
 BA.debugLineNum = 41;BA.debugLine="Dim Text As String";
Debug.ShouldStop(256);
_text = RemoteObject.createImmutable("");Debug.locals.put("Text", _text);
 BA.debugLineNum = 43;BA.debugLine="Dim getHTML As BANanoFetch";
Debug.ShouldStop(1024);
_gethtml = RemoteObject.createNew ("com.ab.banano.BANanoFetch");Debug.locals.put("getHTML", _gethtml);
 BA.debugLineNum = 44;BA.debugLine="getHTML.Initialize(\"./assets/index.html\", init)";
Debug.ShouldStop(2048);
_gethtml.runVoidMethod ("Initialize",(Object)(BA.ObjectToString("./assets/index.html")),(Object)(_init));
 BA.debugLineNum = 45;BA.debugLine="getHTML.Then(response)";
Debug.ShouldStop(4096);
_gethtml.runVoidMethod ("Then",(Object)((_response)));
 BA.debugLineNum = 46;BA.debugLine="Return response.Text 'ignore";
Debug.ShouldStop(8192);
if (true) return BA.ObjectToString(_response.runMethod(false,"Text"));
 BA.debugLineNum = 47;BA.debugLine="getHTML.Then(Text) 'ignore";
Debug.ShouldStop(16384);
_gethtml.runVoidMethod ("Then",(Object)((_text)));
 BA.debugLineNum = 48;BA.debugLine="body.SetHTML(ExtractBodyPart(Text))";
Debug.ShouldStop(32768);
_body.runVoidMethod ("SetHTML",(Object)(_extractbodypart(_text)));
 BA.debugLineNum = 50;BA.debugLine="Button1.Initialize(\"#Button1\")";
Debug.ShouldStop(131072);
main._button1.runVoidMethod ("Initialize",(Object)((RemoteObject.createImmutable("#Button1"))));
 BA.debugLineNum = 51;BA.debugLine="Editbox1.Initialize(\"#Editbox1\")";
Debug.ShouldStop(262144);
main._editbox1.runVoidMethod ("Initialize",(Object)((RemoteObject.createImmutable("#Editbox1"))));
 BA.debugLineNum = 53;BA.debugLine="Button1.On(\"click\", Me, \"HandleButton1\")";
Debug.ShouldStop(1048576);
main._button1.runVoidMethod ("On",(Object)(BA.ObjectToString("click")),(Object)(main.getObject()),(Object)(RemoteObject.createImmutable("HandleButton1")));
 BA.debugLineNum = 54;BA.debugLine="getHTML.end";
Debug.ShouldStop(2097152);
_gethtml.runVoidMethod ("End");
 BA.debugLineNum = 55;BA.debugLine="End Sub";
Debug.ShouldStop(4194304);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _extractbodypart(RemoteObject _html) throws Exception{
try {
		Debug.PushSubsStack("ExtractBodyPart (main) ","main",0,main.ba,main.mostCurrent,61);
if (RapidSub.canDelegate("extractbodypart")) { return b4j.example.main.remoteMe.runUserSub(false, "main","extractbodypart", _html);}
RemoteObject _bodybegin = RemoteObject.createImmutable(0);
RemoteObject _bodyend = RemoteObject.createImmutable(0);
Debug.locals.put("html", _html);
 BA.debugLineNum = 61;BA.debugLine="public Sub ExtractBodyPart(html As String) As Stri";
Debug.ShouldStop(268435456);
 BA.debugLineNum = 62;BA.debugLine="Dim bodyBegin As Int = html.IndexOf(\"<body>\")";
Debug.ShouldStop(536870912);
_bodybegin = _html.runMethod(true,"indexOf",(Object)(RemoteObject.createImmutable("<body>")));Debug.locals.put("bodyBegin", _bodybegin);Debug.locals.put("bodyBegin", _bodybegin);
 BA.debugLineNum = 63;BA.debugLine="html = html.SubString(bodyBegin + 6)";
Debug.ShouldStop(1073741824);
_html = _html.runMethod(true,"substring",(Object)(RemoteObject.solve(new RemoteObject[] {_bodybegin,RemoteObject.createImmutable(6)}, "+",1, 1)));Debug.locals.put("html", _html);
 BA.debugLineNum = 64;BA.debugLine="Dim bodyEnd As Int =  html.IndexOf(\"</body>\")";
Debug.ShouldStop(-2147483648);
_bodyend = _html.runMethod(true,"indexOf",(Object)(RemoteObject.createImmutable("</body>")));Debug.locals.put("bodyEnd", _bodyend);Debug.locals.put("bodyEnd", _bodyend);
 BA.debugLineNum = 65;BA.debugLine="html = html.SubString2(0,bodyEnd)";
Debug.ShouldStop(1);
_html = _html.runMethod(true,"substring",(Object)(BA.numberCast(int.class, 0)),(Object)(_bodyend));Debug.locals.put("html", _html);
 BA.debugLineNum = 66;BA.debugLine="Return html";
Debug.ShouldStop(2);
if (true) return _html;
 BA.debugLineNum = 67;BA.debugLine="End Sub";
Debug.ShouldStop(4);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _handlebutton1(RemoteObject _event) throws Exception{
try {
		Debug.PushSubsStack("HandleButton1 (main) ","main",0,main.ba,main.mostCurrent,57);
if (RapidSub.canDelegate("handlebutton1")) { return b4j.example.main.remoteMe.runUserSub(false, "main","handlebutton1", _event);}
Debug.locals.put("event", _event);
 BA.debugLineNum = 57;BA.debugLine="public Sub HandleButton1(event As BANanoEvent)";
Debug.ShouldStop(16777216);
 BA.debugLineNum = 58;BA.debugLine="Editbox1.SetValue(\"Alain Bailleul\")";
Debug.ShouldStop(33554432);
main._editbox1.runVoidMethod ("SetValue",(Object)(RemoteObject.createImmutable("Alain Bailleul")));
 BA.debugLineNum = 59;BA.debugLine="End Sub";
Debug.ShouldStop(67108864);
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
 //BA.debugLineNum = 7;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 8;BA.debugLine="Private BANano As BANano 'ignore";
main._banano = RemoteObject.createNew ("com.ab.banano.BANano");
 //BA.debugLineNum = 10;BA.debugLine="Private Button1 As BANanoElement";
main._button1 = RemoteObject.createNew ("com.ab.banano.BANanoElement");
 //BA.debugLineNum = 11;BA.debugLine="Private Editbox1 As BANanoElement";
main._editbox1 = RemoteObject.createNew ("com.ab.banano.BANanoElement");
 //BA.debugLineNum = 12;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}