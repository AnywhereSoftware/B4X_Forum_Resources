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
            frm.initWithStage(ba, stage, 775, 640);
            ba.raiseEvent(null, "appstart", frm, (String[])getParameters().getRaw().toArray(new String[0]));
        } catch (Throwable t) {
            BA.printException(t, true);
            System.exit(1);
        }
    }
public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4j.objects.JFX _fx = null;
public static anywheresoftware.b4j.objects.Form _mainform = null;
public static anywheresoftware.b4j.objects.ButtonWrapper _button1 = null;
public static anywheresoftware.b4j.objects.ButtonWrapper _button2 = null;
public static anywheresoftware.b4j.objects.CheckboxWrapper _checkbox1 = null;
public static anywheresoftware.b4j.objects.ChoiceBoxWrapper _choicebox1 = null;
public static anywheresoftware.b4j.objects.LabelWrapper _label1 = null;
public static anywheresoftware.b4j.objects.ColorPickerWrapper _colorpicker1 = null;
public static anywheresoftware.b4j.objects.DatePickerWrapper _datepicker1 = null;
public static anywheresoftware.b4j.objects.ComboBoxWrapper _combobox1 = null;
public static anywheresoftware.b4j.objects.ListViewWrapper _listview1 = null;
public static anywheresoftware.b4j.objects.ProgressIndicatorWrapper.ProgressBarWrapper _progressbar1 = null;
public static anywheresoftware.b4j.objects.ProgressIndicatorWrapper _progressindicator1 = null;
public static anywheresoftware.b4j.objects.ButtonWrapper.RadioButtonWrapper _radiobutton1 = null;
public static anywheresoftware.b4j.objects.SliderWrapper _slider1 = null;
public static anywheresoftware.b4j.objects.SpinnerWrapper _spinner1 = null;
public static anywheresoftware.b4j.objects.TableViewWrapper _tableview1 = null;
public static anywheresoftware.b4j.objects.TextInputControlWrapper.TextAreaWrapper _textarea1 = null;
public static anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _textfield1 = null;
public static anywheresoftware.b4j.objects.ButtonWrapper.ToggleButtonWrapper _togglebutton1 = null;
public static anywheresoftware.b4j.objects.TreeViewWrapper _treeview1 = null;
public static b4j.example.metro _metro = null;
public static boolean  _application_error(anywheresoftware.b4a.objects.B4AException _error,String _stacktrace) throws Exception{
 //BA.debugLineNum = 52;BA.debugLine="Sub Application_Error (Error As Exception, StackTr";
 //BA.debugLineNum = 53;BA.debugLine="Return True";
if (true) return anywheresoftware.b4a.keywords.Common.True;
 //BA.debugLineNum = 54;BA.debugLine="End Sub";
return false;
}
public static String  _appstart(anywheresoftware.b4j.objects.Form _form1,String[] _args) throws Exception{
anywheresoftware.b4j.objects.TreeViewWrapper.ConcreteTreeItemWrapper _tti = null;
anywheresoftware.b4j.objects.TreeTableViewWrapper.TreeTableItemWrapper _tti2 = null;
int _i = 0;
 //BA.debugLineNum = 30;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
 //BA.debugLineNum = 31;BA.debugLine="MainForm = Form1";
_mainform = _form1;
 //BA.debugLineNum = 32;BA.debugLine="MainForm.RootPane.LoadLayout(\"main\") 'Load the la";
_mainform.getRootPane().LoadLayout(ba,"main");
 //BA.debugLineNum = 33;BA.debugLine="MainForm.Show";
_mainform.Show();
 //BA.debugLineNum = 35;BA.debugLine="Metro.ApplyTheme(MainForm,\"Dark\")";
_metro._applytheme /*String*/ (_mainform,"Dark");
 //BA.debugLineNum = 37;BA.debugLine="Dim tti As TreeItem";
_tti = new anywheresoftware.b4j.objects.TreeViewWrapper.ConcreteTreeItemWrapper();
 //BA.debugLineNum = 38;BA.debugLine="Dim tti2 As TreeTableItem";
_tti2 = new anywheresoftware.b4j.objects.TreeTableViewWrapper.TreeTableItemWrapper();
 //BA.debugLineNum = 39;BA.debugLine="tti2.Initialize(\"tt\", Array(\"Column 0 value\", \"Co";
_tti2.Initialize(ba,"tt",new Object[]{(Object)("Column 0 value"),(Object)("Column 1 value"),(Object)("Column 2 value")});
 //BA.debugLineNum = 41;BA.debugLine="For i = 0 To 10";
{
final int step8 = 1;
final int limit8 = (int) (10);
_i = (int) (0) ;
for (;_i <= limit8 ;_i = _i + step8 ) {
 //BA.debugLineNum = 42;BA.debugLine="ListView1.Items.Add(\"Item #\" & (i+1))";
_listview1.getItems().Add((Object)("Item #"+BA.NumberToString((_i+1))));
 //BA.debugLineNum = 43;BA.debugLine="ComboBox1.Items.Add(\"Item #\" & (i+1))";
_combobox1.getItems().Add((Object)("Item #"+BA.NumberToString((_i+1))));
 //BA.debugLineNum = 44;BA.debugLine="Spinner1.SetListItems(Array (\"Item #1\", \"Item #2";
_spinner1.SetListItems(anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)("Item #1"),(Object)("Item #2")}));
 //BA.debugLineNum = 45;BA.debugLine="ChoiceBox1.Items.Add(\"Item #\" & (i+1))";
_choicebox1.getItems().Add((Object)("Item #"+BA.NumberToString((_i+1))));
 //BA.debugLineNum = 46;BA.debugLine="tti.Initialize(\"tt\",\"Item #\" & (i+1))";
_tti.Initialize(ba,"tt","Item #"+BA.NumberToString((_i+1)));
 //BA.debugLineNum = 47;BA.debugLine="TreeView1.Root.Children.Add(tti)";
_treeview1.getRoot().getChildren().Add((Object)(_tti.getObject()));
 }
};
 //BA.debugLineNum = 49;BA.debugLine="End Sub";
return "";
}

private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main._process_globals();
metro._process_globals();
		
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
 //BA.debugLineNum = 9;BA.debugLine="Private Button1 As Button";
_button1 = new anywheresoftware.b4j.objects.ButtonWrapper();
 //BA.debugLineNum = 10;BA.debugLine="Private Button2 As Button";
_button2 = new anywheresoftware.b4j.objects.ButtonWrapper();
 //BA.debugLineNum = 11;BA.debugLine="Private CheckBox1 As CheckBox";
_checkbox1 = new anywheresoftware.b4j.objects.CheckboxWrapper();
 //BA.debugLineNum = 12;BA.debugLine="Private ChoiceBox1 As ChoiceBox";
_choicebox1 = new anywheresoftware.b4j.objects.ChoiceBoxWrapper();
 //BA.debugLineNum = 13;BA.debugLine="Private Label1 As Label";
_label1 = new anywheresoftware.b4j.objects.LabelWrapper();
 //BA.debugLineNum = 14;BA.debugLine="Private ColorPicker1 As ColorPicker";
_colorpicker1 = new anywheresoftware.b4j.objects.ColorPickerWrapper();
 //BA.debugLineNum = 15;BA.debugLine="Private DatePicker1 As DatePicker";
_datepicker1 = new anywheresoftware.b4j.objects.DatePickerWrapper();
 //BA.debugLineNum = 16;BA.debugLine="Private ComboBox1 As ComboBox";
_combobox1 = new anywheresoftware.b4j.objects.ComboBoxWrapper();
 //BA.debugLineNum = 17;BA.debugLine="Private ListView1 As ListView";
_listview1 = new anywheresoftware.b4j.objects.ListViewWrapper();
 //BA.debugLineNum = 18;BA.debugLine="Private ProgressBar1 As ProgressBar";
_progressbar1 = new anywheresoftware.b4j.objects.ProgressIndicatorWrapper.ProgressBarWrapper();
 //BA.debugLineNum = 19;BA.debugLine="Private ProgressIndicator1 As ProgressIndicator";
_progressindicator1 = new anywheresoftware.b4j.objects.ProgressIndicatorWrapper();
 //BA.debugLineNum = 20;BA.debugLine="Private RadioButton1 As RadioButton";
_radiobutton1 = new anywheresoftware.b4j.objects.ButtonWrapper.RadioButtonWrapper();
 //BA.debugLineNum = 21;BA.debugLine="Private Slider1 As Slider";
_slider1 = new anywheresoftware.b4j.objects.SliderWrapper();
 //BA.debugLineNum = 22;BA.debugLine="Private Spinner1 As Spinner";
_spinner1 = new anywheresoftware.b4j.objects.SpinnerWrapper();
 //BA.debugLineNum = 23;BA.debugLine="Private TableView1 As TableView";
_tableview1 = new anywheresoftware.b4j.objects.TableViewWrapper();
 //BA.debugLineNum = 24;BA.debugLine="Private TextArea1 As TextArea";
_textarea1 = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextAreaWrapper();
 //BA.debugLineNum = 25;BA.debugLine="Private TextField1 As TextField";
_textfield1 = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
 //BA.debugLineNum = 26;BA.debugLine="Private ToggleButton1 As ToggleButton";
_togglebutton1 = new anywheresoftware.b4j.objects.ButtonWrapper.ToggleButtonWrapper();
 //BA.debugLineNum = 27;BA.debugLine="Private TreeView1 As TreeView";
_treeview1 = new anywheresoftware.b4j.objects.TreeViewWrapper();
 //BA.debugLineNum = 28;BA.debugLine="End Sub";
return "";
}
public static String  _slider1_valuechange(double _value) throws Exception{
 //BA.debugLineNum = 56;BA.debugLine="Sub Slider1_ValueChange (Value As Double)";
 //BA.debugLineNum = 57;BA.debugLine="ProgressBar1.Progress = Value/100";
_progressbar1.setProgress(_value/(double)100);
 //BA.debugLineNum = 58;BA.debugLine="ProgressIndicator1.Progress = Value/100";
_progressindicator1.setProgress(_value/(double)100);
 //BA.debugLineNum = 59;BA.debugLine="Log(\"Value :\" & Value)";
anywheresoftware.b4a.keywords.Common.Log("Value :"+BA.NumberToString(_value));
 //BA.debugLineNum = 60;BA.debugLine="End Sub";
return "";
}
}
