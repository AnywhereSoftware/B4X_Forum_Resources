
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class copyonwritemap {
    public static RemoteObject myClass;
	public copyonwritemap() {
	}
    public static PCBA staticBA = new PCBA(null, copyonwritemap.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _internalmap = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
public static b4j.example.main _main = null;
public static b4j.example.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"InternalMap",_ref.getField(false, "_internalmap")};
}
}