package b4a.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class td_swipepanel_subs_0 {


public static RemoteObject  _base_resize(RemoteObject __ref,RemoteObject _width,RemoteObject _height) throws Exception{
try {
		Debug.PushSubsStack("Base_Resize (td_swipepanel) ","td_swipepanel",2,__ref.getField(false, "ba"),__ref,86);
if (RapidSub.canDelegate("base_resize")) { return __ref.runUserSub(false, "td_swipepanel","base_resize", __ref, _width, _height);}
Debug.locals.put("Width", _width);
Debug.locals.put("Height", _height);
 BA.debugLineNum = 86;BA.debugLine="Private Sub Base_Resize (Width As Double, Height A";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 88;BA.debugLine="End Sub";
Debug.ShouldStop(8388608);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 49;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 50;BA.debugLine="Private mEventName As String 'ignore";
td_swipepanel._meventname = RemoteObject.createImmutable("");__ref.setField("_meventname",td_swipepanel._meventname);
 //BA.debugLineNum = 51;BA.debugLine="Private mCallBack As Object 'ignore";
td_swipepanel._mcallback = RemoteObject.createNew ("Object");__ref.setField("_mcallback",td_swipepanel._mcallback);
 //BA.debugLineNum = 52;BA.debugLine="Public mBase As B4XView";
td_swipepanel._mbase = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_mbase",td_swipepanel._mbase);
 //BA.debugLineNum = 53;BA.debugLine="Private xui As XUI 'ignore";
td_swipepanel._xui = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");__ref.setField("_xui",td_swipepanel._xui);
 //BA.debugLineNum = 54;BA.debugLine="Public Tag As Object";
td_swipepanel._tag = RemoteObject.createNew ("Object");__ref.setField("_tag",td_swipepanel._tag);
 //BA.debugLineNum = 56;BA.debugLine="Public XScrollView As ScrollView2D";
td_swipepanel._xscrollview = RemoteObject.createNew ("flm.b4a.scrollview2d.ScrollView2DWrapper");__ref.setField("_xscrollview",td_swipepanel._xscrollview);
 //BA.debugLineNum = 57;BA.debugLine="Private mprops As Map";
td_swipepanel._mprops = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");__ref.setField("_mprops",td_swipepanel._mprops);
 //BA.debugLineNum = 58;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _designercreateview(RemoteObject __ref,RemoteObject _base,RemoteObject _lbl,RemoteObject _props) throws Exception{
try {
		Debug.PushSubsStack("DesignerCreateView (td_swipepanel) ","td_swipepanel",2,__ref.getField(false, "ba"),__ref,71);
if (RapidSub.canDelegate("designercreateview")) { return __ref.runUserSub(false, "td_swipepanel","designercreateview", __ref, _base, _lbl, _props);}
Debug.locals.put("Base", _base);
Debug.locals.put("Lbl", _lbl);
Debug.locals.put("Props", _props);
 BA.debugLineNum = 71;BA.debugLine="Public Sub DesignerCreateView (Base As Object, Lbl";
Debug.ShouldStop(64);
 BA.debugLineNum = 72;BA.debugLine="mBase = Base";
Debug.ShouldStop(128);
__ref.getField(false,"_mbase" /*RemoteObject*/ ).setObject (_base);
 BA.debugLineNum = 73;BA.debugLine="Tag = mBase.Tag";
Debug.ShouldStop(256);
__ref.setField ("_tag" /*RemoteObject*/ ,__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(false,"getTag"));
 BA.debugLineNum = 74;BA.debugLine="mBase.Tag = Me";
Debug.ShouldStop(512);
__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(false,"setTag",__ref);
 BA.debugLineNum = 76;BA.debugLine="mprops = Props";
Debug.ShouldStop(2048);
__ref.setField ("_mprops" /*RemoteObject*/ ,_props);
 BA.debugLineNum = 77;BA.debugLine="Log(mprops)";
Debug.ShouldStop(4096);
td_swipepanel.__c.runVoidMethod ("LogImpl","21048582",BA.ObjectToString(__ref.getField(false,"_mprops" /*RemoteObject*/ )),0);
 BA.debugLineNum = 80;BA.debugLine="XScrollView.Initialize(mBase.width,mBase.height,\"";
Debug.ShouldStop(32768);
__ref.getField(false,"_xscrollview" /*RemoteObject*/ ).runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"getHeight")),(Object)(RemoteObject.createImmutable("XScrollview")));
 BA.debugLineNum = 81;BA.debugLine="If Props.get(\"layout\") <> \"\" Then setLayoutFile(P";
Debug.ShouldStop(65536);
if (RemoteObject.solveBoolean("!",_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("layout")))),RemoteObject.createImmutable(("")))) { 
__ref.runClassMethod (b4a.example.td_swipepanel.class, "_setlayoutfile" /*void*/ ,(Object)(BA.ObjectToString(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("layout")))))));};
 BA.debugLineNum = 83;BA.debugLine="mBase.AddView(XScrollView,0,0,mBase.width,mBase.h";
Debug.ShouldStop(262144);
__ref.getField(false,"_mbase" /*RemoteObject*/ ).runVoidMethod ("AddView",(Object)((__ref.getField(false,"_xscrollview" /*RemoteObject*/ ).getObject())),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_mbase" /*RemoteObject*/ ).runMethod(true,"getHeight")));
 BA.debugLineNum = 84;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
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
		Debug.PushSubsStack("Initialize (td_swipepanel) ","td_swipepanel",2,__ref.getField(false, "ba"),__ref,61);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "td_swipepanel","initialize", __ref, _ba, _callback, _eventname);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
Debug.locals.put("Callback", _callback);
Debug.locals.put("EventName", _eventname);
 BA.debugLineNum = 61;BA.debugLine="Public Sub Initialize (Callback As Object, EventNa";
Debug.ShouldStop(268435456);
 BA.debugLineNum = 62;BA.debugLine="mEventName = EventName";
Debug.ShouldStop(536870912);
__ref.setField ("_meventname" /*RemoteObject*/ ,_eventname);
 BA.debugLineNum = 63;BA.debugLine="mCallBack = Callback";
Debug.ShouldStop(1073741824);
__ref.setField ("_mcallback" /*RemoteObject*/ ,_callback);
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
public static void  _setlayoutfile(RemoteObject __ref,RemoteObject _layout) throws Exception{
try {
		Debug.PushSubsStack("setLayoutFile (td_swipepanel) ","td_swipepanel",2,__ref.getField(false, "ba"),__ref,95);
if (RapidSub.canDelegate("setlayoutfile")) { __ref.runUserSub(false, "td_swipepanel","setlayoutfile", __ref, _layout); return;}
ResumableSub_setLayoutFile rsub = new ResumableSub_setLayoutFile(null,__ref,_layout);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_setLayoutFile extends BA.ResumableSub {
public ResumableSub_setLayoutFile(b4a.example.td_swipepanel parent,RemoteObject __ref,RemoteObject _layout) {
this.parent = parent;
this.__ref = __ref;
this._layout = _layout;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4a.example.td_swipepanel parent;
RemoteObject _layout;
RemoteObject _w = RemoteObject.createImmutable(0);
RemoteObject _h = RemoteObject.createImmutable(0);
RemoteObject _v = RemoteObject.declareNull("Object");
RemoteObject group6;
int index6;
int groupLen6;

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("setLayoutFile (td_swipepanel) ","td_swipepanel",2,__ref.getField(false, "ba"),__ref,95);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
try {

        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
Debug.locals.put("_ref", __ref);
Debug.locals.put("Layout", _layout);
 BA.debugLineNum = 96;BA.debugLine="Try";
Debug.ShouldStop(-2147483648);
if (true) break;

case 1:
//try
this.state = 22;
this.catchState = 21;
this.state = 3;
if (true) break;

case 3:
//C
this.state = 4;
this.catchState = 21;
 BA.debugLineNum = 98;BA.debugLine="Sleep(0)";
Debug.ShouldStop(2);
parent.__c.runVoidMethod ("Sleep",__ref.getField(false, "ba"),anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "td_swipepanel", "setlayoutfile"),BA.numberCast(int.class, 0));
this.state = 23;
return;
case 23:
//C
this.state = 4;
;
 BA.debugLineNum = 99;BA.debugLine="XScrollView.Panel.RemoveAllViews";
Debug.ShouldStop(4);
__ref.getField(false,"_xscrollview" /*RemoteObject*/ ).runMethod(false,"getPanel").runVoidMethod ("RemoveAllViews");
 BA.debugLineNum = 100;BA.debugLine="XScrollView.panel.LoadLayout(Layout)";
Debug.ShouldStop(8);
__ref.getField(false,"_xscrollview" /*RemoteObject*/ ).runMethod(false,"getPanel").runMethodAndSync(false,"LoadLayout",(Object)(_layout),__ref.getField(false, "ba"));
 BA.debugLineNum = 102;BA.debugLine="Dim w,h As Int";
Debug.ShouldStop(32);
_w = RemoteObject.createImmutable(0);Debug.locals.put("w", _w);
_h = RemoteObject.createImmutable(0);Debug.locals.put("h", _h);
 BA.debugLineNum = 103;BA.debugLine="For Each v As Object In XScrollView.panel.getall";
Debug.ShouldStop(64);
if (true) break;

case 4:
//for
this.state = 19;
group6 = __ref.getField(false,"_xscrollview" /*RemoteObject*/ ).runMethod(false,"getPanel").runMethod(false,"GetAllViewsRecursive");
index6 = 0;
groupLen6 = group6.runMethod(true,"getSize").<Integer>get();
Debug.locals.put("v", _v);
this.state = 24;
if (true) break;

case 24:
//C
this.state = 19;
if (index6 < groupLen6) {
this.state = 6;
_v = group6.runMethod(false,"Get",index6);Debug.locals.put("v", _v);}
if (true) break;

case 25:
//C
this.state = 24;
index6++;
Debug.locals.put("v", _v);
if (true) break;

case 6:
//C
this.state = 7;
 BA.debugLineNum = 104;BA.debugLine="If v.As(View).Left + v.As(View).Width > w Then";
Debug.ShouldStop(128);
if (true) break;

case 7:
//if
this.state = 12;
if (RemoteObject.solveBoolean(">",RemoteObject.solve(new RemoteObject[] {(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.ConcreteViewWrapper"), _v)).runMethod(true,"getLeft"),(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.ConcreteViewWrapper"), _v)).runMethod(true,"getWidth")}, "+",1, 1),BA.numberCast(double.class, _w))) { 
this.state = 9;
;}if (true) break;

case 9:
//C
this.state = 12;
_w = RemoteObject.solve(new RemoteObject[] {(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.ConcreteViewWrapper"), _v)).runMethod(true,"getLeft"),(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.ConcreteViewWrapper"), _v)).runMethod(true,"getWidth")}, "+",1, 1);Debug.locals.put("w", _w);
if (true) break;

case 12:
//C
this.state = 13;
;
 BA.debugLineNum = 105;BA.debugLine="If v.As(View).Top + v.As(View).Height > h Then";
Debug.ShouldStop(256);
if (true) break;

case 13:
//if
this.state = 18;
if (RemoteObject.solveBoolean(">",RemoteObject.solve(new RemoteObject[] {(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.ConcreteViewWrapper"), _v)).runMethod(true,"getTop"),(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.ConcreteViewWrapper"), _v)).runMethod(true,"getHeight")}, "+",1, 1),BA.numberCast(double.class, _h))) { 
this.state = 15;
;}if (true) break;

case 15:
//C
this.state = 18;
_h = RemoteObject.solve(new RemoteObject[] {(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.ConcreteViewWrapper"), _v)).runMethod(true,"getTop"),(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.ConcreteViewWrapper"), _v)).runMethod(true,"getHeight")}, "+",1, 1);Debug.locals.put("h", _h);
if (true) break;

case 18:
//C
this.state = 25;
;
 if (true) break;
if (true) break;

case 19:
//C
this.state = 22;
Debug.locals.put("v", _v);
;
 BA.debugLineNum = 107;BA.debugLine="w = w + w *	mprops.get(\"oversize\")/100";
Debug.ShouldStop(1024);
_w = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_w,_w,BA.numberCast(double.class, __ref.getField(false,"_mprops" /*RemoteObject*/ ).runMethod(false,"Get",(Object)((RemoteObject.createImmutable("oversize"))))),RemoteObject.createImmutable(100)}, "+*/",1, 0));Debug.locals.put("w", _w);
 BA.debugLineNum = 108;BA.debugLine="h = h + h *	mprops.get(\"oversize\")/100";
Debug.ShouldStop(2048);
_h = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_h,_h,BA.numberCast(double.class, __ref.getField(false,"_mprops" /*RemoteObject*/ ).runMethod(false,"Get",(Object)((RemoteObject.createImmutable("oversize"))))),RemoteObject.createImmutable(100)}, "+*/",1, 0));Debug.locals.put("h", _h);
 BA.debugLineNum = 109;BA.debugLine="XScrollView.panel.Width = w";
Debug.ShouldStop(4096);
__ref.getField(false,"_xscrollview" /*RemoteObject*/ ).runMethod(false,"getPanel").runMethod(true,"setWidth",_w);
 BA.debugLineNum = 110;BA.debugLine="XScrollView.panel.height = h";
Debug.ShouldStop(8192);
__ref.getField(false,"_xscrollview" /*RemoteObject*/ ).runMethod(false,"getPanel").runMethod(true,"setHeight",_h);
 Debug.CheckDeviceExceptions();
if (true) break;

case 21:
//C
this.state = 22;
this.catchState = 0;
 BA.debugLineNum = 112;BA.debugLine="Log(LastException)";
Debug.ShouldStop(32768);
parent.__c.runVoidMethod ("LogImpl","21179665",BA.ObjectToString(parent.__c.runMethod(false,"LastException",__ref.getField(false, "ba"))),0);
 if (true) break;
if (true) break;

case 22:
//C
this.state = -1;
this.catchState = 0;
;
 BA.debugLineNum = 114;BA.debugLine="End Sub";
Debug.ShouldStop(131072);
if (true) break;
}} 
       catch (Exception e0) {
			
if (catchState == 0)
    throw e0;
else {
    state = catchState;
BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e0.toString());}
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
public static RemoteObject  _xscrollview_scrollchanged(RemoteObject __ref,RemoteObject _posx,RemoteObject _posy) throws Exception{
try {
		Debug.PushSubsStack("XScrollView_ScrollChanged (td_swipepanel) ","td_swipepanel",2,__ref.getField(false, "ba"),__ref,119);
if (RapidSub.canDelegate("xscrollview_scrollchanged")) { return __ref.runUserSub(false, "td_swipepanel","xscrollview_scrollchanged", __ref, _posx, _posy);}
Debug.locals.put("PosX", _posx);
Debug.locals.put("PosY", _posy);
 BA.debugLineNum = 119;BA.debugLine="Private Sub XScrollView_ScrollChanged(PosX As Int,";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 120;BA.debugLine="If SubExists(mCallBack, mEventName & \"_ScrollChan";
Debug.ShouldStop(8388608);
if (td_swipepanel.__c.runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback" /*RemoteObject*/ )),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname" /*RemoteObject*/ ),RemoteObject.createImmutable("_ScrollChanged")))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 121;BA.debugLine="CallSub3(mCallBack, mEventName & \"_ScrollChanged";
Debug.ShouldStop(16777216);
td_swipepanel.__c.runMethodAndSync(false,"CallSubNew3",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback" /*RemoteObject*/ )),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname" /*RemoteObject*/ ),RemoteObject.createImmutable("_ScrollChanged"))),(Object)((_posx)),(Object)((_posy)));
 };
 BA.debugLineNum = 123;BA.debugLine="End Sub";
Debug.ShouldStop(67108864);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}