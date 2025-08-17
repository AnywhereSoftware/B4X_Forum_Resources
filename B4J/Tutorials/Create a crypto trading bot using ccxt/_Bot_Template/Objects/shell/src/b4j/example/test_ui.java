
package b4j.example;

import java.io.IOException;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RDebug;
import anywheresoftware.b4a.pc.RemoteObject;
import anywheresoftware.b4a.pc.RDebug.IRemote;
import anywheresoftware.b4a.pc.Debug;
import anywheresoftware.b4a.pc.B4XTypes.B4XClass;
import anywheresoftware.b4a.pc.B4XTypes.DeviceClass;

public class test_ui implements IRemote{
	public static test_ui mostCurrent;
	public static RemoteObject ba;
    public static boolean processGlobalsRun;
    public static RemoteObject myClass;
    public static RemoteObject remoteMe;
	public test_ui() {
		mostCurrent = this;
	}
    public RemoteObject getRemoteMe() {
        return remoteMe;    
    }
    
public boolean isSingleton() {
		return true;
	}
    static {
		mostCurrent = new test_ui();
		remoteMe = RemoteObject.declareNull("b4j.example.test_ui");
        anywheresoftware.b4a.pc.RapidSub.moduleToObject.put(new B4XClass("test_ui"), "b4j.example.test_ui");
	}
    public static void main (String[] args) throws Exception {
		new RDebug(args[0], Integer.parseInt(args[1]), Integer.parseInt(args[2]), args[3]);
		RDebug.INSTANCE.waitForTask();

	}
    private static PCBA pcBA = new PCBA(null, test_ui.class);
	public static RemoteObject runMethod(boolean notUsed, String method, Object... args) throws Exception{
		return (RemoteObject) pcBA.raiseEvent(method.substring(1), args);
	}
    public static void runVoidMethod(String method, Object... args) throws Exception{
		runMethod(false, method, args);
	}
    public static RemoteObject getObject() {
		return myClass;
	 }
	public PCBA create(Object[] args) throws ClassNotFoundException{
		ba = (RemoteObject) args[1];
		pcBA = new PCBA(this, test_ui.class);
        main_subs_0.initializeProcessGlobals();
		return pcBA;
	}
public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _fx = RemoteObject.declareNull("anywheresoftware.b4j.objects.JFX");
public static RemoteObject _pane_api_call_buttons = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
public static RemoteObject _btn_reset = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
public static RemoteObject _txt_output = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextAreaWrapper");
public static RemoteObject _cmb_bot = RemoteObject.declareNull("anywheresoftware.b4j.objects.ComboBoxWrapper");
public static RemoteObject _cmb_scoin = RemoteObject.declareNull("anywheresoftware.b4j.objects.ComboBoxWrapper");
public static RemoteObject _cmb_coinpair = RemoteObject.declareNull("anywheresoftware.b4j.objects.ComboBoxWrapper");
public static RemoteObject _lbl_exchange = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
public static RemoteObject _lbl_open_orders = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
public static RemoteObject _xui = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");
public static RemoteObject _api_call_map = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
public static RemoteObject _btc_buy_price = RemoteObject.createImmutable(0);
public static RemoteObject _btc_buy_volume = RemoteObject.createImmutable(0);
public static RemoteObject _btc_buy_total = RemoteObject.createImmutable(0);
public static RemoteObject _btc_edit_buy_price = RemoteObject.createImmutable(0);
public static RemoteObject _btc_edit_buy_volume = RemoteObject.createImmutable(0);
public static RemoteObject _btc_edit_buy_total = RemoteObject.createImmutable(0);
public static RemoteObject _btc_sell_price = RemoteObject.createImmutable(0);
public static RemoteObject _btc_sell_volume = RemoteObject.createImmutable(0);
public static RemoteObject _btc_sell_total = RemoteObject.createImmutable(0);
public static RemoteObject _cssutils = RemoteObject.declareNull("b4j.example.cssutils");
public static b4j.example.main _main = null;
public static b4j.example.ccxt _ccxt = null;
public static b4j.example.calc _calc = null;
public static b4j.example.httputils2service _httputils2service = null;
  public Object[] GetGlobals() {
		return new Object[] {"API_Call_Map",test_ui._api_call_map,"btc_buy_price",test_ui._btc_buy_price,"btc_buy_total",test_ui._btc_buy_total,"btc_buy_volume",test_ui._btc_buy_volume,"btc_edit_buy_price",test_ui._btc_edit_buy_price,"btc_edit_buy_total",test_ui._btc_edit_buy_total,"btc_edit_buy_volume",test_ui._btc_edit_buy_volume,"btc_sell_price",test_ui._btc_sell_price,"btc_sell_total",test_ui._btc_sell_total,"btc_sell_volume",test_ui._btc_sell_volume,"btn_Reset",test_ui._btn_reset,"Calc",Debug.moduleToString(b4j.example.calc.class),"ccxt",Debug.moduleToString(b4j.example.ccxt.class),"cmb_Bot",test_ui._cmb_bot,"cmb_Coinpair",test_ui._cmb_coinpair,"cmb_Scoin",test_ui._cmb_scoin,"CSSUtils",test_ui._cssutils,"fx",test_ui._fx,"HttpUtils2Service",Debug.moduleToString(b4j.example.httputils2service.class),"lbl_Exchange",test_ui._lbl_exchange,"lbl_Open_Orders",test_ui._lbl_open_orders,"Main",Debug.moduleToString(b4j.example.main.class),"pane_API_call_buttons",test_ui._pane_api_call_buttons,"txt_Output",test_ui._txt_output,"xui",test_ui._xui};
}
}