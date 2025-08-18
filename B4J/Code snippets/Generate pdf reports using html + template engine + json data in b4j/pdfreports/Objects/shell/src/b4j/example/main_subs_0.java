package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _appstart(RemoteObject _form1,RemoteObject _args) throws Exception{
try {
		Debug.PushSubsStack("AppStart (main) ","main",0,main.ba,main.mostCurrent,14);
if (RapidSub.canDelegate("appstart")) { return b4j.example.main.remoteMe.runUserSub(false, "main","appstart", _form1, _args);}
Debug.locals.put("Form1", _form1);
Debug.locals.put("Args", _args);
 BA.debugLineNum = 14;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
Debug.ShouldStop(8192);
 BA.debugLineNum = 15;BA.debugLine="MainForm = Form1";
Debug.ShouldStop(16384);
main._mainform = _form1;
 BA.debugLineNum = 16;BA.debugLine="MainForm.RootPane.LoadLayout(\"main\") 'Load the la";
Debug.ShouldStop(32768);
main._mainform.runMethod(false,"getRootPane").runMethodAndSync(false,"LoadLayout",main.ba,(Object)(RemoteObject.createImmutable("main")));
 BA.debugLineNum = 17;BA.debugLine="pdfName=\"report.pdf\"";
Debug.ShouldStop(65536);
main._pdfname = BA.ObjectToString("report.pdf");
 BA.debugLineNum = 18;BA.debugLine="repfolder=\"c:\\reports\\\"";
Debug.ShouldStop(131072);
main._repfolder = BA.ObjectToString("c:\\reports\\");
 BA.debugLineNum = 19;BA.debugLine="MainForm.Show";
Debug.ShouldStop(262144);
main._mainform.runVoidMethodAndSync ("Show");
 BA.debugLineNum = 22;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asjo(RemoteObject _o) throws Exception{
try {
		Debug.PushSubsStack("asJO (main) ","main",0,main.ba,main.mostCurrent,101);
if (RapidSub.canDelegate("asjo")) { return b4j.example.main.remoteMe.runUserSub(false, "main","asjo", _o);}
Debug.locals.put("o", _o);
 BA.debugLineNum = 101;BA.debugLine="Sub asJO(o As JavaObject)As JavaObject";
Debug.ShouldStop(16);
 BA.debugLineNum = 102;BA.debugLine="Return o";
Debug.ShouldStop(32);
if (true) return _o;
 BA.debugLineNum = 103;BA.debugLine="End Sub";
Debug.ShouldStop(64);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _button1_click() throws Exception{
try {
		Debug.PushSubsStack("Button1_Click (main) ","main",0,main.ba,main.mostCurrent,97);
if (RapidSub.canDelegate("button1_click")) { return b4j.example.main.remoteMe.runUserSub(false, "main","button1_click");}
 BA.debugLineNum = 97;BA.debugLine="Private Sub Button1_Click";
Debug.ShouldStop(1);
 BA.debugLineNum = 98;BA.debugLine="PrintPdf";
Debug.ShouldStop(2);
_printpdf();
 BA.debugLineNum = 99;BA.debugLine="End Sub";
Debug.ShouldStop(4);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _pdfprint_processcompleted(RemoteObject _success,RemoteObject _exitcode,RemoteObject _stdout,RemoteObject _stderr) throws Exception{
try {
		Debug.PushSubsStack("PdfPrint_ProcessCompleted (main) ","main",0,main.ba,main.mostCurrent,80);
if (RapidSub.canDelegate("pdfprint_processcompleted")) { return b4j.example.main.remoteMe.runUserSub(false, "main","pdfprint_processcompleted", _success, _exitcode, _stdout, _stderr);}
RemoteObject _fileseparator = RemoteObject.createImmutable("");
RemoteObject _appdir = RemoteObject.createImmutable("");
RemoteObject _osname = RemoteObject.createImmutable("");
Debug.locals.put("Success", _success);
Debug.locals.put("ExitCode", _exitcode);
Debug.locals.put("StdOut", _stdout);
Debug.locals.put("StdErr", _stderr);
 BA.debugLineNum = 80;BA.debugLine="Sub PdfPrint_ProcessCompleted (Success As Boolean,";
Debug.ShouldStop(32768);
 BA.debugLineNum = 81;BA.debugLine="Log(StdOut)";
Debug.ShouldStop(65536);
main.__c.runVoidMethod ("Log",(Object)(_stdout));
 BA.debugLineNum = 82;BA.debugLine="Log(StdErr)";
Debug.ShouldStop(131072);
main.__c.runVoidMethod ("Log",(Object)(_stderr));
 BA.debugLineNum = 83;BA.debugLine="Dim FileSeparator As String=\"/\"";
Debug.ShouldStop(262144);
_fileseparator = BA.ObjectToString("/");Debug.locals.put("FileSeparator", _fileseparator);Debug.locals.put("FileSeparator", _fileseparator);
 BA.debugLineNum = 84;BA.debugLine="Dim AppDir As String=\"appdir\"";
Debug.ShouldStop(524288);
_appdir = BA.ObjectToString("appdir");Debug.locals.put("AppDir", _appdir);Debug.locals.put("AppDir", _appdir);
 BA.debugLineNum = 85;BA.debugLine="Dim OsName As String=asJO(Me).RunMethod(\"getSysPr";
Debug.ShouldStop(1048576);
_osname = BA.ObjectToString(_asjo(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), main.getObject())).runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getSysProp")),(Object)((RemoteObject.createNewArray("String",new int[] {1},new Object[] {RemoteObject.createImmutable("os.name")})))));Debug.locals.put("OsName", _osname);Debug.locals.put("OsName", _osname);
 BA.debugLineNum = 86;BA.debugLine="If Success And ExitCode = 0 Then";
Debug.ShouldStop(2097152);
if (RemoteObject.solveBoolean(".",_success) && RemoteObject.solveBoolean("=",_exitcode,BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 87;BA.debugLine="If OsName.Contains(\"Windows\") Then";
Debug.ShouldStop(4194304);
if (_osname.runMethod(true,"contains",(Object)(RemoteObject.createImmutable("Windows"))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 88;BA.debugLine="fx.ShowExternalDocument(File.GetUri(repfolder,p";
Debug.ShouldStop(8388608);
main._fx.runVoidMethod ("ShowExternalDocument",(Object)(main.__c.getField(false,"File").runMethod(true,"GetUri",(Object)(main._repfolder),(Object)(main._pdfname))));
 }else 
{ BA.debugLineNum = 89;BA.debugLine="Else If OsName.Contains(\"Linux\") Then";
Debug.ShouldStop(16777216);
if (_osname.runMethod(true,"contains",(Object)(RemoteObject.createImmutable("Linux"))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 90;BA.debugLine="fx.ShowExternalDocument( AppDir & FileSeparator";
Debug.ShouldStop(33554432);
main._fx.runVoidMethod ("ShowExternalDocument",(Object)(RemoteObject.concat(_appdir,_fileseparator,main._pdfname)));
 }}
;
 }else {
 BA.debugLineNum = 93;BA.debugLine="fx.Msgbox(MainForm,\"Check wkhtmltopdf error mess";
Debug.ShouldStop(268435456);
main._fx.runVoidMethodAndSync ("Msgbox",(Object)(main._mainform),(Object)(BA.ObjectToString("Check wkhtmltopdf error messages in log")),(Object)(RemoteObject.createImmutable("Stop")));
 };
 BA.debugLineNum = 95;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _printpdf() throws Exception{
try {
		Debug.PushSubsStack("PrintPdf (main) ","main",0,main.ba,main.mostCurrent,24);
if (RapidSub.canDelegate("printpdf")) { return b4j.example.main.remoteMe.runUserSub(false, "main","printpdf");}
RemoteObject _pdfsh = RemoteObject.declareNull("anywheresoftware.b4j.objects.Shell");
RemoteObject _jsongenerator = RemoteObject.declareNull("anywheresoftware.b4j.objects.collections.JSONParser.JSONGenerator");
RemoteObject _n = RemoteObject.createImmutable(0);
RemoteObject _data = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _lst = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _d1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _json = RemoteObject.createImmutable("");
RemoteObject _sb = RemoteObject.declareNull("anywheresoftware.b4a.keywords.StringBuilderWrapper");
RemoteObject _t = RemoteObject.createImmutable(0L);
RemoteObject _fileready = RemoteObject.createImmutable(false);
 BA.debugLineNum = 24;BA.debugLine="Sub PrintPdf()";
Debug.ShouldStop(8388608);
 BA.debugLineNum = 25;BA.debugLine="Dim PdfSh As Shell";
Debug.ShouldStop(16777216);
_pdfsh = RemoteObject.createNew ("anywheresoftware.b4j.objects.Shell");Debug.locals.put("PdfSh", _pdfsh);
 BA.debugLineNum = 27;BA.debugLine="If File.Exists(repfolder,\"render.js\") Then";
Debug.ShouldStop(67108864);
if (main.__c.getField(false,"File").runMethod(true,"Exists",(Object)(main._repfolder),(Object)(RemoteObject.createImmutable("render.js"))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 28;BA.debugLine="File.Delete(repfolder,\"render.js\")";
Debug.ShouldStop(134217728);
main.__c.getField(false,"File").runVoidMethod ("Delete",(Object)(main._repfolder),(Object)(RemoteObject.createImmutable("render.js")));
 };
 BA.debugLineNum = 31;BA.debugLine="Dim JSONGenerator As JSONGenerator";
Debug.ShouldStop(1073741824);
_jsongenerator = RemoteObject.createNew ("anywheresoftware.b4j.objects.collections.JSONParser.JSONGenerator");Debug.locals.put("JSONGenerator", _jsongenerator);
 BA.debugLineNum = 32;BA.debugLine="Dim n As Int";
Debug.ShouldStop(-2147483648);
_n = RemoteObject.createImmutable(0);Debug.locals.put("n", _n);
 BA.debugLineNum = 33;BA.debugLine="Dim data As Map";
Debug.ShouldStop(1);
_data = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("data", _data);
 BA.debugLineNum = 34;BA.debugLine="data.Initialize";
Debug.ShouldStop(2);
_data.runVoidMethod ("Initialize");
 BA.debugLineNum = 35;BA.debugLine="Dim lst As List";
Debug.ShouldStop(4);
_lst = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("lst", _lst);
 BA.debugLineNum = 36;BA.debugLine="lst.Initialize";
Debug.ShouldStop(8);
_lst.runVoidMethod ("Initialize");
 BA.debugLineNum = 37;BA.debugLine="For n=0 To 15";
Debug.ShouldStop(16);
{
final int step11 = 1;
final int limit11 = 15;
_n = BA.numberCast(int.class, 0) ;
for (;(step11 > 0 && _n.<Integer>get().intValue() <= limit11) || (step11 < 0 && _n.<Integer>get().intValue() >= limit11) ;_n = RemoteObject.createImmutable((int)(0 + _n.<Integer>get().intValue() + step11))  ) {
Debug.locals.put("n", _n);
 BA.debugLineNum = 38;BA.debugLine="Dim d1 As Map";
Debug.ShouldStop(32);
_d1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("d1", _d1);
 BA.debugLineNum = 39;BA.debugLine="d1.Initialize";
Debug.ShouldStop(64);
_d1.runVoidMethod ("Initialize");
 BA.debugLineNum = 40;BA.debugLine="d1.Put(\"category\",\"a1-\" & n)";
Debug.ShouldStop(128);
_d1.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("category"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("a1-"),_n))));
 BA.debugLineNum = 41;BA.debugLine="d1.Put(\"description\",\"a2-\" & n)";
Debug.ShouldStop(256);
_d1.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("description"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("a2-"),_n))));
 BA.debugLineNum = 42;BA.debugLine="d1.Put(\"title\",\"a3-\" & n)";
Debug.ShouldStop(512);
_d1.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("title"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("a3-"),_n))));
 BA.debugLineNum = 43;BA.debugLine="d1.Put(\"video\",\"a4-\" & n)";
Debug.ShouldStop(1024);
_d1.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("video"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("a4-"),_n))));
 BA.debugLineNum = 44;BA.debugLine="lst.Add(d1)";
Debug.ShouldStop(2048);
_lst.runVoidMethod ("Add",(Object)((_d1.getObject())));
 }
}Debug.locals.put("n", _n);
;
 BA.debugLineNum = 47;BA.debugLine="data.Put(\"shows\",lst)";
Debug.ShouldStop(16384);
_data.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("shows"))),(Object)((_lst.getObject())));
 BA.debugLineNum = 49;BA.debugLine="JSONGenerator.Initialize(data)";
Debug.ShouldStop(65536);
_jsongenerator.runVoidMethod ("Initialize",(Object)(_data));
 BA.debugLineNum = 51;BA.debugLine="Dim json As String= JSONGenerator.ToString";
Debug.ShouldStop(262144);
_json = _jsongenerator.runMethod(true,"ToString");Debug.locals.put("json", _json);Debug.locals.put("json", _json);
 BA.debugLineNum = 53;BA.debugLine="Dim sb As StringBuilder";
Debug.ShouldStop(1048576);
_sb = RemoteObject.createNew ("anywheresoftware.b4a.keywords.StringBuilderWrapper");Debug.locals.put("sb", _sb);
 BA.debugLineNum = 54;BA.debugLine="sb.Initialize";
Debug.ShouldStop(2097152);
_sb.runVoidMethod ("Initialize");
 BA.debugLineNum = 55;BA.debugLine="sb.Append(\"function renderdoc(){\")";
Debug.ShouldStop(4194304);
_sb.runVoidMethod ("Append",(Object)(RemoteObject.createImmutable("function renderdoc(){")));
 BA.debugLineNum = 56;BA.debugLine="sb.Append(\"var template = document.getElementBy";
Debug.ShouldStop(8388608);
_sb.runVoidMethod ("Append",(Object)(RemoteObject.createImmutable("var template = document.getElementById('template').innerHTML;")));
 BA.debugLineNum = 57;BA.debugLine="sb.Append(\"var rendered = Mustache.render(templ";
Debug.ShouldStop(16777216);
_sb.runVoidMethod ("Append",(Object)(RemoteObject.concat(RemoteObject.createImmutable("var rendered = Mustache.render(template,"),_json,RemoteObject.createImmutable(");"))));
 BA.debugLineNum = 58;BA.debugLine="sb.Append(\"document.getElementById('target').in";
Debug.ShouldStop(33554432);
_sb.runVoidMethod ("Append",(Object)(RemoteObject.createImmutable("document.getElementById('target').innerHTML = rendered;")));
 BA.debugLineNum = 59;BA.debugLine="sb.Append(\"}\")";
Debug.ShouldStop(67108864);
_sb.runVoidMethod ("Append",(Object)(RemoteObject.createImmutable("}")));
 BA.debugLineNum = 61;BA.debugLine="File.WriteString(repfolder,\"render.js\",sb.ToStrin";
Debug.ShouldStop(268435456);
main.__c.getField(false,"File").runVoidMethod ("WriteString",(Object)(main._repfolder),(Object)(BA.ObjectToString("render.js")),(Object)(_sb.runMethod(true,"ToString")));
 BA.debugLineNum = 63;BA.debugLine="Dim t As Long = DateTime.Now";
Debug.ShouldStop(1073741824);
_t = main.__c.getField(false,"DateTime").runMethod(true,"getNow");Debug.locals.put("t", _t);Debug.locals.put("t", _t);
 BA.debugLineNum = 64;BA.debugLine="Dim fileready As Boolean=False";
Debug.ShouldStop(-2147483648);
_fileready = main.__c.getField(true,"False");Debug.locals.put("fileready", _fileready);Debug.locals.put("fileready", _fileready);
 BA.debugLineNum = 65;BA.debugLine="Do While fileready=False And DateTime.Now < t+500";
Debug.ShouldStop(1);
while (RemoteObject.solveBoolean("=",_fileready,main.__c.getField(true,"False")) && RemoteObject.solveBoolean("<",main.__c.getField(false,"DateTime").runMethod(true,"getNow"),RemoteObject.solve(new RemoteObject[] {_t,RemoteObject.createImmutable(5000)}, "+",1, 2))) {
 BA.debugLineNum = 66;BA.debugLine="If File.Exists(repfolder,\"render.js\") Then";
Debug.ShouldStop(2);
if (main.__c.getField(false,"File").runMethod(true,"Exists",(Object)(main._repfolder),(Object)(RemoteObject.createImmutable("render.js"))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 67;BA.debugLine="fileready=True";
Debug.ShouldStop(4);
_fileready = main.__c.getField(true,"True");Debug.locals.put("fileready", _fileready);
 };
 }
;
 BA.debugLineNum = 70;BA.debugLine="If fileready=True Then";
Debug.ShouldStop(32);
if (RemoteObject.solveBoolean("=",_fileready,main.__c.getField(true,"True"))) { 
 BA.debugLineNum = 71;BA.debugLine="PdfSh.Initialize(\"PdfPrint\", \"c:\\program files";
Debug.ShouldStop(64);
_pdfsh.runVoidMethod ("Initialize",(Object)(BA.ObjectToString("PdfPrint")),(Object)(BA.ObjectToString("c:\\program files\\wkhtmltopdf\\bin\\wkhtmltopdf.exe")),(Object)(main.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("String",new int[] {5},new Object[] {BA.ObjectToString("--javascript-delay 	"),BA.ObjectToString("500"),BA.ObjectToString("--enable-local-file-access"),RemoteObject.concat(main._repfolder,RemoteObject.createImmutable("report.html")),RemoteObject.concat(main._repfolder,main._pdfname)})))));
 BA.debugLineNum = 72;BA.debugLine="PdfSh.WorkingDirectory = repfolder";
Debug.ShouldStop(128);
_pdfsh.runMethod(true,"setWorkingDirectory",main._repfolder);
 BA.debugLineNum = 73;BA.debugLine="PdfSh.Run(5000)";
Debug.ShouldStop(256);
_pdfsh.runVoidMethod ("Run",main.ba,(Object)(BA.numberCast(long.class, 5000)));
 }else {
 BA.debugLineNum = 75;BA.debugLine="fx.Msgbox(MainForm,\"Check wkhtmltopdf and report";
Debug.ShouldStop(1024);
main._fx.runVoidMethodAndSync ("Msgbox",(Object)(main._mainform),(Object)(BA.ObjectToString("Check wkhtmltopdf and report paths")),(Object)(RemoteObject.createImmutable("Stop")));
 };
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
 //BA.debugLineNum = 6;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 7;BA.debugLine="Private fx As JFX";
main._fx = RemoteObject.createNew ("anywheresoftware.b4j.objects.JFX");
 //BA.debugLineNum = 8;BA.debugLine="Private MainForm As Form";
main._mainform = RemoteObject.createNew ("anywheresoftware.b4j.objects.Form");
 //BA.debugLineNum = 9;BA.debugLine="Private Button1 As Button";
main._button1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");
 //BA.debugLineNum = 10;BA.debugLine="Private pdfName As String";
main._pdfname = RemoteObject.createImmutable("");
 //BA.debugLineNum = 11;BA.debugLine="Private repfolder As String";
main._repfolder = RemoteObject.createImmutable("");
 //BA.debugLineNum = 12;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}