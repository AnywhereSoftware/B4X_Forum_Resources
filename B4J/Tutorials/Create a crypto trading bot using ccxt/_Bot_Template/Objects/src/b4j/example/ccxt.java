package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;

public class ccxt extends Object{
public static ccxt mostCurrent = new ccxt();

public static BA ba;
static {
		ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.ccxt", null);
		ba.loadHtSubs(ccxt.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			
			ba.raiseEvent2(null, true, "SHELL", false);
			ba.raiseEvent2(null, true, "CREATE", true, "b4j.example.ccxt", ba);
		}
	}
    public static Class<?> getObject() {
		return ccxt.class;
	}

 
public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4j.objects.JFX _fx = null;
public static int _php_port = 0;
public static String _php_url = "";
public static anywheresoftware.b4j.objects.collections.JSONParser _json = null;
public static anywheresoftware.b4a.objects.collections.Map _buy_orderbook_map = null;
public static anywheresoftware.b4a.objects.collections.Map _sell_orderbook_map = null;
public static anywheresoftware.b4a.objects.collections.List _coinpair_list = null;
public static anywheresoftware.b4a.objects.collections.List _pcoin_list = null;
public static anywheresoftware.b4a.objects.collections.List _scoin_list = null;
public static anywheresoftware.b4a.objects.collections.List _ohlcv_timeframe_list = null;
public static String _canceled_order_id = "";
public static anywheresoftware.b4a.objects.collections.Map _exchange_info_map = null;
public static b4j.example.cssutils _cssutils = null;
public static b4j.example.main _main = null;
public static b4j.example.calc _calc = null;
public static b4j.example.test_ui _test_ui = null;
public static b4j.example.httputils2service _httputils2service = null;
public static String  _add_my_order(long _ts,String _coinpair,String _side,String _id,double _price,double _volume,double _filled,double _remaining,String _order_type,String _status) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "add_my_order", false))
	 {return ((String) Debug.delegate(ba, "add_my_order", new Object[] {_ts,_coinpair,_side,_id,_price,_volume,_filled,_remaining,_order_type,_status}));}
double _total = 0;
b4j.example.calc._order _this = null;
boolean _already_exists = false;
int _i = 0;
b4j.example.calc._order _compare_order = null;
RDebugUtils.currentLine=2949120;
 //BA.debugLineNum = 2949120;BA.debugLine="Sub Add_My_Order(TS As Long, Coinpair As String, S";
RDebugUtils.currentLine=2949121;
 //BA.debugLineNum = 2949121;BA.debugLine="If id <> \"none\" Then";
if ((_id).equals("none") == false) { 
RDebugUtils.currentLine=2949122;
 //BA.debugLineNum = 2949122;BA.debugLine="Dim total As Double = Price * Volume";
_total = _price*_volume;
RDebugUtils.currentLine=2949123;
 //BA.debugLineNum = 2949123;BA.debugLine="Dim this As Order : this.Initialize";
_this = new b4j.example.calc._order();
RDebugUtils.currentLine=2949123;
 //BA.debugLineNum = 2949123;BA.debugLine="Dim this As Order : this.Initialize";
_this.Initialize();
RDebugUtils.currentLine=2949125;
 //BA.debugLineNum = 2949125;BA.debugLine="Dim already_exists As Boolean = False";
_already_exists = anywheresoftware.b4a.keywords.Common.False;
RDebugUtils.currentLine=2949126;
 //BA.debugLineNum = 2949126;BA.debugLine="For i = 0 To Calc.All_My_Orders_List.Size-1";
{
final int step6 = 1;
final int limit6 = (int) (_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .getSize()-1);
_i = (int) (0) ;
for (;_i <= limit6 ;_i = _i + step6 ) {
RDebugUtils.currentLine=2949127;
 //BA.debugLineNum = 2949127;BA.debugLine="Dim compare_order As Order = Calc.All_My_Orders_";
_compare_order = (b4j.example.calc._order)(_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .Get(_i));
RDebugUtils.currentLine=2949128;
 //BA.debugLineNum = 2949128;BA.debugLine="If compare_order.id = id Then already_exists = T";
if ((_compare_order.id /*String*/ ).equals(_id)) { 
_already_exists = anywheresoftware.b4a.keywords.Common.True;};
 }
};
RDebugUtils.currentLine=2949130;
 //BA.debugLineNum = 2949130;BA.debugLine="If already_exists = True Then";
if (_already_exists==anywheresoftware.b4a.keywords.Common.True) { 
RDebugUtils.currentLine=2949131;
 //BA.debugLineNum = 2949131;BA.debugLine="Log(\"Order '\" & id & \"' already exists\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72949131","Order '"+_id+"' already exists",0);
 }else {
RDebugUtils.currentLine=2949133;
 //BA.debugLineNum = 2949133;BA.debugLine="this.TS = TS : this.Coinpair = Coinpair : this.s";
_this.TS /*long*/  = _ts;
RDebugUtils.currentLine=2949133;
 //BA.debugLineNum = 2949133;BA.debugLine="this.TS = TS : this.Coinpair = Coinpair : this.s";
_this.Coinpair /*String*/  = _coinpair;
RDebugUtils.currentLine=2949133;
 //BA.debugLineNum = 2949133;BA.debugLine="this.TS = TS : this.Coinpair = Coinpair : this.s";
_this.side /*String*/  = _side;
RDebugUtils.currentLine=2949133;
 //BA.debugLineNum = 2949133;BA.debugLine="this.TS = TS : this.Coinpair = Coinpair : this.s";
_this.id /*String*/  = _id;
RDebugUtils.currentLine=2949133;
 //BA.debugLineNum = 2949133;BA.debugLine="this.TS = TS : this.Coinpair = Coinpair : this.s";
_this.Price /*double*/  = _price;
RDebugUtils.currentLine=2949133;
 //BA.debugLineNum = 2949133;BA.debugLine="this.TS = TS : this.Coinpair = Coinpair : this.s";
_this.Volume /*double*/  = _volume;
RDebugUtils.currentLine=2949133;
 //BA.debugLineNum = 2949133;BA.debugLine="this.TS = TS : this.Coinpair = Coinpair : this.s";
_this.Total /*double*/  = _total;
RDebugUtils.currentLine=2949134;
 //BA.debugLineNum = 2949134;BA.debugLine="this.filled = Filled : this.remaining = Remainin";
_this.filled /*double*/  = _filled;
RDebugUtils.currentLine=2949134;
 //BA.debugLineNum = 2949134;BA.debugLine="this.filled = Filled : this.remaining = Remainin";
_this.remaining /*double*/  = _remaining;
RDebugUtils.currentLine=2949135;
 //BA.debugLineNum = 2949135;BA.debugLine="this.Order_Type = Order_Type									'limit";
_this.Order_Type /*String*/  = _order_type;
RDebugUtils.currentLine=2949136;
 //BA.debugLineNum = 2949136;BA.debugLine="this.Status = Status													'open";
_this.Status /*String*/  = _status;
RDebugUtils.currentLine=2949137;
 //BA.debugLineNum = 2949137;BA.debugLine="Calc.All_My_Orders_List.Add(this)";
_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .Add((Object)(_this));
RDebugUtils.currentLine=2949140;
 //BA.debugLineNum = 2949140;BA.debugLine="test_ui.Update_Orders";
_test_ui._update_orders /*String*/ ();
RDebugUtils.currentLine=2949141;
 //BA.debugLineNum = 2949141;BA.debugLine="Log(\"Added my \" & this.side & \" \" & this.Order_T";
anywheresoftware.b4a.keywords.Common.LogImpl("72949141","Added my "+_this.side /*String*/ +" "+_this.Order_Type /*String*/ +" Order for "+_this.Coinpair /*String*/ +" @ "+BA.NumberToString(_this.Price /*double*/ ),0);
 };
 };
RDebugUtils.currentLine=2949145;
 //BA.debugLineNum = 2949145;BA.debugLine="End Sub";
return "";
}
public static String  _add_my_trade(long _ts,String _coinpair,String _side,String _trade_id,String _order_id,double _price,double _volume,String _trade_type,double _fee,String _fee_currency) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "add_my_trade", false))
	 {return ((String) Debug.delegate(ba, "add_my_trade", new Object[] {_ts,_coinpair,_side,_trade_id,_order_id,_price,_volume,_trade_type,_fee,_fee_currency}));}
double _total = 0;
b4j.example.calc._amt _this = null;
RDebugUtils.currentLine=2883584;
 //BA.debugLineNum = 2883584;BA.debugLine="Sub Add_My_Trade(TS As Long, Coinpair As String, S";
RDebugUtils.currentLine=2883586;
 //BA.debugLineNum = 2883586;BA.debugLine="Dim total As Double = price * volume";
_total = _price*_volume;
RDebugUtils.currentLine=2883587;
 //BA.debugLineNum = 2883587;BA.debugLine="Dim this As AMT";
_this = new b4j.example.calc._amt();
RDebugUtils.currentLine=2883588;
 //BA.debugLineNum = 2883588;BA.debugLine="this.TS = TS												'1502962946216";
_this.TS /*long*/  = _ts;
RDebugUtils.currentLine=2883589;
 //BA.debugLineNum = 2883589;BA.debugLine="this.Coinpair = Coinpair								'ETH/BTC";
_this.Coinpair /*String*/  = _coinpair;
RDebugUtils.currentLine=2883590;
 //BA.debugLineNum = 2883590;BA.debugLine="this.Side = Side											'buy";
_this.Side /*String*/  = _side;
RDebugUtils.currentLine=2883591;
 //BA.debugLineNum = 2883591;BA.debugLine="this.trade_id = trade_id								'12345-67890:0987";
_this.trade_id /*String*/  = _trade_id;
RDebugUtils.currentLine=2883592;
 //BA.debugLineNum = 2883592;BA.debugLine="this.order_id = order_id								'12345-67890:0987";
_this.order_id /*String*/  = _order_id;
RDebugUtils.currentLine=2883593;
 //BA.debugLineNum = 2883593;BA.debugLine="this.Price = price										'0.06917684";
_this.Price /*double*/  = _price;
RDebugUtils.currentLine=2883594;
 //BA.debugLineNum = 2883594;BA.debugLine="this.Volume = volume								'1.5";
_this.Volume /*double*/  = _volume;
RDebugUtils.currentLine=2883595;
 //BA.debugLineNum = 2883595;BA.debugLine="this.total = total											'0.10376526";
_this.Total /*double*/  = _total;
RDebugUtils.currentLine=2883596;
 //BA.debugLineNum = 2883596;BA.debugLine="this.trade_type = trade_type						'limit";
_this.trade_type /*String*/  = _trade_type;
RDebugUtils.currentLine=2883597;
 //BA.debugLineNum = 2883597;BA.debugLine="this.Fee = fee												'0.0015";
_this.Fee /*double*/  = _fee;
RDebugUtils.currentLine=2883598;
 //BA.debugLineNum = 2883598;BA.debugLine="this.Fee_Currency = fee_currency			'ETH";
_this.Fee_Currency /*String*/  = _fee_currency;
RDebugUtils.currentLine=2883599;
 //BA.debugLineNum = 2883599;BA.debugLine="Calc.All_My_Trades_List.Add(this)";
_calc._all_my_trades_list /*anywheresoftware.b4a.objects.collections.List*/ .Add((Object)(_this));
RDebugUtils.currentLine=2883600;
 //BA.debugLineNum = 2883600;BA.debugLine="End Sub";
return "";
}
public static String  _all_my_open_orders() throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "all_my_open_orders", false))
	 {return ((String) Debug.delegate(ba, "all_my_open_orders", null));}
RDebugUtils.currentLine=3801088;
 //BA.debugLineNum = 3801088;BA.debugLine="Sub All_My_Open_Orders		'optional ccxt variables (";
RDebugUtils.currentLine=3801089;
 //BA.debugLineNum = 3801089;BA.debugLine="fetch_all_open_orders";
_fetch_all_open_orders();
RDebugUtils.currentLine=3801090;
 //BA.debugLineNum = 3801090;BA.debugLine="End Sub";
return "";
}
public static String  _fetch_all_open_orders() throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "fetch_all_open_orders", false))
	 {return ((String) Debug.delegate(ba, "fetch_all_open_orders", null));}
String _input = "";
RDebugUtils.currentLine=1114112;
 //BA.debugLineNum = 1114112;BA.debugLine="Sub fetch_all_open_orders		'optional ccxt variable";
RDebugUtils.currentLine=1114113;
 //BA.debugLineNum = 1114113;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&command=fetch_all_open_orders";
RDebugUtils.currentLine=1114114;
 //BA.debugLineNum = 1114114;BA.debugLine="API_Call(\"Get_All_My_Open_Orders\", input)";
_api_call("Get_All_My_Open_Orders",_input);
RDebugUtils.currentLine=1114115;
 //BA.debugLineNum = 1114115;BA.debugLine="End Sub";
return "";
}
public static String  _all_my_trade_history(long _since,int _limit) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "all_my_trade_history", false))
	 {return ((String) Debug.delegate(ba, "all_my_trade_history", new Object[] {_since,_limit}));}
RDebugUtils.currentLine=3932160;
 //BA.debugLineNum = 3932160;BA.debugLine="Sub All_My_Trade_History(since As Long, limit As I";
RDebugUtils.currentLine=3932161;
 //BA.debugLineNum = 3932161;BA.debugLine="fetch_all_my_trades(since, limit)";
_fetch_all_my_trades(_since,_limit);
RDebugUtils.currentLine=3932162;
 //BA.debugLineNum = 3932162;BA.debugLine="End Sub";
return "";
}
public static String  _fetch_all_my_trades(long _since,int _limit) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "fetch_all_my_trades", false))
	 {return ((String) Debug.delegate(ba, "fetch_all_my_trades", new Object[] {_since,_limit}));}
String _input = "";
RDebugUtils.currentLine=1245184;
 //BA.debugLineNum = 1245184;BA.debugLine="Sub fetch_all_my_trades(since As Long, limit As In";
RDebugUtils.currentLine=1245185;
 //BA.debugLineNum = 1245185;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&limit="+BA.NumberToString(_limit)+"&since="+BA.NumberToString(_since)+"&command=fetch_all_my_trades";
RDebugUtils.currentLine=1245186;
 //BA.debugLineNum = 1245186;BA.debugLine="API_Call(\"Get_All_My_Trade_History\", input)";
_api_call("Get_All_My_Trade_History",_input);
RDebugUtils.currentLine=1245187;
 //BA.debugLineNum = 1245187;BA.debugLine="End Sub";
return "";
}
public static String  _all_tickers() throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "all_tickers", false))
	 {return ((String) Debug.delegate(ba, "all_tickers", null));}
RDebugUtils.currentLine=3407872;
 //BA.debugLineNum = 3407872;BA.debugLine="Sub All_Tickers";
RDebugUtils.currentLine=3407873;
 //BA.debugLineNum = 3407873;BA.debugLine="fetch_tickers";
_fetch_tickers();
RDebugUtils.currentLine=3407874;
 //BA.debugLineNum = 3407874;BA.debugLine="End Sub";
return "";
}
public static String  _fetch_tickers() throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "fetch_tickers", false))
	 {return ((String) Debug.delegate(ba, "fetch_tickers", null));}
String _input = "";
RDebugUtils.currentLine=720896;
 //BA.debugLineNum = 720896;BA.debugLine="Sub fetch_tickers";
RDebugUtils.currentLine=720897;
 //BA.debugLineNum = 720897;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&command=fetch_tickers";
RDebugUtils.currentLine=720898;
 //BA.debugLineNum = 720898;BA.debugLine="API_Call(\"Get_All_Tickers\", input)";
_api_call("Get_All_Tickers",_input);
RDebugUtils.currentLine=720899;
 //BA.debugLineNum = 720899;BA.debugLine="End Sub";
return "";
}
public static void  _api_call(String _call,String _input) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "api_call", false))
	 {Debug.delegate(ba, "api_call", new Object[] {_call,_input}); return;}
ResumableSub_API_Call rsub = new ResumableSub_API_Call(null,_call,_input);
rsub.resume(ba, null);
}
public static class ResumableSub_API_Call extends BA.ResumableSub {
public ResumableSub_API_Call(b4j.example.ccxt parent,String _call,String _input) {
this.parent = parent;
this._call = _call;
this._input = _input;
}
b4j.example.ccxt parent;
String _call;
String _input;
String _result = "";

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="ccxt";

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = -1;
RDebugUtils.currentLine=1835009;
 //BA.debugLineNum = 1835009;BA.debugLine="Log(\"-------------------- API Call '\" & Call & \"'";
anywheresoftware.b4a.keywords.Common.LogImpl("71835009","-------------------- API Call '"+_call+"' --------------------",0);
RDebugUtils.currentLine=1835010;
 //BA.debugLineNum = 1835010;BA.debugLine="Log(\"Wait For(Start_Job(\" & Call & \", \" & PHP_URL";
anywheresoftware.b4a.keywords.Common.LogImpl("71835010","Wait For(Start_Job("+_call+", "+parent._php_url+", "+_input+")) Complete (Result As String)",0);
RDebugUtils.currentLine=1835011;
 //BA.debugLineNum = 1835011;BA.debugLine="Wait For(Start_Job(Call, PHP_URL, input)) Complet";
anywheresoftware.b4a.keywords.Common.WaitFor("complete", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "ccxt", "api_call"), _start_job(_call,parent._php_url,_input));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_result = (String) result[0];
;
RDebugUtils.currentLine=1835014;
 //BA.debugLineNum = 1835014;BA.debugLine="test_ui.txt_Output.Text = Result";
parent._test_ui._txt_output /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextAreaWrapper*/ .setText(_result);
RDebugUtils.currentLine=1835015;
 //BA.debugLineNum = 1835015;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public static anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _start_job(String _call,String _url,String _input) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "start_job", false))
	 {return ((anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) Debug.delegate(ba, "start_job", new Object[] {_call,_url,_input}));}
ResumableSub_Start_Job rsub = new ResumableSub_Start_Job(null,_call,_url,_input);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_Start_Job extends BA.ResumableSub {
public ResumableSub_Start_Job(b4j.example.ccxt parent,String _call,String _url,String _input) {
this.parent = parent;
this._call = _call;
this._url = _url;
this._input = _input;
}
b4j.example.ccxt parent;
String _call;
String _url;
String _input;
b4j.example.httpjob _job = null;
String _result = "";
String _jresult = "";

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="ccxt";

    while (true) {
try {

        switch (state) {
            case -1:
{
anywheresoftware.b4a.keywords.Common.ReturnFromResumableSub(this,null);return;}
case 0:
//C
this.state = 1;
RDebugUtils.currentLine=1900547;
 //BA.debugLineNum = 1900547;BA.debugLine="Dim Job As HttpJob";
_job = new b4j.example.httpjob();
RDebugUtils.currentLine=1900548;
 //BA.debugLineNum = 1900548;BA.debugLine="Job.Initialize(\"\", Me)";
_job._initialize /*String*/ (null,ba,"",ccxt.getObject());
RDebugUtils.currentLine=1900549;
 //BA.debugLineNum = 1900549;BA.debugLine="Dim Result As String = \"Null\"";
_result = "Null";
RDebugUtils.currentLine=1900551;
 //BA.debugLineNum = 1900551;BA.debugLine="Try";
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
RDebugUtils.currentLine=1900552;
 //BA.debugLineNum = 1900552;BA.debugLine="Job.Download(URL & \"?\" & Input)";
_job._download /*String*/ (null,_url+"?"+_input);
RDebugUtils.currentLine=1900553;
 //BA.debugLineNum = 1900553;BA.debugLine="Wait For (Job) JobDone(Job As HttpJob)";
anywheresoftware.b4a.keywords.Common.WaitFor("jobdone", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "ccxt", "start_job"), (Object)(_job));
this.state = 67;
return;
case 67:
//C
this.state = 4;
_job = (b4j.example.httpjob) result[0];
;
RDebugUtils.currentLine=1900555;
 //BA.debugLineNum = 1900555;BA.debugLine="Log(\"B4J Job Success = \" & Job.Success)";
anywheresoftware.b4a.keywords.Common.LogImpl("71900555","B4J Job Success = "+BA.ObjectToString(_job._success /*boolean*/ ),0);
RDebugUtils.currentLine=1900557;
 //BA.debugLineNum = 1900557;BA.debugLine="If Job.Success Then";
if (true) break;

case 4:
//if
this.state = 63;
if (_job._success /*boolean*/ ) { 
this.state = 6;
}else {
this.state = 62;
}if (true) break;

case 6:
//C
this.state = 7;
RDebugUtils.currentLine=1900559;
 //BA.debugLineNum = 1900559;BA.debugLine="Result = Job.GetString";
_result = _job._getstring /*String*/ (null);
RDebugUtils.currentLine=1900560;
 //BA.debugLineNum = 1900560;BA.debugLine="Log(Result)";
anywheresoftware.b4a.keywords.Common.LogImpl("71900560",_result,0);
RDebugUtils.currentLine=1900561;
 //BA.debugLineNum = 1900561;BA.debugLine="If Result <> \"Null\" Then";
if (true) break;

case 7:
//if
this.state = 60;
if ((_result).equals("Null") == false) { 
this.state = 9;
}else {
this.state = 59;
}if (true) break;

case 9:
//C
this.state = 10;
RDebugUtils.currentLine=1900562;
 //BA.debugLineNum = 1900562;BA.debugLine="Dim JResult As String = Filter_JSON_String(Res";
_jresult = _filter_json_string(_result);
RDebugUtils.currentLine=1900564;
 //BA.debugLineNum = 1900564;BA.debugLine="Select Call";
if (true) break;

case 10:
//select
this.state = 57;
switch (BA.switchObjectToInt(_call,"Test_PHP","Test_CCXT","Get_Exchanges","Get_Exchange_Info","Get_Markets","Get_Ticker","Get_All_Tickers","Get_OrderBook","Get_OHLCV","Get_Public_Trade_History","Get_My_Balances","Get_My_Open_Orders","Get_All_My_Open_Orders","Get_My_Trade_History","Get_All_My_Trade_History","Create_Limit_Buy_Order","Create_Limit_Sell_Order","Edit_Limit_Order","Place_Market_Buy_Order","Place_Market_Sell_Order","Cancel_Order","Cancel_All_Orders")) {
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
RDebugUtils.currentLine=1900570;
 //BA.debugLineNum = 1900570;BA.debugLine="Get_Exchanges_completed(JResult)";
_get_exchanges_completed(_jresult);
 if (true) break;

case 18:
//C
this.state = 57;
RDebugUtils.currentLine=1900572;
 //BA.debugLineNum = 1900572;BA.debugLine="Get_Exchange_Info_completed(JResult)";
_get_exchange_info_completed(_jresult);
 if (true) break;

case 20:
//C
this.state = 57;
RDebugUtils.currentLine=1900574;
 //BA.debugLineNum = 1900574;BA.debugLine="Get_Markets_completed(JResult)";
_get_markets_completed(_jresult);
 if (true) break;

case 22:
//C
this.state = 57;
RDebugUtils.currentLine=1900576;
 //BA.debugLineNum = 1900576;BA.debugLine="Get_Ticker_completed(JResult)";
_get_ticker_completed(_jresult);
 if (true) break;

case 24:
//C
this.state = 57;
RDebugUtils.currentLine=1900578;
 //BA.debugLineNum = 1900578;BA.debugLine="Get_All_Tickers_completed(JResult)";
_get_all_tickers_completed(_jresult);
 if (true) break;

case 26:
//C
this.state = 57;
RDebugUtils.currentLine=1900580;
 //BA.debugLineNum = 1900580;BA.debugLine="Get_Orderbook_completed(JResult)";
_get_orderbook_completed(_jresult);
 if (true) break;

case 28:
//C
this.state = 57;
RDebugUtils.currentLine=1900582;
 //BA.debugLineNum = 1900582;BA.debugLine="Get_OHLCV_completed(JResult)";
_get_ohlcv_completed(_jresult);
 if (true) break;

case 30:
//C
this.state = 57;
 if (true) break;

case 32:
//C
this.state = 57;
RDebugUtils.currentLine=1900586;
 //BA.debugLineNum = 1900586;BA.debugLine="Get_My_Balances_completed(JResult)";
_get_my_balances_completed(_jresult);
 if (true) break;

case 34:
//C
this.state = 57;
RDebugUtils.currentLine=1900588;
 //BA.debugLineNum = 1900588;BA.debugLine="Get_All_My_Open_Orders_Completed(JResult)";
_get_all_my_open_orders_completed(_jresult);
 if (true) break;

case 36:
//C
this.state = 57;
RDebugUtils.currentLine=1900590;
 //BA.debugLineNum = 1900590;BA.debugLine="Get_All_My_Open_Orders_Completed(JResult)";
_get_all_my_open_orders_completed(_jresult);
 if (true) break;

case 38:
//C
this.state = 57;
RDebugUtils.currentLine=1900592;
 //BA.debugLineNum = 1900592;BA.debugLine="Get_My_Trade_History_Completed(JResult)";
_get_my_trade_history_completed(_jresult);
 if (true) break;

case 40:
//C
this.state = 57;
RDebugUtils.currentLine=1900594;
 //BA.debugLineNum = 1900594;BA.debugLine="Get_All_My_Trade_History_Completed(JResult)";
_get_all_my_trade_history_completed(_jresult);
 if (true) break;

case 42:
//C
this.state = 57;
RDebugUtils.currentLine=1900596;
 //BA.debugLineNum = 1900596;BA.debugLine="Order_Completed(JResult)";
_order_completed(_jresult);
 if (true) break;

case 44:
//C
this.state = 57;
RDebugUtils.currentLine=1900598;
 //BA.debugLineNum = 1900598;BA.debugLine="Order_Completed(JResult)";
_order_completed(_jresult);
 if (true) break;

case 46:
//C
this.state = 57;
RDebugUtils.currentLine=1900600;
 //BA.debugLineNum = 1900600;BA.debugLine="Remove_My_Order(Canceled_Order_ID)					'Remo";
_remove_my_order(parent._canceled_order_id);
RDebugUtils.currentLine=1900601;
 //BA.debugLineNum = 1900601;BA.debugLine="Order_Completed(JResult)";
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
RDebugUtils.currentLine=1900608;
 //BA.debugLineNum = 1900608;BA.debugLine="Cancel_Order_Completed(JResult)";
_cancel_order_completed(_jresult);
 if (true) break;

case 54:
//C
this.state = 57;
RDebugUtils.currentLine=1900610;
 //BA.debugLineNum = 1900610;BA.debugLine="Cancel_All_Orders_Completed(JResult)";
_cancel_all_orders_completed(_jresult);
 if (true) break;

case 56:
//C
this.state = 57;
RDebugUtils.currentLine=1900612;
 //BA.debugLineNum = 1900612;BA.debugLine="Log(\"Sub:Start_Job, Case \"\"\" & Call & \"\"\" DO";
anywheresoftware.b4a.keywords.Common.LogImpl("71900612","Sub:Start_Job, Case \""+_call+"\" DOES NOT EXIST!!!",0);
 if (true) break;

case 57:
//C
this.state = 60;
;
 if (true) break;

case 59:
//C
this.state = 60;
RDebugUtils.currentLine=1900615;
 //BA.debugLineNum = 1900615;BA.debugLine="LogError(\"result = \" & Result)";
anywheresoftware.b4a.keywords.Common.LogError("result = "+_result);
 if (true) break;

case 60:
//C
this.state = 63;
;
 if (true) break;

case 62:
//C
this.state = 63;
RDebugUtils.currentLine=1900619;
 //BA.debugLineNum = 1900619;BA.debugLine="LogError(\"Job Failed!!!\")";
anywheresoftware.b4a.keywords.Common.LogError("Job Failed!!!");
RDebugUtils.currentLine=1900620;
 //BA.debugLineNum = 1900620;BA.debugLine="Result = Job.ErrorMessage";
_result = _job._errormessage /*String*/ ;
 if (true) break;

case 63:
//C
this.state = 66;
;
 if (true) break;

case 65:
//C
this.state = 66;
this.catchState = 0;
RDebugUtils.currentLine=1900625;
 //BA.debugLineNum = 1900625;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("71900625",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 if (true) break;
if (true) break;

case 66:
//C
this.state = -1;
this.catchState = 0;
;
RDebugUtils.currentLine=1900628;
 //BA.debugLineNum = 1900628;BA.debugLine="Job.Release";
_job._release /*String*/ (null);
RDebugUtils.currentLine=1900629;
 //BA.debugLineNum = 1900629;BA.debugLine="Return Result";
if (true) {
anywheresoftware.b4a.keywords.Common.ReturnFromResumableSub(this,(Object)(_result));return;};
RDebugUtils.currentLine=1900630;
 //BA.debugLineNum = 1900630;BA.debugLine="End Sub";
if (true) break;
}} 
       catch (Exception e0) {
			
if (catchState == 0)
    throw e0;
else {
    state = catchState;
ba.setLastException(e0);}
            }
        }
    }
}
public static String  _cancel_all_orders() throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "cancel_all_orders", false))
	 {return ((String) Debug.delegate(ba, "cancel_all_orders", null));}
String _input = "";
RDebugUtils.currentLine=1638400;
 //BA.debugLineNum = 1638400;BA.debugLine="Sub cancel_all_orders";
RDebugUtils.currentLine=1638401;
 //BA.debugLineNum = 1638401;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&command=cancel_all_orders";
RDebugUtils.currentLine=1638402;
 //BA.debugLineNum = 1638402;BA.debugLine="API_Call(\"Cancel_All_Orders\", input)";
_api_call("Cancel_All_Orders",_input);
RDebugUtils.currentLine=1638403;
 //BA.debugLineNum = 1638403;BA.debugLine="End Sub";
return "";
}
public static String  _cancel_all_orders_completed(String _result) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "cancel_all_orders_completed", false))
	 {return ((String) Debug.delegate(ba, "cancel_all_orders_completed", new Object[] {_result}));}
anywheresoftware.b4a.objects.collections.Map _m1 = null;
anywheresoftware.b4a.objects.collections.Map _m2 = null;
int _count = 0;
anywheresoftware.b4a.objects.collections.List _l1 = null;
int _i = 0;
String _id = "";
RDebugUtils.currentLine=2818048;
 //BA.debugLineNum = 2818048;BA.debugLine="Private Sub Cancel_All_Orders_Completed(result As";
RDebugUtils.currentLine=2818049;
 //BA.debugLineNum = 2818049;BA.debugLine="Log(\"Cancel_All_Orders_Completed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72818049","Cancel_All_Orders_Completed",0);
RDebugUtils.currentLine=2818050;
 //BA.debugLineNum = 2818050;BA.debugLine="Try";
try {RDebugUtils.currentLine=2818051;
 //BA.debugLineNum = 2818051;BA.debugLine="Log(result)";
anywheresoftware.b4a.keywords.Common.LogImpl("72818051",_result,0);
RDebugUtils.currentLine=2818053;
 //BA.debugLineNum = 2818053;BA.debugLine="If Is_JSON(result) = True Then";
if (_is_json(_result)==anywheresoftware.b4a.keywords.Common.True) { 
RDebugUtils.currentLine=2818054;
 //BA.debugLineNum = 2818054;BA.debugLine="JSON.Initialize(result)";
_json.Initialize(_result);
RDebugUtils.currentLine=2818055;
 //BA.debugLineNum = 2818055;BA.debugLine="If Main.Selected_Bot.exchange = \"kraken\" Then";
if ((_main._selected_bot /*b4j.example.main._trading_bot*/ .exchange /*String*/ ).equals("kraken")) { 
RDebugUtils.currentLine=2818056;
 //BA.debugLineNum = 2818056;BA.debugLine="Dim m1, m2 As Map";
_m1 = new anywheresoftware.b4a.objects.collections.Map();
_m2 = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=2818057;
 //BA.debugLineNum = 2818057;BA.debugLine="m1 = JSON.NextObject";
_m1 = _json.NextObject();
RDebugUtils.currentLine=2818058;
 //BA.debugLineNum = 2818058;BA.debugLine="m2 = m1.Get(\"result\")";
_m2 = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_m1.Get((Object)("result"))));
RDebugUtils.currentLine=2818059;
 //BA.debugLineNum = 2818059;BA.debugLine="Dim count As Int = m2.GetDefault(\"count\", 0)";
_count = (int)(BA.ObjectToNumber(_m2.GetDefault((Object)("count"),(Object)(0))));
RDebugUtils.currentLine=2818060;
 //BA.debugLineNum = 2818060;BA.debugLine="If count >= Calc.All_My_Orders_List.Size Then";
if (_count>=_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .getSize()) { 
RDebugUtils.currentLine=2818061;
 //BA.debugLineNum = 2818061;BA.debugLine="Calc.All_My_Orders_List.Clear";
_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .Clear();
RDebugUtils.currentLine=2818062;
 //BA.debugLineNum = 2818062;BA.debugLine="test_ui.Update_Orders";
_test_ui._update_orders /*String*/ ();
 };
 }else {
RDebugUtils.currentLine=2818065;
 //BA.debugLineNum = 2818065;BA.debugLine="Dim L1 As List";
_l1 = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=2818066;
 //BA.debugLineNum = 2818066;BA.debugLine="L1 = JSON.NextArray";
_l1 = _json.NextArray();
RDebugUtils.currentLine=2818067;
 //BA.debugLineNum = 2818067;BA.debugLine="For i = 0 To L1.Size-1";
{
final int step18 = 1;
final int limit18 = (int) (_l1.getSize()-1);
_i = (int) (0) ;
for (;_i <= limit18 ;_i = _i + step18 ) {
RDebugUtils.currentLine=2818068;
 //BA.debugLineNum = 2818068;BA.debugLine="Dim id As String = L1.Get(i)";
_id = BA.ObjectToString(_l1.Get(_i));
RDebugUtils.currentLine=2818069;
 //BA.debugLineNum = 2818069;BA.debugLine="Remove_My_Order(id)";
_remove_my_order(_id);
 }
};
 };
RDebugUtils.currentLine=2818072;
 //BA.debugLineNum = 2818072;BA.debugLine="If Calc.All_My_Orders_List.Size > 0 Then LogErro";
if (_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .getSize()>0) { 
anywheresoftware.b4a.keywords.Common.LogError("All_My_Orders_List.Size = "+BA.NumberToString(_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .getSize())+", but should be 0");};
 };
 } 
       catch (Exception e26) {
			ba.setLastException(e26);RDebugUtils.currentLine=2818076;
 //BA.debugLineNum = 2818076;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("72818076",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=2818078;
 //BA.debugLineNum = 2818078;BA.debugLine="End Sub";
return "";
}
public static boolean  _is_json(String _json_string) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "is_json", false))
	 {return ((Boolean) Debug.delegate(ba, "is_json", new Object[] {_json_string}));}
boolean _it_is_json = false;
RDebugUtils.currentLine=3080192;
 //BA.debugLineNum = 3080192;BA.debugLine="Sub Is_JSON(json_string As String) As Boolean";
RDebugUtils.currentLine=3080193;
 //BA.debugLineNum = 3080193;BA.debugLine="Dim It_Is_JSON As Boolean = False";
_it_is_json = anywheresoftware.b4a.keywords.Common.False;
RDebugUtils.currentLine=3080194;
 //BA.debugLineNum = 3080194;BA.debugLine="If json_string.StartsWith(\"[{\") Or json_string.St";
if (_json_string.startsWith("[{") || _json_string.startsWith("[") || _json_string.startsWith("{")) { 
RDebugUtils.currentLine=3080195;
 //BA.debugLineNum = 3080195;BA.debugLine="It_Is_JSON = True";
_it_is_json = anywheresoftware.b4a.keywords.Common.True;
 };
RDebugUtils.currentLine=3080197;
 //BA.debugLineNum = 3080197;BA.debugLine="Return It_Is_JSON";
if (true) return _it_is_json;
RDebugUtils.currentLine=3080198;
 //BA.debugLineNum = 3080198;BA.debugLine="End Sub";
return false;
}
public static String  _remove_my_order(String _id) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "remove_my_order", false))
	 {return ((String) Debug.delegate(ba, "remove_my_order", new Object[] {_id}));}
int _index = 0;
int _i = 0;
b4j.example.calc._order _this = null;
RDebugUtils.currentLine=3014656;
 //BA.debugLineNum = 3014656;BA.debugLine="Sub Remove_My_Order(id As String)";
RDebugUtils.currentLine=3014657;
 //BA.debugLineNum = 3014657;BA.debugLine="Dim index As Int = -1";
_index = (int) (-1);
RDebugUtils.currentLine=3014659;
 //BA.debugLineNum = 3014659;BA.debugLine="Log(\"started with \" & Calc.All_My_Orders_List.Siz";
anywheresoftware.b4a.keywords.Common.LogImpl("73014659","started with "+BA.NumberToString(_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .getSize())+" orders",0);
RDebugUtils.currentLine=3014661;
 //BA.debugLineNum = 3014661;BA.debugLine="For i = 0 To Calc.All_My_Orders_List.Size-1";
{
final int step3 = 1;
final int limit3 = (int) (_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .getSize()-1);
_i = (int) (0) ;
for (;_i <= limit3 ;_i = _i + step3 ) {
RDebugUtils.currentLine=3014662;
 //BA.debugLineNum = 3014662;BA.debugLine="Dim this As Order = Calc.All_My_Orders_List.Get(";
_this = (b4j.example.calc._order)(_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .Get(_i));
RDebugUtils.currentLine=3014663;
 //BA.debugLineNum = 3014663;BA.debugLine="If this.id = id Then";
if ((_this.id /*String*/ ).equals(_id)) { 
RDebugUtils.currentLine=3014664;
 //BA.debugLineNum = 3014664;BA.debugLine="Log(\"Removed my \" & this.side & \" \" & this.Orde";
anywheresoftware.b4a.keywords.Common.LogImpl("73014664","Removed my "+_this.side /*String*/ +" "+_this.Order_Type /*String*/ +" Order for "+_this.Coinpair /*String*/ +" @ "+BA.NumberToString(_this.Price /*double*/ ),0);
RDebugUtils.currentLine=3014665;
 //BA.debugLineNum = 3014665;BA.debugLine="index = i";
_index = _i;
 };
 }
};
RDebugUtils.currentLine=3014668;
 //BA.debugLineNum = 3014668;BA.debugLine="If index > -1 Then Calc.All_My_Orders_List.Remove";
if (_index>-1) { 
_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .RemoveAt(_index);};
RDebugUtils.currentLine=3014670;
 //BA.debugLineNum = 3014670;BA.debugLine="Log(\"ended with \" & Calc.All_My_Orders_List.Size";
anywheresoftware.b4a.keywords.Common.LogImpl("73014670","ended with "+BA.NumberToString(_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .getSize())+" orders",0);
RDebugUtils.currentLine=3014672;
 //BA.debugLineNum = 3014672;BA.debugLine="test_ui.Update_Orders";
_test_ui._update_orders /*String*/ ();
RDebugUtils.currentLine=3014673;
 //BA.debugLineNum = 3014673;BA.debugLine="End Sub";
return "";
}
public static String  _cancel_order(String _coinpair,String _id) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "cancel_order", false))
	 {return ((String) Debug.delegate(ba, "cancel_order", new Object[] {_coinpair,_id}));}
String _input = "";
RDebugUtils.currentLine=1507328;
 //BA.debugLineNum = 1507328;BA.debugLine="Sub cancel_order(coinpair As String, id As String)";
RDebugUtils.currentLine=1507329;
 //BA.debugLineNum = 1507329;BA.debugLine="Canceled_Order_ID = id";
_canceled_order_id = _id;
RDebugUtils.currentLine=1507330;
 //BA.debugLineNum = 1507330;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&id="+_id+"&symbol="+_coinpair+"&command=cancel_order";
RDebugUtils.currentLine=1507331;
 //BA.debugLineNum = 1507331;BA.debugLine="API_Call(\"Cancel_Order\", input)";
_api_call("Cancel_Order",_input);
RDebugUtils.currentLine=1507332;
 //BA.debugLineNum = 1507332;BA.debugLine="End Sub";
return "";
}
public static String  _cancel_order_completed(String _result) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "cancel_order_completed", false))
	 {return ((String) Debug.delegate(ba, "cancel_order_completed", new Object[] {_result}));}
String _id = "";
anywheresoftware.b4a.objects.collections.Map _m = null;
anywheresoftware.b4a.objects.collections.List _error_list = null;
anywheresoftware.b4a.objects.collections.Map _result_map = null;
int _k_count = 0;
RDebugUtils.currentLine=2752512;
 //BA.debugLineNum = 2752512;BA.debugLine="Private Sub Cancel_Order_Completed(result As Strin";
RDebugUtils.currentLine=2752519;
 //BA.debugLineNum = 2752519;BA.debugLine="Log(\"Cancel_Order_Completed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72752519","Cancel_Order_Completed",0);
RDebugUtils.currentLine=2752520;
 //BA.debugLineNum = 2752520;BA.debugLine="Try";
try {RDebugUtils.currentLine=2752521;
 //BA.debugLineNum = 2752521;BA.debugLine="Log(result)";
anywheresoftware.b4a.keywords.Common.LogImpl("72752521",_result,0);
RDebugUtils.currentLine=2752522;
 //BA.debugLineNum = 2752522;BA.debugLine="If Main.Selected_Bot.exchange.Contains(\"coinbase";
if (_main._selected_bot /*b4j.example.main._trading_bot*/ .exchange /*String*/ .contains("coinbase")) { 
RDebugUtils.currentLine=2752523;
 //BA.debugLineNum = 2752523;BA.debugLine="Dim id As String = result.SubString2(3, result.";
_id = _result.substring((int) (3),(int) (_result.length()-4));
RDebugUtils.currentLine=2752524;
 //BA.debugLineNum = 2752524;BA.debugLine="Log(id)";
anywheresoftware.b4a.keywords.Common.LogImpl("72752524",_id,0);
RDebugUtils.currentLine=2752525;
 //BA.debugLineNum = 2752525;BA.debugLine="Remove_My_Order(id)";
_remove_my_order(_id);
 }else 
{RDebugUtils.currentLine=2752526;
 //BA.debugLineNum = 2752526;BA.debugLine="Else If Main.Selected_Bot.exchange.Contains(\"kra";
if (_main._selected_bot /*b4j.example.main._trading_bot*/ .exchange /*String*/ .contains("kraken")) { 
RDebugUtils.currentLine=2752527;
 //BA.debugLineNum = 2752527;BA.debugLine="JSON.Initialize(result)";
_json.Initialize(_result);
RDebugUtils.currentLine=2752528;
 //BA.debugLineNum = 2752528;BA.debugLine="Dim m As Map = JSON.NextObject";
_m = new anywheresoftware.b4a.objects.collections.Map();
_m = _json.NextObject();
RDebugUtils.currentLine=2752529;
 //BA.debugLineNum = 2752529;BA.debugLine="Dim error_list As List = m.Get(\"error\")";
_error_list = new anywheresoftware.b4a.objects.collections.List();
_error_list = (anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_m.Get((Object)("error"))));
RDebugUtils.currentLine=2752530;
 //BA.debugLineNum = 2752530;BA.debugLine="Dim result_map As Map = m.Get(\"result\")";
_result_map = new anywheresoftware.b4a.objects.collections.Map();
_result_map = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_m.Get((Object)("result"))));
RDebugUtils.currentLine=2752531;
 //BA.debugLineNum = 2752531;BA.debugLine="Dim k_count As Int";
_k_count = 0;
RDebugUtils.currentLine=2752532;
 //BA.debugLineNum = 2752532;BA.debugLine="Log(error_list)";
anywheresoftware.b4a.keywords.Common.LogImpl("72752532",BA.ObjectToString(_error_list),0);
RDebugUtils.currentLine=2752533;
 //BA.debugLineNum = 2752533;BA.debugLine="Log(result_map)";
anywheresoftware.b4a.keywords.Common.LogImpl("72752533",BA.ObjectToString(_result_map),0);
RDebugUtils.currentLine=2752534;
 //BA.debugLineNum = 2752534;BA.debugLine="k_count = result_map.GetDefault(\"count\", 0)";
_k_count = (int)(BA.ObjectToNumber(_result_map.GetDefault((Object)("count"),(Object)(0))));
RDebugUtils.currentLine=2752535;
 //BA.debugLineNum = 2752535;BA.debugLine="If k_count = 1 Then";
if (_k_count==1) { 
RDebugUtils.currentLine=2752536;
 //BA.debugLineNum = 2752536;BA.debugLine="Remove_My_Order(Canceled_Order_ID)";
_remove_my_order(_canceled_order_id);
 }else {
RDebugUtils.currentLine=2752538;
 //BA.debugLineNum = 2752538;BA.debugLine="Log(result_map)";
anywheresoftware.b4a.keywords.Common.LogImpl("72752538",BA.ObjectToString(_result_map),0);
 };
 }}
;
 } 
       catch (Exception e24) {
			ba.setLastException(e24);RDebugUtils.currentLine=2752544;
 //BA.debugLineNum = 2752544;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("72752544",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=2752546;
 //BA.debugLineNum = 2752546;BA.debugLine="End Sub";
return "";
}
public static String  _cancel_orders(String _coinpair) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "cancel_orders", false))
	 {return ((String) Debug.delegate(ba, "cancel_orders", new Object[] {_coinpair}));}
String _input = "";
RDebugUtils.currentLine=1572864;
 //BA.debugLineNum = 1572864;BA.debugLine="Sub cancel_orders(coinpair As String)			'ccxt look";
RDebugUtils.currentLine=1572865;
 //BA.debugLineNum = 1572865;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&coinpair="+_coinpair+"&command=cancel_orders";
RDebugUtils.currentLine=1572866;
 //BA.debugLineNum = 1572866;BA.debugLine="API_Call(\"Cancel_All_Orders\", input)";
_api_call("Cancel_All_Orders",_input);
RDebugUtils.currentLine=1572867;
 //BA.debugLineNum = 1572867;BA.debugLine="End Sub";
return "";
}
public static String  _count_json_string(String _result,int _return_json_number) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "count_json_string", false))
	 {return ((String) Debug.delegate(ba, "count_json_string", new Object[] {_result,_return_json_number}));}
String _starting_string = "";
String _json_string = "";
int _i = 0;
int _starting_index = 0;
int _curly_count = 0;
int _square_count = 0;
int _character_count = 0;
String _ch = "";
RDebugUtils.currentLine=3211264;
 //BA.debugLineNum = 3211264;BA.debugLine="Sub Count_JSON_String(result As String, return_jso";
RDebugUtils.currentLine=3211266;
 //BA.debugLineNum = 3211266;BA.debugLine="Dim starting_string As String = \"[5] => \"";
_starting_string = "[5] => ";
RDebugUtils.currentLine=3211267;
 //BA.debugLineNum = 3211267;BA.debugLine="Dim json_string As String = result";
_json_string = _result;
RDebugUtils.currentLine=3211269;
 //BA.debugLineNum = 3211269;BA.debugLine="For i = 0 To return_json_number";
{
final int step3 = 1;
final int limit3 = _return_json_number;
_i = (int) (0) ;
for (;_i <= limit3 ;_i = _i + step3 ) {
RDebugUtils.currentLine=3211270;
 //BA.debugLineNum = 3211270;BA.debugLine="Dim starting_index As Int = json_string.IndexOf(";
_starting_index = (int) (_json_string.indexOf(_starting_string)+_starting_string.length());
RDebugUtils.currentLine=3211271;
 //BA.debugLineNum = 3211271;BA.debugLine="json_string = json_string.SubString(starting_ind";
_json_string = _json_string.substring(_starting_index);
 }
};
RDebugUtils.currentLine=3211276;
 //BA.debugLineNum = 3211276;BA.debugLine="Dim curly_count As Int";
_curly_count = 0;
RDebugUtils.currentLine=3211277;
 //BA.debugLineNum = 3211277;BA.debugLine="Dim square_count As Int";
_square_count = 0;
RDebugUtils.currentLine=3211278;
 //BA.debugLineNum = 3211278;BA.debugLine="Dim character_count As Int";
_character_count = 0;
RDebugUtils.currentLine=3211279;
 //BA.debugLineNum = 3211279;BA.debugLine="Do While curly_count > 0 Or square_count > 0 Or c";
while (_curly_count>0 || _square_count>0 || _character_count==0) {
RDebugUtils.currentLine=3211280;
 //BA.debugLineNum = 3211280;BA.debugLine="Dim ch As String = json_string.CharAt(character_";
_ch = BA.ObjectToString(_json_string.charAt(_character_count));
RDebugUtils.currentLine=3211281;
 //BA.debugLineNum = 3211281;BA.debugLine="If ch = \"[\" Then square_count = square_count + 1";
if ((_ch).equals("[")) { 
_square_count = (int) (_square_count+1);};
RDebugUtils.currentLine=3211282;
 //BA.debugLineNum = 3211282;BA.debugLine="If ch = \"]\" Then square_count = square_count - 1";
if ((_ch).equals("]")) { 
_square_count = (int) (_square_count-1);};
RDebugUtils.currentLine=3211283;
 //BA.debugLineNum = 3211283;BA.debugLine="If ch = \"{\" Then curly_count = curly_count + 1";
if ((_ch).equals("{")) { 
_curly_count = (int) (_curly_count+1);};
RDebugUtils.currentLine=3211284;
 //BA.debugLineNum = 3211284;BA.debugLine="If ch = \"}\" Then curly_count = curly_count - 1";
if ((_ch).equals("}")) { 
_curly_count = (int) (_curly_count-1);};
RDebugUtils.currentLine=3211285;
 //BA.debugLineNum = 3211285;BA.debugLine="character_count = character_count + 1";
_character_count = (int) (_character_count+1);
 }
;
RDebugUtils.currentLine=3211288;
 //BA.debugLineNum = 3211288;BA.debugLine="json_string = json_string.SubString2(0, character";
_json_string = _json_string.substring((int) (0),_character_count);
RDebugUtils.currentLine=3211289;
 //BA.debugLineNum = 3211289;BA.debugLine="LogError(json_string.Length & \"   \" & json_string";
anywheresoftware.b4a.keywords.Common.LogError(BA.NumberToString(_json_string.length())+"   "+_json_string);
RDebugUtils.currentLine=3211291;
 //BA.debugLineNum = 3211291;BA.debugLine="Return json_string";
if (true) return _json_string;
RDebugUtils.currentLine=3211292;
 //BA.debugLineNum = 3211292;BA.debugLine="End Sub";
return "";
}
public static String  _create_limit_buy_order(String _coinpair,double _price,double _volume) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "create_limit_buy_order", false))
	 {return ((String) Debug.delegate(ba, "create_limit_buy_order", new Object[] {_coinpair,_price,_volume}));}
String _p = "";
String _v = "";
String _input = "";
RDebugUtils.currentLine=1310720;
 //BA.debugLineNum = 1310720;BA.debugLine="Sub create_limit_buy_order(coinpair As String, pri";
RDebugUtils.currentLine=1310721;
 //BA.debugLineNum = 1310721;BA.debugLine="Dim p As String = NumberFormat2(price, 1,8,8,Fals";
_p = anywheresoftware.b4a.keywords.Common.NumberFormat2(_price,(int) (1),(int) (8),(int) (8),anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=1310722;
 //BA.debugLineNum = 1310722;BA.debugLine="Dim v As String = NumberFormat2(volume, 1,8,8,Fal";
_v = anywheresoftware.b4a.keywords.Common.NumberFormat2(_volume,(int) (1),(int) (8),(int) (8),anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=1310723;
 //BA.debugLineNum = 1310723;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&symbol="+_coinpair+"&amount="+_v+"&price="+_p+"&command=create_limit_buy_order";
RDebugUtils.currentLine=1310724;
 //BA.debugLineNum = 1310724;BA.debugLine="API_Call(\"Create_Limit_Buy_Order\", input)";
_api_call("Create_Limit_Buy_Order",_input);
RDebugUtils.currentLine=1310725;
 //BA.debugLineNum = 1310725;BA.debugLine="End Sub";
return "";
}
public static String  _create_limit_sell_order(String _coinpair,double _price,double _volume) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "create_limit_sell_order", false))
	 {return ((String) Debug.delegate(ba, "create_limit_sell_order", new Object[] {_coinpair,_price,_volume}));}
String _p = "";
String _v = "";
String _input = "";
RDebugUtils.currentLine=1376256;
 //BA.debugLineNum = 1376256;BA.debugLine="Sub create_limit_sell_order(coinpair As String, pr";
RDebugUtils.currentLine=1376257;
 //BA.debugLineNum = 1376257;BA.debugLine="Dim p As String = NumberFormat2(price, 1,8,8,Fals";
_p = anywheresoftware.b4a.keywords.Common.NumberFormat2(_price,(int) (1),(int) (8),(int) (8),anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=1376258;
 //BA.debugLineNum = 1376258;BA.debugLine="Dim v As String = NumberFormat2(volume, 1,8,8,Fal";
_v = anywheresoftware.b4a.keywords.Common.NumberFormat2(_volume,(int) (1),(int) (8),(int) (8),anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=1376259;
 //BA.debugLineNum = 1376259;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&symbol="+_coinpair+"&amount="+_v+"&price="+_p+"&command=create_limit_sell_order";
RDebugUtils.currentLine=1376260;
 //BA.debugLineNum = 1376260;BA.debugLine="API_Call(\"Create_Limit_Sell_Order\", input)";
_api_call("Create_Limit_Sell_Order",_input);
RDebugUtils.currentLine=1376261;
 //BA.debugLineNum = 1376261;BA.debugLine="End Sub";
return "";
}
public static String  _create_market_buy_order(String _coinpair,double _volume) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "create_market_buy_order", false))
	 {return ((String) Debug.delegate(ba, "create_market_buy_order", new Object[] {_coinpair,_volume}));}
String _v = "";
String _input = "";
RDebugUtils.currentLine=1703936;
 //BA.debugLineNum = 1703936;BA.debugLine="Sub create_market_buy_order(coinpair As String, vo";
RDebugUtils.currentLine=1703938;
 //BA.debugLineNum = 1703938;BA.debugLine="Dim v As String = NumberFormat2(volume, 1,8,8,Fal";
_v = anywheresoftware.b4a.keywords.Common.NumberFormat2(_volume,(int) (1),(int) (8),(int) (8),anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=1703939;
 //BA.debugLineNum = 1703939;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&symbol="+_coinpair+"&amount="+_v+"&command=create_market_buy_order";
RDebugUtils.currentLine=1703940;
 //BA.debugLineNum = 1703940;BA.debugLine="API_Call(\"Create_Market_Buy_Order\", input)";
_api_call("Create_Market_Buy_Order",_input);
RDebugUtils.currentLine=1703941;
 //BA.debugLineNum = 1703941;BA.debugLine="End Sub";
return "";
}
public static String  _create_market_sell_order(String _coinpair,double _volume) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "create_market_sell_order", false))
	 {return ((String) Debug.delegate(ba, "create_market_sell_order", new Object[] {_coinpair,_volume}));}
String _v = "";
String _input = "";
RDebugUtils.currentLine=1769472;
 //BA.debugLineNum = 1769472;BA.debugLine="Sub create_market_sell_order(coinpair As String, v";
RDebugUtils.currentLine=1769473;
 //BA.debugLineNum = 1769473;BA.debugLine="Dim v As String = NumberFormat2(volume, 1,8,8,Fal";
_v = anywheresoftware.b4a.keywords.Common.NumberFormat2(_volume,(int) (1),(int) (8),(int) (8),anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=1769474;
 //BA.debugLineNum = 1769474;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&symbol="+_coinpair+"&amount="+_v+"&command=create_market_sell_order";
RDebugUtils.currentLine=1769475;
 //BA.debugLineNum = 1769475;BA.debugLine="API_Call(\"Place_Market_Sell_Order\", input)";
_api_call("Place_Market_Sell_Order",_input);
RDebugUtils.currentLine=1769476;
 //BA.debugLineNum = 1769476;BA.debugLine="End Sub";
return "";
}
public static String  _edit_limit_order(String _id,String _coinpair,String _side,double _price,double _volume) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "edit_limit_order", false))
	 {return ((String) Debug.delegate(ba, "edit_limit_order", new Object[] {_id,_coinpair,_side,_price,_volume}));}
String _p = "";
String _v = "";
String _input = "";
RDebugUtils.currentLine=1441792;
 //BA.debugLineNum = 1441792;BA.debugLine="Sub edit_limit_order(id As String, coinpair As Str";
RDebugUtils.currentLine=1441793;
 //BA.debugLineNum = 1441793;BA.debugLine="Canceled_Order_ID = id";
_canceled_order_id = _id;
RDebugUtils.currentLine=1441794;
 //BA.debugLineNum = 1441794;BA.debugLine="Dim p As String = NumberFormat2(price, 1,8,8,Fals";
_p = anywheresoftware.b4a.keywords.Common.NumberFormat2(_price,(int) (1),(int) (8),(int) (8),anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=1441795;
 //BA.debugLineNum = 1441795;BA.debugLine="Dim v As String = NumberFormat2(volume, 1,8,8,Fal";
_v = anywheresoftware.b4a.keywords.Common.NumberFormat2(_volume,(int) (1),(int) (8),(int) (8),anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=1441796;
 //BA.debugLineNum = 1441796;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&id="+_id+"&symbol="+_coinpair+"&side="+_side+"&amount="+_v+"&price="+_p+"&command=edit_limit_order";
RDebugUtils.currentLine=1441797;
 //BA.debugLineNum = 1441797;BA.debugLine="API_Call(\"Edit_Limit_Order\", input)";
_api_call("Edit_Limit_Order",_input);
RDebugUtils.currentLine=1441798;
 //BA.debugLineNum = 1441798;BA.debugLine="End Sub";
return "";
}
public static String  _exchange_info() throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "exchange_info", false))
	 {return ((String) Debug.delegate(ba, "exchange_info", null));}
String _input = "";
RDebugUtils.currentLine=524288;
 //BA.debugLineNum = 524288;BA.debugLine="Sub exchange_info";
RDebugUtils.currentLine=524289;
 //BA.debugLineNum = 524289;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&command=exchange_info";
RDebugUtils.currentLine=524290;
 //BA.debugLineNum = 524290;BA.debugLine="API_Call(\"Get_Exchange_Info\", input)";
_api_call("Get_Exchange_Info",_input);
RDebugUtils.currentLine=524291;
 //BA.debugLineNum = 524291;BA.debugLine="End Sub";
return "";
}
public static String  _exchanges() throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "exchanges", false))
	 {return ((String) Debug.delegate(ba, "exchanges", null));}
String _input = "";
RDebugUtils.currentLine=458752;
 //BA.debugLineNum = 458752;BA.debugLine="Sub exchanges";
RDebugUtils.currentLine=458753;
 //BA.debugLineNum = 458753;BA.debugLine="Dim input As String = \"command=exchanges\"";
_input = "command=exchanges";
RDebugUtils.currentLine=458754;
 //BA.debugLineNum = 458754;BA.debugLine="API_Call(\"exchanges\", input)";
_api_call("exchanges",_input);
RDebugUtils.currentLine=458755;
 //BA.debugLineNum = 458755;BA.debugLine="End Sub";
return "";
}
public static String  _fetch_balance() throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "fetch_balance", false))
	 {return ((String) Debug.delegate(ba, "fetch_balance", null));}
String _input = "";
RDebugUtils.currentLine=983040;
 //BA.debugLineNum = 983040;BA.debugLine="Sub fetch_balance";
RDebugUtils.currentLine=983041;
 //BA.debugLineNum = 983041;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&command=fetch_balance";
RDebugUtils.currentLine=983042;
 //BA.debugLineNum = 983042;BA.debugLine="API_Call(\"Get_My_Balances\", input)";
_api_call("Get_My_Balances",_input);
RDebugUtils.currentLine=983043;
 //BA.debugLineNum = 983043;BA.debugLine="End Sub";
return "";
}
public static String  _fetch_l2_order_book(String _coinpair,int _limit) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "fetch_l2_order_book", false))
	 {return ((String) Debug.delegate(ba, "fetch_l2_order_book", new Object[] {_coinpair,_limit}));}
String _input = "";
RDebugUtils.currentLine=786432;
 //BA.debugLineNum = 786432;BA.debugLine="Sub fetch_l2_order_book(coinpair As String, limit";
RDebugUtils.currentLine=786433;
 //BA.debugLineNum = 786433;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&symbol="+_coinpair+"&limit="+BA.NumberToString(_limit)+"&command=fetch_l2_order_book";
RDebugUtils.currentLine=786434;
 //BA.debugLineNum = 786434;BA.debugLine="API_Call(\"Get_OrderBook\", input)";
_api_call("Get_OrderBook",_input);
RDebugUtils.currentLine=786435;
 //BA.debugLineNum = 786435;BA.debugLine="End Sub";
return "";
}
public static String  _fetch_markets() throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "fetch_markets", false))
	 {return ((String) Debug.delegate(ba, "fetch_markets", null));}
String _input = "";
RDebugUtils.currentLine=589824;
 //BA.debugLineNum = 589824;BA.debugLine="Sub fetch_markets";
RDebugUtils.currentLine=589825;
 //BA.debugLineNum = 589825;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&command=fetch_markets";
RDebugUtils.currentLine=589826;
 //BA.debugLineNum = 589826;BA.debugLine="API_Call(\"Get_Markets\", input)";
_api_call("Get_Markets",_input);
RDebugUtils.currentLine=589827;
 //BA.debugLineNum = 589827;BA.debugLine="End Sub";
return "";
}
public static String  _fetch_my_trades(String _coinpair,long _since,int _limit) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "fetch_my_trades", false))
	 {return ((String) Debug.delegate(ba, "fetch_my_trades", new Object[] {_coinpair,_since,_limit}));}
String _input = "";
RDebugUtils.currentLine=1179648;
 //BA.debugLineNum = 1179648;BA.debugLine="Sub fetch_my_trades(coinpair As String, since As L";
RDebugUtils.currentLine=1179651;
 //BA.debugLineNum = 1179651;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&symbol="+_coinpair+"&limit="+BA.NumberToString(_limit)+"&since="+BA.NumberToString(_since)+"&command=fetch_my_trades";
RDebugUtils.currentLine=1179652;
 //BA.debugLineNum = 1179652;BA.debugLine="API_Call(\"Get_My_Trade_History\", input)";
_api_call("Get_My_Trade_History",_input);
RDebugUtils.currentLine=1179653;
 //BA.debugLineNum = 1179653;BA.debugLine="End Sub";
return "";
}
public static String  _fetch_ohlcv(String _coinpair,String _timeframe) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "fetch_ohlcv", false))
	 {return ((String) Debug.delegate(ba, "fetch_ohlcv", new Object[] {_coinpair,_timeframe}));}
String _input = "";
RDebugUtils.currentLine=851968;
 //BA.debugLineNum = 851968;BA.debugLine="Sub fetch_ohlcv(coinpair As String, timeframe As S";
RDebugUtils.currentLine=851970;
 //BA.debugLineNum = 851970;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&symbol="+_coinpair+"&timeframe="+_timeframe+"&command=fetch_ohlcv";
RDebugUtils.currentLine=851971;
 //BA.debugLineNum = 851971;BA.debugLine="API_Call(\"Get_OHLCV\", input)";
_api_call("Get_OHLCV",_input);
RDebugUtils.currentLine=851972;
 //BA.debugLineNum = 851972;BA.debugLine="End Sub";
return "";
}
public static String  _fetch_open_orders(String _coinpair) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "fetch_open_orders", false))
	 {return ((String) Debug.delegate(ba, "fetch_open_orders", new Object[] {_coinpair}));}
String _input = "";
RDebugUtils.currentLine=1048576;
 //BA.debugLineNum = 1048576;BA.debugLine="Sub fetch_open_orders(coinpair As String)	'optiona";
RDebugUtils.currentLine=1048577;
 //BA.debugLineNum = 1048577;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&symbol="+_coinpair+"&command=fetch_open_orders";
RDebugUtils.currentLine=1048578;
 //BA.debugLineNum = 1048578;BA.debugLine="API_Call(\"Get_My_Open_Orders\", input)";
_api_call("Get_My_Open_Orders",_input);
RDebugUtils.currentLine=1048579;
 //BA.debugLineNum = 1048579;BA.debugLine="End Sub";
return "";
}
public static String  _fetch_ticker(String _coinpair) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "fetch_ticker", false))
	 {return ((String) Debug.delegate(ba, "fetch_ticker", new Object[] {_coinpair}));}
String _input = "";
RDebugUtils.currentLine=655360;
 //BA.debugLineNum = 655360;BA.debugLine="Sub fetch_ticker(coinpair As String)";
RDebugUtils.currentLine=655361;
 //BA.debugLineNum = 655361;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&symbol="+_coinpair+"&command=fetch_ticker";
RDebugUtils.currentLine=655362;
 //BA.debugLineNum = 655362;BA.debugLine="API_Call(\"Get_Ticker\", input)";
_api_call("Get_Ticker",_input);
RDebugUtils.currentLine=655363;
 //BA.debugLineNum = 655363;BA.debugLine="End Sub";
return "";
}
public static String  _fetch_trades(String _coinpair,int _limit) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "fetch_trades", false))
	 {return ((String) Debug.delegate(ba, "fetch_trades", new Object[] {_coinpair,_limit}));}
String _input = "";
RDebugUtils.currentLine=917504;
 //BA.debugLineNum = 917504;BA.debugLine="Sub fetch_trades(coinpair As String, limit As Int)";
RDebugUtils.currentLine=917506;
 //BA.debugLineNum = 917506;BA.debugLine="Dim input As String = \"bot=\" & Main.Selected_Bot.";
_input = "bot="+_main._selected_bot /*b4j.example.main._trading_bot*/ .name /*String*/ +"&symbol="+_coinpair+"&limit="+BA.NumberToString(_limit)+"&command=fetch_trades";
RDebugUtils.currentLine=917507;
 //BA.debugLineNum = 917507;BA.debugLine="API_Call(\"Get_Public_Trade_History\", input)";
_api_call("Get_Public_Trade_History",_input);
RDebugUtils.currentLine=917508;
 //BA.debugLineNum = 917508;BA.debugLine="End Sub";
return "";
}
public static String  _filter_json_string(String _str) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "filter_json_string", false))
	 {return ((String) Debug.delegate(ba, "filter_json_string", new Object[] {_str}));}
String _json_string = "";
String _cha = "";
int _cha_count = 0;
RDebugUtils.currentLine=3145728;
 //BA.debugLineNum = 3145728;BA.debugLine="Sub Filter_JSON_String(str As String) As String";
RDebugUtils.currentLine=3145730;
 //BA.debugLineNum = 3145730;BA.debugLine="Dim json_string As String = \"Null\"";
_json_string = "Null";
RDebugUtils.currentLine=3145734;
 //BA.debugLineNum = 3145734;BA.debugLine="Dim cha As String";
_cha = "";
RDebugUtils.currentLine=3145735;
 //BA.debugLineNum = 3145735;BA.debugLine="Dim cha_count As Int";
_cha_count = 0;
RDebugUtils.currentLine=3145737;
 //BA.debugLineNum = 3145737;BA.debugLine="Do Until cha = \"[\" Or cha = \"{\" Or cha_count = st";
while (!((_cha).equals("[") || (_cha).equals("{") || _cha_count==_str.length()-1)) {
RDebugUtils.currentLine=3145738;
 //BA.debugLineNum = 3145738;BA.debugLine="cha = str.CharAt(cha_count)";
_cha = BA.ObjectToString(_str.charAt(_cha_count));
RDebugUtils.currentLine=3145739;
 //BA.debugLineNum = 3145739;BA.debugLine="cha_count = cha_count + 1";
_cha_count = (int) (_cha_count+1);
 }
;
RDebugUtils.currentLine=3145743;
 //BA.debugLineNum = 3145743;BA.debugLine="json_string = str.SubString(cha_count - 1)";
_json_string = _str.substring((int) (_cha_count-1));
RDebugUtils.currentLine=3145746;
 //BA.debugLineNum = 3145746;BA.debugLine="If json_string.Length > 2 Then";
if (_json_string.length()>2) { 
RDebugUtils.currentLine=3145747;
 //BA.debugLineNum = 3145747;BA.debugLine="Return json_string";
if (true) return _json_string;
 }else {
RDebugUtils.currentLine=3145749;
 //BA.debugLineNum = 3145749;BA.debugLine="Return str";
if (true) return _str;
 };
RDebugUtils.currentLine=3145751;
 //BA.debugLineNum = 3145751;BA.debugLine="End Sub";
return "";
}
public static String  _get_all_my_open_orders_completed(String _result) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "get_all_my_open_orders_completed", false))
	 {return ((String) Debug.delegate(ba, "get_all_my_open_orders_completed", new Object[] {_result}));}
anywheresoftware.b4a.objects.collections.List _l = null;
anywheresoftware.b4a.objects.collections.Map _m = null;
int _i = 0;
b4j.example.calc._order _my_order = null;
RDebugUtils.currentLine=2490368;
 //BA.debugLineNum = 2490368;BA.debugLine="Private Sub Get_All_My_Open_Orders_Completed(resul";
RDebugUtils.currentLine=2490369;
 //BA.debugLineNum = 2490369;BA.debugLine="Log(\"Get_All_My_Open_Orders_Completed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72490369","Get_All_My_Open_Orders_Completed",0);
RDebugUtils.currentLine=2490371;
 //BA.debugLineNum = 2490371;BA.debugLine="Try";
try {RDebugUtils.currentLine=2490372;
 //BA.debugLineNum = 2490372;BA.debugLine="Calc.All_My_Orders_List.Initialize									'reset";
_calc._all_my_orders_list /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=2490373;
 //BA.debugLineNum = 2490373;BA.debugLine="If Is_JSON(result) = True Then";
if (_is_json(_result)==anywheresoftware.b4a.keywords.Common.True) { 
RDebugUtils.currentLine=2490374;
 //BA.debugLineNum = 2490374;BA.debugLine="JSON.Initialize(result)";
_json.Initialize(_result);
RDebugUtils.currentLine=2490375;
 //BA.debugLineNum = 2490375;BA.debugLine="Dim L As List";
_l = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=2490376;
 //BA.debugLineNum = 2490376;BA.debugLine="Dim m As Map";
_m = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=2490377;
 //BA.debugLineNum = 2490377;BA.debugLine="L = JSON.NextArray";
_l = _json.NextArray();
RDebugUtils.currentLine=2490378;
 //BA.debugLineNum = 2490378;BA.debugLine="For i = 0 To L.Size-1";
{
final int step9 = 1;
final int limit9 = (int) (_l.getSize()-1);
_i = (int) (0) ;
for (;_i <= limit9 ;_i = _i + step9 ) {
RDebugUtils.currentLine=2490379;
 //BA.debugLineNum = 2490379;BA.debugLine="Dim my_order As Order : 	my_order.Initialize";
_my_order = new b4j.example.calc._order();
RDebugUtils.currentLine=2490379;
 //BA.debugLineNum = 2490379;BA.debugLine="Dim my_order As Order : 	my_order.Initialize";
_my_order.Initialize();
RDebugUtils.currentLine=2490380;
 //BA.debugLineNum = 2490380;BA.debugLine="m = L.Get(i)";
_m = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_l.Get(_i)));
RDebugUtils.currentLine=2490381;
 //BA.debugLineNum = 2490381;BA.debugLine="Add_My_Order(m.Get(\"timestamp\"), m.Get(\"symbol\"";
_add_my_order(BA.ObjectToLongNumber(_m.Get((Object)("timestamp"))),BA.ObjectToString(_m.Get((Object)("symbol"))),BA.ObjectToString(_m.Get((Object)("side"))),BA.ObjectToString(_m.Get((Object)("id"))),(double)(BA.ObjectToNumber(_m.Get((Object)("price")))),(double)(BA.ObjectToNumber(_m.Get((Object)("amount")))),(double)(BA.ObjectToNumber(_m.Get((Object)("filled")))),(double)(BA.ObjectToNumber(_m.Get((Object)("remaining")))),BA.ObjectToString(_m.Get((Object)("type"))),BA.ObjectToString(_m.Get((Object)("status"))));
 }
};
 };
 } 
       catch (Exception e17) {
			ba.setLastException(e17);RDebugUtils.currentLine=2490386;
 //BA.debugLineNum = 2490386;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("72490386",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=2490388;
 //BA.debugLineNum = 2490388;BA.debugLine="End Sub";
return "";
}
public static String  _get_all_my_trade_history_completed(String _result) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "get_all_my_trade_history_completed", false))
	 {return ((String) Debug.delegate(ba, "get_all_my_trade_history_completed", new Object[] {_result}));}
anywheresoftware.b4a.objects.collections.Map _m1 = null;
anywheresoftware.b4a.objects.collections.Map _m2 = null;
anywheresoftware.b4a.objects.collections.List _l1 = null;
int _i = 0;
RDebugUtils.currentLine=2621440;
 //BA.debugLineNum = 2621440;BA.debugLine="Private Sub Get_All_My_Trade_History_Completed(res";
RDebugUtils.currentLine=2621441;
 //BA.debugLineNum = 2621441;BA.debugLine="Log(\"Get_All_My_Trade_History_Completed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72621441","Get_All_My_Trade_History_Completed",0);
RDebugUtils.currentLine=2621442;
 //BA.debugLineNum = 2621442;BA.debugLine="Try";
try {RDebugUtils.currentLine=2621443;
 //BA.debugLineNum = 2621443;BA.debugLine="Calc.All_My_Trades_List.Initialize									'reset";
_calc._all_my_trades_list /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=2621445;
 //BA.debugLineNum = 2621445;BA.debugLine="If Is_JSON(result) = True Then";
if (_is_json(_result)==anywheresoftware.b4a.keywords.Common.True) { 
RDebugUtils.currentLine=2621446;
 //BA.debugLineNum = 2621446;BA.debugLine="JSON.Initialize(result)";
_json.Initialize(_result);
RDebugUtils.currentLine=2621447;
 //BA.debugLineNum = 2621447;BA.debugLine="Dim m1, m2 As Map";
_m1 = new anywheresoftware.b4a.objects.collections.Map();
_m2 = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=2621448;
 //BA.debugLineNum = 2621448;BA.debugLine="Dim L1 As List";
_l1 = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=2621449;
 //BA.debugLineNum = 2621449;BA.debugLine="L1 = JSON.NextArray";
_l1 = _json.NextArray();
RDebugUtils.currentLine=2621452;
 //BA.debugLineNum = 2621452;BA.debugLine="For i = 0 To L1.Size-1";
{
final int step9 = 1;
final int limit9 = (int) (_l1.getSize()-1);
_i = (int) (0) ;
for (;_i <= limit9 ;_i = _i + step9 ) {
RDebugUtils.currentLine=2621453;
 //BA.debugLineNum = 2621453;BA.debugLine="m1 = L1.Get(i)";
_m1 = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_l1.Get(_i)));
RDebugUtils.currentLine=2621454;
 //BA.debugLineNum = 2621454;BA.debugLine="m2 = m1.Get(\"fee\")";
_m2 = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_m1.Get((Object)("fee"))));
RDebugUtils.currentLine=2621455;
 //BA.debugLineNum = 2621455;BA.debugLine="Add_My_Trade(m1.Get(\"timestamp\"), m1.Get(\"symbo";
_add_my_trade(BA.ObjectToLongNumber(_m1.Get((Object)("timestamp"))),BA.ObjectToString(_m1.Get((Object)("symbol"))),BA.ObjectToString(_m1.Get((Object)("side"))),BA.ObjectToString(_m1.Get((Object)("id"))),BA.ObjectToString(_m1.Get((Object)("order"))),(double)(BA.ObjectToNumber(_m1.Get((Object)("price")))),(double)(BA.ObjectToNumber(_m1.Get((Object)("amount")))),BA.ObjectToString(_m1.Get((Object)("type"))),(double)(BA.ObjectToNumber(_m2.Get((Object)("cost")))),BA.ObjectToString(_m2.Get((Object)("currency"))));
 }
};
 };
 } 
       catch (Exception e16) {
			ba.setLastException(e16);RDebugUtils.currentLine=2621460;
 //BA.debugLineNum = 2621460;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("72621460",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=2621462;
 //BA.debugLineNum = 2621462;BA.debugLine="End Sub";
return "";
}
public static String  _get_all_tickers_completed(String _result) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "get_all_tickers_completed", false))
	 {return ((String) Debug.delegate(ba, "get_all_tickers_completed", new Object[] {_result}));}
anywheresoftware.b4a.objects.collections.Map _m1 = null;
anywheresoftware.b4a.objects.collections.Map _m2 = null;
int _i = 0;
String _coinpair = "";
RDebugUtils.currentLine=2228224;
 //BA.debugLineNum = 2228224;BA.debugLine="Private Sub Get_All_Tickers_completed(result As St";
RDebugUtils.currentLine=2228225;
 //BA.debugLineNum = 2228225;BA.debugLine="Log(\"Get_Tickers_completed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72228225","Get_Tickers_completed",0);
RDebugUtils.currentLine=2228227;
 //BA.debugLineNum = 2228227;BA.debugLine="Try";
try {RDebugUtils.currentLine=2228228;
 //BA.debugLineNum = 2228228;BA.debugLine="If Is_JSON(result) = True Then";
if (_is_json(_result)==anywheresoftware.b4a.keywords.Common.True) { 
RDebugUtils.currentLine=2228229;
 //BA.debugLineNum = 2228229;BA.debugLine="JSON.Initialize(result)";
_json.Initialize(_result);
RDebugUtils.currentLine=2228230;
 //BA.debugLineNum = 2228230;BA.debugLine="Dim m1, m2 As Map";
_m1 = new anywheresoftware.b4a.objects.collections.Map();
_m2 = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=2228231;
 //BA.debugLineNum = 2228231;BA.debugLine="m1 = JSON.NextObject";
_m1 = _json.NextObject();
RDebugUtils.currentLine=2228233;
 //BA.debugLineNum = 2228233;BA.debugLine="For i = 0 To m1.Size-1";
{
final int step7 = 1;
final int limit7 = (int) (_m1.getSize()-1);
_i = (int) (0) ;
for (;_i <= limit7 ;_i = _i + step7 ) {
RDebugUtils.currentLine=2228234;
 //BA.debugLineNum = 2228234;BA.debugLine="Dim coinpair As String = m1.GetKeyAt(i)";
_coinpair = BA.ObjectToString(_m1.GetKeyAt(_i));
RDebugUtils.currentLine=2228236;
 //BA.debugLineNum = 2228236;BA.debugLine="m2 = m1.GetValueAt(i)";
_m2 = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_m1.GetValueAt(_i)));
RDebugUtils.currentLine=2228237;
 //BA.debugLineNum = 2228237;BA.debugLine="Log(\"----------\" & coinpair & \"----------\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72228237","----------"+_coinpair+"----------",0);
RDebugUtils.currentLine=2228238;
 //BA.debugLineNum = 2228238;BA.debugLine="Log(	Calc.My_Date_Time( m2.Get(\"timestamp\")))";
anywheresoftware.b4a.keywords.Common.LogImpl("72228238",_calc._my_date_time /*String*/ (BA.ObjectToLongNumber(_m2.Get((Object)("timestamp")))),0);
RDebugUtils.currentLine=2228239;
 //BA.debugLineNum = 2228239;BA.debugLine="Log(\"Last Price: \" & m2.Get(\"last\"))";
anywheresoftware.b4a.keywords.Common.LogImpl("72228239","Last Price: "+BA.ObjectToString(_m2.Get((Object)("last"))),0);
 }
};
 };
 } 
       catch (Exception e16) {
			ba.setLastException(e16);RDebugUtils.currentLine=2228246;
 //BA.debugLineNum = 2228246;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("72228246",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=2228248;
 //BA.debugLineNum = 2228248;BA.debugLine="End Sub";
return "";
}
public static String  _get_exchange_info_completed(String _result) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "get_exchange_info_completed", false))
	 {return ((String) Debug.delegate(ba, "get_exchange_info_completed", new Object[] {_result}));}
anywheresoftware.b4a.objects.collections.Map _m1 = null;
anywheresoftware.b4a.objects.collections.Map _m2 = null;
int _i = 0;
String _tf = "";
RDebugUtils.currentLine=2031616;
 //BA.debugLineNum = 2031616;BA.debugLine="Private Sub Get_Exchange_Info_completed(result As";
RDebugUtils.currentLine=2031617;
 //BA.debugLineNum = 2031617;BA.debugLine="Log(\"Get_Exchange_Info_completed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72031617","Get_Exchange_Info_completed",0);
RDebugUtils.currentLine=2031641;
 //BA.debugLineNum = 2031641;BA.debugLine="OHLCV_TimeFrame_List.Initialize";
_ohlcv_timeframe_list.Initialize();
RDebugUtils.currentLine=2031643;
 //BA.debugLineNum = 2031643;BA.debugLine="Try";
try {RDebugUtils.currentLine=2031644;
 //BA.debugLineNum = 2031644;BA.debugLine="If Is_JSON(result) = True Then";
if (_is_json(_result)==anywheresoftware.b4a.keywords.Common.True) { 
RDebugUtils.currentLine=2031645;
 //BA.debugLineNum = 2031645;BA.debugLine="JSON.Initialize(result)";
_json.Initialize(_result);
RDebugUtils.currentLine=2031646;
 //BA.debugLineNum = 2031646;BA.debugLine="Dim m1, m2 As Map";
_m1 = new anywheresoftware.b4a.objects.collections.Map();
_m2 = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=2031647;
 //BA.debugLineNum = 2031647;BA.debugLine="m1 = JSON.NextObject";
_m1 = _json.NextObject();
RDebugUtils.currentLine=2031648;
 //BA.debugLineNum = 2031648;BA.debugLine="Log(\"id: \" & m1.Get(\"id\"))";
anywheresoftware.b4a.keywords.Common.LogImpl("72031648","id: "+BA.ObjectToString(_m1.Get((Object)("id"))),0);
RDebugUtils.currentLine=2031649;
 //BA.debugLineNum = 2031649;BA.debugLine="Log(\"countries: \" & m1.Get(\"countries\"))";
anywheresoftware.b4a.keywords.Common.LogImpl("72031649","countries: "+BA.ObjectToString(_m1.Get((Object)("countries"))),0);
RDebugUtils.currentLine=2031650;
 //BA.debugLineNum = 2031650;BA.debugLine="m2 = m1.Get(\"has\")";
_m2 = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_m1.Get((Object)("has"))));
RDebugUtils.currentLine=2031651;
 //BA.debugLineNum = 2031651;BA.debugLine="Log(\"Get_Markets: \" & m2.Get(\"fetchMarkets\"))";
anywheresoftware.b4a.keywords.Common.LogImpl("72031651","Get_Markets: "+BA.ObjectToString(_m2.Get((Object)("fetchMarkets"))),0);
RDebugUtils.currentLine=2031652;
 //BA.debugLineNum = 2031652;BA.debugLine="Log(\"Get_Ticker: \" & m2.Get(\"fetchTicker\"))";
anywheresoftware.b4a.keywords.Common.LogImpl("72031652","Get_Ticker: "+BA.ObjectToString(_m2.Get((Object)("fetchTicker"))),0);
RDebugUtils.currentLine=2031653;
 //BA.debugLineNum = 2031653;BA.debugLine="Log(\"Get_All_Tickers: \" & m2.Get(\"fetchTickers\"";
anywheresoftware.b4a.keywords.Common.LogImpl("72031653","Get_All_Tickers: "+BA.ObjectToString(_m2.Get((Object)("fetchTickers"))),0);
RDebugUtils.currentLine=2031654;
 //BA.debugLineNum = 2031654;BA.debugLine="Log(\"Get_OrderBook\" & m2.Get(\"fetchOrderBook\"))";
anywheresoftware.b4a.keywords.Common.LogImpl("72031654","Get_OrderBook"+BA.ObjectToString(_m2.Get((Object)("fetchOrderBook"))),0);
RDebugUtils.currentLine=2031655;
 //BA.debugLineNum = 2031655;BA.debugLine="Log(\"Get_OHLCV: \" & m2.Get(\"fetchOHLCV\"))";
anywheresoftware.b4a.keywords.Common.LogImpl("72031655","Get_OHLCV: "+BA.ObjectToString(_m2.Get((Object)("fetchOHLCV"))),0);
RDebugUtils.currentLine=2031656;
 //BA.debugLineNum = 2031656;BA.debugLine="Log(\"Get_Public_Trade_History: \" & m2.Get(\"fetc";
anywheresoftware.b4a.keywords.Common.LogImpl("72031656","Get_Public_Trade_History: "+BA.ObjectToString(_m2.Get((Object)("fetchTrades"))),0);
RDebugUtils.currentLine=2031657;
 //BA.debugLineNum = 2031657;BA.debugLine="Log(\"Get_My_Balances: \" & m2.Get(\"fetchBalance\"";
anywheresoftware.b4a.keywords.Common.LogImpl("72031657","Get_My_Balances: "+BA.ObjectToString(_m2.Get((Object)("fetchBalance"))),0);
RDebugUtils.currentLine=2031658;
 //BA.debugLineNum = 2031658;BA.debugLine="Log(\"Get_All_My_Open_Orders: \" & m2.Get(\"fetchO";
anywheresoftware.b4a.keywords.Common.LogImpl("72031658","Get_All_My_Open_Orders: "+BA.ObjectToString(_m2.Get((Object)("fetchOpenOrders"))),0);
RDebugUtils.currentLine=2031659;
 //BA.debugLineNum = 2031659;BA.debugLine="Log(\"Cancel_Order: \" & m2.Get(\"cancelOrder\"))";
anywheresoftware.b4a.keywords.Common.LogImpl("72031659","Cancel_Order: "+BA.ObjectToString(_m2.Get((Object)("cancelOrder"))),0);
RDebugUtils.currentLine=2031660;
 //BA.debugLineNum = 2031660;BA.debugLine="m2 = m1.Get(\"timeframes\")															'for OH";
_m2 = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_m1.Get((Object)("timeframes"))));
RDebugUtils.currentLine=2031661;
 //BA.debugLineNum = 2031661;BA.debugLine="For i = 0 To m2.Size-1";
{
final int step21 = 1;
final int limit21 = (int) (_m2.getSize()-1);
_i = (int) (0) ;
for (;_i <= limit21 ;_i = _i + step21 ) {
RDebugUtils.currentLine=2031662;
 //BA.debugLineNum = 2031662;BA.debugLine="Dim tf As String = m2.GetKeyAt(i)";
_tf = BA.ObjectToString(_m2.GetKeyAt(_i));
RDebugUtils.currentLine=2031663;
 //BA.debugLineNum = 2031663;BA.debugLine="OHLCV_TimeFrame_List.Add(tf)";
_ohlcv_timeframe_list.Add((Object)(_tf));
 }
};
RDebugUtils.currentLine=2031665;
 //BA.debugLineNum = 2031665;BA.debugLine="Log(\"Supported OHLCV Time Frames: \" & OHLCV_Tim";
anywheresoftware.b4a.keywords.Common.LogImpl("72031665","Supported OHLCV Time Frames: "+BA.ObjectToString(_ohlcv_timeframe_list),0);
 };
 } 
       catch (Exception e28) {
			ba.setLastException(e28);RDebugUtils.currentLine=2031669;
 //BA.debugLineNum = 2031669;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("72031669",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=2031671;
 //BA.debugLineNum = 2031671;BA.debugLine="End Sub";
return "";
}
public static String  _get_exchanges_completed(String _result) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "get_exchanges_completed", false))
	 {return ((String) Debug.delegate(ba, "get_exchanges_completed", new Object[] {_result}));}
anywheresoftware.b4a.objects.collections.List _l = null;
int _i = 0;
RDebugUtils.currentLine=1966080;
 //BA.debugLineNum = 1966080;BA.debugLine="Private Sub Get_Exchanges_completed(result As Stri";
RDebugUtils.currentLine=1966081;
 //BA.debugLineNum = 1966081;BA.debugLine="Log(\"Get_Exchanges_completed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("71966081","Get_Exchanges_completed",0);
RDebugUtils.currentLine=1966083;
 //BA.debugLineNum = 1966083;BA.debugLine="Try";
try {RDebugUtils.currentLine=1966084;
 //BA.debugLineNum = 1966084;BA.debugLine="If Is_JSON(result) = True Then";
if (_is_json(_result)==anywheresoftware.b4a.keywords.Common.True) { 
RDebugUtils.currentLine=1966085;
 //BA.debugLineNum = 1966085;BA.debugLine="JSON.Initialize(result)";
_json.Initialize(_result);
RDebugUtils.currentLine=1966086;
 //BA.debugLineNum = 1966086;BA.debugLine="Dim L As List";
_l = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=1966087;
 //BA.debugLineNum = 1966087;BA.debugLine="L = JSON.NextArray";
_l = _json.NextArray();
RDebugUtils.currentLine=1966088;
 //BA.debugLineNum = 1966088;BA.debugLine="For i = 0 To L.Size-1";
{
final int step7 = 1;
final int limit7 = (int) (_l.getSize()-1);
_i = (int) (0) ;
for (;_i <= limit7 ;_i = _i + step7 ) {
 }
};
 };
 } 
       catch (Exception e11) {
			ba.setLastException(e11);RDebugUtils.currentLine=1966097;
 //BA.debugLineNum = 1966097;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("71966097",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=1966099;
 //BA.debugLineNum = 1966099;BA.debugLine="End Sub";
return "";
}
public static String  _get_markets_completed(String _result) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "get_markets_completed", false))
	 {return ((String) Debug.delegate(ba, "get_markets_completed", new Object[] {_result}));}
String _coinpair = "";
String _pcoin = "";
String _scoin = "";
anywheresoftware.b4a.objects.collections.List _l1 = null;
anywheresoftware.b4a.objects.collections.Map _m1 = null;
int _i = 0;
Object _coin = null;
RDebugUtils.currentLine=2097152;
 //BA.debugLineNum = 2097152;BA.debugLine="Private Sub Get_Markets_completed(result As String";
RDebugUtils.currentLine=2097153;
 //BA.debugLineNum = 2097153;BA.debugLine="Log(\"Get_Markets_completed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72097153","Get_Markets_completed",0);
RDebugUtils.currentLine=2097164;
 //BA.debugLineNum = 2097164;BA.debugLine="Try";
try {RDebugUtils.currentLine=2097166;
 //BA.debugLineNum = 2097166;BA.debugLine="If Is_JSON(result) Then";
if (_is_json(_result)) { 
RDebugUtils.currentLine=2097167;
 //BA.debugLineNum = 2097167;BA.debugLine="JSON.Initialize(result)";
_json.Initialize(_result);
RDebugUtils.currentLine=2097168;
 //BA.debugLineNum = 2097168;BA.debugLine="Dim coinpair, pcoin, scoin As String";
_coinpair = "";
_pcoin = "";
_scoin = "";
RDebugUtils.currentLine=2097169;
 //BA.debugLineNum = 2097169;BA.debugLine="Dim L1 As List";
_l1 = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=2097170;
 //BA.debugLineNum = 2097170;BA.debugLine="Dim m1 As Map";
_m1 = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=2097171;
 //BA.debugLineNum = 2097171;BA.debugLine="L1 = JSON.NextArray";
_l1 = _json.NextArray();
RDebugUtils.currentLine=2097172;
 //BA.debugLineNum = 2097172;BA.debugLine="Log(L1)";
anywheresoftware.b4a.keywords.Common.LogImpl("72097172",BA.ObjectToString(_l1),0);
RDebugUtils.currentLine=2097174;
 //BA.debugLineNum = 2097174;BA.debugLine="Pcoin_List.Initialize";
_pcoin_list.Initialize();
RDebugUtils.currentLine=2097175;
 //BA.debugLineNum = 2097175;BA.debugLine="Scoin_List.Initialize";
_scoin_list.Initialize();
RDebugUtils.currentLine=2097176;
 //BA.debugLineNum = 2097176;BA.debugLine="Coinpair_List.Initialize";
_coinpair_list.Initialize();
RDebugUtils.currentLine=2097177;
 //BA.debugLineNum = 2097177;BA.debugLine="test_ui.cmb_Coinpair.Items.Clear";
_test_ui._cmb_coinpair /*anywheresoftware.b4j.objects.ComboBoxWrapper*/ .getItems().Clear();
RDebugUtils.currentLine=2097179;
 //BA.debugLineNum = 2097179;BA.debugLine="For i = 0 To L1.Size-1";
{
final int step14 = 1;
final int limit14 = (int) (_l1.getSize()-1);
_i = (int) (0) ;
for (;_i <= limit14 ;_i = _i + step14 ) {
RDebugUtils.currentLine=2097180;
 //BA.debugLineNum = 2097180;BA.debugLine="m1 = L1.Get(i)";
_m1 = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_l1.Get(_i)));
RDebugUtils.currentLine=2097181;
 //BA.debugLineNum = 2097181;BA.debugLine="Log(m1)";
anywheresoftware.b4a.keywords.Common.LogImpl("72097181",BA.ObjectToString(_m1),0);
RDebugUtils.currentLine=2097182;
 //BA.debugLineNum = 2097182;BA.debugLine="pcoin = m1.Get(\"base\")";
_pcoin = BA.ObjectToString(_m1.Get((Object)("base")));
RDebugUtils.currentLine=2097183;
 //BA.debugLineNum = 2097183;BA.debugLine="Pcoin_List.Add(pcoin)";
_pcoin_list.Add((Object)(_pcoin));
RDebugUtils.currentLine=2097184;
 //BA.debugLineNum = 2097184;BA.debugLine="coinpair = m1.Get(\"symbol\")";
_coinpair = BA.ObjectToString(_m1.Get((Object)("symbol")));
RDebugUtils.currentLine=2097185;
 //BA.debugLineNum = 2097185;BA.debugLine="Coinpair_List.Add(coinpair)";
_coinpair_list.Add((Object)(_coinpair));
RDebugUtils.currentLine=2097186;
 //BA.debugLineNum = 2097186;BA.debugLine="scoin = m1.Get(\"quote\")";
_scoin = BA.ObjectToString(_m1.Get((Object)("quote")));
RDebugUtils.currentLine=2097187;
 //BA.debugLineNum = 2097187;BA.debugLine="If Scoin_List.IndexOf(scoin) = -1 Then Scoin_Li";
if (_scoin_list.IndexOf((Object)(_scoin))==-1) { 
_scoin_list.Add((Object)(_scoin));};
 }
};
RDebugUtils.currentLine=2097191;
 //BA.debugLineNum = 2097191;BA.debugLine="test_ui.cmb_Scoin.Items.Clear";
_test_ui._cmb_scoin /*anywheresoftware.b4j.objects.ComboBoxWrapper*/ .getItems().Clear();
RDebugUtils.currentLine=2097192;
 //BA.debugLineNum = 2097192;BA.debugLine="Scoin_List.Sort(True)";
_scoin_list.Sort(anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=2097193;
 //BA.debugLineNum = 2097193;BA.debugLine="For Each coin In Scoin_List";
{
final anywheresoftware.b4a.BA.IterableList group26 = _scoin_list;
final int groupLen26 = group26.getSize()
;int index26 = 0;
;
for (; index26 < groupLen26;index26++){
_coin = group26.Get(index26);
RDebugUtils.currentLine=2097194;
 //BA.debugLineNum = 2097194;BA.debugLine="test_ui.cmb_Scoin.Items.Add(coin)";
_test_ui._cmb_scoin /*anywheresoftware.b4j.objects.ComboBoxWrapper*/ .getItems().Add(_coin);
 }
};
 };
 } 
       catch (Exception e31) {
			ba.setLastException(e31);RDebugUtils.currentLine=2097199;
 //BA.debugLineNum = 2097199;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("72097199",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=2097201;
 //BA.debugLineNum = 2097201;BA.debugLine="End Sub";
return "";
}
public static String  _get_my_balances_completed(String _result) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "get_my_balances_completed", false))
	 {return ((String) Debug.delegate(ba, "get_my_balances_completed", new Object[] {_result}));}
anywheresoftware.b4a.objects.collections.Map _m1 = null;
anywheresoftware.b4a.objects.collections.Map _m2 = null;
String _key = "";
Object _val = null;
RDebugUtils.currentLine=2424832;
 //BA.debugLineNum = 2424832;BA.debugLine="Private Sub Get_My_Balances_completed(result As St";
RDebugUtils.currentLine=2424833;
 //BA.debugLineNum = 2424833;BA.debugLine="Log(\"Get_My_Balances_completed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72424833","Get_My_Balances_completed",0);
RDebugUtils.currentLine=2424835;
 //BA.debugLineNum = 2424835;BA.debugLine="Try";
try {RDebugUtils.currentLine=2424836;
 //BA.debugLineNum = 2424836;BA.debugLine="If Is_JSON(result) = True Then";
if (_is_json(_result)==anywheresoftware.b4a.keywords.Common.True) { 
RDebugUtils.currentLine=2424837;
 //BA.debugLineNum = 2424837;BA.debugLine="JSON.Initialize(result)";
_json.Initialize(_result);
RDebugUtils.currentLine=2424838;
 //BA.debugLineNum = 2424838;BA.debugLine="Dim m1, m2 As Map";
_m1 = new anywheresoftware.b4a.objects.collections.Map();
_m2 = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=2424840;
 //BA.debugLineNum = 2424840;BA.debugLine="m1 = JSON.NextObject";
_m1 = _json.NextObject();
RDebugUtils.currentLine=2424847;
 //BA.debugLineNum = 2424847;BA.debugLine="Log(\"----- Balance Held -----\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72424847","----- Balance Held -----",0);
RDebugUtils.currentLine=2424848;
 //BA.debugLineNum = 2424848;BA.debugLine="m2 = m1.Get(\"used\")";
_m2 = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_m1.Get((Object)("used"))));
RDebugUtils.currentLine=2424849;
 //BA.debugLineNum = 2424849;BA.debugLine="For Each Key As String In m2.Keys";
{
final anywheresoftware.b4a.BA.IterableList group9 = _m2.Keys();
final int groupLen9 = group9.getSize()
;int index9 = 0;
;
for (; index9 < groupLen9;index9++){
_key = BA.ObjectToString(group9.Get(index9));
RDebugUtils.currentLine=2424850;
 //BA.debugLineNum = 2424850;BA.debugLine="Dim val As Object = m2.Get(Key)";
_val = _m2.Get((Object)(_key));
RDebugUtils.currentLine=2424851;
 //BA.debugLineNum = 2424851;BA.debugLine="If val <> Null And val > 0 Then Log(Key & \": \"";
if (_val!= null && (double)(BA.ObjectToNumber(_val))>0) { 
anywheresoftware.b4a.keywords.Common.LogImpl("72424851",_key+": "+BA.ObjectToString(_val),0);};
 }
};
RDebugUtils.currentLine=2424854;
 //BA.debugLineNum = 2424854;BA.debugLine="Log(\"----- Balance Available -----\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72424854","----- Balance Available -----",0);
RDebugUtils.currentLine=2424855;
 //BA.debugLineNum = 2424855;BA.debugLine="m2 = m1.Get(\"free\")";
_m2 = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_m1.Get((Object)("free"))));
RDebugUtils.currentLine=2424856;
 //BA.debugLineNum = 2424856;BA.debugLine="For Each Key As String In m2.Keys";
{
final anywheresoftware.b4a.BA.IterableList group15 = _m2.Keys();
final int groupLen15 = group15.getSize()
;int index15 = 0;
;
for (; index15 < groupLen15;index15++){
_key = BA.ObjectToString(group15.Get(index15));
RDebugUtils.currentLine=2424857;
 //BA.debugLineNum = 2424857;BA.debugLine="Dim val As Object = m2.Get(Key)";
_val = _m2.Get((Object)(_key));
RDebugUtils.currentLine=2424858;
 //BA.debugLineNum = 2424858;BA.debugLine="If val <> Null And val > 0 Then Log(Key & \": \"";
if (_val!= null && (double)(BA.ObjectToNumber(_val))>0) { 
anywheresoftware.b4a.keywords.Common.LogImpl("72424858",_key+": "+BA.ObjectToString(_val),0);};
 }
};
RDebugUtils.currentLine=2424861;
 //BA.debugLineNum = 2424861;BA.debugLine="Log(\"----- Balance Total -----\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72424861","----- Balance Total -----",0);
RDebugUtils.currentLine=2424862;
 //BA.debugLineNum = 2424862;BA.debugLine="m2 = m1.Get(\"total\")";
_m2 = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_m1.Get((Object)("total"))));
RDebugUtils.currentLine=2424863;
 //BA.debugLineNum = 2424863;BA.debugLine="For Each Key As String In m2.Keys";
{
final anywheresoftware.b4a.BA.IterableList group21 = _m2.Keys();
final int groupLen21 = group21.getSize()
;int index21 = 0;
;
for (; index21 < groupLen21;index21++){
_key = BA.ObjectToString(group21.Get(index21));
RDebugUtils.currentLine=2424864;
 //BA.debugLineNum = 2424864;BA.debugLine="Dim val As Object = m2.Get(Key)";
_val = _m2.Get((Object)(_key));
RDebugUtils.currentLine=2424865;
 //BA.debugLineNum = 2424865;BA.debugLine="If val <> Null And val > 0 Then Log(Key & \": \"";
if (_val!= null && (double)(BA.ObjectToNumber(_val))>0) { 
anywheresoftware.b4a.keywords.Common.LogImpl("72424865",_key+": "+BA.ObjectToString(_val),0);};
 }
};
 };
 } 
       catch (Exception e27) {
			ba.setLastException(e27);RDebugUtils.currentLine=2424870;
 //BA.debugLineNum = 2424870;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("72424870",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=2424872;
 //BA.debugLineNum = 2424872;BA.debugLine="End Sub";
return "";
}
public static String  _get_my_trade_history_completed(String _result) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "get_my_trade_history_completed", false))
	 {return ((String) Debug.delegate(ba, "get_my_trade_history_completed", new Object[] {_result}));}
RDebugUtils.currentLine=2555904;
 //BA.debugLineNum = 2555904;BA.debugLine="Private Sub Get_My_Trade_History_Completed(result";
RDebugUtils.currentLine=2555905;
 //BA.debugLineNum = 2555905;BA.debugLine="Log(\"Get_My_Trade_History_Completed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72555905","Get_My_Trade_History_Completed",0);
RDebugUtils.currentLine=2555909;
 //BA.debugLineNum = 2555909;BA.debugLine="End Sub";
return "";
}
public static String  _get_ohlcv_completed(String _result) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "get_ohlcv_completed", false))
	 {return ((String) Debug.delegate(ba, "get_ohlcv_completed", new Object[] {_result}));}
anywheresoftware.b4a.objects.collections.List _l1 = null;
anywheresoftware.b4a.objects.collections.List _l2 = null;
int _i = 0;
RDebugUtils.currentLine=2359296;
 //BA.debugLineNum = 2359296;BA.debugLine="Private Sub Get_OHLCV_completed(result As String)";
RDebugUtils.currentLine=2359297;
 //BA.debugLineNum = 2359297;BA.debugLine="Log(\"Get_OHLCV_completed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72359297","Get_OHLCV_completed",0);
RDebugUtils.currentLine=2359298;
 //BA.debugLineNum = 2359298;BA.debugLine="Try";
try {RDebugUtils.currentLine=2359299;
 //BA.debugLineNum = 2359299;BA.debugLine="If Is_JSON(result) = True Then";
if (_is_json(_result)==anywheresoftware.b4a.keywords.Common.True) { 
RDebugUtils.currentLine=2359300;
 //BA.debugLineNum = 2359300;BA.debugLine="JSON.Initialize(result)";
_json.Initialize(_result);
RDebugUtils.currentLine=2359301;
 //BA.debugLineNum = 2359301;BA.debugLine="Dim L1, L2 As List";
_l1 = new anywheresoftware.b4a.objects.collections.List();
_l2 = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=2359302;
 //BA.debugLineNum = 2359302;BA.debugLine="L1 = JSON.NextArray";
_l1 = _json.NextArray();
RDebugUtils.currentLine=2359304;
 //BA.debugLineNum = 2359304;BA.debugLine="For i = 0 To L1.Size-1";
{
final int step7 = 1;
final int limit7 = (int) (_l1.getSize()-1);
_i = (int) (0) ;
for (;_i <= limit7 ;_i = _i + step7 ) {
RDebugUtils.currentLine=2359305;
 //BA.debugLineNum = 2359305;BA.debugLine="L2 = L1.Get(i)";
_l2 = (anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_l1.Get(_i)));
RDebugUtils.currentLine=2359306;
 //BA.debugLineNum = 2359306;BA.debugLine="Log(\"TS: \" & L2.Get(0) & \" open: \" & L2.Get(1)";
anywheresoftware.b4a.keywords.Common.LogImpl("72359306","TS: "+BA.ObjectToString(_l2.Get((int) (0)))+" open: "+BA.ObjectToString(_l2.Get((int) (1)))+" high: "+BA.ObjectToString(_l2.Get((int) (2)))+" low: "+BA.ObjectToString(_l2.Get((int) (3)))+" close: "+BA.ObjectToString(_l2.Get((int) (4)))+" volume: "+BA.ObjectToString(_l2.Get((int) (5))),0);
 }
};
 };
 } 
       catch (Exception e13) {
			ba.setLastException(e13);RDebugUtils.currentLine=2359312;
 //BA.debugLineNum = 2359312;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("72359312",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=2359314;
 //BA.debugLineNum = 2359314;BA.debugLine="End Sub";
return "";
}
public static String  _get_orderbook_completed(String _result) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "get_orderbook_completed", false))
	 {return ((String) Debug.delegate(ba, "get_orderbook_completed", new Object[] {_result}));}
String _coinpair = "";
double _price = 0;
double _volume = 0;
anywheresoftware.b4a.objects.collections.List _l1 = null;
anywheresoftware.b4a.objects.collections.List _l2 = null;
anywheresoftware.b4a.objects.collections.Map _m1 = null;
int _i = 0;
RDebugUtils.currentLine=2293760;
 //BA.debugLineNum = 2293760;BA.debugLine="Private Sub Get_Orderbook_completed(result As Stri";
RDebugUtils.currentLine=2293761;
 //BA.debugLineNum = 2293761;BA.debugLine="Log(\"Get_Orderbook_completed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72293761","Get_Orderbook_completed",0);
RDebugUtils.currentLine=2293762;
 //BA.debugLineNum = 2293762;BA.debugLine="Try";
try {RDebugUtils.currentLine=2293764;
 //BA.debugLineNum = 2293764;BA.debugLine="If Is_JSON(result) Then";
if (_is_json(_result)) { 
RDebugUtils.currentLine=2293765;
 //BA.debugLineNum = 2293765;BA.debugLine="JSON.Initialize(result)";
_json.Initialize(_result);
RDebugUtils.currentLine=2293766;
 //BA.debugLineNum = 2293766;BA.debugLine="Dim coinpair As String";
_coinpair = "";
RDebugUtils.currentLine=2293767;
 //BA.debugLineNum = 2293767;BA.debugLine="Dim price, volume As Double";
_price = 0;
_volume = 0;
RDebugUtils.currentLine=2293768;
 //BA.debugLineNum = 2293768;BA.debugLine="Dim L1, L2 As List";
_l1 = new anywheresoftware.b4a.objects.collections.List();
_l2 = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=2293769;
 //BA.debugLineNum = 2293769;BA.debugLine="Dim m1 As Map";
_m1 = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=2293770;
 //BA.debugLineNum = 2293770;BA.debugLine="m1 = JSON.NextObject";
_m1 = _json.NextObject();
RDebugUtils.currentLine=2293771;
 //BA.debugLineNum = 2293771;BA.debugLine="coinpair = m1.Get(\"symbol\")";
_coinpair = BA.ObjectToString(_m1.Get((Object)("symbol")));
RDebugUtils.currentLine=2293772;
 //BA.debugLineNum = 2293772;BA.debugLine="If coinpair = Main.Selected_Coinpair Then";
if ((_coinpair).equals(_main._selected_coinpair /*String*/ )) { 
RDebugUtils.currentLine=2293773;
 //BA.debugLineNum = 2293773;BA.debugLine="Buy_Orderbook_Map.Initialize";
_buy_orderbook_map.Initialize();
RDebugUtils.currentLine=2293774;
 //BA.debugLineNum = 2293774;BA.debugLine="L1 = m1.Get(\"bids\")";
_l1 = (anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_m1.Get((Object)("bids"))));
RDebugUtils.currentLine=2293775;
 //BA.debugLineNum = 2293775;BA.debugLine="For i = 0 To L1.Size - 1";
{
final int step14 = 1;
final int limit14 = (int) (_l1.getSize()-1);
_i = (int) (0) ;
for (;_i <= limit14 ;_i = _i + step14 ) {
RDebugUtils.currentLine=2293776;
 //BA.debugLineNum = 2293776;BA.debugLine="L2 = L1.Get(i)";
_l2 = (anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_l1.Get(_i)));
RDebugUtils.currentLine=2293777;
 //BA.debugLineNum = 2293777;BA.debugLine="price = L2.Get(0)";
_price = (double)(BA.ObjectToNumber(_l2.Get((int) (0))));
RDebugUtils.currentLine=2293778;
 //BA.debugLineNum = 2293778;BA.debugLine="volume = L2.Get(1)";
_volume = (double)(BA.ObjectToNumber(_l2.Get((int) (1))));
RDebugUtils.currentLine=2293779;
 //BA.debugLineNum = 2293779;BA.debugLine="Buy_Orderbook_Map.Put(price, volume)";
_buy_orderbook_map.Put((Object)(_price),(Object)(_volume));
 }
};
RDebugUtils.currentLine=2293782;
 //BA.debugLineNum = 2293782;BA.debugLine="Sell_Orderbook_Map.Initialize";
_sell_orderbook_map.Initialize();
RDebugUtils.currentLine=2293783;
 //BA.debugLineNum = 2293783;BA.debugLine="L1 = m1.Get(\"asks\")";
_l1 = (anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_m1.Get((Object)("asks"))));
RDebugUtils.currentLine=2293784;
 //BA.debugLineNum = 2293784;BA.debugLine="For i = 0 To L1.Size - 1";
{
final int step22 = 1;
final int limit22 = (int) (_l1.getSize()-1);
_i = (int) (0) ;
for (;_i <= limit22 ;_i = _i + step22 ) {
RDebugUtils.currentLine=2293785;
 //BA.debugLineNum = 2293785;BA.debugLine="L2 = L1.Get(i)";
_l2 = (anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_l1.Get(_i)));
RDebugUtils.currentLine=2293786;
 //BA.debugLineNum = 2293786;BA.debugLine="price = L2.Get(0)";
_price = (double)(BA.ObjectToNumber(_l2.Get((int) (0))));
RDebugUtils.currentLine=2293787;
 //BA.debugLineNum = 2293787;BA.debugLine="volume = L2.Get(1)";
_volume = (double)(BA.ObjectToNumber(_l2.Get((int) (1))));
RDebugUtils.currentLine=2293788;
 //BA.debugLineNum = 2293788;BA.debugLine="Sell_Orderbook_Map.Put(price, volume)";
_sell_orderbook_map.Put((Object)(_price),(Object)(_volume));
 }
};
 };
 };
 } 
       catch (Exception e31) {
			ba.setLastException(e31);RDebugUtils.currentLine=2293794;
 //BA.debugLineNum = 2293794;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("72293794",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=2293796;
 //BA.debugLineNum = 2293796;BA.debugLine="End Sub";
return "";
}
public static String  _get_ticker_completed(String _result) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "get_ticker_completed", false))
	 {return ((String) Debug.delegate(ba, "get_ticker_completed", new Object[] {_result}));}
anywheresoftware.b4a.objects.collections.Map _m1 = null;
String _coinpair = "";
RDebugUtils.currentLine=2162688;
 //BA.debugLineNum = 2162688;BA.debugLine="Private Sub Get_Ticker_completed(result As String)";
RDebugUtils.currentLine=2162689;
 //BA.debugLineNum = 2162689;BA.debugLine="Log(\"Get_Ticker_completed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72162689","Get_Ticker_completed",0);
RDebugUtils.currentLine=2162711;
 //BA.debugLineNum = 2162711;BA.debugLine="Try";
try {RDebugUtils.currentLine=2162712;
 //BA.debugLineNum = 2162712;BA.debugLine="If Is_JSON(result) = True Then";
if (_is_json(_result)==anywheresoftware.b4a.keywords.Common.True) { 
RDebugUtils.currentLine=2162713;
 //BA.debugLineNum = 2162713;BA.debugLine="JSON.Initialize(result)";
_json.Initialize(_result);
RDebugUtils.currentLine=2162714;
 //BA.debugLineNum = 2162714;BA.debugLine="Dim m1 As Map";
_m1 = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=2162715;
 //BA.debugLineNum = 2162715;BA.debugLine="m1 = JSON.NextObject";
_m1 = _json.NextObject();
RDebugUtils.currentLine=2162716;
 //BA.debugLineNum = 2162716;BA.debugLine="Dim coinpair As String = m1.Get(\"symbol\")";
_coinpair = BA.ObjectToString(_m1.Get((Object)("symbol")));
RDebugUtils.currentLine=2162717;
 //BA.debugLineNum = 2162717;BA.debugLine="Log(\"-----\" & coinpair & \"-----\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72162717","-----"+_coinpair+"-----",0);
RDebugUtils.currentLine=2162718;
 //BA.debugLineNum = 2162718;BA.debugLine="Log(\"TS: \" & m1.Get(\"timestamp\"))";
anywheresoftware.b4a.keywords.Common.LogImpl("72162718","TS: "+BA.ObjectToString(_m1.Get((Object)("timestamp"))),0);
RDebugUtils.currentLine=2162719;
 //BA.debugLineNum = 2162719;BA.debugLine="Log(	Calc.My_Date_Time( m1.Get(\"timestamp\")))";
anywheresoftware.b4a.keywords.Common.LogImpl("72162719",_calc._my_date_time /*String*/ (BA.ObjectToLongNumber(_m1.Get((Object)("timestamp")))),0);
RDebugUtils.currentLine=2162721;
 //BA.debugLineNum = 2162721;BA.debugLine="Log(\"price: \" & m1.Get(\"close\"))		'same as \"las";
anywheresoftware.b4a.keywords.Common.LogImpl("72162721","price: "+BA.ObjectToString(_m1.Get((Object)("close"))),0);
RDebugUtils.currentLine=2162722;
 //BA.debugLineNum = 2162722;BA.debugLine="Log(\"24hr volume: \" & m1.Get(\"quoteVolume\") & \"";
anywheresoftware.b4a.keywords.Common.LogImpl("72162722","24hr volume: "+BA.ObjectToString(_m1.Get((Object)("quoteVolume")))+" "+_calc._get_scoin /*String*/ (_coinpair),0);
RDebugUtils.currentLine=2162723;
 //BA.debugLineNum = 2162723;BA.debugLine="Log(\"24hr change: \" & m1.Get(\"change\") & \"%\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72162723","24hr change: "+BA.ObjectToString(_m1.Get((Object)("change")))+"%",0);
 };
 } 
       catch (Exception e16) {
			ba.setLastException(e16);RDebugUtils.currentLine=2162728;
 //BA.debugLineNum = 2162728;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("72162728",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=2162730;
 //BA.debugLineNum = 2162730;BA.debugLine="End Sub";
return "";
}
public static String  _markets() throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "markets", false))
	 {return ((String) Debug.delegate(ba, "markets", null));}
RDebugUtils.currentLine=3276800;
 //BA.debugLineNum = 3276800;BA.debugLine="Sub Markets";
RDebugUtils.currentLine=3276801;
 //BA.debugLineNum = 3276801;BA.debugLine="fetch_markets";
_fetch_markets();
RDebugUtils.currentLine=3276802;
 //BA.debugLineNum = 3276802;BA.debugLine="End Sub";
return "";
}
public static String  _my_balances() throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "my_balances", false))
	 {return ((String) Debug.delegate(ba, "my_balances", null));}
RDebugUtils.currentLine=3670016;
 //BA.debugLineNum = 3670016;BA.debugLine="Sub My_Balances";
RDebugUtils.currentLine=3670017;
 //BA.debugLineNum = 3670017;BA.debugLine="fetch_balance";
_fetch_balance();
RDebugUtils.currentLine=3670018;
 //BA.debugLineNum = 3670018;BA.debugLine="End Sub";
return "";
}
public static String  _my_open_orders(String _coinpair) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "my_open_orders", false))
	 {return ((String) Debug.delegate(ba, "my_open_orders", new Object[] {_coinpair}));}
RDebugUtils.currentLine=3735552;
 //BA.debugLineNum = 3735552;BA.debugLine="Sub My_Open_Orders(coinpair As String)	'optional c";
RDebugUtils.currentLine=3735553;
 //BA.debugLineNum = 3735553;BA.debugLine="fetch_open_orders(coinpair)";
_fetch_open_orders(_coinpair);
RDebugUtils.currentLine=3735554;
 //BA.debugLineNum = 3735554;BA.debugLine="End Sub";
return "";
}
public static String  _my_trade_history(String _coinpair,long _since,int _limit) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "my_trade_history", false))
	 {return ((String) Debug.delegate(ba, "my_trade_history", new Object[] {_coinpair,_since,_limit}));}
RDebugUtils.currentLine=3866624;
 //BA.debugLineNum = 3866624;BA.debugLine="Sub My_Trade_History(coinpair As String, since As";
RDebugUtils.currentLine=3866625;
 //BA.debugLineNum = 3866625;BA.debugLine="fetch_my_trades(coinpair, since, limit)";
_fetch_my_trades(_coinpair,_since,_limit);
RDebugUtils.currentLine=3866626;
 //BA.debugLineNum = 3866626;BA.debugLine="End Sub";
return "";
}
public static String  _ohlcv(String _coinpair,String _timeframe) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "ohlcv", false))
	 {return ((String) Debug.delegate(ba, "ohlcv", new Object[] {_coinpair,_timeframe}));}
RDebugUtils.currentLine=3538944;
 //BA.debugLineNum = 3538944;BA.debugLine="Sub OHLCV(coinpair As String, timeframe As String)";
RDebugUtils.currentLine=3538945;
 //BA.debugLineNum = 3538945;BA.debugLine="fetch_ohlcv(coinpair, timeframe)";
_fetch_ohlcv(_coinpair,_timeframe);
RDebugUtils.currentLine=3538946;
 //BA.debugLineNum = 3538946;BA.debugLine="End Sub";
return "";
}
public static String  _order_completed(String _result) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "order_completed", false))
	 {return ((String) Debug.delegate(ba, "order_completed", new Object[] {_result}));}
anywheresoftware.b4a.objects.collections.Map _m = null;
long _ts = 0L;
String _coinpair = "";
String _side = "";
String _id = "";
double _amount = 0;
double _filled = 0;
double _remaining = 0;
String _order_type = "";
String _status = "";
double _price = 0;
RDebugUtils.currentLine=2686976;
 //BA.debugLineNum = 2686976;BA.debugLine="Private Sub Order_Completed(result As String)";
RDebugUtils.currentLine=2686977;
 //BA.debugLineNum = 2686977;BA.debugLine="Log(\"Order_Completed\")";
anywheresoftware.b4a.keywords.Common.LogImpl("72686977","Order_Completed",0);
RDebugUtils.currentLine=2686979;
 //BA.debugLineNum = 2686979;BA.debugLine="Try";
try {RDebugUtils.currentLine=2686980;
 //BA.debugLineNum = 2686980;BA.debugLine="If Is_JSON(result) = True Then";
if (_is_json(_result)==anywheresoftware.b4a.keywords.Common.True) { 
RDebugUtils.currentLine=2686981;
 //BA.debugLineNum = 2686981;BA.debugLine="JSON.Initialize(result)";
_json.Initialize(_result);
RDebugUtils.currentLine=2686982;
 //BA.debugLineNum = 2686982;BA.debugLine="Dim m As Map";
_m = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=2686983;
 //BA.debugLineNum = 2686983;BA.debugLine="m = JSON.NextObject";
_m = _json.NextObject();
RDebugUtils.currentLine=2686984;
 //BA.debugLineNum = 2686984;BA.debugLine="Dim ts As Long = m.GetDefault(\"timestamp\", DateT";
_ts = BA.ObjectToLongNumber(_m.GetDefault((Object)("timestamp"),(Object)(anywheresoftware.b4a.keywords.Common.DateTime.getNow())));
RDebugUtils.currentLine=2686985;
 //BA.debugLineNum = 2686985;BA.debugLine="Dim coinpair As String = m.GetDefault(\"symbol\",";
_coinpair = BA.ObjectToString(_m.GetDefault((Object)("symbol"),(Object)("none")));
RDebugUtils.currentLine=2686986;
 //BA.debugLineNum = 2686986;BA.debugLine="Dim side As String = m.GetDefault(\"side\", \"none\"";
_side = BA.ObjectToString(_m.GetDefault((Object)("side"),(Object)("none")));
RDebugUtils.currentLine=2686987;
 //BA.debugLineNum = 2686987;BA.debugLine="Dim id As String = m.GetDefault(\"id\", \"none\")";
_id = BA.ObjectToString(_m.GetDefault((Object)("id"),(Object)("none")));
RDebugUtils.currentLine=2686988;
 //BA.debugLineNum = 2686988;BA.debugLine="Dim amount As Double = m.GetDefault(\"amount\", 0)";
_amount = (double)(BA.ObjectToNumber(_m.GetDefault((Object)("amount"),(Object)(0))));
RDebugUtils.currentLine=2686989;
 //BA.debugLineNum = 2686989;BA.debugLine="Dim filled As Double = m.GetDefault(\"filled\", 0)";
_filled = (double)(BA.ObjectToNumber(_m.GetDefault((Object)("filled"),(Object)(0))));
RDebugUtils.currentLine=2686990;
 //BA.debugLineNum = 2686990;BA.debugLine="Dim remaining As Double = m.GetDefault(\"remainin";
_remaining = (double)(BA.ObjectToNumber(_m.GetDefault((Object)("remaining"),(Object)(0))));
RDebugUtils.currentLine=2686991;
 //BA.debugLineNum = 2686991;BA.debugLine="Dim order_type As String = m.GetDefault(\"type\",";
_order_type = BA.ObjectToString(_m.GetDefault((Object)("type"),(Object)("none")));
RDebugUtils.currentLine=2686992;
 //BA.debugLineNum = 2686992;BA.debugLine="Dim status As String = m.GetDefault(\"status\", \"n";
_status = BA.ObjectToString(_m.GetDefault((Object)("status"),(Object)("none")));
RDebugUtils.currentLine=2686994;
 //BA.debugLineNum = 2686994;BA.debugLine="If side = \"sell\" Then";
if ((_side).equals("sell")) { 
RDebugUtils.currentLine=2686995;
 //BA.debugLineNum = 2686995;BA.debugLine="Dim price As Double = m.GetDefault(\"price\", 0)";
_price = (double)(BA.ObjectToNumber(_m.GetDefault((Object)("price"),(Object)(0))));
 }else {
RDebugUtils.currentLine=2686997;
 //BA.debugLineNum = 2686997;BA.debugLine="Dim price As Double = m.GetDefault(\"price\", 100";
_price = (double)(BA.ObjectToNumber(_m.GetDefault((Object)("price"),(Object)(1000000))));
 };
RDebugUtils.currentLine=2687000;
 //BA.debugLineNum = 2687000;BA.debugLine="If result.Contains(\"error\") = False Then Add_My_";
if (_result.contains("error")==anywheresoftware.b4a.keywords.Common.False) { 
_add_my_order(_ts,_coinpair,_side,_id,_price,_amount,_filled,_remaining,_order_type,_status);};
 };
 } 
       catch (Exception e24) {
			ba.setLastException(e24);RDebugUtils.currentLine=2687004;
 //BA.debugLineNum = 2687004;BA.debugLine="Log(LastException)";
anywheresoftware.b4a.keywords.Common.LogImpl("72687004",BA.ObjectToString(anywheresoftware.b4a.keywords.Common.LastException(ba)),0);
 };
RDebugUtils.currentLine=2687007;
 //BA.debugLineNum = 2687007;BA.debugLine="End Sub";
return "";
}
public static String  _orderbook(String _coinpair,int _limit) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "orderbook", false))
	 {return ((String) Debug.delegate(ba, "orderbook", new Object[] {_coinpair,_limit}));}
RDebugUtils.currentLine=3473408;
 //BA.debugLineNum = 3473408;BA.debugLine="Sub OrderBook(coinpair As String, limit As Int)";
RDebugUtils.currentLine=3473409;
 //BA.debugLineNum = 3473409;BA.debugLine="fetch_l2_order_book(coinpair, limit)";
_fetch_l2_order_book(_coinpair,_limit);
RDebugUtils.currentLine=3473410;
 //BA.debugLineNum = 3473410;BA.debugLine="End Sub";
return "";
}
public static String  _place_market_buy_order(String _coinpair,double _volume) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "place_market_buy_order", false))
	 {return ((String) Debug.delegate(ba, "place_market_buy_order", new Object[] {_coinpair,_volume}));}
RDebugUtils.currentLine=3997696;
 //BA.debugLineNum = 3997696;BA.debugLine="Sub Place_Market_Buy_Order(coinpair As String, vol";
RDebugUtils.currentLine=3997697;
 //BA.debugLineNum = 3997697;BA.debugLine="create_market_buy_order(coinpair, volume)";
_create_market_buy_order(_coinpair,_volume);
RDebugUtils.currentLine=3997698;
 //BA.debugLineNum = 3997698;BA.debugLine="End Sub";
return "";
}
public static String  _place_market_sell_order(String _coinpair,double _volume) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "place_market_sell_order", false))
	 {return ((String) Debug.delegate(ba, "place_market_sell_order", new Object[] {_coinpair,_volume}));}
RDebugUtils.currentLine=4063232;
 //BA.debugLineNum = 4063232;BA.debugLine="Sub Place_Market_Sell_Order(coinpair As String, vo";
RDebugUtils.currentLine=4063233;
 //BA.debugLineNum = 4063233;BA.debugLine="create_market_sell_order(coinpair, volume)";
_create_market_sell_order(_coinpair,_volume);
RDebugUtils.currentLine=4063234;
 //BA.debugLineNum = 4063234;BA.debugLine="End Sub";
return "";
}
public static String  _public_trade_history(String _coinpair,int _limit) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "public_trade_history", false))
	 {return ((String) Debug.delegate(ba, "public_trade_history", new Object[] {_coinpair,_limit}));}
RDebugUtils.currentLine=3604480;
 //BA.debugLineNum = 3604480;BA.debugLine="Sub Public_Trade_History(coinpair As String, limit";
RDebugUtils.currentLine=3604481;
 //BA.debugLineNum = 3604481;BA.debugLine="fetch_trades(coinpair, limit)";
_fetch_trades(_coinpair,_limit);
RDebugUtils.currentLine=3604482;
 //BA.debugLineNum = 3604482;BA.debugLine="End Sub";
return "";
}
public static String  _test_ccxt() throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "test_ccxt", false))
	 {return ((String) Debug.delegate(ba, "test_ccxt", null));}
String _input = "";
RDebugUtils.currentLine=393216;
 //BA.debugLineNum = 393216;BA.debugLine="Sub Test_CCXT";
RDebugUtils.currentLine=393217;
 //BA.debugLineNum = 393217;BA.debugLine="Dim input As String = \"bot=NA&command=Test_CCXT\"";
_input = "bot=NA&command=Test_CCXT";
RDebugUtils.currentLine=393218;
 //BA.debugLineNum = 393218;BA.debugLine="API_Call(\"Test_CCXT\", input)";
_api_call("Test_CCXT",_input);
RDebugUtils.currentLine=393219;
 //BA.debugLineNum = 393219;BA.debugLine="End Sub";
return "";
}
public static String  _test_php() throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "test_php", false))
	 {return ((String) Debug.delegate(ba, "test_php", null));}
String _input = "";
RDebugUtils.currentLine=327680;
 //BA.debugLineNum = 327680;BA.debugLine="Sub Test_PHP";
RDebugUtils.currentLine=327681;
 //BA.debugLineNum = 327681;BA.debugLine="Dim input As String = \"bot=NA&command=Test_PHP\"";
_input = "bot=NA&command=Test_PHP";
RDebugUtils.currentLine=327682;
 //BA.debugLineNum = 327682;BA.debugLine="API_Call(\"Test_PHP\", input)";
_api_call("Test_PHP",_input);
RDebugUtils.currentLine=327683;
 //BA.debugLineNum = 327683;BA.debugLine="End Sub";
return "";
}
public static String  _ticker(String _coinpair) throws Exception{
RDebugUtils.currentModule="ccxt";
if (Debug.shouldDelegate(ba, "ticker", false))
	 {return ((String) Debug.delegate(ba, "ticker", new Object[] {_coinpair}));}
RDebugUtils.currentLine=3342336;
 //BA.debugLineNum = 3342336;BA.debugLine="Sub Ticker(coinpair As String)";
RDebugUtils.currentLine=3342337;
 //BA.debugLineNum = 3342337;BA.debugLine="fetch_ticker(coinpair)";
_fetch_ticker(_coinpair);
RDebugUtils.currentLine=3342338;
 //BA.debugLineNum = 3342338;BA.debugLine="End Sub";
return "";
}
}