package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _answer(RemoteObject _resp,RemoteObject _freemarker_template,RemoteObject _root) throws Exception{
try {
		Debug.PushSubsStack("answer (main) ","main",0,main.ba,main.mostCurrent,62);
if (RapidSub.canDelegate("answer")) { return b4j.example.main.remoteMe.runUserSub(false, "main","answer", _resp, _freemarker_template, _root);}
RemoteObject _is_htmx = RemoteObject.createImmutable(false);
Debug.locals.put("resp", _resp);
Debug.locals.put("freemarker_template", _freemarker_template);
Debug.locals.put("root", _root);
 BA.debugLineNum = 62;BA.debugLine="public Sub answer(resp As ServletResponse, freemar";
Debug.ShouldStop(536870912);
 BA.debugLineNum = 63;BA.debugLine="Dim is_htmx As Boolean = root.GetDefault(\"htmx\",";
Debug.ShouldStop(1073741824);
_is_htmx = BA.ObjectToBoolean(_root.runMethod(false,"GetDefault",(Object)(RemoteObject.createImmutable(("htmx"))),(Object)((main.__c.getField(true,"False")))));Debug.locals.put("is_htmx", _is_htmx);Debug.locals.put("is_htmx", _is_htmx);
 BA.debugLineNum = 65;BA.debugLine="If is_htmx Then";
Debug.ShouldStop(1);
if (_is_htmx.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 66;BA.debugLine="answer_freemarker_part(resp, freemarker_template";
Debug.ShouldStop(2);
_answer_freemarker_part(_resp,_freemarker_template,_root);
 }else {
 BA.debugLineNum = 68;BA.debugLine="answer_freemarker(resp, freemarker_template, roo";
Debug.ShouldStop(8);
_answer_freemarker(_resp,_freemarker_template,_root);
 };
 BA.debugLineNum = 70;BA.debugLine="End Sub";
Debug.ShouldStop(32);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _answer_freemarker(RemoteObject _resp,RemoteObject _freemarker_template,RemoteObject _root) throws Exception{
try {
		Debug.PushSubsStack("answer_freemarker (main) ","main",0,main.ba,main.mostCurrent,72);
if (RapidSub.canDelegate("answer_freemarker")) { return b4j.example.main.remoteMe.runUserSub(false, "main","answer_freemarker", _resp, _freemarker_template, _root);}
RemoteObject _t = RemoteObject.declareNull("b4j.example.template");
Debug.locals.put("resp", _resp);
Debug.locals.put("freemarker_template", _freemarker_template);
Debug.locals.put("root", _root);
 BA.debugLineNum = 72;BA.debugLine="public Sub answer_freemarker(resp As ServletRespon";
Debug.ShouldStop(128);
 BA.debugLineNum = 73;BA.debugLine="Dim t As Template = be_free.getTemplate(\"layout.h";
Debug.ShouldStop(256);
_t = main._be_free.runMethod(false,"_gettemplate",(Object)(RemoteObject.createImmutable("layout.html")));Debug.locals.put("t", _t);Debug.locals.put("t", _t);
 BA.debugLineNum = 74;BA.debugLine="resp.CharacterEncoding = \"UTF-8\"";
Debug.ShouldStop(512);
_resp.runMethod(true,"setCharacterEncoding",BA.ObjectToString("UTF-8"));
 BA.debugLineNum = 76;BA.debugLine="root.Put(\"bodyTemplate\", freemarker_template)";
Debug.ShouldStop(2048);
_root.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("bodyTemplate"))),(Object)((_freemarker_template)));
 BA.debugLineNum = 77;BA.debugLine="resp.Write(t.stdOut(root))";
Debug.ShouldStop(4096);
_resp.runVoidMethod ("Write",(Object)(_t.runMethod(true,"_stdout",(Object)(_root))));
 BA.debugLineNum = 78;BA.debugLine="End Sub";
Debug.ShouldStop(8192);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _answer_freemarker_part(RemoteObject _resp,RemoteObject _freemarker_template,RemoteObject _root) throws Exception{
try {
		Debug.PushSubsStack("answer_freemarker_part (main) ","main",0,main.ba,main.mostCurrent,80);
if (RapidSub.canDelegate("answer_freemarker_part")) { return b4j.example.main.remoteMe.runUserSub(false, "main","answer_freemarker_part", _resp, _freemarker_template, _root);}
RemoteObject _t = RemoteObject.declareNull("b4j.example.template");
Debug.locals.put("resp", _resp);
Debug.locals.put("freemarker_template", _freemarker_template);
Debug.locals.put("root", _root);
 BA.debugLineNum = 80;BA.debugLine="public Sub answer_freemarker_part(resp As ServletR";
Debug.ShouldStop(32768);
 BA.debugLineNum = 81;BA.debugLine="Dim t As Template = be_free.getTemplate(freemarke";
Debug.ShouldStop(65536);
_t = main._be_free.runMethod(false,"_gettemplate",(Object)(_freemarker_template));Debug.locals.put("t", _t);Debug.locals.put("t", _t);
 BA.debugLineNum = 82;BA.debugLine="resp.CharacterEncoding = \"UTF-8\"";
Debug.ShouldStop(131072);
_resp.runMethod(true,"setCharacterEncoding",BA.ObjectToString("UTF-8"));
 BA.debugLineNum = 83;BA.debugLine="resp.Write(t.stdOut(root))";
Debug.ShouldStop(262144);
_resp.runVoidMethod ("Write",(Object)(_t.runMethod(true,"_stdout",(Object)(_root))));
 BA.debugLineNum = 84;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _appstart(RemoteObject _args) throws Exception{
try {
		Debug.PushSubsStack("AppStart (main) ","main",0,main.ba,main.mostCurrent,18);
if (RapidSub.canDelegate("appstart")) { return b4j.example.main.remoteMe.runUserSub(false, "main","appstart", _args);}
Debug.locals.put("Args", _args);
 BA.debugLineNum = 18;BA.debugLine="Sub AppStart (Args() As String)";
Debug.ShouldStop(131072);
 BA.debugLineNum = 19;BA.debugLine="base_url = $\"${base_url}:${port}\"$";
Debug.ShouldStop(262144);
main._base_url = (RemoteObject.concat(RemoteObject.createImmutable(""),main.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((main._base_url))),RemoteObject.createImmutable(":"),main.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((main._port))),RemoteObject.createImmutable("")));
 BA.debugLineNum = 20;BA.debugLine="init_templates";
Debug.ShouldStop(524288);
_init_templates();
 BA.debugLineNum = 21;BA.debugLine="init_server";
Debug.ShouldStop(1048576);
_init_server();
 BA.debugLineNum = 23;BA.debugLine="StartMessageLoop";
Debug.ShouldStop(4194304);
main.__c.runVoidMethod ("StartMessageLoop",main.ba);
 BA.debugLineNum = 24;BA.debugLine="End Sub";
Debug.ShouldStop(8388608);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _htmx_middleware(RemoteObject _req) throws Exception{
try {
		Debug.PushSubsStack("htmx_middleware (main) ","main",0,main.ba,main.mostCurrent,86);
if (RapidSub.canDelegate("htmx_middleware")) { return b4j.example.main.remoteMe.runUserSub(false, "main","htmx_middleware", _req);}
RemoteObject _is_boosted = RemoteObject.createImmutable(false);
RemoteObject _is_htmx = RemoteObject.createImmutable(false);
Debug.locals.put("req", _req);
 BA.debugLineNum = 86;BA.debugLine="public Sub htmx_middleware(req As ServletRequest)";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 87;BA.debugLine="Dim is_boosted As Boolean = req.GetHeader(\"HX-Boo";
Debug.ShouldStop(4194304);
_is_boosted = BA.ObjectToBoolean(RemoteObject.solveBoolean("!",(_req.runMethod(true,"GetHeader",(Object)(RemoteObject.createImmutable("HX-Boosted")))),BA.ObjectToString("")));Debug.locals.put("is_boosted", _is_boosted);Debug.locals.put("is_boosted", _is_boosted);
 BA.debugLineNum = 88;BA.debugLine="Dim is_htmx	   As Boolean = req.GetHeader(\"HX-Req";
Debug.ShouldStop(8388608);
_is_htmx = BA.ObjectToBoolean(RemoteObject.solveBoolean("!",(_req.runMethod(true,"GetHeader",(Object)(RemoteObject.createImmutable("HX-Request")))),BA.ObjectToString("")));Debug.locals.put("is_htmx", _is_htmx);Debug.locals.put("is_htmx", _is_htmx);
 BA.debugLineNum = 90;BA.debugLine="Return CreateMap(\"boosted\": is_boosted, \"htmx\": i";
Debug.ShouldStop(33554432);
if (true) return main.__c.runMethod(false, "createMap", (Object)(new RemoteObject[] {RemoteObject.createImmutable(("boosted")),(_is_boosted),RemoteObject.createImmutable(("htmx")),(_is_htmx)}));
 BA.debugLineNum = 91;BA.debugLine="End Sub";
Debug.ShouldStop(67108864);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _init_server() throws Exception{
try {
		Debug.PushSubsStack("init_server (main) ","main",0,main.ba,main.mostCurrent,26);
if (RapidSub.canDelegate("init_server")) { return b4j.example.main.remoteMe.runUserSub(false, "main","init_server");}
RemoteObject _url = RemoteObject.createImmutable("");
 BA.debugLineNum = 26;BA.debugLine="private Sub init_server";
Debug.ShouldStop(33554432);
 BA.debugLineNum = 27;BA.debugLine="server.Initialize(\"srvr\")";
Debug.ShouldStop(67108864);
main._server.runVoidMethod ("Initialize",main.ba,(Object)(RemoteObject.createImmutable("srvr")));
 BA.debugLineNum = 28;BA.debugLine="server.StaticFilesFolder = File.Combine(File.DirA";
Debug.ShouldStop(134217728);
main._server.runMethod(true,"setStaticFilesFolder",main.__c.getField(false,"File").runMethod(true,"Combine",(Object)(main.__c.getField(false,"File").runMethod(true,"getDirApp")),(Object)(RemoteObject.createImmutable("www"))));
 BA.debugLineNum = 30;BA.debugLine="server.Port = port";
Debug.ShouldStop(536870912);
main._server.runMethod(true,"setPort",main._port);
 BA.debugLineNum = 34;BA.debugLine="urls = server.CreateThreadSafeMap";
Debug.ShouldStop(2);
main._urls = main._server.runMethod(false,"CreateThreadSafeMap");
 BA.debugLineNum = 35;BA.debugLine="urls.Put(\"handlerLandingPage\", \"\")";
Debug.ShouldStop(4);
main._urls.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("handlerLandingPage"))),(Object)((RemoteObject.createImmutable(""))));
 BA.debugLineNum = 36;BA.debugLine="urls.Put(\"handlerFeatures\"	 , \"/features\")";
Debug.ShouldStop(8);
main._urls.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("handlerFeatures"))),(Object)((RemoteObject.createImmutable("/features"))));
 BA.debugLineNum = 37;BA.debugLine="urls.Put(\"handlerContactUs\"	 , \"/contactUs\")";
Debug.ShouldStop(16);
main._urls.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("handlerContactUs"))),(Object)((RemoteObject.createImmutable("/contactUs"))));
 BA.debugLineNum = 38;BA.debugLine="urls.Put(\"handlerPrices\"	 , \"/prices\")";
Debug.ShouldStop(32);
main._urls.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("handlerPrices"))),(Object)((RemoteObject.createImmutable("/prices"))));
 BA.debugLineNum = 40;BA.debugLine="For Each url As String In urls.Keys";
Debug.ShouldStop(128);
{
final RemoteObject group9 = main._urls.runMethod(false,"Keys");
final int groupLen9 = group9.runMethod(true,"getSize").<Integer>get()
;int index9 = 0;
;
for (; index9 < groupLen9;index9++){
_url = BA.ObjectToString(group9.runMethod(false,"Get",index9));Debug.locals.put("url", _url);
Debug.locals.put("url", _url);
 BA.debugLineNum = 41;BA.debugLine="server.AddHandler(urls.Get(url), url, False)";
Debug.ShouldStop(256);
main._server.runVoidMethod ("AddHandler",(Object)(BA.ObjectToString(main._urls.runMethod(false,"Get",(Object)((_url))))),(Object)(_url),(Object)(main.__c.getField(true,"False")));
 }
}Debug.locals.put("url", _url);
;
 BA.debugLineNum = 44;BA.debugLine="be_free.addSharedVariable(\"urls\", urls)";
Debug.ShouldStop(2048);
main._be_free.runVoidMethod ("_addsharedvariable",(Object)(BA.ObjectToString("urls")),(Object)((main._urls.getObject())));
 BA.debugLineNum = 46;BA.debugLine="server.SetStaticFilesOptions(CreateMap(\"dirAllowe";
Debug.ShouldStop(8192);
main._server.runVoidMethod ("SetStaticFilesOptions",(Object)(main.__c.runMethod(false, "createMap", (Object)(new RemoteObject[] {RemoteObject.createImmutable(("dirAllowed")),(main.__c.getField(true,"False"))}))));
 BA.debugLineNum = 48;BA.debugLine="server.Start";
Debug.ShouldStop(32768);
main._server.runVoidMethod ("Start");
 BA.debugLineNum = 49;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _init_templates() throws Exception{
try {
		Debug.PushSubsStack("init_templates (main) ","main",0,main.ba,main.mostCurrent,51);
if (RapidSub.canDelegate("init_templates")) { return b4j.example.main.remoteMe.runUserSub(false, "main","init_templates");}
 BA.debugLineNum = 51;BA.debugLine="Private Sub init_templates";
Debug.ShouldStop(262144);
 BA.debugLineNum = 52;BA.debugLine="be_free.Initialize";
Debug.ShouldStop(524288);
main._be_free.runVoidMethod ("_initialize",main.ba);
 BA.debugLineNum = 53;BA.debugLine="be_free.DefaultEncoding = \"UTF-8\"";
Debug.ShouldStop(1048576);
main._be_free.runVoidMethod ("_setdefaultencoding",BA.ObjectToString("UTF-8"));
 BA.debugLineNum = 54;BA.debugLine="be_free.DirectoryForTemplateLoading = File.DirApp";
Debug.ShouldStop(2097152);
main._be_free.runVoidMethod ("_setdirectoryfortemplateloading",RemoteObject.concat(main.__c.getField(false,"File").runMethod(true,"getDirApp"),RemoteObject.createImmutable("/freemarker_templates")));
 BA.debugLineNum = 55;BA.debugLine="be_free.LazyAutoImports = True";
Debug.ShouldStop(4194304);
main._be_free.runVoidMethod ("_setlazyautoimports",main.__c.getField(true,"True"));
 BA.debugLineNum = 56;BA.debugLine="be_free.addAutoImport(\"fun\", \"functions.ftl\")";
Debug.ShouldStop(8388608);
main._be_free.runVoidMethod ("_addautoimport",(Object)(BA.ObjectToString("fun")),(Object)(RemoteObject.createImmutable("functions.ftl")));
 BA.debugLineNum = 57;BA.debugLine="be_free.exposeFields";
Debug.ShouldStop(16777216);
main._be_free.runVoidMethod ("_exposefields");
 BA.debugLineNum = 58;BA.debugLine="be_free.addSharedVariable(\"base_url\", base_url)";
Debug.ShouldStop(33554432);
main._be_free.runVoidMethod ("_addsharedvariable",(Object)(BA.ObjectToString("base_url")),(Object)((main._base_url)));
 BA.debugLineNum = 59;BA.debugLine="be_free.addSharedVariable(\"derechos_ano\", DateTim";
Debug.ShouldStop(67108864);
main._be_free.runVoidMethod ("_addsharedvariable",(Object)(BA.ObjectToString("derechos_ano")),(Object)(((BA.NumberToString(main.__c.getField(false,"DateTime").runMethod(true,"GetYear",(Object)(main.__c.getField(false,"DateTime").runMethod(true,"getNow"))))))));
 BA.debugLineNum = 60;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
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
handlerlandingpage.myClass = BA.getDeviceClass ("b4j.example.handlerlandingpage");
handlercontactus.myClass = BA.getDeviceClass ("b4j.example.handlercontactus");
handlerprices.myClass = BA.getDeviceClass ("b4j.example.handlerprices");
handlerfeatures.myClass = BA.getDeviceClass ("b4j.example.handlerfeatures");
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 9;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 10;BA.debugLine="Private be_free As Freemarker";
main._be_free = RemoteObject.createNew ("b4j.example.freemarker");
 //BA.debugLineNum = 11;BA.debugLine="Private base_url As String = \"http://localhost:30";
main._base_url = BA.ObjectToString("http://localhost:3000");
 //BA.debugLineNum = 12;BA.debugLine="Private port As Int = 3000";
main._port = BA.numberCast(int.class, 3000);
 //BA.debugLineNum = 14;BA.debugLine="Private server As Server";
main._server = RemoteObject.createNew ("anywheresoftware.b4j.object.ServerWrapper");
 //BA.debugLineNum = 15;BA.debugLine="Public urls As Map";
main._urls = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
 //BA.debugLineNum = 16;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}