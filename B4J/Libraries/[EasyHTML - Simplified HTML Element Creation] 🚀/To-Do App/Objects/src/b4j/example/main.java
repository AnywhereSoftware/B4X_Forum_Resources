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
public static anywheresoftware.b4j.object.ServerWrapper _srvr = null;
public static anywheresoftware.b4j.objects.SQL _db = null;
public static String  _appstart(String[] _args) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "appstart", false))
	 {return ((String) Debug.delegate(ba, "appstart", new Object[] {_args}));}
RDebugUtils.currentLine=65536;
 //BA.debugLineNum = 65536;BA.debugLine="Sub AppStart (Args() As String)";
RDebugUtils.currentLine=65537;
 //BA.debugLineNum = 65537;BA.debugLine="srvr.Initialize(\"srvr\")";
_srvr.Initialize(ba,"srvr");
RDebugUtils.currentLine=65538;
 //BA.debugLineNum = 65538;BA.debugLine="srvr.Port = 51042";
_srvr.setPort((int) (51042));
RDebugUtils.currentLine=65539;
 //BA.debugLineNum = 65539;BA.debugLine="srvr.StaticFilesFolder = File.Combine(File.DirApp";
_srvr.setStaticFilesFolder(anywheresoftware.b4a.keywords.Common.File.Combine(anywheresoftware.b4a.keywords.Common.File.getDirApp(),"www"));
RDebugUtils.currentLine=65540;
 //BA.debugLineNum = 65540;BA.debugLine="srvr.AddHandler(\"\", \"ControllerInicio\", False)";
_srvr.AddHandler("","ControllerInicio",anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=65541;
 //BA.debugLineNum = 65541;BA.debugLine="srvr.AddHandler(\"/get\", \"ModelGetTasks\", False)";
_srvr.AddHandler("/get","ModelGetTasks",anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=65542;
 //BA.debugLineNum = 65542;BA.debugLine="srvr.AddHandler(\"/add\", \"ModelAddTask\", False)";
_srvr.AddHandler("/add","ModelAddTask",anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=65543;
 //BA.debugLineNum = 65543;BA.debugLine="srvr.AddHandler(\"/delete\", \"ModelDeleteTask\", Fal";
_srvr.AddHandler("/delete","ModelDeleteTask",anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=65544;
 //BA.debugLineNum = 65544;BA.debugLine="srvr.Start";
_srvr.Start();
RDebugUtils.currentLine=65545;
 //BA.debugLineNum = 65545;BA.debugLine="StartMessageLoop";
anywheresoftware.b4a.keywords.Common.StartMessageLoop(ba);
RDebugUtils.currentLine=65547;
 //BA.debugLineNum = 65547;BA.debugLine="End Sub";
return "";
}
public static String  _getlisttask() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "getlisttask", false))
	 {return ((String) Debug.delegate(ba, "getlisttask", null));}
br.com.oaksoftware.easyhtml.easyhtml _ul = null;
anywheresoftware.b4j.objects.SQL.ResultSetWrapper _cursor = null;
br.com.oaksoftware.easyhtml.easyhtml _btndelete = null;
br.com.oaksoftware.easyhtml.easyhtml _li = null;
RDebugUtils.currentLine=1114112;
 //BA.debugLineNum = 1114112;BA.debugLine="Public Sub GetListTask As String";
RDebugUtils.currentLine=1114113;
 //BA.debugLineNum = 1114113;BA.debugLine="Dim Ul As EasyHTML";
_ul = new br.com.oaksoftware.easyhtml.easyhtml();
RDebugUtils.currentLine=1114114;
 //BA.debugLineNum = 1114114;BA.debugLine="Ul.Initialize(\"ul\").AddStyle(\"margin-top\", \"3rem\"";
_ul._initialize(ba,"ul")._addstyle("margin-top","3rem");
RDebugUtils.currentLine=1114115;
 //BA.debugLineNum = 1114115;BA.debugLine="Try";
try {RDebugUtils.currentLine=1114116;
 //BA.debugLineNum = 1114116;BA.debugLine="OpenDB";
_opendb();
RDebugUtils.currentLine=1114117;
 //BA.debugLineNum = 1114117;BA.debugLine="Dim Cursor As ResultSet = db.ExecQuery(\"SELECT *";
_cursor = new anywheresoftware.b4j.objects.SQL.ResultSetWrapper();
_cursor = _db.ExecQuery("SELECT * FROM tasks");
RDebugUtils.currentLine=1114118;
 //BA.debugLineNum = 1114118;BA.debugLine="Do While Cursor.NextRow";
while (_cursor.NextRow()) {
RDebugUtils.currentLine=1114119;
 //BA.debugLineNum = 1114119;BA.debugLine="Dim BtnDelete As EasyHTML";
_btndelete = new br.com.oaksoftware.easyhtml.easyhtml();
RDebugUtils.currentLine=1114120;
 //BA.debugLineNum = 1114120;BA.debugLine="Dim li As EasyHTML";
_li = new br.com.oaksoftware.easyhtml.easyhtml();
RDebugUtils.currentLine=1114121;
 //BA.debugLineNum = 1114121;BA.debugLine="BtnDelete.Initialize(\"button\").HX_POST(\"/delete";
_btndelete._initialize(ba,"button")._hx_post("/delete")._hx_vals((" { \"id\": \""+anywheresoftware.b4a.keywords.Common.SmartStringFormatter("",(Object)(_cursor.GetString("id")))+"\" } "))._hx_target("#divTasks")._addelement("Delete")._addclass("secondary");
RDebugUtils.currentLine=1114122;
 //BA.debugLineNum = 1114122;BA.debugLine="li.Initialize(\"li\").AddElement(Cursor.GetString";
_li._initialize(ba,"li")._addelement(_cursor.GetString("task"))._addelement(_btndelete._mount())._addstyle("display","flex")._addstyle("justify-content","space-between");
RDebugUtils.currentLine=1114123;
 //BA.debugLineNum = 1114123;BA.debugLine="Ul.AddElement(li.Mount)";
_ul._addelement(_li._mount());
 }
;
RDebugUtils.currentLine=1114125;
 //BA.debugLineNum = 1114125;BA.debugLine="db.Close";
_db.Close();
 } 
       catch (Exception e15) {
			ba.setLastException(e15);RDebugUtils.currentLine=1114127;
 //BA.debugLineNum = 1114127;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("61114127",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=1114129;
 //BA.debugLineNum = 1114129;BA.debugLine="Return Ul.Mount";
if (true) return _ul._mount();
RDebugUtils.currentLine=1114130;
 //BA.debugLineNum = 1114130;BA.debugLine="End Sub";
return "";
}
public static String  _opendb() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "opendb", false))
	 {return ((String) Debug.delegate(ba, "opendb", null));}
RDebugUtils.currentLine=1048576;
 //BA.debugLineNum = 1048576;BA.debugLine="Public Sub OpenDB";
RDebugUtils.currentLine=1048577;
 //BA.debugLineNum = 1048577;BA.debugLine="db.InitializeSQLite(File.DirApp, \"dados.sqlite3\",";
_db.InitializeSQLite(anywheresoftware.b4a.keywords.Common.File.getDirApp(),"dados.sqlite3",anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=1048578;
 //BA.debugLineNum = 1048578;BA.debugLine="End Sub";
return "";
}
}