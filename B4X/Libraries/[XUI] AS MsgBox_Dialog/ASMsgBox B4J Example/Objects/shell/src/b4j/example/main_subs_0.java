package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _application_error(RemoteObject _error,RemoteObject _stacktrace) throws Exception{
try {
		Debug.PushSubsStack("Application_Error (main) ","main",0,main.ba,main.mostCurrent,19);
if (RapidSub.canDelegate("application_error")) { return b4j.example.main.remoteMe.runUserSub(false, "main","application_error", _error, _stacktrace);}
Debug.locals.put("Error", _error);
Debug.locals.put("StackTrace", _stacktrace);
 BA.debugLineNum = 19;BA.debugLine="Sub Application_Error (Error As Exception, StackTr";
Debug.ShouldStop(262144);
 BA.debugLineNum = 20;BA.debugLine="Return True";
Debug.ShouldStop(524288);
if (true) return main.__c.getField(true,"True");
 BA.debugLineNum = 21;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
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
		Debug.PushSubsStack("AppStart (main) ","main",0,main.ba,main.mostCurrent,12);
if (RapidSub.canDelegate("appstart")) { return b4j.example.main.remoteMe.runUserSub(false, "main","appstart", _form1, _args);}
Debug.locals.put("Form1", _form1);
Debug.locals.put("Args", _args);
 BA.debugLineNum = 12;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
Debug.ShouldStop(2048);
 BA.debugLineNum = 13;BA.debugLine="MainForm = Form1";
Debug.ShouldStop(4096);
main._mainform = _form1;
 BA.debugLineNum = 14;BA.debugLine="MainForm.RootPane.LoadLayout(\"frm_main\") 'Load th";
Debug.ShouldStop(8192);
main._mainform.runMethod(false,"getRootPane").runMethodAndSync(false,"LoadLayout",main.ba,(Object)(RemoteObject.createImmutable("frm_main")));
 BA.debugLineNum = 15;BA.debugLine="MainForm.Show";
Debug.ShouldStop(16384);
main._mainform.runVoidMethodAndSync ("Show");
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
public static void  _lbl_show_msg_mouseclicked(RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("lbl_show_msg_MouseClicked (main) ","main",0,main.ba,main.mostCurrent,23);
if (RapidSub.canDelegate("lbl_show_msg_mouseclicked")) { b4j.example.main.remoteMe.runUserSub(false, "main","lbl_show_msg_mouseclicked", _eventdata); return;}
ResumableSub_lbl_show_msg_MouseClicked rsub = new ResumableSub_lbl_show_msg_MouseClicked(null,_eventdata);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_lbl_show_msg_MouseClicked extends BA.ResumableSub {
public ResumableSub_lbl_show_msg_MouseClicked(b4j.example.main parent,RemoteObject _eventdata) {
this.parent = parent;
this._eventdata = _eventdata;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
b4j.example.main parent;
RemoteObject _eventdata;
RemoteObject _asmsgbox1 = RemoteObject.declareNull("b4j.example.asmsgbox");
RemoteObject _res = RemoteObject.createImmutable(0);
RemoteObject _closed = RemoteObject.createImmutable(false);

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("lbl_show_msg_MouseClicked (main) ","main",0,main.ba,main.mostCurrent,23);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 25;BA.debugLine="Private ASMsgBox1 As ASMsgBox";
Debug.ShouldStop(16777216);
_asmsgbox1 = RemoteObject.createNew ("b4j.example.asmsgbox");Debug.locals.put("ASMsgBox1", _asmsgbox1);
 BA.debugLineNum = 27;BA.debugLine="ASMsgBox1.Initialize(Me,\"ASMsgBox1\")";
Debug.ShouldStop(67108864);
_asmsgbox1.runClassMethod (b4j.example.asmsgbox.class, "_initialize",main.ba,(Object)(main.getObject()),(Object)(RemoteObject.createImmutable("ASMsgBox1")));
 BA.debugLineNum = 28;BA.debugLine="ASMsgBox1.InitializeWithoutDesigner(MainForm.Root";
Debug.ShouldStop(134217728);
_asmsgbox1.runClassMethod (b4j.example.asmsgbox.class, "_initializewithoutdesigner",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper"), parent._mainform.runMethod(false,"getRootPane").getObject()),(Object)(BA.numberCast(int.class, 0xff2f343a)),(Object)(parent.__c.getField(true,"True")),(Object)(parent.__c.getField(true,"True")),(Object)(parent.__c.getField(true,"False")));
 BA.debugLineNum = 29;BA.debugLine="ASMsgBox1.InitializeBottom(\"Button1\",\"Button2\",\"B";
Debug.ShouldStop(268435456);
_asmsgbox1.runClassMethod (b4j.example.asmsgbox.class, "_initializebottom",(Object)(BA.ObjectToString("Button1")),(Object)(BA.ObjectToString("Button2")),(Object)(RemoteObject.createImmutable("Button3")));
 BA.debugLineNum = 31;BA.debugLine="ASMsgBox1.EnableDrag = ASMsgBox1.DragableTop";
Debug.ShouldStop(1073741824);
_asmsgbox1.runClassMethod (b4j.example.asmsgbox.class, "_setenabledrag",_asmsgbox1.runClassMethod (b4j.example.asmsgbox.class, "_getdragabletop"));
 BA.debugLineNum = 32;BA.debugLine="ASMsgBox1.icon_set_icon(xui.LoadBitmap(File.DirAs";
Debug.ShouldStop(-2147483648);
_asmsgbox1.runClassMethod (b4j.example.asmsgbox.class, "_icon_set_icon",(Object)(parent._xui.runMethod(false,"LoadBitmap",(Object)(parent.__c.getField(false,"File").runMethod(true,"getDirAssets")),(Object)(RemoteObject.createImmutable("b4x.png")))));
 BA.debugLineNum = 33;BA.debugLine="ASMsgBox1.CenterDialog(MainForm.RootPane)";
Debug.ShouldStop(1);
_asmsgbox1.runClassMethod (b4j.example.asmsgbox.class, "_centerdialog",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper"), parent._mainform.runMethod(false,"getRootPane").getObject()));
 BA.debugLineNum = 34;BA.debugLine="ASMsgBox1.CloseButtonVisible = True";
Debug.ShouldStop(2);
_asmsgbox1.runClassMethod (b4j.example.asmsgbox.class, "_setclosebuttonvisible",parent.__c.getField(true,"True"));
 BA.debugLineNum = 35;BA.debugLine="ASMsgBox1.ShowWithText(\"Hello B4X!\",True)";
Debug.ShouldStop(4);
_asmsgbox1.runClassMethod (b4j.example.asmsgbox.class, "_showwithtext",(Object)(BA.ObjectToString("Hello B4X!")),(Object)(parent.__c.getField(true,"True")));
 BA.debugLineNum = 38;BA.debugLine="Wait For ASMsgBox1_result(res As Int)";
Debug.ShouldStop(32);
parent.__c.runVoidMethod ("WaitFor","asmsgbox1_result", main.ba, anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this), null);
this.state = 5;
return;
case 5:
//C
this.state = 1;
_res = (RemoteObject) result.getArrayElement(true,RemoteObject.createImmutable(0));Debug.locals.put("res", _res);
;
 BA.debugLineNum = 41;BA.debugLine="If res = ASMsgBox1.POSITIVE  Then";
Debug.ShouldStop(256);
if (true) break;

case 1:
//if
this.state = 4;
if (RemoteObject.solveBoolean("=",_res,BA.numberCast(double.class, _asmsgbox1.runClassMethod (b4j.example.asmsgbox.class, "_getpositive")))) { 
this.state = 3;
}if (true) break;

case 3:
//C
this.state = 4;
 BA.debugLineNum = 43;BA.debugLine="Log(\"Postive\")";
Debug.ShouldStop(1024);
parent.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Postive")));
 if (true) break;

case 4:
//C
this.state = -1;
;
 BA.debugLineNum = 47;BA.debugLine="Wait For (ASMsgBox1.Close(True)) Complete (Closed";
Debug.ShouldStop(16384);
parent.__c.runVoidMethod ("WaitFor","complete", main.ba, anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this), _asmsgbox1.runClassMethod (b4j.example.asmsgbox.class, "_close",(Object)(parent.__c.getField(true,"True"))));
this.state = 6;
return;
case 6:
//C
this.state = -1;
_closed = (RemoteObject) result.getArrayElement(true,RemoteObject.createImmutable(0));Debug.locals.put("Closed", _closed);
;
 BA.debugLineNum = 49;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
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
public static void  _asmsgbox1_result(RemoteObject _res) throws Exception{
}
public static void  _complete(RemoteObject _closed) throws Exception{
}

private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main_subs_0._process_globals();
main.myClass = BA.getDeviceClass ("b4j.example.main");
asmsgbox.myClass = BA.getDeviceClass ("b4j.example.asmsgbox");
		
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
 //BA.debugLineNum = 9;BA.debugLine="Dim xui As XUI";
main._xui = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper.XUI");
 //BA.debugLineNum = 10;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}