package b4a.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class starter_subs_0 {


public static RemoteObject  _application_error(RemoteObject _error,RemoteObject _stacktrace) throws Exception{
try {
		Debug.PushSubsStack("Application_Error (starter) ","starter",1,starter.processBA,starter.mostCurrent,27);
if (RapidSub.canDelegate("application_error")) { return b4a.example.starter.remoteMe.runUserSub(false, "starter","application_error", _error, _stacktrace);}
Debug.locals.put("Error", _error);
Debug.locals.put("StackTrace", _stacktrace);
 BA.debugLineNum = 27;BA.debugLine="Sub Application_Error (Error As Exception, StackTr";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 28;BA.debugLine="Return True";
Debug.ShouldStop(134217728);
if (true) return starter.mostCurrent.__c.getField(true,"True");
 BA.debugLineNum = 29;BA.debugLine="End Sub";
Debug.ShouldStop(268435456);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 6;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 10;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _service_create() throws Exception{
try {
		Debug.PushSubsStack("Service_Create (starter) ","starter",1,starter.processBA,starter.mostCurrent,12);
if (RapidSub.canDelegate("service_create")) { return b4a.example.starter.remoteMe.runUserSub(false, "starter","service_create");}
 BA.debugLineNum = 12;BA.debugLine="Sub Service_Create";
Debug.ShouldStop(2048);
 BA.debugLineNum = 16;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _service_destroy() throws Exception{
try {
		Debug.PushSubsStack("Service_Destroy (starter) ","starter",1,starter.processBA,starter.mostCurrent,31);
if (RapidSub.canDelegate("service_destroy")) { return b4a.example.starter.remoteMe.runUserSub(false, "starter","service_destroy");}
 BA.debugLineNum = 31;BA.debugLine="Sub Service_Destroy";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 33;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _service_start(RemoteObject _startingintent) throws Exception{
try {
		Debug.PushSubsStack("Service_Start (starter) ","starter",1,starter.processBA,starter.mostCurrent,18);
if (RapidSub.canDelegate("service_start")) { return b4a.example.starter.remoteMe.runUserSub(false, "starter","service_start", _startingintent);}
Debug.locals.put("StartingIntent", _startingintent);
 BA.debugLineNum = 18;BA.debugLine="Sub Service_Start (StartingIntent As Intent)";
Debug.ShouldStop(131072);
 BA.debugLineNum = 19;BA.debugLine="Service.StopAutomaticForeground 'Starter service";
Debug.ShouldStop(262144);
starter.mostCurrent._service.runVoidMethod ("StopAutomaticForeground");
 BA.debugLineNum = 20;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _service_taskremoved() throws Exception{
try {
		Debug.PushSubsStack("Service_TaskRemoved (starter) ","starter",1,starter.processBA,starter.mostCurrent,22);
if (RapidSub.canDelegate("service_taskremoved")) { return b4a.example.starter.remoteMe.runUserSub(false, "starter","service_taskremoved");}
 BA.debugLineNum = 22;BA.debugLine="Sub Service_TaskRemoved";
Debug.ShouldStop(2097152);
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
}