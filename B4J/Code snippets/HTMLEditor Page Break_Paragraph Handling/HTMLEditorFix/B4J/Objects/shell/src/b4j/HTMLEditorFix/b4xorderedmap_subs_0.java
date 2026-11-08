package b4j.HTMLEditorFix;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xorderedmap_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 1;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 2;BA.debugLine="Private map As Map";
b4xorderedmap._map = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");__ref.setField("_map",b4xorderedmap._map);
 //BA.debugLineNum = 3;BA.debugLine="Private list As List";
b4xorderedmap._list = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");__ref.setField("_list",b4xorderedmap._list);
 //BA.debugLineNum = 4;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _clear(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Clear (b4xorderedmap) ","b4xorderedmap",6,__ref.getField(false, "ba"),__ref,26);
if (RapidSub.canDelegate("clear")) { return __ref.runUserSub(false, "b4xorderedmap","clear", __ref);}
 BA.debugLineNum = 26;BA.debugLine="Public Sub Clear";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 27;BA.debugLine="list.Clear";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_list" /*RemoteObject*/ ).runVoidMethod ("Clear");
 BA.debugLineNum = 28;BA.debugLine="map.Clear";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_map" /*RemoteObject*/ ).runVoidMethod ("Clear");
 BA.debugLineNum = 29;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _containskey(RemoteObject __ref,RemoteObject _key) throws Exception{
try {
		Debug.PushSubsStack("ContainsKey (b4xorderedmap) ","b4xorderedmap",6,__ref.getField(false, "ba"),__ref,46);
if (RapidSub.canDelegate("containskey")) { return __ref.runUserSub(false, "b4xorderedmap","containskey", __ref, _key);}
Debug.locals.put("Key", _key);
 BA.debugLineNum = 46;BA.debugLine="Public Sub ContainsKey (Key As Object) As Boolean";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 47;BA.debugLine="Return map.ContainsKey(Key)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_map" /*RemoteObject*/ ).runMethod(true,"ContainsKey",(Object)(_key));
 BA.debugLineNum = 48;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get(RemoteObject __ref,RemoteObject _key) throws Exception{
try {
		Debug.PushSubsStack("Get (b4xorderedmap) ","b4xorderedmap",6,__ref.getField(false, "ba"),__ref,37);
if (RapidSub.canDelegate("get")) { return __ref.runUserSub(false, "b4xorderedmap","get", __ref, _key);}
Debug.locals.put("Key", _key);
 BA.debugLineNum = 37;BA.debugLine="Public Sub Get (Key As Object) As Object";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 38;BA.debugLine="Return map.Get(Key)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_map" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(_key));
 BA.debugLineNum = 39;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getdataforserializator(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("GetDataForSerializator (b4xorderedmap) ","b4xorderedmap",6,__ref.getField(false, "ba"),__ref,65);
if (RapidSub.canDelegate("getdataforserializator")) { return __ref.runUserSub(false, "b4xorderedmap","getdataforserializator", __ref);}
 BA.debugLineNum = 65;BA.debugLine="Public Sub GetDataForSerializator As Object";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 66;BA.debugLine="Return Array(map, list)";
Debug.JustUpdateDeviceLine();
if (true) return (RemoteObject.createNewArray("Object",new int[] {2},new Object[] {(__ref.getField(false,"_map" /*RemoteObject*/ ).getObject()),(__ref.getField(false,"_list" /*RemoteObject*/ ).getObject())}));
 BA.debugLineNum = 67;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getdefault(RemoteObject __ref,RemoteObject _key,RemoteObject _defaultvalue) throws Exception{
try {
		Debug.PushSubsStack("GetDefault (b4xorderedmap) ","b4xorderedmap",6,__ref.getField(false, "ba"),__ref,42);
if (RapidSub.canDelegate("getdefault")) { return __ref.runUserSub(false, "b4xorderedmap","getdefault", __ref, _key, _defaultvalue);}
Debug.locals.put("Key", _key);
Debug.locals.put("DefaultValue", _defaultvalue);
 BA.debugLineNum = 42;BA.debugLine="Public Sub GetDefault (Key As Object, DefaultValue";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 43;BA.debugLine="Return map.GetDefault(Key, DefaultValue)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_map" /*RemoteObject*/ ).runMethod(false,"GetDefault",(Object)(_key),(Object)(_defaultvalue));
 BA.debugLineNum = 44;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getkeys(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getKeys (b4xorderedmap) ","b4xorderedmap",6,__ref.getField(false, "ba"),__ref,32);
if (RapidSub.canDelegate("getkeys")) { return __ref.runUserSub(false, "b4xorderedmap","getkeys", __ref);}
 BA.debugLineNum = 32;BA.debugLine="Public Sub getKeys As List";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 33;BA.debugLine="Return list";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_list" /*RemoteObject*/ );
 BA.debugLineNum = 34;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getsize(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getSize (b4xorderedmap) ","b4xorderedmap",6,__ref.getField(false, "ba"),__ref,50);
if (RapidSub.canDelegate("getsize")) { return __ref.runUserSub(false, "b4xorderedmap","getsize", __ref);}
 BA.debugLineNum = 50;BA.debugLine="Public Sub getSize As Int";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 51;BA.debugLine="Return map.Size";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_map" /*RemoteObject*/ ).runMethod(true,"getSize");
 BA.debugLineNum = 52;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getvalues(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getValues (b4xorderedmap) ","b4xorderedmap",6,__ref.getField(false, "ba"),__ref,55);
if (RapidSub.canDelegate("getvalues")) { return __ref.runUserSub(false, "b4xorderedmap","getvalues", __ref);}
RemoteObject _res = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _key = RemoteObject.declareNull("Object");
 BA.debugLineNum = 55;BA.debugLine="Public Sub getValues As List";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 56;BA.debugLine="Dim res As List";
Debug.JustUpdateDeviceLine();
_res = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("res", _res);
 BA.debugLineNum = 57;BA.debugLine="res.Initialize";
Debug.JustUpdateDeviceLine();
_res.runVoidMethod ("Initialize");
 BA.debugLineNum = 58;BA.debugLine="For Each key As Object In list";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group3 = __ref.getField(false,"_list" /*RemoteObject*/ );
final int groupLen3 = group3.runMethod(true,"getSize").<Integer>get()
;int index3 = 0;
;
for (; index3 < groupLen3;index3++){
_key = group3.runMethod(false,"Get",index3);Debug.locals.put("key", _key);
Debug.locals.put("key", _key);
 BA.debugLineNum = 59;BA.debugLine="res.Add(map.Get(key))";
Debug.JustUpdateDeviceLine();
_res.runVoidMethod ("Add",(Object)(__ref.getField(false,"_map" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(_key))));
 }
}Debug.locals.put("key", _key);
;
 BA.debugLineNum = 61;BA.debugLine="Return res";
Debug.JustUpdateDeviceLine();
if (true) return _res;
 BA.debugLineNum = 62;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (b4xorderedmap) ","b4xorderedmap",6,__ref.getField(false, "ba"),__ref,6);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "b4xorderedmap","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 6;BA.debugLine="Public Sub Initialize";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 7;BA.debugLine="map.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_map" /*RemoteObject*/ ).runVoidMethod ("Initialize");
 BA.debugLineNum = 8;BA.debugLine="list.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_list" /*RemoteObject*/ ).runVoidMethod ("Initialize");
 BA.debugLineNum = 9;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _put(RemoteObject __ref,RemoteObject _key,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("Put (b4xorderedmap) ","b4xorderedmap",6,__ref.getField(false, "ba"),__ref,12);
if (RapidSub.canDelegate("put")) { return __ref.runUserSub(false, "b4xorderedmap","put", __ref, _key, _value);}
Debug.locals.put("Key", _key);
Debug.locals.put("Value", _value);
 BA.debugLineNum = 12;BA.debugLine="Public Sub Put (Key As Object, Value As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 13;BA.debugLine="If map.ContainsKey(Key) = False Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_map" /*RemoteObject*/ ).runMethod(true,"ContainsKey",(Object)(_key)),b4xorderedmap.__c.getField(true,"False"))) { 
 BA.debugLineNum = 14;BA.debugLine="list.Add(Key)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_list" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)(_key));
 };
 BA.debugLineNum = 16;BA.debugLine="map.Put(Key, Value)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_map" /*RemoteObject*/ ).runVoidMethod ("Put",(Object)(_key),(Object)(_value));
 BA.debugLineNum = 17;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _remove(RemoteObject __ref,RemoteObject _key) throws Exception{
try {
		Debug.PushSubsStack("Remove (b4xorderedmap) ","b4xorderedmap",6,__ref.getField(false, "ba"),__ref,20);
if (RapidSub.canDelegate("remove")) { return __ref.runUserSub(false, "b4xorderedmap","remove", __ref, _key);}
Debug.locals.put("Key", _key);
 BA.debugLineNum = 20;BA.debugLine="Public Sub Remove (Key As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 21;BA.debugLine="If map.ContainsKey(Key) = False Then Return";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_map" /*RemoteObject*/ ).runMethod(true,"ContainsKey",(Object)(_key)),b4xorderedmap.__c.getField(true,"False"))) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 22;BA.debugLine="list.RemoveAt(list.IndexOf(Key))";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_list" /*RemoteObject*/ ).runVoidMethod ("RemoveAt",(Object)(__ref.getField(false,"_list" /*RemoteObject*/ ).runMethod(true,"IndexOf",(Object)(_key))));
 BA.debugLineNum = 23;BA.debugLine="map.Remove(Key)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_map" /*RemoteObject*/ ).runVoidMethod ("Remove",(Object)(_key));
 BA.debugLineNum = 24;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setdatafromserializator(RemoteObject __ref,RemoteObject _data) throws Exception{
try {
		Debug.PushSubsStack("SetDataFromSerializator (b4xorderedmap) ","b4xorderedmap",6,__ref.getField(false, "ba"),__ref,70);
if (RapidSub.canDelegate("setdatafromserializator")) { return __ref.runUserSub(false, "b4xorderedmap","setdatafromserializator", __ref, _data);}
RemoteObject _o = null;
Debug.locals.put("Data", _data);
 BA.debugLineNum = 70;BA.debugLine="Public Sub SetDataFromSerializator (Data As Object";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 71;BA.debugLine="Dim o() As Object = Data";
Debug.JustUpdateDeviceLine();
_o = (_data);Debug.locals.put("o", _o);Debug.locals.put("o", _o);
 BA.debugLineNum = 72;BA.debugLine="map = o(0)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_map" /*RemoteObject*/ ).setObject (_o.getArrayElement(false,BA.numberCast(int.class, 0)));
 BA.debugLineNum = 73;BA.debugLine="list = o(1)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_list" /*RemoteObject*/ ).setObject (_o.getArrayElement(false,BA.numberCast(int.class, 1)));
 BA.debugLineNum = 74;BA.debugLine="End Sub";
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