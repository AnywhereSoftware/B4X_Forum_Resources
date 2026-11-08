package b4a.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.debug.*;

public class bmpopup extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    private static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new BA(_ba, this, htSubs, "b4a.example.bmpopup");
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            
        }
        if (BA.isShellModeRuntimeCheck(ba)) 
			   this.getClass().getMethod("_class_globals", b4a.example.bmpopup.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 public anywheresoftware.b4a.keywords.Common __c = null;
public anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _mview = null;
public anywheresoftware.b4a.objects.ActivityWrapper _mparent = null;
public String _meventname = "";
public Object _mcallback = null;
public boolean _isvisible = false;
public String _stext = "";
public String _stitle = "";
public String _sicon = "";
public Object _mtag = null;
public int _pbgcolor = 0;
public int _otitlecolor = 0;
public int _omessagecolor = 0;
public int _oiconcolor = 0;
public int _oposition = 0;
public boolean _oappheader = false;
public int _oduration = 0;
public boolean _ocanclose = false;
public anywheresoftware.b4a.objects.LabelWrapper _lblicon = null;
public anywheresoftware.b4a.objects.LabelWrapper _lblcontent = null;
public anywheresoftware.b4a.objects.LabelWrapper _lbltitle = null;
public anywheresoftware.b4a.objects.LabelWrapper _lblclose = null;
public anywheresoftware.b4a.objects.PanelWrapper _pnlbackground = null;
public int _h_top = 0;
public int _h_center = 0;
public int _h_bottom = 0;
public anywheresoftware.b4a.objects.Timer _tmr = null;
public long _starttime = 0L;
public anywheresoftware.b4a.objects.PanelWrapper _pnltouch = null;
public String  _class_globals() throws Exception{
 //BA.debugLineNum = 4;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 5;BA.debugLine="Dim xui As XUI";
_xui = new anywheresoftware.b4a.objects.B4XViewWrapper.XUI();
 //BA.debugLineNum = 7;BA.debugLine="Public mView As B4XView";
_mview = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 8;BA.debugLine="Public mParent As Activity";
_mparent = new anywheresoftware.b4a.objects.ActivityWrapper();
 //BA.debugLineNum = 9;BA.debugLine="Public mEventName As String";
_meventname = "";
 //BA.debugLineNum = 10;BA.debugLine="Public mCallBack As Object";
_mcallback = new Object();
 //BA.debugLineNum = 12;BA.debugLine="Public isVisible As Boolean = False";
_isvisible = __c.False;
 //BA.debugLineNum = 14;BA.debugLine="Private sText As String = \"\"";
_stext = "";
 //BA.debugLineNum = 15;BA.debugLine="Private sTitle As String = \"\"";
_stitle = "";
 //BA.debugLineNum = 16;BA.debugLine="Private sIcon As String = \"\"";
_sicon = "";
 //BA.debugLineNum = 18;BA.debugLine="Public 	mTag As Object";
_mtag = new Object();
 //BA.debugLineNum = 19;BA.debugLine="Private pBgColor As Int = Colors.White";
_pbgcolor = __c.Colors.White;
 //BA.debugLineNum = 20;BA.debugLine="Private oTitleColor As Int = Colors.Black";
_otitlecolor = __c.Colors.Black;
 //BA.debugLineNum = 21;BA.debugLine="Private oMessageColor As Int = Colors.Black";
_omessagecolor = __c.Colors.Black;
 //BA.debugLineNum = 22;BA.debugLine="Private oIconColor As Int = Colors.Black";
_oiconcolor = __c.Colors.Black;
 //BA.debugLineNum = 23;BA.debugLine="Private oPosition As Int = 0";
_oposition = (int) (0);
 //BA.debugLineNum = 24;BA.debugLine="Private oAppHeader As Boolean = False";
_oappheader = __c.False;
 //BA.debugLineNum = 25;BA.debugLine="Private oDuration As Int = 0";
_oduration = (int) (0);
 //BA.debugLineNum = 26;BA.debugLine="Private oCanClose As Boolean = True";
_ocanclose = __c.True;
 //BA.debugLineNum = 27;BA.debugLine="Private lblIcon As Label";
_lblicon = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 28;BA.debugLine="Private lblContent As Label";
_lblcontent = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 29;BA.debugLine="Private lblTitle As Label";
_lbltitle = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 30;BA.debugLine="Private lblClose As Label";
_lblclose = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 31;BA.debugLine="Private pnlBackground As Panel";
_pnlbackground = new anywheresoftware.b4a.objects.PanelWrapper();
 //BA.debugLineNum = 33;BA.debugLine="Public H_TOP As Int = 0";
_h_top = (int) (0);
 //BA.debugLineNum = 34;BA.debugLine="Public H_CENTER As Int = 1";
_h_center = (int) (1);
 //BA.debugLineNum = 35;BA.debugLine="Public H_BOTTOM As Int = 2";
_h_bottom = (int) (2);
 //BA.debugLineNum = 37;BA.debugLine="Private tmr As Timer";
_tmr = new anywheresoftware.b4a.objects.Timer();
 //BA.debugLineNum = 38;BA.debugLine="Private StartTime As Long";
_starttime = 0L;
 //BA.debugLineNum = 39;BA.debugLine="Private pnlTouch As Panel";
_pnltouch = new anywheresoftware.b4a.objects.PanelWrapper();
 //BA.debugLineNum = 40;BA.debugLine="End Sub";
return "";
}
public int  _convertmillisecondstoseconds(long _t) throws Exception{
int _seconds = 0;
 //BA.debugLineNum = 123;BA.debugLine="Private Sub ConvertMillisecondsToSeconds(t As Long";
 //BA.debugLineNum = 124;BA.debugLine="Dim Seconds As Int";
_seconds = 0;
 //BA.debugLineNum = 125;BA.debugLine="Seconds = (t Mod DateTime.TicksPerMinute) / DateT";
_seconds = (int) ((_t%__c.DateTime.TicksPerMinute)/(double)__c.DateTime.TicksPerSecond);
 //BA.debugLineNum = 126;BA.debugLine="Return Seconds";
if (true) return _seconds;
 //BA.debugLineNum = 127;BA.debugLine="End Sub";
return 0;
}
public boolean  _getappheader() throws Exception{
 //BA.debugLineNum = 146;BA.debugLine="Public Sub getAppHeader As Boolean";
 //BA.debugLineNum = 147;BA.debugLine="Return oAppHeader";
if (true) return _oappheader;
 //BA.debugLineNum = 148;BA.debugLine="End Sub";
return false;
}
public int  _getbackcolor() throws Exception{
 //BA.debugLineNum = 134;BA.debugLine="Public Sub getBackColor As Int";
 //BA.debugLineNum = 135;BA.debugLine="Return pBgColor";
if (true) return _pbgcolor;
 //BA.debugLineNum = 136;BA.debugLine="End Sub";
return 0;
}
public boolean  _getclose() throws Exception{
 //BA.debugLineNum = 206;BA.debugLine="Public Sub getClose As Boolean";
 //BA.debugLineNum = 207;BA.debugLine="Return oCanClose";
if (true) return _ocanclose;
 //BA.debugLineNum = 208;BA.debugLine="End Sub";
return false;
}
public int  _getduration() throws Exception{
 //BA.debugLineNum = 198;BA.debugLine="Public Sub getDuration As Int";
 //BA.debugLineNum = 199;BA.debugLine="Return oDuration";
if (true) return _oduration;
 //BA.debugLineNum = 200;BA.debugLine="End Sub";
return 0;
}
public String  _getmessage() throws Exception{
 //BA.debugLineNum = 170;BA.debugLine="Public Sub getMessage As String";
 //BA.debugLineNum = 171;BA.debugLine="Return sText";
if (true) return _stext;
 //BA.debugLineNum = 172;BA.debugLine="End Sub";
return "";
}
public Object  _getmessagecolor() throws Exception{
 //BA.debugLineNum = 158;BA.debugLine="Public Sub getMessageColor As Object";
 //BA.debugLineNum = 159;BA.debugLine="Return oMessageColor";
if (true) return (Object)(_omessagecolor);
 //BA.debugLineNum = 160;BA.debugLine="End Sub";
return null;
}
public Object  _gettag() throws Exception{
 //BA.debugLineNum = 214;BA.debugLine="Public Sub getTag As Object";
 //BA.debugLineNum = 215;BA.debugLine="Return mTag";
if (true) return _mtag;
 //BA.debugLineNum = 216;BA.debugLine="End Sub";
return null;
}
public String  _gettitle() throws Exception{
 //BA.debugLineNum = 178;BA.debugLine="Public Sub getTitle As String";
 //BA.debugLineNum = 179;BA.debugLine="Return sTitle";
if (true) return _stitle;
 //BA.debugLineNum = 180;BA.debugLine="End Sub";
return "";
}
public Object  _gettitlecolor() throws Exception{
 //BA.debugLineNum = 150;BA.debugLine="Public Sub getTitleColor As Object";
 //BA.debugLineNum = 151;BA.debugLine="Return oTitleColor";
if (true) return (Object)(_otitlecolor);
 //BA.debugLineNum = 152;BA.debugLine="End Sub";
return null;
}
public String  _hide() throws Exception{
 //BA.debugLineNum = 90;BA.debugLine="Public Sub Hide";
 //BA.debugLineNum = 91;BA.debugLine="mView.SetVisibleAnimated(300, False)";
_mview.SetVisibleAnimated((int) (300),__c.False);
 //BA.debugLineNum = 92;BA.debugLine="isVisible = False";
_isvisible = __c.False;
 //BA.debugLineNum = 93;BA.debugLine="End Sub";
return "";
}
public String  _initialize(anywheresoftware.b4a.BA _ba,anywheresoftware.b4a.objects.ActivityWrapper _parent,String _eventname,Object _callback) throws Exception{
innerInitialize(_ba);
 //BA.debugLineNum = 43;BA.debugLine="Public Sub Initialize(Parent As Activity, EventNam";
 //BA.debugLineNum = 46;BA.debugLine="mParent = Parent";
_mparent = _parent;
 //BA.debugLineNum = 47;BA.debugLine="mEventName = EventName";
_meventname = _eventname;
 //BA.debugLineNum = 48;BA.debugLine="mView = xui.CreatePanel(mEventName)";
_mview = _xui.CreatePanel(ba,_meventname);
 //BA.debugLineNum = 49;BA.debugLine="mView.LoadLayout(\"layout_PopUp\")";
_mview.LoadLayout("layout_PopUp",ba);
 //BA.debugLineNum = 50;BA.debugLine="mCallBack = CallBack";
_mcallback = _callback;
 //BA.debugLineNum = 52;BA.debugLine="End Sub";
return "";
}
public String  _lblclose_click() throws Exception{
 //BA.debugLineNum = 110;BA.debugLine="Private Sub lblClose_Click";
 //BA.debugLineNum = 111;BA.debugLine="Hide";
_hide();
 //BA.debugLineNum = 112;BA.debugLine="End Sub";
return "";
}
public String  _pnltouch_click() throws Exception{
 //BA.debugLineNum = 220;BA.debugLine="Private Sub pnlTouch_Click";
 //BA.debugLineNum = 221;BA.debugLine="If SubExists(mCallBack, mEventName & \"_Click\") Th";
if (__c.SubExists(ba,_mcallback,_meventname+"_Click")) { 
 //BA.debugLineNum = 222;BA.debugLine="CallSub2(mCallBack, mEventName & \"_Click\", mTag)";
__c.CallSubNew2(ba,_mcallback,_meventname+"_Click",_mtag);
 };
 //BA.debugLineNum = 224;BA.debugLine="End Sub";
return "";
}
public String  _setappheader(boolean _header) throws Exception{
 //BA.debugLineNum = 142;BA.debugLine="Public Sub setAppHeader(Header As Boolean)";
 //BA.debugLineNum = 143;BA.debugLine="oAppHeader = Header";
_oappheader = _header;
 //BA.debugLineNum = 144;BA.debugLine="End Sub";
return "";
}
public String  _setbackcolor(int _color) throws Exception{
 //BA.debugLineNum = 130;BA.debugLine="Public Sub setBackColor(Color As Int)";
 //BA.debugLineNum = 131;BA.debugLine="pBgColor = Color";
_pbgcolor = _color;
 //BA.debugLineNum = 132;BA.debugLine="End Sub";
return "";
}
public String  _setclose(boolean _close) throws Exception{
 //BA.debugLineNum = 202;BA.debugLine="Public Sub setClose(Close As Boolean)";
 //BA.debugLineNum = 203;BA.debugLine="oCanClose = Close";
_ocanclose = _close;
 //BA.debugLineNum = 204;BA.debugLine="End Sub";
return "";
}
public String  _setduration(int _seconds) throws Exception{
 //BA.debugLineNum = 194;BA.debugLine="Public Sub setDuration(Seconds As Int)";
 //BA.debugLineNum = 195;BA.debugLine="oDuration = Seconds";
_oduration = _seconds;
 //BA.debugLineNum = 196;BA.debugLine="End Sub";
return "";
}
public String  _seticon(String _icon) throws Exception{
 //BA.debugLineNum = 182;BA.debugLine="Public Sub setIcon(Icon As String)";
 //BA.debugLineNum = 183;BA.debugLine="sIcon = Icon";
_sicon = _icon;
 //BA.debugLineNum = 184;BA.debugLine="End Sub";
return "";
}
public String  _seticoncolor(int _color) throws Exception{
 //BA.debugLineNum = 186;BA.debugLine="Public Sub setIconColor(Color As Int)";
 //BA.debugLineNum = 187;BA.debugLine="oIconColor = Color";
_oiconcolor = _color;
 //BA.debugLineNum = 188;BA.debugLine="End Sub";
return "";
}
public String  _setmessage(String _text) throws Exception{
 //BA.debugLineNum = 166;BA.debugLine="Public Sub setMessage(Text As String)";
 //BA.debugLineNum = 167;BA.debugLine="sText = Text";
_stext = _text;
 //BA.debugLineNum = 168;BA.debugLine="End Sub";
return "";
}
public String  _setmessagecolor(Object _color) throws Exception{
 //BA.debugLineNum = 154;BA.debugLine="Public Sub setMessageColor(Color As Object)";
 //BA.debugLineNum = 155;BA.debugLine="oMessageColor = Color";
_omessagecolor = (int)(BA.ObjectToNumber(_color));
 //BA.debugLineNum = 156;BA.debugLine="End Sub";
return "";
}
public String  _setposition(int _position) throws Exception{
 //BA.debugLineNum = 190;BA.debugLine="Public Sub setPosition(Position As Int)";
 //BA.debugLineNum = 191;BA.debugLine="oPosition = Position";
_oposition = _position;
 //BA.debugLineNum = 192;BA.debugLine="End Sub";
return "";
}
public String  _settag(Object _tag) throws Exception{
 //BA.debugLineNum = 210;BA.debugLine="Public Sub setTag(Tag As Object)";
 //BA.debugLineNum = 211;BA.debugLine="mTag = Tag";
_mtag = _tag;
 //BA.debugLineNum = 212;BA.debugLine="End Sub";
return "";
}
public String  _settitle(String _title) throws Exception{
 //BA.debugLineNum = 174;BA.debugLine="Public Sub setTitle(Title As String)";
 //BA.debugLineNum = 175;BA.debugLine="sTitle = Title";
_stitle = _title;
 //BA.debugLineNum = 176;BA.debugLine="End Sub";
return "";
}
public String  _settitlecolor(Object _color) throws Exception{
 //BA.debugLineNum = 138;BA.debugLine="Public Sub setTitleColor(Color As Object)";
 //BA.debugLineNum = 139;BA.debugLine="oTitleColor = Color";
_otitlecolor = (int)(BA.ObjectToNumber(_color));
 //BA.debugLineNum = 140;BA.debugLine="End Sub";
return "";
}
public String  _show() throws Exception{
float _pos = 0f;
 //BA.debugLineNum = 54;BA.debugLine="Public Sub Show";
 //BA.debugLineNum = 55;BA.debugLine="Dim pos As Float = 0";
_pos = (float) (0);
 //BA.debugLineNum = 57;BA.debugLine="Select oPosition";
switch (_oposition) {
case 0: {
 //BA.debugLineNum = 58;BA.debugLine="Case 0: pos = IIf(oAppHeader,5%y,0)";
_pos = (float)(BA.ObjectToNumber(((_oappheader) ? ((Object)(__c.PerYToCurrent((float) (5),ba))) : ((Object)(0)))));
 break; }
case 1: {
 //BA.debugLineNum = 59;BA.debugLine="Case 1: pos = 35%y";
_pos = (float) (__c.PerYToCurrent((float) (35),ba));
 break; }
case 2: {
 //BA.debugLineNum = 60;BA.debugLine="Case 2: pos = 85%y";
_pos = (float) (__c.PerYToCurrent((float) (85),ba));
 break; }
default: {
 //BA.debugLineNum = 62;BA.debugLine="pos = oPosition";
_pos = (float) (_oposition);
 break; }
}
;
 //BA.debugLineNum = 66;BA.debugLine="mView.SetVisibleAnimated(700, True)";
_mview.SetVisibleAnimated((int) (700),__c.True);
 //BA.debugLineNum = 67;BA.debugLine="mView.SetLayoutAnimated(700,0,0,(mParent.Width*85";
_mview.SetLayoutAnimated((int) (700),(int) (0),(int) (0),(int) ((_mparent.getWidth()*__c.PerXToCurrent((float) (85),ba))),__c.DipToCurrent((int) (110)));
 //BA.debugLineNum = 68;BA.debugLine="mView.Tag = mEventName";
_mview.setTag((Object)(_meventname));
 //BA.debugLineNum = 69;BA.debugLine="mView.BringToFront";
_mview.BringToFront();
 //BA.debugLineNum = 70;BA.debugLine="mView.As(Panel).Elevation = 3dip";
((anywheresoftware.b4a.objects.PanelWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.PanelWrapper(), (android.view.ViewGroup)(_mview.getObject()))).setElevation((float) (__c.DipToCurrent((int) (3))));
 //BA.debugLineNum = 72;BA.debugLine="If isVisible = False Then mParent.AddView(mView,0";
if (_isvisible==__c.False) { 
_mparent.AddView((android.view.View)(_mview.getObject()),(int) (0),(int) (_pos),(int) ((_mparent.getWidth()*__c.PerXToCurrent((float) (85),ba))),__c.DipToCurrent((int) (110)));};
 //BA.debugLineNum = 74;BA.debugLine="lblContent.Text = sText";
_lblcontent.setText(BA.ObjectToCharSequence(_stext));
 //BA.debugLineNum = 75;BA.debugLine="lblContent.TextColor = oMessageColor";
_lblcontent.setTextColor(_omessagecolor);
 //BA.debugLineNum = 76;BA.debugLine="lblTitle.Text = sTitle";
_lbltitle.setText(BA.ObjectToCharSequence(_stitle));
 //BA.debugLineNum = 77;BA.debugLine="lblTitle.TextColor = oTitleColor";
_lbltitle.setTextColor(_otitlecolor);
 //BA.debugLineNum = 78;BA.debugLine="pnlBackground.Color = pBgColor";
_pnlbackground.setColor(_pbgcolor);
 //BA.debugLineNum = 79;BA.debugLine="lblIcon.Text = sIcon";
_lblicon.setText(BA.ObjectToCharSequence(_sicon));
 //BA.debugLineNum = 80;BA.debugLine="lblIcon.TextColor = oIconColor";
_lblicon.setTextColor(_oiconcolor);
 //BA.debugLineNum = 81;BA.debugLine="isVisible = True";
_isvisible = __c.True;
 //BA.debugLineNum = 82;BA.debugLine="StartTime = DateTime.Now";
_starttime = __c.DateTime.getNow();
 //BA.debugLineNum = 83;BA.debugLine="lblClose.Visible = oCanClose";
_lblclose.setVisible(_ocanclose);
 //BA.debugLineNum = 85;BA.debugLine="tmr.Initialize(\"tmr\",1000)";
_tmr.Initialize(ba,"tmr",(long) (1000));
 //BA.debugLineNum = 87;BA.debugLine="If Not(oDuration = 0) Then tmr.Enabled = True";
if (__c.Not(_oduration==0)) { 
_tmr.setEnabled(__c.True);};
 //BA.debugLineNum = 88;BA.debugLine="End Sub";
return "";
}
public String  _tmr_tick() throws Exception{
int _s = 0;
 //BA.debugLineNum = 114;BA.debugLine="Private Sub tmr_Tick";
 //BA.debugLineNum = 116;BA.debugLine="Dim S As Int = ConvertMillisecondsToSeconds(DateT";
_s = _convertmillisecondstoseconds((long) (__c.DateTime.getNow()-_starttime));
 //BA.debugLineNum = 118;BA.debugLine="If S = oDuration Then";
if (_s==_oduration) { 
 //BA.debugLineNum = 119;BA.debugLine="Hide";
_hide();
 };
 //BA.debugLineNum = 121;BA.debugLine="End Sub";
return "";
}
public String  _update() throws Exception{
 //BA.debugLineNum = 95;BA.debugLine="Public Sub Update";
 //BA.debugLineNum = 96;BA.debugLine="If isVisible Then";
if (_isvisible) { 
 //BA.debugLineNum = 97;BA.debugLine="lblContent.Text = sText";
_lblcontent.setText(BA.ObjectToCharSequence(_stext));
 //BA.debugLineNum = 98;BA.debugLine="lblContent.TextColor = oMessageColor";
_lblcontent.setTextColor(_omessagecolor);
 //BA.debugLineNum = 99;BA.debugLine="lblTitle.Text = sTitle";
_lbltitle.setText(BA.ObjectToCharSequence(_stitle));
 //BA.debugLineNum = 100;BA.debugLine="lblTitle.TextColor = oTitleColor";
_lbltitle.setTextColor(_otitlecolor);
 //BA.debugLineNum = 101;BA.debugLine="pnlBackground.Color = pBgColor";
_pnlbackground.setColor(_pbgcolor);
 //BA.debugLineNum = 102;BA.debugLine="lblIcon.Text = sIcon";
_lblicon.setText(BA.ObjectToCharSequence(_sicon));
 //BA.debugLineNum = 103;BA.debugLine="lblIcon.TextColor = oIconColor";
_lblicon.setTextColor(_oiconcolor);
 //BA.debugLineNum = 104;BA.debugLine="isVisible = True";
_isvisible = __c.True;
 //BA.debugLineNum = 105;BA.debugLine="StartTime = DateTime.Now";
_starttime = __c.DateTime.getNow();
 //BA.debugLineNum = 106;BA.debugLine="lblClose.Visible = oCanClose";
_lblclose.setVisible(_ocanclose);
 };
 //BA.debugLineNum = 108;BA.debugLine="End Sub";
return "";
}
public anywheresoftware.b4a.objects.B4XViewWrapper  _view() throws Exception{
 //BA.debugLineNum = 162;BA.debugLine="Public Sub View As B4XView";
 //BA.debugLineNum = 163;BA.debugLine="Return mView";
if (true) return _mview;
 //BA.debugLineNum = 164;BA.debugLine="End Sub";
return null;
}
public Object callSub(String sub, Object sender, Object[] args) throws Exception {
BA.senderHolder.set(sender);
return BA.SubDelegator.SubNotFound;
}
}
