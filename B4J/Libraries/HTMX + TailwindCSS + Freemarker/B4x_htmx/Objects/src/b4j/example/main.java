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
public static b4j.example.freemarker _be_free = null;
public static String _base_url = "";
public static int _port = 0;
public static anywheresoftware.b4j.object.ServerWrapper _server = null;
public static anywheresoftware.b4a.objects.collections.Map _urls = null;
public static String  _answer(anywheresoftware.b4j.object.JServlet.ServletResponseWrapper _resp,String _freemarker_template,anywheresoftware.b4a.objects.collections.Map _root) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "answer", false))
	 {return ((String) Debug.delegate(ba, "answer", new Object[] {_resp,_freemarker_template,_root}));}
boolean _is_htmx = false;
RDebugUtils.currentLine=524288;
 //BA.debugLineNum = 524288;BA.debugLine="public Sub answer(resp As ServletResponse, freemar";
RDebugUtils.currentLine=524289;
 //BA.debugLineNum = 524289;BA.debugLine="Dim is_htmx As Boolean = root.GetDefault(\"htmx\",";
_is_htmx = BA.ObjectToBoolean(_root.GetDefault((Object)("htmx"),(Object)(anywheresoftware.b4a.keywords.Common.False)));
RDebugUtils.currentLine=524291;
 //BA.debugLineNum = 524291;BA.debugLine="If is_htmx Then";
if (_is_htmx) { 
RDebugUtils.currentLine=524292;
 //BA.debugLineNum = 524292;BA.debugLine="answer_freemarker_part(resp, freemarker_template";
_answer_freemarker_part(_resp,_freemarker_template,_root);
 }else {
RDebugUtils.currentLine=524294;
 //BA.debugLineNum = 524294;BA.debugLine="answer_freemarker(resp, freemarker_template, roo";
_answer_freemarker(_resp,_freemarker_template,_root);
 };
RDebugUtils.currentLine=524296;
 //BA.debugLineNum = 524296;BA.debugLine="End Sub";
return "";
}
public static String  _answer_freemarker_part(anywheresoftware.b4j.object.JServlet.ServletResponseWrapper _resp,String _freemarker_template,anywheresoftware.b4a.objects.collections.Map _root) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "answer_freemarker_part", false))
	 {return ((String) Debug.delegate(ba, "answer_freemarker_part", new Object[] {_resp,_freemarker_template,_root}));}
b4j.example.template _t = null;
RDebugUtils.currentLine=655360;
 //BA.debugLineNum = 655360;BA.debugLine="public Sub answer_freemarker_part(resp As ServletR";
RDebugUtils.currentLine=655361;
 //BA.debugLineNum = 655361;BA.debugLine="Dim t As Template = be_free.getTemplate(freemarke";
_t = _be_free._gettemplate(_freemarker_template);
RDebugUtils.currentLine=655362;
 //BA.debugLineNum = 655362;BA.debugLine="resp.CharacterEncoding = \"UTF-8\"";
_resp.setCharacterEncoding("UTF-8");
RDebugUtils.currentLine=655363;
 //BA.debugLineNum = 655363;BA.debugLine="resp.Write(t.stdOut(root))";
_resp.Write(_t._stdout(_root));
RDebugUtils.currentLine=655364;
 //BA.debugLineNum = 655364;BA.debugLine="End Sub";
return "";
}
public static String  _answer_freemarker(anywheresoftware.b4j.object.JServlet.ServletResponseWrapper _resp,String _freemarker_template,anywheresoftware.b4a.objects.collections.Map _root) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "answer_freemarker", false))
	 {return ((String) Debug.delegate(ba, "answer_freemarker", new Object[] {_resp,_freemarker_template,_root}));}
b4j.example.template _t = null;
RDebugUtils.currentLine=589824;
 //BA.debugLineNum = 589824;BA.debugLine="public Sub answer_freemarker(resp As ServletRespon";
RDebugUtils.currentLine=589825;
 //BA.debugLineNum = 589825;BA.debugLine="Dim t As Template = be_free.getTemplate(\"layout.h";
_t = _be_free._gettemplate("layout.html");
RDebugUtils.currentLine=589826;
 //BA.debugLineNum = 589826;BA.debugLine="resp.CharacterEncoding = \"UTF-8\"";
_resp.setCharacterEncoding("UTF-8");
RDebugUtils.currentLine=589828;
 //BA.debugLineNum = 589828;BA.debugLine="root.Put(\"bodyTemplate\", freemarker_template)";
_root.Put((Object)("bodyTemplate"),(Object)(_freemarker_template));
RDebugUtils.currentLine=589829;
 //BA.debugLineNum = 589829;BA.debugLine="resp.Write(t.stdOut(root))";
_resp.Write(_t._stdout(_root));
RDebugUtils.currentLine=589830;
 //BA.debugLineNum = 589830;BA.debugLine="End Sub";
return "";
}
public static String  _appstart(String[] _args) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "appstart", false))
	 {return ((String) Debug.delegate(ba, "appstart", new Object[] {_args}));}
RDebugUtils.currentLine=65536;
 //BA.debugLineNum = 65536;BA.debugLine="Sub AppStart (Args() As String)";
RDebugUtils.currentLine=65537;
 //BA.debugLineNum = 65537;BA.debugLine="base_url = $\"${base_url}:${port}\"$";
_base_url = (""+anywheresoftware.b4a.keywords.Common.SmartStringFormatter("",(Object)(_base_url))+":"+anywheresoftware.b4a.keywords.Common.SmartStringFormatter("",(Object)(_port))+"");
RDebugUtils.currentLine=65538;
 //BA.debugLineNum = 65538;BA.debugLine="init_templates";
_init_templates();
RDebugUtils.currentLine=65539;
 //BA.debugLineNum = 65539;BA.debugLine="init_server";
_init_server();
RDebugUtils.currentLine=65541;
 //BA.debugLineNum = 65541;BA.debugLine="StartMessageLoop";
anywheresoftware.b4a.keywords.Common.StartMessageLoop(ba);
RDebugUtils.currentLine=65542;
 //BA.debugLineNum = 65542;BA.debugLine="End Sub";
return "";
}
public static String  _init_templates() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "init_templates", false))
	 {return ((String) Debug.delegate(ba, "init_templates", null));}
RDebugUtils.currentLine=458752;
 //BA.debugLineNum = 458752;BA.debugLine="Private Sub init_templates";
RDebugUtils.currentLine=458753;
 //BA.debugLineNum = 458753;BA.debugLine="be_free.Initialize";
_be_free._initialize(ba);
RDebugUtils.currentLine=458754;
 //BA.debugLineNum = 458754;BA.debugLine="be_free.DefaultEncoding = \"UTF-8\"";
_be_free._setdefaultencoding("UTF-8");
RDebugUtils.currentLine=458755;
 //BA.debugLineNum = 458755;BA.debugLine="be_free.DirectoryForTemplateLoading = File.DirApp";
_be_free._setdirectoryfortemplateloading(anywheresoftware.b4a.keywords.Common.File.getDirApp()+"/freemarker_templates");
RDebugUtils.currentLine=458756;
 //BA.debugLineNum = 458756;BA.debugLine="be_free.LazyAutoImports = True";
_be_free._setlazyautoimports(anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=458757;
 //BA.debugLineNum = 458757;BA.debugLine="be_free.addAutoImport(\"fun\", \"functions.ftl\")";
_be_free._addautoimport("fun","functions.ftl");
RDebugUtils.currentLine=458758;
 //BA.debugLineNum = 458758;BA.debugLine="be_free.exposeFields";
_be_free._exposefields();
RDebugUtils.currentLine=458759;
 //BA.debugLineNum = 458759;BA.debugLine="be_free.addSharedVariable(\"base_url\", base_url)";
_be_free._addsharedvariable("base_url",(Object)(_base_url));
RDebugUtils.currentLine=458760;
 //BA.debugLineNum = 458760;BA.debugLine="be_free.addSharedVariable(\"derechos_ano\", DateTim";
_be_free._addsharedvariable("derechos_ano",(Object)((BA.NumberToString(anywheresoftware.b4a.keywords.Common.DateTime.GetYear(anywheresoftware.b4a.keywords.Common.DateTime.getNow())))));
RDebugUtils.currentLine=458761;
 //BA.debugLineNum = 458761;BA.debugLine="End Sub";
return "";
}
public static String  _init_server() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "init_server", false))
	 {return ((String) Debug.delegate(ba, "init_server", null));}
String _url = "";
RDebugUtils.currentLine=393216;
 //BA.debugLineNum = 393216;BA.debugLine="private Sub init_server";
RDebugUtils.currentLine=393217;
 //BA.debugLineNum = 393217;BA.debugLine="server.Initialize(\"srvr\")";
_server.Initialize(ba,"srvr");
RDebugUtils.currentLine=393218;
 //BA.debugLineNum = 393218;BA.debugLine="server.StaticFilesFolder = File.Combine(File.DirA";
_server.setStaticFilesFolder(anywheresoftware.b4a.keywords.Common.File.Combine(anywheresoftware.b4a.keywords.Common.File.getDirApp(),"www"));
RDebugUtils.currentLine=393220;
 //BA.debugLineNum = 393220;BA.debugLine="server.Port = port";
_server.setPort(_port);
RDebugUtils.currentLine=393224;
 //BA.debugLineNum = 393224;BA.debugLine="urls = server.CreateThreadSafeMap";
_urls = _server.CreateThreadSafeMap();
RDebugUtils.currentLine=393225;
 //BA.debugLineNum = 393225;BA.debugLine="urls.Put(\"handlerLandingPage\", \"\")";
_urls.Put((Object)("handlerLandingPage"),(Object)(""));
RDebugUtils.currentLine=393226;
 //BA.debugLineNum = 393226;BA.debugLine="urls.Put(\"handlerFeatures\"	 , \"/features\")";
_urls.Put((Object)("handlerFeatures"),(Object)("/features"));
RDebugUtils.currentLine=393227;
 //BA.debugLineNum = 393227;BA.debugLine="urls.Put(\"handlerContactUs\"	 , \"/contactUs\")";
_urls.Put((Object)("handlerContactUs"),(Object)("/contactUs"));
RDebugUtils.currentLine=393228;
 //BA.debugLineNum = 393228;BA.debugLine="urls.Put(\"handlerPrices\"	 , \"/prices\")";
_urls.Put((Object)("handlerPrices"),(Object)("/prices"));
RDebugUtils.currentLine=393230;
 //BA.debugLineNum = 393230;BA.debugLine="For Each url As String In urls.Keys";
{
final anywheresoftware.b4a.BA.IterableList group9 = _urls.Keys();
final int groupLen9 = group9.getSize()
;int index9 = 0;
;
for (; index9 < groupLen9;index9++){
_url = BA.ObjectToString(group9.Get(index9));
RDebugUtils.currentLine=393231;
 //BA.debugLineNum = 393231;BA.debugLine="server.AddHandler(urls.Get(url), url, False)";
_server.AddHandler(BA.ObjectToString(_urls.Get((Object)(_url))),_url,anywheresoftware.b4a.keywords.Common.False);
 }
};
RDebugUtils.currentLine=393234;
 //BA.debugLineNum = 393234;BA.debugLine="be_free.addSharedVariable(\"urls\", urls)";
_be_free._addsharedvariable("urls",(Object)(_urls.getObject()));
RDebugUtils.currentLine=393236;
 //BA.debugLineNum = 393236;BA.debugLine="server.SetStaticFilesOptions(CreateMap(\"dirAllowe";
_server.SetStaticFilesOptions(anywheresoftware.b4a.keywords.Common.createMap(new Object[] {(Object)("dirAllowed"),(Object)(anywheresoftware.b4a.keywords.Common.False)}));
RDebugUtils.currentLine=393238;
 //BA.debugLineNum = 393238;BA.debugLine="server.Start";
_server.Start();
RDebugUtils.currentLine=393239;
 //BA.debugLineNum = 393239;BA.debugLine="End Sub";
return "";
}
public static anywheresoftware.b4a.objects.collections.Map  _htmx_middleware(anywheresoftware.b4j.object.JServlet.ServletRequestWrapper _req) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "htmx_middleware", false))
	 {return ((anywheresoftware.b4a.objects.collections.Map) Debug.delegate(ba, "htmx_middleware", new Object[] {_req}));}
boolean _is_boosted = false;
boolean _is_htmx = false;
RDebugUtils.currentLine=720896;
 //BA.debugLineNum = 720896;BA.debugLine="public Sub htmx_middleware(req As ServletRequest)";
RDebugUtils.currentLine=720897;
 //BA.debugLineNum = 720897;BA.debugLine="Dim is_boosted As Boolean = req.GetHeader(\"HX-Boo";
_is_boosted = ((_req.GetHeader("HX-Boosted"))).equals("") == false;
RDebugUtils.currentLine=720898;
 //BA.debugLineNum = 720898;BA.debugLine="Dim is_htmx	   As Boolean = req.GetHeader(\"HX-Req";
_is_htmx = ((_req.GetHeader("HX-Request"))).equals("") == false;
RDebugUtils.currentLine=720900;
 //BA.debugLineNum = 720900;BA.debugLine="Return CreateMap(\"boosted\": is_boosted, \"htmx\": i";
if (true) return anywheresoftware.b4a.keywords.Common.createMap(new Object[] {(Object)("boosted"),(Object)(_is_boosted),(Object)("htmx"),(Object)(_is_htmx)});
RDebugUtils.currentLine=720901;
 //BA.debugLineNum = 720901;BA.debugLine="End Sub";
return null;
}
}