package b4a.TimezoneMapper;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _activity_create(RemoteObject _firsttime) throws Exception{
try {
		Debug.PushSubsStack("Activity_Create (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,38);
if (RapidSub.canDelegate("activity_create")) { return b4a.TimezoneMapper.main.remoteMe.runUserSub(false, "main","activity_create", _firsttime);}
Debug.locals.put("FirstTime", _firsttime);
 BA.debugLineNum = 38;BA.debugLine="Sub Activity_Create(FirstTime As Boolean)";
Debug.ShouldStop(32);
 BA.debugLineNum = 40;BA.debugLine="Activity.LoadLayout(\"Layout\")";
Debug.ShouldStop(128);
main.mostCurrent._activity.runMethodAndSync(false,"LoadLayout",(Object)(RemoteObject.createImmutable("Layout")),main.mostCurrent.activityBA);
 BA.debugLineNum = 42;BA.debugLine="oTimezoneMapper.InitializeStatic(\"b4a.TimezoneMap";
Debug.ShouldStop(512);
main.mostCurrent._otimezonemapper.runVoidMethod ("InitializeStatic",(Object)(RemoteObject.createImmutable("b4a.TimezoneMapper.main.TimezoneMapper")));
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
public static RemoteObject  _activity_pause(RemoteObject _userclosed) throws Exception{
try {
		Debug.PushSubsStack("Activity_Pause (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,52);
if (RapidSub.canDelegate("activity_pause")) { return b4a.TimezoneMapper.main.remoteMe.runUserSub(false, "main","activity_pause", _userclosed);}
Debug.locals.put("UserClosed", _userclosed);
 BA.debugLineNum = 52;BA.debugLine="Sub Activity_Pause (UserClosed As Boolean)";
Debug.ShouldStop(524288);
 BA.debugLineNum = 54;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _activity_resume() throws Exception{
try {
		Debug.PushSubsStack("Activity_Resume (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,47);
if (RapidSub.canDelegate("activity_resume")) { return b4a.TimezoneMapper.main.remoteMe.runUserSub(false, "main","activity_resume");}
 BA.debugLineNum = 47;BA.debugLine="Sub Activity_Resume";
Debug.ShouldStop(16384);
 BA.debugLineNum = 49;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _button1_click() throws Exception{
try {
		Debug.PushSubsStack("Button1_Click (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,57);
if (RapidSub.canDelegate("button1_click")) { return b4a.TimezoneMapper.main.remoteMe.runUserSub(false, "main","button1_click");}
RemoteObject _llat = RemoteObject.createImmutable(0);
RemoteObject _llong = RemoteObject.createImmutable(0);
RemoteObject _timezone_name = RemoteObject.createImmutable("");
RemoteObject _timezone_abbreviation = RemoteObject.createImmutable("");
RemoteObject _timezone_daylightsaving = RemoteObject.createImmutable(false);
RemoteObject _result = RemoteObject.createImmutable("");
 BA.debugLineNum = 57;BA.debugLine="Sub Button1_Click";
Debug.ShouldStop(16777216);
 BA.debugLineNum = 59;BA.debugLine="Try";
Debug.ShouldStop(67108864);
try { BA.debugLineNum = 61;BA.debugLine="If IsNumber(TextField1.Text.Trim) = False Then R";
Debug.ShouldStop(268435456);
if (RemoteObject.solveBoolean("=",main.mostCurrent.__c.runMethod(true,"IsNumber",(Object)(main.mostCurrent._textfield1.runMethod(true,"getText").runMethod(true,"trim"))),main.mostCurrent.__c.getField(true,"False"))) { 
Debug.CheckDeviceExceptions();if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 62;BA.debugLine="If IsNumber(TextField2.Text.Trim) = False Then R";
Debug.ShouldStop(536870912);
if (RemoteObject.solveBoolean("=",main.mostCurrent.__c.runMethod(true,"IsNumber",(Object)(main.mostCurrent._textfield2.runMethod(true,"getText").runMethod(true,"trim"))),main.mostCurrent.__c.getField(true,"False"))) { 
Debug.CheckDeviceExceptions();if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 64;BA.debugLine="Dim lLat As Double = TextField1.Text.Trim.As(Dou";
Debug.ShouldStop(-2147483648);
_llat = (BA.numberCast(double.class, main.mostCurrent._textfield1.runMethod(true,"getText").runMethod(true,"trim")));Debug.locals.put("lLat", _llat);Debug.locals.put("lLat", _llat);
 BA.debugLineNum = 65;BA.debugLine="Dim lLong As Double = TextField2.Text.Trim.As(Do";
Debug.ShouldStop(1);
_llong = (BA.numberCast(double.class, main.mostCurrent._textfield2.runMethod(true,"getText").runMethod(true,"trim")));Debug.locals.put("lLong", _llong);Debug.locals.put("lLong", _llong);
 BA.debugLineNum = 67;BA.debugLine="Dim TimeZone_Name As String";
Debug.ShouldStop(4);
_timezone_name = RemoteObject.createImmutable("");Debug.locals.put("TimeZone_Name", _timezone_name);
 BA.debugLineNum = 68;BA.debugLine="Dim TimeZone_Abbreviation As String";
Debug.ShouldStop(8);
_timezone_abbreviation = RemoteObject.createImmutable("");Debug.locals.put("TimeZone_Abbreviation", _timezone_abbreviation);
 BA.debugLineNum = 69;BA.debugLine="Dim TimeZone_DaylightSaving As Boolean";
Debug.ShouldStop(16);
_timezone_daylightsaving = RemoteObject.createImmutable(false);Debug.locals.put("TimeZone_DaylightSaving", _timezone_daylightsaving);
 BA.debugLineNum = 70;BA.debugLine="Dim Result As String";
Debug.ShouldStop(32);
_result = RemoteObject.createImmutable("");Debug.locals.put("Result", _result);
 BA.debugLineNum = 72;BA.debugLine="TimeZone_Name = GetTimeZoneNameFromLatLong(lLat,";
Debug.ShouldStop(128);
_timezone_name = _gettimezonenamefromlatlong(_llat,_llong).runMethod(true,"trim");Debug.locals.put("TimeZone_Name", _timezone_name);
 BA.debugLineNum = 73;BA.debugLine="TimeZone_Abbreviation = GetAbbreviation(TimeZone";
Debug.ShouldStop(256);
_timezone_abbreviation = _getabbreviation(_timezone_name);Debug.locals.put("TimeZone_Abbreviation", _timezone_abbreviation);
 BA.debugLineNum = 74;BA.debugLine="TimeZone_DaylightSaving = GetDaylightSaving(Time";
Debug.ShouldStop(512);
_timezone_daylightsaving = _getdaylightsaving(_timezone_name);Debug.locals.put("TimeZone_DaylightSaving", _timezone_daylightsaving);
 BA.debugLineNum = 76;BA.debugLine="Result = \"Name = \" & TimeZone_Name.Trim";
Debug.ShouldStop(2048);
_result = RemoteObject.concat(RemoteObject.createImmutable("Name = "),_timezone_name.runMethod(true,"trim"));Debug.locals.put("Result", _result);
 BA.debugLineNum = 77;BA.debugLine="Result = Result & CRLF & \"Abbreviation = \" & Tim";
Debug.ShouldStop(4096);
_result = RemoteObject.concat(_result,main.mostCurrent.__c.getField(true,"CRLF"),RemoteObject.createImmutable("Abbreviation = "),_timezone_abbreviation.runMethod(true,"trim"));Debug.locals.put("Result", _result);
 BA.debugLineNum = 78;BA.debugLine="Result = Result & CRLF & \"DaylightSaving = \" & T";
Debug.ShouldStop(8192);
_result = RemoteObject.concat(_result,main.mostCurrent.__c.getField(true,"CRLF"),RemoteObject.createImmutable("DaylightSaving = "),_timezone_daylightsaving);Debug.locals.put("Result", _result);
 BA.debugLineNum = 80;BA.debugLine="Label3.Text = Result.Trim";
Debug.ShouldStop(32768);
main.mostCurrent._label3.runMethod(true,"setText",BA.ObjectToCharSequence(_result.runMethod(true,"trim")));
 BA.debugLineNum = 82;BA.debugLine="MsgboxAsync(\"OK\",\"Note\")";
Debug.ShouldStop(131072);
main.mostCurrent.__c.runVoidMethod ("MsgboxAsync",(Object)(BA.ObjectToCharSequence("OK")),(Object)(BA.ObjectToCharSequence(RemoteObject.createImmutable("Note"))),main.processBA);
 BA.debugLineNum = 84;BA.debugLine="Return";
Debug.ShouldStop(524288);
Debug.CheckDeviceExceptions();if (true) return RemoteObject.createImmutable("");
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e20) {
			BA.rdebugUtils.runVoidMethod("setLastException",main.processBA, e20.toString()); BA.debugLineNum = 90;BA.debugLine="MsgboxAsync(LastException.Message,\"Error\")";
Debug.ShouldStop(33554432);
main.mostCurrent.__c.runVoidMethod ("MsgboxAsync",(Object)(BA.ObjectToCharSequence(main.mostCurrent.__c.runMethod(false,"LastException",main.mostCurrent.activityBA).runMethod(true,"getMessage"))),(Object)(BA.ObjectToCharSequence(RemoteObject.createImmutable("Error"))),main.processBA);
 BA.debugLineNum = 92;BA.debugLine="Return";
Debug.ShouldStop(134217728);
if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 96;BA.debugLine="End Sub";
Debug.ShouldStop(-2147483648);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getabbreviation(RemoteObject _ntimezonename) throws Exception{
try {
		Debug.PushSubsStack("GetAbbreviation (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,116);
if (RapidSub.canDelegate("getabbreviation")) { return b4a.TimezoneMapper.main.remoteMe.runUserSub(false, "main","getabbreviation", _ntimezonename);}
RemoteObject _timezoneoffset = RemoteObject.createImmutable(0);
RemoteObject _tzoffset = RemoteObject.createImmutable(0f);
RemoteObject _stroffset = RemoteObject.createImmutable("");
Debug.locals.put("nTimeZoneName", _ntimezonename);
 BA.debugLineNum = 116;BA.debugLine="Sub GetAbbreviation (nTimeZoneName As String) As S";
Debug.ShouldStop(524288);
 BA.debugLineNum = 118;BA.debugLine="Try";
Debug.ShouldStop(2097152);
try { BA.debugLineNum = 120;BA.debugLine="Dim TimeZoneOffset As Int = oTimezoneMapper.RunM";
Debug.ShouldStop(8388608);
_timezoneoffset = (BA.numberCast(int.class, main.mostCurrent._otimezonemapper.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getTZOffset")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(_ntimezonename.runMethod(true,"trim"))})))));Debug.locals.put("TimeZoneOffset", _timezoneoffset);Debug.locals.put("TimeZoneOffset", _timezoneoffset);
 BA.debugLineNum = 121;BA.debugLine="Dim tzOffset As Float = (TimeZoneOffset / 3600)";
Debug.ShouldStop(16777216);
_tzoffset = BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_timezoneoffset,RemoteObject.createImmutable(3600)}, "/",0, 0)),RemoteObject.createImmutable(1000)}, "/",0, 0));Debug.locals.put("tzOffset", _tzoffset);Debug.locals.put("tzOffset", _tzoffset);
 BA.debugLineNum = 122;BA.debugLine="Dim StrOffset As String";
Debug.ShouldStop(33554432);
_stroffset = RemoteObject.createImmutable("");Debug.locals.put("StrOffset", _stroffset);
 BA.debugLineNum = 124;BA.debugLine="StrOffset = \"GMT \" & IIf(tzOffset >= 0,\"+\",\"\") &";
Debug.ShouldStop(134217728);
_stroffset = RemoteObject.concat(RemoteObject.createImmutable("GMT "),((RemoteObject.solveBoolean("g",_tzoffset,BA.numberCast(double.class, 0))) ? (RemoteObject.createImmutable(("+"))) : ((RemoteObject.createImmutable("")))),_tzoffset);Debug.locals.put("StrOffset", _stroffset);
 BA.debugLineNum = 126;BA.debugLine="Return StrOffset.Trim";
Debug.ShouldStop(536870912);
Debug.CheckDeviceExceptions();if (true) return _stroffset.runMethod(true,"trim");
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e8) {
			BA.rdebugUtils.runVoidMethod("setLastException",main.processBA, e8.toString()); BA.debugLineNum = 132;BA.debugLine="Return \"\"";
Debug.ShouldStop(8);
if (true) return BA.ObjectToString("");
 };
 BA.debugLineNum = 136;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getdaylightsaving(RemoteObject _ntimezonename) throws Exception{
try {
		Debug.PushSubsStack("GetDaylightSaving (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,139);
if (RapidSub.canDelegate("getdaylightsaving")) { return b4a.TimezoneMapper.main.remoteMe.runUserSub(false, "main","getdaylightsaving", _ntimezonename);}
Debug.locals.put("nTimeZoneName", _ntimezonename);
 BA.debugLineNum = 139;BA.debugLine="Sub GetDaylightSaving (nTimeZoneName As String) As";
Debug.ShouldStop(1024);
 BA.debugLineNum = 141;BA.debugLine="Try";
Debug.ShouldStop(4096);
try { BA.debugLineNum = 143;BA.debugLine="Return oTimezoneMapper.RunMethod(\"getTZDst\",Arra";
Debug.ShouldStop(16384);
Debug.CheckDeviceExceptions();if (true) return (BA.ObjectToBoolean(main.mostCurrent._otimezonemapper.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getTZDst")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(_ntimezonename.runMethod(true,"trim"))})))));
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e4) {
			BA.rdebugUtils.runVoidMethod("setLastException",main.processBA, e4.toString()); BA.debugLineNum = 149;BA.debugLine="Return False";
Debug.ShouldStop(1048576);
if (true) return main.mostCurrent.__c.getField(true,"False");
 };
 BA.debugLineNum = 153;BA.debugLine="End Sub";
Debug.ShouldStop(16777216);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _gettimezonenamefromlatlong(RemoteObject _lat,RemoteObject _lng) throws Exception{
try {
		Debug.PushSubsStack("GetTimeZoneNameFromLatLong (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,99);
if (RapidSub.canDelegate("gettimezonenamefromlatlong")) { return b4a.TimezoneMapper.main.remoteMe.runUserSub(false, "main","gettimezonenamefromlatlong", _lat, _lng);}
Debug.locals.put("lat", _lat);
Debug.locals.put("lng", _lng);
 BA.debugLineNum = 99;BA.debugLine="Sub GetTimeZoneNameFromLatLong(lat As Double, lng";
Debug.ShouldStop(4);
 BA.debugLineNum = 101;BA.debugLine="Try";
Debug.ShouldStop(16);
try { BA.debugLineNum = 103;BA.debugLine="Return oTimezoneMapper.RunMethod(\"latLngToTimeZo";
Debug.ShouldStop(64);
Debug.CheckDeviceExceptions();if (true) return (BA.ObjectToString(main.mostCurrent._otimezonemapper.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("latLngToTimeZoneString")),(Object)(RemoteObject.createNewArray("Object",new int[] {2},new Object[] {(_lat),(_lng)}))))).runMethod(true,"trim");
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e4) {
			BA.rdebugUtils.runVoidMethod("setLastException",main.processBA, e4.toString()); BA.debugLineNum = 109;BA.debugLine="Return \"\"";
Debug.ShouldStop(4096);
if (true) return BA.ObjectToString("");
 };
 BA.debugLineNum = 113;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _globals() throws Exception{
 //BA.debugLineNum = 25;BA.debugLine="Sub Globals";
 //BA.debugLineNum = 29;BA.debugLine="Private TextField1 As EditText";
main.mostCurrent._textfield1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.EditTextWrapper");
 //BA.debugLineNum = 30;BA.debugLine="Private TextField2 As EditText";
main.mostCurrent._textfield2 = RemoteObject.createNew ("anywheresoftware.b4a.objects.EditTextWrapper");
 //BA.debugLineNum = 31;BA.debugLine="Private Label3 As Label";
main.mostCurrent._label3 = RemoteObject.createNew ("anywheresoftware.b4a.objects.LabelWrapper");
 //BA.debugLineNum = 33;BA.debugLine="Private oTimezoneMapper As JavaObject";
main.mostCurrent._otimezonemapper = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
 //BA.debugLineNum = 35;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}

public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main_subs_0._process_globals();
main.myClass = BA.getDeviceClass ("b4a.TimezoneMapper.main");
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 17;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 22;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}