
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class pybridgeworker {
    public static RemoteObject myClass;
	public pybridgeworker() {
	}
    public static PCBA staticBA = new PCBA(null, pybridgeworker.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _py = RemoteObject.declareNull("b4j.example.pybridge");
public static RemoteObject _ailogic = RemoteObject.declareNull("b4j.example.pywrapper");
public static b4j.example.main _main = null;
public static b4j.example.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"AILogic",_ref.getField(false, "_ailogic"),"py",_ref.getField(false, "_py")};
}
}