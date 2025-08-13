package b4j.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class callsubutils extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4j.objects.FxBA("b4j.example", "b4j.example.callsubutils", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.callsubutils.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 public anywheresoftware.b4a.keywords.Common __c = null;
public anywheresoftware.b4a.objects.collections.Map _vvv4 = null;
public com.stevel05.draganddrop.transfermode _vv6 = null;
public b4j.example.main _main = null;
public static class _rundelayeddata{
public boolean IsInitialized;
public Object Module;
public String SubName;
public Object[] Arg;
public boolean Delayed;
public boolean Cancelled;
public void Initialize() {
IsInitialized = true;
Module = new Object();
SubName = "";
Arg = new Object[0];
{
int d0 = Arg.length;
for (int i0 = 0;i0 < d0;i0++) {
Arg[i0] = new Object();
}
}
;
Delayed = false;
Cancelled = false;
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public b4j.example.callsubutils._rundelayeddata  _vv7(Object _module,String _subname,int _delay) throws Exception{
 //BA.debugLineNum = 13;BA.debugLine="Public Sub CallSubDelayedPlus(Module As Object, Su";
 //BA.debugLineNum = 14;BA.debugLine="Return CallSubDelayedPlus2(Module, SubName, Delay";
if (true) return _vv0(_module,_subname,_delay,(Object[])(__c.Null));
 //BA.debugLineNum = 15;BA.debugLine="End Sub";
return null;
}
public b4j.example.callsubutils._rundelayeddata  _vv0(Object _module,String _subname,int _delay,Object[] _arg) throws Exception{
 //BA.debugLineNum = 20;BA.debugLine="Public Sub CallSubDelayedPlus2(Module As Object, S";
 //BA.debugLineNum = 21;BA.debugLine="Return PlusImpl(Module, SubName, Delay, Arg, True";
if (true) return _vvv3(_module,_subname,_delay,_arg,__c.True);
 //BA.debugLineNum = 22;BA.debugLine="End Sub";
return null;
}
public b4j.example.callsubutils._rundelayeddata  _vvv1(Object _module,String _subname,int _delay) throws Exception{
 //BA.debugLineNum = 26;BA.debugLine="Public Sub CallSubPlus(Module As Object, SubName A";
 //BA.debugLineNum = 27;BA.debugLine="Return CallSubPlus2(Module, SubName, Delay, Null)";
if (true) return _vvv2(_module,_subname,_delay,(Object[])(__c.Null));
 //BA.debugLineNum = 28;BA.debugLine="End Sub";
return null;
}
public b4j.example.callsubutils._rundelayeddata  _vvv2(Object _module,String _subname,int _delay,Object[] _arg) throws Exception{
 //BA.debugLineNum = 33;BA.debugLine="Public Sub CallSubPlus2(Module As Object, SubName";
 //BA.debugLineNum = 34;BA.debugLine="Return PlusImpl(Module, SubName, Delay, Arg, Fals";
if (true) return _vvv3(_module,_subname,_delay,_arg,__c.False);
 //BA.debugLineNum = 35;BA.debugLine="End Sub";
return null;
}
public String  _class_globals() throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 3;BA.debugLine="Private RunDelayed As Map";
_vvv4 = new anywheresoftware.b4a.objects.collections.Map();
 //BA.debugLineNum = 4;BA.debugLine="Type RunDelayedData (Module As Object, SubName As";
;
 //BA.debugLineNum = 5;BA.debugLine="End Sub";
return "";
}
public String  _initialize(anywheresoftware.b4a.BA _ba) throws Exception{
innerInitialize(_ba);
 //BA.debugLineNum = 7;BA.debugLine="Public Sub Initialize";
 //BA.debugLineNum = 9;BA.debugLine="End Sub";
return "";
}
public b4j.example.callsubutils._rundelayeddata  _vvv3(Object _module,String _subname,int _delay,Object[] _arg,boolean _delayed) throws Exception{
anywheresoftware.b4a.objects.Timer _tmr = null;
b4j.example.callsubutils._rundelayeddata _rdd = null;
 //BA.debugLineNum = 37;BA.debugLine="Private Sub PlusImpl(Module As Object, SubName As";
 //BA.debugLineNum = 38;BA.debugLine="If RunDelayed.IsInitialized = False Then RunDelay";
if (_vvv4.IsInitialized()==__c.False) { 
_vvv4.Initialize();};
 //BA.debugLineNum = 39;BA.debugLine="Dim tmr As Timer";
_tmr = new anywheresoftware.b4a.objects.Timer();
 //BA.debugLineNum = 40;BA.debugLine="tmr.Initialize(\"tmr\", Delay)";
_tmr.Initialize(ba,"tmr",(long) (_delay));
 //BA.debugLineNum = 41;BA.debugLine="Dim rdd As RunDelayedData";
_rdd = new b4j.example.callsubutils._rundelayeddata();
 //BA.debugLineNum = 42;BA.debugLine="rdd.Module = Module";
_rdd.Module /*Object*/  = _module;
 //BA.debugLineNum = 43;BA.debugLine="rdd.SubName = SubName";
_rdd.SubName /*String*/  = _subname;
 //BA.debugLineNum = 44;BA.debugLine="rdd.Arg = Arg";
_rdd.Arg /*Object[]*/  = _arg;
 //BA.debugLineNum = 45;BA.debugLine="rdd.delayed = delayed";
_rdd.Delayed /*boolean*/  = _delayed;
 //BA.debugLineNum = 46;BA.debugLine="RunDelayed.Put(tmr, rdd)";
_vvv4.Put((Object)(_tmr),(Object)(_rdd));
 //BA.debugLineNum = 47;BA.debugLine="tmr.Enabled = True";
_tmr.setEnabled(__c.True);
 //BA.debugLineNum = 48;BA.debugLine="Return rdd";
if (true) return _rdd;
 //BA.debugLineNum = 49;BA.debugLine="End Sub";
return null;
}
public String  _tmr_tick() throws Exception{
anywheresoftware.b4a.objects.Timer _t = null;
b4j.example.callsubutils._rundelayeddata _rdd = null;
 //BA.debugLineNum = 51;BA.debugLine="Private Sub tmr_Tick";
 //BA.debugLineNum = 52;BA.debugLine="Dim t As Timer = Sender";
_t = (anywheresoftware.b4a.objects.Timer)(__c.Sender(ba));
 //BA.debugLineNum = 53;BA.debugLine="t.Enabled = False";
_t.setEnabled(__c.False);
 //BA.debugLineNum = 54;BA.debugLine="Dim rdd As RunDelayedData = RunDelayed.Get(t)";
_rdd = (b4j.example.callsubutils._rundelayeddata)(_vvv4.Get((Object)(_t)));
 //BA.debugLineNum = 55;BA.debugLine="RunDelayed.Remove(t)";
_vvv4.Remove((Object)(_t));
 //BA.debugLineNum = 56;BA.debugLine="If rdd.Cancelled Then Return";
if (_rdd.Cancelled /*boolean*/ ) { 
if (true) return "";};
 //BA.debugLineNum = 57;BA.debugLine="If rdd.Delayed Then";
if (_rdd.Delayed /*boolean*/ ) { 
 //BA.debugLineNum = 58;BA.debugLine="If rdd.Arg = Null Then";
if (_rdd.Arg /*Object[]*/ == null) { 
 //BA.debugLineNum = 59;BA.debugLine="CallSubDelayed(rdd.Module, rdd.SubName)";
__c.CallSubDelayed(ba,_rdd.Module /*Object*/ ,_rdd.SubName /*String*/ );
 }else {
 //BA.debugLineNum = 61;BA.debugLine="CallSubDelayed2(rdd.Module, rdd.SubName, rdd.Ar";
__c.CallSubDelayed2(ba,_rdd.Module /*Object*/ ,_rdd.SubName /*String*/ ,(Object)(_rdd.Arg /*Object[]*/ ));
 };
 }else {
 //BA.debugLineNum = 64;BA.debugLine="If rdd.Arg = Null Then";
if (_rdd.Arg /*Object[]*/ == null) { 
 //BA.debugLineNum = 65;BA.debugLine="CallSub(rdd.Module, rdd.SubName)";
__c.CallSubNew(ba,_rdd.Module /*Object*/ ,_rdd.SubName /*String*/ );
 }else {
 //BA.debugLineNum = 67;BA.debugLine="CallSub2(rdd.Module, rdd.SubName, rdd.Arg)";
__c.CallSubNew2(ba,_rdd.Module /*Object*/ ,_rdd.SubName /*String*/ ,(Object)(_rdd.Arg /*Object[]*/ ));
 };
 };
 //BA.debugLineNum = 70;BA.debugLine="End Sub";
return "";
}
public Object callSub(String sub, Object sender, Object[] args) throws Exception {
BA.senderHolder.set(sender);
return BA.SubDelegator.SubNotFound;
}
}
