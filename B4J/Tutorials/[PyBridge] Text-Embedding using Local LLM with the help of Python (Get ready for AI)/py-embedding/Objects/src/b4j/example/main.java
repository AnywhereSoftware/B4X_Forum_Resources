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
public static b4j.example.pybridgeworker _pyworker = null;
public static b4j.example.b4xcollections _b4xcollections = null;
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
 //BA.debugLineNum = 65538;BA.debugLine="srvr.Port = 8080";
_srvr.setPort((int) (8080));
RDebugUtils.currentLine=65541;
 //BA.debugLineNum = 65541;BA.debugLine="srvr.StaticFilesFolder=\"www\"";
_srvr.setStaticFilesFolder("www");
RDebugUtils.currentLine=65542;
 //BA.debugLineNum = 65542;BA.debugLine="srvr.AddWebSocket(\"/ws_search\", \"searchws\")";
_srvr.AddWebSocket("/ws_search","searchws");
RDebugUtils.currentLine=65543;
 //BA.debugLineNum = 65543;BA.debugLine="srvr.AddHandler(\"/convert\", \"ConvertHandler\", Fal";
_srvr.AddHandler("/convert","ConvertHandler",anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=65546;
 //BA.debugLineNum = 65546;BA.debugLine="srvr.AddBackgroundWorker(\"PyBridgeWorker\")";
_srvr.AddBackgroundWorker("PyBridgeWorker");
RDebugUtils.currentLine=65548;
 //BA.debugLineNum = 65548;BA.debugLine="srvr.Start";
_srvr.Start();
RDebugUtils.currentLine=65549;
 //BA.debugLineNum = 65549;BA.debugLine="Log(\"The Text-Embedding running on http://127.0.0";
anywheresoftware.b4a.keywords.Common.LogImpl("265549","The Text-Embedding running on http://127.0.0.1:8080",0);
RDebugUtils.currentLine=65551;
 //BA.debugLineNum = 65551;BA.debugLine="StartMessageLoop";
anywheresoftware.b4a.keywords.Common.StartMessageLoop(ba);
RDebugUtils.currentLine=65552;
 //BA.debugLineNum = 65552;BA.debugLine="End Sub";
return "";
}
}