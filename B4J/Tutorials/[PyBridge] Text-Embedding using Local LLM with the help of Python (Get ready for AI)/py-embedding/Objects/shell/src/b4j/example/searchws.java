
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class searchws {
    public static RemoteObject myClass;
	public searchws() {
	}
    public static PCBA staticBA = new PCBA(null, searchws.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _ws = RemoteObject.declareNull("anywheresoftware.b4j.object.WebSocket");
public static RemoteObject _isclientconnected = RemoteObject.createImmutable(false);
public static b4j.example.main _main = null;
public static b4j.example.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"IsClientConnected",_ref.getField(false, "_isclientconnected"),"ws",_ref.getField(false, "_ws")};
}
}