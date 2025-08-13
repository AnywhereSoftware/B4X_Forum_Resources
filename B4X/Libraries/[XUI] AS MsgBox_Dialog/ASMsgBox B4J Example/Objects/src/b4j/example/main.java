package b4j.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.debug.*;

public class main extends javafx.application.Application{
public static main mostCurrent = new main();

public static BA ba;
static {
		ba = new  anywheresoftware.b4a.ShellBA("b4j.example", "b4j.example.main", null);
		ba.loadHtSubs(main.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			anywheresoftware.b4a.ShellBA.delegateBA = new anywheresoftware.b4j.objects.FxBA("b4j.example", null, null);
			ba.raiseEvent2(null, true, "SHELL", false);
			ba.raiseEvent2(null, true, "CREATE", true, "b4j.example.main", ba);
		}
	}
    public static Class<?> getObject() {
		return main.class;
	}

 
    public static void main(String[] args) {
    	launch(args);
    }
    public void start (javafx.stage.Stage stage) {
        try {
            if (!false)
                System.setProperty("prism.lcdtext", "false");
            anywheresoftware.b4j.objects.FxBA.application = this;
		    anywheresoftware.b4a.keywords.Common.setDensity(javafx.stage.Screen.getPrimary().getDpi());
            anywheresoftware.b4a.keywords.Common.LogDebug("Program started.");
            initializeProcessGlobals();
            anywheresoftware.b4j.objects.Form frm = new anywheresoftware.b4j.objects.Form();
            frm.initWithStage(ba, stage, 600, 600);
            ba.raiseEvent(null, "appstart", frm, (String[])getParameters().getRaw().toArray(new String[0]));
        } catch (Throwable t) {
            BA.printException(t, true);
            System.exit(1);
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
public static anywheresoftware.b4j.objects.JFX _fx = null;
public static anywheresoftware.b4j.objects.Form _mainform = null;
public static anywheresoftware.b4j.objects.B4XViewWrapper.XUI _xui = null;
public static boolean  _application_error(anywheresoftware.b4a.objects.B4AException _error,String _stacktrace) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "application_error"))
	 {return ((Boolean) Debug.delegate(ba, "application_error", new Object[] {_error,_stacktrace}));}
RDebugUtils.currentLine=131072;
 //BA.debugLineNum = 131072;BA.debugLine="Sub Application_Error (Error As Exception, StackTr";
RDebugUtils.currentLine=131073;
 //BA.debugLineNum = 131073;BA.debugLine="Return True";
if (true) return anywheresoftware.b4a.keywords.Common.True;
RDebugUtils.currentLine=131074;
 //BA.debugLineNum = 131074;BA.debugLine="End Sub";
return false;
}
public static String  _appstart(anywheresoftware.b4j.objects.Form _form1,String[] _args) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "appstart"))
	 {return ((String) Debug.delegate(ba, "appstart", new Object[] {_form1,_args}));}
RDebugUtils.currentLine=65536;
 //BA.debugLineNum = 65536;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
RDebugUtils.currentLine=65537;
 //BA.debugLineNum = 65537;BA.debugLine="MainForm = Form1";
_mainform = _form1;
RDebugUtils.currentLine=65538;
 //BA.debugLineNum = 65538;BA.debugLine="MainForm.RootPane.LoadLayout(\"frm_main\") 'Load th";
_mainform.getRootPane().LoadLayout(ba,"frm_main");
RDebugUtils.currentLine=65539;
 //BA.debugLineNum = 65539;BA.debugLine="MainForm.Show";
_mainform.Show();
RDebugUtils.currentLine=65540;
 //BA.debugLineNum = 65540;BA.debugLine="End Sub";
return "";
}
public static void  _lbl_show_msg_mouseclicked(anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "lbl_show_msg_mouseclicked"))
	 {Debug.delegate(ba, "lbl_show_msg_mouseclicked", new Object[] {_eventdata}); return;}
ResumableSub_lbl_show_msg_MouseClicked rsub = new ResumableSub_lbl_show_msg_MouseClicked(null,_eventdata);
rsub.resume(ba, null);
}
public static class ResumableSub_lbl_show_msg_MouseClicked extends BA.ResumableSub {
public ResumableSub_lbl_show_msg_MouseClicked(b4j.example.main parent,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) {
this.parent = parent;
this._eventdata = _eventdata;
}
b4j.example.main parent;
anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata;
b4j.example.asmsgbox _asmsgbox1 = null;
int _res = 0;
boolean _closed = false;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="main";

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
RDebugUtils.currentLine=262146;
 //BA.debugLineNum = 262146;BA.debugLine="Private ASMsgBox1 As ASMsgBox";
_asmsgbox1 = new b4j.example.asmsgbox();
RDebugUtils.currentLine=262148;
 //BA.debugLineNum = 262148;BA.debugLine="ASMsgBox1.Initialize(Me,\"ASMsgBox1\")";
_asmsgbox1._initialize(null,ba,main.getObject(),"ASMsgBox1");
RDebugUtils.currentLine=262149;
 //BA.debugLineNum = 262149;BA.debugLine="ASMsgBox1.InitializeWithoutDesigner(MainForm.Root";
_asmsgbox1._initializewithoutdesigner(null,(anywheresoftware.b4j.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper(), (java.lang.Object)(parent._mainform.getRootPane().getObject())),(int) (0xff2f343a),anywheresoftware.b4a.keywords.Common.True,anywheresoftware.b4a.keywords.Common.True,anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=262150;
 //BA.debugLineNum = 262150;BA.debugLine="ASMsgBox1.InitializeBottom(\"Button1\",\"Button2\",\"B";
_asmsgbox1._initializebottom(null,"Button1","Button2","Button3");
RDebugUtils.currentLine=262152;
 //BA.debugLineNum = 262152;BA.debugLine="ASMsgBox1.EnableDrag = ASMsgBox1.DragableTop";
_asmsgbox1._setenabledrag(null,_asmsgbox1._getdragabletop(null));
RDebugUtils.currentLine=262153;
 //BA.debugLineNum = 262153;BA.debugLine="ASMsgBox1.icon_set_icon(xui.LoadBitmap(File.DirAs";
_asmsgbox1._icon_set_icon(null,parent._xui.LoadBitmap(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"b4x.png"));
RDebugUtils.currentLine=262154;
 //BA.debugLineNum = 262154;BA.debugLine="ASMsgBox1.CenterDialog(MainForm.RootPane)";
_asmsgbox1._centerdialog(null,(anywheresoftware.b4j.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper(), (java.lang.Object)(parent._mainform.getRootPane().getObject())));
RDebugUtils.currentLine=262155;
 //BA.debugLineNum = 262155;BA.debugLine="ASMsgBox1.CloseButtonVisible = True";
_asmsgbox1._setclosebuttonvisible(null,anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=262156;
 //BA.debugLineNum = 262156;BA.debugLine="ASMsgBox1.ShowWithText(\"Hello B4X!\",True)";
_asmsgbox1._showwithtext(null,"Hello B4X!",anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=262159;
 //BA.debugLineNum = 262159;BA.debugLine="Wait For ASMsgBox1_result(res As Int)";
anywheresoftware.b4a.keywords.Common.WaitFor("asmsgbox1_result", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "main", "lbl_show_msg_mouseclicked"), null);
this.state = 5;
return;
case 5:
//C
this.state = 1;
_res = (int) result[0];
;
RDebugUtils.currentLine=262162;
 //BA.debugLineNum = 262162;BA.debugLine="If res = ASMsgBox1.POSITIVE  Then";
if (true) break;

case 1:
//if
this.state = 4;
if (_res==_asmsgbox1._getpositive(null)) { 
this.state = 3;
}if (true) break;

case 3:
//C
this.state = 4;
RDebugUtils.currentLine=262164;
 //BA.debugLineNum = 262164;BA.debugLine="Log(\"Postive\")";
anywheresoftware.b4a.keywords.Common.Log("Postive");
 if (true) break;

case 4:
//C
this.state = -1;
;
RDebugUtils.currentLine=262168;
 //BA.debugLineNum = 262168;BA.debugLine="Wait For (ASMsgBox1.Close(True)) Complete (Closed";
anywheresoftware.b4a.keywords.Common.WaitFor("complete", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "main", "lbl_show_msg_mouseclicked"), _asmsgbox1._close(null,anywheresoftware.b4a.keywords.Common.True));
this.state = 6;
return;
case 6:
//C
this.state = -1;
_closed = (boolean) result[0];
;
RDebugUtils.currentLine=262170;
 //BA.debugLineNum = 262170;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
}