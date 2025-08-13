
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class handlerfeatures {
    public static RemoteObject myClass;
	public handlerfeatures() {
	}
    public static PCBA staticBA = new PCBA(null, handlerfeatures.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static b4j.example.main _main = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {};
}
}