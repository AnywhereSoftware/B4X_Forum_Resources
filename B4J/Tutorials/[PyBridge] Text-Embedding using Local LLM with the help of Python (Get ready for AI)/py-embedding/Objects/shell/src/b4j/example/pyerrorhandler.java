
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class pyerrorhandler {
    public static RemoteObject myClass;
	public pyerrorhandler() {
	}
    public static PCBA staticBA = new PCBA(null, pyerrorhandler.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _ignoredclasses = RemoteObject.declareNull("b4j.example.b4xset");
public static RemoteObject _threadclass = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
public static RemoteObject _mutils = RemoteObject.declareNull("b4j.example.pyutils");
public static RemoteObject _baclass = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
public static RemoteObject _filescache = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
public static b4j.example.main _main = null;
public static b4j.example.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"BAClass",_ref.getField(false, "_baclass"),"FilesCache",_ref.getField(false, "_filescache"),"IgnoredClasses",_ref.getField(false, "_ignoredclasses"),"mUtils",_ref.getField(false, "_mutils"),"ThreadClass",_ref.getField(false, "_threadclass")};
}
}