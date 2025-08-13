
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

public class calc implements IRemote{
	public static calc mostCurrent;
	public static RemoteObject ba;
    public static boolean processGlobalsRun;
    public static RemoteObject myClass;
    public static RemoteObject remoteMe;
	public calc() {
		mostCurrent = this;
	}
    public RemoteObject getRemoteMe() {
        return remoteMe;    
    }
    
public boolean isSingleton() {
		return true;
	}
    static {
		mostCurrent = new calc();
		remoteMe = RemoteObject.declareNull("b4j.example.calc");
        anywheresoftware.b4a.pc.RapidSub.moduleToObject.put(new B4XClass("calc"), "b4j.example.calc");
	}
    public static void main (String[] args) throws Exception {
		new RDebug(args[0], Integer.parseInt(args[1]), Integer.parseInt(args[2]), args[3]);
		RDebug.INSTANCE.waitForTask();

	}
    private static PCBA pcBA = new PCBA(null, calc.class);
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
		pcBA = new PCBA(this, calc.class);
        main_subs_0.initializeProcessGlobals();
		return pcBA;
	}
public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _fx = RemoteObject.declareNull("anywheresoftware.b4j.objects.JFX");
public static RemoteObject _my_gmt_offset = RemoteObject.createImmutable(0);
public static RemoteObject _all_my_orders_list = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static RemoteObject _all_my_trades_list = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static RemoteObject _cssutils = RemoteObject.declareNull("b4j.example.cssutils");
public static b4j.example.main _main = null;
public static b4j.example.ccxt _ccxt = null;
public static b4j.example.test_ui _test_ui = null;
public static b4j.example.httputils2service _httputils2service = null;
  public Object[] GetGlobals() {
		return new Object[] {"All_My_Orders_List",calc._all_my_orders_list,"All_My_Trades_List",calc._all_my_trades_list,"ccxt",Debug.moduleToString(b4j.example.ccxt.class),"CSSUtils",calc._cssutils,"fx",calc._fx,"HttpUtils2Service",Debug.moduleToString(b4j.example.httputils2service.class),"Main",Debug.moduleToString(b4j.example.main.class),"My_GMT_Offset",calc._my_gmt_offset,"test_ui",Debug.moduleToString(b4j.example.test_ui.class)};
}
}