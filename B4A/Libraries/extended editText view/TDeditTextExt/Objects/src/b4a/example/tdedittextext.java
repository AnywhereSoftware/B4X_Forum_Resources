package b4a.example;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.debug.*;

public class tdedittextext extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    private static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new BA(_ba, this, htSubs, "b4a.example.tdedittextext");
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            
        }
        if (BA.isShellModeRuntimeCheck(ba)) 
			   this.getClass().getMethod("_class_globals", b4a.example.tdedittextext.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 public anywheresoftware.b4a.keywords.Common __c = null;
public String _meventname = "";
public Object _mcallback = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _mbase = null;
public anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public Object _tag = null;
public anywheresoftware.b4a.objects.IME _ime = null;
public anywheresoftware.b4a.objects.collections.Map _mprops = null;
public anywheresoftware.b4a.objects.EditTextWrapper _edt = null;
public anywheresoftware.b4a.objects.LabelWrapper _lbl1 = null;
public anywheresoftware.b4a.objects.PanelWrapper _pnl = null;
public anywheresoftware.b4a.objects.HorizontalScrollViewWrapper _scvh = null;
public String  _base_resize(double _width,double _height) throws Exception{
 //BA.debugLineNum = 213;BA.debugLine="Private Sub Base_Resize (Width As Double, Height A";
 //BA.debugLineNum = 214;BA.debugLine="End Sub";
return "";
}
public String  _checkmask(String _edttxt) throws Exception{
String _msk = "";
String _t = "";
String _m = "";
String _s = "";
boolean _error = false;
int _start = 0;
int _stop = 0;
int _stepval = 0;
int _x = 0;
 //BA.debugLineNum = 320;BA.debugLine="private Sub checkMask(edtTxt As String)";
 //BA.debugLineNum = 321;BA.debugLine="Dim msk As String = mprops.Get(\"Mask\")";
_msk = BA.ObjectToString(_mprops.Get((Object)("Mask")));
 //BA.debugLineNum = 322;BA.debugLine="Dim T As String = edtTxt";
_t = _edttxt;
 //BA.debugLineNum = 323;BA.debugLine="If msk.Length <> T.Length And mprops.Get(\"SingleL";
if (_msk.length()!=_t.length() && (_mprops.Get((Object)("SingleLine"))).equals((Object)(__c.True))) { 
 //BA.debugLineNum = 324;BA.debugLine="flashError";
_flasherror();
 }else if(_msk.length()==0 || _t.length()==0) { 
 //BA.debugLineNum = 326;BA.debugLine="flashError";
_flasherror();
 }else {
 //BA.debugLineNum = 328;BA.debugLine="Dim M,S As String";
_m = "";
_s = "";
 //BA.debugLineNum = 329;BA.debugLine="Dim error As Boolean = False";
_error = __c.False;
 //BA.debugLineNum = 330;BA.debugLine="Dim start, stop , StepVal As Int";
_start = 0;
_stop = 0;
_stepval = 0;
 //BA.debugLineNum = 331;BA.debugLine="Log(edt.InputType)";
__c.LogImpl("71507339",BA.NumberToString(_edt.getInputType()),0);
 //BA.debugLineNum = 333;BA.debugLine="If  edt.InputType = 524290 Or edt.InputType = 53";
if (_edt.getInputType()==524290 || _edt.getInputType()==536578) { 
 //BA.debugLineNum = 334;BA.debugLine="start = msk.Length-1";
_start = (int) (_msk.length()-1);
 //BA.debugLineNum = 335;BA.debugLine="stop = 0";
_stop = (int) (0);
 //BA.debugLineNum = 336;BA.debugLine="StepVal = -1";
_stepval = (int) (-1);
 }else {
 //BA.debugLineNum = 338;BA.debugLine="start = 0";
_start = (int) (0);
 //BA.debugLineNum = 339;BA.debugLine="stop = msk.Length-1";
_stop = (int) (_msk.length()-1);
 //BA.debugLineNum = 340;BA.debugLine="StepVal = 1";
_stepval = (int) (1);
 };
 //BA.debugLineNum = 343;BA.debugLine="For x = start To stop Step StepVal";
{
final int step21 = _stepval;
final int limit21 = _stop;
_x = _start ;
for (;(step21 > 0 && _x <= limit21) || (step21 < 0 && _x >= limit21) ;_x = ((int)(0 + _x + step21))  ) {
 //BA.debugLineNum = 344;BA.debugLine="If error Then Exit ' on error leave loop";
if (_error) { 
if (true) break;};
 //BA.debugLineNum = 346;BA.debugLine="M = msk.SubString2(x,x+1)";
_m = _msk.substring(_x,(int) (_x+1));
 //BA.debugLineNum = 347;BA.debugLine="S = T.SubString2(x,x+1)";
_s = _t.substring(_x,(int) (_x+1));
 //BA.debugLineNum = 348;BA.debugLine="Select Case edt.InputType";
switch (BA.switchObjectToInt(_edt.getInputType(),(int) (524290),(int) (536578),(int) (524291))) {
case 0: {
 //BA.debugLineNum = 350;BA.debugLine="If m = \"#\" And IsNumber(S) Then";
if ((_m).equals("#") && __c.IsNumber(_s)) { 
 //BA.debugLineNum = 351;BA.debugLine="error = False";
_error = __c.False;
 }else {
 //BA.debugLineNum = 353;BA.debugLine="error = True";
_error = __c.True;
 };
 break; }
case 1: {
 //BA.debugLineNum = 356;BA.debugLine="If m = \"#\" Then";
if ((_m).equals("#")) { 
 //BA.debugLineNum = 357;BA.debugLine="error = Not(IsNumber(S))";
_error = __c.Not(__c.IsNumber(_s));
 }else if((_m).equals(".") || (_m).equals(",")) { 
 //BA.debugLineNum = 359;BA.debugLine="Log(S):Log(M)";
__c.LogImpl("71507367",_s,0);
 //BA.debugLineNum = 359;BA.debugLine="Log(S):Log(M)";
__c.LogImpl("71507367",_m,0);
 //BA.debugLineNum = 360;BA.debugLine="If s <> m Then	error = True";
if ((_s).equals(_m) == false) { 
_error = __c.True;};
 };
 break; }
case 2: {
 //BA.debugLineNum = 363;BA.debugLine="If m = \"#\" Then";
if ((_m).equals("#")) { 
 //BA.debugLineNum = 364;BA.debugLine="error = Not(IsNumber(S))";
_error = __c.Not(__c.IsNumber(_s));
 }else if((_m).equals(".") || (_m).equals("N") || (_m).equals("/") || (_m).equals(";") || (_m).equals("-") || (_m).equals("+") || (_m).equals(",") || (_m).equals("(") || (_m).equals(")") || (_m).equals(" ")) { 
 //BA.debugLineNum = 368;BA.debugLine="If s <> m Then error = True";
if ((_s).equals(_m) == false) { 
_error = __c.True;};
 };
 break; }
default: {
 break; }
}
;
 }
};
 //BA.debugLineNum = 374;BA.debugLine="If error Then";
if (_error) { 
 //BA.debugLineNum = 375;BA.debugLine="flashError";
_flasherror();
 };
 };
 //BA.debugLineNum = 379;BA.debugLine="If xui.SubExists(mCallBack, mCallBack & \"_InputEr";
if (_xui.SubExists(ba,_mcallback,BA.ObjectToString(_mcallback)+"_InputError",(int) (0))) { 
 //BA.debugLineNum = 380;BA.debugLine="CallSubDelayed2(mCallBack,mCallBack  & \"_InputEr";
__c.CallSubDelayed2(ba,_mcallback,BA.ObjectToString(_mcallback)+"_InputError",(Object)(_error));
 };
 //BA.debugLineNum = 382;BA.debugLine="End Sub";
return "";
}
public String  _class_globals() throws Exception{
 //BA.debugLineNum = 63;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 64;BA.debugLine="Private mEventName As String 'ignore";
_meventname = "";
 //BA.debugLineNum = 65;BA.debugLine="Private mCallBack As Object 'ignore";
_mcallback = new Object();
 //BA.debugLineNum = 66;BA.debugLine="Public mBase As B4XView";
_mbase = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 67;BA.debugLine="Private xui As XUI 'ignore";
_xui = new anywheresoftware.b4a.objects.B4XViewWrapper.XUI();
 //BA.debugLineNum = 68;BA.debugLine="Public Tag As Object";
_tag = new Object();
 //BA.debugLineNum = 70;BA.debugLine="Private ime As IME";
_ime = new anywheresoftware.b4a.objects.IME();
 //BA.debugLineNum = 71;BA.debugLine="Private mprops As Map";
_mprops = new anywheresoftware.b4a.objects.collections.Map();
 //BA.debugLineNum = 72;BA.debugLine="Public edt As EditText";
_edt = new anywheresoftware.b4a.objects.EditTextWrapper();
 //BA.debugLineNum = 73;BA.debugLine="Private lbl1 As Label";
_lbl1 = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 74;BA.debugLine="Private pnl As Panel";
_pnl = new anywheresoftware.b4a.objects.PanelWrapper();
 //BA.debugLineNum = 75;BA.debugLine="Public scvH As HorizontalScrollView";
_scvh = new anywheresoftware.b4a.objects.HorizontalScrollViewWrapper();
 //BA.debugLineNum = 76;BA.debugLine="End Sub";
return "";
}
public String  _designercreateview(Object _base,anywheresoftware.b4a.objects.LabelWrapper _lbl,anywheresoftware.b4a.objects.collections.Map _props) throws Exception{
anywheresoftware.b4a.objects.B4XViewWrapper _edtb4x = null;
anywheresoftware.b4a.keywords.constants.TypefaceWrapper _ty = null;
String[] _temp = null;
String _l = "";
 //BA.debugLineNum = 94;BA.debugLine="Public Sub DesignerCreateView (Base As Object, lbl";
 //BA.debugLineNum = 95;BA.debugLine="mBase = Base";
_mbase = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(_base));
 //BA.debugLineNum = 96;BA.debugLine="Tag = mBase.Tag";
_tag = _mbase.getTag();
 //BA.debugLineNum = 97;BA.debugLine="mBase.Tag = Me";
_mbase.setTag(this);
 //BA.debugLineNum = 99;BA.debugLine="mprops=Props";
_mprops = _props;
 //BA.debugLineNum = 101;BA.debugLine="Public edtB4X As B4XView = edt";
_edtb4x = new anywheresoftware.b4a.objects.B4XViewWrapper();
_edtb4x = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(_edt.getObject()));
 //BA.debugLineNum = 102;BA.debugLine="edt.Width = mBase.Width";
_edt.setWidth(_mbase.getWidth());
 //BA.debugLineNum = 103;BA.debugLine="edt.Height = mBase.Height";
_edt.setHeight(_mbase.getHeight());
 //BA.debugLineNum = 104;BA.debugLine="edtB4X.Width = Props.Get(\"Width\")";
_edtb4x.setWidth((int)(BA.ObjectToNumber(_props.Get((Object)("Width")))));
 //BA.debugLineNum = 105;BA.debugLine="edtB4X.Height= Props.Get(\"Height\")";
_edtb4x.setHeight((int)(BA.ObjectToNumber(_props.Get((Object)("Height")))));
 //BA.debugLineNum = 106;BA.debugLine="Dim ty As Typeface = Typeface.DEFAULT";
_ty = new anywheresoftware.b4a.keywords.constants.TypefaceWrapper();
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.DEFAULT));
 //BA.debugLineNum = 107;BA.debugLine="Select Case mprops.get(\"Typeface\")";
switch (BA.switchObjectToInt(_mprops.Get((Object)("Typeface")),(Object)("DEFAULT"),(Object)("MONOSPACE"),(Object)("SERIF"),(Object)("SANS_SERIF"))) {
case 0: {
 //BA.debugLineNum = 109;BA.debugLine="Select Case mprops.Get(\"Style\")";
switch (BA.switchObjectToInt(_mprops.Get((Object)("Style")),(Object)("NORMAL"),(Object)("BOLD"),(Object)("ITALIC"),(Object)("BOLD_ITALIC"))) {
case 0: {
 //BA.debugLineNum = 111;BA.debugLine="ty = Typeface.CreateNew(Typeface.DEFAULT,Type";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.DEFAULT,__c.Typeface.STYLE_NORMAL)));
 break; }
case 1: {
 //BA.debugLineNum = 113;BA.debugLine="ty = Typeface.CreateNew(Typeface.DEFAULT,Type";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.DEFAULT,__c.Typeface.STYLE_BOLD)));
 break; }
case 2: {
 //BA.debugLineNum = 115;BA.debugLine="ty = Typeface.CreateNew(Typeface.DEFAULT,Type";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.DEFAULT,__c.Typeface.STYLE_ITALIC)));
 break; }
case 3: {
 //BA.debugLineNum = 117;BA.debugLine="ty = Typeface.CreateNew(Typeface.DEFAULT,Type";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.DEFAULT,__c.Typeface.STYLE_BOLD_ITALIC)));
 break; }
}
;
 break; }
case 1: {
 //BA.debugLineNum = 120;BA.debugLine="Select Case mprops.Get(\"Style\")";
switch (BA.switchObjectToInt(_mprops.Get((Object)("Style")),(Object)("NORMAL"),(Object)("BOLD"),(Object)("ITALIC"),(Object)("BOLD_ITALIC"))) {
case 0: {
 //BA.debugLineNum = 122;BA.debugLine="ty = Typeface.CreateNew(Typeface.MONOSPACE,Ty";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.MONOSPACE,__c.Typeface.STYLE_NORMAL)));
 break; }
case 1: {
 //BA.debugLineNum = 124;BA.debugLine="ty = Typeface.CreateNew(Typeface.MONOSPACE,Ty";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.MONOSPACE,__c.Typeface.STYLE_BOLD)));
 break; }
case 2: {
 //BA.debugLineNum = 126;BA.debugLine="ty = Typeface.CreateNew(Typeface.MONOSPACE,Ty";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.MONOSPACE,__c.Typeface.STYLE_ITALIC)));
 break; }
case 3: {
 //BA.debugLineNum = 128;BA.debugLine="ty = Typeface.CreateNew(Typeface.MONOSPACE,Ty";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.MONOSPACE,__c.Typeface.STYLE_BOLD_ITALIC)));
 break; }
}
;
 break; }
case 2: {
 //BA.debugLineNum = 131;BA.debugLine="Select Case mprops.Get(\"Style\")";
switch (BA.switchObjectToInt(_mprops.Get((Object)("Style")),(Object)("NORMAL"),(Object)("BOLD"),(Object)("ITALIC"),(Object)("BOLD_ITALIC"))) {
case 0: {
 //BA.debugLineNum = 133;BA.debugLine="ty = Typeface.CreateNew(Typeface.SERIF,Typefa";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.SERIF,__c.Typeface.STYLE_NORMAL)));
 break; }
case 1: {
 //BA.debugLineNum = 135;BA.debugLine="ty = Typeface.CreateNew(Typeface.SERIF,Typefa";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.SERIF,__c.Typeface.STYLE_BOLD)));
 break; }
case 2: {
 //BA.debugLineNum = 137;BA.debugLine="ty = Typeface.CreateNew(Typeface.SERIF,Typefa";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.SERIF,__c.Typeface.STYLE_ITALIC)));
 break; }
case 3: {
 //BA.debugLineNum = 139;BA.debugLine="ty = Typeface.CreateNew(Typeface.SERIF,Typefa";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.SERIF,__c.Typeface.STYLE_BOLD_ITALIC)));
 break; }
}
;
 break; }
case 3: {
 //BA.debugLineNum = 142;BA.debugLine="Select Case mprops.Get(\"Style\")";
switch (BA.switchObjectToInt(_mprops.Get((Object)("Style")),(Object)("NORMAL"),(Object)("BOLD"),(Object)("ITALIC"),(Object)("BOLD_ITALIC"))) {
case 0: {
 //BA.debugLineNum = 144;BA.debugLine="ty = Typeface.CreateNew(Typeface.SANS_SERIF,T";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.SANS_SERIF,__c.Typeface.STYLE_NORMAL)));
 break; }
case 1: {
 //BA.debugLineNum = 146;BA.debugLine="ty = Typeface.CreateNew(Typeface.SANS_SERIF,T";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.SANS_SERIF,__c.Typeface.STYLE_BOLD)));
 break; }
case 2: {
 //BA.debugLineNum = 148;BA.debugLine="ty = Typeface.CreateNew(Typeface.SANS_SERIF,T";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.SANS_SERIF,__c.Typeface.STYLE_ITALIC)));
 break; }
case 3: {
 //BA.debugLineNum = 150;BA.debugLine="ty = Typeface.CreateNew(Typeface.SANS_SERIF,T";
_ty = (anywheresoftware.b4a.keywords.constants.TypefaceWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.constants.TypefaceWrapper(), (android.graphics.Typeface)(__c.Typeface.CreateNew(__c.Typeface.SANS_SERIF,__c.Typeface.STYLE_BOLD_ITALIC)));
 break; }
}
;
 break; }
}
;
 //BA.debugLineNum = 153;BA.debugLine="edtB4X.Font = xui.createfont(ty,mprops.Get(\"Size\"";
_edtb4x.setFont(_xui.CreateFont((android.graphics.Typeface)(_ty.getObject()),(float)(BA.ObjectToNumber(_mprops.Get((Object)("Size"))))));
 //BA.debugLineNum = 154;BA.debugLine="edtB4X.TextSize = mprops.Get(\"Size\")";
_edtb4x.setTextSize((float)(BA.ObjectToNumber(_mprops.Get((Object)("Size")))));
 //BA.debugLineNum = 155;BA.debugLine="edtB4X.SetTextAlignment(mprops.Get(\"VertAlignment";
_edtb4x.SetTextAlignment(BA.ObjectToString(_mprops.Get((Object)("VertAlignment"))),BA.ObjectToString(_mprops.Get((Object)("HorizAlignment"))));
 //BA.debugLineNum = 156;BA.debugLine="edtB4X.TextColor=mprops.Get(\"TextColor\")";
_edtb4x.setTextColor((int)(BA.ObjectToNumber(_mprops.Get((Object)("TextColor")))));
 //BA.debugLineNum = 157;BA.debugLine="edt = edtB4X ' set b4x properties to edt";
_edt = (anywheresoftware.b4a.objects.EditTextWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.EditTextWrapper(), (android.widget.EditText)(_edtb4x.getObject()));
 //BA.debugLineNum = 158;BA.debugLine="Dim temp(3) As String";
_temp = new String[(int) (3)];
java.util.Arrays.fill(_temp,"");
 //BA.debugLineNum = 159;BA.debugLine="temp(0) = mprops.Get(\"Padding\")";
_temp[(int) (0)] = BA.ObjectToString(_mprops.Get((Object)("Padding")));
 //BA.debugLineNum = 160;BA.debugLine="If temp(0).Length>0 Then";
if (_temp[(int) (0)].length()>0) { 
 //BA.debugLineNum = 161;BA.debugLine="temp = Regex.split(\"\\,\",temp(0))";
_temp = __c.Regex.Split("\\,",_temp[(int) (0)]);
 //BA.debugLineNum = 162;BA.debugLine="edt.Padding = Array As Int (temp(0),temp(1),temp";
_edt.setPadding(new int[]{(int)(Double.parseDouble(_temp[(int) (0)])),(int)(Double.parseDouble(_temp[(int) (1)])),(int)(Double.parseDouble(_temp[(int) (2)])),(int)(Double.parseDouble(_temp[(int) (3)]))});
 };
 //BA.debugLineNum = 164;BA.debugLine="edt.Color = mprops.Get(\"Color\")";
_edt.setColor((int)(BA.ObjectToNumber(_mprops.Get((Object)("Color")))));
 //BA.debugLineNum = 165;BA.debugLine="edt.Enabled=mprops.Get(\"Enabled\")";
_edt.setEnabled(BA.ObjectToBoolean(_mprops.Get((Object)("Enabled"))));
 //BA.debugLineNum = 166;BA.debugLine="edt.tag=mprops.Get(\"Tag\")";
_edt.setTag(_mprops.Get((Object)("Tag")));
 //BA.debugLineNum = 167;BA.debugLine="edt.Text=mprops.Get(\"Text\")";
_edt.setText(BA.ObjectToCharSequence(_mprops.Get((Object)("Text"))));
 //BA.debugLineNum = 168;BA.debugLine="edt.PasswordMode = mprops.Get(\"Passwort\")";
_edt.setPasswordMode(BA.ObjectToBoolean(_mprops.Get((Object)("Passwort"))));
 //BA.debugLineNum = 169;BA.debugLine="Select Case mprops.Get(\"InputType\")";
switch (BA.switchObjectToInt(_mprops.Get((Object)("InputType")),(Object)("NONE"),(Object)("NUMBERS"),(Object)("DECIMAL_NUMBERS"),(Object)("TEXT"),(Object)("PHONE"))) {
case 0: {
 //BA.debugLineNum = 171;BA.debugLine="edt.InputType = edt.INPUT_TYPE_NONE";
_edt.setInputType(_edt.INPUT_TYPE_NONE);
 break; }
case 1: {
 //BA.debugLineNum = 173;BA.debugLine="edt.InputType = edt.INPUT_TYPE_NUMBERS";
_edt.setInputType(_edt.INPUT_TYPE_NUMBERS);
 break; }
case 2: {
 //BA.debugLineNum = 175;BA.debugLine="edt.InputType = edt.INPUT_TYPE_DECIMAL_NUMBERS";
_edt.setInputType(_edt.INPUT_TYPE_DECIMAL_NUMBERS);
 break; }
case 3: {
 //BA.debugLineNum = 177;BA.debugLine="edt.InputType = edt.INPUT_TYPE_TEXT";
_edt.setInputType(_edt.INPUT_TYPE_TEXT);
 break; }
case 4: {
 //BA.debugLineNum = 179;BA.debugLine="edt.InputType = edt.INPUT_TYPE_PHONE";
_edt.setInputType(_edt.INPUT_TYPE_PHONE);
 break; }
}
;
 //BA.debugLineNum = 181;BA.debugLine="edt.Hint = mprops.Get(\"HintText\")";
_edt.setHint(BA.ObjectToString(_mprops.Get((Object)("HintText"))));
 //BA.debugLineNum = 182;BA.debugLine="edt.HintColor = mprops.Get(\"HintTextColor\")";
_edt.setHintColor((int)(BA.ObjectToNumber(_mprops.Get((Object)("HintTextColor")))));
 //BA.debugLineNum = 183;BA.debugLine="edt.Wrap = mprops.Get(\"WrapText\")";
_edt.setWrap(BA.ObjectToBoolean(_mprops.Get((Object)("WrapText"))));
 //BA.debugLineNum = 184;BA.debugLine="edt.ForceDoneButton = mprops.Get(\"ForceDone\")";
_edt.setForceDoneButton(BA.ObjectToBoolean(_mprops.Get((Object)("ForceDone"))));
 //BA.debugLineNum = 185;BA.debugLine="SpellCheck(edt,mprops.Get(\"SpellCheck\"))";
_spellcheck(_edt,BA.ObjectToBoolean(_mprops.Get((Object)("SpellCheck"))));
 //BA.debugLineNum = 187;BA.debugLine="scvH.Panel.Color=Colors.Transparent";
_scvh.getPanel().setColor(__c.Colors.Transparent);
 //BA.debugLineNum = 188;BA.debugLine="scvH.Width = mBase.Width";
_scvh.setWidth(_mbase.getWidth());
 //BA.debugLineNum = 189;BA.debugLine="scvH.panel.Width = mBase.width + 50dip";
_scvh.getPanel().setWidth((int) (_mbase.getWidth()+__c.DipToCurrent((int) (50))));
 //BA.debugLineNum = 190;BA.debugLine="scvH.Height =mBase.height";
_scvh.setHeight(_mbase.getHeight());
 //BA.debugLineNum = 191;BA.debugLine="scvH.panel.Height = mBase.height";
_scvh.getPanel().setHeight(_mbase.getHeight());
 //BA.debugLineNum = 193;BA.debugLine="scvH.Panel.AddView(edt,0dip,0dip,scvH.panel.Width";
_scvh.getPanel().AddView((android.view.View)(_edt.getObject()),__c.DipToCurrent((int) (0)),__c.DipToCurrent((int) (0)),_scvh.getPanel().getWidth(),_scvh.getPanel().getHeight());
 //BA.debugLineNum = 194;BA.debugLine="If mprops.Get(\"SingleLine\") Then";
if (BA.ObjectToBoolean(_mprops.Get((Object)("SingleLine")))) { 
 //BA.debugLineNum = 195;BA.debugLine="edt.SingleLine=True";
_edt.setSingleLine(__c.True);
 }else {
 //BA.debugLineNum = 197;BA.debugLine="edt.SingleLine=False";
_edt.setSingleLine(__c.False);
 };
 //BA.debugLineNum = 199;BA.debugLine="Dim l As String = mprops.Get(\"Mask\")";
_l = BA.ObjectToString(_mprops.Get((Object)("Mask")));
 //BA.debugLineNum = 200;BA.debugLine="If l.length > 0 Then mprops.Put(\"Lenght\",l.length";
if (_l.length()>0) { 
_mprops.Put((Object)("Lenght"),(Object)(_l.length()));};
 //BA.debugLineNum = 202;BA.debugLine="pnl.Width = mBase.Width+4: pnl.Height = mBase.hei";
_pnl.setWidth((int) (_mbase.getWidth()+4));
 //BA.debugLineNum = 202;BA.debugLine="pnl.Width = mBase.Width+4: pnl.Height = mBase.hei";
_pnl.setHeight((int) (_mbase.getHeight()+4));
 //BA.debugLineNum = 203;BA.debugLine="pnl.Color = Colors.Transparent";
_pnl.setColor(__c.Colors.Transparent);
 //BA.debugLineNum = 204;BA.debugLine="pnl.Padding = Array As Int (2,2,2,2)";
_pnl.setPadding(new int[]{(int) (2),(int) (2),(int) (2),(int) (2)});
 //BA.debugLineNum = 206;BA.debugLine="pnl.AddView(scvH,0,0,scvH.Width,scvH.Height)";
_pnl.AddView((android.view.View)(_scvh.getObject()),(int) (0),(int) (0),_scvh.getWidth(),_scvh.getHeight());
 //BA.debugLineNum = 208;BA.debugLine="mBase.AddView(pnl,0,0,scvH.width,scvH.height)";
_mbase.AddView((android.view.View)(_pnl.getObject()),(int) (0),(int) (0),_scvh.getWidth(),_scvh.getHeight());
 //BA.debugLineNum = 209;BA.debugLine="End Sub";
return "";
}
public String  _edt_enterpressed() throws Exception{
 //BA.debugLineNum = 265;BA.debugLine="private Sub edt_EnterPressed";
 //BA.debugLineNum = 266;BA.debugLine="If mprops.Get(\"SingleLine\") = True Then";
if ((_mprops.Get((Object)("SingleLine"))).equals((Object)(__c.True))) { 
 //BA.debugLineNum = 268;BA.debugLine="If mprops.get(\"Mask\") <> Null And edt.Text <> \"\"";
if (_mprops.Get((Object)("Mask"))!= null && (_edt.getText()).equals("") == false) { 
 //BA.debugLineNum = 269;BA.debugLine="checkMask(edt.Text)";
_checkmask(_edt.getText());
 };
 }else {
 //BA.debugLineNum = 273;BA.debugLine="If xui.SubExists(mCallBack, mCallBack & \"_EnterP";
if (_xui.SubExists(ba,_mcallback,BA.ObjectToString(_mcallback)+"_EnterPressed",(int) (0))) { 
 //BA.debugLineNum = 274;BA.debugLine="CallSubDelayed(mCallBack,mCallBack  & \"_EnterPr";
__c.CallSubDelayed(ba,_mcallback,BA.ObjectToString(_mcallback)+"_EnterPressed");
 };
 };
 //BA.debugLineNum = 277;BA.debugLine="End Sub";
return "";
}
public String  _edt_focuschanged(boolean _hasfocus) throws Exception{
anywheresoftware.b4a.objects.B4XViewWrapper _edtb4x = null;
 //BA.debugLineNum = 234;BA.debugLine="private Sub edt_FocusChanged(HasFocus As Boolean)";
 //BA.debugLineNum = 236;BA.debugLine="Dim edtB4X As B4XView = pnl";
_edtb4x = new anywheresoftware.b4a.objects.B4XViewWrapper();
_edtb4x = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(_pnl.getObject()));
 //BA.debugLineNum = 237;BA.debugLine="If HasFocus And mprops.get(\"Tint\") Then";
if (_hasfocus && BA.ObjectToBoolean(_mprops.Get((Object)("Tint")))) { 
 //BA.debugLineNum = 238;BA.debugLine="edtB4X.SetColorAndBorder(edtB4X.Color, _ 			mpro";
_edtb4x.SetColorAndBorder(_edtb4x.getColor(),(int)(BA.ObjectToNumber(_mprops.Get((Object)("TintBorderWidth")))),(int)(BA.ObjectToNumber(_mprops.Get((Object)("TintActive")))),(int) (0));
 }else {
 //BA.debugLineNum = 241;BA.debugLine="edtB4X.SetColorAndBorder(edtB4X.Color, _ 			mpro";
_edtb4x.SetColorAndBorder(_edtb4x.getColor(),(int)(BA.ObjectToNumber(_mprops.Get((Object)("TintBorderWidth")))),(int)(BA.ObjectToNumber(_mprops.Get((Object)("TintNotActive")))),(int) (0));
 };
 //BA.debugLineNum = 246;BA.debugLine="pnl=edtB4X";
_pnl = (anywheresoftware.b4a.objects.PanelWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.PanelWrapper(), (android.view.ViewGroup)(_edtb4x.getObject()));
 //BA.debugLineNum = 249;BA.debugLine="If HasFocus = False Then";
if (_hasfocus==__c.False) { 
 //BA.debugLineNum = 250;BA.debugLine="ime.HideKeyboard";
_ime.HideKeyboard(ba);
 }else {
 //BA.debugLineNum = 252;BA.debugLine="ime.ShowKeyboard(edt)";
_ime.ShowKeyboard((android.view.View)(_edt.getObject()));
 };
 //BA.debugLineNum = 256;BA.debugLine="If xui.SubExists(mCallBack, mCallBack & \"_FocusCh";
if (_xui.SubExists(ba,_mcallback,BA.ObjectToString(_mcallback)+"_FocusChanged",(int) (0))) { 
 //BA.debugLineNum = 257;BA.debugLine="CallSubDelayed2(mCallBack,mCallBack  & \"_FocusCh";
__c.CallSubDelayed2(ba,_mcallback,BA.ObjectToString(_mcallback)+"_FocusChanged",(Object)(_hasfocus));
 };
 //BA.debugLineNum = 259;BA.debugLine="End Sub";
return "";
}
public String  _edt_textchanged(String _old,String _new) throws Exception{
 //BA.debugLineNum = 222;BA.debugLine="private Sub edt_TextChanged(old As String, new As";
 //BA.debugLineNum = 223;BA.debugLine="If edt.Text.Length > mprops.Get(\"Length\") Then";
if (_edt.getText().length()>(double)(BA.ObjectToNumber(_mprops.Get((Object)("Length"))))) { 
 //BA.debugLineNum = 224;BA.debugLine="edt.Text=old";
_edt.setText(BA.ObjectToCharSequence(_old));
 };
 //BA.debugLineNum = 227;BA.debugLine="If xui.SubExists(mCallBack, mCallBack & \"_TextCha";
if (_xui.SubExists(ba,_mcallback,BA.ObjectToString(_mcallback)+"_TextChanged",(int) (0))) { 
 //BA.debugLineNum = 228;BA.debugLine="CallSubDelayed3(mCallBack,mCallBack  & \"_TextCha";
__c.CallSubDelayed3(ba,_mcallback,BA.ObjectToString(_mcallback)+"_TextChanged",(Object)(_old),(Object)(_new));
 };
 //BA.debugLineNum = 230;BA.debugLine="End Sub";
return "";
}
public void  _flasherror() throws Exception{
ResumableSub_flashError rsub = new ResumableSub_flashError(this);
rsub.resume(ba, null);
}
public static class ResumableSub_flashError extends BA.ResumableSub {
public ResumableSub_flashError(b4a.example.tdedittextext parent) {
this.parent = parent;
}
b4a.example.tdedittextext parent;
boolean _toggle = false;
int _x = 0;
int step2;
int limit2;

@Override
public void resume(BA ba, Object[] result) throws Exception{

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
 //BA.debugLineNum = 397;BA.debugLine="Dim toggle As Boolean = False";
_toggle = parent.__c.False;
 //BA.debugLineNum = 398;BA.debugLine="For x = 0 To 5";
if (true) break;

case 1:
//for
this.state = 10;
step2 = 1;
limit2 = (int) (5);
_x = (int) (0) ;
this.state = 11;
if (true) break;

case 11:
//C
this.state = 10;
if ((step2 > 0 && _x <= limit2) || (step2 < 0 && _x >= limit2)) this.state = 3;
if (true) break;

case 12:
//C
this.state = 11;
_x = ((int)(0 + _x + step2)) ;
if (true) break;

case 3:
//C
this.state = 4;
 //BA.debugLineNum = 399;BA.debugLine="Sleep(250)";
parent.__c.Sleep(ba,this,(int) (250));
this.state = 13;
return;
case 13:
//C
this.state = 4;
;
 //BA.debugLineNum = 400;BA.debugLine="If toggle = False Then";
if (true) break;

case 4:
//if
this.state = 9;
if (_toggle==parent.__c.False) { 
this.state = 6;
}else {
this.state = 8;
}if (true) break;

case 6:
//C
this.state = 9;
 //BA.debugLineNum = 401;BA.debugLine="edt.Color = 0xFFEF7575";
parent._edt.setColor(((int)0xffef7575));
 //BA.debugLineNum = 402;BA.debugLine="toggle=True";
_toggle = parent.__c.True;
 if (true) break;

case 8:
//C
this.state = 9;
 //BA.debugLineNum = 404;BA.debugLine="edt.Color = mprops.Get(\"Color\")";
parent._edt.setColor((int)(BA.ObjectToNumber(parent._mprops.Get((Object)("Color")))));
 //BA.debugLineNum = 405;BA.debugLine="toggle=False";
_toggle = parent.__c.False;
 if (true) break;

case 9:
//C
this.state = 12;
;
 if (true) break;
if (true) break;

case 10:
//C
this.state = -1;
;
 //BA.debugLineNum = 408;BA.debugLine="edt.Color = mprops.Get(\"Color\")";
parent._edt.setColor((int)(BA.ObjectToNumber(parent._mprops.Get((Object)("Color")))));
 //BA.debugLineNum = 409;BA.debugLine="xui.MsgboxAsync(mprops.Get(\"Message\") & CRLF & _";
parent._xui.MsgboxAsync(ba,BA.ObjectToCharSequence(BA.ObjectToString(parent._mprops.Get((Object)("Message")))+parent.__c.CRLF+"("+BA.ObjectToString(parent._mprops.Get((Object)("Mask")))+")"),BA.ObjectToCharSequence(parent._mprops.Get((Object)("Title"))));
 //BA.debugLineNum = 411;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public String  _initialize(anywheresoftware.b4a.BA _ba,Object _callback,String _eventname) throws Exception{
innerInitialize(_ba);
 //BA.debugLineNum = 80;BA.debugLine="Public Sub Initialize (Callback As Object, EventNa";
 //BA.debugLineNum = 81;BA.debugLine="mEventName = EventName";
_meventname = _eventname;
 //BA.debugLineNum = 82;BA.debugLine="mCallBack = Callback";
_mcallback = _callback;
 //BA.debugLineNum = 84;BA.debugLine="ime.Initialize(\"ime\")";
_ime.Initialize("ime");
 //BA.debugLineNum = 85;BA.debugLine="mprops.initialize";
_mprops.Initialize();
 //BA.debugLineNum = 86;BA.debugLine="edt.Initialize(\"edt\")";
_edt.Initialize(ba,"edt");
 //BA.debugLineNum = 87;BA.debugLine="lbl1.Initialize(\"lbl\")";
_lbl1.Initialize(ba,"lbl");
 //BA.debugLineNum = 88;BA.debugLine="pnl.Initialize(\"pnl\")";
_pnl.Initialize(ba,"pnl");
 //BA.debugLineNum = 89;BA.debugLine="scvH.Initialize(100,\"scvH\")";
_scvh.Initialize(ba,(int) (100),"scvH");
 //BA.debugLineNum = 90;BA.debugLine="End Sub";
return "";
}
public String  _scvv_scrollchanged(int _position) throws Exception{
 //BA.debugLineNum = 285;BA.debugLine="private Sub scvV_ScrollChanged(Position As Int)";
 //BA.debugLineNum = 287;BA.debugLine="If xui.SubExists(mCallBack, mCallBack & \"_ScrollC";
if (_xui.SubExists(ba,_mcallback,BA.ObjectToString(_mcallback)+"_ScrollChanged",(int) (0))) { 
 //BA.debugLineNum = 288;BA.debugLine="CallSubDelayed2(mCallBack,mCallBack  & \"_ScrollC";
__c.CallSubDelayed2(ba,_mcallback,BA.ObjectToString(_mcallback)+"_ScrollChanged",(Object)(_position));
 };
 //BA.debugLineNum = 290;BA.debugLine="End Sub";
return "";
}
public String  _setlength(int _lengthvalue) throws Exception{
 //BA.debugLineNum = 305;BA.debugLine="public Sub setLength(LengthValue As Int)";
 //BA.debugLineNum = 306;BA.debugLine="mprops.put(\"Length\",LengthValue)";
_mprops.Put((Object)("Length"),(Object)(_lengthvalue));
 //BA.debugLineNum = 307;BA.debugLine="End Sub";
return "";
}
public String  _setmask(String _maskstring) throws Exception{
 //BA.debugLineNum = 301;BA.debugLine="public Sub setMask(MaskString As String)";
 //BA.debugLineNum = 302;BA.debugLine="mprops.Put(\"Mask\",MaskString)";
_mprops.Put((Object)("Mask"),(Object)(_maskstring));
 //BA.debugLineNum = 303;BA.debugLine="End Sub";
return "";
}
public String  _setspellchecking(boolean _active) throws Exception{
 //BA.debugLineNum = 309;BA.debugLine="public Sub setSpellChecking(Active As Boolean)";
 //BA.debugLineNum = 310;BA.debugLine="SpellCheck(edt,Active)";
_spellcheck(_edt,_active);
 //BA.debugLineNum = 311;BA.debugLine="mprops.put(\"SpellCheck\",Active)";
_mprops.Put((Object)("SpellCheck"),(Object)(_active));
 //BA.debugLineNum = 312;BA.debugLine="End Sub";
return "";
}
public String  _settint(boolean _dotint) throws Exception{
 //BA.debugLineNum = 296;BA.debugLine="public Sub setTint(DoTint As Boolean)";
 //BA.debugLineNum = 297;BA.debugLine="mprops.Put(\"Tint\",DoTint)";
_mprops.Put((Object)("Tint"),(Object)(_dotint));
 //BA.debugLineNum = 298;BA.debugLine="End Sub";
return "";
}
public String  _spellcheck(anywheresoftware.b4a.objects.EditTextWrapper _et,boolean _enable) throws Exception{
 //BA.debugLineNum = 386;BA.debugLine="private Sub SpellCheck(et As EditText, Enable As B";
 //BA.debugLineNum = 387;BA.debugLine="If Enable Then";
if (_enable) { 
 //BA.debugLineNum = 388;BA.debugLine="et.inputType=Bit.Or(et.InputType, 524288)";
_et.setInputType(__c.Bit.Or(_et.getInputType(),(int) (524288)));
 }else {
 //BA.debugLineNum = 390;BA.debugLine="et.InputType = Bit.And(et.InputType, Bit.Not(524";
_et.setInputType(__c.Bit.And(_et.getInputType(),__c.Bit.Not((int) (524288))));
 };
 //BA.debugLineNum = 392;BA.debugLine="End Sub";
return "";
}
public Object callSub(String sub, Object sender, Object[] args) throws Exception {
BA.senderHolder.set(sender);
return BA.SubDelegator.SubNotFound;
}
}
