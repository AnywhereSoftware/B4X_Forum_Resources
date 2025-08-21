package b4a.Sudoku;


import anywheresoftware.b4a.B4AMenuItem;
import android.app.Activity;
import android.os.Bundle;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.B4AActivity;
import anywheresoftware.b4a.ObjectWrapper;
import anywheresoftware.b4a.objects.ActivityWrapper;
import java.lang.reflect.InvocationTargetException;
import anywheresoftware.b4a.B4AUncaughtException;
import anywheresoftware.b4a.debug.*;
import java.lang.ref.WeakReference;

public class main extends Activity implements B4AActivity{
	public static main mostCurrent;
	static boolean afterFirstLayout;
	static boolean isFirst = true;
    private static boolean processGlobalsRun = false;
	BALayout layout;
	public static BA processBA;
	BA activityBA;
    ActivityWrapper _activity;
    java.util.ArrayList<B4AMenuItem> menuItems;
	public static final boolean fullScreen = true;
	public static final boolean includeTitle = false;
    public static WeakReference<Activity> previousOne;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
        mostCurrent = this;
		if (processBA == null) {
			processBA = new BA(this.getApplicationContext(), null, null, "b4a.Sudoku", "b4a.Sudoku.main");
			processBA.loadHtSubs(this.getClass());
	        float deviceScale = getApplicationContext().getResources().getDisplayMetrics().density;
	        BALayout.setDeviceScale(deviceScale);
            
		}
		else if (previousOne != null) {
			Activity p = previousOne.get();
			if (p != null && p != this) {
                BA.LogInfo("Killing previous instance (main).");
				p.finish();
			}
		}
        processBA.setActivityPaused(true);
        processBA.runHook("oncreate", this, null);
		if (!includeTitle) {
        	this.getWindow().requestFeature(android.view.Window.FEATURE_NO_TITLE);
        }
        if (fullScreen) {
        	getWindow().setFlags(android.view.WindowManager.LayoutParams.FLAG_FULLSCREEN,   
        			android.view.WindowManager.LayoutParams.FLAG_FULLSCREEN);
        }
		
        processBA.sharedProcessBA.activityBA = null;
		layout = new BALayout(this);
		setContentView(layout);
		afterFirstLayout = false;
        WaitForLayout wl = new WaitForLayout();
        if (anywheresoftware.b4a.objects.ServiceHelper.StarterHelper.startFromActivity(this, processBA, wl, false))
		    BA.handler.postDelayed(wl, 5);

	}
	static class WaitForLayout implements Runnable {
		public void run() {
			if (afterFirstLayout)
				return;
			if (mostCurrent == null)
				return;
            
			if (mostCurrent.layout.getWidth() == 0) {
				BA.handler.postDelayed(this, 5);
				return;
			}
			mostCurrent.layout.getLayoutParams().height = mostCurrent.layout.getHeight();
			mostCurrent.layout.getLayoutParams().width = mostCurrent.layout.getWidth();
			afterFirstLayout = true;
			mostCurrent.afterFirstLayout();
		}
	}
	private void afterFirstLayout() {
        if (this != mostCurrent)
			return;
		activityBA = new BA(this, layout, processBA, "b4a.Sudoku", "b4a.Sudoku.main");
        
        processBA.sharedProcessBA.activityBA = new java.lang.ref.WeakReference<BA>(activityBA);
        anywheresoftware.b4a.objects.ViewWrapper.lastId = 0;
        _activity = new ActivityWrapper(activityBA, "activity");
        anywheresoftware.b4a.Msgbox.isDismissing = false;
        if (BA.isShellModeRuntimeCheck(processBA)) {
			if (isFirst)
				processBA.raiseEvent2(null, true, "SHELL", false);
			processBA.raiseEvent2(null, true, "CREATE", true, "b4a.Sudoku.main", processBA, activityBA, _activity, anywheresoftware.b4a.keywords.Common.Density, mostCurrent);
			_activity.reinitializeForShell(activityBA, "activity");
		}
        initializeProcessGlobals();		
        initializeGlobals();
        
        BA.LogInfo("** Activity (main) Create, isFirst = " + isFirst + " **");
        processBA.raiseEvent2(null, true, "activity_create", false, isFirst);
		isFirst = false;
		if (this != mostCurrent)
			return;
        processBA.setActivityPaused(false);
        BA.LogInfo("** Activity (main) Resume **");
        processBA.raiseEvent(null, "activity_resume");
        if (android.os.Build.VERSION.SDK_INT >= 11) {
			try {
				android.app.Activity.class.getMethod("invalidateOptionsMenu").invoke(this,(Object[]) null);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}
	public void addMenuItem(B4AMenuItem item) {
		if (menuItems == null)
			menuItems = new java.util.ArrayList<B4AMenuItem>();
		menuItems.add(item);
	}
	@Override
	public boolean onCreateOptionsMenu(android.view.Menu menu) {
		super.onCreateOptionsMenu(menu);
        try {
            if (processBA.subExists("activity_actionbarhomeclick")) {
                Class.forName("android.app.ActionBar").getMethod("setHomeButtonEnabled", boolean.class).invoke(
                    getClass().getMethod("getActionBar").invoke(this), true);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (processBA.runHook("oncreateoptionsmenu", this, new Object[] {menu}))
            return true;
		if (menuItems == null)
			return false;
		for (B4AMenuItem bmi : menuItems) {
			android.view.MenuItem mi = menu.add(bmi.title);
			if (bmi.drawable != null)
				mi.setIcon(bmi.drawable);
            if (android.os.Build.VERSION.SDK_INT >= 11) {
				try {
                    if (bmi.addToBar) {
				        android.view.MenuItem.class.getMethod("setShowAsAction", int.class).invoke(mi, 1);
                    }
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			mi.setOnMenuItemClickListener(new B4AMenuItemsClickListener(bmi.eventName.toLowerCase(BA.cul)));
		}
        
		return true;
	}   
 @Override
 public boolean onOptionsItemSelected(android.view.MenuItem item) {
    if (item.getItemId() == 16908332) {
        processBA.raiseEvent(null, "activity_actionbarhomeclick");
        return true;
    }
    else
        return super.onOptionsItemSelected(item); 
}
@Override
 public boolean onPrepareOptionsMenu(android.view.Menu menu) {
    super.onPrepareOptionsMenu(menu);
    processBA.runHook("onprepareoptionsmenu", this, new Object[] {menu});
    return true;
    
 }
 protected void onStart() {
    super.onStart();
    processBA.runHook("onstart", this, null);
}
 protected void onStop() {
    super.onStop();
    processBA.runHook("onstop", this, null);
}
    public void onWindowFocusChanged(boolean hasFocus) {
       super.onWindowFocusChanged(hasFocus);
       if (processBA.subExists("activity_windowfocuschanged"))
           processBA.raiseEvent2(null, true, "activity_windowfocuschanged", false, hasFocus);
    }
	private class B4AMenuItemsClickListener implements android.view.MenuItem.OnMenuItemClickListener {
		private final String eventName;
		public B4AMenuItemsClickListener(String eventName) {
			this.eventName = eventName;
		}
		public boolean onMenuItemClick(android.view.MenuItem item) {
			processBA.raiseEventFromUI(item.getTitle(), eventName + "_click");
			return true;
		}
	}
    public static Class<?> getObject() {
		return main.class;
	}
    private Boolean onKeySubExist = null;
    private Boolean onKeyUpSubExist = null;
	@Override
	public boolean onKeyDown(int keyCode, android.view.KeyEvent event) {
        if (processBA.runHook("onkeydown", this, new Object[] {keyCode, event}))
            return true;
		if (onKeySubExist == null)
			onKeySubExist = processBA.subExists("activity_keypress");
		if (onKeySubExist) {
			if (keyCode == anywheresoftware.b4a.keywords.constants.KeyCodes.KEYCODE_BACK &&
					android.os.Build.VERSION.SDK_INT >= 18) {
				HandleKeyDelayed hk = new HandleKeyDelayed();
				hk.kc = keyCode;
				BA.handler.post(hk);
				return true;
			}
			else {
				boolean res = new HandleKeyDelayed().runDirectly(keyCode);
				if (res)
					return true;
			}
		}
		return super.onKeyDown(keyCode, event);
	}
	private class HandleKeyDelayed implements Runnable {
		int kc;
		public void run() {
			runDirectly(kc);
		}
		public boolean runDirectly(int keyCode) {
			Boolean res =  (Boolean)processBA.raiseEvent2(_activity, false, "activity_keypress", false, keyCode);
			if (res == null || res == true) {
                return true;
            }
            else if (keyCode == anywheresoftware.b4a.keywords.constants.KeyCodes.KEYCODE_BACK) {
				finish();
				return true;
			}
            return false;
		}
		
	}
    @Override
	public boolean onKeyUp(int keyCode, android.view.KeyEvent event) {
        if (processBA.runHook("onkeyup", this, new Object[] {keyCode, event}))
            return true;
		if (onKeyUpSubExist == null)
			onKeyUpSubExist = processBA.subExists("activity_keyup");
		if (onKeyUpSubExist) {
			Boolean res =  (Boolean)processBA.raiseEvent2(_activity, false, "activity_keyup", false, keyCode);
			if (res == null || res == true)
				return true;
		}
		return super.onKeyUp(keyCode, event);
	}
	@Override
	public void onNewIntent(android.content.Intent intent) {
        super.onNewIntent(intent);
		this.setIntent(intent);
        processBA.runHook("onnewintent", this, new Object[] {intent});
	}
    @Override 
	public void onPause() {
		super.onPause();
        if (_activity == null)
            return;
        if (this != mostCurrent)
			return;
		anywheresoftware.b4a.Msgbox.dismiss(true);
        BA.LogInfo("** Activity (main) Pause, UserClosed = " + activityBA.activity.isFinishing() + " **");
        if (mostCurrent != null)
            processBA.raiseEvent2(_activity, true, "activity_pause", false, activityBA.activity.isFinishing());		
        processBA.setActivityPaused(true);
        mostCurrent = null;
        if (!activityBA.activity.isFinishing())
			previousOne = new WeakReference<Activity>(this);
        anywheresoftware.b4a.Msgbox.isDismissing = false;
        processBA.runHook("onpause", this, null);
	}

	@Override
	public void onDestroy() {
        super.onDestroy();
		previousOne = null;
        processBA.runHook("ondestroy", this, null);
	}
    @Override 
	public void onResume() {
		super.onResume();
        mostCurrent = this;
        anywheresoftware.b4a.Msgbox.isDismissing = false;
        if (activityBA != null) { //will be null during activity create (which waits for AfterLayout).
        	ResumeMessage rm = new ResumeMessage(mostCurrent);
        	BA.handler.post(rm);
        }
        processBA.runHook("onresume", this, null);
	}
    private static class ResumeMessage implements Runnable {
    	private final WeakReference<Activity> activity;
    	public ResumeMessage(Activity activity) {
    		this.activity = new WeakReference<Activity>(activity);
    	}
		public void run() {
            main mc = mostCurrent;
			if (mc == null || mc != activity.get())
				return;
			processBA.setActivityPaused(false);
            BA.LogInfo("** Activity (main) Resume **");
            if (mc != mostCurrent)
                return;
		    processBA.raiseEvent(mc._activity, "activity_resume", (Object[])null);
		}
    }
	@Override
	protected void onActivityResult(int requestCode, int resultCode,
	      android.content.Intent data) {
		processBA.onActivityResult(requestCode, resultCode, data);
        processBA.runHook("onactivityresult", this, new Object[] {requestCode, resultCode});
	}
	private static void initializeGlobals() {
		processBA.raiseEvent2(null, true, "globals", false, (Object[])null);
	}
    public void onRequestPermissionsResult(int requestCode,
        String permissions[], int[] grantResults) {
        for (int i = 0;i < permissions.length;i++) {
            Object[] o = new Object[] {permissions[i], grantResults[i] == 0};
            processBA.raiseEventFromDifferentThread(null,null, 0, "activity_permissionresult", true, o);
        }
            
    }

public anywheresoftware.b4a.keywords.Common __c = null;
public anywheresoftware.b4a.objects.PanelWrapper _panel1 = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btn1 = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btn2 = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btn3 = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btn4 = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btn5 = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btn6 = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btn7 = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btn8 = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btn9 = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btnnul = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btnsolveon = null;
public anywheresoftware.b4a.objects.LabelWrapper _lblsolveonoff = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btnshow = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btnclearall = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btnsave = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btnrestore = null;
public anywheresoftware.b4a.objects.PanelWrapper _panel2 = null;
public anywheresoftware.b4a.objects.ButtonWrapper _btnclearbackgound = null;
public static int _nbrows = 0;
public static int _nbcols = 0;
public static int _cellheight = 0;
public static int _cellwidth = 0;
public anywheresoftware.b4a.objects.LabelWrapper[][] _gridlbl = null;
public anywheresoftware.b4a.objects.LabelWrapper[] _answerlbl = null;
public static int[] _answertotal = null;
public static int _numberselected = 0;
public static String[][] _stored = null;
public static int _totalcount = 0;
public static int _oldtotalcount = 0;
public static boolean _solveon = false;
public b4a.Sudoku.starter _starter = null;
public b4a.Sudoku.information _information = null;

public static boolean isAnyActivityVisible() {
    boolean vis = false;
vis = vis | (main.mostCurrent != null);
return vis;}
public static String  _actionsolvegrid() throws Exception{
 //BA.debugLineNum = 685;BA.debugLine="Sub ActionSolveGrid";
 //BA.debugLineNum = 686;BA.debugLine="ClearGridTags      ' clears the tags";
_cleargridtags();
 //BA.debugLineNum = 687;BA.debugLine="SearchGrid			'Searches for the NumberSelected an";
_searchgrid();
 //BA.debugLineNum = 688;BA.debugLine="If SolveRows Or SolveColumns Or SolveSquares The";
if (_solverows() || _solvecolumns() || _solvesquares()) { 
 //BA.debugLineNum = 689;BA.debugLine="ActionSolveGrid";
_actionsolvegrid();
 };
 //BA.debugLineNum = 691;BA.debugLine="End Sub";
return "";
}
public static String  _activity_create(boolean _firsttime) throws Exception{
 //BA.debugLineNum = 261;BA.debugLine="Sub Activity_Create(FirstTime As Boolean)";
 //BA.debugLineNum = 262;BA.debugLine="Activity.LoadLayout(\"1\")";
mostCurrent._activity.LoadLayout("1",mostCurrent.activityBA);
 //BA.debugLineNum = 263;BA.debugLine="InitGridLabels";
_initgridlabels();
 //BA.debugLineNum = 264;BA.debugLine="InitAnswerLabels";
_initanswerlabels();
 //BA.debugLineNum = 265;BA.debugLine="lblSolveOnOff.Text=\"\"";
mostCurrent._lblsolveonoff.setText(BA.ObjectToCharSequence(""));
 //BA.debugLineNum = 267;BA.debugLine="PopulateStored_Hard";
_populatestored_hard();
 //BA.debugLineNum = 268;BA.debugLine="End Sub";
return "";
}
public static String  _activity_pause(boolean _userclosed) throws Exception{
 //BA.debugLineNum = 274;BA.debugLine="Sub Activity_Pause (UserClosed As Boolean)";
 //BA.debugLineNum = 276;BA.debugLine="End Sub";
return "";
}
public static String  _activity_resume() throws Exception{
 //BA.debugLineNum = 270;BA.debugLine="Sub Activity_Resume";
 //BA.debugLineNum = 272;BA.debugLine="End Sub";
return "";
}
public static String  _autosolvegrid() throws Exception{
int _count = 0;
 //BA.debugLineNum = 697;BA.debugLine="Sub AutoSolveGrid";
 //BA.debugLineNum = 698;BA.debugLine="For Count = 1 To 9";
{
final int step1 = 1;
final int limit1 = (int) (9);
_count = (int) (1) ;
for (;_count <= limit1 ;_count = _count + step1 ) {
 //BA.debugLineNum = 699;BA.debugLine="NumberSelected=Count";
_numberselected = _count;
 //BA.debugLineNum = 700;BA.debugLine="ActionSolveGrid                'Recursive progra";
_actionsolvegrid();
 }
};
 //BA.debugLineNum = 702;BA.debugLine="CheckTotalCount                   ' Checks the to";
_checktotalcount();
 //BA.debugLineNum = 704;BA.debugLine="If TotalCount> OldTotalCount Then";
if (_totalcount>_oldtotalcount) { 
 //BA.debugLineNum = 705;BA.debugLine="OldTotalCount = TotalCount";
_oldtotalcount = _totalcount;
 //BA.debugLineNum = 706;BA.debugLine="AutoSolveGrid";
_autosolvegrid();
 }else {
 //BA.debugLineNum = 708;BA.debugLine="Msgbox(\"Solve has finished\", \"Complete\")";
anywheresoftware.b4a.keywords.Common.Msgbox(BA.ObjectToCharSequence("Solve has finished"),BA.ObjectToCharSequence("Complete"),mostCurrent.activityBA);
 //BA.debugLineNum = 709;BA.debugLine="If TotalCount = 81 Then";
if (_totalcount==81) { 
 //BA.debugLineNum = 710;BA.debugLine="Msgbox(\"Checking Answers\",\"Grid Completed\")";
anywheresoftware.b4a.keywords.Common.Msgbox(BA.ObjectToCharSequence("Checking Answers"),BA.ObjectToCharSequence("Grid Completed"),mostCurrent.activityBA);
 //BA.debugLineNum = 711;BA.debugLine="VerifyTotalGrid";
_verifytotalgrid();
 };
 //BA.debugLineNum = 713;BA.debugLine="SolveOn=False";
_solveon = anywheresoftware.b4a.keywords.Common.False;
 //BA.debugLineNum = 714;BA.debugLine="SolveLabel(SolveOn)";
_solvelabel(_solveon);
 };
 //BA.debugLineNum = 716;BA.debugLine="End Sub";
return "";
}
public static String  _btn1_click() throws Exception{
 //BA.debugLineNum = 831;BA.debugLine="Sub btn1_Click";
 //BA.debugLineNum = 832;BA.debugLine="NumberSelected=1";
_numberselected = (int) (1);
 //BA.debugLineNum = 833;BA.debugLine="ButtonColorChange(NumberSelected)";
_buttoncolorchange(_numberselected);
 //BA.debugLineNum = 834;BA.debugLine="End Sub";
return "";
}
public static String  _btn2_click() throws Exception{
 //BA.debugLineNum = 836;BA.debugLine="Sub btn2_Click";
 //BA.debugLineNum = 837;BA.debugLine="NumberSelected=2";
_numberselected = (int) (2);
 //BA.debugLineNum = 838;BA.debugLine="ButtonColorChange(NumberSelected)";
_buttoncolorchange(_numberselected);
 //BA.debugLineNum = 839;BA.debugLine="End Sub";
return "";
}
public static String  _btn3_click() throws Exception{
 //BA.debugLineNum = 841;BA.debugLine="Sub btn3_Click";
 //BA.debugLineNum = 842;BA.debugLine="NumberSelected=3";
_numberselected = (int) (3);
 //BA.debugLineNum = 843;BA.debugLine="ButtonColorChange(NumberSelected)";
_buttoncolorchange(_numberselected);
 //BA.debugLineNum = 844;BA.debugLine="End Sub";
return "";
}
public static String  _btn4_click() throws Exception{
 //BA.debugLineNum = 846;BA.debugLine="Sub btn4_Click";
 //BA.debugLineNum = 847;BA.debugLine="NumberSelected=4";
_numberselected = (int) (4);
 //BA.debugLineNum = 848;BA.debugLine="ButtonColorChange(NumberSelected)";
_buttoncolorchange(_numberselected);
 //BA.debugLineNum = 849;BA.debugLine="End Sub";
return "";
}
public static String  _btn5_click() throws Exception{
 //BA.debugLineNum = 851;BA.debugLine="Sub btn5_Click";
 //BA.debugLineNum = 852;BA.debugLine="NumberSelected=5";
_numberselected = (int) (5);
 //BA.debugLineNum = 853;BA.debugLine="ButtonColorChange(NumberSelected)";
_buttoncolorchange(_numberselected);
 //BA.debugLineNum = 854;BA.debugLine="End Sub";
return "";
}
public static String  _btn6_click() throws Exception{
 //BA.debugLineNum = 856;BA.debugLine="Sub btn6_Click";
 //BA.debugLineNum = 857;BA.debugLine="NumberSelected=6";
_numberselected = (int) (6);
 //BA.debugLineNum = 858;BA.debugLine="ButtonColorChange(NumberSelected)";
_buttoncolorchange(_numberselected);
 //BA.debugLineNum = 859;BA.debugLine="End Sub";
return "";
}
public static String  _btn7_click() throws Exception{
 //BA.debugLineNum = 861;BA.debugLine="Sub btn7_Click";
 //BA.debugLineNum = 862;BA.debugLine="NumberSelected=7";
_numberselected = (int) (7);
 //BA.debugLineNum = 863;BA.debugLine="ButtonColorChange(NumberSelected)";
_buttoncolorchange(_numberselected);
 //BA.debugLineNum = 864;BA.debugLine="End Sub";
return "";
}
public static String  _btn8_click() throws Exception{
 //BA.debugLineNum = 866;BA.debugLine="Sub btn8_Click";
 //BA.debugLineNum = 867;BA.debugLine="NumberSelected=8";
_numberselected = (int) (8);
 //BA.debugLineNum = 868;BA.debugLine="ButtonColorChange(NumberSelected)";
_buttoncolorchange(_numberselected);
 //BA.debugLineNum = 869;BA.debugLine="End Sub";
return "";
}
public static String  _btn9_click() throws Exception{
 //BA.debugLineNum = 871;BA.debugLine="Sub btn9_Click";
 //BA.debugLineNum = 872;BA.debugLine="NumberSelected=9";
_numberselected = (int) (9);
 //BA.debugLineNum = 873;BA.debugLine="ButtonColorChange(NumberSelected)";
_buttoncolorchange(_numberselected);
 //BA.debugLineNum = 874;BA.debugLine="End Sub";
return "";
}
public static String  _btnclearall_click() throws Exception{
 //BA.debugLineNum = 753;BA.debugLine="Sub btnClearAll_Click";
 //BA.debugLineNum = 754;BA.debugLine="If SolveOn=False Then";
if (_solveon==anywheresoftware.b4a.keywords.Common.False) { 
 //BA.debugLineNum = 755;BA.debugLine="ClearGridBackground";
_cleargridbackground();
 //BA.debugLineNum = 756;BA.debugLine="ClearGridText";
_cleargridtext();
 //BA.debugLineNum = 757;BA.debugLine="ClearGridTags";
_cleargridtags();
 //BA.debugLineNum = 758;BA.debugLine="ClearAnswers";
_clearanswers();
 }else {
 //BA.debugLineNum = 760;BA.debugLine="Msgbox(\"Solve is on - cannot use this feature\",";
anywheresoftware.b4a.keywords.Common.Msgbox(BA.ObjectToCharSequence("Solve is on - cannot use this feature"),BA.ObjectToCharSequence("Error!"),mostCurrent.activityBA);
 };
 //BA.debugLineNum = 762;BA.debugLine="End Sub";
return "";
}
public static String  _btnclearbackgound_click() throws Exception{
 //BA.debugLineNum = 765;BA.debugLine="Sub btnClearBackgound_Click";
 //BA.debugLineNum = 766;BA.debugLine="If SolveOn=False Then";
if (_solveon==anywheresoftware.b4a.keywords.Common.False) { 
 //BA.debugLineNum = 767;BA.debugLine="ClearGridBackground";
_cleargridbackground();
 }else {
 //BA.debugLineNum = 769;BA.debugLine="Msgbox(\"Solve is on - cannot use this feature\",";
anywheresoftware.b4a.keywords.Common.Msgbox(BA.ObjectToCharSequence("Solve is on - cannot use this feature"),BA.ObjectToCharSequence("Error!"),mostCurrent.activityBA);
 };
 //BA.debugLineNum = 771;BA.debugLine="End Sub";
return "";
}
public static String  _btnnul_click() throws Exception{
 //BA.debugLineNum = 879;BA.debugLine="Sub btnNul_Click";
 //BA.debugLineNum = 880;BA.debugLine="NumberSelected=10";
_numberselected = (int) (10);
 //BA.debugLineNum = 881;BA.debugLine="ButtonColorChange(NumberSelected)";
_buttoncolorchange(_numberselected);
 //BA.debugLineNum = 882;BA.debugLine="NumberSelected = 0    					'must be zero for dele";
_numberselected = (int) (0);
 //BA.debugLineNum = 883;BA.debugLine="End Sub";
return "";
}
public static String  _btnrestore_click() throws Exception{
int _i = 0;
int _j = 0;
 //BA.debugLineNum = 788;BA.debugLine="Sub btnRestore_Click";
 //BA.debugLineNum = 789;BA.debugLine="If SolveOn=False Then";
if (_solveon==anywheresoftware.b4a.keywords.Common.False) { 
 //BA.debugLineNum = 790;BA.debugLine="ClearGridBackground";
_cleargridbackground();
 //BA.debugLineNum = 791;BA.debugLine="ClearGridText";
_cleargridtext();
 //BA.debugLineNum = 792;BA.debugLine="ClearAnswers";
_clearanswers();
 //BA.debugLineNum = 793;BA.debugLine="For i= 0 To NbRows-1";
{
final int step5 = 1;
final int limit5 = (int) (_nbrows-1);
_i = (int) (0) ;
for (;_i <= limit5 ;_i = _i + step5 ) {
 //BA.debugLineNum = 794;BA.debugLine="For j=0 To NbCols-1";
{
final int step6 = 1;
final int limit6 = (int) (_nbcols-1);
_j = (int) (0) ;
for (;_j <= limit6 ;_j = _j + step6 ) {
 //BA.debugLineNum = 795;BA.debugLine="gridlbl(i,j).Text=Stored(i,j)";
mostCurrent._gridlbl[_i][_j].setText(BA.ObjectToCharSequence(mostCurrent._stored[_i][_j]));
 }
};
 }
};
 }else {
 //BA.debugLineNum = 799;BA.debugLine="Msgbox(\"Solve is on - cannot use this feature\",";
anywheresoftware.b4a.keywords.Common.Msgbox(BA.ObjectToCharSequence("Solve is on - cannot use this feature"),BA.ObjectToCharSequence("Error!"),mostCurrent.activityBA);
 };
 //BA.debugLineNum = 801;BA.debugLine="End Sub";
return "";
}
public static String  _btnsave_click() throws Exception{
int _i = 0;
int _j = 0;
 //BA.debugLineNum = 775;BA.debugLine="Sub btnSave_Click";
 //BA.debugLineNum = 776;BA.debugLine="If SolveOn = False  Then";
if (_solveon==anywheresoftware.b4a.keywords.Common.False) { 
 //BA.debugLineNum = 777;BA.debugLine="For i= 0 To NbRows-1";
{
final int step2 = 1;
final int limit2 = (int) (_nbrows-1);
_i = (int) (0) ;
for (;_i <= limit2 ;_i = _i + step2 ) {
 //BA.debugLineNum = 778;BA.debugLine="For j=0 To NbCols-1";
{
final int step3 = 1;
final int limit3 = (int) (_nbcols-1);
_j = (int) (0) ;
for (;_j <= limit3 ;_j = _j + step3 ) {
 //BA.debugLineNum = 779;BA.debugLine="Stored(i,j)=gridlbl(i,j).Text";
mostCurrent._stored[_i][_j] = mostCurrent._gridlbl[_i][_j].getText();
 }
};
 }
};
 }else {
 //BA.debugLineNum = 783;BA.debugLine="Msgbox(\"SolveOn is on - cannot use this feature\"";
anywheresoftware.b4a.keywords.Common.Msgbox(BA.ObjectToCharSequence("SolveOn is on - cannot use this feature"),BA.ObjectToCharSequence("Error!"),mostCurrent.activityBA);
 };
 //BA.debugLineNum = 785;BA.debugLine="End Sub";
return "";
}
public static String  _btnshow_click() throws Exception{
 //BA.debugLineNum = 739;BA.debugLine="Sub btnShow_Click";
 //BA.debugLineNum = 740;BA.debugLine="If  NumberSelected>0 Then";
if (_numberselected>0) { 
 //BA.debugLineNum = 741;BA.debugLine="SearchGrid  'Searches for the NumberSelected and";
_searchgrid();
 //BA.debugLineNum = 742;BA.debugLine="CheckTotalCount";
_checktotalcount();
 //BA.debugLineNum = 743;BA.debugLine="If TotalCount = 81 Then";
if (_totalcount==81) { 
 //BA.debugLineNum = 744;BA.debugLine="Msgbox(\"Checking Answers\",\"Grid Completed\")";
anywheresoftware.b4a.keywords.Common.Msgbox(BA.ObjectToCharSequence("Checking Answers"),BA.ObjectToCharSequence("Grid Completed"),mostCurrent.activityBA);
 //BA.debugLineNum = 745;BA.debugLine="VerifyTotalGrid";
_verifytotalgrid();
 };
 }else {
 //BA.debugLineNum = 748;BA.debugLine="Msgbox(\"Select a Number first\", \"Error!\")";
anywheresoftware.b4a.keywords.Common.Msgbox(BA.ObjectToCharSequence("Select a Number first"),BA.ObjectToCharSequence("Error!"),mostCurrent.activityBA);
 };
 //BA.debugLineNum = 750;BA.debugLine="End Sub";
return "";
}
public static String  _btnsolveon_click() throws Exception{
 //BA.debugLineNum = 804;BA.debugLine="Sub btnSolveOn_Click";
 //BA.debugLineNum = 805;BA.debugLine="ButtonColorChange(99)				' forces all buttons to";
_buttoncolorchange((int) (99));
 //BA.debugLineNum = 806;BA.debugLine="ClearGridBackground";
_cleargridbackground();
 //BA.debugLineNum = 807;BA.debugLine="SolveOn=True";
_solveon = anywheresoftware.b4a.keywords.Common.True;
 //BA.debugLineNum = 808;BA.debugLine="SolveLabel(SolveOn)";
_solvelabel(_solveon);
 //BA.debugLineNum = 809;BA.debugLine="TotalCount = 0";
_totalcount = (int) (0);
 //BA.debugLineNum = 810;BA.debugLine="OldTotalCount=0";
_oldtotalcount = (int) (0);
 //BA.debugLineNum = 811;BA.debugLine="AutoSolveGrid";
_autosolvegrid();
 //BA.debugLineNum = 812;BA.debugLine="End Sub";
return "";
}
public static String  _buttoncolorchange(int _number) throws Exception{
anywheresoftware.b4a.objects.ButtonWrapper[] _buttons = null;
int _i = 0;
 //BA.debugLineNum = 819;BA.debugLine="Sub ButtonColorChange(Number As Int)";
 //BA.debugLineNum = 820;BA.debugLine="Dim Buttons(10) As Button";
_buttons = new anywheresoftware.b4a.objects.ButtonWrapper[(int) (10)];
{
int d0 = _buttons.length;
for (int i0 = 0;i0 < d0;i0++) {
_buttons[i0] = new anywheresoftware.b4a.objects.ButtonWrapper();
}
}
;
 //BA.debugLineNum = 821;BA.debugLine="Buttons = Array As Button(btn1,btn2,btn3,btn4,btn";
_buttons = new anywheresoftware.b4a.objects.ButtonWrapper[]{mostCurrent._btn1,mostCurrent._btn2,mostCurrent._btn3,mostCurrent._btn4,mostCurrent._btn5,mostCurrent._btn6,mostCurrent._btn7,mostCurrent._btn8,mostCurrent._btn9,mostCurrent._btnnul};
 //BA.debugLineNum = 822;BA.debugLine="For i=0 To 9";
{
final int step3 = 1;
final int limit3 = (int) (9);
_i = (int) (0) ;
for (;_i <= limit3 ;_i = _i + step3 ) {
 //BA.debugLineNum = 823;BA.debugLine="Buttons(i).SetBackgroundImage(LoadBitmap(File.Di";
_buttons[_i].SetBackgroundImageNew((android.graphics.Bitmap)(anywheresoftware.b4a.keywords.Common.LoadBitmap(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"ButtonTop.png").getObject()));
 }
};
 //BA.debugLineNum = 825;BA.debugLine="If Number<>99 Then";
if (_number!=99) { 
 //BA.debugLineNum = 826;BA.debugLine="Buttons(Number-1).SetBackgroundImage(LoadBitmap(";
_buttons[(int) (_number-1)].SetBackgroundImageNew((android.graphics.Bitmap)(anywheresoftware.b4a.keywords.Common.LoadBitmap(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"ButtonBot.png").getObject()));
 };
 //BA.debugLineNum = 828;BA.debugLine="End Sub";
return "";
}
public static String  _changesquarecolour(int _toprow,int _topcol,boolean _onsolveon) throws Exception{
int _i = 0;
int _j = 0;
 //BA.debugLineNum = 480;BA.debugLine="Sub ChangeSquareColour(TopRow As Int, TopCol As In";
 //BA.debugLineNum = 481;BA.debugLine="For i=TopRow To TopRow+2";
{
final int step1 = 1;
final int limit1 = (int) (_toprow+2);
_i = _toprow ;
for (;_i <= limit1 ;_i = _i + step1 ) {
 //BA.debugLineNum = 482;BA.debugLine="For j=TopCol To TopCol+2";
{
final int step2 = 1;
final int limit2 = (int) (_topcol+2);
_j = _topcol ;
for (;_j <= limit2 ;_j = _j + step2 ) {
 //BA.debugLineNum = 483;BA.debugLine="If OnSolveON=False Then";
if (_onsolveon==anywheresoftware.b4a.keywords.Common.False) { 
 //BA.debugLineNum = 484;BA.debugLine="gridlbl(i,j).Color=Colors.Gray";
mostCurrent._gridlbl[_i][_j].setColor(anywheresoftware.b4a.keywords.Common.Colors.Gray);
 };
 //BA.debugLineNum = 486;BA.debugLine="gridlbl(i,j).Tag=\"V\"";
mostCurrent._gridlbl[_i][_j].setTag((Object)("V"));
 }
};
 }
};
 //BA.debugLineNum = 489;BA.debugLine="End Sub";
return "";
}
public static String  _checkcolumns(boolean _onsolveon) throws Exception{
int _i = 0;
int _j = 0;
int _k = 0;
 //BA.debugLineNum = 445;BA.debugLine="Sub CheckColumns(OnSolveON As Boolean)";
 //BA.debugLineNum = 446;BA.debugLine="For i= 0 To NbCols-1";
{
final int step1 = 1;
final int limit1 = (int) (_nbcols-1);
_i = (int) (0) ;
for (;_i <= limit1 ;_i = _i + step1 ) {
 //BA.debugLineNum = 447;BA.debugLine="For j = 0 To NbRows-1";
{
final int step2 = 1;
final int limit2 = (int) (_nbrows-1);
_j = (int) (0) ;
for (;_j <= limit2 ;_j = _j + step2 ) {
 //BA.debugLineNum = 448;BA.debugLine="If gridlbl(i,j).Text=NumberSelected Then";
if ((mostCurrent._gridlbl[_i][_j].getText()).equals(BA.NumberToString(_numberselected))) { 
 //BA.debugLineNum = 449;BA.debugLine="For k=0 To NbCols-1";
{
final int step4 = 1;
final int limit4 = (int) (_nbcols-1);
_k = (int) (0) ;
for (;_k <= limit4 ;_k = _k + step4 ) {
 //BA.debugLineNum = 450;BA.debugLine="If OnSolveON=False Then";
if (_onsolveon==anywheresoftware.b4a.keywords.Common.False) { 
 //BA.debugLineNum = 451;BA.debugLine="gridlbl(k,j).Color=Colors.Gray";
mostCurrent._gridlbl[_k][_j].setColor(anywheresoftware.b4a.keywords.Common.Colors.Gray);
 };
 //BA.debugLineNum = 453;BA.debugLine="gridlbl(k,j).Tag=\"V\"";
mostCurrent._gridlbl[_k][_j].setTag((Object)("V"));
 }
};
 };
 }
};
 }
};
 //BA.debugLineNum = 458;BA.debugLine="End Sub";
return "";
}
public static String  _checkexisting(boolean _onsolveon) throws Exception{
int _i = 0;
int _j = 0;
 //BA.debugLineNum = 525;BA.debugLine="Sub CheckExisting (OnSolveOn As Boolean)";
 //BA.debugLineNum = 526;BA.debugLine="For i= 0 To NbRows-1";
{
final int step1 = 1;
final int limit1 = (int) (_nbrows-1);
_i = (int) (0) ;
for (;_i <= limit1 ;_i = _i + step1 ) {
 //BA.debugLineNum = 527;BA.debugLine="For j = 0 To NbCols-1";
{
final int step2 = 1;
final int limit2 = (int) (_nbcols-1);
_j = (int) (0) ;
for (;_j <= limit2 ;_j = _j + step2 ) {
 //BA.debugLineNum = 528;BA.debugLine="If gridlbl(i,j).Text.Length >0 Then";
if (mostCurrent._gridlbl[_i][_j].getText().length()>0) { 
 //BA.debugLineNum = 529;BA.debugLine="If OnSolveOn=False Then";
if (_onsolveon==anywheresoftware.b4a.keywords.Common.False) { 
 //BA.debugLineNum = 530;BA.debugLine="gridlbl(i,j).Color=Colors.Gray";
mostCurrent._gridlbl[_i][_j].setColor(anywheresoftware.b4a.keywords.Common.Colors.Gray);
 };
 //BA.debugLineNum = 532;BA.debugLine="gridlbl(i,j).Tag=\"V\"";
mostCurrent._gridlbl[_i][_j].setTag((Object)("V"));
 };
 }
};
 }
};
 //BA.debugLineNum = 536;BA.debugLine="End Sub";
return "";
}
public static String  _checkindividualtotals() throws Exception{
int _count = 0;
int _k = 0;
int _i = 0;
int _j = 0;
 //BA.debugLineNum = 541;BA.debugLine="Sub CheckIndividualTotals";
 //BA.debugLineNum = 542;BA.debugLine="Dim Count As Int";
_count = 0;
 //BA.debugLineNum = 543;BA.debugLine="For k=1 To 9";
{
final int step2 = 1;
final int limit2 = (int) (9);
_k = (int) (1) ;
for (;_k <= limit2 ;_k = _k + step2 ) {
 //BA.debugLineNum = 544;BA.debugLine="Count=0";
_count = (int) (0);
 //BA.debugLineNum = 545;BA.debugLine="For i = 0 To NbCols-1";
{
final int step4 = 1;
final int limit4 = (int) (_nbcols-1);
_i = (int) (0) ;
for (;_i <= limit4 ;_i = _i + step4 ) {
 //BA.debugLineNum = 546;BA.debugLine="For j = 0 To NbRows-1";
{
final int step5 = 1;
final int limit5 = (int) (_nbrows-1);
_j = (int) (0) ;
for (;_j <= limit5 ;_j = _j + step5 ) {
 //BA.debugLineNum = 547;BA.debugLine="If gridlbl(i,j).Text=k Then";
if ((mostCurrent._gridlbl[_i][_j].getText()).equals(BA.NumberToString(_k))) { 
 //BA.debugLineNum = 548;BA.debugLine="Count = Count+1";
_count = (int) (_count+1);
 };
 }
};
 }
};
 //BA.debugLineNum = 552;BA.debugLine="Select True";
switch (BA.switchObjectToInt(anywheresoftware.b4a.keywords.Common.True,_count==0,_count>0)) {
case 0: {
 //BA.debugLineNum = 554;BA.debugLine="Answerlbl(k-1).text=\"\"";
mostCurrent._answerlbl[(int) (_k-1)].setText(BA.ObjectToCharSequence(""));
 break; }
case 1: {
 //BA.debugLineNum = 556;BA.debugLine="Answerlbl(k-1).text=Count";
mostCurrent._answerlbl[(int) (_k-1)].setText(BA.ObjectToCharSequence(_count));
 //BA.debugLineNum = 557;BA.debugLine="AnswerTotal(k-1)=Count";
_answertotal[(int) (_k-1)] = _count;
 //BA.debugLineNum = 558;BA.debugLine="Answerlbl(k-1).Color=Colors.Black";
mostCurrent._answerlbl[(int) (_k-1)].setColor(anywheresoftware.b4a.keywords.Common.Colors.Black);
 break; }
}
;
 //BA.debugLineNum = 561;BA.debugLine="Select True";
switch (BA.switchObjectToInt(anywheresoftware.b4a.keywords.Common.True,_count==9,_count>9)) {
case 0: {
 //BA.debugLineNum = 563;BA.debugLine="Answerlbl(k-1).Color=Colors.Blue";
mostCurrent._answerlbl[(int) (_k-1)].setColor(anywheresoftware.b4a.keywords.Common.Colors.Blue);
 break; }
case 1: {
 //BA.debugLineNum = 565;BA.debugLine="Answerlbl(k-1).Color=Colors.Red";
mostCurrent._answerlbl[(int) (_k-1)].setColor(anywheresoftware.b4a.keywords.Common.Colors.Red);
 break; }
}
;
 }
};
 //BA.debugLineNum = 568;BA.debugLine="End Sub";
return "";
}
public static String  _checkrows(boolean _onsolveon) throws Exception{
int _i = 0;
int _j = 0;
int _k = 0;
 //BA.debugLineNum = 462;BA.debugLine="Sub CheckRows(OnSolveON As Boolean)";
 //BA.debugLineNum = 463;BA.debugLine="For i= 0 To NbRows-1";
{
final int step1 = 1;
final int limit1 = (int) (_nbrows-1);
_i = (int) (0) ;
for (;_i <= limit1 ;_i = _i + step1 ) {
 //BA.debugLineNum = 464;BA.debugLine="For j = 0 To NbCols-1";
{
final int step2 = 1;
final int limit2 = (int) (_nbcols-1);
_j = (int) (0) ;
for (;_j <= limit2 ;_j = _j + step2 ) {
 //BA.debugLineNum = 465;BA.debugLine="If gridlbl(i,j).Text=NumberSelected Then";
if ((mostCurrent._gridlbl[_i][_j].getText()).equals(BA.NumberToString(_numberselected))) { 
 //BA.debugLineNum = 466;BA.debugLine="For k=0 To NbRows-1";
{
final int step4 = 1;
final int limit4 = (int) (_nbrows-1);
_k = (int) (0) ;
for (;_k <= limit4 ;_k = _k + step4 ) {
 //BA.debugLineNum = 467;BA.debugLine="If OnSolveON = False Then";
if (_onsolveon==anywheresoftware.b4a.keywords.Common.False) { 
 //BA.debugLineNum = 468;BA.debugLine="gridlbl(i,k).Color=Colors.Gray";
mostCurrent._gridlbl[_i][_k].setColor(anywheresoftware.b4a.keywords.Common.Colors.Gray);
 };
 //BA.debugLineNum = 470;BA.debugLine="gridlbl(i,k).Tag = \"V\"";
mostCurrent._gridlbl[_i][_k].setTag((Object)("V"));
 }
};
 };
 }
};
 }
};
 //BA.debugLineNum = 475;BA.debugLine="End Sub";
return "";
}
public static String  _checksquares(boolean _onsolveon) throws Exception{
int _toprow = 0;
int _topcol = 0;
int _i = 0;
int _j = 0;
 //BA.debugLineNum = 494;BA.debugLine="Sub CheckSquares(OnSolveON As Boolean)";
 //BA.debugLineNum = 495;BA.debugLine="Dim TopRow As Int";
_toprow = 0;
 //BA.debugLineNum = 496;BA.debugLine="Dim TopCol As Int";
_topcol = 0;
 //BA.debugLineNum = 498;BA.debugLine="For i= 0 To NbRows-1";
{
final int step3 = 1;
final int limit3 = (int) (_nbrows-1);
_i = (int) (0) ;
for (;_i <= limit3 ;_i = _i + step3 ) {
 //BA.debugLineNum = 499;BA.debugLine="For j = 0 To NbCols-1";
{
final int step4 = 1;
final int limit4 = (int) (_nbcols-1);
_j = (int) (0) ;
for (;_j <= limit4 ;_j = _j + step4 ) {
 //BA.debugLineNum = 500;BA.debugLine="If gridlbl(i,j).Text=NumberSelected Then";
if ((mostCurrent._gridlbl[_i][_j].getText()).equals(BA.NumberToString(_numberselected))) { 
 //BA.debugLineNum = 501;BA.debugLine="Select True";
switch (BA.switchObjectToInt(anywheresoftware.b4a.keywords.Common.True,_i>=0 && _i<=2,_i>=3 && _i<=5,_i>=6 && _i<=8)) {
case 0: {
 //BA.debugLineNum = 503;BA.debugLine="TopRow = 0";
_toprow = (int) (0);
 break; }
case 1: {
 //BA.debugLineNum = 505;BA.debugLine="TopRow = 3";
_toprow = (int) (3);
 break; }
case 2: {
 //BA.debugLineNum = 507;BA.debugLine="TopRow = 6";
_toprow = (int) (6);
 break; }
}
;
 //BA.debugLineNum = 509;BA.debugLine="Select True";
switch (BA.switchObjectToInt(anywheresoftware.b4a.keywords.Common.True,_j>=0 && _j<=2,_j>=3 && _j<=5,_j>=6 && _j<=8)) {
case 0: {
 //BA.debugLineNum = 511;BA.debugLine="TopCol = 0";
_topcol = (int) (0);
 break; }
case 1: {
 //BA.debugLineNum = 513;BA.debugLine="TopCol = 3";
_topcol = (int) (3);
 break; }
case 2: {
 //BA.debugLineNum = 515;BA.debugLine="TopCol = 6";
_topcol = (int) (6);
 break; }
}
;
 //BA.debugLineNum = 517;BA.debugLine="ChangeSquareColour(TopRow, TopCol,OnSolveON)";
_changesquarecolour(_toprow,_topcol,_onsolveon);
 };
 }
};
 }
};
 //BA.debugLineNum = 521;BA.debugLine="End Sub";
return "";
}
public static String  _checktotalcount() throws Exception{
int _i = 0;
int _j = 0;
 //BA.debugLineNum = 572;BA.debugLine="Sub CheckTotalCount";
 //BA.debugLineNum = 573;BA.debugLine="TotalCount=0";
_totalcount = (int) (0);
 //BA.debugLineNum = 574;BA.debugLine="For i= 0 To NbCols-1";
{
final int step2 = 1;
final int limit2 = (int) (_nbcols-1);
_i = (int) (0) ;
for (;_i <= limit2 ;_i = _i + step2 ) {
 //BA.debugLineNum = 575;BA.debugLine="For j = 0 To NbRows-1";
{
final int step3 = 1;
final int limit3 = (int) (_nbrows-1);
_j = (int) (0) ;
for (;_j <= limit3 ;_j = _j + step3 ) {
 //BA.debugLineNum = 576;BA.debugLine="If gridlbl(i,j).Text.Length>0 Then";
if (mostCurrent._gridlbl[_i][_j].getText().length()>0) { 
 //BA.debugLineNum = 577;BA.debugLine="TotalCount=TotalCount+1";
_totalcount = (int) (_totalcount+1);
 };
 }
};
 }
};
 //BA.debugLineNum = 581;BA.debugLine="Answerlbl(9).Text=TotalCount";
mostCurrent._answerlbl[(int) (9)].setText(BA.ObjectToCharSequence(_totalcount));
 //BA.debugLineNum = 582;BA.debugLine="End Sub";
return "";
}
public static String  _clearanswers() throws Exception{
int _j = 0;
 //BA.debugLineNum = 312;BA.debugLine="Sub ClearAnswers";
 //BA.debugLineNum = 313;BA.debugLine="For j=0 To NbRows-1								' clears answers and g";
{
final int step1 = 1;
final int limit1 = (int) (_nbrows-1);
_j = (int) (0) ;
for (;_j <= limit1 ;_j = _j + step1 ) {
 //BA.debugLineNum = 314;BA.debugLine="Answerlbl(j).Text=\"\"";
mostCurrent._answerlbl[_j].setText(BA.ObjectToCharSequence(""));
 //BA.debugLineNum = 315;BA.debugLine="Answerlbl(j).Color=Colors.Black";
mostCurrent._answerlbl[_j].setColor(anywheresoftware.b4a.keywords.Common.Colors.Black);
 //BA.debugLineNum = 316;BA.debugLine="AnswerTotal(j)=0";
_answertotal[_j] = (int) (0);
 }
};
 //BA.debugLineNum = 318;BA.debugLine="Answerlbl(9).text = \"\"";
mostCurrent._answerlbl[(int) (9)].setText(BA.ObjectToCharSequence(""));
 //BA.debugLineNum = 319;BA.debugLine="End Sub";
return "";
}
public static String  _cleargridbackground() throws Exception{
int _i = 0;
int _j = 0;
 //BA.debugLineNum = 340;BA.debugLine="Sub ClearGridBackground";
 //BA.debugLineNum = 341;BA.debugLine="For i=0 To NbCols-1";
{
final int step1 = 1;
final int limit1 = (int) (_nbcols-1);
_i = (int) (0) ;
for (;_i <= limit1 ;_i = _i + step1 ) {
 //BA.debugLineNum = 342;BA.debugLine="For j=0 To NbRows-1";
{
final int step2 = 1;
final int limit2 = (int) (_nbrows-1);
_j = (int) (0) ;
for (;_j <= limit2 ;_j = _j + step2 ) {
 //BA.debugLineNum = 343;BA.debugLine="gridlbl(i,j).Color=Colors.Black";
mostCurrent._gridlbl[_i][_j].setColor(anywheresoftware.b4a.keywords.Common.Colors.Black);
 }
};
 }
};
 //BA.debugLineNum = 346;BA.debugLine="End Sub";
return "";
}
public static String  _cleargridtags() throws Exception{
int _i = 0;
int _j = 0;
 //BA.debugLineNum = 322;BA.debugLine="Sub ClearGridTags";
 //BA.debugLineNum = 323;BA.debugLine="For i=0 To NbCols-1";
{
final int step1 = 1;
final int limit1 = (int) (_nbcols-1);
_i = (int) (0) ;
for (;_i <= limit1 ;_i = _i + step1 ) {
 //BA.debugLineNum = 324;BA.debugLine="For j=0 To NbRows-1";
{
final int step2 = 1;
final int limit2 = (int) (_nbrows-1);
_j = (int) (0) ;
for (;_j <= limit2 ;_j = _j + step2 ) {
 //BA.debugLineNum = 325;BA.debugLine="gridlbl(i,j).Tag=\"\"";
mostCurrent._gridlbl[_i][_j].setTag((Object)(""));
 }
};
 }
};
 //BA.debugLineNum = 328;BA.debugLine="End Sub";
return "";
}
public static String  _cleargridtext() throws Exception{
int _i = 0;
int _j = 0;
 //BA.debugLineNum = 331;BA.debugLine="Sub ClearGridText";
 //BA.debugLineNum = 332;BA.debugLine="For i=0 To NbCols-1";
{
final int step1 = 1;
final int limit1 = (int) (_nbcols-1);
_i = (int) (0) ;
for (;_i <= limit1 ;_i = _i + step1 ) {
 //BA.debugLineNum = 333;BA.debugLine="For j=0 To NbRows-1";
{
final int step2 = 1;
final int limit2 = (int) (_nbrows-1);
_j = (int) (0) ;
for (;_j <= limit2 ;_j = _j + step2 ) {
 //BA.debugLineNum = 334;BA.debugLine="gridlbl(i,j).Text=\"\"";
mostCurrent._gridlbl[_i][_j].setText(BA.ObjectToCharSequence(""));
 }
};
 }
};
 //BA.debugLineNum = 337;BA.debugLine="End Sub";
return "";
}
public static String  _globals() throws Exception{
 //BA.debugLineNum = 22;BA.debugLine="Sub Globals";
 //BA.debugLineNum = 26;BA.debugLine="Private Panel1 As Panel";
mostCurrent._panel1 = new anywheresoftware.b4a.objects.PanelWrapper();
 //BA.debugLineNum = 27;BA.debugLine="Private btn1 As Button";
mostCurrent._btn1 = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 28;BA.debugLine="Private btn2 As Button";
mostCurrent._btn2 = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 29;BA.debugLine="Private btn3 As Button";
mostCurrent._btn3 = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 30;BA.debugLine="Private btn4 As Button";
mostCurrent._btn4 = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 31;BA.debugLine="Private btn5 As Button";
mostCurrent._btn5 = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 32;BA.debugLine="Private btn6 As Button";
mostCurrent._btn6 = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 33;BA.debugLine="Private btn7 As Button";
mostCurrent._btn7 = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 34;BA.debugLine="Private btn8 As Button";
mostCurrent._btn8 = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 35;BA.debugLine="Private btn9 As Button";
mostCurrent._btn9 = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 36;BA.debugLine="Private btnNul As Button";
mostCurrent._btnnul = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 39;BA.debugLine="Private btnSolveOn As Button";
mostCurrent._btnsolveon = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 40;BA.debugLine="Private lblSolveOnOff As Label";
mostCurrent._lblsolveonoff = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 41;BA.debugLine="Private btnShow As Button";
mostCurrent._btnshow = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 42;BA.debugLine="Private btnClearAll As Button";
mostCurrent._btnclearall = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 43;BA.debugLine="Private btnSave As Button";
mostCurrent._btnsave = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 44;BA.debugLine="Private btnRestore As Button";
mostCurrent._btnrestore = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 45;BA.debugLine="Private Panel2 As Panel";
mostCurrent._panel2 = new anywheresoftware.b4a.objects.PanelWrapper();
 //BA.debugLineNum = 46;BA.debugLine="Private btnClearBackgound As Button";
mostCurrent._btnclearbackgound = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 49;BA.debugLine="Dim NbRows = 9 As Int";
_nbrows = (int) (9);
 //BA.debugLineNum = 50;BA.debugLine="Dim NbCols = 9 As Int";
_nbcols = (int) (9);
 //BA.debugLineNum = 51;BA.debugLine="Dim CellHeight = 45dip As Int";
_cellheight = anywheresoftware.b4a.keywords.Common.DipToCurrent((int) (45));
 //BA.debugLineNum = 52;BA.debugLine="Dim CellWidth= 45dip As Int";
_cellwidth = anywheresoftware.b4a.keywords.Common.DipToCurrent((int) (45));
 //BA.debugLineNum = 53;BA.debugLine="Dim gridlbl(NbRows, NbCols) As Label";
mostCurrent._gridlbl = new anywheresoftware.b4a.objects.LabelWrapper[_nbrows][];
{
int d0 = mostCurrent._gridlbl.length;
int d1 = _nbcols;
for (int i0 = 0;i0 < d0;i0++) {
mostCurrent._gridlbl[i0] = new anywheresoftware.b4a.objects.LabelWrapper[d1];
for (int i1 = 0;i1 < d1;i1++) {
mostCurrent._gridlbl[i0][i1] = new anywheresoftware.b4a.objects.LabelWrapper();
}
}
}
;
 //BA.debugLineNum = 56;BA.debugLine="Dim Answerlbl(10) As Label";
mostCurrent._answerlbl = new anywheresoftware.b4a.objects.LabelWrapper[(int) (10)];
{
int d0 = mostCurrent._answerlbl.length;
for (int i0 = 0;i0 < d0;i0++) {
mostCurrent._answerlbl[i0] = new anywheresoftware.b4a.objects.LabelWrapper();
}
}
;
 //BA.debugLineNum = 57;BA.debugLine="Dim AnswerTotal(9) As Int";
_answertotal = new int[(int) (9)];
;
 //BA.debugLineNum = 58;BA.debugLine="Dim NumberSelected As Int";
_numberselected = 0;
 //BA.debugLineNum = 61;BA.debugLine="Dim Stored(NbRows,NbCols) As String";
mostCurrent._stored = new String[_nbrows][];
{
int d0 = mostCurrent._stored.length;
int d1 = _nbcols;
for (int i0 = 0;i0 < d0;i0++) {
mostCurrent._stored[i0] = new String[d1];
java.util.Arrays.fill(mostCurrent._stored[i0],"");
}
}
;
 //BA.debugLineNum = 62;BA.debugLine="Public Answerlbl(10) As Label";
mostCurrent._answerlbl = new anywheresoftware.b4a.objects.LabelWrapper[(int) (10)];
{
int d0 = mostCurrent._answerlbl.length;
for (int i0 = 0;i0 < d0;i0++) {
mostCurrent._answerlbl[i0] = new anywheresoftware.b4a.objects.LabelWrapper();
}
}
;
 //BA.debugLineNum = 63;BA.debugLine="Public gridlbl(NbRows, NbCols) As Label";
mostCurrent._gridlbl = new anywheresoftware.b4a.objects.LabelWrapper[_nbrows][];
{
int d0 = mostCurrent._gridlbl.length;
int d1 = _nbcols;
for (int i0 = 0;i0 < d0;i0++) {
mostCurrent._gridlbl[i0] = new anywheresoftware.b4a.objects.LabelWrapper[d1];
for (int i1 = 0;i1 < d1;i1++) {
mostCurrent._gridlbl[i0][i1] = new anywheresoftware.b4a.objects.LabelWrapper();
}
}
}
;
 //BA.debugLineNum = 66;BA.debugLine="Public TotalCount As Int";
_totalcount = 0;
 //BA.debugLineNum = 67;BA.debugLine="Public OldTotalCount As Int";
_oldtotalcount = 0;
 //BA.debugLineNum = 68;BA.debugLine="Public SolveOn As Boolean";
_solveon = false;
 //BA.debugLineNum = 70;BA.debugLine="End Sub";
return "";
}
public static String  _initanswerlabels() throws Exception{
int _row = 0;
 //BA.debugLineNum = 297;BA.debugLine="Sub InitAnswerLabels";
 //BA.debugLineNum = 298;BA.debugLine="For row = 0 To NbRows";
{
final int step1 = 1;
final int limit1 = _nbrows;
_row = (int) (0) ;
for (;_row <= limit1 ;_row = _row + step1 ) {
 //BA.debugLineNum = 299;BA.debugLine="Answerlbl(row).Initialize(\"lblAnswer\")";
mostCurrent._answerlbl[_row].Initialize(mostCurrent.activityBA,"lblAnswer");
 //BA.debugLineNum = 300;BA.debugLine="Panel2.AddView(Answerlbl(row),5dip, 6dip + row *";
mostCurrent._panel2.AddView((android.view.View)(mostCurrent._answerlbl[_row].getObject()),anywheresoftware.b4a.keywords.Common.DipToCurrent((int) (5)),(int) (anywheresoftware.b4a.keywords.Common.DipToCurrent((int) (6))+_row*anywheresoftware.b4a.keywords.Common.DipToCurrent((int) (50))),(int) (90),(int) (40));
 //BA.debugLineNum = 301;BA.debugLine="Answerlbl(row).Color = Colors.Black";
mostCurrent._answerlbl[_row].setColor(anywheresoftware.b4a.keywords.Common.Colors.Black);
 //BA.debugLineNum = 302;BA.debugLine="Answerlbl(row).TextColor = Colors.White";
mostCurrent._answerlbl[_row].setTextColor(anywheresoftware.b4a.keywords.Common.Colors.White);
 //BA.debugLineNum = 303;BA.debugLine="Answerlbl(row).TextSize = 20";
mostCurrent._answerlbl[_row].setTextSize((float) (20));
 //BA.debugLineNum = 304;BA.debugLine="Answerlbl(row).Gravity = Bit.Or(Gravity.CENTER_H";
mostCurrent._answerlbl[_row].setGravity(anywheresoftware.b4a.keywords.Common.Bit.Or(anywheresoftware.b4a.keywords.Common.Gravity.CENTER_HORIZONTAL,anywheresoftware.b4a.keywords.Common.Gravity.CENTER_VERTICAL));
 }
};
 //BA.debugLineNum = 307;BA.debugLine="End Sub";
return "";
}
public static String  _initgridlabels() throws Exception{
int _row = 0;
int _col = 0;
 //BA.debugLineNum = 280;BA.debugLine="Sub InitGridLabels";
 //BA.debugLineNum = 281;BA.debugLine="Dim row, col As Int";
_row = 0;
_col = 0;
 //BA.debugLineNum = 282;BA.debugLine="For row = 0 To NbRows - 1";
{
final int step2 = 1;
final int limit2 = (int) (_nbrows-1);
_row = (int) (0) ;
for (;_row <= limit2 ;_row = _row + step2 ) {
 //BA.debugLineNum = 283;BA.debugLine="For col = 0 To NbCols - 1";
{
final int step3 = 1;
final int limit3 = (int) (_nbcols-1);
_col = (int) (0) ;
for (;_col <= limit3 ;_col = _col + step3 ) {
 //BA.debugLineNum = 284;BA.debugLine="gridlbl(row, col).Initialize(\"lblValue\")";
mostCurrent._gridlbl[_row][_col].Initialize(mostCurrent.activityBA,"lblValue");
 //BA.debugLineNum = 285;BA.debugLine="Panel1.AddView(gridlbl(row, col), 8dip + col*60";
mostCurrent._panel1.AddView((android.view.View)(mostCurrent._gridlbl[_row][_col].getObject()),(int) (anywheresoftware.b4a.keywords.Common.DipToCurrent((int) (8))+_col*anywheresoftware.b4a.keywords.Common.DipToCurrent((int) (60))),(int) (anywheresoftware.b4a.keywords.Common.DipToCurrent((int) (8))+_row*anywheresoftware.b4a.keywords.Common.DipToCurrent((int) (60))),_cellwidth,_cellheight);
 //BA.debugLineNum = 286;BA.debugLine="gridlbl(row, col).Color = Colors.Black";
mostCurrent._gridlbl[_row][_col].setColor(anywheresoftware.b4a.keywords.Common.Colors.Black);
 //BA.debugLineNum = 287;BA.debugLine="gridlbl(row, col).TextColor = Colors.White";
mostCurrent._gridlbl[_row][_col].setTextColor(anywheresoftware.b4a.keywords.Common.Colors.White);
 //BA.debugLineNum = 288;BA.debugLine="gridlbl(row, col).TextSize = 30";
mostCurrent._gridlbl[_row][_col].setTextSize((float) (30));
 //BA.debugLineNum = 289;BA.debugLine="gridlbl(row, col).Gravity = Bit.Or(Gravity.CENT";
mostCurrent._gridlbl[_row][_col].setGravity(anywheresoftware.b4a.keywords.Common.Bit.Or(anywheresoftware.b4a.keywords.Common.Gravity.CENTER_HORIZONTAL,anywheresoftware.b4a.keywords.Common.Gravity.CENTER_VERTICAL));
 //BA.debugLineNum = 290;BA.debugLine="gridlbl(row,col).Text=\"\"";
mostCurrent._gridlbl[_row][_col].setText(BA.ObjectToCharSequence(""));
 }
};
 }
};
 //BA.debugLineNum = 293;BA.debugLine="End Sub";
return "";
}
public static String  _panel1_touch(int _action,float _x,float _y) throws Exception{
 //BA.debugLineNum = 727;BA.debugLine="Sub Panel1_Touch (Action As Int, X As Float, Y As";
 //BA.debugLineNum = 728;BA.debugLine="If Action = 0 Then                  ' touch";
if (_action==0) { 
 //BA.debugLineNum = 729;BA.debugLine="If NumberSelected=0 Then";
if (_numberselected==0) { 
 //BA.debugLineNum = 730;BA.debugLine="gridlbl(Y/60,X/60).Text= \"\"";
mostCurrent._gridlbl[(int) (_y/(double)60)][(int) (_x/(double)60)].setText(BA.ObjectToCharSequence(""));
 }else {
 //BA.debugLineNum = 732;BA.debugLine="gridlbl(Y/60,X/60).Text= NumberSelected";
mostCurrent._gridlbl[(int) (_y/(double)60)][(int) (_x/(double)60)].setText(BA.ObjectToCharSequence(_numberselected));
 };
 };
 //BA.debugLineNum = 735;BA.debugLine="End Sub";
return "";
}
public static String  _populatestored_hard() throws Exception{
 //BA.debugLineNum = 169;BA.debugLine="Sub PopulateStored_Hard";
 //BA.debugLineNum = 170;BA.debugLine="Stored(0,0) = \"4\"";
mostCurrent._stored[(int) (0)][(int) (0)] = "4";
 //BA.debugLineNum = 171;BA.debugLine="Stored(0,1) = \"1\"";
mostCurrent._stored[(int) (0)][(int) (1)] = "1";
 //BA.debugLineNum = 172;BA.debugLine="Stored(0,2) = \"\"";
mostCurrent._stored[(int) (0)][(int) (2)] = "";
 //BA.debugLineNum = 173;BA.debugLine="Stored(0,3) = \"\"";
mostCurrent._stored[(int) (0)][(int) (3)] = "";
 //BA.debugLineNum = 174;BA.debugLine="Stored(0,4) = \"5\"";
mostCurrent._stored[(int) (0)][(int) (4)] = "5";
 //BA.debugLineNum = 175;BA.debugLine="Stored(0,5) = \"\"";
mostCurrent._stored[(int) (0)][(int) (5)] = "";
 //BA.debugLineNum = 176;BA.debugLine="Stored(0,6) = \"\"";
mostCurrent._stored[(int) (0)][(int) (6)] = "";
 //BA.debugLineNum = 177;BA.debugLine="Stored(0,7) = \"\"";
mostCurrent._stored[(int) (0)][(int) (7)] = "";
 //BA.debugLineNum = 178;BA.debugLine="Stored(0,8) = \"3\"";
mostCurrent._stored[(int) (0)][(int) (8)] = "3";
 //BA.debugLineNum = 180;BA.debugLine="Stored(1,0) = \"\"";
mostCurrent._stored[(int) (1)][(int) (0)] = "";
 //BA.debugLineNum = 181;BA.debugLine="Stored(1,1) = \"\"";
mostCurrent._stored[(int) (1)][(int) (1)] = "";
 //BA.debugLineNum = 182;BA.debugLine="Stored(1,2) = \"6\"";
mostCurrent._stored[(int) (1)][(int) (2)] = "6";
 //BA.debugLineNum = 183;BA.debugLine="Stored(1,3) = \"\"";
mostCurrent._stored[(int) (1)][(int) (3)] = "";
 //BA.debugLineNum = 184;BA.debugLine="Stored(1,4) = \"1\"";
mostCurrent._stored[(int) (1)][(int) (4)] = "1";
 //BA.debugLineNum = 185;BA.debugLine="Stored(1,5) = \"7\"";
mostCurrent._stored[(int) (1)][(int) (5)] = "7";
 //BA.debugLineNum = 186;BA.debugLine="Stored(1,6) = \"\"";
mostCurrent._stored[(int) (1)][(int) (6)] = "";
 //BA.debugLineNum = 187;BA.debugLine="Stored(1,7) = \"\"";
mostCurrent._stored[(int) (1)][(int) (7)] = "";
 //BA.debugLineNum = 188;BA.debugLine="Stored(1,8) = \"\"";
mostCurrent._stored[(int) (1)][(int) (8)] = "";
 //BA.debugLineNum = 190;BA.debugLine="Stored(2,0) = \"3\"";
mostCurrent._stored[(int) (2)][(int) (0)] = "3";
 //BA.debugLineNum = 191;BA.debugLine="Stored(2,1) = \"\"";
mostCurrent._stored[(int) (2)][(int) (1)] = "";
 //BA.debugLineNum = 192;BA.debugLine="Stored(2,2) = \"\"";
mostCurrent._stored[(int) (2)][(int) (2)] = "";
 //BA.debugLineNum = 193;BA.debugLine="Stored(2,3) = \"6\"";
mostCurrent._stored[(int) (2)][(int) (3)] = "6";
 //BA.debugLineNum = 194;BA.debugLine="Stored(2,4) = \"\"";
mostCurrent._stored[(int) (2)][(int) (4)] = "";
 //BA.debugLineNum = 195;BA.debugLine="Stored(2,5) = \"\"";
mostCurrent._stored[(int) (2)][(int) (5)] = "";
 //BA.debugLineNum = 196;BA.debugLine="Stored(2,6) = \"\"";
mostCurrent._stored[(int) (2)][(int) (6)] = "";
 //BA.debugLineNum = 197;BA.debugLine="Stored(2,7) = \"\"";
mostCurrent._stored[(int) (2)][(int) (7)] = "";
 //BA.debugLineNum = 198;BA.debugLine="Stored(2,8) = \"\"";
mostCurrent._stored[(int) (2)][(int) (8)] = "";
 //BA.debugLineNum = 200;BA.debugLine="Stored(3,0) = \"7\"";
mostCurrent._stored[(int) (3)][(int) (0)] = "7";
 //BA.debugLineNum = 201;BA.debugLine="Stored(3,1) = \"\"";
mostCurrent._stored[(int) (3)][(int) (1)] = "";
 //BA.debugLineNum = 202;BA.debugLine="Stored(3,2) = \"\"";
mostCurrent._stored[(int) (3)][(int) (2)] = "";
 //BA.debugLineNum = 203;BA.debugLine="Stored(3,3) = \"9\"";
mostCurrent._stored[(int) (3)][(int) (3)] = "9";
 //BA.debugLineNum = 204;BA.debugLine="Stored(3,4) = \"\"";
mostCurrent._stored[(int) (3)][(int) (4)] = "";
 //BA.debugLineNum = 205;BA.debugLine="Stored(3,5) = \"\"";
mostCurrent._stored[(int) (3)][(int) (5)] = "";
 //BA.debugLineNum = 206;BA.debugLine="Stored(3,6) = \"6\"";
mostCurrent._stored[(int) (3)][(int) (6)] = "6";
 //BA.debugLineNum = 207;BA.debugLine="Stored(3,7) = \"\"";
mostCurrent._stored[(int) (3)][(int) (7)] = "";
 //BA.debugLineNum = 208;BA.debugLine="Stored(3,8) = \"\"";
mostCurrent._stored[(int) (3)][(int) (8)] = "";
 //BA.debugLineNum = 210;BA.debugLine="Stored(4,0) = \"\"";
mostCurrent._stored[(int) (4)][(int) (0)] = "";
 //BA.debugLineNum = 211;BA.debugLine="Stored(4,1) = \"\"";
mostCurrent._stored[(int) (4)][(int) (1)] = "";
 //BA.debugLineNum = 212;BA.debugLine="Stored(4,2) = \"2\"";
mostCurrent._stored[(int) (4)][(int) (2)] = "2";
 //BA.debugLineNum = 213;BA.debugLine="Stored(4,3) = \"\"";
mostCurrent._stored[(int) (4)][(int) (3)] = "";
 //BA.debugLineNum = 214;BA.debugLine="Stored(4,4) = \"\"";
mostCurrent._stored[(int) (4)][(int) (4)] = "";
 //BA.debugLineNum = 215;BA.debugLine="Stored(4,5) = \"\"";
mostCurrent._stored[(int) (4)][(int) (5)] = "";
 //BA.debugLineNum = 216;BA.debugLine="Stored(4,6) = \"8\"";
mostCurrent._stored[(int) (4)][(int) (6)] = "8";
 //BA.debugLineNum = 217;BA.debugLine="Stored(4,7) = \"\"";
mostCurrent._stored[(int) (4)][(int) (7)] = "";
 //BA.debugLineNum = 218;BA.debugLine="Stored(4,8) = \"\"";
mostCurrent._stored[(int) (4)][(int) (8)] = "";
 //BA.debugLineNum = 220;BA.debugLine="Stored(5,0) = \"\"";
mostCurrent._stored[(int) (5)][(int) (0)] = "";
 //BA.debugLineNum = 221;BA.debugLine="Stored(5,1) = \"\"";
mostCurrent._stored[(int) (5)][(int) (1)] = "";
 //BA.debugLineNum = 222;BA.debugLine="Stored(5,2) = \"3\"";
mostCurrent._stored[(int) (5)][(int) (2)] = "3";
 //BA.debugLineNum = 223;BA.debugLine="Stored(5,3) = \"\"";
mostCurrent._stored[(int) (5)][(int) (3)] = "";
 //BA.debugLineNum = 224;BA.debugLine="Stored(5,4) = \"\"";
mostCurrent._stored[(int) (5)][(int) (4)] = "";
 //BA.debugLineNum = 225;BA.debugLine="Stored(5,5) = \"1\"";
mostCurrent._stored[(int) (5)][(int) (5)] = "1";
 //BA.debugLineNum = 226;BA.debugLine="Stored(5,6) = \"\"";
mostCurrent._stored[(int) (5)][(int) (6)] = "";
 //BA.debugLineNum = 227;BA.debugLine="Stored(5,7) = \"\"";
mostCurrent._stored[(int) (5)][(int) (7)] = "";
 //BA.debugLineNum = 228;BA.debugLine="Stored(5,8) = \"2\"";
mostCurrent._stored[(int) (5)][(int) (8)] = "2";
 //BA.debugLineNum = 230;BA.debugLine="Stored(6,0) = \"\"";
mostCurrent._stored[(int) (6)][(int) (0)] = "";
 //BA.debugLineNum = 231;BA.debugLine="Stored(6,1) = \"\"";
mostCurrent._stored[(int) (6)][(int) (1)] = "";
 //BA.debugLineNum = 232;BA.debugLine="Stored(6,2) = \"\"";
mostCurrent._stored[(int) (6)][(int) (2)] = "";
 //BA.debugLineNum = 233;BA.debugLine="Stored(6,3) = \"\"";
mostCurrent._stored[(int) (6)][(int) (3)] = "";
 //BA.debugLineNum = 234;BA.debugLine="Stored(6,4) = \"\"";
mostCurrent._stored[(int) (6)][(int) (4)] = "";
 //BA.debugLineNum = 235;BA.debugLine="Stored(6,5) = \"9\"";
mostCurrent._stored[(int) (6)][(int) (5)] = "9";
 //BA.debugLineNum = 236;BA.debugLine="Stored(6,6) = \"\"";
mostCurrent._stored[(int) (6)][(int) (6)] = "";
 //BA.debugLineNum = 237;BA.debugLine="Stored(6,7) = \"\"";
mostCurrent._stored[(int) (6)][(int) (7)] = "";
 //BA.debugLineNum = 238;BA.debugLine="Stored(6,8) = \"8\"";
mostCurrent._stored[(int) (6)][(int) (8)] = "8";
 //BA.debugLineNum = 240;BA.debugLine="Stored(7,0) = \"\"";
mostCurrent._stored[(int) (7)][(int) (0)] = "";
 //BA.debugLineNum = 241;BA.debugLine="Stored(7,1) = \"\"";
mostCurrent._stored[(int) (7)][(int) (1)] = "";
 //BA.debugLineNum = 242;BA.debugLine="Stored(7,2) = \"\"";
mostCurrent._stored[(int) (7)][(int) (2)] = "";
 //BA.debugLineNum = 243;BA.debugLine="Stored(7,3) = \"7\"";
mostCurrent._stored[(int) (7)][(int) (3)] = "7";
 //BA.debugLineNum = 244;BA.debugLine="Stored(7,4) = \"8\"";
mostCurrent._stored[(int) (7)][(int) (4)] = "8";
 //BA.debugLineNum = 245;BA.debugLine="Stored(7,5) = \"\"";
mostCurrent._stored[(int) (7)][(int) (5)] = "";
 //BA.debugLineNum = 246;BA.debugLine="Stored(7,6) = \"3\"";
mostCurrent._stored[(int) (7)][(int) (6)] = "3";
 //BA.debugLineNum = 247;BA.debugLine="Stored(7,7) = \"\"";
mostCurrent._stored[(int) (7)][(int) (7)] = "";
 //BA.debugLineNum = 248;BA.debugLine="Stored(7,8) = \"\"";
mostCurrent._stored[(int) (7)][(int) (8)] = "";
 //BA.debugLineNum = 250;BA.debugLine="Stored(8,0) = \"8\"";
mostCurrent._stored[(int) (8)][(int) (0)] = "8";
 //BA.debugLineNum = 251;BA.debugLine="Stored(8,1) = \"\"";
mostCurrent._stored[(int) (8)][(int) (1)] = "";
 //BA.debugLineNum = 252;BA.debugLine="Stored(8,2) = \"\"";
mostCurrent._stored[(int) (8)][(int) (2)] = "";
 //BA.debugLineNum = 253;BA.debugLine="Stored(8,3) = \"\"";
mostCurrent._stored[(int) (8)][(int) (3)] = "";
 //BA.debugLineNum = 254;BA.debugLine="Stored(8,4) = \"4\"";
mostCurrent._stored[(int) (8)][(int) (4)] = "4";
 //BA.debugLineNum = 255;BA.debugLine="Stored(8,5) = \"\"";
mostCurrent._stored[(int) (8)][(int) (5)] = "";
 //BA.debugLineNum = 256;BA.debugLine="Stored(8,6) = \"\"";
mostCurrent._stored[(int) (8)][(int) (6)] = "";
 //BA.debugLineNum = 257;BA.debugLine="Stored(8,7) = \"5\"";
mostCurrent._stored[(int) (8)][(int) (7)] = "5";
 //BA.debugLineNum = 258;BA.debugLine="Stored(8,8) = \"1\"";
mostCurrent._stored[(int) (8)][(int) (8)] = "1";
 //BA.debugLineNum = 260;BA.debugLine="End Sub";
return "";
}
public static String  _populatestored_medium() throws Exception{
 //BA.debugLineNum = 76;BA.debugLine="Sub PopulateStored_Medium";
 //BA.debugLineNum = 77;BA.debugLine="Stored(0,0) = \"6\"";
mostCurrent._stored[(int) (0)][(int) (0)] = "6";
 //BA.debugLineNum = 78;BA.debugLine="Stored(0,1) = \"\"";
mostCurrent._stored[(int) (0)][(int) (1)] = "";
 //BA.debugLineNum = 79;BA.debugLine="Stored(0,2) = \"1\"";
mostCurrent._stored[(int) (0)][(int) (2)] = "1";
 //BA.debugLineNum = 80;BA.debugLine="Stored(0,3) = \"\"";
mostCurrent._stored[(int) (0)][(int) (3)] = "";
 //BA.debugLineNum = 81;BA.debugLine="Stored(0,4) = \"\"";
mostCurrent._stored[(int) (0)][(int) (4)] = "";
 //BA.debugLineNum = 82;BA.debugLine="Stored(0,5) = \"\"";
mostCurrent._stored[(int) (0)][(int) (5)] = "";
 //BA.debugLineNum = 83;BA.debugLine="Stored(0,6) = \"2\"";
mostCurrent._stored[(int) (0)][(int) (6)] = "2";
 //BA.debugLineNum = 84;BA.debugLine="Stored(0,7) = \"5\"";
mostCurrent._stored[(int) (0)][(int) (7)] = "5";
 //BA.debugLineNum = 85;BA.debugLine="Stored(0,8) = \"\"";
mostCurrent._stored[(int) (0)][(int) (8)] = "";
 //BA.debugLineNum = 87;BA.debugLine="Stored(1,0) = \"\"";
mostCurrent._stored[(int) (1)][(int) (0)] = "";
 //BA.debugLineNum = 88;BA.debugLine="Stored(1,1) = \"\"";
mostCurrent._stored[(int) (1)][(int) (1)] = "";
 //BA.debugLineNum = 89;BA.debugLine="Stored(1,2) = \"7\"";
mostCurrent._stored[(int) (1)][(int) (2)] = "7";
 //BA.debugLineNum = 90;BA.debugLine="Stored(1,3) = \"4\"";
mostCurrent._stored[(int) (1)][(int) (3)] = "4";
 //BA.debugLineNum = 91;BA.debugLine="Stored(1,4) = \"\"";
mostCurrent._stored[(int) (1)][(int) (4)] = "";
 //BA.debugLineNum = 92;BA.debugLine="Stored(1,5) = \"2\"";
mostCurrent._stored[(int) (1)][(int) (5)] = "2";
 //BA.debugLineNum = 93;BA.debugLine="Stored(1,6) = \"\"";
mostCurrent._stored[(int) (1)][(int) (6)] = "";
 //BA.debugLineNum = 94;BA.debugLine="Stored(1,7) = \"\"";
mostCurrent._stored[(int) (1)][(int) (7)] = "";
 //BA.debugLineNum = 95;BA.debugLine="Stored(1,8) = \"8\"";
mostCurrent._stored[(int) (1)][(int) (8)] = "8";
 //BA.debugLineNum = 97;BA.debugLine="Stored(2,0) = \"\"";
mostCurrent._stored[(int) (2)][(int) (0)] = "";
 //BA.debugLineNum = 98;BA.debugLine="Stored(2,1) = \"3\"";
mostCurrent._stored[(int) (2)][(int) (1)] = "3";
 //BA.debugLineNum = 99;BA.debugLine="Stored(2,2) = \"\"";
mostCurrent._stored[(int) (2)][(int) (2)] = "";
 //BA.debugLineNum = 100;BA.debugLine="Stored(2,3) = \"\"";
mostCurrent._stored[(int) (2)][(int) (3)] = "";
 //BA.debugLineNum = 101;BA.debugLine="Stored(2,4) = \"\"";
mostCurrent._stored[(int) (2)][(int) (4)] = "";
 //BA.debugLineNum = 102;BA.debugLine="Stored(2,5) = \"\"";
mostCurrent._stored[(int) (2)][(int) (5)] = "";
 //BA.debugLineNum = 103;BA.debugLine="Stored(2,6) = \"\"";
mostCurrent._stored[(int) (2)][(int) (6)] = "";
 //BA.debugLineNum = 104;BA.debugLine="Stored(2,7) = \"6\"";
mostCurrent._stored[(int) (2)][(int) (7)] = "6";
 //BA.debugLineNum = 105;BA.debugLine="Stored(2,8) = \"\"";
mostCurrent._stored[(int) (2)][(int) (8)] = "";
 //BA.debugLineNum = 107;BA.debugLine="Stored(3,0) = \"\"";
mostCurrent._stored[(int) (3)][(int) (0)] = "";
 //BA.debugLineNum = 108;BA.debugLine="Stored(3,1) = \"1\"";
mostCurrent._stored[(int) (3)][(int) (1)] = "1";
 //BA.debugLineNum = 109;BA.debugLine="Stored(3,2) = \"\"";
mostCurrent._stored[(int) (3)][(int) (2)] = "";
 //BA.debugLineNum = 110;BA.debugLine="Stored(3,3) = \"7\"";
mostCurrent._stored[(int) (3)][(int) (3)] = "7";
 //BA.debugLineNum = 111;BA.debugLine="Stored(3,4) = \"\"";
mostCurrent._stored[(int) (3)][(int) (4)] = "";
 //BA.debugLineNum = 112;BA.debugLine="Stored(3,5) = \"\"";
mostCurrent._stored[(int) (3)][(int) (5)] = "";
 //BA.debugLineNum = 113;BA.debugLine="Stored(3,6) = \"\"";
mostCurrent._stored[(int) (3)][(int) (6)] = "";
 //BA.debugLineNum = 114;BA.debugLine="Stored(3,7) = \"2\"";
mostCurrent._stored[(int) (3)][(int) (7)] = "2";
 //BA.debugLineNum = 115;BA.debugLine="Stored(3,8) = \"\"";
mostCurrent._stored[(int) (3)][(int) (8)] = "";
 //BA.debugLineNum = 117;BA.debugLine="Stored(4,0) = \"4\"";
mostCurrent._stored[(int) (4)][(int) (0)] = "4";
 //BA.debugLineNum = 118;BA.debugLine="Stored(4,1) = \"\"";
mostCurrent._stored[(int) (4)][(int) (1)] = "";
 //BA.debugLineNum = 119;BA.debugLine="Stored(4,2) = \"\"";
mostCurrent._stored[(int) (4)][(int) (2)] = "";
 //BA.debugLineNum = 120;BA.debugLine="Stored(4,3) = \"\"";
mostCurrent._stored[(int) (4)][(int) (3)] = "";
 //BA.debugLineNum = 121;BA.debugLine="Stored(4,4) = \"3\"";
mostCurrent._stored[(int) (4)][(int) (4)] = "3";
 //BA.debugLineNum = 122;BA.debugLine="Stored(4,5) = \"\"";
mostCurrent._stored[(int) (4)][(int) (5)] = "";
 //BA.debugLineNum = 123;BA.debugLine="Stored(4,6) = \"\"";
mostCurrent._stored[(int) (4)][(int) (6)] = "";
 //BA.debugLineNum = 124;BA.debugLine="Stored(4,7) = \"\"";
mostCurrent._stored[(int) (4)][(int) (7)] = "";
 //BA.debugLineNum = 125;BA.debugLine="Stored(4,8) = \"6\"";
mostCurrent._stored[(int) (4)][(int) (8)] = "6";
 //BA.debugLineNum = 127;BA.debugLine="Stored(5,0) = \"\"";
mostCurrent._stored[(int) (5)][(int) (0)] = "";
 //BA.debugLineNum = 128;BA.debugLine="Stored(5,1) = \"2\"";
mostCurrent._stored[(int) (5)][(int) (1)] = "2";
 //BA.debugLineNum = 129;BA.debugLine="Stored(5,2) = \"\"";
mostCurrent._stored[(int) (5)][(int) (2)] = "";
 //BA.debugLineNum = 130;BA.debugLine="Stored(5,3) = \"\"";
mostCurrent._stored[(int) (5)][(int) (3)] = "";
 //BA.debugLineNum = 131;BA.debugLine="Stored(5,4) = \"\"";
mostCurrent._stored[(int) (5)][(int) (4)] = "";
 //BA.debugLineNum = 132;BA.debugLine="Stored(5,5) = \"5\"";
mostCurrent._stored[(int) (5)][(int) (5)] = "5";
 //BA.debugLineNum = 133;BA.debugLine="Stored(5,6) = \"\"";
mostCurrent._stored[(int) (5)][(int) (6)] = "";
 //BA.debugLineNum = 134;BA.debugLine="Stored(5,7) = \"1\"";
mostCurrent._stored[(int) (5)][(int) (7)] = "1";
 //BA.debugLineNum = 135;BA.debugLine="Stored(5,8) = \"\"";
mostCurrent._stored[(int) (5)][(int) (8)] = "";
 //BA.debugLineNum = 137;BA.debugLine="Stored(6,0) = \"\"";
mostCurrent._stored[(int) (6)][(int) (0)] = "";
 //BA.debugLineNum = 138;BA.debugLine="Stored(6,1) = \"8\"";
mostCurrent._stored[(int) (6)][(int) (1)] = "8";
 //BA.debugLineNum = 139;BA.debugLine="Stored(6,2) = \"\"";
mostCurrent._stored[(int) (6)][(int) (2)] = "";
 //BA.debugLineNum = 140;BA.debugLine="Stored(6,3) = \"\"";
mostCurrent._stored[(int) (6)][(int) (3)] = "";
 //BA.debugLineNum = 141;BA.debugLine="Stored(6,4) = \"\"";
mostCurrent._stored[(int) (6)][(int) (4)] = "";
 //BA.debugLineNum = 142;BA.debugLine="Stored(6,5) = \"\"";
mostCurrent._stored[(int) (6)][(int) (5)] = "";
 //BA.debugLineNum = 143;BA.debugLine="Stored(6,6) = \"\"";
mostCurrent._stored[(int) (6)][(int) (6)] = "";
 //BA.debugLineNum = 144;BA.debugLine="Stored(6,7) = \"7\"";
mostCurrent._stored[(int) (6)][(int) (7)] = "7";
 //BA.debugLineNum = 145;BA.debugLine="Stored(6,8) = \"\"";
mostCurrent._stored[(int) (6)][(int) (8)] = "";
 //BA.debugLineNum = 147;BA.debugLine="Stored(7,0) = \"1\"";
mostCurrent._stored[(int) (7)][(int) (0)] = "1";
 //BA.debugLineNum = 148;BA.debugLine="Stored(7,1) = \"\"";
mostCurrent._stored[(int) (7)][(int) (1)] = "";
 //BA.debugLineNum = 149;BA.debugLine="Stored(7,2) = \"\"";
mostCurrent._stored[(int) (7)][(int) (2)] = "";
 //BA.debugLineNum = 150;BA.debugLine="Stored(7,3) = \"3\"";
mostCurrent._stored[(int) (7)][(int) (3)] = "3";
 //BA.debugLineNum = 151;BA.debugLine="Stored(7,4) = \"\"";
mostCurrent._stored[(int) (7)][(int) (4)] = "";
 //BA.debugLineNum = 152;BA.debugLine="Stored(7,5) = \"8\"";
mostCurrent._stored[(int) (7)][(int) (5)] = "8";
 //BA.debugLineNum = 153;BA.debugLine="Stored(7,6) = \"6\"";
mostCurrent._stored[(int) (7)][(int) (6)] = "6";
 //BA.debugLineNum = 154;BA.debugLine="Stored(7,7) = \"\"";
mostCurrent._stored[(int) (7)][(int) (7)] = "";
 //BA.debugLineNum = 155;BA.debugLine="Stored(7,8) = \"\"";
mostCurrent._stored[(int) (7)][(int) (8)] = "";
 //BA.debugLineNum = 157;BA.debugLine="Stored(8,0) = \"\"";
mostCurrent._stored[(int) (8)][(int) (0)] = "";
 //BA.debugLineNum = 158;BA.debugLine="Stored(8,1) = \"6\"";
mostCurrent._stored[(int) (8)][(int) (1)] = "6";
 //BA.debugLineNum = 159;BA.debugLine="Stored(8,2) = \"9\"";
mostCurrent._stored[(int) (8)][(int) (2)] = "9";
 //BA.debugLineNum = 160;BA.debugLine="Stored(8,3) = \"\"";
mostCurrent._stored[(int) (8)][(int) (3)] = "";
 //BA.debugLineNum = 161;BA.debugLine="Stored(8,4) = \"\"";
mostCurrent._stored[(int) (8)][(int) (4)] = "";
 //BA.debugLineNum = 162;BA.debugLine="Stored(8,5) = \"\"";
mostCurrent._stored[(int) (8)][(int) (5)] = "";
 //BA.debugLineNum = 163;BA.debugLine="Stored(8,6) = \"8\"";
mostCurrent._stored[(int) (8)][(int) (6)] = "8";
 //BA.debugLineNum = 164;BA.debugLine="Stored(8,7) = \"\"";
mostCurrent._stored[(int) (8)][(int) (7)] = "";
 //BA.debugLineNum = 165;BA.debugLine="Stored(8,8) = \"1\"";
mostCurrent._stored[(int) (8)][(int) (8)] = "1";
 //BA.debugLineNum = 167;BA.debugLine="End Sub";
return "";
}

public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main._process_globals();
starter._process_globals();
information._process_globals();
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static String  _process_globals() throws Exception{
 //BA.debugLineNum = 16;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 20;BA.debugLine="End Sub";
return "";
}
public static String  _searchgrid() throws Exception{
 //BA.debugLineNum = 586;BA.debugLine="Sub SearchGrid";
 //BA.debugLineNum = 587;BA.debugLine="ClearGridBackground";
_cleargridbackground();
 //BA.debugLineNum = 588;BA.debugLine="CheckRows(SolveOn)";
_checkrows(_solveon);
 //BA.debugLineNum = 589;BA.debugLine="CheckColumns(SolveOn)";
_checkcolumns(_solveon);
 //BA.debugLineNum = 590;BA.debugLine="CheckSquares(SolveOn)";
_checksquares(_solveon);
 //BA.debugLineNum = 591;BA.debugLine="CheckExisting(SolveOn)";
_checkexisting(_solveon);
 //BA.debugLineNum = 592;BA.debugLine="CheckIndividualTotals";
_checkindividualtotals();
 //BA.debugLineNum = 593;BA.debugLine="CheckTotalCount						' Finds total count";
_checktotalcount();
 //BA.debugLineNum = 594;BA.debugLine="End Sub";
return "";
}
public static boolean  _solvecolumns() throws Exception{
boolean _change = false;
int _i = 0;
int _count = 0;
int _index = 0;
int _j = 0;
 //BA.debugLineNum = 632;BA.debugLine="Sub SolveColumns As Boolean";
 //BA.debugLineNum = 633;BA.debugLine="Dim Change As Boolean = False";
_change = anywheresoftware.b4a.keywords.Common.False;
 //BA.debugLineNum = 634;BA.debugLine="For i =0 To NbCols-1";
{
final int step2 = 1;
final int limit2 = (int) (_nbcols-1);
_i = (int) (0) ;
for (;_i <= limit2 ;_i = _i + step2 ) {
 //BA.debugLineNum = 635;BA.debugLine="Dim Count As Int";
_count = 0;
 //BA.debugLineNum = 636;BA.debugLine="Dim Index As Int";
_index = 0;
 //BA.debugLineNum = 637;BA.debugLine="For j=0 To NbRows-1";
{
final int step5 = 1;
final int limit5 = (int) (_nbrows-1);
_j = (int) (0) ;
for (;_j <= limit5 ;_j = _j + step5 ) {
 //BA.debugLineNum = 638;BA.debugLine="If gridlbl(j,i).Tag<>\"V\" Then";
if ((mostCurrent._gridlbl[_j][_i].getTag()).equals((Object)("V")) == false) { 
 //BA.debugLineNum = 639;BA.debugLine="Count=Count+1								' Number of empty cells";
_count = (int) (_count+1);
 //BA.debugLineNum = 640;BA.debugLine="Index = j									' location of last empty cel";
_index = _j;
 };
 }
};
 //BA.debugLineNum = 643;BA.debugLine="If Count = 1  Then           'assumes only one s";
if (_count==1) { 
 //BA.debugLineNum = 644;BA.debugLine="gridlbl(Index,i).Text = NumberSelected";
mostCurrent._gridlbl[_index][_i].setText(BA.ObjectToCharSequence(_numberselected));
 //BA.debugLineNum = 645;BA.debugLine="Change=True";
_change = anywheresoftware.b4a.keywords.Common.True;
 };
 }
};
 //BA.debugLineNum = 648;BA.debugLine="Return Change";
if (true) return _change;
 //BA.debugLineNum = 649;BA.debugLine="End Sub";
return false;
}
public static String  _solvelabel(boolean _input) throws Exception{
 //BA.debugLineNum = 598;BA.debugLine="Sub SolveLabel(Input As Boolean)";
 //BA.debugLineNum = 599;BA.debugLine="If Input=True Then";
if (_input==anywheresoftware.b4a.keywords.Common.True) { 
 //BA.debugLineNum = 600;BA.debugLine="lblSolveOnOff.Text=\"SOLVE ON\"";
mostCurrent._lblsolveonoff.setText(BA.ObjectToCharSequence("SOLVE ON"));
 }else {
 //BA.debugLineNum = 602;BA.debugLine="lblSolveOnOff.Text=\"SOLVE OFF\"";
mostCurrent._lblsolveonoff.setText(BA.ObjectToCharSequence("SOLVE OFF"));
 };
 //BA.debugLineNum = 604;BA.debugLine="End Sub";
return "";
}
public static boolean  _solverows() throws Exception{
boolean _change = false;
int _i = 0;
int _count = 0;
int _index = 0;
int _j = 0;
 //BA.debugLineNum = 610;BA.debugLine="Sub SolveRows As Boolean";
 //BA.debugLineNum = 611;BA.debugLine="Dim Change As Boolean = False";
_change = anywheresoftware.b4a.keywords.Common.False;
 //BA.debugLineNum = 612;BA.debugLine="For i =0 To NbRows-1                  ' does each";
{
final int step2 = 1;
final int limit2 = (int) (_nbrows-1);
_i = (int) (0) ;
for (;_i <= limit2 ;_i = _i + step2 ) {
 //BA.debugLineNum = 613;BA.debugLine="Dim Count As Int";
_count = 0;
 //BA.debugLineNum = 614;BA.debugLine="Dim Index As Int";
_index = 0;
 //BA.debugLineNum = 615;BA.debugLine="For j=0 To NbCols-1";
{
final int step5 = 1;
final int limit5 = (int) (_nbcols-1);
_j = (int) (0) ;
for (;_j <= limit5 ;_j = _j + step5 ) {
 //BA.debugLineNum = 616;BA.debugLine="If gridlbl(i,j).Tag<>\"V\" Then";
if ((mostCurrent._gridlbl[_i][_j].getTag()).equals((Object)("V")) == false) { 
 //BA.debugLineNum = 617;BA.debugLine="Count=Count+1";
_count = (int) (_count+1);
 //BA.debugLineNum = 618;BA.debugLine="Index = j									' location of last empty cel";
_index = _j;
 };
 }
};
 //BA.debugLineNum = 621;BA.debugLine="If Count = 1  Then";
if (_count==1) { 
 //BA.debugLineNum = 622;BA.debugLine="gridlbl(i,Index).Text = NumberSelected";
mostCurrent._gridlbl[_i][_index].setText(BA.ObjectToCharSequence(_numberselected));
 //BA.debugLineNum = 623;BA.debugLine="Change=True";
_change = anywheresoftware.b4a.keywords.Common.True;
 };
 }
};
 //BA.debugLineNum = 626;BA.debugLine="Return Change";
if (true) return _change;
 //BA.debugLineNum = 627;BA.debugLine="End Sub";
return false;
}
public static boolean  _solvesquares() throws Exception{
 //BA.debugLineNum = 677;BA.debugLine="Sub SolveSquares As Boolean";
 //BA.debugLineNum = 678;BA.debugLine="Return SolveSquaresDone(0,0) Or SolveSquaresDone(";
if (true) return _solvesquaresdone((int) (0),(int) (0)) || _solvesquaresdone((int) (0),(int) (3)) || _solvesquaresdone((int) (0),(int) (6)) || _solvesquaresdone((int) (3),(int) (0)) || _solvesquaresdone((int) (3),(int) (3)) || _solvesquaresdone((int) (3),(int) (6)) || _solvesquaresdone((int) (6),(int) (0)) || _solvesquaresdone((int) (6),(int) (3)) || _solvesquaresdone((int) (6),(int) (6));
 //BA.debugLineNum = 680;BA.debugLine="End Sub";
return false;
}
public static boolean  _solvesquaresdone(int _toprow,int _topcol) throws Exception{
boolean _change = false;
int _count = 0;
int _indexi = 0;
int _indexj = 0;
int _i = 0;
int _j = 0;
 //BA.debugLineNum = 655;BA.debugLine="Sub SolveSquaresDone(TopRow As Int, TopCol As Int)";
 //BA.debugLineNum = 656;BA.debugLine="Dim Change As Boolean = False";
_change = anywheresoftware.b4a.keywords.Common.False;
 //BA.debugLineNum = 657;BA.debugLine="Dim Count As Int";
_count = 0;
 //BA.debugLineNum = 658;BA.debugLine="Dim IndexI As Int";
_indexi = 0;
 //BA.debugLineNum = 659;BA.debugLine="Dim IndexJ As Int";
_indexj = 0;
 //BA.debugLineNum = 660;BA.debugLine="For i=TopRow To TopRow+2";
{
final int step5 = 1;
final int limit5 = (int) (_toprow+2);
_i = _toprow ;
for (;_i <= limit5 ;_i = _i + step5 ) {
 //BA.debugLineNum = 661;BA.debugLine="For j=TopCol To TopCol+2";
{
final int step6 = 1;
final int limit6 = (int) (_topcol+2);
_j = _topcol ;
for (;_j <= limit6 ;_j = _j + step6 ) {
 //BA.debugLineNum = 662;BA.debugLine="If gridlbl(j,i).Tag<>\"V\" Then";
if ((mostCurrent._gridlbl[_j][_i].getTag()).equals((Object)("V")) == false) { 
 //BA.debugLineNum = 663;BA.debugLine="Count=Count+1								' Number of empty cells";
_count = (int) (_count+1);
 //BA.debugLineNum = 664;BA.debugLine="IndexI = i";
_indexi = _i;
 //BA.debugLineNum = 665;BA.debugLine="IndexJ = j									' location of last empty ce";
_indexj = _j;
 };
 }
};
 }
};
 //BA.debugLineNum = 669;BA.debugLine="If Count = 1  Then           'assumes only one sp";
if (_count==1) { 
 //BA.debugLineNum = 670;BA.debugLine="gridlbl(IndexJ,IndexI).Text = NumberSelected";
mostCurrent._gridlbl[_indexj][_indexi].setText(BA.ObjectToCharSequence(_numberselected));
 //BA.debugLineNum = 671;BA.debugLine="Change=True";
_change = anywheresoftware.b4a.keywords.Common.True;
 };
 //BA.debugLineNum = 673;BA.debugLine="Return Change";
if (true) return _change;
 //BA.debugLineNum = 674;BA.debugLine="End Sub";
return false;
}
public static boolean  _verifycompletecols() throws Exception{
boolean _answer = false;
int _i = 0;
String[] _testarray = null;
int _j = 0;
int _number = 0;
int _k = 0;
 //BA.debugLineNum = 403;BA.debugLine="Sub VerifyCompleteCols As Boolean";
 //BA.debugLineNum = 404;BA.debugLine="Dim Answer As Boolean = True";
_answer = anywheresoftware.b4a.keywords.Common.True;
 //BA.debugLineNum = 405;BA.debugLine="For i =0 To NbRows-1";
{
final int step2 = 1;
final int limit2 = (int) (_nbrows-1);
_i = (int) (0) ;
for (;_i <= limit2 ;_i = _i + step2 ) {
 //BA.debugLineNum = 406;BA.debugLine="Dim TestArray(10) As String";
_testarray = new String[(int) (10)];
java.util.Arrays.fill(_testarray,"");
 //BA.debugLineNum = 407;BA.debugLine="For j=0 To NbCols-1";
{
final int step4 = 1;
final int limit4 = (int) (_nbcols-1);
_j = (int) (0) ;
for (;_j <= limit4 ;_j = _j + step4 ) {
 //BA.debugLineNum = 408;BA.debugLine="If gridlbl(i,j).Text.Length>0 Then";
if (mostCurrent._gridlbl[_i][_j].getText().length()>0) { 
 //BA.debugLineNum = 409;BA.debugLine="Dim Number As Int = gridlbl(i,j).text";
_number = (int)(Double.parseDouble(mostCurrent._gridlbl[_i][_j].getText()));
 //BA.debugLineNum = 410;BA.debugLine="TestArray(Number) =\"A\"";
_testarray[_number] = "A";
 };
 }
};
 //BA.debugLineNum = 413;BA.debugLine="For k = 1 To 9";
{
final int step10 = 1;
final int limit10 = (int) (9);
_k = (int) (1) ;
for (;_k <= limit10 ;_k = _k + step10 ) {
 //BA.debugLineNum = 414;BA.debugLine="If TestArray(k)<>\"A\" Then";
if ((_testarray[_k]).equals("A") == false) { 
 //BA.debugLineNum = 415;BA.debugLine="Answer = False";
_answer = anywheresoftware.b4a.keywords.Common.False;
 };
 }
};
 }
};
 //BA.debugLineNum = 419;BA.debugLine="Return Answer";
if (true) return _answer;
 //BA.debugLineNum = 420;BA.debugLine="End Sub";
return false;
}
public static boolean  _verifycompleterows() throws Exception{
boolean _answer = false;
int _i = 0;
String[] _testarray = null;
int _j = 0;
int _number = 0;
int _k = 0;
 //BA.debugLineNum = 383;BA.debugLine="Sub VerifyCompleteRows As Boolean";
 //BA.debugLineNum = 384;BA.debugLine="Dim Answer As Boolean = True";
_answer = anywheresoftware.b4a.keywords.Common.True;
 //BA.debugLineNum = 385;BA.debugLine="For i =0 To NbCols-1";
{
final int step2 = 1;
final int limit2 = (int) (_nbcols-1);
_i = (int) (0) ;
for (;_i <= limit2 ;_i = _i + step2 ) {
 //BA.debugLineNum = 386;BA.debugLine="Dim TestArray(10) As String";
_testarray = new String[(int) (10)];
java.util.Arrays.fill(_testarray,"");
 //BA.debugLineNum = 387;BA.debugLine="For j=0 To NbRows-1";
{
final int step4 = 1;
final int limit4 = (int) (_nbrows-1);
_j = (int) (0) ;
for (;_j <= limit4 ;_j = _j + step4 ) {
 //BA.debugLineNum = 388;BA.debugLine="If gridlbl(j,i).Text.Length>0 Then";
if (mostCurrent._gridlbl[_j][_i].getText().length()>0) { 
 //BA.debugLineNum = 389;BA.debugLine="Dim Number As Int = gridlbl(j,i).text";
_number = (int)(Double.parseDouble(mostCurrent._gridlbl[_j][_i].getText()));
 //BA.debugLineNum = 390;BA.debugLine="TestArray(Number) =\"A\"";
_testarray[_number] = "A";
 };
 }
};
 //BA.debugLineNum = 393;BA.debugLine="For k = 1 To 9";
{
final int step10 = 1;
final int limit10 = (int) (9);
_k = (int) (1) ;
for (;_k <= limit10 ;_k = _k + step10 ) {
 //BA.debugLineNum = 394;BA.debugLine="If TestArray(k)<>\"A\" Then";
if ((_testarray[_k]).equals("A") == false) { 
 //BA.debugLineNum = 395;BA.debugLine="Answer = False";
_answer = anywheresoftware.b4a.keywords.Common.False;
 };
 }
};
 }
};
 //BA.debugLineNum = 399;BA.debugLine="Return Answer";
if (true) return _answer;
 //BA.debugLineNum = 400;BA.debugLine="End Sub";
return false;
}
public static boolean  _verifycompletesquares() throws Exception{
 //BA.debugLineNum = 378;BA.debugLine="Sub VerifyCompleteSquares As Boolean";
 //BA.debugLineNum = 379;BA.debugLine="Return VerifySquaresDone(0,0) And VerifySquaresDo";
if (true) return _verifysquaresdone((int) (0),(int) (0)) && _verifysquaresdone((int) (0),(int) (3)) && _verifysquaresdone((int) (0),(int) (6)) && _verifysquaresdone((int) (3),(int) (0)) && _verifysquaresdone((int) (3),(int) (3)) && _verifysquaresdone((int) (3),(int) (6)) && _verifysquaresdone((int) (6),(int) (0)) && _verifysquaresdone((int) (6),(int) (3)) && _verifysquaresdone((int) (6),(int) (6));
 //BA.debugLineNum = 381;BA.debugLine="End Sub";
return false;
}
public static boolean  _verifysquaresdone(int _toprow,int _topcol) throws Exception{
String[] _testarray = null;
boolean _answer = false;
int _i = 0;
int _j = 0;
int _number = 0;
int _k = 0;
 //BA.debugLineNum = 358;BA.debugLine="Sub VerifySquaresDone(TopRow As Int, TopCol As Int";
 //BA.debugLineNum = 359;BA.debugLine="Dim TestArray(10) As String";
_testarray = new String[(int) (10)];
java.util.Arrays.fill(_testarray,"");
 //BA.debugLineNum = 360;BA.debugLine="Dim Answer As Boolean=True";
_answer = anywheresoftware.b4a.keywords.Common.True;
 //BA.debugLineNum = 361;BA.debugLine="For i=TopRow To TopRow+2";
{
final int step3 = 1;
final int limit3 = (int) (_toprow+2);
_i = _toprow ;
for (;_i <= limit3 ;_i = _i + step3 ) {
 //BA.debugLineNum = 362;BA.debugLine="For j=TopCol To TopCol+2";
{
final int step4 = 1;
final int limit4 = (int) (_topcol+2);
_j = _topcol ;
for (;_j <= limit4 ;_j = _j + step4 ) {
 //BA.debugLineNum = 363;BA.debugLine="If gridlbl(j,i).Text.Length>0 Then";
if (mostCurrent._gridlbl[_j][_i].getText().length()>0) { 
 //BA.debugLineNum = 364;BA.debugLine="Dim Number As Int = gridlbl(j,i).text";
_number = (int)(Double.parseDouble(mostCurrent._gridlbl[_j][_i].getText()));
 //BA.debugLineNum = 365;BA.debugLine="TestArray(Number) =\"A\"";
_testarray[_number] = "A";
 };
 }
};
 }
};
 //BA.debugLineNum = 369;BA.debugLine="For k = 1 To 9";
{
final int step11 = 1;
final int limit11 = (int) (9);
_k = (int) (1) ;
for (;_k <= limit11 ;_k = _k + step11 ) {
 //BA.debugLineNum = 370;BA.debugLine="If TestArray(k)<>\"A\" Then";
if ((_testarray[_k]).equals("A") == false) { 
 //BA.debugLineNum = 371;BA.debugLine="Answer = False";
_answer = anywheresoftware.b4a.keywords.Common.False;
 };
 }
};
 //BA.debugLineNum = 374;BA.debugLine="Return Answer";
if (true) return _answer;
 //BA.debugLineNum = 375;BA.debugLine="End Sub";
return false;
}
public static String  _verifytotalgrid() throws Exception{
 //BA.debugLineNum = 423;BA.debugLine="Sub VerifyTotalGrid";
 //BA.debugLineNum = 424;BA.debugLine="If VerifyCompleteRows And VerifyCompleteCols And V";
if (_verifycompleterows() && _verifycompletecols() && _verifycompletesquares()) { 
 //BA.debugLineNum = 425;BA.debugLine="If SolveOn Then";
if (_solveon) { 
 //BA.debugLineNum = 426;BA.debugLine="Msgbox(\"AUTO SOLVE did it!\",\"Grid Correct!\")";
anywheresoftware.b4a.keywords.Common.Msgbox(BA.ObjectToCharSequence("AUTO SOLVE did it!"),BA.ObjectToCharSequence("Grid Correct!"),mostCurrent.activityBA);
 }else {
 //BA.debugLineNum = 428;BA.debugLine="Msgbox(\"YOU did it!\",\"Grid Correct!\")";
anywheresoftware.b4a.keywords.Common.Msgbox(BA.ObjectToCharSequence("YOU did it!"),BA.ObjectToCharSequence("Grid Correct!"),mostCurrent.activityBA);
 };
 }else {
 //BA.debugLineNum = 432;BA.debugLine="Msgbox(\"Something is wrong\", \" Grid Incorrect\")";
anywheresoftware.b4a.keywords.Common.Msgbox(BA.ObjectToCharSequence("Something is wrong"),BA.ObjectToCharSequence(" Grid Incorrect"),mostCurrent.activityBA);
 };
 //BA.debugLineNum = 434;BA.debugLine="End Sub";
return "";
}
}
