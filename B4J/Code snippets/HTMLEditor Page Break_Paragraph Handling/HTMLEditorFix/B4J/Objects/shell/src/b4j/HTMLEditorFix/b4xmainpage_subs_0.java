package b4j.HTMLEditorFix;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xmainpage_subs_0 {


public static RemoteObject  _b4xpage_created(RemoteObject __ref,RemoteObject _root1) throws Exception{
try {
		Debug.PushSubsStack("B4XPage_Created (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,32);
if (RapidSub.canDelegate("b4xpage_created")) { return __ref.runUserSub(false, "b4xmainpage","b4xpage_created", __ref, _root1);}
RemoteObject _sb = RemoteObject.declareNull("anywheresoftware.b4a.keywords.StringBuilderWrapper");
RemoteObject _r = RemoteObject.declareNull("anywheresoftware.b4j.agraham.reflection.Reflection");
Debug.locals.put("Root1", _root1);
 BA.debugLineNum = 32;BA.debugLine="Private Sub B4XPage_Created (Root1 As B4XView)";
Debug.ShouldStop(-2147483648);
 BA.debugLineNum = 33;BA.debugLine="Root = Root1";
Debug.ShouldStop(1);
__ref.setField ("_root" /*RemoteObject*/ ,_root1);
 BA.debugLineNum = 34;BA.debugLine="Root.LoadLayout(\"MainPage\")";
Debug.ShouldStop(2);
__ref.getField(false,"_root" /*RemoteObject*/ ).runVoidMethodAndSync ("LoadLayout",(Object)(RemoteObject.createImmutable("MainPage")),__ref.getField(false, "ba"));
 BA.debugLineNum = 36;BA.debugLine="Dim sb As StringBuilder";
Debug.ShouldStop(8);
_sb = RemoteObject.createNew ("anywheresoftware.b4a.keywords.StringBuilderWrapper");Debug.locals.put("sb", _sb);
 BA.debugLineNum = 37;BA.debugLine="sb.Initialize";
Debug.ShouldStop(16);
_sb.runVoidMethod ("Initialize");
 BA.debugLineNum = 38;BA.debugLine="sb.Append(\"<html dir=\").Append(Quoted(\"ltr\")).App";
Debug.ShouldStop(32);
_sb.runMethod(false,"Append",(Object)(RemoteObject.createImmutable("<html dir="))).runMethod(false,"Append",(Object)(__ref.runClassMethod (b4j.HTMLEditorFix.b4xmainpage.class, "_quoted" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("ltr"))))).runVoidMethod ("Append",(Object)(RemoteObject.createImmutable("><head>")));
 BA.debugLineNum = 40;BA.debugLine="sb.Append(\"<style type=\").Append(Quoted(\"text/css";
Debug.ShouldStop(128);
_sb.runMethod(false,"Append",(Object)(RemoteObject.createImmutable("<style type="))).runMethod(false,"Append",(Object)(__ref.runClassMethod (b4j.HTMLEditorFix.b4xmainpage.class, "_quoted" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("text/css"))))).runMethod(false,"Append",(Object)(RemoteObject.createImmutable(">"))).runMethod(false,"Append",(Object)(RemoteObject.createImmutable("div {display: inline;} p {display: inline;}"))).runVoidMethod ("Append",(Object)(RemoteObject.createImmutable("</style></head>")));
 BA.debugLineNum = 41;BA.debugLine="sb.Append(\"<body contenteditable=\").Append(Quoted";
Debug.ShouldStop(256);
_sb.runMethod(false,"Append",(Object)(RemoteObject.createImmutable("<body contenteditable="))).runMethod(false,"Append",(Object)(__ref.runClassMethod (b4j.HTMLEditorFix.b4xmainpage.class, "_quoted" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("true"))))).runVoidMethod ("Append",(Object)(RemoteObject.createImmutable(">")));
 BA.debugLineNum = 42;BA.debugLine="edHTML.As(HTMLEditor).HTMLText = sb.Append(\"</bod";
Debug.ShouldStop(512);
(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.HTMLEditorWrapper"), __ref.getField(false,"_edhtml" /*RemoteObject*/ ).getObject())).runMethod(true,"setHtmlText",_sb.runMethod(false,"Append",(Object)(RemoteObject.createImmutable("</body></html>"))).runMethod(true,"ToString"));
 BA.debugLineNum = 44;BA.debugLine="Dim r As Reflector";
Debug.ShouldStop(2048);
_r = RemoteObject.createNew ("anywheresoftware.b4j.agraham.reflection.Reflection");Debug.locals.put("r", _r);
 BA.debugLineNum = 45;BA.debugLine="r.Target = edHTML";
Debug.ShouldStop(4096);
_r.setField ("Target",(__ref.getField(false,"_edhtml" /*RemoteObject*/ ).getObject()));
 BA.debugLineNum = 46;BA.debugLine="r.AddEventFilter(\"HTMLKey\", \"javafx.scene.input.K";
Debug.ShouldStop(8192);
_r.runVoidMethod ("AddEventFilter",__ref.getField(false, "ba"),(Object)(BA.ObjectToString("HTMLKey")),(Object)(RemoteObject.createImmutable("javafx.scene.input.KeyEvent.ANY")));
 BA.debugLineNum = 47;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 8;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 9;BA.debugLine="Private Root As B4XView";
b4xmainpage._root = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_root",b4xmainpage._root);
 //BA.debugLineNum = 10;BA.debugLine="Private xui As XUI";
b4xmainpage._xui = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");__ref.setField("_xui",b4xmainpage._xui);
 //BA.debugLineNum = 11;BA.debugLine="Private Robot As AWTRobot";
b4xmainpage._robot = RemoteObject.createNew ("butt.droid.awtRobot.AWTRobot");__ref.setField("_robot",b4xmainpage._robot);
 //BA.debugLineNum = 12;BA.debugLine="Private edHTML As B4XView";
b4xmainpage._edhtml = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_edhtml",b4xmainpage._edhtml);
 //BA.debugLineNum = 14;BA.debugLine="Private jcKeyEvt As JavaObject";
b4xmainpage._jckeyevt = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");__ref.setField("_jckeyevt",b4xmainpage._jckeyevt);
 //BA.debugLineNum = 15;BA.debugLine="Private joKeyEvtKeyPressed As JavaObject";
b4xmainpage._jokeyevtkeypressed = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");__ref.setField("_jokeyevtkeypressed",b4xmainpage._jokeyevtkeypressed);
 //BA.debugLineNum = 16;BA.debugLine="Private joKeyEvtKeyReleased As JavaObject";
b4xmainpage._jokeyevtkeyreleased = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");__ref.setField("_jokeyevtkeyreleased",b4xmainpage._jokeyevtkeyreleased);
 //BA.debugLineNum = 17;BA.debugLine="Private joKeyEvtKeyTyped As JavaObject";
b4xmainpage._jokeyevtkeytyped = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");__ref.setField("_jokeyevtkeytyped",b4xmainpage._jokeyevtkeytyped);
 //BA.debugLineNum = 19;BA.debugLine="Private CRComing As Boolean";
b4xmainpage._crcoming = RemoteObject.createImmutable(false);__ref.setField("_crcoming",b4xmainpage._crcoming);
 //BA.debugLineNum = 20;BA.debugLine="Private DelNeeded As Boolean";
b4xmainpage._delneeded = RemoteObject.createImmutable(false);__ref.setField("_delneeded",b4xmainpage._delneeded);
 //BA.debugLineNum = 21;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _htmlkey_filter(RemoteObject __ref,RemoteObject _e) throws Exception{
try {
		Debug.PushSubsStack("HTMLKey_Filter (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,51);
if (RapidSub.canDelegate("htmlkey_filter")) { return __ref.runUserSub(false, "b4xmainpage","htmlkey_filter", __ref, _e);}
RemoteObject _joevt = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _jotype = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _code = RemoteObject.createImmutable("");
Debug.locals.put("e", _e);
 BA.debugLineNum = 51;BA.debugLine="Private Sub HTMLKey_Filter(e As Event)";
Debug.ShouldStop(262144);
 BA.debugLineNum = 52;BA.debugLine="Private joEvt As JavaObject = e";
Debug.ShouldStop(524288);
_joevt = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_joevt = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _e.getObject());Debug.locals.put("joEvt", _joevt);Debug.locals.put("joEvt", _joevt);
 BA.debugLineNum = 53;BA.debugLine="Private joType As JavaObject = joEvt.RunMethod(\"g";
Debug.ShouldStop(1048576);
_jotype = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_jotype = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _joevt.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getEventType")),(Object)((b4xmainpage.__c.getField(false,"Null")))));Debug.locals.put("joType", _jotype);Debug.locals.put("joType", _jotype);
 BA.debugLineNum = 54;BA.debugLine="If joType = joKeyEvtKeyPressed Then 'Consume the";
Debug.ShouldStop(2097152);
if (RemoteObject.solveBoolean("=",_jotype,__ref.getField(false,"_jokeyevtkeypressed" /*RemoteObject*/ ))) { 
 BA.debugLineNum = 55;BA.debugLine="If DelNeeded Then 'Get ahead of the extra space";
Debug.ShouldStop(4194304);
if (__ref.getField(true,"_delneeded" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 56;BA.debugLine="DelNeeded = False";
Debug.ShouldStop(8388608);
__ref.setField ("_delneeded" /*RemoteObject*/ ,b4xmainpage.__c.getField(true,"False"));
 BA.debugLineNum = 57;BA.debugLine="Robot.RobotSpecialKeyPress(\"left_arrow\")";
Debug.ShouldStop(16777216);
__ref.getField(false,"_robot" /*RemoteObject*/ ).runVoidMethod ("RobotSpecialKeyPress",(Object)(RemoteObject.createImmutable("left_arrow")));
 BA.debugLineNum = 58;BA.debugLine="Robot.RobotSpecialKeyRelease(\"left_arrow\")";
Debug.ShouldStop(33554432);
__ref.getField(false,"_robot" /*RemoteObject*/ ).runVoidMethod ("RobotSpecialKeyRelease",(Object)(RemoteObject.createImmutable("left_arrow")));
 };
 BA.debugLineNum = 60;BA.debugLine="Private Code As String = joEvt.RunMethodJO(\"getC";
Debug.ShouldStop(134217728);
_code = BA.ObjectToString(_joevt.runMethod(false,"RunMethodJO",(Object)(BA.ObjectToString("getCode")),(Object)((b4xmainpage.__c.getField(false,"Null")))).runMethod(false,"RunMethod",(Object)(BA.ObjectToString("toString")),(Object)((b4xmainpage.__c.getField(false,"Null")))));Debug.locals.put("Code", _code);Debug.locals.put("Code", _code);
 BA.debugLineNum = 61;BA.debugLine="CRComing = Code.EqualsIgnoreCase(\"enter\")";
Debug.ShouldStop(268435456);
__ref.setField ("_crcoming" /*RemoteObject*/ ,_code.runMethod(true,"equalsIgnoreCase",(Object)(RemoteObject.createImmutable("enter"))));
 BA.debugLineNum = 62;BA.debugLine="If CRComing Then e.Consume";
Debug.ShouldStop(536870912);
if (__ref.getField(true,"_crcoming" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
_e.runVoidMethod ("Consume");};
 }else 
{ BA.debugLineNum = 63;BA.debugLine="Else If joType = joKeyEvtKeyTyped Then";
Debug.ShouldStop(1073741824);
if (RemoteObject.solveBoolean("=",_jotype,__ref.getField(false,"_jokeyevtkeytyped" /*RemoteObject*/ ))) { 
 BA.debugLineNum = 64;BA.debugLine="If CRComing Then e.Consume";
Debug.ShouldStop(-2147483648);
if (__ref.getField(true,"_crcoming" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
_e.runVoidMethod ("Consume");};
 }else 
{ BA.debugLineNum = 65;BA.debugLine="Else If joType = joKeyEvtKeyReleased Then";
Debug.ShouldStop(1);
if (RemoteObject.solveBoolean("=",_jotype,__ref.getField(false,"_jokeyevtkeyreleased" /*RemoteObject*/ ))) { 
 BA.debugLineNum = 66;BA.debugLine="If CRComing Then";
Debug.ShouldStop(2);
if (__ref.getField(true,"_crcoming" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 67;BA.debugLine="CRComing = False";
Debug.ShouldStop(4);
__ref.setField ("_crcoming" /*RemoteObject*/ ,b4xmainpage.__c.getField(true,"False"));
 BA.debugLineNum = 68;BA.debugLine="e.Consume";
Debug.ShouldStop(8);
_e.runVoidMethod ("Consume");
 BA.debugLineNum = 69;BA.debugLine="Robot.RobotPaste2(CRLF & \" \") 'The extra space";
Debug.ShouldStop(16);
__ref.getField(false,"_robot" /*RemoteObject*/ ).runVoidMethod ("RobotPaste2",(Object)(RemoteObject.concat(b4xmainpage.__c.getField(true,"CRLF"),RemoteObject.createImmutable(" "))));
 BA.debugLineNum = 70;BA.debugLine="DelNeeded = True";
Debug.ShouldStop(32);
__ref.setField ("_delneeded" /*RemoteObject*/ ,b4xmainpage.__c.getField(true,"True"));
 }else {
 BA.debugLineNum = 72;BA.debugLine="DelNeeded = False";
Debug.ShouldStop(128);
__ref.setField ("_delneeded" /*RemoteObject*/ ,b4xmainpage.__c.getField(true,"False"));
 };
 }}}
;
 BA.debugLineNum = 75;BA.debugLine="End Sub";
Debug.ShouldStop(1024);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,23);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "b4xmainpage","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 23;BA.debugLine="Public Sub Initialize";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 25;BA.debugLine="jcKeyEvt.InitializeStatic(\"javafx.scene.input.Key";
Debug.ShouldStop(16777216);
__ref.getField(false,"_jckeyevt" /*RemoteObject*/ ).runVoidMethod ("InitializeStatic",(Object)(RemoteObject.createImmutable("javafx.scene.input.KeyEvent")));
 BA.debugLineNum = 26;BA.debugLine="joKeyEvtKeyPressed = jcKeyEvt.GetFieldJO(\"KEY_PRE";
Debug.ShouldStop(33554432);
__ref.setField ("_jokeyevtkeypressed" /*RemoteObject*/ ,__ref.getField(false,"_jckeyevt" /*RemoteObject*/ ).runMethod(false,"GetFieldJO",(Object)(RemoteObject.createImmutable("KEY_PRESSED"))));
 BA.debugLineNum = 27;BA.debugLine="joKeyEvtKeyReleased = jcKeyEvt.GetFieldJO(\"KEY_RE";
Debug.ShouldStop(67108864);
__ref.setField ("_jokeyevtkeyreleased" /*RemoteObject*/ ,__ref.getField(false,"_jckeyevt" /*RemoteObject*/ ).runMethod(false,"GetFieldJO",(Object)(RemoteObject.createImmutable("KEY_RELEASED"))));
 BA.debugLineNum = 28;BA.debugLine="joKeyEvtKeyTyped = jcKeyEvt.GetFieldJO(\"KEY_TYPED";
Debug.ShouldStop(134217728);
__ref.setField ("_jokeyevtkeytyped" /*RemoteObject*/ ,__ref.getField(false,"_jckeyevt" /*RemoteObject*/ ).runMethod(false,"GetFieldJO",(Object)(RemoteObject.createImmutable("KEY_TYPED"))));
 BA.debugLineNum = 29;BA.debugLine="End Sub";
Debug.ShouldStop(268435456);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _quoted(RemoteObject __ref,RemoteObject _s) throws Exception{
try {
		Debug.PushSubsStack("Quoted (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,77);
if (RapidSub.canDelegate("quoted")) { return __ref.runUserSub(false, "b4xmainpage","quoted", __ref, _s);}
Debug.locals.put("s", _s);
 BA.debugLineNum = 77;BA.debugLine="Private Sub Quoted(s As String) As String";
Debug.ShouldStop(4096);
 BA.debugLineNum = 78;BA.debugLine="If s.Length = 0 Then Return QUOTE & QUOTE";
Debug.ShouldStop(8192);
if (RemoteObject.solveBoolean("=",_s.runMethod(true,"length"),BA.numberCast(double.class, 0))) { 
if (true) return RemoteObject.concat(b4xmainpage.__c.getField(true,"QUOTE"),b4xmainpage.__c.getField(true,"QUOTE"));};
 BA.debugLineNum = 79;BA.debugLine="If Not(s.StartsWith(QUOTE)) Then s = QUOTE & s";
Debug.ShouldStop(16384);
if (b4xmainpage.__c.runMethod(true,"Not",(Object)(_s.runMethod(true,"startsWith",(Object)(b4xmainpage.__c.getField(true,"QUOTE"))))).<Boolean>get().booleanValue()) { 
_s = RemoteObject.concat(b4xmainpage.__c.getField(true,"QUOTE"),_s);Debug.locals.put("s", _s);};
 BA.debugLineNum = 80;BA.debugLine="Return IIf(s.EndsWith(QUOTE), s, s & QUOTE)";
Debug.ShouldStop(32768);
if (true) return BA.ObjectToString(((_s.runMethod(true,"endsWith",(Object)(b4xmainpage.__c.getField(true,"QUOTE"))).<Boolean>get().booleanValue()) ? ((_s)) : ((RemoteObject.concat(_s,b4xmainpage.__c.getField(true,"QUOTE"))))));
 BA.debugLineNum = 81;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}