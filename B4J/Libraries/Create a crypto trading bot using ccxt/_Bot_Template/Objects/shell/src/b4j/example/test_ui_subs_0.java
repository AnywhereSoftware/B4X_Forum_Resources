package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class test_ui_subs_0 {


public static RemoteObject  _btn_click() throws Exception{
try {
		Debug.PushSubsStack("btn_Click (test_ui) ","test_ui",3,test_ui.ba,test_ui.mostCurrent,110);
if (RapidSub.canDelegate("btn_click")) { return b4j.example.test_ui.remoteMe.runUserSub(false, "test_ui","btn_click");}
RemoteObject _btn = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
RemoteObject _last_buy_order = RemoteObject.declareNull("b4j.example.calc._order");
int _i = 0;
RemoteObject _this_order = RemoteObject.declareNull("b4j.example.calc._order");
RemoteObject _last_sell_order = RemoteObject.declareNull("b4j.example.calc._order");
 BA.debugLineNum = 110;BA.debugLine="Sub btn_Click										'default calls for the exam";
Debug.ShouldStop(8192);
 BA.debugLineNum = 111;BA.debugLine="Dim btn As Button = Sender";
Debug.ShouldStop(16384);
_btn = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");
_btn = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.ButtonWrapper"), test_ui.__c.runMethod(false,"Sender",test_ui.ba));Debug.locals.put("btn", _btn);Debug.locals.put("btn", _btn);
 BA.debugLineNum = 112;BA.debugLine="Select btn.Tag";
Debug.ShouldStop(32768);
switch (BA.switchObjectToInt(_btn.runMethod(false,"getTag"),RemoteObject.createImmutable(("Test_PHP")),RemoteObject.createImmutable(("Test_CCXT")),RemoteObject.createImmutable(("exchanges")),RemoteObject.createImmutable(("exchange_info")),RemoteObject.createImmutable(("fetch_markets")),RemoteObject.createImmutable(("fetch_ticker")),RemoteObject.createImmutable(("fetch_tickers")),RemoteObject.createImmutable(("fetch_l2_order_book")),RemoteObject.createImmutable(("fetch_ohlcv")),RemoteObject.createImmutable(("fetch_trades")),RemoteObject.createImmutable(("fetch_balance")),RemoteObject.createImmutable(("fetch_open_orders")),RemoteObject.createImmutable(("fetch_all_open_orders")),RemoteObject.createImmutable(("fetch_my_trades")),RemoteObject.createImmutable(("fetch_all_my_trades")),RemoteObject.createImmutable(("create_limit_buy_order")),RemoteObject.createImmutable(("create_limit_sell_order")),RemoteObject.createImmutable(("edit_limit_order")),RemoteObject.createImmutable(("cancel_order")),RemoteObject.createImmutable(("cancel_all_orders")),RemoteObject.createImmutable(("create_market_buy_order")),RemoteObject.createImmutable(("create_market_sell_order")))) {
case 0: {
 BA.debugLineNum = 113;BA.debugLine="Case \"Test_PHP\" : ccxt.Test_PHP";
Debug.ShouldStop(65536);
test_ui._ccxt.runVoidMethod ("_test_php" /*RemoteObject*/ );
 break; }
case 1: {
 BA.debugLineNum = 114;BA.debugLine="Case \"Test_CCXT\" : ccxt.Test_CCXT";
Debug.ShouldStop(131072);
test_ui._ccxt.runVoidMethod ("_test_ccxt" /*RemoteObject*/ );
 break; }
case 2: {
 BA.debugLineNum = 115;BA.debugLine="Case \"exchanges\" : 	ccxt.Exchanges";
Debug.ShouldStop(262144);
test_ui._ccxt.runVoidMethod ("_exchanges" /*RemoteObject*/ );
 break; }
case 3: {
 BA.debugLineNum = 116;BA.debugLine="Case \"exchange_info\" : ccxt.Exchange_Info";
Debug.ShouldStop(524288);
test_ui._ccxt.runVoidMethod ("_exchange_info" /*RemoteObject*/ );
 break; }
case 4: {
 BA.debugLineNum = 117;BA.debugLine="Case \"fetch_markets\" : ccxt.Markets";
Debug.ShouldStop(1048576);
test_ui._ccxt.runVoidMethod ("_markets" /*RemoteObject*/ );
 break; }
case 5: {
 BA.debugLineNum = 118;BA.debugLine="Case \"fetch_ticker\" : 	ccxt.Ticker(Main.Selected";
Debug.ShouldStop(2097152);
test_ui._ccxt.runVoidMethod ("_ticker" /*RemoteObject*/ ,(Object)(test_ui._main._selected_coinpair /*RemoteObject*/ ));
 break; }
case 6: {
 BA.debugLineNum = 119;BA.debugLine="Case \"fetch_tickers\" : ccxt.All_Tickers";
Debug.ShouldStop(4194304);
test_ui._ccxt.runVoidMethod ("_all_tickers" /*RemoteObject*/ );
 break; }
case 7: {
 BA.debugLineNum = 120;BA.debugLine="Case \"fetch_l2_order_book\" : ccxt.OrderBook(Main";
Debug.ShouldStop(8388608);
test_ui._ccxt.runVoidMethod ("_orderbook" /*RemoteObject*/ ,(Object)(test_ui._main._selected_coinpair /*RemoteObject*/ ),(Object)(BA.numberCast(int.class, 50)));
 break; }
case 8: {
 BA.debugLineNum = 121;BA.debugLine="Case \"fetch_ohlcv\" : ccxt.OHLCV(Main.Selected_Co";
Debug.ShouldStop(16777216);
test_ui._ccxt.runVoidMethod ("_ohlcv" /*RemoteObject*/ ,(Object)(test_ui._main._selected_coinpair /*RemoteObject*/ ),(Object)(RemoteObject.createImmutable("1d")));
 break; }
case 9: {
 BA.debugLineNum = 122;BA.debugLine="Case \"fetch_trades\" : ccxt.Public_Trade_History(";
Debug.ShouldStop(33554432);
test_ui._ccxt.runVoidMethod ("_public_trade_history" /*RemoteObject*/ ,(Object)(test_ui._main._selected_coinpair /*RemoteObject*/ ),(Object)(BA.numberCast(int.class, 50)));
 break; }
case 10: {
 BA.debugLineNum = 123;BA.debugLine="Case \"fetch_balance\" : ccxt.My_Balances";
Debug.ShouldStop(67108864);
test_ui._ccxt.runVoidMethod ("_my_balances" /*RemoteObject*/ );
 break; }
case 11: {
 BA.debugLineNum = 124;BA.debugLine="Case \"fetch_open_orders\" : ccxt.My_Open_Orders(M";
Debug.ShouldStop(134217728);
test_ui._ccxt.runVoidMethod ("_my_open_orders" /*RemoteObject*/ ,(Object)(test_ui._main._selected_coinpair /*RemoteObject*/ ));
 break; }
case 12: {
 BA.debugLineNum = 125;BA.debugLine="Case \"fetch_all_open_orders\" : ccxt.All_My_Open_";
Debug.ShouldStop(268435456);
test_ui._ccxt.runVoidMethod ("_all_my_open_orders" /*RemoteObject*/ );
 break; }
case 13: {
 BA.debugLineNum = 126;BA.debugLine="Case \"fetch_my_trades\" : ccxt.My_Trade_History(M";
Debug.ShouldStop(536870912);
test_ui._ccxt.runVoidMethod ("_my_trade_history" /*RemoteObject*/ ,(Object)(test_ui._main._selected_coinpair /*RemoteObject*/ ),(Object)(BA.numberCast(long.class, 0)),(Object)(BA.numberCast(int.class, 50)));
 break; }
case 14: {
 BA.debugLineNum = 127;BA.debugLine="Case \"fetch_all_my_trades\" : ccxt.All_My_Trade_H";
Debug.ShouldStop(1073741824);
test_ui._ccxt.runVoidMethod ("_all_my_trade_history" /*RemoteObject*/ ,(Object)(BA.numberCast(long.class, 0)),(Object)(BA.numberCast(int.class, 200)));
 break; }
case 15: {
 BA.debugLineNum = 128;BA.debugLine="Case \"create_limit_buy_order\" : ccxt.Create_Limi";
Debug.ShouldStop(-2147483648);
test_ui._ccxt.runVoidMethod ("_create_limit_buy_order" /*RemoteObject*/ ,(Object)(BA.ObjectToString("BTC/USD")),(Object)(test_ui._btc_buy_price),(Object)(test_ui._btc_buy_volume));
 break; }
case 16: {
 BA.debugLineNum = 129;BA.debugLine="Case \"create_limit_sell_order\" : ccxt.Create_Lim";
Debug.ShouldStop(1);
test_ui._ccxt.runVoidMethod ("_create_limit_sell_order" /*RemoteObject*/ ,(Object)(BA.ObjectToString("BTC/USD")),(Object)(test_ui._btc_sell_price),(Object)(test_ui._btc_sell_volume));
 break; }
case 17: {
 BA.debugLineNum = 131;BA.debugLine="Dim last_buy_order As Order";
Debug.ShouldStop(4);
_last_buy_order = RemoteObject.createNew ("b4j.example.calc._order");Debug.locals.put("last_buy_order", _last_buy_order);
 BA.debugLineNum = 132;BA.debugLine="For i = 0 To Calc.All_My_Orders_List.Size-1";
Debug.ShouldStop(8);
{
final int step39 = 1;
final int limit39 = RemoteObject.solve(new RemoteObject[] {test_ui._calc._all_my_orders_list /*RemoteObject*/ .runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step39 > 0 && _i <= limit39) || (step39 < 0 && _i >= limit39) ;_i = ((int)(0 + _i + step39))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 133;BA.debugLine="Dim this_order As Order = Calc.All_My_Orders_L";
Debug.ShouldStop(16);
_this_order = (test_ui._calc._all_my_orders_list /*RemoteObject*/ .runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("this_order", _this_order);Debug.locals.put("this_order", _this_order);
 BA.debugLineNum = 134;BA.debugLine="If this_order.side = \"buy\" Then last_buy_order";
Debug.ShouldStop(32);
if (RemoteObject.solveBoolean("=",_this_order.getField(true,"side" /*RemoteObject*/ ),BA.ObjectToString("buy"))) { 
_last_buy_order = _this_order;Debug.locals.put("last_buy_order", _last_buy_order);};
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 136;BA.debugLine="ccxt.Edit_Limit_Order(last_buy_order.id, last_b";
Debug.ShouldStop(128);
test_ui._ccxt.runVoidMethod ("_edit_limit_order" /*RemoteObject*/ ,(Object)(_last_buy_order.getField(true,"id" /*RemoteObject*/ )),(Object)(_last_buy_order.getField(true,"Coinpair" /*RemoteObject*/ )),(Object)(_last_buy_order.getField(true,"side" /*RemoteObject*/ )),(Object)(test_ui._btc_edit_buy_price),(Object)(test_ui._btc_edit_buy_volume));
 break; }
case 18: {
 BA.debugLineNum = 140;BA.debugLine="Dim last_sell_order As Order";
Debug.ShouldStop(2048);
_last_sell_order = RemoteObject.createNew ("b4j.example.calc._order");Debug.locals.put("last_sell_order", _last_sell_order);
 BA.debugLineNum = 141;BA.debugLine="For i = 0 To Calc.All_My_Orders_List.Size-1";
Debug.ShouldStop(4096);
{
final int step46 = 1;
final int limit46 = RemoteObject.solve(new RemoteObject[] {test_ui._calc._all_my_orders_list /*RemoteObject*/ .runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step46 > 0 && _i <= limit46) || (step46 < 0 && _i >= limit46) ;_i = ((int)(0 + _i + step46))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 142;BA.debugLine="Dim this_order As Order = Calc.All_My_Orders_L";
Debug.ShouldStop(8192);
_this_order = (test_ui._calc._all_my_orders_list /*RemoteObject*/ .runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("this_order", _this_order);Debug.locals.put("this_order", _this_order);
 BA.debugLineNum = 143;BA.debugLine="If this_order.side = \"sell\" Then last_sell_ord";
Debug.ShouldStop(16384);
if (RemoteObject.solveBoolean("=",_this_order.getField(true,"side" /*RemoteObject*/ ),BA.ObjectToString("sell"))) { 
_last_sell_order = _this_order;Debug.locals.put("last_sell_order", _last_sell_order);};
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 145;BA.debugLine="ccxt.Cancel_Order(last_sell_order.Coinpair, las";
Debug.ShouldStop(65536);
test_ui._ccxt.runVoidMethod ("_cancel_order" /*RemoteObject*/ ,(Object)(_last_sell_order.getField(true,"Coinpair" /*RemoteObject*/ )),(Object)(_last_sell_order.getField(true,"id" /*RemoteObject*/ )));
 break; }
case 19: {
 BA.debugLineNum = 148;BA.debugLine="Case \"cancel_all_orders\" : ccxt.cancel_all_order";
Debug.ShouldStop(524288);
test_ui._ccxt.runVoidMethod ("_cancel_all_orders" /*RemoteObject*/ );
 break; }
case 20: {
 break; }
case 21: {
 break; }
}
;
 BA.debugLineNum = 153;BA.debugLine="End Sub";
Debug.ShouldStop(16777216);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _btn_reset_click() throws Exception{
try {
		Debug.PushSubsStack("btn_Reset_Click (test_ui) ","test_ui",3,test_ui.ba,test_ui.mostCurrent,222);
if (RapidSub.canDelegate("btn_reset_click")) { return b4j.example.test_ui.remoteMe.runUserSub(false, "test_ui","btn_reset_click");}
 BA.debugLineNum = 222;BA.debugLine="Private Sub btn_Reset_Click";
Debug.ShouldStop(536870912);
 BA.debugLineNum = 223;BA.debugLine="cmb_Bot.SelectedIndex = -1 : Main.Selected_Bot.na";
Debug.ShouldStop(1073741824);
test_ui._cmb_bot.runMethod(true,"setSelectedIndex",BA.numberCast(int.class, -(double) (0 + 1)));
 BA.debugLineNum = 223;BA.debugLine="cmb_Bot.SelectedIndex = -1 : Main.Selected_Bot.na";
Debug.ShouldStop(1073741824);
test_ui._main._selected_bot /*RemoteObject*/ .setField ("name" /*RemoteObject*/ ,BA.ObjectToString(""));
 BA.debugLineNum = 224;BA.debugLine="Reset_Stuff";
Debug.ShouldStop(-2147483648);
_reset_stuff();
 BA.debugLineNum = 225;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _cmb_bot_selectedindexchanged(RemoteObject _index,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("cmb_Bot_SelectedIndexChanged (test_ui) ","test_ui",3,test_ui.ba,test_ui.mostCurrent,155);
if (RapidSub.canDelegate("cmb_bot_selectedindexchanged")) { return b4j.example.test_ui.remoteMe.runUserSub(false, "test_ui","cmb_bot_selectedindexchanged", _index, _value);}
RemoteObject _this_bot = RemoteObject.declareNull("b4j.example.main._trading_bot");
int _i = 0;
Debug.locals.put("Index", _index);
Debug.locals.put("Value", _value);
 BA.debugLineNum = 155;BA.debugLine="Sub cmb_Bot_SelectedIndexChanged(Index As Int, Val";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 156;BA.debugLine="Log(\"Sub: cmb_Exchange_SelectedIndexChanged(\" & V";
Debug.ShouldStop(134217728);
test_ui.__c.runVoidMethod ("LogImpl","74718593",RemoteObject.concat(RemoteObject.createImmutable("Sub: cmb_Exchange_SelectedIndexChanged("),_value,RemoteObject.createImmutable(")")),0);
 BA.debugLineNum = 157;BA.debugLine="Try";
Debug.ShouldStop(268435456);
try { BA.debugLineNum = 158;BA.debugLine="Reset_Stuff";
Debug.ShouldStop(536870912);
_reset_stuff();
 BA.debugLineNum = 160;BA.debugLine="Dim this_bot As Trading_Bot";
Debug.ShouldStop(-2147483648);
_this_bot = RemoteObject.createNew ("b4j.example.main._trading_bot");Debug.locals.put("this_bot", _this_bot);
 BA.debugLineNum = 161;BA.debugLine="For i = 0 To Main.Bot_List.Size-1				'look for t";
Debug.ShouldStop(1);
{
final int step5 = 1;
final int limit5 = RemoteObject.solve(new RemoteObject[] {test_ui._main._bot_list /*RemoteObject*/ .runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step5 > 0 && _i <= limit5) || (step5 < 0 && _i >= limit5) ;_i = ((int)(0 + _i + step5))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 162;BA.debugLine="this_bot = Main.Bot_List.Get(i)";
Debug.ShouldStop(2);
_this_bot = (test_ui._main._bot_list /*RemoteObject*/ .runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("this_bot", _this_bot);
 BA.debugLineNum = 163;BA.debugLine="If this_bot.name = Value Then		'found it";
Debug.ShouldStop(4);
if (RemoteObject.solveBoolean("=",_this_bot.getField(true,"name" /*RemoteObject*/ ),BA.ObjectToString(_value))) { 
 BA.debugLineNum = 165;BA.debugLine="Main.Selected_Bot.Initialize";
Debug.ShouldStop(16);
test_ui._main._selected_bot /*RemoteObject*/ .runVoidMethod ("Initialize");
 BA.debugLineNum = 166;BA.debugLine="Main.Selected_Bot = this_bot";
Debug.ShouldStop(32);
test_ui._main._selected_bot /*RemoteObject*/  = _this_bot;
 BA.debugLineNum = 167;BA.debugLine="lbl_Exchange.Text = Main.Selected_Bot.exchange";
Debug.ShouldStop(64);
test_ui._lbl_exchange.runMethod(true,"setText",test_ui._main._selected_bot /*RemoteObject*/ .getField(true,"exchange" /*RemoteObject*/ ));
 };
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 170;BA.debugLine="Create_Grid_of_Buttons";
Debug.ShouldStop(512);
_create_grid_of_buttons();
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e15) {
			BA.rdebugUtils.runVoidMethod("setLastException",test_ui.ba, e15.toString()); BA.debugLineNum = 173;BA.debugLine="Log(LastException)";
Debug.ShouldStop(4096);
test_ui.__c.runVoidMethod ("LogImpl","74718610",BA.ObjectToString(test_ui.__c.runMethod(false,"LastException",test_ui.ba)),0);
 };
 BA.debugLineNum = 175;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _cmb_coinpair_selectedindexchanged(RemoteObject _index,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("cmb_Coinpair_SelectedIndexChanged (test_ui) ","test_ui",3,test_ui.ba,test_ui.mostCurrent,205);
if (RapidSub.canDelegate("cmb_coinpair_selectedindexchanged")) { return b4j.example.test_ui.remoteMe.runUserSub(false, "test_ui","cmb_coinpair_selectedindexchanged", _index, _value);}
Debug.locals.put("Index", _index);
Debug.locals.put("Value", _value);
 BA.debugLineNum = 205;BA.debugLine="Sub cmb_Coinpair_SelectedIndexChanged(Index As Int";
Debug.ShouldStop(4096);
 BA.debugLineNum = 206;BA.debugLine="Log(\"Sub: cmb_Coinpair_SelectedIndexChanged(\" & V";
Debug.ShouldStop(8192);
test_ui.__c.runVoidMethod ("LogImpl","74849665",RemoteObject.concat(RemoteObject.createImmutable("Sub: cmb_Coinpair_SelectedIndexChanged("),_value,RemoteObject.createImmutable(")")),0);
 BA.debugLineNum = 207;BA.debugLine="Try";
Debug.ShouldStop(16384);
try { BA.debugLineNum = 209;BA.debugLine="Select Value";
Debug.ShouldStop(65536);
switch (BA.switchObjectToInt(_value,RemoteObject.createImmutable(("Get Markets")))) {
case 0: {
 BA.debugLineNum = 211;BA.debugLine="ccxt.Markets";
Debug.ShouldStop(262144);
test_ui._ccxt.runVoidMethod ("_markets" /*RemoteObject*/ );
 break; }
default: {
 BA.debugLineNum = 213;BA.debugLine="Main.Selected_Coinpair = Value";
Debug.ShouldStop(1048576);
test_ui._main._selected_coinpair /*RemoteObject*/  = BA.ObjectToString(_value);
 break; }
}
;
 BA.debugLineNum = 215;BA.debugLine="Create_Grid_of_Buttons";
Debug.ShouldStop(4194304);
_create_grid_of_buttons();
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e11) {
			BA.rdebugUtils.runVoidMethod("setLastException",test_ui.ba, e11.toString()); BA.debugLineNum = 218;BA.debugLine="Log(LastException)";
Debug.ShouldStop(33554432);
test_ui.__c.runVoidMethod ("LogImpl","74849677",BA.ObjectToString(test_ui.__c.runMethod(false,"LastException",test_ui.ba)),0);
 };
 BA.debugLineNum = 220;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _cmb_scoin_selectedindexchanged(RemoteObject _index,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("cmb_Scoin_SelectedIndexChanged (test_ui) ","test_ui",3,test_ui.ba,test_ui.mostCurrent,177);
if (RapidSub.canDelegate("cmb_scoin_selectedindexchanged")) { return b4j.example.test_ui.remoteMe.runUserSub(false, "test_ui","cmb_scoin_selectedindexchanged", _index, _value);}
RemoteObject _coinpair = RemoteObject.createImmutable("");
RemoteObject _scoin = RemoteObject.createImmutable("");
int _i = 0;
Debug.locals.put("Index", _index);
Debug.locals.put("Value", _value);
 BA.debugLineNum = 177;BA.debugLine="Sub cmb_Scoin_SelectedIndexChanged(Index As Int, V";
Debug.ShouldStop(65536);
 BA.debugLineNum = 178;BA.debugLine="Log(\"Sub: cmb_Coinpair_SelectedIndexChanged(\" & V";
Debug.ShouldStop(131072);
test_ui.__c.runVoidMethod ("LogImpl","74784129",RemoteObject.concat(RemoteObject.createImmutable("Sub: cmb_Coinpair_SelectedIndexChanged("),_value,RemoteObject.createImmutable(")")),0);
 BA.debugLineNum = 179;BA.debugLine="Try";
Debug.ShouldStop(262144);
try { BA.debugLineNum = 181;BA.debugLine="Select Value";
Debug.ShouldStop(1048576);
switch (BA.switchObjectToInt(_value,RemoteObject.createImmutable(("Get Markets")))) {
case 0: {
 BA.debugLineNum = 183;BA.debugLine="ccxt.Markets";
Debug.ShouldStop(4194304);
test_ui._ccxt.runVoidMethod ("_markets" /*RemoteObject*/ );
 break; }
default: {
 BA.debugLineNum = 185;BA.debugLine="Main.Selected_Scoin = Value";
Debug.ShouldStop(16777216);
test_ui._main._selected_scoin /*RemoteObject*/  = BA.ObjectToString(_value);
 BA.debugLineNum = 188;BA.debugLine="cmb_Coinpair.Items.Clear";
Debug.ShouldStop(134217728);
test_ui._cmb_coinpair.runMethod(false,"getItems").runVoidMethod ("Clear");
 BA.debugLineNum = 189;BA.debugLine="Dim coinpair As String";
Debug.ShouldStop(268435456);
_coinpair = RemoteObject.createImmutable("");Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 190;BA.debugLine="Dim scoin As String";
Debug.ShouldStop(536870912);
_scoin = RemoteObject.createImmutable("");Debug.locals.put("scoin", _scoin);
 BA.debugLineNum = 191;BA.debugLine="ccxt.Coinpair_List.Sort(True)";
Debug.ShouldStop(1073741824);
test_ui._ccxt._coinpair_list /*RemoteObject*/ .runVoidMethod ("Sort",(Object)(test_ui.__c.getField(true,"True")));
 BA.debugLineNum = 192;BA.debugLine="For i = 0 To ccxt.Coinpair_List.Size-1";
Debug.ShouldStop(-2147483648);
{
final int step12 = 1;
final int limit12 = RemoteObject.solve(new RemoteObject[] {test_ui._ccxt._coinpair_list /*RemoteObject*/ .runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step12 > 0 && _i <= limit12) || (step12 < 0 && _i >= limit12) ;_i = ((int)(0 + _i + step12))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 193;BA.debugLine="coinpair = ccxt.Coinpair_List.Get(i)";
Debug.ShouldStop(1);
_coinpair = BA.ObjectToString(test_ui._ccxt._coinpair_list /*RemoteObject*/ .runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 194;BA.debugLine="scoin = Calc.Get_Scoin(coinpair)";
Debug.ShouldStop(2);
_scoin = test_ui._calc.runMethod(true,"_get_scoin" /*RemoteObject*/ ,(Object)(_coinpair));Debug.locals.put("scoin", _scoin);
 BA.debugLineNum = 195;BA.debugLine="If scoin = Main.Selected_Scoin Then cmb_Coinp";
Debug.ShouldStop(4);
if (RemoteObject.solveBoolean("=",_scoin,test_ui._main._selected_scoin /*RemoteObject*/ )) { 
test_ui._cmb_coinpair.runMethod(false,"getItems").runVoidMethod ("Add",(Object)((_coinpair)));};
 }
}Debug.locals.put("i", _i);
;
 break; }
}
;
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e19) {
			BA.rdebugUtils.runVoidMethod("setLastException",test_ui.ba, e19.toString()); BA.debugLineNum = 201;BA.debugLine="Log(LastException)";
Debug.ShouldStop(256);
test_ui.__c.runVoidMethod ("LogImpl","74784152",BA.ObjectToString(test_ui.__c.runMethod(false,"LastException",test_ui.ba)),0);
 };
 BA.debugLineNum = 203;BA.debugLine="End Sub";
Debug.ShouldStop(1024);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _create_grid_of_buttons() throws Exception{
try {
		Debug.PushSubsStack("Create_Grid_of_Buttons (test_ui) ","test_ui",3,test_ui.ba,test_ui.mostCurrent,63);
if (RapidSub.canDelegate("create_grid_of_buttons")) { return b4j.example.test_ui.remoteMe.runUserSub(false, "test_ui","create_grid_of_buttons");}
RemoteObject _num_of_columns = RemoteObject.createImmutable(0);
RemoteObject _num_of_rows = RemoteObject.createImmutable(0);
RemoteObject _gap = RemoteObject.createImmutable(0);
RemoteObject _border = RemoteObject.createImmutable(0);
RemoteObject _width = RemoteObject.createImmutable(0);
RemoteObject _height = RemoteObject.createImmutable(0);
RemoteObject _btn_width = RemoteObject.createImmutable(0);
RemoteObject _btn_height = RemoteObject.createImmutable(0);
RemoteObject _btn_count = RemoteObject.createImmutable(0);
int _y = 0;
int _x = 0;
RemoteObject _btn = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
RemoteObject _key = RemoteObject.createImmutable("");
RemoteObject _value = RemoteObject.createImmutable("");
RemoteObject _xpos = RemoteObject.createImmutable(0);
RemoteObject _ypos = RemoteObject.createImmutable(0);
 BA.debugLineNum = 63;BA.debugLine="Private Sub Create_Grid_of_Buttons";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 64;BA.debugLine="Dim num_of_columns As Int = 4";
Debug.ShouldStop(-2147483648);
_num_of_columns = BA.numberCast(int.class, 4);Debug.locals.put("num_of_columns", _num_of_columns);Debug.locals.put("num_of_columns", _num_of_columns);
 BA.debugLineNum = 65;BA.debugLine="Dim num_of_rows As Int = 6";
Debug.ShouldStop(1);
_num_of_rows = BA.numberCast(int.class, 6);Debug.locals.put("num_of_rows", _num_of_rows);Debug.locals.put("num_of_rows", _num_of_rows);
 BA.debugLineNum = 66;BA.debugLine="pane_API_call_buttons.RemoveAllNodes";
Debug.ShouldStop(2);
test_ui._pane_api_call_buttons.runVoidMethod ("RemoveAllNodes");
 BA.debugLineNum = 67;BA.debugLine="Dim gap As Int = 2";
Debug.ShouldStop(4);
_gap = BA.numberCast(int.class, 2);Debug.locals.put("gap", _gap);Debug.locals.put("gap", _gap);
 BA.debugLineNum = 68;BA.debugLine="Dim border As Int = 10";
Debug.ShouldStop(8);
_border = BA.numberCast(int.class, 10);Debug.locals.put("border", _border);Debug.locals.put("border", _border);
 BA.debugLineNum = 69;BA.debugLine="Dim width As Int = pane_API_call_buttons.PrefWidt";
Debug.ShouldStop(16);
_width = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {test_ui._pane_api_call_buttons.runMethod(true,"getPrefWidth"),(RemoteObject.solve(new RemoteObject[] {_border,RemoteObject.createImmutable(2)}, "*",0, 1)),(RemoteObject.solve(new RemoteObject[] {_num_of_columns,RemoteObject.createImmutable(1)}, "-",1, 1))}, "--",2, 0));Debug.locals.put("width", _width);Debug.locals.put("width", _width);
 BA.debugLineNum = 70;BA.debugLine="Dim height As Int = pane_API_call_buttons.PrefHei";
Debug.ShouldStop(32);
_height = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {test_ui._pane_api_call_buttons.runMethod(true,"getPrefHeight"),(RemoteObject.solve(new RemoteObject[] {_border,RemoteObject.createImmutable(2)}, "*",0, 1)),(RemoteObject.solve(new RemoteObject[] {_num_of_rows,RemoteObject.createImmutable(1)}, "-",1, 1))}, "--",2, 0));Debug.locals.put("height", _height);Debug.locals.put("height", _height);
 BA.debugLineNum = 71;BA.debugLine="Dim btn_width As Int = (width) / num_of_columns";
Debug.ShouldStop(64);
_btn_width = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {(_width),_num_of_columns}, "/",0, 0));Debug.locals.put("btn_width", _btn_width);Debug.locals.put("btn_width", _btn_width);
 BA.debugLineNum = 72;BA.debugLine="Dim btn_height As Int = (height) / num_of_rows";
Debug.ShouldStop(128);
_btn_height = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {(_height),_num_of_rows}, "/",0, 0));Debug.locals.put("btn_height", _btn_height);Debug.locals.put("btn_height", _btn_height);
 BA.debugLineNum = 73;BA.debugLine="Dim btn_count As Int";
Debug.ShouldStop(256);
_btn_count = RemoteObject.createImmutable(0);Debug.locals.put("btn_count", _btn_count);
 BA.debugLineNum = 74;BA.debugLine="For y = 0 To num_of_rows -1";
Debug.ShouldStop(512);
{
final int step11 = 1;
final int limit11 = RemoteObject.solve(new RemoteObject[] {_num_of_rows,RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_y = 0 ;
for (;(step11 > 0 && _y <= limit11) || (step11 < 0 && _y >= limit11) ;_y = ((int)(0 + _y + step11))  ) {
Debug.locals.put("y", _y);
 BA.debugLineNum = 75;BA.debugLine="For x = 0 To num_of_columns -1";
Debug.ShouldStop(1024);
{
final int step12 = 1;
final int limit12 = RemoteObject.solve(new RemoteObject[] {_num_of_columns,RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_x = 0 ;
for (;(step12 > 0 && _x <= limit12) || (step12 < 0 && _x >= limit12) ;_x = ((int)(0 + _x + step12))  ) {
Debug.locals.put("x", _x);
 BA.debugLineNum = 76;BA.debugLine="If btn_count < API_Call_Map.Size Then";
Debug.ShouldStop(2048);
if (RemoteObject.solveBoolean("<",_btn_count,BA.numberCast(double.class, test_ui._api_call_map.runMethod(true,"getSize")))) { 
 BA.debugLineNum = 77;BA.debugLine="Dim Btn As Button";
Debug.ShouldStop(4096);
_btn = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");Debug.locals.put("Btn", _btn);
 BA.debugLineNum = 78;BA.debugLine="Btn.Initialize(\"btn\")";
Debug.ShouldStop(8192);
_btn.runVoidMethod ("Initialize",test_ui.ba,(Object)(RemoteObject.createImmutable("btn")));
 BA.debugLineNum = 79;BA.debugLine="Dim key, value As String";
Debug.ShouldStop(16384);
_key = RemoteObject.createImmutable("");Debug.locals.put("key", _key);
_value = RemoteObject.createImmutable("");Debug.locals.put("value", _value);
 BA.debugLineNum = 80;BA.debugLine="key = API_Call_Map.GetKeyAt(btn_count)";
Debug.ShouldStop(32768);
_key = BA.ObjectToString(test_ui._api_call_map.runMethod(false,"GetKeyAt",(Object)(_btn_count)));Debug.locals.put("key", _key);
 BA.debugLineNum = 81;BA.debugLine="value = API_Call_Map.GetValueAt(btn_count)";
Debug.ShouldStop(65536);
_value = BA.ObjectToString(test_ui._api_call_map.runMethod(false,"GetValueAt",(Object)(_btn_count)));Debug.locals.put("value", _value);
 BA.debugLineNum = 82;BA.debugLine="Btn.Text = key & CRLF & value";
Debug.ShouldStop(131072);
_btn.runMethod(true,"setText",RemoteObject.concat(_key,test_ui.__c.getField(true,"CRLF"),_value));
 BA.debugLineNum = 83;BA.debugLine="Btn.WrapText = True";
Debug.ShouldStop(262144);
_btn.runMethod(true,"setWrapText",test_ui.__c.getField(true,"True"));
 BA.debugLineNum = 84;BA.debugLine="Btn.Tag = key";
Debug.ShouldStop(524288);
_btn.runMethod(false,"setTag",(_key));
 BA.debugLineNum = 85;BA.debugLine="Dim xpos As Int = x * (btn_width + gap) + bord";
Debug.ShouldStop(1048576);
_xpos = RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_x),(RemoteObject.solve(new RemoteObject[] {_btn_width,_gap}, "+",1, 1)),_border}, "*+",1, 1);Debug.locals.put("xpos", _xpos);Debug.locals.put("xpos", _xpos);
 BA.debugLineNum = 86;BA.debugLine="Dim ypos As Int = y * (btn_height + gap) + bor";
Debug.ShouldStop(2097152);
_ypos = RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_y),(RemoteObject.solve(new RemoteObject[] {_btn_height,_gap}, "+",1, 1)),_border}, "*+",1, 1);Debug.locals.put("ypos", _ypos);Debug.locals.put("ypos", _ypos);
 BA.debugLineNum = 88;BA.debugLine="If value.Contains(\"Private\") Then";
Debug.ShouldStop(8388608);
if (_value.runMethod(true,"contains",(Object)(RemoteObject.createImmutable("Private"))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 89;BA.debugLine="CSSUtils.SetStyleProperty(Btn, \"-fx-backgroun";
Debug.ShouldStop(16777216);
test_ui._cssutils.runVoidMethod ("_setstyleproperty",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper"), _btn.getObject()),(Object)(BA.ObjectToString("-fx-background-color")),(Object)(RemoteObject.createImmutable("linear-gradient(#7F3FBF, #592E84)")));
 BA.debugLineNum = 90;BA.debugLine="Btn.TextColor = fx.Colors.White";
Debug.ShouldStop(33554432);
_btn.runMethod(false,"setTextColor",test_ui._fx.getField(false,"Colors").getField(false,"White"));
 };
 BA.debugLineNum = 93;BA.debugLine="Btn.Enabled = False";
Debug.ShouldStop(268435456);
_btn.runMethod(true,"setEnabled",test_ui.__c.getField(true,"False"));
 BA.debugLineNum = 94;BA.debugLine="If key.Contains(\"Test\") Or key.Contains(\"excha";
Debug.ShouldStop(536870912);
if (RemoteObject.solveBoolean(".",_key.runMethod(true,"contains",(Object)(RemoteObject.createImmutable("Test")))) || RemoteObject.solveBoolean(".",_key.runMethod(true,"contains",(Object)(RemoteObject.createImmutable("exchanges"))))) { 
_btn.runMethod(true,"setEnabled",test_ui.__c.getField(true,"True"));};
 BA.debugLineNum = 95;BA.debugLine="If Main.Selected_Bot.IsInitialized And Main.Se";
Debug.ShouldStop(1073741824);
if (RemoteObject.solveBoolean(".",test_ui._main._selected_bot /*RemoteObject*/ .getField(true,"IsInitialized" /*RemoteObject*/ )) && RemoteObject.solveBoolean(">",test_ui._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ).runMethod(true,"length"),BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 96;BA.debugLine="If value.Contains(\"Single Coinpair\") = False";
Debug.ShouldStop(-2147483648);
if (RemoteObject.solveBoolean("=",_value.runMethod(true,"contains",(Object)(RemoteObject.createImmutable("Single Coinpair"))),test_ui.__c.getField(true,"False"))) { 
_btn.runMethod(true,"setEnabled",test_ui.__c.getField(true,"True"));};
 };
 BA.debugLineNum = 98;BA.debugLine="If Main.Selected_Coinpair.Length > 0 Then	Btn.";
Debug.ShouldStop(2);
if (RemoteObject.solveBoolean(">",test_ui._main._selected_coinpair /*RemoteObject*/ .runMethod(true,"length"),BA.numberCast(double.class, 0))) { 
_btn.runMethod(true,"setEnabled",test_ui.__c.getField(true,"True"));};
 BA.debugLineNum = 102;BA.debugLine="If key.Contains(\"create_market\") Then Btn.Enab";
Debug.ShouldStop(32);
if (_key.runMethod(true,"contains",(Object)(RemoteObject.createImmutable("create_market"))).<Boolean>get().booleanValue()) { 
_btn.runMethod(true,"setEnabled",test_ui.__c.getField(true,"False"));};
 BA.debugLineNum = 103;BA.debugLine="pane_API_call_buttons.AddNode(Btn, xpos, ypos,";
Debug.ShouldStop(64);
test_ui._pane_api_call_buttons.runVoidMethod ("AddNode",(Object)((_btn.getObject())),(Object)(BA.numberCast(double.class, _xpos)),(Object)(BA.numberCast(double.class, _ypos)),(Object)(BA.numberCast(double.class, _btn_width)),(Object)(BA.numberCast(double.class, _btn_height)));
 BA.debugLineNum = 104;BA.debugLine="btn_count = btn_count + 1";
Debug.ShouldStop(128);
_btn_count = RemoteObject.solve(new RemoteObject[] {_btn_count,RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("btn_count", _btn_count);
 };
 }
}Debug.locals.put("x", _x);
;
 }
}Debug.locals.put("y", _y);
;
 BA.debugLineNum = 108;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _create_list_of_api_calls() throws Exception{
try {
		Debug.PushSubsStack("Create_List_of_API_Calls (test_ui) ","test_ui",3,test_ui.ba,test_ui.mostCurrent,35);
if (RapidSub.canDelegate("create_list_of_api_calls")) { return b4j.example.test_ui.remoteMe.runUserSub(false, "test_ui","create_list_of_api_calls");}
 BA.debugLineNum = 35;BA.debugLine="Private Sub Create_List_of_API_Calls";
Debug.ShouldStop(4);
 BA.debugLineNum = 36;BA.debugLine="API_Call_Map.Initialize";
Debug.ShouldStop(8);
test_ui._api_call_map.runVoidMethod ("Initialize");
 BA.debugLineNum = 37;BA.debugLine="API_Call_Map.Put(\"Test_PHP\", \"See if _Bot_Templat";
Debug.ShouldStop(16);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("Test_PHP"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("See if _Bot_Template can"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("communicate with API_call.php")))));
 BA.debugLineNum = 38;BA.debugLine="API_Call_Map.Put(\"Test_CCXT\", \"gets ccxt version\"";
Debug.ShouldStop(32);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("Test_CCXT"))),(Object)((RemoteObject.createImmutable("gets ccxt version"))));
 BA.debugLineNum = 39;BA.debugLine="API_Call_Map.Put(\"exchanges\", \"Public Call\" & CRL";
Debug.ShouldStop(64);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("exchanges"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Public Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("get a list of ccxt supported exchanges")))));
 BA.debugLineNum = 40;BA.debugLine="API_Call_Map.Put(\"exchange_info\", \"Public Call\")";
Debug.ShouldStop(128);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("exchange_info"))),(Object)((RemoteObject.createImmutable("Public Call"))));
 BA.debugLineNum = 41;BA.debugLine="API_Call_Map.Put(\"fetch_markets\", \"Public Call\" &";
Debug.ShouldStop(256);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("fetch_markets"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Public Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("returns All Coinpairs")))));
 BA.debugLineNum = 42;BA.debugLine="API_Call_Map.Put(\"fetch_ticker\", \"Public Call\" &";
Debug.ShouldStop(512);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("fetch_ticker"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Public Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("Single Coinpair")))));
 BA.debugLineNum = 43;BA.debugLine="API_Call_Map.Put(\"fetch_tickers\", \"Public Call,\"";
Debug.ShouldStop(1024);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("fetch_tickers"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Public Call,"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("Doesn't work with all Exchanges"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("All Coinpairs")))));
 BA.debugLineNum = 44;BA.debugLine="API_Call_Map.Put(\"fetch_l2_order_book\", \"Public C";
Debug.ShouldStop(2048);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("fetch_l2_order_book"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Public Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("Single Coinpair")))));
 BA.debugLineNum = 45;BA.debugLine="API_Call_Map.Put(\"fetch_ohlcv\", \"Public Call\" & C";
Debug.ShouldStop(4096);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("fetch_ohlcv"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Public Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("timeframe = 1d"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("Single Coinpair")))));
 BA.debugLineNum = 46;BA.debugLine="API_Call_Map.Put(\"fetch_trades\", \"Public Call\" &";
Debug.ShouldStop(8192);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("fetch_trades"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Public Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("Single Coinpair")))));
 BA.debugLineNum = 47;BA.debugLine="API_Call_Map.Put(\"fetch_balance\", \"Private Call\"";
Debug.ShouldStop(16384);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("fetch_balance"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Private Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("All Coinpairs")))));
 BA.debugLineNum = 48;BA.debugLine="API_Call_Map.Put(\"fetch_open_orders\", \"Private Ca";
Debug.ShouldStop(32768);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("fetch_open_orders"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Private Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("Single Coinpair")))));
 BA.debugLineNum = 49;BA.debugLine="API_Call_Map.Put(\"fetch_all_open_orders\", \"Privat";
Debug.ShouldStop(65536);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("fetch_all_open_orders"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Private Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("Doesn't work with all Exchanges"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("All Coinpairs")))));
 BA.debugLineNum = 50;BA.debugLine="API_Call_Map.Put(\"fetch_my_trades\", \"Private Call";
Debug.ShouldStop(131072);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("fetch_my_trades"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Private Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("Single Coinpair")))));
 BA.debugLineNum = 51;BA.debugLine="API_Call_Map.Put(\"fetch_all_my_trades\", \"Private";
Debug.ShouldStop(262144);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("fetch_all_my_trades"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Private Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("Doesn't work with all Exchanges"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("All Coinpairs")))));
 BA.debugLineNum = 52;BA.debugLine="API_Call_Map.Put(\"create_limit_buy_order\", \"Priva";
Debug.ShouldStop(524288);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("create_limit_buy_order"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Private Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("preset to Buy "),test_ui._btc_buy_volume,RemoteObject.createImmutable(" BTC @ $"),test_ui._btc_buy_price,RemoteObject.createImmutable(" = $"),test_ui._btc_buy_total))));
 BA.debugLineNum = 53;BA.debugLine="API_Call_Map.Put(\"create_limit_sell_order\", \"Priv";
Debug.ShouldStop(1048576);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("create_limit_sell_order"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Private Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("preset to Sell "),test_ui._btc_sell_volume,RemoteObject.createImmutable(" BTC @ $"),test_ui._btc_sell_price,RemoteObject.createImmutable(" = $"),test_ui._btc_sell_total))));
 BA.debugLineNum = 54;BA.debugLine="API_Call_Map.Put(\"edit_limit_order\", \"Private Cal";
Debug.ShouldStop(2097152);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("edit_limit_order"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Private Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("preset to Edit last Buy to "),test_ui._btc_edit_buy_volume,RemoteObject.createImmutable(" BTC @ $"),test_ui._btc_edit_buy_price,RemoteObject.createImmutable(" = $"),test_ui._btc_edit_buy_total))));
 BA.debugLineNum = 55;BA.debugLine="API_Call_Map.Put(\"cancel_order\", \"Private Call\" &";
Debug.ShouldStop(4194304);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("cancel_order"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Private Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("preset to Cancel last Sell Limit Order")))));
 BA.debugLineNum = 57;BA.debugLine="API_Call_Map.Put(\"cancel_all_orders\", \"Private Ca";
Debug.ShouldStop(16777216);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("cancel_all_orders"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Private Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("Cancels all open Orders"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("All Coinpairs")))));
 BA.debugLineNum = 58;BA.debugLine="API_Call_Map.Put(\"create_market_buy_order\", \"Priv";
Debug.ShouldStop(33554432);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("create_market_buy_order"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Private Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("will execute a trade")))));
 BA.debugLineNum = 59;BA.debugLine="API_Call_Map.Put(\"create_market_sell_order\", \"Pri";
Debug.ShouldStop(67108864);
test_ui._api_call_map.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("create_market_sell_order"))),(Object)((RemoteObject.concat(RemoteObject.createImmutable("Private Call"),test_ui.__c.getField(true,"CRLF"),RemoteObject.createImmutable("will execute a trade")))));
 BA.debugLineNum = 60;BA.debugLine="Create_Grid_of_Buttons";
Debug.ShouldStop(134217728);
_create_grid_of_buttons();
 BA.debugLineNum = 61;BA.debugLine="End Sub";
Debug.ShouldStop(268435456);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 4;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 5;BA.debugLine="Private fx As JFX";
test_ui._fx = RemoteObject.createNew ("anywheresoftware.b4j.objects.JFX");
 //BA.debugLineNum = 6;BA.debugLine="Private pane_API_call_buttons As Pane";
test_ui._pane_api_call_buttons = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
 //BA.debugLineNum = 7;BA.debugLine="Private btn_Reset As Button";
test_ui._btn_reset = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");
 //BA.debugLineNum = 8;BA.debugLine="Dim txt_Output As TextArea";
test_ui._txt_output = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextAreaWrapper");
 //BA.debugLineNum = 9;BA.debugLine="Dim cmb_Bot, cmb_Scoin, cmb_Coinpair As ComboBox";
test_ui._cmb_bot = RemoteObject.createNew ("anywheresoftware.b4j.objects.ComboBoxWrapper");
test_ui._cmb_scoin = RemoteObject.createNew ("anywheresoftware.b4j.objects.ComboBoxWrapper");
test_ui._cmb_coinpair = RemoteObject.createNew ("anywheresoftware.b4j.objects.ComboBoxWrapper");
 //BA.debugLineNum = 10;BA.debugLine="Dim lbl_Exchange, lbl_Open_Orders As Label";
test_ui._lbl_exchange = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");
test_ui._lbl_open_orders = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");
 //BA.debugLineNum = 11;BA.debugLine="Private xui As XUI";
test_ui._xui = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");
 //BA.debugLineNum = 12;BA.debugLine="Dim API_Call_Map As Map";
test_ui._api_call_map = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
 //BA.debugLineNum = 15;BA.debugLine="Dim btc_buy_price As Double = 10000				'in USD";
test_ui._btc_buy_price = BA.numberCast(double.class, 10000);
 //BA.debugLineNum = 16;BA.debugLine="Dim btc_buy_volume As Double = .002";
test_ui._btc_buy_volume = BA.numberCast(double.class, .002);
 //BA.debugLineNum = 17;BA.debugLine="Dim btc_buy_total As Double = btc_buy_price * btc";
test_ui._btc_buy_total = RemoteObject.solve(new RemoteObject[] {test_ui._btc_buy_price,test_ui._btc_buy_volume}, "*",0, 0);
 //BA.debugLineNum = 19;BA.debugLine="Dim btc_edit_buy_price As Double = 5000				'in US";
test_ui._btc_edit_buy_price = BA.numberCast(double.class, 5000);
 //BA.debugLineNum = 20;BA.debugLine="Dim btc_edit_buy_volume As Double = .002";
test_ui._btc_edit_buy_volume = BA.numberCast(double.class, .002);
 //BA.debugLineNum = 21;BA.debugLine="Dim btc_edit_buy_total As Double = btc_edit_buy_p";
test_ui._btc_edit_buy_total = RemoteObject.solve(new RemoteObject[] {test_ui._btc_edit_buy_price,test_ui._btc_edit_buy_volume}, "*",0, 0);
 //BA.debugLineNum = 23;BA.debugLine="Dim btc_sell_price As Double = 84000			'in USD";
test_ui._btc_sell_price = BA.numberCast(double.class, 84000);
 //BA.debugLineNum = 24;BA.debugLine="Dim btc_sell_volume As Double = .0002";
test_ui._btc_sell_volume = BA.numberCast(double.class, .0002);
 //BA.debugLineNum = 25;BA.debugLine="Dim btc_sell_total As Double = btc_sell_price * b";
test_ui._btc_sell_total = RemoteObject.solve(new RemoteObject[] {test_ui._btc_sell_price,test_ui._btc_sell_volume}, "*",0, 0);
 //BA.debugLineNum = 26;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _reset_stuff() throws Exception{
try {
		Debug.PushSubsStack("Reset_Stuff (test_ui) ","test_ui",3,test_ui.ba,test_ui.mostCurrent,227);
if (RapidSub.canDelegate("reset_stuff")) { return b4j.example.test_ui.remoteMe.runUserSub(false, "test_ui","reset_stuff");}
 BA.debugLineNum = 227;BA.debugLine="Private Sub Reset_Stuff";
Debug.ShouldStop(4);
 BA.debugLineNum = 228;BA.debugLine="cmb_Scoin.SelectedIndex = -1 : Main.Selected_Scoi";
Debug.ShouldStop(8);
test_ui._cmb_scoin.runMethod(true,"setSelectedIndex",BA.numberCast(int.class, -(double) (0 + 1)));
 BA.debugLineNum = 228;BA.debugLine="cmb_Scoin.SelectedIndex = -1 : Main.Selected_Scoi";
Debug.ShouldStop(8);
test_ui._main._selected_scoin /*RemoteObject*/  = BA.ObjectToString("");
 BA.debugLineNum = 229;BA.debugLine="cmb_Coinpair.SelectedIndex = -1 : Main.Selected_C";
Debug.ShouldStop(16);
test_ui._cmb_coinpair.runMethod(true,"setSelectedIndex",BA.numberCast(int.class, -(double) (0 + 1)));
 BA.debugLineNum = 229;BA.debugLine="cmb_Coinpair.SelectedIndex = -1 : Main.Selected_C";
Debug.ShouldStop(16);
test_ui._main._selected_coinpair /*RemoteObject*/  = BA.ObjectToString("");
 BA.debugLineNum = 230;BA.debugLine="lbl_Exchange.Text = \"\"";
Debug.ShouldStop(32);
test_ui._lbl_exchange.runMethod(true,"setText",BA.ObjectToString(""));
 BA.debugLineNum = 231;BA.debugLine="txt_Output.Text = \"\"";
Debug.ShouldStop(64);
test_ui._txt_output.runMethod(true,"setText",BA.ObjectToString(""));
 BA.debugLineNum = 232;BA.debugLine="Calc.All_My_Orders_List.Initialize";
Debug.ShouldStop(128);
test_ui._calc._all_my_orders_list /*RemoteObject*/ .runVoidMethod ("Initialize");
 BA.debugLineNum = 233;BA.debugLine="Calc.All_My_Trades_List.Initialize";
Debug.ShouldStop(256);
test_ui._calc._all_my_trades_list /*RemoteObject*/ .runVoidMethod ("Initialize");
 BA.debugLineNum = 234;BA.debugLine="lbl_Open_Orders.Text = Calc.All_My_Orders_List.Si";
Debug.ShouldStop(512);
test_ui._lbl_open_orders.runMethod(true,"setText",RemoteObject.concat(test_ui._calc._all_my_orders_list /*RemoteObject*/ .runMethod(true,"getSize"),RemoteObject.createImmutable(" open orders")));
 BA.debugLineNum = 235;BA.debugLine="Create_Grid_of_Buttons";
Debug.ShouldStop(1024);
_create_grid_of_buttons();
 BA.debugLineNum = 236;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _start() throws Exception{
try {
		Debug.PushSubsStack("Start (test_ui) ","test_ui",3,test_ui.ba,test_ui.mostCurrent,28);
if (RapidSub.canDelegate("start")) { return b4j.example.test_ui.remoteMe.runUserSub(false, "test_ui","start");}
 BA.debugLineNum = 28;BA.debugLine="Sub Start";
Debug.ShouldStop(134217728);
 BA.debugLineNum = 29;BA.debugLine="Main.MainForm.RootPane.LoadLayout(\"test\")";
Debug.ShouldStop(268435456);
test_ui._main._mainform /*RemoteObject*/ .runMethod(false,"getRootPane").runMethodAndSync(false,"LoadLayout",test_ui.ba,(Object)(RemoteObject.createImmutable("test")));
 BA.debugLineNum = 30;BA.debugLine="cmb_Scoin.Items.Add(\"Get Markets\")";
Debug.ShouldStop(536870912);
test_ui._cmb_scoin.runMethod(false,"getItems").runVoidMethod ("Add",(Object)((RemoteObject.createImmutable("Get Markets"))));
 BA.debugLineNum = 31;BA.debugLine="cmb_Coinpair.Items.Add(\"Get Markets\")";
Debug.ShouldStop(1073741824);
test_ui._cmb_coinpair.runMethod(false,"getItems").runVoidMethod ("Add",(Object)((RemoteObject.createImmutable("Get Markets"))));
 BA.debugLineNum = 32;BA.debugLine="Create_List_of_API_Calls";
Debug.ShouldStop(-2147483648);
_create_list_of_api_calls();
 BA.debugLineNum = 33;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _update_orders() throws Exception{
try {
		Debug.PushSubsStack("Update_Orders (test_ui) ","test_ui",3,test_ui.ba,test_ui.mostCurrent,238);
if (RapidSub.canDelegate("update_orders")) { return b4j.example.test_ui.remoteMe.runUserSub(false, "test_ui","update_orders");}
 BA.debugLineNum = 238;BA.debugLine="Sub Update_Orders";
Debug.ShouldStop(8192);
 BA.debugLineNum = 239;BA.debugLine="lbl_Open_Orders.Text = Calc.All_My_Orders_List.Si";
Debug.ShouldStop(16384);
test_ui._lbl_open_orders.runMethod(true,"setText",RemoteObject.concat(test_ui._calc._all_my_orders_list /*RemoteObject*/ .runMethod(true,"getSize"),RemoteObject.createImmutable(" open orders")));
 BA.debugLineNum = 240;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}