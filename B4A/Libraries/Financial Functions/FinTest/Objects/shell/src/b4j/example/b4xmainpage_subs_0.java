package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xmainpage_subs_0 {


public static RemoteObject  _b4xpage_created(RemoteObject __ref,RemoteObject _root1) throws Exception{
try {
		Debug.PushSubsStack("B4XPage_Created (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,47);
if (RapidSub.canDelegate("b4xpage_created")) { return __ref.runUserSub(false, "b4xmainpage","b4xpage_created", __ref, _root1);}
Debug.locals.put("Root1", _root1);
 BA.debugLineNum = 47;BA.debugLine="Private Sub B4XPage_Created (Root1 As B4XView)";
Debug.ShouldStop(16384);
 BA.debugLineNum = 48;BA.debugLine="Root = Root1";
Debug.ShouldStop(32768);
__ref.setField ("_root" /*RemoteObject*/ ,_root1);
 BA.debugLineNum = 49;BA.debugLine="Root.LoadLayout(\"MainPage\")";
Debug.ShouldStop(65536);
__ref.getField(false,"_root" /*RemoteObject*/ ).runVoidMethodAndSync ("LoadLayout",(Object)(RemoteObject.createImmutable("MainPage")),__ref.getField(false, "ba"));
 BA.debugLineNum = 50;BA.debugLine="ff.initialize";
Debug.ShouldStop(131072);
__ref.getField(false,"_ff" /*RemoteObject*/ ).runClassMethod (b4j.example.financialfunctions.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"));
 BA.debugLineNum = 51;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _button1_click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Button1_Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,97);
if (RapidSub.canDelegate("button1_click")) { return __ref.runUserSub(false, "b4xmainpage","button1_click", __ref);}
 BA.debugLineNum = 97;BA.debugLine="Private Sub Button1_Click";
Debug.ShouldStop(1);
 BA.debugLineNum = 98;BA.debugLine="ResetZeros";
Debug.ShouldStop(2);
__ref.runClassMethod (b4j.example.b4xmainpage.class, "_resetzeros" /*RemoteObject*/ );
 BA.debugLineNum = 99;BA.debugLine="lblResult.Text=(\"PresentValue: \" & NumberFormat(f";
Debug.ShouldStop(4);
__ref.getField(false,"_lblresult" /*RemoteObject*/ ).runMethod(true,"setText",(RemoteObject.concat(RemoteObject.createImmutable("PresentValue: "),b4xmainpage.__c.runMethod(true,"NumberFormat",(Object)(__ref.getField(false,"_ff" /*RemoteObject*/ ).runClassMethod (b4j.example.financialfunctions.class, "_presentvalue" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_rate" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_nper" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(BA.numberCast(double.class, -__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_pmt" /*RemoteObject*/ ).runMethod(true,"getText")))).<Double>get().doubleValue())),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_fv" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_writedown" /*RemoteObject*/ ).runMethod(true,"getText"))))))),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 2))))));
 BA.debugLineNum = 100;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _button2_click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Button2_Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,92);
if (RapidSub.canDelegate("button2_click")) { return __ref.runUserSub(false, "b4xmainpage","button2_click", __ref);}
 BA.debugLineNum = 92;BA.debugLine="Private Sub Button2_Click";
Debug.ShouldStop(134217728);
 BA.debugLineNum = 93;BA.debugLine="ResetZeros";
Debug.ShouldStop(268435456);
__ref.runClassMethod (b4j.example.b4xmainpage.class, "_resetzeros" /*RemoteObject*/ );
 BA.debugLineNum = 94;BA.debugLine="lblResult.Text=(\"FutureValue: \" & NumberFormat(ff";
Debug.ShouldStop(536870912);
__ref.getField(false,"_lblresult" /*RemoteObject*/ ).runMethod(true,"setText",(RemoteObject.concat(RemoteObject.createImmutable("FutureValue: "),b4xmainpage.__c.runMethod(true,"NumberFormat",(Object)(__ref.getField(false,"_ff" /*RemoteObject*/ ).runClassMethod (b4j.example.financialfunctions.class, "_futurevalue" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_rate" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_nper" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_pmt" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_pv" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_due" /*RemoteObject*/ ).runMethod(true,"getText"))))))),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 2))))));
 BA.debugLineNum = 95;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _button3_click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Button3_Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,82);
if (RapidSub.canDelegate("button3_click")) { return __ref.runUserSub(false, "b4xmainpage","button3_click", __ref);}
 BA.debugLineNum = 82;BA.debugLine="Private Sub Button3_Click";
Debug.ShouldStop(131072);
 BA.debugLineNum = 83;BA.debugLine="ResetZeros";
Debug.ShouldStop(262144);
__ref.runClassMethod (b4j.example.b4xmainpage.class, "_resetzeros" /*RemoteObject*/ );
 BA.debugLineNum = 84;BA.debugLine="lblResult.Text=(\"Annual Rate: \" & NumberFormat(ff";
Debug.ShouldStop(524288);
__ref.getField(false,"_lblresult" /*RemoteObject*/ ).runMethod(true,"setText",(RemoteObject.concat(RemoteObject.createImmutable("Annual Rate: "),b4xmainpage.__c.runMethod(true,"NumberFormat",(Object)(__ref.getField(false,"_ff" /*RemoteObject*/ ).runClassMethod (b4j.example.financialfunctions.class, "_rateofreturnannuity" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_fv" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_pv" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_nper" /*RemoteObject*/ ).runMethod(true,"getText"))))))),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 2))))));
 BA.debugLineNum = 85;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _button4_click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Button4_Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,77);
if (RapidSub.canDelegate("button4_click")) { return __ref.runUserSub(false, "b4xmainpage","button4_click", __ref);}
 BA.debugLineNum = 77;BA.debugLine="Private Sub Button4_Click";
Debug.ShouldStop(4096);
 BA.debugLineNum = 78;BA.debugLine="ResetZeros";
Debug.ShouldStop(8192);
__ref.runClassMethod (b4j.example.b4xmainpage.class, "_resetzeros" /*RemoteObject*/ );
 BA.debugLineNum = 79;BA.debugLine="lblResult.Text=(\"Payment: \" & NumberFormat(ff.Pay";
Debug.ShouldStop(16384);
__ref.getField(false,"_lblresult" /*RemoteObject*/ ).runMethod(true,"setText",(RemoteObject.concat(RemoteObject.createImmutable("Payment: "),b4xmainpage.__c.runMethod(true,"NumberFormat",(Object)(__ref.getField(false,"_ff" /*RemoteObject*/ ).runClassMethod (b4j.example.financialfunctions.class, "_payment" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_rate" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_nper" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_pv" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_fv" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_due" /*RemoteObject*/ ).runMethod(true,"getText"))))))),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 2))))));
 BA.debugLineNum = 80;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _button5_click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Button5_Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,72);
if (RapidSub.canDelegate("button5_click")) { return __ref.runUserSub(false, "b4xmainpage","button5_click", __ref);}
 BA.debugLineNum = 72;BA.debugLine="Private Sub Button5_Click";
Debug.ShouldStop(128);
 BA.debugLineNum = 73;BA.debugLine="ResetZeros";
Debug.ShouldStop(256);
__ref.runClassMethod (b4j.example.b4xmainpage.class, "_resetzeros" /*RemoteObject*/ );
 BA.debugLineNum = 74;BA.debugLine="lblResult.Text=(\"Simple Interest: \" & NumberForma";
Debug.ShouldStop(512);
__ref.getField(false,"_lblresult" /*RemoteObject*/ ).runMethod(true,"setText",(RemoteObject.concat(RemoteObject.createImmutable("Simple Interest: "),b4xmainpage.__c.runMethod(true,"NumberFormat",(Object)(__ref.getField(false,"_ff" /*RemoteObject*/ ).runClassMethod (b4j.example.financialfunctions.class, "_simpleinterest" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_pv" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_rate" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_nper" /*RemoteObject*/ ).runMethod(true,"getText"))))))),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 2))))));
 BA.debugLineNum = 75;BA.debugLine="End Sub";
Debug.ShouldStop(1024);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _button6_click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Button6_Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,67);
if (RapidSub.canDelegate("button6_click")) { return __ref.runUserSub(false, "b4xmainpage","button6_click", __ref);}
 BA.debugLineNum = 67;BA.debugLine="Private Sub Button6_Click";
Debug.ShouldStop(4);
 BA.debugLineNum = 68;BA.debugLine="ResetZeros";
Debug.ShouldStop(8);
__ref.runClassMethod (b4j.example.b4xmainpage.class, "_resetzeros" /*RemoteObject*/ );
 BA.debugLineNum = 69;BA.debugLine="lblResult.Text=(\"Compound Interest: \" & NumberFor";
Debug.ShouldStop(16);
__ref.getField(false,"_lblresult" /*RemoteObject*/ ).runMethod(true,"setText",(RemoteObject.concat(RemoteObject.createImmutable("Compound Interest: "),b4xmainpage.__c.runMethod(true,"NumberFormat",(Object)(__ref.getField(false,"_ff" /*RemoteObject*/ ).runClassMethod (b4j.example.financialfunctions.class, "_compoundinterest" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_pv" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_rate" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_nper" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(BA.numberCast(int.class, __ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_writedown" /*RemoteObject*/ ).runMethod(true,"getText")))))))),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 2))))));
 BA.debugLineNum = 70;BA.debugLine="End Sub";
Debug.ShouldStop(32);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _button7_click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Button7_Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,59);
if (RapidSub.canDelegate("button7_click")) { return __ref.runUserSub(false, "b4xmainpage","button7_click", __ref);}
RemoteObject _a = null;
RemoteObject _b = null;
 BA.debugLineNum = 59;BA.debugLine="Private Sub Button7_Click";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 60;BA.debugLine="Dim a() As Double";
Debug.ShouldStop(134217728);
_a = RemoteObject.createNewArray ("double", new int[] {0}, new Object[]{});Debug.locals.put("a", _a);
 BA.debugLineNum = 61;BA.debugLine="Dim b() As Double";
Debug.ShouldStop(268435456);
_b = RemoteObject.createNewArray ("double", new int[] {0}, new Object[]{});Debug.locals.put("b", _b);
 BA.debugLineNum = 62;BA.debugLine="a = Array As Double (CDo(NPVAmt1.Text), CDo(NPVAm";
Debug.ShouldStop(536870912);
_a = RemoteObject.createNewArray("double",new int[] {3},new Object[] {__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_npvamt1" /*RemoteObject*/ ).runMethod(true,"getText")))),__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_npvamt2" /*RemoteObject*/ ).runMethod(true,"getText")))),__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_npvamt3" /*RemoteObject*/ ).runMethod(true,"getText"))))});Debug.locals.put("a", _a);
 BA.debugLineNum = 63;BA.debugLine="b = Array As Double (CDo(NPVRate1.Text), CDo(NPVR";
Debug.ShouldStop(1073741824);
_b = RemoteObject.createNewArray("double",new int[] {3},new Object[] {__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_npvrate1" /*RemoteObject*/ ).runMethod(true,"getText")))),__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_npvrate2" /*RemoteObject*/ ).runMethod(true,"getText")))),__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_npvrate3" /*RemoteObject*/ ).runMethod(true,"getText"))))});Debug.locals.put("b", _b);
 BA.debugLineNum = 64;BA.debugLine="lbNPVlResult.Text = (\"NPV: \" & NumberFormat(ff.Ne";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_lbnpvlresult" /*RemoteObject*/ ).runMethod(true,"setText",(RemoteObject.concat(RemoteObject.createImmutable("NPV: "),b4xmainpage.__c.runMethod(true,"NumberFormat",(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_ff" /*RemoteObject*/ ).runClassMethod (b4j.example.financialfunctions.class, "_netpresentvalue" /*RemoteObject*/ ,(Object)(_a),(Object)(_b)),__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_projectcost" /*RemoteObject*/ ).runMethod(true,"getText"))))}, "-",1, 0)),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 2))))));
 BA.debugLineNum = 65;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _button8_click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Button8_Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,55);
if (RapidSub.canDelegate("button8_click")) { return __ref.runUserSub(false, "b4xmainpage","button8_click", __ref);}
 BA.debugLineNum = 55;BA.debugLine="Private Sub Button8_Click";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 56;BA.debugLine="lblResult.Text=(\"NPER: \" & NumberFormat(ff.Number";
Debug.ShouldStop(8388608);
__ref.getField(false,"_lblresult" /*RemoteObject*/ ).runMethod(true,"setText",(RemoteObject.concat(RemoteObject.createImmutable("NPER: "),b4xmainpage.__c.runMethod(true,"NumberFormat",(Object)(__ref.getField(false,"_ff" /*RemoteObject*/ ).runClassMethod (b4j.example.financialfunctions.class, "_numberperiods" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_pv" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_pmt" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_rate" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_writedown" /*RemoteObject*/ ).runMethod(true,"getText"))))))),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 2))))));
 BA.debugLineNum = 57;BA.debugLine="End Sub";
Debug.ShouldStop(16777216);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _button9_click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Button9_Click (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,87);
if (RapidSub.canDelegate("button9_click")) { return __ref.runUserSub(false, "b4xmainpage","button9_click", __ref);}
 BA.debugLineNum = 87;BA.debugLine="Private Sub Button9_Click";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 88;BA.debugLine="ResetZeros";
Debug.ShouldStop(8388608);
__ref.runClassMethod (b4j.example.b4xmainpage.class, "_resetzeros" /*RemoteObject*/ );
 BA.debugLineNum = 89;BA.debugLine="lblResult.Text=(\"Rate: \" & NumberFormat(ff.RateOf";
Debug.ShouldStop(16777216);
__ref.getField(false,"_lblresult" /*RemoteObject*/ ).runMethod(true,"setText",(RemoteObject.concat(RemoteObject.createImmutable("Rate: "),b4xmainpage.__c.runMethod(true,"NumberFormat",(Object)(__ref.getField(false,"_ff" /*RemoteObject*/ ).runClassMethod (b4j.example.financialfunctions.class, "_rateofreturnloan" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_pv" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_pmt" /*RemoteObject*/ ).runMethod(true,"getText"))))),(Object)(__ref.runClassMethod (b4j.example.b4xmainpage.class, "_cdo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_nper" /*RemoteObject*/ ).runMethod(true,"getText"))))))),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 2))))));
 BA.debugLineNum = 90;BA.debugLine="End Sub";
Debug.ShouldStop(33554432);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _cdo(RemoteObject __ref,RemoteObject _o) throws Exception{
try {
		Debug.PushSubsStack("CDo (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,103);
if (RapidSub.canDelegate("cdo")) { return __ref.runUserSub(false, "b4xmainpage","cdo", __ref, _o);}
RemoteObject _d = RemoteObject.createImmutable(0);
Debug.locals.put("o", _o);
 BA.debugLineNum = 103;BA.debugLine="Sub CDo(o As Object) As Double";
Debug.ShouldStop(64);
 BA.debugLineNum = 104;BA.debugLine="Dim d As Double";
Debug.ShouldStop(128);
_d = RemoteObject.createImmutable(0);Debug.locals.put("d", _d);
 BA.debugLineNum = 105;BA.debugLine="d = o";
Debug.ShouldStop(256);
_d = BA.numberCast(double.class, _o);Debug.locals.put("d", _d);
 BA.debugLineNum = 106;BA.debugLine="Return d";
Debug.ShouldStop(512);
if (true) return _d;
 BA.debugLineNum = 107;BA.debugLine="End Sub";
Debug.ShouldStop(1024);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 8;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 9;BA.debugLine="Private Root As B4XView";
b4xmainpage._root = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_root",b4xmainpage._root);
 //BA.debugLineNum = 10;BA.debugLine="Private xui As XUI";
b4xmainpage._xui = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");__ref.setField("_xui",b4xmainpage._xui);
 //BA.debugLineNum = 12;BA.debugLine="Private Button1 As Button";
b4xmainpage._button1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");__ref.setField("_button1",b4xmainpage._button1);
 //BA.debugLineNum = 13;BA.debugLine="Private Button2 As Button";
b4xmainpage._button2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");__ref.setField("_button2",b4xmainpage._button2);
 //BA.debugLineNum = 14;BA.debugLine="Private Button3 As Button";
b4xmainpage._button3 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");__ref.setField("_button3",b4xmainpage._button3);
 //BA.debugLineNum = 15;BA.debugLine="Private Button4 As Button";
b4xmainpage._button4 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");__ref.setField("_button4",b4xmainpage._button4);
 //BA.debugLineNum = 16;BA.debugLine="Private Button5 As Button";
b4xmainpage._button5 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");__ref.setField("_button5",b4xmainpage._button5);
 //BA.debugLineNum = 17;BA.debugLine="Private Button6 As Button";
b4xmainpage._button6 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");__ref.setField("_button6",b4xmainpage._button6);
 //BA.debugLineNum = 18;BA.debugLine="Private Button7 As Button";
b4xmainpage._button7 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");__ref.setField("_button7",b4xmainpage._button7);
 //BA.debugLineNum = 19;BA.debugLine="Private Button8 As Button";
b4xmainpage._button8 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");__ref.setField("_button8",b4xmainpage._button8);
 //BA.debugLineNum = 20;BA.debugLine="Private FV As TextField";
b4xmainpage._fv = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");__ref.setField("_fv",b4xmainpage._fv);
 //BA.debugLineNum = 21;BA.debugLine="Private NPer As TextField";
b4xmainpage._nper = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");__ref.setField("_nper",b4xmainpage._nper);
 //BA.debugLineNum = 22;BA.debugLine="Private Pmt As TextField";
b4xmainpage._pmt = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");__ref.setField("_pmt",b4xmainpage._pmt);
 //BA.debugLineNum = 23;BA.debugLine="Private PV As TextField";
b4xmainpage._pv = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");__ref.setField("_pv",b4xmainpage._pv);
 //BA.debugLineNum = 24;BA.debugLine="Private Rate As TextField";
b4xmainpage._rate = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");__ref.setField("_rate",b4xmainpage._rate);
 //BA.debugLineNum = 25;BA.debugLine="Private Due As TextField";
b4xmainpage._due = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");__ref.setField("_due",b4xmainpage._due);
 //BA.debugLineNum = 26;BA.debugLine="Private Writedown As TextField";
b4xmainpage._writedown = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");__ref.setField("_writedown",b4xmainpage._writedown);
 //BA.debugLineNum = 27;BA.debugLine="Dim ff As FinancialFunctions";
b4xmainpage._ff = RemoteObject.createNew ("b4j.example.financialfunctions");__ref.setField("_ff",b4xmainpage._ff);
 //BA.debugLineNum = 29;BA.debugLine="Private lblResult As Label";
b4xmainpage._lblresult = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");__ref.setField("_lblresult",b4xmainpage._lblresult);
 //BA.debugLineNum = 30;BA.debugLine="Private NPVAmt1 As TextField";
b4xmainpage._npvamt1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");__ref.setField("_npvamt1",b4xmainpage._npvamt1);
 //BA.debugLineNum = 31;BA.debugLine="Private NPVAmt2 As TextField";
b4xmainpage._npvamt2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");__ref.setField("_npvamt2",b4xmainpage._npvamt2);
 //BA.debugLineNum = 32;BA.debugLine="Private NPVAmt3 As TextField";
b4xmainpage._npvamt3 = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");__ref.setField("_npvamt3",b4xmainpage._npvamt3);
 //BA.debugLineNum = 33;BA.debugLine="Private NPVRate1 As TextField";
b4xmainpage._npvrate1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");__ref.setField("_npvrate1",b4xmainpage._npvrate1);
 //BA.debugLineNum = 34;BA.debugLine="Private NPVRate2 As TextField";
b4xmainpage._npvrate2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");__ref.setField("_npvrate2",b4xmainpage._npvrate2);
 //BA.debugLineNum = 35;BA.debugLine="Private NPVRate3 As TextField";
b4xmainpage._npvrate3 = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");__ref.setField("_npvrate3",b4xmainpage._npvrate3);
 //BA.debugLineNum = 36;BA.debugLine="Private lbNPVlResult As Label";
b4xmainpage._lbnpvlresult = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");__ref.setField("_lbnpvlresult",b4xmainpage._lbnpvlresult);
 //BA.debugLineNum = 37;BA.debugLine="Private ProjectCost As TextField";
b4xmainpage._projectcost = RemoteObject.createNew ("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");__ref.setField("_projectcost",b4xmainpage._projectcost);
 //BA.debugLineNum = 39;BA.debugLine="Private Button9 As Button";
b4xmainpage._button9 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");__ref.setField("_button9",b4xmainpage._button9);
 //BA.debugLineNum = 40;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,42);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "b4xmainpage","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 42;BA.debugLine="Public Sub Initialize";
Debug.ShouldStop(512);
 BA.debugLineNum = 44;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _resetzeros(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("ResetZeros (b4xmainpage) ","b4xmainpage",1,__ref.getField(false, "ba"),__ref,109);
if (RapidSub.canDelegate("resetzeros")) { return __ref.runUserSub(false, "b4xmainpage","resetzeros", __ref);}
 BA.debugLineNum = 109;BA.debugLine="Sub ResetZeros";
Debug.ShouldStop(4096);
 BA.debugLineNum = 110;BA.debugLine="If IsNumber(PV.Text)=False Then PV.Text = 0";
Debug.ShouldStop(8192);
if (RemoteObject.solveBoolean("=",b4xmainpage.__c.runMethod(true,"IsNumber",(Object)(__ref.getField(false,"_pv" /*RemoteObject*/ ).runMethod(true,"getText"))),b4xmainpage.__c.getField(true,"False"))) { 
__ref.getField(false,"_pv" /*RemoteObject*/ ).runMethod(true,"setText",BA.NumberToString(0));};
 BA.debugLineNum = 111;BA.debugLine="If IsNumber(Rate.Text)=False Then Rate.Text = 0";
Debug.ShouldStop(16384);
if (RemoteObject.solveBoolean("=",b4xmainpage.__c.runMethod(true,"IsNumber",(Object)(__ref.getField(false,"_rate" /*RemoteObject*/ ).runMethod(true,"getText"))),b4xmainpage.__c.getField(true,"False"))) { 
__ref.getField(false,"_rate" /*RemoteObject*/ ).runMethod(true,"setText",BA.NumberToString(0));};
 BA.debugLineNum = 112;BA.debugLine="If IsNumber(NPer.Text)=False Then NPer.Text = 0";
Debug.ShouldStop(32768);
if (RemoteObject.solveBoolean("=",b4xmainpage.__c.runMethod(true,"IsNumber",(Object)(__ref.getField(false,"_nper" /*RemoteObject*/ ).runMethod(true,"getText"))),b4xmainpage.__c.getField(true,"False"))) { 
__ref.getField(false,"_nper" /*RemoteObject*/ ).runMethod(true,"setText",BA.NumberToString(0));};
 BA.debugLineNum = 113;BA.debugLine="If IsNumber(Pmt.Text)=False Then Pmt.Text = 0";
Debug.ShouldStop(65536);
if (RemoteObject.solveBoolean("=",b4xmainpage.__c.runMethod(true,"IsNumber",(Object)(__ref.getField(false,"_pmt" /*RemoteObject*/ ).runMethod(true,"getText"))),b4xmainpage.__c.getField(true,"False"))) { 
__ref.getField(false,"_pmt" /*RemoteObject*/ ).runMethod(true,"setText",BA.NumberToString(0));};
 BA.debugLineNum = 114;BA.debugLine="If IsNumber(FV.Text)=False Then FV.Text = 0";
Debug.ShouldStop(131072);
if (RemoteObject.solveBoolean("=",b4xmainpage.__c.runMethod(true,"IsNumber",(Object)(__ref.getField(false,"_fv" /*RemoteObject*/ ).runMethod(true,"getText"))),b4xmainpage.__c.getField(true,"False"))) { 
__ref.getField(false,"_fv" /*RemoteObject*/ ).runMethod(true,"setText",BA.NumberToString(0));};
 BA.debugLineNum = 115;BA.debugLine="If IsNumber(Due.Text)=False Then Due.Text = 0";
Debug.ShouldStop(262144);
if (RemoteObject.solveBoolean("=",b4xmainpage.__c.runMethod(true,"IsNumber",(Object)(__ref.getField(false,"_due" /*RemoteObject*/ ).runMethod(true,"getText"))),b4xmainpage.__c.getField(true,"False"))) { 
__ref.getField(false,"_due" /*RemoteObject*/ ).runMethod(true,"setText",BA.NumberToString(0));};
 BA.debugLineNum = 116;BA.debugLine="If IsNumber(Writedown.Text)=False Then Writedown.";
Debug.ShouldStop(524288);
if (RemoteObject.solveBoolean("=",b4xmainpage.__c.runMethod(true,"IsNumber",(Object)(__ref.getField(false,"_writedown" /*RemoteObject*/ ).runMethod(true,"getText"))),b4xmainpage.__c.getField(true,"False"))) { 
__ref.getField(false,"_writedown" /*RemoteObject*/ ).runMethod(true,"setText",BA.NumberToString(0));};
 BA.debugLineNum = 117;BA.debugLine="If IsNumber(NPVAmt1.Text)=False Then NPVAmt1.Text";
Debug.ShouldStop(1048576);
if (RemoteObject.solveBoolean("=",b4xmainpage.__c.runMethod(true,"IsNumber",(Object)(__ref.getField(false,"_npvamt1" /*RemoteObject*/ ).runMethod(true,"getText"))),b4xmainpage.__c.getField(true,"False"))) { 
__ref.getField(false,"_npvamt1" /*RemoteObject*/ ).runMethod(true,"setText",BA.NumberToString(0));};
 BA.debugLineNum = 118;BA.debugLine="If IsNumber(NPVAmt2.Text)=False Then NPVAmt2.Text";
Debug.ShouldStop(2097152);
if (RemoteObject.solveBoolean("=",b4xmainpage.__c.runMethod(true,"IsNumber",(Object)(__ref.getField(false,"_npvamt2" /*RemoteObject*/ ).runMethod(true,"getText"))),b4xmainpage.__c.getField(true,"False"))) { 
__ref.getField(false,"_npvamt2" /*RemoteObject*/ ).runMethod(true,"setText",BA.NumberToString(0));};
 BA.debugLineNum = 119;BA.debugLine="If IsNumber(NPVAmt3.Text)=False Then NPVAmt3.Text";
Debug.ShouldStop(4194304);
if (RemoteObject.solveBoolean("=",b4xmainpage.__c.runMethod(true,"IsNumber",(Object)(__ref.getField(false,"_npvamt3" /*RemoteObject*/ ).runMethod(true,"getText"))),b4xmainpage.__c.getField(true,"False"))) { 
__ref.getField(false,"_npvamt3" /*RemoteObject*/ ).runMethod(true,"setText",BA.NumberToString(0));};
 BA.debugLineNum = 120;BA.debugLine="If IsNumber(NPVRate1.Text)=False Then NPVRate1.Te";
Debug.ShouldStop(8388608);
if (RemoteObject.solveBoolean("=",b4xmainpage.__c.runMethod(true,"IsNumber",(Object)(__ref.getField(false,"_npvrate1" /*RemoteObject*/ ).runMethod(true,"getText"))),b4xmainpage.__c.getField(true,"False"))) { 
__ref.getField(false,"_npvrate1" /*RemoteObject*/ ).runMethod(true,"setText",BA.NumberToString(0));};
 BA.debugLineNum = 121;BA.debugLine="If IsNumber(NPVRate2.Text)=False Then NPVRate2.Te";
Debug.ShouldStop(16777216);
if (RemoteObject.solveBoolean("=",b4xmainpage.__c.runMethod(true,"IsNumber",(Object)(__ref.getField(false,"_npvrate2" /*RemoteObject*/ ).runMethod(true,"getText"))),b4xmainpage.__c.getField(true,"False"))) { 
__ref.getField(false,"_npvrate2" /*RemoteObject*/ ).runMethod(true,"setText",BA.NumberToString(0));};
 BA.debugLineNum = 122;BA.debugLine="If IsNumber(NPVRate3.Text)=False Then ProjectCost";
Debug.ShouldStop(33554432);
if (RemoteObject.solveBoolean("=",b4xmainpage.__c.runMethod(true,"IsNumber",(Object)(__ref.getField(false,"_npvrate3" /*RemoteObject*/ ).runMethod(true,"getText"))),b4xmainpage.__c.getField(true,"False"))) { 
__ref.getField(false,"_projectcost" /*RemoteObject*/ ).runMethod(true,"setText",BA.NumberToString(0));};
 BA.debugLineNum = 123;BA.debugLine="End Sub";
Debug.ShouldStop(67108864);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}