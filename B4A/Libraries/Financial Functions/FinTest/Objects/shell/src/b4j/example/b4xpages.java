
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

public class b4xpages implements IRemote{
	public static b4xpages mostCurrent;
	public static RemoteObject ba;
    public static boolean processGlobalsRun;
    public static RemoteObject myClass;
    public static RemoteObject remoteMe;
	public b4xpages() {
		mostCurrent = this;
	}
    public RemoteObject getRemoteMe() {
        return remoteMe;    
    }
    
public boolean isSingleton() {
		return true;
	}
    static {
		mostCurrent = new b4xpages();
		remoteMe = RemoteObject.declareNull("b4j.example.b4xpages");
        anywheresoftware.b4a.pc.RapidSub.moduleToObject.put(new B4XClass("b4xpages"), "b4j.example.b4xpages");
	}
    public static void main (String[] args) throws Exception {
		new RDebug(args[0], Integer.parseInt(args[1]), Integer.parseInt(args[2]), args[3]);
		RDebug.INSTANCE.waitForTask();

	}
    private static PCBA pcBA = new PCBA(null, b4xpages.class);
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
		pcBA = new PCBA(this, b4xpages.class);
        main_subs_0.initializeProcessGlobals();
		return pcBA;
	}
public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _mpm = RemoteObject.declareNull("Object");
public static RemoteObject _delegate = RemoteObject.declareNull("b4j.example.b4xpagesdelegator");
public static RemoteObject _globalcontext = RemoteObject.declareNull("Object");
public static b4j.example.main _main = null;
public static b4j.example.b4xcollections _b4xcollections = null;
  public Object[] GetGlobals() {
		return new Object[] {"B4XCollections",Debug.moduleToString(b4j.example.b4xcollections.class),"Delegate",b4xpages._delegate,"GlobalContext",b4xpages._globalcontext,"Main",Debug.moduleToString(b4j.example.main.class),"mPM",b4xpages._mpm};
}
}