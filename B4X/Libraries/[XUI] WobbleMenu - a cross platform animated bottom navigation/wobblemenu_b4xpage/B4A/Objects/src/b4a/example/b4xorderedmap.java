package b4a.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.debug.*;

public class b4xorderedmap extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    private static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new anywheresoftware.b4a.ShellBA(_ba, this, htSubs, "b4a.example.b4xorderedmap");
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            
        }
        if (BA.isShellModeRuntimeCheck(ba)) 
			   this.getClass().getMethod("_class_globals", b4a.example.b4xorderedmap.class).invoke(this, new Object[] {null});
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
public b4a.example.main _main = null;
public b4a.example.starter _starter = null;
public b4a.example.b4xpages _b4xpages = null;
public b4a.example.b4xcollections _b4xcollections = null;
public String  _initialize(b4a.example.b4xorderedmap __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "initialize", true))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=4063232;
 //BA.debugLineNum = 4063232;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=4063233;
 //BA.debugLineNum = 4063233;BA.debugLine="map.Initialize";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Initialize();
RDebugUtils.currentLine=4063234;
 //BA.debugLineNum = 4063234;BA.debugLine="list.Initialize";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=4063235;
 //BA.debugLineNum = 4063235;BA.debugLine="End Sub";
return "";
}
public String  _put(b4a.example.b4xorderedmap __ref,Object _key,Object _value) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "put", true))
	 {return ((String) Debug.delegate(ba, "put", new Object[] {_key,_value}));}
RDebugUtils.currentLine=4128768;
 //BA.debugLineNum = 4128768;BA.debugLine="Public Sub Put (Key As Object, Value As Object)";
RDebugUtils.currentLine=4128769;
 //BA.debugLineNum = 4128769;BA.debugLine="If map.ContainsKey(Key) = False Then";
if (__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .ContainsKey(_key)==__c.False) { 
RDebugUtils.currentLine=4128770;
 //BA.debugLineNum = 4128770;BA.debugLine="list.Add(Key)";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .Add(_key);
 };
RDebugUtils.currentLine=4128772;
 //BA.debugLineNum = 4128772;BA.debugLine="map.Put(Key, Value)";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Put(_key,_value);
RDebugUtils.currentLine=4128773;
 //BA.debugLineNum = 4128773;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4a.example.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
RDebugUtils.currentLine=3997696;
 //BA.debugLineNum = 3997696;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=3997697;
 //BA.debugLineNum = 3997697;BA.debugLine="Private map As Map";
_map = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=3997698;
 //BA.debugLineNum = 3997698;BA.debugLine="Private list As List";
_list = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=3997699;
 //BA.debugLineNum = 3997699;BA.debugLine="End Sub";
return "";
}
public String  _clear(b4a.example.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "clear", true))
	 {return ((String) Debug.delegate(ba, "clear", null));}
RDebugUtils.currentLine=4259840;
 //BA.debugLineNum = 4259840;BA.debugLine="Public Sub Clear";
RDebugUtils.currentLine=4259841;
 //BA.debugLineNum = 4259841;BA.debugLine="list.Clear";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .Clear();
RDebugUtils.currentLine=4259842;
 //BA.debugLineNum = 4259842;BA.debugLine="map.Clear";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Clear();
RDebugUtils.currentLine=4259843;
 //BA.debugLineNum = 4259843;BA.debugLine="End Sub";
return "";
}
public boolean  _containskey(b4a.example.b4xorderedmap __ref,Object _key) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "containskey", true))
	 {return ((Boolean) Debug.delegate(ba, "containskey", new Object[] {_key}));}
RDebugUtils.currentLine=4521984;
 //BA.debugLineNum = 4521984;BA.debugLine="Public Sub ContainsKey (Key As Object) As Boolean";
RDebugUtils.currentLine=4521985;
 //BA.debugLineNum = 4521985;BA.debugLine="Return map.ContainsKey(Key)";
if (true) return __ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .ContainsKey(_key);
RDebugUtils.currentLine=4521986;
 //BA.debugLineNum = 4521986;BA.debugLine="End Sub";
return false;
}
public Object  _get(b4a.example.b4xorderedmap __ref,Object _key) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "get", true))
	 {return ((Object) Debug.delegate(ba, "get", new Object[] {_key}));}
RDebugUtils.currentLine=4390912;
 //BA.debugLineNum = 4390912;BA.debugLine="Public Sub Get (Key As Object) As Object";
RDebugUtils.currentLine=4390913;
 //BA.debugLineNum = 4390913;BA.debugLine="Return map.Get(Key)";
if (true) return __ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Get(_key);
RDebugUtils.currentLine=4390914;
 //BA.debugLineNum = 4390914;BA.debugLine="End Sub";
return null;
}
public Object  _getdataforserializator(b4a.example.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getdataforserializator", true))
	 {return ((Object) Debug.delegate(ba, "getdataforserializator", null));}
RDebugUtils.currentLine=4718592;
 //BA.debugLineNum = 4718592;BA.debugLine="Public Sub GetDataForSerializator As Object";
RDebugUtils.currentLine=4718593;
 //BA.debugLineNum = 4718593;BA.debugLine="Return Array(map, list)";
if (true) return (Object)(new Object[]{(Object)(__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .getObject()),(Object)(__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .getObject())});
RDebugUtils.currentLine=4718594;
 //BA.debugLineNum = 4718594;BA.debugLine="End Sub";
return null;
}
public Object  _getdefault(b4a.example.b4xorderedmap __ref,Object _key,Object _defaultvalue) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getdefault", true))
	 {return ((Object) Debug.delegate(ba, "getdefault", new Object[] {_key,_defaultvalue}));}
RDebugUtils.currentLine=4456448;
 //BA.debugLineNum = 4456448;BA.debugLine="Public Sub GetDefault (Key As Object, DefaultValue";
RDebugUtils.currentLine=4456449;
 //BA.debugLineNum = 4456449;BA.debugLine="Return map.GetDefault(Key, DefaultValue)";
if (true) return __ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .GetDefault(_key,_defaultvalue);
RDebugUtils.currentLine=4456450;
 //BA.debugLineNum = 4456450;BA.debugLine="End Sub";
return null;
}
public anywheresoftware.b4a.objects.collections.List  _getkeys(b4a.example.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getkeys", true))
	 {return ((anywheresoftware.b4a.objects.collections.List) Debug.delegate(ba, "getkeys", null));}
RDebugUtils.currentLine=4325376;
 //BA.debugLineNum = 4325376;BA.debugLine="Public Sub getKeys As List";
RDebugUtils.currentLine=4325377;
 //BA.debugLineNum = 4325377;BA.debugLine="Return list";
if (true) return __ref._list /*anywheresoftware.b4a.objects.collections.List*/ ;
RDebugUtils.currentLine=4325378;
 //BA.debugLineNum = 4325378;BA.debugLine="End Sub";
return null;
}
public int  _getsize(b4a.example.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getsize", true))
	 {return ((Integer) Debug.delegate(ba, "getsize", null));}
RDebugUtils.currentLine=4587520;
 //BA.debugLineNum = 4587520;BA.debugLine="Public Sub getSize As Int";
RDebugUtils.currentLine=4587521;
 //BA.debugLineNum = 4587521;BA.debugLine="Return map.Size";
if (true) return __ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .getSize();
RDebugUtils.currentLine=4587522;
 //BA.debugLineNum = 4587522;BA.debugLine="End Sub";
return 0;
}
public anywheresoftware.b4a.objects.collections.List  _getvalues(b4a.example.b4xorderedmap __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "getvalues", true))
	 {return ((anywheresoftware.b4a.objects.collections.List) Debug.delegate(ba, "getvalues", null));}
anywheresoftware.b4a.objects.collections.List _res = null;
Object _key = null;
RDebugUtils.currentLine=4653056;
 //BA.debugLineNum = 4653056;BA.debugLine="Public Sub getValues As List";
RDebugUtils.currentLine=4653057;
 //BA.debugLineNum = 4653057;BA.debugLine="Dim res As List";
_res = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=4653058;
 //BA.debugLineNum = 4653058;BA.debugLine="res.Initialize";
_res.Initialize();
RDebugUtils.currentLine=4653059;
 //BA.debugLineNum = 4653059;BA.debugLine="For Each key As Object In list";
{
final anywheresoftware.b4a.BA.IterableList group3 = __ref._list /*anywheresoftware.b4a.objects.collections.List*/ ;
final int groupLen3 = group3.getSize()
;int index3 = 0;
;
for (; index3 < groupLen3;index3++){
_key = group3.Get(index3);
RDebugUtils.currentLine=4653060;
 //BA.debugLineNum = 4653060;BA.debugLine="res.Add(map.Get(key))";
_res.Add(__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Get(_key));
 }
};
RDebugUtils.currentLine=4653062;
 //BA.debugLineNum = 4653062;BA.debugLine="Return res";
if (true) return _res;
RDebugUtils.currentLine=4653063;
 //BA.debugLineNum = 4653063;BA.debugLine="End Sub";
return null;
}
public String  _remove(b4a.example.b4xorderedmap __ref,Object _key) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "remove", true))
	 {return ((String) Debug.delegate(ba, "remove", new Object[] {_key}));}
RDebugUtils.currentLine=4194304;
 //BA.debugLineNum = 4194304;BA.debugLine="Public Sub Remove (Key As Object)";
RDebugUtils.currentLine=4194305;
 //BA.debugLineNum = 4194305;BA.debugLine="If map.ContainsKey(Key) = False Then Return";
if (__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .ContainsKey(_key)==__c.False) { 
if (true) return "";};
RDebugUtils.currentLine=4194306;
 //BA.debugLineNum = 4194306;BA.debugLine="list.RemoveAt(list.IndexOf(Key))";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .RemoveAt(__ref._list /*anywheresoftware.b4a.objects.collections.List*/ .IndexOf(_key));
RDebugUtils.currentLine=4194307;
 //BA.debugLineNum = 4194307;BA.debugLine="map.Remove(Key)";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/ .Remove(_key);
RDebugUtils.currentLine=4194308;
 //BA.debugLineNum = 4194308;BA.debugLine="End Sub";
return "";
}
public String  _setdatafromserializator(b4a.example.b4xorderedmap __ref,Object _data) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xorderedmap";
if (Debug.shouldDelegate(ba, "setdatafromserializator", true))
	 {return ((String) Debug.delegate(ba, "setdatafromserializator", new Object[] {_data}));}
Object[] _o = null;
RDebugUtils.currentLine=4784128;
 //BA.debugLineNum = 4784128;BA.debugLine="Public Sub SetDataFromSerializator (Data As Object";
RDebugUtils.currentLine=4784129;
 //BA.debugLineNum = 4784129;BA.debugLine="Dim o() As Object = Data";
_o = (Object[])(_data);
RDebugUtils.currentLine=4784130;
 //BA.debugLineNum = 4784130;BA.debugLine="map = o(0)";
__ref._map /*anywheresoftware.b4a.objects.collections.Map*/  = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (anywheresoftware.b4a.objects.collections.Map.MyMap)(_o[(int) (0)]));
RDebugUtils.currentLine=4784131;
 //BA.debugLineNum = 4784131;BA.debugLine="list = o(1)";
__ref._list /*anywheresoftware.b4a.objects.collections.List*/  = (anywheresoftware.b4a.objects.collections.List) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.List(), (java.util.List)(_o[(int) (1)]));
RDebugUtils.currentLine=4784132;
 //BA.debugLineNum = 4784132;BA.debugLine="End Sub";
return "";
}
}