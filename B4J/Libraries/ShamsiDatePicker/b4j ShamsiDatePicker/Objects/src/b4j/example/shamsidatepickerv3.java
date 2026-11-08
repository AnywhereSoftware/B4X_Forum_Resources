package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class shamsidatepickerv3 extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.shamsidatepickerv3", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.shamsidatepickerv3.class).invoke(this, new Object[] {null});
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
public anywheresoftware.b4j.objects.JFX _fx = null;
public anywheresoftware.b4j.objects.Form _frm = null;
public anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _mainpane = null;
public int _currentyear = 0;
public int _currentmonth = 0;
public int _selectedyear = 0;
public int _selectedmonth = 0;
public int _selectedday = 0;
public int _todayyear = 0;
public int _todaymonth = 0;
public int _todayday = 0;
public int _resultyear = 0;
public int _resultmonth = 0;
public int _resultday = 0;
public boolean _isconfirmed = false;
public boolean _usepersiandigits = false;
public String[] _monthnames = null;
public String[] _daynames = null;
public String[] _fulldaynames = null;
public int _cell_size = 0;
public int _form_width = 0;
public int _form_height = 0;
public String _fnt = "";
public anywheresoftware.b4a.objects.collections.List _daylabels = null;
public int _firstdow = 0;
public anywheresoftware.b4j.objects.LabelWrapper _lblmonthyear = null;
public b4j.example.main _main = null;
public String  _initialize(b4j.example.shamsidatepickerv3 __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=262144;
 //BA.debugLineNum = 262144;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=262145;
 //BA.debugLineNum = 262145;BA.debugLine="MonthNames = Array As String(\"فروردین\", \"اردیبهشت";
__ref._monthnames /*String[]*/  = new String[]{"فروردین","اردیبهشت","خرداد","تیر","مرداد","شهریور","مهر","آبان","آذر","دی","بهمن","اسفند"};
RDebugUtils.currentLine=262147;
 //BA.debugLineNum = 262147;BA.debugLine="DayNames = Array As String(\"ش\", \"ی\", \"د\", \"س\", \"چ";
__ref._daynames /*String[]*/  = new String[]{"ش","ی","د","س","چ","پ","ج"};
RDebugUtils.currentLine=262148;
 //BA.debugLineNum = 262148;BA.debugLine="FullDayNames = Array As String(\"شنبه\", \"یکشنبه\",";
__ref._fulldaynames /*String[]*/  = new String[]{"شنبه","یکشنبه","دوشنبه","سه‌شنبه","چهارشنبه","پنجشنبه","جمعه"};
RDebugUtils.currentLine=262150;
 //BA.debugLineNum = 262150;BA.debugLine="DayLabels.Initialize";
__ref._daylabels /*anywheresoftware.b4a.objects.collections.List*/ .Initialize();
RDebugUtils.currentLine=262151;
 //BA.debugLineNum = 262151;BA.debugLine="ConvertTodayToShamsi";
__ref._converttodaytoshamsi /*String*/ (null);
RDebugUtils.currentLine=262153;
 //BA.debugLineNum = 262153;BA.debugLine="CurrentYear = TodayYear";
__ref._currentyear /*int*/  = __ref._todayyear /*int*/ ;
RDebugUtils.currentLine=262154;
 //BA.debugLineNum = 262154;BA.debugLine="CurrentMonth = TodayMonth";
__ref._currentmonth /*int*/  = __ref._todaymonth /*int*/ ;
RDebugUtils.currentLine=262155;
 //BA.debugLineNum = 262155;BA.debugLine="SelectedYear = TodayYear";
__ref._selectedyear /*int*/  = __ref._todayyear /*int*/ ;
RDebugUtils.currentLine=262156;
 //BA.debugLineNum = 262156;BA.debugLine="SelectedMonth = TodayMonth";
__ref._selectedmonth /*int*/  = __ref._todaymonth /*int*/ ;
RDebugUtils.currentLine=262157;
 //BA.debugLineNum = 262157;BA.debugLine="SelectedDay = TodayDay";
__ref._selectedday /*int*/  = __ref._todayday /*int*/ ;
RDebugUtils.currentLine=262158;
 //BA.debugLineNum = 262158;BA.debugLine="IsConfirmed = False";
__ref._isconfirmed /*boolean*/  = __c.False;
RDebugUtils.currentLine=262159;
 //BA.debugLineNum = 262159;BA.debugLine="End Sub";
return "";
}
public boolean  _show(b4j.example.shamsidatepickerv3 __ref,anywheresoftware.b4j.objects.Form _owner) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "show", false))
	 {return ((Boolean) Debug.delegate(ba, "show", new Object[] {_owner}));}
RDebugUtils.currentLine=327680;
 //BA.debugLineNum = 327680;BA.debugLine="Public Sub Show(owner As Form) As Boolean";
RDebugUtils.currentLine=327681;
 //BA.debugLineNum = 327681;BA.debugLine="Return ShowAt(owner, Null)";
if (true) return __ref._showat /*boolean*/ (null,_owner,(anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper(), (javafx.scene.Node)(__c.Null)));
RDebugUtils.currentLine=327682;
 //BA.debugLineNum = 327682;BA.debugLine="End Sub";
return false;
}
public long  _getselectedticks(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "getselectedticks", false))
	 {return ((Long) Debug.delegate(ba, "getselectedticks", null));}
long _n = 0L;
RDebugUtils.currentLine=1441792;
 //BA.debugLineNum = 1441792;BA.debugLine="Public Sub GetSelectedTicks As Long";
RDebugUtils.currentLine=1441793;
 //BA.debugLineNum = 1441793;BA.debugLine="Dim n As Long = DateTime.Now";
_n = __c.DateTime.getNow();
RDebugUtils.currentLine=1441794;
 //BA.debugLineNum = 1441794;BA.debugLine="Return ShamsiToTicksWithTime(ResultYear, ResultMo";
if (true) return __ref._shamsitotickswithtime /*long*/ (null,__ref._resultyear /*int*/ ,__ref._resultmonth /*int*/ ,__ref._resultday /*int*/ ,__c.DateTime.GetHour(_n),__c.DateTime.GetMinute(_n),__c.DateTime.GetSecond(_n));
RDebugUtils.currentLine=1441796;
 //BA.debugLineNum = 1441796;BA.debugLine="End Sub";
return 0L;
}
public String  _getselecteddatestring(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "getselecteddatestring", false))
	 {return ((String) Debug.delegate(ba, "getselecteddatestring", null));}
RDebugUtils.currentLine=1376256;
 //BA.debugLineNum = 1376256;BA.debugLine="Public Sub GetSelectedDateString As String";
RDebugUtils.currentLine=1376257;
 //BA.debugLineNum = 1376257;BA.debugLine="Return ResultYear & \"/\" & NumberFormat2(ResultMon";
if (true) return BA.NumberToString(__ref._resultyear /*int*/ )+"/"+__c.NumberFormat2(__ref._resultmonth /*int*/ ,(int) (2),(int) (0),(int) (0),__c.False)+"/"+__c.NumberFormat2(__ref._resultday /*int*/ ,(int) (2),(int) (0),(int) (0),__c.False);
RDebugUtils.currentLine=1376258;
 //BA.debugLineNum = 1376258;BA.debugLine="End Sub";
return "";
}
public long  _getselectedticksnotime(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "getselectedticksnotime", false))
	 {return ((Long) Debug.delegate(ba, "getselectedticksnotime", null));}
RDebugUtils.currentLine=1507328;
 //BA.debugLineNum = 1507328;BA.debugLine="Public Sub GetSelectedTicksNoTime As Long";
RDebugUtils.currentLine=1507329;
 //BA.debugLineNum = 1507329;BA.debugLine="Return ShamsiToTicksWithTime(ResultYear, ResultMo";
if (true) return __ref._shamsitotickswithtime /*long*/ (null,__ref._resultyear /*int*/ ,__ref._resultmonth /*int*/ ,__ref._resultday /*int*/ ,(int) (0),(int) (0),(int) (0));
RDebugUtils.currentLine=1507330;
 //BA.debugLineNum = 1507330;BA.debugLine="End Sub";
return 0L;
}
public String  _tickstoshamsistring(b4j.example.shamsidatepickerv3 __ref,long _ticks) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "tickstoshamsistring", false))
	 {return ((String) Debug.delegate(ba, "tickstoshamsistring", new Object[] {_ticks}));}
int[] _j = null;
RDebugUtils.currentLine=1835008;
 //BA.debugLineNum = 1835008;BA.debugLine="Public Sub TicksToShamsiString(ticks As Long) As S";
RDebugUtils.currentLine=1835009;
 //BA.debugLineNum = 1835009;BA.debugLine="Dim j() As Int = TicksToShamsi(ticks)";
_j = __ref._tickstoshamsi /*int[]*/ (null,_ticks);
RDebugUtils.currentLine=1835010;
 //BA.debugLineNum = 1835010;BA.debugLine="Return j(0) & \"/\" & NumberFormat2(j(1), 2, 0, 0,";
if (true) return BA.NumberToString(_j[(int) (0)])+"/"+__c.NumberFormat2(_j[(int) (1)],(int) (2),(int) (0),(int) (0),__c.False)+"/"+__c.NumberFormat2(_j[(int) (2)],(int) (2),(int) (0),(int) (0),__c.False);
RDebugUtils.currentLine=1835011;
 //BA.debugLineNum = 1835011;BA.debugLine="End Sub";
return "";
}
public String  _adjustselectedday(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "adjustselectedday", false))
	 {return ((String) Debug.delegate(ba, "adjustselectedday", null));}
int _maxday = 0;
RDebugUtils.currentLine=1310720;
 //BA.debugLineNum = 1310720;BA.debugLine="Private Sub AdjustSelectedDay";
RDebugUtils.currentLine=1310721;
 //BA.debugLineNum = 1310721;BA.debugLine="If SelectedYear = CurrentYear And SelectedMonth =";
if (__ref._selectedyear /*int*/ ==__ref._currentyear /*int*/  && __ref._selectedmonth /*int*/ ==__ref._currentmonth /*int*/ ) { 
RDebugUtils.currentLine=1310722;
 //BA.debugLineNum = 1310722;BA.debugLine="Dim maxDay As Int = GetDaysInMonth(CurrentYear,";
_maxday = __ref._getdaysinmonth /*int*/ (null,__ref._currentyear /*int*/ ,__ref._currentmonth /*int*/ );
RDebugUtils.currentLine=1310723;
 //BA.debugLineNum = 1310723;BA.debugLine="If SelectedDay > maxDay Then SelectedDay = maxDa";
if (__ref._selectedday /*int*/ >_maxday) { 
__ref._selectedday /*int*/  = _maxday;};
 };
RDebugUtils.currentLine=1310725;
 //BA.debugLineNum = 1310725;BA.debugLine="End Sub";
return "";
}
public int  _getdaysinmonth(b4j.example.shamsidatepickerv3 __ref,int _jy,int _jm) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "getdaysinmonth", false))
	 {return ((Integer) Debug.delegate(ba, "getdaysinmonth", new Object[] {_jy,_jm}));}
RDebugUtils.currentLine=2424832;
 //BA.debugLineNum = 2424832;BA.debugLine="Public Sub GetDaysInMonth(jy As Int, jm As Int) As";
RDebugUtils.currentLine=2424833;
 //BA.debugLineNum = 2424833;BA.debugLine="If jm <= 6 Then Return 31";
if (_jm<=6) { 
if (true) return (int) (31);};
RDebugUtils.currentLine=2424834;
 //BA.debugLineNum = 2424834;BA.debugLine="If jm <= 11 Then Return 30";
if (_jm<=11) { 
if (true) return (int) (30);};
RDebugUtils.currentLine=2424835;
 //BA.debugLineNum = 2424835;BA.debugLine="If IsLeapShamsi(jy) Then Return 30";
if (__ref._isleapshamsi /*boolean*/ (null,_jy)) { 
if (true) return (int) (30);};
RDebugUtils.currentLine=2424836;
 //BA.debugLineNum = 2424836;BA.debugLine="Return 29";
if (true) return (int) (29);
RDebugUtils.currentLine=2424837;
 //BA.debugLineNum = 2424837;BA.debugLine="End Sub";
return 0;
}
public String  _btnconfirm_action(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "btnconfirm_action", false))
	 {return ((String) Debug.delegate(ba, "btnconfirm_action", null));}
RDebugUtils.currentLine=1114112;
 //BA.debugLineNum = 1114112;BA.debugLine="Private Sub btnConfirm_Action";
RDebugUtils.currentLine=1114113;
 //BA.debugLineNum = 1114113;BA.debugLine="ConfirmAndClose";
__ref._confirmandclose /*String*/ (null);
RDebugUtils.currentLine=1114114;
 //BA.debugLineNum = 1114114;BA.debugLine="End Sub";
return "";
}
public String  _confirmandclose(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "confirmandclose", false))
	 {return ((String) Debug.delegate(ba, "confirmandclose", null));}
RDebugUtils.currentLine=1179648;
 //BA.debugLineNum = 1179648;BA.debugLine="Private Sub ConfirmAndClose";
RDebugUtils.currentLine=1179649;
 //BA.debugLineNum = 1179649;BA.debugLine="ResultYear = SelectedYear";
__ref._resultyear /*int*/  = __ref._selectedyear /*int*/ ;
RDebugUtils.currentLine=1179650;
 //BA.debugLineNum = 1179650;BA.debugLine="ResultMonth = SelectedMonth";
__ref._resultmonth /*int*/  = __ref._selectedmonth /*int*/ ;
RDebugUtils.currentLine=1179651;
 //BA.debugLineNum = 1179651;BA.debugLine="ResultDay = SelectedDay";
__ref._resultday /*int*/  = __ref._selectedday /*int*/ ;
RDebugUtils.currentLine=1179652;
 //BA.debugLineNum = 1179652;BA.debugLine="IsConfirmed = True";
__ref._isconfirmed /*boolean*/  = __c.True;
RDebugUtils.currentLine=1179653;
 //BA.debugLineNum = 1179653;BA.debugLine="frm.Close";
__ref._frm /*anywheresoftware.b4j.objects.Form*/ .Close();
RDebugUtils.currentLine=1179654;
 //BA.debugLineNum = 1179654;BA.debugLine="End Sub";
return "";
}
public String  _btnmonthnext_action(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "btnmonthnext_action", false))
	 {return ((String) Debug.delegate(ba, "btnmonthnext_action", null));}
RDebugUtils.currentLine=786432;
 //BA.debugLineNum = 786432;BA.debugLine="Private Sub btnMonthNext_Action";
RDebugUtils.currentLine=786433;
 //BA.debugLineNum = 786433;BA.debugLine="CurrentMonth = CurrentMonth + 1";
__ref._currentmonth /*int*/  = (int) (__ref._currentmonth /*int*/ +1);
RDebugUtils.currentLine=786434;
 //BA.debugLineNum = 786434;BA.debugLine="If CurrentMonth > 12 Then";
if (__ref._currentmonth /*int*/ >12) { 
RDebugUtils.currentLine=786435;
 //BA.debugLineNum = 786435;BA.debugLine="CurrentMonth = 1";
__ref._currentmonth /*int*/  = (int) (1);
RDebugUtils.currentLine=786436;
 //BA.debugLineNum = 786436;BA.debugLine="CurrentYear = CurrentYear + 1";
__ref._currentyear /*int*/  = (int) (__ref._currentyear /*int*/ +1);
 };
RDebugUtils.currentLine=786438;
 //BA.debugLineNum = 786438;BA.debugLine="AdjustSelectedDay";
__ref._adjustselectedday /*String*/ (null);
RDebugUtils.currentLine=786439;
 //BA.debugLineNum = 786439;BA.debugLine="DrawCalendar";
__ref._drawcalendar /*String*/ (null);
RDebugUtils.currentLine=786440;
 //BA.debugLineNum = 786440;BA.debugLine="End Sub";
return "";
}
public String  _drawcalendar(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "drawcalendar", false))
	 {return ((String) Debug.delegate(ba, "drawcalendar", null));}
int _startx = 0;
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _navpane = null;
anywheresoftware.b4j.objects.ButtonWrapper _btnmonthnext = null;
anywheresoftware.b4j.objects.ButtonWrapper _btnyearnext = null;
anywheresoftware.b4j.objects.ButtonWrapper _btnmonthprev = null;
anywheresoftware.b4j.objects.ButtonWrapper _btnyearprev = null;
int _ypos = 0;
int _i = 0;
anywheresoftware.b4j.objects.LabelWrapper _lbldn = null;
String _c = "";
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _sep = null;
int _daysinmonth = 0;
int _row = 0;
int _col = 0;
int _day = 0;
anywheresoftware.b4j.objects.LabelWrapper _lbl = null;
int _btny = 0;
anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _sep2 = null;
anywheresoftware.b4j.objects.ButtonWrapper _btnconfirm = null;
anywheresoftware.b4j.objects.ButtonWrapper _btntoday = null;
RDebugUtils.currentLine=589824;
 //BA.debugLineNum = 589824;BA.debugLine="Private Sub DrawCalendar";
RDebugUtils.currentLine=589825;
 //BA.debugLineNum = 589825;BA.debugLine="MainPane.RemoveAllNodes";
__ref._mainpane /*anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper*/ .RemoveAllNodes();
RDebugUtils.currentLine=589826;
 //BA.debugLineNum = 589826;BA.debugLine="DayLabels.Clear";
__ref._daylabels /*anywheresoftware.b4a.objects.collections.List*/ .Clear();
RDebugUtils.currentLine=589828;
 //BA.debugLineNum = 589828;BA.debugLine="Dim startX As Int = (FORM_WIDTH - (7 * CELL_SIZE)";
_startx = (int) ((__ref._form_width /*int*/ -(7*__ref._cell_size /*int*/ ))/(double)2);
RDebugUtils.currentLine=589833;
 //BA.debugLineNum = 589833;BA.debugLine="Dim navPane As Pane";
_navpane = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=589834;
 //BA.debugLineNum = 589834;BA.debugLine="navPane.Initialize(\"\")";
_navpane.Initialize(ba,"");
RDebugUtils.currentLine=589835;
 //BA.debugLineNum = 589835;BA.debugLine="navPane.Style = \"-fx-background-color: #2196F3;\"";
_navpane.setStyle("-fx-background-color: #2196F3;");
RDebugUtils.currentLine=589836;
 //BA.debugLineNum = 589836;BA.debugLine="MainPane.AddNode(navPane, 0, 0, FORM_WIDTH, 38)";
__ref._mainpane /*anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper*/ .AddNode((javafx.scene.Node)(_navpane.getObject()),0,0,__ref._form_width /*int*/ ,38);
RDebugUtils.currentLine=589839;
 //BA.debugLineNum = 589839;BA.debugLine="Dim btnMonthNext As Button          'بیرونی راست";
_btnmonthnext = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=589840;
 //BA.debugLineNum = 589840;BA.debugLine="btnMonthNext.Initialize(\"btnMonthNext\")";
_btnmonthnext.Initialize(ba,"btnMonthNext");
RDebugUtils.currentLine=589841;
 //BA.debugLineNum = 589841;BA.debugLine="btnMonthNext.Text = \"❯\"";
_btnmonthnext.setText("❯");
RDebugUtils.currentLine=589842;
 //BA.debugLineNum = 589842;BA.debugLine="btnMonthNext.Style = $\"-fx-background-color: tran";
_btnmonthnext.setStyle(("-fx-background-color: transparent; -fx-text-fill: white; "+__c.SmartStringFormatter("",(Object)(__ref._fnt /*String*/ ))+" -fx-cursor: hand;"));
RDebugUtils.currentLine=589843;
 //BA.debugLineNum = 589843;BA.debugLine="navPane.AddNode(btnMonthNext, FORM_WIDTH - 40, 2,";
_navpane.AddNode((javafx.scene.Node)(_btnmonthnext.getObject()),__ref._form_width /*int*/ -40,2,34,34);
RDebugUtils.currentLine=589845;
 //BA.debugLineNum = 589845;BA.debugLine="Dim btnYearNext As Button           'داخلی راست";
_btnyearnext = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=589846;
 //BA.debugLineNum = 589846;BA.debugLine="btnYearNext.Initialize(\"btnYearNext\")";
_btnyearnext.Initialize(ba,"btnYearNext");
RDebugUtils.currentLine=589847;
 //BA.debugLineNum = 589847;BA.debugLine="btnYearNext.Text = \"❯❯\"";
_btnyearnext.setText("❯❯");
RDebugUtils.currentLine=589848;
 //BA.debugLineNum = 589848;BA.debugLine="btnYearNext.Style = $\"-fx-background-color: trans";
_btnyearnext.setStyle(("-fx-background-color: transparent; -fx-text-fill: white; "+__c.SmartStringFormatter("",(Object)(__ref._fnt /*String*/ ))+" -fx-cursor: hand;"));
RDebugUtils.currentLine=589849;
 //BA.debugLineNum = 589849;BA.debugLine="navPane.AddNode(btnYearNext, FORM_WIDTH - 76, 2,";
_navpane.AddNode((javafx.scene.Node)(_btnyearnext.getObject()),__ref._form_width /*int*/ -76,2,36,34);
RDebugUtils.currentLine=589852;
 //BA.debugLineNum = 589852;BA.debugLine="Dim btnMonthPrev As Button          'بیرونی چپ  =";
_btnmonthprev = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=589853;
 //BA.debugLineNum = 589853;BA.debugLine="btnMonthPrev.Initialize(\"btnMonthPrev\")";
_btnmonthprev.Initialize(ba,"btnMonthPrev");
RDebugUtils.currentLine=589854;
 //BA.debugLineNum = 589854;BA.debugLine="btnMonthPrev.Text = \"❮\"";
_btnmonthprev.setText("❮");
RDebugUtils.currentLine=589855;
 //BA.debugLineNum = 589855;BA.debugLine="btnMonthPrev.Style = $\"-fx-background-color: tran";
_btnmonthprev.setStyle(("-fx-background-color: transparent; -fx-text-fill: white; "+__c.SmartStringFormatter("",(Object)(__ref._fnt /*String*/ ))+" -fx-cursor: hand;"));
RDebugUtils.currentLine=589856;
 //BA.debugLineNum = 589856;BA.debugLine="navPane.AddNode(btnMonthPrev, 6, 2, 34, 34)";
_navpane.AddNode((javafx.scene.Node)(_btnmonthprev.getObject()),6,2,34,34);
RDebugUtils.currentLine=589858;
 //BA.debugLineNum = 589858;BA.debugLine="Dim btnYearPrev As Button           'داخلی چپ  =";
_btnyearprev = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=589859;
 //BA.debugLineNum = 589859;BA.debugLine="btnYearPrev.Initialize(\"btnYearPrev\")";
_btnyearprev.Initialize(ba,"btnYearPrev");
RDebugUtils.currentLine=589860;
 //BA.debugLineNum = 589860;BA.debugLine="btnYearPrev.Text = \"❮❮\"";
_btnyearprev.setText("❮❮");
RDebugUtils.currentLine=589861;
 //BA.debugLineNum = 589861;BA.debugLine="btnYearPrev.Style = $\"-fx-background-color: trans";
_btnyearprev.setStyle(("-fx-background-color: transparent; -fx-text-fill: white; "+__c.SmartStringFormatter("",(Object)(__ref._fnt /*String*/ ))+" -fx-cursor: hand;"));
RDebugUtils.currentLine=589862;
 //BA.debugLineNum = 589862;BA.debugLine="navPane.AddNode(btnYearPrev, 40, 2, 36, 34)";
_navpane.AddNode((javafx.scene.Node)(_btnyearprev.getObject()),40,2,36,34);
RDebugUtils.currentLine=589864;
 //BA.debugLineNum = 589864;BA.debugLine="lblMonthYear.Initialize(\"\")";
__ref._lblmonthyear /*anywheresoftware.b4j.objects.LabelWrapper*/ .Initialize(ba,"");
RDebugUtils.currentLine=589865;
 //BA.debugLineNum = 589865;BA.debugLine="lblMonthYear.Alignment = \"CENTER\"";
__ref._lblmonthyear /*anywheresoftware.b4j.objects.LabelWrapper*/ .setAlignment("CENTER");
RDebugUtils.currentLine=589866;
 //BA.debugLineNum = 589866;BA.debugLine="lblMonthYear.Style = $\"-fx-text-fill: white; -fx-";
__ref._lblmonthyear /*anywheresoftware.b4j.objects.LabelWrapper*/ .setStyle(("-fx-text-fill: white; -fx-font-weight: bold; "+__c.SmartStringFormatter("",(Object)(__ref._fnt /*String*/ ))+""));
RDebugUtils.currentLine=589867;
 //BA.debugLineNum = 589867;BA.debugLine="navPane.AddNode(lblMonthYear, 78, 2, FORM_WIDTH -";
_navpane.AddNode((javafx.scene.Node)(__ref._lblmonthyear /*anywheresoftware.b4j.objects.LabelWrapper*/ .getObject()),78,2,__ref._form_width /*int*/ -156,34);
RDebugUtils.currentLine=589869;
 //BA.debugLineNum = 589869;BA.debugLine="Dim yPos As Int = 42";
_ypos = (int) (42);
RDebugUtils.currentLine=589872;
 //BA.debugLineNum = 589872;BA.debugLine="For i = 0 To 6";
{
final int step33 = 1;
final int limit33 = (int) (6);
_i = (int) (0) ;
for (;_i <= limit33 ;_i = _i + step33 ) {
RDebugUtils.currentLine=589873;
 //BA.debugLineNum = 589873;BA.debugLine="Dim lblDN As Label";
_lbldn = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=589874;
 //BA.debugLineNum = 589874;BA.debugLine="lblDN.Initialize(\"\")";
_lbldn.Initialize(ba,"");
RDebugUtils.currentLine=589875;
 //BA.debugLineNum = 589875;BA.debugLine="lblDN.Text = DayNames(i)";
_lbldn.setText(__ref._daynames /*String[]*/ [_i]);
RDebugUtils.currentLine=589876;
 //BA.debugLineNum = 589876;BA.debugLine="lblDN.Alignment = \"CENTER\"";
_lbldn.setAlignment("CENTER");
RDebugUtils.currentLine=589877;
 //BA.debugLineNum = 589877;BA.debugLine="Dim c As String = \"#555555\"";
_c = "#555555";
RDebugUtils.currentLine=589878;
 //BA.debugLineNum = 589878;BA.debugLine="If i = 6 Then c = \"#E53935\"";
if (_i==6) { 
_c = "#E53935";};
RDebugUtils.currentLine=589879;
 //BA.debugLineNum = 589879;BA.debugLine="lblDN.Style = $\"-fx-text-fill: ${c}; -fx-font-we";
_lbldn.setStyle(("-fx-text-fill: "+__c.SmartStringFormatter("",(Object)(_c))+"; -fx-font-weight: bold; "+__c.SmartStringFormatter("",(Object)(__ref._fnt /*String*/ ))+""));
RDebugUtils.currentLine=589880;
 //BA.debugLineNum = 589880;BA.debugLine="MainPane.AddNode(lblDN, startX + ((6 - i) * CELL";
__ref._mainpane /*anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper*/ .AddNode((javafx.scene.Node)(_lbldn.getObject()),_startx+((6-_i)*__ref._cell_size /*int*/ ),_ypos,__ref._cell_size /*int*/ ,22);
 }
};
RDebugUtils.currentLine=589882;
 //BA.debugLineNum = 589882;BA.debugLine="yPos = yPos + 23";
_ypos = (int) (_ypos+23);
RDebugUtils.currentLine=589884;
 //BA.debugLineNum = 589884;BA.debugLine="Dim sep As Pane";
_sep = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=589885;
 //BA.debugLineNum = 589885;BA.debugLine="sep.Initialize(\"\")";
_sep.Initialize(ba,"");
RDebugUtils.currentLine=589886;
 //BA.debugLineNum = 589886;BA.debugLine="sep.Style = \"-fx-background-color: #E0E0E0;\"";
_sep.setStyle("-fx-background-color: #E0E0E0;");
RDebugUtils.currentLine=589887;
 //BA.debugLineNum = 589887;BA.debugLine="MainPane.AddNode(sep, startX, yPos, 7 * CELL_SIZE";
__ref._mainpane /*anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper*/ .AddNode((javafx.scene.Node)(_sep.getObject()),_startx,_ypos,7*__ref._cell_size /*int*/ ,1);
RDebugUtils.currentLine=589888;
 //BA.debugLineNum = 589888;BA.debugLine="yPos = yPos + 4";
_ypos = (int) (_ypos+4);
RDebugUtils.currentLine=589891;
 //BA.debugLineNum = 589891;BA.debugLine="Dim daysInMonth As Int = GetDaysInMonth(CurrentYe";
_daysinmonth = __ref._getdaysinmonth /*int*/ (null,__ref._currentyear /*int*/ ,__ref._currentmonth /*int*/ );
RDebugUtils.currentLine=589892;
 //BA.debugLineNum = 589892;BA.debugLine="FirstDow = GetFirstDayOfWeek(CurrentYear, Current";
__ref._firstdow /*int*/  = __ref._getfirstdayofweek /*int*/ (null,__ref._currentyear /*int*/ ,__ref._currentmonth /*int*/ );
RDebugUtils.currentLine=589894;
 //BA.debugLineNum = 589894;BA.debugLine="Dim row As Int = 0";
_row = (int) (0);
RDebugUtils.currentLine=589895;
 //BA.debugLineNum = 589895;BA.debugLine="Dim col As Int = FirstDow";
_col = __ref._firstdow /*int*/ ;
RDebugUtils.currentLine=589897;
 //BA.debugLineNum = 589897;BA.debugLine="For day = 1 To daysInMonth";
{
final int step53 = 1;
final int limit53 = _daysinmonth;
_day = (int) (1) ;
for (;_day <= limit53 ;_day = _day + step53 ) {
RDebugUtils.currentLine=589898;
 //BA.debugLineNum = 589898;BA.debugLine="Dim lbl As Label";
_lbl = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=589899;
 //BA.debugLineNum = 589899;BA.debugLine="lbl.Initialize(\"dayLabel\")";
_lbl.Initialize(ba,"dayLabel");
RDebugUtils.currentLine=589900;
 //BA.debugLineNum = 589900;BA.debugLine="lbl.Text = FormatNum(day)";
_lbl.setText(__ref._formatnum /*String*/ (null,_day));
RDebugUtils.currentLine=589901;
 //BA.debugLineNum = 589901;BA.debugLine="lbl.Alignment = \"CENTER\"";
_lbl.setAlignment("CENTER");
RDebugUtils.currentLine=589902;
 //BA.debugLineNum = 589902;BA.debugLine="lbl.Tag = day";
_lbl.setTag((Object)(_day));
RDebugUtils.currentLine=589903;
 //BA.debugLineNum = 589903;BA.debugLine="MainPane.AddNode(lbl, startX + ((6 - col) * CELL";
__ref._mainpane /*anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper*/ .AddNode((javafx.scene.Node)(_lbl.getObject()),_startx+((6-_col)*__ref._cell_size /*int*/ ),_ypos+(_row*__ref._cell_size /*int*/ ),__ref._cell_size /*int*/ ,__ref._cell_size /*int*/ );
RDebugUtils.currentLine=589904;
 //BA.debugLineNum = 589904;BA.debugLine="DayLabels.Add(lbl)";
__ref._daylabels /*anywheresoftware.b4a.objects.collections.List*/ .Add((Object)(_lbl.getObject()));
RDebugUtils.currentLine=589906;
 //BA.debugLineNum = 589906;BA.debugLine="col = col + 1";
_col = (int) (_col+1);
RDebugUtils.currentLine=589907;
 //BA.debugLineNum = 589907;BA.debugLine="If col > 6 Then";
if (_col>6) { 
RDebugUtils.currentLine=589908;
 //BA.debugLineNum = 589908;BA.debugLine="col = 0";
_col = (int) (0);
RDebugUtils.currentLine=589909;
 //BA.debugLineNum = 589909;BA.debugLine="row = row + 1";
_row = (int) (_row+1);
 };
 }
};
RDebugUtils.currentLine=589914;
 //BA.debugLineNum = 589914;BA.debugLine="Dim btnY As Int = FORM_HEIGHT - 40";
_btny = (int) (__ref._form_height /*int*/ -40);
RDebugUtils.currentLine=589916;
 //BA.debugLineNum = 589916;BA.debugLine="Dim sep2 As Pane";
_sep2 = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=589917;
 //BA.debugLineNum = 589917;BA.debugLine="sep2.Initialize(\"\")";
_sep2.Initialize(ba,"");
RDebugUtils.currentLine=589918;
 //BA.debugLineNum = 589918;BA.debugLine="sep2.Style = \"-fx-background-color: #E0E0E0;\"";
_sep2.setStyle("-fx-background-color: #E0E0E0;");
RDebugUtils.currentLine=589919;
 //BA.debugLineNum = 589919;BA.debugLine="MainPane.AddNode(sep2, 0, btnY - 7, FORM_WIDTH, 1";
__ref._mainpane /*anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper*/ .AddNode((javafx.scene.Node)(_sep2.getObject()),0,_btny-7,__ref._form_width /*int*/ ,1);
RDebugUtils.currentLine=589921;
 //BA.debugLineNum = 589921;BA.debugLine="Dim btnConfirm As Button";
_btnconfirm = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=589922;
 //BA.debugLineNum = 589922;BA.debugLine="btnConfirm.Initialize(\"btnConfirm\")";
_btnconfirm.Initialize(ba,"btnConfirm");
RDebugUtils.currentLine=589923;
 //BA.debugLineNum = 589923;BA.debugLine="btnConfirm.Text = \"تایید\"";
_btnconfirm.setText("تایید");
RDebugUtils.currentLine=589924;
 //BA.debugLineNum = 589924;BA.debugLine="btnConfirm.Style = $\"-fx-background-color: #1976D";
_btnconfirm.setStyle(("-fx-background-color: #1976D2; -fx-text-fill: white; "+__c.SmartStringFormatter("",(Object)(__ref._fnt /*String*/ ))+" -fx-background-radius: 4; -fx-cursor: hand;"));
RDebugUtils.currentLine=589925;
 //BA.debugLineNum = 589925;BA.debugLine="MainPane.AddNode(btnConfirm, FORM_WIDTH - 90, btn";
__ref._mainpane /*anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper*/ .AddNode((javafx.scene.Node)(_btnconfirm.getObject()),__ref._form_width /*int*/ -90,_btny,78,30);
RDebugUtils.currentLine=589927;
 //BA.debugLineNum = 589927;BA.debugLine="Dim btnToday As Button";
_btntoday = new anywheresoftware.b4j.objects.ButtonWrapper();
RDebugUtils.currentLine=589928;
 //BA.debugLineNum = 589928;BA.debugLine="btnToday.Initialize(\"btnToday\")";
_btntoday.Initialize(ba,"btnToday");
RDebugUtils.currentLine=589929;
 //BA.debugLineNum = 589929;BA.debugLine="btnToday.Text = \"امروز\"";
_btntoday.setText("امروز");
RDebugUtils.currentLine=589930;
 //BA.debugLineNum = 589930;BA.debugLine="btnToday.Style = $\"-fx-background-color: #FF5722;";
_btntoday.setStyle(("-fx-background-color: #FF5722; -fx-text-fill: white; "+__c.SmartStringFormatter("",(Object)(__ref._fnt /*String*/ ))+" -fx-background-radius: 4; -fx-cursor: hand;"));
RDebugUtils.currentLine=589931;
 //BA.debugLineNum = 589931;BA.debugLine="MainPane.AddNode(btnToday, 12, btnY, 78, 30)";
__ref._mainpane /*anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper*/ .AddNode((javafx.scene.Node)(_btntoday.getObject()),12,_btny,78,30);
RDebugUtils.currentLine=589933;
 //BA.debugLineNum = 589933;BA.debugLine="RefreshStyles";
__ref._refreshstyles /*String*/ (null);
RDebugUtils.currentLine=589934;
 //BA.debugLineNum = 589934;BA.debugLine="End Sub";
return "";
}
public String  _btnmonthprev_action(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "btnmonthprev_action", false))
	 {return ((String) Debug.delegate(ba, "btnmonthprev_action", null));}
RDebugUtils.currentLine=851968;
 //BA.debugLineNum = 851968;BA.debugLine="Private Sub btnMonthPrev_Action";
RDebugUtils.currentLine=851969;
 //BA.debugLineNum = 851969;BA.debugLine="CurrentMonth = CurrentMonth - 1";
__ref._currentmonth /*int*/  = (int) (__ref._currentmonth /*int*/ -1);
RDebugUtils.currentLine=851970;
 //BA.debugLineNum = 851970;BA.debugLine="If CurrentMonth < 1 Then";
if (__ref._currentmonth /*int*/ <1) { 
RDebugUtils.currentLine=851971;
 //BA.debugLineNum = 851971;BA.debugLine="CurrentMonth = 12";
__ref._currentmonth /*int*/  = (int) (12);
RDebugUtils.currentLine=851972;
 //BA.debugLineNum = 851972;BA.debugLine="CurrentYear = CurrentYear - 1";
__ref._currentyear /*int*/  = (int) (__ref._currentyear /*int*/ -1);
 };
RDebugUtils.currentLine=851974;
 //BA.debugLineNum = 851974;BA.debugLine="AdjustSelectedDay";
__ref._adjustselectedday /*String*/ (null);
RDebugUtils.currentLine=851975;
 //BA.debugLineNum = 851975;BA.debugLine="DrawCalendar";
__ref._drawcalendar /*String*/ (null);
RDebugUtils.currentLine=851976;
 //BA.debugLineNum = 851976;BA.debugLine="End Sub";
return "";
}
public String  _btntoday_action(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "btntoday_action", false))
	 {return ((String) Debug.delegate(ba, "btntoday_action", null));}
RDebugUtils.currentLine=1048576;
 //BA.debugLineNum = 1048576;BA.debugLine="Private Sub btnToday_Action";
RDebugUtils.currentLine=1048577;
 //BA.debugLineNum = 1048577;BA.debugLine="CurrentYear = TodayYear";
__ref._currentyear /*int*/  = __ref._todayyear /*int*/ ;
RDebugUtils.currentLine=1048578;
 //BA.debugLineNum = 1048578;BA.debugLine="CurrentMonth = TodayMonth";
__ref._currentmonth /*int*/  = __ref._todaymonth /*int*/ ;
RDebugUtils.currentLine=1048579;
 //BA.debugLineNum = 1048579;BA.debugLine="SelectedYear = TodayYear";
__ref._selectedyear /*int*/  = __ref._todayyear /*int*/ ;
RDebugUtils.currentLine=1048580;
 //BA.debugLineNum = 1048580;BA.debugLine="SelectedMonth = TodayMonth";
__ref._selectedmonth /*int*/  = __ref._todaymonth /*int*/ ;
RDebugUtils.currentLine=1048581;
 //BA.debugLineNum = 1048581;BA.debugLine="SelectedDay = TodayDay";
__ref._selectedday /*int*/  = __ref._todayday /*int*/ ;
RDebugUtils.currentLine=1048582;
 //BA.debugLineNum = 1048582;BA.debugLine="DrawCalendar";
__ref._drawcalendar /*String*/ (null);
RDebugUtils.currentLine=1048583;
 //BA.debugLineNum = 1048583;BA.debugLine="End Sub";
return "";
}
public String  _btnyearnext_action(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "btnyearnext_action", false))
	 {return ((String) Debug.delegate(ba, "btnyearnext_action", null));}
RDebugUtils.currentLine=917504;
 //BA.debugLineNum = 917504;BA.debugLine="Private Sub btnYearNext_Action";
RDebugUtils.currentLine=917505;
 //BA.debugLineNum = 917505;BA.debugLine="CurrentYear = CurrentYear + 1";
__ref._currentyear /*int*/  = (int) (__ref._currentyear /*int*/ +1);
RDebugUtils.currentLine=917506;
 //BA.debugLineNum = 917506;BA.debugLine="AdjustSelectedDay";
__ref._adjustselectedday /*String*/ (null);
RDebugUtils.currentLine=917507;
 //BA.debugLineNum = 917507;BA.debugLine="DrawCalendar";
__ref._drawcalendar /*String*/ (null);
RDebugUtils.currentLine=917508;
 //BA.debugLineNum = 917508;BA.debugLine="End Sub";
return "";
}
public String  _btnyearprev_action(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "btnyearprev_action", false))
	 {return ((String) Debug.delegate(ba, "btnyearprev_action", null));}
RDebugUtils.currentLine=983040;
 //BA.debugLineNum = 983040;BA.debugLine="Private Sub btnYearPrev_Action";
RDebugUtils.currentLine=983041;
 //BA.debugLineNum = 983041;BA.debugLine="CurrentYear = CurrentYear - 1";
__ref._currentyear /*int*/  = (int) (__ref._currentyear /*int*/ -1);
RDebugUtils.currentLine=983042;
 //BA.debugLineNum = 983042;BA.debugLine="AdjustSelectedDay";
__ref._adjustselectedday /*String*/ (null);
RDebugUtils.currentLine=983043;
 //BA.debugLineNum = 983043;BA.debugLine="DrawCalendar";
__ref._drawcalendar /*String*/ (null);
RDebugUtils.currentLine=983044;
 //BA.debugLineNum = 983044;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
RDebugUtils.currentLine=196608;
 //BA.debugLineNum = 196608;BA.debugLine="private Sub Class_Globals";
RDebugUtils.currentLine=196609;
 //BA.debugLineNum = 196609;BA.debugLine="Private fx As JFX";
_fx = new anywheresoftware.b4j.objects.JFX();
RDebugUtils.currentLine=196610;
 //BA.debugLineNum = 196610;BA.debugLine="Private frm As Form";
_frm = new anywheresoftware.b4j.objects.Form();
RDebugUtils.currentLine=196611;
 //BA.debugLineNum = 196611;BA.debugLine="Private MainPane As Pane";
_mainpane = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
RDebugUtils.currentLine=196613;
 //BA.debugLineNum = 196613;BA.debugLine="Private CurrentYear, CurrentMonth As Int";
_currentyear = 0;
_currentmonth = 0;
RDebugUtils.currentLine=196614;
 //BA.debugLineNum = 196614;BA.debugLine="Private SelectedYear, SelectedMonth, SelectedDay";
_selectedyear = 0;
_selectedmonth = 0;
_selectedday = 0;
RDebugUtils.currentLine=196615;
 //BA.debugLineNum = 196615;BA.debugLine="Private TodayYear, TodayMonth, TodayDay As Int";
_todayyear = 0;
_todaymonth = 0;
_todayday = 0;
RDebugUtils.currentLine=196617;
 //BA.debugLineNum = 196617;BA.debugLine="Public ResultYear, ResultMonth, ResultDay As Int";
_resultyear = 0;
_resultmonth = 0;
_resultday = 0;
RDebugUtils.currentLine=196618;
 //BA.debugLineNum = 196618;BA.debugLine="Public IsConfirmed As Boolean";
_isconfirmed = false;
RDebugUtils.currentLine=196619;
 //BA.debugLineNum = 196619;BA.debugLine="Public UsePersianDigits As Boolean = False";
_usepersiandigits = __c.False;
RDebugUtils.currentLine=196621;
 //BA.debugLineNum = 196621;BA.debugLine="Private MonthNames() As String";
_monthnames = new String[(int) (0)];
java.util.Arrays.fill(_monthnames,"");
RDebugUtils.currentLine=196622;
 //BA.debugLineNum = 196622;BA.debugLine="Private DayNames() As String";
_daynames = new String[(int) (0)];
java.util.Arrays.fill(_daynames,"");
RDebugUtils.currentLine=196623;
 //BA.debugLineNum = 196623;BA.debugLine="Private FullDayNames() As String";
_fulldaynames = new String[(int) (0)];
java.util.Arrays.fill(_fulldaynames,"");
RDebugUtils.currentLine=196625;
 //BA.debugLineNum = 196625;BA.debugLine="Private CELL_SIZE As Int = 36";
_cell_size = (int) (36);
RDebugUtils.currentLine=196626;
 //BA.debugLineNum = 196626;BA.debugLine="Private FORM_WIDTH As Int = 290";
_form_width = (int) (290);
RDebugUtils.currentLine=196627;
 //BA.debugLineNum = 196627;BA.debugLine="Private FORM_HEIGHT As Int = 335";
_form_height = (int) (335);
RDebugUtils.currentLine=196629;
 //BA.debugLineNum = 196629;BA.debugLine="Private FNT As String = \"-fx-font-family: Tahoma;";
_fnt = "-fx-font-family: Tahoma; -fx-font-size: 12;";
RDebugUtils.currentLine=196631;
 //BA.debugLineNum = 196631;BA.debugLine="Private DayLabels As List";
_daylabels = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=196632;
 //BA.debugLineNum = 196632;BA.debugLine="Private FirstDow As Int";
_firstdow = 0;
RDebugUtils.currentLine=196633;
 //BA.debugLineNum = 196633;BA.debugLine="Private lblMonthYear As Label";
_lblmonthyear = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=196634;
 //BA.debugLineNum = 196634;BA.debugLine="End Sub";
return "";
}
public String  _converttodaytoshamsi(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "converttodaytoshamsi", false))
	 {return ((String) Debug.delegate(ba, "converttodaytoshamsi", null));}
long _n = 0L;
int[] _r = null;
RDebugUtils.currentLine=2031616;
 //BA.debugLineNum = 2031616;BA.debugLine="Private Sub ConvertTodayToShamsi";
RDebugUtils.currentLine=2031617;
 //BA.debugLineNum = 2031617;BA.debugLine="Dim n As Long = DateTime.Now";
_n = __c.DateTime.getNow();
RDebugUtils.currentLine=2031618;
 //BA.debugLineNum = 2031618;BA.debugLine="Dim r() As Int = GregorianToShamsi(DateTime.GetYe";
_r = __ref._gregoriantoshamsi /*int[]*/ (null,__c.DateTime.GetYear(_n),__c.DateTime.GetMonth(_n),__c.DateTime.GetDayOfMonth(_n));
RDebugUtils.currentLine=2031619;
 //BA.debugLineNum = 2031619;BA.debugLine="TodayYear = r(0)";
__ref._todayyear /*int*/  = _r[(int) (0)];
RDebugUtils.currentLine=2031620;
 //BA.debugLineNum = 2031620;BA.debugLine="TodayMonth = r(1)";
__ref._todaymonth /*int*/  = _r[(int) (1)];
RDebugUtils.currentLine=2031621;
 //BA.debugLineNum = 2031621;BA.debugLine="TodayDay = r(2)";
__ref._todayday /*int*/  = _r[(int) (2)];
RDebugUtils.currentLine=2031622;
 //BA.debugLineNum = 2031622;BA.debugLine="End Sub";
return "";
}
public int[]  _gregoriantoshamsi(b4j.example.shamsidatepickerv3 __ref,int _gy,int _gm,int _gd) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "gregoriantoshamsi", false))
	 {return ((int[]) Debug.delegate(ba, "gregoriantoshamsi", new Object[] {_gy,_gm,_gd}));}
int[] _g_d_m = null;
int _jy = 0;
int _gy2 = 0;
long _days = 0L;
int _jm = 0;
int _jd = 0;
RDebugUtils.currentLine=2097152;
 //BA.debugLineNum = 2097152;BA.debugLine="Public Sub GregorianToShamsi(gy As Int, gm As Int,";
RDebugUtils.currentLine=2097153;
 //BA.debugLineNum = 2097153;BA.debugLine="Dim g_d_m() As Int = Array As Int(0, 31, 59, 90,";
_g_d_m = new int[]{(int) (0),(int) (31),(int) (59),(int) (90),(int) (120),(int) (151),(int) (181),(int) (212),(int) (243),(int) (273),(int) (304),(int) (334)};
RDebugUtils.currentLine=2097154;
 //BA.debugLineNum = 2097154;BA.debugLine="Dim jy As Int";
_jy = 0;
RDebugUtils.currentLine=2097155;
 //BA.debugLineNum = 2097155;BA.debugLine="If gy > 1600 Then";
if (_gy>1600) { 
RDebugUtils.currentLine=2097156;
 //BA.debugLineNum = 2097156;BA.debugLine="jy = 979";
_jy = (int) (979);
RDebugUtils.currentLine=2097157;
 //BA.debugLineNum = 2097157;BA.debugLine="gy = gy - 1600";
_gy = (int) (_gy-1600);
 }else {
RDebugUtils.currentLine=2097159;
 //BA.debugLineNum = 2097159;BA.debugLine="jy = 0";
_jy = (int) (0);
RDebugUtils.currentLine=2097160;
 //BA.debugLineNum = 2097160;BA.debugLine="gy = gy - 621";
_gy = (int) (_gy-621);
 };
RDebugUtils.currentLine=2097163;
 //BA.debugLineNum = 2097163;BA.debugLine="Dim gy2 As Int = gy";
_gy2 = _gy;
RDebugUtils.currentLine=2097164;
 //BA.debugLineNum = 2097164;BA.debugLine="If gm > 2 Then gy2 = gy + 1";
if (_gm>2) { 
_gy2 = (int) (_gy+1);};
RDebugUtils.currentLine=2097166;
 //BA.debugLineNum = 2097166;BA.debugLine="Dim days As Long = (365 * gy) + IDiv(gy2 + 3, 4)";
_days = (long) ((365*_gy)+__ref._idiv /*long*/ (null,(long) (_gy2+3),(long) (4))-__ref._idiv /*long*/ (null,(long) (_gy2+99),(long) (100))+__ref._idiv /*long*/ (null,(long) (_gy2+399),(long) (400))-80+_gd+_g_d_m[(int) (_gm-1)]);
RDebugUtils.currentLine=2097168;
 //BA.debugLineNum = 2097168;BA.debugLine="jy = jy + 33 * IDiv(days, 12053)";
_jy = (int) (_jy+33*__ref._idiv /*long*/ (null,_days,(long) (12053)));
RDebugUtils.currentLine=2097169;
 //BA.debugLineNum = 2097169;BA.debugLine="days = days Mod 12053";
_days = (long) (_days%12053);
RDebugUtils.currentLine=2097171;
 //BA.debugLineNum = 2097171;BA.debugLine="jy = jy + 4 * IDiv(days, 1461)";
_jy = (int) (_jy+4*__ref._idiv /*long*/ (null,_days,(long) (1461)));
RDebugUtils.currentLine=2097172;
 //BA.debugLineNum = 2097172;BA.debugLine="days = days Mod 1461";
_days = (long) (_days%1461);
RDebugUtils.currentLine=2097174;
 //BA.debugLineNum = 2097174;BA.debugLine="If days > 365 Then";
if (_days>365) { 
RDebugUtils.currentLine=2097175;
 //BA.debugLineNum = 2097175;BA.debugLine="jy = jy + IDiv(days - 1, 365)";
_jy = (int) (_jy+__ref._idiv /*long*/ (null,(long) (_days-1),(long) (365)));
RDebugUtils.currentLine=2097176;
 //BA.debugLineNum = 2097176;BA.debugLine="days = (days - 1) Mod 365";
_days = (long) ((_days-1)%365);
 };
RDebugUtils.currentLine=2097179;
 //BA.debugLineNum = 2097179;BA.debugLine="Dim jm, jd As Int";
_jm = 0;
_jd = 0;
RDebugUtils.currentLine=2097180;
 //BA.debugLineNum = 2097180;BA.debugLine="If days < 186 Then";
if (_days<186) { 
RDebugUtils.currentLine=2097181;
 //BA.debugLineNum = 2097181;BA.debugLine="jm = 1 + IDiv(days, 31)";
_jm = (int) (1+__ref._idiv /*long*/ (null,_days,(long) (31)));
RDebugUtils.currentLine=2097182;
 //BA.debugLineNum = 2097182;BA.debugLine="jd = 1 + (days Mod 31)";
_jd = (int) (1+(_days%31));
 }else {
RDebugUtils.currentLine=2097184;
 //BA.debugLineNum = 2097184;BA.debugLine="jm = 7 + IDiv(days - 186, 30)";
_jm = (int) (7+__ref._idiv /*long*/ (null,(long) (_days-186),(long) (30)));
RDebugUtils.currentLine=2097185;
 //BA.debugLineNum = 2097185;BA.debugLine="jd = 1 + ((days - 186) Mod 30)";
_jd = (int) (1+((_days-186)%30));
 };
RDebugUtils.currentLine=2097188;
 //BA.debugLineNum = 2097188;BA.debugLine="Return Array As Int(jy, jm, jd)";
if (true) return new int[]{_jy,_jm,_jd};
RDebugUtils.currentLine=2097189;
 //BA.debugLineNum = 2097189;BA.debugLine="End Sub";
return null;
}
public String  _daylabel_mouseclicked(b4j.example.shamsidatepickerv3 __ref,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "daylabel_mouseclicked", false))
	 {return ((String) Debug.delegate(ba, "daylabel_mouseclicked", new Object[] {_eventdata}));}
anywheresoftware.b4j.objects.LabelWrapper _lbl = null;
int _day = 0;
RDebugUtils.currentLine=720896;
 //BA.debugLineNum = 720896;BA.debugLine="private Sub dayLabel_MouseClicked (EventData As Mo";
RDebugUtils.currentLine=720897;
 //BA.debugLineNum = 720897;BA.debugLine="Dim lbl As Label";
_lbl = new anywheresoftware.b4j.objects.LabelWrapper();
RDebugUtils.currentLine=720898;
 //BA.debugLineNum = 720898;BA.debugLine="lbl = Sender";
_lbl = (anywheresoftware.b4j.objects.LabelWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.LabelWrapper(), (javafx.scene.control.Label)(__c.Sender(ba)));
RDebugUtils.currentLine=720900;
 //BA.debugLineNum = 720900;BA.debugLine="If lbl.Tag <> Null Then";
if (_lbl.getTag()!= null) { 
RDebugUtils.currentLine=720901;
 //BA.debugLineNum = 720901;BA.debugLine="Dim day As Int = lbl.Tag";
_day = (int)(BA.ObjectToNumber(_lbl.getTag()));
RDebugUtils.currentLine=720903;
 //BA.debugLineNum = 720903;BA.debugLine="SelectedYear = CurrentYear";
__ref._selectedyear /*int*/  = __ref._currentyear /*int*/ ;
RDebugUtils.currentLine=720904;
 //BA.debugLineNum = 720904;BA.debugLine="SelectedMonth = CurrentMonth";
__ref._selectedmonth /*int*/  = __ref._currentmonth /*int*/ ;
RDebugUtils.currentLine=720905;
 //BA.debugLineNum = 720905;BA.debugLine="SelectedDay = day";
__ref._selectedday /*int*/  = _day;
RDebugUtils.currentLine=720907;
 //BA.debugLineNum = 720907;BA.debugLine="If EventData.ClickCount >= 2 Then     'دابل کلیک";
if (_eventdata.getClickCount()>=2) { 
RDebugUtils.currentLine=720908;
 //BA.debugLineNum = 720908;BA.debugLine="ConfirmAndClose";
__ref._confirmandclose /*String*/ (null);
RDebugUtils.currentLine=720909;
 //BA.debugLineNum = 720909;BA.debugLine="Return";
if (true) return "";
 };
RDebugUtils.currentLine=720912;
 //BA.debugLineNum = 720912;BA.debugLine="RefreshStyles";
__ref._refreshstyles /*String*/ (null);
 };
RDebugUtils.currentLine=720914;
 //BA.debugLineNum = 720914;BA.debugLine="End Sub";
return "";
}
public String  _refreshstyles(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "refreshstyles", false))
	 {return ((String) Debug.delegate(ba, "refreshstyles", null));}
anywheresoftware.b4j.objects.LabelWrapper _lbl = null;
int _day = 0;
int _col = 0;
boolean _istoday = false;
boolean _issel = false;
boolean _isfri = false;
String _s = "";
RDebugUtils.currentLine=655360;
 //BA.debugLineNum = 655360;BA.debugLine="Private Sub RefreshStyles";
RDebugUtils.currentLine=655361;
 //BA.debugLineNum = 655361;BA.debugLine="lblMonthYear.Text = MonthNames(CurrentMonth - 1)";
__ref._lblmonthyear /*anywheresoftware.b4j.objects.LabelWrapper*/ .setText(__ref._monthnames /*String[]*/ [(int) (__ref._currentmonth /*int*/ -1)]+"  "+__ref._formatnum /*String*/ (null,__ref._currentyear /*int*/ ));
RDebugUtils.currentLine=655362;
 //BA.debugLineNum = 655362;BA.debugLine="frm.Title = FormatNum(SelectedYear) & \"/\" & Forma";
__ref._frm /*anywheresoftware.b4j.objects.Form*/ .setTitle(__ref._formatnum /*String*/ (null,__ref._selectedyear /*int*/ )+"/"+__ref._formatnum2 /*String*/ (null,__ref._selectedmonth /*int*/ )+"/"+__ref._formatnum2 /*String*/ (null,__ref._selectedday /*int*/ )+"   -   "+__ref._getdayofweekname /*String*/ (null,__ref._selectedyear /*int*/ ,__ref._selectedmonth /*int*/ ,__ref._selectedday /*int*/ ));
RDebugUtils.currentLine=655365;
 //BA.debugLineNum = 655365;BA.debugLine="For Each lbl As Label In DayLabels";
_lbl = new anywheresoftware.b4j.objects.LabelWrapper();
{
final anywheresoftware.b4a.BA.IterableList group3 = __ref._daylabels /*anywheresoftware.b4a.objects.collections.List*/ ;
final int groupLen3 = group3.getSize()
;int index3 = 0;
;
for (; index3 < groupLen3;index3++){
_lbl = (anywheresoftware.b4j.objects.LabelWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.LabelWrapper(), (javafx.scene.control.Label)(group3.Get(index3)));
RDebugUtils.currentLine=655366;
 //BA.debugLineNum = 655366;BA.debugLine="Dim day As Int = lbl.Tag";
_day = (int)(BA.ObjectToNumber(_lbl.getTag()));
RDebugUtils.currentLine=655367;
 //BA.debugLineNum = 655367;BA.debugLine="Dim col As Int = (FirstDow + day - 1) Mod 7";
_col = (int) ((__ref._firstdow /*int*/ +_day-1)%7);
RDebugUtils.currentLine=655369;
 //BA.debugLineNum = 655369;BA.debugLine="Dim isToday As Boolean = (day = TodayDay And Cur";
_istoday = (_day==__ref._todayday /*int*/  && __ref._currentmonth /*int*/ ==__ref._todaymonth /*int*/  && __ref._currentyear /*int*/ ==__ref._todayyear /*int*/ );
RDebugUtils.currentLine=655370;
 //BA.debugLineNum = 655370;BA.debugLine="Dim isSel   As Boolean = (day = SelectedDay And";
_issel = (_day==__ref._selectedday /*int*/  && __ref._currentmonth /*int*/ ==__ref._selectedmonth /*int*/  && __ref._currentyear /*int*/ ==__ref._selectedyear /*int*/ );
RDebugUtils.currentLine=655371;
 //BA.debugLineNum = 655371;BA.debugLine="Dim isFri   As Boolean = (col = 6)";
_isfri = (_col==6);
RDebugUtils.currentLine=655373;
 //BA.debugLineNum = 655373;BA.debugLine="Dim s As String = $\"${FNT} -fx-cursor: hand; -fx";
_s = (""+__c.SmartStringFormatter("",(Object)(__ref._fnt /*String*/ ))+" -fx-cursor: hand; -fx-background-radius: "+__c.SmartStringFormatter("",(Object)(__ref._cell_size /*int*/ /(double)2))+";");
RDebugUtils.currentLine=655375;
 //BA.debugLineNum = 655375;BA.debugLine="If isSel And isToday Then";
if (_issel && _istoday) { 
RDebugUtils.currentLine=655376;
 //BA.debugLineNum = 655376;BA.debugLine="s = s & $\" -fx-background-color: #1976D2; -fx-t";
_s = _s+(" -fx-background-color: #1976D2; -fx-text-fill: white; -fx-font-weight: bold; -fx-border-color: #FF5722; -fx-border-width: 2; -fx-border-radius: "+__c.SmartStringFormatter("",(Object)(__ref._cell_size /*int*/ /(double)2))+";");
 }else 
{RDebugUtils.currentLine=655377;
 //BA.debugLineNum = 655377;BA.debugLine="Else If isSel Then";
if (_issel) { 
RDebugUtils.currentLine=655378;
 //BA.debugLineNum = 655378;BA.debugLine="s = s & \" -fx-background-color: #1976D2; -fx-te";
_s = _s+" -fx-background-color: #1976D2; -fx-text-fill: white; -fx-font-weight: bold;";
 }else 
{RDebugUtils.currentLine=655379;
 //BA.debugLineNum = 655379;BA.debugLine="Else If isToday Then";
if (_istoday) { 
RDebugUtils.currentLine=655380;
 //BA.debugLineNum = 655380;BA.debugLine="s = s & $\" -fx-border-color: #FF5722; -fx-borde";
_s = _s+(" -fx-border-color: #FF5722; -fx-border-width: 2; -fx-border-radius: "+__c.SmartStringFormatter("",(Object)(__ref._cell_size /*int*/ /(double)2))+"; -fx-text-fill: #FF5722; -fx-font-weight: bold;");
 }else 
{RDebugUtils.currentLine=655381;
 //BA.debugLineNum = 655381;BA.debugLine="Else If isFri Then";
if (_isfri) { 
RDebugUtils.currentLine=655382;
 //BA.debugLineNum = 655382;BA.debugLine="s = s & \" -fx-text-fill: #E53935;\"";
_s = _s+" -fx-text-fill: #E53935;";
 }else {
RDebugUtils.currentLine=655384;
 //BA.debugLineNum = 655384;BA.debugLine="s = s & \" -fx-text-fill: #333333;\"";
_s = _s+" -fx-text-fill: #333333;";
 }}}}
;
RDebugUtils.currentLine=655387;
 //BA.debugLineNum = 655387;BA.debugLine="lbl.Style = s";
_lbl.setStyle(_s);
 }
};
RDebugUtils.currentLine=655389;
 //BA.debugLineNum = 655389;BA.debugLine="End Sub";
return "";
}
public int  _getfirstdayofweek(b4j.example.shamsidatepickerv3 __ref,int _jy,int _jm) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "getfirstdayofweek", false))
	 {return ((Integer) Debug.delegate(ba, "getfirstdayofweek", new Object[] {_jy,_jm}));}
RDebugUtils.currentLine=2228224;
 //BA.debugLineNum = 2228224;BA.debugLine="Private Sub GetFirstDayOfWeek(jy As Int, jm As Int";
RDebugUtils.currentLine=2228225;
 //BA.debugLineNum = 2228225;BA.debugLine="Return GetShamsiDayOfWeek(jy, jm, 1)";
if (true) return __ref._getshamsidayofweek /*int*/ (null,_jy,_jm,(int) (1));
RDebugUtils.currentLine=2228226;
 //BA.debugLineNum = 2228226;BA.debugLine="End Sub";
return 0;
}
public String  _formatnum(b4j.example.shamsidatepickerv3 __ref,int _n) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "formatnum", false))
	 {return ((String) Debug.delegate(ba, "formatnum", new Object[] {_n}));}
RDebugUtils.currentLine=2621440;
 //BA.debugLineNum = 2621440;BA.debugLine="Private Sub FormatNum(n As Int) As String";
RDebugUtils.currentLine=2621441;
 //BA.debugLineNum = 2621441;BA.debugLine="If UsePersianDigits Then Return ToPersianDigits(n";
if (__ref._usepersiandigits /*boolean*/ ) { 
if (true) return __ref._topersiandigits /*String*/ (null,BA.NumberToString(_n));};
RDebugUtils.currentLine=2621442;
 //BA.debugLineNum = 2621442;BA.debugLine="Return n";
if (true) return BA.NumberToString(_n);
RDebugUtils.currentLine=2621443;
 //BA.debugLineNum = 2621443;BA.debugLine="End Sub";
return "";
}
public String  _topersiandigits(b4j.example.shamsidatepickerv3 __ref,String _input) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "topersiandigits", false))
	 {return ((String) Debug.delegate(ba, "topersiandigits", new Object[] {_input}));}
String[] _en = null;
String[] _fa = null;
String _s = "";
int _i = 0;
RDebugUtils.currentLine=2752512;
 //BA.debugLineNum = 2752512;BA.debugLine="Public Sub ToPersianDigits(input As String) As Str";
RDebugUtils.currentLine=2752513;
 //BA.debugLineNum = 2752513;BA.debugLine="Dim en() As String = Array As String(\"0\",\"1\",\"2\",";
_en = new String[]{"0","1","2","3","4","5","6","7","8","9"};
RDebugUtils.currentLine=2752514;
 //BA.debugLineNum = 2752514;BA.debugLine="Dim fa() As String = Array As String(\"۰\",\"۱\",\"۲\",";
_fa = new String[]{"۰","۱","۲","۳","۴","۵","۶","۷","۸","۹"};
RDebugUtils.currentLine=2752515;
 //BA.debugLineNum = 2752515;BA.debugLine="Dim s As String = input";
_s = _input;
RDebugUtils.currentLine=2752516;
 //BA.debugLineNum = 2752516;BA.debugLine="For i = 0 To 9";
{
final int step4 = 1;
final int limit4 = (int) (9);
_i = (int) (0) ;
for (;_i <= limit4 ;_i = _i + step4 ) {
RDebugUtils.currentLine=2752517;
 //BA.debugLineNum = 2752517;BA.debugLine="s = s.Replace(en(i), fa(i))";
_s = _s.replace(_en[_i],_fa[_i]);
 }
};
RDebugUtils.currentLine=2752519;
 //BA.debugLineNum = 2752519;BA.debugLine="Return s";
if (true) return _s;
RDebugUtils.currentLine=2752520;
 //BA.debugLineNum = 2752520;BA.debugLine="End Sub";
return "";
}
public String  _formatnum2(b4j.example.shamsidatepickerv3 __ref,int _n) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "formatnum2", false))
	 {return ((String) Debug.delegate(ba, "formatnum2", new Object[] {_n}));}
String _s = "";
RDebugUtils.currentLine=2686976;
 //BA.debugLineNum = 2686976;BA.debugLine="Private Sub FormatNum2(n As Int) As String";
RDebugUtils.currentLine=2686977;
 //BA.debugLineNum = 2686977;BA.debugLine="Dim s As String = NumberFormat2(n, 2, 0, 0, False";
_s = __c.NumberFormat2(_n,(int) (2),(int) (0),(int) (0),__c.False);
RDebugUtils.currentLine=2686978;
 //BA.debugLineNum = 2686978;BA.debugLine="If UsePersianDigits Then Return ToPersianDigits(s";
if (__ref._usepersiandigits /*boolean*/ ) { 
if (true) return __ref._topersiandigits /*String*/ (null,_s);};
RDebugUtils.currentLine=2686979;
 //BA.debugLineNum = 2686979;BA.debugLine="Return s";
if (true) return _s;
RDebugUtils.currentLine=2686980;
 //BA.debugLineNum = 2686980;BA.debugLine="End Sub";
return "";
}
public String  _frm_closerequest(b4j.example.shamsidatepickerv3 __ref,anywheresoftware.b4j.objects.NodeWrapper.ConcreteEventWrapper _eventdata) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "frm_closerequest", false))
	 {return ((String) Debug.delegate(ba, "frm_closerequest", new Object[] {_eventdata}));}
RDebugUtils.currentLine=1245184;
 //BA.debugLineNum = 1245184;BA.debugLine="Private Sub frm_CloseRequest (EventData As Event)";
RDebugUtils.currentLine=1245185;
 //BA.debugLineNum = 1245185;BA.debugLine="If IsConfirmed = False Then";
if (__ref._isconfirmed /*boolean*/ ==__c.False) { 
RDebugUtils.currentLine=1245186;
 //BA.debugLineNum = 1245186;BA.debugLine="ResultYear = 0";
__ref._resultyear /*int*/  = (int) (0);
RDebugUtils.currentLine=1245187;
 //BA.debugLineNum = 1245187;BA.debugLine="ResultMonth = 0";
__ref._resultmonth /*int*/  = (int) (0);
RDebugUtils.currentLine=1245188;
 //BA.debugLineNum = 1245188;BA.debugLine="ResultDay = 0";
__ref._resultday /*int*/  = (int) (0);
 };
RDebugUtils.currentLine=1245190;
 //BA.debugLineNum = 1245190;BA.debugLine="End Sub";
return "";
}
public String  _getdayofweekname(b4j.example.shamsidatepickerv3 __ref,int _jy,int _jm,int _jd) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "getdayofweekname", false))
	 {return ((String) Debug.delegate(ba, "getdayofweekname", new Object[] {_jy,_jm,_jd}));}
RDebugUtils.currentLine=2359296;
 //BA.debugLineNum = 2359296;BA.debugLine="Public Sub GetDayOfWeekName(jy As Int, jm As Int,";
RDebugUtils.currentLine=2359297;
 //BA.debugLineNum = 2359297;BA.debugLine="Return FullDayNames(GetShamsiDayOfWeek(jy, jm, jd";
if (true) return __ref._fulldaynames /*String[]*/ [__ref._getshamsidayofweek /*int*/ (null,_jy,_jm,_jd)];
RDebugUtils.currentLine=2359298;
 //BA.debugLineNum = 2359298;BA.debugLine="End Sub";
return "";
}
public int  _getshamsidayofweek(b4j.example.shamsidatepickerv3 __ref,int _jy,int _jm,int _jd) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "getshamsidayofweek", false))
	 {return ((Integer) Debug.delegate(ba, "getshamsidayofweek", new Object[] {_jy,_jm,_jd}));}
int[] _g = null;
int _a = 0;
long _y = 0L;
int _m = 0;
long _jdn = 0L;
RDebugUtils.currentLine=2293760;
 //BA.debugLineNum = 2293760;BA.debugLine="Public Sub GetShamsiDayOfWeek(jy As Int, jm As Int";
RDebugUtils.currentLine=2293761;
 //BA.debugLineNum = 2293761;BA.debugLine="Dim g() As Int = ShamsiToGregorian(jy, jm, jd)";
_g = __ref._shamsitogregorian /*int[]*/ (null,_jy,_jm,_jd);
RDebugUtils.currentLine=2293762;
 //BA.debugLineNum = 2293762;BA.debugLine="Dim a As Int = IDiv(14 - g(1), 12)";
_a = (int) (__ref._idiv /*long*/ (null,(long) (14-_g[(int) (1)]),(long) (12)));
RDebugUtils.currentLine=2293763;
 //BA.debugLineNum = 2293763;BA.debugLine="Dim y As Long = g(0) + 4800 - a";
_y = (long) (_g[(int) (0)]+4800-_a);
RDebugUtils.currentLine=2293764;
 //BA.debugLineNum = 2293764;BA.debugLine="Dim m As Int = g(1) + (12 * a) - 3";
_m = (int) (_g[(int) (1)]+(12*_a)-3);
RDebugUtils.currentLine=2293765;
 //BA.debugLineNum = 2293765;BA.debugLine="Dim jdn As Long = g(2) + IDiv((153 * m) + 2, 5) +";
_jdn = (long) (_g[(int) (2)]+__ref._idiv /*long*/ (null,(long) ((153*_m)+2),(long) (5))+(365*_y)+__ref._idiv /*long*/ (null,_y,(long) (4))-__ref._idiv /*long*/ (null,_y,(long) (100))+__ref._idiv /*long*/ (null,_y,(long) (400))-32045);
RDebugUtils.currentLine=2293766;
 //BA.debugLineNum = 2293766;BA.debugLine="Return ((jdn Mod 7) + 2) Mod 7";
if (true) return (int) (((_jdn%7)+2)%7);
RDebugUtils.currentLine=2293767;
 //BA.debugLineNum = 2293767;BA.debugLine="End Sub";
return 0;
}
public boolean  _isleapshamsi(b4j.example.shamsidatepickerv3 __ref,int _jy) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "isleapshamsi", false))
	 {return ((Boolean) Debug.delegate(ba, "isleapshamsi", new Object[] {_jy}));}
int _r = 0;
int[] _leaps = null;
int _l = 0;
RDebugUtils.currentLine=2490368;
 //BA.debugLineNum = 2490368;BA.debugLine="Public Sub IsLeapShamsi(jy As Int) As Boolean";
RDebugUtils.currentLine=2490369;
 //BA.debugLineNum = 2490369;BA.debugLine="Dim r As Int = jy Mod 33";
_r = (int) (_jy%33);
RDebugUtils.currentLine=2490370;
 //BA.debugLineNum = 2490370;BA.debugLine="Dim leaps() As Int = Array As Int(1, 5, 9, 13, 17";
_leaps = new int[]{(int) (1),(int) (5),(int) (9),(int) (13),(int) (17),(int) (22),(int) (26),(int) (30)};
RDebugUtils.currentLine=2490371;
 //BA.debugLineNum = 2490371;BA.debugLine="For Each l As Int In leaps";
{
final int[] group3 = _leaps;
final int groupLen3 = group3.length
;int index3 = 0;
;
for (; index3 < groupLen3;index3++){
_l = group3[index3];
RDebugUtils.currentLine=2490372;
 //BA.debugLineNum = 2490372;BA.debugLine="If r = l Then Return True";
if (_r==_l) { 
if (true) return __c.True;};
 }
};
RDebugUtils.currentLine=2490374;
 //BA.debugLineNum = 2490374;BA.debugLine="Return False";
if (true) return __c.False;
RDebugUtils.currentLine=2490375;
 //BA.debugLineNum = 2490375;BA.debugLine="End Sub";
return false;
}
public double[]  _getscreenbounds(b4j.example.shamsidatepickerv3 __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "getscreenbounds", false))
	 {return ((double[]) Debug.delegate(ba, "getscreenbounds", null));}
anywheresoftware.b4j.object.JavaObject _jo = null;
anywheresoftware.b4j.object.JavaObject _primary = null;
anywheresoftware.b4j.object.JavaObject _bounds = null;
double _minx = 0;
double _miny = 0;
double _w = 0;
double _h = 0;
RDebugUtils.currentLine=524288;
 //BA.debugLineNum = 524288;BA.debugLine="Private Sub GetScreenBounds As Double()";
RDebugUtils.currentLine=524289;
 //BA.debugLineNum = 524289;BA.debugLine="Dim jo As JavaObject";
_jo = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=524290;
 //BA.debugLineNum = 524290;BA.debugLine="jo.InitializeStatic(\"javafx.stage.Screen\")";
_jo.InitializeStatic("javafx.stage.Screen");
RDebugUtils.currentLine=524291;
 //BA.debugLineNum = 524291;BA.debugLine="Dim primary As JavaObject = jo.RunMethod(\"getPrim";
_primary = new anywheresoftware.b4j.object.JavaObject();
_primary = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_jo.RunMethod("getPrimary",(Object[])(__c.Null))));
RDebugUtils.currentLine=524292;
 //BA.debugLineNum = 524292;BA.debugLine="Dim bounds As JavaObject = primary.RunMethod(\"get";
_bounds = new anywheresoftware.b4j.object.JavaObject();
_bounds = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_primary.RunMethod("getVisualBounds",(Object[])(__c.Null))));
RDebugUtils.currentLine=524294;
 //BA.debugLineNum = 524294;BA.debugLine="Dim minX As Double = bounds.RunMethod(\"getMinX\",";
_minx = (double)(BA.ObjectToNumber(_bounds.RunMethod("getMinX",(Object[])(__c.Null))));
RDebugUtils.currentLine=524295;
 //BA.debugLineNum = 524295;BA.debugLine="Dim minY As Double = bounds.RunMethod(\"getMinY\",";
_miny = (double)(BA.ObjectToNumber(_bounds.RunMethod("getMinY",(Object[])(__c.Null))));
RDebugUtils.currentLine=524296;
 //BA.debugLineNum = 524296;BA.debugLine="Dim w As Double = bounds.RunMethod(\"getWidth\", Nu";
_w = (double)(BA.ObjectToNumber(_bounds.RunMethod("getWidth",(Object[])(__c.Null))));
RDebugUtils.currentLine=524297;
 //BA.debugLineNum = 524297;BA.debugLine="Dim h As Double = bounds.RunMethod(\"getHeight\", N";
_h = (double)(BA.ObjectToNumber(_bounds.RunMethod("getHeight",(Object[])(__c.Null))));
RDebugUtils.currentLine=524299;
 //BA.debugLineNum = 524299;BA.debugLine="Return Array As Double(minX, minY, w, h)";
if (true) return new double[]{_minx,_miny,_w,_h};
RDebugUtils.currentLine=524300;
 //BA.debugLineNum = 524300;BA.debugLine="End Sub";
return null;
}
public long  _shamsitotickswithtime(b4j.example.shamsidatepickerv3 __ref,int _jy,int _jm,int _jd,int _hour,int _minute,int _second) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "shamsitotickswithtime", false))
	 {return ((Long) Debug.delegate(ba, "shamsitotickswithtime", new Object[] {_jy,_jm,_jd,_hour,_minute,_second}));}
int[] _g = null;
String _pd = "";
String _pt = "";
String _ds = "";
String _ts = "";
long _ticks = 0L;
RDebugUtils.currentLine=1703936;
 //BA.debugLineNum = 1703936;BA.debugLine="Public Sub ShamsiToTicksWithTime(jy As Int, jm As";
RDebugUtils.currentLine=1703937;
 //BA.debugLineNum = 1703937;BA.debugLine="Dim g() As Int = ShamsiToGregorian(jy, jm, jd)";
_g = __ref._shamsitogregorian /*int[]*/ (null,_jy,_jm,_jd);
RDebugUtils.currentLine=1703939;
 //BA.debugLineNum = 1703939;BA.debugLine="Dim pd As String = DateTime.DateFormat";
_pd = __c.DateTime.getDateFormat();
RDebugUtils.currentLine=1703940;
 //BA.debugLineNum = 1703940;BA.debugLine="Dim pt As String = DateTime.TimeFormat";
_pt = __c.DateTime.getTimeFormat();
RDebugUtils.currentLine=1703941;
 //BA.debugLineNum = 1703941;BA.debugLine="DateTime.DateFormat = \"yyyy/MM/dd\"";
__c.DateTime.setDateFormat("yyyy/MM/dd");
RDebugUtils.currentLine=1703942;
 //BA.debugLineNum = 1703942;BA.debugLine="DateTime.TimeFormat = \"HH:mm:ss\"";
__c.DateTime.setTimeFormat("HH:mm:ss");
RDebugUtils.currentLine=1703944;
 //BA.debugLineNum = 1703944;BA.debugLine="Dim ds As String = g(0) & \"/\" & NumberFormat2(g(1";
_ds = BA.NumberToString(_g[(int) (0)])+"/"+__c.NumberFormat2(_g[(int) (1)],(int) (2),(int) (0),(int) (0),__c.False)+"/"+__c.NumberFormat2(_g[(int) (2)],(int) (2),(int) (0),(int) (0),__c.False);
RDebugUtils.currentLine=1703945;
 //BA.debugLineNum = 1703945;BA.debugLine="Dim ts As String = NumberFormat2(hour, 2, 0, 0, F";
_ts = __c.NumberFormat2(_hour,(int) (2),(int) (0),(int) (0),__c.False)+":"+__c.NumberFormat2(_minute,(int) (2),(int) (0),(int) (0),__c.False)+":"+__c.NumberFormat2(_second,(int) (2),(int) (0),(int) (0),__c.False);
RDebugUtils.currentLine=1703947;
 //BA.debugLineNum = 1703947;BA.debugLine="Dim ticks As Long = DateTime.DateTimeParse(ds, ts";
_ticks = __c.DateTime.DateTimeParse(_ds,_ts);
RDebugUtils.currentLine=1703949;
 //BA.debugLineNum = 1703949;BA.debugLine="DateTime.DateFormat = pd";
__c.DateTime.setDateFormat(_pd);
RDebugUtils.currentLine=1703950;
 //BA.debugLineNum = 1703950;BA.debugLine="DateTime.TimeFormat = pt";
__c.DateTime.setTimeFormat(_pt);
RDebugUtils.currentLine=1703951;
 //BA.debugLineNum = 1703951;BA.debugLine="Return ticks";
if (true) return _ticks;
RDebugUtils.currentLine=1703952;
 //BA.debugLineNum = 1703952;BA.debugLine="End Sub";
return 0L;
}
public long  _getselectedtickswithtime(b4j.example.shamsidatepickerv3 __ref,int _hour,int _minute,int _second) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "getselectedtickswithtime", false))
	 {return ((Long) Debug.delegate(ba, "getselectedtickswithtime", new Object[] {_hour,_minute,_second}));}
RDebugUtils.currentLine=1572864;
 //BA.debugLineNum = 1572864;BA.debugLine="Public Sub GetSelectedTicksWithTime(hour As Int, m";
RDebugUtils.currentLine=1572865;
 //BA.debugLineNum = 1572865;BA.debugLine="Return ShamsiToTicksWithTime(ResultYear, ResultMo";
if (true) return __ref._shamsitotickswithtime /*long*/ (null,__ref._resultyear /*int*/ ,__ref._resultmonth /*int*/ ,__ref._resultday /*int*/ ,_hour,_minute,_second);
RDebugUtils.currentLine=1572866;
 //BA.debugLineNum = 1572866;BA.debugLine="End Sub";
return 0L;
}
public int[]  _shamsitogregorian(b4j.example.shamsidatepickerv3 __ref,int _jy,int _jm,int _jd) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "shamsitogregorian", false))
	 {return ((int[]) Debug.delegate(ba, "shamsitogregorian", new Object[] {_jy,_jm,_jd}));}
int _gy = 0;
int _mdays = 0;
long _days = 0L;
int _leap = 0;
int[] _md = null;
int _gd = 0;
int _gm = 0;
RDebugUtils.currentLine=2162688;
 //BA.debugLineNum = 2162688;BA.debugLine="Public Sub ShamsiToGregorian(jy As Int, jm As Int,";
RDebugUtils.currentLine=2162689;
 //BA.debugLineNum = 2162689;BA.debugLine="Dim gy As Int";
_gy = 0;
RDebugUtils.currentLine=2162690;
 //BA.debugLineNum = 2162690;BA.debugLine="If jy > 979 Then";
if (_jy>979) { 
RDebugUtils.currentLine=2162691;
 //BA.debugLineNum = 2162691;BA.debugLine="gy = 1600";
_gy = (int) (1600);
RDebugUtils.currentLine=2162692;
 //BA.debugLineNum = 2162692;BA.debugLine="jy = jy - 979";
_jy = (int) (_jy-979);
 }else {
RDebugUtils.currentLine=2162694;
 //BA.debugLineNum = 2162694;BA.debugLine="gy = 621";
_gy = (int) (621);
 };
RDebugUtils.currentLine=2162697;
 //BA.debugLineNum = 2162697;BA.debugLine="Dim mDays As Int";
_mdays = 0;
RDebugUtils.currentLine=2162698;
 //BA.debugLineNum = 2162698;BA.debugLine="If jm < 7 Then";
if (_jm<7) { 
RDebugUtils.currentLine=2162699;
 //BA.debugLineNum = 2162699;BA.debugLine="mDays = (jm - 1) * 31";
_mdays = (int) ((_jm-1)*31);
 }else {
RDebugUtils.currentLine=2162701;
 //BA.debugLineNum = 2162701;BA.debugLine="mDays = ((jm - 7) * 30) + 186";
_mdays = (int) (((_jm-7)*30)+186);
 };
RDebugUtils.currentLine=2162704;
 //BA.debugLineNum = 2162704;BA.debugLine="Dim days As Long = (365 * jy) + (IDiv(jy, 33) * 8";
_days = (long) ((365*_jy)+(__ref._idiv /*long*/ (null,(long) (_jy),(long) (33))*8)+__ref._idiv /*long*/ (null,(long) ((_jy%33)+3),(long) (4))+78+_jd+_mdays);
RDebugUtils.currentLine=2162706;
 //BA.debugLineNum = 2162706;BA.debugLine="gy = gy + 400 * IDiv(days, 146097)";
_gy = (int) (_gy+400*__ref._idiv /*long*/ (null,_days,(long) (146097)));
RDebugUtils.currentLine=2162707;
 //BA.debugLineNum = 2162707;BA.debugLine="days = days Mod 146097";
_days = (long) (_days%146097);
RDebugUtils.currentLine=2162709;
 //BA.debugLineNum = 2162709;BA.debugLine="If days > 36524 Then";
if (_days>36524) { 
RDebugUtils.currentLine=2162710;
 //BA.debugLineNum = 2162710;BA.debugLine="days = days - 1";
_days = (long) (_days-1);
RDebugUtils.currentLine=2162711;
 //BA.debugLineNum = 2162711;BA.debugLine="gy = gy + 100 * IDiv(days, 36524)";
_gy = (int) (_gy+100*__ref._idiv /*long*/ (null,_days,(long) (36524)));
RDebugUtils.currentLine=2162712;
 //BA.debugLineNum = 2162712;BA.debugLine="days = days Mod 36524";
_days = (long) (_days%36524);
RDebugUtils.currentLine=2162713;
 //BA.debugLineNum = 2162713;BA.debugLine="If days >= 365 Then days = days + 1";
if (_days>=365) { 
_days = (long) (_days+1);};
 };
RDebugUtils.currentLine=2162716;
 //BA.debugLineNum = 2162716;BA.debugLine="gy = gy + 4 * IDiv(days, 1461)";
_gy = (int) (_gy+4*__ref._idiv /*long*/ (null,_days,(long) (1461)));
RDebugUtils.currentLine=2162717;
 //BA.debugLineNum = 2162717;BA.debugLine="days = days Mod 1461";
_days = (long) (_days%1461);
RDebugUtils.currentLine=2162719;
 //BA.debugLineNum = 2162719;BA.debugLine="If days > 365 Then";
if (_days>365) { 
RDebugUtils.currentLine=2162720;
 //BA.debugLineNum = 2162720;BA.debugLine="gy = gy + IDiv(days - 1, 365)";
_gy = (int) (_gy+__ref._idiv /*long*/ (null,(long) (_days-1),(long) (365)));
RDebugUtils.currentLine=2162721;
 //BA.debugLineNum = 2162721;BA.debugLine="days = (days - 1) Mod 365";
_days = (long) ((_days-1)%365);
 };
RDebugUtils.currentLine=2162724;
 //BA.debugLineNum = 2162724;BA.debugLine="Dim leap As Int = 0";
_leap = (int) (0);
RDebugUtils.currentLine=2162725;
 //BA.debugLineNum = 2162725;BA.debugLine="If (gy Mod 4 = 0 And gy Mod 100 <> 0) Or (gy Mod";
if ((_gy%4==0 && _gy%100!=0) || (_gy%400==0)) { 
_leap = (int) (1);};
RDebugUtils.currentLine=2162726;
 //BA.debugLineNum = 2162726;BA.debugLine="Dim md() As Int = Array As Int(31, 28 + leap, 31,";
_md = new int[]{(int) (31),(int) (28+_leap),(int) (31),(int) (30),(int) (31),(int) (30),(int) (31),(int) (31),(int) (30),(int) (31),(int) (30),(int) (31)};
RDebugUtils.currentLine=2162728;
 //BA.debugLineNum = 2162728;BA.debugLine="Dim gd As Int = days + 1";
_gd = (int) (_days+1);
RDebugUtils.currentLine=2162729;
 //BA.debugLineNum = 2162729;BA.debugLine="Dim gm As Int = 0";
_gm = (int) (0);
RDebugUtils.currentLine=2162730;
 //BA.debugLineNum = 2162730;BA.debugLine="Do While gm < 12 And gd > md(gm)";
while (_gm<12 && _gd>_md[_gm]) {
RDebugUtils.currentLine=2162731;
 //BA.debugLineNum = 2162731;BA.debugLine="gd = gd - md(gm)";
_gd = (int) (_gd-_md[_gm]);
RDebugUtils.currentLine=2162732;
 //BA.debugLineNum = 2162732;BA.debugLine="gm = gm + 1";
_gm = (int) (_gm+1);
 }
;
RDebugUtils.currentLine=2162735;
 //BA.debugLineNum = 2162735;BA.debugLine="Return Array As Int(gy, gm + 1, gd)";
if (true) return new int[]{_gy,(int) (_gm+1),_gd};
RDebugUtils.currentLine=2162736;
 //BA.debugLineNum = 2162736;BA.debugLine="End Sub";
return null;
}
public long  _idiv(b4j.example.shamsidatepickerv3 __ref,long _a,long _b) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "idiv", false))
	 {return ((Long) Debug.delegate(ba, "idiv", new Object[] {_a,_b}));}
RDebugUtils.currentLine=2555904;
 //BA.debugLineNum = 2555904;BA.debugLine="Private Sub IDiv(a As Long, b As Long) As Long";
RDebugUtils.currentLine=2555905;
 //BA.debugLineNum = 2555905;BA.debugLine="Return Floor(a / b)";
if (true) return (long) (__c.Floor(_a/(double)_b));
RDebugUtils.currentLine=2555906;
 //BA.debugLineNum = 2555906;BA.debugLine="End Sub";
return 0L;
}
public String  _positionform(b4j.example.shamsidatepickerv3 __ref,anywheresoftware.b4j.objects.Form _owner,anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper _anchor) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "positionform", false))
	 {return ((String) Debug.delegate(ba, "positionform", new Object[] {_owner,_anchor}));}
double _x = 0;
double _y = 0;
boolean _hasowner = false;
boolean _placed = false;
anywheresoftware.b4j.object.JavaObject _jo = null;
anywheresoftware.b4j.object.JavaObject _b = null;
double _nw = 0;
double _nh = 0;
anywheresoftware.b4j.object.JavaObject _pt = null;
double _sx = 0;
double _sy = 0;
double[] _scrbounds = null;
double _ol = 0;
double _ot = 0;
double _ow = 0;
double _oh = 0;
double[] _scr = null;
double _sl = 0;
double _st = 0;
double _sw = 0;
double _sh = 0;
RDebugUtils.currentLine=458752;
 //BA.debugLineNum = 458752;BA.debugLine="Private Sub PositionForm(owner As Form, anchor As";
RDebugUtils.currentLine=458753;
 //BA.debugLineNum = 458753;BA.debugLine="Dim x, y As Double";
_x = 0;
_y = 0;
RDebugUtils.currentLine=458754;
 //BA.debugLineNum = 458754;BA.debugLine="Dim hasOwner As Boolean = owner.IsInitialized";
_hasowner = _owner.IsInitialized();
RDebugUtils.currentLine=458755;
 //BA.debugLineNum = 458755;BA.debugLine="Dim placed As Boolean = False";
_placed = __c.False;
RDebugUtils.currentLine=458758;
 //BA.debugLineNum = 458758;BA.debugLine="If anchor <> Null Then";
if (_anchor!= null) { 
RDebugUtils.currentLine=458759;
 //BA.debugLineNum = 458759;BA.debugLine="If anchor.IsInitialized Then";
if (_anchor.IsInitialized()) { 
RDebugUtils.currentLine=458760;
 //BA.debugLineNum = 458760;BA.debugLine="Try";
try {RDebugUtils.currentLine=458761;
 //BA.debugLineNum = 458761;BA.debugLine="Dim jo As JavaObject = anchor";
_jo = new anywheresoftware.b4j.object.JavaObject();
_jo = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_anchor.getObject()));
RDebugUtils.currentLine=458762;
 //BA.debugLineNum = 458762;BA.debugLine="Dim b As JavaObject = jo.RunMethodJO(\"getBound";
_b = new anywheresoftware.b4j.object.JavaObject();
_b = _jo.RunMethodJO("getBoundsInLocal",(Object[])(__c.Null));
RDebugUtils.currentLine=458763;
 //BA.debugLineNum = 458763;BA.debugLine="Dim nw As Double = b.RunMethod(\"getWidth\", Nul";
_nw = (double)(BA.ObjectToNumber(_b.RunMethod("getWidth",(Object[])(__c.Null))));
RDebugUtils.currentLine=458764;
 //BA.debugLineNum = 458764;BA.debugLine="Dim nh As Double = b.RunMethod(\"getHeight\", Nu";
_nh = (double)(BA.ObjectToNumber(_b.RunMethod("getHeight",(Object[])(__c.Null))));
RDebugUtils.currentLine=458766;
 //BA.debugLineNum = 458766;BA.debugLine="Dim pt As JavaObject = jo.RunMethodJO(\"localTo";
_pt = new anywheresoftware.b4j.object.JavaObject();
_pt = _jo.RunMethodJO("localToScreen",new Object[]{(Object)(0.0),(Object)(_nh)});
RDebugUtils.currentLine=458767;
 //BA.debugLineNum = 458767;BA.debugLine="Dim sx As Double = pt.RunMethod(\"getX\", Null)";
_sx = (double)(BA.ObjectToNumber(_pt.RunMethod("getX",(Object[])(__c.Null))));
RDebugUtils.currentLine=458768;
 //BA.debugLineNum = 458768;BA.debugLine="Dim sy As Double = pt.RunMethod(\"getY\", Null)";
_sy = (double)(BA.ObjectToNumber(_pt.RunMethod("getY",(Object[])(__c.Null))));
RDebugUtils.currentLine=458770;
 //BA.debugLineNum = 458770;BA.debugLine="x = sx + nw - FORM_WIDTH";
_x = _sx+_nw-__ref._form_width /*int*/ ;
RDebugUtils.currentLine=458771;
 //BA.debugLineNum = 458771;BA.debugLine="y = sy + 2";
_y = _sy+2;
RDebugUtils.currentLine=458772;
 //BA.debugLineNum = 458772;BA.debugLine="placed = True";
_placed = __c.True;
 } 
       catch (Exception e18) {
			ba.setLastException(e18);RDebugUtils.currentLine=458774;
 //BA.debugLineNum = 458774;BA.debugLine="placed = False";
_placed = __c.False;
 };
 };
 };
RDebugUtils.currentLine=458780;
 //BA.debugLineNum = 458780;BA.debugLine="If placed = False Then";
if (_placed==__c.False) { 
RDebugUtils.currentLine=458781;
 //BA.debugLineNum = 458781;BA.debugLine="If hasOwner Then";
if (_hasowner) { 
RDebugUtils.currentLine=458782;
 //BA.debugLineNum = 458782;BA.debugLine="x = owner.WindowLeft + (owner.WindowWidth - FOR";
_x = _owner.getWindowLeft()+(_owner.getWindowWidth()-__ref._form_width /*int*/ )/(double)2;
RDebugUtils.currentLine=458783;
 //BA.debugLineNum = 458783;BA.debugLine="y = owner.WindowTop + (owner.WindowHeight - FOR";
_y = _owner.getWindowTop()+(_owner.getWindowHeight()-__ref._form_height /*int*/ )/(double)2;
 }else {
RDebugUtils.currentLine=458785;
 //BA.debugLineNum = 458785;BA.debugLine="Dim scrBounds() As Double = GetScreenBounds";
_scrbounds = __ref._getscreenbounds /*double[]*/ (null);
RDebugUtils.currentLine=458786;
 //BA.debugLineNum = 458786;BA.debugLine="x = scrBounds(0) + (scrBounds(2) - FORM_WIDTH)";
_x = _scrbounds[(int) (0)]+(_scrbounds[(int) (2)]-__ref._form_width /*int*/ )/(double)2;
RDebugUtils.currentLine=458787;
 //BA.debugLineNum = 458787;BA.debugLine="y = scrBounds(1) + (scrBounds(3) - FORM_HEIGHT)";
_y = _scrbounds[(int) (1)]+(_scrbounds[(int) (3)]-__ref._form_height /*int*/ )/(double)2;
 };
 };
RDebugUtils.currentLine=458792;
 //BA.debugLineNum = 458792;BA.debugLine="If hasOwner Then";
if (_hasowner) { 
RDebugUtils.currentLine=458793;
 //BA.debugLineNum = 458793;BA.debugLine="Dim oL As Double = owner.WindowLeft";
_ol = _owner.getWindowLeft();
RDebugUtils.currentLine=458794;
 //BA.debugLineNum = 458794;BA.debugLine="Dim oT As Double = owner.WindowTop";
_ot = _owner.getWindowTop();
RDebugUtils.currentLine=458795;
 //BA.debugLineNum = 458795;BA.debugLine="Dim oW As Double = owner.WindowWidth";
_ow = _owner.getWindowWidth();
RDebugUtils.currentLine=458796;
 //BA.debugLineNum = 458796;BA.debugLine="Dim oH As Double = owner.WindowHeight";
_oh = _owner.getWindowHeight();
RDebugUtils.currentLine=458798;
 //BA.debugLineNum = 458798;BA.debugLine="If oW >= FORM_WIDTH Then";
if (_ow>=__ref._form_width /*int*/ ) { 
RDebugUtils.currentLine=458799;
 //BA.debugLineNum = 458799;BA.debugLine="If x < oL Then x = oL";
if (_x<_ol) { 
_x = _ol;};
RDebugUtils.currentLine=458800;
 //BA.debugLineNum = 458800;BA.debugLine="If x + FORM_WIDTH > oL + oW Then x = oL + oW -";
if (_x+__ref._form_width /*int*/ >_ol+_ow) { 
_x = _ol+_ow-__ref._form_width /*int*/ ;};
 }else {
RDebugUtils.currentLine=458802;
 //BA.debugLineNum = 458802;BA.debugLine="x = oL + (oW - FORM_WIDTH) / 2";
_x = _ol+(_ow-__ref._form_width /*int*/ )/(double)2;
 };
RDebugUtils.currentLine=458805;
 //BA.debugLineNum = 458805;BA.debugLine="If oH >= FORM_HEIGHT Then";
if (_oh>=__ref._form_height /*int*/ ) { 
RDebugUtils.currentLine=458806;
 //BA.debugLineNum = 458806;BA.debugLine="If y < oT Then y = oT";
if (_y<_ot) { 
_y = _ot;};
RDebugUtils.currentLine=458807;
 //BA.debugLineNum = 458807;BA.debugLine="If y + FORM_HEIGHT > oT + oH Then y = oT + oH -";
if (_y+__ref._form_height /*int*/ >_ot+_oh) { 
_y = _ot+_oh-__ref._form_height /*int*/ ;};
 }else {
RDebugUtils.currentLine=458809;
 //BA.debugLineNum = 458809;BA.debugLine="y = oT + (oH - FORM_HEIGHT) / 2";
_y = _ot+(_oh-__ref._form_height /*int*/ )/(double)2;
 };
 };
RDebugUtils.currentLine=458814;
 //BA.debugLineNum = 458814;BA.debugLine="Dim scr() As Double = GetScreenBounds";
_scr = __ref._getscreenbounds /*double[]*/ (null);
RDebugUtils.currentLine=458815;
 //BA.debugLineNum = 458815;BA.debugLine="Dim sL As Double = scr(0)";
_sl = _scr[(int) (0)];
RDebugUtils.currentLine=458816;
 //BA.debugLineNum = 458816;BA.debugLine="Dim sT As Double = scr(1)";
_st = _scr[(int) (1)];
RDebugUtils.currentLine=458817;
 //BA.debugLineNum = 458817;BA.debugLine="Dim sW As Double = scr(2)";
_sw = _scr[(int) (2)];
RDebugUtils.currentLine=458818;
 //BA.debugLineNum = 458818;BA.debugLine="Dim sH As Double = scr(3)";
_sh = _scr[(int) (3)];
RDebugUtils.currentLine=458820;
 //BA.debugLineNum = 458820;BA.debugLine="If x < sL Then x = sL";
if (_x<_sl) { 
_x = _sl;};
RDebugUtils.currentLine=458821;
 //BA.debugLineNum = 458821;BA.debugLine="If y < sT Then y = sT";
if (_y<_st) { 
_y = _st;};
RDebugUtils.currentLine=458822;
 //BA.debugLineNum = 458822;BA.debugLine="If x + FORM_WIDTH > sL + sW Then x = sL + sW - FO";
if (_x+__ref._form_width /*int*/ >_sl+_sw) { 
_x = _sl+_sw-__ref._form_width /*int*/ ;};
RDebugUtils.currentLine=458823;
 //BA.debugLineNum = 458823;BA.debugLine="If y + FORM_HEIGHT > sT + sH Then y = sL + sH - F";
if (_y+__ref._form_height /*int*/ >_st+_sh) { 
_y = _sl+_sh-__ref._form_height /*int*/ ;};
RDebugUtils.currentLine=458825;
 //BA.debugLineNum = 458825;BA.debugLine="frm.WindowLeft = x";
__ref._frm /*anywheresoftware.b4j.objects.Form*/ .setWindowLeft(_x);
RDebugUtils.currentLine=458826;
 //BA.debugLineNum = 458826;BA.debugLine="frm.WindowTop = y";
__ref._frm /*anywheresoftware.b4j.objects.Form*/ .setWindowTop(_y);
RDebugUtils.currentLine=458827;
 //BA.debugLineNum = 458827;BA.debugLine="End Sub";
return "";
}
public String  _setdate(b4j.example.shamsidatepickerv3 __ref,int _year,int _month,int _day) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "setdate", false))
	 {return ((String) Debug.delegate(ba, "setdate", new Object[] {_year,_month,_day}));}
RDebugUtils.currentLine=1900544;
 //BA.debugLineNum = 1900544;BA.debugLine="Public Sub SetDate(year As Int, month As Int, day";
RDebugUtils.currentLine=1900545;
 //BA.debugLineNum = 1900545;BA.debugLine="SelectedYear = year";
__ref._selectedyear /*int*/  = _year;
RDebugUtils.currentLine=1900546;
 //BA.debugLineNum = 1900546;BA.debugLine="SelectedMonth = month";
__ref._selectedmonth /*int*/  = _month;
RDebugUtils.currentLine=1900547;
 //BA.debugLineNum = 1900547;BA.debugLine="SelectedDay = day";
__ref._selectedday /*int*/  = _day;
RDebugUtils.currentLine=1900548;
 //BA.debugLineNum = 1900548;BA.debugLine="CurrentYear = year";
__ref._currentyear /*int*/  = _year;
RDebugUtils.currentLine=1900549;
 //BA.debugLineNum = 1900549;BA.debugLine="CurrentMonth = month";
__ref._currentmonth /*int*/  = _month;
RDebugUtils.currentLine=1900550;
 //BA.debugLineNum = 1900550;BA.debugLine="End Sub";
return "";
}
public String  _setdatefromticks(b4j.example.shamsidatepickerv3 __ref,long _ticks) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "setdatefromticks", false))
	 {return ((String) Debug.delegate(ba, "setdatefromticks", new Object[] {_ticks}));}
int[] _j = null;
RDebugUtils.currentLine=1966080;
 //BA.debugLineNum = 1966080;BA.debugLine="Public Sub SetDateFromTicks(ticks As Long)";
RDebugUtils.currentLine=1966081;
 //BA.debugLineNum = 1966081;BA.debugLine="Dim j() As Int = TicksToShamsi(ticks)";
_j = __ref._tickstoshamsi /*int[]*/ (null,_ticks);
RDebugUtils.currentLine=1966082;
 //BA.debugLineNum = 1966082;BA.debugLine="SetDate(j(0), j(1), j(2))";
__ref._setdate /*String*/ (null,_j[(int) (0)],_j[(int) (1)],_j[(int) (2)]);
RDebugUtils.currentLine=1966083;
 //BA.debugLineNum = 1966083;BA.debugLine="End Sub";
return "";
}
public int[]  _tickstoshamsi(b4j.example.shamsidatepickerv3 __ref,long _ticks) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "tickstoshamsi", false))
	 {return ((int[]) Debug.delegate(ba, "tickstoshamsi", new Object[] {_ticks}));}
RDebugUtils.currentLine=1769472;
 //BA.debugLineNum = 1769472;BA.debugLine="Public Sub TicksToShamsi(ticks As Long) As Int()";
RDebugUtils.currentLine=1769473;
 //BA.debugLineNum = 1769473;BA.debugLine="Return GregorianToShamsi(DateTime.GetYear(ticks),";
if (true) return __ref._gregoriantoshamsi /*int[]*/ (null,__c.DateTime.GetYear(_ticks),__c.DateTime.GetMonth(_ticks),__c.DateTime.GetDayOfMonth(_ticks));
RDebugUtils.currentLine=1769474;
 //BA.debugLineNum = 1769474;BA.debugLine="End Sub";
return null;
}
public long  _shamsitoticks(b4j.example.shamsidatepickerv3 __ref,int _jy,int _jm,int _jd) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "shamsitoticks", false))
	 {return ((Long) Debug.delegate(ba, "shamsitoticks", new Object[] {_jy,_jm,_jd}));}
long _n = 0L;
RDebugUtils.currentLine=1638400;
 //BA.debugLineNum = 1638400;BA.debugLine="Public Sub ShamsiToTicks(jy As Int, jm As Int, jd";
RDebugUtils.currentLine=1638401;
 //BA.debugLineNum = 1638401;BA.debugLine="Dim n As Long = DateTime.Now";
_n = __c.DateTime.getNow();
RDebugUtils.currentLine=1638402;
 //BA.debugLineNum = 1638402;BA.debugLine="Return ShamsiToTicksWithTime(jy, jm, jd, DateTime";
if (true) return __ref._shamsitotickswithtime /*long*/ (null,_jy,_jm,_jd,__c.DateTime.GetHour(_n),__c.DateTime.GetMinute(_n),__c.DateTime.GetSecond(_n));
RDebugUtils.currentLine=1638403;
 //BA.debugLineNum = 1638403;BA.debugLine="End Sub";
return 0L;
}
public boolean  _showat(b4j.example.shamsidatepickerv3 __ref,anywheresoftware.b4j.objects.Form _owner,anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper _anchor) throws Exception{
__ref = this;
RDebugUtils.currentModule="shamsidatepickerv3";
if (Debug.shouldDelegate(ba, "showat", false))
	 {return ((Boolean) Debug.delegate(ba, "showat", new Object[] {_owner,_anchor}));}
RDebugUtils.currentLine=393216;
 //BA.debugLineNum = 393216;BA.debugLine="Public Sub ShowAt(owner As Form, anchor As Node) A";
RDebugUtils.currentLine=393217;
 //BA.debugLineNum = 393217;BA.debugLine="IsConfirmed = False";
__ref._isconfirmed /*boolean*/  = __c.False;
RDebugUtils.currentLine=393219;
 //BA.debugLineNum = 393219;BA.debugLine="frm.Initialize(\"frm\", FORM_WIDTH, FORM_HEIGHT)";
__ref._frm /*anywheresoftware.b4j.objects.Form*/ .Initialize(ba,"frm",__ref._form_width /*int*/ ,__ref._form_height /*int*/ );
RDebugUtils.currentLine=393220;
 //BA.debugLineNum = 393220;BA.debugLine="frm.Resizable = False";
__ref._frm /*anywheresoftware.b4j.objects.Form*/ .setResizable(__c.False);
RDebugUtils.currentLine=393221;
 //BA.debugLineNum = 393221;BA.debugLine="If owner.IsInitialized Then frm.SetOwner(owner)";
if (_owner.IsInitialized()) { 
__ref._frm /*anywheresoftware.b4j.objects.Form*/ .SetOwner(_owner);};
RDebugUtils.currentLine=393223;
 //BA.debugLineNum = 393223;BA.debugLine="MainPane = frm.RootPane";
__ref._mainpane /*anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper*/  = (anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper(), (javafx.scene.layout.Pane)(__ref._frm /*anywheresoftware.b4j.objects.Form*/ .getRootPane().getObject()));
RDebugUtils.currentLine=393224;
 //BA.debugLineNum = 393224;BA.debugLine="MainPane.Style = \"-fx-background-color: #FFFFFF;\"";
__ref._mainpane /*anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper*/ .setStyle("-fx-background-color: #FFFFFF;");
RDebugUtils.currentLine=393226;
 //BA.debugLineNum = 393226;BA.debugLine="DrawCalendar";
__ref._drawcalendar /*String*/ (null);
RDebugUtils.currentLine=393227;
 //BA.debugLineNum = 393227;BA.debugLine="PositionForm(owner, anchor)";
__ref._positionform /*String*/ (null,_owner,_anchor);
RDebugUtils.currentLine=393229;
 //BA.debugLineNum = 393229;BA.debugLine="frm.ShowAndWait";
__ref._frm /*anywheresoftware.b4j.objects.Form*/ .ShowAndWait();
RDebugUtils.currentLine=393230;
 //BA.debugLineNum = 393230;BA.debugLine="Return IsConfirmed";
if (true) return __ref._isconfirmed /*boolean*/ ;
RDebugUtils.currentLine=393231;
 //BA.debugLineNum = 393231;BA.debugLine="End Sub";
return false;
}
}