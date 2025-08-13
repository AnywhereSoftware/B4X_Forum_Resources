package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class asmsgbox_subs_0 {


public static RemoteObject  _base_resize(RemoteObject __ref,RemoteObject _width,RemoteObject _height) throws Exception{
try {
		Debug.PushSubsStack("Base_Resize (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,290);
if (RapidSub.canDelegate("base_resize")) { return __ref.runUserSub(false, "asmsgbox","base_resize", __ref, _width, _height);}
Debug.locals.put("Width", _width);
Debug.locals.put("Height", _height);
 BA.debugLineNum = 290;BA.debugLine="Private Sub Base_Resize (Width As Double, Height A";
Debug.ShouldStop(2);
 BA.debugLineNum = 292;BA.debugLine="mBase.SetColorAndBorder(back_color,0dip,xui.Color";
Debug.ShouldStop(8);
__ref.getField(false,"_mbase").runVoidMethod ("SetColorAndBorder",(Object)(__ref.getField(true,"_back_color")),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 0))))),(Object)(__ref.getField(false,"_xui").getField(true,"Color_Transparent")),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))))));
 BA.debugLineNum = 295;BA.debugLine="xpnl_header.Visible = showHeader";
Debug.ShouldStop(64);
__ref.getField(false,"_xpnl_header").runMethod(true,"setVisible",__ref.getField(true,"_showheader"));
 BA.debugLineNum = 296;BA.debugLine="xpnl_bottom.Visible = showBottom";
Debug.ShouldStop(128);
__ref.getField(false,"_xpnl_bottom").runMethod(true,"setVisible",__ref.getField(true,"_showbottom"));
 BA.debugLineNum = 298;BA.debugLine="xpnl_close.Visible = showX";
Debug.ShouldStop(512);
__ref.getField(false,"_xpnl_close").runMethod(true,"setVisible",__ref.getField(true,"_showx"));
 BA.debugLineNum = 300;BA.debugLine="If showHeader = True Then";
Debug.ShouldStop(2048);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_showheader"),asmsgbox.__c.getField(true,"True"))) { 
 BA.debugLineNum = 303;BA.debugLine="xpnl_header.Width = mBase.Width";
Debug.ShouldStop(16384);
__ref.getField(false,"_xpnl_header").runMethod(true,"setWidth",__ref.getField(false,"_mbase").runMethod(true,"getWidth"));
 BA.debugLineNum = 304;BA.debugLine="xline_1.Width = mBase.Width";
Debug.ShouldStop(32768);
__ref.getField(false,"_xline_1").runMethod(true,"setWidth",__ref.getField(false,"_mbase").runMethod(true,"getWidth"));
 BA.debugLineNum = 306;BA.debugLine="xpnl_header.Color = header_clr";
Debug.ShouldStop(131072);
__ref.getField(false,"_xpnl_header").runMethod(true,"setColor",__ref.getField(true,"_header_clr"));
 BA.debugLineNum = 307;BA.debugLine="xlbl_header.Height = MeasureTextHeight(xlbl_head";
Debug.ShouldStop(262144);
__ref.getField(false,"_xlbl_header").runMethod(true,"setHeight",BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.runClassMethod (b4j.example.asmsgbox.class, "_measuretextheight",(Object)(__ref.getField(false,"_xlbl_header").runMethod(true,"getText")),(Object)(__ref.getField(false,"_xlbl_header").runMethod(false,"getFont"))),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 8)))}, "+",1, 1)));
 BA.debugLineNum = 310;BA.debugLine="xpnl_content.Top = xpnl_header.Height";
Debug.ShouldStop(2097152);
__ref.getField(false,"_xpnl_content").runMethod(true,"setTop",__ref.getField(false,"_xpnl_header").runMethod(true,"getHeight"));
 BA.debugLineNum = 313;BA.debugLine="If iconVisible = True Then";
Debug.ShouldStop(16777216);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_iconvisible"),asmsgbox.__c.getField(true,"True"))) { 
 BA.debugLineNum = 315;BA.debugLine="If iconDirection = \"LEFT\" Then";
Debug.ShouldStop(67108864);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_icondirection"),BA.ObjectToString("LEFT"))) { 
 BA.debugLineNum = 317;BA.debugLine="xiv_icon.Width = 40dip";
Debug.ShouldStop(268435456);
__ref.getField(false,"_xiv_icon").runMethod(true,"setWidth",BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 40)))));
 BA.debugLineNum = 318;BA.debugLine="xiv_icon.Height = 40dip";
Debug.ShouldStop(536870912);
__ref.getField(false,"_xiv_icon").runMethod(true,"setHeight",BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 40)))));
 BA.debugLineNum = 320;BA.debugLine="xlbl_header.Top = xpnl_header.Top + xpnl_header";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_xlbl_header").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_header").runMethod(true,"getTop"),__ref.getField(false,"_xpnl_header").runMethod(true,"getHeight"),RemoteObject.createImmutable(2),__ref.getField(false,"_xlbl_header").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "+/-/",2, 0));
 BA.debugLineNum = 321;BA.debugLine="xlbl_header.Width =	MeasureTextWidth(xlbl_heade";
Debug.ShouldStop(1);
__ref.getField(false,"_xlbl_header").runMethod(true,"setWidth",BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.runClassMethod (b4j.example.asmsgbox.class, "_measuretextwidth",(Object)(__ref.getField(false,"_xlbl_header").runMethod(true,"getText")),(Object)(__ref.getField(false,"_xlbl_header").runMethod(false,"getFont"))),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))}, "+",1, 1)));
 BA.debugLineNum = 322;BA.debugLine="xlbl_header.Left = xpnl_header.Width/2 - xlbl_h";
Debug.ShouldStop(2);
__ref.getField(false,"_xlbl_header").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_header").runMethod(true,"getWidth"),RemoteObject.createImmutable(2),__ref.getField(false,"_xlbl_header").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/-/",1, 0));
 BA.debugLineNum = 323;BA.debugLine="xiv_icon.Left = xlbl_header.Left - xiv_icon.Wid";
Debug.ShouldStop(4);
__ref.getField(false,"_xiv_icon").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xlbl_header").runMethod(true,"getLeft"),__ref.getField(false,"_xiv_icon").runMethod(true,"getWidth"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "--",2, 0));
 BA.debugLineNum = 324;BA.debugLine="xiv_icon.Top = xpnl_header.Top + xpnl_header.H";
Debug.ShouldStop(8);
__ref.getField(false,"_xiv_icon").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_header").runMethod(true,"getTop"),__ref.getField(false,"_xpnl_header").runMethod(true,"getHeight"),RemoteObject.createImmutable(2),__ref.getField(false,"_xiv_icon").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "+/-/",2, 0));
 }else 
{ BA.debugLineNum = 326;BA.debugLine="Else If iconDirection = \"MIDDLE\" Then";
Debug.ShouldStop(32);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_icondirection"),BA.ObjectToString("MIDDLE"))) { 
 BA.debugLineNum = 328;BA.debugLine="xiv_icon.Width = 30dip";
Debug.ShouldStop(128);
__ref.getField(false,"_xiv_icon").runMethod(true,"setWidth",BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 30)))));
 BA.debugLineNum = 329;BA.debugLine="xiv_icon.Height = 30dip";
Debug.ShouldStop(256);
__ref.getField(false,"_xiv_icon").runMethod(true,"setHeight",BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 30)))));
 BA.debugLineNum = 331;BA.debugLine="xiv_icon.Top = 4dip";
Debug.ShouldStop(1024);
__ref.getField(false,"_xiv_icon").runMethod(true,"setTop",BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 4)))));
 BA.debugLineNum = 332;BA.debugLine="xiv_icon.Left = xpnl_header.Width/2 - xiv_icon.";
Debug.ShouldStop(2048);
__ref.getField(false,"_xiv_icon").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_header").runMethod(true,"getWidth"),RemoteObject.createImmutable(2),__ref.getField(false,"_xiv_icon").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/-/",1, 0));
 BA.debugLineNum = 334;BA.debugLine="xlbl_header.Top = xiv_icon.Top + xiv_icon.Heig";
Debug.ShouldStop(8192);
__ref.getField(false,"_xlbl_header").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xiv_icon").runMethod(true,"getTop"),__ref.getField(false,"_xiv_icon").runMethod(true,"getHeight"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 4)))}, "+-",2, 0));
 BA.debugLineNum = 335;BA.debugLine="xlbl_header.Width =	MeasureTextWidth(xlbl_heade";
Debug.ShouldStop(16384);
__ref.getField(false,"_xlbl_header").runMethod(true,"setWidth",BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.runClassMethod (b4j.example.asmsgbox.class, "_measuretextwidth",(Object)(__ref.getField(false,"_xlbl_header").runMethod(true,"getText")),(Object)(__ref.getField(false,"_xlbl_header").runMethod(false,"getFont"))),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))}, "+",1, 1)));
 BA.debugLineNum = 336;BA.debugLine="xlbl_header.Left = xpnl_header.Width/2 - xlbl_h";
Debug.ShouldStop(32768);
__ref.getField(false,"_xlbl_header").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_header").runMethod(true,"getWidth"),RemoteObject.createImmutable(2),__ref.getField(false,"_xlbl_header").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/-/",1, 0));
 }else 
{ BA.debugLineNum = 339;BA.debugLine="Else If iconDirection = \"RIGHT\" Then";
Debug.ShouldStop(262144);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_icondirection"),BA.ObjectToString("RIGHT"))) { 
 BA.debugLineNum = 341;BA.debugLine="xlbl_header.Top = xpnl_header.Top + xpnl_header";
Debug.ShouldStop(1048576);
__ref.getField(false,"_xlbl_header").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_header").runMethod(true,"getTop"),__ref.getField(false,"_xpnl_header").runMethod(true,"getHeight"),RemoteObject.createImmutable(2),__ref.getField(false,"_xlbl_header").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "+/-/",2, 0));
 BA.debugLineNum = 342;BA.debugLine="xlbl_header.Width =	MeasureTextWidth(xlbl_heade";
Debug.ShouldStop(2097152);
__ref.getField(false,"_xlbl_header").runMethod(true,"setWidth",BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {__ref.runClassMethod (b4j.example.asmsgbox.class, "_measuretextwidth",(Object)(__ref.getField(false,"_xlbl_header").runMethod(true,"getText")),(Object)(__ref.getField(false,"_xlbl_header").runMethod(false,"getFont"))),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))}, "+",1, 1)));
 BA.debugLineNum = 343;BA.debugLine="xlbl_header.Left = xpnl_header.Width/2 - xlbl_h";
Debug.ShouldStop(4194304);
__ref.getField(false,"_xlbl_header").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_header").runMethod(true,"getWidth"),RemoteObject.createImmutable(2),__ref.getField(false,"_xlbl_header").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/-/",1, 0));
 BA.debugLineNum = 344;BA.debugLine="xiv_icon.Left = xlbl_header.Left + xlbl_header.";
Debug.ShouldStop(8388608);
__ref.getField(false,"_xiv_icon").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xlbl_header").runMethod(true,"getLeft"),__ref.getField(false,"_xlbl_header").runMethod(true,"getWidth"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "++",2, 0));
 BA.debugLineNum = 345;BA.debugLine="xiv_icon.Top = xpnl_header.Top + xpnl_header.H";
Debug.ShouldStop(16777216);
__ref.getField(false,"_xiv_icon").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_header").runMethod(true,"getTop"),__ref.getField(false,"_xpnl_header").runMethod(true,"getHeight"),RemoteObject.createImmutable(2),__ref.getField(false,"_xiv_icon").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "+/-/",2, 0));
 }}}
;
 }else {
 BA.debugLineNum = 351;BA.debugLine="xiv_icon.Width = 40dip";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_xiv_icon").runMethod(true,"setWidth",BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 40)))));
 BA.debugLineNum = 352;BA.debugLine="xiv_icon.Height = 40dip";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_xiv_icon").runMethod(true,"setHeight",BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 40)))));
 BA.debugLineNum = 354;BA.debugLine="xlbl_header.Top = xpnl_header.Top + xpnl_header.";
Debug.ShouldStop(2);
__ref.getField(false,"_xlbl_header").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_header").runMethod(true,"getTop"),__ref.getField(false,"_xpnl_header").runMethod(true,"getHeight"),RemoteObject.createImmutable(2),__ref.getField(false,"_xlbl_header").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "+/-/",2, 0));
 BA.debugLineNum = 355;BA.debugLine="xlbl_header.Left = xpnl_header.Left + 5dip";
Debug.ShouldStop(4);
__ref.getField(false,"_xlbl_header").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_header").runMethod(true,"getLeft"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "+",1, 0));
 BA.debugLineNum = 356;BA.debugLine="xlbl_header.Width = xpnl_header.Width - 5dip";
Debug.ShouldStop(8);
__ref.getField(false,"_xlbl_header").runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_header").runMethod(true,"getWidth"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "-",1, 0));
 };
 }else {
 BA.debugLineNum = 362;BA.debugLine="xpnl_content.Top = 0";
Debug.ShouldStop(512);
__ref.getField(false,"_xpnl_content").runMethod(true,"setTop",BA.numberCast(double.class, 0));
 };
 BA.debugLineNum = 366;BA.debugLine="If showBottom = True Then";
Debug.ShouldStop(8192);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_showbottom"),asmsgbox.__c.getField(true,"True"))) { 
 BA.debugLineNum = 368;BA.debugLine="xpnl_bottom.Color = bottom_crl";
Debug.ShouldStop(32768);
__ref.getField(false,"_xpnl_bottom").runMethod(true,"setColor",__ref.getField(true,"_bottom_crl"));
 BA.debugLineNum = 370;BA.debugLine="xpnl_bottom.Top = mBase.Height - 50dip";
Debug.ShouldStop(131072);
__ref.getField(false,"_xpnl_bottom").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 50)))}, "-",1, 0));
 BA.debugLineNum = 371;BA.debugLine="xpnl_bottom.Width = mBase.Width";
Debug.ShouldStop(262144);
__ref.getField(false,"_xpnl_bottom").runMethod(true,"setWidth",__ref.getField(false,"_mbase").runMethod(true,"getWidth"));
 BA.debugLineNum = 372;BA.debugLine="xline_2.Width = mBase.Width";
Debug.ShouldStop(524288);
__ref.getField(false,"_xline_2").runMethod(true,"setWidth",__ref.getField(false,"_mbase").runMethod(true,"getWidth"));
 BA.debugLineNum = 376;BA.debugLine="xpnl_actionground.Width = xpnl_bottom.Width - 10";
Debug.ShouldStop(8388608);
__ref.getField(false,"_xpnl_actionground").runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_bottom").runMethod(true,"getWidth"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 10)))}, "-",1, 0));
 BA.debugLineNum = 379;BA.debugLine="xpnl_content.Height = mBase.Height - xpnl_conten";
Debug.ShouldStop(67108864);
__ref.getField(false,"_xpnl_content").runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),__ref.getField(false,"_xpnl_content").runMethod(true,"getTop"),__ref.getField(false,"_xpnl_bottom").runMethod(true,"getHeight")}, "--",2, 0));
 }else {
 BA.debugLineNum = 384;BA.debugLine="xpnl_content.Height = mBase.Height - xpnl_conten";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_xpnl_content").runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),__ref.getField(false,"_xpnl_content").runMethod(true,"getTop")}, "-",1, 0));
 };
 BA.debugLineNum = 388;BA.debugLine="xlbl_action_1.Left = 0";
Debug.ShouldStop(8);
__ref.getField(false,"_xlbl_action_1").runMethod(true,"setLeft",BA.numberCast(double.class, 0));
 BA.debugLineNum = 389;BA.debugLine="xlbl_action_1.Width = xpnl_actionground.Width/3 -";
Debug.ShouldStop(16);
__ref.getField(false,"_xlbl_action_1").runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_actionground").runMethod(true,"getWidth"),RemoteObject.createImmutable(3),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "/-",1, 0));
 BA.debugLineNum = 391;BA.debugLine="xlbl_action_2.Left = xlbl_action_1.Left + xlbl_ac";
Debug.ShouldStop(64);
__ref.getField(false,"_xlbl_action_2").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xlbl_action_1").runMethod(true,"getLeft"),__ref.getField(false,"_xlbl_action_1").runMethod(true,"getWidth"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "++",2, 0));
 BA.debugLineNum = 392;BA.debugLine="xlbl_action_2.Width = xpnl_actionground.Width/3 '";
Debug.ShouldStop(128);
__ref.getField(false,"_xlbl_action_2").runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_actionground").runMethod(true,"getWidth"),RemoteObject.createImmutable(3)}, "/",0, 0));
 BA.debugLineNum = 394;BA.debugLine="xlbl_action_3.Left = xlbl_action_2.Left + xlbl_ac";
Debug.ShouldStop(512);
__ref.getField(false,"_xlbl_action_3").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xlbl_action_2").runMethod(true,"getLeft"),__ref.getField(false,"_xlbl_action_2").runMethod(true,"getWidth"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "++",2, 0));
 BA.debugLineNum = 395;BA.debugLine="xlbl_action_3.Width = xpnl_actionground.Width/3 -";
Debug.ShouldStop(1024);
__ref.getField(false,"_xlbl_action_3").runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_actionground").runMethod(true,"getWidth"),RemoteObject.createImmutable(3),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "/-",1, 0));
 BA.debugLineNum = 397;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _centerdialog(RemoteObject __ref,RemoteObject _parent) throws Exception{
try {
		Debug.PushSubsStack("CenterDialog (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,775);
if (RapidSub.canDelegate("centerdialog")) { return __ref.runUserSub(false, "asmsgbox","centerdialog", __ref, _parent);}
Debug.locals.put("Parent", _parent);
 BA.debugLineNum = 775;BA.debugLine="Public Sub CenterDialog(Parent As B4XView)";
Debug.ShouldStop(64);
 BA.debugLineNum = 777;BA.debugLine="mBase.Left = Parent.Width/2 - mBase.Width/2";
Debug.ShouldStop(256);
__ref.getField(false,"_mbase").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {_parent.runMethod(true,"getWidth"),RemoteObject.createImmutable(2),__ref.getField(false,"_mbase").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/-/",1, 0));
 BA.debugLineNum = 778;BA.debugLine="mBase.Top = 0 + Parent.Height/2  - mBase.Height/2";
Debug.ShouldStop(512);
__ref.getField(false,"_mbase").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(0),_parent.runMethod(true,"getHeight"),RemoteObject.createImmutable(2),__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "+/-/",2, 0));
 BA.debugLineNum = 780;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 41;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 42;BA.debugLine="Private mEventName As String 'ignore";
asmsgbox._meventname = RemoteObject.createImmutable("");__ref.setField("_meventname",asmsgbox._meventname);
 //BA.debugLineNum = 43;BA.debugLine="Private mCallBack As Object 'ignore";
asmsgbox._mcallback = RemoteObject.createNew ("Object");__ref.setField("_mcallback",asmsgbox._mcallback);
 //BA.debugLineNum = 44;BA.debugLine="Private mBase As B4XView 'ignore";
asmsgbox._mbase = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_mbase",asmsgbox._mbase);
 //BA.debugLineNum = 45;BA.debugLine="Private xui As XUI 'ignore";
asmsgbox._xui = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper.XUI");__ref.setField("_xui",asmsgbox._xui);
 //BA.debugLineNum = 49;BA.debugLine="Private back_color As Int";
asmsgbox._back_color = RemoteObject.createImmutable(0);__ref.setField("_back_color",asmsgbox._back_color);
 //BA.debugLineNum = 50;BA.debugLine="Private showX As Boolean";
asmsgbox._showx = RemoteObject.createImmutable(false);__ref.setField("_showx",asmsgbox._showx);
 //BA.debugLineNum = 51;BA.debugLine="Private header_clr As Int";
asmsgbox._header_clr = RemoteObject.createImmutable(0);__ref.setField("_header_clr",asmsgbox._header_clr);
 //BA.debugLineNum = 52;BA.debugLine="Private bottom_crl As Int";
asmsgbox._bottom_crl = RemoteObject.createImmutable(0);__ref.setField("_bottom_crl",asmsgbox._bottom_crl);
 //BA.debugLineNum = 54;BA.debugLine="Private iconVisible As Boolean";
asmsgbox._iconvisible = RemoteObject.createImmutable(false);__ref.setField("_iconvisible",asmsgbox._iconvisible);
 //BA.debugLineNum = 55;BA.debugLine="Private iconDirection As String";
asmsgbox._icondirection = RemoteObject.createImmutable("");__ref.setField("_icondirection",asmsgbox._icondirection);
 //BA.debugLineNum = 56;BA.debugLine="Private border_width As Int";
asmsgbox._border_width = RemoteObject.createImmutable(0);__ref.setField("_border_width",asmsgbox._border_width);
 //BA.debugLineNum = 58;BA.debugLine="Private showHeader As Boolean";
asmsgbox._showheader = RemoteObject.createImmutable(false);__ref.setField("_showheader",asmsgbox._showheader);
 //BA.debugLineNum = 59;BA.debugLine="Private showBottom As Boolean";
asmsgbox._showbottom = RemoteObject.createImmutable(false);__ref.setField("_showbottom",asmsgbox._showbottom);
 //BA.debugLineNum = 61;BA.debugLine="Private headerFontSize As Int";
asmsgbox._headerfontsize = RemoteObject.createImmutable(0);__ref.setField("_headerfontsize",asmsgbox._headerfontsize);
 //BA.debugLineNum = 62;BA.debugLine="Private headerText As String";
asmsgbox._headertext = RemoteObject.createImmutable("");__ref.setField("_headertext",asmsgbox._headertext);
 //BA.debugLineNum = 64;BA.debugLine="Private xpnl_close As B4XView";
asmsgbox._xpnl_close = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_xpnl_close",asmsgbox._xpnl_close);
 //BA.debugLineNum = 66;BA.debugLine="Private xline_1,xline_2 As B4XView";
asmsgbox._xline_1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_xline_1",asmsgbox._xline_1);
asmsgbox._xline_2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_xline_2",asmsgbox._xline_2);
 //BA.debugLineNum = 68;BA.debugLine="Private xIconFont As B4XFont";
asmsgbox._xiconfont = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper.B4XFont");__ref.setField("_xiconfont",asmsgbox._xiconfont);
 //BA.debugLineNum = 70;BA.debugLine="Private fx As JFX";
asmsgbox._fx = RemoteObject.createNew ("anywheresoftware.b4j.objects.JFX");__ref.setField("_fx",asmsgbox._fx);
 //BA.debugLineNum = 74;BA.debugLine="Private lbl_header As Label";
asmsgbox._lbl_header = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");__ref.setField("_lbl_header",asmsgbox._lbl_header);
 //BA.debugLineNum = 75;BA.debugLine="Private xlbl_header As B4XView";
asmsgbox._xlbl_header = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_xlbl_header",asmsgbox._xlbl_header);
 //BA.debugLineNum = 76;BA.debugLine="Private xpnl_header As B4XView";
asmsgbox._xpnl_header = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_xpnl_header",asmsgbox._xpnl_header);
 //BA.debugLineNum = 77;BA.debugLine="Private xpnl_bottom As B4XView";
asmsgbox._xpnl_bottom = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_xpnl_bottom",asmsgbox._xpnl_bottom);
 //BA.debugLineNum = 78;BA.debugLine="Private xiv_icon As B4XView";
asmsgbox._xiv_icon = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_xiv_icon",asmsgbox._xiv_icon);
 //BA.debugLineNum = 79;BA.debugLine="Private xpnl_content As B4XView";
asmsgbox._xpnl_content = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_xpnl_content",asmsgbox._xpnl_content);
 //BA.debugLineNum = 80;BA.debugLine="Private xlbl_action_1,xlbl_action_2,xlbl_action_3";
asmsgbox._xlbl_action_1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_xlbl_action_1",asmsgbox._xlbl_action_1);
asmsgbox._xlbl_action_2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_xlbl_action_2",asmsgbox._xlbl_action_2);
asmsgbox._xlbl_action_3 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_xlbl_action_3",asmsgbox._xlbl_action_3);
 //BA.debugLineNum = 81;BA.debugLine="Private xpnl_actionground As B4XView";
asmsgbox._xpnl_actionground = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_xpnl_actionground",asmsgbox._xpnl_actionground);
 //BA.debugLineNum = 82;BA.debugLine="Private xlbl_text As B4XView";
asmsgbox._xlbl_text = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_xlbl_text",asmsgbox._xlbl_text);
 //BA.debugLineNum = 85;BA.debugLine="Private dragable As Int = 0";
asmsgbox._dragable = BA.numberCast(int.class, 0);__ref.setField("_dragable",asmsgbox._dragable);
 //BA.debugLineNum = 86;BA.debugLine="Private donwx As Int";
asmsgbox._donwx = RemoteObject.createImmutable(0);__ref.setField("_donwx",asmsgbox._donwx);
 //BA.debugLineNum = 87;BA.debugLine="Private downy As Int";
asmsgbox._downy = RemoteObject.createImmutable(0);__ref.setField("_downy",asmsgbox._downy);
 //BA.debugLineNum = 93;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _close(RemoteObject __ref,RemoteObject _animated) throws Exception{
try {
		Debug.PushSubsStack("Close (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,275);
if (RapidSub.canDelegate("close")) { return __ref.runUserSub(false, "asmsgbox","close", __ref, _animated);}
ResumableSub_Close rsub = new ResumableSub_Close(null,__ref,_animated);
rsub.remoteResumableSub = anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSubForFilter();
rsub.resume(null, null);
return RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.keywords.Common.ResumableSubWrapper"), rsub.remoteResumableSub);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_Close extends BA.ResumableSub {
public ResumableSub_Close(b4j.example.asmsgbox parent,RemoteObject __ref,RemoteObject _animated) {
this.parent = parent;
this.__ref = __ref;
this._animated = _animated;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.asmsgbox parent;
RemoteObject _animated;

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("Close (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,275);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
{
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,RemoteObject.createImmutable(null));return;}
case 0:
//C
this.state = 1;
Debug.locals.put("_ref", __ref);
Debug.locals.put("animated", _animated);
 BA.debugLineNum = 277;BA.debugLine="If mBase.IsInitialized And mBase.Parent.IsInitial";
Debug.ShouldStop(1048576);
if (true) break;

case 1:
//if
this.state = 10;
if (RemoteObject.solveBoolean(".",__ref.getField(false,"_mbase").runMethod(true,"IsInitialized")) && RemoteObject.solveBoolean(".",__ref.getField(false,"_mbase").runMethod(false,"getParent").runMethod(true,"IsInitialized"))) { 
this.state = 3;
}if (true) break;

case 3:
//C
this.state = 4;
 BA.debugLineNum = 278;BA.debugLine="If animated = True Then";
Debug.ShouldStop(2097152);
if (true) break;

case 4:
//if
this.state = 9;
if (RemoteObject.solveBoolean("=",_animated,parent.__c.getField(true,"True"))) { 
this.state = 6;
}else 
{ BA.debugLineNum = 280;BA.debugLine="Else If animated = False Then";
Debug.ShouldStop(8388608);
if (RemoteObject.solveBoolean("=",_animated,parent.__c.getField(true,"False"))) { 
this.state = 8;
}}
if (true) break;

case 6:
//C
this.state = 9;
 BA.debugLineNum = 279;BA.debugLine="mBase.SetVisibleAnimated(300,False)";
Debug.ShouldStop(4194304);
__ref.getField(false,"_mbase").runVoidMethod ("SetVisibleAnimated",__ref.getField(false, "ba"),(Object)(BA.numberCast(int.class, 300)),(Object)(parent.__c.getField(true,"False")));
 if (true) break;

case 8:
//C
this.state = 9;
 BA.debugLineNum = 281;BA.debugLine="mBase.Visible = False";
Debug.ShouldStop(16777216);
__ref.getField(false,"_mbase").runMethod(true,"setVisible",parent.__c.getField(true,"False"));
 if (true) break;

case 9:
//C
this.state = 10;
;
 BA.debugLineNum = 284;BA.debugLine="Return True";
Debug.ShouldStop(134217728);
if (true) {
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,(parent.__c.getField(true,"True")));return;};
 if (true) break;

case 10:
//C
this.state = -1;
;
 BA.debugLineNum = 286;BA.debugLine="Return False";
Debug.ShouldStop(536870912);
if (true) {
parent.__c.runVoidMethod ("ReturnFromResumableSub",this.remoteResumableSub,(parent.__c.getField(true,"False")));return;};
 BA.debugLineNum = 288;BA.debugLine="End Sub";
Debug.ShouldStop(-2147483648);
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
public static RemoteObject  _closebutton_handler(RemoteObject __ref,RemoteObject _senderpanel) throws Exception{
try {
		Debug.PushSubsStack("closebutton_handler (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,863);
if (RapidSub.canDelegate("closebutton_handler")) { return __ref.runUserSub(false, "asmsgbox","closebutton_handler", __ref, _senderpanel);}
Debug.locals.put("SenderPanel", _senderpanel);
 BA.debugLineNum = 863;BA.debugLine="Private Sub closebutton_handler(SenderPanel As B4X";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 865;BA.debugLine="mBase.Visible = False";
Debug.ShouldStop(1);
__ref.getField(false,"_mbase").runMethod(true,"setVisible",asmsgbox.__c.getField(true,"False"));
 BA.debugLineNum = 867;BA.debugLine="End Sub";
Debug.ShouldStop(4);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _create_bottom(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("create_bottom (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,465);
if (RapidSub.canDelegate("create_bottom")) { return __ref.runUserSub(false, "asmsgbox","create_bottom", __ref);}
RemoteObject _lbl_action_1 = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
RemoteObject _lbl_action_2 = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
RemoteObject _lbl_action_3 = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
 BA.debugLineNum = 465;BA.debugLine="Private Sub create_bottom";
Debug.ShouldStop(65536);
 BA.debugLineNum = 468;BA.debugLine="xpnl_bottom = xui.CreatePanel(\"\")";
Debug.ShouldStop(524288);
__ref.setField ("_xpnl_bottom",__ref.getField(false,"_xui").runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable(""))));
 BA.debugLineNum = 469;BA.debugLine="mBase.AddView(xpnl_bottom,0,mBase.Height - 50dip,";
Debug.ShouldStop(1048576);
__ref.getField(false,"_mbase").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_xpnl_bottom").getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 50)))}, "-",1, 0)),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getWidth")),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 50))))));
 BA.debugLineNum = 470;BA.debugLine="xpnl_bottom.Color = xui.Color_Red";
Debug.ShouldStop(2097152);
__ref.getField(false,"_xpnl_bottom").runMethod(true,"setColor",__ref.getField(false,"_xui").getField(true,"Color_Red"));
 BA.debugLineNum = 471;BA.debugLine="xpnl_bottom.SetColorAndBorder(xui.Color_Red,0,xui";
Debug.ShouldStop(4194304);
__ref.getField(false,"_xpnl_bottom").runVoidMethod ("SetColorAndBorder",(Object)(__ref.getField(false,"_xui").getField(true,"Color_Red")),(Object)(BA.numberCast(double.class, 0)),(Object)(__ref.getField(false,"_xui").getField(true,"Color_Transparent")),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))))));
 BA.debugLineNum = 474;BA.debugLine="xline_2 = xui.CreatePanel(\"\")";
Debug.ShouldStop(33554432);
__ref.setField ("_xline_2",__ref.getField(false,"_xui").runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable(""))));
 BA.debugLineNum = 475;BA.debugLine="xpnl_bottom.AddView(xline_2,0dip,0dip,xpnl_bottom";
Debug.ShouldStop(67108864);
__ref.getField(false,"_xpnl_bottom").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_xline_2").getObject())),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 0))))),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 0))))),(Object)(__ref.getField(false,"_xpnl_bottom").runMethod(true,"getWidth")),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 2))))));
 BA.debugLineNum = 476;BA.debugLine="xline_2.Color = xui.Color_White";
Debug.ShouldStop(134217728);
__ref.getField(false,"_xline_2").runMethod(true,"setColor",__ref.getField(false,"_xui").getField(true,"Color_White"));
 BA.debugLineNum = 477;BA.debugLine="MakeViewBackgroundTransparent(xline_2,100)";
Debug.ShouldStop(268435456);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_makeviewbackgroundtransparent",(Object)(__ref.getField(false,"_xline_2")),(Object)(BA.numberCast(int.class, 100)));
 BA.debugLineNum = 481;BA.debugLine="xpnl_actionground = xui.CreatePanel(\"\")";
Debug.ShouldStop(1);
__ref.setField ("_xpnl_actionground",__ref.getField(false,"_xui").runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable(""))));
 BA.debugLineNum = 482;BA.debugLine="xpnl_bottom.AddView(xpnl_actionground,5dip,5dip,x";
Debug.ShouldStop(2);
__ref.getField(false,"_xpnl_bottom").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_xpnl_actionground").getObject())),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))))),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_bottom").runMethod(true,"getWidth"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "-",1, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_bottom").runMethod(true,"getHeight"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 10)))}, "-",1, 0)));
 BA.debugLineNum = 486;BA.debugLine="Dim lbl_action_1,lbl_action_2,lbl_action_3 As Lab";
Debug.ShouldStop(32);
_lbl_action_1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("lbl_action_1", _lbl_action_1);
_lbl_action_2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("lbl_action_2", _lbl_action_2);
_lbl_action_3 = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("lbl_action_3", _lbl_action_3);
 BA.debugLineNum = 487;BA.debugLine="lbl_action_1.Initialize(\"xlbl_action_1\")";
Debug.ShouldStop(64);
_lbl_action_1.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("xlbl_action_1")));
 BA.debugLineNum = 488;BA.debugLine="lbl_action_2.Initialize(\"xlbl_action_2\")";
Debug.ShouldStop(128);
_lbl_action_2.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("xlbl_action_2")));
 BA.debugLineNum = 489;BA.debugLine="lbl_action_3.Initialize(\"xlbl_action_3\")";
Debug.ShouldStop(256);
_lbl_action_3.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("xlbl_action_3")));
 BA.debugLineNum = 491;BA.debugLine="xlbl_action_1 = lbl_action_1";
Debug.ShouldStop(1024);
__ref.getField(false,"_xlbl_action_1").setObject (_lbl_action_1.getObject());
 BA.debugLineNum = 492;BA.debugLine="xlbl_action_2 = lbl_action_2";
Debug.ShouldStop(2048);
__ref.getField(false,"_xlbl_action_2").setObject (_lbl_action_2.getObject());
 BA.debugLineNum = 493;BA.debugLine="xlbl_action_3 = lbl_action_3";
Debug.ShouldStop(4096);
__ref.getField(false,"_xlbl_action_3").setObject (_lbl_action_3.getObject());
 BA.debugLineNum = 495;BA.debugLine="xlbl_action_1.Tag = getCANCEL";
Debug.ShouldStop(16384);
__ref.getField(false,"_xlbl_action_1").runMethod(false,"setTag",(__ref.runClassMethod (b4j.example.asmsgbox.class, "_getcancel")));
 BA.debugLineNum = 496;BA.debugLine="xlbl_action_2.Tag = getNEGATIVE";
Debug.ShouldStop(32768);
__ref.getField(false,"_xlbl_action_2").runMethod(false,"setTag",(__ref.runClassMethod (b4j.example.asmsgbox.class, "_getnegative")));
 BA.debugLineNum = 497;BA.debugLine="xlbl_action_3.Tag = getPOSITIVE";
Debug.ShouldStop(65536);
__ref.getField(false,"_xlbl_action_3").runMethod(false,"setTag",(__ref.runClassMethod (b4j.example.asmsgbox.class, "_getpositive")));
 BA.debugLineNum = 499;BA.debugLine="xpnl_actionground.AddView(xlbl_action_1,0,0,0 ,xp";
Debug.ShouldStop(262144);
__ref.getField(false,"_xpnl_actionground").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_xlbl_action_1").getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(__ref.getField(false,"_xpnl_actionground").runMethod(true,"getHeight")));
 BA.debugLineNum = 500;BA.debugLine="xpnl_actionground.AddView(xlbl_action_2,xlbl_acti";
Debug.ShouldStop(524288);
__ref.getField(false,"_xpnl_actionground").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_xlbl_action_2").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xlbl_action_1").runMethod(true,"getLeft"),__ref.getField(false,"_xlbl_action_1").runMethod(true,"getWidth"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "++",2, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(__ref.getField(false,"_xpnl_actionground").runMethod(true,"getHeight")));
 BA.debugLineNum = 501;BA.debugLine="xpnl_actionground.AddView(xlbl_action_3,xlbl_acti";
Debug.ShouldStop(1048576);
__ref.getField(false,"_xpnl_actionground").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_xlbl_action_3").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xlbl_action_2").runMethod(true,"getLeft"),__ref.getField(false,"_xlbl_action_2").runMethod(true,"getWidth"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "++",2, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(__ref.getField(false,"_xpnl_actionground").runMethod(true,"getHeight")));
 BA.debugLineNum = 503;BA.debugLine="xlbl_action_1.Font = xui.CreateDefaultBoldFont(15";
Debug.ShouldStop(4194304);
__ref.getField(false,"_xlbl_action_1").runMethod(false,"setFont",__ref.getField(false,"_xui").runMethod(false,"CreateDefaultBoldFont",(Object)(BA.numberCast(float.class, 15))));
 BA.debugLineNum = 504;BA.debugLine="xlbl_action_2.Font = xui.CreateDefaultBoldFont(15";
Debug.ShouldStop(8388608);
__ref.getField(false,"_xlbl_action_2").runMethod(false,"setFont",__ref.getField(false,"_xui").runMethod(false,"CreateDefaultBoldFont",(Object)(BA.numberCast(float.class, 15))));
 BA.debugLineNum = 505;BA.debugLine="xlbl_action_3.Font = xui.CreateDefaultBoldFont(15";
Debug.ShouldStop(16777216);
__ref.getField(false,"_xlbl_action_3").runMethod(false,"setFont",__ref.getField(false,"_xui").runMethod(false,"CreateDefaultBoldFont",(Object)(BA.numberCast(float.class, 15))));
 BA.debugLineNum = 507;BA.debugLine="xlbl_action_1.TextColor = xui.Color_White";
Debug.ShouldStop(67108864);
__ref.getField(false,"_xlbl_action_1").runMethod(true,"setTextColor",__ref.getField(false,"_xui").getField(true,"Color_White"));
 BA.debugLineNum = 508;BA.debugLine="xlbl_action_2.TextColor = xui.Color_White";
Debug.ShouldStop(134217728);
__ref.getField(false,"_xlbl_action_2").runMethod(true,"setTextColor",__ref.getField(false,"_xui").getField(true,"Color_White"));
 BA.debugLineNum = 509;BA.debugLine="xlbl_action_3.TextColor = xui.Color_White";
Debug.ShouldStop(268435456);
__ref.getField(false,"_xlbl_action_3").runMethod(true,"setTextColor",__ref.getField(false,"_xui").getField(true,"Color_White"));
 BA.debugLineNum = 511;BA.debugLine="xlbl_action_1.SetTextAlignment(\"CENTER\",\"CENTER\")";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_xlbl_action_1").runVoidMethod ("SetTextAlignment",(Object)(BA.ObjectToString("CENTER")),(Object)(RemoteObject.createImmutable("CENTER")));
 BA.debugLineNum = 512;BA.debugLine="xlbl_action_2.SetTextAlignment(\"CENTER\",\"CENTER\")";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_xlbl_action_2").runVoidMethod ("SetTextAlignment",(Object)(BA.ObjectToString("CENTER")),(Object)(RemoteObject.createImmutable("CENTER")));
 BA.debugLineNum = 513;BA.debugLine="xlbl_action_3.SetTextAlignment(\"CENTER\",\"CENTER\")";
Debug.ShouldStop(1);
__ref.getField(false,"_xlbl_action_3").runVoidMethod ("SetTextAlignment",(Object)(BA.ObjectToString("CENTER")),(Object)(RemoteObject.createImmutable("CENTER")));
 BA.debugLineNum = 515;BA.debugLine="End Sub";
Debug.ShouldStop(4);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _create_top(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("create_top (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,402);
if (RapidSub.canDelegate("create_top")) { return __ref.runUserSub(false, "asmsgbox","create_top", __ref);}
RemoteObject _lbl_close = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
RemoteObject _iv_icon = RemoteObject.declareNull("anywheresoftware.b4j.objects.ImageViewWrapper");
 BA.debugLineNum = 402;BA.debugLine="Private Sub create_top";
Debug.ShouldStop(131072);
 BA.debugLineNum = 405;BA.debugLine="xpnl_header = xui.CreatePanel(\"xpnl_header\")";
Debug.ShouldStop(1048576);
__ref.setField ("_xpnl_header",__ref.getField(false,"_xui").runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("xpnl_header"))));
 BA.debugLineNum = 406;BA.debugLine="mBase.AddView(xpnl_header,0,0,mBase.Width,60dip)";
Debug.ShouldStop(2097152);
__ref.getField(false,"_mbase").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_xpnl_header").getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getWidth")),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 60))))));
 BA.debugLineNum = 407;BA.debugLine="xpnl_header.Color = xui.Color_Red";
Debug.ShouldStop(4194304);
__ref.getField(false,"_xpnl_header").runMethod(true,"setColor",__ref.getField(false,"_xui").getField(true,"Color_Red"));
 BA.debugLineNum = 408;BA.debugLine="xpnl_header.SetColorAndBorder(xui.Color_Red,0,xui";
Debug.ShouldStop(8388608);
__ref.getField(false,"_xpnl_header").runVoidMethod ("SetColorAndBorder",(Object)(__ref.getField(false,"_xui").getField(true,"Color_Red")),(Object)(BA.numberCast(double.class, 0)),(Object)(__ref.getField(false,"_xui").getField(true,"Color_Transparent")),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))))));
 BA.debugLineNum = 418;BA.debugLine="xline_1 = xui.CreatePanel(\"\")";
Debug.ShouldStop(2);
__ref.setField ("_xline_1",__ref.getField(false,"_xui").runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable(""))));
 BA.debugLineNum = 419;BA.debugLine="xpnl_header.AddView(xline_1,0dip,xpnl_header.Heig";
Debug.ShouldStop(4);
__ref.getField(false,"_xpnl_header").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_xline_1").getObject())),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 0))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_header").runMethod(true,"getHeight"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 2)))}, "-",1, 0)),(Object)(__ref.getField(false,"_xpnl_header").runMethod(true,"getWidth")),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 2))))));
 BA.debugLineNum = 420;BA.debugLine="xline_1.Color = xui.Color_White";
Debug.ShouldStop(8);
__ref.getField(false,"_xline_1").runMethod(true,"setColor",__ref.getField(false,"_xui").getField(true,"Color_White"));
 BA.debugLineNum = 421;BA.debugLine="MakeViewBackgroundTransparent(xline_1,100)";
Debug.ShouldStop(16);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_makeviewbackgroundtransparent",(Object)(__ref.getField(false,"_xline_1")),(Object)(BA.numberCast(int.class, 100)));
 BA.debugLineNum = 424;BA.debugLine="Private lbl_close As Label";
Debug.ShouldStop(128);
_lbl_close = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("lbl_close", _lbl_close);
 BA.debugLineNum = 425;BA.debugLine="lbl_close.Initialize(\"xpnl_close\")";
Debug.ShouldStop(256);
_lbl_close.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("xpnl_close")));
 BA.debugLineNum = 426;BA.debugLine="xpnl_close = lbl_close";
Debug.ShouldStop(512);
__ref.getField(false,"_xpnl_close").setObject (_lbl_close.getObject());
 BA.debugLineNum = 427;BA.debugLine="mBase.AddView(xpnl_close, mBase.Width - 5dip - 20";
Debug.ShouldStop(1024);
__ref.getField(false,"_mbase").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_xpnl_close").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getWidth"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 20)))}, "--",2, 0)),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 2))))),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 20))))),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 20))))));
 BA.debugLineNum = 435;BA.debugLine="xIconFont = fx.CreateFontAwesome(25)";
Debug.ShouldStop(262144);
__ref.getField(false,"_xiconfont").setObject (__ref.getField(false,"_fx").runMethod(false,"CreateFontAwesome",(Object)(BA.numberCast(double.class, 25))).getObject());
 BA.debugLineNum = 440;BA.debugLine="xpnl_close.Font = xIconFont";
Debug.ShouldStop(8388608);
__ref.getField(false,"_xpnl_close").runMethod(false,"setFont",__ref.getField(false,"_xiconfont"));
 BA.debugLineNum = 441;BA.debugLine="xpnl_close.TextColor = xui.Color_White";
Debug.ShouldStop(16777216);
__ref.getField(false,"_xpnl_close").runMethod(true,"setTextColor",__ref.getField(false,"_xui").getField(true,"Color_White"));
 BA.debugLineNum = 442;BA.debugLine="xpnl_close.Text = Chr(0xF00D)";
Debug.ShouldStop(33554432);
__ref.getField(false,"_xpnl_close").runMethod(true,"setText",BA.ObjectToString(asmsgbox.__c.runMethod(true,"Chr",(Object)(BA.numberCast(int.class, 0xf00d)))));
 BA.debugLineNum = 446;BA.debugLine="Private iv_icon As ImageView";
Debug.ShouldStop(536870912);
_iv_icon = RemoteObject.createNew ("anywheresoftware.b4j.objects.ImageViewWrapper");Debug.locals.put("iv_icon", _iv_icon);
 BA.debugLineNum = 447;BA.debugLine="iv_icon.Initialize(\"xiv_icon\")";
Debug.ShouldStop(1073741824);
_iv_icon.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("xiv_icon")));
 BA.debugLineNum = 449;BA.debugLine="xiv_icon = iv_icon";
Debug.ShouldStop(1);
__ref.getField(false,"_xiv_icon").setObject (_iv_icon.getObject());
 BA.debugLineNum = 450;BA.debugLine="xpnl_header.AddView(xiv_icon,5dip,0,40dip,40dip)";
Debug.ShouldStop(2);
__ref.getField(false,"_xpnl_header").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_xiv_icon").getObject())),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))))),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 40))))),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 40))))));
 BA.debugLineNum = 454;BA.debugLine="lbl_header.Initialize(\"\")";
Debug.ShouldStop(32);
__ref.getField(false,"_lbl_header").runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 455;BA.debugLine="xlbl_header = lbl_header";
Debug.ShouldStop(64);
__ref.getField(false,"_xlbl_header").setObject (__ref.getField(false,"_lbl_header").getObject());
 BA.debugLineNum = 457;BA.debugLine="xpnl_header.AddView(xlbl_header,5dip,5dip,xpnl_he";
Debug.ShouldStop(256);
__ref.getField(false,"_xpnl_header").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_xlbl_header").getObject())),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))))),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_header").runMethod(true,"getWidth"),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "-",1, 0)),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 20))))));
 BA.debugLineNum = 458;BA.debugLine="xlbl_header.TextColor = xui.Color_White";
Debug.ShouldStop(512);
__ref.getField(false,"_xlbl_header").runMethod(true,"setTextColor",__ref.getField(false,"_xui").getField(true,"Color_White"));
 BA.debugLineNum = 459;BA.debugLine="xlbl_header.Font = xui.CreateDefaultBoldFont(head";
Debug.ShouldStop(1024);
__ref.getField(false,"_xlbl_header").runMethod(false,"setFont",__ref.getField(false,"_xui").runMethod(false,"CreateDefaultBoldFont",(Object)(BA.numberCast(float.class, __ref.getField(true,"_headerfontsize")))));
 BA.debugLineNum = 460;BA.debugLine="xlbl_header.SetTextAlignment(\"CENTER\",\"CENTER\")";
Debug.ShouldStop(2048);
__ref.getField(false,"_xlbl_header").runVoidMethod ("SetTextAlignment",(Object)(BA.ObjectToString("CENTER")),(Object)(RemoteObject.createImmutable("CENTER")));
 BA.debugLineNum = 461;BA.debugLine="xlbl_header.Text = headerText";
Debug.ShouldStop(4096);
__ref.getField(false,"_xlbl_header").runMethod(true,"setText",__ref.getField(true,"_headertext"));
 BA.debugLineNum = 463;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createroundbitmap(RemoteObject __ref,RemoteObject _input,RemoteObject _size) throws Exception{
try {
		Debug.PushSubsStack("CreateRoundBitmap (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,1003);
if (RapidSub.canDelegate("createroundbitmap")) { return __ref.runUserSub(false, "asmsgbox","createroundbitmap", __ref, _input, _size);}
RemoteObject _l = RemoteObject.createImmutable(0);
RemoteObject _c = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XCanvas");
RemoteObject _xview = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
RemoteObject _path = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XCanvas.B4XPath");
RemoteObject _res = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper");
Debug.locals.put("Input", _input);
Debug.locals.put("Size", _size);
 BA.debugLineNum = 1003;BA.debugLine="Sub CreateRoundBitmap (Input As B4XBitmap, Size As";
Debug.ShouldStop(1024);
 BA.debugLineNum = 1004;BA.debugLine="If Input.Width <> Input.Height Then";
Debug.ShouldStop(2048);
if (RemoteObject.solveBoolean("!",_input.runMethod(true,"getWidth"),_input.runMethod(true,"getHeight"))) { 
 BA.debugLineNum = 1006;BA.debugLine="Dim l As Int = Min(Input.Width, Input.Height)";
Debug.ShouldStop(8192);
_l = BA.numberCast(int.class, asmsgbox.__c.runMethod(true,"Min",(Object)(_input.runMethod(true,"getWidth")),(Object)(_input.runMethod(true,"getHeight"))));Debug.locals.put("l", _l);Debug.locals.put("l", _l);
 BA.debugLineNum = 1007;BA.debugLine="Input = Input.Crop(Input.Width / 2 - l / 2, Inpu";
Debug.ShouldStop(16384);
_input = _input.runMethod(false,"Crop",(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_input.runMethod(true,"getWidth"),RemoteObject.createImmutable(2),_l,RemoteObject.createImmutable(2)}, "/-/",1, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_input.runMethod(true,"getHeight"),RemoteObject.createImmutable(2),_l,RemoteObject.createImmutable(2)}, "/-/",1, 0))),(Object)(_l),(Object)(_l));Debug.locals.put("Input", _input);
 };
 BA.debugLineNum = 1009;BA.debugLine="Dim c As B4XCanvas";
Debug.ShouldStop(65536);
_c = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XCanvas");Debug.locals.put("c", _c);
 BA.debugLineNum = 1010;BA.debugLine="Dim xview As B4XView = xui.CreatePanel(\"\")";
Debug.ShouldStop(131072);
_xview = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");
_xview = __ref.getField(false,"_xui").runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));Debug.locals.put("xview", _xview);Debug.locals.put("xview", _xview);
 BA.debugLineNum = 1011;BA.debugLine="xview.SetLayoutAnimated(0, 0, 0, Size, Size)";
Debug.ShouldStop(262144);
_xview.runVoidMethod ("SetLayoutAnimated",(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, _size)),(Object)(BA.numberCast(double.class, _size)));
 BA.debugLineNum = 1012;BA.debugLine="c.Initialize(xview)";
Debug.ShouldStop(524288);
_c.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(_xview));
 BA.debugLineNum = 1013;BA.debugLine="Dim path As B4XPath";
Debug.ShouldStop(1048576);
_path = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XCanvas.B4XPath");Debug.locals.put("path", _path);
 BA.debugLineNum = 1014;BA.debugLine="path.InitializeOval(c.TargetRect)";
Debug.ShouldStop(2097152);
_path.runVoidMethod ("InitializeOval",(Object)(_c.runMethod(false,"getTargetRect")));
 BA.debugLineNum = 1015;BA.debugLine="c.ClipPath(path)";
Debug.ShouldStop(4194304);
_c.runVoidMethod ("ClipPath",(Object)(_path));
 BA.debugLineNum = 1016;BA.debugLine="c.DrawBitmap(Input.Resize(Size, Size, False), c.T";
Debug.ShouldStop(8388608);
_c.runVoidMethod ("DrawBitmap",(Object)((_input.runMethod(false,"Resize",(Object)(_size),(Object)(_size),(Object)(asmsgbox.__c.getField(true,"False"))).getObject())),(Object)(_c.runMethod(false,"getTargetRect")));
 BA.debugLineNum = 1017;BA.debugLine="c.RemoveClip";
Debug.ShouldStop(16777216);
_c.runVoidMethod ("RemoveClip");
 BA.debugLineNum = 1019;BA.debugLine="If border_width > 0 Then";
Debug.ShouldStop(67108864);
if (RemoteObject.solveBoolean(">",__ref.getField(true,"_border_width"),BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 1020;BA.debugLine="c.DrawCircle(c.TargetRect.CenterX, c.TargetRect.C";
Debug.ShouldStop(134217728);
_c.runVoidMethod ("DrawCircle",(Object)(_c.runMethod(false,"getTargetRect").runMethod(true,"getCenterX")),(Object)(_c.runMethod(false,"getTargetRect").runMethod(true,"getCenterY")),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_c.runMethod(false,"getTargetRect").runMethod(true,"getWidth"),RemoteObject.createImmutable(2),asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 2)))}, "/-",1, 0))),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White")),(Object)(asmsgbox.__c.getField(true,"False")),(Object)(BA.numberCast(float.class, __ref.getField(true,"_border_width"))));
 };
 BA.debugLineNum = 1022;BA.debugLine="c.Invalidate";
Debug.ShouldStop(536870912);
_c.runVoidMethod ("Invalidate");
 BA.debugLineNum = 1023;BA.debugLine="Dim res As B4XBitmap = c.CreateBitmap";
Debug.ShouldStop(1073741824);
_res = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper");
_res = _c.runMethod(false,"CreateBitmap");Debug.locals.put("res", _res);Debug.locals.put("res", _res);
 BA.debugLineNum = 1024;BA.debugLine="c.Release";
Debug.ShouldStop(-2147483648);
_c.runVoidMethod ("Release");
 BA.debugLineNum = 1025;BA.debugLine="Return res";
Debug.ShouldStop(1);
if (true) return _res;
 BA.debugLineNum = 1026;BA.debugLine="End Sub";
Debug.ShouldStop(2);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _designercreateview(RemoteObject __ref,RemoteObject _base,RemoteObject _lbl,RemoteObject _props) throws Exception{
try {
		Debug.PushSubsStack("DesignerCreateView (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,192);
if (RapidSub.canDelegate("designercreateview")) { return __ref.runUserSub(false, "asmsgbox","designercreateview", __ref, _base, _lbl, _props);}
RemoteObject _lbl_text = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
Debug.locals.put("Base", _base);
Debug.locals.put("lbl", _lbl);
Debug.locals.put("Props", _props);
 BA.debugLineNum = 192;BA.debugLine="Public Sub DesignerCreateView (Base As Object, lbl";
Debug.ShouldStop(-2147483648);
 BA.debugLineNum = 193;BA.debugLine="mBase = Base";
Debug.ShouldStop(1);
__ref.getField(false,"_mbase").setObject (_base);
 BA.debugLineNum = 195;BA.debugLine="back_color = xui.PaintOrColorToColor(Props.Get(";
Debug.ShouldStop(4);
__ref.setField ("_back_color",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("Back_Color")))))));
 BA.debugLineNum = 196;BA.debugLine="showX = Props.Get(\"Show_X\")";
Debug.ShouldStop(8);
__ref.setField ("_showx",BA.ObjectToBoolean(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("Show_X"))))));
 BA.debugLineNum = 197;BA.debugLine="header_clr = xui.PaintOrColorToColor(Props.Get(\"H";
Debug.ShouldStop(16);
__ref.setField ("_header_clr",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("Header_CLR")))))));
 BA.debugLineNum = 198;BA.debugLine="bottom_crl = xui.PaintOrColorToColor(Props.Get(\"B";
Debug.ShouldStop(32);
__ref.setField ("_bottom_crl",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("Bottom_CLR")))))));
 BA.debugLineNum = 200;BA.debugLine="iconVisible = Props.Get(\"Icon_visible\")";
Debug.ShouldStop(128);
__ref.setField ("_iconvisible",BA.ObjectToBoolean(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("Icon_visible"))))));
 BA.debugLineNum = 201;BA.debugLine="iconDirection = Props.Get(\"Icon_direction\")";
Debug.ShouldStop(256);
__ref.setField ("_icondirection",BA.ObjectToString(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("Icon_direction"))))));
 BA.debugLineNum = 202;BA.debugLine="border_width = DipToCurrent(Props.Get(\"BorderWidt";
Debug.ShouldStop(512);
__ref.setField ("_border_width",asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, _props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("BorderWidth"))))))));
 BA.debugLineNum = 204;BA.debugLine="showHeader = Props.Get(\"show_header\")";
Debug.ShouldStop(2048);
__ref.setField ("_showheader",BA.ObjectToBoolean(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("show_header"))))));
 BA.debugLineNum = 205;BA.debugLine="showBottom = Props.Get(\"show_bottom\")";
Debug.ShouldStop(4096);
__ref.setField ("_showbottom",BA.ObjectToBoolean(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("show_bottom"))))));
 BA.debugLineNum = 207;BA.debugLine="headerFontSize = Props.Get(\"header_font_size\")";
Debug.ShouldStop(16384);
__ref.setField ("_headerfontsize",BA.numberCast(int.class, _props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("header_font_size"))))));
 BA.debugLineNum = 209;BA.debugLine="headerText = Props.Get(\"Header_Text\")";
Debug.ShouldStop(65536);
__ref.setField ("_headertext",BA.ObjectToString(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("Header_Text"))))));
 BA.debugLineNum = 211;BA.debugLine="create_top";
Debug.ShouldStop(262144);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_create_top");
 BA.debugLineNum = 212;BA.debugLine="create_bottom";
Debug.ShouldStop(524288);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_create_bottom");
 BA.debugLineNum = 214;BA.debugLine="xpnl_content = xui.CreatePanel(\"xpnl_content\")";
Debug.ShouldStop(2097152);
__ref.setField ("_xpnl_content",__ref.getField(false,"_xui").runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("xpnl_content"))));
 BA.debugLineNum = 215;BA.debugLine="mBase.AddView(xpnl_content,0,xpnl_header.Height,m";
Debug.ShouldStop(4194304);
__ref.getField(false,"_mbase").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_xpnl_content").getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(__ref.getField(false,"_xpnl_header").runMethod(true,"getHeight")),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getWidth")),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_bottom").runMethod(true,"getTop"),__ref.getField(false,"_xpnl_header").runMethod(true,"getHeight")}, "-",1, 0)));
 BA.debugLineNum = 216;BA.debugLine="xpnl_content.Color = xui.Color_Transparent";
Debug.ShouldStop(8388608);
__ref.getField(false,"_xpnl_content").runMethod(true,"setColor",__ref.getField(false,"_xui").getField(true,"Color_Transparent"));
 BA.debugLineNum = 225;BA.debugLine="Dim lbl_text As Label";
Debug.ShouldStop(1);
_lbl_text = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("lbl_text", _lbl_text);
 BA.debugLineNum = 226;BA.debugLine="lbl_text.Initialize(\"\")";
Debug.ShouldStop(2);
_lbl_text.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 228;BA.debugLine="xlbl_text = lbl_text";
Debug.ShouldStop(8);
__ref.getField(false,"_xlbl_text").setObject (_lbl_text.getObject());
 BA.debugLineNum = 229;BA.debugLine="xlbl_text.TextColor = xui.Color_White";
Debug.ShouldStop(16);
__ref.getField(false,"_xlbl_text").runMethod(true,"setTextColor",__ref.getField(false,"_xui").getField(true,"Color_White"));
 BA.debugLineNum = 230;BA.debugLine="xlbl_text.Font = xui.CreateDefaultBoldFont(20)";
Debug.ShouldStop(32);
__ref.getField(false,"_xlbl_text").runMethod(false,"setFont",__ref.getField(false,"_xui").runMethod(false,"CreateDefaultBoldFont",(Object)(BA.numberCast(float.class, 20))));
 BA.debugLineNum = 231;BA.debugLine="xlbl_text.SetTextAlignment(\"CENTER\",\"CENTER\")";
Debug.ShouldStop(64);
__ref.getField(false,"_xlbl_text").runVoidMethod ("SetTextAlignment",(Object)(BA.ObjectToString("CENTER")),(Object)(RemoteObject.createImmutable("CENTER")));
 BA.debugLineNum = 233;BA.debugLine="mBase.AddView(xlbl_text,0,xpnl_header.Height,mBas";
Debug.ShouldStop(256);
__ref.getField(false,"_mbase").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_xlbl_text").getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(__ref.getField(false,"_xpnl_header").runMethod(true,"getHeight")),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getWidth")),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_xpnl_bottom").runMethod(true,"getTop"),__ref.getField(false,"_xpnl_header").runMethod(true,"getHeight")}, "-",1, 0)));
 BA.debugLineNum = 235;BA.debugLine="xlbl_text.Visible = False";
Debug.ShouldStop(1024);
__ref.getField(false,"_xlbl_text").runMethod(true,"setVisible",asmsgbox.__c.getField(true,"False"));
 BA.debugLineNum = 243;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getbase(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getBase (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,185);
if (RapidSub.canDelegate("getbase")) { return __ref.runUserSub(false, "asmsgbox","getbase", __ref);}
 BA.debugLineNum = 185;BA.debugLine="Public Sub getBase As B4XView";
Debug.ShouldStop(16777216);
 BA.debugLineNum = 187;BA.debugLine="Return mBase";
Debug.ShouldStop(67108864);
if (true) return __ref.getField(false,"_mbase");
 BA.debugLineNum = 189;BA.debugLine="End Sub";
Debug.ShouldStop(268435456);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getbottomcolor(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getBottomColor (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,823);
if (RapidSub.canDelegate("getbottomcolor")) { return __ref.runUserSub(false, "asmsgbox","getbottomcolor", __ref);}
 BA.debugLineNum = 823;BA.debugLine="Public Sub getBottomColor As Int";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 825;BA.debugLine="Return xpnl_bottom.Color";
Debug.ShouldStop(16777216);
if (true) return __ref.getField(false,"_xpnl_bottom").runMethod(true,"getColor");
 BA.debugLineNum = 827;BA.debugLine="End Sub";
Debug.ShouldStop(67108864);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getbottomtop(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getBottomTop (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,762);
if (RapidSub.canDelegate("getbottomtop")) { return __ref.runUserSub(false, "asmsgbox","getbottomtop", __ref);}
 BA.debugLineNum = 762;BA.debugLine="Public Sub getBottomTop As Int";
Debug.ShouldStop(33554432);
 BA.debugLineNum = 764;BA.debugLine="Return xpnl_bottom.Top";
Debug.ShouldStop(134217728);
if (true) return BA.numberCast(int.class, __ref.getField(false,"_xpnl_bottom").runMethod(true,"getTop"));
 BA.debugLineNum = 766;BA.debugLine="End Sub";
Debug.ShouldStop(536870912);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getbutton1(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getButton1 (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,783);
if (RapidSub.canDelegate("getbutton1")) { return __ref.runUserSub(false, "asmsgbox","getbutton1", __ref);}
 BA.debugLineNum = 783;BA.debugLine="Public Sub getButton1 As B4XView";
Debug.ShouldStop(16384);
 BA.debugLineNum = 785;BA.debugLine="Return xlbl_action_1";
Debug.ShouldStop(65536);
if (true) return __ref.getField(false,"_xlbl_action_1");
 BA.debugLineNum = 787;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getbutton2(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getButton2 (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,790);
if (RapidSub.canDelegate("getbutton2")) { return __ref.runUserSub(false, "asmsgbox","getbutton2", __ref);}
 BA.debugLineNum = 790;BA.debugLine="Public Sub getButton2 As B4XView";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 792;BA.debugLine="Return xlbl_action_2";
Debug.ShouldStop(8388608);
if (true) return __ref.getField(false,"_xlbl_action_2");
 BA.debugLineNum = 794;BA.debugLine="End Sub";
Debug.ShouldStop(33554432);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getbutton3(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getButton3 (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,797);
if (RapidSub.canDelegate("getbutton3")) { return __ref.runUserSub(false, "asmsgbox","getbutton3", __ref);}
 BA.debugLineNum = 797;BA.debugLine="Public Sub getButton3 As B4XView";
Debug.ShouldStop(268435456);
 BA.debugLineNum = 799;BA.debugLine="Return xlbl_action_3";
Debug.ShouldStop(1073741824);
if (true) return __ref.getField(false,"_xlbl_action_3");
 BA.debugLineNum = 801;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getcancel(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getCANCEL (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,888);
if (RapidSub.canDelegate("getcancel")) { return __ref.runUserSub(false, "asmsgbox","getcancel", __ref);}
 BA.debugLineNum = 888;BA.debugLine="Public Sub getCANCEL As Int";
Debug.ShouldStop(8388608);
 BA.debugLineNum = 890;BA.debugLine="Return 1";
Debug.ShouldStop(33554432);
if (true) return BA.numberCast(int.class, 1);
 BA.debugLineNum = 892;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getclosebuttonvisible(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getCloseButtonVisible (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,746);
if (RapidSub.canDelegate("getclosebuttonvisible")) { return __ref.runUserSub(false, "asmsgbox","getclosebuttonvisible", __ref);}
 BA.debugLineNum = 746;BA.debugLine="Public Sub getCloseButtonVisible As Boolean";
Debug.ShouldStop(512);
 BA.debugLineNum = 748;BA.debugLine="Return showX";
Debug.ShouldStop(2048);
if (true) return __ref.getField(true,"_showx");
 BA.debugLineNum = 750;BA.debugLine="End Sub";
Debug.ShouldStop(8192);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getcontentheight(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getContentHeight (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,769);
if (RapidSub.canDelegate("getcontentheight")) { return __ref.runUserSub(false, "asmsgbox","getcontentheight", __ref);}
 BA.debugLineNum = 769;BA.debugLine="Public Sub getContentHeight As Int";
Debug.ShouldStop(1);
 BA.debugLineNum = 771;BA.debugLine="Return xpnl_content.Height";
Debug.ShouldStop(4);
if (true) return BA.numberCast(int.class, __ref.getField(false,"_xpnl_content").runMethod(true,"getHeight"));
 BA.debugLineNum = 773;BA.debugLine="End Sub";
Debug.ShouldStop(16);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getdragablecontent(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getDragableContent (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,719);
if (RapidSub.canDelegate("getdragablecontent")) { return __ref.runUserSub(false, "asmsgbox","getdragablecontent", __ref);}
 BA.debugLineNum = 719;BA.debugLine="Public Sub getDragableContent As Int";
Debug.ShouldStop(16384);
 BA.debugLineNum = 721;BA.debugLine="Return 2";
Debug.ShouldStop(65536);
if (true) return BA.numberCast(int.class, 2);
 BA.debugLineNum = 723;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getdragabledisable(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getDragableDisable (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,725);
if (RapidSub.canDelegate("getdragabledisable")) { return __ref.runUserSub(false, "asmsgbox","getdragabledisable", __ref);}
 BA.debugLineNum = 725;BA.debugLine="Public Sub getDragableDisable As Int";
Debug.ShouldStop(1048576);
 BA.debugLineNum = 727;BA.debugLine="Return 0";
Debug.ShouldStop(4194304);
if (true) return BA.numberCast(int.class, 0);
 BA.debugLineNum = 729;BA.debugLine="End Sub";
Debug.ShouldStop(16777216);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getdragabletop(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getDragableTop (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,713);
if (RapidSub.canDelegate("getdragabletop")) { return __ref.runUserSub(false, "asmsgbox","getdragabletop", __ref);}
 BA.debugLineNum = 713;BA.debugLine="Public Sub getDragableTop As Int";
Debug.ShouldStop(256);
 BA.debugLineNum = 715;BA.debugLine="Return 1";
Debug.ShouldStop(1024);
if (true) return BA.numberCast(int.class, 1);
 BA.debugLineNum = 717;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getenabledrag(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getEnableDrag (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,707);
if (RapidSub.canDelegate("getenabledrag")) { return __ref.runUserSub(false, "asmsgbox","getenabledrag", __ref);}
 BA.debugLineNum = 707;BA.debugLine="Public Sub getEnableDrag As Int";
Debug.ShouldStop(4);
 BA.debugLineNum = 709;BA.debugLine="Return dragable";
Debug.ShouldStop(16);
if (true) return __ref.getField(true,"_dragable");
 BA.debugLineNum = 711;BA.debugLine="End Sub";
Debug.ShouldStop(64);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getheader_font_size(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getHeader_Font_Size (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,577);
if (RapidSub.canDelegate("getheader_font_size")) { return __ref.runUserSub(false, "asmsgbox","getheader_font_size", __ref);}
 BA.debugLineNum = 577;BA.debugLine="Public Sub getHeader_Font_Size As Int";
Debug.ShouldStop(1);
 BA.debugLineNum = 579;BA.debugLine="Return headerFontSize";
Debug.ShouldStop(4);
if (true) return __ref.getField(true,"_headerfontsize");
 BA.debugLineNum = 581;BA.debugLine="End Sub";
Debug.ShouldStop(16);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getheader_text(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getHeader_Text (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,562);
if (RapidSub.canDelegate("getheader_text")) { return __ref.runUserSub(false, "asmsgbox","getheader_text", __ref);}
 BA.debugLineNum = 562;BA.debugLine="Public Sub getHeader_Text As String";
Debug.ShouldStop(131072);
 BA.debugLineNum = 564;BA.debugLine="Return headerText";
Debug.ShouldStop(524288);
if (true) return __ref.getField(true,"_headertext");
 BA.debugLineNum = 566;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getheaderbottom(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getHeaderBottom (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,755);
if (RapidSub.canDelegate("getheaderbottom")) { return __ref.runUserSub(false, "asmsgbox","getheaderbottom", __ref);}
 BA.debugLineNum = 755;BA.debugLine="Public Sub getHeaderBottom As Int";
Debug.ShouldStop(262144);
 BA.debugLineNum = 757;BA.debugLine="Return xpnl_header.Height";
Debug.ShouldStop(1048576);
if (true) return BA.numberCast(int.class, __ref.getField(false,"_xpnl_header").runMethod(true,"getHeight"));
 BA.debugLineNum = 759;BA.debugLine="End Sub";
Debug.ShouldStop(4194304);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getheadercolor(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getHeaderColor (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,817);
if (RapidSub.canDelegate("getheadercolor")) { return __ref.runUserSub(false, "asmsgbox","getheadercolor", __ref);}
 BA.debugLineNum = 817;BA.debugLine="Public Sub getHeaderColor As Int";
Debug.ShouldStop(65536);
 BA.debugLineNum = 819;BA.debugLine="Return xpnl_header.Color";
Debug.ShouldStop(262144);
if (true) return __ref.getField(false,"_xpnl_header").runMethod(true,"getColor");
 BA.debugLineNum = 821;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _geticon_direction(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getIcon_direction (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,610);
if (RapidSub.canDelegate("geticon_direction")) { return __ref.runUserSub(false, "asmsgbox","geticon_direction", __ref);}
 BA.debugLineNum = 610;BA.debugLine="Public Sub getIcon_direction As String";
Debug.ShouldStop(2);
 BA.debugLineNum = 612;BA.debugLine="Return iconDirection";
Debug.ShouldStop(8);
if (true) return __ref.getField(true,"_icondirection");
 BA.debugLineNum = 614;BA.debugLine="End Sub";
Debug.ShouldStop(32);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getnegative(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getNEGATIVE (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,881);
if (RapidSub.canDelegate("getnegative")) { return __ref.runUserSub(false, "asmsgbox","getnegative", __ref);}
 BA.debugLineNum = 881;BA.debugLine="Public Sub getNEGATIVE As Int";
Debug.ShouldStop(65536);
 BA.debugLineNum = 883;BA.debugLine="Return 2";
Debug.ShouldStop(262144);
if (true) return BA.numberCast(int.class, 2);
 BA.debugLineNum = 885;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getpositive(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("getPOSITIVE (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,874);
if (RapidSub.canDelegate("getpositive")) { return __ref.runUserSub(false, "asmsgbox","getpositive", __ref);}
 BA.debugLineNum = 874;BA.debugLine="Public Sub getPOSITIVE As Int";
Debug.ShouldStop(512);
 BA.debugLineNum = 876;BA.debugLine="Return 3";
Debug.ShouldStop(2048);
if (true) return BA.numberCast(int.class, 3);
 BA.debugLineNum = 878;BA.debugLine="End Sub";
Debug.ShouldStop(8192);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _icon_border_width(RemoteObject __ref,RemoteObject _border) throws Exception{
try {
		Debug.PushSubsStack("icon_border_width (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,624);
if (RapidSub.canDelegate("icon_border_width")) { return __ref.runUserSub(false, "asmsgbox","icon_border_width", __ref, _border);}
Debug.locals.put("border", _border);
 BA.debugLineNum = 624;BA.debugLine="Public Sub icon_border_width(border As Int)";
Debug.ShouldStop(32768);
 BA.debugLineNum = 626;BA.debugLine="If border > -1 And border < 6 Then";
Debug.ShouldStop(131072);
if (RemoteObject.solveBoolean(">",_border,BA.numberCast(double.class, -(double) (0 + 1))) && RemoteObject.solveBoolean("<",_border,BA.numberCast(double.class, 6))) { 
 BA.debugLineNum = 628;BA.debugLine="border_width = border";
Debug.ShouldStop(524288);
__ref.setField ("_border_width",_border);
 }else {
 BA.debugLineNum = 635;BA.debugLine="Return";
Debug.ShouldStop(67108864);
if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 639;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _icon_click_handler(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("icon_click_handler (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,545);
if (RapidSub.canDelegate("icon_click_handler")) { return __ref.runUserSub(false, "asmsgbox","icon_click_handler", __ref);}
 BA.debugLineNum = 545;BA.debugLine="Private Sub icon_click_handler";
Debug.ShouldStop(1);
 BA.debugLineNum = 547;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_IconCl";
Debug.ShouldStop(4);
if (__ref.getField(false,"_xui").runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_IconClick"))),(Object)(BA.numberCast(int.class, 0))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 548;BA.debugLine="CallSub(mCallBack, mEventName & \"_IconClick\")";
Debug.ShouldStop(8);
asmsgbox.__c.runMethodAndSync(false,"CallSubNew",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_IconClick"))));
 };
 BA.debugLineNum = 551;BA.debugLine="End Sub";
Debug.ShouldStop(64);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _icon_longclick_handler(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("icon_longclick_handler (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,553);
if (RapidSub.canDelegate("icon_longclick_handler")) { return __ref.runUserSub(false, "asmsgbox","icon_longclick_handler", __ref);}
 BA.debugLineNum = 553;BA.debugLine="Private Sub icon_longclick_handler";
Debug.ShouldStop(256);
 BA.debugLineNum = 555;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_IconLo";
Debug.ShouldStop(1024);
if (__ref.getField(false,"_xui").runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_IconLongClick"))),(Object)(BA.numberCast(int.class, 0))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 556;BA.debugLine="CallSub(mCallBack, mEventName & \"_IconLongClick\"";
Debug.ShouldStop(2048);
asmsgbox.__c.runMethodAndSync(false,"CallSubNew",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_IconLongClick"))));
 };
 BA.debugLineNum = 559;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _icon_set_icon(RemoteObject __ref,RemoteObject _icon) throws Exception{
try {
		Debug.PushSubsStack("icon_set_icon (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,731);
if (RapidSub.canDelegate("icon_set_icon")) { return __ref.runUserSub(false, "asmsgbox","icon_set_icon", __ref, _icon);}
Debug.locals.put("icon", _icon);
 BA.debugLineNum = 731;BA.debugLine="Public Sub icon_set_icon(icon As B4XBitmap)";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 733;BA.debugLine="xiv_icon.SetBitmap(CreateRoundBitmap(icon,xiv_ico";
Debug.ShouldStop(268435456);
__ref.getField(false,"_xiv_icon").runVoidMethod ("SetBitmap",(Object)((__ref.runClassMethod (b4j.example.asmsgbox.class, "_createroundbitmap",(Object)(_icon),(Object)(BA.numberCast(int.class, __ref.getField(false,"_xiv_icon").runMethod(true,"getWidth")))).getObject())));
 BA.debugLineNum = 735;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _icon_visible(RemoteObject __ref,RemoteObject _visible) throws Exception{
try {
		Debug.PushSubsStack("icon_visible (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,616);
if (RapidSub.canDelegate("icon_visible")) { return __ref.runUserSub(false, "asmsgbox","icon_visible", __ref, _visible);}
Debug.locals.put("visible", _visible);
 BA.debugLineNum = 616;BA.debugLine="Public Sub icon_visible(visible As Boolean)";
Debug.ShouldStop(128);
 BA.debugLineNum = 618;BA.debugLine="iconVisible = visible";
Debug.ShouldStop(512);
__ref.setField ("_iconvisible",_visible);
 BA.debugLineNum = 619;BA.debugLine="Base_Resize(mBase.Width,mBase.Height)";
Debug.ShouldStop(1024);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_base_resize",(Object)(__ref.getField(false,"_mbase").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getHeight")));
 BA.debugLineNum = 621;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _callback,RemoteObject _eventname) throws Exception{
try {
		Debug.PushSubsStack("Initialize (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,179);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "asmsgbox","initialize", __ref, _ba, _callback, _eventname);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
Debug.locals.put("Callback", _callback);
Debug.locals.put("EventName", _eventname);
 BA.debugLineNum = 179;BA.debugLine="Public Sub Initialize (Callback As Object, EventNa";
Debug.ShouldStop(262144);
 BA.debugLineNum = 180;BA.debugLine="mEventName = EventName";
Debug.ShouldStop(524288);
__ref.setField ("_meventname",_eventname);
 BA.debugLineNum = 181;BA.debugLine="mCallBack = Callback";
Debug.ShouldStop(1048576);
__ref.setField ("_mcallback",_callback);
 BA.debugLineNum = 182;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initializebottom(RemoteObject __ref,RemoteObject _button1,RemoteObject _button2,RemoteObject _button3) throws Exception{
try {
		Debug.PushSubsStack("InitializeBottom (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,144);
if (RapidSub.canDelegate("initializebottom")) { return __ref.runUserSub(false, "asmsgbox","initializebottom", __ref, _button1, _button2, _button3);}
Debug.locals.put("button1", _button1);
Debug.locals.put("button2", _button2);
Debug.locals.put("button3", _button3);
 BA.debugLineNum = 144;BA.debugLine="Public Sub InitializeBottom(button1 As String,butt";
Debug.ShouldStop(32768);
 BA.debugLineNum = 146;BA.debugLine="If button1 = \"\" Then";
Debug.ShouldStop(131072);
if (RemoteObject.solveBoolean("=",_button1,BA.ObjectToString(""))) { 
 BA.debugLineNum = 148;BA.debugLine="xlbl_action_1.Text = \"\"";
Debug.ShouldStop(524288);
__ref.getField(false,"_xlbl_action_1").runMethod(true,"setText",BA.ObjectToString(""));
 BA.debugLineNum = 149;BA.debugLine="xlbl_action_1.Visible = False";
Debug.ShouldStop(1048576);
__ref.getField(false,"_xlbl_action_1").runMethod(true,"setVisible",asmsgbox.__c.getField(true,"False"));
 }else {
 BA.debugLineNum = 152;BA.debugLine="xlbl_action_1.Text = button1";
Debug.ShouldStop(8388608);
__ref.getField(false,"_xlbl_action_1").runMethod(true,"setText",_button1);
 BA.debugLineNum = 154;BA.debugLine="xlbl_action_1.Visible = True";
Debug.ShouldStop(33554432);
__ref.getField(false,"_xlbl_action_1").runMethod(true,"setVisible",asmsgbox.__c.getField(true,"True"));
 };
 BA.debugLineNum = 157;BA.debugLine="If button2 = \"\" Then";
Debug.ShouldStop(268435456);
if (RemoteObject.solveBoolean("=",_button2,BA.ObjectToString(""))) { 
 BA.debugLineNum = 158;BA.debugLine="xlbl_action_2.Text = \"\"";
Debug.ShouldStop(536870912);
__ref.getField(false,"_xlbl_action_2").runMethod(true,"setText",BA.ObjectToString(""));
 BA.debugLineNum = 159;BA.debugLine="xlbl_action_2.Visible = False";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_xlbl_action_2").runMethod(true,"setVisible",asmsgbox.__c.getField(true,"False"));
 }else {
 BA.debugLineNum = 162;BA.debugLine="xlbl_action_2.Text = button2";
Debug.ShouldStop(2);
__ref.getField(false,"_xlbl_action_2").runMethod(true,"setText",_button2);
 BA.debugLineNum = 164;BA.debugLine="xlbl_action_2.Visible = True";
Debug.ShouldStop(8);
__ref.getField(false,"_xlbl_action_2").runMethod(true,"setVisible",asmsgbox.__c.getField(true,"True"));
 };
 BA.debugLineNum = 167;BA.debugLine="If button3 = \"\" Then";
Debug.ShouldStop(64);
if (RemoteObject.solveBoolean("=",_button3,BA.ObjectToString(""))) { 
 BA.debugLineNum = 168;BA.debugLine="xlbl_action_3.Text = \"\"";
Debug.ShouldStop(128);
__ref.getField(false,"_xlbl_action_3").runMethod(true,"setText",BA.ObjectToString(""));
 BA.debugLineNum = 169;BA.debugLine="xlbl_action_3.Visible = False";
Debug.ShouldStop(256);
__ref.getField(false,"_xlbl_action_3").runMethod(true,"setVisible",asmsgbox.__c.getField(true,"False"));
 }else {
 BA.debugLineNum = 172;BA.debugLine="xlbl_action_3.Text = button3";
Debug.ShouldStop(2048);
__ref.getField(false,"_xlbl_action_3").runMethod(true,"setText",_button3);
 BA.debugLineNum = 174;BA.debugLine="xlbl_action_3.Visible = True";
Debug.ShouldStop(8192);
__ref.getField(false,"_xlbl_action_3").runMethod(true,"setVisible",asmsgbox.__c.getField(true,"True"));
 };
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
public static RemoteObject  _initializewithoutdesigner(RemoteObject __ref,RemoteObject _parent,RemoteObject _backgroundcolor,RemoteObject _show_header,RemoteObject _show_bottom,RemoteObject _show_close_button) throws Exception{
try {
		Debug.PushSubsStack("InitializeWithoutDesigner (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,98);
if (RapidSub.canDelegate("initializewithoutdesigner")) { return __ref.runUserSub(false, "asmsgbox","initializewithoutdesigner", __ref, _parent, _backgroundcolor, _show_header, _show_bottom, _show_close_button);}
RemoteObject _tmp_base = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
RemoteObject _props = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.Map");
RemoteObject _lbl = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
Debug.locals.put("parent", _parent);
Debug.locals.put("backgroundcolor", _backgroundcolor);
Debug.locals.put("show_header", _show_header);
Debug.locals.put("show_bottom", _show_bottom);
Debug.locals.put("show_close_button", _show_close_button);
 BA.debugLineNum = 98;BA.debugLine="Public Sub InitializeWithoutDesigner(parent As B4X";
Debug.ShouldStop(2);
 BA.debugLineNum = 101;BA.debugLine="Dim tmp_base As B4XView";
Debug.ShouldStop(16);
_tmp_base = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");Debug.locals.put("tmp_base", _tmp_base);
 BA.debugLineNum = 102;BA.debugLine="tmp_base = xui.CreatePanel(mEventName)";
Debug.ShouldStop(32);
_tmp_base = __ref.getField(false,"_xui").runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(__ref.getField(true,"_meventname")));Debug.locals.put("tmp_base", _tmp_base);
 BA.debugLineNum = 106;BA.debugLine="parent.AddView(tmp_base, 0 + parent.Width/2 - tmp";
Debug.ShouldStop(512);
_parent.runVoidMethod ("AddView",(Object)((_tmp_base.getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(0),_parent.runMethod(true,"getWidth"),RemoteObject.createImmutable(2),_tmp_base.runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "+/-/",2, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(0),_parent.runMethod(true,"getHeight"),RemoteObject.createImmutable(2),_tmp_base.runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "+/-/",2, 0)),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 300))))),(Object)(BA.numberCast(double.class, asmsgbox.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 300))))));
 BA.debugLineNum = 108;BA.debugLine="Dim props As Map";
Debug.ShouldStop(2048);
_props = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.Map");Debug.locals.put("props", _props);
 BA.debugLineNum = 109;BA.debugLine="props.Initialize";
Debug.ShouldStop(4096);
_props.runVoidMethod ("Initialize");
 BA.debugLineNum = 110;BA.debugLine="props.Put(\"Back_Color\",backgroundcolor)";
Debug.ShouldStop(8192);
_props.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("Back_Color"))),(Object)((_backgroundcolor)));
 BA.debugLineNum = 111;BA.debugLine="props.Put(\"show_header\",show_header)";
Debug.ShouldStop(16384);
_props.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("show_header"))),(Object)((_show_header)));
 BA.debugLineNum = 112;BA.debugLine="props.Put(\"show_bottom\",show_bottom)";
Debug.ShouldStop(32768);
_props.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("show_bottom"))),(Object)((_show_bottom)));
 BA.debugLineNum = 113;BA.debugLine="props.Put(\"Show_X\",show_close_button)";
Debug.ShouldStop(65536);
_props.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("Show_X"))),(Object)((_show_close_button)));
 BA.debugLineNum = 114;BA.debugLine="props.Put(\"Header_CLR\",0xFF2F343A)";
Debug.ShouldStop(131072);
_props.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("Header_CLR"))),(Object)(RemoteObject.createImmutable((0xff2f343a))));
 BA.debugLineNum = 115;BA.debugLine="props.Put(\"Bottom_CLR\",0xFF2F343A)";
Debug.ShouldStop(262144);
_props.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("Bottom_CLR"))),(Object)(RemoteObject.createImmutable((0xff2f343a))));
 BA.debugLineNum = 117;BA.debugLine="If show_header = True Then";
Debug.ShouldStop(1048576);
if (RemoteObject.solveBoolean("=",_show_header,asmsgbox.__c.getField(true,"True"))) { 
 BA.debugLineNum = 118;BA.debugLine="props.Put(\"Icon_visible\",True)";
Debug.ShouldStop(2097152);
_props.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("Icon_visible"))),(Object)((asmsgbox.__c.getField(true,"True"))));
 BA.debugLineNum = 119;BA.debugLine="props.Put(\"Icon_direction\",\"LEFT\")";
Debug.ShouldStop(4194304);
_props.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("Icon_direction"))),(Object)((RemoteObject.createImmutable("LEFT"))));
 }else {
 BA.debugLineNum = 121;BA.debugLine="props.Put(\"Icon_visible\",False)";
Debug.ShouldStop(16777216);
_props.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("Icon_visible"))),(Object)((asmsgbox.__c.getField(true,"False"))));
 BA.debugLineNum = 122;BA.debugLine="props.Put(\"Icon_direction\",\"LEFT\")";
Debug.ShouldStop(33554432);
_props.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("Icon_direction"))),(Object)((RemoteObject.createImmutable("LEFT"))));
 };
 BA.debugLineNum = 125;BA.debugLine="props.Put(\"BorderWidth\",0)";
Debug.ShouldStop(268435456);
_props.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("BorderWidth"))),(Object)(RemoteObject.createImmutable((0))));
 BA.debugLineNum = 128;BA.debugLine="props.Put(\"header_font_size\",20)";
Debug.ShouldStop(-2147483648);
_props.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("header_font_size"))),(Object)(RemoteObject.createImmutable((20))));
 BA.debugLineNum = 129;BA.debugLine="props.Put(\"Header_Text\",\"Anywhere B4X\")";
Debug.ShouldStop(1);
_props.runVoidMethod ("Put",(Object)(RemoteObject.createImmutable(("Header_Text"))),(Object)((RemoteObject.createImmutable("Anywhere B4X"))));
 BA.debugLineNum = 131;BA.debugLine="Dim lbl As Label";
Debug.ShouldStop(4);
_lbl = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("lbl", _lbl);
 BA.debugLineNum = 132;BA.debugLine="lbl.Initialize(\"\")";
Debug.ShouldStop(8);
_lbl.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 134;BA.debugLine="DesignerCreateView(tmp_base,lbl,props)";
Debug.ShouldStop(32);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_designercreateview",(Object)((_tmp_base.getObject())),(Object)(_lbl),(Object)(_props));
 BA.debugLineNum = 136;BA.debugLine="mBase.Visible = False";
Debug.ShouldStop(128);
__ref.getField(false,"_mbase").runMethod(true,"setVisible",asmsgbox.__c.getField(true,"False"));
 BA.debugLineNum = 138;BA.debugLine="Base_Resize(mBase.Width,mBase.Height)";
Debug.ShouldStop(512);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_base_resize",(Object)(__ref.getField(false,"_mbase").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getHeight")));
 BA.debugLineNum = 141;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _loadlayout(RemoteObject __ref,RemoteObject _layout) throws Exception{
try {
		Debug.PushSubsStack("LoadLayout (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,804);
if (RapidSub.canDelegate("loadlayout")) { return __ref.runUserSub(false, "asmsgbox","loadlayout", __ref, _layout);}
Debug.locals.put("layout", _layout);
 BA.debugLineNum = 804;BA.debugLine="Public Sub LoadLayout(layout As String)";
Debug.ShouldStop(8);
 BA.debugLineNum = 806;BA.debugLine="xpnl_content.LoadLayout(layout)";
Debug.ShouldStop(32);
__ref.getField(false,"_xpnl_content").runVoidMethodAndSync ("LoadLayout",(Object)(_layout),__ref.getField(false, "ba"));
 BA.debugLineNum = 808;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _loadlayout2(RemoteObject __ref,RemoteObject _p) throws Exception{
try {
		Debug.PushSubsStack("LoadLayout2 (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,811);
if (RapidSub.canDelegate("loadlayout2")) { return __ref.runUserSub(false, "asmsgbox","loadlayout2", __ref, _p);}
Debug.locals.put("p", _p);
 BA.debugLineNum = 811;BA.debugLine="Public Sub LoadLayout2(p As B4XView)";
Debug.ShouldStop(1024);
 BA.debugLineNum = 813;BA.debugLine="xpnl_content = p";
Debug.ShouldStop(4096);
__ref.setField ("_xpnl_content",_p);
 BA.debugLineNum = 815;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _makeviewbackgroundtransparent(RemoteObject __ref,RemoteObject _view,RemoteObject _alpha) throws Exception{
try {
		Debug.PushSubsStack("MakeViewBackgroundTransparent (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,952);
if (RapidSub.canDelegate("makeviewbackgroundtransparent")) { return __ref.runUserSub(false, "asmsgbox","makeviewbackgroundtransparent", __ref, _view, _alpha);}
RemoteObject _clr = RemoteObject.createImmutable(0);
Debug.locals.put("View", _view);
Debug.locals.put("Alpha", _alpha);
 BA.debugLineNum = 952;BA.debugLine="Private Sub MakeViewBackgroundTransparent(View As";
Debug.ShouldStop(8388608);
 BA.debugLineNum = 953;BA.debugLine="Dim clr As Int = View.Color";
Debug.ShouldStop(16777216);
_clr = _view.runMethod(true,"getColor");Debug.locals.put("clr", _clr);Debug.locals.put("clr", _clr);
 BA.debugLineNum = 954;BA.debugLine="If clr = 0 Then";
Debug.ShouldStop(33554432);
if (RemoteObject.solveBoolean("=",_clr,BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 955;BA.debugLine="Log(\"Cannot get background color.\")";
Debug.ShouldStop(67108864);
asmsgbox.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Cannot get background color.")));
 BA.debugLineNum = 956;BA.debugLine="Return";
Debug.ShouldStop(134217728);
if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 958;BA.debugLine="View.Color = Bit.Or(Bit.And(0x00ffffff, clr), Bit";
Debug.ShouldStop(536870912);
_view.runMethod(true,"setColor",asmsgbox.__c.getField(false,"Bit").runMethod(true,"Or",(Object)(asmsgbox.__c.getField(false,"Bit").runMethod(true,"And",(Object)(BA.numberCast(int.class, 0x00ffffff)),(Object)(_clr))),(Object)(asmsgbox.__c.getField(false,"Bit").runMethod(true,"ShiftLeft",(Object)(_alpha),(Object)(BA.numberCast(int.class, 24))))));
 BA.debugLineNum = 959;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _measuretextheight(RemoteObject __ref,RemoteObject _text,RemoteObject _font1) throws Exception{
try {
		Debug.PushSubsStack("MeasureTextHeight (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,962);
if (RapidSub.canDelegate("measuretextheight")) { return __ref.runUserSub(false, "asmsgbox","measuretextheight", __ref, _text, _font1);}
RemoteObject _jo = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _bounds = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
Debug.locals.put("Text", _text);
Debug.locals.put("Font1", _font1);
 BA.debugLineNum = 962;BA.debugLine="Private Sub MeasureTextHeight(Text As String, Font";
Debug.ShouldStop(2);
 BA.debugLineNum = 972;BA.debugLine="Dim jo As JavaObject";
Debug.ShouldStop(2048);
_jo = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");Debug.locals.put("jo", _jo);
 BA.debugLineNum = 973;BA.debugLine="jo.InitializeNewInstance(\"javafx.scene.text.Text\"";
Debug.ShouldStop(4096);
_jo.runVoidMethod ("InitializeNewInstance",(Object)(BA.ObjectToString("javafx.scene.text.Text")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(_text)})));
 BA.debugLineNum = 974;BA.debugLine="jo.RunMethod(\"setFont\",Array(Font1.ToNativeFont))";
Debug.ShouldStop(8192);
_jo.runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("setFont")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(_font1.runMethod(false,"ToNativeFont").getObject())})));
 BA.debugLineNum = 975;BA.debugLine="jo.RunMethod(\"setLineSpacing\",Array(0.0))";
Debug.ShouldStop(16384);
_jo.runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("setLineSpacing")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {RemoteObject.createImmutable((0.0))})));
 BA.debugLineNum = 976;BA.debugLine="jo.RunMethod(\"setWrappingWidth\",Array(0.0))";
Debug.ShouldStop(32768);
_jo.runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("setWrappingWidth")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {RemoteObject.createImmutable((0.0))})));
 BA.debugLineNum = 977;BA.debugLine="Dim Bounds As JavaObject = jo.RunMethod(\"getLayou";
Debug.ShouldStop(65536);
_bounds = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_bounds.setObject(_jo.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getLayoutBounds")),(Object)((asmsgbox.__c.getField(false,"Null")))));Debug.locals.put("Bounds", _bounds);
 BA.debugLineNum = 978;BA.debugLine="Return Bounds.RunMethod(\"getHeight\",Null)";
Debug.ShouldStop(131072);
if (true) return BA.numberCast(int.class, _bounds.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getHeight")),(Object)((asmsgbox.__c.getField(false,"Null")))));
 BA.debugLineNum = 980;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _measuretextwidth(RemoteObject __ref,RemoteObject _text,RemoteObject _font1) throws Exception{
try {
		Debug.PushSubsStack("MeasureTextWidth (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,982);
if (RapidSub.canDelegate("measuretextwidth")) { return __ref.runUserSub(false, "asmsgbox","measuretextwidth", __ref, _text, _font1);}
RemoteObject _jo = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _bounds = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
Debug.locals.put("Text", _text);
Debug.locals.put("Font1", _font1);
 BA.debugLineNum = 982;BA.debugLine="Private Sub MeasureTextWidth(Text As String, Font1";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 992;BA.debugLine="Dim jo As JavaObject";
Debug.ShouldStop(-2147483648);
_jo = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");Debug.locals.put("jo", _jo);
 BA.debugLineNum = 993;BA.debugLine="jo.InitializeNewInstance(\"javafx.scene.text.Text\"";
Debug.ShouldStop(1);
_jo.runVoidMethod ("InitializeNewInstance",(Object)(BA.ObjectToString("javafx.scene.text.Text")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(_text)})));
 BA.debugLineNum = 994;BA.debugLine="jo.RunMethod(\"setFont\",Array(Font1.ToNativeFont))";
Debug.ShouldStop(2);
_jo.runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("setFont")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(_font1.runMethod(false,"ToNativeFont").getObject())})));
 BA.debugLineNum = 995;BA.debugLine="jo.RunMethod(\"setLineSpacing\",Array(0.0))";
Debug.ShouldStop(4);
_jo.runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("setLineSpacing")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {RemoteObject.createImmutable((0.0))})));
 BA.debugLineNum = 996;BA.debugLine="jo.RunMethod(\"setWrappingWidth\",Array(0.0))";
Debug.ShouldStop(8);
_jo.runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("setWrappingWidth")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {RemoteObject.createImmutable((0.0))})));
 BA.debugLineNum = 997;BA.debugLine="Dim Bounds As JavaObject = jo.RunMethod(\"getLayou";
Debug.ShouldStop(16);
_bounds = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_bounds.setObject(_jo.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getLayoutBounds")),(Object)((asmsgbox.__c.getField(false,"Null")))));Debug.locals.put("Bounds", _bounds);
 BA.debugLineNum = 998;BA.debugLine="Return Bounds.RunMethod(\"getWidth\",Null)";
Debug.ShouldStop(32);
if (true) return BA.numberCast(int.class, _bounds.runMethod(false,"RunMethod",(Object)(BA.ObjectToString("getWidth")),(Object)((asmsgbox.__c.getField(false,"Null")))));
 BA.debugLineNum = 1000;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable(0);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _result(RemoteObject __ref,RemoteObject _res) throws Exception{
try {
		Debug.PushSubsStack("result (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,937);
if (RapidSub.canDelegate("result")) { return __ref.runUserSub(false, "asmsgbox","result", __ref, _res);}
Debug.locals.put("res", _res);
 BA.debugLineNum = 937;BA.debugLine="Private Sub result(res As Int)";
Debug.ShouldStop(256);
 BA.debugLineNum = 939;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_result";
Debug.ShouldStop(1024);
if (__ref.getField(false,"_xui").runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_result"))),(Object)(BA.numberCast(int.class, 0))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 940;BA.debugLine="CallSub2(mCallBack, mEventName & \"_result\",res)";
Debug.ShouldStop(2048);
asmsgbox.__c.runMethodAndSync(false,"CallSubNew2",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_result"))),(Object)((_res)));
 };
 BA.debugLineNum = 943;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setbottomcolor(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("setBottomColor (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,836);
if (RapidSub.canDelegate("setbottomcolor")) { return __ref.runUserSub(false, "asmsgbox","setbottomcolor", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 836;BA.debugLine="Public Sub setBottomColor(color As Int)";
Debug.ShouldStop(8);
 BA.debugLineNum = 838;BA.debugLine="bottom_crl = color";
Debug.ShouldStop(32);
__ref.setField ("_bottom_crl",_color);
 BA.debugLineNum = 839;BA.debugLine="xpnl_bottom.Color = color";
Debug.ShouldStop(64);
__ref.getField(false,"_xpnl_bottom").runMethod(true,"setColor",_color);
 BA.debugLineNum = 841;BA.debugLine="End Sub";
Debug.ShouldStop(256);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setclosebuttonvisible(RemoteObject __ref,RemoteObject _visible) throws Exception{
try {
		Debug.PushSubsStack("setCloseButtonVisible (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,738);
if (RapidSub.canDelegate("setclosebuttonvisible")) { return __ref.runUserSub(false, "asmsgbox","setclosebuttonvisible", __ref, _visible);}
Debug.locals.put("visible", _visible);
 BA.debugLineNum = 738;BA.debugLine="Public Sub setCloseButtonVisible(visible As Boolea";
Debug.ShouldStop(2);
 BA.debugLineNum = 740;BA.debugLine="showX = visible";
Debug.ShouldStop(8);
__ref.setField ("_showx",_visible);
 BA.debugLineNum = 741;BA.debugLine="Base_Resize(mBase.Width,mBase.Height)";
Debug.ShouldStop(16);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_base_resize",(Object)(__ref.getField(false,"_mbase").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getHeight")));
 BA.debugLineNum = 743;BA.debugLine="End Sub";
Debug.ShouldStop(64);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setenabledrag(RemoteObject __ref,RemoteObject _enable) throws Exception{
try {
		Debug.PushSubsStack("setEnableDrag (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,701);
if (RapidSub.canDelegate("setenabledrag")) { return __ref.runUserSub(false, "asmsgbox","setenabledrag", __ref, _enable);}
Debug.locals.put("enable", _enable);
 BA.debugLineNum = 701;BA.debugLine="Public Sub setEnableDrag(enable As Int)";
Debug.ShouldStop(268435456);
 BA.debugLineNum = 703;BA.debugLine="dragable = enable";
Debug.ShouldStop(1073741824);
__ref.setField ("_dragable",_enable);
 BA.debugLineNum = 705;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setheader_font_size(RemoteObject __ref,RemoteObject _fontsize) throws Exception{
try {
		Debug.PushSubsStack("setHeader_Font_Size (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,584);
if (RapidSub.canDelegate("setheader_font_size")) { return __ref.runUserSub(false, "asmsgbox","setheader_font_size", __ref, _fontsize);}
Debug.locals.put("fontsize", _fontsize);
 BA.debugLineNum = 584;BA.debugLine="Public Sub setHeader_Font_Size(fontsize As Int)";
Debug.ShouldStop(128);
 BA.debugLineNum = 586;BA.debugLine="headerFontSize = fontsize";
Debug.ShouldStop(512);
__ref.setField ("_headerfontsize",_fontsize);
 BA.debugLineNum = 587;BA.debugLine="xlbl_header.Font = xui.CreateDefaultBoldFont(head";
Debug.ShouldStop(1024);
__ref.getField(false,"_xlbl_header").runMethod(false,"setFont",__ref.getField(false,"_xui").runMethod(false,"CreateDefaultBoldFont",(Object)(BA.numberCast(float.class, __ref.getField(true,"_headerfontsize")))));
 BA.debugLineNum = 589;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setheader_text(RemoteObject __ref,RemoteObject _text) throws Exception{
try {
		Debug.PushSubsStack("setHeader_Text (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,569);
if (RapidSub.canDelegate("setheader_text")) { return __ref.runUserSub(false, "asmsgbox","setheader_text", __ref, _text);}
Debug.locals.put("text", _text);
 BA.debugLineNum = 569;BA.debugLine="Public Sub setHeader_Text(text As String)";
Debug.ShouldStop(16777216);
 BA.debugLineNum = 571;BA.debugLine="headerText = text";
Debug.ShouldStop(67108864);
__ref.setField ("_headertext",_text);
 BA.debugLineNum = 572;BA.debugLine="xlbl_header.Text = headerText";
Debug.ShouldStop(134217728);
__ref.getField(false,"_xlbl_header").runMethod(true,"setText",__ref.getField(true,"_headertext"));
 BA.debugLineNum = 574;BA.debugLine="End Sub";
Debug.ShouldStop(536870912);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setheadercolor(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("setHeaderColor (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,829);
if (RapidSub.canDelegate("setheadercolor")) { return __ref.runUserSub(false, "asmsgbox","setheadercolor", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 829;BA.debugLine="Public Sub setHeaderColor(color As Int)";
Debug.ShouldStop(268435456);
 BA.debugLineNum = 831;BA.debugLine="header_clr = color";
Debug.ShouldStop(1073741824);
__ref.setField ("_header_clr",_color);
 BA.debugLineNum = 832;BA.debugLine="xpnl_header.Color = color";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_xpnl_header").runMethod(true,"setColor",_color);
 BA.debugLineNum = 834;BA.debugLine="End Sub";
Debug.ShouldStop(2);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _seticon_direction(RemoteObject __ref,RemoteObject _direction) throws Exception{
try {
		Debug.PushSubsStack("setIcon_direction (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,593);
if (RapidSub.canDelegate("seticon_direction")) { return __ref.runUserSub(false, "asmsgbox","seticon_direction", __ref, _direction);}
Debug.locals.put("direction", _direction);
 BA.debugLineNum = 593;BA.debugLine="Public Sub setIcon_direction(direction As String)";
Debug.ShouldStop(65536);
 BA.debugLineNum = 595;BA.debugLine="If direction = \"LEFT\" Or direction = \"RIGHT\" Or d";
Debug.ShouldStop(262144);
if (RemoteObject.solveBoolean("=",_direction,BA.ObjectToString("LEFT")) || RemoteObject.solveBoolean("=",_direction,BA.ObjectToString("RIGHT")) || RemoteObject.solveBoolean("=",_direction,BA.ObjectToString("MIDDLE"))) { 
 BA.debugLineNum = 597;BA.debugLine="iconDirection = direction";
Debug.ShouldStop(1048576);
__ref.setField ("_icondirection",_direction);
 BA.debugLineNum = 598;BA.debugLine="Base_Resize(mBase.Width,mBase.Height)";
Debug.ShouldStop(2097152);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_base_resize",(Object)(__ref.getField(false,"_mbase").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getHeight")));
 }else {
 BA.debugLineNum = 602;BA.debugLine="Return";
Debug.ShouldStop(33554432);
if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 606;BA.debugLine="End Sub";
Debug.ShouldStop(536870912);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _show(RemoteObject __ref,RemoteObject _animated) throws Exception{
try {
		Debug.PushSubsStack("Show (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,261);
if (RapidSub.canDelegate("show")) { return __ref.runUserSub(false, "asmsgbox","show", __ref, _animated);}
Debug.locals.put("animated", _animated);
 BA.debugLineNum = 261;BA.debugLine="Public Sub Show(animated As Boolean)";
Debug.ShouldStop(16);
 BA.debugLineNum = 263;BA.debugLine="If animated = True Then";
Debug.ShouldStop(64);
if (RemoteObject.solveBoolean("=",_animated,asmsgbox.__c.getField(true,"True"))) { 
 BA.debugLineNum = 265;BA.debugLine="mBase.SetVisibleAnimated(300,True)";
Debug.ShouldStop(256);
__ref.getField(false,"_mbase").runVoidMethod ("SetVisibleAnimated",__ref.getField(false, "ba"),(Object)(BA.numberCast(int.class, 300)),(Object)(asmsgbox.__c.getField(true,"True")));
 }else 
{ BA.debugLineNum = 267;BA.debugLine="Else If animated = False Then";
Debug.ShouldStop(1024);
if (RemoteObject.solveBoolean("=",_animated,asmsgbox.__c.getField(true,"False"))) { 
 BA.debugLineNum = 269;BA.debugLine="mBase.Visible = True";
Debug.ShouldStop(4096);
__ref.getField(false,"_mbase").runMethod(true,"setVisible",asmsgbox.__c.getField(true,"True"));
 }}
;
 BA.debugLineNum = 273;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _showwithtext(RemoteObject __ref,RemoteObject _text,RemoteObject _animated) throws Exception{
try {
		Debug.PushSubsStack("ShowWithText (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,246);
if (RapidSub.canDelegate("showwithtext")) { return __ref.runUserSub(false, "asmsgbox","showwithtext", __ref, _text, _animated);}
Debug.locals.put("text", _text);
Debug.locals.put("animated", _animated);
 BA.debugLineNum = 246;BA.debugLine="Public Sub ShowWithText(text As String,animated As";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 248;BA.debugLine="xlbl_text.BringToFront";
Debug.ShouldStop(8388608);
__ref.getField(false,"_xlbl_text").runVoidMethod ("BringToFront");
 BA.debugLineNum = 249;BA.debugLine="xlbl_text.Visible = True";
Debug.ShouldStop(16777216);
__ref.getField(false,"_xlbl_text").runMethod(true,"setVisible",asmsgbox.__c.getField(true,"True"));
 BA.debugLineNum = 250;BA.debugLine="If animated = True Then";
Debug.ShouldStop(33554432);
if (RemoteObject.solveBoolean("=",_animated,asmsgbox.__c.getField(true,"True"))) { 
 BA.debugLineNum = 252;BA.debugLine="mBase.SetVisibleAnimated(300,True)";
Debug.ShouldStop(134217728);
__ref.getField(false,"_mbase").runVoidMethod ("SetVisibleAnimated",__ref.getField(false, "ba"),(Object)(BA.numberCast(int.class, 300)),(Object)(asmsgbox.__c.getField(true,"True")));
 }else 
{ BA.debugLineNum = 253;BA.debugLine="Else If animated = False Then";
Debug.ShouldStop(268435456);
if (RemoteObject.solveBoolean("=",_animated,asmsgbox.__c.getField(true,"False"))) { 
 BA.debugLineNum = 254;BA.debugLine="mBase.Visible = True";
Debug.ShouldStop(536870912);
__ref.getField(false,"_mbase").runMethod(true,"setVisible",asmsgbox.__c.getField(true,"True"));
 }}
;
 BA.debugLineNum = 257;BA.debugLine="xlbl_text.Text = text";
Debug.ShouldStop(1);
__ref.getField(false,"_xlbl_text").runMethod(true,"setText",_text);
 BA.debugLineNum = 259;BA.debugLine="End Sub";
Debug.ShouldStop(4);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _xiv_icon_longclick(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("xiv_icon_LongClick (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,539);
if (RapidSub.canDelegate("xiv_icon_longclick")) { return __ref.runUserSub(false, "asmsgbox","xiv_icon_longclick", __ref);}
 BA.debugLineNum = 539;BA.debugLine="Private Sub xiv_icon_LongClick";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 541;BA.debugLine="icon_longclick_handler";
Debug.ShouldStop(268435456);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_icon_longclick_handler");
 BA.debugLineNum = 543;BA.debugLine="End Sub";
Debug.ShouldStop(1073741824);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _xiv_icon_mouseclicked(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("xiv_icon_MouseClicked (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,523);
if (RapidSub.canDelegate("xiv_icon_mouseclicked")) { return __ref.runUserSub(false, "asmsgbox","xiv_icon_mouseclicked", __ref, _eventdata);}
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 523;BA.debugLine="Private Sub xiv_icon_MouseClicked (EventData As Mo";
Debug.ShouldStop(1024);
 BA.debugLineNum = 525;BA.debugLine="icon_click_handler";
Debug.ShouldStop(4096);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_icon_click_handler");
 BA.debugLineNum = 527;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _xlbl_action_1_mouseclicked(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("xlbl_action_1_MouseClicked (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,896);
if (RapidSub.canDelegate("xlbl_action_1_mouseclicked")) { return __ref.runUserSub(false, "asmsgbox","xlbl_action_1_mouseclicked", __ref, _eventdata);}
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 896;BA.debugLine="Private Sub xlbl_action_1_MouseClicked (EventData";
Debug.ShouldStop(-2147483648);
 BA.debugLineNum = 898;BA.debugLine="result(xlbl_action_1.Tag)";
Debug.ShouldStop(2);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_result",(Object)(BA.numberCast(int.class, __ref.getField(false,"_xlbl_action_1").runMethod(false,"getTag"))));
 BA.debugLineNum = 900;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _xlbl_action_2_mouseclicked(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("xlbl_action_2_MouseClicked (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,902);
if (RapidSub.canDelegate("xlbl_action_2_mouseclicked")) { return __ref.runUserSub(false, "asmsgbox","xlbl_action_2_mouseclicked", __ref, _eventdata);}
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 902;BA.debugLine="Private Sub xlbl_action_2_MouseClicked (EventData";
Debug.ShouldStop(32);
 BA.debugLineNum = 904;BA.debugLine="result(xlbl_action_2.Tag)";
Debug.ShouldStop(128);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_result",(Object)(BA.numberCast(int.class, __ref.getField(false,"_xlbl_action_2").runMethod(false,"getTag"))));
 BA.debugLineNum = 906;BA.debugLine="End Sub";
Debug.ShouldStop(512);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _xlbl_action_3_mouseclicked(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("xlbl_action_3_MouseClicked (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,908);
if (RapidSub.canDelegate("xlbl_action_3_mouseclicked")) { return __ref.runUserSub(false, "asmsgbox","xlbl_action_3_mouseclicked", __ref, _eventdata);}
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 908;BA.debugLine="Private Sub xlbl_action_3_MouseClicked (EventData";
Debug.ShouldStop(2048);
 BA.debugLineNum = 910;BA.debugLine="result(xlbl_action_3.Tag)";
Debug.ShouldStop(8192);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_result",(Object)(BA.numberCast(int.class, __ref.getField(false,"_xlbl_action_3").runMethod(false,"getTag"))));
 BA.debugLineNum = 912;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _xpnl_close_mouseclicked(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("xpnl_close_MouseClicked (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,847);
if (RapidSub.canDelegate("xpnl_close_mouseclicked")) { return __ref.runUserSub(false, "asmsgbox","xpnl_close_mouseclicked", __ref, _eventdata);}
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 847;BA.debugLine="Private Sub xpnl_close_MouseClicked (EventData As";
Debug.ShouldStop(16384);
 BA.debugLineNum = 849;BA.debugLine="closebutton_handler(Sender)";
Debug.ShouldStop(65536);
__ref.runClassMethod (b4j.example.asmsgbox.class, "_closebutton_handler",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper"), asmsgbox.__c.runMethod(false,"Sender",__ref.getField(false, "ba"))));
 BA.debugLineNum = 851;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _xpnl_content_touch(RemoteObject __ref,RemoteObject _action,RemoteObject _x,RemoteObject _y) throws Exception{
try {
		Debug.PushSubsStack("xpnl_content_Touch (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,675);
if (RapidSub.canDelegate("xpnl_content_touch")) { return __ref.runUserSub(false, "asmsgbox","xpnl_content_touch", __ref, _action, _x, _y);}
Debug.locals.put("Action", _action);
Debug.locals.put("X", _x);
Debug.locals.put("Y", _y);
 BA.debugLineNum = 675;BA.debugLine="Private Sub xpnl_content_Touch(Action As Int, X As";
Debug.ShouldStop(4);
 BA.debugLineNum = 678;BA.debugLine="If dragable = 2 Then";
Debug.ShouldStop(32);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_dragable"),BA.numberCast(double.class, 2))) { 
 BA.debugLineNum = 680;BA.debugLine="If Action = xpnl_bottom.TOUCH_ACTION_DOWN Then";
Debug.ShouldStop(128);
if (RemoteObject.solveBoolean("=",_action,BA.numberCast(double.class, __ref.getField(false,"_xpnl_bottom").getField(true,"TOUCH_ACTION_DOWN")))) { 
 BA.debugLineNum = 682;BA.debugLine="donwx  = X";
Debug.ShouldStop(512);
__ref.setField ("_donwx",BA.numberCast(int.class, _x));
 BA.debugLineNum = 683;BA.debugLine="downy  = y";
Debug.ShouldStop(1024);
__ref.setField ("_downy",BA.numberCast(int.class, _y));
 }else 
{ BA.debugLineNum = 685;BA.debugLine="Else if Action = xpnl_bottom.TOUCH_ACTION_MOVE T";
Debug.ShouldStop(4096);
if (RemoteObject.solveBoolean("=",_action,BA.numberCast(double.class, __ref.getField(false,"_xpnl_bottom").getField(true,"TOUCH_ACTION_MOVE")))) { 
 BA.debugLineNum = 687;BA.debugLine="mBase.Top = mBase.Top + y - downy";
Debug.ShouldStop(16384);
__ref.getField(false,"_mbase").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getTop"),_y,__ref.getField(true,"_downy")}, "+-",2, 0));
 BA.debugLineNum = 688;BA.debugLine="mBase.Left = mBase.Left + x - donwx";
Debug.ShouldStop(32768);
__ref.getField(false,"_mbase").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getLeft"),_x,__ref.getField(true,"_donwx")}, "+-",2, 0));
 }}
;
 };
 BA.debugLineNum = 697;BA.debugLine="Return True";
Debug.ShouldStop(16777216);
if (true) return asmsgbox.__c.getField(true,"True");
 BA.debugLineNum = 698;BA.debugLine="End Sub";
Debug.ShouldStop(33554432);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _xpnl_header_touch(RemoteObject __ref,RemoteObject _action,RemoteObject _x,RemoteObject _y) throws Exception{
try {
		Debug.PushSubsStack("xpnl_header_Touch (asmsgbox) ","asmsgbox",1,__ref.getField(false, "ba"),__ref,645);
if (RapidSub.canDelegate("xpnl_header_touch")) { return __ref.runUserSub(false, "asmsgbox","xpnl_header_touch", __ref, _action, _x, _y);}
Debug.locals.put("Action", _action);
Debug.locals.put("X", _x);
Debug.locals.put("Y", _y);
 BA.debugLineNum = 645;BA.debugLine="Private Sub xpnl_header_Touch(Action As Int, X As";
Debug.ShouldStop(16);
 BA.debugLineNum = 647;BA.debugLine="If dragable = 1 Then";
Debug.ShouldStop(64);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_dragable"),BA.numberCast(double.class, 1))) { 
 BA.debugLineNum = 649;BA.debugLine="If Action = xpnl_bottom.TOUCH_ACTION_DOWN Then";
Debug.ShouldStop(256);
if (RemoteObject.solveBoolean("=",_action,BA.numberCast(double.class, __ref.getField(false,"_xpnl_bottom").getField(true,"TOUCH_ACTION_DOWN")))) { 
 BA.debugLineNum = 651;BA.debugLine="donwx  = X";
Debug.ShouldStop(1024);
__ref.setField ("_donwx",BA.numberCast(int.class, _x));
 BA.debugLineNum = 652;BA.debugLine="downy  = y";
Debug.ShouldStop(2048);
__ref.setField ("_downy",BA.numberCast(int.class, _y));
 }else 
{ BA.debugLineNum = 654;BA.debugLine="Else if Action = xpnl_bottom.TOUCH_ACTION_MOVE Th";
Debug.ShouldStop(8192);
if (RemoteObject.solveBoolean("=",_action,BA.numberCast(double.class, __ref.getField(false,"_xpnl_bottom").getField(true,"TOUCH_ACTION_MOVE")))) { 
 BA.debugLineNum = 656;BA.debugLine="mBase.Top = mBase.Top + y - downy";
Debug.ShouldStop(32768);
__ref.getField(false,"_mbase").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getTop"),_y,__ref.getField(true,"_downy")}, "+-",2, 0));
 BA.debugLineNum = 657;BA.debugLine="mBase.Left = mBase.Left + x - donwx";
Debug.ShouldStop(65536);
__ref.getField(false,"_mbase").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getLeft"),_x,__ref.getField(true,"_donwx")}, "+-",2, 0));
 }}
;
 };
 BA.debugLineNum = 667;BA.debugLine="Return True";
Debug.ShouldStop(67108864);
if (true) return asmsgbox.__c.getField(true,"True");
 BA.debugLineNum = 668;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}