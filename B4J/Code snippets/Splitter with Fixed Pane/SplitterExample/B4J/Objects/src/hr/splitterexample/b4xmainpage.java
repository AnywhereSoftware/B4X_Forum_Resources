package hr.splitterexample;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class b4xmainpage extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("hr.splitterexample", "hr.splitterexample.b4xmainpage", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", hr.splitterexample.b4xmainpage.class).invoke(this, new Object[] {null});
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
public anywheresoftware.b4a.objects.B4XViewWrapper _root = null;
public anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public int _spldefault = 0;
public int _splleft = 0;
public int _splright = 0;
public int _spltop = 0;
public int _splbottom = 0;
public hr.splitterexample.keyvaluestore _kvs = null;
public hr.splitterexample.csplitter _verticalsplitter = null;
public hr.splitterexample.csplitter _horizontalsplitter = null;
public hr.splitterexample.main _main = null;
public hr.splitterexample.b4xpages _b4xpages = null;
public hr.splitterexample.b4xcollections _b4xcollections = null;
public String  _b4xpage_created(hr.splitterexample.b4xmainpage __ref,anywheresoftware.b4a.objects.B4XViewWrapper _root1) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "b4xpage_created", false))
	 {return ((String) Debug.delegate(ba, "b4xpage_created", new Object[] {_root1}));}
RDebugUtils.currentLine=589824;
 //BA.debugLineNum = 589824;BA.debugLine="Private Sub B4XPage_Created (Root1 As B4XView)";
RDebugUtils.currentLine=589825;
 //BA.debugLineNum = 589825;BA.debugLine="Root = Root1";
__ref._root /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = _root1;
RDebugUtils.currentLine=589827;
 //BA.debugLineNum = 589827;BA.debugLine="B4XPages.SetTitle(Me, \"Splitter Example\")";
_b4xpages._settitle /*String*/ (this,(Object)("Splitter Example"));
RDebugUtils.currentLine=589829;
 //BA.debugLineNum = 589829;BA.debugLine="VerticalSplitter.Initialize(Root, splLeft, \"Verti";
__ref._verticalsplitter /*hr.splitterexample.csplitter*/ ._initialize /*String*/ (null,ba,__ref._root /*anywheresoftware.b4a.objects.B4XViewWrapper*/ ,__ref._splleft /*int*/ ,"VerticalSplitter");
RDebugUtils.currentLine=589830;
 //BA.debugLineNum = 589830;BA.debugLine="HorizontalSplitter.Initialize(VerticalSplitter.Fl";
__ref._horizontalsplitter /*hr.splitterexample.csplitter*/ ._initialize /*String*/ (null,ba,__ref._verticalsplitter /*hr.splitterexample.csplitter*/ ._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ ,__ref._spltop /*int*/ ,"HorizontalSplitter");
RDebugUtils.currentLine=589832;
 //BA.debugLineNum = 589832;BA.debugLine="VerticalSplitter.FixedPanel.LoadLayout(\"MainPage\"";
__ref._verticalsplitter /*hr.splitterexample.csplitter*/ ._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .LoadLayout("MainPage",ba);
RDebugUtils.currentLine=589833;
 //BA.debugLineNum = 589833;BA.debugLine="HorizontalSplitter.FixedPanel.LoadLayout(\"HorzTop";
__ref._horizontalsplitter /*hr.splitterexample.csplitter*/ ._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .LoadLayout("HorzTop",ba);
RDebugUtils.currentLine=589834;
 //BA.debugLineNum = 589834;BA.debugLine="HorizontalSplitter.FlexPanel.LoadLayout(\"HorzBott";
__ref._horizontalsplitter /*hr.splitterexample.csplitter*/ ._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .LoadLayout("HorzBottom",ba);
RDebugUtils.currentLine=589836;
 //BA.debugLineNum = 589836;BA.debugLine="End Sub";
return "";
}
public String  _button1_click(hr.splitterexample.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "button1_click", false))
	 {return ((String) Debug.delegate(ba, "button1_click", null));}
RDebugUtils.currentLine=655360;
 //BA.debugLineNum = 655360;BA.debugLine="Private Sub Button1_Click";
RDebugUtils.currentLine=655361;
 //BA.debugLineNum = 655361;BA.debugLine="xui.MsgboxAsync(\"Hello world!\", \"B4X\")";
__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .MsgboxAsync(ba,"Hello world!","B4X");
RDebugUtils.currentLine=655362;
 //BA.debugLineNum = 655362;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(hr.splitterexample.b4xmainpage __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xmainpage";
RDebugUtils.currentLine=458752;
 //BA.debugLineNum = 458752;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=458753;
 //BA.debugLineNum = 458753;BA.debugLine="Private Root As B4XView";
_root = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=458754;
 //BA.debugLineNum = 458754;BA.debugLine="Private xui As XUI";
_xui = new anywheresoftware.b4a.objects.B4XViewWrapper.XUI();
RDebugUtils.currentLine=458756;
 //BA.debugLineNum = 458756;BA.debugLine="Public Const splDefault As Int = -1";
_spldefault = (int) (-1);
RDebugUtils.currentLine=458757;
 //BA.debugLineNum = 458757;BA.debugLine="Public Const splLeft As Int = 0";
_splleft = (int) (0);
RDebugUtils.currentLine=458758;
 //BA.debugLineNum = 458758;BA.debugLine="Public Const splRight As Int = 1";
_splright = (int) (1);
RDebugUtils.currentLine=458759;
 //BA.debugLineNum = 458759;BA.debugLine="Public Const splTop As Int = 2";
_spltop = (int) (2);
RDebugUtils.currentLine=458760;
 //BA.debugLineNum = 458760;BA.debugLine="Public Const splBottom As Int = 3";
_splbottom = (int) (3);
RDebugUtils.currentLine=458762;
 //BA.debugLineNum = 458762;BA.debugLine="Public KVS As KeyValueStore";
_kvs = new hr.splitterexample.keyvaluestore();
RDebugUtils.currentLine=458764;
 //BA.debugLineNum = 458764;BA.debugLine="Private VerticalSplitter As cSplitter";
_verticalsplitter = new hr.splitterexample.csplitter();
RDebugUtils.currentLine=458765;
 //BA.debugLineNum = 458765;BA.debugLine="Private HorizontalSplitter As cSplitter";
_horizontalsplitter = new hr.splitterexample.csplitter();
RDebugUtils.currentLine=458766;
 //BA.debugLineNum = 458766;BA.debugLine="End Sub";
return "";
}
public String  _initialize(hr.splitterexample.b4xmainpage __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="b4xmainpage";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=524288;
 //BA.debugLineNum = 524288;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=524290;
 //BA.debugLineNum = 524290;BA.debugLine="xui.SetDataFolder(\"SplitterExample\")";
__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .SetDataFolder("SplitterExample");
RDebugUtils.currentLine=524291;
 //BA.debugLineNum = 524291;BA.debugLine="KVS.Initialize(xui.DefaultFolder, \"Options.kvs\")";
__ref._kvs /*hr.splitterexample.keyvaluestore*/ ._initialize /*String*/ (null,ba,__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .getDefaultFolder(),"Options.kvs");
RDebugUtils.currentLine=524292;
 //BA.debugLineNum = 524292;BA.debugLine="End Sub";
return "";
}
}