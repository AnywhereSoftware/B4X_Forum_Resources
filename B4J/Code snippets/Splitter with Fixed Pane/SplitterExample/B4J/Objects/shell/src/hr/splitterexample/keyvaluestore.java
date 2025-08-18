
package hr.splitterexample;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class keyvaluestore {
    public static RemoteObject myClass;
	public keyvaluestore() {
	}
    public static PCBA staticBA = new PCBA(null, keyvaluestore.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _sql1 = RemoteObject.declareNull("anywheresoftware.b4j.objects.SQL");
public static RemoteObject _ser = RemoteObject.declareNull("anywheresoftware.b4a.randomaccessfile.B4XSerializator");
public static hr.splitterexample.main _main = null;
public static hr.splitterexample.b4xpages _b4xpages = null;
public static hr.splitterexample.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"ser",_ref.getField(false, "_ser"),"sql1",_ref.getField(false, "_sql1")};
}
}