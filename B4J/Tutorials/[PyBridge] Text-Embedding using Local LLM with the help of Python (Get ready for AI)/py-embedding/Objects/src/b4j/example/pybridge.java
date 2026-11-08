package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class pybridge extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.pybridge", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.pybridge.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 
    public void  innerInitializeHelper(anywheresoftware.b4a.BA _ba) throws Exception{
        innerInitialize(_ba);
    }
    public Object callSub(String sub, Object sender, Object[] args) throws Exception {
        return BA.SubDelegator.SubNotFound;
    }
public static class _pyobject{
public boolean IsInitialized;
public int Key;
public void Initialize() {
IsInitialized = true;
Key = 0;
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public static class _pytask{
public boolean IsInitialized;
public int TaskId;
public int TaskType;
public anywheresoftware.b4a.objects.collections.List Extra;
public void Initialize() {
IsInitialized = true;
TaskId = 0;
TaskType = 0;
Extra = new anywheresoftware.b4a.objects.collections.List();
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public static class _internalpytaskasyncresult{
public boolean IsInitialized;
public b4j.example.pybridge._pyobject PyObject;
public Object Value;
public boolean Error;
public void Initialize() {
IsInitialized = true;
PyObject = new b4j.example.pybridge._pyobject();
Value = new Object();
Error = false;
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public static class _pyoptions{
public boolean IsInitialized;
public String PythonExecutable;
public int LocalPort;
public String PyBridgePath;
public int PyOutColor;
public int PyErrColor;
public int B4JColor;
public boolean ForceCopyBridgeSrc;
public int WatchDogSeconds;
public String PyCacheFolder;
public anywheresoftware.b4a.objects.collections.Map EnvironmentVars;
public boolean TrackLineNumbers;
public String PythonPath;
public void Initialize() {
IsInitialized = true;
PythonExecutable = "";
LocalPort = 0;
PyBridgePath = "";
PyOutColor = 0;
PyErrColor = 0;
B4JColor = 0;
ForceCopyBridgeSrc = false;
WatchDogSeconds = 0;
PyCacheFolder = "";
EnvironmentVars = new anywheresoftware.b4a.objects.collections.Map();
TrackLineNumbers = false;
PythonPath = "";
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public static class _internalpymethodargs{
public boolean IsInitialized;
public anywheresoftware.b4a.objects.collections.List Args;
public anywheresoftware.b4a.objects.collections.Map KWArgs;
public b4j.example.pybridge._pytask Task;
public void Initialize() {
IsInitialized = true;
Args = new anywheresoftware.b4a.objects.collections.List();
KWArgs = new anywheresoftware.b4a.objects.collections.Map();
Task = new b4j.example.pybridge._pytask();
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public anywheresoftware.b4a.keywords.Common __c = null;
public b4j.example.pycomm _comm = null;
public Object _mcallback = null;
public String _meventname = "";
public b4j.example.pyutils _utils = null;
public b4j.example.pywrapper _builtins = null;
public b4j.example.pywrapper _bridge = null;
public b4j.example.pywrapper _itertools = null;
public b4j.example.pywrapper _sys = null;
public anywheresoftware.b4j.objects.Shell _shl = null;
public b4j.example.pybridge._pyoptions _moptions = null;
public int _shlreadloopindex = 0;
public b4j.example.pyerrorhandler _errorhandler = null;
public String _pylastexception = "";
public anywheresoftware.b4a.objects.collections.Map _eventmapper = null;
public b4j.example.main _main = null;
public b4j.example.b4xcollections _b4xcollections = null;
public String  _initialize(b4j.example.pybridge __ref,anywheresoftware.b4a.BA _ba,Object _callback,String _eventname) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "initialize", true))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba,_callback,_eventname}));}
RDebugUtils.currentLine=720896;
 //BA.debugLineNum = 720896;BA.debugLine="Public Sub Initialize (Callback As Object, EventNa";
RDebugUtils.currentLine=720897;
 //BA.debugLineNum = 720897;BA.debugLine="mCallback = Callback";
__ref._mcallback /*Object*/  = _callback;
RDebugUtils.currentLine=720898;
 //BA.debugLineNum = 720898;BA.debugLine="mEventName = EventName";
__ref._meventname /*String*/  = _eventname;
RDebugUtils.currentLine=720899;
 //BA.debugLineNum = 720899;BA.debugLine="mOptions.Initialize";
__ref._moptions /*b4j.example.pybridge._pyoptions*/ .Initialize();
RDebugUtils.currentLine=720900;
 //BA.debugLineNum = 720900;BA.debugLine="ErrorHandler.Initialize(Utils)";
__ref._errorhandler /*b4j.example.pyerrorhandler*/ ._initialize /*String*/ (null,ba,__ref._utils /*b4j.example.pyutils*/ );
RDebugUtils.currentLine=720901;
 //BA.debugLineNum = 720901;BA.debugLine="Utils.Initialize(Me, comm)";
__ref._utils /*b4j.example.pyutils*/ ._initialize /*String*/ (null,ba,(b4j.example.pybridge)(this),__ref._comm /*b4j.example.pycomm*/ );
RDebugUtils.currentLine=720902;
 //BA.debugLineNum = 720902;BA.debugLine="EventMapper.Initialize";
__ref._eventmapper /*anywheresoftware.b4a.objects.collections.Map*/ .Initialize();
RDebugUtils.currentLine=720903;
 //BA.debugLineNum = 720903;BA.debugLine="End Sub";
return "";
}
public b4j.example.pybridge._pyoptions  _createoptions(b4j.example.pybridge __ref,String _pythonexecutable) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "createoptions", true))
	 {return ((b4j.example.pybridge._pyoptions) Debug.delegate(ba, "createoptions", new Object[] {_pythonexecutable}));}
b4j.example.pybridge._pyoptions _opt = null;
anywheresoftware.b4j.object.JavaObject _jo = null;
anywheresoftware.b4a.objects.collections.Map _allenvvars = null;
String _key = "";
RDebugUtils.currentLine=1048576;
 //BA.debugLineNum = 1048576;BA.debugLine="Public Sub CreateOptions (PythonExecutable As Stri";
RDebugUtils.currentLine=1048577;
 //BA.debugLineNum = 1048577;BA.debugLine="Dim opt As PyOptions";
_opt = new b4j.example.pybridge._pyoptions();
RDebugUtils.currentLine=1048578;
 //BA.debugLineNum = 1048578;BA.debugLine="opt.Initialize";
_opt.Initialize();
RDebugUtils.currentLine=1048579;
 //BA.debugLineNum = 1048579;BA.debugLine="opt.PythonExecutable = PythonExecutable";
_opt.PythonExecutable /*String*/  = _pythonexecutable;
RDebugUtils.currentLine=1048580;
 //BA.debugLineNum = 1048580;BA.debugLine="opt.PyBridgePath = File.Combine(File.DirData(\"pyb";
_opt.PyBridgePath /*String*/  = __c.File.Combine(__c.File.DirData("pybridge"),("b4x_bridge_"+__c.SmartStringFormatter("",(Object)(__ref._utils /*b4j.example.pyutils*/ ._pythonbridgecodeversion /*String*/ ))+".zip"));
RDebugUtils.currentLine=1048581;
 //BA.debugLineNum = 1048581;BA.debugLine="opt.B4JColor = 0xFF727272";
_opt.B4JColor /*int*/  = ((int)0xff727272);
RDebugUtils.currentLine=1048582;
 //BA.debugLineNum = 1048582;BA.debugLine="opt.PyErrColor = 0xFFF74479";
_opt.PyErrColor /*int*/  = ((int)0xfff74479);
RDebugUtils.currentLine=1048583;
 //BA.debugLineNum = 1048583;BA.debugLine="opt.PyOutColor = 0xFF446EF7";
_opt.PyOutColor /*int*/  = ((int)0xff446ef7);
RDebugUtils.currentLine=1048584;
 //BA.debugLineNum = 1048584;BA.debugLine="opt.WatchDogSeconds = 30";
_opt.WatchDogSeconds /*int*/  = (int) (30);
RDebugUtils.currentLine=1048585;
 //BA.debugLineNum = 1048585;BA.debugLine="opt.PyCacheFolder = File.DirData(\"pybridge\")";
_opt.PyCacheFolder /*String*/  = __c.File.DirData("pybridge");
RDebugUtils.currentLine=1048586;
 //BA.debugLineNum = 1048586;BA.debugLine="opt.EnvironmentVars =  CreateMap(\"PYTHONUTF8\": 1)";
_opt.EnvironmentVars /*anywheresoftware.b4a.objects.collections.Map*/  = __c.createMap(new Object[] {(Object)("PYTHONUTF8"),(Object)(1)});
RDebugUtils.currentLine=1048587;
 //BA.debugLineNum = 1048587;BA.debugLine="Dim jo As JavaObject";
_jo = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=1048588;
 //BA.debugLineNum = 1048588;BA.debugLine="jo.InitializeStatic(\"java.lang.System\")";
_jo.InitializeStatic("java.lang.System");
RDebugUtils.currentLine=1048589;
 //BA.debugLineNum = 1048589;BA.debugLine="Dim AllEnvVars As Map = jo.RunMethod(\"getenv\", Nu";
_allenvvars = new anywheresoftware.b4a.objects.collections.Map();
_allenvvars = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_jo.RunMethod("getenv",(Object[])(__c.Null))));
RDebugUtils.currentLine=1048590;
 //BA.debugLineNum = 1048590;BA.debugLine="For Each key As String In AllEnvVars.Keys";
{
final anywheresoftware.b4a.BA.IterableList group14 = _allenvvars.Keys();
final int groupLen14 = group14.getSize()
;int index14 = 0;
;
for (; index14 < groupLen14;index14++){
_key = BA.ObjectToString(group14.Get(index14));
RDebugUtils.currentLine=1048591;
 //BA.debugLineNum = 1048591;BA.debugLine="opt.EnvironmentVars.Put(key, AllEnvVars.Get(key)";
_opt.EnvironmentVars /*anywheresoftware.b4a.objects.collections.Map*/ .Put((Object)(_key),_allenvvars.Get((Object)(_key)));
 }
};
RDebugUtils.currentLine=1048593;
 //BA.debugLineNum = 1048593;BA.debugLine="opt.PythonPath = \"\"";
_opt.PythonPath /*String*/  = "";
RDebugUtils.currentLine=1048594;
 //BA.debugLineNum = 1048594;BA.debugLine="opt.TrackLineNumbers = True";
_opt.TrackLineNumbers /*boolean*/  = __c.True;
RDebugUtils.currentLine=1048595;
 //BA.debugLineNum = 1048595;BA.debugLine="If Utils.DetectOS = \"windows\" Then opt.Environmen";
if ((__ref._utils /*b4j.example.pyutils*/ ._detectos /*String*/ (null)).equals("windows")) { 
_opt.EnvironmentVars /*anywheresoftware.b4a.objects.collections.Map*/ .Put((Object)("MPLCONFIGDIR"),(Object)(__c.GetEnvironmentVariable("USERPROFILE","")));};
RDebugUtils.currentLine=1048596;
 //BA.debugLineNum = 1048596;BA.debugLine="Return opt";
if (true) return _opt;
RDebugUtils.currentLine=1048597;
 //BA.debugLineNum = 1048597;BA.debugLine="End Sub";
return null;
}
public String  _start(b4j.example.pybridge __ref,b4j.example.pybridge._pyoptions _options) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "start", true))
	 {return ((String) Debug.delegate(ba, "start", new Object[] {_options}));}
String _exe = "";
String _globalpath = "";
String _path = "";
RDebugUtils.currentLine=786432;
 //BA.debugLineNum = 786432;BA.debugLine="Public Sub Start (Options As PyOptions)";
RDebugUtils.currentLine=786433;
 //BA.debugLineNum = 786433;BA.debugLine="KillProcess";
__ref._killprocess /*String*/ (null);
RDebugUtils.currentLine=786434;
 //BA.debugLineNum = 786434;BA.debugLine="mOptions = Options";
__ref._moptions /*b4j.example.pybridge._pyoptions*/  = _options;
RDebugUtils.currentLine=786435;
 //BA.debugLineNum = 786435;BA.debugLine="comm.Initialize(Me, Options.LocalPort)";
__ref._comm /*b4j.example.pycomm*/ ._initialize /*String*/ (null,ba,(b4j.example.pybridge)(this),_options.LocalPort /*int*/ );
RDebugUtils.currentLine=786436;
 //BA.debugLineNum = 786436;BA.debugLine="Utils.Comm = comm";
__ref._utils /*b4j.example.pyutils*/ ._comm /*b4j.example.pycomm*/  = __ref._comm /*b4j.example.pycomm*/ ;
RDebugUtils.currentLine=786437;
 //BA.debugLineNum = 786437;BA.debugLine="If Options.PythonExecutable <> \"\" Then";
if ((_options.PythonExecutable /*String*/ ).equals("") == false) { 
RDebugUtils.currentLine=786438;
 //BA.debugLineNum = 786438;BA.debugLine="If File.Exists(Options.PyBridgePath, \"\") = False";
if (__c.File.Exists(_options.PyBridgePath /*String*/ ,"")==__c.False || __ref._moptions /*b4j.example.pybridge._pyoptions*/ .ForceCopyBridgeSrc /*boolean*/ ) { 
RDebugUtils.currentLine=786439;
 //BA.debugLineNum = 786439;BA.debugLine="File.Copy(File.DirAssets, \"b4x_bridge.zip\", Opt";
__c.File.Copy(__c.File.getDirAssets(),"b4x_bridge.zip",_options.PyBridgePath /*String*/ ,"");
RDebugUtils.currentLine=786440;
 //BA.debugLineNum = 786440;BA.debugLine="Utils.PyLog(Utils.B4JPrefix, mOptions.B4JColor,";
__ref._utils /*b4j.example.pyutils*/ ._pylog /*String*/ (null,__ref._utils /*b4j.example.pyutils*/ ._b4jprefix /*String*/ ,__ref._moptions /*b4j.example.pybridge._pyoptions*/ .B4JColor /*int*/ ,(Object)("Python package copied to: "+_options.PyBridgePath /*String*/ ));
 };
RDebugUtils.currentLine=786442;
 //BA.debugLineNum = 786442;BA.debugLine="Dim exe As String = Options.PythonExecutable";
_exe = _options.PythonExecutable /*String*/ ;
RDebugUtils.currentLine=786443;
 //BA.debugLineNum = 786443;BA.debugLine="If File.Exists(exe, \"\") = False Then";
if (__c.File.Exists(_exe,"")==__c.False) { 
RDebugUtils.currentLine=786444;
 //BA.debugLineNum = 786444;BA.debugLine="Dim GlobalPath As String = File.Combine(GetEnvi";
_globalpath = __c.File.Combine(__c.GetEnvironmentVariable("B4J_PYTHON",""),"python.exe");
RDebugUtils.currentLine=786445;
 //BA.debugLineNum = 786445;BA.debugLine="If File.Exists(GlobalPath, \"\") Then";
if (__c.File.Exists(_globalpath,"")) { 
RDebugUtils.currentLine=786446;
 //BA.debugLineNum = 786446;BA.debugLine="exe = GlobalPath";
_exe = _globalpath;
 }else {
RDebugUtils.currentLine=786448;
 //BA.debugLineNum = 786448;BA.debugLine="LogError(\"Python executable not found!\")";
__c.LogError("Python executable not found!");
RDebugUtils.currentLine=786449;
 //BA.debugLineNum = 786449;BA.debugLine="comm.CloseServer";
__ref._comm /*b4j.example.pycomm*/ ._closeserver /*String*/ (null);
RDebugUtils.currentLine=786450;
 //BA.debugLineNum = 786450;BA.debugLine="Return";
if (true) return "";
 };
 };
RDebugUtils.currentLine=786453;
 //BA.debugLineNum = 786453;BA.debugLine="Log($\"Python path: ${exe}\"$)";
__c.LogImpl("9786453",("Python path: "+__c.SmartStringFormatter("",(Object)(_exe))+""),0);
RDebugUtils.currentLine=786454;
 //BA.debugLineNum = 786454;BA.debugLine="Dim Shl As Shell";
_shl = new anywheresoftware.b4j.objects.Shell();
RDebugUtils.currentLine=786455;
 //BA.debugLineNum = 786455;BA.debugLine="Shl.Initialize(\"shl\", exe, Array As String(\"-u\",";
__ref._shl /*anywheresoftware.b4j.objects.Shell*/ .Initialize("shl",_exe,anywheresoftware.b4a.keywords.Common.ArrayToList(new String[]{"-u","-m","b4x_bridge",BA.NumberToString(__ref._comm /*b4j.example.pycomm*/ ._port /*int*/ ),BA.NumberToString(__ref._moptions /*b4j.example.pybridge._pyoptions*/ .WatchDogSeconds /*int*/ )}));
RDebugUtils.currentLine=786456;
 //BA.debugLineNum = 786456;BA.debugLine="Dim path As String = IIf(Options.PythonPath = \"\"";
_path = BA.ObjectToString((((_options.PythonPath /*String*/ ).equals("")) ? ((Object)(_options.PyBridgePath /*String*/ )) : ((Object)(_options.PythonPath /*String*/ +";"+_options.PyBridgePath /*String*/ ))));
RDebugUtils.currentLine=786457;
 //BA.debugLineNum = 786457;BA.debugLine="Options.EnvironmentVars.Put(\"PYTHONPATH\", path)";
_options.EnvironmentVars /*anywheresoftware.b4a.objects.collections.Map*/ .Put((Object)("PYTHONPATH"),(Object)(_path));
RDebugUtils.currentLine=786458;
 //BA.debugLineNum = 786458;BA.debugLine="If Options.PyCacheFolder <> \"\" Then Options.Envi";
if ((_options.PyCacheFolder /*String*/ ).equals("") == false) { 
_options.EnvironmentVars /*anywheresoftware.b4a.objects.collections.Map*/ .Put((Object)("PYTHONPYCACHEPREFIX"),(Object)(_options.PyCacheFolder /*String*/ ));};
RDebugUtils.currentLine=786459;
 //BA.debugLineNum = 786459;BA.debugLine="Shl.SetEnvironmentVariables(Options.EnvironmentV";
__ref._shl /*anywheresoftware.b4j.objects.Shell*/ .SetEnvironmentVariables(_options.EnvironmentVars /*anywheresoftware.b4a.objects.collections.Map*/ );
RDebugUtils.currentLine=786460;
 //BA.debugLineNum = 786460;BA.debugLine="Shl.Run(-1)";
__ref._shl /*anywheresoftware.b4j.objects.Shell*/ .Run(ba,(long) (-1));
RDebugUtils.currentLine=786461;
 //BA.debugLineNum = 786461;BA.debugLine="ShlReadLoop";
__ref._shlreadloop /*void*/ (null);
 };
RDebugUtils.currentLine=786463;
 //BA.debugLineNum = 786463;BA.debugLine="End Sub";
return "";
}
public b4j.example.pywrapper  _importmodule(b4j.example.pybridge __ref,String _module) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "importmodule", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "importmodule", new Object[] {_module}));}
b4j.example.pywrapper _res = null;
RDebugUtils.currentLine=2097152;
 //BA.debugLineNum = 2097152;BA.debugLine="Public Sub ImportModule (Module As String) As PyWr";
RDebugUtils.currentLine=2097153;
 //BA.debugLineNum = 2097153;BA.debugLine="RunNoArgsCode(\"import \" & Module)";
__ref._runnoargscode /*String*/ (null,"import "+_module);
RDebugUtils.currentLine=2097154;
 //BA.debugLineNum = 2097154;BA.debugLine="Dim res As PyWrapper = Utils.ImportLib.Run(\"impor";
_res = __ref._utils /*b4j.example.pyutils*/ ._importlib /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"import_module")._arg /*b4j.example.pywrapper*/ (null,(Object)(_module));
RDebugUtils.currentLine=2097155;
 //BA.debugLineNum = 2097155;BA.debugLine="Return res";
if (true) return _res;
RDebugUtils.currentLine=2097156;
 //BA.debugLineNum = 2097156;BA.debugLine="End Sub";
return null;
}
public String  _afterconnection(b4j.example.pybridge __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "afterconnection", true))
	 {return ((String) Debug.delegate(ba, "afterconnection", null));}
RDebugUtils.currentLine=1179648;
 //BA.debugLineNum = 1179648;BA.debugLine="Private Sub AfterConnection";
RDebugUtils.currentLine=1179649;
 //BA.debugLineNum = 1179649;BA.debugLine="Bridge.Initialize(Me, Utils.CreatePyObject(1))";
__ref._bridge /*b4j.example.pywrapper*/ ._initialize /*String*/ (null,ba,(b4j.example.pybridge)(this),__ref._utils /*b4j.example.pyutils*/ ._createpyobject /*b4j.example.pybridge._pyobject*/ (null,(int) (1)));
RDebugUtils.currentLine=1179650;
 //BA.debugLineNum = 1179650;BA.debugLine="Builtins.Initialize(Me, Utils.CreatePyObject(3))";
__ref._builtins /*b4j.example.pywrapper*/ ._initialize /*String*/ (null,ba,(b4j.example.pybridge)(this),__ref._utils /*b4j.example.pyutils*/ ._createpyobject /*b4j.example.pybridge._pyobject*/ (null,(int) (3)));
RDebugUtils.currentLine=1179651;
 //BA.debugLineNum = 1179651;BA.debugLine="Utils.Connected(Utils.CreatePyObject(2), mOptions";
__ref._utils /*b4j.example.pyutils*/ ._connected /*String*/ (null,__ref._utils /*b4j.example.pyutils*/ ._createpyobject /*b4j.example.pybridge._pyobject*/ (null,(int) (2)),__ref._moptions /*b4j.example.pybridge._pyoptions*/ );
RDebugUtils.currentLine=1179652;
 //BA.debugLineNum = 1179652;BA.debugLine="Sys = ImportModule(\"sys\")";
__ref._sys /*b4j.example.pywrapper*/  = __ref._importmodule /*b4j.example.pywrapper*/ (null,"sys");
RDebugUtils.currentLine=1179653;
 //BA.debugLineNum = 1179653;BA.debugLine="Itertools = ImportModule(\"itertools\")";
__ref._itertools /*b4j.example.pywrapper*/  = __ref._importmodule /*b4j.example.pywrapper*/ (null,"itertools");
RDebugUtils.currentLine=1179654;
 //BA.debugLineNum = 1179654;BA.debugLine="End Sub";
return "";
}
public b4j.example.pywrapper  _asfloat(b4j.example.pybridge __ref,Object _o) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "asfloat", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "asfloat", new Object[] {_o}));}
RDebugUtils.currentLine=2490368;
 //BA.debugLineNum = 2490368;BA.debugLine="Public Sub AsFloat (o As Object) As PyWrapper";
RDebugUtils.currentLine=2490369;
 //BA.debugLineNum = 2490369;BA.debugLine="Return Builtins.Run(\"float\").Arg(o)";
if (true) return __ref._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"float")._arg /*b4j.example.pywrapper*/ (null,_o);
RDebugUtils.currentLine=2490370;
 //BA.debugLineNum = 2490370;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _asint(b4j.example.pybridge __ref,Object _o) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "asint", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "asint", new Object[] {_o}));}
RDebugUtils.currentLine=2359296;
 //BA.debugLineNum = 2359296;BA.debugLine="Public Sub AsInt (o As Object) As PyWrapper";
RDebugUtils.currentLine=2359297;
 //BA.debugLineNum = 2359297;BA.debugLine="Return Builtins.Run(\"int\").Arg(o)";
if (true) return __ref._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"int")._arg /*b4j.example.pywrapper*/ (null,_o);
RDebugUtils.currentLine=2359298;
 //BA.debugLineNum = 2359298;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _asstr(b4j.example.pybridge __ref,Object _o) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "asstr", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "asstr", new Object[] {_o}));}
RDebugUtils.currentLine=2424832;
 //BA.debugLineNum = 2424832;BA.debugLine="Public Sub AsStr (o As Object) As PyWrapper";
RDebugUtils.currentLine=2424833;
 //BA.debugLineNum = 2424833;BA.debugLine="Return Builtins.Run(\"str\").Arg(o)";
if (true) return __ref._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"str")._arg /*b4j.example.pywrapper*/ (null,_o);
RDebugUtils.currentLine=2424834;
 //BA.debugLineNum = 2424834;BA.debugLine="End Sub";
return null;
}
public String  _class_globals(b4j.example.pybridge __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
RDebugUtils.currentLine=655360;
 //BA.debugLineNum = 655360;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=655361;
 //BA.debugLineNum = 655361;BA.debugLine="Type PyObject (Key As Int)";
;
RDebugUtils.currentLine=655362;
 //BA.debugLineNum = 655362;BA.debugLine="Type PyTask (TaskId As Int, TaskType As Int, Extr";
;
RDebugUtils.currentLine=655363;
 //BA.debugLineNum = 655363;BA.debugLine="Type InternalPyTaskAsyncResult (PyObject As PyObj";
;
RDebugUtils.currentLine=655364;
 //BA.debugLineNum = 655364;BA.debugLine="Type PyOptions (PythonExecutable As String, Local";
;
RDebugUtils.currentLine=655368;
 //BA.debugLineNum = 655368;BA.debugLine="Type InternalPyMethodArgs (Args As List, KWArgs A";
;
RDebugUtils.currentLine=655369;
 //BA.debugLineNum = 655369;BA.debugLine="Private comm As PyComm";
_comm = new b4j.example.pycomm();
RDebugUtils.currentLine=655370;
 //BA.debugLineNum = 655370;BA.debugLine="Private mCallback As Object";
_mcallback = new Object();
RDebugUtils.currentLine=655371;
 //BA.debugLineNum = 655371;BA.debugLine="Private mEventName As String";
_meventname = "";
RDebugUtils.currentLine=655372;
 //BA.debugLineNum = 655372;BA.debugLine="Public Utils As PyUtils";
_utils = new b4j.example.pyutils();
RDebugUtils.currentLine=655373;
 //BA.debugLineNum = 655373;BA.debugLine="Public Builtins As PyWrapper";
_builtins = new b4j.example.pywrapper();
RDebugUtils.currentLine=655374;
 //BA.debugLineNum = 655374;BA.debugLine="Public Bridge As PyWrapper";
_bridge = new b4j.example.pywrapper();
RDebugUtils.currentLine=655375;
 //BA.debugLineNum = 655375;BA.debugLine="Public Itertools As PyWrapper";
_itertools = new b4j.example.pywrapper();
RDebugUtils.currentLine=655376;
 //BA.debugLineNum = 655376;BA.debugLine="Public Sys As PyWrapper";
_sys = new b4j.example.pywrapper();
RDebugUtils.currentLine=655377;
 //BA.debugLineNum = 655377;BA.debugLine="Private Shl As Shell";
_shl = new anywheresoftware.b4j.objects.Shell();
RDebugUtils.currentLine=655378;
 //BA.debugLineNum = 655378;BA.debugLine="Private mOptions As PyOptions";
_moptions = new b4j.example.pybridge._pyoptions();
RDebugUtils.currentLine=655379;
 //BA.debugLineNum = 655379;BA.debugLine="Private ShlReadLoopIndex As Int";
_shlreadloopindex = 0;
RDebugUtils.currentLine=655380;
 //BA.debugLineNum = 655380;BA.debugLine="Public ErrorHandler As PyErrorHandler";
_errorhandler = new b4j.example.pyerrorhandler();
RDebugUtils.currentLine=655381;
 //BA.debugLineNum = 655381;BA.debugLine="Public PyLastException As String";
_pylastexception = "";
RDebugUtils.currentLine=655382;
 //BA.debugLineNum = 655382;BA.debugLine="Private EventMapper As Map";
_eventmapper = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=655383;
 //BA.debugLineNum = 655383;BA.debugLine="End Sub";
return "";
}
public b4j.example.pywrapper  _convertunserializable(b4j.example.pybridge __ref,Object _list) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "convertunserializable", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "convertunserializable", new Object[] {_list}));}
String _code = "";
RDebugUtils.currentLine=2949120;
 //BA.debugLineNum = 2949120;BA.debugLine="Private Sub ConvertUnserializable (List As Object)";
RDebugUtils.currentLine=2949121;
 //BA.debugLineNum = 2949121;BA.debugLine="Dim Code As String = $\" def ConvertUnserializable";
_code = ("\n"+"def ConvertUnserializable (bridge, list1):\n"+"	l = map(lambda x: bridge.comm.serializator.is_serializable(x), list1)\n"+"	return [x if y is None else str(y)[:100] for x, y in zip(list1, l)]\n"+"");
RDebugUtils.currentLine=2949126;
 //BA.debugLineNum = 2949126;BA.debugLine="Return RunCode(\"ConvertUnserializable\", Array(Bri";
if (true) return __ref._runcode /*b4j.example.pywrapper*/ (null,"ConvertUnserializable",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(__ref._bridge /*b4j.example.pywrapper*/ ),_list}),_code);
RDebugUtils.currentLine=2949127;
 //BA.debugLineNum = 2949127;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _runcode(b4j.example.pybridge __ref,String _membername,anywheresoftware.b4a.objects.collections.List _args,String _functioncode) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "runcode", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "runcode", new Object[] {_membername,_args,_functioncode}));}
RDebugUtils.currentLine=1703936;
 //BA.debugLineNum = 1703936;BA.debugLine="Public Sub RunCode (MemberName As String, Args As";
RDebugUtils.currentLine=1703937;
 //BA.debugLineNum = 1703937;BA.debugLine="RegisterMember(MemberName, FunctionCode, False)";
__ref._registermember /*String*/ (null,_membername,_functioncode,__c.False);
RDebugUtils.currentLine=1703938;
 //BA.debugLineNum = 1703938;BA.debugLine="Return GetMember(MemberName).Call.Args(Args)";
if (true) return __ref._getmember /*b4j.example.pywrapper*/ (null,_membername)._call /*b4j.example.pywrapper*/ (null)._args /*b4j.example.pywrapper*/ (null,_args);
RDebugUtils.currentLine=1703939;
 //BA.debugLineNum = 1703939;BA.debugLine="End Sub";
return null;
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _fetchobjects(b4j.example.pybridge __ref,Object _objects) throws Exception{
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "fetchobjects", true))
	 {return ((anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) Debug.delegate(ba, "fetchobjects", new Object[] {_objects}));}
ResumableSub_FetchObjects rsub = new ResumableSub_FetchObjects(this,__ref,_objects);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_FetchObjects extends BA.ResumableSub {
public ResumableSub_FetchObjects(b4j.example.pybridge parent,b4j.example.pybridge __ref,Object _objects) {
this.parent = parent;
this.__ref = __ref;
this._objects = _objects;
this.__ref = parent;
}
b4j.example.pybridge __ref;
b4j.example.pybridge parent;
Object _objects;
b4j.example.pywrapper _list = null;
b4j.example.pywrapper _result = null;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="pybridge";

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.ReturnFromResumableSub(this,null);return;}
case 0:
//C
this.state = -1;
RDebugUtils.currentLine=2818049;
 //BA.debugLineNum = 2818049;BA.debugLine="Dim List As PyWrapper = IIf(Objects Is PyWrapper,";
_list = (b4j.example.pywrapper)(((_objects instanceof b4j.example.pywrapper) ? (_objects) : ((Object)(__ref._wrapobject /*b4j.example.pywrapper*/ (null,_objects)))));
RDebugUtils.currentLine=2818050;
 //BA.debugLineNum = 2818050;BA.debugLine="Wait For (ConvertUnserializable(List).Fetch) Comp";
parent.__c.WaitFor("complete", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pybridge", "fetchobjects"), __ref._convertunserializable /*b4j.example.pywrapper*/ (null,(Object)(_list))._fetch /*anywheresoftware.b4a.keywords.Common.ResumableSubWrapper*/ (null));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_result = (b4j.example.pywrapper) result[1];
;
RDebugUtils.currentLine=2818051;
 //BA.debugLineNum = 2818051;BA.debugLine="Return Result.Value.As(List)";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(((anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_result._getvalue /*Object*/ (null))))));return;};
RDebugUtils.currentLine=2818052;
 //BA.debugLineNum = 2818052;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public b4j.example.pywrapper  _wrapobject(b4j.example.pybridge __ref,Object _obj) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "wrapobject", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "wrapobject", new Object[] {_obj}));}
String _code = "";
RDebugUtils.currentLine=3080192;
 //BA.debugLineNum = 3080192;BA.debugLine="Public Sub WrapObject (Obj As Object) As PyWrapper";
RDebugUtils.currentLine=3080193;
 //BA.debugLineNum = 3080193;BA.debugLine="Dim Code As String = $\" def WrapObject(obj): 	ret";
_code = ("\n"+"def WrapObject(obj):\n"+"	return obj\n"+"");
RDebugUtils.currentLine=3080197;
 //BA.debugLineNum = 3080197;BA.debugLine="Return RunCode(\"WrapObject\", Array(Obj), Code)";
if (true) return __ref._runcode /*b4j.example.pywrapper*/ (null,"WrapObject",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{_obj}),_code);
RDebugUtils.currentLine=3080198;
 //BA.debugLineNum = 3080198;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _filter(b4j.example.pybridge __ref,Object _predicate,Object _iterable) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "filter", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "filter", new Object[] {_predicate,_iterable}));}
RDebugUtils.currentLine=2621440;
 //BA.debugLineNum = 2621440;BA.debugLine="Public Sub Filter (Predicate As Object, Iterable A";
RDebugUtils.currentLine=2621441;
 //BA.debugLineNum = 2621441;BA.debugLine="Return Builtins.Run(\"filter\").Arg(Utils.ConvertLa";
if (true) return __ref._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"filter")._arg /*b4j.example.pywrapper*/ (null,(Object)(__ref._utils /*b4j.example.pyutils*/ ._convertlambdaifmatch /*b4j.example.pywrapper*/ (null,_predicate)))._arg /*b4j.example.pywrapper*/ (null,_iterable);
RDebugUtils.currentLine=2621442;
 //BA.debugLineNum = 2621442;BA.debugLine="End Sub";
return null;
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _flush(b4j.example.pybridge __ref) throws Exception{
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "flush", true))
	 {return ((anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) Debug.delegate(ba, "flush", null));}
ResumableSub_Flush rsub = new ResumableSub_Flush(this,__ref);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_Flush extends BA.ResumableSub {
public ResumableSub_Flush(b4j.example.pybridge parent,b4j.example.pybridge __ref) {
this.parent = parent;
this.__ref = __ref;
this.__ref = parent;
}
b4j.example.pybridge __ref;
b4j.example.pybridge parent;
boolean _success = false;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="pybridge";

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.ReturnFromResumableSub(this,null);return;}
case 0:
//C
this.state = -1;
RDebugUtils.currentLine=1245185;
 //BA.debugLineNum = 1245185;BA.debugLine="Wait For (Utils.Flush) Complete (Success As Boole";
parent.__c.WaitFor("complete", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pybridge", "flush"), __ref._utils /*b4j.example.pyutils*/ ._flush /*anywheresoftware.b4a.keywords.Common.ResumableSubWrapper*/ (null));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_success = (boolean) result[1];
;
RDebugUtils.currentLine=1245186;
 //BA.debugLineNum = 1245186;BA.debugLine="Return Success";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(_success));return;};
RDebugUtils.currentLine=1245187;
 //BA.debugLineNum = 1245187;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public b4j.example.pywrapper  _getmember(b4j.example.pybridge __ref,String _member) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "getmember", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "getmember", new Object[] {_member}));}
RDebugUtils.currentLine=2031616;
 //BA.debugLineNum = 2031616;BA.debugLine="Public Sub GetMember(Member As String) As PyWrappe";
RDebugUtils.currentLine=2031617;
 //BA.debugLineNum = 2031617;BA.debugLine="Return Utils.EvalGlobals.Get(Member)";
if (true) return __ref._utils /*b4j.example.pyutils*/ ._evalglobals /*b4j.example.pywrapper*/ ._get /*b4j.example.pywrapper*/ (null,(Object)(_member));
RDebugUtils.currentLine=2031618;
 //BA.debugLineNum = 2031618;BA.debugLine="End Sub";
return null;
}
public String  _handleoutanderr(b4j.example.pybridge __ref,String _out,String _err) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "handleoutanderr", true))
	 {return ((String) Debug.delegate(ba, "handleoutanderr", new Object[] {_out,_err}));}
RDebugUtils.currentLine=917504;
 //BA.debugLineNum = 917504;BA.debugLine="Private Sub HandleOutAndErr (out As String, Err As";
RDebugUtils.currentLine=917505;
 //BA.debugLineNum = 917505;BA.debugLine="If out.Length > 0 Then Utils.PyLog(Utils.PyOutPre";
if (_out.length()>0) { 
__ref._utils /*b4j.example.pyutils*/ ._pylog /*String*/ (null,__ref._utils /*b4j.example.pyutils*/ ._pyoutprefix /*String*/ ,__ref._moptions /*b4j.example.pybridge._pyoptions*/ .PyOutColor /*int*/ ,(Object)(_out));};
RDebugUtils.currentLine=917506;
 //BA.debugLineNum = 917506;BA.debugLine="If Err.Length > 0 Then Utils.PyLog(Utils.PyErrPre";
if (_err.length()>0) { 
__ref._utils /*b4j.example.pyutils*/ ._pylog /*String*/ (null,__ref._utils /*b4j.example.pyutils*/ ._pyerrprefix /*String*/ ,__ref._moptions /*b4j.example.pybridge._pyoptions*/ .PyErrColor /*int*/ ,(Object)(_err));};
RDebugUtils.currentLine=917507;
 //BA.debugLineNum = 917507;BA.debugLine="End Sub";
return "";
}
public String  _runnoargscode(b4j.example.pybridge __ref,String _code) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "runnoargscode", true))
	 {return ((String) Debug.delegate(ba, "runnoargscode", new Object[] {_code}));}
RDebugUtils.currentLine=1835008;
 //BA.debugLineNum = 1835008;BA.debugLine="Public Sub RunNoArgsCode (Code As String)";
RDebugUtils.currentLine=1835009;
 //BA.debugLineNum = 1835009;BA.debugLine="Builtins.RunArgs(\"exec\", Array(Code, Utils.EvalGl";
__ref._builtins /*b4j.example.pywrapper*/ ._runargs /*b4j.example.pywrapper*/ (null,"exec",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(_code),(Object)(__ref._utils /*b4j.example.pyutils*/ ._evalglobals /*b4j.example.pywrapper*/ ),__c.Null}),(anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(__c.Null)));
RDebugUtils.currentLine=1835010;
 //BA.debugLineNum = 1835010;BA.debugLine="End Sub";
return "";
}
public b4j.example.pywrapper  _importmodulefrom(b4j.example.pybridge __ref,String _frommodule,String _importmember) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "importmodulefrom", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "importmodulefrom", new Object[] {_frommodule,_importmember}));}
b4j.example.pywrapper _res = null;
RDebugUtils.currentLine=2162688;
 //BA.debugLineNum = 2162688;BA.debugLine="Public Sub ImportModuleFrom(FromModule As String,";
RDebugUtils.currentLine=2162689;
 //BA.debugLineNum = 2162689;BA.debugLine="RunNoArgsCode(\"from \" & FromModule & \" import \" &";
__ref._runnoargscode /*String*/ (null,"from "+_frommodule+" import "+_importmember);
RDebugUtils.currentLine=2162690;
 //BA.debugLineNum = 2162690;BA.debugLine="Dim res As PyWrapper = ImportModule(FromModule).G";
_res = __ref._importmodule /*b4j.example.pywrapper*/ (null,_frommodule)._getfield /*b4j.example.pywrapper*/ (null,_importmember);
RDebugUtils.currentLine=2162691;
 //BA.debugLineNum = 2162691;BA.debugLine="Return res";
if (true) return _res;
RDebugUtils.currentLine=2162692;
 //BA.debugLineNum = 2162692;BA.debugLine="End Sub";
return null;
}
public String  _killprocess(b4j.example.pybridge __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "killprocess", true))
	 {return ((String) Debug.delegate(ba, "killprocess", null));}
RDebugUtils.currentLine=1441792;
 //BA.debugLineNum = 1441792;BA.debugLine="Public Sub KillProcess";
RDebugUtils.currentLine=1441793;
 //BA.debugLineNum = 1441793;BA.debugLine="Try";
try {RDebugUtils.currentLine=1441794;
 //BA.debugLineNum = 1441794;BA.debugLine="ShlReadLoopIndex = ShlReadLoopIndex + 1";
__ref._shlreadloopindex /*int*/  = (int) (__ref._shlreadloopindex /*int*/ +1);
RDebugUtils.currentLine=1441795;
 //BA.debugLineNum = 1441795;BA.debugLine="If Initialized(comm) Then";
if (__c.Initialized((Object)(__ref._comm /*b4j.example.pycomm*/ ))) { 
RDebugUtils.currentLine=1441796;
 //BA.debugLineNum = 1441796;BA.debugLine="comm.CloseServer";
__ref._comm /*b4j.example.pycomm*/ ._closeserver /*String*/ (null);
 };
RDebugUtils.currentLine=1441798;
 //BA.debugLineNum = 1441798;BA.debugLine="If mOptions.PythonExecutable <> \"\" And Initializ";
if ((__ref._moptions /*b4j.example.pybridge._pyoptions*/ .PythonExecutable /*String*/ ).equals("") == false && __c.Initialized((Object)(__ref._shl /*anywheresoftware.b4j.objects.Shell*/ ))) { 
RDebugUtils.currentLine=1441799;
 //BA.debugLineNum = 1441799;BA.debugLine="Shl.KillProcess";
__ref._shl /*anywheresoftware.b4j.objects.Shell*/ .KillProcess();
 };
 } 
       catch (Exception e10) {
			ba.setLastException(e10);RDebugUtils.currentLine=1441802;
 //BA.debugLineNum = 1441802;BA.debugLine="Log(LastException)";
__c.LogImpl("91441802",BA.ObjectToString(__c.LastException(ba)),0);
 };
RDebugUtils.currentLine=1441804;
 //BA.debugLineNum = 1441804;BA.debugLine="End Sub";
return "";
}
public b4j.example.pywrapper  _lambda(b4j.example.pybridge __ref,String _code) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "lambda", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "lambda", new Object[] {_code}));}
RDebugUtils.currentLine=2686976;
 //BA.debugLineNum = 2686976;BA.debugLine="Public Sub Lambda(Code As String) As PyWrapper";
RDebugUtils.currentLine=2686977;
 //BA.debugLineNum = 2686977;BA.debugLine="Return RunStatement(\"lambda \" & Code)";
if (true) return __ref._runstatement /*b4j.example.pywrapper*/ (null,"lambda "+_code);
RDebugUtils.currentLine=2686978;
 //BA.debugLineNum = 2686978;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _runstatement(b4j.example.pybridge __ref,String _code) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "runstatement", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "runstatement", new Object[] {_code}));}
RDebugUtils.currentLine=1900544;
 //BA.debugLineNum = 1900544;BA.debugLine="Public Sub RunStatement (Code As String) As PyWrap";
RDebugUtils.currentLine=1900545;
 //BA.debugLineNum = 1900545;BA.debugLine="Return RunStatement2(Code, Null)";
if (true) return __ref._runstatement2 /*b4j.example.pywrapper*/ (null,_code,(anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(__c.Null)));
RDebugUtils.currentLine=1900546;
 //BA.debugLineNum = 1900546;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _map_(b4j.example.pybridge __ref,Object _function,Object _iterable) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "map_", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "map_", new Object[] {_function,_iterable}));}
RDebugUtils.currentLine=2555904;
 //BA.debugLineNum = 2555904;BA.debugLine="Public Sub Map_(Function As Object, Iterable As Ob";
RDebugUtils.currentLine=2555905;
 //BA.debugLineNum = 2555905;BA.debugLine="Return Builtins.Run(\"map\").Arg(Utils.ConvertLambd";
if (true) return __ref._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"map")._arg /*b4j.example.pywrapper*/ (null,(Object)(__ref._utils /*b4j.example.pyutils*/ ._convertlambdaifmatch /*b4j.example.pywrapper*/ (null,_function)))._arg /*b4j.example.pywrapper*/ (null,_iterable);
RDebugUtils.currentLine=2555906;
 //BA.debugLineNum = 2555906;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _open(b4j.example.pybridge __ref,Object _filepath,Object _mode) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "open", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "open", new Object[] {_filepath,_mode}));}
RDebugUtils.currentLine=3145728;
 //BA.debugLineNum = 3145728;BA.debugLine="Public Sub Open (FilePath As Object, Mode As Objec";
RDebugUtils.currentLine=3145729;
 //BA.debugLineNum = 3145729;BA.debugLine="Return Builtins.Run(\"open\").Arg(FilePath).Arg(Mod";
if (true) return __ref._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"open")._arg /*b4j.example.pywrapper*/ (null,_filepath)._arg /*b4j.example.pywrapper*/ (null,_mode);
RDebugUtils.currentLine=3145730;
 //BA.debugLineNum = 3145730;BA.debugLine="End Sub";
return null;
}
public String  _print(b4j.example.pybridge __ref,Object _obj) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "print", true))
	 {return ((String) Debug.delegate(ba, "print", new Object[] {_obj}));}
RDebugUtils.currentLine=1507328;
 //BA.debugLineNum = 1507328;BA.debugLine="Public Sub Print(Obj As Object)";
RDebugUtils.currentLine=1507329;
 //BA.debugLineNum = 1507329;BA.debugLine="PrintJoin(Array(Obj), False)";
__ref._printjoin /*String*/ (null,anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{_obj}),__c.False);
RDebugUtils.currentLine=1507330;
 //BA.debugLineNum = 1507330;BA.debugLine="End Sub";
return "";
}
public String  _printjoin(b4j.example.pybridge __ref,anywheresoftware.b4a.objects.collections.List _objects,boolean _stderr) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "printjoin", true))
	 {return ((String) Debug.delegate(ba, "printjoin", new Object[] {_objects,_stderr}));}
String _code = "";
RDebugUtils.currentLine=1572864;
 //BA.debugLineNum = 1572864;BA.debugLine="Public Sub PrintJoin (Objects As List, StdErr As B";
RDebugUtils.currentLine=1572865;
 //BA.debugLineNum = 1572865;BA.debugLine="Dim Code As String = $\" def _print(obj, StdErr):";
_code = ("\n"+"def _print(obj, StdErr):\n"+"	print(*obj, file=sys.stderr if StdErr else sys.stdout)\n"+"");
RDebugUtils.currentLine=1572869;
 //BA.debugLineNum = 1572869;BA.debugLine="RunCode(\"_print\", Array(Objects, StdErr), Code)";
__ref._runcode /*b4j.example.pywrapper*/ (null,"_print",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(_objects.getObject()),(Object)(_stderr)}),_code);
RDebugUtils.currentLine=1572870;
 //BA.debugLineNum = 1572870;BA.debugLine="End Sub";
return "";
}
public b4j.example.pywrapper  _pyiif(b4j.example.pybridge __ref,Object _condition,Object _truevalue,Object _falsevalue) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "pyiif", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "pyiif", new Object[] {_condition,_truevalue,_falsevalue}));}
RDebugUtils.currentLine=3014656;
 //BA.debugLineNum = 3014656;BA.debugLine="Public Sub PyIIf (Condition As Object, TrueValue A";
RDebugUtils.currentLine=3014657;
 //BA.debugLineNum = 3014657;BA.debugLine="Return RunCode(\"PyIIF\", Array(Condition, TrueValu";
if (true) return __ref._runcode /*b4j.example.pywrapper*/ (null,"PyIIF",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{_condition,_truevalue,_falsevalue}),("\n"+"def PyIIF(condition, TrueValue, FalseValue):\n"+"	res = TrueValue if condition else FalseValue\n"+"	if callable(res):\n"+"		return res()\n"+"	else:\n"+"		return res\n"+""));
RDebugUtils.currentLine=3014665;
 //BA.debugLineNum = 3014665;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _pynext(b4j.example.pybridge __ref,b4j.example.pywrapper _iter) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "pynext", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "pynext", new Object[] {_iter}));}
RDebugUtils.currentLine=2752512;
 //BA.debugLineNum = 2752512;BA.debugLine="Public Sub PyNext(Iter As PyWrapper) As PyWrapper";
RDebugUtils.currentLine=2752513;
 //BA.debugLineNum = 2752513;BA.debugLine="Return Builtins.Run(\"next\").Arg(Iter)";
if (true) return __ref._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"next")._arg /*b4j.example.pywrapper*/ (null,(Object)(_iter));
RDebugUtils.currentLine=2752514;
 //BA.debugLineNum = 2752514;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _range(b4j.example.pybridge __ref,Object _firstparam) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "range", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "range", new Object[] {_firstparam}));}
RDebugUtils.currentLine=2883584;
 //BA.debugLineNum = 2883584;BA.debugLine="Public Sub Range (FirstParam As Object) As PyWrapp";
RDebugUtils.currentLine=2883585;
 //BA.debugLineNum = 2883585;BA.debugLine="Return Builtins.Run(\"range\").Arg(FirstParam)";
if (true) return __ref._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"range")._arg /*b4j.example.pywrapper*/ (null,_firstparam);
RDebugUtils.currentLine=2883586;
 //BA.debugLineNum = 2883586;BA.debugLine="End Sub";
return null;
}
public String  _registermember(b4j.example.pybridge __ref,String _keyname,String _classcode,boolean _overwrite) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "registermember", true))
	 {return ((String) Debug.delegate(ba, "registermember", new Object[] {_keyname,_classcode,_overwrite}));}
RDebugUtils.currentLine=1638400;
 //BA.debugLineNum = 1638400;BA.debugLine="Private Sub RegisterMember (KeyName As String, Cla";
RDebugUtils.currentLine=1638401;
 //BA.debugLineNum = 1638401;BA.debugLine="If Utils.RegisteredMembers.Contains(KeyName) = Fa";
if (__ref._utils /*b4j.example.pyutils*/ ._registeredmembers /*b4j.example.b4xset*/ ._contains /*boolean*/ (null,(Object)(_keyname))==__c.False || _overwrite) { 
RDebugUtils.currentLine=1638402;
 //BA.debugLineNum = 1638402;BA.debugLine="RunNoArgsCode(ClassCode)";
__ref._runnoargscode /*String*/ (null,_classcode);
RDebugUtils.currentLine=1638403;
 //BA.debugLineNum = 1638403;BA.debugLine="Utils.RegisteredMembers.Add(KeyName)";
__ref._utils /*b4j.example.pyutils*/ ._registeredmembers /*b4j.example.b4xset*/ ._add /*String*/ (null,(Object)(_keyname));
 };
RDebugUtils.currentLine=1638405;
 //BA.debugLineNum = 1638405;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _runcodeawait(b4j.example.pybridge __ref,String _membername,anywheresoftware.b4a.objects.collections.List _args,String _functioncode) throws Exception{
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "runcodeawait", true))
	 {return ((anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) Debug.delegate(ba, "runcodeawait", new Object[] {_membername,_args,_functioncode}));}
ResumableSub_RunCodeAwait rsub = new ResumableSub_RunCodeAwait(this,__ref,_membername,_args,_functioncode);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_RunCodeAwait extends BA.ResumableSub {
public ResumableSub_RunCodeAwait(b4j.example.pybridge parent,b4j.example.pybridge __ref,String _membername,anywheresoftware.b4a.objects.collections.List _args,String _functioncode) {
this.parent = parent;
this.__ref = __ref;
this._membername = _membername;
this._args = _args;
this._functioncode = _functioncode;
this.__ref = parent;
}
b4j.example.pybridge __ref;
b4j.example.pybridge parent;
String _membername;
anywheresoftware.b4a.objects.collections.List _args;
String _functioncode;
b4j.example.pywrapper _result = null;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="pybridge";

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.ReturnFromResumableSub(this,null);return;}
case 0:
//C
this.state = -1;
RDebugUtils.currentLine=1769473;
 //BA.debugLineNum = 1769473;BA.debugLine="RegisterMember(MemberName, FunctionCode, False)";
__ref._registermember /*String*/ (null,_membername,_functioncode,parent.__c.False);
RDebugUtils.currentLine=1769474;
 //BA.debugLineNum = 1769474;BA.debugLine="Wait For (GetMember(MemberName).RunAwait(\"__call_";
parent.__c.WaitFor("complete", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pybridge", "runcodeawait"), __ref._getmember /*b4j.example.pywrapper*/ (null,_membername)._runawait /*anywheresoftware.b4a.keywords.Common.ResumableSubWrapper*/ (null,"__call__",_args,(anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(parent.__c.Null))));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_result = (b4j.example.pywrapper) result[1];
;
RDebugUtils.currentLine=1769475;
 //BA.debugLineNum = 1769475;BA.debugLine="Return Result";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(_result));return;};
RDebugUtils.currentLine=1769476;
 //BA.debugLineNum = 1769476;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public b4j.example.pywrapper  _runstatement2(b4j.example.pybridge __ref,String _code,anywheresoftware.b4a.objects.collections.Map _locals) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "runstatement2", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "runstatement2", new Object[] {_code,_locals}));}
RDebugUtils.currentLine=1966080;
 //BA.debugLineNum = 1966080;BA.debugLine="Public Sub RunStatement2 (Code As String, Locals A";
RDebugUtils.currentLine=1966081;
 //BA.debugLineNum = 1966081;BA.debugLine="If NotInitialized(Locals) Then Locals = B4XCollec";
if (__c.NotInitialized((Object)(_locals))) { 
_locals = _b4xcollections._getemptymap /*anywheresoftware.b4a.objects.collections.Map*/ ();};
RDebugUtils.currentLine=1966082;
 //BA.debugLineNum = 1966082;BA.debugLine="Return Builtins.RunArgs (\"eval\", Array(Code, Util";
if (true) return __ref._builtins /*b4j.example.pywrapper*/ ._runargs /*b4j.example.pywrapper*/ (null,"eval",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(_code),(Object)(__ref._utils /*b4j.example.pyutils*/ ._evalglobals /*b4j.example.pywrapper*/ ),(Object)(_locals.getObject())}),(anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(__c.Null)));
RDebugUtils.currentLine=1966083;
 //BA.debugLineNum = 1966083;BA.debugLine="End Sub";
return null;
}
public String  _seteventmapping(b4j.example.pybridge __ref,String _pythoneventname,Object _callback,String _b4xeventname) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "seteventmapping", true))
	 {return ((String) Debug.delegate(ba, "seteventmapping", new Object[] {_pythoneventname,_callback,_b4xeventname}));}
RDebugUtils.currentLine=1376256;
 //BA.debugLineNum = 1376256;BA.debugLine="Public Sub SetEventMapping(PythonEventName As Stri";
RDebugUtils.currentLine=1376257;
 //BA.debugLineNum = 1376257;BA.debugLine="EventMapper.Put(PythonEventName, Array(Callback,";
__ref._eventmapper /*anywheresoftware.b4a.objects.collections.Map*/ .Put((Object)(_pythoneventname),(Object)(new Object[]{_callback,(Object)(_b4xeventname)}));
RDebugUtils.currentLine=1376258;
 //BA.debugLineNum = 1376258;BA.debugLine="End Sub";
return "";
}
public String  _shl_processcompleted(b4j.example.pybridge __ref,boolean _success,int _exitcode,String _stdout,String _stderr) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "shl_processcompleted", true))
	 {return ((String) Debug.delegate(ba, "shl_processcompleted", new Object[] {_success,_exitcode,_stdout,_stderr}));}
RDebugUtils.currentLine=983040;
 //BA.debugLineNum = 983040;BA.debugLine="Private Sub shl_ProcessCompleted (Success As Boole";
RDebugUtils.currentLine=983041;
 //BA.debugLineNum = 983041;BA.debugLine="HandleOutAndErr(StdOut, StdErr)";
__ref._handleoutanderr /*String*/ (null,_stdout,_stderr);
RDebugUtils.currentLine=983042;
 //BA.debugLineNum = 983042;BA.debugLine="Utils.PyLog(Utils.B4JPrefix, mOptions.B4JColor, $";
__ref._utils /*b4j.example.pyutils*/ ._pylog /*String*/ (null,__ref._utils /*b4j.example.pyutils*/ ._b4jprefix /*String*/ ,__ref._moptions /*b4j.example.pybridge._pyoptions*/ .B4JColor /*int*/ ,(Object)(("Process completed. ExitCode: "+__c.SmartStringFormatter("",(Object)(_exitcode))+"")));
RDebugUtils.currentLine=983043;
 //BA.debugLineNum = 983043;BA.debugLine="Dim Shl As Shell";
_shl = new anywheresoftware.b4j.objects.Shell();
RDebugUtils.currentLine=983044;
 //BA.debugLineNum = 983044;BA.debugLine="comm.CloseServer";
__ref._comm /*b4j.example.pycomm*/ ._closeserver /*String*/ (null);
RDebugUtils.currentLine=983045;
 //BA.debugLineNum = 983045;BA.debugLine="End Sub";
return "";
}
public void  _shlreadloop(b4j.example.pybridge __ref) throws Exception{
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "shlreadloop", true))
	 {Debug.delegate(ba, "shlreadloop", null); return;}
ResumableSub_ShlReadLoop rsub = new ResumableSub_ShlReadLoop(this,__ref);
rsub.resume(ba, null);
}
public static class ResumableSub_ShlReadLoop extends BA.ResumableSub {
public ResumableSub_ShlReadLoop(b4j.example.pybridge parent,b4j.example.pybridge __ref) {
this.parent = parent;
this.__ref = __ref;
this.__ref = parent;
}
b4j.example.pybridge __ref;
b4j.example.pybridge parent;
int _myindex = 0;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="pybridge";

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
RDebugUtils.currentLine=851969;
 //BA.debugLineNum = 851969;BA.debugLine="ShlReadLoopIndex = ShlReadLoopIndex + 1";
__ref._shlreadloopindex /*int*/  = (int) (__ref._shlreadloopindex /*int*/ +1);
RDebugUtils.currentLine=851970;
 //BA.debugLineNum = 851970;BA.debugLine="Dim MyIndex As Int = ShlReadLoopIndex";
_myindex = __ref._shlreadloopindex /*int*/ ;
RDebugUtils.currentLine=851971;
 //BA.debugLineNum = 851971;BA.debugLine="Do While MyIndex = ShlReadLoopIndex And Initializ";
if (true) break;

case 1:
//do while
this.state = 4;
while (_myindex==__ref._shlreadloopindex /*int*/  && parent.__c.Initialized((Object)(__ref._shl /*anywheresoftware.b4j.objects.Shell*/ ))) {
this.state = 3;
if (true) break;
}
if (true) break;

case 3:
//C
this.state = 1;
RDebugUtils.currentLine=851972;
 //BA.debugLineNum = 851972;BA.debugLine="HandleOutAndErr(Shl.GetTempOut2(True), Shl.GetTe";
__ref._handleoutanderr /*String*/ (null,__ref._shl /*anywheresoftware.b4j.objects.Shell*/ .GetTempOut2(parent.__c.True),__ref._shl /*anywheresoftware.b4j.objects.Shell*/ .GetTempErr2(parent.__c.True));
RDebugUtils.currentLine=851973;
 //BA.debugLineNum = 851973;BA.debugLine="Sleep(50)";
parent.__c.Sleep(ba,new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pybridge", "shlreadloop"),(int) (50));
this.state = 5;
return;
case 5:
//C
this.state = 1;
;
 if (true) break;

case 4:
//C
this.state = -1;
;
RDebugUtils.currentLine=851975;
 //BA.debugLineNum = 851975;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public b4j.example.pywrapper  _slice(b4j.example.pybridge __ref,Object _startvalue,Object _stopvalue) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "slice", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "slice", new Object[] {_startvalue,_stopvalue}));}
RDebugUtils.currentLine=2228224;
 //BA.debugLineNum = 2228224;BA.debugLine="Public Sub Slice (StartValue As Object, StopValue";
RDebugUtils.currentLine=2228225;
 //BA.debugLineNum = 2228225;BA.debugLine="Return Builtins.RunArgs(\"slice\", Array(Utils.Conv";
if (true) return __ref._builtins /*b4j.example.pywrapper*/ ._runargs /*b4j.example.pywrapper*/ (null,"slice",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{__ref._utils /*b4j.example.pyutils*/ ._converttointifmatch /*Object*/ (null,_startvalue),__ref._utils /*b4j.example.pyutils*/ ._converttointifmatch /*Object*/ (null,_stopvalue)}),(anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(__c.Null)));
RDebugUtils.currentLine=2228226;
 //BA.debugLineNum = 2228226;BA.debugLine="End Sub";
return null;
}
public b4j.example.pywrapper  _sliceall(b4j.example.pybridge __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "sliceall", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "sliceall", null));}
RDebugUtils.currentLine=2293760;
 //BA.debugLineNum = 2293760;BA.debugLine="Public Sub SliceAll As PyWrapper";
RDebugUtils.currentLine=2293761;
 //BA.debugLineNum = 2293761;BA.debugLine="Return Slice(Null, Null)";
if (true) return __ref._slice /*b4j.example.pywrapper*/ (null,__c.Null,__c.Null);
RDebugUtils.currentLine=2293762;
 //BA.debugLineNum = 2293762;BA.debugLine="End Sub";
return null;
}
public String  _state_changed(b4j.example.pybridge __ref,int _oldstate,int _newstate) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "state_changed", true))
	 {return ((String) Debug.delegate(ba, "state_changed", new Object[] {_oldstate,_newstate}));}
RDebugUtils.currentLine=1114112;
 //BA.debugLineNum = 1114112;BA.debugLine="Private Sub State_Changed (OldState As Int, NewSta";
RDebugUtils.currentLine=1114113;
 //BA.debugLineNum = 1114113;BA.debugLine="If NewState = comm.STATE_CONNECTED Then";
if (_newstate==__ref._comm /*b4j.example.pycomm*/ ._state_connected /*int*/ ) { 
RDebugUtils.currentLine=1114114;
 //BA.debugLineNum = 1114114;BA.debugLine="AfterConnection";
__ref._afterconnection /*String*/ (null);
 }else {
RDebugUtils.currentLine=1114116;
 //BA.debugLineNum = 1114116;BA.debugLine="Utils.Disconnected";
__ref._utils /*b4j.example.pyutils*/ ._disconnected /*String*/ (null);
RDebugUtils.currentLine=1114117;
 //BA.debugLineNum = 1114117;BA.debugLine="KillProcess";
__ref._killprocess /*String*/ (null);
 };
RDebugUtils.currentLine=1114119;
 //BA.debugLineNum = 1114119;BA.debugLine="If NewState = comm.STATE_CONNECTED Or (OldState =";
if (_newstate==__ref._comm /*b4j.example.pycomm*/ ._state_connected /*int*/  || (_oldstate==__ref._comm /*b4j.example.pycomm*/ ._state_waiting_for_connection /*int*/  && _newstate==__ref._comm /*b4j.example.pycomm*/ ._state_disconnected /*int*/ )) { 
RDebugUtils.currentLine=1114120;
 //BA.debugLineNum = 1114120;BA.debugLine="CallSubDelayed2(mCallback, mEventName & \"_connec";
__c.CallSubDelayed2(ba,__ref._mcallback /*Object*/ ,__ref._meventname /*String*/ +"_connected",(Object)(_newstate==__ref._comm /*b4j.example.pycomm*/ ._state_connected /*int*/ ));
 }else 
{RDebugUtils.currentLine=1114121;
 //BA.debugLineNum = 1114121;BA.debugLine="Else if SubExists(mCallback, mEventName & \"_disco";
if (__c.SubExists(ba,__ref._mcallback /*Object*/ ,__ref._meventname /*String*/ +"_disconnected")) { 
RDebugUtils.currentLine=1114122;
 //BA.debugLineNum = 1114122;BA.debugLine="CallSubDelayed(mCallback, mEventName & \"_disconn";
__c.CallSubDelayed(ba,__ref._mcallback /*Object*/ ,__ref._meventname /*String*/ +"_disconnected");
 }}
;
RDebugUtils.currentLine=1114124;
 //BA.debugLineNum = 1114124;BA.debugLine="End Sub";
return "";
}
public String  _task_received(b4j.example.pybridge __ref,b4j.example.pybridge._pytask _task) throws Exception{
__ref = this;
RDebugUtils.currentModule="pybridge";
if (Debug.shouldDelegate(ba, "task_received", true))
	 {return ((String) Debug.delegate(ba, "task_received", new Object[] {_task}));}
String _eventname = "";
anywheresoftware.b4a.objects.collections.Map _params = null;
Object[] _cc = null;
RDebugUtils.currentLine=1310720;
 //BA.debugLineNum = 1310720;BA.debugLine="Private Sub Task_Received(TASK As PyTask)";
RDebugUtils.currentLine=1310721;
 //BA.debugLineNum = 1310721;BA.debugLine="If TASK.TaskType = Utils.TASK_TYPE_PING Then";
if (_task.TaskType /*int*/ ==__ref._utils /*b4j.example.pyutils*/ ._task_type_ping /*int*/ ) { 
RDebugUtils.currentLine=1310722;
 //BA.debugLineNum = 1310722;BA.debugLine="comm.SendTask(Utils.CreatePyTask(0, Utils.TASK_T";
__ref._comm /*b4j.example.pycomm*/ ._sendtask /*String*/ (null,__ref._utils /*b4j.example.pyutils*/ ._createpytask /*b4j.example.pybridge._pytask*/ (null,(int) (0),__ref._utils /*b4j.example.pyutils*/ ._task_type_ping /*int*/ ,anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{})));
 }else 
{RDebugUtils.currentLine=1310723;
 //BA.debugLineNum = 1310723;BA.debugLine="Else If TASK.TaskType <> Utils.TASK_TYPE_EVENT Th";
if (_task.TaskType /*int*/ !=__ref._utils /*b4j.example.pyutils*/ ._task_type_event /*int*/ ) { 
RDebugUtils.currentLine=1310724;
 //BA.debugLineNum = 1310724;BA.debugLine="LogError(\"Unexpected message: \" & TASK)";
__c.LogError("Unexpected message: "+BA.ObjectToString(_task));
 }else {
RDebugUtils.currentLine=1310726;
 //BA.debugLineNum = 1310726;BA.debugLine="Dim EventName As String = TASK.Extra.Get(0)";
_eventname = BA.ObjectToString(_task.Extra /*anywheresoftware.b4a.objects.collections.List*/ .Get((int) (0)));
RDebugUtils.currentLine=1310727;
 //BA.debugLineNum = 1310727;BA.debugLine="Dim Params As Map = TASK.Extra.Get(1)";
_params = new anywheresoftware.b4a.objects.collections.Map();
_params = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_task.Extra /*anywheresoftware.b4a.objects.collections.List*/ .Get((int) (1))));
RDebugUtils.currentLine=1310728;
 //BA.debugLineNum = 1310728;BA.debugLine="If EventMapper.ContainsKey(EventName) Then";
if (__ref._eventmapper /*anywheresoftware.b4a.objects.collections.Map*/ .ContainsKey((Object)(_eventname))) { 
RDebugUtils.currentLine=1310729;
 //BA.debugLineNum = 1310729;BA.debugLine="Dim cc() As Object = EventMapper.Get(EventName)";
_cc = (Object[])(__ref._eventmapper /*anywheresoftware.b4a.objects.collections.Map*/ .Get((Object)(_eventname)));
RDebugUtils.currentLine=1310730;
 //BA.debugLineNum = 1310730;BA.debugLine="CallSubDelayed2(cc(0), cc(1).As(String) & \"_\" &";
__c.CallSubDelayed2(ba,_cc[(int) (0)],(BA.ObjectToString(_cc[(int) (1)]))+"_"+_eventname,(Object)(_params));
 }else {
RDebugUtils.currentLine=1310732;
 //BA.debugLineNum = 1310732;BA.debugLine="CallSubDelayed2(mCallback, mEventName & \"_\" & E";
__c.CallSubDelayed2(ba,__ref._mcallback /*Object*/ ,__ref._meventname /*String*/ +"_"+_eventname,(Object)(_params));
 };
 }}
;
RDebugUtils.currentLine=1310735;
 //BA.debugLineNum = 1310735;BA.debugLine="End Sub";
return "";
}
}