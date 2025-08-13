package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;

public class calc extends Object{
public static calc mostCurrent = new calc();

public static BA ba;
static {
		ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.calc", null);
		ba.loadHtSubs(calc.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			
			ba.raiseEvent2(null, true, "SHELL", false);
			ba.raiseEvent2(null, true, "CREATE", true, "b4j.example.calc", ba);
		}
	}
    public static Class<?> getObject() {
		return calc.class;
	}

 
public static class _order{
public boolean IsInitialized;
public String Coinpair;
public String side;
public String id;
public long TS;
public double Price;
public double Volume;
public double Total;
public double filled;
public double remaining;
public String Order_Type;
public String Status;
public void Initialize() {
IsInitialized = true;
Coinpair = "";
side = "";
id = "";
TS = 0L;
Price = 0;
Volume = 0;
Total = 0;
filled = 0;
remaining = 0;
Order_Type = "";
Status = "";
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public static class _amt{
public boolean IsInitialized;
public String trade_id;
public String order_id;
public String Coinpair;
public long TS;
public String Side;
public double Price;
public double Volume;
public double Total;
public double Fee;
public String Fee_Currency;
public String trade_type;
public void Initialize() {
IsInitialized = true;
trade_id = "";
order_id = "";
Coinpair = "";
TS = 0L;
Side = "";
Price = 0;
Volume = 0;
Total = 0;
Fee = 0;
Fee_Currency = "";
trade_type = "";
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4j.objects.JFX _fx = null;
public static int _my_gmt_offset = 0;
public static anywheresoftware.b4a.objects.collections.List _all_my_orders_list = null;
public static anywheresoftware.b4a.objects.collections.List _all_my_trades_list = null;
public static b4j.example.cssutils _cssutils = null;
public static b4j.example.main _main = null;
public static b4j.example.ccxt _ccxt = null;
public static b4j.example.test_ui _test_ui = null;
public static b4j.example.httputils2service _httputils2service = null;
public static String  _my_date_time(long _ts) throws Exception{
RDebugUtils.currentModule="calc";
if (Debug.shouldDelegate(ba, "my_date_time", false))
	 {return ((String) Debug.delegate(ba, "my_date_time", new Object[] {_ts}));}
String _dt = "";
RDebugUtils.currentLine=4325376;
 //BA.debugLineNum = 4325376;BA.debugLine="Sub My_Date_Time(TS As Long) As String";
RDebugUtils.currentLine=4325377;
 //BA.debugLineNum = 4325377;BA.debugLine="DateTime.SetTimeZone(My_GMT_Offset)";
anywheresoftware.b4a.keywords.Common.DateTime.SetTimeZone(_my_gmt_offset);
RDebugUtils.currentLine=4325378;
 //BA.debugLineNum = 4325378;BA.debugLine="Dim dt As String = DateTime.Date(TS) & \"   \" & Da";
_dt = anywheresoftware.b4a.keywords.Common.DateTime.Date(_ts)+"   "+anywheresoftware.b4a.keywords.Common.DateTime.Time(_ts);
RDebugUtils.currentLine=4325379;
 //BA.debugLineNum = 4325379;BA.debugLine="DateTime.SetTimeZone(0)												'Back to UTC t";
anywheresoftware.b4a.keywords.Common.DateTime.SetTimeZone(0);
RDebugUtils.currentLine=4325380;
 //BA.debugLineNum = 4325380;BA.debugLine="Return (dt)";
if (true) return (_dt);
RDebugUtils.currentLine=4325381;
 //BA.debugLineNum = 4325381;BA.debugLine="End Sub";
return "";
}
public static String  _get_scoin(String _coinpair) throws Exception{
RDebugUtils.currentModule="calc";
if (Debug.shouldDelegate(ba, "get_scoin", false))
	 {return ((String) Debug.delegate(ba, "get_scoin", new Object[] {_coinpair}));}
String _scoin = "";
int _index = 0;
RDebugUtils.currentLine=4259840;
 //BA.debugLineNum = 4259840;BA.debugLine="Sub Get_Scoin (coinpair As String) As String";
RDebugUtils.currentLine=4259841;
 //BA.debugLineNum = 4259841;BA.debugLine="Dim scoin As String";
_scoin = "";
RDebugUtils.currentLine=4259842;
 //BA.debugLineNum = 4259842;BA.debugLine="Dim index As Int = coinpair.IndexOf(\"/\") + 1";
_index = (int) (_coinpair.indexOf("/")+1);
RDebugUtils.currentLine=4259843;
 //BA.debugLineNum = 4259843;BA.debugLine="scoin = coinpair.SubString(index)";
_scoin = _coinpair.substring(_index);
RDebugUtils.currentLine=4259844;
 //BA.debugLineNum = 4259844;BA.debugLine="Return scoin";
if (true) return _scoin;
RDebugUtils.currentLine=4259845;
 //BA.debugLineNum = 4259845;BA.debugLine="End Sub";
return "";
}
public static String  _get_pcoin(String _coinpair) throws Exception{
RDebugUtils.currentModule="calc";
if (Debug.shouldDelegate(ba, "get_pcoin", false))
	 {return ((String) Debug.delegate(ba, "get_pcoin", new Object[] {_coinpair}));}
String _pcoin = "";
int _index = 0;
RDebugUtils.currentLine=4194304;
 //BA.debugLineNum = 4194304;BA.debugLine="Sub Get_Pcoin (coinpair As String) As String";
RDebugUtils.currentLine=4194305;
 //BA.debugLineNum = 4194305;BA.debugLine="Dim pcoin As String";
_pcoin = "";
RDebugUtils.currentLine=4194306;
 //BA.debugLineNum = 4194306;BA.debugLine="Dim index As Int = coinpair.IndexOf(\"/\")";
_index = _coinpair.indexOf("/");
RDebugUtils.currentLine=4194307;
 //BA.debugLineNum = 4194307;BA.debugLine="pcoin = coinpair.SubString2(0, index)";
_pcoin = _coinpair.substring((int) (0),_index);
RDebugUtils.currentLine=4194308;
 //BA.debugLineNum = 4194308;BA.debugLine="Return pcoin";
if (true) return _pcoin;
RDebugUtils.currentLine=4194309;
 //BA.debugLineNum = 4194309;BA.debugLine="End Sub";
return "";
}
}