package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xcollections_subs_0 {


public static RemoteObject  _createbitset(RemoteObject _size) throws Exception{
try {
		Debug.PushSubsStack("CreateBitSet (b4xcollections) ","b4xcollections",12,b4xcollections.ba,b4xcollections.mostCurrent,53);
if (RapidSub.canDelegate("createbitset")) { return b4j.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","createbitset", _size);}
RemoteObject _s = RemoteObject.declareNull("b4j.example.b4xbitset");
Debug.locals.put("Size", _size);
 BA.debugLineNum = 53;BA.debugLine="Public Sub CreateBitSet (Size As Int) As B4XBitSet";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 54;BA.debugLine="Dim s As B4XBitSet";
Debug.JustUpdateDeviceLine();
_s = RemoteObject.createNew ("b4j.example.b4xbitset");Debug.locals.put("s", _s);
 BA.debugLineNum = 55;BA.debugLine="s.Initialize(Size)";
Debug.JustUpdateDeviceLine();
_s.runClassMethod (b4j.example.b4xbitset.class, "_initialize" /*RemoteObject*/ ,b4xcollections.ba,(Object)(_size));
 BA.debugLineNum = 56;BA.debugLine="Return s";
Debug.JustUpdateDeviceLine();
if (true) return _s;
 BA.debugLineNum = 57;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createlist(RemoteObject _items) throws Exception{
try {
		Debug.PushSubsStack("CreateList (b4xcollections) ","b4xcollections",12,b4xcollections.ba,b4xcollections.mostCurrent,104);
if (RapidSub.canDelegate("createlist")) { return b4j.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","createlist", _items);}
RemoteObject _res = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
Debug.locals.put("Items", _items);
 BA.debugLineNum = 104;BA.debugLine="Public Sub CreateList (Items As List) As List";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 105;BA.debugLine="Dim res As List";
Debug.JustUpdateDeviceLine();
_res = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("res", _res);
 BA.debugLineNum = 106;BA.debugLine="res.Initialize";
Debug.JustUpdateDeviceLine();
_res.runVoidMethod ("Initialize");
 BA.debugLineNum = 107;BA.debugLine="If Initialized(Items) Then res.AddAll(Items)";
Debug.JustUpdateDeviceLine();
if (b4xcollections.__c.runMethod(true,"Initialized",(Object)((_items))).<Boolean>get().booleanValue()) { 
_res.runVoidMethod ("AddAll",(Object)(_items));};
 BA.debugLineNum = 108;BA.debugLine="Return res";
Debug.JustUpdateDeviceLine();
if (true) return _res;
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
public static RemoteObject  _createorderedmap() throws Exception{
try {
		Debug.PushSubsStack("CreateOrderedMap (b4xcollections) ","b4xcollections",12,b4xcollections.ba,b4xcollections.mostCurrent,31);
if (RapidSub.canDelegate("createorderedmap")) { return b4j.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","createorderedmap");}
 BA.debugLineNum = 31;BA.debugLine="Public Sub CreateOrderedMap As B4XOrderedMap";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 32;BA.debugLine="Return CreateOrderedMap2(Null, Null)";
Debug.JustUpdateDeviceLine();
if (true) return _createorderedmap2(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), b4xcollections.__c.getField(false,"Null")),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), b4xcollections.__c.getField(false,"Null")));
 BA.debugLineNum = 33;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createorderedmap2(RemoteObject _keys,RemoteObject _values) throws Exception{
try {
		Debug.PushSubsStack("CreateOrderedMap2 (b4xcollections) ","b4xcollections",12,b4xcollections.ba,b4xcollections.mostCurrent,39);
if (RapidSub.canDelegate("createorderedmap2")) { return b4j.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","createorderedmap2", _keys, _values);}
RemoteObject _m = RemoteObject.declareNull("b4j.example.b4xorderedmap");
int _i = 0;
Debug.locals.put("Keys", _keys);
Debug.locals.put("Values", _values);
 BA.debugLineNum = 39;BA.debugLine="Public Sub CreateOrderedMap2 (Keys As List, Values";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 40;BA.debugLine="Dim m As B4XOrderedMap";
Debug.JustUpdateDeviceLine();
_m = RemoteObject.createNew ("b4j.example.b4xorderedmap");Debug.locals.put("m", _m);
 BA.debugLineNum = 41;BA.debugLine="m.Initialize";
Debug.JustUpdateDeviceLine();
_m.runClassMethod (b4j.example.b4xorderedmap.class, "_initialize" /*RemoteObject*/ ,b4xcollections.ba);
 BA.debugLineNum = 42;BA.debugLine="If Keys <> Null And Values <> Null And Keys.IsIni";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("N",_keys) && RemoteObject.solveBoolean("N",_values) && RemoteObject.solveBoolean(".",_keys.runMethod(true,"IsInitialized")) && RemoteObject.solveBoolean(".",_values.runMethod(true,"IsInitialized"))) { 
 BA.debugLineNum = 43;BA.debugLine="For i = 0 To Keys.Size - 1";
Debug.JustUpdateDeviceLine();
{
final int step4 = 1;
final int limit4 = RemoteObject.solve(new RemoteObject[] {_keys.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step4 > 0 && _i <= limit4) || (step4 < 0 && _i >= limit4) ;_i = ((int)(0 + _i + step4))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 44;BA.debugLine="m.Put(Keys.Get(i), Values.Get(i))";
Debug.JustUpdateDeviceLine();
_m.runClassMethod (b4j.example.b4xorderedmap.class, "_put" /*RemoteObject*/ ,(Object)(_keys.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i)))),(Object)(_values.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i)))));
 }
}Debug.locals.put("i", _i);
;
 };
 BA.debugLineNum = 47;BA.debugLine="Return m";
Debug.JustUpdateDeviceLine();
if (true) return _m;
 BA.debugLineNum = 48;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createset() throws Exception{
try {
		Debug.PushSubsStack("CreateSet (b4xcollections) ","b4xcollections",12,b4xcollections.ba,b4xcollections.mostCurrent,10);
if (RapidSub.canDelegate("createset")) { return b4j.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","createset");}
 BA.debugLineNum = 10;BA.debugLine="Public Sub CreateSet As B4XSet";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 11;BA.debugLine="Return CreateSet2(Null)";
Debug.JustUpdateDeviceLine();
if (true) return _createset2(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), b4xcollections.__c.getField(false,"Null")));
 BA.debugLineNum = 12;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createset2(RemoteObject _values) throws Exception{
try {
		Debug.PushSubsStack("CreateSet2 (b4xcollections) ","b4xcollections",12,b4xcollections.ba,b4xcollections.mostCurrent,17);
if (RapidSub.canDelegate("createset2")) { return b4j.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","createset2", _values);}
RemoteObject _s = RemoteObject.declareNull("b4j.example.b4xset");
RemoteObject _v = RemoteObject.declareNull("Object");
Debug.locals.put("Values", _values);
 BA.debugLineNum = 17;BA.debugLine="Public Sub CreateSet2 (Values As List) As B4XSet";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 18;BA.debugLine="Dim s As B4XSet";
Debug.JustUpdateDeviceLine();
_s = RemoteObject.createNew ("b4j.example.b4xset");Debug.locals.put("s", _s);
 BA.debugLineNum = 19;BA.debugLine="s.Initialize";
Debug.JustUpdateDeviceLine();
_s.runClassMethod (b4j.example.b4xset.class, "_initialize" /*RemoteObject*/ ,b4xcollections.ba);
 BA.debugLineNum = 20;BA.debugLine="If Values <> Null And Values.IsInitialized Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("N",_values) && RemoteObject.solveBoolean(".",_values.runMethod(true,"IsInitialized"))) { 
 BA.debugLineNum = 21;BA.debugLine="For Each v As Object In Values";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group4 = _values;
final int groupLen4 = group4.runMethod(true,"getSize").<Integer>get()
;int index4 = 0;
;
for (; index4 < groupLen4;index4++){
_v = group4.runMethod(false,"Get",index4);Debug.locals.put("v", _v);
Debug.locals.put("v", _v);
 BA.debugLineNum = 22;BA.debugLine="s.Add(v)";
Debug.JustUpdateDeviceLine();
_s.runClassMethod (b4j.example.b4xset.class, "_add" /*RemoteObject*/ ,(Object)(_v));
 }
}Debug.locals.put("v", _v);
;
 };
 BA.debugLineNum = 25;BA.debugLine="Return s";
Debug.JustUpdateDeviceLine();
if (true) return _s;
 BA.debugLineNum = 26;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getemptylist() throws Exception{
try {
		Debug.PushSubsStack("GetEmptyList (b4xcollections) ","b4xcollections",12,b4xcollections.ba,b4xcollections.mostCurrent,69);
if (RapidSub.canDelegate("getemptylist")) { return b4j.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","getemptylist");}
 BA.debugLineNum = 69;BA.debugLine="Public Sub GetEmptyList As List";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 70;BA.debugLine="If mEmptyList.IsInitialized = False Or mEmptyList";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",b4xcollections._memptylist.runMethod(true,"IsInitialized"),b4xcollections.__c.getField(true,"False")) || RemoteObject.solveBoolean(">",b4xcollections._memptylist.runMethod(true,"getSize"),BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 71;BA.debugLine="Dim mEmptyList As List";
Debug.JustUpdateDeviceLine();
b4xcollections._memptylist = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");
 BA.debugLineNum = 72;BA.debugLine="mEmptyList.Initialize";
Debug.JustUpdateDeviceLine();
b4xcollections._memptylist.runVoidMethod ("Initialize");
 };
 BA.debugLineNum = 74;BA.debugLine="Return mEmptyList";
Debug.JustUpdateDeviceLine();
if (true) return b4xcollections._memptylist;
 BA.debugLineNum = 75;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getemptymap() throws Exception{
try {
		Debug.PushSubsStack("GetEmptyMap (b4xcollections) ","b4xcollections",12,b4xcollections.ba,b4xcollections.mostCurrent,60);
if (RapidSub.canDelegate("getemptymap")) { return b4j.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","getemptymap");}
 BA.debugLineNum = 60;BA.debugLine="Public Sub GetEmptyMap As Map";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 61;BA.debugLine="If mEmptyMap.IsInitialized = False Or mEmptyMap.S";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",b4xcollections._memptymap.runMethod(true,"IsInitialized"),b4xcollections.__c.getField(true,"False")) || RemoteObject.solveBoolean(">",b4xcollections._memptymap.runMethod(true,"getSize"),BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 62;BA.debugLine="Dim mEmptyMap As Map";
Debug.JustUpdateDeviceLine();
b4xcollections._memptymap = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
 BA.debugLineNum = 63;BA.debugLine="mEmptyMap.Initialize";
Debug.JustUpdateDeviceLine();
b4xcollections._memptymap.runVoidMethod ("Initialize");
 };
 BA.debugLineNum = 65;BA.debugLine="Return mEmptyMap";
Debug.JustUpdateDeviceLine();
if (true) return b4xcollections._memptymap;
 BA.debugLineNum = 66;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mergelists(RemoteObject _list1,RemoteObject _list2) throws Exception{
try {
		Debug.PushSubsStack("MergeLists (b4xcollections) ","b4xcollections",12,b4xcollections.ba,b4xcollections.mostCurrent,95);
if (RapidSub.canDelegate("mergelists")) { return b4j.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","mergelists", _list1, _list2);}
RemoteObject _res = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
Debug.locals.put("List1", _list1);
Debug.locals.put("List2", _list2);
 BA.debugLineNum = 95;BA.debugLine="Public Sub MergeLists (List1 As List, List2 As Lis";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 96;BA.debugLine="Dim res As List";
Debug.JustUpdateDeviceLine();
_res = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("res", _res);
 BA.debugLineNum = 97;BA.debugLine="res.Initialize";
Debug.JustUpdateDeviceLine();
_res.runVoidMethod ("Initialize");
 BA.debugLineNum = 98;BA.debugLine="If Initialized(List1) Then res.AddAll(List1)";
Debug.JustUpdateDeviceLine();
if (b4xcollections.__c.runMethod(true,"Initialized",(Object)((_list1))).<Boolean>get().booleanValue()) { 
_res.runVoidMethod ("AddAll",(Object)(_list1));};
 BA.debugLineNum = 99;BA.debugLine="If Initialized(List2) Then res.AddAll(List2)";
Debug.JustUpdateDeviceLine();
if (b4xcollections.__c.runMethod(true,"Initialized",(Object)((_list2))).<Boolean>get().booleanValue()) { 
_res.runVoidMethod ("AddAll",(Object)(_list2));};
 BA.debugLineNum = 100;BA.debugLine="Return res";
Debug.JustUpdateDeviceLine();
if (true) return _res;
 BA.debugLineNum = 101;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mergemaps(RemoteObject _map1,RemoteObject _map2) throws Exception{
try {
		Debug.PushSubsStack("MergeMaps (b4xcollections) ","b4xcollections",12,b4xcollections.ba,b4xcollections.mostCurrent,78);
if (RapidSub.canDelegate("mergemaps")) { return b4j.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","mergemaps", _map1, _map2);}
RemoteObject _res = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _key = RemoteObject.declareNull("Object");
Debug.locals.put("Map1", _map1);
Debug.locals.put("Map2", _map2);
 BA.debugLineNum = 78;BA.debugLine="Public Sub MergeMaps (Map1 As Map, Map2 As Map) As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 79;BA.debugLine="Dim res As Map";
Debug.JustUpdateDeviceLine();
_res = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("res", _res);
 BA.debugLineNum = 80;BA.debugLine="res.Initialize";
Debug.JustUpdateDeviceLine();
_res.runVoidMethod ("Initialize");
 BA.debugLineNum = 81;BA.debugLine="If Initialized(Map1) Then";
Debug.JustUpdateDeviceLine();
if (b4xcollections.__c.runMethod(true,"Initialized",(Object)((_map1))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 82;BA.debugLine="For Each key As Object In Map1.Keys";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group4 = _map1.runMethod(false,"Keys");
final int groupLen4 = group4.runMethod(true,"getSize").<Integer>get()
;int index4 = 0;
;
for (; index4 < groupLen4;index4++){
_key = group4.runMethod(false,"Get",index4);Debug.locals.put("key", _key);
Debug.locals.put("key", _key);
 BA.debugLineNum = 83;BA.debugLine="res.Put(key, Map1.Get(key))";
Debug.JustUpdateDeviceLine();
_res.runVoidMethod ("Put",(Object)(_key),(Object)(_map1.runMethod(false,"Get",(Object)(_key))));
 }
}Debug.locals.put("key", _key);
;
 };
 BA.debugLineNum = 86;BA.debugLine="If Initialized(Map2) Then";
Debug.JustUpdateDeviceLine();
if (b4xcollections.__c.runMethod(true,"Initialized",(Object)((_map2))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 87;BA.debugLine="For Each key As Object In Map2.Keys";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group9 = _map2.runMethod(false,"Keys");
final int groupLen9 = group9.runMethod(true,"getSize").<Integer>get()
;int index9 = 0;
;
for (; index9 < groupLen9;index9++){
_key = group9.runMethod(false,"Get",index9);Debug.locals.put("key", _key);
Debug.locals.put("key", _key);
 BA.debugLineNum = 88;BA.debugLine="res.Put(key, Map2.Get(key))";
Debug.JustUpdateDeviceLine();
_res.runVoidMethod ("Put",(Object)(_key),(Object)(_map2.runMethod(false,"Get",(Object)(_key))));
 }
}Debug.locals.put("key", _key);
;
 };
 BA.debugLineNum = 91;BA.debugLine="Return res";
Debug.JustUpdateDeviceLine();
if (true) return _res;
 BA.debugLineNum = 92;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 3;BA.debugLine="Private mEmptyMap As Map";
b4xcollections._memptymap = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
 //BA.debugLineNum = 4;BA.debugLine="Private mEmptyList As List";
b4xcollections._memptylist = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");
 //BA.debugLineNum = 5;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _shufflelist(RemoteObject _items) throws Exception{
try {
		Debug.PushSubsStack("ShuffleList (b4xcollections) ","b4xcollections",12,b4xcollections.ba,b4xcollections.mostCurrent,112);
if (RapidSub.canDelegate("shufflelist")) { return b4j.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","shufflelist", _items);}
RemoteObject _n = RemoteObject.createImmutable(0);
int _i = 0;
RemoteObject _j = RemoteObject.createImmutable(0);
RemoteObject _o = RemoteObject.declareNull("Object");
Debug.locals.put("Items", _items);
 BA.debugLineNum = 112;BA.debugLine="Public Sub ShuffleList (Items As List)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 113;BA.debugLine="Dim n As Int = Items.Size";
Debug.JustUpdateDeviceLine();
_n = _items.runMethod(true,"getSize");Debug.locals.put("n", _n);Debug.locals.put("n", _n);
 BA.debugLineNum = 114;BA.debugLine="For i = 0 To n - 2";
Debug.JustUpdateDeviceLine();
{
final int step2 = 1;
final int limit2 = RemoteObject.solve(new RemoteObject[] {_n,RemoteObject.createImmutable(2)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step2 > 0 && _i <= limit2) || (step2 < 0 && _i >= limit2) ;_i = ((int)(0 + _i + step2))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 115;BA.debugLine="Dim j As Int = Rnd(i, n)";
Debug.JustUpdateDeviceLine();
_j = b4xcollections.__c.runMethod(true,"Rnd",(Object)(BA.numberCast(int.class, _i)),(Object)(_n));Debug.locals.put("j", _j);Debug.locals.put("j", _j);
 BA.debugLineNum = 116;BA.debugLine="Dim o As Object = Items.Get(i)";
Debug.JustUpdateDeviceLine();
_o = _items.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i)));Debug.locals.put("o", _o);Debug.locals.put("o", _o);
 BA.debugLineNum = 117;BA.debugLine="Items.Set(i, Items.Get(j))";
Debug.JustUpdateDeviceLine();
_items.runVoidMethod ("Set",(Object)(BA.numberCast(int.class, _i)),(Object)(_items.runMethod(false,"Get",(Object)(_j))));
 BA.debugLineNum = 118;BA.debugLine="Items.Set(j, o)";
Debug.JustUpdateDeviceLine();
_items.runVoidMethod ("Set",(Object)(_j),(Object)(_o));
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 120;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _sublist(RemoteObject _items,RemoteObject _startindex,RemoteObject _endindex) throws Exception{
try {
		Debug.PushSubsStack("SubList (b4xcollections) ","b4xcollections",12,b4xcollections.ba,b4xcollections.mostCurrent,123);
if (RapidSub.canDelegate("sublist")) { return b4j.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","sublist", _items, _startindex, _endindex);}
RemoteObject _res = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
int _i = 0;
Debug.locals.put("Items", _items);
Debug.locals.put("StartIndex", _startindex);
Debug.locals.put("EndIndex", _endindex);
 BA.debugLineNum = 123;BA.debugLine="Public Sub SubList (Items As List, StartIndex As I";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 124;BA.debugLine="Dim res As List";
Debug.JustUpdateDeviceLine();
_res = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("res", _res);
 BA.debugLineNum = 125;BA.debugLine="res.Initialize";
Debug.JustUpdateDeviceLine();
_res.runVoidMethod ("Initialize");
 BA.debugLineNum = 126;BA.debugLine="For i = StartIndex To EndIndex - 1";
Debug.JustUpdateDeviceLine();
{
final int step3 = 1;
final int limit3 = RemoteObject.solve(new RemoteObject[] {_endindex,RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = _startindex.<Integer>get().intValue() ;
for (;(step3 > 0 && _i <= limit3) || (step3 < 0 && _i >= limit3) ;_i = ((int)(0 + _i + step3))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 127;BA.debugLine="res.Add(Items.Get(i))";
Debug.JustUpdateDeviceLine();
_res.runVoidMethod ("Add",(Object)(_items.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i)))));
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 129;BA.debugLine="Return res";
Debug.JustUpdateDeviceLine();
if (true) return _res;
 BA.debugLineNum = 130;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}