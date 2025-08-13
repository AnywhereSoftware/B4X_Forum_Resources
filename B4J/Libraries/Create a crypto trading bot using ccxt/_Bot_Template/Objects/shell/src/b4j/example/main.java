
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

public class main implements IRemote{
	public static main mostCurrent;
	public static RemoteObject ba;
    public static boolean processGlobalsRun;
    public static RemoteObject myClass;
    public static RemoteObject remoteMe;
	public main() {
		mostCurrent = this;
	}
    public RemoteObject getRemoteMe() {
        return remoteMe;    
    }
    
public boolean isSingleton() {
		return true;
	}
    static {
		mostCurrent = new main();
		remoteMe = RemoteObject.declareNull("b4j.example.main");
        anywheresoftware.b4a.pc.RapidSub.moduleToObject.put(new B4XClass("main"), "b4j.example.main");
	}
    public static void main (String[] args) throws Exception {
		new RDebug(args[0], Integer.parseInt(args[1]), Integer.parseInt(args[2]), args[3]);
		RDebug.INSTANCE.waitForTask();

	}
    private static PCBA pcBA = new PCBA(null, main.class);
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
		pcBA = new PCBA(this, main.class);
        main_subs_0.initializeProcessGlobals();
		return pcBA;
	}
public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _fx = RemoteObject.declareNull("anywheresoftware.b4j.objects.JFX");
public static RemoteObject _mainform = RemoteObject.declareNull("anywheresoftware.b4j.objects.Form");
public static RemoteObject _bot_list = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static RemoteObject _selected_bot = RemoteObject.declareNull("b4j.example.main._trading_bot");
public static RemoteObject _selected_scoin = RemoteObject.createImmutable("");
public static RemoteObject _selected_coinpair = RemoteObject.createImmutable("");
public static RemoteObject _bot_timer = RemoteObject.declareNull("anywheresoftware.b4a.objects.Timer");
public static RemoteObject _cssutils = RemoteObject.declareNull("b4j.example.cssutils");
public static b4j.example.ccxt _ccxt = null;
public static b4j.example.calc _calc = null;
public static b4j.example.test_ui _test_ui = null;
public static b4j.example.httputils2service _httputils2service = null;
  public Object[] GetGlobals() {
		return new Object[] {"Bot_List",main._bot_list,"Bot_Timer",main._bot_timer,"Calc",Debug.moduleToString(b4j.example.calc.class),"ccxt",Debug.moduleToString(b4j.example.ccxt.class),"CSSUtils",main._cssutils,"fx",main._fx,"HttpUtils2Service",Debug.moduleToString(b4j.example.httputils2service.class),"MainForm",main._mainform,"Selected_Bot",main._selected_bot,"Selected_Coinpair",main._selected_coinpair,"Selected_Scoin",main._selected_scoin,"test_ui",Debug.moduleToString(b4j.example.test_ui.class)};
}
}