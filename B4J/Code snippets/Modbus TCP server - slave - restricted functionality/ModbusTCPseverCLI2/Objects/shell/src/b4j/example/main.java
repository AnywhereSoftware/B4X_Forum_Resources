
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
public static RemoteObject _astreams = RemoteObject.declareNull("anywheresoftware.b4a.randomaccessfile.AsyncStreams");
public static RemoteObject _server = RemoteObject.declareNull("anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper");
public static RemoteObject _socket1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.SocketWrapper");
public static RemoteObject _slaveaddress = RemoteObject.createImmutable((byte)0);
public static RemoteObject _holdreg = null;
public static RemoteObject _rxtransident = null;
public static RemoteObject _rxprotocolident = null;
public static RemoteObject _rxlength = null;
public static RemoteObject _rxunitidentifier = RemoteObject.createImmutable((byte)0);
public static RemoteObject _rxfunctioncode = RemoteObject.createImmutable((byte)0);
public static RemoteObject _rxfirstaddresregister = null;
public static RemoteObject _rxrange = null;
public static RemoteObject _requestfirstaddresreg = RemoteObject.createImmutable((short)0);
public static RemoteObject _requestrangereg = RemoteObject.createImmutable((short)0);
  public Object[] GetGlobals() {
		return new Object[] {"AStreams",main._astreams,"HoldReg",main._holdreg,"RequestFirstAddresReg",main._requestfirstaddresreg,"RequestRangeReg",main._requestrangereg,"RxFirstAddresRegister",main._rxfirstaddresregister,"RxFunctionCode",main._rxfunctioncode,"RxLength",main._rxlength,"RxProtocolIdent",main._rxprotocolident,"RxRange",main._rxrange,"RxTransIdent",main._rxtransident,"RxUnitIdentifier",main._rxunitidentifier,"Server",main._server,"slaveAddress",main._slaveaddress,"Socket1",main._socket1};
}
}