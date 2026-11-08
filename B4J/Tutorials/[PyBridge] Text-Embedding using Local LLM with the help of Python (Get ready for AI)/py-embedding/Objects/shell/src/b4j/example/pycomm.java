
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class pycomm {
    public static RemoteObject myClass;
	public pycomm() {
	}
    public static PCBA staticBA = new PCBA(null, pycomm.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _srvr = RemoteObject.declareNull("anywheresoftware.b4a.objects.SocketWrapper.ServerSocketWrapper");
public static RemoteObject _state_disconnected = RemoteObject.createImmutable(0);
public static RemoteObject _state_connected = RemoteObject.createImmutable(0);
public static RemoteObject _state_waiting_for_connection = RemoteObject.createImmutable(0);
public static RemoteObject _state = RemoteObject.createImmutable(0);
public static RemoteObject _port = RemoteObject.createImmutable(0);
public static RemoteObject _mbridge = RemoteObject.declareNull("b4j.example.pybridge");
public static RemoteObject _astream = RemoteObject.declareNull("anywheresoftware.b4a.randomaccessfile.AsyncStreams");
public static RemoteObject _ser = RemoteObject.declareNull("anywheresoftware.b4a.randomaccessfile.B4XSerializator");
public static RemoteObject _waitingtasks = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
public static RemoteObject _jme = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
public static RemoteObject _bufferedtasks = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static b4j.example.main _main = null;
public static b4j.example.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"astream",_ref.getField(false, "_astream"),"BufferedTasks",_ref.getField(false, "_bufferedtasks"),"jME",_ref.getField(false, "_jme"),"mBridge",_ref.getField(false, "_mbridge"),"Port",_ref.getField(false, "_port"),"ser",_ref.getField(false, "_ser"),"srvr",_ref.getField(false, "_srvr"),"State",_ref.getField(false, "_state"),"STATE_CONNECTED",_ref.getField(false, "_state_connected"),"STATE_DISCONNECTED",_ref.getField(false, "_state_disconnected"),"STATE_WAITING_FOR_CONNECTION",_ref.getField(false, "_state_waiting_for_connection"),"WaitingTasks",_ref.getField(false, "_waitingtasks")};
}
}