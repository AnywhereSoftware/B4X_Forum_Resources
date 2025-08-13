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
            frm.initWithStage(ba, stage, 1020, 920);
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
		        b4j.example.cssutils._process_globals();
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static class _trading_bot{
public boolean IsInitialized;
public String name;
public String exchange;
public String secondary_coin;
public void Initialize() {
IsInitialized = true;
name = "";
exchange = "";
secondary_coin = "";
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4j.objects.JFX _fx = null;
public static anywheresoftware.b4j.objects.Form _mainform = null;
public static anywheresoftware.b4a.objects.collections.List _bot_list = null;
public static b4j.example.main._trading_bot _selected_bot = null;
public static String _selected_scoin = "";
public static String _selected_coinpair = "";
public static anywheresoftware.b4a.objects.Timer _bot_timer = null;
public static b4j.example.cssutils _cssutils = null;
public static b4j.example.ccxt _ccxt = null;
public static b4j.example.calc _calc = null;
public static b4j.example.test_ui _test_ui = null;
public static b4j.example.httputils2service _httputils2service = null;
public static String  _appstart(anywheresoftware.b4j.objects.Form _form1,String[] _args) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "appstart", false))
	 {return ((String) Debug.delegate(ba, "appstart", new Object[] {_form1,_args}));}
RDebugUtils.currentLine=65536;
 //BA.debugLineNum = 65536;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
RDebugUtils.currentLine=65537;
 //BA.debugLineNum = 65537;BA.debugLine="Log(\"Program Start ------------------------------";
anywheresoftware.b4a.keywords.Common.LogImpl("765537","Program Start ----------------------------------------------------",0);
RDebugUtils.currentLine=65538;
 //BA.debugLineNum = 65538;BA.debugLine="MainForm = Form1";
_mainform = _form1;
RDebugUtils.currentLine=65540;
 //BA.debugLineNum = 65540;BA.debugLine="MainForm.WindowWidth = 1032";
_mainform.setWindowWidth(1032);
RDebugUtils.currentLine=65541;
 //BA.debugLineNum = 65541;BA.debugLine="MainForm.WindowHeight = 945";
_mainform.setWindowHeight(945);
RDebugUtils.currentLine=65542;
 //BA.debugLineNum = 65542;BA.debugLine="MainForm.WindowTop = (1080 - MainForm.Height) / 2";
_mainform.setWindowTop((1080-_mainform.getHeight())/(double)2);
RDebugUtils.currentLine=65543;
 //BA.debugLineNum = 65543;BA.debugLine="MainForm.WindowLeft = 0";
_mainform.setWindowLeft(0);
RDebugUtils.currentLine=65544;
 //BA.debugLineNum = 65544;BA.debugLine="MainForm.Show";
_mainform.Show();
RDebugUtils.currentLine=65546;
 //BA.debugLineNum = 65546;BA.debugLine="DateTime.SetTimeZone(0)								'UTC matches php,";
anywheresoftware.b4a.keywords.Common.DateTime.SetTimeZone(0);
RDebugUtils.currentLine=65550;
 //BA.debugLineNum = 65550;BA.debugLine="ccxt.Exchange_Info_Map.Initialize";
_ccxt._exchange_info_map /*anywheresoftware.b4a.objects.collections.Map*/ .Initialize();
RDebugUtils.currentLine=65551;
 //BA.debugLineNum = 65551;BA.debugLine="Calc.All_My_Orders_List.Initialize";
_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=65553;
 //BA.debugLineNum = 65553;BA.debugLine="test_ui.Start";
_test_ui._start /*String*/ ();
RDebugUtils.currentLine=65556;
 //BA.debugLineNum = 65556;BA.debugLine="Bot_List.Initialize";
_bot_list.Initialize();
RDebugUtils.currentLine=65558;
 //BA.debugLineNum = 65558;BA.debugLine="Create_Bot(\"binanceus_1\", \"binanceus\", \"USD\")";
_create_bot("binanceus_1","binanceus","USD");
RDebugUtils.currentLine=65559;
 //BA.debugLineNum = 65559;BA.debugLine="Create_Bot(\"kraken_1\", \"kraken\", \"USD\")";
_create_bot("kraken_1","kraken","USD");
RDebugUtils.currentLine=65562;
 //BA.debugLineNum = 65562;BA.debugLine="Bot_Timer.Initialize(\"Bot_Timer\", 1000)";
_bot_timer.Initialize(ba,"Bot_Timer",(long) (1000));
RDebugUtils.currentLine=65563;
 //BA.debugLineNum = 65563;BA.debugLine="Bot_Timer.Enabled = True";
_bot_timer.setEnabled(anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=65564;
 //BA.debugLineNum = 65564;BA.debugLine="End Sub";
return "";
}
public static String  _create_bot(String _name,String _exchange,String _secondary_coin) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "create_bot", false))
	 {return ((String) Debug.delegate(ba, "create_bot", new Object[] {_name,_exchange,_secondary_coin}));}
b4j.example.main._trading_bot _my_bot = null;
RDebugUtils.currentLine=131072;
 //BA.debugLineNum = 131072;BA.debugLine="Sub Create_Bot(name As String, exchange As String,";
RDebugUtils.currentLine=131073;
 //BA.debugLineNum = 131073;BA.debugLine="Dim my_bot As Trading_Bot";
_my_bot = new b4j.example.main._trading_bot();
RDebugUtils.currentLine=131074;
 //BA.debugLineNum = 131074;BA.debugLine="my_bot.Initialize";
_my_bot.Initialize();
RDebugUtils.currentLine=131075;
 //BA.debugLineNum = 131075;BA.debugLine="my_bot.name = name";
_my_bot.name /*String*/  = _name;
RDebugUtils.currentLine=131076;
 //BA.debugLineNum = 131076;BA.debugLine="my_bot.exchange = exchange";
_my_bot.exchange /*String*/  = _exchange;
RDebugUtils.currentLine=131077;
 //BA.debugLineNum = 131077;BA.debugLine="my_bot.secondary_coin = secondary_coin";
_my_bot.secondary_coin /*String*/  = _secondary_coin;
RDebugUtils.currentLine=131078;
 //BA.debugLineNum = 131078;BA.debugLine="Bot_List.Add(my_bot)";
_bot_list.Add((Object)(_my_bot));
RDebugUtils.currentLine=131079;
 //BA.debugLineNum = 131079;BA.debugLine="test_ui.cmb_Bot.Items.Add(name)";
_test_ui._cmb_bot /*anywheresoftware.b4j.objects.ComboBoxWrapper*/ .getItems().Add((Object)(_name));
RDebugUtils.currentLine=131080;
 //BA.debugLineNum = 131080;BA.debugLine="End Sub";
return "";
}
public static String  _bot_timer_tick() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "bot_timer_tick", false))
	 {return ((String) Debug.delegate(ba, "bot_timer_tick", null));}
RDebugUtils.currentLine=196608;
 //BA.debugLineNum = 196608;BA.debugLine="Sub Bot_Timer_tick				'Example of Bot Stuff to do";
RDebugUtils.currentLine=196622;
 //BA.debugLineNum = 196622;BA.debugLine="End Sub";
return "";
}
}