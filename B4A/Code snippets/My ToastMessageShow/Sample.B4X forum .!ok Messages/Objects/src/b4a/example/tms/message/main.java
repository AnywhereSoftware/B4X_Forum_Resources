package b4a.example.tms.message;


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

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
        mostCurrent = this;
		if (processBA == null) {
			processBA = new BA(this.getApplicationContext(), null, null, "b4a.example.tms.message", "b4a.example.tms.message.main");
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
		activityBA = new BA(this, layout, processBA, "b4a.example.tms.message", "b4a.example.tms.message.main");
        
        processBA.sharedProcessBA.activityBA = new java.lang.ref.WeakReference<BA>(activityBA);
        anywheresoftware.b4a.objects.ViewWrapper.lastId = 0;
        _activity = new ActivityWrapper(activityBA, "activity");
        anywheresoftware.b4a.Msgbox.isDismissing = false;
        if (BA.isShellModeRuntimeCheck(processBA)) {
			if (isFirst)
				processBA.raiseEvent2(null, true, "SHELL", false);
			processBA.raiseEvent2(null, true, "CREATE", true, "b4a.example.tms.message.main", processBA, activityBA, _activity, anywheresoftware.b4a.keywords.Common.Density, mostCurrent);
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
public anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _overlay = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _pnlmessage = null;
public anywheresoftware.b4a.objects.LabelWrapper _label1 = null;
public anywheresoftware.b4a.objects.LabelWrapper _label2 = null;
public static int _corners = 0;
public static boolean _overlayvisible = false;
public b4a.example.tms.message.starter _starter = null;

public static boolean isAnyActivityVisible() {
    boolean vis = false;
vis = vis | (main.mostCurrent != null);
return vis;}
public static String  _activity_create(boolean _firsttime) throws Exception{
 //BA.debugLineNum = 29;BA.debugLine="Sub Activity_Create(FirstTime As Boolean)";
 //BA.debugLineNum = 30;BA.debugLine="Activity.LoadLayout(\"main\")";
mostCurrent._activity.LoadLayout("main",mostCurrent.activityBA);
 //BA.debugLineNum = 31;BA.debugLine="Overlay = xui.CreatePanel(\"Overlay\")";
mostCurrent._overlay = mostCurrent._xui.CreatePanel(processBA,"Overlay");
 //BA.debugLineNum = 32;BA.debugLine="Overlay.Visible = False";
mostCurrent._overlay.setVisible(anywheresoftware.b4a.keywords.Common.False);
 //BA.debugLineNum = 34;BA.debugLine="Activity.AddView(Overlay, 0, 0, 100%x, 100%y)";
mostCurrent._activity.AddView((android.view.View)(mostCurrent._overlay.getObject()),(int) (0),(int) (0),anywheresoftware.b4a.keywords.Common.PerXToCurrent((float) (100),mostCurrent.activityBA),anywheresoftware.b4a.keywords.Common.PerYToCurrent((float) (100),mostCurrent.activityBA));
 //BA.debugLineNum = 36;BA.debugLine="Overlay.LoadLayout(\"overlay_message\")";
mostCurrent._overlay.LoadLayout("overlay_message",mostCurrent.activityBA);
 //BA.debugLineNum = 37;BA.debugLine="pnlMessage.LoadLayout(\"drawer_message\")";
mostCurrent._pnlmessage.LoadLayout("drawer_message",mostCurrent.activityBA);
 //BA.debugLineNum = 38;BA.debugLine="pnlMessage.SetColorAndBorder(xui.Color_ARGB(20,0,";
mostCurrent._pnlmessage.SetColorAndBorder(mostCurrent._xui.Color_ARGB((int) (20),(int) (0),(int) (0),(int) (0)),(int) (0),(int) (0),_corners);
 //BA.debugLineNum = 39;BA.debugLine="End Sub";
return "";
}
public static String  _activity_pause(boolean _userclosed) throws Exception{
 //BA.debugLineNum = 85;BA.debugLine="Sub Activity_Pause (UserClosed As Boolean)";
 //BA.debugLineNum = 86;BA.debugLine="End Sub";
return "";
}
public static String  _activity_resume() throws Exception{
 //BA.debugLineNum = 82;BA.debugLine="Sub Activity_Resume";
 //BA.debugLineNum = 83;BA.debugLine="End Sub";
return "";
}
public static String  _btnshow_click() throws Exception{
 //BA.debugLineNum = 73;BA.debugLine="Sub btnShow_Click";
 //BA.debugLineNum = 74;BA.debugLine="If OverlayVisible Then Return";
if (_overlayvisible) { 
if (true) return "";};
 //BA.debugLineNum = 75;BA.debugLine="ToastMessageShow2";
_toastmessageshow2();
 //BA.debugLineNum = 76;BA.debugLine="End Sub";
return "";
}
public static String  _globals() throws Exception{
 //BA.debugLineNum = 19;BA.debugLine="Sub Globals";
 //BA.debugLineNum = 20;BA.debugLine="Private xui As XUI";
mostCurrent._xui = new anywheresoftware.b4a.objects.B4XViewWrapper.XUI();
 //BA.debugLineNum = 21;BA.debugLine="Private Overlay, pnlMessage As B4XView";
mostCurrent._overlay = new anywheresoftware.b4a.objects.B4XViewWrapper();
mostCurrent._pnlmessage = new anywheresoftware.b4a.objects.B4XViewWrapper();
 //BA.debugLineNum = 22;BA.debugLine="Private Label1, Label2 As Label";
mostCurrent._label1 = new anywheresoftware.b4a.objects.LabelWrapper();
mostCurrent._label2 = new anywheresoftware.b4a.objects.LabelWrapper();
 //BA.debugLineNum = 24;BA.debugLine="Private corners As Int = 125dip";
_corners = anywheresoftware.b4a.keywords.Common.DipToCurrent((int) (125));
 //BA.debugLineNum = 25;BA.debugLine="Private OverlayVisible As Boolean";
_overlayvisible = false;
 //BA.debugLineNum = 27;BA.debugLine="End Sub";
return "";
}
public static String  _overlay_click() throws Exception{
 //BA.debugLineNum = 78;BA.debugLine="Sub Overlay_Click";
 //BA.debugLineNum = 79;BA.debugLine="If OverlayVisible Then ToastMessageShow2_Hide";
if (_overlayvisible) { 
_toastmessageshow2_hide();};
 //BA.debugLineNum = 80;BA.debugLine="End Sub";
return "";
}

public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main._process_globals();
starter._process_globals();
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static String  _process_globals() throws Exception{
 //BA.debugLineNum = 15;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 17;BA.debugLine="End Sub";
return "";
}
public static void  _toastmessageshow2() throws Exception{
ResumableSub_ToastMessageShow2 rsub = new ResumableSub_ToastMessageShow2(null);
rsub.resume(processBA, null);
}
public static class ResumableSub_ToastMessageShow2 extends BA.ResumableSub {
public ResumableSub_ToastMessageShow2(b4a.example.tms.message.main parent) {
this.parent = parent;
}
b4a.example.tms.message.main parent;
int _duration = 0;
anywheresoftware.b4a.objects.PanelWrapper _pnl = null;
int _pnlmessagevisibleheight = 0;

@Override
public void resume(BA ba, Object[] result) throws Exception{

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
 //BA.debugLineNum = 42;BA.debugLine="Dim Duration As Int = 600";
_duration = (int) (600);
 //BA.debugLineNum = 43;BA.debugLine="OverlayVisible = Not(OverlayVisible)";
parent._overlayvisible = anywheresoftware.b4a.keywords.Common.Not(parent._overlayvisible);
 //BA.debugLineNum = 45;BA.debugLine="Dim pnl As Panel = pnlMessage";
_pnl = new anywheresoftware.b4a.objects.PanelWrapper();
_pnl.setObject((android.view.ViewGroup)(parent.mostCurrent._pnlmessage.getObject()));
 //BA.debugLineNum = 46;BA.debugLine="pnl.SetColorAnimated(600,Colors.ARGB(20,0,0,0),Co";
_pnl.SetColorAnimated((int) (600),anywheresoftware.b4a.keywords.Common.Colors.ARGB((int) (20),(int) (0),(int) (0),(int) (0)),anywheresoftware.b4a.keywords.Common.Colors.ARGB((int) (80),(int) (0),(int) (0),(int) (0)));
 //BA.debugLineNum = 48;BA.debugLine="Overlay.SetVisibleAnimated(Duration, OverlayVisib";
parent.mostCurrent._overlay.SetVisibleAnimated(_duration,parent._overlayvisible);
 //BA.debugLineNum = 49;BA.debugLine="Dim pnlMessageVisibleHeight As Int = pnlMessage.H";
_pnlmessagevisibleheight = (int) (parent.mostCurrent._pnlmessage.getHeight()-parent._corners);
 //BA.debugLineNum = 52;BA.debugLine="Label1.TextSize = 17";
parent.mostCurrent._label1.setTextSize((float) (17));
 //BA.debugLineNum = 53;BA.debugLine="pnlMessage.SetLayoutAnimated(0, 0, pnlMessage.Par";
parent.mostCurrent._pnlmessage.SetLayoutAnimated((int) (0),(int) (0),parent.mostCurrent._pnlmessage.getParent().getHeight(),parent.mostCurrent._pnlmessage.getWidth(),parent.mostCurrent._pnlmessage.getHeight());
 //BA.debugLineNum = 54;BA.debugLine="pnlMessage.SetLayoutAnimated(Duration, 0, pnlMess";
parent.mostCurrent._pnlmessage.SetLayoutAnimated(_duration,(int) (0),(int) (parent.mostCurrent._pnlmessage.getParent().getHeight()-_pnlmessagevisibleheight),parent.mostCurrent._pnlmessage.getWidth(),parent.mostCurrent._pnlmessage.getHeight());
 //BA.debugLineNum = 56;BA.debugLine="Sleep(2800)";
anywheresoftware.b4a.keywords.Common.Sleep(mostCurrent.activityBA,this,(int) (2800));
this.state = 7;
return;
case 7:
//C
this.state = 1;
;
 //BA.debugLineNum = 57;BA.debugLine="If OverlayVisible Then ToastMessageShow2_Hide";
if (true) break;

case 1:
//if
this.state = 6;
if (parent._overlayvisible) { 
this.state = 3;
;}if (true) break;

case 3:
//C
this.state = 6;
_toastmessageshow2_hide();
if (true) break;

case 6:
//C
this.state = -1;
;
 //BA.debugLineNum = 59;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public static String  _toastmessageshow2_hide() throws Exception{
int _duration = 0;
int _pnlmessagevisibleheight = 0;
 //BA.debugLineNum = 61;BA.debugLine="Sub ToastMessageShow2_Hide";
 //BA.debugLineNum = 62;BA.debugLine="Dim Duration As Int = 800";
_duration = (int) (800);
 //BA.debugLineNum = 63;BA.debugLine="OverlayVisible = False";
_overlayvisible = anywheresoftware.b4a.keywords.Common.False;
 //BA.debugLineNum = 64;BA.debugLine="Overlay.SetVisibleAnimated(Duration, OverlayVisib";
mostCurrent._overlay.SetVisibleAnimated(_duration,_overlayvisible);
 //BA.debugLineNum = 65;BA.debugLine="Dim pnlMessageVisibleHeight As Int = pnlMessage.H";
_pnlmessagevisibleheight = (int) (mostCurrent._pnlmessage.getHeight()-_corners);
 //BA.debugLineNum = 68;BA.debugLine="Label1.SetTextSizeAnimated(800,4)";
mostCurrent._label1.SetTextSizeAnimated((int) (800),(float) (4));
 //BA.debugLineNum = 69;BA.debugLine="pnlMessage.SetLayoutAnimated(0, 0, pnlMessage.Par";
mostCurrent._pnlmessage.SetLayoutAnimated((int) (0),(int) (0),(int) (mostCurrent._pnlmessage.getParent().getHeight()-_pnlmessagevisibleheight),mostCurrent._pnlmessage.getWidth(),mostCurrent._pnlmessage.getHeight());
 //BA.debugLineNum = 70;BA.debugLine="pnlMessage.SetLayoutAnimated(Duration, 0, pnlMess";
mostCurrent._pnlmessage.SetLayoutAnimated(_duration,(int) (0),mostCurrent._pnlmessage.getParent().getHeight(),mostCurrent._pnlmessage.getWidth(),mostCurrent._pnlmessage.getHeight());
 //BA.debugLineNum = 71;BA.debugLine="End Sub";
return "";
}
}
