package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _appstart(RemoteObject _form1,RemoteObject _args) throws Exception{
try {
		Debug.PushSubsStack("AppStart (main) ","main",0,main.ba,main.mostCurrent,18);
if (RapidSub.canDelegate("appstart")) { return b4j.example.main.remoteMe.runUserSub(false, "main","appstart", _form1, _args);}
Debug.locals.put("Form1", _form1);
Debug.locals.put("Args", _args);
 BA.debugLineNum = 18;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
Debug.ShouldStop(131072);
 BA.debugLineNum = 19;BA.debugLine="Log(\"Program Start ------------------------------";
Debug.ShouldStop(262144);
main.__c.runVoidMethod ("LogImpl","765537",RemoteObject.createImmutable("Program Start ----------------------------------------------------"),0);
 BA.debugLineNum = 20;BA.debugLine="MainForm = Form1";
Debug.ShouldStop(524288);
main._mainform = _form1;
 BA.debugLineNum = 22;BA.debugLine="MainForm.WindowWidth = 1032";
Debug.ShouldStop(2097152);
main._mainform.runMethod(true,"setWindowWidth",BA.numberCast(double.class, 1032));
 BA.debugLineNum = 23;BA.debugLine="MainForm.WindowHeight = 945";
Debug.ShouldStop(4194304);
main._mainform.runMethod(true,"setWindowHeight",BA.numberCast(double.class, 945));
 BA.debugLineNum = 24;BA.debugLine="MainForm.WindowTop = (1080 - MainForm.Height) / 2";
Debug.ShouldStop(8388608);
main._mainform.runMethod(true,"setWindowTop",RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1080),main._mainform.runMethod(true,"getHeight")}, "-",1, 0)),RemoteObject.createImmutable(2)}, "/",0, 0));
 BA.debugLineNum = 25;BA.debugLine="MainForm.WindowLeft = 0";
Debug.ShouldStop(16777216);
main._mainform.runMethod(true,"setWindowLeft",BA.numberCast(double.class, 0));
 BA.debugLineNum = 26;BA.debugLine="MainForm.Show";
Debug.ShouldStop(33554432);
main._mainform.runVoidMethodAndSync ("Show");
 BA.debugLineNum = 28;BA.debugLine="DateTime.SetTimeZone(0)								'UTC matches php,";
Debug.ShouldStop(134217728);
main.__c.getField(false,"DateTime").runVoidMethod ("SetTimeZone",(Object)(BA.numberCast(double.class, 0)));
 BA.debugLineNum = 32;BA.debugLine="ccxt.Exchange_Info_Map.Initialize";
Debug.ShouldStop(-2147483648);
main._ccxt._exchange_info_map /*RemoteObject*/ .runVoidMethod ("Initialize");
 BA.debugLineNum = 33;BA.debugLine="Calc.All_My_Orders_List.Initialize";
Debug.ShouldStop(1);
main._calc._all_my_orders_list /*RemoteObject*/ .runVoidMethod ("Initialize");
 BA.debugLineNum = 35;BA.debugLine="test_ui.Start";
Debug.ShouldStop(4);
main._test_ui.runVoidMethod ("_start" /*RemoteObject*/ );
 BA.debugLineNum = 38;BA.debugLine="Bot_List.Initialize";
Debug.ShouldStop(32);
main._bot_list.runVoidMethod ("Initialize");
 BA.debugLineNum = 40;BA.debugLine="Create_Bot(\"binanceus_1\", \"binanceus\", \"USD\")";
Debug.ShouldStop(128);
_create_bot(BA.ObjectToString("binanceus_1"),BA.ObjectToString("binanceus"),RemoteObject.createImmutable("USD"));
 BA.debugLineNum = 41;BA.debugLine="Create_Bot(\"kraken_1\", \"kraken\", \"USD\")";
Debug.ShouldStop(256);
_create_bot(BA.ObjectToString("kraken_1"),BA.ObjectToString("kraken"),RemoteObject.createImmutable("USD"));
 BA.debugLineNum = 44;BA.debugLine="Bot_Timer.Initialize(\"Bot_Timer\", 1000)";
Debug.ShouldStop(2048);
main._bot_timer.runVoidMethod ("Initialize",main.ba,(Object)(BA.ObjectToString("Bot_Timer")),(Object)(BA.numberCast(long.class, 1000)));
 BA.debugLineNum = 45;BA.debugLine="Bot_Timer.Enabled = True";
Debug.ShouldStop(4096);
main._bot_timer.runMethod(true,"setEnabled",main.__c.getField(true,"True"));
 BA.debugLineNum = 46;BA.debugLine="End Sub";
Debug.ShouldStop(8192);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _bot_timer_tick() throws Exception{
try {
		Debug.PushSubsStack("Bot_Timer_tick (main) ","main",0,main.ba,main.mostCurrent,59);
if (RapidSub.canDelegate("bot_timer_tick")) { return b4j.example.main.remoteMe.runUserSub(false, "main","bot_timer_tick");}
 BA.debugLineNum = 59;BA.debugLine="Sub Bot_Timer_tick				'Example of Bot Stuff to do";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 73;BA.debugLine="End Sub";
Debug.ShouldStop(256);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _create_bot(RemoteObject _name,RemoteObject _exchange,RemoteObject _secondary_coin) throws Exception{
try {
		Debug.PushSubsStack("Create_Bot (main) ","main",0,main.ba,main.mostCurrent,49);
if (RapidSub.canDelegate("create_bot")) { return b4j.example.main.remoteMe.runUserSub(false, "main","create_bot", _name, _exchange, _secondary_coin);}
RemoteObject _my_bot = RemoteObject.declareNull("b4j.example.main._trading_bot");
Debug.locals.put("name", _name);
Debug.locals.put("exchange", _exchange);
Debug.locals.put("secondary_coin", _secondary_coin);
 BA.debugLineNum = 49;BA.debugLine="Sub Create_Bot(name As String, exchange As String,";
Debug.ShouldStop(65536);
 BA.debugLineNum = 50;BA.debugLine="Dim my_bot As Trading_Bot";
Debug.ShouldStop(131072);
_my_bot = RemoteObject.createNew ("b4j.example.main._trading_bot");Debug.locals.put("my_bot", _my_bot);
 BA.debugLineNum = 51;BA.debugLine="my_bot.Initialize";
Debug.ShouldStop(262144);
_my_bot.runVoidMethod ("Initialize");
 BA.debugLineNum = 52;BA.debugLine="my_bot.name = name";
Debug.ShouldStop(524288);
_my_bot.setField ("name" /*RemoteObject*/ ,_name);
 BA.debugLineNum = 53;BA.debugLine="my_bot.exchange = exchange";
Debug.ShouldStop(1048576);
_my_bot.setField ("exchange" /*RemoteObject*/ ,_exchange);
 BA.debugLineNum = 54;BA.debugLine="my_bot.secondary_coin = secondary_coin";
Debug.ShouldStop(2097152);
_my_bot.setField ("secondary_coin" /*RemoteObject*/ ,_secondary_coin);
 BA.debugLineNum = 55;BA.debugLine="Bot_List.Add(my_bot)";
Debug.ShouldStop(4194304);
main._bot_list.runVoidMethod ("Add",(Object)((_my_bot)));
 BA.debugLineNum = 56;BA.debugLine="test_ui.cmb_Bot.Items.Add(name)";
Debug.ShouldStop(8388608);
main._test_ui._cmb_bot /*RemoteObject*/ .runMethod(false,"getItems").runVoidMethod ("Add",(Object)((_name)));
 BA.debugLineNum = 57;BA.debugLine="End Sub";
Debug.ShouldStop(16777216);
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
ccxt_subs_0._process_globals();
calc_subs_0._process_globals();
test_ui_subs_0._process_globals();
httputils2service_subs_0._process_globals();
main.myClass = BA.getDeviceClass ("b4j.example.main");
ccxt.myClass = BA.getDeviceClass ("b4j.example.ccxt");
calc.myClass = BA.getDeviceClass ("b4j.example.calc");
test_ui.myClass = BA.getDeviceClass ("b4j.example.test_ui");
httputils2service.myClass = BA.getDeviceClass ("b4j.example.httputils2service");
httpjob.myClass = BA.getDeviceClass ("b4j.example.httpjob");
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 6;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 7;BA.debugLine="Private fx As JFX";
main._fx = RemoteObject.createNew ("anywheresoftware.b4j.objects.JFX");
 //BA.debugLineNum = 8;BA.debugLine="Dim MainForm As Form";
main._mainform = RemoteObject.createNew ("anywheresoftware.b4j.objects.Form");
 //BA.debugLineNum = 9;BA.debugLine="Type Trading_Bot (name As String, exchange As Str";
;
 //BA.debugLineNum = 10;BA.debugLine="Dim Bot_List As List		'list of trading_bot object";
main._bot_list = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");
 //BA.debugLineNum = 11;BA.debugLine="Dim Selected_Bot As Trading_Bot";
main._selected_bot = RemoteObject.createNew ("b4j.example.main._trading_bot");
 //BA.debugLineNum = 12;BA.debugLine="Dim Selected_Scoin As String";
main._selected_scoin = RemoteObject.createImmutable("");
 //BA.debugLineNum = 13;BA.debugLine="Dim Selected_Coinpair As String";
main._selected_coinpair = RemoteObject.createImmutable("");
 //BA.debugLineNum = 14;BA.debugLine="Private Bot_Timer As Timer";
main._bot_timer = RemoteObject.createNew ("anywheresoftware.b4a.objects.Timer");
 //BA.debugLineNum = 16;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}