package b4j.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;
import anywheresoftware.b4a.debug.*;

public class asbottommenu extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.ShellBA("b4j.example", "b4j.example.asbottommenu", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.asbottommenu.class).invoke(this, new Object[] {null});
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
public int _defaultcolorconstant = 0;
public int _currentpage = 0;
public anywheresoftware.b4j.objects.B4XViewWrapper.XUI _xui = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _asbm_page_1 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _asbm_page_2 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _asbm_page_3 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _asbm_page_4 = null;
public anywheresoftware.b4j.objects.ImageViewWrapper _asbm_icon_1 = null;
public anywheresoftware.b4j.objects.ImageViewWrapper _asbm_icon_2 = null;
public anywheresoftware.b4j.objects.ImageViewWrapper _asbm_icon_3 = null;
public anywheresoftware.b4j.objects.ImageViewWrapper _asbm_icon_4 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _asbm_badget_1 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _asbm_badget_2 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _asbm_badget_3 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _asbm_badget_4 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _asbm_slider = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _asbm_add_icon = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _asbm_add_background = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _asbm_parting_line = null;
public anywheresoftware.b4j.objects.B4XViewWrapper _asbm_page_background = null;
public int _s_color1 = 0;
public int _s_color2 = 0;
public int _s_color3 = 0;
public int _s_color4 = 0;
public int _b_color = 0;
public int _p_line = 0;
public int _m_backgroundcolor = 0;
public boolean _e_badgetcolor1 = false;
public boolean _e_badgetcolor2 = false;
public boolean _e_badgetcolor3 = false;
public boolean _e_badgetcolor4 = false;
public int _b_color1 = 0;
public int _b_color2 = 0;
public int _b_color3 = 0;
public int _b_color4 = 0;
public int _p_clickcolor = 0;
public boolean _e_selectedpagecolor = false;
public int _s_pagecolor = 0;
public boolean _middlebuttonvisible = false;
public anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _icon1 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _icon2 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _icon3 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _icon4 = null;
public anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _middleicon = null;
public String _typeofmenu = "";
public int _mode = 0;
public b4j.example.main _main = null;
public String  _seticon1(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _icon) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "seticon1"))
	 {return ((String) Debug.delegate(ba, "seticon1", new Object[] {_icon}));}
RDebugUtils.currentLine=3014656;
 //BA.debugLineNum = 3014656;BA.debugLine="Public Sub SetIcon1(icon As B4XBitmap)";
RDebugUtils.currentLine=3014658;
 //BA.debugLineNum = 3014658;BA.debugLine="icon1 = icon";
__ref._icon1 = _icon;
RDebugUtils.currentLine=3014661;
 //BA.debugLineNum = 3014661;BA.debugLine="asbm_icon_1.SetImage(icon1)";
__ref._asbm_icon_1.SetImage((javafx.scene.image.Image)(__ref._icon1.getObject()));
RDebugUtils.currentLine=3014663;
 //BA.debugLineNum = 3014663;BA.debugLine="If currentpage = 1 Then";
if (__ref._currentpage==1) { 
RDebugUtils.currentLine=3014665;
 //BA.debugLineNum = 3014665;BA.debugLine="asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_1.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_1.GetImage().getObject())),__ref._s_pagecolor).getObject()));
 };
RDebugUtils.currentLine=3014681;
 //BA.debugLineNum = 3014681;BA.debugLine="End Sub";
return "";
}
public String  _seticon2(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _icon) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "seticon2"))
	 {return ((String) Debug.delegate(ba, "seticon2", new Object[] {_icon}));}
RDebugUtils.currentLine=3080192;
 //BA.debugLineNum = 3080192;BA.debugLine="Public Sub SetIcon2(icon As B4XBitmap)";
RDebugUtils.currentLine=3080194;
 //BA.debugLineNum = 3080194;BA.debugLine="icon2 = icon";
__ref._icon2 = _icon;
RDebugUtils.currentLine=3080197;
 //BA.debugLineNum = 3080197;BA.debugLine="asbm_icon_2.SetImage(icon2)";
__ref._asbm_icon_2.SetImage((javafx.scene.image.Image)(__ref._icon2.getObject()));
RDebugUtils.currentLine=3080199;
 //BA.debugLineNum = 3080199;BA.debugLine="If currentpage = 2 Then";
if (__ref._currentpage==2) { 
RDebugUtils.currentLine=3080201;
 //BA.debugLineNum = 3080201;BA.debugLine="asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_2.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_2.GetImage().getObject())),__ref._s_pagecolor).getObject()));
 };
RDebugUtils.currentLine=3080219;
 //BA.debugLineNum = 3080219;BA.debugLine="End Sub";
return "";
}
public String  _seticon3(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _icon) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "seticon3"))
	 {return ((String) Debug.delegate(ba, "seticon3", new Object[] {_icon}));}
RDebugUtils.currentLine=3145728;
 //BA.debugLineNum = 3145728;BA.debugLine="Public Sub SetIcon3(icon As B4XBitmap)";
RDebugUtils.currentLine=3145730;
 //BA.debugLineNum = 3145730;BA.debugLine="icon3 = icon";
__ref._icon3 = _icon;
RDebugUtils.currentLine=3145733;
 //BA.debugLineNum = 3145733;BA.debugLine="asbm_icon_3.SetImage(icon3)";
__ref._asbm_icon_3.SetImage((javafx.scene.image.Image)(__ref._icon3.getObject()));
RDebugUtils.currentLine=3145735;
 //BA.debugLineNum = 3145735;BA.debugLine="If currentpage = 3 Then";
if (__ref._currentpage==3) { 
RDebugUtils.currentLine=3145737;
 //BA.debugLineNum = 3145737;BA.debugLine="asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_3.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_3.GetImage().getObject())),__ref._s_pagecolor).getObject()));
 };
RDebugUtils.currentLine=3145754;
 //BA.debugLineNum = 3145754;BA.debugLine="End Sub";
return "";
}
public String  _seticon4(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _icon) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "seticon4"))
	 {return ((String) Debug.delegate(ba, "seticon4", new Object[] {_icon}));}
RDebugUtils.currentLine=3211264;
 //BA.debugLineNum = 3211264;BA.debugLine="Public Sub SetIcon4(icon As B4XBitmap)";
RDebugUtils.currentLine=3211266;
 //BA.debugLineNum = 3211266;BA.debugLine="icon4 = icon";
__ref._icon4 = _icon;
RDebugUtils.currentLine=3211269;
 //BA.debugLineNum = 3211269;BA.debugLine="asbm_icon_4.SetImage(icon4)";
__ref._asbm_icon_4.SetImage((javafx.scene.image.Image)(__ref._icon4.getObject()));
RDebugUtils.currentLine=3211271;
 //BA.debugLineNum = 3211271;BA.debugLine="If currentpage = 4 Then";
if (__ref._currentpage==4) { 
RDebugUtils.currentLine=3211273;
 //BA.debugLineNum = 3211273;BA.debugLine="asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_4.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_4.GetImage().getObject())),__ref._s_pagecolor).getObject()));
 };
RDebugUtils.currentLine=3211289;
 //BA.debugLineNum = 3211289;BA.debugLine="End Sub";
return "";
}
public String  _enablebadget1(b4j.example.asbottommenu __ref,boolean _enable) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "enablebadget1"))
	 {return ((String) Debug.delegate(ba, "enablebadget1", new Object[] {_enable}));}
RDebugUtils.currentLine=1572864;
 //BA.debugLineNum = 1572864;BA.debugLine="Public Sub EnableBadget1(Enable As Boolean)";
RDebugUtils.currentLine=1572866;
 //BA.debugLineNum = 1572866;BA.debugLine="e_BadgetColor1 = Enable";
__ref._e_badgetcolor1 = _enable;
RDebugUtils.currentLine=1572867;
 //BA.debugLineNum = 1572867;BA.debugLine="asbm_badget_1.Visible = e_BadgetColor1";
__ref._asbm_badget_1.setVisible(__ref._e_badgetcolor1);
RDebugUtils.currentLine=1572868;
 //BA.debugLineNum = 1572868;BA.debugLine="End Sub";
return "";
}
public String  _enablebadget2(b4j.example.asbottommenu __ref,boolean _enable) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "enablebadget2"))
	 {return ((String) Debug.delegate(ba, "enablebadget2", new Object[] {_enable}));}
RDebugUtils.currentLine=1638400;
 //BA.debugLineNum = 1638400;BA.debugLine="Public Sub EnableBadget2(Enable As Boolean)";
RDebugUtils.currentLine=1638402;
 //BA.debugLineNum = 1638402;BA.debugLine="e_BadgetColor2 = Enable";
__ref._e_badgetcolor2 = _enable;
RDebugUtils.currentLine=1638403;
 //BA.debugLineNum = 1638403;BA.debugLine="asbm_badget_2.Visible = e_BadgetColor2";
__ref._asbm_badget_2.setVisible(__ref._e_badgetcolor2);
RDebugUtils.currentLine=1638404;
 //BA.debugLineNum = 1638404;BA.debugLine="End Sub";
return "";
}
public String  _enablebadget3(b4j.example.asbottommenu __ref,boolean _enable) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "enablebadget3"))
	 {return ((String) Debug.delegate(ba, "enablebadget3", new Object[] {_enable}));}
RDebugUtils.currentLine=1703936;
 //BA.debugLineNum = 1703936;BA.debugLine="Public Sub EnableBadget3(Enable As Boolean)";
RDebugUtils.currentLine=1703938;
 //BA.debugLineNum = 1703938;BA.debugLine="e_BadgetColor3 = Enable";
__ref._e_badgetcolor3 = _enable;
RDebugUtils.currentLine=1703939;
 //BA.debugLineNum = 1703939;BA.debugLine="asbm_badget_3.Visible = e_BadgetColor3";
__ref._asbm_badget_3.setVisible(__ref._e_badgetcolor3);
RDebugUtils.currentLine=1703940;
 //BA.debugLineNum = 1703940;BA.debugLine="End Sub";
return "";
}
public String  _enablebadget4(b4j.example.asbottommenu __ref,boolean _enable) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "enablebadget4"))
	 {return ((String) Debug.delegate(ba, "enablebadget4", new Object[] {_enable}));}
RDebugUtils.currentLine=1769472;
 //BA.debugLineNum = 1769472;BA.debugLine="Public Sub EnableBadget4(Enable As Boolean)";
RDebugUtils.currentLine=1769474;
 //BA.debugLineNum = 1769474;BA.debugLine="e_BadgetColor4 = Enable";
__ref._e_badgetcolor4 = _enable;
RDebugUtils.currentLine=1769475;
 //BA.debugLineNum = 1769475;BA.debugLine="asbm_badget_4.Visible = e_BadgetColor4";
__ref._asbm_badget_4.setVisible(__ref._e_badgetcolor4);
RDebugUtils.currentLine=1769476;
 //BA.debugLineNum = 1769476;BA.debugLine="End Sub";
return "";
}
public String  _setbadgetvalue1(b4j.example.asbottommenu __ref,int _value) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setbadgetvalue1"))
	 {return ((String) Debug.delegate(ba, "setbadgetvalue1", new Object[] {_value}));}
RDebugUtils.currentLine=2752512;
 //BA.debugLineNum = 2752512;BA.debugLine="Public Sub SetBadgetValue1(value As Int)";
RDebugUtils.currentLine=2752514;
 //BA.debugLineNum = 2752514;BA.debugLine="If value > 9 Then";
if (_value>9) { 
RDebugUtils.currentLine=2752516;
 //BA.debugLineNum = 2752516;BA.debugLine="asbm_badget_1.Text = \"+\" & 9";
__ref._asbm_badget_1.setText("+"+BA.NumberToString(9));
 }else 
{RDebugUtils.currentLine=2752518;
 //BA.debugLineNum = 2752518;BA.debugLine="Else if value < 0 Then";
if (_value<0) { 
RDebugUtils.currentLine=2752520;
 //BA.debugLineNum = 2752520;BA.debugLine="asbm_badget_1.Text = 0";
__ref._asbm_badget_1.setText(BA.NumberToString(0));
 }else {
RDebugUtils.currentLine=2752525;
 //BA.debugLineNum = 2752525;BA.debugLine="asbm_badget_1.Text = value";
__ref._asbm_badget_1.setText(BA.NumberToString(_value));
 }}
;
RDebugUtils.currentLine=2752529;
 //BA.debugLineNum = 2752529;BA.debugLine="End Sub";
return "";
}
public String  _asbm_add_background_click(b4j.example.asbottommenu __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "asbm_add_background_click"))
	 {return ((String) Debug.delegate(ba, "asbm_add_background_click", null));}
RDebugUtils.currentLine=1310720;
 //BA.debugLineNum = 1310720;BA.debugLine="Private Sub asbm_add_background_Click";
RDebugUtils.currentLine=1310722;
 //BA.debugLineNum = 1310722;BA.debugLine="asbm_add_background_handler(Sender)";
__ref._asbm_add_background_handler(null,(anywheresoftware.b4j.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper(), (java.lang.Object)(__c.Sender(ba))));
RDebugUtils.currentLine=1310724;
 //BA.debugLineNum = 1310724;BA.debugLine="End Sub";
return "";
}
public String  _asbm_add_background_handler(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper _senderpanel) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "asbm_add_background_handler"))
	 {return ((String) Debug.delegate(ba, "asbm_add_background_handler", new Object[] {_senderpanel}));}
RDebugUtils.currentLine=1441792;
 //BA.debugLineNum = 1441792;BA.debugLine="Private Sub asbm_add_background_handler(SenderPane";
RDebugUtils.currentLine=1441794;
 //BA.debugLineNum = 1441794;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_Middle";
if (__ref._xui.SubExists(ba,__ref._mcallback,__ref._meventname+"_MiddleButtonClick",(int) (0))) { 
RDebugUtils.currentLine=1441795;
 //BA.debugLineNum = 1441795;BA.debugLine="CallSub(mCallBack, mEventName & \"_MiddleButtonCl";
__c.CallSubNew(ba,__ref._mcallback,__ref._meventname+"_MiddleButtonClick");
 };
RDebugUtils.currentLine=1441799;
 //BA.debugLineNum = 1441799;BA.debugLine="End Sub";
return "";
}
public String  _asbm_add_background_handler_long(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper _senderpanel) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "asbm_add_background_handler_long"))
	 {return ((String) Debug.delegate(ba, "asbm_add_background_handler_long", new Object[] {_senderpanel}));}
RDebugUtils.currentLine=1507328;
 //BA.debugLineNum = 1507328;BA.debugLine="Private Sub asbm_add_background_handler_long(Sende";
RDebugUtils.currentLine=1507330;
 //BA.debugLineNum = 1507330;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_Middle";
if (__ref._xui.SubExists(ba,__ref._mcallback,__ref._meventname+"_MiddleButtonLongClick",(int) (0))) { 
RDebugUtils.currentLine=1507331;
 //BA.debugLineNum = 1507331;BA.debugLine="CallSub(mCallBack, mEventName & \"_MiddleButtonLo";
__c.CallSubNew(ba,__ref._mcallback,__ref._meventname+"_MiddleButtonLongClick");
 };
RDebugUtils.currentLine=1507335;
 //BA.debugLineNum = 1507335;BA.debugLine="End Sub";
return "";
}
public String  _asbm_add_background_longclick(b4j.example.asbottommenu __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "asbm_add_background_longclick"))
	 {return ((String) Debug.delegate(ba, "asbm_add_background_longclick", null));}
RDebugUtils.currentLine=1376256;
 //BA.debugLineNum = 1376256;BA.debugLine="Private Sub asbm_add_background_LongClick";
RDebugUtils.currentLine=1376258;
 //BA.debugLineNum = 1376258;BA.debugLine="asbm_add_background_handler_long(Sender)";
__ref._asbm_add_background_handler_long(null,(anywheresoftware.b4j.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper(), (java.lang.Object)(__c.Sender(ba))));
RDebugUtils.currentLine=1376260;
 //BA.debugLineNum = 1376260;BA.debugLine="End Sub";
return "";
}
public String  _asbm_page_1_handler(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper _senderpanel) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "asbm_page_1_handler"))
	 {return ((String) Debug.delegate(ba, "asbm_page_1_handler", new Object[] {_senderpanel}));}
int _cx = 0;
RDebugUtils.currentLine=655360;
 //BA.debugLineNum = 655360;BA.debugLine="private Sub asbm_page_1_handler(SenderPanel As B4X";
RDebugUtils.currentLine=655362;
 //BA.debugLineNum = 655362;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_Page1C";
if (__ref._xui.SubExists(ba,__ref._mcallback,__ref._meventname+"_Page1Click",(int) (0))) { 
RDebugUtils.currentLine=655363;
 //BA.debugLineNum = 655363;BA.debugLine="CallSub(mCallBack, mEventName & \"_Page1Click\")";
__c.CallSubNew(ba,__ref._mcallback,__ref._meventname+"_Page1Click");
 };
RDebugUtils.currentLine=655365;
 //BA.debugLineNum = 655365;BA.debugLine="currentpage = 1";
__ref._currentpage = (int) (1);
RDebugUtils.currentLine=655367;
 //BA.debugLineNum = 655367;BA.debugLine="Dim cx As Int = asbm_page_1.Left + asbm_page_1.Wi";
_cx = (int) (__ref._asbm_page_1.getLeft()+__ref._asbm_page_1.getWidth()/(double)2);
RDebugUtils.currentLine=655369;
 //BA.debugLineNum = 655369;BA.debugLine="asbm_slider.SetLayoutAnimated(500,cx - asbm_slide";
__ref._asbm_slider.SetLayoutAnimated((int) (500),_cx-__ref._asbm_slider.getWidth()/(double)2,__ref._asbm_slider.getTop(),__ref._asbm_slider.getWidth(),__ref._asbm_slider.getHeight());
RDebugUtils.currentLine=655370;
 //BA.debugLineNum = 655370;BA.debugLine="asbm_slider.SetColorAnimated(0,asbm_slider.Color,";
__ref._asbm_slider.SetColorAnimated((int) (0),__ref._asbm_slider.getColor(),__ref._s_color1);
RDebugUtils.currentLine=655373;
 //BA.debugLineNum = 655373;BA.debugLine="If e_SelectedPageColor = True Then";
if (__ref._e_selectedpagecolor==__c.True) { 
RDebugUtils.currentLine=655375;
 //BA.debugLineNum = 655375;BA.debugLine="asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_2.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_2.GetImage().getObject())),__ref._xui.Color_White).getObject()));
RDebugUtils.currentLine=655377;
 //BA.debugLineNum = 655377;BA.debugLine="If Mode = 1 Then";
if (__ref._mode==1) { 
RDebugUtils.currentLine=655379;
 //BA.debugLineNum = 655379;BA.debugLine="asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLev";
__ref._asbm_icon_3.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_3.GetImage().getObject())),__ref._xui.Color_White).getObject()));
RDebugUtils.currentLine=655380;
 //BA.debugLineNum = 655380;BA.debugLine="asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLev";
__ref._asbm_icon_4.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_4.GetImage().getObject())),__ref._xui.Color_White).getObject()));
 };
RDebugUtils.currentLine=655384;
 //BA.debugLineNum = 655384;BA.debugLine="asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_1.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_1.GetImage().getObject())),__ref._s_pagecolor).getObject()));
 };
RDebugUtils.currentLine=655388;
 //BA.debugLineNum = 655388;BA.debugLine="CreateHaloEffect(asbm_page_1, asbm_page_1.Width/2";
__ref._createhaloeffect(null,__ref._asbm_page_1,(int) (__ref._asbm_page_1.getWidth()/(double)2),(int) (__ref._asbm_page_1.getHeight()/(double)2),__ref._p_clickcolor);
RDebugUtils.currentLine=655390;
 //BA.debugLineNum = 655390;BA.debugLine="BringToFront(asbm_icon_1)";
__ref._bringtofront(null,(anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper(), (javafx.scene.Node)(__ref._asbm_icon_1.getObject())));
RDebugUtils.currentLine=655416;
 //BA.debugLineNum = 655416;BA.debugLine="asbm_slider.BringToFront";
__ref._asbm_slider.BringToFront();
RDebugUtils.currentLine=655418;
 //BA.debugLineNum = 655418;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper  _changecolorbasedonalphalevel(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _bmp,int _newcolor) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "changecolorbasedonalphalevel"))
	 {return ((anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) Debug.delegate(ba, "changecolorbasedonalphalevel", new Object[] {_bmp,_newcolor}));}
b4j.example.bitmapcreator _bc = null;
b4j.example.bitmapcreator._argbcolor _a1 = null;
b4j.example.bitmapcreator._argbcolor _a2 = null;
int _y = 0;
int _x = 0;
RDebugUtils.currentLine=1245184;
 //BA.debugLineNum = 1245184;BA.debugLine="Private Sub ChangeColorBasedOnAlphaLevel(bmp As B4";
RDebugUtils.currentLine=1245185;
 //BA.debugLineNum = 1245185;BA.debugLine="Dim bc As BitmapCreator";
_bc = new b4j.example.bitmapcreator();
RDebugUtils.currentLine=1245186;
 //BA.debugLineNum = 1245186;BA.debugLine="bc.Initialize(bmp.Width, bmp.Height)";
_bc._initialize(null,ba,(int) (_bmp.getWidth()),(int) (_bmp.getHeight()));
RDebugUtils.currentLine=1245187;
 //BA.debugLineNum = 1245187;BA.debugLine="bc.CopyPixelsFromBitmap(bmp)";
_bc._copypixelsfrombitmap(null,_bmp);
RDebugUtils.currentLine=1245188;
 //BA.debugLineNum = 1245188;BA.debugLine="Dim a1, a2 As ARGBColor";
_a1 = new b4j.example.bitmapcreator._argbcolor();
_a2 = new b4j.example.bitmapcreator._argbcolor();
RDebugUtils.currentLine=1245189;
 //BA.debugLineNum = 1245189;BA.debugLine="bc.ColorToARGB(NewColor, a1)";
_bc._colortoargb(null,_newcolor,_a1);
RDebugUtils.currentLine=1245190;
 //BA.debugLineNum = 1245190;BA.debugLine="For y = 0 To bc.mHeight - 1";
{
final int step6 = 1;
final int limit6 = (int) (_bc._mheight-1);
_y = (int) (0) ;
for (;_y <= limit6 ;_y = _y + step6 ) {
RDebugUtils.currentLine=1245191;
 //BA.debugLineNum = 1245191;BA.debugLine="For x = 0 To bc.mWidth - 1";
{
final int step7 = 1;
final int limit7 = (int) (_bc._mwidth-1);
_x = (int) (0) ;
for (;_x <= limit7 ;_x = _x + step7 ) {
RDebugUtils.currentLine=1245192;
 //BA.debugLineNum = 1245192;BA.debugLine="bc.GetARGB(x, y, a2)";
_bc._getargb(null,_x,_y,_a2);
RDebugUtils.currentLine=1245193;
 //BA.debugLineNum = 1245193;BA.debugLine="If a2.a > 0 Then";
if (_a2.a>0) { 
RDebugUtils.currentLine=1245194;
 //BA.debugLineNum = 1245194;BA.debugLine="a2.r = a1.r";
_a2.r = _a1.r;
RDebugUtils.currentLine=1245195;
 //BA.debugLineNum = 1245195;BA.debugLine="a2.g = a1.g";
_a2.g = _a1.g;
RDebugUtils.currentLine=1245196;
 //BA.debugLineNum = 1245196;BA.debugLine="a2.b = a1.b";
_a2.b = _a1.b;
RDebugUtils.currentLine=1245197;
 //BA.debugLineNum = 1245197;BA.debugLine="bc.SetARGB(x, y, a2)";
_bc._setargb(null,_x,_y,_a2);
 };
 }
};
 }
};
RDebugUtils.currentLine=1245201;
 //BA.debugLineNum = 1245201;BA.debugLine="Return bc.Bitmap";
if (true) return _bc._getbitmap(null);
RDebugUtils.currentLine=1245202;
 //BA.debugLineNum = 1245202;BA.debugLine="End Sub";
return null;
}
public void  _createhaloeffect(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper _parent,int _x,int _y,int _clr) throws Exception{
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "createhaloeffect"))
	 {Debug.delegate(ba, "createhaloeffect", new Object[] {_parent,_x,_y,_clr}); return;}
ResumableSub_CreateHaloEffect rsub = new ResumableSub_CreateHaloEffect(this,__ref,_parent,_x,_y,_clr);
rsub.resume(ba, null);
}
public static class ResumableSub_CreateHaloEffect extends BA.ResumableSub {
public ResumableSub_CreateHaloEffect(b4j.example.asbottommenu parent,b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper _parent,int _x,int _y,int _clr) {
this.parent = parent;
this.__ref = __ref;
this._parent = _parent;
this._x = _x;
this._y = _y;
this._clr = _clr;
this.__ref = parent;
}
b4j.example.asbottommenu __ref;
b4j.example.asbottommenu parent;
anywheresoftware.b4j.objects.B4XViewWrapper _parent;
int _x;
int _y;
int _clr;
anywheresoftware.b4j.objects.B4XCanvas _cvs = null;
anywheresoftware.b4j.objects.B4XViewWrapper _p = null;
int _radius = 0;
anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _bmp = null;
int _i = 0;
int step8;
int limit8;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="asbottommenu";

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
RDebugUtils.currentLine=1114113;
 //BA.debugLineNum = 1114113;BA.debugLine="Dim cvs As B4XCanvas";
_cvs = new anywheresoftware.b4j.objects.B4XCanvas();
RDebugUtils.currentLine=1114114;
 //BA.debugLineNum = 1114114;BA.debugLine="Dim p As B4XView = xui.CreatePanel(\"\")";
_p = new anywheresoftware.b4j.objects.B4XViewWrapper();
_p = __ref._xui.CreatePanel(ba,"");
RDebugUtils.currentLine=1114115;
 //BA.debugLineNum = 1114115;BA.debugLine="Dim radius As Int = 150dip";
_radius = parent.__c.DipToCurrent((int) (150));
RDebugUtils.currentLine=1114116;
 //BA.debugLineNum = 1114116;BA.debugLine="p.SetLayoutAnimated(0, 0, 0, radius * 2, radius *";
_p.SetLayoutAnimated((int) (0),0,0,_radius*2,_radius*2);
RDebugUtils.currentLine=1114117;
 //BA.debugLineNum = 1114117;BA.debugLine="cvs.Initialize(p)";
_cvs.Initialize(ba,_p);
RDebugUtils.currentLine=1114118;
 //BA.debugLineNum = 1114118;BA.debugLine="cvs.DrawCircle(cvs.TargetRect.CenterX, cvs.Target";
_cvs.DrawCircle(_cvs.getTargetRect().getCenterX(),_cvs.getTargetRect().getCenterY(),(float) (_cvs.getTargetRect().getWidth()/(double)2),_clr,parent.__c.True,(float) (0));
RDebugUtils.currentLine=1114119;
 //BA.debugLineNum = 1114119;BA.debugLine="Dim bmp As B4XBitmap = cvs.CreateBitmap";
_bmp = new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper();
_bmp = _cvs.CreateBitmap();
RDebugUtils.currentLine=1114120;
 //BA.debugLineNum = 1114120;BA.debugLine="For i = 1 To 1";
if (true) break;

case 1:
//for
this.state = 4;
step8 = 1;
limit8 = (int) (1);
_i = (int) (1) ;
this.state = 5;
if (true) break;

case 5:
//C
this.state = 4;
if ((step8 > 0 && _i <= limit8) || (step8 < 0 && _i >= limit8)) this.state = 3;
if (true) break;

case 6:
//C
this.state = 5;
_i = ((int)(0 + _i + step8)) ;
if (true) break;

case 3:
//C
this.state = 6;
RDebugUtils.currentLine=1114121;
 //BA.debugLineNum = 1114121;BA.debugLine="CreateHaloEffectHelper(Parent,bmp, x, y, clr, ra";
__ref._createhaloeffecthelper(null,_parent,_bmp,_x,_y,_clr,_radius);
RDebugUtils.currentLine=1114122;
 //BA.debugLineNum = 1114122;BA.debugLine="Sleep(800)";
parent.__c.Sleep(ba,new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "asbottommenu", "createhaloeffect"),(int) (800));
this.state = 7;
return;
case 7:
//C
this.state = 6;
;
 if (true) break;
if (true) break;

case 4:
//C
this.state = -1;
;
RDebugUtils.currentLine=1114124;
 //BA.debugLineNum = 1114124;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public String  _bringtofront(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper _n) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "bringtofront"))
	 {return ((String) Debug.delegate(ba, "bringtofront", new Object[] {_n}));}
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _parent = null;
RDebugUtils.currentLine=4849664;
 //BA.debugLineNum = 4849664;BA.debugLine="Sub BringToFront(n As Node)";
RDebugUtils.currentLine=4849665;
 //BA.debugLineNum = 4849665;BA.debugLine="Dim parent As Pane = n.Parent";
_parent = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
_parent.setObject((javafx.scene.layout.Pane)(_n.getParent().getObject()));
RDebugUtils.currentLine=4849666;
 //BA.debugLineNum = 4849666;BA.debugLine="n.RemoveNodeFromParent";
_n.RemoveNodeFromParent();
RDebugUtils.currentLine=4849667;
 //BA.debugLineNum = 4849667;BA.debugLine="parent.AddNode(n, n.Left, n.Top, n.PrefWidth, n.P";
_parent.AddNode((javafx.scene.Node)(_n.getObject()),_n.getLeft(),_n.getTop(),_n.getPrefWidth(),_n.getPrefHeight());
RDebugUtils.currentLine=4849668;
 //BA.debugLineNum = 4849668;BA.debugLine="End Sub";
return "";
}
public String  _asbm_page_1_mouseclicked(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "asbm_page_1_mouseclicked"))
	 {return ((String) Debug.delegate(ba, "asbm_page_1_mouseclicked", new Object[] {_eventdata}));}
RDebugUtils.currentLine=5373952;
 //BA.debugLineNum = 5373952;BA.debugLine="Private Sub asbm_page_1_MouseClicked (EventData As";
RDebugUtils.currentLine=5373954;
 //BA.debugLineNum = 5373954;BA.debugLine="asbm_page_1_handler(Sender)";
__ref._asbm_page_1_handler(null,(anywheresoftware.b4j.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper(), (java.lang.Object)(__c.Sender(ba))));
RDebugUtils.currentLine=5373956;
 //BA.debugLineNum = 5373956;BA.debugLine="End Sub";
return "";
}
public String  _asbm_page_2_click(b4j.example.asbottommenu __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "asbm_page_2_click"))
	 {return ((String) Debug.delegate(ba, "asbm_page_2_click", null));}
RDebugUtils.currentLine=720896;
 //BA.debugLineNum = 720896;BA.debugLine="Private Sub asbm_page_2_Click";
RDebugUtils.currentLine=720898;
 //BA.debugLineNum = 720898;BA.debugLine="asbm_page_2_handler(Sender)";
__ref._asbm_page_2_handler(null,(anywheresoftware.b4j.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper(), (java.lang.Object)(__c.Sender(ba))));
RDebugUtils.currentLine=720900;
 //BA.debugLineNum = 720900;BA.debugLine="End Sub";
return "";
}
public String  _asbm_page_2_handler(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper _senderpanel) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "asbm_page_2_handler"))
	 {return ((String) Debug.delegate(ba, "asbm_page_2_handler", new Object[] {_senderpanel}));}
int _cx = 0;
RDebugUtils.currentLine=786432;
 //BA.debugLineNum = 786432;BA.debugLine="Private Sub asbm_page_2_handler(SenderPanel As B4X";
RDebugUtils.currentLine=786434;
 //BA.debugLineNum = 786434;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_Page2C";
if (__ref._xui.SubExists(ba,__ref._mcallback,__ref._meventname+"_Page2Click",(int) (0))) { 
RDebugUtils.currentLine=786435;
 //BA.debugLineNum = 786435;BA.debugLine="CallSub(mCallBack, mEventName & \"_Page2Click\")";
__c.CallSubNew(ba,__ref._mcallback,__ref._meventname+"_Page2Click");
 };
RDebugUtils.currentLine=786437;
 //BA.debugLineNum = 786437;BA.debugLine="currentpage = 2";
__ref._currentpage = (int) (2);
RDebugUtils.currentLine=786438;
 //BA.debugLineNum = 786438;BA.debugLine="Dim cx As Int = asbm_page_2.Left + asbm_page_2.Wi";
_cx = (int) (__ref._asbm_page_2.getLeft()+__ref._asbm_page_2.getWidth()/(double)2);
RDebugUtils.currentLine=786440;
 //BA.debugLineNum = 786440;BA.debugLine="asbm_slider.SetLayoutAnimated(500,cx - asbm_slide";
__ref._asbm_slider.SetLayoutAnimated((int) (500),_cx-__ref._asbm_slider.getWidth()/(double)2,__ref._asbm_slider.getTop(),__ref._asbm_slider.getWidth(),__ref._asbm_slider.getHeight());
RDebugUtils.currentLine=786441;
 //BA.debugLineNum = 786441;BA.debugLine="asbm_slider.SetColorAnimated(0,asbm_slider.Color,";
__ref._asbm_slider.SetColorAnimated((int) (0),__ref._asbm_slider.getColor(),__ref._s_color2);
RDebugUtils.currentLine=786446;
 //BA.debugLineNum = 786446;BA.debugLine="If e_SelectedPageColor = True Then";
if (__ref._e_selectedpagecolor==__c.True) { 
RDebugUtils.currentLine=786448;
 //BA.debugLineNum = 786448;BA.debugLine="asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_1.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_1.GetImage().getObject())),__ref._xui.Color_White).getObject()));
RDebugUtils.currentLine=786450;
 //BA.debugLineNum = 786450;BA.debugLine="If Mode = 1 Then";
if (__ref._mode==1) { 
RDebugUtils.currentLine=786452;
 //BA.debugLineNum = 786452;BA.debugLine="asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLev";
__ref._asbm_icon_3.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_3.GetImage().getObject())),__ref._xui.Color_White).getObject()));
RDebugUtils.currentLine=786453;
 //BA.debugLineNum = 786453;BA.debugLine="asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLev";
__ref._asbm_icon_4.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_4.GetImage().getObject())),__ref._xui.Color_White).getObject()));
 };
RDebugUtils.currentLine=786457;
 //BA.debugLineNum = 786457;BA.debugLine="asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_2.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_2.GetImage().getObject())),__ref._s_pagecolor).getObject()));
 };
RDebugUtils.currentLine=786461;
 //BA.debugLineNum = 786461;BA.debugLine="CreateHaloEffect(asbm_page_2, asbm_page_2.Width/2";
__ref._createhaloeffect(null,__ref._asbm_page_2,(int) (__ref._asbm_page_2.getWidth()/(double)2),(int) (__ref._asbm_page_2.getHeight()/(double)2),__ref._p_clickcolor);
RDebugUtils.currentLine=786462;
 //BA.debugLineNum = 786462;BA.debugLine="BringToFront(asbm_icon_2)";
__ref._bringtofront(null,(anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper(), (javafx.scene.Node)(__ref._asbm_icon_2.getObject())));
RDebugUtils.currentLine=786485;
 //BA.debugLineNum = 786485;BA.debugLine="asbm_slider.BringToFront";
__ref._asbm_slider.BringToFront();
RDebugUtils.currentLine=786489;
 //BA.debugLineNum = 786489;BA.debugLine="End Sub";
return "";
}
public String  _asbm_page_2_mouseclicked(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "asbm_page_2_mouseclicked"))
	 {return ((String) Debug.delegate(ba, "asbm_page_2_mouseclicked", new Object[] {_eventdata}));}
RDebugUtils.currentLine=5505024;
 //BA.debugLineNum = 5505024;BA.debugLine="Private Sub asbm_page_2_MouseClicked (EventData As";
RDebugUtils.currentLine=5505026;
 //BA.debugLineNum = 5505026;BA.debugLine="asbm_page_2_handler(Sender)";
__ref._asbm_page_2_handler(null,(anywheresoftware.b4j.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper(), (java.lang.Object)(__c.Sender(ba))));
RDebugUtils.currentLine=5505028;
 //BA.debugLineNum = 5505028;BA.debugLine="End Sub";
return "";
}
public String  _asbm_page_3_click(b4j.example.asbottommenu __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "asbm_page_3_click"))
	 {return ((String) Debug.delegate(ba, "asbm_page_3_click", null));}
RDebugUtils.currentLine=851968;
 //BA.debugLineNum = 851968;BA.debugLine="Private Sub asbm_page_3_Click";
RDebugUtils.currentLine=851970;
 //BA.debugLineNum = 851970;BA.debugLine="asbm_page_3_handler(Sender)";
__ref._asbm_page_3_handler(null,(anywheresoftware.b4j.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper(), (java.lang.Object)(__c.Sender(ba))));
RDebugUtils.currentLine=851972;
 //BA.debugLineNum = 851972;BA.debugLine="End Sub";
return "";
}
public String  _asbm_page_3_handler(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper _senderpanel) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "asbm_page_3_handler"))
	 {return ((String) Debug.delegate(ba, "asbm_page_3_handler", new Object[] {_senderpanel}));}
int _cx = 0;
RDebugUtils.currentLine=917504;
 //BA.debugLineNum = 917504;BA.debugLine="Private Sub asbm_page_3_handler(SenderPanel As B4X";
RDebugUtils.currentLine=917506;
 //BA.debugLineNum = 917506;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_Page3C";
if (__ref._xui.SubExists(ba,__ref._mcallback,__ref._meventname+"_Page3Click",(int) (0))) { 
RDebugUtils.currentLine=917507;
 //BA.debugLineNum = 917507;BA.debugLine="CallSub(mCallBack, mEventName & \"_Page3Click\")";
__c.CallSubNew(ba,__ref._mcallback,__ref._meventname+"_Page3Click");
 };
RDebugUtils.currentLine=917509;
 //BA.debugLineNum = 917509;BA.debugLine="currentpage = 3";
__ref._currentpage = (int) (3);
RDebugUtils.currentLine=917511;
 //BA.debugLineNum = 917511;BA.debugLine="Dim cx As Int = asbm_page_3.Left + asbm_page_3.Wi";
_cx = (int) (__ref._asbm_page_3.getLeft()+__ref._asbm_page_3.getWidth()/(double)2);
RDebugUtils.currentLine=917513;
 //BA.debugLineNum = 917513;BA.debugLine="asbm_slider.SetLayoutAnimated(500,cx - asbm_slide";
__ref._asbm_slider.SetLayoutAnimated((int) (500),_cx-__ref._asbm_slider.getWidth()/(double)2,__ref._asbm_slider.getTop(),__ref._asbm_slider.getWidth(),__ref._asbm_slider.getHeight());
RDebugUtils.currentLine=917514;
 //BA.debugLineNum = 917514;BA.debugLine="asbm_slider.SetColorAnimated(0,asbm_slider.Color,";
__ref._asbm_slider.SetColorAnimated((int) (0),__ref._asbm_slider.getColor(),__ref._s_color3);
RDebugUtils.currentLine=917518;
 //BA.debugLineNum = 917518;BA.debugLine="If e_SelectedPageColor = True Then";
if (__ref._e_selectedpagecolor==__c.True) { 
RDebugUtils.currentLine=917520;
 //BA.debugLineNum = 917520;BA.debugLine="asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_1.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_1.GetImage().getObject())),__ref._xui.Color_White).getObject()));
RDebugUtils.currentLine=917521;
 //BA.debugLineNum = 917521;BA.debugLine="asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_2.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_2.GetImage().getObject())),__ref._xui.Color_White).getObject()));
RDebugUtils.currentLine=917522;
 //BA.debugLineNum = 917522;BA.debugLine="asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_4.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_4.GetImage().getObject())),__ref._xui.Color_White).getObject()));
RDebugUtils.currentLine=917524;
 //BA.debugLineNum = 917524;BA.debugLine="asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_3.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_3.GetImage().getObject())),__ref._s_pagecolor).getObject()));
 };
RDebugUtils.currentLine=917528;
 //BA.debugLineNum = 917528;BA.debugLine="CreateHaloEffect(asbm_page_3, asbm_page_3.Width/2";
__ref._createhaloeffect(null,__ref._asbm_page_3,(int) (__ref._asbm_page_3.getWidth()/(double)2),(int) (__ref._asbm_page_3.getHeight()/(double)2),__ref._p_clickcolor);
RDebugUtils.currentLine=917529;
 //BA.debugLineNum = 917529;BA.debugLine="BringToFront(asbm_icon_3)";
__ref._bringtofront(null,(anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper(), (javafx.scene.Node)(__ref._asbm_icon_3.getObject())));
RDebugUtils.currentLine=917549;
 //BA.debugLineNum = 917549;BA.debugLine="asbm_slider.BringToFront";
__ref._asbm_slider.BringToFront();
RDebugUtils.currentLine=917552;
 //BA.debugLineNum = 917552;BA.debugLine="End Sub";
return "";
}
public String  _asbm_page_3_mouseclicked(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "asbm_page_3_mouseclicked"))
	 {return ((String) Debug.delegate(ba, "asbm_page_3_mouseclicked", new Object[] {_eventdata}));}
RDebugUtils.currentLine=5570560;
 //BA.debugLineNum = 5570560;BA.debugLine="Private Sub asbm_page_3_MouseClicked (EventData As";
RDebugUtils.currentLine=5570562;
 //BA.debugLineNum = 5570562;BA.debugLine="asbm_page_3_handler(Sender)";
__ref._asbm_page_3_handler(null,(anywheresoftware.b4j.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper(), (java.lang.Object)(__c.Sender(ba))));
RDebugUtils.currentLine=5570564;
 //BA.debugLineNum = 5570564;BA.debugLine="End Sub";
return "";
}
public String  _asbm_page_4_handler(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper _senderpanel) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "asbm_page_4_handler"))
	 {return ((String) Debug.delegate(ba, "asbm_page_4_handler", new Object[] {_senderpanel}));}
int _cx = 0;
RDebugUtils.currentLine=1048576;
 //BA.debugLineNum = 1048576;BA.debugLine="Private Sub asbm_page_4_handler(SenderPanel As B4X";
RDebugUtils.currentLine=1048578;
 //BA.debugLineNum = 1048578;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_Page4C";
if (__ref._xui.SubExists(ba,__ref._mcallback,__ref._meventname+"_Page4Click",(int) (0))) { 
RDebugUtils.currentLine=1048579;
 //BA.debugLineNum = 1048579;BA.debugLine="CallSub(mCallBack, mEventName & \"_Page4Click\")";
__c.CallSubNew(ba,__ref._mcallback,__ref._meventname+"_Page4Click");
 };
RDebugUtils.currentLine=1048581;
 //BA.debugLineNum = 1048581;BA.debugLine="currentpage = 4";
__ref._currentpage = (int) (4);
RDebugUtils.currentLine=1048583;
 //BA.debugLineNum = 1048583;BA.debugLine="Dim cx As Int = asbm_page_4.Left + asbm_page_4.Wi";
_cx = (int) (__ref._asbm_page_4.getLeft()+__ref._asbm_page_4.getWidth()/(double)2);
RDebugUtils.currentLine=1048585;
 //BA.debugLineNum = 1048585;BA.debugLine="asbm_slider.SetLayoutAnimated(500,cx - asbm_slide";
__ref._asbm_slider.SetLayoutAnimated((int) (500),_cx-__ref._asbm_slider.getWidth()/(double)2,__ref._asbm_slider.getTop(),__ref._asbm_slider.getWidth(),__ref._asbm_slider.getHeight());
RDebugUtils.currentLine=1048586;
 //BA.debugLineNum = 1048586;BA.debugLine="asbm_slider.SetColorAnimated(0,asbm_slider.Color,";
__ref._asbm_slider.SetColorAnimated((int) (0),__ref._asbm_slider.getColor(),__ref._s_color4);
RDebugUtils.currentLine=1048590;
 //BA.debugLineNum = 1048590;BA.debugLine="If e_SelectedPageColor = True Then";
if (__ref._e_selectedpagecolor==__c.True) { 
RDebugUtils.currentLine=1048592;
 //BA.debugLineNum = 1048592;BA.debugLine="asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_1.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_1.GetImage().getObject())),__ref._xui.Color_White).getObject()));
RDebugUtils.currentLine=1048593;
 //BA.debugLineNum = 1048593;BA.debugLine="asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_2.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_2.GetImage().getObject())),__ref._xui.Color_White).getObject()));
RDebugUtils.currentLine=1048594;
 //BA.debugLineNum = 1048594;BA.debugLine="asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_3.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_3.GetImage().getObject())),__ref._xui.Color_White).getObject()));
RDebugUtils.currentLine=1048597;
 //BA.debugLineNum = 1048597;BA.debugLine="asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLeve";
__ref._asbm_icon_4.SetImage((javafx.scene.image.Image)(__ref._changecolorbasedonalphalevel(null,(anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper(), (javafx.scene.image.Image)(__ref._asbm_icon_4.GetImage().getObject())),__ref._s_pagecolor).getObject()));
 };
RDebugUtils.currentLine=1048601;
 //BA.debugLineNum = 1048601;BA.debugLine="CreateHaloEffect(asbm_page_4, asbm_page_4.Width/2";
__ref._createhaloeffect(null,__ref._asbm_page_4,(int) (__ref._asbm_page_4.getWidth()/(double)2),(int) (__ref._asbm_page_4.getHeight()/(double)2),__ref._p_clickcolor);
RDebugUtils.currentLine=1048603;
 //BA.debugLineNum = 1048603;BA.debugLine="BringToFront(asbm_icon_4)";
__ref._bringtofront(null,(anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper(), (javafx.scene.Node)(__ref._asbm_icon_4.getObject())));
RDebugUtils.currentLine=1048625;
 //BA.debugLineNum = 1048625;BA.debugLine="asbm_slider.BringToFront";
__ref._asbm_slider.BringToFront();
RDebugUtils.currentLine=1048627;
 //BA.debugLineNum = 1048627;BA.debugLine="End Sub";
return "";
}
public String  _asbm_page_4_mouseclicked(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "asbm_page_4_mouseclicked"))
	 {return ((String) Debug.delegate(ba, "asbm_page_4_mouseclicked", new Object[] {_eventdata}));}
RDebugUtils.currentLine=5636096;
 //BA.debugLineNum = 5636096;BA.debugLine="Private Sub asbm_page_4_MouseClicked (EventData As";
RDebugUtils.currentLine=5636098;
 //BA.debugLineNum = 5636098;BA.debugLine="asbm_page_4_handler(Sender)";
__ref._asbm_page_4_handler(null,(anywheresoftware.b4j.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.B4XViewWrapper(), (java.lang.Object)(__c.Sender(ba))));
RDebugUtils.currentLine=5636100;
 //BA.debugLineNum = 5636100;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4j.example.asbottommenu __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
RDebugUtils.currentLine=196608;
 //BA.debugLineNum = 196608;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=196610;
 //BA.debugLineNum = 196610;BA.debugLine="Private mEventName As String 'ignore";
_meventname = "";
RDebugUtils.currentLine=196611;
 //BA.debugLineNum = 196611;BA.debugLine="Private mCallBack As Object 'ignore";
_mcallback = new Object();
RDebugUtils.currentLine=196612;
 //BA.debugLineNum = 196612;BA.debugLine="Private mBase As B4XView";
_mbase = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=196614;
 //BA.debugLineNum = 196614;BA.debugLine="Private Const DefaultColorConstant As Int = -9848";
_defaultcolorconstant = (int) (-984833);
RDebugUtils.currentLine=196616;
 //BA.debugLineNum = 196616;BA.debugLine="Private currentpage As Int = 1";
_currentpage = (int) (1);
RDebugUtils.currentLine=196618;
 //BA.debugLineNum = 196618;BA.debugLine="Private xui As XUI";
_xui = new anywheresoftware.b4j.objects.B4XViewWrapper.XUI();
RDebugUtils.currentLine=196620;
 //BA.debugLineNum = 196620;BA.debugLine="Private asbm_page_1,asbm_page_2,asbm_page_3,asbm_";
_asbm_page_1 = new anywheresoftware.b4j.objects.B4XViewWrapper();
_asbm_page_2 = new anywheresoftware.b4j.objects.B4XViewWrapper();
_asbm_page_3 = new anywheresoftware.b4j.objects.B4XViewWrapper();
_asbm_page_4 = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=196621;
 //BA.debugLineNum = 196621;BA.debugLine="Private asbm_icon_1,asbm_icon_2,asbm_icon_3,asbm_";
_asbm_icon_1 = new anywheresoftware.b4j.objects.ImageViewWrapper();
_asbm_icon_2 = new anywheresoftware.b4j.objects.ImageViewWrapper();
_asbm_icon_3 = new anywheresoftware.b4j.objects.ImageViewWrapper();
_asbm_icon_4 = new anywheresoftware.b4j.objects.ImageViewWrapper();
RDebugUtils.currentLine=196622;
 //BA.debugLineNum = 196622;BA.debugLine="Private asbm_badget_1,asbm_badget_2,asbm_badget_3";
_asbm_badget_1 = new anywheresoftware.b4j.objects.B4XViewWrapper();
_asbm_badget_2 = new anywheresoftware.b4j.objects.B4XViewWrapper();
_asbm_badget_3 = new anywheresoftware.b4j.objects.B4XViewWrapper();
_asbm_badget_4 = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=196623;
 //BA.debugLineNum = 196623;BA.debugLine="Private asbm_slider As B4XView";
_asbm_slider = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=196626;
 //BA.debugLineNum = 196626;BA.debugLine="Private asbm_add_icon As B4XView";
_asbm_add_icon = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=196627;
 //BA.debugLineNum = 196627;BA.debugLine="Private asbm_add_background As B4XView";
_asbm_add_background = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=196629;
 //BA.debugLineNum = 196629;BA.debugLine="Private asbm_parting_line As B4XView";
_asbm_parting_line = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=196631;
 //BA.debugLineNum = 196631;BA.debugLine="Private asbm_page_background As B4XView";
_asbm_page_background = new anywheresoftware.b4j.objects.B4XViewWrapper();
RDebugUtils.currentLine=196638;
 //BA.debugLineNum = 196638;BA.debugLine="Private s_Color1 As Int";
_s_color1 = 0;
RDebugUtils.currentLine=196639;
 //BA.debugLineNum = 196639;BA.debugLine="Private s_Color2 As Int";
_s_color2 = 0;
RDebugUtils.currentLine=196640;
 //BA.debugLineNum = 196640;BA.debugLine="Private s_Color3 As Int";
_s_color3 = 0;
RDebugUtils.currentLine=196641;
 //BA.debugLineNum = 196641;BA.debugLine="Private s_Color4 As Int";
_s_color4 = 0;
RDebugUtils.currentLine=196643;
 //BA.debugLineNum = 196643;BA.debugLine="Private b_Color As Int";
_b_color = 0;
RDebugUtils.currentLine=196645;
 //BA.debugLineNum = 196645;BA.debugLine="Private p_Line As Int";
_p_line = 0;
RDebugUtils.currentLine=196647;
 //BA.debugLineNum = 196647;BA.debugLine="Private m_BackgroundColor As Int";
_m_backgroundcolor = 0;
RDebugUtils.currentLine=196649;
 //BA.debugLineNum = 196649;BA.debugLine="Private e_BadgetColor1 As Boolean";
_e_badgetcolor1 = false;
RDebugUtils.currentLine=196650;
 //BA.debugLineNum = 196650;BA.debugLine="Private e_BadgetColor2 As Boolean";
_e_badgetcolor2 = false;
RDebugUtils.currentLine=196651;
 //BA.debugLineNum = 196651;BA.debugLine="Private e_BadgetColor3 As Boolean";
_e_badgetcolor3 = false;
RDebugUtils.currentLine=196652;
 //BA.debugLineNum = 196652;BA.debugLine="Private e_BadgetColor4 As Boolean";
_e_badgetcolor4 = false;
RDebugUtils.currentLine=196654;
 //BA.debugLineNum = 196654;BA.debugLine="Private b_color1 As Int";
_b_color1 = 0;
RDebugUtils.currentLine=196655;
 //BA.debugLineNum = 196655;BA.debugLine="Private b_color2 As Int";
_b_color2 = 0;
RDebugUtils.currentLine=196656;
 //BA.debugLineNum = 196656;BA.debugLine="Private b_color3 As Int";
_b_color3 = 0;
RDebugUtils.currentLine=196657;
 //BA.debugLineNum = 196657;BA.debugLine="Private b_color4 As Int";
_b_color4 = 0;
RDebugUtils.currentLine=196659;
 //BA.debugLineNum = 196659;BA.debugLine="Private p_ClickColor As Int";
_p_clickcolor = 0;
RDebugUtils.currentLine=196661;
 //BA.debugLineNum = 196661;BA.debugLine="Private e_SelectedPageColor As Boolean";
_e_selectedpagecolor = false;
RDebugUtils.currentLine=196663;
 //BA.debugLineNum = 196663;BA.debugLine="Private s_PageColor As Int";
_s_pagecolor = 0;
RDebugUtils.currentLine=196665;
 //BA.debugLineNum = 196665;BA.debugLine="Private MiddleButtonVisible As Boolean";
_middlebuttonvisible = false;
RDebugUtils.currentLine=196669;
 //BA.debugLineNum = 196669;BA.debugLine="Private icon1 As B4XBitmap";
_icon1 = new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper();
RDebugUtils.currentLine=196670;
 //BA.debugLineNum = 196670;BA.debugLine="Private icon2 As B4XBitmap";
_icon2 = new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper();
RDebugUtils.currentLine=196671;
 //BA.debugLineNum = 196671;BA.debugLine="Private icon3 As B4XBitmap";
_icon3 = new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper();
RDebugUtils.currentLine=196672;
 //BA.debugLineNum = 196672;BA.debugLine="Private icon4 As B4XBitmap";
_icon4 = new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper();
RDebugUtils.currentLine=196674;
 //BA.debugLineNum = 196674;BA.debugLine="Private middleicon As B4XBitmap";
_middleicon = new anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper();
RDebugUtils.currentLine=196676;
 //BA.debugLineNum = 196676;BA.debugLine="Private TypeOfMenu As String = \"4 Icon Tabs\"";
_typeofmenu = "4 Icon Tabs";
RDebugUtils.currentLine=196678;
 //BA.debugLineNum = 196678;BA.debugLine="Private Mode As Int = 1";
_mode = (int) (1);
RDebugUtils.currentLine=196680;
 //BA.debugLineNum = 196680;BA.debugLine="End Sub";
return "";
}
public void  _createhaloeffecthelper(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper _parent,anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _bmp,int _x,int _y,int _clr,int _radius) throws Exception{
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "createhaloeffecthelper"))
	 {Debug.delegate(ba, "createhaloeffecthelper", new Object[] {_parent,_bmp,_x,_y,_clr,_radius}); return;}
ResumableSub_CreateHaloEffectHelper rsub = new ResumableSub_CreateHaloEffectHelper(this,__ref,_parent,_bmp,_x,_y,_clr,_radius);
rsub.resume(ba, null);
}
public static class ResumableSub_CreateHaloEffectHelper extends BA.ResumableSub {
public ResumableSub_CreateHaloEffectHelper(b4j.example.asbottommenu parent,b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper _parent,anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _bmp,int _x,int _y,int _clr,int _radius) {
this.parent = parent;
this.__ref = __ref;
this._parent = _parent;
this._bmp = _bmp;
this._x = _x;
this._y = _y;
this._clr = _clr;
this._radius = _radius;
this.__ref = parent;
}
b4j.example.asbottommenu __ref;
b4j.example.asbottommenu parent;
anywheresoftware.b4j.objects.B4XViewWrapper _parent;
anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _bmp;
int _x;
int _y;
int _clr;
int _radius;
anywheresoftware.b4j.objects.ImageViewWrapper _iv = null;
anywheresoftware.b4j.objects.B4XViewWrapper _p = null;
int _duration = 0;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="asbottommenu";

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = -1;
RDebugUtils.currentLine=1179649;
 //BA.debugLineNum = 1179649;BA.debugLine="Dim iv As ImageView";
_iv = new anywheresoftware.b4j.objects.ImageViewWrapper();
RDebugUtils.currentLine=1179650;
 //BA.debugLineNum = 1179650;BA.debugLine="iv.Initialize(\"\")";
_iv.Initialize(ba,"");
RDebugUtils.currentLine=1179651;
 //BA.debugLineNum = 1179651;BA.debugLine="Dim p As B4XView = iv";
_p = new anywheresoftware.b4j.objects.B4XViewWrapper();
_p.setObject((java.lang.Object)(_iv.getObject()));
RDebugUtils.currentLine=1179652;
 //BA.debugLineNum = 1179652;BA.debugLine="p.SetBitmap(bmp)";
_p.SetBitmap((javafx.scene.image.Image)(_bmp.getObject()));
RDebugUtils.currentLine=1179653;
 //BA.debugLineNum = 1179653;BA.debugLine="Parent.AddView(p, x, y, 0, 0)";
_parent.AddView((javafx.scene.Node)(_p.getObject()),_x,_y,0,0);
RDebugUtils.currentLine=1179654;
 //BA.debugLineNum = 1179654;BA.debugLine="Dim duration As Int = 1000";
_duration = (int) (1000);
RDebugUtils.currentLine=1179655;
 //BA.debugLineNum = 1179655;BA.debugLine="p.SetLayoutAnimated(duration, x - radius, y - rad";
_p.SetLayoutAnimated(_duration,_x-_radius,_y-_radius,2*_radius,2*_radius);
RDebugUtils.currentLine=1179656;
 //BA.debugLineNum = 1179656;BA.debugLine="p.SetVisibleAnimated(duration, False)";
_p.SetVisibleAnimated(ba,_duration,parent.__c.False);
RDebugUtils.currentLine=1179657;
 //BA.debugLineNum = 1179657;BA.debugLine="Sleep(duration)";
parent.__c.Sleep(ba,new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "asbottommenu", "createhaloeffecthelper"),_duration);
this.state = 1;
return;
case 1:
//C
this.state = -1;
;
RDebugUtils.currentLine=1179658;
 //BA.debugLineNum = 1179658;BA.debugLine="p.RemoveViewFromParent";
_p.RemoveViewFromParent();
RDebugUtils.currentLine=1179659;
 //BA.debugLineNum = 1179659;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public String  _designercreateview(b4j.example.asbottommenu __ref,Object _base,anywheresoftware.b4j.objects.LabelWrapper _lbl,anywheresoftware.b4a.objects.collections.Map _props) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "designercreateview"))
	 {return ((String) Debug.delegate(ba, "designercreateview", new Object[] {_base,_lbl,_props}));}
int _cx = 0;
int _cy = 0;
RDebugUtils.currentLine=458752;
 //BA.debugLineNum = 458752;BA.debugLine="Public Sub DesignerCreateView (Base As Object, Lbl";
RDebugUtils.currentLine=458753;
 //BA.debugLineNum = 458753;BA.debugLine="mBase = Base";
__ref._mbase.setObject((java.lang.Object)(_base));
RDebugUtils.currentLine=458756;
 //BA.debugLineNum = 458756;BA.debugLine="mBase.SetLayoutAnimated(0, mBase.Left, mBase.Top";
__ref._mbase.SetLayoutAnimated((int) (0),__ref._mbase.getLeft(),__ref._mbase.getTop(),__ref._mbase.getWidth(),__ref._mbase.getHeight());
RDebugUtils.currentLine=458759;
 //BA.debugLineNum = 458759;BA.debugLine="mBase.Color = xui.Color_Transparent";
__ref._mbase.setColor(__ref._xui.Color_Transparent);
RDebugUtils.currentLine=458763;
 //BA.debugLineNum = 458763;BA.debugLine="TypeOfMenu =  Props.Get(\"TypeOfMenu\")";
__ref._typeofmenu = BA.ObjectToString(_props.Get((Object)("TypeOfMenu")));
RDebugUtils.currentLine=458765;
 //BA.debugLineNum = 458765;BA.debugLine="If TypeOfMenu = \"4 Icon Tabs\" Then";
if ((__ref._typeofmenu).equals("4 Icon Tabs")) { 
RDebugUtils.currentLine=458767;
 //BA.debugLineNum = 458767;BA.debugLine="Mode = 1";
__ref._mode = (int) (1);
RDebugUtils.currentLine=458769;
 //BA.debugLineNum = 458769;BA.debugLine="IconTabs4(Props)";
__ref._icontabs4(null,_props);
RDebugUtils.currentLine=458772;
 //BA.debugLineNum = 458772;BA.debugLine="asbm_page_background.Color = b_Color";
__ref._asbm_page_background.setColor(__ref._b_color);
RDebugUtils.currentLine=458774;
 //BA.debugLineNum = 458774;BA.debugLine="mBase.AddView(asbm_page_background,0,mBase.Heigh";
__ref._mbase.AddView((javafx.scene.Node)(__ref._asbm_page_background.getObject()),0,__ref._mbase.getHeight()/(double)2.5,__ref._mbase.getWidth(),__ref._mbase.getHeight());
RDebugUtils.currentLine=458776;
 //BA.debugLineNum = 458776;BA.debugLine="asbm_page_background.Top = mBase.Height/2.5 'mBa";
__ref._asbm_page_background.setTop(__ref._mbase.getHeight()/(double)2.5);
RDebugUtils.currentLine=458777;
 //BA.debugLineNum = 458777;BA.debugLine="asbm_page_background.Height = mBase.Height - asb";
__ref._asbm_page_background.setHeight(__ref._mbase.getHeight()-__ref._asbm_page_background.getTop());
RDebugUtils.currentLine=458779;
 //BA.debugLineNum = 458779;BA.debugLine="mBase.AddView(asbm_parting_line,0,mBase.Height/2";
__ref._mbase.AddView((javafx.scene.Node)(__ref._asbm_parting_line.getObject()),0,__ref._mbase.getHeight()/(double)2.5,__ref._mbase.getWidth(),__ref._asbm_parting_line.getHeight());
RDebugUtils.currentLine=458781;
 //BA.debugLineNum = 458781;BA.debugLine="mBase.AddView(asbm_add_background,mBase.Width /";
__ref._mbase.AddView((javafx.scene.Node)(__ref._asbm_add_background.getObject()),__ref._mbase.getWidth()/(double)2-__ref._asbm_add_background.getWidth()/(double)2,0,__ref._mbase.getHeight()/(double)1.2,__ref._mbase.getHeight()/(double)1.2);
RDebugUtils.currentLine=458784;
 //BA.debugLineNum = 458784;BA.debugLine="asbm_add_background.SetColorAndBorder(m_Backgrou";
__ref._asbm_add_background.SetColorAndBorder(__ref._m_backgroundcolor,__c.DipToCurrent((int) (3)),__ref._xui.Color_White,__ref._asbm_add_background.getHeight()/(double)2);
RDebugUtils.currentLine=458788;
 //BA.debugLineNum = 458788;BA.debugLine="asbm_add_background.AddView(asbm_add_icon,10dip,";
__ref._asbm_add_background.AddView((javafx.scene.Node)(__ref._asbm_add_icon.getObject()),__c.DipToCurrent((int) (10)),__c.DipToCurrent((int) (10)),__ref._asbm_add_background.getWidth()/(double)2.5,__ref._asbm_add_background.getHeight()/(double)2.5);
RDebugUtils.currentLine=458790;
 //BA.debugLineNum = 458790;BA.debugLine="asbm_add_icon.Left = asbm_add_background.Width /";
__ref._asbm_add_icon.setLeft(__ref._asbm_add_background.getWidth()/(double)2-__ref._asbm_add_icon.getWidth()/(double)2);
RDebugUtils.currentLine=458791;
 //BA.debugLineNum = 458791;BA.debugLine="asbm_add_icon.Top = asbm_add_background.Height /";
__ref._asbm_add_icon.setTop(__ref._asbm_add_background.getHeight()/(double)2-__ref._asbm_add_icon.getHeight()/(double)2);
RDebugUtils.currentLine=458795;
 //BA.debugLineNum = 458795;BA.debugLine="If MiddleButtonVisible = True Then";
if (__ref._middlebuttonvisible==__c.True) { 
RDebugUtils.currentLine=458797;
 //BA.debugLineNum = 458797;BA.debugLine="asbm_page_background.AddView(asbm_page_1,0,3dip";
__ref._asbm_page_background.AddView((javafx.scene.Node)(__ref._asbm_page_1.getObject()),0,__c.DipToCurrent((int) (3)),__ref._asbm_add_background.getLeft()/(double)2,__ref._asbm_page_background.getHeight());
 }else {
RDebugUtils.currentLine=458801;
 //BA.debugLineNum = 458801;BA.debugLine="asbm_page_background.AddView(asbm_page_1,0,3dip";
__ref._asbm_page_background.AddView((javafx.scene.Node)(__ref._asbm_page_1.getObject()),0,__c.DipToCurrent((int) (3)),__ref._asbm_page_background.getWidth()/(double)4,__ref._asbm_page_background.getHeight());
 };
RDebugUtils.currentLine=458810;
 //BA.debugLineNum = 458810;BA.debugLine="If MiddleButtonVisible = True Then";
if (__ref._middlebuttonvisible==__c.True) { 
RDebugUtils.currentLine=458811;
 //BA.debugLineNum = 458811;BA.debugLine="asbm_page_background.AddView(asbm_page_2,asbm_pa";
__ref._asbm_page_background.AddView((javafx.scene.Node)(__ref._asbm_page_2.getObject()),__ref._asbm_page_1.getWidth(),__c.DipToCurrent((int) (3)),__ref._asbm_add_background.getLeft()/(double)2,__ref._asbm_page_background.getHeight());
 }else {
RDebugUtils.currentLine=458813;
 //BA.debugLineNum = 458813;BA.debugLine="asbm_page_background.AddView(asbm_page_2,asbm_p";
__ref._asbm_page_background.AddView((javafx.scene.Node)(__ref._asbm_page_2.getObject()),__ref._asbm_page_1.getWidth(),__c.DipToCurrent((int) (3)),__ref._asbm_page_background.getWidth()/(double)4,__ref._asbm_page_background.getHeight());
 };
RDebugUtils.currentLine=458817;
 //BA.debugLineNum = 458817;BA.debugLine="asbm_page_4.Width = asbm_page_background.Height";
__ref._asbm_page_4.setWidth(__ref._asbm_page_background.getHeight()+__c.DipToCurrent((int) (5)));
RDebugUtils.currentLine=458821;
 //BA.debugLineNum = 458821;BA.debugLine="asbm_page_3.Width = asbm_page_background.Height";
__ref._asbm_page_3.setWidth(__ref._asbm_page_background.getHeight()+__c.DipToCurrent((int) (5)));
RDebugUtils.currentLine=458824;
 //BA.debugLineNum = 458824;BA.debugLine="If MiddleButtonVisible = True Then";
if (__ref._middlebuttonvisible==__c.True) { 
RDebugUtils.currentLine=458825;
 //BA.debugLineNum = 458825;BA.debugLine="asbm_page_background.AddView(asbm_page_3,asbm_ad";
__ref._asbm_page_background.AddView((javafx.scene.Node)(__ref._asbm_page_3.getObject()),__ref._asbm_add_background.getLeft()+__ref._asbm_add_background.getWidth(),__c.DipToCurrent((int) (3)),__ref._asbm_add_background.getLeft()/(double)2,__ref._asbm_page_background.getHeight());
 }else {
RDebugUtils.currentLine=458827;
 //BA.debugLineNum = 458827;BA.debugLine="asbm_page_background.AddView(asbm_page_3,asbm_p";
__ref._asbm_page_background.AddView((javafx.scene.Node)(__ref._asbm_page_3.getObject()),__ref._asbm_page_2.getLeft()+__ref._asbm_page_2.getWidth(),__c.DipToCurrent((int) (3)),__ref._asbm_page_background.getWidth()/(double)4,__ref._asbm_page_background.getHeight());
 };
RDebugUtils.currentLine=458832;
 //BA.debugLineNum = 458832;BA.debugLine="If MiddleButtonVisible = True Then";
if (__ref._middlebuttonvisible==__c.True) { 
RDebugUtils.currentLine=458833;
 //BA.debugLineNum = 458833;BA.debugLine="asbm_page_background.AddView(asbm_page_4,asbm_pa";
__ref._asbm_page_background.AddView((javafx.scene.Node)(__ref._asbm_page_4.getObject()),__ref._asbm_page_3.getLeft()+__ref._asbm_page_3.getWidth(),__c.DipToCurrent((int) (3)),__ref._asbm_add_background.getLeft()/(double)2,__ref._asbm_page_background.getHeight());
 }else {
RDebugUtils.currentLine=458835;
 //BA.debugLineNum = 458835;BA.debugLine="asbm_page_background.AddView(asbm_page_4,asbm_p";
__ref._asbm_page_background.AddView((javafx.scene.Node)(__ref._asbm_page_4.getObject()),__ref._asbm_page_3.getLeft()+__ref._asbm_page_3.getWidth(),__c.DipToCurrent((int) (3)),__ref._asbm_page_background.getWidth()/(double)4,__ref._asbm_page_background.getHeight());
 };
RDebugUtils.currentLine=458839;
 //BA.debugLineNum = 458839;BA.debugLine="asbm_icon_1.Height = asbm_page_background.Height";
__ref._asbm_icon_1.setHeight(__ref._asbm_page_background.getHeight()/(double)2.5);
RDebugUtils.currentLine=458840;
 //BA.debugLineNum = 458840;BA.debugLine="asbm_icon_1.Width = asbm_page_background.Height/";
__ref._asbm_icon_1.setWidth(__ref._asbm_page_background.getHeight()/(double)2.5);
RDebugUtils.currentLine=458843;
 //BA.debugLineNum = 458843;BA.debugLine="asbm_icon_2.Height = asbm_page_background.Height";
__ref._asbm_icon_2.setHeight(__ref._asbm_page_background.getHeight()/(double)2.5);
RDebugUtils.currentLine=458844;
 //BA.debugLineNum = 458844;BA.debugLine="asbm_icon_2.Width = asbm_page_background.Height/";
__ref._asbm_icon_2.setWidth(__ref._asbm_page_background.getHeight()/(double)2.5);
RDebugUtils.currentLine=458847;
 //BA.debugLineNum = 458847;BA.debugLine="asbm_icon_3.Height = asbm_page_background.Height";
__ref._asbm_icon_3.setHeight(__ref._asbm_page_background.getHeight()/(double)2.5);
RDebugUtils.currentLine=458848;
 //BA.debugLineNum = 458848;BA.debugLine="asbm_icon_3.Width = asbm_page_background.Height/";
__ref._asbm_icon_3.setWidth(__ref._asbm_page_background.getHeight()/(double)2.5);
RDebugUtils.currentLine=458850;
 //BA.debugLineNum = 458850;BA.debugLine="asbm_icon_4.Height = asbm_page_background.Height";
__ref._asbm_icon_4.setHeight(__ref._asbm_page_background.getHeight()/(double)2.5);
RDebugUtils.currentLine=458851;
 //BA.debugLineNum = 458851;BA.debugLine="asbm_icon_4.Width = asbm_page_background.Height/";
__ref._asbm_icon_4.setWidth(__ref._asbm_page_background.getHeight()/(double)2.5);
RDebugUtils.currentLine=458854;
 //BA.debugLineNum = 458854;BA.debugLine="Dim cx,cy As Int";
_cx = 0;
_cy = 0;
RDebugUtils.currentLine=458855;
 //BA.debugLineNum = 458855;BA.debugLine="cx = asbm_page_1.Left + asbm_page_1.Width/2";
_cx = (int) (__ref._asbm_page_1.getLeft()+__ref._asbm_page_1.getWidth()/(double)2);
RDebugUtils.currentLine=458856;
 //BA.debugLineNum = 458856;BA.debugLine="cy = asbm_page_1.Top + asbm_page_1.Height/2.5";
_cy = (int) (__ref._asbm_page_1.getTop()+__ref._asbm_page_1.getHeight()/(double)2.5);
RDebugUtils.currentLine=458858;
 //BA.debugLineNum = 458858;BA.debugLine="asbm_page_1.AddView(asbm_icon_1,5dip,asbm_page_1";
__ref._asbm_page_1.AddView((javafx.scene.Node)(__ref._asbm_icon_1.getObject()),__c.DipToCurrent((int) (5)),__ref._asbm_page_1.getHeight()/(double)2-__ref._asbm_icon_1.getHeight()/(double)2,__ref._asbm_icon_1.getHeight(),__ref._asbm_icon_1.getHeight());
RDebugUtils.currentLine=458860;
 //BA.debugLineNum = 458860;BA.debugLine="asbm_icon_1.Left = cx - asbm_icon_1.Width/2";
__ref._asbm_icon_1.setLeft(_cx-__ref._asbm_icon_1.getWidth()/(double)2);
RDebugUtils.currentLine=458861;
 //BA.debugLineNum = 458861;BA.debugLine="asbm_icon_1.Top = cy - asbm_icon_1.Height/2";
__ref._asbm_icon_1.setTop(_cy-__ref._asbm_icon_1.getHeight()/(double)2);
RDebugUtils.currentLine=458864;
 //BA.debugLineNum = 458864;BA.debugLine="asbm_page_2.AddView(asbm_icon_2,5dip,asbm_page_2";
__ref._asbm_page_2.AddView((javafx.scene.Node)(__ref._asbm_icon_2.getObject()),__c.DipToCurrent((int) (5)),__ref._asbm_page_2.getHeight()/(double)2-__ref._asbm_icon_2.getHeight()/(double)2,__ref._asbm_icon_2.getHeight(),__ref._asbm_icon_2.getHeight());
RDebugUtils.currentLine=458866;
 //BA.debugLineNum = 458866;BA.debugLine="asbm_icon_2.Left = cx - asbm_icon_2.Width/2";
__ref._asbm_icon_2.setLeft(_cx-__ref._asbm_icon_2.getWidth()/(double)2);
RDebugUtils.currentLine=458867;
 //BA.debugLineNum = 458867;BA.debugLine="asbm_icon_2.Top = cy - asbm_icon_2.Height/2";
__ref._asbm_icon_2.setTop(_cy-__ref._asbm_icon_2.getHeight()/(double)2);
RDebugUtils.currentLine=458870;
 //BA.debugLineNum = 458870;BA.debugLine="asbm_page_3.AddView(asbm_icon_3,5dip,asbm_page_3";
__ref._asbm_page_3.AddView((javafx.scene.Node)(__ref._asbm_icon_3.getObject()),__c.DipToCurrent((int) (5)),__ref._asbm_page_3.getHeight()/(double)2-__ref._asbm_icon_3.getHeight()/(double)2,__ref._asbm_icon_3.getHeight(),__ref._asbm_icon_3.getHeight());
RDebugUtils.currentLine=458872;
 //BA.debugLineNum = 458872;BA.debugLine="asbm_icon_3.Left = cx - asbm_icon_3.Width/2";
__ref._asbm_icon_3.setLeft(_cx-__ref._asbm_icon_3.getWidth()/(double)2);
RDebugUtils.currentLine=458873;
 //BA.debugLineNum = 458873;BA.debugLine="asbm_icon_3.Top = cy - asbm_icon_3.Height/2";
__ref._asbm_icon_3.setTop(_cy-__ref._asbm_icon_3.getHeight()/(double)2);
RDebugUtils.currentLine=458876;
 //BA.debugLineNum = 458876;BA.debugLine="asbm_page_4.AddView(asbm_icon_4,5dip,asbm_page_4";
__ref._asbm_page_4.AddView((javafx.scene.Node)(__ref._asbm_icon_4.getObject()),__c.DipToCurrent((int) (5)),__ref._asbm_page_4.getHeight()/(double)2-__ref._asbm_icon_4.getHeight()/(double)2,__ref._asbm_icon_4.getHeight(),__ref._asbm_icon_4.getHeight());
RDebugUtils.currentLine=458878;
 //BA.debugLineNum = 458878;BA.debugLine="asbm_icon_4.Left = cx - asbm_icon_4.Width/2";
__ref._asbm_icon_4.setLeft(_cx-__ref._asbm_icon_4.getWidth()/(double)2);
RDebugUtils.currentLine=458879;
 //BA.debugLineNum = 458879;BA.debugLine="asbm_icon_4.Top = cy - asbm_icon_4.Height/2";
__ref._asbm_icon_4.setTop(_cy-__ref._asbm_icon_4.getHeight()/(double)2);
RDebugUtils.currentLine=458882;
 //BA.debugLineNum = 458882;BA.debugLine="asbm_page_background.AddView(asbm_slider,asbm_pa";
__ref._asbm_page_background.AddView((javafx.scene.Node)(__ref._asbm_slider.getObject()),__ref._asbm_page_1.getWidth()/(double)2-__ref._asbm_slider.getWidth()/(double)2,__ref._asbm_page_background.getHeight()-__c.DipToCurrent((int) (12)),__ref._asbm_slider.getWidth(),__ref._asbm_slider.getHeight());
RDebugUtils.currentLine=458884;
 //BA.debugLineNum = 458884;BA.debugLine="asbm_page_1.AddView(asbm_badget_1,asbm_icon_1.Le";
__ref._asbm_page_1.AddView((javafx.scene.Node)(__ref._asbm_badget_1.getObject()),__ref._asbm_icon_1.getLeft()+__ref._asbm_icon_1.getWidth()+__c.DipToCurrent((int) (1)),__ref._asbm_icon_1.getTop()-__ref._asbm_badget_1.getHeight()/(double)2,__ref._asbm_badget_1.getWidth(),__ref._asbm_badget_1.getHeight());
RDebugUtils.currentLine=458886;
 //BA.debugLineNum = 458886;BA.debugLine="asbm_page_2.AddView(asbm_badget_2,asbm_icon_1.Le";
__ref._asbm_page_2.AddView((javafx.scene.Node)(__ref._asbm_badget_2.getObject()),__ref._asbm_icon_1.getLeft()+__ref._asbm_icon_1.getWidth()+__c.DipToCurrent((int) (1)),__ref._asbm_icon_2.getTop()-__ref._asbm_badget_2.getHeight()/(double)2,__ref._asbm_badget_2.getWidth(),__ref._asbm_badget_2.getHeight());
RDebugUtils.currentLine=458888;
 //BA.debugLineNum = 458888;BA.debugLine="asbm_page_3.AddView(asbm_badget_3,asbm_icon_1.Le";
__ref._asbm_page_3.AddView((javafx.scene.Node)(__ref._asbm_badget_3.getObject()),__ref._asbm_icon_1.getLeft()+__ref._asbm_icon_1.getWidth()+__c.DipToCurrent((int) (1)),__ref._asbm_icon_3.getTop()-__ref._asbm_badget_3.getHeight()/(double)2,__ref._asbm_badget_3.getWidth(),__ref._asbm_badget_3.getHeight());
RDebugUtils.currentLine=458890;
 //BA.debugLineNum = 458890;BA.debugLine="asbm_page_4.AddView(asbm_badget_4,asbm_icon_1.Le";
__ref._asbm_page_4.AddView((javafx.scene.Node)(__ref._asbm_badget_4.getObject()),__ref._asbm_icon_1.getLeft()+__ref._asbm_icon_1.getWidth()+__c.DipToCurrent((int) (1)),__ref._asbm_icon_4.getTop()-__ref._asbm_badget_4.getHeight()/(double)2,__ref._asbm_badget_4.getWidth(),__ref._asbm_badget_4.getHeight());
RDebugUtils.currentLine=458894;
 //BA.debugLineNum = 458894;BA.debugLine="asbm_badget_1.Visible = e_BadgetColor1";
__ref._asbm_badget_1.setVisible(__ref._e_badgetcolor1);
RDebugUtils.currentLine=458895;
 //BA.debugLineNum = 458895;BA.debugLine="asbm_badget_2.Visible = e_BadgetColor2";
__ref._asbm_badget_2.setVisible(__ref._e_badgetcolor2);
RDebugUtils.currentLine=458896;
 //BA.debugLineNum = 458896;BA.debugLine="asbm_badget_3.Visible = e_BadgetColor3";
__ref._asbm_badget_3.setVisible(__ref._e_badgetcolor3);
RDebugUtils.currentLine=458897;
 //BA.debugLineNum = 458897;BA.debugLine="asbm_badget_4.Visible = e_BadgetColor4";
__ref._asbm_badget_4.setVisible(__ref._e_badgetcolor4);
RDebugUtils.currentLine=458900;
 //BA.debugLineNum = 458900;BA.debugLine="If MiddleButtonVisible = True Then";
if (__ref._middlebuttonvisible==__c.True) { 
RDebugUtils.currentLine=458901;
 //BA.debugLineNum = 458901;BA.debugLine="asbm_add_background.Visible = True";
__ref._asbm_add_background.setVisible(__c.True);
RDebugUtils.currentLine=458902;
 //BA.debugLineNum = 458902;BA.debugLine="asbm_add_background.Enabled = True";
__ref._asbm_add_background.setEnabled(__c.True);
 }else {
RDebugUtils.currentLine=458905;
 //BA.debugLineNum = 458905;BA.debugLine="asbm_add_background.Visible = False";
__ref._asbm_add_background.setVisible(__c.False);
RDebugUtils.currentLine=458906;
 //BA.debugLineNum = 458906;BA.debugLine="asbm_add_background.Enabled = False";
__ref._asbm_add_background.setEnabled(__c.False);
 };
 }else 
{RDebugUtils.currentLine=458909;
 //BA.debugLineNum = 458909;BA.debugLine="else If TypeOfMenu = \"2 Icon Tabs\" Then";
if ((__ref._typeofmenu).equals("2 Icon Tabs")) { 
RDebugUtils.currentLine=458911;
 //BA.debugLineNum = 458911;BA.debugLine="Mode = 2";
__ref._mode = (int) (2);
RDebugUtils.currentLine=458913;
 //BA.debugLineNum = 458913;BA.debugLine="IconTabs2(Props)";
__ref._icontabs2(null,_props);
RDebugUtils.currentLine=458916;
 //BA.debugLineNum = 458916;BA.debugLine="asbm_page_background.Color = b_Color";
__ref._asbm_page_background.setColor(__ref._b_color);
RDebugUtils.currentLine=458918;
 //BA.debugLineNum = 458918;BA.debugLine="mBase.AddView(asbm_page_background,0,mBase.Heigh";
__ref._mbase.AddView((javafx.scene.Node)(__ref._asbm_page_background.getObject()),0,__ref._mbase.getHeight()/(double)2.5,__ref._mbase.getWidth(),__ref._mbase.getHeight());
RDebugUtils.currentLine=458920;
 //BA.debugLineNum = 458920;BA.debugLine="asbm_page_background.Top = mBase.Height/2.5 'mBa";
__ref._asbm_page_background.setTop(__ref._mbase.getHeight()/(double)2.5);
RDebugUtils.currentLine=458921;
 //BA.debugLineNum = 458921;BA.debugLine="asbm_page_background.Height = mBase.Height - asb";
__ref._asbm_page_background.setHeight(__ref._mbase.getHeight()-__ref._asbm_page_background.getTop());
RDebugUtils.currentLine=458923;
 //BA.debugLineNum = 458923;BA.debugLine="mBase.AddView(asbm_parting_line,0,mBase.Height/2";
__ref._mbase.AddView((javafx.scene.Node)(__ref._asbm_parting_line.getObject()),0,__ref._mbase.getHeight()/(double)2.5,__ref._mbase.getWidth(),__ref._asbm_parting_line.getHeight());
RDebugUtils.currentLine=458925;
 //BA.debugLineNum = 458925;BA.debugLine="mBase.AddView(asbm_add_background,mBase.Width /";
__ref._mbase.AddView((javafx.scene.Node)(__ref._asbm_add_background.getObject()),__ref._mbase.getWidth()/(double)2-__ref._asbm_add_background.getWidth()/(double)2,0,__ref._mbase.getHeight()/(double)1.2,__ref._mbase.getHeight()/(double)1.2);
RDebugUtils.currentLine=458928;
 //BA.debugLineNum = 458928;BA.debugLine="asbm_add_background.SetColorAndBorder(m_Backgrou";
__ref._asbm_add_background.SetColorAndBorder(__ref._m_backgroundcolor,__c.DipToCurrent((int) (3)),__ref._xui.Color_White,__ref._asbm_add_background.getHeight()/(double)2);
RDebugUtils.currentLine=458932;
 //BA.debugLineNum = 458932;BA.debugLine="asbm_add_background.AddView(asbm_add_icon,10dip,";
__ref._asbm_add_background.AddView((javafx.scene.Node)(__ref._asbm_add_icon.getObject()),__c.DipToCurrent((int) (10)),__c.DipToCurrent((int) (10)),__ref._asbm_add_background.getWidth()/(double)2.5,__ref._asbm_add_background.getHeight()/(double)2.5);
RDebugUtils.currentLine=458934;
 //BA.debugLineNum = 458934;BA.debugLine="asbm_add_icon.Left = asbm_add_background.Width /";
__ref._asbm_add_icon.setLeft(__ref._asbm_add_background.getWidth()/(double)2-__ref._asbm_add_icon.getWidth()/(double)2);
RDebugUtils.currentLine=458935;
 //BA.debugLineNum = 458935;BA.debugLine="asbm_add_icon.Top = asbm_add_background.Height /";
__ref._asbm_add_icon.setTop(__ref._asbm_add_background.getHeight()/(double)2-__ref._asbm_add_icon.getHeight()/(double)2);
RDebugUtils.currentLine=458937;
 //BA.debugLineNum = 458937;BA.debugLine="If MiddleButtonVisible = True Then";
if (__ref._middlebuttonvisible==__c.True) { 
RDebugUtils.currentLine=458938;
 //BA.debugLineNum = 458938;BA.debugLine="asbm_page_background.AddView(asbm_page_1,0,3dip,";
__ref._asbm_page_background.AddView((javafx.scene.Node)(__ref._asbm_page_1.getObject()),0,__c.DipToCurrent((int) (3)),__ref._asbm_add_background.getLeft(),__ref._asbm_page_background.getHeight());
 }else {
RDebugUtils.currentLine=458941;
 //BA.debugLineNum = 458941;BA.debugLine="asbm_page_background.AddView(asbm_page_1,0,3dip";
__ref._asbm_page_background.AddView((javafx.scene.Node)(__ref._asbm_page_1.getObject()),0,__c.DipToCurrent((int) (3)),__ref._asbm_page_background.getWidth()/(double)2,__ref._asbm_page_background.getHeight());
 };
RDebugUtils.currentLine=458945;
 //BA.debugLineNum = 458945;BA.debugLine="If MiddleButtonVisible = True Then";
if (__ref._middlebuttonvisible==__c.True) { 
RDebugUtils.currentLine=458946;
 //BA.debugLineNum = 458946;BA.debugLine="asbm_page_background.AddView(asbm_page_2,asbm_ad";
__ref._asbm_page_background.AddView((javafx.scene.Node)(__ref._asbm_page_2.getObject()),__ref._asbm_add_background.getLeft()+__ref._asbm_add_background.getWidth(),__c.DipToCurrent((int) (3)),__ref._asbm_add_background.getLeft(),__ref._asbm_page_background.getHeight());
 }else {
RDebugUtils.currentLine=458949;
 //BA.debugLineNum = 458949;BA.debugLine="asbm_page_background.AddView(asbm_page_2,asbm_p";
__ref._asbm_page_background.AddView((javafx.scene.Node)(__ref._asbm_page_2.getObject()),__ref._asbm_page_1.getLeft()+__ref._asbm_page_1.getWidth(),__c.DipToCurrent((int) (3)),__ref._asbm_add_background.getWidth()/(double)2,__ref._asbm_page_background.getHeight());
 };
RDebugUtils.currentLine=458965;
 //BA.debugLineNum = 458965;BA.debugLine="asbm_icon_1.Height = asbm_page_background.Height";
__ref._asbm_icon_1.setHeight(__ref._asbm_page_background.getHeight()/(double)2.2);
RDebugUtils.currentLine=458966;
 //BA.debugLineNum = 458966;BA.debugLine="asbm_icon_1.Width = asbm_icon_1.Height";
__ref._asbm_icon_1.setWidth(__ref._asbm_icon_1.getHeight());
RDebugUtils.currentLine=458968;
 //BA.debugLineNum = 458968;BA.debugLine="asbm_icon_2.Height = asbm_page_background.Height";
__ref._asbm_icon_2.setHeight(__ref._asbm_page_background.getHeight()/(double)2.2);
RDebugUtils.currentLine=458969;
 //BA.debugLineNum = 458969;BA.debugLine="asbm_icon_2.Width = asbm_icon_2.Height";
__ref._asbm_icon_2.setWidth(__ref._asbm_icon_2.getHeight());
RDebugUtils.currentLine=458978;
 //BA.debugLineNum = 458978;BA.debugLine="Dim cx,cy As Int";
_cx = 0;
_cy = 0;
RDebugUtils.currentLine=458979;
 //BA.debugLineNum = 458979;BA.debugLine="cx = asbm_page_1.Left + asbm_page_1.Width/2";
_cx = (int) (__ref._asbm_page_1.getLeft()+__ref._asbm_page_1.getWidth()/(double)2);
RDebugUtils.currentLine=458980;
 //BA.debugLineNum = 458980;BA.debugLine="cy = asbm_page_1.Top + asbm_page_1.Height/2.3";
_cy = (int) (__ref._asbm_page_1.getTop()+__ref._asbm_page_1.getHeight()/(double)2.3);
RDebugUtils.currentLine=458982;
 //BA.debugLineNum = 458982;BA.debugLine="asbm_page_1.AddView(asbm_icon_1,5dip,asbm_page_1";
__ref._asbm_page_1.AddView((javafx.scene.Node)(__ref._asbm_icon_1.getObject()),__c.DipToCurrent((int) (5)),__ref._asbm_page_1.getHeight()/(double)2-__ref._asbm_icon_1.getHeight()/(double)2,__ref._asbm_icon_1.getHeight(),__ref._asbm_icon_1.getHeight());
RDebugUtils.currentLine=458984;
 //BA.debugLineNum = 458984;BA.debugLine="asbm_icon_1.Left = cx - asbm_icon_1.Width/2";
__ref._asbm_icon_1.setLeft(_cx-__ref._asbm_icon_1.getWidth()/(double)2);
RDebugUtils.currentLine=458985;
 //BA.debugLineNum = 458985;BA.debugLine="asbm_icon_1.Top = cy - asbm_icon_1.Height/2";
__ref._asbm_icon_1.setTop(_cy-__ref._asbm_icon_1.getHeight()/(double)2);
RDebugUtils.currentLine=458988;
 //BA.debugLineNum = 458988;BA.debugLine="asbm_page_2.AddView(asbm_icon_2,5dip,asbm_page_2";
__ref._asbm_page_2.AddView((javafx.scene.Node)(__ref._asbm_icon_2.getObject()),__c.DipToCurrent((int) (5)),__ref._asbm_page_2.getHeight()/(double)2-__ref._asbm_icon_2.getHeight()/(double)2,__ref._asbm_icon_2.getHeight(),__ref._asbm_icon_2.getHeight());
RDebugUtils.currentLine=458990;
 //BA.debugLineNum = 458990;BA.debugLine="asbm_icon_2.Left = cx - asbm_icon_2.Width/2";
__ref._asbm_icon_2.setLeft(_cx-__ref._asbm_icon_2.getWidth()/(double)2);
RDebugUtils.currentLine=458991;
 //BA.debugLineNum = 458991;BA.debugLine="asbm_icon_2.Top = cy - asbm_icon_2.Height/2";
__ref._asbm_icon_2.setTop(_cy-__ref._asbm_icon_2.getHeight()/(double)2);
RDebugUtils.currentLine=459006;
 //BA.debugLineNum = 459006;BA.debugLine="asbm_page_background.AddView(asbm_slider,asbm_pa";
__ref._asbm_page_background.AddView((javafx.scene.Node)(__ref._asbm_slider.getObject()),__ref._asbm_page_1.getWidth()/(double)2-__ref._asbm_slider.getWidth()/(double)2,__ref._asbm_page_background.getHeight()-__c.DipToCurrent((int) (12)),__ref._asbm_slider.getWidth(),__ref._asbm_slider.getHeight());
RDebugUtils.currentLine=459008;
 //BA.debugLineNum = 459008;BA.debugLine="asbm_page_1.AddView(asbm_badget_1,asbm_icon_1.Le";
__ref._asbm_page_1.AddView((javafx.scene.Node)(__ref._asbm_badget_1.getObject()),__ref._asbm_icon_1.getLeft()+__ref._asbm_icon_1.getWidth()+__c.DipToCurrent((int) (1)),__ref._asbm_icon_1.getTop()-__ref._asbm_badget_1.getHeight()/(double)2,__ref._asbm_badget_1.getWidth(),__ref._asbm_badget_1.getHeight());
RDebugUtils.currentLine=459010;
 //BA.debugLineNum = 459010;BA.debugLine="asbm_page_2.AddView(asbm_badget_2,asbm_icon_1.Le";
__ref._asbm_page_2.AddView((javafx.scene.Node)(__ref._asbm_badget_2.getObject()),__ref._asbm_icon_1.getLeft()+__ref._asbm_icon_1.getWidth()+__c.DipToCurrent((int) (1)),__ref._asbm_icon_2.getTop()-__ref._asbm_badget_2.getHeight()/(double)2,__ref._asbm_badget_2.getWidth(),__ref._asbm_badget_2.getHeight());
RDebugUtils.currentLine=459018;
 //BA.debugLineNum = 459018;BA.debugLine="asbm_badget_1.Visible = e_BadgetColor1";
__ref._asbm_badget_1.setVisible(__ref._e_badgetcolor1);
RDebugUtils.currentLine=459019;
 //BA.debugLineNum = 459019;BA.debugLine="asbm_badget_2.Visible = e_BadgetColor2";
__ref._asbm_badget_2.setVisible(__ref._e_badgetcolor2);
RDebugUtils.currentLine=459024;
 //BA.debugLineNum = 459024;BA.debugLine="If MiddleButtonVisible = True Then";
if (__ref._middlebuttonvisible==__c.True) { 
RDebugUtils.currentLine=459025;
 //BA.debugLineNum = 459025;BA.debugLine="asbm_add_background.Visible = True";
__ref._asbm_add_background.setVisible(__c.True);
RDebugUtils.currentLine=459026;
 //BA.debugLineNum = 459026;BA.debugLine="asbm_add_background.Enabled = True";
__ref._asbm_add_background.setEnabled(__c.True);
 }else {
RDebugUtils.currentLine=459029;
 //BA.debugLineNum = 459029;BA.debugLine="asbm_add_background.Visible = False";
__ref._asbm_add_background.setVisible(__c.False);
RDebugUtils.currentLine=459030;
 //BA.debugLineNum = 459030;BA.debugLine="asbm_add_background.Enabled = False";
__ref._asbm_add_background.setEnabled(__c.False);
 };
 }}
;
RDebugUtils.currentLine=459040;
 //BA.debugLineNum = 459040;BA.debugLine="End Sub";
return "";
}
public String  _icontabs4(b4j.example.asbottommenu __ref,anywheresoftware.b4a.objects.collections.Map _props) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "icontabs4"))
	 {return ((String) Debug.delegate(ba, "icontabs4", new Object[] {_props}));}
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pnl_asbm_page_background = null;
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pnl_asbm_parting_line = null;
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pnl_asbm_add_background = null;
anywheresoftware.b4j.objects.ImageViewWrapper _pnl_asbm_add_icon = null;
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pnl_asbm_page_1 = null;
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pnl_asbm_page_2 = null;
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pnl_asbm_page_3 = null;
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pnl_asbm_page_4 = null;
anywheresoftware.b4j.objects.ImageViewWrapper _pnl_asbm_icon_4 = null;
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pnl_asbm_slider = null;
anywheresoftware.b4j.objects.LabelWrapper _pnl_asbm_badget_1 = null;
anywheresoftware.b4j.objects.LabelWrapper _pnl_asbm_badget_2 = null;
anywheresoftware.b4j.objects.LabelWrapper _pnl_asbm_badget_3 = null;
anywheresoftware.b4j.objects.LabelWrapper _pnl_asbm_badget_4 = null;
RDebugUtils.currentLine=262144;
 //BA.debugLineNum = 262144;BA.debugLine="Private Sub IconTabs4(Props As Map)";
RDebugUtils.currentLine=262153;
 //BA.debugLineNum = 262153;BA.debugLine="Dim pnl_asbm_page_background As Pane";
_pnl_asbm_page_background = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=262154;
 //BA.debugLineNum = 262154;BA.debugLine="Dim pnl_asbm_parting_line As Pane";
_pnl_asbm_parting_line = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=262155;
 //BA.debugLineNum = 262155;BA.debugLine="Dim pnl_asbm_add_background As Pane";
_pnl_asbm_add_background = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=262161;
 //BA.debugLineNum = 262161;BA.debugLine="pnl_asbm_page_background.Initialize(\"asbm_page_ba";
_pnl_asbm_page_background.Initialize(ba,"asbm_page_background");
RDebugUtils.currentLine=262162;
 //BA.debugLineNum = 262162;BA.debugLine="asbm_page_background = pnl_asbm_page_background";
__ref._asbm_page_background.setObject((java.lang.Object)(_pnl_asbm_page_background.getObject()));
RDebugUtils.currentLine=262166;
 //BA.debugLineNum = 262166;BA.debugLine="pnl_asbm_parting_line.Initialize(\"asbm_parting_li";
_pnl_asbm_parting_line.Initialize(ba,"asbm_parting_line");
RDebugUtils.currentLine=262167;
 //BA.debugLineNum = 262167;BA.debugLine="asbm_parting_line = pnl_asbm_parting_line";
__ref._asbm_parting_line.setObject((java.lang.Object)(_pnl_asbm_parting_line.getObject()));
RDebugUtils.currentLine=262170;
 //BA.debugLineNum = 262170;BA.debugLine="pnl_asbm_add_background.Initialize(\"asbm_add_back";
_pnl_asbm_add_background.Initialize(ba,"asbm_add_background");
RDebugUtils.currentLine=262171;
 //BA.debugLineNum = 262171;BA.debugLine="asbm_add_background = pnl_asbm_add_background";
__ref._asbm_add_background.setObject((java.lang.Object)(_pnl_asbm_add_background.getObject()));
RDebugUtils.currentLine=262174;
 //BA.debugLineNum = 262174;BA.debugLine="asbm_add_background.Height = mBase.Height/1.2";
__ref._asbm_add_background.setHeight(__ref._mbase.getHeight()/(double)1.2);
RDebugUtils.currentLine=262175;
 //BA.debugLineNum = 262175;BA.debugLine="asbm_add_background.Width = mBase.Height/1.2";
__ref._asbm_add_background.setWidth(__ref._mbase.getHeight()/(double)1.2);
RDebugUtils.currentLine=262177;
 //BA.debugLineNum = 262177;BA.debugLine="Dim pnl_asbm_add_icon As ImageView";
_pnl_asbm_add_icon = new anywheresoftware.b4j.objects.ImageViewWrapper();
RDebugUtils.currentLine=262178;
 //BA.debugLineNum = 262178;BA.debugLine="pnl_asbm_add_icon.Initialize(\"asbm_icon_4\")";
_pnl_asbm_add_icon.Initialize(ba,"asbm_icon_4");
RDebugUtils.currentLine=262196;
 //BA.debugLineNum = 262196;BA.debugLine="pnl_asbm_add_icon.SetImage(xui.LoadBitmap(File.Di";
_pnl_asbm_add_icon.SetImage((javafx.scene.image.Image)(__ref._xui.LoadBitmap(__c.File.getDirAssets(),"add.png").getObject()));
RDebugUtils.currentLine=262203;
 //BA.debugLineNum = 262203;BA.debugLine="asbm_add_icon = pnl_asbm_add_icon";
__ref._asbm_add_icon.setObject((java.lang.Object)(_pnl_asbm_add_icon.getObject()));
RDebugUtils.currentLine=262215;
 //BA.debugLineNum = 262215;BA.debugLine="Dim pnl_asbm_page_1 As Pane";
_pnl_asbm_page_1 = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=262216;
 //BA.debugLineNum = 262216;BA.debugLine="Dim pnl_asbm_page_2 As Pane";
_pnl_asbm_page_2 = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=262217;
 //BA.debugLineNum = 262217;BA.debugLine="Dim pnl_asbm_page_3 As Pane";
_pnl_asbm_page_3 = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=262218;
 //BA.debugLineNum = 262218;BA.debugLine="Dim pnl_asbm_page_4 As Pane";
_pnl_asbm_page_4 = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=262224;
 //BA.debugLineNum = 262224;BA.debugLine="pnl_asbm_page_1.Initialize(\"asbm_page_1\")";
_pnl_asbm_page_1.Initialize(ba,"asbm_page_1");
RDebugUtils.currentLine=262225;
 //BA.debugLineNum = 262225;BA.debugLine="asbm_page_1 = pnl_asbm_page_1";
__ref._asbm_page_1.setObject((java.lang.Object)(_pnl_asbm_page_1.getObject()));
RDebugUtils.currentLine=262229;
 //BA.debugLineNum = 262229;BA.debugLine="pnl_asbm_page_2.Initialize(\"asbm_page_2\")";
_pnl_asbm_page_2.Initialize(ba,"asbm_page_2");
RDebugUtils.currentLine=262230;
 //BA.debugLineNum = 262230;BA.debugLine="asbm_page_2 = pnl_asbm_page_2";
__ref._asbm_page_2.setObject((java.lang.Object)(_pnl_asbm_page_2.getObject()));
RDebugUtils.currentLine=262234;
 //BA.debugLineNum = 262234;BA.debugLine="pnl_asbm_page_3.Initialize(\"asbm_page_3\")";
_pnl_asbm_page_3.Initialize(ba,"asbm_page_3");
RDebugUtils.currentLine=262235;
 //BA.debugLineNum = 262235;BA.debugLine="asbm_page_3 = pnl_asbm_page_3";
__ref._asbm_page_3.setObject((java.lang.Object)(_pnl_asbm_page_3.getObject()));
RDebugUtils.currentLine=262239;
 //BA.debugLineNum = 262239;BA.debugLine="pnl_asbm_page_4.Initialize(\"asbm_page_4\")";
_pnl_asbm_page_4.Initialize(ba,"asbm_page_4");
RDebugUtils.currentLine=262240;
 //BA.debugLineNum = 262240;BA.debugLine="asbm_page_4 = pnl_asbm_page_4";
__ref._asbm_page_4.setObject((java.lang.Object)(_pnl_asbm_page_4.getObject()));
RDebugUtils.currentLine=262244;
 //BA.debugLineNum = 262244;BA.debugLine="asbm_icon_1.Initialize(\"asbm_icon_1\")";
__ref._asbm_icon_1.Initialize(ba,"asbm_icon_1");
RDebugUtils.currentLine=262262;
 //BA.debugLineNum = 262262;BA.debugLine="asbm_icon_2.Initialize(\"asbm_icon_2\")";
__ref._asbm_icon_2.Initialize(ba,"asbm_icon_2");
RDebugUtils.currentLine=262276;
 //BA.debugLineNum = 262276;BA.debugLine="asbm_icon_3.Initialize(\"asbm_icon_3\")";
__ref._asbm_icon_3.Initialize(ba,"asbm_icon_3");
RDebugUtils.currentLine=262290;
 //BA.debugLineNum = 262290;BA.debugLine="Dim pnl_asbm_icon_4 As ImageView";
_pnl_asbm_icon_4 = new anywheresoftware.b4j.objects.ImageViewWrapper();
RDebugUtils.currentLine=262291;
 //BA.debugLineNum = 262291;BA.debugLine="pnl_asbm_icon_4.Initialize(\"asbm_icon_4\")";
_pnl_asbm_icon_4.Initialize(ba,"asbm_icon_4");
RDebugUtils.currentLine=262304;
 //BA.debugLineNum = 262304;BA.debugLine="asbm_icon_4 = pnl_asbm_icon_4";
__ref._asbm_icon_4 = _pnl_asbm_icon_4;
RDebugUtils.currentLine=262314;
 //BA.debugLineNum = 262314;BA.debugLine="Dim pnl_asbm_slider As Pane";
_pnl_asbm_slider = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=262318;
 //BA.debugLineNum = 262318;BA.debugLine="pnl_asbm_slider.Initialize(\"asbm_slider\")";
_pnl_asbm_slider.Initialize(ba,"asbm_slider");
RDebugUtils.currentLine=262319;
 //BA.debugLineNum = 262319;BA.debugLine="asbm_slider = pnl_asbm_slider";
__ref._asbm_slider.setObject((java.lang.Object)(_pnl_asbm_slider.getObject()));
RDebugUtils.currentLine=262324;
 //BA.debugLineNum = 262324;BA.debugLine="Dim pnl_asbm_badget_1 As Label";
_pnl_asbm_badget_1 = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=262325;
 //BA.debugLineNum = 262325;BA.debugLine="pnl_asbm_badget_1.Initialize(\"asbm_badget_1\")";
_pnl_asbm_badget_1.Initialize(ba,"asbm_badget_1");
RDebugUtils.currentLine=262326;
 //BA.debugLineNum = 262326;BA.debugLine="asbm_badget_1 = pnl_asbm_badget_1";
__ref._asbm_badget_1.setObject((java.lang.Object)(_pnl_asbm_badget_1.getObject()));
RDebugUtils.currentLine=262327;
 //BA.debugLineNum = 262327;BA.debugLine="asbm_badget_1.Font = xui.CreateDefaultBoldFont(10";
__ref._asbm_badget_1.setFont(__ref._xui.CreateDefaultBoldFont((float) (10)));
RDebugUtils.currentLine=262328;
 //BA.debugLineNum = 262328;BA.debugLine="asbm_badget_1.TextColor = xui.Color_White";
__ref._asbm_badget_1.setTextColor(__ref._xui.Color_White);
RDebugUtils.currentLine=262329;
 //BA.debugLineNum = 262329;BA.debugLine="asbm_badget_1.SetTextAlignment(\"CENTER\",\"CENTER\")";
__ref._asbm_badget_1.SetTextAlignment("CENTER","CENTER");
RDebugUtils.currentLine=262333;
 //BA.debugLineNum = 262333;BA.debugLine="Dim pnl_asbm_badget_2 As Label";
_pnl_asbm_badget_2 = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=262334;
 //BA.debugLineNum = 262334;BA.debugLine="pnl_asbm_badget_2.Initialize(\"asbm_badget_2\")";
_pnl_asbm_badget_2.Initialize(ba,"asbm_badget_2");
RDebugUtils.currentLine=262335;
 //BA.debugLineNum = 262335;BA.debugLine="asbm_badget_2 = pnl_asbm_badget_2";
__ref._asbm_badget_2.setObject((java.lang.Object)(_pnl_asbm_badget_2.getObject()));
RDebugUtils.currentLine=262336;
 //BA.debugLineNum = 262336;BA.debugLine="asbm_badget_2.Font = xui.CreateDefaultBoldFont(10";
__ref._asbm_badget_2.setFont(__ref._xui.CreateDefaultBoldFont((float) (10)));
RDebugUtils.currentLine=262337;
 //BA.debugLineNum = 262337;BA.debugLine="asbm_badget_2.TextColor = xui.Color_White";
__ref._asbm_badget_2.setTextColor(__ref._xui.Color_White);
RDebugUtils.currentLine=262338;
 //BA.debugLineNum = 262338;BA.debugLine="asbm_badget_2.SetTextAlignment(\"CENTER\",\"CENTER\")";
__ref._asbm_badget_2.SetTextAlignment("CENTER","CENTER");
RDebugUtils.currentLine=262340;
 //BA.debugLineNum = 262340;BA.debugLine="Dim pnl_asbm_badget_3 As Label";
_pnl_asbm_badget_3 = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=262341;
 //BA.debugLineNum = 262341;BA.debugLine="pnl_asbm_badget_3.Initialize(\"asbm_badget_3\")";
_pnl_asbm_badget_3.Initialize(ba,"asbm_badget_3");
RDebugUtils.currentLine=262342;
 //BA.debugLineNum = 262342;BA.debugLine="asbm_badget_3 = pnl_asbm_badget_3";
__ref._asbm_badget_3.setObject((java.lang.Object)(_pnl_asbm_badget_3.getObject()));
RDebugUtils.currentLine=262343;
 //BA.debugLineNum = 262343;BA.debugLine="asbm_badget_3.Font = xui.CreateDefaultBoldFont(10";
__ref._asbm_badget_3.setFont(__ref._xui.CreateDefaultBoldFont((float) (10)));
RDebugUtils.currentLine=262344;
 //BA.debugLineNum = 262344;BA.debugLine="asbm_badget_3.TextColor = xui.Color_White";
__ref._asbm_badget_3.setTextColor(__ref._xui.Color_White);
RDebugUtils.currentLine=262345;
 //BA.debugLineNum = 262345;BA.debugLine="asbm_badget_3.SetTextAlignment(\"CENTER\",\"CENTER\")";
__ref._asbm_badget_3.SetTextAlignment("CENTER","CENTER");
RDebugUtils.currentLine=262347;
 //BA.debugLineNum = 262347;BA.debugLine="Dim pnl_asbm_badget_4 As Label";
_pnl_asbm_badget_4 = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=262348;
 //BA.debugLineNum = 262348;BA.debugLine="pnl_asbm_badget_4.Initialize(\"asbm_badget_4\")";
_pnl_asbm_badget_4.Initialize(ba,"asbm_badget_4");
RDebugUtils.currentLine=262349;
 //BA.debugLineNum = 262349;BA.debugLine="asbm_badget_4 = pnl_asbm_badget_4";
__ref._asbm_badget_4.setObject((java.lang.Object)(_pnl_asbm_badget_4.getObject()));
RDebugUtils.currentLine=262350;
 //BA.debugLineNum = 262350;BA.debugLine="asbm_badget_4.Font = xui.CreateDefaultBoldFont(10";
__ref._asbm_badget_4.setFont(__ref._xui.CreateDefaultBoldFont((float) (10)));
RDebugUtils.currentLine=262351;
 //BA.debugLineNum = 262351;BA.debugLine="asbm_badget_4.TextColor = xui.Color_White";
__ref._asbm_badget_4.setTextColor(__ref._xui.Color_White);
RDebugUtils.currentLine=262352;
 //BA.debugLineNum = 262352;BA.debugLine="asbm_badget_4.SetTextAlignment(\"CENTER\",\"CENTER\")";
__ref._asbm_badget_4.SetTextAlignment("CENTER","CENTER");
RDebugUtils.currentLine=262356;
 //BA.debugLineNum = 262356;BA.debugLine="s_Color1 = xui.PaintOrColorToColor(Props.Get(\"Sli";
__ref._s_color1 = __ref._xui.PaintOrColorToColor(_props.Get((Object)("SliderColor1")));
RDebugUtils.currentLine=262357;
 //BA.debugLineNum = 262357;BA.debugLine="s_Color2 = xui.PaintOrColorToColor(Props.Get(\"Sli";
__ref._s_color2 = __ref._xui.PaintOrColorToColor(_props.Get((Object)("SliderColor2")));
RDebugUtils.currentLine=262358;
 //BA.debugLineNum = 262358;BA.debugLine="s_Color3 = xui.PaintOrColorToColor(Props.Get(\"Sli";
__ref._s_color3 = __ref._xui.PaintOrColorToColor(_props.Get((Object)("SliderColor3")));
RDebugUtils.currentLine=262359;
 //BA.debugLineNum = 262359;BA.debugLine="s_Color4 = xui.PaintOrColorToColor(Props.Get(\"Sli";
__ref._s_color4 = __ref._xui.PaintOrColorToColor(_props.Get((Object)("SliderColor4")));
RDebugUtils.currentLine=262361;
 //BA.debugLineNum = 262361;BA.debugLine="b_Color = xui.PaintOrColorToColor(Props.Get(\"Back";
__ref._b_color = __ref._xui.PaintOrColorToColor(_props.Get((Object)("BackgroundColor")));
RDebugUtils.currentLine=262363;
 //BA.debugLineNum = 262363;BA.debugLine="p_Line = xui.PaintOrColorToColor(Props.Get(\"Parti";
__ref._p_line = __ref._xui.PaintOrColorToColor(_props.Get((Object)("PartingLine")));
RDebugUtils.currentLine=262365;
 //BA.debugLineNum = 262365;BA.debugLine="m_BackgroundColor = xui.PaintOrColorToColor(Props";
__ref._m_backgroundcolor = __ref._xui.PaintOrColorToColor(_props.Get((Object)("MiddleBackgroundColor")));
RDebugUtils.currentLine=262367;
 //BA.debugLineNum = 262367;BA.debugLine="e_BadgetColor1 = Props.Get(\"EnableBadgetColor1\")";
__ref._e_badgetcolor1 = BA.ObjectToBoolean(_props.Get((Object)("EnableBadgetColor1")));
RDebugUtils.currentLine=262368;
 //BA.debugLineNum = 262368;BA.debugLine="e_BadgetColor2 = Props.Get(\"EnableBadgetColor2\")";
__ref._e_badgetcolor2 = BA.ObjectToBoolean(_props.Get((Object)("EnableBadgetColor2")));
RDebugUtils.currentLine=262369;
 //BA.debugLineNum = 262369;BA.debugLine="e_BadgetColor3 = Props.Get(\"EnableBadgetColor3\")";
__ref._e_badgetcolor3 = BA.ObjectToBoolean(_props.Get((Object)("EnableBadgetColor3")));
RDebugUtils.currentLine=262370;
 //BA.debugLineNum = 262370;BA.debugLine="e_BadgetColor4 = Props.Get(\"EnableBadgetColor4\")";
__ref._e_badgetcolor4 = BA.ObjectToBoolean(_props.Get((Object)("EnableBadgetColor4")));
RDebugUtils.currentLine=262372;
 //BA.debugLineNum = 262372;BA.debugLine="b_color1 = xui.PaintOrColorToColor(Props.Get(\"Bad";
__ref._b_color1 = __ref._xui.PaintOrColorToColor(_props.Get((Object)("BadgetColor1")));
RDebugUtils.currentLine=262373;
 //BA.debugLineNum = 262373;BA.debugLine="b_color2 = xui.PaintOrColorToColor(Props.Get(\"Bad";
__ref._b_color2 = __ref._xui.PaintOrColorToColor(_props.Get((Object)("BadgetColor2")));
RDebugUtils.currentLine=262374;
 //BA.debugLineNum = 262374;BA.debugLine="b_color3 = xui.PaintOrColorToColor(Props.Get(\"Bad";
__ref._b_color3 = __ref._xui.PaintOrColorToColor(_props.Get((Object)("BadgetColor3")));
RDebugUtils.currentLine=262375;
 //BA.debugLineNum = 262375;BA.debugLine="b_color4 = xui.PaintOrColorToColor(Props.Get(\"Bad";
__ref._b_color4 = __ref._xui.PaintOrColorToColor(_props.Get((Object)("BadgetColor4")));
RDebugUtils.currentLine=262377;
 //BA.debugLineNum = 262377;BA.debugLine="p_ClickColor = xui.PaintOrColorToColor(Props.Get(";
__ref._p_clickcolor = __ref._xui.PaintOrColorToColor(_props.Get((Object)("PageClickColor")));
RDebugUtils.currentLine=262379;
 //BA.debugLineNum = 262379;BA.debugLine="e_SelectedPageColor = Props.Get(\"EnableSelectedPa";
__ref._e_selectedpagecolor = BA.ObjectToBoolean(_props.Get((Object)("EnableSelectedPageColor")));
RDebugUtils.currentLine=262381;
 //BA.debugLineNum = 262381;BA.debugLine="s_PageColor = xui.PaintOrColorToColor(Props.Get(\"";
__ref._s_pagecolor = __ref._xui.PaintOrColorToColor(_props.Get((Object)("SelectedPageColor")));
RDebugUtils.currentLine=262383;
 //BA.debugLineNum = 262383;BA.debugLine="MiddleButtonVisible = Props.Get(\"MiddleButtonVisi";
__ref._middlebuttonvisible = BA.ObjectToBoolean(_props.Get((Object)("MiddleButtonVisible")));
RDebugUtils.currentLine=262387;
 //BA.debugLineNum = 262387;BA.debugLine="asbm_page_1.Color = b_Color";
__ref._asbm_page_1.setColor(__ref._b_color);
RDebugUtils.currentLine=262388;
 //BA.debugLineNum = 262388;BA.debugLine="asbm_page_2.Color = b_Color";
__ref._asbm_page_2.setColor(__ref._b_color);
RDebugUtils.currentLine=262389;
 //BA.debugLineNum = 262389;BA.debugLine="asbm_page_3.Color = b_Color";
__ref._asbm_page_3.setColor(__ref._b_color);
RDebugUtils.currentLine=262390;
 //BA.debugLineNum = 262390;BA.debugLine="asbm_page_4.Color = b_Color";
__ref._asbm_page_4.setColor(__ref._b_color);
RDebugUtils.currentLine=262395;
 //BA.debugLineNum = 262395;BA.debugLine="asbm_slider.Height = 2dip";
__ref._asbm_slider.setHeight(__c.DipToCurrent((int) (2)));
RDebugUtils.currentLine=262396;
 //BA.debugLineNum = 262396;BA.debugLine="asbm_slider.Width = 40dip";
__ref._asbm_slider.setWidth(__c.DipToCurrent((int) (40)));
RDebugUtils.currentLine=262397;
 //BA.debugLineNum = 262397;BA.debugLine="asbm_slider.SetColorAndBorder(s_Color1,0,xui.Colo";
__ref._asbm_slider.SetColorAndBorder(__ref._s_color1,0,__ref._xui.Color_Transparent,__ref._asbm_slider.getHeight()/(double)2);
RDebugUtils.currentLine=262402;
 //BA.debugLineNum = 262402;BA.debugLine="asbm_parting_line.Height = 3dip";
__ref._asbm_parting_line.setHeight(__c.DipToCurrent((int) (3)));
RDebugUtils.currentLine=262403;
 //BA.debugLineNum = 262403;BA.debugLine="asbm_parting_line.Color = p_Line";
__ref._asbm_parting_line.setColor(__ref._p_line);
RDebugUtils.currentLine=262407;
 //BA.debugLineNum = 262407;BA.debugLine="asbm_badget_1.Width = 18dip";
__ref._asbm_badget_1.setWidth(__c.DipToCurrent((int) (18)));
RDebugUtils.currentLine=262408;
 //BA.debugLineNum = 262408;BA.debugLine="asbm_badget_1.Height = 18dip";
__ref._asbm_badget_1.setHeight(__c.DipToCurrent((int) (18)));
RDebugUtils.currentLine=262409;
 //BA.debugLineNum = 262409;BA.debugLine="asbm_badget_1.SetColorAndBorder(b_color1,0dip,xui";
__ref._asbm_badget_1.SetColorAndBorder(__ref._b_color1,__c.DipToCurrent((int) (0)),__ref._xui.Color_White,__ref._asbm_badget_1.getHeight()/(double)2);
RDebugUtils.currentLine=262410;
 //BA.debugLineNum = 262410;BA.debugLine="asbm_badget_1.Text = 0";
__ref._asbm_badget_1.setText(BA.NumberToString(0));
RDebugUtils.currentLine=262413;
 //BA.debugLineNum = 262413;BA.debugLine="asbm_badget_2.Width = 18dip";
__ref._asbm_badget_2.setWidth(__c.DipToCurrent((int) (18)));
RDebugUtils.currentLine=262414;
 //BA.debugLineNum = 262414;BA.debugLine="asbm_badget_2.Height = 18dip";
__ref._asbm_badget_2.setHeight(__c.DipToCurrent((int) (18)));
RDebugUtils.currentLine=262415;
 //BA.debugLineNum = 262415;BA.debugLine="asbm_badget_2.SetColorAndBorder(b_color2,0dip,xui";
__ref._asbm_badget_2.SetColorAndBorder(__ref._b_color2,__c.DipToCurrent((int) (0)),__ref._xui.Color_White,__ref._asbm_badget_2.getHeight()/(double)2);
RDebugUtils.currentLine=262416;
 //BA.debugLineNum = 262416;BA.debugLine="asbm_badget_2.Text = 0";
__ref._asbm_badget_2.setText(BA.NumberToString(0));
RDebugUtils.currentLine=262418;
 //BA.debugLineNum = 262418;BA.debugLine="asbm_badget_3.Width = 18dip";
__ref._asbm_badget_3.setWidth(__c.DipToCurrent((int) (18)));
RDebugUtils.currentLine=262419;
 //BA.debugLineNum = 262419;BA.debugLine="asbm_badget_3.Height = 18dip";
__ref._asbm_badget_3.setHeight(__c.DipToCurrent((int) (18)));
RDebugUtils.currentLine=262420;
 //BA.debugLineNum = 262420;BA.debugLine="asbm_badget_3.SetColorAndBorder(b_color3,0dip,xui";
__ref._asbm_badget_3.SetColorAndBorder(__ref._b_color3,__c.DipToCurrent((int) (0)),__ref._xui.Color_White,__ref._asbm_badget_3.getHeight()/(double)2);
RDebugUtils.currentLine=262421;
 //BA.debugLineNum = 262421;BA.debugLine="asbm_badget_3.Text = 0";
__ref._asbm_badget_3.setText(BA.NumberToString(0));
RDebugUtils.currentLine=262423;
 //BA.debugLineNum = 262423;BA.debugLine="asbm_badget_4.Width = 18dip";
__ref._asbm_badget_4.setWidth(__c.DipToCurrent((int) (18)));
RDebugUtils.currentLine=262424;
 //BA.debugLineNum = 262424;BA.debugLine="asbm_badget_4.Height = 18dip";
__ref._asbm_badget_4.setHeight(__c.DipToCurrent((int) (18)));
RDebugUtils.currentLine=262425;
 //BA.debugLineNum = 262425;BA.debugLine="asbm_badget_4.SetColorAndBorder(b_color4,0dip,xui";
__ref._asbm_badget_4.SetColorAndBorder(__ref._b_color4,__c.DipToCurrent((int) (0)),__ref._xui.Color_White,__ref._asbm_badget_4.getHeight()/(double)2);
RDebugUtils.currentLine=262426;
 //BA.debugLineNum = 262426;BA.debugLine="asbm_badget_4.Text = 0";
__ref._asbm_badget_4.setText(BA.NumberToString(0));
RDebugUtils.currentLine=262429;
 //BA.debugLineNum = 262429;BA.debugLine="End Sub";
return "";
}
public String  _icontabs2(b4j.example.asbottommenu __ref,anywheresoftware.b4a.objects.collections.Map _props) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "icontabs2"))
	 {return ((String) Debug.delegate(ba, "icontabs2", new Object[] {_props}));}
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pnl_asbm_page_background = null;
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pnl_asbm_parting_line = null;
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pnl_asbm_add_background = null;
anywheresoftware.b4j.objects.ImageViewWrapper _pnl_asbm_add_icon = null;
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pnl_asbm_page_1 = null;
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pnl_asbm_page_2 = null;
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _pnl_asbm_slider = null;
anywheresoftware.b4j.objects.LabelWrapper _pnl_asbm_badget_1 = null;
anywheresoftware.b4j.objects.LabelWrapper _pnl_asbm_badget_2 = null;
RDebugUtils.currentLine=327680;
 //BA.debugLineNum = 327680;BA.debugLine="Private Sub IconTabs2(Props As Map)";
RDebugUtils.currentLine=327689;
 //BA.debugLineNum = 327689;BA.debugLine="Dim pnl_asbm_page_background As Pane";
_pnl_asbm_page_background = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=327690;
 //BA.debugLineNum = 327690;BA.debugLine="Dim pnl_asbm_parting_line As Pane";
_pnl_asbm_parting_line = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=327691;
 //BA.debugLineNum = 327691;BA.debugLine="Dim pnl_asbm_add_background As Pane";
_pnl_asbm_add_background = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=327698;
 //BA.debugLineNum = 327698;BA.debugLine="pnl_asbm_page_background.Initialize(\"asbm_page_ba";
_pnl_asbm_page_background.Initialize(ba,"asbm_page_background");
RDebugUtils.currentLine=327699;
 //BA.debugLineNum = 327699;BA.debugLine="asbm_page_background = pnl_asbm_page_background";
__ref._asbm_page_background.setObject((java.lang.Object)(_pnl_asbm_page_background.getObject()));
RDebugUtils.currentLine=327703;
 //BA.debugLineNum = 327703;BA.debugLine="pnl_asbm_parting_line.Initialize(\"asbm_parting_li";
_pnl_asbm_parting_line.Initialize(ba,"asbm_parting_line");
RDebugUtils.currentLine=327704;
 //BA.debugLineNum = 327704;BA.debugLine="asbm_parting_line = pnl_asbm_parting_line";
__ref._asbm_parting_line.setObject((java.lang.Object)(_pnl_asbm_parting_line.getObject()));
RDebugUtils.currentLine=327707;
 //BA.debugLineNum = 327707;BA.debugLine="pnl_asbm_add_background.Initialize(\"asbm_add_back";
_pnl_asbm_add_background.Initialize(ba,"asbm_add_background");
RDebugUtils.currentLine=327708;
 //BA.debugLineNum = 327708;BA.debugLine="asbm_add_background = pnl_asbm_add_background";
__ref._asbm_add_background.setObject((java.lang.Object)(_pnl_asbm_add_background.getObject()));
RDebugUtils.currentLine=327709;
 //BA.debugLineNum = 327709;BA.debugLine="asbm_add_background.Height = mBase.Height/1.2";
__ref._asbm_add_background.setHeight(__ref._mbase.getHeight()/(double)1.2);
RDebugUtils.currentLine=327710;
 //BA.debugLineNum = 327710;BA.debugLine="asbm_add_background.Width = mBase.Height/1.2";
__ref._asbm_add_background.setWidth(__ref._mbase.getHeight()/(double)1.2);
RDebugUtils.currentLine=327712;
 //BA.debugLineNum = 327712;BA.debugLine="Dim pnl_asbm_add_icon As ImageView";
_pnl_asbm_add_icon = new anywheresoftware.b4j.objects.ImageViewWrapper();
RDebugUtils.currentLine=327713;
 //BA.debugLineNum = 327713;BA.debugLine="pnl_asbm_add_icon.Initialize(\"asbm_icon_4\")";
_pnl_asbm_add_icon.Initialize(ba,"asbm_icon_4");
RDebugUtils.currentLine=327727;
 //BA.debugLineNum = 327727;BA.debugLine="pnl_asbm_add_icon.SetImage(xui.LoadBitmap(File.Di";
_pnl_asbm_add_icon.SetImage((javafx.scene.image.Image)(__ref._xui.LoadBitmap(__c.File.getDirAssets(),"add.png").getObject()));
RDebugUtils.currentLine=327734;
 //BA.debugLineNum = 327734;BA.debugLine="asbm_add_icon = pnl_asbm_add_icon";
__ref._asbm_add_icon.setObject((java.lang.Object)(_pnl_asbm_add_icon.getObject()));
RDebugUtils.currentLine=327739;
 //BA.debugLineNum = 327739;BA.debugLine="Dim pnl_asbm_page_1 As Pane";
_pnl_asbm_page_1 = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=327740;
 //BA.debugLineNum = 327740;BA.debugLine="Dim pnl_asbm_page_2 As Pane";
_pnl_asbm_page_2 = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=327748;
 //BA.debugLineNum = 327748;BA.debugLine="pnl_asbm_page_1.Initialize(\"asbm_page_1\")";
_pnl_asbm_page_1.Initialize(ba,"asbm_page_1");
RDebugUtils.currentLine=327749;
 //BA.debugLineNum = 327749;BA.debugLine="asbm_page_1 = pnl_asbm_page_1";
__ref._asbm_page_1.setObject((java.lang.Object)(_pnl_asbm_page_1.getObject()));
RDebugUtils.currentLine=327753;
 //BA.debugLineNum = 327753;BA.debugLine="pnl_asbm_page_2.Initialize(\"asbm_page_2\")";
_pnl_asbm_page_2.Initialize(ba,"asbm_page_2");
RDebugUtils.currentLine=327754;
 //BA.debugLineNum = 327754;BA.debugLine="asbm_page_2 = pnl_asbm_page_2";
__ref._asbm_page_2.setObject((java.lang.Object)(_pnl_asbm_page_2.getObject()));
RDebugUtils.currentLine=327768;
 //BA.debugLineNum = 327768;BA.debugLine="asbm_icon_1.Initialize(\"asbm_icon_1\")";
__ref._asbm_icon_1.Initialize(ba,"asbm_icon_1");
RDebugUtils.currentLine=327784;
 //BA.debugLineNum = 327784;BA.debugLine="asbm_icon_2.Initialize(\"asbm_icon_2\")";
__ref._asbm_icon_2.Initialize(ba,"asbm_icon_2");
RDebugUtils.currentLine=327813;
 //BA.debugLineNum = 327813;BA.debugLine="Dim pnl_asbm_slider As Pane";
_pnl_asbm_slider = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=327822;
 //BA.debugLineNum = 327822;BA.debugLine="pnl_asbm_slider.Initialize(\"asbm_slider\")";
_pnl_asbm_slider.Initialize(ba,"asbm_slider");
RDebugUtils.currentLine=327823;
 //BA.debugLineNum = 327823;BA.debugLine="asbm_slider = pnl_asbm_slider";
__ref._asbm_slider.setObject((java.lang.Object)(_pnl_asbm_slider.getObject()));
RDebugUtils.currentLine=327833;
 //BA.debugLineNum = 327833;BA.debugLine="Dim pnl_asbm_badget_1 As Label";
_pnl_asbm_badget_1 = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=327834;
 //BA.debugLineNum = 327834;BA.debugLine="pnl_asbm_badget_1.Initialize(\"asbm_badget_1\")";
_pnl_asbm_badget_1.Initialize(ba,"asbm_badget_1");
RDebugUtils.currentLine=327835;
 //BA.debugLineNum = 327835;BA.debugLine="asbm_badget_1 = pnl_asbm_badget_1";
__ref._asbm_badget_1.setObject((java.lang.Object)(_pnl_asbm_badget_1.getObject()));
RDebugUtils.currentLine=327836;
 //BA.debugLineNum = 327836;BA.debugLine="asbm_badget_1.Font = xui.CreateDefaultBoldFont(10";
__ref._asbm_badget_1.setFont(__ref._xui.CreateDefaultBoldFont((float) (10)));
RDebugUtils.currentLine=327837;
 //BA.debugLineNum = 327837;BA.debugLine="asbm_badget_1.TextColor = xui.Color_White";
__ref._asbm_badget_1.setTextColor(__ref._xui.Color_White);
RDebugUtils.currentLine=327838;
 //BA.debugLineNum = 327838;BA.debugLine="asbm_badget_1.SetTextAlignment(\"CENTER\",\"CENTER\")";
__ref._asbm_badget_1.SetTextAlignment("CENTER","CENTER");
RDebugUtils.currentLine=327842;
 //BA.debugLineNum = 327842;BA.debugLine="Dim pnl_asbm_badget_2 As Label";
_pnl_asbm_badget_2 = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=327843;
 //BA.debugLineNum = 327843;BA.debugLine="pnl_asbm_badget_2.Initialize(\"asbm_badget_2\")";
_pnl_asbm_badget_2.Initialize(ba,"asbm_badget_2");
RDebugUtils.currentLine=327844;
 //BA.debugLineNum = 327844;BA.debugLine="asbm_badget_2 = pnl_asbm_badget_2";
__ref._asbm_badget_2.setObject((java.lang.Object)(_pnl_asbm_badget_2.getObject()));
RDebugUtils.currentLine=327845;
 //BA.debugLineNum = 327845;BA.debugLine="asbm_badget_2.Font = xui.CreateDefaultBoldFont(10";
__ref._asbm_badget_2.setFont(__ref._xui.CreateDefaultBoldFont((float) (10)));
RDebugUtils.currentLine=327846;
 //BA.debugLineNum = 327846;BA.debugLine="asbm_badget_2.TextColor = xui.Color_White";
__ref._asbm_badget_2.setTextColor(__ref._xui.Color_White);
RDebugUtils.currentLine=327847;
 //BA.debugLineNum = 327847;BA.debugLine="asbm_badget_2.SetTextAlignment(\"CENTER\",\"CENTER\")";
__ref._asbm_badget_2.SetTextAlignment("CENTER","CENTER");
RDebugUtils.currentLine=327865;
 //BA.debugLineNum = 327865;BA.debugLine="s_Color1 = xui.PaintOrColorToColor(Props.Get(\"Sli";
__ref._s_color1 = __ref._xui.PaintOrColorToColor(_props.Get((Object)("SliderColor1")));
RDebugUtils.currentLine=327866;
 //BA.debugLineNum = 327866;BA.debugLine="s_Color2 = xui.PaintOrColorToColor(Props.Get(\"Sli";
__ref._s_color2 = __ref._xui.PaintOrColorToColor(_props.Get((Object)("SliderColor2")));
RDebugUtils.currentLine=327869;
 //BA.debugLineNum = 327869;BA.debugLine="b_Color = xui.PaintOrColorToColor(Props.Get(\"Back";
__ref._b_color = __ref._xui.PaintOrColorToColor(_props.Get((Object)("BackgroundColor")));
RDebugUtils.currentLine=327871;
 //BA.debugLineNum = 327871;BA.debugLine="p_Line = xui.PaintOrColorToColor(Props.Get(\"Parti";
__ref._p_line = __ref._xui.PaintOrColorToColor(_props.Get((Object)("PartingLine")));
RDebugUtils.currentLine=327873;
 //BA.debugLineNum = 327873;BA.debugLine="m_BackgroundColor = xui.PaintOrColorToColor(Props";
__ref._m_backgroundcolor = __ref._xui.PaintOrColorToColor(_props.Get((Object)("MiddleBackgroundColor")));
RDebugUtils.currentLine=327875;
 //BA.debugLineNum = 327875;BA.debugLine="e_BadgetColor1 = Props.Get(\"EnableBadgetColor1\")";
__ref._e_badgetcolor1 = BA.ObjectToBoolean(_props.Get((Object)("EnableBadgetColor1")));
RDebugUtils.currentLine=327876;
 //BA.debugLineNum = 327876;BA.debugLine="e_BadgetColor2 = Props.Get(\"EnableBadgetColor2\")";
__ref._e_badgetcolor2 = BA.ObjectToBoolean(_props.Get((Object)("EnableBadgetColor2")));
RDebugUtils.currentLine=327879;
 //BA.debugLineNum = 327879;BA.debugLine="b_color1 = xui.PaintOrColorToColor(Props.Get(\"Bad";
__ref._b_color1 = __ref._xui.PaintOrColorToColor(_props.Get((Object)("BadgetColor1")));
RDebugUtils.currentLine=327880;
 //BA.debugLineNum = 327880;BA.debugLine="b_color2 = xui.PaintOrColorToColor(Props.Get(\"Bad";
__ref._b_color2 = __ref._xui.PaintOrColorToColor(_props.Get((Object)("BadgetColor2")));
RDebugUtils.currentLine=327883;
 //BA.debugLineNum = 327883;BA.debugLine="p_ClickColor = xui.PaintOrColorToColor(Props.Get(";
__ref._p_clickcolor = __ref._xui.PaintOrColorToColor(_props.Get((Object)("PageClickColor")));
RDebugUtils.currentLine=327885;
 //BA.debugLineNum = 327885;BA.debugLine="e_SelectedPageColor = Props.Get(\"EnableSelectedPa";
__ref._e_selectedpagecolor = BA.ObjectToBoolean(_props.Get((Object)("EnableSelectedPageColor")));
RDebugUtils.currentLine=327887;
 //BA.debugLineNum = 327887;BA.debugLine="s_PageColor = xui.PaintOrColorToColor(Props.Get(\"";
__ref._s_pagecolor = __ref._xui.PaintOrColorToColor(_props.Get((Object)("SelectedPageColor")));
RDebugUtils.currentLine=327889;
 //BA.debugLineNum = 327889;BA.debugLine="MiddleButtonVisible = Props.Get(\"MiddleButtonVisi";
__ref._middlebuttonvisible = BA.ObjectToBoolean(_props.Get((Object)("MiddleButtonVisible")));
RDebugUtils.currentLine=327892;
 //BA.debugLineNum = 327892;BA.debugLine="asbm_page_1.Color = b_Color";
__ref._asbm_page_1.setColor(__ref._b_color);
RDebugUtils.currentLine=327893;
 //BA.debugLineNum = 327893;BA.debugLine="asbm_page_2.Color = b_Color";
__ref._asbm_page_2.setColor(__ref._b_color);
RDebugUtils.currentLine=327900;
 //BA.debugLineNum = 327900;BA.debugLine="asbm_slider.Height = 2dip";
__ref._asbm_slider.setHeight(__c.DipToCurrent((int) (2)));
RDebugUtils.currentLine=327901;
 //BA.debugLineNum = 327901;BA.debugLine="asbm_slider.Width = 40dip";
__ref._asbm_slider.setWidth(__c.DipToCurrent((int) (40)));
RDebugUtils.currentLine=327902;
 //BA.debugLineNum = 327902;BA.debugLine="asbm_slider.SetColorAndBorder(s_Color1,0,xui.Colo";
__ref._asbm_slider.SetColorAndBorder(__ref._s_color1,0,__ref._xui.Color_Transparent,__ref._asbm_slider.getHeight()/(double)2);
RDebugUtils.currentLine=327907;
 //BA.debugLineNum = 327907;BA.debugLine="asbm_parting_line.Height = 3dip";
__ref._asbm_parting_line.setHeight(__c.DipToCurrent((int) (3)));
RDebugUtils.currentLine=327908;
 //BA.debugLineNum = 327908;BA.debugLine="asbm_parting_line.Color = p_Line";
__ref._asbm_parting_line.setColor(__ref._p_line);
RDebugUtils.currentLine=327912;
 //BA.debugLineNum = 327912;BA.debugLine="asbm_badget_1.Width = 18dip";
__ref._asbm_badget_1.setWidth(__c.DipToCurrent((int) (18)));
RDebugUtils.currentLine=327913;
 //BA.debugLineNum = 327913;BA.debugLine="asbm_badget_1.Height = 18dip";
__ref._asbm_badget_1.setHeight(__c.DipToCurrent((int) (18)));
RDebugUtils.currentLine=327914;
 //BA.debugLineNum = 327914;BA.debugLine="asbm_badget_1.SetColorAndBorder(b_color1,0dip,xui";
__ref._asbm_badget_1.SetColorAndBorder(__ref._b_color1,__c.DipToCurrent((int) (0)),__ref._xui.Color_White,__ref._asbm_badget_1.getHeight()/(double)2);
RDebugUtils.currentLine=327915;
 //BA.debugLineNum = 327915;BA.debugLine="asbm_badget_1.Text = 0";
__ref._asbm_badget_1.setText(BA.NumberToString(0));
RDebugUtils.currentLine=327918;
 //BA.debugLineNum = 327918;BA.debugLine="asbm_badget_2.Width = 18dip";
__ref._asbm_badget_2.setWidth(__c.DipToCurrent((int) (18)));
RDebugUtils.currentLine=327919;
 //BA.debugLineNum = 327919;BA.debugLine="asbm_badget_2.Height = 18dip";
__ref._asbm_badget_2.setHeight(__c.DipToCurrent((int) (18)));
RDebugUtils.currentLine=327920;
 //BA.debugLineNum = 327920;BA.debugLine="asbm_badget_2.SetColorAndBorder(b_color2,0dip,xui";
__ref._asbm_badget_2.SetColorAndBorder(__ref._b_color2,__c.DipToCurrent((int) (0)),__ref._xui.Color_White,__ref._asbm_badget_2.getHeight()/(double)2);
RDebugUtils.currentLine=327921;
 //BA.debugLineNum = 327921;BA.debugLine="asbm_badget_2.Text = 0";
__ref._asbm_badget_2.setText(BA.NumberToString(0));
RDebugUtils.currentLine=327933;
 //BA.debugLineNum = 327933;BA.debugLine="End Sub";
return "";
}
public String  _enableselectedpagecolor(b4j.example.asbottommenu __ref,boolean _enable) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "enableselectedpagecolor"))
	 {return ((String) Debug.delegate(ba, "enableselectedpagecolor", new Object[] {_enable}));}
RDebugUtils.currentLine=2162688;
 //BA.debugLineNum = 2162688;BA.debugLine="Public Sub EnableSelectedPageColor(enable As Boole";
RDebugUtils.currentLine=2162690;
 //BA.debugLineNum = 2162690;BA.debugLine="e_SelectedPageColor = enable";
__ref._e_selectedpagecolor = _enable;
RDebugUtils.currentLine=2162692;
 //BA.debugLineNum = 2162692;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4j.objects.B4XViewWrapper  _getbase(b4j.example.asbottommenu __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "getbase"))
	 {return ((anywheresoftware.b4j.objects.B4XViewWrapper) Debug.delegate(ba, "getbase", null));}
RDebugUtils.currentLine=524288;
 //BA.debugLineNum = 524288;BA.debugLine="Public Sub GetBase As B4XView";
RDebugUtils.currentLine=524289;
 //BA.debugLineNum = 524289;BA.debugLine="Return mBase";
if (true) return __ref._mbase;
RDebugUtils.currentLine=524290;
 //BA.debugLineNum = 524290;BA.debugLine="End Sub";
return null;
}
public String  _initialize(b4j.example.asbottommenu __ref,anywheresoftware.b4a.BA _ba,Object _callback,String _eventname) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "initialize"))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba,_callback,_eventname}));}
RDebugUtils.currentLine=393216;
 //BA.debugLineNum = 393216;BA.debugLine="Public Sub Initialize (CallBack As Object, EventNa";
RDebugUtils.currentLine=393217;
 //BA.debugLineNum = 393217;BA.debugLine="mEventName = EventName";
__ref._meventname = _eventname;
RDebugUtils.currentLine=393218;
 //BA.debugLineNum = 393218;BA.debugLine="mCallBack = CallBack";
__ref._mcallback = _callback;
RDebugUtils.currentLine=393223;
 //BA.debugLineNum = 393223;BA.debugLine="End Sub";
return "";
}
public String  _setbadgetcolor1(b4j.example.asbottommenu __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setbadgetcolor1"))
	 {return ((String) Debug.delegate(ba, "setbadgetcolor1", new Object[] {_color}));}
RDebugUtils.currentLine=1835008;
 //BA.debugLineNum = 1835008;BA.debugLine="Public Sub SetBadgetColor1(color As Int)";
RDebugUtils.currentLine=1835010;
 //BA.debugLineNum = 1835010;BA.debugLine="b_color1 = color";
__ref._b_color1 = _color;
RDebugUtils.currentLine=1835011;
 //BA.debugLineNum = 1835011;BA.debugLine="asbm_badget_1.Color = b_color1";
__ref._asbm_badget_1.setColor(__ref._b_color1);
RDebugUtils.currentLine=1835012;
 //BA.debugLineNum = 1835012;BA.debugLine="End Sub";
return "";
}
public String  _setbadgetcolor2(b4j.example.asbottommenu __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setbadgetcolor2"))
	 {return ((String) Debug.delegate(ba, "setbadgetcolor2", new Object[] {_color}));}
RDebugUtils.currentLine=1900544;
 //BA.debugLineNum = 1900544;BA.debugLine="Public Sub SetBadgetColor2(color As Int)";
RDebugUtils.currentLine=1900546;
 //BA.debugLineNum = 1900546;BA.debugLine="b_color2 = color";
__ref._b_color2 = _color;
RDebugUtils.currentLine=1900547;
 //BA.debugLineNum = 1900547;BA.debugLine="asbm_badget_2.Color = b_color2";
__ref._asbm_badget_2.setColor(__ref._b_color2);
RDebugUtils.currentLine=1900548;
 //BA.debugLineNum = 1900548;BA.debugLine="End Sub";
return "";
}
public String  _setbadgetcolor3(b4j.example.asbottommenu __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setbadgetcolor3"))
	 {return ((String) Debug.delegate(ba, "setbadgetcolor3", new Object[] {_color}));}
RDebugUtils.currentLine=1966080;
 //BA.debugLineNum = 1966080;BA.debugLine="Public Sub SetBadgetColor3(color As Int)";
RDebugUtils.currentLine=1966082;
 //BA.debugLineNum = 1966082;BA.debugLine="b_color3 = color";
__ref._b_color3 = _color;
RDebugUtils.currentLine=1966083;
 //BA.debugLineNum = 1966083;BA.debugLine="asbm_badget_3.Color = b_color3";
__ref._asbm_badget_3.setColor(__ref._b_color3);
RDebugUtils.currentLine=1966084;
 //BA.debugLineNum = 1966084;BA.debugLine="End Sub";
return "";
}
public String  _setbadgetcolor4(b4j.example.asbottommenu __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setbadgetcolor4"))
	 {return ((String) Debug.delegate(ba, "setbadgetcolor4", new Object[] {_color}));}
RDebugUtils.currentLine=2031616;
 //BA.debugLineNum = 2031616;BA.debugLine="Public Sub SetBadgetColor4(color As Int)";
RDebugUtils.currentLine=2031618;
 //BA.debugLineNum = 2031618;BA.debugLine="b_color4 = color";
__ref._b_color4 = _color;
RDebugUtils.currentLine=2031619;
 //BA.debugLineNum = 2031619;BA.debugLine="asbm_badget_4.Color = b_color4";
__ref._asbm_badget_4.setColor(__ref._b_color4);
RDebugUtils.currentLine=2031620;
 //BA.debugLineNum = 2031620;BA.debugLine="End Sub";
return "";
}
public String  _setbadgetvalue2(b4j.example.asbottommenu __ref,int _value) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setbadgetvalue2"))
	 {return ((String) Debug.delegate(ba, "setbadgetvalue2", new Object[] {_value}));}
RDebugUtils.currentLine=2818048;
 //BA.debugLineNum = 2818048;BA.debugLine="Public Sub SetBadgetValue2(value As Int)";
RDebugUtils.currentLine=2818050;
 //BA.debugLineNum = 2818050;BA.debugLine="If value > 9 Then";
if (_value>9) { 
RDebugUtils.currentLine=2818052;
 //BA.debugLineNum = 2818052;BA.debugLine="asbm_badget_2.Text = \"+\" & 9";
__ref._asbm_badget_2.setText("+"+BA.NumberToString(9));
 }else 
{RDebugUtils.currentLine=2818054;
 //BA.debugLineNum = 2818054;BA.debugLine="Else if value < 0 Then";
if (_value<0) { 
RDebugUtils.currentLine=2818056;
 //BA.debugLineNum = 2818056;BA.debugLine="asbm_badget_2.Text = 0";
__ref._asbm_badget_2.setText(BA.NumberToString(0));
 }else {
RDebugUtils.currentLine=2818061;
 //BA.debugLineNum = 2818061;BA.debugLine="asbm_badget_2.Text = value";
__ref._asbm_badget_2.setText(BA.NumberToString(_value));
 }}
;
RDebugUtils.currentLine=2818065;
 //BA.debugLineNum = 2818065;BA.debugLine="End Sub";
return "";
}
public String  _setbadgetvalue3(b4j.example.asbottommenu __ref,int _value) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setbadgetvalue3"))
	 {return ((String) Debug.delegate(ba, "setbadgetvalue3", new Object[] {_value}));}
RDebugUtils.currentLine=2883584;
 //BA.debugLineNum = 2883584;BA.debugLine="Public Sub SetBadgetValue3(value As Int)";
RDebugUtils.currentLine=2883586;
 //BA.debugLineNum = 2883586;BA.debugLine="If value > 9 Then";
if (_value>9) { 
RDebugUtils.currentLine=2883588;
 //BA.debugLineNum = 2883588;BA.debugLine="asbm_badget_3.Text = \"+\" & 9";
__ref._asbm_badget_3.setText("+"+BA.NumberToString(9));
 }else 
{RDebugUtils.currentLine=2883590;
 //BA.debugLineNum = 2883590;BA.debugLine="Else if value < 0 Then";
if (_value<0) { 
RDebugUtils.currentLine=2883592;
 //BA.debugLineNum = 2883592;BA.debugLine="asbm_badget_3.Text = 0";
__ref._asbm_badget_3.setText(BA.NumberToString(0));
 }else {
RDebugUtils.currentLine=2883597;
 //BA.debugLineNum = 2883597;BA.debugLine="asbm_badget_3.Text = value";
__ref._asbm_badget_3.setText(BA.NumberToString(_value));
 }}
;
RDebugUtils.currentLine=2883601;
 //BA.debugLineNum = 2883601;BA.debugLine="End Sub";
return "";
}
public String  _setbadgetvalue4(b4j.example.asbottommenu __ref,int _value) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setbadgetvalue4"))
	 {return ((String) Debug.delegate(ba, "setbadgetvalue4", new Object[] {_value}));}
RDebugUtils.currentLine=2949120;
 //BA.debugLineNum = 2949120;BA.debugLine="Public Sub SetBadgetValue4(value As Int)";
RDebugUtils.currentLine=2949122;
 //BA.debugLineNum = 2949122;BA.debugLine="If value > 9 Then";
if (_value>9) { 
RDebugUtils.currentLine=2949124;
 //BA.debugLineNum = 2949124;BA.debugLine="asbm_badget_4.Text = \"+\" & 9";
__ref._asbm_badget_4.setText("+"+BA.NumberToString(9));
 }else 
{RDebugUtils.currentLine=2949126;
 //BA.debugLineNum = 2949126;BA.debugLine="Else if value < 0 Then";
if (_value<0) { 
RDebugUtils.currentLine=2949128;
 //BA.debugLineNum = 2949128;BA.debugLine="asbm_badget_4.Text = 0";
__ref._asbm_badget_4.setText(BA.NumberToString(0));
 }else {
RDebugUtils.currentLine=2949133;
 //BA.debugLineNum = 2949133;BA.debugLine="asbm_badget_4.Text = value";
__ref._asbm_badget_4.setText(BA.NumberToString(_value));
 }}
;
RDebugUtils.currentLine=2949137;
 //BA.debugLineNum = 2949137;BA.debugLine="End Sub";
return "";
}
public String  _setcurrentpage(b4j.example.asbottommenu __ref,int _page) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setcurrentpage"))
	 {return ((String) Debug.delegate(ba, "setcurrentpage", new Object[] {_page}));}
RDebugUtils.currentLine=3342336;
 //BA.debugLineNum = 3342336;BA.debugLine="Public Sub SetCurrentPage(page As Int)";
RDebugUtils.currentLine=3342338;
 //BA.debugLineNum = 3342338;BA.debugLine="If page = 1 Then";
if (_page==1) { 
RDebugUtils.currentLine=3342340;
 //BA.debugLineNum = 3342340;BA.debugLine="asbm_page_1_handler(asbm_page_1)";
__ref._asbm_page_1_handler(null,__ref._asbm_page_1);
 }else 
{RDebugUtils.currentLine=3342342;
 //BA.debugLineNum = 3342342;BA.debugLine="Else If page = 2 Then";
if (_page==2) { 
RDebugUtils.currentLine=3342344;
 //BA.debugLineNum = 3342344;BA.debugLine="asbm_page_2_handler(asbm_page_2)";
__ref._asbm_page_2_handler(null,__ref._asbm_page_2);
 }else 
{RDebugUtils.currentLine=3342346;
 //BA.debugLineNum = 3342346;BA.debugLine="Else If page = 3 Then";
if (_page==3) { 
RDebugUtils.currentLine=3342348;
 //BA.debugLineNum = 3342348;BA.debugLine="asbm_page_3_handler(asbm_page_3)";
__ref._asbm_page_3_handler(null,__ref._asbm_page_3);
 }else 
{RDebugUtils.currentLine=3342350;
 //BA.debugLineNum = 3342350;BA.debugLine="Else If page = 4 Then";
if (_page==4) { 
RDebugUtils.currentLine=3342352;
 //BA.debugLineNum = 3342352;BA.debugLine="asbm_page_4_handler(asbm_page_4)";
__ref._asbm_page_4_handler(null,__ref._asbm_page_4);
 }else {
RDebugUtils.currentLine=3342356;
 //BA.debugLineNum = 3342356;BA.debugLine="Log(\"Page number not valid\")";
__c.Log("Page number not valid");
RDebugUtils.currentLine=3342357;
 //BA.debugLineNum = 3342357;BA.debugLine="asbm_page_1_handler(asbm_page_1)";
__ref._asbm_page_1_handler(null,__ref._asbm_page_1);
 }}}}
;
RDebugUtils.currentLine=3342361;
 //BA.debugLineNum = 3342361;BA.debugLine="End Sub";
return "";
}
public String  _setmenubackgroundcolor(b4j.example.asbottommenu __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setmenubackgroundcolor"))
	 {return ((String) Debug.delegate(ba, "setmenubackgroundcolor", new Object[] {_color}));}
RDebugUtils.currentLine=2097152;
 //BA.debugLineNum = 2097152;BA.debugLine="Public Sub SetMenuBackgroundColor(color As Int)";
RDebugUtils.currentLine=2097154;
 //BA.debugLineNum = 2097154;BA.debugLine="b_Color = color";
__ref._b_color = _color;
RDebugUtils.currentLine=2097155;
 //BA.debugLineNum = 2097155;BA.debugLine="asbm_page_background.Color = b_Color";
__ref._asbm_page_background.setColor(__ref._b_color);
RDebugUtils.currentLine=2097156;
 //BA.debugLineNum = 2097156;BA.debugLine="End Sub";
return "";
}
public String  _setmiddlebuttonbackgroundcolor(b4j.example.asbottommenu __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setmiddlebuttonbackgroundcolor"))
	 {return ((String) Debug.delegate(ba, "setmiddlebuttonbackgroundcolor", new Object[] {_color}));}
RDebugUtils.currentLine=2359296;
 //BA.debugLineNum = 2359296;BA.debugLine="Public Sub SetMiddleButtonBackgroundColor(color As";
RDebugUtils.currentLine=2359299;
 //BA.debugLineNum = 2359299;BA.debugLine="m_BackgroundColor = color";
__ref._m_backgroundcolor = _color;
RDebugUtils.currentLine=2359300;
 //BA.debugLineNum = 2359300;BA.debugLine="asbm_add_background.Color = m_BackgroundColor";
__ref._asbm_add_background.setColor(__ref._m_backgroundcolor);
RDebugUtils.currentLine=2359302;
 //BA.debugLineNum = 2359302;BA.debugLine="End Sub";
return "";
}
public String  _setmiddlebuttonicon(b4j.example.asbottommenu __ref,anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper _icon) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setmiddlebuttonicon"))
	 {return ((String) Debug.delegate(ba, "setmiddlebuttonicon", new Object[] {_icon}));}
RDebugUtils.currentLine=3276800;
 //BA.debugLineNum = 3276800;BA.debugLine="Public Sub SetMiddleButtonIcon(icon As B4XBitmap)";
RDebugUtils.currentLine=3276802;
 //BA.debugLineNum = 3276802;BA.debugLine="middleicon = icon";
__ref._middleicon = _icon;
RDebugUtils.currentLine=3276803;
 //BA.debugLineNum = 3276803;BA.debugLine="asbm_add_icon.SetBitmap(middleicon)";
__ref._asbm_add_icon.SetBitmap((javafx.scene.image.Image)(__ref._middleicon.getObject()));
RDebugUtils.currentLine=3276806;
 //BA.debugLineNum = 3276806;BA.debugLine="End Sub";
return "";
}
public String  _setpageclickcolor(b4j.example.asbottommenu __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setpageclickcolor"))
	 {return ((String) Debug.delegate(ba, "setpageclickcolor", new Object[] {_color}));}
RDebugUtils.currentLine=2293760;
 //BA.debugLineNum = 2293760;BA.debugLine="Public Sub SetPageClickColor(color As Int)";
RDebugUtils.currentLine=2293762;
 //BA.debugLineNum = 2293762;BA.debugLine="p_ClickColor = color";
__ref._p_clickcolor = _color;
RDebugUtils.currentLine=2293764;
 //BA.debugLineNum = 2293764;BA.debugLine="End Sub";
return "";
}
public String  _setpartinglinecolor(b4j.example.asbottommenu __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setpartinglinecolor"))
	 {return ((String) Debug.delegate(ba, "setpartinglinecolor", new Object[] {_color}));}
RDebugUtils.currentLine=2424832;
 //BA.debugLineNum = 2424832;BA.debugLine="Public Sub SetPartingLineColor(color As Int)";
RDebugUtils.currentLine=2424834;
 //BA.debugLineNum = 2424834;BA.debugLine="p_Line = color";
__ref._p_line = _color;
RDebugUtils.currentLine=2424835;
 //BA.debugLineNum = 2424835;BA.debugLine="asbm_parting_line.Color = p_Line";
__ref._asbm_parting_line.setColor(__ref._p_line);
RDebugUtils.currentLine=2424837;
 //BA.debugLineNum = 2424837;BA.debugLine="End Sub";
return "";
}
public String  _setselectedpagecolor(b4j.example.asbottommenu __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setselectedpagecolor"))
	 {return ((String) Debug.delegate(ba, "setselectedpagecolor", new Object[] {_color}));}
RDebugUtils.currentLine=2228224;
 //BA.debugLineNum = 2228224;BA.debugLine="Public Sub SetSelectedPageColor(color As Int)";
RDebugUtils.currentLine=2228226;
 //BA.debugLineNum = 2228226;BA.debugLine="s_PageColor = color";
__ref._s_pagecolor = _color;
RDebugUtils.currentLine=2228228;
 //BA.debugLineNum = 2228228;BA.debugLine="End Sub";
return "";
}
public String  _setslider1color(b4j.example.asbottommenu __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setslider1color"))
	 {return ((String) Debug.delegate(ba, "setslider1color", new Object[] {_color}));}
RDebugUtils.currentLine=2490368;
 //BA.debugLineNum = 2490368;BA.debugLine="Public Sub SetSlider1Color(color As Int)";
RDebugUtils.currentLine=2490370;
 //BA.debugLineNum = 2490370;BA.debugLine="s_Color1 = color";
__ref._s_color1 = _color;
RDebugUtils.currentLine=2490372;
 //BA.debugLineNum = 2490372;BA.debugLine="End Sub";
return "";
}
public String  _setslider2color(b4j.example.asbottommenu __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setslider2color"))
	 {return ((String) Debug.delegate(ba, "setslider2color", new Object[] {_color}));}
RDebugUtils.currentLine=2555904;
 //BA.debugLineNum = 2555904;BA.debugLine="Public Sub SetSlider2Color(color As Int)";
RDebugUtils.currentLine=2555906;
 //BA.debugLineNum = 2555906;BA.debugLine="s_Color2 = color";
__ref._s_color2 = _color;
RDebugUtils.currentLine=2555908;
 //BA.debugLineNum = 2555908;BA.debugLine="End Sub";
return "";
}
public String  _setslider3color(b4j.example.asbottommenu __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setslider3color"))
	 {return ((String) Debug.delegate(ba, "setslider3color", new Object[] {_color}));}
RDebugUtils.currentLine=2621440;
 //BA.debugLineNum = 2621440;BA.debugLine="Public Sub SetSlider3Color(color As Int)";
RDebugUtils.currentLine=2621442;
 //BA.debugLineNum = 2621442;BA.debugLine="s_Color3 = color";
__ref._s_color3 = _color;
RDebugUtils.currentLine=2621444;
 //BA.debugLineNum = 2621444;BA.debugLine="End Sub";
return "";
}
public String  _setslider4color(b4j.example.asbottommenu __ref,int _color) throws Exception{
__ref = this;
RDebugUtils.currentModule="asbottommenu";
if (Debug.shouldDelegate(ba, "setslider4color"))
	 {return ((String) Debug.delegate(ba, "setslider4color", new Object[] {_color}));}
RDebugUtils.currentLine=2686976;
 //BA.debugLineNum = 2686976;BA.debugLine="Public Sub SetSlider4Color(color As Int)";
RDebugUtils.currentLine=2686978;
 //BA.debugLineNum = 2686978;BA.debugLine="s_Color4 = color";
__ref._s_color4 = _color;
RDebugUtils.currentLine=2686980;
 //BA.debugLineNum = 2686980;BA.debugLine="End Sub";
return "";
}
}