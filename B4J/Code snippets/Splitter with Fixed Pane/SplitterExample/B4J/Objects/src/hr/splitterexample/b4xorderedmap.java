package hr.splitterexample;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class b4xorderedmap extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("hr.splitterexample", "hr.splitterexample.b4xorderedmap", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", hr.splitterexample.b4xorderedmap.class).invoke(this, new Object[] {null});
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
public hr.splitterexample.main _main = null;
public hr.splitterexample.b4xpages _b4xpages = null;
public hr.splitterexample.b4xcollections _b4xcollections = null;
public String  _initialize(hr.splitterexample.b4xorderedmap __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "initialize", true))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=4718592;
 //BA.debugLineNum = 4718592;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=4718593;
 //BA.debugLineNum = 4718593;BA.debugLine="map.Initialize";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Initialize();
RDebugUtils.currentLine=4718594;
 //BA.debugLineNum = 4718594;BA.debugLine="list.Initialize";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=4718595;
 //BA.debugLineNum = 4718595;BA.debugLine="End Sub";
return "";
}
public String  _put(hr.splitterexample.b4xorderedmap __ref,Object _key,Object _value) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "put", true))
	 {return ((String) Debug.delegate(ba, "put", new Object[] {_key,_value}));}
RDebugUtils.currentLine=4784128;
 //BA.debugLineNum = 4784128;BA.debugLine="Public Sub Put (Key As Object, Value As Object)";
RDebugUtils.currentLine=4784129;
 //BA.debugLineNum = 4784129;BA.debugLine="If map.ContainsKey(Key) = False Then";
if (__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .ContainsKey(_key)==__c.False) { 
RDebugUtils.currentLine=4784130;
 //BA.debugLineNum = 4784130;BA.debugLine="list.Add(Key)";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .Add(_key);
 };
RDebugUtils.currentLine=4784132;
 //BA.debugLineNum = 4784132;BA.debugLine="map.Put(Key, Value)";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Put(_key,_value);
RDebugUtils.currentLine=4784133;
 //BA.debugLineNum = 4784133;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(hr.splitterexample.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
RDebugUtils.currentLine=4653056;
 //BA.debugLineNum = 4653056;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=4653057;
 //BA.debugLineNum = 4653057;BA.debugLine="Private map As Map";
_map = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=4653058;
 //BA.debugLineNum = 4653058;BA.debugLine="Private list As List";
_list = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=4653059;
 //BA.debugLineNum = 4653059;BA.debugLine="End Sub";
return "";
}
public String  _clear(hr.splitterexample.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "clear", true))
	 {return ((String) Debug.delegate(ba, "clear", null));}
RDebugUtils.currentLine=4915200;
 //BA.debugLineNum = 4915200;BA.debugLine="Public Sub Clear";
RDebugUtils.currentLine=4915201;
 //BA.debugLineNum = 4915201;BA.debugLine="list.Clear";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .Clear();
RDebugUtils.currentLine=4915202;
 //BA.debugLineNum = 4915202;BA.debugLine="map.Clear";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Clear();
RDebugUtils.currentLine=4915203;
 //BA.debugLineNum = 4915203;BA.debugLine="End Sub";
return "";
}
public boolean  _containskey(hr.splitterexample.b4xorderedmap __ref,Object _key) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "containskey", true))
	 {return ((Boolean) Debug.delegate(ba, "containskey", new Object[] {_key}));}
RDebugUtils.currentLine=5177344;
 //BA.debugLineNum = 5177344;BA.debugLine="Public Sub ContainsKey (Key As Object) As Boolean";
RDebugUtils.currentLine=5177345;
 //BA.debugLineNum = 5177345;BA.debugLine="Return map.ContainsKey(Key)";
if (true) return __ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .ContainsKey(_key);
RDebugUtils.currentLine=5177346;
 //BA.debugLineNum = 5177346;BA.debugLine="End Sub";
return false;
}
public Object  _get(hr.splitterexample.b4xorderedmap __ref,Object _key) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "get", true))
	 {return ((Object) Debug.delegate(ba, "get", new Object[] {_key}));}
RDebugUtils.currentLine=5046272;
 //BA.debugLineNum = 5046272;BA.debugLine="Public Sub Get (Key As Object) As Object";
RDebugUtils.currentLine=5046273;
 //BA.debugLineNum = 5046273;BA.debugLine="Return map.Get(Key)";
if (true) return __ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Get(_key);
RDebugUtils.currentLine=5046274;
 //BA.debugLineNum = 5046274;BA.debugLine="End Sub";
return null;
}
public Object  _getdataforserializator(hr.splitterexample.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getdataforserializator", true))
	 {return ((Object) Debug.delegate(ba, "getdataforserializator", null));}
RDebugUtils.currentLine=5373952;
 //BA.debugLineNum = 5373952;BA.debugLine="Public Sub GetDataForSerializator As Object";
RDebugUtils.currentLine=5373953;
 //BA.debugLineNum = 5373953;BA.debugLine="Return Array(map, list)";
if (true) return (Object)(new Object[]{(Object)(__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .getObject()),(Object)(__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .getObject())});
RDebugUtils.currentLine=5373954;
 //BA.debugLineNum = 5373954;BA.debugLine="End Sub";
return null;
}
public Object  _getdefault(hr.splitterexample.b4xorderedmap __ref,Object _key,Object _defaultvalue) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getdefault", true))
	 {return ((Object) Debug.delegate(ba, "getdefault", new Object[] {_key,_defaultvalue}));}
RDebugUtils.currentLine=5111808;
 //BA.debugLineNum = 5111808;BA.debugLine="Public Sub GetDefault (Key As Object, DefaultValue";
RDebugUtils.currentLine=5111809;
 //BA.debugLineNum = 5111809;BA.debugLine="Return map.GetDefault(Key, DefaultValue)";
if (true) return __ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .GetDefault(_key,_defaultvalue);
RDebugUtils.currentLine=5111810;
 //BA.debugLineNum = 5111810;BA.debugLine="End Sub";
return null;
}
public anywheresoftware.b4a.objects.collections.List  _getkeys(hr.splitterexample.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getkeys", true))
	 {return ((anywheresoftware.b4a.objects.collections.List) Debug.delegate(ba, "getkeys", null));}
RDebugUtils.currentLine=4980736;
 //BA.debugLineNum = 4980736;BA.debugLine="Public Sub getKeys As List";
RDebugUtils.currentLine=4980737;
 //BA.debugLineNum = 4980737;BA.debugLine="Return list";
if (true) return __ref._list /*anywheresoftware.b4a.objects.collections.List*/ ;
RDebugUtils.currentLine=4980738;
 //BA.debugLineNum = 4980738;BA.debugLine="End Sub";
return null;
}
public int  _getsize(hr.splitterexample.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getsize", true))
	 {return ((Integer) Debug.delegate(ba, "getsize", null));}
RDebugUtils.currentLine=5242880;
 //BA.debugLineNum = 5242880;BA.debugLine="Public Sub getSize As Int";
RDebugUtils.currentLine=5242881;
 //BA.debugLineNum = 5242881;BA.debugLine="Return map.Size";
if (true) return __ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .getSize();
RDebugUtils.currentLine=5242882;
 //BA.debugLineNum = 5242882;BA.debugLine="End Sub";
return 0;
}
public anywheresoftware.b4a.objects.collections.List  _getvalues(hr.splitterexample.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getvalues", true))
	 {return ((anywheresoftware.b4a.objects.collections.List) Debug.delegate(ba, "getvalues", null));}
anywheresoftware.b4a.objects.collections.List _res = null;
Object _key = null;
RDebugUtils.currentLine=5308416;
 //BA.debugLineNum = 5308416;BA.debugLine="Public Sub getValues As List";
RDebugUtils.currentLine=5308417;
 //BA.debugLineNum = 5308417;BA.debugLine="Dim res As List";
_res = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=5308418;
 //BA.debugLineNum = 5308418;BA.debugLine="res.Initialize";
_res.Initialize();
RDebugUtils.currentLine=5308419;
 //BA.debugLineNum = 5308419;BA.debugLine="For Each key As Object In list";
{
final anywheresoftware.b4a.BA.IterableList group3 = __ref._list /*anywheresoftware.b4a.objects.collections.List*/ ;
final int groupLen3 = group3.getSize()
;int index3 = 0;
;
for (; index3 < groupLen3;index3++){
_key = group3.Get(index3);
RDebugUtils.currentLine=5308420;
 //BA.debugLineNum = 5308420;BA.debugLine="res.Add(map.Get(key))";
_res.Add(__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Get(_key));
 }
};
RDebugUtils.currentLine=5308422;
 //BA.debugLineNum = 5308422;BA.debugLine="Return res";
if (true) return _res;
RDebugUtils.currentLine=5308423;
 //BA.debugLineNum = 5308423;BA.debugLine="End Sub";
return null;
}
public String  _remove(hr.splitterexample.b4xorderedmap __ref,Object _key) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "remove", true))
	 {return ((String) Debug.delegate(ba, "remove", new Object[] {_key}));}
RDebugUtils.currentLine=4849664;
 //BA.debugLineNum = 4849664;BA.debugLine="Public Sub Remove (Key As Object)";
RDebugUtils.currentLine=4849665;
 //BA.debugLineNum = 4849665;BA.debugLine="If map.ContainsKey(Key) = False Then Return";
if (__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .ContainsKey(_key)==__c.False) { 
if (true) return "";};
RDebugUtils.currentLine=4849666;
 //BA.debugLineNum = 4849666;BA.debugLine="list.RemoveAt(list.IndexOf(Key))";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .RemoveAt(__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .IndexOf(_key));
RDebugUtils.currentLine=4849667;
 //BA.debugLineNum = 4849667;BA.debugLine="map.Remove(Key)";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Remove(_key);
RDebugUtils.currentLine=4849668;
 //BA.debugLineNum = 4849668;BA.debugLine="End Sub";
return "";
}
public String  _setdatafromserializator(hr.splitterexample.b4xorderedmap __ref,Object _data) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "setdatafromserializator", true))
	 {return ((String) Debug.delegate(ba, "setdatafromserializator", new Object[] {_data}));}
Object[] _o = null;
RDebugUtils.currentLine=5439488;
 //BA.debugLineNum = 5439488;BA.debugLine="Public Sub SetDataFromSerializator (Data As Object";
RDebugUtils.currentLine=5439489;
 //BA.debugLineNum = 5439489;BA.debugLine="Dim o() As Object = Data";
_o = (Object[])(_data);
RDebugUtils.currentLine=5439490;
 //BA.debugLineNum = 5439490;BA.debugLine="map = o(0)";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/  = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (anywheresoftware.b4a.objects.collections.Map.MyMap)(_o[(int) (0)]));
RDebugUtils.currentLine=5439491;
 //BA.debugLineNum = 5439491;BA.debugLine="list = o(1)";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/  = (anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_o[(int) (1)]));
RDebugUtils.currentLine=5439492;
 //BA.debugLineNum = 5439492;BA.debugLine="End Sub";
return "";
}
}