
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class pywrapper {
    public static RemoteObject myClass;
	public pywrapper() {
	}
    public static PCBA staticBA = new PCBA(null, pywrapper.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _internalkey = RemoteObject.declareNull("b4j.example.pybridge._pyobject");
public static RemoteObject _mbridge = RemoteObject.declareNull("b4j.example.pybridge");
public static RemoteObject _mfetched = RemoteObject.createImmutable(false);
public static RemoteObject _merror = RemoteObject.createImmutable(false);
public static RemoteObject _mvalue = RemoteObject.declareNull("Object");
public static RemoteObject _lastargs = RemoteObject.declareNull("b4j.example.pybridge._internalpymethodargs");
public static b4j.example.main _main = null;
public static b4j.example.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"InternalKey",_ref.getField(false, "_internalkey"),"LastArgs",_ref.getField(false, "_lastargs"),"mBridge",_ref.getField(false, "_mbridge"),"mError",_ref.getField(false, "_merror"),"mFetched",_ref.getField(false, "_mfetched"),"mValue",_ref.getField(false, "_mvalue")};
}
}