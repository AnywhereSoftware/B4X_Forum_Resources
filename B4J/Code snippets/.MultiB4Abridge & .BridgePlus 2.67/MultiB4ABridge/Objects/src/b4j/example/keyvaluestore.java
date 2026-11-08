package b4j.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class keyvaluestore extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4j.objects.FxBA("b4j.example", "b4j.example.keyvaluestore", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.keyvaluestore.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 public anywheresoftware.b4a.keywords.Common __c = null;
public anywheresoftware.b4j.objects.SQL _vvvvvv4 = null;
public anywheresoftware.b4a.randomaccessfile.B4XSerializator _vvvvvv5 = null;
public com.stevel05.draganddrop.transfermode _vv6 = null;
public b4j.example.main _main = null;
public String  _class_globals() throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 3;BA.debugLine="Private sql1 As SQL";
_vvvvvv4 = new anywheresoftware.b4j.objects.SQL();
 //BA.debugLineNum = 4;BA.debugLine="Private ser As B4XSerializator";
_vvvvvv5 = new anywheresoftware.b4a.randomaccessfile.B4XSerializator();
 //BA.debugLineNum = 5;BA.debugLine="End Sub";
return "";
}
public String  _vvv5() throws Exception{
 //BA.debugLineNum = 161;BA.debugLine="Public Sub Close";
 //BA.debugLineNum = 162;BA.debugLine="sql1.Close";
_vvvvvv4.Close();
 //BA.debugLineNum = 163;BA.debugLine="End Sub";
return "";
}
public boolean  _vvvv0(String _key) throws Exception{
 //BA.debugLineNum = 149;BA.debugLine="Public Sub ContainsKey(Key As String) As Boolean";
 //BA.debugLineNum = 150;BA.debugLine="Return sql1.ExecQuerySingleResult2(\"SELECT count(";
if (true) return (double)(Double.parseDouble(_vvvvvv4.ExecQuerySingleResult2("SELECT count(key) FROM main WHERE key = ?",anywheresoftware.b4a.keywords.Common.ArrayToList(new String[]{_key}))))>0;
 //BA.debugLineNum = 152;BA.debugLine="End Sub";
return false;
}
public String  _vvvvv1() throws Exception{
 //BA.debugLineNum = 166;BA.debugLine="Private Sub CreateTable";
 //BA.debugLineNum = 167;BA.debugLine="sql1.ExecNonQuery(\"CREATE TABLE IF NOT EXISTS mai";
_vvvvvv4.ExecNonQuery("CREATE TABLE IF NOT EXISTS main(key TEXT PRIMARY KEY, value NONE)");
 //BA.debugLineNum = 168;BA.debugLine="End Sub";
return "";
}
public String  _vvvvv2() throws Exception{
 //BA.debugLineNum = 155;BA.debugLine="Public Sub DeleteAll";
 //BA.debugLineNum = 156;BA.debugLine="sql1.ExecNonQuery(\"DROP TABLE main\")";
_vvvvvv4.ExecNonQuery("DROP TABLE main");
 //BA.debugLineNum = 157;BA.debugLine="CreateTable";
_vvvvv1();
 //BA.debugLineNum = 158;BA.debugLine="End Sub";
return "";
}
public Object  _vvvvv3(String _key) throws Exception{
anywheresoftware.b4j.objects.SQL.ResultSetWrapper _rs = null;
Object _result = null;
 //BA.debugLineNum = 22;BA.debugLine="Public Sub Get(Key As String) As Object";
 //BA.debugLineNum = 23;BA.debugLine="Dim rs As ResultSet = sql1.ExecQuery2(\"SELECT val";
_rs = new anywheresoftware.b4j.objects.SQL.ResultSetWrapper();
_rs = _vvvvvv4.ExecQuery2("SELECT value FROM main WHERE key = ?",anywheresoftware.b4a.keywords.Common.ArrayToList(new String[]{_key}));
 //BA.debugLineNum = 24;BA.debugLine="Dim result As Object = Null";
_result = __c.Null;
 //BA.debugLineNum = 25;BA.debugLine="If rs.NextRow Then";
if (_rs.NextRow()) { 
 //BA.debugLineNum = 26;BA.debugLine="result = ser.ConvertBytesToObject(rs.GetBlob2(0)";
_result = _vvvvvv5.ConvertBytesToObject(_rs.GetBlob2((int) (0)));
 };
 //BA.debugLineNum = 28;BA.debugLine="rs.Close";
_rs.Close();
 //BA.debugLineNum = 29;BA.debugLine="Return result";
if (true) return _result;
 //BA.debugLineNum = 30;BA.debugLine="End Sub";
return null;
}
public Object  _vvvvv4(String _key,Object _defaultvalue) throws Exception{
Object _res = null;
 //BA.debugLineNum = 84;BA.debugLine="Public Sub GetDefault(Key As String, DefaultValue";
 //BA.debugLineNum = 85;BA.debugLine="Dim res As Object = Get(Key)";
_res = _vvvvv3(_key);
 //BA.debugLineNum = 86;BA.debugLine="If res = Null Then Return DefaultValue";
if (_res== null) { 
if (true) return _defaultvalue;};
 //BA.debugLineNum = 87;BA.debugLine="Return res";
if (true) return _res;
 //BA.debugLineNum = 88;BA.debugLine="End Sub";
return null;
}
public Object  _vvvvv5(String _key,String _password) throws Exception{
anywheresoftware.b4a.object.B4XEncryption _cipher = null;
byte[] _b = null;
 //BA.debugLineNum = 99;BA.debugLine="Public Sub GetEncrypted (Key As String, Password A";
 //BA.debugLineNum = 103;BA.debugLine="Dim cipher As B4XCipher";
_cipher = new anywheresoftware.b4a.object.B4XEncryption();
 //BA.debugLineNum = 105;BA.debugLine="Dim b() As Byte = Get(Key)";
_b = (byte[])(_vvvvv3(_key));
 //BA.debugLineNum = 106;BA.debugLine="If b = Null Then Return Null";
if (_b== null) { 
if (true) return __c.Null;};
 //BA.debugLineNum = 107;BA.debugLine="Return ser.ConvertBytesToObject(cipher.Decrypt(b,";
if (true) return _vvvvvv5.ConvertBytesToObject(_cipher.Decrypt(_b,_password));
 //BA.debugLineNum = 108;BA.debugLine="End Sub";
return null;
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _vvvvv6(anywheresoftware.b4a.objects.collections.List _keys) throws Exception{
ResumableSub_GetMapAsync rsub = new ResumableSub_GetMapAsync(this,_keys);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_GetMapAsync extends BA.ResumableSub {
public ResumableSub_GetMapAsync(b4j.example.keyvaluestore parent,anywheresoftware.b4a.objects.collections.List _keys) {
this.parent = parent;
this._keys = _keys;
}
b4j.example.keyvaluestore parent;
anywheresoftware.b4a.objects.collections.List _keys;
anywheresoftware.b4a.keywords.StringBuilderWrapper _sb = null;
int _i = 0;
Object _senderfilter = null;
boolean _success = false;
anywheresoftware.b4j.objects.SQL.ResultSetWrapper _rs = null;
anywheresoftware.b4a.objects.collections.Map _m = null;
anywheresoftware.b4a.randomaccessfile.B4XSerializator _myser = null;
Object _newobject = null;
int step4;
int limit4;

@Override
public void resume(BA ba, Object[] result) throws Exception{

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.ReturnFromResumableSub(this,null);return;}
case 0:
//C
this.state = 1;
 //BA.debugLineNum = 38;BA.debugLine="Dim sb As StringBuilder";
_sb = new anywheresoftware.b4a.keywords.StringBuilderWrapper();
 //BA.debugLineNum = 39;BA.debugLine="sb.Initialize";
_sb.Initialize();
 //BA.debugLineNum = 40;BA.debugLine="sb.Append(\"SELECT key, value FROM main WHERE \")";
_sb.Append("SELECT key, value FROM main WHERE ");
 //BA.debugLineNum = 41;BA.debugLine="For i = 0 To Keys.Size - 1";
if (true) break;

case 1:
//for
this.state = 10;
step4 = 1;
limit4 = (int) (_keys.getSize()-1);
_i = (int) (0) ;
this.state = 25;
if (true) break;

case 25:
//C
this.state = 10;
if ((step4 > 0 && _i <= limit4) || (step4 < 0 && _i >= limit4)) this.state = 3;
if (true) break;

case 26:
//C
this.state = 25;
_i = ((int)(0 + _i + step4)) ;
if (true) break;

case 3:
//C
this.state = 4;
 //BA.debugLineNum = 42;BA.debugLine="If i > 0 Then sb.Append(\" OR \")";
if (true) break;

case 4:
//if
this.state = 9;
if (_i>0) { 
this.state = 6;
;}if (true) break;

case 6:
//C
this.state = 9;
_sb.Append(" OR ");
if (true) break;

case 9:
//C
this.state = 26;
;
 //BA.debugLineNum = 43;BA.debugLine="sb.Append(\" key = ? \")";
_sb.Append(" key = ? ");
 if (true) break;
if (true) break;

case 10:
//C
this.state = 11;
;
 //BA.debugLineNum = 45;BA.debugLine="Dim SenderFilter As Object = sql1.ExecQueryAsync(";
_senderfilter = parent._vvvvvv4.ExecQueryAsync(ba,"SQL",_sb.ToString(),_keys);
 //BA.debugLineNum = 46;BA.debugLine="Wait For (SenderFilter) SQL_QueryComplete (Succes";
parent.__c.WaitFor("sql_querycomplete", ba, this, _senderfilter);
this.state = 27;
return;
case 27:
//C
this.state = 11;
_success = (boolean) result[0];
_rs = (anywheresoftware.b4j.objects.SQL.ResultSetWrapper) result[1];
;
 //BA.debugLineNum = 47;BA.debugLine="Dim m As Map";
_m = new anywheresoftware.b4a.objects.collections.Map();
 //BA.debugLineNum = 48;BA.debugLine="m.Initialize";
_m.Initialize();
 //BA.debugLineNum = 49;BA.debugLine="If Success Then";
if (true) break;

case 11:
//if
this.state = 24;
if (_success) { 
this.state = 13;
}else {
this.state = 23;
}if (true) break;

case 13:
//C
this.state = 14;
 //BA.debugLineNum = 50;BA.debugLine="Do While rs.NextRow";
if (true) break;

case 14:
//do while
this.state = 21;
while (_rs.NextRow()) {
this.state = 16;
if (true) break;
}
if (true) break;

case 16:
//C
this.state = 17;
 //BA.debugLineNum = 51;BA.debugLine="Dim myser As B4XSerializator";
_myser = new anywheresoftware.b4a.randomaccessfile.B4XSerializator();
 //BA.debugLineNum = 52;BA.debugLine="myser.ConvertBytesToObjectAsync(rs.GetBlob2(1),";
_myser.ConvertBytesToObjectAsync(ba,_rs.GetBlob2((int) (1)),"myser");
 //BA.debugLineNum = 53;BA.debugLine="Wait For (myser) myser_BytesToObject (Success A";
parent.__c.WaitFor("myser_bytestoobject", ba, this, (Object)(_myser));
this.state = 28;
return;
case 28:
//C
this.state = 17;
_success = (boolean) result[0];
_newobject = (Object) result[1];
;
 //BA.debugLineNum = 54;BA.debugLine="If Success Then";
if (true) break;

case 17:
//if
this.state = 20;
if (_success) { 
this.state = 19;
}if (true) break;

case 19:
//C
this.state = 20;
 //BA.debugLineNum = 55;BA.debugLine="m.Put(rs.GetString2(0), NewObject)";
_m.Put((Object)(_rs.GetString2((int) (0))),_newobject);
 if (true) break;

case 20:
//C
this.state = 14;
;
 if (true) break;

case 21:
//C
this.state = 24;
;
 //BA.debugLineNum = 58;BA.debugLine="rs.Close";
_rs.Close();
 if (true) break;

case 23:
//C
this.state = 24;
 if (true) break;

case 24:
//C
this.state = -1;
;
 //BA.debugLineNum = 62;BA.debugLine="Return m";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(_m));return;};
 //BA.debugLineNum = 63;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public void  _sql_querycomplete(boolean _success,anywheresoftware.b4j.objects.SQL.ResultSetWrapper _rs) throws Exception{
}
public void  _myser_bytestoobject(boolean _success,Object _newobject) throws Exception{
}
public String  _initialize(anywheresoftware.b4a.BA _ba,String _dir,String _filename) throws Exception{
innerInitialize(_ba);
 //BA.debugLineNum = 8;BA.debugLine="Public Sub Initialize (Dir As String, FileName As";
 //BA.debugLineNum = 9;BA.debugLine="If sql1.IsInitialized Then sql1.Close";
if (_vvvvvv4.IsInitialized()) { 
_vvvvvv4.Close();};
 //BA.debugLineNum = 11;BA.debugLine="sql1.InitializeSQLite(Dir, FileName, True)";
_vvvvvv4.InitializeSQLite(_dir,_filename,__c.True);
 //BA.debugLineNum = 15;BA.debugLine="CreateTable";
_vvvvv1();
 //BA.debugLineNum = 16;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4a.objects.collections.List  _vvvvv7() throws Exception{
anywheresoftware.b4j.objects.SQL.ResultSetWrapper _c = null;
anywheresoftware.b4a.objects.collections.List _res = null;
 //BA.debugLineNum = 137;BA.debugLine="Public Sub ListKeys As List";
 //BA.debugLineNum = 138;BA.debugLine="Dim c As ResultSet = sql1.ExecQuery(\"SELECT key F";
_c = new anywheresoftware.b4j.objects.SQL.ResultSetWrapper();
_c = _vvvvvv4.ExecQuery("SELECT key FROM main");
 //BA.debugLineNum = 139;BA.debugLine="Dim res As List";
_res = new anywheresoftware.b4a.objects.collections.List();
 //BA.debugLineNum = 140;BA.debugLine="res.Initialize";
_res.Initialize();
 //BA.debugLineNum = 141;BA.debugLine="Do While c.NextRow";
while (_c.NextRow()) {
 //BA.debugLineNum = 142;BA.debugLine="res.Add(c.GetString2(0))";
_res.Add((Object)(_c.GetString2((int) (0))));
 }
;
 //BA.debugLineNum = 144;BA.debugLine="c.Close";
_c.Close();
 //BA.debugLineNum = 145;BA.debugLine="Return res";
if (true) return _res;
 //BA.debugLineNum = 146;BA.debugLine="End Sub";
return null;
}
public String  _vvvvv0(String _key,Object _value) throws Exception{
 //BA.debugLineNum = 18;BA.debugLine="Public Sub Put(Key As String, Value As Object)";
 //BA.debugLineNum = 19;BA.debugLine="sql1.ExecNonQuery2(\"INSERT OR REPLACE INTO main V";
_vvvvvv4.ExecNonQuery2("INSERT OR REPLACE INTO main VALUES(?, ?)",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(_key),(Object)(_vvvvvv5.ConvertObjectToBytes(_value))}));
 //BA.debugLineNum = 20;BA.debugLine="End Sub";
return "";
}
public String  _vvvvvv1(String _key,Object _value,String _password) throws Exception{
anywheresoftware.b4a.object.B4XEncryption _cipher = null;
 //BA.debugLineNum = 90;BA.debugLine="Public Sub PutEncrypted (Key As String, Value As O";
 //BA.debugLineNum = 94;BA.debugLine="Dim cipher As B4XCipher";
_cipher = new anywheresoftware.b4a.object.B4XEncryption();
 //BA.debugLineNum = 96;BA.debugLine="Put(Key, cipher.Encrypt(ser.ConvertObjectToBytes(";
_vvvvv0(_key,(Object)(_cipher.Encrypt(_vvvvvv5.ConvertObjectToBytes(_value),_password)));
 //BA.debugLineNum = 97;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _vvvvvv2(anywheresoftware.b4a.objects.collections.Map _map) throws Exception{
ResumableSub_PutMapAsync rsub = new ResumableSub_PutMapAsync(this,_map);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_PutMapAsync extends BA.ResumableSub {
public ResumableSub_PutMapAsync(b4j.example.keyvaluestore parent,anywheresoftware.b4a.objects.collections.Map _map) {
this.parent = parent;
this._map = _map;
}
b4j.example.keyvaluestore parent;
anywheresoftware.b4a.objects.collections.Map _map;
String _key = "";
anywheresoftware.b4a.randomaccessfile.B4XSerializator _myser = null;
boolean _success = false;
byte[] _bytes = null;
Object _senderfilter = null;
anywheresoftware.b4a.BA.IterableList group1;
int index1;
int groupLen1;

@Override
public void resume(BA ba, Object[] result) throws Exception{

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.ReturnFromResumableSub(this,null);return;}
case 0:
//C
this.state = 1;
 //BA.debugLineNum = 69;BA.debugLine="For Each key As String In Map.Keys";
if (true) break;

case 1:
//for
this.state = 10;
group1 = _map.Keys();
index1 = 0;
groupLen1 = group1.getSize();
this.state = 11;
if (true) break;

case 11:
//C
this.state = 10;
if (index1 < groupLen1) {
this.state = 3;
_key = BA.ObjectToString(group1.Get(index1));}
if (true) break;

case 12:
//C
this.state = 11;
index1++;
if (true) break;

case 3:
//C
this.state = 4;
 //BA.debugLineNum = 70;BA.debugLine="Dim myser As B4XSerializator";
_myser = new anywheresoftware.b4a.randomaccessfile.B4XSerializator();
 //BA.debugLineNum = 71;BA.debugLine="myser.ConvertObjectToBytesAsync(Map.Get(key), \"m";
_myser.ConvertObjectToBytesAsync(ba,_map.Get((Object)(_key)),"myser");
 //BA.debugLineNum = 72;BA.debugLine="Wait For (myser) myser_ObjectToBytes (Success As";
parent.__c.WaitFor("myser_objecttobytes", ba, this, (Object)(_myser));
this.state = 13;
return;
case 13:
//C
this.state = 4;
_success = (boolean) result[0];
_bytes = (byte[]) result[1];
;
 //BA.debugLineNum = 73;BA.debugLine="If Success Then";
if (true) break;

case 4:
//if
this.state = 9;
if (_success) { 
this.state = 6;
}else {
this.state = 8;
}if (true) break;

case 6:
//C
this.state = 9;
 //BA.debugLineNum = 74;BA.debugLine="sql1.AddNonQueryToBatch(\"INSERT OR REPLACE INTO";
parent._vvvvvv4.AddNonQueryToBatch("INSERT OR REPLACE INTO main VALUES(?, ?)",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(_key),(Object)(_bytes)}));
 if (true) break;

case 8:
//C
this.state = 9;
 if (true) break;

case 9:
//C
this.state = 12;
;
 if (true) break;
if (true) break;

case 10:
//C
this.state = -1;
;
 //BA.debugLineNum = 79;BA.debugLine="Dim SenderFilter As Object = sql1.ExecNonQueryBat";
_senderfilter = parent._vvvvvv4.ExecNonQueryBatch(ba,"SQL");
 //BA.debugLineNum = 80;BA.debugLine="Wait For (SenderFilter) SQL_NonQueryComplete (Suc";
parent.__c.WaitFor("sql_nonquerycomplete", ba, this, _senderfilter);
this.state = 14;
return;
case 14:
//C
this.state = -1;
_success = (boolean) result[0];
;
 //BA.debugLineNum = 81;BA.debugLine="Return Success";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(_success));return;};
 //BA.debugLineNum = 82;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public void  _myser_objecttobytes(boolean _success,byte[] _bytes) throws Exception{
}
public void  _sql_nonquerycomplete(boolean _success) throws Exception{
}
public String  _vvvvvv3(String _key) throws Exception{
 //BA.debugLineNum = 132;BA.debugLine="Public Sub Remove(Key As String)";
 //BA.debugLineNum = 133;BA.debugLine="sql1.ExecNonQuery2(\"DELETE FROM main WHERE key =";
_vvvvvv4.ExecNonQuery2("DELETE FROM main WHERE key = ?",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(_key)}));
 //BA.debugLineNum = 134;BA.debugLine="End Sub";
return "";
}
public Object callSub(String sub, Object sender, Object[] args) throws Exception {
BA.senderHolder.set(sender);
return BA.SubDelegator.SubNotFound;
}
}
