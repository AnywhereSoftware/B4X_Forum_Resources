package b4a.example.markdownview;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static void  _activity_create(RemoteObject _firsttime) throws Exception{
try {
		Debug.PushSubsStack("Activity_Create (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,26);
if (RapidSub.canDelegate("activity_create")) { b4a.example.markdownview.main.remoteMe.runUserSub(false, "main","activity_create", _firsttime); return;}
ResumableSub_Activity_Create rsub = new ResumableSub_Activity_Create(null,_firsttime);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_Activity_Create extends BA.ResumableSub {
public ResumableSub_Activity_Create(b4a.example.markdownview.main parent,RemoteObject _firsttime) {
this.parent = parent;
this._firsttime = _firsttime;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
b4a.example.markdownview.main parent;
RemoteObject _firsttime;
RemoteObject _success = RemoteObject.createImmutable(false);

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("Activity_Create (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,26);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = -1;
Debug.locals.put("FirstTime", _firsttime);
 BA.debugLineNum = 27;BA.debugLine="Activity.LoadLayout(\"Layout\")";
Debug.ShouldStop(67108864);
parent.mostCurrent._activity.runMethodAndSync(false,"LoadLayout",(Object)(RemoteObject.createImmutable("Layout")),main.mostCurrent.activityBA);
 BA.debugLineNum = 29;BA.debugLine="Wait For (File.CopyAsync(File.DirAssets, \"README.";
Debug.ShouldStop(268435456);
parent.mostCurrent.__c.runVoidMethod ("WaitFor","complete", main.processBA, anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "main", "activity_create"), parent.mostCurrent.__c.getField(false,"File").runMethod(false,"CopyAsync",main.processBA,(Object)(parent.mostCurrent.__c.getField(false,"File").runMethod(true,"getDirAssets")),(Object)(BA.ObjectToString("README.md")),(Object)(parent.mostCurrent.__c.getField(false,"File").runMethod(true,"getDirInternal")),(Object)(RemoteObject.createImmutable("README.md"))));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_success = (RemoteObject) result.getArrayElement(true,RemoteObject.createImmutable(0));Debug.locals.put("Success", _success);
;
 BA.debugLineNum = 30;BA.debugLine="Log(\"Success: \" & Success)";
Debug.ShouldStop(536870912);
parent.mostCurrent.__c.runVoidMethod ("LogImpl","3131076",RemoteObject.concat(RemoteObject.createImmutable("Success: "),_success),0);
 BA.debugLineNum = 32;BA.debugLine="B4AMarkDownView1.loadMarkdownFromFile(File.Combin";
Debug.ShouldStop(-2147483648);
parent.mostCurrent._b4amarkdownview1.runVoidMethod ("loadMarkdownFromFile",(Object)(parent.mostCurrent.__c.getField(false,"File").runMethod(true,"Combine",(Object)(parent.mostCurrent.__c.getField(false,"File").runMethod(true,"getDirInternal")),(Object)(RemoteObject.createImmutable("README.md")))));
 BA.debugLineNum = 39;BA.debugLine="End Sub";
Debug.ShouldStop(64);
if (true) break;

            }
        }
    }
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}
public static void  _complete(RemoteObject _success) throws Exception{
}
public static RemoteObject  _activity_pause(RemoteObject _userclosed) throws Exception{
try {
		Debug.PushSubsStack("Activity_Pause (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,45);
if (RapidSub.canDelegate("activity_pause")) { return b4a.example.markdownview.main.remoteMe.runUserSub(false, "main","activity_pause", _userclosed);}
Debug.locals.put("UserClosed", _userclosed);
 BA.debugLineNum = 45;BA.debugLine="Sub Activity_Pause (UserClosed As Boolean)";
Debug.ShouldStop(4096);
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
if (RapidSub.canDelegate("activity_resume")) { return b4a.example.markdownview.main.remoteMe.runUserSub(false, "main","activity_resume");}
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
public static RemoteObject  _button1_click() throws Exception{
try {
		Debug.PushSubsStack("Button1_Click (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,49);
if (RapidSub.canDelegate("button1_click")) { return b4a.example.markdownview.main.remoteMe.runUserSub(false, "main","button1_click");}
 BA.debugLineNum = 49;BA.debugLine="Sub Button1_Click";
Debug.ShouldStop(65536);
 BA.debugLineNum = 50;BA.debugLine="xui.MsgboxAsync(\"Hello world!\", \"B4X\")";
Debug.ShouldStop(131072);
main._xui.runVoidMethod ("MsgboxAsync",main.processBA,(Object)(BA.ObjectToCharSequence("Hello world!")),(Object)(BA.ObjectToCharSequence(RemoteObject.createImmutable("B4X"))));
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
public static RemoteObject  _globals() throws Exception{
 //BA.debugLineNum = 21;BA.debugLine="Sub Globals";
 //BA.debugLineNum = 23;BA.debugLine="Private B4AMarkDownView1 As B4AMarkDownView";
main.mostCurrent._b4amarkdownview1 = RemoteObject.createNew ("com.example.B4AMarkDownView.B4AMarkDownView");
 //BA.debugLineNum = 24;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}

public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main_subs_0._process_globals();
starter_subs_0._process_globals();
main.myClass = BA.getDeviceClass ("b4a.example.markdownview.main");
starter.myClass = BA.getDeviceClass ("b4a.example.markdownview.starter");
		
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
}