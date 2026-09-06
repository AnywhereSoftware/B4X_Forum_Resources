package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class shamsidatepickerv3_subs_0 {


public static RemoteObject  _adjustselectedday(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("AdjustSelectedDay (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,397);
if (RapidSub.canDelegate("adjustselectedday")) { return __ref.runUserSub(false, "shamsidatepickerv3","adjustselectedday", __ref);}
RemoteObject _maxday = RemoteObject.createImmutable(0);
 BA.debugLineNum = 397;BA.debugLine="Private Sub AdjustSelectedDay";
Debug.ShouldStop(4096);
 BA.debugLineNum = 398;BA.debugLine="If SelectedYear = CurrentYear And SelectedMonth =";
Debug.ShouldStop(8192);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_selectedyear" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(true,"_currentyear" /*RemoteObject*/ ))) && RemoteObject.solveBoolean("=",__ref.getField(true,"_selectedmonth" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(true,"_currentmonth" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 399;BA.debugLine="Dim maxDay As Int = GetDaysInMonth(CurrentYear,";
Debug.ShouldStop(16384);
_maxday = __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_getdaysinmonth" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_currentyear" /*RemoteObject*/ )),(Object)(__ref.getField(true,"_currentmonth" /*RemoteObject*/ )));Debug.locals.put("maxDay", _maxday);Debug.locals.put("maxDay", _maxday);
 BA.debugLineNum = 400;BA.debugLine="If SelectedDay > maxDay Then SelectedDay = maxDa";
Debug.ShouldStop(32768);
if (RemoteObject.solveBoolean(">",__ref.getField(true,"_selectedday" /*RemoteObject*/ ),BA.numberCast(double.class, _maxday))) { 
__ref.setField ("_selectedday" /*RemoteObject*/ ,_maxday);};
 };
 BA.debugLineNum = 402;BA.debugLine="End Sub";
Debug.ShouldStop(131072);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _btnconfirm_action(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("btnConfirm_Action (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,377);
if (RapidSub.canDelegate("btnconfirm_action")) { return __ref.runUserSub(false, "shamsidatepickerv3","btnconfirm_action", __ref);}
 BA.debugLineNum = 377;BA.debugLine="Private Sub btnConfirm_Action";
Debug.ShouldStop(16777216);
 BA.debugLineNum = 378;BA.debugLine="ConfirmAndClose";
Debug.ShouldStop(33554432);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_confirmandclose" /*RemoteObject*/ );
 BA.debugLineNum = 379;BA.debugLine="End Sub";
Debug.ShouldStop(67108864);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _btnmonthnext_action(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("btnMonthNext_Action (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,335);
if (RapidSub.canDelegate("btnmonthnext_action")) { return __ref.runUserSub(false, "shamsidatepickerv3","btnmonthnext_action", __ref);}
 BA.debugLineNum = 335;BA.debugLine="Private Sub btnMonthNext_Action";
Debug.ShouldStop(16384);
 BA.debugLineNum = 336;BA.debugLine="CurrentMonth = CurrentMonth + 1";
Debug.ShouldStop(32768);
__ref.setField ("_currentmonth" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_currentmonth" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "+",1, 1));
 BA.debugLineNum = 337;BA.debugLine="If CurrentMonth > 12 Then";
Debug.ShouldStop(65536);
if (RemoteObject.solveBoolean(">",__ref.getField(true,"_currentmonth" /*RemoteObject*/ ),BA.numberCast(double.class, 12))) { 
 BA.debugLineNum = 338;BA.debugLine="CurrentMonth = 1";
Debug.ShouldStop(131072);
__ref.setField ("_currentmonth" /*RemoteObject*/ ,BA.numberCast(int.class, 1));
 BA.debugLineNum = 339;BA.debugLine="CurrentYear = CurrentYear + 1";
Debug.ShouldStop(262144);
__ref.setField ("_currentyear" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_currentyear" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "+",1, 1));
 };
 BA.debugLineNum = 341;BA.debugLine="AdjustSelectedDay";
Debug.ShouldStop(1048576);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_adjustselectedday" /*RemoteObject*/ );
 BA.debugLineNum = 342;BA.debugLine="DrawCalendar";
Debug.ShouldStop(2097152);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_drawcalendar" /*RemoteObject*/ );
 BA.debugLineNum = 343;BA.debugLine="End Sub";
Debug.ShouldStop(4194304);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _btnmonthprev_action(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("btnMonthPrev_Action (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,345);
if (RapidSub.canDelegate("btnmonthprev_action")) { return __ref.runUserSub(false, "shamsidatepickerv3","btnmonthprev_action", __ref);}
 BA.debugLineNum = 345;BA.debugLine="Private Sub btnMonthPrev_Action";
Debug.ShouldStop(16777216);
 BA.debugLineNum = 346;BA.debugLine="CurrentMonth = CurrentMonth - 1";
Debug.ShouldStop(33554432);
__ref.setField ("_currentmonth" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_currentmonth" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "-",1, 1));
 BA.debugLineNum = 347;BA.debugLine="If CurrentMonth < 1 Then";
Debug.ShouldStop(67108864);
if (RemoteObject.solveBoolean("<",__ref.getField(true,"_currentmonth" /*RemoteObject*/ ),BA.numberCast(double.class, 1))) { 
 BA.debugLineNum = 348;BA.debugLine="CurrentMonth = 12";
Debug.ShouldStop(134217728);
__ref.setField ("_currentmonth" /*RemoteObject*/ ,BA.numberCast(int.class, 12));
 BA.debugLineNum = 349;BA.debugLine="CurrentYear = CurrentYear - 1";
Debug.ShouldStop(268435456);
__ref.setField ("_currentyear" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_currentyear" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "-",1, 1));
 };
 BA.debugLineNum = 351;BA.debugLine="AdjustSelectedDay";
Debug.ShouldStop(1073741824);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_adjustselectedday" /*RemoteObject*/ );
 BA.debugLineNum = 352;BA.debugLine="DrawCalendar";
Debug.ShouldStop(-2147483648);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_drawcalendar" /*RemoteObject*/ );
 BA.debugLineNum = 353;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _btntoday_action(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("btnToday_Action (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,368);
if (RapidSub.canDelegate("btntoday_action")) { return __ref.runUserSub(false, "shamsidatepickerv3","btntoday_action", __ref);}
 BA.debugLineNum = 368;BA.debugLine="Private Sub btnToday_Action";
Debug.ShouldStop(32768);
 BA.debugLineNum = 369;BA.debugLine="CurrentYear = TodayYear";
Debug.ShouldStop(65536);
__ref.setField ("_currentyear" /*RemoteObject*/ ,__ref.getField(true,"_todayyear" /*RemoteObject*/ ));
 BA.debugLineNum = 370;BA.debugLine="CurrentMonth = TodayMonth";
Debug.ShouldStop(131072);
__ref.setField ("_currentmonth" /*RemoteObject*/ ,__ref.getField(true,"_todaymonth" /*RemoteObject*/ ));
 BA.debugLineNum = 371;BA.debugLine="SelectedYear = TodayYear";
Debug.ShouldStop(262144);
__ref.setField ("_selectedyear" /*RemoteObject*/ ,__ref.getField(true,"_todayyear" /*RemoteObject*/ ));
 BA.debugLineNum = 372;BA.debugLine="SelectedMonth = TodayMonth";
Debug.ShouldStop(524288);
__ref.setField ("_selectedmonth" /*RemoteObject*/ ,__ref.getField(true,"_todaymonth" /*RemoteObject*/ ));
 BA.debugLineNum = 373;BA.debugLine="SelectedDay = TodayDay";
Debug.ShouldStop(1048576);
__ref.setField ("_selectedday" /*RemoteObject*/ ,__ref.getField(true,"_todayday" /*RemoteObject*/ ));
 BA.debugLineNum = 374;BA.debugLine="DrawCalendar";
Debug.ShouldStop(2097152);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_drawcalendar" /*RemoteObject*/ );
 BA.debugLineNum = 375;BA.debugLine="End Sub";
Debug.ShouldStop(4194304);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _btnyearnext_action(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("btnYearNext_Action (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,356);
if (RapidSub.canDelegate("btnyearnext_action")) { return __ref.runUserSub(false, "shamsidatepickerv3","btnyearnext_action", __ref);}
 BA.debugLineNum = 356;BA.debugLine="Private Sub btnYearNext_Action";
Debug.ShouldStop(8);
 BA.debugLineNum = 357;BA.debugLine="CurrentYear = CurrentYear + 1";
Debug.ShouldStop(16);
__ref.setField ("_currentyear" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_currentyear" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "+",1, 1));
 BA.debugLineNum = 358;BA.debugLine="AdjustSelectedDay";
Debug.ShouldStop(32);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_adjustselectedday" /*RemoteObject*/ );
 BA.debugLineNum = 359;BA.debugLine="DrawCalendar";
Debug.ShouldStop(64);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_drawcalendar" /*RemoteObject*/ );
 BA.debugLineNum = 360;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _btnyearprev_action(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("btnYearPrev_Action (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,362);
if (RapidSub.canDelegate("btnyearprev_action")) { return __ref.runUserSub(false, "shamsidatepickerv3","btnyearprev_action", __ref);}
 BA.debugLineNum = 362;BA.debugLine="Private Sub btnYearPrev_Action";
Debug.ShouldStop(512);
 BA.debugLineNum = 363;BA.debugLine="CurrentYear = CurrentYear - 1";
Debug.ShouldStop(1024);
__ref.setField ("_currentyear" /*RemoteObject*/ ,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_currentyear" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "-",1, 1));
 BA.debugLineNum = 364;BA.debugLine="AdjustSelectedDay";
Debug.ShouldStop(2048);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_adjustselectedday" /*RemoteObject*/ );
 BA.debugLineNum = 365;BA.debugLine="DrawCalendar";
Debug.ShouldStop(4096);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_drawcalendar" /*RemoteObject*/ );
 BA.debugLineNum = 366;BA.debugLine="End Sub";
Debug.ShouldStop(8192);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 3;BA.debugLine="private Sub Class_Globals";
 //BA.debugLineNum = 4;BA.debugLine="Private fx As JFX";
shamsidatepickerv3._fx = RemoteObject.createNew ("anywheresoftware.b4j.objects.JFX");__ref.setField("_fx",shamsidatepickerv3._fx);
 //BA.debugLineNum = 5;BA.debugLine="Private frm As Form";
shamsidatepickerv3._frm = RemoteObject.createNew ("anywheresoftware.b4j.objects.Form");__ref.setField("_frm",shamsidatepickerv3._frm);
 //BA.debugLineNum = 6;BA.debugLine="Private MainPane As Pane";
shamsidatepickerv3._mainpane = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");__ref.setField("_mainpane",shamsidatepickerv3._mainpane);
 //BA.debugLineNum = 8;BA.debugLine="Private CurrentYear, CurrentMonth As Int";
shamsidatepickerv3._currentyear = RemoteObject.createImmutable(0);__ref.setField("_currentyear",shamsidatepickerv3._currentyear);
shamsidatepickerv3._currentmonth = RemoteObject.createImmutable(0);__ref.setField("_currentmonth",shamsidatepickerv3._currentmonth);
 //BA.debugLineNum = 9;BA.debugLine="Private SelectedYear, SelectedMonth, SelectedDay";
shamsidatepickerv3._selectedyear = RemoteObject.createImmutable(0);__ref.setField("_selectedyear",shamsidatepickerv3._selectedyear);
shamsidatepickerv3._selectedmonth = RemoteObject.createImmutable(0);__ref.setField("_selectedmonth",shamsidatepickerv3._selectedmonth);
shamsidatepickerv3._selectedday = RemoteObject.createImmutable(0);__ref.setField("_selectedday",shamsidatepickerv3._selectedday);
 //BA.debugLineNum = 10;BA.debugLine="Private TodayYear, TodayMonth, TodayDay As Int";
shamsidatepickerv3._todayyear = RemoteObject.createImmutable(0);__ref.setField("_todayyear",shamsidatepickerv3._todayyear);
shamsidatepickerv3._todaymonth = RemoteObject.createImmutable(0);__ref.setField("_todaymonth",shamsidatepickerv3._todaymonth);
shamsidatepickerv3._todayday = RemoteObject.createImmutable(0);__ref.setField("_todayday",shamsidatepickerv3._todayday);
 //BA.debugLineNum = 12;BA.debugLine="Public ResultYear, ResultMonth, ResultDay As Int";
shamsidatepickerv3._resultyear = RemoteObject.createImmutable(0);__ref.setField("_resultyear",shamsidatepickerv3._resultyear);
shamsidatepickerv3._resultmonth = RemoteObject.createImmutable(0);__ref.setField("_resultmonth",shamsidatepickerv3._resultmonth);
shamsidatepickerv3._resultday = RemoteObject.createImmutable(0);__ref.setField("_resultday",shamsidatepickerv3._resultday);
 //BA.debugLineNum = 13;BA.debugLine="Public IsConfirmed As Boolean";
shamsidatepickerv3._isconfirmed = RemoteObject.createImmutable(false);__ref.setField("_isconfirmed",shamsidatepickerv3._isconfirmed);
 //BA.debugLineNum = 14;BA.debugLine="Public UsePersianDigits As Boolean = False";
shamsidatepickerv3._usepersiandigits = shamsidatepickerv3.__c.getField(true,"False");__ref.setField("_usepersiandigits",shamsidatepickerv3._usepersiandigits);
 //BA.debugLineNum = 16;BA.debugLine="Private MonthNames() As String";
shamsidatepickerv3._monthnames = RemoteObject.createNewArray ("String", new int[] {0}, new Object[]{});__ref.setField("_monthnames",shamsidatepickerv3._monthnames);
 //BA.debugLineNum = 17;BA.debugLine="Private DayNames() As String";
shamsidatepickerv3._daynames = RemoteObject.createNewArray ("String", new int[] {0}, new Object[]{});__ref.setField("_daynames",shamsidatepickerv3._daynames);
 //BA.debugLineNum = 18;BA.debugLine="Private FullDayNames() As String";
shamsidatepickerv3._fulldaynames = RemoteObject.createNewArray ("String", new int[] {0}, new Object[]{});__ref.setField("_fulldaynames",shamsidatepickerv3._fulldaynames);
 //BA.debugLineNum = 20;BA.debugLine="Private CELL_SIZE As Int = 36";
shamsidatepickerv3._cell_size = BA.numberCast(int.class, 36);__ref.setField("_cell_size",shamsidatepickerv3._cell_size);
 //BA.debugLineNum = 21;BA.debugLine="Private FORM_WIDTH As Int = 290";
shamsidatepickerv3._form_width = BA.numberCast(int.class, 290);__ref.setField("_form_width",shamsidatepickerv3._form_width);
 //BA.debugLineNum = 22;BA.debugLine="Private FORM_HEIGHT As Int = 335";
shamsidatepickerv3._form_height = BA.numberCast(int.class, 335);__ref.setField("_form_height",shamsidatepickerv3._form_height);
 //BA.debugLineNum = 24;BA.debugLine="Private FNT As String = \"-fx-font-family: Tahoma;";
shamsidatepickerv3._fnt = BA.ObjectToString("-fx-font-family: Tahoma; -fx-font-size: 12;");__ref.setField("_fnt",shamsidatepickerv3._fnt);
 //BA.debugLineNum = 26;BA.debugLine="Private DayLabels As List";
shamsidatepickerv3._daylabels = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");__ref.setField("_daylabels",shamsidatepickerv3._daylabels);
 //BA.debugLineNum = 27;BA.debugLine="Private FirstDow As Int";
shamsidatepickerv3._firstdow = RemoteObject.createImmutable(0);__ref.setField("_firstdow",shamsidatepickerv3._firstdow);
 //BA.debugLineNum = 28;BA.debugLine="Private lblMonthYear As Label";
shamsidatepickerv3._lblmonthyear = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");__ref.setField("_lblmonthyear",shamsidatepickerv3._lblmonthyear);
 //BA.debugLineNum = 29;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _confirmandclose(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("ConfirmAndClose (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,381);
if (RapidSub.canDelegate("confirmandclose")) { return __ref.runUserSub(false, "shamsidatepickerv3","confirmandclose", __ref);}
 BA.debugLineNum = 381;BA.debugLine="Private Sub ConfirmAndClose";
Debug.ShouldStop(268435456);
 BA.debugLineNum = 382;BA.debugLine="ResultYear = SelectedYear";
Debug.ShouldStop(536870912);
__ref.setField ("_resultyear" /*RemoteObject*/ ,__ref.getField(true,"_selectedyear" /*RemoteObject*/ ));
 BA.debugLineNum = 383;BA.debugLine="ResultMonth = SelectedMonth";
Debug.ShouldStop(1073741824);
__ref.setField ("_resultmonth" /*RemoteObject*/ ,__ref.getField(true,"_selectedmonth" /*RemoteObject*/ ));
 BA.debugLineNum = 384;BA.debugLine="ResultDay = SelectedDay";
Debug.ShouldStop(-2147483648);
__ref.setField ("_resultday" /*RemoteObject*/ ,__ref.getField(true,"_selectedday" /*RemoteObject*/ ));
 BA.debugLineNum = 385;BA.debugLine="IsConfirmed = True";
Debug.ShouldStop(1);
__ref.setField ("_isconfirmed" /*RemoteObject*/ ,shamsidatepickerv3.__c.getField(true,"True"));
 BA.debugLineNum = 386;BA.debugLine="frm.Close";
Debug.ShouldStop(2);
__ref.getField(false,"_frm" /*RemoteObject*/ ).runVoidMethod ("Close");
 BA.debugLineNum = 387;BA.debugLine="End Sub";
Debug.ShouldStop(4);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _converttodaytoshamsi(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("ConvertTodayToShamsi (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,473);
if (RapidSub.canDelegate("converttodaytoshamsi")) { return __ref.runUserSub(false, "shamsidatepickerv3","converttodaytoshamsi", __ref);}
RemoteObject _n = RemoteObject.createImmutable(0L);
RemoteObject _r = null;
 BA.debugLineNum = 473;BA.debugLine="Private Sub ConvertTodayToShamsi";
Debug.ShouldStop(16777216);
 BA.debugLineNum = 474;BA.debugLine="Dim n As Long = DateTime.Now";
Debug.ShouldStop(33554432);
_n = shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"getNow");Debug.locals.put("n", _n);Debug.locals.put("n", _n);
 BA.debugLineNum = 475;BA.debugLine="Dim r() As Int = GregorianToShamsi(DateTime.GetYe";
Debug.ShouldStop(67108864);
_r = __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_gregoriantoshamsi" /*RemoteObject*/ ,(Object)(shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"GetYear",(Object)(_n))),(Object)(shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"GetMonth",(Object)(_n))),(Object)(shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"GetDayOfMonth",(Object)(_n))));Debug.locals.put("r", _r);Debug.locals.put("r", _r);
 BA.debugLineNum = 476;BA.debugLine="TodayYear = r(0)";
Debug.ShouldStop(134217728);
__ref.setField ("_todayyear" /*RemoteObject*/ ,_r.getArrayElement(true,BA.numberCast(int.class, 0)));
 BA.debugLineNum = 477;BA.debugLine="TodayMonth = r(1)";
Debug.ShouldStop(268435456);
__ref.setField ("_todaymonth" /*RemoteObject*/ ,_r.getArrayElement(true,BA.numberCast(int.class, 1)));
 BA.debugLineNum = 478;BA.debugLine="TodayDay = r(2)";
Debug.ShouldStop(536870912);
__ref.setField ("_todayday" /*RemoteObject*/ ,_r.getArrayElement(true,BA.numberCast(int.class, 2)));
 BA.debugLineNum = 479;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _daylabel_mouseclicked(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("dayLabel_MouseClicked (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,314);
if (RapidSub.canDelegate("daylabel_mouseclicked")) { return __ref.runUserSub(false, "shamsidatepickerv3","daylabel_mouseclicked", __ref, _eventdata);}
RemoteObject _lbl = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
RemoteObject _day = RemoteObject.createImmutable(0);
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 314;BA.debugLine="private Sub dayLabel_MouseClicked (EventData As Mo";
Debug.ShouldStop(33554432);
 BA.debugLineNum = 315;BA.debugLine="Dim lbl As Label";
Debug.ShouldStop(67108864);
_lbl = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("lbl", _lbl);
 BA.debugLineNum = 316;BA.debugLine="lbl = Sender";
Debug.ShouldStop(134217728);
_lbl = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.LabelWrapper"), shamsidatepickerv3.__c.runMethod(false,"Sender",__ref.getField(false, "ba")));Debug.locals.put("lbl", _lbl);
 BA.debugLineNum = 318;BA.debugLine="If lbl.Tag <> Null Then";
Debug.ShouldStop(536870912);
if (RemoteObject.solveBoolean("N",_lbl.runMethod(false,"getTag"))) { 
 BA.debugLineNum = 319;BA.debugLine="Dim day As Int = lbl.Tag";
Debug.ShouldStop(1073741824);
_day = BA.numberCast(int.class, _lbl.runMethod(false,"getTag"));Debug.locals.put("day", _day);Debug.locals.put("day", _day);
 BA.debugLineNum = 321;BA.debugLine="SelectedYear = CurrentYear";
Debug.ShouldStop(1);
__ref.setField ("_selectedyear" /*RemoteObject*/ ,__ref.getField(true,"_currentyear" /*RemoteObject*/ ));
 BA.debugLineNum = 322;BA.debugLine="SelectedMonth = CurrentMonth";
Debug.ShouldStop(2);
__ref.setField ("_selectedmonth" /*RemoteObject*/ ,__ref.getField(true,"_currentmonth" /*RemoteObject*/ ));
 BA.debugLineNum = 323;BA.debugLine="SelectedDay = day";
Debug.ShouldStop(4);
__ref.setField ("_selectedday" /*RemoteObject*/ ,_day);
 BA.debugLineNum = 325;BA.debugLine="If EventData.ClickCount >= 2 Then     'دابل کلیک";
Debug.ShouldStop(16);
if (RemoteObject.solveBoolean("g",_eventdata.runMethod(true,"getClickCount"),BA.numberCast(double.class, 2))) { 
 BA.debugLineNum = 326;BA.debugLine="ConfirmAndClose";
Debug.ShouldStop(32);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_confirmandclose" /*RemoteObject*/ );
 BA.debugLineNum = 327;BA.debugLine="Return";
Debug.ShouldStop(64);
if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 330;BA.debugLine="RefreshStyles";
Debug.ShouldStop(512);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_refreshstyles" /*RemoteObject*/ );
 };
 BA.debugLineNum = 332;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _drawcalendar(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("DrawCalendar (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,169);
if (RapidSub.canDelegate("drawcalendar")) { return __ref.runUserSub(false, "shamsidatepickerv3","drawcalendar", __ref);}
RemoteObject _startx = RemoteObject.createImmutable(0);
RemoteObject _navpane = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _btnmonthnext = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
RemoteObject _btnyearnext = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
RemoteObject _btnmonthprev = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
RemoteObject _btnyearprev = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
RemoteObject _ypos = RemoteObject.createImmutable(0);
int _i = 0;
RemoteObject _lbldn = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
RemoteObject _c = RemoteObject.createImmutable("");
RemoteObject _sep = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _daysinmonth = RemoteObject.createImmutable(0);
RemoteObject _row = RemoteObject.createImmutable(0);
RemoteObject _col = RemoteObject.createImmutable(0);
int _day = 0;
RemoteObject _lbl = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
RemoteObject _btny = RemoteObject.createImmutable(0);
RemoteObject _sep2 = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _btnconfirm = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
RemoteObject _btntoday = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
 BA.debugLineNum = 169;BA.debugLine="Private Sub DrawCalendar";
Debug.ShouldStop(256);
 BA.debugLineNum = 170;BA.debugLine="MainPane.RemoveAllNodes";
Debug.ShouldStop(512);
__ref.getField(false,"_mainpane" /*RemoteObject*/ ).runVoidMethod ("RemoveAllNodes");
 BA.debugLineNum = 171;BA.debugLine="DayLabels.Clear";
Debug.ShouldStop(1024);
__ref.getField(false,"_daylabels" /*RemoteObject*/ ).runVoidMethod ("Clear");
 BA.debugLineNum = 173;BA.debugLine="Dim startX As Int = (FORM_WIDTH - (7 * CELL_SIZE)";
Debug.ShouldStop(4096);
_startx = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_form_width" /*RemoteObject*/ ),(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(7),__ref.getField(true,"_cell_size" /*RemoteObject*/ )}, "*",0, 1))}, "-",1, 1)),RemoteObject.createImmutable(2)}, "/",0, 0));Debug.locals.put("startX", _startx);Debug.locals.put("startX", _startx);
 BA.debugLineNum = 178;BA.debugLine="Dim navPane As Pane";
Debug.ShouldStop(131072);
_navpane = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("navPane", _navpane);
 BA.debugLineNum = 179;BA.debugLine="navPane.Initialize(\"\")";
Debug.ShouldStop(262144);
_navpane.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 180;BA.debugLine="navPane.Style = \"-fx-background-color: #2196F3;\"";
Debug.ShouldStop(524288);
_navpane.runMethod(true,"setStyle",BA.ObjectToString("-fx-background-color: #2196F3;"));
 BA.debugLineNum = 181;BA.debugLine="MainPane.AddNode(navPane, 0, 0, FORM_WIDTH, 38)";
Debug.ShouldStop(1048576);
__ref.getField(false,"_mainpane" /*RemoteObject*/ ).runVoidMethod ("AddNode",(Object)((_navpane.getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, __ref.getField(true,"_form_width" /*RemoteObject*/ ))),(Object)(BA.numberCast(double.class, 38)));
 BA.debugLineNum = 184;BA.debugLine="Dim btnMonthNext As Button          'بیرونی راست";
Debug.ShouldStop(8388608);
_btnmonthnext = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");Debug.locals.put("btnMonthNext", _btnmonthnext);
 BA.debugLineNum = 185;BA.debugLine="btnMonthNext.Initialize(\"btnMonthNext\")";
Debug.ShouldStop(16777216);
_btnmonthnext.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("btnMonthNext")));
 BA.debugLineNum = 186;BA.debugLine="btnMonthNext.Text = \"❯\"";
Debug.ShouldStop(33554432);
_btnmonthnext.runMethod(true,"setText",BA.ObjectToString("❯"));
 BA.debugLineNum = 187;BA.debugLine="btnMonthNext.Style = $\"-fx-background-color: tran";
Debug.ShouldStop(67108864);
_btnmonthnext.runMethod(true,"setStyle",(RemoteObject.concat(RemoteObject.createImmutable("-fx-background-color: transparent; -fx-text-fill: white; "),shamsidatepickerv3.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((__ref.getField(true,"_fnt" /*RemoteObject*/ )))),RemoteObject.createImmutable(" -fx-cursor: hand;"))));
 BA.debugLineNum = 188;BA.debugLine="navPane.AddNode(btnMonthNext, FORM_WIDTH - 40, 2,";
Debug.ShouldStop(134217728);
_navpane.runVoidMethod ("AddNode",(Object)((_btnmonthnext.getObject())),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_form_width" /*RemoteObject*/ ),RemoteObject.createImmutable(40)}, "-",1, 1))),(Object)(BA.numberCast(double.class, 2)),(Object)(BA.numberCast(double.class, 34)),(Object)(BA.numberCast(double.class, 34)));
 BA.debugLineNum = 190;BA.debugLine="Dim btnYearNext As Button           'داخلی راست";
Debug.ShouldStop(536870912);
_btnyearnext = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");Debug.locals.put("btnYearNext", _btnyearnext);
 BA.debugLineNum = 191;BA.debugLine="btnYearNext.Initialize(\"btnYearNext\")";
Debug.ShouldStop(1073741824);
_btnyearnext.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("btnYearNext")));
 BA.debugLineNum = 192;BA.debugLine="btnYearNext.Text = \"❯❯\"";
Debug.ShouldStop(-2147483648);
_btnyearnext.runMethod(true,"setText",BA.ObjectToString("❯❯"));
 BA.debugLineNum = 193;BA.debugLine="btnYearNext.Style = $\"-fx-background-color: trans";
Debug.ShouldStop(1);
_btnyearnext.runMethod(true,"setStyle",(RemoteObject.concat(RemoteObject.createImmutable("-fx-background-color: transparent; -fx-text-fill: white; "),shamsidatepickerv3.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((__ref.getField(true,"_fnt" /*RemoteObject*/ )))),RemoteObject.createImmutable(" -fx-cursor: hand;"))));
 BA.debugLineNum = 194;BA.debugLine="navPane.AddNode(btnYearNext, FORM_WIDTH - 76, 2,";
Debug.ShouldStop(2);
_navpane.runVoidMethod ("AddNode",(Object)((_btnyearnext.getObject())),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_form_width" /*RemoteObject*/ ),RemoteObject.createImmutable(76)}, "-",1, 1))),(Object)(BA.numberCast(double.class, 2)),(Object)(BA.numberCast(double.class, 36)),(Object)(BA.numberCast(double.class, 34)));
 BA.debugLineNum = 197;BA.debugLine="Dim btnMonthPrev As Button          'بیرونی چپ  =";
Debug.ShouldStop(16);
_btnmonthprev = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");Debug.locals.put("btnMonthPrev", _btnmonthprev);
 BA.debugLineNum = 198;BA.debugLine="btnMonthPrev.Initialize(\"btnMonthPrev\")";
Debug.ShouldStop(32);
_btnmonthprev.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("btnMonthPrev")));
 BA.debugLineNum = 199;BA.debugLine="btnMonthPrev.Text = \"❮\"";
Debug.ShouldStop(64);
_btnmonthprev.runMethod(true,"setText",BA.ObjectToString("❮"));
 BA.debugLineNum = 200;BA.debugLine="btnMonthPrev.Style = $\"-fx-background-color: tran";
Debug.ShouldStop(128);
_btnmonthprev.runMethod(true,"setStyle",(RemoteObject.concat(RemoteObject.createImmutable("-fx-background-color: transparent; -fx-text-fill: white; "),shamsidatepickerv3.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((__ref.getField(true,"_fnt" /*RemoteObject*/ )))),RemoteObject.createImmutable(" -fx-cursor: hand;"))));
 BA.debugLineNum = 201;BA.debugLine="navPane.AddNode(btnMonthPrev, 6, 2, 34, 34)";
Debug.ShouldStop(256);
_navpane.runVoidMethod ("AddNode",(Object)((_btnmonthprev.getObject())),(Object)(BA.numberCast(double.class, 6)),(Object)(BA.numberCast(double.class, 2)),(Object)(BA.numberCast(double.class, 34)),(Object)(BA.numberCast(double.class, 34)));
 BA.debugLineNum = 203;BA.debugLine="Dim btnYearPrev As Button           'داخلی چپ  =";
Debug.ShouldStop(1024);
_btnyearprev = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");Debug.locals.put("btnYearPrev", _btnyearprev);
 BA.debugLineNum = 204;BA.debugLine="btnYearPrev.Initialize(\"btnYearPrev\")";
Debug.ShouldStop(2048);
_btnyearprev.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("btnYearPrev")));
 BA.debugLineNum = 205;BA.debugLine="btnYearPrev.Text = \"❮❮\"";
Debug.ShouldStop(4096);
_btnyearprev.runMethod(true,"setText",BA.ObjectToString("❮❮"));
 BA.debugLineNum = 206;BA.debugLine="btnYearPrev.Style = $\"-fx-background-color: trans";
Debug.ShouldStop(8192);
_btnyearprev.runMethod(true,"setStyle",(RemoteObject.concat(RemoteObject.createImmutable("-fx-background-color: transparent; -fx-text-fill: white; "),shamsidatepickerv3.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((__ref.getField(true,"_fnt" /*RemoteObject*/ )))),RemoteObject.createImmutable(" -fx-cursor: hand;"))));
 BA.debugLineNum = 207;BA.debugLine="navPane.AddNode(btnYearPrev, 40, 2, 36, 34)";
Debug.ShouldStop(16384);
_navpane.runVoidMethod ("AddNode",(Object)((_btnyearprev.getObject())),(Object)(BA.numberCast(double.class, 40)),(Object)(BA.numberCast(double.class, 2)),(Object)(BA.numberCast(double.class, 36)),(Object)(BA.numberCast(double.class, 34)));
 BA.debugLineNum = 209;BA.debugLine="lblMonthYear.Initialize(\"\")";
Debug.ShouldStop(65536);
__ref.getField(false,"_lblmonthyear" /*RemoteObject*/ ).runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 210;BA.debugLine="lblMonthYear.Alignment = \"CENTER\"";
Debug.ShouldStop(131072);
__ref.getField(false,"_lblmonthyear" /*RemoteObject*/ ).runMethod(true,"setAlignment",BA.ObjectToString("CENTER"));
 BA.debugLineNum = 211;BA.debugLine="lblMonthYear.Style = $\"-fx-text-fill: white; -fx-";
Debug.ShouldStop(262144);
__ref.getField(false,"_lblmonthyear" /*RemoteObject*/ ).runMethod(true,"setStyle",(RemoteObject.concat(RemoteObject.createImmutable("-fx-text-fill: white; -fx-font-weight: bold; "),shamsidatepickerv3.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((__ref.getField(true,"_fnt" /*RemoteObject*/ )))),RemoteObject.createImmutable(""))));
 BA.debugLineNum = 212;BA.debugLine="navPane.AddNode(lblMonthYear, 78, 2, FORM_WIDTH -";
Debug.ShouldStop(524288);
_navpane.runVoidMethod ("AddNode",(Object)((__ref.getField(false,"_lblmonthyear" /*RemoteObject*/ ).getObject())),(Object)(BA.numberCast(double.class, 78)),(Object)(BA.numberCast(double.class, 2)),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_form_width" /*RemoteObject*/ ),RemoteObject.createImmutable(156)}, "-",1, 1))),(Object)(BA.numberCast(double.class, 34)));
 BA.debugLineNum = 214;BA.debugLine="Dim yPos As Int = 42";
Debug.ShouldStop(2097152);
_ypos = BA.numberCast(int.class, 42);Debug.locals.put("yPos", _ypos);Debug.locals.put("yPos", _ypos);
 BA.debugLineNum = 217;BA.debugLine="For i = 0 To 6";
Debug.ShouldStop(16777216);
{
final int step33 = 1;
final int limit33 = 6;
_i = 0 ;
for (;(step33 > 0 && _i <= limit33) || (step33 < 0 && _i >= limit33) ;_i = ((int)(0 + _i + step33))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 218;BA.debugLine="Dim lblDN As Label";
Debug.ShouldStop(33554432);
_lbldn = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("lblDN", _lbldn);
 BA.debugLineNum = 219;BA.debugLine="lblDN.Initialize(\"\")";
Debug.ShouldStop(67108864);
_lbldn.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 220;BA.debugLine="lblDN.Text = DayNames(i)";
Debug.ShouldStop(134217728);
_lbldn.runMethod(true,"setText",__ref.getField(false,"_daynames" /*RemoteObject*/ ).getArrayElement(true,BA.numberCast(int.class, _i)));
 BA.debugLineNum = 221;BA.debugLine="lblDN.Alignment = \"CENTER\"";
Debug.ShouldStop(268435456);
_lbldn.runMethod(true,"setAlignment",BA.ObjectToString("CENTER"));
 BA.debugLineNum = 222;BA.debugLine="Dim c As String = \"#555555\"";
Debug.ShouldStop(536870912);
_c = BA.ObjectToString("#555555");Debug.locals.put("c", _c);Debug.locals.put("c", _c);
 BA.debugLineNum = 223;BA.debugLine="If i = 6 Then c = \"#E53935\"";
Debug.ShouldStop(1073741824);
if (RemoteObject.solveBoolean("=",RemoteObject.createImmutable(_i),BA.numberCast(double.class, 6))) { 
_c = BA.ObjectToString("#E53935");Debug.locals.put("c", _c);};
 BA.debugLineNum = 224;BA.debugLine="lblDN.Style = $\"-fx-text-fill: ${c}; -fx-font-we";
Debug.ShouldStop(-2147483648);
_lbldn.runMethod(true,"setStyle",(RemoteObject.concat(RemoteObject.createImmutable("-fx-text-fill: "),shamsidatepickerv3.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_c))),RemoteObject.createImmutable("; -fx-font-weight: bold; "),shamsidatepickerv3.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((__ref.getField(true,"_fnt" /*RemoteObject*/ )))),RemoteObject.createImmutable(""))));
 BA.debugLineNum = 225;BA.debugLine="MainPane.AddNode(lblDN, startX + ((6 - i) * CELL";
Debug.ShouldStop(1);
__ref.getField(false,"_mainpane" /*RemoteObject*/ ).runVoidMethod ("AddNode",(Object)((_lbldn.getObject())),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_startx,(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(6),RemoteObject.createImmutable(_i)}, "-",1, 1)),__ref.getField(true,"_cell_size" /*RemoteObject*/ )}, "*",0, 1))}, "+",1, 1))),(Object)(BA.numberCast(double.class, _ypos)),(Object)(BA.numberCast(double.class, __ref.getField(true,"_cell_size" /*RemoteObject*/ ))),(Object)(BA.numberCast(double.class, 22)));
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 227;BA.debugLine="yPos = yPos + 23";
Debug.ShouldStop(4);
_ypos = RemoteObject.solve(new RemoteObject[] {_ypos,RemoteObject.createImmutable(23)}, "+",1, 1);Debug.locals.put("yPos", _ypos);
 BA.debugLineNum = 229;BA.debugLine="Dim sep As Pane";
Debug.ShouldStop(16);
_sep = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("sep", _sep);
 BA.debugLineNum = 230;BA.debugLine="sep.Initialize(\"\")";
Debug.ShouldStop(32);
_sep.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 231;BA.debugLine="sep.Style = \"-fx-background-color: #E0E0E0;\"";
Debug.ShouldStop(64);
_sep.runMethod(true,"setStyle",BA.ObjectToString("-fx-background-color: #E0E0E0;"));
 BA.debugLineNum = 232;BA.debugLine="MainPane.AddNode(sep, startX, yPos, 7 * CELL_SIZE";
Debug.ShouldStop(128);
__ref.getField(false,"_mainpane" /*RemoteObject*/ ).runVoidMethod ("AddNode",(Object)((_sep.getObject())),(Object)(BA.numberCast(double.class, _startx)),(Object)(BA.numberCast(double.class, _ypos)),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(7),__ref.getField(true,"_cell_size" /*RemoteObject*/ )}, "*",0, 1))),(Object)(BA.numberCast(double.class, 1)));
 BA.debugLineNum = 233;BA.debugLine="yPos = yPos + 4";
Debug.ShouldStop(256);
_ypos = RemoteObject.solve(new RemoteObject[] {_ypos,RemoteObject.createImmutable(4)}, "+",1, 1);Debug.locals.put("yPos", _ypos);
 BA.debugLineNum = 236;BA.debugLine="Dim daysInMonth As Int = GetDaysInMonth(CurrentYe";
Debug.ShouldStop(2048);
_daysinmonth = __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_getdaysinmonth" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_currentyear" /*RemoteObject*/ )),(Object)(__ref.getField(true,"_currentmonth" /*RemoteObject*/ )));Debug.locals.put("daysInMonth", _daysinmonth);Debug.locals.put("daysInMonth", _daysinmonth);
 BA.debugLineNum = 237;BA.debugLine="FirstDow = GetFirstDayOfWeek(CurrentYear, Current";
Debug.ShouldStop(4096);
__ref.setField ("_firstdow" /*RemoteObject*/ ,__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_getfirstdayofweek" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_currentyear" /*RemoteObject*/ )),(Object)(__ref.getField(true,"_currentmonth" /*RemoteObject*/ ))));
 BA.debugLineNum = 239;BA.debugLine="Dim row As Int = 0";
Debug.ShouldStop(16384);
_row = BA.numberCast(int.class, 0);Debug.locals.put("row", _row);Debug.locals.put("row", _row);
 BA.debugLineNum = 240;BA.debugLine="Dim col As Int = FirstDow";
Debug.ShouldStop(32768);
_col = __ref.getField(true,"_firstdow" /*RemoteObject*/ );Debug.locals.put("col", _col);Debug.locals.put("col", _col);
 BA.debugLineNum = 242;BA.debugLine="For day = 1 To daysInMonth";
Debug.ShouldStop(131072);
{
final int step53 = 1;
final int limit53 = _daysinmonth.<Integer>get().intValue();
_day = 1 ;
for (;(step53 > 0 && _day <= limit53) || (step53 < 0 && _day >= limit53) ;_day = ((int)(0 + _day + step53))  ) {
Debug.locals.put("day", _day);
 BA.debugLineNum = 243;BA.debugLine="Dim lbl As Label";
Debug.ShouldStop(262144);
_lbl = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("lbl", _lbl);
 BA.debugLineNum = 244;BA.debugLine="lbl.Initialize(\"dayLabel\")";
Debug.ShouldStop(524288);
_lbl.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("dayLabel")));
 BA.debugLineNum = 245;BA.debugLine="lbl.Text = FormatNum(day)";
Debug.ShouldStop(1048576);
_lbl.runMethod(true,"setText",__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_formatnum" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, _day))));
 BA.debugLineNum = 246;BA.debugLine="lbl.Alignment = \"CENTER\"";
Debug.ShouldStop(2097152);
_lbl.runMethod(true,"setAlignment",BA.ObjectToString("CENTER"));
 BA.debugLineNum = 247;BA.debugLine="lbl.Tag = day";
Debug.ShouldStop(4194304);
_lbl.runMethod(false,"setTag",RemoteObject.createImmutable((_day)));
 BA.debugLineNum = 248;BA.debugLine="MainPane.AddNode(lbl, startX + ((6 - col) * CELL";
Debug.ShouldStop(8388608);
__ref.getField(false,"_mainpane" /*RemoteObject*/ ).runVoidMethod ("AddNode",(Object)((_lbl.getObject())),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_startx,(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(6),_col}, "-",1, 1)),__ref.getField(true,"_cell_size" /*RemoteObject*/ )}, "*",0, 1))}, "+",1, 1))),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_ypos,(RemoteObject.solve(new RemoteObject[] {_row,__ref.getField(true,"_cell_size" /*RemoteObject*/ )}, "*",0, 1))}, "+",1, 1))),(Object)(BA.numberCast(double.class, __ref.getField(true,"_cell_size" /*RemoteObject*/ ))),(Object)(BA.numberCast(double.class, __ref.getField(true,"_cell_size" /*RemoteObject*/ ))));
 BA.debugLineNum = 249;BA.debugLine="DayLabels.Add(lbl)";
Debug.ShouldStop(16777216);
__ref.getField(false,"_daylabels" /*RemoteObject*/ ).runVoidMethod ("Add",(Object)((_lbl.getObject())));
 BA.debugLineNum = 251;BA.debugLine="col = col + 1";
Debug.ShouldStop(67108864);
_col = RemoteObject.solve(new RemoteObject[] {_col,RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("col", _col);
 BA.debugLineNum = 252;BA.debugLine="If col > 6 Then";
Debug.ShouldStop(134217728);
if (RemoteObject.solveBoolean(">",_col,BA.numberCast(double.class, 6))) { 
 BA.debugLineNum = 253;BA.debugLine="col = 0";
Debug.ShouldStop(268435456);
_col = BA.numberCast(int.class, 0);Debug.locals.put("col", _col);
 BA.debugLineNum = 254;BA.debugLine="row = row + 1";
Debug.ShouldStop(536870912);
_row = RemoteObject.solve(new RemoteObject[] {_row,RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("row", _row);
 };
 }
}Debug.locals.put("day", _day);
;
 BA.debugLineNum = 259;BA.debugLine="Dim btnY As Int = FORM_HEIGHT - 40";
Debug.ShouldStop(4);
_btny = RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_form_height" /*RemoteObject*/ ),RemoteObject.createImmutable(40)}, "-",1, 1);Debug.locals.put("btnY", _btny);Debug.locals.put("btnY", _btny);
 BA.debugLineNum = 261;BA.debugLine="Dim sep2 As Pane";
Debug.ShouldStop(16);
_sep2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("sep2", _sep2);
 BA.debugLineNum = 262;BA.debugLine="sep2.Initialize(\"\")";
Debug.ShouldStop(32);
_sep2.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 263;BA.debugLine="sep2.Style = \"-fx-background-color: #E0E0E0;\"";
Debug.ShouldStop(64);
_sep2.runMethod(true,"setStyle",BA.ObjectToString("-fx-background-color: #E0E0E0;"));
 BA.debugLineNum = 264;BA.debugLine="MainPane.AddNode(sep2, 0, btnY - 7, FORM_WIDTH, 1";
Debug.ShouldStop(128);
__ref.getField(false,"_mainpane" /*RemoteObject*/ ).runVoidMethod ("AddNode",(Object)((_sep2.getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_btny,RemoteObject.createImmutable(7)}, "-",1, 1))),(Object)(BA.numberCast(double.class, __ref.getField(true,"_form_width" /*RemoteObject*/ ))),(Object)(BA.numberCast(double.class, 1)));
 BA.debugLineNum = 266;BA.debugLine="Dim btnConfirm As Button";
Debug.ShouldStop(512);
_btnconfirm = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");Debug.locals.put("btnConfirm", _btnconfirm);
 BA.debugLineNum = 267;BA.debugLine="btnConfirm.Initialize(\"btnConfirm\")";
Debug.ShouldStop(1024);
_btnconfirm.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("btnConfirm")));
 BA.debugLineNum = 268;BA.debugLine="btnConfirm.Text = \"تایید\"";
Debug.ShouldStop(2048);
_btnconfirm.runMethod(true,"setText",BA.ObjectToString("تایید"));
 BA.debugLineNum = 269;BA.debugLine="btnConfirm.Style = $\"-fx-background-color: #1976D";
Debug.ShouldStop(4096);
_btnconfirm.runMethod(true,"setStyle",(RemoteObject.concat(RemoteObject.createImmutable("-fx-background-color: #1976D2; -fx-text-fill: white; "),shamsidatepickerv3.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((__ref.getField(true,"_fnt" /*RemoteObject*/ )))),RemoteObject.createImmutable(" -fx-background-radius: 4; -fx-cursor: hand;"))));
 BA.debugLineNum = 270;BA.debugLine="MainPane.AddNode(btnConfirm, FORM_WIDTH - 90, btn";
Debug.ShouldStop(8192);
__ref.getField(false,"_mainpane" /*RemoteObject*/ ).runVoidMethod ("AddNode",(Object)((_btnconfirm.getObject())),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_form_width" /*RemoteObject*/ ),RemoteObject.createImmutable(90)}, "-",1, 1))),(Object)(BA.numberCast(double.class, _btny)),(Object)(BA.numberCast(double.class, 78)),(Object)(BA.numberCast(double.class, 30)));
 BA.debugLineNum = 272;BA.debugLine="Dim btnToday As Button";
Debug.ShouldStop(32768);
_btntoday = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");Debug.locals.put("btnToday", _btntoday);
 BA.debugLineNum = 273;BA.debugLine="btnToday.Initialize(\"btnToday\")";
Debug.ShouldStop(65536);
_btntoday.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("btnToday")));
 BA.debugLineNum = 274;BA.debugLine="btnToday.Text = \"امروز\"";
Debug.ShouldStop(131072);
_btntoday.runMethod(true,"setText",BA.ObjectToString("امروز"));
 BA.debugLineNum = 275;BA.debugLine="btnToday.Style = $\"-fx-background-color: #FF5722;";
Debug.ShouldStop(262144);
_btntoday.runMethod(true,"setStyle",(RemoteObject.concat(RemoteObject.createImmutable("-fx-background-color: #FF5722; -fx-text-fill: white; "),shamsidatepickerv3.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((__ref.getField(true,"_fnt" /*RemoteObject*/ )))),RemoteObject.createImmutable(" -fx-background-radius: 4; -fx-cursor: hand;"))));
 BA.debugLineNum = 276;BA.debugLine="MainPane.AddNode(btnToday, 12, btnY, 78, 30)";
Debug.ShouldStop(524288);
__ref.getField(false,"_mainpane" /*RemoteObject*/ ).runVoidMethod ("AddNode",(Object)((_btntoday.getObject())),(Object)(BA.numberCast(double.class, 12)),(Object)(BA.numberCast(double.class, _btny)),(Object)(BA.numberCast(double.class, 78)),(Object)(BA.numberCast(double.class, 30)));
 BA.debugLineNum = 278;BA.debugLine="RefreshStyles";
Debug.ShouldStop(2097152);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_refreshstyles" /*RemoteObject*/ );
 BA.debugLineNum = 279;BA.debugLine="End Sub";
Debug.ShouldStop(4194304);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _formatnum(RemoteObject __ref,RemoteObject _n) throws Exception{
try {
		Debug.PushSubsStack("FormatNum (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,610);
if (RapidSub.canDelegate("formatnum")) { return __ref.runUserSub(false, "shamsidatepickerv3","formatnum", __ref, _n);}
Debug.locals.put("n", _n);
 BA.debugLineNum = 610;BA.debugLine="Private Sub FormatNum(n As Int) As String";
Debug.ShouldStop(2);
 BA.debugLineNum = 611;BA.debugLine="If UsePersianDigits Then Return ToPersianDigits(n";
Debug.ShouldStop(4);
if (__ref.getField(true,"_usepersiandigits" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
if (true) return __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_topersiandigits" /*RemoteObject*/ ,(Object)(BA.NumberToString(_n)));};
 BA.debugLineNum = 612;BA.debugLine="Return n";
Debug.ShouldStop(8);
if (true) return BA.NumberToString(_n);
 BA.debugLineNum = 613;BA.debugLine="End Sub";
Debug.ShouldStop(16);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _formatnum2(RemoteObject __ref,RemoteObject _n) throws Exception{
try {
		Debug.PushSubsStack("FormatNum2 (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,615);
if (RapidSub.canDelegate("formatnum2")) { return __ref.runUserSub(false, "shamsidatepickerv3","formatnum2", __ref, _n);}
RemoteObject _s = RemoteObject.createImmutable("");
Debug.locals.put("n", _n);
 BA.debugLineNum = 615;BA.debugLine="Private Sub FormatNum2(n As Int) As String";
Debug.ShouldStop(64);
 BA.debugLineNum = 616;BA.debugLine="Dim s As String = NumberFormat2(n, 2, 0, 0, False";
Debug.ShouldStop(128);
_s = shamsidatepickerv3.__c.runMethod(true,"NumberFormat2",(Object)(BA.numberCast(double.class, _n)),(Object)(BA.numberCast(int.class, 2)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(shamsidatepickerv3.__c.getField(true,"False")));Debug.locals.put("s", _s);Debug.locals.put("s", _s);
 BA.debugLineNum = 617;BA.debugLine="If UsePersianDigits Then Return ToPersianDigits(s";
Debug.ShouldStop(256);
if (__ref.getField(true,"_usepersiandigits" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
if (true) return __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_topersiandigits" /*RemoteObject*/ ,(Object)(_s));};
 BA.debugLineNum = 618;BA.debugLine="Return s";
Debug.ShouldStop(512);
if (true) return _s;
 BA.debugLineNum = 619;BA.debugLine="End Sub";
Debug.ShouldStop(1024);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _frm_closerequest(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("frm_CloseRequest (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,389);
if (RapidSub.canDelegate("frm_closerequest")) { return __ref.runUserSub(false, "shamsidatepickerv3","frm_closerequest", __ref, _eventdata);}
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 389;BA.debugLine="Private Sub frm_CloseRequest (EventData As Event)";
Debug.ShouldStop(16);
 BA.debugLineNum = 390;BA.debugLine="If IsConfirmed = False Then";
Debug.ShouldStop(32);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_isconfirmed" /*RemoteObject*/ ),shamsidatepickerv3.__c.getField(true,"False"))) { 
 BA.debugLineNum = 391;BA.debugLine="ResultYear = 0";
Debug.ShouldStop(64);
__ref.setField ("_resultyear" /*RemoteObject*/ ,BA.numberCast(int.class, 0));
 BA.debugLineNum = 392;BA.debugLine="ResultMonth = 0";
Debug.ShouldStop(128);
__ref.setField ("_resultmonth" /*RemoteObject*/ ,BA.numberCast(int.class, 0));
 BA.debugLineNum = 393;BA.debugLine="ResultDay = 0";
Debug.ShouldStop(256);
__ref.setField ("_resultday" /*RemoteObject*/ ,BA.numberCast(int.class, 0));
 };
 BA.debugLineNum = 395;BA.debugLine="End Sub";
Debug.ShouldStop(1024);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getdayofweekname(RemoteObject __ref,RemoteObject _jy,RemoteObject _jm,RemoteObject _jd) throws Exception{
try {
		Debug.PushSubsStack("GetDayOfWeekName (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,584);
if (RapidSub.canDelegate("getdayofweekname")) { return __ref.runUserSub(false, "shamsidatepickerv3","getdayofweekname", __ref, _jy, _jm, _jd);}
Debug.locals.put("jy", _jy);
Debug.locals.put("jm", _jm);
Debug.locals.put("jd", _jd);
 BA.debugLineNum = 584;BA.debugLine="Public Sub GetDayOfWeekName(jy As Int, jm As Int,";
Debug.ShouldStop(128);
 BA.debugLineNum = 585;BA.debugLine="Return FullDayNames(GetShamsiDayOfWeek(jy, jm, jd";
Debug.ShouldStop(256);
if (true) return __ref.getField(false,"_fulldaynames" /*RemoteObject*/ ).getArrayElement(true,__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_getshamsidayofweek" /*RemoteObject*/ ,(Object)(_jy),(Object)(_jm),(Object)(_jd)));
 BA.debugLineNum = 586;BA.debugLine="End Sub";
Debug.ShouldStop(512);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getdaysinmonth(RemoteObject __ref,RemoteObject _jy,RemoteObject _jm) throws Exception{
try {
		Debug.PushSubsStack("GetDaysInMonth (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,588);
if (RapidSub.canDelegate("getdaysinmonth")) { return __ref.runUserSub(false, "shamsidatepickerv3","getdaysinmonth", __ref, _jy, _jm);}
Debug.locals.put("jy", _jy);
Debug.locals.put("jm", _jm);
 BA.debugLineNum = 588;BA.debugLine="Public Sub GetDaysInMonth(jy As Int, jm As Int) As";
Debug.ShouldStop(2048);
 BA.debugLineNum = 589;BA.debugLine="If jm <= 6 Then Return 31";
Debug.ShouldStop(4096);
if (RemoteObject.solveBoolean("k",_jm,BA.numberCast(double.class, 6))) { 
if (true) return BA.numberCast(int.class, 31);};
 BA.debugLineNum = 590;BA.debugLine="If jm <= 11 Then Return 30";
Debug.ShouldStop(8192);
if (RemoteObject.solveBoolean("k",_jm,BA.numberCast(double.class, 11))) { 
if (true) return BA.numberCast(int.class, 30);};
 BA.debugLineNum = 591;BA.debugLine="If IsLeapShamsi(jy) Then Return 30";
Debug.ShouldStop(16384);
if (__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_isleapshamsi" /*RemoteObject*/ ,(Object)(_jy)).<Boolean>get().booleanValue()) { 
if (true) return BA.numberCast(int.class, 30);};
 BA.debugLineNum = 592;BA.debugLine="Return 29";
Debug.ShouldStop(32768);
if (true) return BA.numberCast(int.class, 29);
 BA.debugLineNum = 593;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getfirstdayofweek(RemoteObject __ref,RemoteObject _jy,RemoteObject _jm) throws Exception{
try {
		Debug.PushSubsStack("GetFirstDayOfWeek (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,570);
if (RapidSub.canDelegate("getfirstdayofweek")) { return __ref.runUserSub(false, "shamsidatepickerv3","getfirstdayofweek", __ref, _jy, _jm);}
Debug.locals.put("jy", _jy);
Debug.locals.put("jm", _jm);
 BA.debugLineNum = 570;BA.debugLine="Private Sub GetFirstDayOfWeek(jy As Int, jm As Int";
Debug.ShouldStop(33554432);
 BA.debugLineNum = 571;BA.debugLine="Return GetShamsiDayOfWeek(jy, jm, 1)";
Debug.ShouldStop(67108864);
if (true) return __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_getshamsidayofweek" /*RemoteObject*/ ,(Object)(_jy),(Object)(_jm),(Object)(BA.numberCast(int.class, 1)));
 BA.debugLineNum = 572;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getscreenbounds(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("GetScreenBounds (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,153);
if (RapidSub.canDelegate("getscreenbounds")) { return __ref.runUserSub(false, "shamsidatepickerv3","getscreenbounds", __ref);}
RemoteObject _jo = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _primary = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _bounds = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _minx = RemoteObject.createImmutable(0);
RemoteObject _miny = RemoteObject.createImmutable(0);
RemoteObject _w = RemoteObject.createImmutable(0);
RemoteObject _h = RemoteObject.createImmutable(0);
 BA.debugLineNum = 153;BA.debugLine="Private Sub GetScreenBounds As Double()";
Debug.ShouldStop(16777216);
 BA.debugLineNum = 154;BA.debugLine="Dim jo As JavaObject";
Debug.ShouldStop(33554432);
_jo = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");Debug.locals.put("jo", _jo);
 BA.debugLineNum = 155;BA.debugLine="jo.InitializeStatic(\"javafx.stage.Screen\")";
Debug.ShouldStop(67108864);
_jo.runVoidMethod ("InitializeStatic",(Object)(RemoteObject.createImmutable("javafx.stage.Screen")));
 BA.debugLineNum = 156;BA.debugLine="Dim primary As JavaObject = jo.RunMethod(\"getPrim";
Debug.ShouldStop(134217728);
_primary = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_primary = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _jo.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getPrimary")),(Object)((shamsidatepickerv3.__c.getField(false,"Null")))));Debug.locals.put("primary", _primary);Debug.locals.put("primary", _primary);
 BA.debugLineNum = 157;BA.debugLine="Dim bounds As JavaObject = primary.RunMethod(\"get";
Debug.ShouldStop(268435456);
_bounds = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_bounds = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _primary.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getVisualBounds")),(Object)((shamsidatepickerv3.__c.getField(false,"Null")))));Debug.locals.put("bounds", _bounds);Debug.locals.put("bounds", _bounds);
 BA.debugLineNum = 159;BA.debugLine="Dim minX As Double = bounds.RunMethod(\"getMinX\",";
Debug.ShouldStop(1073741824);
_minx = BA.numberCast(double.class, _bounds.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getMinX")),(Object)((shamsidatepickerv3.__c.getField(false,"Null")))));Debug.locals.put("minX", _minx);Debug.locals.put("minX", _minx);
 BA.debugLineNum = 160;BA.debugLine="Dim minY As Double = bounds.RunMethod(\"getMinY\",";
Debug.ShouldStop(-2147483648);
_miny = BA.numberCast(double.class, _bounds.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getMinY")),(Object)((shamsidatepickerv3.__c.getField(false,"Null")))));Debug.locals.put("minY", _miny);Debug.locals.put("minY", _miny);
 BA.debugLineNum = 161;BA.debugLine="Dim w As Double = bounds.RunMethod(\"getWidth\", Nu";
Debug.ShouldStop(1);
_w = BA.numberCast(double.class, _bounds.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getWidth")),(Object)((shamsidatepickerv3.__c.getField(false,"Null")))));Debug.locals.put("w", _w);Debug.locals.put("w", _w);
 BA.debugLineNum = 162;BA.debugLine="Dim h As Double = bounds.RunMethod(\"getHeight\", N";
Debug.ShouldStop(2);
_h = BA.numberCast(double.class, _bounds.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getHeight")),(Object)((shamsidatepickerv3.__c.getField(false,"Null")))));Debug.locals.put("h", _h);Debug.locals.put("h", _h);
 BA.debugLineNum = 164;BA.debugLine="Return Array As Double(minX, minY, w, h)";
Debug.ShouldStop(8);
if (true) return RemoteObject.createNewArray("double",new int[] {4},new Object[] {_minx,_miny,_w,_h});
 BA.debugLineNum = 165;BA.debugLine="End Sub";
Debug.ShouldStop(16);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getselecteddatestring(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("GetSelectedDateString (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,406);
if (RapidSub.canDelegate("getselecteddatestring")) { return __ref.runUserSub(false, "shamsidatepickerv3","getselecteddatestring", __ref);}
 BA.debugLineNum = 406;BA.debugLine="Public Sub GetSelectedDateString As String";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 407;BA.debugLine="Return ResultYear & \"/\" & NumberFormat2(ResultMon";
Debug.ShouldStop(4194304);
if (true) return RemoteObject.concat(__ref.getField(true,"_resultyear" /*RemoteObject*/ ),RemoteObject.createImmutable("/"),shamsidatepickerv3.__c.runMethod(true,"NumberFormat2",(Object)(BA.numberCast(double.class, __ref.getField(true,"_resultmonth" /*RemoteObject*/ ))),(Object)(BA.numberCast(int.class, 2)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(shamsidatepickerv3.__c.getField(true,"False"))),RemoteObject.createImmutable("/"),shamsidatepickerv3.__c.runMethod(true,"NumberFormat2",(Object)(BA.numberCast(double.class, __ref.getField(true,"_resultday" /*RemoteObject*/ ))),(Object)(BA.numberCast(int.class, 2)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(shamsidatepickerv3.__c.getField(true,"False"))));
 BA.debugLineNum = 408;BA.debugLine="End Sub";
Debug.ShouldStop(8388608);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getselectedticks(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("GetSelectedTicks (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,411);
if (RapidSub.canDelegate("getselectedticks")) { return __ref.runUserSub(false, "shamsidatepickerv3","getselectedticks", __ref);}
RemoteObject _n = RemoteObject.createImmutable(0L);
 BA.debugLineNum = 411;BA.debugLine="Public Sub GetSelectedTicks As Long";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 412;BA.debugLine="Dim n As Long = DateTime.Now";
Debug.ShouldStop(134217728);
_n = shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"getNow");Debug.locals.put("n", _n);Debug.locals.put("n", _n);
 BA.debugLineNum = 413;BA.debugLine="Return ShamsiToTicksWithTime(ResultYear, ResultMo";
Debug.ShouldStop(268435456);
if (true) return __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_shamsitotickswithtime" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_resultyear" /*RemoteObject*/ )),(Object)(__ref.getField(true,"_resultmonth" /*RemoteObject*/ )),(Object)(__ref.getField(true,"_resultday" /*RemoteObject*/ )),(Object)(shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"GetHour",(Object)(_n))),(Object)(shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"GetMinute",(Object)(_n))),(Object)(shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"GetSecond",(Object)(_n))));
 BA.debugLineNum = 415;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable(0L);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getselectedticksnotime(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("GetSelectedTicksNoTime (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,418);
if (RapidSub.canDelegate("getselectedticksnotime")) { return __ref.runUserSub(false, "shamsidatepickerv3","getselectedticksnotime", __ref);}
 BA.debugLineNum = 418;BA.debugLine="Public Sub GetSelectedTicksNoTime As Long";
Debug.ShouldStop(2);
 BA.debugLineNum = 419;BA.debugLine="Return ShamsiToTicksWithTime(ResultYear, ResultMo";
Debug.ShouldStop(4);
if (true) return __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_shamsitotickswithtime" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_resultyear" /*RemoteObject*/ )),(Object)(__ref.getField(true,"_resultmonth" /*RemoteObject*/ )),(Object)(__ref.getField(true,"_resultday" /*RemoteObject*/ )),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)));
 BA.debugLineNum = 420;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable(0L);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getselectedtickswithtime(RemoteObject __ref,RemoteObject _hour,RemoteObject _minute,RemoteObject _second) throws Exception{
try {
		Debug.PushSubsStack("GetSelectedTicksWithTime (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,422);
if (RapidSub.canDelegate("getselectedtickswithtime")) { return __ref.runUserSub(false, "shamsidatepickerv3","getselectedtickswithtime", __ref, _hour, _minute, _second);}
Debug.locals.put("hour", _hour);
Debug.locals.put("minute", _minute);
Debug.locals.put("second", _second);
 BA.debugLineNum = 422;BA.debugLine="Public Sub GetSelectedTicksWithTime(hour As Int, m";
Debug.ShouldStop(32);
 BA.debugLineNum = 423;BA.debugLine="Return ShamsiToTicksWithTime(ResultYear, ResultMo";
Debug.ShouldStop(64);
if (true) return __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_shamsitotickswithtime" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_resultyear" /*RemoteObject*/ )),(Object)(__ref.getField(true,"_resultmonth" /*RemoteObject*/ )),(Object)(__ref.getField(true,"_resultday" /*RemoteObject*/ )),(Object)(_hour),(Object)(_minute),(Object)(_second));
 BA.debugLineNum = 424;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable(0L);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getshamsidayofweek(RemoteObject __ref,RemoteObject _jy,RemoteObject _jm,RemoteObject _jd) throws Exception{
try {
		Debug.PushSubsStack("GetShamsiDayOfWeek (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,575);
if (RapidSub.canDelegate("getshamsidayofweek")) { return __ref.runUserSub(false, "shamsidatepickerv3","getshamsidayofweek", __ref, _jy, _jm, _jd);}
RemoteObject _g = null;
RemoteObject _a = RemoteObject.createImmutable(0);
RemoteObject _y = RemoteObject.createImmutable(0L);
RemoteObject _m = RemoteObject.createImmutable(0);
RemoteObject _jdn = RemoteObject.createImmutable(0L);
Debug.locals.put("jy", _jy);
Debug.locals.put("jm", _jm);
Debug.locals.put("jd", _jd);
 BA.debugLineNum = 575;BA.debugLine="Public Sub GetShamsiDayOfWeek(jy As Int, jm As Int";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 576;BA.debugLine="Dim g() As Int = ShamsiToGregorian(jy, jm, jd)";
Debug.ShouldStop(-2147483648);
_g = __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_shamsitogregorian" /*RemoteObject*/ ,(Object)(_jy),(Object)(_jm),(Object)(_jd));Debug.locals.put("g", _g);Debug.locals.put("g", _g);
 BA.debugLineNum = 577;BA.debugLine="Dim a As Int = IDiv(14 - g(1), 12)";
Debug.ShouldStop(1);
_a = BA.numberCast(int.class, __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(BA.numberCast(long.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(14),_g.getArrayElement(true,BA.numberCast(int.class, 1))}, "-",1, 1))),(Object)(BA.numberCast(long.class, 12))));Debug.locals.put("a", _a);Debug.locals.put("a", _a);
 BA.debugLineNum = 578;BA.debugLine="Dim y As Long = g(0) + 4800 - a";
Debug.ShouldStop(2);
_y = BA.numberCast(long.class, RemoteObject.solve(new RemoteObject[] {_g.getArrayElement(true,BA.numberCast(int.class, 0)),RemoteObject.createImmutable(4800),_a}, "+-",2, 1));Debug.locals.put("y", _y);Debug.locals.put("y", _y);
 BA.debugLineNum = 579;BA.debugLine="Dim m As Int = g(1) + (12 * a) - 3";
Debug.ShouldStop(4);
_m = RemoteObject.solve(new RemoteObject[] {_g.getArrayElement(true,BA.numberCast(int.class, 1)),(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(12),_a}, "*",0, 1)),RemoteObject.createImmutable(3)}, "+-",2, 1);Debug.locals.put("m", _m);Debug.locals.put("m", _m);
 BA.debugLineNum = 580;BA.debugLine="Dim jdn As Long = g(2) + IDiv((153 * m) + 2, 5) +";
Debug.ShouldStop(8);
_jdn = RemoteObject.solve(new RemoteObject[] {_g.getArrayElement(true,BA.numberCast(int.class, 2)),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(BA.numberCast(long.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(153),_m}, "*",0, 1)),RemoteObject.createImmutable(2)}, "+",1, 1))),(Object)(BA.numberCast(long.class, 5))),(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(365),_y}, "*",0, 2)),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(_y),(Object)(BA.numberCast(long.class, 4))),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(_y),(Object)(BA.numberCast(long.class, 100))),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(_y),(Object)(BA.numberCast(long.class, 400))),RemoteObject.createImmutable(32045)}, "+++-+-",6, 2);Debug.locals.put("jdn", _jdn);Debug.locals.put("jdn", _jdn);
 BA.debugLineNum = 581;BA.debugLine="Return ((jdn Mod 7) + 2) Mod 7";
Debug.ShouldStop(16);
if (true) return BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_jdn,RemoteObject.createImmutable(7)}, "%",0, 2)),RemoteObject.createImmutable(2)}, "+",1, 2)),RemoteObject.createImmutable(7)}, "%",0, 2));
 BA.debugLineNum = 582;BA.debugLine="End Sub";
Debug.ShouldStop(32);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _gregoriantoshamsi(RemoteObject __ref,RemoteObject _gy,RemoteObject _gm,RemoteObject _gd) throws Exception{
try {
		Debug.PushSubsStack("GregorianToShamsi (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,481);
if (RapidSub.canDelegate("gregoriantoshamsi")) { return __ref.runUserSub(false, "shamsidatepickerv3","gregoriantoshamsi", __ref, _gy, _gm, _gd);}
RemoteObject _g_d_m = null;
RemoteObject _jy = RemoteObject.createImmutable(0);
RemoteObject _gy2 = RemoteObject.createImmutable(0);
RemoteObject _days = RemoteObject.createImmutable(0L);
RemoteObject _jm = RemoteObject.createImmutable(0);
RemoteObject _jd = RemoteObject.createImmutable(0);
Debug.locals.put("gy", _gy);
Debug.locals.put("gm", _gm);
Debug.locals.put("gd", _gd);
 BA.debugLineNum = 481;BA.debugLine="Public Sub GregorianToShamsi(gy As Int, gm As Int,";
Debug.ShouldStop(1);
 BA.debugLineNum = 482;BA.debugLine="Dim g_d_m() As Int = Array As Int(0, 31, 59, 90,";
Debug.ShouldStop(2);
_g_d_m = RemoteObject.createNewArray("int",new int[] {12},new Object[] {BA.numberCast(int.class, 0),BA.numberCast(int.class, 31),BA.numberCast(int.class, 59),BA.numberCast(int.class, 90),BA.numberCast(int.class, 120),BA.numberCast(int.class, 151),BA.numberCast(int.class, 181),BA.numberCast(int.class, 212),BA.numberCast(int.class, 243),BA.numberCast(int.class, 273),BA.numberCast(int.class, 304),BA.numberCast(int.class, 334)});Debug.locals.put("g_d_m", _g_d_m);Debug.locals.put("g_d_m", _g_d_m);
 BA.debugLineNum = 483;BA.debugLine="Dim jy As Int";
Debug.ShouldStop(4);
_jy = RemoteObject.createImmutable(0);Debug.locals.put("jy", _jy);
 BA.debugLineNum = 484;BA.debugLine="If gy > 1600 Then";
Debug.ShouldStop(8);
if (RemoteObject.solveBoolean(">",_gy,BA.numberCast(double.class, 1600))) { 
 BA.debugLineNum = 485;BA.debugLine="jy = 979";
Debug.ShouldStop(16);
_jy = BA.numberCast(int.class, 979);Debug.locals.put("jy", _jy);
 BA.debugLineNum = 486;BA.debugLine="gy = gy - 1600";
Debug.ShouldStop(32);
_gy = RemoteObject.solve(new RemoteObject[] {_gy,RemoteObject.createImmutable(1600)}, "-",1, 1);Debug.locals.put("gy", _gy);
 }else {
 BA.debugLineNum = 488;BA.debugLine="jy = 0";
Debug.ShouldStop(128);
_jy = BA.numberCast(int.class, 0);Debug.locals.put("jy", _jy);
 BA.debugLineNum = 489;BA.debugLine="gy = gy - 621";
Debug.ShouldStop(256);
_gy = RemoteObject.solve(new RemoteObject[] {_gy,RemoteObject.createImmutable(621)}, "-",1, 1);Debug.locals.put("gy", _gy);
 };
 BA.debugLineNum = 492;BA.debugLine="Dim gy2 As Int = gy";
Debug.ShouldStop(2048);
_gy2 = _gy;Debug.locals.put("gy2", _gy2);Debug.locals.put("gy2", _gy2);
 BA.debugLineNum = 493;BA.debugLine="If gm > 2 Then gy2 = gy + 1";
Debug.ShouldStop(4096);
if (RemoteObject.solveBoolean(">",_gm,BA.numberCast(double.class, 2))) { 
_gy2 = RemoteObject.solve(new RemoteObject[] {_gy,RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("gy2", _gy2);};
 BA.debugLineNum = 495;BA.debugLine="Dim days As Long = (365 * gy) + IDiv(gy2 + 3, 4)";
Debug.ShouldStop(16384);
_days = RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(365),_gy}, "*",0, 1)),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(BA.numberCast(long.class, RemoteObject.solve(new RemoteObject[] {_gy2,RemoteObject.createImmutable(3)}, "+",1, 1))),(Object)(BA.numberCast(long.class, 4))),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(BA.numberCast(long.class, RemoteObject.solve(new RemoteObject[] {_gy2,RemoteObject.createImmutable(99)}, "+",1, 1))),(Object)(BA.numberCast(long.class, 100))),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(BA.numberCast(long.class, RemoteObject.solve(new RemoteObject[] {_gy2,RemoteObject.createImmutable(399)}, "+",1, 1))),(Object)(BA.numberCast(long.class, 400))),RemoteObject.createImmutable(80),_gd,_g_d_m.getArrayElement(true,RemoteObject.solve(new RemoteObject[] {_gm,RemoteObject.createImmutable(1)}, "-",1, 1))}, "+-+-++",6, 2);Debug.locals.put("days", _days);Debug.locals.put("days", _days);
 BA.debugLineNum = 497;BA.debugLine="jy = jy + 33 * IDiv(days, 12053)";
Debug.ShouldStop(65536);
_jy = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_jy,RemoteObject.createImmutable(33),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(_days),(Object)(BA.numberCast(long.class, 12053)))}, "+*",1, 2));Debug.locals.put("jy", _jy);
 BA.debugLineNum = 498;BA.debugLine="days = days Mod 12053";
Debug.ShouldStop(131072);
_days = RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(12053)}, "%",0, 2);Debug.locals.put("days", _days);
 BA.debugLineNum = 500;BA.debugLine="jy = jy + 4 * IDiv(days, 1461)";
Debug.ShouldStop(524288);
_jy = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_jy,RemoteObject.createImmutable(4),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(_days),(Object)(BA.numberCast(long.class, 1461)))}, "+*",1, 2));Debug.locals.put("jy", _jy);
 BA.debugLineNum = 501;BA.debugLine="days = days Mod 1461";
Debug.ShouldStop(1048576);
_days = RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(1461)}, "%",0, 2);Debug.locals.put("days", _days);
 BA.debugLineNum = 503;BA.debugLine="If days > 365 Then";
Debug.ShouldStop(4194304);
if (RemoteObject.solveBoolean(">",_days,BA.numberCast(long.class, 365))) { 
 BA.debugLineNum = 504;BA.debugLine="jy = jy + IDiv(days - 1, 365)";
Debug.ShouldStop(8388608);
_jy = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_jy,__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(1)}, "-",1, 2)),(Object)(BA.numberCast(long.class, 365)))}, "+",1, 2));Debug.locals.put("jy", _jy);
 BA.debugLineNum = 505;BA.debugLine="days = (days - 1) Mod 365";
Debug.ShouldStop(16777216);
_days = RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(1)}, "-",1, 2)),RemoteObject.createImmutable(365)}, "%",0, 2);Debug.locals.put("days", _days);
 };
 BA.debugLineNum = 508;BA.debugLine="Dim jm, jd As Int";
Debug.ShouldStop(134217728);
_jm = RemoteObject.createImmutable(0);Debug.locals.put("jm", _jm);
_jd = RemoteObject.createImmutable(0);Debug.locals.put("jd", _jd);
 BA.debugLineNum = 509;BA.debugLine="If days < 186 Then";
Debug.ShouldStop(268435456);
if (RemoteObject.solveBoolean("<",_days,BA.numberCast(long.class, 186))) { 
 BA.debugLineNum = 510;BA.debugLine="jm = 1 + IDiv(days, 31)";
Debug.ShouldStop(536870912);
_jm = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(_days),(Object)(BA.numberCast(long.class, 31)))}, "+",1, 2));Debug.locals.put("jm", _jm);
 BA.debugLineNum = 511;BA.debugLine="jd = 1 + (days Mod 31)";
Debug.ShouldStop(1073741824);
_jd = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),(RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(31)}, "%",0, 2))}, "+",1, 2));Debug.locals.put("jd", _jd);
 }else {
 BA.debugLineNum = 513;BA.debugLine="jm = 7 + IDiv(days - 186, 30)";
Debug.ShouldStop(1);
_jm = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(7),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(186)}, "-",1, 2)),(Object)(BA.numberCast(long.class, 30)))}, "+",1, 2));Debug.locals.put("jm", _jm);
 BA.debugLineNum = 514;BA.debugLine="jd = 1 + ((days - 186) Mod 30)";
Debug.ShouldStop(2);
_jd = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(1),(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(186)}, "-",1, 2)),RemoteObject.createImmutable(30)}, "%",0, 2))}, "+",1, 2));Debug.locals.put("jd", _jd);
 };
 BA.debugLineNum = 517;BA.debugLine="Return Array As Int(jy, jm, jd)";
Debug.ShouldStop(16);
if (true) return RemoteObject.createNewArray("int",new int[] {3},new Object[] {_jy,_jm,_jd});
 BA.debugLineNum = 518;BA.debugLine="End Sub";
Debug.ShouldStop(32);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _idiv(RemoteObject __ref,RemoteObject _a,RemoteObject _b) throws Exception{
try {
		Debug.PushSubsStack("IDiv (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,606);
if (RapidSub.canDelegate("idiv")) { return __ref.runUserSub(false, "shamsidatepickerv3","idiv", __ref, _a, _b);}
Debug.locals.put("a", _a);
Debug.locals.put("b", _b);
 BA.debugLineNum = 606;BA.debugLine="Private Sub IDiv(a As Long, b As Long) As Long";
Debug.ShouldStop(536870912);
 BA.debugLineNum = 607;BA.debugLine="Return Floor(a / b)";
Debug.ShouldStop(1073741824);
if (true) return BA.numberCast(long.class, shamsidatepickerv3.__c.runMethod(true,"Floor",(Object)(RemoteObject.solve(new RemoteObject[] {_a,_b}, "/",0, 0))));
 BA.debugLineNum = 608;BA.debugLine="End Sub";
Debug.ShouldStop(-2147483648);
return RemoteObject.createImmutable(0L);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,31);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "shamsidatepickerv3","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 31;BA.debugLine="Public Sub Initialize";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 32;BA.debugLine="MonthNames = Array As String(\"فروردین\", \"اردیبهشت";
Debug.ShouldStop(-2147483648);
__ref.setField ("_monthnames" /*RemoteObject*/ ,RemoteObject.createNewArray("String",new int[] {12},new Object[] {BA.ObjectToString("فروردین"),BA.ObjectToString("اردیبهشت"),BA.ObjectToString("خرداد"),BA.ObjectToString("تیر"),BA.ObjectToString("مرداد"),BA.ObjectToString("شهریور"),BA.ObjectToString("مهر"),BA.ObjectToString("آبان"),BA.ObjectToString("آذر"),BA.ObjectToString("دی"),BA.ObjectToString("بهمن"),RemoteObject.createImmutable("اسفند")}));
 BA.debugLineNum = 34;BA.debugLine="DayNames = Array As String(\"ش\", \"ی\", \"د\", \"س\", \"چ";
Debug.ShouldStop(2);
__ref.setField ("_daynames" /*RemoteObject*/ ,RemoteObject.createNewArray("String",new int[] {7},new Object[] {BA.ObjectToString("ش"),BA.ObjectToString("ی"),BA.ObjectToString("د"),BA.ObjectToString("س"),BA.ObjectToString("چ"),BA.ObjectToString("پ"),RemoteObject.createImmutable("ج")}));
 BA.debugLineNum = 35;BA.debugLine="FullDayNames = Array As String(\"شنبه\", \"یکشنبه\",";
Debug.ShouldStop(4);
__ref.setField ("_fulldaynames" /*RemoteObject*/ ,RemoteObject.createNewArray("String",new int[] {7},new Object[] {BA.ObjectToString("شنبه"),BA.ObjectToString("یکشنبه"),BA.ObjectToString("دوشنبه"),BA.ObjectToString("سه‌شنبه"),BA.ObjectToString("چهارشنبه"),BA.ObjectToString("پنجشنبه"),RemoteObject.createImmutable("جمعه")}));
 BA.debugLineNum = 37;BA.debugLine="DayLabels.Initialize";
Debug.ShouldStop(16);
__ref.getField(false,"_daylabels" /*RemoteObject*/ ).runVoidMethod ("Initialize");
 BA.debugLineNum = 38;BA.debugLine="ConvertTodayToShamsi";
Debug.ShouldStop(32);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_converttodaytoshamsi" /*RemoteObject*/ );
 BA.debugLineNum = 40;BA.debugLine="CurrentYear = TodayYear";
Debug.ShouldStop(128);
__ref.setField ("_currentyear" /*RemoteObject*/ ,__ref.getField(true,"_todayyear" /*RemoteObject*/ ));
 BA.debugLineNum = 41;BA.debugLine="CurrentMonth = TodayMonth";
Debug.ShouldStop(256);
__ref.setField ("_currentmonth" /*RemoteObject*/ ,__ref.getField(true,"_todaymonth" /*RemoteObject*/ ));
 BA.debugLineNum = 42;BA.debugLine="SelectedYear = TodayYear";
Debug.ShouldStop(512);
__ref.setField ("_selectedyear" /*RemoteObject*/ ,__ref.getField(true,"_todayyear" /*RemoteObject*/ ));
 BA.debugLineNum = 43;BA.debugLine="SelectedMonth = TodayMonth";
Debug.ShouldStop(1024);
__ref.setField ("_selectedmonth" /*RemoteObject*/ ,__ref.getField(true,"_todaymonth" /*RemoteObject*/ ));
 BA.debugLineNum = 44;BA.debugLine="SelectedDay = TodayDay";
Debug.ShouldStop(2048);
__ref.setField ("_selectedday" /*RemoteObject*/ ,__ref.getField(true,"_todayday" /*RemoteObject*/ ));
 BA.debugLineNum = 45;BA.debugLine="IsConfirmed = False";
Debug.ShouldStop(4096);
__ref.setField ("_isconfirmed" /*RemoteObject*/ ,shamsidatepickerv3.__c.getField(true,"False"));
 BA.debugLineNum = 46;BA.debugLine="End Sub";
Debug.ShouldStop(8192);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _isleapshamsi(RemoteObject __ref,RemoteObject _jy) throws Exception{
try {
		Debug.PushSubsStack("IsLeapShamsi (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,595);
if (RapidSub.canDelegate("isleapshamsi")) { return __ref.runUserSub(false, "shamsidatepickerv3","isleapshamsi", __ref, _jy);}
RemoteObject _r = RemoteObject.createImmutable(0);
RemoteObject _leaps = null;
RemoteObject _l = RemoteObject.createImmutable(0);
Debug.locals.put("jy", _jy);
 BA.debugLineNum = 595;BA.debugLine="Public Sub IsLeapShamsi(jy As Int) As Boolean";
Debug.ShouldStop(262144);
 BA.debugLineNum = 596;BA.debugLine="Dim r As Int = jy Mod 33";
Debug.ShouldStop(524288);
_r = RemoteObject.solve(new RemoteObject[] {_jy,RemoteObject.createImmutable(33)}, "%",0, 1);Debug.locals.put("r", _r);Debug.locals.put("r", _r);
 BA.debugLineNum = 597;BA.debugLine="Dim leaps() As Int = Array As Int(1, 5, 9, 13, 17";
Debug.ShouldStop(1048576);
_leaps = RemoteObject.createNewArray("int",new int[] {8},new Object[] {BA.numberCast(int.class, 1),BA.numberCast(int.class, 5),BA.numberCast(int.class, 9),BA.numberCast(int.class, 13),BA.numberCast(int.class, 17),BA.numberCast(int.class, 22),BA.numberCast(int.class, 26),BA.numberCast(int.class, 30)});Debug.locals.put("leaps", _leaps);Debug.locals.put("leaps", _leaps);
 BA.debugLineNum = 598;BA.debugLine="For Each l As Int In leaps";
Debug.ShouldStop(2097152);
{
final RemoteObject group3 = _leaps;
final int groupLen3 = group3.getField(true,"length").<Integer>get()
;int index3 = 0;
;
for (; index3 < groupLen3;index3++){
_l = group3.getArrayElement(true,RemoteObject.createImmutable(index3));Debug.locals.put("l", _l);
Debug.locals.put("l", _l);
 BA.debugLineNum = 599;BA.debugLine="If r = l Then Return True";
Debug.ShouldStop(4194304);
if (RemoteObject.solveBoolean("=",_r,BA.numberCast(double.class, _l))) { 
if (true) return shamsidatepickerv3.__c.getField(true,"True");};
 }
}Debug.locals.put("l", _l);
;
 BA.debugLineNum = 601;BA.debugLine="Return False";
Debug.ShouldStop(16777216);
if (true) return shamsidatepickerv3.__c.getField(true,"False");
 BA.debugLineNum = 602;BA.debugLine="End Sub";
Debug.ShouldStop(33554432);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _positionform(RemoteObject __ref,RemoteObject _owner,RemoteObject _anchor) throws Exception{
try {
		Debug.PushSubsStack("PositionForm (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,75);
if (RapidSub.canDelegate("positionform")) { return __ref.runUserSub(false, "shamsidatepickerv3","positionform", __ref, _owner, _anchor);}
RemoteObject _x = RemoteObject.createImmutable(0);
RemoteObject _y = RemoteObject.createImmutable(0);
RemoteObject _hasowner = RemoteObject.createImmutable(false);
RemoteObject _placed = RemoteObject.createImmutable(false);
RemoteObject _jo = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _b = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _nw = RemoteObject.createImmutable(0);
RemoteObject _nh = RemoteObject.createImmutable(0);
RemoteObject _pt = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _sx = RemoteObject.createImmutable(0);
RemoteObject _sy = RemoteObject.createImmutable(0);
RemoteObject _scrbounds = null;
RemoteObject _ol = RemoteObject.createImmutable(0);
RemoteObject _ot = RemoteObject.createImmutable(0);
RemoteObject _ow = RemoteObject.createImmutable(0);
RemoteObject _oh = RemoteObject.createImmutable(0);
RemoteObject _scr = null;
RemoteObject _sl = RemoteObject.createImmutable(0);
RemoteObject _st = RemoteObject.createImmutable(0);
RemoteObject _sw = RemoteObject.createImmutable(0);
RemoteObject _sh = RemoteObject.createImmutable(0);
Debug.locals.put("owner", _owner);
Debug.locals.put("anchor", _anchor);
 BA.debugLineNum = 75;BA.debugLine="Private Sub PositionForm(owner As Form, anchor As";
Debug.ShouldStop(1024);
 BA.debugLineNum = 76;BA.debugLine="Dim x, y As Double";
Debug.ShouldStop(2048);
_x = RemoteObject.createImmutable(0);Debug.locals.put("x", _x);
_y = RemoteObject.createImmutable(0);Debug.locals.put("y", _y);
 BA.debugLineNum = 77;BA.debugLine="Dim hasOwner As Boolean = owner.IsInitialized";
Debug.ShouldStop(4096);
_hasowner = _owner.runMethod(true,"IsInitialized");Debug.locals.put("hasOwner", _hasowner);Debug.locals.put("hasOwner", _hasowner);
 BA.debugLineNum = 78;BA.debugLine="Dim placed As Boolean = False";
Debug.ShouldStop(8192);
_placed = shamsidatepickerv3.__c.getField(true,"False");Debug.locals.put("placed", _placed);Debug.locals.put("placed", _placed);
 BA.debugLineNum = 81;BA.debugLine="If anchor <> Null Then";
Debug.ShouldStop(65536);
if (RemoteObject.solveBoolean("N",_anchor)) { 
 BA.debugLineNum = 82;BA.debugLine="If anchor.IsInitialized Then";
Debug.ShouldStop(131072);
if (_anchor.runMethod(true,"IsInitialized").<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 83;BA.debugLine="Try";
Debug.ShouldStop(262144);
try { BA.debugLineNum = 84;BA.debugLine="Dim jo As JavaObject = anchor";
Debug.ShouldStop(524288);
_jo = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_jo = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _anchor.getObject());Debug.locals.put("jo", _jo);Debug.locals.put("jo", _jo);
 BA.debugLineNum = 85;BA.debugLine="Dim b As JavaObject = jo.RunMethodJO(\"getBound";
Debug.ShouldStop(1048576);
_b = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_b = _jo.runMethod(false,"RunMethodJO",(Object)(BA.ObjectToString("getBoundsInLocal")),(Object)((shamsidatepickerv3.__c.getField(false,"Null"))));Debug.locals.put("b", _b);Debug.locals.put("b", _b);
 BA.debugLineNum = 86;BA.debugLine="Dim nw As Double = b.RunMethod(\"getWidth\", Nul";
Debug.ShouldStop(2097152);
_nw = BA.numberCast(double.class, _b.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getWidth")),(Object)((shamsidatepickerv3.__c.getField(false,"Null")))));Debug.locals.put("nw", _nw);Debug.locals.put("nw", _nw);
 BA.debugLineNum = 87;BA.debugLine="Dim nh As Double = b.RunMethod(\"getHeight\", Nu";
Debug.ShouldStop(4194304);
_nh = BA.numberCast(double.class, _b.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getHeight")),(Object)((shamsidatepickerv3.__c.getField(false,"Null")))));Debug.locals.put("nh", _nh);Debug.locals.put("nh", _nh);
 BA.debugLineNum = 89;BA.debugLine="Dim pt As JavaObject = jo.RunMethodJO(\"localTo";
Debug.ShouldStop(16777216);
_pt = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_pt = _jo.runMethod(false,"RunMethodJO",(Object)(BA.ObjectToString("localToScreen")),(Object)(RemoteObject.createNewArray("Object",new int[] {2},new Object[] {RemoteObject.createImmutable((0.0)),(_nh)})));Debug.locals.put("pt", _pt);Debug.locals.put("pt", _pt);
 BA.debugLineNum = 90;BA.debugLine="Dim sx As Double = pt.RunMethod(\"getX\", Null)";
Debug.ShouldStop(33554432);
_sx = BA.numberCast(double.class, _pt.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getX")),(Object)((shamsidatepickerv3.__c.getField(false,"Null")))));Debug.locals.put("sx", _sx);Debug.locals.put("sx", _sx);
 BA.debugLineNum = 91;BA.debugLine="Dim sy As Double = pt.RunMethod(\"getY\", Null)";
Debug.ShouldStop(67108864);
_sy = BA.numberCast(double.class, _pt.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getY")),(Object)((shamsidatepickerv3.__c.getField(false,"Null")))));Debug.locals.put("sy", _sy);Debug.locals.put("sy", _sy);
 BA.debugLineNum = 93;BA.debugLine="x = sx + nw - FORM_WIDTH";
Debug.ShouldStop(268435456);
_x = RemoteObject.solve(new RemoteObject[] {_sx,_nw,__ref.getField(true,"_form_width" /*RemoteObject*/ )}, "+-",2, 0);Debug.locals.put("x", _x);
 BA.debugLineNum = 94;BA.debugLine="y = sy + 2";
Debug.ShouldStop(536870912);
_y = RemoteObject.solve(new RemoteObject[] {_sy,RemoteObject.createImmutable(2)}, "+",1, 0);Debug.locals.put("y", _y);
 BA.debugLineNum = 95;BA.debugLine="placed = True";
Debug.ShouldStop(1073741824);
_placed = shamsidatepickerv3.__c.getField(true,"True");Debug.locals.put("placed", _placed);
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e18) {
			BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e18.toString()); BA.debugLineNum = 97;BA.debugLine="placed = False";
Debug.ShouldStop(1);
_placed = shamsidatepickerv3.__c.getField(true,"False");Debug.locals.put("placed", _placed);
 };
 };
 };
 BA.debugLineNum = 103;BA.debugLine="If placed = False Then";
Debug.ShouldStop(64);
if (RemoteObject.solveBoolean("=",_placed,shamsidatepickerv3.__c.getField(true,"False"))) { 
 BA.debugLineNum = 104;BA.debugLine="If hasOwner Then";
Debug.ShouldStop(128);
if (_hasowner.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 105;BA.debugLine="x = owner.WindowLeft + (owner.WindowWidth - FOR";
Debug.ShouldStop(256);
_x = RemoteObject.solve(new RemoteObject[] {_owner.runMethod(true,"getWindowLeft"),(RemoteObject.solve(new RemoteObject[] {_owner.runMethod(true,"getWindowWidth"),__ref.getField(true,"_form_width" /*RemoteObject*/ )}, "-",1, 0)),RemoteObject.createImmutable(2)}, "+/",1, 0);Debug.locals.put("x", _x);
 BA.debugLineNum = 106;BA.debugLine="y = owner.WindowTop + (owner.WindowHeight - FOR";
Debug.ShouldStop(512);
_y = RemoteObject.solve(new RemoteObject[] {_owner.runMethod(true,"getWindowTop"),(RemoteObject.solve(new RemoteObject[] {_owner.runMethod(true,"getWindowHeight"),__ref.getField(true,"_form_height" /*RemoteObject*/ )}, "-",1, 0)),RemoteObject.createImmutable(2)}, "+/",1, 0);Debug.locals.put("y", _y);
 }else {
 BA.debugLineNum = 108;BA.debugLine="Dim scrBounds() As Double = GetScreenBounds";
Debug.ShouldStop(2048);
_scrbounds = __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_getscreenbounds" /*RemoteObject*/ );Debug.locals.put("scrBounds", _scrbounds);Debug.locals.put("scrBounds", _scrbounds);
 BA.debugLineNum = 109;BA.debugLine="x = scrBounds(0) + (scrBounds(2) - FORM_WIDTH)";
Debug.ShouldStop(4096);
_x = RemoteObject.solve(new RemoteObject[] {_scrbounds.getArrayElement(true,BA.numberCast(int.class, 0)),(RemoteObject.solve(new RemoteObject[] {_scrbounds.getArrayElement(true,BA.numberCast(int.class, 2)),__ref.getField(true,"_form_width" /*RemoteObject*/ )}, "-",1, 0)),RemoteObject.createImmutable(2)}, "+/",1, 0);Debug.locals.put("x", _x);
 BA.debugLineNum = 110;BA.debugLine="y = scrBounds(1) + (scrBounds(3) - FORM_HEIGHT)";
Debug.ShouldStop(8192);
_y = RemoteObject.solve(new RemoteObject[] {_scrbounds.getArrayElement(true,BA.numberCast(int.class, 1)),(RemoteObject.solve(new RemoteObject[] {_scrbounds.getArrayElement(true,BA.numberCast(int.class, 3)),__ref.getField(true,"_form_height" /*RemoteObject*/ )}, "-",1, 0)),RemoteObject.createImmutable(2)}, "+/",1, 0);Debug.locals.put("y", _y);
 };
 };
 BA.debugLineNum = 115;BA.debugLine="If hasOwner Then";
Debug.ShouldStop(262144);
if (_hasowner.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 116;BA.debugLine="Dim oL As Double = owner.WindowLeft";
Debug.ShouldStop(524288);
_ol = _owner.runMethod(true,"getWindowLeft");Debug.locals.put("oL", _ol);Debug.locals.put("oL", _ol);
 BA.debugLineNum = 117;BA.debugLine="Dim oT As Double = owner.WindowTop";
Debug.ShouldStop(1048576);
_ot = _owner.runMethod(true,"getWindowTop");Debug.locals.put("oT", _ot);Debug.locals.put("oT", _ot);
 BA.debugLineNum = 118;BA.debugLine="Dim oW As Double = owner.WindowWidth";
Debug.ShouldStop(2097152);
_ow = _owner.runMethod(true,"getWindowWidth");Debug.locals.put("oW", _ow);Debug.locals.put("oW", _ow);
 BA.debugLineNum = 119;BA.debugLine="Dim oH As Double = owner.WindowHeight";
Debug.ShouldStop(4194304);
_oh = _owner.runMethod(true,"getWindowHeight");Debug.locals.put("oH", _oh);Debug.locals.put("oH", _oh);
 BA.debugLineNum = 121;BA.debugLine="If oW >= FORM_WIDTH Then";
Debug.ShouldStop(16777216);
if (RemoteObject.solveBoolean("g",_ow,BA.numberCast(double.class, __ref.getField(true,"_form_width" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 122;BA.debugLine="If x < oL Then x = oL";
Debug.ShouldStop(33554432);
if (RemoteObject.solveBoolean("<",_x,_ol)) { 
_x = _ol;Debug.locals.put("x", _x);};
 BA.debugLineNum = 123;BA.debugLine="If x + FORM_WIDTH > oL + oW Then x = oL + oW -";
Debug.ShouldStop(67108864);
if (RemoteObject.solveBoolean(">",RemoteObject.solve(new RemoteObject[] {_x,__ref.getField(true,"_form_width" /*RemoteObject*/ )}, "+",1, 0),RemoteObject.solve(new RemoteObject[] {_ol,_ow}, "+",1, 0))) { 
_x = RemoteObject.solve(new RemoteObject[] {_ol,_ow,__ref.getField(true,"_form_width" /*RemoteObject*/ )}, "+-",2, 0);Debug.locals.put("x", _x);};
 }else {
 BA.debugLineNum = 125;BA.debugLine="x = oL + (oW - FORM_WIDTH) / 2";
Debug.ShouldStop(268435456);
_x = RemoteObject.solve(new RemoteObject[] {_ol,(RemoteObject.solve(new RemoteObject[] {_ow,__ref.getField(true,"_form_width" /*RemoteObject*/ )}, "-",1, 0)),RemoteObject.createImmutable(2)}, "+/",1, 0);Debug.locals.put("x", _x);
 };
 BA.debugLineNum = 128;BA.debugLine="If oH >= FORM_HEIGHT Then";
Debug.ShouldStop(-2147483648);
if (RemoteObject.solveBoolean("g",_oh,BA.numberCast(double.class, __ref.getField(true,"_form_height" /*RemoteObject*/ )))) { 
 BA.debugLineNum = 129;BA.debugLine="If y < oT Then y = oT";
Debug.ShouldStop(1);
if (RemoteObject.solveBoolean("<",_y,_ot)) { 
_y = _ot;Debug.locals.put("y", _y);};
 BA.debugLineNum = 130;BA.debugLine="If y + FORM_HEIGHT > oT + oH Then y = oT + oH -";
Debug.ShouldStop(2);
if (RemoteObject.solveBoolean(">",RemoteObject.solve(new RemoteObject[] {_y,__ref.getField(true,"_form_height" /*RemoteObject*/ )}, "+",1, 0),RemoteObject.solve(new RemoteObject[] {_ot,_oh}, "+",1, 0))) { 
_y = RemoteObject.solve(new RemoteObject[] {_ot,_oh,__ref.getField(true,"_form_height" /*RemoteObject*/ )}, "+-",2, 0);Debug.locals.put("y", _y);};
 }else {
 BA.debugLineNum = 132;BA.debugLine="y = oT + (oH - FORM_HEIGHT) / 2";
Debug.ShouldStop(8);
_y = RemoteObject.solve(new RemoteObject[] {_ot,(RemoteObject.solve(new RemoteObject[] {_oh,__ref.getField(true,"_form_height" /*RemoteObject*/ )}, "-",1, 0)),RemoteObject.createImmutable(2)}, "+/",1, 0);Debug.locals.put("y", _y);
 };
 };
 BA.debugLineNum = 137;BA.debugLine="Dim scr() As Double = GetScreenBounds";
Debug.ShouldStop(256);
_scr = __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_getscreenbounds" /*RemoteObject*/ );Debug.locals.put("scr", _scr);Debug.locals.put("scr", _scr);
 BA.debugLineNum = 138;BA.debugLine="Dim sL As Double = scr(0)";
Debug.ShouldStop(512);
_sl = _scr.getArrayElement(true,BA.numberCast(int.class, 0));Debug.locals.put("sL", _sl);Debug.locals.put("sL", _sl);
 BA.debugLineNum = 139;BA.debugLine="Dim sT As Double = scr(1)";
Debug.ShouldStop(1024);
_st = _scr.getArrayElement(true,BA.numberCast(int.class, 1));Debug.locals.put("sT", _st);Debug.locals.put("sT", _st);
 BA.debugLineNum = 140;BA.debugLine="Dim sW As Double = scr(2)";
Debug.ShouldStop(2048);
_sw = _scr.getArrayElement(true,BA.numberCast(int.class, 2));Debug.locals.put("sW", _sw);Debug.locals.put("sW", _sw);
 BA.debugLineNum = 141;BA.debugLine="Dim sH As Double = scr(3)";
Debug.ShouldStop(4096);
_sh = _scr.getArrayElement(true,BA.numberCast(int.class, 3));Debug.locals.put("sH", _sh);Debug.locals.put("sH", _sh);
 BA.debugLineNum = 143;BA.debugLine="If x < sL Then x = sL";
Debug.ShouldStop(16384);
if (RemoteObject.solveBoolean("<",_x,_sl)) { 
_x = _sl;Debug.locals.put("x", _x);};
 BA.debugLineNum = 144;BA.debugLine="If y < sT Then y = sT";
Debug.ShouldStop(32768);
if (RemoteObject.solveBoolean("<",_y,_st)) { 
_y = _st;Debug.locals.put("y", _y);};
 BA.debugLineNum = 145;BA.debugLine="If x + FORM_WIDTH > sL + sW Then x = sL + sW - FO";
Debug.ShouldStop(65536);
if (RemoteObject.solveBoolean(">",RemoteObject.solve(new RemoteObject[] {_x,__ref.getField(true,"_form_width" /*RemoteObject*/ )}, "+",1, 0),RemoteObject.solve(new RemoteObject[] {_sl,_sw}, "+",1, 0))) { 
_x = RemoteObject.solve(new RemoteObject[] {_sl,_sw,__ref.getField(true,"_form_width" /*RemoteObject*/ )}, "+-",2, 0);Debug.locals.put("x", _x);};
 BA.debugLineNum = 146;BA.debugLine="If y + FORM_HEIGHT > sT + sH Then y = sL + sH - F";
Debug.ShouldStop(131072);
if (RemoteObject.solveBoolean(">",RemoteObject.solve(new RemoteObject[] {_y,__ref.getField(true,"_form_height" /*RemoteObject*/ )}, "+",1, 0),RemoteObject.solve(new RemoteObject[] {_st,_sh}, "+",1, 0))) { 
_y = RemoteObject.solve(new RemoteObject[] {_sl,_sh,__ref.getField(true,"_form_height" /*RemoteObject*/ )}, "+-",2, 0);Debug.locals.put("y", _y);};
 BA.debugLineNum = 148;BA.debugLine="frm.WindowLeft = x";
Debug.ShouldStop(524288);
__ref.getField(false,"_frm" /*RemoteObject*/ ).runMethod(true,"setWindowLeft",_x);
 BA.debugLineNum = 149;BA.debugLine="frm.WindowTop = y";
Debug.ShouldStop(1048576);
__ref.getField(false,"_frm" /*RemoteObject*/ ).runMethod(true,"setWindowTop",_y);
 BA.debugLineNum = 150;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _refreshstyles(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("RefreshStyles (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,282);
if (RapidSub.canDelegate("refreshstyles")) { return __ref.runUserSub(false, "shamsidatepickerv3","refreshstyles", __ref);}
RemoteObject _lbl = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
RemoteObject _day = RemoteObject.createImmutable(0);
RemoteObject _col = RemoteObject.createImmutable(0);
RemoteObject _istoday = RemoteObject.createImmutable(false);
RemoteObject _issel = RemoteObject.createImmutable(false);
RemoteObject _isfri = RemoteObject.createImmutable(false);
RemoteObject _s = RemoteObject.createImmutable("");
 BA.debugLineNum = 282;BA.debugLine="Private Sub RefreshStyles";
Debug.ShouldStop(33554432);
 BA.debugLineNum = 283;BA.debugLine="lblMonthYear.Text = MonthNames(CurrentMonth - 1)";
Debug.ShouldStop(67108864);
__ref.getField(false,"_lblmonthyear" /*RemoteObject*/ ).runMethod(true,"setText",RemoteObject.concat(__ref.getField(false,"_monthnames" /*RemoteObject*/ ).getArrayElement(true,RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_currentmonth" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "-",1, 1)),RemoteObject.createImmutable("  "),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_formatnum" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_currentyear" /*RemoteObject*/ )))));
 BA.debugLineNum = 284;BA.debugLine="frm.Title = FormatNum(SelectedYear) & \"/\" & Forma";
Debug.ShouldStop(134217728);
__ref.getField(false,"_frm" /*RemoteObject*/ ).runMethod(true,"setTitle",RemoteObject.concat(__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_formatnum" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_selectedyear" /*RemoteObject*/ ))),RemoteObject.createImmutable("/"),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_formatnum2" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_selectedmonth" /*RemoteObject*/ ))),RemoteObject.createImmutable("/"),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_formatnum2" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_selectedday" /*RemoteObject*/ ))),RemoteObject.createImmutable("   -   "),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_getdayofweekname" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_selectedyear" /*RemoteObject*/ )),(Object)(__ref.getField(true,"_selectedmonth" /*RemoteObject*/ )),(Object)(__ref.getField(true,"_selectedday" /*RemoteObject*/ )))));
 BA.debugLineNum = 287;BA.debugLine="For Each lbl As Label In DayLabels";
Debug.ShouldStop(1073741824);
_lbl = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");
{
final RemoteObject group3 = __ref.getField(false,"_daylabels" /*RemoteObject*/ );
final int groupLen3 = group3.runMethod(true,"getSize").<Integer>get()
;int index3 = 0;
;
for (; index3 < groupLen3;index3++){
_lbl = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.LabelWrapper"), group3.runMethod(false,"Get",index3));Debug.locals.put("lbl", _lbl);
Debug.locals.put("lbl", _lbl);
 BA.debugLineNum = 288;BA.debugLine="Dim day As Int = lbl.Tag";
Debug.ShouldStop(-2147483648);
_day = BA.numberCast(int.class, _lbl.runMethod(false,"getTag"));Debug.locals.put("day", _day);Debug.locals.put("day", _day);
 BA.debugLineNum = 289;BA.debugLine="Dim col As Int = (FirstDow + day - 1) Mod 7";
Debug.ShouldStop(1);
_col = RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_firstdow" /*RemoteObject*/ ),_day,RemoteObject.createImmutable(1)}, "+-",2, 1)),RemoteObject.createImmutable(7)}, "%",0, 1);Debug.locals.put("col", _col);Debug.locals.put("col", _col);
 BA.debugLineNum = 291;BA.debugLine="Dim isToday As Boolean = (day = TodayDay And Cur";
Debug.ShouldStop(4);
_istoday = BA.ObjectToBoolean((RemoteObject.solveBoolean("=",_day,BA.numberCast(double.class, __ref.getField(true,"_todayday" /*RemoteObject*/ ))) && RemoteObject.solveBoolean("=",__ref.getField(true,"_currentmonth" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(true,"_todaymonth" /*RemoteObject*/ ))) && RemoteObject.solveBoolean("=",__ref.getField(true,"_currentyear" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(true,"_todayyear" /*RemoteObject*/ )))));Debug.locals.put("isToday", _istoday);Debug.locals.put("isToday", _istoday);
 BA.debugLineNum = 292;BA.debugLine="Dim isSel   As Boolean = (day = SelectedDay And";
Debug.ShouldStop(8);
_issel = BA.ObjectToBoolean((RemoteObject.solveBoolean("=",_day,BA.numberCast(double.class, __ref.getField(true,"_selectedday" /*RemoteObject*/ ))) && RemoteObject.solveBoolean("=",__ref.getField(true,"_currentmonth" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(true,"_selectedmonth" /*RemoteObject*/ ))) && RemoteObject.solveBoolean("=",__ref.getField(true,"_currentyear" /*RemoteObject*/ ),BA.numberCast(double.class, __ref.getField(true,"_selectedyear" /*RemoteObject*/ )))));Debug.locals.put("isSel", _issel);Debug.locals.put("isSel", _issel);
 BA.debugLineNum = 293;BA.debugLine="Dim isFri   As Boolean = (col = 6)";
Debug.ShouldStop(16);
_isfri = BA.ObjectToBoolean((RemoteObject.solveBoolean("=",_col,BA.numberCast(double.class, 6))));Debug.locals.put("isFri", _isfri);Debug.locals.put("isFri", _isfri);
 BA.debugLineNum = 295;BA.debugLine="Dim s As String = $\"${FNT} -fx-cursor: hand; -fx";
Debug.ShouldStop(64);
_s = (RemoteObject.concat(RemoteObject.createImmutable(""),shamsidatepickerv3.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((__ref.getField(true,"_fnt" /*RemoteObject*/ )))),RemoteObject.createImmutable(" -fx-cursor: hand; -fx-background-radius: "),shamsidatepickerv3.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_cell_size" /*RemoteObject*/ ),RemoteObject.createImmutable(2)}, "/",0, 0)))),RemoteObject.createImmutable(";")));Debug.locals.put("s", _s);Debug.locals.put("s", _s);
 BA.debugLineNum = 297;BA.debugLine="If isSel And isToday Then";
Debug.ShouldStop(256);
if (RemoteObject.solveBoolean(".",_issel) && RemoteObject.solveBoolean(".",_istoday)) { 
 BA.debugLineNum = 298;BA.debugLine="s = s & $\" -fx-background-color: #1976D2; -fx-t";
Debug.ShouldStop(512);
_s = RemoteObject.concat(_s,(RemoteObject.concat(RemoteObject.createImmutable(" -fx-background-color: #1976D2; -fx-text-fill: white; -fx-font-weight: bold; -fx-border-color: #FF5722; -fx-border-width: 2; -fx-border-radius: "),shamsidatepickerv3.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_cell_size" /*RemoteObject*/ ),RemoteObject.createImmutable(2)}, "/",0, 0)))),RemoteObject.createImmutable(";"))));Debug.locals.put("s", _s);
 }else 
{ BA.debugLineNum = 299;BA.debugLine="Else If isSel Then";
Debug.ShouldStop(1024);
if (_issel.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 300;BA.debugLine="s = s & \" -fx-background-color: #1976D2; -fx-te";
Debug.ShouldStop(2048);
_s = RemoteObject.concat(_s,RemoteObject.createImmutable(" -fx-background-color: #1976D2; -fx-text-fill: white; -fx-font-weight: bold;"));Debug.locals.put("s", _s);
 }else 
{ BA.debugLineNum = 301;BA.debugLine="Else If isToday Then";
Debug.ShouldStop(4096);
if (_istoday.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 302;BA.debugLine="s = s & $\" -fx-border-color: #FF5722; -fx-borde";
Debug.ShouldStop(8192);
_s = RemoteObject.concat(_s,(RemoteObject.concat(RemoteObject.createImmutable(" -fx-border-color: #FF5722; -fx-border-width: 2; -fx-border-radius: "),shamsidatepickerv3.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((RemoteObject.solve(new RemoteObject[] {__ref.getField(true,"_cell_size" /*RemoteObject*/ ),RemoteObject.createImmutable(2)}, "/",0, 0)))),RemoteObject.createImmutable("; -fx-text-fill: #FF5722; -fx-font-weight: bold;"))));Debug.locals.put("s", _s);
 }else 
{ BA.debugLineNum = 303;BA.debugLine="Else If isFri Then";
Debug.ShouldStop(16384);
if (_isfri.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 304;BA.debugLine="s = s & \" -fx-text-fill: #E53935;\"";
Debug.ShouldStop(32768);
_s = RemoteObject.concat(_s,RemoteObject.createImmutable(" -fx-text-fill: #E53935;"));Debug.locals.put("s", _s);
 }else {
 BA.debugLineNum = 306;BA.debugLine="s = s & \" -fx-text-fill: #333333;\"";
Debug.ShouldStop(131072);
_s = RemoteObject.concat(_s,RemoteObject.createImmutable(" -fx-text-fill: #333333;"));Debug.locals.put("s", _s);
 }}}}
;
 BA.debugLineNum = 309;BA.debugLine="lbl.Style = s";
Debug.ShouldStop(1048576);
_lbl.runMethod(true,"setStyle",_s);
 }
}Debug.locals.put("lbl", _lbl);
;
 BA.debugLineNum = 311;BA.debugLine="End Sub";
Debug.ShouldStop(4194304);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setdate(RemoteObject __ref,RemoteObject _year,RemoteObject _month,RemoteObject _day) throws Exception{
try {
		Debug.PushSubsStack("SetDate (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,458);
if (RapidSub.canDelegate("setdate")) { return __ref.runUserSub(false, "shamsidatepickerv3","setdate", __ref, _year, _month, _day);}
Debug.locals.put("year", _year);
Debug.locals.put("month", _month);
Debug.locals.put("day", _day);
 BA.debugLineNum = 458;BA.debugLine="Public Sub SetDate(year As Int, month As Int, day";
Debug.ShouldStop(512);
 BA.debugLineNum = 459;BA.debugLine="SelectedYear = year";
Debug.ShouldStop(1024);
__ref.setField ("_selectedyear" /*RemoteObject*/ ,_year);
 BA.debugLineNum = 460;BA.debugLine="SelectedMonth = month";
Debug.ShouldStop(2048);
__ref.setField ("_selectedmonth" /*RemoteObject*/ ,_month);
 BA.debugLineNum = 461;BA.debugLine="SelectedDay = day";
Debug.ShouldStop(4096);
__ref.setField ("_selectedday" /*RemoteObject*/ ,_day);
 BA.debugLineNum = 462;BA.debugLine="CurrentYear = year";
Debug.ShouldStop(8192);
__ref.setField ("_currentyear" /*RemoteObject*/ ,_year);
 BA.debugLineNum = 463;BA.debugLine="CurrentMonth = month";
Debug.ShouldStop(16384);
__ref.setField ("_currentmonth" /*RemoteObject*/ ,_month);
 BA.debugLineNum = 464;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setdatefromticks(RemoteObject __ref,RemoteObject _ticks) throws Exception{
try {
		Debug.PushSubsStack("SetDateFromTicks (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,466);
if (RapidSub.canDelegate("setdatefromticks")) { return __ref.runUserSub(false, "shamsidatepickerv3","setdatefromticks", __ref, _ticks);}
RemoteObject _j = null;
Debug.locals.put("ticks", _ticks);
 BA.debugLineNum = 466;BA.debugLine="Public Sub SetDateFromTicks(ticks As Long)";
Debug.ShouldStop(131072);
 BA.debugLineNum = 467;BA.debugLine="Dim j() As Int = TicksToShamsi(ticks)";
Debug.ShouldStop(262144);
_j = __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_tickstoshamsi" /*RemoteObject*/ ,(Object)(_ticks));Debug.locals.put("j", _j);Debug.locals.put("j", _j);
 BA.debugLineNum = 468;BA.debugLine="SetDate(j(0), j(1), j(2))";
Debug.ShouldStop(524288);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_setdate" /*RemoteObject*/ ,(Object)(_j.getArrayElement(true,BA.numberCast(int.class, 0))),(Object)(_j.getArrayElement(true,BA.numberCast(int.class, 1))),(Object)(_j.getArrayElement(true,BA.numberCast(int.class, 2))));
 BA.debugLineNum = 469;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _shamsitogregorian(RemoteObject __ref,RemoteObject _jy,RemoteObject _jm,RemoteObject _jd) throws Exception{
try {
		Debug.PushSubsStack("ShamsiToGregorian (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,520);
if (RapidSub.canDelegate("shamsitogregorian")) { return __ref.runUserSub(false, "shamsidatepickerv3","shamsitogregorian", __ref, _jy, _jm, _jd);}
RemoteObject _gy = RemoteObject.createImmutable(0);
RemoteObject _mdays = RemoteObject.createImmutable(0);
RemoteObject _days = RemoteObject.createImmutable(0L);
RemoteObject _leap = RemoteObject.createImmutable(0);
RemoteObject _md = null;
RemoteObject _gd = RemoteObject.createImmutable(0);
RemoteObject _gm = RemoteObject.createImmutable(0);
Debug.locals.put("jy", _jy);
Debug.locals.put("jm", _jm);
Debug.locals.put("jd", _jd);
 BA.debugLineNum = 520;BA.debugLine="Public Sub ShamsiToGregorian(jy As Int, jm As Int,";
Debug.ShouldStop(128);
 BA.debugLineNum = 521;BA.debugLine="Dim gy As Int";
Debug.ShouldStop(256);
_gy = RemoteObject.createImmutable(0);Debug.locals.put("gy", _gy);
 BA.debugLineNum = 522;BA.debugLine="If jy > 979 Then";
Debug.ShouldStop(512);
if (RemoteObject.solveBoolean(">",_jy,BA.numberCast(double.class, 979))) { 
 BA.debugLineNum = 523;BA.debugLine="gy = 1600";
Debug.ShouldStop(1024);
_gy = BA.numberCast(int.class, 1600);Debug.locals.put("gy", _gy);
 BA.debugLineNum = 524;BA.debugLine="jy = jy - 979";
Debug.ShouldStop(2048);
_jy = RemoteObject.solve(new RemoteObject[] {_jy,RemoteObject.createImmutable(979)}, "-",1, 1);Debug.locals.put("jy", _jy);
 }else {
 BA.debugLineNum = 526;BA.debugLine="gy = 621";
Debug.ShouldStop(8192);
_gy = BA.numberCast(int.class, 621);Debug.locals.put("gy", _gy);
 };
 BA.debugLineNum = 529;BA.debugLine="Dim mDays As Int";
Debug.ShouldStop(65536);
_mdays = RemoteObject.createImmutable(0);Debug.locals.put("mDays", _mdays);
 BA.debugLineNum = 530;BA.debugLine="If jm < 7 Then";
Debug.ShouldStop(131072);
if (RemoteObject.solveBoolean("<",_jm,BA.numberCast(double.class, 7))) { 
 BA.debugLineNum = 531;BA.debugLine="mDays = (jm - 1) * 31";
Debug.ShouldStop(262144);
_mdays = RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_jm,RemoteObject.createImmutable(1)}, "-",1, 1)),RemoteObject.createImmutable(31)}, "*",0, 1);Debug.locals.put("mDays", _mdays);
 }else {
 BA.debugLineNum = 533;BA.debugLine="mDays = ((jm - 7) * 30) + 186";
Debug.ShouldStop(1048576);
_mdays = RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_jm,RemoteObject.createImmutable(7)}, "-",1, 1)),RemoteObject.createImmutable(30)}, "*",0, 1)),RemoteObject.createImmutable(186)}, "+",1, 1);Debug.locals.put("mDays", _mdays);
 };
 BA.debugLineNum = 536;BA.debugLine="Dim days As Long = (365 * jy) + (IDiv(jy, 33) * 8";
Debug.ShouldStop(8388608);
_days = RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(365),_jy}, "*",0, 1)),(RemoteObject.solve(new RemoteObject[] {__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(BA.numberCast(long.class, _jy)),(Object)(BA.numberCast(long.class, 33))),RemoteObject.createImmutable(8)}, "*",0, 2)),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(BA.numberCast(long.class, RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_jy,RemoteObject.createImmutable(33)}, "%",0, 1)),RemoteObject.createImmutable(3)}, "+",1, 1))),(Object)(BA.numberCast(long.class, 4))),RemoteObject.createImmutable(78),_jd,_mdays}, "+++++",5, 2);Debug.locals.put("days", _days);Debug.locals.put("days", _days);
 BA.debugLineNum = 538;BA.debugLine="gy = gy + 400 * IDiv(days, 146097)";
Debug.ShouldStop(33554432);
_gy = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_gy,RemoteObject.createImmutable(400),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(_days),(Object)(BA.numberCast(long.class, 146097)))}, "+*",1, 2));Debug.locals.put("gy", _gy);
 BA.debugLineNum = 539;BA.debugLine="days = days Mod 146097";
Debug.ShouldStop(67108864);
_days = RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(146097)}, "%",0, 2);Debug.locals.put("days", _days);
 BA.debugLineNum = 541;BA.debugLine="If days > 36524 Then";
Debug.ShouldStop(268435456);
if (RemoteObject.solveBoolean(">",_days,BA.numberCast(long.class, 36524))) { 
 BA.debugLineNum = 542;BA.debugLine="days = days - 1";
Debug.ShouldStop(536870912);
_days = RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(1)}, "-",1, 2);Debug.locals.put("days", _days);
 BA.debugLineNum = 543;BA.debugLine="gy = gy + 100 * IDiv(days, 36524)";
Debug.ShouldStop(1073741824);
_gy = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_gy,RemoteObject.createImmutable(100),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(_days),(Object)(BA.numberCast(long.class, 36524)))}, "+*",1, 2));Debug.locals.put("gy", _gy);
 BA.debugLineNum = 544;BA.debugLine="days = days Mod 36524";
Debug.ShouldStop(-2147483648);
_days = RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(36524)}, "%",0, 2);Debug.locals.put("days", _days);
 BA.debugLineNum = 545;BA.debugLine="If days >= 365 Then days = days + 1";
Debug.ShouldStop(1);
if (RemoteObject.solveBoolean("g",_days,BA.numberCast(long.class, 365))) { 
_days = RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(1)}, "+",1, 2);Debug.locals.put("days", _days);};
 };
 BA.debugLineNum = 548;BA.debugLine="gy = gy + 4 * IDiv(days, 1461)";
Debug.ShouldStop(8);
_gy = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_gy,RemoteObject.createImmutable(4),__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(_days),(Object)(BA.numberCast(long.class, 1461)))}, "+*",1, 2));Debug.locals.put("gy", _gy);
 BA.debugLineNum = 549;BA.debugLine="days = days Mod 1461";
Debug.ShouldStop(16);
_days = RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(1461)}, "%",0, 2);Debug.locals.put("days", _days);
 BA.debugLineNum = 551;BA.debugLine="If days > 365 Then";
Debug.ShouldStop(64);
if (RemoteObject.solveBoolean(">",_days,BA.numberCast(long.class, 365))) { 
 BA.debugLineNum = 552;BA.debugLine="gy = gy + IDiv(days - 1, 365)";
Debug.ShouldStop(128);
_gy = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_gy,__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_idiv" /*RemoteObject*/ ,(Object)(RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(1)}, "-",1, 2)),(Object)(BA.numberCast(long.class, 365)))}, "+",1, 2));Debug.locals.put("gy", _gy);
 BA.debugLineNum = 553;BA.debugLine="days = (days - 1) Mod 365";
Debug.ShouldStop(256);
_days = RemoteObject.solve(new RemoteObject[] {(RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(1)}, "-",1, 2)),RemoteObject.createImmutable(365)}, "%",0, 2);Debug.locals.put("days", _days);
 };
 BA.debugLineNum = 556;BA.debugLine="Dim leap As Int = 0";
Debug.ShouldStop(2048);
_leap = BA.numberCast(int.class, 0);Debug.locals.put("leap", _leap);Debug.locals.put("leap", _leap);
 BA.debugLineNum = 557;BA.debugLine="If (gy Mod 4 = 0 And gy Mod 100 <> 0) Or (gy Mod";
Debug.ShouldStop(4096);
if (RemoteObject.solveBoolean(".",BA.ObjectToBoolean((RemoteObject.solveBoolean("=",RemoteObject.solve(new RemoteObject[] {_gy,RemoteObject.createImmutable(4)}, "%",0, 1),BA.numberCast(double.class, 0)) && RemoteObject.solveBoolean("!",RemoteObject.solve(new RemoteObject[] {_gy,RemoteObject.createImmutable(100)}, "%",0, 1),BA.numberCast(double.class, 0))))) || RemoteObject.solveBoolean(".",BA.ObjectToBoolean((RemoteObject.solveBoolean("=",RemoteObject.solve(new RemoteObject[] {_gy,RemoteObject.createImmutable(400)}, "%",0, 1),BA.numberCast(double.class, 0)))))) { 
_leap = BA.numberCast(int.class, 1);Debug.locals.put("leap", _leap);};
 BA.debugLineNum = 558;BA.debugLine="Dim md() As Int = Array As Int(31, 28 + leap, 31,";
Debug.ShouldStop(8192);
_md = RemoteObject.createNewArray("int",new int[] {12},new Object[] {BA.numberCast(int.class, 31),RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(28),_leap}, "+",1, 1),BA.numberCast(int.class, 31),BA.numberCast(int.class, 30),BA.numberCast(int.class, 31),BA.numberCast(int.class, 30),BA.numberCast(int.class, 31),BA.numberCast(int.class, 31),BA.numberCast(int.class, 30),BA.numberCast(int.class, 31),BA.numberCast(int.class, 30),BA.numberCast(int.class, 31)});Debug.locals.put("md", _md);Debug.locals.put("md", _md);
 BA.debugLineNum = 560;BA.debugLine="Dim gd As Int = days + 1";
Debug.ShouldStop(32768);
_gd = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_days,RemoteObject.createImmutable(1)}, "+",1, 2));Debug.locals.put("gd", _gd);Debug.locals.put("gd", _gd);
 BA.debugLineNum = 561;BA.debugLine="Dim gm As Int = 0";
Debug.ShouldStop(65536);
_gm = BA.numberCast(int.class, 0);Debug.locals.put("gm", _gm);Debug.locals.put("gm", _gm);
 BA.debugLineNum = 562;BA.debugLine="Do While gm < 12 And gd > md(gm)";
Debug.ShouldStop(131072);
while (RemoteObject.solveBoolean("<",_gm,BA.numberCast(double.class, 12)) && RemoteObject.solveBoolean(">",_gd,BA.numberCast(double.class, _md.getArrayElement(true,_gm)))) {
 BA.debugLineNum = 563;BA.debugLine="gd = gd - md(gm)";
Debug.ShouldStop(262144);
_gd = RemoteObject.solve(new RemoteObject[] {_gd,_md.getArrayElement(true,_gm)}, "-",1, 1);Debug.locals.put("gd", _gd);
 BA.debugLineNum = 564;BA.debugLine="gm = gm + 1";
Debug.ShouldStop(524288);
_gm = RemoteObject.solve(new RemoteObject[] {_gm,RemoteObject.createImmutable(1)}, "+",1, 1);Debug.locals.put("gm", _gm);
 }
;
 BA.debugLineNum = 567;BA.debugLine="Return Array As Int(gy, gm + 1, gd)";
Debug.ShouldStop(4194304);
if (true) return RemoteObject.createNewArray("int",new int[] {3},new Object[] {_gy,RemoteObject.solve(new RemoteObject[] {_gm,RemoteObject.createImmutable(1)}, "+",1, 1),_gd});
 BA.debugLineNum = 568;BA.debugLine="End Sub";
Debug.ShouldStop(8388608);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _shamsitoticks(RemoteObject __ref,RemoteObject _jy,RemoteObject _jm,RemoteObject _jd) throws Exception{
try {
		Debug.PushSubsStack("ShamsiToTicks (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,426);
if (RapidSub.canDelegate("shamsitoticks")) { return __ref.runUserSub(false, "shamsidatepickerv3","shamsitoticks", __ref, _jy, _jm, _jd);}
RemoteObject _n = RemoteObject.createImmutable(0L);
Debug.locals.put("jy", _jy);
Debug.locals.put("jm", _jm);
Debug.locals.put("jd", _jd);
 BA.debugLineNum = 426;BA.debugLine="Public Sub ShamsiToTicks(jy As Int, jm As Int, jd";
Debug.ShouldStop(512);
 BA.debugLineNum = 427;BA.debugLine="Dim n As Long = DateTime.Now";
Debug.ShouldStop(1024);
_n = shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"getNow");Debug.locals.put("n", _n);Debug.locals.put("n", _n);
 BA.debugLineNum = 428;BA.debugLine="Return ShamsiToTicksWithTime(jy, jm, jd, DateTime";
Debug.ShouldStop(2048);
if (true) return __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_shamsitotickswithtime" /*RemoteObject*/ ,(Object)(_jy),(Object)(_jm),(Object)(_jd),(Object)(shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"GetHour",(Object)(_n))),(Object)(shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"GetMinute",(Object)(_n))),(Object)(shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"GetSecond",(Object)(_n))));
 BA.debugLineNum = 429;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
return RemoteObject.createImmutable(0L);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _shamsitotickswithtime(RemoteObject __ref,RemoteObject _jy,RemoteObject _jm,RemoteObject _jd,RemoteObject _hour,RemoteObject _minute,RemoteObject _second) throws Exception{
try {
		Debug.PushSubsStack("ShamsiToTicksWithTime (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,431);
if (RapidSub.canDelegate("shamsitotickswithtime")) { return __ref.runUserSub(false, "shamsidatepickerv3","shamsitotickswithtime", __ref, _jy, _jm, _jd, _hour, _minute, _second);}
RemoteObject _g = null;
RemoteObject _pd = RemoteObject.createImmutable("");
RemoteObject _pt = RemoteObject.createImmutable("");
RemoteObject _ds = RemoteObject.createImmutable("");
RemoteObject _ts = RemoteObject.createImmutable("");
RemoteObject _ticks = RemoteObject.createImmutable(0L);
Debug.locals.put("jy", _jy);
Debug.locals.put("jm", _jm);
Debug.locals.put("jd", _jd);
Debug.locals.put("hour", _hour);
Debug.locals.put("minute", _minute);
Debug.locals.put("second", _second);
 BA.debugLineNum = 431;BA.debugLine="Public Sub ShamsiToTicksWithTime(jy As Int, jm As";
Debug.ShouldStop(16384);
 BA.debugLineNum = 432;BA.debugLine="Dim g() As Int = ShamsiToGregorian(jy, jm, jd)";
Debug.ShouldStop(32768);
_g = __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_shamsitogregorian" /*RemoteObject*/ ,(Object)(_jy),(Object)(_jm),(Object)(_jd));Debug.locals.put("g", _g);Debug.locals.put("g", _g);
 BA.debugLineNum = 434;BA.debugLine="Dim pd As String = DateTime.DateFormat";
Debug.ShouldStop(131072);
_pd = shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"getDateFormat");Debug.locals.put("pd", _pd);Debug.locals.put("pd", _pd);
 BA.debugLineNum = 435;BA.debugLine="Dim pt As String = DateTime.TimeFormat";
Debug.ShouldStop(262144);
_pt = shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"getTimeFormat");Debug.locals.put("pt", _pt);Debug.locals.put("pt", _pt);
 BA.debugLineNum = 436;BA.debugLine="DateTime.DateFormat = \"yyyy/MM/dd\"";
Debug.ShouldStop(524288);
shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"setDateFormat",BA.ObjectToString("yyyy/MM/dd"));
 BA.debugLineNum = 437;BA.debugLine="DateTime.TimeFormat = \"HH:mm:ss\"";
Debug.ShouldStop(1048576);
shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"setTimeFormat",BA.ObjectToString("HH:mm:ss"));
 BA.debugLineNum = 439;BA.debugLine="Dim ds As String = g(0) & \"/\" & NumberFormat2(g(1";
Debug.ShouldStop(4194304);
_ds = RemoteObject.concat(_g.getArrayElement(true,BA.numberCast(int.class, 0)),RemoteObject.createImmutable("/"),shamsidatepickerv3.__c.runMethod(true,"NumberFormat2",(Object)(BA.numberCast(double.class, _g.getArrayElement(true,BA.numberCast(int.class, 1)))),(Object)(BA.numberCast(int.class, 2)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(shamsidatepickerv3.__c.getField(true,"False"))),RemoteObject.createImmutable("/"),shamsidatepickerv3.__c.runMethod(true,"NumberFormat2",(Object)(BA.numberCast(double.class, _g.getArrayElement(true,BA.numberCast(int.class, 2)))),(Object)(BA.numberCast(int.class, 2)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(shamsidatepickerv3.__c.getField(true,"False"))));Debug.locals.put("ds", _ds);Debug.locals.put("ds", _ds);
 BA.debugLineNum = 440;BA.debugLine="Dim ts As String = NumberFormat2(hour, 2, 0, 0, F";
Debug.ShouldStop(8388608);
_ts = RemoteObject.concat(shamsidatepickerv3.__c.runMethod(true,"NumberFormat2",(Object)(BA.numberCast(double.class, _hour)),(Object)(BA.numberCast(int.class, 2)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(shamsidatepickerv3.__c.getField(true,"False"))),RemoteObject.createImmutable(":"),shamsidatepickerv3.__c.runMethod(true,"NumberFormat2",(Object)(BA.numberCast(double.class, _minute)),(Object)(BA.numberCast(int.class, 2)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(shamsidatepickerv3.__c.getField(true,"False"))),RemoteObject.createImmutable(":"),shamsidatepickerv3.__c.runMethod(true,"NumberFormat2",(Object)(BA.numberCast(double.class, _second)),(Object)(BA.numberCast(int.class, 2)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(shamsidatepickerv3.__c.getField(true,"False"))));Debug.locals.put("ts", _ts);Debug.locals.put("ts", _ts);
 BA.debugLineNum = 442;BA.debugLine="Dim ticks As Long = DateTime.DateTimeParse(ds, ts";
Debug.ShouldStop(33554432);
_ticks = shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"DateTimeParse",(Object)(_ds),(Object)(_ts));Debug.locals.put("ticks", _ticks);Debug.locals.put("ticks", _ticks);
 BA.debugLineNum = 444;BA.debugLine="DateTime.DateFormat = pd";
Debug.ShouldStop(134217728);
shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"setDateFormat",_pd);
 BA.debugLineNum = 445;BA.debugLine="DateTime.TimeFormat = pt";
Debug.ShouldStop(268435456);
shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"setTimeFormat",_pt);
 BA.debugLineNum = 446;BA.debugLine="Return ticks";
Debug.ShouldStop(536870912);
if (true) return _ticks;
 BA.debugLineNum = 447;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable(0L);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _show(RemoteObject __ref,RemoteObject _owner) throws Exception{
try {
		Debug.PushSubsStack("Show (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,51);
if (RapidSub.canDelegate("show")) { return __ref.runUserSub(false, "shamsidatepickerv3","show", __ref, _owner);}
Debug.locals.put("owner", _owner);
 BA.debugLineNum = 51;BA.debugLine="Public Sub Show(owner As Form) As Boolean";
Debug.ShouldStop(262144);
 BA.debugLineNum = 52;BA.debugLine="Return ShowAt(owner, Null)";
Debug.ShouldStop(524288);
if (true) return __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_showat" /*RemoteObject*/ ,(Object)(_owner),RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper"), shamsidatepickerv3.__c.getField(false,"Null")));
 BA.debugLineNum = 53;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _showat(RemoteObject __ref,RemoteObject _owner,RemoteObject _anchor) throws Exception{
try {
		Debug.PushSubsStack("ShowAt (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,56);
if (RapidSub.canDelegate("showat")) { return __ref.runUserSub(false, "shamsidatepickerv3","showat", __ref, _owner, _anchor);}
Debug.locals.put("owner", _owner);
Debug.locals.put("anchor", _anchor);
 BA.debugLineNum = 56;BA.debugLine="Public Sub ShowAt(owner As Form, anchor As Node) A";
Debug.ShouldStop(8388608);
 BA.debugLineNum = 57;BA.debugLine="IsConfirmed = False";
Debug.ShouldStop(16777216);
__ref.setField ("_isconfirmed" /*RemoteObject*/ ,shamsidatepickerv3.__c.getField(true,"False"));
 BA.debugLineNum = 59;BA.debugLine="frm.Initialize(\"frm\", FORM_WIDTH, FORM_HEIGHT)";
Debug.ShouldStop(67108864);
__ref.getField(false,"_frm" /*RemoteObject*/ ).runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(BA.ObjectToString("frm")),(Object)(BA.numberCast(double.class, __ref.getField(true,"_form_width" /*RemoteObject*/ ))),(Object)(BA.numberCast(double.class, __ref.getField(true,"_form_height" /*RemoteObject*/ ))));
 BA.debugLineNum = 60;BA.debugLine="frm.Resizable = False";
Debug.ShouldStop(134217728);
__ref.getField(false,"_frm" /*RemoteObject*/ ).runMethod(true,"setResizable",shamsidatepickerv3.__c.getField(true,"False"));
 BA.debugLineNum = 61;BA.debugLine="If owner.IsInitialized Then frm.SetOwner(owner)";
Debug.ShouldStop(268435456);
if (_owner.runMethod(true,"IsInitialized").<Boolean>get().booleanValue()) { 
__ref.getField(false,"_frm" /*RemoteObject*/ ).runVoidMethod ("SetOwner",(Object)(_owner));};
 BA.debugLineNum = 63;BA.debugLine="MainPane = frm.RootPane";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_mainpane" /*RemoteObject*/ ).setObject (__ref.getField(false,"_frm" /*RemoteObject*/ ).runMethod(false,"getRootPane").getObject());
 BA.debugLineNum = 64;BA.debugLine="MainPane.Style = \"-fx-background-color: #FFFFFF;\"";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_mainpane" /*RemoteObject*/ ).runMethod(true,"setStyle",BA.ObjectToString("-fx-background-color: #FFFFFF;"));
 BA.debugLineNum = 66;BA.debugLine="DrawCalendar";
Debug.ShouldStop(2);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_drawcalendar" /*RemoteObject*/ );
 BA.debugLineNum = 67;BA.debugLine="PositionForm(owner, anchor)";
Debug.ShouldStop(4);
__ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_positionform" /*RemoteObject*/ ,(Object)(_owner),(Object)(_anchor));
 BA.debugLineNum = 69;BA.debugLine="frm.ShowAndWait";
Debug.ShouldStop(16);
__ref.getField(false,"_frm" /*RemoteObject*/ ).runVoidMethodAndSync ("ShowAndWait");
 BA.debugLineNum = 70;BA.debugLine="Return IsConfirmed";
Debug.ShouldStop(32);
if (true) return __ref.getField(true,"_isconfirmed" /*RemoteObject*/ );
 BA.debugLineNum = 71;BA.debugLine="End Sub";
Debug.ShouldStop(64);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _tickstoshamsi(RemoteObject __ref,RemoteObject _ticks) throws Exception{
try {
		Debug.PushSubsStack("TicksToShamsi (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,449);
if (RapidSub.canDelegate("tickstoshamsi")) { return __ref.runUserSub(false, "shamsidatepickerv3","tickstoshamsi", __ref, _ticks);}
Debug.locals.put("ticks", _ticks);
 BA.debugLineNum = 449;BA.debugLine="Public Sub TicksToShamsi(ticks As Long) As Int()";
Debug.ShouldStop(1);
 BA.debugLineNum = 450;BA.debugLine="Return GregorianToShamsi(DateTime.GetYear(ticks),";
Debug.ShouldStop(2);
if (true) return __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_gregoriantoshamsi" /*RemoteObject*/ ,(Object)(shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"GetYear",(Object)(_ticks))),(Object)(shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"GetMonth",(Object)(_ticks))),(Object)(shamsidatepickerv3.__c.getField(false,"DateTime").runMethod(true,"GetDayOfMonth",(Object)(_ticks))));
 BA.debugLineNum = 451;BA.debugLine="End Sub";
Debug.ShouldStop(4);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _tickstoshamsistring(RemoteObject __ref,RemoteObject _ticks) throws Exception{
try {
		Debug.PushSubsStack("TicksToShamsiString (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,453);
if (RapidSub.canDelegate("tickstoshamsistring")) { return __ref.runUserSub(false, "shamsidatepickerv3","tickstoshamsistring", __ref, _ticks);}
RemoteObject _j = null;
Debug.locals.put("ticks", _ticks);
 BA.debugLineNum = 453;BA.debugLine="Public Sub TicksToShamsiString(ticks As Long) As S";
Debug.ShouldStop(16);
 BA.debugLineNum = 454;BA.debugLine="Dim j() As Int = TicksToShamsi(ticks)";
Debug.ShouldStop(32);
_j = __ref.runClassMethod (b4j.example.shamsidatepickerv3.class, "_tickstoshamsi" /*RemoteObject*/ ,(Object)(_ticks));Debug.locals.put("j", _j);Debug.locals.put("j", _j);
 BA.debugLineNum = 455;BA.debugLine="Return j(0) & \"/\" & NumberFormat2(j(1), 2, 0, 0,";
Debug.ShouldStop(64);
if (true) return RemoteObject.concat(_j.getArrayElement(true,BA.numberCast(int.class, 0)),RemoteObject.createImmutable("/"),shamsidatepickerv3.__c.runMethod(true,"NumberFormat2",(Object)(BA.numberCast(double.class, _j.getArrayElement(true,BA.numberCast(int.class, 1)))),(Object)(BA.numberCast(int.class, 2)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(shamsidatepickerv3.__c.getField(true,"False"))),RemoteObject.createImmutable("/"),shamsidatepickerv3.__c.runMethod(true,"NumberFormat2",(Object)(BA.numberCast(double.class, _j.getArrayElement(true,BA.numberCast(int.class, 2)))),(Object)(BA.numberCast(int.class, 2)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(shamsidatepickerv3.__c.getField(true,"False"))));
 BA.debugLineNum = 456;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _topersiandigits(RemoteObject __ref,RemoteObject _input) throws Exception{
try {
		Debug.PushSubsStack("ToPersianDigits (shamsidatepickerv3) ","shamsidatepickerv3",1,__ref.getField(false, "ba"),__ref,621);
if (RapidSub.canDelegate("topersiandigits")) { return __ref.runUserSub(false, "shamsidatepickerv3","topersiandigits", __ref, _input);}
RemoteObject _en = null;
RemoteObject _fa = null;
RemoteObject _s = RemoteObject.createImmutable("");
int _i = 0;
Debug.locals.put("input", _input);
 BA.debugLineNum = 621;BA.debugLine="Public Sub ToPersianDigits(input As String) As Str";
Debug.ShouldStop(4096);
 BA.debugLineNum = 622;BA.debugLine="Dim en() As String = Array As String(\"0\",\"1\",\"2\",";
Debug.ShouldStop(8192);
_en = RemoteObject.createNewArray("String",new int[] {10},new Object[] {BA.ObjectToString("0"),BA.ObjectToString("1"),BA.ObjectToString("2"),BA.ObjectToString("3"),BA.ObjectToString("4"),BA.ObjectToString("5"),BA.ObjectToString("6"),BA.ObjectToString("7"),BA.ObjectToString("8"),RemoteObject.createImmutable("9")});Debug.locals.put("en", _en);Debug.locals.put("en", _en);
 BA.debugLineNum = 623;BA.debugLine="Dim fa() As String = Array As String(\"۰\",\"۱\",\"۲\",";
Debug.ShouldStop(16384);
_fa = RemoteObject.createNewArray("String",new int[] {10},new Object[] {BA.ObjectToString("۰"),BA.ObjectToString("۱"),BA.ObjectToString("۲"),BA.ObjectToString("۳"),BA.ObjectToString("۴"),BA.ObjectToString("۵"),BA.ObjectToString("۶"),BA.ObjectToString("۷"),BA.ObjectToString("۸"),RemoteObject.createImmutable("۹")});Debug.locals.put("fa", _fa);Debug.locals.put("fa", _fa);
 BA.debugLineNum = 624;BA.debugLine="Dim s As String = input";
Debug.ShouldStop(32768);
_s = _input;Debug.locals.put("s", _s);Debug.locals.put("s", _s);
 BA.debugLineNum = 625;BA.debugLine="For i = 0 To 9";
Debug.ShouldStop(65536);
{
final int step4 = 1;
final int limit4 = 9;
_i = 0 ;
for (;(step4 > 0 && _i <= limit4) || (step4 < 0 && _i >= limit4) ;_i = ((int)(0 + _i + step4))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 626;BA.debugLine="s = s.Replace(en(i), fa(i))";
Debug.ShouldStop(131072);
_s = _s.runMethod(true,"replace",(Object)(_en.getArrayElement(true,BA.numberCast(int.class, _i))),(Object)(_fa.getArrayElement(true,BA.numberCast(int.class, _i))));Debug.locals.put("s", _s);
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 628;BA.debugLine="Return s";
Debug.ShouldStop(524288);
if (true) return _s;
 BA.debugLineNum = 629;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}