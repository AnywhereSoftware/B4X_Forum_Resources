package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class copyonwritemap_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 9;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 10;BA.debugLine="Private InternalMap As Map";
copyonwritemap._internalmap = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");__ref.setField("_internalmap",copyonwritemap._internalmap);
 //BA.debugLineNum = 11;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _clear(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Clear (copyonwritemap) ","copyonwritemap",17,__ref.getField(false, "ba"),__ref,40);
if (RapidSub.canDelegate("clear")) { return __ref.runUserSub(false, "copyonwritemap","clear", __ref);}
 BA.debugLineNum = 40;BA.debugLine="Public Sub Clear";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 41;BA.debugLine="Dim InternalMap As Map";
Debug.JustUpdateDeviceLine();
copyonwritemap._internalmap = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");__ref.setField("_internalmap",copyonwritemap._internalmap);
 BA.debugLineNum = 42;BA.debugLine="InternalMap.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_internalmap" /*RemoteObject*/ ).runVoidMethod ("Initialize");
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
public static RemoteObject  _containskey(RemoteObject __ref,RemoteObject _key) throws Exception{
try {
		Debug.PushSubsStack("ContainsKey (copyonwritemap) ","copyonwritemap",17,__ref.getField(false, "ba"),__ref,49);
if (RapidSub.canDelegate("containskey")) { return __ref.runUserSub(false, "copyonwritemap","containskey", __ref, _key);}
Debug.locals.put("Key", _key);
 BA.debugLineNum = 49;BA.debugLine="Public Sub ContainsKey (Key As Object) As Boolean";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 50;BA.debugLine="Return InternalMap.ContainsKey(Key)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_internalmap" /*RemoteObject*/ ).runMethod(true,"ContainsKey",(Object)(_key));
 BA.debugLineNum = 51;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _copymap(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("CopyMap (copyonwritemap) ","copyonwritemap",17,__ref.getField(false, "ba"),__ref,18);
if (RapidSub.canDelegate("copymap")) { return __ref.runUserSub(false, "copyonwritemap","copymap", __ref);}
 BA.debugLineNum = 18;BA.debugLine="Private Sub CopyMap";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 19;BA.debugLine="InternalMap = B4XCollections.MergeMaps(InternalMa";
Debug.JustUpdateDeviceLine();
__ref.setField ("_internalmap" /*RemoteObject*/ ,copyonwritemap._b4xcollections.runMethod(false,"_mergemaps" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_internalmap" /*RemoteObject*/ )),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), copyonwritemap.__c.getField(false,"Null"))));
 BA.debugLineNum = 20;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get(RemoteObject __ref,RemoteObject _key) throws Exception{
try {
		Debug.PushSubsStack("Get (copyonwritemap) ","copyonwritemap",17,__ref.getField(false, "ba"),__ref,22);
if (RapidSub.canDelegate("get")) { return __ref.runUserSub(false, "copyonwritemap","get", __ref, _key);}
Debug.locals.put("Key", _key);
 BA.debugLineNum = 22;BA.debugLine="Public Sub Get (Key As Object) As Object";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 23;BA.debugLine="Return InternalMap.Get(Key)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_internalmap" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(_key));
 BA.debugLineNum = 24;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getdefault(RemoteObject __ref,RemoteObject _key,RemoteObject _default) throws Exception{
try {
		Debug.PushSubsStack("GetDefault (copyonwritemap) ","copyonwritemap",17,__ref.getField(false, "ba"),__ref,26);
if (RapidSub.canDelegate("getdefault")) { return __ref.runUserSub(false, "copyonwritemap","getdefault", __ref, _key, _default);}
Debug.locals.put("Key", _key);
Debug.locals.put("Default", _default);
 BA.debugLineNum = 26;BA.debugLine="Public Sub GetDefault (Key As Object, Default As O";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 27;BA.debugLine="Return InternalMap.GetDefault(Key, Default)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_internalmap" /*RemoteObject*/ ).runMethod(false,"GetDefault",(Object)(_key),(Object)(_default));
 BA.debugLineNum = 28;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getmap(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("GetMap (copyonwritemap) ","copyonwritemap",17,__ref.getField(false, "ba"),__ref,54);
if (RapidSub.canDelegate("getmap")) { return __ref.runUserSub(false, "copyonwritemap","getmap", __ref);}
 BA.debugLineNum = 54;BA.debugLine="Public Sub GetMap As Map";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 55;BA.debugLine="Return InternalMap";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_internalmap" /*RemoteObject*/ );
 BA.debugLineNum = 56;BA.debugLine="End Sub";
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
		Debug.PushSubsStack("getSize (copyonwritemap) ","copyonwritemap",17,__ref.getField(false, "ba"),__ref,45);
if (RapidSub.canDelegate("getsize")) { return __ref.runUserSub(false, "copyonwritemap","getsize", __ref);}
 BA.debugLineNum = 45;BA.debugLine="Public Sub getSize As Int";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 46;BA.debugLine="Return InternalMap.Size";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_internalmap" /*RemoteObject*/ ).runMethod(true,"getSize");
 BA.debugLineNum = 47;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _initialitems) throws Exception{
try {
		Debug.PushSubsStack("Initialize (copyonwritemap) ","copyonwritemap",17,__ref.getField(false, "ba"),__ref,14);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "copyonwritemap","initialize", __ref, _ba, _initialitems);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
Debug.locals.put("InitialItems", _initialitems);
 BA.debugLineNum = 14;BA.debugLine="Public Sub Initialize (InitialItems As Map)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 15;BA.debugLine="InternalMap = B4XCollections.MergeMaps(InitialIte";
Debug.JustUpdateDeviceLine();
__ref.setField ("_internalmap" /*RemoteObject*/ ,copyonwritemap._b4xcollections.runMethod(false,"_mergemaps" /*RemoteObject*/ ,(Object)(_initialitems),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), copyonwritemap.__c.getField(false,"Null"))));
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
public static RemoteObject  _put(RemoteObject __ref,RemoteObject _key,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("Put (copyonwritemap) ","copyonwritemap",17,__ref.getField(false, "ba"),__ref,30);
if (RapidSub.canDelegate("put")) { return __ref.runUserSub(false, "copyonwritemap","put", __ref, _key, _value);}
Debug.locals.put("Key", _key);
Debug.locals.put("Value", _value);
 BA.debugLineNum = 30;BA.debugLine="Public Sub Put (Key As Object, Value As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 31;BA.debugLine="CopyMap";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.copyonwritemap.class, "_copymap" /*RemoteObject*/ );
 BA.debugLineNum = 32;BA.debugLine="InternalMap.Put(Key, Value)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_internalmap" /*RemoteObject*/ ).runVoidMethod ("Put",(Object)(_key),(Object)(_value));
 BA.debugLineNum = 33;BA.debugLine="End Sub";
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
		Debug.PushSubsStack("Remove (copyonwritemap) ","copyonwritemap",17,__ref.getField(false, "ba"),__ref,35);
if (RapidSub.canDelegate("remove")) { return __ref.runUserSub(false, "copyonwritemap","remove", __ref, _key);}
Debug.locals.put("Key", _key);
 BA.debugLineNum = 35;BA.debugLine="Public Sub Remove (Key As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 36;BA.debugLine="CopyMap";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.copyonwritemap.class, "_copymap" /*RemoteObject*/ );
 BA.debugLineNum = 37;BA.debugLine="InternalMap.Remove(Key)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_internalmap" /*RemoteObject*/ ).runVoidMethod ("Remove",(Object)(_key));
 BA.debugLineNum = 38;BA.debugLine="End Sub";
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