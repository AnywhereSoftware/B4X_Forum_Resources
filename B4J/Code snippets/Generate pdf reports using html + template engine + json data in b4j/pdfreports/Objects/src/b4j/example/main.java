package b4j.example;

import anywheresoftware.b4a.debug.*;
import java.io.File;
import java.net.URI;
import java.net.URISyntaxException;

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
            frm.initWithStage(ba, stage, 600, 400);
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
public static anywheresoftware.b4j.objects.ButtonWrapper _button1 = null;
public static String _pdfname = "";
public static String _repfolder = "";
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
 //BA.debugLineNum = 65538;BA.debugLine="MainForm.RootPane.LoadLayout(\"main\") 'Load the la";
_mainform.getRootPane().LoadLayout(ba,"main");
RDebugUtils.currentLine=65539;
 //BA.debugLineNum = 65539;BA.debugLine="pdfName=\"report.pdf\"";
_pdfname = "report.pdf";
RDebugUtils.currentLine=65540;
 //BA.debugLineNum = 65540;BA.debugLine="repfolder=\"c:\\reports\\\"";
_repfolder = "c:\\reports\\";
RDebugUtils.currentLine=65541;
 //BA.debugLineNum = 65541;BA.debugLine="MainForm.Show";
_mainform.Show();
RDebugUtils.currentLine=65544;
 //BA.debugLineNum = 65544;BA.debugLine="End Sub";
return "";
}
public static anywheresoftware.b4j.object.JavaObject  _asjo(anywheresoftware.b4j.object.JavaObject _o) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "asjo", false))
	 {return ((anywheresoftware.b4j.object.JavaObject) Debug.delegate(ba, "asjo", new Object[] {_o}));}
RDebugUtils.currentLine=327680;
 //BA.debugLineNum = 327680;BA.debugLine="Sub asJO(o As JavaObject)As JavaObject";
RDebugUtils.currentLine=327681;
 //BA.debugLineNum = 327681;BA.debugLine="Return o";
if (true) return _o;
RDebugUtils.currentLine=327682;
 //BA.debugLineNum = 327682;BA.debugLine="End Sub";
return null;
}
public static String  _button1_click() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "button1_click", false))
	 {return ((String) Debug.delegate(ba, "button1_click", null));}
RDebugUtils.currentLine=262144;
 //BA.debugLineNum = 262144;BA.debugLine="Private Sub Button1_Click";
RDebugUtils.currentLine=262145;
 //BA.debugLineNum = 262145;BA.debugLine="PrintPdf";
_printpdf();
RDebugUtils.currentLine=262146;
 //BA.debugLineNum = 262146;BA.debugLine="End Sub";
return "";
}
public static String  _printpdf() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "printpdf", false))
	 {return ((String) Debug.delegate(ba, "printpdf", null));}
anywheresoftware.b4j.objects.Shell _pdfsh = null;
anywheresoftware.b4j.objects.collections.JSONParser.JSONGenerator _jsongenerator = null;
int _n = 0;
anywheresoftware.b4a.objects.collections.Map _data = null;
anywheresoftware.b4a.objects.collections.List _lst = null;
anywheresoftware.b4a.objects.collections.Map _d1 = null;
String _json = "";
anywheresoftware.b4a.keywords.StringBuilderWrapper _sb = null;
long _t = 0L;
boolean _fileready = false;
RDebugUtils.currentLine=131072;
 //BA.debugLineNum = 131072;BA.debugLine="Sub PrintPdf()";
RDebugUtils.currentLine=131073;
 //BA.debugLineNum = 131073;BA.debugLine="Dim PdfSh As Shell";
_pdfsh = new anywheresoftware.b4j.objects.Shell();
RDebugUtils.currentLine=131075;
 //BA.debugLineNum = 131075;BA.debugLine="If File.Exists(repfolder,\"render.js\") Then";
if (anywheresoftware.b4a.keywords.Common.File.Exists(_repfolder,"render.js")) { 
RDebugUtils.currentLine=131076;
 //BA.debugLineNum = 131076;BA.debugLine="File.Delete(repfolder,\"render.js\")";
anywheresoftware.b4a.keywords.Common.File.Delete(_repfolder,"render.js");
 };
RDebugUtils.currentLine=131079;
 //BA.debugLineNum = 131079;BA.debugLine="Dim JSONGenerator As JSONGenerator";
_jsongenerator = new anywheresoftware.b4j.objects.collections.JSONParser.JSONGenerator();
RDebugUtils.currentLine=131080;
 //BA.debugLineNum = 131080;BA.debugLine="Dim n As Int";
_n = 0;
RDebugUtils.currentLine=131081;
 //BA.debugLineNum = 131081;BA.debugLine="Dim data As Map";
_data = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=131082;
 //BA.debugLineNum = 131082;BA.debugLine="data.Initialize";
_data.Initialize();
RDebugUtils.currentLine=131083;
 //BA.debugLineNum = 131083;BA.debugLine="Dim lst As List";
_lst = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=131084;
 //BA.debugLineNum = 131084;BA.debugLine="lst.Initialize";
_lst.Initialize();
RDebugUtils.currentLine=131085;
 //BA.debugLineNum = 131085;BA.debugLine="For n=0 To 15";
{
final int step11 = 1;
final int limit11 = (int) (15);
_n = (int) (0) ;
for (;_n <= limit11 ;_n = _n + step11 ) {
RDebugUtils.currentLine=131086;
 //BA.debugLineNum = 131086;BA.debugLine="Dim d1 As Map";
_d1 = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=131087;
 //BA.debugLineNum = 131087;BA.debugLine="d1.Initialize";
_d1.Initialize();
RDebugUtils.currentLine=131088;
 //BA.debugLineNum = 131088;BA.debugLine="d1.Put(\"category\",\"a1-\" & n)";
_d1.Put((Object)("category"),(Object)("a1-"+BA.NumberToString(_n)));
RDebugUtils.currentLine=131089;
 //BA.debugLineNum = 131089;BA.debugLine="d1.Put(\"description\",\"a2-\" & n)";
_d1.Put((Object)("description"),(Object)("a2-"+BA.NumberToString(_n)));
RDebugUtils.currentLine=131090;
 //BA.debugLineNum = 131090;BA.debugLine="d1.Put(\"title\",\"a3-\" & n)";
_d1.Put((Object)("title"),(Object)("a3-"+BA.NumberToString(_n)));
RDebugUtils.currentLine=131091;
 //BA.debugLineNum = 131091;BA.debugLine="d1.Put(\"video\",\"a4-\" & n)";
_d1.Put((Object)("video"),(Object)("a4-"+BA.NumberToString(_n)));
RDebugUtils.currentLine=131092;
 //BA.debugLineNum = 131092;BA.debugLine="lst.Add(d1)";
_lst.Add((Object)(_d1.getObject()));
 }
};
RDebugUtils.currentLine=131095;
 //BA.debugLineNum = 131095;BA.debugLine="data.Put(\"shows\",lst)";
_data.Put((Object)("shows"),(Object)(_lst.getObject()));
RDebugUtils.currentLine=131097;
 //BA.debugLineNum = 131097;BA.debugLine="JSONGenerator.Initialize(data)";
_jsongenerator.Initialize(_data);
RDebugUtils.currentLine=131099;
 //BA.debugLineNum = 131099;BA.debugLine="Dim json As String= JSONGenerator.ToString";
_json = _jsongenerator.ToString();
RDebugUtils.currentLine=131101;
 //BA.debugLineNum = 131101;BA.debugLine="Dim sb As StringBuilder";
_sb = new anywheresoftware.b4a.keywords.StringBuilderWrapper();
RDebugUtils.currentLine=131102;
 //BA.debugLineNum = 131102;BA.debugLine="sb.Initialize";
_sb.Initialize();
RDebugUtils.currentLine=131103;
 //BA.debugLineNum = 131103;BA.debugLine="sb.Append(\"function renderdoc(){\")";
_sb.Append("function renderdoc(){");
RDebugUtils.currentLine=131104;
 //BA.debugLineNum = 131104;BA.debugLine="sb.Append(\"var template = document.getElementBy";
_sb.Append("var template = document.getElementById('template').innerHTML;");
RDebugUtils.currentLine=131105;
 //BA.debugLineNum = 131105;BA.debugLine="sb.Append(\"var rendered = Mustache.render(templ";
_sb.Append("var rendered = Mustache.render(template,"+_json+");");
RDebugUtils.currentLine=131106;
 //BA.debugLineNum = 131106;BA.debugLine="sb.Append(\"document.getElementById('target').in";
_sb.Append("document.getElementById('target').innerHTML = rendered;");
RDebugUtils.currentLine=131107;
 //BA.debugLineNum = 131107;BA.debugLine="sb.Append(\"}\")";
_sb.Append("}");
RDebugUtils.currentLine=131109;
 //BA.debugLineNum = 131109;BA.debugLine="File.WriteString(repfolder,\"render.js\",sb.ToStrin";
anywheresoftware.b4a.keywords.Common.File.WriteString(_repfolder,"render.js",_sb.ToString());
RDebugUtils.currentLine=131111;
 //BA.debugLineNum = 131111;BA.debugLine="Dim t As Long = DateTime.Now";
_t = anywheresoftware.b4a.keywords.Common.DateTime.getNow();
RDebugUtils.currentLine=131112;
 //BA.debugLineNum = 131112;BA.debugLine="Dim fileready As Boolean=False";
_fileready = anywheresoftware.b4a.keywords.Common.False;
RDebugUtils.currentLine=131113;
 //BA.debugLineNum = 131113;BA.debugLine="Do While fileready=False And DateTime.Now < t+500";
while (_fileready==anywheresoftware.b4a.keywords.Common.False && anywheresoftware.b4a.keywords.Common.DateTime.getNow()<_t+5000) {
RDebugUtils.currentLine=131114;
 //BA.debugLineNum = 131114;BA.debugLine="If File.Exists(repfolder,\"render.js\") Then";
if (anywheresoftware.b4a.keywords.Common.File.Exists(_repfolder,"render.js")) { 
RDebugUtils.currentLine=131115;
 //BA.debugLineNum = 131115;BA.debugLine="fileready=True";
_fileready = anywheresoftware.b4a.keywords.Common.True;
 };
 }
;
RDebugUtils.currentLine=131118;
 //BA.debugLineNum = 131118;BA.debugLine="If fileready=True Then";
if (_fileready==anywheresoftware.b4a.keywords.Common.True) { 
RDebugUtils.currentLine=131119;
 //BA.debugLineNum = 131119;BA.debugLine="PdfSh.Initialize(\"PdfPrint\", \"c:\\program files";
_pdfsh.Initialize("PdfPrint","c:\\program files\\wkhtmltopdf\\bin\\wkhtmltopdf.exe",anywheresoftware.b4a.keywords.Common.ArrayToList(new String[]{"--javascript-delay 	","500","--enable-local-file-access",_repfolder+"report.html",_repfolder+_pdfname}));
RDebugUtils.currentLine=131120;
 //BA.debugLineNum = 131120;BA.debugLine="PdfSh.WorkingDirectory = repfolder";
_pdfsh.setWorkingDirectory(_repfolder);
RDebugUtils.currentLine=131121;
 //BA.debugLineNum = 131121;BA.debugLine="PdfSh.Run(5000)";
_pdfsh.Run(ba,(long) (5000));
 }else {
RDebugUtils.currentLine=131123;
 //BA.debugLineNum = 131123;BA.debugLine="fx.Msgbox(MainForm,\"Check wkhtmltopdf and report";
_fx.Msgbox(_mainform,"Check wkhtmltopdf and report paths","Stop");
 };
RDebugUtils.currentLine=131126;
 //BA.debugLineNum = 131126;BA.debugLine="End Sub";
return "";
}
public static String  _pdfprint_processcompleted(boolean _success,int _exitcode,String _stdout,String _stderr) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "pdfprint_processcompleted", false))
	 {return ((String) Debug.delegate(ba, "pdfprint_processcompleted", new Object[] {_success,_exitcode,_stdout,_stderr}));}
String _fileseparator = "";
String _appdir = "";
String _osname = "";
RDebugUtils.currentLine=196608;
 //BA.debugLineNum = 196608;BA.debugLine="Sub PdfPrint_ProcessCompleted (Success As Boolean,";
RDebugUtils.currentLine=196609;
 //BA.debugLineNum = 196609;BA.debugLine="Log(StdOut)";
anywheresoftware.b4a.keywords.Common.Log(_stdout);
RDebugUtils.currentLine=196610;
 //BA.debugLineNum = 196610;BA.debugLine="Log(StdErr)";
anywheresoftware.b4a.keywords.Common.Log(_stderr);
RDebugUtils.currentLine=196611;
 //BA.debugLineNum = 196611;BA.debugLine="Dim FileSeparator As String=\"/\"";
_fileseparator = "/";
RDebugUtils.currentLine=196612;
 //BA.debugLineNum = 196612;BA.debugLine="Dim AppDir As String=\"appdir\"";
_appdir = "appdir";
RDebugUtils.currentLine=196613;
 //BA.debugLineNum = 196613;BA.debugLine="Dim OsName As String=asJO(Me).RunMethod(\"getSysPr";
_osname = BA.ObjectToString(_asjo((anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(main.getObject()))).RunMethod("getSysProp",(Object[])(new String[]{"os.name"})));
RDebugUtils.currentLine=196614;
 //BA.debugLineNum = 196614;BA.debugLine="If Success And ExitCode = 0 Then";
if (_success && _exitcode==0) { 
RDebugUtils.currentLine=196615;
 //BA.debugLineNum = 196615;BA.debugLine="If OsName.Contains(\"Windows\") Then";
if (_osname.contains("Windows")) { 
RDebugUtils.currentLine=196616;
 //BA.debugLineNum = 196616;BA.debugLine="fx.ShowExternalDocument(File.GetUri(repfolder,p";
_fx.ShowExternalDocument(anywheresoftware.b4a.keywords.Common.File.GetUri(_repfolder,_pdfname));
 }else 
{RDebugUtils.currentLine=196617;
 //BA.debugLineNum = 196617;BA.debugLine="Else If OsName.Contains(\"Linux\") Then";
if (_osname.contains("Linux")) { 
RDebugUtils.currentLine=196618;
 //BA.debugLineNum = 196618;BA.debugLine="fx.ShowExternalDocument( AppDir & FileSeparator";
_fx.ShowExternalDocument(_appdir+_fileseparator+_pdfname);
 }}
;
 }else {
RDebugUtils.currentLine=196621;
 //BA.debugLineNum = 196621;BA.debugLine="fx.Msgbox(MainForm,\"Check wkhtmltopdf error mess";
_fx.Msgbox(_mainform,"Check wkhtmltopdf error messages in log","Stop");
 };
RDebugUtils.currentLine=196623;
 //BA.debugLineNum = 196623;BA.debugLine="End Sub";
return "";
}

public static String getAppPath(){
    String userDir = System.getProperty("user.dir");
	return userDir;
}
public static String getSysProp(String fld){
    String data = System.getProperty(fld);
	return data;
}

}