package as.msg.box;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.debug.*;

public class asmsgbox extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    private static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new BA(_ba, this, htSubs, "as.msg.box.asmsgbox");
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            
        }
        if (BA.isShellModeRuntimeCheck(ba)) 
			   this.getClass().getMethod("_class_globals", as.msg.box.asmsgbox.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 public anywheresoftware.b4a.keywords.Common __c = null;
public String _vvvvvvv0 = "";
public Object _vvvvvvvv1 = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _vvvvvvvv2 = null;
public anywheresoftware.b4a.objects.B4XViewWrapper.XUI _vvvvvvvv3 = null;
public int _back_color = 0;
public boolean _vvvvvvvv4 = false;
public int _header_clr = 0;
public int _bottom_crl = 0;
public boolean _vvvvvvvv5 = false;
public String _vvvvvvvv6 = "";
public int _border_width = 0;
public boolean _vvvvvvvv7 = false;
public boolean _vvvvvvvv0 = false;
public int _vvvvvvvvv1 = 0;
public String _vvvvvvvvv2 = "";
public anywheresoftware.b4a.objects.B4XViewWrapper _xpnl_close = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _xline_1 = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _xline_2 = null;
public anywheresoftware.b4a.objects.B4XViewWrapper.B4XFont _vvvvvvvvv3 = null;
public anywheresoftware.b4a.objects.LabelWrapper _lbl_header = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _xlbl_header = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _xpnl_header = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _xpnl_bottom = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _xiv_icon = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _xpnl_content = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _xlbl_action_1 = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _xlbl_action_2 = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _xlbl_action_3 = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _xpnl_actionground = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _xlbl_text = null;
public int _vvvvvvvvv4 = 0;
public int _vvvvvvvvv5 = 0;
public int _vvvvvvvvv6 = 0;
public String  _base_resize(double _width,double _height) throws Exception{
 //BA.debugLineNum = 290;BA.debugLine="Private Sub Base_Resize (Width As Double, Height A";
 //BA.debugLineNum = 292;BA.debugLine="mBase.SetColorAndBorder(back_color,0dip,xui.Color";
_vvvvvvvv2.SetColorAndBorder(_back_color,__c.DipToCurrent((int) (0)),_vvvvvvvv3.Color_Transparent,__c.DipToCurrent((int) (5)));
 //BA.debugLineNum = 295;BA.debugLine="xpnl_header.Visible = showHeader";
_xpnl_header.setVisible(_vvvvvvvv7);
 //BA.debugLineNum = 296;BA.debugLine="xpnl_bottom.Visible = showBottom";
_xpnl_bottom.setVisible(_vvvvvvvv0);
 //BA.debugLineNum = 298;BA.debugLine="xpnl_close.Visible = showX";
_xpnl_close.setVisible(_vvvvvvvv4);
 //BA.debugLineNum = 300;BA.debugLine="If showHeader = True Then";
if (_vvvvvvvv7==__c.True) { 
 //BA.debugLineNum = 303;BA.debugLine="xpnl_header.Width = mBase.Width";
_xpnl_header.setWidth(_vvvvvvvv2.getWidth());
 //BA.debugLineNum = 304;BA.debugLine="xline_1.Width = mBase.Width";
_xline_1.setWidth(_vvvvvvvv2.getWidth());
 //BA.debugLineNum = 306;BA.debugLine="xpnl_header.Color = header_clr";
_xpnl_header.setColor(_header_clr);
 //BA.debugLineNum = 307;BA.debugLine="xlbl_header.Height = MeasureTextHeight(xlbl_head";
_xlbl_header.setHeight((int) (_vvvv6(_xlbl_header.getText(),_xlbl_header.getFont())+__c.DipToCurrent((int) (8))));
 //BA.debugLineNum = 310;BA.debugLine="xpnl_content.Top = xpnl_header.Height";
_xpnl_content.setTop(_xpnl_header.getHeight());
 //BA.debugLineNum = 313;BA.debugLine="If iconVisible = True Then";
if (_vvvvvvvv5==__c.True) { 
 //BA.debugLineNum = 315;BA.debugLine="If iconDirection = \"LEFT\" Then";
if ((_vvvvvvvv6).equals("LEFT")) { 
 //BA.debugLineNum = 317;BA.debugLine="xiv_icon.Width = 40dip";
_xiv_icon.setWidth(__c.DipToCurrent((int) (40)));
 //BA.debugLineNum = 318;BA.debugLine="xiv_icon.Height = 40dip";
_xiv_icon.setHeight(__c.DipToCurrent((int) (40)));
 //BA.debugLineNum = 320;BA.debugLine="xlbl_header.Top = xpnl_header.Top + xpnl_header";
_xlbl_header.setTop((int) (_xpnl_header.getTop()+_xpnl_header.getHeight()/(double)2-_xlbl_header.getHeight()/(double)2));
 //BA.debugLineNum = 321;BA.debugLine="xlbl_header.Width =	MeasureTextWidth(xlbl_heade";
_xlbl_header.setWidth((int) (_vvvv7(_xlbl_header.getText(),_xlbl_header.getFont())+__c.DipToCurrent((int) (1))));
 //BA.debugLineNum = 322;BA.debugLine="xlbl_header.Left = xpnl_header.Width/2 - xlbl_h";
_xlbl_header.setLeft((int) (_xpnl_header.getWidth()/(double)2-_xlbl_header.getWidth()/(double)2));
 //BA.debugLineNum = 323;BA.debugLine="xiv_icon.Left = xlbl_header.Left - xiv_icon.Wid";
_xiv_icon.setLeft((int) (_xlbl_header.getLeft()-_xiv_icon.getWidth()-__c.DipToCurrent((int) (5))));
 //BA.debugLineNum = 324;BA.debugLine="xiv_icon.Top = xpnl_header.Top + xpnl_header.H";
_xiv_icon.setTop((int) (_xpnl_header.getTop()+_xpnl_header.getHeight()/(double)2-_xiv_icon.getHeight()/(double)2));
 }else if((_vvvvvvvv6).equals("MIDDLE")) { 
 //BA.debugLineNum = 328;BA.debugLine="xiv_icon.Width = 30dip";
_xiv_icon.setWidth(__c.DipToCurrent((int) (30)));
 //BA.debugLineNum = 329;BA.debugLine="xiv_icon.Height = 30dip";
_xiv_icon.setHeight(__c.DipToCurrent((int) (30)));
 //BA.debugLineNum = 331;BA.debugLine="xiv_icon.Top = 4dip";
_xiv_icon.setTop(__c.DipToCurrent((int) (4)));
 //BA.debugLineNum = 332;BA.debugLine="xiv_icon.Left = xpnl_header.Width/2 - xiv_icon.";
_xiv_icon.setLeft((int) (_xpnl_header.getWidth()/(double)2-_xiv_icon.getWidth()/(double)2));
 //BA.debugLineNum = 334;BA.debugLine="xlbl_header.Top = xiv_icon.Top + xiv_icon.Heig";
_xlbl_header.setTop((int) (_xiv_icon.getTop()+_xiv_icon.getHeight()-__c.DipToCurrent((int) (4))));
 //BA.debugLineNum = 335;BA.debugLine="xlbl_header.Width =	MeasureTextWidth(xlbl_heade";
_xlbl_header.setWidth((int) (_vvvv7(_xlbl_header.getText(),_xlbl_header.getFont())+__c.DipToCurrent((int) (1))));
 //BA.debugLineNum = 336;BA.debugLine="xlbl_header.Left = xpnl_header.Width/2 - xlbl_h";
_xlbl_header.setLeft((int) (_xpnl_header.getWidth()/(double)2-_xlbl_header.getWidth()/(double)2));
 }else if((_vvvvvvvv6).equals("RIGHT")) { 
 //BA.debugLineNum = 341;BA.debugLine="xlbl_header.Top = xpnl_header.Top + xpnl_header";
_xlbl_header.setTop((int) (_xpnl_header.getTop()+_xpnl_header.getHeight()/(double)2-_xlbl_header.getHeight()/(double)2));
 //BA.debugLineNum = 342;BA.debugLine="xlbl_header.Width =	MeasureTextWidth(xlbl_heade";
_xlbl_header.setWidth((int) (_vvvv7(_xlbl_header.getText(),_xlbl_header.getFont())+__c.DipToCurrent((int) (1))));
 //BA.debugLineNum = 343;BA.debugLine="xlbl_header.Left = xpnl_header.Width/2 - xlbl_h";
_xlbl_header.setLeft((int) (_xpnl_header.getWidth()/(double)2-_xlbl_header.getWidth()/(double)2));
 //BA.debugLineNum = 344;BA.debugLine="xiv_icon.Left = xlbl_header.Left + xlbl_header.";
_xiv_icon.setLeft((int) (_xlbl_header.getLeft()+_xlbl_header.getWidth()+__c.DipToCurrent((int) (5))));
 //BA.debugLineNum = 345;BA.debugLine="xiv_icon.Top = xpnl_header.Top + xpnl_header.H";
_xiv_icon.setTop((int) (_xpnl_header.getTop()+_xpnl_header.getHeight()/(double)2-_xiv_icon.getHeight()/(double)2));
 };
 }else {
 //BA.debugLineNum = 351;BA.debugLine="xiv_icon.Width = 40dip";
_xiv_icon.setWidth(__c.DipToCurrent((int) (40)));
 //BA.debugLineNum = 352;BA.debugLine="xiv_icon.Height = 40dip";
_xiv_icon.setHeight(__c.DipToCurrent((int) (40)));
 //BA.debugLineNum = 354;BA.debugLine="xlbl_header.Top = xpnl_header.Top + xpnl_header.";
_xlbl_header.setTop((int) (_xpnl_header.getTop()+_xpnl_header.getHeight()/(double)2-_xlbl_header.getHeight()/(double)2));
 //BA.debugLineNum = 355;BA.debugLine="xlbl_header.Left = xpnl_header.Left + 5dip";
_xlbl_header.setLeft((int) (_xpnl_header.getLeft()+__c.DipToCurrent((int) (5))));
 //BA.debugLineNum = 356;BA.debugLine="xlbl_header.Width = xpnl_header.Width - 5dip";
_xlbl_header.setWidth((int) (_xpnl_header.getWidth()-__c.DipToCurrent((int) (5))));
 };
 }else {
 //BA.debugLineNum = 362;BA.debugLine="xpnl_content.Top = 0";
_xpnl_content.setTop((int) (0));
 };
 //BA.debugLineNum = 366;BA.debugLine="If showBottom = True Then";
if (_vvvvvvvv0==__c.True) { 
 //BA.debugLineNum = 368;BA.debugLine="xpnl_bottom.Color = bottom_crl";
_xpnl_bottom.setColor(_bottom_crl);
 //BA.debugLineNum = 370;BA.debugLine="xpnl_bottom.Top = mBase.Height - 50dip";
_xpnl_bottom.setTop((int) (_vvvvvvvv2.getHeight()-__c.DipToCurrent((int) (50))));
 //BA.debugLineNum = 371;BA.debugLine="xpnl_bottom.Width = mBase.Width";
_xpnl_bottom.setWidth(_vvvvvvvv2.getWidth());
 //BA.debugLineNum = 372;BA.debugLine="xline_2.Width = mBase.Width";
_xline_2.setWidth(_vvvvvvvv2.getWidth());
 //BA.debugLineNum = 376;BA.debugLine="xpnl_actionground.Width = xpnl_bottom.Width - 10";
_xpnl_actionground.setWidth((int) (_xpnl_bottom.getWidth()-__c.DipToCurrent((int) (10))));
 //BA.debugLineNum = 379;BA.debugLine="xpnl_content.Height = mBase.Height - xpnl_conten";
_xpnl_content.setHeight((int) (_vvvvvvvv2.getHeight()-_xpnl_content.getTop()-_xpnl_bottom.getHeight()));
 }else {
 //BA.debugLineNum = 384;BA.debugLine="xpnl_content.Height = mBase.Height - xpnl_conten";
_xpnl_content.setHeight((int) (_vvvvvvvv2.getHeight()-_xpnl_content.getTop()));
 };
 //BA.debugLineNum = 388;BA.debugLine="xlbl_action_1.Left = 0";
_xlbl_action_1.setLeft((int) (0));
 //BA.debugLineNum = 389;BA.debugLine="xlbl_action_1.Width = xpnl_actionground.Width/3 -";
_xlbl_action_1.setWidth((int) (_xpnl_actionground.getWidth()/(double)3-__c.DipToCurrent((int) (5))));
 //BA.debugLineNum = 391;BA.debugLine="xlbl_action_2.Left = xlbl_action_1.Left + xlbl_ac";
_xlbl_action_2.setLeft((int) (_xlbl_action_1.getLeft()+_xlbl_action_1.getWidth()+__c.DipToCurrent((int) (5))));
 //BA.debugLineNum = 392;BA.debugLine="xlbl_action_2.Width = xpnl_actionground.Width/3 '";
_xlbl_action_2.setWidth((int) (_xpnl_actionground.getWidth()/(double)3));
 //BA.debugLineNum = 394;BA.debugLine="xlbl_action_3.Left = xlbl_action_2.Left + xlbl_ac";
_xlbl_action_3.setLeft((int) (_xlbl_action_2.getLeft()+_xlbl_action_2.getWidth()+__c.DipToCurrent((int) (5))));
 //BA.debugLineNum = 395;BA.debugLine="xlbl_action_3.Width = xpnl_actionground.Width/3 -";
_xlbl_action_3.setWidth((int) (_xpnl_actionground.getWidth()/(double)3-__c.DipToCurrent((int) (5))));
 //BA.debugLineNum = 397;BA.debugLine="End Sub";
return "";
}
public String  _v5(anywheresoftware.b4a.objects.B4XViewWrapper _parent) throws Exception{
 //BA.debugLineNum = 775;BA.debugLine="Public Sub CenterDialog(Parent As B4XView)";
 //BA.debugLineNum = 777;BA.debugLine="mBase.Left = Parent.Width/2 - mBase.Width/2";
_vvvvvvvv2.setLeft((int) (_parent.getWidth()/(double)2-_vvvvvvvv2.getWidth()/(double)2));
 //BA.debugLineNum = 778;BA.debugLine="mBase.Top = 0 + Parent.Height/2  - mBase.Height/2";
_vvvvvvvv2.setTop((int) (0+_parent.getHeight()/(double)2-_vvvvvvvv2.getHeight()/(double)2));
 //BA.debugLineNum = 780;BA.debugLine="End Sub";
return "";
}
public String  _class_globals() throws Exception{
 //BA.debugLineNum = 41;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 42;BA.debugLine="Private mEventName As String 'ignore";
_vvvvvvv0 = "";
 //BA.debugLineNum = 43;BA.debugLine="Private mCallBack As Object 'ignore";
_vvvvvvvv1 = new Object();
 //BA.debugLineNum = 44;BA.debugLine="Private mBase As B4XView 'ignore";
_vvvvvvvv2 = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 45;BA.debugLine="Private xui As XUI 'ignore";
_vvvvvvvv3 = new anywheresoftware.b4a.objects.B4XViewWrapper.XUI();
 //BA.debugLineNum = 49;BA.debugLine="Private back_color As Int";
_back_color = 0;
 //BA.debugLineNum = 50;BA.debugLine="Private showX As Boolean";
_vvvvvvvv4 = false;
 //BA.debugLineNum = 51;BA.debugLine="Private header_clr As Int";
_header_clr = 0;
 //BA.debugLineNum = 52;BA.debugLine="Private bottom_crl As Int";
_bottom_crl = 0;
 //BA.debugLineNum = 54;BA.debugLine="Private iconVisible As Boolean";
_vvvvvvvv5 = false;
 //BA.debugLineNum = 55;BA.debugLine="Private iconDirection As String";
_vvvvvvvv6 = "";
 //BA.debugLineNum = 56;BA.debugLine="Private border_width As Int";
_border_width = 0;
 //BA.debugLineNum = 58;BA.debugLine="Private showHeader As Boolean";
_vvvvvvvv7 = false;
 //BA.debugLineNum = 59;BA.debugLine="Private showBottom As Boolean";
_vvvvvvvv0 = false;
 //BA.debugLineNum = 61;BA.debugLine="Private headerFontSize As Int";
_vvvvvvvvv1 = 0;
 //BA.debugLineNum = 62;BA.debugLine="Private headerText As String";
_vvvvvvvvv2 = "";
 //BA.debugLineNum = 64;BA.debugLine="Private xpnl_close As B4XView";
_xpnl_close = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 66;BA.debugLine="Private xline_1,xline_2 As B4XView";
_xline_1 = new anywheresoftware.b4a.objects.B4XViewWrapper();
_xline_2 = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 68;BA.debugLine="Private xIconFont As B4XFont";
_vvvvvvvvv3 = new anywheresoftware.b4a.objects.B4XViewWrapper.B4XFont();
 //BA.debugLineNum = 74;BA.debugLine="Private lbl_header As Label";
_lbl_header = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 75;BA.debugLine="Private xlbl_header As B4XView";
_xlbl_header = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 76;BA.debugLine="Private xpnl_header As B4XView";
_xpnl_header = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 77;BA.debugLine="Private xpnl_bottom As B4XView";
_xpnl_bottom = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 78;BA.debugLine="Private xiv_icon As B4XView";
_xiv_icon = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 79;BA.debugLine="Private xpnl_content As B4XView";
_xpnl_content = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 80;BA.debugLine="Private xlbl_action_1,xlbl_action_2,xlbl_action_3";
_xlbl_action_1 = new anywheresoftware.b4a.objects.B4XViewWrapper();
_xlbl_action_2 = new anywheresoftware.b4a.objects.B4XViewWrapper();
_xlbl_action_3 = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 81;BA.debugLine="Private xpnl_actionground As B4XView";
_xpnl_actionground = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 82;BA.debugLine="Private xlbl_text As B4XView";
_xlbl_text = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 85;BA.debugLine="Private dragable As Int = 0";
_vvvvvvvvv4 = (int) (0);
 //BA.debugLineNum = 86;BA.debugLine="Private donwx As Int";
_vvvvvvvvv5 = 0;
 //BA.debugLineNum = 87;BA.debugLine="Private downy As Int";
_vvvvvvvvv6 = 0;
 //BA.debugLineNum = 93;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4a.keywords.Common.ResumableSubWrapper  _v6(boolean _animated) throws Exception{
ResumableSub_Close rsub = new ResumableSub_Close(this,_animated);
rsub.resume(ba, null);
return (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), rsub);
}
public static class ResumableSub_Close extends BA.ResumableSub {
public ResumableSub_Close(as.msg.box.asmsgbox parent,boolean _animated) {
this.parent = parent;
this._animated = _animated;
}
as.msg.box.asmsgbox parent;
boolean _animated;

@Override
public void resume(BA ba, Object[] result) throws Exception{

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.ReturnFromResumableSub(this,null);return;}
case 0:
//C
this.state = 1;
 //BA.debugLineNum = 277;BA.debugLine="If mBase.IsInitialized And mBase.Parent.IsInitial";
if (true) break;

case 1:
//if
this.state = 10;
if (parent._vvvvvvvv2.IsInitialized() && parent._vvvvvvvv2.getParent().IsInitialized()) { 
this.state = 3;
}if (true) break;

case 3:
//C
this.state = 4;
 //BA.debugLineNum = 278;BA.debugLine="If animated = True Then";
if (true) break;

case 4:
//if
this.state = 9;
if (_animated==parent.__c.True) { 
this.state = 6;
}else if(_animated==parent.__c.False) { 
this.state = 8;
}if (true) break;

case 6:
//C
this.state = 9;
 //BA.debugLineNum = 279;BA.debugLine="mBase.SetVisibleAnimated(300,False)";
parent._vvvvvvvv2.SetVisibleAnimated((int) (300),parent.__c.False);
 if (true) break;

case 8:
//C
this.state = 9;
 //BA.debugLineNum = 281;BA.debugLine="mBase.Visible = False";
parent._vvvvvvvv2.setVisible(parent.__c.False);
 if (true) break;

case 9:
//C
this.state = 10;
;
 //BA.debugLineNum = 284;BA.debugLine="Return True";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.True));return;};
 if (true) break;

case 10:
//C
this.state = -1;
;
 //BA.debugLineNum = 286;BA.debugLine="Return False";
if (true) {
parent.__c.ReturnFromResumableSub(this,(Object)(parent.__c.False));return;};
 //BA.debugLineNum = 288;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public String  _closebutton_handler(anywheresoftware.b4a.objects.B4XViewWrapper _senderpanel) throws Exception{
 //BA.debugLineNum = 863;BA.debugLine="Private Sub closebutton_handler(SenderPanel As B4X";
 //BA.debugLineNum = 865;BA.debugLine="mBase.Visible = False";
_vvvvvvvv2.setVisible(__c.False);
 //BA.debugLineNum = 867;BA.debugLine="End Sub";
return "";
}
public String  _create_bottom() throws Exception{
anywheresoftware.b4a.objects.LabelWrapper _lbl_action_1 = null;
anywheresoftware.b4a.objects.LabelWrapper _lbl_action_2 = null;
anywheresoftware.b4a.objects.LabelWrapper _lbl_action_3 = null;
 //BA.debugLineNum = 465;BA.debugLine="Private Sub create_bottom";
 //BA.debugLineNum = 468;BA.debugLine="xpnl_bottom = xui.CreatePanel(\"\")";
_xpnl_bottom = _vvvvvvvv3.CreatePanel(ba,"");
 //BA.debugLineNum = 469;BA.debugLine="mBase.AddView(xpnl_bottom,0,mBase.Height - 50dip,";
_vvvvvvvv2.AddView((android.view.View)(_xpnl_bottom.getObject()),(int) (0),(int) (_vvvvvvvv2.getHeight()-__c.DipToCurrent((int) (50))),_vvvvvvvv2.getWidth(),__c.DipToCurrent((int) (50)));
 //BA.debugLineNum = 470;BA.debugLine="xpnl_bottom.Color = xui.Color_Red";
_xpnl_bottom.setColor(_vvvvvvvv3.Color_Red);
 //BA.debugLineNum = 471;BA.debugLine="xpnl_bottom.SetColorAndBorder(xui.Color_Red,0,xui";
_xpnl_bottom.SetColorAndBorder(_vvvvvvvv3.Color_Red,(int) (0),_vvvvvvvv3.Color_Transparent,__c.DipToCurrent((int) (5)));
 //BA.debugLineNum = 474;BA.debugLine="xline_2 = xui.CreatePanel(\"\")";
_xline_2 = _vvvvvvvv3.CreatePanel(ba,"");
 //BA.debugLineNum = 475;BA.debugLine="xpnl_bottom.AddView(xline_2,0dip,0dip,xpnl_bottom";
_xpnl_bottom.AddView((android.view.View)(_xline_2.getObject()),__c.DipToCurrent((int) (0)),__c.DipToCurrent((int) (0)),_xpnl_bottom.getWidth(),__c.DipToCurrent((int) (2)));
 //BA.debugLineNum = 476;BA.debugLine="xline_2.Color = xui.Color_White";
_xline_2.setColor(_vvvvvvvv3.Color_White);
 //BA.debugLineNum = 477;BA.debugLine="MakeViewBackgroundTransparent(xline_2,100)";
_vvvv5(_xline_2,(int) (100));
 //BA.debugLineNum = 481;BA.debugLine="xpnl_actionground = xui.CreatePanel(\"\")";
_xpnl_actionground = _vvvvvvvv3.CreatePanel(ba,"");
 //BA.debugLineNum = 482;BA.debugLine="xpnl_bottom.AddView(xpnl_actionground,5dip,5dip,x";
_xpnl_bottom.AddView((android.view.View)(_xpnl_actionground.getObject()),__c.DipToCurrent((int) (5)),__c.DipToCurrent((int) (5)),(int) (_xpnl_bottom.getWidth()-__c.DipToCurrent((int) (5))),(int) (_xpnl_bottom.getHeight()-__c.DipToCurrent((int) (10))));
 //BA.debugLineNum = 486;BA.debugLine="Dim lbl_action_1,lbl_action_2,lbl_action_3 As Lab";
_lbl_action_1 = new anywheresoftware.b4a.objects.LabelWrapper();
_lbl_action_2 = new anywheresoftware.b4a.objects.LabelWrapper();
_lbl_action_3 = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 487;BA.debugLine="lbl_action_1.Initialize(\"xlbl_action_1\")";
_lbl_action_1.Initialize(ba,"xlbl_action_1");
 //BA.debugLineNum = 488;BA.debugLine="lbl_action_2.Initialize(\"xlbl_action_2\")";
_lbl_action_2.Initialize(ba,"xlbl_action_2");
 //BA.debugLineNum = 489;BA.debugLine="lbl_action_3.Initialize(\"xlbl_action_3\")";
_lbl_action_3.Initialize(ba,"xlbl_action_3");
 //BA.debugLineNum = 491;BA.debugLine="xlbl_action_1 = lbl_action_1";
_xlbl_action_1.setObject((java.lang.Object)(_lbl_action_1.getObject()));
 //BA.debugLineNum = 492;BA.debugLine="xlbl_action_2 = lbl_action_2";
_xlbl_action_2.setObject((java.lang.Object)(_lbl_action_2.getObject()));
 //BA.debugLineNum = 493;BA.debugLine="xlbl_action_3 = lbl_action_3";
_xlbl_action_3.setObject((java.lang.Object)(_lbl_action_3.getObject()));
 //BA.debugLineNum = 495;BA.debugLine="xlbl_action_1.Tag = getCANCEL";
_xlbl_action_1.setTag((Object)(_getvvvvvv5()));
 //BA.debugLineNum = 496;BA.debugLine="xlbl_action_2.Tag = getNEGATIVE";
_xlbl_action_2.setTag((Object)(_getvvvvvvv6()));
 //BA.debugLineNum = 497;BA.debugLine="xlbl_action_3.Tag = getPOSITIVE";
_xlbl_action_3.setTag((Object)(_getvvvvvvv7()));
 //BA.debugLineNum = 499;BA.debugLine="xpnl_actionground.AddView(xlbl_action_1,0,0,0 ,xp";
_xpnl_actionground.AddView((android.view.View)(_xlbl_action_1.getObject()),(int) (0),(int) (0),(int) (0),_xpnl_actionground.getHeight());
 //BA.debugLineNum = 500;BA.debugLine="xpnl_actionground.AddView(xlbl_action_2,xlbl_acti";
_xpnl_actionground.AddView((android.view.View)(_xlbl_action_2.getObject()),(int) (_xlbl_action_1.getLeft()+_xlbl_action_1.getWidth()+__c.DipToCurrent((int) (5))),(int) (0),(int) (0),_xpnl_actionground.getHeight());
 //BA.debugLineNum = 501;BA.debugLine="xpnl_actionground.AddView(xlbl_action_3,xlbl_acti";
_xpnl_actionground.AddView((android.view.View)(_xlbl_action_3.getObject()),(int) (_xlbl_action_2.getLeft()+_xlbl_action_2.getWidth()+__c.DipToCurrent((int) (5))),(int) (0),(int) (0),_xpnl_actionground.getHeight());
 //BA.debugLineNum = 503;BA.debugLine="xlbl_action_1.Font = xui.CreateDefaultBoldFont(15";
_xlbl_action_1.setFont(_vvvvvvvv3.CreateDefaultBoldFont((float) (15)));
 //BA.debugLineNum = 504;BA.debugLine="xlbl_action_2.Font = xui.CreateDefaultBoldFont(15";
_xlbl_action_2.setFont(_vvvvvvvv3.CreateDefaultBoldFont((float) (15)));
 //BA.debugLineNum = 505;BA.debugLine="xlbl_action_3.Font = xui.CreateDefaultBoldFont(15";
_xlbl_action_3.setFont(_vvvvvvvv3.CreateDefaultBoldFont((float) (15)));
 //BA.debugLineNum = 507;BA.debugLine="xlbl_action_1.TextColor = xui.Color_White";
_xlbl_action_1.setTextColor(_vvvvvvvv3.Color_White);
 //BA.debugLineNum = 508;BA.debugLine="xlbl_action_2.TextColor = xui.Color_White";
_xlbl_action_2.setTextColor(_vvvvvvvv3.Color_White);
 //BA.debugLineNum = 509;BA.debugLine="xlbl_action_3.TextColor = xui.Color_White";
_xlbl_action_3.setTextColor(_vvvvvvvv3.Color_White);
 //BA.debugLineNum = 511;BA.debugLine="xlbl_action_1.SetTextAlignment(\"CENTER\",\"CENTER\")";
_xlbl_action_1.SetTextAlignment("CENTER","CENTER");
 //BA.debugLineNum = 512;BA.debugLine="xlbl_action_2.SetTextAlignment(\"CENTER\",\"CENTER\")";
_xlbl_action_2.SetTextAlignment("CENTER","CENTER");
 //BA.debugLineNum = 513;BA.debugLine="xlbl_action_3.SetTextAlignment(\"CENTER\",\"CENTER\")";
_xlbl_action_3.SetTextAlignment("CENTER","CENTER");
 //BA.debugLineNum = 515;BA.debugLine="End Sub";
return "";
}
public String  _create_top() throws Exception{
anywheresoftware.b4a.agraham.reflection.Reflection _r = null;
anywheresoftware.b4a.objects.LabelWrapper _lbl_close = null;
anywheresoftware.b4a.objects.ImageViewWrapper _iv_icon = null;
 //BA.debugLineNum = 402;BA.debugLine="Private Sub create_top";
 //BA.debugLineNum = 405;BA.debugLine="xpnl_header = xui.CreatePanel(\"xpnl_header\")";
_xpnl_header = _vvvvvvvv3.CreatePanel(ba,"xpnl_header");
 //BA.debugLineNum = 406;BA.debugLine="mBase.AddView(xpnl_header,0,0,mBase.Width,60dip)";
_vvvvvvvv2.AddView((android.view.View)(_xpnl_header.getObject()),(int) (0),(int) (0),_vvvvvvvv2.getWidth(),__c.DipToCurrent((int) (60)));
 //BA.debugLineNum = 407;BA.debugLine="xpnl_header.Color = xui.Color_Red";
_xpnl_header.setColor(_vvvvvvvv3.Color_Red);
 //BA.debugLineNum = 408;BA.debugLine="xpnl_header.SetColorAndBorder(xui.Color_Red,0,xui";
_xpnl_header.SetColorAndBorder(_vvvvvvvv3.Color_Red,(int) (0),_vvvvvvvv3.Color_Transparent,__c.DipToCurrent((int) (5)));
 //BA.debugLineNum = 412;BA.debugLine="Private r As Reflector";
_r = new anywheresoftware.b4a.agraham.reflection.Reflection();
 //BA.debugLineNum = 413;BA.debugLine="r.Target = xpnl_header";
_r.Target = (Object)(_xpnl_header.getObject());
 //BA.debugLineNum = 414;BA.debugLine="r.SetOnTouchListener(\"xpnl_header_Touch2\")";
_r.SetOnTouchListener(ba,"xpnl_header_Touch2");
 //BA.debugLineNum = 418;BA.debugLine="xline_1 = xui.CreatePanel(\"\")";
_xline_1 = _vvvvvvvv3.CreatePanel(ba,"");
 //BA.debugLineNum = 419;BA.debugLine="xpnl_header.AddView(xline_1,0dip,xpnl_header.Heig";
_xpnl_header.AddView((android.view.View)(_xline_1.getObject()),__c.DipToCurrent((int) (0)),(int) (_xpnl_header.getHeight()-__c.DipToCurrent((int) (2))),_xpnl_header.getWidth(),__c.DipToCurrent((int) (2)));
 //BA.debugLineNum = 420;BA.debugLine="xline_1.Color = xui.Color_White";
_xline_1.setColor(_vvvvvvvv3.Color_White);
 //BA.debugLineNum = 421;BA.debugLine="MakeViewBackgroundTransparent(xline_1,100)";
_vvvv5(_xline_1,(int) (100));
 //BA.debugLineNum = 424;BA.debugLine="Private lbl_close As Label";
_lbl_close = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 425;BA.debugLine="lbl_close.Initialize(\"xpnl_close\")";
_lbl_close.Initialize(ba,"xpnl_close");
 //BA.debugLineNum = 426;BA.debugLine="xpnl_close = lbl_close";
_xpnl_close.setObject((java.lang.Object)(_lbl_close.getObject()));
 //BA.debugLineNum = 427;BA.debugLine="mBase.AddView(xpnl_close, mBase.Width - 5dip - 20";
_vvvvvvvv2.AddView((android.view.View)(_xpnl_close.getObject()),(int) (_vvvvvvvv2.getWidth()-__c.DipToCurrent((int) (5))-__c.DipToCurrent((int) (20))),__c.DipToCurrent((int) (2)),__c.DipToCurrent((int) (20)),__c.DipToCurrent((int) (20)));
 //BA.debugLineNum = 431;BA.debugLine="xIconFont = xui.CreateFont(Typeface.CreateNew(Typ";
_vvvvvvvvv3 = _vvvvvvvv3.CreateFont(__c.Typeface.CreateNew(__c.Typeface.getFONTAWESOME(),__c.Typeface.STYLE_NORMAL),(float) (23));
 //BA.debugLineNum = 440;BA.debugLine="xpnl_close.Font = xIconFont";
_xpnl_close.setFont(_vvvvvvvvv3);
 //BA.debugLineNum = 441;BA.debugLine="xpnl_close.TextColor = xui.Color_White";
_xpnl_close.setTextColor(_vvvvvvvv3.Color_White);
 //BA.debugLineNum = 442;BA.debugLine="xpnl_close.Text = Chr(0xF00D)";
_xpnl_close.setText(BA.ObjectToCharSequence(__c.Chr((int) (0xf00d))));
 //BA.debugLineNum = 446;BA.debugLine="Private iv_icon As ImageView";
_iv_icon = new anywheresoftware.b4a.objects.ImageViewWrapper();
 //BA.debugLineNum = 447;BA.debugLine="iv_icon.Initialize(\"xiv_icon\")";
_iv_icon.Initialize(ba,"xiv_icon");
 //BA.debugLineNum = 449;BA.debugLine="xiv_icon = iv_icon";
_xiv_icon.setObject((java.lang.Object)(_iv_icon.getObject()));
 //BA.debugLineNum = 450;BA.debugLine="xpnl_header.AddView(xiv_icon,5dip,0,40dip,40dip)";
_xpnl_header.AddView((android.view.View)(_xiv_icon.getObject()),__c.DipToCurrent((int) (5)),(int) (0),__c.DipToCurrent((int) (40)),__c.DipToCurrent((int) (40)));
 //BA.debugLineNum = 454;BA.debugLine="lbl_header.Initialize(\"\")";
_lbl_header.Initialize(ba,"");
 //BA.debugLineNum = 455;BA.debugLine="xlbl_header = lbl_header";
_xlbl_header.setObject((java.lang.Object)(_lbl_header.getObject()));
 //BA.debugLineNum = 457;BA.debugLine="xpnl_header.AddView(xlbl_header,5dip,5dip,xpnl_he";
_xpnl_header.AddView((android.view.View)(_xlbl_header.getObject()),__c.DipToCurrent((int) (5)),__c.DipToCurrent((int) (5)),(int) (_xpnl_header.getWidth()-__c.DipToCurrent((int) (5))),__c.DipToCurrent((int) (20)));
 //BA.debugLineNum = 458;BA.debugLine="xlbl_header.TextColor = xui.Color_White";
_xlbl_header.setTextColor(_vvvvvvvv3.Color_White);
 //BA.debugLineNum = 459;BA.debugLine="xlbl_header.Font = xui.CreateDefaultBoldFont(head";
_xlbl_header.setFont(_vvvvvvvv3.CreateDefaultBoldFont((float) (_vvvvvvvvv1)));
 //BA.debugLineNum = 460;BA.debugLine="xlbl_header.SetTextAlignment(\"CENTER\",\"CENTER\")";
_xlbl_header.SetTextAlignment("CENTER","CENTER");
 //BA.debugLineNum = 461;BA.debugLine="xlbl_header.Text = headerText";
_xlbl_header.setText(BA.ObjectToCharSequence(_vvvvvvvvv2));
 //BA.debugLineNum = 463;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4a.objects.B4XViewWrapper.B4XBitmapWrapper  _v7(anywheresoftware.b4a.objects.B4XViewWrapper.B4XBitmapWrapper _input,int _size) throws Exception{
int _l = 0;
anywheresoftware.b4a.objects.B4XCanvas _c = null;
anywheresoftware.b4a.objects.B4XViewWrapper _xview = null;
anywheresoftware.b4a.objects.B4XCanvas.B4XPath _path = null;
anywheresoftware.b4a.objects.B4XViewWrapper.B4XBitmapWrapper _res = null;
 //BA.debugLineNum = 1003;BA.debugLine="Sub CreateRoundBitmap (Input As B4XBitmap, Size As";
 //BA.debugLineNum = 1004;BA.debugLine="If Input.Width <> Input.Height Then";
if (_input.getWidth()!=_input.getHeight()) { 
 //BA.debugLineNum = 1006;BA.debugLine="Dim l As Int = Min(Input.Width, Input.Height)";
_l = (int) (__c.Min(_input.getWidth(),_input.getHeight()));
 //BA.debugLineNum = 1007;BA.debugLine="Input = Input.Crop(Input.Width / 2 - l / 2, Inpu";
_input = _input.Crop((int) (_input.getWidth()/(double)2-_l/(double)2),(int) (_input.getHeight()/(double)2-_l/(double)2),_l,_l);
 };
 //BA.debugLineNum = 1009;BA.debugLine="Dim c As B4XCanvas";
_c = new anywheresoftware.b4a.objects.B4XCanvas();
 //BA.debugLineNum = 1010;BA.debugLine="Dim xview As B4XView = xui.CreatePanel(\"\")";
_xview = new anywheresoftware.b4a.objects.B4XViewWrapper();
_xview = _vvvvvvvv3.CreatePanel(ba,"");
 //BA.debugLineNum = 1011;BA.debugLine="xview.SetLayoutAnimated(0, 0, 0, Size, Size)";
_xview.SetLayoutAnimated((int) (0),(int) (0),(int) (0),_size,_size);
 //BA.debugLineNum = 1012;BA.debugLine="c.Initialize(xview)";
_c.Initialize(_xview);
 //BA.debugLineNum = 1013;BA.debugLine="Dim path As B4XPath";
_path = new anywheresoftware.b4a.objects.B4XCanvas.B4XPath();
 //BA.debugLineNum = 1014;BA.debugLine="path.InitializeOval(c.TargetRect)";
_path.InitializeOval(_c.getTargetRect());
 //BA.debugLineNum = 1015;BA.debugLine="c.ClipPath(path)";
_c.ClipPath(_path);
 //BA.debugLineNum = 1016;BA.debugLine="c.DrawBitmap(Input.Resize(Size, Size, False), c.T";
_c.DrawBitmap((android.graphics.Bitmap)(_input.Resize(_size,_size,__c.False).getObject()),_c.getTargetRect());
 //BA.debugLineNum = 1017;BA.debugLine="c.RemoveClip";
_c.RemoveClip();
 //BA.debugLineNum = 1019;BA.debugLine="If border_width > 0 Then";
if (_border_width>0) { 
 //BA.debugLineNum = 1020;BA.debugLine="c.DrawCircle(c.TargetRect.CenterX, c.TargetRect.C";
_c.DrawCircle(_c.getTargetRect().getCenterX(),_c.getTargetRect().getCenterY(),(float) (_c.getTargetRect().getWidth()/(double)2-__c.DipToCurrent((int) (2))),_vvvvvvvv3.Color_White,__c.False,(float) (_border_width));
 };
 //BA.debugLineNum = 1022;BA.debugLine="c.Invalidate";
_c.Invalidate();
 //BA.debugLineNum = 1023;BA.debugLine="Dim res As B4XBitmap = c.CreateBitmap";
_res = new anywheresoftware.b4a.objects.B4XViewWrapper.B4XBitmapWrapper();
_res = _c.CreateBitmap();
 //BA.debugLineNum = 1024;BA.debugLine="c.Release";
_c.Release();
 //BA.debugLineNum = 1025;BA.debugLine="Return res";
if (true) return _res;
 //BA.debugLineNum = 1026;BA.debugLine="End Sub";
return null;
}
public String  _designercreateview(Object _base,anywheresoftware.b4a.objects.LabelWrapper _lbl,anywheresoftware.b4a.objects.collections.Map _props) throws Exception{
anywheresoftware.b4a.agraham.reflection.Reflection _r = null;
anywheresoftware.b4a.objects.LabelWrapper _lbl_text = null;
 //BA.debugLineNum = 192;BA.debugLine="Public Sub DesignerCreateView (Base As Object, lbl";
 //BA.debugLineNum = 193;BA.debugLine="mBase = Base";
_vvvvvvvv2.setObject((java.lang.Object)(_base));
 //BA.debugLineNum = 195;BA.debugLine="back_color = xui.PaintOrColorToColor(Props.Get(";
_back_color = _vvvvvvvv3.PaintOrColorToColor(_props.Get((Object)("Back_Color")));
 //BA.debugLineNum = 196;BA.debugLine="showX = Props.Get(\"Show_X\")";
_vvvvvvvv4 = BA.ObjectToBoolean(_props.Get((Object)("Show_X")));
 //BA.debugLineNum = 197;BA.debugLine="header_clr = xui.PaintOrColorToColor(Props.Get(\"H";
_header_clr = _vvvvvvvv3.PaintOrColorToColor(_props.Get((Object)("Header_CLR")));
 //BA.debugLineNum = 198;BA.debugLine="bottom_crl = xui.PaintOrColorToColor(Props.Get(\"B";
_bottom_crl = _vvvvvvvv3.PaintOrColorToColor(_props.Get((Object)("Bottom_CLR")));
 //BA.debugLineNum = 200;BA.debugLine="iconVisible = Props.Get(\"Icon_visible\")";
_vvvvvvvv5 = BA.ObjectToBoolean(_props.Get((Object)("Icon_visible")));
 //BA.debugLineNum = 201;BA.debugLine="iconDirection = Props.Get(\"Icon_direction\")";
_vvvvvvvv6 = BA.ObjectToString(_props.Get((Object)("Icon_direction")));
 //BA.debugLineNum = 202;BA.debugLine="border_width = DipToCurrent(Props.Get(\"BorderWidt";
_border_width = __c.DipToCurrent((int)(BA.ObjectToNumber(_props.Get((Object)("BorderWidth")))));
 //BA.debugLineNum = 204;BA.debugLine="showHeader = Props.Get(\"show_header\")";
_vvvvvvvv7 = BA.ObjectToBoolean(_props.Get((Object)("show_header")));
 //BA.debugLineNum = 205;BA.debugLine="showBottom = Props.Get(\"show_bottom\")";
_vvvvvvvv0 = BA.ObjectToBoolean(_props.Get((Object)("show_bottom")));
 //BA.debugLineNum = 207;BA.debugLine="headerFontSize = Props.Get(\"header_font_size\")";
_vvvvvvvvv1 = (int)(BA.ObjectToNumber(_props.Get((Object)("header_font_size"))));
 //BA.debugLineNum = 209;BA.debugLine="headerText = Props.Get(\"Header_Text\")";
_vvvvvvvvv2 = BA.ObjectToString(_props.Get((Object)("Header_Text")));
 //BA.debugLineNum = 211;BA.debugLine="create_top";
_create_top();
 //BA.debugLineNum = 212;BA.debugLine="create_bottom";
_create_bottom();
 //BA.debugLineNum = 214;BA.debugLine="xpnl_content = xui.CreatePanel(\"xpnl_content\")";
_xpnl_content = _vvvvvvvv3.CreatePanel(ba,"xpnl_content");
 //BA.debugLineNum = 215;BA.debugLine="mBase.AddView(xpnl_content,0,xpnl_header.Height,m";
_vvvvvvvv2.AddView((android.view.View)(_xpnl_content.getObject()),(int) (0),_xpnl_header.getHeight(),_vvvvvvvv2.getWidth(),(int) (_xpnl_bottom.getTop()-_xpnl_header.getHeight()));
 //BA.debugLineNum = 216;BA.debugLine="xpnl_content.Color = xui.Color_Transparent";
_xpnl_content.setColor(_vvvvvvvv3.Color_Transparent);
 //BA.debugLineNum = 220;BA.debugLine="Private r As Reflector";
_r = new anywheresoftware.b4a.agraham.reflection.Reflection();
 //BA.debugLineNum = 221;BA.debugLine="r.Target = xpnl_content";
_r.Target = (Object)(_xpnl_content.getObject());
 //BA.debugLineNum = 222;BA.debugLine="r.SetOnTouchListener(\"xpnl_content_Touch2\")";
_r.SetOnTouchListener(ba,"xpnl_content_Touch2");
 //BA.debugLineNum = 225;BA.debugLine="Dim lbl_text As Label";
_lbl_text = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 226;BA.debugLine="lbl_text.Initialize(\"\")";
_lbl_text.Initialize(ba,"");
 //BA.debugLineNum = 228;BA.debugLine="xlbl_text = lbl_text";
_xlbl_text.setObject((java.lang.Object)(_lbl_text.getObject()));
 //BA.debugLineNum = 229;BA.debugLine="xlbl_text.TextColor = xui.Color_White";
_xlbl_text.setTextColor(_vvvvvvvv3.Color_White);
 //BA.debugLineNum = 230;BA.debugLine="xlbl_text.Font = xui.CreateDefaultBoldFont(20)";
_xlbl_text.setFont(_vvvvvvvv3.CreateDefaultBoldFont((float) (20)));
 //BA.debugLineNum = 231;BA.debugLine="xlbl_text.SetTextAlignment(\"CENTER\",\"CENTER\")";
_xlbl_text.SetTextAlignment("CENTER","CENTER");
 //BA.debugLineNum = 233;BA.debugLine="mBase.AddView(xlbl_text,0,xpnl_header.Height,mBas";
_vvvvvvvv2.AddView((android.view.View)(_xlbl_text.getObject()),(int) (0),_xpnl_header.getHeight(),_vvvvvvvv2.getWidth(),(int) (_xpnl_bottom.getTop()-_xpnl_header.getHeight()));
 //BA.debugLineNum = 235;BA.debugLine="xlbl_text.Visible = False";
_xlbl_text.setVisible(__c.False);
 //BA.debugLineNum = 239;BA.debugLine="Base_Resize(mBase.width,mBase.height)";
_base_resize(_vvvvvvvv2.getWidth(),_vvvvvvvv2.getHeight());
 //BA.debugLineNum = 243;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4a.objects.B4XViewWrapper  _getvvvvv7() throws Exception{
 //BA.debugLineNum = 185;BA.debugLine="Public Sub getBase As B4XView";
 //BA.debugLineNum = 187;BA.debugLine="Return mBase";
if (true) return _vvvvvvvv2;
 //BA.debugLineNum = 189;BA.debugLine="End Sub";
return null;
}
public int  _getvvvvv0() throws Exception{
 //BA.debugLineNum = 823;BA.debugLine="Public Sub getBottomColor As Int";
 //BA.debugLineNum = 825;BA.debugLine="Return xpnl_bottom.Color";
if (true) return _xpnl_bottom.getColor();
 //BA.debugLineNum = 827;BA.debugLine="End Sub";
return 0;
}
public int  _getvvvvvv1() throws Exception{
 //BA.debugLineNum = 762;BA.debugLine="Public Sub getBottomTop As Int";
 //BA.debugLineNum = 764;BA.debugLine="Return xpnl_bottom.Top";
if (true) return _xpnl_bottom.getTop();
 //BA.debugLineNum = 766;BA.debugLine="End Sub";
return 0;
}
public anywheresoftware.b4a.objects.B4XViewWrapper  _getvvvvvv2() throws Exception{
 //BA.debugLineNum = 783;BA.debugLine="Public Sub getButton1 As B4XView";
 //BA.debugLineNum = 785;BA.debugLine="Return xlbl_action_1";
if (true) return _xlbl_action_1;
 //BA.debugLineNum = 787;BA.debugLine="End Sub";
return null;
}
public anywheresoftware.b4a.objects.B4XViewWrapper  _getvvvvvv3() throws Exception{
 //BA.debugLineNum = 790;BA.debugLine="Public Sub getButton2 As B4XView";
 //BA.debugLineNum = 792;BA.debugLine="Return xlbl_action_2";
if (true) return _xlbl_action_2;
 //BA.debugLineNum = 794;BA.debugLine="End Sub";
return null;
}
public anywheresoftware.b4a.objects.B4XViewWrapper  _getvvvvvv4() throws Exception{
 //BA.debugLineNum = 797;BA.debugLine="Public Sub getButton3 As B4XView";
 //BA.debugLineNum = 799;BA.debugLine="Return xlbl_action_3";
if (true) return _xlbl_action_3;
 //BA.debugLineNum = 801;BA.debugLine="End Sub";
return null;
}
public int  _getvvvvvv5() throws Exception{
 //BA.debugLineNum = 888;BA.debugLine="Public Sub getCANCEL As Int";
 //BA.debugLineNum = 890;BA.debugLine="Return 1";
if (true) return (int) (1);
 //BA.debugLineNum = 892;BA.debugLine="End Sub";
return 0;
}
public boolean  _getvvvvvv6() throws Exception{
 //BA.debugLineNum = 746;BA.debugLine="Public Sub getCloseButtonVisible As Boolean";
 //BA.debugLineNum = 748;BA.debugLine="Return showX";
if (true) return _vvvvvvvv4;
 //BA.debugLineNum = 750;BA.debugLine="End Sub";
return false;
}
public int  _getvvvvvv7() throws Exception{
 //BA.debugLineNum = 769;BA.debugLine="Public Sub getContentHeight As Int";
 //BA.debugLineNum = 771;BA.debugLine="Return xpnl_content.Height";
if (true) return _xpnl_content.getHeight();
 //BA.debugLineNum = 773;BA.debugLine="End Sub";
return 0;
}
public int  _getvvvvvv0() throws Exception{
 //BA.debugLineNum = 719;BA.debugLine="Public Sub getDragableContent As Int";
 //BA.debugLineNum = 721;BA.debugLine="Return 2";
if (true) return (int) (2);
 //BA.debugLineNum = 723;BA.debugLine="End Sub";
return 0;
}
public int  _getvvvvvvv1() throws Exception{
 //BA.debugLineNum = 725;BA.debugLine="Public Sub getDragableDisable As Int";
 //BA.debugLineNum = 727;BA.debugLine="Return 0";
if (true) return (int) (0);
 //BA.debugLineNum = 729;BA.debugLine="End Sub";
return 0;
}
public int  _getvvvvvvv2() throws Exception{
 //BA.debugLineNum = 713;BA.debugLine="Public Sub getDragableTop As Int";
 //BA.debugLineNum = 715;BA.debugLine="Return 1";
if (true) return (int) (1);
 //BA.debugLineNum = 717;BA.debugLine="End Sub";
return 0;
}
public int  _getvvvvvvv3() throws Exception{
 //BA.debugLineNum = 707;BA.debugLine="Public Sub getEnableDrag As Int";
 //BA.debugLineNum = 709;BA.debugLine="Return dragable";
if (true) return _vvvvvvvvv4;
 //BA.debugLineNum = 711;BA.debugLine="End Sub";
return 0;
}
public int  _getheader_font_size() throws Exception{
 //BA.debugLineNum = 577;BA.debugLine="Public Sub getHeader_Font_Size As Int";
 //BA.debugLineNum = 579;BA.debugLine="Return headerFontSize";
if (true) return _vvvvvvvvv1;
 //BA.debugLineNum = 581;BA.debugLine="End Sub";
return 0;
}
public String  _getheader_text() throws Exception{
 //BA.debugLineNum = 562;BA.debugLine="Public Sub getHeader_Text As String";
 //BA.debugLineNum = 564;BA.debugLine="Return headerText";
if (true) return _vvvvvvvvv2;
 //BA.debugLineNum = 566;BA.debugLine="End Sub";
return "";
}
public int  _getvvvvvvv4() throws Exception{
 //BA.debugLineNum = 755;BA.debugLine="Public Sub getHeaderBottom As Int";
 //BA.debugLineNum = 757;BA.debugLine="Return xpnl_header.Height";
if (true) return _xpnl_header.getHeight();
 //BA.debugLineNum = 759;BA.debugLine="End Sub";
return 0;
}
public int  _getvvvvvvv5() throws Exception{
 //BA.debugLineNum = 817;BA.debugLine="Public Sub getHeaderColor As Int";
 //BA.debugLineNum = 819;BA.debugLine="Return xpnl_header.Color";
if (true) return _xpnl_header.getColor();
 //BA.debugLineNum = 821;BA.debugLine="End Sub";
return 0;
}
public String  _geticon_direction() throws Exception{
 //BA.debugLineNum = 610;BA.debugLine="Public Sub getIcon_direction As String";
 //BA.debugLineNum = 612;BA.debugLine="Return iconDirection";
if (true) return _vvvvvvvv6;
 //BA.debugLineNum = 614;BA.debugLine="End Sub";
return "";
}
public int  _getvvvvvvv6() throws Exception{
 //BA.debugLineNum = 881;BA.debugLine="Public Sub getNEGATIVE As Int";
 //BA.debugLineNum = 883;BA.debugLine="Return 2";
if (true) return (int) (2);
 //BA.debugLineNum = 885;BA.debugLine="End Sub";
return 0;
}
public int  _getvvvvvvv7() throws Exception{
 //BA.debugLineNum = 874;BA.debugLine="Public Sub getPOSITIVE As Int";
 //BA.debugLineNum = 876;BA.debugLine="Return 3";
if (true) return (int) (3);
 //BA.debugLineNum = 878;BA.debugLine="End Sub";
return 0;
}
public String  _icon_border_width(int _border) throws Exception{
 //BA.debugLineNum = 624;BA.debugLine="Public Sub icon_border_width(border As Int)";
 //BA.debugLineNum = 626;BA.debugLine="If border > -1 And border < 6 Then";
if (_border>-1 && _border<6) { 
 //BA.debugLineNum = 628;BA.debugLine="border_width = border";
_border_width = _border;
 }else {
 //BA.debugLineNum = 635;BA.debugLine="Return";
if (true) return "";
 };
 //BA.debugLineNum = 639;BA.debugLine="End Sub";
return "";
}
public String  _icon_click_handler() throws Exception{
 //BA.debugLineNum = 545;BA.debugLine="Private Sub icon_click_handler";
 //BA.debugLineNum = 547;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_IconCl";
if (_vvvvvvvv3.SubExists(ba,_vvvvvvvv1,_vvvvvvv0+"_IconClick",(int) (0))) { 
 //BA.debugLineNum = 548;BA.debugLine="CallSub(mCallBack, mEventName & \"_IconClick\")";
__c.CallSubNew(ba,_vvvvvvvv1,_vvvvvvv0+"_IconClick");
 };
 //BA.debugLineNum = 551;BA.debugLine="End Sub";
return "";
}
public String  _icon_longclick_handler() throws Exception{
 //BA.debugLineNum = 553;BA.debugLine="Private Sub icon_longclick_handler";
 //BA.debugLineNum = 555;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_IconLo";
if (_vvvvvvvv3.SubExists(ba,_vvvvvvvv1,_vvvvvvv0+"_IconLongClick",(int) (0))) { 
 //BA.debugLineNum = 556;BA.debugLine="CallSub(mCallBack, mEventName & \"_IconLongClick\"";
__c.CallSubNew(ba,_vvvvvvvv1,_vvvvvvv0+"_IconLongClick");
 };
 //BA.debugLineNum = 559;BA.debugLine="End Sub";
return "";
}
public String  _icon_set_icon(anywheresoftware.b4a.objects.B4XViewWrapper.B4XBitmapWrapper _icon) throws Exception{
 //BA.debugLineNum = 731;BA.debugLine="Public Sub icon_set_icon(icon As B4XBitmap)";
 //BA.debugLineNum = 733;BA.debugLine="xiv_icon.SetBitmap(CreateRoundBitmap(icon,xiv_ico";
_xiv_icon.SetBitmap((android.graphics.Bitmap)(_v7(_icon,_xiv_icon.getWidth()).getObject()));
 //BA.debugLineNum = 735;BA.debugLine="End Sub";
return "";
}
public String  _icon_visible(boolean _visible) throws Exception{
 //BA.debugLineNum = 616;BA.debugLine="Public Sub icon_visible(visible As Boolean)";
 //BA.debugLineNum = 618;BA.debugLine="iconVisible = visible";
_vvvvvvvv5 = _visible;
 //BA.debugLineNum = 619;BA.debugLine="Base_Resize(mBase.Width,mBase.Height)";
_base_resize(_vvvvvvvv2.getWidth(),_vvvvvvvv2.getHeight());
 //BA.debugLineNum = 621;BA.debugLine="End Sub";
return "";
}
public String  _initialize(anywheresoftware.b4a.BA _ba,Object _callback,String _eventname) throws Exception{
innerInitialize(_ba);
 //BA.debugLineNum = 179;BA.debugLine="Public Sub Initialize (Callback As Object, EventNa";
 //BA.debugLineNum = 180;BA.debugLine="mEventName = EventName";
_vvvvvvv0 = _eventname;
 //BA.debugLineNum = 181;BA.debugLine="mCallBack = Callback";
_vvvvvvvv1 = _callback;
 //BA.debugLineNum = 182;BA.debugLine="End Sub";
return "";
}
public String  _vvvv1(String _button1,String _button2,String _button3) throws Exception{
 //BA.debugLineNum = 144;BA.debugLine="Public Sub InitializeBottom(button1 As String,butt";
 //BA.debugLineNum = 146;BA.debugLine="If button1 = \"\" Then";
if ((_button1).equals("")) { 
 //BA.debugLineNum = 148;BA.debugLine="xlbl_action_1.Text = \"\"";
_xlbl_action_1.setText(BA.ObjectToCharSequence(""));
 //BA.debugLineNum = 149;BA.debugLine="xlbl_action_1.Visible = False";
_xlbl_action_1.setVisible(__c.False);
 }else {
 //BA.debugLineNum = 152;BA.debugLine="xlbl_action_1.Text = button1";
_xlbl_action_1.setText(BA.ObjectToCharSequence(_button1));
 //BA.debugLineNum = 154;BA.debugLine="xlbl_action_1.Visible = True";
_xlbl_action_1.setVisible(__c.True);
 };
 //BA.debugLineNum = 157;BA.debugLine="If button2 = \"\" Then";
if ((_button2).equals("")) { 
 //BA.debugLineNum = 158;BA.debugLine="xlbl_action_2.Text = \"\"";
_xlbl_action_2.setText(BA.ObjectToCharSequence(""));
 //BA.debugLineNum = 159;BA.debugLine="xlbl_action_2.Visible = False";
_xlbl_action_2.setVisible(__c.False);
 }else {
 //BA.debugLineNum = 162;BA.debugLine="xlbl_action_2.Text = button2";
_xlbl_action_2.setText(BA.ObjectToCharSequence(_button2));
 //BA.debugLineNum = 164;BA.debugLine="xlbl_action_2.Visible = True";
_xlbl_action_2.setVisible(__c.True);
 };
 //BA.debugLineNum = 167;BA.debugLine="If button3 = \"\" Then";
if ((_button3).equals("")) { 
 //BA.debugLineNum = 168;BA.debugLine="xlbl_action_3.Text = \"\"";
_xlbl_action_3.setText(BA.ObjectToCharSequence(""));
 //BA.debugLineNum = 169;BA.debugLine="xlbl_action_3.Visible = False";
_xlbl_action_3.setVisible(__c.False);
 }else {
 //BA.debugLineNum = 172;BA.debugLine="xlbl_action_3.Text = button3";
_xlbl_action_3.setText(BA.ObjectToCharSequence(_button3));
 //BA.debugLineNum = 174;BA.debugLine="xlbl_action_3.Visible = True";
_xlbl_action_3.setVisible(__c.True);
 };
 //BA.debugLineNum = 177;BA.debugLine="End Sub";
return "";
}
public String  _vvvv2(anywheresoftware.b4a.objects.B4XViewWrapper _parent,int _backgroundcolor,boolean _show_header,boolean _show_bottom,boolean _show_close_button) throws Exception{
anywheresoftware.b4a.objects.B4XViewWrapper _tmp_base = null;
anywheresoftware.b4a.objects.collections.Map _props = null;
anywheresoftware.b4a.objects.LabelWrapper _lbl = null;
 //BA.debugLineNum = 98;BA.debugLine="Public Sub InitializeWithoutDesigner(parent As B4X";
 //BA.debugLineNum = 101;BA.debugLine="Dim tmp_base As B4XView";
_tmp_base = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 102;BA.debugLine="tmp_base = xui.CreatePanel(mEventName)";
_tmp_base = _vvvvvvvv3.CreatePanel(ba,_vvvvvvv0);
 //BA.debugLineNum = 106;BA.debugLine="parent.AddView(tmp_base, 0 + parent.Width/2 - tmp";
_parent.AddView((android.view.View)(_tmp_base.getObject()),(int) (0+_parent.getWidth()/(double)2-_tmp_base.getWidth()/(double)2),(int) (0+_parent.getHeight()/(double)2-_tmp_base.getHeight()/(double)2),__c.DipToCurrent((int) (300)),__c.DipToCurrent((int) (300)));
 //BA.debugLineNum = 108;BA.debugLine="Dim props As Map";
_props = new anywheresoftware.b4a.objects.collections.Map();
 //BA.debugLineNum = 109;BA.debugLine="props.Initialize";
_props.Initialize();
 //BA.debugLineNum = 110;BA.debugLine="props.Put(\"Back_Color\",backgroundcolor)";
_props.Put((Object)("Back_Color"),(Object)(_backgroundcolor));
 //BA.debugLineNum = 111;BA.debugLine="props.Put(\"show_header\",show_header)";
_props.Put((Object)("show_header"),(Object)(_show_header));
 //BA.debugLineNum = 112;BA.debugLine="props.Put(\"show_bottom\",show_bottom)";
_props.Put((Object)("show_bottom"),(Object)(_show_bottom));
 //BA.debugLineNum = 113;BA.debugLine="props.Put(\"Show_X\",show_close_button)";
_props.Put((Object)("Show_X"),(Object)(_show_close_button));
 //BA.debugLineNum = 114;BA.debugLine="props.Put(\"Header_CLR\",0xFF2F343A)";
_props.Put((Object)("Header_CLR"),(Object)(0xff2f343a));
 //BA.debugLineNum = 115;BA.debugLine="props.Put(\"Bottom_CLR\",0xFF2F343A)";
_props.Put((Object)("Bottom_CLR"),(Object)(0xff2f343a));
 //BA.debugLineNum = 117;BA.debugLine="If show_header = True Then";
if (_show_header==__c.True) { 
 //BA.debugLineNum = 118;BA.debugLine="props.Put(\"Icon_visible\",True)";
_props.Put((Object)("Icon_visible"),(Object)(__c.True));
 //BA.debugLineNum = 119;BA.debugLine="props.Put(\"Icon_direction\",\"LEFT\")";
_props.Put((Object)("Icon_direction"),(Object)("LEFT"));
 }else {
 //BA.debugLineNum = 121;BA.debugLine="props.Put(\"Icon_visible\",False)";
_props.Put((Object)("Icon_visible"),(Object)(__c.False));
 //BA.debugLineNum = 122;BA.debugLine="props.Put(\"Icon_direction\",\"LEFT\")";
_props.Put((Object)("Icon_direction"),(Object)("LEFT"));
 };
 //BA.debugLineNum = 125;BA.debugLine="props.Put(\"BorderWidth\",0)";
_props.Put((Object)("BorderWidth"),(Object)(0));
 //BA.debugLineNum = 128;BA.debugLine="props.Put(\"header_font_size\",20)";
_props.Put((Object)("header_font_size"),(Object)(20));
 //BA.debugLineNum = 129;BA.debugLine="props.Put(\"Header_Text\",\"Anywhere B4X\")";
_props.Put((Object)("Header_Text"),(Object)("Anywhere B4X"));
 //BA.debugLineNum = 131;BA.debugLine="Dim lbl As Label";
_lbl = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 132;BA.debugLine="lbl.Initialize(\"\")";
_lbl.Initialize(ba,"");
 //BA.debugLineNum = 134;BA.debugLine="DesignerCreateView(tmp_base,lbl,props)";
_designercreateview((Object)(_tmp_base.getObject()),_lbl,_props);
 //BA.debugLineNum = 136;BA.debugLine="mBase.Visible = False";
_vvvvvvvv2.setVisible(__c.False);
 //BA.debugLineNum = 138;BA.debugLine="Base_Resize(mBase.Width,mBase.Height)";
_base_resize(_vvvvvvvv2.getWidth(),_vvvvvvvv2.getHeight());
 //BA.debugLineNum = 141;BA.debugLine="End Sub";
return "";
}
public String  _vvvv3(String _layout) throws Exception{
 //BA.debugLineNum = 804;BA.debugLine="Public Sub LoadLayout(layout As String)";
 //BA.debugLineNum = 806;BA.debugLine="xpnl_content.LoadLayout(layout)";
_xpnl_content.LoadLayout(_layout,ba);
 //BA.debugLineNum = 808;BA.debugLine="End Sub";
return "";
}
public String  _vvvv4(anywheresoftware.b4a.objects.B4XViewWrapper _p) throws Exception{
 //BA.debugLineNum = 811;BA.debugLine="Public Sub LoadLayout2(p As B4XView)";
 //BA.debugLineNum = 813;BA.debugLine="xpnl_content = p";
_xpnl_content = _p;
 //BA.debugLineNum = 815;BA.debugLine="End Sub";
return "";
}
public String  _vvvv5(anywheresoftware.b4a.objects.B4XViewWrapper _view,int _alpha) throws Exception{
int _clr = 0;
 //BA.debugLineNum = 952;BA.debugLine="Private Sub MakeViewBackgroundTransparent(View As";
 //BA.debugLineNum = 953;BA.debugLine="Dim clr As Int = View.Color";
_clr = _view.getColor();
 //BA.debugLineNum = 954;BA.debugLine="If clr = 0 Then";
if (_clr==0) { 
 //BA.debugLineNum = 955;BA.debugLine="Log(\"Cannot get background color.\")";
__c.Log("Cannot get background color.");
 //BA.debugLineNum = 956;BA.debugLine="Return";
if (true) return "";
 };
 //BA.debugLineNum = 958;BA.debugLine="View.Color = Bit.Or(Bit.And(0x00ffffff, clr), Bit";
_view.setColor(__c.Bit.Or(__c.Bit.And((int) (0x00ffffff),_clr),__c.Bit.ShiftLeft(_alpha,(int) (24))));
 //BA.debugLineNum = 959;BA.debugLine="End Sub";
return "";
}
public int  _vvvv6(String _text,anywheresoftware.b4a.objects.B4XViewWrapper.B4XFont _font1) throws Exception{
anywheresoftware.b4a.objects.drawable.CanvasWrapper.BitmapWrapper _bmp = null;
anywheresoftware.b4a.objects.drawable.CanvasWrapper _cvs = null;
 //BA.debugLineNum = 962;BA.debugLine="Private Sub MeasureTextHeight(Text As String, Font";
 //BA.debugLineNum = 964;BA.debugLine="Private bmp As Bitmap";
_bmp = new anywheresoftware.b4a.objects.drawable.CanvasWrapper.BitmapWrapper();
 //BA.debugLineNum = 965;BA.debugLine="bmp.InitializeMutable(2dip, 2dip)";
_bmp.InitializeMutable(__c.DipToCurrent((int) (2)),__c.DipToCurrent((int) (2)));
 //BA.debugLineNum = 966;BA.debugLine="Private cvs As Canvas";
_cvs = new anywheresoftware.b4a.objects.drawable.CanvasWrapper();
 //BA.debugLineNum = 967;BA.debugLine="cvs.Initialize2(bmp)";
_cvs.Initialize2((android.graphics.Bitmap)(_bmp.getObject()));
 //BA.debugLineNum = 968;BA.debugLine="Return cvs.MeasureStringHeight(Text, Font1.ToN";
if (true) return (int) (_cvs.MeasureStringHeight(_text,(android.graphics.Typeface)(_font1.ToNativeFont().getObject()),_font1.getSize()));
 //BA.debugLineNum = 980;BA.debugLine="End Sub";
return 0;
}
public int  _vvvv7(String _text,anywheresoftware.b4a.objects.B4XViewWrapper.B4XFont _font1) throws Exception{
anywheresoftware.b4a.objects.drawable.CanvasWrapper.BitmapWrapper _bmp = null;
anywheresoftware.b4a.objects.drawable.CanvasWrapper _cvs = null;
 //BA.debugLineNum = 982;BA.debugLine="Private Sub MeasureTextWidth(Text As String, Font1";
 //BA.debugLineNum = 984;BA.debugLine="Private bmp As Bitmap";
_bmp = new anywheresoftware.b4a.objects.drawable.CanvasWrapper.BitmapWrapper();
 //BA.debugLineNum = 985;BA.debugLine="bmp.InitializeMutable(2dip, 2dip)";
_bmp.InitializeMutable(__c.DipToCurrent((int) (2)),__c.DipToCurrent((int) (2)));
 //BA.debugLineNum = 986;BA.debugLine="Private cvs As Canvas";
_cvs = new anywheresoftware.b4a.objects.drawable.CanvasWrapper();
 //BA.debugLineNum = 987;BA.debugLine="cvs.Initialize2(bmp)";
_cvs.Initialize2((android.graphics.Bitmap)(_bmp.getObject()));
 //BA.debugLineNum = 988;BA.debugLine="Return cvs.MeasureStringWidth(Text, Font1.ToNa";
if (true) return (int) (_cvs.MeasureStringWidth(_text,(android.graphics.Typeface)(_font1.ToNativeFont().getObject()),_font1.getSize()));
 //BA.debugLineNum = 1000;BA.debugLine="End Sub";
return 0;
}
public String  _vvvv0(int _res) throws Exception{
 //BA.debugLineNum = 937;BA.debugLine="Private Sub result(res As Int)";
 //BA.debugLineNum = 939;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_result";
if (_vvvvvvvv3.SubExists(ba,_vvvvvvvv1,_vvvvvvv0+"_result",(int) (0))) { 
 //BA.debugLineNum = 940;BA.debugLine="CallSub2(mCallBack, mEventName & \"_result\",res)";
__c.CallSubNew2(ba,_vvvvvvvv1,_vvvvvvv0+"_result",(Object)(_res));
 };
 //BA.debugLineNum = 943;BA.debugLine="End Sub";
return "";
}
public String  _setvvvvv0(int _color) throws Exception{
 //BA.debugLineNum = 836;BA.debugLine="Public Sub setBottomColor(color As Int)";
 //BA.debugLineNum = 838;BA.debugLine="bottom_crl = color";
_bottom_crl = _color;
 //BA.debugLineNum = 839;BA.debugLine="xpnl_bottom.Color = color";
_xpnl_bottom.setColor(_color);
 //BA.debugLineNum = 841;BA.debugLine="End Sub";
return "";
}
public String  _setvvvvvv6(boolean _visible) throws Exception{
 //BA.debugLineNum = 738;BA.debugLine="Public Sub setCloseButtonVisible(visible As Boolea";
 //BA.debugLineNum = 740;BA.debugLine="showX = visible";
_vvvvvvvv4 = _visible;
 //BA.debugLineNum = 741;BA.debugLine="Base_Resize(mBase.Width,mBase.Height)";
_base_resize(_vvvvvvvv2.getWidth(),_vvvvvvvv2.getHeight());
 //BA.debugLineNum = 743;BA.debugLine="End Sub";
return "";
}
public String  _setvvvvvvv3(int _enable) throws Exception{
 //BA.debugLineNum = 701;BA.debugLine="Public Sub setEnableDrag(enable As Int)";
 //BA.debugLineNum = 703;BA.debugLine="dragable = enable";
_vvvvvvvvv4 = _enable;
 //BA.debugLineNum = 705;BA.debugLine="End Sub";
return "";
}
public String  _setheader_font_size(int _fontsize) throws Exception{
 //BA.debugLineNum = 584;BA.debugLine="Public Sub setHeader_Font_Size(fontsize As Int)";
 //BA.debugLineNum = 586;BA.debugLine="headerFontSize = fontsize";
_vvvvvvvvv1 = _fontsize;
 //BA.debugLineNum = 587;BA.debugLine="xlbl_header.Font = xui.CreateDefaultBoldFont(head";
_xlbl_header.setFont(_vvvvvvvv3.CreateDefaultBoldFont((float) (_vvvvvvvvv1)));
 //BA.debugLineNum = 589;BA.debugLine="End Sub";
return "";
}
public String  _setheader_text(String _text) throws Exception{
 //BA.debugLineNum = 569;BA.debugLine="Public Sub setHeader_Text(text As String)";
 //BA.debugLineNum = 571;BA.debugLine="headerText = text";
_vvvvvvvvv2 = _text;
 //BA.debugLineNum = 572;BA.debugLine="xlbl_header.Text = headerText";
_xlbl_header.setText(BA.ObjectToCharSequence(_vvvvvvvvv2));
 //BA.debugLineNum = 574;BA.debugLine="End Sub";
return "";
}
public String  _setvvvvvvv5(int _color) throws Exception{
 //BA.debugLineNum = 829;BA.debugLine="Public Sub setHeaderColor(color As Int)";
 //BA.debugLineNum = 831;BA.debugLine="header_clr = color";
_header_clr = _color;
 //BA.debugLineNum = 832;BA.debugLine="xpnl_header.Color = color";
_xpnl_header.setColor(_color);
 //BA.debugLineNum = 834;BA.debugLine="End Sub";
return "";
}
public String  _seticon_direction(String _direction) throws Exception{
 //BA.debugLineNum = 593;BA.debugLine="Public Sub setIcon_direction(direction As String)";
 //BA.debugLineNum = 595;BA.debugLine="If direction = \"LEFT\" Or direction = \"RIGHT\" Or d";
if ((_direction).equals("LEFT") || (_direction).equals("RIGHT") || (_direction).equals("MIDDLE")) { 
 //BA.debugLineNum = 597;BA.debugLine="iconDirection = direction";
_vvvvvvvv6 = _direction;
 //BA.debugLineNum = 598;BA.debugLine="Base_Resize(mBase.Width,mBase.Height)";
_base_resize(_vvvvvvvv2.getWidth(),_vvvvvvvv2.getHeight());
 }else {
 //BA.debugLineNum = 602;BA.debugLine="Return";
if (true) return "";
 };
 //BA.debugLineNum = 606;BA.debugLine="End Sub";
return "";
}
public String  _vvvvv5(boolean _animated) throws Exception{
 //BA.debugLineNum = 261;BA.debugLine="Public Sub Show(animated As Boolean)";
 //BA.debugLineNum = 263;BA.debugLine="If animated = True Then";
if (_animated==__c.True) { 
 //BA.debugLineNum = 265;BA.debugLine="mBase.SetVisibleAnimated(300,True)";
_vvvvvvvv2.SetVisibleAnimated((int) (300),__c.True);
 }else if(_animated==__c.False) { 
 //BA.debugLineNum = 269;BA.debugLine="mBase.Visible = True";
_vvvvvvvv2.setVisible(__c.True);
 };
 //BA.debugLineNum = 273;BA.debugLine="End Sub";
return "";
}
public String  _vvvvv6(String _text,boolean _animated) throws Exception{
 //BA.debugLineNum = 246;BA.debugLine="Public Sub ShowWithText(text As String,animated As";
 //BA.debugLineNum = 248;BA.debugLine="xlbl_text.BringToFront";
_xlbl_text.BringToFront();
 //BA.debugLineNum = 249;BA.debugLine="xlbl_text.Visible = True";
_xlbl_text.setVisible(__c.True);
 //BA.debugLineNum = 250;BA.debugLine="If animated = True Then";
if (_animated==__c.True) { 
 //BA.debugLineNum = 252;BA.debugLine="mBase.SetVisibleAnimated(300,True)";
_vvvvvvvv2.SetVisibleAnimated((int) (300),__c.True);
 }else if(_animated==__c.False) { 
 //BA.debugLineNum = 254;BA.debugLine="mBase.Visible = True";
_vvvvvvvv2.setVisible(__c.True);
 };
 //BA.debugLineNum = 257;BA.debugLine="xlbl_text.Text = text";
_xlbl_text.setText(BA.ObjectToCharSequence(_text));
 //BA.debugLineNum = 259;BA.debugLine="End Sub";
return "";
}
public String  _xiv_icon_click() throws Exception{
 //BA.debugLineNum = 531;BA.debugLine="Private Sub xiv_icon_Click";
 //BA.debugLineNum = 533;BA.debugLine="icon_click_handler";
_icon_click_handler();
 //BA.debugLineNum = 535;BA.debugLine="End Sub";
return "";
}
public String  _xiv_icon_longclick() throws Exception{
 //BA.debugLineNum = 539;BA.debugLine="Private Sub xiv_icon_LongClick";
 //BA.debugLineNum = 541;BA.debugLine="icon_longclick_handler";
_icon_longclick_handler();
 //BA.debugLineNum = 543;BA.debugLine="End Sub";
return "";
}
public String  _xlbl_action_1_click() throws Exception{
 //BA.debugLineNum = 916;BA.debugLine="Private Sub xlbl_action_1_Click";
 //BA.debugLineNum = 918;BA.debugLine="result(xlbl_action_1.Tag)";
_vvvv0((int)(BA.ObjectToNumber(_xlbl_action_1.getTag())));
 //BA.debugLineNum = 920;BA.debugLine="End Sub";
return "";
}
public String  _xlbl_action_2_click() throws Exception{
 //BA.debugLineNum = 922;BA.debugLine="Private Sub xlbl_action_2_Click";
 //BA.debugLineNum = 924;BA.debugLine="result(xlbl_action_2.Tag)";
_vvvv0((int)(BA.ObjectToNumber(_xlbl_action_2.getTag())));
 //BA.debugLineNum = 926;BA.debugLine="End Sub";
return "";
}
public String  _xlbl_action_3_click() throws Exception{
 //BA.debugLineNum = 928;BA.debugLine="Private Sub xlbl_action_3_Click";
 //BA.debugLineNum = 930;BA.debugLine="result(xlbl_action_3.Tag)";
_vvvv0((int)(BA.ObjectToNumber(_xlbl_action_3.getTag())));
 //BA.debugLineNum = 932;BA.debugLine="End Sub";
return "";
}
public String  _xpnl_close_click() throws Exception{
 //BA.debugLineNum = 855;BA.debugLine="Private Sub xpnl_close_Click";
 //BA.debugLineNum = 857;BA.debugLine="closebutton_handler(Sender)";
_closebutton_handler((anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(__c.Sender(ba))));
 //BA.debugLineNum = 859;BA.debugLine="End Sub";
return "";
}
public boolean  _xpnl_content_touch2(Object _o,int _action,float _x,float _y,Object _motion) throws Exception{
 //BA.debugLineNum = 673;BA.debugLine="Private Sub xpnl_content_Touch2 (o As Object, ACTI";
 //BA.debugLineNum = 678;BA.debugLine="If dragable = 2 Then";
if (_vvvvvvvvv4==2) { 
 //BA.debugLineNum = 680;BA.debugLine="If Action = xpnl_bottom.TOUCH_ACTION_DOWN Then";
if (_action==_xpnl_bottom.TOUCH_ACTION_DOWN) { 
 //BA.debugLineNum = 682;BA.debugLine="donwx  = X";
_vvvvvvvvv5 = (int) (_x);
 //BA.debugLineNum = 683;BA.debugLine="downy  = y";
_vvvvvvvvv6 = (int) (_y);
 }else if(_action==_xpnl_bottom.TOUCH_ACTION_MOVE) { 
 //BA.debugLineNum = 687;BA.debugLine="mBase.Top = mBase.Top + y - downy";
_vvvvvvvv2.setTop((int) (_vvvvvvvv2.getTop()+_y-_vvvvvvvvv6));
 //BA.debugLineNum = 688;BA.debugLine="mBase.Left = mBase.Left + x - donwx";
_vvvvvvvv2.setLeft((int) (_vvvvvvvv2.getLeft()+_x-_vvvvvvvvv5));
 };
 };
 //BA.debugLineNum = 697;BA.debugLine="Return True";
if (true) return __c.True;
 //BA.debugLineNum = 698;BA.debugLine="End Sub";
return false;
}
public boolean  _xpnl_header_touch2(Object _o,int _action,float _x,float _y,Object _motion) throws Exception{
 //BA.debugLineNum = 643;BA.debugLine="Private Sub xpnl_header_Touch2 (o As Object, ACTIO";
 //BA.debugLineNum = 647;BA.debugLine="If dragable = 1 Then";
if (_vvvvvvvvv4==1) { 
 //BA.debugLineNum = 649;BA.debugLine="If Action = xpnl_bottom.TOUCH_ACTION_DOWN Then";
if (_action==_xpnl_bottom.TOUCH_ACTION_DOWN) { 
 //BA.debugLineNum = 651;BA.debugLine="donwx  = X";
_vvvvvvvvv5 = (int) (_x);
 //BA.debugLineNum = 652;BA.debugLine="downy  = y";
_vvvvvvvvv6 = (int) (_y);
 }else if(_action==_xpnl_bottom.TOUCH_ACTION_MOVE) { 
 //BA.debugLineNum = 656;BA.debugLine="mBase.Top = mBase.Top + y - downy";
_vvvvvvvv2.setTop((int) (_vvvvvvvv2.getTop()+_y-_vvvvvvvvv6));
 //BA.debugLineNum = 657;BA.debugLine="mBase.Left = mBase.Left + x - donwx";
_vvvvvvvv2.setLeft((int) (_vvvvvvvv2.getLeft()+_x-_vvvvvvvvv5));
 };
 };
 //BA.debugLineNum = 667;BA.debugLine="Return True";
if (true) return __c.True;
 //BA.debugLineNum = 668;BA.debugLine="End Sub";
return false;
}
public Object callSub(String sub, Object sender, Object[] args) throws Exception {
BA.senderHolder.set(sender);
return BA.SubDelegator.SubNotFound;
}
}
