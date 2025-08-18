package b4j.HTMLEditorFix;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xset_subs_0 {


public static RemoteObject  _add(RemoteObject __ref,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("Add (b4xset) ","b4xset",7,__ref.getField(false, "ba"),__ref,9);
if (RapidSub.canDelegate("add")) { return __ref.runUserSub(false, "b4xset","add", __ref, _value);}
Debug.locals.put("Value", _value);
 BA.debugLineNum = 9;BA.debugLine="Public Sub Add(Value As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 10;BA.debugLine="map.Put(Value, \"\")";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_map" /*RemoteObject*/ ).runClassMethod (b4j.HTMLEditorFix.b4xorderedmap.class, "_put" /*RemoteObject*/ ,(Object)(_value),(Object)((RemoteObject.createImmutable(""))));
 BA.debugLineNum = 11;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _aslist(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("AsList (b4xset) ","b4xset",7,__ref.getField(false, "ba"),__ref,29);
if (RapidSub.canDelegate("aslist")) { return __ref.runUserSub(false, "b4xset","aslist", __ref);}
 BA.debugLineNum = 29;BA.debugLine="Public Sub AsList As List";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 30;BA.debugLine="Return map.Keys";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_map" /*RemoteObject*/ ).runClassMethod (b4j.HTMLEditorFix.b4xorderedmap.class, "_getkeys" /*RemoteObject*/ );
 BA.debugLineNum = 31;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 1;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 2;BA.debugLine="Private map As B4XOrderedMap";
b4xset._map = RemoteObject.createNew ("b4j.HTMLEditorFix.b4xorderedmap");__ref.setField("_map",b4xset._map);
 //BA.debugLineNum = 3;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _clear(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Clear (b4xset) ","b4xset",7,__ref.getField(false, "ba"),__ref,25);
if (RapidSub.canDelegate("clear")) { return __ref.runUserSub(false, "b4xset","clear", __ref);}
 BA.debugLineNum = 25;BA.debugLine="Public Sub Clear";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 26;BA.debugLine="map.Clear";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_map" /*RemoteObject*/ ).runClassMethod (b4j.HTMLEditorFix.b4xorderedmap.class, "_clear" /*RemoteObject*/ );
 BA.debugLineNum = 27;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _contains(RemoteObject __ref,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("Contains (b4xset) ","b4xset",7,__ref.getField(false, "ba"),__ref,17);
if (RapidSub.canDelegate("contains")) { return __ref.runUserSub(false, "b4xset","contains", __ref, _value);}
Debug.locals.put("Value", _value);
 BA.debugLineNum = 17;BA.debugLine="Public Sub Contains (Value As Object) As Boolean";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 18;BA.debugLine="Return map.ContainsKey(Value)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_map" /*RemoteObject*/ ).runClassMethod (b4j.HTMLEditorFix.b4xorderedmap.class, "_containskey" /*RemoteObject*/ ,(Object)(_value));
 BA.debugLineNum = 19;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getsize(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getSize (b4xset) ","b4xset",7,__ref.getField(false, "ba"),__ref,21);
if (RapidSub.canDelegate("getsize")) { return __ref.runUserSub(false, "b4xset","getsize", __ref);}
 BA.debugLineNum = 21;BA.debugLine="Public Sub getSize As Int";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 22;BA.debugLine="Return map.Size";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_map" /*RemoteObject*/ ).runClassMethod (b4j.HTMLEditorFix.b4xorderedmap.class, "_getsize" /*RemoteObject*/ );
 BA.debugLineNum = 23;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (b4xset) ","b4xset",7,__ref.getField(false, "ba"),__ref,5);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "b4xset","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 5;BA.debugLine="Public Sub Initialize";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 6;BA.debugLine="map.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_map" /*RemoteObject*/ ).runClassMethod (b4j.HTMLEditorFix.b4xorderedmap.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"));
 BA.debugLineNum = 7;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _remove(RemoteObject __ref,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("Remove (b4xset) ","b4xset",7,__ref.getField(false, "ba"),__ref,13);
if (RapidSub.canDelegate("remove")) { return __ref.runUserSub(false, "b4xset","remove", __ref, _value);}
Debug.locals.put("Value", _value);
 BA.debugLineNum = 13;BA.debugLine="Public Sub Remove(Value As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 14;BA.debugLine="map.Remove(Value)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_map" /*RemoteObject*/ ).runClassMethod (b4j.HTMLEditorFix.b4xorderedmap.class, "_remove" /*RemoteObject*/ ,(Object)(_value));
 BA.debugLineNum = 15;BA.debugLine="End Sub";
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