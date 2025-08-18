package b4a.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class wobblemenu_subs_0 {


public static void  _animateto(RemoteObject __ref,RemoteObject _element,RemoteObject _newpos) throws Exception{
try {
		Debug.PushSubsStack("AnimateTo (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,591);
if (RapidSub.canDelegate("animateto")) { __ref.runUserSub(false, "wobblemenu","animateto", __ref, _element, _newpos); return;}
ResumableSub_AnimateTo rsub = new ResumableSub_AnimateTo(null,__ref,_element,_newpos);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_AnimateTo extends BA.ResumableSub {
public ResumableSub_AnimateTo(b4a.example.wobblemenu parent,RemoteObject __ref,RemoteObject _element,RemoteObject _newpos) {
this.parent = parent;
this.__ref = __ref;
this._element = _element;
this._newpos = _newpos;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4a.example.wobblemenu parent;
RemoteObject _element;
RemoteObject _newpos;
RemoteObject _n = RemoteObject.createImmutable(0L);
RemoteObject _duration = RemoteObject.createImmutable(0);
RemoteObject _currentpos = RemoteObject.createImmutable(0);
RemoteObject _start = RemoteObject.createImmutable(0f);
RemoteObject _tempvalue = RemoteObject.createImmutable(0f);

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("AnimateTo (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,591);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
Debug.locals.put("_ref", __ref);
Debug.locals.put("Element", _element);
Debug.locals.put("NewPos", _newpos);
 BA.debugLineNum = 592;BA.debugLine="Dim n As Long = DateTime.Now";
Debug.ShouldStop(32768);
_n = parent.__c.getField(false,"DateTime").runMethod(true,"getNow");Debug.locals.put("n", _n);Debug.locals.put("n", _n);
 BA.debugLineNum = 593;BA.debugLine="Dim duration As Int = animDuration";
Debug.ShouldStop(65536);
_duration = __ref.getField(true,"_animduration" /*RemoteObject*/ );Debug.locals.put("duration", _duration);Debug.locals.put("duration", _duration);
 BA.debugLineNum = 594;BA.debugLine="Dim currentPos As Int = Element.left";
Debug.ShouldStop(131072);
_currentpos = _element.runMethod(true,"getLeft");Debug.locals.put("currentPos", _currentpos);Debug.locals.put("currentPos", _currentpos);
 BA.debugLineNum = 595;BA.debugLine="Dim start As Float = currentPos";
Debug.ShouldStop(262144);
_start = BA.numberCast(float.class, _currentpos);Debug.locals.put("start", _start);Debug.locals.put("start", _start);
 BA.debugLineNum = 596;BA.debugLine="currentPos = NewPos";
Debug.ShouldStop(524288);
_currentpos = _newpos;Debug.locals.put("currentPos", _currentpos);
 BA.debugLineNum = 597;BA.debugLine="Dim tempValue As Float";
Debug.ShouldStop(1048576);
_tempvalue = RemoteObject.createImmutable(0f);Debug.locals.put("tempValue", _tempvalue);
 BA.debugLineNum = 598;BA.debugLine="Do While DateTime.Now < n + duration";
Debug.ShouldStop(2097152);
if (true) break;

case 1:
//do while
this.state = 10;
while (RemoteObject.solveBoolean("<",parent.__c.getField(false,"DateTime").runMethod(true,"getNow"),RemoteObject.solve(new RemoteObject[] {_n,_duration}, "+",1, 2))) {
this.state = 3;
if (true) break;
}
if (true) break;

case 3:
//C
this.state = 4;
 BA.debugLineNum = 599;BA.debugLine="tempValue = TimeWisePosition(DateTime.Now - n, s";
Debug.ShouldStop(4194304);
_tempvalue = BA.numberCast(float.class, __ref.runClassMethod (b4a.example.wobblemenu.class, "_timewiseposition" /*RemoteObject*/ ,(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {parent.__c.getField(false,"DateTime").runMethod(true,"getNow"),_n}, "-",1, 2))),(Object)(_start),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_newpos,_start}, "-",1, 0))),(Object)(_duration)));Debug.locals.put("tempValue", _tempvalue);
 BA.debugLineNum = 600;BA.debugLine="Element.left=tempValue";
Debug.ShouldStop(8388608);
_element.runMethod(true,"setLeft",BA.numberCast(int.class, _tempvalue));
 BA.debugLineNum = 601;BA.debugLine="Sleep(1)";
Debug.ShouldStop(16777216);
parent.__c.runVoidMethod ("Sleep",__ref.getField(false, "ba"),anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "wobblemenu", "animateto"),BA.numberCast(int.class, 1));
this.state = 11;
return;
case 11:
//C
this.state = 4;
;
 BA.debugLineNum = 602;BA.debugLine="If NewPos <> currentPos Then Return";
Debug.ShouldStop(33554432);
if (true) break;

case 4:
//if
this.state = 9;
if (RemoteObject.solveBoolean("!",_newpos,_currentpos)) { 
this.state = 6;
;}if (true) break;

case 6:
//C
this.state = 9;
if (true) return ;
if (true) break;

case 9:
//C
this.state = 1;
;
 if (true) break;

case 10:
//C
this.state = -1;
;
 BA.debugLineNum = 604;BA.debugLine="Element.Left = currentPos";
Debug.ShouldStop(134217728);
_element.runMethod(true,"setLeft",_currentpos);
 BA.debugLineNum = 605;BA.debugLine="End Sub";
Debug.ShouldStop(268435456);
if (true) break;

            }
        }
    }
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}
public static RemoteObject  _base_resize(RemoteObject __ref,RemoteObject _width,RemoteObject _height) throws Exception{
try {
		Debug.PushSubsStack("Base_Resize (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,117);
if (RapidSub.canDelegate("base_resize")) { return __ref.runUserSub(false, "wobblemenu","base_resize", __ref, _width, _height);}
Debug.locals.put("Width", _width);
Debug.locals.put("Height", _height);
 BA.debugLineNum = 117;BA.debugLine="Private Sub Base_Resize (Width As Double, Height A";
Debug.ShouldStop(1048576);
 BA.debugLineNum = 118;BA.debugLine="mBase.Width = Width";
Debug.ShouldStop(2097152);
__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"setWidth",BA.numberCast(int.class, _width));
 BA.debugLineNum = 119;BA.debugLine="AbsoluteWidth= Min(mBase.Parent.Width,mBase.Paren";
Debug.ShouldStop(4194304);
__ref.setField ("_absolutewidth" /*RemoteObject*/ ,BA.numberCast(int.class, wobblemenu.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, __ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(false,"getParent").runMethod(true,"getWidth"))),(Object)(BA.numberCast(double.class, __ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(false,"getParent").runMethod(true,"getHeight"))))));
 BA.debugLineNum = 120;BA.debugLine="MenuHeight = (AbsoluteWidth/7) + ((AbsoluteWidth/";
Debug.ShouldStop(8388608);
__ref.setField ("_menuheight" /*RemoteObject*/ ,BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_absolutewidth" /*RemoteObject*/ ),RemoteObject.createImmutable(7)}, "/",0, 0)),(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_absolutewidth" /*RemoteObject*/ ),RemoteObject.createImmutable(7)}, "/",0, 0)),RemoteObject.createImmutable(4)}, "/",0, 0))}, "+",1, 0)));
 BA.debugLineNum = 121;BA.debugLine="mBase.Height = MenuHeight";
Debug.ShouldStop(16777216);
__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"setHeight",__ref.getField(true,"_menuheight" /*RemoteObject*/ ));
 BA.debugLineNum = 122;BA.debugLine="mBase.Top = mBase.Parent.Height - mBase.Height";
Debug.ShouldStop(33554432);
__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(false,"getParent").runMethod(true,"getHeight"),__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"getHeight")}, "-",1, 1));
 BA.debugLineNum = 123;BA.debugLine="circleRadius = AbsoluteWidth/7";
Debug.ShouldStop(67108864);
__ref.setField ("_circleradius" /*RemoteObject*/ ,BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_absolutewidth" /*RemoteObject*/ ),RemoteObject.createImmutable(7)}, "/",0, 0)));
 BA.debugLineNum = 125;BA.debugLine="DrawView";
Debug.ShouldStop(268435456);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_drawview" /*RemoteObject*/ );
 BA.debugLineNum = 126;BA.debugLine="End Sub";
Debug.ShouldStop(536870912);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 22;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 23;BA.debugLine="Private mEventName As String 'ignore";
wobblemenu._meventname = RemoteObject.createImmutable("");__ref.setField("_meventname",wobblemenu._meventname);
 //BA.debugLineNum = 24;BA.debugLine="Private mCallBack As Object 'ignore";
wobblemenu._mcallback = RemoteObject.createNew ("Object");__ref.setField("_mcallback",wobblemenu._mcallback);
 //BA.debugLineNum = 25;BA.debugLine="Private mBase As B4XView";
wobblemenu._mbase = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_mbase",wobblemenu._mbase);
 //BA.debugLineNum = 26;BA.debugLine="Private xui As XUI";
wobblemenu._xui = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");__ref.setField("_xui",wobblemenu._xui);
 //BA.debugLineNum = 28;BA.debugLine="Private BackgroundColor,IconColor,IconSize,TextCo";
wobblemenu._backgroundcolor = RemoteObject.createImmutable(0);__ref.setField("_backgroundcolor",wobblemenu._backgroundcolor);
wobblemenu._iconcolor = RemoteObject.createImmutable(0);__ref.setField("_iconcolor",wobblemenu._iconcolor);
wobblemenu._iconsize = RemoteObject.createImmutable(0);__ref.setField("_iconsize",wobblemenu._iconsize);
wobblemenu._textcolor = RemoteObject.createImmutable(0);__ref.setField("_textcolor",wobblemenu._textcolor);
wobblemenu._textsize = RemoteObject.createImmutable(0);__ref.setField("_textsize",wobblemenu._textsize);
wobblemenu._selectediconcolor = RemoteObject.createImmutable(0);__ref.setField("_selectediconcolor",wobblemenu._selectediconcolor);
wobblemenu._circleradius = RemoteObject.createImmutable(0);__ref.setField("_circleradius",wobblemenu._circleradius);
wobblemenu._animduration = RemoteObject.createImmutable(0);__ref.setField("_animduration",wobblemenu._animduration);
 //BA.debugLineNum = 29;BA.debugLine="Private TabContainer,TabCurve,TabCircle,Tab1,Tab2";
wobblemenu._tabcontainer = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_tabcontainer",wobblemenu._tabcontainer);
wobblemenu._tabcurve = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_tabcurve",wobblemenu._tabcurve);
wobblemenu._tabcircle = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_tabcircle",wobblemenu._tabcircle);
wobblemenu._tab1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_tab1",wobblemenu._tab1);
wobblemenu._tab2 = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_tab2",wobblemenu._tab2);
wobblemenu._tab3 = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_tab3",wobblemenu._tab3);
wobblemenu._tab4 = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_tab4",wobblemenu._tab4);
wobblemenu._tab5 = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_tab5",wobblemenu._tab5);
 //BA.debugLineNum = 30;BA.debugLine="Private Tabs,IconList As List";
wobblemenu._tabs = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");__ref.setField("_tabs",wobblemenu._tabs);
wobblemenu._iconlist = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");__ref.setField("_iconlist",wobblemenu._iconlist);
 //BA.debugLineNum = 31;BA.debugLine="Private MenuHeight, AbsoluteWidth, TabCount As In";
wobblemenu._menuheight = RemoteObject.createImmutable(0);__ref.setField("_menuheight",wobblemenu._menuheight);
wobblemenu._absolutewidth = RemoteObject.createImmutable(0);__ref.setField("_absolutewidth",wobblemenu._absolutewidth);
wobblemenu._tabcount = RemoteObject.createImmutable(0);__ref.setField("_tabcount",wobblemenu._tabcount);
 //BA.debugLineNum = 32;BA.debugLine="Private CurrentTab As Int";
wobblemenu._currenttab = RemoteObject.createImmutable(0);__ref.setField("_currenttab",wobblemenu._currenttab);
 //BA.debugLineNum = 34;BA.debugLine="Public const ANIMATION_TYPE_ELASTIC_OUT As Int =";
wobblemenu._animation_type_elastic_out = BA.numberCast(int.class, 0);__ref.setField("_animation_type_elastic_out",wobblemenu._animation_type_elastic_out);
 //BA.debugLineNum = 35;BA.debugLine="Public const ANIMATION_TYPE_ELASTIC_IN As Int = 1";
wobblemenu._animation_type_elastic_in = BA.numberCast(int.class, 1);__ref.setField("_animation_type_elastic_in",wobblemenu._animation_type_elastic_in);
 //BA.debugLineNum = 36;BA.debugLine="Public const ANIMATION_TYPE_EASE_OUT As Int = 2";
wobblemenu._animation_type_ease_out = BA.numberCast(int.class, 2);__ref.setField("_animation_type_ease_out",wobblemenu._animation_type_ease_out);
 //BA.debugLineNum = 37;BA.debugLine="Public const ANIMATION_TYPE_EASE_IN As Int = 3";
wobblemenu._animation_type_ease_in = BA.numberCast(int.class, 3);__ref.setField("_animation_type_ease_in",wobblemenu._animation_type_ease_in);
 //BA.debugLineNum = 38;BA.debugLine="Public const ANIMATION_TYPE_NONE As Int = 4";
wobblemenu._animation_type_none = BA.numberCast(int.class, 4);__ref.setField("_animation_type_none",wobblemenu._animation_type_none);
 //BA.debugLineNum = 39;BA.debugLine="Private AnimationType As Int";
wobblemenu._animationtype = RemoteObject.createImmutable(0);__ref.setField("_animationtype",wobblemenu._animationtype);
 //BA.debugLineNum = 41;BA.debugLine="Public const ICON_APPEAR_FROM_CENTER As Int = 0";
wobblemenu._icon_appear_from_center = BA.numberCast(int.class, 0);__ref.setField("_icon_appear_from_center",wobblemenu._icon_appear_from_center);
 //BA.debugLineNum = 42;BA.debugLine="Public const ICON_APPEAR_FROM_EDGE As Int = 1";
wobblemenu._icon_appear_from_edge = BA.numberCast(int.class, 1);__ref.setField("_icon_appear_from_edge",wobblemenu._icon_appear_from_edge);
 //BA.debugLineNum = 43;BA.debugLine="Public const ICON_APPEAR_FADE_IN As Int = 2";
wobblemenu._icon_appear_fade_in = BA.numberCast(int.class, 2);__ref.setField("_icon_appear_fade_in",wobblemenu._icon_appear_fade_in);
 //BA.debugLineNum = 44;BA.debugLine="Public const ICON_APPEAR_NO_ANIMATION As Int = 3";
wobblemenu._icon_appear_no_animation = BA.numberCast(int.class, 3);__ref.setField("_icon_appear_no_animation",wobblemenu._icon_appear_no_animation);
 //BA.debugLineNum = 45;BA.debugLine="Private IconAppearStyle As Int";
wobblemenu._iconappearstyle = RemoteObject.createImmutable(0);__ref.setField("_iconappearstyle",wobblemenu._iconappearstyle);
 //BA.debugLineNum = 46;BA.debugLine="Private ShadowColor As String";
wobblemenu._shadowcolor = RemoteObject.createImmutable("");__ref.setField("_shadowcolor",wobblemenu._shadowcolor);
 //BA.debugLineNum = 47;BA.debugLine="Private badge,enabled As List";
wobblemenu._badge = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");__ref.setField("_badge",wobblemenu._badge);
wobblemenu._enabled = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");__ref.setField("_enabled",wobblemenu._enabled);
 //BA.debugLineNum = 54;BA.debugLine="Type IconType(Text As String, Icon As String, iFo";
;
 //BA.debugLineNum = 59;BA.debugLine="Private designerLbl As B4XView";
wobblemenu._designerlbl = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_designerlbl",wobblemenu._designerlbl);
 //BA.debugLineNum = 60;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _createtab(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("CreateTab (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,189);
if (RapidSub.canDelegate("createtab")) { return __ref.runUserSub(false, "wobblemenu","createtab", __ref);}
int _j = 0;
RemoteObject _tabview = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
RemoteObject _tab_width = RemoteObject.createImmutable(0);
RemoteObject _i = RemoteObject.declareNull("b4a.example.wobblemenu._icontype");
RemoteObject _icon = RemoteObject.declareNull("anywheresoftware.b4a.objects.LabelWrapper");
RemoteObject _b4xlbl = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
RemoteObject _icontext = RemoteObject.declareNull("anywheresoftware.b4a.objects.LabelWrapper");
RemoteObject _data = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
 BA.debugLineNum = 189;BA.debugLine="Private Sub CreateTab";
Debug.ShouldStop(268435456);
 BA.debugLineNum = 190;BA.debugLine="For j=0 To TabCount-1";
Debug.ShouldStop(536870912);
{
final int step1 = 1;
final int limit1 = RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_tabcount" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_j = 0 ;
for (;(step1 > 0 && _j <= limit1) || (step1 < 0 && _j >= limit1) ;_j = ((int)(0 + _j + step1))  ) {
Debug.locals.put("j", _j);
 BA.debugLineNum = 192;BA.debugLine="Dim tabView As B4XView = Tabs.Get(j)";
Debug.ShouldStop(-2147483648);
_tabview = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");
_tabview = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), __ref.getField(false,"_tabs" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(BA.numberCast(int.class, _j))));Debug.locals.put("tabView", _tabview);
 BA.debugLineNum = 193;BA.debugLine="tabView.Enabled = enabled.Get(j)";
Debug.ShouldStop(1);
_tabview.runMethod(true,"setEnabled",BA.ObjectToBoolean(__ref.getField(false,"_enabled" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(BA.numberCast(int.class, _j)))));
 BA.debugLineNum = 194;BA.debugLine="Dim tab_width As Int = TabContainer.Width/TabCou";
Debug.ShouldStop(2);
_tab_width = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),__ref.getField(true,"_tabcount" /*RemoteObject*/ )}, "/",0, 0));Debug.locals.put("tab_width", _tab_width);Debug.locals.put("tab_width", _tab_width);
 BA.debugLineNum = 195;BA.debugLine="tabView.Color = xui.Color_Transparent";
Debug.ShouldStop(4);
_tabview.runMethod(true,"setColor",__ref.getField(false,"_xui" /*RemoteObject*/ ).getField(true,"Color_Transparent"));
 BA.debugLineNum = 196;BA.debugLine="TabContainer.AddView(tabView,tab_width*j,0,tab_w";
Debug.ShouldStop(8);
__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runVoidMethod ("AddView",(Object)((_tabview.getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {_tab_width,RemoteObject.createImmutable(_j)}, "*",0, 1)),(Object)(BA.numberCast(int.class, 0)),(Object)(_tab_width),(Object)(__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getHeight")));
 BA.debugLineNum = 198;BA.debugLine="Dim i As IconType:i.Initialize";
Debug.ShouldStop(32);
_i = RemoteObject.createNew ("b4a.example.wobblemenu._icontype");Debug.locals.put("i", _i);
 BA.debugLineNum = 198;BA.debugLine="Dim i As IconType:i.Initialize";
Debug.ShouldStop(32);
_i.runVoidMethod ("Initialize");
 BA.debugLineNum = 199;BA.debugLine="If IconList.Size > j Then";
Debug.ShouldStop(64);
if (RemoteObject.solveBoolean(">",__ref.getField(false,"_iconlist" /*RemoteObject*/ ).runMethod(true,"getSize"),BA.numberCast(int.class, _j))) { 
 BA.debugLineNum = 200;BA.debugLine="i = IconList.Get(j)";
Debug.ShouldStop(128);
_i = (__ref.getField(false,"_iconlist" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(BA.numberCast(int.class, _j))));Debug.locals.put("i", _i);
 }else {
 BA.debugLineNum = 202;BA.debugLine="i.icon = Chr(0xF10C)";
Debug.ShouldStop(512);
_i.setField ("Icon" /*RemoteObject*/ ,BA.ObjectToString(wobblemenu.__c.runMethod(true,"Chr",(Object)(BA.numberCast(int.class, 0xf10c)))));
 BA.debugLineNum = 208;BA.debugLine="i.ifont = Typeface.FONTAWESOME";
Debug.ShouldStop(32768);
_i.getField(false,"iFont" /*RemoteObject*/ ).setObject (wobblemenu.__c.getField(false,"Typeface").runMethod(false,"getFONTAWESOME"));
 };
 BA.debugLineNum = 212;BA.debugLine="Dim icon As Label";
Debug.ShouldStop(524288);
_icon = RemoteObject.createNew ("anywheresoftware.b4a.objects.LabelWrapper");Debug.locals.put("icon", _icon);
 BA.debugLineNum = 213;BA.debugLine="icon.Initialize(\"\")";
Debug.ShouldStop(1048576);
_icon.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 214;BA.debugLine="Dim b4xlbl As B4XView = icon";
Debug.ShouldStop(2097152);
_b4xlbl = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");
_b4xlbl = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), _icon.getObject());Debug.locals.put("b4xlbl", _b4xlbl);
 BA.debugLineNum = 215;BA.debugLine="b4xlbl.TextColor = IconColor";
Debug.ShouldStop(4194304);
_b4xlbl.runMethod(true,"setTextColor",__ref.getField(true,"_iconcolor" /*RemoteObject*/ ));
 BA.debugLineNum = 216;BA.debugLine="b4xlbl.SetTextAlignment(\"CENTER\",\"CENTER\")";
Debug.ShouldStop(8388608);
_b4xlbl.runVoidMethod ("SetTextAlignment",(Object)(BA.ObjectToString("CENTER")),(Object)(RemoteObject.createImmutable("CENTER")));
 BA.debugLineNum = 217;BA.debugLine="b4xlbl.TextSize = IconSize";
Debug.ShouldStop(16777216);
_b4xlbl.runMethod(true,"setTextSize",BA.numberCast(float.class, __ref.getField(true,"_iconsize" /*RemoteObject*/ )));
 BA.debugLineNum = 222;BA.debugLine="icon.Typeface = i.iFont";
Debug.ShouldStop(536870912);
_icon.runMethod(false,"setTypeface",(_i.getField(false,"iFont" /*RemoteObject*/ ).getObject()));
 BA.debugLineNum = 225;BA.debugLine="icon.Text = i.icon";
Debug.ShouldStop(1);
_icon.runMethod(true,"setText",BA.ObjectToCharSequence(_i.getField(true,"Icon" /*RemoteObject*/ )));
 BA.debugLineNum = 226;BA.debugLine="tabView.AddView(icon,0,0,tabView.Width,tabView.H";
Debug.ShouldStop(2);
_tabview.runVoidMethod ("AddView",(Object)((_icon.getObject())),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(_tabview.runMethod(true,"getWidth")),(Object)(_tabview.runMethod(true,"getHeight")));
 BA.debugLineNum = 228;BA.debugLine="Dim iconText As Label";
Debug.ShouldStop(8);
_icontext = RemoteObject.createNew ("anywheresoftware.b4a.objects.LabelWrapper");Debug.locals.put("iconText", _icontext);
 BA.debugLineNum = 229;BA.debugLine="iconText.Initialize(\"\")";
Debug.ShouldStop(16);
_icontext.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 230;BA.debugLine="b4xlbl=iconText";
Debug.ShouldStop(32);
_b4xlbl = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), _icontext.getObject());
 BA.debugLineNum = 231;BA.debugLine="b4xlbl.TextColor = TextColor";
Debug.ShouldStop(64);
_b4xlbl.runMethod(true,"setTextColor",__ref.getField(true,"_textcolor" /*RemoteObject*/ ));
 BA.debugLineNum = 232;BA.debugLine="b4xlbl.Font=designerLbl.Font";
Debug.ShouldStop(128);
_b4xlbl.runMethod(false,"setFont",__ref.getField(false,"_designerlbl" /*RemoteObject*/ ).runMethod(false,"getFont"));
 BA.debugLineNum = 233;BA.debugLine="b4xlbl.TextSize=TextSize";
Debug.ShouldStop(256);
_b4xlbl.runMethod(true,"setTextSize",BA.numberCast(float.class, __ref.getField(true,"_textsize" /*RemoteObject*/ )));
 BA.debugLineNum = 234;BA.debugLine="b4xlbl.SetTextAlignment(\"CENTER\",\"CENTER\")";
Debug.ShouldStop(512);
_b4xlbl.runVoidMethod ("SetTextAlignment",(Object)(BA.ObjectToString("CENTER")),(Object)(RemoteObject.createImmutable("CENTER")));
 BA.debugLineNum = 235;BA.debugLine="b4xlbl.text=i.text";
Debug.ShouldStop(1024);
_b4xlbl.runMethod(true,"setText",BA.ObjectToCharSequence(_i.getField(true,"Text" /*RemoteObject*/ )));
 BA.debugLineNum = 237;BA.debugLine="tabView.AddView(iconText,0,tabView.Height/2,tabV";
Debug.ShouldStop(4096);
_tabview.runVoidMethod ("AddView",(Object)((_icontext.getObject())),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_tabview.runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(_tabview.runMethod(true,"getWidth")),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_tabview.runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0))));
 BA.debugLineNum = 239;BA.debugLine="If i.Text = \"\" Then";
Debug.ShouldStop(16384);
if (RemoteObject.solveBoolean("=",_i.getField(true,"Text" /*RemoteObject*/ ),BA.ObjectToString(""))) { 
 BA.debugLineNum = 243;BA.debugLine="icon.Height=tabView.Height";
Debug.ShouldStop(262144);
_icon.runMethod(true,"setHeight",_tabview.runMethod(true,"getHeight"));
 }else {
 BA.debugLineNum = 249;BA.debugLine="icon.Height=(tabView.Height/3)*2";
Debug.ShouldStop(16777216);
_icon.runMethod(true,"setHeight",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_tabview.runMethod(true,"getHeight"),RemoteObject.createImmutable(3)}, "/",0, 0)),RemoteObject.createImmutable(2)}, "*",0, 0)));
 };
 BA.debugLineNum = 253;BA.debugLine="If badge.Size > j Then";
Debug.ShouldStop(268435456);
if (RemoteObject.solveBoolean(">",__ref.getField(false,"_badge" /*RemoteObject*/ ).runMethod(true,"getSize"),BA.numberCast(int.class, _j))) { 
 BA.debugLineNum = 254;BA.debugLine="If badge.Get(j) <> \"\" Then";
Debug.ShouldStop(536870912);
if (RemoteObject.solveBoolean("!",__ref.getField(false,"_badge" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(BA.numberCast(int.class, _j))),RemoteObject.createImmutable(("")))) { 
 BA.debugLineNum = 255;BA.debugLine="Dim data As Map = badge.Get(j)";
Debug.ShouldStop(1073741824);
_data = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");
_data = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.collections.Map"), __ref.getField(false,"_badge" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(BA.numberCast(int.class, _j))));Debug.locals.put("data", _data);
 BA.debugLineNum = 256;BA.debugLine="SetBadge(j+1,data.Get(\"count\"),data.Get(\"backc";
Debug.ShouldStop(-2147483648);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_setbadge" /*RemoteObject*/ ,(Object)(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_j),RemoteObject.createImmutable(1)}, "+",1, 1)),(Object)(BA.numberCast(int.class, _data.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("count")))))),(Object)(BA.numberCast(int.class, _data.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("backcolor")))))),(Object)(BA.numberCast(int.class, _data.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("textcolor")))))));
 };
 }else {
 BA.debugLineNum = 259;BA.debugLine="badge.Add(\"\")";
Debug.ShouldStop(4);
__ref.getField(false,"_badge" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)((RemoteObject.createImmutable(""))));
 };
 BA.debugLineNum = 262;BA.debugLine="If IconList.Size < TabCount Then IconList.add(i)";
Debug.ShouldStop(32);
if (RemoteObject.solveBoolean("<",__ref.getField(false,"_iconlist" /*RemoteObject*/ ).runMethod(true,"getSize"),__ref.getField(true,"_tabcount" /*RemoteObject*/ ))) { 
__ref.getField(false,"_iconlist" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)((_i)));};
 BA.debugLineNum = 263;BA.debugLine="If j=CurrentTab-1 Then";
Debug.ShouldStop(64);
if (RemoteObject.solveBoolean("=",RemoteObject.createImmutable(_j),RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_currenttab" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "-",1, 1))) { 
 BA.debugLineNum = 264;BA.debugLine="icon.Visible = False";
Debug.ShouldStop(128);
_icon.runMethod(true,"setVisible",wobblemenu.__c.getField(true,"False"));
 BA.debugLineNum = 265;BA.debugLine="iconText.Visible = False";
Debug.ShouldStop(256);
_icontext.runMethod(true,"setVisible",wobblemenu.__c.getField(true,"False"));
 };
 }
}Debug.locals.put("j", _j);
;
 BA.debugLineNum = 268;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _curveto(RemoteObject __ref,RemoteObject _path1,RemoteObject _controlpointx,RemoteObject _controlpointy,RemoteObject _targetx,RemoteObject _targety) throws Exception{
try {
		Debug.PushSubsStack("CurveTo (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,630);
if (RapidSub.canDelegate("curveto")) { return __ref.runUserSub(false, "wobblemenu","curveto", __ref, _path1, _controlpointx, _controlpointy, _targetx, _targety);}
RemoteObject _lastpoint = RemoteObject.declareNull("b4a.example.bcpath._internalbcpathpointdata");
RemoteObject _currentx = RemoteObject.createImmutable(0f);
RemoteObject _currenty = RemoteObject.createImmutable(0f);
RemoteObject _numberofsteps = RemoteObject.createImmutable(0);
RemoteObject _dt = RemoteObject.createImmutable(0f);
RemoteObject _t = RemoteObject.createImmutable(0f);
int _i = 0;
RemoteObject _tt1 = RemoteObject.createImmutable(0f);
RemoteObject _tt2 = RemoteObject.createImmutable(0f);
RemoteObject _tt3 = RemoteObject.createImmutable(0f);
RemoteObject _x = RemoteObject.createImmutable(0f);
RemoteObject _y = RemoteObject.createImmutable(0f);
Debug.locals.put("Path1", _path1);
Debug.locals.put("ControlPointX", _controlpointx);
Debug.locals.put("ControlPointY", _controlpointy);
Debug.locals.put("TargetX", _targetx);
Debug.locals.put("TargetY", _targety);
 BA.debugLineNum = 630;BA.debugLine="Private Sub CurveTo (Path1 As BCPath, ControlPoint";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 631;BA.debugLine="Dim LastPoint As InternalBCPathPointData = Path1.";
Debug.ShouldStop(4194304);
_lastpoint = (_path1.getField(false,"_points").runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {_path1.getField(false,"_points").runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1))));Debug.locals.put("LastPoint", _lastpoint);Debug.locals.put("LastPoint", _lastpoint);
 BA.debugLineNum = 632;BA.debugLine="Dim CurrentX As Float = LastPoint.X";
Debug.ShouldStop(8388608);
_currentx = _lastpoint.getField(true,"X");Debug.locals.put("CurrentX", _currentx);Debug.locals.put("CurrentX", _currentx);
 BA.debugLineNum = 633;BA.debugLine="Dim Currenty As Float = LastPoint.Y";
Debug.ShouldStop(16777216);
_currenty = _lastpoint.getField(true,"Y");Debug.locals.put("Currenty", _currenty);Debug.locals.put("Currenty", _currenty);
 BA.debugLineNum = 634;BA.debugLine="Dim NumberOfSteps As Int = 11 '<--- change as nee";
Debug.ShouldStop(33554432);
_numberofsteps = BA.numberCast(int.class, 11);Debug.locals.put("NumberOfSteps", _numberofsteps);Debug.locals.put("NumberOfSteps", _numberofsteps);
 BA.debugLineNum = 635;BA.debugLine="Dim dt As Float = 1 / NumberOfSteps";
Debug.ShouldStop(67108864);
_dt = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_numberofsteps}, "/",0, 0));Debug.locals.put("dt", _dt);Debug.locals.put("dt", _dt);
 BA.debugLineNum = 636;BA.debugLine="Dim t As Float = dt";
Debug.ShouldStop(134217728);
_t = _dt;Debug.locals.put("t", _t);Debug.locals.put("t", _t);
 BA.debugLineNum = 637;BA.debugLine="For i = 1 To NumberOfSteps";
Debug.ShouldStop(268435456);
{
final int step7 = 1;
final int limit7 = _numberofsteps.<Integer>get().intValue();
_i = 1 ;
for (;(step7 > 0 && _i <= limit7) || (step7 < 0 && _i >= limit7) ;_i = ((int)(0 + _i + step7))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 638;BA.debugLine="Dim tt1 As Float =  (1 - t) * (1 - t)";
Debug.ShouldStop(536870912);
_tt1 = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_t}, "-",1, 0)),(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_t}, "-",1, 0))}, "*",0, 0));Debug.locals.put("tt1", _tt1);Debug.locals.put("tt1", _tt1);
 BA.debugLineNum = 639;BA.debugLine="Dim tt2 As Float = 2 * (1 - t) * t";
Debug.ShouldStop(1073741824);
_tt2 = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(2),(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_t}, "-",1, 0)),_t}, "**",0, 0));Debug.locals.put("tt2", _tt2);Debug.locals.put("tt2", _tt2);
 BA.debugLineNum = 640;BA.debugLine="Dim tt3 As Float = t * t";
Debug.ShouldStop(-2147483648);
_tt3 = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_t,_t}, "*",0, 0));Debug.locals.put("tt3", _tt3);Debug.locals.put("tt3", _tt3);
 BA.debugLineNum = 641;BA.debugLine="Dim x As Float = tt1 * CurrentX + tt2 * ControlP";
Debug.ShouldStop(1);
_x = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_tt1,_currentx,_tt2,_controlpointx,_tt3,_targetx}, "*+*+*",2, 0));Debug.locals.put("x", _x);Debug.locals.put("x", _x);
 BA.debugLineNum = 642;BA.debugLine="Dim y As Float = tt1 * Currenty + tt2 * ControlP";
Debug.ShouldStop(2);
_y = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_tt1,_currenty,_tt2,_controlpointy,_tt3,_targety}, "*+*+*",2, 0));Debug.locals.put("y", _y);Debug.locals.put("y", _y);
 BA.debugLineNum = 643;BA.debugLine="Path1.LineTo(x, y)";
Debug.ShouldStop(4);
_path1.runVoidMethod ("_lineto",(Object)(_x),(Object)(_y));
 BA.debugLineNum = 644;BA.debugLine="t = t + dt";
Debug.ShouldStop(8);
_t = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_t,_dt}, "+",1, 0));Debug.locals.put("t", _t);
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 646;BA.debugLine="End Sub";
Debug.ShouldStop(32);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _designercreateview(RemoteObject __ref,RemoteObject _base,RemoteObject _lbl,RemoteObject _props) throws Exception{
try {
		Debug.PushSubsStack("DesignerCreateView (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,73);
if (RapidSub.canDelegate("designercreateview")) { return __ref.runUserSub(false, "wobblemenu","designercreateview", __ref, _base, _lbl, _props);}
Debug.locals.put("Base", _base);
Debug.locals.put("Lbl", _lbl);
Debug.locals.put("Props", _props);
 BA.debugLineNum = 73;BA.debugLine="Public Sub DesignerCreateView (Base As Object, Lbl";
Debug.ShouldStop(256);
 BA.debugLineNum = 74;BA.debugLine="designerLbl=Lbl";
Debug.ShouldStop(512);
__ref.getField(false,"_designerlbl" /*RemoteObject*/ ).setObject (_lbl.getObject());
 BA.debugLineNum = 75;BA.debugLine="mBase = Base";
Debug.ShouldStop(1024);
__ref.getField(false,"_mbase" /*RemoteObject*/ ).setObject (_base);
 BA.debugLineNum = 76;BA.debugLine="mBase.Color = xui.Color_Transparent";
Debug.ShouldStop(2048);
__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"setColor",__ref.getField(false,"_xui" /*RemoteObject*/ ).getField(true,"Color_Transparent"));
 BA.debugLineNum = 77;BA.debugLine="AbsoluteWidth= Min(mBase.Parent.Width,mBase.Paren";
Debug.ShouldStop(4096);
__ref.setField ("_absolutewidth" /*RemoteObject*/ ,BA.numberCast(int.class, wobblemenu.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, __ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(false,"getParent").runMethod(true,"getWidth"))),(Object)(BA.numberCast(double.class, __ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(false,"getParent").runMethod(true,"getHeight"))))));
 BA.debugLineNum = 78;BA.debugLine="MenuHeight = (AbsoluteWidth/7) + ((AbsoluteWidth/";
Debug.ShouldStop(8192);
__ref.setField ("_menuheight" /*RemoteObject*/ ,BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_absolutewidth" /*RemoteObject*/ ),RemoteObject.createImmutable(7)}, "/",0, 0)),(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_absolutewidth" /*RemoteObject*/ ),RemoteObject.createImmutable(7)}, "/",0, 0)),RemoteObject.createImmutable(4)}, "/",0, 0))}, "+",1, 0)));
 BA.debugLineNum = 79;BA.debugLine="mBase.Height = MenuHeight";
Debug.ShouldStop(16384);
__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"setHeight",__ref.getField(true,"_menuheight" /*RemoteObject*/ ));
 BA.debugLineNum = 80;BA.debugLine="mBase.Top = mBase.Parent.Height - mBase.Height";
Debug.ShouldStop(32768);
__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(false,"getParent").runMethod(true,"getHeight"),__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"getHeight")}, "-",1, 1));
 BA.debugLineNum = 81;BA.debugLine="circleRadius = AbsoluteWidth/7";
Debug.ShouldStop(65536);
__ref.setField ("_circleradius" /*RemoteObject*/ ,BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_absolutewidth" /*RemoteObject*/ ),RemoteObject.createImmutable(7)}, "/",0, 0)));
 BA.debugLineNum = 83;BA.debugLine="BackgroundColor = xui.PaintOrColorToColor(Props.G";
Debug.ShouldStop(262144);
__ref.setField ("_backgroundcolor" /*RemoteObject*/ ,__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("BackgroundColor")))))));
 BA.debugLineNum = 84;BA.debugLine="IconColor = xui.PaintOrColorToColor(Props.Get(\"Ic";
Debug.ShouldStop(524288);
__ref.setField ("_iconcolor" /*RemoteObject*/ ,__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("IconColor")))))));
 BA.debugLineNum = 85;BA.debugLine="IconSize = xui.PaintOrColorToColor(Props.Get(\"Ico";
Debug.ShouldStop(1048576);
__ref.setField ("_iconsize" /*RemoteObject*/ ,__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("IconSize")))))));
 BA.debugLineNum = 86;BA.debugLine="TextSize = xui.PaintOrColorToColor(Props.Get(\"Tex";
Debug.ShouldStop(2097152);
__ref.setField ("_textsize" /*RemoteObject*/ ,__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("TextSize")))))));
 BA.debugLineNum = 87;BA.debugLine="TextColor = xui.PaintOrColorToColor(Props.Get(\"Te";
Debug.ShouldStop(4194304);
__ref.setField ("_textcolor" /*RemoteObject*/ ,__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("TextColor")))))));
 BA.debugLineNum = 88;BA.debugLine="SelectedIconColor = xui.PaintOrColorToColor(Props";
Debug.ShouldStop(8388608);
__ref.setField ("_selectediconcolor" /*RemoteObject*/ ,__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("SelectedIconColor")))))));
 BA.debugLineNum = 89;BA.debugLine="animDuration = Props.Get(\"AnimationDuration\")";
Debug.ShouldStop(16777216);
__ref.setField ("_animduration" /*RemoteObject*/ ,BA.numberCast(int.class, _props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("AnimationDuration"))))));
 BA.debugLineNum = 90;BA.debugLine="TabCount = Props.Get(\"TabCount\")";
Debug.ShouldStop(33554432);
__ref.setField ("_tabcount" /*RemoteObject*/ ,BA.numberCast(int.class, _props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("TabCount"))))));
 BA.debugLineNum = 91;BA.debugLine="ShadowColor = Props.Get(\"ShadowColor\")";
Debug.ShouldStop(67108864);
__ref.setField ("_shadowcolor" /*RemoteObject*/ ,BA.ObjectToString(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("ShadowColor"))))));
 BA.debugLineNum = 92;BA.debugLine="If TabCount = 5 Then";
Debug.ShouldStop(134217728);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_tabcount" /*RemoteObject*/ ),BA.numberCast(int.class, 5))) { 
 BA.debugLineNum = 93;BA.debugLine="CurrentTab = 3";
Debug.ShouldStop(268435456);
__ref.setField ("_currenttab" /*RemoteObject*/ ,BA.numberCast(int.class, 3));
 }else {
 BA.debugLineNum = 95;BA.debugLine="CurrentTab = 2";
Debug.ShouldStop(1073741824);
__ref.setField ("_currenttab" /*RemoteObject*/ ,BA.numberCast(int.class, 2));
 };
 BA.debugLineNum = 98;BA.debugLine="Select Props.Get(\"IconAppear\")";
Debug.ShouldStop(2);
switch (BA.switchObjectToInt(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("IconAppear")))),RemoteObject.createImmutable(("FROM EDGE")),RemoteObject.createImmutable(("FROM CENTER")),RemoteObject.createImmutable(("FADE IN")),RemoteObject.createImmutable(("NO ANIMATION")))) {
case 0: {
 BA.debugLineNum = 99;BA.debugLine="Case \"FROM EDGE\": IconAppearStyle = ICON_APPEAR_";
Debug.ShouldStop(4);
__ref.setField ("_iconappearstyle" /*RemoteObject*/ ,__ref.getField(true,"_icon_appear_from_edge" /*RemoteObject*/ ));
 break; }
case 1: {
 BA.debugLineNum = 100;BA.debugLine="Case \"FROM CENTER\": IconAppearStyle = ICON_APPEA";
Debug.ShouldStop(8);
__ref.setField ("_iconappearstyle" /*RemoteObject*/ ,__ref.getField(true,"_icon_appear_from_center" /*RemoteObject*/ ));
 break; }
case 2: {
 BA.debugLineNum = 101;BA.debugLine="Case \"FADE IN\": IconAppearStyle = ICON_APPEAR_FA";
Debug.ShouldStop(16);
__ref.setField ("_iconappearstyle" /*RemoteObject*/ ,__ref.getField(true,"_icon_appear_fade_in" /*RemoteObject*/ ));
 break; }
case 3: {
 BA.debugLineNum = 102;BA.debugLine="Case \"NO ANIMATION\": IconAppearStyle = ICON_APPE";
Debug.ShouldStop(32);
__ref.setField ("_iconappearstyle" /*RemoteObject*/ ,__ref.getField(true,"_icon_appear_no_animation" /*RemoteObject*/ ));
 break; }
}
;
 BA.debugLineNum = 105;BA.debugLine="Select Props.Get(\"AnimationType\")";
Debug.ShouldStop(256);
switch (BA.switchObjectToInt(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("AnimationType")))),RemoteObject.createImmutable(("ELASTIC OUT")),RemoteObject.createImmutable(("ELASTIC IN")),RemoteObject.createImmutable(("EASE OUT")),RemoteObject.createImmutable(("EASE IN")),RemoteObject.createImmutable(("NONE")))) {
case 0: {
 BA.debugLineNum = 106;BA.debugLine="Case \"ELASTIC OUT\": AnimationType = ANIMATION_TY";
Debug.ShouldStop(512);
__ref.setField ("_animationtype" /*RemoteObject*/ ,__ref.getField(true,"_animation_type_elastic_out" /*RemoteObject*/ ));
 break; }
case 1: {
 BA.debugLineNum = 107;BA.debugLine="Case \"ELASTIC IN\": AnimationType = ANIMATION_TYP";
Debug.ShouldStop(1024);
__ref.setField ("_animationtype" /*RemoteObject*/ ,__ref.getField(true,"_animation_type_elastic_in" /*RemoteObject*/ ));
 break; }
case 2: {
 BA.debugLineNum = 108;BA.debugLine="Case \"EASE OUT\": AnimationType = ANIMATION_TYPE_";
Debug.ShouldStop(2048);
__ref.setField ("_animationtype" /*RemoteObject*/ ,__ref.getField(true,"_animation_type_ease_out" /*RemoteObject*/ ));
 break; }
case 3: {
 BA.debugLineNum = 109;BA.debugLine="Case \"EASE IN\": AnimationType = ANIMATION_TYPE_E";
Debug.ShouldStop(4096);
__ref.setField ("_animationtype" /*RemoteObject*/ ,__ref.getField(true,"_animation_type_ease_in" /*RemoteObject*/ ));
 break; }
case 4: {
 BA.debugLineNum = 110;BA.debugLine="Case \"NONE\": AnimationType = ANIMATION_TYPE_NONE";
Debug.ShouldStop(8192);
__ref.setField ("_animationtype" /*RemoteObject*/ ,__ref.getField(true,"_animation_type_none" /*RemoteObject*/ ));
 break; }
}
;
 BA.debugLineNum = 113;BA.debugLine="DrawView";
Debug.ShouldStop(65536);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_drawview" /*RemoteObject*/ );
 BA.debugLineNum = 115;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _drawcircle(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("DrawCircle (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,379);
if (RapidSub.canDelegate("drawcircle")) { return __ref.runUserSub(false, "wobblemenu","drawcircle", __ref);}
RemoteObject _circle = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XCanvas");
RemoteObject _innerradius = RemoteObject.createImmutable(0);
int _i = 0;
 BA.debugLineNum = 379;BA.debugLine="Private Sub DrawCircle";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 380;BA.debugLine="Dim circle As B4XCanvas";
Debug.ShouldStop(134217728);
_circle = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XCanvas");Debug.locals.put("circle", _circle);
 BA.debugLineNum = 381;BA.debugLine="circle.Initialize(TabCircle)";
Debug.ShouldStop(268435456);
_circle.runVoidMethod ("Initialize",(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ )));
 BA.debugLineNum = 382;BA.debugLine="Dim innerRadius As Int = Min(mBase.Parent.Width,m";
Debug.ShouldStop(536870912);
_innerradius = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {wobblemenu.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, __ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(false,"getParent").runMethod(true,"getWidth"))),(Object)(BA.numberCast(double.class, __ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(false,"getParent").runMethod(true,"getHeight")))),RemoteObject.createImmutable(8)}, "/",0, 0));Debug.locals.put("innerRadius", _innerradius);Debug.locals.put("innerRadius", _innerradius);
 BA.debugLineNum = 383;BA.debugLine="For i=1 To 10";
Debug.ShouldStop(1073741824);
{
final int step4 = 1;
final int limit4 = 10;
_i = 1 ;
for (;(step4 > 0 && _i <= limit4) || (step4 < 0 && _i >= limit4) ;_i = ((int)(0 + _i + step4))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 384;BA.debugLine="If ShadowColor=\"Dark\" Then";
Debug.ShouldStop(-2147483648);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_shadowcolor" /*RemoteObject*/ ),BA.ObjectToString("Dark"))) { 
 BA.debugLineNum = 385;BA.debugLine="circle.DrawCircle(circleRadius/2,(circleRadius/";
Debug.ShouldStop(1);
_circle.runVoidMethod ("DrawCircle",(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_circleradius" /*RemoteObject*/ ),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_circleradius" /*RemoteObject*/ ),RemoteObject.createImmutable(2)}, "/",0, 0)),RemoteObject.createImmutable(2)}, "+",1, 0))),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_innerradius,RemoteObject.createImmutable(2)}, "/",0, 0)),RemoteObject.createImmutable(_i)}, "+",1, 0))),(Object)(__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"Color_ARGB",(Object)(BA.numberCast(int.class, 3)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)))),(Object)(wobblemenu.__c.getField(true,"True")),(Object)(BA.numberCast(float.class, 0)));
 }else 
{ BA.debugLineNum = 386;BA.debugLine="Else If ShadowColor=\"Light\" Then";
Debug.ShouldStop(2);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_shadowcolor" /*RemoteObject*/ ),BA.ObjectToString("Light"))) { 
 BA.debugLineNum = 387;BA.debugLine="circle.DrawCircle(circleRadius/2,(circleRadius/";
Debug.ShouldStop(4);
_circle.runVoidMethod ("DrawCircle",(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_circleradius" /*RemoteObject*/ ),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_circleradius" /*RemoteObject*/ ),RemoteObject.createImmutable(2)}, "/",0, 0)),RemoteObject.createImmutable(2)}, "+",1, 0))),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_innerradius,RemoteObject.createImmutable(2)}, "/",0, 0)),RemoteObject.createImmutable(_i)}, "+",1, 0))),(Object)(__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"Color_ARGB",(Object)(BA.numberCast(int.class, 3)),(Object)(BA.numberCast(int.class, 255)),(Object)(BA.numberCast(int.class, 255)),(Object)(BA.numberCast(int.class, 255)))),(Object)(wobblemenu.__c.getField(true,"True")),(Object)(BA.numberCast(float.class, 0)));
 }}
;
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 391;BA.debugLine="circle.DrawCircle(circleRadius/2,circleRadius/2,i";
Debug.ShouldStop(64);
_circle.runVoidMethod ("DrawCircle",(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_circleradius" /*RemoteObject*/ ),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_circleradius" /*RemoteObject*/ ),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_innerradius,RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(__ref.getField(true,"_backgroundcolor" /*RemoteObject*/ )),(Object)(wobblemenu.__c.getField(true,"True")),(Object)(BA.numberCast(float.class, 0)));
 BA.debugLineNum = 392;BA.debugLine="circle.Invalidate";
Debug.ShouldStop(128);
_circle.runVoidMethod ("Invalidate");
 BA.debugLineNum = 393;BA.debugLine="End Sub";
Debug.ShouldStop(256);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _drawcurve(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("DrawCurve (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,325);
if (RapidSub.canDelegate("drawcurve")) { return __ref.runUserSub(false, "wobblemenu","drawcurve", __ref);}
RemoteObject _backargb = null;
RemoteObject _curve = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XCanvas");
RemoteObject _rect = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XCanvas.B4XRect");
RemoteObject _bezierview = RemoteObject.declareNull("b4a.example.bitmapcreator");
RemoteObject _bezierpath = RemoteObject.declareNull("b4a.example.bcpath");
RemoteObject _swidth = RemoteObject.createImmutable(0);
RemoteObject _sheight = RemoteObject.createImmutable(0);
RemoteObject _curveheight = RemoteObject.createImmutable(0);
RemoteObject _shadow = RemoteObject.createImmutable(0);
 BA.debugLineNum = 325;BA.debugLine="Private Sub DrawCurve";
Debug.ShouldStop(16);
 BA.debugLineNum = 326;BA.debugLine="Dim backARGB() As Int = GetARGB(BackgroundColor)";
Debug.ShouldStop(32);
_backargb = __ref.runClassMethod (b4a.example.wobblemenu.class, "_getargb" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_backgroundcolor" /*RemoteObject*/ )));Debug.locals.put("backARGB", _backargb);Debug.locals.put("backARGB", _backargb);
 BA.debugLineNum = 327;BA.debugLine="Dim curve As B4XCanvas";
Debug.ShouldStop(64);
_curve = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XCanvas");Debug.locals.put("curve", _curve);
 BA.debugLineNum = 328;BA.debugLine="curve.Initialize(TabCurve)";
Debug.ShouldStop(128);
_curve.runVoidMethod ("Initialize",(Object)(__ref.getField(false,"_tabcurve" /*RemoteObject*/ )));
 BA.debugLineNum = 329;BA.debugLine="Dim rect As B4XRect";
Debug.ShouldStop(256);
_rect = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XCanvas.B4XRect");Debug.locals.put("rect", _rect);
 BA.debugLineNum = 330;BA.debugLine="Dim BezierView As BitmapCreator";
Debug.ShouldStop(512);
_bezierview = RemoteObject.createNew ("b4a.example.bitmapcreator");Debug.locals.put("BezierView", _bezierview);
 BA.debugLineNum = 331;BA.debugLine="Dim BezierPath As BCPath";
Debug.ShouldStop(1024);
_bezierpath = RemoteObject.createNew ("b4a.example.bcpath");Debug.locals.put("BezierPath", _bezierpath);
 BA.debugLineNum = 332;BA.debugLine="Dim sWidth As Double = 1000";
Debug.ShouldStop(2048);
_swidth = BA.numberCast(double.class, 1000);Debug.locals.put("sWidth", _swidth);Debug.locals.put("sWidth", _swidth);
 BA.debugLineNum = 333;BA.debugLine="Dim sHeight As Double = 500";
Debug.ShouldStop(4096);
_sheight = BA.numberCast(double.class, 500);Debug.locals.put("sHeight", _sheight);Debug.locals.put("sHeight", _sheight);
 BA.debugLineNum = 335;BA.debugLine="Dim curveHeight As Double = sHeight- sHeight/5 -";
Debug.ShouldStop(16384);
_curveheight = RemoteObject.solve(new RemoteObject[] {_sheight,_sheight,RemoteObject.createImmutable(5),wobblemenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3)))}, "-/-",2, 0);Debug.locals.put("curveHeight", _curveheight);Debug.locals.put("curveHeight", _curveheight);
 BA.debugLineNum = 341;BA.debugLine="BezierPath.Initialize(0, 0)";
Debug.ShouldStop(1048576);
_bezierpath.runVoidMethod ("_initialize",__ref.getField(false, "ba"),(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, 0)));
 BA.debugLineNum = 342;BA.debugLine="CurveTo(BezierPath, sWidth/9, 0, sWidth/7, (sHeig";
Debug.ShouldStop(2097152);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_curveto" /*RemoteObject*/ ,(Object)(_bezierpath),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_swidth,RemoteObject.createImmutable(9)}, "/",0, 0))),(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_swidth,RemoteObject.createImmutable(7)}, "/",0, 0))),(Object)(BA.numberCast(float.class, (RemoteObject.solve(new RemoteObject[] {_sheight,RemoteObject.createImmutable(3)}, "/",0, 0)))));
 BA.debugLineNum = 343;BA.debugLine="CurveTo(BezierPath, sWidth/5 + 5dip, curveHeight";
Debug.ShouldStop(4194304);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_curveto" /*RemoteObject*/ ,(Object)(_bezierpath),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_swidth,RemoteObject.createImmutable(5),wobblemenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "/+",1, 0))),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_curveheight,wobblemenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 8)))}, "-",1, 0))),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_swidth,RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(BA.numberCast(float.class, _curveheight)));
 BA.debugLineNum = 344;BA.debugLine="CurveTo(BezierPath, (sWidth-sWidth/5) - 5dip, cur";
Debug.ShouldStop(8388608);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_curveto" /*RemoteObject*/ ,(Object)(_bezierpath),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_swidth,_swidth,RemoteObject.createImmutable(5)}, "-/",1, 0)),wobblemenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "-",1, 0))),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_curveheight,wobblemenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 8)))}, "-",1, 0))),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_swidth,(RemoteObject.solve(new RemoteObject[] {_swidth,RemoteObject.createImmutable(7)}, "/",0, 0))}, "-",1, 0))),(Object)(BA.numberCast(float.class, (RemoteObject.solve(new RemoteObject[] {_sheight,RemoteObject.createImmutable(3)}, "/",0, 0)))));
 BA.debugLineNum = 345;BA.debugLine="CurveTo(BezierPath, (sWidth-sWidth/9)-2dip, 0, sW";
Debug.ShouldStop(16777216);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_curveto" /*RemoteObject*/ ,(Object)(_bezierpath),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_swidth,_swidth,RemoteObject.createImmutable(9)}, "-/",1, 0)),wobblemenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 2)))}, "-",1, 0))),(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, _swidth)),(Object)(BA.numberCast(float.class, 0)));
 BA.debugLineNum = 346;BA.debugLine="BezierPath.LineTo(sWidth,sHeight)";
Debug.ShouldStop(33554432);
_bezierpath.runVoidMethod ("_lineto",(Object)(BA.numberCast(float.class, _swidth)),(Object)(BA.numberCast(float.class, _sheight)));
 BA.debugLineNum = 347;BA.debugLine="BezierPath.LineTo(0,sHeight)";
Debug.ShouldStop(67108864);
_bezierpath.runVoidMethod ("_lineto",(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, _sheight)));
 BA.debugLineNum = 348;BA.debugLine="BezierPath.LineTo(0,0)";
Debug.ShouldStop(134217728);
_bezierpath.runVoidMethod ("_lineto",(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, 0)));
 BA.debugLineNum = 350;BA.debugLine="Dim shadow As Int";
Debug.ShouldStop(536870912);
_shadow = RemoteObject.createImmutable(0);Debug.locals.put("shadow", _shadow);
 BA.debugLineNum = 351;BA.debugLine="If ShadowColor=\"Dark\" Then";
Debug.ShouldStop(1073741824);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_shadowcolor" /*RemoteObject*/ ),BA.ObjectToString("Dark"))) { 
 BA.debugLineNum = 352;BA.debugLine="shadow = xui.Color_ARGB(backARGB(0),Max(0,backAR";
Debug.ShouldStop(-2147483648);
_shadow = __ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"Color_ARGB",(Object)(_backargb.getArrayElement(true,BA.numberCast(int.class, 0))),(Object)(BA.numberCast(int.class, wobblemenu.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_backargb.getArrayElement(true,BA.numberCast(int.class, 1)),RemoteObject.createImmutable(20)}, "-",1, 1)))))),(Object)(BA.numberCast(int.class, wobblemenu.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_backargb.getArrayElement(true,BA.numberCast(int.class, 2)),RemoteObject.createImmutable(20)}, "-",1, 1)))))),(Object)(BA.numberCast(int.class, wobblemenu.__c.runMethod(true,"Max",(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_backargb.getArrayElement(true,BA.numberCast(int.class, 3)),RemoteObject.createImmutable(20)}, "-",1, 1)))))));Debug.locals.put("shadow", _shadow);
 }else 
{ BA.debugLineNum = 353;BA.debugLine="Else If ShadowColor=\"Light\" Then";
Debug.ShouldStop(1);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_shadowcolor" /*RemoteObject*/ ),BA.ObjectToString("Light"))) { 
 BA.debugLineNum = 354;BA.debugLine="shadow = xui.Color_ARGB(backARGB(0),Min(255,back";
Debug.ShouldStop(2);
_shadow = __ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"Color_ARGB",(Object)(_backargb.getArrayElement(true,BA.numberCast(int.class, 0))),(Object)(BA.numberCast(int.class, wobblemenu.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, 255)),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_backargb.getArrayElement(true,BA.numberCast(int.class, 1)),RemoteObject.createImmutable(20)}, "+",1, 1)))))),(Object)(BA.numberCast(int.class, wobblemenu.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, 255)),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_backargb.getArrayElement(true,BA.numberCast(int.class, 2)),RemoteObject.createImmutable(20)}, "+",1, 1)))))),(Object)(BA.numberCast(int.class, wobblemenu.__c.runMethod(true,"Min",(Object)(BA.numberCast(double.class, 255)),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_backargb.getArrayElement(true,BA.numberCast(int.class, 3)),RemoteObject.createImmutable(20)}, "+",1, 1)))))));Debug.locals.put("shadow", _shadow);
 }}
;
 BA.debugLineNum = 357;BA.debugLine="BezierView.Initialize(sWidth,sHeight)";
Debug.ShouldStop(16);
_bezierview.runVoidMethod ("_initialize",__ref.getField(false, "ba"),(Object)(BA.numberCast(int.class, _swidth)),(Object)(BA.numberCast(int.class, _sheight)));
 BA.debugLineNum = 358;BA.debugLine="BezierView.DrawPath(BezierPath,BackgroundColor,Tr";
Debug.ShouldStop(32);
_bezierview.runVoidMethod ("_drawpath",(Object)(_bezierpath),(Object)(__ref.getField(true,"_backgroundcolor" /*RemoteObject*/ )),(Object)(wobblemenu.__c.getField(true,"True")),(Object)(BA.numberCast(int.class, 0)));
 BA.debugLineNum = 360;BA.debugLine="BezierView.DrawPath(BezierPath,shadow,False,10)";
Debug.ShouldStop(128);
_bezierview.runVoidMethod ("_drawpath",(Object)(_bezierpath),(Object)(_shadow),(Object)(wobblemenu.__c.getField(true,"False")),(Object)(BA.numberCast(int.class, 10)));
 BA.debugLineNum = 365;BA.debugLine="rect.Initialize(TabContainer.Width - (AbsoluteWid";
Debug.ShouldStop(4096);
_rect.runVoidMethod ("Initialize",(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_absolutewidth" /*RemoteObject*/ ),RemoteObject.createImmutable(5)}, "/",0, 0)),RemoteObject.createImmutable(2),RemoteObject.createImmutable(4)}, "-/-",2, 0))),(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_absolutewidth" /*RemoteObject*/ ),RemoteObject.createImmutable(5)}, "/",0, 0)),RemoteObject.createImmutable(2),RemoteObject.createImmutable(4)}, "+/+",2, 0))),(Object)(BA.numberCast(float.class, __ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getHeight"))));
 BA.debugLineNum = 366;BA.debugLine="curve.DrawBitmap(BezierView.Bitmap,rect)";
Debug.ShouldStop(8192);
_curve.runVoidMethod ("DrawBitmap",(Object)((_bezierview.runMethod(false,"_getbitmap").getObject())),(Object)(_rect));
 BA.debugLineNum = 368;BA.debugLine="rect.Initialize(0,0,TabContainer.Width -(Absolute";
Debug.ShouldStop(32768);
_rect.runVoidMethod ("Initialize",(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_absolutewidth" /*RemoteObject*/ ),RemoteObject.createImmutable(5)}, "/",0, 0)),RemoteObject.createImmutable(2)}, "-/",1, 0))),(Object)(BA.numberCast(float.class, __ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getHeight"))));
 BA.debugLineNum = 369;BA.debugLine="curve.DrawRect(rect,BackgroundColor,True,0)";
Debug.ShouldStop(65536);
_curve.runVoidMethod ("DrawRect",(Object)(_rect),(Object)(__ref.getField(true,"_backgroundcolor" /*RemoteObject*/ )),(Object)(wobblemenu.__c.getField(true,"True")),(Object)(BA.numberCast(float.class, 0)));
 BA.debugLineNum = 370;BA.debugLine="rect.Initialize(TabContainer.Width +(AbsoluteWidt";
Debug.ShouldStop(131072);
_rect.runVoidMethod ("Initialize",(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_absolutewidth" /*RemoteObject*/ ),RemoteObject.createImmutable(5)}, "/",0, 0)),RemoteObject.createImmutable(2)}, "+/",1, 0))),(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, __ref.getField(false,"_tabcurve" /*RemoteObject*/ ).runMethod(true,"getWidth"))),(Object)(BA.numberCast(float.class, __ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getHeight"))));
 BA.debugLineNum = 371;BA.debugLine="curve.DrawRect(rect,BackgroundColor,True,0)";
Debug.ShouldStop(262144);
_curve.runVoidMethod ("DrawRect",(Object)(_rect),(Object)(__ref.getField(true,"_backgroundcolor" /*RemoteObject*/ )),(Object)(wobblemenu.__c.getField(true,"True")),(Object)(BA.numberCast(float.class, 0)));
 BA.debugLineNum = 372;BA.debugLine="curve.DrawLine(0,0,TabContainer.Width -(AbsoluteW";
Debug.ShouldStop(524288);
_curve.runVoidMethod ("DrawLine",(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_absolutewidth" /*RemoteObject*/ ),RemoteObject.createImmutable(5)}, "/",0, 0)),RemoteObject.createImmutable(2)}, "-/",1, 0))),(Object)(BA.numberCast(float.class, 0)),(Object)(_shadow),(Object)(BA.numberCast(float.class, 4)));
 BA.debugLineNum = 373;BA.debugLine="curve.DrawLine(TabContainer.Width +(AbsoluteWidth";
Debug.ShouldStop(1048576);
_curve.runVoidMethod ("DrawLine",(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_absolutewidth" /*RemoteObject*/ ),RemoteObject.createImmutable(5)}, "/",0, 0)),RemoteObject.createImmutable(2)}, "+/",1, 0))),(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "*",0, 1))),(Object)(BA.numberCast(float.class, 0)),(Object)(_shadow),(Object)(BA.numberCast(float.class, 4)));
 BA.debugLineNum = 374;BA.debugLine="curve.DrawLine(0,TabContainer.Height,TabContainer";
Debug.ShouldStop(2097152);
_curve.runVoidMethod ("DrawLine",(Object)(BA.numberCast(float.class, 0)),(Object)(BA.numberCast(float.class, __ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getHeight"))),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "*",0, 1))),(Object)(BA.numberCast(float.class, __ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getHeight"))),(Object)(__ref.getField(true,"_backgroundcolor" /*RemoteObject*/ )),(Object)(BA.numberCast(float.class, 4)));
 BA.debugLineNum = 376;BA.debugLine="curve.Invalidate";
Debug.ShouldStop(8388608);
_curve.runVoidMethod ("Invalidate");
 BA.debugLineNum = 377;BA.debugLine="End Sub";
Debug.ShouldStop(16777216);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _drawview(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("DrawView (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,128);
if (RapidSub.canDelegate("drawview")) { return __ref.runUserSub(false, "wobblemenu","drawview", __ref);}
RemoteObject _icon = RemoteObject.declareNull("anywheresoftware.b4a.objects.LabelWrapper");
RemoteObject _lw = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
RemoteObject _rw = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
RemoteObject _cw = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
 BA.debugLineNum = 128;BA.debugLine="Private Sub DrawView";
Debug.ShouldStop(-2147483648);
 BA.debugLineNum = 129;BA.debugLine="mBase.RemoveAllViews";
Debug.ShouldStop(1);
__ref.getField(false,"_mbase" /*RemoteObject*/ ).runVoidMethod ("RemoveAllViews");
 BA.debugLineNum = 130;BA.debugLine="Tabs.Clear";
Debug.ShouldStop(2);
__ref.getField(false,"_tabs" /*RemoteObject*/ ).runVoidMethod ("Clear");
 BA.debugLineNum = 131;BA.debugLine="If TabCircle.IsInitialized Then TabCircle.RemoveA";
Debug.ShouldStop(4);
if (__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"IsInitialized").<Boolean>get().booleanValue()) { 
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runVoidMethod ("RemoveAllViews");};
 BA.debugLineNum = 133;BA.debugLine="TabContainer = xui.CreatePanel(\"\")";
Debug.ShouldStop(16);
__ref.setField ("_tabcontainer" /*RemoteObject*/ ,__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable(""))));
 BA.debugLineNum = 134;BA.debugLine="mBase.AddView(TabContainer,0,mBase.Height/4 ,mBas";
Debug.ShouldStop(32);
__ref.getField(false,"_mbase" /*RemoteObject*/ ).runVoidMethod ("AddView",(Object)((__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).getObject())),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(4)}, "/",0, 0))),(Object)(__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"getWidth")),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"getHeight"),(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(4)}, "/",0, 0))}, "-",1, 0))));
 BA.debugLineNum = 135;BA.debugLine="TabCurve = xui.CreatePanel(\"\")";
Debug.ShouldStop(64);
__ref.setField ("_tabcurve" /*RemoteObject*/ ,__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable(""))));
 BA.debugLineNum = 136;BA.debugLine="TabContainer.AddView(TabCurve,((TabContainer.Widt";
Debug.ShouldStop(128);
__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runVoidMethod ("AddView",(Object)((__ref.getField(false,"_tabcurve" /*RemoteObject*/ ).getObject())),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),__ref.getField(true,"_tabcount" /*RemoteObject*/ )}, "/",0, 0)),(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_currenttab" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "-",1, 1))}, "*",0, 0)),(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),__ref.getField(true,"_tabcount" /*RemoteObject*/ )}, "/",0, 0)),RemoteObject.createImmutable(2)}, "/",0, 0)),(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "*",0, 1)),RemoteObject.createImmutable(2)}, "/",0, 0))}, "+-",2, 0))),(Object)(BA.numberCast(int.class, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "*",0, 1)),(Object)(__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getHeight")));
 BA.debugLineNum = 137;BA.debugLine="DrawCurve";
Debug.ShouldStop(256);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_drawcurve" /*RemoteObject*/ );
 BA.debugLineNum = 139;BA.debugLine="TabCircle = xui.CreatePanel(\"\")";
Debug.ShouldStop(1024);
__ref.setField ("_tabcircle" /*RemoteObject*/ ,__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable(""))));
 BA.debugLineNum = 140;BA.debugLine="mBase.AddView(TabCircle,((TabContainer.Width/TabC";
Debug.ShouldStop(2048);
__ref.getField(false,"_mbase" /*RemoteObject*/ ).runVoidMethod ("AddView",(Object)((__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).getObject())),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),__ref.getField(true,"_tabcount" /*RemoteObject*/ )}, "/",0, 0)),(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_currenttab" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "-",1, 1))}, "*",0, 0)),(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcontainer" /*RemoteObject*/ ).runMethod(true,"getWidth"),__ref.getField(true,"_tabcount" /*RemoteObject*/ )}, "/",0, 0)),RemoteObject.createImmutable(2)}, "/",0, 0)),(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_circleradius" /*RemoteObject*/ ),RemoteObject.createImmutable(2)}, "/",0, 0))}, "+-",2, 0))),(Object)(wobblemenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))),(Object)(__ref.getField(true,"_circleradius" /*RemoteObject*/ )),(Object)(__ref.getField(true,"_circleradius" /*RemoteObject*/ )));
 BA.debugLineNum = 141;BA.debugLine="DrawCircle";
Debug.ShouldStop(4096);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_drawcircle" /*RemoteObject*/ );
 BA.debugLineNum = 143;BA.debugLine="Dim icon As Label";
Debug.ShouldStop(16384);
_icon = RemoteObject.createNew ("anywheresoftware.b4a.objects.LabelWrapper");Debug.locals.put("icon", _icon);
 BA.debugLineNum = 144;BA.debugLine="icon.Initialize(\"\")";
Debug.ShouldStop(32768);
_icon.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 151;BA.debugLine="icon.TextColor = SelectedIconColor";
Debug.ShouldStop(4194304);
_icon.runMethod(true,"setTextColor",__ref.getField(true,"_selectediconcolor" /*RemoteObject*/ ));
 BA.debugLineNum = 152;BA.debugLine="icon.Typeface = Typeface.FONTAWESOME";
Debug.ShouldStop(8388608);
_icon.runMethod(false,"setTypeface",wobblemenu.__c.getField(false,"Typeface").runMethod(false,"getFONTAWESOME"));
 BA.debugLineNum = 153;BA.debugLine="icon.TextSize = 20";
Debug.ShouldStop(16777216);
_icon.runMethod(true,"setTextSize",BA.numberCast(float.class, 20));
 BA.debugLineNum = 154;BA.debugLine="icon.Gravity = Gravity.CENTER_HORIZONTAL + Gravit";
Debug.ShouldStop(33554432);
_icon.runMethod(true,"setGravity",RemoteObject.solve(new RemoteObject[] {wobblemenu.__c.getField(false,"Gravity").getField(true,"CENTER_HORIZONTAL"),wobblemenu.__c.getField(false,"Gravity").getField(true,"CENTER_VERTICAL")}, "+",1, 1));
 BA.debugLineNum = 161;BA.debugLine="TabCircle.AddView(icon,0,0,TabCircle.Width,TabCir";
Debug.ShouldStop(1);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runVoidMethod ("AddView",(Object)((_icon.getObject())),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getHeight")));
 BA.debugLineNum = 163;BA.debugLine="Dim lw,rw,cw As B4XView";
Debug.ShouldStop(4);
_lw = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");Debug.locals.put("lw", _lw);
_rw = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");Debug.locals.put("rw", _rw);
_cw = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");Debug.locals.put("cw", _cw);
 BA.debugLineNum = 164;BA.debugLine="lw = xui.CreatePanel(\"\")";
Debug.ShouldStop(8);
_lw = __ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));Debug.locals.put("lw", _lw);
 BA.debugLineNum = 165;BA.debugLine="rw = xui.CreatePanel(\"\")";
Debug.ShouldStop(16);
_rw = __ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));Debug.locals.put("rw", _rw);
 BA.debugLineNum = 166;BA.debugLine="cw = xui.CreatePanel(\"\")";
Debug.ShouldStop(32);
_cw = __ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));Debug.locals.put("cw", _cw);
 BA.debugLineNum = 167;BA.debugLine="lw.Color = BackgroundColor";
Debug.ShouldStop(64);
_lw.runMethod(true,"setColor",__ref.getField(true,"_backgroundcolor" /*RemoteObject*/ ));
 BA.debugLineNum = 168;BA.debugLine="rw.Color = BackgroundColor";
Debug.ShouldStop(128);
_rw.runMethod(true,"setColor",__ref.getField(true,"_backgroundcolor" /*RemoteObject*/ ));
 BA.debugLineNum = 169;BA.debugLine="cw.Color = BackgroundColor";
Debug.ShouldStop(256);
_cw.runMethod(true,"setColor",__ref.getField(true,"_backgroundcolor" /*RemoteObject*/ ));
 BA.debugLineNum = 170;BA.debugLine="TabCircle.AddView(lw,(TabCircle.Height/5),(TabCir";
Debug.ShouldStop(512);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runVoidMethod ("AddView",(Object)((_lw.getObject())),(Object)(BA.numberCast(int.class, (RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(5)}, "/",0, 0)))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)),(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)),RemoteObject.createImmutable(2)}, "/",0, 0))}, "-",1, 0))),(Object)(wobblemenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0))));
 BA.debugLineNum = 171;BA.debugLine="TabCircle.AddView(rw,TabCircle.Width-(TabCircle.H";
Debug.ShouldStop(1024);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runVoidMethod ("AddView",(Object)((_rw.getObject())),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getWidth"),(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(5)}, "/",0, 0)),wobblemenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))}, "--",2, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)),(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)),RemoteObject.createImmutable(2)}, "/",0, 0))}, "-",1, 0))),(Object)(wobblemenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0))));
 BA.debugLineNum = 172;BA.debugLine="TabCircle.AddView(cw,TabCircle.Width/2,(TabCircle";
Debug.ShouldStop(2048);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runVoidMethod ("AddView",(Object)((_cw.getObject())),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)),(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)),RemoteObject.createImmutable(2)}, "/",0, 0))}, "-",1, 0))),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0))));
 BA.debugLineNum = 174;BA.debugLine="Tab1 = xui.CreatePanel(\"IconTab\")";
Debug.ShouldStop(8192);
__ref.setField ("_tab1" /*RemoteObject*/ ,__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("IconTab"))));
 BA.debugLineNum = 175;BA.debugLine="Tabs.Add(Tab1)";
Debug.ShouldStop(16384);
__ref.getField(false,"_tabs" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)((__ref.getField(false,"_tab1" /*RemoteObject*/ ).getObject())));
 BA.debugLineNum = 176;BA.debugLine="Tab2 = xui.CreatePanel(\"IconTab\")";
Debug.ShouldStop(32768);
__ref.setField ("_tab2" /*RemoteObject*/ ,__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("IconTab"))));
 BA.debugLineNum = 177;BA.debugLine="Tabs.Add(Tab2)";
Debug.ShouldStop(65536);
__ref.getField(false,"_tabs" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)((__ref.getField(false,"_tab2" /*RemoteObject*/ ).getObject())));
 BA.debugLineNum = 178;BA.debugLine="Tab3 = xui.CreatePanel(\"IconTab\")";
Debug.ShouldStop(131072);
__ref.setField ("_tab3" /*RemoteObject*/ ,__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("IconTab"))));
 BA.debugLineNum = 179;BA.debugLine="Tabs.Add(Tab3)";
Debug.ShouldStop(262144);
__ref.getField(false,"_tabs" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)((__ref.getField(false,"_tab3" /*RemoteObject*/ ).getObject())));
 BA.debugLineNum = 180;BA.debugLine="Tab4 = xui.CreatePanel(\"IconTab\")";
Debug.ShouldStop(524288);
__ref.setField ("_tab4" /*RemoteObject*/ ,__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("IconTab"))));
 BA.debugLineNum = 181;BA.debugLine="Tabs.Add(Tab4)";
Debug.ShouldStop(1048576);
__ref.getField(false,"_tabs" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)((__ref.getField(false,"_tab4" /*RemoteObject*/ ).getObject())));
 BA.debugLineNum = 182;BA.debugLine="Tab5 = xui.CreatePanel(\"IconTab\")";
Debug.ShouldStop(2097152);
__ref.setField ("_tab5" /*RemoteObject*/ ,__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("IconTab"))));
 BA.debugLineNum = 183;BA.debugLine="Tabs.Add(Tab5)";
Debug.ShouldStop(4194304);
__ref.getField(false,"_tabs" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)((__ref.getField(false,"_tab5" /*RemoteObject*/ ).getObject())));
 BA.debugLineNum = 185;BA.debugLine="CreateTab";
Debug.ShouldStop(16777216);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_createtab" /*RemoteObject*/ );
 BA.debugLineNum = 186;BA.debugLine="SetCircleIcon";
Debug.ShouldStop(33554432);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_setcircleicon" /*void*/ );
 BA.debugLineNum = 187;BA.debugLine="End Sub";
Debug.ShouldStop(67108864);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getargb(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("GetARGB (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,649);
if (RapidSub.canDelegate("getargb")) { return __ref.runUserSub(false, "wobblemenu","getargb", __ref, _color);}
RemoteObject _res = null;
Debug.locals.put("Color", _color);
 BA.debugLineNum = 649;BA.debugLine="Private Sub GetARGB(Color As Int) As Int()";
Debug.ShouldStop(256);
 BA.debugLineNum = 650;BA.debugLine="Private res(4) As Int";
Debug.ShouldStop(512);
_res = RemoteObject.createNewArray ("int", new int[] {4}, new Object[]{});Debug.locals.put("res", _res);
 BA.debugLineNum = 651;BA.debugLine="res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0x";
Debug.ShouldStop(1024);
_res.setArrayElement (wobblemenu.__c.getField(false,"Bit").runMethod(true,"UnsignedShiftRight",(Object)(wobblemenu.__c.getField(false,"Bit").runMethod(true,"And",(Object)(_color),(Object)(BA.numberCast(int.class, 0xff000000)))),(Object)(BA.numberCast(int.class, 24))),BA.numberCast(int.class, 0));
 BA.debugLineNum = 652;BA.debugLine="res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0x";
Debug.ShouldStop(2048);
_res.setArrayElement (wobblemenu.__c.getField(false,"Bit").runMethod(true,"UnsignedShiftRight",(Object)(wobblemenu.__c.getField(false,"Bit").runMethod(true,"And",(Object)(_color),(Object)(BA.numberCast(int.class, 0xff0000)))),(Object)(BA.numberCast(int.class, 16))),BA.numberCast(int.class, 1));
 BA.debugLineNum = 653;BA.debugLine="res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0x";
Debug.ShouldStop(4096);
_res.setArrayElement (wobblemenu.__c.getField(false,"Bit").runMethod(true,"UnsignedShiftRight",(Object)(wobblemenu.__c.getField(false,"Bit").runMethod(true,"And",(Object)(_color),(Object)(BA.numberCast(int.class, 0xff00)))),(Object)(BA.numberCast(int.class, 8))),BA.numberCast(int.class, 2));
 BA.debugLineNum = 654;BA.debugLine="res(3) = Bit.And(Color, 0xff)";
Debug.ShouldStop(8192);
_res.setArrayElement (wobblemenu.__c.getField(false,"Bit").runMethod(true,"And",(Object)(_color),(Object)(BA.numberCast(int.class, 0xff))),BA.numberCast(int.class, 3));
 BA.debugLineNum = 655;BA.debugLine="Return res";
Debug.ShouldStop(16384);
if (true) return _res;
 BA.debugLineNum = 656;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getcurrenttab(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("GetCurrentTab (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,447);
if (RapidSub.canDelegate("getcurrenttab")) { return __ref.runUserSub(false, "wobblemenu","getcurrenttab", __ref);}
 BA.debugLineNum = 447;BA.debugLine="Public Sub GetCurrentTab As Int";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 448;BA.debugLine="Return CurrentTab";
Debug.ShouldStop(-2147483648);
if (true) return __ref.getField(true,"_currenttab" /*RemoteObject*/ );
 BA.debugLineNum = 449;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getenabletab(RemoteObject __ref,RemoteObject _tabid) throws Exception{
try {
		Debug.PushSubsStack("GetEnableTab (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,536);
if (RapidSub.canDelegate("getenabletab")) { return __ref.runUserSub(false, "wobblemenu","getenabletab", __ref, _tabid);}
Debug.locals.put("TabID", _tabid);
 BA.debugLineNum = 536;BA.debugLine="Public Sub GetEnableTab(TabID As Int) As Boolean";
Debug.ShouldStop(8388608);
 BA.debugLineNum = 537;BA.debugLine="If TabID >= 1 And TabID <= TabCount Then";
Debug.ShouldStop(16777216);
if (RemoteObject.solveBoolean("g",_tabid,BA.numberCast(int.class, 1)) && RemoteObject.solveBoolean("k",_tabid,__ref.getField(true,"_tabcount" /*RemoteObject*/ ))) { 
 BA.debugLineNum = 538;BA.debugLine="Return enabled.get(TabID-1)";
Debug.ShouldStop(33554432);
if (true) return BA.ObjectToBoolean(__ref.getField(false,"_enabled" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {_tabid,RemoteObject.createImmutable(1)}, "-",1, 1))));
 }else {
 BA.debugLineNum = 540;BA.debugLine="Log(\"Invalid Tab ID\")";
Debug.ShouldStop(134217728);
wobblemenu.__c.runVoidMethod ("LogImpl","210747908",RemoteObject.createImmutable("Invalid Tab ID"),0);
 BA.debugLineNum = 541;BA.debugLine="Return False";
Debug.ShouldStop(268435456);
if (true) return wobblemenu.__c.getField(true,"False");
 };
 BA.debugLineNum = 543;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getheight(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getHeight (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,522);
if (RapidSub.canDelegate("getheight")) { return __ref.runUserSub(false, "wobblemenu","getheight", __ref);}
 BA.debugLineNum = 522;BA.debugLine="Public Sub getHeight As Int";
Debug.ShouldStop(512);
 BA.debugLineNum = 523;BA.debugLine="Return mBase.Height";
Debug.ShouldStop(1024);
if (true) return __ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"getHeight");
 BA.debugLineNum = 524;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _icontab_click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("IconTab_Click (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,557);
if (RapidSub.canDelegate("icontab_click")) { return __ref.runUserSub(false, "wobblemenu","icontab_click", __ref);}
 BA.debugLineNum = 557;BA.debugLine="Private Sub IconTab_Click";
Debug.ShouldStop(4096);
 BA.debugLineNum = 558;BA.debugLine="TriggerTabClickEvent(Sender)";
Debug.ShouldStop(8192);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_triggertabclickevent" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), wobblemenu.__c.runMethod(false,"Sender",__ref.getField(false, "ba"))));
 BA.debugLineNum = 559;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _callback,RemoteObject _eventname) throws Exception{
try {
		Debug.PushSubsStack("Initialize (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,62);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "wobblemenu","initialize", __ref, _ba, _callback, _eventname);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
Debug.locals.put("Callback", _callback);
Debug.locals.put("EventName", _eventname);
 BA.debugLineNum = 62;BA.debugLine="Public Sub Initialize (Callback As Object, EventNa";
Debug.ShouldStop(536870912);
 BA.debugLineNum = 63;BA.debugLine="mEventName = EventName";
Debug.ShouldStop(1073741824);
__ref.setField ("_meventname" /*RemoteObject*/ ,_eventname);
 BA.debugLineNum = 64;BA.debugLine="mCallBack = Callback";
Debug.ShouldStop(-2147483648);
__ref.setField ("_mcallback" /*RemoteObject*/ ,_callback);
 BA.debugLineNum = 65;BA.debugLine="IconList.Initialize";
Debug.ShouldStop(1);
__ref.getField(false,"_iconlist" /*RemoteObject*/ ).runVoidMethod ("Initialize");
 BA.debugLineNum = 66;BA.debugLine="Tabs.Initialize";
Debug.ShouldStop(2);
__ref.getField(false,"_tabs" /*RemoteObject*/ ).runVoidMethod ("Initialize");
 BA.debugLineNum = 67;BA.debugLine="badge.Initialize";
Debug.ShouldStop(4);
__ref.getField(false,"_badge" /*RemoteObject*/ ).runVoidMethod ("Initialize");
 BA.debugLineNum = 68;BA.debugLine="enabled.Initialize2(Array As Boolean(True,True,Tr";
Debug.ShouldStop(8);
__ref.getField(false,"_enabled" /*RemoteObject*/ ).runVoidMethod ("Initialize2",(Object)(wobblemenu.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("boolean",new int[] {5},new Object[] {wobblemenu.__c.getField(true,"True"),wobblemenu.__c.getField(true,"True"),wobblemenu.__c.getField(true,"True"),wobblemenu.__c.getField(true,"True"),wobblemenu.__c.getField(true,"True")})))));
 BA.debugLineNum = 69;BA.debugLine="End Sub";
Debug.ShouldStop(16);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _removebadge(RemoteObject __ref,RemoteObject _tabid) throws Exception{
try {
		Debug.PushSubsStack("RemoveBadge (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,510);
if (RapidSub.canDelegate("removebadge")) { return __ref.runUserSub(false, "wobblemenu","removebadge", __ref, _tabid);}
RemoteObject _t = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
Debug.locals.put("TabID", _tabid);
 BA.debugLineNum = 510;BA.debugLine="Public Sub RemoveBadge(TabID As Int)";
Debug.ShouldStop(536870912);
 BA.debugLineNum = 511;BA.debugLine="If TabID >= 1 And TabID <= TabCount Then";
Debug.ShouldStop(1073741824);
if (RemoteObject.solveBoolean("g",_tabid,BA.numberCast(int.class, 1)) && RemoteObject.solveBoolean("k",_tabid,__ref.getField(true,"_tabcount" /*RemoteObject*/ ))) { 
 BA.debugLineNum = 512;BA.debugLine="badge.set(TabID-1,\"\")";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_badge" /*RemoteObject*/ ).runVoidMethod ("Set",(Object)(RemoteObject.solve(new RemoteObject[] {_tabid,RemoteObject.createImmutable(1)}, "-",1, 1)),(Object)((RemoteObject.createImmutable(""))));
 BA.debugLineNum = 513;BA.debugLine="Dim t As B4XView = Tabs.Get(TabID-1)";
Debug.ShouldStop(1);
_t = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");
_t = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), __ref.getField(false,"_tabs" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {_tabid,RemoteObject.createImmutable(1)}, "-",1, 1))));Debug.locals.put("t", _t);
 BA.debugLineNum = 514;BA.debugLine="If t.NumberOfViews = 3 Then";
Debug.ShouldStop(2);
if (RemoteObject.solveBoolean("=",_t.runMethod(true,"getNumberOfViews"),BA.numberCast(int.class, 3))) { 
 BA.debugLineNum = 515;BA.debugLine="t.GetView(2).RemoveViewFromParent";
Debug.ShouldStop(4);
_t.runMethod(false,"GetView",(Object)(BA.numberCast(int.class, 2))).runVoidMethod ("RemoveViewFromParent");
 };
 }else {
 BA.debugLineNum = 518;BA.debugLine="Log(\"Invalid Tab ID\")";
Debug.ShouldStop(32);
wobblemenu.__c.runVoidMethod ("LogImpl","29240584",RemoteObject.createImmutable("Invalid Tab ID"),0);
 };
 BA.debugLineNum = 520;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setanimationtype(RemoteObject __ref,RemoteObject _animation_type) throws Exception{
try {
		Debug.PushSubsStack("SetAnimationType (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,459);
if (RapidSub.canDelegate("setanimationtype")) { return __ref.runUserSub(false, "wobblemenu","setanimationtype", __ref, _animation_type);}
Debug.locals.put("Animation_Type", _animation_type);
 BA.debugLineNum = 459;BA.debugLine="Public Sub SetAnimationType(Animation_Type As Int)";
Debug.ShouldStop(1024);
 BA.debugLineNum = 460;BA.debugLine="AnimationType = Animation_Type";
Debug.ShouldStop(2048);
__ref.setField ("_animationtype" /*RemoteObject*/ ,_animation_type);
 BA.debugLineNum = 461;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setbadge(RemoteObject __ref,RemoteObject _tabid,RemoteObject _count,RemoteObject _backcolor,RemoteObject _txtcolor) throws Exception{
try {
		Debug.PushSubsStack("SetBadge (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,486);
if (RapidSub.canDelegate("setbadge")) { return __ref.runUserSub(false, "wobblemenu","setbadge", __ref, _tabid, _count, _backcolor, _txtcolor);}
RemoteObject _t = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
RemoteObject _l = RemoteObject.declareNull("anywheresoftware.b4a.objects.LabelWrapper");
RemoteObject _b4xlbl = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
Debug.locals.put("TabID", _tabid);
Debug.locals.put("Count", _count);
Debug.locals.put("BackColor", _backcolor);
Debug.locals.put("TxtColor", _txtcolor);
 BA.debugLineNum = 486;BA.debugLine="Public Sub SetBadge(TabID As Int, Count As Int, Ba";
Debug.ShouldStop(32);
 BA.debugLineNum = 488;BA.debugLine="If TabID >= 1 And TabID <= TabCount Then";
Debug.ShouldStop(128);
if (RemoteObject.solveBoolean("g",_tabid,BA.numberCast(int.class, 1)) && RemoteObject.solveBoolean("k",_tabid,__ref.getField(true,"_tabcount" /*RemoteObject*/ ))) { 
 BA.debugLineNum = 489;BA.debugLine="If Count>0 Then";
Debug.ShouldStop(256);
if (RemoteObject.solveBoolean(">",_count,BA.numberCast(int.class, 0))) { 
 BA.debugLineNum = 490;BA.debugLine="Dim t As B4XView = Tabs.Get(TabID-1)";
Debug.ShouldStop(512);
_t = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");
_t = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), __ref.getField(false,"_tabs" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {_tabid,RemoteObject.createImmutable(1)}, "-",1, 1))));Debug.locals.put("t", _t);
 BA.debugLineNum = 491;BA.debugLine="Dim l As Label";
Debug.ShouldStop(1024);
_l = RemoteObject.createNew ("anywheresoftware.b4a.objects.LabelWrapper");Debug.locals.put("l", _l);
 BA.debugLineNum = 492;BA.debugLine="l.Initialize(\"\")";
Debug.ShouldStop(2048);
_l.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 493;BA.debugLine="Dim b4xlbl As B4XView=l";
Debug.ShouldStop(4096);
_b4xlbl = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");
_b4xlbl = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), _l.getObject());Debug.locals.put("b4xlbl", _b4xlbl);
 BA.debugLineNum = 494;BA.debugLine="b4xlbl.TextSize=10";
Debug.ShouldStop(8192);
_b4xlbl.runMethod(true,"setTextSize",BA.numberCast(float.class, 10));
 BA.debugLineNum = 495;BA.debugLine="b4xlbl.TextColor=xui.PaintOrColorToColor(TxtCol";
Debug.ShouldStop(16384);
_b4xlbl.runMethod(true,"setTextColor",__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"PaintOrColorToColor",(Object)((_txtcolor))));
 BA.debugLineNum = 496;BA.debugLine="b4xlbl.Text = Count";
Debug.ShouldStop(32768);
_b4xlbl.runMethod(true,"setText",BA.ObjectToCharSequence(_count));
 BA.debugLineNum = 497;BA.debugLine="If Count>99 Then b4xlbl.Text = \"99+\"";
Debug.ShouldStop(65536);
if (RemoteObject.solveBoolean(">",_count,BA.numberCast(int.class, 99))) { 
_b4xlbl.runMethod(true,"setText",BA.ObjectToCharSequence("99+"));};
 BA.debugLineNum = 498;BA.debugLine="b4xlbl.SetTextAlignment(\"CENTER\",\"CENTER\")";
Debug.ShouldStop(131072);
_b4xlbl.runVoidMethod ("SetTextAlignment",(Object)(BA.ObjectToString("CENTER")),(Object)(RemoteObject.createImmutable("CENTER")));
 BA.debugLineNum = 499;BA.debugLine="t.AddView(l,(t.Width/3)*2,5dip,t.Height/3,t.Hei";
Debug.ShouldStop(262144);
_t.runVoidMethod ("AddView",(Object)((_l.getObject())),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_t.runMethod(true,"getWidth"),RemoteObject.createImmutable(3)}, "/",0, 0)),RemoteObject.createImmutable(2)}, "*",0, 0))),(Object)(wobblemenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_t.runMethod(true,"getHeight"),RemoteObject.createImmutable(3)}, "/",0, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_t.runMethod(true,"getHeight"),RemoteObject.createImmutable(3)}, "/",0, 0))));
 BA.debugLineNum = 501;BA.debugLine="b4xlbl.SetColorAndBorder(xui.PaintOrColorToColo";
Debug.ShouldStop(1048576);
_b4xlbl.runVoidMethod ("SetColorAndBorder",(Object)(__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"PaintOrColorToColor",(Object)((_backcolor)))),(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(false,"_xui" /*RemoteObject*/ ).getField(true,"Color_Transparent")),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_b4xlbl.runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0))));
 BA.debugLineNum = 503;BA.debugLine="badge.set(TabID-1,CreateMap(\"count\":Count,\"back";
Debug.ShouldStop(4194304);
__ref.getField(false,"_badge" /*RemoteObject*/ ).runVoidMethod ("Set",(Object)(RemoteObject.solve(new RemoteObject[] {_tabid,RemoteObject.createImmutable(1)}, "-",1, 1)),(Object)((wobblemenu.__c.runMethod(false, "createMap", (Object)(new RemoteObject[] {RemoteObject.createImmutable(("count")),(_count),RemoteObject.createImmutable(("backcolor")),(_backcolor),RemoteObject.createImmutable(("textcolor")),(_txtcolor)})).getObject())));
 };
 }else {
 BA.debugLineNum = 506;BA.debugLine="Log(\"Invalid Tab ID\")";
Debug.ShouldStop(33554432);
wobblemenu.__c.runVoidMethod ("LogImpl","29175060",RemoteObject.createImmutable("Invalid Tab ID"),0);
 };
 BA.debugLineNum = 508;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static void  _setcircleicon(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("SetCircleIcon (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,270);
if (RapidSub.canDelegate("setcircleicon")) { __ref.runUserSub(false, "wobblemenu","setcircleicon", __ref); return;}
ResumableSub_SetCircleIcon rsub = new ResumableSub_SetCircleIcon(null,__ref);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_SetCircleIcon extends BA.ResumableSub {
public ResumableSub_SetCircleIcon(b4a.example.wobblemenu parent,RemoteObject __ref) {
this.parent = parent;
this.__ref = __ref;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4a.example.wobblemenu parent;
RemoteObject _id = RemoteObject.createImmutable(0);
RemoteObject _cl = RemoteObject.declareNull("anywheresoftware.b4a.objects.LabelWrapper");
RemoteObject _mtab = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
RemoteObject _tl = RemoteObject.declareNull("anywheresoftware.b4a.objects.LabelWrapper");

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("SetCircleIcon (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,270);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
Debug.locals.put("_ref", __ref);
 BA.debugLineNum = 272;BA.debugLine="Dim id As Int = 0";
Debug.ShouldStop(32768);
_id = BA.numberCast(int.class, 0);Debug.locals.put("id", _id);Debug.locals.put("id", _id);
 BA.debugLineNum = 277;BA.debugLine="Select IconAppearStyle";
Debug.ShouldStop(1048576);
if (true) break;

case 1:
//select
this.state = 8;
switch (BA.switchObjectToInt(__ref.getField(true,"_iconappearstyle" /*RemoteObject*/ ),BA.numberCast(int.class, 0),BA.numberCast(int.class, 1),BA.numberCast(int.class, 2))) {
case 0: {
this.state = 3;
if (true) break;
}
case 1: {
this.state = 5;
if (true) break;
}
case 2: {
this.state = 7;
if (true) break;
}
}
if (true) break;

case 3:
//C
this.state = 8;
 BA.debugLineNum = 279;BA.debugLine="TabCircle.GetView(id+1).SetLayoutAnimated(0,Tab";
Debug.ShouldStop(4194304);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runVoidMethod ("SetLayoutAnimated",(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runMethod(true,"getLeft")),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runMethod(true,"getTop")),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runMethod(true,"getHeight")));
 BA.debugLineNum = 280;BA.debugLine="TabCircle.GetView(id+2).SetLayoutAnimated(0,Tab";
Debug.ShouldStop(8388608);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(2)}, "+",1, 1))).runVoidMethod ("SetLayoutAnimated",(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getWidth"),(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(5)}, "/",0, 0)),(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0))}, "--",2, 0))),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(BA.numberCast(int.class, 2))).runMethod(true,"getTop")),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(BA.numberCast(int.class, 2))).runMethod(true,"getHeight")));
 BA.debugLineNum = 281;BA.debugLine="TabCircle.GetView(id+1).SetVisibleAnimated(0,Tr";
Debug.ShouldStop(16777216);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runVoidMethod ("SetVisibleAnimated",(Object)(BA.numberCast(int.class, 0)),(Object)(parent.__c.getField(true,"True")));
 BA.debugLineNum = 282;BA.debugLine="TabCircle.GetView(id+2).SetVisibleAnimated(0,Tr";
Debug.ShouldStop(33554432);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(2)}, "+",1, 1))).runVoidMethod ("SetVisibleAnimated",(Object)(BA.numberCast(int.class, 0)),(Object)(parent.__c.getField(true,"True")));
 if (true) break;

case 5:
//C
this.state = 8;
 BA.debugLineNum = 284;BA.debugLine="TabCircle.GetView(id+3).SetLayoutAnimated(0,Tab";
Debug.ShouldStop(134217728);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(3)}, "+",1, 1))).runVoidMethod ("SetLayoutAnimated",(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runMethod(true,"getLeft")),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runMethod(true,"getTop")),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(2)}, "+",1, 1))).runMethod(true,"getLeft"),__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runMethod(true,"getLeft")}, "-",1, 1)),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runMethod(true,"getHeight")));
 BA.debugLineNum = 285;BA.debugLine="TabCircle.GetView(id+3).SetVisibleAnimated(0,Tr";
Debug.ShouldStop(268435456);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(3)}, "+",1, 1))).runVoidMethod ("SetVisibleAnimated",(Object)(BA.numberCast(int.class, 0)),(Object)(parent.__c.getField(true,"True")));
 if (true) break;

case 7:
//C
this.state = 8;
 BA.debugLineNum = 287;BA.debugLine="TabCircle.GetView(id).SetVisibleAnimated(0,Fals";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(_id)).runVoidMethod ("SetVisibleAnimated",(Object)(BA.numberCast(int.class, 0)),(Object)(parent.__c.getField(true,"False")));
 if (true) break;

case 8:
//C
this.state = 9;
;
 BA.debugLineNum = 289;BA.debugLine="Sleep(1)";
Debug.ShouldStop(1);
parent.__c.runVoidMethod ("Sleep",__ref.getField(false, "ba"),anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "wobblemenu", "setcircleicon"),BA.numberCast(int.class, 1));
this.state = 17;
return;
case 17:
//C
this.state = 9;
;
 BA.debugLineNum = 291;BA.debugLine="Dim cl As Label = TabCircle.GetView(id)";
Debug.ShouldStop(4);
_cl = RemoteObject.createNew ("anywheresoftware.b4a.objects.LabelWrapper");
_cl = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.LabelWrapper"), __ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(_id)).getObject());Debug.locals.put("cl", _cl);
 BA.debugLineNum = 292;BA.debugLine="Dim mTab As B4XView = Tabs.Get(CurrentTab-1)";
Debug.ShouldStop(8);
_mtab = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");
_mtab = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), __ref.getField(false,"_tabs" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_currenttab" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "-",1, 1))));Debug.locals.put("mTab", _mtab);
 BA.debugLineNum = 293;BA.debugLine="Dim tl As Label = mTab.GetView(0)";
Debug.ShouldStop(16);
_tl = RemoteObject.createNew ("anywheresoftware.b4a.objects.LabelWrapper");
_tl = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.LabelWrapper"), _mtab.runMethod(false,"GetView",(Object)(BA.numberCast(int.class, 0))).getObject());Debug.locals.put("tl", _tl);
 BA.debugLineNum = 294;BA.debugLine="cl.Text = tl.text";
Debug.ShouldStop(32);
_cl.runMethod(true,"setText",BA.ObjectToCharSequence(_tl.runMethod(true,"getText")));
 BA.debugLineNum = 301;BA.debugLine="cl.Typeface = tl.Typeface";
Debug.ShouldStop(4096);
_cl.runMethod(false,"setTypeface",_tl.runMethod(false,"getTypeface"));
 BA.debugLineNum = 304;BA.debugLine="Select IconAppearStyle";
Debug.ShouldStop(32768);
if (true) break;

case 9:
//select
this.state = 16;
switch (BA.switchObjectToInt(__ref.getField(true,"_iconappearstyle" /*RemoteObject*/ ),BA.numberCast(int.class, 0),BA.numberCast(int.class, 1),BA.numberCast(int.class, 2))) {
case 0: {
this.state = 11;
if (true) break;
}
case 1: {
this.state = 13;
if (true) break;
}
case 2: {
this.state = 15;
if (true) break;
}
}
if (true) break;

case 11:
//C
this.state = 16;
 BA.debugLineNum = 306;BA.debugLine="TabCircle.GetView(id+1).SetLayoutAnimated(800,T";
Debug.ShouldStop(131072);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runVoidMethod ("SetLayoutAnimated",(Object)(BA.numberCast(int.class, 800)),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runMethod(true,"getLeft")),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runMethod(true,"getTop")),(Object)(parent.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runMethod(true,"getHeight")));
 BA.debugLineNum = 307;BA.debugLine="TabCircle.GetView(id+2).SetLayoutAnimated(800,T";
Debug.ShouldStop(262144);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(2)}, "+",1, 1))).runVoidMethod ("SetLayoutAnimated",(Object)(BA.numberCast(int.class, 800)),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getWidth"),(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(4)}, "/",0, 0)),parent.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))}, "--",2, 0))),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(2)}, "+",1, 1))).runMethod(true,"getTop")),(Object)(parent.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(2)}, "+",1, 1))).runMethod(true,"getHeight")));
 if (true) break;

case 13:
//C
this.state = 16;
 BA.debugLineNum = 309;BA.debugLine="TabCircle.GetView(id+3).SetLayoutAnimated(800,T";
Debug.ShouldStop(1048576);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(3)}, "+",1, 1))).runVoidMethod ("SetLayoutAnimated",(Object)(BA.numberCast(int.class, 800)),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runMethod(true,"getTop")),(Object)(parent.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))),(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runMethod(true,"getHeight")));
 if (true) break;

case 15:
//C
this.state = 16;
 BA.debugLineNum = 311;BA.debugLine="TabCircle.GetView(id).SetVisibleAnimated(800,Tr";
Debug.ShouldStop(4194304);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(_id)).runVoidMethod ("SetVisibleAnimated",(Object)(BA.numberCast(int.class, 800)),(Object)(parent.__c.getField(true,"True")));
 if (true) break;

case 16:
//C
this.state = -1;
;
 BA.debugLineNum = 315;BA.debugLine="Sleep(400)";
Debug.ShouldStop(67108864);
parent.__c.runVoidMethod ("Sleep",__ref.getField(false, "ba"),anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "wobblemenu", "setcircleicon"),BA.numberCast(int.class, 400));
this.state = 18;
return;
case 18:
//C
this.state = -1;
;
 BA.debugLineNum = 319;BA.debugLine="TabCircle.GetView(id+1).SetVisibleAnimated(100,Fa";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(1)}, "+",1, 1))).runVoidMethod ("SetVisibleAnimated",(Object)(BA.numberCast(int.class, 100)),(Object)(parent.__c.getField(true,"False")));
 BA.debugLineNum = 320;BA.debugLine="TabCircle.GetView(id+2).SetVisibleAnimated(100,Fa";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(2)}, "+",1, 1))).runVoidMethod ("SetVisibleAnimated",(Object)(BA.numberCast(int.class, 100)),(Object)(parent.__c.getField(true,"False")));
 BA.debugLineNum = 321;BA.debugLine="TabCircle.GetView(id+3).SetVisibleAnimated(100,Fa";
Debug.ShouldStop(1);
__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(false,"GetView",(Object)(RemoteObject.solve(new RemoteObject[] {_id,RemoteObject.createImmutable(3)}, "+",1, 1))).runVoidMethod ("SetVisibleAnimated",(Object)(BA.numberCast(int.class, 100)),(Object)(parent.__c.getField(true,"False")));
 BA.debugLineNum = 323;BA.debugLine="End Sub";
Debug.ShouldStop(4);
if (true) break;

            }
        }
    }
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}
public static RemoteObject  _setcurrenttab(RemoteObject __ref,RemoteObject _tabid) throws Exception{
try {
		Debug.PushSubsStack("SetCurrentTab (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,451);
if (RapidSub.canDelegate("setcurrenttab")) { return __ref.runUserSub(false, "wobblemenu","setcurrenttab", __ref, _tabid);}
Debug.locals.put("TabID", _tabid);
 BA.debugLineNum = 451;BA.debugLine="Public Sub SetCurrentTab(TabID As Int)";
Debug.ShouldStop(4);
 BA.debugLineNum = 452;BA.debugLine="If TabID >= 1 And TabID <= TabCount Then";
Debug.ShouldStop(8);
if (RemoteObject.solveBoolean("g",_tabid,BA.numberCast(int.class, 1)) && RemoteObject.solveBoolean("k",_tabid,__ref.getField(true,"_tabcount" /*RemoteObject*/ ))) { 
 BA.debugLineNum = 453;BA.debugLine="TriggerTabClickEvent(Tabs.Get(TabID-1))";
Debug.ShouldStop(16);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_triggertabclickevent" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), __ref.getField(false,"_tabs" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {_tabid,RemoteObject.createImmutable(1)}, "-",1, 1)))));
 }else {
 BA.debugLineNum = 455;BA.debugLine="Log(\"Invalid Tab ID\")";
Debug.ShouldStop(64);
wobblemenu.__c.runVoidMethod ("LogImpl","28978436",RemoteObject.createImmutable("Invalid Tab ID"),0);
 };
 BA.debugLineNum = 457;BA.debugLine="End Sub";
Debug.ShouldStop(256);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setenabletab(RemoteObject __ref,RemoteObject _tabid,RemoteObject _enable) throws Exception{
try {
		Debug.PushSubsStack("SetEnableTab (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,526);
if (RapidSub.canDelegate("setenabletab")) { return __ref.runUserSub(false, "wobblemenu","setenabletab", __ref, _tabid, _enable);}
RemoteObject _t = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
Debug.locals.put("TabID", _tabid);
Debug.locals.put("enable", _enable);
 BA.debugLineNum = 526;BA.debugLine="Public Sub SetEnableTab(TabID As Int, enable As Bo";
Debug.ShouldStop(8192);
 BA.debugLineNum = 527;BA.debugLine="If TabID >= 1 And TabID <= TabCount Then";
Debug.ShouldStop(16384);
if (RemoteObject.solveBoolean("g",_tabid,BA.numberCast(int.class, 1)) && RemoteObject.solveBoolean("k",_tabid,__ref.getField(true,"_tabcount" /*RemoteObject*/ ))) { 
 BA.debugLineNum = 528;BA.debugLine="Dim t As B4XView = Tabs.Get(TabID-1)";
Debug.ShouldStop(32768);
_t = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");
_t = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), __ref.getField(false,"_tabs" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {_tabid,RemoteObject.createImmutable(1)}, "-",1, 1))));Debug.locals.put("t", _t);
 BA.debugLineNum = 529;BA.debugLine="t.Enabled = enable";
Debug.ShouldStop(65536);
_t.runMethod(true,"setEnabled",_enable);
 BA.debugLineNum = 530;BA.debugLine="enabled.Set(TabID-1,enable)";
Debug.ShouldStop(131072);
__ref.getField(false,"_enabled" /*RemoteObject*/ ).runVoidMethod ("Set",(Object)(RemoteObject.solve(new RemoteObject[] {_tabid,RemoteObject.createImmutable(1)}, "-",1, 1)),(Object)((_enable)));
 }else {
 BA.debugLineNum = 532;BA.debugLine="Log(\"Invalid Tab ID\")";
Debug.ShouldStop(524288);
wobblemenu.__c.runVoidMethod ("LogImpl","210682374",RemoteObject.createImmutable("Invalid Tab ID"),0);
 };
 BA.debugLineNum = 534;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _seticonappearstyle(RemoteObject __ref,RemoteObject _icon_appear_style) throws Exception{
try {
		Debug.PushSubsStack("SetIconAppearStyle (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,463);
if (RapidSub.canDelegate("seticonappearstyle")) { return __ref.runUserSub(false, "wobblemenu","seticonappearstyle", __ref, _icon_appear_style);}
Debug.locals.put("Icon_Appear_Style", _icon_appear_style);
 BA.debugLineNum = 463;BA.debugLine="Public Sub SetIconAppearStyle(Icon_Appear_Style As";
Debug.ShouldStop(16384);
 BA.debugLineNum = 464;BA.debugLine="IconAppearStyle = Icon_Appear_Style";
Debug.ShouldStop(32768);
__ref.setField ("_iconappearstyle" /*RemoteObject*/ ,_icon_appear_style);
 BA.debugLineNum = 465;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _settabcount(RemoteObject __ref,RemoteObject _count) throws Exception{
try {
		Debug.PushSubsStack("SetTabCount (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,469);
if (RapidSub.canDelegate("settabcount")) { return __ref.runUserSub(false, "wobblemenu","settabcount", __ref, _count);}
Debug.locals.put("count", _count);
 BA.debugLineNum = 469;BA.debugLine="Public Sub SetTabCount(count As Int)";
Debug.ShouldStop(1048576);
 BA.debugLineNum = 470;BA.debugLine="If count = 3 Or count = 5 Then";
Debug.ShouldStop(2097152);
if (RemoteObject.solveBoolean("=",_count,BA.numberCast(int.class, 3)) || RemoteObject.solveBoolean("=",_count,BA.numberCast(int.class, 5))) { 
 BA.debugLineNum = 471;BA.debugLine="If CurrentTab > count Then";
Debug.ShouldStop(4194304);
if (RemoteObject.solveBoolean(">",__ref.getField(true,"_currenttab" /*RemoteObject*/ ),_count)) { 
 BA.debugLineNum = 472;BA.debugLine="Log(\"Current Tab ID: \"&CurrentTab)";
Debug.ShouldStop(8388608);
wobblemenu.__c.runVoidMethod ("LogImpl","210616835",RemoteObject.concat(RemoteObject.createImmutable("Current Tab ID: "),__ref.getField(true,"_currenttab" /*RemoteObject*/ )),0);
 BA.debugLineNum = 473;BA.debugLine="Log(\"Cannot change tab count.\")";
Debug.ShouldStop(16777216);
wobblemenu.__c.runVoidMethod ("LogImpl","210616836",RemoteObject.createImmutable("Cannot change tab count."),0);
 }else {
 BA.debugLineNum = 475;BA.debugLine="TabCount = count";
Debug.ShouldStop(67108864);
__ref.setField ("_tabcount" /*RemoteObject*/ ,_count);
 BA.debugLineNum = 476;BA.debugLine="DrawView";
Debug.ShouldStop(134217728);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_drawview" /*RemoteObject*/ );
 };
 }else {
 BA.debugLineNum = 479;BA.debugLine="Log(\"Count must be either 5 or 3.\")";
Debug.ShouldStop(1073741824);
wobblemenu.__c.runVoidMethod ("LogImpl","210616842",RemoteObject.createImmutable("Count must be either 5 or 3."),0);
 };
 BA.debugLineNum = 481;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _settabtexticon(RemoteObject __ref,RemoteObject _tabid,RemoteObject _text,RemoteObject _icon,RemoteObject _iconfont) throws Exception{
try {
		Debug.PushSubsStack("SetTabTextIcon (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,402);
if (RapidSub.canDelegate("settabtexticon")) { return __ref.runUserSub(false, "wobblemenu","settabtexticon", __ref, _tabid, _text, _icon, _iconfont);}
RemoteObject _i = RemoteObject.declareNull("b4a.example.wobblemenu._icontype");
RemoteObject _mtab = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
RemoteObject _l = RemoteObject.declareNull("anywheresoftware.b4a.objects.LabelWrapper");
RemoteObject _lbl = RemoteObject.declareNull("anywheresoftware.b4a.objects.LabelWrapper");
Debug.locals.put("TabID", _tabid);
Debug.locals.put("Text", _text);
Debug.locals.put("Icon", _icon);
Debug.locals.put("IconFont", _iconfont);
 BA.debugLineNum = 402;BA.debugLine="Public Sub SetTabTextIcon(TabID As Int,Text As Str";
Debug.ShouldStop(131072);
 BA.debugLineNum = 404;BA.debugLine="If TabID >= 1 And TabID <= TabCount Then";
Debug.ShouldStop(524288);
if (RemoteObject.solveBoolean("g",_tabid,BA.numberCast(int.class, 1)) && RemoteObject.solveBoolean("k",_tabid,__ref.getField(true,"_tabcount" /*RemoteObject*/ ))) { 
 BA.debugLineNum = 405;BA.debugLine="Dim i As IconType:i.Initialize";
Debug.ShouldStop(1048576);
_i = RemoteObject.createNew ("b4a.example.wobblemenu._icontype");Debug.locals.put("i", _i);
 BA.debugLineNum = 405;BA.debugLine="Dim i As IconType:i.Initialize";
Debug.ShouldStop(1048576);
_i.runVoidMethod ("Initialize");
 BA.debugLineNum = 406;BA.debugLine="i.icon = Icon";
Debug.ShouldStop(2097152);
_i.setField ("Icon" /*RemoteObject*/ ,_icon);
 BA.debugLineNum = 407;BA.debugLine="i.Text = Text";
Debug.ShouldStop(4194304);
_i.setField ("Text" /*RemoteObject*/ ,_text);
 BA.debugLineNum = 408;BA.debugLine="i.ifont = IconFont";
Debug.ShouldStop(8388608);
_i.setField ("iFont" /*RemoteObject*/ ,_iconfont);
 BA.debugLineNum = 409;BA.debugLine="IconList.set(TabID-1,i)";
Debug.ShouldStop(16777216);
__ref.getField(false,"_iconlist" /*RemoteObject*/ ).runVoidMethod ("Set",(Object)(RemoteObject.solve(new RemoteObject[] {_tabid,RemoteObject.createImmutable(1)}, "-",1, 1)),(Object)((_i)));
 BA.debugLineNum = 411;BA.debugLine="Dim mTab As B4XView = Tabs.Get(TabID-1)";
Debug.ShouldStop(67108864);
_mtab = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");
_mtab = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), __ref.getField(false,"_tabs" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {_tabid,RemoteObject.createImmutable(1)}, "-",1, 1))));Debug.locals.put("mTab", _mtab);
 BA.debugLineNum = 412;BA.debugLine="Dim l As Label = mTab.GetView(0)";
Debug.ShouldStop(134217728);
_l = RemoteObject.createNew ("anywheresoftware.b4a.objects.LabelWrapper");
_l = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.LabelWrapper"), _mtab.runMethod(false,"GetView",(Object)(BA.numberCast(int.class, 0))).getObject());Debug.locals.put("l", _l);
 BA.debugLineNum = 413;BA.debugLine="l.Text = Icon";
Debug.ShouldStop(268435456);
_l.runMethod(true,"setText",BA.ObjectToCharSequence(_icon));
 BA.debugLineNum = 421;BA.debugLine="l.Typeface = IconFont";
Debug.ShouldStop(16);
_l.runMethod(false,"setTypeface",(_iconfont.getObject()));
 BA.debugLineNum = 424;BA.debugLine="If Text = \"\" Then";
Debug.ShouldStop(128);
if (RemoteObject.solveBoolean("=",_text,BA.ObjectToString(""))) { 
 BA.debugLineNum = 428;BA.debugLine="l.Height=mTab.Height";
Debug.ShouldStop(2048);
_l.runMethod(true,"setHeight",_mtab.runMethod(true,"getHeight"));
 }else {
 BA.debugLineNum = 434;BA.debugLine="l.Height=(mTab.Height/3)*2";
Debug.ShouldStop(131072);
_l.runMethod(true,"setHeight",BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_mtab.runMethod(true,"getHeight"),RemoteObject.createImmutable(3)}, "/",0, 0)),RemoteObject.createImmutable(2)}, "*",0, 0)));
 };
 BA.debugLineNum = 438;BA.debugLine="Dim lbl As Label = mTab.GetView(1)";
Debug.ShouldStop(2097152);
_lbl = RemoteObject.createNew ("anywheresoftware.b4a.objects.LabelWrapper");
_lbl = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.LabelWrapper"), _mtab.runMethod(false,"GetView",(Object)(BA.numberCast(int.class, 1))).getObject());Debug.locals.put("lbl", _lbl);
 BA.debugLineNum = 439;BA.debugLine="lbl.Text = Text";
Debug.ShouldStop(4194304);
_lbl.runMethod(true,"setText",BA.ObjectToCharSequence(_text));
 BA.debugLineNum = 441;BA.debugLine="SetCircleIcon";
Debug.ShouldStop(16777216);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_setcircleicon" /*void*/ );
 }else {
 BA.debugLineNum = 443;BA.debugLine="Log(\"Invalid Tab ID\")";
Debug.ShouldStop(67108864);
wobblemenu.__c.runVoidMethod ("LogImpl","28847401",RemoteObject.createImmutable("Invalid Tab ID"),0);
 };
 BA.debugLineNum = 445;BA.debugLine="End Sub";
Debug.ShouldStop(268435456);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _timewiseposition(RemoteObject __ref,RemoteObject _ctime,RemoteObject _frompos,RemoteObject _topos,RemoteObject _duration) throws Exception{
try {
		Debug.PushSubsStack("TimeWisePosition (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,608);
if (RapidSub.canDelegate("timewiseposition")) { return __ref.runUserSub(false, "wobblemenu","timewiseposition", __ref, _ctime, _frompos, _topos, _duration);}
RemoteObject _ts = RemoteObject.createImmutable(0f);
RemoteObject _tc = RemoteObject.createImmutable(0f);
Debug.locals.put("ctime", _ctime);
Debug.locals.put("fromPos", _frompos);
Debug.locals.put("toPos", _topos);
Debug.locals.put("duration", _duration);
 BA.debugLineNum = 608;BA.debugLine="Private Sub TimeWisePosition(ctime As Float, fromP";
Debug.ShouldStop(-2147483648);
 BA.debugLineNum = 609;BA.debugLine="Dim ts,tc As Float";
Debug.ShouldStop(1);
_ts = RemoteObject.createImmutable(0f);Debug.locals.put("ts", _ts);
_tc = RemoteObject.createImmutable(0f);Debug.locals.put("tc", _tc);
 BA.debugLineNum = 610;BA.debugLine="ctime = ctime/duration";
Debug.ShouldStop(2);
_ctime = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_ctime,_duration}, "/",0, 0));Debug.locals.put("ctime", _ctime);
 BA.debugLineNum = 611;BA.debugLine="ts=ctime*ctime";
Debug.ShouldStop(4);
_ts = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_ctime,_ctime}, "*",0, 0));Debug.locals.put("ts", _ts);
 BA.debugLineNum = 612;BA.debugLine="tc=ts*ctime";
Debug.ShouldStop(8);
_tc = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_ts,_ctime}, "*",0, 0));Debug.locals.put("tc", _tc);
 BA.debugLineNum = 614;BA.debugLine="Select AnimationType";
Debug.ShouldStop(32);
switch (BA.switchObjectToInt(__ref.getField(true,"_animationtype" /*RemoteObject*/ ),BA.numberCast(int.class, 0),BA.numberCast(int.class, 1),BA.numberCast(int.class, 2),BA.numberCast(int.class, 3))) {
case 0: {
 BA.debugLineNum = 616;BA.debugLine="Return fromPos + toPos * (23.645*tc*ts + -73.73";
Debug.ShouldStop(128);
if (true) return BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_frompos,_topos,RemoteObject.createImmutable((23.645*(double) (0 + _tc.<Float>get().floatValue())*(double) (0 + _ts.<Float>get().floatValue())+-73.7325*(double) (0 + _ts.<Float>get().floatValue())*(double) (0 + _ts.<Float>get().floatValue())+86.38*(double) (0 + _tc.<Float>get().floatValue())+-46.79*(double) (0 + _ts.<Float>get().floatValue())+11.4975*(double) (0 + _ctime.<Float>get().floatValue())))}, "+*",1, 0));
 break; }
case 1: {
 BA.debugLineNum = 618;BA.debugLine="Return fromPos + toPos * (34.445*tc*ts + -69.39";
Debug.ShouldStop(512);
if (true) return BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_frompos,_topos,RemoteObject.createImmutable((34.445*(double) (0 + _tc.<Float>get().floatValue())*(double) (0 + _ts.<Float>get().floatValue())+-69.39*(double) (0 + _ts.<Float>get().floatValue())*(double) (0 + _ts.<Float>get().floatValue())+47.395*(double) (0 + _tc.<Float>get().floatValue())+-12.4*(double) (0 + _ts.<Float>get().floatValue())+0.95*(double) (0 + _ctime.<Float>get().floatValue())))}, "+*",1, 0));
 break; }
case 2: {
 BA.debugLineNum = 620;BA.debugLine="Return fromPos + toPos * (tc*ts + -5*ts*ts + 10";
Debug.ShouldStop(2048);
if (true) return BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_frompos,_topos,RemoteObject.createImmutable(((double) (0 + _tc.<Float>get().floatValue())*(double) (0 + _ts.<Float>get().floatValue())+-(double) (0 + 5)*(double) (0 + _ts.<Float>get().floatValue())*(double) (0 + _ts.<Float>get().floatValue())+(double) (0 + 10)*(double) (0 + _tc.<Float>get().floatValue())+-(double) (0 + 10)*(double) (0 + _ts.<Float>get().floatValue())+(double) (0 + 5)*(double) (0 + _ctime.<Float>get().floatValue())))}, "+*",1, 0));
 break; }
case 3: {
 BA.debugLineNum = 622;BA.debugLine="Return fromPos + toPos * (tc*ts)";
Debug.ShouldStop(8192);
if (true) return BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_frompos,_topos,(RemoteObject.solve(new RemoteObject[] {_tc,_ts}, "*",0, 0))}, "+*",1, 0));
 break; }
default: {
 BA.debugLineNum = 624;BA.debugLine="Return fromPos + toPos*(ctime)";
Debug.ShouldStop(32768);
if (true) return BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_frompos,_topos,(_ctime)}, "+*",1, 0));
 break; }
}
;
 BA.debugLineNum = 627;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _triggertabclickevent(RemoteObject __ref,RemoteObject _t) throws Exception{
try {
		Debug.PushSubsStack("TriggerTabClickEvent (wobblemenu) ","wobblemenu",3,__ref.getField(false, "ba"),__ref,563);
if (RapidSub.canDelegate("triggertabclickevent")) { return __ref.runUserSub(false, "wobblemenu","triggertabclickevent", __ref, _t);}
int _i = 0;
RemoteObject _tb = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
Debug.locals.put("t", _t);
 BA.debugLineNum = 563;BA.debugLine="Private Sub TriggerTabClickEvent(t As B4XView)";
Debug.ShouldStop(262144);
 BA.debugLineNum = 564;BA.debugLine="If CurrentTab <> Tabs.IndexOf(t)+1 Then CurrentTa";
Debug.ShouldStop(524288);
if (RemoteObject.solveBoolean("!",__ref.getField(true,"_currenttab" /*RemoteObject*/ ),RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabs" /*RemoteObject*/ ).runMethod(true,"IndexOf",(Object)((_t.getObject()))),RemoteObject.createImmutable(1)}, "+",1, 1))) { 
__ref.setField ("_currenttab" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabs" /*RemoteObject*/ ).runMethod(true,"IndexOf",(Object)((_t.getObject()))),RemoteObject.createImmutable(1)}, "+",1, 1));};
 BA.debugLineNum = 565;BA.debugLine="AnimateTo(TabCurve,t.Left+(t.Width/2)-(TabCurve.W";
Debug.ShouldStop(1048576);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_animateto" /*void*/ ,(Object)(__ref.getField(false,"_tabcurve" /*RemoteObject*/ )),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_t.runMethod(true,"getLeft"),(RemoteObject.solve(new RemoteObject[] {_t.runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0)),(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcurve" /*RemoteObject*/ ).runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0)),RemoteObject.createImmutable(1)}, "+--",3, 0))));
 BA.debugLineNum = 566;BA.debugLine="AnimateTo(TabCircle,t.Left+(t.Width/2)-(TabCircle";
Debug.ShouldStop(2097152);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_animateto" /*void*/ ,(Object)(__ref.getField(false,"_tabcircle" /*RemoteObject*/ )),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_t.runMethod(true,"getLeft"),(RemoteObject.solve(new RemoteObject[] {_t.runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0)),(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_tabcircle" /*RemoteObject*/ ).runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0))}, "+-",2, 0))));
 BA.debugLineNum = 568;BA.debugLine="For i=0 To TabCount-1";
Debug.ShouldStop(8388608);
{
final int step4 = 1;
final int limit4 = RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_tabcount" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step4 > 0 && _i <= limit4) || (step4 < 0 && _i >= limit4) ;_i = ((int)(0 + _i + step4))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 569;BA.debugLine="Dim tb As B4XView = Tabs.Get(i)";
Debug.ShouldStop(16777216);
_tb = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");
_tb = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), __ref.getField(false,"_tabs" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("tb", _tb);
 BA.debugLineNum = 570;BA.debugLine="If tb<>t Then";
Debug.ShouldStop(33554432);
if (RemoteObject.solveBoolean("!",_tb,_t)) { 
 BA.debugLineNum = 571;BA.debugLine="tb.GetView(0).Visible = True";
Debug.ShouldStop(67108864);
_tb.runMethod(false,"GetView",(Object)(BA.numberCast(int.class, 0))).runMethod(true,"setVisible",wobblemenu.__c.getField(true,"True"));
 BA.debugLineNum = 572;BA.debugLine="tb.GetView(1).Visible = True";
Debug.ShouldStop(134217728);
_tb.runMethod(false,"GetView",(Object)(BA.numberCast(int.class, 1))).runMethod(true,"setVisible",wobblemenu.__c.getField(true,"True"));
 BA.debugLineNum = 573;BA.debugLine="If tb.NumberOfViews = 3 Then tb.GetView(2).Visi";
Debug.ShouldStop(268435456);
if (RemoteObject.solveBoolean("=",_tb.runMethod(true,"getNumberOfViews"),BA.numberCast(int.class, 3))) { 
_tb.runMethod(false,"GetView",(Object)(BA.numberCast(int.class, 2))).runMethod(true,"setVisible",wobblemenu.__c.getField(true,"True"));};
 }else {
 BA.debugLineNum = 575;BA.debugLine="tb.GetView(0).Visible = False";
Debug.ShouldStop(1073741824);
_tb.runMethod(false,"GetView",(Object)(BA.numberCast(int.class, 0))).runMethod(true,"setVisible",wobblemenu.__c.getField(true,"False"));
 BA.debugLineNum = 576;BA.debugLine="tb.GetView(1).Visible = False";
Debug.ShouldStop(-2147483648);
_tb.runMethod(false,"GetView",(Object)(BA.numberCast(int.class, 1))).runMethod(true,"setVisible",wobblemenu.__c.getField(true,"False"));
 BA.debugLineNum = 577;BA.debugLine="If tb.NumberOfViews = 3 Then tb.GetView(2).Visi";
Debug.ShouldStop(1);
if (RemoteObject.solveBoolean("=",_tb.runMethod(true,"getNumberOfViews"),BA.numberCast(int.class, 3))) { 
_tb.runMethod(false,"GetView",(Object)(BA.numberCast(int.class, 2))).runMethod(true,"setVisible",wobblemenu.__c.getField(true,"False"));};
 };
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 580;BA.debugLine="SetCircleIcon";
Debug.ShouldStop(8);
__ref.runClassMethod (b4a.example.wobblemenu.class, "_setcircleicon" /*void*/ );
 BA.debugLineNum = 582;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_Tab\"&C";
Debug.ShouldStop(32);
if (__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback" /*RemoteObject*/ )),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname" /*RemoteObject*/ ),RemoteObject.createImmutable("_Tab"),__ref.getField(true,"_currenttab" /*RemoteObject*/ ),RemoteObject.createImmutable("Click"))),(Object)(BA.numberCast(int.class, 0))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 583;BA.debugLine="CallSub(mCallBack, mEventName & \"_Tab\"&CurrentTa";
Debug.ShouldStop(64);
wobblemenu.__c.runMethodAndSync(false,"CallSubNew",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback" /*RemoteObject*/ )),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname" /*RemoteObject*/ ),RemoteObject.createImmutable("_Tab"),__ref.getField(true,"_currenttab" /*RemoteObject*/ ),RemoteObject.createImmutable("Click"))));
 };
 BA.debugLineNum = 585;BA.debugLine="End Sub";
Debug.ShouldStop(256);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}