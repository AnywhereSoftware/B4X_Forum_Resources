package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class asbottommenu_subs_0 {


public static RemoteObject  _asbm_add_background_click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("asbm_add_background_Click (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1344);
if (RapidSub.canDelegate("asbm_add_background_click")) { return __ref.runUserSub(false, "asbottommenu","asbm_add_background_click", __ref);}
 BA.debugLineNum = 1344;BA.debugLine="Private Sub asbm_add_background_Click";
Debug.ShouldStop(-2147483648);
 BA.debugLineNum = 1346;BA.debugLine="asbm_add_background_handler(Sender)";
Debug.ShouldStop(2);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_asbm_add_background_handler",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper"), asbottommenu.__c.runMethod(false,"Sender",__ref.getField(false, "ba"))));
 BA.debugLineNum = 1348;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbm_add_background_handler(RemoteObject __ref,RemoteObject _senderpanel) throws Exception{
try {
		Debug.PushSubsStack("asbm_add_background_handler (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1356);
if (RapidSub.canDelegate("asbm_add_background_handler")) { return __ref.runUserSub(false, "asbottommenu","asbm_add_background_handler", __ref, _senderpanel);}
Debug.locals.put("SenderPanel", _senderpanel);
 BA.debugLineNum = 1356;BA.debugLine="Private Sub asbm_add_background_handler(SenderPane";
Debug.ShouldStop(2048);
 BA.debugLineNum = 1358;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_Middle";
Debug.ShouldStop(8192);
if (__ref.getField(false,"_xui").runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_MiddleButtonClick"))),(Object)(BA.numberCast(int.class, 0))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 1359;BA.debugLine="CallSub(mCallBack, mEventName & \"_MiddleButtonCl";
Debug.ShouldStop(16384);
asbottommenu.__c.runMethodAndSync(false,"CallSubNew",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_MiddleButtonClick"))));
 };
 BA.debugLineNum = 1363;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbm_add_background_handler_long(RemoteObject __ref,RemoteObject _senderpanel) throws Exception{
try {
		Debug.PushSubsStack("asbm_add_background_handler_long (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1365);
if (RapidSub.canDelegate("asbm_add_background_handler_long")) { return __ref.runUserSub(false, "asbottommenu","asbm_add_background_handler_long", __ref, _senderpanel);}
Debug.locals.put("SenderPanel", _senderpanel);
 BA.debugLineNum = 1365;BA.debugLine="Private Sub asbm_add_background_handler_long(Sende";
Debug.ShouldStop(1048576);
 BA.debugLineNum = 1367;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_Middle";
Debug.ShouldStop(4194304);
if (__ref.getField(false,"_xui").runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_MiddleButtonLongClick"))),(Object)(BA.numberCast(int.class, 0))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 1368;BA.debugLine="CallSub(mCallBack, mEventName & \"_MiddleButtonLo";
Debug.ShouldStop(8388608);
asbottommenu.__c.runMethodAndSync(false,"CallSubNew",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_MiddleButtonLongClick"))));
 };
 BA.debugLineNum = 1372;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbm_add_background_longclick(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("asbm_add_background_LongClick (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1350);
if (RapidSub.canDelegate("asbm_add_background_longclick")) { return __ref.runUserSub(false, "asbottommenu","asbm_add_background_longclick", __ref);}
 BA.debugLineNum = 1350;BA.debugLine="Private Sub asbm_add_background_LongClick";
Debug.ShouldStop(32);
 BA.debugLineNum = 1352;BA.debugLine="asbm_add_background_handler_long(Sender)";
Debug.ShouldStop(128);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_asbm_add_background_handler_long",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper"), asbottommenu.__c.runMethod(false,"Sender",__ref.getField(false, "ba"))));
 BA.debugLineNum = 1354;BA.debugLine="End Sub";
Debug.ShouldStop(512);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbm_page_1_handler(RemoteObject __ref,RemoteObject _senderpanel) throws Exception{
try {
		Debug.PushSubsStack("asbm_page_1_handler (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1003);
if (RapidSub.canDelegate("asbm_page_1_handler")) { return __ref.runUserSub(false, "asbottommenu","asbm_page_1_handler", __ref, _senderpanel);}
RemoteObject _cx = RemoteObject.createImmutable(0);
Debug.locals.put("SenderPanel", _senderpanel);
 BA.debugLineNum = 1003;BA.debugLine="private Sub asbm_page_1_handler(SenderPanel As B4X";
Debug.ShouldStop(1024);
 BA.debugLineNum = 1005;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_Page1C";
Debug.ShouldStop(4096);
if (__ref.getField(false,"_xui").runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_Page1Click"))),(Object)(BA.numberCast(int.class, 0))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 1006;BA.debugLine="CallSub(mCallBack, mEventName & \"_Page1Click\")";
Debug.ShouldStop(8192);
asbottommenu.__c.runMethodAndSync(false,"CallSubNew",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_Page1Click"))));
 };
 BA.debugLineNum = 1008;BA.debugLine="currentpage = 1";
Debug.ShouldStop(32768);
__ref.setField ("_currentpage",BA.numberCast(int.class, 1));
 BA.debugLineNum = 1010;BA.debugLine="Dim cx As Int = asbm_page_1.Left + asbm_page_1.Wi";
Debug.ShouldStop(131072);
_cx = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_1").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_page_1").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "+/",1, 0));Debug.locals.put("cx", _cx);Debug.locals.put("cx", _cx);
 BA.debugLineNum = 1012;BA.debugLine="asbm_slider.SetLayoutAnimated(500,cx - asbm_slide";
Debug.ShouldStop(524288);
__ref.getField(false,"_asbm_slider").runVoidMethod ("SetLayoutAnimated",(Object)(BA.numberCast(int.class, 500)),(Object)(RemoteObject.solve(new RemoteObject[] {_cx,__ref.getField(false,"_asbm_slider").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "-/",1, 0)),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getTop")),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getHeight")));
 BA.debugLineNum = 1013;BA.debugLine="asbm_slider.SetColorAnimated(0,asbm_slider.Color,";
Debug.ShouldStop(1048576);
__ref.getField(false,"_asbm_slider").runVoidMethod ("SetColorAnimated",(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getColor")),(Object)(__ref.getField(true,"_s_color1")));
 BA.debugLineNum = 1016;BA.debugLine="If e_SelectedPageColor = True Then";
Debug.ShouldStop(8388608);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_e_selectedpagecolor"),asbottommenu.__c.getField(true,"True"))) { 
 BA.debugLineNum = 1018;BA.debugLine="asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(33554432);
__ref.getField(false,"_asbm_icon_2").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_2").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White"))).getObject())));
 BA.debugLineNum = 1020;BA.debugLine="If Mode = 1 Then";
Debug.ShouldStop(134217728);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_mode"),BA.numberCast(double.class, 1))) { 
 BA.debugLineNum = 1022;BA.debugLine="asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLev";
Debug.ShouldStop(536870912);
__ref.getField(false,"_asbm_icon_3").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_3").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White"))).getObject())));
 BA.debugLineNum = 1023;BA.debugLine="asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLev";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_asbm_icon_4").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_4").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White"))).getObject())));
 };
 BA.debugLineNum = 1027;BA.debugLine="asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(4);
__ref.getField(false,"_asbm_icon_1").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_1").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(true,"_s_pagecolor"))).getObject())));
 };
 BA.debugLineNum = 1031;BA.debugLine="CreateHaloEffect(asbm_page_1, asbm_page_1.Width/2";
Debug.ShouldStop(64);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_createhaloeffect",(Object)(__ref.getField(false,"_asbm_page_1")),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_1").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_1").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(__ref.getField(true,"_p_clickcolor")));
 BA.debugLineNum = 1033;BA.debugLine="BringToFront(asbm_icon_1)";
Debug.ShouldStop(256);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_bringtofront",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper"), __ref.getField(false,"_asbm_icon_1").getObject()));
 BA.debugLineNum = 1059;BA.debugLine="asbm_slider.BringToFront";
Debug.ShouldStop(4);
__ref.getField(false,"_asbm_slider").runVoidMethod ("BringToFront");
 BA.debugLineNum = 1061;BA.debugLine="End Sub";
Debug.ShouldStop(16);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbm_page_1_mouseclicked(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("asbm_page_1_MouseClicked (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,983);
if (RapidSub.canDelegate("asbm_page_1_mouseclicked")) { return __ref.runUserSub(false, "asbottommenu","asbm_page_1_mouseclicked", __ref, _eventdata);}
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 983;BA.debugLine="Private Sub asbm_page_1_MouseClicked (EventData As";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 985;BA.debugLine="asbm_page_1_handler(Sender)";
Debug.ShouldStop(16777216);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_asbm_page_1_handler",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper"), asbottommenu.__c.runMethod(false,"Sender",__ref.getField(false, "ba"))));
 BA.debugLineNum = 987;BA.debugLine="End Sub";
Debug.ShouldStop(67108864);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbm_page_2_click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("asbm_page_2_Click (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1065);
if (RapidSub.canDelegate("asbm_page_2_click")) { return __ref.runUserSub(false, "asbottommenu","asbm_page_2_click", __ref);}
 BA.debugLineNum = 1065;BA.debugLine="Private Sub asbm_page_2_Click";
Debug.ShouldStop(256);
 BA.debugLineNum = 1067;BA.debugLine="asbm_page_2_handler(Sender)";
Debug.ShouldStop(1024);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_asbm_page_2_handler",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper"), asbottommenu.__c.runMethod(false,"Sender",__ref.getField(false, "ba"))));
 BA.debugLineNum = 1069;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbm_page_2_handler(RemoteObject __ref,RemoteObject _senderpanel) throws Exception{
try {
		Debug.PushSubsStack("asbm_page_2_handler (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1090);
if (RapidSub.canDelegate("asbm_page_2_handler")) { return __ref.runUserSub(false, "asbottommenu","asbm_page_2_handler", __ref, _senderpanel);}
RemoteObject _cx = RemoteObject.createImmutable(0);
Debug.locals.put("SenderPanel", _senderpanel);
 BA.debugLineNum = 1090;BA.debugLine="Private Sub asbm_page_2_handler(SenderPanel As B4X";
Debug.ShouldStop(2);
 BA.debugLineNum = 1092;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_Page2C";
Debug.ShouldStop(8);
if (__ref.getField(false,"_xui").runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_Page2Click"))),(Object)(BA.numberCast(int.class, 0))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 1093;BA.debugLine="CallSub(mCallBack, mEventName & \"_Page2Click\")";
Debug.ShouldStop(16);
asbottommenu.__c.runMethodAndSync(false,"CallSubNew",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_Page2Click"))));
 };
 BA.debugLineNum = 1095;BA.debugLine="currentpage = 2";
Debug.ShouldStop(64);
__ref.setField ("_currentpage",BA.numberCast(int.class, 2));
 BA.debugLineNum = 1096;BA.debugLine="Dim cx As Int = asbm_page_2.Left + asbm_page_2.Wi";
Debug.ShouldStop(128);
_cx = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_2").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_page_2").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "+/",1, 0));Debug.locals.put("cx", _cx);Debug.locals.put("cx", _cx);
 BA.debugLineNum = 1098;BA.debugLine="asbm_slider.SetLayoutAnimated(500,cx - asbm_slide";
Debug.ShouldStop(512);
__ref.getField(false,"_asbm_slider").runVoidMethod ("SetLayoutAnimated",(Object)(BA.numberCast(int.class, 500)),(Object)(RemoteObject.solve(new RemoteObject[] {_cx,__ref.getField(false,"_asbm_slider").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "-/",1, 0)),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getTop")),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getHeight")));
 BA.debugLineNum = 1099;BA.debugLine="asbm_slider.SetColorAnimated(0,asbm_slider.Color,";
Debug.ShouldStop(1024);
__ref.getField(false,"_asbm_slider").runVoidMethod ("SetColorAnimated",(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getColor")),(Object)(__ref.getField(true,"_s_color2")));
 BA.debugLineNum = 1104;BA.debugLine="If e_SelectedPageColor = True Then";
Debug.ShouldStop(32768);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_e_selectedpagecolor"),asbottommenu.__c.getField(true,"True"))) { 
 BA.debugLineNum = 1106;BA.debugLine="asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(131072);
__ref.getField(false,"_asbm_icon_1").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_1").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White"))).getObject())));
 BA.debugLineNum = 1108;BA.debugLine="If Mode = 1 Then";
Debug.ShouldStop(524288);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_mode"),BA.numberCast(double.class, 1))) { 
 BA.debugLineNum = 1110;BA.debugLine="asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLev";
Debug.ShouldStop(2097152);
__ref.getField(false,"_asbm_icon_3").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_3").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White"))).getObject())));
 BA.debugLineNum = 1111;BA.debugLine="asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLev";
Debug.ShouldStop(4194304);
__ref.getField(false,"_asbm_icon_4").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_4").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White"))).getObject())));
 };
 BA.debugLineNum = 1115;BA.debugLine="asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(67108864);
__ref.getField(false,"_asbm_icon_2").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_2").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(true,"_s_pagecolor"))).getObject())));
 };
 BA.debugLineNum = 1119;BA.debugLine="CreateHaloEffect(asbm_page_2, asbm_page_2.Width/2";
Debug.ShouldStop(1073741824);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_createhaloeffect",(Object)(__ref.getField(false,"_asbm_page_2")),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_2").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_2").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(__ref.getField(true,"_p_clickcolor")));
 BA.debugLineNum = 1120;BA.debugLine="BringToFront(asbm_icon_2)";
Debug.ShouldStop(-2147483648);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_bringtofront",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper"), __ref.getField(false,"_asbm_icon_2").getObject()));
 BA.debugLineNum = 1143;BA.debugLine="asbm_slider.BringToFront";
Debug.ShouldStop(4194304);
__ref.getField(false,"_asbm_slider").runVoidMethod ("BringToFront");
 BA.debugLineNum = 1147;BA.debugLine="End Sub";
Debug.ShouldStop(67108864);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbm_page_2_mouseclicked(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("asbm_page_2_MouseClicked (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1074);
if (RapidSub.canDelegate("asbm_page_2_mouseclicked")) { return __ref.runUserSub(false, "asbottommenu","asbm_page_2_mouseclicked", __ref, _eventdata);}
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 1074;BA.debugLine="Private Sub asbm_page_2_MouseClicked (EventData As";
Debug.ShouldStop(131072);
 BA.debugLineNum = 1076;BA.debugLine="asbm_page_2_handler(Sender)";
Debug.ShouldStop(524288);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_asbm_page_2_handler",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper"), asbottommenu.__c.runMethod(false,"Sender",__ref.getField(false, "ba"))));
 BA.debugLineNum = 1078;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbm_page_3_click(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("asbm_page_3_Click (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1149);
if (RapidSub.canDelegate("asbm_page_3_click")) { return __ref.runUserSub(false, "asbottommenu","asbm_page_3_click", __ref);}
 BA.debugLineNum = 1149;BA.debugLine="Private Sub asbm_page_3_Click";
Debug.ShouldStop(268435456);
 BA.debugLineNum = 1151;BA.debugLine="asbm_page_3_handler(Sender)";
Debug.ShouldStop(1073741824);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_asbm_page_3_handler",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper"), asbottommenu.__c.runMethod(false,"Sender",__ref.getField(false, "ba"))));
 BA.debugLineNum = 1153;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbm_page_3_handler(RemoteObject __ref,RemoteObject _senderpanel) throws Exception{
try {
		Debug.PushSubsStack("asbm_page_3_handler (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1173);
if (RapidSub.canDelegate("asbm_page_3_handler")) { return __ref.runUserSub(false, "asbottommenu","asbm_page_3_handler", __ref, _senderpanel);}
RemoteObject _cx = RemoteObject.createImmutable(0);
Debug.locals.put("SenderPanel", _senderpanel);
 BA.debugLineNum = 1173;BA.debugLine="Private Sub asbm_page_3_handler(SenderPanel As B4X";
Debug.ShouldStop(1048576);
 BA.debugLineNum = 1175;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_Page3C";
Debug.ShouldStop(4194304);
if (__ref.getField(false,"_xui").runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_Page3Click"))),(Object)(BA.numberCast(int.class, 0))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 1176;BA.debugLine="CallSub(mCallBack, mEventName & \"_Page3Click\")";
Debug.ShouldStop(8388608);
asbottommenu.__c.runMethodAndSync(false,"CallSubNew",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_Page3Click"))));
 };
 BA.debugLineNum = 1178;BA.debugLine="currentpage = 3";
Debug.ShouldStop(33554432);
__ref.setField ("_currentpage",BA.numberCast(int.class, 3));
 BA.debugLineNum = 1180;BA.debugLine="Dim cx As Int = asbm_page_3.Left + asbm_page_3.Wi";
Debug.ShouldStop(134217728);
_cx = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_3").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_page_3").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "+/",1, 0));Debug.locals.put("cx", _cx);Debug.locals.put("cx", _cx);
 BA.debugLineNum = 1182;BA.debugLine="asbm_slider.SetLayoutAnimated(500,cx - asbm_slide";
Debug.ShouldStop(536870912);
__ref.getField(false,"_asbm_slider").runVoidMethod ("SetLayoutAnimated",(Object)(BA.numberCast(int.class, 500)),(Object)(RemoteObject.solve(new RemoteObject[] {_cx,__ref.getField(false,"_asbm_slider").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "-/",1, 0)),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getTop")),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getHeight")));
 BA.debugLineNum = 1183;BA.debugLine="asbm_slider.SetColorAnimated(0,asbm_slider.Color,";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_asbm_slider").runVoidMethod ("SetColorAnimated",(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getColor")),(Object)(__ref.getField(true,"_s_color3")));
 BA.debugLineNum = 1187;BA.debugLine="If e_SelectedPageColor = True Then";
Debug.ShouldStop(4);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_e_selectedpagecolor"),asbottommenu.__c.getField(true,"True"))) { 
 BA.debugLineNum = 1189;BA.debugLine="asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(16);
__ref.getField(false,"_asbm_icon_1").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_1").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White"))).getObject())));
 BA.debugLineNum = 1190;BA.debugLine="asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(32);
__ref.getField(false,"_asbm_icon_2").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_2").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White"))).getObject())));
 BA.debugLineNum = 1191;BA.debugLine="asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(64);
__ref.getField(false,"_asbm_icon_4").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_4").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White"))).getObject())));
 BA.debugLineNum = 1193;BA.debugLine="asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(256);
__ref.getField(false,"_asbm_icon_3").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_3").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(true,"_s_pagecolor"))).getObject())));
 };
 BA.debugLineNum = 1197;BA.debugLine="CreateHaloEffect(asbm_page_3, asbm_page_3.Width/2";
Debug.ShouldStop(4096);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_createhaloeffect",(Object)(__ref.getField(false,"_asbm_page_3")),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_3").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_3").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(__ref.getField(true,"_p_clickcolor")));
 BA.debugLineNum = 1198;BA.debugLine="BringToFront(asbm_icon_3)";
Debug.ShouldStop(8192);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_bringtofront",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper"), __ref.getField(false,"_asbm_icon_3").getObject()));
 BA.debugLineNum = 1218;BA.debugLine="asbm_slider.BringToFront";
Debug.ShouldStop(2);
__ref.getField(false,"_asbm_slider").runVoidMethod ("BringToFront");
 BA.debugLineNum = 1221;BA.debugLine="End Sub";
Debug.ShouldStop(16);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbm_page_3_mouseclicked(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("asbm_page_3_MouseClicked (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1157);
if (RapidSub.canDelegate("asbm_page_3_mouseclicked")) { return __ref.runUserSub(false, "asbottommenu","asbm_page_3_mouseclicked", __ref, _eventdata);}
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 1157;BA.debugLine="Private Sub asbm_page_3_MouseClicked (EventData As";
Debug.ShouldStop(16);
 BA.debugLineNum = 1159;BA.debugLine="asbm_page_3_handler(Sender)";
Debug.ShouldStop(64);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_asbm_page_3_handler",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper"), asbottommenu.__c.runMethod(false,"Sender",__ref.getField(false, "ba"))));
 BA.debugLineNum = 1161;BA.debugLine="End Sub";
Debug.ShouldStop(256);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbm_page_4_handler(RemoteObject __ref,RemoteObject _senderpanel) throws Exception{
try {
		Debug.PushSubsStack("asbm_page_4_handler (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1244);
if (RapidSub.canDelegate("asbm_page_4_handler")) { return __ref.runUserSub(false, "asbottommenu","asbm_page_4_handler", __ref, _senderpanel);}
RemoteObject _cx = RemoteObject.createImmutable(0);
Debug.locals.put("SenderPanel", _senderpanel);
 BA.debugLineNum = 1244;BA.debugLine="Private Sub asbm_page_4_handler(SenderPanel As B4X";
Debug.ShouldStop(134217728);
 BA.debugLineNum = 1246;BA.debugLine="If xui.SubExists(mCallBack, mEventName & \"_Page4C";
Debug.ShouldStop(536870912);
if (__ref.getField(false,"_xui").runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_Page4Click"))),(Object)(BA.numberCast(int.class, 0))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 1247;BA.debugLine="CallSub(mCallBack, mEventName & \"_Page4Click\")";
Debug.ShouldStop(1073741824);
asbottommenu.__c.runMethodAndSync(false,"CallSubNew",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_mcallback")),(Object)(RemoteObject.concat(__ref.getField(true,"_meventname"),RemoteObject.createImmutable("_Page4Click"))));
 };
 BA.debugLineNum = 1249;BA.debugLine="currentpage = 4";
Debug.ShouldStop(1);
__ref.setField ("_currentpage",BA.numberCast(int.class, 4));
 BA.debugLineNum = 1251;BA.debugLine="Dim cx As Int = asbm_page_4.Left + asbm_page_4.Wi";
Debug.ShouldStop(4);
_cx = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_4").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_page_4").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "+/",1, 0));Debug.locals.put("cx", _cx);Debug.locals.put("cx", _cx);
 BA.debugLineNum = 1253;BA.debugLine="asbm_slider.SetLayoutAnimated(500,cx - asbm_slide";
Debug.ShouldStop(16);
__ref.getField(false,"_asbm_slider").runVoidMethod ("SetLayoutAnimated",(Object)(BA.numberCast(int.class, 500)),(Object)(RemoteObject.solve(new RemoteObject[] {_cx,__ref.getField(false,"_asbm_slider").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "-/",1, 0)),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getTop")),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getHeight")));
 BA.debugLineNum = 1254;BA.debugLine="asbm_slider.SetColorAnimated(0,asbm_slider.Color,";
Debug.ShouldStop(32);
__ref.getField(false,"_asbm_slider").runVoidMethod ("SetColorAnimated",(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getColor")),(Object)(__ref.getField(true,"_s_color4")));
 BA.debugLineNum = 1258;BA.debugLine="If e_SelectedPageColor = True Then";
Debug.ShouldStop(512);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_e_selectedpagecolor"),asbottommenu.__c.getField(true,"True"))) { 
 BA.debugLineNum = 1260;BA.debugLine="asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(2048);
__ref.getField(false,"_asbm_icon_1").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_1").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White"))).getObject())));
 BA.debugLineNum = 1261;BA.debugLine="asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(4096);
__ref.getField(false,"_asbm_icon_2").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_2").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White"))).getObject())));
 BA.debugLineNum = 1262;BA.debugLine="asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(8192);
__ref.getField(false,"_asbm_icon_3").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_3").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White"))).getObject())));
 BA.debugLineNum = 1265;BA.debugLine="asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(65536);
__ref.getField(false,"_asbm_icon_4").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_4").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(true,"_s_pagecolor"))).getObject())));
 };
 BA.debugLineNum = 1269;BA.debugLine="CreateHaloEffect(asbm_page_4, asbm_page_4.Width/2";
Debug.ShouldStop(1048576);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_createhaloeffect",(Object)(__ref.getField(false,"_asbm_page_4")),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_4").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_4").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(__ref.getField(true,"_p_clickcolor")));
 BA.debugLineNum = 1271;BA.debugLine="BringToFront(asbm_icon_4)";
Debug.ShouldStop(4194304);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_bringtofront",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.NodeWrapper.ConcreteNodeWrapper"), __ref.getField(false,"_asbm_icon_4").getObject()));
 BA.debugLineNum = 1293;BA.debugLine="asbm_slider.BringToFront";
Debug.ShouldStop(4096);
__ref.getField(false,"_asbm_slider").runVoidMethod ("BringToFront");
 BA.debugLineNum = 1295;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _asbm_page_4_mouseclicked(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("asbm_page_4_MouseClicked (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1227);
if (RapidSub.canDelegate("asbm_page_4_mouseclicked")) { return __ref.runUserSub(false, "asbottommenu","asbm_page_4_mouseclicked", __ref, _eventdata);}
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 1227;BA.debugLine="Private Sub asbm_page_4_MouseClicked (EventData As";
Debug.ShouldStop(1024);
 BA.debugLineNum = 1229;BA.debugLine="asbm_page_4_handler(Sender)";
Debug.ShouldStop(4096);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_asbm_page_4_handler",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper"), asbottommenu.__c.runMethod(false,"Sender",__ref.getField(false, "ba"))));
 BA.debugLineNum = 1231;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _bringtofront(RemoteObject __ref,RemoteObject _n) throws Exception{
try {
		Debug.PushSubsStack("BringToFront (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,973);
if (RapidSub.canDelegate("bringtofront")) { return __ref.runUserSub(false, "asbottommenu","bringtofront", __ref, _n);}
RemoteObject _parent = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
Debug.locals.put("n", _n);
 BA.debugLineNum = 973;BA.debugLine="Sub BringToFront(n As Node)";
Debug.ShouldStop(4096);
 BA.debugLineNum = 974;BA.debugLine="Dim parent As Pane = n.Parent";
Debug.ShouldStop(8192);
_parent = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
_parent.setObject(_n.runMethod(false,"getParent").getObject());Debug.locals.put("parent", _parent);
 BA.debugLineNum = 975;BA.debugLine="n.RemoveNodeFromParent";
Debug.ShouldStop(16384);
_n.runVoidMethod ("RemoveNodeFromParent");
 BA.debugLineNum = 976;BA.debugLine="parent.AddNode(n, n.Left, n.Top, n.PrefWidth, n.P";
Debug.ShouldStop(32768);
_parent.runVoidMethod ("AddNode",(Object)((_n.getObject())),(Object)(_n.runMethod(true,"getLeft")),(Object)(_n.runMethod(true,"getTop")),(Object)(_n.runMethod(true,"getPrefWidth")),(Object)(_n.runMethod(true,"getPrefHeight")));
 BA.debugLineNum = 977;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _changecolorbasedonalphalevel(RemoteObject __ref,RemoteObject _bmp,RemoteObject _newcolor) throws Exception{
try {
		Debug.PushSubsStack("ChangeColorBasedOnAlphaLevel (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1324);
if (RapidSub.canDelegate("changecolorbasedonalphalevel")) { return __ref.runUserSub(false, "asbottommenu","changecolorbasedonalphalevel", __ref, _bmp, _newcolor);}
RemoteObject _bc = RemoteObject.declareNull("b4j.example.bitmapcreator");
RemoteObject _a1 = RemoteObject.declareNull("b4j.example.bitmapcreator._argbcolor");
RemoteObject _a2 = RemoteObject.declareNull("b4j.example.bitmapcreator._argbcolor");
int _y = 0;
int _x = 0;
Debug.locals.put("bmp", _bmp);
Debug.locals.put("NewColor", _newcolor);
 BA.debugLineNum = 1324;BA.debugLine="Private Sub ChangeColorBasedOnAlphaLevel(bmp As B4";
Debug.ShouldStop(2048);
 BA.debugLineNum = 1325;BA.debugLine="Dim bc As BitmapCreator";
Debug.ShouldStop(4096);
_bc = RemoteObject.createNew ("b4j.example.bitmapcreator");Debug.locals.put("bc", _bc);
 BA.debugLineNum = 1326;BA.debugLine="bc.Initialize(bmp.Width, bmp.Height)";
Debug.ShouldStop(8192);
_bc.runClassMethod (b4j.example.bitmapcreator.class, "_initialize",__ref.getField(false, "ba"),(Object)(BA.numberCast(int.class, _bmp.runMethod(true,"getWidth"))),(Object)(BA.numberCast(int.class, _bmp.runMethod(true,"getHeight"))));
 BA.debugLineNum = 1327;BA.debugLine="bc.CopyPixelsFromBitmap(bmp)";
Debug.ShouldStop(16384);
_bc.runClassMethod (b4j.example.bitmapcreator.class, "_copypixelsfrombitmap",(Object)(_bmp));
 BA.debugLineNum = 1328;BA.debugLine="Dim a1, a2 As ARGBColor";
Debug.ShouldStop(32768);
_a1 = RemoteObject.createNew ("b4j.example.bitmapcreator._argbcolor");Debug.locals.put("a1", _a1);
_a2 = RemoteObject.createNew ("b4j.example.bitmapcreator._argbcolor");Debug.locals.put("a2", _a2);
 BA.debugLineNum = 1329;BA.debugLine="bc.ColorToARGB(NewColor, a1)";
Debug.ShouldStop(65536);
_bc.runClassMethod (b4j.example.bitmapcreator.class, "_colortoargb",(Object)(_newcolor),(Object)(_a1));
 BA.debugLineNum = 1330;BA.debugLine="For y = 0 To bc.mHeight - 1";
Debug.ShouldStop(131072);
{
final int step6 = 1;
final int limit6 = RemoteObject.solve(new RemoteObject[] {_bc.getField(true,"_mheight"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_y = 0 ;
for (;(step6 > 0 && _y <= limit6) || (step6 < 0 && _y >= limit6) ;_y = ((int)(0 + _y + step6))  ) {
Debug.locals.put("y", _y);
 BA.debugLineNum = 1331;BA.debugLine="For x = 0 To bc.mWidth - 1";
Debug.ShouldStop(262144);
{
final int step7 = 1;
final int limit7 = RemoteObject.solve(new RemoteObject[] {_bc.getField(true,"_mwidth"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_x = 0 ;
for (;(step7 > 0 && _x <= limit7) || (step7 < 0 && _x >= limit7) ;_x = ((int)(0 + _x + step7))  ) {
Debug.locals.put("x", _x);
 BA.debugLineNum = 1332;BA.debugLine="bc.GetARGB(x, y, a2)";
Debug.ShouldStop(524288);
_bc.runClassMethod (b4j.example.bitmapcreator.class, "_getargb",(Object)(BA.numberCast(int.class, _x)),(Object)(BA.numberCast(int.class, _y)),(Object)(_a2));
 BA.debugLineNum = 1333;BA.debugLine="If a2.a > 0 Then";
Debug.ShouldStop(1048576);
if (RemoteObject.solveBoolean(">",_a2.getField(true,"a"),BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 1334;BA.debugLine="a2.r = a1.r";
Debug.ShouldStop(2097152);
_a2.setField ("r",_a1.getField(true,"r"));
 BA.debugLineNum = 1335;BA.debugLine="a2.g = a1.g";
Debug.ShouldStop(4194304);
_a2.setField ("g",_a1.getField(true,"g"));
 BA.debugLineNum = 1336;BA.debugLine="a2.b = a1.b";
Debug.ShouldStop(8388608);
_a2.setField ("b",_a1.getField(true,"b"));
 BA.debugLineNum = 1337;BA.debugLine="bc.SetARGB(x, y, a2)";
Debug.ShouldStop(16777216);
_bc.runClassMethod (b4j.example.bitmapcreator.class, "_setargb",(Object)(BA.numberCast(int.class, _x)),(Object)(BA.numberCast(int.class, _y)),(Object)(_a2));
 };
 }
}Debug.locals.put("x", _x);
;
 }
}Debug.locals.put("y", _y);
;
 BA.debugLineNum = 1341;BA.debugLine="Return bc.Bitmap";
Debug.ShouldStop(268435456);
if (true) return _bc.runClassMethod (b4j.example.bitmapcreator.class, "_getbitmap");
 BA.debugLineNum = 1342;BA.debugLine="End Sub";
Debug.ShouldStop(536870912);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 49;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 51;BA.debugLine="Private mEventName As String 'ignore";
asbottommenu._meventname = RemoteObject.createImmutable("");__ref.setField("_meventname",asbottommenu._meventname);
 //BA.debugLineNum = 52;BA.debugLine="Private mCallBack As Object 'ignore";
asbottommenu._mcallback = RemoteObject.createNew ("Object");__ref.setField("_mcallback",asbottommenu._mcallback);
 //BA.debugLineNum = 53;BA.debugLine="Private mBase As B4XView";
asbottommenu._mbase = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_mbase",asbottommenu._mbase);
 //BA.debugLineNum = 55;BA.debugLine="Private Const DefaultColorConstant As Int = -9848";
asbottommenu._defaultcolorconstant = BA.numberCast(int.class, -(double) (0 + 984833));__ref.setField("_defaultcolorconstant",asbottommenu._defaultcolorconstant);
 //BA.debugLineNum = 57;BA.debugLine="Private currentpage As Int = 1";
asbottommenu._currentpage = BA.numberCast(int.class, 1);__ref.setField("_currentpage",asbottommenu._currentpage);
 //BA.debugLineNum = 59;BA.debugLine="Private xui As XUI";
asbottommenu._xui = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper.XUI");__ref.setField("_xui",asbottommenu._xui);
 //BA.debugLineNum = 61;BA.debugLine="Private asbm_page_1,asbm_page_2,asbm_page_3,asbm_";
asbottommenu._asbm_page_1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_asbm_page_1",asbottommenu._asbm_page_1);
asbottommenu._asbm_page_2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_asbm_page_2",asbottommenu._asbm_page_2);
asbottommenu._asbm_page_3 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_asbm_page_3",asbottommenu._asbm_page_3);
asbottommenu._asbm_page_4 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_asbm_page_4",asbottommenu._asbm_page_4);
 //BA.debugLineNum = 62;BA.debugLine="Private asbm_icon_1,asbm_icon_2,asbm_icon_3,asbm_";
asbottommenu._asbm_icon_1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ImageViewWrapper");__ref.setField("_asbm_icon_1",asbottommenu._asbm_icon_1);
asbottommenu._asbm_icon_2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ImageViewWrapper");__ref.setField("_asbm_icon_2",asbottommenu._asbm_icon_2);
asbottommenu._asbm_icon_3 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ImageViewWrapper");__ref.setField("_asbm_icon_3",asbottommenu._asbm_icon_3);
asbottommenu._asbm_icon_4 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ImageViewWrapper");__ref.setField("_asbm_icon_4",asbottommenu._asbm_icon_4);
 //BA.debugLineNum = 63;BA.debugLine="Private asbm_badget_1,asbm_badget_2,asbm_badget_3";
asbottommenu._asbm_badget_1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_asbm_badget_1",asbottommenu._asbm_badget_1);
asbottommenu._asbm_badget_2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_asbm_badget_2",asbottommenu._asbm_badget_2);
asbottommenu._asbm_badget_3 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_asbm_badget_3",asbottommenu._asbm_badget_3);
asbottommenu._asbm_badget_4 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_asbm_badget_4",asbottommenu._asbm_badget_4);
 //BA.debugLineNum = 64;BA.debugLine="Private asbm_slider As B4XView";
asbottommenu._asbm_slider = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_asbm_slider",asbottommenu._asbm_slider);
 //BA.debugLineNum = 67;BA.debugLine="Private asbm_add_icon As B4XView";
asbottommenu._asbm_add_icon = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_asbm_add_icon",asbottommenu._asbm_add_icon);
 //BA.debugLineNum = 68;BA.debugLine="Private asbm_add_background As B4XView";
asbottommenu._asbm_add_background = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_asbm_add_background",asbottommenu._asbm_add_background);
 //BA.debugLineNum = 70;BA.debugLine="Private asbm_parting_line As B4XView";
asbottommenu._asbm_parting_line = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_asbm_parting_line",asbottommenu._asbm_parting_line);
 //BA.debugLineNum = 72;BA.debugLine="Private asbm_page_background As B4XView";
asbottommenu._asbm_page_background = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");__ref.setField("_asbm_page_background",asbottommenu._asbm_page_background);
 //BA.debugLineNum = 79;BA.debugLine="Private s_Color1 As Int";
asbottommenu._s_color1 = RemoteObject.createImmutable(0);__ref.setField("_s_color1",asbottommenu._s_color1);
 //BA.debugLineNum = 80;BA.debugLine="Private s_Color2 As Int";
asbottommenu._s_color2 = RemoteObject.createImmutable(0);__ref.setField("_s_color2",asbottommenu._s_color2);
 //BA.debugLineNum = 81;BA.debugLine="Private s_Color3 As Int";
asbottommenu._s_color3 = RemoteObject.createImmutable(0);__ref.setField("_s_color3",asbottommenu._s_color3);
 //BA.debugLineNum = 82;BA.debugLine="Private s_Color4 As Int";
asbottommenu._s_color4 = RemoteObject.createImmutable(0);__ref.setField("_s_color4",asbottommenu._s_color4);
 //BA.debugLineNum = 84;BA.debugLine="Private b_Color As Int";
asbottommenu._b_color = RemoteObject.createImmutable(0);__ref.setField("_b_color",asbottommenu._b_color);
 //BA.debugLineNum = 86;BA.debugLine="Private p_Line As Int";
asbottommenu._p_line = RemoteObject.createImmutable(0);__ref.setField("_p_line",asbottommenu._p_line);
 //BA.debugLineNum = 88;BA.debugLine="Private m_BackgroundColor As Int";
asbottommenu._m_backgroundcolor = RemoteObject.createImmutable(0);__ref.setField("_m_backgroundcolor",asbottommenu._m_backgroundcolor);
 //BA.debugLineNum = 90;BA.debugLine="Private e_BadgetColor1 As Boolean";
asbottommenu._e_badgetcolor1 = RemoteObject.createImmutable(false);__ref.setField("_e_badgetcolor1",asbottommenu._e_badgetcolor1);
 //BA.debugLineNum = 91;BA.debugLine="Private e_BadgetColor2 As Boolean";
asbottommenu._e_badgetcolor2 = RemoteObject.createImmutable(false);__ref.setField("_e_badgetcolor2",asbottommenu._e_badgetcolor2);
 //BA.debugLineNum = 92;BA.debugLine="Private e_BadgetColor3 As Boolean";
asbottommenu._e_badgetcolor3 = RemoteObject.createImmutable(false);__ref.setField("_e_badgetcolor3",asbottommenu._e_badgetcolor3);
 //BA.debugLineNum = 93;BA.debugLine="Private e_BadgetColor4 As Boolean";
asbottommenu._e_badgetcolor4 = RemoteObject.createImmutable(false);__ref.setField("_e_badgetcolor4",asbottommenu._e_badgetcolor4);
 //BA.debugLineNum = 95;BA.debugLine="Private b_color1 As Int";
asbottommenu._b_color1 = RemoteObject.createImmutable(0);__ref.setField("_b_color1",asbottommenu._b_color1);
 //BA.debugLineNum = 96;BA.debugLine="Private b_color2 As Int";
asbottommenu._b_color2 = RemoteObject.createImmutable(0);__ref.setField("_b_color2",asbottommenu._b_color2);
 //BA.debugLineNum = 97;BA.debugLine="Private b_color3 As Int";
asbottommenu._b_color3 = RemoteObject.createImmutable(0);__ref.setField("_b_color3",asbottommenu._b_color3);
 //BA.debugLineNum = 98;BA.debugLine="Private b_color4 As Int";
asbottommenu._b_color4 = RemoteObject.createImmutable(0);__ref.setField("_b_color4",asbottommenu._b_color4);
 //BA.debugLineNum = 100;BA.debugLine="Private p_ClickColor As Int";
asbottommenu._p_clickcolor = RemoteObject.createImmutable(0);__ref.setField("_p_clickcolor",asbottommenu._p_clickcolor);
 //BA.debugLineNum = 102;BA.debugLine="Private e_SelectedPageColor As Boolean";
asbottommenu._e_selectedpagecolor = RemoteObject.createImmutable(false);__ref.setField("_e_selectedpagecolor",asbottommenu._e_selectedpagecolor);
 //BA.debugLineNum = 104;BA.debugLine="Private s_PageColor As Int";
asbottommenu._s_pagecolor = RemoteObject.createImmutable(0);__ref.setField("_s_pagecolor",asbottommenu._s_pagecolor);
 //BA.debugLineNum = 106;BA.debugLine="Private MiddleButtonVisible As Boolean";
asbottommenu._middlebuttonvisible = RemoteObject.createImmutable(false);__ref.setField("_middlebuttonvisible",asbottommenu._middlebuttonvisible);
 //BA.debugLineNum = 110;BA.debugLine="Private icon1 As B4XBitmap";
asbottommenu._icon1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper");__ref.setField("_icon1",asbottommenu._icon1);
 //BA.debugLineNum = 111;BA.debugLine="Private icon2 As B4XBitmap";
asbottommenu._icon2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper");__ref.setField("_icon2",asbottommenu._icon2);
 //BA.debugLineNum = 112;BA.debugLine="Private icon3 As B4XBitmap";
asbottommenu._icon3 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper");__ref.setField("_icon3",asbottommenu._icon3);
 //BA.debugLineNum = 113;BA.debugLine="Private icon4 As B4XBitmap";
asbottommenu._icon4 = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper");__ref.setField("_icon4",asbottommenu._icon4);
 //BA.debugLineNum = 115;BA.debugLine="Private middleicon As B4XBitmap";
asbottommenu._middleicon = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper");__ref.setField("_middleicon",asbottommenu._middleicon);
 //BA.debugLineNum = 117;BA.debugLine="Private TypeOfMenu As String = \"4 Icon Tabs\"";
asbottommenu._typeofmenu = BA.ObjectToString("4 Icon Tabs");__ref.setField("_typeofmenu",asbottommenu._typeofmenu);
 //BA.debugLineNum = 119;BA.debugLine="Private Mode As Int = 1";
asbottommenu._mode = BA.numberCast(int.class, 1);__ref.setField("_mode",asbottommenu._mode);
 //BA.debugLineNum = 121;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static void  _createhaloeffect(RemoteObject __ref,RemoteObject _parent,RemoteObject _x,RemoteObject _y,RemoteObject _clr) throws Exception{
try {
		Debug.PushSubsStack("CreateHaloEffect (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1297);
if (RapidSub.canDelegate("createhaloeffect")) { __ref.runUserSub(false, "asbottommenu","createhaloeffect", __ref, _parent, _x, _y, _clr); return;}
ResumableSub_CreateHaloEffect rsub = new ResumableSub_CreateHaloEffect(null,__ref,_parent,_x,_y,_clr);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_CreateHaloEffect extends BA.ResumableSub {
public ResumableSub_CreateHaloEffect(b4j.example.asbottommenu parent,RemoteObject __ref,RemoteObject _parent,RemoteObject _x,RemoteObject _y,RemoteObject _clr) {
this.parent = parent;
this.__ref = __ref;
this._parent = _parent;
this._x = _x;
this._y = _y;
this._clr = _clr;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.asbottommenu parent;
RemoteObject _parent;
RemoteObject _x;
RemoteObject _y;
RemoteObject _clr;
RemoteObject _cvs = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XCanvas");
RemoteObject _p = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
RemoteObject _radius = RemoteObject.createImmutable(0);
RemoteObject _bmp = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper");
int _i = 0;
int step8;
int limit8;

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("CreateHaloEffect (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1297);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
Debug.locals.put("_ref", __ref);
Debug.locals.put("Parent", _parent);
Debug.locals.put("x", _x);
Debug.locals.put("y", _y);
Debug.locals.put("clr", _clr);
 BA.debugLineNum = 1298;BA.debugLine="Dim cvs As B4XCanvas";
Debug.ShouldStop(131072);
_cvs = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XCanvas");Debug.locals.put("cvs", _cvs);
 BA.debugLineNum = 1299;BA.debugLine="Dim p As B4XView = xui.CreatePanel(\"\")";
Debug.ShouldStop(262144);
_p = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");
_p = __ref.getField(false,"_xui").runMethod(false,"CreatePanel",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));Debug.locals.put("p", _p);Debug.locals.put("p", _p);
 BA.debugLineNum = 1300;BA.debugLine="Dim radius As Int = 150dip";
Debug.ShouldStop(524288);
_radius = parent.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 150)));Debug.locals.put("radius", _radius);Debug.locals.put("radius", _radius);
 BA.debugLineNum = 1301;BA.debugLine="p.SetLayoutAnimated(0, 0, 0, radius * 2, radius *";
Debug.ShouldStop(1048576);
_p.runVoidMethod ("SetLayoutAnimated",(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_radius,RemoteObject.createImmutable(2)}, "*",0, 1))),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_radius,RemoteObject.createImmutable(2)}, "*",0, 1))));
 BA.debugLineNum = 1302;BA.debugLine="cvs.Initialize(p)";
Debug.ShouldStop(2097152);
_cvs.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(_p));
 BA.debugLineNum = 1303;BA.debugLine="cvs.DrawCircle(cvs.TargetRect.CenterX, cvs.Target";
Debug.ShouldStop(4194304);
_cvs.runVoidMethod ("DrawCircle",(Object)(_cvs.runMethod(false,"getTargetRect").runMethod(true,"getCenterX")),(Object)(_cvs.runMethod(false,"getTargetRect").runMethod(true,"getCenterY")),(Object)(BA.numberCast(float.class, RemoteObject.solve(new RemoteObject[] {_cvs.runMethod(false,"getTargetRect").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0))),(Object)(_clr),(Object)(parent.__c.getField(true,"True")),(Object)(BA.numberCast(float.class, 0)));
 BA.debugLineNum = 1304;BA.debugLine="Dim bmp As B4XBitmap = cvs.CreateBitmap";
Debug.ShouldStop(8388608);
_bmp = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper");
_bmp = _cvs.runMethod(false,"CreateBitmap");Debug.locals.put("bmp", _bmp);Debug.locals.put("bmp", _bmp);
 BA.debugLineNum = 1305;BA.debugLine="For i = 1 To 1";
Debug.ShouldStop(16777216);
if (true) break;

case 1:
//for
this.state = 4;
step8 = 1;
limit8 = 1;
_i = 1 ;
Debug.locals.put("i", _i);
this.state = 5;
if (true) break;

case 5:
//C
this.state = 4;
if ((step8 > 0 && _i <= limit8) || (step8 < 0 && _i >= limit8)) this.state = 3;
if (true) break;

case 6:
//C
this.state = 5;
_i = ((int)(0 + _i + step8)) ;
Debug.locals.put("i", _i);
if (true) break;

case 3:
//C
this.state = 6;
 BA.debugLineNum = 1306;BA.debugLine="CreateHaloEffectHelper(Parent,bmp, x, y, clr, ra";
Debug.ShouldStop(33554432);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_createhaloeffecthelper",(Object)(_parent),(Object)(_bmp),(Object)(_x),(Object)(_y),(Object)(_clr),(Object)(_radius));
 BA.debugLineNum = 1307;BA.debugLine="Sleep(800)";
Debug.ShouldStop(67108864);
parent.__c.runVoidMethod ("Sleep",__ref.getField(false, "ba"),anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this),BA.numberCast(int.class, 800));
this.state = 7;
return;
case 7:
//C
this.state = 6;
;
 if (true) break;
if (true) break;

case 4:
//C
this.state = -1;
Debug.locals.put("i", _i);
;
 BA.debugLineNum = 1309;BA.debugLine="End Sub";
Debug.ShouldStop(268435456);
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
public static void  _createhaloeffecthelper(RemoteObject __ref,RemoteObject _parent,RemoteObject _bmp,RemoteObject _x,RemoteObject _y,RemoteObject _clr,RemoteObject _radius) throws Exception{
try {
		Debug.PushSubsStack("CreateHaloEffectHelper (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1311);
if (RapidSub.canDelegate("createhaloeffecthelper")) { __ref.runUserSub(false, "asbottommenu","createhaloeffecthelper", __ref, _parent, _bmp, _x, _y, _clr, _radius); return;}
ResumableSub_CreateHaloEffectHelper rsub = new ResumableSub_CreateHaloEffectHelper(null,__ref,_parent,_bmp,_x,_y,_clr,_radius);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_CreateHaloEffectHelper extends BA.ResumableSub {
public ResumableSub_CreateHaloEffectHelper(b4j.example.asbottommenu parent,RemoteObject __ref,RemoteObject _parent,RemoteObject _bmp,RemoteObject _x,RemoteObject _y,RemoteObject _clr,RemoteObject _radius) {
this.parent = parent;
this.__ref = __ref;
this._parent = _parent;
this._bmp = _bmp;
this._x = _x;
this._y = _y;
this._clr = _clr;
this._radius = _radius;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.asbottommenu parent;
RemoteObject _parent;
RemoteObject _bmp;
RemoteObject _x;
RemoteObject _y;
RemoteObject _clr;
RemoteObject _radius;
RemoteObject _iv = RemoteObject.declareNull("anywheresoftware.b4j.objects.ImageViewWrapper");
RemoteObject _p = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
RemoteObject _duration = RemoteObject.createImmutable(0);

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("CreateHaloEffectHelper (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1311);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = -1;
Debug.locals.put("_ref", __ref);
Debug.locals.put("Parent", _parent);
Debug.locals.put("bmp", _bmp);
Debug.locals.put("x", _x);
Debug.locals.put("y", _y);
Debug.locals.put("clr", _clr);
Debug.locals.put("radius", _radius);
 BA.debugLineNum = 1312;BA.debugLine="Dim iv As ImageView";
Debug.ShouldStop(-2147483648);
_iv = RemoteObject.createNew ("anywheresoftware.b4j.objects.ImageViewWrapper");Debug.locals.put("iv", _iv);
 BA.debugLineNum = 1313;BA.debugLine="iv.Initialize(\"\")";
Debug.ShouldStop(1);
_iv.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 1314;BA.debugLine="Dim p As B4XView = iv";
Debug.ShouldStop(2);
_p = RemoteObject.createNew ("anywheresoftware.b4j.objects.B4XViewWrapper");
_p.setObject(_iv.getObject());Debug.locals.put("p", _p);
 BA.debugLineNum = 1315;BA.debugLine="p.SetBitmap(bmp)";
Debug.ShouldStop(4);
_p.runVoidMethod ("SetBitmap",(Object)((_bmp.getObject())));
 BA.debugLineNum = 1316;BA.debugLine="Parent.AddView(p, x, y, 0, 0)";
Debug.ShouldStop(8);
_parent.runVoidMethod ("AddView",(Object)((_p.getObject())),(Object)(BA.numberCast(double.class, _x)),(Object)(BA.numberCast(double.class, _y)),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, 0)));
 BA.debugLineNum = 1317;BA.debugLine="Dim duration As Int = 1000";
Debug.ShouldStop(16);
_duration = BA.numberCast(int.class, 1000);Debug.locals.put("duration", _duration);Debug.locals.put("duration", _duration);
 BA.debugLineNum = 1318;BA.debugLine="p.SetLayoutAnimated(duration, x - radius, y - rad";
Debug.ShouldStop(32);
_p.runVoidMethod ("SetLayoutAnimated",(Object)(_duration),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_x,_radius}, "-",1, 1))),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {_y,_radius}, "-",1, 1))),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(2),_radius}, "*",0, 1))),(Object)(BA.numberCast(double.class, RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(2),_radius}, "*",0, 1))));
 BA.debugLineNum = 1319;BA.debugLine="p.SetVisibleAnimated(duration, False)";
Debug.ShouldStop(64);
_p.runVoidMethod ("SetVisibleAnimated",__ref.getField(false, "ba"),(Object)(_duration),(Object)(parent.__c.getField(true,"False")));
 BA.debugLineNum = 1320;BA.debugLine="Sleep(duration)";
Debug.ShouldStop(128);
parent.__c.runVoidMethod ("Sleep",__ref.getField(false, "ba"),anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this),_duration);
this.state = 1;
return;
case 1:
//C
this.state = -1;
;
 BA.debugLineNum = 1321;BA.debugLine="p.RemoveViewFromParent";
Debug.ShouldStop(256);
_p.runVoidMethod ("RemoveViewFromParent");
 BA.debugLineNum = 1322;BA.debugLine="End Sub";
Debug.ShouldStop(512);
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
public static RemoteObject  _designercreateview(RemoteObject __ref,RemoteObject _base,RemoteObject _lbl,RemoteObject _props) throws Exception{
try {
		Debug.PushSubsStack("DesignerCreateView (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,676);
if (RapidSub.canDelegate("designercreateview")) { return __ref.runUserSub(false, "asbottommenu","designercreateview", __ref, _base, _lbl, _props);}
RemoteObject _cx = RemoteObject.createImmutable(0);
RemoteObject _cy = RemoteObject.createImmutable(0);
Debug.locals.put("Base", _base);
Debug.locals.put("Lbl", _lbl);
Debug.locals.put("Props", _props);
 BA.debugLineNum = 676;BA.debugLine="Public Sub DesignerCreateView (Base As Object, Lbl";
Debug.ShouldStop(8);
 BA.debugLineNum = 677;BA.debugLine="mBase = Base";
Debug.ShouldStop(16);
__ref.getField(false,"_mbase").setObject (_base);
 BA.debugLineNum = 680;BA.debugLine="mBase.SetLayoutAnimated(0, mBase.Left, mBase.Top";
Debug.ShouldStop(128);
__ref.getField(false,"_mbase").runVoidMethod ("SetLayoutAnimated",(Object)(BA.numberCast(int.class, 0)),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getLeft")),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getTop")),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getHeight")));
 BA.debugLineNum = 683;BA.debugLine="mBase.Color = xui.Color_Transparent";
Debug.ShouldStop(1024);
__ref.getField(false,"_mbase").runMethod(true,"setColor",__ref.getField(false,"_xui").getField(true,"Color_Transparent"));
 BA.debugLineNum = 687;BA.debugLine="TypeOfMenu =  Props.Get(\"TypeOfMenu\")";
Debug.ShouldStop(16384);
__ref.setField ("_typeofmenu",BA.ObjectToString(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("TypeOfMenu"))))));
 BA.debugLineNum = 689;BA.debugLine="If TypeOfMenu = \"4 Icon Tabs\" Then";
Debug.ShouldStop(65536);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_typeofmenu"),BA.ObjectToString("4 Icon Tabs"))) { 
 BA.debugLineNum = 691;BA.debugLine="Mode = 1";
Debug.ShouldStop(262144);
__ref.setField ("_mode",BA.numberCast(int.class, 1));
 BA.debugLineNum = 693;BA.debugLine="IconTabs4(Props)";
Debug.ShouldStop(1048576);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_icontabs4",(Object)(_props));
 BA.debugLineNum = 696;BA.debugLine="asbm_page_background.Color = b_Color";
Debug.ShouldStop(8388608);
__ref.getField(false,"_asbm_page_background").runMethod(true,"setColor",__ref.getField(true,"_b_color"));
 BA.debugLineNum = 698;BA.debugLine="mBase.AddView(asbm_page_background,0,mBase.Heigh";
Debug.ShouldStop(33554432);
__ref.getField(false,"_mbase").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_page_background").getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0)),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getHeight")));
 BA.debugLineNum = 700;BA.debugLine="asbm_page_background.Top = mBase.Height/2.5 'mBa";
Debug.ShouldStop(134217728);
__ref.getField(false,"_asbm_page_background").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0));
 BA.debugLineNum = 701;BA.debugLine="asbm_page_background.Height = mBase.Height - asb";
Debug.ShouldStop(268435456);
__ref.getField(false,"_asbm_page_background").runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),__ref.getField(false,"_asbm_page_background").runMethod(true,"getTop")}, "-",1, 0));
 BA.debugLineNum = 703;BA.debugLine="mBase.AddView(asbm_parting_line,0,mBase.Height/2";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_mbase").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_parting_line").getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0)),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_asbm_parting_line").runMethod(true,"getHeight")));
 BA.debugLineNum = 705;BA.debugLine="mBase.AddView(asbm_add_background,mBase.Width /";
Debug.ShouldStop(1);
__ref.getField(false,"_mbase").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_add_background").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getWidth"),RemoteObject.createImmutable(2),__ref.getField(false,"_asbm_add_background").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/-/",1, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(1.2)}, "/",0, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(1.2)}, "/",0, 0)));
 BA.debugLineNum = 708;BA.debugLine="asbm_add_background.SetColorAndBorder(m_Backgrou";
Debug.ShouldStop(8);
__ref.getField(false,"_asbm_add_background").runVoidMethod ("SetColorAndBorder",(Object)(__ref.getField(true,"_m_backgroundcolor")),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3))))),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White")),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)));
 BA.debugLineNum = 712;BA.debugLine="asbm_add_background.AddView(asbm_add_icon,10dip,";
Debug.ShouldStop(128);
__ref.getField(false,"_asbm_add_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_add_icon").getObject())),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 10))))),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 10))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getWidth"),RemoteObject.createImmutable(2.5)}, "/",0, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0)));
 BA.debugLineNum = 714;BA.debugLine="asbm_add_icon.Left = asbm_add_background.Width /";
Debug.ShouldStop(512);
__ref.getField(false,"_asbm_add_icon").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getWidth"),RemoteObject.createImmutable(2),__ref.getField(false,"_asbm_add_icon").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/-/",1, 0));
 BA.debugLineNum = 715;BA.debugLine="asbm_add_icon.Top = asbm_add_background.Height /";
Debug.ShouldStop(1024);
__ref.getField(false,"_asbm_add_icon").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2),__ref.getField(false,"_asbm_add_icon").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/-/",1, 0));
 BA.debugLineNum = 719;BA.debugLine="If MiddleButtonVisible = True Then";
Debug.ShouldStop(16384);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_middlebuttonvisible"),asbottommenu.__c.getField(true,"True"))) { 
 BA.debugLineNum = 721;BA.debugLine="asbm_page_background.AddView(asbm_page_1,0,3dip";
Debug.ShouldStop(65536);
__ref.getField(false,"_asbm_page_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_page_1").getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getLeft"),RemoteObject.createImmutable(2)}, "/",0, 0)),(Object)(__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight")));
 }else {
 BA.debugLineNum = 725;BA.debugLine="asbm_page_background.AddView(asbm_page_1,0,3dip";
Debug.ShouldStop(1048576);
__ref.getField(false,"_asbm_page_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_page_1").getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getWidth"),RemoteObject.createImmutable(4)}, "/",0, 0)),(Object)(__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight")));
 };
 BA.debugLineNum = 734;BA.debugLine="If MiddleButtonVisible = True Then";
Debug.ShouldStop(536870912);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_middlebuttonvisible"),asbottommenu.__c.getField(true,"True"))) { 
 BA.debugLineNum = 735;BA.debugLine="asbm_page_background.AddView(asbm_page_2,asbm_pa";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_asbm_page_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_page_2").getObject())),(Object)(__ref.getField(false,"_asbm_page_1").runMethod(true,"getWidth")),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getLeft"),RemoteObject.createImmutable(2)}, "/",0, 0)),(Object)(__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight")));
 }else {
 BA.debugLineNum = 737;BA.debugLine="asbm_page_background.AddView(asbm_page_2,asbm_p";
Debug.ShouldStop(1);
__ref.getField(false,"_asbm_page_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_page_2").getObject())),(Object)(__ref.getField(false,"_asbm_page_1").runMethod(true,"getWidth")),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getWidth"),RemoteObject.createImmutable(4)}, "/",0, 0)),(Object)(__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight")));
 };
 BA.debugLineNum = 741;BA.debugLine="asbm_page_4.Width = asbm_page_background.Height";
Debug.ShouldStop(16);
__ref.getField(false,"_asbm_page_4").runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight"),asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "+",1, 0));
 BA.debugLineNum = 745;BA.debugLine="asbm_page_3.Width = asbm_page_background.Height";
Debug.ShouldStop(256);
__ref.getField(false,"_asbm_page_3").runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight"),asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5)))}, "+",1, 0));
 BA.debugLineNum = 748;BA.debugLine="If MiddleButtonVisible = True Then";
Debug.ShouldStop(2048);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_middlebuttonvisible"),asbottommenu.__c.getField(true,"True"))) { 
 BA.debugLineNum = 749;BA.debugLine="asbm_page_background.AddView(asbm_page_3,asbm_ad";
Debug.ShouldStop(4096);
__ref.getField(false,"_asbm_page_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_page_3").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_add_background").runMethod(true,"getWidth")}, "+",1, 0)),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getLeft"),RemoteObject.createImmutable(2)}, "/",0, 0)),(Object)(__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight")));
 }else {
 BA.debugLineNum = 751;BA.debugLine="asbm_page_background.AddView(asbm_page_3,asbm_p";
Debug.ShouldStop(16384);
__ref.getField(false,"_asbm_page_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_page_3").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_2").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_page_2").runMethod(true,"getWidth")}, "+",1, 0)),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getWidth"),RemoteObject.createImmutable(4)}, "/",0, 0)),(Object)(__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight")));
 };
 BA.debugLineNum = 756;BA.debugLine="If MiddleButtonVisible = True Then";
Debug.ShouldStop(524288);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_middlebuttonvisible"),asbottommenu.__c.getField(true,"True"))) { 
 BA.debugLineNum = 757;BA.debugLine="asbm_page_background.AddView(asbm_page_4,asbm_pa";
Debug.ShouldStop(1048576);
__ref.getField(false,"_asbm_page_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_page_4").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_3").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_page_3").runMethod(true,"getWidth")}, "+",1, 0)),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getLeft"),RemoteObject.createImmutable(2)}, "/",0, 0)),(Object)(__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight")));
 }else {
 BA.debugLineNum = 759;BA.debugLine="asbm_page_background.AddView(asbm_page_4,asbm_p";
Debug.ShouldStop(4194304);
__ref.getField(false,"_asbm_page_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_page_4").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_3").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_page_3").runMethod(true,"getWidth")}, "+",1, 0)),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getWidth"),RemoteObject.createImmutable(4)}, "/",0, 0)),(Object)(__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight")));
 };
 BA.debugLineNum = 763;BA.debugLine="asbm_icon_1.Height = asbm_page_background.Height";
Debug.ShouldStop(67108864);
__ref.getField(false,"_asbm_icon_1").runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0));
 BA.debugLineNum = 764;BA.debugLine="asbm_icon_1.Width = asbm_page_background.Height/";
Debug.ShouldStop(134217728);
__ref.getField(false,"_asbm_icon_1").runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0));
 BA.debugLineNum = 767;BA.debugLine="asbm_icon_2.Height = asbm_page_background.Height";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_asbm_icon_2").runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0));
 BA.debugLineNum = 768;BA.debugLine="asbm_icon_2.Width = asbm_page_background.Height/";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_asbm_icon_2").runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0));
 BA.debugLineNum = 771;BA.debugLine="asbm_icon_3.Height = asbm_page_background.Height";
Debug.ShouldStop(4);
__ref.getField(false,"_asbm_icon_3").runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0));
 BA.debugLineNum = 772;BA.debugLine="asbm_icon_3.Width = asbm_page_background.Height/";
Debug.ShouldStop(8);
__ref.getField(false,"_asbm_icon_3").runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0));
 BA.debugLineNum = 774;BA.debugLine="asbm_icon_4.Height = asbm_page_background.Height";
Debug.ShouldStop(32);
__ref.getField(false,"_asbm_icon_4").runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0));
 BA.debugLineNum = 775;BA.debugLine="asbm_icon_4.Width = asbm_page_background.Height/";
Debug.ShouldStop(64);
__ref.getField(false,"_asbm_icon_4").runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0));
 BA.debugLineNum = 778;BA.debugLine="Dim cx,cy As Int";
Debug.ShouldStop(512);
_cx = RemoteObject.createImmutable(0);Debug.locals.put("cx", _cx);
_cy = RemoteObject.createImmutable(0);Debug.locals.put("cy", _cy);
 BA.debugLineNum = 779;BA.debugLine="cx = asbm_page_1.Left + asbm_page_1.Width/2";
Debug.ShouldStop(1024);
_cx = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_1").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_page_1").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "+/",1, 0));Debug.locals.put("cx", _cx);
 BA.debugLineNum = 780;BA.debugLine="cy = asbm_page_1.Top + asbm_page_1.Height/2.5";
Debug.ShouldStop(2048);
_cy = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_1").runMethod(true,"getTop"),__ref.getField(false,"_asbm_page_1").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "+/",1, 0));Debug.locals.put("cy", _cy);
 BA.debugLineNum = 782;BA.debugLine="asbm_page_1.AddView(asbm_icon_1,5dip,asbm_page_1";
Debug.ShouldStop(8192);
__ref.getField(false,"_asbm_page_1").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_icon_1").getObject())),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_1").runMethod(true,"getHeight"),RemoteObject.createImmutable(2),__ref.getField(false,"_asbm_icon_1").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/-/",1, 0)),(Object)(__ref.getField(false,"_asbm_icon_1").runMethod(true,"getHeight")),(Object)(__ref.getField(false,"_asbm_icon_1").runMethod(true,"getHeight")));
 BA.debugLineNum = 784;BA.debugLine="asbm_icon_1.Left = cx - asbm_icon_1.Width/2";
Debug.ShouldStop(32768);
__ref.getField(false,"_asbm_icon_1").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {_cx,__ref.getField(false,"_asbm_icon_1").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "-/",1, 0));
 BA.debugLineNum = 785;BA.debugLine="asbm_icon_1.Top = cy - asbm_icon_1.Height/2";
Debug.ShouldStop(65536);
__ref.getField(false,"_asbm_icon_1").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {_cy,__ref.getField(false,"_asbm_icon_1").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "-/",1, 0));
 BA.debugLineNum = 788;BA.debugLine="asbm_page_2.AddView(asbm_icon_2,5dip,asbm_page_2";
Debug.ShouldStop(524288);
__ref.getField(false,"_asbm_page_2").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_icon_2").getObject())),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_2").runMethod(true,"getHeight"),RemoteObject.createImmutable(2),__ref.getField(false,"_asbm_icon_2").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/-/",1, 0)),(Object)(__ref.getField(false,"_asbm_icon_2").runMethod(true,"getHeight")),(Object)(__ref.getField(false,"_asbm_icon_2").runMethod(true,"getHeight")));
 BA.debugLineNum = 790;BA.debugLine="asbm_icon_2.Left = cx - asbm_icon_2.Width/2";
Debug.ShouldStop(2097152);
__ref.getField(false,"_asbm_icon_2").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {_cx,__ref.getField(false,"_asbm_icon_2").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "-/",1, 0));
 BA.debugLineNum = 791;BA.debugLine="asbm_icon_2.Top = cy - asbm_icon_2.Height/2";
Debug.ShouldStop(4194304);
__ref.getField(false,"_asbm_icon_2").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {_cy,__ref.getField(false,"_asbm_icon_2").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "-/",1, 0));
 BA.debugLineNum = 794;BA.debugLine="asbm_page_3.AddView(asbm_icon_3,5dip,asbm_page_3";
Debug.ShouldStop(33554432);
__ref.getField(false,"_asbm_page_3").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_icon_3").getObject())),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_3").runMethod(true,"getHeight"),RemoteObject.createImmutable(2),__ref.getField(false,"_asbm_icon_3").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/-/",1, 0)),(Object)(__ref.getField(false,"_asbm_icon_3").runMethod(true,"getHeight")),(Object)(__ref.getField(false,"_asbm_icon_3").runMethod(true,"getHeight")));
 BA.debugLineNum = 796;BA.debugLine="asbm_icon_3.Left = cx - asbm_icon_3.Width/2";
Debug.ShouldStop(134217728);
__ref.getField(false,"_asbm_icon_3").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {_cx,__ref.getField(false,"_asbm_icon_3").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "-/",1, 0));
 BA.debugLineNum = 797;BA.debugLine="asbm_icon_3.Top = cy - asbm_icon_3.Height/2";
Debug.ShouldStop(268435456);
__ref.getField(false,"_asbm_icon_3").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {_cy,__ref.getField(false,"_asbm_icon_3").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "-/",1, 0));
 BA.debugLineNum = 800;BA.debugLine="asbm_page_4.AddView(asbm_icon_4,5dip,asbm_page_4";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_asbm_page_4").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_icon_4").getObject())),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_4").runMethod(true,"getHeight"),RemoteObject.createImmutable(2),__ref.getField(false,"_asbm_icon_4").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/-/",1, 0)),(Object)(__ref.getField(false,"_asbm_icon_4").runMethod(true,"getHeight")),(Object)(__ref.getField(false,"_asbm_icon_4").runMethod(true,"getHeight")));
 BA.debugLineNum = 802;BA.debugLine="asbm_icon_4.Left = cx - asbm_icon_4.Width/2";
Debug.ShouldStop(2);
__ref.getField(false,"_asbm_icon_4").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {_cx,__ref.getField(false,"_asbm_icon_4").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "-/",1, 0));
 BA.debugLineNum = 803;BA.debugLine="asbm_icon_4.Top = cy - asbm_icon_4.Height/2";
Debug.ShouldStop(4);
__ref.getField(false,"_asbm_icon_4").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {_cy,__ref.getField(false,"_asbm_icon_4").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "-/",1, 0));
 BA.debugLineNum = 806;BA.debugLine="asbm_page_background.AddView(asbm_slider,asbm_pa";
Debug.ShouldStop(32);
__ref.getField(false,"_asbm_page_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_slider").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_1").runMethod(true,"getWidth"),RemoteObject.createImmutable(2),__ref.getField(false,"_asbm_slider").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/-/",1, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight"),asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 12)))}, "-",1, 0)),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getHeight")));
 BA.debugLineNum = 808;BA.debugLine="asbm_page_1.AddView(asbm_badget_1,asbm_icon_1.Le";
Debug.ShouldStop(128);
__ref.getField(false,"_asbm_page_1").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_badget_1").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_icon_1").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_icon_1").runMethod(true,"getWidth"),asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))}, "++",2, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_icon_1").runMethod(true,"getTop"),__ref.getField(false,"_asbm_badget_1").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "-/",1, 0)),(Object)(__ref.getField(false,"_asbm_badget_1").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_asbm_badget_1").runMethod(true,"getHeight")));
 BA.debugLineNum = 810;BA.debugLine="asbm_page_2.AddView(asbm_badget_2,asbm_icon_1.Le";
Debug.ShouldStop(512);
__ref.getField(false,"_asbm_page_2").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_badget_2").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_icon_1").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_icon_1").runMethod(true,"getWidth"),asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))}, "++",2, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_icon_2").runMethod(true,"getTop"),__ref.getField(false,"_asbm_badget_2").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "-/",1, 0)),(Object)(__ref.getField(false,"_asbm_badget_2").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_asbm_badget_2").runMethod(true,"getHeight")));
 BA.debugLineNum = 812;BA.debugLine="asbm_page_3.AddView(asbm_badget_3,asbm_icon_1.Le";
Debug.ShouldStop(2048);
__ref.getField(false,"_asbm_page_3").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_badget_3").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_icon_1").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_icon_1").runMethod(true,"getWidth"),asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))}, "++",2, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_icon_3").runMethod(true,"getTop"),__ref.getField(false,"_asbm_badget_3").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "-/",1, 0)),(Object)(__ref.getField(false,"_asbm_badget_3").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_asbm_badget_3").runMethod(true,"getHeight")));
 BA.debugLineNum = 814;BA.debugLine="asbm_page_4.AddView(asbm_badget_4,asbm_icon_1.Le";
Debug.ShouldStop(8192);
__ref.getField(false,"_asbm_page_4").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_badget_4").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_icon_1").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_icon_1").runMethod(true,"getWidth"),asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))}, "++",2, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_icon_4").runMethod(true,"getTop"),__ref.getField(false,"_asbm_badget_4").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "-/",1, 0)),(Object)(__ref.getField(false,"_asbm_badget_4").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_asbm_badget_4").runMethod(true,"getHeight")));
 BA.debugLineNum = 818;BA.debugLine="asbm_badget_1.Visible = e_BadgetColor1";
Debug.ShouldStop(131072);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setVisible",__ref.getField(true,"_e_badgetcolor1"));
 BA.debugLineNum = 819;BA.debugLine="asbm_badget_2.Visible = e_BadgetColor2";
Debug.ShouldStop(262144);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setVisible",__ref.getField(true,"_e_badgetcolor2"));
 BA.debugLineNum = 820;BA.debugLine="asbm_badget_3.Visible = e_BadgetColor3";
Debug.ShouldStop(524288);
__ref.getField(false,"_asbm_badget_3").runMethod(true,"setVisible",__ref.getField(true,"_e_badgetcolor3"));
 BA.debugLineNum = 821;BA.debugLine="asbm_badget_4.Visible = e_BadgetColor4";
Debug.ShouldStop(1048576);
__ref.getField(false,"_asbm_badget_4").runMethod(true,"setVisible",__ref.getField(true,"_e_badgetcolor4"));
 BA.debugLineNum = 824;BA.debugLine="If MiddleButtonVisible = True Then";
Debug.ShouldStop(8388608);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_middlebuttonvisible"),asbottommenu.__c.getField(true,"True"))) { 
 BA.debugLineNum = 825;BA.debugLine="asbm_add_background.Visible = True";
Debug.ShouldStop(16777216);
__ref.getField(false,"_asbm_add_background").runMethod(true,"setVisible",asbottommenu.__c.getField(true,"True"));
 BA.debugLineNum = 826;BA.debugLine="asbm_add_background.Enabled = True";
Debug.ShouldStop(33554432);
__ref.getField(false,"_asbm_add_background").runMethod(true,"setEnabled",asbottommenu.__c.getField(true,"True"));
 }else {
 BA.debugLineNum = 829;BA.debugLine="asbm_add_background.Visible = False";
Debug.ShouldStop(268435456);
__ref.getField(false,"_asbm_add_background").runMethod(true,"setVisible",asbottommenu.__c.getField(true,"False"));
 BA.debugLineNum = 830;BA.debugLine="asbm_add_background.Enabled = False";
Debug.ShouldStop(536870912);
__ref.getField(false,"_asbm_add_background").runMethod(true,"setEnabled",asbottommenu.__c.getField(true,"False"));
 };
 }else 
{ BA.debugLineNum = 833;BA.debugLine="else If TypeOfMenu = \"2 Icon Tabs\" Then";
Debug.ShouldStop(1);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_typeofmenu"),BA.ObjectToString("2 Icon Tabs"))) { 
 BA.debugLineNum = 835;BA.debugLine="Mode = 2";
Debug.ShouldStop(4);
__ref.setField ("_mode",BA.numberCast(int.class, 2));
 BA.debugLineNum = 837;BA.debugLine="IconTabs2(Props)";
Debug.ShouldStop(16);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_icontabs2",(Object)(_props));
 BA.debugLineNum = 840;BA.debugLine="asbm_page_background.Color = b_Color";
Debug.ShouldStop(128);
__ref.getField(false,"_asbm_page_background").runMethod(true,"setColor",__ref.getField(true,"_b_color"));
 BA.debugLineNum = 842;BA.debugLine="mBase.AddView(asbm_page_background,0,mBase.Heigh";
Debug.ShouldStop(512);
__ref.getField(false,"_mbase").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_page_background").getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0)),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getHeight")));
 BA.debugLineNum = 844;BA.debugLine="asbm_page_background.Top = mBase.Height/2.5 'mBa";
Debug.ShouldStop(2048);
__ref.getField(false,"_asbm_page_background").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0));
 BA.debugLineNum = 845;BA.debugLine="asbm_page_background.Height = mBase.Height - asb";
Debug.ShouldStop(4096);
__ref.getField(false,"_asbm_page_background").runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),__ref.getField(false,"_asbm_page_background").runMethod(true,"getTop")}, "-",1, 0));
 BA.debugLineNum = 847;BA.debugLine="mBase.AddView(asbm_parting_line,0,mBase.Height/2";
Debug.ShouldStop(16384);
__ref.getField(false,"_mbase").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_parting_line").getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0)),(Object)(__ref.getField(false,"_mbase").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_asbm_parting_line").runMethod(true,"getHeight")));
 BA.debugLineNum = 849;BA.debugLine="mBase.AddView(asbm_add_background,mBase.Width /";
Debug.ShouldStop(65536);
__ref.getField(false,"_mbase").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_add_background").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getWidth"),RemoteObject.createImmutable(2),__ref.getField(false,"_asbm_add_background").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/-/",1, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(1.2)}, "/",0, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(1.2)}, "/",0, 0)));
 BA.debugLineNum = 852;BA.debugLine="asbm_add_background.SetColorAndBorder(m_Backgrou";
Debug.ShouldStop(524288);
__ref.getField(false,"_asbm_add_background").runVoidMethod ("SetColorAndBorder",(Object)(__ref.getField(true,"_m_backgroundcolor")),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3))))),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White")),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)));
 BA.debugLineNum = 856;BA.debugLine="asbm_add_background.AddView(asbm_add_icon,10dip,";
Debug.ShouldStop(8388608);
__ref.getField(false,"_asbm_add_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_add_icon").getObject())),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 10))))),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 10))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getWidth"),RemoteObject.createImmutable(2.5)}, "/",0, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.5)}, "/",0, 0)));
 BA.debugLineNum = 858;BA.debugLine="asbm_add_icon.Left = asbm_add_background.Width /";
Debug.ShouldStop(33554432);
__ref.getField(false,"_asbm_add_icon").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getWidth"),RemoteObject.createImmutable(2),__ref.getField(false,"_asbm_add_icon").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/-/",1, 0));
 BA.debugLineNum = 859;BA.debugLine="asbm_add_icon.Top = asbm_add_background.Height /";
Debug.ShouldStop(67108864);
__ref.getField(false,"_asbm_add_icon").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2),__ref.getField(false,"_asbm_add_icon").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/-/",1, 0));
 BA.debugLineNum = 861;BA.debugLine="If MiddleButtonVisible = True Then";
Debug.ShouldStop(268435456);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_middlebuttonvisible"),asbottommenu.__c.getField(true,"True"))) { 
 BA.debugLineNum = 862;BA.debugLine="asbm_page_background.AddView(asbm_page_1,0,3dip,";
Debug.ShouldStop(536870912);
__ref.getField(false,"_asbm_page_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_page_1").getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3))))),(Object)(__ref.getField(false,"_asbm_add_background").runMethod(true,"getLeft")),(Object)(__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight")));
 }else {
 BA.debugLineNum = 865;BA.debugLine="asbm_page_background.AddView(asbm_page_1,0,3dip";
Debug.ShouldStop(1);
__ref.getField(false,"_asbm_page_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_page_1").getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0)),(Object)(__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight")));
 };
 BA.debugLineNum = 869;BA.debugLine="If MiddleButtonVisible = True Then";
Debug.ShouldStop(16);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_middlebuttonvisible"),asbottommenu.__c.getField(true,"True"))) { 
 BA.debugLineNum = 870;BA.debugLine="asbm_page_background.AddView(asbm_page_2,asbm_ad";
Debug.ShouldStop(32);
__ref.getField(false,"_asbm_page_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_page_2").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_add_background").runMethod(true,"getWidth")}, "+",1, 0)),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3))))),(Object)(__ref.getField(false,"_asbm_add_background").runMethod(true,"getLeft")),(Object)(__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight")));
 }else {
 BA.debugLineNum = 873;BA.debugLine="asbm_page_background.AddView(asbm_page_2,asbm_p";
Debug.ShouldStop(256);
__ref.getField(false,"_asbm_page_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_page_2").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_1").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_page_1").runMethod(true,"getWidth")}, "+",1, 0)),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_add_background").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/",0, 0)),(Object)(__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight")));
 };
 BA.debugLineNum = 889;BA.debugLine="asbm_icon_1.Height = asbm_page_background.Height";
Debug.ShouldStop(16777216);
__ref.getField(false,"_asbm_icon_1").runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.2)}, "/",0, 0));
 BA.debugLineNum = 890;BA.debugLine="asbm_icon_1.Width = asbm_icon_1.Height";
Debug.ShouldStop(33554432);
__ref.getField(false,"_asbm_icon_1").runMethod(true,"setWidth",__ref.getField(false,"_asbm_icon_1").runMethod(true,"getHeight"));
 BA.debugLineNum = 892;BA.debugLine="asbm_icon_2.Height = asbm_page_background.Height";
Debug.ShouldStop(134217728);
__ref.getField(false,"_asbm_icon_2").runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.2)}, "/",0, 0));
 BA.debugLineNum = 893;BA.debugLine="asbm_icon_2.Width = asbm_icon_2.Height";
Debug.ShouldStop(268435456);
__ref.getField(false,"_asbm_icon_2").runMethod(true,"setWidth",__ref.getField(false,"_asbm_icon_2").runMethod(true,"getHeight"));
 BA.debugLineNum = 902;BA.debugLine="Dim cx,cy As Int";
Debug.ShouldStop(32);
_cx = RemoteObject.createImmutable(0);Debug.locals.put("cx", _cx);
_cy = RemoteObject.createImmutable(0);Debug.locals.put("cy", _cy);
 BA.debugLineNum = 903;BA.debugLine="cx = asbm_page_1.Left + asbm_page_1.Width/2";
Debug.ShouldStop(64);
_cx = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_1").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_page_1").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "+/",1, 0));Debug.locals.put("cx", _cx);
 BA.debugLineNum = 904;BA.debugLine="cy = asbm_page_1.Top + asbm_page_1.Height/2.3";
Debug.ShouldStop(128);
_cy = BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_1").runMethod(true,"getTop"),__ref.getField(false,"_asbm_page_1").runMethod(true,"getHeight"),RemoteObject.createImmutable(2.3)}, "+/",1, 0));Debug.locals.put("cy", _cy);
 BA.debugLineNum = 906;BA.debugLine="asbm_page_1.AddView(asbm_icon_1,5dip,asbm_page_1";
Debug.ShouldStop(512);
__ref.getField(false,"_asbm_page_1").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_icon_1").getObject())),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_1").runMethod(true,"getHeight"),RemoteObject.createImmutable(2),__ref.getField(false,"_asbm_icon_1").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/-/",1, 0)),(Object)(__ref.getField(false,"_asbm_icon_1").runMethod(true,"getHeight")),(Object)(__ref.getField(false,"_asbm_icon_1").runMethod(true,"getHeight")));
 BA.debugLineNum = 908;BA.debugLine="asbm_icon_1.Left = cx - asbm_icon_1.Width/2";
Debug.ShouldStop(2048);
__ref.getField(false,"_asbm_icon_1").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {_cx,__ref.getField(false,"_asbm_icon_1").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "-/",1, 0));
 BA.debugLineNum = 909;BA.debugLine="asbm_icon_1.Top = cy - asbm_icon_1.Height/2";
Debug.ShouldStop(4096);
__ref.getField(false,"_asbm_icon_1").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {_cy,__ref.getField(false,"_asbm_icon_1").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "-/",1, 0));
 BA.debugLineNum = 912;BA.debugLine="asbm_page_2.AddView(asbm_icon_2,5dip,asbm_page_2";
Debug.ShouldStop(32768);
__ref.getField(false,"_asbm_page_2").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_icon_2").getObject())),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 5))))),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_2").runMethod(true,"getHeight"),RemoteObject.createImmutable(2),__ref.getField(false,"_asbm_icon_2").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/-/",1, 0)),(Object)(__ref.getField(false,"_asbm_icon_2").runMethod(true,"getHeight")),(Object)(__ref.getField(false,"_asbm_icon_2").runMethod(true,"getHeight")));
 BA.debugLineNum = 914;BA.debugLine="asbm_icon_2.Left = cx - asbm_icon_2.Width/2";
Debug.ShouldStop(131072);
__ref.getField(false,"_asbm_icon_2").runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {_cx,__ref.getField(false,"_asbm_icon_2").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "-/",1, 0));
 BA.debugLineNum = 915;BA.debugLine="asbm_icon_2.Top = cy - asbm_icon_2.Height/2";
Debug.ShouldStop(262144);
__ref.getField(false,"_asbm_icon_2").runMethod(true,"setTop",RemoteObject.solve(new RemoteObject[] {_cy,__ref.getField(false,"_asbm_icon_2").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "-/",1, 0));
 BA.debugLineNum = 930;BA.debugLine="asbm_page_background.AddView(asbm_slider,asbm_pa";
Debug.ShouldStop(2);
__ref.getField(false,"_asbm_page_background").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_slider").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_1").runMethod(true,"getWidth"),RemoteObject.createImmutable(2),__ref.getField(false,"_asbm_slider").runMethod(true,"getWidth"),RemoteObject.createImmutable(2)}, "/-/",1, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_page_background").runMethod(true,"getHeight"),asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 12)))}, "-",1, 0)),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_asbm_slider").runMethod(true,"getHeight")));
 BA.debugLineNum = 932;BA.debugLine="asbm_page_1.AddView(asbm_badget_1,asbm_icon_1.Le";
Debug.ShouldStop(8);
__ref.getField(false,"_asbm_page_1").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_badget_1").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_icon_1").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_icon_1").runMethod(true,"getWidth"),asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))}, "++",2, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_icon_1").runMethod(true,"getTop"),__ref.getField(false,"_asbm_badget_1").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "-/",1, 0)),(Object)(__ref.getField(false,"_asbm_badget_1").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_asbm_badget_1").runMethod(true,"getHeight")));
 BA.debugLineNum = 934;BA.debugLine="asbm_page_2.AddView(asbm_badget_2,asbm_icon_1.Le";
Debug.ShouldStop(32);
__ref.getField(false,"_asbm_page_2").runVoidMethod ("AddView",(Object)((__ref.getField(false,"_asbm_badget_2").getObject())),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_icon_1").runMethod(true,"getLeft"),__ref.getField(false,"_asbm_icon_1").runMethod(true,"getWidth"),asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 1)))}, "++",2, 0)),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_icon_2").runMethod(true,"getTop"),__ref.getField(false,"_asbm_badget_2").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "-/",1, 0)),(Object)(__ref.getField(false,"_asbm_badget_2").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_asbm_badget_2").runMethod(true,"getHeight")));
 BA.debugLineNum = 942;BA.debugLine="asbm_badget_1.Visible = e_BadgetColor1";
Debug.ShouldStop(8192);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setVisible",__ref.getField(true,"_e_badgetcolor1"));
 BA.debugLineNum = 943;BA.debugLine="asbm_badget_2.Visible = e_BadgetColor2";
Debug.ShouldStop(16384);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setVisible",__ref.getField(true,"_e_badgetcolor2"));
 BA.debugLineNum = 948;BA.debugLine="If MiddleButtonVisible = True Then";
Debug.ShouldStop(524288);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_middlebuttonvisible"),asbottommenu.__c.getField(true,"True"))) { 
 BA.debugLineNum = 949;BA.debugLine="asbm_add_background.Visible = True";
Debug.ShouldStop(1048576);
__ref.getField(false,"_asbm_add_background").runMethod(true,"setVisible",asbottommenu.__c.getField(true,"True"));
 BA.debugLineNum = 950;BA.debugLine="asbm_add_background.Enabled = True";
Debug.ShouldStop(2097152);
__ref.getField(false,"_asbm_add_background").runMethod(true,"setEnabled",asbottommenu.__c.getField(true,"True"));
 }else {
 BA.debugLineNum = 953;BA.debugLine="asbm_add_background.Visible = False";
Debug.ShouldStop(16777216);
__ref.getField(false,"_asbm_add_background").runMethod(true,"setVisible",asbottommenu.__c.getField(true,"False"));
 BA.debugLineNum = 954;BA.debugLine="asbm_add_background.Enabled = False";
Debug.ShouldStop(33554432);
__ref.getField(false,"_asbm_add_background").runMethod(true,"setEnabled",asbottommenu.__c.getField(true,"False"));
 };
 }}
;
 BA.debugLineNum = 964;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _enablebadget1(RemoteObject __ref,RemoteObject _enable) throws Exception{
try {
		Debug.PushSubsStack("EnableBadget1 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1376);
if (RapidSub.canDelegate("enablebadget1")) { return __ref.runUserSub(false, "asbottommenu","enablebadget1", __ref, _enable);}
Debug.locals.put("Enable", _enable);
 BA.debugLineNum = 1376;BA.debugLine="Public Sub EnableBadget1(Enable As Boolean)";
Debug.ShouldStop(-2147483648);
 BA.debugLineNum = 1378;BA.debugLine="e_BadgetColor1 = Enable";
Debug.ShouldStop(2);
__ref.setField ("_e_badgetcolor1",_enable);
 BA.debugLineNum = 1379;BA.debugLine="asbm_badget_1.Visible = e_BadgetColor1";
Debug.ShouldStop(4);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setVisible",__ref.getField(true,"_e_badgetcolor1"));
 BA.debugLineNum = 1380;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _enablebadget2(RemoteObject __ref,RemoteObject _enable) throws Exception{
try {
		Debug.PushSubsStack("EnableBadget2 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1382);
if (RapidSub.canDelegate("enablebadget2")) { return __ref.runUserSub(false, "asbottommenu","enablebadget2", __ref, _enable);}
Debug.locals.put("Enable", _enable);
 BA.debugLineNum = 1382;BA.debugLine="Public Sub EnableBadget2(Enable As Boolean)";
Debug.ShouldStop(32);
 BA.debugLineNum = 1384;BA.debugLine="e_BadgetColor2 = Enable";
Debug.ShouldStop(128);
__ref.setField ("_e_badgetcolor2",_enable);
 BA.debugLineNum = 1385;BA.debugLine="asbm_badget_2.Visible = e_BadgetColor2";
Debug.ShouldStop(256);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setVisible",__ref.getField(true,"_e_badgetcolor2"));
 BA.debugLineNum = 1386;BA.debugLine="End Sub";
Debug.ShouldStop(512);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _enablebadget3(RemoteObject __ref,RemoteObject _enable) throws Exception{
try {
		Debug.PushSubsStack("EnableBadget3 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1388);
if (RapidSub.canDelegate("enablebadget3")) { return __ref.runUserSub(false, "asbottommenu","enablebadget3", __ref, _enable);}
Debug.locals.put("Enable", _enable);
 BA.debugLineNum = 1388;BA.debugLine="Public Sub EnableBadget3(Enable As Boolean)";
Debug.ShouldStop(2048);
 BA.debugLineNum = 1390;BA.debugLine="e_BadgetColor3 = Enable";
Debug.ShouldStop(8192);
__ref.setField ("_e_badgetcolor3",_enable);
 BA.debugLineNum = 1391;BA.debugLine="asbm_badget_3.Visible = e_BadgetColor3";
Debug.ShouldStop(16384);
__ref.getField(false,"_asbm_badget_3").runMethod(true,"setVisible",__ref.getField(true,"_e_badgetcolor3"));
 BA.debugLineNum = 1392;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _enablebadget4(RemoteObject __ref,RemoteObject _enable) throws Exception{
try {
		Debug.PushSubsStack("EnableBadget4 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1394);
if (RapidSub.canDelegate("enablebadget4")) { return __ref.runUserSub(false, "asbottommenu","enablebadget4", __ref, _enable);}
Debug.locals.put("Enable", _enable);
 BA.debugLineNum = 1394;BA.debugLine="Public Sub EnableBadget4(Enable As Boolean)";
Debug.ShouldStop(131072);
 BA.debugLineNum = 1396;BA.debugLine="e_BadgetColor4 = Enable";
Debug.ShouldStop(524288);
__ref.setField ("_e_badgetcolor4",_enable);
 BA.debugLineNum = 1397;BA.debugLine="asbm_badget_4.Visible = e_BadgetColor4";
Debug.ShouldStop(1048576);
__ref.getField(false,"_asbm_badget_4").runMethod(true,"setVisible",__ref.getField(true,"_e_badgetcolor4"));
 BA.debugLineNum = 1398;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _enableselectedpagecolor(RemoteObject __ref,RemoteObject _enable) throws Exception{
try {
		Debug.PushSubsStack("EnableSelectedPageColor (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1431);
if (RapidSub.canDelegate("enableselectedpagecolor")) { return __ref.runUserSub(false, "asbottommenu","enableselectedpagecolor", __ref, _enable);}
Debug.locals.put("enable", _enable);
 BA.debugLineNum = 1431;BA.debugLine="Public Sub EnableSelectedPageColor(enable As Boole";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 1433;BA.debugLine="e_SelectedPageColor = enable";
Debug.ShouldStop(16777216);
__ref.setField ("_e_selectedpagecolor",_enable);
 BA.debugLineNum = 1435;BA.debugLine="End Sub";
Debug.ShouldStop(67108864);
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
		Debug.PushSubsStack("GetBase (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,967);
if (RapidSub.canDelegate("getbase")) { return __ref.runUserSub(false, "asbottommenu","getbase", __ref);}
 BA.debugLineNum = 967;BA.debugLine="Public Sub GetBase As B4XView";
Debug.ShouldStop(64);
 BA.debugLineNum = 968;BA.debugLine="Return mBase";
Debug.ShouldStop(128);
if (true) return __ref.getField(false,"_mbase");
 BA.debugLineNum = 969;BA.debugLine="End Sub";
Debug.ShouldStop(256);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _icontabs2(RemoteObject __ref,RemoteObject _props) throws Exception{
try {
		Debug.PushSubsStack("IconTabs2 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,411);
if (RapidSub.canDelegate("icontabs2")) { return __ref.runUserSub(false, "asbottommenu","icontabs2", __ref, _props);}
RemoteObject _pnl_asbm_page_background = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _pnl_asbm_parting_line = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _pnl_asbm_add_background = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _pnl_asbm_add_icon = RemoteObject.declareNull("anywheresoftware.b4j.objects.ImageViewWrapper");
RemoteObject _pnl_asbm_page_1 = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _pnl_asbm_page_2 = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _pnl_asbm_slider = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _pnl_asbm_badget_1 = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
RemoteObject _pnl_asbm_badget_2 = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
Debug.locals.put("Props", _props);
 BA.debugLineNum = 411;BA.debugLine="Private Sub IconTabs2(Props As Map)";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 420;BA.debugLine="Dim pnl_asbm_page_background As Pane";
Debug.ShouldStop(8);
_pnl_asbm_page_background = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("pnl_asbm_page_background", _pnl_asbm_page_background);
 BA.debugLineNum = 421;BA.debugLine="Dim pnl_asbm_parting_line As Pane";
Debug.ShouldStop(16);
_pnl_asbm_parting_line = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("pnl_asbm_parting_line", _pnl_asbm_parting_line);
 BA.debugLineNum = 422;BA.debugLine="Dim pnl_asbm_add_background As Pane";
Debug.ShouldStop(32);
_pnl_asbm_add_background = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("pnl_asbm_add_background", _pnl_asbm_add_background);
 BA.debugLineNum = 429;BA.debugLine="pnl_asbm_page_background.Initialize(\"asbm_page_ba";
Debug.ShouldStop(4096);
_pnl_asbm_page_background.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_page_background")));
 BA.debugLineNum = 430;BA.debugLine="asbm_page_background = pnl_asbm_page_background";
Debug.ShouldStop(8192);
__ref.getField(false,"_asbm_page_background").setObject (_pnl_asbm_page_background.getObject());
 BA.debugLineNum = 434;BA.debugLine="pnl_asbm_parting_line.Initialize(\"asbm_parting_li";
Debug.ShouldStop(131072);
_pnl_asbm_parting_line.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_parting_line")));
 BA.debugLineNum = 435;BA.debugLine="asbm_parting_line = pnl_asbm_parting_line";
Debug.ShouldStop(262144);
__ref.getField(false,"_asbm_parting_line").setObject (_pnl_asbm_parting_line.getObject());
 BA.debugLineNum = 438;BA.debugLine="pnl_asbm_add_background.Initialize(\"asbm_add_back";
Debug.ShouldStop(2097152);
_pnl_asbm_add_background.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_add_background")));
 BA.debugLineNum = 439;BA.debugLine="asbm_add_background = pnl_asbm_add_background";
Debug.ShouldStop(4194304);
__ref.getField(false,"_asbm_add_background").setObject (_pnl_asbm_add_background.getObject());
 BA.debugLineNum = 440;BA.debugLine="asbm_add_background.Height = mBase.Height/1.2";
Debug.ShouldStop(8388608);
__ref.getField(false,"_asbm_add_background").runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(1.2)}, "/",0, 0));
 BA.debugLineNum = 441;BA.debugLine="asbm_add_background.Width = mBase.Height/1.2";
Debug.ShouldStop(16777216);
__ref.getField(false,"_asbm_add_background").runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(1.2)}, "/",0, 0));
 BA.debugLineNum = 443;BA.debugLine="Dim pnl_asbm_add_icon As ImageView";
Debug.ShouldStop(67108864);
_pnl_asbm_add_icon = RemoteObject.createNew ("anywheresoftware.b4j.objects.ImageViewWrapper");Debug.locals.put("pnl_asbm_add_icon", _pnl_asbm_add_icon);
 BA.debugLineNum = 444;BA.debugLine="pnl_asbm_add_icon.Initialize(\"asbm_icon_4\")";
Debug.ShouldStop(134217728);
_pnl_asbm_add_icon.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_icon_4")));
 BA.debugLineNum = 458;BA.debugLine="pnl_asbm_add_icon.SetImage(xui.LoadBitmap(File.Di";
Debug.ShouldStop(512);
_pnl_asbm_add_icon.runVoidMethod ("SetImage",(Object)((__ref.getField(false,"_xui").runMethod(false,"LoadBitmap",(Object)(asbottommenu.__c.getField(false,"File").runMethod(true,"getDirAssets")),(Object)(RemoteObject.createImmutable("add.png"))).getObject())));
 BA.debugLineNum = 465;BA.debugLine="asbm_add_icon = pnl_asbm_add_icon";
Debug.ShouldStop(65536);
__ref.getField(false,"_asbm_add_icon").setObject (_pnl_asbm_add_icon.getObject());
 BA.debugLineNum = 470;BA.debugLine="Dim pnl_asbm_page_1 As Pane";
Debug.ShouldStop(2097152);
_pnl_asbm_page_1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("pnl_asbm_page_1", _pnl_asbm_page_1);
 BA.debugLineNum = 471;BA.debugLine="Dim pnl_asbm_page_2 As Pane";
Debug.ShouldStop(4194304);
_pnl_asbm_page_2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("pnl_asbm_page_2", _pnl_asbm_page_2);
 BA.debugLineNum = 479;BA.debugLine="pnl_asbm_page_1.Initialize(\"asbm_page_1\")";
Debug.ShouldStop(1073741824);
_pnl_asbm_page_1.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_page_1")));
 BA.debugLineNum = 480;BA.debugLine="asbm_page_1 = pnl_asbm_page_1";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_asbm_page_1").setObject (_pnl_asbm_page_1.getObject());
 BA.debugLineNum = 484;BA.debugLine="pnl_asbm_page_2.Initialize(\"asbm_page_2\")";
Debug.ShouldStop(8);
_pnl_asbm_page_2.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_page_2")));
 BA.debugLineNum = 485;BA.debugLine="asbm_page_2 = pnl_asbm_page_2";
Debug.ShouldStop(16);
__ref.getField(false,"_asbm_page_2").setObject (_pnl_asbm_page_2.getObject());
 BA.debugLineNum = 499;BA.debugLine="asbm_icon_1.Initialize(\"asbm_icon_1\")";
Debug.ShouldStop(262144);
__ref.getField(false,"_asbm_icon_1").runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_icon_1")));
 BA.debugLineNum = 515;BA.debugLine="asbm_icon_2.Initialize(\"asbm_icon_2\")";
Debug.ShouldStop(4);
__ref.getField(false,"_asbm_icon_2").runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_icon_2")));
 BA.debugLineNum = 544;BA.debugLine="Dim pnl_asbm_slider As Pane";
Debug.ShouldStop(-2147483648);
_pnl_asbm_slider = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("pnl_asbm_slider", _pnl_asbm_slider);
 BA.debugLineNum = 553;BA.debugLine="pnl_asbm_slider.Initialize(\"asbm_slider\")";
Debug.ShouldStop(256);
_pnl_asbm_slider.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_slider")));
 BA.debugLineNum = 554;BA.debugLine="asbm_slider = pnl_asbm_slider";
Debug.ShouldStop(512);
__ref.getField(false,"_asbm_slider").setObject (_pnl_asbm_slider.getObject());
 BA.debugLineNum = 564;BA.debugLine="Dim pnl_asbm_badget_1 As Label";
Debug.ShouldStop(524288);
_pnl_asbm_badget_1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("pnl_asbm_badget_1", _pnl_asbm_badget_1);
 BA.debugLineNum = 565;BA.debugLine="pnl_asbm_badget_1.Initialize(\"asbm_badget_1\")";
Debug.ShouldStop(1048576);
_pnl_asbm_badget_1.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_badget_1")));
 BA.debugLineNum = 566;BA.debugLine="asbm_badget_1 = pnl_asbm_badget_1";
Debug.ShouldStop(2097152);
__ref.getField(false,"_asbm_badget_1").setObject (_pnl_asbm_badget_1.getObject());
 BA.debugLineNum = 567;BA.debugLine="asbm_badget_1.Font = xui.CreateDefaultBoldFont(10";
Debug.ShouldStop(4194304);
__ref.getField(false,"_asbm_badget_1").runMethod(false,"setFont",__ref.getField(false,"_xui").runMethod(false,"CreateDefaultBoldFont",(Object)(BA.numberCast(float.class, 10))));
 BA.debugLineNum = 568;BA.debugLine="asbm_badget_1.TextColor = xui.Color_White";
Debug.ShouldStop(8388608);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setTextColor",__ref.getField(false,"_xui").getField(true,"Color_White"));
 BA.debugLineNum = 569;BA.debugLine="asbm_badget_1.SetTextAlignment(\"CENTER\",\"CENTER\")";
Debug.ShouldStop(16777216);
__ref.getField(false,"_asbm_badget_1").runVoidMethod ("SetTextAlignment",(Object)(BA.ObjectToString("CENTER")),(Object)(RemoteObject.createImmutable("CENTER")));
 BA.debugLineNum = 573;BA.debugLine="Dim pnl_asbm_badget_2 As Label";
Debug.ShouldStop(268435456);
_pnl_asbm_badget_2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("pnl_asbm_badget_2", _pnl_asbm_badget_2);
 BA.debugLineNum = 574;BA.debugLine="pnl_asbm_badget_2.Initialize(\"asbm_badget_2\")";
Debug.ShouldStop(536870912);
_pnl_asbm_badget_2.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_badget_2")));
 BA.debugLineNum = 575;BA.debugLine="asbm_badget_2 = pnl_asbm_badget_2";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_asbm_badget_2").setObject (_pnl_asbm_badget_2.getObject());
 BA.debugLineNum = 576;BA.debugLine="asbm_badget_2.Font = xui.CreateDefaultBoldFont(10";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_asbm_badget_2").runMethod(false,"setFont",__ref.getField(false,"_xui").runMethod(false,"CreateDefaultBoldFont",(Object)(BA.numberCast(float.class, 10))));
 BA.debugLineNum = 577;BA.debugLine="asbm_badget_2.TextColor = xui.Color_White";
Debug.ShouldStop(1);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setTextColor",__ref.getField(false,"_xui").getField(true,"Color_White"));
 BA.debugLineNum = 578;BA.debugLine="asbm_badget_2.SetTextAlignment(\"CENTER\",\"CENTER\")";
Debug.ShouldStop(2);
__ref.getField(false,"_asbm_badget_2").runVoidMethod ("SetTextAlignment",(Object)(BA.ObjectToString("CENTER")),(Object)(RemoteObject.createImmutable("CENTER")));
 BA.debugLineNum = 596;BA.debugLine="s_Color1 = xui.PaintOrColorToColor(Props.Get(\"Sli";
Debug.ShouldStop(524288);
__ref.setField ("_s_color1",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("SliderColor1")))))));
 BA.debugLineNum = 597;BA.debugLine="s_Color2 = xui.PaintOrColorToColor(Props.Get(\"Sli";
Debug.ShouldStop(1048576);
__ref.setField ("_s_color2",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("SliderColor2")))))));
 BA.debugLineNum = 600;BA.debugLine="b_Color = xui.PaintOrColorToColor(Props.Get(\"Back";
Debug.ShouldStop(8388608);
__ref.setField ("_b_color",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("BackgroundColor")))))));
 BA.debugLineNum = 602;BA.debugLine="p_Line = xui.PaintOrColorToColor(Props.Get(\"Parti";
Debug.ShouldStop(33554432);
__ref.setField ("_p_line",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("PartingLine")))))));
 BA.debugLineNum = 604;BA.debugLine="m_BackgroundColor = xui.PaintOrColorToColor(Props";
Debug.ShouldStop(134217728);
__ref.setField ("_m_backgroundcolor",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("MiddleBackgroundColor")))))));
 BA.debugLineNum = 606;BA.debugLine="e_BadgetColor1 = Props.Get(\"EnableBadgetColor1\")";
Debug.ShouldStop(536870912);
__ref.setField ("_e_badgetcolor1",BA.ObjectToBoolean(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("EnableBadgetColor1"))))));
 BA.debugLineNum = 607;BA.debugLine="e_BadgetColor2 = Props.Get(\"EnableBadgetColor2\")";
Debug.ShouldStop(1073741824);
__ref.setField ("_e_badgetcolor2",BA.ObjectToBoolean(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("EnableBadgetColor2"))))));
 BA.debugLineNum = 610;BA.debugLine="b_color1 = xui.PaintOrColorToColor(Props.Get(\"Bad";
Debug.ShouldStop(2);
__ref.setField ("_b_color1",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("BadgetColor1")))))));
 BA.debugLineNum = 611;BA.debugLine="b_color2 = xui.PaintOrColorToColor(Props.Get(\"Bad";
Debug.ShouldStop(4);
__ref.setField ("_b_color2",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("BadgetColor2")))))));
 BA.debugLineNum = 614;BA.debugLine="p_ClickColor = xui.PaintOrColorToColor(Props.Get(";
Debug.ShouldStop(32);
__ref.setField ("_p_clickcolor",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("PageClickColor")))))));
 BA.debugLineNum = 616;BA.debugLine="e_SelectedPageColor = Props.Get(\"EnableSelectedPa";
Debug.ShouldStop(128);
__ref.setField ("_e_selectedpagecolor",BA.ObjectToBoolean(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("EnableSelectedPageColor"))))));
 BA.debugLineNum = 618;BA.debugLine="s_PageColor = xui.PaintOrColorToColor(Props.Get(\"";
Debug.ShouldStop(512);
__ref.setField ("_s_pagecolor",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("SelectedPageColor")))))));
 BA.debugLineNum = 620;BA.debugLine="MiddleButtonVisible = Props.Get(\"MiddleButtonVisi";
Debug.ShouldStop(2048);
__ref.setField ("_middlebuttonvisible",BA.ObjectToBoolean(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("MiddleButtonVisible"))))));
 BA.debugLineNum = 623;BA.debugLine="asbm_page_1.Color = b_Color";
Debug.ShouldStop(16384);
__ref.getField(false,"_asbm_page_1").runMethod(true,"setColor",__ref.getField(true,"_b_color"));
 BA.debugLineNum = 624;BA.debugLine="asbm_page_2.Color = b_Color";
Debug.ShouldStop(32768);
__ref.getField(false,"_asbm_page_2").runMethod(true,"setColor",__ref.getField(true,"_b_color"));
 BA.debugLineNum = 631;BA.debugLine="asbm_slider.Height = 2dip";
Debug.ShouldStop(4194304);
__ref.getField(false,"_asbm_slider").runMethod(true,"setHeight",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 2)))));
 BA.debugLineNum = 632;BA.debugLine="asbm_slider.Width = 40dip";
Debug.ShouldStop(8388608);
__ref.getField(false,"_asbm_slider").runMethod(true,"setWidth",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 40)))));
 BA.debugLineNum = 633;BA.debugLine="asbm_slider.SetColorAndBorder(s_Color1,0,xui.Colo";
Debug.ShouldStop(16777216);
__ref.getField(false,"_asbm_slider").runVoidMethod ("SetColorAndBorder",(Object)(__ref.getField(true,"_s_color1")),(Object)(BA.numberCast(double.class, 0)),(Object)(__ref.getField(false,"_xui").getField(true,"Color_Transparent")),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_slider").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)));
 BA.debugLineNum = 638;BA.debugLine="asbm_parting_line.Height = 3dip";
Debug.ShouldStop(536870912);
__ref.getField(false,"_asbm_parting_line").runMethod(true,"setHeight",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3)))));
 BA.debugLineNum = 639;BA.debugLine="asbm_parting_line.Color = p_Line";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_asbm_parting_line").runMethod(true,"setColor",__ref.getField(true,"_p_line"));
 BA.debugLineNum = 643;BA.debugLine="asbm_badget_1.Width = 18dip";
Debug.ShouldStop(4);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setWidth",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 18)))));
 BA.debugLineNum = 644;BA.debugLine="asbm_badget_1.Height = 18dip";
Debug.ShouldStop(8);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setHeight",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 18)))));
 BA.debugLineNum = 645;BA.debugLine="asbm_badget_1.SetColorAndBorder(b_color1,0dip,xui";
Debug.ShouldStop(16);
__ref.getField(false,"_asbm_badget_1").runVoidMethod ("SetColorAndBorder",(Object)(__ref.getField(true,"_b_color1")),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 0))))),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White")),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_badget_1").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)));
 BA.debugLineNum = 646;BA.debugLine="asbm_badget_1.Text = 0";
Debug.ShouldStop(32);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setText",BA.NumberToString(0));
 BA.debugLineNum = 649;BA.debugLine="asbm_badget_2.Width = 18dip";
Debug.ShouldStop(256);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setWidth",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 18)))));
 BA.debugLineNum = 650;BA.debugLine="asbm_badget_2.Height = 18dip";
Debug.ShouldStop(512);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setHeight",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 18)))));
 BA.debugLineNum = 651;BA.debugLine="asbm_badget_2.SetColorAndBorder(b_color2,0dip,xui";
Debug.ShouldStop(1024);
__ref.getField(false,"_asbm_badget_2").runVoidMethod ("SetColorAndBorder",(Object)(__ref.getField(true,"_b_color2")),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 0))))),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White")),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_badget_2").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)));
 BA.debugLineNum = 652;BA.debugLine="asbm_badget_2.Text = 0";
Debug.ShouldStop(2048);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setText",BA.NumberToString(0));
 BA.debugLineNum = 664;BA.debugLine="End Sub";
Debug.ShouldStop(8388608);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _icontabs4(RemoteObject __ref,RemoteObject _props) throws Exception{
try {
		Debug.PushSubsStack("IconTabs4 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,123);
if (RapidSub.canDelegate("icontabs4")) { return __ref.runUserSub(false, "asbottommenu","icontabs4", __ref, _props);}
RemoteObject _pnl_asbm_page_background = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _pnl_asbm_parting_line = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _pnl_asbm_add_background = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _pnl_asbm_add_icon = RemoteObject.declareNull("anywheresoftware.b4j.objects.ImageViewWrapper");
RemoteObject _pnl_asbm_page_1 = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _pnl_asbm_page_2 = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _pnl_asbm_page_3 = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _pnl_asbm_page_4 = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _pnl_asbm_icon_4 = RemoteObject.declareNull("anywheresoftware.b4j.objects.ImageViewWrapper");
RemoteObject _pnl_asbm_slider = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");
RemoteObject _pnl_asbm_badget_1 = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
RemoteObject _pnl_asbm_badget_2 = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
RemoteObject _pnl_asbm_badget_3 = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
RemoteObject _pnl_asbm_badget_4 = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
Debug.locals.put("Props", _props);
 BA.debugLineNum = 123;BA.debugLine="Private Sub IconTabs4(Props As Map)";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 132;BA.debugLine="Dim pnl_asbm_page_background As Pane";
Debug.ShouldStop(8);
_pnl_asbm_page_background = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("pnl_asbm_page_background", _pnl_asbm_page_background);
 BA.debugLineNum = 133;BA.debugLine="Dim pnl_asbm_parting_line As Pane";
Debug.ShouldStop(16);
_pnl_asbm_parting_line = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("pnl_asbm_parting_line", _pnl_asbm_parting_line);
 BA.debugLineNum = 134;BA.debugLine="Dim pnl_asbm_add_background As Pane";
Debug.ShouldStop(32);
_pnl_asbm_add_background = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("pnl_asbm_add_background", _pnl_asbm_add_background);
 BA.debugLineNum = 140;BA.debugLine="pnl_asbm_page_background.Initialize(\"asbm_page_ba";
Debug.ShouldStop(2048);
_pnl_asbm_page_background.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_page_background")));
 BA.debugLineNum = 141;BA.debugLine="asbm_page_background = pnl_asbm_page_background";
Debug.ShouldStop(4096);
__ref.getField(false,"_asbm_page_background").setObject (_pnl_asbm_page_background.getObject());
 BA.debugLineNum = 145;BA.debugLine="pnl_asbm_parting_line.Initialize(\"asbm_parting_li";
Debug.ShouldStop(65536);
_pnl_asbm_parting_line.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_parting_line")));
 BA.debugLineNum = 146;BA.debugLine="asbm_parting_line = pnl_asbm_parting_line";
Debug.ShouldStop(131072);
__ref.getField(false,"_asbm_parting_line").setObject (_pnl_asbm_parting_line.getObject());
 BA.debugLineNum = 149;BA.debugLine="pnl_asbm_add_background.Initialize(\"asbm_add_back";
Debug.ShouldStop(1048576);
_pnl_asbm_add_background.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_add_background")));
 BA.debugLineNum = 150;BA.debugLine="asbm_add_background = pnl_asbm_add_background";
Debug.ShouldStop(2097152);
__ref.getField(false,"_asbm_add_background").setObject (_pnl_asbm_add_background.getObject());
 BA.debugLineNum = 153;BA.debugLine="asbm_add_background.Height = mBase.Height/1.2";
Debug.ShouldStop(16777216);
__ref.getField(false,"_asbm_add_background").runMethod(true,"setHeight",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(1.2)}, "/",0, 0));
 BA.debugLineNum = 154;BA.debugLine="asbm_add_background.Width = mBase.Height/1.2";
Debug.ShouldStop(33554432);
__ref.getField(false,"_asbm_add_background").runMethod(true,"setWidth",RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mbase").runMethod(true,"getHeight"),RemoteObject.createImmutable(1.2)}, "/",0, 0));
 BA.debugLineNum = 156;BA.debugLine="Dim pnl_asbm_add_icon As ImageView";
Debug.ShouldStop(134217728);
_pnl_asbm_add_icon = RemoteObject.createNew ("anywheresoftware.b4j.objects.ImageViewWrapper");Debug.locals.put("pnl_asbm_add_icon", _pnl_asbm_add_icon);
 BA.debugLineNum = 157;BA.debugLine="pnl_asbm_add_icon.Initialize(\"asbm_icon_4\")";
Debug.ShouldStop(268435456);
_pnl_asbm_add_icon.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_icon_4")));
 BA.debugLineNum = 175;BA.debugLine="pnl_asbm_add_icon.SetImage(xui.LoadBitmap(File.Di";
Debug.ShouldStop(16384);
_pnl_asbm_add_icon.runVoidMethod ("SetImage",(Object)((__ref.getField(false,"_xui").runMethod(false,"LoadBitmap",(Object)(asbottommenu.__c.getField(false,"File").runMethod(true,"getDirAssets")),(Object)(RemoteObject.createImmutable("add.png"))).getObject())));
 BA.debugLineNum = 182;BA.debugLine="asbm_add_icon = pnl_asbm_add_icon";
Debug.ShouldStop(2097152);
__ref.getField(false,"_asbm_add_icon").setObject (_pnl_asbm_add_icon.getObject());
 BA.debugLineNum = 194;BA.debugLine="Dim pnl_asbm_page_1 As Pane";
Debug.ShouldStop(2);
_pnl_asbm_page_1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("pnl_asbm_page_1", _pnl_asbm_page_1);
 BA.debugLineNum = 195;BA.debugLine="Dim pnl_asbm_page_2 As Pane";
Debug.ShouldStop(4);
_pnl_asbm_page_2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("pnl_asbm_page_2", _pnl_asbm_page_2);
 BA.debugLineNum = 196;BA.debugLine="Dim pnl_asbm_page_3 As Pane";
Debug.ShouldStop(8);
_pnl_asbm_page_3 = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("pnl_asbm_page_3", _pnl_asbm_page_3);
 BA.debugLineNum = 197;BA.debugLine="Dim pnl_asbm_page_4 As Pane";
Debug.ShouldStop(16);
_pnl_asbm_page_4 = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("pnl_asbm_page_4", _pnl_asbm_page_4);
 BA.debugLineNum = 203;BA.debugLine="pnl_asbm_page_1.Initialize(\"asbm_page_1\")";
Debug.ShouldStop(1024);
_pnl_asbm_page_1.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_page_1")));
 BA.debugLineNum = 204;BA.debugLine="asbm_page_1 = pnl_asbm_page_1";
Debug.ShouldStop(2048);
__ref.getField(false,"_asbm_page_1").setObject (_pnl_asbm_page_1.getObject());
 BA.debugLineNum = 208;BA.debugLine="pnl_asbm_page_2.Initialize(\"asbm_page_2\")";
Debug.ShouldStop(32768);
_pnl_asbm_page_2.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_page_2")));
 BA.debugLineNum = 209;BA.debugLine="asbm_page_2 = pnl_asbm_page_2";
Debug.ShouldStop(65536);
__ref.getField(false,"_asbm_page_2").setObject (_pnl_asbm_page_2.getObject());
 BA.debugLineNum = 213;BA.debugLine="pnl_asbm_page_3.Initialize(\"asbm_page_3\")";
Debug.ShouldStop(1048576);
_pnl_asbm_page_3.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_page_3")));
 BA.debugLineNum = 214;BA.debugLine="asbm_page_3 = pnl_asbm_page_3";
Debug.ShouldStop(2097152);
__ref.getField(false,"_asbm_page_3").setObject (_pnl_asbm_page_3.getObject());
 BA.debugLineNum = 218;BA.debugLine="pnl_asbm_page_4.Initialize(\"asbm_page_4\")";
Debug.ShouldStop(33554432);
_pnl_asbm_page_4.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_page_4")));
 BA.debugLineNum = 219;BA.debugLine="asbm_page_4 = pnl_asbm_page_4";
Debug.ShouldStop(67108864);
__ref.getField(false,"_asbm_page_4").setObject (_pnl_asbm_page_4.getObject());
 BA.debugLineNum = 223;BA.debugLine="asbm_icon_1.Initialize(\"asbm_icon_1\")";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_asbm_icon_1").runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_icon_1")));
 BA.debugLineNum = 241;BA.debugLine="asbm_icon_2.Initialize(\"asbm_icon_2\")";
Debug.ShouldStop(65536);
__ref.getField(false,"_asbm_icon_2").runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_icon_2")));
 BA.debugLineNum = 255;BA.debugLine="asbm_icon_3.Initialize(\"asbm_icon_3\")";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_asbm_icon_3").runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_icon_3")));
 BA.debugLineNum = 269;BA.debugLine="Dim pnl_asbm_icon_4 As ImageView";
Debug.ShouldStop(4096);
_pnl_asbm_icon_4 = RemoteObject.createNew ("anywheresoftware.b4j.objects.ImageViewWrapper");Debug.locals.put("pnl_asbm_icon_4", _pnl_asbm_icon_4);
 BA.debugLineNum = 270;BA.debugLine="pnl_asbm_icon_4.Initialize(\"asbm_icon_4\")";
Debug.ShouldStop(8192);
_pnl_asbm_icon_4.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_icon_4")));
 BA.debugLineNum = 283;BA.debugLine="asbm_icon_4 = pnl_asbm_icon_4";
Debug.ShouldStop(67108864);
__ref.setField ("_asbm_icon_4",_pnl_asbm_icon_4);
 BA.debugLineNum = 293;BA.debugLine="Dim pnl_asbm_slider As Pane";
Debug.ShouldStop(16);
_pnl_asbm_slider = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper");Debug.locals.put("pnl_asbm_slider", _pnl_asbm_slider);
 BA.debugLineNum = 297;BA.debugLine="pnl_asbm_slider.Initialize(\"asbm_slider\")";
Debug.ShouldStop(256);
_pnl_asbm_slider.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_slider")));
 BA.debugLineNum = 298;BA.debugLine="asbm_slider = pnl_asbm_slider";
Debug.ShouldStop(512);
__ref.getField(false,"_asbm_slider").setObject (_pnl_asbm_slider.getObject());
 BA.debugLineNum = 303;BA.debugLine="Dim pnl_asbm_badget_1 As Label";
Debug.ShouldStop(16384);
_pnl_asbm_badget_1 = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("pnl_asbm_badget_1", _pnl_asbm_badget_1);
 BA.debugLineNum = 304;BA.debugLine="pnl_asbm_badget_1.Initialize(\"asbm_badget_1\")";
Debug.ShouldStop(32768);
_pnl_asbm_badget_1.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_badget_1")));
 BA.debugLineNum = 305;BA.debugLine="asbm_badget_1 = pnl_asbm_badget_1";
Debug.ShouldStop(65536);
__ref.getField(false,"_asbm_badget_1").setObject (_pnl_asbm_badget_1.getObject());
 BA.debugLineNum = 306;BA.debugLine="asbm_badget_1.Font = xui.CreateDefaultBoldFont(10";
Debug.ShouldStop(131072);
__ref.getField(false,"_asbm_badget_1").runMethod(false,"setFont",__ref.getField(false,"_xui").runMethod(false,"CreateDefaultBoldFont",(Object)(BA.numberCast(float.class, 10))));
 BA.debugLineNum = 307;BA.debugLine="asbm_badget_1.TextColor = xui.Color_White";
Debug.ShouldStop(262144);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setTextColor",__ref.getField(false,"_xui").getField(true,"Color_White"));
 BA.debugLineNum = 308;BA.debugLine="asbm_badget_1.SetTextAlignment(\"CENTER\",\"CENTER\")";
Debug.ShouldStop(524288);
__ref.getField(false,"_asbm_badget_1").runVoidMethod ("SetTextAlignment",(Object)(BA.ObjectToString("CENTER")),(Object)(RemoteObject.createImmutable("CENTER")));
 BA.debugLineNum = 312;BA.debugLine="Dim pnl_asbm_badget_2 As Label";
Debug.ShouldStop(8388608);
_pnl_asbm_badget_2 = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("pnl_asbm_badget_2", _pnl_asbm_badget_2);
 BA.debugLineNum = 313;BA.debugLine="pnl_asbm_badget_2.Initialize(\"asbm_badget_2\")";
Debug.ShouldStop(16777216);
_pnl_asbm_badget_2.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_badget_2")));
 BA.debugLineNum = 314;BA.debugLine="asbm_badget_2 = pnl_asbm_badget_2";
Debug.ShouldStop(33554432);
__ref.getField(false,"_asbm_badget_2").setObject (_pnl_asbm_badget_2.getObject());
 BA.debugLineNum = 315;BA.debugLine="asbm_badget_2.Font = xui.CreateDefaultBoldFont(10";
Debug.ShouldStop(67108864);
__ref.getField(false,"_asbm_badget_2").runMethod(false,"setFont",__ref.getField(false,"_xui").runMethod(false,"CreateDefaultBoldFont",(Object)(BA.numberCast(float.class, 10))));
 BA.debugLineNum = 316;BA.debugLine="asbm_badget_2.TextColor = xui.Color_White";
Debug.ShouldStop(134217728);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setTextColor",__ref.getField(false,"_xui").getField(true,"Color_White"));
 BA.debugLineNum = 317;BA.debugLine="asbm_badget_2.SetTextAlignment(\"CENTER\",\"CENTER\")";
Debug.ShouldStop(268435456);
__ref.getField(false,"_asbm_badget_2").runVoidMethod ("SetTextAlignment",(Object)(BA.ObjectToString("CENTER")),(Object)(RemoteObject.createImmutable("CENTER")));
 BA.debugLineNum = 319;BA.debugLine="Dim pnl_asbm_badget_3 As Label";
Debug.ShouldStop(1073741824);
_pnl_asbm_badget_3 = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("pnl_asbm_badget_3", _pnl_asbm_badget_3);
 BA.debugLineNum = 320;BA.debugLine="pnl_asbm_badget_3.Initialize(\"asbm_badget_3\")";
Debug.ShouldStop(-2147483648);
_pnl_asbm_badget_3.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_badget_3")));
 BA.debugLineNum = 321;BA.debugLine="asbm_badget_3 = pnl_asbm_badget_3";
Debug.ShouldStop(1);
__ref.getField(false,"_asbm_badget_3").setObject (_pnl_asbm_badget_3.getObject());
 BA.debugLineNum = 322;BA.debugLine="asbm_badget_3.Font = xui.CreateDefaultBoldFont(10";
Debug.ShouldStop(2);
__ref.getField(false,"_asbm_badget_3").runMethod(false,"setFont",__ref.getField(false,"_xui").runMethod(false,"CreateDefaultBoldFont",(Object)(BA.numberCast(float.class, 10))));
 BA.debugLineNum = 323;BA.debugLine="asbm_badget_3.TextColor = xui.Color_White";
Debug.ShouldStop(4);
__ref.getField(false,"_asbm_badget_3").runMethod(true,"setTextColor",__ref.getField(false,"_xui").getField(true,"Color_White"));
 BA.debugLineNum = 324;BA.debugLine="asbm_badget_3.SetTextAlignment(\"CENTER\",\"CENTER\")";
Debug.ShouldStop(8);
__ref.getField(false,"_asbm_badget_3").runVoidMethod ("SetTextAlignment",(Object)(BA.ObjectToString("CENTER")),(Object)(RemoteObject.createImmutable("CENTER")));
 BA.debugLineNum = 326;BA.debugLine="Dim pnl_asbm_badget_4 As Label";
Debug.ShouldStop(32);
_pnl_asbm_badget_4 = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");Debug.locals.put("pnl_asbm_badget_4", _pnl_asbm_badget_4);
 BA.debugLineNum = 327;BA.debugLine="pnl_asbm_badget_4.Initialize(\"asbm_badget_4\")";
Debug.ShouldStop(64);
_pnl_asbm_badget_4.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("asbm_badget_4")));
 BA.debugLineNum = 328;BA.debugLine="asbm_badget_4 = pnl_asbm_badget_4";
Debug.ShouldStop(128);
__ref.getField(false,"_asbm_badget_4").setObject (_pnl_asbm_badget_4.getObject());
 BA.debugLineNum = 329;BA.debugLine="asbm_badget_4.Font = xui.CreateDefaultBoldFont(10";
Debug.ShouldStop(256);
__ref.getField(false,"_asbm_badget_4").runMethod(false,"setFont",__ref.getField(false,"_xui").runMethod(false,"CreateDefaultBoldFont",(Object)(BA.numberCast(float.class, 10))));
 BA.debugLineNum = 330;BA.debugLine="asbm_badget_4.TextColor = xui.Color_White";
Debug.ShouldStop(512);
__ref.getField(false,"_asbm_badget_4").runMethod(true,"setTextColor",__ref.getField(false,"_xui").getField(true,"Color_White"));
 BA.debugLineNum = 331;BA.debugLine="asbm_badget_4.SetTextAlignment(\"CENTER\",\"CENTER\")";
Debug.ShouldStop(1024);
__ref.getField(false,"_asbm_badget_4").runVoidMethod ("SetTextAlignment",(Object)(BA.ObjectToString("CENTER")),(Object)(RemoteObject.createImmutable("CENTER")));
 BA.debugLineNum = 335;BA.debugLine="s_Color1 = xui.PaintOrColorToColor(Props.Get(\"Sli";
Debug.ShouldStop(16384);
__ref.setField ("_s_color1",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("SliderColor1")))))));
 BA.debugLineNum = 336;BA.debugLine="s_Color2 = xui.PaintOrColorToColor(Props.Get(\"Sli";
Debug.ShouldStop(32768);
__ref.setField ("_s_color2",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("SliderColor2")))))));
 BA.debugLineNum = 337;BA.debugLine="s_Color3 = xui.PaintOrColorToColor(Props.Get(\"Sli";
Debug.ShouldStop(65536);
__ref.setField ("_s_color3",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("SliderColor3")))))));
 BA.debugLineNum = 338;BA.debugLine="s_Color4 = xui.PaintOrColorToColor(Props.Get(\"Sli";
Debug.ShouldStop(131072);
__ref.setField ("_s_color4",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("SliderColor4")))))));
 BA.debugLineNum = 340;BA.debugLine="b_Color = xui.PaintOrColorToColor(Props.Get(\"Back";
Debug.ShouldStop(524288);
__ref.setField ("_b_color",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("BackgroundColor")))))));
 BA.debugLineNum = 342;BA.debugLine="p_Line = xui.PaintOrColorToColor(Props.Get(\"Parti";
Debug.ShouldStop(2097152);
__ref.setField ("_p_line",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("PartingLine")))))));
 BA.debugLineNum = 344;BA.debugLine="m_BackgroundColor = xui.PaintOrColorToColor(Props";
Debug.ShouldStop(8388608);
__ref.setField ("_m_backgroundcolor",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("MiddleBackgroundColor")))))));
 BA.debugLineNum = 346;BA.debugLine="e_BadgetColor1 = Props.Get(\"EnableBadgetColor1\")";
Debug.ShouldStop(33554432);
__ref.setField ("_e_badgetcolor1",BA.ObjectToBoolean(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("EnableBadgetColor1"))))));
 BA.debugLineNum = 347;BA.debugLine="e_BadgetColor2 = Props.Get(\"EnableBadgetColor2\")";
Debug.ShouldStop(67108864);
__ref.setField ("_e_badgetcolor2",BA.ObjectToBoolean(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("EnableBadgetColor2"))))));
 BA.debugLineNum = 348;BA.debugLine="e_BadgetColor3 = Props.Get(\"EnableBadgetColor3\")";
Debug.ShouldStop(134217728);
__ref.setField ("_e_badgetcolor3",BA.ObjectToBoolean(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("EnableBadgetColor3"))))));
 BA.debugLineNum = 349;BA.debugLine="e_BadgetColor4 = Props.Get(\"EnableBadgetColor4\")";
Debug.ShouldStop(268435456);
__ref.setField ("_e_badgetcolor4",BA.ObjectToBoolean(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("EnableBadgetColor4"))))));
 BA.debugLineNum = 351;BA.debugLine="b_color1 = xui.PaintOrColorToColor(Props.Get(\"Bad";
Debug.ShouldStop(1073741824);
__ref.setField ("_b_color1",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("BadgetColor1")))))));
 BA.debugLineNum = 352;BA.debugLine="b_color2 = xui.PaintOrColorToColor(Props.Get(\"Bad";
Debug.ShouldStop(-2147483648);
__ref.setField ("_b_color2",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("BadgetColor2")))))));
 BA.debugLineNum = 353;BA.debugLine="b_color3 = xui.PaintOrColorToColor(Props.Get(\"Bad";
Debug.ShouldStop(1);
__ref.setField ("_b_color3",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("BadgetColor3")))))));
 BA.debugLineNum = 354;BA.debugLine="b_color4 = xui.PaintOrColorToColor(Props.Get(\"Bad";
Debug.ShouldStop(2);
__ref.setField ("_b_color4",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("BadgetColor4")))))));
 BA.debugLineNum = 356;BA.debugLine="p_ClickColor = xui.PaintOrColorToColor(Props.Get(";
Debug.ShouldStop(8);
__ref.setField ("_p_clickcolor",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("PageClickColor")))))));
 BA.debugLineNum = 358;BA.debugLine="e_SelectedPageColor = Props.Get(\"EnableSelectedPa";
Debug.ShouldStop(32);
__ref.setField ("_e_selectedpagecolor",BA.ObjectToBoolean(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("EnableSelectedPageColor"))))));
 BA.debugLineNum = 360;BA.debugLine="s_PageColor = xui.PaintOrColorToColor(Props.Get(\"";
Debug.ShouldStop(128);
__ref.setField ("_s_pagecolor",__ref.getField(false,"_xui").runMethod(true,"PaintOrColorToColor",(Object)(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("SelectedPageColor")))))));
 BA.debugLineNum = 362;BA.debugLine="MiddleButtonVisible = Props.Get(\"MiddleButtonVisi";
Debug.ShouldStop(512);
__ref.setField ("_middlebuttonvisible",BA.ObjectToBoolean(_props.runMethod(false,"Get",(Object)((RemoteObject.createImmutable("MiddleButtonVisible"))))));
 BA.debugLineNum = 366;BA.debugLine="asbm_page_1.Color = b_Color";
Debug.ShouldStop(8192);
__ref.getField(false,"_asbm_page_1").runMethod(true,"setColor",__ref.getField(true,"_b_color"));
 BA.debugLineNum = 367;BA.debugLine="asbm_page_2.Color = b_Color";
Debug.ShouldStop(16384);
__ref.getField(false,"_asbm_page_2").runMethod(true,"setColor",__ref.getField(true,"_b_color"));
 BA.debugLineNum = 368;BA.debugLine="asbm_page_3.Color = b_Color";
Debug.ShouldStop(32768);
__ref.getField(false,"_asbm_page_3").runMethod(true,"setColor",__ref.getField(true,"_b_color"));
 BA.debugLineNum = 369;BA.debugLine="asbm_page_4.Color = b_Color";
Debug.ShouldStop(65536);
__ref.getField(false,"_asbm_page_4").runMethod(true,"setColor",__ref.getField(true,"_b_color"));
 BA.debugLineNum = 374;BA.debugLine="asbm_slider.Height = 2dip";
Debug.ShouldStop(2097152);
__ref.getField(false,"_asbm_slider").runMethod(true,"setHeight",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 2)))));
 BA.debugLineNum = 375;BA.debugLine="asbm_slider.Width = 40dip";
Debug.ShouldStop(4194304);
__ref.getField(false,"_asbm_slider").runMethod(true,"setWidth",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 40)))));
 BA.debugLineNum = 376;BA.debugLine="asbm_slider.SetColorAndBorder(s_Color1,0,xui.Colo";
Debug.ShouldStop(8388608);
__ref.getField(false,"_asbm_slider").runVoidMethod ("SetColorAndBorder",(Object)(__ref.getField(true,"_s_color1")),(Object)(BA.numberCast(double.class, 0)),(Object)(__ref.getField(false,"_xui").getField(true,"Color_Transparent")),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_slider").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)));
 BA.debugLineNum = 381;BA.debugLine="asbm_parting_line.Height = 3dip";
Debug.ShouldStop(268435456);
__ref.getField(false,"_asbm_parting_line").runMethod(true,"setHeight",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 3)))));
 BA.debugLineNum = 382;BA.debugLine="asbm_parting_line.Color = p_Line";
Debug.ShouldStop(536870912);
__ref.getField(false,"_asbm_parting_line").runMethod(true,"setColor",__ref.getField(true,"_p_line"));
 BA.debugLineNum = 386;BA.debugLine="asbm_badget_1.Width = 18dip";
Debug.ShouldStop(2);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setWidth",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 18)))));
 BA.debugLineNum = 387;BA.debugLine="asbm_badget_1.Height = 18dip";
Debug.ShouldStop(4);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setHeight",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 18)))));
 BA.debugLineNum = 388;BA.debugLine="asbm_badget_1.SetColorAndBorder(b_color1,0dip,xui";
Debug.ShouldStop(8);
__ref.getField(false,"_asbm_badget_1").runVoidMethod ("SetColorAndBorder",(Object)(__ref.getField(true,"_b_color1")),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 0))))),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White")),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_badget_1").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)));
 BA.debugLineNum = 389;BA.debugLine="asbm_badget_1.Text = 0";
Debug.ShouldStop(16);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setText",BA.NumberToString(0));
 BA.debugLineNum = 392;BA.debugLine="asbm_badget_2.Width = 18dip";
Debug.ShouldStop(128);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setWidth",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 18)))));
 BA.debugLineNum = 393;BA.debugLine="asbm_badget_2.Height = 18dip";
Debug.ShouldStop(256);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setHeight",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 18)))));
 BA.debugLineNum = 394;BA.debugLine="asbm_badget_2.SetColorAndBorder(b_color2,0dip,xui";
Debug.ShouldStop(512);
__ref.getField(false,"_asbm_badget_2").runVoidMethod ("SetColorAndBorder",(Object)(__ref.getField(true,"_b_color2")),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 0))))),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White")),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_badget_2").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)));
 BA.debugLineNum = 395;BA.debugLine="asbm_badget_2.Text = 0";
Debug.ShouldStop(1024);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setText",BA.NumberToString(0));
 BA.debugLineNum = 397;BA.debugLine="asbm_badget_3.Width = 18dip";
Debug.ShouldStop(4096);
__ref.getField(false,"_asbm_badget_3").runMethod(true,"setWidth",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 18)))));
 BA.debugLineNum = 398;BA.debugLine="asbm_badget_3.Height = 18dip";
Debug.ShouldStop(8192);
__ref.getField(false,"_asbm_badget_3").runMethod(true,"setHeight",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 18)))));
 BA.debugLineNum = 399;BA.debugLine="asbm_badget_3.SetColorAndBorder(b_color3,0dip,xui";
Debug.ShouldStop(16384);
__ref.getField(false,"_asbm_badget_3").runVoidMethod ("SetColorAndBorder",(Object)(__ref.getField(true,"_b_color3")),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 0))))),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White")),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_badget_3").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)));
 BA.debugLineNum = 400;BA.debugLine="asbm_badget_3.Text = 0";
Debug.ShouldStop(32768);
__ref.getField(false,"_asbm_badget_3").runMethod(true,"setText",BA.NumberToString(0));
 BA.debugLineNum = 402;BA.debugLine="asbm_badget_4.Width = 18dip";
Debug.ShouldStop(131072);
__ref.getField(false,"_asbm_badget_4").runMethod(true,"setWidth",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 18)))));
 BA.debugLineNum = 403;BA.debugLine="asbm_badget_4.Height = 18dip";
Debug.ShouldStop(262144);
__ref.getField(false,"_asbm_badget_4").runMethod(true,"setHeight",BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 18)))));
 BA.debugLineNum = 404;BA.debugLine="asbm_badget_4.SetColorAndBorder(b_color4,0dip,xui";
Debug.ShouldStop(524288);
__ref.getField(false,"_asbm_badget_4").runVoidMethod ("SetColorAndBorder",(Object)(__ref.getField(true,"_b_color4")),(Object)(BA.numberCast(double.class, asbottommenu.__c.runMethod(true,"DipToCurrent",(Object)(BA.numberCast(int.class, 0))))),(Object)(__ref.getField(false,"_xui").getField(true,"Color_White")),(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_asbm_badget_4").runMethod(true,"getHeight"),RemoteObject.createImmutable(2)}, "/",0, 0)));
 BA.debugLineNum = 405;BA.debugLine="asbm_badget_4.Text = 0";
Debug.ShouldStop(1048576);
__ref.getField(false,"_asbm_badget_4").runMethod(true,"setText",BA.NumberToString(0));
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
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _callback,RemoteObject _eventname) throws Exception{
try {
		Debug.PushSubsStack("Initialize (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,667);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "asbottommenu","initialize", __ref, _ba, _callback, _eventname);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
Debug.locals.put("CallBack", _callback);
Debug.locals.put("EventName", _eventname);
 BA.debugLineNum = 667;BA.debugLine="Public Sub Initialize (CallBack As Object, EventNa";
Debug.ShouldStop(67108864);
 BA.debugLineNum = 668;BA.debugLine="mEventName = EventName";
Debug.ShouldStop(134217728);
__ref.setField ("_meventname",_eventname);
 BA.debugLineNum = 669;BA.debugLine="mCallBack = CallBack";
Debug.ShouldStop(268435456);
__ref.setField ("_mcallback",_callback);
 BA.debugLineNum = 674;BA.debugLine="End Sub";
Debug.ShouldStop(2);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setbadgetcolor1(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("SetBadgetColor1 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1400);
if (RapidSub.canDelegate("setbadgetcolor1")) { return __ref.runUserSub(false, "asbottommenu","setbadgetcolor1", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 1400;BA.debugLine="Public Sub SetBadgetColor1(color As Int)";
Debug.ShouldStop(8388608);
 BA.debugLineNum = 1402;BA.debugLine="b_color1 = color";
Debug.ShouldStop(33554432);
__ref.setField ("_b_color1",_color);
 BA.debugLineNum = 1403;BA.debugLine="asbm_badget_1.Color = b_color1";
Debug.ShouldStop(67108864);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setColor",__ref.getField(true,"_b_color1"));
 BA.debugLineNum = 1404;BA.debugLine="End Sub";
Debug.ShouldStop(134217728);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setbadgetcolor2(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("SetBadgetColor2 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1406);
if (RapidSub.canDelegate("setbadgetcolor2")) { return __ref.runUserSub(false, "asbottommenu","setbadgetcolor2", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 1406;BA.debugLine="Public Sub SetBadgetColor2(color As Int)";
Debug.ShouldStop(536870912);
 BA.debugLineNum = 1408;BA.debugLine="b_color2 = color";
Debug.ShouldStop(-2147483648);
__ref.setField ("_b_color2",_color);
 BA.debugLineNum = 1409;BA.debugLine="asbm_badget_2.Color = b_color2";
Debug.ShouldStop(1);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setColor",__ref.getField(true,"_b_color2"));
 BA.debugLineNum = 1410;BA.debugLine="End Sub";
Debug.ShouldStop(2);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setbadgetcolor3(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("SetBadgetColor3 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1412);
if (RapidSub.canDelegate("setbadgetcolor3")) { return __ref.runUserSub(false, "asbottommenu","setbadgetcolor3", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 1412;BA.debugLine="Public Sub SetBadgetColor3(color As Int)";
Debug.ShouldStop(8);
 BA.debugLineNum = 1414;BA.debugLine="b_color3 = color";
Debug.ShouldStop(32);
__ref.setField ("_b_color3",_color);
 BA.debugLineNum = 1415;BA.debugLine="asbm_badget_3.Color = b_color3";
Debug.ShouldStop(64);
__ref.getField(false,"_asbm_badget_3").runMethod(true,"setColor",__ref.getField(true,"_b_color3"));
 BA.debugLineNum = 1416;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setbadgetcolor4(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("SetBadgetColor4 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1418);
if (RapidSub.canDelegate("setbadgetcolor4")) { return __ref.runUserSub(false, "asbottommenu","setbadgetcolor4", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 1418;BA.debugLine="Public Sub SetBadgetColor4(color As Int)";
Debug.ShouldStop(512);
 BA.debugLineNum = 1420;BA.debugLine="b_color4 = color";
Debug.ShouldStop(2048);
__ref.setField ("_b_color4",_color);
 BA.debugLineNum = 1421;BA.debugLine="asbm_badget_4.Color = b_color4";
Debug.ShouldStop(4096);
__ref.getField(false,"_asbm_badget_4").runMethod(true,"setColor",__ref.getField(true,"_b_color4"));
 BA.debugLineNum = 1422;BA.debugLine="End Sub";
Debug.ShouldStop(8192);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setbadgetvalue1(RemoteObject __ref,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("SetBadgetValue1 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1489);
if (RapidSub.canDelegate("setbadgetvalue1")) { return __ref.runUserSub(false, "asbottommenu","setbadgetvalue1", __ref, _value);}
Debug.locals.put("value", _value);
 BA.debugLineNum = 1489;BA.debugLine="Public Sub SetBadgetValue1(value As Int)";
Debug.ShouldStop(65536);
 BA.debugLineNum = 1491;BA.debugLine="If value > 9 Then";
Debug.ShouldStop(262144);
if (RemoteObject.solveBoolean(">",_value,BA.numberCast(double.class, 9))) { 
 BA.debugLineNum = 1493;BA.debugLine="asbm_badget_1.Text = \"+\" & 9";
Debug.ShouldStop(1048576);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setText",RemoteObject.concat(RemoteObject.createImmutable("+"),RemoteObject.createImmutable(9)));
 }else 
{ BA.debugLineNum = 1495;BA.debugLine="Else if value < 0 Then";
Debug.ShouldStop(4194304);
if (RemoteObject.solveBoolean("<",_value,BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 1497;BA.debugLine="asbm_badget_1.Text = 0";
Debug.ShouldStop(16777216);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setText",BA.NumberToString(0));
 }else {
 BA.debugLineNum = 1502;BA.debugLine="asbm_badget_1.Text = value";
Debug.ShouldStop(536870912);
__ref.getField(false,"_asbm_badget_1").runMethod(true,"setText",BA.NumberToString(_value));
 }}
;
 BA.debugLineNum = 1506;BA.debugLine="End Sub";
Debug.ShouldStop(2);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setbadgetvalue2(RemoteObject __ref,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("SetBadgetValue2 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1508);
if (RapidSub.canDelegate("setbadgetvalue2")) { return __ref.runUserSub(false, "asbottommenu","setbadgetvalue2", __ref, _value);}
Debug.locals.put("value", _value);
 BA.debugLineNum = 1508;BA.debugLine="Public Sub SetBadgetValue2(value As Int)";
Debug.ShouldStop(8);
 BA.debugLineNum = 1510;BA.debugLine="If value > 9 Then";
Debug.ShouldStop(32);
if (RemoteObject.solveBoolean(">",_value,BA.numberCast(double.class, 9))) { 
 BA.debugLineNum = 1512;BA.debugLine="asbm_badget_2.Text = \"+\" & 9";
Debug.ShouldStop(128);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setText",RemoteObject.concat(RemoteObject.createImmutable("+"),RemoteObject.createImmutable(9)));
 }else 
{ BA.debugLineNum = 1514;BA.debugLine="Else if value < 0 Then";
Debug.ShouldStop(512);
if (RemoteObject.solveBoolean("<",_value,BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 1516;BA.debugLine="asbm_badget_2.Text = 0";
Debug.ShouldStop(2048);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setText",BA.NumberToString(0));
 }else {
 BA.debugLineNum = 1521;BA.debugLine="asbm_badget_2.Text = value";
Debug.ShouldStop(65536);
__ref.getField(false,"_asbm_badget_2").runMethod(true,"setText",BA.NumberToString(_value));
 }}
;
 BA.debugLineNum = 1525;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setbadgetvalue3(RemoteObject __ref,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("SetBadgetValue3 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1527);
if (RapidSub.canDelegate("setbadgetvalue3")) { return __ref.runUserSub(false, "asbottommenu","setbadgetvalue3", __ref, _value);}
Debug.locals.put("value", _value);
 BA.debugLineNum = 1527;BA.debugLine="Public Sub SetBadgetValue3(value As Int)";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 1529;BA.debugLine="If value > 9 Then";
Debug.ShouldStop(16777216);
if (RemoteObject.solveBoolean(">",_value,BA.numberCast(double.class, 9))) { 
 BA.debugLineNum = 1531;BA.debugLine="asbm_badget_3.Text = \"+\" & 9";
Debug.ShouldStop(67108864);
__ref.getField(false,"_asbm_badget_3").runMethod(true,"setText",RemoteObject.concat(RemoteObject.createImmutable("+"),RemoteObject.createImmutable(9)));
 }else 
{ BA.debugLineNum = 1533;BA.debugLine="Else if value < 0 Then";
Debug.ShouldStop(268435456);
if (RemoteObject.solveBoolean("<",_value,BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 1535;BA.debugLine="asbm_badget_3.Text = 0";
Debug.ShouldStop(1073741824);
__ref.getField(false,"_asbm_badget_3").runMethod(true,"setText",BA.NumberToString(0));
 }else {
 BA.debugLineNum = 1540;BA.debugLine="asbm_badget_3.Text = value";
Debug.ShouldStop(8);
__ref.getField(false,"_asbm_badget_3").runMethod(true,"setText",BA.NumberToString(_value));
 }}
;
 BA.debugLineNum = 1544;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setbadgetvalue4(RemoteObject __ref,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("SetBadgetValue4 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1546);
if (RapidSub.canDelegate("setbadgetvalue4")) { return __ref.runUserSub(false, "asbottommenu","setbadgetvalue4", __ref, _value);}
Debug.locals.put("value", _value);
 BA.debugLineNum = 1546;BA.debugLine="Public Sub SetBadgetValue4(value As Int)";
Debug.ShouldStop(512);
 BA.debugLineNum = 1548;BA.debugLine="If value > 9 Then";
Debug.ShouldStop(2048);
if (RemoteObject.solveBoolean(">",_value,BA.numberCast(double.class, 9))) { 
 BA.debugLineNum = 1550;BA.debugLine="asbm_badget_4.Text = \"+\" & 9";
Debug.ShouldStop(8192);
__ref.getField(false,"_asbm_badget_4").runMethod(true,"setText",RemoteObject.concat(RemoteObject.createImmutable("+"),RemoteObject.createImmutable(9)));
 }else 
{ BA.debugLineNum = 1552;BA.debugLine="Else if value < 0 Then";
Debug.ShouldStop(32768);
if (RemoteObject.solveBoolean("<",_value,BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 1554;BA.debugLine="asbm_badget_4.Text = 0";
Debug.ShouldStop(131072);
__ref.getField(false,"_asbm_badget_4").runMethod(true,"setText",BA.NumberToString(0));
 }else {
 BA.debugLineNum = 1559;BA.debugLine="asbm_badget_4.Text = value";
Debug.ShouldStop(4194304);
__ref.getField(false,"_asbm_badget_4").runMethod(true,"setText",BA.NumberToString(_value));
 }}
;
 BA.debugLineNum = 1563;BA.debugLine="End Sub";
Debug.ShouldStop(67108864);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setcurrentpage(RemoteObject __ref,RemoteObject _page) throws Exception{
try {
		Debug.PushSubsStack("SetCurrentPage (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1685);
if (RapidSub.canDelegate("setcurrentpage")) { return __ref.runUserSub(false, "asbottommenu","setcurrentpage", __ref, _page);}
Debug.locals.put("page", _page);
 BA.debugLineNum = 1685;BA.debugLine="Public Sub SetCurrentPage(page As Int)";
Debug.ShouldStop(1048576);
 BA.debugLineNum = 1687;BA.debugLine="If page = 1 Then";
Debug.ShouldStop(4194304);
if (RemoteObject.solveBoolean("=",_page,BA.numberCast(double.class, 1))) { 
 BA.debugLineNum = 1689;BA.debugLine="asbm_page_1_handler(asbm_page_1)";
Debug.ShouldStop(16777216);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_asbm_page_1_handler",(Object)(__ref.getField(false,"_asbm_page_1")));
 }else 
{ BA.debugLineNum = 1691;BA.debugLine="Else If page = 2 Then";
Debug.ShouldStop(67108864);
if (RemoteObject.solveBoolean("=",_page,BA.numberCast(double.class, 2))) { 
 BA.debugLineNum = 1693;BA.debugLine="asbm_page_2_handler(asbm_page_2)";
Debug.ShouldStop(268435456);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_asbm_page_2_handler",(Object)(__ref.getField(false,"_asbm_page_2")));
 }else 
{ BA.debugLineNum = 1695;BA.debugLine="Else If page = 3 Then";
Debug.ShouldStop(1073741824);
if (RemoteObject.solveBoolean("=",_page,BA.numberCast(double.class, 3))) { 
 BA.debugLineNum = 1697;BA.debugLine="asbm_page_3_handler(asbm_page_3)";
Debug.ShouldStop(1);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_asbm_page_3_handler",(Object)(__ref.getField(false,"_asbm_page_3")));
 }else 
{ BA.debugLineNum = 1699;BA.debugLine="Else If page = 4 Then";
Debug.ShouldStop(4);
if (RemoteObject.solveBoolean("=",_page,BA.numberCast(double.class, 4))) { 
 BA.debugLineNum = 1701;BA.debugLine="asbm_page_4_handler(asbm_page_4)";
Debug.ShouldStop(16);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_asbm_page_4_handler",(Object)(__ref.getField(false,"_asbm_page_4")));
 }else {
 BA.debugLineNum = 1705;BA.debugLine="Log(\"Page number not valid\")";
Debug.ShouldStop(256);
asbottommenu.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("Page number not valid")));
 BA.debugLineNum = 1706;BA.debugLine="asbm_page_1_handler(asbm_page_1)";
Debug.ShouldStop(512);
__ref.runClassMethod (b4j.example.asbottommenu.class, "_asbm_page_1_handler",(Object)(__ref.getField(false,"_asbm_page_1")));
 }}}}
;
 BA.debugLineNum = 1710;BA.debugLine="End Sub";
Debug.ShouldStop(8192);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _seticon1(RemoteObject __ref,RemoteObject _icon) throws Exception{
try {
		Debug.PushSubsStack("SetIcon1 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1565);
if (RapidSub.canDelegate("seticon1")) { return __ref.runUserSub(false, "asbottommenu","seticon1", __ref, _icon);}
Debug.locals.put("icon", _icon);
 BA.debugLineNum = 1565;BA.debugLine="Public Sub SetIcon1(icon As B4XBitmap)";
Debug.ShouldStop(268435456);
 BA.debugLineNum = 1567;BA.debugLine="icon1 = icon";
Debug.ShouldStop(1073741824);
__ref.setField ("_icon1",_icon);
 BA.debugLineNum = 1570;BA.debugLine="asbm_icon_1.SetImage(icon1)";
Debug.ShouldStop(2);
__ref.getField(false,"_asbm_icon_1").runVoidMethod ("SetImage",(Object)((__ref.getField(false,"_icon1").getObject())));
 BA.debugLineNum = 1572;BA.debugLine="If currentpage = 1 Then";
Debug.ShouldStop(8);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_currentpage"),BA.numberCast(double.class, 1))) { 
 BA.debugLineNum = 1574;BA.debugLine="asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(32);
__ref.getField(false,"_asbm_icon_1").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_1").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(true,"_s_pagecolor"))).getObject())));
 };
 BA.debugLineNum = 1590;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _seticon2(RemoteObject __ref,RemoteObject _icon) throws Exception{
try {
		Debug.PushSubsStack("SetIcon2 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1592);
if (RapidSub.canDelegate("seticon2")) { return __ref.runUserSub(false, "asbottommenu","seticon2", __ref, _icon);}
Debug.locals.put("icon", _icon);
 BA.debugLineNum = 1592;BA.debugLine="Public Sub SetIcon2(icon As B4XBitmap)";
Debug.ShouldStop(8388608);
 BA.debugLineNum = 1594;BA.debugLine="icon2 = icon";
Debug.ShouldStop(33554432);
__ref.setField ("_icon2",_icon);
 BA.debugLineNum = 1597;BA.debugLine="asbm_icon_2.SetImage(icon2)";
Debug.ShouldStop(268435456);
__ref.getField(false,"_asbm_icon_2").runVoidMethod ("SetImage",(Object)((__ref.getField(false,"_icon2").getObject())));
 BA.debugLineNum = 1599;BA.debugLine="If currentpage = 2 Then";
Debug.ShouldStop(1073741824);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_currentpage"),BA.numberCast(double.class, 2))) { 
 BA.debugLineNum = 1601;BA.debugLine="asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(1);
__ref.getField(false,"_asbm_icon_2").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_2").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(true,"_s_pagecolor"))).getObject())));
 };
 BA.debugLineNum = 1619;BA.debugLine="End Sub";
Debug.ShouldStop(262144);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _seticon3(RemoteObject __ref,RemoteObject _icon) throws Exception{
try {
		Debug.PushSubsStack("SetIcon3 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1621);
if (RapidSub.canDelegate("seticon3")) { return __ref.runUserSub(false, "asbottommenu","seticon3", __ref, _icon);}
Debug.locals.put("icon", _icon);
 BA.debugLineNum = 1621;BA.debugLine="Public Sub SetIcon3(icon As B4XBitmap)";
Debug.ShouldStop(1048576);
 BA.debugLineNum = 1623;BA.debugLine="icon3 = icon";
Debug.ShouldStop(4194304);
__ref.setField ("_icon3",_icon);
 BA.debugLineNum = 1626;BA.debugLine="asbm_icon_3.SetImage(icon3)";
Debug.ShouldStop(33554432);
__ref.getField(false,"_asbm_icon_3").runVoidMethod ("SetImage",(Object)((__ref.getField(false,"_icon3").getObject())));
 BA.debugLineNum = 1628;BA.debugLine="If currentpage = 3 Then";
Debug.ShouldStop(134217728);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_currentpage"),BA.numberCast(double.class, 3))) { 
 BA.debugLineNum = 1630;BA.debugLine="asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(536870912);
__ref.getField(false,"_asbm_icon_3").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_3").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(true,"_s_pagecolor"))).getObject())));
 };
 BA.debugLineNum = 1647;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _seticon4(RemoteObject __ref,RemoteObject _icon) throws Exception{
try {
		Debug.PushSubsStack("SetIcon4 (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1649);
if (RapidSub.canDelegate("seticon4")) { return __ref.runUserSub(false, "asbottommenu","seticon4", __ref, _icon);}
Debug.locals.put("icon", _icon);
 BA.debugLineNum = 1649;BA.debugLine="Public Sub SetIcon4(icon As B4XBitmap)";
Debug.ShouldStop(65536);
 BA.debugLineNum = 1651;BA.debugLine="icon4 = icon";
Debug.ShouldStop(262144);
__ref.setField ("_icon4",_icon);
 BA.debugLineNum = 1654;BA.debugLine="asbm_icon_4.SetImage(icon4)";
Debug.ShouldStop(2097152);
__ref.getField(false,"_asbm_icon_4").runVoidMethod ("SetImage",(Object)((__ref.getField(false,"_icon4").getObject())));
 BA.debugLineNum = 1656;BA.debugLine="If currentpage = 4 Then";
Debug.ShouldStop(8388608);
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_currentpage"),BA.numberCast(double.class, 4))) { 
 BA.debugLineNum = 1658;BA.debugLine="asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLeve";
Debug.ShouldStop(33554432);
__ref.getField(false,"_asbm_icon_4").runVoidMethod ("SetImage",(Object)((__ref.runClassMethod (b4j.example.asbottommenu.class, "_changecolorbasedonalphalevel",RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.objects.B4XViewWrapper.B4XBitmapWrapper"), __ref.getField(false,"_asbm_icon_4").runMethod(false,"GetImage").getObject()),(Object)(__ref.getField(true,"_s_pagecolor"))).getObject())));
 };
 BA.debugLineNum = 1674;BA.debugLine="End Sub";
Debug.ShouldStop(512);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setmenubackgroundcolor(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("SetMenuBackgroundColor (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1424);
if (RapidSub.canDelegate("setmenubackgroundcolor")) { return __ref.runUserSub(false, "asbottommenu","setmenubackgroundcolor", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 1424;BA.debugLine="Public Sub SetMenuBackgroundColor(color As Int)";
Debug.ShouldStop(32768);
 BA.debugLineNum = 1426;BA.debugLine="b_Color = color";
Debug.ShouldStop(131072);
__ref.setField ("_b_color",_color);
 BA.debugLineNum = 1427;BA.debugLine="asbm_page_background.Color = b_Color";
Debug.ShouldStop(262144);
__ref.getField(false,"_asbm_page_background").runMethod(true,"setColor",__ref.getField(true,"_b_color"));
 BA.debugLineNum = 1428;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setmiddlebuttonbackgroundcolor(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("SetMiddleButtonBackgroundColor (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1450);
if (RapidSub.canDelegate("setmiddlebuttonbackgroundcolor")) { return __ref.runUserSub(false, "asbottommenu","setmiddlebuttonbackgroundcolor", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 1450;BA.debugLine="Public Sub SetMiddleButtonBackgroundColor(color As";
Debug.ShouldStop(512);
 BA.debugLineNum = 1453;BA.debugLine="m_BackgroundColor = color";
Debug.ShouldStop(4096);
__ref.setField ("_m_backgroundcolor",_color);
 BA.debugLineNum = 1454;BA.debugLine="asbm_add_background.Color = m_BackgroundColor";
Debug.ShouldStop(8192);
__ref.getField(false,"_asbm_add_background").runMethod(true,"setColor",__ref.getField(true,"_m_backgroundcolor"));
 BA.debugLineNum = 1456;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setmiddlebuttonicon(RemoteObject __ref,RemoteObject _icon) throws Exception{
try {
		Debug.PushSubsStack("SetMiddleButtonIcon (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1676);
if (RapidSub.canDelegate("setmiddlebuttonicon")) { return __ref.runUserSub(false, "asbottommenu","setmiddlebuttonicon", __ref, _icon);}
Debug.locals.put("icon", _icon);
 BA.debugLineNum = 1676;BA.debugLine="Public Sub SetMiddleButtonIcon(icon As B4XBitmap)";
Debug.ShouldStop(2048);
 BA.debugLineNum = 1678;BA.debugLine="middleicon = icon";
Debug.ShouldStop(8192);
__ref.setField ("_middleicon",_icon);
 BA.debugLineNum = 1679;BA.debugLine="asbm_add_icon.SetBitmap(middleicon)";
Debug.ShouldStop(16384);
__ref.getField(false,"_asbm_add_icon").runVoidMethod ("SetBitmap",(Object)((__ref.getField(false,"_middleicon").getObject())));
 BA.debugLineNum = 1682;BA.debugLine="End Sub";
Debug.ShouldStop(131072);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setpageclickcolor(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("SetPageClickColor (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1444);
if (RapidSub.canDelegate("setpageclickcolor")) { return __ref.runUserSub(false, "asbottommenu","setpageclickcolor", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 1444;BA.debugLine="Public Sub SetPageClickColor(color As Int)";
Debug.ShouldStop(8);
 BA.debugLineNum = 1446;BA.debugLine="p_ClickColor = color";
Debug.ShouldStop(32);
__ref.setField ("_p_clickcolor",_color);
 BA.debugLineNum = 1448;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setpartinglinecolor(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("SetPartingLineColor (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1458);
if (RapidSub.canDelegate("setpartinglinecolor")) { return __ref.runUserSub(false, "asbottommenu","setpartinglinecolor", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 1458;BA.debugLine="Public Sub SetPartingLineColor(color As Int)";
Debug.ShouldStop(131072);
 BA.debugLineNum = 1460;BA.debugLine="p_Line = color";
Debug.ShouldStop(524288);
__ref.setField ("_p_line",_color);
 BA.debugLineNum = 1461;BA.debugLine="asbm_parting_line.Color = p_Line";
Debug.ShouldStop(1048576);
__ref.getField(false,"_asbm_parting_line").runMethod(true,"setColor",__ref.getField(true,"_p_line"));
 BA.debugLineNum = 1463;BA.debugLine="End Sub";
Debug.ShouldStop(4194304);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setselectedpagecolor(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("SetSelectedPageColor (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1437);
if (RapidSub.canDelegate("setselectedpagecolor")) { return __ref.runUserSub(false, "asbottommenu","setselectedpagecolor", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 1437;BA.debugLine="Public Sub SetSelectedPageColor(color As Int)";
Debug.ShouldStop(268435456);
 BA.debugLineNum = 1439;BA.debugLine="s_PageColor = color";
Debug.ShouldStop(1073741824);
__ref.setField ("_s_pagecolor",_color);
 BA.debugLineNum = 1441;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setslider1color(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("SetSlider1Color (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1465);
if (RapidSub.canDelegate("setslider1color")) { return __ref.runUserSub(false, "asbottommenu","setslider1color", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 1465;BA.debugLine="Public Sub SetSlider1Color(color As Int)";
Debug.ShouldStop(16777216);
 BA.debugLineNum = 1467;BA.debugLine="s_Color1 = color";
Debug.ShouldStop(67108864);
__ref.setField ("_s_color1",_color);
 BA.debugLineNum = 1469;BA.debugLine="End Sub";
Debug.ShouldStop(268435456);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setslider2color(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("SetSlider2Color (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1471);
if (RapidSub.canDelegate("setslider2color")) { return __ref.runUserSub(false, "asbottommenu","setslider2color", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 1471;BA.debugLine="Public Sub SetSlider2Color(color As Int)";
Debug.ShouldStop(1073741824);
 BA.debugLineNum = 1473;BA.debugLine="s_Color2 = color";
Debug.ShouldStop(1);
__ref.setField ("_s_color2",_color);
 BA.debugLineNum = 1475;BA.debugLine="End Sub";
Debug.ShouldStop(4);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setslider3color(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("SetSlider3Color (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1477);
if (RapidSub.canDelegate("setslider3color")) { return __ref.runUserSub(false, "asbottommenu","setslider3color", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 1477;BA.debugLine="Public Sub SetSlider3Color(color As Int)";
Debug.ShouldStop(16);
 BA.debugLineNum = 1479;BA.debugLine="s_Color3 = color";
Debug.ShouldStop(64);
__ref.setField ("_s_color3",_color);
 BA.debugLineNum = 1481;BA.debugLine="End Sub";
Debug.ShouldStop(256);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _setslider4color(RemoteObject __ref,RemoteObject _color) throws Exception{
try {
		Debug.PushSubsStack("SetSlider4Color (asbottommenu) ","asbottommenu",1,__ref.getField(false, "ba"),__ref,1483);
if (RapidSub.canDelegate("setslider4color")) { return __ref.runUserSub(false, "asbottommenu","setslider4color", __ref, _color);}
Debug.locals.put("color", _color);
 BA.debugLineNum = 1483;BA.debugLine="Public Sub SetSlider4Color(color As Int)";
Debug.ShouldStop(1024);
 BA.debugLineNum = 1485;BA.debugLine="s_Color4 = color";
Debug.ShouldStop(4096);
__ref.setField ("_s_color4",_color);
 BA.debugLineNum = 1487;BA.debugLine="End Sub";
Debug.ShouldStop(16384);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}