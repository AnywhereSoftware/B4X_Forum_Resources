package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _appstart(RemoteObject _form1,RemoteObject _args) throws Exception{
try {
		Debug.PushSubsStack("AppStart (main) ","main",0,main.ba,main.mostCurrent,13);
if (RapidSub.canDelegate("appstart")) { return b4j.example.main.remoteMe.runUserSub(false, "main","appstart", _form1, _args);}
Debug.locals.put("Form1", _form1);
Debug.locals.put("Args", _args);
 BA.debugLineNum = 13;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
Debug.ShouldStop(4096);
 BA.debugLineNum = 14;BA.debugLine="MainForm = Form1";
Debug.ShouldStop(8192);
main._mainform = _form1;
 BA.debugLineNum = 15;BA.debugLine="MainForm.RootPane.LoadLayout(\"Layout1\")";
Debug.ShouldStop(16384);
main._mainform.runMethod(false,"getRootPane").runMethodAndSync(false,"LoadLayout",main.ba,(Object)(RemoteObject.createImmutable("Layout1")));
 BA.debugLineNum = 16;BA.debugLine="MainForm.Show";
Debug.ShouldStop(32768);
main._mainform.runVoidMethodAndSync ("Show");
 BA.debugLineNum = 17;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
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
		Debug.PushSubsStack("Button1_Click (main) ","main",0,main.ba,main.mostCurrent,19);
if (RapidSub.canDelegate("button1_click")) { return b4j.example.main.remoteMe.runUserSub(false, "main","button1_click");}
RemoteObject _picker = RemoteObject.declareNull("b4j.example.shamsidatepickerv3");
RemoteObject _ticks = RemoteObject.createImmutable(0L);
 BA.debugLineNum = 19;BA.debugLine="Sub Button1_Click";
Debug.ShouldStop(262144);
 BA.debugLineNum = 21;BA.debugLine="Dim picker As ShamsiDatePickerV3";
Debug.ShouldStop(1048576);
_picker = RemoteObject.createNew ("b4j.example.shamsidatepickerv3");Debug.locals.put("picker", _picker);
 BA.debugLineNum = 22;BA.debugLine="picker.Initialize";
Debug.ShouldStop(2097152);
_picker.runClassMethod (b4j.example.shamsidatepickerv3.class, "_initialize" /*RemoteObject*/ ,main.ba);
 BA.debugLineNum = 27;BA.debugLine="If picker.Show(MainForm) Then";
Debug.ShouldStop(67108864);
if (_picker.runClassMethod (b4j.example.shamsidatepickerv3.class, "_show" /*RemoteObject*/ ,(Object)(main._mainform)).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 29;BA.debugLine="Dim ticks As Long = picker.GetSelectedTicks";
Debug.ShouldStop(268435456);
_ticks = _picker.runClassMethod (b4j.example.shamsidatepickerv3.class, "_getselectedticks" /*RemoteObject*/ );Debug.locals.put("ticks", _ticks);Debug.locals.put("ticks", _ticks);
 BA.debugLineNum = 31;BA.debugLine="DateTime.DateFormat = \"yyyy/MM/dd HH:mm:ss\"";
Debug.ShouldStop(1073741824);
main.__c.getField(false,"DateTime").runMethod(true,"setDateFormat",BA.ObjectToString("yyyy/MM/dd HH:mm:ss"));
 BA.debugLineNum = 32;BA.debugLine="Log(\"تاریخ شمسی : \" & picker.GetSelectedDateStri";
Debug.ShouldStop(-2147483648);
main.__c.runVoidMethod ("LogImpl","2131085",RemoteObject.concat(RemoteObject.createImmutable("تاریخ شمسی : "),_picker.runClassMethod (b4j.example.shamsidatepickerv3.class, "_getselecteddatestring" /*RemoteObject*/ )),0);
 BA.debugLineNum = 33;BA.debugLine="Log(\"Tick        : \" & ticks)";
Debug.ShouldStop(1);
main.__c.runVoidMethod ("LogImpl","2131086",RemoteObject.concat(RemoteObject.createImmutable("Tick        : "),_ticks),0);
 BA.debugLineNum = 34;BA.debugLine="Log(\"میلادی      : \" & DateTime.Date(ticks))";
Debug.ShouldStop(2);
main.__c.runVoidMethod ("LogImpl","2131087",RemoteObject.concat(RemoteObject.createImmutable("میلادی      : "),main.__c.getField(false,"DateTime").runMethod(true,"Date",(Object)(_ticks))),0);
 BA.debugLineNum = 35;BA.debugLine="Log(\"بدون زمان   : \" & DateTime.Date(picker.GetS";
Debug.ShouldStop(4);
main.__c.runVoidMethod ("LogImpl","2131088",RemoteObject.concat(RemoteObject.createImmutable("بدون زمان   : "),main.__c.getField(false,"DateTime").runMethod(true,"Date",(Object)(_picker.runClassMethod (b4j.example.shamsidatepickerv3.class, "_getselectedticksnotime" /*RemoteObject*/ )))),0);
 BA.debugLineNum = 36;BA.debugLine="Log(\"برگشت شمسی  : \" & picker.TicksToShamsiStrin";
Debug.ShouldStop(8);
main.__c.runVoidMethod ("LogImpl","2131089",RemoteObject.concat(RemoteObject.createImmutable("برگشت شمسی  : "),_picker.runClassMethod (b4j.example.shamsidatepickerv3.class, "_tickstoshamsistring" /*RemoteObject*/ ,(Object)(_ticks))),0);
 }else {
 BA.debugLineNum = 39;BA.debugLine="Log(\"بدون انتخاب\")";
Debug.ShouldStop(64);
main.__c.runVoidMethod ("LogImpl","2131092",RemoteObject.createImmutable("بدون انتخاب"),0);
 };
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

private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main_subs_0._process_globals();
main.myClass = BA.getDeviceClass ("b4j.example.main");
shamsidatepickerv3.myClass = BA.getDeviceClass ("b4j.example.shamsidatepickerv3");
		
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
 //BA.debugLineNum = 9;BA.debugLine="Private xui As XUI";
main._xui = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");
 //BA.debugLineNum = 10;BA.debugLine="Private Button1 As B4XView";
main._button1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");
 //BA.debugLineNum = 11;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}