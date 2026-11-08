package b4a.zsk.ExportRingtone;


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
	public static final boolean fullScreen = false;
	public static final boolean includeTitle = true;
    public static WeakReference<Activity> previousOne;
    public static boolean dontPause;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
        mostCurrent = this;
		if (processBA == null) {
			processBA = new BA(this.getApplicationContext(), null, null, "b4a.zsk.ExportRingtone", "b4a.zsk.ExportRingtone.main");
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
        if (anywheresoftware.b4a.objects.ServiceHelper.StarterHelper.startFromActivity(this, processBA, wl, true))
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
		activityBA = new BA(this, layout, processBA, "b4a.zsk.ExportRingtone", "b4a.zsk.ExportRingtone.main");
        
        processBA.sharedProcessBA.activityBA = new java.lang.ref.WeakReference<BA>(activityBA);
        anywheresoftware.b4a.objects.ViewWrapper.lastId = 0;
        _activity = new ActivityWrapper(activityBA, "activity");
        anywheresoftware.b4a.Msgbox.isDismissing = false;
        if (BA.isShellModeRuntimeCheck(processBA)) {
			if (isFirst)
				processBA.raiseEvent2(null, true, "SHELL", false);
			processBA.raiseEvent2(null, true, "CREATE", true, "b4a.zsk.ExportRingtone.main", processBA, activityBA, _activity, anywheresoftware.b4a.keywords.Common.Density, mostCurrent);
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
        if (!dontPause)
            BA.LogInfo("** Activity (main) Pause, UserClosed = " + activityBA.activity.isFinishing() + " **");
        else
            BA.LogInfo("** Activity (main) Pause event (activity is not paused). **");
        if (mostCurrent != null)
            processBA.raiseEvent2(_activity, true, "activity_pause", false, activityBA.activity.isFinishing());		
        if (!dontPause) {
            processBA.setActivityPaused(true);
            mostCurrent = null;
        }

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
public static b4a.zsk.RingtoneExporter.RingtoneExporter _myringtoneexporter = null;
public anywheresoftware.b4a.objects.LabelWrapper _labeltype = null;
public anywheresoftware.b4a.objects.LabelWrapper _labeluri = null;
public anywheresoftware.b4a.objects.SpinnerWrapper _spinnertype = null;
public anywheresoftware.b4a.objects.ButtonWrapper _buttonplay = null;
public anywheresoftware.b4a.objects.ButtonWrapper _buttonsave = null;
public anywheresoftware.b4a.objects.ButtonWrapper _buttonexit = null;

public static boolean isAnyActivityVisible() {
    boolean vis = false;
vis = vis | (main.mostCurrent != null);
return vis;}
public static String  _activity_create(boolean _firsttime) throws Exception{
 //BA.debugLineNum = 28;BA.debugLine="Sub Activity_Create(FirstTime As Boolean)";
 //BA.debugLineNum = 29;BA.debugLine="MyRingtoneExporter.Initialize(\"MyRingtoneExporter";
_myringtoneexporter.Initialize(processBA,"MyRingtoneExporter");
 //BA.debugLineNum = 30;BA.debugLine="InitLayout";
_initlayout();
 //BA.debugLineNum = 31;BA.debugLine="End Sub";
return "";
}
public static String  _activity_pause(boolean _userclosed) throws Exception{
 //BA.debugLineNum = 36;BA.debugLine="Sub Activity_Pause (UserClosed As Boolean)";
 //BA.debugLineNum = 37;BA.debugLine="End Sub";
return "";
}
public static String  _activity_resume() throws Exception{
 //BA.debugLineNum = 33;BA.debugLine="Sub Activity_Resume";
 //BA.debugLineNum = 34;BA.debugLine="End Sub";
return "";
}
public static String  _buttonexit_click() throws Exception{
 //BA.debugLineNum = 55;BA.debugLine="Sub ButtonExit_Click";
 //BA.debugLineNum = 56;BA.debugLine="Activity.Finish";
mostCurrent._activity.Finish();
 //BA.debugLineNum = 57;BA.debugLine="ExitApplication";
anywheresoftware.b4a.keywords.Common.ExitApplication();
 //BA.debugLineNum = 58;BA.debugLine="End Sub";
return "";
}
public static String  _buttonplay_click() throws Exception{
 //BA.debugLineNum = 47;BA.debugLine="Sub ButtonPlay_Click";
 //BA.debugLineNum = 48;BA.debugLine="MyRingtoneExporter.PlayRingtone";
_myringtoneexporter.PlayRingtone();
 //BA.debugLineNum = 49;BA.debugLine="End Sub";
return "";
}
public static String  _buttonsave_click() throws Exception{
 //BA.debugLineNum = 51;BA.debugLine="Sub ButtonSave_Click";
 //BA.debugLineNum = 52;BA.debugLine="MyRingtoneExporter.SaveRingtone															'BA";
_myringtoneexporter.SaveRingtone();
 //BA.debugLineNum = 53;BA.debugLine="End Sub";
return "";
}
public static String  _globals() throws Exception{
 //BA.debugLineNum = 19;BA.debugLine="Sub Globals";
 //BA.debugLineNum = 20;BA.debugLine="Dim LabelType As Label";
mostCurrent._labeltype = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 21;BA.debugLine="Dim LabelUri As Label";
mostCurrent._labeluri = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 22;BA.debugLine="Dim SpinnerType As Spinner";
mostCurrent._spinnertype = new anywheresoftware.b4a.objects.SpinnerWrapper();
 //BA.debugLineNum = 23;BA.debugLine="Dim ButtonPlay As Button";
mostCurrent._buttonplay = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 24;BA.debugLine="Dim ButtonSave As Button";
mostCurrent._buttonsave = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 25;BA.debugLine="Dim ButtonExit As Button";
mostCurrent._buttonexit = new anywheresoftware.b4a.objects.ButtonWrapper();
 //BA.debugLineNum = 26;BA.debugLine="End Sub";
return "";
}
public static String  _initlayout() throws Exception{
 //BA.debugLineNum = 60;BA.debugLine="Sub InitLayout()";
 //BA.debugLineNum = 61;BA.debugLine="LabelType.Initialize(\"\")";
mostCurrent._labeltype.Initialize(mostCurrent.activityBA,"");
 //BA.debugLineNum = 62;BA.debugLine="LabelUri.Initialize(\"\")";
mostCurrent._labeluri.Initialize(mostCurrent.activityBA,"");
 //BA.debugLineNum = 63;BA.debugLine="SpinnerType.Initialize(\"SpinnerType\")";
mostCurrent._spinnertype.Initialize(mostCurrent.activityBA,"SpinnerType");
 //BA.debugLineNum = 64;BA.debugLine="ButtonPlay.Initialize(\"ButtonPlay\")";
mostCurrent._buttonplay.Initialize(mostCurrent.activityBA,"ButtonPlay");
 //BA.debugLineNum = 65;BA.debugLine="ButtonSave.Initialize(\"ButtonSave\")";
mostCurrent._buttonsave.Initialize(mostCurrent.activityBA,"ButtonSave");
 //BA.debugLineNum = 66;BA.debugLine="ButtonExit.Initialize(\"ButtonExit\")";
mostCurrent._buttonexit.Initialize(mostCurrent.activityBA,"ButtonExit");
 //BA.debugLineNum = 68;BA.debugLine="LabelType.Text = \"铃声类型\"";
mostCurrent._labeltype.setText(BA.ObjectToCharSequence("铃声类型"));
 //BA.debugLineNum = 69;BA.debugLine="LabelType.TextSize = 14";
mostCurrent._labeltype.setTextSize((float) (14));
 //BA.debugLineNum = 71;BA.debugLine="SpinnerType.AddAll(Array As String(\"RINGTONE\", \"N";
mostCurrent._spinnertype.AddAll(anywheresoftware.b4a.keywords.Common.ArrayToList(new String[]{"RINGTONE","NOTIFICATION","ALARM"}));
 //BA.debugLineNum = 73;BA.debugLine="LabelUri.Text = \"Uri = \" & MyRingtoneExporter.set";
mostCurrent._labeluri.setText(BA.ObjectToCharSequence("Uri = "+_myringtoneexporter.setRingtoneType((int) (1))));
 //BA.debugLineNum = 74;BA.debugLine="LabelUri.TextSize = 14";
mostCurrent._labeluri.setTextSize((float) (14));
 //BA.debugLineNum = 75;BA.debugLine="LabelUri.SingleLine = False";
mostCurrent._labeluri.setSingleLine(anywheresoftware.b4a.keywords.Common.False);
 //BA.debugLineNum = 77;BA.debugLine="ButtonPlay.Text = \"播放\"";
mostCurrent._buttonplay.setText(BA.ObjectToCharSequence("播放"));
 //BA.debugLineNum = 78;BA.debugLine="ButtonPlay.TextSize = 16";
mostCurrent._buttonplay.setTextSize((float) (16));
 //BA.debugLineNum = 80;BA.debugLine="ButtonSave.Text = \"导出\"";
mostCurrent._buttonsave.setText(BA.ObjectToCharSequence("导出"));
 //BA.debugLineNum = 81;BA.debugLine="ButtonSave.TextSize = 16";
mostCurrent._buttonsave.setTextSize((float) (16));
 //BA.debugLineNum = 83;BA.debugLine="ButtonExit.Text = \"退出\"";
mostCurrent._buttonexit.setText(BA.ObjectToCharSequence("退出"));
 //BA.debugLineNum = 84;BA.debugLine="ButtonExit.TextSize = 16";
mostCurrent._buttonexit.setTextSize((float) (16));
 //BA.debugLineNum = 86;BA.debugLine="Activity.AddView(LabelType,     5%X,  7%Y, 20%X,";
mostCurrent._activity.AddView((android.view.View)(mostCurrent._labeltype.getObject()),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (5),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerYToCurrent((float) (7),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (20),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (12),mostCurrent.activityBA));
 //BA.debugLineNum = 87;BA.debugLine="Activity.AddView(LabelUri,      5%X, 20%Y, 90%X,";
mostCurrent._activity.AddView((android.view.View)(mostCurrent._labeluri.getObject()),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (5),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerYToCurrent((float) (20),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (90),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (12),mostCurrent.activityBA));
 //BA.debugLineNum = 88;BA.debugLine="Activity.AddView(SpinnerType,  30%X,  5%Y, 65%X,";
mostCurrent._activity.AddView((android.view.View)(mostCurrent._spinnertype.getObject()),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (30),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerYToCurrent((float) (5),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (65),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (12),mostCurrent.activityBA));
 //BA.debugLineNum = 89;BA.debugLine="Activity.AddView(ButtonPlay,    5%X, 35%Y, 90%X,";
mostCurrent._activity.AddView((android.view.View)(mostCurrent._buttonplay.getObject()),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (5),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerYToCurrent((float) (35),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (90),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerYToCurrent((float) (12),mostCurrent.activityBA));
 //BA.debugLineNum = 90;BA.debugLine="Activity.AddView(ButtonSave,    5%X, 50%Y, 90%X,";
mostCurrent._activity.AddView((android.view.View)(mostCurrent._buttonsave.getObject()),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (5),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerYToCurrent((float) (50),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (90),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerYToCurrent((float) (12),mostCurrent.activityBA));
 //BA.debugLineNum = 91;BA.debugLine="Activity.AddView(ButtonExit,    5%X, 65%Y, 90%X,";
mostCurrent._activity.AddView((android.view.View)(mostCurrent._buttonexit.getObject()),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (5),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerYToCurrent((float) (65),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (90),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerYToCurrent((float) (12),mostCurrent.activityBA));
 //BA.debugLineNum = 92;BA.debugLine="End Sub";
return "";
}

public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main._process_globals();
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static String  _process_globals() throws Exception{
 //BA.debugLineNum = 15;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 16;BA.debugLine="Private MyRingtoneExporter As RingtoneExporter";
_myringtoneexporter = new b4a.zsk.RingtoneExporter.RingtoneExporter();
 //BA.debugLineNum = 17;BA.debugLine="End Sub";
return "";
}
public static String  _spinnertype_itemclick(int _position,Object _value) throws Exception{
 //BA.debugLineNum = 39;BA.debugLine="Sub SpinnerType_ItemClick (Position As Int, Value";
 //BA.debugLineNum = 40;BA.debugLine="If Position = 2 Then";
if (_position==2) { 
 //BA.debugLineNum = 41;BA.debugLine="LabelUri.Text = \"Uri = \" & MyRingtoneExporter.se";
mostCurrent._labeluri.setText(BA.ObjectToCharSequence("Uri = "+_myringtoneexporter.setRingtoneType((int) (_position+2))));
 }else {
 //BA.debugLineNum = 43;BA.debugLine="LabelUri.Text = \"Uri = \" & MyRingtoneExporter.se";
mostCurrent._labeluri.setText(BA.ObjectToCharSequence("Uri = "+_myringtoneexporter.setRingtoneType((int) (_position+1))));
 };
 //BA.debugLineNum = 45;BA.debugLine="End Sub";
return "";
}
}
