package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;

public class main extends javafx.application.Application{
public static main mostCurrent = new main();

public static BA ba;
static {
		ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.main", null);
		ba.loadHtSubs(main.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			anywheresoftware.b4a.shell.ShellBA.delegateBA = new anywheresoftware.b4j.objects.FxBA("b4j.example", null, null);
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
public static anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public static anywheresoftware.b4a.objects.B4XViewWrapper _button1 = null;
public static String  _appstart(anywheresoftware.b4j.objects.Form _form1,String[] _args) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "appstart", false))
	 {return ((String) Debug.delegate(ba, "appstart", new Object[] {_form1,_args}));}
RDebugUtils.currentLine=65536;
 //BA.debugLineNum = 65536;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
RDebugUtils.currentLine=65537;
 //BA.debugLineNum = 65537;BA.debugLine="MainForm = Form1";
_mainform = _form1;
RDebugUtils.currentLine=65538;
 //BA.debugLineNum = 65538;BA.debugLine="MainForm.RootPane.LoadLayout(\"Layout1\")";
_mainform.getRootPane().LoadLayout(ba,"Layout1");
RDebugUtils.currentLine=65539;
 //BA.debugLineNum = 65539;BA.debugLine="MainForm.Show";
_mainform.Show();
RDebugUtils.currentLine=65540;
 //BA.debugLineNum = 65540;BA.debugLine="End Sub";
return "";
}
public static String  _button1_click() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "button1_click", false))
	 {return ((String) Debug.delegate(ba, "button1_click", null));}
b4j.example.shamsidatepickerv3 _picker = null;
long _ticks = 0L;
RDebugUtils.currentLine=131072;
 //BA.debugLineNum = 131072;BA.debugLine="Sub Button1_Click";
RDebugUtils.currentLine=131074;
 //BA.debugLineNum = 131074;BA.debugLine="Dim picker As ShamsiDatePickerV3";
_picker = new b4j.example.shamsidatepickerv3();
RDebugUtils.currentLine=131075;
 //BA.debugLineNum = 131075;BA.debugLine="picker.Initialize";
_picker._initialize /*String*/ (null,ba);
RDebugUtils.currentLine=131080;
 //BA.debugLineNum = 131080;BA.debugLine="If picker.Show(MainForm) Then";
if (_picker._show /*boolean*/ (null,_mainform)) { 
RDebugUtils.currentLine=131082;
 //BA.debugLineNum = 131082;BA.debugLine="Dim ticks As Long = picker.GetSelectedTicks";
_ticks = _picker._getselectedticks /*long*/ (null);
RDebugUtils.currentLine=131084;
 //BA.debugLineNum = 131084;BA.debugLine="DateTime.DateFormat = \"yyyy/MM/dd HH:mm:ss\"";
anywheresoftware.b4a.keywords.Common.DateTime.setDateFormat("yyyy/MM/dd HH:mm:ss");
RDebugUtils.currentLine=131085;
 //BA.debugLineNum = 131085;BA.debugLine="Log(\"تاریخ شمسی : \" & picker.GetSelectedDateStri";
anywheresoftware.b4a.keywords.Common.LogImpl("2131085","تاریخ شمسی : "+_picker._getselecteddatestring /*String*/ (null),0);
RDebugUtils.currentLine=131086;
 //BA.debugLineNum = 131086;BA.debugLine="Log(\"Tick        : \" & ticks)";
anywheresoftware.b4a.keywords.Common.LogImpl("2131086","Tick        : "+BA.NumberToString(_ticks),0);
RDebugUtils.currentLine=131087;
 //BA.debugLineNum = 131087;BA.debugLine="Log(\"میلادی      : \" & DateTime.Date(ticks))";
anywheresoftware.b4a.keywords.Common.LogImpl("2131087","میلادی      : "+anywheresoftware.b4a.keywords.Common.DateTime.Date(_ticks),0);
RDebugUtils.currentLine=131088;
 //BA.debugLineNum = 131088;BA.debugLine="Log(\"بدون زمان   : \" & DateTime.Date(picker.GetS";
anywheresoftware.b4a.keywords.Common.LogImpl("2131088","بدون زمان   : "+anywheresoftware.b4a.keywords.Common.DateTime.Date(_picker._getselectedticksnotime /*long*/ (null)),0);
RDebugUtils.currentLine=131089;
 //BA.debugLineNum = 131089;BA.debugLine="Log(\"برگشت شمسی  : \" & picker.TicksToShamsiStrin";
anywheresoftware.b4a.keywords.Common.LogImpl("2131089","برگشت شمسی  : "+_picker._tickstoshamsistring /*String*/ (null,_ticks),0);
 }else {
RDebugUtils.currentLine=131092;
 //BA.debugLineNum = 131092;BA.debugLine="Log(\"بدون انتخاب\")";
anywheresoftware.b4a.keywords.Common.LogImpl("2131092","بدون انتخاب",0);
 };
RDebugUtils.currentLine=131096;
 //BA.debugLineNum = 131096;BA.debugLine="End Sub";
return "";
}
}