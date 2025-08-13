package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _appstart(RemoteObject _args) throws Exception{
try {
		Debug.PushSubsStack("AppStart (main) ","main",0,main.ba,main.mostCurrent,14);
if (RapidSub.canDelegate("appstart")) { return b4j.example.main.remoteMe.runUserSub(false, "main","appstart", _args);}
Debug.locals.put("Args", _args);
 BA.debugLineNum = 14;BA.debugLine="Sub AppStart (Args() As String)";
Debug.ShouldStop(8192);
 BA.debugLineNum = 15;BA.debugLine="srvr.Initialize(\"srvr\")";
Debug.ShouldStop(16384);
main._srvr.runVoidMethod ("Initialize",main.ba,(Object)(RemoteObject.createImmutable("srvr")));
 BA.debugLineNum = 16;BA.debugLine="srvr.Port = 51042";
Debug.ShouldStop(32768);
main._srvr.runMethod(true,"setPort",BA.numberCast(int.class, 51042));
 BA.debugLineNum = 17;BA.debugLine="srvr.StaticFilesFolder = File.Combine(File.DirApp";
Debug.ShouldStop(65536);
main._srvr.runMethod(true,"setStaticFilesFolder",main.__c.getField(false,"File").runMethod(true,"Combine",(Object)(main.__c.getField(false,"File").runMethod(true,"getDirApp")),(Object)(RemoteObject.createImmutable("www"))));
 BA.debugLineNum = 18;BA.debugLine="srvr.AddHandler(\"\", \"ControllerInicio\", False)";
Debug.ShouldStop(131072);
main._srvr.runVoidMethod ("AddHandler",(Object)(BA.ObjectToString("")),(Object)(BA.ObjectToString("ControllerInicio")),(Object)(main.__c.getField(true,"False")));
 BA.debugLineNum = 19;BA.debugLine="srvr.AddHandler(\"/get\", \"ModelGetTasks\", False)";
Debug.ShouldStop(262144);
main._srvr.runVoidMethod ("AddHandler",(Object)(BA.ObjectToString("/get")),(Object)(BA.ObjectToString("ModelGetTasks")),(Object)(main.__c.getField(true,"False")));
 BA.debugLineNum = 20;BA.debugLine="srvr.AddHandler(\"/add\", \"ModelAddTask\", False)";
Debug.ShouldStop(524288);
main._srvr.runVoidMethod ("AddHandler",(Object)(BA.ObjectToString("/add")),(Object)(BA.ObjectToString("ModelAddTask")),(Object)(main.__c.getField(true,"False")));
 BA.debugLineNum = 21;BA.debugLine="srvr.AddHandler(\"/delete\", \"ModelDeleteTask\", Fal";
Debug.ShouldStop(1048576);
main._srvr.runVoidMethod ("AddHandler",(Object)(BA.ObjectToString("/delete")),(Object)(BA.ObjectToString("ModelDeleteTask")),(Object)(main.__c.getField(true,"False")));
 BA.debugLineNum = 22;BA.debugLine="srvr.Start";
Debug.ShouldStop(2097152);
main._srvr.runVoidMethod ("Start");
 BA.debugLineNum = 23;BA.debugLine="StartMessageLoop";
Debug.ShouldStop(4194304);
main.__c.runVoidMethod ("StartMessageLoop",main.ba);
 BA.debugLineNum = 25;BA.debugLine="End Sub";
Debug.ShouldStop(16777216);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getlisttask() throws Exception{
try {
		Debug.PushSubsStack("GetListTask (main) ","main",0,main.ba,main.mostCurrent,31);
if (RapidSub.canDelegate("getlisttask")) { return b4j.example.main.remoteMe.runUserSub(false, "main","getlisttask");}
RemoteObject _ul = RemoteObject.declareNull("br.com.oaksoftware.easyhtml.easyhtml");
RemoteObject _cursor = RemoteObject.declareNull("anywheresoftware.b4j.objects.SQL.ResultSetWrapper");
RemoteObject _btndelete = RemoteObject.declareNull("br.com.oaksoftware.easyhtml.easyhtml");
RemoteObject _li = RemoteObject.declareNull("br.com.oaksoftware.easyhtml.easyhtml");
 BA.debugLineNum = 31;BA.debugLine="Public Sub GetListTask As String";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 32;BA.debugLine="Dim Ul As EasyHTML";
Debug.ShouldStop(-2147483648);
_ul = RemoteObject.createNew ("br.com.oaksoftware.easyhtml.easyhtml");Debug.locals.put("Ul", _ul);
 BA.debugLineNum = 33;BA.debugLine="Ul.Initialize(\"ul\").AddStyle(\"margin-top\", \"3rem\"";
Debug.ShouldStop(1);
_ul.runMethod(false,"_initialize",main.ba,(Object)(RemoteObject.createImmutable("ul"))).runVoidMethod ("_addstyle",(Object)(BA.ObjectToString("margin-top")),(Object)(RemoteObject.createImmutable("3rem")));
 BA.debugLineNum = 34;BA.debugLine="Try";
Debug.ShouldStop(2);
try { BA.debugLineNum = 35;BA.debugLine="OpenDB";
Debug.ShouldStop(4);
_opendb();
 BA.debugLineNum = 36;BA.debugLine="Dim Cursor As ResultSet = db.ExecQuery(\"SELECT *";
Debug.ShouldStop(8);
_cursor = RemoteObject.createNew ("anywheresoftware.b4j.objects.SQL.ResultSetWrapper");
_cursor = main._db.runMethod(false,"ExecQuery",(Object)(RemoteObject.createImmutable("SELECT * FROM tasks")));Debug.locals.put("Cursor", _cursor);Debug.locals.put("Cursor", _cursor);
 BA.debugLineNum = 37;BA.debugLine="Do While Cursor.NextRow";
Debug.ShouldStop(16);
while (_cursor.runMethod(true,"NextRow").<Boolean>get().booleanValue()) {
 BA.debugLineNum = 38;BA.debugLine="Dim BtnDelete As EasyHTML";
Debug.ShouldStop(32);
_btndelete = RemoteObject.createNew ("br.com.oaksoftware.easyhtml.easyhtml");Debug.locals.put("BtnDelete", _btndelete);
 BA.debugLineNum = 39;BA.debugLine="Dim li As EasyHTML";
Debug.ShouldStop(64);
_li = RemoteObject.createNew ("br.com.oaksoftware.easyhtml.easyhtml");Debug.locals.put("li", _li);
 BA.debugLineNum = 40;BA.debugLine="BtnDelete.Initialize(\"button\").HX_POST(\"/delete";
Debug.ShouldStop(128);
_btndelete.runMethod(false,"_initialize",main.ba,(Object)(RemoteObject.createImmutable("button"))).runMethod(false,"_hx_post",(Object)(RemoteObject.createImmutable("/delete"))).runMethod(false,"_hx_vals",(Object)((RemoteObject.concat(RemoteObject.createImmutable(" { \"id\": \""),main.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_cursor.runMethod(true,"GetString",(Object)(RemoteObject.createImmutable("id")))))),RemoteObject.createImmutable("\" } "))))).runMethod(false,"_hx_target",(Object)(RemoteObject.createImmutable("#divTasks"))).runMethod(false,"_addelement",(Object)(RemoteObject.createImmutable("Delete"))).runVoidMethod ("_addclass",(Object)(RemoteObject.createImmutable("secondary")));
 BA.debugLineNum = 41;BA.debugLine="li.Initialize(\"li\").AddElement(Cursor.GetString";
Debug.ShouldStop(256);
_li.runMethod(false,"_initialize",main.ba,(Object)(RemoteObject.createImmutable("li"))).runMethod(false,"_addelement",(Object)(_cursor.runMethod(true,"GetString",(Object)(RemoteObject.createImmutable("task"))))).runMethod(false,"_addelement",(Object)(_btndelete.runMethod(true,"_mount"))).runMethod(false,"_addstyle",(Object)(BA.ObjectToString("display")),(Object)(RemoteObject.createImmutable("flex"))).runVoidMethod ("_addstyle",(Object)(BA.ObjectToString("justify-content")),(Object)(RemoteObject.createImmutable("space-between")));
 BA.debugLineNum = 42;BA.debugLine="Ul.AddElement(li.Mount)";
Debug.ShouldStop(512);
_ul.runVoidMethod ("_addelement",(Object)(_li.runMethod(true,"_mount")));
 }
;
 BA.debugLineNum = 44;BA.debugLine="db.Close";
Debug.ShouldStop(2048);
main._db.runVoidMethod ("Close");
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e15) {
			BA.rdebugUtils.runVoidMethod("setLastException",main.ba, e15.toString()); BA.debugLineNum = 46;BA.debugLine="Log(LastException)";
Debug.ShouldStop(8192);
main.__c.runVoidMethod ("LogImpl","61114127",BA.ObjectToString(main.__c.runMethod(false,"LastException",main.ba)),0);
 };
 BA.debugLineNum = 48;BA.debugLine="Return Ul.Mount";
Debug.ShouldStop(32768);
if (true) return _ul.runMethod(true,"_mount");
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
public static RemoteObject  _opendb() throws Exception{
try {
		Debug.PushSubsStack("OpenDB (main) ","main",0,main.ba,main.mostCurrent,27);
if (RapidSub.canDelegate("opendb")) { return b4j.example.main.remoteMe.runUserSub(false, "main","opendb");}
 BA.debugLineNum = 27;BA.debugLine="Public Sub OpenDB";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 28;BA.debugLine="db.InitializeSQLite(File.DirApp, \"dados.sqlite3\",";
Debug.ShouldStop(134217728);
main._db.runVoidMethod ("InitializeSQLite",(Object)(main.__c.getField(false,"File").runMethod(true,"getDirApp")),(Object)(BA.ObjectToString("dados.sqlite3")),(Object)(main.__c.getField(true,"True")));
 BA.debugLineNum = 29;BA.debugLine="End Sub";
Debug.ShouldStop(268435456);
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
controllerinicio.myClass = BA.getDeviceClass ("b4j.example.controllerinicio");
modeladdtask.myClass = BA.getDeviceClass ("b4j.example.modeladdtask");
modeldeletetask.myClass = BA.getDeviceClass ("b4j.example.modeldeletetask");
modelgettasks.myClass = BA.getDeviceClass ("b4j.example.modelgettasks");
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 8;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 9;BA.debugLine="Private srvr As Server";
main._srvr = RemoteObject.createNew ("anywheresoftware.b4j.object.ServerWrapper");
 //BA.debugLineNum = 11;BA.debugLine="Public db As SQL";
main._db = RemoteObject.createNew ("anywheresoftware.b4j.objects.SQL");
 //BA.debugLineNum = 12;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}