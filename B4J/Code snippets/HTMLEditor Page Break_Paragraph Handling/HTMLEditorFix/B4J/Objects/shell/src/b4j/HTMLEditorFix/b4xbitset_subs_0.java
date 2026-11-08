package b4j.HTMLEditorFix;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xbitset_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 1;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 5;BA.debugLine="Private data() As Int";
b4xbitset._data = RemoteObject.createNewArray ("int", new int[] {0}, new Object[]{});__ref.setField("_data",b4xbitset._data);
 //BA.debugLineNum = 7;BA.debugLine="Private mSize As Int";
b4xbitset._msize = RemoteObject.createImmutable(0);__ref.setField("_msize",b4xbitset._msize);
 //BA.debugLineNum = 8;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _clear(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Clear (b4xbitset) ","b4xbitset",3,__ref.getField(false, "ba"),__ref,53);
if (RapidSub.canDelegate("clear")) { return __ref.runUserSub(false, "b4xbitset","clear", __ref);}
 BA.debugLineNum = 53;BA.debugLine="Public Sub Clear";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 57;BA.debugLine="Dim data(Bit.ShiftRight(mSize, 5) + 1) As Int";
Debug.JustUpdateDeviceLine();
b4xbitset._data = RemoteObject.createNewArray ("int", new int[] {RemoteObject.solve(new RemoteObject[] {b4xbitset.__c.getField(false,"Bit").runMethod(true,"ShiftRight",(Object)(__ref.getField(true,"_msize" /*RemoteObject*/ )),(Object)(BA.numberCast(int.class, 5))),RemoteObject.createImmutable(1)}, "+",1, 1).<Integer>get().intValue()}, new Object[]{});__ref.setField("_data",b4xbitset._data);
 BA.debugLineNum = 59;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _get(RemoteObject __ref,RemoteObject _index) throws Exception{
try {
		Debug.PushSubsStack("Get (b4xbitset) ","b4xbitset",3,__ref.getField(false, "ba"),__ref,38);
if (RapidSub.canDelegate("get")) { return __ref.runUserSub(false, "b4xbitset","get", __ref, _index);}
RemoteObject _dindex = RemoteObject.createImmutable(0);
RemoteObject _offset = RemoteObject.createImmutable(0);
RemoteObject _blockvalue = RemoteObject.createImmutable(0);
Debug.locals.put("Index", _index);
 BA.debugLineNum = 38;BA.debugLine="Public Sub Get(Index As Int) As Boolean";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 39;BA.debugLine="Dim dindex As Int = Bit.ShiftRight(Index, 5)";
Debug.JustUpdateDeviceLine();
_dindex = b4xbitset.__c.getField(false,"Bit").runMethod(true,"ShiftRight",(Object)(_index),(Object)(BA.numberCast(int.class, 5)));Debug.locals.put("dindex", _dindex);Debug.locals.put("dindex", _dindex);
 BA.debugLineNum = 40;BA.debugLine="Dim offset As Int = Bit.And(0x0000001f, Index)";
Debug.JustUpdateDeviceLine();
_offset = b4xbitset.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, ((int)0x0000001f))),(Object)(_index));Debug.locals.put("offset", _offset);Debug.locals.put("offset", _offset);
 BA.debugLineNum = 44;BA.debugLine="Dim BlockValue As Int = data(dindex)";
Debug.JustUpdateDeviceLine();
_blockvalue = __ref.getField(false,"_data" /*RemoteObject*/ ).getArrayElement(true,_dindex);Debug.locals.put("BlockValue", _blockvalue);Debug.locals.put("BlockValue", _blockvalue);
 BA.debugLineNum = 46;BA.debugLine="Return Bit.And(BlockValue, Bit.ShiftLeft(1, offse";
Debug.JustUpdateDeviceLine();
if (true) return BA.ObjectToBoolean(RemoteObject.solveBoolean("!",b4xbitset.__c.getField(false,"Bit").runMethod(true,"And",(Object)(_blockvalue),(Object)(b4xbitset.__c.getField(false,"Bit").runMethod(true,"ShiftLeft",(Object)(BA.numberCast(int.class, 1)),(Object)(_offset)))),BA.numberCast(double.class, 0)));
 BA.debugLineNum = 47;BA.debugLine="End Sub";
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
		Debug.PushSubsStack("getSize (b4xbitset) ","b4xbitset",3,__ref.getField(false, "ba"),__ref,49);
if (RapidSub.canDelegate("getsize")) { return __ref.runUserSub(false, "b4xbitset","getsize", __ref);}
 BA.debugLineNum = 49;BA.debugLine="Public Sub getSize As Int";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 50;BA.debugLine="Return mSize";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(true,"_msize" /*RemoteObject*/ );
 BA.debugLineNum = 51;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _size) throws Exception{
try {
		Debug.PushSubsStack("Initialize (b4xbitset) ","b4xbitset",3,__ref.getField(false, "ba"),__ref,10);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "b4xbitset","initialize", __ref, _ba, _size);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
Debug.locals.put("Size", _size);
 BA.debugLineNum = 10;BA.debugLine="Public Sub Initialize (Size As Int)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 11;BA.debugLine="mSize = Size";
Debug.JustUpdateDeviceLine();
__ref.setField ("_msize" /*RemoteObject*/ ,_size);
 BA.debugLineNum = 12;BA.debugLine="Clear";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.HTMLEditorFix.b4xbitset.class, "_clear" /*RemoteObject*/ );
 BA.debugLineNum = 13;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _set(RemoteObject __ref,RemoteObject _index,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("Set (b4xbitset) ","b4xbitset",3,__ref.getField(false, "ba"),__ref,16);
if (RapidSub.canDelegate("set")) { return __ref.runUserSub(false, "b4xbitset","set", __ref, _index, _value);}
RemoteObject _dindex = RemoteObject.createImmutable(0);
RemoteObject _offset = RemoteObject.createImmutable(0);
RemoteObject _blockvalue = RemoteObject.createImmutable(0);
RemoteObject _newblockvalue = RemoteObject.createImmutable(0);
Debug.locals.put("Index", _index);
Debug.locals.put("Value", _value);
 BA.debugLineNum = 16;BA.debugLine="Public Sub Set(Index As Int, Value As Boolean)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 17;BA.debugLine="Dim dindex As Int = Bit.ShiftRight(Index, 5)";
Debug.JustUpdateDeviceLine();
_dindex = b4xbitset.__c.getField(false,"Bit").runMethod(true,"ShiftRight",(Object)(_index),(Object)(BA.numberCast(int.class, 5)));Debug.locals.put("dindex", _dindex);Debug.locals.put("dindex", _dindex);
 BA.debugLineNum = 18;BA.debugLine="Dim offset As Int = Bit.And(0x0000001f, Index)";
Debug.JustUpdateDeviceLine();
_offset = b4xbitset.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, ((int)0x0000001f))),(Object)(_index));Debug.locals.put("offset", _offset);Debug.locals.put("offset", _offset);
 BA.debugLineNum = 22;BA.debugLine="Dim BlockValue As Int = data(dindex)";
Debug.JustUpdateDeviceLine();
_blockvalue = __ref.getField(false,"_data" /*RemoteObject*/ ).getArrayElement(true,_dindex);Debug.locals.put("BlockValue", _blockvalue);Debug.locals.put("BlockValue", _blockvalue);
 BA.debugLineNum = 24;BA.debugLine="Dim NewBlockValue As Int";
Debug.JustUpdateDeviceLine();
_newblockvalue = RemoteObject.createImmutable(0);Debug.locals.put("NewBlockValue", _newblockvalue);
 BA.debugLineNum = 25;BA.debugLine="If Value Then";
Debug.JustUpdateDeviceLine();
if (_value.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 26;BA.debugLine="NewBlockValue = Bit.Or(BlockValue, Bit.ShiftLeft";
Debug.JustUpdateDeviceLine();
_newblockvalue = b4xbitset.__c.getField(false,"Bit").runMethod(true,"Or",(Object)(_blockvalue),(Object)(b4xbitset.__c.getField(false,"Bit").runMethod(true,"ShiftLeft",(Object)(BA.numberCast(int.class, 1)),(Object)(_offset))));Debug.locals.put("NewBlockValue", _newblockvalue);
 }else {
 BA.debugLineNum = 28;BA.debugLine="NewBlockValue = Bit.And(BlockValue, Bit.Not(Bit.";
Debug.JustUpdateDeviceLine();
_newblockvalue = b4xbitset.__c.getField(false,"Bit").runMethod(true,"And",(Object)(_blockvalue),(Object)(b4xbitset.__c.getField(false,"Bit").runMethod(true,"Not",(Object)(b4xbitset.__c.getField(false,"Bit").runMethod(true,"ShiftLeft",(Object)(BA.numberCast(int.class, 1)),(Object)(_offset))))));Debug.locals.put("NewBlockValue", _newblockvalue);
 };
 BA.debugLineNum = 33;BA.debugLine="data(dindex) = NewBlockValue";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_data" /*RemoteObject*/ ).setArrayElement (_newblockvalue,_dindex);
 BA.debugLineNum = 35;BA.debugLine="End Sub";
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