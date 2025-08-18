package b4a.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.debug.*;

public class wobblemenu extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    private static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new anywheresoftware.b4a.ShellBA(_ba, this, htSubs, "b4a.example.wobblemenu");
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            
        }
        if (BA.isShellModeRuntimeCheck(ba)) 
			   this.getClass().getMethod("_class_globals", b4a.example.wobblemenu.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 
    public void  innerInitializeHelper(anywheresoftware.b4a.BA _ba) throws Exception{
        innerInitialize(_ba);
    }
    public Object callSub(String sub, Object sender, Object[] args) throws Exception {
        return BA.SubDelegator.SubNotFound;
    }
public static class _icontype{
public boolean IsInitialized;
public String Text;
public String Icon;
public anywheresoftware.b4a.keywords.constants.TypefaceWrapper iFont;
public void Initialize() {
IsInitialized = true;
Text = "";
Icon = "";
iFont = new anywheresoftware.b4a.keywords.constants.TypefaceWrapper();
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public anywheresoftware.b4a.keywords.Common __c = null;
public String _meventname = "";
public Object _mcallback = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _mbase = null;
public anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public int _backgroundcolor = 0;
public int _iconcolor = 0;
public int _iconsize = 0;
public int _textcolor = 0;
public int _textsize = 0;
public int _selectediconcolor = 0;
public int _circleradius = 0;
public int _animduration = 0;
public anywheresoftware.b4a.objects.B4XViewWrapper _tabcontainer = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _tabcurve = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _tabcircle = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _tab1 = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _tab2 = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _tab3 = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _tab4 = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _tab5 = null;
public anywheresoftware.b4a.objects.collections.List _tabs = null;
public anywheresoftware.b4a.objects.collections.List _iconlist = null;
public int _menuheight = 0;
public int _absolutewidth = 0;
public int _tabcount = 0;
public int _currenttab = 0;
public int _animation_type_elastic_out = 0;
public int _animation_type_elastic_in = 0;
public int _animation_type_ease_out = 0;
public int _animation_type_ease_in = 0;
public int _animation_type_none = 0;
public int _animationtype = 0;
public int _icon_appear_from_center = 0;
public int _icon_appear_from_edge = 0;
public int _icon_appear_fade_in = 0;
public int _icon_appear_no_animation = 0;
public int _iconappearstyle = 0;
public String _shadowcolor = "";
public anywheresoftware.b4a.objects.collections.List _badge = null;
public anywheresoftware.b4a.objects.collections.List _enabled = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _designerlbl = null;
public b4a.example.main _main = null;
public b4a.example.starter _starter = null;
public b4a.example.b4xpages _b4xpages = null;
public b4a.example.b4xcollections _b4xcollections = null;
public String  _settabtexticon(b4a.example.wobblemenu __ref,int _tabid,String _text,String _icon,anywheresoftware.b4a.keywords.constants.TypefaceWrapper _iconfont) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "settabtexticon", false))
	 {return ((String) Debug.delegate(ba, "settabtexticon", new Object[] {_tabid,_text,_icon,_iconfont}));}
b4a.example.wobblemenu._icontype _i = null;
anywheresoftware.b4a.objects.B4XViewWrapper _mtab = null;
anywheresoftware.b4a.objects.LabelWrapper _l = null;
anywheresoftware.b4a.objects.LabelWrapper _lbl = null;
RDebugUtils.currentLine=8847360;
 //BA.debugLineNum = 8847360;BA.debugLine="Public Sub SetTabTextIcon(TabID As Int,Text As Str";
RDebugUtils.currentLine=8847362;
 //BA.debugLineNum = 8847362;BA.debugLine="If TabID >= 1 And TabID <= TabCount Then";
if (_tabid>=1 && _tabid<=__ref._tabcount /*int*/ ) { 
RDebugUtils.currentLine=8847363;
 //BA.debugLineNum = 8847363;BA.debugLine="Dim i As IconType:i.Initialize";
_i = new b4a.example.wobblemenu._icontype();
RDebugUtils.currentLine=8847363;
 //BA.debugLineNum = 8847363;BA.debugLine="Dim i As IconType:i.Initialize";
_i.Initialize();
RDebugUtils.currentLine=8847364;
 //BA.debugLineNum = 8847364;BA.debugLine="i.icon = Icon";
_i.Icon /*String*/  = _icon;
RDebugUtils.currentLine=8847365;
 //BA.debugLineNum = 8847365;BA.debugLine="i.Text = Text";
_i.Text /*String*/  = _text;
RDebugUtils.currentLine=8847366;
 //BA.debugLineNum = 8847366;BA.debugLine="i.ifont = IconFont";
_i.iFont /*anywheresoftware.b4a.keywords.constants.TypefaceWrapper*/  = _iconfont;
RDebugUtils.currentLine=8847367;
 //BA.debugLineNum = 8847367;BA.debugLine="IconList.set(TabID-1,i)";
__ref._iconlist /*anywheresoftware.b4a.objects.collections.List*/ .Set((int) (_tabid-1),(Object)(_i));
RDebugUtils.currentLine=8847369;
 //BA.debugLineNum = 8847369;BA.debugLine="Dim mTab As B4XView = Tabs.Get(TabID-1)";
_mtab = new anywheresoftware.b4a.objects.B4XViewWrapper();
_mtab = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Get((int) (_tabid-1))));
RDebugUtils.currentLine=8847370;
 //BA.debugLineNum = 8847370;BA.debugLine="Dim l As Label = mTab.GetView(0)";
_l = new anywheresoftware.b4a.objects.LabelWrapper();
_l = (anywheresoftware.b4a.objects.LabelWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.LabelWrapper(), (android.widget.TextView)(_mtab.GetView((int) (0)).getObject()));
RDebugUtils.currentLine=8847371;
 //BA.debugLineNum = 8847371;BA.debugLine="l.Text = Icon";
_l.setText(BA.ObjectToCharSequence(_icon));
RDebugUtils.currentLine=8847379;
 //BA.debugLineNum = 8847379;BA.debugLine="l.Typeface = IconFont";
_l.setTypeface((android.graphics.Typeface)(_iconfont.getObject()));
RDebugUtils.currentLine=8847382;
 //BA.debugLineNum = 8847382;BA.debugLine="If Text = \"\" Then";
if ((_text).equals("")) { 
RDebugUtils.currentLine=8847386;
 //BA.debugLineNum = 8847386;BA.debugLine="l.Height=mTab.Height";
_l.setHeight(_mtab.getHeight());
 }else {
RDebugUtils.currentLine=8847392;
 //BA.debugLineNum = 8847392;BA.debugLine="l.Height=(mTab.Height/3)*2";
_l.setHeight((int) ((_mtab.getHeight()/(double)3)*2));
 };
RDebugUtils.currentLine=8847396;
 //BA.debugLineNum = 8847396;BA.debugLine="Dim lbl As Label = mTab.GetView(1)";
_lbl = new anywheresoftware.b4a.objects.LabelWrapper();
_lbl = (anywheresoftware.b4a.objects.LabelWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.LabelWrapper(), (android.widget.TextView)(_mtab.GetView((int) (1)).getObject()));
RDebugUtils.currentLine=8847397;
 //BA.debugLineNum = 8847397;BA.debugLine="lbl.Text = Text";
_lbl.setText(BA.ObjectToCharSequence(_text));
RDebugUtils.currentLine=8847399;
 //BA.debugLineNum = 8847399;BA.debugLine="SetCircleIcon";
__ref._setcircleicon /*void*/ (null);
 }else {
RDebugUtils.currentLine=8847401;
 //BA.debugLineNum = 8847401;BA.debugLine="Log(\"Invalid Tab ID\")";
__c.LogImpl("28847401","Invalid Tab ID",0);
 };
RDebugUtils.currentLine=8847403;
 //BA.debugLineNum = 8847403;BA.debugLine="End Sub";
return "";
}
public void  _animateto(b4a.example.wobblemenu __ref,anywheresoftware.b4a.objects.B4XViewWrapper _element,int _newpos) throws Exception{
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "animateto", false))
	 {Debug.delegate(ba, "animateto", new Object[] {_element,_newpos}); return;}
ResumableSub_AnimateTo rsub = new ResumableSub_AnimateTo(this,__ref,_element,_newpos);
rsub.resume(ba, null);
}
public static class ResumableSub_AnimateTo extends BA.ResumableSub {
public ResumableSub_AnimateTo(b4a.example.wobblemenu parent,b4a.example.wobblemenu __ref,anywheresoftware.b4a.objects.B4XViewWrapper _element,int _newpos) {
this.parent = parent;
this.__ref = __ref;
this._element = _element;
this._newpos = _newpos;
this.__ref = parent;
}
b4a.example.wobblemenu __ref;
b4a.example.wobblemenu parent;
anywheresoftware.b4a.objects.B4XViewWrapper _element;
int _newpos;
long _n = 0L;
int _duration = 0;
int _currentpos = 0;
float _start = 0f;
float _tempvalue = 0f;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="wobblemenu";

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
RDebugUtils.currentLine=9502721;
 //BA.debugLineNum = 9502721;BA.debugLine="Dim n As Long = DateTime.Now";
_n = parent.__c.DateTime.getNow();
RDebugUtils.currentLine=9502722;
 //BA.debugLineNum = 9502722;BA.debugLine="Dim duration As Int = animDuration";
_duration = __ref._animduration /*int*/ ;
RDebugUtils.currentLine=9502723;
 //BA.debugLineNum = 9502723;BA.debugLine="Dim currentPos As Int = Element.left";
_currentpos = _element.getLeft();
RDebugUtils.currentLine=9502724;
 //BA.debugLineNum = 9502724;BA.debugLine="Dim start As Float = currentPos";
_start = (float) (_currentpos);
RDebugUtils.currentLine=9502725;
 //BA.debugLineNum = 9502725;BA.debugLine="currentPos = NewPos";
_currentpos = _newpos;
RDebugUtils.currentLine=9502726;
 //BA.debugLineNum = 9502726;BA.debugLine="Dim tempValue As Float";
_tempvalue = 0f;
RDebugUtils.currentLine=9502727;
 //BA.debugLineNum = 9502727;BA.debugLine="Do While DateTime.Now < n + duration";
if (true) break;

case 1:
//do while
this.state = 10;
while (parent.__c.DateTime.getNow()<_n+_duration) {
this.state = 3;
if (true) break;
}
if (true) break;

case 3:
//C
this.state = 4;
RDebugUtils.currentLine=9502728;
 //BA.debugLineNum = 9502728;BA.debugLine="tempValue = TimeWisePosition(DateTime.Now - n, s";
_tempvalue = (float) (__ref._timewiseposition /*int*/ (null,(float) (parent.__c.DateTime.getNow()-_n),_start,(float) (_newpos-_start),_duration));
RDebugUtils.currentLine=9502729;
 //BA.debugLineNum = 9502729;BA.debugLine="Element.left=tempValue";
_element.setLeft((int) (_tempvalue));
RDebugUtils.currentLine=9502730;
 //BA.debugLineNum = 9502730;BA.debugLine="Sleep(1)";
parent.__c.Sleep(ba,new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "wobblemenu", "animateto"),(int) (1));
this.state = 11;
return;
case 11:
//C
this.state = 4;
;
RDebugUtils.currentLine=9502731;
 //BA.debugLineNum = 9502731;BA.debugLine="If NewPos <> currentPos Then Return";
if (true) break;

case 4:
//if
this.state = 9;
if (_newpos!=_currentpos) { 
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
RDebugUtils.currentLine=9502733;
 //BA.debugLineNum = 9502733;BA.debugLine="Element.Left = currentPos";
_element.setLeft(_currentpos);
RDebugUtils.currentLine=9502734;
 //BA.debugLineNum = 9502734;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public int  _timewiseposition(b4a.example.wobblemenu __ref,float _ctime,float _frompos,float _topos,int _duration) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "timewiseposition", false))
	 {return ((Integer) Debug.delegate(ba, "timewiseposition", new Object[] {_ctime,_frompos,_topos,_duration}));}
float _ts = 0f;
float _tc = 0f;
RDebugUtils.currentLine=9568256;
 //BA.debugLineNum = 9568256;BA.debugLine="Private Sub TimeWisePosition(ctime As Float, fromP";
RDebugUtils.currentLine=9568257;
 //BA.debugLineNum = 9568257;BA.debugLine="Dim ts,tc As Float";
_ts = 0f;
_tc = 0f;
RDebugUtils.currentLine=9568258;
 //BA.debugLineNum = 9568258;BA.debugLine="ctime = ctime/duration";
_ctime = (float) (_ctime/(double)_duration);
RDebugUtils.currentLine=9568259;
 //BA.debugLineNum = 9568259;BA.debugLine="ts=ctime*ctime";
_ts = (float) (_ctime*_ctime);
RDebugUtils.currentLine=9568260;
 //BA.debugLineNum = 9568260;BA.debugLine="tc=ts*ctime";
_tc = (float) (_ts*_ctime);
RDebugUtils.currentLine=9568262;
 //BA.debugLineNum = 9568262;BA.debugLine="Select AnimationType";
switch (BA.switchObjectToInt(__ref._animationtype /*int*/ ,(int) (0),(int) (1),(int) (2),(int) (3))) {
case 0: {
RDebugUtils.currentLine=9568264;
 //BA.debugLineNum = 9568264;BA.debugLine="Return fromPos + toPos * (23.645*tc*ts + -73.73";
if (true) return (int) (_frompos+_topos*(23.645*_tc*_ts+-73.7325*_ts*_ts+86.38*_tc+-46.79*_ts+11.4975*_ctime));
 break; }
case 1: {
RDebugUtils.currentLine=9568266;
 //BA.debugLineNum = 9568266;BA.debugLine="Return fromPos + toPos * (34.445*tc*ts + -69.39";
if (true) return (int) (_frompos+_topos*(34.445*_tc*_ts+-69.39*_ts*_ts+47.395*_tc+-12.4*_ts+0.95*_ctime));
 break; }
case 2: {
RDebugUtils.currentLine=9568268;
 //BA.debugLineNum = 9568268;BA.debugLine="Return fromPos + toPos * (tc*ts + -5*ts*ts + 10";
if (true) return (int) (_frompos+_topos*(_tc*_ts+-5*_ts*_ts+10*_tc+-10*_ts+5*_ctime));
 break; }
case 3: {
RDebugUtils.currentLine=9568270;
 //BA.debugLineNum = 9568270;BA.debugLine="Return fromPos + toPos * (tc*ts)";
if (true) return (int) (_frompos+_topos*(_tc*_ts));
 break; }
default: {
RDebugUtils.currentLine=9568272;
 //BA.debugLineNum = 9568272;BA.debugLine="Return fromPos + toPos*(ctime)";
if (true) return (int) (_frompos+_topos*(_ctime));
 break; }
}
;
RDebugUtils.currentLine=9568275;
 //BA.debugLineNum = 9568275;BA.debugLine="End Sub";
return 0;
}
public String  _base_resize(b4a.example.wobblemenu __ref,double _width,double _height) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "base_resize", false))
	 {return ((String) Debug.delegate(ba, "base_resize", new Object[] {_width,_height}));}
RDebugUtils.currentLine=8454144;
 //BA.debugLineNum = 8454144;BA.debugLine="Private Sub Base_Resize (Width As Double, Height A";
RDebugUtils.currentLine=8454145;
 //BA.debugLineNum = 8454145;BA.debugLine="mBase.Width = Width";
__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setWidth((int) (_width));
RDebugUtils.currentLine=8454146;
 //BA.debugLineNum = 8454146;BA.debugLine="AbsoluteWidth= Min(mBase.Parent.Width,mBase.Paren";
__ref._absolutewidth /*int*/  = (int) (__c.Min(__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getParent().getWidth(),__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getParent().getHeight()));
RDebugUtils.currentLine=8454147;
 //BA.debugLineNum = 8454147;BA.debugLine="MenuHeight = (AbsoluteWidth/7) + ((AbsoluteWidth/";
__ref._menuheight /*int*/  = (int) ((__ref._absolutewidth /*int*/ /(double)7)+((__ref._absolutewidth /*int*/ /(double)7)/(double)4));
RDebugUtils.currentLine=8454148;
 //BA.debugLineNum = 8454148;BA.debugLine="mBase.Height = MenuHeight";
__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(__ref._menuheight /*int*/ );
RDebugUtils.currentLine=8454149;
 //BA.debugLineNum = 8454149;BA.debugLine="mBase.Top = mBase.Parent.Height - mBase.Height";
__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop((int) (__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getParent().getHeight()-__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()));
RDebugUtils.currentLine=8454150;
 //BA.debugLineNum = 8454150;BA.debugLine="circleRadius = AbsoluteWidth/7";
__ref._circleradius /*int*/  = (int) (__ref._absolutewidth /*int*/ /(double)7);
RDebugUtils.currentLine=8454152;
 //BA.debugLineNum = 8454152;BA.debugLine="DrawView";
__ref._drawview /*String*/ (null);
RDebugUtils.currentLine=8454153;
 //BA.debugLineNum = 8454153;BA.debugLine="End Sub";
return "";
}
public String  _drawview(b4a.example.wobblemenu __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "drawview", false))
	 {return ((String) Debug.delegate(ba, "drawview", null));}
anywheresoftware.b4a.objects.LabelWrapper _icon = null;
anywheresoftware.b4a.objects.B4XViewWrapper _lw = null;
anywheresoftware.b4a.objects.B4XViewWrapper _rw = null;
anywheresoftware.b4a.objects.B4XViewWrapper _cw = null;
RDebugUtils.currentLine=8519680;
 //BA.debugLineNum = 8519680;BA.debugLine="Private Sub DrawView";
RDebugUtils.currentLine=8519681;
 //BA.debugLineNum = 8519681;BA.debugLine="mBase.RemoveAllViews";
__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .RemoveAllViews();
RDebugUtils.currentLine=8519682;
 //BA.debugLineNum = 8519682;BA.debugLine="Tabs.Clear";
__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Clear();
RDebugUtils.currentLine=8519683;
 //BA.debugLineNum = 8519683;BA.debugLine="If TabCircle.IsInitialized Then TabCircle.RemoveA";
if (__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .IsInitialized()) { 
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .RemoveAllViews();};
RDebugUtils.currentLine=8519685;
 //BA.debugLineNum = 8519685;BA.debugLine="TabContainer = xui.CreatePanel(\"\")";
__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .CreatePanel(ba,"");
RDebugUtils.currentLine=8519686;
 //BA.debugLineNum = 8519686;BA.debugLine="mBase.AddView(TabContainer,0,mBase.Height/4 ,mBas";
__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .AddView((android.view.View)(__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getObject()),(int) (0),(int) (__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)4),__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth(),(int) (__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()-(__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)4)));
RDebugUtils.currentLine=8519687;
 //BA.debugLineNum = 8519687;BA.debugLine="TabCurve = xui.CreatePanel(\"\")";
__ref._tabcurve /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .CreatePanel(ba,"");
RDebugUtils.currentLine=8519688;
 //BA.debugLineNum = 8519688;BA.debugLine="TabContainer.AddView(TabCurve,((TabContainer.Widt";
__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .AddView((android.view.View)(__ref._tabcurve /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getObject()),(int) (((__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()/(double)__ref._tabcount /*int*/ )*(__ref._currenttab /*int*/ -1))+((__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()/(double)__ref._tabcount /*int*/ )/(double)2)-((__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()*2)/(double)2)),(int) (0),(int) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()*2),__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight());
RDebugUtils.currentLine=8519689;
 //BA.debugLineNum = 8519689;BA.debugLine="DrawCurve";
__ref._drawcurve /*String*/ (null);
RDebugUtils.currentLine=8519691;
 //BA.debugLineNum = 8519691;BA.debugLine="TabCircle = xui.CreatePanel(\"\")";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .CreatePanel(ba,"");
RDebugUtils.currentLine=8519692;
 //BA.debugLineNum = 8519692;BA.debugLine="mBase.AddView(TabCircle,((TabContainer.Width/TabC";
__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .AddView((android.view.View)(__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getObject()),(int) (((__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()/(double)__ref._tabcount /*int*/ )*(__ref._currenttab /*int*/ -1))+((__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()/(double)__ref._tabcount /*int*/ )/(double)2)-(__ref._circleradius /*int*/ /(double)2)),__c.DipToCurrent((int) (1)),__ref._circleradius /*int*/ ,__ref._circleradius /*int*/ );
RDebugUtils.currentLine=8519693;
 //BA.debugLineNum = 8519693;BA.debugLine="DrawCircle";
__ref._drawcircle /*String*/ (null);
RDebugUtils.currentLine=8519695;
 //BA.debugLineNum = 8519695;BA.debugLine="Dim icon As Label";
_icon = new anywheresoftware.b4a.objects.LabelWrapper();
RDebugUtils.currentLine=8519696;
 //BA.debugLineNum = 8519696;BA.debugLine="icon.Initialize(\"\")";
_icon.Initialize(ba,"");
RDebugUtils.currentLine=8519703;
 //BA.debugLineNum = 8519703;BA.debugLine="icon.TextColor = SelectedIconColor";
_icon.setTextColor(__ref._selectediconcolor /*int*/ );
RDebugUtils.currentLine=8519704;
 //BA.debugLineNum = 8519704;BA.debugLine="icon.Typeface = Typeface.FONTAWESOME";
_icon.setTypeface(__c.Typeface.getFONTAWESOME());
RDebugUtils.currentLine=8519705;
 //BA.debugLineNum = 8519705;BA.debugLine="icon.TextSize = 20";
_icon.setTextSize((float) (20));
RDebugUtils.currentLine=8519706;
 //BA.debugLineNum = 8519706;BA.debugLine="icon.Gravity = Gravity.CENTER_HORIZONTAL + Gravit";
_icon.setGravity((int) (__c.Gravity.CENTER_HORIZONTAL+__c.Gravity.CENTER_VERTICAL));
RDebugUtils.currentLine=8519713;
 //BA.debugLineNum = 8519713;BA.debugLine="TabCircle.AddView(icon,0,0,TabCircle.Width,TabCir";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .AddView((android.view.View)(_icon.getObject()),(int) (0),(int) (0),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth(),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight());
RDebugUtils.currentLine=8519715;
 //BA.debugLineNum = 8519715;BA.debugLine="Dim lw,rw,cw As B4XView";
_lw = new anywheresoftware.b4a.objects.B4XViewWrapper();
_rw = new anywheresoftware.b4a.objects.B4XViewWrapper();
_cw = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=8519716;
 //BA.debugLineNum = 8519716;BA.debugLine="lw = xui.CreatePanel(\"\")";
_lw = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .CreatePanel(ba,"");
RDebugUtils.currentLine=8519717;
 //BA.debugLineNum = 8519717;BA.debugLine="rw = xui.CreatePanel(\"\")";
_rw = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .CreatePanel(ba,"");
RDebugUtils.currentLine=8519718;
 //BA.debugLineNum = 8519718;BA.debugLine="cw = xui.CreatePanel(\"\")";
_cw = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .CreatePanel(ba,"");
RDebugUtils.currentLine=8519719;
 //BA.debugLineNum = 8519719;BA.debugLine="lw.Color = BackgroundColor";
_lw.setColor(__ref._backgroundcolor /*int*/ );
RDebugUtils.currentLine=8519720;
 //BA.debugLineNum = 8519720;BA.debugLine="rw.Color = BackgroundColor";
_rw.setColor(__ref._backgroundcolor /*int*/ );
RDebugUtils.currentLine=8519721;
 //BA.debugLineNum = 8519721;BA.debugLine="cw.Color = BackgroundColor";
_cw.setColor(__ref._backgroundcolor /*int*/ );
RDebugUtils.currentLine=8519722;
 //BA.debugLineNum = 8519722;BA.debugLine="TabCircle.AddView(lw,(TabCircle.Height/5),(TabCir";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .AddView((android.view.View)(_lw.getObject()),(int) ((__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)5)),(int) ((__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)2)-((__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)2)/(double)2)),__c.DipToCurrent((int) (1)),(int) (__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)2));
RDebugUtils.currentLine=8519723;
 //BA.debugLineNum = 8519723;BA.debugLine="TabCircle.AddView(rw,TabCircle.Width-(TabCircle.H";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .AddView((android.view.View)(_rw.getObject()),(int) (__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()-(__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)5)-__c.DipToCurrent((int) (1))),(int) ((__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)2)-((__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)2)/(double)2)),__c.DipToCurrent((int) (1)),(int) (__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)2));
RDebugUtils.currentLine=8519724;
 //BA.debugLineNum = 8519724;BA.debugLine="TabCircle.AddView(cw,TabCircle.Width/2,(TabCircle";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .AddView((android.view.View)(_cw.getObject()),(int) (__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()/(double)2),(int) ((__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)2)-((__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)2)/(double)2)),(int) (0),(int) (__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)2));
RDebugUtils.currentLine=8519726;
 //BA.debugLineNum = 8519726;BA.debugLine="Tab1 = xui.CreatePanel(\"IconTab\")";
__ref._tab1 /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .CreatePanel(ba,"IconTab");
RDebugUtils.currentLine=8519727;
 //BA.debugLineNum = 8519727;BA.debugLine="Tabs.Add(Tab1)";
__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Add((Object)(__ref._tab1 /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getObject()));
RDebugUtils.currentLine=8519728;
 //BA.debugLineNum = 8519728;BA.debugLine="Tab2 = xui.CreatePanel(\"IconTab\")";
__ref._tab2 /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .CreatePanel(ba,"IconTab");
RDebugUtils.currentLine=8519729;
 //BA.debugLineNum = 8519729;BA.debugLine="Tabs.Add(Tab2)";
__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Add((Object)(__ref._tab2 /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getObject()));
RDebugUtils.currentLine=8519730;
 //BA.debugLineNum = 8519730;BA.debugLine="Tab3 = xui.CreatePanel(\"IconTab\")";
__ref._tab3 /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .CreatePanel(ba,"IconTab");
RDebugUtils.currentLine=8519731;
 //BA.debugLineNum = 8519731;BA.debugLine="Tabs.Add(Tab3)";
__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Add((Object)(__ref._tab3 /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getObject()));
RDebugUtils.currentLine=8519732;
 //BA.debugLineNum = 8519732;BA.debugLine="Tab4 = xui.CreatePanel(\"IconTab\")";
__ref._tab4 /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .CreatePanel(ba,"IconTab");
RDebugUtils.currentLine=8519733;
 //BA.debugLineNum = 8519733;BA.debugLine="Tabs.Add(Tab4)";
__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Add((Object)(__ref._tab4 /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getObject()));
RDebugUtils.currentLine=8519734;
 //BA.debugLineNum = 8519734;BA.debugLine="Tab5 = xui.CreatePanel(\"IconTab\")";
__ref._tab5 /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .CreatePanel(ba,"IconTab");
RDebugUtils.currentLine=8519735;
 //BA.debugLineNum = 8519735;BA.debugLine="Tabs.Add(Tab5)";
__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Add((Object)(__ref._tab5 /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getObject()));
RDebugUtils.currentLine=8519737;
 //BA.debugLineNum = 8519737;BA.debugLine="CreateTab";
__ref._createtab /*String*/ (null);
RDebugUtils.currentLine=8519738;
 //BA.debugLineNum = 8519738;BA.debugLine="SetCircleIcon";
__ref._setcircleicon /*void*/ (null);
RDebugUtils.currentLine=8519739;
 //BA.debugLineNum = 8519739;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4a.example.wobblemenu __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
RDebugUtils.currentLine=8257536;
 //BA.debugLineNum = 8257536;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=8257537;
 //BA.debugLineNum = 8257537;BA.debugLine="Private mEventName As String 'ignore";
_meventname = "";
RDebugUtils.currentLine=8257538;
 //BA.debugLineNum = 8257538;BA.debugLine="Private mCallBack As Object 'ignore";
_mcallback = new Object();
RDebugUtils.currentLine=8257539;
 //BA.debugLineNum = 8257539;BA.debugLine="Private mBase As B4XView";
_mbase = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=8257540;
 //BA.debugLineNum = 8257540;BA.debugLine="Private xui As XUI";
_xui = new anywheresoftware.b4a.objects.B4XViewWrapper.XUI();
RDebugUtils.currentLine=8257542;
 //BA.debugLineNum = 8257542;BA.debugLine="Private BackgroundColor,IconColor,IconSize,TextCo";
_backgroundcolor = 0;
_iconcolor = 0;
_iconsize = 0;
_textcolor = 0;
_textsize = 0;
_selectediconcolor = 0;
_circleradius = 0;
_animduration = 0;
RDebugUtils.currentLine=8257543;
 //BA.debugLineNum = 8257543;BA.debugLine="Private TabContainer,TabCurve,TabCircle,Tab1,Tab2";
_tabcontainer = new anywheresoftware.b4a.objects.B4XViewWrapper();
_tabcurve = new anywheresoftware.b4a.objects.B4XViewWrapper();
_tabcircle = new anywheresoftware.b4a.objects.B4XViewWrapper();
_tab1 = new anywheresoftware.b4a.objects.B4XViewWrapper();
_tab2 = new anywheresoftware.b4a.objects.B4XViewWrapper();
_tab3 = new anywheresoftware.b4a.objects.B4XViewWrapper();
_tab4 = new anywheresoftware.b4a.objects.B4XViewWrapper();
_tab5 = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=8257544;
 //BA.debugLineNum = 8257544;BA.debugLine="Private Tabs,IconList As List";
_tabs = new anywheresoftware.b4a.objects.collections.List();
_iconlist = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=8257545;
 //BA.debugLineNum = 8257545;BA.debugLine="Private MenuHeight, AbsoluteWidth, TabCount As In";
_menuheight = 0;
_absolutewidth = 0;
_tabcount = 0;
RDebugUtils.currentLine=8257546;
 //BA.debugLineNum = 8257546;BA.debugLine="Private CurrentTab As Int";
_currenttab = 0;
RDebugUtils.currentLine=8257548;
 //BA.debugLineNum = 8257548;BA.debugLine="Public const ANIMATION_TYPE_ELASTIC_OUT As Int =";
_animation_type_elastic_out = (int) (0);
RDebugUtils.currentLine=8257549;
 //BA.debugLineNum = 8257549;BA.debugLine="Public const ANIMATION_TYPE_ELASTIC_IN As Int = 1";
_animation_type_elastic_in = (int) (1);
RDebugUtils.currentLine=8257550;
 //BA.debugLineNum = 8257550;BA.debugLine="Public const ANIMATION_TYPE_EASE_OUT As Int = 2";
_animation_type_ease_out = (int) (2);
RDebugUtils.currentLine=8257551;
 //BA.debugLineNum = 8257551;BA.debugLine="Public const ANIMATION_TYPE_EASE_IN As Int = 3";
_animation_type_ease_in = (int) (3);
RDebugUtils.currentLine=8257552;
 //BA.debugLineNum = 8257552;BA.debugLine="Public const ANIMATION_TYPE_NONE As Int = 4";
_animation_type_none = (int) (4);
RDebugUtils.currentLine=8257553;
 //BA.debugLineNum = 8257553;BA.debugLine="Private AnimationType As Int";
_animationtype = 0;
RDebugUtils.currentLine=8257555;
 //BA.debugLineNum = 8257555;BA.debugLine="Public const ICON_APPEAR_FROM_CENTER As Int = 0";
_icon_appear_from_center = (int) (0);
RDebugUtils.currentLine=8257556;
 //BA.debugLineNum = 8257556;BA.debugLine="Public const ICON_APPEAR_FROM_EDGE As Int = 1";
_icon_appear_from_edge = (int) (1);
RDebugUtils.currentLine=8257557;
 //BA.debugLineNum = 8257557;BA.debugLine="Public const ICON_APPEAR_FADE_IN As Int = 2";
_icon_appear_fade_in = (int) (2);
RDebugUtils.currentLine=8257558;
 //BA.debugLineNum = 8257558;BA.debugLine="Public const ICON_APPEAR_NO_ANIMATION As Int = 3";
_icon_appear_no_animation = (int) (3);
RDebugUtils.currentLine=8257559;
 //BA.debugLineNum = 8257559;BA.debugLine="Private IconAppearStyle As Int";
_iconappearstyle = 0;
RDebugUtils.currentLine=8257560;
 //BA.debugLineNum = 8257560;BA.debugLine="Private ShadowColor As String";
_shadowcolor = "";
RDebugUtils.currentLine=8257561;
 //BA.debugLineNum = 8257561;BA.debugLine="Private badge,enabled As List";
_badge = new anywheresoftware.b4a.objects.collections.List();
_enabled = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=8257568;
 //BA.debugLineNum = 8257568;BA.debugLine="Type IconType(Text As String, Icon As String, iFo";
;
RDebugUtils.currentLine=8257573;
 //BA.debugLineNum = 8257573;BA.debugLine="Private designerLbl As B4XView";
_designerlbl = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=8257574;
 //BA.debugLineNum = 8257574;BA.debugLine="End Sub";
return "";
}
public String  _createtab(b4a.example.wobblemenu __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "createtab", false))
	 {return ((String) Debug.delegate(ba, "createtab", null));}
int _j = 0;
anywheresoftware.b4a.objects.B4XViewWrapper _tabview = null;
int _tab_width = 0;
b4a.example.wobblemenu._icontype _i = null;
anywheresoftware.b4a.objects.LabelWrapper _icon = null;
anywheresoftware.b4a.objects.B4XViewWrapper _b4xlbl = null;
anywheresoftware.b4a.objects.LabelWrapper _icontext = null;
anywheresoftware.b4a.objects.collections.Map _data = null;
RDebugUtils.currentLine=8585216;
 //BA.debugLineNum = 8585216;BA.debugLine="Private Sub CreateTab";
RDebugUtils.currentLine=8585217;
 //BA.debugLineNum = 8585217;BA.debugLine="For j=0 To TabCount-1";
{
final int step1 = 1;
final int limit1 = (int) (__ref._tabcount /*int*/ -1);
_j = (int) (0) ;
for (;_j <= limit1 ;_j = _j + step1 ) {
RDebugUtils.currentLine=8585219;
 //BA.debugLineNum = 8585219;BA.debugLine="Dim tabView As B4XView = Tabs.Get(j)";
_tabview = new anywheresoftware.b4a.objects.B4XViewWrapper();
_tabview = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Get(_j)));
RDebugUtils.currentLine=8585220;
 //BA.debugLineNum = 8585220;BA.debugLine="tabView.Enabled = enabled.Get(j)";
_tabview.setEnabled(BA.ObjectToBoolean(__ref._enabled /*anywheresoftware.b4a.objects.collections.List*/ .Get(_j)));
RDebugUtils.currentLine=8585221;
 //BA.debugLineNum = 8585221;BA.debugLine="Dim tab_width As Int = TabContainer.Width/TabCou";
_tab_width = (int) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()/(double)__ref._tabcount /*int*/ );
RDebugUtils.currentLine=8585222;
 //BA.debugLineNum = 8585222;BA.debugLine="tabView.Color = xui.Color_Transparent";
_tabview.setColor(__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .Color_Transparent);
RDebugUtils.currentLine=8585223;
 //BA.debugLineNum = 8585223;BA.debugLine="TabContainer.AddView(tabView,tab_width*j,0,tab_w";
__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .AddView((android.view.View)(_tabview.getObject()),(int) (_tab_width*_j),(int) (0),_tab_width,__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight());
RDebugUtils.currentLine=8585225;
 //BA.debugLineNum = 8585225;BA.debugLine="Dim i As IconType:i.Initialize";
_i = new b4a.example.wobblemenu._icontype();
RDebugUtils.currentLine=8585225;
 //BA.debugLineNum = 8585225;BA.debugLine="Dim i As IconType:i.Initialize";
_i.Initialize();
RDebugUtils.currentLine=8585226;
 //BA.debugLineNum = 8585226;BA.debugLine="If IconList.Size > j Then";
if (__ref._iconlist /*anywheresoftware.b4a.objects.collections.List*/ .getSize()>_j) { 
RDebugUtils.currentLine=8585227;
 //BA.debugLineNum = 8585227;BA.debugLine="i = IconList.Get(j)";
_i = (b4a.example.wobblemenu._icontype)(__ref._iconlist /*anywheresoftware.b4a.objects.collections.List*/ .Get(_j));
 }else {
RDebugUtils.currentLine=8585229;
 //BA.debugLineNum = 8585229;BA.debugLine="i.icon = Chr(0xF10C)";
_i.Icon /*String*/  = BA.ObjectToString(__c.Chr((int) (0xf10c)));
RDebugUtils.currentLine=8585235;
 //BA.debugLineNum = 8585235;BA.debugLine="i.ifont = Typeface.FONTAWESOME";
_i.iFont /*anywheresoftware.b4a.keywords.constants.TypefaceWrapper*/  = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.getFONTAWESOME()));
 };
RDebugUtils.currentLine=8585239;
 //BA.debugLineNum = 8585239;BA.debugLine="Dim icon As Label";
_icon = new anywheresoftware.b4a.objects.LabelWrapper();
RDebugUtils.currentLine=8585240;
 //BA.debugLineNum = 8585240;BA.debugLine="icon.Initialize(\"\")";
_icon.Initialize(ba,"");
RDebugUtils.currentLine=8585241;
 //BA.debugLineNum = 8585241;BA.debugLine="Dim b4xlbl As B4XView = icon";
_b4xlbl = new anywheresoftware.b4a.objects.B4XViewWrapper();
_b4xlbl = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(_icon.getObject()));
RDebugUtils.currentLine=8585242;
 //BA.debugLineNum = 8585242;BA.debugLine="b4xlbl.TextColor = IconColor";
_b4xlbl.setTextColor(__ref._iconcolor /*int*/ );
RDebugUtils.currentLine=8585243;
 //BA.debugLineNum = 8585243;BA.debugLine="b4xlbl.SetTextAlignment(\"CENTER\",\"CENTER\")";
_b4xlbl.SetTextAlignment("CENTER","CENTER");
RDebugUtils.currentLine=8585244;
 //BA.debugLineNum = 8585244;BA.debugLine="b4xlbl.TextSize = IconSize";
_b4xlbl.setTextSize((float) (__ref._iconsize /*int*/ ));
RDebugUtils.currentLine=8585249;
 //BA.debugLineNum = 8585249;BA.debugLine="icon.Typeface = i.iFont";
_icon.setTypeface((android.graphics.Typeface)(_i.iFont /*anywheresoftware.b4a.keywords.constants.TypefaceWrapper*/ .getObject()));
RDebugUtils.currentLine=8585252;
 //BA.debugLineNum = 8585252;BA.debugLine="icon.Text = i.icon";
_icon.setText(BA.ObjectToCharSequence(_i.Icon /*String*/ ));
RDebugUtils.currentLine=8585253;
 //BA.debugLineNum = 8585253;BA.debugLine="tabView.AddView(icon,0,0,tabView.Width,tabView.H";
_tabview.AddView((android.view.View)(_icon.getObject()),(int) (0),(int) (0),_tabview.getWidth(),_tabview.getHeight());
RDebugUtils.currentLine=8585255;
 //BA.debugLineNum = 8585255;BA.debugLine="Dim iconText As Label";
_icontext = new anywheresoftware.b4a.objects.LabelWrapper();
RDebugUtils.currentLine=8585256;
 //BA.debugLineNum = 8585256;BA.debugLine="iconText.Initialize(\"\")";
_icontext.Initialize(ba,"");
RDebugUtils.currentLine=8585257;
 //BA.debugLineNum = 8585257;BA.debugLine="b4xlbl=iconText";
_b4xlbl = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(_icontext.getObject()));
RDebugUtils.currentLine=8585258;
 //BA.debugLineNum = 8585258;BA.debugLine="b4xlbl.TextColor = TextColor";
_b4xlbl.setTextColor(__ref._textcolor /*int*/ );
RDebugUtils.currentLine=8585259;
 //BA.debugLineNum = 8585259;BA.debugLine="b4xlbl.Font=designerLbl.Font";
_b4xlbl.setFont(__ref._designerlbl /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getFont());
RDebugUtils.currentLine=8585260;
 //BA.debugLineNum = 8585260;BA.debugLine="b4xlbl.TextSize=TextSize";
_b4xlbl.setTextSize((float) (__ref._textsize /*int*/ ));
RDebugUtils.currentLine=8585261;
 //BA.debugLineNum = 8585261;BA.debugLine="b4xlbl.SetTextAlignment(\"CENTER\",\"CENTER\")";
_b4xlbl.SetTextAlignment("CENTER","CENTER");
RDebugUtils.currentLine=8585262;
 //BA.debugLineNum = 8585262;BA.debugLine="b4xlbl.text=i.text";
_b4xlbl.setText(BA.ObjectToCharSequence(_i.Text /*String*/ ));
RDebugUtils.currentLine=8585264;
 //BA.debugLineNum = 8585264;BA.debugLine="tabView.AddView(iconText,0,tabView.Height/2,tabV";
_tabview.AddView((android.view.View)(_icontext.getObject()),(int) (0),(int) (_tabview.getHeight()/(double)2),_tabview.getWidth(),(int) (_tabview.getHeight()/(double)2));
RDebugUtils.currentLine=8585266;
 //BA.debugLineNum = 8585266;BA.debugLine="If i.Text = \"\" Then";
if ((_i.Text /*String*/ ).equals("")) { 
RDebugUtils.currentLine=8585270;
 //BA.debugLineNum = 8585270;BA.debugLine="icon.Height=tabView.Height";
_icon.setHeight(_tabview.getHeight());
 }else {
RDebugUtils.currentLine=8585276;
 //BA.debugLineNum = 8585276;BA.debugLine="icon.Height=(tabView.Height/3)*2";
_icon.setHeight((int) ((_tabview.getHeight()/(double)3)*2));
 };
RDebugUtils.currentLine=8585280;
 //BA.debugLineNum = 8585280;BA.debugLine="If badge.Size > j Then";
if (__ref._badge /*anywheresoftware.b4a.objects.collections.List*/ .getSize()>_j) { 
RDebugUtils.currentLine=8585281;
 //BA.debugLineNum = 8585281;BA.debugLine="If badge.Get(j) <> \"\" Then";
if ((__ref._badge /*anywheresoftware.b4a.objects.collections.List*/ .Get(_j)).equals((Object)("")) == false) { 
RDebugUtils.currentLine=8585282;
 //BA.debugLineNum = 8585282;BA.debugLine="Dim data As Map = badge.Get(j)";
_data = new anywheresoftware.b4a.objects.collections.Map();
_data = (anywheresoftware.b4a.objects.collections.Map) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.collections.Map(), (anywheresoftware.b4a.objects.collections.Map.MyMap)(__ref._badge /*anywheresoftware.b4a.objects.collections.List*/ .Get(_j)));
RDebugUtils.currentLine=8585283;
 //BA.debugLineNum = 8585283;BA.debugLine="SetBadge(j+1,data.Get(\"count\"),data.Get(\"backc";
__ref._setbadge /*String*/ (null,(int) (_j+1),(int)(BA.ObjectToNumber(_data.Get((Object)("count")))),(int)(BA.ObjectToNumber(_data.Get((Object)("backcolor")))),(int)(BA.ObjectToNumber(_data.Get((Object)("textcolor")))));
 };
 }else {
RDebugUtils.currentLine=8585286;
 //BA.debugLineNum = 8585286;BA.debugLine="badge.Add(\"\")";
__ref._badge /*anywheresoftware.b4a.objects.collections.List*/ .Add((Object)(""));
 };
RDebugUtils.currentLine=8585289;
 //BA.debugLineNum = 8585289;BA.debugLine="If IconList.Size < TabCount Then IconList.add(i)";
if (__ref._iconlist /*anywheresoftware.b4a.objects.collections.List*/ .getSize()<__ref._tabcount /*int*/ ) { 
__ref._iconlist /*anywheresoftware.b4a.objects.collections.List*/ .Add((Object)(_i));};
RDebugUtils.currentLine=8585290;
 //BA.debugLineNum = 8585290;BA.debugLine="If j=CurrentTab-1 Then";
if (_j==__ref._currenttab /*int*/ -1) { 
RDebugUtils.currentLine=8585291;
 //BA.debugLineNum = 8585291;BA.debugLine="icon.Visible = False";
_icon.setVisible(__c.False);
RDebugUtils.currentLine=8585292;
 //BA.debugLineNum = 8585292;BA.debugLine="iconText.Visible = False";
_icontext.setVisible(__c.False);
 };
 }
};
RDebugUtils.currentLine=8585295;
 //BA.debugLineNum = 8585295;BA.debugLine="End Sub";
return "";
}
public String  _setbadge(b4a.example.wobblemenu __ref,int _tabid,int _count,int _backcolor,int _txtcolor) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "setbadge", false))
	 {return ((String) Debug.delegate(ba, "setbadge", new Object[] {_tabid,_count,_backcolor,_txtcolor}));}
anywheresoftware.b4a.objects.B4XViewWrapper _t = null;
anywheresoftware.b4a.objects.LabelWrapper _l = null;
anywheresoftware.b4a.objects.B4XViewWrapper _b4xlbl = null;
RDebugUtils.currentLine=9175040;
 //BA.debugLineNum = 9175040;BA.debugLine="Public Sub SetBadge(TabID As Int, Count As Int, Ba";
RDebugUtils.currentLine=9175042;
 //BA.debugLineNum = 9175042;BA.debugLine="If TabID >= 1 And TabID <= TabCount Then";
if (_tabid>=1 && _tabid<=__ref._tabcount /*int*/ ) { 
RDebugUtils.currentLine=9175043;
 //BA.debugLineNum = 9175043;BA.debugLine="If Count>0 Then";
if (_count>0) { 
RDebugUtils.currentLine=9175044;
 //BA.debugLineNum = 9175044;BA.debugLine="Dim t As B4XView = Tabs.Get(TabID-1)";
_t = new anywheresoftware.b4a.objects.B4XViewWrapper();
_t = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Get((int) (_tabid-1))));
RDebugUtils.currentLine=9175045;
 //BA.debugLineNum = 9175045;BA.debugLine="Dim l As Label";
_l = new anywheresoftware.b4a.objects.LabelWrapper();
RDebugUtils.currentLine=9175046;
 //BA.debugLineNum = 9175046;BA.debugLine="l.Initialize(\"\")";
_l.Initialize(ba,"");
RDebugUtils.currentLine=9175047;
 //BA.debugLineNum = 9175047;BA.debugLine="Dim b4xlbl As B4XView=l";
_b4xlbl = new anywheresoftware.b4a.objects.B4XViewWrapper();
_b4xlbl = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(_l.getObject()));
RDebugUtils.currentLine=9175048;
 //BA.debugLineNum = 9175048;BA.debugLine="b4xlbl.TextSize=10";
_b4xlbl.setTextSize((float) (10));
RDebugUtils.currentLine=9175049;
 //BA.debugLineNum = 9175049;BA.debugLine="b4xlbl.TextColor=xui.PaintOrColorToColor(TxtCol";
_b4xlbl.setTextColor(__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .PaintOrColorToColor((Object)(_txtcolor)));
RDebugUtils.currentLine=9175050;
 //BA.debugLineNum = 9175050;BA.debugLine="b4xlbl.Text = Count";
_b4xlbl.setText(BA.ObjectToCharSequence(_count));
RDebugUtils.currentLine=9175051;
 //BA.debugLineNum = 9175051;BA.debugLine="If Count>99 Then b4xlbl.Text = \"99+\"";
if (_count>99) { 
_b4xlbl.setText(BA.ObjectToCharSequence("99+"));};
RDebugUtils.currentLine=9175052;
 //BA.debugLineNum = 9175052;BA.debugLine="b4xlbl.SetTextAlignment(\"CENTER\",\"CENTER\")";
_b4xlbl.SetTextAlignment("CENTER","CENTER");
RDebugUtils.currentLine=9175053;
 //BA.debugLineNum = 9175053;BA.debugLine="t.AddView(l,(t.Width/3)*2,5dip,t.Height/3,t.Hei";
_t.AddView((android.view.View)(_l.getObject()),(int) ((_t.getWidth()/(double)3)*2),__c.DipToCurrent((int) (5)),(int) (_t.getHeight()/(double)3),(int) (_t.getHeight()/(double)3));
RDebugUtils.currentLine=9175055;
 //BA.debugLineNum = 9175055;BA.debugLine="b4xlbl.SetColorAndBorder(xui.PaintOrColorToColo";
_b4xlbl.SetColorAndBorder(__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .PaintOrColorToColor((Object)(_backcolor)),(int) (0),__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .Color_Transparent,(int) (_b4xlbl.getHeight()/(double)2));
RDebugUtils.currentLine=9175057;
 //BA.debugLineNum = 9175057;BA.debugLine="badge.set(TabID-1,CreateMap(\"count\":Count,\"back";
__ref._badge /*anywheresoftware.b4a.objects.collections.List*/ .Set((int) (_tabid-1),(Object)(__c.createMap(new Object[] {(Object)("count"),(Object)(_count),(Object)("backcolor"),(Object)(_backcolor),(Object)("textcolor"),(Object)(_txtcolor)}).getObject()));
 };
 }else {
RDebugUtils.currentLine=9175060;
 //BA.debugLineNum = 9175060;BA.debugLine="Log(\"Invalid Tab ID\")";
__c.LogImpl("29175060","Invalid Tab ID",0);
 };
RDebugUtils.currentLine=9175062;
 //BA.debugLineNum = 9175062;BA.debugLine="End Sub";
return "";
}
public String  _curveto(b4a.example.wobblemenu __ref,b4a.example.bcpath _path1,float _controlpointx,float _controlpointy,float _targetx,float _targety) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "curveto", false))
	 {return ((String) Debug.delegate(ba, "curveto", new Object[] {_path1,_controlpointx,_controlpointy,_targetx,_targety}));}
b4a.example.bcpath._internalbcpathpointdata _lastpoint = null;
float _currentx = 0f;
float _currenty = 0f;
int _numberofsteps = 0;
float _dt = 0f;
float _t = 0f;
int _i = 0;
float _tt1 = 0f;
float _tt2 = 0f;
float _tt3 = 0f;
float _x = 0f;
float _y = 0f;
RDebugUtils.currentLine=9633792;
 //BA.debugLineNum = 9633792;BA.debugLine="Private Sub CurveTo (Path1 As BCPath, ControlPoint";
RDebugUtils.currentLine=9633793;
 //BA.debugLineNum = 9633793;BA.debugLine="Dim LastPoint As InternalBCPathPointData = Path1.";
_lastpoint = (b4a.example.bcpath._internalbcpathpointdata)(_path1._points.Get((int) (_path1._points.getSize()-1)));
RDebugUtils.currentLine=9633794;
 //BA.debugLineNum = 9633794;BA.debugLine="Dim CurrentX As Float = LastPoint.X";
_currentx = _lastpoint.X;
RDebugUtils.currentLine=9633795;
 //BA.debugLineNum = 9633795;BA.debugLine="Dim Currenty As Float = LastPoint.Y";
_currenty = _lastpoint.Y;
RDebugUtils.currentLine=9633796;
 //BA.debugLineNum = 9633796;BA.debugLine="Dim NumberOfSteps As Int = 11 '<--- change as nee";
_numberofsteps = (int) (11);
RDebugUtils.currentLine=9633797;
 //BA.debugLineNum = 9633797;BA.debugLine="Dim dt As Float = 1 / NumberOfSteps";
_dt = (float) (1/(double)_numberofsteps);
RDebugUtils.currentLine=9633798;
 //BA.debugLineNum = 9633798;BA.debugLine="Dim t As Float = dt";
_t = _dt;
RDebugUtils.currentLine=9633799;
 //BA.debugLineNum = 9633799;BA.debugLine="For i = 1 To NumberOfSteps";
{
final int step7 = 1;
final int limit7 = _numberofsteps;
_i = (int) (1) ;
for (;_i <= limit7 ;_i = _i + step7 ) {
RDebugUtils.currentLine=9633800;
 //BA.debugLineNum = 9633800;BA.debugLine="Dim tt1 As Float =  (1 - t) * (1 - t)";
_tt1 = (float) ((1-_t)*(1-_t));
RDebugUtils.currentLine=9633801;
 //BA.debugLineNum = 9633801;BA.debugLine="Dim tt2 As Float = 2 * (1 - t) * t";
_tt2 = (float) (2*(1-_t)*_t);
RDebugUtils.currentLine=9633802;
 //BA.debugLineNum = 9633802;BA.debugLine="Dim tt3 As Float = t * t";
_tt3 = (float) (_t*_t);
RDebugUtils.currentLine=9633803;
 //BA.debugLineNum = 9633803;BA.debugLine="Dim x As Float = tt1 * CurrentX + tt2 * ControlP";
_x = (float) (_tt1*_currentx+_tt2*_controlpointx+_tt3*_targetx);
RDebugUtils.currentLine=9633804;
 //BA.debugLineNum = 9633804;BA.debugLine="Dim y As Float = tt1 * Currenty + tt2 * ControlP";
_y = (float) (_tt1*_currenty+_tt2*_controlpointy+_tt3*_targety);
RDebugUtils.currentLine=9633805;
 //BA.debugLineNum = 9633805;BA.debugLine="Path1.LineTo(x, y)";
_path1._lineto(_x,_y);
RDebugUtils.currentLine=9633806;
 //BA.debugLineNum = 9633806;BA.debugLine="t = t + dt";
_t = (float) (_t+_dt);
 }
};
RDebugUtils.currentLine=9633808;
 //BA.debugLineNum = 9633808;BA.debugLine="End Sub";
return "";
}
public String  _designercreateview(b4a.example.wobblemenu __ref,Object _base,anywheresoftware.b4a.objects.LabelWrapper _lbl,anywheresoftware.b4a.objects.collections.Map _props) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "designercreateview", false))
	 {return ((String) Debug.delegate(ba, "designercreateview", new Object[] {_base,_lbl,_props}));}
RDebugUtils.currentLine=8388608;
 //BA.debugLineNum = 8388608;BA.debugLine="Public Sub DesignerCreateView (Base As Object, Lbl";
RDebugUtils.currentLine=8388609;
 //BA.debugLineNum = 8388609;BA.debugLine="designerLbl=Lbl";
__ref._designerlbl /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(_lbl.getObject()));
RDebugUtils.currentLine=8388610;
 //BA.debugLineNum = 8388610;BA.debugLine="mBase = Base";
__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(_base));
RDebugUtils.currentLine=8388611;
 //BA.debugLineNum = 8388611;BA.debugLine="mBase.Color = xui.Color_Transparent";
__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setColor(__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .Color_Transparent);
RDebugUtils.currentLine=8388612;
 //BA.debugLineNum = 8388612;BA.debugLine="AbsoluteWidth= Min(mBase.Parent.Width,mBase.Paren";
__ref._absolutewidth /*int*/  = (int) (__c.Min(__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getParent().getWidth(),__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getParent().getHeight()));
RDebugUtils.currentLine=8388613;
 //BA.debugLineNum = 8388613;BA.debugLine="MenuHeight = (AbsoluteWidth/7) + ((AbsoluteWidth/";
__ref._menuheight /*int*/  = (int) ((__ref._absolutewidth /*int*/ /(double)7)+((__ref._absolutewidth /*int*/ /(double)7)/(double)4));
RDebugUtils.currentLine=8388614;
 //BA.debugLineNum = 8388614;BA.debugLine="mBase.Height = MenuHeight";
__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(__ref._menuheight /*int*/ );
RDebugUtils.currentLine=8388615;
 //BA.debugLineNum = 8388615;BA.debugLine="mBase.Top = mBase.Parent.Height - mBase.Height";
__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop((int) (__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getParent().getHeight()-__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()));
RDebugUtils.currentLine=8388616;
 //BA.debugLineNum = 8388616;BA.debugLine="circleRadius = AbsoluteWidth/7";
__ref._circleradius /*int*/  = (int) (__ref._absolutewidth /*int*/ /(double)7);
RDebugUtils.currentLine=8388618;
 //BA.debugLineNum = 8388618;BA.debugLine="BackgroundColor = xui.PaintOrColorToColor(Props.G";
__ref._backgroundcolor /*int*/  = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .PaintOrColorToColor(_props.Get((Object)("BackgroundColor")));
RDebugUtils.currentLine=8388619;
 //BA.debugLineNum = 8388619;BA.debugLine="IconColor = xui.PaintOrColorToColor(Props.Get(\"Ic";
__ref._iconcolor /*int*/  = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .PaintOrColorToColor(_props.Get((Object)("IconColor")));
RDebugUtils.currentLine=8388620;
 //BA.debugLineNum = 8388620;BA.debugLine="IconSize = xui.PaintOrColorToColor(Props.Get(\"Ico";
__ref._iconsize /*int*/  = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .PaintOrColorToColor(_props.Get((Object)("IconSize")));
RDebugUtils.currentLine=8388621;
 //BA.debugLineNum = 8388621;BA.debugLine="TextSize = xui.PaintOrColorToColor(Props.Get(\"Tex";
__ref._textsize /*int*/  = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .PaintOrColorToColor(_props.Get((Object)("TextSize")));
RDebugUtils.currentLine=8388622;
 //BA.debugLineNum = 8388622;BA.debugLine="TextColor = xui.PaintOrColorToColor(Props.Get(\"Te";
__ref._textcolor /*int*/  = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .PaintOrColorToColor(_props.Get((Object)("TextColor")));
RDebugUtils.currentLine=8388623;
 //BA.debugLineNum = 8388623;BA.debugLine="SelectedIconColor = xui.PaintOrColorToColor(Props";
__ref._selectediconcolor /*int*/  = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .PaintOrColorToColor(_props.Get((Object)("SelectedIconColor")));
RDebugUtils.currentLine=8388624;
 //BA.debugLineNum = 8388624;BA.debugLine="animDuration = Props.Get(\"AnimationDuration\")";
__ref._animduration /*int*/  = (int)(BA.ObjectToNumber(_props.Get((Object)("AnimationDuration"))));
RDebugUtils.currentLine=8388625;
 //BA.debugLineNum = 8388625;BA.debugLine="TabCount = Props.Get(\"TabCount\")";
__ref._tabcount /*int*/  = (int)(BA.ObjectToNumber(_props.Get((Object)("TabCount"))));
RDebugUtils.currentLine=8388626;
 //BA.debugLineNum = 8388626;BA.debugLine="ShadowColor = Props.Get(\"ShadowColor\")";
__ref._shadowcolor /*String*/  = BA.ObjectToString(_props.Get((Object)("ShadowColor")));
RDebugUtils.currentLine=8388627;
 //BA.debugLineNum = 8388627;BA.debugLine="If TabCount = 5 Then";
if (__ref._tabcount /*int*/ ==5) { 
RDebugUtils.currentLine=8388628;
 //BA.debugLineNum = 8388628;BA.debugLine="CurrentTab = 3";
__ref._currenttab /*int*/  = (int) (3);
 }else {
RDebugUtils.currentLine=8388630;
 //BA.debugLineNum = 8388630;BA.debugLine="CurrentTab = 2";
__ref._currenttab /*int*/  = (int) (2);
 };
RDebugUtils.currentLine=8388633;
 //BA.debugLineNum = 8388633;BA.debugLine="Select Props.Get(\"IconAppear\")";
switch (BA.switchObjectToInt(_props.Get((Object)("IconAppear")),(Object)("FROM EDGE"),(Object)("FROM CENTER"),(Object)("FADE IN"),(Object)("NO ANIMATION"))) {
case 0: {
RDebugUtils.currentLine=8388634;
 //BA.debugLineNum = 8388634;BA.debugLine="Case \"FROM EDGE\": IconAppearStyle = ICON_APPEAR_";
__ref._iconappearstyle /*int*/  = __ref._icon_appear_from_edge /*int*/ ;
 break; }
case 1: {
RDebugUtils.currentLine=8388635;
 //BA.debugLineNum = 8388635;BA.debugLine="Case \"FROM CENTER\": IconAppearStyle = ICON_APPEA";
__ref._iconappearstyle /*int*/  = __ref._icon_appear_from_center /*int*/ ;
 break; }
case 2: {
RDebugUtils.currentLine=8388636;
 //BA.debugLineNum = 8388636;BA.debugLine="Case \"FADE IN\": IconAppearStyle = ICON_APPEAR_FA";
__ref._iconappearstyle /*int*/  = __ref._icon_appear_fade_in /*int*/ ;
 break; }
case 3: {
RDebugUtils.currentLine=8388637;
 //BA.debugLineNum = 8388637;BA.debugLine="Case \"NO ANIMATION\": IconAppearStyle = ICON_APPE";
__ref._iconappearstyle /*int*/  = __ref._icon_appear_no_animation /*int*/ ;
 break; }
}
;
RDebugUtils.currentLine=8388640;
 //BA.debugLineNum = 8388640;BA.debugLine="Select Props.Get(\"AnimationType\")";
switch (BA.switchObjectToInt(_props.Get((Object)("AnimationType")),(Object)("ELASTIC OUT"),(Object)("ELASTIC IN"),(Object)("EASE OUT"),(Object)("EASE IN"),(Object)("NONE"))) {
case 0: {
RDebugUtils.currentLine=8388641;
 //BA.debugLineNum = 8388641;BA.debugLine="Case \"ELASTIC OUT\": AnimationType = ANIMATION_TY";
__ref._animationtype /*int*/  = __ref._animation_type_elastic_out /*int*/ ;
 break; }
case 1: {
RDebugUtils.currentLine=8388642;
 //BA.debugLineNum = 8388642;BA.debugLine="Case \"ELASTIC IN\": AnimationType = ANIMATION_TYP";
__ref._animationtype /*int*/  = __ref._animation_type_elastic_in /*int*/ ;
 break; }
case 2: {
RDebugUtils.currentLine=8388643;
 //BA.debugLineNum = 8388643;BA.debugLine="Case \"EASE OUT\": AnimationType = ANIMATION_TYPE_";
__ref._animationtype /*int*/  = __ref._animation_type_ease_out /*int*/ ;
 break; }
case 3: {
RDebugUtils.currentLine=8388644;
 //BA.debugLineNum = 8388644;BA.debugLine="Case \"EASE IN\": AnimationType = ANIMATION_TYPE_E";
__ref._animationtype /*int*/  = __ref._animation_type_ease_in /*int*/ ;
 break; }
case 4: {
RDebugUtils.currentLine=8388645;
 //BA.debugLineNum = 8388645;BA.debugLine="Case \"NONE\": AnimationType = ANIMATION_TYPE_NONE";
__ref._animationtype /*int*/  = __ref._animation_type_none /*int*/ ;
 break; }
}
;
RDebugUtils.currentLine=8388648;
 //BA.debugLineNum = 8388648;BA.debugLine="DrawView";
__ref._drawview /*String*/ (null);
RDebugUtils.currentLine=8388650;
 //BA.debugLineNum = 8388650;BA.debugLine="End Sub";
return "";
}
public String  _drawcircle(b4a.example.wobblemenu __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "drawcircle", false))
	 {return ((String) Debug.delegate(ba, "drawcircle", null));}
anywheresoftware.b4a.objects.B4XCanvas _circle = null;
int _innerradius = 0;
int _i = 0;
RDebugUtils.currentLine=8781824;
 //BA.debugLineNum = 8781824;BA.debugLine="Private Sub DrawCircle";
RDebugUtils.currentLine=8781825;
 //BA.debugLineNum = 8781825;BA.debugLine="Dim circle As B4XCanvas";
_circle = new anywheresoftware.b4a.objects.B4XCanvas();
RDebugUtils.currentLine=8781826;
 //BA.debugLineNum = 8781826;BA.debugLine="circle.Initialize(TabCircle)";
_circle.Initialize(__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ );
RDebugUtils.currentLine=8781827;
 //BA.debugLineNum = 8781827;BA.debugLine="Dim innerRadius As Int = Min(mBase.Parent.Width,m";
_innerradius = (int) (__c.Min(__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getParent().getWidth(),__ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getParent().getHeight())/(double)8);
RDebugUtils.currentLine=8781828;
 //BA.debugLineNum = 8781828;BA.debugLine="For i=1 To 10";
{
final int step4 = 1;
final int limit4 = (int) (10);
_i = (int) (1) ;
for (;_i <= limit4 ;_i = _i + step4 ) {
RDebugUtils.currentLine=8781829;
 //BA.debugLineNum = 8781829;BA.debugLine="If ShadowColor=\"Dark\" Then";
if ((__ref._shadowcolor /*String*/ ).equals("Dark")) { 
RDebugUtils.currentLine=8781830;
 //BA.debugLineNum = 8781830;BA.debugLine="circle.DrawCircle(circleRadius/2,(circleRadius/";
_circle.DrawCircle((float) (__ref._circleradius /*int*/ /(double)2),(float) ((__ref._circleradius /*int*/ /(double)2)+2),(float) ((_innerradius/(double)2)+_i),__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .Color_ARGB((int) (3),(int) (0),(int) (0),(int) (0)),__c.True,(float) (0));
 }else 
{RDebugUtils.currentLine=8781831;
 //BA.debugLineNum = 8781831;BA.debugLine="Else If ShadowColor=\"Light\" Then";
if ((__ref._shadowcolor /*String*/ ).equals("Light")) { 
RDebugUtils.currentLine=8781832;
 //BA.debugLineNum = 8781832;BA.debugLine="circle.DrawCircle(circleRadius/2,(circleRadius/";
_circle.DrawCircle((float) (__ref._circleradius /*int*/ /(double)2),(float) ((__ref._circleradius /*int*/ /(double)2)+2),(float) ((_innerradius/(double)2)+_i),__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .Color_ARGB((int) (3),(int) (255),(int) (255),(int) (255)),__c.True,(float) (0));
 }}
;
 }
};
RDebugUtils.currentLine=8781836;
 //BA.debugLineNum = 8781836;BA.debugLine="circle.DrawCircle(circleRadius/2,circleRadius/2,i";
_circle.DrawCircle((float) (__ref._circleradius /*int*/ /(double)2),(float) (__ref._circleradius /*int*/ /(double)2),(float) (_innerradius/(double)2),__ref._backgroundcolor /*int*/ ,__c.True,(float) (0));
RDebugUtils.currentLine=8781837;
 //BA.debugLineNum = 8781837;BA.debugLine="circle.Invalidate";
_circle.Invalidate();
RDebugUtils.currentLine=8781838;
 //BA.debugLineNum = 8781838;BA.debugLine="End Sub";
return "";
}
public String  _drawcurve(b4a.example.wobblemenu __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "drawcurve", false))
	 {return ((String) Debug.delegate(ba, "drawcurve", null));}
int[] _backargb = null;
anywheresoftware.b4a.objects.B4XCanvas _curve = null;
anywheresoftware.b4a.objects.B4XCanvas.B4XRect _rect = null;
b4a.example.bitmapcreator _bezierview = null;
b4a.example.bcpath _bezierpath = null;
double _swidth = 0;
double _sheight = 0;
double _curveheight = 0;
int _shadow = 0;
RDebugUtils.currentLine=8716288;
 //BA.debugLineNum = 8716288;BA.debugLine="Private Sub DrawCurve";
RDebugUtils.currentLine=8716289;
 //BA.debugLineNum = 8716289;BA.debugLine="Dim backARGB() As Int = GetARGB(BackgroundColor)";
_backargb = __ref._getargb /*int[]*/ (null,__ref._backgroundcolor /*int*/ );
RDebugUtils.currentLine=8716290;
 //BA.debugLineNum = 8716290;BA.debugLine="Dim curve As B4XCanvas";
_curve = new anywheresoftware.b4a.objects.B4XCanvas();
RDebugUtils.currentLine=8716291;
 //BA.debugLineNum = 8716291;BA.debugLine="curve.Initialize(TabCurve)";
_curve.Initialize(__ref._tabcurve /*anywheresoftware.b4a.objects.B4XViewWrapper*/ );
RDebugUtils.currentLine=8716292;
 //BA.debugLineNum = 8716292;BA.debugLine="Dim rect As B4XRect";
_rect = new anywheresoftware.b4a.objects.B4XCanvas.B4XRect();
RDebugUtils.currentLine=8716293;
 //BA.debugLineNum = 8716293;BA.debugLine="Dim BezierView As BitmapCreator";
_bezierview = new b4a.example.bitmapcreator();
RDebugUtils.currentLine=8716294;
 //BA.debugLineNum = 8716294;BA.debugLine="Dim BezierPath As BCPath";
_bezierpath = new b4a.example.bcpath();
RDebugUtils.currentLine=8716295;
 //BA.debugLineNum = 8716295;BA.debugLine="Dim sWidth As Double = 1000";
_swidth = 1000;
RDebugUtils.currentLine=8716296;
 //BA.debugLineNum = 8716296;BA.debugLine="Dim sHeight As Double = 500";
_sheight = 500;
RDebugUtils.currentLine=8716298;
 //BA.debugLineNum = 8716298;BA.debugLine="Dim curveHeight As Double = sHeight- sHeight/5 -";
_curveheight = _sheight-_sheight/(double)5-__c.DipToCurrent((int) (3));
RDebugUtils.currentLine=8716304;
 //BA.debugLineNum = 8716304;BA.debugLine="BezierPath.Initialize(0, 0)";
_bezierpath._initialize(ba,(float) (0),(float) (0));
RDebugUtils.currentLine=8716305;
 //BA.debugLineNum = 8716305;BA.debugLine="CurveTo(BezierPath, sWidth/9, 0, sWidth/7, (sHeig";
__ref._curveto /*String*/ (null,_bezierpath,(float) (_swidth/(double)9),(float) (0),(float) (_swidth/(double)7),(float) ((_sheight/(double)3)));
RDebugUtils.currentLine=8716306;
 //BA.debugLineNum = 8716306;BA.debugLine="CurveTo(BezierPath, sWidth/5 + 5dip, curveHeight";
__ref._curveto /*String*/ (null,_bezierpath,(float) (_swidth/(double)5+__c.DipToCurrent((int) (5))),(float) (_curveheight-__c.DipToCurrent((int) (8))),(float) (_swidth/(double)2),(float) (_curveheight));
RDebugUtils.currentLine=8716307;
 //BA.debugLineNum = 8716307;BA.debugLine="CurveTo(BezierPath, (sWidth-sWidth/5) - 5dip, cur";
__ref._curveto /*String*/ (null,_bezierpath,(float) ((_swidth-_swidth/(double)5)-__c.DipToCurrent((int) (5))),(float) (_curveheight-__c.DipToCurrent((int) (8))),(float) (_swidth-(_swidth/(double)7)),(float) ((_sheight/(double)3)));
RDebugUtils.currentLine=8716308;
 //BA.debugLineNum = 8716308;BA.debugLine="CurveTo(BezierPath, (sWidth-sWidth/9)-2dip, 0, sW";
__ref._curveto /*String*/ (null,_bezierpath,(float) ((_swidth-_swidth/(double)9)-__c.DipToCurrent((int) (2))),(float) (0),(float) (_swidth),(float) (0));
RDebugUtils.currentLine=8716309;
 //BA.debugLineNum = 8716309;BA.debugLine="BezierPath.LineTo(sWidth,sHeight)";
_bezierpath._lineto((float) (_swidth),(float) (_sheight));
RDebugUtils.currentLine=8716310;
 //BA.debugLineNum = 8716310;BA.debugLine="BezierPath.LineTo(0,sHeight)";
_bezierpath._lineto((float) (0),(float) (_sheight));
RDebugUtils.currentLine=8716311;
 //BA.debugLineNum = 8716311;BA.debugLine="BezierPath.LineTo(0,0)";
_bezierpath._lineto((float) (0),(float) (0));
RDebugUtils.currentLine=8716313;
 //BA.debugLineNum = 8716313;BA.debugLine="Dim shadow As Int";
_shadow = 0;
RDebugUtils.currentLine=8716314;
 //BA.debugLineNum = 8716314;BA.debugLine="If ShadowColor=\"Dark\" Then";
if ((__ref._shadowcolor /*String*/ ).equals("Dark")) { 
RDebugUtils.currentLine=8716315;
 //BA.debugLineNum = 8716315;BA.debugLine="shadow = xui.Color_ARGB(backARGB(0),Max(0,backAR";
_shadow = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .Color_ARGB(_backargb[(int) (0)],(int) (__c.Max(0,_backargb[(int) (1)]-20)),(int) (__c.Max(0,_backargb[(int) (2)]-20)),(int) (__c.Max(0,_backargb[(int) (3)]-20)));
 }else 
{RDebugUtils.currentLine=8716316;
 //BA.debugLineNum = 8716316;BA.debugLine="Else If ShadowColor=\"Light\" Then";
if ((__ref._shadowcolor /*String*/ ).equals("Light")) { 
RDebugUtils.currentLine=8716317;
 //BA.debugLineNum = 8716317;BA.debugLine="shadow = xui.Color_ARGB(backARGB(0),Min(255,back";
_shadow = __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .Color_ARGB(_backargb[(int) (0)],(int) (__c.Min(255,_backargb[(int) (1)]+20)),(int) (__c.Min(255,_backargb[(int) (2)]+20)),(int) (__c.Min(255,_backargb[(int) (3)]+20)));
 }}
;
RDebugUtils.currentLine=8716320;
 //BA.debugLineNum = 8716320;BA.debugLine="BezierView.Initialize(sWidth,sHeight)";
_bezierview._initialize(ba,(int) (_swidth),(int) (_sheight));
RDebugUtils.currentLine=8716321;
 //BA.debugLineNum = 8716321;BA.debugLine="BezierView.DrawPath(BezierPath,BackgroundColor,Tr";
_bezierview._drawpath(_bezierpath,__ref._backgroundcolor /*int*/ ,__c.True,(int) (0));
RDebugUtils.currentLine=8716323;
 //BA.debugLineNum = 8716323;BA.debugLine="BezierView.DrawPath(BezierPath,shadow,False,10)";
_bezierview._drawpath(_bezierpath,_shadow,__c.False,(int) (10));
RDebugUtils.currentLine=8716328;
 //BA.debugLineNum = 8716328;BA.debugLine="rect.Initialize(TabContainer.Width - (AbsoluteWid";
_rect.Initialize((float) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()-(__ref._absolutewidth /*int*/ /(double)5)/(double)2-4),(float) (0),(float) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()+(__ref._absolutewidth /*int*/ /(double)5)/(double)2+4),(float) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()));
RDebugUtils.currentLine=8716329;
 //BA.debugLineNum = 8716329;BA.debugLine="curve.DrawBitmap(BezierView.Bitmap,rect)";
_curve.DrawBitmap((android.graphics.Bitmap)(_bezierview._getbitmap().getObject()),_rect);
RDebugUtils.currentLine=8716331;
 //BA.debugLineNum = 8716331;BA.debugLine="rect.Initialize(0,0,TabContainer.Width -(Absolute";
_rect.Initialize((float) (0),(float) (0),(float) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()-(__ref._absolutewidth /*int*/ /(double)5)/(double)2),(float) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()));
RDebugUtils.currentLine=8716332;
 //BA.debugLineNum = 8716332;BA.debugLine="curve.DrawRect(rect,BackgroundColor,True,0)";
_curve.DrawRect(_rect,__ref._backgroundcolor /*int*/ ,__c.True,(float) (0));
RDebugUtils.currentLine=8716333;
 //BA.debugLineNum = 8716333;BA.debugLine="rect.Initialize(TabContainer.Width +(AbsoluteWidt";
_rect.Initialize((float) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()+(__ref._absolutewidth /*int*/ /(double)5)/(double)2),(float) (0),(float) (__ref._tabcurve /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()),(float) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()));
RDebugUtils.currentLine=8716334;
 //BA.debugLineNum = 8716334;BA.debugLine="curve.DrawRect(rect,BackgroundColor,True,0)";
_curve.DrawRect(_rect,__ref._backgroundcolor /*int*/ ,__c.True,(float) (0));
RDebugUtils.currentLine=8716335;
 //BA.debugLineNum = 8716335;BA.debugLine="curve.DrawLine(0,0,TabContainer.Width -(AbsoluteW";
_curve.DrawLine((float) (0),(float) (0),(float) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()-(__ref._absolutewidth /*int*/ /(double)5)/(double)2),(float) (0),_shadow,(float) (4));
RDebugUtils.currentLine=8716336;
 //BA.debugLineNum = 8716336;BA.debugLine="curve.DrawLine(TabContainer.Width +(AbsoluteWidth";
_curve.DrawLine((float) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()+(__ref._absolutewidth /*int*/ /(double)5)/(double)2),(float) (0),(float) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()*2),(float) (0),_shadow,(float) (4));
RDebugUtils.currentLine=8716337;
 //BA.debugLineNum = 8716337;BA.debugLine="curve.DrawLine(0,TabContainer.Height,TabContainer";
_curve.DrawLine((float) (0),(float) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()),(float) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()*2),(float) (__ref._tabcontainer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()),__ref._backgroundcolor /*int*/ ,(float) (4));
RDebugUtils.currentLine=8716339;
 //BA.debugLineNum = 8716339;BA.debugLine="curve.Invalidate";
_curve.Invalidate();
RDebugUtils.currentLine=8716340;
 //BA.debugLineNum = 8716340;BA.debugLine="End Sub";
return "";
}
public int[]  _getargb(b4a.example.wobblemenu __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "getargb", false))
	 {return ((int[]) Debug.delegate(ba, "getargb", new Object[] {_color}));}
int[] _res = null;
RDebugUtils.currentLine=9699328;
 //BA.debugLineNum = 9699328;BA.debugLine="Private Sub GetARGB(Color As Int) As Int()";
RDebugUtils.currentLine=9699329;
 //BA.debugLineNum = 9699329;BA.debugLine="Private res(4) As Int";
_res = new int[(int) (4)];
;
RDebugUtils.currentLine=9699330;
 //BA.debugLineNum = 9699330;BA.debugLine="res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0x";
_res[(int) (0)] = __c.Bit.UnsignedShiftRight(__c.Bit.And(_color,(int) (0xff000000)),(int) (24));
RDebugUtils.currentLine=9699331;
 //BA.debugLineNum = 9699331;BA.debugLine="res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0x";
_res[(int) (1)] = __c.Bit.UnsignedShiftRight(__c.Bit.And(_color,(int) (0xff0000)),(int) (16));
RDebugUtils.currentLine=9699332;
 //BA.debugLineNum = 9699332;BA.debugLine="res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0x";
_res[(int) (2)] = __c.Bit.UnsignedShiftRight(__c.Bit.And(_color,(int) (0xff00)),(int) (8));
RDebugUtils.currentLine=9699333;
 //BA.debugLineNum = 9699333;BA.debugLine="res(3) = Bit.And(Color, 0xff)";
_res[(int) (3)] = __c.Bit.And(_color,(int) (0xff));
RDebugUtils.currentLine=9699334;
 //BA.debugLineNum = 9699334;BA.debugLine="Return res";
if (true) return _res;
RDebugUtils.currentLine=9699335;
 //BA.debugLineNum = 9699335;BA.debugLine="End Sub";
return null;
}
public void  _setcircleicon(b4a.example.wobblemenu __ref) throws Exception{
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "setcircleicon", false))
	 {Debug.delegate(ba, "setcircleicon", null); return;}
ResumableSub_SetCircleIcon rsub = new ResumableSub_SetCircleIcon(this,__ref);
rsub.resume(ba, null);
}
public static class ResumableSub_SetCircleIcon extends BA.ResumableSub {
public ResumableSub_SetCircleIcon(b4a.example.wobblemenu parent,b4a.example.wobblemenu __ref) {
this.parent = parent;
this.__ref = __ref;
this.__ref = parent;
}
b4a.example.wobblemenu __ref;
b4a.example.wobblemenu parent;
int _id = 0;
anywheresoftware.b4a.objects.LabelWrapper _cl = null;
anywheresoftware.b4a.objects.B4XViewWrapper _mtab = null;
anywheresoftware.b4a.objects.LabelWrapper _tl = null;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="wobblemenu";

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
RDebugUtils.currentLine=8650754;
 //BA.debugLineNum = 8650754;BA.debugLine="Dim id As Int = 0";
_id = (int) (0);
RDebugUtils.currentLine=8650759;
 //BA.debugLineNum = 8650759;BA.debugLine="Select IconAppearStyle";
if (true) break;

case 1:
//select
this.state = 8;
switch (BA.switchObjectToInt(__ref._iconappearstyle /*int*/ ,(int) (0),(int) (1),(int) (2))) {
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
RDebugUtils.currentLine=8650761;
 //BA.debugLineNum = 8650761;BA.debugLine="TabCircle.GetView(id+1).SetLayoutAnimated(0,Tab";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).SetLayoutAnimated((int) (0),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).getLeft(),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).getTop(),(int) (__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()/(double)2),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).getHeight());
RDebugUtils.currentLine=8650762;
 //BA.debugLineNum = 8650762;BA.debugLine="TabCircle.GetView(id+2).SetLayoutAnimated(0,Tab";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+2)).SetLayoutAnimated((int) (0),(int) (__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()-(__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)5)-(__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()/(double)2)),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (2)).getTop(),(int) (__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()/(double)2),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (2)).getHeight());
RDebugUtils.currentLine=8650763;
 //BA.debugLineNum = 8650763;BA.debugLine="TabCircle.GetView(id+1).SetVisibleAnimated(0,Tr";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).SetVisibleAnimated((int) (0),parent.__c.True);
RDebugUtils.currentLine=8650764;
 //BA.debugLineNum = 8650764;BA.debugLine="TabCircle.GetView(id+2).SetVisibleAnimated(0,Tr";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+2)).SetVisibleAnimated((int) (0),parent.__c.True);
 if (true) break;

case 5:
//C
this.state = 8;
RDebugUtils.currentLine=8650766;
 //BA.debugLineNum = 8650766;BA.debugLine="TabCircle.GetView(id+3).SetLayoutAnimated(0,Tab";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+3)).SetLayoutAnimated((int) (0),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).getLeft(),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).getTop(),(int) (__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+2)).getLeft()-__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).getLeft()),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).getHeight());
RDebugUtils.currentLine=8650767;
 //BA.debugLineNum = 8650767;BA.debugLine="TabCircle.GetView(id+3).SetVisibleAnimated(0,Tr";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+3)).SetVisibleAnimated((int) (0),parent.__c.True);
 if (true) break;

case 7:
//C
this.state = 8;
RDebugUtils.currentLine=8650769;
 //BA.debugLineNum = 8650769;BA.debugLine="TabCircle.GetView(id).SetVisibleAnimated(0,Fals";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView(_id).SetVisibleAnimated((int) (0),parent.__c.False);
 if (true) break;

case 8:
//C
this.state = 9;
;
RDebugUtils.currentLine=8650771;
 //BA.debugLineNum = 8650771;BA.debugLine="Sleep(1)";
parent.__c.Sleep(ba,new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "wobblemenu", "setcircleicon"),(int) (1));
this.state = 17;
return;
case 17:
//C
this.state = 9;
;
RDebugUtils.currentLine=8650773;
 //BA.debugLineNum = 8650773;BA.debugLine="Dim cl As Label = TabCircle.GetView(id)";
_cl = new anywheresoftware.b4a.objects.LabelWrapper();
_cl = (anywheresoftware.b4a.objects.LabelWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.LabelWrapper(), (android.widget.TextView)(__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView(_id).getObject()));
RDebugUtils.currentLine=8650774;
 //BA.debugLineNum = 8650774;BA.debugLine="Dim mTab As B4XView = Tabs.Get(CurrentTab-1)";
_mtab = new anywheresoftware.b4a.objects.B4XViewWrapper();
_mtab = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Get((int) (__ref._currenttab /*int*/ -1))));
RDebugUtils.currentLine=8650775;
 //BA.debugLineNum = 8650775;BA.debugLine="Dim tl As Label = mTab.GetView(0)";
_tl = new anywheresoftware.b4a.objects.LabelWrapper();
_tl = (anywheresoftware.b4a.objects.LabelWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.LabelWrapper(), (android.widget.TextView)(_mtab.GetView((int) (0)).getObject()));
RDebugUtils.currentLine=8650776;
 //BA.debugLineNum = 8650776;BA.debugLine="cl.Text = tl.text";
_cl.setText(BA.ObjectToCharSequence(_tl.getText()));
RDebugUtils.currentLine=8650783;
 //BA.debugLineNum = 8650783;BA.debugLine="cl.Typeface = tl.Typeface";
_cl.setTypeface(_tl.getTypeface());
RDebugUtils.currentLine=8650786;
 //BA.debugLineNum = 8650786;BA.debugLine="Select IconAppearStyle";
if (true) break;

case 9:
//select
this.state = 16;
switch (BA.switchObjectToInt(__ref._iconappearstyle /*int*/ ,(int) (0),(int) (1),(int) (2))) {
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
RDebugUtils.currentLine=8650788;
 //BA.debugLineNum = 8650788;BA.debugLine="TabCircle.GetView(id+1).SetLayoutAnimated(800,T";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).SetLayoutAnimated((int) (800),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).getLeft(),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).getTop(),parent.__c.DipToCurrent((int) (1)),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).getHeight());
RDebugUtils.currentLine=8650789;
 //BA.debugLineNum = 8650789;BA.debugLine="TabCircle.GetView(id+2).SetLayoutAnimated(800,T";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+2)).SetLayoutAnimated((int) (800),(int) (__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()-(__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)4)-parent.__c.DipToCurrent((int) (1))),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+2)).getTop(),parent.__c.DipToCurrent((int) (1)),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+2)).getHeight());
 if (true) break;

case 13:
//C
this.state = 16;
RDebugUtils.currentLine=8650791;
 //BA.debugLineNum = 8650791;BA.debugLine="TabCircle.GetView(id+3).SetLayoutAnimated(800,T";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+3)).SetLayoutAnimated((int) (800),(int) (__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()/(double)2),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).getTop(),parent.__c.DipToCurrent((int) (1)),__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).getHeight());
 if (true) break;

case 15:
//C
this.state = 16;
RDebugUtils.currentLine=8650793;
 //BA.debugLineNum = 8650793;BA.debugLine="TabCircle.GetView(id).SetVisibleAnimated(800,Tr";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView(_id).SetVisibleAnimated((int) (800),parent.__c.True);
 if (true) break;

case 16:
//C
this.state = -1;
;
RDebugUtils.currentLine=8650797;
 //BA.debugLineNum = 8650797;BA.debugLine="Sleep(400)";
parent.__c.Sleep(ba,new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "wobblemenu", "setcircleicon"),(int) (400));
this.state = 18;
return;
case 18:
//C
this.state = -1;
;
RDebugUtils.currentLine=8650801;
 //BA.debugLineNum = 8650801;BA.debugLine="TabCircle.GetView(id+1).SetVisibleAnimated(100,Fa";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+1)).SetVisibleAnimated((int) (100),parent.__c.False);
RDebugUtils.currentLine=8650802;
 //BA.debugLineNum = 8650802;BA.debugLine="TabCircle.GetView(id+2).SetVisibleAnimated(100,Fa";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+2)).SetVisibleAnimated((int) (100),parent.__c.False);
RDebugUtils.currentLine=8650803;
 //BA.debugLineNum = 8650803;BA.debugLine="TabCircle.GetView(id+3).SetVisibleAnimated(100,Fa";
__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .GetView((int) (_id+3)).SetVisibleAnimated((int) (100),parent.__c.False);
RDebugUtils.currentLine=8650805;
 //BA.debugLineNum = 8650805;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public int  _getcurrenttab(b4a.example.wobblemenu __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "getcurrenttab", false))
	 {return ((Integer) Debug.delegate(ba, "getcurrenttab", null));}
RDebugUtils.currentLine=8912896;
 //BA.debugLineNum = 8912896;BA.debugLine="Public Sub GetCurrentTab As Int";
RDebugUtils.currentLine=8912897;
 //BA.debugLineNum = 8912897;BA.debugLine="Return CurrentTab";
if (true) return __ref._currenttab /*int*/ ;
RDebugUtils.currentLine=8912898;
 //BA.debugLineNum = 8912898;BA.debugLine="End Sub";
return 0;
}
public boolean  _getenabletab(b4a.example.wobblemenu __ref,int _tabid) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "getenabletab", false))
	 {return ((Boolean) Debug.delegate(ba, "getenabletab", new Object[] {_tabid}));}
RDebugUtils.currentLine=10747904;
 //BA.debugLineNum = 10747904;BA.debugLine="Public Sub GetEnableTab(TabID As Int) As Boolean";
RDebugUtils.currentLine=10747905;
 //BA.debugLineNum = 10747905;BA.debugLine="If TabID >= 1 And TabID <= TabCount Then";
if (_tabid>=1 && _tabid<=__ref._tabcount /*int*/ ) { 
RDebugUtils.currentLine=10747906;
 //BA.debugLineNum = 10747906;BA.debugLine="Return enabled.get(TabID-1)";
if (true) return BA.ObjectToBoolean(__ref._enabled /*anywheresoftware.b4a.objects.collections.List*/ .Get((int) (_tabid-1)));
 }else {
RDebugUtils.currentLine=10747908;
 //BA.debugLineNum = 10747908;BA.debugLine="Log(\"Invalid Tab ID\")";
__c.LogImpl("210747908","Invalid Tab ID",0);
RDebugUtils.currentLine=10747909;
 //BA.debugLineNum = 10747909;BA.debugLine="Return False";
if (true) return __c.False;
 };
RDebugUtils.currentLine=10747911;
 //BA.debugLineNum = 10747911;BA.debugLine="End Sub";
return false;
}
public int  _getheight(b4a.example.wobblemenu __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "getheight", false))
	 {return ((Integer) Debug.delegate(ba, "getheight", null));}
RDebugUtils.currentLine=9306112;
 //BA.debugLineNum = 9306112;BA.debugLine="Public Sub getHeight As Int";
RDebugUtils.currentLine=9306113;
 //BA.debugLineNum = 9306113;BA.debugLine="Return mBase.Height";
if (true) return __ref._mbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight();
RDebugUtils.currentLine=9306114;
 //BA.debugLineNum = 9306114;BA.debugLine="End Sub";
return 0;
}
public String  _icontab_click(b4a.example.wobblemenu __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "icontab_click", false))
	 {return ((String) Debug.delegate(ba, "icontab_click", null));}
RDebugUtils.currentLine=9371648;
 //BA.debugLineNum = 9371648;BA.debugLine="Private Sub IconTab_Click";
RDebugUtils.currentLine=9371649;
 //BA.debugLineNum = 9371649;BA.debugLine="TriggerTabClickEvent(Sender)";
__ref._triggertabclickevent /*String*/ (null,(anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(__c.Sender(ba))));
RDebugUtils.currentLine=9371650;
 //BA.debugLineNum = 9371650;BA.debugLine="End Sub";
return "";
}
public String  _triggertabclickevent(b4a.example.wobblemenu __ref,anywheresoftware.b4a.objects.B4XViewWrapper _t) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "triggertabclickevent", false))
	 {return ((String) Debug.delegate(ba, "triggertabclickevent", new Object[] {_t}));}
int _i = 0;
anywheresoftware.b4a.objects.B4XViewWrapper _tb = null;
RDebugUtils.currentLine=9437184;
 //BA.debugLineNum = 9437184;BA.debugLine="Private Sub TriggerTabClickEvent(t As B4XView)";
RDebugUtils.currentLine=9437185;
 //BA.debugLineNum = 9437185;BA.debugLine="If CurrentTab <> Tabs.IndexOf(t)+1 Then CurrentTa";
if (__ref._currenttab /*int*/ !=__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .IndexOf((Object)(_t.getObject()))+1) { 
__ref._currenttab /*int*/  = (int) (__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .IndexOf((Object)(_t.getObject()))+1);};
RDebugUtils.currentLine=9437186;
 //BA.debugLineNum = 9437186;BA.debugLine="AnimateTo(TabCurve,t.Left+(t.Width/2)-(TabCurve.W";
__ref._animateto /*void*/ (null,__ref._tabcurve /*anywheresoftware.b4a.objects.B4XViewWrapper*/ ,(int) (_t.getLeft()+(_t.getWidth()/(double)2)-(__ref._tabcurve /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()/(double)2)-1));
RDebugUtils.currentLine=9437187;
 //BA.debugLineNum = 9437187;BA.debugLine="AnimateTo(TabCircle,t.Left+(t.Width/2)-(TabCircle";
__ref._animateto /*void*/ (null,__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ ,(int) (_t.getLeft()+(_t.getWidth()/(double)2)-(__ref._tabcircle /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()/(double)2)));
RDebugUtils.currentLine=9437189;
 //BA.debugLineNum = 9437189;BA.debugLine="For i=0 To TabCount-1";
{
final int step4 = 1;
final int limit4 = (int) (__ref._tabcount /*int*/ -1);
_i = (int) (0) ;
for (;_i <= limit4 ;_i = _i + step4 ) {
RDebugUtils.currentLine=9437190;
 //BA.debugLineNum = 9437190;BA.debugLine="Dim tb As B4XView = Tabs.Get(i)";
_tb = new anywheresoftware.b4a.objects.B4XViewWrapper();
_tb = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Get(_i)));
RDebugUtils.currentLine=9437191;
 //BA.debugLineNum = 9437191;BA.debugLine="If tb<>t Then";
if ((_tb).equals(_t) == false) { 
RDebugUtils.currentLine=9437192;
 //BA.debugLineNum = 9437192;BA.debugLine="tb.GetView(0).Visible = True";
_tb.GetView((int) (0)).setVisible(__c.True);
RDebugUtils.currentLine=9437193;
 //BA.debugLineNum = 9437193;BA.debugLine="tb.GetView(1).Visible = True";
_tb.GetView((int) (1)).setVisible(__c.True);
RDebugUtils.currentLine=9437194;
 //BA.debugLineNum = 9437194;BA.debugLine="If tb.NumberOfViews = 3 Then tb.GetView(2).Visi";
if (_tb.getNumberOfViews()==3) { 
_tb.GetView((int) (2)).setVisible(__c.True);};
 }else {
RDebugUtils.currentLine=9437196;
 //BA.debugLineNum = 9437196;BA.debugLine="tb.GetView(0).Visible = False";
_tb.GetView((int) (0)).setVisible(__c.False);
RDebugUtils.currentLine=9437197;
 //BA.debugLineNum = 9437197;BA.debugLine="tb.GetView(1).Visible = False";
_tb.GetView((int) (1)).setVisible(__c.False);
RDebugUtils.currentLine=9437198;
 //BA.debugLineNum = 9437198;BA.debugLine="If tb.NumberOfViews = 3 Then tb.GetView(2).Visi";
if (_tb.getNumberOfViews()==3) { 
_tb.GetView((int) (2)).setVisible(__c.False);};
 };
 }
};
RDebugUtils.currentLine=9437201;
 //BA.debugLineNum = 9437201;BA.debugLine="SetCircleIcon";
__ref._setcircleicon /*void*/ (null);
RDebugUtils.currentLine=9437203;
 //BA.debugLineNum = 9437203;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_Tab\"&C";
if (__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .SubExists(ba,__ref._mcallback /*Object*/ ,__ref._meventname /*String*/ +"_Tab"+BA.NumberToString(__ref._currenttab /*int*/ )+"Click",(int) (0))) { 
RDebugUtils.currentLine=9437204;
 //BA.debugLineNum = 9437204;BA.debugLine="CallSub(mCallBack, mEventName & \"_Tab\"&CurrentTa";
__c.CallSubNew(ba,__ref._mcallback /*Object*/ ,__ref._meventname /*String*/ +"_Tab"+BA.NumberToString(__ref._currenttab /*int*/ )+"Click");
 };
RDebugUtils.currentLine=9437206;
 //BA.debugLineNum = 9437206;BA.debugLine="End Sub";
return "";
}
public String  _initialize(b4a.example.wobblemenu __ref,anywheresoftware.b4a.BA _ba,Object _callback,String _eventname) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba,_callback,_eventname}));}
RDebugUtils.currentLine=8323072;
 //BA.debugLineNum = 8323072;BA.debugLine="Public Sub Initialize (Callback As Object, EventNa";
RDebugUtils.currentLine=8323073;
 //BA.debugLineNum = 8323073;BA.debugLine="mEventName = EventName";
__ref._meventname /*String*/  = _eventname;
RDebugUtils.currentLine=8323074;
 //BA.debugLineNum = 8323074;BA.debugLine="mCallBack = Callback";
__ref._mcallback /*Object*/  = _callback;
RDebugUtils.currentLine=8323075;
 //BA.debugLineNum = 8323075;BA.debugLine="IconList.Initialize";
__ref._iconlist /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=8323076;
 //BA.debugLineNum = 8323076;BA.debugLine="Tabs.Initialize";
__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=8323077;
 //BA.debugLineNum = 8323077;BA.debugLine="badge.Initialize";
__ref._badge /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=8323078;
 //BA.debugLineNum = 8323078;BA.debugLine="enabled.Initialize2(Array As Boolean(True,True,Tr";
__ref._enabled /*anywheresoftware.b4a.objects.collections.List*/ .Initialize2(anywheresoftware.b4a.keywords.Common.ArrayToList(new boolean[]{__c.True,__c.True,__c.True,__c.True,__c.True}));
RDebugUtils.currentLine=8323079;
 //BA.debugLineNum = 8323079;BA.debugLine="End Sub";
return "";
}
public String  _removebadge(b4a.example.wobblemenu __ref,int _tabid) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "removebadge", false))
	 {return ((String) Debug.delegate(ba, "removebadge", new Object[] {_tabid}));}
anywheresoftware.b4a.objects.B4XViewWrapper _t = null;
RDebugUtils.currentLine=9240576;
 //BA.debugLineNum = 9240576;BA.debugLine="Public Sub RemoveBadge(TabID As Int)";
RDebugUtils.currentLine=9240577;
 //BA.debugLineNum = 9240577;BA.debugLine="If TabID >= 1 And TabID <= TabCount Then";
if (_tabid>=1 && _tabid<=__ref._tabcount /*int*/ ) { 
RDebugUtils.currentLine=9240578;
 //BA.debugLineNum = 9240578;BA.debugLine="badge.set(TabID-1,\"\")";
__ref._badge /*anywheresoftware.b4a.objects.collections.List*/ .Set((int) (_tabid-1),(Object)(""));
RDebugUtils.currentLine=9240579;
 //BA.debugLineNum = 9240579;BA.debugLine="Dim t As B4XView = Tabs.Get(TabID-1)";
_t = new anywheresoftware.b4a.objects.B4XViewWrapper();
_t = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Get((int) (_tabid-1))));
RDebugUtils.currentLine=9240580;
 //BA.debugLineNum = 9240580;BA.debugLine="If t.NumberOfViews = 3 Then";
if (_t.getNumberOfViews()==3) { 
RDebugUtils.currentLine=9240581;
 //BA.debugLineNum = 9240581;BA.debugLine="t.GetView(2).RemoveViewFromParent";
_t.GetView((int) (2)).RemoveViewFromParent();
 };
 }else {
RDebugUtils.currentLine=9240584;
 //BA.debugLineNum = 9240584;BA.debugLine="Log(\"Invalid Tab ID\")";
__c.LogImpl("29240584","Invalid Tab ID",0);
 };
RDebugUtils.currentLine=9240586;
 //BA.debugLineNum = 9240586;BA.debugLine="End Sub";
return "";
}
public String  _setanimationtype(b4a.example.wobblemenu __ref,int _animation_type) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "setanimationtype", false))
	 {return ((String) Debug.delegate(ba, "setanimationtype", new Object[] {_animation_type}));}
RDebugUtils.currentLine=9043968;
 //BA.debugLineNum = 9043968;BA.debugLine="Public Sub SetAnimationType(Animation_Type As Int)";
RDebugUtils.currentLine=9043969;
 //BA.debugLineNum = 9043969;BA.debugLine="AnimationType = Animation_Type";
__ref._animationtype /*int*/  = _animation_type;
RDebugUtils.currentLine=9043970;
 //BA.debugLineNum = 9043970;BA.debugLine="End Sub";
return "";
}
public String  _setcurrenttab(b4a.example.wobblemenu __ref,int _tabid) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "setcurrenttab", false))
	 {return ((String) Debug.delegate(ba, "setcurrenttab", new Object[] {_tabid}));}
RDebugUtils.currentLine=8978432;
 //BA.debugLineNum = 8978432;BA.debugLine="Public Sub SetCurrentTab(TabID As Int)";
RDebugUtils.currentLine=8978433;
 //BA.debugLineNum = 8978433;BA.debugLine="If TabID >= 1 And TabID <= TabCount Then";
if (_tabid>=1 && _tabid<=__ref._tabcount /*int*/ ) { 
RDebugUtils.currentLine=8978434;
 //BA.debugLineNum = 8978434;BA.debugLine="TriggerTabClickEvent(Tabs.Get(TabID-1))";
__ref._triggertabclickevent /*String*/ (null,(anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Get((int) (_tabid-1)))));
 }else {
RDebugUtils.currentLine=8978436;
 //BA.debugLineNum = 8978436;BA.debugLine="Log(\"Invalid Tab ID\")";
__c.LogImpl("28978436","Invalid Tab ID",0);
 };
RDebugUtils.currentLine=8978438;
 //BA.debugLineNum = 8978438;BA.debugLine="End Sub";
return "";
}
public String  _setenabletab(b4a.example.wobblemenu __ref,int _tabid,boolean _enable) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "setenabletab", false))
	 {return ((String) Debug.delegate(ba, "setenabletab", new Object[] {_tabid,_enable}));}
anywheresoftware.b4a.objects.B4XViewWrapper _t = null;
RDebugUtils.currentLine=10682368;
 //BA.debugLineNum = 10682368;BA.debugLine="Public Sub SetEnableTab(TabID As Int, enable As Bo";
RDebugUtils.currentLine=10682369;
 //BA.debugLineNum = 10682369;BA.debugLine="If TabID >= 1 And TabID <= TabCount Then";
if (_tabid>=1 && _tabid<=__ref._tabcount /*int*/ ) { 
RDebugUtils.currentLine=10682370;
 //BA.debugLineNum = 10682370;BA.debugLine="Dim t As B4XView = Tabs.Get(TabID-1)";
_t = new anywheresoftware.b4a.objects.B4XViewWrapper();
_t = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(__ref._tabs /*anywheresoftware.b4a.objects.collections.List*/ .Get((int) (_tabid-1))));
RDebugUtils.currentLine=10682371;
 //BA.debugLineNum = 10682371;BA.debugLine="t.Enabled = enable";
_t.setEnabled(_enable);
RDebugUtils.currentLine=10682372;
 //BA.debugLineNum = 10682372;BA.debugLine="enabled.Set(TabID-1,enable)";
__ref._enabled /*anywheresoftware.b4a.objects.collections.List*/ .Set((int) (_tabid-1),(Object)(_enable));
 }else {
RDebugUtils.currentLine=10682374;
 //BA.debugLineNum = 10682374;BA.debugLine="Log(\"Invalid Tab ID\")";
__c.LogImpl("210682374","Invalid Tab ID",0);
 };
RDebugUtils.currentLine=10682376;
 //BA.debugLineNum = 10682376;BA.debugLine="End Sub";
return "";
}
public String  _seticonappearstyle(b4a.example.wobblemenu __ref,int _icon_appear_style) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "seticonappearstyle", false))
	 {return ((String) Debug.delegate(ba, "seticonappearstyle", new Object[] {_icon_appear_style}));}
RDebugUtils.currentLine=9109504;
 //BA.debugLineNum = 9109504;BA.debugLine="Public Sub SetIconAppearStyle(Icon_Appear_Style As";
RDebugUtils.currentLine=9109505;
 //BA.debugLineNum = 9109505;BA.debugLine="IconAppearStyle = Icon_Appear_Style";
__ref._iconappearstyle /*int*/  = _icon_appear_style;
RDebugUtils.currentLine=9109506;
 //BA.debugLineNum = 9109506;BA.debugLine="End Sub";
return "";
}
public String  _settabcount(b4a.example.wobblemenu __ref,int _count) throws Exception{
__ref = this;
RDebugUtils.currentModule="wobblemenu";
if (Debug.shouldDelegate(ba, "settabcount", false))
	 {return ((String) Debug.delegate(ba, "settabcount", new Object[] {_count}));}
RDebugUtils.currentLine=10616832;
 //BA.debugLineNum = 10616832;BA.debugLine="Public Sub SetTabCount(count As Int)";
RDebugUtils.currentLine=10616833;
 //BA.debugLineNum = 10616833;BA.debugLine="If count = 3 Or count = 5 Then";
if (_count==3 || _count==5) { 
RDebugUtils.currentLine=10616834;
 //BA.debugLineNum = 10616834;BA.debugLine="If CurrentTab > count Then";
if (__ref._currenttab /*int*/ >_count) { 
RDebugUtils.currentLine=10616835;
 //BA.debugLineNum = 10616835;BA.debugLine="Log(\"Current Tab ID: \"&CurrentTab)";
__c.LogImpl("210616835","Current Tab ID: "+BA.NumberToString(__ref._currenttab /*int*/ ),0);
RDebugUtils.currentLine=10616836;
 //BA.debugLineNum = 10616836;BA.debugLine="Log(\"Cannot change tab count.\")";
__c.LogImpl("210616836","Cannot change tab count.",0);
 }else {
RDebugUtils.currentLine=10616838;
 //BA.debugLineNum = 10616838;BA.debugLine="TabCount = count";
__ref._tabcount /*int*/  = _count;
RDebugUtils.currentLine=10616839;
 //BA.debugLineNum = 10616839;BA.debugLine="DrawView";
__ref._drawview /*String*/ (null);
 };
 }else {
RDebugUtils.currentLine=10616842;
 //BA.debugLineNum = 10616842;BA.debugLine="Log(\"Count must be either 5 or 3.\")";
__c.LogImpl("210616842","Count must be either 5 or 3.",0);
 };
RDebugUtils.currentLine=10616844;
 //BA.debugLineNum = 10616844;BA.debugLine="End Sub";
return "";
}
}