package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class b4xmainpage extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.b4xmainpage", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.b4xmainpage.class).invoke(this, new Object[] {null});
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
public anywheresoftware.b4a.objects.B4XViewWrapper _root = null;
public anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public anywheresoftware.b4j.objects.ButtonWrapper _button1 = null;
public anywheresoftware.b4j.objects.ButtonWrapper _button2 = null;
public anywheresoftware.b4j.objects.ButtonWrapper _button3 = null;
public anywheresoftware.b4j.objects.ButtonWrapper _button4 = null;
public anywheresoftware.b4j.objects.ButtonWrapper _button5 = null;
public anywheresoftware.b4j.objects.ButtonWrapper _button6 = null;
public anywheresoftware.b4j.objects.ButtonWrapper _button7 = null;
public anywheresoftware.b4j.objects.ButtonWrapper _button8 = null;
public anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _fv = null;
public anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _nper = null;
public anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _pmt = null;
public anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _pv = null;
public anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _rate = null;
public anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _due = null;
public anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _writedown = null;
public b4j.example.financialfunctions _ff = null;
public anywheresoftware.b4j.objects.LabelWrapper _lblresult = null;
public anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _npvamt1 = null;
public anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _npvamt2 = null;
public anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _npvamt3 = null;
public anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _npvrate1 = null;
public anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _npvrate2 = null;
public anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _npvrate3 = null;
public anywheresoftware.b4j.objects.LabelWrapper _lbnpvlresult = null;
public anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper _projectcost = null;
public anywheresoftware.b4j.objects.ButtonWrapper _button9 = null;
public b4j.example.main _main = null;
public b4j.example.b4xpages _b4xpages = null;
public b4j.example.b4xcollections _b4xcollections = null;
public String  _b4xpage_created(b4j.example.b4xmainpage __ref,anywheresoftware.b4a.objects.B4XViewWrapper _root1) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "b4xpage_created", false))
	 {return ((String) Debug.delegate(ba, "b4xpage_created", new Object[] {_root1}));}
RDebugUtils.currentLine=589824;
 //BA.debugLineNum = 589824;BA.debugLine="Private Sub B4XPage_Created (Root1 As B4XView)";
RDebugUtils.currentLine=589825;
 //BA.debugLineNum = 589825;BA.debugLine="Root = Root1";
__ref._root /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = _root1;
RDebugUtils.currentLine=589826;
 //BA.debugLineNum = 589826;BA.debugLine="Root.LoadLayout(\"MainPage\")";
__ref._root /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .LoadLayout("MainPage",ba);
RDebugUtils.currentLine=589827;
 //BA.debugLineNum = 589827;BA.debugLine="ff.initialize";
__ref._ff /*b4j.example.financialfunctions*/ ._initialize /*String*/ (null,ba);
RDebugUtils.currentLine=589828;
 //BA.debugLineNum = 589828;BA.debugLine="End Sub";
return "";
}
public String  _button1_click(b4j.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "button1_click", false))
	 {return ((String) Debug.delegate(ba, "button1_click", null));}
RDebugUtils.currentLine=1179648;
 //BA.debugLineNum = 1179648;BA.debugLine="Private Sub Button1_Click";
RDebugUtils.currentLine=1179649;
 //BA.debugLineNum = 1179649;BA.debugLine="ResetZeros";
__ref._resetzeros /*String*/ (null);
RDebugUtils.currentLine=1179650;
 //BA.debugLineNum = 1179650;BA.debugLine="lblResult.Text=(\"PresentValue: \" & NumberFormat(f";
__ref._lblresult /*anywheresoftware.b4j.objects.LabelWrapper*/ .setText(("PresentValue: "+__c.NumberFormat(__ref._ff /*b4j.example.financialfunctions*/ ._presentvalue /*double*/ (null,__ref._cdo /*double*/ (null,(Object)(__ref._rate /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._nper /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),-__ref._cdo /*double*/ (null,(Object)(__ref._pmt /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._fv /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._writedown /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText()))),(int) (1),(int) (2))));
RDebugUtils.currentLine=1179651;
 //BA.debugLineNum = 1179651;BA.debugLine="End Sub";
return "";
}
public String  _resetzeros(b4j.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "resetzeros", false))
	 {return ((String) Debug.delegate(ba, "resetzeros", null));}
RDebugUtils.currentLine=1310720;
 //BA.debugLineNum = 1310720;BA.debugLine="Sub ResetZeros";
RDebugUtils.currentLine=1310721;
 //BA.debugLineNum = 1310721;BA.debugLine="If IsNumber(PV.Text)=False Then PV.Text = 0";
if (__c.IsNumber(__ref._pv /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())==__c.False) { 
__ref._pv /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .setText(BA.NumberToString(0));};
RDebugUtils.currentLine=1310722;
 //BA.debugLineNum = 1310722;BA.debugLine="If IsNumber(Rate.Text)=False Then Rate.Text = 0";
if (__c.IsNumber(__ref._rate /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())==__c.False) { 
__ref._rate /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .setText(BA.NumberToString(0));};
RDebugUtils.currentLine=1310723;
 //BA.debugLineNum = 1310723;BA.debugLine="If IsNumber(NPer.Text)=False Then NPer.Text = 0";
if (__c.IsNumber(__ref._nper /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())==__c.False) { 
__ref._nper /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .setText(BA.NumberToString(0));};
RDebugUtils.currentLine=1310724;
 //BA.debugLineNum = 1310724;BA.debugLine="If IsNumber(Pmt.Text)=False Then Pmt.Text = 0";
if (__c.IsNumber(__ref._pmt /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())==__c.False) { 
__ref._pmt /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .setText(BA.NumberToString(0));};
RDebugUtils.currentLine=1310725;
 //BA.debugLineNum = 1310725;BA.debugLine="If IsNumber(FV.Text)=False Then FV.Text = 0";
if (__c.IsNumber(__ref._fv /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())==__c.False) { 
__ref._fv /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .setText(BA.NumberToString(0));};
RDebugUtils.currentLine=1310726;
 //BA.debugLineNum = 1310726;BA.debugLine="If IsNumber(Due.Text)=False Then Due.Text = 0";
if (__c.IsNumber(__ref._due /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())==__c.False) { 
__ref._due /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .setText(BA.NumberToString(0));};
RDebugUtils.currentLine=1310727;
 //BA.debugLineNum = 1310727;BA.debugLine="If IsNumber(Writedown.Text)=False Then Writedown.";
if (__c.IsNumber(__ref._writedown /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())==__c.False) { 
__ref._writedown /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .setText(BA.NumberToString(0));};
RDebugUtils.currentLine=1310728;
 //BA.debugLineNum = 1310728;BA.debugLine="If IsNumber(NPVAmt1.Text)=False Then NPVAmt1.Text";
if (__c.IsNumber(__ref._npvamt1 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())==__c.False) { 
__ref._npvamt1 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .setText(BA.NumberToString(0));};
RDebugUtils.currentLine=1310729;
 //BA.debugLineNum = 1310729;BA.debugLine="If IsNumber(NPVAmt2.Text)=False Then NPVAmt2.Text";
if (__c.IsNumber(__ref._npvamt2 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())==__c.False) { 
__ref._npvamt2 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .setText(BA.NumberToString(0));};
RDebugUtils.currentLine=1310730;
 //BA.debugLineNum = 1310730;BA.debugLine="If IsNumber(NPVAmt3.Text)=False Then NPVAmt3.Text";
if (__c.IsNumber(__ref._npvamt3 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())==__c.False) { 
__ref._npvamt3 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .setText(BA.NumberToString(0));};
RDebugUtils.currentLine=1310731;
 //BA.debugLineNum = 1310731;BA.debugLine="If IsNumber(NPVRate1.Text)=False Then NPVRate1.Te";
if (__c.IsNumber(__ref._npvrate1 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())==__c.False) { 
__ref._npvrate1 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .setText(BA.NumberToString(0));};
RDebugUtils.currentLine=1310732;
 //BA.debugLineNum = 1310732;BA.debugLine="If IsNumber(NPVRate2.Text)=False Then NPVRate2.Te";
if (__c.IsNumber(__ref._npvrate2 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())==__c.False) { 
__ref._npvrate2 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .setText(BA.NumberToString(0));};
RDebugUtils.currentLine=1310733;
 //BA.debugLineNum = 1310733;BA.debugLine="If IsNumber(NPVRate3.Text)=False Then ProjectCost";
if (__c.IsNumber(__ref._npvrate3 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())==__c.False) { 
__ref._projectcost /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .setText(BA.NumberToString(0));};
RDebugUtils.currentLine=1310734;
 //BA.debugLineNum = 1310734;BA.debugLine="End Sub";
return "";
}
public double  _cdo(b4j.example.b4xmainpage __ref,Object _o) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "cdo", false))
	 {return ((Double) Debug.delegate(ba, "cdo", new Object[] {_o}));}
double _d = 0;
RDebugUtils.currentLine=1245184;
 //BA.debugLineNum = 1245184;BA.debugLine="Sub CDo(o As Object) As Double";
RDebugUtils.currentLine=1245185;
 //BA.debugLineNum = 1245185;BA.debugLine="Dim d As Double";
_d = 0;
RDebugUtils.currentLine=1245186;
 //BA.debugLineNum = 1245186;BA.debugLine="d = o";
_d = (double)(BA.ObjectToNumber(_o));
RDebugUtils.currentLine=1245187;
 //BA.debugLineNum = 1245187;BA.debugLine="Return d";
if (true) return _d;
RDebugUtils.currentLine=1245188;
 //BA.debugLineNum = 1245188;BA.debugLine="End Sub";
return 0;
}
public String  _button2_click(b4j.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "button2_click", false))
	 {return ((String) Debug.delegate(ba, "button2_click", null));}
RDebugUtils.currentLine=1114112;
 //BA.debugLineNum = 1114112;BA.debugLine="Private Sub Button2_Click";
RDebugUtils.currentLine=1114113;
 //BA.debugLineNum = 1114113;BA.debugLine="ResetZeros";
__ref._resetzeros /*String*/ (null);
RDebugUtils.currentLine=1114114;
 //BA.debugLineNum = 1114114;BA.debugLine="lblResult.Text=(\"FutureValue: \" & NumberFormat(ff";
__ref._lblresult /*anywheresoftware.b4j.objects.LabelWrapper*/ .setText(("FutureValue: "+__c.NumberFormat(__ref._ff /*b4j.example.financialfunctions*/ ._futurevalue /*double*/ (null,__ref._cdo /*double*/ (null,(Object)(__ref._rate /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._nper /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._pmt /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._pv /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._due /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText()))),(int) (1),(int) (2))));
RDebugUtils.currentLine=1114115;
 //BA.debugLineNum = 1114115;BA.debugLine="End Sub";
return "";
}
public String  _button3_click(b4j.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "button3_click", false))
	 {return ((String) Debug.delegate(ba, "button3_click", null));}
RDebugUtils.currentLine=983040;
 //BA.debugLineNum = 983040;BA.debugLine="Private Sub Button3_Click";
RDebugUtils.currentLine=983041;
 //BA.debugLineNum = 983041;BA.debugLine="ResetZeros";
__ref._resetzeros /*String*/ (null);
RDebugUtils.currentLine=983042;
 //BA.debugLineNum = 983042;BA.debugLine="lblResult.Text=(\"Annual Rate: \" & NumberFormat(ff";
__ref._lblresult /*anywheresoftware.b4j.objects.LabelWrapper*/ .setText(("Annual Rate: "+__c.NumberFormat(__ref._ff /*b4j.example.financialfunctions*/ ._rateofreturnannuity /*double*/ (null,__ref._cdo /*double*/ (null,(Object)(__ref._fv /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._pv /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._nper /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText()))),(int) (1),(int) (2))));
RDebugUtils.currentLine=983043;
 //BA.debugLineNum = 983043;BA.debugLine="End Sub";
return "";
}
public String  _button4_click(b4j.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "button4_click", false))
	 {return ((String) Debug.delegate(ba, "button4_click", null));}
RDebugUtils.currentLine=917504;
 //BA.debugLineNum = 917504;BA.debugLine="Private Sub Button4_Click";
RDebugUtils.currentLine=917505;
 //BA.debugLineNum = 917505;BA.debugLine="ResetZeros";
__ref._resetzeros /*String*/ (null);
RDebugUtils.currentLine=917506;
 //BA.debugLineNum = 917506;BA.debugLine="lblResult.Text=(\"Payment: \" & NumberFormat(ff.Pay";
__ref._lblresult /*anywheresoftware.b4j.objects.LabelWrapper*/ .setText(("Payment: "+__c.NumberFormat(__ref._ff /*b4j.example.financialfunctions*/ ._payment /*double*/ (null,__ref._cdo /*double*/ (null,(Object)(__ref._rate /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._nper /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._pv /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._fv /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._due /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText()))),(int) (1),(int) (2))));
RDebugUtils.currentLine=917507;
 //BA.debugLineNum = 917507;BA.debugLine="End Sub";
return "";
}
public String  _button5_click(b4j.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "button5_click", false))
	 {return ((String) Debug.delegate(ba, "button5_click", null));}
RDebugUtils.currentLine=851968;
 //BA.debugLineNum = 851968;BA.debugLine="Private Sub Button5_Click";
RDebugUtils.currentLine=851969;
 //BA.debugLineNum = 851969;BA.debugLine="ResetZeros";
__ref._resetzeros /*String*/ (null);
RDebugUtils.currentLine=851970;
 //BA.debugLineNum = 851970;BA.debugLine="lblResult.Text=(\"Simple Interest: \" & NumberForma";
__ref._lblresult /*anywheresoftware.b4j.objects.LabelWrapper*/ .setText(("Simple Interest: "+__c.NumberFormat(__ref._ff /*b4j.example.financialfunctions*/ ._simpleinterest /*double*/ (null,__ref._cdo /*double*/ (null,(Object)(__ref._pv /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._rate /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._nper /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText()))),(int) (1),(int) (2))));
RDebugUtils.currentLine=851971;
 //BA.debugLineNum = 851971;BA.debugLine="End Sub";
return "";
}
public String  _button6_click(b4j.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "button6_click", false))
	 {return ((String) Debug.delegate(ba, "button6_click", null));}
RDebugUtils.currentLine=786432;
 //BA.debugLineNum = 786432;BA.debugLine="Private Sub Button6_Click";
RDebugUtils.currentLine=786433;
 //BA.debugLineNum = 786433;BA.debugLine="ResetZeros";
__ref._resetzeros /*String*/ (null);
RDebugUtils.currentLine=786434;
 //BA.debugLineNum = 786434;BA.debugLine="lblResult.Text=(\"Compound Interest: \" & NumberFor";
__ref._lblresult /*anywheresoftware.b4j.objects.LabelWrapper*/ .setText(("Compound Interest: "+__c.NumberFormat(__ref._ff /*b4j.example.financialfunctions*/ ._compoundinterest /*double*/ (null,__ref._cdo /*double*/ (null,(Object)(__ref._pv /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._rate /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._nper /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),(int) (__ref._cdo /*double*/ (null,(Object)(__ref._writedown /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())))),(int) (1),(int) (2))));
RDebugUtils.currentLine=786435;
 //BA.debugLineNum = 786435;BA.debugLine="End Sub";
return "";
}
public String  _button7_click(b4j.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "button7_click", false))
	 {return ((String) Debug.delegate(ba, "button7_click", null));}
double[] _a = null;
double[] _b = null;
RDebugUtils.currentLine=720896;
 //BA.debugLineNum = 720896;BA.debugLine="Private Sub Button7_Click";
RDebugUtils.currentLine=720897;
 //BA.debugLineNum = 720897;BA.debugLine="Dim a() As Double";
_a = new double[(int) (0)];
;
RDebugUtils.currentLine=720898;
 //BA.debugLineNum = 720898;BA.debugLine="Dim b() As Double";
_b = new double[(int) (0)];
;
RDebugUtils.currentLine=720899;
 //BA.debugLineNum = 720899;BA.debugLine="a = Array As Double (CDo(NPVAmt1.Text), CDo(NPVAm";
_a = new double[]{__ref._cdo /*double*/ (null,(Object)(__ref._npvamt1 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._npvamt2 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._npvamt3 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText()))};
RDebugUtils.currentLine=720900;
 //BA.debugLineNum = 720900;BA.debugLine="b = Array As Double (CDo(NPVRate1.Text), CDo(NPVR";
_b = new double[]{__ref._cdo /*double*/ (null,(Object)(__ref._npvrate1 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._npvrate2 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._npvrate3 /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText()))};
RDebugUtils.currentLine=720901;
 //BA.debugLineNum = 720901;BA.debugLine="lbNPVlResult.Text = (\"NPV: \" & NumberFormat(ff.Ne";
__ref._lbnpvlresult /*anywheresoftware.b4j.objects.LabelWrapper*/ .setText(("NPV: "+__c.NumberFormat(__ref._ff /*b4j.example.financialfunctions*/ ._netpresentvalue /*double*/ (null,_a,_b)-__ref._cdo /*double*/ (null,(Object)(__ref._projectcost /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),(int) (1),(int) (2))));
RDebugUtils.currentLine=720902;
 //BA.debugLineNum = 720902;BA.debugLine="End Sub";
return "";
}
public String  _button8_click(b4j.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "button8_click", false))
	 {return ((String) Debug.delegate(ba, "button8_click", null));}
RDebugUtils.currentLine=655360;
 //BA.debugLineNum = 655360;BA.debugLine="Private Sub Button8_Click";
RDebugUtils.currentLine=655361;
 //BA.debugLineNum = 655361;BA.debugLine="lblResult.Text=(\"NPER: \" & NumberFormat(ff.Number";
__ref._lblresult /*anywheresoftware.b4j.objects.LabelWrapper*/ .setText(("NPER: "+__c.NumberFormat(__ref._ff /*b4j.example.financialfunctions*/ ._numberperiods /*double*/ (null,__ref._cdo /*double*/ (null,(Object)(__ref._pv /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._pmt /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._rate /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._writedown /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText()))),(int) (1),(int) (2))));
RDebugUtils.currentLine=655362;
 //BA.debugLineNum = 655362;BA.debugLine="End Sub";
return "";
}
public String  _button9_click(b4j.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "button9_click", false))
	 {return ((String) Debug.delegate(ba, "button9_click", null));}
RDebugUtils.currentLine=1048576;
 //BA.debugLineNum = 1048576;BA.debugLine="Private Sub Button9_Click";
RDebugUtils.currentLine=1048577;
 //BA.debugLineNum = 1048577;BA.debugLine="ResetZeros";
__ref._resetzeros /*String*/ (null);
RDebugUtils.currentLine=1048578;
 //BA.debugLineNum = 1048578;BA.debugLine="lblResult.Text=(\"Rate: \" & NumberFormat(ff.RateOf";
__ref._lblresult /*anywheresoftware.b4j.objects.LabelWrapper*/ .setText(("Rate: "+__c.NumberFormat(__ref._ff /*b4j.example.financialfunctions*/ ._rateofreturnloan /*double*/ (null,__ref._cdo /*double*/ (null,(Object)(__ref._pv /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._pmt /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText())),__ref._cdo /*double*/ (null,(Object)(__ref._nper /*anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper*/ .getText()))),(int) (1),(int) (2))));
RDebugUtils.currentLine=1048579;
 //BA.debugLineNum = 1048579;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4j.example.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
RDebugUtils.currentLine=458752;
 //BA.debugLineNum = 458752;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=458753;
 //BA.debugLineNum = 458753;BA.debugLine="Private Root As B4XView";
_root = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=458754;
 //BA.debugLineNum = 458754;BA.debugLine="Private xui As XUI";
_xui = new anywheresoftware.b4a.objects.B4XViewWrapper.XUI();
RDebugUtils.currentLine=458756;
 //BA.debugLineNum = 458756;BA.debugLine="Private Button1 As Button";
_button1 = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=458757;
 //BA.debugLineNum = 458757;BA.debugLine="Private Button2 As Button";
_button2 = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=458758;
 //BA.debugLineNum = 458758;BA.debugLine="Private Button3 As Button";
_button3 = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=458759;
 //BA.debugLineNum = 458759;BA.debugLine="Private Button4 As Button";
_button4 = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=458760;
 //BA.debugLineNum = 458760;BA.debugLine="Private Button5 As Button";
_button5 = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=458761;
 //BA.debugLineNum = 458761;BA.debugLine="Private Button6 As Button";
_button6 = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=458762;
 //BA.debugLineNum = 458762;BA.debugLine="Private Button7 As Button";
_button7 = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=458763;
 //BA.debugLineNum = 458763;BA.debugLine="Private Button8 As Button";
_button8 = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=458764;
 //BA.debugLineNum = 458764;BA.debugLine="Private FV As TextField";
_fv = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
RDebugUtils.currentLine=458765;
 //BA.debugLineNum = 458765;BA.debugLine="Private NPer As TextField";
_nper = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
RDebugUtils.currentLine=458766;
 //BA.debugLineNum = 458766;BA.debugLine="Private Pmt As TextField";
_pmt = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
RDebugUtils.currentLine=458767;
 //BA.debugLineNum = 458767;BA.debugLine="Private PV As TextField";
_pv = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
RDebugUtils.currentLine=458768;
 //BA.debugLineNum = 458768;BA.debugLine="Private Rate As TextField";
_rate = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
RDebugUtils.currentLine=458769;
 //BA.debugLineNum = 458769;BA.debugLine="Private Due As TextField";
_due = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
RDebugUtils.currentLine=458770;
 //BA.debugLineNum = 458770;BA.debugLine="Private Writedown As TextField";
_writedown = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
RDebugUtils.currentLine=458771;
 //BA.debugLineNum = 458771;BA.debugLine="Dim ff As FinancialFunctions";
_ff = new b4j.example.financialfunctions();
RDebugUtils.currentLine=458773;
 //BA.debugLineNum = 458773;BA.debugLine="Private lblResult As Label";
_lblresult = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=458774;
 //BA.debugLineNum = 458774;BA.debugLine="Private NPVAmt1 As TextField";
_npvamt1 = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
RDebugUtils.currentLine=458775;
 //BA.debugLineNum = 458775;BA.debugLine="Private NPVAmt2 As TextField";
_npvamt2 = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
RDebugUtils.currentLine=458776;
 //BA.debugLineNum = 458776;BA.debugLine="Private NPVAmt3 As TextField";
_npvamt3 = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
RDebugUtils.currentLine=458777;
 //BA.debugLineNum = 458777;BA.debugLine="Private NPVRate1 As TextField";
_npvrate1 = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
RDebugUtils.currentLine=458778;
 //BA.debugLineNum = 458778;BA.debugLine="Private NPVRate2 As TextField";
_npvrate2 = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
RDebugUtils.currentLine=458779;
 //BA.debugLineNum = 458779;BA.debugLine="Private NPVRate3 As TextField";
_npvrate3 = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
RDebugUtils.currentLine=458780;
 //BA.debugLineNum = 458780;BA.debugLine="Private lbNPVlResult As Label";
_lbnpvlresult = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=458781;
 //BA.debugLineNum = 458781;BA.debugLine="Private ProjectCost As TextField";
_projectcost = new anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper();
RDebugUtils.currentLine=458783;
 //BA.debugLineNum = 458783;BA.debugLine="Private Button9 As Button";
_button9 = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=458784;
 //BA.debugLineNum = 458784;BA.debugLine="End Sub";
return "";
}
public String  _initialize(b4j.example.b4xmainpage __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=524288;
 //BA.debugLineNum = 524288;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=524290;
 //BA.debugLineNum = 524290;BA.debugLine="End Sub";
return "";
}
}