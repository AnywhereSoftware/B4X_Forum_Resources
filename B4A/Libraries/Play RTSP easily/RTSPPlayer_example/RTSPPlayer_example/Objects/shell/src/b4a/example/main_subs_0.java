package b4a.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _activity_create(RemoteObject _firsttime) throws Exception{
try {
		Debug.PushSubsStack("Activity_Create (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,30);
if (RapidSub.canDelegate("activity_create")) { return b4a.example.main.remoteMe.runUserSub(false, "main","activity_create", _firsttime);}
RemoteObject _v = RemoteObject.declareNull("anywheresoftware.b4a.objects.ConcreteViewWrapper");
Debug.locals.put("FirstTime", _firsttime);
 BA.debugLineNum = 30;BA.debugLine="Sub Activity_Create(FirstTime As Boolean)";
Debug.ShouldStop(536870912);
 BA.debugLineNum = 31;BA.debugLine="Activity.LoadLayout(\"Layout\")";
Debug.ShouldStop(1073741824);
main.mostCurrent._activity.runMethodAndSync(false,"LoadLayout",(Object)(RemoteObject.createImmutable("Layout")),main.mostCurrent.activityBA);
 BA.debugLineNum = 33;BA.debugLine="Dim v As View = player.Initialize(\"RTSP\")";
Debug.ShouldStop(1);
_v = RemoteObject.createNew ("anywheresoftware.b4a.objects.ConcreteViewWrapper");
_v = main.mostCurrent._player.runMethod(false,"Initialize",main.processBA,(Object)(RemoteObject.createImmutable("RTSP")));Debug.locals.put("v", _v);Debug.locals.put("v", _v);
 BA.debugLineNum = 34;BA.debugLine="If player.IsInitialised Then";
Debug.ShouldStop(2);
if (main.mostCurrent._player.runMethod(true,"IsInitialised").<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 35;BA.debugLine="PlayerCont.AddView(v,0,0,PlayerCont.Width,Player";
Debug.ShouldStop(4);
main.mostCurrent._playercont.runVoidMethod ("AddView",(Object)((_v.getObject())),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(main.mostCurrent._playercont.runMethod(true,"getWidth")),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {main.mostCurrent._playercont.runMethod(true,"getWidth"),(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(9),RemoteObject.createImmutable(16)}, "/",0, 0))}, "*",0, 0))));
 BA.debugLineNum = 36;BA.debugLine="player.SetMedia(\"rtsp://192.168.2.200:554/user=a";
Debug.ShouldStop(8);
main.mostCurrent._player.runVoidMethod ("SetMedia",(Object)(BA.ObjectToString("rtsp://192.168.2.200:554/user=admin&password=admin1111&channel=1&stream=stream=1.sdp")),(Object)(BA.ObjectToString("admin")),(Object)(BA.ObjectToString("admin1111")),(Object)(RemoteObject.createImmutable("aaa")));
 };
 BA.debugLineNum = 39;BA.debugLine="End Sub";
Debug.ShouldStop(64);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _activity_pause(RemoteObject _userclosed) throws Exception{
try {
		Debug.PushSubsStack("Activity_Pause (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,45);
if (RapidSub.canDelegate("activity_pause")) { return b4a.example.main.remoteMe.runUserSub(false, "main","activity_pause", _userclosed);}
Debug.locals.put("UserClosed", _userclosed);
 BA.debugLineNum = 45;BA.debugLine="Sub Activity_Pause (UserClosed As Boolean)";
Debug.ShouldStop(4096);
 BA.debugLineNum = 46;BA.debugLine="If player.IsInitialised And player.IsStarted Then";
Debug.ShouldStop(8192);
if (RemoteObject.solveBoolean(".",main.mostCurrent._player.runMethod(true,"IsInitialised")) && RemoteObject.solveBoolean(".",main.mostCurrent._player.runMethod(true,"IsStarted"))) { 
main.mostCurrent._player.runVoidMethod ("Stop");};
 BA.debugLineNum = 47;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _activity_resume() throws Exception{
try {
		Debug.PushSubsStack("Activity_Resume (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,41);
if (RapidSub.canDelegate("activity_resume")) { return b4a.example.main.remoteMe.runUserSub(false, "main","activity_resume");}
 BA.debugLineNum = 41;BA.debugLine="Sub Activity_Resume";
Debug.ShouldStop(256);
 BA.debugLineNum = 43;BA.debugLine="End Sub";
Debug.ShouldStop(1024);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _globals() throws Exception{
 //BA.debugLineNum = 21;BA.debugLine="Sub Globals";
 //BA.debugLineNum = 24;BA.debugLine="Dim player As RTSPVideoPlayer";
main.mostCurrent._player = RemoteObject.createNew ("com.biswajit.rtsp.RTSPPlayerWrapper");
 //BA.debugLineNum = 25;BA.debugLine="Private PlayerCont As Panel";
main.mostCurrent._playercont = RemoteObject.createNew ("anywheresoftware.b4a.objects.PanelWrapper");
 //BA.debugLineNum = 26;BA.debugLine="Private stopBtn As Button";
main.mostCurrent._stopbtn = RemoteObject.createNew ("anywheresoftware.b4a.objects.ButtonWrapper");
 //BA.debugLineNum = 27;BA.debugLine="Private startBtn As Button";
main.mostCurrent._startbtn = RemoteObject.createNew ("anywheresoftware.b4a.objects.ButtonWrapper");
 //BA.debugLineNum = 28;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}

public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main_subs_0._process_globals();
starter_subs_0._process_globals();
main.myClass = BA.getDeviceClass ("b4a.example.main");
starter.myClass = BA.getDeviceClass ("b4a.example.starter");
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 15;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 18;BA.debugLine="Private xui As XUI";
main._xui = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");
 //BA.debugLineNum = 19;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _rtsp_connected() throws Exception{
try {
		Debug.PushSubsStack("RTSP_Connected (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,57);
if (RapidSub.canDelegate("rtsp_connected")) { return b4a.example.main.remoteMe.runUserSub(false, "main","rtsp_connected");}
 BA.debugLineNum = 57;BA.debugLine="Sub RTSP_Connected";
Debug.ShouldStop(16777216);
 BA.debugLineNum = 58;BA.debugLine="Activity.Title = \"Connected\"";
Debug.ShouldStop(33554432);
main.mostCurrent._activity.runMethod(false,"setTitle",BA.ObjectToCharSequence("Connected"));
 BA.debugLineNum = 59;BA.debugLine="End Sub";
Debug.ShouldStop(67108864);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _rtsp_connecting() throws Exception{
try {
		Debug.PushSubsStack("RTSP_Connecting (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,61);
if (RapidSub.canDelegate("rtsp_connecting")) { return b4a.example.main.remoteMe.runUserSub(false, "main","rtsp_connecting");}
 BA.debugLineNum = 61;BA.debugLine="Sub RTSP_Connecting";
Debug.ShouldStop(268435456);
 BA.debugLineNum = 62;BA.debugLine="Activity.Title = \"Connecting\"";
Debug.ShouldStop(536870912);
main.mostCurrent._activity.runMethod(false,"setTitle",BA.ObjectToCharSequence("Connecting"));
 BA.debugLineNum = 63;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _rtsp_disconnected() throws Exception{
try {
		Debug.PushSubsStack("RTSP_Disconnected (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,65);
if (RapidSub.canDelegate("rtsp_disconnected")) { return b4a.example.main.remoteMe.runUserSub(false, "main","rtsp_disconnected");}
 BA.debugLineNum = 65;BA.debugLine="Sub RTSP_Disconnected";
Debug.ShouldStop(1);
 BA.debugLineNum = 66;BA.debugLine="Activity.Title = \"Disconnected\"";
Debug.ShouldStop(2);
main.mostCurrent._activity.runMethod(false,"setTitle",BA.ObjectToCharSequence("Disconnected"));
 BA.debugLineNum = 67;BA.debugLine="End Sub";
Debug.ShouldStop(4);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _rtsp_error(RemoteObject _message) throws Exception{
try {
		Debug.PushSubsStack("RTSP_Error (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,69);
if (RapidSub.canDelegate("rtsp_error")) { return b4a.example.main.remoteMe.runUserSub(false, "main","rtsp_error", _message);}
Debug.locals.put("message", _message);
 BA.debugLineNum = 69;BA.debugLine="Sub RTSP_Error(message As String)";
Debug.ShouldStop(16);
 BA.debugLineNum = 70;BA.debugLine="Msgbox(message, \"Error\")";
Debug.ShouldStop(32);
main.mostCurrent.__c.runVoidMethodAndSync ("Msgbox",(Object)(BA.ObjectToCharSequence(_message)),(Object)(BA.ObjectToCharSequence(RemoteObject.createImmutable("Error"))),main.mostCurrent.activityBA);
 BA.debugLineNum = 71;BA.debugLine="End Sub";
Debug.ShouldStop(64);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _rtsp_firstframerendered() throws Exception{
try {
		Debug.PushSubsStack("RTSP_FirstFrameRendered (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,73);
if (RapidSub.canDelegate("rtsp_firstframerendered")) { return b4a.example.main.remoteMe.runUserSub(false, "main","rtsp_firstframerendered");}
 BA.debugLineNum = 73;BA.debugLine="Sub RTSP_FirstFrameRendered";
Debug.ShouldStop(256);
 BA.debugLineNum = 74;BA.debugLine="Activity.Title = \"Video Started\"";
Debug.ShouldStop(512);
main.mostCurrent._activity.runMethod(false,"setTitle",BA.ObjectToCharSequence("Video Started"));
 BA.debugLineNum = 75;BA.debugLine="End Sub";
Debug.ShouldStop(1024);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _rtsp_unauthorized() throws Exception{
try {
		Debug.PushSubsStack("RTSP_Unauthorized (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,77);
if (RapidSub.canDelegate("rtsp_unauthorized")) { return b4a.example.main.remoteMe.runUserSub(false, "main","rtsp_unauthorized");}
 BA.debugLineNum = 77;BA.debugLine="Sub RTSP_Unauthorized";
Debug.ShouldStop(4096);
 BA.debugLineNum = 78;BA.debugLine="Activity.Title = \"Auth Failed\"";
Debug.ShouldStop(8192);
main.mostCurrent._activity.runMethod(false,"setTitle",BA.ObjectToCharSequence("Auth Failed"));
 BA.debugLineNum = 79;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _startbtn_click() throws Exception{
try {
		Debug.PushSubsStack("startBtn_Click (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,49);
if (RapidSub.canDelegate("startbtn_click")) { return b4a.example.main.remoteMe.runUserSub(false, "main","startbtn_click");}
 BA.debugLineNum = 49;BA.debugLine="Private Sub startBtn_Click";
Debug.ShouldStop(65536);
 BA.debugLineNum = 50;BA.debugLine="If player.IsInitialised Then player.Start(True,Tr";
Debug.ShouldStop(131072);
if (main.mostCurrent._player.runMethod(true,"IsInitialised").<Boolean>get().booleanValue()) { 
main.mostCurrent._player.runVoidMethod ("Start",(Object)(main.mostCurrent.__c.getField(true,"True")),(Object)(main.mostCurrent.__c.getField(true,"True")));};
 BA.debugLineNum = 51;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _stopbtn_click() throws Exception{
try {
		Debug.PushSubsStack("stopBtn_Click (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,53);
if (RapidSub.canDelegate("stopbtn_click")) { return b4a.example.main.remoteMe.runUserSub(false, "main","stopbtn_click");}
 BA.debugLineNum = 53;BA.debugLine="Private Sub stopBtn_Click";
Debug.ShouldStop(1048576);
 BA.debugLineNum = 54;BA.debugLine="If player.IsInitialised Then player.Stop";
Debug.ShouldStop(2097152);
if (main.mostCurrent._player.runMethod(true,"IsInitialised").<Boolean>get().booleanValue()) { 
main.mostCurrent._player.runVoidMethod ("Stop");};
 BA.debugLineNum = 55;BA.debugLine="End Sub";
Debug.ShouldStop(4194304);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}