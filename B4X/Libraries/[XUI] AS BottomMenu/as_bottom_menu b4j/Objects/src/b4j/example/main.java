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
public static b4j.example.asbottommenu _asbottommenu1 = null;
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
RDebugUtils.currentLine=65541;
 //BA.debugLineNum = 65541;BA.debugLine="ASBottomMenu1.SetIcon1(xui.LoadBitmap(File.DirAss";
_asbottommenu1._seticon1(null,_xui.LoadBitmap(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"home2.png"));
RDebugUtils.currentLine=65542;
 //BA.debugLineNum = 65542;BA.debugLine="ASBottomMenu1.SetIcon2(xui.LoadBitmap(File.DirAss";
_asbottommenu1._seticon2(null,_xui.LoadBitmap(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"chat.png"));
RDebugUtils.currentLine=65543;
 //BA.debugLineNum = 65543;BA.debugLine="ASBottomMenu1.SetIcon3(xui.loadBitmap(File.DirAss";
_asbottommenu1._seticon3(null,_xui.LoadBitmap(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"group.png"));
RDebugUtils.currentLine=65544;
 //BA.debugLineNum = 65544;BA.debugLine="ASBottomMenu1.SetIcon4(xui.LoadBitmap(File.DirAss";
_asbottommenu1._seticon4(null,_xui.LoadBitmap(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"settings.png"));
RDebugUtils.currentLine=65546;
 //BA.debugLineNum = 65546;BA.debugLine="ASBottomMenu1.EnableBadget1(True)";
_asbottommenu1._enablebadget1(null,anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=65547;
 //BA.debugLineNum = 65547;BA.debugLine="ASBottomMenu1.EnableBadget2(True)";
_asbottommenu1._enablebadget2(null,anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=65548;
 //BA.debugLineNum = 65548;BA.debugLine="ASBottomMenu1.EnableBadget3(True)";
_asbottommenu1._enablebadget3(null,anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=65549;
 //BA.debugLineNum = 65549;BA.debugLine="ASBottomMenu1.EnableBadget4(True)";
_asbottommenu1._enablebadget4(null,anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=65551;
 //BA.debugLineNum = 65551;BA.debugLine="ASBottomMenu1.SetBadgetValue1(20)";
_asbottommenu1._setbadgetvalue1(null,(int) (20));
RDebugUtils.currentLine=65553;
 //BA.debugLineNum = 65553;BA.debugLine="End Sub";
return "";
}
public static String  _asbottommenu1_page1click() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "asbottommenu1_page1click"))
	 {return ((String) Debug.delegate(ba, "asbottommenu1_page1click", null));}
RDebugUtils.currentLine=4980736;
 //BA.debugLineNum = 4980736;BA.debugLine="Sub ASBottomMenu1_Page1Click";
RDebugUtils.currentLine=4980737;
 //BA.debugLineNum = 4980737;BA.debugLine="Log(\"Clicked Page1\")";
anywheresoftware.b4a.keywords.Common.Log("Clicked Page1");
RDebugUtils.currentLine=4980738;
 //BA.debugLineNum = 4980738;BA.debugLine="End Sub";
return "";
}
public static String  _asbottommenu1_page2click() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "asbottommenu1_page2click"))
	 {return ((String) Debug.delegate(ba, "asbottommenu1_page2click", null));}
RDebugUtils.currentLine=5046272;
 //BA.debugLineNum = 5046272;BA.debugLine="Sub ASBottomMenu1_Page2Click";
RDebugUtils.currentLine=5046273;
 //BA.debugLineNum = 5046273;BA.debugLine="Log(\"Clicked Page2\")";
anywheresoftware.b4a.keywords.Common.Log("Clicked Page2");
RDebugUtils.currentLine=5046274;
 //BA.debugLineNum = 5046274;BA.debugLine="End Sub";
return "";
}
public static String  _asbottommenu1_page3click() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "asbottommenu1_page3click"))
	 {return ((String) Debug.delegate(ba, "asbottommenu1_page3click", null));}
RDebugUtils.currentLine=5111808;
 //BA.debugLineNum = 5111808;BA.debugLine="Sub ASBottomMenu1_Page3Click";
RDebugUtils.currentLine=5111809;
 //BA.debugLineNum = 5111809;BA.debugLine="Log(\"Clicked Page3\")";
anywheresoftware.b4a.keywords.Common.Log("Clicked Page3");
RDebugUtils.currentLine=5111810;
 //BA.debugLineNum = 5111810;BA.debugLine="End Sub";
return "";
}
public static String  _asbottommenu1_page4click() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "asbottommenu1_page4click"))
	 {return ((String) Debug.delegate(ba, "asbottommenu1_page4click", null));}
RDebugUtils.currentLine=5177344;
 //BA.debugLineNum = 5177344;BA.debugLine="Sub ASBottomMenu1_Page4Click";
RDebugUtils.currentLine=5177345;
 //BA.debugLineNum = 5177345;BA.debugLine="Log(\"Clicked Page4\")";
anywheresoftware.b4a.keywords.Common.Log("Clicked Page4");
RDebugUtils.currentLine=5177346;
 //BA.debugLineNum = 5177346;BA.debugLine="End Sub";
return "";
}
}