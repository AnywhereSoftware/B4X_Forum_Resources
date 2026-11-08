
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class pybridge {
    public static RemoteObject myClass;
	public pybridge() {
	}
    public static PCBA staticBA = new PCBA(null, pybridge.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _comm = RemoteObject.declareNull("b4j.example.pycomm");
public static RemoteObject _mcallback = RemoteObject.declareNull("Object");
public static RemoteObject _meventname = RemoteObject.createImmutable("");
public static RemoteObject _utils = RemoteObject.declareNull("b4j.example.pyutils");
public static RemoteObject _builtins = RemoteObject.declareNull("b4j.example.pywrapper");
public static RemoteObject _bridge = RemoteObject.declareNull("b4j.example.pywrapper");
public static RemoteObject _itertools = RemoteObject.declareNull("b4j.example.pywrapper");
public static RemoteObject _sys = RemoteObject.declareNull("b4j.example.pywrapper");
public static RemoteObject _shl = RemoteObject.declareNull("anywheresoftware.b4j.objects.Shell");
public static RemoteObject _moptions = RemoteObject.declareNull("b4j.example.pybridge._pyoptions");
public static RemoteObject _shlreadloopindex = RemoteObject.createImmutable(0);
public static RemoteObject _errorhandler = RemoteObject.declareNull("b4j.example.pyerrorhandler");
public static RemoteObject _pylastexception = RemoteObject.createImmutable("");
public static RemoteObject _eventmapper = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
public static b4j.example.main _main = null;
public static b4j.example.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"Bridge",_ref.getField(false, "_bridge"),"Builtins",_ref.getField(false, "_builtins"),"comm",_ref.getField(false, "_comm"),"ErrorHandler",_ref.getField(false, "_errorhandler"),"EventMapper",_ref.getField(false, "_eventmapper"),"Itertools",_ref.getField(false, "_itertools"),"mCallback",_ref.getField(false, "_mcallback"),"mEventName",_ref.getField(false, "_meventname"),"mOptions",_ref.getField(false, "_moptions"),"PyLastException",_ref.getField(false, "_pylastexception"),"Shl",_ref.getField(false, "_shl"),"ShlReadLoopIndex",_ref.getField(false, "_shlreadloopindex"),"Sys",_ref.getField(false, "_sys"),"Utils",_ref.getField(false, "_utils")};
}
}