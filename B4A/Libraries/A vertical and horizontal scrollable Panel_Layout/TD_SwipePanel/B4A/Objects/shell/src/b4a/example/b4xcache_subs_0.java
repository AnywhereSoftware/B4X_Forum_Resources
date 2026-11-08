package b4a.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xcache_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 1;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 2;BA.debugLine="Type B4XCacheItem (Value As Object, LastAccessedT";
;
 //BA.debugLineNum = 3;BA.debugLine="Private Data As B4XOrderedMap";
b4xcache._data = RemoteObject.createNew ("b4a.example.b4xorderedmap");__ref.setField("_data",b4xcache._data);
 //BA.debugLineNum = 4;BA.debugLine="Private mMaxSize As Int = 100";
b4xcache._mmaxsize = BA.numberCast(int.class, 100);__ref.setField("_mmaxsize",b4xcache._mmaxsize);
 //BA.debugLineNum = 5;BA.debugLine="Private RemoveThreshold As Float = 0.3";
b4xcache._removethreshold = BA.numberCast(float.class, 0.3);__ref.setField("_removethreshold",b4xcache._removethreshold);
 //BA.debugLineNum = 6;BA.debugLine="Private EternalCounts As Int";
b4xcache._eternalcounts = RemoteObject.createImmutable(0);__ref.setField("_eternalcounts",b4xcache._eternalcounts);
 //BA.debugLineNum = 7;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _containskey(RemoteObject __ref,RemoteObject _key) throws Exception{
try {
		Debug.PushSubsStack("ContainsKey (b4xcache) ","b4xcache",7,__ref.getField(false, "ba"),__ref,66);
if (RapidSub.canDelegate("containskey")) { return __ref.runUserSub(false, "b4xcache","containskey", __ref, _key);}
Debug.locals.put("Key", _key);
 BA.debugLineNum = 66;BA.debugLine="Public Sub ContainsKey(Key As String) As Boolean";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 67;BA.debugLine="Return Data.ContainsKey(Key)";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return __ref.getField(false,"_data" /*RemoteObject*/ ).runClassMethod (b4a.example.b4xorderedmap.class, "_containskey" /*RemoteObject*/ ,(Object)((_key)));
 BA.debugLineNum = 68;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createb4xcacheitem(RemoteObject __ref,RemoteObject _value,RemoteObject _key) throws Exception{
try {
		Debug.PushSubsStack("CreateB4XCacheItem (b4xcache) ","b4xcache",7,__ref.getField(false, "ba"),__ref,102);
if (RapidSub.canDelegate("createb4xcacheitem")) { return __ref.runUserSub(false, "b4xcache","createb4xcacheitem", __ref, _value, _key);}
RemoteObject _t1 = RemoteObject.declareNull("b4a.example.b4xcache._b4xcacheitem");
Debug.locals.put("Value", _value);
Debug.locals.put("Key", _key);
 BA.debugLineNum = 102;BA.debugLine="Private Sub CreateB4XCacheItem (Value As Object, K";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 103;BA.debugLine="Dim t1 As B4XCacheItem";
Debug.JustUpdateDeviceLine();
_t1 = RemoteObject.createNew ("b4a.example.b4xcache._b4xcacheitem");Debug.locals.put("t1", _t1);
 BA.debugLineNum = 104;BA.debugLine="t1.Initialize";
Debug.JustUpdateDeviceLine();
_t1.runVoidMethod ("Initialize");
 BA.debugLineNum = 105;BA.debugLine="t1.Value = Value";
Debug.JustUpdateDeviceLine();
_t1.setField ("Value" /*RemoteObject*/ ,_value);
 BA.debugLineNum = 106;BA.debugLine="t1.LastAccessedTime = DateTime.Now";
Debug.JustUpdateDeviceLine();
_t1.setField ("LastAccessedTime" /*RemoteObject*/ ,b4xcache.__c.getField(false,"DateTime").runMethod(true,"getNow"));
 BA.debugLineNum = 107;BA.debugLine="t1.Key = Key";
Debug.JustUpdateDeviceLine();
_t1.setField ("Key" /*RemoteObject*/ ,_key);
 BA.debugLineNum = 108;BA.debugLine="Return t1";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return _t1;
 BA.debugLineNum = 109;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get(RemoteObject __ref,RemoteObject _key) throws Exception{
try {
		Debug.PushSubsStack("Get (b4xcache) ","b4xcache",7,__ref.getField(false, "ba"),__ref,24);
if (RapidSub.canDelegate("get")) { return __ref.runUserSub(false, "b4xcache","get", __ref, _key);}
RemoteObject _ci = RemoteObject.declareNull("b4a.example.b4xcache._b4xcacheitem");
Debug.locals.put("Key", _key);
 BA.debugLineNum = 24;BA.debugLine="Public Sub Get (Key As String) As Object";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 25;BA.debugLine="Dim ci As B4XCacheItem = Data.Get(Key)";
Debug.JustUpdateDeviceLine();
_ci = (__ref.getField(false,"_data" /*RemoteObject*/ ).runClassMethod (b4a.example.b4xorderedmap.class, "_get" /*RemoteObject*/ ,(Object)((_key))));Debug.locals.put("ci", _ci);Debug.locals.put("ci", _ci);
 BA.debugLineNum = 26;BA.debugLine="If ci <> Null Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("N",_ci)) { 
 BA.debugLineNum = 27;BA.debugLine="If ci.Eternal = False Then ci.LastAccessedTime =";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_ci.getField(true,"Eternal" /*RemoteObject*/ ),b4xcache.__c.getField(true,"False"))) { 
_ci.setField ("LastAccessedTime" /*RemoteObject*/ ,b4xcache.__c.getField(false,"DateTime").runMethod(true,"getNow"));};
 BA.debugLineNum = 28;BA.debugLine="Return ci.Value";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return _ci.getField(false,"Value" /*RemoteObject*/ );
 };
 BA.debugLineNum = 30;BA.debugLine="Return Null";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return b4xcache.__c.getField(false,"Null");
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
public static RemoteObject  _getmaxsize(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getMaxSize (b4xcache) ","b4xcache",7,__ref.getField(false, "ba"),__ref,19);
if (RapidSub.canDelegate("getmaxsize")) { return __ref.runUserSub(false, "b4xcache","getmaxsize", __ref);}
 BA.debugLineNum = 19;BA.debugLine="Public Sub getMaxSize As Int";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 20;BA.debugLine="Return mMaxSize";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return __ref.getField(true,"_mmaxsize" /*RemoteObject*/ );
 BA.debugLineNum = 21;BA.debugLine="End Sub";
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
		Debug.PushSubsStack("Initialize (b4xcache) ","b4xcache",7,__ref.getField(false, "ba"),__ref,9);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "b4xcache","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 9;BA.debugLine="Public Sub Initialize";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 10;BA.debugLine="Data.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_data" /*RemoteObject*/ ).runClassMethod (b4a.example.b4xorderedmap.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"));
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
public static RemoteObject  _iseternal(RemoteObject __ref,RemoteObject _key) throws Exception{
try {
		Debug.PushSubsStack("IsEternal (b4xcache) ","b4xcache",7,__ref.getField(false, "ba"),__ref,60);
if (RapidSub.canDelegate("iseternal")) { return __ref.runUserSub(false, "b4xcache","iseternal", __ref, _key);}
RemoteObject _ci = RemoteObject.declareNull("b4a.example.b4xcache._b4xcacheitem");
Debug.locals.put("Key", _key);
 BA.debugLineNum = 60;BA.debugLine="Private Sub IsEternal(Key As String) As Boolean";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 61;BA.debugLine="Dim ci As B4XCacheItem = Data.Get(Key)";
Debug.JustUpdateDeviceLine();
_ci = (__ref.getField(false,"_data" /*RemoteObject*/ ).runClassMethod (b4a.example.b4xorderedmap.class, "_get" /*RemoteObject*/ ,(Object)((_key))));Debug.locals.put("ci", _ci);Debug.locals.put("ci", _ci);
 BA.debugLineNum = 62;BA.debugLine="Return IIf(ci = Null, False, ci.Eternal)";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return BA.ObjectToBoolean(((RemoteObject.solveBoolean("n",_ci)) ? ((b4xcache.__c.getField(true,"False"))) : ((_ci.getField(true,"Eternal" /*RemoteObject*/ )))));
 BA.debugLineNum = 63;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _keys(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Keys (b4xcache) ","b4xcache",7,__ref.getField(false, "ba"),__ref,98);
if (RapidSub.canDelegate("keys")) { return __ref.runUserSub(false, "b4xcache","keys", __ref);}
 BA.debugLineNum = 98;BA.debugLine="Public Sub Keys As List";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 99;BA.debugLine="Return Data.Keys";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return __ref.getField(false,"_data" /*RemoteObject*/ ).runClassMethod (b4a.example.b4xorderedmap.class, "_getkeys" /*RemoteObject*/ );
 BA.debugLineNum = 100;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _put(RemoteObject __ref,RemoteObject _key,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("Put (b4xcache) ","b4xcache",7,__ref.getField(false, "ba"),__ref,35);
if (RapidSub.canDelegate("put")) { return __ref.runUserSub(false, "b4xcache","put", __ref, _key, _value);}
Debug.locals.put("Key", _key);
Debug.locals.put("Value", _value);
 BA.debugLineNum = 35;BA.debugLine="Public Sub Put (Key As String, Value As Object) As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 36;BA.debugLine="If IsEternal(Key) Then EternalCounts = EternalCou";
Debug.JustUpdateDeviceLine();
if (__ref.runClassMethod (b4a.example.b4xcache.class, "_iseternal" /*RemoteObject*/ ,(Object)(_key)).<Boolean>get().booleanValue()) { 
__ref.setField ("_eternalcounts" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_eternalcounts" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "-",1, 1));};
 BA.debugLineNum = 37;BA.debugLine="Data.Put(Key, CreateB4XCacheItem(Value, Key))";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_data" /*RemoteObject*/ ).runClassMethod (b4a.example.b4xorderedmap.class, "_put" /*RemoteObject*/ ,(Object)((_key)),(Object)((__ref.runClassMethod (b4a.example.b4xcache.class, "_createb4xcacheitem" /*RemoteObject*/ ,(Object)(_value),(Object)(_key)))));
 BA.debugLineNum = 38;BA.debugLine="TrimIfOversize";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4a.example.b4xcache.class, "_trimifoversize" /*RemoteObject*/ );
 BA.debugLineNum = 39;BA.debugLine="Return Value";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return _value;
 BA.debugLineNum = 40;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _puteternal(RemoteObject __ref,RemoteObject _key,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("PutEternal (b4xcache) ","b4xcache",7,__ref.getField(false, "ba"),__ref,44);
if (RapidSub.canDelegate("puteternal")) { return __ref.runUserSub(false, "b4xcache","puteternal", __ref, _key, _value);}
RemoteObject _ci = RemoteObject.declareNull("b4a.example.b4xcache._b4xcacheitem");
Debug.locals.put("Key", _key);
Debug.locals.put("Value", _value);
 BA.debugLineNum = 44;BA.debugLine="Public Sub PutEternal (Key As String, Value As Obj";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 45;BA.debugLine="If IsEternal(Key) Then EternalCounts = EternalCou";
Debug.JustUpdateDeviceLine();
if (__ref.runClassMethod (b4a.example.b4xcache.class, "_iseternal" /*RemoteObject*/ ,(Object)(_key)).<Boolean>get().booleanValue()) { 
__ref.setField ("_eternalcounts" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_eternalcounts" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "-",1, 1));};
 BA.debugLineNum = 46;BA.debugLine="Dim ci As B4XCacheItem = CreateB4XCacheItem(Value";
Debug.JustUpdateDeviceLine();
_ci = __ref.runClassMethod (b4a.example.b4xcache.class, "_createb4xcacheitem" /*RemoteObject*/ ,(Object)(_value),(Object)(_key));Debug.locals.put("ci", _ci);Debug.locals.put("ci", _ci);
 BA.debugLineNum = 47;BA.debugLine="ci.Eternal = True";
Debug.JustUpdateDeviceLine();
_ci.setField ("Eternal" /*RemoteObject*/ ,b4xcache.__c.getField(true,"True"));
 BA.debugLineNum = 48;BA.debugLine="ci.LastAccessedTime = 9223372036854775807";
Debug.JustUpdateDeviceLine();
_ci.setField ("LastAccessedTime" /*RemoteObject*/ ,BA.numberCast(long.class, 9223372036854775807L));
 BA.debugLineNum = 49;BA.debugLine="EternalCounts = EternalCounts + 1";
Debug.JustUpdateDeviceLine();
__ref.setField ("_eternalcounts" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_eternalcounts" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "+",1, 1));
 BA.debugLineNum = 50;BA.debugLine="Data.Put(Key, ci)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_data" /*RemoteObject*/ ).runClassMethod (b4a.example.b4xorderedmap.class, "_put" /*RemoteObject*/ ,(Object)((_key)),(Object)((_ci)));
 BA.debugLineNum = 51;BA.debugLine="Return Value";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return _value;
 BA.debugLineNum = 52;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _remove(RemoteObject __ref,RemoteObject _key) throws Exception{
try {
		Debug.PushSubsStack("Remove (b4xcache) ","b4xcache",7,__ref.getField(false, "ba"),__ref,55);
if (RapidSub.canDelegate("remove")) { return __ref.runUserSub(false, "b4xcache","remove", __ref, _key);}
Debug.locals.put("Key", _key);
 BA.debugLineNum = 55;BA.debugLine="Public Sub Remove (Key As String)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 56;BA.debugLine="If IsEternal(Key) Then EternalCounts = EternalCou";
Debug.JustUpdateDeviceLine();
if (__ref.runClassMethod (b4a.example.b4xcache.class, "_iseternal" /*RemoteObject*/ ,(Object)(_key)).<Boolean>get().booleanValue()) { 
__ref.setField ("_eternalcounts" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_eternalcounts" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "-",1, 1));};
 BA.debugLineNum = 57;BA.debugLine="Data.Remove(Key)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_data" /*RemoteObject*/ ).runClassMethod (b4a.example.b4xorderedmap.class, "_remove" /*RemoteObject*/ ,(Object)((_key)));
 BA.debugLineNum = 58;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _removeolditems(RemoteObject __ref,RemoteObject _agems) throws Exception{
try {
		Debug.PushSubsStack("RemoveOldItems (b4xcache) ","b4xcache",7,__ref.getField(false, "ba"),__ref,82);
if (RapidSub.canDelegate("removeolditems")) { return __ref.runUserSub(false, "b4xcache","removeolditems", __ref, _agems);}
RemoteObject _values = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _level = RemoteObject.createImmutable(0L);
RemoteObject _ci = RemoteObject.declareNull("b4a.example.b4xcache._b4xcacheitem");
Debug.locals.put("AgeMs", _agems);
 BA.debugLineNum = 82;BA.debugLine="Public Sub RemoveOldItems (AgeMs As Long)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 83;BA.debugLine="Dim values As List = Data.Values";
Debug.JustUpdateDeviceLine();
_values = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");
_values = __ref.getField(false,"_data" /*RemoteObject*/ ).runClassMethod (b4a.example.b4xorderedmap.class, "_getvalues" /*RemoteObject*/ );Debug.locals.put("values", _values);Debug.locals.put("values", _values);
 BA.debugLineNum = 84;BA.debugLine="Dim level As Long = DateTime.Now - AgeMs";
Debug.JustUpdateDeviceLine();
_level = RemoteObject.solve(new RemoteObject[] {b4xcache.__c.getField(false,"DateTime").runMethod(true,"getNow"),_agems}, "-",1, 2);Debug.locals.put("level", _level);Debug.locals.put("level", _level);
 BA.debugLineNum = 85;BA.debugLine="For Each ci As B4XCacheItem In values";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group3 = _values;
final int groupLen3 = group3.runMethod(true,"getSize").<Integer>get()
;int index3 = 0;
;
for (; index3 < groupLen3;index3++){
_ci = (group3.runMethod(false,"Get",index3));Debug.locals.put("ci", _ci);
Debug.locals.put("ci", _ci);
 BA.debugLineNum = 86;BA.debugLine="If ci.LastAccessedTime <= level Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("k",_ci.getField(true,"LastAccessedTime" /*RemoteObject*/ ),_level)) { 
 BA.debugLineNum = 87;BA.debugLine="Data.Remove(ci.Key)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_data" /*RemoteObject*/ ).runClassMethod (b4a.example.b4xorderedmap.class, "_remove" /*RemoteObject*/ ,(Object)((_ci.getField(true,"Key" /*RemoteObject*/ ))));
 };
 }
}Debug.locals.put("ci", _ci);
;
 BA.debugLineNum = 90;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setmaxsize(RemoteObject __ref,RemoteObject _s) throws Exception{
try {
		Debug.PushSubsStack("setMaxSize (b4xcache) ","b4xcache",7,__ref.getField(false, "ba"),__ref,14);
if (RapidSub.canDelegate("setmaxsize")) { return __ref.runUserSub(false, "b4xcache","setmaxsize", __ref, _s);}
Debug.locals.put("s", _s);
 BA.debugLineNum = 14;BA.debugLine="Public Sub setMaxSize(s As Int)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 15;BA.debugLine="mMaxSize = s";
Debug.JustUpdateDeviceLine();
__ref.setField ("_mmaxsize" /*RemoteObject*/ ,_s);
 BA.debugLineNum = 16;BA.debugLine="TrimIfOversize";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4a.example.b4xcache.class, "_trimifoversize" /*RemoteObject*/ );
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
public static RemoteObject  _size(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Size (b4xcache) ","b4xcache",7,__ref.getField(false, "ba"),__ref,93);
if (RapidSub.canDelegate("size")) { return __ref.runUserSub(false, "b4xcache","size", __ref);}
 BA.debugLineNum = 93;BA.debugLine="Public Sub Size As Int";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 94;BA.debugLine="Return Data.Size";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return __ref.getField(false,"_data" /*RemoteObject*/ ).runClassMethod (b4a.example.b4xorderedmap.class, "_getsize" /*RemoteObject*/ );
 BA.debugLineNum = 95;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _trimifoversize(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("TrimIfOversize (b4xcache) ","b4xcache",7,__ref.getField(false, "ba"),__ref,70);
if (RapidSub.canDelegate("trimifoversize")) { return __ref.runUserSub(false, "b4xcache","trimifoversize", __ref);}
RemoteObject _values = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _numberofitemstoremove = RemoteObject.createImmutable(0);
int _i = 0;
 BA.debugLineNum = 70;BA.debugLine="Private Sub TrimIfOversize";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 71;BA.debugLine="If Data.Size - EternalCounts > mMaxSize Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_data" /*RemoteObject*/ ).runClassMethod (b4a.example.b4xorderedmap.class, "_getsize" /*RemoteObject*/ ),__ref.getField(true,"_eternalcounts" /*RemoteObject*/ )}, "-",1, 1),BA.numberCast(double.class, __ref.getField(true,"_mmaxsize" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 72;BA.debugLine="Dim values As List = Data.Values";
Debug.JustUpdateDeviceLine();
_values = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");
_values = __ref.getField(false,"_data" /*RemoteObject*/ ).runClassMethod (b4a.example.b4xorderedmap.class, "_getvalues" /*RemoteObject*/ );Debug.locals.put("values", _values);Debug.locals.put("values", _values);
 BA.debugLineNum = 73;BA.debugLine="values.SortType(\"LastAccessedTime\", True)";
Debug.JustUpdateDeviceLine();
_values.runVoidMethod ("SortType",(Object)(BA.ObjectToString("LastAccessedTime")),(Object)(b4xcache.__c.getField(true,"True")));
 BA.debugLineNum = 74;BA.debugLine="Dim NumberOfItemsToRemove As Int = Ceil(mMaxSize";
Debug.JustUpdateDeviceLine();
_numberofitemstoremove = BA.numberCast(int.class, b4xcache.__c.runMethod(true,"Ceil",(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mmaxsize" /*RemoteObject*/ ),__ref.getField(true,"_removethreshold" /*RemoteObject*/ )}, "*",0, 0))));Debug.locals.put("NumberOfItemsToRemove", _numberofitemstoremove);Debug.locals.put("NumberOfItemsToRemove", _numberofitemstoremove);
 BA.debugLineNum = 75;BA.debugLine="For i = 0 To NumberOfItemsToRemove";
Debug.JustUpdateDeviceLine();
{
final int step5 = 1;
final int limit5 = _numberofitemstoremove.<Integer>get().intValue();
_i = 0 ;
for (;(step5 > 0 && _i <= limit5) || (step5 < 0 && _i >= limit5) ;_i = ((int)(0 + _i + step5))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 76;BA.debugLine="Data.Remove(values.Get(i).As(B4XCacheItem).Key)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_data" /*RemoteObject*/ ).runClassMethod (b4a.example.b4xorderedmap.class, "_remove" /*RemoteObject*/ ,(Object)((((_values.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))))).getField(true,"Key" /*RemoteObject*/ ))));
 }
}Debug.locals.put("i", _i);
;
 };
 BA.debugLineNum = 79;BA.debugLine="End Sub";
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