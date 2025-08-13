package b4a.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xcomparatorsort_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 1;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 2;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (b4xcomparatorsort) ","b4xcomparatorsort",9,__ref.getField(false, "ba"),__ref,4);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "b4xcomparatorsort","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 4;BA.debugLine="Public Sub Initialize";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 5;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _partition(RemoteObject __ref,RemoteObject _data,RemoteObject _startindex,RemoteObject _length,RemoteObject _pivotindex,RemoteObject _comparator) throws Exception{
try {
		Debug.PushSubsStack("Partition (b4xcomparatorsort) ","b4xcomparatorsort",9,__ref.getField(false, "ba"),__ref,30);
if (RapidSub.canDelegate("partition")) { return __ref.runUserSub(false, "b4xcomparatorsort","partition", __ref, _data, _startindex, _length, _pivotindex, _comparator);}
RemoteObject _pivotvalue = RemoteObject.declareNull("Object");
RemoteObject _l = RemoteObject.createImmutable(0);
int _i = 0;
Debug.locals.put("Data", _data);
Debug.locals.put("StartIndex", _startindex);
Debug.locals.put("Length", _length);
Debug.locals.put("PivotIndex", _pivotindex);
Debug.locals.put("Comparator", _comparator);
 BA.debugLineNum = 30;BA.debugLine="Private Sub Partition(Data As List, StartIndex As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 31;BA.debugLine="Dim PivotValue As Object = Data.Get(StartIndex +";
Debug.JustUpdateDeviceLine();
_pivotvalue = _data.runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {_startindex,_pivotindex}, "+",1, 1)));Debug.locals.put("PivotValue", _pivotvalue);Debug.locals.put("PivotValue", _pivotvalue);
 BA.debugLineNum = 32;BA.debugLine="Swap(Data, StartIndex, PivotIndex, Length - 1)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4a.example.b4xcomparatorsort.class, "_swap" /*RemoteObject*/ ,(Object)(_data),(Object)(_startindex),(Object)(_pivotindex),(Object)(RemoteObject.solve(new RemoteObject[] {_length,RemoteObject.createImmutable(1)}, "-",1, 1)));
 BA.debugLineNum = 33;BA.debugLine="Dim L As Int = 0";
Debug.JustUpdateDeviceLine();
_l = BA.numberCast(int.class, 0);Debug.locals.put("L", _l);Debug.locals.put("L", _l);
 BA.debugLineNum = 34;BA.debugLine="For i = 0 To Length - 2";
Debug.JustUpdateDeviceLine();
{
final int step4 = 1;
final int limit4 = RemoteObject.solve(new RemoteObject[] {_length,RemoteObject.createImmutable(2)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step4 > 0 && _i <= limit4) || (step4 < 0 && _i >= limit4) ;_i = ((int)(0 + _i + step4))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 35;BA.debugLine="If CallSub3(Comparator, \"Compare\", Data.Get(Star";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("<",(BA.numberCast(int.class, b4xcomparatorsort.__c.runMethodAndSync(false,"CallSubNew3",__ref.getField(false, "ba"),(Object)(_comparator),(Object)(BA.ObjectToString("Compare")),(Object)(_data.runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {_startindex,RemoteObject.createImmutable(_i)}, "+",1, 1)))),(Object)(_pivotvalue)))),BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 36;BA.debugLine="L = L + 1";
Debug.JustUpdateDeviceLine();
_l = RemoteObject.solve(new RemoteObject[] {_l,RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("L", _l);
 BA.debugLineNum = 37;BA.debugLine="Swap(Data, StartIndex, L - 1, i)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4a.example.b4xcomparatorsort.class, "_swap" /*RemoteObject*/ ,(Object)(_data),(Object)(_startindex),(Object)(RemoteObject.solve(new RemoteObject[] {_l,RemoteObject.createImmutable(1)}, "-",1, 1)),(Object)(BA.numberCast(int.class, _i)));
 };
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 40;BA.debugLine="Swap(Data, StartIndex, Length - 1, L)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4a.example.b4xcomparatorsort.class, "_swap" /*RemoteObject*/ ,(Object)(_data),(Object)(_startindex),(Object)(RemoteObject.solve(new RemoteObject[] {_length,RemoteObject.createImmutable(1)}, "-",1, 1)),(Object)(_l));
 BA.debugLineNum = 41;BA.debugLine="Return L";
Debug.JustUpdateDeviceLine();
Debug.CheckDeviceExceptions();if (true) return _l;
 BA.debugLineNum = 42;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _quicksort(RemoteObject __ref,RemoteObject _data,RemoteObject _startindex,RemoteObject _length,RemoteObject _comparator) throws Exception{
try {
		Debug.PushSubsStack("QuickSort (b4xcomparatorsort) ","b4xcomparatorsort",9,__ref.getField(false, "ba"),__ref,21);
if (RapidSub.canDelegate("quicksort")) { return __ref.runUserSub(false, "b4xcomparatorsort","quicksort", __ref, _data, _startindex, _length, _comparator);}
RemoteObject _pivotindex = RemoteObject.createImmutable(0);
RemoteObject _r = RemoteObject.createImmutable(0);
Debug.locals.put("Data", _data);
Debug.locals.put("StartIndex", _startindex);
Debug.locals.put("Length", _length);
Debug.locals.put("Comparator", _comparator);
 BA.debugLineNum = 21;BA.debugLine="Private Sub QuickSort (Data As List, StartIndex As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 22;BA.debugLine="If Length > 1 Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",_length,BA.numberCast(double.class, 1))) { 
 BA.debugLineNum = 23;BA.debugLine="Dim PivotIndex As Int = Rnd(0, Length)";
Debug.JustUpdateDeviceLine();
_pivotindex = b4xcomparatorsort.__c.runMethod(true,"Rnd",(Object)(BA.numberCast(int.class, 0)),(Object)(_length));Debug.locals.put("PivotIndex", _pivotindex);Debug.locals.put("PivotIndex", _pivotindex);
 BA.debugLineNum = 24;BA.debugLine="Dim r As Int = Partition(Data, StartIndex, Lengt";
Debug.JustUpdateDeviceLine();
_r = __ref.runClassMethod (b4a.example.b4xcomparatorsort.class, "_partition" /*RemoteObject*/ ,(Object)(_data),(Object)(_startindex),(Object)(_length),(Object)(_pivotindex),(Object)(_comparator));Debug.locals.put("r", _r);Debug.locals.put("r", _r);
 BA.debugLineNum = 25;BA.debugLine="QuickSort(Data, StartIndex, r, Comparator)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4a.example.b4xcomparatorsort.class, "_quicksort" /*RemoteObject*/ ,(Object)(_data),(Object)(_startindex),(Object)(_r),(Object)(_comparator));
 BA.debugLineNum = 26;BA.debugLine="QuickSort(Data, StartIndex + r + 1, Length - r -";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4a.example.b4xcomparatorsort.class, "_quicksort" /*RemoteObject*/ ,(Object)(_data),(Object)(RemoteObject.solve(new RemoteObject[] {_startindex,_r,RemoteObject.createImmutable(1)}, "++",2, 1)),(Object)(RemoteObject.solve(new RemoteObject[] {_length,_r,RemoteObject.createImmutable(1)}, "--",2, 1)),(Object)(_comparator));
 };
 BA.debugLineNum = 28;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _sort(RemoteObject __ref,RemoteObject _data,RemoteObject _comparator) throws Exception{
try {
		Debug.PushSubsStack("Sort (b4xcomparatorsort) ","b4xcomparatorsort",9,__ref.getField(false, "ba"),__ref,12);
if (RapidSub.canDelegate("sort")) { return __ref.runUserSub(false, "b4xcomparatorsort","sort", __ref, _data, _comparator);}
Debug.locals.put("Data", _data);
Debug.locals.put("Comparator", _comparator);
 BA.debugLineNum = 12;BA.debugLine="Public Sub Sort (Data As List, Comparator As Objec";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 14;BA.debugLine="QuickSort(Data, 0, Data.Size, Comparator)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4a.example.b4xcomparatorsort.class, "_quicksort" /*RemoteObject*/ ,(Object)(_data),(Object)(BA.numberCast(int.class, 0)),(Object)(_data.runMethod(true,"getSize")),(Object)(_comparator));
 BA.debugLineNum = 18;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _swap(RemoteObject __ref,RemoteObject _data,RemoteObject _startindex,RemoteObject _i1,RemoteObject _i2) throws Exception{
try {
		Debug.PushSubsStack("Swap (b4xcomparatorsort) ","b4xcomparatorsort",9,__ref.getField(false, "ba"),__ref,44);
if (RapidSub.canDelegate("swap")) { return __ref.runUserSub(false, "b4xcomparatorsort","swap", __ref, _data, _startindex, _i1, _i2);}
RemoteObject _o = RemoteObject.declareNull("Object");
Debug.locals.put("Data", _data);
Debug.locals.put("StartIndex", _startindex);
Debug.locals.put("i1", _i1);
Debug.locals.put("i2", _i2);
 BA.debugLineNum = 44;BA.debugLine="Private Sub Swap (Data As List, StartIndex As Int,";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 45;BA.debugLine="Dim o As Object = Data.Get(StartIndex + i1)";
Debug.JustUpdateDeviceLine();
_o = _data.runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {_startindex,_i1}, "+",1, 1)));Debug.locals.put("o", _o);Debug.locals.put("o", _o);
 BA.debugLineNum = 46;BA.debugLine="Data.Set(StartIndex + i1, Data.Get(StartIndex + i";
Debug.JustUpdateDeviceLine();
_data.runVoidMethod ("Set",(Object)(RemoteObject.solve(new RemoteObject[] {_startindex,_i1}, "+",1, 1)),(Object)(_data.runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {_startindex,_i2}, "+",1, 1)))));
 BA.debugLineNum = 47;BA.debugLine="Data.Set(StartIndex + i2, o)";
Debug.JustUpdateDeviceLine();
_data.runVoidMethod ("Set",(Object)(RemoteObject.solve(new RemoteObject[] {_startindex,_i2}, "+",1, 1)),(Object)(_o));
 BA.debugLineNum = 48;BA.debugLine="End Sub";
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