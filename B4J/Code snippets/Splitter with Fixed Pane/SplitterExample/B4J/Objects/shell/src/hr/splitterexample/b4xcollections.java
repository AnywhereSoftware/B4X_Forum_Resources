
package hr.splitterexample;

import java.io.IOException;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RDebug;
import anywheresoftware.b4a.pc.RemoteObject;
import anywheresoftware.b4a.pc.RDebug.IRemote;
import anywheresoftware.b4a.pc.Debug;
import anywheresoftware.b4a.pc.B4XTypes.B4XClass;
import anywheresoftware.b4a.pc.B4XTypes.DeviceClass;

public class b4xcollections implements IRemote{
	public static b4xcollections mostCurrent;
	public static RemoteObject ba;
    public static boolean processGlobalsRun;
    public static RemoteObject myClass;
    public static RemoteObject remoteMe;
	public b4xcollections() {
		mostCurrent = this;
	}
    public RemoteObject getRemoteMe() {
        return remoteMe;    
    }
    
public boolean isSingleton() {
		return true;
	}
    static {
		mostCurrent = new b4xcollections();
		remoteMe = RemoteObject.declareNull("hr.splitterexample.b4xcollections");
        anywheresoftware.b4a.pc.RapidSub.moduleToObject.put(new B4XClass("b4xcollections"), "hr.splitterexample.b4xcollections");
	}
    public static void main (String[] args) throws Exception {
		new RDebug(args[0], Integer.parseInt(args[1]), Integer.parseInt(args[2]), args[3]);
		RDebug.INSTANCE.waitForTask();

	}
    private static PCBA pcBA = new PCBA(null, b4xcollections.class);
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
		pcBA = new PCBA(this, b4xcollections.class);
        main_subs_0.initializeProcessGlobals();
		return pcBA;
	}
public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static hr.splitterexample.main _main = null;
public static hr.splitterexample.b4xpages _b4xpages = null;
  public Object[] GetGlobals() {
		return new Object[] {"B4XPages",Debug.moduleToString(hr.splitterexample.b4xpages.class),"Main",Debug.moduleToString(hr.splitterexample.main.class)};
}
}