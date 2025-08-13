package b4a.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xbytesbuilder_subs_0 {


public static RemoteObject  _append(RemoteObject __ref,RemoteObject _data) throws Exception{
try {
		Debug.PushSubsStack("Append (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,24);
if (RapidSub.canDelegate("append")) { return __ref.runUserSub(false, "b4xbytesbuilder","append", __ref, _data);}
Debug.locals.put("Data", _data);
 BA.debugLineNum = 24;BA.debugLine="Public Sub Append(Data() As Byte) As B4XBytesBuild";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 25;BA.debugLine="Return Append2(Data, 0, Data.Length)";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return __ref.runClassMethod (b4a.example.b4xbytesbuilder.class, "_append2" /*RemoteObject*/ ,(Object)(_data),(Object)(BA.numberCast(int.class, 0)),(Object)(_data.getField(true,"length")));
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
public static RemoteObject  _append2(RemoteObject __ref,RemoteObject _data,RemoteObject _startindex,RemoteObject _length) throws Exception{
try {
		Debug.PushSubsStack("Append2 (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,31);
if (RapidSub.canDelegate("append2")) { return __ref.runUserSub(false, "b4xbytesbuilder","append2", __ref, _data, _startindex, _length);}
RemoteObject _oldlength = RemoteObject.createImmutable(0);
Debug.locals.put("Data", _data);
Debug.locals.put("StartIndex", _startindex);
Debug.locals.put("Length", _length);
 BA.debugLineNum = 31;BA.debugLine="Public Sub Append2(Data() As Byte, StartIndex As I";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 32;BA.debugLine="Dim OldLength As Int = ChangeLength(mLength + Len";
Debug.JustUpdateDeviceLine();
_oldlength = __ref.runClassMethod (b4a.example.b4xbytesbuilder.class, "_changelength" /*RemoteObject*/ ,(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mlength" /*RemoteObject*/ ),_length}, "+",1, 1)));Debug.locals.put("OldLength", _oldlength);Debug.locals.put("OldLength", _oldlength);
 BA.debugLineNum = 33;BA.debugLine="Bit.ArrayCopy(Data, StartIndex, mBuffer, OldLengt";
Debug.JustUpdateDeviceLine();
b4xbytesbuilder.__c.getField(false,"Bit").runVoidMethod ("ArrayCopy",(Object)((_data)),(Object)(_startindex),(Object)((__ref.getField(false,"_mbuffer" /*RemoteObject*/ ))),(Object)(_oldlength),(Object)(_length));
 BA.debugLineNum = 34;BA.debugLine="Return Me";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return (__ref);
 BA.debugLineNum = 35;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _changelength(RemoteObject __ref,RemoteObject _newlength) throws Exception{
try {
		Debug.PushSubsStack("ChangeLength (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,12);
if (RapidSub.canDelegate("changelength")) { return __ref.runUserSub(false, "b4xbytesbuilder","changelength", __ref, _newlength);}
RemoteObject _oldlength = RemoteObject.createImmutable(0);
RemoteObject _b = null;
Debug.locals.put("NewLength", _newlength);
 BA.debugLineNum = 12;BA.debugLine="Private Sub ChangeLength (NewLength As Int) As Int";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 13;BA.debugLine="Dim OldLength As Int = mLength";
Debug.JustUpdateDeviceLine();
_oldlength = __ref.getField(true,"_mlength" /*RemoteObject*/ );Debug.locals.put("OldLength", _oldlength);Debug.locals.put("OldLength", _oldlength);
 BA.debugLineNum = 14;BA.debugLine="mLength = NewLength";
Debug.JustUpdateDeviceLine();
__ref.setField ("_mlength" /*RemoteObject*/ ,_newlength);
 BA.debugLineNum = 15;BA.debugLine="If mBuffer.Length < mLength Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("<",__ref.getField(false,"_mbuffer" /*RemoteObject*/ ).getField(true,"length"),BA.numberCast(double.class, __ref.getField(true,"_mlength" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 16;BA.debugLine="Dim b(Max(mBuffer.Length * 2, NewLength)) As Byt";
Debug.JustUpdateDeviceLine();
_b = RemoteObject.createNewArray ("byte", new int[] {(int) (0 + b4xbytesbuilder.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbuffer" /*RemoteObject*/ ).getField(true,"length"),RemoteObject.createImmutable(2)}, "*",0, 1))),(Object)(BA.numberCast(double.class, _newlength))).<Double>get().doubleValue())}, new Object[]{});Debug.locals.put("b", _b);
 BA.debugLineNum = 17;BA.debugLine="Bit.ArrayCopy(mBuffer, 0, b, 0, mBuffer.Length)";
Debug.JustUpdateDeviceLine();
b4xbytesbuilder.__c.getField(false,"Bit").runVoidMethod ("ArrayCopy",(Object)((__ref.getField(false,"_mbuffer" /*RemoteObject*/ ))),(Object)(BA.numberCast(int.class, 0)),(Object)((_b)),(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(false,"_mbuffer" /*RemoteObject*/ ).getField(true,"length")));
 BA.debugLineNum = 18;BA.debugLine="mBuffer = b";
Debug.JustUpdateDeviceLine();
__ref.setField ("_mbuffer" /*RemoteObject*/ ,_b);
 };
 BA.debugLineNum = 20;BA.debugLine="Return OldLength";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return _oldlength;
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
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 1;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 2;BA.debugLine="Private mBuffer() As Byte";
b4xbytesbuilder._mbuffer = RemoteObject.createNewArray ("byte", new int[] {0}, new Object[]{});__ref.setField("_mbuffer",b4xbytesbuilder._mbuffer);
 //BA.debugLineNum = 3;BA.debugLine="Private mLength As Int";
b4xbytesbuilder._mlength = RemoteObject.createImmutable(0);__ref.setField("_mlength",b4xbytesbuilder._mlength);
 //BA.debugLineNum = 4;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _clear(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Clear (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,37);
if (RapidSub.canDelegate("clear")) { return __ref.runUserSub(false, "b4xbytesbuilder","clear", __ref);}
 BA.debugLineNum = 37;BA.debugLine="Public Sub Clear";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 38;BA.debugLine="ChangeLength(0)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4a.example.b4xbytesbuilder.class, "_changelength" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 0)));
 BA.debugLineNum = 39;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getbuffer(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getBuffer (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,103);
if (RapidSub.canDelegate("getbuffer")) { return __ref.runUserSub(false, "b4xbytesbuilder","getbuffer", __ref);}
 BA.debugLineNum = 103;BA.debugLine="Private Sub getBuffer As Byte() 'ignore";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 104;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getinternalbuffer(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getInternalBuffer (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,127);
if (RapidSub.canDelegate("getinternalbuffer")) { return __ref.runUserSub(false, "b4xbytesbuilder","getinternalbuffer", __ref);}
 BA.debugLineNum = 127;BA.debugLine="Public Sub getInternalBuffer As Byte()";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 128;BA.debugLine="Return mBuffer";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return __ref.getField(false,"_mbuffer" /*RemoteObject*/ );
 BA.debugLineNum = 129;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getlength(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getLength (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,92);
if (RapidSub.canDelegate("getlength")) { return __ref.runUserSub(false, "b4xbytesbuilder","getlength", __ref);}
 BA.debugLineNum = 92;BA.debugLine="Public Sub getLength As Int";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 93;BA.debugLine="Return mLength";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return __ref.getField(true,"_mlength" /*RemoteObject*/ );
 BA.debugLineNum = 94;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _indexof(RemoteObject __ref,RemoteObject _searchfor) throws Exception{
try {
		Debug.PushSubsStack("IndexOf (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,107);
if (RapidSub.canDelegate("indexof")) { return __ref.runUserSub(false, "b4xbytesbuilder","indexof", __ref, _searchfor);}
Debug.locals.put("SearchFor", _searchfor);
 BA.debugLineNum = 107;BA.debugLine="Public Sub IndexOf(SearchFor() As Byte) As Int";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 108;BA.debugLine="Return IndexOf2(SearchFor, 0)";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return __ref.runClassMethod (b4a.example.b4xbytesbuilder.class, "_indexof2" /*RemoteObject*/ ,(Object)(_searchfor),(Object)(BA.numberCast(int.class, 0)));
 BA.debugLineNum = 109;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _indexof2(RemoteObject __ref,RemoteObject _searchfor,RemoteObject _index) throws Exception{
try {
		Debug.PushSubsStack("IndexOf2 (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,112);
if (RapidSub.canDelegate("indexof2")) { return __ref.runUserSub(false, "b4xbytesbuilder","indexof2", __ref, _searchfor, _index);}
int _i1 = 0;
int _i2 = 0;
Debug.locals.put("SearchFor", _searchfor);
Debug.locals.put("Index", _index);
 BA.debugLineNum = 112;BA.debugLine="Public Sub IndexOf2(SearchFor() As Byte, Index As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 113;BA.debugLine="For i1 = Index To mLength - SearchFor.Length";
Debug.JustUpdateDeviceLine();
{
final int step1 = 1;
final int limit1 = RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mlength" /*RemoteObject*/ ),_searchfor.getField(true,"length")}, "-",1, 1).<Integer>get().intValue();
_i1 = _index.<Integer>get().intValue() ;
for (;(step1 > 0 && _i1 <= limit1) || (step1 < 0 && _i1 >= limit1) ;_i1 = ((int)(0 + _i1 + step1))  ) {
Debug.locals.put("i1", _i1);
 BA.debugLineNum = 114;BA.debugLine="For i2 = 0 To SearchFor.Length - 1";
Debug.JustUpdateDeviceLine();
{
final int step2 = 1;
final int limit2 = RemoteObject.solve(new RemoteObject[] {_searchfor.getField(true,"length"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i2 = 0 ;
for (;(step2 > 0 && _i2 <= limit2) || (step2 < 0 && _i2 >= limit2) ;_i2 = ((int)(0 + _i2 + step2))  ) {
Debug.locals.put("i2", _i2);
 BA.debugLineNum = 115;BA.debugLine="If SearchFor(i2) <> mBuffer(i1 + i2) Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("!",_searchfor.getArrayElement(true,BA.numberCast(int.class, _i2)),BA.numberCast(double.class, __ref.getField(false,"_mbuffer" /*RemoteObject*/ ).getArrayElement(true,RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_i1),RemoteObject.createImmutable(_i2)}, "+",1, 1))))) { 
 BA.debugLineNum = 116;BA.debugLine="Exit";
Debug.JustUpdateDeviceLine();
if (true) break;
 };
 }
}Debug.locals.put("i2", _i2);
;
 BA.debugLineNum = 119;BA.debugLine="If i2 = SearchFor.Length Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",RemoteObject.createImmutable(_i2),BA.numberCast(double.class, _searchfor.getField(true,"length")))) { 
 BA.debugLineNum = 120;BA.debugLine="Return i1";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return BA.numberCast(int.class, _i1);
 };
 }
}Debug.locals.put("i1", _i1);
;
 BA.debugLineNum = 123;BA.debugLine="Return -1";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return BA.numberCast(int.class, -(double) (0 + 1));
 BA.debugLineNum = 124;BA.debugLine="End Sub";
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
		Debug.PushSubsStack("Initialize (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,6);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "b4xbytesbuilder","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 6;BA.debugLine="Public Sub Initialize";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 7;BA.debugLine="Dim mBuffer(100) As Byte";
Debug.JustUpdateDeviceLine();
b4xbytesbuilder._mbuffer = RemoteObject.createNewArray ("byte", new int[] {100}, new Object[]{});__ref.setField("_mbuffer",b4xbytesbuilder._mbuffer);
 BA.debugLineNum = 8;BA.debugLine="mLength = 0";
Debug.JustUpdateDeviceLine();
__ref.setField ("_mlength" /*RemoteObject*/ ,BA.numberCast(int.class, 0));
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
public static RemoteObject  _insert(RemoteObject __ref,RemoteObject _index,RemoteObject _data) throws Exception{
try {
		Debug.PushSubsStack("Insert (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,43);
if (RapidSub.canDelegate("insert")) { return __ref.runUserSub(false, "b4xbytesbuilder","insert", __ref, _index, _data);}
RemoteObject _afterindex = null;
Debug.locals.put("Index", _index);
Debug.locals.put("Data", _data);
 BA.debugLineNum = 43;BA.debugLine="Public Sub Insert(Index As Int, Data() As Byte)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 44;BA.debugLine="If Index >= mLength Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("g",_index,BA.numberCast(double.class, __ref.getField(true,"_mlength" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 45;BA.debugLine="If Index > mLength Then Log(\"Index too large\")";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",_index,BA.numberCast(double.class, __ref.getField(true,"_mlength" /*RemoteObject*/ )))) { 
b4xbytesbuilder.__c.runVoidMethod ("LogImpl","93538946",RemoteObject.createImmutable("Index too large"),0);};
 BA.debugLineNum = 46;BA.debugLine="Append(Data)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4a.example.b4xbytesbuilder.class, "_append" /*RemoteObject*/ ,(Object)(_data));
 }else {
 BA.debugLineNum = 48;BA.debugLine="Dim AfterIndex() As Byte = SubArray(Index)";
Debug.JustUpdateDeviceLine();
_afterindex = __ref.runClassMethod (b4a.example.b4xbytesbuilder.class, "_subarray" /*RemoteObject*/ ,(Object)(_index));Debug.locals.put("AfterIndex", _afterindex);Debug.locals.put("AfterIndex", _afterindex);
 BA.debugLineNum = 49;BA.debugLine="ChangeLength(mLength + Data.Length)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4a.example.b4xbytesbuilder.class, "_changelength" /*RemoteObject*/ ,(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mlength" /*RemoteObject*/ ),_data.getField(true,"length")}, "+",1, 1)));
 BA.debugLineNum = 50;BA.debugLine="Bit.ArrayCopy(Data, 0, mBuffer, Index, Data.Leng";
Debug.JustUpdateDeviceLine();
b4xbytesbuilder.__c.getField(false,"Bit").runVoidMethod ("ArrayCopy",(Object)((_data)),(Object)(BA.numberCast(int.class, 0)),(Object)((__ref.getField(false,"_mbuffer" /*RemoteObject*/ ))),(Object)(_index),(Object)(_data.getField(true,"length")));
 BA.debugLineNum = 51;BA.debugLine="Bit.ArrayCopy(AfterIndex, 0, mBuffer, Index + Da";
Debug.JustUpdateDeviceLine();
b4xbytesbuilder.__c.getField(false,"Bit").runVoidMethod ("ArrayCopy",(Object)((_afterindex)),(Object)(BA.numberCast(int.class, 0)),(Object)((__ref.getField(false,"_mbuffer" /*RemoteObject*/ ))),(Object)(RemoteObject.solve(new RemoteObject[] {_index,_data.getField(true,"length")}, "+",1, 1)),(Object)(_afterindex.getField(true,"length")));
 };
 BA.debugLineNum = 53;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _remove(RemoteObject __ref,RemoteObject _beginindex,RemoteObject _endindex) throws Exception{
try {
		Debug.PushSubsStack("Remove (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,69);
if (RapidSub.canDelegate("remove")) { return __ref.runUserSub(false, "b4xbytesbuilder","remove", __ref, _beginindex, _endindex);}
RemoteObject _res = null;
RemoteObject _afterendindex = null;
Debug.locals.put("BeginIndex", _beginindex);
Debug.locals.put("EndIndex", _endindex);
 BA.debugLineNum = 69;BA.debugLine="Public Sub Remove(BeginIndex As Int, EndIndex As I";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 70;BA.debugLine="Dim res() As Byte = SubArray2(BeginIndex, EndInde";
Debug.JustUpdateDeviceLine();
_res = __ref.runClassMethod (b4a.example.b4xbytesbuilder.class, "_subarray2" /*RemoteObject*/ ,(Object)(_beginindex),(Object)(_endindex));Debug.locals.put("res", _res);Debug.locals.put("res", _res);
 BA.debugLineNum = 71;BA.debugLine="If EndIndex <= mLength Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("k",_endindex,BA.numberCast(double.class, __ref.getField(true,"_mlength" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 72;BA.debugLine="Dim AfterEndIndex() As Byte = SubArray(EndIndex)";
Debug.JustUpdateDeviceLine();
_afterendindex = __ref.runClassMethod (b4a.example.b4xbytesbuilder.class, "_subarray" /*RemoteObject*/ ,(Object)(_endindex));Debug.locals.put("AfterEndIndex", _afterendindex);Debug.locals.put("AfterEndIndex", _afterendindex);
 BA.debugLineNum = 73;BA.debugLine="Bit.ArrayCopy(AfterEndIndex, 0, mBuffer, BeginIn";
Debug.JustUpdateDeviceLine();
b4xbytesbuilder.__c.getField(false,"Bit").runVoidMethod ("ArrayCopy",(Object)((_afterendindex)),(Object)(BA.numberCast(int.class, 0)),(Object)((__ref.getField(false,"_mbuffer" /*RemoteObject*/ ))),(Object)(_beginindex),(Object)(_afterendindex.getField(true,"length")));
 };
 BA.debugLineNum = 75;BA.debugLine="ChangeLength(mLength - (EndIndex - BeginIndex))";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4a.example.b4xbytesbuilder.class, "_changelength" /*RemoteObject*/ ,(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_mlength" /*RemoteObject*/ ),(RemoteObject.solve(new RemoteObject[] {_endindex,_beginindex}, "-",1, 1))}, "-",1, 1)));
 BA.debugLineNum = 76;BA.debugLine="Return res";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return _res;
 BA.debugLineNum = 77;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _set(RemoteObject __ref,RemoteObject _index,RemoteObject _data) throws Exception{
try {
		Debug.PushSubsStack("Set (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,56);
if (RapidSub.canDelegate("set")) { return __ref.runUserSub(false, "b4xbytesbuilder","set", __ref, _index, _data);}
Debug.locals.put("Index", _index);
Debug.locals.put("Data", _data);
 BA.debugLineNum = 56;BA.debugLine="Public Sub Set(Index As Int, Data() As Byte)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 57;BA.debugLine="If Index >= mLength Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("g",_index,BA.numberCast(double.class, __ref.getField(true,"_mlength" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 58;BA.debugLine="If Index > mLength Then Log(\"Index too large\")";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",_index,BA.numberCast(double.class, __ref.getField(true,"_mlength" /*RemoteObject*/ )))) { 
b4xbytesbuilder.__c.runVoidMethod ("LogImpl","93604482",RemoteObject.createImmutable("Index too large"),0);};
 BA.debugLineNum = 59;BA.debugLine="Append(Data)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4a.example.b4xbytesbuilder.class, "_append" /*RemoteObject*/ ,(Object)(_data));
 }else {
 BA.debugLineNum = 61;BA.debugLine="If Data.Length + Index > mLength Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",RemoteObject.solve(new RemoteObject[] {_data.getField(true,"length"),_index}, "+",1, 1),BA.numberCast(double.class, __ref.getField(true,"_mlength" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 62;BA.debugLine="ChangeLength(Data.Length + Index)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4a.example.b4xbytesbuilder.class, "_changelength" /*RemoteObject*/ ,(Object)(RemoteObject.solve(new RemoteObject[] {_data.getField(true,"length"),_index}, "+",1, 1)));
 };
 BA.debugLineNum = 64;BA.debugLine="Bit.ArrayCopy(Data, 0, mBuffer, Index, Data.Leng";
Debug.JustUpdateDeviceLine();
b4xbytesbuilder.__c.getField(false,"Bit").runVoidMethod ("ArrayCopy",(Object)((_data)),(Object)(BA.numberCast(int.class, 0)),(Object)((__ref.getField(false,"_mbuffer" /*RemoteObject*/ ))),(Object)(_index),(Object)(_data.getField(true,"length")));
 };
 BA.debugLineNum = 66;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _subarray(RemoteObject __ref,RemoteObject _beginindex) throws Exception{
try {
		Debug.PushSubsStack("SubArray (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,80);
if (RapidSub.canDelegate("subarray")) { return __ref.runUserSub(false, "b4xbytesbuilder","subarray", __ref, _beginindex);}
Debug.locals.put("BeginIndex", _beginindex);
 BA.debugLineNum = 80;BA.debugLine="Public Sub SubArray(BeginIndex As Int) As Byte()";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 81;BA.debugLine="Return SubArray2(BeginIndex, mLength)";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return __ref.runClassMethod (b4a.example.b4xbytesbuilder.class, "_subarray2" /*RemoteObject*/ ,(Object)(_beginindex),(Object)(__ref.getField(true,"_mlength" /*RemoteObject*/ )));
 BA.debugLineNum = 82;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _subarray2(RemoteObject __ref,RemoteObject _beginindex,RemoteObject _endindex) throws Exception{
try {
		Debug.PushSubsStack("SubArray2 (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,86);
if (RapidSub.canDelegate("subarray2")) { return __ref.runUserSub(false, "b4xbytesbuilder","subarray2", __ref, _beginindex, _endindex);}
RemoteObject _b = null;
Debug.locals.put("BeginIndex", _beginindex);
Debug.locals.put("EndIndex", _endindex);
 BA.debugLineNum = 86;BA.debugLine="Public Sub SubArray2(BeginIndex As Int, EndIndex A";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 87;BA.debugLine="Dim b(EndIndex - BeginIndex) As Byte";
Debug.JustUpdateDeviceLine();
_b = RemoteObject.createNewArray ("byte", new int[] {RemoteObject.solve(new RemoteObject[] {_endindex,_beginindex}, "-",1, 1).<Integer>get().intValue()}, new Object[]{});Debug.locals.put("b", _b);
 BA.debugLineNum = 88;BA.debugLine="Bit.ArrayCopy(mBuffer, BeginIndex, b, 0, b.Length";
Debug.JustUpdateDeviceLine();
b4xbytesbuilder.__c.getField(false,"Bit").runVoidMethod ("ArrayCopy",(Object)((__ref.getField(false,"_mbuffer" /*RemoteObject*/ ))),(Object)(_beginindex),(Object)((_b)),(Object)(BA.numberCast(int.class, 0)),(Object)(_b.getField(true,"length")));
 BA.debugLineNum = 89;BA.debugLine="Return b";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return _b;
 BA.debugLineNum = 90;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _toarray(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("ToArray (b4xbytesbuilder) ","b4xbytesbuilder",6,__ref.getField(false, "ba"),__ref,97);
if (RapidSub.canDelegate("toarray")) { return __ref.runUserSub(false, "b4xbytesbuilder","toarray", __ref);}
 BA.debugLineNum = 97;BA.debugLine="Public Sub ToArray() As Byte()";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 98;BA.debugLine="Return SubArray(0)";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return __ref.runClassMethod (b4a.example.b4xbytesbuilder.class, "_subarray" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 0)));
 BA.debugLineNum = 99;BA.debugLine="End Sub";
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