package b4a.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xcollections_subs_0 {


public static RemoteObject  _createbitset(RemoteObject _ba,RemoteObject _size) throws Exception{
try {
		Debug.PushSubsStack("CreateBitSet (b4xcollections) ","b4xcollections",7,_ba,b4xcollections.mostCurrent,52);
if (RapidSub.canDelegate("createbitset")) { return b4a.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","createbitset", _ba, _size);}
RemoteObject _s = RemoteObject.declareNull("b4a.example.b4xbitset");
;
Debug.locals.put("Size", _size);
 BA.debugLineNum = 52;BA.debugLine="Public Sub CreateBitSet (Size As Int) As B4XBitSet";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 53;BA.debugLine="Dim s As B4XBitSet";
Debug.JustUpdateDeviceLine();
_s = RemoteObject.createNew ("b4a.example.b4xbitset");Debug.locals.put("s", _s);
 BA.debugLineNum = 54;BA.debugLine="s.Initialize(Size)";
Debug.JustUpdateDeviceLine();
_s.runClassMethod (b4a.example.b4xbitset.class, "_initialize" /*RemoteObject*/ ,BA.rdebugUtils.runMethod(false, "processBAFromBA", _ba),(Object)(_size));
 BA.debugLineNum = 55;BA.debugLine="Return s";
Debug.JustUpdateDeviceLine();
if (true) return _s;
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
public static RemoteObject  _createorderedmap(RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("CreateOrderedMap (b4xcollections) ","b4xcollections",7,_ba,b4xcollections.mostCurrent,30);
if (RapidSub.canDelegate("createorderedmap")) { return b4a.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","createorderedmap", _ba);}
;
 BA.debugLineNum = 30;BA.debugLine="Public Sub CreateOrderedMap As B4XOrderedMap";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 31;BA.debugLine="Return CreateOrderedMap2(Null, Null)";
Debug.JustUpdateDeviceLine();
if (true) return _createorderedmap2(_ba,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), b4xcollections.mostCurrent.__c.getField(false,"Null")),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), b4xcollections.mostCurrent.__c.getField(false,"Null")));
 BA.debugLineNum = 32;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createorderedmap2(RemoteObject _ba,RemoteObject _keys,RemoteObject _values) throws Exception{
try {
		Debug.PushSubsStack("CreateOrderedMap2 (b4xcollections) ","b4xcollections",7,_ba,b4xcollections.mostCurrent,38);
if (RapidSub.canDelegate("createorderedmap2")) { return b4a.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","createorderedmap2", _ba, _keys, _values);}
RemoteObject _m = RemoteObject.declareNull("b4a.example.b4xorderedmap");
int _i = 0;
;
Debug.locals.put("Keys", _keys);
Debug.locals.put("Values", _values);
 BA.debugLineNum = 38;BA.debugLine="Public Sub CreateOrderedMap2 (Keys As List, Values";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 39;BA.debugLine="Dim m As B4XOrderedMap";
Debug.JustUpdateDeviceLine();
_m = RemoteObject.createNew ("b4a.example.b4xorderedmap");Debug.locals.put("m", _m);
 BA.debugLineNum = 40;BA.debugLine="m.Initialize";
Debug.JustUpdateDeviceLine();
_m.runClassMethod (b4a.example.b4xorderedmap.class, "_initialize" /*RemoteObject*/ ,BA.rdebugUtils.runMethod(false, "processBAFromBA", _ba));
 BA.debugLineNum = 41;BA.debugLine="If Keys <> Null And Values <> Null And Keys.IsIni";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("N",_keys) && RemoteObject.solveBoolean("N",_values) && RemoteObject.solveBoolean(".",_keys.runMethod(true,"IsInitialized")) && RemoteObject.solveBoolean(".",_values.runMethod(true,"IsInitialized"))) { 
 BA.debugLineNum = 42;BA.debugLine="For i = 0 To Keys.Size - 1";
Debug.JustUpdateDeviceLine();
{
final int step4 = 1;
final int limit4 = RemoteObject.solve(new RemoteObject[] {_keys.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step4 > 0 && _i <= limit4) || (step4 < 0 && _i >= limit4) ;_i = ((int)(0 + _i + step4))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 43;BA.debugLine="m.Put(Keys.Get(i), Values.Get(i))";
Debug.JustUpdateDeviceLine();
_m.runClassMethod (b4a.example.b4xorderedmap.class, "_put" /*RemoteObject*/ ,(Object)(_keys.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i)))),(Object)(_values.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i)))));
 }
}Debug.locals.put("i", _i);
;
 };
 BA.debugLineNum = 46;BA.debugLine="Return m";
Debug.JustUpdateDeviceLine();
if (true) return _m;
 BA.debugLineNum = 47;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createset(RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("CreateSet (b4xcollections) ","b4xcollections",7,_ba,b4xcollections.mostCurrent,9);
if (RapidSub.canDelegate("createset")) { return b4a.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","createset", _ba);}
;
 BA.debugLineNum = 9;BA.debugLine="Public Sub CreateSet As B4XSet";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 10;BA.debugLine="Return CreateSet2(Null)";
Debug.JustUpdateDeviceLine();
if (true) return _createset2(_ba,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.List"), b4xcollections.mostCurrent.__c.getField(false,"Null")));
 BA.debugLineNum = 11;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createset2(RemoteObject _ba,RemoteObject _values) throws Exception{
try {
		Debug.PushSubsStack("CreateSet2 (b4xcollections) ","b4xcollections",7,_ba,b4xcollections.mostCurrent,16);
if (RapidSub.canDelegate("createset2")) { return b4a.example.b4xcollections.remoteMe.runUserSub(false, "b4xcollections","createset2", _ba, _values);}
RemoteObject _s = RemoteObject.declareNull("b4a.example.b4xset");
RemoteObject _v = RemoteObject.declareNull("Object");
;
Debug.locals.put("Values", _values);
 BA.debugLineNum = 16;BA.debugLine="Public Sub CreateSet2 (Values As List) As B4XSet";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 17;BA.debugLine="Dim s As B4XSet";
Debug.JustUpdateDeviceLine();
_s = RemoteObject.createNew ("b4a.example.b4xset");Debug.locals.put("s", _s);
 BA.debugLineNum = 18;BA.debugLine="s.Initialize";
Debug.JustUpdateDeviceLine();
_s.runClassMethod (b4a.example.b4xset.class, "_initialize" /*RemoteObject*/ ,BA.rdebugUtils.runMethod(false, "processBAFromBA", _ba));
 BA.debugLineNum = 19;BA.debugLine="If Values <> Null And Values.IsInitialized Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("N",_values) && RemoteObject.solveBoolean(".",_values.runMethod(true,"IsInitialized"))) { 
 BA.debugLineNum = 20;BA.debugLine="For Each v As Object In Values";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group4 = _values;
final int groupLen4 = group4.runMethod(true,"getSize").<Integer>get()
;int index4 = 0;
;
for (; index4 < groupLen4;index4++){
_v = group4.runMethod(false,"Get",index4);Debug.locals.put("v", _v);
Debug.locals.put("v", _v);
 BA.debugLineNum = 21;BA.debugLine="s.Add(v)";
Debug.JustUpdateDeviceLine();
_s.runClassMethod (b4a.example.b4xset.class, "_add" /*RemoteObject*/ ,(Object)(_v));
 }
}Debug.locals.put("v", _v);
;
 };
 BA.debugLineNum = 24;BA.debugLine="Return s";
Debug.JustUpdateDeviceLine();
if (true) return _s;
 BA.debugLineNum = 25;BA.debugLine="End Sub";
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
 //BA.debugLineNum = 4;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}