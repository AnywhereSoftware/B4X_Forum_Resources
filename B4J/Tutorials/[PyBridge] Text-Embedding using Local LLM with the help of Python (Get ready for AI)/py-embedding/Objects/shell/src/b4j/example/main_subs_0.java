package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _appstart(RemoteObject _args) throws Exception{
try {
		Debug.PushSubsStack("AppStart (main) ","main",0,main.ba,main.mostCurrent,11);
if (RapidSub.canDelegate("appstart")) { return b4j.example.main.remoteMe.runUserSub(false, "main","appstart", _args);}
Debug.locals.put("Args", _args);
 BA.debugLineNum = 11;BA.debugLine="Sub AppStart (Args() As String)";
Debug.ShouldStop(1024);
 BA.debugLineNum = 12;BA.debugLine="srvr.Initialize(\"srvr\")";
Debug.ShouldStop(2048);
main._srvr.runVoidMethod ("Initialize",main.ba,(Object)(RemoteObject.createImmutable("srvr")));
 BA.debugLineNum = 13;BA.debugLine="srvr.Port = 8080";
Debug.ShouldStop(4096);
main._srvr.runMethod(true,"setPort",BA.numberCast(int.class, 8080));
 BA.debugLineNum = 16;BA.debugLine="srvr.StaticFilesFolder=\"www\"";
Debug.ShouldStop(32768);
main._srvr.runMethod(true,"setStaticFilesFolder",BA.ObjectToString("www"));
 BA.debugLineNum = 17;BA.debugLine="srvr.AddWebSocket(\"/ws_search\", \"searchws\")";
Debug.ShouldStop(65536);
main._srvr.runVoidMethod ("AddWebSocket",(Object)(BA.ObjectToString("/ws_search")),(Object)(RemoteObject.createImmutable("searchws")));
 BA.debugLineNum = 18;BA.debugLine="srvr.AddHandler(\"/convert\", \"ConvertHandler\", Fal";
Debug.ShouldStop(131072);
main._srvr.runVoidMethod ("AddHandler",(Object)(BA.ObjectToString("/convert")),(Object)(BA.ObjectToString("ConvertHandler")),(Object)(main.__c.getField(true,"False")));
 BA.debugLineNum = 21;BA.debugLine="srvr.AddBackgroundWorker(\"PyBridgeWorker\")";
Debug.ShouldStop(1048576);
main._srvr.runVoidMethod ("AddBackgroundWorker",(Object)(RemoteObject.createImmutable("PyBridgeWorker")));
 BA.debugLineNum = 23;BA.debugLine="srvr.Start";
Debug.ShouldStop(4194304);
main._srvr.runVoidMethod ("Start");
 BA.debugLineNum = 24;BA.debugLine="Log(\"The Text-Embedding running on http://127.0.0";
Debug.ShouldStop(8388608);
main.__c.runVoidMethod ("LogImpl","265549",RemoteObject.createImmutable("The Text-Embedding running on http://127.0.0.1:8080"),0);
 BA.debugLineNum = 26;BA.debugLine="StartMessageLoop";
Debug.ShouldStop(33554432);
main.__c.runVoidMethod ("StartMessageLoop",main.ba);
 BA.debugLineNum = 27;BA.debugLine="End Sub";
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
b4xcollections_subs_0._process_globals();
main.myClass = BA.getDeviceClass ("b4j.example.main");
pybridgeworker.myClass = BA.getDeviceClass ("b4j.example.pybridgeworker");
searchws.myClass = BA.getDeviceClass ("b4j.example.searchws");
converthandler.myClass = BA.getDeviceClass ("b4j.example.converthandler");
pybridge.myClass = BA.getDeviceClass ("b4j.example.pybridge");
pycomm.myClass = BA.getDeviceClass ("b4j.example.pycomm");
pyerrorhandler.myClass = BA.getDeviceClass ("b4j.example.pyerrorhandler");
pyutils.myClass = BA.getDeviceClass ("b4j.example.pyutils");
pywrapper.myClass = BA.getDeviceClass ("b4j.example.pywrapper");
b4xbitset.myClass = BA.getDeviceClass ("b4j.example.b4xbitset");
b4xbytesbuilder.myClass = BA.getDeviceClass ("b4j.example.b4xbytesbuilder");
b4xcache.myClass = BA.getDeviceClass ("b4j.example.b4xcache");
b4xcollections.myClass = BA.getDeviceClass ("b4j.example.b4xcollections");
b4xcomparatorsort.myClass = BA.getDeviceClass ("b4j.example.b4xcomparatorsort");
b4xorderedmap.myClass = BA.getDeviceClass ("b4j.example.b4xorderedmap");
b4xset.myClass = BA.getDeviceClass ("b4j.example.b4xset");
copyonwritelist.myClass = BA.getDeviceClass ("b4j.example.copyonwritelist");
copyonwritemap.myClass = BA.getDeviceClass ("b4j.example.copyonwritemap");
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 6;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 7;BA.debugLine="Private srvr As Server";
main._srvr = RemoteObject.createNew ("anywheresoftware.b4j.object.ServerWrapper");
 //BA.debugLineNum = 8;BA.debugLine="Public PyWorker As PyBridgeWorker ' Worker checki";
main._pyworker = RemoteObject.createNew ("b4j.example.pybridgeworker");
 //BA.debugLineNum = 9;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}