package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class financialfunctions_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 1;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 2;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _compoundinterest(RemoteObject __ref,RemoteObject _mypv,RemoteObject _myrate,RemoteObject _mynper,RemoteObject _mywritedown) throws Exception{
try {
		Debug.PushSubsStack("CompoundInterest (financialfunctions) ","financialfunctions",10,__ref.getField(false, "ba"),__ref,67);
if (RapidSub.canDelegate("compoundinterest")) { return __ref.runUserSub(false, "financialfunctions","compoundinterest", __ref, _mypv, _myrate, _mynper, _mywritedown);}
Debug.locals.put("myPV", _mypv);
Debug.locals.put("myRate", _myrate);
Debug.locals.put("myNPer", _mynper);
Debug.locals.put("myWritedown", _mywritedown);
 BA.debugLineNum = 67;BA.debugLine="Public Sub CompoundInterest(myPV As Double, myRate";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 70;BA.debugLine="Return (myPV*Power((1+(myRate/myWritedown)),(myNP";
Debug.JustUpdateDeviceLine();
if (true) return RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_mypv,financialfunctions.__c.runMethod(true,"Power",(Object)((RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),(RemoteObject.solve(new RemoteObject[] {_myrate,_mywritedown}, "/",0, 0))}, "+",1, 0))),(Object)((RemoteObject.solve(new RemoteObject[] {_mynper,_mywritedown}, "*",0, 0))))}, "*",0, 0)),_mypv}, "-",1, 0);
 BA.debugLineNum = 71;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _futurevalue(RemoteObject __ref,RemoteObject _myrate,RemoteObject _mynper,RemoteObject _mypmt,RemoteObject _mypv,RemoteObject _mydue) throws Exception{
try {
		Debug.PushSubsStack("FutureValue (financialfunctions) ","financialfunctions",10,__ref.getField(false, "ba"),__ref,17);
if (RapidSub.canDelegate("futurevalue")) { return __ref.runUserSub(false, "financialfunctions","futurevalue", __ref, _myrate, _mynper, _mypmt, _mypv, _mydue);}
RemoteObject _result = RemoteObject.createImmutable(0);
Debug.locals.put("myRate", _myrate);
Debug.locals.put("myNPer", _mynper);
Debug.locals.put("MyPmt", _mypmt);
Debug.locals.put("myPV", _mypv);
Debug.locals.put("myDue", _mydue);
 BA.debugLineNum = 17;BA.debugLine="Public Sub FutureValue(myRate As Double, myNPer As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 19;BA.debugLine="Dim result As Double = 0";
Debug.JustUpdateDeviceLine();
_result = BA.numberCast(double.class, 0);Debug.locals.put("result", _result);Debug.locals.put("result", _result);
 BA.debugLineNum = 20;BA.debugLine="If(myRate <> 0) Then";
Debug.JustUpdateDeviceLine();
if ((RemoteObject.solveBoolean("!",_myrate,BA.numberCast(double.class, 0)))) { 
 BA.debugLineNum = 21;BA.debugLine="result = -MyPmt * (1 + myRate * myDue) * ( (Powe";
Debug.JustUpdateDeviceLine();
_result = BA.numberCast(double.class, -_mypmt.<Double>get().doubleValue()*(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_myrate,_mydue}, "+*",1, 0)).<Double>get().doubleValue()*(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {financialfunctions.__c.runMethod(true,"Power",(Object)((RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_myrate}, "+",1, 0))),(Object)(_mynper)),RemoteObject.createImmutable(1)}, "-",1, 0)),_myrate}, "/",0, 0)).<Double>get().doubleValue()-_mypv.<Double>get().doubleValue()*financialfunctions.__c.runMethod(true,"Power",(Object)((RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_myrate}, "+",1, 0))),(Object)(_mynper)).<Double>get().doubleValue());Debug.locals.put("result", _result);
 }else {
 BA.debugLineNum = 23;BA.debugLine="result = -(MyPmt * myNPer) - myPV";
Debug.JustUpdateDeviceLine();
_result = BA.numberCast(double.class, -(RemoteObject.solve(new RemoteObject[] {_mypmt,_mynper}, "*",0, 0)).<Double>get().doubleValue()-_mypv.<Double>get().doubleValue());Debug.locals.put("result", _result);
 };
 BA.debugLineNum = 25;BA.debugLine="Return result";
Debug.JustUpdateDeviceLine();
if (true) return _result;
 BA.debugLineNum = 26;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("initialize (financialfunctions) ","financialfunctions",10,__ref.getField(false, "ba"),__ref,4);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "financialfunctions","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 4;BA.debugLine="public Sub initialize";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 6;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _netpresentvalue(RemoteObject __ref,RemoteObject _mypv,RemoteObject _myrate) throws Exception{
try {
		Debug.PushSubsStack("NetPresentValue (financialfunctions) ","financialfunctions",10,__ref.getField(false, "ba"),__ref,73);
if (RapidSub.canDelegate("netpresentvalue")) { return __ref.runUserSub(false, "financialfunctions","netpresentvalue", __ref, _mypv, _myrate);}
RemoteObject _myresult = RemoteObject.createImmutable(0);
RemoteObject _mycounter = RemoteObject.createImmutable(0);
RemoteObject _mynper = RemoteObject.createImmutable(0);
Debug.locals.put("myPV", _mypv);
Debug.locals.put("myRate", _myrate);
 BA.debugLineNum = 73;BA.debugLine="public Sub NetPresentValue(myPV() As Double, myRat";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 75;BA.debugLine="Private myResult As Double";
Debug.JustUpdateDeviceLine();
_myresult = RemoteObject.createImmutable(0);Debug.locals.put("myResult", _myresult);
 BA.debugLineNum = 76;BA.debugLine="Private myCounter As Double";
Debug.JustUpdateDeviceLine();
_mycounter = RemoteObject.createImmutable(0);Debug.locals.put("myCounter", _mycounter);
 BA.debugLineNum = 77;BA.debugLine="Private myNPer As Int = myPV.Length";
Debug.JustUpdateDeviceLine();
_mynper = _mypv.getField(true,"length");Debug.locals.put("myNPer", _mynper);Debug.locals.put("myNPer", _mynper);
 BA.debugLineNum = 79;BA.debugLine="If myPV.Length <> myRate.Length Then Return -9999";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("!",_mypv.getField(true,"length"),BA.numberCast(double.class, _myrate.getField(true,"length")))) { 
if (true) return BA.numberCast(double.class, -(double) (0 + 999999999));};
 BA.debugLineNum = 80;BA.debugLine="myResult = 0";
Debug.JustUpdateDeviceLine();
_myresult = BA.numberCast(double.class, 0);Debug.locals.put("myResult", _myresult);
 BA.debugLineNum = 81;BA.debugLine="For myCounter = 0 To myNPer - 1";
Debug.JustUpdateDeviceLine();
{
final double step6 = 1;
final double limit6 = (double) (0 + RemoteObject.solve(new RemoteObject[] {_mynper,RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue());
_mycounter = BA.numberCast(double.class, 0) ;
for (;(step6 > 0 && _mycounter.<Double>get().doubleValue() <= limit6) || (step6 < 0 && _mycounter.<Double>get().doubleValue() >= limit6) ;_mycounter = RemoteObject.createImmutable((double)(0 + _mycounter.<Double>get().doubleValue() + step6))  ) {
Debug.locals.put("myCounter", _mycounter);
 BA.debugLineNum = 82;BA.debugLine="myResult = myResult + (myPV(myCounter)/ Power((1";
Debug.JustUpdateDeviceLine();
_myresult = RemoteObject.solve(new RemoteObject[] {_myresult,(RemoteObject.solve(new RemoteObject[] {_mypv.getArrayElement(true,BA.numberCast(int.class, _mycounter)),financialfunctions.__c.runMethod(true,"Power",(Object)((RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_myrate.getArrayElement(true,BA.numberCast(int.class, _mycounter))}, "+",1, 0))),(Object)((RemoteObject.solve(new RemoteObject[] {_mycounter,RemoteObject.createImmutable(1)}, "+",1, 0))))}, "/",0, 0))}, "+",1, 0);Debug.locals.put("myResult", _myresult);
 }
}Debug.locals.put("myCounter", _mycounter);
;
 BA.debugLineNum = 84;BA.debugLine="Return myResult";
Debug.JustUpdateDeviceLine();
if (true) return _myresult;
 BA.debugLineNum = 85;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _numberperiods(RemoteObject __ref,RemoteObject _mypv,RemoteObject _mypmt,RemoteObject _myrate,RemoteObject _mywritedown) throws Exception{
try {
		Debug.PushSubsStack("NumberPeriods (financialfunctions) ","financialfunctions",10,__ref.getField(false, "ba"),__ref,87);
if (RapidSub.canDelegate("numberperiods")) { return __ref.runUserSub(false, "financialfunctions","numberperiods", __ref, _mypv, _mypmt, _myrate, _mywritedown);}
Debug.locals.put("myPV", _mypv);
Debug.locals.put("myPmt", _mypmt);
Debug.locals.put("myRate", _myrate);
Debug.locals.put("myWritedown", _mywritedown);
 BA.debugLineNum = 87;BA.debugLine="public Sub NumberPeriods(myPV As Double, myPmt As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 89;BA.debugLine="Return(-Logarithm(1-(((myRate/myWritedown)*myPV)/";
Debug.JustUpdateDeviceLine();
if (true) return BA.numberCast(double.class, (-financialfunctions.__c.runMethod(true,"Logarithm",(Object)(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_myrate,_mywritedown}, "/",0, 0)),_mypv}, "*",0, 0)),_mypmt}, "/",0, 0))}, "-",1, 0)),(Object)(BA.numberCast(double.class, 10))).<Double>get().doubleValue()/(double)(financialfunctions.__c.runMethod(true,"Logarithm",(Object)(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),(RemoteObject.solve(new RemoteObject[] {_myrate,_mywritedown}, "/",0, 0))}, "+",1, 0)),(Object)(BA.numberCast(double.class, 10)))).<Double>get().doubleValue()));
 BA.debugLineNum = 90;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _payment(RemoteObject __ref,RemoteObject _myrate,RemoteObject _mynper,RemoteObject _mypv,RemoteObject _myfv,RemoteObject _mydue) throws Exception{
try {
		Debug.PushSubsStack("Payment (financialfunctions) ","financialfunctions",10,__ref.getField(false, "ba"),__ref,38);
if (RapidSub.canDelegate("payment")) { return __ref.runUserSub(false, "financialfunctions","payment", __ref, _myrate, _mynper, _mypv, _myfv, _mydue);}
RemoteObject _pval = RemoteObject.createImmutable(0);
RemoteObject _fval = RemoteObject.createImmutable(0);
RemoteObject _totalfutureval = RemoteObject.createImmutable(0);
RemoteObject _geometricsum = RemoteObject.createImmutable(0);
RemoteObject _totalrate = RemoteObject.createImmutable(0);
RemoteObject _totalrate1 = RemoteObject.createImmutable(0);
Debug.locals.put("myRate", _myrate);
Debug.locals.put("myNPer", _mynper);
Debug.locals.put("MyPV", _mypv);
Debug.locals.put("MyFV", _myfv);
Debug.locals.put("myDue", _mydue);
 BA.debugLineNum = 38;BA.debugLine="Public  Sub Payment(myRate As Double, myNPer As Do";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 40;BA.debugLine="Dim PVal As Double = -MyPV";
Debug.JustUpdateDeviceLine();
_pval = BA.numberCast(double.class, -_mypv.<Double>get().doubleValue());Debug.locals.put("PVal", _pval);Debug.locals.put("PVal", _pval);
 BA.debugLineNum = 41;BA.debugLine="Dim FVal As Double = -MyFV";
Debug.JustUpdateDeviceLine();
_fval = BA.numberCast(double.class, -_myfv.<Double>get().doubleValue());Debug.locals.put("FVal", _fval);Debug.locals.put("FVal", _fval);
 BA.debugLineNum = 42;BA.debugLine="If (myNPer == 0) Then Return 0";
Debug.JustUpdateDeviceLine();
if ((RemoteObject.solveBoolean("=",_mynper,BA.numberCast(double.class, 0)))) { 
if (true) return BA.numberCast(double.class, 0);};
 BA.debugLineNum = 44;BA.debugLine="Dim totalFutureVal As Double = 0";
Debug.JustUpdateDeviceLine();
_totalfutureval = BA.numberCast(double.class, 0);Debug.locals.put("totalFutureVal", _totalfutureval);Debug.locals.put("totalFutureVal", _totalfutureval);
 BA.debugLineNum = 45;BA.debugLine="Dim geometricSum As Double = 0";
Debug.JustUpdateDeviceLine();
_geometricsum = BA.numberCast(double.class, 0);Debug.locals.put("geometricSum", _geometricsum);Debug.locals.put("geometricSum", _geometricsum);
 BA.debugLineNum = 47;BA.debugLine="If (myRate == 0) Then";
Debug.JustUpdateDeviceLine();
if ((RemoteObject.solveBoolean("=",_myrate,BA.numberCast(double.class, 0)))) { 
 BA.debugLineNum = 48;BA.debugLine="totalFutureVal = FVal + PVal";
Debug.JustUpdateDeviceLine();
_totalfutureval = RemoteObject.solve(new RemoteObject[] {_fval,_pval}, "+",1, 0);Debug.locals.put("totalFutureVal", _totalfutureval);
 BA.debugLineNum = 49;BA.debugLine="geometricSum = myNPer";
Debug.JustUpdateDeviceLine();
_geometricsum = _mynper;Debug.locals.put("geometricSum", _geometricsum);
 }else 
{ BA.debugLineNum = 50;BA.debugLine="else if (myDue == 0) Then";
Debug.JustUpdateDeviceLine();
if ((RemoteObject.solveBoolean("=",_mydue,BA.numberCast(double.class, 0)))) { 
 BA.debugLineNum = 51;BA.debugLine="Dim totalRate As Double = Power(myRate + 1, myNP";
Debug.JustUpdateDeviceLine();
_totalrate = financialfunctions.__c.runMethod(true,"Power",(Object)(RemoteObject.solve(new RemoteObject[] {_myrate,RemoteObject.createImmutable(1)}, "+",1, 0)),(Object)(_mynper));Debug.locals.put("totalRate", _totalrate);Debug.locals.put("totalRate", _totalrate);
 BA.debugLineNum = 52;BA.debugLine="totalFutureVal = FVal + PVal * totalRate";
Debug.JustUpdateDeviceLine();
_totalfutureval = RemoteObject.solve(new RemoteObject[] {_fval,_pval,_totalrate}, "+*",1, 0);Debug.locals.put("totalFutureVal", _totalfutureval);
 BA.debugLineNum = 53;BA.debugLine="geometricSum = (totalRate - 1) / myRate";
Debug.JustUpdateDeviceLine();
_geometricsum = RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_totalrate,RemoteObject.createImmutable(1)}, "-",1, 0)),_myrate}, "/",0, 0);Debug.locals.put("geometricSum", _geometricsum);
 }else 
{ BA.debugLineNum = 54;BA.debugLine="else if (myDue == 1) Then";
Debug.JustUpdateDeviceLine();
if ((RemoteObject.solveBoolean("=",_mydue,BA.numberCast(double.class, 1)))) { 
 BA.debugLineNum = 55;BA.debugLine="Dim totalRate1 As Double = Power(myRate + 1, myN";
Debug.JustUpdateDeviceLine();
_totalrate1 = financialfunctions.__c.runMethod(true,"Power",(Object)(RemoteObject.solve(new RemoteObject[] {_myrate,RemoteObject.createImmutable(1)}, "+",1, 0)),(Object)(_mynper));Debug.locals.put("totalRate1", _totalrate1);Debug.locals.put("totalRate1", _totalrate1);
 BA.debugLineNum = 56;BA.debugLine="totalFutureVal = FVal + PVal * totalRate1";
Debug.JustUpdateDeviceLine();
_totalfutureval = RemoteObject.solve(new RemoteObject[] {_fval,_pval,_totalrate1}, "+*",1, 0);Debug.locals.put("totalFutureVal", _totalfutureval);
 BA.debugLineNum = 57;BA.debugLine="geometricSum = ((1 + myRate) * (totalRate1 - 1))";
Debug.JustUpdateDeviceLine();
_geometricsum = RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_myrate}, "+",1, 0)),(RemoteObject.solve(new RemoteObject[] {_totalrate1,RemoteObject.createImmutable(1)}, "-",1, 0))}, "*",0, 0)),_myrate}, "/",0, 0);Debug.locals.put("geometricSum", _geometricsum);
 }}}
;
 BA.debugLineNum = 59;BA.debugLine="Return (totalFutureVal) / geometricSum";
Debug.JustUpdateDeviceLine();
if (true) return RemoteObject.solve(new RemoteObject[] {(_totalfutureval),_geometricsum}, "/",0, 0);
 BA.debugLineNum = 60;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _presentvalue(RemoteObject __ref,RemoteObject _myrate,RemoteObject _mynper,RemoteObject _mypmt,RemoteObject _myfv,RemoteObject _mydue) throws Exception{
try {
		Debug.PushSubsStack("PresentValue (financialfunctions) ","financialfunctions",10,__ref.getField(false, "ba"),__ref,8);
if (RapidSub.canDelegate("presentvalue")) { return __ref.runUserSub(false, "financialfunctions","presentvalue", __ref, _myrate, _mynper, _mypmt, _myfv, _mydue);}
RemoteObject _result = RemoteObject.createImmutable(0);
Debug.locals.put("myRate", _myrate);
Debug.locals.put("myNPer", _mynper);
Debug.locals.put("myPMT", _mypmt);
Debug.locals.put("myFV", _myfv);
Debug.locals.put("myDue", _mydue);
 BA.debugLineNum = 8;BA.debugLine="Public Sub PresentValue(myRate As Double, myNPer A";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 10;BA.debugLine="Dim result As Double = 0";
Debug.JustUpdateDeviceLine();
_result = BA.numberCast(double.class, 0);Debug.locals.put("result", _result);Debug.locals.put("result", _result);
 BA.debugLineNum = 11;BA.debugLine="result = result+ (myFV / (Power((1+(myRate/myDue)";
Debug.JustUpdateDeviceLine();
_result = RemoteObject.solve(new RemoteObject[] {_result,(RemoteObject.solve(new RemoteObject[] {_myfv,(financialfunctions.__c.runMethod(true,"Power",(Object)((RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),(RemoteObject.solve(new RemoteObject[] {_myrate,_mydue}, "/",0, 0))}, "+",1, 0))),(Object)((RemoteObject.solve(new RemoteObject[] {_mynper,_mydue}, "*",0, 0)))))}, "/",0, 0))}, "+",1, 0);Debug.locals.put("result", _result);
 BA.debugLineNum = 12;BA.debugLine="result = result + (myPMT * ( ( 1 - Power((1+myRat";
Debug.JustUpdateDeviceLine();
_result = RemoteObject.solve(new RemoteObject[] {_result,(RemoteObject.solve(new RemoteObject[] {_mypmt,(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),financialfunctions.__c.runMethod(true,"Power",(Object)((RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_myrate}, "+",1, 0))),(Object)(BA.numberCast(double.class, -_mynper.<Double>get().doubleValue())))}, "-",1, 0)),_myrate}, "/",0, 0))}, "*",0, 0))}, "+",1, 0);Debug.locals.put("result", _result);
 BA.debugLineNum = 13;BA.debugLine="Return result";
Debug.JustUpdateDeviceLine();
if (true) return _result;
 BA.debugLineNum = 14;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _rateofreturnannuity(RemoteObject __ref,RemoteObject _myfv,RemoteObject _mypv,RemoteObject _myterm) throws Exception{
try {
		Debug.PushSubsStack("RateOfReturnAnnuity (financialfunctions) ","financialfunctions",10,__ref.getField(false, "ba"),__ref,28);
if (RapidSub.canDelegate("rateofreturnannuity")) { return __ref.runUserSub(false, "financialfunctions","rateofreturnannuity", __ref, _myfv, _mypv, _myterm);}
Debug.locals.put("myFV", _myfv);
Debug.locals.put("myPV", _mypv);
Debug.locals.put("myTerm", _myterm);
 BA.debugLineNum = 28;BA.debugLine="public Sub RateOfReturnAnnuity(myFV As Double, myP";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 30;BA.debugLine="Return(Power((myFV/myPV),(1/myTerm)) - 1)";
Debug.JustUpdateDeviceLine();
if (true) return (RemoteObject.solve(new RemoteObject[] {financialfunctions.__c.runMethod(true,"Power",(Object)((RemoteObject.solve(new RemoteObject[] {_myfv,_mypv}, "/",0, 0))),(Object)((RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_myterm}, "/",0, 0)))),RemoteObject.createImmutable(1)}, "-",1, 0));
 BA.debugLineNum = 31;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _rateofreturnloan(RemoteObject __ref,RemoteObject _mypv,RemoteObject _mypmt,RemoteObject _myterm) throws Exception{
try {
		Debug.PushSubsStack("RateOfReturnLoan (financialfunctions) ","financialfunctions",10,__ref.getField(false, "ba"),__ref,33);
if (RapidSub.canDelegate("rateofreturnloan")) { return __ref.runUserSub(false, "financialfunctions","rateofreturnloan", __ref, _mypv, _mypmt, _myterm);}
Debug.locals.put("myPV", _mypv);
Debug.locals.put("myPmt", _mypmt);
Debug.locals.put("myTerm", _myterm);
 BA.debugLineNum = 33;BA.debugLine="public Sub RateOfReturnLoan(myPV As Double, myPmt";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 35;BA.debugLine="Return(Power(((myPmt*myTerm)/myPV),(1/myTerm)) -";
Debug.JustUpdateDeviceLine();
if (true) return (RemoteObject.solve(new RemoteObject[] {financialfunctions.__c.runMethod(true,"Power",(Object)((RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_mypmt,_myterm}, "*",0, 0)),_mypv}, "/",0, 0))),(Object)((RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),_myterm}, "/",0, 0)))),RemoteObject.createImmutable(1)}, "-",1, 0));
 BA.debugLineNum = 36;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _simpleinterest(RemoteObject __ref,RemoteObject _myprincipal,RemoteObject _myrate,RemoteObject _myterm) throws Exception{
try {
		Debug.PushSubsStack("SimpleInterest (financialfunctions) ","financialfunctions",10,__ref.getField(false, "ba"),__ref,62);
if (RapidSub.canDelegate("simpleinterest")) { return __ref.runUserSub(false, "financialfunctions","simpleinterest", __ref, _myprincipal, _myrate, _myterm);}
Debug.locals.put("myPrincipal", _myprincipal);
Debug.locals.put("myRate", _myrate);
Debug.locals.put("myTerm", _myterm);
 BA.debugLineNum = 62;BA.debugLine="public Sub SimpleInterest(myPrincipal As Double, m";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 64;BA.debugLine="Return(myPrincipal * myRate * myTerm)";
Debug.JustUpdateDeviceLine();
if (true) return (RemoteObject.solve(new RemoteObject[] {_myprincipal,_myrate,_myterm}, "**",0, 0));
 BA.debugLineNum = 65;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}