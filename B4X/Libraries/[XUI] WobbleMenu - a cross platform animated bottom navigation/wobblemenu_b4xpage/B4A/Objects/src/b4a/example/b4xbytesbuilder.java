package b4a.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.debug.*;

public class b4xbytesbuilder extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    private static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new anywheresoftware.b4a.ShellBA(_ba, this, htSubs, "b4a.example.b4xbytesbuilder");
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            
        }
        if (BA.isShellModeRuntimeCheck(ba)) 
			   this.getClass().getMethod("_class_globals", b4a.example.b4xbytesbuilder.class).invoke(this, new Object[] {null});
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
public byte[] _mbuffer = null;
public int _mlength = 0;
public b4a.example.main _main = null;
public b4a.example.starter _starter = null;
public b4a.example.b4xpages _b4xpages = null;
public b4a.example.b4xcollections _b4xcollections = null;
public b4a.example.b4xbytesbuilder  _append(b4a.example.b4xbytesbuilder __ref,byte[] _data) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xbytesbuilder";
if (Debug.shouldDelegate(ba, "append", true))
	 {return ((b4a.example.b4xbytesbuilder) Debug.delegate(ba, "append", new Object[] {_data}));}
int _oldlength = 0;
RDebugUtils.currentLine=2818048;
 //BA.debugLineNum = 2818048;BA.debugLine="Public Sub Append(Data() As Byte) As B4XBytesBuild";
RDebugUtils.currentLine=2818049;
 //BA.debugLineNum = 2818049;BA.debugLine="Dim OldLength As Int = ChangeLength(mLength + Dat";
_oldlength = __ref._changelength /*int*/ (null,(int) (__ref._mlength /*int*/ +_data.length));
RDebugUtils.currentLine=2818050;
 //BA.debugLineNum = 2818050;BA.debugLine="Bit.ArrayCopy(Data, 0, mBuffer, OldLength, Data.L";
__c.Bit.ArrayCopy((Object)(_data),(int) (0),(Object)(__ref._mbuffer /*byte[]*/ ),_oldlength,_data.length);
RDebugUtils.currentLine=2818051;
 //BA.debugLineNum = 2818051;BA.debugLine="Return Me";
if (true) return (b4a.example.b4xbytesbuilder)(this);
RDebugUtils.currentLine=2818052;
 //BA.debugLineNum = 2818052;BA.debugLine="End Sub";
return null;
}
public int  _changelength(b4a.example.b4xbytesbuilder __ref,int _newlength) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xbytesbuilder";
if (Debug.shouldDelegate(ba, "changelength", true))
	 {return ((Integer) Debug.delegate(ba, "changelength", new Object[] {_newlength}));}
int _oldlength = 0;
byte[] _b = null;
RDebugUtils.currentLine=2752512;
 //BA.debugLineNum = 2752512;BA.debugLine="Private Sub ChangeLength (NewLength As Int) As Int";
RDebugUtils.currentLine=2752513;
 //BA.debugLineNum = 2752513;BA.debugLine="Dim OldLength As Int = mLength";
_oldlength = __ref._mlength /*int*/ ;
RDebugUtils.currentLine=2752514;
 //BA.debugLineNum = 2752514;BA.debugLine="mLength = NewLength";
__ref._mlength /*int*/  = _newlength;
RDebugUtils.currentLine=2752515;
 //BA.debugLineNum = 2752515;BA.debugLine="If mBuffer.Length < mLength Then";
if (__ref._mbuffer /*byte[]*/ .length<__ref._mlength /*int*/ ) { 
RDebugUtils.currentLine=2752516;
 //BA.debugLineNum = 2752516;BA.debugLine="Dim b(Max(mBuffer.Length * 2, NewLength)) As Byt";
_b = new byte[(int) (__c.Max(__ref._mbuffer /*byte[]*/ .length*2,_newlength))];
;
RDebugUtils.currentLine=2752517;
 //BA.debugLineNum = 2752517;BA.debugLine="Bit.ArrayCopy(mBuffer, 0, b, 0, mBuffer.Length)";
__c.Bit.ArrayCopy((Object)(__ref._mbuffer /*byte[]*/ ),(int) (0),(Object)(_b),(int) (0),__ref._mbuffer /*byte[]*/ .length);
RDebugUtils.currentLine=2752518;
 //BA.debugLineNum = 2752518;BA.debugLine="mBuffer = b";
__ref._mbuffer /*byte[]*/  = _b;
 };
RDebugUtils.currentLine=2752520;
 //BA.debugLineNum = 2752520;BA.debugLine="Return OldLength";
if (true) return _oldlength;
RDebugUtils.currentLine=2752521;
 //BA.debugLineNum = 2752521;BA.debugLine="End Sub";
return 0;
}
public String  _class_globals(b4a.example.b4xbytesbuilder __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xbytesbuilder";
RDebugUtils.currentLine=2621440;
 //BA.debugLineNum = 2621440;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=2621441;
 //BA.debugLineNum = 2621441;BA.debugLine="Private mBuffer() As Byte";
_mbuffer = new byte[(int) (0)];
;
RDebugUtils.currentLine=2621442;
 //BA.debugLineNum = 2621442;BA.debugLine="Private mLength As Int";
_mlength = 0;
RDebugUtils.currentLine=2621443;
 //BA.debugLineNum = 2621443;BA.debugLine="End Sub";
return "";
}
public String  _clear(b4a.example.b4xbytesbuilder __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xbytesbuilder";
if (Debug.shouldDelegate(ba, "clear", true))
	 {return ((String) Debug.delegate(ba, "clear", null));}
RDebugUtils.currentLine=2883584;
 //BA.debugLineNum = 2883584;BA.debugLine="Public Sub Clear";
RDebugUtils.currentLine=2883585;
 //BA.debugLineNum = 2883585;BA.debugLine="ChangeLength(0)";
__ref._changelength /*int*/ (null,(int) (0));
RDebugUtils.currentLine=2883586;
 //BA.debugLineNum = 2883586;BA.debugLine="End Sub";
return "";
}
public byte[]  _getbuffer(b4a.example.b4xbytesbuilder __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xbytesbuilder";
if (Debug.shouldDelegate(ba, "getbuffer", true))
	 {return ((byte[]) Debug.delegate(ba, "getbuffer", null));}
RDebugUtils.currentLine=3407872;
 //BA.debugLineNum = 3407872;BA.debugLine="Private Sub getBuffer As Byte() 'ignore";
RDebugUtils.currentLine=3407873;
 //BA.debugLineNum = 3407873;BA.debugLine="End Sub";
return null;
}
public int  _getlength(b4a.example.b4xbytesbuilder __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xbytesbuilder";
if (Debug.shouldDelegate(ba, "getlength", true))
	 {return ((Integer) Debug.delegate(ba, "getlength", null));}
RDebugUtils.currentLine=3276800;
 //BA.debugLineNum = 3276800;BA.debugLine="Public Sub getLength As Int";
RDebugUtils.currentLine=3276801;
 //BA.debugLineNum = 3276801;BA.debugLine="Return mLength";
if (true) return __ref._mlength /*int*/ ;
RDebugUtils.currentLine=3276802;
 //BA.debugLineNum = 3276802;BA.debugLine="End Sub";
return 0;
}
public int  _indexof(b4a.example.b4xbytesbuilder __ref,byte[] _searchfor) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xbytesbuilder";
if (Debug.shouldDelegate(ba, "indexof", true))
	 {return ((Integer) Debug.delegate(ba, "indexof", new Object[] {_searchfor}));}
RDebugUtils.currentLine=3473408;
 //BA.debugLineNum = 3473408;BA.debugLine="Public Sub IndexOf(SearchFor() As Byte) As Int";
RDebugUtils.currentLine=3473409;
 //BA.debugLineNum = 3473409;BA.debugLine="Return IndexOf2(SearchFor, 0)";
if (true) return __ref._indexof2 /*int*/ (null,_searchfor,(int) (0));
RDebugUtils.currentLine=3473410;
 //BA.debugLineNum = 3473410;BA.debugLine="End Sub";
return 0;
}
public int  _indexof2(b4a.example.b4xbytesbuilder __ref,byte[] _searchfor,int _index) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xbytesbuilder";
if (Debug.shouldDelegate(ba, "indexof2", true))
	 {return ((Integer) Debug.delegate(ba, "indexof2", new Object[] {_searchfor,_index}));}
int _i1 = 0;
int _i2 = 0;
RDebugUtils.currentLine=3538944;
 //BA.debugLineNum = 3538944;BA.debugLine="Public Sub IndexOf2(SearchFor() As Byte, Index As";
RDebugUtils.currentLine=3538945;
 //BA.debugLineNum = 3538945;BA.debugLine="For i1 = Index To mLength - SearchFor.Length";
{
final int step1 = 1;
final int limit1 = (int) (__ref._mlength /*int*/ -_searchfor.length);
_i1 = _index ;
for (;_i1 <= limit1 ;_i1 = _i1 + step1 ) {
RDebugUtils.currentLine=3538946;
 //BA.debugLineNum = 3538946;BA.debugLine="For i2 = 0 To SearchFor.Length - 1";
{
final int step2 = 1;
final int limit2 = (int) (_searchfor.length-1);
_i2 = (int) (0) ;
for (;_i2 <= limit2 ;_i2 = _i2 + step2 ) {
RDebugUtils.currentLine=3538947;
 //BA.debugLineNum = 3538947;BA.debugLine="If SearchFor(i2) <> mBuffer(i1 + i2) Then";
if (_searchfor[_i2]!=__ref._mbuffer /*byte[]*/ [(int) (_i1+_i2)]) { 
RDebugUtils.currentLine=3538948;
 //BA.debugLineNum = 3538948;BA.debugLine="Exit";
if (true) break;
 };
 }
};
RDebugUtils.currentLine=3538951;
 //BA.debugLineNum = 3538951;BA.debugLine="If i2 = SearchFor.Length Then";
if (_i2==_searchfor.length) { 
RDebugUtils.currentLine=3538952;
 //BA.debugLineNum = 3538952;BA.debugLine="Return i1";
if (true) return _i1;
 };
 }
};
RDebugUtils.currentLine=3538955;
 //BA.debugLineNum = 3538955;BA.debugLine="Return -1";
if (true) return (int) (-1);
RDebugUtils.currentLine=3538956;
 //BA.debugLineNum = 3538956;BA.debugLine="End Sub";
return 0;
}
public String  _initialize(b4a.example.b4xbytesbuilder __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="b4xbytesbuilder";
if (Debug.shouldDelegate(ba, "initialize", true))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=2686976;
 //BA.debugLineNum = 2686976;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=2686977;
 //BA.debugLineNum = 2686977;BA.debugLine="Dim mBuffer(100) As Byte";
_mbuffer = new byte[(int) (100)];
;
RDebugUtils.currentLine=2686978;
 //BA.debugLineNum = 2686978;BA.debugLine="mLength = 0";
__ref._mlength /*int*/  = (int) (0);
RDebugUtils.currentLine=2686979;
 //BA.debugLineNum = 2686979;BA.debugLine="End Sub";
return "";
}
public String  _insert(b4a.example.b4xbytesbuilder __ref,int _index,byte[] _data) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xbytesbuilder";
if (Debug.shouldDelegate(ba, "insert", true))
	 {return ((String) Debug.delegate(ba, "insert", new Object[] {_index,_data}));}
byte[] _afterindex = null;
RDebugUtils.currentLine=2949120;
 //BA.debugLineNum = 2949120;BA.debugLine="Public Sub Insert(Index As Int, Data() As Byte)";
RDebugUtils.currentLine=2949121;
 //BA.debugLineNum = 2949121;BA.debugLine="If Index >= mLength Then";
if (_index>=__ref._mlength /*int*/ ) { 
RDebugUtils.currentLine=2949122;
 //BA.debugLineNum = 2949122;BA.debugLine="If Index > mLength Then Log(\"Index too large\")";
if (_index>__ref._mlength /*int*/ ) { 
__c.LogImpl("92949122","Index too large",0);};
RDebugUtils.currentLine=2949123;
 //BA.debugLineNum = 2949123;BA.debugLine="Append(Data)";
__ref._append /*b4a.example.b4xbytesbuilder*/ (null,_data);
 }else {
RDebugUtils.currentLine=2949125;
 //BA.debugLineNum = 2949125;BA.debugLine="Dim AfterIndex() As Byte = SubArray(Index)";
_afterindex = __ref._subarray /*byte[]*/ (null,_index);
RDebugUtils.currentLine=2949126;
 //BA.debugLineNum = 2949126;BA.debugLine="ChangeLength(mLength + Data.Length)";
__ref._changelength /*int*/ (null,(int) (__ref._mlength /*int*/ +_data.length));
RDebugUtils.currentLine=2949127;
 //BA.debugLineNum = 2949127;BA.debugLine="Bit.ArrayCopy(Data, 0, mBuffer, Index, Data.Leng";
__c.Bit.ArrayCopy((Object)(_data),(int) (0),(Object)(__ref._mbuffer /*byte[]*/ ),_index,_data.length);
RDebugUtils.currentLine=2949128;
 //BA.debugLineNum = 2949128;BA.debugLine="Bit.ArrayCopy(AfterIndex, 0, mBuffer, Index + Da";
__c.Bit.ArrayCopy((Object)(_afterindex),(int) (0),(Object)(__ref._mbuffer /*byte[]*/ ),(int) (_index+_data.length),_afterindex.length);
 };
RDebugUtils.currentLine=2949130;
 //BA.debugLineNum = 2949130;BA.debugLine="End Sub";
return "";
}
public byte[]  _subarray(b4a.example.b4xbytesbuilder __ref,int _beginindex) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xbytesbuilder";
if (Debug.shouldDelegate(ba, "subarray", true))
	 {return ((byte[]) Debug.delegate(ba, "subarray", new Object[] {_beginindex}));}
RDebugUtils.currentLine=3145728;
 //BA.debugLineNum = 3145728;BA.debugLine="Public Sub SubArray(BeginIndex As Int) As Byte()";
RDebugUtils.currentLine=3145729;
 //BA.debugLineNum = 3145729;BA.debugLine="Return SubArray2(BeginIndex, mLength)";
if (true) return __ref._subarray2 /*byte[]*/ (null,_beginindex,__ref._mlength /*int*/ );
RDebugUtils.currentLine=3145730;
 //BA.debugLineNum = 3145730;BA.debugLine="End Sub";
return null;
}
public byte[]  _remove(b4a.example.b4xbytesbuilder __ref,int _beginindex,int _endindex) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xbytesbuilder";
if (Debug.shouldDelegate(ba, "remove", true))
	 {return ((byte[]) Debug.delegate(ba, "remove", new Object[] {_beginindex,_endindex}));}
byte[] _res = null;
byte[] _afterendindex = null;
RDebugUtils.currentLine=3080192;
 //BA.debugLineNum = 3080192;BA.debugLine="Public Sub Remove(BeginIndex As Int, EndIndex As I";
RDebugUtils.currentLine=3080193;
 //BA.debugLineNum = 3080193;BA.debugLine="Dim res() As Byte = SubArray2(BeginIndex, EndInde";
_res = __ref._subarray2 /*byte[]*/ (null,_beginindex,_endindex);
RDebugUtils.currentLine=3080194;
 //BA.debugLineNum = 3080194;BA.debugLine="If EndIndex <= mLength Then";
if (_endindex<=__ref._mlength /*int*/ ) { 
RDebugUtils.currentLine=3080195;
 //BA.debugLineNum = 3080195;BA.debugLine="Dim AfterEndIndex() As Byte = SubArray(EndIndex)";
_afterendindex = __ref._subarray /*byte[]*/ (null,_endindex);
RDebugUtils.currentLine=3080196;
 //BA.debugLineNum = 3080196;BA.debugLine="Bit.ArrayCopy(AfterEndIndex, 0, mBuffer, BeginIn";
__c.Bit.ArrayCopy((Object)(_afterendindex),(int) (0),(Object)(__ref._mbuffer /*byte[]*/ ),_beginindex,_afterendindex.length);
 };
RDebugUtils.currentLine=3080198;
 //BA.debugLineNum = 3080198;BA.debugLine="ChangeLength(mLength - (EndIndex - BeginIndex))";
__ref._changelength /*int*/ (null,(int) (__ref._mlength /*int*/ -(_endindex-_beginindex)));
RDebugUtils.currentLine=3080199;
 //BA.debugLineNum = 3080199;BA.debugLine="Return res";
if (true) return _res;
RDebugUtils.currentLine=3080200;
 //BA.debugLineNum = 3080200;BA.debugLine="End Sub";
return null;
}
public byte[]  _subarray2(b4a.example.b4xbytesbuilder __ref,int _beginindex,int _endindex) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xbytesbuilder";
if (Debug.shouldDelegate(ba, "subarray2", true))
	 {return ((byte[]) Debug.delegate(ba, "subarray2", new Object[] {_beginindex,_endindex}));}
byte[] _b = null;
RDebugUtils.currentLine=3211264;
 //BA.debugLineNum = 3211264;BA.debugLine="Public Sub SubArray2(BeginIndex As Int, EndIndex A";
RDebugUtils.currentLine=3211265;
 //BA.debugLineNum = 3211265;BA.debugLine="Dim b(EndIndex - BeginIndex) As Byte";
_b = new byte[(int) (_endindex-_beginindex)];
;
RDebugUtils.currentLine=3211266;
 //BA.debugLineNum = 3211266;BA.debugLine="Bit.ArrayCopy(mBuffer, BeginIndex, b, 0, b.Length";
__c.Bit.ArrayCopy((Object)(__ref._mbuffer /*byte[]*/ ),_beginindex,(Object)(_b),(int) (0),_b.length);
RDebugUtils.currentLine=3211267;
 //BA.debugLineNum = 3211267;BA.debugLine="Return b";
if (true) return _b;
RDebugUtils.currentLine=3211268;
 //BA.debugLineNum = 3211268;BA.debugLine="End Sub";
return null;
}
public String  _set(b4a.example.b4xbytesbuilder __ref,int _index,byte[] _data) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xbytesbuilder";
if (Debug.shouldDelegate(ba, "set", true))
	 {return ((String) Debug.delegate(ba, "set", new Object[] {_index,_data}));}
RDebugUtils.currentLine=3014656;
 //BA.debugLineNum = 3014656;BA.debugLine="Public Sub Set(Index As Int, Data() As Byte)";
RDebugUtils.currentLine=3014657;
 //BA.debugLineNum = 3014657;BA.debugLine="If Index >= mLength Then";
if (_index>=__ref._mlength /*int*/ ) { 
RDebugUtils.currentLine=3014658;
 //BA.debugLineNum = 3014658;BA.debugLine="If Index > mLength Then Log(\"Index too large\")";
if (_index>__ref._mlength /*int*/ ) { 
__c.LogImpl("93014658","Index too large",0);};
RDebugUtils.currentLine=3014659;
 //BA.debugLineNum = 3014659;BA.debugLine="Append(Data)";
__ref._append /*b4a.example.b4xbytesbuilder*/ (null,_data);
 }else {
RDebugUtils.currentLine=3014661;
 //BA.debugLineNum = 3014661;BA.debugLine="If Data.Length + Index > mLength Then";
if (_data.length+_index>__ref._mlength /*int*/ ) { 
RDebugUtils.currentLine=3014662;
 //BA.debugLineNum = 3014662;BA.debugLine="ChangeLength(Data.Length + Index)";
__ref._changelength /*int*/ (null,(int) (_data.length+_index));
 };
RDebugUtils.currentLine=3014664;
 //BA.debugLineNum = 3014664;BA.debugLine="Bit.ArrayCopy(Data, 0, mBuffer, Index, Data.Leng";
__c.Bit.ArrayCopy((Object)(_data),(int) (0),(Object)(__ref._mbuffer /*byte[]*/ ),_index,_data.length);
 };
RDebugUtils.currentLine=3014666;
 //BA.debugLineNum = 3014666;BA.debugLine="End Sub";
return "";
}
public byte[]  _toarray(b4a.example.b4xbytesbuilder __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xbytesbuilder";
if (Debug.shouldDelegate(ba, "toarray", true))
	 {return ((byte[]) Debug.delegate(ba, "toarray", null));}
RDebugUtils.currentLine=3342336;
 //BA.debugLineNum = 3342336;BA.debugLine="Public Sub ToArray() As Byte()";
RDebugUtils.currentLine=3342337;
 //BA.debugLineNum = 3342337;BA.debugLine="Return SubArray(0)";
if (true) return __ref._subarray /*byte[]*/ (null,(int) (0));
RDebugUtils.currentLine=3342338;
 //BA.debugLineNum = 3342338;BA.debugLine="End Sub";
return null;
}
}