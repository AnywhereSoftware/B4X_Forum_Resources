
package hr.splitterexample;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class b4xset {
    public static RemoteObject myClass;
	public b4xset() {
	}
    public static PCBA staticBA = new PCBA(null, b4xset.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _map = RemoteObject.declareNull("hr.splitterexample.b4xorderedmap");
public static hr.splitterexample.main _main = null;
public static hr.splitterexample.b4xpages _b4xpages = null;
public static hr.splitterexample.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"map",_ref.getField(false, "_map")};
}
}