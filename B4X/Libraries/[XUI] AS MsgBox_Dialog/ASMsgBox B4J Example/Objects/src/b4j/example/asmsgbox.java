package b4j.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;
import anywheresoftware.b4a.debug.*;

public class asmsgbox extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.ShellBA("b4j.example", "b4j.example.asmsgbox", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.asmsgbox.class).invoke(this, new Object[] {null});
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
public anywheresoftware.b4j.objects.B4XViewWrapper _mbase = null;
public anywheresoftware.b4j.objects.B4XViewWrapper.XUI _xui = null;
public int _back_color = 0;
public boolean _showx = false;
public int _header_clr = 0;
public int _bottom_crl = 0;
public boolean _iconvisible = false;
public String _icondirection = "";
public int _border_width = 0;
public boolean _showheader = false;
public boolean _showbottom = false;
public int _headerfontsize = 0;
public String _headertext = "";
public anywheresoftware.b4j.objects.B4XViewWrapper _xpnl_close = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _xline_1 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _xline_2 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper.B4XFont _xiconfont = null;
public anywheresoftware.b4j.objects.JFX _fx = null;
public anywheresoftware.b4j.objects.LabelWrapper _lbl_header = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _xlbl_header = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _xpnl_header = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _xpnl_bottom = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _xiv_icon = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _xpnl_content = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _xlbl_action_1 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _xlbl_action_2 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _xlbl_action_3 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _xpnl_actionground = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _xlbl_text = null;
public int _dragable = 0;
public int _donwx = 0;
public int _downy = 0;
public b4j.example.main _main = null;
public String  _initialize(b4j.example.asmsgbox __ref,anywheresoftware.b4a.BA _ba,Object _callback,String _eventname) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "initialize"))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba,_callback,_eventname}));}
RDebugUtils.currentLine=524288;
 //BA.debugLineNum = 524288;BA.debugLine="Public Sub Initialize (Callback As Object, EventNa";
RDebugUtils.currentLine=524289;
 //BA.debugLineNum = 524289;BA.debugLine="mEventName = EventName";
__ref._meventname = _eventname;
RDebugUtils.currentLine=524290;
 //BA.debugLineNum = 524290;BA.debugLine="mCallBack = Callback";
__ref._mcallback = _callback;
RDebugUtils.currentLine=524291;
 //BA.debugLineNum = 524291;BA.debugLine="End Sub";
return "";
}
public String  _initializewithoutdesigner(b4j.example.asmsgbox __ref,anywheresoftware.b4j.objects.B4XViewWrapper _parent,int _backgroundcolor,boolean _show_header,boolean _show_bottom,boolean _show_close_button) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "initializewithoutdesigner"))
	 {return ((String) Debug.delegate(ba, "initializewithoutdesigner", new Object[] {_parent,_backgroundcolor,_show_header,_show_bottom,_show_close_button}));}
anywheresoftware.b4j.objects.B4XViewWrapper _tmp_base = null;
anywheresoftware.b4a.objects.collections.Map _props = null;
anywheresoftware.b4j.objects.LabelWrapper _lbl = null;
RDebugUtils.currentLine=393216;
 //BA.debugLineNum = 393216;BA.debugLine="Public Sub InitializeWithoutDesigner(parent As B4X";
RDebugUtils.currentLine=393219;
 //BA.debugLineNum = 393219;BA.debugLine="Dim tmp_base As B4XView";
_tmp_base = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=393220;
 //BA.debugLineNum = 393220;BA.debugLine="tmp_base = xui.CreatePanel(mEventName)";
_tmp_base = __ref._xui.CreatePanel(ba,__ref._meventname);
RDebugUtils.currentLine=393224;
 //BA.debugLineNum = 393224;BA.debugLine="parent.AddView(tmp_base, 0 + parent.Width/2 - tmp";
_parent.AddView((javafx.scene.Node)(_tmp_base.getObject()),0+_parent.getWidth()/(double)2-_tmp_base.getWidth()/(double)2,0+_parent.getHeight()/(double)2-_tmp_base.getHeight()/(double)2,__c.DipToCurrent((int) (300)),__c.DipToCurrent((int) (300)));
RDebugUtils.currentLine=393226;
 //BA.debugLineNum = 393226;BA.debugLine="Dim props As Map";
_props = new anywheresoftware.b4a.objects.collections.Map();
RDebugUtils.currentLine=393227;
 //BA.debugLineNum = 393227;BA.debugLine="props.Initialize";
_props.Initialize();
RDebugUtils.currentLine=393228;
 //BA.debugLineNum = 393228;BA.debugLine="props.Put(\"Back_Color\",backgroundcolor)";
_props.Put((Object)("Back_Color"),(Object)(_backgroundcolor));
RDebugUtils.currentLine=393229;
 //BA.debugLineNum = 393229;BA.debugLine="props.Put(\"show_header\",show_header)";
_props.Put((Object)("show_header"),(Object)(_show_header));
RDebugUtils.currentLine=393230;
 //BA.debugLineNum = 393230;BA.debugLine="props.Put(\"show_bottom\",show_bottom)";
_props.Put((Object)("show_bottom"),(Object)(_show_bottom));
RDebugUtils.currentLine=393231;
 //BA.debugLineNum = 393231;BA.debugLine="props.Put(\"Show_X\",show_close_button)";
_props.Put((Object)("Show_X"),(Object)(_show_close_button));
RDebugUtils.currentLine=393232;
 //BA.debugLineNum = 393232;BA.debugLine="props.Put(\"Header_CLR\",0xFF2F343A)";
_props.Put((Object)("Header_CLR"),(Object)(0xff2f343a));
RDebugUtils.currentLine=393233;
 //BA.debugLineNum = 393233;BA.debugLine="props.Put(\"Bottom_CLR\",0xFF2F343A)";
_props.Put((Object)("Bottom_CLR"),(Object)(0xff2f343a));
RDebugUtils.currentLine=393235;
 //BA.debugLineNum = 393235;BA.debugLine="If show_header = True Then";
if (_show_header==__c.True) { 
RDebugUtils.currentLine=393236;
 //BA.debugLineNum = 393236;BA.debugLine="props.Put(\"Icon_visible\",True)";
_props.Put((Object)("Icon_visible"),(Object)(__c.True));
RDebugUtils.currentLine=393237;
 //BA.debugLineNum = 393237;BA.debugLine="props.Put(\"Icon_direction\",\"LEFT\")";
_props.Put((Object)("Icon_direction"),(Object)("LEFT"));
 }else {
RDebugUtils.currentLine=393239;
 //BA.debugLineNum = 393239;BA.debugLine="props.Put(\"Icon_visible\",False)";
_props.Put((Object)("Icon_visible"),(Object)(__c.False));
RDebugUtils.currentLine=393240;
 //BA.debugLineNum = 393240;BA.debugLine="props.Put(\"Icon_direction\",\"LEFT\")";
_props.Put((Object)("Icon_direction"),(Object)("LEFT"));
 };
RDebugUtils.currentLine=393243;
 //BA.debugLineNum = 393243;BA.debugLine="props.Put(\"BorderWidth\",0)";
_props.Put((Object)("BorderWidth"),(Object)(0));
RDebugUtils.currentLine=393246;
 //BA.debugLineNum = 393246;BA.debugLine="props.Put(\"header_font_size\",20)";
_props.Put((Object)("header_font_size"),(Object)(20));
RDebugUtils.currentLine=393247;
 //BA.debugLineNum = 393247;BA.debugLine="props.Put(\"Header_Text\",\"Anywhere B4X\")";
_props.Put((Object)("Header_Text"),(Object)("Anywhere B4X"));
RDebugUtils.currentLine=393249;
 //BA.debugLineNum = 393249;BA.debugLine="Dim lbl As Label";
_lbl = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=393250;
 //BA.debugLineNum = 393250;BA.debugLine="lbl.Initialize(\"\")";
_lbl.Initialize(ba,"");
RDebugUtils.currentLine=393252;
 //BA.debugLineNum = 393252;BA.debugLine="DesignerCreateView(tmp_base,lbl,props)";
__ref._designercreateview(null,(Object)(_tmp_base.getObject()),_lbl,_props);
RDebugUtils.currentLine=393254;
 //BA.debugLineNum = 393254;BA.debugLine="mBase.Visible = False";
__ref._mbase.setVisible(__c.False);
RDebugUtils.currentLine=393256;
 //BA.debugLineNum = 393256;BA.debugLine="Base_Resize(mBase.Width,mBase.Height)";
__ref._base_resize(null,__ref._mbase.getWidth(),__ref._mbase.getHeight());
RDebugUtils.currentLine=393259;
 //BA.debugLineNum = 393259;BA.debugLine="End Sub";
return "";
}
public String  _initializebottom(b4j.example.asmsgbox __ref,String _button1,String _button2,String _button3) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "initializebottom"))
	 {return ((String) Debug.delegate(ba, "initializebottom", new Object[] {_button1,_button2,_button3}));}
RDebugUtils.currentLine=458752;
 //BA.debugLineNum = 458752;BA.debugLine="Public Sub InitializeBottom(button1 As String,butt";
RDebugUtils.currentLine=458754;
 //BA.debugLineNum = 458754;BA.debugLine="If button1 = \"\" Then";
if ((_button1).equals("")) { 
RDebugUtils.currentLine=458756;
 //BA.debugLineNum = 458756;BA.debugLine="xlbl_action_1.Text = \"\"";
__ref._xlbl_action_1.setText("");
RDebugUtils.currentLine=458757;
 //BA.debugLineNum = 458757;BA.debugLine="xlbl_action_1.Visible = False";
__ref._xlbl_action_1.setVisible(__c.False);
 }else {
RDebugUtils.currentLine=458760;
 //BA.debugLineNum = 458760;BA.debugLine="xlbl_action_1.Text = button1";
__ref._xlbl_action_1.setText(_button1);
RDebugUtils.currentLine=458762;
 //BA.debugLineNum = 458762;BA.debugLine="xlbl_action_1.Visible = True";
__ref._xlbl_action_1.setVisible(__c.True);
 };
RDebugUtils.currentLine=458765;
 //BA.debugLineNum = 458765;BA.debugLine="If button2 = \"\" Then";
if ((_button2).equals("")) { 
RDebugUtils.currentLine=458766;
 //BA.debugLineNum = 458766;BA.debugLine="xlbl_action_2.Text = \"\"";
__ref._xlbl_action_2.setText("");
RDebugUtils.currentLine=458767;
 //BA.debugLineNum = 458767;BA.debugLine="xlbl_action_2.Visible = False";
__ref._xlbl_action_2.setVisible(__c.False);
 }else {
RDebugUtils.currentLine=458770;
 //BA.debugLineNum = 458770;BA.debugLine="xlbl_action_2.Text = button2";
__ref._xlbl_action_2.setText(_button2);
RDebugUtils.currentLine=458772;
 //BA.debugLineNum = 458772;BA.debugLine="xlbl_action_2.Visible = True";
__ref._xlbl_action_2.setVisible(__c.True);
 };
RDebugUtils.currentLine=458775;
 //BA.debugLineNum = 458775;BA.debugLine="If button3 = \"\" Then";
if ((_button3).equals("")) { 
RDebugUtils.currentLine=458776;
 //BA.debugLineNum = 458776;BA.debugLine="xlbl_action_3.Text = \"\"";
__ref._xlbl_action_3.setText("");
RDebugUtils.currentLine=458777;
 //BA.debugLineNum = 458777;BA.debugLine="xlbl_action_3.Visible = False";
__ref._xlbl_action_3.setVisible(__c.False);
 }else {
RDebugUtils.currentLine=458780;
 //BA.debugLineNum = 458780;BA.debugLine="xlbl_action_3.Text = button3";
__ref._xlbl_action_3.setText(_button3);
RDebugUtils.currentLine=458782;
 //BA.debugLineNum = 458782;BA.debugLine="xlbl_action_3.Visible = True";
__ref._xlbl_action_3.setVisible(__c.True);
 };
RDebugUtils.currentLine=458785;
 //BA.debugLineNum = 458785;BA.debugLine="End Sub";
return "";
}
public String  _setenabledrag(b4j.example.asmsgbox __ref,int _enable) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "setenabledrag"))
	 {return ((String) Debug.delegate(ba, "setenabledrag", new Object[] {_enable}));}
RDebugUtils.currentLine=2031616;
 //BA.debugLineNum = 2031616;BA.debugLine="Public Sub setEnableDrag(enable As Int)";
RDebugUtils.currentLine=2031618;
 //BA.debugLineNum = 2031618;BA.debugLine="dragable = enable";
__ref._dragable = _enable;
RDebugUtils.currentLine=2031620;
 //BA.debugLineNum = 2031620;BA.debugLine="End Sub";
return "";
}
public int  _getdragabletop(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getdragabletop"))
	 {return ((Integer) Debug.delegate(ba, "getdragabletop", null));}
RDebugUtils.currentLine=2162688;
 //BA.debugLineNum = 2162688;BA.debugLine="Public Sub getDragableTop As Int";
RDebugUtils.currentLine=2162690;
 //BA.debugLineNum = 2162690;BA.debugLine="Return 1";
if (true) return (int) (1);
RDebugUtils.currentLine=2162692;
 //BA.debugLineNum = 2162692;BA.debugLine="End Sub";
return 0;
}
public String  _icon_set_icon(b4j.example.asmsgbox __ref,anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _icon) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "icon_set_icon"))
	 {return ((String) Debug.delegate(ba, "icon_set_icon", new Object[] {_icon}));}
RDebugUtils.currentLine=2359296;
 //BA.debugLineNum = 2359296;BA.debugLine="Public Sub icon_set_icon(icon As B4XBitmap)";
RDebugUtils.currentLine=2359298;
 //BA.debugLineNum = 2359298;BA.debugLine="xiv_icon.SetBitmap(CreateRoundBitmap(icon,xiv_ico";
__ref._xiv_icon.SetBitmap((javafx.scene.image.Image)(__ref._createroundbitmap(null,_icon,(int) (__ref._xiv_icon.getWidth())).getObject()));
RDebugUtils.currentLine=2359300;
 //BA.debugLineNum = 2359300;BA.debugLine="End Sub";
return "";
}
public String  _centerdialog(b4j.example.asmsgbox __ref,anywheresoftware.b4j.objects.B4XViewWrapper _parent) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "centerdialog"))
	 {return ((String) Debug.delegate(ba, "centerdialog", new Object[] {_parent}));}
RDebugUtils.currentLine=2752512;
 //BA.debugLineNum = 2752512;BA.debugLine="Public Sub CenterDialog(Parent As B4XView)";
RDebugUtils.currentLine=2752514;
 //BA.debugLineNum = 2752514;BA.debugLine="mBase.Left = Parent.Width/2 - mBase.Width/2";
__ref._mbase.setLeft(_parent.getWidth()/(double)2-__ref._mbase.getWidth()/(double)2);
RDebugUtils.currentLine=2752515;
 //BA.debugLineNum = 2752515;BA.debugLine="mBase.Top = 0 + Parent.Height/2  - mBase.Height/2";
__ref._mbase.setTop(0+_parent.getHeight()/(double)2-__ref._mbase.getHeight()/(double)2);
RDebugUtils.currentLine=2752517;
 //BA.debugLineNum = 2752517;BA.debugLine="End Sub";
return "";
}
public String  _setclosebuttonvisible(b4j.example.asmsgbox __ref,boolean _visible) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "setclosebuttonvisible"))
	 {return ((String) Debug.delegate(ba, "setclosebuttonvisible", new Object[] {_visible}));}
RDebugUtils.currentLine=2424832;
 //BA.debugLineNum = 2424832;BA.debugLine="Public Sub setCloseButtonVisible(visible As Boolea";
RDebugUtils.currentLine=2424834;
 //BA.debugLineNum = 2424834;BA.debugLine="showX = visible";
__ref._showx = _visible;
RDebugUtils.currentLine=2424835;
 //BA.debugLineNum = 2424835;BA.debugLine="Base_Resize(mBase.Width,mBase.Height)";
__ref._base_resize(null,__ref._mbase.getWidth(),__ref._mbase.getHeight());
RDebugUtils.currentLine=2424837;
 //BA.debugLineNum = 2424837;BA.debugLine="End Sub";
return "";
}
public String  _showwithtext(b4j.example.asmsgbox __ref,String _text,boolean _animated) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "showwithtext"))
	 {return ((String) Debug.delegate(ba, "showwithtext", new Object[] {_text,_animated}));}
RDebugUtils.currentLine=720896;
 //BA.debugLineNum = 720896;BA.debugLine="Public Sub ShowWithText(text As String,animated As";
RDebugUtils.currentLine=720898;
 //BA.debugLineNum = 720898;BA.debugLine="xlbl_text.BringToFront";
__ref._xlbl_text.BringToFront();
RDebugUtils.currentLine=720899;
 //BA.debugLineNum = 720899;BA.debugLine="xlbl_text.Visible = True";
__ref._xlbl_text.setVisible(__c.True);
RDebugUtils.currentLine=720900;
 //BA.debugLineNum = 720900;BA.debugLine="If animated = True Then";
if (_animated==__c.True) { 
RDebugUtils.currentLine=720902;
 //BA.debugLineNum = 720902;BA.debugLine="mBase.SetVisibleAnimated(300,True)";
__ref._mbase.SetVisibleAnimated(ba,(int) (300),__c.True);
 }else 
{RDebugUtils.currentLine=720903;
 //BA.debugLineNum = 720903;BA.debugLine="Else If animated = False Then";
if (_animated==__c.False) { 
RDebugUtils.currentLine=720904;
 //BA.debugLineNum = 720904;BA.debugLine="mBase.Visible = True";
__ref._mbase.setVisible(__c.True);
 }}
;
RDebugUtils.currentLine=720907;
 //BA.debugLineNum = 720907;BA.debugLine="xlbl_text.Text = text";
__ref._xlbl_text.setText(_text);
RDebugUtils.currentLine=720909;
 //BA.debugLineNum = 720909;BA.debugLine="End Sub";
return "";
}
public int  _getpositive(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getpositive"))
	 {return ((Integer) Debug.delegate(ba, "getpositive", null));}
RDebugUtils.currentLine=3538944;
 //BA.debugLineNum = 3538944;BA.debugLine="Public Sub getPOSITIVE As Int";
RDebugUtils.currentLine=3538946;
 //BA.debugLineNum = 3538946;BA.debugLine="Return 3";
if (true) return (int) (3);
RDebugUtils.currentLine=3538948;
 //BA.debugLineNum = 3538948;BA.debugLine="End Sub";
return 0;
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _close(b4j.example.asmsgbox __ref,boolean _animated) throws Exception{
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "close"))
	 {return ((anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) Debug.delegate(ba, "close", new Object[] {_animated}));}
ResumableSub_Close rsub = new ResumableSub_Close(this,__ref,_animated);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_Close extends BA.ResumableSub {
public ResumableSub_Close(b4j.example.asmsgbox parent,b4j.example.asmsgbox __ref,boolean _animated) {
this.parent = parent;
this.__ref = __ref;
this._animated = _animated;
this.__ref = parent;
}
b4j.example.asmsgbox __ref;
b4j.example.asmsgbox parent;
boolean _animated;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="asmsgbox";

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.ReturnFromResumableSub(this,null);return;}
case 0:
//C
this.state = 1;
RDebugUtils.currentLine=851970;
 //BA.debugLineNum = 851970;BA.debugLine="If mBase.IsInitialized And mBase.Parent.IsInitial";
if (true) break;

case 1:
//if
this.state = 10;
if (__ref._mbase.IsInitialized() && __ref._mbase.getParent().IsInitialized()) { 
this.state = 3;
}if (true) break;

case 3:
//C
this.state = 4;
RDebugUtils.currentLine=851971;
 //BA.debugLineNum = 851971;BA.debugLine="If animated = True Then";
if (true) break;

case 4:
//if
this.state = 9;
if (_animated==parent.__c.True) { 
this.state = 6;
}else 
{RDebugUtils.currentLine=851973;
 //BA.debugLineNum = 851973;BA.debugLine="Else If animated = False Then";
if (_animated==parent.__c.False) { 
this.state = 8;
}}
if (true) break;

case 6:
//C
this.state = 9;
RDebugUtils.currentLine=851972;
 //BA.debugLineNum = 851972;BA.debugLine="mBase.SetVisibleAnimated(300,False)";
__ref._mbase.SetVisibleAnimated(ba,(int) (300),parent.__c.False);
 if (true) break;

case 8:
//C
this.state = 9;
RDebugUtils.currentLine=851974;
 //BA.debugLineNum = 851974;BA.debugLine="mBase.Visible = False";
__ref._mbase.setVisible(parent.__c.False);
 if (true) break;

case 9:
//C
this.state = 10;
;
RDebugUtils.currentLine=851977;
 //BA.debugLineNum = 851977;BA.debugLine="Return True";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.True));return;};
 if (true) break;

case 10:
//C
this.state = -1;
;
RDebugUtils.currentLine=851979;
 //BA.debugLineNum = 851979;BA.debugLine="Return False";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.False));return;};
RDebugUtils.currentLine=851981;
 //BA.debugLineNum = 851981;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public String  _base_resize(b4j.example.asmsgbox __ref,double _width,double _height) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "base_resize"))
	 {return ((String) Debug.delegate(ba, "base_resize", new Object[] {_width,_height}));}
RDebugUtils.currentLine=917504;
 //BA.debugLineNum = 917504;BA.debugLine="Private Sub Base_Resize (Width As Double, Height A";
RDebugUtils.currentLine=917506;
 //BA.debugLineNum = 917506;BA.debugLine="mBase.SetColorAndBorder(back_color,0dip,xui.Color";
__ref._mbase.SetColorAndBorder(__ref._back_color,__c.DipToCurrent((int) (0)),__ref._xui.Color_Transparent,__c.DipToCurrent((int) (5)));
RDebugUtils.currentLine=917509;
 //BA.debugLineNum = 917509;BA.debugLine="xpnl_header.Visible = showHeader";
__ref._xpnl_header.setVisible(__ref._showheader);
RDebugUtils.currentLine=917510;
 //BA.debugLineNum = 917510;BA.debugLine="xpnl_bottom.Visible = showBottom";
__ref._xpnl_bottom.setVisible(__ref._showbottom);
RDebugUtils.currentLine=917512;
 //BA.debugLineNum = 917512;BA.debugLine="xpnl_close.Visible = showX";
__ref._xpnl_close.setVisible(__ref._showx);
RDebugUtils.currentLine=917514;
 //BA.debugLineNum = 917514;BA.debugLine="If showHeader = True Then";
if (__ref._showheader==__c.True) { 
RDebugUtils.currentLine=917517;
 //BA.debugLineNum = 917517;BA.debugLine="xpnl_header.Width = mBase.Width";
__ref._xpnl_header.setWidth(__ref._mbase.getWidth());
RDebugUtils.currentLine=917518;
 //BA.debugLineNum = 917518;BA.debugLine="xline_1.Width = mBase.Width";
__ref._xline_1.setWidth(__ref._mbase.getWidth());
RDebugUtils.currentLine=917520;
 //BA.debugLineNum = 917520;BA.debugLine="xpnl_header.Color = header_clr";
__ref._xpnl_header.setColor(__ref._header_clr);
RDebugUtils.currentLine=917521;
 //BA.debugLineNum = 917521;BA.debugLine="xlbl_header.Height = MeasureTextHeight(xlbl_head";
__ref._xlbl_header.setHeight(__ref._measuretextheight(null,__ref._xlbl_header.getText(),__ref._xlbl_header.getFont())+__c.DipToCurrent((int) (8)));
RDebugUtils.currentLine=917524;
 //BA.debugLineNum = 917524;BA.debugLine="xpnl_content.Top = xpnl_header.Height";
__ref._xpnl_content.setTop(__ref._xpnl_header.getHeight());
RDebugUtils.currentLine=917527;
 //BA.debugLineNum = 917527;BA.debugLine="If iconVisible = True Then";
if (__ref._iconvisible==__c.True) { 
RDebugUtils.currentLine=917529;
 //BA.debugLineNum = 917529;BA.debugLine="If iconDirection = \"LEFT\" Then";
if ((__ref._icondirection).equals("LEFT")) { 
RDebugUtils.currentLine=917531;
 //BA.debugLineNum = 917531;BA.debugLine="xiv_icon.Width = 40dip";
__ref._xiv_icon.setWidth(__c.DipToCurrent((int) (40)));
RDebugUtils.currentLine=917532;
 //BA.debugLineNum = 917532;BA.debugLine="xiv_icon.Height = 40dip";
__ref._xiv_icon.setHeight(__c.DipToCurrent((int) (40)));
RDebugUtils.currentLine=917534;
 //BA.debugLineNum = 917534;BA.debugLine="xlbl_header.Top = xpnl_header.Top + xpnl_header";
__ref._xlbl_header.setTop(__ref._xpnl_header.getTop()+__ref._xpnl_header.getHeight()/(double)2-__ref._xlbl_header.getHeight()/(double)2);
RDebugUtils.currentLine=917535;
 //BA.debugLineNum = 917535;BA.debugLine="xlbl_header.Width =	MeasureTextWidth(xlbl_heade";
__ref._xlbl_header.setWidth(__ref._measuretextwidth(null,__ref._xlbl_header.getText(),__ref._xlbl_header.getFont())+__c.DipToCurrent((int) (1)));
RDebugUtils.currentLine=917536;
 //BA.debugLineNum = 917536;BA.debugLine="xlbl_header.Left = xpnl_header.Width/2 - xlbl_h";
__ref._xlbl_header.setLeft(__ref._xpnl_header.getWidth()/(double)2-__ref._xlbl_header.getWidth()/(double)2);
RDebugUtils.currentLine=917537;
 //BA.debugLineNum = 917537;BA.debugLine="xiv_icon.Left = xlbl_header.Left - xiv_icon.Wid";
__ref._xiv_icon.setLeft(__ref._xlbl_header.getLeft()-__ref._xiv_icon.getWidth()-__c.DipToCurrent((int) (5)));
RDebugUtils.currentLine=917538;
 //BA.debugLineNum = 917538;BA.debugLine="xiv_icon.Top = xpnl_header.Top + xpnl_header.H";
__ref._xiv_icon.setTop(__ref._xpnl_header.getTop()+__ref._xpnl_header.getHeight()/(double)2-__ref._xiv_icon.getHeight()/(double)2);
 }else 
{RDebugUtils.currentLine=917540;
 //BA.debugLineNum = 917540;BA.debugLine="Else If iconDirection = \"MIDDLE\" Then";
if ((__ref._icondirection).equals("MIDDLE")) { 
RDebugUtils.currentLine=917542;
 //BA.debugLineNum = 917542;BA.debugLine="xiv_icon.Width = 30dip";
__ref._xiv_icon.setWidth(__c.DipToCurrent((int) (30)));
RDebugUtils.currentLine=917543;
 //BA.debugLineNum = 917543;BA.debugLine="xiv_icon.Height = 30dip";
__ref._xiv_icon.setHeight(__c.DipToCurrent((int) (30)));
RDebugUtils.currentLine=917545;
 //BA.debugLineNum = 917545;BA.debugLine="xiv_icon.Top = 4dip";
__ref._xiv_icon.setTop(__c.DipToCurrent((int) (4)));
RDebugUtils.currentLine=917546;
 //BA.debugLineNum = 917546;BA.debugLine="xiv_icon.Left = xpnl_header.Width/2 - xiv_icon.";
__ref._xiv_icon.setLeft(__ref._xpnl_header.getWidth()/(double)2-__ref._xiv_icon.getWidth()/(double)2);
RDebugUtils.currentLine=917548;
 //BA.debugLineNum = 917548;BA.debugLine="xlbl_header.Top = xiv_icon.Top + xiv_icon.Heig";
__ref._xlbl_header.setTop(__ref._xiv_icon.getTop()+__ref._xiv_icon.getHeight()-__c.DipToCurrent((int) (4)));
RDebugUtils.currentLine=917549;
 //BA.debugLineNum = 917549;BA.debugLine="xlbl_header.Width =	MeasureTextWidth(xlbl_heade";
__ref._xlbl_header.setWidth(__ref._measuretextwidth(null,__ref._xlbl_header.getText(),__ref._xlbl_header.getFont())+__c.DipToCurrent((int) (1)));
RDebugUtils.currentLine=917550;
 //BA.debugLineNum = 917550;BA.debugLine="xlbl_header.Left = xpnl_header.Width/2 - xlbl_h";
__ref._xlbl_header.setLeft(__ref._xpnl_header.getWidth()/(double)2-__ref._xlbl_header.getWidth()/(double)2);
 }else 
{RDebugUtils.currentLine=917553;
 //BA.debugLineNum = 917553;BA.debugLine="Else If iconDirection = \"RIGHT\" Then";
if ((__ref._icondirection).equals("RIGHT")) { 
RDebugUtils.currentLine=917555;
 //BA.debugLineNum = 917555;BA.debugLine="xlbl_header.Top = xpnl_header.Top + xpnl_header";
__ref._xlbl_header.setTop(__ref._xpnl_header.getTop()+__ref._xpnl_header.getHeight()/(double)2-__ref._xlbl_header.getHeight()/(double)2);
RDebugUtils.currentLine=917556;
 //BA.debugLineNum = 917556;BA.debugLine="xlbl_header.Width =	MeasureTextWidth(xlbl_heade";
__ref._xlbl_header.setWidth(__ref._measuretextwidth(null,__ref._xlbl_header.getText(),__ref._xlbl_header.getFont())+__c.DipToCurrent((int) (1)));
RDebugUtils.currentLine=917557;
 //BA.debugLineNum = 917557;BA.debugLine="xlbl_header.Left = xpnl_header.Width/2 - xlbl_h";
__ref._xlbl_header.setLeft(__ref._xpnl_header.getWidth()/(double)2-__ref._xlbl_header.getWidth()/(double)2);
RDebugUtils.currentLine=917558;
 //BA.debugLineNum = 917558;BA.debugLine="xiv_icon.Left = xlbl_header.Left + xlbl_header.";
__ref._xiv_icon.setLeft(__ref._xlbl_header.getLeft()+__ref._xlbl_header.getWidth()+__c.DipToCurrent((int) (5)));
RDebugUtils.currentLine=917559;
 //BA.debugLineNum = 917559;BA.debugLine="xiv_icon.Top = xpnl_header.Top + xpnl_header.H";
__ref._xiv_icon.setTop(__ref._xpnl_header.getTop()+__ref._xpnl_header.getHeight()/(double)2-__ref._xiv_icon.getHeight()/(double)2);
 }}}
;
 }else {
RDebugUtils.currentLine=917565;
 //BA.debugLineNum = 917565;BA.debugLine="xiv_icon.Width = 40dip";
__ref._xiv_icon.setWidth(__c.DipToCurrent((int) (40)));
RDebugUtils.currentLine=917566;
 //BA.debugLineNum = 917566;BA.debugLine="xiv_icon.Height = 40dip";
__ref._xiv_icon.setHeight(__c.DipToCurrent((int) (40)));
RDebugUtils.currentLine=917568;
 //BA.debugLineNum = 917568;BA.debugLine="xlbl_header.Top = xpnl_header.Top + xpnl_header.";
__ref._xlbl_header.setTop(__ref._xpnl_header.getTop()+__ref._xpnl_header.getHeight()/(double)2-__ref._xlbl_header.getHeight()/(double)2);
RDebugUtils.currentLine=917569;
 //BA.debugLineNum = 917569;BA.debugLine="xlbl_header.Left = xpnl_header.Left + 5dip";
__ref._xlbl_header.setLeft(__ref._xpnl_header.getLeft()+__c.DipToCurrent((int) (5)));
RDebugUtils.currentLine=917570;
 //BA.debugLineNum = 917570;BA.debugLine="xlbl_header.Width = xpnl_header.Width - 5dip";
__ref._xlbl_header.setWidth(__ref._xpnl_header.getWidth()-__c.DipToCurrent((int) (5)));
 };
 }else {
RDebugUtils.currentLine=917576;
 //BA.debugLineNum = 917576;BA.debugLine="xpnl_content.Top = 0";
__ref._xpnl_content.setTop(0);
 };
RDebugUtils.currentLine=917580;
 //BA.debugLineNum = 917580;BA.debugLine="If showBottom = True Then";
if (__ref._showbottom==__c.True) { 
RDebugUtils.currentLine=917582;
 //BA.debugLineNum = 917582;BA.debugLine="xpnl_bottom.Color = bottom_crl";
__ref._xpnl_bottom.setColor(__ref._bottom_crl);
RDebugUtils.currentLine=917584;
 //BA.debugLineNum = 917584;BA.debugLine="xpnl_bottom.Top = mBase.Height - 50dip";
__ref._xpnl_bottom.setTop(__ref._mbase.getHeight()-__c.DipToCurrent((int) (50)));
RDebugUtils.currentLine=917585;
 //BA.debugLineNum = 917585;BA.debugLine="xpnl_bottom.Width = mBase.Width";
__ref._xpnl_bottom.setWidth(__ref._mbase.getWidth());
RDebugUtils.currentLine=917586;
 //BA.debugLineNum = 917586;BA.debugLine="xline_2.Width = mBase.Width";
__ref._xline_2.setWidth(__ref._mbase.getWidth());
RDebugUtils.currentLine=917590;
 //BA.debugLineNum = 917590;BA.debugLine="xpnl_actionground.Width = xpnl_bottom.Width - 10";
__ref._xpnl_actionground.setWidth(__ref._xpnl_bottom.getWidth()-__c.DipToCurrent((int) (10)));
RDebugUtils.currentLine=917593;
 //BA.debugLineNum = 917593;BA.debugLine="xpnl_content.Height = mBase.Height - xpnl_conten";
__ref._xpnl_content.setHeight(__ref._mbase.getHeight()-__ref._xpnl_content.getTop()-__ref._xpnl_bottom.getHeight());
 }else {
RDebugUtils.currentLine=917598;
 //BA.debugLineNum = 917598;BA.debugLine="xpnl_content.Height = mBase.Height - xpnl_conten";
__ref._xpnl_content.setHeight(__ref._mbase.getHeight()-__ref._xpnl_content.getTop());
 };
RDebugUtils.currentLine=917602;
 //BA.debugLineNum = 917602;BA.debugLine="xlbl_action_1.Left = 0";
__ref._xlbl_action_1.setLeft(0);
RDebugUtils.currentLine=917603;
 //BA.debugLineNum = 917603;BA.debugLine="xlbl_action_1.Width = xpnl_actionground.Width/3 -";
__ref._xlbl_action_1.setWidth(__ref._xpnl_actionground.getWidth()/(double)3-__c.DipToCurrent((int) (5)));
RDebugUtils.currentLine=917605;
 //BA.debugLineNum = 917605;BA.debugLine="xlbl_action_2.Left = xlbl_action_1.Left + xlbl_ac";
__ref._xlbl_action_2.setLeft(__ref._xlbl_action_1.getLeft()+__ref._xlbl_action_1.getWidth()+__c.DipToCurrent((int) (5)));
RDebugUtils.currentLine=917606;
 //BA.debugLineNum = 917606;BA.debugLine="xlbl_action_2.Width = xpnl_actionground.Width/3 '";
__ref._xlbl_action_2.setWidth(__ref._xpnl_actionground.getWidth()/(double)3);
RDebugUtils.currentLine=917608;
 //BA.debugLineNum = 917608;BA.debugLine="xlbl_action_3.Left = xlbl_action_2.Left + xlbl_ac";
__ref._xlbl_action_3.setLeft(__ref._xlbl_action_2.getLeft()+__ref._xlbl_action_2.getWidth()+__c.DipToCurrent((int) (5)));
RDebugUtils.currentLine=917609;
 //BA.debugLineNum = 917609;BA.debugLine="xlbl_action_3.Width = xpnl_actionground.Width/3 -";
__ref._xlbl_action_3.setWidth(__ref._xpnl_actionground.getWidth()/(double)3-__c.DipToCurrent((int) (5)));
RDebugUtils.currentLine=917611;
 //BA.debugLineNum = 917611;BA.debugLine="End Sub";
return "";
}
public int  _measuretextheight(b4j.example.asmsgbox __ref,String _text,anywheresoftware.b4j.objects.B4XViewWrapper.B4XFont _font1) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "measuretextheight"))
	 {return ((Integer) Debug.delegate(ba, "measuretextheight", new Object[] {_text,_font1}));}
anywheresoftware.b4j.object.JavaObject _jo = null;
anywheresoftware.b4j.object.JavaObject _bounds = null;
RDebugUtils.currentLine=4063232;
 //BA.debugLineNum = 4063232;BA.debugLine="Private Sub MeasureTextHeight(Text As String, Font";
RDebugUtils.currentLine=4063242;
 //BA.debugLineNum = 4063242;BA.debugLine="Dim jo As JavaObject";
_jo = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=4063243;
 //BA.debugLineNum = 4063243;BA.debugLine="jo.InitializeNewInstance(\"javafx.scene.text.Text\"";
_jo.InitializeNewInstance("javafx.scene.text.Text",new Object[]{(Object)(_text)});
RDebugUtils.currentLine=4063244;
 //BA.debugLineNum = 4063244;BA.debugLine="jo.RunMethod(\"setFont\",Array(Font1.ToNativeFont))";
_jo.RunMethod("setFont",new Object[]{(Object)(_font1.ToNativeFont().getObject())});
RDebugUtils.currentLine=4063245;
 //BA.debugLineNum = 4063245;BA.debugLine="jo.RunMethod(\"setLineSpacing\",Array(0.0))";
_jo.RunMethod("setLineSpacing",new Object[]{(Object)(0.0)});
RDebugUtils.currentLine=4063246;
 //BA.debugLineNum = 4063246;BA.debugLine="jo.RunMethod(\"setWrappingWidth\",Array(0.0))";
_jo.RunMethod("setWrappingWidth",new Object[]{(Object)(0.0)});
RDebugUtils.currentLine=4063247;
 //BA.debugLineNum = 4063247;BA.debugLine="Dim Bounds As JavaObject = jo.RunMethod(\"getLayou";
_bounds = new anywheresoftware.b4j.object.JavaObject();
_bounds.setObject((java.lang.Object)(_jo.RunMethod("getLayoutBounds",(Object[])(__c.Null))));
RDebugUtils.currentLine=4063248;
 //BA.debugLineNum = 4063248;BA.debugLine="Return Bounds.RunMethod(\"getHeight\",Null)";
if (true) return (int)(BA.ObjectToNumber(_bounds.RunMethod("getHeight",(Object[])(__c.Null))));
RDebugUtils.currentLine=4063250;
 //BA.debugLineNum = 4063250;BA.debugLine="End Sub";
return 0;
}
public int  _measuretextwidth(b4j.example.asmsgbox __ref,String _text,anywheresoftware.b4j.objects.B4XViewWrapper.B4XFont _font1) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "measuretextwidth"))
	 {return ((Integer) Debug.delegate(ba, "measuretextwidth", new Object[] {_text,_font1}));}
anywheresoftware.b4j.object.JavaObject _jo = null;
anywheresoftware.b4j.object.JavaObject _bounds = null;
RDebugUtils.currentLine=4128768;
 //BA.debugLineNum = 4128768;BA.debugLine="Private Sub MeasureTextWidth(Text As String, Font1";
RDebugUtils.currentLine=4128778;
 //BA.debugLineNum = 4128778;BA.debugLine="Dim jo As JavaObject";
_jo = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=4128779;
 //BA.debugLineNum = 4128779;BA.debugLine="jo.InitializeNewInstance(\"javafx.scene.text.Text\"";
_jo.InitializeNewInstance("javafx.scene.text.Text",new Object[]{(Object)(_text)});
RDebugUtils.currentLine=4128780;
 //BA.debugLineNum = 4128780;BA.debugLine="jo.RunMethod(\"setFont\",Array(Font1.ToNativeFont))";
_jo.RunMethod("setFont",new Object[]{(Object)(_font1.ToNativeFont().getObject())});
RDebugUtils.currentLine=4128781;
 //BA.debugLineNum = 4128781;BA.debugLine="jo.RunMethod(\"setLineSpacing\",Array(0.0))";
_jo.RunMethod("setLineSpacing",new Object[]{(Object)(0.0)});
RDebugUtils.currentLine=4128782;
 //BA.debugLineNum = 4128782;BA.debugLine="jo.RunMethod(\"setWrappingWidth\",Array(0.0))";
_jo.RunMethod("setWrappingWidth",new Object[]{(Object)(0.0)});
RDebugUtils.currentLine=4128783;
 //BA.debugLineNum = 4128783;BA.debugLine="Dim Bounds As JavaObject = jo.RunMethod(\"getLayou";
_bounds = new anywheresoftware.b4j.object.JavaObject();
_bounds.setObject((java.lang.Object)(_jo.RunMethod("getLayoutBounds",(Object[])(__c.Null))));
RDebugUtils.currentLine=4128784;
 //BA.debugLineNum = 4128784;BA.debugLine="Return Bounds.RunMethod(\"getWidth\",Null)";
if (true) return (int)(BA.ObjectToNumber(_bounds.RunMethod("getWidth",(Object[])(__c.Null))));
RDebugUtils.currentLine=4128786;
 //BA.debugLineNum = 4128786;BA.debugLine="End Sub";
return 0;
}
public String  _class_globals(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
RDebugUtils.currentLine=327680;
 //BA.debugLineNum = 327680;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=327681;
 //BA.debugLineNum = 327681;BA.debugLine="Private mEventName As String 'ignore";
_meventname = "";
RDebugUtils.currentLine=327682;
 //BA.debugLineNum = 327682;BA.debugLine="Private mCallBack As Object 'ignore";
_mcallback = new Object();
RDebugUtils.currentLine=327683;
 //BA.debugLineNum = 327683;BA.debugLine="Private mBase As B4XView 'ignore";
_mbase = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=327684;
 //BA.debugLineNum = 327684;BA.debugLine="Private xui As XUI 'ignore";
_xui = new anywheresoftware.b4j.objects.B4XViewWrapper.XUI();
RDebugUtils.currentLine=327688;
 //BA.debugLineNum = 327688;BA.debugLine="Private back_color As Int";
_back_color = 0;
RDebugUtils.currentLine=327689;
 //BA.debugLineNum = 327689;BA.debugLine="Private showX As Boolean";
_showx = false;
RDebugUtils.currentLine=327690;
 //BA.debugLineNum = 327690;BA.debugLine="Private header_clr As Int";
_header_clr = 0;
RDebugUtils.currentLine=327691;
 //BA.debugLineNum = 327691;BA.debugLine="Private bottom_crl As Int";
_bottom_crl = 0;
RDebugUtils.currentLine=327693;
 //BA.debugLineNum = 327693;BA.debugLine="Private iconVisible As Boolean";
_iconvisible = false;
RDebugUtils.currentLine=327694;
 //BA.debugLineNum = 327694;BA.debugLine="Private iconDirection As String";
_icondirection = "";
RDebugUtils.currentLine=327695;
 //BA.debugLineNum = 327695;BA.debugLine="Private border_width As Int";
_border_width = 0;
RDebugUtils.currentLine=327697;
 //BA.debugLineNum = 327697;BA.debugLine="Private showHeader As Boolean";
_showheader = false;
RDebugUtils.currentLine=327698;
 //BA.debugLineNum = 327698;BA.debugLine="Private showBottom As Boolean";
_showbottom = false;
RDebugUtils.currentLine=327700;
 //BA.debugLineNum = 327700;BA.debugLine="Private headerFontSize As Int";
_headerfontsize = 0;
RDebugUtils.currentLine=327701;
 //BA.debugLineNum = 327701;BA.debugLine="Private headerText As String";
_headertext = "";
RDebugUtils.currentLine=327703;
 //BA.debugLineNum = 327703;BA.debugLine="Private xpnl_close As B4XView";
_xpnl_close = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=327705;
 //BA.debugLineNum = 327705;BA.debugLine="Private xline_1,xline_2 As B4XView";
_xline_1 = new anywheresoftware.b4j.objects.B4XViewWrapper();
_xline_2 = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=327707;
 //BA.debugLineNum = 327707;BA.debugLine="Private xIconFont As B4XFont";
_xiconfont = new anywheresoftware.b4j.objects.B4XViewWrapper.B4XFont();
RDebugUtils.currentLine=327709;
 //BA.debugLineNum = 327709;BA.debugLine="Private fx As JFX";
_fx = new anywheresoftware.b4j.objects.JFX();
RDebugUtils.currentLine=327713;
 //BA.debugLineNum = 327713;BA.debugLine="Private lbl_header As Label";
_lbl_header = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=327714;
 //BA.debugLineNum = 327714;BA.debugLine="Private xlbl_header As B4XView";
_xlbl_header = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=327715;
 //BA.debugLineNum = 327715;BA.debugLine="Private xpnl_header As B4XView";
_xpnl_header = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=327716;
 //BA.debugLineNum = 327716;BA.debugLine="Private xpnl_bottom As B4XView";
_xpnl_bottom = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=327717;
 //BA.debugLineNum = 327717;BA.debugLine="Private xiv_icon As B4XView";
_xiv_icon = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=327718;
 //BA.debugLineNum = 327718;BA.debugLine="Private xpnl_content As B4XView";
_xpnl_content = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=327719;
 //BA.debugLineNum = 327719;BA.debugLine="Private xlbl_action_1,xlbl_action_2,xlbl_action_3";
_xlbl_action_1 = new anywheresoftware.b4j.objects.B4XViewWrapper();
_xlbl_action_2 = new anywheresoftware.b4j.objects.B4XViewWrapper();
_xlbl_action_3 = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=327720;
 //BA.debugLineNum = 327720;BA.debugLine="Private xpnl_actionground As B4XView";
_xpnl_actionground = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=327721;
 //BA.debugLineNum = 327721;BA.debugLine="Private xlbl_text As B4XView";
_xlbl_text = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=327724;
 //BA.debugLineNum = 327724;BA.debugLine="Private dragable As Int = 0";
_dragable = (int) (0);
RDebugUtils.currentLine=327725;
 //BA.debugLineNum = 327725;BA.debugLine="Private donwx As Int";
_donwx = 0;
RDebugUtils.currentLine=327726;
 //BA.debugLineNum = 327726;BA.debugLine="Private downy As Int";
_downy = 0;
RDebugUtils.currentLine=327732;
 //BA.debugLineNum = 327732;BA.debugLine="End Sub";
return "";
}
public String  _closebutton_handler(b4j.example.asmsgbox __ref,anywheresoftware.b4j.objects.B4XViewWrapper _senderpanel) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "closebutton_handler"))
	 {return ((String) Debug.delegate(ba, "closebutton_handler", new Object[] {_senderpanel}));}
RDebugUtils.currentLine=3473408;
 //BA.debugLineNum = 3473408;BA.debugLine="Private Sub closebutton_handler(SenderPanel As B4X";
RDebugUtils.currentLine=3473410;
 //BA.debugLineNum = 3473410;BA.debugLine="mBase.Visible = False";
__ref._mbase.setVisible(__c.False);
RDebugUtils.currentLine=3473412;
 //BA.debugLineNum = 3473412;BA.debugLine="End Sub";
return "";
}
public String  _create_bottom(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "create_bottom"))
	 {return ((String) Debug.delegate(ba, "create_bottom", null));}
anywheresoftware.b4j.objects.LabelWrapper _lbl_action_1 = null;
anywheresoftware.b4j.objects.LabelWrapper _lbl_action_2 = null;
anywheresoftware.b4j.objects.LabelWrapper _lbl_action_3 = null;
RDebugUtils.currentLine=1048576;
 //BA.debugLineNum = 1048576;BA.debugLine="Private Sub create_bottom";
RDebugUtils.currentLine=1048579;
 //BA.debugLineNum = 1048579;BA.debugLine="xpnl_bottom = xui.CreatePanel(\"\")";
__ref._xpnl_bottom = __ref._xui.CreatePanel(ba,"");
RDebugUtils.currentLine=1048580;
 //BA.debugLineNum = 1048580;BA.debugLine="mBase.AddView(xpnl_bottom,0,mBase.Height - 50dip,";
__ref._mbase.AddView((javafx.scene.Node)(__ref._xpnl_bottom.getObject()),0,__ref._mbase.getHeight()-__c.DipToCurrent((int) (50)),__ref._mbase.getWidth(),__c.DipToCurrent((int) (50)));
RDebugUtils.currentLine=1048581;
 //BA.debugLineNum = 1048581;BA.debugLine="xpnl_bottom.Color = xui.Color_Red";
__ref._xpnl_bottom.setColor(__ref._xui.Color_Red);
RDebugUtils.currentLine=1048582;
 //BA.debugLineNum = 1048582;BA.debugLine="xpnl_bottom.SetColorAndBorder(xui.Color_Red,0,xui";
__ref._xpnl_bottom.SetColorAndBorder(__ref._xui.Color_Red,0,__ref._xui.Color_Transparent,__c.DipToCurrent((int) (5)));
RDebugUtils.currentLine=1048585;
 //BA.debugLineNum = 1048585;BA.debugLine="xline_2 = xui.CreatePanel(\"\")";
__ref._xline_2 = __ref._xui.CreatePanel(ba,"");
RDebugUtils.currentLine=1048586;
 //BA.debugLineNum = 1048586;BA.debugLine="xpnl_bottom.AddView(xline_2,0dip,0dip,xpnl_bottom";
__ref._xpnl_bottom.AddView((javafx.scene.Node)(__ref._xline_2.getObject()),__c.DipToCurrent((int) (0)),__c.DipToCurrent((int) (0)),__ref._xpnl_bottom.getWidth(),__c.DipToCurrent((int) (2)));
RDebugUtils.currentLine=1048587;
 //BA.debugLineNum = 1048587;BA.debugLine="xline_2.Color = xui.Color_White";
__ref._xline_2.setColor(__ref._xui.Color_White);
RDebugUtils.currentLine=1048588;
 //BA.debugLineNum = 1048588;BA.debugLine="MakeViewBackgroundTransparent(xline_2,100)";
__ref._makeviewbackgroundtransparent(null,__ref._xline_2,(int) (100));
RDebugUtils.currentLine=1048592;
 //BA.debugLineNum = 1048592;BA.debugLine="xpnl_actionground = xui.CreatePanel(\"\")";
__ref._xpnl_actionground = __ref._xui.CreatePanel(ba,"");
RDebugUtils.currentLine=1048593;
 //BA.debugLineNum = 1048593;BA.debugLine="xpnl_bottom.AddView(xpnl_actionground,5dip,5dip,x";
__ref._xpnl_bottom.AddView((javafx.scene.Node)(__ref._xpnl_actionground.getObject()),__c.DipToCurrent((int) (5)),__c.DipToCurrent((int) (5)),__ref._xpnl_bottom.getWidth()-__c.DipToCurrent((int) (5)),__ref._xpnl_bottom.getHeight()-__c.DipToCurrent((int) (10)));
RDebugUtils.currentLine=1048597;
 //BA.debugLineNum = 1048597;BA.debugLine="Dim lbl_action_1,lbl_action_2,lbl_action_3 As Lab";
_lbl_action_1 = new anywheresoftware.b4j.objects.LabelWrapper();
_lbl_action_2 = new anywheresoftware.b4j.objects.LabelWrapper();
_lbl_action_3 = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=1048598;
 //BA.debugLineNum = 1048598;BA.debugLine="lbl_action_1.Initialize(\"xlbl_action_1\")";
_lbl_action_1.Initialize(ba,"xlbl_action_1");
RDebugUtils.currentLine=1048599;
 //BA.debugLineNum = 1048599;BA.debugLine="lbl_action_2.Initialize(\"xlbl_action_2\")";
_lbl_action_2.Initialize(ba,"xlbl_action_2");
RDebugUtils.currentLine=1048600;
 //BA.debugLineNum = 1048600;BA.debugLine="lbl_action_3.Initialize(\"xlbl_action_3\")";
_lbl_action_3.Initialize(ba,"xlbl_action_3");
RDebugUtils.currentLine=1048602;
 //BA.debugLineNum = 1048602;BA.debugLine="xlbl_action_1 = lbl_action_1";
__ref._xlbl_action_1.setObject((java.lang.Object)(_lbl_action_1.getObject()));
RDebugUtils.currentLine=1048603;
 //BA.debugLineNum = 1048603;BA.debugLine="xlbl_action_2 = lbl_action_2";
__ref._xlbl_action_2.setObject((java.lang.Object)(_lbl_action_2.getObject()));
RDebugUtils.currentLine=1048604;
 //BA.debugLineNum = 1048604;BA.debugLine="xlbl_action_3 = lbl_action_3";
__ref._xlbl_action_3.setObject((java.lang.Object)(_lbl_action_3.getObject()));
RDebugUtils.currentLine=1048606;
 //BA.debugLineNum = 1048606;BA.debugLine="xlbl_action_1.Tag = getCANCEL";
__ref._xlbl_action_1.setTag((Object)(__ref._getcancel(null)));
RDebugUtils.currentLine=1048607;
 //BA.debugLineNum = 1048607;BA.debugLine="xlbl_action_2.Tag = getNEGATIVE";
__ref._xlbl_action_2.setTag((Object)(__ref._getnegative(null)));
RDebugUtils.currentLine=1048608;
 //BA.debugLineNum = 1048608;BA.debugLine="xlbl_action_3.Tag = getPOSITIVE";
__ref._xlbl_action_3.setTag((Object)(__ref._getpositive(null)));
RDebugUtils.currentLine=1048610;
 //BA.debugLineNum = 1048610;BA.debugLine="xpnl_actionground.AddView(xlbl_action_1,0,0,0 ,xp";
__ref._xpnl_actionground.AddView((javafx.scene.Node)(__ref._xlbl_action_1.getObject()),0,0,0,__ref._xpnl_actionground.getHeight());
RDebugUtils.currentLine=1048611;
 //BA.debugLineNum = 1048611;BA.debugLine="xpnl_actionground.AddView(xlbl_action_2,xlbl_acti";
__ref._xpnl_actionground.AddView((javafx.scene.Node)(__ref._xlbl_action_2.getObject()),__ref._xlbl_action_1.getLeft()+__ref._xlbl_action_1.getWidth()+__c.DipToCurrent((int) (5)),0,0,__ref._xpnl_actionground.getHeight());
RDebugUtils.currentLine=1048612;
 //BA.debugLineNum = 1048612;BA.debugLine="xpnl_actionground.AddView(xlbl_action_3,xlbl_acti";
__ref._xpnl_actionground.AddView((javafx.scene.Node)(__ref._xlbl_action_3.getObject()),__ref._xlbl_action_2.getLeft()+__ref._xlbl_action_2.getWidth()+__c.DipToCurrent((int) (5)),0,0,__ref._xpnl_actionground.getHeight());
RDebugUtils.currentLine=1048614;
 //BA.debugLineNum = 1048614;BA.debugLine="xlbl_action_1.Font = xui.CreateDefaultBoldFont(15";
__ref._xlbl_action_1.setFont(__ref._xui.CreateDefaultBoldFont((float) (15)));
RDebugUtils.currentLine=1048615;
 //BA.debugLineNum = 1048615;BA.debugLine="xlbl_action_2.Font = xui.CreateDefaultBoldFont(15";
__ref._xlbl_action_2.setFont(__ref._xui.CreateDefaultBoldFont((float) (15)));
RDebugUtils.currentLine=1048616;
 //BA.debugLineNum = 1048616;BA.debugLine="xlbl_action_3.Font = xui.CreateDefaultBoldFont(15";
__ref._xlbl_action_3.setFont(__ref._xui.CreateDefaultBoldFont((float) (15)));
RDebugUtils.currentLine=1048618;
 //BA.debugLineNum = 1048618;BA.debugLine="xlbl_action_1.TextColor = xui.Color_White";
__ref._xlbl_action_1.setTextColor(__ref._xui.Color_White);
RDebugUtils.currentLine=1048619;
 //BA.debugLineNum = 1048619;BA.debugLine="xlbl_action_2.TextColor = xui.Color_White";
__ref._xlbl_action_2.setTextColor(__ref._xui.Color_White);
RDebugUtils.currentLine=1048620;
 //BA.debugLineNum = 1048620;BA.debugLine="xlbl_action_3.TextColor = xui.Color_White";
__ref._xlbl_action_3.setTextColor(__ref._xui.Color_White);
RDebugUtils.currentLine=1048622;
 //BA.debugLineNum = 1048622;BA.debugLine="xlbl_action_1.SetTextAlignment(\"CENTER\",\"CENTER\")";
__ref._xlbl_action_1.SetTextAlignment("CENTER","CENTER");
RDebugUtils.currentLine=1048623;
 //BA.debugLineNum = 1048623;BA.debugLine="xlbl_action_2.SetTextAlignment(\"CENTER\",\"CENTER\")";
__ref._xlbl_action_2.SetTextAlignment("CENTER","CENTER");
RDebugUtils.currentLine=1048624;
 //BA.debugLineNum = 1048624;BA.debugLine="xlbl_action_3.SetTextAlignment(\"CENTER\",\"CENTER\")";
__ref._xlbl_action_3.SetTextAlignment("CENTER","CENTER");
RDebugUtils.currentLine=1048626;
 //BA.debugLineNum = 1048626;BA.debugLine="End Sub";
return "";
}
public String  _makeviewbackgroundtransparent(b4j.example.asmsgbox __ref,anywheresoftware.b4j.objects.B4XViewWrapper _view,int _alpha) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "makeviewbackgroundtransparent"))
	 {return ((String) Debug.delegate(ba, "makeviewbackgroundtransparent", new Object[] {_view,_alpha}));}
int _clr = 0;
RDebugUtils.currentLine=3997696;
 //BA.debugLineNum = 3997696;BA.debugLine="Private Sub MakeViewBackgroundTransparent(View As";
RDebugUtils.currentLine=3997697;
 //BA.debugLineNum = 3997697;BA.debugLine="Dim clr As Int = View.Color";
_clr = _view.getColor();
RDebugUtils.currentLine=3997698;
 //BA.debugLineNum = 3997698;BA.debugLine="If clr = 0 Then";
if (_clr==0) { 
RDebugUtils.currentLine=3997699;
 //BA.debugLineNum = 3997699;BA.debugLine="Log(\"Cannot get background color.\")";
__c.Log("Cannot get background color.");
RDebugUtils.currentLine=3997700;
 //BA.debugLineNum = 3997700;BA.debugLine="Return";
if (true) return "";
 };
RDebugUtils.currentLine=3997702;
 //BA.debugLineNum = 3997702;BA.debugLine="View.Color = Bit.Or(Bit.And(0x00ffffff, clr), Bit";
_view.setColor(__c.Bit.Or(__c.Bit.And((int) (0x00ffffff),_clr),__c.Bit.ShiftLeft(_alpha,(int) (24))));
RDebugUtils.currentLine=3997703;
 //BA.debugLineNum = 3997703;BA.debugLine="End Sub";
return "";
}
public int  _getcancel(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getcancel"))
	 {return ((Integer) Debug.delegate(ba, "getcancel", null));}
RDebugUtils.currentLine=3670016;
 //BA.debugLineNum = 3670016;BA.debugLine="Public Sub getCANCEL As Int";
RDebugUtils.currentLine=3670018;
 //BA.debugLineNum = 3670018;BA.debugLine="Return 1";
if (true) return (int) (1);
RDebugUtils.currentLine=3670020;
 //BA.debugLineNum = 3670020;BA.debugLine="End Sub";
return 0;
}
public int  _getnegative(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getnegative"))
	 {return ((Integer) Debug.delegate(ba, "getnegative", null));}
RDebugUtils.currentLine=3604480;
 //BA.debugLineNum = 3604480;BA.debugLine="Public Sub getNEGATIVE As Int";
RDebugUtils.currentLine=3604482;
 //BA.debugLineNum = 3604482;BA.debugLine="Return 2";
if (true) return (int) (2);
RDebugUtils.currentLine=3604484;
 //BA.debugLineNum = 3604484;BA.debugLine="End Sub";
return 0;
}
public String  _create_top(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "create_top"))
	 {return ((String) Debug.delegate(ba, "create_top", null));}
anywheresoftware.b4j.objects.LabelWrapper _lbl_close = null;
anywheresoftware.b4j.objects.ImageViewWrapper _iv_icon = null;
RDebugUtils.currentLine=983040;
 //BA.debugLineNum = 983040;BA.debugLine="Private Sub create_top";
RDebugUtils.currentLine=983043;
 //BA.debugLineNum = 983043;BA.debugLine="xpnl_header = xui.CreatePanel(\"xpnl_header\")";
__ref._xpnl_header = __ref._xui.CreatePanel(ba,"xpnl_header");
RDebugUtils.currentLine=983044;
 //BA.debugLineNum = 983044;BA.debugLine="mBase.AddView(xpnl_header,0,0,mBase.Width,60dip)";
__ref._mbase.AddView((javafx.scene.Node)(__ref._xpnl_header.getObject()),0,0,__ref._mbase.getWidth(),__c.DipToCurrent((int) (60)));
RDebugUtils.currentLine=983045;
 //BA.debugLineNum = 983045;BA.debugLine="xpnl_header.Color = xui.Color_Red";
__ref._xpnl_header.setColor(__ref._xui.Color_Red);
RDebugUtils.currentLine=983046;
 //BA.debugLineNum = 983046;BA.debugLine="xpnl_header.SetColorAndBorder(xui.Color_Red,0,xui";
__ref._xpnl_header.SetColorAndBorder(__ref._xui.Color_Red,0,__ref._xui.Color_Transparent,__c.DipToCurrent((int) (5)));
RDebugUtils.currentLine=983056;
 //BA.debugLineNum = 983056;BA.debugLine="xline_1 = xui.CreatePanel(\"\")";
__ref._xline_1 = __ref._xui.CreatePanel(ba,"");
RDebugUtils.currentLine=983057;
 //BA.debugLineNum = 983057;BA.debugLine="xpnl_header.AddView(xline_1,0dip,xpnl_header.Heig";
__ref._xpnl_header.AddView((javafx.scene.Node)(__ref._xline_1.getObject()),__c.DipToCurrent((int) (0)),__ref._xpnl_header.getHeight()-__c.DipToCurrent((int) (2)),__ref._xpnl_header.getWidth(),__c.DipToCurrent((int) (2)));
RDebugUtils.currentLine=983058;
 //BA.debugLineNum = 983058;BA.debugLine="xline_1.Color = xui.Color_White";
__ref._xline_1.setColor(__ref._xui.Color_White);
RDebugUtils.currentLine=983059;
 //BA.debugLineNum = 983059;BA.debugLine="MakeViewBackgroundTransparent(xline_1,100)";
__ref._makeviewbackgroundtransparent(null,__ref._xline_1,(int) (100));
RDebugUtils.currentLine=983062;
 //BA.debugLineNum = 983062;BA.debugLine="Private lbl_close As Label";
_lbl_close = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=983063;
 //BA.debugLineNum = 983063;BA.debugLine="lbl_close.Initialize(\"xpnl_close\")";
_lbl_close.Initialize(ba,"xpnl_close");
RDebugUtils.currentLine=983064;
 //BA.debugLineNum = 983064;BA.debugLine="xpnl_close = lbl_close";
__ref._xpnl_close.setObject((java.lang.Object)(_lbl_close.getObject()));
RDebugUtils.currentLine=983065;
 //BA.debugLineNum = 983065;BA.debugLine="mBase.AddView(xpnl_close, mBase.Width - 5dip - 20";
__ref._mbase.AddView((javafx.scene.Node)(__ref._xpnl_close.getObject()),__ref._mbase.getWidth()-__c.DipToCurrent((int) (5))-__c.DipToCurrent((int) (20)),__c.DipToCurrent((int) (2)),__c.DipToCurrent((int) (20)),__c.DipToCurrent((int) (20)));
RDebugUtils.currentLine=983073;
 //BA.debugLineNum = 983073;BA.debugLine="xIconFont = fx.CreateFontAwesome(25)";
__ref._xiconfont.setObject((javafx.scene.text.Font)(__ref._fx.CreateFontAwesome(25).getObject()));
RDebugUtils.currentLine=983078;
 //BA.debugLineNum = 983078;BA.debugLine="xpnl_close.Font = xIconFont";
__ref._xpnl_close.setFont(__ref._xiconfont);
RDebugUtils.currentLine=983079;
 //BA.debugLineNum = 983079;BA.debugLine="xpnl_close.TextColor = xui.Color_White";
__ref._xpnl_close.setTextColor(__ref._xui.Color_White);
RDebugUtils.currentLine=983080;
 //BA.debugLineNum = 983080;BA.debugLine="xpnl_close.Text = Chr(0xF00D)";
__ref._xpnl_close.setText(BA.ObjectToString(__c.Chr((int) (0xf00d))));
RDebugUtils.currentLine=983084;
 //BA.debugLineNum = 983084;BA.debugLine="Private iv_icon As ImageView";
_iv_icon = new anywheresoftware.b4j.objects.ImageViewWrapper();
RDebugUtils.currentLine=983085;
 //BA.debugLineNum = 983085;BA.debugLine="iv_icon.Initialize(\"xiv_icon\")";
_iv_icon.Initialize(ba,"xiv_icon");
RDebugUtils.currentLine=983087;
 //BA.debugLineNum = 983087;BA.debugLine="xiv_icon = iv_icon";
__ref._xiv_icon.setObject((java.lang.Object)(_iv_icon.getObject()));
RDebugUtils.currentLine=983088;
 //BA.debugLineNum = 983088;BA.debugLine="xpnl_header.AddView(xiv_icon,5dip,0,40dip,40dip)";
__ref._xpnl_header.AddView((javafx.scene.Node)(__ref._xiv_icon.getObject()),__c.DipToCurrent((int) (5)),0,__c.DipToCurrent((int) (40)),__c.DipToCurrent((int) (40)));
RDebugUtils.currentLine=983092;
 //BA.debugLineNum = 983092;BA.debugLine="lbl_header.Initialize(\"\")";
__ref._lbl_header.Initialize(ba,"");
RDebugUtils.currentLine=983093;
 //BA.debugLineNum = 983093;BA.debugLine="xlbl_header = lbl_header";
__ref._xlbl_header.setObject((java.lang.Object)(__ref._lbl_header.getObject()));
RDebugUtils.currentLine=983095;
 //BA.debugLineNum = 983095;BA.debugLine="xpnl_header.AddView(xlbl_header,5dip,5dip,xpnl_he";
__ref._xpnl_header.AddView((javafx.scene.Node)(__ref._xlbl_header.getObject()),__c.DipToCurrent((int) (5)),__c.DipToCurrent((int) (5)),__ref._xpnl_header.getWidth()-__c.DipToCurrent((int) (5)),__c.DipToCurrent((int) (20)));
RDebugUtils.currentLine=983096;
 //BA.debugLineNum = 983096;BA.debugLine="xlbl_header.TextColor = xui.Color_White";
__ref._xlbl_header.setTextColor(__ref._xui.Color_White);
RDebugUtils.currentLine=983097;
 //BA.debugLineNum = 983097;BA.debugLine="xlbl_header.Font = xui.CreateDefaultBoldFont(head";
__ref._xlbl_header.setFont(__ref._xui.CreateDefaultBoldFont((float) (__ref._headerfontsize)));
RDebugUtils.currentLine=983098;
 //BA.debugLineNum = 983098;BA.debugLine="xlbl_header.SetTextAlignment(\"CENTER\",\"CENTER\")";
__ref._xlbl_header.SetTextAlignment("CENTER","CENTER");
RDebugUtils.currentLine=983099;
 //BA.debugLineNum = 983099;BA.debugLine="xlbl_header.Text = headerText";
__ref._xlbl_header.setText(__ref._headertext);
RDebugUtils.currentLine=983101;
 //BA.debugLineNum = 983101;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper  _createroundbitmap(b4j.example.asmsgbox __ref,anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _input,int _size) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "createroundbitmap"))
	 {return ((anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) Debug.delegate(ba, "createroundbitmap", new Object[] {_input,_size}));}
int _l = 0;
anywheresoftware.b4j.objects.B4XCanvas _c = null;
anywheresoftware.b4j.objects.B4XViewWrapper _xview = null;
anywheresoftware.b4j.objects.B4XCanvas.B4XPath _path = null;
anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _res = null;
RDebugUtils.currentLine=4194304;
 //BA.debugLineNum = 4194304;BA.debugLine="Sub CreateRoundBitmap (Input As B4XBitmap, Size As";
RDebugUtils.currentLine=4194305;
 //BA.debugLineNum = 4194305;BA.debugLine="If Input.Width <> Input.Height Then";
if (_input.getWidth()!=_input.getHeight()) { 
RDebugUtils.currentLine=4194307;
 //BA.debugLineNum = 4194307;BA.debugLine="Dim l As Int = Min(Input.Width, Input.Height)";
_l = (int) (__c.Min(_input.getWidth(),_input.getHeight()));
RDebugUtils.currentLine=4194308;
 //BA.debugLineNum = 4194308;BA.debugLine="Input = Input.Crop(Input.Width / 2 - l / 2, Inpu";
_input = _input.Crop((int) (_input.getWidth()/(double)2-_l/(double)2),(int) (_input.getHeight()/(double)2-_l/(double)2),_l,_l);
 };
RDebugUtils.currentLine=4194310;
 //BA.debugLineNum = 4194310;BA.debugLine="Dim c As B4XCanvas";
_c = new anywheresoftware.b4j.objects.B4XCanvas();
RDebugUtils.currentLine=4194311;
 //BA.debugLineNum = 4194311;BA.debugLine="Dim xview As B4XView = xui.CreatePanel(\"\")";
_xview = new anywheresoftware.b4j.objects.B4XViewWrapper();
_xview = __ref._xui.CreatePanel(ba,"");
RDebugUtils.currentLine=4194312;
 //BA.debugLineNum = 4194312;BA.debugLine="xview.SetLayoutAnimated(0, 0, 0, Size, Size)";
_xview.SetLayoutAnimated((int) (0),0,0,_size,_size);
RDebugUtils.currentLine=4194313;
 //BA.debugLineNum = 4194313;BA.debugLine="c.Initialize(xview)";
_c.Initialize(ba,_xview);
RDebugUtils.currentLine=4194314;
 //BA.debugLineNum = 4194314;BA.debugLine="Dim path As B4XPath";
_path = new anywheresoftware.b4j.objects.B4XCanvas.B4XPath();
RDebugUtils.currentLine=4194315;
 //BA.debugLineNum = 4194315;BA.debugLine="path.InitializeOval(c.TargetRect)";
_path.InitializeOval(_c.getTargetRect());
RDebugUtils.currentLine=4194316;
 //BA.debugLineNum = 4194316;BA.debugLine="c.ClipPath(path)";
_c.ClipPath(_path);
RDebugUtils.currentLine=4194317;
 //BA.debugLineNum = 4194317;BA.debugLine="c.DrawBitmap(Input.Resize(Size, Size, False), c.T";
_c.DrawBitmap((javafx.scene.image.Image)(_input.Resize(_size,_size,__c.False).getObject()),_c.getTargetRect());
RDebugUtils.currentLine=4194318;
 //BA.debugLineNum = 4194318;BA.debugLine="c.RemoveClip";
_c.RemoveClip();
RDebugUtils.currentLine=4194320;
 //BA.debugLineNum = 4194320;BA.debugLine="If border_width > 0 Then";
if (__ref._border_width>0) { 
RDebugUtils.currentLine=4194321;
 //BA.debugLineNum = 4194321;BA.debugLine="c.DrawCircle(c.TargetRect.CenterX, c.TargetRect.C";
_c.DrawCircle(_c.getTargetRect().getCenterX(),_c.getTargetRect().getCenterY(),(float) (_c.getTargetRect().getWidth()/(double)2-__c.DipToCurrent((int) (2))),__ref._xui.Color_White,__c.False,(float) (__ref._border_width));
 };
RDebugUtils.currentLine=4194323;
 //BA.debugLineNum = 4194323;BA.debugLine="c.Invalidate";
_c.Invalidate();
RDebugUtils.currentLine=4194324;
 //BA.debugLineNum = 4194324;BA.debugLine="Dim res As B4XBitmap = c.CreateBitmap";
_res = new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper();
_res = _c.CreateBitmap();
RDebugUtils.currentLine=4194325;
 //BA.debugLineNum = 4194325;BA.debugLine="c.Release";
_c.Release();
RDebugUtils.currentLine=4194326;
 //BA.debugLineNum = 4194326;BA.debugLine="Return res";
if (true) return _res;
RDebugUtils.currentLine=4194327;
 //BA.debugLineNum = 4194327;BA.debugLine="End Sub";
return null;
}
public String  _designercreateview(b4j.example.asmsgbox __ref,Object _base,anywheresoftware.b4j.objects.LabelWrapper _lbl,anywheresoftware.b4a.objects.collections.Map _props) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "designercreateview"))
	 {return ((String) Debug.delegate(ba, "designercreateview", new Object[] {_base,_lbl,_props}));}
anywheresoftware.b4j.objects.LabelWrapper _lbl_text = null;
RDebugUtils.currentLine=655360;
 //BA.debugLineNum = 655360;BA.debugLine="Public Sub DesignerCreateView (Base As Object, lbl";
RDebugUtils.currentLine=655361;
 //BA.debugLineNum = 655361;BA.debugLine="mBase = Base";
__ref._mbase.setObject((java.lang.Object)(_base));
RDebugUtils.currentLine=655363;
 //BA.debugLineNum = 655363;BA.debugLine="back_color = xui.PaintOrColorToColor(Props.Get(";
__ref._back_color = __ref._xui.PaintOrColorToColor(_props.Get((Object)("Back_Color")));
RDebugUtils.currentLine=655364;
 //BA.debugLineNum = 655364;BA.debugLine="showX = Props.Get(\"Show_X\")";
__ref._showx = BA.ObjectToBoolean(_props.Get((Object)("Show_X")));
RDebugUtils.currentLine=655365;
 //BA.debugLineNum = 655365;BA.debugLine="header_clr = xui.PaintOrColorToColor(Props.Get(\"H";
__ref._header_clr = __ref._xui.PaintOrColorToColor(_props.Get((Object)("Header_CLR")));
RDebugUtils.currentLine=655366;
 //BA.debugLineNum = 655366;BA.debugLine="bottom_crl = xui.PaintOrColorToColor(Props.Get(\"B";
__ref._bottom_crl = __ref._xui.PaintOrColorToColor(_props.Get((Object)("Bottom_CLR")));
RDebugUtils.currentLine=655368;
 //BA.debugLineNum = 655368;BA.debugLine="iconVisible = Props.Get(\"Icon_visible\")";
__ref._iconvisible = BA.ObjectToBoolean(_props.Get((Object)("Icon_visible")));
RDebugUtils.currentLine=655369;
 //BA.debugLineNum = 655369;BA.debugLine="iconDirection = Props.Get(\"Icon_direction\")";
__ref._icondirection = BA.ObjectToString(_props.Get((Object)("Icon_direction")));
RDebugUtils.currentLine=655370;
 //BA.debugLineNum = 655370;BA.debugLine="border_width = DipToCurrent(Props.Get(\"BorderWidt";
__ref._border_width = __c.DipToCurrent((int)(BA.ObjectToNumber(_props.Get((Object)("BorderWidth")))));
RDebugUtils.currentLine=655372;
 //BA.debugLineNum = 655372;BA.debugLine="showHeader = Props.Get(\"show_header\")";
__ref._showheader = BA.ObjectToBoolean(_props.Get((Object)("show_header")));
RDebugUtils.currentLine=655373;
 //BA.debugLineNum = 655373;BA.debugLine="showBottom = Props.Get(\"show_bottom\")";
__ref._showbottom = BA.ObjectToBoolean(_props.Get((Object)("show_bottom")));
RDebugUtils.currentLine=655375;
 //BA.debugLineNum = 655375;BA.debugLine="headerFontSize = Props.Get(\"header_font_size\")";
__ref._headerfontsize = (int)(BA.ObjectToNumber(_props.Get((Object)("header_font_size"))));
RDebugUtils.currentLine=655377;
 //BA.debugLineNum = 655377;BA.debugLine="headerText = Props.Get(\"Header_Text\")";
__ref._headertext = BA.ObjectToString(_props.Get((Object)("Header_Text")));
RDebugUtils.currentLine=655379;
 //BA.debugLineNum = 655379;BA.debugLine="create_top";
__ref._create_top(null);
RDebugUtils.currentLine=655380;
 //BA.debugLineNum = 655380;BA.debugLine="create_bottom";
__ref._create_bottom(null);
RDebugUtils.currentLine=655382;
 //BA.debugLineNum = 655382;BA.debugLine="xpnl_content = xui.CreatePanel(\"xpnl_content\")";
__ref._xpnl_content = __ref._xui.CreatePanel(ba,"xpnl_content");
RDebugUtils.currentLine=655383;
 //BA.debugLineNum = 655383;BA.debugLine="mBase.AddView(xpnl_content,0,xpnl_header.Height,m";
__ref._mbase.AddView((javafx.scene.Node)(__ref._xpnl_content.getObject()),0,__ref._xpnl_header.getHeight(),__ref._mbase.getWidth(),__ref._xpnl_bottom.getTop()-__ref._xpnl_header.getHeight());
RDebugUtils.currentLine=655384;
 //BA.debugLineNum = 655384;BA.debugLine="xpnl_content.Color = xui.Color_Transparent";
__ref._xpnl_content.setColor(__ref._xui.Color_Transparent);
RDebugUtils.currentLine=655393;
 //BA.debugLineNum = 655393;BA.debugLine="Dim lbl_text As Label";
_lbl_text = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=655394;
 //BA.debugLineNum = 655394;BA.debugLine="lbl_text.Initialize(\"\")";
_lbl_text.Initialize(ba,"");
RDebugUtils.currentLine=655396;
 //BA.debugLineNum = 655396;BA.debugLine="xlbl_text = lbl_text";
__ref._xlbl_text.setObject((java.lang.Object)(_lbl_text.getObject()));
RDebugUtils.currentLine=655397;
 //BA.debugLineNum = 655397;BA.debugLine="xlbl_text.TextColor = xui.Color_White";
__ref._xlbl_text.setTextColor(__ref._xui.Color_White);
RDebugUtils.currentLine=655398;
 //BA.debugLineNum = 655398;BA.debugLine="xlbl_text.Font = xui.CreateDefaultBoldFont(20)";
__ref._xlbl_text.setFont(__ref._xui.CreateDefaultBoldFont((float) (20)));
RDebugUtils.currentLine=655399;
 //BA.debugLineNum = 655399;BA.debugLine="xlbl_text.SetTextAlignment(\"CENTER\",\"CENTER\")";
__ref._xlbl_text.SetTextAlignment("CENTER","CENTER");
RDebugUtils.currentLine=655401;
 //BA.debugLineNum = 655401;BA.debugLine="mBase.AddView(xlbl_text,0,xpnl_header.Height,mBas";
__ref._mbase.AddView((javafx.scene.Node)(__ref._xlbl_text.getObject()),0,__ref._xpnl_header.getHeight(),__ref._mbase.getWidth(),__ref._xpnl_bottom.getTop()-__ref._xpnl_header.getHeight());
RDebugUtils.currentLine=655403;
 //BA.debugLineNum = 655403;BA.debugLine="xlbl_text.Visible = False";
__ref._xlbl_text.setVisible(__c.False);
RDebugUtils.currentLine=655411;
 //BA.debugLineNum = 655411;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4j.objects.B4XViewWrapper  _getbase(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getbase"))
	 {return ((anywheresoftware.b4j.objects.B4XViewWrapper) Debug.delegate(ba, "getbase", null));}
RDebugUtils.currentLine=589824;
 //BA.debugLineNum = 589824;BA.debugLine="Public Sub getBase As B4XView";
RDebugUtils.currentLine=589826;
 //BA.debugLineNum = 589826;BA.debugLine="Return mBase";
if (true) return __ref._mbase;
RDebugUtils.currentLine=589828;
 //BA.debugLineNum = 589828;BA.debugLine="End Sub";
return null;
}
public int  _getbottomcolor(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getbottomcolor"))
	 {return ((Integer) Debug.delegate(ba, "getbottomcolor", null));}
RDebugUtils.currentLine=3211264;
 //BA.debugLineNum = 3211264;BA.debugLine="Public Sub getBottomColor As Int";
RDebugUtils.currentLine=3211266;
 //BA.debugLineNum = 3211266;BA.debugLine="Return xpnl_bottom.Color";
if (true) return __ref._xpnl_bottom.getColor();
RDebugUtils.currentLine=3211268;
 //BA.debugLineNum = 3211268;BA.debugLine="End Sub";
return 0;
}
public int  _getbottomtop(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getbottomtop"))
	 {return ((Integer) Debug.delegate(ba, "getbottomtop", null));}
RDebugUtils.currentLine=2621440;
 //BA.debugLineNum = 2621440;BA.debugLine="Public Sub getBottomTop As Int";
RDebugUtils.currentLine=2621442;
 //BA.debugLineNum = 2621442;BA.debugLine="Return xpnl_bottom.Top";
if (true) return (int) (__ref._xpnl_bottom.getTop());
RDebugUtils.currentLine=2621444;
 //BA.debugLineNum = 2621444;BA.debugLine="End Sub";
return 0;
}
public anywheresoftware.b4j.objects.B4XViewWrapper  _getbutton1(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getbutton1"))
	 {return ((anywheresoftware.b4j.objects.B4XViewWrapper) Debug.delegate(ba, "getbutton1", null));}
RDebugUtils.currentLine=2818048;
 //BA.debugLineNum = 2818048;BA.debugLine="Public Sub getButton1 As B4XView";
RDebugUtils.currentLine=2818050;
 //BA.debugLineNum = 2818050;BA.debugLine="Return xlbl_action_1";
if (true) return __ref._xlbl_action_1;
RDebugUtils.currentLine=2818052;
 //BA.debugLineNum = 2818052;BA.debugLine="End Sub";
return null;
}
public anywheresoftware.b4j.objects.B4XViewWrapper  _getbutton2(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getbutton2"))
	 {return ((anywheresoftware.b4j.objects.B4XViewWrapper) Debug.delegate(ba, "getbutton2", null));}
RDebugUtils.currentLine=2883584;
 //BA.debugLineNum = 2883584;BA.debugLine="Public Sub getButton2 As B4XView";
RDebugUtils.currentLine=2883586;
 //BA.debugLineNum = 2883586;BA.debugLine="Return xlbl_action_2";
if (true) return __ref._xlbl_action_2;
RDebugUtils.currentLine=2883588;
 //BA.debugLineNum = 2883588;BA.debugLine="End Sub";
return null;
}
public anywheresoftware.b4j.objects.B4XViewWrapper  _getbutton3(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getbutton3"))
	 {return ((anywheresoftware.b4j.objects.B4XViewWrapper) Debug.delegate(ba, "getbutton3", null));}
RDebugUtils.currentLine=2949120;
 //BA.debugLineNum = 2949120;BA.debugLine="Public Sub getButton3 As B4XView";
RDebugUtils.currentLine=2949122;
 //BA.debugLineNum = 2949122;BA.debugLine="Return xlbl_action_3";
if (true) return __ref._xlbl_action_3;
RDebugUtils.currentLine=2949124;
 //BA.debugLineNum = 2949124;BA.debugLine="End Sub";
return null;
}
public boolean  _getclosebuttonvisible(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getclosebuttonvisible"))
	 {return ((Boolean) Debug.delegate(ba, "getclosebuttonvisible", null));}
RDebugUtils.currentLine=2490368;
 //BA.debugLineNum = 2490368;BA.debugLine="Public Sub getCloseButtonVisible As Boolean";
RDebugUtils.currentLine=2490370;
 //BA.debugLineNum = 2490370;BA.debugLine="Return showX";
if (true) return __ref._showx;
RDebugUtils.currentLine=2490372;
 //BA.debugLineNum = 2490372;BA.debugLine="End Sub";
return false;
}
public int  _getcontentheight(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getcontentheight"))
	 {return ((Integer) Debug.delegate(ba, "getcontentheight", null));}
RDebugUtils.currentLine=2686976;
 //BA.debugLineNum = 2686976;BA.debugLine="Public Sub getContentHeight As Int";
RDebugUtils.currentLine=2686978;
 //BA.debugLineNum = 2686978;BA.debugLine="Return xpnl_content.Height";
if (true) return (int) (__ref._xpnl_content.getHeight());
RDebugUtils.currentLine=2686980;
 //BA.debugLineNum = 2686980;BA.debugLine="End Sub";
return 0;
}
public int  _getdragablecontent(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getdragablecontent"))
	 {return ((Integer) Debug.delegate(ba, "getdragablecontent", null));}
RDebugUtils.currentLine=2228224;
 //BA.debugLineNum = 2228224;BA.debugLine="Public Sub getDragableContent As Int";
RDebugUtils.currentLine=2228226;
 //BA.debugLineNum = 2228226;BA.debugLine="Return 2";
if (true) return (int) (2);
RDebugUtils.currentLine=2228228;
 //BA.debugLineNum = 2228228;BA.debugLine="End Sub";
return 0;
}
public int  _getdragabledisable(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getdragabledisable"))
	 {return ((Integer) Debug.delegate(ba, "getdragabledisable", null));}
RDebugUtils.currentLine=2293760;
 //BA.debugLineNum = 2293760;BA.debugLine="Public Sub getDragableDisable As Int";
RDebugUtils.currentLine=2293762;
 //BA.debugLineNum = 2293762;BA.debugLine="Return 0";
if (true) return (int) (0);
RDebugUtils.currentLine=2293764;
 //BA.debugLineNum = 2293764;BA.debugLine="End Sub";
return 0;
}
public int  _getenabledrag(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getenabledrag"))
	 {return ((Integer) Debug.delegate(ba, "getenabledrag", null));}
RDebugUtils.currentLine=2097152;
 //BA.debugLineNum = 2097152;BA.debugLine="Public Sub getEnableDrag As Int";
RDebugUtils.currentLine=2097154;
 //BA.debugLineNum = 2097154;BA.debugLine="Return dragable";
if (true) return __ref._dragable;
RDebugUtils.currentLine=2097156;
 //BA.debugLineNum = 2097156;BA.debugLine="End Sub";
return 0;
}
public int  _getheader_font_size(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getheader_font_size"))
	 {return ((Integer) Debug.delegate(ba, "getheader_font_size", null));}
RDebugUtils.currentLine=1507328;
 //BA.debugLineNum = 1507328;BA.debugLine="Public Sub getHeader_Font_Size As Int";
RDebugUtils.currentLine=1507330;
 //BA.debugLineNum = 1507330;BA.debugLine="Return headerFontSize";
if (true) return __ref._headerfontsize;
RDebugUtils.currentLine=1507332;
 //BA.debugLineNum = 1507332;BA.debugLine="End Sub";
return 0;
}
public String  _getheader_text(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getheader_text"))
	 {return ((String) Debug.delegate(ba, "getheader_text", null));}
RDebugUtils.currentLine=1376256;
 //BA.debugLineNum = 1376256;BA.debugLine="Public Sub getHeader_Text As String";
RDebugUtils.currentLine=1376258;
 //BA.debugLineNum = 1376258;BA.debugLine="Return headerText";
if (true) return __ref._headertext;
RDebugUtils.currentLine=1376260;
 //BA.debugLineNum = 1376260;BA.debugLine="End Sub";
return "";
}
public int  _getheaderbottom(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getheaderbottom"))
	 {return ((Integer) Debug.delegate(ba, "getheaderbottom", null));}
RDebugUtils.currentLine=2555904;
 //BA.debugLineNum = 2555904;BA.debugLine="Public Sub getHeaderBottom As Int";
RDebugUtils.currentLine=2555906;
 //BA.debugLineNum = 2555906;BA.debugLine="Return xpnl_header.Height";
if (true) return (int) (__ref._xpnl_header.getHeight());
RDebugUtils.currentLine=2555908;
 //BA.debugLineNum = 2555908;BA.debugLine="End Sub";
return 0;
}
public int  _getheadercolor(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "getheadercolor"))
	 {return ((Integer) Debug.delegate(ba, "getheadercolor", null));}
RDebugUtils.currentLine=3145728;
 //BA.debugLineNum = 3145728;BA.debugLine="Public Sub getHeaderColor As Int";
RDebugUtils.currentLine=3145730;
 //BA.debugLineNum = 3145730;BA.debugLine="Return xpnl_header.Color";
if (true) return __ref._xpnl_header.getColor();
RDebugUtils.currentLine=3145732;
 //BA.debugLineNum = 3145732;BA.debugLine="End Sub";
return 0;
}
public String  _geticon_direction(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "geticon_direction"))
	 {return ((String) Debug.delegate(ba, "geticon_direction", null));}
RDebugUtils.currentLine=1703936;
 //BA.debugLineNum = 1703936;BA.debugLine="Public Sub getIcon_direction As String";
RDebugUtils.currentLine=1703938;
 //BA.debugLineNum = 1703938;BA.debugLine="Return iconDirection";
if (true) return __ref._icondirection;
RDebugUtils.currentLine=1703940;
 //BA.debugLineNum = 1703940;BA.debugLine="End Sub";
return "";
}
public String  _icon_border_width(b4j.example.asmsgbox __ref,int _border) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "icon_border_width"))
	 {return ((String) Debug.delegate(ba, "icon_border_width", new Object[] {_border}));}
RDebugUtils.currentLine=1835008;
 //BA.debugLineNum = 1835008;BA.debugLine="Public Sub icon_border_width(border As Int)";
RDebugUtils.currentLine=1835010;
 //BA.debugLineNum = 1835010;BA.debugLine="If border > -1 And border < 6 Then";
if (_border>-1 && _border<6) { 
RDebugUtils.currentLine=1835012;
 //BA.debugLineNum = 1835012;BA.debugLine="border_width = border";
__ref._border_width = _border;
 }else {
RDebugUtils.currentLine=1835019;
 //BA.debugLineNum = 1835019;BA.debugLine="Return";
if (true) return "";
 };
RDebugUtils.currentLine=1835023;
 //BA.debugLineNum = 1835023;BA.debugLine="End Sub";
return "";
}
public String  _icon_click_handler(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "icon_click_handler"))
	 {return ((String) Debug.delegate(ba, "icon_click_handler", null));}
RDebugUtils.currentLine=1245184;
 //BA.debugLineNum = 1245184;BA.debugLine="Private Sub icon_click_handler";
RDebugUtils.currentLine=1245186;
 //BA.debugLineNum = 1245186;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_IconCl";
if (__ref._xui.SubExists(ba,__ref._mcallback,__ref._meventname+"_IconClick",(int) (0))) { 
RDebugUtils.currentLine=1245187;
 //BA.debugLineNum = 1245187;BA.debugLine="CallSub(mCallBack, mEventName & \"_IconClick\")";
__c.CallSubNew(ba,__ref._mcallback,__ref._meventname+"_IconClick");
 };
RDebugUtils.currentLine=1245190;
 //BA.debugLineNum = 1245190;BA.debugLine="End Sub";
return "";
}
public String  _icon_longclick_handler(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "icon_longclick_handler"))
	 {return ((String) Debug.delegate(ba, "icon_longclick_handler", null));}
RDebugUtils.currentLine=1310720;
 //BA.debugLineNum = 1310720;BA.debugLine="Private Sub icon_longclick_handler";
RDebugUtils.currentLine=1310722;
 //BA.debugLineNum = 1310722;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_IconLo";
if (__ref._xui.SubExists(ba,__ref._mcallback,__ref._meventname+"_IconLongClick",(int) (0))) { 
RDebugUtils.currentLine=1310723;
 //BA.debugLineNum = 1310723;BA.debugLine="CallSub(mCallBack, mEventName & \"_IconLongClick\"";
__c.CallSubNew(ba,__ref._mcallback,__ref._meventname+"_IconLongClick");
 };
RDebugUtils.currentLine=1310726;
 //BA.debugLineNum = 1310726;BA.debugLine="End Sub";
return "";
}
public String  _icon_visible(b4j.example.asmsgbox __ref,boolean _visible) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "icon_visible"))
	 {return ((String) Debug.delegate(ba, "icon_visible", new Object[] {_visible}));}
RDebugUtils.currentLine=1769472;
 //BA.debugLineNum = 1769472;BA.debugLine="Public Sub icon_visible(visible As Boolean)";
RDebugUtils.currentLine=1769474;
 //BA.debugLineNum = 1769474;BA.debugLine="iconVisible = visible";
__ref._iconvisible = _visible;
RDebugUtils.currentLine=1769475;
 //BA.debugLineNum = 1769475;BA.debugLine="Base_Resize(mBase.Width,mBase.Height)";
__ref._base_resize(null,__ref._mbase.getWidth(),__ref._mbase.getHeight());
RDebugUtils.currentLine=1769477;
 //BA.debugLineNum = 1769477;BA.debugLine="End Sub";
return "";
}
public String  _loadlayout(b4j.example.asmsgbox __ref,String _layout) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "loadlayout"))
	 {return ((String) Debug.delegate(ba, "loadlayout", new Object[] {_layout}));}
RDebugUtils.currentLine=3014656;
 //BA.debugLineNum = 3014656;BA.debugLine="Public Sub LoadLayout(layout As String)";
RDebugUtils.currentLine=3014658;
 //BA.debugLineNum = 3014658;BA.debugLine="xpnl_content.LoadLayout(layout)";
__ref._xpnl_content.LoadLayout(_layout,ba);
RDebugUtils.currentLine=3014660;
 //BA.debugLineNum = 3014660;BA.debugLine="End Sub";
return "";
}
public String  _loadlayout2(b4j.example.asmsgbox __ref,anywheresoftware.b4j.objects.B4XViewWrapper _p) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "loadlayout2"))
	 {return ((String) Debug.delegate(ba, "loadlayout2", new Object[] {_p}));}
RDebugUtils.currentLine=3080192;
 //BA.debugLineNum = 3080192;BA.debugLine="Public Sub LoadLayout2(p As B4XView)";
RDebugUtils.currentLine=3080194;
 //BA.debugLineNum = 3080194;BA.debugLine="xpnl_content = p";
__ref._xpnl_content = _p;
RDebugUtils.currentLine=3080196;
 //BA.debugLineNum = 3080196;BA.debugLine="End Sub";
return "";
}
public String  _result(b4j.example.asmsgbox __ref,int _res) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "result"))
	 {return ((String) Debug.delegate(ba, "result", new Object[] {_res}));}
RDebugUtils.currentLine=3932160;
 //BA.debugLineNum = 3932160;BA.debugLine="Private Sub result(res As Int)";
RDebugUtils.currentLine=3932162;
 //BA.debugLineNum = 3932162;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_result";
if (__ref._xui.SubExists(ba,__ref._mcallback,__ref._meventname+"_result",(int) (0))) { 
RDebugUtils.currentLine=3932163;
 //BA.debugLineNum = 3932163;BA.debugLine="CallSub2(mCallBack, mEventName & \"_result\",res)";
__c.CallSubNew2(ba,__ref._mcallback,__ref._meventname+"_result",(Object)(_res));
 };
RDebugUtils.currentLine=3932166;
 //BA.debugLineNum = 3932166;BA.debugLine="End Sub";
return "";
}
public String  _setbottomcolor(b4j.example.asmsgbox __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "setbottomcolor"))
	 {return ((String) Debug.delegate(ba, "setbottomcolor", new Object[] {_color}));}
RDebugUtils.currentLine=3342336;
 //BA.debugLineNum = 3342336;BA.debugLine="Public Sub setBottomColor(color As Int)";
RDebugUtils.currentLine=3342338;
 //BA.debugLineNum = 3342338;BA.debugLine="bottom_crl = color";
__ref._bottom_crl = _color;
RDebugUtils.currentLine=3342339;
 //BA.debugLineNum = 3342339;BA.debugLine="xpnl_bottom.Color = color";
__ref._xpnl_bottom.setColor(_color);
RDebugUtils.currentLine=3342341;
 //BA.debugLineNum = 3342341;BA.debugLine="End Sub";
return "";
}
public String  _setheader_font_size(b4j.example.asmsgbox __ref,int _fontsize) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "setheader_font_size"))
	 {return ((String) Debug.delegate(ba, "setheader_font_size", new Object[] {_fontsize}));}
RDebugUtils.currentLine=1572864;
 //BA.debugLineNum = 1572864;BA.debugLine="Public Sub setHeader_Font_Size(fontsize As Int)";
RDebugUtils.currentLine=1572866;
 //BA.debugLineNum = 1572866;BA.debugLine="headerFontSize = fontsize";
__ref._headerfontsize = _fontsize;
RDebugUtils.currentLine=1572867;
 //BA.debugLineNum = 1572867;BA.debugLine="xlbl_header.Font = xui.CreateDefaultBoldFont(head";
__ref._xlbl_header.setFont(__ref._xui.CreateDefaultBoldFont((float) (__ref._headerfontsize)));
RDebugUtils.currentLine=1572869;
 //BA.debugLineNum = 1572869;BA.debugLine="End Sub";
return "";
}
public String  _setheader_text(b4j.example.asmsgbox __ref,String _text) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "setheader_text"))
	 {return ((String) Debug.delegate(ba, "setheader_text", new Object[] {_text}));}
RDebugUtils.currentLine=1441792;
 //BA.debugLineNum = 1441792;BA.debugLine="Public Sub setHeader_Text(text As String)";
RDebugUtils.currentLine=1441794;
 //BA.debugLineNum = 1441794;BA.debugLine="headerText = text";
__ref._headertext = _text;
RDebugUtils.currentLine=1441795;
 //BA.debugLineNum = 1441795;BA.debugLine="xlbl_header.Text = headerText";
__ref._xlbl_header.setText(__ref._headertext);
RDebugUtils.currentLine=1441797;
 //BA.debugLineNum = 1441797;BA.debugLine="End Sub";
return "";
}
public String  _setheadercolor(b4j.example.asmsgbox __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "setheadercolor"))
	 {return ((String) Debug.delegate(ba, "setheadercolor", new Object[] {_color}));}
RDebugUtils.currentLine=3276800;
 //BA.debugLineNum = 3276800;BA.debugLine="Public Sub setHeaderColor(color As Int)";
RDebugUtils.currentLine=3276802;
 //BA.debugLineNum = 3276802;BA.debugLine="header_clr = color";
__ref._header_clr = _color;
RDebugUtils.currentLine=3276803;
 //BA.debugLineNum = 3276803;BA.debugLine="xpnl_header.Color = color";
__ref._xpnl_header.setColor(_color);
RDebugUtils.currentLine=3276805;
 //BA.debugLineNum = 3276805;BA.debugLine="End Sub";
return "";
}
public String  _seticon_direction(b4j.example.asmsgbox __ref,String _direction) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "seticon_direction"))
	 {return ((String) Debug.delegate(ba, "seticon_direction", new Object[] {_direction}));}
RDebugUtils.currentLine=1638400;
 //BA.debugLineNum = 1638400;BA.debugLine="Public Sub setIcon_direction(direction As String)";
RDebugUtils.currentLine=1638402;
 //BA.debugLineNum = 1638402;BA.debugLine="If direction = \"LEFT\" Or direction = \"RIGHT\" Or d";
if ((_direction).equals("LEFT") || (_direction).equals("RIGHT") || (_direction).equals("MIDDLE")) { 
RDebugUtils.currentLine=1638404;
 //BA.debugLineNum = 1638404;BA.debugLine="iconDirection = direction";
__ref._icondirection = _direction;
RDebugUtils.currentLine=1638405;
 //BA.debugLineNum = 1638405;BA.debugLine="Base_Resize(mBase.Width,mBase.Height)";
__ref._base_resize(null,__ref._mbase.getWidth(),__ref._mbase.getHeight());
 }else {
RDebugUtils.currentLine=1638409;
 //BA.debugLineNum = 1638409;BA.debugLine="Return";
if (true) return "";
 };
RDebugUtils.currentLine=1638413;
 //BA.debugLineNum = 1638413;BA.debugLine="End Sub";
return "";
}
public String  _show(b4j.example.asmsgbox __ref,boolean _animated) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "show"))
	 {return ((String) Debug.delegate(ba, "show", new Object[] {_animated}));}
RDebugUtils.currentLine=786432;
 //BA.debugLineNum = 786432;BA.debugLine="Public Sub Show(animated As Boolean)";
RDebugUtils.currentLine=786434;
 //BA.debugLineNum = 786434;BA.debugLine="If animated = True Then";
if (_animated==__c.True) { 
RDebugUtils.currentLine=786436;
 //BA.debugLineNum = 786436;BA.debugLine="mBase.SetVisibleAnimated(300,True)";
__ref._mbase.SetVisibleAnimated(ba,(int) (300),__c.True);
 }else 
{RDebugUtils.currentLine=786438;
 //BA.debugLineNum = 786438;BA.debugLine="Else If animated = False Then";
if (_animated==__c.False) { 
RDebugUtils.currentLine=786440;
 //BA.debugLineNum = 786440;BA.debugLine="mBase.Visible = True";
__ref._mbase.setVisible(__c.True);
 }}
;
RDebugUtils.currentLine=786444;
 //BA.debugLineNum = 786444;BA.debugLine="End Sub";
return "";
}
public String  _xiv_icon_longclick(b4j.example.asmsgbox __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "xiv_icon_longclick"))
	 {return ((String) Debug.delegate(ba, "xiv_icon_longclick", null));}
RDebugUtils.currentLine=1179648;
 //BA.debugLineNum = 1179648;BA.debugLine="Private Sub xiv_icon_LongClick";
RDebugUtils.currentLine=1179650;
 //BA.debugLineNum = 1179650;BA.debugLine="icon_longclick_handler";
__ref._icon_longclick_handler(null);
RDebugUtils.currentLine=1179652;
 //BA.debugLineNum = 1179652;BA.debugLine="End Sub";
return "";
}
public String  _xiv_icon_mouseclicked(b4j.example.asmsgbox __ref,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "xiv_icon_mouseclicked"))
	 {return ((String) Debug.delegate(ba, "xiv_icon_mouseclicked", new Object[] {_eventdata}));}
RDebugUtils.currentLine=1114112;
 //BA.debugLineNum = 1114112;BA.debugLine="Private Sub xiv_icon_MouseClicked (EventData As Mo";
RDebugUtils.currentLine=1114114;
 //BA.debugLineNum = 1114114;BA.debugLine="icon_click_handler";
__ref._icon_click_handler(null);
RDebugUtils.currentLine=1114116;
 //BA.debugLineNum = 1114116;BA.debugLine="End Sub";
return "";
}
public String  _xlbl_action_1_mouseclicked(b4j.example.asmsgbox __ref,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "xlbl_action_1_mouseclicked"))
	 {return ((String) Debug.delegate(ba, "xlbl_action_1_mouseclicked", new Object[] {_eventdata}));}
RDebugUtils.currentLine=3735552;
 //BA.debugLineNum = 3735552;BA.debugLine="Private Sub xlbl_action_1_MouseClicked (EventData";
RDebugUtils.currentLine=3735554;
 //BA.debugLineNum = 3735554;BA.debugLine="result(xlbl_action_1.Tag)";
__ref._result(null,(int)(BA.ObjectToNumber(__ref._xlbl_action_1.getTag())));
RDebugUtils.currentLine=3735556;
 //BA.debugLineNum = 3735556;BA.debugLine="End Sub";
return "";
}
public String  _xlbl_action_2_mouseclicked(b4j.example.asmsgbox __ref,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "xlbl_action_2_mouseclicked"))
	 {return ((String) Debug.delegate(ba, "xlbl_action_2_mouseclicked", new Object[] {_eventdata}));}
RDebugUtils.currentLine=3801088;
 //BA.debugLineNum = 3801088;BA.debugLine="Private Sub xlbl_action_2_MouseClicked (EventData";
RDebugUtils.currentLine=3801090;
 //BA.debugLineNum = 3801090;BA.debugLine="result(xlbl_action_2.Tag)";
__ref._result(null,(int)(BA.ObjectToNumber(__ref._xlbl_action_2.getTag())));
RDebugUtils.currentLine=3801092;
 //BA.debugLineNum = 3801092;BA.debugLine="End Sub";
return "";
}
public String  _xlbl_action_3_mouseclicked(b4j.example.asmsgbox __ref,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "xlbl_action_3_mouseclicked"))
	 {return ((String) Debug.delegate(ba, "xlbl_action_3_mouseclicked", new Object[] {_eventdata}));}
RDebugUtils.currentLine=3866624;
 //BA.debugLineNum = 3866624;BA.debugLine="Private Sub xlbl_action_3_MouseClicked (EventData";
RDebugUtils.currentLine=3866626;
 //BA.debugLineNum = 3866626;BA.debugLine="result(xlbl_action_3.Tag)";
__ref._result(null,(int)(BA.ObjectToNumber(__ref._xlbl_action_3.getTag())));
RDebugUtils.currentLine=3866628;
 //BA.debugLineNum = 3866628;BA.debugLine="End Sub";
return "";
}
public String  _xpnl_close_mouseclicked(b4j.example.asmsgbox __ref,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "xpnl_close_mouseclicked"))
	 {return ((String) Debug.delegate(ba, "xpnl_close_mouseclicked", new Object[] {_eventdata}));}
RDebugUtils.currentLine=3407872;
 //BA.debugLineNum = 3407872;BA.debugLine="Private Sub xpnl_close_MouseClicked (EventData As";
RDebugUtils.currentLine=3407874;
 //BA.debugLineNum = 3407874;BA.debugLine="closebutton_handler(Sender)";
__ref._closebutton_handler(null,(anywheresoftware.b4j.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper(), (java.lang.Object)(__c.Sender(ba))));
RDebugUtils.currentLine=3407876;
 //BA.debugLineNum = 3407876;BA.debugLine="End Sub";
return "";
}
public boolean  _xpnl_content_touch(b4j.example.asmsgbox __ref,int _action,float _x,float _y) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "xpnl_content_touch"))
	 {return ((Boolean) Debug.delegate(ba, "xpnl_content_touch", new Object[] {_action,_x,_y}));}
RDebugUtils.currentLine=1966080;
 //BA.debugLineNum = 1966080;BA.debugLine="Private Sub xpnl_content_Touch(Action As Int, X As";
RDebugUtils.currentLine=1966083;
 //BA.debugLineNum = 1966083;BA.debugLine="If dragable = 2 Then";
if (__ref._dragable==2) { 
RDebugUtils.currentLine=1966085;
 //BA.debugLineNum = 1966085;BA.debugLine="If Action = xpnl_bottom.TOUCH_ACTION_DOWN Then";
if (_action==__ref._xpnl_bottom.TOUCH_ACTION_DOWN) { 
RDebugUtils.currentLine=1966087;
 //BA.debugLineNum = 1966087;BA.debugLine="donwx  = X";
__ref._donwx = (int) (_x);
RDebugUtils.currentLine=1966088;
 //BA.debugLineNum = 1966088;BA.debugLine="downy  = y";
__ref._downy = (int) (_y);
 }else 
{RDebugUtils.currentLine=1966090;
 //BA.debugLineNum = 1966090;BA.debugLine="Else if Action = xpnl_bottom.TOUCH_ACTION_MOVE T";
if (_action==__ref._xpnl_bottom.TOUCH_ACTION_MOVE) { 
RDebugUtils.currentLine=1966092;
 //BA.debugLineNum = 1966092;BA.debugLine="mBase.Top = mBase.Top + y - downy";
__ref._mbase.setTop(__ref._mbase.getTop()+_y-__ref._downy);
RDebugUtils.currentLine=1966093;
 //BA.debugLineNum = 1966093;BA.debugLine="mBase.Left = mBase.Left + x - donwx";
__ref._mbase.setLeft(__ref._mbase.getLeft()+_x-__ref._donwx);
 }}
;
 };
RDebugUtils.currentLine=1966102;
 //BA.debugLineNum = 1966102;BA.debugLine="Return True";
if (true) return __c.True;
RDebugUtils.currentLine=1966103;
 //BA.debugLineNum = 1966103;BA.debugLine="End Sub";
return false;
}
public boolean  _xpnl_header_touch(b4j.example.asmsgbox __ref,int _action,float _x,float _y) throws Exception{
__ref = this;
RDebugUtils.currentModule="asmsgbox";
if (Debug.shouldDelegate(ba, "xpnl_header_touch"))
	 {return ((Boolean) Debug.delegate(ba, "xpnl_header_touch", new Object[] {_action,_x,_y}));}
RDebugUtils.currentLine=1900544;
 //BA.debugLineNum = 1900544;BA.debugLine="Private Sub xpnl_header_Touch(Action As Int, X As";
RDebugUtils.currentLine=1900546;
 //BA.debugLineNum = 1900546;BA.debugLine="If dragable = 1 Then";
if (__ref._dragable==1) { 
RDebugUtils.currentLine=1900548;
 //BA.debugLineNum = 1900548;BA.debugLine="If Action = xpnl_bottom.TOUCH_ACTION_DOWN Then";
if (_action==__ref._xpnl_bottom.TOUCH_ACTION_DOWN) { 
RDebugUtils.currentLine=1900550;
 //BA.debugLineNum = 1900550;BA.debugLine="donwx  = X";
__ref._donwx = (int) (_x);
RDebugUtils.currentLine=1900551;
 //BA.debugLineNum = 1900551;BA.debugLine="downy  = y";
__ref._downy = (int) (_y);
 }else 
{RDebugUtils.currentLine=1900553;
 //BA.debugLineNum = 1900553;BA.debugLine="Else if Action = xpnl_bottom.TOUCH_ACTION_MOVE Th";
if (_action==__ref._xpnl_bottom.TOUCH_ACTION_MOVE) { 
RDebugUtils.currentLine=1900555;
 //BA.debugLineNum = 1900555;BA.debugLine="mBase.Top = mBase.Top + y - downy";
__ref._mbase.setTop(__ref._mbase.getTop()+_y-__ref._downy);
RDebugUtils.currentLine=1900556;
 //BA.debugLineNum = 1900556;BA.debugLine="mBase.Left = mBase.Left + x - donwx";
__ref._mbase.setLeft(__ref._mbase.getLeft()+_x-__ref._donwx);
 }}
;
 };
RDebugUtils.currentLine=1900566;
 //BA.debugLineNum = 1900566;BA.debugLine="Return True";
if (true) return __c.True;
RDebugUtils.currentLine=1900567;
 //BA.debugLineNum = 1900567;BA.debugLine="End Sub";
return false;
}
}