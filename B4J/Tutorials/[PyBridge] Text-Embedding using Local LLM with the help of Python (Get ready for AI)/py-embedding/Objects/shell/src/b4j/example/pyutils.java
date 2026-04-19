
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class pyutils {
    public static RemoteObject myClass;
	public pyutils() {
	}
    public static PCBA staticBA = new PCBA(null, pyutils.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _task_type_run = RemoteObject.createImmutable(0);
public static RemoteObject _task_type_get = RemoteObject.createImmutable(0);
public static RemoteObject _task_type_run_async = RemoteObject.createImmutable(0);
public static RemoteObject _task_type_clean = RemoteObject.createImmutable(0);
public static RemoteObject _task_type_error = RemoteObject.createImmutable(0);
public static RemoteObject _task_type_event = RemoteObject.createImmutable(0);
public static RemoteObject _task_type_ping = RemoteObject.createImmutable(0);
public static RemoteObject _task_type_flush = RemoteObject.createImmutable(0);
public static RemoteObject _pythonbridgecodeversion = RemoteObject.createImmutable("");
public static RemoteObject _pyoutprefix = RemoteObject.createImmutable("");
public static RemoteObject _pyerrprefix = RemoteObject.createImmutable("");
public static RemoteObject _b4jprefix = RemoteObject.createImmutable("");
public static RemoteObject _evalglobals = RemoteObject.declareNull("b4j.example.pywrapper");
public static RemoteObject _importlib = RemoteObject.declareNull("b4j.example.pywrapper");
public static RemoteObject _mbridge = RemoteObject.declareNull("b4j.example.pybridge");
public static RemoteObject _taskidcounter = RemoteObject.createImmutable(0);
public static RemoteObject _pyobjectcounter = RemoteObject.createImmutable(0);
public static RemoteObject _cleanerclass = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
public static RemoteObject _cleanerindex = RemoteObject.createImmutable(0);
public static RemoteObject _comm = RemoteObject.declareNull("b4j.example.pycomm");
public static RemoteObject _moptions = RemoteObject.declareNull("b4j.example.pybridge._pyoptions");
public static RemoteObject _cleaner = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
public static RemoteObject _registeredmembers = RemoteObject.declareNull("b4j.example.b4xset");
public static RemoteObject _epsilon = RemoteObject.createImmutable(0);
public static RemoteObject _keysthatneedtoberegistered = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static RemoteObject _objectsthatneedtoberegistered = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static RemoteObject _system = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
public static RemoteObject _memoryslots = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
public static RemoteObject _lastmemorysize = RemoteObject.createImmutable(0);
public static RemoteObject _memory_increase_threshold = RemoteObject.createImmutable(0);
public static RemoteObject _packagename = RemoteObject.createImmutable("");
public static RemoteObject _io = RemoteObject.declareNull("b4j.example.pywrapper");
public static b4j.example.main _main = null;
public static b4j.example.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"B4JPrefix",_ref.getField(false, "_b4jprefix"),"cleaner",_ref.getField(false, "_cleaner"),"CleanerClass",_ref.getField(false, "_cleanerclass"),"CleanerIndex",_ref.getField(false, "_cleanerindex"),"Comm",_ref.getField(false, "_comm"),"Epsilon",_ref.getField(false, "_epsilon"),"EvalGlobals",_ref.getField(false, "_evalglobals"),"ImportLib",_ref.getField(false, "_importlib"),"IO",_ref.getField(false, "_io"),"KeysThatNeedToBeRegistered",_ref.getField(false, "_keysthatneedtoberegistered"),"LastMemorySize",_ref.getField(false, "_lastmemorysize"),"mBridge",_ref.getField(false, "_mbridge"),"MEMORY_INCREASE_THRESHOLD",_ref.getField(false, "_memory_increase_threshold"),"MemorySlots",_ref.getField(false, "_memoryslots"),"mOptions",_ref.getField(false, "_moptions"),"ObjectsThatNeedToBeRegistered",_ref.getField(false, "_objectsthatneedtoberegistered"),"PackageName",_ref.getField(false, "_packagename"),"PyErrPrefix",_ref.getField(false, "_pyerrprefix"),"PyObjectCounter",_ref.getField(false, "_pyobjectcounter"),"PyOutPrefix",_ref.getField(false, "_pyoutprefix"),"PythonBridgeCodeVersion",_ref.getField(false, "_pythonbridgecodeversion"),"RegisteredMembers",_ref.getField(false, "_registeredmembers"),"System",_ref.getField(false, "_system"),"TASK_TYPE_CLEAN",_ref.getField(false, "_task_type_clean"),"TASK_TYPE_ERROR",_ref.getField(false, "_task_type_error"),"TASK_TYPE_EVENT",_ref.getField(false, "_task_type_event"),"TASK_TYPE_FLUSH",_ref.getField(false, "_task_type_flush"),"TASK_TYPE_GET",_ref.getField(false, "_task_type_get"),"TASK_TYPE_PING",_ref.getField(false, "_task_type_ping"),"TASK_TYPE_RUN",_ref.getField(false, "_task_type_run"),"TASK_TYPE_RUN_ASYNC",_ref.getField(false, "_task_type_run_async"),"TaskIdCounter",_ref.getField(false, "_taskidcounter")};
}
}