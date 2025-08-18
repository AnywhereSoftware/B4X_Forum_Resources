package hr.splitterexample;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class csplitter extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("hr.splitterexample", "hr.splitterexample.csplitter", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", hr.splitterexample.csplitter.class).invoke(this, new Object[] {null});
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
public anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public int _spldefault = 0;
public int _splleft = 0;
public int _splright = 0;
public int _spltop = 0;
public int _splbottom = 0;
public String _optkey = "";
public int _fsplittertype = 0;
public int _fminfixedsize = 0;
public int _fminflexsize = 0;
public boolean _sizing = false;
public anywheresoftware.b4a.objects.B4XViewWrapper _parent = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _panbase = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _fixedpanel = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _flexpanel = null;
public anywheresoftware.b4a.objects.B4XViewWrapper _sizer = null;
public hr.splitterexample.main _main = null;
public hr.splitterexample.b4xpages _b4xpages = null;
public hr.splitterexample.b4xcollections _b4xcollections = null;
public String  _initialize(hr.splitterexample.csplitter __ref,anywheresoftware.b4a.BA _ba,anywheresoftware.b4a.objects.B4XViewWrapper _aparent,int _splittertype,String _key) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba,_aparent,_splittertype,_key}));}
RDebugUtils.currentLine=786432;
 //BA.debugLineNum = 786432;BA.debugLine="Public Sub Initialize(AParent As B4XView, Splitter";
RDebugUtils.currentLine=786433;
 //BA.debugLineNum = 786433;BA.debugLine="Parent = AParent";
__ref._parent /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = _aparent;
RDebugUtils.currentLine=786434;
 //BA.debugLineNum = 786434;BA.debugLine="OptKey = Key";
__ref._optkey /*String*/  = _key;
RDebugUtils.currentLine=786435;
 //BA.debugLineNum = 786435;BA.debugLine="Parent.LoadLayout(\"StretchPanel\")";
__ref._parent /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .LoadLayout("StretchPanel",ba);
RDebugUtils.currentLine=786436;
 //BA.debugLineNum = 786436;BA.debugLine="panBase.LoadLayout(\"Splitter\")";
__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .LoadLayout("Splitter",ba);
RDebugUtils.currentLine=786437;
 //BA.debugLineNum = 786437;BA.debugLine="setSplitterType(IIf(SplitterType = splDefault, sp";
__ref._setsplittertype /*String*/ (null,(int)(BA.ObjectToNumber(((_splittertype==__ref._spldefault /*int*/ ) ? ((Object)(__ref._splleft /*int*/ )) : ((Object)(_splittertype))))));
RDebugUtils.currentLine=786438;
 //BA.debugLineNum = 786438;BA.debugLine="RestorePos";
__ref._restorepos /*String*/ (null);
RDebugUtils.currentLine=786439;
 //BA.debugLineNum = 786439;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(hr.splitterexample.csplitter __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
RDebugUtils.currentLine=720896;
 //BA.debugLineNum = 720896;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=720897;
 //BA.debugLineNum = 720897;BA.debugLine="Private fx As JFX";
_fx = new anywheresoftware.b4j.objects.JFX();
RDebugUtils.currentLine=720898;
 //BA.debugLineNum = 720898;BA.debugLine="Private xui As XUI";
_xui = new anywheresoftware.b4a.objects.B4XViewWrapper.XUI();
RDebugUtils.currentLine=720900;
 //BA.debugLineNum = 720900;BA.debugLine="Public Const splDefault As Int = -1";
_spldefault = (int) (-1);
RDebugUtils.currentLine=720901;
 //BA.debugLineNum = 720901;BA.debugLine="Public Const splLeft As Int = 0";
_splleft = (int) (0);
RDebugUtils.currentLine=720902;
 //BA.debugLineNum = 720902;BA.debugLine="Public Const splRight As Int = 1";
_splright = (int) (1);
RDebugUtils.currentLine=720903;
 //BA.debugLineNum = 720903;BA.debugLine="Public Const splTop As Int = 2";
_spltop = (int) (2);
RDebugUtils.currentLine=720904;
 //BA.debugLineNum = 720904;BA.debugLine="Public Const splBottom As Int = 3";
_splbottom = (int) (3);
RDebugUtils.currentLine=720906;
 //BA.debugLineNum = 720906;BA.debugLine="Private OptKey As String = \"\"";
_optkey = "";
RDebugUtils.currentLine=720907;
 //BA.debugLineNum = 720907;BA.debugLine="Private FSplitterType As Int = splDefault";
_fsplittertype = __ref._spldefault /*int*/ ;
RDebugUtils.currentLine=720908;
 //BA.debugLineNum = 720908;BA.debugLine="Private FMinFixedSize As Int = 30";
_fminfixedsize = (int) (30);
RDebugUtils.currentLine=720909;
 //BA.debugLineNum = 720909;BA.debugLine="Private FMinFlexSize As Int = 30";
_fminflexsize = (int) (30);
RDebugUtils.currentLine=720910;
 //BA.debugLineNum = 720910;BA.debugLine="Private Sizing As Boolean = False";
_sizing = __c.False;
RDebugUtils.currentLine=720912;
 //BA.debugLineNum = 720912;BA.debugLine="Private Parent As B4XView";
_parent = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=720913;
 //BA.debugLineNum = 720913;BA.debugLine="Private panBase As B4XView";
_panbase = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=720914;
 //BA.debugLineNum = 720914;BA.debugLine="Public FixedPanel As B4XView";
_fixedpanel = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=720915;
 //BA.debugLineNum = 720915;BA.debugLine="Public FlexPanel As B4XView";
_flexpanel = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=720916;
 //BA.debugLineNum = 720916;BA.debugLine="Public Sizer As B4XView";
_sizer = new anywheresoftware.b4a.objects.B4XViewWrapper();
RDebugUtils.currentLine=720917;
 //BA.debugLineNum = 720917;BA.debugLine="End Sub";
return "";
}
public int  _getminfixedsize(hr.splitterexample.csplitter __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "getminfixedsize", false))
	 {return ((Integer) Debug.delegate(ba, "getminfixedsize", null));}
RDebugUtils.currentLine=1048576;
 //BA.debugLineNum = 1048576;BA.debugLine="Public Sub getMinFixedSize As Int";
RDebugUtils.currentLine=1048577;
 //BA.debugLineNum = 1048577;BA.debugLine="Return FMinFixedSize";
if (true) return __ref._fminfixedsize /*int*/ ;
RDebugUtils.currentLine=1048578;
 //BA.debugLineNum = 1048578;BA.debugLine="End Sub";
return 0;
}
public int  _getminflexsize(hr.splitterexample.csplitter __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "getminflexsize", false))
	 {return ((Integer) Debug.delegate(ba, "getminflexsize", null));}
RDebugUtils.currentLine=1179648;
 //BA.debugLineNum = 1179648;BA.debugLine="Public Sub getMinFlexSize As Int";
RDebugUtils.currentLine=1179649;
 //BA.debugLineNum = 1179649;BA.debugLine="Return FMinFixedSize";
if (true) return __ref._fminfixedsize /*int*/ ;
RDebugUtils.currentLine=1179650;
 //BA.debugLineNum = 1179650;BA.debugLine="End Sub";
return 0;
}
public int  _getsplittertype(hr.splitterexample.csplitter __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "getsplittertype", false))
	 {return ((Integer) Debug.delegate(ba, "getsplittertype", null));}
RDebugUtils.currentLine=917504;
 //BA.debugLineNum = 917504;BA.debugLine="Public Sub getSplitterType As Int";
RDebugUtils.currentLine=917505;
 //BA.debugLineNum = 917505;BA.debugLine="Return FSplitterType";
if (true) return __ref._fsplittertype /*int*/ ;
RDebugUtils.currentLine=917506;
 //BA.debugLineNum = 917506;BA.debugLine="End Sub";
return 0;
}
public boolean  _horizontal(hr.splitterexample.csplitter __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "horizontal", false))
	 {return ((Boolean) Debug.delegate(ba, "horizontal", null));}
RDebugUtils.currentLine=1441792;
 //BA.debugLineNum = 1441792;BA.debugLine="Private Sub Horizontal As Boolean";
RDebugUtils.currentLine=1441793;
 //BA.debugLineNum = 1441793;BA.debugLine="Return HorizontalType(FSplitterType)";
if (true) return __ref._horizontaltype /*boolean*/ (null,__ref._fsplittertype /*int*/ );
RDebugUtils.currentLine=1441794;
 //BA.debugLineNum = 1441794;BA.debugLine="End Sub";
return false;
}
public boolean  _horizontaltype(hr.splitterexample.csplitter __ref,int _atype) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "horizontaltype", false))
	 {return ((Boolean) Debug.delegate(ba, "horizontaltype", new Object[] {_atype}));}
RDebugUtils.currentLine=1507328;
 //BA.debugLineNum = 1507328;BA.debugLine="Private Sub HorizontalType(AType As Int) As Boolea";
RDebugUtils.currentLine=1507329;
 //BA.debugLineNum = 1507329;BA.debugLine="If AType = splLeft Then Return True";
if (_atype==__ref._splleft /*int*/ ) { 
if (true) return __c.True;};
RDebugUtils.currentLine=1507330;
 //BA.debugLineNum = 1507330;BA.debugLine="If AType = splRight Then Return True";
if (_atype==__ref._splright /*int*/ ) { 
if (true) return __c.True;};
RDebugUtils.currentLine=1507331;
 //BA.debugLineNum = 1507331;BA.debugLine="If AType < 0 Then Return True";
if (_atype<0) { 
if (true) return __c.True;};
RDebugUtils.currentLine=1507332;
 //BA.debugLineNum = 1507332;BA.debugLine="Return False";
if (true) return __c.False;
RDebugUtils.currentLine=1507333;
 //BA.debugLineNum = 1507333;BA.debugLine="End Sub";
return false;
}
public String  _setsplittertype(hr.splitterexample.csplitter __ref,int _value) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "setsplittertype", false))
	 {return ((String) Debug.delegate(ba, "setsplittertype", new Object[] {_value}));}
int _oldtype = 0;
anywheresoftware.b4j.object.JavaObject _jocursors = null;
RDebugUtils.currentLine=983040;
 //BA.debugLineNum = 983040;BA.debugLine="Public Sub setSplitterType(Value As Int)";
RDebugUtils.currentLine=983041;
 //BA.debugLineNum = 983041;BA.debugLine="Dim OldType As Int = FSplitterType";
_oldtype = __ref._fsplittertype /*int*/ ;
RDebugUtils.currentLine=983042;
 //BA.debugLineNum = 983042;BA.debugLine="FSplitterType = Value";
__ref._fsplittertype /*int*/  = _value;
RDebugUtils.currentLine=983043;
 //BA.debugLineNum = 983043;BA.debugLine="Dim joCursors As JavaObject";
_jocursors = new anywheresoftware.b4j.object.JavaObject();
RDebugUtils.currentLine=983044;
 //BA.debugLineNum = 983044;BA.debugLine="joCursors.InitializeStatic(\"javafx.scene.Cursor\")";
_jocursors.InitializeStatic("javafx.scene.Cursor");
RDebugUtils.currentLine=983045;
 //BA.debugLineNum = 983045;BA.debugLine="Sizer.As(Pane).MouseCursor = joCursors.GetField(I";
((anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper(), (javafx.scene.layout.Pane)(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getObject()))).setMouseCursor((javafx.scene.Cursor)(_jocursors.GetField(BA.ObjectToString(((__ref._horizontal /*boolean*/ (null)) ? ((Object)("H_RESIZE")) : ((Object)("V_RESIZE")))))));
RDebugUtils.currentLine=983046;
 //BA.debugLineNum = 983046;BA.debugLine="If HorizontalType(OldType) <> Horizontal Then Res";
if (__ref._horizontaltype /*boolean*/ (null,_oldtype)!=__ref._horizontal /*boolean*/ (null)) { 
__ref._restructure /*String*/ (null);};
RDebugUtils.currentLine=983047;
 //BA.debugLineNum = 983047;BA.debugLine="Select FSplitterType";
switch (BA.switchObjectToInt(__ref._fsplittertype /*int*/ ,__ref._splleft /*int*/ ,__ref._splright /*int*/ ,__ref._spltop /*int*/ )) {
case 0: {
RDebugUtils.currentLine=983049;
 //BA.debugLineNum = 983049;BA.debugLine="FixedPanel.Left = 0";
__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setLeft(0);
RDebugUtils.currentLine=983050;
 //BA.debugLineNum = 983050;BA.debugLine="Sizer.Left = panBase.Width / 2";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setLeft(__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()/(double)2);
RDebugUtils.currentLine=983051;
 //BA.debugLineNum = 983051;BA.debugLine="FlexPanel.Left = Sizer.Left + Sizer.Width";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setLeft(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft()+__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth());
 break; }
case 1: {
RDebugUtils.currentLine=983053;
 //BA.debugLineNum = 983053;BA.debugLine="FlexPanel.Left = 0";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setLeft(0);
RDebugUtils.currentLine=983054;
 //BA.debugLineNum = 983054;BA.debugLine="Sizer.Left = panBase.Width / 2";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setLeft(__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()/(double)2);
RDebugUtils.currentLine=983055;
 //BA.debugLineNum = 983055;BA.debugLine="FixedPanel.Left = Sizer.Left + Sizer.Width";
__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setLeft(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft()+__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth());
 break; }
case 2: {
RDebugUtils.currentLine=983057;
 //BA.debugLineNum = 983057;BA.debugLine="FixedPanel.Top = 0";
__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop(0);
RDebugUtils.currentLine=983058;
 //BA.debugLineNum = 983058;BA.debugLine="Sizer.Top = panBase.Height / 2";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop(__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)2);
RDebugUtils.currentLine=983059;
 //BA.debugLineNum = 983059;BA.debugLine="FlexPanel.Top = Sizer.Top + Sizer.Height";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop()+__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight());
 break; }
default: {
RDebugUtils.currentLine=983061;
 //BA.debugLineNum = 983061;BA.debugLine="FlexPanel.Top = 0";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop(0);
RDebugUtils.currentLine=983062;
 //BA.debugLineNum = 983062;BA.debugLine="Sizer.Top = panBase.Height / 2";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop(__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()/(double)2);
RDebugUtils.currentLine=983063;
 //BA.debugLineNum = 983063;BA.debugLine="FixedPanel.Top = Sizer.Top + Sizer.Height";
__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop()+__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight());
 break; }
}
;
RDebugUtils.currentLine=983065;
 //BA.debugLineNum = 983065;BA.debugLine="panBase_Resize(panBase.Width, panBase.Height)";
__ref._panbase_resize /*String*/ (null,__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth(),__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight());
RDebugUtils.currentLine=983066;
 //BA.debugLineNum = 983066;BA.debugLine="End Sub";
return "";
}
public String  _restorepos(hr.splitterexample.csplitter __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "restorepos", false))
	 {return ((String) Debug.delegate(ba, "restorepos", null));}
RDebugUtils.currentLine=851968;
 //BA.debugLineNum = 851968;BA.debugLine="Public Sub RestorePos";
RDebugUtils.currentLine=851969;
 //BA.debugLineNum = 851969;BA.debugLine="setDiv(B4XPages.MainPage.KVS.GetDefault($\"${OptKe";
__ref._setdiv /*String*/ (null,(int)(BA.ObjectToNumber(_b4xpages._mainpage /*hr.splitterexample.b4xmainpage*/ ()._kvs /*hr.splitterexample.keyvaluestore*/ ._getdefault /*Object*/ (null,(""+__c.SmartStringFormatter("",(Object)(__ref._optkey /*String*/ ))+"Pos"),(Object)(250)))));
RDebugUtils.currentLine=851970;
 //BA.debugLineNum = 851970;BA.debugLine="End Sub";
return "";
}
public String  _panbase_resize(hr.splitterexample.csplitter __ref,double _width,double _height) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "panbase_resize", false))
	 {return ((String) Debug.delegate(ba, "panbase_resize", new Object[] {_width,_height}));}
RDebugUtils.currentLine=1835008;
 //BA.debugLineNum = 1835008;BA.debugLine="Private Sub panBase_Resize (Width As Double, Heigh";
RDebugUtils.currentLine=1835009;
 //BA.debugLineNum = 1835009;BA.debugLine="If Horizontal Then";
if (__ref._horizontal /*boolean*/ (null)) { 
RDebugUtils.currentLine=1835010;
 //BA.debugLineNum = 1835010;BA.debugLine="FixedPanel.Height = Height";
__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(_height);
RDebugUtils.currentLine=1835011;
 //BA.debugLineNum = 1835011;BA.debugLine="Sizer.Height = Height";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(_height);
RDebugUtils.currentLine=1835012;
 //BA.debugLineNum = 1835012;BA.debugLine="FlexPanel.Height = Height";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(_height);
 }else {
RDebugUtils.currentLine=1835014;
 //BA.debugLineNum = 1835014;BA.debugLine="FixedPanel.Width = Width";
__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setWidth(_width);
RDebugUtils.currentLine=1835015;
 //BA.debugLineNum = 1835015;BA.debugLine="Sizer.Width = Width";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setWidth(_width);
RDebugUtils.currentLine=1835016;
 //BA.debugLineNum = 1835016;BA.debugLine="FlexPanel.Width = Width";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setWidth(_width);
 };
RDebugUtils.currentLine=1835018;
 //BA.debugLineNum = 1835018;BA.debugLine="Select FSplitterType";
switch (BA.switchObjectToInt(__ref._fsplittertype /*int*/ ,__ref._splleft /*int*/ ,__ref._splright /*int*/ ,__ref._spltop /*int*/ )) {
case 0: {
RDebugUtils.currentLine=1835020;
 //BA.debugLineNum = 1835020;BA.debugLine="FlexPanel.Width = Max(Width - FlexPanel.Left, F";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setWidth(__c.Max(_width-__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft(),__ref._fminflexsize /*int*/ ));
 break; }
case 1: {
RDebugUtils.currentLine=1835022;
 //BA.debugLineNum = 1835022;BA.debugLine="FlexPanel.Width = Max(Width - Sizer.Left, FMinF";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setWidth(__c.Max(_width-__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft(),__ref._fminflexsize /*int*/ ));
 break; }
case 2: {
RDebugUtils.currentLine=1835024;
 //BA.debugLineNum = 1835024;BA.debugLine="FlexPanel.Height = Max(Height - FlexPanel.Top,";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(__c.Max(_height-__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop(),__ref._fminflexsize /*int*/ ));
 break; }
default: {
RDebugUtils.currentLine=1835026;
 //BA.debugLineNum = 1835026;BA.debugLine="FlexPanel.Height = Max(Height - Sizer.Top, FMin";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(__c.Max(_height-__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop(),__ref._fminflexsize /*int*/ ));
 break; }
}
;
RDebugUtils.currentLine=1835028;
 //BA.debugLineNum = 1835028;BA.debugLine="End Sub";
return "";
}
public String  _setdiv(hr.splitterexample.csplitter __ref,int _pos) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "setdiv", false))
	 {return ((String) Debug.delegate(ba, "setdiv", new Object[] {_pos}));}
RDebugUtils.currentLine=1310720;
 //BA.debugLineNum = 1310720;BA.debugLine="Public Sub setDiv(Pos As Int)";
RDebugUtils.currentLine=1310721;
 //BA.debugLineNum = 1310721;BA.debugLine="SetSizer(Pos - Sizer.Left, Pos - Sizer.Top)";
__ref._setsizer /*String*/ (null,(int) (_pos-__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft()),(int) (_pos-__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop()));
RDebugUtils.currentLine=1310722;
 //BA.debugLineNum = 1310722;BA.debugLine="End Sub";
return "";
}
public String  _restructure(hr.splitterexample.csplitter __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "restructure", false))
	 {return ((String) Debug.delegate(ba, "restructure", null));}
RDebugUtils.currentLine=1572864;
 //BA.debugLineNum = 1572864;BA.debugLine="Public Sub Restructure";
RDebugUtils.currentLine=1572865;
 //BA.debugLineNum = 1572865;BA.debugLine="If Horizontal Then";
if (__ref._horizontal /*boolean*/ (null)) { 
RDebugUtils.currentLine=1572866;
 //BA.debugLineNum = 1572866;BA.debugLine="FixedPanel.Top = 0";
__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop(0);
RDebugUtils.currentLine=1572867;
 //BA.debugLineNum = 1572867;BA.debugLine="FixedPanel.Height = panBase.Height";
__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight());
RDebugUtils.currentLine=1572868;
 //BA.debugLineNum = 1572868;BA.debugLine="Sizer.Top = 0";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop(0);
RDebugUtils.currentLine=1572869;
 //BA.debugLineNum = 1572869;BA.debugLine="Sizer.Width = Sizer.Height";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setWidth(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight());
RDebugUtils.currentLine=1572870;
 //BA.debugLineNum = 1572870;BA.debugLine="Sizer.Height = panBase.Height";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight());
RDebugUtils.currentLine=1572871;
 //BA.debugLineNum = 1572871;BA.debugLine="FlexPanel.Top = 0";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop(0);
RDebugUtils.currentLine=1572872;
 //BA.debugLineNum = 1572872;BA.debugLine="FlexPanel.Height = panBase.Height";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight());
 }else {
RDebugUtils.currentLine=1572874;
 //BA.debugLineNum = 1572874;BA.debugLine="FixedPanel.Left = 0";
__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setLeft(0);
RDebugUtils.currentLine=1572875;
 //BA.debugLineNum = 1572875;BA.debugLine="FixedPanel.Width = panBase.Width";
__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setWidth(__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth());
RDebugUtils.currentLine=1572876;
 //BA.debugLineNum = 1572876;BA.debugLine="Sizer.Left = 0";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setLeft(0);
RDebugUtils.currentLine=1572877;
 //BA.debugLineNum = 1572877;BA.debugLine="Sizer.Height = Sizer.Width";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth());
RDebugUtils.currentLine=1572878;
 //BA.debugLineNum = 1572878;BA.debugLine="Sizer.Width = panBase.width";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setWidth(__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth());
RDebugUtils.currentLine=1572879;
 //BA.debugLineNum = 1572879;BA.debugLine="FlexPanel.Left = 0";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setLeft(0);
RDebugUtils.currentLine=1572880;
 //BA.debugLineNum = 1572880;BA.debugLine="FlexPanel.Width = panBase.Width";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setWidth(__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth());
 };
RDebugUtils.currentLine=1572882;
 //BA.debugLineNum = 1572882;BA.debugLine="End Sub";
return "";
}
public String  _setsizer(hr.splitterexample.csplitter __ref,int _x,int _y) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "setsizer", false))
	 {return ((String) Debug.delegate(ba, "setsizer", new Object[] {_x,_y}));}
RDebugUtils.currentLine=1703936;
 //BA.debugLineNum = 1703936;BA.debugLine="Private Sub SetSizer(X As Int, Y As Int)";
RDebugUtils.currentLine=1703937;
 //BA.debugLineNum = 1703937;BA.debugLine="Select FSplitterType";
switch (BA.switchObjectToInt(__ref._fsplittertype /*int*/ ,__ref._splleft /*int*/ ,__ref._splright /*int*/ ,__ref._spltop /*int*/ )) {
case 0: {
RDebugUtils.currentLine=1703939;
 //BA.debugLineNum = 1703939;BA.debugLine="Sizer.Left = Max(Min(Sizer.Left + X, panBase.Wi";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setLeft(__c.Max(__c.Min(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft()+_x,__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()-__ref._fminflexsize /*int*/ ),__ref._fminfixedsize /*int*/ ));
RDebugUtils.currentLine=1703940;
 //BA.debugLineNum = 1703940;BA.debugLine="FlexPanel.Left = Sizer.Left + Sizer.Width";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setLeft(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft()+__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth());
RDebugUtils.currentLine=1703941;
 //BA.debugLineNum = 1703941;BA.debugLine="FlexPanel.Width = Max(FlexPanel.Parent.Width -";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setWidth(__c.Max(__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getParent().getWidth()-__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft(),__ref._fminflexsize /*int*/ ));
RDebugUtils.currentLine=1703942;
 //BA.debugLineNum = 1703942;BA.debugLine="FixedPanel.Width = Max(Sizer.Left - FixedPanel.";
__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setWidth(__c.Max(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft()-__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft(),__ref._fminfixedsize /*int*/ ));
 break; }
case 1: {
RDebugUtils.currentLine=1703944;
 //BA.debugLineNum = 1703944;BA.debugLine="Sizer.Left = Max(Min(Sizer.Left + X, panBase.Wi";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setLeft(__c.Max(__c.Min(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft()+_x,__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()-__ref._fminflexsize /*int*/ ),__ref._fminfixedsize /*int*/ ));
RDebugUtils.currentLine=1703945;
 //BA.debugLineNum = 1703945;BA.debugLine="FlexPanel.Left = Sizer.Left + Sizer.Width";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setLeft(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft()+__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth());
RDebugUtils.currentLine=1703946;
 //BA.debugLineNum = 1703946;BA.debugLine="FlexPanel.Width = FlexPanel.Parent.Width - Flex";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setWidth(__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getParent().getWidth()-__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft());
RDebugUtils.currentLine=1703947;
 //BA.debugLineNum = 1703947;BA.debugLine="FixedPanel.Width = Sizer.Left - FixedPanel.Left";
__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setWidth(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft()-__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft());
 break; }
case 2: {
RDebugUtils.currentLine=1703949;
 //BA.debugLineNum = 1703949;BA.debugLine="Sizer.Top = Max(Min(Sizer.Top + Y, panBase.Heig";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop(__c.Max(__c.Min(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop()+_y,__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()-__ref._fminflexsize /*int*/ ),__ref._fminfixedsize /*int*/ ));
RDebugUtils.currentLine=1703950;
 //BA.debugLineNum = 1703950;BA.debugLine="FlexPanel.Top = Sizer.Top + Sizer.Height";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop()+__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight());
RDebugUtils.currentLine=1703951;
 //BA.debugLineNum = 1703951;BA.debugLine="FlexPanel.Height = FlexPanel.Parent.Height - Fl";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getParent().getHeight()-__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop());
RDebugUtils.currentLine=1703952;
 //BA.debugLineNum = 1703952;BA.debugLine="FixedPanel.Height = Sizer.Top - FixedPanel.Top";
__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop()-__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop());
 break; }
default: {
RDebugUtils.currentLine=1703954;
 //BA.debugLineNum = 1703954;BA.debugLine="Sizer.Top = Max(Min(Sizer.Top + Y, panBase.Heig";
__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop(__c.Max(__c.Min(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop()+_y,__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()-__ref._fminflexsize /*int*/ ),__ref._fminfixedsize /*int*/ ));
RDebugUtils.currentLine=1703955;
 //BA.debugLineNum = 1703955;BA.debugLine="FlexPanel.Top = Sizer.Top + Sizer.Height";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setTop(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop()+__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight());
RDebugUtils.currentLine=1703956;
 //BA.debugLineNum = 1703956;BA.debugLine="FlexPanel.Height = FlexPanel.Parent.Height - Fl";
__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getParent().getHeight()-__ref._flexpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight());
RDebugUtils.currentLine=1703957;
 //BA.debugLineNum = 1703957;BA.debugLine="FixedPanel.Height = Sizer.Top - FixedPanel.Top";
__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .setHeight(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop()-__ref._fixedpanel /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop());
 break; }
}
;
RDebugUtils.currentLine=1703959;
 //BA.debugLineNum = 1703959;BA.debugLine="End Sub";
return "";
}
public String  _setdivpercent(hr.splitterexample.csplitter __ref,int _pos) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "setdivpercent", false))
	 {return ((String) Debug.delegate(ba, "setdivpercent", new Object[] {_pos}));}
RDebugUtils.currentLine=1376256;
 //BA.debugLineNum = 1376256;BA.debugLine="Public Sub SetDivPerCent(pos As Int)";
RDebugUtils.currentLine=1376257;
 //BA.debugLineNum = 1376257;BA.debugLine="Select FSplitterType";
switch (BA.switchObjectToInt(__ref._fsplittertype /*int*/ ,__ref._splleft /*int*/ ,__ref._splright /*int*/ )) {
case 0: 
case 1: {
RDebugUtils.currentLine=1376259;
 //BA.debugLineNum = 1376259;BA.debugLine="setDiv(pos * 100 / panBase.Width)";
__ref._setdiv /*String*/ (null,(int) (_pos*100/(double)__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getWidth()));
 break; }
default: {
RDebugUtils.currentLine=1376261;
 //BA.debugLineNum = 1376261;BA.debugLine="setDiv(pos * 100 / panBase.Height)";
__ref._setdiv /*String*/ (null,(int) (_pos*100/(double)__ref._panbase /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getHeight()));
 break; }
}
;
RDebugUtils.currentLine=1376263;
 //BA.debugLineNum = 1376263;BA.debugLine="End Sub";
return "";
}
public String  _setminfixedsize(hr.splitterexample.csplitter __ref,int _size) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "setminfixedsize", false))
	 {return ((String) Debug.delegate(ba, "setminfixedsize", new Object[] {_size}));}
RDebugUtils.currentLine=1114112;
 //BA.debugLineNum = 1114112;BA.debugLine="Public Sub setMinFixedSize(Size As Int)";
RDebugUtils.currentLine=1114113;
 //BA.debugLineNum = 1114113;BA.debugLine="FMinFixedSize = Size";
__ref._fminfixedsize /*int*/  = _size;
RDebugUtils.currentLine=1114114;
 //BA.debugLineNum = 1114114;BA.debugLine="End Sub";
return "";
}
public String  _setminflexsize(hr.splitterexample.csplitter __ref,int _size) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "setminflexsize", false))
	 {return ((String) Debug.delegate(ba, "setminflexsize", new Object[] {_size}));}
RDebugUtils.currentLine=1245184;
 //BA.debugLineNum = 1245184;BA.debugLine="Public Sub setMinFlexSize(Size As Int)";
RDebugUtils.currentLine=1245185;
 //BA.debugLineNum = 1245185;BA.debugLine="FMinFixedSize = Size";
__ref._fminfixedsize /*int*/  = _size;
RDebugUtils.currentLine=1245186;
 //BA.debugLineNum = 1245186;BA.debugLine="End Sub";
return "";
}
public void  _sizer_mousepressed(hr.splitterexample.csplitter __ref,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "sizer_mousepressed", false))
	 {Debug.delegate(ba, "sizer_mousepressed", new Object[] {_eventdata}); return;}
ResumableSub_Sizer_MousePressed rsub = new ResumableSub_Sizer_MousePressed(this,__ref,_eventdata);
rsub.resume(ba, null);
}
public static class ResumableSub_Sizer_MousePressed extends BA.ResumableSub {
public ResumableSub_Sizer_MousePressed(hr.splitterexample.csplitter parent,hr.splitterexample.csplitter __ref,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) {
this.parent = parent;
this.__ref = __ref;
this._eventdata = _eventdata;
this.__ref = parent;
}
hr.splitterexample.csplitter __ref;
hr.splitterexample.csplitter parent;
anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata;
double _startx = 0;
double _starty = 0;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="csplitter";

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
RDebugUtils.currentLine=1638401;
 //BA.debugLineNum = 1638401;BA.debugLine="If EventData.ClickCount > 1 Then Return";
if (true) break;

case 1:
//if
this.state = 6;
if (_eventdata.getClickCount()>1) { 
this.state = 3;
;}if (true) break;

case 3:
//C
this.state = 6;
if (true) return ;
if (true) break;

case 6:
//C
this.state = 7;
;
RDebugUtils.currentLine=1638402;
 //BA.debugLineNum = 1638402;BA.debugLine="Sizing = True";
__ref._sizing /*boolean*/  = parent.__c.True;
RDebugUtils.currentLine=1638403;
 //BA.debugLineNum = 1638403;BA.debugLine="Dim StartX As Double = EventData.X";
_startx = _eventdata.getX();
RDebugUtils.currentLine=1638404;
 //BA.debugLineNum = 1638404;BA.debugLine="Dim StartY As Double = EventData.Y";
_starty = _eventdata.getY();
RDebugUtils.currentLine=1638405;
 //BA.debugLineNum = 1638405;BA.debugLine="Do While Sizing";
if (true) break;

case 7:
//do while
this.state = 10;
while (__ref._sizing /*boolean*/ ) {
this.state = 9;
if (true) break;
}
if (true) break;

case 9:
//C
this.state = 7;
RDebugUtils.currentLine=1638406;
 //BA.debugLineNum = 1638406;BA.debugLine="Wait For(Sizer) Sizer_MouseDragged(EventData As";
parent.__c.WaitFor("sizer_mousedragged", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "csplitter", "sizer_mousepressed"), (Object)(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getObject()));
this.state = 11;
return;
case 11:
//C
this.state = 7;
_eventdata = (anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper) result[1];
;
RDebugUtils.currentLine=1638407;
 //BA.debugLineNum = 1638407;BA.debugLine="SetSizer(EventData.X - StartX, EventData.Y - Sta";
__ref._setsizer /*String*/ (null,(int) (_eventdata.getX()-_startx),(int) (_eventdata.getY()-_starty));
 if (true) break;

case 10:
//C
this.state = -1;
;
RDebugUtils.currentLine=1638409;
 //BA.debugLineNum = 1638409;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public String  _sizer_mousereleased(hr.splitterexample.csplitter __ref,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
__ref = this;
RDebugUtils.currentModule="csplitter";
if (Debug.shouldDelegate(ba, "sizer_mousereleased", false))
	 {return ((String) Debug.delegate(ba, "sizer_mousereleased", new Object[] {_eventdata}));}
RDebugUtils.currentLine=1769472;
 //BA.debugLineNum = 1769472;BA.debugLine="Private Sub Sizer_MouseReleased (EventData As Mous";
RDebugUtils.currentLine=1769473;
 //BA.debugLineNum = 1769473;BA.debugLine="Sizing = False";
__ref._sizing /*boolean*/  = __c.False;
RDebugUtils.currentLine=1769474;
 //BA.debugLineNum = 1769474;BA.debugLine="B4XPages.MainPage.KVS.Put($\"${OptKey}Pos\"$, IIf(H";
_b4xpages._mainpage /*hr.splitterexample.b4xmainpage*/ ()._kvs /*hr.splitterexample.keyvaluestore*/ ._put /*String*/ (null,(""+__c.SmartStringFormatter("",(Object)(__ref._optkey /*String*/ ))+"Pos"),((__ref._horizontal /*boolean*/ (null)) ? ((Object)(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getLeft())) : ((Object)(__ref._sizer /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getTop()))));
RDebugUtils.currentLine=1769475;
 //BA.debugLineNum = 1769475;BA.debugLine="End Sub";
return "";
}
}