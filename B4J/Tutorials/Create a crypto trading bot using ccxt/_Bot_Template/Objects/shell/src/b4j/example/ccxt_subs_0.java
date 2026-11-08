package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class ccxt_subs_0 {


public static RemoteObject  _add_my_order(RemoteObject _ts,RemoteObject _coinpair,RemoteObject _side,RemoteObject _id,RemoteObject _price,RemoteObject _volume,RemoteObject _filled,RemoteObject _remaining,RemoteObject _order_type,RemoteObject _status) throws Exception{
try {
		Debug.PushSubsStack("Add_My_Order (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,775);
if (RapidSub.canDelegate("add_my_order")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","add_my_order", _ts, _coinpair, _side, _id, _price, _volume, _filled, _remaining, _order_type, _status);}
RemoteObject _total = RemoteObject.createImmutable(0);
RemoteObject _this = RemoteObject.declareNull("b4j.example.calc._order");
RemoteObject _already_exists = RemoteObject.createImmutable(false);
int _i = 0;
RemoteObject _compare_order = RemoteObject.declareNull("b4j.example.calc._order");
Debug.locals.put("TS", _ts);
Debug.locals.put("Coinpair", _coinpair);
Debug.locals.put("Side", _side);
Debug.locals.put("id", _id);
Debug.locals.put("Price", _price);
Debug.locals.put("Volume", _volume);
Debug.locals.put("Filled", _filled);
Debug.locals.put("Remaining", _remaining);
Debug.locals.put("Order_Type", _order_type);
Debug.locals.put("Status", _status);
 BA.debugLineNum = 775;BA.debugLine="Sub Add_My_Order(TS As Long, Coinpair As String, S";
Debug.ShouldStop(64);
 BA.debugLineNum = 776;BA.debugLine="If id <> \"none\" Then";
Debug.ShouldStop(128);
if (RemoteObject.solveBoolean("!",_id,BA.ObjectToString("none"))) { 
 BA.debugLineNum = 777;BA.debugLine="Dim total As Double = Price * Volume";
Debug.ShouldStop(256);
_total = RemoteObject.solve(new RemoteObject[] {_price,_volume}, "*",0, 0);Debug.locals.put("total", _total);Debug.locals.put("total", _total);
 BA.debugLineNum = 778;BA.debugLine="Dim this As Order : this.Initialize";
Debug.ShouldStop(512);
_this = RemoteObject.createNew ("b4j.example.calc._order");Debug.locals.put("this", _this);
 BA.debugLineNum = 778;BA.debugLine="Dim this As Order : this.Initialize";
Debug.ShouldStop(512);
_this.runVoidMethod ("Initialize");
 BA.debugLineNum = 780;BA.debugLine="Dim already_exists As Boolean = False";
Debug.ShouldStop(2048);
_already_exists = ccxt.__c.getField(true,"False");Debug.locals.put("already_exists", _already_exists);Debug.locals.put("already_exists", _already_exists);
 BA.debugLineNum = 781;BA.debugLine="For i = 0 To Calc.All_My_Orders_List.Size-1";
Debug.ShouldStop(4096);
{
final int step6 = 1;
final int limit6 = RemoteObject.solve(new RemoteObject[] {ccxt._calc._all_my_orders_list /*RemoteObject*/ .runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step6 > 0 && _i <= limit6) || (step6 < 0 && _i >= limit6) ;_i = ((int)(0 + _i + step6))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 782;BA.debugLine="Dim compare_order As Order = Calc.All_My_Orders_";
Debug.ShouldStop(8192);
_compare_order = (ccxt._calc._all_my_orders_list /*RemoteObject*/ .runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("compare_order", _compare_order);Debug.locals.put("compare_order", _compare_order);
 BA.debugLineNum = 783;BA.debugLine="If compare_order.id = id Then already_exists = T";
Debug.ShouldStop(16384);
if (RemoteObject.solveBoolean("=",_compare_order.getField(true,"id" /*RemoteObject*/ ),_id)) { 
_already_exists = ccxt.__c.getField(true,"True");Debug.locals.put("already_exists", _already_exists);};
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 785;BA.debugLine="If already_exists = True Then";
Debug.ShouldStop(65536);
if (RemoteObject.solveBoolean("=",_already_exists,ccxt.__c.getField(true,"True"))) { 
 BA.debugLineNum = 786;BA.debugLine="Log(\"Order '\" & id & \"' already exists\")";
Debug.ShouldStop(131072);
ccxt.__c.runVoidMethod ("LogImpl","72949131",RemoteObject.concat(RemoteObject.createImmutable("Order '"),_id,RemoteObject.createImmutable("' already exists")),0);
 }else {
 BA.debugLineNum = 788;BA.debugLine="this.TS = TS : this.Coinpair = Coinpair : this.s";
Debug.ShouldStop(524288);
_this.setField ("TS" /*RemoteObject*/ ,_ts);
 BA.debugLineNum = 788;BA.debugLine="this.TS = TS : this.Coinpair = Coinpair : this.s";
Debug.ShouldStop(524288);
_this.setField ("Coinpair" /*RemoteObject*/ ,_coinpair);
 BA.debugLineNum = 788;BA.debugLine="this.TS = TS : this.Coinpair = Coinpair : this.s";
Debug.ShouldStop(524288);
_this.setField ("side" /*RemoteObject*/ ,_side);
 BA.debugLineNum = 788;BA.debugLine="this.TS = TS : this.Coinpair = Coinpair : this.s";
Debug.ShouldStop(524288);
_this.setField ("id" /*RemoteObject*/ ,_id);
 BA.debugLineNum = 788;BA.debugLine="this.TS = TS : this.Coinpair = Coinpair : this.s";
Debug.ShouldStop(524288);
_this.setField ("Price" /*RemoteObject*/ ,_price);
 BA.debugLineNum = 788;BA.debugLine="this.TS = TS : this.Coinpair = Coinpair : this.s";
Debug.ShouldStop(524288);
_this.setField ("Volume" /*RemoteObject*/ ,_volume);
 BA.debugLineNum = 788;BA.debugLine="this.TS = TS : this.Coinpair = Coinpair : this.s";
Debug.ShouldStop(524288);
_this.setField ("Total" /*RemoteObject*/ ,_total);
 BA.debugLineNum = 789;BA.debugLine="this.filled = Filled : this.remaining = Remainin";
Debug.ShouldStop(1048576);
_this.setField ("filled" /*RemoteObject*/ ,_filled);
 BA.debugLineNum = 789;BA.debugLine="this.filled = Filled : this.remaining = Remainin";
Debug.ShouldStop(1048576);
_this.setField ("remaining" /*RemoteObject*/ ,_remaining);
 BA.debugLineNum = 790;BA.debugLine="this.Order_Type = Order_Type									'limit";
Debug.ShouldStop(2097152);
_this.setField ("Order_Type" /*RemoteObject*/ ,_order_type);
 BA.debugLineNum = 791;BA.debugLine="this.Status = Status													'open";
Debug.ShouldStop(4194304);
_this.setField ("Status" /*RemoteObject*/ ,_status);
 BA.debugLineNum = 792;BA.debugLine="Calc.All_My_Orders_List.Add(this)";
Debug.ShouldStop(8388608);
ccxt._calc._all_my_orders_list /*RemoteObject*/ .runVoidMethod ("Add",(Object)((_this)));
 BA.debugLineNum = 795;BA.debugLine="test_ui.Update_Orders";
Debug.ShouldStop(67108864);
ccxt._test_ui.runVoidMethod ("_update_orders" /*RemoteObject*/ );
 BA.debugLineNum = 796;BA.debugLine="Log(\"Added my \" & this.side & \" \" & this.Order_T";
Debug.ShouldStop(134217728);
ccxt.__c.runVoidMethod ("LogImpl","72949141",RemoteObject.concat(RemoteObject.createImmutable("Added my "),_this.getField(true,"side" /*RemoteObject*/ ),RemoteObject.createImmutable(" "),_this.getField(true,"Order_Type" /*RemoteObject*/ ),RemoteObject.createImmutable(" Order for "),_this.getField(true,"Coinpair" /*RemoteObject*/ ),RemoteObject.createImmutable(" @ "),_this.getField(true,"Price" /*RemoteObject*/ )),0);
 };
 };
 BA.debugLineNum = 800;BA.debugLine="End Sub";
Debug.ShouldStop(-2147483648);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _add_my_trade(RemoteObject _ts,RemoteObject _coinpair,RemoteObject _side,RemoteObject _trade_id,RemoteObject _order_id,RemoteObject _price,RemoteObject _volume,RemoteObject _trade_type,RemoteObject _fee,RemoteObject _fee_currency) throws Exception{
try {
		Debug.PushSubsStack("Add_My_Trade (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,756);
if (RapidSub.canDelegate("add_my_trade")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","add_my_trade", _ts, _coinpair, _side, _trade_id, _order_id, _price, _volume, _trade_type, _fee, _fee_currency);}
RemoteObject _total = RemoteObject.createImmutable(0);
RemoteObject _this = RemoteObject.declareNull("b4j.example.calc._amt");
Debug.locals.put("TS", _ts);
Debug.locals.put("Coinpair", _coinpair);
Debug.locals.put("Side", _side);
Debug.locals.put("trade_id", _trade_id);
Debug.locals.put("order_id", _order_id);
Debug.locals.put("price", _price);
Debug.locals.put("volume", _volume);
Debug.locals.put("trade_type", _trade_type);
Debug.locals.put("fee", _fee);
Debug.locals.put("fee_currency", _fee_currency);
 BA.debugLineNum = 756;BA.debugLine="Sub Add_My_Trade(TS As Long, Coinpair As String, S";
Debug.ShouldStop(524288);
 BA.debugLineNum = 758;BA.debugLine="Dim total As Double = price * volume";
Debug.ShouldStop(2097152);
_total = RemoteObject.solve(new RemoteObject[] {_price,_volume}, "*",0, 0);Debug.locals.put("total", _total);Debug.locals.put("total", _total);
 BA.debugLineNum = 759;BA.debugLine="Dim this As AMT";
Debug.ShouldStop(4194304);
_this = RemoteObject.createNew ("b4j.example.calc._amt");Debug.locals.put("this", _this);
 BA.debugLineNum = 760;BA.debugLine="this.TS = TS												'1502962946216";
Debug.ShouldStop(8388608);
_this.setField ("TS" /*RemoteObject*/ ,_ts);
 BA.debugLineNum = 761;BA.debugLine="this.Coinpair = Coinpair								'ETH/BTC";
Debug.ShouldStop(16777216);
_this.setField ("Coinpair" /*RemoteObject*/ ,_coinpair);
 BA.debugLineNum = 762;BA.debugLine="this.Side = Side											'buy";
Debug.ShouldStop(33554432);
_this.setField ("Side" /*RemoteObject*/ ,_side);
 BA.debugLineNum = 763;BA.debugLine="this.trade_id = trade_id								'12345-67890:0987";
Debug.ShouldStop(67108864);
_this.setField ("trade_id" /*RemoteObject*/ ,_trade_id);
 BA.debugLineNum = 764;BA.debugLine="this.order_id = order_id								'12345-67890:0987";
Debug.ShouldStop(134217728);
_this.setField ("order_id" /*RemoteObject*/ ,_order_id);
 BA.debugLineNum = 765;BA.debugLine="this.Price = price										'0.06917684";
Debug.ShouldStop(268435456);
_this.setField ("Price" /*RemoteObject*/ ,_price);
 BA.debugLineNum = 766;BA.debugLine="this.Volume = volume								'1.5";
Debug.ShouldStop(536870912);
_this.setField ("Volume" /*RemoteObject*/ ,_volume);
 BA.debugLineNum = 767;BA.debugLine="this.total = total											'0.10376526";
Debug.ShouldStop(1073741824);
_this.setField ("Total" /*RemoteObject*/ ,_total);
 BA.debugLineNum = 768;BA.debugLine="this.trade_type = trade_type						'limit";
Debug.ShouldStop(-2147483648);
_this.setField ("trade_type" /*RemoteObject*/ ,_trade_type);
 BA.debugLineNum = 769;BA.debugLine="this.Fee = fee												'0.0015";
Debug.ShouldStop(1);
_this.setField ("Fee" /*RemoteObject*/ ,_fee);
 BA.debugLineNum = 770;BA.debugLine="this.Fee_Currency = fee_currency			'ETH";
Debug.ShouldStop(2);
_this.setField ("Fee_Currency" /*RemoteObject*/ ,_fee_currency);
 BA.debugLineNum = 771;BA.debugLine="Calc.All_My_Trades_List.Add(this)";
Debug.ShouldStop(4);
ccxt._calc._all_my_trades_list /*RemoteObject*/ .runVoidMethod ("Add",(Object)((_this)));
 BA.debugLineNum = 772;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _all_my_open_orders() throws Exception{
try {
		Debug.PushSubsStack("All_My_Open_Orders (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,927);
if (RapidSub.canDelegate("all_my_open_orders")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","all_my_open_orders");}
 BA.debugLineNum = 927;BA.debugLine="Sub All_My_Open_Orders		'optional ccxt variables (";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 928;BA.debugLine="fetch_all_open_orders";
Debug.ShouldStop(-2147483648);
_fetch_all_open_orders();
 BA.debugLineNum = 929;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _all_my_trade_history(RemoteObject _since,RemoteObject _limit) throws Exception{
try {
		Debug.PushSubsStack("All_My_Trade_History (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,937);
if (RapidSub.canDelegate("all_my_trade_history")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","all_my_trade_history", _since, _limit);}
Debug.locals.put("since", _since);
Debug.locals.put("limit", _limit);
 BA.debugLineNum = 937;BA.debugLine="Sub All_My_Trade_History(since As Long, limit As I";
Debug.ShouldStop(256);
 BA.debugLineNum = 938;BA.debugLine="fetch_all_my_trades(since, limit)";
Debug.ShouldStop(512);
_fetch_all_my_trades(_since,_limit);
 BA.debugLineNum = 939;BA.debugLine="End Sub";
Debug.ShouldStop(1024);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _all_tickers() throws Exception{
try {
		Debug.PushSubsStack("All_Tickers (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,899);
if (RapidSub.canDelegate("all_tickers")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","all_tickers");}
 BA.debugLineNum = 899;BA.debugLine="Sub All_Tickers";
Debug.ShouldStop(4);
 BA.debugLineNum = 900;BA.debugLine="fetch_tickers";
Debug.ShouldStop(8);
_fetch_tickers();
 BA.debugLineNum = 901;BA.debugLine="End Sub";
Debug.ShouldStop(16);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static void  _api_call(RemoteObject _call,RemoteObject _input) throws Exception{
try {
		Debug.PushSubsStack("API_Call (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,191);
if (RapidSub.canDelegate("api_call")) { b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","api_call", _call, _input); return;}
ResumableSub_API_Call rsub = new ResumableSub_API_Call(null,_call,_input);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_API_Call extends BA.ResumableSub {
public ResumableSub_API_Call(b4j.example.ccxt parent,RemoteObject _call,RemoteObject _input) {
this.parent = parent;
this._call = _call;
this._input = _input;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
b4j.example.ccxt parent;
RemoteObject _call;
RemoteObject _input;
RemoteObject _result = RemoteObject.createImmutable("");

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("API_Call (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,191);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = -1;
Debug.locals.put("Call", _call);
Debug.locals.put("input", _input);
 BA.debugLineNum = 192;BA.debugLine="Log(\"-------------------- API Call '\" & Call & \"'";
Debug.ShouldStop(-2147483648);
parent.__c.runVoidMethod ("LogImpl","71835009",RemoteObject.concat(RemoteObject.createImmutable("-------------------- API Call '"),_call,RemoteObject.createImmutable("' --------------------")),0);
 BA.debugLineNum = 193;BA.debugLine="Log(\"Wait For(Start_Job(\" & Call & \", \" & PHP_URL";
Debug.ShouldStop(1);
parent.__c.runVoidMethod ("LogImpl","71835010",RemoteObject.concat(RemoteObject.createImmutable("Wait For(Start_Job("),_call,RemoteObject.createImmutable(", "),parent._php_url,RemoteObject.createImmutable(", "),_input,RemoteObject.createImmutable(")) Complete (Result As String)")),0);
 BA.debugLineNum = 194;BA.debugLine="Wait For(Start_Job(Call, PHP_URL, input)) Complet";
Debug.ShouldStop(2);
parent.__c.runVoidMethod ("WaitFor","complete", ccxt.ba, anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "ccxt", "api_call"), _start_job(_call,parent._php_url,_input));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_result = (RemoteObject) result.getArrayElement(true,RemoteObject.createImmutable(0));Debug.locals.put("Result", _result);
;
 BA.debugLineNum = 197;BA.debugLine="test_ui.txt_Output.Text = Result";
Debug.ShouldStop(16);
parent._test_ui._txt_output /*RemoteObject*/ .runMethod(true,"setText",_result);
 BA.debugLineNum = 198;BA.debugLine="End Sub";
Debug.ShouldStop(32);
if (true) break;

            }
        }
    }
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}
public static void  _complete(RemoteObject _result) throws Exception{
}
public static RemoteObject  _cancel_all_orders() throws Exception{
try {
		Debug.PushSubsStack("cancel_all_orders (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,171);
if (RapidSub.canDelegate("cancel_all_orders")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","cancel_all_orders");}
RemoteObject _input = RemoteObject.createImmutable("");
 BA.debugLineNum = 171;BA.debugLine="Sub cancel_all_orders";
Debug.ShouldStop(1024);
 BA.debugLineNum = 172;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(2048);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&command=cancel_all_orders"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 173;BA.debugLine="API_Call(\"Cancel_All_Orders\", input)";
Debug.ShouldStop(4096);
_api_call(BA.ObjectToString("Cancel_All_Orders"),_input);
 BA.debugLineNum = 174;BA.debugLine="End Sub";
Debug.ShouldStop(8192);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _cancel_all_orders_completed(RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Cancel_All_Orders_Completed (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,710);
if (RapidSub.canDelegate("cancel_all_orders_completed")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","cancel_all_orders_completed", _result);}
RemoteObject _m1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _m2 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _count = RemoteObject.createImmutable(0);
RemoteObject _l1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
int _i = 0;
RemoteObject _id = RemoteObject.createImmutable("");
Debug.locals.put("result", _result);
 BA.debugLineNum = 710;BA.debugLine="Private Sub Cancel_All_Orders_Completed(result As";
Debug.ShouldStop(32);
 BA.debugLineNum = 711;BA.debugLine="Log(\"Cancel_All_Orders_Completed\")";
Debug.ShouldStop(64);
ccxt.__c.runVoidMethod ("LogImpl","72818049",RemoteObject.createImmutable("Cancel_All_Orders_Completed"),0);
 BA.debugLineNum = 712;BA.debugLine="Try";
Debug.ShouldStop(128);
try { BA.debugLineNum = 713;BA.debugLine="Log(result)";
Debug.ShouldStop(256);
ccxt.__c.runVoidMethod ("LogImpl","72818051",_result,0);
 BA.debugLineNum = 715;BA.debugLine="If Is_JSON(result) = True Then";
Debug.ShouldStop(1024);
if (RemoteObject.solveBoolean("=",_is_json(_result),ccxt.__c.getField(true,"True"))) { 
 BA.debugLineNum = 716;BA.debugLine="JSON.Initialize(result)";
Debug.ShouldStop(2048);
ccxt._json.runVoidMethod ("Initialize",(Object)(_result));
 BA.debugLineNum = 717;BA.debugLine="If Main.Selected_Bot.exchange = \"kraken\" Then";
Debug.ShouldStop(4096);
if (RemoteObject.solveBoolean("=",ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"exchange" /*RemoteObject*/ ),BA.ObjectToString("kraken"))) { 
 BA.debugLineNum = 718;BA.debugLine="Dim m1, m2 As Map";
Debug.ShouldStop(8192);
_m1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m1", _m1);
_m2 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m2", _m2);
 BA.debugLineNum = 719;BA.debugLine="m1 = JSON.NextObject";
Debug.ShouldStop(16384);
_m1 = ccxt._json.runMethod(false,"NextObject");Debug.locals.put("m1", _m1);
 BA.debugLineNum = 720;BA.debugLine="m2 = m1.Get(\"result\")";
Debug.ShouldStop(32768);
_m2 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("result")))));Debug.locals.put("m2", _m2);
 BA.debugLineNum = 721;BA.debugLine="Dim count As Int = m2.GetDefault(\"count\", 0)";
Debug.ShouldStop(65536);
_count = BA.numberCast(int.class, _m2.runMethod(false,"GetDefault",(Object)(RemoteObject.createImmutable(("count"))),(Object)(RemoteObject.createImmutable((0)))));Debug.locals.put("count", _count);Debug.locals.put("count", _count);
 BA.debugLineNum = 722;BA.debugLine="If count >= Calc.All_My_Orders_List.Size Then";
Debug.ShouldStop(131072);
if (RemoteObject.solveBoolean("g",_count,BA.numberCast(double.class, ccxt._calc._all_my_orders_list /*RemoteObject*/ .runMethod(true,"getSize")))) { 
 BA.debugLineNum = 723;BA.debugLine="Calc.All_My_Orders_List.Clear";
Debug.ShouldStop(262144);
ccxt._calc._all_my_orders_list /*RemoteObject*/ .runVoidMethod ("Clear");
 BA.debugLineNum = 724;BA.debugLine="test_ui.Update_Orders";
Debug.ShouldStop(524288);
ccxt._test_ui.runVoidMethod ("_update_orders" /*RemoteObject*/ );
 };
 }else {
 BA.debugLineNum = 727;BA.debugLine="Dim L1 As List";
Debug.ShouldStop(4194304);
_l1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("L1", _l1);
 BA.debugLineNum = 728;BA.debugLine="L1 = JSON.NextArray";
Debug.ShouldStop(8388608);
_l1 = ccxt._json.runMethod(false,"NextArray");Debug.locals.put("L1", _l1);
 BA.debugLineNum = 729;BA.debugLine="For i = 0 To L1.Size-1";
Debug.ShouldStop(16777216);
{
final int step18 = 1;
final int limit18 = RemoteObject.solve(new RemoteObject[] {_l1.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step18 > 0 && _i <= limit18) || (step18 < 0 && _i >= limit18) ;_i = ((int)(0 + _i + step18))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 730;BA.debugLine="Dim id As String = L1.Get(i)";
Debug.ShouldStop(33554432);
_id = BA.ObjectToString(_l1.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("id", _id);Debug.locals.put("id", _id);
 BA.debugLineNum = 731;BA.debugLine="Remove_My_Order(id)";
Debug.ShouldStop(67108864);
_remove_my_order(_id);
 }
}Debug.locals.put("i", _i);
;
 };
 BA.debugLineNum = 734;BA.debugLine="If Calc.All_My_Orders_List.Size > 0 Then LogErro";
Debug.ShouldStop(536870912);
if (RemoteObject.solveBoolean(">",ccxt._calc._all_my_orders_list /*RemoteObject*/ .runMethod(true,"getSize"),BA.numberCast(double.class, 0))) { 
ccxt.__c.runVoidMethod ("LogError",(Object)(RemoteObject.concat(RemoteObject.createImmutable("All_My_Orders_List.Size = "),ccxt._calc._all_my_orders_list /*RemoteObject*/ .runMethod(true,"getSize"),RemoteObject.createImmutable(", but should be 0"))));};
 };
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e26) {
			BA.rdebugUtils.runVoidMethod("setLastException",ccxt.ba, e26.toString()); BA.debugLineNum = 738;BA.debugLine="Log(LastException)";
Debug.ShouldStop(2);
ccxt.__c.runVoidMethod ("LogImpl","72818076",BA.ObjectToString(ccxt.__c.runMethod(false,"LastException",ccxt.ba)),0);
 };
 BA.debugLineNum = 740;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _cancel_order(RemoteObject _coinpair,RemoteObject _id) throws Exception{
try {
		Debug.PushSubsStack("cancel_order (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,158);
if (RapidSub.canDelegate("cancel_order")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","cancel_order", _coinpair, _id);}
RemoteObject _input = RemoteObject.createImmutable("");
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("id", _id);
 BA.debugLineNum = 158;BA.debugLine="Sub cancel_order(coinpair As String, id As String)";
Debug.ShouldStop(536870912);
 BA.debugLineNum = 159;BA.debugLine="Canceled_Order_ID = id";
Debug.ShouldStop(1073741824);
ccxt._canceled_order_id = _id;
 BA.debugLineNum = 160;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(-2147483648);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&id="),_id,RemoteObject.createImmutable("&symbol="),_coinpair,RemoteObject.createImmutable("&command=cancel_order"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 161;BA.debugLine="API_Call(\"Cancel_Order\", input)";
Debug.ShouldStop(1);
_api_call(BA.ObjectToString("Cancel_Order"),_input);
 BA.debugLineNum = 162;BA.debugLine="End Sub";
Debug.ShouldStop(2);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _cancel_order_completed(RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Cancel_Order_Completed (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,674);
if (RapidSub.canDelegate("cancel_order_completed")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","cancel_order_completed", _result);}
RemoteObject _id = RemoteObject.createImmutable("");
RemoteObject _m = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _error_list = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _result_map = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _k_count = RemoteObject.createImmutable(0);
Debug.locals.put("result", _result);
 BA.debugLineNum = 674;BA.debugLine="Private Sub Cancel_Order_Completed(result As Strin";
Debug.ShouldStop(2);
 BA.debugLineNum = 681;BA.debugLine="Log(\"Cancel_Order_Completed\")";
Debug.ShouldStop(256);
ccxt.__c.runVoidMethod ("LogImpl","72752519",RemoteObject.createImmutable("Cancel_Order_Completed"),0);
 BA.debugLineNum = 682;BA.debugLine="Try";
Debug.ShouldStop(512);
try { BA.debugLineNum = 683;BA.debugLine="Log(result)";
Debug.ShouldStop(1024);
ccxt.__c.runVoidMethod ("LogImpl","72752521",_result,0);
 BA.debugLineNum = 684;BA.debugLine="If Main.Selected_Bot.exchange.Contains(\"coinbase";
Debug.ShouldStop(2048);
if (ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"exchange" /*RemoteObject*/ ).runMethod(true,"contains",(Object)(RemoteObject.createImmutable("coinbase"))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 685;BA.debugLine="Dim id As String = result.SubString2(3, result.";
Debug.ShouldStop(4096);
_id = _result.runMethod(true,"substring",(Object)(BA.numberCast(int.class, 3)),(Object)(RemoteObject.solve(new RemoteObject[] {_result.runMethod(true,"length"),RemoteObject.createImmutable(4)}, "-",1, 1)));Debug.locals.put("id", _id);Debug.locals.put("id", _id);
 BA.debugLineNum = 686;BA.debugLine="Log(id)";
Debug.ShouldStop(8192);
ccxt.__c.runVoidMethod ("LogImpl","72752524",_id,0);
 BA.debugLineNum = 687;BA.debugLine="Remove_My_Order(id)";
Debug.ShouldStop(16384);
_remove_my_order(_id);
 }else 
{ BA.debugLineNum = 688;BA.debugLine="Else If Main.Selected_Bot.exchange.Contains(\"kra";
Debug.ShouldStop(32768);
if (ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"exchange" /*RemoteObject*/ ).runMethod(true,"contains",(Object)(RemoteObject.createImmutable("kraken"))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 689;BA.debugLine="JSON.Initialize(result)";
Debug.ShouldStop(65536);
ccxt._json.runVoidMethod ("Initialize",(Object)(_result));
 BA.debugLineNum = 690;BA.debugLine="Dim m As Map = JSON.NextObject";
Debug.ShouldStop(131072);
_m = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
_m = ccxt._json.runMethod(false,"NextObject");Debug.locals.put("m", _m);Debug.locals.put("m", _m);
 BA.debugLineNum = 691;BA.debugLine="Dim error_list As List = m.Get(\"error\")";
Debug.ShouldStop(262144);
_error_list = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");
_error_list = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), _m.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("error")))));Debug.locals.put("error_list", _error_list);Debug.locals.put("error_list", _error_list);
 BA.debugLineNum = 692;BA.debugLine="Dim result_map As Map = m.Get(\"result\")";
Debug.ShouldStop(524288);
_result_map = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
_result_map = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _m.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("result")))));Debug.locals.put("result_map", _result_map);Debug.locals.put("result_map", _result_map);
 BA.debugLineNum = 693;BA.debugLine="Dim k_count As Int";
Debug.ShouldStop(1048576);
_k_count = RemoteObject.createImmutable(0);Debug.locals.put("k_count", _k_count);
 BA.debugLineNum = 694;BA.debugLine="Log(error_list)";
Debug.ShouldStop(2097152);
ccxt.__c.runVoidMethod ("LogImpl","72752532",BA.ObjectToString(_error_list),0);
 BA.debugLineNum = 695;BA.debugLine="Log(result_map)";
Debug.ShouldStop(4194304);
ccxt.__c.runVoidMethod ("LogImpl","72752533",BA.ObjectToString(_result_map),0);
 BA.debugLineNum = 696;BA.debugLine="k_count = result_map.GetDefault(\"count\", 0)";
Debug.ShouldStop(8388608);
_k_count = BA.numberCast(int.class, _result_map.runMethod(false,"GetDefault",(Object)(RemoteObject.createImmutable(("count"))),(Object)(RemoteObject.createImmutable((0)))));Debug.locals.put("k_count", _k_count);
 BA.debugLineNum = 697;BA.debugLine="If k_count = 1 Then";
Debug.ShouldStop(16777216);
if (RemoteObject.solveBoolean("=",_k_count,BA.numberCast(double.class, 1))) { 
 BA.debugLineNum = 698;BA.debugLine="Remove_My_Order(Canceled_Order_ID)";
Debug.ShouldStop(33554432);
_remove_my_order(ccxt._canceled_order_id);
 }else {
 BA.debugLineNum = 700;BA.debugLine="Log(result_map)";
Debug.ShouldStop(134217728);
ccxt.__c.runVoidMethod ("LogImpl","72752538",BA.ObjectToString(_result_map),0);
 };
 }}
;
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e24) {
			BA.rdebugUtils.runVoidMethod("setLastException",ccxt.ba, e24.toString()); BA.debugLineNum = 706;BA.debugLine="Log(LastException)";
Debug.ShouldStop(2);
ccxt.__c.runVoidMethod ("LogImpl","72752544",BA.ObjectToString(ccxt.__c.runMethod(false,"LastException",ccxt.ba)),0);
 };
 BA.debugLineNum = 708;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _cancel_orders(RemoteObject _coinpair) throws Exception{
try {
		Debug.PushSubsStack("cancel_orders (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,165);
if (RapidSub.canDelegate("cancel_orders")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","cancel_orders", _coinpair);}
RemoteObject _input = RemoteObject.createImmutable("");
Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 165;BA.debugLine="Sub cancel_orders(coinpair As String)			'ccxt look";
Debug.ShouldStop(16);
 BA.debugLineNum = 166;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(32);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&coinpair="),_coinpair,RemoteObject.createImmutable("&command=cancel_orders"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 167;BA.debugLine="API_Call(\"Cancel_All_Orders\", input)";
Debug.ShouldStop(64);
_api_call(BA.ObjectToString("Cancel_All_Orders"),_input);
 BA.debugLineNum = 168;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _count_json_string(RemoteObject _result,RemoteObject _return_json_number) throws Exception{
try {
		Debug.PushSubsStack("Count_JSON_String (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,857);
if (RapidSub.canDelegate("count_json_string")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","count_json_string", _result, _return_json_number);}
RemoteObject _starting_string = RemoteObject.createImmutable("");
RemoteObject _json_string = RemoteObject.createImmutable("");
int _i = 0;
RemoteObject _starting_index = RemoteObject.createImmutable(0);
RemoteObject _curly_count = RemoteObject.createImmutable(0);
RemoteObject _square_count = RemoteObject.createImmutable(0);
RemoteObject _character_count = RemoteObject.createImmutable(0);
RemoteObject _ch = RemoteObject.createImmutable("");
Debug.locals.put("result", _result);
Debug.locals.put("return_json_number", _return_json_number);
 BA.debugLineNum = 857;BA.debugLine="Sub Count_JSON_String(result As String, return_jso";
Debug.ShouldStop(16777216);
 BA.debugLineNum = 859;BA.debugLine="Dim starting_string As String = \"[5] => \"";
Debug.ShouldStop(67108864);
_starting_string = BA.ObjectToString("[5] => ");Debug.locals.put("starting_string", _starting_string);Debug.locals.put("starting_string", _starting_string);
 BA.debugLineNum = 860;BA.debugLine="Dim json_string As String = result";
Debug.ShouldStop(134217728);
_json_string = _result;Debug.locals.put("json_string", _json_string);Debug.locals.put("json_string", _json_string);
 BA.debugLineNum = 862;BA.debugLine="For i = 0 To return_json_number";
Debug.ShouldStop(536870912);
{
final int step3 = 1;
final int limit3 = _return_json_number.<Integer>get().intValue();
_i = 0 ;
for (;(step3 > 0 && _i <= limit3) || (step3 < 0 && _i >= limit3) ;_i = ((int)(0 + _i + step3))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 863;BA.debugLine="Dim starting_index As Int = json_string.IndexOf(";
Debug.ShouldStop(1073741824);
_starting_index = RemoteObject.solve(new RemoteObject[] {_json_string.runMethod(true,"indexOf",(Object)(_starting_string)),_starting_string.runMethod(true,"length")}, "+",1, 1);Debug.locals.put("starting_index", _starting_index);Debug.locals.put("starting_index", _starting_index);
 BA.debugLineNum = 864;BA.debugLine="json_string = json_string.SubString(starting_ind";
Debug.ShouldStop(-2147483648);
_json_string = _json_string.runMethod(true,"substring",(Object)(_starting_index));Debug.locals.put("json_string", _json_string);
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 869;BA.debugLine="Dim curly_count As Int";
Debug.ShouldStop(16);
_curly_count = RemoteObject.createImmutable(0);Debug.locals.put("curly_count", _curly_count);
 BA.debugLineNum = 870;BA.debugLine="Dim square_count As Int";
Debug.ShouldStop(32);
_square_count = RemoteObject.createImmutable(0);Debug.locals.put("square_count", _square_count);
 BA.debugLineNum = 871;BA.debugLine="Dim character_count As Int";
Debug.ShouldStop(64);
_character_count = RemoteObject.createImmutable(0);Debug.locals.put("character_count", _character_count);
 BA.debugLineNum = 872;BA.debugLine="Do While curly_count > 0 Or square_count > 0 Or c";
Debug.ShouldStop(128);
while (RemoteObject.solveBoolean(">",_curly_count,BA.numberCast(double.class, 0)) || RemoteObject.solveBoolean(">",_square_count,BA.numberCast(double.class, 0)) || RemoteObject.solveBoolean("=",_character_count,BA.numberCast(double.class, 0))) {
 BA.debugLineNum = 873;BA.debugLine="Dim ch As String = json_string.CharAt(character_";
Debug.ShouldStop(256);
_ch = BA.ObjectToString(_json_string.runMethod(true,"charAt",(Object)(_character_count)));Debug.locals.put("ch", _ch);Debug.locals.put("ch", _ch);
 BA.debugLineNum = 874;BA.debugLine="If ch = \"[\" Then square_count = square_count + 1";
Debug.ShouldStop(512);
if (RemoteObject.solveBoolean("=",_ch,BA.ObjectToString("["))) { 
_square_count = RemoteObject.solve(new RemoteObject[] {_square_count,RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("square_count", _square_count);};
 BA.debugLineNum = 875;BA.debugLine="If ch = \"]\" Then square_count = square_count - 1";
Debug.ShouldStop(1024);
if (RemoteObject.solveBoolean("=",_ch,BA.ObjectToString("]"))) { 
_square_count = RemoteObject.solve(new RemoteObject[] {_square_count,RemoteObject.createImmutable(1)}, "-",1, 1);Debug.locals.put("square_count", _square_count);};
 BA.debugLineNum = 876;BA.debugLine="If ch = \"{\" Then curly_count = curly_count + 1";
Debug.ShouldStop(2048);
if (RemoteObject.solveBoolean("=",_ch,BA.ObjectToString("{"))) { 
_curly_count = RemoteObject.solve(new RemoteObject[] {_curly_count,RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("curly_count", _curly_count);};
 BA.debugLineNum = 877;BA.debugLine="If ch = \"}\" Then curly_count = curly_count - 1";
Debug.ShouldStop(4096);
if (RemoteObject.solveBoolean("=",_ch,BA.ObjectToString("}"))) { 
_curly_count = RemoteObject.solve(new RemoteObject[] {_curly_count,RemoteObject.createImmutable(1)}, "-",1, 1);Debug.locals.put("curly_count", _curly_count);};
 BA.debugLineNum = 878;BA.debugLine="character_count = character_count + 1";
Debug.ShouldStop(8192);
_character_count = RemoteObject.solve(new RemoteObject[] {_character_count,RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("character_count", _character_count);
 }
;
 BA.debugLineNum = 881;BA.debugLine="json_string = json_string.SubString2(0, character";
Debug.ShouldStop(65536);
_json_string = _json_string.runMethod(true,"substring",(Object)(BA.numberCast(int.class, 0)),(Object)(_character_count));Debug.locals.put("json_string", _json_string);
 BA.debugLineNum = 882;BA.debugLine="LogError(json_string.Length & \"   \" & json_string";
Debug.ShouldStop(131072);
ccxt.__c.runVoidMethod ("LogError",(Object)(RemoteObject.concat(_json_string.runMethod(true,"length"),RemoteObject.createImmutable("   "),_json_string)));
 BA.debugLineNum = 884;BA.debugLine="Return json_string";
Debug.ShouldStop(524288);
if (true) return _json_string;
 BA.debugLineNum = 885;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _create_limit_buy_order(RemoteObject _coinpair,RemoteObject _price,RemoteObject _volume) throws Exception{
try {
		Debug.PushSubsStack("create_limit_buy_order (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,134);
if (RapidSub.canDelegate("create_limit_buy_order")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","create_limit_buy_order", _coinpair, _price, _volume);}
RemoteObject _p = RemoteObject.createImmutable("");
RemoteObject _v = RemoteObject.createImmutable("");
RemoteObject _input = RemoteObject.createImmutable("");
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("price", _price);
Debug.locals.put("volume", _volume);
 BA.debugLineNum = 134;BA.debugLine="Sub create_limit_buy_order(coinpair As String, pri";
Debug.ShouldStop(32);
 BA.debugLineNum = 135;BA.debugLine="Dim p As String = NumberFormat2(price, 1,8,8,Fals";
Debug.ShouldStop(64);
_p = ccxt.__c.runMethod(true,"NumberFormat2",(Object)(_price),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 8)),(Object)(BA.numberCast(int.class, 8)),(Object)(ccxt.__c.getField(true,"False")));Debug.locals.put("p", _p);Debug.locals.put("p", _p);
 BA.debugLineNum = 136;BA.debugLine="Dim v As String = NumberFormat2(volume, 1,8,8,Fal";
Debug.ShouldStop(128);
_v = ccxt.__c.runMethod(true,"NumberFormat2",(Object)(_volume),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 8)),(Object)(BA.numberCast(int.class, 8)),(Object)(ccxt.__c.getField(true,"False")));Debug.locals.put("v", _v);Debug.locals.put("v", _v);
 BA.debugLineNum = 137;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(256);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&symbol="),_coinpair,RemoteObject.createImmutable("&amount="),_v,RemoteObject.createImmutable("&price="),_p,RemoteObject.createImmutable("&command=create_limit_buy_order"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 138;BA.debugLine="API_Call(\"Create_Limit_Buy_Order\", input)";
Debug.ShouldStop(512);
_api_call(BA.ObjectToString("Create_Limit_Buy_Order"),_input);
 BA.debugLineNum = 139;BA.debugLine="End Sub";
Debug.ShouldStop(1024);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _create_limit_sell_order(RemoteObject _coinpair,RemoteObject _price,RemoteObject _volume) throws Exception{
try {
		Debug.PushSubsStack("create_limit_sell_order (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,142);
if (RapidSub.canDelegate("create_limit_sell_order")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","create_limit_sell_order", _coinpair, _price, _volume);}
RemoteObject _p = RemoteObject.createImmutable("");
RemoteObject _v = RemoteObject.createImmutable("");
RemoteObject _input = RemoteObject.createImmutable("");
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("price", _price);
Debug.locals.put("volume", _volume);
 BA.debugLineNum = 142;BA.debugLine="Sub create_limit_sell_order(coinpair As String, pr";
Debug.ShouldStop(8192);
 BA.debugLineNum = 143;BA.debugLine="Dim p As String = NumberFormat2(price, 1,8,8,Fals";
Debug.ShouldStop(16384);
_p = ccxt.__c.runMethod(true,"NumberFormat2",(Object)(_price),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 8)),(Object)(BA.numberCast(int.class, 8)),(Object)(ccxt.__c.getField(true,"False")));Debug.locals.put("p", _p);Debug.locals.put("p", _p);
 BA.debugLineNum = 144;BA.debugLine="Dim v As String = NumberFormat2(volume, 1,8,8,Fal";
Debug.ShouldStop(32768);
_v = ccxt.__c.runMethod(true,"NumberFormat2",(Object)(_volume),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 8)),(Object)(BA.numberCast(int.class, 8)),(Object)(ccxt.__c.getField(true,"False")));Debug.locals.put("v", _v);Debug.locals.put("v", _v);
 BA.debugLineNum = 145;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(65536);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&symbol="),_coinpair,RemoteObject.createImmutable("&amount="),_v,RemoteObject.createImmutable("&price="),_p,RemoteObject.createImmutable("&command=create_limit_sell_order"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 146;BA.debugLine="API_Call(\"Create_Limit_Sell_Order\", input)";
Debug.ShouldStop(131072);
_api_call(BA.ObjectToString("Create_Limit_Sell_Order"),_input);
 BA.debugLineNum = 147;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _create_market_buy_order(RemoteObject _coinpair,RemoteObject _volume) throws Exception{
try {
		Debug.PushSubsStack("create_market_buy_order (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,177);
if (RapidSub.canDelegate("create_market_buy_order")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","create_market_buy_order", _coinpair, _volume);}
RemoteObject _v = RemoteObject.createImmutable("");
RemoteObject _input = RemoteObject.createImmutable("");
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("volume", _volume);
 BA.debugLineNum = 177;BA.debugLine="Sub create_market_buy_order(coinpair As String, vo";
Debug.ShouldStop(65536);
 BA.debugLineNum = 179;BA.debugLine="Dim v As String = NumberFormat2(volume, 1,8,8,Fal";
Debug.ShouldStop(262144);
_v = ccxt.__c.runMethod(true,"NumberFormat2",(Object)(_volume),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 8)),(Object)(BA.numberCast(int.class, 8)),(Object)(ccxt.__c.getField(true,"False")));Debug.locals.put("v", _v);Debug.locals.put("v", _v);
 BA.debugLineNum = 180;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(524288);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&symbol="),_coinpair,RemoteObject.createImmutable("&amount="),_v,RemoteObject.createImmutable("&command=create_market_buy_order"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 181;BA.debugLine="API_Call(\"Create_Market_Buy_Order\", input)";
Debug.ShouldStop(1048576);
_api_call(BA.ObjectToString("Create_Market_Buy_Order"),_input);
 BA.debugLineNum = 182;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _create_market_sell_order(RemoteObject _coinpair,RemoteObject _volume) throws Exception{
try {
		Debug.PushSubsStack("create_market_sell_order (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,185);
if (RapidSub.canDelegate("create_market_sell_order")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","create_market_sell_order", _coinpair, _volume);}
RemoteObject _v = RemoteObject.createImmutable("");
RemoteObject _input = RemoteObject.createImmutable("");
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("volume", _volume);
 BA.debugLineNum = 185;BA.debugLine="Sub create_market_sell_order(coinpair As String, v";
Debug.ShouldStop(16777216);
 BA.debugLineNum = 186;BA.debugLine="Dim v As String = NumberFormat2(volume, 1,8,8,Fal";
Debug.ShouldStop(33554432);
_v = ccxt.__c.runMethod(true,"NumberFormat2",(Object)(_volume),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 8)),(Object)(BA.numberCast(int.class, 8)),(Object)(ccxt.__c.getField(true,"False")));Debug.locals.put("v", _v);Debug.locals.put("v", _v);
 BA.debugLineNum = 187;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(67108864);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&symbol="),_coinpair,RemoteObject.createImmutable("&amount="),_v,RemoteObject.createImmutable("&command=create_market_sell_order"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 188;BA.debugLine="API_Call(\"Place_Market_Sell_Order\", input)";
Debug.ShouldStop(134217728);
_api_call(BA.ObjectToString("Place_Market_Sell_Order"),_input);
 BA.debugLineNum = 189;BA.debugLine="End Sub";
Debug.ShouldStop(268435456);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _edit_limit_order(RemoteObject _id,RemoteObject _coinpair,RemoteObject _side,RemoteObject _price,RemoteObject _volume) throws Exception{
try {
		Debug.PushSubsStack("edit_limit_order (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,150);
if (RapidSub.canDelegate("edit_limit_order")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","edit_limit_order", _id, _coinpair, _side, _price, _volume);}
RemoteObject _p = RemoteObject.createImmutable("");
RemoteObject _v = RemoteObject.createImmutable("");
RemoteObject _input = RemoteObject.createImmutable("");
Debug.locals.put("id", _id);
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("side", _side);
Debug.locals.put("price", _price);
Debug.locals.put("volume", _volume);
 BA.debugLineNum = 150;BA.debugLine="Sub edit_limit_order(id As String, coinpair As Str";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 151;BA.debugLine="Canceled_Order_ID = id";
Debug.ShouldStop(4194304);
ccxt._canceled_order_id = _id;
 BA.debugLineNum = 152;BA.debugLine="Dim p As String = NumberFormat2(price, 1,8,8,Fals";
Debug.ShouldStop(8388608);
_p = ccxt.__c.runMethod(true,"NumberFormat2",(Object)(_price),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 8)),(Object)(BA.numberCast(int.class, 8)),(Object)(ccxt.__c.getField(true,"False")));Debug.locals.put("p", _p);Debug.locals.put("p", _p);
 BA.debugLineNum = 153;BA.debugLine="Dim v As String = NumberFormat2(volume, 1,8,8,Fal";
Debug.ShouldStop(16777216);
_v = ccxt.__c.runMethod(true,"NumberFormat2",(Object)(_volume),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 8)),(Object)(BA.numberCast(int.class, 8)),(Object)(ccxt.__c.getField(true,"False")));Debug.locals.put("v", _v);Debug.locals.put("v", _v);
 BA.debugLineNum = 154;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(33554432);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&id="),_id,RemoteObject.createImmutable("&symbol="),_coinpair,RemoteObject.createImmutable("&side="),_side,RemoteObject.createImmutable("&amount="),_v,RemoteObject.createImmutable("&price="),_p,RemoteObject.createImmutable("&command=edit_limit_order"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 155;BA.debugLine="API_Call(\"Edit_Limit_Order\", input)";
Debug.ShouldStop(67108864);
_api_call(BA.ObjectToString("Edit_Limit_Order"),_input);
 BA.debugLineNum = 156;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _exchange_info() throws Exception{
try {
		Debug.PushSubsStack("exchange_info (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,60);
if (RapidSub.canDelegate("exchange_info")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","exchange_info");}
RemoteObject _input = RemoteObject.createImmutable("");
 BA.debugLineNum = 60;BA.debugLine="Sub exchange_info";
Debug.ShouldStop(134217728);
 BA.debugLineNum = 61;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(268435456);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&command=exchange_info"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 62;BA.debugLine="API_Call(\"Get_Exchange_Info\", input)";
Debug.ShouldStop(536870912);
_api_call(BA.ObjectToString("Get_Exchange_Info"),_input);
 BA.debugLineNum = 63;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _exchanges() throws Exception{
try {
		Debug.PushSubsStack("exchanges (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,54);
if (RapidSub.canDelegate("exchanges")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","exchanges");}
RemoteObject _input = RemoteObject.createImmutable("");
 BA.debugLineNum = 54;BA.debugLine="Sub exchanges";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 55;BA.debugLine="Dim input As String = \"command=exchanges\"";
Debug.ShouldStop(4194304);
_input = BA.ObjectToString("command=exchanges");Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 56;BA.debugLine="API_Call(\"exchanges\", input)";
Debug.ShouldStop(8388608);
_api_call(BA.ObjectToString("exchanges"),_input);
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
public static RemoteObject  _fetch_all_my_trades(RemoteObject _since,RemoteObject _limit) throws Exception{
try {
		Debug.PushSubsStack("fetch_all_my_trades (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,127);
if (RapidSub.canDelegate("fetch_all_my_trades")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","fetch_all_my_trades", _since, _limit);}
RemoteObject _input = RemoteObject.createImmutable("");
Debug.locals.put("since", _since);
Debug.locals.put("limit", _limit);
 BA.debugLineNum = 127;BA.debugLine="Sub fetch_all_my_trades(since As Long, limit As In";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 128;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(-2147483648);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&limit="),_limit,RemoteObject.createImmutable("&since="),_since,RemoteObject.createImmutable("&command=fetch_all_my_trades"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 129;BA.debugLine="API_Call(\"Get_All_My_Trade_History\", input)";
Debug.ShouldStop(1);
_api_call(BA.ObjectToString("Get_All_My_Trade_History"),_input);
 BA.debugLineNum = 130;BA.debugLine="End Sub";
Debug.ShouldStop(2);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fetch_all_open_orders() throws Exception{
try {
		Debug.PushSubsStack("fetch_all_open_orders (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,113);
if (RapidSub.canDelegate("fetch_all_open_orders")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","fetch_all_open_orders");}
RemoteObject _input = RemoteObject.createImmutable("");
 BA.debugLineNum = 113;BA.debugLine="Sub fetch_all_open_orders		'optional ccxt variable";
Debug.ShouldStop(65536);
 BA.debugLineNum = 114;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(131072);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&command=fetch_all_open_orders"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 115;BA.debugLine="API_Call(\"Get_All_My_Open_Orders\", input)";
Debug.ShouldStop(262144);
_api_call(BA.ObjectToString("Get_All_My_Open_Orders"),_input);
 BA.debugLineNum = 116;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fetch_balance() throws Exception{
try {
		Debug.PushSubsStack("fetch_balance (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,101);
if (RapidSub.canDelegate("fetch_balance")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","fetch_balance");}
RemoteObject _input = RemoteObject.createImmutable("");
 BA.debugLineNum = 101;BA.debugLine="Sub fetch_balance";
Debug.ShouldStop(16);
 BA.debugLineNum = 102;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(32);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&command=fetch_balance"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 103;BA.debugLine="API_Call(\"Get_My_Balances\", input)";
Debug.ShouldStop(64);
_api_call(BA.ObjectToString("Get_My_Balances"),_input);
 BA.debugLineNum = 104;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fetch_l2_order_book(RemoteObject _coinpair,RemoteObject _limit) throws Exception{
try {
		Debug.PushSubsStack("fetch_l2_order_book (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,82);
if (RapidSub.canDelegate("fetch_l2_order_book")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","fetch_l2_order_book", _coinpair, _limit);}
RemoteObject _input = RemoteObject.createImmutable("");
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("limit", _limit);
 BA.debugLineNum = 82;BA.debugLine="Sub fetch_l2_order_book(coinpair As String, limit";
Debug.ShouldStop(131072);
 BA.debugLineNum = 83;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(262144);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&symbol="),_coinpair,RemoteObject.createImmutable("&limit="),_limit,RemoteObject.createImmutable("&command=fetch_l2_order_book"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 84;BA.debugLine="API_Call(\"Get_OrderBook\", input)";
Debug.ShouldStop(524288);
_api_call(BA.ObjectToString("Get_OrderBook"),_input);
 BA.debugLineNum = 85;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fetch_markets() throws Exception{
try {
		Debug.PushSubsStack("fetch_markets (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,65);
if (RapidSub.canDelegate("fetch_markets")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","fetch_markets");}
RemoteObject _input = RemoteObject.createImmutable("");
 BA.debugLineNum = 65;BA.debugLine="Sub fetch_markets";
Debug.ShouldStop(1);
 BA.debugLineNum = 66;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(2);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&command=fetch_markets"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 67;BA.debugLine="API_Call(\"Get_Markets\", input)";
Debug.ShouldStop(4);
_api_call(BA.ObjectToString("Get_Markets"),_input);
 BA.debugLineNum = 68;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fetch_my_trades(RemoteObject _coinpair,RemoteObject _since,RemoteObject _limit) throws Exception{
try {
		Debug.PushSubsStack("fetch_my_trades (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,119);
if (RapidSub.canDelegate("fetch_my_trades")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","fetch_my_trades", _coinpair, _since, _limit);}
RemoteObject _input = RemoteObject.createImmutable("");
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("since", _since);
Debug.locals.put("limit", _limit);
 BA.debugLineNum = 119;BA.debugLine="Sub fetch_my_trades(coinpair As String, since As L";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 122;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(33554432);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&symbol="),_coinpair,RemoteObject.createImmutable("&limit="),_limit,RemoteObject.createImmutable("&since="),_since,RemoteObject.createImmutable("&command=fetch_my_trades"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 123;BA.debugLine="API_Call(\"Get_My_Trade_History\", input)";
Debug.ShouldStop(67108864);
_api_call(BA.ObjectToString("Get_My_Trade_History"),_input);
 BA.debugLineNum = 124;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fetch_ohlcv(RemoteObject _coinpair,RemoteObject _timeframe) throws Exception{
try {
		Debug.PushSubsStack("fetch_ohlcv (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,88);
if (RapidSub.canDelegate("fetch_ohlcv")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","fetch_ohlcv", _coinpair, _timeframe);}
RemoteObject _input = RemoteObject.createImmutable("");
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("timeframe", _timeframe);
 BA.debugLineNum = 88;BA.debugLine="Sub fetch_ohlcv(coinpair As String, timeframe As S";
Debug.ShouldStop(8388608);
 BA.debugLineNum = 90;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(33554432);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&symbol="),_coinpair,RemoteObject.createImmutable("&timeframe="),_timeframe,RemoteObject.createImmutable("&command=fetch_ohlcv"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 91;BA.debugLine="API_Call(\"Get_OHLCV\", input)";
Debug.ShouldStop(67108864);
_api_call(BA.ObjectToString("Get_OHLCV"),_input);
 BA.debugLineNum = 92;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fetch_open_orders(RemoteObject _coinpair) throws Exception{
try {
		Debug.PushSubsStack("fetch_open_orders (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,107);
if (RapidSub.canDelegate("fetch_open_orders")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","fetch_open_orders", _coinpair);}
RemoteObject _input = RemoteObject.createImmutable("");
Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 107;BA.debugLine="Sub fetch_open_orders(coinpair As String)	'optiona";
Debug.ShouldStop(1024);
 BA.debugLineNum = 108;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(2048);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&symbol="),_coinpair,RemoteObject.createImmutable("&command=fetch_open_orders"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 109;BA.debugLine="API_Call(\"Get_My_Open_Orders\", input)";
Debug.ShouldStop(4096);
_api_call(BA.ObjectToString("Get_My_Open_Orders"),_input);
 BA.debugLineNum = 110;BA.debugLine="End Sub";
Debug.ShouldStop(8192);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fetch_ticker(RemoteObject _coinpair) throws Exception{
try {
		Debug.PushSubsStack("fetch_ticker (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,71);
if (RapidSub.canDelegate("fetch_ticker")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","fetch_ticker", _coinpair);}
RemoteObject _input = RemoteObject.createImmutable("");
Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 71;BA.debugLine="Sub fetch_ticker(coinpair As String)";
Debug.ShouldStop(64);
 BA.debugLineNum = 72;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(128);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&symbol="),_coinpair,RemoteObject.createImmutable("&command=fetch_ticker"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 73;BA.debugLine="API_Call(\"Get_Ticker\", input)";
Debug.ShouldStop(256);
_api_call(BA.ObjectToString("Get_Ticker"),_input);
 BA.debugLineNum = 74;BA.debugLine="End Sub";
Debug.ShouldStop(512);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fetch_tickers() throws Exception{
try {
		Debug.PushSubsStack("fetch_tickers (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,76);
if (RapidSub.canDelegate("fetch_tickers")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","fetch_tickers");}
RemoteObject _input = RemoteObject.createImmutable("");
 BA.debugLineNum = 76;BA.debugLine="Sub fetch_tickers";
Debug.ShouldStop(2048);
 BA.debugLineNum = 77;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(4096);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&command=fetch_tickers"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 78;BA.debugLine="API_Call(\"Get_All_Tickers\", input)";
Debug.ShouldStop(8192);
_api_call(BA.ObjectToString("Get_All_Tickers"),_input);
 BA.debugLineNum = 79;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _fetch_trades(RemoteObject _coinpair,RemoteObject _limit) throws Exception{
try {
		Debug.PushSubsStack("fetch_trades (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,95);
if (RapidSub.canDelegate("fetch_trades")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","fetch_trades", _coinpair, _limit);}
RemoteObject _input = RemoteObject.createImmutable("");
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("limit", _limit);
 BA.debugLineNum = 95;BA.debugLine="Sub fetch_trades(coinpair As String, limit As Int)";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 97;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
Debug.ShouldStop(1);
_input = RemoteObject.concat(RemoteObject.createImmutable("bot="),ccxt._main._selected_bot /*RemoteObject*/ .getField(true,"name" /*RemoteObject*/ ),RemoteObject.createImmutable("&symbol="),_coinpair,RemoteObject.createImmutable("&limit="),_limit,RemoteObject.createImmutable("&command=fetch_trades"));Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 98;BA.debugLine="API_Call(\"Get_Public_Trade_History\", input)";
Debug.ShouldStop(2);
_api_call(BA.ObjectToString("Get_Public_Trade_History"),_input);
 BA.debugLineNum = 99;BA.debugLine="End Sub";
Debug.ShouldStop(4);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _filter_json_string(RemoteObject _str) throws Exception{
try {
		Debug.PushSubsStack("Filter_JSON_String (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,831);
if (RapidSub.canDelegate("filter_json_string")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","filter_json_string", _str);}
RemoteObject _json_string = RemoteObject.createImmutable("");
RemoteObject _cha = RemoteObject.createImmutable("");
RemoteObject _cha_count = RemoteObject.createImmutable(0);
Debug.locals.put("str", _str);
 BA.debugLineNum = 831;BA.debugLine="Sub Filter_JSON_String(str As String) As String";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 833;BA.debugLine="Dim json_string As String = \"Null\"";
Debug.ShouldStop(1);
_json_string = BA.ObjectToString("Null");Debug.locals.put("json_string", _json_string);Debug.locals.put("json_string", _json_string);
 BA.debugLineNum = 837;BA.debugLine="Dim cha As String";
Debug.ShouldStop(16);
_cha = RemoteObject.createImmutable("");Debug.locals.put("cha", _cha);
 BA.debugLineNum = 838;BA.debugLine="Dim cha_count As Int";
Debug.ShouldStop(32);
_cha_count = RemoteObject.createImmutable(0);Debug.locals.put("cha_count", _cha_count);
 BA.debugLineNum = 840;BA.debugLine="Do Until cha = \"[\" Or cha = \"{\" Or cha_count = st";
Debug.ShouldStop(128);
while (!(RemoteObject.solveBoolean("=",_cha,BA.ObjectToString("[")) || RemoteObject.solveBoolean("=",_cha,BA.ObjectToString("{")) || RemoteObject.solveBoolean("=",_cha_count,BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_str.runMethod(true,"length"),RemoteObject.createImmutable(1)}, "-",1, 1))))) {
 BA.debugLineNum = 841;BA.debugLine="cha = str.CharAt(cha_count)";
Debug.ShouldStop(256);
_cha = BA.ObjectToString(_str.runMethod(true,"charAt",(Object)(_cha_count)));Debug.locals.put("cha", _cha);
 BA.debugLineNum = 842;BA.debugLine="cha_count = cha_count + 1";
Debug.ShouldStop(512);
_cha_count = RemoteObject.solve(new RemoteObject[] {_cha_count,RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("cha_count", _cha_count);
 }
;
 BA.debugLineNum = 846;BA.debugLine="json_string = str.SubString(cha_count - 1)";
Debug.ShouldStop(8192);
_json_string = _str.runMethod(true,"substring",(Object)(RemoteObject.solve(new RemoteObject[] {_cha_count,RemoteObject.createImmutable(1)}, "-",1, 1)));Debug.locals.put("json_string", _json_string);
 BA.debugLineNum = 849;BA.debugLine="If json_string.Length > 2 Then";
Debug.ShouldStop(65536);
if (RemoteObject.solveBoolean(">",_json_string.runMethod(true,"length"),BA.numberCast(double.class, 2))) { 
 BA.debugLineNum = 850;BA.debugLine="Return json_string";
Debug.ShouldStop(131072);
if (true) return _json_string;
 }else {
 BA.debugLineNum = 852;BA.debugLine="Return str";
Debug.ShouldStop(524288);
if (true) return _str;
 };
 BA.debugLineNum = 854;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get_all_my_open_orders_completed(RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Get_All_My_Open_Orders_Completed (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,588);
if (RapidSub.canDelegate("get_all_my_open_orders_completed")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","get_all_my_open_orders_completed", _result);}
RemoteObject _l = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _m = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
int _i = 0;
RemoteObject _my_order = RemoteObject.declareNull("b4j.example.calc._order");
Debug.locals.put("result", _result);
 BA.debugLineNum = 588;BA.debugLine="Private Sub Get_All_My_Open_Orders_Completed(resul";
Debug.ShouldStop(2048);
 BA.debugLineNum = 589;BA.debugLine="Log(\"Get_All_My_Open_Orders_Completed\")";
Debug.ShouldStop(4096);
ccxt.__c.runVoidMethod ("LogImpl","72490369",RemoteObject.createImmutable("Get_All_My_Open_Orders_Completed"),0);
 BA.debugLineNum = 591;BA.debugLine="Try";
Debug.ShouldStop(16384);
try { BA.debugLineNum = 592;BA.debugLine="Calc.All_My_Orders_List.Initialize									'reset";
Debug.ShouldStop(32768);
ccxt._calc._all_my_orders_list /*RemoteObject*/ .runVoidMethod ("Initialize");
 BA.debugLineNum = 593;BA.debugLine="If Is_JSON(result) = True Then";
Debug.ShouldStop(65536);
if (RemoteObject.solveBoolean("=",_is_json(_result),ccxt.__c.getField(true,"True"))) { 
 BA.debugLineNum = 594;BA.debugLine="JSON.Initialize(result)";
Debug.ShouldStop(131072);
ccxt._json.runVoidMethod ("Initialize",(Object)(_result));
 BA.debugLineNum = 595;BA.debugLine="Dim L As List";
Debug.ShouldStop(262144);
_l = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("L", _l);
 BA.debugLineNum = 596;BA.debugLine="Dim m As Map";
Debug.ShouldStop(524288);
_m = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m", _m);
 BA.debugLineNum = 597;BA.debugLine="L = JSON.NextArray";
Debug.ShouldStop(1048576);
_l = ccxt._json.runMethod(false,"NextArray");Debug.locals.put("L", _l);
 BA.debugLineNum = 598;BA.debugLine="For i = 0 To L.Size-1";
Debug.ShouldStop(2097152);
{
final int step9 = 1;
final int limit9 = RemoteObject.solve(new RemoteObject[] {_l.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step9 > 0 && _i <= limit9) || (step9 < 0 && _i >= limit9) ;_i = ((int)(0 + _i + step9))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 599;BA.debugLine="Dim my_order As Order : 	my_order.Initialize";
Debug.ShouldStop(4194304);
_my_order = RemoteObject.createNew ("b4j.example.calc._order");Debug.locals.put("my_order", _my_order);
 BA.debugLineNum = 599;BA.debugLine="Dim my_order As Order : 	my_order.Initialize";
Debug.ShouldStop(4194304);
_my_order.runVoidMethod ("Initialize");
 BA.debugLineNum = 600;BA.debugLine="m = L.Get(i)";
Debug.ShouldStop(8388608);
_m = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _l.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("m", _m);
 BA.debugLineNum = 601;BA.debugLine="Add_My_Order(m.Get(\"timestamp\"), m.Get(\"symbol\"";
Debug.ShouldStop(16777216);
_add_my_order(BA.numberCast(long.class, _m.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("timestamp"))))),BA.ObjectToString(_m.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("symbol"))))),BA.ObjectToString(_m.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("side"))))),BA.ObjectToString(_m.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("id"))))),BA.numberCast(double.class, _m.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("price"))))),BA.numberCast(double.class, _m.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("amount"))))),BA.numberCast(double.class, _m.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("filled"))))),BA.numberCast(double.class, _m.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("remaining"))))),BA.ObjectToString(_m.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("type"))))),BA.ObjectToString(_m.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("status"))))));
 }
}Debug.locals.put("i", _i);
;
 };
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e17) {
			BA.rdebugUtils.runVoidMethod("setLastException",ccxt.ba, e17.toString()); BA.debugLineNum = 606;BA.debugLine="Log(LastException)";
Debug.ShouldStop(536870912);
ccxt.__c.runVoidMethod ("LogImpl","72490386",BA.ObjectToString(ccxt.__c.runMethod(false,"LastException",ccxt.ba)),0);
 };
 BA.debugLineNum = 608;BA.debugLine="End Sub";
Debug.ShouldStop(-2147483648);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get_all_my_trade_history_completed(RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Get_All_My_Trade_History_Completed (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,617);
if (RapidSub.canDelegate("get_all_my_trade_history_completed")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","get_all_my_trade_history_completed", _result);}
RemoteObject _m1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _m2 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _l1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
int _i = 0;
Debug.locals.put("result", _result);
 BA.debugLineNum = 617;BA.debugLine="Private Sub Get_All_My_Trade_History_Completed(res";
Debug.ShouldStop(256);
 BA.debugLineNum = 618;BA.debugLine="Log(\"Get_All_My_Trade_History_Completed\")";
Debug.ShouldStop(512);
ccxt.__c.runVoidMethod ("LogImpl","72621441",RemoteObject.createImmutable("Get_All_My_Trade_History_Completed"),0);
 BA.debugLineNum = 619;BA.debugLine="Try";
Debug.ShouldStop(1024);
try { BA.debugLineNum = 620;BA.debugLine="Calc.All_My_Trades_List.Initialize									'reset";
Debug.ShouldStop(2048);
ccxt._calc._all_my_trades_list /*RemoteObject*/ .runVoidMethod ("Initialize");
 BA.debugLineNum = 622;BA.debugLine="If Is_JSON(result) = True Then";
Debug.ShouldStop(8192);
if (RemoteObject.solveBoolean("=",_is_json(_result),ccxt.__c.getField(true,"True"))) { 
 BA.debugLineNum = 623;BA.debugLine="JSON.Initialize(result)";
Debug.ShouldStop(16384);
ccxt._json.runVoidMethod ("Initialize",(Object)(_result));
 BA.debugLineNum = 624;BA.debugLine="Dim m1, m2 As Map";
Debug.ShouldStop(32768);
_m1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m1", _m1);
_m2 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m2", _m2);
 BA.debugLineNum = 625;BA.debugLine="Dim L1 As List";
Debug.ShouldStop(65536);
_l1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("L1", _l1);
 BA.debugLineNum = 626;BA.debugLine="L1 = JSON.NextArray";
Debug.ShouldStop(131072);
_l1 = ccxt._json.runMethod(false,"NextArray");Debug.locals.put("L1", _l1);
 BA.debugLineNum = 629;BA.debugLine="For i = 0 To L1.Size-1";
Debug.ShouldStop(1048576);
{
final int step9 = 1;
final int limit9 = RemoteObject.solve(new RemoteObject[] {_l1.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step9 > 0 && _i <= limit9) || (step9 < 0 && _i >= limit9) ;_i = ((int)(0 + _i + step9))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 630;BA.debugLine="m1 = L1.Get(i)";
Debug.ShouldStop(2097152);
_m1 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _l1.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("m1", _m1);
 BA.debugLineNum = 631;BA.debugLine="m2 = m1.Get(\"fee\")";
Debug.ShouldStop(4194304);
_m2 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("fee")))));Debug.locals.put("m2", _m2);
 BA.debugLineNum = 632;BA.debugLine="Add_My_Trade(m1.Get(\"timestamp\"), m1.Get(\"symbo";
Debug.ShouldStop(8388608);
_add_my_trade(BA.numberCast(long.class, _m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("timestamp"))))),BA.ObjectToString(_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("symbol"))))),BA.ObjectToString(_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("side"))))),BA.ObjectToString(_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("id"))))),BA.ObjectToString(_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("order"))))),BA.numberCast(double.class, _m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("price"))))),BA.numberCast(double.class, _m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("amount"))))),BA.ObjectToString(_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("type"))))),BA.numberCast(double.class, _m2.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("cost"))))),BA.ObjectToString(_m2.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("currency"))))));
 }
}Debug.locals.put("i", _i);
;
 };
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e16) {
			BA.rdebugUtils.runVoidMethod("setLastException",ccxt.ba, e16.toString()); BA.debugLineNum = 637;BA.debugLine="Log(LastException)";
Debug.ShouldStop(268435456);
ccxt.__c.runVoidMethod ("LogImpl","72621460",BA.ObjectToString(ccxt.__c.runMethod(false,"LastException",ccxt.ba)),0);
 };
 BA.debugLineNum = 639;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get_all_tickers_completed(RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Get_All_Tickers_completed (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,462);
if (RapidSub.canDelegate("get_all_tickers_completed")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","get_all_tickers_completed", _result);}
RemoteObject _m1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _m2 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
int _i = 0;
RemoteObject _coinpair = RemoteObject.createImmutable("");
Debug.locals.put("result", _result);
 BA.debugLineNum = 462;BA.debugLine="Private Sub Get_All_Tickers_completed(result As St";
Debug.ShouldStop(8192);
 BA.debugLineNum = 463;BA.debugLine="Log(\"Get_Tickers_completed\")";
Debug.ShouldStop(16384);
ccxt.__c.runVoidMethod ("LogImpl","72228225",RemoteObject.createImmutable("Get_Tickers_completed"),0);
 BA.debugLineNum = 465;BA.debugLine="Try";
Debug.ShouldStop(65536);
try { BA.debugLineNum = 466;BA.debugLine="If Is_JSON(result) = True Then";
Debug.ShouldStop(131072);
if (RemoteObject.solveBoolean("=",_is_json(_result),ccxt.__c.getField(true,"True"))) { 
 BA.debugLineNum = 467;BA.debugLine="JSON.Initialize(result)";
Debug.ShouldStop(262144);
ccxt._json.runVoidMethod ("Initialize",(Object)(_result));
 BA.debugLineNum = 468;BA.debugLine="Dim m1, m2 As Map";
Debug.ShouldStop(524288);
_m1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m1", _m1);
_m2 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m2", _m2);
 BA.debugLineNum = 469;BA.debugLine="m1 = JSON.NextObject";
Debug.ShouldStop(1048576);
_m1 = ccxt._json.runMethod(false,"NextObject");Debug.locals.put("m1", _m1);
 BA.debugLineNum = 471;BA.debugLine="For i = 0 To m1.Size-1";
Debug.ShouldStop(4194304);
{
final int step7 = 1;
final int limit7 = RemoteObject.solve(new RemoteObject[] {_m1.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step7 > 0 && _i <= limit7) || (step7 < 0 && _i >= limit7) ;_i = ((int)(0 + _i + step7))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 472;BA.debugLine="Dim coinpair As String = m1.GetKeyAt(i)";
Debug.ShouldStop(8388608);
_coinpair = BA.ObjectToString(_m1.runMethod(false,"GetKeyAt",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("coinpair", _coinpair);Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 474;BA.debugLine="m2 = m1.GetValueAt(i)";
Debug.ShouldStop(33554432);
_m2 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _m1.runMethod(false,"GetValueAt",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("m2", _m2);
 BA.debugLineNum = 475;BA.debugLine="Log(\"----------\" & coinpair & \"----------\")";
Debug.ShouldStop(67108864);
ccxt.__c.runVoidMethod ("LogImpl","72228237",RemoteObject.concat(RemoteObject.createImmutable("----------"),_coinpair,RemoteObject.createImmutable("----------")),0);
 BA.debugLineNum = 476;BA.debugLine="Log(	Calc.My_Date_Time( m2.Get(\"timestamp\")))";
Debug.ShouldStop(134217728);
ccxt.__c.runVoidMethod ("LogImpl","72228238",ccxt._calc.runMethod(true,"_my_date_time" /*RemoteObject*/ ,(Object)(BA.numberCast(long.class, _m2.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("timestamp"))))))),0);
 BA.debugLineNum = 477;BA.debugLine="Log(\"Last Price: \" & m2.Get(\"last\"))";
Debug.ShouldStop(268435456);
ccxt.__c.runVoidMethod ("LogImpl","72228239",RemoteObject.concat(RemoteObject.createImmutable("Last Price: "),_m2.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("last"))))),0);
 }
}Debug.locals.put("i", _i);
;
 };
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e16) {
			BA.rdebugUtils.runVoidMethod("setLastException",ccxt.ba, e16.toString()); BA.debugLineNum = 484;BA.debugLine="Log(LastException)";
Debug.ShouldStop(8);
ccxt.__c.runVoidMethod ("LogImpl","72228246",BA.ObjectToString(ccxt.__c.runMethod(false,"LastException",ccxt.ba)),0);
 };
 BA.debugLineNum = 486;BA.debugLine="End Sub";
Debug.ShouldStop(32);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get_exchange_info_completed(RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Get_Exchange_Info_completed (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,310);
if (RapidSub.canDelegate("get_exchange_info_completed")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","get_exchange_info_completed", _result);}
RemoteObject _m1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _m2 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
int _i = 0;
RemoteObject _tf = RemoteObject.createImmutable("");
Debug.locals.put("result", _result);
 BA.debugLineNum = 310;BA.debugLine="Private Sub Get_Exchange_Info_completed(result As";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 311;BA.debugLine="Log(\"Get_Exchange_Info_completed\")";
Debug.ShouldStop(4194304);
ccxt.__c.runVoidMethod ("LogImpl","72031617",RemoteObject.createImmutable("Get_Exchange_Info_completed"),0);
 BA.debugLineNum = 335;BA.debugLine="OHLCV_TimeFrame_List.Initialize";
Debug.ShouldStop(16384);
ccxt._ohlcv_timeframe_list.runVoidMethod ("Initialize");
 BA.debugLineNum = 337;BA.debugLine="Try";
Debug.ShouldStop(65536);
try { BA.debugLineNum = 338;BA.debugLine="If Is_JSON(result) = True Then";
Debug.ShouldStop(131072);
if (RemoteObject.solveBoolean("=",_is_json(_result),ccxt.__c.getField(true,"True"))) { 
 BA.debugLineNum = 339;BA.debugLine="JSON.Initialize(result)";
Debug.ShouldStop(262144);
ccxt._json.runVoidMethod ("Initialize",(Object)(_result));
 BA.debugLineNum = 340;BA.debugLine="Dim m1, m2 As Map";
Debug.ShouldStop(524288);
_m1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m1", _m1);
_m2 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m2", _m2);
 BA.debugLineNum = 341;BA.debugLine="m1 = JSON.NextObject";
Debug.ShouldStop(1048576);
_m1 = ccxt._json.runMethod(false,"NextObject");Debug.locals.put("m1", _m1);
 BA.debugLineNum = 342;BA.debugLine="Log(\"id: \" & m1.Get(\"id\"))";
Debug.ShouldStop(2097152);
ccxt.__c.runVoidMethod ("LogImpl","72031648",RemoteObject.concat(RemoteObject.createImmutable("id: "),_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("id"))))),0);
 BA.debugLineNum = 343;BA.debugLine="Log(\"countries: \" & m1.Get(\"countries\"))";
Debug.ShouldStop(4194304);
ccxt.__c.runVoidMethod ("LogImpl","72031649",RemoteObject.concat(RemoteObject.createImmutable("countries: "),_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("countries"))))),0);
 BA.debugLineNum = 344;BA.debugLine="m2 = m1.Get(\"has\")";
Debug.ShouldStop(8388608);
_m2 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("has")))));Debug.locals.put("m2", _m2);
 BA.debugLineNum = 345;BA.debugLine="Log(\"Get_Markets: \" & m2.Get(\"fetchMarkets\"))";
Debug.ShouldStop(16777216);
ccxt.__c.runVoidMethod ("LogImpl","72031651",RemoteObject.concat(RemoteObject.createImmutable("Get_Markets: "),_m2.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("fetchMarkets"))))),0);
 BA.debugLineNum = 346;BA.debugLine="Log(\"Get_Ticker: \" & m2.Get(\"fetchTicker\"))";
Debug.ShouldStop(33554432);
ccxt.__c.runVoidMethod ("LogImpl","72031652",RemoteObject.concat(RemoteObject.createImmutable("Get_Ticker: "),_m2.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("fetchTicker"))))),0);
 BA.debugLineNum = 347;BA.debugLine="Log(\"Get_All_Tickers: \" & m2.Get(\"fetchTickers\"";
Debug.ShouldStop(67108864);
ccxt.__c.runVoidMethod ("LogImpl","72031653",RemoteObject.concat(RemoteObject.createImmutable("Get_All_Tickers: "),_m2.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("fetchTickers"))))),0);
 BA.debugLineNum = 348;BA.debugLine="Log(\"Get_OrderBook\" & m2.Get(\"fetchOrderBook\"))";
Debug.ShouldStop(134217728);
ccxt.__c.runVoidMethod ("LogImpl","72031654",RemoteObject.concat(RemoteObject.createImmutable("Get_OrderBook"),_m2.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("fetchOrderBook"))))),0);
 BA.debugLineNum = 349;BA.debugLine="Log(\"Get_OHLCV: \" & m2.Get(\"fetchOHLCV\"))";
Debug.ShouldStop(268435456);
ccxt.__c.runVoidMethod ("LogImpl","72031655",RemoteObject.concat(RemoteObject.createImmutable("Get_OHLCV: "),_m2.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("fetchOHLCV"))))),0);
 BA.debugLineNum = 350;BA.debugLine="Log(\"Get_Public_Trade_History: \" & m2.Get(\"fetc";
Debug.ShouldStop(536870912);
ccxt.__c.runVoidMethod ("LogImpl","72031656",RemoteObject.concat(RemoteObject.createImmutable("Get_Public_Trade_History: "),_m2.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("fetchTrades"))))),0);
 BA.debugLineNum = 351;BA.debugLine="Log(\"Get_My_Balances: \" & m2.Get(\"fetchBalance\"";
Debug.ShouldStop(1073741824);
ccxt.__c.runVoidMethod ("LogImpl","72031657",RemoteObject.concat(RemoteObject.createImmutable("Get_My_Balances: "),_m2.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("fetchBalance"))))),0);
 BA.debugLineNum = 352;BA.debugLine="Log(\"Get_All_My_Open_Orders: \" & m2.Get(\"fetchO";
Debug.ShouldStop(-2147483648);
ccxt.__c.runVoidMethod ("LogImpl","72031658",RemoteObject.concat(RemoteObject.createImmutable("Get_All_My_Open_Orders: "),_m2.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("fetchOpenOrders"))))),0);
 BA.debugLineNum = 353;BA.debugLine="Log(\"Cancel_Order: \" & m2.Get(\"cancelOrder\"))";
Debug.ShouldStop(1);
ccxt.__c.runVoidMethod ("LogImpl","72031659",RemoteObject.concat(RemoteObject.createImmutable("Cancel_Order: "),_m2.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("cancelOrder"))))),0);
 BA.debugLineNum = 354;BA.debugLine="m2 = m1.Get(\"timeframes\")															'for OH";
Debug.ShouldStop(2);
_m2 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("timeframes")))));Debug.locals.put("m2", _m2);
 BA.debugLineNum = 355;BA.debugLine="For i = 0 To m2.Size-1";
Debug.ShouldStop(4);
{
final int step21 = 1;
final int limit21 = RemoteObject.solve(new RemoteObject[] {_m2.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step21 > 0 && _i <= limit21) || (step21 < 0 && _i >= limit21) ;_i = ((int)(0 + _i + step21))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 356;BA.debugLine="Dim tf As String = m2.GetKeyAt(i)";
Debug.ShouldStop(8);
_tf = BA.ObjectToString(_m2.runMethod(false,"GetKeyAt",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("tf", _tf);Debug.locals.put("tf", _tf);
 BA.debugLineNum = 357;BA.debugLine="OHLCV_TimeFrame_List.Add(tf)";
Debug.ShouldStop(16);
ccxt._ohlcv_timeframe_list.runVoidMethod ("Add",(Object)((_tf)));
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 359;BA.debugLine="Log(\"Supported OHLCV Time Frames: \" & OHLCV_Tim";
Debug.ShouldStop(64);
ccxt.__c.runVoidMethod ("LogImpl","72031665",RemoteObject.concat(RemoteObject.createImmutable("Supported OHLCV Time Frames: "),ccxt._ohlcv_timeframe_list),0);
 };
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e28) {
			BA.rdebugUtils.runVoidMethod("setLastException",ccxt.ba, e28.toString()); BA.debugLineNum = 363;BA.debugLine="Log(LastException)";
Debug.ShouldStop(1024);
ccxt.__c.runVoidMethod ("LogImpl","72031669",BA.ObjectToString(ccxt.__c.runMethod(false,"LastException",ccxt.ba)),0);
 };
 BA.debugLineNum = 365;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get_exchanges_completed(RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Get_Exchanges_completed (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,289);
if (RapidSub.canDelegate("get_exchanges_completed")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","get_exchanges_completed", _result);}
RemoteObject _l = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
int _i = 0;
Debug.locals.put("result", _result);
 BA.debugLineNum = 289;BA.debugLine="Private Sub Get_Exchanges_completed(result As Stri";
Debug.ShouldStop(1);
 BA.debugLineNum = 290;BA.debugLine="Log(\"Get_Exchanges_completed\")";
Debug.ShouldStop(2);
ccxt.__c.runVoidMethod ("LogImpl","71966081",RemoteObject.createImmutable("Get_Exchanges_completed"),0);
 BA.debugLineNum = 292;BA.debugLine="Try";
Debug.ShouldStop(8);
try { BA.debugLineNum = 293;BA.debugLine="If Is_JSON(result) = True Then";
Debug.ShouldStop(16);
if (RemoteObject.solveBoolean("=",_is_json(_result),ccxt.__c.getField(true,"True"))) { 
 BA.debugLineNum = 294;BA.debugLine="JSON.Initialize(result)";
Debug.ShouldStop(32);
ccxt._json.runVoidMethod ("Initialize",(Object)(_result));
 BA.debugLineNum = 295;BA.debugLine="Dim L As List";
Debug.ShouldStop(64);
_l = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("L", _l);
 BA.debugLineNum = 296;BA.debugLine="L = JSON.NextArray";
Debug.ShouldStop(128);
_l = ccxt._json.runMethod(false,"NextArray");Debug.locals.put("L", _l);
 BA.debugLineNum = 297;BA.debugLine="For i = 0 To L.Size-1";
Debug.ShouldStop(256);
{
final int step7 = 1;
final int limit7 = RemoteObject.solve(new RemoteObject[] {_l.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step7 > 0 && _i <= limit7) || (step7 < 0 && _i >= limit7) ;_i = ((int)(0 + _i + step7))  ) {
Debug.locals.put("i", _i);
 }
}Debug.locals.put("i", _i);
;
 };
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e11) {
			BA.rdebugUtils.runVoidMethod("setLastException",ccxt.ba, e11.toString()); BA.debugLineNum = 306;BA.debugLine="Log(LastException)";
Debug.ShouldStop(131072);
ccxt.__c.runVoidMethod ("LogImpl","71966097",BA.ObjectToString(ccxt.__c.runMethod(false,"LastException",ccxt.ba)),0);
 };
 BA.debugLineNum = 308;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get_markets_completed(RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Get_Markets_completed (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,367);
if (RapidSub.canDelegate("get_markets_completed")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","get_markets_completed", _result);}
RemoteObject _coinpair = RemoteObject.createImmutable("");
RemoteObject _pcoin = RemoteObject.createImmutable("");
RemoteObject _scoin = RemoteObject.createImmutable("");
RemoteObject _l1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _m1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
int _i = 0;
RemoteObject _coin = RemoteObject.declareNull("Object");
Debug.locals.put("result", _result);
 BA.debugLineNum = 367;BA.debugLine="Private Sub Get_Markets_completed(result As String";
Debug.ShouldStop(16384);
 BA.debugLineNum = 368;BA.debugLine="Log(\"Get_Markets_completed\")";
Debug.ShouldStop(32768);
ccxt.__c.runVoidMethod ("LogImpl","72097153",RemoteObject.createImmutable("Get_Markets_completed"),0);
 BA.debugLineNum = 379;BA.debugLine="Try";
Debug.ShouldStop(67108864);
try { BA.debugLineNum = 381;BA.debugLine="If Is_JSON(result) Then";
Debug.ShouldStop(268435456);
if (_is_json(_result).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 382;BA.debugLine="JSON.Initialize(result)";
Debug.ShouldStop(536870912);
ccxt._json.runVoidMethod ("Initialize",(Object)(_result));
 BA.debugLineNum = 383;BA.debugLine="Dim coinpair, pcoin, scoin As String";
Debug.ShouldStop(1073741824);
_coinpair = RemoteObject.createImmutable("");Debug.locals.put("coinpair", _coinpair);
_pcoin = RemoteObject.createImmutable("");Debug.locals.put("pcoin", _pcoin);
_scoin = RemoteObject.createImmutable("");Debug.locals.put("scoin", _scoin);
 BA.debugLineNum = 384;BA.debugLine="Dim L1 As List";
Debug.ShouldStop(-2147483648);
_l1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("L1", _l1);
 BA.debugLineNum = 385;BA.debugLine="Dim m1 As Map";
Debug.ShouldStop(1);
_m1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m1", _m1);
 BA.debugLineNum = 386;BA.debugLine="L1 = JSON.NextArray";
Debug.ShouldStop(2);
_l1 = ccxt._json.runMethod(false,"NextArray");Debug.locals.put("L1", _l1);
 BA.debugLineNum = 387;BA.debugLine="Log(L1)";
Debug.ShouldStop(4);
ccxt.__c.runVoidMethod ("LogImpl","72097172",BA.ObjectToString(_l1),0);
 BA.debugLineNum = 389;BA.debugLine="Pcoin_List.Initialize";
Debug.ShouldStop(16);
ccxt._pcoin_list.runVoidMethod ("Initialize");
 BA.debugLineNum = 390;BA.debugLine="Scoin_List.Initialize";
Debug.ShouldStop(32);
ccxt._scoin_list.runVoidMethod ("Initialize");
 BA.debugLineNum = 391;BA.debugLine="Coinpair_List.Initialize";
Debug.ShouldStop(64);
ccxt._coinpair_list.runVoidMethod ("Initialize");
 BA.debugLineNum = 392;BA.debugLine="test_ui.cmb_Coinpair.Items.Clear";
Debug.ShouldStop(128);
ccxt._test_ui._cmb_coinpair /*RemoteObject*/ .runMethod(false,"getItems").runVoidMethod ("Clear");
 BA.debugLineNum = 394;BA.debugLine="For i = 0 To L1.Size-1";
Debug.ShouldStop(512);
{
final int step14 = 1;
final int limit14 = RemoteObject.solve(new RemoteObject[] {_l1.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step14 > 0 && _i <= limit14) || (step14 < 0 && _i >= limit14) ;_i = ((int)(0 + _i + step14))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 395;BA.debugLine="m1 = L1.Get(i)";
Debug.ShouldStop(1024);
_m1 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _l1.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("m1", _m1);
 BA.debugLineNum = 396;BA.debugLine="Log(m1)";
Debug.ShouldStop(2048);
ccxt.__c.runVoidMethod ("LogImpl","72097181",BA.ObjectToString(_m1),0);
 BA.debugLineNum = 397;BA.debugLine="pcoin = m1.Get(\"base\")";
Debug.ShouldStop(4096);
_pcoin = BA.ObjectToString(_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("base")))));Debug.locals.put("pcoin", _pcoin);
 BA.debugLineNum = 398;BA.debugLine="Pcoin_List.Add(pcoin)";
Debug.ShouldStop(8192);
ccxt._pcoin_list.runVoidMethod ("Add",(Object)((_pcoin)));
 BA.debugLineNum = 399;BA.debugLine="coinpair = m1.Get(\"symbol\")";
Debug.ShouldStop(16384);
_coinpair = BA.ObjectToString(_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("symbol")))));Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 400;BA.debugLine="Coinpair_List.Add(coinpair)";
Debug.ShouldStop(32768);
ccxt._coinpair_list.runVoidMethod ("Add",(Object)((_coinpair)));
 BA.debugLineNum = 401;BA.debugLine="scoin = m1.Get(\"quote\")";
Debug.ShouldStop(65536);
_scoin = BA.ObjectToString(_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("quote")))));Debug.locals.put("scoin", _scoin);
 BA.debugLineNum = 402;BA.debugLine="If Scoin_List.IndexOf(scoin) = -1 Then Scoin_Li";
Debug.ShouldStop(131072);
if (RemoteObject.solveBoolean("=",ccxt._scoin_list.runMethod(true,"IndexOf",(Object)((_scoin))),BA.numberCast(double.class, -(double) (0 + 1)))) { 
ccxt._scoin_list.runVoidMethod ("Add",(Object)((_scoin)));};
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 406;BA.debugLine="test_ui.cmb_Scoin.Items.Clear";
Debug.ShouldStop(2097152);
ccxt._test_ui._cmb_scoin /*RemoteObject*/ .runMethod(false,"getItems").runVoidMethod ("Clear");
 BA.debugLineNum = 407;BA.debugLine="Scoin_List.Sort(True)";
Debug.ShouldStop(4194304);
ccxt._scoin_list.runVoidMethod ("Sort",(Object)(ccxt.__c.getField(true,"True")));
 BA.debugLineNum = 408;BA.debugLine="For Each coin In Scoin_List";
Debug.ShouldStop(8388608);
{
final RemoteObject group26 = ccxt._scoin_list;
final int groupLen26 = group26.runMethod(true,"getSize").<Integer>get()
;int index26 = 0;
;
for (; index26 < groupLen26;index26++){
_coin = group26.runMethod(false,"Get",index26);Debug.locals.put("coin", _coin);
Debug.locals.put("coin", _coin);
 BA.debugLineNum = 409;BA.debugLine="test_ui.cmb_Scoin.Items.Add(coin)";
Debug.ShouldStop(16777216);
ccxt._test_ui._cmb_scoin /*RemoteObject*/ .runMethod(false,"getItems").runVoidMethod ("Add",(Object)(_coin));
 }
}Debug.locals.put("coin", _coin);
;
 };
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e31) {
			BA.rdebugUtils.runVoidMethod("setLastException",ccxt.ba, e31.toString()); BA.debugLineNum = 414;BA.debugLine="Log(LastException)";
Debug.ShouldStop(536870912);
ccxt.__c.runVoidMethod ("LogImpl","72097199",BA.ObjectToString(ccxt.__c.runMethod(false,"LastException",ccxt.ba)),0);
 };
 BA.debugLineNum = 416;BA.debugLine="End Sub";
Debug.ShouldStop(-2147483648);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get_my_balances_completed(RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Get_My_Balances_completed (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,546);
if (RapidSub.canDelegate("get_my_balances_completed")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","get_my_balances_completed", _result);}
RemoteObject _m1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _m2 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _key = RemoteObject.createImmutable("");
RemoteObject _val = RemoteObject.declareNull("Object");
Debug.locals.put("result", _result);
 BA.debugLineNum = 546;BA.debugLine="Private Sub Get_My_Balances_completed(result As St";
Debug.ShouldStop(2);
 BA.debugLineNum = 547;BA.debugLine="Log(\"Get_My_Balances_completed\")";
Debug.ShouldStop(4);
ccxt.__c.runVoidMethod ("LogImpl","72424833",RemoteObject.createImmutable("Get_My_Balances_completed"),0);
 BA.debugLineNum = 549;BA.debugLine="Try";
Debug.ShouldStop(16);
try { BA.debugLineNum = 550;BA.debugLine="If Is_JSON(result) = True Then";
Debug.ShouldStop(32);
if (RemoteObject.solveBoolean("=",_is_json(_result),ccxt.__c.getField(true,"True"))) { 
 BA.debugLineNum = 551;BA.debugLine="JSON.Initialize(result)";
Debug.ShouldStop(64);
ccxt._json.runVoidMethod ("Initialize",(Object)(_result));
 BA.debugLineNum = 552;BA.debugLine="Dim m1, m2 As Map";
Debug.ShouldStop(128);
_m1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m1", _m1);
_m2 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m2", _m2);
 BA.debugLineNum = 554;BA.debugLine="m1 = JSON.NextObject";
Debug.ShouldStop(512);
_m1 = ccxt._json.runMethod(false,"NextObject");Debug.locals.put("m1", _m1);
 BA.debugLineNum = 561;BA.debugLine="Log(\"----- Balance Held -----\")";
Debug.ShouldStop(65536);
ccxt.__c.runVoidMethod ("LogImpl","72424847",RemoteObject.createImmutable("----- Balance Held -----"),0);
 BA.debugLineNum = 562;BA.debugLine="m2 = m1.Get(\"used\")";
Debug.ShouldStop(131072);
_m2 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("used")))));Debug.locals.put("m2", _m2);
 BA.debugLineNum = 563;BA.debugLine="For Each Key As String In m2.Keys";
Debug.ShouldStop(262144);
{
final RemoteObject group9 = _m2.runMethod(false,"Keys");
final int groupLen9 = group9.runMethod(true,"getSize").<Integer>get()
;int index9 = 0;
;
for (; index9 < groupLen9;index9++){
_key = BA.ObjectToString(group9.runMethod(false,"Get",index9));Debug.locals.put("Key", _key);
Debug.locals.put("Key", _key);
 BA.debugLineNum = 564;BA.debugLine="Dim val As Object = m2.Get(Key)";
Debug.ShouldStop(524288);
_val = _m2.runMethod(false,"Get",(Object)((_key)));Debug.locals.put("val", _val);Debug.locals.put("val", _val);
 BA.debugLineNum = 565;BA.debugLine="If val <> Null And val > 0 Then Log(Key & \": \"";
Debug.ShouldStop(1048576);
if (RemoteObject.solveBoolean("N",_val) && RemoteObject.solveBoolean(">",BA.numberCast(double.class, _val),BA.numberCast(double.class, 0))) { 
ccxt.__c.runVoidMethod ("LogImpl","72424851",RemoteObject.concat(_key,RemoteObject.createImmutable(": "),_val),0);};
 }
}Debug.locals.put("Key", _key);
;
 BA.debugLineNum = 568;BA.debugLine="Log(\"----- Balance Available -----\")";
Debug.ShouldStop(8388608);
ccxt.__c.runVoidMethod ("LogImpl","72424854",RemoteObject.createImmutable("----- Balance Available -----"),0);
 BA.debugLineNum = 569;BA.debugLine="m2 = m1.Get(\"free\")";
Debug.ShouldStop(16777216);
_m2 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("free")))));Debug.locals.put("m2", _m2);
 BA.debugLineNum = 570;BA.debugLine="For Each Key As String In m2.Keys";
Debug.ShouldStop(33554432);
{
final RemoteObject group15 = _m2.runMethod(false,"Keys");
final int groupLen15 = group15.runMethod(true,"getSize").<Integer>get()
;int index15 = 0;
;
for (; index15 < groupLen15;index15++){
_key = BA.ObjectToString(group15.runMethod(false,"Get",index15));Debug.locals.put("Key", _key);
Debug.locals.put("Key", _key);
 BA.debugLineNum = 571;BA.debugLine="Dim val As Object = m2.Get(Key)";
Debug.ShouldStop(67108864);
_val = _m2.runMethod(false,"Get",(Object)((_key)));Debug.locals.put("val", _val);Debug.locals.put("val", _val);
 BA.debugLineNum = 572;BA.debugLine="If val <> Null And val > 0 Then Log(Key & \": \"";
Debug.ShouldStop(134217728);
if (RemoteObject.solveBoolean("N",_val) && RemoteObject.solveBoolean(">",BA.numberCast(double.class, _val),BA.numberCast(double.class, 0))) { 
ccxt.__c.runVoidMethod ("LogImpl","72424858",RemoteObject.concat(_key,RemoteObject.createImmutable(": "),_val),0);};
 }
}Debug.locals.put("Key", _key);
;
 BA.debugLineNum = 575;BA.debugLine="Log(\"----- Balance Total -----\")";
Debug.ShouldStop(1073741824);
ccxt.__c.runVoidMethod ("LogImpl","72424861",RemoteObject.createImmutable("----- Balance Total -----"),0);
 BA.debugLineNum = 576;BA.debugLine="m2 = m1.Get(\"total\")";
Debug.ShouldStop(-2147483648);
_m2 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), _m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("total")))));Debug.locals.put("m2", _m2);
 BA.debugLineNum = 577;BA.debugLine="For Each Key As String In m2.Keys";
Debug.ShouldStop(1);
{
final RemoteObject group21 = _m2.runMethod(false,"Keys");
final int groupLen21 = group21.runMethod(true,"getSize").<Integer>get()
;int index21 = 0;
;
for (; index21 < groupLen21;index21++){
_key = BA.ObjectToString(group21.runMethod(false,"Get",index21));Debug.locals.put("Key", _key);
Debug.locals.put("Key", _key);
 BA.debugLineNum = 578;BA.debugLine="Dim val As Object = m2.Get(Key)";
Debug.ShouldStop(2);
_val = _m2.runMethod(false,"Get",(Object)((_key)));Debug.locals.put("val", _val);Debug.locals.put("val", _val);
 BA.debugLineNum = 579;BA.debugLine="If val <> Null And val > 0 Then Log(Key & \": \"";
Debug.ShouldStop(4);
if (RemoteObject.solveBoolean("N",_val) && RemoteObject.solveBoolean(">",BA.numberCast(double.class, _val),BA.numberCast(double.class, 0))) { 
ccxt.__c.runVoidMethod ("LogImpl","72424865",RemoteObject.concat(_key,RemoteObject.createImmutable(": "),_val),0);};
 }
}Debug.locals.put("Key", _key);
;
 };
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e27) {
			BA.rdebugUtils.runVoidMethod("setLastException",ccxt.ba, e27.toString()); BA.debugLineNum = 584;BA.debugLine="Log(LastException)";
Debug.ShouldStop(128);
ccxt.__c.runVoidMethod ("LogImpl","72424870",BA.ObjectToString(ccxt.__c.runMethod(false,"LastException",ccxt.ba)),0);
 };
 BA.debugLineNum = 586;BA.debugLine="End Sub";
Debug.ShouldStop(512);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get_my_trade_history_completed(RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Get_My_Trade_History_Completed (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,610);
if (RapidSub.canDelegate("get_my_trade_history_completed")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","get_my_trade_history_completed", _result);}
Debug.locals.put("result", _result);
 BA.debugLineNum = 610;BA.debugLine="Private Sub Get_My_Trade_History_Completed(result";
Debug.ShouldStop(2);
 BA.debugLineNum = 611;BA.debugLine="Log(\"Get_My_Trade_History_Completed\")";
Debug.ShouldStop(4);
ccxt.__c.runVoidMethod ("LogImpl","72555905",RemoteObject.createImmutable("Get_My_Trade_History_Completed"),0);
 BA.debugLineNum = 615;BA.debugLine="End Sub";
Debug.ShouldStop(64);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get_ohlcv_completed(RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Get_OHLCV_completed (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,526);
if (RapidSub.canDelegate("get_ohlcv_completed")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","get_ohlcv_completed", _result);}
RemoteObject _l1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _l2 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
int _i = 0;
Debug.locals.put("result", _result);
 BA.debugLineNum = 526;BA.debugLine="Private Sub Get_OHLCV_completed(result As String)";
Debug.ShouldStop(8192);
 BA.debugLineNum = 527;BA.debugLine="Log(\"Get_OHLCV_completed\")";
Debug.ShouldStop(16384);
ccxt.__c.runVoidMethod ("LogImpl","72359297",RemoteObject.createImmutable("Get_OHLCV_completed"),0);
 BA.debugLineNum = 528;BA.debugLine="Try";
Debug.ShouldStop(32768);
try { BA.debugLineNum = 529;BA.debugLine="If Is_JSON(result) = True Then";
Debug.ShouldStop(65536);
if (RemoteObject.solveBoolean("=",_is_json(_result),ccxt.__c.getField(true,"True"))) { 
 BA.debugLineNum = 530;BA.debugLine="JSON.Initialize(result)";
Debug.ShouldStop(131072);
ccxt._json.runVoidMethod ("Initialize",(Object)(_result));
 BA.debugLineNum = 531;BA.debugLine="Dim L1, L2 As List";
Debug.ShouldStop(262144);
_l1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("L1", _l1);
_l2 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("L2", _l2);
 BA.debugLineNum = 532;BA.debugLine="L1 = JSON.NextArray";
Debug.ShouldStop(524288);
_l1 = ccxt._json.runMethod(false,"NextArray");Debug.locals.put("L1", _l1);
 BA.debugLineNum = 534;BA.debugLine="For i = 0 To L1.Size-1";
Debug.ShouldStop(2097152);
{
final int step7 = 1;
final int limit7 = RemoteObject.solve(new RemoteObject[] {_l1.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step7 > 0 && _i <= limit7) || (step7 < 0 && _i >= limit7) ;_i = ((int)(0 + _i + step7))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 535;BA.debugLine="L2 = L1.Get(i)";
Debug.ShouldStop(4194304);
_l2 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), _l1.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("L2", _l2);
 BA.debugLineNum = 536;BA.debugLine="Log(\"TS: \" & L2.Get(0) & \" open: \" & L2.Get(1)";
Debug.ShouldStop(8388608);
ccxt.__c.runVoidMethod ("LogImpl","72359306",RemoteObject.concat(RemoteObject.createImmutable("TS: "),_l2.runMethod(false,"Get",(Object)(BA.numberCast(int.class, 0))),RemoteObject.createImmutable(" open: "),_l2.runMethod(false,"Get",(Object)(BA.numberCast(int.class, 1))),RemoteObject.createImmutable(" high: "),_l2.runMethod(false,"Get",(Object)(BA.numberCast(int.class, 2))),RemoteObject.createImmutable(" low: "),_l2.runMethod(false,"Get",(Object)(BA.numberCast(int.class, 3))),RemoteObject.createImmutable(" close: "),_l2.runMethod(false,"Get",(Object)(BA.numberCast(int.class, 4))),RemoteObject.createImmutable(" volume: "),_l2.runMethod(false,"Get",(Object)(BA.numberCast(int.class, 5)))),0);
 }
}Debug.locals.put("i", _i);
;
 };
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e13) {
			BA.rdebugUtils.runVoidMethod("setLastException",ccxt.ba, e13.toString()); BA.debugLineNum = 542;BA.debugLine="Log(LastException)";
Debug.ShouldStop(536870912);
ccxt.__c.runVoidMethod ("LogImpl","72359312",BA.ObjectToString(ccxt.__c.runMethod(false,"LastException",ccxt.ba)),0);
 };
 BA.debugLineNum = 544;BA.debugLine="End Sub";
Debug.ShouldStop(-2147483648);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get_orderbook_completed(RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Get_Orderbook_completed (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,488);
if (RapidSub.canDelegate("get_orderbook_completed")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","get_orderbook_completed", _result);}
RemoteObject _coinpair = RemoteObject.createImmutable("");
RemoteObject _price = RemoteObject.createImmutable(0);
RemoteObject _volume = RemoteObject.createImmutable(0);
RemoteObject _l1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _l2 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _m1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
int _i = 0;
Debug.locals.put("result", _result);
 BA.debugLineNum = 488;BA.debugLine="Private Sub Get_Orderbook_completed(result As Stri";
Debug.ShouldStop(128);
 BA.debugLineNum = 489;BA.debugLine="Log(\"Get_Orderbook_completed\")";
Debug.ShouldStop(256);
ccxt.__c.runVoidMethod ("LogImpl","72293761",RemoteObject.createImmutable("Get_Orderbook_completed"),0);
 BA.debugLineNum = 490;BA.debugLine="Try";
Debug.ShouldStop(512);
try { BA.debugLineNum = 492;BA.debugLine="If Is_JSON(result) Then";
Debug.ShouldStop(2048);
if (_is_json(_result).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 493;BA.debugLine="JSON.Initialize(result)";
Debug.ShouldStop(4096);
ccxt._json.runVoidMethod ("Initialize",(Object)(_result));
 BA.debugLineNum = 494;BA.debugLine="Dim coinpair As String";
Debug.ShouldStop(8192);
_coinpair = RemoteObject.createImmutable("");Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 495;BA.debugLine="Dim price, volume As Double";
Debug.ShouldStop(16384);
_price = RemoteObject.createImmutable(0);Debug.locals.put("price", _price);
_volume = RemoteObject.createImmutable(0);Debug.locals.put("volume", _volume);
 BA.debugLineNum = 496;BA.debugLine="Dim L1, L2 As List";
Debug.ShouldStop(32768);
_l1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("L1", _l1);
_l2 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("L2", _l2);
 BA.debugLineNum = 497;BA.debugLine="Dim m1 As Map";
Debug.ShouldStop(65536);
_m1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m1", _m1);
 BA.debugLineNum = 498;BA.debugLine="m1 = JSON.NextObject";
Debug.ShouldStop(131072);
_m1 = ccxt._json.runMethod(false,"NextObject");Debug.locals.put("m1", _m1);
 BA.debugLineNum = 499;BA.debugLine="coinpair = m1.Get(\"symbol\")";
Debug.ShouldStop(262144);
_coinpair = BA.ObjectToString(_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("symbol")))));Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 500;BA.debugLine="If coinpair = Main.Selected_Coinpair Then";
Debug.ShouldStop(524288);
if (RemoteObject.solveBoolean("=",_coinpair,ccxt._main._selected_coinpair /*RemoteObject*/ )) { 
 BA.debugLineNum = 501;BA.debugLine="Buy_Orderbook_Map.Initialize";
Debug.ShouldStop(1048576);
ccxt._buy_orderbook_map.runVoidMethod ("Initialize");
 BA.debugLineNum = 502;BA.debugLine="L1 = m1.Get(\"bids\")";
Debug.ShouldStop(2097152);
_l1 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), _m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("bids")))));Debug.locals.put("L1", _l1);
 BA.debugLineNum = 503;BA.debugLine="For i = 0 To L1.Size - 1";
Debug.ShouldStop(4194304);
{
final int step14 = 1;
final int limit14 = RemoteObject.solve(new RemoteObject[] {_l1.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step14 > 0 && _i <= limit14) || (step14 < 0 && _i >= limit14) ;_i = ((int)(0 + _i + step14))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 504;BA.debugLine="L2 = L1.Get(i)";
Debug.ShouldStop(8388608);
_l2 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), _l1.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("L2", _l2);
 BA.debugLineNum = 505;BA.debugLine="price = L2.Get(0)";
Debug.ShouldStop(16777216);
_price = BA.numberCast(double.class, _l2.runMethod(false,"Get",(Object)(BA.numberCast(int.class, 0))));Debug.locals.put("price", _price);
 BA.debugLineNum = 506;BA.debugLine="volume = L2.Get(1)";
Debug.ShouldStop(33554432);
_volume = BA.numberCast(double.class, _l2.runMethod(false,"Get",(Object)(BA.numberCast(int.class, 1))));Debug.locals.put("volume", _volume);
 BA.debugLineNum = 507;BA.debugLine="Buy_Orderbook_Map.Put(price, volume)";
Debug.ShouldStop(67108864);
ccxt._buy_orderbook_map.runVoidMethod ("Put",(Object)((_price)),(Object)((_volume)));
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 510;BA.debugLine="Sell_Orderbook_Map.Initialize";
Debug.ShouldStop(536870912);
ccxt._sell_orderbook_map.runVoidMethod ("Initialize");
 BA.debugLineNum = 511;BA.debugLine="L1 = m1.Get(\"asks\")";
Debug.ShouldStop(1073741824);
_l1 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), _m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("asks")))));Debug.locals.put("L1", _l1);
 BA.debugLineNum = 512;BA.debugLine="For i = 0 To L1.Size - 1";
Debug.ShouldStop(-2147483648);
{
final int step22 = 1;
final int limit22 = RemoteObject.solve(new RemoteObject[] {_l1.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step22 > 0 && _i <= limit22) || (step22 < 0 && _i >= limit22) ;_i = ((int)(0 + _i + step22))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 513;BA.debugLine="L2 = L1.Get(i)";
Debug.ShouldStop(1);
_l2 = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), _l1.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("L2", _l2);
 BA.debugLineNum = 514;BA.debugLine="price = L2.Get(0)";
Debug.ShouldStop(2);
_price = BA.numberCast(double.class, _l2.runMethod(false,"Get",(Object)(BA.numberCast(int.class, 0))));Debug.locals.put("price", _price);
 BA.debugLineNum = 515;BA.debugLine="volume = L2.Get(1)";
Debug.ShouldStop(4);
_volume = BA.numberCast(double.class, _l2.runMethod(false,"Get",(Object)(BA.numberCast(int.class, 1))));Debug.locals.put("volume", _volume);
 BA.debugLineNum = 516;BA.debugLine="Sell_Orderbook_Map.Put(price, volume)";
Debug.ShouldStop(8);
ccxt._sell_orderbook_map.runVoidMethod ("Put",(Object)((_price)),(Object)((_volume)));
 }
}Debug.locals.put("i", _i);
;
 };
 };
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e31) {
			BA.rdebugUtils.runVoidMethod("setLastException",ccxt.ba, e31.toString()); BA.debugLineNum = 522;BA.debugLine="Log(LastException)";
Debug.ShouldStop(512);
ccxt.__c.runVoidMethod ("LogImpl","72293794",BA.ObjectToString(ccxt.__c.runMethod(false,"LastException",ccxt.ba)),0);
 };
 BA.debugLineNum = 524;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get_ticker_completed(RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Get_Ticker_completed (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,418);
if (RapidSub.canDelegate("get_ticker_completed")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","get_ticker_completed", _result);}
RemoteObject _m1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _coinpair = RemoteObject.createImmutable("");
Debug.locals.put("result", _result);
 BA.debugLineNum = 418;BA.debugLine="Private Sub Get_Ticker_completed(result As String)";
Debug.ShouldStop(2);
 BA.debugLineNum = 419;BA.debugLine="Log(\"Get_Ticker_completed\")";
Debug.ShouldStop(4);
ccxt.__c.runVoidMethod ("LogImpl","72162689",RemoteObject.createImmutable("Get_Ticker_completed"),0);
 BA.debugLineNum = 441;BA.debugLine="Try";
Debug.ShouldStop(16777216);
try { BA.debugLineNum = 442;BA.debugLine="If Is_JSON(result) = True Then";
Debug.ShouldStop(33554432);
if (RemoteObject.solveBoolean("=",_is_json(_result),ccxt.__c.getField(true,"True"))) { 
 BA.debugLineNum = 443;BA.debugLine="JSON.Initialize(result)";
Debug.ShouldStop(67108864);
ccxt._json.runVoidMethod ("Initialize",(Object)(_result));
 BA.debugLineNum = 444;BA.debugLine="Dim m1 As Map";
Debug.ShouldStop(134217728);
_m1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m1", _m1);
 BA.debugLineNum = 445;BA.debugLine="m1 = JSON.NextObject";
Debug.ShouldStop(268435456);
_m1 = ccxt._json.runMethod(false,"NextObject");Debug.locals.put("m1", _m1);
 BA.debugLineNum = 446;BA.debugLine="Dim coinpair As String = m1.Get(\"symbol\")";
Debug.ShouldStop(536870912);
_coinpair = BA.ObjectToString(_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("symbol")))));Debug.locals.put("coinpair", _coinpair);Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 447;BA.debugLine="Log(\"-----\" & coinpair & \"-----\")";
Debug.ShouldStop(1073741824);
ccxt.__c.runVoidMethod ("LogImpl","72162717",RemoteObject.concat(RemoteObject.createImmutable("-----"),_coinpair,RemoteObject.createImmutable("-----")),0);
 BA.debugLineNum = 448;BA.debugLine="Log(\"TS: \" & m1.Get(\"timestamp\"))";
Debug.ShouldStop(-2147483648);
ccxt.__c.runVoidMethod ("LogImpl","72162718",RemoteObject.concat(RemoteObject.createImmutable("TS: "),_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("timestamp"))))),0);
 BA.debugLineNum = 449;BA.debugLine="Log(	Calc.My_Date_Time( m1.Get(\"timestamp\")))";
Debug.ShouldStop(1);
ccxt.__c.runVoidMethod ("LogImpl","72162719",ccxt._calc.runMethod(true,"_my_date_time" /*RemoteObject*/ ,(Object)(BA.numberCast(long.class, _m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("timestamp"))))))),0);
 BA.debugLineNum = 451;BA.debugLine="Log(\"price: \" & m1.Get(\"close\"))		'same as \"las";
Debug.ShouldStop(4);
ccxt.__c.runVoidMethod ("LogImpl","72162721",RemoteObject.concat(RemoteObject.createImmutable("price: "),_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("close"))))),0);
 BA.debugLineNum = 452;BA.debugLine="Log(\"24hr volume: \" & m1.Get(\"quoteVolume\") & \"";
Debug.ShouldStop(8);
ccxt.__c.runVoidMethod ("LogImpl","72162722",RemoteObject.concat(RemoteObject.createImmutable("24hr volume: "),_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("quoteVolume")))),RemoteObject.createImmutable(" "),ccxt._calc.runMethod(true,"_get_scoin" /*RemoteObject*/ ,(Object)(_coinpair))),0);
 BA.debugLineNum = 453;BA.debugLine="Log(\"24hr change: \" & m1.Get(\"change\") & \"%\")";
Debug.ShouldStop(16);
ccxt.__c.runVoidMethod ("LogImpl","72162723",RemoteObject.concat(RemoteObject.createImmutable("24hr change: "),_m1.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("change")))),RemoteObject.createImmutable("%")),0);
 };
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e16) {
			BA.rdebugUtils.runVoidMethod("setLastException",ccxt.ba, e16.toString()); BA.debugLineNum = 458;BA.debugLine="Log(LastException)";
Debug.ShouldStop(512);
ccxt.__c.runVoidMethod ("LogImpl","72162728",BA.ObjectToString(ccxt.__c.runMethod(false,"LastException",ccxt.ba)),0);
 };
 BA.debugLineNum = 460;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _is_json(RemoteObject _json_string) throws Exception{
try {
		Debug.PushSubsStack("Is_JSON (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,823);
if (RapidSub.canDelegate("is_json")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","is_json", _json_string);}
RemoteObject _it_is_json = RemoteObject.createImmutable(false);
Debug.locals.put("json_string", _json_string);
 BA.debugLineNum = 823;BA.debugLine="Sub Is_JSON(json_string As String) As Boolean";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 824;BA.debugLine="Dim It_Is_JSON As Boolean = False";
Debug.ShouldStop(8388608);
_it_is_json = ccxt.__c.getField(true,"False");Debug.locals.put("It_Is_JSON", _it_is_json);Debug.locals.put("It_Is_JSON", _it_is_json);
 BA.debugLineNum = 825;BA.debugLine="If json_string.StartsWith(\"[{\") Or json_string.St";
Debug.ShouldStop(16777216);
if (RemoteObject.solveBoolean(".",_json_string.runMethod(true,"startsWith",(Object)(RemoteObject.createImmutable("[{")))) || RemoteObject.solveBoolean(".",_json_string.runMethod(true,"startsWith",(Object)(RemoteObject.createImmutable("[")))) || RemoteObject.solveBoolean(".",_json_string.runMethod(true,"startsWith",(Object)(RemoteObject.createImmutable("{"))))) { 
 BA.debugLineNum = 826;BA.debugLine="It_Is_JSON = True";
Debug.ShouldStop(33554432);
_it_is_json = ccxt.__c.getField(true,"True");Debug.locals.put("It_Is_JSON", _it_is_json);
 };
 BA.debugLineNum = 828;BA.debugLine="Return It_Is_JSON";
Debug.ShouldStop(134217728);
if (true) return _it_is_json;
 BA.debugLineNum = 829;BA.debugLine="End Sub";
Debug.ShouldStop(268435456);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _markets() throws Exception{
try {
		Debug.PushSubsStack("Markets (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,890);
if (RapidSub.canDelegate("markets")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","markets");}
 BA.debugLineNum = 890;BA.debugLine="Sub Markets";
Debug.ShouldStop(33554432);
 BA.debugLineNum = 891;BA.debugLine="fetch_markets";
Debug.ShouldStop(67108864);
_fetch_markets();
 BA.debugLineNum = 892;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _my_balances() throws Exception{
try {
		Debug.PushSubsStack("My_Balances (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,918);
if (RapidSub.canDelegate("my_balances")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","my_balances");}
 BA.debugLineNum = 918;BA.debugLine="Sub My_Balances";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 919;BA.debugLine="fetch_balance";
Debug.ShouldStop(4194304);
_fetch_balance();
 BA.debugLineNum = 920;BA.debugLine="End Sub";
Debug.ShouldStop(8388608);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _my_open_orders(RemoteObject _coinpair) throws Exception{
try {
		Debug.PushSubsStack("My_Open_Orders (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,922);
if (RapidSub.canDelegate("my_open_orders")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","my_open_orders", _coinpair);}
Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 922;BA.debugLine="Sub My_Open_Orders(coinpair As String)	'optional c";
Debug.ShouldStop(33554432);
 BA.debugLineNum = 923;BA.debugLine="fetch_open_orders(coinpair)";
Debug.ShouldStop(67108864);
_fetch_open_orders(_coinpair);
 BA.debugLineNum = 924;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _my_trade_history(RemoteObject _coinpair,RemoteObject _since,RemoteObject _limit) throws Exception{
try {
		Debug.PushSubsStack("My_Trade_History (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,932);
if (RapidSub.canDelegate("my_trade_history")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","my_trade_history", _coinpair, _since, _limit);}
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("since", _since);
Debug.locals.put("limit", _limit);
 BA.debugLineNum = 932;BA.debugLine="Sub My_Trade_History(coinpair As String, since As";
Debug.ShouldStop(8);
 BA.debugLineNum = 933;BA.debugLine="fetch_my_trades(coinpair, since, limit)";
Debug.ShouldStop(16);
_fetch_my_trades(_coinpair,_since,_limit);
 BA.debugLineNum = 934;BA.debugLine="End Sub";
Debug.ShouldStop(32);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _ohlcv(RemoteObject _coinpair,RemoteObject _timeframe) throws Exception{
try {
		Debug.PushSubsStack("OHLCV (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,909);
if (RapidSub.canDelegate("ohlcv")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","ohlcv", _coinpair, _timeframe);}
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("timeframe", _timeframe);
 BA.debugLineNum = 909;BA.debugLine="Sub OHLCV(coinpair As String, timeframe As String)";
Debug.ShouldStop(4096);
 BA.debugLineNum = 910;BA.debugLine="fetch_ohlcv(coinpair, timeframe)";
Debug.ShouldStop(8192);
_fetch_ohlcv(_coinpair,_timeframe);
 BA.debugLineNum = 911;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _order_completed(RemoteObject _result) throws Exception{
try {
		Debug.PushSubsStack("Order_Completed (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,641);
if (RapidSub.canDelegate("order_completed")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","order_completed", _result);}
RemoteObject _m = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _ts = RemoteObject.createImmutable(0L);
RemoteObject _coinpair = RemoteObject.createImmutable("");
RemoteObject _side = RemoteObject.createImmutable("");
RemoteObject _id = RemoteObject.createImmutable("");
RemoteObject _amount = RemoteObject.createImmutable(0);
RemoteObject _filled = RemoteObject.createImmutable(0);
RemoteObject _remaining = RemoteObject.createImmutable(0);
RemoteObject _order_type = RemoteObject.createImmutable("");
RemoteObject _status = RemoteObject.createImmutable("");
RemoteObject _price = RemoteObject.createImmutable(0);
Debug.locals.put("result", _result);
 BA.debugLineNum = 641;BA.debugLine="Private Sub Order_Completed(result As String)";
Debug.ShouldStop(1);
 BA.debugLineNum = 642;BA.debugLine="Log(\"Order_Completed\")";
Debug.ShouldStop(2);
ccxt.__c.runVoidMethod ("LogImpl","72686977",RemoteObject.createImmutable("Order_Completed"),0);
 BA.debugLineNum = 644;BA.debugLine="Try";
Debug.ShouldStop(8);
try { BA.debugLineNum = 645;BA.debugLine="If Is_JSON(result) = True Then";
Debug.ShouldStop(16);
if (RemoteObject.solveBoolean("=",_is_json(_result),ccxt.__c.getField(true,"True"))) { 
 BA.debugLineNum = 646;BA.debugLine="JSON.Initialize(result)";
Debug.ShouldStop(32);
ccxt._json.runVoidMethod ("Initialize",(Object)(_result));
 BA.debugLineNum = 647;BA.debugLine="Dim m As Map";
Debug.ShouldStop(64);
_m = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("m", _m);
 BA.debugLineNum = 648;BA.debugLine="m = JSON.NextObject";
Debug.ShouldStop(128);
_m = ccxt._json.runMethod(false,"NextObject");Debug.locals.put("m", _m);
 BA.debugLineNum = 649;BA.debugLine="Dim ts As Long = m.GetDefault(\"timestamp\", DateT";
Debug.ShouldStop(256);
_ts = BA.numberCast(long.class, _m.runMethod(false,"GetDefault",(Object)(RemoteObject.createImmutable(("timestamp"))),(Object)((ccxt.__c.getField(false,"DateTime").runMethod(true,"getNow")))));Debug.locals.put("ts", _ts);Debug.locals.put("ts", _ts);
 BA.debugLineNum = 650;BA.debugLine="Dim coinpair As String = m.GetDefault(\"symbol\",";
Debug.ShouldStop(512);
_coinpair = BA.ObjectToString(_m.runMethod(false,"GetDefault",(Object)(RemoteObject.createImmutable(("symbol"))),(Object)((RemoteObject.createImmutable("none")))));Debug.locals.put("coinpair", _coinpair);Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 651;BA.debugLine="Dim side As String = m.GetDefault(\"side\", \"none\"";
Debug.ShouldStop(1024);
_side = BA.ObjectToString(_m.runMethod(false,"GetDefault",(Object)(RemoteObject.createImmutable(("side"))),(Object)((RemoteObject.createImmutable("none")))));Debug.locals.put("side", _side);Debug.locals.put("side", _side);
 BA.debugLineNum = 652;BA.debugLine="Dim id As String = m.GetDefault(\"id\", \"none\")";
Debug.ShouldStop(2048);
_id = BA.ObjectToString(_m.runMethod(false,"GetDefault",(Object)(RemoteObject.createImmutable(("id"))),(Object)((RemoteObject.createImmutable("none")))));Debug.locals.put("id", _id);Debug.locals.put("id", _id);
 BA.debugLineNum = 653;BA.debugLine="Dim amount As Double = m.GetDefault(\"amount\", 0)";
Debug.ShouldStop(4096);
_amount = BA.numberCast(double.class, _m.runMethod(false,"GetDefault",(Object)(RemoteObject.createImmutable(("amount"))),(Object)(RemoteObject.createImmutable((0)))));Debug.locals.put("amount", _amount);Debug.locals.put("amount", _amount);
 BA.debugLineNum = 654;BA.debugLine="Dim filled As Double = m.GetDefault(\"filled\", 0)";
Debug.ShouldStop(8192);
_filled = BA.numberCast(double.class, _m.runMethod(false,"GetDefault",(Object)(RemoteObject.createImmutable(("filled"))),(Object)(RemoteObject.createImmutable((0)))));Debug.locals.put("filled", _filled);Debug.locals.put("filled", _filled);
 BA.debugLineNum = 655;BA.debugLine="Dim remaining As Double = m.GetDefault(\"remainin";
Debug.ShouldStop(16384);
_remaining = BA.numberCast(double.class, _m.runMethod(false,"GetDefault",(Object)(RemoteObject.createImmutable(("remaining"))),(Object)(RemoteObject.createImmutable((0)))));Debug.locals.put("remaining", _remaining);Debug.locals.put("remaining", _remaining);
 BA.debugLineNum = 656;BA.debugLine="Dim order_type As String = m.GetDefault(\"type\",";
Debug.ShouldStop(32768);
_order_type = BA.ObjectToString(_m.runMethod(false,"GetDefault",(Object)(RemoteObject.createImmutable(("type"))),(Object)((RemoteObject.createImmutable("none")))));Debug.locals.put("order_type", _order_type);Debug.locals.put("order_type", _order_type);
 BA.debugLineNum = 657;BA.debugLine="Dim status As String = m.GetDefault(\"status\", \"n";
Debug.ShouldStop(65536);
_status = BA.ObjectToString(_m.runMethod(false,"GetDefault",(Object)(RemoteObject.createImmutable(("status"))),(Object)((RemoteObject.createImmutable("none")))));Debug.locals.put("status", _status);Debug.locals.put("status", _status);
 BA.debugLineNum = 659;BA.debugLine="If side = \"sell\" Then";
Debug.ShouldStop(262144);
if (RemoteObject.solveBoolean("=",_side,BA.ObjectToString("sell"))) { 
 BA.debugLineNum = 660;BA.debugLine="Dim price As Double = m.GetDefault(\"price\", 0)";
Debug.ShouldStop(524288);
_price = BA.numberCast(double.class, _m.runMethod(false,"GetDefault",(Object)(RemoteObject.createImmutable(("price"))),(Object)(RemoteObject.createImmutable((0)))));Debug.locals.put("price", _price);Debug.locals.put("price", _price);
 }else {
 BA.debugLineNum = 662;BA.debugLine="Dim price As Double = m.GetDefault(\"price\", 100";
Debug.ShouldStop(2097152);
_price = BA.numberCast(double.class, _m.runMethod(false,"GetDefault",(Object)(RemoteObject.createImmutable(("price"))),(Object)(RemoteObject.createImmutable((1000000)))));Debug.locals.put("price", _price);Debug.locals.put("price", _price);
 };
 BA.debugLineNum = 665;BA.debugLine="If result.Contains(\"error\") = False Then Add_My_";
Debug.ShouldStop(16777216);
if (RemoteObject.solveBoolean("=",_result.runMethod(true,"contains",(Object)(RemoteObject.createImmutable("error"))),ccxt.__c.getField(true,"False"))) { 
_add_my_order(_ts,_coinpair,_side,_id,_price,_amount,_filled,_remaining,_order_type,_status);};
 };
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e24) {
			BA.rdebugUtils.runVoidMethod("setLastException",ccxt.ba, e24.toString()); BA.debugLineNum = 669;BA.debugLine="Log(LastException)";
Debug.ShouldStop(268435456);
ccxt.__c.runVoidMethod ("LogImpl","72687004",BA.ObjectToString(ccxt.__c.runMethod(false,"LastException",ccxt.ba)),0);
 };
 BA.debugLineNum = 672;BA.debugLine="End Sub";
Debug.ShouldStop(-2147483648);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _orderbook(RemoteObject _coinpair,RemoteObject _limit) throws Exception{
try {
		Debug.PushSubsStack("OrderBook (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,904);
if (RapidSub.canDelegate("orderbook")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","orderbook", _coinpair, _limit);}
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("limit", _limit);
 BA.debugLineNum = 904;BA.debugLine="Sub OrderBook(coinpair As String, limit As Int)";
Debug.ShouldStop(128);
 BA.debugLineNum = 905;BA.debugLine="fetch_l2_order_book(coinpair, limit)";
Debug.ShouldStop(256);
_fetch_l2_order_book(_coinpair,_limit);
 BA.debugLineNum = 906;BA.debugLine="End Sub";
Debug.ShouldStop(512);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _place_market_buy_order(RemoteObject _coinpair,RemoteObject _volume) throws Exception{
try {
		Debug.PushSubsStack("Place_Market_Buy_Order (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,942);
if (RapidSub.canDelegate("place_market_buy_order")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","place_market_buy_order", _coinpair, _volume);}
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("volume", _volume);
 BA.debugLineNum = 942;BA.debugLine="Sub Place_Market_Buy_Order(coinpair As String, vol";
Debug.ShouldStop(8192);
 BA.debugLineNum = 943;BA.debugLine="create_market_buy_order(coinpair, volume)";
Debug.ShouldStop(16384);
_create_market_buy_order(_coinpair,_volume);
 BA.debugLineNum = 944;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _place_market_sell_order(RemoteObject _coinpair,RemoteObject _volume) throws Exception{
try {
		Debug.PushSubsStack("Place_Market_Sell_Order (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,947);
if (RapidSub.canDelegate("place_market_sell_order")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","place_market_sell_order", _coinpair, _volume);}
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("volume", _volume);
 BA.debugLineNum = 947;BA.debugLine="Sub Place_Market_Sell_Order(coinpair As String, vo";
Debug.ShouldStop(262144);
 BA.debugLineNum = 948;BA.debugLine="create_market_sell_order(coinpair, volume)";
Debug.ShouldStop(524288);
_create_market_sell_order(_coinpair,_volume);
 BA.debugLineNum = 949;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 27;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 29;BA.debugLine="Private fx As JFX";
ccxt._fx = RemoteObject.createNew ("anywheresoftware.b4j.objects.JFX");
 //BA.debugLineNum = 30;BA.debugLine="Private PHP_Port As Int = 8080";
ccxt._php_port = BA.numberCast(int.class, 8080);
 //BA.debugLineNum = 31;BA.debugLine="Private PHP_URL As String = \"http://localhost:\" &";
ccxt._php_url = RemoteObject.concat(RemoteObject.createImmutable("http://localhost:"),ccxt._php_port,RemoteObject.createImmutable("/API_call.php"));
 //BA.debugLineNum = 32;BA.debugLine="Private JSON As JSONParser";
ccxt._json = RemoteObject.createNew ("anywheresoftware.b4j.objects.collections.JSONParser");
 //BA.debugLineNum = 33;BA.debugLine="Dim Buy_Orderbook_Map As Map";
ccxt._buy_orderbook_map = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
 //BA.debugLineNum = 34;BA.debugLine="Dim Sell_Orderbook_Map As Map";
ccxt._sell_orderbook_map = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
 //BA.debugLineNum = 35;BA.debugLine="Dim Coinpair_List As List";
ccxt._coinpair_list = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");
 //BA.debugLineNum = 36;BA.debugLine="Dim Pcoin_List As List";
ccxt._pcoin_list = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");
 //BA.debugLineNum = 37;BA.debugLine="Dim Scoin_List As List";
ccxt._scoin_list = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");
 //BA.debugLineNum = 38;BA.debugLine="Dim OHLCV_TimeFrame_List As List";
ccxt._ohlcv_timeframe_list = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");
 //BA.debugLineNum = 39;BA.debugLine="Dim Canceled_Order_ID As String";
ccxt._canceled_order_id = RemoteObject.createImmutable("");
 //BA.debugLineNum = 40;BA.debugLine="Dim Exchange_Info_Map As Map";
ccxt._exchange_info_map = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
 //BA.debugLineNum = 41;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _public_trade_history(RemoteObject _coinpair,RemoteObject _limit) throws Exception{
try {
		Debug.PushSubsStack("Public_Trade_History (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,914);
if (RapidSub.canDelegate("public_trade_history")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","public_trade_history", _coinpair, _limit);}
Debug.locals.put("coinpair", _coinpair);
Debug.locals.put("limit", _limit);
 BA.debugLineNum = 914;BA.debugLine="Sub Public_Trade_History(coinpair As String, limit";
Debug.ShouldStop(131072);
 BA.debugLineNum = 915;BA.debugLine="fetch_trades(coinpair, limit)";
Debug.ShouldStop(262144);
_fetch_trades(_coinpair,_limit);
 BA.debugLineNum = 916;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _remove_my_order(RemoteObject _id) throws Exception{
try {
		Debug.PushSubsStack("Remove_My_Order (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,803);
if (RapidSub.canDelegate("remove_my_order")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","remove_my_order", _id);}
RemoteObject _index = RemoteObject.createImmutable(0);
int _i = 0;
RemoteObject _this = RemoteObject.declareNull("b4j.example.calc._order");
Debug.locals.put("id", _id);
 BA.debugLineNum = 803;BA.debugLine="Sub Remove_My_Order(id As String)";
Debug.ShouldStop(4);
 BA.debugLineNum = 804;BA.debugLine="Dim index As Int = -1";
Debug.ShouldStop(8);
_index = BA.numberCast(int.class, -(double) (0 + 1));Debug.locals.put("index", _index);Debug.locals.put("index", _index);
 BA.debugLineNum = 806;BA.debugLine="Log(\"started with \" & Calc.All_My_Orders_List.Siz";
Debug.ShouldStop(32);
ccxt.__c.runVoidMethod ("LogImpl","73014659",RemoteObject.concat(RemoteObject.createImmutable("started with "),ccxt._calc._all_my_orders_list /*RemoteObject*/ .runMethod(true,"getSize"),RemoteObject.createImmutable(" orders")),0);
 BA.debugLineNum = 808;BA.debugLine="For i = 0 To Calc.All_My_Orders_List.Size-1";
Debug.ShouldStop(128);
{
final int step3 = 1;
final int limit3 = RemoteObject.solve(new RemoteObject[] {ccxt._calc._all_my_orders_list /*RemoteObject*/ .runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step3 > 0 && _i <= limit3) || (step3 < 0 && _i >= limit3) ;_i = ((int)(0 + _i + step3))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 809;BA.debugLine="Dim this As Order = Calc.All_My_Orders_List.Get(";
Debug.ShouldStop(256);
_this = (ccxt._calc._all_my_orders_list /*RemoteObject*/ .runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("this", _this);Debug.locals.put("this", _this);
 BA.debugLineNum = 810;BA.debugLine="If this.id = id Then";
Debug.ShouldStop(512);
if (RemoteObject.solveBoolean("=",_this.getField(true,"id" /*RemoteObject*/ ),_id)) { 
 BA.debugLineNum = 811;BA.debugLine="Log(\"Removed my \" & this.side & \" \" & this.Orde";
Debug.ShouldStop(1024);
ccxt.__c.runVoidMethod ("LogImpl","73014664",RemoteObject.concat(RemoteObject.createImmutable("Removed my "),_this.getField(true,"side" /*RemoteObject*/ ),RemoteObject.createImmutable(" "),_this.getField(true,"Order_Type" /*RemoteObject*/ ),RemoteObject.createImmutable(" Order for "),_this.getField(true,"Coinpair" /*RemoteObject*/ ),RemoteObject.createImmutable(" @ "),_this.getField(true,"Price" /*RemoteObject*/ )),0);
 BA.debugLineNum = 812;BA.debugLine="index = i";
Debug.ShouldStop(2048);
_index = BA.numberCast(int.class, _i);Debug.locals.put("index", _index);
 };
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 815;BA.debugLine="If index > -1 Then Calc.All_My_Orders_List.Remove";
Debug.ShouldStop(16384);
if (RemoteObject.solveBoolean(">",_index,BA.numberCast(double.class, -(double) (0 + 1)))) { 
ccxt._calc._all_my_orders_list /*RemoteObject*/ .runVoidMethod ("RemoveAt",(Object)(_index));};
 BA.debugLineNum = 817;BA.debugLine="Log(\"ended with \" & Calc.All_My_Orders_List.Size";
Debug.ShouldStop(65536);
ccxt.__c.runVoidMethod ("LogImpl","73014670",RemoteObject.concat(RemoteObject.createImmutable("ended with "),ccxt._calc._all_my_orders_list /*RemoteObject*/ .runMethod(true,"getSize"),RemoteObject.createImmutable(" orders")),0);
 BA.debugLineNum = 819;BA.debugLine="test_ui.Update_Orders";
Debug.ShouldStop(262144);
ccxt._test_ui.runVoidMethod ("_update_orders" /*RemoteObject*/ );
 BA.debugLineNum = 820;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _start_job(RemoteObject _call,RemoteObject _url,RemoteObject _input) throws Exception{
try {
		Debug.PushSubsStack("Start_Job (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,201);
if (RapidSub.canDelegate("start_job")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","start_job", _call, _url, _input);}
ResumableSub_Start_Job rsub = new ResumableSub_Start_Job(null,_call,_url,_input);
rsub.remoteResumableSub = anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSubForFilter();
rsub.resume(null, null);
return RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.keywords.Common.ResumableSubWrapper"), rsub.remoteResumableSub);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_Start_Job extends BA.ResumableSub {
public ResumableSub_Start_Job(b4j.example.ccxt parent,RemoteObject _call,RemoteObject _url,RemoteObject _input) {
this.parent = parent;
this._call = _call;
this._url = _url;
this._input = _input;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
b4j.example.ccxt parent;
RemoteObject _call;
RemoteObject _url;
RemoteObject _input;
RemoteObject _job = RemoteObject.declareNull("b4j.example.httpjob");
RemoteObject _result = RemoteObject.createImmutable("");
RemoteObject _jresult = RemoteObject.createImmutable("");

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("Start_Job (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,201);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
try {

        switch (state) {
            case -1:
{
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,RemoteObject.createImmutable(null));return;}
case 0:
//C
this.state = 1;
Debug.locals.put("Call", _call);
Debug.locals.put("URL", _url);
Debug.locals.put("Input", _input);
 BA.debugLineNum = 204;BA.debugLine="Dim Job As HttpJob";
Debug.ShouldStop(2048);
_job = RemoteObject.createNew ("b4j.example.httpjob");Debug.locals.put("Job", _job);
 BA.debugLineNum = 205;BA.debugLine="Job.Initialize(\"\", Me)";
Debug.ShouldStop(4096);
_job.runClassMethod (b4j.example.httpjob.class, "_initialize" /*RemoteObject*/ ,ccxt.ba,(Object)(BA.ObjectToString("")),(Object)(ccxt.getObject()));
 BA.debugLineNum = 206;BA.debugLine="Dim Result As String = \"Null\"";
Debug.ShouldStop(8192);
_result = BA.ObjectToString("Null");Debug.locals.put("Result", _result);Debug.locals.put("Result", _result);
 BA.debugLineNum = 208;BA.debugLine="Try";
Debug.ShouldStop(32768);
if (true) break;

case 1:
//try
this.state = 66;
this.catchState = 65;
this.state = 3;
if (true) break;

case 3:
//C
this.state = 4;
this.catchState = 65;
 BA.debugLineNum = 209;BA.debugLine="Job.Download(URL & \"?\" & Input)";
Debug.ShouldStop(65536);
_job.runClassMethod (b4j.example.httpjob.class, "_download" /*RemoteObject*/ ,(Object)(RemoteObject.concat(_url,RemoteObject.createImmutable("?"),_input)));
 BA.debugLineNum = 210;BA.debugLine="Wait For (Job) JobDone(Job As HttpJob)";
Debug.ShouldStop(131072);
parent.__c.runVoidMethod ("WaitFor","jobdone", ccxt.ba, anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "ccxt", "start_job"), (_job));
this.state = 67;
return;
case 67:
//C
this.state = 4;
_job = (RemoteObject) result.getArrayElement(false,RemoteObject.createImmutable(0));Debug.locals.put("Job", _job);
;
 BA.debugLineNum = 212;BA.debugLine="Log(\"B4J Job Success = \" & Job.Success)";
Debug.ShouldStop(524288);
parent.__c.runVoidMethod ("LogImpl","71900555",RemoteObject.concat(RemoteObject.createImmutable("B4J Job Success = "),_job.getField(true,"_success" /*RemoteObject*/ )),0);
 BA.debugLineNum = 214;BA.debugLine="If Job.Success Then";
Debug.ShouldStop(2097152);
if (true) break;

case 4:
//if
this.state = 63;
if (_job.getField(true,"_success" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
this.state = 6;
}else {
this.state = 62;
}if (true) break;

case 6:
//C
this.state = 7;
 BA.debugLineNum = 216;BA.debugLine="Result = Job.GetString";
Debug.ShouldStop(8388608);
_result = _job.runClassMethod (b4j.example.httpjob.class, "_getstring" /*RemoteObject*/ );Debug.locals.put("Result", _result);
 BA.debugLineNum = 217;BA.debugLine="Log(Result)";
Debug.ShouldStop(16777216);
parent.__c.runVoidMethod ("LogImpl","71900560",_result,0);
 BA.debugLineNum = 218;BA.debugLine="If Result <> \"Null\" Then";
Debug.ShouldStop(33554432);
if (true) break;

case 7:
//if
this.state = 60;
if (RemoteObject.solveBoolean("!",_result,BA.ObjectToString("Null"))) { 
this.state = 9;
}else {
this.state = 59;
}if (true) break;

case 9:
//C
this.state = 10;
 BA.debugLineNum = 219;BA.debugLine="Dim JResult As String = Filter_JSON_String(Res";
Debug.ShouldStop(67108864);
_jresult = _filter_json_string(_result);Debug.locals.put("JResult", _jresult);Debug.locals.put("JResult", _jresult);
 BA.debugLineNum = 221;BA.debugLine="Select Call";
Debug.ShouldStop(268435456);
if (true) break;

case 10:
//select
this.state = 57;
switch (BA.switchObjectToInt(_call,BA.ObjectToString("Test_PHP"),BA.ObjectToString("Test_CCXT"),BA.ObjectToString("Get_Exchanges"),BA.ObjectToString("Get_Exchange_Info"),BA.ObjectToString("Get_Markets"),BA.ObjectToString("Get_Ticker"),BA.ObjectToString("Get_All_Tickers"),BA.ObjectToString("Get_OrderBook"),BA.ObjectToString("Get_OHLCV"),BA.ObjectToString("Get_Public_Trade_History"),BA.ObjectToString("Get_My_Balances"),BA.ObjectToString("Get_My_Open_Orders"),BA.ObjectToString("Get_All_My_Open_Orders"),BA.ObjectToString("Get_My_Trade_History"),BA.ObjectToString("Get_All_My_Trade_History"),BA.ObjectToString("Create_Limit_Buy_Order"),BA.ObjectToString("Create_Limit_Sell_Order"),BA.ObjectToString("Edit_Limit_Order"),BA.ObjectToString("Place_Market_Buy_Order"),BA.ObjectToString("Place_Market_Sell_Order"),BA.ObjectToString("Cancel_Order"),BA.ObjectToString("Cancel_All_Orders"))) {
case 0: {
this.state = 12;
if (true) break;
}
case 1: {
this.state = 14;
if (true) break;
}
case 2: {
this.state = 16;
if (true) break;
}
case 3: {
this.state = 18;
if (true) break;
}
case 4: {
this.state = 20;
if (true) break;
}
case 5: {
this.state = 22;
if (true) break;
}
case 6: {
this.state = 24;
if (true) break;
}
case 7: {
this.state = 26;
if (true) break;
}
case 8: {
this.state = 28;
if (true) break;
}
case 9: {
this.state = 30;
if (true) break;
}
case 10: {
this.state = 32;
if (true) break;
}
case 11: {
this.state = 34;
if (true) break;
}
case 12: {
this.state = 36;
if (true) break;
}
case 13: {
this.state = 38;
if (true) break;
}
case 14: {
this.state = 40;
if (true) break;
}
case 15: {
this.state = 42;
if (true) break;
}
case 16: {
this.state = 44;
if (true) break;
}
case 17: {
this.state = 46;
if (true) break;
}
case 18: {
this.state = 48;
if (true) break;
}
case 19: {
this.state = 50;
if (true) break;
}
case 20: {
this.state = 52;
if (true) break;
}
case 21: {
this.state = 54;
if (true) break;
}
default: {
this.state = 56;
if (true) break;
}
}
if (true) break;

case 12:
//C
this.state = 57;
 if (true) break;

case 14:
//C
this.state = 57;
 if (true) break;

case 16:
//C
this.state = 57;
 BA.debugLineNum = 227;BA.debugLine="Get_Exchanges_completed(JResult)";
Debug.ShouldStop(4);
_get_exchanges_completed(_jresult);
 if (true) break;

case 18:
//C
this.state = 57;
 BA.debugLineNum = 229;BA.debugLine="Get_Exchange_Info_completed(JResult)";
Debug.ShouldStop(16);
_get_exchange_info_completed(_jresult);
 if (true) break;

case 20:
//C
this.state = 57;
 BA.debugLineNum = 231;BA.debugLine="Get_Markets_completed(JResult)";
Debug.ShouldStop(64);
_get_markets_completed(_jresult);
 if (true) break;

case 22:
//C
this.state = 57;
 BA.debugLineNum = 233;BA.debugLine="Get_Ticker_completed(JResult)";
Debug.ShouldStop(256);
_get_ticker_completed(_jresult);
 if (true) break;

case 24:
//C
this.state = 57;
 BA.debugLineNum = 235;BA.debugLine="Get_All_Tickers_completed(JResult)";
Debug.ShouldStop(1024);
_get_all_tickers_completed(_jresult);
 if (true) break;

case 26:
//C
this.state = 57;
 BA.debugLineNum = 237;BA.debugLine="Get_Orderbook_completed(JResult)";
Debug.ShouldStop(4096);
_get_orderbook_completed(_jresult);
 if (true) break;

case 28:
//C
this.state = 57;
 BA.debugLineNum = 239;BA.debugLine="Get_OHLCV_completed(JResult)";
Debug.ShouldStop(16384);
_get_ohlcv_completed(_jresult);
 if (true) break;

case 30:
//C
this.state = 57;
 if (true) break;

case 32:
//C
this.state = 57;
 BA.debugLineNum = 243;BA.debugLine="Get_My_Balances_completed(JResult)";
Debug.ShouldStop(262144);
_get_my_balances_completed(_jresult);
 if (true) break;

case 34:
//C
this.state = 57;
 BA.debugLineNum = 245;BA.debugLine="Get_All_My_Open_Orders_Completed(JResult)";
Debug.ShouldStop(1048576);
_get_all_my_open_orders_completed(_jresult);
 if (true) break;

case 36:
//C
this.state = 57;
 BA.debugLineNum = 247;BA.debugLine="Get_All_My_Open_Orders_Completed(JResult)";
Debug.ShouldStop(4194304);
_get_all_my_open_orders_completed(_jresult);
 if (true) break;

case 38:
//C
this.state = 57;
 BA.debugLineNum = 249;BA.debugLine="Get_My_Trade_History_Completed(JResult)";
Debug.ShouldStop(16777216);
_get_my_trade_history_completed(_jresult);
 if (true) break;

case 40:
//C
this.state = 57;
 BA.debugLineNum = 251;BA.debugLine="Get_All_My_Trade_History_Completed(JResult)";
Debug.ShouldStop(67108864);
_get_all_my_trade_history_completed(_jresult);
 if (true) break;

case 42:
//C
this.state = 57;
 BA.debugLineNum = 253;BA.debugLine="Order_Completed(JResult)";
Debug.ShouldStop(268435456);
_order_completed(_jresult);
 if (true) break;

case 44:
//C
this.state = 57;
 BA.debugLineNum = 255;BA.debugLine="Order_Completed(JResult)";
Debug.ShouldStop(1073741824);
_order_completed(_jresult);
 if (true) break;

case 46:
//C
this.state = 57;
 BA.debugLineNum = 257;BA.debugLine="Remove_My_Order(Canceled_Order_ID)					'Remo";
Debug.ShouldStop(1);
_remove_my_order(parent._canceled_order_id);
 BA.debugLineNum = 258;BA.debugLine="Order_Completed(JResult)";
Debug.ShouldStop(2);
_order_completed(_jresult);
 if (true) break;

case 48:
//C
this.state = 57;
 if (true) break;

case 50:
//C
this.state = 57;
 if (true) break;

case 52:
//C
this.state = 57;
 BA.debugLineNum = 265;BA.debugLine="Cancel_Order_Completed(JResult)";
Debug.ShouldStop(256);
_cancel_order_completed(_jresult);
 if (true) break;

case 54:
//C
this.state = 57;
 BA.debugLineNum = 267;BA.debugLine="Cancel_All_Orders_Completed(JResult)";
Debug.ShouldStop(1024);
_cancel_all_orders_completed(_jresult);
 if (true) break;

case 56:
//C
this.state = 57;
 BA.debugLineNum = 269;BA.debugLine="Log(\"Sub:Start_Job, Case \"\"\" & Call & \"\"\" DO";
Debug.ShouldStop(4096);
parent.__c.runVoidMethod ("LogImpl","71900612",RemoteObject.concat(RemoteObject.createImmutable("Sub:Start_Job, Case \""),_call,RemoteObject.createImmutable("\" DOES NOT EXIST!!!")),0);
 if (true) break;

case 57:
//C
this.state = 60;
;
 if (true) break;

case 59:
//C
this.state = 60;
 BA.debugLineNum = 272;BA.debugLine="LogError(\"result = \" & Result)";
Debug.ShouldStop(32768);
parent.__c.runVoidMethod ("LogError",(Object)(RemoteObject.concat(RemoteObject.createImmutable("result = "),_result)));
 if (true) break;

case 60:
//C
this.state = 63;
;
 if (true) break;

case 62:
//C
this.state = 63;
 BA.debugLineNum = 276;BA.debugLine="LogError(\"Job Failed!!!\")";
Debug.ShouldStop(524288);
parent.__c.runVoidMethod ("LogError",(Object)(RemoteObject.createImmutable("Job Failed!!!")));
 BA.debugLineNum = 277;BA.debugLine="Result = Job.ErrorMessage";
Debug.ShouldStop(1048576);
_result = _job.getField(true,"_errormessage" /*RemoteObject*/ );Debug.locals.put("Result", _result);
 if (true) break;

case 63:
//C
this.state = 66;
;
 Debug.CheckDeviceExceptions();
if (true) break;

case 65:
//C
this.state = 66;
this.catchState = 0;
 BA.debugLineNum = 282;BA.debugLine="Log(LastException)";
Debug.ShouldStop(33554432);
parent.__c.runVoidMethod ("LogImpl","71900625",BA.ObjectToString(parent.__c.runMethod(false,"LastException",ccxt.ba)),0);
 if (true) break;
if (true) break;

case 66:
//C
this.state = -1;
this.catchState = 0;
;
 BA.debugLineNum = 285;BA.debugLine="Job.Release";
Debug.ShouldStop(268435456);
_job.runClassMethod (b4j.example.httpjob.class, "_release" /*RemoteObject*/ );
 BA.debugLineNum = 286;BA.debugLine="Return Result";
Debug.ShouldStop(536870912);
if (true) {
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,(_result));return;};
 BA.debugLineNum = 287;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
if (true) break;
}} 
       catch (Exception e0) {
			
if (catchState == 0)
    throw e0;
else {
    state = catchState;
BA.rdebugUtils.runVoidMethod("setLastException",ccxt.ba, e0.toString());}
            }
        }
    }
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}
public static void  _jobdone(RemoteObject _job) throws Exception{
}
public static RemoteObject  _test_ccxt() throws Exception{
try {
		Debug.PushSubsStack("Test_CCXT (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,49);
if (RapidSub.canDelegate("test_ccxt")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","test_ccxt");}
RemoteObject _input = RemoteObject.createImmutable("");
 BA.debugLineNum = 49;BA.debugLine="Sub Test_CCXT";
Debug.ShouldStop(65536);
 BA.debugLineNum = 50;BA.debugLine="Dim input As String = \"bot=NA&command=Test_CCXT\"";
Debug.ShouldStop(131072);
_input = BA.ObjectToString("bot=NA&command=Test_CCXT");Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 51;BA.debugLine="API_Call(\"Test_CCXT\", input)";
Debug.ShouldStop(262144);
_api_call(BA.ObjectToString("Test_CCXT"),_input);
 BA.debugLineNum = 52;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _test_php() throws Exception{
try {
		Debug.PushSubsStack("Test_PHP (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,44);
if (RapidSub.canDelegate("test_php")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","test_php");}
RemoteObject _input = RemoteObject.createImmutable("");
 BA.debugLineNum = 44;BA.debugLine="Sub Test_PHP";
Debug.ShouldStop(2048);
 BA.debugLineNum = 45;BA.debugLine="Dim input As String = \"bot=NA&command=Test_PHP\"";
Debug.ShouldStop(4096);
_input = BA.ObjectToString("bot=NA&command=Test_PHP");Debug.locals.put("input", _input);Debug.locals.put("input", _input);
 BA.debugLineNum = 46;BA.debugLine="API_Call(\"Test_PHP\", input)";
Debug.ShouldStop(8192);
_api_call(BA.ObjectToString("Test_PHP"),_input);
 BA.debugLineNum = 47;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _ticker(RemoteObject _coinpair) throws Exception{
try {
		Debug.PushSubsStack("Ticker (ccxt) ","ccxt",1,ccxt.ba,ccxt.mostCurrent,895);
if (RapidSub.canDelegate("ticker")) { return b4j.example.ccxt.remoteMe.runUserSub(false, "ccxt","ticker", _coinpair);}
Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 895;BA.debugLine="Sub Ticker(coinpair As String)";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 896;BA.debugLine="fetch_ticker(coinpair)";
Debug.ShouldStop(-2147483648);
_fetch_ticker(_coinpair);
 BA.debugLineNum = 897;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}