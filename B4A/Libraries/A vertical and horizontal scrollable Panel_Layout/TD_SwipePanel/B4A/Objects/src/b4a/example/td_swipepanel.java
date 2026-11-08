package b4a.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.debug.*;

public class td_swipepanel extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    private static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new anywheresoftware.b4a.ShellBA(_ba, this, htSubs, "b4a.example.td_swipepanel");
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            
        }
        if (BA.isShellModeRuntimeCheck(ba)) 
			   this.getClass().getMethod("_class_globals", b4a.example.td_swipepanel.class).invoke(this, new Object[] {null});
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
public String _meventname = "";
public Object _mcallback = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _mbase = null;
public anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public Object _tag = null;
public flm.b4a.scrollview2d.ScrollView2DWrapper _xscrollview = null;
public anywheresoftware.b4a.objects.collections.Map _mprops = null;
public b4a.example.main _main = null;
public b4a.example.starter _starter = null;
public b4a.example.b4xpages _b4xpages = null;
public b4a.example.b4xcollections _b4xcollections = null;
public String  _base_resize(b4a.example.td_swipepanel __ref,double _width,double _height) throws Exception{
__ref = this;
RDebugUtils.currentModule="td_swipepanel";
if (Debug.shouldDelegate(ba, "base_resize", false))
	 {return ((String) Debug.delegate(ba, "base_resize", new Object[] {_width,_height}));}
RDebugUtils.currentLine=1114112;
 //BA.debugLineNum = 1114112;BA.debugLine="Private Sub Base_Resize (Width As Double, Height A";
RDebugUtils.currentLine=1114114;
 //BA.debugLineNum = 1114114;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4a.example.td_swipepanel __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="td_swipepanel";
RDebugUtils.currentLine=917504;
 //BA.debugLineNum = 917504;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=917505;
 //BA.debugLineNum = 917505;BA.debugLine="Private mEventName As String 'ignore";
_meventname = "";
RDebugUtils.currentLine=917506;
 //BA.debugLineNum = 917506;BA.debugLine="Private mCallBack As Object 'ignore";
_mcallback = new Object();
RDebugUtils.currentLine=917507;
 //BA.debugLineNum = 917507;BA.debugLine="Public mBase As B4XView";
_mbase = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=917508;
 //BA.debugLineNum = 917508;BA.debugLine="Private xui As XUI 'ignore";
_xui = new anywheresoftware.b4a.objects.B4XViewWrapper.XUI();
RDebugUtils.currentLine=917509;
 //BA.debugLineNum = 917509;BA.debugLine="Public Tag As Object";
_tag = new Object();
RDebugUtils.currentLine=917511;
 //BA.debugLineNum = 917511;BA.debugLine="Public XScrollView As ScrollView2D";
_xscrollview = new flm.b4a.scrollview2d.ScrollView2DWrapper();
RDebugUtils.currentLine=917512;
 //BA.debugLineNum = 917512;BA.debugLine="Private mprops As Map";
_mprops = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=917513;
 //BA.debugLineNum = 917513;BA.debugLine="End Sub";
return "";
}
public String  _designercreateview(b4a.example.td_swipepanel __ref,Object _base,anywheresoftware.b4a.objects.LabelWrapper _lbl,anywheresoftware.b4a.objects.collections.Map _props) throws Exception{
__ref = this;
RDebugUtils.currentModule="td_swipepanel";
if (Debug.shouldDelegate(ba, "designercreateview", false))
	 {return ((String) Debug.delegate(ba, "designercreateview", new Object[] {_base,_lbl,_props}));}
RDebugUtils.currentLine=1048576;
 //BA.debugLineNum = 1048576;BA.debugLine="Public Sub DesignerCreateView (Base As Object, Lbl";
RDebugUtils.currentLine=1048577;
 //BA.debugLineNum = 1048577;BA.debugLine="mBase = Base";
__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(_base));
RDebugUtils.currentLine=1048578;
 //BA.debugLineNum = 1048578;BA.debugLine="Tag = mBase.Tag";
__ref._tag /*Object*/  = __ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTag();
RDebugUtils.currentLine=1048579;
 //BA.debugLineNum = 1048579;BA.debugLine="mBase.Tag = Me";
__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTag(this);
RDebugUtils.currentLine=1048581;
 //BA.debugLineNum = 1048581;BA.debugLine="mprops = Props";
__ref._mprops /*anywheresoftware.b4a.objects.collections.Map*/  = _props;
RDebugUtils.currentLine=1048582;
 //BA.debugLineNum = 1048582;BA.debugLine="Log(mprops)";
__c.LogImpl("21048582",BA.ObjectToString(__ref._mprops /*anywheresoftware.b4a.objects.collections.Map*/ ),0);
RDebugUtils.currentLine=1048585;
 //BA.debugLineNum = 1048585;BA.debugLine="XScrollView.Initialize(mBase.width,mBase.height,\"";
__ref._xscrollview /*flm.b4a.scrollview2d.ScrollView2DWrapper*/ .Initialize(ba,__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth(),__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight(),"XScrollview");
RDebugUtils.currentLine=1048586;
 //BA.debugLineNum = 1048586;BA.debugLine="If Props.get(\"layout\") <> \"\" Then setLayoutFile(P";
if ((_props.Get((Object)("layout"))).equals((Object)("")) == false) { 
__ref._setlayoutfile /*void*/ (null,BA.ObjectToString(_props.Get((Object)("layout"))));};
RDebugUtils.currentLine=1048588;
 //BA.debugLineNum = 1048588;BA.debugLine="mBase.AddView(XScrollView,0,0,mBase.width,mBase.h";
__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .AddView((android.view.View)(__ref._xscrollview /*flm.b4a.scrollview2d.ScrollView2DWrapper*/ .getObject()),(int) (0),(int) (0),__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth(),__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight());
RDebugUtils.currentLine=1048589;
 //BA.debugLineNum = 1048589;BA.debugLine="End Sub";
return "";
}
public void  _setlayoutfile(b4a.example.td_swipepanel __ref,String _layout) throws Exception{
RDebugUtils.currentModule="td_swipepanel";
if (Debug.shouldDelegate(ba, "setlayoutfile", false))
	 {Debug.delegate(ba, "setlayoutfile", new Object[] {_layout}); return;}
ResumableSub_setLayoutFile rsub = new ResumableSub_setLayoutFile(this,__ref,_layout);
rsub.resume(ba, null);
}
public static class ResumableSub_setLayoutFile extends BA.ResumableSub {
public ResumableSub_setLayoutFile(b4a.example.td_swipepanel parent,b4a.example.td_swipepanel __ref,String _layout) {
this.parent = parent;
this.__ref = __ref;
this._layout = _layout;
this.__ref = parent;
}
b4a.example.td_swipepanel __ref;
b4a.example.td_swipepanel parent;
String _layout;
int _w = 0;
int _h = 0;
Object _v = null;
anywheresoftware.b4a.BA.IterableList group6;
int index6;
int groupLen6;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="td_swipepanel";

    while (true) {
try {

        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
RDebugUtils.currentLine=1179649;
 //BA.debugLineNum = 1179649;BA.debugLine="Try";
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
RDebugUtils.currentLine=1179651;
 //BA.debugLineNum = 1179651;BA.debugLine="Sleep(0)";
parent.__c.Sleep(ba,new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "td_swipepanel", "setlayoutfile"),(int) (0));
this.state = 23;
return;
case 23:
//C
this.state = 4;
;
RDebugUtils.currentLine=1179652;
 //BA.debugLineNum = 1179652;BA.debugLine="XScrollView.Panel.RemoveAllViews";
__ref._xscrollview /*flm.b4a.scrollview2d.ScrollView2DWrapper*/ .getPanel().RemoveAllViews();
RDebugUtils.currentLine=1179653;
 //BA.debugLineNum = 1179653;BA.debugLine="XScrollView.panel.LoadLayout(Layout)";
__ref._xscrollview /*flm.b4a.scrollview2d.ScrollView2DWrapper*/ .getPanel().LoadLayout(_layout,ba);
RDebugUtils.currentLine=1179655;
 //BA.debugLineNum = 1179655;BA.debugLine="Dim w,h As Int";
_w = 0;
_h = 0;
RDebugUtils.currentLine=1179656;
 //BA.debugLineNum = 1179656;BA.debugLine="For Each v As Object In XScrollView.panel.getall";
if (true) break;

case 4:
//for
this.state = 19;
group6 = __ref._xscrollview /*flm.b4a.scrollview2d.ScrollView2DWrapper*/ .getPanel().GetAllViewsRecursive();
index6 = 0;
groupLen6 = group6.getSize();
this.state = 24;
if (true) break;

case 24:
//C
this.state = 19;
if (index6 < groupLen6) {
this.state = 6;
_v = group6.Get(index6);}
if (true) break;

case 25:
//C
this.state = 24;
index6++;
if (true) break;

case 6:
//C
this.state = 7;
RDebugUtils.currentLine=1179657;
 //BA.debugLineNum = 1179657;BA.debugLine="If v.As(View).Left + v.As(View).Width > w Then";
if (true) break;

case 7:
//if
this.state = 12;
if (((anywheresoftware.b4a.objects.ConcreteViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.ConcreteViewWrapper(), (android.view.View)(_v))).getLeft()+((anywheresoftware.b4a.objects.ConcreteViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.ConcreteViewWrapper(), (android.view.View)(_v))).getWidth()>_w) { 
this.state = 9;
;}if (true) break;

case 9:
//C
this.state = 12;
_w = (int) (((anywheresoftware.b4a.objects.ConcreteViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.ConcreteViewWrapper(), (android.view.View)(_v))).getLeft()+((anywheresoftware.b4a.objects.ConcreteViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.ConcreteViewWrapper(), (android.view.View)(_v))).getWidth());
if (true) break;

case 12:
//C
this.state = 13;
;
RDebugUtils.currentLine=1179658;
 //BA.debugLineNum = 1179658;BA.debugLine="If v.As(View).Top + v.As(View).Height > h Then";
if (true) break;

case 13:
//if
this.state = 18;
if (((anywheresoftware.b4a.objects.ConcreteViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.ConcreteViewWrapper(), (android.view.View)(_v))).getTop()+((anywheresoftware.b4a.objects.ConcreteViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.ConcreteViewWrapper(), (android.view.View)(_v))).getHeight()>_h) { 
this.state = 15;
;}if (true) break;

case 15:
//C
this.state = 18;
_h = (int) (((anywheresoftware.b4a.objects.ConcreteViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.ConcreteViewWrapper(), (android.view.View)(_v))).getTop()+((anywheresoftware.b4a.objects.ConcreteViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.ConcreteViewWrapper(), (android.view.View)(_v))).getHeight());
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
;
RDebugUtils.currentLine=1179660;
 //BA.debugLineNum = 1179660;BA.debugLine="w = w + w *	mprops.get(\"oversize\")/100";
_w = (int) (_w+_w*(double)(BA.ObjectToNumber(__ref._mprops /*anywheresoftware.b4a.objects.collections.Map*/ .Get((Object)("oversize"))))/(double)100);
RDebugUtils.currentLine=1179661;
 //BA.debugLineNum = 1179661;BA.debugLine="h = h + h *	mprops.get(\"oversize\")/100";
_h = (int) (_h+_h*(double)(BA.ObjectToNumber(__ref._mprops /*anywheresoftware.b4a.objects.collections.Map*/ .Get((Object)("oversize"))))/(double)100);
RDebugUtils.currentLine=1179662;
 //BA.debugLineNum = 1179662;BA.debugLine="XScrollView.panel.Width = w";
__ref._xscrollview /*flm.b4a.scrollview2d.ScrollView2DWrapper*/ .getPanel().setWidth(_w);
RDebugUtils.currentLine=1179663;
 //BA.debugLineNum = 1179663;BA.debugLine="XScrollView.panel.height = h";
__ref._xscrollview /*flm.b4a.scrollview2d.ScrollView2DWrapper*/ .getPanel().setHeight(_h);
 if (true) break;

case 21:
//C
this.state = 22;
this.catchState = 0;
RDebugUtils.currentLine=1179665;
 //BA.debugLineNum = 1179665;BA.debugLine="Log(LastException)";
parent.__c.LogImpl("21179665",BA.ObjectToString(parent.__c.LastException(ba)),0);
 if (true) break;
if (true) break;

case 22:
//C
this.state = -1;
this.catchState = 0;
;
RDebugUtils.currentLine=1179667;
 //BA.debugLineNum = 1179667;BA.debugLine="End Sub";
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
public String  _initialize(b4a.example.td_swipepanel __ref,anywheresoftware.b4a.BA _ba,Object _callback,String _eventname) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="td_swipepanel";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba,_callback,_eventname}));}
RDebugUtils.currentLine=983040;
 //BA.debugLineNum = 983040;BA.debugLine="Public Sub Initialize (Callback As Object, EventNa";
RDebugUtils.currentLine=983041;
 //BA.debugLineNum = 983041;BA.debugLine="mEventName = EventName";
__ref._meventname /*String*/  = _eventname;
RDebugUtils.currentLine=983042;
 //BA.debugLineNum = 983042;BA.debugLine="mCallBack = Callback";
__ref._mcallback /*Object*/  = _callback;
RDebugUtils.currentLine=983043;
 //BA.debugLineNum = 983043;BA.debugLine="End Sub";
return "";
}
public String  _xscrollview_scrollchanged(b4a.example.td_swipepanel __ref,int _posx,int _posy) throws Exception{
__ref = this;
RDebugUtils.currentModule="td_swipepanel";
if (Debug.shouldDelegate(ba, "xscrollview_scrollchanged", false))
	 {return ((String) Debug.delegate(ba, "xscrollview_scrollchanged", new Object[] {_posx,_posy}));}
RDebugUtils.currentLine=10616832;
 //BA.debugLineNum = 10616832;BA.debugLine="Private Sub XScrollView_ScrollChanged(PosX As Int,";
RDebugUtils.currentLine=10616833;
 //BA.debugLineNum = 10616833;BA.debugLine="If SubExists(mCallBack, mEventName & \"_ScrollChan";
if (__c.SubExists(ba,__ref._mcallback /*Object*/ ,__ref._meventname /*String*/ +"_ScrollChanged")) { 
RDebugUtils.currentLine=10616834;
 //BA.debugLineNum = 10616834;BA.debugLine="CallSub3(mCallBack, mEventName & \"_ScrollChanged";
__c.CallSubNew3(ba,__ref._mcallback /*Object*/ ,__ref._meventname /*String*/ +"_ScrollChanged",(Object)(_posx),(Object)(_posy));
 };
RDebugUtils.currentLine=10616836;
 //BA.debugLineNum = 10616836;BA.debugLine="End Sub";
return "";
}
}