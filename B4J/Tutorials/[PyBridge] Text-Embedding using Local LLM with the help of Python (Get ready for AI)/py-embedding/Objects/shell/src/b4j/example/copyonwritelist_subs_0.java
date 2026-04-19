package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class copyonwritelist_subs_0 {


public static RemoteObject  _add(RemoteObject __ref,RemoteObject _item) throws Exception{
try {
		Debug.PushSubsStack("Add (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,16);
if (RapidSub.canDelegate("add")) { return __ref.runUserSub(false, "copyonwritelist","add", __ref, _item);}
Debug.locals.put("Item", _item);
 BA.debugLineNum = 16;BA.debugLine="Public Sub Add (Item As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 17;BA.debugLine="MakeCopy";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.copyonwritelist.class, "_makecopy" /*RemoteObject*/ );
 BA.debugLineNum = 18;BA.debugLine="InternalList.Add(Item)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_internallist" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)(_item));
 BA.debugLineNum = 19;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _addall(RemoteObject __ref,RemoteObject _items) throws Exception{
try {
		Debug.PushSubsStack("AddAll (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,49);
if (RapidSub.canDelegate("addall")) { return __ref.runUserSub(false, "copyonwritelist","addall", __ref, _items);}
Debug.locals.put("Items", _items);
 BA.debugLineNum = 49;BA.debugLine="Public Sub AddAll (Items As List)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 50;BA.debugLine="MakeCopy";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.copyonwritelist.class, "_makecopy" /*RemoteObject*/ );
 BA.debugLineNum = 51;BA.debugLine="InternalList.AddAll(Items)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_internallist" /*RemoteObject*/ ).runVoidMethod ("AddAll",(Object)(_items));
 BA.debugLineNum = 52;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _addallat(RemoteObject __ref,RemoteObject _index,RemoteObject _items) throws Exception{
try {
		Debug.PushSubsStack("AddAllAt (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,54);
if (RapidSub.canDelegate("addallat")) { return __ref.runUserSub(false, "copyonwritelist","addallat", __ref, _index, _items);}
Debug.locals.put("Index", _index);
Debug.locals.put("Items", _items);
 BA.debugLineNum = 54;BA.debugLine="Public Sub AddAllAt (Index As Int, Items As List)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 55;BA.debugLine="MakeCopy";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.copyonwritelist.class, "_makecopy" /*RemoteObject*/ );
 BA.debugLineNum = 56;BA.debugLine="InternalList.AddAllAt(Index, Items)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_internallist" /*RemoteObject*/ ).runVoidMethod ("AddAllAt",(Object)(_index),(Object)(_items));
 BA.debugLineNum = 57;BA.debugLine="End Sub";
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
 //BA.debugLineNum = 4;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 5;BA.debugLine="Private InternalList As List";
copyonwritelist._internallist = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");__ref.setField("_internallist",copyonwritelist._internallist);
 //BA.debugLineNum = 6;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _clear(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Clear (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,26);
if (RapidSub.canDelegate("clear")) { return __ref.runUserSub(false, "copyonwritelist","clear", __ref);}
 BA.debugLineNum = 26;BA.debugLine="Public Sub Clear";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 27;BA.debugLine="Dim InternalList As List";
Debug.JustUpdateDeviceLine();
copyonwritelist._internallist = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");__ref.setField("_internallist",copyonwritelist._internallist);
 BA.debugLineNum = 28;BA.debugLine="InternalList.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_internallist" /*RemoteObject*/ ).runVoidMethod ("Initialize");
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
public static RemoteObject  _get(RemoteObject __ref,RemoteObject _index) throws Exception{
try {
		Debug.PushSubsStack("Get (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,31);
if (RapidSub.canDelegate("get")) { return __ref.runUserSub(false, "copyonwritelist","get", __ref, _index);}
Debug.locals.put("Index", _index);
 BA.debugLineNum = 31;BA.debugLine="Public Sub Get (Index As Int) As Boolean";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 32;BA.debugLine="Return InternalList.Get(Index)";
Debug.JustUpdateDeviceLine();
if (true) return BA.ObjectToBoolean(__ref.getField(false,"_internallist" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(_index)));
 BA.debugLineNum = 33;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getlist(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("GetList (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,84);
if (RapidSub.canDelegate("getlist")) { return __ref.runUserSub(false, "copyonwritelist","getlist", __ref);}
 BA.debugLineNum = 84;BA.debugLine="Public Sub GetList As List";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 85;BA.debugLine="Return InternalList";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_internallist" /*RemoteObject*/ );
 BA.debugLineNum = 86;BA.debugLine="End Sub";
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
		Debug.PushSubsStack("getSize (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,40);
if (RapidSub.canDelegate("getsize")) { return __ref.runUserSub(false, "copyonwritelist","getsize", __ref);}
 BA.debugLineNum = 40;BA.debugLine="Public Sub getSize As Int";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 41;BA.debugLine="Return InternalList.Size";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_internallist" /*RemoteObject*/ ).runMethod(true,"getSize");
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
public static RemoteObject  _indexof(RemoteObject __ref,RemoteObject _item) throws Exception{
try {
		Debug.PushSubsStack("IndexOf (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,59);
if (RapidSub.canDelegate("indexof")) { return __ref.runUserSub(false, "copyonwritelist","indexof", __ref, _item);}
Debug.locals.put("Item", _item);
 BA.debugLineNum = 59;BA.debugLine="Public Sub IndexOf (Item As Object) As Int";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 60;BA.debugLine="Return InternalList.IndexOf(Item)";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_internallist" /*RemoteObject*/ ).runMethod(true,"IndexOf",(Object)(_item));
 BA.debugLineNum = 61;BA.debugLine="End Sub";
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
		Debug.PushSubsStack("Initialize (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,8);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "copyonwritelist","initialize", __ref, _ba, _initialitems);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
Debug.locals.put("InitialItems", _initialitems);
 BA.debugLineNum = 8;BA.debugLine="Public Sub Initialize (InitialItems As List)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 9;BA.debugLine="InternalList = B4XCollections.CreateList(InitialI";
Debug.JustUpdateDeviceLine();
__ref.setField ("_internallist" /*RemoteObject*/ ,copyonwritelist._b4xcollections.runMethod(false,"_createlist" /*RemoteObject*/ ,(Object)(_initialitems)));
 BA.debugLineNum = 10;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _insertat(RemoteObject __ref,RemoteObject _index,RemoteObject _item) throws Exception{
try {
		Debug.PushSubsStack("InsertAt (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,44);
if (RapidSub.canDelegate("insertat")) { return __ref.runUserSub(false, "copyonwritelist","insertat", __ref, _index, _item);}
Debug.locals.put("Index", _index);
Debug.locals.put("Item", _item);
 BA.debugLineNum = 44;BA.debugLine="Public Sub InsertAt (Index As Int, Item As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 45;BA.debugLine="MakeCopy";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.copyonwritelist.class, "_makecopy" /*RemoteObject*/ );
 BA.debugLineNum = 46;BA.debugLine="InternalList.InsertAt(Index, Item)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_internallist" /*RemoteObject*/ ).runVoidMethod ("InsertAt",(Object)(_index),(Object)(_item));
 BA.debugLineNum = 47;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _makecopy(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("MakeCopy (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,12);
if (RapidSub.canDelegate("makecopy")) { return __ref.runUserSub(false, "copyonwritelist","makecopy", __ref);}
 BA.debugLineNum = 12;BA.debugLine="Private Sub MakeCopy";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 13;BA.debugLine="InternalList = B4XCollections.CreateList(Internal";
Debug.JustUpdateDeviceLine();
__ref.setField ("_internallist" /*RemoteObject*/ ,copyonwritelist._b4xcollections.runMethod(false,"_createlist" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_internallist" /*RemoteObject*/ ))));
 BA.debugLineNum = 14;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _removeat(RemoteObject __ref,RemoteObject _index) throws Exception{
try {
		Debug.PushSubsStack("RemoveAt (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,21);
if (RapidSub.canDelegate("removeat")) { return __ref.runUserSub(false, "copyonwritelist","removeat", __ref, _index);}
Debug.locals.put("Index", _index);
 BA.debugLineNum = 21;BA.debugLine="Public Sub RemoveAt (Index As Int)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 22;BA.debugLine="MakeCopy";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.copyonwritelist.class, "_makecopy" /*RemoteObject*/ );
 BA.debugLineNum = 23;BA.debugLine="InternalList.RemoveAt(Index)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_internallist" /*RemoteObject*/ ).runVoidMethod ("RemoveAt",(Object)(_index));
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
public static RemoteObject  _set(RemoteObject __ref,RemoteObject _index,RemoteObject _item) throws Exception{
try {
		Debug.PushSubsStack("Set (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,35);
if (RapidSub.canDelegate("set")) { return __ref.runUserSub(false, "copyonwritelist","set", __ref, _index, _item);}
Debug.locals.put("Index", _index);
Debug.locals.put("Item", _item);
 BA.debugLineNum = 35;BA.debugLine="Public Sub Set (Index As Int, Item As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 36;BA.debugLine="MakeCopy";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.copyonwritelist.class, "_makecopy" /*RemoteObject*/ );
 BA.debugLineNum = 37;BA.debugLine="InternalList.Set(Index, Item)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_internallist" /*RemoteObject*/ ).runVoidMethod ("Set",(Object)(_index),(Object)(_item));
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
public static RemoteObject  _sort(RemoteObject __ref,RemoteObject _ascending) throws Exception{
try {
		Debug.PushSubsStack("Sort (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,63);
if (RapidSub.canDelegate("sort")) { return __ref.runUserSub(false, "copyonwritelist","sort", __ref, _ascending);}
Debug.locals.put("Ascending", _ascending);
 BA.debugLineNum = 63;BA.debugLine="Public Sub Sort (Ascending As Boolean)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 64;BA.debugLine="MakeCopy";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.copyonwritelist.class, "_makecopy" /*RemoteObject*/ );
 BA.debugLineNum = 65;BA.debugLine="InternalList.Sort(Ascending)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_internallist" /*RemoteObject*/ ).runVoidMethod ("Sort",(Object)(_ascending));
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
public static RemoteObject  _sortcaseinsensitive(RemoteObject __ref,RemoteObject _ascending) throws Exception{
try {
		Debug.PushSubsStack("SortCaseInsensitive (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,68);
if (RapidSub.canDelegate("sortcaseinsensitive")) { return __ref.runUserSub(false, "copyonwritelist","sortcaseinsensitive", __ref, _ascending);}
Debug.locals.put("Ascending", _ascending);
 BA.debugLineNum = 68;BA.debugLine="Public Sub SortCaseInsensitive (Ascending As Boole";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 69;BA.debugLine="MakeCopy";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.copyonwritelist.class, "_makecopy" /*RemoteObject*/ );
 BA.debugLineNum = 70;BA.debugLine="InternalList.SortCaseInsensitive(Ascending)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_internallist" /*RemoteObject*/ ).runVoidMethod ("SortCaseInsensitive",(Object)(_ascending));
 BA.debugLineNum = 71;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _sorttype(RemoteObject __ref,RemoteObject _fieldname,RemoteObject _ascending) throws Exception{
try {
		Debug.PushSubsStack("SortType (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,73);
if (RapidSub.canDelegate("sorttype")) { return __ref.runUserSub(false, "copyonwritelist","sorttype", __ref, _fieldname, _ascending);}
Debug.locals.put("FieldName", _fieldname);
Debug.locals.put("Ascending", _ascending);
 BA.debugLineNum = 73;BA.debugLine="Public Sub SortType (FieldName As String, Ascendin";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 74;BA.debugLine="MakeCopy";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.copyonwritelist.class, "_makecopy" /*RemoteObject*/ );
 BA.debugLineNum = 75;BA.debugLine="InternalList.SortType(FieldName, Ascending)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_internallist" /*RemoteObject*/ ).runVoidMethod ("SortType",(Object)(_fieldname),(Object)(_ascending));
 BA.debugLineNum = 76;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _sorttypecaseinsensitive(RemoteObject __ref,RemoteObject _fieldname,RemoteObject _ascending) throws Exception{
try {
		Debug.PushSubsStack("SortTypeCaseInsensitive (copyonwritelist) ","copyonwritelist",16,__ref.getField(false, "ba"),__ref,78);
if (RapidSub.canDelegate("sorttypecaseinsensitive")) { return __ref.runUserSub(false, "copyonwritelist","sorttypecaseinsensitive", __ref, _fieldname, _ascending);}
Debug.locals.put("FieldName", _fieldname);
Debug.locals.put("Ascending", _ascending);
 BA.debugLineNum = 78;BA.debugLine="Public Sub SortTypeCaseInsensitive (FieldName As S";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 79;BA.debugLine="MakeCopy";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.copyonwritelist.class, "_makecopy" /*RemoteObject*/ );
 BA.debugLineNum = 80;BA.debugLine="InternalList.SortTypeCaseInsensitive(FieldName, A";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_internallist" /*RemoteObject*/ ).runVoidMethod ("SortTypeCaseInsensitive",(Object)(_fieldname),(Object)(_ascending));
 BA.debugLineNum = 81;BA.debugLine="End Sub";
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