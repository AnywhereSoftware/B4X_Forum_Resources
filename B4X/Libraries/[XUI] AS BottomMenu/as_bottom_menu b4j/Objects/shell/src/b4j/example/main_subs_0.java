package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _application_error(RemoteObject _error,RemoteObject _stacktrace) throws Exception{
try {
		Debug.PushSubsStack("Application_Error (main) ","main",0,main.ba,main.mostCurrent,34);
if (RapidSub.canDelegate("application_error")) { return b4j.example.main.remoteMe.runUserSub(false, "main","application_error", _error, _stacktrace);}
Debug.locals.put("Error", _error);
Debug.locals.put("StackTrace", _stacktrace);
 BA.debugLineNum = 34;BA.debugLine="Sub Application_Error (Error As Exception, StackTr";
Debug.ShouldStop(2);
 BA.debugLineNum = 35;BA.debugLine="Return True";
Debug.ShouldStop(4);
if (true) return main.__c.getField(true,"True");
 BA.debugLineNum = 36;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
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
 BA.debugLineNum = 16;BA.debugLine="MainForm.RootPane.LoadLayout(\"frm_main\") 'Load th";
Debug.ShouldStop(32768);
main._mainform.runMethod(false,"getRootPane").runMethodAndSync(false,"LoadLayout",main.ba,(Object)(RemoteObject.createImmutable("frm_main")));
 BA.debugLineNum = 17;BA.debugLine="MainForm.Show";
Debug.ShouldStop(65536);
main._mainform.runVoidMethodAndSync ("Show");
 BA.debugLineNum = 19;BA.debugLine="ASBottomMenu1.SetIcon1(xui.LoadBitmap(File.DirAss";
Debug.ShouldStop(262144);
main._asbottommenu1.runClassMethod (b4j.example.asbottommenu.class, "_seticon1",(Object)(main._xui.runMethod(false,"LoadBitmap",(Object)(main.__c.getField(false,"File").runMethod(true,"getDirAssets")),(Object)(RemoteObject.createImmutable("home2.png")))));
 BA.debugLineNum = 20;BA.debugLine="ASBottomMenu1.SetIcon2(xui.LoadBitmap(File.DirAss";
Debug.ShouldStop(524288);
main._asbottommenu1.runClassMethod (b4j.example.asbottommenu.class, "_seticon2",(Object)(main._xui.runMethod(false,"LoadBitmap",(Object)(main.__c.getField(false,"File").runMethod(true,"getDirAssets")),(Object)(RemoteObject.createImmutable("chat.png")))));
 BA.debugLineNum = 21;BA.debugLine="ASBottomMenu1.SetIcon3(xui.loadBitmap(File.DirAss";
Debug.ShouldStop(1048576);
main._asbottommenu1.runClassMethod (b4j.example.asbottommenu.class, "_seticon3",(Object)(main._xui.runMethod(false,"LoadBitmap",(Object)(main.__c.getField(false,"File").runMethod(true,"getDirAssets")),(Object)(RemoteObject.createImmutable("group.png")))));
 BA.debugLineNum = 22;BA.debugLine="ASBottomMenu1.SetIcon4(xui.LoadBitmap(File.DirAss";
Debug.ShouldStop(2097152);
main._asbottommenu1.runClassMethod (b4j.example.asbottommenu.class, "_seticon4",(Object)(main._xui.runMethod(false,"LoadBitmap",(Object)(main.__c.getField(false,"File").runMethod(true,"getDirAssets")),(Object)(RemoteObject.createImmutable("settings.png")))));
 BA.debugLineNum = 24;BA.debugLine="ASBottomMenu1.EnableBadget1(True)";
Debug.ShouldStop(8388608);
main._asbottommenu1.runClassMethod (b4j.example.asbottommenu.class, "_enablebadget1",(Object)(main.__c.getField(true,"True")));
 BA.debugLineNum = 25;BA.debugLine="ASBottomMenu1.EnableBadget2(True)";
Debug.ShouldStop(16777216);
main._asbottommenu1.runClassMethod (b4j.example.asbottommenu.class, "_enablebadget2",(Object)(main.__c.getField(true,"True")));
 BA.debugLineNum = 26;BA.debugLine="ASBottomMenu1.EnableBadget3(True)";
Debug.ShouldStop(33554432);
main._asbottommenu1.runClassMethod (b4j.example.asbottommenu.class, "_enablebadget3",(Object)(main.__c.getField(true,"True")));
 BA.debugLineNum = 27;BA.debugLine="ASBottomMenu1.EnableBadget4(True)";
Debug.ShouldStop(67108864);
main._asbottommenu1.runClassMethod (b4j.example.asbottommenu.class, "_enablebadget4",(Object)(main.__c.getField(true,"True")));
 BA.debugLineNum = 29;BA.debugLine="ASBottomMenu1.SetBadgetValue1(20)";
Debug.ShouldStop(268435456);
main._asbottommenu1.runClassMethod (b4j.example.asbottommenu.class, "_setbadgetvalue1",(Object)(BA.numberCast(int.class, 20)));
 BA.debugLineNum = 31;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbottommenu1_page1click() throws Exception{
try {
		Debug.PushSubsStack("ASBottomMenu1_Page1Click (main) ","main",0,main.ba,main.mostCurrent,38);
if (RapidSub.canDelegate("asbottommenu1_page1click")) { return b4j.example.main.remoteMe.runUserSub(false, "main","asbottommenu1_page1click");}
 BA.debugLineNum = 38;BA.debugLine="Sub ASBottomMenu1_Page1Click";
Debug.ShouldStop(32);
 BA.debugLineNum = 39;BA.debugLine="Log(\"Clicked Page1\")";
Debug.ShouldStop(64);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Clicked Page1")));
 BA.debugLineNum = 40;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbottommenu1_page2click() throws Exception{
try {
		Debug.PushSubsStack("ASBottomMenu1_Page2Click (main) ","main",0,main.ba,main.mostCurrent,42);
if (RapidSub.canDelegate("asbottommenu1_page2click")) { return b4j.example.main.remoteMe.runUserSub(false, "main","asbottommenu1_page2click");}
 BA.debugLineNum = 42;BA.debugLine="Sub ASBottomMenu1_Page2Click";
Debug.ShouldStop(512);
 BA.debugLineNum = 43;BA.debugLine="Log(\"Clicked Page2\")";
Debug.ShouldStop(1024);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Clicked Page2")));
 BA.debugLineNum = 44;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbottommenu1_page3click() throws Exception{
try {
		Debug.PushSubsStack("ASBottomMenu1_Page3Click (main) ","main",0,main.ba,main.mostCurrent,46);
if (RapidSub.canDelegate("asbottommenu1_page3click")) { return b4j.example.main.remoteMe.runUserSub(false, "main","asbottommenu1_page3click");}
 BA.debugLineNum = 46;BA.debugLine="Sub ASBottomMenu1_Page3Click";
Debug.ShouldStop(8192);
 BA.debugLineNum = 47;BA.debugLine="Log(\"Clicked Page3\")";
Debug.ShouldStop(16384);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Clicked Page3")));
 BA.debugLineNum = 48;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbottommenu1_page4click() throws Exception{
try {
		Debug.PushSubsStack("ASBottomMenu1_Page4Click (main) ","main",0,main.ba,main.mostCurrent,50);
if (RapidSub.canDelegate("asbottommenu1_page4click")) { return b4j.example.main.remoteMe.runUserSub(false, "main","asbottommenu1_page4click");}
 BA.debugLineNum = 50;BA.debugLine="Sub ASBottomMenu1_Page4Click";
Debug.ShouldStop(131072);
 BA.debugLineNum = 51;BA.debugLine="Log(\"Clicked Page4\")";
Debug.ShouldStop(262144);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Clicked Page4")));
 BA.debugLineNum = 52;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
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
asbottommenu.myClass = BA.getDeviceClass ("b4j.example.asbottommenu");
bitmapcreator.myClass = BA.getDeviceClass ("b4j.example.bitmapcreator");
		
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
 //BA.debugLineNum = 10;BA.debugLine="Private ASBottomMenu1 As ASBottomMenu";
main._asbottommenu1 = RemoteObject.createNew ("b4j.example.asbottommenu");
 //BA.debugLineNum = 11;BA.debugLine="Private xui As XUI";
main._xui = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper.XUI");
 //BA.debugLineNum = 12;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}