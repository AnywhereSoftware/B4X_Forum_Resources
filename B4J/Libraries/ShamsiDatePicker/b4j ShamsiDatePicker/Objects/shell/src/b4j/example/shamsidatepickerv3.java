
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class shamsidatepickerv3 {
    public static RemoteObject myClass;
	public shamsidatepickerv3() {
	}
    public static PCBA staticBA = new PCBA(null, shamsidatepickerv3.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _fx = RemoteObject.declareNull("anywheresoftware.b4j.objects.JFX");
public static RemoteObject _frm = RemoteObject.declareNull("anywheresoftware.b4j.objects.Form");
public static RemoteObject _mainpane = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
public static RemoteObject _currentyear = RemoteObject.createImmutable(0);
public static RemoteObject _currentmonth = RemoteObject.createImmutable(0);
public static RemoteObject _selectedyear = RemoteObject.createImmutable(0);
public static RemoteObject _selectedmonth = RemoteObject.createImmutable(0);
public static RemoteObject _selectedday = RemoteObject.createImmutable(0);
public static RemoteObject _todayyear = RemoteObject.createImmutable(0);
public static RemoteObject _todaymonth = RemoteObject.createImmutable(0);
public static RemoteObject _todayday = RemoteObject.createImmutable(0);
public static RemoteObject _resultyear = RemoteObject.createImmutable(0);
public static RemoteObject _resultmonth = RemoteObject.createImmutable(0);
public static RemoteObject _resultday = RemoteObject.createImmutable(0);
public static RemoteObject _isconfirmed = RemoteObject.createImmutable(false);
public static RemoteObject _usepersiandigits = RemoteObject.createImmutable(false);
public static RemoteObject _monthnames = null;
public static RemoteObject _daynames = null;
public static RemoteObject _fulldaynames = null;
public static RemoteObject _cell_size = RemoteObject.createImmutable(0);
public static RemoteObject _form_width = RemoteObject.createImmutable(0);
public static RemoteObject _form_height = RemoteObject.createImmutable(0);
public static RemoteObject _fnt = RemoteObject.createImmutable("");
public static RemoteObject _daylabels = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static RemoteObject _firstdow = RemoteObject.createImmutable(0);
public static RemoteObject _lblmonthyear = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
public static b4j.example.main _main = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"CELL_SIZE",_ref.getField(false, "_cell_size"),"CurrentMonth",_ref.getField(false, "_currentmonth"),"CurrentYear",_ref.getField(false, "_currentyear"),"DayLabels",_ref.getField(false, "_daylabels"),"DayNames",_ref.getField(false, "_daynames"),"FirstDow",_ref.getField(false, "_firstdow"),"FNT",_ref.getField(false, "_fnt"),"FORM_HEIGHT",_ref.getField(false, "_form_height"),"FORM_WIDTH",_ref.getField(false, "_form_width"),"frm",_ref.getField(false, "_frm"),"FullDayNames",_ref.getField(false, "_fulldaynames"),"fx",_ref.getField(false, "_fx"),"IsConfirmed",_ref.getField(false, "_isconfirmed"),"lblMonthYear",_ref.getField(false, "_lblmonthyear"),"MainPane",_ref.getField(false, "_mainpane"),"MonthNames",_ref.getField(false, "_monthnames"),"ResultDay",_ref.getField(false, "_resultday"),"ResultMonth",_ref.getField(false, "_resultmonth"),"ResultYear",_ref.getField(false, "_resultyear"),"SelectedDay",_ref.getField(false, "_selectedday"),"SelectedMonth",_ref.getField(false, "_selectedmonth"),"SelectedYear",_ref.getField(false, "_selectedyear"),"TodayDay",_ref.getField(false, "_todayday"),"TodayMonth",_ref.getField(false, "_todaymonth"),"TodayYear",_ref.getField(false, "_todayyear"),"UsePersianDigits",_ref.getField(false, "_usepersiandigits")};
}
}