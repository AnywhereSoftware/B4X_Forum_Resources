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
public static anywheresoftware.b4a.objects.collections.List _l = null;
public static String[] _seg = null;
public static String  _appstart(anywheresoftware.b4j.objects.Form _form1,String[] _args) throws Exception{
 //BA.debugLineNum = 15;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
 //BA.debugLineNum = 16;BA.debugLine="MainForm = Form1";
_mainform = _form1;
 //BA.debugLineNum = 17;BA.debugLine="MainForm.RootPane.LoadLayout(\"Layout1\")";
_mainform.getRootPane().LoadLayout(ba,"Layout1");
 //BA.debugLineNum = 18;BA.debugLine="MainForm.Show";
_mainform.Show();
 //BA.debugLineNum = 19;BA.debugLine="l.Initialize";
_l.Initialize();
 //BA.debugLineNum = 20;BA.debugLine="InitList";
_initlist();
 //BA.debugLineNum = 21;BA.debugLine="ConvertList";
_convertlist();
 //BA.debugLineNum = 22;BA.debugLine="MainForm.Close";
_mainform.Close();
 //BA.debugLineNum = 23;BA.debugLine="End Sub";
return "";
}
public static String  _button1_click() throws Exception{
 //BA.debugLineNum = 25;BA.debugLine="Sub Button1_Click";
 //BA.debugLineNum = 26;BA.debugLine="ConvertList";
_convertlist();
 //BA.debugLineNum = 27;BA.debugLine="xui.MsgboxAsync(\"Hello World!\", \"B4X\")";
_xui.MsgboxAsync(ba,"Hello World!","B4X");
 //BA.debugLineNum = 28;BA.debugLine="End Sub";
return "";
}
public static String  _convertlist() throws Exception{
int _i = 0;
String _s = "";
String[] _e = null;
String[] _b = null;
String _p = "";
 //BA.debugLineNum = 30;BA.debugLine="Sub ConvertList";
 //BA.debugLineNum = 31;BA.debugLine="Dim i As Int";
_i = 0;
 //BA.debugLineNum = 32;BA.debugLine="For Each s As String In l";
{
final anywheresoftware.b4a.BA.IterableList group2 = _l;
final int groupLen2 = group2.getSize()
;int index2 = 0;
;
for (; index2 < groupLen2;index2++){
_s = BA.ObjectToString(group2.Get(index2));
 //BA.debugLineNum = 33;BA.debugLine="Dim e() As String = Regex.Split(\",\", s)";
_e = anywheresoftware.b4a.keywords.Common.Regex.Split(",",_s);
 //BA.debugLineNum = 35;BA.debugLine="Dim b() As String = Regex.Split(\"\",e(0))";
_b = anywheresoftware.b4a.keywords.Common.Regex.Split("",_e[(int) (0)]);
 //BA.debugLineNum = 36;BA.debugLine="Dim p As String	= \"\"";
_p = "";
 //BA.debugLineNum = 37;BA.debugLine="For i = 0 To b.Length - 1";
{
final int step6 = 1;
final int limit6 = (int) (_b.length-1);
_i = (int) (0) ;
for (;_i <= limit6 ;_i = _i + step6 ) {
 //BA.debugLineNum = 38;BA.debugLine="If b(i) = \"1\" Then";
if ((_b[_i]).equals("1")) { 
 //BA.debugLineNum = 39;BA.debugLine="p = p & seg(i) ' & \" | \"";
_p = _p+_seg[_i];
 //BA.debugLineNum = 40;BA.debugLine="If i < b.Length - 1 Then p = p  & \" | \"";
if (_i<_b.length-1) { 
_p = _p+" | ";};
 };
 }
};
 //BA.debugLineNum = 43;BA.debugLine="If p = \"\" Then p = \"0\"";
if ((_p).equals("")) { 
_p = "0";};
 //BA.debugLineNum = 44;BA.debugLine="p = p & \",\" & TAB & e(1)";
_p = _p+","+anywheresoftware.b4a.keywords.Common.TAB+_e[(int) (1)];
 //BA.debugLineNum = 45;BA.debugLine="Log(p)";
anywheresoftware.b4a.keywords.Common.Log(_p);
 }
};
 //BA.debugLineNum = 47;BA.debugLine="End Sub";
return "";
}
public static String  _initlist() throws Exception{
 //BA.debugLineNum = 49;BA.debugLine="Sub InitList";
 //BA.debugLineNum = 50;BA.debugLine="l.Add(\"1111110,		// 0\")";
_l.Add((Object)("1111110,		// 0"));
 //BA.debugLineNum = 51;BA.debugLine="l.Add(\"0110000, 	// 1\")";
_l.Add((Object)("0110000, 	// 1"));
 //BA.debugLineNum = 52;BA.debugLine="l.Add(\"1101101, 	// 2\")";
_l.Add((Object)("1101101, 	// 2"));
 //BA.debugLineNum = 53;BA.debugLine="l.Add(\"1111001, 	// 3\")";
_l.Add((Object)("1111001, 	// 3"));
 //BA.debugLineNum = 54;BA.debugLine="l.Add(\"0110011, 	// 4\")";
_l.Add((Object)("0110011, 	// 4"));
 //BA.debugLineNum = 55;BA.debugLine="l.Add(\"1011011,		// 5\")";
_l.Add((Object)("1011011,		// 5"));
 //BA.debugLineNum = 56;BA.debugLine="l.Add(\"1011111, 	// 6\")";
_l.Add((Object)("1011111, 	// 6"));
 //BA.debugLineNum = 57;BA.debugLine="l.Add(\"1110000, 	// 7\")";
_l.Add((Object)("1110000, 	// 7"));
 //BA.debugLineNum = 58;BA.debugLine="l.Add(\"1111111, 	// 8\")";
_l.Add((Object)("1111111, 	// 8"));
 //BA.debugLineNum = 59;BA.debugLine="l.Add(\"1111011, 	// 9\")";
_l.Add((Object)("1111011, 	// 9"));
 //BA.debugLineNum = 60;BA.debugLine="l.Add(\"0000000, 	// 10 ' '\")";
_l.Add((Object)("0000000, 	// 10 ' '"));
 //BA.debugLineNum = 61;BA.debugLine="l.Add(\"0000001,		// 11 -\")";
_l.Add((Object)("0000001,		// 11 -"));
 //BA.debugLineNum = 62;BA.debugLine="l.Add(\"1100011, 	// 12 °\")";
_l.Add((Object)("1100011, 	// 12 °"));
 //BA.debugLineNum = 63;BA.debugLine="l.Add(\"0001001, 	// 13 =\")";
_l.Add((Object)("0001001, 	// 13 ="));
 //BA.debugLineNum = 64;BA.debugLine="l.Add(\"0100101, 	// 14 / \")";
_l.Add((Object)("0100101, 	// 14 / "));
 //BA.debugLineNum = 65;BA.debugLine="l.Add(\"0001000, 	// 15 _\")";
_l.Add((Object)("0001000, 	// 15 _"));
 //BA.debugLineNum = 66;BA.debugLine="l.Add(\"0010010, 	// 16 %\")";
_l.Add((Object)("0010010, 	// 16 %"));
 //BA.debugLineNum = 67;BA.debugLine="l.Add(\"1110100,		// 17 @\")";
_l.Add((Object)("1110100,		// 17 @"));
 //BA.debugLineNum = 68;BA.debugLine="l.Add(\"0000100, 	// 18 .\")";
_l.Add((Object)("0000100, 	// 18 ."));
 //BA.debugLineNum = 69;BA.debugLine="l.Add(\"0011000, 	// 19 ,\")";
_l.Add((Object)("0011000, 	// 19 ,"));
 //BA.debugLineNum = 70;BA.debugLine="l.Add(\"0101000, 	// 20 ;\")";
_l.Add((Object)("0101000, 	// 20 ;"));
 //BA.debugLineNum = 71;BA.debugLine="l.Add(\"1001000, 	// 21 :\")";
_l.Add((Object)("1001000, 	// 21 :"));
 //BA.debugLineNum = 72;BA.debugLine="l.Add(\"0110001, 	// 22 +\")";
_l.Add((Object)("0110001, 	// 22 +"));
 //BA.debugLineNum = 73;BA.debugLine="l.Add(\"1001001,		// 23 *\")";
_l.Add((Object)("1001001,		// 23 *"));
 //BA.debugLineNum = 74;BA.debugLine="l.Add(\"0110110, 	// 24 #\")";
_l.Add((Object)("0110110, 	// 24 #"));
 //BA.debugLineNum = 75;BA.debugLine="l.Add(\"1101011, 	// 25 !\")";
_l.Add((Object)("1101011, 	// 25 !"));
 //BA.debugLineNum = 76;BA.debugLine="l.Add(\"1101001, 	// 26 ?\")";
_l.Add((Object)("1101001, 	// 26 ?"));
 //BA.debugLineNum = 77;BA.debugLine="l.Add(\"0000010, 	// 27 '\")";
_l.Add((Object)("0000010, 	// 27 '"));
 //BA.debugLineNum = 78;BA.debugLine="l.Add(\"0100010, 	// 28 ''\")";
_l.Add((Object)("0100010, 	// 28 ''"));
 //BA.debugLineNum = 79;BA.debugLine="l.Add(\"1000010,		// 29 <\")";
_l.Add((Object)("1000010,		// 29 <"));
 //BA.debugLineNum = 80;BA.debugLine="l.Add(\"1100000, 	// 30 >\")";
_l.Add((Object)("1100000, 	// 30 >"));
 //BA.debugLineNum = 81;BA.debugLine="l.Add(\"0010011, 	// 31 \\\")";
_l.Add((Object)("0010011, 	// 31 \\"));
 //BA.debugLineNum = 82;BA.debugLine="l.Add(\"1001110, 	// 32 (\")";
_l.Add((Object)("1001110, 	// 32 ("));
 //BA.debugLineNum = 83;BA.debugLine="l.Add(\"1111000, 	// 33 )\")";
_l.Add((Object)("1111000, 	// 33 )"));
 //BA.debugLineNum = 84;BA.debugLine="l.Add(\"1000000, 	// 34 |\")";
_l.Add((Object)("1000000, 	// 34 |"));
 //BA.debugLineNum = 85;BA.debugLine="l.Add(\"1001110,		// 35 C\")";
_l.Add((Object)("1001110,		// 35 C"));
 //BA.debugLineNum = 86;BA.debugLine="l.Add(\"0110111, 	// 36 H\")";
_l.Add((Object)("0110111, 	// 36 H"));
 //BA.debugLineNum = 87;BA.debugLine="l.Add(\"1110110, 	// 37 N\")";
_l.Add((Object)("1110110, 	// 37 N"));
 //BA.debugLineNum = 88;BA.debugLine="l.Add(\"1111110, 	// 38 O\")";
_l.Add((Object)("1111110, 	// 38 O"));
 //BA.debugLineNum = 89;BA.debugLine="l.Add(\"1100110, 	// 39 R\")";
_l.Add((Object)("1100110, 	// 39 R"));
 //BA.debugLineNum = 90;BA.debugLine="l.Add(\"0111110, 	// 40 U\")";
_l.Add((Object)("0111110, 	// 40 U"));
 //BA.debugLineNum = 91;BA.debugLine="l.Add(\"0110111,		// 41 X\")";
_l.Add((Object)("0110111,		// 41 X"));
 //BA.debugLineNum = 92;BA.debugLine="l.Add(\"1111101, 	// 42 A\")";
_l.Add((Object)("1111101, 	// 42 A"));
 //BA.debugLineNum = 93;BA.debugLine="l.Add(\"0011111, 	// 43 B\")";
_l.Add((Object)("0011111, 	// 43 B"));
 //BA.debugLineNum = 94;BA.debugLine="l.Add(\"0001101, 	// 44 C\")";
_l.Add((Object)("0001101, 	// 44 C"));
 //BA.debugLineNum = 95;BA.debugLine="l.Add(\"0111101, 	// 45 D\")";
_l.Add((Object)("0111101, 	// 45 D"));
 //BA.debugLineNum = 96;BA.debugLine="l.Add(\"1001111, 	// 46 E\")";
_l.Add((Object)("1001111, 	// 46 E"));
 //BA.debugLineNum = 97;BA.debugLine="l.Add(\"1000111,		// 47 F\")";
_l.Add((Object)("1000111,		// 47 F"));
 //BA.debugLineNum = 98;BA.debugLine="l.Add(\"1011110, 	// 48 G\")";
_l.Add((Object)("1011110, 	// 48 G"));
 //BA.debugLineNum = 99;BA.debugLine="l.Add(\"0010111, 	// 49 H\")";
_l.Add((Object)("0010111, 	// 49 H"));
 //BA.debugLineNum = 100;BA.debugLine="l.Add(\"1000100, 	// 50 I\")";
_l.Add((Object)("1000100, 	// 50 I"));
 //BA.debugLineNum = 101;BA.debugLine="l.Add(\"1011000, 	// 51 J\")";
_l.Add((Object)("1011000, 	// 51 J"));
 //BA.debugLineNum = 102;BA.debugLine="l.Add(\"1010111, 	// 52 K\")";
_l.Add((Object)("1010111, 	// 52 K"));
 //BA.debugLineNum = 103;BA.debugLine="l.Add(\"0001110,		// 53 L\")";
_l.Add((Object)("0001110,		// 53 L"));
 //BA.debugLineNum = 104;BA.debugLine="l.Add(\"1010101, 	// 54 M\")";
_l.Add((Object)("1010101, 	// 54 M"));
 //BA.debugLineNum = 105;BA.debugLine="l.Add(\"0010101, 	// 55 N\")";
_l.Add((Object)("0010101, 	// 55 N"));
 //BA.debugLineNum = 106;BA.debugLine="l.Add(\"0011101, 	// 56 O\")";
_l.Add((Object)("0011101, 	// 56 O"));
 //BA.debugLineNum = 107;BA.debugLine="l.Add(\"1100111, 	// 57 P\")";
_l.Add((Object)("1100111, 	// 57 P"));
 //BA.debugLineNum = 108;BA.debugLine="l.Add(\"1110011, 	// 58 Q\")";
_l.Add((Object)("1110011, 	// 58 Q"));
 //BA.debugLineNum = 109;BA.debugLine="l.Add(\"0000101,		// 59 R\")";
_l.Add((Object)("0000101,		// 59 R"));
 //BA.debugLineNum = 110;BA.debugLine="l.Add(\"1011010, 	// 60 S\")";
_l.Add((Object)("1011010, 	// 60 S"));
 //BA.debugLineNum = 111;BA.debugLine="l.Add(\"0001111, 	// 61 T\")";
_l.Add((Object)("0001111, 	// 61 T"));
 //BA.debugLineNum = 112;BA.debugLine="l.Add(\"0011100, 	// 62 U\")";
_l.Add((Object)("0011100, 	// 62 U"));
 //BA.debugLineNum = 113;BA.debugLine="l.Add(\"0101010, 	// 63 V\")";
_l.Add((Object)("0101010, 	// 63 V"));
 //BA.debugLineNum = 114;BA.debugLine="l.Add(\"0101011, 	// 64 W\")";
_l.Add((Object)("0101011, 	// 64 W"));
 //BA.debugLineNum = 115;BA.debugLine="l.Add(\"0010100,		// 65 X\")";
_l.Add((Object)("0010100,		// 65 X"));
 //BA.debugLineNum = 116;BA.debugLine="l.Add(\"0111011, 	// 66 Y\")";
_l.Add((Object)("0111011, 	// 66 Y"));
 //BA.debugLineNum = 117;BA.debugLine="l.Add(\"1101100,		// 67 Z\")";
_l.Add((Object)("1101100,		// 67 Z"));
 //BA.debugLineNum = 118;BA.debugLine="End Sub";
return "";
}

private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main._process_globals();
		
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
 //BA.debugLineNum = 11;BA.debugLine="Dim l As List";
_l = new anywheresoftware.b4a.objects.collections.List();
 //BA.debugLineNum = 12;BA.debugLine="Dim seg() As String = Array As String(\"SEG_A\",\"SE";
_seg = new String[]{"SEG_A","SEG_B","SEG_C","SEG_D","SEG_E","SEG_F","SEG_G"};
 //BA.debugLineNum = 13;BA.debugLine="End Sub";
return "";
}
}
