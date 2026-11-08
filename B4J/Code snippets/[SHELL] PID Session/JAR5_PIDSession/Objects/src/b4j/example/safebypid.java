package b4j.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class safebypid extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4j.objects.FxBA("b4j.example", "b4j.example.safebypid", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.safebypid.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 public anywheresoftware.b4a.keywords.Common __c = null;
public b4j.example.main _vvv4 = null;
public String  _class_globals() throws Exception{
 //BA.debugLineNum = 4;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 6;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _vvv5(String _fpath,String _fname) throws Exception{
ResumableSub_Delete rsub = new ResumableSub_Delete(this,_fpath,_fname);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_Delete extends BA.ResumableSub {
public ResumableSub_Delete(b4j.example.safebypid parent,String _fpath,String _fname) {
this.parent = parent;
this._fpath = _fpath;
this._fname = _fname;
}
b4j.example.safebypid parent;
String _fpath;
String _fname;
anywheresoftware.b4a.randomaccessfile.RandomAccessFile _raf = null;
anywheresoftware.b4a.agraham.encryption.CipherWrapper.SecureRandomWrapper _sr = null;
byte[] _aeskey = null;
long _total = 0L;

@Override
public void resume(BA ba, Object[] result) throws Exception{

    while (true) {
try {

        switch (state) {
            case -1:
{
parent.__c.ReturnFromResumableSub(this,null);return;}
case 0:
//C
this.state = 1;
 //BA.debugLineNum = 20;BA.debugLine="Try";
if (true) break;

case 1:
//try
this.state = 14;
this.catchState = 13;
this.state = 3;
if (true) break;

case 3:
//C
this.state = 4;
this.catchState = 13;
 //BA.debugLineNum = 21;BA.debugLine="If File.Exists(fPath, fName) Then";
if (true) break;

case 4:
//if
this.state = 11;
if (parent.__c.File.Exists(_fpath,_fname)) { 
this.state = 6;
}if (true) break;

case 6:
//C
this.state = 7;
 //BA.debugLineNum = 22;BA.debugLine="Private raf As RandomAccessFile";
_raf = new anywheresoftware.b4a.randomaccessfile.RandomAccessFile();
 //BA.debugLineNum = 23;BA.debugLine="Dim sr As SecureRandom";
_sr = new anywheresoftware.b4a.agraham.encryption.CipherWrapper.SecureRandomWrapper();
 //BA.debugLineNum = 25;BA.debugLine="raf.Initialize(fPath,fName, False)";
_raf.Initialize(_fpath,_fname,parent.__c.False);
 //BA.debugLineNum = 27;BA.debugLine="Dim aesKey(64) As Byte '64 bytes = 4x128 bits";
_aeskey = new byte[(int) (64)];
;
 //BA.debugLineNum = 28;BA.debugLine="Dim total As Long";
_total = 0L;
 //BA.debugLineNum = 29;BA.debugLine="Do While (raf.CurrentPosition < raf.Size)";
if (true) break;

case 7:
//do while
this.state = 10;
while ((_raf.CurrentPosition<_raf.getSize())) {
this.state = 9;
if (true) break;
}
if (true) break;

case 9:
//C
this.state = 7;
 //BA.debugLineNum = 30;BA.debugLine="Sleep(10)";
parent.__c.Sleep(ba,this,(int) (10));
this.state = 15;
return;
case 15:
//C
this.state = 7;
;
 //BA.debugLineNum = 31;BA.debugLine="total = raf.Size";
_total = _raf.getSize();
 //BA.debugLineNum = 33;BA.debugLine="sr.SetRandomSeed(total)";
_sr.SetRandomSeed(_total);
 //BA.debugLineNum = 34;BA.debugLine="sr.GetRandomBytes(aesKey)";
_sr.GetRandomBytes(_aeskey);
 //BA.debugLineNum = 35;BA.debugLine="raf.WriteObject(aesKey, False, raf.CurrentPosi";
_raf.WriteObject((Object)(_aeskey),parent.__c.False,_raf.CurrentPosition);
 if (true) break;

case 10:
//C
this.state = 11;
;
 //BA.debugLineNum = 38;BA.debugLine="raf.Flush";
_raf.Flush();
 //BA.debugLineNum = 39;BA.debugLine="raf.Close";
_raf.Close();
 //BA.debugLineNum = 40;BA.debugLine="File.Delete(fPath,fName)";
parent.__c.File.Delete(_fpath,_fname);
 if (true) break;

case 11:
//C
this.state = 14;
;
 //BA.debugLineNum = 42;BA.debugLine="Return True";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.True));return;};
 if (true) break;

case 13:
//C
this.state = 14;
this.catchState = 0;
 //BA.debugLineNum = 44;BA.debugLine="Return False";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.False));return;};
 if (true) break;
if (true) break;

case 14:
//C
this.state = -1;
this.catchState = 0;
;
 //BA.debugLineNum = 46;BA.debugLine="End Sub";
if (true) break;
}} 
       catch (Exception e0) {
			
if (catchState == 0)
    throw e0;
else {
    state = catchState;
ba.setLastException(e0);}
            }
        }
    }
}
public String  _initialize(anywheresoftware.b4a.BA _ba) throws Exception{
innerInitialize(_ba);
 //BA.debugLineNum = 9;BA.debugLine="Public Sub Initialize";
 //BA.debugLineNum = 11;BA.debugLine="End Sub";
return "";
}
public String  _process_globals() throws Exception{
 //BA.debugLineNum = 13;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 17;BA.debugLine="End Sub";
return "";
}
public Object callSub(String sub, Object sender, Object[] args) throws Exception {
BA.senderHolder.set(sender);
return BA.SubDelegator.SubNotFound;
}
}
