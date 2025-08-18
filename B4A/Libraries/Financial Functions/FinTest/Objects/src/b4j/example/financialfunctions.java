package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class financialfunctions extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.financialfunctions", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.financialfunctions.class).invoke(this, new Object[] {null});
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
public b4j.example.main _main = null;
public b4j.example.b4xpages _b4xpages = null;
public b4j.example.b4xcollections _b4xcollections = null;
public String  _initialize(b4j.example.financialfunctions __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="financialfunctions";
if (Debug.shouldDelegate(ba, "initialize", true))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=8519680;
 //BA.debugLineNum = 8519680;BA.debugLine="public Sub initialize";
RDebugUtils.currentLine=8519682;
 //BA.debugLineNum = 8519682;BA.debugLine="End Sub";
return "";
}
public double  _presentvalue(b4j.example.financialfunctions __ref,double _myrate,double _mynper,double _mypmt,double _myfv,double _mydue) throws Exception{
__ref = this;
RDebugUtils.currentModule="financialfunctions";
if (Debug.shouldDelegate(ba, "presentvalue", true))
	 {return ((Double) Debug.delegate(ba, "presentvalue", new Object[] {_myrate,_mynper,_mypmt,_myfv,_mydue}));}
double _result = 0;
RDebugUtils.currentLine=8585216;
 //BA.debugLineNum = 8585216;BA.debugLine="Public Sub PresentValue(myRate As Double, myNPer A";
RDebugUtils.currentLine=8585218;
 //BA.debugLineNum = 8585218;BA.debugLine="Dim result As Double = 0";
_result = 0;
RDebugUtils.currentLine=8585219;
 //BA.debugLineNum = 8585219;BA.debugLine="result = result+ (myFV / (Power((1+(myRate/myDue)";
_result = _result+(_myfv/(double)(__c.Power((1+(_myrate/(double)_mydue)),(_mynper*_mydue))));
RDebugUtils.currentLine=8585220;
 //BA.debugLineNum = 8585220;BA.debugLine="result = result + (myPMT * ( ( 1 - Power((1+myRat";
_result = _result+(_mypmt*((1-__c.Power((1+_myrate),-_mynper))/(double)_myrate));
RDebugUtils.currentLine=8585221;
 //BA.debugLineNum = 8585221;BA.debugLine="Return result";
if (true) return _result;
RDebugUtils.currentLine=8585222;
 //BA.debugLineNum = 8585222;BA.debugLine="End Sub";
return 0;
}
public double  _futurevalue(b4j.example.financialfunctions __ref,double _myrate,double _mynper,double _mypmt,double _mypv,double _mydue) throws Exception{
__ref = this;
RDebugUtils.currentModule="financialfunctions";
if (Debug.shouldDelegate(ba, "futurevalue", true))
	 {return ((Double) Debug.delegate(ba, "futurevalue", new Object[] {_myrate,_mynper,_mypmt,_mypv,_mydue}));}
double _result = 0;
RDebugUtils.currentLine=8650752;
 //BA.debugLineNum = 8650752;BA.debugLine="Public Sub FutureValue(myRate As Double, myNPer As";
RDebugUtils.currentLine=8650754;
 //BA.debugLineNum = 8650754;BA.debugLine="Dim result As Double = 0";
_result = 0;
RDebugUtils.currentLine=8650755;
 //BA.debugLineNum = 8650755;BA.debugLine="If(myRate <> 0) Then";
if ((_myrate!=0)) { 
RDebugUtils.currentLine=8650756;
 //BA.debugLineNum = 8650756;BA.debugLine="result = -MyPmt * (1 + myRate * myDue) * ( (Powe";
_result = -_mypmt*(1+_myrate*_mydue)*((__c.Power((1+_myrate),_mynper)-1)/(double)_myrate)-_mypv*__c.Power((1+_myrate),_mynper);
 }else {
RDebugUtils.currentLine=8650758;
 //BA.debugLineNum = 8650758;BA.debugLine="result = -(MyPmt * myNPer) - myPV";
_result = -(_mypmt*_mynper)-_mypv;
 };
RDebugUtils.currentLine=8650760;
 //BA.debugLineNum = 8650760;BA.debugLine="Return result";
if (true) return _result;
RDebugUtils.currentLine=8650761;
 //BA.debugLineNum = 8650761;BA.debugLine="End Sub";
return 0;
}
public double  _rateofreturnannuity(b4j.example.financialfunctions __ref,double _myfv,double _mypv,double _myterm) throws Exception{
__ref = this;
RDebugUtils.currentModule="financialfunctions";
if (Debug.shouldDelegate(ba, "rateofreturnannuity", true))
	 {return ((Double) Debug.delegate(ba, "rateofreturnannuity", new Object[] {_myfv,_mypv,_myterm}));}
RDebugUtils.currentLine=8716288;
 //BA.debugLineNum = 8716288;BA.debugLine="public Sub RateOfReturnAnnuity(myFV As Double, myP";
RDebugUtils.currentLine=8716290;
 //BA.debugLineNum = 8716290;BA.debugLine="Return(Power((myFV/myPV),(1/myTerm)) - 1)";
if (true) return (__c.Power((_myfv/(double)_mypv),(1/(double)_myterm))-1);
RDebugUtils.currentLine=8716291;
 //BA.debugLineNum = 8716291;BA.debugLine="End Sub";
return 0;
}
public double  _payment(b4j.example.financialfunctions __ref,double _myrate,double _mynper,double _mypv,double _myfv,double _mydue) throws Exception{
__ref = this;
RDebugUtils.currentModule="financialfunctions";
if (Debug.shouldDelegate(ba, "payment", true))
	 {return ((Double) Debug.delegate(ba, "payment", new Object[] {_myrate,_mynper,_mypv,_myfv,_mydue}));}
double _pval = 0;
double _fval = 0;
double _totalfutureval = 0;
double _geometricsum = 0;
double _totalrate = 0;
double _totalrate1 = 0;
RDebugUtils.currentLine=8847360;
 //BA.debugLineNum = 8847360;BA.debugLine="Public  Sub Payment(myRate As Double, myNPer As Do";
RDebugUtils.currentLine=8847362;
 //BA.debugLineNum = 8847362;BA.debugLine="Dim PVal As Double = -MyPV";
_pval = -_mypv;
RDebugUtils.currentLine=8847363;
 //BA.debugLineNum = 8847363;BA.debugLine="Dim FVal As Double = -MyFV";
_fval = -_myfv;
RDebugUtils.currentLine=8847364;
 //BA.debugLineNum = 8847364;BA.debugLine="If (myNPer == 0) Then Return 0";
if ((_mynper==0)) { 
if (true) return 0;};
RDebugUtils.currentLine=8847366;
 //BA.debugLineNum = 8847366;BA.debugLine="Dim totalFutureVal As Double = 0";
_totalfutureval = 0;
RDebugUtils.currentLine=8847367;
 //BA.debugLineNum = 8847367;BA.debugLine="Dim geometricSum As Double = 0";
_geometricsum = 0;
RDebugUtils.currentLine=8847369;
 //BA.debugLineNum = 8847369;BA.debugLine="If (myRate == 0) Then";
if ((_myrate==0)) { 
RDebugUtils.currentLine=8847370;
 //BA.debugLineNum = 8847370;BA.debugLine="totalFutureVal = FVal + PVal";
_totalfutureval = _fval+_pval;
RDebugUtils.currentLine=8847371;
 //BA.debugLineNum = 8847371;BA.debugLine="geometricSum = myNPer";
_geometricsum = _mynper;
 }else 
{RDebugUtils.currentLine=8847372;
 //BA.debugLineNum = 8847372;BA.debugLine="else if (myDue == 0) Then";
if ((_mydue==0)) { 
RDebugUtils.currentLine=8847373;
 //BA.debugLineNum = 8847373;BA.debugLine="Dim totalRate As Double = Power(myRate + 1, myNP";
_totalrate = __c.Power(_myrate+1,_mynper);
RDebugUtils.currentLine=8847374;
 //BA.debugLineNum = 8847374;BA.debugLine="totalFutureVal = FVal + PVal * totalRate";
_totalfutureval = _fval+_pval*_totalrate;
RDebugUtils.currentLine=8847375;
 //BA.debugLineNum = 8847375;BA.debugLine="geometricSum = (totalRate - 1) / myRate";
_geometricsum = (_totalrate-1)/(double)_myrate;
 }else 
{RDebugUtils.currentLine=8847376;
 //BA.debugLineNum = 8847376;BA.debugLine="else if (myDue == 1) Then";
if ((_mydue==1)) { 
RDebugUtils.currentLine=8847377;
 //BA.debugLineNum = 8847377;BA.debugLine="Dim totalRate1 As Double = Power(myRate + 1, myN";
_totalrate1 = __c.Power(_myrate+1,_mynper);
RDebugUtils.currentLine=8847378;
 //BA.debugLineNum = 8847378;BA.debugLine="totalFutureVal = FVal + PVal * totalRate1";
_totalfutureval = _fval+_pval*_totalrate1;
RDebugUtils.currentLine=8847379;
 //BA.debugLineNum = 8847379;BA.debugLine="geometricSum = ((1 + myRate) * (totalRate1 - 1))";
_geometricsum = ((1+_myrate)*(_totalrate1-1))/(double)_myrate;
 }}}
;
RDebugUtils.currentLine=8847381;
 //BA.debugLineNum = 8847381;BA.debugLine="Return (totalFutureVal) / geometricSum";
if (true) return (_totalfutureval)/(double)_geometricsum;
RDebugUtils.currentLine=8847382;
 //BA.debugLineNum = 8847382;BA.debugLine="End Sub";
return 0;
}
public double  _simpleinterest(b4j.example.financialfunctions __ref,double _myprincipal,double _myrate,double _myterm) throws Exception{
__ref = this;
RDebugUtils.currentModule="financialfunctions";
if (Debug.shouldDelegate(ba, "simpleinterest", true))
	 {return ((Double) Debug.delegate(ba, "simpleinterest", new Object[] {_myprincipal,_myrate,_myterm}));}
RDebugUtils.currentLine=8912896;
 //BA.debugLineNum = 8912896;BA.debugLine="public Sub SimpleInterest(myPrincipal As Double, m";
RDebugUtils.currentLine=8912898;
 //BA.debugLineNum = 8912898;BA.debugLine="Return(myPrincipal * myRate * myTerm)";
if (true) return (_myprincipal*_myrate*_myterm);
RDebugUtils.currentLine=8912899;
 //BA.debugLineNum = 8912899;BA.debugLine="End Sub";
return 0;
}
public double  _compoundinterest(b4j.example.financialfunctions __ref,double _mypv,double _myrate,double _mynper,int _mywritedown) throws Exception{
__ref = this;
RDebugUtils.currentModule="financialfunctions";
if (Debug.shouldDelegate(ba, "compoundinterest", true))
	 {return ((Double) Debug.delegate(ba, "compoundinterest", new Object[] {_mypv,_myrate,_mynper,_mywritedown}));}
RDebugUtils.currentLine=8978432;
 //BA.debugLineNum = 8978432;BA.debugLine="Public Sub CompoundInterest(myPV As Double, myRate";
RDebugUtils.currentLine=8978435;
 //BA.debugLineNum = 8978435;BA.debugLine="Return (myPV*Power((1+(myRate/myWritedown)),(myNP";
if (true) return (_mypv*__c.Power((1+(_myrate/(double)_mywritedown)),(_mynper*_mywritedown)))-_mypv;
RDebugUtils.currentLine=8978436;
 //BA.debugLineNum = 8978436;BA.debugLine="End Sub";
return 0;
}
public double  _netpresentvalue(b4j.example.financialfunctions __ref,double[] _mypv,double[] _myrate) throws Exception{
__ref = this;
RDebugUtils.currentModule="financialfunctions";
if (Debug.shouldDelegate(ba, "netpresentvalue", true))
	 {return ((Double) Debug.delegate(ba, "netpresentvalue", new Object[] {_mypv,_myrate}));}
double _myresult = 0;
double _mycounter = 0;
int _mynper = 0;
RDebugUtils.currentLine=9043968;
 //BA.debugLineNum = 9043968;BA.debugLine="public Sub NetPresentValue(myPV() As Double, myRat";
RDebugUtils.currentLine=9043970;
 //BA.debugLineNum = 9043970;BA.debugLine="Private myResult As Double";
_myresult = 0;
RDebugUtils.currentLine=9043971;
 //BA.debugLineNum = 9043971;BA.debugLine="Private myCounter As Double";
_mycounter = 0;
RDebugUtils.currentLine=9043972;
 //BA.debugLineNum = 9043972;BA.debugLine="Private myNPer As Int = myPV.Length";
_mynper = _mypv.length;
RDebugUtils.currentLine=9043974;
 //BA.debugLineNum = 9043974;BA.debugLine="If myPV.Length <> myRate.Length Then Return -9999";
if (_mypv.length!=_myrate.length) { 
if (true) return -999999999;};
RDebugUtils.currentLine=9043975;
 //BA.debugLineNum = 9043975;BA.debugLine="myResult = 0";
_myresult = 0;
RDebugUtils.currentLine=9043976;
 //BA.debugLineNum = 9043976;BA.debugLine="For myCounter = 0 To myNPer - 1";
{
final double step6 = 1;
final double limit6 = _mynper-1;
_mycounter = 0 ;
for (;_mycounter <= limit6 ;_mycounter = ((double)(0 + _mycounter + step6))  ) {
RDebugUtils.currentLine=9043977;
 //BA.debugLineNum = 9043977;BA.debugLine="myResult = myResult + (myPV(myCounter)/ Power((1";
_myresult = _myresult+(_mypv[(int) (_mycounter)]/(double)__c.Power((1+_myrate[(int) (_mycounter)]),(_mycounter+1)));
 }
};
RDebugUtils.currentLine=9043979;
 //BA.debugLineNum = 9043979;BA.debugLine="Return myResult";
if (true) return _myresult;
RDebugUtils.currentLine=9043980;
 //BA.debugLineNum = 9043980;BA.debugLine="End Sub";
return 0;
}
public double  _numberperiods(b4j.example.financialfunctions __ref,double _mypv,double _mypmt,double _myrate,double _mywritedown) throws Exception{
__ref = this;
RDebugUtils.currentModule="financialfunctions";
if (Debug.shouldDelegate(ba, "numberperiods", true))
	 {return ((Double) Debug.delegate(ba, "numberperiods", new Object[] {_mypv,_mypmt,_myrate,_mywritedown}));}
RDebugUtils.currentLine=9109504;
 //BA.debugLineNum = 9109504;BA.debugLine="public Sub NumberPeriods(myPV As Double, myPmt As";
RDebugUtils.currentLine=9109506;
 //BA.debugLineNum = 9109506;BA.debugLine="Return(-Logarithm(1-(((myRate/myWritedown)*myPV)/";
if (true) return (-__c.Logarithm(1-(((_myrate/(double)_mywritedown)*_mypv)/(double)_mypmt),10)/(double)(__c.Logarithm(1+(_myrate/(double)_mywritedown),10)));
RDebugUtils.currentLine=9109507;
 //BA.debugLineNum = 9109507;BA.debugLine="End Sub";
return 0;
}
public double  _rateofreturnloan(b4j.example.financialfunctions __ref,double _mypv,double _mypmt,double _myterm) throws Exception{
__ref = this;
RDebugUtils.currentModule="financialfunctions";
if (Debug.shouldDelegate(ba, "rateofreturnloan", true))
	 {return ((Double) Debug.delegate(ba, "rateofreturnloan", new Object[] {_mypv,_mypmt,_myterm}));}
RDebugUtils.currentLine=8781824;
 //BA.debugLineNum = 8781824;BA.debugLine="public Sub RateOfReturnLoan(myPV As Double, myPmt";
RDebugUtils.currentLine=8781826;
 //BA.debugLineNum = 8781826;BA.debugLine="Return(Power(((myPmt*myTerm)/myPV),(1/myTerm)) -";
if (true) return (__c.Power(((_mypmt*_myterm)/(double)_mypv),(1/(double)_myterm))-1);
RDebugUtils.currentLine=8781827;
 //BA.debugLineNum = 8781827;BA.debugLine="End Sub";
return 0;
}
public String  _class_globals(b4j.example.financialfunctions __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="financialfunctions";
RDebugUtils.currentLine=8454144;
 //BA.debugLineNum = 8454144;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=8454145;
 //BA.debugLineNum = 8454145;BA.debugLine="End Sub";
return "";
}
}