package b4j.example;


import anywheresoftware.b4a.BA;

public class main extends javafx.application.Application{
public static main mostCurrent = new main();

public static BA ba;
static {
		ba = new  anywheresoftware.b4j.objects.FxBA("b4j.example", "b4j.example.main", null);
		ba.loadHtSubs(main.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			
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
public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4j.objects.JFX _fx = null;
public static anywheresoftware.b4j.objects.Form _mainform = null;
public static anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public static anywheresoftware.b4a.objects.B4XViewWrapper _button1 = null;
public static String _mypassword = "";
public static anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _txtfieldmin = null;
public static anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _txtfieldmax = null;
public static b4j.example.b4xpassword _b4xpassword = null;
public static String  _appstart(anywheresoftware.b4j.objects.Form _form1,String[] _args) throws Exception{
 //BA.debugLineNum = 18;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
 //BA.debugLineNum = 19;BA.debugLine="MainForm = Form1";
_mainform = _form1;
 //BA.debugLineNum = 20;BA.debugLine="MainForm.RootPane.LoadLayout(\"Layout1\")";
_mainform.getRootPane().LoadLayout(ba,"Layout1");
 //BA.debugLineNum = 21;BA.debugLine="MainForm.Title = \"B4XPassword Generator by ThRuST";
_mainform.setTitle("B4XPassword Generator by ThRuST");
 //BA.debugLineNum = 22;BA.debugLine="MainForm.Show";
_mainform.Show();
 //BA.debugLineNum = 25;BA.debugLine="Dim MyPassword As String";
_mypassword = "";
 //BA.debugLineNum = 26;BA.debugLine="MyPassword = B4XPassword.Randomize_Password(3, 11";
_mypassword = _b4xpassword._randomize_password /*String*/ ((int) (3),(int) (11));
 //BA.debugLineNum = 28;BA.debugLine="End Sub";
return "";
}
public static String  _button1_click() throws Exception{
 //BA.debugLineNum = 30;BA.debugLine="Sub Button1_Click";
 //BA.debugLineNum = 32;BA.debugLine="Try";
try { //BA.debugLineNum = 34;BA.debugLine="MyPassword = B4XPassword.Randomize_Password(txtF";
_mypassword = _b4xpassword._randomize_password /*String*/ ((int)(Double.parseDouble(_txtfieldmin.getText())),(int)(Double.parseDouble(_txtfieldmax.getText())));
 //BA.debugLineNum = 36;BA.debugLine="Button1.Text = MyPassword";
_button1.setText(_mypassword);
 //BA.debugLineNum = 38;BA.debugLine="Log(MyPassword)";
anywheresoftware.b4a.keywords.Common.LogImpl("5131080",_mypassword,0);
 } 
       catch (Exception e6) {
			ba.setLastException(e6); //BA.debugLineNum = 41;BA.debugLine="Log(LastException.Message)";
anywheresoftware.b4a.keywords.Common.LogImpl("5131083",anywheresoftware.b4a.keywords.Common.LastException(ba).getMessage(),0);
 //BA.debugLineNum = 42;BA.debugLine="xui.MsgboxAsync(\"OOps! keep int values in range";
_xui.MsgboxAsync(ba,"OOps! keep int values in range!!","");
 };
 //BA.debugLineNum = 46;BA.debugLine="End Sub";
return "";
}

private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main._process_globals();
b4xpassword._process_globals();
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static String  _process_globals() throws Exception{
 //BA.debugLineNum = 6;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 7;BA.debugLine="Private fx As JFX";
_fx = new anywheresoftware.b4j.objects.JFX();
 //BA.debugLineNum = 8;BA.debugLine="Private MainForm As Form";
_mainform = new anywheresoftware.b4j.objects.Form();
 //BA.debugLineNum = 9;BA.debugLine="Private xui As XUI";
_xui = new anywheresoftware.b4a.objects.B4XViewWrapper.XUI();
 //BA.debugLineNum = 10;BA.debugLine="Private Button1 As B4XView";
_button1 = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 11;BA.debugLine="Private MyPassword As String";
_mypassword = "";
 //BA.debugLineNum = 13;BA.debugLine="Private txtFieldMin As TextField";
_txtfieldmin = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
 //BA.debugLineNum = 14;BA.debugLine="Private txtFieldMax As TextField";
_txtfieldmax = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
 //BA.debugLineNum = 16;BA.debugLine="End Sub";
return "";
}
}
