package b4j.HTMLEditorFix;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class b4xorderedmap extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.HTMLEditorFix", "b4j.HTMLEditorFix.b4xorderedmap", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.HTMLEditorFix.b4xorderedmap.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 
    public void  innerInitializeHelper(anywheresoftware.b4a.BA _ba) throws Exception{
        innerInitialize(_ba);
    }
    public Object callSub(String sub, Object sender, Object[] args) throws Exception {
        return BA.SubDelegator.SubNotFound;
    }
public anywheresoftware.b4a.keywords.Common __c = null;
public anywheresoftware.b4a.objects.collections.Map _map = null;
public anywheresoftware.b4a.objects.collections.List _list = null;
public b4j.HTMLEditorFix.main _main = null;
public b4j.HTMLEditorFix.b4xpages _b4xpages = null;
public b4j.HTMLEditorFix.b4xcollections _b4xcollections = null;
public String  _initialize(b4j.HTMLEditorFix.b4xorderedmap __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "initialize", true))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=3538944;
 //BA.debugLineNum = 3538944;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=3538945;
 //BA.debugLineNum = 3538945;BA.debugLine="map.Initialize";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Initialize();
RDebugUtils.currentLine=3538946;
 //BA.debugLineNum = 3538946;BA.debugLine="list.Initialize";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=3538947;
 //BA.debugLineNum = 3538947;BA.debugLine="End Sub";
return "";
}
public String  _put(b4j.HTMLEditorFix.b4xorderedmap __ref,Object _key,Object _value) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "put", true))
	 {return ((String) Debug.delegate(ba, "put", new Object[] {_key,_value}));}
RDebugUtils.currentLine=3604480;
 //BA.debugLineNum = 3604480;BA.debugLine="Public Sub Put (Key As Object, Value As Object)";
RDebugUtils.currentLine=3604481;
 //BA.debugLineNum = 3604481;BA.debugLine="If map.ContainsKey(Key) = False Then";
if (__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .ContainsKey(_key)==__c.False) { 
RDebugUtils.currentLine=3604482;
 //BA.debugLineNum = 3604482;BA.debugLine="list.Add(Key)";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .Add(_key);
 };
RDebugUtils.currentLine=3604484;
 //BA.debugLineNum = 3604484;BA.debugLine="map.Put(Key, Value)";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Put(_key,_value);
RDebugUtils.currentLine=3604485;
 //BA.debugLineNum = 3604485;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4j.HTMLEditorFix.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
RDebugUtils.currentLine=3473408;
 //BA.debugLineNum = 3473408;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=3473409;
 //BA.debugLineNum = 3473409;BA.debugLine="Private map As Map";
_map = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=3473410;
 //BA.debugLineNum = 3473410;BA.debugLine="Private list As List";
_list = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=3473411;
 //BA.debugLineNum = 3473411;BA.debugLine="End Sub";
return "";
}
public String  _clear(b4j.HTMLEditorFix.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "clear", true))
	 {return ((String) Debug.delegate(ba, "clear", null));}
RDebugUtils.currentLine=3735552;
 //BA.debugLineNum = 3735552;BA.debugLine="Public Sub Clear";
RDebugUtils.currentLine=3735553;
 //BA.debugLineNum = 3735553;BA.debugLine="list.Clear";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .Clear();
RDebugUtils.currentLine=3735554;
 //BA.debugLineNum = 3735554;BA.debugLine="map.Clear";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Clear();
RDebugUtils.currentLine=3735555;
 //BA.debugLineNum = 3735555;BA.debugLine="End Sub";
return "";
}
public boolean  _containskey(b4j.HTMLEditorFix.b4xorderedmap __ref,Object _key) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "containskey", true))
	 {return ((Boolean) Debug.delegate(ba, "containskey", new Object[] {_key}));}
RDebugUtils.currentLine=3997696;
 //BA.debugLineNum = 3997696;BA.debugLine="Public Sub ContainsKey (Key As Object) As Boolean";
RDebugUtils.currentLine=3997697;
 //BA.debugLineNum = 3997697;BA.debugLine="Return map.ContainsKey(Key)";
if (true) return __ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .ContainsKey(_key);
RDebugUtils.currentLine=3997698;
 //BA.debugLineNum = 3997698;BA.debugLine="End Sub";
return false;
}
public Object  _get(b4j.HTMLEditorFix.b4xorderedmap __ref,Object _key) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "get", true))
	 {return ((Object) Debug.delegate(ba, "get", new Object[] {_key}));}
RDebugUtils.currentLine=3866624;
 //BA.debugLineNum = 3866624;BA.debugLine="Public Sub Get (Key As Object) As Object";
RDebugUtils.currentLine=3866625;
 //BA.debugLineNum = 3866625;BA.debugLine="Return map.Get(Key)";
if (true) return __ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Get(_key);
RDebugUtils.currentLine=3866626;
 //BA.debugLineNum = 3866626;BA.debugLine="End Sub";
return null;
}
public Object  _getdataforserializator(b4j.HTMLEditorFix.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getdataforserializator", true))
	 {return ((Object) Debug.delegate(ba, "getdataforserializator", null));}
RDebugUtils.currentLine=4194304;
 //BA.debugLineNum = 4194304;BA.debugLine="Public Sub GetDataForSerializator As Object";
RDebugUtils.currentLine=4194305;
 //BA.debugLineNum = 4194305;BA.debugLine="Return Array(map, list)";
if (true) return (Object)(new Object[]{(Object)(__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .getObject()),(Object)(__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .getObject())});
RDebugUtils.currentLine=4194306;
 //BA.debugLineNum = 4194306;BA.debugLine="End Sub";
return null;
}
public Object  _getdefault(b4j.HTMLEditorFix.b4xorderedmap __ref,Object _key,Object _defaultvalue) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getdefault", true))
	 {return ((Object) Debug.delegate(ba, "getdefault", new Object[] {_key,_defaultvalue}));}
RDebugUtils.currentLine=3932160;
 //BA.debugLineNum = 3932160;BA.debugLine="Public Sub GetDefault (Key As Object, DefaultValue";
RDebugUtils.currentLine=3932161;
 //BA.debugLineNum = 3932161;BA.debugLine="Return map.GetDefault(Key, DefaultValue)";
if (true) return __ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .GetDefault(_key,_defaultvalue);
RDebugUtils.currentLine=3932162;
 //BA.debugLineNum = 3932162;BA.debugLine="End Sub";
return null;
}
public anywheresoftware.b4a.objects.collections.List  _getkeys(b4j.HTMLEditorFix.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getkeys", true))
	 {return ((anywheresoftware.b4a.objects.collections.List) Debug.delegate(ba, "getkeys", null));}
RDebugUtils.currentLine=3801088;
 //BA.debugLineNum = 3801088;BA.debugLine="Public Sub getKeys As List";
RDebugUtils.currentLine=3801089;
 //BA.debugLineNum = 3801089;BA.debugLine="Return list";
if (true) return __ref._list /*anywheresoftware.b4a.objects.collections.List*/ ;
RDebugUtils.currentLine=3801090;
 //BA.debugLineNum = 3801090;BA.debugLine="End Sub";
return null;
}
public int  _getsize(b4j.HTMLEditorFix.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getsize", true))
	 {return ((Integer) Debug.delegate(ba, "getsize", null));}
RDebugUtils.currentLine=4063232;
 //BA.debugLineNum = 4063232;BA.debugLine="Public Sub getSize As Int";
RDebugUtils.currentLine=4063233;
 //BA.debugLineNum = 4063233;BA.debugLine="Return map.Size";
if (true) return __ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .getSize();
RDebugUtils.currentLine=4063234;
 //BA.debugLineNum = 4063234;BA.debugLine="End Sub";
return 0;
}
public anywheresoftware.b4a.objects.collections.List  _getvalues(b4j.HTMLEditorFix.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getvalues", true))
	 {return ((anywheresoftware.b4a.objects.collections.List) Debug.delegate(ba, "getvalues", null));}
anywheresoftware.b4a.objects.collections.List _res = null;
Object _key = null;
RDebugUtils.currentLine=4128768;
 //BA.debugLineNum = 4128768;BA.debugLine="Public Sub getValues As List";
RDebugUtils.currentLine=4128769;
 //BA.debugLineNum = 4128769;BA.debugLine="Dim res As List";
_res = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=4128770;
 //BA.debugLineNum = 4128770;BA.debugLine="res.Initialize";
_res.Initialize();
RDebugUtils.currentLine=4128771;
 //BA.debugLineNum = 4128771;BA.debugLine="For Each key As Object In list";
{
final anywheresoftware.b4a.BA.IterableList group3 = __ref._list /*anywheresoftware.b4a.objects.collections.List*/ ;
final int groupLen3 = group3.getSize()
;int index3 = 0;
;
for (; index3 < groupLen3;index3++){
_key = group3.Get(index3);
RDebugUtils.currentLine=4128772;
 //BA.debugLineNum = 4128772;BA.debugLine="res.Add(map.Get(key))";
_res.Add(__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Get(_key));
 }
};
RDebugUtils.currentLine=4128774;
 //BA.debugLineNum = 4128774;BA.debugLine="Return res";
if (true) return _res;
RDebugUtils.currentLine=4128775;
 //BA.debugLineNum = 4128775;BA.debugLine="End Sub";
return null;
}
public String  _remove(b4j.HTMLEditorFix.b4xorderedmap __ref,Object _key) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "remove", true))
	 {return ((String) Debug.delegate(ba, "remove", new Object[] {_key}));}
RDebugUtils.currentLine=3670016;
 //BA.debugLineNum = 3670016;BA.debugLine="Public Sub Remove (Key As Object)";
RDebugUtils.currentLine=3670017;
 //BA.debugLineNum = 3670017;BA.debugLine="If map.ContainsKey(Key) = False Then Return";
if (__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .ContainsKey(_key)==__c.False) { 
if (true) return "";};
RDebugUtils.currentLine=3670018;
 //BA.debugLineNum = 3670018;BA.debugLine="list.RemoveAt(list.IndexOf(Key))";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .RemoveAt(__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .IndexOf(_key));
RDebugUtils.currentLine=3670019;
 //BA.debugLineNum = 3670019;BA.debugLine="map.Remove(Key)";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Remove(_key);
RDebugUtils.currentLine=3670020;
 //BA.debugLineNum = 3670020;BA.debugLine="End Sub";
return "";
}
public String  _setdatafromserializator(b4j.HTMLEditorFix.b4xorderedmap __ref,Object _data) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "setdatafromserializator", true))
	 {return ((String) Debug.delegate(ba, "setdatafromserializator", new Object[] {_data}));}
Object[] _o = null;
RDebugUtils.currentLine=4259840;
 //BA.debugLineNum = 4259840;BA.debugLine="Public Sub SetDataFromSerializator (Data As Object";
RDebugUtils.currentLine=4259841;
 //BA.debugLineNum = 4259841;BA.debugLine="Dim o() As Object = Data";
_o = (Object[])(_data);
RDebugUtils.currentLine=4259842;
 //BA.debugLineNum = 4259842;BA.debugLine="map = o(0)";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/  = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (anywheresoftware.b4a.objects.collections.Map.MyMap)(_o[(int) (0)]));
RDebugUtils.currentLine=4259843;
 //BA.debugLineNum = 4259843;BA.debugLine="list = o(1)";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/  = (anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_o[(int) (1)]));
RDebugUtils.currentLine=4259844;
 //BA.debugLineNum = 4259844;BA.debugLine="End Sub";
return "";
}
}