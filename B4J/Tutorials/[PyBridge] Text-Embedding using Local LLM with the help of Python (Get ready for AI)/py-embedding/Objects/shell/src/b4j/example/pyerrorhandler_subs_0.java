package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class pyerrorhandler_subs_0 {


public static RemoteObject  _adddatatotask(RemoteObject __ref,RemoteObject _task) throws Exception{
try {
		Debug.PushSubsStack("AddDataToTask (pyerrorhandler) ","pyerrorhandler",6,__ref.getField(false, "ba"),__ref,18);
if (RapidSub.canDelegate("adddatatotask")) { return __ref.runUserSub(false, "pyerrorhandler","adddatatotask", __ref, _task);}
RemoteObject _elements = null;
int _e = 0;
RemoteObject _element = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _origcls = RemoteObject.createImmutable("");
RemoteObject _i = RemoteObject.createImmutable(0);
RemoteObject _cls = RemoteObject.createImmutable("");
RemoteObject _method = RemoteObject.createImmutable("");
Debug.locals.put("Task", _task);
 BA.debugLineNum = 18;BA.debugLine="Public Sub AddDataToTask (Task As PyTask)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 19;BA.debugLine="If mUtils.mOptions.TrackLineNumbers = False Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_mutils" /*RemoteObject*/ ).getField(false,"_moptions" /*RemoteObject*/ ).getField(true,"TrackLineNumbers" /*RemoteObject*/ ),pyerrorhandler.__c.getField(true,"False"))) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 20;BA.debugLine="Dim elements() As Object = ThreadClass.RunMethod(";
Debug.JustUpdateDeviceLine();
_elements = (__ref.getField(false,"_threadclass" /*RemoteObject*/ ).runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getStackTrace")),(Object)((pyerrorhandler.__c.getField(false,"Null")))));Debug.locals.put("elements", _elements);Debug.locals.put("elements", _elements);
 BA.debugLineNum = 21;BA.debugLine="For e = 8 To elements.Length - 1";
Debug.JustUpdateDeviceLine();
{
final int step3 = 1;
final int limit3 = RemoteObject.solve(new RemoteObject[] {_elements.getField(true,"length"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_e = 8 ;
for (;(step3 > 0 && _e <= limit3) || (step3 < 0 && _e >= limit3) ;_e = ((int)(0 + _e + step3))  ) {
Debug.locals.put("e", _e);
 BA.debugLineNum = 22;BA.debugLine="Dim element As JavaObject = elements(e)";
Debug.JustUpdateDeviceLine();
_element = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_element = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _elements.getArrayElement(false,BA.numberCast(int.class, _e)));Debug.locals.put("element", _element);Debug.locals.put("element", _element);
 BA.debugLineNum = 23;BA.debugLine="Dim origcls As String = element.RunMethod(\"getCl";
Debug.JustUpdateDeviceLine();
_origcls = BA.ObjectToString(_element.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getClassName")),(Object)((pyerrorhandler.__c.getField(false,"Null")))));Debug.locals.put("origcls", _origcls);Debug.locals.put("origcls", _origcls);
 BA.debugLineNum = 24;BA.debugLine="If origcls.StartsWith(mUtils.PackageName) Then";
Debug.JustUpdateDeviceLine();
if (_origcls.runMethod(true,"startsWith",(Object)(__ref.getField(false,"_mutils" /*RemoteObject*/ ).getField(true,"_packagename" /*RemoteObject*/ ))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 25;BA.debugLine="origcls = origcls.SubString(mUtils.PackageName.";
Debug.JustUpdateDeviceLine();
_origcls = _origcls.runMethod(true,"substring",(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mutils" /*RemoteObject*/ ).getField(true,"_packagename" /*RemoteObject*/ ).runMethod(true,"length"),RemoteObject.createImmutable(1)}, "+",1, 1)));Debug.locals.put("origcls", _origcls);
 BA.debugLineNum = 26;BA.debugLine="Dim i As Int = origcls.IndexOf(\"$\")";
Debug.JustUpdateDeviceLine();
_i = _origcls.runMethod(true,"indexOf",(Object)(RemoteObject.createImmutable("$")));Debug.locals.put("i", _i);Debug.locals.put("i", _i);
 BA.debugLineNum = 27;BA.debugLine="Dim cls As String = origcls";
Debug.JustUpdateDeviceLine();
_cls = _origcls;Debug.locals.put("cls", _cls);Debug.locals.put("cls", _cls);
 BA.debugLineNum = 28;BA.debugLine="If i > -1 Then cls = cls.SubString2(0, i)";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",_i,BA.numberCast(double.class, -(double) (0 + 1)))) { 
_cls = _cls.runMethod(true,"substring",(Object)(BA.numberCast(int.class, 0)),(Object)(_i));Debug.locals.put("cls", _cls);};
 BA.debugLineNum = 29;BA.debugLine="If IgnoredClasses.Contains(cls) Then Continue";
Debug.JustUpdateDeviceLine();
if (__ref.getField(false,"_ignoredclasses" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_contains" /*RemoteObject*/ ,(Object)((_cls))).<Boolean>get().booleanValue()) { 
if (true) continue;};
 BA.debugLineNum = 30;BA.debugLine="Task.Extra.Set(5, cls)";
Debug.JustUpdateDeviceLine();
_task.getField(false,"Extra" /*RemoteObject*/ ).runVoidMethod ("Set",(Object)(BA.numberCast(int.class, 5)),(Object)((_cls)));
 BA.debugLineNum = 31;BA.debugLine="Dim method As String";
Debug.JustUpdateDeviceLine();
_method = RemoteObject.createImmutable("");Debug.locals.put("method", _method);
 BA.debugLineNum = 32;BA.debugLine="If i > -1 Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",_i,BA.numberCast(double.class, -(double) (0 + 1)))) { 
 BA.debugLineNum = 33;BA.debugLine="method = origcls.SubString(i + 1)";
Debug.JustUpdateDeviceLine();
_method = _origcls.runMethod(true,"substring",(Object)(RemoteObject.solve(new RemoteObject[] {_i,RemoteObject.createImmutable(1)}, "+",1, 1)));Debug.locals.put("method", _method);
 BA.debugLineNum = 34;BA.debugLine="If method.StartsWith(\"ResumableSub\") Then meth";
Debug.JustUpdateDeviceLine();
if (_method.runMethod(true,"startsWith",(Object)(RemoteObject.createImmutable("ResumableSub"))).<Boolean>get().booleanValue()) { 
_method = _method.runMethod(true,"substring",(Object)(RemoteObject.createImmutable("ResumableSub_").runMethod(true,"length")));Debug.locals.put("method", _method);};
 }else {
 BA.debugLineNum = 36;BA.debugLine="method = element.RunMethod(\"getMethodName\", Nu";
Debug.JustUpdateDeviceLine();
_method = BA.ObjectToString(_element.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getMethodName")),(Object)((pyerrorhandler.__c.getField(false,"Null")))));Debug.locals.put("method", _method);
 };
 BA.debugLineNum = 38;BA.debugLine="Task.Extra.Set(6, method)";
Debug.JustUpdateDeviceLine();
_task.getField(false,"Extra" /*RemoteObject*/ ).runVoidMethod ("Set",(Object)(BA.numberCast(int.class, 6)),(Object)((_method)));
 BA.debugLineNum = 39;BA.debugLine="Task.Extra.Set(7, element.RunMethod(\"getLineNum";
Debug.JustUpdateDeviceLine();
_task.getField(false,"Extra" /*RemoteObject*/ ).runVoidMethod ("Set",(Object)(BA.numberCast(int.class, 7)),(Object)(_element.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getLineNumber")),(Object)((pyerrorhandler.__c.getField(false,"Null"))))));
 BA.debugLineNum = 40;BA.debugLine="Return";
Debug.JustUpdateDeviceLine();
if (true) return RemoteObject.createImmutable("");
 };
 }
}Debug.locals.put("e", _e);
;
 BA.debugLineNum = 43;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 3;BA.debugLine="Public IgnoredClasses As B4XSet";
pyerrorhandler._ignoredclasses = RemoteObject.createNew ("b4j.example.b4xset");__ref.setField("_ignoredclasses",pyerrorhandler._ignoredclasses);
 //BA.debugLineNum = 4;BA.debugLine="Private ThreadClass As JavaObject";
pyerrorhandler._threadclass = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");__ref.setField("_threadclass",pyerrorhandler._threadclass);
 //BA.debugLineNum = 5;BA.debugLine="Private mUtils As PyUtils";
pyerrorhandler._mutils = RemoteObject.createNew ("b4j.example.pyutils");__ref.setField("_mutils",pyerrorhandler._mutils);
 //BA.debugLineNum = 6;BA.debugLine="Private BAClass As JavaObject";
pyerrorhandler._baclass = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");__ref.setField("_baclass",pyerrorhandler._baclass);
 //BA.debugLineNum = 7;BA.debugLine="Private FilesCache As Map";
pyerrorhandler._filescache = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");__ref.setField("_filescache",pyerrorhandler._filescache);
 //BA.debugLineNum = 8;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _utils) throws Exception{
try {
		Debug.PushSubsStack("Initialize (pyerrorhandler) ","pyerrorhandler",6,__ref.getField(false, "ba"),__ref,10);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "pyerrorhandler","initialize", __ref, _ba, _utils);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
Debug.locals.put("Utils", _utils);
 BA.debugLineNum = 10;BA.debugLine="Public Sub Initialize (Utils As PyUtils)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 11;BA.debugLine="BAClass.InitializeStatic(\"anywheresoftware.b4a.BA";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_baclass" /*RemoteObject*/ ).runVoidMethod ("InitializeStatic",(Object)(RemoteObject.createImmutable("anywheresoftware.b4a.BA")));
 BA.debugLineNum = 12;BA.debugLine="ThreadClass = ThreadClass.InitializeStatic(\"java.";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_threadclass" /*RemoteObject*/ ).setObject (__ref.getField(false,"_threadclass" /*RemoteObject*/ ).runMethod(false,"InitializeStatic",(Object)(RemoteObject.createImmutable("java.lang.Thread"))).runMethod(false,"RunMethod",(Object)(BA.ObjectToString("currentThread")),(Object)((pyerrorhandler.__c.getField(false,"Null")))));
 BA.debugLineNum = 13;BA.debugLine="mUtils = Utils";
Debug.JustUpdateDeviceLine();
__ref.setField ("_mutils" /*RemoteObject*/ ,_utils);
 BA.debugLineNum = 14;BA.debugLine="IgnoredClasses = B4XCollections.CreateSet2(Array(";
Debug.JustUpdateDeviceLine();
__ref.setField ("_ignoredclasses" /*RemoteObject*/ ,pyerrorhandler._b4xcollections.runMethod(false,"_createset2" /*RemoteObject*/ ,(Object)(pyerrorhandler.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("Object",new int[] {5},new Object[] {RemoteObject.createImmutable(("pyerrorhandler")),RemoteObject.createImmutable(("pyutils")),RemoteObject.createImmutable(("pywrapper")),RemoteObject.createImmutable(("pybridge")),(RemoteObject.createImmutable("pycomm"))}))))));
 BA.debugLineNum = 15;BA.debugLine="FilesCache.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_filescache" /*RemoteObject*/ ).runVoidMethod ("Initialize");
 BA.debugLineNum = 16;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _untangleerror(RemoteObject __ref,RemoteObject _s) throws Exception{
try {
		Debug.PushSubsStack("UntangleError (pyerrorhandler) ","pyerrorhandler",6,__ref.getField(false, "ba"),__ref,45);
if (RapidSub.canDelegate("untangleerror")) { return __ref.runUserSub(false, "pyerrorhandler","untangleerror", __ref, _s);}
RemoteObject _m = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Regex.MatcherWrapper");
RemoteObject _module = RemoteObject.createImmutable("");
RemoteObject _linenumber = RemoteObject.createImmutable(0);
RemoteObject _folder = RemoteObject.createImmutable("");
RemoteObject _ffile = RemoteObject.createImmutable("");
RemoteObject _lines = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
int _i = 0;
RemoteObject _line = RemoteObject.createImmutable("");
Debug.locals.put("s", _s);
 BA.debugLineNum = 45;BA.debugLine="Public Sub UntangleError (s As String)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 46;BA.debugLine="Dim m As Matcher = Regex.Matcher(\"~de:([^,]+),(\\d";
Debug.JustUpdateDeviceLine();
_m = RemoteObject.createNew ("anywheresoftware.b4a.keywords.Regex.MatcherWrapper");
_m = pyerrorhandler.__c.getField(false,"Regex").runMethod(false,"Matcher",(Object)(BA.ObjectToString("~de:([^,]+),(\\d+)")),(Object)(_s));Debug.locals.put("m", _m);Debug.locals.put("m", _m);
 BA.debugLineNum = 47;BA.debugLine="m.Find";
Debug.JustUpdateDeviceLine();
_m.runVoidMethod ("Find");
 BA.debugLineNum = 48;BA.debugLine="Dim Module As String = m.Group(1)";
Debug.JustUpdateDeviceLine();
_module = _m.runMethod(true,"Group",(Object)(BA.numberCast(int.class, 1)));Debug.locals.put("Module", _module);Debug.locals.put("Module", _module);
 BA.debugLineNum = 49;BA.debugLine="Dim LineNumber As Int = m.Group(2) - 1";
Debug.JustUpdateDeviceLine();
_linenumber = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {BA.numberCast(double.class, _m.runMethod(true,"Group",(Object)(BA.numberCast(int.class, 2)))),RemoteObject.createImmutable(1)}, "-",1, 0));Debug.locals.put("LineNumber", _linenumber);Debug.locals.put("LineNumber", _linenumber);
 BA.debugLineNum = 50;BA.debugLine="If FilesCache.ContainsKey(Module) = False Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_filescache" /*RemoteObject*/ ).runMethod(true,"ContainsKey",(Object)((_module))),pyerrorhandler.__c.getField(true,"False"))) { 
 BA.debugLineNum = 51;BA.debugLine="Dim folder As String = File.Combine(File.DirApp,";
Debug.JustUpdateDeviceLine();
_folder = pyerrorhandler.__c.getField(false,"File").runMethod(true,"Combine",(Object)(pyerrorhandler.__c.getField(false,"File").runMethod(true,"getDirApp")),(Object)(RemoteObject.concat(RemoteObject.createImmutable("src\\"),__ref.getField(false,"_mutils" /*RemoteObject*/ ).getField(true,"_packagename" /*RemoteObject*/ ).runMethod(true,"replace",(Object)(BA.ObjectToString(".")),(Object)(RemoteObject.createImmutable("\\"))))));Debug.locals.put("folder", _folder);Debug.locals.put("folder", _folder);
 BA.debugLineNum = 52;BA.debugLine="Dim ffile As String = Module & \".java\"";
Debug.JustUpdateDeviceLine();
_ffile = RemoteObject.concat(_module,RemoteObject.createImmutable(".java"));Debug.locals.put("ffile", _ffile);Debug.locals.put("ffile", _ffile);
 BA.debugLineNum = 53;BA.debugLine="If File.Exists(folder, ffile) Then";
Debug.JustUpdateDeviceLine();
if (pyerrorhandler.__c.getField(false,"File").runMethod(true,"Exists",(Object)(_folder),(Object)(_ffile)).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 54;BA.debugLine="FilesCache.Put(Module, File.ReadList(folder, ff";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_filescache" /*RemoteObject*/ ).runVoidMethod ("Put",(Object)((_module)),(Object)((pyerrorhandler.__c.getField(false,"File").runMethod(false,"ReadList",(Object)(_folder),(Object)(_ffile)).getObject())));
 }else {
 BA.debugLineNum = 56;BA.debugLine="FilesCache.Put(Module, Null)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_filescache" /*RemoteObject*/ ).runVoidMethod ("Put",(Object)((_module)),(Object)(pyerrorhandler.__c.getField(false,"Null")));
 };
 };
 BA.debugLineNum = 59;BA.debugLine="Dim lines As List = FilesCache.Get(Module)";
Debug.JustUpdateDeviceLine();
_lines = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");
_lines = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), __ref.getField(false,"_filescache" /*RemoteObject*/ ).runMethod(false,"Get",(Object)((_module))));Debug.locals.put("lines", _lines);Debug.locals.put("lines", _lines);
 BA.debugLineNum = 60;BA.debugLine="If NotInitialized(lines) Then Return";
Debug.JustUpdateDeviceLine();
if (pyerrorhandler.__c.runMethod(true,"NotInitialized",(Object)((_lines))).<Boolean>get().booleanValue()) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 61;BA.debugLine="For i = LineNumber To Max(0, LineNumber - 10) Ste";
Debug.JustUpdateDeviceLine();
{
final int step16 = -1;
final int limit16 = (int) (0 + pyerrorhandler.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_linenumber,RemoteObject.createImmutable(10)}, "-",1, 1)))).<Double>get().doubleValue());
_i = _linenumber.<Integer>get().intValue() ;
for (;(step16 > 0 && _i <= limit16) || (step16 < 0 && _i >= limit16) ;_i = ((int)(0 + _i + step16))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 62;BA.debugLine="Dim line As String = lines.Get(i)";
Debug.JustUpdateDeviceLine();
_line = BA.ObjectToString(_lines.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("line", _line);Debug.locals.put("line", _line);
 BA.debugLineNum = 63;BA.debugLine="If line.StartsWith(\" //BA.debugLineNum\") Then";
Debug.JustUpdateDeviceLine();
if (_line.runMethod(true,"startsWith",(Object)(RemoteObject.createImmutable(" //BA.debugLineNum"))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 64;BA.debugLine="m = Regex.Matcher(\"BA\\.debugLineNum\\s*=\\s*(\\d+)";
Debug.JustUpdateDeviceLine();
_m = pyerrorhandler.__c.getField(false,"Regex").runMethod(false,"Matcher",(Object)(BA.ObjectToString("BA\\.debugLineNum\\s*=\\s*(\\d+);")),(Object)(_line));Debug.locals.put("m", _m);
 BA.debugLineNum = 65;BA.debugLine="If m.Find Then";
Debug.JustUpdateDeviceLine();
if (_m.runMethod(true,"Find").<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 66;BA.debugLine="BAClass.RunMethod(\"Log\", Array(\"~de:\" & Module";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_baclass" /*RemoteObject*/ ).runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("Log")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(RemoteObject.concat(RemoteObject.createImmutable("~de:"),_module,RemoteObject.createImmutable(","),_m.runMethod(true,"Group",(Object)(BA.numberCast(int.class, 1)))))})));
 BA.debugLineNum = 67;BA.debugLine="Exit";
Debug.JustUpdateDeviceLine();
if (true) break;
 };
 };
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 72;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}