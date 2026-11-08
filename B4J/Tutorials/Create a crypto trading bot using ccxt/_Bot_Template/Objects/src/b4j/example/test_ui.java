package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;

public class test_ui extends Object{
public static test_ui mostCurrent = new test_ui();

public static BA ba;
static {
		ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.test_ui", null);
		ba.loadHtSubs(test_ui.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			
			ba.raiseEvent2(null, true, "SHELL", false);
			ba.raiseEvent2(null, true, "CREATE", true, "b4j.example.test_ui", ba);
		}
	}
    public static Class<?> getObject() {
		return test_ui.class;
	}

 
public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4j.objects.JFX _fx = null;
public static anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pane_api_call_buttons = null;
public static anywheresoftware.b4j.objects.ButtonWrapper _btn_reset = null;
public static anywheresoftware.b4j.objects.TextInputControlWrapper.TextAreaWrapper _txt_output = null;
public static anywheresoftware.b4j.objects.ComboBoxWrapper _cmb_bot = null;
public static anywheresoftware.b4j.objects.ComboBoxWrapper _cmb_scoin = null;
public static anywheresoftware.b4j.objects.ComboBoxWrapper _cmb_coinpair = null;
public static anywheresoftware.b4j.objects.LabelWrapper _lbl_exchange = null;
public static anywheresoftware.b4j.objects.LabelWrapper _lbl_open_orders = null;
public static anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public static anywheresoftware.b4a.objects.collections.Map _api_call_map = null;
public static double _btc_buy_price = 0;
public static double _btc_buy_volume = 0;
public static double _btc_buy_total = 0;
public static double _btc_edit_buy_price = 0;
public static double _btc_edit_buy_volume = 0;
public static double _btc_edit_buy_total = 0;
public static double _btc_sell_price = 0;
public static double _btc_sell_volume = 0;
public static double _btc_sell_total = 0;
public static b4j.example.cssutils _cssutils = null;
public static b4j.example.main _main = null;
public static b4j.example.ccxt _ccxt = null;
public static b4j.example.calc _calc = null;
public static b4j.example.httputils2service _httputils2service = null;
public static String  _start() throws Exception{
RDebugUtils.currentModule="test_ui";
if (Debug.shouldDelegate(ba, "start", false))
	 {return ((String) Debug.delegate(ba, "start", null));}
RDebugUtils.currentLine=4456448;
 //BA.debugLineNum = 4456448;BA.debugLine="Sub Start";
RDebugUtils.currentLine=4456449;
 //BA.debugLineNum = 4456449;BA.debugLine="Main.MainForm.RootPane.LoadLayout(\"test\")";
_main._mainform /*anywheresoftware.b4j.objects.Form*/ .getRootPane().LoadLayout(ba,"test");
RDebugUtils.currentLine=4456450;
 //BA.debugLineNum = 4456450;BA.debugLine="cmb_Scoin.Items.Add(\"Get Markets\")";
_cmb_scoin.getItems().Add((Object)("Get Markets"));
RDebugUtils.currentLine=4456451;
 //BA.debugLineNum = 4456451;BA.debugLine="cmb_Coinpair.Items.Add(\"Get Markets\")";
_cmb_coinpair.getItems().Add((Object)("Get Markets"));
RDebugUtils.currentLine=4456452;
 //BA.debugLineNum = 4456452;BA.debugLine="Create_List_of_API_Calls";
_create_list_of_api_calls();
RDebugUtils.currentLine=4456453;
 //BA.debugLineNum = 4456453;BA.debugLine="End Sub";
return "";
}
public static String  _update_orders() throws Exception{
RDebugUtils.currentModule="test_ui";
if (Debug.shouldDelegate(ba, "update_orders", false))
	 {return ((String) Debug.delegate(ba, "update_orders", null));}
RDebugUtils.currentLine=5046272;
 //BA.debugLineNum = 5046272;BA.debugLine="Sub Update_Orders";
RDebugUtils.currentLine=5046273;
 //BA.debugLineNum = 5046273;BA.debugLine="lbl_Open_Orders.Text = Calc.All_My_Orders_List.Si";
_lbl_open_orders.setText(BA.NumberToString(_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .getSize())+" open orders");
RDebugUtils.currentLine=5046274;
 //BA.debugLineNum = 5046274;BA.debugLine="End Sub";
return "";
}
public static String  _btn_click() throws Exception{
RDebugUtils.currentModule="test_ui";
if (Debug.shouldDelegate(ba, "btn_click", false))
	 {return ((String) Debug.delegate(ba, "btn_click", null));}
anywheresoftware.b4j.objects.ButtonWrapper _btn = null;
b4j.example.calc._order _last_buy_order = null;
int _i = 0;
b4j.example.calc._order _this_order = null;
b4j.example.calc._order _last_sell_order = null;
RDebugUtils.currentLine=4653056;
 //BA.debugLineNum = 4653056;BA.debugLine="Sub btn_Click										'default calls for the exam";
RDebugUtils.currentLine=4653057;
 //BA.debugLineNum = 4653057;BA.debugLine="Dim btn As Button = Sender";
_btn = new anywheresoftware.b4j.objects.ButtonWrapper();
_btn = (anywheresoftware.b4j.objects.ButtonWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.ButtonWrapper(), (javafx.scene.control.Button)(anywheresoftware.b4a.keywords.Common.Sender(ba)));
RDebugUtils.currentLine=4653058;
 //BA.debugLineNum = 4653058;BA.debugLine="Select btn.Tag";
switch (BA.switchObjectToInt(_btn.getTag(),(Object)("Test_PHP"),(Object)("Test_CCXT"),(Object)("exchanges"),(Object)("exchange_info"),(Object)("fetch_markets"),(Object)("fetch_ticker"),(Object)("fetch_tickers"),(Object)("fetch_l2_order_book"),(Object)("fetch_ohlcv"),(Object)("fetch_trades"),(Object)("fetch_balance"),(Object)("fetch_open_orders"),(Object)("fetch_all_open_orders"),(Object)("fetch_my_trades"),(Object)("fetch_all_my_trades"),(Object)("create_limit_buy_order"),(Object)("create_limit_sell_order"),(Object)("edit_limit_order"),(Object)("cancel_order"),(Object)("cancel_all_orders"),(Object)("create_market_buy_order"),(Object)("create_market_sell_order"))) {
case 0: {
RDebugUtils.currentLine=4653059;
 //BA.debugLineNum = 4653059;BA.debugLine="Case \"Test_PHP\" : ccxt.Test_PHP";
_ccxt._test_php /*String*/ ();
 break; }
case 1: {
RDebugUtils.currentLine=4653060;
 //BA.debugLineNum = 4653060;BA.debugLine="Case \"Test_CCXT\" : ccxt.Test_CCXT";
_ccxt._test_ccxt /*String*/ ();
 break; }
case 2: {
RDebugUtils.currentLine=4653061;
 //BA.debugLineNum = 4653061;BA.debugLine="Case \"exchanges\" : 	ccxt.Exchanges";
_ccxt._exchanges /*String*/ ();
 break; }
case 3: {
RDebugUtils.currentLine=4653062;
 //BA.debugLineNum = 4653062;BA.debugLine="Case \"exchange_info\" : ccxt.Exchange_Info";
_ccxt._exchange_info /*String*/ ();
 break; }
case 4: {
RDebugUtils.currentLine=4653063;
 //BA.debugLineNum = 4653063;BA.debugLine="Case \"fetch_markets\" : ccxt.Markets";
_ccxt._markets /*String*/ ();
 break; }
case 5: {
RDebugUtils.currentLine=4653064;
 //BA.debugLineNum = 4653064;BA.debugLine="Case \"fetch_ticker\" : 	ccxt.Ticker(Main.Selected";
_ccxt._ticker /*String*/ (_main._selected_coinpair /*String*/ );
 break; }
case 6: {
RDebugUtils.currentLine=4653065;
 //BA.debugLineNum = 4653065;BA.debugLine="Case \"fetch_tickers\" : ccxt.All_Tickers";
_ccxt._all_tickers /*String*/ ();
 break; }
case 7: {
RDebugUtils.currentLine=4653066;
 //BA.debugLineNum = 4653066;BA.debugLine="Case \"fetch_l2_order_book\" : ccxt.OrderBook(Main";
_ccxt._orderbook /*String*/ (_main._selected_coinpair /*String*/ ,(int) (50));
 break; }
case 8: {
RDebugUtils.currentLine=4653067;
 //BA.debugLineNum = 4653067;BA.debugLine="Case \"fetch_ohlcv\" : ccxt.OHLCV(Main.Selected_Co";
_ccxt._ohlcv /*String*/ (_main._selected_coinpair /*String*/ ,"1d");
 break; }
case 9: {
RDebugUtils.currentLine=4653068;
 //BA.debugLineNum = 4653068;BA.debugLine="Case \"fetch_trades\" : ccxt.Public_Trade_History(";
_ccxt._public_trade_history /*String*/ (_main._selected_coinpair /*String*/ ,(int) (50));
 break; }
case 10: {
RDebugUtils.currentLine=4653069;
 //BA.debugLineNum = 4653069;BA.debugLine="Case \"fetch_balance\" : ccxt.My_Balances";
_ccxt._my_balances /*String*/ ();
 break; }
case 11: {
RDebugUtils.currentLine=4653070;
 //BA.debugLineNum = 4653070;BA.debugLine="Case \"fetch_open_orders\" : ccxt.My_Open_Orders(M";
_ccxt._my_open_orders /*String*/ (_main._selected_coinpair /*String*/ );
 break; }
case 12: {
RDebugUtils.currentLine=4653071;
 //BA.debugLineNum = 4653071;BA.debugLine="Case \"fetch_all_open_orders\" : ccxt.All_My_Open_";
_ccxt._all_my_open_orders /*String*/ ();
 break; }
case 13: {
RDebugUtils.currentLine=4653072;
 //BA.debugLineNum = 4653072;BA.debugLine="Case \"fetch_my_trades\" : ccxt.My_Trade_History(M";
_ccxt._my_trade_history /*String*/ (_main._selected_coinpair /*String*/ ,(long) (0),(int) (50));
 break; }
case 14: {
RDebugUtils.currentLine=4653073;
 //BA.debugLineNum = 4653073;BA.debugLine="Case \"fetch_all_my_trades\" : ccxt.All_My_Trade_H";
_ccxt._all_my_trade_history /*String*/ ((long) (0),(int) (200));
 break; }
case 15: {
RDebugUtils.currentLine=4653074;
 //BA.debugLineNum = 4653074;BA.debugLine="Case \"create_limit_buy_order\" : ccxt.Create_Limi";
_ccxt._create_limit_buy_order /*String*/ ("BTC/USD",_btc_buy_price,_btc_buy_volume);
 break; }
case 16: {
RDebugUtils.currentLine=4653075;
 //BA.debugLineNum = 4653075;BA.debugLine="Case \"create_limit_sell_order\" : ccxt.Create_Lim";
_ccxt._create_limit_sell_order /*String*/ ("BTC/USD",_btc_sell_price,_btc_sell_volume);
 break; }
case 17: {
RDebugUtils.currentLine=4653077;
 //BA.debugLineNum = 4653077;BA.debugLine="Dim last_buy_order As Order";
_last_buy_order = new b4j.example.calc._order();
RDebugUtils.currentLine=4653078;
 //BA.debugLineNum = 4653078;BA.debugLine="For i = 0 To Calc.All_My_Orders_List.Size-1";
{
final int step39 = 1;
final int limit39 = (int) (_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .getSize()-1);
_i = (int) (0) ;
for (;_i <= limit39 ;_i = _i + step39 ) {
RDebugUtils.currentLine=4653079;
 //BA.debugLineNum = 4653079;BA.debugLine="Dim this_order As Order = Calc.All_My_Orders_L";
_this_order = (b4j.example.calc._order)(_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .Get(_i));
RDebugUtils.currentLine=4653080;
 //BA.debugLineNum = 4653080;BA.debugLine="If this_order.side = \"buy\" Then last_buy_order";
if ((_this_order.side /*String*/ ).equals("buy")) { 
_last_buy_order = _this_order;};
 }
};
RDebugUtils.currentLine=4653082;
 //BA.debugLineNum = 4653082;BA.debugLine="ccxt.Edit_Limit_Order(last_buy_order.id, last_b";
_ccxt._edit_limit_order /*String*/ (_last_buy_order.id /*String*/ ,_last_buy_order.Coinpair /*String*/ ,_last_buy_order.side /*String*/ ,_btc_edit_buy_price,_btc_edit_buy_volume);
 break; }
case 18: {
RDebugUtils.currentLine=4653086;
 //BA.debugLineNum = 4653086;BA.debugLine="Dim last_sell_order As Order";
_last_sell_order = new b4j.example.calc._order();
RDebugUtils.currentLine=4653087;
 //BA.debugLineNum = 4653087;BA.debugLine="For i = 0 To Calc.All_My_Orders_List.Size-1";
{
final int step46 = 1;
final int limit46 = (int) (_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .getSize()-1);
_i = (int) (0) ;
for (;_i <= limit46 ;_i = _i + step46 ) {
RDebugUtils.currentLine=4653088;
 //BA.debugLineNum = 4653088;BA.debugLine="Dim this_order As Order = Calc.All_My_Orders_L";
_this_order = (b4j.example.calc._order)(_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .Get(_i));
RDebugUtils.currentLine=4653089;
 //BA.debugLineNum = 4653089;BA.debugLine="If this_order.side = \"sell\" Then last_sell_ord";
if ((_this_order.side /*String*/ ).equals("sell")) { 
_last_sell_order = _this_order;};
 }
};
RDebugUtils.currentLine=4653091;
 //BA.debugLineNum = 4653091;BA.debugLine="ccxt.Cancel_Order(last_sell_order.Coinpair, las";
_ccxt._cancel_order /*String*/ (_last_sell_order.Coinpair /*String*/ ,_last_sell_order.id /*String*/ );
 break; }
case 19: {
RDebugUtils.currentLine=4653094;
 //BA.debugLineNum = 4653094;BA.debugLine="Case \"cancel_all_orders\" : ccxt.cancel_all_order";
_ccxt._cancel_all_orders /*String*/ ();
 break; }
case 20: {
 break; }
case 21: {
 break; }
}
;
RDebugUtils.currentLine=4653099;
 //BA.debugLineNum = 4653099;BA.debugLine="End Sub";
return "";
}
public static String  _btn_reset_click() throws Exception{
RDebugUtils.currentModule="test_ui";
if (Debug.shouldDelegate(ba, "btn_reset_click", false))
	 {return ((String) Debug.delegate(ba, "btn_reset_click", null));}
RDebugUtils.currentLine=4915200;
 //BA.debugLineNum = 4915200;BA.debugLine="Private Sub btn_Reset_Click";
RDebugUtils.currentLine=4915201;
 //BA.debugLineNum = 4915201;BA.debugLine="cmb_Bot.SelectedIndex = -1 : Main.Selected_Bot.na";
_cmb_bot.setSelectedIndex((int) (-1));
RDebugUtils.currentLine=4915201;
 //BA.debugLineNum = 4915201;BA.debugLine="cmb_Bot.SelectedIndex = -1 : Main.Selected_Bot.na";
_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/  = "";
RDebugUtils.currentLine=4915202;
 //BA.debugLineNum = 4915202;BA.debugLine="Reset_Stuff";
_reset_stuff();
RDebugUtils.currentLine=4915203;
 //BA.debugLineNum = 4915203;BA.debugLine="End Sub";
return "";
}
public static String  _reset_stuff() throws Exception{
RDebugUtils.currentModule="test_ui";
if (Debug.shouldDelegate(ba, "reset_stuff", false))
	 {return ((String) Debug.delegate(ba, "reset_stuff", null));}
RDebugUtils.currentLine=4980736;
 //BA.debugLineNum = 4980736;BA.debugLine="Private Sub Reset_Stuff";
RDebugUtils.currentLine=4980737;
 //BA.debugLineNum = 4980737;BA.debugLine="cmb_Scoin.SelectedIndex = -1 : Main.Selected_Scoi";
_cmb_scoin.setSelectedIndex((int) (-1));
RDebugUtils.currentLine=4980737;
 //BA.debugLineNum = 4980737;BA.debugLine="cmb_Scoin.SelectedIndex = -1 : Main.Selected_Scoi";
_main._selected_scoin /*String*/  = "";
RDebugUtils.currentLine=4980738;
 //BA.debugLineNum = 4980738;BA.debugLine="cmb_Coinpair.SelectedIndex = -1 : Main.Selected_C";
_cmb_coinpair.setSelectedIndex((int) (-1));
RDebugUtils.currentLine=4980738;
 //BA.debugLineNum = 4980738;BA.debugLine="cmb_Coinpair.SelectedIndex = -1 : Main.Selected_C";
_main._selected_coinpair /*String*/  = "";
RDebugUtils.currentLine=4980739;
 //BA.debugLineNum = 4980739;BA.debugLine="lbl_Exchange.Text = \"\"";
_lbl_exchange.setText("");
RDebugUtils.currentLine=4980740;
 //BA.debugLineNum = 4980740;BA.debugLine="txt_Output.Text = \"\"";
_txt_output.setText("");
RDebugUtils.currentLine=4980741;
 //BA.debugLineNum = 4980741;BA.debugLine="Calc.All_My_Orders_List.Initialize";
_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=4980742;
 //BA.debugLineNum = 4980742;BA.debugLine="Calc.All_My_Trades_List.Initialize";
_calc._all_my_trades_list /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=4980743;
 //BA.debugLineNum = 4980743;BA.debugLine="lbl_Open_Orders.Text = Calc.All_My_Orders_List.Si";
_lbl_open_orders.setText(BA.NumberToString(_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .getSize())+" open orders");
RDebugUtils.currentLine=4980744;
 //BA.debugLineNum = 4980744;BA.debugLine="Create_Grid_of_Buttons";
_create_grid_of_buttons();
RDebugUtils.currentLine=4980745;
 //BA.debugLineNum = 4980745;BA.debugLine="End Sub";
return "";
}
public static String  _cmb_bot_selectedindexchanged(int _index,Object _value) throws Exception{
RDebugUtils.currentModule="test_ui";
if (Debug.shouldDelegate(ba, "cmb_bot_selectedindexchanged", false))
	 {return ((String) Debug.delegate(ba, "cmb_bot_selectedindexchanged", new Object[] {_index,_value}));}
b4j.example.main._trading_bot _this_bot = null;
int _i = 0;
RDebugUtils.currentLine=4718592;
 //BA.debugLineNum = 4718592;BA.debugLine="Sub cmb_Bot_SelectedIndexChanged(Index As Int, Val";
RDebugUtils.currentLine=4718593;
 //BA.debugLineNum = 4718593;BA.debugLine="Log(\"Sub: cmb_Exchange_SelectedIndexChanged(\" & V";
anywheresoftware.b4a.keywords.Common.LogImpl("74718593","Sub: cmb_Exchange_SelectedIndexChanged("+BA.ObjectToString(_value)+")",0);
RDebugUtils.currentLine=4718594;
 //BA.debugLineNum = 4718594;BA.debugLine="Try";
try {RDebugUtils.currentLine=4718595;
 //BA.debugLineNum = 4718595;BA.debugLine="Reset_Stuff";
_reset_stuff();
RDebugUtils.currentLine=4718597;
 //BA.debugLineNum = 4718597;BA.debugLine="Dim this_bot As Trading_Bot";
_this_bot = new b4j.example.main._trading_bot();
RDebugUtils.currentLine=4718598;
 //BA.debugLineNum = 4718598;BA.debugLine="For i = 0 To Main.Bot_List.Size-1				'look for t";
{
final int step5 = 1;
final int limit5 = (int) (_main._bot_list /*anywheresoftware.b4a.objects.collections.List*/ .getSize()-1);
_i = (int) (0) ;
for (;_i <= limit5 ;_i = _i + step5 ) {
RDebugUtils.currentLine=4718599;
 //BA.debugLineNum = 4718599;BA.debugLine="this_bot = Main.Bot_List.Get(i)";
_this_bot = (b4j.example.main._trading_bot)(_main._bot_list /*anywheresoftware.b4a.objects.collections.List*/ .Get(_i));
RDebugUtils.currentLine=4718600;
 //BA.debugLineNum = 4718600;BA.debugLine="If this_bot.name = Value Then		'found it";
if ((_this_bot.name /*String*/ ).equals(BA.ObjectToString(_value))) { 
RDebugUtils.currentLine=4718602;
 //BA.debugLineNum = 4718602;BA.debugLine="Main.Selected_Bot.Initialize";
_main._selected_bot /*b4j.example.main._trading_bot*/ .Initialize();
RDebugUtils.currentLine=4718603;
 //BA.debugLineNum = 4718603;BA.debugLine="Main.Selected_Bot = this_bot";
_main._selected_bot /*b4j.example.main._trading_bot*/  = _this_bot;
RDebugUtils.currentLine=4718604;
 //BA.debugLineNum = 4718604;BA.debugLine="lbl_Exchange.Text = Main.Selected_Bot.exchange";
_lbl_exchange.setText(_main._selected_bot /*b4j.example.main._trading_bot*/ .exchange /*String*/ );
 };
 }
};
RDebugUtils.currentLine=4718607;
 //BA.debugLineNum = 4718607;BA.debugLine="Create_Grid_of_Buttons";
_create_grid_of_buttons();
 } 
       catch (Exception e15) {
			ba.setLastException(e15);RDebugUtils.currentLine=4718610;
 //BA.debugLineNum = 4718610;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("74718610",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=4718612;
 //BA.debugLineNum = 4718612;BA.debugLine="End Sub";
return "";
}
public static String  _create_grid_of_buttons() throws Exception{
RDebugUtils.currentModule="test_ui";
if (Debug.shouldDelegate(ba, "create_grid_of_buttons", false))
	 {return ((String) Debug.delegate(ba, "create_grid_of_buttons", null));}
int _num_of_columns = 0;
int _num_of_rows = 0;
int _gap = 0;
int _border = 0;
int _width = 0;
int _height = 0;
int _btn_width = 0;
int _btn_height = 0;
int _btn_count = 0;
int _y = 0;
int _x = 0;
anywheresoftware.b4j.objects.ButtonWrapper _btn = null;
String _key = "";
String _value = "";
int _xpos = 0;
int _ypos = 0;
RDebugUtils.currentLine=4587520;
 //BA.debugLineNum = 4587520;BA.debugLine="Private Sub Create_Grid_of_Buttons";
RDebugUtils.currentLine=4587521;
 //BA.debugLineNum = 4587521;BA.debugLine="Dim num_of_columns As Int = 4";
_num_of_columns = (int) (4);
RDebugUtils.currentLine=4587522;
 //BA.debugLineNum = 4587522;BA.debugLine="Dim num_of_rows As Int = 6";
_num_of_rows = (int) (6);
RDebugUtils.currentLine=4587523;
 //BA.debugLineNum = 4587523;BA.debugLine="pane_API_call_buttons.RemoveAllNodes";
_pane_api_call_buttons.RemoveAllNodes();
RDebugUtils.currentLine=4587524;
 //BA.debugLineNum = 4587524;BA.debugLine="Dim gap As Int = 2";
_gap = (int) (2);
RDebugUtils.currentLine=4587525;
 //BA.debugLineNum = 4587525;BA.debugLine="Dim border As Int = 10";
_border = (int) (10);
RDebugUtils.currentLine=4587526;
 //BA.debugLineNum = 4587526;BA.debugLine="Dim width As Int = pane_API_call_buttons.PrefWidt";
_width = (int) (_pane_api_call_buttons.getPrefWidth()-(_border*2)-(_num_of_columns-1));
RDebugUtils.currentLine=4587527;
 //BA.debugLineNum = 4587527;BA.debugLine="Dim height As Int = pane_API_call_buttons.PrefHei";
_height = (int) (_pane_api_call_buttons.getPrefHeight()-(_border*2)-(_num_of_rows-1));
RDebugUtils.currentLine=4587528;
 //BA.debugLineNum = 4587528;BA.debugLine="Dim btn_width As Int = (width) / num_of_columns";
_btn_width = (int) ((_width)/(double)_num_of_columns);
RDebugUtils.currentLine=4587529;
 //BA.debugLineNum = 4587529;BA.debugLine="Dim btn_height As Int = (height) / num_of_rows";
_btn_height = (int) ((_height)/(double)_num_of_rows);
RDebugUtils.currentLine=4587530;
 //BA.debugLineNum = 4587530;BA.debugLine="Dim btn_count As Int";
_btn_count = 0;
RDebugUtils.currentLine=4587531;
 //BA.debugLineNum = 4587531;BA.debugLine="For y = 0 To num_of_rows -1";
{
final int step11 = 1;
final int limit11 = (int) (_num_of_rows-1);
_y = (int) (0) ;
for (;_y <= limit11 ;_y = _y + step11 ) {
RDebugUtils.currentLine=4587532;
 //BA.debugLineNum = 4587532;BA.debugLine="For x = 0 To num_of_columns -1";
{
final int step12 = 1;
final int limit12 = (int) (_num_of_columns-1);
_x = (int) (0) ;
for (;_x <= limit12 ;_x = _x + step12 ) {
RDebugUtils.currentLine=4587533;
 //BA.debugLineNum = 4587533;BA.debugLine="If btn_count < API_Call_Map.Size Then";
if (_btn_count<_api_call_map.getSize()) { 
RDebugUtils.currentLine=4587534;
 //BA.debugLineNum = 4587534;BA.debugLine="Dim Btn As Button";
_btn = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=4587535;
 //BA.debugLineNum = 4587535;BA.debugLine="Btn.Initialize(\"btn\")";
_btn.Initialize(ba,"btn");
RDebugUtils.currentLine=4587536;
 //BA.debugLineNum = 4587536;BA.debugLine="Dim key, value As String";
_key = "";
_value = "";
RDebugUtils.currentLine=4587537;
 //BA.debugLineNum = 4587537;BA.debugLine="key = API_Call_Map.GetKeyAt(btn_count)";
_key = BA.ObjectToString(_api_call_map.GetKeyAt(_btn_count));
RDebugUtils.currentLine=4587538;
 //BA.debugLineNum = 4587538;BA.debugLine="value = API_Call_Map.GetValueAt(btn_count)";
_value = BA.ObjectToString(_api_call_map.GetValueAt(_btn_count));
RDebugUtils.currentLine=4587539;
 //BA.debugLineNum = 4587539;BA.debugLine="Btn.Text = key & CRLF & value";
_btn.setText(_key+anywheresoftware.b4a.keywords.Common.CRLF+_value);
RDebugUtils.currentLine=4587540;
 //BA.debugLineNum = 4587540;BA.debugLine="Btn.WrapText = True";
_btn.setWrapText(anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=4587541;
 //BA.debugLineNum = 4587541;BA.debugLine="Btn.Tag = key";
_btn.setTag((Object)(_key));
RDebugUtils.currentLine=4587542;
 //BA.debugLineNum = 4587542;BA.debugLine="Dim xpos As Int = x * (btn_width + gap) + bord";
_xpos = (int) (_x*(_btn_width+_gap)+_border);
RDebugUtils.currentLine=4587543;
 //BA.debugLineNum = 4587543;BA.debugLine="Dim ypos As Int = y * (btn_height + gap) + bor";
_ypos = (int) (_y*(_btn_height+_gap)+_border);
RDebugUtils.currentLine=4587545;
 //BA.debugLineNum = 4587545;BA.debugLine="If value.Contains(\"Private\") Then";
if (_value.contains("Private")) { 
RDebugUtils.currentLine=4587546;
 //BA.debugLineNum = 4587546;BA.debugLine="CSSUtils.SetStyleProperty(Btn, \"-fx-backgroun";
_cssutils._setstyleproperty((anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper(), (javafx.scene.Node)(_btn.getObject())),"-fx-background-color","linear-gradient(#7F3FBF, #592E84)");
RDebugUtils.currentLine=4587547;
 //BA.debugLineNum = 4587547;BA.debugLine="Btn.TextColor = fx.Colors.White";
_btn.setTextColor(_fx.Colors.White);
 };
RDebugUtils.currentLine=4587550;
 //BA.debugLineNum = 4587550;BA.debugLine="Btn.Enabled = False";
_btn.setEnabled(anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=4587551;
 //BA.debugLineNum = 4587551;BA.debugLine="If key.Contains(\"Test\") Or key.Contains(\"excha";
if (_key.contains("Test") || _key.contains("exchanges")) { 
_btn.setEnabled(anywheresoftware.b4a.keywords.Common.True);};
RDebugUtils.currentLine=4587552;
 //BA.debugLineNum = 4587552;BA.debugLine="If Main.Selected_Bot.IsInitialized And Main.Se";
if (_main._selected_bot /*b4j.example.main._trading_bot*/ .IsInitialized /*boolean*/  && _main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ .length()>0) { 
RDebugUtils.currentLine=4587553;
 //BA.debugLineNum = 4587553;BA.debugLine="If value.Contains(\"Single Coinpair\") = False";
if (_value.contains("Single Coinpair")==anywheresoftware.b4a.keywords.Common.False) { 
_btn.setEnabled(anywheresoftware.b4a.keywords.Common.True);};
 };
RDebugUtils.currentLine=4587555;
 //BA.debugLineNum = 4587555;BA.debugLine="If Main.Selected_Coinpair.Length > 0 Then	Btn.";
if (_main._selected_coinpair /*String*/ .length()>0) { 
_btn.setEnabled(anywheresoftware.b4a.keywords.Common.True);};
RDebugUtils.currentLine=4587559;
 //BA.debugLineNum = 4587559;BA.debugLine="If key.Contains(\"create_market\") Then Btn.Enab";
if (_key.contains("create_market")) { 
_btn.setEnabled(anywheresoftware.b4a.keywords.Common.False);};
RDebugUtils.currentLine=4587560;
 //BA.debugLineNum = 4587560;BA.debugLine="pane_API_call_buttons.AddNode(Btn, xpos, ypos,";
_pane_api_call_buttons.AddNode((javafx.scene.Node)(_btn.getObject()),_xpos,_ypos,_btn_width,_btn_height);
RDebugUtils.currentLine=4587561;
 //BA.debugLineNum = 4587561;BA.debugLine="btn_count = btn_count + 1";
_btn_count = (int) (_btn_count+1);
 };
 }
};
 }
};
RDebugUtils.currentLine=4587565;
 //BA.debugLineNum = 4587565;BA.debugLine="End Sub";
return "";
}
public static String  _cmb_coinpair_selectedindexchanged(int _index,Object _value) throws Exception{
RDebugUtils.currentModule="test_ui";
if (Debug.shouldDelegate(ba, "cmb_coinpair_selectedindexchanged", false))
	 {return ((String) Debug.delegate(ba, "cmb_coinpair_selectedindexchanged", new Object[] {_index,_value}));}
RDebugUtils.currentLine=4849664;
 //BA.debugLineNum = 4849664;BA.debugLine="Sub cmb_Coinpair_SelectedIndexChanged(Index As Int";
RDebugUtils.currentLine=4849665;
 //BA.debugLineNum = 4849665;BA.debugLine="Log(\"Sub: cmb_Coinpair_SelectedIndexChanged(\" & V";
anywheresoftware.b4a.keywords.Common.LogImpl("74849665","Sub: cmb_Coinpair_SelectedIndexChanged("+BA.ObjectToString(_value)+")",0);
RDebugUtils.currentLine=4849666;
 //BA.debugLineNum = 4849666;BA.debugLine="Try";
try {RDebugUtils.currentLine=4849668;
 //BA.debugLineNum = 4849668;BA.debugLine="Select Value";
switch (BA.switchObjectToInt(_value,(Object)("Get Markets"))) {
case 0: {
RDebugUtils.currentLine=4849670;
 //BA.debugLineNum = 4849670;BA.debugLine="ccxt.Markets";
_ccxt._markets /*String*/ ();
 break; }
default: {
RDebugUtils.currentLine=4849672;
 //BA.debugLineNum = 4849672;BA.debugLine="Main.Selected_Coinpair = Value";
_main._selected_coinpair /*String*/  = BA.ObjectToString(_value);
 break; }
}
;
RDebugUtils.currentLine=4849674;
 //BA.debugLineNum = 4849674;BA.debugLine="Create_Grid_of_Buttons";
_create_grid_of_buttons();
 } 
       catch (Exception e11) {
			ba.setLastException(e11);RDebugUtils.currentLine=4849677;
 //BA.debugLineNum = 4849677;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("74849677",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=4849679;
 //BA.debugLineNum = 4849679;BA.debugLine="End Sub";
return "";
}
public static String  _cmb_scoin_selectedindexchanged(int _index,Object _value) throws Exception{
RDebugUtils.currentModule="test_ui";
if (Debug.shouldDelegate(ba, "cmb_scoin_selectedindexchanged", false))
	 {return ((String) Debug.delegate(ba, "cmb_scoin_selectedindexchanged", new Object[] {_index,_value}));}
String _coinpair = "";
String _scoin = "";
int _i = 0;
RDebugUtils.currentLine=4784128;
 //BA.debugLineNum = 4784128;BA.debugLine="Sub cmb_Scoin_SelectedIndexChanged(Index As Int, V";
RDebugUtils.currentLine=4784129;
 //BA.debugLineNum = 4784129;BA.debugLine="Log(\"Sub: cmb_Coinpair_SelectedIndexChanged(\" & V";
anywheresoftware.b4a.keywords.Common.LogImpl("74784129","Sub: cmb_Coinpair_SelectedIndexChanged("+BA.ObjectToString(_value)+")",0);
RDebugUtils.currentLine=4784130;
 //BA.debugLineNum = 4784130;BA.debugLine="Try";
try {RDebugUtils.currentLine=4784132;
 //BA.debugLineNum = 4784132;BA.debugLine="Select Value";
switch (BA.switchObjectToInt(_value,(Object)("Get Markets"))) {
case 0: {
RDebugUtils.currentLine=4784134;
 //BA.debugLineNum = 4784134;BA.debugLine="ccxt.Markets";
_ccxt._markets /*String*/ ();
 break; }
default: {
RDebugUtils.currentLine=4784136;
 //BA.debugLineNum = 4784136;BA.debugLine="Main.Selected_Scoin = Value";
_main._selected_scoin /*String*/  = BA.ObjectToString(_value);
RDebugUtils.currentLine=4784139;
 //BA.debugLineNum = 4784139;BA.debugLine="cmb_Coinpair.Items.Clear";
_cmb_coinpair.getItems().Clear();
RDebugUtils.currentLine=4784140;
 //BA.debugLineNum = 4784140;BA.debugLine="Dim coinpair As String";
_coinpair = "";
RDebugUtils.currentLine=4784141;
 //BA.debugLineNum = 4784141;BA.debugLine="Dim scoin As String";
_scoin = "";
RDebugUtils.currentLine=4784142;
 //BA.debugLineNum = 4784142;BA.debugLine="ccxt.Coinpair_List.Sort(True)";
_ccxt._coinpair_list /*anywheresoftware.b4a.objects.collections.List*/ .Sort(anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=4784143;
 //BA.debugLineNum = 4784143;BA.debugLine="For i = 0 To ccxt.Coinpair_List.Size-1";
{
final int step12 = 1;
final int limit12 = (int) (_ccxt._coinpair_list /*anywheresoftware.b4a.objects.collections.List*/ .getSize()-1);
_i = (int) (0) ;
for (;_i <= limit12 ;_i = _i + step12 ) {
RDebugUtils.currentLine=4784144;
 //BA.debugLineNum = 4784144;BA.debugLine="coinpair = ccxt.Coinpair_List.Get(i)";
_coinpair = BA.ObjectToString(_ccxt._coinpair_list /*anywheresoftware.b4a.objects.collections.List*/ .Get(_i));
RDebugUtils.currentLine=4784145;
 //BA.debugLineNum = 4784145;BA.debugLine="scoin = Calc.Get_Scoin(coinpair)";
_scoin = _calc._get_scoin /*String*/ (_coinpair);
RDebugUtils.currentLine=4784146;
 //BA.debugLineNum = 4784146;BA.debugLine="If scoin = Main.Selected_Scoin Then cmb_Coinp";
if ((_scoin).equals(_main._selected_scoin /*String*/ )) { 
_cmb_coinpair.getItems().Add((Object)(_coinpair));};
 }
};
 break; }
}
;
 } 
       catch (Exception e19) {
			ba.setLastException(e19);RDebugUtils.currentLine=4784152;
 //BA.debugLineNum = 4784152;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("74784152",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=4784154;
 //BA.debugLineNum = 4784154;BA.debugLine="End Sub";
return "";
}
public static String  _create_list_of_api_calls() throws Exception{
RDebugUtils.currentModule="test_ui";
if (Debug.shouldDelegate(ba, "create_list_of_api_calls", false))
	 {return ((String) Debug.delegate(ba, "create_list_of_api_calls", null));}
RDebugUtils.currentLine=4521984;
 //BA.debugLineNum = 4521984;BA.debugLine="Private Sub Create_List_of_API_Calls";
RDebugUtils.currentLine=4521985;
 //BA.debugLineNum = 4521985;BA.debugLine="API_Call_Map.Initialize";
_api_call_map.Initialize();
RDebugUtils.currentLine=4521986;
 //BA.debugLineNum = 4521986;BA.debugLine="API_Call_Map.Put(\"Test_PHP\", \"See if _Bot_Templat";
_api_call_map.Put((Object)("Test_PHP"),(Object)("See if _Bot_Template can"+anywheresoftware.b4a.keywords.Common.CRLF+"communicate with API_call.php"));
RDebugUtils.currentLine=4521987;
 //BA.debugLineNum = 4521987;BA.debugLine="API_Call_Map.Put(\"Test_CCXT\", \"gets ccxt version\"";
_api_call_map.Put((Object)("Test_CCXT"),(Object)("gets ccxt version"));
RDebugUtils.currentLine=4521988;
 //BA.debugLineNum = 4521988;BA.debugLine="API_Call_Map.Put(\"exchanges\", \"Public Call\" & CRL";
_api_call_map.Put((Object)("exchanges"),(Object)("Public Call"+anywheresoftware.b4a.keywords.Common.CRLF+"get a list of ccxt supported exchanges"));
RDebugUtils.currentLine=4521989;
 //BA.debugLineNum = 4521989;BA.debugLine="API_Call_Map.Put(\"exchange_info\", \"Public Call\")";
_api_call_map.Put((Object)("exchange_info"),(Object)("Public Call"));
RDebugUtils.currentLine=4521990;
 //BA.debugLineNum = 4521990;BA.debugLine="API_Call_Map.Put(\"fetch_markets\", \"Public Call\" &";
_api_call_map.Put((Object)("fetch_markets"),(Object)("Public Call"+anywheresoftware.b4a.keywords.Common.CRLF+"returns All Coinpairs"));
RDebugUtils.currentLine=4521991;
 //BA.debugLineNum = 4521991;BA.debugLine="API_Call_Map.Put(\"fetch_ticker\", \"Public Call\" &";
_api_call_map.Put((Object)("fetch_ticker"),(Object)("Public Call"+anywheresoftware.b4a.keywords.Common.CRLF+"Single Coinpair"));
RDebugUtils.currentLine=4521992;
 //BA.debugLineNum = 4521992;BA.debugLine="API_Call_Map.Put(\"fetch_tickers\", \"Public Call,\"";
_api_call_map.Put((Object)("fetch_tickers"),(Object)("Public Call,"+anywheresoftware.b4a.keywords.Common.CRLF+"Doesn't work with all Exchanges"+anywheresoftware.b4a.keywords.Common.CRLF+"All Coinpairs"));
RDebugUtils.currentLine=4521993;
 //BA.debugLineNum = 4521993;BA.debugLine="API_Call_Map.Put(\"fetch_l2_order_book\", \"Public C";
_api_call_map.Put((Object)("fetch_l2_order_book"),(Object)("Public Call"+anywheresoftware.b4a.keywords.Common.CRLF+"Single Coinpair"));
RDebugUtils.currentLine=4521994;
 //BA.debugLineNum = 4521994;BA.debugLine="API_Call_Map.Put(\"fetch_ohlcv\", \"Public Call\" & C";
_api_call_map.Put((Object)("fetch_ohlcv"),(Object)("Public Call"+anywheresoftware.b4a.keywords.Common.CRLF+"timeframe = 1d"+anywheresoftware.b4a.keywords.Common.CRLF+"Single Coinpair"));
RDebugUtils.currentLine=4521995;
 //BA.debugLineNum = 4521995;BA.debugLine="API_Call_Map.Put(\"fetch_trades\", \"Public Call\" &";
_api_call_map.Put((Object)("fetch_trades"),(Object)("Public Call"+anywheresoftware.b4a.keywords.Common.CRLF+"Single Coinpair"));
RDebugUtils.currentLine=4521996;
 //BA.debugLineNum = 4521996;BA.debugLine="API_Call_Map.Put(\"fetch_balance\", \"Private Call\"";
_api_call_map.Put((Object)("fetch_balance"),(Object)("Private Call"+anywheresoftware.b4a.keywords.Common.CRLF+"All Coinpairs"));
RDebugUtils.currentLine=4521997;
 //BA.debugLineNum = 4521997;BA.debugLine="API_Call_Map.Put(\"fetch_open_orders\", \"Private Ca";
_api_call_map.Put((Object)("fetch_open_orders"),(Object)("Private Call"+anywheresoftware.b4a.keywords.Common.CRLF+"Single Coinpair"));
RDebugUtils.currentLine=4521998;
 //BA.debugLineNum = 4521998;BA.debugLine="API_Call_Map.Put(\"fetch_all_open_orders\", \"Privat";
_api_call_map.Put((Object)("fetch_all_open_orders"),(Object)("Private Call"+anywheresoftware.b4a.keywords.Common.CRLF+"Doesn't work with all Exchanges"+anywheresoftware.b4a.keywords.Common.CRLF+"All Coinpairs"));
RDebugUtils.currentLine=4521999;
 //BA.debugLineNum = 4521999;BA.debugLine="API_Call_Map.Put(\"fetch_my_trades\", \"Private Call";
_api_call_map.Put((Object)("fetch_my_trades"),(Object)("Private Call"+anywheresoftware.b4a.keywords.Common.CRLF+"Single Coinpair"));
RDebugUtils.currentLine=4522000;
 //BA.debugLineNum = 4522000;BA.debugLine="API_Call_Map.Put(\"fetch_all_my_trades\", \"Private";
_api_call_map.Put((Object)("fetch_all_my_trades"),(Object)("Private Call"+anywheresoftware.b4a.keywords.Common.CRLF+"Doesn't work with all Exchanges"+anywheresoftware.b4a.keywords.Common.CRLF+"All Coinpairs"));
RDebugUtils.currentLine=4522001;
 //BA.debugLineNum = 4522001;BA.debugLine="API_Call_Map.Put(\"create_limit_buy_order\", \"Priva";
_api_call_map.Put((Object)("create_limit_buy_order"),(Object)("Private Call"+anywheresoftware.b4a.keywords.Common.CRLF+"preset to Buy "+BA.NumberToString(_btc_buy_volume)+" BTC @ $"+BA.NumberToString(_btc_buy_price)+" = $"+BA.NumberToString(_btc_buy_total)));
RDebugUtils.currentLine=4522002;
 //BA.debugLineNum = 4522002;BA.debugLine="API_Call_Map.Put(\"create_limit_sell_order\", \"Priv";
_api_call_map.Put((Object)("create_limit_sell_order"),(Object)("Private Call"+anywheresoftware.b4a.keywords.Common.CRLF+"preset to Sell "+BA.NumberToString(_btc_sell_volume)+" BTC @ $"+BA.NumberToString(_btc_sell_price)+" = $"+BA.NumberToString(_btc_sell_total)));
RDebugUtils.currentLine=4522003;
 //BA.debugLineNum = 4522003;BA.debugLine="API_Call_Map.Put(\"edit_limit_order\", \"Private Cal";
_api_call_map.Put((Object)("edit_limit_order"),(Object)("Private Call"+anywheresoftware.b4a.keywords.Common.CRLF+"preset to Edit last Buy to "+BA.NumberToString(_btc_edit_buy_volume)+" BTC @ $"+BA.NumberToString(_btc_edit_buy_price)+" = $"+BA.NumberToString(_btc_edit_buy_total)));
RDebugUtils.currentLine=4522004;
 //BA.debugLineNum = 4522004;BA.debugLine="API_Call_Map.Put(\"cancel_order\", \"Private Call\" &";
_api_call_map.Put((Object)("cancel_order"),(Object)("Private Call"+anywheresoftware.b4a.keywords.Common.CRLF+"preset to Cancel last Sell Limit Order"));
RDebugUtils.currentLine=4522006;
 //BA.debugLineNum = 4522006;BA.debugLine="API_Call_Map.Put(\"cancel_all_orders\", \"Private Ca";
_api_call_map.Put((Object)("cancel_all_orders"),(Object)("Private Call"+anywheresoftware.b4a.keywords.Common.CRLF+"Cancels all open Orders"+anywheresoftware.b4a.keywords.Common.CRLF+"All Coinpairs"));
RDebugUtils.currentLine=4522007;
 //BA.debugLineNum = 4522007;BA.debugLine="API_Call_Map.Put(\"create_market_buy_order\", \"Priv";
_api_call_map.Put((Object)("create_market_buy_order"),(Object)("Private Call"+anywheresoftware.b4a.keywords.Common.CRLF+"will execute a trade"));
RDebugUtils.currentLine=4522008;
 //BA.debugLineNum = 4522008;BA.debugLine="API_Call_Map.Put(\"create_market_sell_order\", \"Pri";
_api_call_map.Put((Object)("create_market_sell_order"),(Object)("Private Call"+anywheresoftware.b4a.keywords.Common.CRLF+"will execute a trade"));
RDebugUtils.currentLine=4522009;
 //BA.debugLineNum = 4522009;BA.debugLine="Create_Grid_of_Buttons";
_create_grid_of_buttons();
RDebugUtils.currentLine=4522010;
 //BA.debugLineNum = 4522010;BA.debugLine="End Sub";
return "";
}
}