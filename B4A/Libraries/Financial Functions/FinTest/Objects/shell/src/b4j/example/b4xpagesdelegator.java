
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class b4xpagesdelegator {
    public static RemoteObject myClass;
	public b4xpagesdelegator() {
	}
    public static PCBA staticBA = new PCBA(null, b4xpagesdelegator.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static b4j.example.main _main = null;
public static b4j.example.b4xpages _b4xpages = null;
public static b4j.example.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {};
}
}