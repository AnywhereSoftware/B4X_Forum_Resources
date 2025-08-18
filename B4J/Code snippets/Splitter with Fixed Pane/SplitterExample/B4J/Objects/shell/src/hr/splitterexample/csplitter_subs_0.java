package hr.splitterexample;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class csplitter_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 1;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 2;BA.debugLine="Private fx As JFX";
csplitter._fx = RemoteObject.createNew ("anywheresoftware.b4j.objects.JFX");__ref.setField("_fx",csplitter._fx);
 //BA.debugLineNum = 3;BA.debugLine="Private xui As XUI";
csplitter._xui = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");__ref.setField("_xui",csplitter._xui);
 //BA.debugLineNum = 5;BA.debugLine="Public Const splDefault As Int = -1";
csplitter._spldefault = BA.numberCast(int.class, -(double) (0 + 1));__ref.setField("_spldefault",csplitter._spldefault);
 //BA.debugLineNum = 6;BA.debugLine="Public Const splLeft As Int = 0";
csplitter._splleft = BA.numberCast(int.class, 0);__ref.setField("_splleft",csplitter._splleft);
 //BA.debugLineNum = 7;BA.debugLine="Public Const splRight As Int = 1";
csplitter._splright = BA.numberCast(int.class, 1);__ref.setField("_splright",csplitter._splright);
 //BA.debugLineNum = 8;BA.debugLine="Public Const splTop As Int = 2";
csplitter._spltop = BA.numberCast(int.class, 2);__ref.setField("_spltop",csplitter._spltop);
 //BA.debugLineNum = 9;BA.debugLine="Public Const splBottom As Int = 3";
csplitter._splbottom = BA.numberCast(int.class, 3);__ref.setField("_splbottom",csplitter._splbottom);
 //BA.debugLineNum = 11;BA.debugLine="Private OptKey As String = \"\"";
csplitter._optkey = BA.ObjectToString("");__ref.setField("_optkey",csplitter._optkey);
 //BA.debugLineNum = 12;BA.debugLine="Private FSplitterType As Int = splDefault";
csplitter._fsplittertype = __ref.getField(true,"_spldefault" /*RemoteObject*/ );__ref.setField("_fsplittertype",csplitter._fsplittertype);
 //BA.debugLineNum = 13;BA.debugLine="Private FMinFixedSize As Int = 30";
csplitter._fminfixedsize = BA.numberCast(int.class, 30);__ref.setField("_fminfixedsize",csplitter._fminfixedsize);
 //BA.debugLineNum = 14;BA.debugLine="Private FMinFlexSize As Int = 30";
csplitter._fminflexsize = BA.numberCast(int.class, 30);__ref.setField("_fminflexsize",csplitter._fminflexsize);
 //BA.debugLineNum = 15;BA.debugLine="Private Sizing As Boolean = False";
csplitter._sizing = csplitter.__c.getField(true,"False");__ref.setField("_sizing",csplitter._sizing);
 //BA.debugLineNum = 17;BA.debugLine="Private Parent As B4XView";
csplitter._parent = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_parent",csplitter._parent);
 //BA.debugLineNum = 18;BA.debugLine="Private panBase As B4XView";
csplitter._panbase = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_panbase",csplitter._panbase);
 //BA.debugLineNum = 19;BA.debugLine="Public FixedPanel As B4XView";
csplitter._fixedpanel = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_fixedpanel",csplitter._fixedpanel);
 //BA.debugLineNum = 20;BA.debugLine="Public FlexPanel As B4XView";
csplitter._flexpanel = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_flexpanel",csplitter._flexpanel);
 //BA.debugLineNum = 21;BA.debugLine="Public Sizer As B4XView";
csplitter._sizer = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper");__ref.setField("_sizer",csplitter._sizer);
 //BA.debugLineNum = 22;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _getminfixedsize(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getMinFixedSize (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,74);
if (RapidSub.canDelegate("getminfixedsize")) { return __ref.runUserSub(false, "csplitter","getminfixedsize", __ref);}
 BA.debugLineNum = 74;BA.debugLine="Public Sub getMinFixedSize As Int";
Debug.ShouldStop(512);
 BA.debugLineNum = 75;BA.debugLine="Return FMinFixedSize";
Debug.ShouldStop(1024);
if (true) return __ref.getField(true,"_fminfixedsize" /*RemoteObject*/ );
 BA.debugLineNum = 76;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getminflexsize(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getMinFlexSize (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,82);
if (RapidSub.canDelegate("getminflexsize")) { return __ref.runUserSub(false, "csplitter","getminflexsize", __ref);}
 BA.debugLineNum = 82;BA.debugLine="Public Sub getMinFlexSize As Int";
Debug.ShouldStop(131072);
 BA.debugLineNum = 83;BA.debugLine="Return FMinFixedSize";
Debug.ShouldStop(262144);
if (true) return __ref.getField(true,"_fminfixedsize" /*RemoteObject*/ );
 BA.debugLineNum = 84;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getsplittertype(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getSplitterType (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,41);
if (RapidSub.canDelegate("getsplittertype")) { return __ref.runUserSub(false, "csplitter","getsplittertype", __ref);}
 BA.debugLineNum = 41;BA.debugLine="Public Sub getSplitterType As Int";
Debug.ShouldStop(256);
 BA.debugLineNum = 42;BA.debugLine="Return FSplitterType";
Debug.ShouldStop(512);
if (true) return __ref.getField(true,"_fsplittertype" /*RemoteObject*/ );
 BA.debugLineNum = 43;BA.debugLine="End Sub";
Debug.ShouldStop(1024);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _horizontal(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Horizontal (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,103);
if (RapidSub.canDelegate("horizontal")) { return __ref.runUserSub(false, "csplitter","horizontal", __ref);}
 BA.debugLineNum = 103;BA.debugLine="Private Sub Horizontal As Boolean";
Debug.ShouldStop(64);
 BA.debugLineNum = 104;BA.debugLine="Return HorizontalType(FSplitterType)";
Debug.ShouldStop(128);
if (true) return __ref.runClassMethod (hr.splitterexample.csplitter.class, "_horizontaltype" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_fsplittertype" /*RemoteObject*/ )));
 BA.debugLineNum = 105;BA.debugLine="End Sub";
Debug.ShouldStop(256);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _horizontaltype(RemoteObject __ref,RemoteObject _atype) throws Exception{
try {
		Debug.PushSubsStack("HorizontalType (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,107);
if (RapidSub.canDelegate("horizontaltype")) { return __ref.runUserSub(false, "csplitter","horizontaltype", __ref, _atype);}
Debug.locals.put("AType", _atype);
 BA.debugLineNum = 107;BA.debugLine="Private Sub HorizontalType(AType As Int) As Boolea";
Debug.ShouldStop(1024);
 BA.debugLineNum = 108;BA.debugLine="If AType = splLeft Then Return True";
Debug.ShouldStop(2048);
if (RemoteObject.solveBoolean("=",_atype,BA.numberCast(double.class, __ref.getField(true,"_splleft" /*RemoteObject*/ )))) { 
if (true) return csplitter.__c.getField(true,"True");};
 BA.debugLineNum = 109;BA.debugLine="If AType = splRight Then Return True";
Debug.ShouldStop(4096);
if (RemoteObject.solveBoolean("=",_atype,BA.numberCast(double.class, __ref.getField(true,"_splright" /*RemoteObject*/ )))) { 
if (true) return csplitter.__c.getField(true,"True");};
 BA.debugLineNum = 110;BA.debugLine="If AType < 0 Then Return True";
Debug.ShouldStop(8192);
if (RemoteObject.solveBoolean("<",_atype,BA.numberCast(double.class, 0))) { 
if (true) return csplitter.__c.getField(true,"True");};
 BA.debugLineNum = 111;BA.debugLine="Return False";
Debug.ShouldStop(16384);
if (true) return csplitter.__c.getField(true,"False");
 BA.debugLineNum = 112;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _aparent,RemoteObject _splittertype,RemoteObject _key) throws Exception{
try {
		Debug.PushSubsStack("Initialize (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,25);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "csplitter","initialize", __ref, _ba, _aparent, _splittertype, _key);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
Debug.locals.put("AParent", _aparent);
Debug.locals.put("SplitterType", _splittertype);
Debug.locals.put("Key", _key);
 BA.debugLineNum = 25;BA.debugLine="Public Sub Initialize(AParent As B4XView, Splitter";
Debug.ShouldStop(16777216);
 BA.debugLineNum = 26;BA.debugLine="Parent = AParent";
Debug.ShouldStop(33554432);
__ref.setField ("_parent" /*RemoteObject*/ ,_aparent);
 BA.debugLineNum = 27;BA.debugLine="OptKey = Key";
Debug.ShouldStop(67108864);
__ref.setField ("_optkey" /*RemoteObject*/ ,_key);
 BA.debugLineNum = 28;BA.debugLine="Parent.LoadLayout(\"StretchPanel\")";
Debug.ShouldStop(134217728);
__ref.getField(false,"_parent" /*RemoteObject*/ ).runVoidMethodAndSync ("LoadLayout",(Object)(RemoteObject.createImmutable("StretchPanel")),__ref.getField(false, "ba"));
 BA.debugLineNum = 29;BA.debugLine="panBase.LoadLayout(\"Splitter\")";
Debug.ShouldStop(268435456);
__ref.getField(false,"_panbase" /*RemoteObject*/ ).runVoidMethodAndSync ("LoadLayout",(Object)(RemoteObject.createImmutable("Splitter")),__ref.getField(false, "ba"));
 BA.debugLineNum = 30;BA.debugLine="setSplitterType(IIf(SplitterType = splDefault, sp";
Debug.ShouldStop(536870912);
__ref.runClassMethod (hr.splitterexample.csplitter.class, "_setsplittertype" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, ((RemoteObject.solveBoolean("=",_splittertype,BA.numberCast(double.class, __ref.getField(true,"_spldefault" /*RemoteObject*/ )))) ? ((__ref.getField(true,"_splleft" /*RemoteObject*/ ))) : ((_splittertype))))));
 BA.debugLineNum = 31;BA.debugLine="RestorePos";
Debug.ShouldStop(1073741824);
__ref.runClassMethod (hr.splitterexample.csplitter.class, "_restorepos" /*RemoteObject*/ );
 BA.debugLineNum = 32;BA.debugLine="End Sub";
Debug.ShouldStop(-2147483648);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _panbase_resize(RemoteObject __ref,RemoteObject _width,RemoteObject _height) throws Exception{
try {
		Debug.PushSubsStack("panBase_Resize (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,179);
if (RapidSub.canDelegate("panbase_resize")) { return __ref.runUserSub(false, "csplitter","panbase_resize", __ref, _width, _height);}
Debug.locals.put("Width", _width);
Debug.locals.put("Height", _height);
 BA.debugLineNum = 179;BA.debugLine="Private Sub panBase_Resize (Width As Double, Heigh";
Debug.ShouldStop(262144);
 BA.debugLineNum = 180;BA.debugLine="If Horizontal Then";
Debug.ShouldStop(524288);
if (__ref.runClassMethod (hr.splitterexample.csplitter.class, "_horizontal" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 181;BA.debugLine="FixedPanel.Height = Height";
Debug.ShouldStop(1048576);
__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"setHeight",_height);
 BA.debugLineNum = 182;BA.debugLine="Sizer.Height = Height";
Debug.ShouldStop(2097152);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setHeight",_height);
 BA.debugLineNum = 183;BA.debugLine="FlexPanel.Height = Height";
Debug.ShouldStop(4194304);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setHeight",_height);
 }else {
 BA.debugLineNum = 185;BA.debugLine="FixedPanel.Width = Width";
Debug.ShouldStop(16777216);
__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"setWidth",_width);
 BA.debugLineNum = 186;BA.debugLine="Sizer.Width = Width";
Debug.ShouldStop(33554432);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setWidth",_width);
 BA.debugLineNum = 187;BA.debugLine="FlexPanel.Width = Width";
Debug.ShouldStop(67108864);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setWidth",_width);
 };
 BA.debugLineNum = 189;BA.debugLine="Select FSplitterType";
Debug.ShouldStop(268435456);
switch (BA.switchObjectToInt(__ref.getField(true,"_fsplittertype" /*RemoteObject*/ ),__ref.getField(true,"_splleft" /*RemoteObject*/ ),__ref.getField(true,"_splright" /*RemoteObject*/ ),__ref.getField(true,"_spltop" /*RemoteObject*/ ))) {
case 0: {
 BA.debugLineNum = 191;BA.debugLine="FlexPanel.Width = Max(Width - FlexPanel.Left, F";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setWidth",csplitter.__c.runMethod(true,"Max",(Object)(RemoteObject.solve(new RemoteObject[] {_width,__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"getLeft")}, "-",1, 0)),(Object)(BA.numberCast(double.class, __ref.getField(true,"_fminflexsize" /*RemoteObject*/ )))));
 break; }
case 1: {
 BA.debugLineNum = 193;BA.debugLine="FlexPanel.Width = Max(Width - Sizer.Left, FMinF";
Debug.ShouldStop(1);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setWidth",csplitter.__c.runMethod(true,"Max",(Object)(RemoteObject.solve(new RemoteObject[] {_width,__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getLeft")}, "-",1, 0)),(Object)(BA.numberCast(double.class, __ref.getField(true,"_fminflexsize" /*RemoteObject*/ )))));
 break; }
case 2: {
 BA.debugLineNum = 195;BA.debugLine="FlexPanel.Height = Max(Height - FlexPanel.Top,";
Debug.ShouldStop(4);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setHeight",csplitter.__c.runMethod(true,"Max",(Object)(RemoteObject.solve(new RemoteObject[] {_height,__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"getTop")}, "-",1, 0)),(Object)(BA.numberCast(double.class, __ref.getField(true,"_fminflexsize" /*RemoteObject*/ )))));
 break; }
default: {
 BA.debugLineNum = 197;BA.debugLine="FlexPanel.Height = Max(Height - Sizer.Top, FMin";
Debug.ShouldStop(16);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setHeight",csplitter.__c.runMethod(true,"Max",(Object)(RemoteObject.solve(new RemoteObject[] {_height,__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getTop")}, "-",1, 0)),(Object)(BA.numberCast(double.class, __ref.getField(true,"_fminflexsize" /*RemoteObject*/ )))));
 break; }
}
;
 BA.debugLineNum = 199;BA.debugLine="End Sub";
Debug.ShouldStop(64);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _restorepos(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("RestorePos (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,34);
if (RapidSub.canDelegate("restorepos")) { return __ref.runUserSub(false, "csplitter","restorepos", __ref);}
 BA.debugLineNum = 34;BA.debugLine="Public Sub RestorePos";
Debug.ShouldStop(2);
 BA.debugLineNum = 35;BA.debugLine="setDiv(B4XPages.MainPage.KVS.GetDefault($\"${OptKe";
Debug.ShouldStop(4);
__ref.runClassMethod (hr.splitterexample.csplitter.class, "_setdiv" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, csplitter._b4xpages.runMethod(false,"_mainpage" /*RemoteObject*/ ).getField(false,"_kvs" /*RemoteObject*/ ).runClassMethod (hr.splitterexample.keyvaluestore.class, "_getdefault" /*RemoteObject*/ ,(Object)((RemoteObject.concat(RemoteObject.createImmutable(""),csplitter.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((__ref.getField(true,"_optkey" /*RemoteObject*/ )))),RemoteObject.createImmutable("Pos")))),(Object)(RemoteObject.createImmutable((250)))))));
 BA.debugLineNum = 36;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _restructure(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Restructure (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,114);
if (RapidSub.canDelegate("restructure")) { return __ref.runUserSub(false, "csplitter","restructure", __ref);}
 BA.debugLineNum = 114;BA.debugLine="Public Sub Restructure";
Debug.ShouldStop(131072);
 BA.debugLineNum = 115;BA.debugLine="If Horizontal Then";
Debug.ShouldStop(262144);
if (__ref.runClassMethod (hr.splitterexample.csplitter.class, "_horizontal" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 116;BA.debugLine="FixedPanel.Top = 0";
Debug.ShouldStop(524288);
__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"setTop",BA.numberCast(double.class, 0));
 BA.debugLineNum = 117;BA.debugLine="FixedPanel.Height = panBase.Height";
Debug.ShouldStop(1048576);
__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"setHeight",__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getHeight"));
 BA.debugLineNum = 118;BA.debugLine="Sizer.Top = 0";
Debug.ShouldStop(2097152);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setTop",BA.numberCast(double.class, 0));
 BA.debugLineNum = 119;BA.debugLine="Sizer.Width = Sizer.Height";
Debug.ShouldStop(4194304);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setWidth",__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getHeight"));
 BA.debugLineNum = 120;BA.debugLine="Sizer.Height = panBase.Height";
Debug.ShouldStop(8388608);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setHeight",__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getHeight"));
 BA.debugLineNum = 121;BA.debugLine="FlexPanel.Top = 0";
Debug.ShouldStop(16777216);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setTop",BA.numberCast(double.class, 0));
 BA.debugLineNum = 122;BA.debugLine="FlexPanel.Height = panBase.Height";
Debug.ShouldStop(33554432);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setHeight",__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getHeight"));
 }else {
 BA.debugLineNum = 124;BA.debugLine="FixedPanel.Left = 0";
Debug.ShouldStop(134217728);
__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"setLeft",BA.numberCast(double.class, 0));
 BA.debugLineNum = 125;BA.debugLine="FixedPanel.Width = panBase.Width";
Debug.ShouldStop(268435456);
__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"setWidth",__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getWidth"));
 BA.debugLineNum = 126;BA.debugLine="Sizer.Left = 0";
Debug.ShouldStop(536870912);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setLeft",BA.numberCast(double.class, 0));
 BA.debugLineNum = 127;BA.debugLine="Sizer.Height = Sizer.Width";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setHeight",__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getWidth"));
 BA.debugLineNum = 128;BA.debugLine="Sizer.Width = panBase.width";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setWidth",__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getWidth"));
 BA.debugLineNum = 129;BA.debugLine="FlexPanel.Left = 0";
Debug.ShouldStop(1);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setLeft",BA.numberCast(double.class, 0));
 BA.debugLineNum = 130;BA.debugLine="FlexPanel.Width = panBase.Width";
Debug.ShouldStop(2);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setWidth",__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getWidth"));
 };
 BA.debugLineNum = 132;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setdiv(RemoteObject __ref,RemoteObject _pos) throws Exception{
try {
		Debug.PushSubsStack("setDiv (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,90);
if (RapidSub.canDelegate("setdiv")) { return __ref.runUserSub(false, "csplitter","setdiv", __ref, _pos);}
Debug.locals.put("Pos", _pos);
 BA.debugLineNum = 90;BA.debugLine="Public Sub setDiv(Pos As Int)";
Debug.ShouldStop(33554432);
 BA.debugLineNum = 91;BA.debugLine="SetSizer(Pos - Sizer.Left, Pos - Sizer.Top)";
Debug.ShouldStop(67108864);
__ref.runClassMethod (hr.splitterexample.csplitter.class, "_setsizer" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_pos,__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getLeft")}, "-",1, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_pos,__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getTop")}, "-",1, 0))));
 BA.debugLineNum = 92;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setdivpercent(RemoteObject __ref,RemoteObject _pos) throws Exception{
try {
		Debug.PushSubsStack("SetDivPerCent (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,94);
if (RapidSub.canDelegate("setdivpercent")) { return __ref.runUserSub(false, "csplitter","setdivpercent", __ref, _pos);}
Debug.locals.put("pos", _pos);
 BA.debugLineNum = 94;BA.debugLine="Public Sub SetDivPerCent(pos As Int)";
Debug.ShouldStop(536870912);
 BA.debugLineNum = 95;BA.debugLine="Select FSplitterType";
Debug.ShouldStop(1073741824);
switch (BA.switchObjectToInt(__ref.getField(true,"_fsplittertype" /*RemoteObject*/ ),__ref.getField(true,"_splleft" /*RemoteObject*/ ),__ref.getField(true,"_splright" /*RemoteObject*/ ))) {
case 0: 
case 1: {
 BA.debugLineNum = 97;BA.debugLine="setDiv(pos * 100 / panBase.Width)";
Debug.ShouldStop(1);
__ref.runClassMethod (hr.splitterexample.csplitter.class, "_setdiv" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_pos,RemoteObject.createImmutable(100),__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getWidth")}, "*/",0, 0))));
 break; }
default: {
 BA.debugLineNum = 99;BA.debugLine="setDiv(pos * 100 / panBase.Height)";
Debug.ShouldStop(4);
__ref.runClassMethod (hr.splitterexample.csplitter.class, "_setdiv" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_pos,RemoteObject.createImmutable(100),__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getHeight")}, "*/",0, 0))));
 break; }
}
;
 BA.debugLineNum = 101;BA.debugLine="End Sub";
Debug.ShouldStop(16);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setminfixedsize(RemoteObject __ref,RemoteObject _size) throws Exception{
try {
		Debug.PushSubsStack("setMinFixedSize (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,78);
if (RapidSub.canDelegate("setminfixedsize")) { return __ref.runUserSub(false, "csplitter","setminfixedsize", __ref, _size);}
Debug.locals.put("Size", _size);
 BA.debugLineNum = 78;BA.debugLine="Public Sub setMinFixedSize(Size As Int)";
Debug.ShouldStop(8192);
 BA.debugLineNum = 79;BA.debugLine="FMinFixedSize = Size";
Debug.ShouldStop(16384);
__ref.setField ("_fminfixedsize" /*RemoteObject*/ ,_size);
 BA.debugLineNum = 80;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setminflexsize(RemoteObject __ref,RemoteObject _size) throws Exception{
try {
		Debug.PushSubsStack("setMinFlexSize (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,86);
if (RapidSub.canDelegate("setminflexsize")) { return __ref.runUserSub(false, "csplitter","setminflexsize", __ref, _size);}
Debug.locals.put("Size", _size);
 BA.debugLineNum = 86;BA.debugLine="Public Sub setMinFlexSize(Size As Int)";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 87;BA.debugLine="FMinFixedSize = Size";
Debug.ShouldStop(4194304);
__ref.setField ("_fminfixedsize" /*RemoteObject*/ ,_size);
 BA.debugLineNum = 88;BA.debugLine="End Sub";
Debug.ShouldStop(8388608);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setsizer(RemoteObject __ref,RemoteObject _x,RemoteObject _y) throws Exception{
try {
		Debug.PushSubsStack("SetSizer (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,149);
if (RapidSub.canDelegate("setsizer")) { return __ref.runUserSub(false, "csplitter","setsizer", __ref, _x, _y);}
Debug.locals.put("X", _x);
Debug.locals.put("Y", _y);
 BA.debugLineNum = 149;BA.debugLine="Private Sub SetSizer(X As Int, Y As Int)";
Debug.ShouldStop(1048576);
 BA.debugLineNum = 150;BA.debugLine="Select FSplitterType";
Debug.ShouldStop(2097152);
switch (BA.switchObjectToInt(__ref.getField(true,"_fsplittertype" /*RemoteObject*/ ),__ref.getField(true,"_splleft" /*RemoteObject*/ ),__ref.getField(true,"_splright" /*RemoteObject*/ ),__ref.getField(true,"_spltop" /*RemoteObject*/ ))) {
case 0: {
 BA.debugLineNum = 152;BA.debugLine="Sizer.Left = Max(Min(Sizer.Left + X, panBase.Wi";
Debug.ShouldStop(8388608);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setLeft",csplitter.__c.runMethod(true,"Max",(Object)(csplitter.__c.runMethod(true,"Min",(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getLeft"),_x}, "+",1, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getWidth"),__ref.getField(true,"_fminflexsize" /*RemoteObject*/ )}, "-",1, 0)))),(Object)(BA.numberCast(double.class, __ref.getField(true,"_fminfixedsize" /*RemoteObject*/ )))));
 BA.debugLineNum = 153;BA.debugLine="FlexPanel.Left = Sizer.Left + Sizer.Width";
Debug.ShouldStop(16777216);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getLeft"),__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getWidth")}, "+",1, 0));
 BA.debugLineNum = 154;BA.debugLine="FlexPanel.Width = Max(FlexPanel.Parent.Width -";
Debug.ShouldStop(33554432);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setWidth",csplitter.__c.runMethod(true,"Max",(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(false,"getParent").runMethod(true,"getWidth"),__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"getLeft")}, "-",1, 0)),(Object)(BA.numberCast(double.class, __ref.getField(true,"_fminflexsize" /*RemoteObject*/ )))));
 BA.debugLineNum = 155;BA.debugLine="FixedPanel.Width = Max(Sizer.Left - FixedPanel.";
Debug.ShouldStop(67108864);
__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"setWidth",csplitter.__c.runMethod(true,"Max",(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getLeft"),__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"getLeft")}, "-",1, 0)),(Object)(BA.numberCast(double.class, __ref.getField(true,"_fminfixedsize" /*RemoteObject*/ )))));
 break; }
case 1: {
 BA.debugLineNum = 157;BA.debugLine="Sizer.Left = Max(Min(Sizer.Left + X, panBase.Wi";
Debug.ShouldStop(268435456);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setLeft",csplitter.__c.runMethod(true,"Max",(Object)(csplitter.__c.runMethod(true,"Min",(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getLeft"),_x}, "+",1, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getWidth"),__ref.getField(true,"_fminflexsize" /*RemoteObject*/ )}, "-",1, 0)))),(Object)(BA.numberCast(double.class, __ref.getField(true,"_fminfixedsize" /*RemoteObject*/ )))));
 BA.debugLineNum = 158;BA.debugLine="FlexPanel.Left = Sizer.Left + Sizer.Width";
Debug.ShouldStop(536870912);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getLeft"),__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getWidth")}, "+",1, 0));
 BA.debugLineNum = 159;BA.debugLine="FlexPanel.Width = FlexPanel.Parent.Width - Flex";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(false,"getParent").runMethod(true,"getWidth"),__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"getLeft")}, "-",1, 0));
 BA.debugLineNum = 160;BA.debugLine="FixedPanel.Width = Sizer.Left - FixedPanel.Left";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getLeft"),__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"getLeft")}, "-",1, 0));
 break; }
case 2: {
 BA.debugLineNum = 162;BA.debugLine="Sizer.Top = Max(Min(Sizer.Top + Y, panBase.Heig";
Debug.ShouldStop(2);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setTop",csplitter.__c.runMethod(true,"Max",(Object)(csplitter.__c.runMethod(true,"Min",(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getTop"),_y}, "+",1, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getHeight"),__ref.getField(true,"_fminflexsize" /*RemoteObject*/ )}, "-",1, 0)))),(Object)(BA.numberCast(double.class, __ref.getField(true,"_fminfixedsize" /*RemoteObject*/ )))));
 BA.debugLineNum = 163;BA.debugLine="FlexPanel.Top = Sizer.Top + Sizer.Height";
Debug.ShouldStop(4);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getTop"),__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getHeight")}, "+",1, 0));
 BA.debugLineNum = 164;BA.debugLine="FlexPanel.Height = FlexPanel.Parent.Height - Fl";
Debug.ShouldStop(8);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(false,"getParent").runMethod(true,"getHeight"),__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"getTop")}, "-",1, 0));
 BA.debugLineNum = 165;BA.debugLine="FixedPanel.Height = Sizer.Top - FixedPanel.Top";
Debug.ShouldStop(16);
__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getTop"),__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"getTop")}, "-",1, 0));
 break; }
default: {
 BA.debugLineNum = 167;BA.debugLine="Sizer.Top = Max(Min(Sizer.Top + Y, panBase.Heig";
Debug.ShouldStop(64);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setTop",csplitter.__c.runMethod(true,"Max",(Object)(csplitter.__c.runMethod(true,"Min",(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getTop"),_y}, "+",1, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getHeight"),__ref.getField(true,"_fminflexsize" /*RemoteObject*/ )}, "-",1, 0)))),(Object)(BA.numberCast(double.class, __ref.getField(true,"_fminfixedsize" /*RemoteObject*/ )))));
 BA.debugLineNum = 168;BA.debugLine="FlexPanel.Top = Sizer.Top + Sizer.Height";
Debug.ShouldStop(128);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getTop"),__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getHeight")}, "+",1, 0));
 BA.debugLineNum = 169;BA.debugLine="FlexPanel.Height = FlexPanel.Parent.Height - Fl";
Debug.ShouldStop(256);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(false,"getParent").runMethod(true,"getHeight"),__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"getHeight")}, "-",1, 0));
 BA.debugLineNum = 170;BA.debugLine="FixedPanel.Height = Sizer.Top - FixedPanel.Top";
Debug.ShouldStop(512);
__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getTop"),__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"getTop")}, "-",1, 0));
 break; }
}
;
 BA.debugLineNum = 172;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setsplittertype(RemoteObject __ref,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("setSplitterType (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,46);
if (RapidSub.canDelegate("setsplittertype")) { return __ref.runUserSub(false, "csplitter","setsplittertype", __ref, _value);}
RemoteObject _oldtype = RemoteObject.createImmutable(0);
RemoteObject _jocursors = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
Debug.locals.put("Value", _value);
 BA.debugLineNum = 46;BA.debugLine="Public Sub setSplitterType(Value As Int)";
Debug.ShouldStop(8192);
 BA.debugLineNum = 47;BA.debugLine="Dim OldType As Int = FSplitterType";
Debug.ShouldStop(16384);
_oldtype = __ref.getField(true,"_fsplittertype" /*RemoteObject*/ );Debug.locals.put("OldType", _oldtype);Debug.locals.put("OldType", _oldtype);
 BA.debugLineNum = 48;BA.debugLine="FSplitterType = Value";
Debug.ShouldStop(32768);
__ref.setField ("_fsplittertype" /*RemoteObject*/ ,_value);
 BA.debugLineNum = 49;BA.debugLine="Dim joCursors As JavaObject";
Debug.ShouldStop(65536);
_jocursors = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");Debug.locals.put("joCursors", _jocursors);
 BA.debugLineNum = 50;BA.debugLine="joCursors.InitializeStatic(\"javafx.scene.Cursor\")";
Debug.ShouldStop(131072);
_jocursors.runVoidMethod ("InitializeStatic",(Object)(RemoteObject.createImmutable("javafx.scene.Cursor")));
 BA.debugLineNum = 51;BA.debugLine="Sizer.As(Pane).MouseCursor = joCursors.GetField(I";
Debug.ShouldStop(262144);
(RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper"), __ref.getField(false,"_sizer" /*RemoteObject*/ ).getObject())).runMethod(false,"setMouseCursor",(_jocursors.runMethod(false,"GetField",(Object)(BA.ObjectToString(((__ref.runClassMethod (hr.splitterexample.csplitter.class, "_horizontal" /*RemoteObject*/ ).<Boolean>get().booleanValue()) ? (RemoteObject.createImmutable(("H_RESIZE"))) : ((RemoteObject.createImmutable("V_RESIZE")))))))));
 BA.debugLineNum = 52;BA.debugLine="If HorizontalType(OldType) <> Horizontal Then Res";
Debug.ShouldStop(524288);
if (RemoteObject.solveBoolean("!",__ref.runClassMethod (hr.splitterexample.csplitter.class, "_horizontaltype" /*RemoteObject*/ ,(Object)(_oldtype)),__ref.runClassMethod (hr.splitterexample.csplitter.class, "_horizontal" /*RemoteObject*/ ))) { 
__ref.runClassMethod (hr.splitterexample.csplitter.class, "_restructure" /*RemoteObject*/ );};
 BA.debugLineNum = 53;BA.debugLine="Select FSplitterType";
Debug.ShouldStop(1048576);
switch (BA.switchObjectToInt(__ref.getField(true,"_fsplittertype" /*RemoteObject*/ ),__ref.getField(true,"_splleft" /*RemoteObject*/ ),__ref.getField(true,"_splright" /*RemoteObject*/ ),__ref.getField(true,"_spltop" /*RemoteObject*/ ))) {
case 0: {
 BA.debugLineNum = 55;BA.debugLine="FixedPanel.Left = 0";
Debug.ShouldStop(4194304);
__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"setLeft",BA.numberCast(double.class, 0));
 BA.debugLineNum = 56;BA.debugLine="Sizer.Left = panBase.Width / 2";
Debug.ShouldStop(8388608);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0));
 BA.debugLineNum = 57;BA.debugLine="FlexPanel.Left = Sizer.Left + Sizer.Width";
Debug.ShouldStop(16777216);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getLeft"),__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getWidth")}, "+",1, 0));
 break; }
case 1: {
 BA.debugLineNum = 59;BA.debugLine="FlexPanel.Left = 0";
Debug.ShouldStop(67108864);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setLeft",BA.numberCast(double.class, 0));
 BA.debugLineNum = 60;BA.debugLine="Sizer.Left = panBase.Width / 2";
Debug.ShouldStop(134217728);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0));
 BA.debugLineNum = 61;BA.debugLine="FixedPanel.Left = Sizer.Left + Sizer.Width";
Debug.ShouldStop(268435456);
__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getLeft"),__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getWidth")}, "+",1, 0));
 break; }
case 2: {
 BA.debugLineNum = 63;BA.debugLine="FixedPanel.Top = 0";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"setTop",BA.numberCast(double.class, 0));
 BA.debugLineNum = 64;BA.debugLine="Sizer.Top = panBase.Height / 2";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0));
 BA.debugLineNum = 65;BA.debugLine="FlexPanel.Top = Sizer.Top + Sizer.Height";
Debug.ShouldStop(1);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getTop"),__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getHeight")}, "+",1, 0));
 break; }
default: {
 BA.debugLineNum = 67;BA.debugLine="FlexPanel.Top = 0";
Debug.ShouldStop(4);
__ref.getField(false,"_flexpanel" /*RemoteObject*/ ).runMethod(true,"setTop",BA.numberCast(double.class, 0));
 BA.debugLineNum = 68;BA.debugLine="Sizer.Top = panBase.Height / 2";
Debug.ShouldStop(8);
__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0));
 BA.debugLineNum = 69;BA.debugLine="FixedPanel.Top = Sizer.Top + Sizer.Height";
Debug.ShouldStop(16);
__ref.getField(false,"_fixedpanel" /*RemoteObject*/ ).runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getTop"),__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getHeight")}, "+",1, 0));
 break; }
}
;
 BA.debugLineNum = 71;BA.debugLine="panBase_Resize(panBase.Width, panBase.Height)";
Debug.ShouldStop(64);
__ref.runClassMethod (hr.splitterexample.csplitter.class, "_panbase_resize" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_panbase" /*RemoteObject*/ ).runMethod(true,"getHeight")));
 BA.debugLineNum = 72;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static void  _sizer_mousepressed(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("Sizer_MousePressed (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,138);
if (RapidSub.canDelegate("sizer_mousepressed")) { __ref.runUserSub(false, "csplitter","sizer_mousepressed", __ref, _eventdata); return;}
ResumableSub_Sizer_MousePressed rsub = new ResumableSub_Sizer_MousePressed(null,__ref,_eventdata);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_Sizer_MousePressed extends BA.ResumableSub {
public ResumableSub_Sizer_MousePressed(hr.splitterexample.csplitter parent,RemoteObject __ref,RemoteObject _eventdata) {
this.parent = parent;
this.__ref = __ref;
this._eventdata = _eventdata;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
hr.splitterexample.csplitter parent;
RemoteObject _eventdata;
RemoteObject _startx = RemoteObject.createImmutable(0);
RemoteObject _starty = RemoteObject.createImmutable(0);

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("Sizer_MousePressed (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,138);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
Debug.locals.put("_ref", __ref);
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 139;BA.debugLine="If EventData.ClickCount > 1 Then Return";
Debug.ShouldStop(1024);
if (true) break;

case 1:
//if
this.state = 6;
if (RemoteObject.solveBoolean(">",_eventdata.runMethod(true,"getClickCount"),BA.numberCast(double.class, 1))) { 
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
 BA.debugLineNum = 140;BA.debugLine="Sizing = True";
Debug.ShouldStop(2048);
__ref.setField ("_sizing" /*RemoteObject*/ ,parent.__c.getField(true,"True"));
 BA.debugLineNum = 141;BA.debugLine="Dim StartX As Double = EventData.X";
Debug.ShouldStop(4096);
_startx = _eventdata.runMethod(true,"getX");Debug.locals.put("StartX", _startx);Debug.locals.put("StartX", _startx);
 BA.debugLineNum = 142;BA.debugLine="Dim StartY As Double = EventData.Y";
Debug.ShouldStop(8192);
_starty = _eventdata.runMethod(true,"getY");Debug.locals.put("StartY", _starty);Debug.locals.put("StartY", _starty);
 BA.debugLineNum = 143;BA.debugLine="Do While Sizing";
Debug.ShouldStop(16384);
if (true) break;

case 7:
//do while
this.state = 10;
while (__ref.getField(true,"_sizing" /*RemoteObject*/ ).<Boolean>get().booleanValue()) {
this.state = 9;
if (true) break;
}
if (true) break;

case 9:
//C
this.state = 7;
 BA.debugLineNum = 144;BA.debugLine="Wait For(Sizer) Sizer_MouseDragged(EventData As";
Debug.ShouldStop(32768);
parent.__c.runVoidMethod ("WaitFor","sizer_mousedragged", __ref.getField(false, "ba"), anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "csplitter", "sizer_mousepressed"), (__ref.getField(false,"_sizer" /*RemoteObject*/ ).getObject()));
this.state = 11;
return;
case 11:
//C
this.state = 7;
_eventdata = (RemoteObject) result.getArrayElement(false,RemoteObject.createImmutable(1));Debug.locals.put("EventData", _eventdata);
;
 BA.debugLineNum = 145;BA.debugLine="SetSizer(EventData.X - StartX, EventData.Y - Sta";
Debug.ShouldStop(65536);
__ref.runClassMethod (hr.splitterexample.csplitter.class, "_setsizer" /*RemoteObject*/ ,(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_eventdata.runMethod(true,"getX"),_startx}, "-",1, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_eventdata.runMethod(true,"getY"),_starty}, "-",1, 0))));
 if (true) break;

case 10:
//C
this.state = -1;
;
 BA.debugLineNum = 147;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
if (true) break;

            }
        }
    }
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}
public static void  _sizer_mousedragged(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
}
public static RemoteObject  _sizer_mousereleased(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("Sizer_MouseReleased (csplitter) ","csplitter",2,__ref.getField(false, "ba"),__ref,174);
if (RapidSub.canDelegate("sizer_mousereleased")) { return __ref.runUserSub(false, "csplitter","sizer_mousereleased", __ref, _eventdata);}
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 174;BA.debugLine="Private Sub Sizer_MouseReleased (EventData As Mous";
Debug.ShouldStop(8192);
 BA.debugLineNum = 175;BA.debugLine="Sizing = False";
Debug.ShouldStop(16384);
__ref.setField ("_sizing" /*RemoteObject*/ ,csplitter.__c.getField(true,"False"));
 BA.debugLineNum = 176;BA.debugLine="B4XPages.MainPage.KVS.Put($\"${OptKey}Pos\"$, IIf(H";
Debug.ShouldStop(32768);
csplitter._b4xpages.runMethod(false,"_mainpage" /*RemoteObject*/ ).getField(false,"_kvs" /*RemoteObject*/ ).runClassMethod (hr.splitterexample.keyvaluestore.class, "_put" /*RemoteObject*/ ,(Object)((RemoteObject.concat(RemoteObject.createImmutable(""),csplitter.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((__ref.getField(true,"_optkey" /*RemoteObject*/ )))),RemoteObject.createImmutable("Pos")))),(Object)(((__ref.runClassMethod (hr.splitterexample.csplitter.class, "_horizontal" /*RemoteObject*/ ).<Boolean>get().booleanValue()) ? ((__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getLeft"))) : ((__ref.getField(false,"_sizer" /*RemoteObject*/ ).runMethod(true,"getTop"))))));
 BA.debugLineNum = 177;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}