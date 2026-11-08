package b4j.example;

import java.io.IOException;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class processbypid extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4j.objects.FxBA("b4j.example", "b4j.example.processbypid", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.processbypid.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 public anywheresoftware.b4a.keywords.Common __c = null;
public anywheresoftware.b4a.objects.collections.List _vv7 = null;
public anywheresoftware.b4j.object.JavaObject _vv0 = null;
public b4j.example.safebypid _vvv1 = null;
public String _vvv2 = "";
public String _vvv3 = "";
public b4j.example.main _vvv4 = null;
public String  _class_globals() throws Exception{
 //BA.debugLineNum = 4;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 5;BA.debugLine="Private ByPID As List";
_vv7 = new anywheresoftware.b4a.objects.collections.List();
 //BA.debugLineNum = 6;BA.debugLine="Private jo As JavaObject";
_vv0 = new anywheresoftware.b4j.object.JavaObject();
 //BA.debugLineNum = 7;BA.debugLine="Private safe As SafeByPID";
_vvv1 = new b4j.example.safebypid();
 //BA.debugLineNum = 8;BA.debugLine="Dim Pathname, Filename As String";
_vvv2 = "";
_vvv3 = "";
 //BA.debugLineNum = 9;BA.debugLine="End Sub";
return "";
}
public String  _initialize(anywheresoftware.b4a.BA _ba,String _inipathname,String _inifilename) throws Exception{
innerInitialize(_ba);
 //BA.debugLineNum = 12;BA.debugLine="Public Sub Initialize(iniPathname As String, iniFi";
 //BA.debugLineNum = 13;BA.debugLine="ByPID.Initialize";
_vv7.Initialize();
 //BA.debugLineNum = 14;BA.debugLine="Pathname = iniPathname";
_vvv2 = _inipathname;
 //BA.debugLineNum = 15;BA.debugLine="Filename = iniFilename";
_vvv3 = _inifilename;
 //BA.debugLineNum = 16;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _vv4(String _mepid) throws Exception{
ResumableSub_KillByPID rsub = new ResumableSub_KillByPID(this,_mepid);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_KillByPID extends BA.ResumableSub {
public ResumableSub_KillByPID(b4j.example.processbypid parent,String _mepid) {
this.parent = parent;
this._mepid = _mepid;
}
b4j.example.processbypid parent;
String _mepid;

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
 //BA.debugLineNum = 35;BA.debugLine="Try";
if (true) break;

case 1:
//try
this.state = 6;
this.catchState = 5;
this.state = 3;
if (true) break;

case 3:
//C
this.state = 6;
this.catchState = 5;
 //BA.debugLineNum = 36;BA.debugLine="jo = Me";
parent._vv0 = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(parent));
 //BA.debugLineNum = 37;BA.debugLine="jo.RunMethod(\"killProcessByPID\", Array As Object";
parent._vv0.RunMethod("killProcessByPID",new Object[]{(Object)(_mepid)});
 if (true) break;

case 5:
//C
this.state = 6;
this.catchState = 0;
 //BA.debugLineNum = 39;BA.debugLine="Return False";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.False));return;};
 if (true) break;
if (true) break;

case 6:
//C
this.state = -1;
this.catchState = 0;
;
 //BA.debugLineNum = 41;BA.debugLine="Return True";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.True));return;};
 //BA.debugLineNum = 42;BA.debugLine="End Sub";
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
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _vv5(String _lstpathname,String _lstfilename) throws Exception{
ResumableSub_KillByPIDFromListFile rsub = new ResumableSub_KillByPIDFromListFile(this,_lstpathname,_lstfilename);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_KillByPIDFromListFile extends BA.ResumableSub {
public ResumableSub_KillByPIDFromListFile(b4j.example.processbypid parent,String _lstpathname,String _lstfilename) {
this.parent = parent;
this._lstpathname = _lstpathname;
this._lstfilename = _lstfilename;
}
b4j.example.processbypid parent;
String _lstpathname;
String _lstfilename;
int _i = 0;
boolean _resultsafe = false;
int step5;
int limit5;

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
 //BA.debugLineNum = 47;BA.debugLine="Try";
if (true) break;

case 1:
//try
this.state = 32;
this.catchState = 31;
this.state = 3;
if (true) break;

case 3:
//C
this.state = 4;
this.catchState = 31;
 //BA.debugLineNum = 48;BA.debugLine="If File.Exists(lstPathname, lstFilename) Then";
if (true) break;

case 4:
//if
this.state = 29;
if (parent.__c.File.Exists(_lstpathname,_lstfilename)) { 
this.state = 6;
}else {
this.state = 28;
}if (true) break;

case 6:
//C
this.state = 7;
 //BA.debugLineNum = 49;BA.debugLine="ByPID = File.ReadList(lstPathname, lstFilename)";
parent._vv7 = parent.__c.File.ReadList(_lstpathname,_lstfilename);
 //BA.debugLineNum = 51;BA.debugLine="If ByPID.IsInitialized And ByPID.Size > 0 Then";
if (true) break;

case 7:
//if
this.state = 26;
if (parent._vv7.IsInitialized() && parent._vv7.getSize()>0) { 
this.state = 9;
}else {
this.state = 25;
}if (true) break;

case 9:
//C
this.state = 10;
 //BA.debugLineNum = 52;BA.debugLine="For i = 0 To ByPID.Size -1";
if (true) break;

case 10:
//for
this.state = 17;
step5 = 1;
limit5 = (int) (parent._vv7.getSize()-1);
_i = (int) (0) ;
this.state = 33;
if (true) break;

case 33:
//C
this.state = 17;
if ((step5 > 0 && _i <= limit5) || (step5 < 0 && _i >= limit5)) this.state = 12;
if (true) break;

case 34:
//C
this.state = 33;
_i = ((int)(0 + _i + step5)) ;
if (true) break;

case 12:
//C
this.state = 13;
 //BA.debugLineNum = 53;BA.debugLine="If ByPID.Get(i).As(String).Length > 0 Then";
if (true) break;

case 13:
//if
this.state = 16;
if ((BA.ObjectToString(parent._vv7.Get(_i))).length()>0) { 
this.state = 15;
}if (true) break;

case 15:
//C
this.state = 16;
 //BA.debugLineNum = 54;BA.debugLine="jo = Me";
parent._vv0 = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(parent));
 //BA.debugLineNum = 55;BA.debugLine="jo.RunMethod(\"killProcessByPID\", Array As Ob";
parent._vv0.RunMethod("killProcessByPID",new Object[]{parent._vv7.Get(_i)});
 if (true) break;

case 16:
//C
this.state = 34;
;
 if (true) break;
if (true) break;

case 17:
//C
this.state = 18;
;
 //BA.debugLineNum = 58;BA.debugLine="safe.Initialize";
parent._vvv1._initialize /*String*/ (ba);
 //BA.debugLineNum = 59;BA.debugLine="Wait For (safe.Delete(lstPathname, lstFilename";
parent.__c.WaitFor("complete", ba, this, parent._vvv1._vvv5 /*anywheresoftware.b4a.keywords.Common.ResumableSubWrapper*/ (_lstpathname,_lstfilename));
this.state = 35;
return;
case 35:
//C
this.state = 18;
_resultsafe = (boolean) result[0];
;
 //BA.debugLineNum = 60;BA.debugLine="If resultSafe Then Log(\"Safe delete!\")";
if (true) break;

case 18:
//if
this.state = 23;
if (_resultsafe) { 
this.state = 20;
;}if (true) break;

case 20:
//C
this.state = 23;
parent.__c.LogImpl("3458766","Safe delete!",0);
if (true) break;

case 23:
//C
this.state = 26;
;
 if (true) break;

case 25:
//C
this.state = 26;
 //BA.debugLineNum = 62;BA.debugLine="Return False";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.False));return;};
 if (true) break;

case 26:
//C
this.state = 29;
;
 if (true) break;

case 28:
//C
this.state = 29;
 //BA.debugLineNum = 65;BA.debugLine="Return False";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.False));return;};
 if (true) break;

case 29:
//C
this.state = 32;
;
 if (true) break;

case 31:
//C
this.state = 32;
this.catchState = 0;
 //BA.debugLineNum = 68;BA.debugLine="Return False";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.False));return;};
 if (true) break;
if (true) break;

case 32:
//C
this.state = -1;
this.catchState = 0;
;
 //BA.debugLineNum = 70;BA.debugLine="Return True";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.True));return;};
 //BA.debugLineNum = 71;BA.debugLine="End Sub";
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
public void  _complete(boolean _resultsafe) throws Exception{
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _vv6(String _lstpathname,String _lstfilename) throws Exception{
ResumableSub_SaveByPID2WriteList rsub = new ResumableSub_SaveByPID2WriteList(this,_lstpathname,_lstfilename);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_SaveByPID2WriteList extends BA.ResumableSub {
public ResumableSub_SaveByPID2WriteList(b4j.example.processbypid parent,String _lstpathname,String _lstfilename) {
this.parent = parent;
this._lstpathname = _lstpathname;
this._lstfilename = _lstfilename;
}
b4j.example.processbypid parent;
String _lstpathname;
String _lstfilename;
String _pid = "";

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
this.state = 6;
this.catchState = 5;
this.state = 3;
if (true) break;

case 3:
//C
this.state = 6;
this.catchState = 5;
 //BA.debugLineNum = 21;BA.debugLine="jo.InitializeStatic(\"java.lang.management.Manage";
parent._vv0.InitializeStatic("java.lang.management.ManagementFactory");
 //BA.debugLineNum = 22;BA.debugLine="Dim PID As String = jo.RunMethodJO(\"getRuntimeMX";
_pid = BA.ObjectToString(parent._vv0.RunMethodJO("getRuntimeMXBean",(Object[])(parent.__c.Null)).RunMethod("getName",(Object[])(parent.__c.Null)));
 //BA.debugLineNum = 23;BA.debugLine="PID = PID.SubString2(0,PID.IndexOf(\"@\"))";
_pid = _pid.substring((int) (0),_pid.indexOf("@"));
 //BA.debugLineNum = 25;BA.debugLine="ByPID.Add(PID)";
parent._vv7.Add((Object)(_pid));
 //BA.debugLineNum = 26;BA.debugLine="File.WriteList(lstPathname, lstFilename, ByPID)";
parent.__c.File.WriteList(_lstpathname,_lstfilename,parent._vv7);
 if (true) break;

case 5:
//C
this.state = 6;
this.catchState = 0;
 //BA.debugLineNum = 28;BA.debugLine="Return False";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.False));return;};
 if (true) break;
if (true) break;

case 6:
//C
this.state = -1;
this.catchState = 0;
;
 //BA.debugLineNum = 30;BA.debugLine="Return True";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.True));return;};
 //BA.debugLineNum = 31;BA.debugLine="End Sub";
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
public Object callSub(String sub, Object sender, Object[] args) throws Exception {
BA.senderHolder.set(sender);
return BA.SubDelegator.SubNotFound;
}

	public static boolean killProcessByPID(String pid)
    {
        String cmd = "taskkill /F /PID " + pid;
        try {
            Runtime.getRuntime().exec(cmd);
            return true;
        } catch (IOException ex) {
            System.err.println("Failed to kill PID: " + pid);
            System.err.println(ex.getMessage());
            return false;
        }
    }
}
