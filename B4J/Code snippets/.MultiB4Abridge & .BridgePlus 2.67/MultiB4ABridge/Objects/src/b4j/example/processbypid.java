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
public anywheresoftware.b4a.objects.collections.List _vvvvvvv1 = null;
public anywheresoftware.b4j.object.JavaObject _vvvvvvv2 = null;
public com.stevel05.draganddrop.transfermode _vv6 = null;
public b4j.example.main _main = null;
public String  _class_globals() throws Exception{
 //BA.debugLineNum = 4;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 5;BA.debugLine="Private ByPID As List";
_vvvvvvv1 = new anywheresoftware.b4a.objects.collections.List();
 //BA.debugLineNum = 6;BA.debugLine="Private jo As JavaObject";
_vvvvvvv2 = new anywheresoftware.b4j.object.JavaObject();
 //BA.debugLineNum = 7;BA.debugLine="End Sub";
return "";
}
public String  _initialize(anywheresoftware.b4a.BA _ba) throws Exception{
innerInitialize(_ba);
 //BA.debugLineNum = 10;BA.debugLine="Public Sub Initialize";
 //BA.debugLineNum = 11;BA.debugLine="ByPID.Initialize";
_vvvvvvv1.Initialize();
 //BA.debugLineNum = 12;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _vvvvvv6(String _mepid) throws Exception{
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
 //BA.debugLineNum = 31;BA.debugLine="Try";
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
 //BA.debugLineNum = 32;BA.debugLine="jo = Me";
parent._vvvvvvv2 = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(parent));
 //BA.debugLineNum = 33;BA.debugLine="jo.RunMethod(\"killProcessByPID\", Array As Object";
parent._vvvvvvv2.RunMethod("killProcessByPID",new Object[]{(Object)(_mepid)});
 if (true) break;

case 5:
//C
this.state = 6;
this.catchState = 0;
 //BA.debugLineNum = 35;BA.debugLine="Return False";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.False));return;};
 if (true) break;
if (true) break;

case 6:
//C
this.state = -1;
this.catchState = 0;
;
 //BA.debugLineNum = 37;BA.debugLine="Return True";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.True));return;};
 //BA.debugLineNum = 38;BA.debugLine="End Sub";
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
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _vvvvvv7(String _lstpathname,String _lstfilename) throws Exception{
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
 //BA.debugLineNum = 43;BA.debugLine="Try";
if (true) break;

case 1:
//try
this.state = 26;
this.catchState = 25;
this.state = 3;
if (true) break;

case 3:
//C
this.state = 4;
this.catchState = 25;
 //BA.debugLineNum = 44;BA.debugLine="If File.Exists(lstPathname, lstFilename) Then";
if (true) break;

case 4:
//if
this.state = 23;
if (parent.__c.File.Exists(_lstpathname,_lstfilename)) { 
this.state = 6;
}else {
this.state = 22;
}if (true) break;

case 6:
//C
this.state = 7;
 //BA.debugLineNum = 45;BA.debugLine="ByPID = File.ReadList(lstPathname, lstFilename)";
parent._vvvvvvv1 = parent.__c.File.ReadList(_lstpathname,_lstfilename);
 //BA.debugLineNum = 47;BA.debugLine="If ByPID.IsInitialized And ByPID.Size > 0 Then";
if (true) break;

case 7:
//if
this.state = 20;
if (parent._vvvvvvv1.IsInitialized() && parent._vvvvvvv1.getSize()>0) { 
this.state = 9;
}else {
this.state = 19;
}if (true) break;

case 9:
//C
this.state = 10;
 //BA.debugLineNum = 48;BA.debugLine="For i = 0 To ByPID.Size -1";
if (true) break;

case 10:
//for
this.state = 17;
step5 = 1;
limit5 = (int) (parent._vvvvvvv1.getSize()-1);
_i = (int) (0) ;
this.state = 27;
if (true) break;

case 27:
//C
this.state = 17;
if ((step5 > 0 && _i <= limit5) || (step5 < 0 && _i >= limit5)) this.state = 12;
if (true) break;

case 28:
//C
this.state = 27;
_i = ((int)(0 + _i + step5)) ;
if (true) break;

case 12:
//C
this.state = 13;
 //BA.debugLineNum = 49;BA.debugLine="If ByPID.Get(i).As(String).Length > 0 Then";
if (true) break;

case 13:
//if
this.state = 16;
if ((BA.ObjectToString(parent._vvvvvvv1.Get(_i))).length()>0) { 
this.state = 15;
}if (true) break;

case 15:
//C
this.state = 16;
 //BA.debugLineNum = 50;BA.debugLine="jo = Me";
parent._vvvvvvv2 = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(parent));
 //BA.debugLineNum = 51;BA.debugLine="jo.RunMethod(\"killProcessByPID\", Array As Ob";
parent._vvvvvvv2.RunMethod("killProcessByPID",new Object[]{parent._vvvvvvv1.Get(_i)});
 if (true) break;

case 16:
//C
this.state = 28;
;
 if (true) break;
if (true) break;

case 17:
//C
this.state = 20;
;
 if (true) break;

case 19:
//C
this.state = 20;
 //BA.debugLineNum = 55;BA.debugLine="Return False";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.False));return;};
 if (true) break;

case 20:
//C
this.state = 23;
;
 if (true) break;

case 22:
//C
this.state = 23;
 //BA.debugLineNum = 58;BA.debugLine="Return False";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.False));return;};
 if (true) break;

case 23:
//C
this.state = 26;
;
 if (true) break;

case 25:
//C
this.state = 26;
this.catchState = 0;
 //BA.debugLineNum = 61;BA.debugLine="Return False";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.False));return;};
 if (true) break;
if (true) break;

case 26:
//C
this.state = -1;
this.catchState = 0;
;
 //BA.debugLineNum = 63;BA.debugLine="Return True";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.True));return;};
 //BA.debugLineNum = 64;BA.debugLine="End Sub";
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
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _vvvvvv0(String _lstpathname,String _lstfilename) throws Exception{
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
 //BA.debugLineNum = 16;BA.debugLine="Try";
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
 //BA.debugLineNum = 17;BA.debugLine="jo.InitializeStatic(\"java.lang.management.Manage";
parent._vvvvvvv2.InitializeStatic("java.lang.management.ManagementFactory");
 //BA.debugLineNum = 18;BA.debugLine="Dim PID As String = jo.RunMethodJO(\"getRuntimeMX";
_pid = BA.ObjectToString(parent._vvvvvvv2.RunMethodJO("getRuntimeMXBean",(Object[])(parent.__c.Null)).RunMethod("getName",(Object[])(parent.__c.Null)));
 //BA.debugLineNum = 19;BA.debugLine="PID = PID.SubString2(0,PID.IndexOf(\"@\"))";
_pid = _pid.substring((int) (0),_pid.indexOf("@"));
 //BA.debugLineNum = 21;BA.debugLine="ByPID.Add(PID)";
parent._vvvvvvv1.Add((Object)(_pid));
 //BA.debugLineNum = 22;BA.debugLine="File.WriteList(lstPathname, lstFilename, ByPID)";
parent.__c.File.WriteList(_lstpathname,_lstfilename,parent._vvvvvvv1);
 if (true) break;

case 5:
//C
this.state = 6;
this.catchState = 0;
 //BA.debugLineNum = 24;BA.debugLine="Return False";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.False));return;};
 if (true) break;
if (true) break;

case 6:
//C
this.state = -1;
this.catchState = 0;
;
 //BA.debugLineNum = 26;BA.debugLine="Return True";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.True));return;};
 //BA.debugLineNum = 27;BA.debugLine="End Sub";
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
