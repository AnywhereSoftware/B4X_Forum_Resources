package b4j.HTMLEditorFix;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class b4xmainpage extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.HTMLEditorFix", "b4j.HTMLEditorFix.b4xmainpage", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.HTMLEditorFix.b4xmainpage.class).invoke(this, new Object[] {null});
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
public anywheresoftware.b4a.objects.B4XViewWrapper _root = null;
public anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public butt.droid.awtRobot.AWTRobot _robot = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _edhtml = null;
public anywheresoftware.b4j.object.JavaObject _jckeyevt = null;
public anywheresoftware.b4j.object.JavaObject _jokeyevtkeypressed = null;
public anywheresoftware.b4j.object.JavaObject _jokeyevtkeyreleased = null;
public anywheresoftware.b4j.object.JavaObject _jokeyevtkeytyped = null;
public boolean _crcoming = false;
public boolean _delneeded = false;
public b4j.HTMLEditorFix.main _main = null;
public b4j.HTMLEditorFix.b4xpages _b4xpages = null;
public b4j.HTMLEditorFix.b4xcollections _b4xcollections = null;
public String  _b4xpage_created(b4j.HTMLEditorFix.b4xmainpage __ref,anywheresoftware.b4a.objects.B4XViewWrapper _root1) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "b4xpage_created", false))
	 {return ((String) Debug.delegate(ba, "b4xpage_created", new Object[] {_root1}));}
anywheresoftware.b4a.keywords.StringBuilderWrapper _sb = null;
anywheresoftware.b4j.agraham.reflection.Reflection _r = null;
RDebugUtils.currentLine=589824;
 //BA.debugLineNum = 589824;BA.debugLine="Private Sub B4XPage_Created (Root1 As B4XView)";
RDebugUtils.currentLine=589825;
 //BA.debugLineNum = 589825;BA.debugLine="Root = Root1";
__ref._root /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = _root1;
RDebugUtils.currentLine=589826;
 //BA.debugLineNum = 589826;BA.debugLine="Root.LoadLayout(\"MainPage\")";
__ref._root /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .LoadLayout("MainPage",ba);
RDebugUtils.currentLine=589828;
 //BA.debugLineNum = 589828;BA.debugLine="Dim sb As StringBuilder";
_sb = new anywheresoftware.b4a.keywords.StringBuilderWrapper();
RDebugUtils.currentLine=589829;
 //BA.debugLineNum = 589829;BA.debugLine="sb.Initialize";
_sb.Initialize();
RDebugUtils.currentLine=589830;
 //BA.debugLineNum = 589830;BA.debugLine="sb.Append(\"<html dir=\").Append(Quoted(\"ltr\")).App";
_sb.Append("<html dir=").Append(__ref._quoted /*String*/ (null,"ltr")).Append("><head>");
RDebugUtils.currentLine=589832;
 //BA.debugLineNum = 589832;BA.debugLine="sb.Append(\"<style type=\").Append(Quoted(\"text/css";
_sb.Append("<style type=").Append(__ref._quoted /*String*/ (null,"text/css")).Append(">").Append("div {display: inline;} p {display: inline;}").Append("</style></head>");
RDebugUtils.currentLine=589833;
 //BA.debugLineNum = 589833;BA.debugLine="sb.Append(\"<body contenteditable=\").Append(Quoted";
_sb.Append("<body contenteditable=").Append(__ref._quoted /*String*/ (null,"true")).Append(">");
RDebugUtils.currentLine=589834;
 //BA.debugLineNum = 589834;BA.debugLine="edHTML.As(HTMLEditor).HTMLText = sb.Append(\"</bod";
((anywheresoftware.b4j.objects.HTMLEditorWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.HTMLEditorWrapper(), (javafx.scene.web.HTMLEditor)(__ref._edhtml /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getObject()))).setHtmlText(_sb.Append("</body></html>").ToString());
RDebugUtils.currentLine=589836;
 //BA.debugLineNum = 589836;BA.debugLine="Dim r As Reflector";
_r = new anywheresoftware.b4j.agraham.reflection.Reflection();
RDebugUtils.currentLine=589837;
 //BA.debugLineNum = 589837;BA.debugLine="r.Target = edHTML";
_r.Target = (Object)(__ref._edhtml /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getObject());
RDebugUtils.currentLine=589838;
 //BA.debugLineNum = 589838;BA.debugLine="r.AddEventFilter(\"HTMLKey\", \"javafx.scene.input.K";
_r.AddEventFilter(ba,"HTMLKey","javafx.scene.input.KeyEvent.ANY");
RDebugUtils.currentLine=589839;
 //BA.debugLineNum = 589839;BA.debugLine="End Sub";
return "";
}
public String  _quoted(b4j.HTMLEditorFix.b4xmainpage __ref,String _s) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "quoted", false))
	 {return ((String) Debug.delegate(ba, "quoted", new Object[] {_s}));}
RDebugUtils.currentLine=8650752;
 //BA.debugLineNum = 8650752;BA.debugLine="Private Sub Quoted(s As String) As String";
RDebugUtils.currentLine=8650753;
 //BA.debugLineNum = 8650753;BA.debugLine="If s.Length = 0 Then Return QUOTE & QUOTE";
if (_s.length()==0) { 
if (true) return __c.QUOTE+__c.QUOTE;};
RDebugUtils.currentLine=8650754;
 //BA.debugLineNum = 8650754;BA.debugLine="If Not(s.StartsWith(QUOTE)) Then s = QUOTE & s";
if (__c.Not(_s.startsWith(__c.QUOTE))) { 
_s = __c.QUOTE+_s;};
RDebugUtils.currentLine=8650755;
 //BA.debugLineNum = 8650755;BA.debugLine="Return IIf(s.EndsWith(QUOTE), s, s & QUOTE)";
if (true) return BA.ObjectToString(((_s.endsWith(__c.QUOTE)) ? ((Object)(_s)) : ((Object)(_s+__c.QUOTE))));
RDebugUtils.currentLine=8650756;
 //BA.debugLineNum = 8650756;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4j.HTMLEditorFix.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
RDebugUtils.currentLine=458752;
 //BA.debugLineNum = 458752;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=458753;
 //BA.debugLineNum = 458753;BA.debugLine="Private Root As B4XView";
_root = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=458754;
 //BA.debugLineNum = 458754;BA.debugLine="Private xui As XUI";
_xui = new anywheresoftware.b4a.objects.B4XViewWrapper.XUI();
RDebugUtils.currentLine=458755;
 //BA.debugLineNum = 458755;BA.debugLine="Private Robot As AWTRobot";
_robot = new butt.droid.awtRobot.AWTRobot();
RDebugUtils.currentLine=458756;
 //BA.debugLineNum = 458756;BA.debugLine="Private edHTML As B4XView";
_edhtml = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=458758;
 //BA.debugLineNum = 458758;BA.debugLine="Private jcKeyEvt As JavaObject";
_jckeyevt = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=458759;
 //BA.debugLineNum = 458759;BA.debugLine="Private joKeyEvtKeyPressed As JavaObject";
_jokeyevtkeypressed = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=458760;
 //BA.debugLineNum = 458760;BA.debugLine="Private joKeyEvtKeyReleased As JavaObject";
_jokeyevtkeyreleased = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=458761;
 //BA.debugLineNum = 458761;BA.debugLine="Private joKeyEvtKeyTyped As JavaObject";
_jokeyevtkeytyped = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=458763;
 //BA.debugLineNum = 458763;BA.debugLine="Private CRComing As Boolean";
_crcoming = false;
RDebugUtils.currentLine=458764;
 //BA.debugLineNum = 458764;BA.debugLine="Private DelNeeded As Boolean";
_delneeded = false;
RDebugUtils.currentLine=458765;
 //BA.debugLineNum = 458765;BA.debugLine="End Sub";
return "";
}
public String  _htmlkey_filter(b4j.HTMLEditorFix.b4xmainpage __ref,anywheresoftware.b4j.objects.NodeWrapper.ConcreteEventWrapper _e) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "htmlkey_filter", false))
	 {return ((String) Debug.delegate(ba, "htmlkey_filter", new Object[] {_e}));}
anywheresoftware.b4j.object.JavaObject _joevt = null;
anywheresoftware.b4j.object.JavaObject _jotype = null;
String _code = "";
RDebugUtils.currentLine=8126464;
 //BA.debugLineNum = 8126464;BA.debugLine="Private Sub HTMLKey_Filter(e As Event)";
RDebugUtils.currentLine=8126465;
 //BA.debugLineNum = 8126465;BA.debugLine="Private joEvt As JavaObject = e";
_joevt = new anywheresoftware.b4j.object.JavaObject();
_joevt = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_e.getObject()));
RDebugUtils.currentLine=8126466;
 //BA.debugLineNum = 8126466;BA.debugLine="Private joType As JavaObject = joEvt.RunMethod(\"g";
_jotype = new anywheresoftware.b4j.object.JavaObject();
_jotype = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_joevt.RunMethod("getEventType",(Object[])(__c.Null))));
RDebugUtils.currentLine=8126467;
 //BA.debugLineNum = 8126467;BA.debugLine="If joType = joKeyEvtKeyPressed Then 'Consume the";
if ((_jotype).equals(__ref._jokeyevtkeypressed /*anywheresoftware.b4j.object.JavaObject*/ )) { 
RDebugUtils.currentLine=8126468;
 //BA.debugLineNum = 8126468;BA.debugLine="If DelNeeded Then 'Get ahead of the extra space";
if (__ref._delneeded /*boolean*/ ) { 
RDebugUtils.currentLine=8126469;
 //BA.debugLineNum = 8126469;BA.debugLine="DelNeeded = False";
__ref._delneeded /*boolean*/  = __c.False;
RDebugUtils.currentLine=8126470;
 //BA.debugLineNum = 8126470;BA.debugLine="Robot.RobotSpecialKeyPress(\"left_arrow\")";
__ref._robot /*butt.droid.awtRobot.AWTRobot*/ .RobotSpecialKeyPress("left_arrow");
RDebugUtils.currentLine=8126471;
 //BA.debugLineNum = 8126471;BA.debugLine="Robot.RobotSpecialKeyRelease(\"left_arrow\")";
__ref._robot /*butt.droid.awtRobot.AWTRobot*/ .RobotSpecialKeyRelease("left_arrow");
 };
RDebugUtils.currentLine=8126473;
 //BA.debugLineNum = 8126473;BA.debugLine="Private Code As String = joEvt.RunMethodJO(\"getC";
_code = BA.ObjectToString(_joevt.RunMethodJO("getCode",(Object[])(__c.Null)).RunMethod("toString",(Object[])(__c.Null)));
RDebugUtils.currentLine=8126474;
 //BA.debugLineNum = 8126474;BA.debugLine="CRComing = Code.EqualsIgnoreCase(\"enter\")";
__ref._crcoming /*boolean*/  = _code.equalsIgnoreCase("enter");
RDebugUtils.currentLine=8126475;
 //BA.debugLineNum = 8126475;BA.debugLine="If CRComing Then e.Consume";
if (__ref._crcoming /*boolean*/ ) { 
_e.Consume();};
 }else 
{RDebugUtils.currentLine=8126476;
 //BA.debugLineNum = 8126476;BA.debugLine="Else If joType = joKeyEvtKeyTyped Then";
if ((_jotype).equals(__ref._jokeyevtkeytyped /*anywheresoftware.b4j.object.JavaObject*/ )) { 
RDebugUtils.currentLine=8126477;
 //BA.debugLineNum = 8126477;BA.debugLine="If CRComing Then e.Consume";
if (__ref._crcoming /*boolean*/ ) { 
_e.Consume();};
 }else 
{RDebugUtils.currentLine=8126478;
 //BA.debugLineNum = 8126478;BA.debugLine="Else If joType = joKeyEvtKeyReleased Then";
if ((_jotype).equals(__ref._jokeyevtkeyreleased /*anywheresoftware.b4j.object.JavaObject*/ )) { 
RDebugUtils.currentLine=8126479;
 //BA.debugLineNum = 8126479;BA.debugLine="If CRComing Then";
if (__ref._crcoming /*boolean*/ ) { 
RDebugUtils.currentLine=8126480;
 //BA.debugLineNum = 8126480;BA.debugLine="CRComing = False";
__ref._crcoming /*boolean*/  = __c.False;
RDebugUtils.currentLine=8126481;
 //BA.debugLineNum = 8126481;BA.debugLine="e.Consume";
_e.Consume();
RDebugUtils.currentLine=8126482;
 //BA.debugLineNum = 8126482;BA.debugLine="Robot.RobotPaste2(CRLF & \" \") 'The extra space";
__ref._robot /*butt.droid.awtRobot.AWTRobot*/ .RobotPaste2(__c.CRLF+" ");
RDebugUtils.currentLine=8126483;
 //BA.debugLineNum = 8126483;BA.debugLine="DelNeeded = True";
__ref._delneeded /*boolean*/  = __c.True;
 }else {
RDebugUtils.currentLine=8126485;
 //BA.debugLineNum = 8126485;BA.debugLine="DelNeeded = False";
__ref._delneeded /*boolean*/  = __c.False;
 };
 }}}
;
RDebugUtils.currentLine=8126488;
 //BA.debugLineNum = 8126488;BA.debugLine="End Sub";
return "";
}
public String  _initialize(b4j.HTMLEditorFix.b4xmainpage __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=524288;
 //BA.debugLineNum = 524288;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=524290;
 //BA.debugLineNum = 524290;BA.debugLine="jcKeyEvt.InitializeStatic(\"javafx.scene.input.Key";
__ref._jckeyevt /*anywheresoftware.b4j.object.JavaObject*/ .InitializeStatic("javafx.scene.input.KeyEvent");
RDebugUtils.currentLine=524291;
 //BA.debugLineNum = 524291;BA.debugLine="joKeyEvtKeyPressed = jcKeyEvt.GetFieldJO(\"KEY_PRE";
__ref._jokeyevtkeypressed /*anywheresoftware.b4j.object.JavaObject*/  = __ref._jckeyevt /*anywheresoftware.b4j.object.JavaObject*/ .GetFieldJO("KEY_PRESSED");
RDebugUtils.currentLine=524292;
 //BA.debugLineNum = 524292;BA.debugLine="joKeyEvtKeyReleased = jcKeyEvt.GetFieldJO(\"KEY_RE";
__ref._jokeyevtkeyreleased /*anywheresoftware.b4j.object.JavaObject*/  = __ref._jckeyevt /*anywheresoftware.b4j.object.JavaObject*/ .GetFieldJO("KEY_RELEASED");
RDebugUtils.currentLine=524293;
 //BA.debugLineNum = 524293;BA.debugLine="joKeyEvtKeyTyped = jcKeyEvt.GetFieldJO(\"KEY_TYPED";
__ref._jokeyevtkeytyped /*anywheresoftware.b4j.object.JavaObject*/  = __ref._jckeyevt /*anywheresoftware.b4j.object.JavaObject*/ .GetFieldJO("KEY_TYPED");
RDebugUtils.currentLine=524294;
 //BA.debugLineNum = 524294;BA.debugLine="End Sub";
return "";
}
}