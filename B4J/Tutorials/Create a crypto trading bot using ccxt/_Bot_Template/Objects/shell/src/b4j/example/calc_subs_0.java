package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class calc_subs_0 {


public static RemoteObject  _get_pcoin(RemoteObject _coinpair) throws Exception{
try {
		Debug.PushSubsStack("Get_Pcoin (calc) ","calc",2,calc.ba,calc.mostCurrent,15);
if (RapidSub.canDelegate("get_pcoin")) { return b4j.example.calc.remoteMe.runUserSub(false, "calc","get_pcoin", _coinpair);}
RemoteObject _pcoin = RemoteObject.createImmutable("");
RemoteObject _index = RemoteObject.createImmutable(0);
Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 15;BA.debugLine="Sub Get_Pcoin (coinpair As String) As String";
Debug.ShouldStop(16384);
 BA.debugLineNum = 16;BA.debugLine="Dim pcoin As String";
Debug.ShouldStop(32768);
_pcoin = RemoteObject.createImmutable("");Debug.locals.put("pcoin", _pcoin);
 BA.debugLineNum = 17;BA.debugLine="Dim index As Int = coinpair.IndexOf(\"/\")";
Debug.ShouldStop(65536);
_index = _coinpair.runMethod(true,"indexOf",(Object)(RemoteObject.createImmutable("/")));Debug.locals.put("index", _index);Debug.locals.put("index", _index);
 BA.debugLineNum = 18;BA.debugLine="pcoin = coinpair.SubString2(0, index)";
Debug.ShouldStop(131072);
_pcoin = _coinpair.runMethod(true,"substring",(Object)(BA.numberCast(int.class, 0)),(Object)(_index));Debug.locals.put("pcoin", _pcoin);
 BA.debugLineNum = 19;BA.debugLine="Return pcoin";
Debug.ShouldStop(262144);
if (true) return _pcoin;
 BA.debugLineNum = 20;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get_scoin(RemoteObject _coinpair) throws Exception{
try {
		Debug.PushSubsStack("Get_Scoin (calc) ","calc",2,calc.ba,calc.mostCurrent,23);
if (RapidSub.canDelegate("get_scoin")) { return b4j.example.calc.remoteMe.runUserSub(false, "calc","get_scoin", _coinpair);}
RemoteObject _scoin = RemoteObject.createImmutable("");
RemoteObject _index = RemoteObject.createImmutable(0);
Debug.locals.put("coinpair", _coinpair);
 BA.debugLineNum = 23;BA.debugLine="Sub Get_Scoin (coinpair As String) As String";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 24;BA.debugLine="Dim scoin As String";
Debug.ShouldStop(8388608);
_scoin = RemoteObject.createImmutable("");Debug.locals.put("scoin", _scoin);
 BA.debugLineNum = 25;BA.debugLine="Dim index As Int = coinpair.IndexOf(\"/\") + 1";
Debug.ShouldStop(16777216);
_index = RemoteObject.solve(new RemoteObject[] {_coinpair.runMethod(true,"indexOf",(Object)(RemoteObject.createImmutable("/"))),RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("index", _index);Debug.locals.put("index", _index);
 BA.debugLineNum = 26;BA.debugLine="scoin = coinpair.SubString(index)";
Debug.ShouldStop(33554432);
_scoin = _coinpair.runMethod(true,"substring",(Object)(_index));Debug.locals.put("scoin", _scoin);
 BA.debugLineNum = 27;BA.debugLine="Return scoin";
Debug.ShouldStop(67108864);
if (true) return _scoin;
 BA.debugLineNum = 28;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _my_date_time(RemoteObject _ts) throws Exception{
try {
		Debug.PushSubsStack("My_Date_Time (calc) ","calc",2,calc.ba,calc.mostCurrent,31);
if (RapidSub.canDelegate("my_date_time")) { return b4j.example.calc.remoteMe.runUserSub(false, "calc","my_date_time", _ts);}
RemoteObject _dt = RemoteObject.createImmutable("");
Debug.locals.put("TS", _ts);
 BA.debugLineNum = 31;BA.debugLine="Sub My_Date_Time(TS As Long) As String";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 32;BA.debugLine="DateTime.SetTimeZone(My_GMT_Offset)";
Debug.ShouldStop(-2147483648);
calc.__c.getField(false,"DateTime").runVoidMethod ("SetTimeZone",(Object)(BA.numberCast(double.class, calc._my_gmt_offset)));
 BA.debugLineNum = 33;BA.debugLine="Dim dt As String = DateTime.Date(TS) & \"   \" & Da";
Debug.ShouldStop(1);
_dt = RemoteObject.concat(calc.__c.getField(false,"DateTime").runMethod(true,"Date",(Object)(_ts)),RemoteObject.createImmutable("   "),calc.__c.getField(false,"DateTime").runMethod(true,"Time",(Object)(_ts)));Debug.locals.put("dt", _dt);Debug.locals.put("dt", _dt);
 BA.debugLineNum = 34;BA.debugLine="DateTime.SetTimeZone(0)												'Back to UTC t";
Debug.ShouldStop(2);
calc.__c.getField(false,"DateTime").runVoidMethod ("SetTimeZone",(Object)(BA.numberCast(double.class, 0)));
 BA.debugLineNum = 35;BA.debugLine="Return (dt)";
Debug.ShouldStop(4);
if (true) return (_dt);
 BA.debugLineNum = 36;BA.debugLine="End Sub";
Debug.ShouldStop(8);
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
calc._fx = RemoteObject.createNew ("anywheresoftware.b4j.objects.JFX");
 //BA.debugLineNum = 6;BA.debugLine="Private My_GMT_Offset As Int = -8												'PST";
calc._my_gmt_offset = BA.numberCast(int.class, -(double) (0 + 8));
 //BA.debugLineNum = 8;BA.debugLine="Type Order(Coinpair As String, side As String, id";
;
 //BA.debugLineNum = 9;BA.debugLine="Dim All_My_Orders_List As List";
calc._all_my_orders_list = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");
 //BA.debugLineNum = 10;BA.debugLine="Type AMT (trade_id As String, order_id As String,";
;
 //BA.debugLineNum = 11;BA.debugLine="Dim All_My_Trades_List As List";
calc._all_my_trades_list = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");
 //BA.debugLineNum = 12;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}