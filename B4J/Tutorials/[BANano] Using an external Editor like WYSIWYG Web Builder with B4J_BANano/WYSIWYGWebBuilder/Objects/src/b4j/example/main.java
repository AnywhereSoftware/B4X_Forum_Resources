package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;

public class main extends Object{
public static main mostCurrent = new main();

public static BA ba;
static {
		ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.main", null);
		ba.loadHtSubs(main.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			anywheresoftware.b4a.shell.ShellBA.delegateBA = new anywheresoftware.b4a.StandardBA("b4j.example", null, null);
			ba.raiseEvent2(null, true, "SHELL", false);
			ba.raiseEvent2(null, true, "CREATE", true, "b4j.example.main", ba);
		}
	}
    public static Class<?> getObject() {
		return main.class;
	}

 
    public static void main(String[] args) throws Exception{
        try {
            anywheresoftware.b4a.keywords.Common.LogDebug("Program started.");
            initializeProcessGlobals();
            ba.raiseEvent(null, "appstart", (Object)args);
        } catch (Throwable t) {
			BA.printException(t, true);
		
        } finally {
            anywheresoftware.b4a.keywords.Common.LogDebug("Program terminated (StartMessageLoop was not called).");
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
public static com.ab.banano.BANano _banano = null;
public static com.ab.banano.BANanoElement _button1 = null;
public static com.ab.banano.BANanoElement _editbox1 = null;
public static boolean  _application_error(anywheresoftware.b4a.objects.B4AException _error,String _stacktrace) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "application_error", false))
	 {return ((Boolean) Debug.delegate(ba, "application_error", new Object[] {_error,_stacktrace}));}
RDebugUtils.currentLine=131072;
 //BA.debugLineNum = 131072;BA.debugLine="Sub Application_Error (Error As Exception, StackTr";
RDebugUtils.currentLine=131073;
 //BA.debugLineNum = 131073;BA.debugLine="Return True";
if (true) return anywheresoftware.b4a.keywords.Common.True;
RDebugUtils.currentLine=131074;
 //BA.debugLineNum = 131074;BA.debugLine="End Sub";
return false;
}
public static String  _appstart(String[] _args) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "appstart", false))
	 {return ((String) Debug.delegate(ba, "appstart", new Object[] {_args}));}
RDebugUtils.currentLine=65536;
 //BA.debugLineNum = 65536;BA.debugLine="Sub AppStart (Args() As String)";
RDebugUtils.currentLine=65537;
 //BA.debugLineNum = 65537;BA.debugLine="BANano.Initialize(\"BANano\", \"BANanoWYSIWYG\",1)";
_banano.Initialize("BANano","BANanoWYSIWYG",(long) (1));
RDebugUtils.currentLine=65539;
 //BA.debugLineNum = 65539;BA.debugLine="BANano.Header.AddCSSFile(\"index.css\")";
_banano.Header.AddCSSFile("index.css");
RDebugUtils.currentLine=65540;
 //BA.debugLineNum = 65540;BA.debugLine="BANano.Header.AddCSSFile(\"Untitled1.css\")";
_banano.Header.AddCSSFile("Untitled1.css");
RDebugUtils.currentLine=65542;
 //BA.debugLineNum = 65542;BA.debugLine="BANano.Build(File.DirApp)";
_banano.Build(anywheresoftware.b4a.keywords.Common.File.getDirApp());
RDebugUtils.currentLine=65544;
 //BA.debugLineNum = 65544;BA.debugLine="ExitApplication";
anywheresoftware.b4a.keywords.Common.ExitApplication();
RDebugUtils.currentLine=65545;
 //BA.debugLineNum = 65545;BA.debugLine="End Sub";
return "";
}
public static String  _banano_ready() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "banano_ready", false))
	 {return ((String) Debug.delegate(ba, "banano_ready", null));}
com.ab.banano.BANanoElement _body = null;
com.ab.banano.BANanoFetchOptions _init = null;
com.ab.banano.BANanoFetchResponse _response = null;
String _text = "";
com.ab.banano.BANanoFetch _gethtml = null;
RDebugUtils.currentLine=196608;
 //BA.debugLineNum = 196608;BA.debugLine="Sub BANano_Ready()";
RDebugUtils.currentLine=196609;
 //BA.debugLineNum = 196609;BA.debugLine="Dim body As BANanoElement";
_body = new com.ab.banano.BANanoElement();
RDebugUtils.currentLine=196610;
 //BA.debugLineNum = 196610;BA.debugLine="body.Initialize(\"#body\")";
_body.Initialize((Object)("#body"));
RDebugUtils.currentLine=196613;
 //BA.debugLineNum = 196613;BA.debugLine="Dim init As BANanoFetchOptions";
_init = new com.ab.banano.BANanoFetchOptions();
RDebugUtils.currentLine=196614;
 //BA.debugLineNum = 196614;BA.debugLine="init.Initialize";
_init.Initialize();
RDebugUtils.currentLine=196615;
 //BA.debugLineNum = 196615;BA.debugLine="init.Mode = \"no-cors\"";
_init.setMode("no-cors");
RDebugUtils.currentLine=196617;
 //BA.debugLineNum = 196617;BA.debugLine="Dim response As BANanoFetchResponse";
_response = new com.ab.banano.BANanoFetchResponse();
RDebugUtils.currentLine=196618;
 //BA.debugLineNum = 196618;BA.debugLine="Dim Text As String";
_text = "";
RDebugUtils.currentLine=196620;
 //BA.debugLineNum = 196620;BA.debugLine="Dim getHTML As BANanoFetch";
_gethtml = new com.ab.banano.BANanoFetch();
RDebugUtils.currentLine=196621;
 //BA.debugLineNum = 196621;BA.debugLine="getHTML.Initialize(\"./assets/index.html\", init)";
_gethtml.Initialize("./assets/index.html",_init);
RDebugUtils.currentLine=196622;
 //BA.debugLineNum = 196622;BA.debugLine="getHTML.Then(response)";
_gethtml.Then((Object)(_response));
RDebugUtils.currentLine=196623;
 //BA.debugLineNum = 196623;BA.debugLine="Return response.Text 'ignore";
if (true) return BA.ObjectToString(_response.Text());
RDebugUtils.currentLine=196624;
 //BA.debugLineNum = 196624;BA.debugLine="getHTML.Then(Text) 'ignore";
_gethtml.Then((Object)(_text));
RDebugUtils.currentLine=196625;
 //BA.debugLineNum = 196625;BA.debugLine="body.SetHTML(ExtractBodyPart(Text))";
_body.SetHTML(_extractbodypart(_text));
RDebugUtils.currentLine=196627;
 //BA.debugLineNum = 196627;BA.debugLine="Button1.Initialize(\"#Button1\")";
_button1.Initialize((Object)("#Button1"));
RDebugUtils.currentLine=196628;
 //BA.debugLineNum = 196628;BA.debugLine="Editbox1.Initialize(\"#Editbox1\")";
_editbox1.Initialize((Object)("#Editbox1"));
RDebugUtils.currentLine=196630;
 //BA.debugLineNum = 196630;BA.debugLine="Button1.On(\"click\", Me, \"HandleButton1\")";
_button1.On("click",main.getObject(),"HandleButton1");
RDebugUtils.currentLine=196631;
 //BA.debugLineNum = 196631;BA.debugLine="getHTML.end";
_gethtml.End();
RDebugUtils.currentLine=196632;
 //BA.debugLineNum = 196632;BA.debugLine="End Sub";
return "";
}
public static String  _extractbodypart(String _html) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "extractbodypart", false))
	 {return ((String) Debug.delegate(ba, "extractbodypart", new Object[] {_html}));}
int _bodybegin = 0;
int _bodyend = 0;
RDebugUtils.currentLine=1245184;
 //BA.debugLineNum = 1245184;BA.debugLine="public Sub ExtractBodyPart(html As String) As Stri";
RDebugUtils.currentLine=1245185;
 //BA.debugLineNum = 1245185;BA.debugLine="Dim bodyBegin As Int = html.IndexOf(\"<body>\")";
_bodybegin = _html.indexOf("<body>");
RDebugUtils.currentLine=1245186;
 //BA.debugLineNum = 1245186;BA.debugLine="html = html.SubString(bodyBegin + 6)";
_html = _html.substring((int) (_bodybegin+6));
RDebugUtils.currentLine=1245187;
 //BA.debugLineNum = 1245187;BA.debugLine="Dim bodyEnd As Int =  html.IndexOf(\"</body>\")";
_bodyend = _html.indexOf("</body>");
RDebugUtils.currentLine=1245188;
 //BA.debugLineNum = 1245188;BA.debugLine="html = html.SubString2(0,bodyEnd)";
_html = _html.substring((int) (0),_bodyend);
RDebugUtils.currentLine=1245189;
 //BA.debugLineNum = 1245189;BA.debugLine="Return html";
if (true) return _html;
RDebugUtils.currentLine=1245190;
 //BA.debugLineNum = 1245190;BA.debugLine="End Sub";
return "";
}
public static String  _handlebutton1(com.ab.banano.BANanoEvent _event) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "handlebutton1", false))
	 {return ((String) Debug.delegate(ba, "handlebutton1", new Object[] {_event}));}
RDebugUtils.currentLine=2097152;
 //BA.debugLineNum = 2097152;BA.debugLine="public Sub HandleButton1(event As BANanoEvent)";
RDebugUtils.currentLine=2097153;
 //BA.debugLineNum = 2097153;BA.debugLine="Editbox1.SetValue(\"Alain Bailleul\")";
_editbox1.SetValue("Alain Bailleul");
RDebugUtils.currentLine=2097154;
 //BA.debugLineNum = 2097154;BA.debugLine="End Sub";
return "";
}
}