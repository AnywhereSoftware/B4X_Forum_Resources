package as.rippleview.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.debug.*;

public class asrippleview extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    private static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new BA(_ba, this, htSubs, "as.rippleview.example.asrippleview");
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            
        }
        if (BA.isShellModeRuntimeCheck(ba)) 
			   this.getClass().getMethod("_class_globals", as.rippleview.example.asrippleview.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 public anywheresoftware.b4a.keywords.Common __c = null;
public String _vvv7 = "";
public Object _vvv0 = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _vvvv1 = null;
public anywheresoftware.b4a.objects.B4XViewWrapper.XUI _vvvv2 = null;
public boolean _vvvv3 = false;
public anywheresoftware.b4a.objects.B4XViewWrapper.B4XBitmapWrapper _ripple_bmp = null;
public int _p_duration = 0;
public int _p_fadeduration = 0;
public int _p_color = 0;
public String  _v5(Object _base,int _duration,int _fade_duration,int _ripple_color) throws Exception{
anywheresoftware.b4a.objects.collections.Map _tmp_map = null;
anywheresoftware.b4a.objects.LabelWrapper _tmp_lbl = null;
 //BA.debugLineNum = 69;BA.debugLine="Public Sub AddView(base As Object,duration As Int,";
 //BA.debugLineNum = 71;BA.debugLine="Dim tmp_map As Map";
_tmp_map = new anywheresoftware.b4a.objects.collections.Map();
 //BA.debugLineNum = 72;BA.debugLine="tmp_map.Initialize";
_tmp_map.Initialize();
 //BA.debugLineNum = 73;BA.debugLine="tmp_map.Put(\"Duration\",duration)";
_tmp_map.Put((Object)("Duration"),(Object)(_duration));
 //BA.debugLineNum = 74;BA.debugLine="tmp_map.Put(\"FadeDuration\",fade_duration)";
_tmp_map.Put((Object)("FadeDuration"),(Object)(_fade_duration));
 //BA.debugLineNum = 75;BA.debugLine="tmp_map.Put(\"RippleColor\",ripple_color)";
_tmp_map.Put((Object)("RippleColor"),(Object)(_ripple_color));
 //BA.debugLineNum = 77;BA.debugLine="Dim tmp_lbl As Label";
_tmp_lbl = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 78;BA.debugLine="tmp_lbl.Initialize(\"\")";
_tmp_lbl.Initialize(ba,"");
 //BA.debugLineNum = 80;BA.debugLine="DesignerCreateView(base,tmp_lbl,tmp_map)";
_designercreateview(_base,_tmp_lbl,_tmp_map);
 //BA.debugLineNum = 82;BA.debugLine="End Sub";
return "";
}
public String  _v6() throws Exception{
 //BA.debugLineNum = 143;BA.debugLine="Public Sub Apply";
 //BA.debugLineNum = 145;BA.debugLine="CreateHaloEffect";
_v7();
 //BA.debugLineNum = 147;BA.debugLine="End Sub";
return "";
}
public String  _base_resize(double _width,double _height) throws Exception{
 //BA.debugLineNum = 60;BA.debugLine="Private Sub Base_Resize (Width As Double, Height A";
 //BA.debugLineNum = 62;BA.debugLine="mBase.SetLayoutAnimated(0,mBase.Left,mBase.Top,Wi";
_vvvv1.SetLayoutAnimated((int) (0),_vvvv1.getLeft(),_vvvv1.getTop(),(int) (_width),(int) (_height));
 //BA.debugLineNum = 64;BA.debugLine="End Sub";
return "";
}
public String  _class_globals() throws Exception{
 //BA.debugLineNum = 11;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 12;BA.debugLine="Private mEventName As String 'ignore";
_vvv7 = "";
 //BA.debugLineNum = 13;BA.debugLine="Private mCallBack As Object 'ignore";
_vvv0 = new Object();
 //BA.debugLineNum = 14;BA.debugLine="Private mBase As B4XView 'ignore";
_vvvv1 = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 15;BA.debugLine="Private xui As XUI 'ignore";
_vvvv2 = new anywheresoftware.b4a.objects.B4XViewWrapper.XUI();
 //BA.debugLineNum = 17;BA.debugLine="Private running As Boolean = False";
_vvvv3 = __c.False;
 //BA.debugLineNum = 18;BA.debugLine="Private ripple_bmp As B4XBitmap";
_ripple_bmp = new anywheresoftware.b4a.objects.B4XViewWrapper.B4XBitmapWrapper();
 //BA.debugLineNum = 21;BA.debugLine="Private p_duration As Int";
_p_duration = 0;
 //BA.debugLineNum = 22;BA.debugLine="Private p_fadeduration As Int";
_p_fadeduration = 0;
 //BA.debugLineNum = 23;BA.debugLine="Private p_color As Int";
_p_color = 0;
 //BA.debugLineNum = 25;BA.debugLine="End Sub";
return "";
}
public String  _v7() throws Exception{
anywheresoftware.b4a.objects.B4XCanvas _cvs = null;
anywheresoftware.b4a.objects.B4XViewWrapper _p = null;
 //BA.debugLineNum = 153;BA.debugLine="Private Sub CreateHaloEffect";
 //BA.debugLineNum = 155;BA.debugLine="Dim cvs As B4XCanvas";
_cvs = new anywheresoftware.b4a.objects.B4XCanvas();
 //BA.debugLineNum = 156;BA.debugLine="Dim p As B4XView = xui.CreatePanel(\"\")";
_p = new anywheresoftware.b4a.objects.B4XViewWrapper();
_p = _vvvv2.CreatePanel(ba,"");
 //BA.debugLineNum = 158;BA.debugLine="p.SetLayoutAnimated(0, 0, 0, mBase.Width/2 * 2,";
_p.SetLayoutAnimated((int) (0),(int) (0),(int) (0),(int) (_vvvv1.getWidth()/(double)2*2),(int) (_vvvv1.getWidth()/(double)2*2));
 //BA.debugLineNum = 159;BA.debugLine="cvs.Initialize(p)";
_cvs.Initialize(_p);
 //BA.debugLineNum = 160;BA.debugLine="cvs.DrawCircle(cvs.TargetRect.CenterX, cvs.Target";
_cvs.DrawCircle(_cvs.getTargetRect().getCenterX(),_cvs.getTargetRect().getCenterY(),(float) (_cvs.getTargetRect().getWidth()/(double)2),_p_color,__c.True,(float) (0));
 //BA.debugLineNum = 161;BA.debugLine="ripple_bmp= cvs.CreateBitmap";
_ripple_bmp = _cvs.CreateBitmap();
 //BA.debugLineNum = 163;BA.debugLine="End Sub";
return "";
}
public void  _v0(anywheresoftware.b4a.objects.B4XViewWrapper _parent,int _x,int _y,int _radius) throws Exception{
ResumableSub_CreateHaloEffectHelper rsub = new ResumableSub_CreateHaloEffectHelper(this,_parent,_x,_y,_radius);
rsub.resume(ba, null);
}
public static class ResumableSub_CreateHaloEffectHelper extends BA.ResumableSub {
public ResumableSub_CreateHaloEffectHelper(as.rippleview.example.asrippleview parent,anywheresoftware.b4a.objects.B4XViewWrapper _parent,int _x,int _y,int _radius) {
this.parent = parent;
this._parent = _parent;
this._x = _x;
this._y = _y;
this._radius = _radius;
}
as.rippleview.example.asrippleview parent;
anywheresoftware.b4a.objects.B4XViewWrapper _parent;
int _x;
int _y;
int _radius;
anywheresoftware.b4a.objects.ImageViewWrapper _iv = null;
anywheresoftware.b4a.objects.B4XViewWrapper _p = null;

@Override
public void resume(BA ba, Object[] result) throws Exception{

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = -1;
 //BA.debugLineNum = 175;BA.debugLine="Dim iv As ImageView";
_iv = new anywheresoftware.b4a.objects.ImageViewWrapper();
 //BA.debugLineNum = 176;BA.debugLine="iv.Initialize(\"\")";
_iv.Initialize(ba,"");
 //BA.debugLineNum = 177;BA.debugLine="Dim p As B4XView = iv";
_p = new anywheresoftware.b4a.objects.B4XViewWrapper();
_p.setObject((java.lang.Object)(_iv.getObject()));
 //BA.debugLineNum = 178;BA.debugLine="p.SetBitmap(ripple_bmp)";
_p.SetBitmap((android.graphics.Bitmap)(parent._ripple_bmp.getObject()));
 //BA.debugLineNum = 179;BA.debugLine="Parent.AddView(p, x, y, 0, 0)";
_parent.AddView((android.view.View)(_p.getObject()),_x,_y,(int) (0),(int) (0));
 //BA.debugLineNum = 180;BA.debugLine="p.SetLayoutAnimated(p_fadeduration, x - radius, y";
_p.SetLayoutAnimated(parent._p_fadeduration,(int) (_x-_radius),(int) (_y-_radius),(int) (2*_radius),(int) (2*_radius));
 //BA.debugLineNum = 181;BA.debugLine="p.SetVisibleAnimated(p_fadeduration, False)";
_p.SetVisibleAnimated(parent._p_fadeduration,parent.__c.False);
 //BA.debugLineNum = 182;BA.debugLine="Sleep(p_fadeduration)";
parent.__c.Sleep(ba,this,parent._p_fadeduration);
this.state = 1;
return;
case 1:
//C
this.state = -1;
;
 //BA.debugLineNum = 183;BA.debugLine="p.RemoveViewFromParent";
_p.RemoveViewFromParent();
 //BA.debugLineNum = 184;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public String  _designercreateview(Object _base,anywheresoftware.b4a.objects.LabelWrapper _lbl,anywheresoftware.b4a.objects.collections.Map _props) throws Exception{
 //BA.debugLineNum = 33;BA.debugLine="Public Sub DesignerCreateView (Base As Object, Lbl";
 //BA.debugLineNum = 34;BA.debugLine="mBase = Base";
_vvvv1.setObject((java.lang.Object)(_base));
 //BA.debugLineNum = 37;BA.debugLine="mBase.SetColorAndBorder(xui.Color_Transparent,0,xu";
_vvvv1.SetColorAndBorder(_vvvv2.Color_Transparent,(int) (0),_vvvv2.Color_Transparent,(int) (_vvvv1.getWidth()/(double)2));
 //BA.debugLineNum = 42;BA.debugLine="ini_props(Props)";
_ini_props(_props);
 //BA.debugLineNum = 44;BA.debugLine="CreateHaloEffect";
_v7();
 //BA.debugLineNum = 47;BA.debugLine="Base_Resize(mBase.Width,mBase.Height)";
_base_resize(_vvvv1.getWidth(),_vvvv1.getHeight());
 //BA.debugLineNum = 50;BA.debugLine="End Sub";
return "";
}
public void  _vv1() throws Exception{
ResumableSub_Effect rsub = new ResumableSub_Effect(this);
rsub.resume(ba, null);
}
public static class ResumableSub_Effect extends BA.ResumableSub {
public ResumableSub_Effect(as.rippleview.example.asrippleview parent) {
this.parent = parent;
}
as.rippleview.example.asrippleview parent;

@Override
public void resume(BA ba, Object[] result) throws Exception{

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
 //BA.debugLineNum = 167;BA.debugLine="Do While running = True";
if (true) break;

case 1:
//do while
this.state = 4;
while (parent._vvvv3==parent.__c.True) {
this.state = 3;
if (true) break;
}
if (true) break;

case 3:
//C
this.state = 1;
 //BA.debugLineNum = 168;BA.debugLine="CreateHaloEffectHelper(mBase, mBase.Width/2, mBa";
parent._v0(parent._vvvv1,(int) (parent._vvvv1.getWidth()/(double)2),(int) (parent._vvvv1.getHeight()/(double)2),(int) (parent._vvvv1.getWidth()/(double)2));
 //BA.debugLineNum = 169;BA.debugLine="Sleep(p_duration)";
parent.__c.Sleep(ba,this,parent._p_duration);
this.state = 5;
return;
case 5:
//C
this.state = 1;
;
 if (true) break;

case 4:
//C
this.state = -1;
;
 //BA.debugLineNum = 172;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public int  _getvvv3() throws Exception{
 //BA.debugLineNum = 90;BA.debugLine="Public Sub getDuration As Int";
 //BA.debugLineNum = 92;BA.debugLine="Return p_duration";
if (true) return _p_duration;
 //BA.debugLineNum = 94;BA.debugLine="End Sub";
return 0;
}
public int  _getvvv4() throws Exception{
 //BA.debugLineNum = 102;BA.debugLine="Public Sub getFadeDuration As Int";
 //BA.debugLineNum = 104;BA.debugLine="Return p_fadeduration";
if (true) return _p_fadeduration;
 //BA.debugLineNum = 106;BA.debugLine="End Sub";
return 0;
}
public boolean  _getvvv5() throws Exception{
 //BA.debugLineNum = 136;BA.debugLine="Public Sub getIsRunning As Boolean";
 //BA.debugLineNum = 138;BA.debugLine="Return running";
if (true) return _vvvv3;
 //BA.debugLineNum = 140;BA.debugLine="End Sub";
return false;
}
public int  _getvvv6() throws Exception{
 //BA.debugLineNum = 114;BA.debugLine="Public Sub getRippleColor As Int";
 //BA.debugLineNum = 116;BA.debugLine="Return p_color";
if (true) return _p_color;
 //BA.debugLineNum = 118;BA.debugLine="End Sub";
return 0;
}
public String  _ini_props(anywheresoftware.b4a.objects.collections.Map _props) throws Exception{
 //BA.debugLineNum = 52;BA.debugLine="Private Sub ini_props(Props As Map)";
 //BA.debugLineNum = 54;BA.debugLine="p_duration = Props.Get(\"Duration\")";
_p_duration = (int)(BA.ObjectToNumber(_props.Get((Object)("Duration"))));
 //BA.debugLineNum = 55;BA.debugLine="p_fadeduration = Props.Get(\"FadeDuration\")";
_p_fadeduration = (int)(BA.ObjectToNumber(_props.Get((Object)("FadeDuration"))));
 //BA.debugLineNum = 56;BA.debugLine="p_color = xui.PaintOrColorToColor(Props.Get(\"Ripp";
_p_color = _vvvv2.PaintOrColorToColor(_props.Get((Object)("RippleColor")));
 //BA.debugLineNum = 58;BA.debugLine="End Sub";
return "";
}
public String  _initialize(anywheresoftware.b4a.BA _ba,Object _callback,String _eventname) throws Exception{
innerInitialize(_ba);
 //BA.debugLineNum = 27;BA.debugLine="Public Sub Initialize (Callback As Object, EventNa";
 //BA.debugLineNum = 28;BA.debugLine="mEventName = EventName";
_vvv7 = _eventname;
 //BA.debugLineNum = 29;BA.debugLine="mCallBack = Callback";
_vvv0 = _callback;
 //BA.debugLineNum = 30;BA.debugLine="End Sub";
return "";
}
public String  _setvvv3(int _duration) throws Exception{
 //BA.debugLineNum = 84;BA.debugLine="Public Sub setDuration(duration As Int)";
 //BA.debugLineNum = 86;BA.debugLine="p_duration = duration";
_p_duration = _duration;
 //BA.debugLineNum = 88;BA.debugLine="End Sub";
return "";
}
public String  _setvvv4(int _duration) throws Exception{
 //BA.debugLineNum = 96;BA.debugLine="Public Sub setFadeDuration(duration As Int)";
 //BA.debugLineNum = 98;BA.debugLine="p_fadeduration = duration";
_p_fadeduration = _duration;
 //BA.debugLineNum = 100;BA.debugLine="End Sub";
return "";
}
public String  _setvvv6(int _color) throws Exception{
 //BA.debugLineNum = 108;BA.debugLine="Public Sub setRippleColor(color As Int)";
 //BA.debugLineNum = 110;BA.debugLine="p_color = color";
_p_color = _color;
 //BA.debugLineNum = 112;BA.debugLine="End Sub";
return "";
}
public String  _vvv1() throws Exception{
 //BA.debugLineNum = 121;BA.debugLine="Public Sub Start";
 //BA.debugLineNum = 123;BA.debugLine="running = True";
_vvvv3 = __c.True;
 //BA.debugLineNum = 124;BA.debugLine="Effect";
_vv1();
 //BA.debugLineNum = 126;BA.debugLine="End Sub";
return "";
}
public String  _vvv2() throws Exception{
 //BA.debugLineNum = 129;BA.debugLine="Public Sub Stop";
 //BA.debugLineNum = 131;BA.debugLine="running = False";
_vvvv3 = __c.False;
 //BA.debugLineNum = 133;BA.debugLine="End Sub";
return "";
}
public Object callSub(String sub, Object sender, Object[] args) throws Exception {
BA.senderHolder.set(sender);
return BA.SubDelegator.SubNotFound;
}
}
