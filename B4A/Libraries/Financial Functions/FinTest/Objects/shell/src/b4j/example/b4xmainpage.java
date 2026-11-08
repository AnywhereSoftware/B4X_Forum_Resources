
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class b4xmainpage {
    public static RemoteObject myClass;
	public b4xmainpage() {
	}
    public static PCBA staticBA = new PCBA(null, b4xmainpage.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _root = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _xui = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");
public static RemoteObject _button1 = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
public static RemoteObject _button2 = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
public static RemoteObject _button3 = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
public static RemoteObject _button4 = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
public static RemoteObject _button5 = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
public static RemoteObject _button6 = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
public static RemoteObject _button7 = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
public static RemoteObject _button8 = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
public static RemoteObject _fv = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
public static RemoteObject _nper = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
public static RemoteObject _pmt = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
public static RemoteObject _pv = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
public static RemoteObject _rate = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
public static RemoteObject _due = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
public static RemoteObject _writedown = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
public static RemoteObject _ff = RemoteObject.declareNull("b4j.example.financialfunctions");
public static RemoteObject _lblresult = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
public static RemoteObject _npvamt1 = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
public static RemoteObject _npvamt2 = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
public static RemoteObject _npvamt3 = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
public static RemoteObject _npvrate1 = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
public static RemoteObject _npvrate2 = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
public static RemoteObject _npvrate3 = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
public static RemoteObject _lbnpvlresult = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
public static RemoteObject _projectcost = RemoteObject.declareNull("anywheresoftware.b4j.objects.TextInputControlWrapper.TextFieldWrapper");
public static RemoteObject _button9 = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
public static b4j.example.main _main = null;
public static b4j.example.b4xpages _b4xpages = null;
public static b4j.example.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"Button1",_ref.getField(false, "_button1"),"Button2",_ref.getField(false, "_button2"),"Button3",_ref.getField(false, "_button3"),"Button4",_ref.getField(false, "_button4"),"Button5",_ref.getField(false, "_button5"),"Button6",_ref.getField(false, "_button6"),"Button7",_ref.getField(false, "_button7"),"Button8",_ref.getField(false, "_button8"),"Button9",_ref.getField(false, "_button9"),"Due",_ref.getField(false, "_due"),"ff",_ref.getField(false, "_ff"),"FV",_ref.getField(false, "_fv"),"lblResult",_ref.getField(false, "_lblresult"),"lbNPVlResult",_ref.getField(false, "_lbnpvlresult"),"NPer",_ref.getField(false, "_nper"),"NPVAmt1",_ref.getField(false, "_npvamt1"),"NPVAmt2",_ref.getField(false, "_npvamt2"),"NPVAmt3",_ref.getField(false, "_npvamt3"),"NPVRate1",_ref.getField(false, "_npvrate1"),"NPVRate2",_ref.getField(false, "_npvrate2"),"NPVRate3",_ref.getField(false, "_npvrate3"),"Pmt",_ref.getField(false, "_pmt"),"ProjectCost",_ref.getField(false, "_projectcost"),"PV",_ref.getField(false, "_pv"),"Rate",_ref.getField(false, "_rate"),"Root",_ref.getField(false, "_root"),"Writedown",_ref.getField(false, "_writedown"),"xui",_ref.getField(false, "_xui")};
}
}