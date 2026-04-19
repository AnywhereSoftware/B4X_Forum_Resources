package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class pyutils extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.pyutils", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.pyutils.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 
    public void  innerInitializeHelper(anywheresoftware.b4a.BA _ba) throws Exception{
        innerInitialize(_ba);
    }
    public Object callSub(String sub, Object sender, Object[] args) throws Exception {
        return BA.SubDelegator.SubNotFound;
    }
public anywheresoftware.b4a.keywords.Common __c = null;
public int _task_type_run = 0;
public int _task_type_get = 0;
public int _task_type_run_async = 0;
public int _task_type_clean = 0;
public int _task_type_error = 0;
public int _task_type_event = 0;
public int _task_type_ping = 0;
public int _task_type_flush = 0;
public String _pythonbridgecodeversion = "";
public String _pyoutprefix = "";
public String _pyerrprefix = "";
public String _b4jprefix = "";
public b4j.example.pywrapper _evalglobals = null;
public b4j.example.pywrapper _importlib = null;
public b4j.example.pybridge _mbridge = null;
public int _taskidcounter = 0;
public int _pyobjectcounter = 0;
public anywheresoftware.b4j.object.JavaObject _cleanerclass = null;
public int _cleanerindex = 0;
public b4j.example.pycomm _comm = null;
public b4j.example.pybridge._pyoptions _moptions = null;
public anywheresoftware.b4j.object.JavaObject _cleaner = null;
public b4j.example.b4xset _registeredmembers = null;
public double _epsilon = 0;
public anywheresoftware.b4a.objects.collections.List _keysthatneedtoberegistered = null;
public anywheresoftware.b4a.objects.collections.List _objectsthatneedtoberegistered = null;
public anywheresoftware.b4j.object.JavaObject _system = null;
public anywheresoftware.b4a.objects.collections.Map _memoryslots = null;
public int _lastmemorysize = 0;
public int _memory_increase_threshold = 0;
public String _packagename = "";
public b4j.example.pywrapper _io = null;
public b4j.example.main _main = null;
public b4j.example.b4xcollections _b4xcollections = null;
public b4j.example.pybridge._pyobject  _createpyobject(b4j.example.pyutils __ref,int _key) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "createpyobject", true))
	 {return ((b4j.example.pybridge._pyobject) Debug.delegate(ba, "createpyobject", new Object[] {_key}));}
b4j.example.pybridge._pyobject _t1 = null;
RDebugUtils.currentLine=5439488;
 //BA.debugLineNum = 5439488;BA.debugLine="Public Sub CreatePyObject (Key As Int) As PyObject";
RDebugUtils.currentLine=5439489;
 //BA.debugLineNum = 5439489;BA.debugLine="Dim t1 As PyObject";
_t1 = new b4j.example.pybridge._pyobject();
RDebugUtils.currentLine=5439490;
 //BA.debugLineNum = 5439490;BA.debugLine="t1.Initialize";
_t1.Initialize();
RDebugUtils.currentLine=5439491;
 //BA.debugLineNum = 5439491;BA.debugLine="If Key = 0 Then";
if (_key==0) { 
RDebugUtils.currentLine=5439492;
 //BA.debugLineNum = 5439492;BA.debugLine="PyObjectCounter = PyObjectCounter + 1";
__ref._pyobjectcounter /*int*/  = (int) (__ref._pyobjectcounter /*int*/ +1);
RDebugUtils.currentLine=5439493;
 //BA.debugLineNum = 5439493;BA.debugLine="Key = PyObjectCounter";
_key = __ref._pyobjectcounter /*int*/ ;
 };
RDebugUtils.currentLine=5439495;
 //BA.debugLineNum = 5439495;BA.debugLine="t1.Key = Key";
_t1.Key /*int*/  = _key;
RDebugUtils.currentLine=5439496;
 //BA.debugLineNum = 5439496;BA.debugLine="RegisterForCleaning(t1)";
__ref._registerforcleaning /*String*/ (null,_t1);
RDebugUtils.currentLine=5439497;
 //BA.debugLineNum = 5439497;BA.debugLine="Return t1";
if (true) return _t1;
RDebugUtils.currentLine=5439498;
 //BA.debugLineNum = 5439498;BA.debugLine="End Sub";
return null;
}
public String  _connected(b4j.example.pyutils __ref,b4j.example.pybridge._pyobject _vimportlib,b4j.example.pybridge._pyoptions _options) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "connected", true))
	 {return ((String) Debug.delegate(ba, "connected", new Object[] {_vimportlib,_options}));}
RDebugUtils.currentLine=4456448;
 //BA.debugLineNum = 4456448;BA.debugLine="Public Sub Connected (vImportLib As PyObject, opti";
RDebugUtils.currentLine=4456449;
 //BA.debugLineNum = 4456449;BA.debugLine="mOptions = options";
__ref._moptions /*b4j.example.pybridge._pyoptions*/  = _options;
RDebugUtils.currentLine=4456450;
 //BA.debugLineNum = 4456450;BA.debugLine="PyObjectCounter = 100";
__ref._pyobjectcounter /*int*/  = (int) (100);
RDebugUtils.currentLine=4456451;
 //BA.debugLineNum = 4456451;BA.debugLine="ImportLib.Initialize(mBridge, vImportLib)";
__ref._importlib /*b4j.example.pywrapper*/ ._initialize /*String*/ (null,ba,__ref._mbridge /*b4j.example.pybridge*/ ,_vimportlib);
RDebugUtils.currentLine=4456452;
 //BA.debugLineNum = 4456452;BA.debugLine="EvalGlobals = mBridge.Builtins.Run(\"dict\")";
__ref._evalglobals /*b4j.example.pywrapper*/  = __ref._mbridge /*b4j.example.pybridge*/ ._builtins /*b4j.example.pywrapper*/ ._run /*b4j.example.pywrapper*/ (null,"dict");
RDebugUtils.currentLine=4456453;
 //BA.debugLineNum = 4456453;BA.debugLine="RegisteredMembers.Initialize";
__ref._registeredmembers /*b4j.example.b4xset*/ ._initialize /*String*/ (null,ba);
RDebugUtils.currentLine=4456454;
 //BA.debugLineNum = 4456454;BA.debugLine="KeysThatNeedToBeRegistered.Clear";
__ref._keysthatneedtoberegistered /*anywheresoftware.b4a.objects.collections.List*/ .Clear();
RDebugUtils.currentLine=4456455;
 //BA.debugLineNum = 4456455;BA.debugLine="ObjectsThatNeedToBeRegistered.Clear";
__ref._objectsthatneedtoberegistered /*anywheresoftware.b4a.objects.collections.List*/ .Clear();
RDebugUtils.currentLine=4456456;
 //BA.debugLineNum = 4456456;BA.debugLine="MemorySlots.Clear";
__ref._memoryslots /*anywheresoftware.b4a.objects.collections.Map*/ .Clear();
RDebugUtils.currentLine=4456457;
 //BA.debugLineNum = 4456457;BA.debugLine="LastMemorySize = 0";
__ref._lastmemorysize /*int*/  = (int) (0);
RDebugUtils.currentLine=4456458;
 //BA.debugLineNum = 4456458;BA.debugLine="CheckKeysNeedToBeCleaned";
__ref._checkkeysneedtobecleaned /*void*/ (null);
RDebugUtils.currentLine=4456459;
 //BA.debugLineNum = 4456459;BA.debugLine="AddConverters";
__ref._addconverters /*String*/ (null);
RDebugUtils.currentLine=4456460;
 //BA.debugLineNum = 4456460;BA.debugLine="End Sub";
return "";
}
public String  _detectos(b4j.example.pyutils __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "detectos", true))
	 {return ((String) Debug.delegate(ba, "detectos", null));}
String _os = "";
RDebugUtils.currentLine=6094848;
 //BA.debugLineNum = 6094848;BA.debugLine="Public Sub DetectOS As String";
RDebugUtils.currentLine=6094849;
 //BA.debugLineNum = 6094849;BA.debugLine="Dim os As String = GetSystemProperty(\"os.name\", \"";
_os = __c.GetSystemProperty("os.name","").toLowerCase(anywheresoftware.b4a.keywords.Common.stringLocale);
RDebugUtils.currentLine=6094850;
 //BA.debugLineNum = 6094850;BA.debugLine="If os.Contains(\"win\") Then";
if (_os.contains("win")) { 
RDebugUtils.currentLine=6094851;
 //BA.debugLineNum = 6094851;BA.debugLine="Return \"windows\"";
if (true) return "windows";
 }else 
{RDebugUtils.currentLine=6094852;
 //BA.debugLineNum = 6094852;BA.debugLine="Else If os.Contains(\"mac\") Then";
if (_os.contains("mac")) { 
RDebugUtils.currentLine=6094853;
 //BA.debugLineNum = 6094853;BA.debugLine="Return \"mac\"";
if (true) return "mac";
 }else {
RDebugUtils.currentLine=6094855;
 //BA.debugLineNum = 6094855;BA.debugLine="Return \"linux\"";
if (true) return "linux";
 }}
;
RDebugUtils.currentLine=6094857;
 //BA.debugLineNum = 6094857;BA.debugLine="End Sub";
return "";
}
public b4j.example.pywrapper  _convertlambdaifmatch(b4j.example.pyutils __ref,Object _o) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "convertlambdaifmatch", true))
	 {return ((b4j.example.pywrapper) Debug.delegate(ba, "convertlambdaifmatch", new Object[] {_o}));}
RDebugUtils.currentLine=5963776;
 //BA.debugLineNum = 5963776;BA.debugLine="Public Sub ConvertLambdaIfMatch (o As Object) As P";
RDebugUtils.currentLine=5963777;
 //BA.debugLineNum = 5963777;BA.debugLine="If o Is PyWrapper Then Return o";
if (_o instanceof b4j.example.pywrapper) { 
if (true) return (b4j.example.pywrapper)(_o);};
RDebugUtils.currentLine=5963778;
 //BA.debugLineNum = 5963778;BA.debugLine="Return mBridge.RunStatement(o)";
if (true) return __ref._mbridge /*b4j.example.pybridge*/ ._runstatement /*b4j.example.pywrapper*/ (null,BA.ObjectToString(_o));
RDebugUtils.currentLine=5963779;
 //BA.debugLineNum = 5963779;BA.debugLine="End Sub";
return null;
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _flush(b4j.example.pyutils __ref) throws Exception{
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "flush", true))
	 {return ((anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) Debug.delegate(ba, "flush", null));}
ResumableSub_Flush rsub = new ResumableSub_Flush(this,__ref);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_Flush extends BA.ResumableSub {
public ResumableSub_Flush(b4j.example.pyutils parent,b4j.example.pyutils __ref) {
this.parent = parent;
this.__ref = __ref;
this.__ref = parent;
}
b4j.example.pyutils __ref;
b4j.example.pyutils parent;
b4j.example.pybridge._pytask _task = null;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="pyutils";

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.ReturnFromResumableSub(this,null);return;}
case 0:
//C
this.state = 1;
RDebugUtils.currentLine=5177345;
 //BA.debugLineNum = 5177345;BA.debugLine="Dim task As PyTask = CreatePyTask(0, TASK_TYPE_FL";
_task = __ref._createpytask /*b4j.example.pybridge._pytask*/ (null,(int) (0),__ref._task_type_flush /*int*/ ,anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{}));
RDebugUtils.currentLine=5177346;
 //BA.debugLineNum = 5177346;BA.debugLine="Comm.SendTaskAndWait(task)";
__ref._comm /*b4j.example.pycomm*/ ._sendtaskandwait /*String*/ (null,_task);
RDebugUtils.currentLine=5177347;
 //BA.debugLineNum = 5177347;BA.debugLine="Wait For (task) AsyncTask_Received (task As PyTas";
parent.__c.WaitFor("asynctask_received", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pyutils", "flush"), (Object)(_task));
this.state = 7;
return;
case 7:
//C
this.state = 1;
_task = (b4j.example.pybridge._pytask) result[1];
;
RDebugUtils.currentLine=5177348;
 //BA.debugLineNum = 5177348;BA.debugLine="If task.TaskType = TASK_TYPE_ERROR Then";
if (true) break;

case 1:
//if
this.state = 6;
if (_task.TaskType /*int*/ ==__ref._task_type_error /*int*/ ) { 
this.state = 3;
}else {
this.state = 5;
}if (true) break;

case 3:
//C
this.state = 6;
RDebugUtils.currentLine=5177349;
 //BA.debugLineNum = 5177349;BA.debugLine="mBridge.PyLastException = task.Extra.Get(0)";
__ref._mbridge /*b4j.example.pybridge*/ ._pylastexception /*String*/  = BA.ObjectToString(_task.Extra /*anywheresoftware.b4a.objects.collections.List*/ .Get((int) (0)));
RDebugUtils.currentLine=5177350;
 //BA.debugLineNum = 5177350;BA.debugLine="Return False";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.False));return;};
 if (true) break;

case 5:
//C
this.state = 6;
RDebugUtils.currentLine=5177352;
 //BA.debugLineNum = 5177352;BA.debugLine="Return True";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.True));return;};
 if (true) break;

case 6:
//C
this.state = -1;
;
RDebugUtils.currentLine=5177354;
 //BA.debugLineNum = 5177354;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public String  _pylog(b4j.example.pyutils __ref,String _prefix,int _clr,Object _o) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "pylog", true))
	 {return ((String) Debug.delegate(ba, "pylog", new Object[] {_prefix,_clr,_o}));}
String _s = "";
String[] _lines = null;
String _line = "";
RDebugUtils.currentLine=5308416;
 //BA.debugLineNum = 5308416;BA.debugLine="Public Sub PyLog(Prefix As String, Clr As Int, O A";
RDebugUtils.currentLine=5308418;
 //BA.debugLineNum = 5308418;BA.debugLine="If o Is PyWrapper Then";
if (_o instanceof b4j.example.pywrapper) { 
RDebugUtils.currentLine=5308419;
 //BA.debugLineNum = 5308419;BA.debugLine="mBridge.PrintJoin(Array(o), Clr = mOptions.PyErr";
__ref._mbridge /*b4j.example.pybridge*/ ._printjoin /*String*/ (null,anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{_o}),_clr==__ref._moptions /*b4j.example.pybridge._pyoptions*/ .PyErrColor /*int*/ );
 }else {
RDebugUtils.currentLine=5308421;
 //BA.debugLineNum = 5308421;BA.debugLine="Dim s As String = o";
_s = BA.ObjectToString(_o);
RDebugUtils.currentLine=5308422;
 //BA.debugLineNum = 5308422;BA.debugLine="If s.Length > 3900 Then";
if (_s.length()>3900) { 
RDebugUtils.currentLine=5308423;
 //BA.debugLineNum = 5308423;BA.debugLine="s = s.SubString2(0, 3900) & CRLF & \"(message tr";
_s = _s.substring((int) (0),(int) (3900))+__c.CRLF+"(message truncated)";
 };
RDebugUtils.currentLine=5308425;
 //BA.debugLineNum = 5308425;BA.debugLine="s = s.Trim.Replace(Chr(13), \"\")";
_s = _s.trim().replace(BA.ObjectToString(__c.Chr((int) (13))),"");
RDebugUtils.currentLine=5308426;
 //BA.debugLineNum = 5308426;BA.debugLine="Dim lines() As String = Regex.Split(\"\\n+\", s)";
_lines = __c.Regex.Split("\\n+",_s);
RDebugUtils.currentLine=5308427;
 //BA.debugLineNum = 5308427;BA.debugLine="For Each line As String In lines";
{
final String[] group10 = _lines;
final int groupLen10 = group10.length
;int index10 = 0;
;
for (; index10 < groupLen10;index10++){
_line = group10[index10];
RDebugUtils.currentLine=5308428;
 //BA.debugLineNum = 5308428;BA.debugLine="line = line.Trim";
_line = _line.trim();
RDebugUtils.currentLine=5308429;
 //BA.debugLineNum = 5308429;BA.debugLine="If line.StartsWith(\"~de:\") Then";
if (_line.startsWith("~de:")) { 
RDebugUtils.currentLine=5308430;
 //BA.debugLineNum = 5308430;BA.debugLine="mBridge.ErrorHandler.UntangleError(line)";
__ref._mbridge /*b4j.example.pybridge*/ ._errorhandler /*b4j.example.pyerrorhandler*/ ._untangleerror /*String*/ (null,_line);
 }else 
{RDebugUtils.currentLine=5308431;
 //BA.debugLineNum = 5308431;BA.debugLine="Else If Clr <> 0 Then";
if (_clr!=0) { 
RDebugUtils.currentLine=5308432;
 //BA.debugLineNum = 5308432;BA.debugLine="If Comm.State = Comm.STATE_DISCONNECTED And li";
if (__ref._comm /*b4j.example.pycomm*/ ._state /*int*/ ==__ref._comm /*b4j.example.pycomm*/ ._state_disconnected /*int*/  && _line.startsWith("Unhandled exception in task")) { 
RDebugUtils.currentLine=5308433;
 //BA.debugLineNum = 5308433;BA.debugLine="Return";
if (true) return "";
 };
RDebugUtils.currentLine=5308435;
 //BA.debugLineNum = 5308435;BA.debugLine="LogColor(Prefix & line, Clr)";
__c.LogImpl("95308435",_prefix+_line,_clr);
 }else {
RDebugUtils.currentLine=5308437;
 //BA.debugLineNum = 5308437;BA.debugLine="Log(Prefix & line)";
__c.LogImpl("95308437",_prefix+_line,0);
 }}
;
 }
};
 };
RDebugUtils.currentLine=5308442;
 //BA.debugLineNum = 5308442;BA.debugLine="End Sub";
return "";
}
public String  _initialize(b4j.example.pyutils __ref,anywheresoftware.b4a.BA _ba,b4j.example.pybridge _bridge,b4j.example.pycomm _vcomm) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "initialize", true))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba,_bridge,_vcomm}));}
RDebugUtils.currentLine=4390912;
 //BA.debugLineNum = 4390912;BA.debugLine="Public Sub Initialize (bridge As PyBridge, vComm A";
RDebugUtils.currentLine=4390913;
 //BA.debugLineNum = 4390913;BA.debugLine="mBridge = bridge";
__ref._mbridge /*b4j.example.pybridge*/  = _bridge;
RDebugUtils.currentLine=4390914;
 //BA.debugLineNum = 4390914;BA.debugLine="CleanerClass = CleanerClass.InitializeStatic(GetT";
__ref._cleanerclass /*anywheresoftware.b4j.object.JavaObject*/  = __ref._cleanerclass /*anywheresoftware.b4j.object.JavaObject*/ .InitializeStatic(__c.GetType(this)+"$CleanRunnable");
RDebugUtils.currentLine=4390915;
 //BA.debugLineNum = 4390915;BA.debugLine="cleaner = cleaner.InitializeStatic(\"java.lang.ref";
__ref._cleaner /*anywheresoftware.b4j.object.JavaObject*/  = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(__ref._cleaner /*anywheresoftware.b4j.object.JavaObject*/ .InitializeStatic("java.lang.ref.Cleaner").RunMethod("create",(Object[])(__c.Null))));
RDebugUtils.currentLine=4390916;
 //BA.debugLineNum = 4390916;BA.debugLine="System.InitializeStatic(\"System\")";
__ref._system /*anywheresoftware.b4j.object.JavaObject*/ .InitializeStatic("System");
RDebugUtils.currentLine=4390917;
 //BA.debugLineNum = 4390917;BA.debugLine="PackageName = GetType(Me)";
__ref._packagename /*String*/  = __c.GetType(this);
RDebugUtils.currentLine=4390918;
 //BA.debugLineNum = 4390918;BA.debugLine="PackageName = PackageName.SubString2(0, PackageNa";
__ref._packagename /*String*/  = __ref._packagename /*String*/ .substring((int) (0),(int) (__ref._packagename /*String*/ .length()-".pyutils".length()));
RDebugUtils.currentLine=4390919;
 //BA.debugLineNum = 4390919;BA.debugLine="KeysThatNeedToBeRegistered.Initialize";
__ref._keysthatneedtoberegistered /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=4390920;
 //BA.debugLineNum = 4390920;BA.debugLine="ObjectsThatNeedToBeRegistered.Initialize";
__ref._objectsthatneedtoberegistered /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=4390921;
 //BA.debugLineNum = 4390921;BA.debugLine="MemorySlots.Initialize";
__ref._memoryslots /*anywheresoftware.b4a.objects.collections.Map*/ .Initialize();
RDebugUtils.currentLine=4390922;
 //BA.debugLineNum = 4390922;BA.debugLine="If GetSystemProperty(\"b4j.ide\", False) = True The";
if ((__c.GetSystemProperty("b4j.ide",BA.ObjectToString(__c.False))).equals(BA.ObjectToString(__c.True))) { 
RDebugUtils.currentLine=4390923;
 //BA.debugLineNum = 4390923;BA.debugLine="PyErrPrefix = \"\"";
__ref._pyerrprefix /*String*/  = "";
RDebugUtils.currentLine=4390924;
 //BA.debugLineNum = 4390924;BA.debugLine="PyOutPrefix = \"\"";
__ref._pyoutprefix /*String*/  = "";
RDebugUtils.currentLine=4390925;
 //BA.debugLineNum = 4390925;BA.debugLine="B4JPrefix = \"\"";
__ref._b4jprefix /*String*/  = "";
 };
RDebugUtils.currentLine=4390927;
 //BA.debugLineNum = 4390927;BA.debugLine="End Sub";
return "";
}
public Object  _converttointifmatch(b4j.example.pyutils __ref,Object _o) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "converttointifmatch", true))
	 {return ((Object) Debug.delegate(ba, "converttointifmatch", new Object[] {_o}));}
double _d = 0;
int _i = 0;
RDebugUtils.currentLine=5898240;
 //BA.debugLineNum = 5898240;BA.debugLine="Public Sub ConvertToIntIfMatch (o As Object) As Ob";
RDebugUtils.currentLine=5898241;
 //BA.debugLineNum = 5898241;BA.debugLine="If o Is Float Or o Is Double Then";
if (_o instanceof Float || _o instanceof Double) { 
RDebugUtils.currentLine=5898242;
 //BA.debugLineNum = 5898242;BA.debugLine="Dim d As Double = o";
_d = (double)(BA.ObjectToNumber(_o));
RDebugUtils.currentLine=5898243;
 //BA.debugLineNum = 5898243;BA.debugLine="Dim i As Int = d";
_i = (int) (_d);
RDebugUtils.currentLine=5898244;
 //BA.debugLineNum = 5898244;BA.debugLine="If Abs(d - i) < Epsilon Then Return i";
if (__c.Abs(_d-_i)<__ref._epsilon /*double*/ ) { 
if (true) return (Object)(_i);};
 };
RDebugUtils.currentLine=5898246;
 //BA.debugLineNum = 5898246;BA.debugLine="Return o";
if (true) return _o;
RDebugUtils.currentLine=5898247;
 //BA.debugLineNum = 5898247;BA.debugLine="End Sub";
return null;
}
public String  _disconnected(b4j.example.pyutils __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "disconnected", true))
	 {return ((String) Debug.delegate(ba, "disconnected", null));}
RDebugUtils.currentLine=4587520;
 //BA.debugLineNum = 4587520;BA.debugLine="Public Sub Disconnected";
RDebugUtils.currentLine=4587521;
 //BA.debugLineNum = 4587521;BA.debugLine="CleanerIndex = CleanerIndex + 1";
__ref._cleanerindex /*int*/  = (int) (__ref._cleanerindex /*int*/ +1);
RDebugUtils.currentLine=4587522;
 //BA.debugLineNum = 4587522;BA.debugLine="End Sub";
return "";
}
public b4j.example.pybridge._pytask  _createpytask(b4j.example.pyutils __ref,int _taskid,int _tasktype,anywheresoftware.b4a.objects.collections.List _extra) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "createpytask", true))
	 {return ((b4j.example.pybridge._pytask) Debug.delegate(ba, "createpytask", new Object[] {_taskid,_tasktype,_extra}));}
b4j.example.pybridge._pytask _t1 = null;
RDebugUtils.currentLine=5373952;
 //BA.debugLineNum = 5373952;BA.debugLine="Public Sub CreatePyTask (TaskId As Int, TaskType A";
RDebugUtils.currentLine=5373953;
 //BA.debugLineNum = 5373953;BA.debugLine="Dim t1 As PyTask";
_t1 = new b4j.example.pybridge._pytask();
RDebugUtils.currentLine=5373954;
 //BA.debugLineNum = 5373954;BA.debugLine="t1.Initialize";
_t1.Initialize();
RDebugUtils.currentLine=5373955;
 //BA.debugLineNum = 5373955;BA.debugLine="If TaskId = 0 Then";
if (_taskid==0) { 
RDebugUtils.currentLine=5373956;
 //BA.debugLineNum = 5373956;BA.debugLine="TaskIdCounter = TaskIdCounter + 1";
__ref._taskidcounter /*int*/  = (int) (__ref._taskidcounter /*int*/ +1);
RDebugUtils.currentLine=5373957;
 //BA.debugLineNum = 5373957;BA.debugLine="TaskId = TaskIdCounter";
_taskid = __ref._taskidcounter /*int*/ ;
 };
RDebugUtils.currentLine=5373959;
 //BA.debugLineNum = 5373959;BA.debugLine="t1.TaskId = TaskId";
_t1.TaskId /*int*/  = _taskid;
RDebugUtils.currentLine=5373960;
 //BA.debugLineNum = 5373960;BA.debugLine="t1.TaskType = TaskType";
_t1.TaskType /*int*/  = _tasktype;
RDebugUtils.currentLine=5373961;
 //BA.debugLineNum = 5373961;BA.debugLine="t1.Extra = Extra";
_t1.Extra /*anywheresoftware.b4a.objects.collections.List*/  = _extra;
RDebugUtils.currentLine=5373962;
 //BA.debugLineNum = 5373962;BA.debugLine="Return t1";
if (true) return _t1;
RDebugUtils.currentLine=5373963;
 //BA.debugLineNum = 5373963;BA.debugLine="End Sub";
return null;
}
public String  _unwrapbeforeserialization(b4j.example.pyutils __ref,anywheresoftware.b4a.objects.collections.List _extra) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "unwrapbeforeserialization", true))
	 {return ((String) Debug.delegate(ba, "unwrapbeforeserialization", new Object[] {_extra}));}
RDebugUtils.currentLine=4849664;
 //BA.debugLineNum = 4849664;BA.debugLine="Public Sub UnwrapBeforeSerialization (Extra As Lis";
RDebugUtils.currentLine=4849665;
 //BA.debugLineNum = 4849665;BA.debugLine="UnwrapList(Extra.Get(2))";
__ref._unwraplist /*String*/ (null,(anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_extra.Get((int) (2)))));
RDebugUtils.currentLine=4849666;
 //BA.debugLineNum = 4849666;BA.debugLine="UnwrapMap(Extra.Get(3))";
__ref._unwrapmap /*String*/ (null,(anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_extra.Get((int) (3)))));
RDebugUtils.currentLine=4849667;
 //BA.debugLineNum = 4849667;BA.debugLine="End Sub";
return "";
}
public String  _addconverters(b4j.example.pyutils __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "addconverters", true))
	 {return ((String) Debug.delegate(ba, "addconverters", null));}
b4j.example.pywrapper _converters = null;
RDebugUtils.currentLine=4521984;
 //BA.debugLineNum = 4521984;BA.debugLine="Private Sub AddConverters";
RDebugUtils.currentLine=4521985;
 //BA.debugLineNum = 4521985;BA.debugLine="IO = mBridge.ImportModule(\"io\")";
__ref._io /*b4j.example.pywrapper*/  = __ref._mbridge /*b4j.example.pybridge*/ ._importmodule /*b4j.example.pywrapper*/ (null,"io");
RDebugUtils.currentLine=4521986;
 //BA.debugLineNum = 4521986;BA.debugLine="Dim converters As PyWrapper = mBridge.Bridge.GetF";
_converters = __ref._mbridge /*b4j.example.pybridge*/ ._bridge /*b4j.example.pywrapper*/ ._getfield /*b4j.example.pywrapper*/ (null,"comm")._getfield /*b4j.example.pywrapper*/ (null,"serializator")._getfield /*b4j.example.pywrapper*/ (null,"converters");
RDebugUtils.currentLine=4521987;
 //BA.debugLineNum = 4521987;BA.debugLine="converters.Set(IO.GetField(\"BytesIO\"), mBridge.La";
_converters._set /*String*/ (null,(Object)(__ref._io /*b4j.example.pywrapper*/ ._getfield /*b4j.example.pywrapper*/ (null,"BytesIO")),(Object)(__ref._mbridge /*b4j.example.pybridge*/ ._lambda /*b4j.example.pywrapper*/ (null,"x: x.getvalue()")));
RDebugUtils.currentLine=4521988;
 //BA.debugLineNum = 4521988;BA.debugLine="mBridge.RunNoArgsCode(\"from b4x_bridge.bridge imp";
__ref._mbridge /*b4j.example.pybridge*/ ._runnoargscode /*String*/ (null,"from b4x_bridge.bridge import bridge_instance");
RDebugUtils.currentLine=4521989;
 //BA.debugLineNum = 4521989;BA.debugLine="End Sub";
return "";
}
public b4j.example.pybridge._internalpytaskasyncresult  _checkforerrorsandreturn(b4j.example.pyutils __ref,b4j.example.pybridge._pytask _task,b4j.example.pybridge._pyobject _pyobject) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "checkforerrorsandreturn", true))
	 {return ((b4j.example.pybridge._internalpytaskasyncresult) Debug.delegate(ba, "checkforerrorsandreturn", new Object[] {_task,_pyobject}));}
RDebugUtils.currentLine=5505024;
 //BA.debugLineNum = 5505024;BA.debugLine="Private Sub CheckForErrorsAndReturn (TASK As PyTas";
RDebugUtils.currentLine=5505026;
 //BA.debugLineNum = 5505026;BA.debugLine="Return CreateInternalPyTaskAsyncResult(PyObject,";
if (true) return __ref._createinternalpytaskasyncresult /*b4j.example.pybridge._internalpytaskasyncresult*/ (null,_pyobject,_task.Extra /*anywheresoftware.b4a.objects.collections.List*/ .Get((int) (0)),_task.TaskType /*int*/ ==__ref._task_type_error /*int*/ );
RDebugUtils.currentLine=5505027;
 //BA.debugLineNum = 5505027;BA.debugLine="End Sub";
return null;
}
public b4j.example.pybridge._internalpytaskasyncresult  _createinternalpytaskasyncresult(b4j.example.pyutils __ref,b4j.example.pybridge._pyobject _pyobject,Object _value,boolean _error) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "createinternalpytaskasyncresult", true))
	 {return ((b4j.example.pybridge._internalpytaskasyncresult) Debug.delegate(ba, "createinternalpytaskasyncresult", new Object[] {_pyobject,_value,_error}));}
b4j.example.pybridge._internalpytaskasyncresult _t1 = null;
RDebugUtils.currentLine=6029312;
 //BA.debugLineNum = 6029312;BA.debugLine="Private Sub CreateInternalPyTaskAsyncResult (PyObj";
RDebugUtils.currentLine=6029313;
 //BA.debugLineNum = 6029313;BA.debugLine="Dim t1 As InternalPyTaskAsyncResult";
_t1 = new b4j.example.pybridge._internalpytaskasyncresult();
RDebugUtils.currentLine=6029314;
 //BA.debugLineNum = 6029314;BA.debugLine="t1.Initialize";
_t1.Initialize();
RDebugUtils.currentLine=6029315;
 //BA.debugLineNum = 6029315;BA.debugLine="t1.PyObject = PyObject";
_t1.PyObject /*b4j.example.pybridge._pyobject*/  = _pyobject;
RDebugUtils.currentLine=6029316;
 //BA.debugLineNum = 6029316;BA.debugLine="t1.Value = Value";
_t1.Value /*Object*/  = _value;
RDebugUtils.currentLine=6029317;
 //BA.debugLineNum = 6029317;BA.debugLine="t1.Error = Error";
_t1.Error /*boolean*/  = _error;
RDebugUtils.currentLine=6029318;
 //BA.debugLineNum = 6029318;BA.debugLine="Return t1";
if (true) return _t1;
RDebugUtils.currentLine=6029319;
 //BA.debugLineNum = 6029319;BA.debugLine="End Sub";
return null;
}
public void  _checkkeysneedtobecleaned(b4j.example.pyutils __ref) throws Exception{
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "checkkeysneedtobecleaned", true))
	 {Debug.delegate(ba, "checkkeysneedtobecleaned", null); return;}
ResumableSub_CheckKeysNeedToBeCleaned rsub = new ResumableSub_CheckKeysNeedToBeCleaned(this,__ref);
rsub.resume(ba, null);
}
public static class ResumableSub_CheckKeysNeedToBeCleaned extends BA.ResumableSub {
public ResumableSub_CheckKeysNeedToBeCleaned(b4j.example.pyutils parent,b4j.example.pyutils __ref) {
this.parent = parent;
this.__ref = __ref;
this.__ref = parent;
}
b4j.example.pyutils __ref;
b4j.example.pyutils parent;
int _myindex = 0;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="pyutils";

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
RDebugUtils.currentLine=5636097;
 //BA.debugLineNum = 5636097;BA.debugLine="CleanerClass.RunMethod(\"getKeys\", Null) 'clear an";
__ref._cleanerclass /*anywheresoftware.b4j.object.JavaObject*/ .RunMethod("getKeys",(Object[])(parent.__c.Null));
RDebugUtils.currentLine=5636098;
 //BA.debugLineNum = 5636098;BA.debugLine="CleanerIndex = CleanerIndex + 1";
__ref._cleanerindex /*int*/  = (int) (__ref._cleanerindex /*int*/ +1);
RDebugUtils.currentLine=5636099;
 //BA.debugLineNum = 5636099;BA.debugLine="Dim MyIndex As Int = CleanerIndex";
_myindex = __ref._cleanerindex /*int*/ ;
RDebugUtils.currentLine=5636100;
 //BA.debugLineNum = 5636100;BA.debugLine="CleanerClass.SetField(\"currentCleanerIndex\", MyIn";
__ref._cleanerclass /*anywheresoftware.b4j.object.JavaObject*/ .SetField("currentCleanerIndex",(Object)(_myindex));
RDebugUtils.currentLine=5636101;
 //BA.debugLineNum = 5636101;BA.debugLine="Do While MyIndex = CleanerIndex";
if (true) break;

case 1:
//do while
this.state = 4;
while (_myindex==__ref._cleanerindex /*int*/ ) {
this.state = 3;
if (true) break;
}
if (true) break;

case 3:
//C
this.state = 1;
RDebugUtils.currentLine=5636102;
 //BA.debugLineNum = 5636102;BA.debugLine="KeysImpl";
__ref._keysimpl /*String*/ (null);
RDebugUtils.currentLine=5636103;
 //BA.debugLineNum = 5636103;BA.debugLine="Sleep(200)";
parent.__c.Sleep(ba,new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pyutils", "checkkeysneedtobecleaned"),(int) (200));
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
RDebugUtils.currentLine=5636105;
 //BA.debugLineNum = 5636105;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public String  _keysimpl(b4j.example.pyutils __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "keysimpl", true))
	 {return ((String) Debug.delegate(ba, "keysimpl", null));}
anywheresoftware.b4a.objects.collections.List _keys = null;
int _key = 0;
RDebugUtils.currentLine=5701632;
 //BA.debugLineNum = 5701632;BA.debugLine="Private Sub KeysImpl";
RDebugUtils.currentLine=5701633;
 //BA.debugLineNum = 5701633;BA.debugLine="Dim keys As List = CleanerClass.RunMethod(\"getKey";
_keys = new anywheresoftware.b4a.objects.collections.List();
_keys = (anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(__ref._cleanerclass /*anywheresoftware.b4j.object.JavaObject*/ .RunMethod("getKeys",(Object[])(__c.Null))));
RDebugUtils.currentLine=5701634;
 //BA.debugLineNum = 5701634;BA.debugLine="If keys.Size > 0 Then";
if (_keys.getSize()>0) { 
RDebugUtils.currentLine=5701635;
 //BA.debugLineNum = 5701635;BA.debugLine="Comm.SendTask(CreatePyTask(0, TASK_TYPE_CLEAN, k";
__ref._comm /*b4j.example.pycomm*/ ._sendtask /*String*/ (null,__ref._createpytask /*b4j.example.pybridge._pytask*/ (null,(int) (0),__ref._task_type_clean /*int*/ ,_keys));
RDebugUtils.currentLine=5701636;
 //BA.debugLineNum = 5701636;BA.debugLine="For Each key As Int In keys";
{
final anywheresoftware.b4a.BA.IterableList group4 = _keys;
final int groupLen4 = group4.getSize()
;int index4 = 0;
;
for (; index4 < groupLen4;index4++){
_key = (int)(BA.ObjectToNumber(group4.Get(index4)));
RDebugUtils.currentLine=5701637;
 //BA.debugLineNum = 5701637;BA.debugLine="MemorySlots.Remove(key)";
__ref._memoryslots /*anywheresoftware.b4a.objects.collections.Map*/ .Remove((Object)(_key));
 }
};
RDebugUtils.currentLine=5701639;
 //BA.debugLineNum = 5701639;BA.debugLine="LastMemorySize = MemorySlots.Size";
__ref._lastmemorysize /*int*/  = __ref._memoryslots /*anywheresoftware.b4a.objects.collections.Map*/ .getSize();
 };
RDebugUtils.currentLine=5701641;
 //BA.debugLineNum = 5701641;BA.debugLine="RegisterKeys";
__ref._registerkeys /*String*/ (null);
RDebugUtils.currentLine=5701642;
 //BA.debugLineNum = 5701642;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4j.example.pyutils __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
RDebugUtils.currentLine=4325376;
 //BA.debugLineNum = 4325376;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=4325377;
 //BA.debugLineNum = 4325377;BA.debugLine="Public TASK_TYPE_RUN = 1, TASK_TYPE_GET = 2, TASK";
_task_type_run = (int) (1);
_task_type_get = (int) (2);
_task_type_run_async = (int) (3);
_task_type_clean = (int) (4);
_task_type_error = (int) (5);
_task_type_event = (int) (6);
_task_type_ping = (int) (7);
_task_type_flush = (int) (8);
RDebugUtils.currentLine=4325380;
 //BA.debugLineNum = 4325380;BA.debugLine="Public PythonBridgeCodeVersion As String = \"1.00\"";
_pythonbridgecodeversion = "1.00";
RDebugUtils.currentLine=4325381;
 //BA.debugLineNum = 4325381;BA.debugLine="Public PyOutPrefix = \"(pyout) \", PyErrPrefix = \"(";
_pyoutprefix = "(pyout) ";
_pyerrprefix = "(pyerr) ";
_b4jprefix = "(b4j) ";
RDebugUtils.currentLine=4325382;
 //BA.debugLineNum = 4325382;BA.debugLine="Public EvalGlobals As PyWrapper";
_evalglobals = new b4j.example.pywrapper();
RDebugUtils.currentLine=4325383;
 //BA.debugLineNum = 4325383;BA.debugLine="Public ImportLib As PyWrapper";
_importlib = new b4j.example.pywrapper();
RDebugUtils.currentLine=4325385;
 //BA.debugLineNum = 4325385;BA.debugLine="Private mBridge As PyBridge";
_mbridge = new b4j.example.pybridge();
RDebugUtils.currentLine=4325386;
 //BA.debugLineNum = 4325386;BA.debugLine="Public TaskIdCounter, PyObjectCounter As Int";
_taskidcounter = 0;
_pyobjectcounter = 0;
RDebugUtils.currentLine=4325387;
 //BA.debugLineNum = 4325387;BA.debugLine="Public CleanerClass As JavaObject";
_cleanerclass = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=4325388;
 //BA.debugLineNum = 4325388;BA.debugLine="Public CleanerIndex As Int";
_cleanerindex = 0;
RDebugUtils.currentLine=4325389;
 //BA.debugLineNum = 4325389;BA.debugLine="Public Comm As PyComm";
_comm = new b4j.example.pycomm();
RDebugUtils.currentLine=4325390;
 //BA.debugLineNum = 4325390;BA.debugLine="Public mOptions As PyOptions";
_moptions = new b4j.example.pybridge._pyoptions();
RDebugUtils.currentLine=4325391;
 //BA.debugLineNum = 4325391;BA.debugLine="Public cleaner As JavaObject";
_cleaner = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=4325392;
 //BA.debugLineNum = 4325392;BA.debugLine="Public RegisteredMembers As B4XSet";
_registeredmembers = new b4j.example.b4xset();
RDebugUtils.currentLine=4325393;
 //BA.debugLineNum = 4325393;BA.debugLine="Public Epsilon As Double = 0.0000001";
_epsilon = 0.0000001;
RDebugUtils.currentLine=4325394;
 //BA.debugLineNum = 4325394;BA.debugLine="Private KeysThatNeedToBeRegistered As List";
_keysthatneedtoberegistered = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=4325395;
 //BA.debugLineNum = 4325395;BA.debugLine="Private ObjectsThatNeedToBeRegistered As List";
_objectsthatneedtoberegistered = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=4325396;
 //BA.debugLineNum = 4325396;BA.debugLine="Private System As JavaObject";
_system = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=4325397;
 //BA.debugLineNum = 4325397;BA.debugLine="Private MemorySlots As Map";
_memoryslots = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=4325398;
 //BA.debugLineNum = 4325398;BA.debugLine="Private LastMemorySize As Int";
_lastmemorysize = 0;
RDebugUtils.currentLine=4325399;
 //BA.debugLineNum = 4325399;BA.debugLine="Public MEMORY_INCREASE_THRESHOLD As Int = 500000";
_memory_increase_threshold = (int) (500000);
RDebugUtils.currentLine=4325400;
 //BA.debugLineNum = 4325400;BA.debugLine="Public PackageName As String";
_packagename = "";
RDebugUtils.currentLine=4325401;
 //BA.debugLineNum = 4325401;BA.debugLine="Public IO As PyWrapper";
_io = new b4j.example.pywrapper();
RDebugUtils.currentLine=4325402;
 //BA.debugLineNum = 4325402;BA.debugLine="End Sub";
return "";
}
public Object[]  _createextra(b4j.example.pyutils __ref,b4j.example.pybridge._pyobject _target,String _method,b4j.example.pybridge._internalpymethodargs _args,b4j.example.pybridge._pyobject _res) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "createextra", true))
	 {return ((Object[]) Debug.delegate(ba, "createextra", new Object[] {_target,_method,_args,_res}));}
RDebugUtils.currentLine=4718592;
 //BA.debugLineNum = 4718592;BA.debugLine="Private Sub CreateExtra(Target As PyObject, Method";
RDebugUtils.currentLine=4718593;
 //BA.debugLineNum = 4718593;BA.debugLine="If mOptions.TrackLineNumbers Then";
if (__ref._moptions /*b4j.example.pybridge._pyoptions*/ .TrackLineNumbers /*boolean*/ ) { 
RDebugUtils.currentLine=4718594;
 //BA.debugLineNum = 4718594;BA.debugLine="Return Array(Target.Key, Method, Args.Args, Args";
if (true) return new Object[]{(Object)(_target.Key /*int*/ ),(Object)(_method),(Object)(_args.Args /*anywheresoftware.b4a.objects.collections.List*/ .getObject()),(Object)(_args.KWArgs /*anywheresoftware.b4a.objects.collections.Map*/ .getObject()),(Object)(_res.Key /*int*/ ),(Object)(""),(Object)(""),(Object)(0)};
 }else {
RDebugUtils.currentLine=4718596;
 //BA.debugLineNum = 4718596;BA.debugLine="Return Array(Target.Key, Method, Args.Args, Args";
if (true) return new Object[]{(Object)(_target.Key /*int*/ ),(Object)(_method),(Object)(_args.Args /*anywheresoftware.b4a.objects.collections.List*/ .getObject()),(Object)(_args.KWArgs /*anywheresoftware.b4a.objects.collections.Map*/ .getObject()),(Object)(_res.Key /*int*/ )};
 };
RDebugUtils.currentLine=4718598;
 //BA.debugLineNum = 4718598;BA.debugLine="End Sub";
return null;
}
public String  _registerforcleaning(b4j.example.pyutils __ref,b4j.example.pybridge._pyobject _py) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "registerforcleaning", true))
	 {return ((String) Debug.delegate(ba, "registerforcleaning", new Object[] {_py}));}
RDebugUtils.currentLine=5570560;
 //BA.debugLineNum = 5570560;BA.debugLine="Private Sub RegisterForCleaning (Py As PyObject)";
RDebugUtils.currentLine=5570561;
 //BA.debugLineNum = 5570561;BA.debugLine="ObjectsThatNeedToBeRegistered.Add(Py)";
__ref._objectsthatneedtoberegistered /*anywheresoftware.b4a.objects.collections.List*/ .Add((Object)(_py));
RDebugUtils.currentLine=5570562;
 //BA.debugLineNum = 5570562;BA.debugLine="KeysThatNeedToBeRegistered.Add(Py.Key)";
__ref._keysthatneedtoberegistered /*anywheresoftware.b4a.objects.collections.List*/ .Add((Object)(_py.Key /*int*/ ));
RDebugUtils.currentLine=5570563;
 //BA.debugLineNum = 5570563;BA.debugLine="MemorySlots.Put(Py.Key, Null)";
__ref._memoryslots /*anywheresoftware.b4a.objects.collections.Map*/ .Put((Object)(_py.Key /*int*/ ),__c.Null);
RDebugUtils.currentLine=5570564;
 //BA.debugLineNum = 5570564;BA.debugLine="If MemorySlots.Size - LastMemorySize > MEMORY_INC";
if (__ref._memoryslots /*anywheresoftware.b4a.objects.collections.Map*/ .getSize()-__ref._lastmemorysize /*int*/ >__ref._memory_increase_threshold /*int*/ ) { 
RDebugUtils.currentLine=5570565;
 //BA.debugLineNum = 5570565;BA.debugLine="ForceGC";
__ref._forcegc /*String*/ (null);
 };
RDebugUtils.currentLine=5570567;
 //BA.debugLineNum = 5570567;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _fetch(b4j.example.pyutils __ref,b4j.example.pybridge._pyobject _pyobject) throws Exception{
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "fetch", true))
	 {return ((anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) Debug.delegate(ba, "fetch", new Object[] {_pyobject}));}
ResumableSub_Fetch rsub = new ResumableSub_Fetch(this,__ref,_pyobject);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_Fetch extends BA.ResumableSub {
public ResumableSub_Fetch(b4j.example.pyutils parent,b4j.example.pyutils __ref,b4j.example.pybridge._pyobject _pyobject) {
this.parent = parent;
this.__ref = __ref;
this._pyobject = _pyobject;
this.__ref = parent;
}
b4j.example.pyutils __ref;
b4j.example.pyutils parent;
b4j.example.pybridge._pyobject _pyobject;
b4j.example.pybridge._pytask _task = null;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="pyutils";

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.ReturnFromResumableSub(this,null);return;}
case 0:
//C
this.state = -1;
RDebugUtils.currentLine=5242881;
 //BA.debugLineNum = 5242881;BA.debugLine="Dim TASK As PyTask = CreatePyTask(0, TASK_TYPE_GE";
_task = __ref._createpytask /*b4j.example.pybridge._pytask*/ (null,(int) (0),__ref._task_type_get /*int*/ ,anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(_pyobject.Key /*int*/ )}));
RDebugUtils.currentLine=5242882;
 //BA.debugLineNum = 5242882;BA.debugLine="Comm.SendTaskAndWait(TASK)";
__ref._comm /*b4j.example.pycomm*/ ._sendtaskandwait /*String*/ (null,_task);
RDebugUtils.currentLine=5242883;
 //BA.debugLineNum = 5242883;BA.debugLine="Wait For (TASK) AsyncTask_Received (TASK As PyTas";
parent.__c.WaitFor("asynctask_received", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pyutils", "fetch"), (Object)(_task));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_task = (b4j.example.pybridge._pytask) result[1];
;
RDebugUtils.currentLine=5242884;
 //BA.debugLineNum = 5242884;BA.debugLine="Return CheckForErrorsAndReturn(TASK, PyObject)";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(__ref._checkforerrorsandreturn /*b4j.example.pybridge._internalpytaskasyncresult*/ (null,_task,_pyobject)));return;};
RDebugUtils.currentLine=5242885;
 //BA.debugLineNum = 5242885;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public String  _forcegc(b4j.example.pyutils __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "forcegc", true))
	 {return ((String) Debug.delegate(ba, "forcegc", null));}
RDebugUtils.currentLine=5767168;
 //BA.debugLineNum = 5767168;BA.debugLine="Public Sub ForceGC";
RDebugUtils.currentLine=5767169;
 //BA.debugLineNum = 5767169;BA.debugLine="LastMemorySize = MemorySlots.Size";
__ref._lastmemorysize /*int*/  = __ref._memoryslots /*anywheresoftware.b4a.objects.collections.Map*/ .getSize();
RDebugUtils.currentLine=5767170;
 //BA.debugLineNum = 5767170;BA.debugLine="PyLog(B4JPrefix, mOptions.B4JColor, \"ForceGC: mem";
__ref._pylog /*String*/ (null,__ref._b4jprefix /*String*/ ,__ref._moptions /*b4j.example.pybridge._pyoptions*/ .B4JColor /*int*/ ,(Object)("ForceGC: memory slots - "+BA.NumberToString(__ref._lastmemorysize /*int*/ )));
RDebugUtils.currentLine=5767171;
 //BA.debugLineNum = 5767171;BA.debugLine="System.RunMethod(\"gc\", Null)";
__ref._system /*anywheresoftware.b4j.object.JavaObject*/ .RunMethod("gc",(Object[])(__c.Null));
RDebugUtils.currentLine=5767172;
 //BA.debugLineNum = 5767172;BA.debugLine="KeysImpl";
__ref._keysimpl /*String*/ (null);
RDebugUtils.currentLine=5767173;
 //BA.debugLineNum = 5767173;BA.debugLine="End Sub";
return "";
}
public boolean  _isarray(b4j.example.pyutils __ref,Object _obj) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "isarray", true))
	 {return ((Boolean) Debug.delegate(ba, "isarray", new Object[] {_obj}));}
RDebugUtils.currentLine=5046272;
 //BA.debugLineNum = 5046272;BA.debugLine="Private Sub IsArray(obj As Object) As Boolean";
RDebugUtils.currentLine=5046273;
 //BA.debugLineNum = 5046273;BA.debugLine="Return obj <> Null And \"[Ljava.lang.Object;\" = Ge";
if (true) return _obj!= null && ("[Ljava.lang.Object;").equals(__c.GetType(_obj));
RDebugUtils.currentLine=5046274;
 //BA.debugLineNum = 5046274;BA.debugLine="End Sub";
return false;
}
public String  _registerkeys(b4j.example.pyutils __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "registerkeys", true))
	 {return ((String) Debug.delegate(ba, "registerkeys", null));}
RDebugUtils.currentLine=5832704;
 //BA.debugLineNum = 5832704;BA.debugLine="Private Sub RegisterKeys";
RDebugUtils.currentLine=5832705;
 //BA.debugLineNum = 5832705;BA.debugLine="CleanerClass.RunMethod(\"registerMultipleKeys\", Ar";
__ref._cleanerclass /*anywheresoftware.b4j.object.JavaObject*/ .RunMethod("registerMultipleKeys",new Object[]{(Object)(__ref._objectsthatneedtoberegistered /*anywheresoftware.b4a.objects.collections.List*/ .getObject()),(Object)(__ref._keysthatneedtoberegistered /*anywheresoftware.b4a.objects.collections.List*/ .getObject()),(Object)(__ref._cleaner /*anywheresoftware.b4j.object.JavaObject*/ .getObject())});
RDebugUtils.currentLine=5832706;
 //BA.debugLineNum = 5832706;BA.debugLine="ObjectsThatNeedToBeRegistered.Clear";
__ref._objectsthatneedtoberegistered /*anywheresoftware.b4a.objects.collections.List*/ .Clear();
RDebugUtils.currentLine=5832707;
 //BA.debugLineNum = 5832707;BA.debugLine="KeysThatNeedToBeRegistered.Clear";
__ref._keysthatneedtoberegistered /*anywheresoftware.b4a.objects.collections.List*/ .Clear();
RDebugUtils.currentLine=5832708;
 //BA.debugLineNum = 5832708;BA.debugLine="End Sub";
return "";
}
public b4j.example.pybridge._pyobject  _run(b4j.example.pyutils __ref,b4j.example.pybridge._pyobject _target,String _method,b4j.example.pybridge._internalpymethodargs _args) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "run", true))
	 {return ((b4j.example.pybridge._pyobject) Debug.delegate(ba, "run", new Object[] {_target,_method,_args}));}
b4j.example.pybridge._pyobject _res = null;
b4j.example.pybridge._pytask _task = null;
RDebugUtils.currentLine=4653056;
 //BA.debugLineNum = 4653056;BA.debugLine="Public Sub Run (Target As PyObject, Method As Stri";
RDebugUtils.currentLine=4653057;
 //BA.debugLineNum = 4653057;BA.debugLine="Dim res As PyObject = CreatePyObject(0)";
_res = __ref._createpyobject /*b4j.example.pybridge._pyobject*/ (null,(int) (0));
RDebugUtils.currentLine=4653058;
 //BA.debugLineNum = 4653058;BA.debugLine="Dim TASK As PyTask = CreatePyTask(0, TASK_TYPE_RU";
_task = __ref._createpytask /*b4j.example.pybridge._pytask*/ (null,(int) (0),__ref._task_type_run /*int*/ ,anywheresoftware.b4a.keywords.Common.ArrayToList(__ref._createextra /*Object[]*/ (null,_target,_method,_args,_res)));
RDebugUtils.currentLine=4653059;
 //BA.debugLineNum = 4653059;BA.debugLine="mBridge.ErrorHandler.AddDataToTask(TASK)";
__ref._mbridge /*b4j.example.pybridge*/ ._errorhandler /*b4j.example.pyerrorhandler*/ ._adddatatotask /*String*/ (null,_task);
RDebugUtils.currentLine=4653060;
 //BA.debugLineNum = 4653060;BA.debugLine="Comm.SendTask(TASK)";
__ref._comm /*b4j.example.pycomm*/ ._sendtask /*String*/ (null,_task);
RDebugUtils.currentLine=4653061;
 //BA.debugLineNum = 4653061;BA.debugLine="Return res";
if (true) return _res;
RDebugUtils.currentLine=4653062;
 //BA.debugLineNum = 4653062;BA.debugLine="End Sub";
return null;
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _runasync(b4j.example.pyutils __ref,b4j.example.pybridge._pyobject _target,String _method,b4j.example.pybridge._internalpymethodargs _args) throws Exception{
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "runasync", true))
	 {return ((anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) Debug.delegate(ba, "runasync", new Object[] {_target,_method,_args}));}
ResumableSub_RunAsync rsub = new ResumableSub_RunAsync(this,__ref,_target,_method,_args);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_RunAsync extends BA.ResumableSub {
public ResumableSub_RunAsync(b4j.example.pyutils parent,b4j.example.pyutils __ref,b4j.example.pybridge._pyobject _target,String _method,b4j.example.pybridge._internalpymethodargs _args) {
this.parent = parent;
this.__ref = __ref;
this._target = _target;
this._method = _method;
this._args = _args;
this.__ref = parent;
}
b4j.example.pyutils __ref;
b4j.example.pyutils parent;
b4j.example.pybridge._pyobject _target;
String _method;
b4j.example.pybridge._internalpymethodargs _args;
b4j.example.pybridge._pyobject _res = null;
b4j.example.pybridge._pytask _task = null;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="pyutils";

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.ReturnFromResumableSub(this,null);return;}
case 0:
//C
this.state = -1;
RDebugUtils.currentLine=4784129;
 //BA.debugLineNum = 4784129;BA.debugLine="Dim res As PyObject = CreatePyObject(0)";
_res = __ref._createpyobject /*b4j.example.pybridge._pyobject*/ (null,(int) (0));
RDebugUtils.currentLine=4784130;
 //BA.debugLineNum = 4784130;BA.debugLine="Dim TASK As PyTask = CreatePyTask(0, TASK_TYPE_RU";
_task = __ref._createpytask /*b4j.example.pybridge._pytask*/ (null,(int) (0),__ref._task_type_run_async /*int*/ ,anywheresoftware.b4a.keywords.Common.ArrayToList(__ref._createextra /*Object[]*/ (null,_target,_method,_args,_res)));
RDebugUtils.currentLine=4784131;
 //BA.debugLineNum = 4784131;BA.debugLine="mBridge.ErrorHandler.AddDataToTask(TASK)";
__ref._mbridge /*b4j.example.pybridge*/ ._errorhandler /*b4j.example.pyerrorhandler*/ ._adddatatotask /*String*/ (null,_task);
RDebugUtils.currentLine=4784132;
 //BA.debugLineNum = 4784132;BA.debugLine="Comm.SendTaskAndWait(TASK)";
__ref._comm /*b4j.example.pycomm*/ ._sendtaskandwait /*String*/ (null,_task);
RDebugUtils.currentLine=4784133;
 //BA.debugLineNum = 4784133;BA.debugLine="Wait For (TASK) AsyncTask_Received (TASK As PyTas";
parent.__c.WaitFor("asynctask_received", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "pyutils", "runasync"), (Object)(_task));
this.state = 1;
return;
case 1:
//C
this.state = -1;
_task = (b4j.example.pybridge._pytask) result[1];
;
RDebugUtils.currentLine=4784134;
 //BA.debugLineNum = 4784134;BA.debugLine="Return CheckForErrorsAndReturn(TASK, res)";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(__ref._checkforerrorsandreturn /*b4j.example.pybridge._internalpytaskasyncresult*/ (null,_task,_res)));return;};
RDebugUtils.currentLine=4784135;
 //BA.debugLineNum = 4784135;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public String  _unwraplist(b4j.example.pyutils __ref,anywheresoftware.b4a.objects.collections.List _lst) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "unwraplist", true))
	 {return ((String) Debug.delegate(ba, "unwraplist", new Object[] {_lst}));}
int _i = 0;
Object _v = null;
RDebugUtils.currentLine=4915200;
 //BA.debugLineNum = 4915200;BA.debugLine="Private Sub UnwrapList (Lst As List)";
RDebugUtils.currentLine=4915201;
 //BA.debugLineNum = 4915201;BA.debugLine="If NotInitialized(Lst) Then Return";
if (__c.NotInitialized((Object)(_lst))) { 
if (true) return "";};
RDebugUtils.currentLine=4915202;
 //BA.debugLineNum = 4915202;BA.debugLine="For i = 0 To Lst.Size - 1";
{
final int step2 = 1;
final int limit2 = (int) (_lst.getSize()-1);
_i = (int) (0) ;
for (;_i <= limit2 ;_i = _i + step2 ) {
RDebugUtils.currentLine=4915203;
 //BA.debugLineNum = 4915203;BA.debugLine="Dim v As Object = Lst.Get(i)";
_v = _lst.Get(_i);
RDebugUtils.currentLine=4915204;
 //BA.debugLineNum = 4915204;BA.debugLine="If v Is PyWrapper Then";
if (_v instanceof b4j.example.pywrapper) { 
RDebugUtils.currentLine=4915205;
 //BA.debugLineNum = 4915205;BA.debugLine="Lst.Set(i, v.As(PyWrapper).InternalKey)";
_lst.Set(_i,(Object)(((b4j.example.pywrapper)(_v))._internalkey /*b4j.example.pybridge._pyobject*/ ));
 }else 
{RDebugUtils.currentLine=4915206;
 //BA.debugLineNum = 4915206;BA.debugLine="Else If v Is List Then";
if (_v instanceof java.util.List) { 
RDebugUtils.currentLine=4915207;
 //BA.debugLineNum = 4915207;BA.debugLine="UnwrapList(v)";
__ref._unwraplist /*String*/ (null,(anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_v)));
 }else 
{RDebugUtils.currentLine=4915208;
 //BA.debugLineNum = 4915208;BA.debugLine="Else If v Is Map Then";
if (_v instanceof java.util.Map) { 
RDebugUtils.currentLine=4915209;
 //BA.debugLineNum = 4915209;BA.debugLine="UnwrapMap(v)";
__ref._unwrapmap /*String*/ (null,(anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_v)));
 }else 
{RDebugUtils.currentLine=4915210;
 //BA.debugLineNum = 4915210;BA.debugLine="Else If IsArray(v) Then";
if (__ref._isarray /*boolean*/ (null,_v)) { 
RDebugUtils.currentLine=4915211;
 //BA.debugLineNum = 4915211;BA.debugLine="UnwrapTuple(v)";
__ref._unwraptuple /*String*/ (null,(Object[])(_v));
 }}}}
;
 }
};
RDebugUtils.currentLine=4915214;
 //BA.debugLineNum = 4915214;BA.debugLine="End Sub";
return "";
}
public String  _unwrapmap(b4j.example.pyutils __ref,anywheresoftware.b4a.objects.collections.Map _map) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "unwrapmap", true))
	 {return ((String) Debug.delegate(ba, "unwrapmap", new Object[] {_map}));}
anywheresoftware.b4a.objects.collections.List _keysthatneedtobeunwrapped = null;
Object _key = null;
Object _value = null;
RDebugUtils.currentLine=5111808;
 //BA.debugLineNum = 5111808;BA.debugLine="Private Sub UnwrapMap (Map As Map)";
RDebugUtils.currentLine=5111809;
 //BA.debugLineNum = 5111809;BA.debugLine="If NotInitialized(Map) Then Return";
if (__c.NotInitialized((Object)(_map))) { 
if (true) return "";};
RDebugUtils.currentLine=5111810;
 //BA.debugLineNum = 5111810;BA.debugLine="Dim KeysThatNeedToBeUnwrapped As List";
_keysthatneedtobeunwrapped = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=5111811;
 //BA.debugLineNum = 5111811;BA.debugLine="KeysThatNeedToBeUnwrapped.Initialize";
_keysthatneedtobeunwrapped.Initialize();
RDebugUtils.currentLine=5111812;
 //BA.debugLineNum = 5111812;BA.debugLine="For Each key As Object In Map.Keys";
{
final anywheresoftware.b4a.BA.IterableList group4 = _map.Keys();
final int groupLen4 = group4.getSize()
;int index4 = 0;
;
for (; index4 < groupLen4;index4++){
_key = group4.Get(index4);
RDebugUtils.currentLine=5111813;
 //BA.debugLineNum = 5111813;BA.debugLine="Dim value As Object = Map.Get(key)";
_value = _map.Get(_key);
RDebugUtils.currentLine=5111814;
 //BA.debugLineNum = 5111814;BA.debugLine="If value Is PyWrapper Then";
if (_value instanceof b4j.example.pywrapper) { 
RDebugUtils.currentLine=5111815;
 //BA.debugLineNum = 5111815;BA.debugLine="KeysThatNeedToBeUnwrapped.Add(key)";
_keysthatneedtobeunwrapped.Add(_key);
 }else 
{RDebugUtils.currentLine=5111816;
 //BA.debugLineNum = 5111816;BA.debugLine="Else If value Is List Then";
if (_value instanceof java.util.List) { 
RDebugUtils.currentLine=5111817;
 //BA.debugLineNum = 5111817;BA.debugLine="UnwrapList(value)";
__ref._unwraplist /*String*/ (null,(anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_value)));
 }else 
{RDebugUtils.currentLine=5111818;
 //BA.debugLineNum = 5111818;BA.debugLine="Else If value Is Map Then";
if (_value instanceof java.util.Map) { 
RDebugUtils.currentLine=5111819;
 //BA.debugLineNum = 5111819;BA.debugLine="UnwrapMap(value)";
__ref._unwrapmap /*String*/ (null,(anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_value)));
 }else 
{RDebugUtils.currentLine=5111820;
 //BA.debugLineNum = 5111820;BA.debugLine="Else If IsArray(value) Then";
if (__ref._isarray /*boolean*/ (null,_value)) { 
RDebugUtils.currentLine=5111821;
 //BA.debugLineNum = 5111821;BA.debugLine="UnwrapTuple(value)";
__ref._unwraptuple /*String*/ (null,(Object[])(_value));
 }}}}
;
 }
};
RDebugUtils.currentLine=5111824;
 //BA.debugLineNum = 5111824;BA.debugLine="For Each key As Object In KeysThatNeedToBeUnwrapp";
{
final anywheresoftware.b4a.BA.IterableList group16 = _keysthatneedtobeunwrapped;
final int groupLen16 = group16.getSize()
;int index16 = 0;
;
for (; index16 < groupLen16;index16++){
_key = group16.Get(index16);
RDebugUtils.currentLine=5111825;
 //BA.debugLineNum = 5111825;BA.debugLine="Dim value As Object = Map.Get(key)";
_value = _map.Get(_key);
RDebugUtils.currentLine=5111826;
 //BA.debugLineNum = 5111826;BA.debugLine="Map.Put(key, value.As(PyWrapper).InternalKey)";
_map.Put(_key,(Object)(((b4j.example.pywrapper)(_value))._internalkey /*b4j.example.pybridge._pyobject*/ ));
 }
};
RDebugUtils.currentLine=5111828;
 //BA.debugLineNum = 5111828;BA.debugLine="End Sub";
return "";
}
public String  _unwraptuple(b4j.example.pyutils __ref,Object[] _obj) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyutils";
if (Debug.shouldDelegate(ba, "unwraptuple", true))
	 {return ((String) Debug.delegate(ba, "unwraptuple", new Object[] {_obj}));}
int _i = 0;
Object _o = null;
RDebugUtils.currentLine=4980736;
 //BA.debugLineNum = 4980736;BA.debugLine="Private Sub UnwrapTuple (Obj() As Object)";
RDebugUtils.currentLine=4980737;
 //BA.debugLineNum = 4980737;BA.debugLine="For i = 0 To Obj.Length - 1";
{
final int step1 = 1;
final int limit1 = (int) (_obj.length-1);
_i = (int) (0) ;
for (;_i <= limit1 ;_i = _i + step1 ) {
RDebugUtils.currentLine=4980738;
 //BA.debugLineNum = 4980738;BA.debugLine="Dim o As Object = Obj(i)";
_o = _obj[_i];
RDebugUtils.currentLine=4980739;
 //BA.debugLineNum = 4980739;BA.debugLine="If o Is PyWrapper Then";
if (_o instanceof b4j.example.pywrapper) { 
RDebugUtils.currentLine=4980740;
 //BA.debugLineNum = 4980740;BA.debugLine="Obj(i) = o.As(PyWrapper).InternalKey";
_obj[_i] = (Object)(((b4j.example.pywrapper)(_o))._internalkey /*b4j.example.pybridge._pyobject*/ );
 }else 
{RDebugUtils.currentLine=4980741;
 //BA.debugLineNum = 4980741;BA.debugLine="Else If o Is List Then";
if (_o instanceof java.util.List) { 
RDebugUtils.currentLine=4980742;
 //BA.debugLineNum = 4980742;BA.debugLine="UnwrapList(o)";
__ref._unwraplist /*String*/ (null,(anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_o)));
 }else 
{RDebugUtils.currentLine=4980743;
 //BA.debugLineNum = 4980743;BA.debugLine="Else If o Is Map Then";
if (_o instanceof java.util.Map) { 
RDebugUtils.currentLine=4980744;
 //BA.debugLineNum = 4980744;BA.debugLine="UnwrapMap(o)";
__ref._unwrapmap /*String*/ (null,(anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (java.util.Map)(_o)));
 }else 
{RDebugUtils.currentLine=4980745;
 //BA.debugLineNum = 4980745;BA.debugLine="Else If IsArray(o) Then";
if (__ref._isarray /*boolean*/ (null,_o)) { 
RDebugUtils.currentLine=4980746;
 //BA.debugLineNum = 4980746;BA.debugLine="UnwrapTuple(o)";
__ref._unwraptuple /*String*/ (null,(Object[])(_o));
 }}}}
;
 }
};
RDebugUtils.currentLine=4980749;
 //BA.debugLineNum = 4980749;BA.debugLine="End Sub";
return "";
}
public static class CleanRunnable implements Runnable {
	private final int key;
	private final int cleanerIndex;
	private final static java.util.List<Object> listOfKeys = java.util.Collections.synchronizedList(new java.util.ArrayList<Object>());
	public static volatile int currentCleanerIndex;
	public CleanRunnable(int key, int cleanerIndex) {
		this.key = key;
		this.cleanerIndex = cleanerIndex;
	}
	public void run() {
		if (this.cleanerIndex == currentCleanerIndex)
			listOfKeys.add(key);
	}
	public static java.util.List<Object> getKeys() {
		synchronized(listOfKeys) {
			java.util.ArrayList<Object> res = new java.util.ArrayList<Object>(listOfKeys);
			listOfKeys.clear();
			return res;
		}
	}
	public static void registerMultipleKeys(java.util.List<Object> objects, java.util.List<Integer> keys, java.lang.ref.Cleaner cleaner) {
		for (int i = 0;i < objects.size();i++) {
			Object object = objects.get(i);
			int key = keys.get(i);
			cleaner.register(object, new CleanRunnable(key, currentCleanerIndex));
		}
	}
}

}