package b4a.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xmainpage_subs_0 {


public static RemoteObject  _b4xpage_created(RemoteObject __ref,RemoteObject _root1) throws Exception{
try {
		Debug.PushSubsStack("B4XPage_Created (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,22);
if (RapidSub.canDelegate("b4xpage_created")) { return __ref.runUserSub(false, "b4xmainpage","b4xpage_created", __ref, _root1);}
int _i = 0;
RemoteObject _p = RemoteObject.declareNull("anywheresoftware.b4a.objects.PanelWrapper");
RemoteObject _l = RemoteObject.declareNull("anywheresoftware.b4a.objects.LabelWrapper");
Debug.locals.put("Root1", _root1);
 BA.debugLineNum = 22;BA.debugLine="Private Sub B4XPage_Created (Root1 As B4XView)";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 23;BA.debugLine="Root = Root1";
Debug.ShouldStop(4194304);
__ref.setField ("_root" /*RemoteObject*/ ,_root1);
 BA.debugLineNum = 24;BA.debugLine="Root.LoadLayout(\"MainPage\")";
Debug.ShouldStop(8388608);
__ref.getField(false,"_root" /*RemoteObject*/ ).runVoidMethodAndSync ("LoadLayout",(Object)(RemoteObject.createImmutable("MainPage")),__ref.getField(false, "ba"));
 BA.debugLineNum = 26;BA.debugLine="WobbleMenu1.SetTabTextIcon(1,\"Page 1\", Chr(0xE3D0";
Debug.ShouldStop(33554432);
__ref.getField(false,"_wobblemenu1" /*RemoteObject*/ ).runClassMethod (b4a.example.wobblemenu.class, "_settabtexticon" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 1)),(Object)(BA.ObjectToString("Page 1")),(Object)(BA.ObjectToString(b4xmainpage.__c.runMethod(true,"Chr",(Object)(BA.numberCast(int.class, 0xe3d0))))),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.keywords.constants.TypefaceWrapper"), b4xmainpage.__c.getField(false,"Typeface").runMethod(false,"getMATERIALICONS")));
 BA.debugLineNum = 27;BA.debugLine="WobbleMenu1.SetTabTextIcon(2,\"Page 2\", Chr(0xE3D1";
Debug.ShouldStop(67108864);
__ref.getField(false,"_wobblemenu1" /*RemoteObject*/ ).runClassMethod (b4a.example.wobblemenu.class, "_settabtexticon" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 2)),(Object)(BA.ObjectToString("Page 2")),(Object)(BA.ObjectToString(b4xmainpage.__c.runMethod(true,"Chr",(Object)(BA.numberCast(int.class, 0xe3d1))))),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.keywords.constants.TypefaceWrapper"), b4xmainpage.__c.getField(false,"Typeface").runMethod(false,"getMATERIALICONS")));
 BA.debugLineNum = 28;BA.debugLine="WobbleMenu1.SetTabTextIcon(3,\"Page 3\", Chr(0xE3D2";
Debug.ShouldStop(134217728);
__ref.getField(false,"_wobblemenu1" /*RemoteObject*/ ).runClassMethod (b4a.example.wobblemenu.class, "_settabtexticon" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 3)),(Object)(BA.ObjectToString("Page 3")),(Object)(BA.ObjectToString(b4xmainpage.__c.runMethod(true,"Chr",(Object)(BA.numberCast(int.class, 0xe3d2))))),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.keywords.constants.TypefaceWrapper"), b4xmainpage.__c.getField(false,"Typeface").runMethod(false,"getMATERIALICONS")));
 BA.debugLineNum = 29;BA.debugLine="WobbleMenu1.SetTabTextIcon(4,\"Page 4\", Chr(0xE3D4";
Debug.ShouldStop(268435456);
__ref.getField(false,"_wobblemenu1" /*RemoteObject*/ ).runClassMethod (b4a.example.wobblemenu.class, "_settabtexticon" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 4)),(Object)(BA.ObjectToString("Page 4")),(Object)(BA.ObjectToString(b4xmainpage.__c.runMethod(true,"Chr",(Object)(BA.numberCast(int.class, 0xe3d4))))),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.keywords.constants.TypefaceWrapper"), b4xmainpage.__c.getField(false,"Typeface").runMethod(false,"getMATERIALICONS")));
 BA.debugLineNum = 30;BA.debugLine="WobbleMenu1.SetTabTextIcon(5,\"Page 5\", Chr(0xE3D5";
Debug.ShouldStop(536870912);
__ref.getField(false,"_wobblemenu1" /*RemoteObject*/ ).runClassMethod (b4a.example.wobblemenu.class, "_settabtexticon" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, 5)),(Object)(BA.ObjectToString("Page 5")),(Object)(BA.ObjectToString(b4xmainpage.__c.runMethod(true,"Chr",(Object)(BA.numberCast(int.class, 0xe3d5))))),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.keywords.constants.TypefaceWrapper"), b4xmainpage.__c.getField(false,"Typeface").runMethod(false,"getMATERIALICONS")));
 BA.debugLineNum = 32;BA.debugLine="For i=0 To 4";
Debug.ShouldStop(-2147483648);
{
final int step8 = 1;
final int limit8 = 4;
_i = 0 ;
for (;(step8 > 0 && _i <= limit8) || (step8 < 0 && _i >= limit8) ;_i = ((int)(0 + _i + step8))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 33;BA.debugLine="Dim p As Panel = xui.CreatePanel(\"\")";
Debug.ShouldStop(1);
_p = RemoteObject.createNew ("anywheresoftware.b4a.objects.PanelWrapper");
_p = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.PanelWrapper"), __ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable(""))).getObject());Debug.locals.put("p", _p);
 BA.debugLineNum = 34;BA.debugLine="p.SetLayout(0,0,AHViewPager1.Width,AHViewPager1.";
Debug.ShouldStop(2);
_p.runVoidMethod ("SetLayout",(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(false,"_ahviewpager1" /*RemoteObject*/ ).runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_ahviewpager1" /*RemoteObject*/ ).runMethod(true,"getHeight")));
 BA.debugLineNum = 40;BA.debugLine="p.Color = Colors.LightGray";
Debug.ShouldStop(128);
_p.runVoidMethod ("setColor",b4xmainpage.__c.getField(false,"Colors").getField(true,"LightGray"));
 BA.debugLineNum = 41;BA.debugLine="Dim l As Label";
Debug.ShouldStop(256);
_l = RemoteObject.createNew ("anywheresoftware.b4a.objects.LabelWrapper");Debug.locals.put("l", _l);
 BA.debugLineNum = 42;BA.debugLine="l.Initialize(\"\")";
Debug.ShouldStop(512);
_l.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 43;BA.debugLine="l.Text = \"Page \"&(i+1)";
Debug.ShouldStop(1024);
_l.runMethod(true,"setText",BA.ObjectToCharSequence(RemoteObject.concat(RemoteObject.createImmutable("Page "),(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_i),RemoteObject.createImmutable(1)}, "+",1, 1)))));
 BA.debugLineNum = 44;BA.debugLine="l.Gravity = Gravity.CENTER";
Debug.ShouldStop(2048);
_l.runMethod(true,"setGravity",b4xmainpage.__c.getField(false,"Gravity").getField(true,"CENTER"));
 BA.debugLineNum = 45;BA.debugLine="l.TextColor = Colors.Black";
Debug.ShouldStop(4096);
_l.runMethod(true,"setTextColor",b4xmainpage.__c.getField(false,"Colors").getField(true,"Black"));
 BA.debugLineNum = 46;BA.debugLine="l.TextSize = 40";
Debug.ShouldStop(8192);
_l.runMethod(true,"setTextSize",BA.numberCast(float.class, 40));
 BA.debugLineNum = 47;BA.debugLine="p.AddView(l,0,0,AHViewPager1.Width,AHViewPager1.";
Debug.ShouldStop(16384);
_p.runVoidMethod ("AddView",(Object)((_l.getObject())),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(false,"_ahviewpager1" /*RemoteObject*/ ).runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_ahviewpager1" /*RemoteObject*/ ).runMethod(true,"getHeight")));
 BA.debugLineNum = 49;BA.debugLine="pagecont.AddPage(p,\"\")";
Debug.ShouldStop(65536);
__ref.getField(false,"_pagecont" /*RemoteObject*/ ).runVoidMethod ("AddPage",(Object)((_p.getObject())),(Object)(RemoteObject.createImmutable("")));
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 52;BA.debugLine="AHViewPager1.PageContainer = pagecont";
Debug.ShouldStop(524288);
__ref.getField(false,"_ahviewpager1" /*RemoteObject*/ ).runVoidMethod ("setPageContainer",__ref.getField(false,"_pagecont" /*RemoteObject*/ ));
 BA.debugLineNum = 53;BA.debugLine="AHViewPager1.CurrentPage = 2";
Debug.ShouldStop(1048576);
__ref.getField(false,"_ahviewpager1" /*RemoteObject*/ ).runMethod(true,"setCurrentPage",BA.numberCast(int.class, 2));
 BA.debugLineNum = 54;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
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
 //BA.debugLineNum = 11;BA.debugLine="Private AHViewPager1 As AHViewPager";
b4xmainpage._ahviewpager1 = RemoteObject.createNew ("de.amberhome.viewpager.AHViewPager");__ref.setField("_ahviewpager1",b4xmainpage._ahviewpager1);
 //BA.debugLineNum = 12;BA.debugLine="Private WobbleMenu1 As WobbleMenu";
b4xmainpage._wobblemenu1 = RemoteObject.createNew ("b4a.example.wobblemenu");__ref.setField("_wobblemenu1",b4xmainpage._wobblemenu1);
 //BA.debugLineNum = 14;BA.debugLine="Private pagecont As AHPageContainer";
b4xmainpage._pagecont = RemoteObject.createNew ("de.amberhome.viewpager.AHPageContainer");__ref.setField("_pagecont",b4xmainpage._pagecont);
 //BA.debugLineNum = 15;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,17);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "b4xmainpage","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 17;BA.debugLine="Public Sub Initialize";
Debug.ShouldStop(65536);
 BA.debugLineNum = 18;BA.debugLine="pagecont.Initialize";
Debug.ShouldStop(131072);
__ref.getField(false,"_pagecont" /*RemoteObject*/ ).runVoidMethod ("Initialize",__ref.getField(false, "ba"));
 BA.debugLineNum = 19;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _wobblemenu1_tab1click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("WobbleMenu1_Tab1Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,58);
if (RapidSub.canDelegate("wobblemenu1_tab1click")) { return __ref.runUserSub(false, "b4xmainpage","wobblemenu1_tab1click", __ref);}
 BA.debugLineNum = 58;BA.debugLine="Sub WobbleMenu1_Tab1Click";
Debug.ShouldStop(33554432);
 BA.debugLineNum = 59;BA.debugLine="AHViewPager1.GotoPage(0,True)";
Debug.ShouldStop(67108864);
__ref.getField(false,"_ahviewpager1" /*RemoteObject*/ ).runVoidMethodAndSync ("GotoPage",(Object)(BA.numberCast(int.class, 0)),(Object)(b4xmainpage.__c.getField(true,"True")));
 BA.debugLineNum = 60;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _wobblemenu1_tab2click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("WobbleMenu1_Tab2Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,62);
if (RapidSub.canDelegate("wobblemenu1_tab2click")) { return __ref.runUserSub(false, "b4xmainpage","wobblemenu1_tab2click", __ref);}
 BA.debugLineNum = 62;BA.debugLine="Sub WobbleMenu1_Tab2Click";
Debug.ShouldStop(536870912);
 BA.debugLineNum = 63;BA.debugLine="AHViewPager1.GotoPage(1,True)";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_ahviewpager1" /*RemoteObject*/ ).runVoidMethodAndSync ("GotoPage",(Object)(BA.numberCast(int.class, 1)),(Object)(b4xmainpage.__c.getField(true,"True")));
 BA.debugLineNum = 64;BA.debugLine="End Sub";
Debug.ShouldStop(-2147483648);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _wobblemenu1_tab3click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("WobbleMenu1_Tab3Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,66);
if (RapidSub.canDelegate("wobblemenu1_tab3click")) { return __ref.runUserSub(false, "b4xmainpage","wobblemenu1_tab3click", __ref);}
 BA.debugLineNum = 66;BA.debugLine="Sub WobbleMenu1_Tab3Click";
Debug.ShouldStop(2);
 BA.debugLineNum = 67;BA.debugLine="AHViewPager1.GotoPage(2,True)";
Debug.ShouldStop(4);
__ref.getField(false,"_ahviewpager1" /*RemoteObject*/ ).runVoidMethodAndSync ("GotoPage",(Object)(BA.numberCast(int.class, 2)),(Object)(b4xmainpage.__c.getField(true,"True")));
 BA.debugLineNum = 68;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _wobblemenu1_tab4click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("WobbleMenu1_Tab4Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,70);
if (RapidSub.canDelegate("wobblemenu1_tab4click")) { return __ref.runUserSub(false, "b4xmainpage","wobblemenu1_tab4click", __ref);}
 BA.debugLineNum = 70;BA.debugLine="Sub WobbleMenu1_Tab4Click";
Debug.ShouldStop(32);
 BA.debugLineNum = 71;BA.debugLine="AHViewPager1.GotoPage(3,True)";
Debug.ShouldStop(64);
__ref.getField(false,"_ahviewpager1" /*RemoteObject*/ ).runVoidMethodAndSync ("GotoPage",(Object)(BA.numberCast(int.class, 3)),(Object)(b4xmainpage.__c.getField(true,"True")));
 BA.debugLineNum = 72;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _wobblemenu1_tab5click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("WobbleMenu1_Tab5Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,74);
if (RapidSub.canDelegate("wobblemenu1_tab5click")) { return __ref.runUserSub(false, "b4xmainpage","wobblemenu1_tab5click", __ref);}
 BA.debugLineNum = 74;BA.debugLine="Sub WobbleMenu1_Tab5Click";
Debug.ShouldStop(512);
 BA.debugLineNum = 75;BA.debugLine="AHViewPager1.GotoPage(4,True)";
Debug.ShouldStop(1024);
__ref.getField(false,"_ahviewpager1" /*RemoteObject*/ ).runVoidMethodAndSync ("GotoPage",(Object)(BA.numberCast(int.class, 4)),(Object)(b4xmainpage.__c.getField(true,"True")));
 BA.debugLineNum = 76;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}