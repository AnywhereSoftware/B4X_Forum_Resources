package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class pyerrorhandler extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.pyerrorhandler", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.pyerrorhandler.class).invoke(this, new Object[] {null});
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
public b4j.example.b4xset _ignoredclasses = null;
public anywheresoftware.b4j.object.JavaObject _threadclass = null;
public b4j.example.pyutils _mutils = null;
public anywheresoftware.b4j.object.JavaObject _baclass = null;
public anywheresoftware.b4a.objects.collections.Map _filescache = null;
public b4j.example.main _main = null;
public b4j.example.b4xcollections _b4xcollections = null;
public String  _initialize(b4j.example.pyerrorhandler __ref,anywheresoftware.b4a.BA _ba,b4j.example.pyutils _utils) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="pyerrorhandler";
if (Debug.shouldDelegate(ba, "initialize", true))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba,_utils}));}
RDebugUtils.currentLine=4128768;
 //BA.debugLineNum = 4128768;BA.debugLine="Public Sub Initialize (Utils As PyUtils)";
RDebugUtils.currentLine=4128769;
 //BA.debugLineNum = 4128769;BA.debugLine="BAClass.InitializeStatic(\"anywheresoftware.b4a.BA";
__ref._baclass /*anywheresoftware.b4j.object.JavaObject*/ .InitializeStatic("anywheresoftware.b4a.BA");
RDebugUtils.currentLine=4128770;
 //BA.debugLineNum = 4128770;BA.debugLine="ThreadClass = ThreadClass.InitializeStatic(\"java.";
__ref._threadclass /*anywheresoftware.b4j.object.JavaObject*/  = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(__ref._threadclass /*anywheresoftware.b4j.object.JavaObject*/ .InitializeStatic("java.lang.Thread").RunMethod("currentThread",(Object[])(__c.Null))));
RDebugUtils.currentLine=4128771;
 //BA.debugLineNum = 4128771;BA.debugLine="mUtils = Utils";
__ref._mutils /*b4j.example.pyutils*/  = _utils;
RDebugUtils.currentLine=4128772;
 //BA.debugLineNum = 4128772;BA.debugLine="IgnoredClasses = B4XCollections.CreateSet2(Array(";
__ref._ignoredclasses /*b4j.example.b4xset*/  = _b4xcollections._createset2 /*b4j.example.b4xset*/ (anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)("pyerrorhandler"),(Object)("pyutils"),(Object)("pywrapper"),(Object)("pybridge"),(Object)("pycomm")}));
RDebugUtils.currentLine=4128773;
 //BA.debugLineNum = 4128773;BA.debugLine="FilesCache.Initialize";
__ref._filescache /*anywheresoftware.b4a.objects.collections.Map*/ .Initialize();
RDebugUtils.currentLine=4128774;
 //BA.debugLineNum = 4128774;BA.debugLine="End Sub";
return "";
}
public String  _adddatatotask(b4j.example.pyerrorhandler __ref,b4j.example.pybridge._pytask _task) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyerrorhandler";
if (Debug.shouldDelegate(ba, "adddatatotask", true))
	 {return ((String) Debug.delegate(ba, "adddatatotask", new Object[] {_task}));}
Object[] _elements = null;
int _e = 0;
anywheresoftware.b4j.object.JavaObject _element = null;
String _origcls = "";
int _i = 0;
String _cls = "";
String _method = "";
RDebugUtils.currentLine=4194304;
 //BA.debugLineNum = 4194304;BA.debugLine="Public Sub AddDataToTask (Task As PyTask)";
RDebugUtils.currentLine=4194305;
 //BA.debugLineNum = 4194305;BA.debugLine="If mUtils.mOptions.TrackLineNumbers = False Then";
if (__ref._mutils /*b4j.example.pyutils*/ ._moptions /*b4j.example.pybridge._pyoptions*/ .TrackLineNumbers /*boolean*/ ==__c.False) { 
if (true) return "";};
RDebugUtils.currentLine=4194306;
 //BA.debugLineNum = 4194306;BA.debugLine="Dim elements() As Object = ThreadClass.RunMethod(";
_elements = (Object[])(__ref._threadclass /*anywheresoftware.b4j.object.JavaObject*/ .RunMethod("getStackTrace",(Object[])(__c.Null)));
RDebugUtils.currentLine=4194307;
 //BA.debugLineNum = 4194307;BA.debugLine="For e = 8 To elements.Length - 1";
{
final int step3 = 1;
final int limit3 = (int) (_elements.length-1);
_e = (int) (8) ;
for (;_e <= limit3 ;_e = _e + step3 ) {
RDebugUtils.currentLine=4194308;
 //BA.debugLineNum = 4194308;BA.debugLine="Dim element As JavaObject = elements(e)";
_element = new anywheresoftware.b4j.object.JavaObject();
_element = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_elements[_e]));
RDebugUtils.currentLine=4194309;
 //BA.debugLineNum = 4194309;BA.debugLine="Dim origcls As String = element.RunMethod(\"getCl";
_origcls = BA.ObjectToString(_element.RunMethod("getClassName",(Object[])(__c.Null)));
RDebugUtils.currentLine=4194310;
 //BA.debugLineNum = 4194310;BA.debugLine="If origcls.StartsWith(mUtils.PackageName) Then";
if (_origcls.startsWith(__ref._mutils /*b4j.example.pyutils*/ ._packagename /*String*/ )) { 
RDebugUtils.currentLine=4194311;
 //BA.debugLineNum = 4194311;BA.debugLine="origcls = origcls.SubString(mUtils.PackageName.";
_origcls = _origcls.substring((int) (__ref._mutils /*b4j.example.pyutils*/ ._packagename /*String*/ .length()+1));
RDebugUtils.currentLine=4194312;
 //BA.debugLineNum = 4194312;BA.debugLine="Dim i As Int = origcls.IndexOf(\"$\")";
_i = _origcls.indexOf("$");
RDebugUtils.currentLine=4194313;
 //BA.debugLineNum = 4194313;BA.debugLine="Dim cls As String = origcls";
_cls = _origcls;
RDebugUtils.currentLine=4194314;
 //BA.debugLineNum = 4194314;BA.debugLine="If i > -1 Then cls = cls.SubString2(0, i)";
if (_i>-1) { 
_cls = _cls.substring((int) (0),_i);};
RDebugUtils.currentLine=4194315;
 //BA.debugLineNum = 4194315;BA.debugLine="If IgnoredClasses.Contains(cls) Then Continue";
if (__ref._ignoredclasses /*b4j.example.b4xset*/ ._contains /*boolean*/ (null,(Object)(_cls))) { 
if (true) continue;};
RDebugUtils.currentLine=4194316;
 //BA.debugLineNum = 4194316;BA.debugLine="Task.Extra.Set(5, cls)";
_task.Extra /*anywheresoftware.b4a.objects.collections.List*/ .Set((int) (5),(Object)(_cls));
RDebugUtils.currentLine=4194317;
 //BA.debugLineNum = 4194317;BA.debugLine="Dim method As String";
_method = "";
RDebugUtils.currentLine=4194318;
 //BA.debugLineNum = 4194318;BA.debugLine="If i > -1 Then";
if (_i>-1) { 
RDebugUtils.currentLine=4194319;
 //BA.debugLineNum = 4194319;BA.debugLine="method = origcls.SubString(i + 1)";
_method = _origcls.substring((int) (_i+1));
RDebugUtils.currentLine=4194320;
 //BA.debugLineNum = 4194320;BA.debugLine="If method.StartsWith(\"ResumableSub\") Then meth";
if (_method.startsWith("ResumableSub")) { 
_method = _method.substring("ResumableSub_".length());};
 }else {
RDebugUtils.currentLine=4194322;
 //BA.debugLineNum = 4194322;BA.debugLine="method = element.RunMethod(\"getMethodName\", Nu";
_method = BA.ObjectToString(_element.RunMethod("getMethodName",(Object[])(__c.Null)));
 };
RDebugUtils.currentLine=4194324;
 //BA.debugLineNum = 4194324;BA.debugLine="Task.Extra.Set(6, method)";
_task.Extra /*anywheresoftware.b4a.objects.collections.List*/ .Set((int) (6),(Object)(_method));
RDebugUtils.currentLine=4194325;
 //BA.debugLineNum = 4194325;BA.debugLine="Task.Extra.Set(7, element.RunMethod(\"getLineNum";
_task.Extra /*anywheresoftware.b4a.objects.collections.List*/ .Set((int) (7),_element.RunMethod("getLineNumber",(Object[])(__c.Null)));
RDebugUtils.currentLine=4194326;
 //BA.debugLineNum = 4194326;BA.debugLine="Return";
if (true) return "";
 };
 }
};
RDebugUtils.currentLine=4194329;
 //BA.debugLineNum = 4194329;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4j.example.pyerrorhandler __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyerrorhandler";
RDebugUtils.currentLine=4063232;
 //BA.debugLineNum = 4063232;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=4063233;
 //BA.debugLineNum = 4063233;BA.debugLine="Public IgnoredClasses As B4XSet";
_ignoredclasses = new b4j.example.b4xset();
RDebugUtils.currentLine=4063234;
 //BA.debugLineNum = 4063234;BA.debugLine="Private ThreadClass As JavaObject";
_threadclass = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=4063235;
 //BA.debugLineNum = 4063235;BA.debugLine="Private mUtils As PyUtils";
_mutils = new b4j.example.pyutils();
RDebugUtils.currentLine=4063236;
 //BA.debugLineNum = 4063236;BA.debugLine="Private BAClass As JavaObject";
_baclass = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=4063237;
 //BA.debugLineNum = 4063237;BA.debugLine="Private FilesCache As Map";
_filescache = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=4063238;
 //BA.debugLineNum = 4063238;BA.debugLine="End Sub";
return "";
}
public String  _untangleerror(b4j.example.pyerrorhandler __ref,String _s) throws Exception{
__ref = this;
RDebugUtils.currentModule="pyerrorhandler";
if (Debug.shouldDelegate(ba, "untangleerror", true))
	 {return ((String) Debug.delegate(ba, "untangleerror", new Object[] {_s}));}
anywheresoftware.b4a.keywords.Regex.MatcherWrapper _m = null;
String _module = "";
int _linenumber = 0;
String _folder = "";
String _ffile = "";
anywheresoftware.b4a.objects.collections.List _lines = null;
int _i = 0;
String _line = "";
RDebugUtils.currentLine=4259840;
 //BA.debugLineNum = 4259840;BA.debugLine="Public Sub UntangleError (s As String)";
RDebugUtils.currentLine=4259841;
 //BA.debugLineNum = 4259841;BA.debugLine="Dim m As Matcher = Regex.Matcher(\"~de:([^,]+),(\\d";
_m = new anywheresoftware.b4a.keywords.Regex.MatcherWrapper();
_m = __c.Regex.Matcher("~de:([^,]+),(\\d+)",_s);
RDebugUtils.currentLine=4259842;
 //BA.debugLineNum = 4259842;BA.debugLine="m.Find";
_m.Find();
RDebugUtils.currentLine=4259843;
 //BA.debugLineNum = 4259843;BA.debugLine="Dim Module As String = m.Group(1)";
_module = _m.Group((int) (1));
RDebugUtils.currentLine=4259844;
 //BA.debugLineNum = 4259844;BA.debugLine="Dim LineNumber As Int = m.Group(2) - 1";
_linenumber = (int) ((double)(Double.parseDouble(_m.Group((int) (2))))-1);
RDebugUtils.currentLine=4259845;
 //BA.debugLineNum = 4259845;BA.debugLine="If FilesCache.ContainsKey(Module) = False Then";
if (__ref._filescache /*anywheresoftware.b4a.objects.collections.Map*/ .ContainsKey((Object)(_module))==__c.False) { 
RDebugUtils.currentLine=4259846;
 //BA.debugLineNum = 4259846;BA.debugLine="Dim folder As String = File.Combine(File.DirApp,";
_folder = __c.File.Combine(__c.File.getDirApp(),"src\\"+__ref._mutils /*b4j.example.pyutils*/ ._packagename /*String*/ .replace(".","\\"));
RDebugUtils.currentLine=4259847;
 //BA.debugLineNum = 4259847;BA.debugLine="Dim ffile As String = Module & \".java\"";
_ffile = _module+".java";
RDebugUtils.currentLine=4259848;
 //BA.debugLineNum = 4259848;BA.debugLine="If File.Exists(folder, ffile) Then";
if (__c.File.Exists(_folder,_ffile)) { 
RDebugUtils.currentLine=4259849;
 //BA.debugLineNum = 4259849;BA.debugLine="FilesCache.Put(Module, File.ReadList(folder, ff";
__ref._filescache /*anywheresoftware.b4a.objects.collections.Map*/ .Put((Object)(_module),(Object)(__c.File.ReadList(_folder,_ffile).getObject()));
 }else {
RDebugUtils.currentLine=4259851;
 //BA.debugLineNum = 4259851;BA.debugLine="FilesCache.Put(Module, Null)";
__ref._filescache /*anywheresoftware.b4a.objects.collections.Map*/ .Put((Object)(_module),__c.Null);
 };
 };
RDebugUtils.currentLine=4259854;
 //BA.debugLineNum = 4259854;BA.debugLine="Dim lines As List = FilesCache.Get(Module)";
_lines = new anywheresoftware.b4a.objects.collections.List();
_lines = (anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(__ref._filescache /*anywheresoftware.b4a.objects.collections.Map*/ .Get((Object)(_module))));
RDebugUtils.currentLine=4259855;
 //BA.debugLineNum = 4259855;BA.debugLine="If NotInitialized(lines) Then Return";
if (__c.NotInitialized((Object)(_lines))) { 
if (true) return "";};
RDebugUtils.currentLine=4259856;
 //BA.debugLineNum = 4259856;BA.debugLine="For i = LineNumber To Max(0, LineNumber - 10) Ste";
{
final int step16 = -1;
final int limit16 = (int) (__c.Max(0,_linenumber-10));
_i = _linenumber ;
for (;_i >= limit16 ;_i = _i + step16 ) {
RDebugUtils.currentLine=4259857;
 //BA.debugLineNum = 4259857;BA.debugLine="Dim line As String = lines.Get(i)";
_line = BA.ObjectToString(_lines.Get(_i));
RDebugUtils.currentLine=4259858;
 //BA.debugLineNum = 4259858;BA.debugLine="If line.StartsWith(\" //BA.debugLineNum\") Then";
if (_line.startsWith(" //BA.debugLineNum")) { 
RDebugUtils.currentLine=4259859;
 //BA.debugLineNum = 4259859;BA.debugLine="m = Regex.Matcher(\"BA\\.debugLineNum\\s*=\\s*(\\d+)";
_m = __c.Regex.Matcher("BA\\.debugLineNum\\s*=\\s*(\\d+);",_line);
RDebugUtils.currentLine=4259860;
 //BA.debugLineNum = 4259860;BA.debugLine="If m.Find Then";
if (_m.Find()) { 
RDebugUtils.currentLine=4259861;
 //BA.debugLineNum = 4259861;BA.debugLine="BAClass.RunMethod(\"Log\", Array(\"~de:\" & Module";
__ref._baclass /*anywheresoftware.b4j.object.JavaObject*/ .RunMethod("Log",new Object[]{(Object)("~de:"+_module+","+_m.Group((int) (1)))});
RDebugUtils.currentLine=4259862;
 //BA.debugLineNum = 4259862;BA.debugLine="Exit";
if (true) break;
 };
 };
 }
};
RDebugUtils.currentLine=4259867;
 //BA.debugLineNum = 4259867;BA.debugLine="End Sub";
return "";
}
}