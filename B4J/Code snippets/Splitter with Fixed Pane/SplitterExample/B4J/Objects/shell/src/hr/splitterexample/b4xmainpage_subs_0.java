package hr.splitterexample;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xmainpage_subs_0 {


public static RemoteObject  _b4xpage_created(RemoteObject __ref,RemoteObject _root1) throws Exception{
try {
		Debug.PushSubsStack("B4XPage_Created (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,31);
if (RapidSub.canDelegate("b4xpage_created")) { return __ref.runUserSub(false, "b4xmainpage","b4xpage_created", __ref, _root1);}
Debug.locals.put("Root1", _root1);
 BA.debugLineNum = 31;BA.debugLine="Private Sub B4XPage_Created (Root1 As B4XView)";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 32;BA.debugLine="Root = Root1";
Debug.ShouldStop(-2147483648);
__ref.setField ("_root" /*RemoteObject*/ ,_root1);
 BA.debugLineNum = 34;BA.debugLine="B4XPages.SetTitle(Me, \"Splitter Example\")";
Debug.ShouldStop(2);
b4xmainpage._b4xpages.runVoidMethod ("_settitle" /*RemoteObject*/ ,(Object)(__ref),(Object)((RemoteObject.createImmutable("Splitter Example"))));
 BA.debugLineNum = 36;BA.debugLine="VerticalSplitter.Initialize(Root, splLeft, \"Verti";
Debug.ShouldStop(8);
__ref.getField(false,"_verticalsplitter" /*RemoteObject*/ ).runClassMethod (hr.splitterexample.csplitter.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_root" /*RemoteObject*/ )),(Object)(__ref.getField(true,"_splleft" /*RemoteObject*/ )),(Object)(RemoteObject.createImmutable("VerticalSplitter")));
 BA.debugLineNum = 37;BA.debugLine="HorizontalSplitter.Initialize(VerticalSplitter.Fl";
Debug.ShouldStop(16);
__ref.getField(false,"_horizontalsplitter" /*RemoteObject*/ ).runClassMethod (hr.splitterexample.csplitter.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_verticalsplitter" /*RemoteObject*/ ).getField(false,"_flexpanel" /*RemoteObject*/ )),(Object)(__ref.getField(true,"_spltop" /*RemoteObject*/ )),(Object)(RemoteObject.createImmutable("HorizontalSplitter")));
 BA.debugLineNum = 39;BA.debugLine="VerticalSplitter.FixedPanel.LoadLayout(\"MainPage\"";
Debug.ShouldStop(64);
__ref.getField(false,"_verticalsplitter" /*RemoteObject*/ ).getField(false,"_fixedpanel" /*RemoteObject*/ ).runVoidMethodAndSync ("LoadLayout",(Object)(RemoteObject.createImmutable("MainPage")),__ref.getField(false, "ba"));
 BA.debugLineNum = 40;BA.debugLine="HorizontalSplitter.FixedPanel.LoadLayout(\"HorzTop";
Debug.ShouldStop(128);
__ref.getField(false,"_horizontalsplitter" /*RemoteObject*/ ).getField(false,"_fixedpanel" /*RemoteObject*/ ).runVoidMethodAndSync ("LoadLayout",(Object)(RemoteObject.createImmutable("HorzTop")),__ref.getField(false, "ba"));
 BA.debugLineNum = 41;BA.debugLine="HorizontalSplitter.FlexPanel.LoadLayout(\"HorzBott";
Debug.ShouldStop(256);
__ref.getField(false,"_horizontalsplitter" /*RemoteObject*/ ).getField(false,"_flexpanel" /*RemoteObject*/ ).runVoidMethodAndSync ("LoadLayout",(Object)(RemoteObject.createImmutable("HorzBottom")),__ref.getField(false, "ba"));
 BA.debugLineNum = 43;BA.debugLine="End Sub";
Debug.ShouldStop(1024);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _button1_click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Button1_Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,47);
if (RapidSub.canDelegate("button1_click")) { return __ref.runUserSub(false, "b4xmainpage","button1_click", __ref);}
 BA.debugLineNum = 47;BA.debugLine="Private Sub Button1_Click";
Debug.ShouldStop(16384);
 BA.debugLineNum = 48;BA.debugLine="xui.MsgboxAsync(\"Hello world!\", \"B4X\")";
Debug.ShouldStop(32768);
__ref.getField(false,"_xui" /*RemoteObject*/ ).runVoidMethod ("MsgboxAsync",__ref.getField(false, "ba"),(Object)(BA.ObjectToString("Hello world!")),(Object)(RemoteObject.createImmutable("B4X")));
 BA.debugLineNum = 49;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
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
 //BA.debugLineNum = 12;BA.debugLine="Public Const splDefault As Int = -1";
b4xmainpage._spldefault = BA.numberCast(int.class, -(double) (0 + 1));__ref.setField("_spldefault",b4xmainpage._spldefault);
 //BA.debugLineNum = 13;BA.debugLine="Public Const splLeft As Int = 0";
b4xmainpage._splleft = BA.numberCast(int.class, 0);__ref.setField("_splleft",b4xmainpage._splleft);
 //BA.debugLineNum = 14;BA.debugLine="Public Const splRight As Int = 1";
b4xmainpage._splright = BA.numberCast(int.class, 1);__ref.setField("_splright",b4xmainpage._splright);
 //BA.debugLineNum = 15;BA.debugLine="Public Const splTop As Int = 2";
b4xmainpage._spltop = BA.numberCast(int.class, 2);__ref.setField("_spltop",b4xmainpage._spltop);
 //BA.debugLineNum = 16;BA.debugLine="Public Const splBottom As Int = 3";
b4xmainpage._splbottom = BA.numberCast(int.class, 3);__ref.setField("_splbottom",b4xmainpage._splbottom);
 //BA.debugLineNum = 18;BA.debugLine="Public KVS As KeyValueStore";
b4xmainpage._kvs = RemoteObject.createNew ("hr.splitterexample.keyvaluestore");__ref.setField("_kvs",b4xmainpage._kvs);
 //BA.debugLineNum = 20;BA.debugLine="Private VerticalSplitter As cSplitter";
b4xmainpage._verticalsplitter = RemoteObject.createNew ("hr.splitterexample.csplitter");__ref.setField("_verticalsplitter",b4xmainpage._verticalsplitter);
 //BA.debugLineNum = 21;BA.debugLine="Private HorizontalSplitter As cSplitter";
b4xmainpage._horizontalsplitter = RemoteObject.createNew ("hr.splitterexample.csplitter");__ref.setField("_horizontalsplitter",b4xmainpage._horizontalsplitter);
 //BA.debugLineNum = 22;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,24);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "b4xmainpage","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 24;BA.debugLine="Public Sub Initialize";
Debug.ShouldStop(8388608);
 BA.debugLineNum = 26;BA.debugLine="xui.SetDataFolder(\"SplitterExample\")";
Debug.ShouldStop(33554432);
__ref.getField(false,"_xui" /*RemoteObject*/ ).runVoidMethod ("SetDataFolder",(Object)(RemoteObject.createImmutable("SplitterExample")));
 BA.debugLineNum = 27;BA.debugLine="KVS.Initialize(xui.DefaultFolder, \"Options.kvs\")";
Debug.ShouldStop(67108864);
__ref.getField(false,"_kvs" /*RemoteObject*/ ).runClassMethod (hr.splitterexample.keyvaluestore.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"getDefaultFolder")),(Object)(RemoteObject.createImmutable("Options.kvs")));
 BA.debugLineNum = 28;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}