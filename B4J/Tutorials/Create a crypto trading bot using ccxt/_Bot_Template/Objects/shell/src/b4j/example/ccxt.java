
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

public class ccxt implements IRemote{
	public static ccxt mostCurrent;
	public static RemoteObject ba;
    public static boolean processGlobalsRun;
    public static RemoteObject myClass;
    public static RemoteObject remoteMe;
	public ccxt() {
		mostCurrent = this;
	}
    public RemoteObject getRemoteMe() {
        return remoteMe;    
    }
    
public boolean isSingleton() {
		return true;
	}
    static {
		mostCurrent = new ccxt();
		remoteMe = RemoteObject.declareNull("b4j.example.ccxt");
        anywheresoftware.b4a.pc.RapidSub.moduleToObject.put(new B4XClass("ccxt"), "b4j.example.ccxt");
	}
    public static void main (String[] args) throws Exception {
		new RDebug(args[0], Integer.parseInt(args[1]), Integer.parseInt(args[2]), args[3]);
		RDebug.INSTANCE.waitForTask();

	}
    private static PCBA pcBA = new PCBA(null, ccxt.class);
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
		pcBA = new PCBA(this, ccxt.class);
        main_subs_0.initializeProcessGlobals();
		return pcBA;
	}
public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _fx = RemoteObject.declareNull("anywheresoftware.b4j.objects.JFX");
public static RemoteObject _php_port = RemoteObject.createImmutable(0);
public static RemoteObject _php_url = RemoteObject.createImmutable("");
public static RemoteObject _json = RemoteObject.declareNull("anywheresoftware.b4j.objects.collections.JSONParser");
public static RemoteObject _buy_orderbook_map = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
public static RemoteObject _sell_orderbook_map = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
public static RemoteObject _coinpair_list = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static RemoteObject _pcoin_list = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static RemoteObject _scoin_list = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static RemoteObject _ohlcv_timeframe_list = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static RemoteObject _canceled_order_id = RemoteObject.createImmutable("");
public static RemoteObject _exchange_info_map = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
public static RemoteObject _cssutils = RemoteObject.declareNull("b4j.example.cssutils");
public static b4j.example.main _main = null;
public static b4j.example.calc _calc = null;
public static b4j.example.test_ui _test_ui = null;
public static b4j.example.httputils2service _httputils2service = null;
  public Object[] GetGlobals() {
		return new Object[] {"Buy_Orderbook_Map",ccxt._buy_orderbook_map,"Calc",Debug.moduleToString(b4j.example.calc.class),"Canceled_Order_ID",ccxt._canceled_order_id,"Coinpair_List",ccxt._coinpair_list,"CSSUtils",ccxt._cssutils,"Exchange_Info_Map",ccxt._exchange_info_map,"fx",ccxt._fx,"HttpUtils2Service",Debug.moduleToString(b4j.example.httputils2service.class),"JSON",ccxt._json,"Main",Debug.moduleToString(b4j.example.main.class),"OHLCV_TimeFrame_List",ccxt._ohlcv_timeframe_list,"Pcoin_List",ccxt._pcoin_list,"PHP_Port",ccxt._php_port,"PHP_URL",ccxt._php_url,"Scoin_List",ccxt._scoin_list,"Sell_Orderbook_Map",ccxt._sell_orderbook_map,"test_ui",Debug.moduleToString(b4j.example.test_ui.class)};
}
}