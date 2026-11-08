package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class b4xpagesmanager_subs_0 {


public static RemoteObject  _activity_pause(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Activity_Pause (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,632);
if (RapidSub.canDelegate("activity_pause")) { return __ref.runUserSub(false, "b4xpagesmanager","activity_pause", __ref);}
 BA.debugLineNum = 632;BA.debugLine="Public Sub Activity_Pause";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 633;BA.debugLine="RaiseEventWithResult(GetTopPage, \"B4XPage_Disappe";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_raiseeventwithresult" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_gettoppage" /*RemoteObject*/ )),(Object)(BA.ObjectToString("B4XPage_Disappear")),(Object)((b4xpagesmanager.__c.getField(false,"Null"))));
 BA.debugLineNum = 634;BA.debugLine="BackgroundStateChanged(False)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_backgroundstatechanged" /*RemoteObject*/ ,(Object)(b4xpagesmanager.__c.getField(true,"False")));
 BA.debugLineNum = 635;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _activity_resume(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Activity_Resume (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,607);
if (RapidSub.canDelegate("activity_resume")) { return __ref.runUserSub(false, "b4xpagesmanager","activity_resume", __ref);}
RemoteObject _shouldraise = RemoteObject.createImmutable(false);
 BA.debugLineNum = 607;BA.debugLine="Public Sub Activity_Resume";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 608;BA.debugLine="Dim ShouldRaise As Boolean = IsForeground = False";
Debug.JustUpdateDeviceLine();
_shouldraise = BA.ObjectToBoolean(RemoteObject.solveBoolean("=",__ref.getField(true,"_isforeground" /*RemoteObject*/ ),b4xpagesmanager.__c.getField(true,"False")));Debug.locals.put("ShouldRaise", _shouldraise);Debug.locals.put("ShouldRaise", _shouldraise);
 BA.debugLineNum = 609;BA.debugLine="BackgroundStateChanged(True)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_backgroundstatechanged" /*RemoteObject*/ ,(Object)(b4xpagesmanager.__c.getField(true,"True")));
 BA.debugLineNum = 610;BA.debugLine="If ShouldRaise Then";
Debug.JustUpdateDeviceLine();
if (_shouldraise.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 611;BA.debugLine="RaiseEvent(GetTopPage, \"B4XPage_Appear\", Null)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_raiseevent" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_gettoppage" /*RemoteObject*/ )),(Object)(BA.ObjectToString("B4XPage_Appear")),(Object)((b4xpagesmanager.__c.getField(false,"Null"))));
 };
 BA.debugLineNum = 613;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _addpage(RemoteObject __ref,RemoteObject _id,RemoteObject _b4xpage) throws Exception{
try {
		Debug.PushSubsStack("AddPage (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,141);
if (RapidSub.canDelegate("addpage")) { return __ref.runUserSub(false, "b4xpagesmanager","addpage", __ref, _id, _b4xpage);}
RemoteObject _idtolower = RemoteObject.createImmutable("");
Debug.locals.put("Id", _id);
Debug.locals.put("B4XPage", _b4xpage);
 BA.debugLineNum = 141;BA.debugLine="Public Sub AddPage (Id As String, B4XPage As Objec";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 142;BA.debugLine="Dim IdToLower As String = Id.ToLowerCase";
Debug.JustUpdateDeviceLine();
_idtolower = _id.runMethod(true,"toLowerCase");Debug.locals.put("IdToLower", _idtolower);Debug.locals.put("IdToLower", _idtolower);
 BA.debugLineNum = 143;BA.debugLine="If IdToB4XPage.ContainsKey(IdToLower) Then";
Debug.JustUpdateDeviceLine();
if (__ref.getField(false,"_idtob4xpage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_containskey" /*RemoteObject*/ ,(Object)((_idtolower))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 144;BA.debugLine="Log($\"Page with this id already exists: ${IdToLo";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runVoidMethod ("LogImpl","96225923",(RemoteObject.concat(RemoteObject.createImmutable("Page with this id already exists: "),b4xpagesmanager.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_idtolower))),RemoteObject.createImmutable("!"))),0);
 BA.debugLineNum = 145;BA.debugLine="Return";
Debug.JustUpdateDeviceLine();
if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 147;BA.debugLine="IdToB4XPage.Put(IdToLower, CreateB4XPageInfo(B4XP";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_idtob4xpage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_put" /*RemoteObject*/ ,(Object)((_idtolower)),(Object)((__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_createb4xpageinfo" /*RemoteObject*/ ,(Object)(_b4xpage),(Object)(_idtolower),(Object)(b4xpagesmanager.__c.getField(true,"False")),(Object)((_id))))));
 BA.debugLineNum = 148;BA.debugLine="If IdToB4XPage.Size = 1 Then ShowPage(IdToLower)";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_idtob4xpage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_getsize" /*RemoteObject*/ ),BA.numberCast(double.class, 1))) { 
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_showpage" /*RemoteObject*/ ,(Object)(_idtolower));};
 BA.debugLineNum = 149;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _addpageandcreate(RemoteObject __ref,RemoteObject _id,RemoteObject _b4xpage) throws Exception{
try {
		Debug.PushSubsStack("AddPageAndCreate (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,151);
if (RapidSub.canDelegate("addpageandcreate")) { return __ref.runUserSub(false, "b4xpagesmanager","addpageandcreate", __ref, _id, _b4xpage);}
Debug.locals.put("Id", _id);
Debug.locals.put("B4XPage", _b4xpage);
 BA.debugLineNum = 151;BA.debugLine="Public Sub AddPageAndCreate (Id As String, B4XPage";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 152;BA.debugLine="AddPage (Id, B4XPage)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_addpage" /*RemoteObject*/ ,(Object)(_id),(Object)(_b4xpage));
 BA.debugLineNum = 153;BA.debugLine="CreatePageIfNeeded(GetPageFromId(Id))";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_createpageifneeded" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_getpagefromid" /*RemoteObject*/ ,(Object)(_id))));
 BA.debugLineNum = 154;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _backgroundstatechanged(RemoteObject __ref,RemoteObject _newstate) throws Exception{
try {
		Debug.PushSubsStack("BackgroundStateChanged (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,615);
if (RapidSub.canDelegate("backgroundstatechanged")) { return __ref.runUserSub(false, "b4xpagesmanager","backgroundstatechanged", __ref, _newstate);}
RemoteObject _ev = RemoteObject.createImmutable("");
RemoteObject _pi = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
Debug.locals.put("NewState", _newstate);
 BA.debugLineNum = 615;BA.debugLine="Private Sub BackgroundStateChanged (NewState As Bo";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 616;BA.debugLine="If IsForeground = NewState Then Return";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_isforeground" /*RemoteObject*/ ),_newstate)) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 617;BA.debugLine="IsForeground = NewState";
Debug.JustUpdateDeviceLine();
__ref.setField ("_isforeground" /*RemoteObject*/ ,_newstate);
 BA.debugLineNum = 618;BA.debugLine="Dim ev As String";
Debug.JustUpdateDeviceLine();
_ev = RemoteObject.createImmutable("");Debug.locals.put("ev", _ev);
 BA.debugLineNum = 619;BA.debugLine="If IsForeground Then ev = \"B4XPage_Foreground\" El";
Debug.JustUpdateDeviceLine();
if (__ref.getField(true,"_isforeground" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
_ev = BA.ObjectToString("B4XPage_Foreground");Debug.locals.put("ev", _ev);}
else {
_ev = BA.ObjectToString("B4XPage_Background");Debug.locals.put("ev", _ev);};
 BA.debugLineNum = 620;BA.debugLine="For Each pi As B4XPageInfo In IdToB4XPage.Values";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group5 = __ref.getField(false,"_idtob4xpage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_getvalues" /*RemoteObject*/ );
final int groupLen5 = group5.runMethod(true,"getSize").<Integer>get()
;int index5 = 0;
;
for (; index5 < groupLen5;index5++){
_pi = (group5.runMethod(false,"Get",index5));Debug.locals.put("pi", _pi);
Debug.locals.put("pi", _pi);
 BA.debugLineNum = 621;BA.debugLine="If xui.SubExists(pi.B4XPage, ev, 0) Then";
Debug.JustUpdateDeviceLine();
if (__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(_pi.getField(false,"B4XPage" /*RemoteObject*/ )),(Object)(_ev),(Object)(BA.numberCast(int.class, 0))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 622;BA.debugLine="LogEvent(pi, ev)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_logevent" /*RemoteObject*/ ,(Object)(_pi),(Object)(_ev));
 BA.debugLineNum = 623;BA.debugLine="If IsForeground Then";
Debug.JustUpdateDeviceLine();
if (__ref.getField(true,"_isforeground" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 624;BA.debugLine="CallSubDelayed(pi.B4XPage, ev)";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runVoidMethod ("CallSubDelayed",__ref.getField(false, "ba"),(Object)(_pi.getField(false,"B4XPage" /*RemoteObject*/ )),(Object)(_ev));
 }else {
 BA.debugLineNum = 626;BA.debugLine="CallSub(pi.B4XPage, ev)";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runMethodAndSync(false,"CallSubNew",__ref.getField(false, "ba"),(Object)(_pi.getField(false,"B4XPage" /*RemoteObject*/ )),(Object)(_ev));
 };
 };
 }
}Debug.locals.put("pi", _pi);
;
 BA.debugLineNum = 630;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 22;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 23;BA.debugLine="Private IdToB4XPage As B4XOrderedMap";
b4xpagesmanager._idtob4xpage = RemoteObject.createNew ("b4j.example.b4xorderedmap");__ref.setField("_idtob4xpage",b4xpagesmanager._idtob4xpage);
 //BA.debugLineNum = 24;BA.debugLine="Private RootB4XToPage As B4XOrderedMap";
b4xpagesmanager._rootb4xtopage = RemoteObject.createNew ("b4j.example.b4xorderedmap");__ref.setField("_rootb4xtopage",b4xpagesmanager._rootb4xtopage);
 //BA.debugLineNum = 30;BA.debugLine="Type B4XPageParent (NativeType As Form)";
;
 //BA.debugLineNum = 34;BA.debugLine="Type B4XPageInfo (B4XPage As Object, Id As String";
;
 //BA.debugLineNum = 38;BA.debugLine="Public mStackOfPageIds As B4XSet";
b4xpagesmanager._mstackofpageids = RemoteObject.createNew ("b4j.example.b4xset");__ref.setField("_mstackofpageids",b4xpagesmanager._mstackofpageids);
 //BA.debugLineNum = 39;BA.debugLine="Private xui As XUI 'ignore";
b4xpagesmanager._xui = RemoteObject.createNew ("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");__ref.setField("_xui",b4xpagesmanager._xui);
 //BA.debugLineNum = 41;BA.debugLine="Private mMainForm As Form";
b4xpagesmanager._mmainform = RemoteObject.createNew ("anywheresoftware.b4j.objects.Form");__ref.setField("_mmainform",b4xpagesmanager._mmainform);
 //BA.debugLineNum = 49;BA.debugLine="Public IsForeground As Boolean";
b4xpagesmanager._isforeground = RemoteObject.createImmutable(false);__ref.setField("_isforeground",b4xpagesmanager._isforeground);
 //BA.debugLineNum = 50;BA.debugLine="Public TransitionAnimationDuration As Int = 100";
b4xpagesmanager._transitionanimationduration = BA.numberCast(int.class, 100);__ref.setField("_transitionanimationduration",b4xpagesmanager._transitionanimationduration);
 //BA.debugLineNum = 51;BA.debugLine="Public MainPage As B4XMainPage";
b4xpagesmanager._mainpage = RemoteObject.createNew ("b4j.example.b4xmainpage");__ref.setField("_mainpage",b4xpagesmanager._mainpage);
 //BA.debugLineNum = 52;BA.debugLine="Private StackString As String";
b4xpagesmanager._stackstring = RemoteObject.createImmutable("");__ref.setField("_stackstring",b4xpagesmanager._stackstring);
 //BA.debugLineNum = 53;BA.debugLine="Public LogEvents As Boolean = False";
b4xpagesmanager._logevents = b4xpagesmanager.__c.getField(true,"False");__ref.setField("_logevents",b4xpagesmanager._logevents);
 //BA.debugLineNum = 54;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _closepage(RemoteObject __ref,RemoteObject _b4xpage) throws Exception{
try {
		Debug.PushSubsStack("ClosePage (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,209);
if (RapidSub.canDelegate("closepage")) { return __ref.runUserSub(false, "b4xpagesmanager","closepage", __ref, _b4xpage);}
RemoteObject _pi = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
Debug.locals.put("B4XPage", _b4xpage);
 BA.debugLineNum = 209;BA.debugLine="Public Sub ClosePage (B4XPage As Object)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 210;BA.debugLine="Dim pi As B4XPageInfo = FindPIFromB4XPage(B4XPage";
Debug.JustUpdateDeviceLine();
_pi = __ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_findpifromb4xpage" /*RemoteObject*/ ,(Object)(_b4xpage));Debug.locals.put("pi", _pi);Debug.locals.put("pi", _pi);
 BA.debugLineNum = 211;BA.debugLine="If mStackOfPageIds.Contains(pi.Id) = False Then R";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_contains" /*RemoteObject*/ ,(Object)((_pi.getField(true,"Id" /*RemoteObject*/ )))),b4xpagesmanager.__c.getField(true,"False"))) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 212;BA.debugLine="If xui.IsB4i And GetTopPage <> pi Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(".",__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"getIsB4i")) && RemoteObject.solveBoolean("!",__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_gettoppage" /*RemoteObject*/ ),_pi)) { 
 BA.debugLineNum = 213;BA.debugLine="Log(\"Only top page can be closed\")";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runVoidMethod ("LogImpl","96488068",RemoteObject.createImmutable("Only top page can be closed"),0);
 BA.debugLineNum = 214;BA.debugLine="Return";
Debug.JustUpdateDeviceLine();
if (true) return RemoteObject.createImmutable("");
 }else 
{ BA.debugLineNum = 215;BA.debugLine="Else If xui.IsB4i And mStackOfPageIds.Size = 1 Th";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(".",__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"getIsB4i")) && RemoteObject.solveBoolean("=",__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_getsize" /*RemoteObject*/ ),BA.numberCast(double.class, 1))) { 
 BA.debugLineNum = 216;BA.debugLine="Log(\"First page cannot be closed\")";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runVoidMethod ("LogImpl","96488071",RemoteObject.createImmutable("First page cannot be closed"),0);
 BA.debugLineNum = 217;BA.debugLine="Return";
Debug.JustUpdateDeviceLine();
if (true) return RemoteObject.createImmutable("");
 }}
;
 BA.debugLineNum = 219;BA.debugLine="ClosePageImpl(pi)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_closepageimpl" /*RemoteObject*/ ,(Object)(_pi));
 BA.debugLineNum = 220;BA.debugLine="If GetTopPage = pi Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_gettoppage" /*RemoteObject*/ ),_pi)) { 
 BA.debugLineNum = 221;BA.debugLine="TopPageDisappear";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_toppagedisappear" /*RemoteObject*/ );
 };
 BA.debugLineNum = 223;BA.debugLine="If xui.IsB4A And mStackOfPageIds.Size = 1 Then Re";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(".",__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"getIsB4A")) && RemoteObject.solveBoolean("=",__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_getsize" /*RemoteObject*/ ),BA.numberCast(double.class, 1))) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 224;BA.debugLine="mStackOfPageIds.Remove(pi.Id)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_remove" /*RemoteObject*/ ,(Object)((_pi.getField(true,"Id" /*RemoteObject*/ ))));
 BA.debugLineNum = 225;BA.debugLine="If xui.IsB4A Then ShowPageImpl(GetTopPage)";
Debug.JustUpdateDeviceLine();
if (__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"getIsB4A").<Boolean>get().booleanValue()) { 
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_showpageimpl" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_gettoppage" /*RemoteObject*/ )));};
 BA.debugLineNum = 226;BA.debugLine="TopPageAppear";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_toppageappear" /*RemoteObject*/ );
 BA.debugLineNum = 227;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _closepageimpl(RemoteObject __ref,RemoteObject _pi) throws Exception{
try {
		Debug.PushSubsStack("ClosePageImpl (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,312);
if (RapidSub.canDelegate("closepageimpl")) { return __ref.runUserSub(false, "b4xpagesmanager","closepageimpl", __ref, _pi);}
Debug.locals.put("pi", _pi);
 BA.debugLineNum = 312;BA.debugLine="Private Sub ClosePageImpl (pi As B4XPageInfo) 'ign";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 324;BA.debugLine="pi.Parent.NativeType.Close";
Debug.JustUpdateDeviceLine();
_pi.getField(false,"Parent" /*RemoteObject*/ ).getField(false,"NativeType" /*RemoteObject*/ ).runVoidMethod ("Close");
 BA.debugLineNum = 328;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _closerequestexists(RemoteObject __ref,RemoteObject _pi) throws Exception{
try {
		Debug.PushSubsStack("CloseRequestExists (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,531);
if (RapidSub.canDelegate("closerequestexists")) { return __ref.runUserSub(false, "b4xpagesmanager","closerequestexists", __ref, _pi);}
Debug.locals.put("pi", _pi);
 BA.debugLineNum = 531;BA.debugLine="Private Sub CloseRequestExists (pi As B4XPageInfo)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 532;BA.debugLine="Return xui.SubExists(pi.B4XPage, \"B4XPage_CloseRe";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(_pi.getField(false,"B4XPage" /*RemoteObject*/ )),(Object)(BA.ObjectToString("B4XPage_CloseRequest")),(Object)(BA.numberCast(int.class, 0)));
 BA.debugLineNum = 533;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createb4xpageinfo(RemoteObject __ref,RemoteObject _b4xpage,RemoteObject _id,RemoteObject _created,RemoteObject _title) throws Exception{
try {
		Debug.PushSubsStack("CreateB4XPageInfo (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,417);
if (RapidSub.canDelegate("createb4xpageinfo")) { return __ref.runUserSub(false, "b4xpagesmanager","createb4xpageinfo", __ref, _b4xpage, _id, _created, _title);}
RemoteObject _t1 = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
Debug.locals.put("B4XPage", _b4xpage);
Debug.locals.put("Id", _id);
Debug.locals.put("Created", _created);
Debug.locals.put("Title", _title);
 BA.debugLineNum = 417;BA.debugLine="Private Sub CreateB4XPageInfo (B4XPage As Object,";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 418;BA.debugLine="Dim t1 As B4XPageInfo";
Debug.JustUpdateDeviceLine();
_t1 = RemoteObject.createNew ("b4j.example.b4xpagesmanager._b4xpageinfo");Debug.locals.put("t1", _t1);
 BA.debugLineNum = 419;BA.debugLine="t1.Initialize";
Debug.JustUpdateDeviceLine();
_t1.runVoidMethod ("Initialize");
 BA.debugLineNum = 420;BA.debugLine="t1.B4XPage = B4XPage";
Debug.JustUpdateDeviceLine();
_t1.setField ("B4XPage" /*RemoteObject*/ ,_b4xpage);
 BA.debugLineNum = 421;BA.debugLine="t1.Id = Id";
Debug.JustUpdateDeviceLine();
_t1.setField ("Id" /*RemoteObject*/ ,_id);
 BA.debugLineNum = 422;BA.debugLine="t1.Created = Created";
Debug.JustUpdateDeviceLine();
_t1.setField ("Created" /*RemoteObject*/ ,_created);
 BA.debugLineNum = 423;BA.debugLine="t1.Title = Title";
Debug.JustUpdateDeviceLine();
_t1.setField ("Title" /*RemoteObject*/ ,_title);
 BA.debugLineNum = 424;BA.debugLine="Return t1";
Debug.JustUpdateDeviceLine();
if (true) return _t1;
 BA.debugLineNum = 425;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createb4xpageparent(RemoteObject __ref,RemoteObject _nativetype) throws Exception{
try {
		Debug.PushSubsStack("CreateB4XPageParent (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,597);
if (RapidSub.canDelegate("createb4xpageparent")) { return __ref.runUserSub(false, "b4xpagesmanager","createb4xpageparent", __ref, _nativetype);}
RemoteObject _t1 = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageparent");
Debug.locals.put("NativeType", _nativetype);
 BA.debugLineNum = 597;BA.debugLine="Private Sub CreateB4XPageParent (NativeType As For";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 601;BA.debugLine="Dim t1 As B4XPageParent";
Debug.JustUpdateDeviceLine();
_t1 = RemoteObject.createNew ("b4j.example.b4xpagesmanager._b4xpageparent");Debug.locals.put("t1", _t1);
 BA.debugLineNum = 602;BA.debugLine="t1.Initialize";
Debug.JustUpdateDeviceLine();
_t1.runVoidMethod ("Initialize");
 BA.debugLineNum = 603;BA.debugLine="t1.NativeType = NativeType";
Debug.JustUpdateDeviceLine();
_t1.setField ("NativeType" /*RemoteObject*/ ,_nativetype);
 BA.debugLineNum = 604;BA.debugLine="Return t1";
Debug.JustUpdateDeviceLine();
if (true) return _t1;
 BA.debugLineNum = 605;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createpageifneeded(RemoteObject __ref,RemoteObject _pi) throws Exception{
try {
		Debug.PushSubsStack("CreatePageIfNeeded (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,349);
if (RapidSub.canDelegate("createpageifneeded")) { return __ref.runUserSub(false, "b4xpagesmanager","createpageifneeded", __ref, _pi);}
Debug.locals.put("pi", _pi);
 BA.debugLineNum = 349;BA.debugLine="Private Sub CreatePageIfNeeded(pi As B4XPageInfo)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 350;BA.debugLine="If pi.Created Then Return";
Debug.JustUpdateDeviceLine();
if (_pi.getField(true,"Created" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 351;BA.debugLine="pi.IsFirst = IdToB4XPage.Size = 1";
Debug.JustUpdateDeviceLine();
_pi.setField ("IsFirst" /*RemoteObject*/ ,BA.ObjectToBoolean(RemoteObject.solveBoolean("=",__ref.getField(false,"_idtob4xpage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_getsize" /*RemoteObject*/ ),BA.numberCast(double.class, 1))));
 BA.debugLineNum = 352;BA.debugLine="CreatePageImpl (pi)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_createpageimpl" /*RemoteObject*/ ,(Object)(_pi));
 BA.debugLineNum = 353;BA.debugLine="pi.Created = True";
Debug.JustUpdateDeviceLine();
_pi.setField ("Created" /*RemoteObject*/ ,b4xpagesmanager.__c.getField(true,"True"));
 BA.debugLineNum = 354;BA.debugLine="RootB4XToPage.Put(pi.Root, pi)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_rootb4xtopage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_put" /*RemoteObject*/ ,(Object)((_pi.getField(false,"Root" /*RemoteObject*/ ).getObject())),(Object)((_pi)));
 BA.debugLineNum = 355;BA.debugLine="LogEvent(pi, \"B4XPage_Created\")";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_logevent" /*RemoteObject*/ ,(Object)(_pi),(Object)(RemoteObject.createImmutable("B4XPage_Created")));
 BA.debugLineNum = 356;BA.debugLine="CallSub2(pi.B4XPage, \"B4XPage_Created\", pi.root)";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runMethodAndSync(false,"CallSubNew2",__ref.getField(false, "ba"),(Object)(_pi.getField(false,"B4XPage" /*RemoteObject*/ )),(Object)(BA.ObjectToString("B4XPage_Created")),(Object)((_pi.getField(false,"Root" /*RemoteObject*/ ))));
 BA.debugLineNum = 358;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createpageimpl(RemoteObject __ref,RemoteObject _pi) throws Exception{
try {
		Debug.PushSubsStack("CreatePageImpl (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,366);
if (RapidSub.canDelegate("createpageimpl")) { return __ref.runUserSub(false, "b4xpagesmanager","createpageimpl", __ref, _pi);}
RemoteObject _f = RemoteObject.declareNull("anywheresoftware.b4j.objects.Form");
Debug.locals.put("pi", _pi);
 BA.debugLineNum = 366;BA.debugLine="Private Sub CreatePageImpl (pi As B4XPageInfo)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 368;BA.debugLine="If pi.IsFirst Then";
Debug.JustUpdateDeviceLine();
if (_pi.getField(true,"IsFirst" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 369;BA.debugLine="pi.Parent = CreateB4XPageParent(mMainForm)";
Debug.JustUpdateDeviceLine();
_pi.setField ("Parent" /*RemoteObject*/ ,__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_createb4xpageparent" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_mmainform" /*RemoteObject*/ ))));
 }else {
 BA.debugLineNum = 371;BA.debugLine="Dim f As Form";
Debug.JustUpdateDeviceLine();
_f = RemoteObject.createNew ("anywheresoftware.b4j.objects.Form");Debug.locals.put("f", _f);
 BA.debugLineNum = 372;BA.debugLine="f.Initialize(\"MainForm\", mMainForm.RootPane.Widt";
Debug.JustUpdateDeviceLine();
_f.runVoidMethod ("Initialize",__ref.getField(false, "ba"),(Object)(BA.ObjectToString("MainForm")),(Object)(__ref.getField(false,"_mmainform" /*RemoteObject*/ ).runMethod(false,"getRootPane").runMethod(true,"getWidth")),(Object)(__ref.getField(false,"_mmainform" /*RemoteObject*/ ).runMethod(false,"getRootPane").runMethod(true,"getHeight")));
 BA.debugLineNum = 373;BA.debugLine="pi.Parent = CreateB4XPageParent(f)";
Debug.JustUpdateDeviceLine();
_pi.setField ("Parent" /*RemoteObject*/ ,__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_createb4xpageparent" /*RemoteObject*/ ,(Object)(_f)));
 };
 BA.debugLineNum = 375;BA.debugLine="pi.Root = pi.Parent.NativeType.RootPane";
Debug.JustUpdateDeviceLine();
_pi.getField(false,"Root" /*RemoteObject*/ ).setObject (_pi.getField(false,"Parent" /*RemoteObject*/ ).getField(false,"NativeType" /*RemoteObject*/ ).runMethod(false,"getRootPane").getObject());
 BA.debugLineNum = 376;BA.debugLine="pi.Parent.NativeType.Title = pi.Title";
Debug.JustUpdateDeviceLine();
_pi.getField(false,"Parent" /*RemoteObject*/ ).getField(false,"NativeType" /*RemoteObject*/ ).runMethod(true,"setTitle",BA.ObjectToString(_pi.getField(false,"Title" /*RemoteObject*/ )));
 BA.debugLineNum = 389;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _findpifromb4xpage(RemoteObject __ref,RemoteObject _page) throws Exception{
try {
		Debug.PushSubsStack("FindPIFromB4XPage (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,303);
if (RapidSub.canDelegate("findpifromb4xpage")) { return __ref.runUserSub(false, "b4xpagesmanager","findpifromb4xpage", __ref, _page);}
RemoteObject _pi = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
Debug.locals.put("Page", _page);
 BA.debugLineNum = 303;BA.debugLine="Public Sub FindPIFromB4XPage (Page As Object) As B";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 304;BA.debugLine="For Each pi As B4XPageInfo In IdToB4XPage.Values";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group1 = __ref.getField(false,"_idtob4xpage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_getvalues" /*RemoteObject*/ );
final int groupLen1 = group1.runMethod(true,"getSize").<Integer>get()
;int index1 = 0;
;
for (; index1 < groupLen1;index1++){
_pi = (group1.runMethod(false,"Get",index1));Debug.locals.put("pi", _pi);
Debug.locals.put("pi", _pi);
 BA.debugLineNum = 305;BA.debugLine="If pi.B4XPage = Page Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_pi.getField(false,"B4XPage" /*RemoteObject*/ ),_page)) { 
 BA.debugLineNum = 306;BA.debugLine="Return pi";
Debug.JustUpdateDeviceLine();
if (true) return _pi;
 };
 }
}Debug.locals.put("pi", _pi);
;
 BA.debugLineNum = 309;BA.debugLine="Return Null";
Debug.JustUpdateDeviceLine();
if (true) return (b4xpagesmanager.__c.getField(false,"Null"));
 BA.debugLineNum = 310;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getpage(RemoteObject __ref,RemoteObject _id) throws Exception{
try {
		Debug.PushSubsStack("GetPage (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,391);
if (RapidSub.canDelegate("getpage")) { return __ref.runUserSub(false, "b4xpagesmanager","getpage", __ref, _id);}
Debug.locals.put("Id", _id);
 BA.debugLineNum = 391;BA.debugLine="Public Sub GetPage (Id As String) As Object";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 392;BA.debugLine="Return GetPageFromId(Id).B4XPage";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_getpagefromid" /*RemoteObject*/ ,(Object)(_id)).getField(false,"B4XPage" /*RemoteObject*/ );
 BA.debugLineNum = 393;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getpagefromid(RemoteObject __ref,RemoteObject _id) throws Exception{
try {
		Debug.PushSubsStack("GetPageFromId (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,395);
if (RapidSub.canDelegate("getpagefromid")) { return __ref.runUserSub(false, "b4xpagesmanager","getpagefromid", __ref, _id);}
RemoteObject _pi = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
Debug.locals.put("id", _id);
 BA.debugLineNum = 395;BA.debugLine="Private Sub GetPageFromId (id As String) As B4XPag";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 396;BA.debugLine="Dim pi As B4XPageInfo = IdToB4XPage.Get(id.ToLowe";
Debug.JustUpdateDeviceLine();
_pi = (__ref.getField(false,"_idtob4xpage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_get" /*RemoteObject*/ ,(Object)((_id.runMethod(true,"toLowerCase")))));Debug.locals.put("pi", _pi);Debug.locals.put("pi", _pi);
 BA.debugLineNum = 397;BA.debugLine="If pi = Null Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("n",_pi)) { 
 BA.debugLineNum = 398;BA.debugLine="Log(\"Error: page id not found: \" & id)";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runVoidMethod ("LogImpl","97143427",RemoteObject.concat(RemoteObject.createImmutable("Error: page id not found: "),_id),0);
 BA.debugLineNum = 399;BA.debugLine="Log(\"Ids: \" & IdToB4XPage.Keys) 'ignore";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runVoidMethod ("LogImpl","97143428",RemoteObject.concat(RemoteObject.createImmutable("Ids: "),__ref.getField(false,"_idtob4xpage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_getkeys" /*RemoteObject*/ )),0);
 };
 BA.debugLineNum = 401;BA.debugLine="Return pi";
Debug.JustUpdateDeviceLine();
if (true) return _pi;
 BA.debugLineNum = 402;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getpageinfofromroot(RemoteObject __ref,RemoteObject _root) throws Exception{
try {
		Debug.PushSubsStack("GetPageInfoFromRoot (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,404);
if (RapidSub.canDelegate("getpageinfofromroot")) { return __ref.runUserSub(false, "b4xpagesmanager","getpageinfofromroot", __ref, _root);}
Debug.locals.put("Root", _root);
 BA.debugLineNum = 404;BA.debugLine="Public Sub GetPageInfoFromRoot (Root As B4XView) A";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 405;BA.debugLine="Return RootB4XToPage.Get(Root)";
Debug.JustUpdateDeviceLine();
if (true) return (__ref.getField(false,"_rootb4xtopage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_get" /*RemoteObject*/ ,(Object)((_root.getObject()))));
 BA.debugLineNum = 406;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _gettoppage(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("GetTopPage (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,589);
if (RapidSub.canDelegate("gettoppage")) { return __ref.runUserSub(false, "b4xpagesmanager","gettoppage", __ref);}
 BA.debugLineNum = 589;BA.debugLine="Public Sub GetTopPage As B4XPageInfo";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 590;BA.debugLine="If mStackOfPageIds.Size = 0 Then Return Null";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_getsize" /*RemoteObject*/ ),BA.numberCast(double.class, 0))) { 
if (true) return (b4xpagesmanager.__c.getField(false,"Null"));};
 BA.debugLineNum = 591;BA.debugLine="Return IdToB4XPage.Get(mStackOfPageIds.AsList.Get";
Debug.JustUpdateDeviceLine();
if (true) return (__ref.getField(false,"_idtob4xpage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_get" /*RemoteObject*/ ,(Object)(__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_aslist" /*RemoteObject*/ ).runMethod(false,"Get",(Object)(RemoteObject.solve(new RemoteObject[] {__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_getsize" /*RemoteObject*/ ),RemoteObject.createImmutable(1)}, "-",1, 1))))));
 BA.debugLineNum = 592;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static void  _handlecloserequest(RemoteObject __ref,RemoteObject _pi) throws Exception{
try {
		Debug.PushSubsStack("HandleCloseRequest (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,535);
if (RapidSub.canDelegate("handlecloserequest")) { __ref.runUserSub(false, "b4xpagesmanager","handlecloserequest", __ref, _pi); return;}
ResumableSub_HandleCloseRequest rsub = new ResumableSub_HandleCloseRequest(null,__ref,_pi);
rsub.resume(null, null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static class ResumableSub_HandleCloseRequest extends BA.ResumableSub {
public ResumableSub_HandleCloseRequest(b4j.example.b4xpagesmanager parent,RemoteObject __ref,RemoteObject _pi) {
this.parent = parent;
this.__ref = __ref;
this._pi = _pi;
}
java.util.LinkedHashMap<String, Object> rsLocals = new java.util.LinkedHashMap<String, Object>();
RemoteObject __ref;
b4j.example.b4xpagesmanager parent;
RemoteObject _pi;
RemoteObject _rs = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common.ResumableSubWrapper");
RemoteObject _shouldclose = RemoteObject.createImmutable(false);

@Override
public void resume(BA ba, RemoteObject result) throws Exception{
try {
		Debug.PushSubsStack("HandleCloseRequest (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,535);
Debug.locals = rsLocals;Debug.currentSubFrame.locals = rsLocals;

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
Debug.locals.put("_ref", __ref);
Debug.locals.put("pi", _pi);
 BA.debugLineNum = 536;BA.debugLine="LogEvent(pi, \"B4XPage_CloseRequest\")";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_logevent" /*RemoteObject*/ ,(Object)(_pi),(Object)(RemoteObject.createImmutable("B4XPage_CloseRequest")));
 BA.debugLineNum = 537;BA.debugLine="Dim rs As ResumableSub = CallSub(pi.B4XPage, \"B4X";
Debug.JustUpdateDeviceLine();
_rs = RemoteObject.createNew ("anywheresoftware.b4a.keywords.Common.ResumableSubWrapper");
_rs = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.keywords.Common.ResumableSubWrapper"), parent.__c.runMethodAndSync(false,"CallSubNew",__ref.getField(false, "ba"),(Object)(_pi.getField(false,"B4XPage" /*RemoteObject*/ )),(Object)(RemoteObject.createImmutable("B4XPage_CloseRequest"))));Debug.locals.put("rs", _rs);Debug.locals.put("rs", _rs);
 BA.debugLineNum = 538;BA.debugLine="Wait For (rs) Complete (ShouldClose As Boolean)";
Debug.JustUpdateDeviceLine();
parent.__c.runVoidMethod ("WaitFor","complete", __ref.getField(false, "ba"), anywheresoftware.b4a.pc.PCResumableSub.createDebugResumeSub(this, "b4xpagesmanager", "handlecloserequest"), _rs);
this.state = 5;
return;
case 5:
//C
this.state = 1;
_shouldclose = (RemoteObject) result.getArrayElement(true,RemoteObject.createImmutable(1));Debug.locals.put("ShouldClose", _shouldclose);
;
 BA.debugLineNum = 539;BA.debugLine="If ShouldClose Then";
Debug.JustUpdateDeviceLine();
if (true) break;

case 1:
//if
this.state = 4;
if (_shouldclose.<Boolean>get().booleanValue()) { 
this.state = 3;
}if (true) break;

case 3:
//C
this.state = 4;
 BA.debugLineNum = 540;BA.debugLine="ClosePage(pi.B4XPage)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_closepage" /*RemoteObject*/ ,(Object)(_pi.getField(false,"B4XPage" /*RemoteObject*/ )));
 if (true) break;

case 4:
//C
this.state = -1;
;
 BA.debugLineNum = 542;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
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
public static void  _complete(RemoteObject __ref,RemoteObject _shouldclose) throws Exception{
}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _mainform) throws Exception{
try {
		Debug.PushSubsStack("Initialize (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,57);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "b4xpagesmanager","initialize", __ref, _ba, _mainform);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
RemoteObject _nonmainpagewasadded = RemoteObject.createImmutable(false);
Debug.locals.put("ba", _ba);
Debug.locals.put("MainForm", _mainform);
 BA.debugLineNum = 57;BA.debugLine="Public Sub Initialize (MainForm As Form)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 63;BA.debugLine="IdToB4XPage.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_idtob4xpage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"));
 BA.debugLineNum = 64;BA.debugLine="RootB4XToPage.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_rootb4xtopage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"));
 BA.debugLineNum = 65;BA.debugLine="mStackOfPageIds.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"));
 BA.debugLineNum = 67;BA.debugLine="mMainForm = MainForm";
Debug.JustUpdateDeviceLine();
__ref.setField ("_mmainform" /*RemoteObject*/ ,_mainform);
 BA.debugLineNum = 78;BA.debugLine="B4XPages.InternalSetPagesManager(Me)";
Debug.JustUpdateDeviceLine();
b4xpagesmanager._b4xpages.runVoidMethod ("_internalsetpagesmanager" /*RemoteObject*/ ,(Object)(__ref));
 BA.debugLineNum = 79;BA.debugLine="MainPage.Initialize";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mainpage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xmainpage.class, "_initialize" /*RemoteObject*/ ,__ref.getField(false, "ba"));
 BA.debugLineNum = 80;BA.debugLine="Dim NonMainPageWasAdded As Boolean = IdToB4XPage.";
Debug.JustUpdateDeviceLine();
_nonmainpagewasadded = BA.ObjectToBoolean(RemoteObject.solveBoolean(">",__ref.getField(false,"_idtob4xpage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_getsize" /*RemoteObject*/ ),BA.numberCast(double.class, 0)));Debug.locals.put("NonMainPageWasAdded", _nonmainpagewasadded);Debug.locals.put("NonMainPageWasAdded", _nonmainpagewasadded);
 BA.debugLineNum = 81;BA.debugLine="IdToB4XPage.Put(\"~~~~~temp~~~~\", CreateB4XPageInf";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_idtob4xpage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_put" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable(("~~~~~temp~~~~"))),(Object)((__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_createb4xpageinfo" /*RemoteObject*/ ,(Object)((__ref.getField(false,"_mainpage" /*RemoteObject*/ ))),(Object)(BA.ObjectToString("")),(Object)(b4xpagesmanager.__c.getField(true,"False")),(Object)((RemoteObject.createImmutable("")))))));
 BA.debugLineNum = 82;BA.debugLine="BackgroundStateChanged(True)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_backgroundstatechanged" /*RemoteObject*/ ,(Object)(b4xpagesmanager.__c.getField(true,"True")));
 BA.debugLineNum = 83;BA.debugLine="IdToB4XPage.Remove(\"~~~~~temp~~~~\")";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_idtob4xpage" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xorderedmap.class, "_remove" /*RemoteObject*/ ,(Object)((RemoteObject.createImmutable("~~~~~temp~~~~"))));
 BA.debugLineNum = 84;BA.debugLine="AddPageAndCreate(\"MainPage\", MainPage)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_addpageandcreate" /*RemoteObject*/ ,(Object)(BA.ObjectToString("MainPage")),(Object)((__ref.getField(false,"_mainpage" /*RemoteObject*/ ))));
 BA.debugLineNum = 85;BA.debugLine="If LogEvents = False Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_logevents" /*RemoteObject*/ ),b4xpagesmanager.__c.getField(true,"False"))) { 
 BA.debugLineNum = 86;BA.debugLine="Log(\"Call B4XPages.GetManager.LogEvents = True t";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runVoidMethod ("LogImpl","96160413",RemoteObject.createImmutable("Call B4XPages.GetManager.LogEvents = True to enable logging B4XPages events."),0);
 };
 BA.debugLineNum = 88;BA.debugLine="If NonMainPageWasAdded Then";
Debug.JustUpdateDeviceLine();
if (_nonmainpagewasadded.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 89;BA.debugLine="If Not(xui.IsB4i) Then";
Debug.JustUpdateDeviceLine();
if (b4xpagesmanager.__c.runMethod(true,"Not",(Object)(__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"getIsB4i"))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 90;BA.debugLine="RaiseEvent(GetTopPage, \"B4XPage_Appear\", Null)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_raiseevent" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_gettoppage" /*RemoteObject*/ )),(Object)(BA.ObjectToString("B4XPage_Appear")),(Object)((b4xpagesmanager.__c.getField(false,"Null"))));
 };
 };
 BA.debugLineNum = 93;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _logevent(RemoteObject __ref,RemoteObject _pi,RemoteObject _ev) throws Exception{
try {
		Debug.PushSubsStack("LogEvent (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,637);
if (RapidSub.canDelegate("logevent")) { return __ref.runUserSub(false, "b4xpagesmanager","logevent", __ref, _pi, _ev);}
RemoteObject _msg = RemoteObject.createImmutable("");
Debug.locals.put("pi", _pi);
Debug.locals.put("ev", _ev);
 BA.debugLineNum = 637;BA.debugLine="Private Sub LogEvent (pi As B4XPageInfo, ev As Str";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 638;BA.debugLine="If LogEvents Then";
Debug.JustUpdateDeviceLine();
if (__ref.getField(true,"_logevents" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 639;BA.debugLine="Dim msg As String = $\"*** ${pi.Id}: ${ev} ${Stac";
Debug.JustUpdateDeviceLine();
_msg = (RemoteObject.concat(RemoteObject.createImmutable("*** "),b4xpagesmanager.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_pi.getField(true,"Id" /*RemoteObject*/ )))),RemoteObject.createImmutable(": "),b4xpagesmanager.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_ev))),RemoteObject.createImmutable(" "),b4xpagesmanager.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((__ref.getField(true,"_stackstring" /*RemoteObject*/ )))),RemoteObject.createImmutable("")));Debug.locals.put("msg", _msg);Debug.locals.put("msg", _msg);
 BA.debugLineNum = 640;BA.debugLine="Log(msg)";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runVoidMethod ("LogImpl","98323075",_msg,0);
 };
 BA.debugLineNum = 642;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_closed(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("MainForm_Closed (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,437);
if (RapidSub.canDelegate("mainform_closed")) { return __ref.runUserSub(false, "b4xpagesmanager","mainform_closed", __ref);}
RemoteObject _frm = RemoteObject.declareNull("anywheresoftware.b4j.objects.Form");
RemoteObject _pi = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
 BA.debugLineNum = 437;BA.debugLine="Public Sub MainForm_Closed";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 438;BA.debugLine="Dim frm As Form = Sender";
Debug.JustUpdateDeviceLine();
_frm = (b4xpagesmanager.__c.runMethod(false,"Sender",__ref.getField(false, "ba")));Debug.locals.put("frm", _frm);Debug.locals.put("frm", _frm);
 BA.debugLineNum = 439;BA.debugLine="Dim pi As B4XPageInfo = GetPageInfoFromRoot(frm.R";
Debug.JustUpdateDeviceLine();
_pi = __ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_getpageinfofromroot" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), _frm.runMethod(false,"getRootPane").getObject()));Debug.locals.put("pi", _pi);Debug.locals.put("pi", _pi);
 BA.debugLineNum = 440;BA.debugLine="RaiseEventWithResult(pi, \"B4XPage_Disappear\", Nul";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_raiseeventwithresult" /*RemoteObject*/ ,(Object)(_pi),(Object)(BA.ObjectToString("B4XPage_Disappear")),(Object)((b4xpagesmanager.__c.getField(false,"Null"))));
 BA.debugLineNum = 441;BA.debugLine="mStackOfPageIds.Remove(pi.Id)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_remove" /*RemoteObject*/ ,(Object)((_pi.getField(true,"Id" /*RemoteObject*/ ))));
 BA.debugLineNum = 442;BA.debugLine="If mStackOfPageIds.Size = 0 Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_getsize" /*RemoteObject*/ ),BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 443;BA.debugLine="BackgroundStateChanged(False)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_backgroundstatechanged" /*RemoteObject*/ ,(Object)(b4xpagesmanager.__c.getField(true,"False")));
 };
 BA.debugLineNum = 445;BA.debugLine="UpdateStackString";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_updatestackstring" /*RemoteObject*/ );
 BA.debugLineNum = 446;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_closerequest(RemoteObject __ref,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("MainForm_CloseRequest (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,454);
if (RapidSub.canDelegate("mainform_closerequest")) { return __ref.runUserSub(false, "b4xpagesmanager","mainform_closerequest", __ref, _eventdata);}
RemoteObject _frm = RemoteObject.declareNull("anywheresoftware.b4j.objects.Form");
RemoteObject _pi = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 454;BA.debugLine="Public Sub MainForm_CloseRequest (EventData As Eve";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 455;BA.debugLine="Dim frm As Form = Sender";
Debug.JustUpdateDeviceLine();
_frm = (b4xpagesmanager.__c.runMethod(false,"Sender",__ref.getField(false, "ba")));Debug.locals.put("frm", _frm);Debug.locals.put("frm", _frm);
 BA.debugLineNum = 456;BA.debugLine="Dim pi As B4XPageInfo = GetPageInfoFromRoot(frm.R";
Debug.JustUpdateDeviceLine();
_pi = __ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_getpageinfofromroot" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), _frm.runMethod(false,"getRootPane").getObject()));Debug.locals.put("pi", _pi);Debug.locals.put("pi", _pi);
 BA.debugLineNum = 457;BA.debugLine="If pi <> Null And CloseRequestExists (pi) Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("N",_pi) && RemoteObject.solveBoolean(".",__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_closerequestexists" /*RemoteObject*/ ,(Object)(_pi)))) { 
 BA.debugLineNum = 458;BA.debugLine="EventData.Consume";
Debug.JustUpdateDeviceLine();
_eventdata.runVoidMethod ("Consume");
 BA.debugLineNum = 459;BA.debugLine="HandleCloseRequest (pi)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_handlecloserequest" /*void*/ ,(Object)(_pi));
 };
 BA.debugLineNum = 461;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_focuschanged(RemoteObject __ref,RemoteObject _hasfocus) throws Exception{
try {
		Debug.PushSubsStack("MainForm_FocusChanged (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,428);
if (RapidSub.canDelegate("mainform_focuschanged")) { return __ref.runUserSub(false, "b4xpagesmanager","mainform_focuschanged", __ref, _hasfocus);}
RemoteObject _frm = RemoteObject.declareNull("anywheresoftware.b4j.objects.Form");
RemoteObject _pi = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
Debug.locals.put("HasFocus", _hasfocus);
 BA.debugLineNum = 428;BA.debugLine="Public Sub MainForm_FocusChanged (HasFocus As Bool";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 429;BA.debugLine="Dim frm As Form = Sender";
Debug.JustUpdateDeviceLine();
_frm = (b4xpagesmanager.__c.runMethod(false,"Sender",__ref.getField(false, "ba")));Debug.locals.put("frm", _frm);Debug.locals.put("frm", _frm);
 BA.debugLineNum = 430;BA.debugLine="Dim pi As B4XPageInfo = GetPageInfoFromRoot(frm.R";
Debug.JustUpdateDeviceLine();
_pi = __ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_getpageinfofromroot" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), _frm.runMethod(false,"getRootPane").getObject()));Debug.locals.put("pi", _pi);Debug.locals.put("pi", _pi);
 BA.debugLineNum = 431;BA.debugLine="If pi = Null Then Return";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("n",_pi)) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 432;BA.debugLine="If HasFocus Then";
Debug.JustUpdateDeviceLine();
if (_hasfocus.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 433;BA.debugLine="MovePageToTop(pi)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_movepagetotop" /*RemoteObject*/ ,(Object)(_pi));
 };
 BA.debugLineNum = 435;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_iconifiedchanged(RemoteObject __ref,RemoteObject _iconified) throws Exception{
try {
		Debug.PushSubsStack("MainForm_IconifiedChanged (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,448);
if (RapidSub.canDelegate("mainform_iconifiedchanged")) { return __ref.runUserSub(false, "b4xpagesmanager","mainform_iconifiedchanged", __ref, _iconified);}
RemoteObject _frm = RemoteObject.declareNull("anywheresoftware.b4j.objects.Form");
RemoteObject _pi = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
Debug.locals.put("Iconified", _iconified);
 BA.debugLineNum = 448;BA.debugLine="Public Sub MainForm_IconifiedChanged (Iconified As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 449;BA.debugLine="Dim frm As Form = Sender";
Debug.JustUpdateDeviceLine();
_frm = (b4xpagesmanager.__c.runMethod(false,"Sender",__ref.getField(false, "ba")));Debug.locals.put("frm", _frm);Debug.locals.put("frm", _frm);
 BA.debugLineNum = 450;BA.debugLine="Dim pi As B4XPageInfo = GetPageInfoFromRoot(frm.R";
Debug.JustUpdateDeviceLine();
_pi = __ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_getpageinfofromroot" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), _frm.runMethod(false,"getRootPane").getObject()));Debug.locals.put("pi", _pi);Debug.locals.put("pi", _pi);
 BA.debugLineNum = 451;BA.debugLine="RaiseEvent(pi, \"B4XPage_IconifiedChanged\", Array(";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_raiseevent" /*RemoteObject*/ ,(Object)(_pi),(Object)(BA.ObjectToString("B4XPage_IconifiedChanged")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(_iconified)})));
 BA.debugLineNum = 452;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_resize(RemoteObject __ref,RemoteObject _width,RemoteObject _height) throws Exception{
try {
		Debug.PushSubsStack("MainForm_Resize (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,582);
if (RapidSub.canDelegate("mainform_resize")) { return __ref.runUserSub(false, "b4xpagesmanager","mainform_resize", __ref, _width, _height);}
RemoteObject _w = RemoteObject.createImmutable(0);
RemoteObject _h = RemoteObject.createImmutable(0);
Debug.locals.put("Width", _width);
Debug.locals.put("Height", _height);
 BA.debugLineNum = 582;BA.debugLine="Public Sub MainForm_Resize(Width As Double, Height";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 583;BA.debugLine="Dim w As Int = Width";
Debug.JustUpdateDeviceLine();
_w = BA.numberCast(int.class, _width);Debug.locals.put("w", _w);Debug.locals.put("w", _w);
 BA.debugLineNum = 584;BA.debugLine="Dim h As Int = Height";
Debug.JustUpdateDeviceLine();
_h = BA.numberCast(int.class, _height);Debug.locals.put("h", _h);Debug.locals.put("h", _h);
 BA.debugLineNum = 585;BA.debugLine="RaiseEvent(GetPageInfoFromRoot(Sender), \"B4XPage_";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_raiseevent" /*RemoteObject*/ ,(Object)(__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_getpageinfofromroot" /*RemoteObject*/ ,RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4a.objects.B4XViewWrapper"), b4xpagesmanager.__c.runMethod(false,"Sender",__ref.getField(false, "ba"))))),(Object)(BA.ObjectToString("B4XPage_Resize")),(Object)(RemoteObject.createNewArray("Object",new int[] {2},new Object[] {(_w),(_h)})));
 BA.debugLineNum = 586;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _movepagetotop(RemoteObject __ref,RemoteObject _pi) throws Exception{
try {
		Debug.PushSubsStack("MovePageToTop (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,410);
if (RapidSub.canDelegate("movepagetotop")) { return __ref.runUserSub(false, "b4xpagesmanager","movepagetotop", __ref, _pi);}
Debug.locals.put("pi", _pi);
 BA.debugLineNum = 410;BA.debugLine="Private Sub MovePageToTop (pi As B4XPageInfo)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 411;BA.debugLine="mStackOfPageIds.Remove(pi.Id)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_remove" /*RemoteObject*/ ,(Object)((_pi.getField(true,"Id" /*RemoteObject*/ ))));
 BA.debugLineNum = 412;BA.debugLine="mStackOfPageIds.Add(pi.Id)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_add" /*RemoteObject*/ ,(Object)((_pi.getField(true,"Id" /*RemoteObject*/ ))));
 BA.debugLineNum = 413;BA.debugLine="UpdateStackString";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_updatestackstring" /*RemoteObject*/ );
 BA.debugLineNum = 414;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _raiseevent(RemoteObject __ref,RemoteObject _targetpage,RemoteObject _subname,RemoteObject _params) throws Exception{
try {
		Debug.PushSubsStack("RaiseEvent (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,545);
if (RapidSub.canDelegate("raiseevent")) { return __ref.runUserSub(false, "b4xpagesmanager","raiseevent", __ref, _targetpage, _subname, _params);}
RemoteObject _length = RemoteObject.createImmutable(0);
Debug.locals.put("TargetPage", _targetpage);
Debug.locals.put("SubName", _subname);
Debug.locals.put("Params", _params);
 BA.debugLineNum = 545;BA.debugLine="Public Sub RaiseEvent (TargetPage As B4XPageInfo,";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 546;BA.debugLine="If TargetPage = Null Then Return";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("n",_targetpage)) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 547;BA.debugLine="Dim length As Int";
Debug.JustUpdateDeviceLine();
_length = RemoteObject.createImmutable(0);Debug.locals.put("length", _length);
 BA.debugLineNum = 548;BA.debugLine="If Params = Null Then length = 0 Else length = Pa";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("n",_params)) { 
_length = BA.numberCast(int.class, 0);Debug.locals.put("length", _length);}
else {
_length = _params.getField(true,"length");Debug.locals.put("length", _length);};
 BA.debugLineNum = 549;BA.debugLine="LogEvent(TargetPage, SubName)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_logevent" /*RemoteObject*/ ,(Object)(_targetpage),(Object)(_subname));
 BA.debugLineNum = 550;BA.debugLine="If xui.SubExists(TargetPage.B4XPage, SubName, len";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(_targetpage.getField(false,"B4XPage" /*RemoteObject*/ )),(Object)(_subname),(Object)(_length)),b4xpagesmanager.__c.getField(true,"False"))) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 551;BA.debugLine="Select length";
Debug.JustUpdateDeviceLine();
switch (BA.switchObjectToInt(_length,BA.numberCast(int.class, 0),BA.numberCast(int.class, 1),BA.numberCast(int.class, 2))) {
case 0: {
 BA.debugLineNum = 553;BA.debugLine="CallSubDelayed(TargetPage.B4XPage, SubName)";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runVoidMethod ("CallSubDelayed",__ref.getField(false, "ba"),(Object)(_targetpage.getField(false,"B4XPage" /*RemoteObject*/ )),(Object)(_subname));
 break; }
case 1: {
 BA.debugLineNum = 555;BA.debugLine="CallSubDelayed2(TargetPage.B4XPage, SubName, Pa";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)(_targetpage.getField(false,"B4XPage" /*RemoteObject*/ )),(Object)(_subname),(Object)(_params.getArrayElement(false,BA.numberCast(int.class, 0))));
 break; }
case 2: {
 BA.debugLineNum = 557;BA.debugLine="CallSubDelayed3(TargetPage.B4XPage, SubName, Pa";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runVoidMethod ("CallSubDelayed3",__ref.getField(false, "ba"),(Object)(_targetpage.getField(false,"B4XPage" /*RemoteObject*/ )),(Object)(_subname),(Object)(_params.getArrayElement(false,BA.numberCast(int.class, 0))),(Object)(_params.getArrayElement(false,BA.numberCast(int.class, 1))));
 break; }
default: {
 BA.debugLineNum = 559;BA.debugLine="Log(\"Too many parameters\")";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runVoidMethod ("LogImpl","97798798",RemoteObject.createImmutable("Too many parameters"),0);
 break; }
}
;
 BA.debugLineNum = 561;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _raiseeventwithresult(RemoteObject __ref,RemoteObject _targetpage,RemoteObject _subname,RemoteObject _params) throws Exception{
try {
		Debug.PushSubsStack("RaiseEventWithResult (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,563);
if (RapidSub.canDelegate("raiseeventwithresult")) { return __ref.runUserSub(false, "b4xpagesmanager","raiseeventwithresult", __ref, _targetpage, _subname, _params);}
RemoteObject _length = RemoteObject.createImmutable(0);
Debug.locals.put("TargetPage", _targetpage);
Debug.locals.put("SubName", _subname);
Debug.locals.put("Params", _params);
 BA.debugLineNum = 563;BA.debugLine="Public Sub RaiseEventWithResult (TargetPage As B4X";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 564;BA.debugLine="If TargetPage = Null Then Return Null";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("n",_targetpage)) { 
if (true) return b4xpagesmanager.__c.getField(false,"Null");};
 BA.debugLineNum = 565;BA.debugLine="Dim length As Int";
Debug.JustUpdateDeviceLine();
_length = RemoteObject.createImmutable(0);Debug.locals.put("length", _length);
 BA.debugLineNum = 566;BA.debugLine="If Params = Null Then length = 0 Else length = Pa";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("n",_params)) { 
_length = BA.numberCast(int.class, 0);Debug.locals.put("length", _length);}
else {
_length = _params.getField(true,"length");Debug.locals.put("length", _length);};
 BA.debugLineNum = 567;BA.debugLine="LogEvent(TargetPage, SubName)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_logevent" /*RemoteObject*/ ,(Object)(_targetpage),(Object)(_subname));
 BA.debugLineNum = 568;BA.debugLine="If xui.SubExists(TargetPage.B4XPage, SubName, len";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"SubExists",__ref.getField(false, "ba"),(Object)(_targetpage.getField(false,"B4XPage" /*RemoteObject*/ )),(Object)(_subname),(Object)(_length)),b4xpagesmanager.__c.getField(true,"False"))) { 
if (true) return b4xpagesmanager.__c.getField(false,"Null");};
 BA.debugLineNum = 569;BA.debugLine="Select length";
Debug.JustUpdateDeviceLine();
switch (BA.switchObjectToInt(_length,BA.numberCast(int.class, 0),BA.numberCast(int.class, 1),BA.numberCast(int.class, 2))) {
case 0: {
 BA.debugLineNum = 571;BA.debugLine="Return CallSub(TargetPage.B4XPage, SubName)";
Debug.JustUpdateDeviceLine();
if (true) return b4xpagesmanager.__c.runMethodAndSync(false,"CallSubNew",__ref.getField(false, "ba"),(Object)(_targetpage.getField(false,"B4XPage" /*RemoteObject*/ )),(Object)(_subname));
 break; }
case 1: {
 BA.debugLineNum = 573;BA.debugLine="Return CallSub2(TargetPage.B4XPage, SubName, Pa";
Debug.JustUpdateDeviceLine();
if (true) return b4xpagesmanager.__c.runMethodAndSync(false,"CallSubNew2",__ref.getField(false, "ba"),(Object)(_targetpage.getField(false,"B4XPage" /*RemoteObject*/ )),(Object)(_subname),(Object)(_params.getArrayElement(false,BA.numberCast(int.class, 0))));
 break; }
case 2: {
 BA.debugLineNum = 575;BA.debugLine="Return CallSub3(TargetPage.B4XPage, SubName, Pa";
Debug.JustUpdateDeviceLine();
if (true) return b4xpagesmanager.__c.runMethodAndSync(false,"CallSubNew3",__ref.getField(false, "ba"),(Object)(_targetpage.getField(false,"B4XPage" /*RemoteObject*/ )),(Object)(_subname),(Object)(_params.getArrayElement(false,BA.numberCast(int.class, 0))),(Object)(_params.getArrayElement(false,BA.numberCast(int.class, 1))));
 break; }
default: {
 BA.debugLineNum = 577;BA.debugLine="Log(\"Too many parameters\")";
Debug.JustUpdateDeviceLine();
b4xpagesmanager.__c.runVoidMethod ("LogImpl","97864334",RemoteObject.createImmutable("Too many parameters"),0);
 break; }
}
;
 BA.debugLineNum = 579;BA.debugLine="Return Null";
Debug.JustUpdateDeviceLine();
if (true) return b4xpagesmanager.__c.getField(false,"Null");
 BA.debugLineNum = 580;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _settitle(RemoteObject __ref,RemoteObject _b4xpage,RemoteObject _title) throws Exception{
try {
		Debug.PushSubsStack("SetTitle (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,360);
if (RapidSub.canDelegate("settitle")) { return __ref.runUserSub(false, "b4xpagesmanager","settitle", __ref, _b4xpage, _title);}
RemoteObject _pi = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
Debug.locals.put("B4XPage", _b4xpage);
Debug.locals.put("Title", _title);
 BA.debugLineNum = 360;BA.debugLine="Public Sub SetTitle (B4XPage As Object, Title As O";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 361;BA.debugLine="Dim pi As B4XPageInfo = FindPIFromB4XPage(B4XPage";
Debug.JustUpdateDeviceLine();
_pi = __ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_findpifromb4xpage" /*RemoteObject*/ ,(Object)(_b4xpage));Debug.locals.put("pi", _pi);Debug.locals.put("pi", _pi);
 BA.debugLineNum = 362;BA.debugLine="pi.Title = Title";
Debug.JustUpdateDeviceLine();
_pi.setField ("Title" /*RemoteObject*/ ,_title);
 BA.debugLineNum = 363;BA.debugLine="pi.Parent.NativeType.Title = Title";
Debug.JustUpdateDeviceLine();
_pi.getField(false,"Parent" /*RemoteObject*/ ).getField(false,"NativeType" /*RemoteObject*/ ).runMethod(true,"setTitle",BA.ObjectToString(_title));
 BA.debugLineNum = 364;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _showpage(RemoteObject __ref,RemoteObject _id) throws Exception{
try {
		Debug.PushSubsStack("ShowPage (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,156);
if (RapidSub.canDelegate("showpage")) { return __ref.runUserSub(false, "b4xpagesmanager","showpage", __ref, _id);}
RemoteObject _pi = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
Debug.locals.put("Id", _id);
 BA.debugLineNum = 156;BA.debugLine="Public Sub ShowPage (Id As String)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 157;BA.debugLine="Dim pi As B4XPageInfo = GetPageFromId(Id)";
Debug.JustUpdateDeviceLine();
_pi = __ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_getpagefromid" /*RemoteObject*/ ,(Object)(_id));Debug.locals.put("pi", _pi);Debug.locals.put("pi", _pi);
 BA.debugLineNum = 158;BA.debugLine="If pi = GetTopPage Then Return";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_pi,__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_gettoppage" /*RemoteObject*/ ))) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 159;BA.debugLine="CreatePageIfNeeded(pi)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_createpageifneeded" /*RemoteObject*/ ,(Object)(_pi));
 BA.debugLineNum = 160;BA.debugLine="TopPageDisappear";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_toppagedisappear" /*RemoteObject*/ );
 BA.debugLineNum = 174;BA.debugLine="mStackOfPageIds.Remove(pi.Id)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_remove" /*RemoteObject*/ ,(Object)((_pi.getField(true,"Id" /*RemoteObject*/ ))));
 BA.debugLineNum = 175;BA.debugLine="ShowPageImpl(pi)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_showpageimpl" /*RemoteObject*/ ,(Object)(_pi));
 BA.debugLineNum = 176;BA.debugLine="mStackOfPageIds.Add(pi.Id)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_add" /*RemoteObject*/ ,(Object)((_pi.getField(true,"Id" /*RemoteObject*/ ))));
 BA.debugLineNum = 177;BA.debugLine="TopPageAppear";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_toppageappear" /*RemoteObject*/ );
 BA.debugLineNum = 178;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _showpageandremovepreviouspages(RemoteObject __ref,RemoteObject _id) throws Exception{
try {
		Debug.PushSubsStack("ShowPageAndRemovePreviousPages (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,180);
if (RapidSub.canDelegate("showpageandremovepreviouspages")) { return __ref.runUserSub(false, "b4xpagesmanager","showpageandremovepreviouspages", __ref, _id);}
RemoteObject _pi = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
RemoteObject _pagetoremove = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
Debug.locals.put("Id", _id);
 BA.debugLineNum = 180;BA.debugLine="Public Sub ShowPageAndRemovePreviousPages (Id As S";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 181;BA.debugLine="If GetTopPage = Null Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("n",__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_gettoppage" /*RemoteObject*/ ))) { 
 BA.debugLineNum = 182;BA.debugLine="ShowPage(Id)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_showpage" /*RemoteObject*/ ,(Object)(_id));
 BA.debugLineNum = 183;BA.debugLine="Return";
Debug.JustUpdateDeviceLine();
if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 185;BA.debugLine="Dim pi As B4XPageInfo = GetPageFromId(Id)";
Debug.JustUpdateDeviceLine();
_pi = __ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_getpagefromid" /*RemoteObject*/ ,(Object)(_id));Debug.locals.put("pi", _pi);Debug.locals.put("pi", _pi);
 BA.debugLineNum = 186;BA.debugLine="CreatePageIfNeeded(pi)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_createpageifneeded" /*RemoteObject*/ ,(Object)(_pi));
 BA.debugLineNum = 187;BA.debugLine="TopPageDisappear";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_toppagedisappear" /*RemoteObject*/ );
 BA.debugLineNum = 191;BA.debugLine="For Each Id As String In mStackOfPageIds.AsList";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group8 = __ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_aslist" /*RemoteObject*/ );
final int groupLen8 = group8.runMethod(true,"getSize").<Integer>get()
;int index8 = 0;
;
for (; index8 < groupLen8;index8++){
_id = BA.ObjectToString(group8.runMethod(false,"Get",index8));Debug.locals.put("Id", _id);
Debug.locals.put("Id", _id);
 BA.debugLineNum = 192;BA.debugLine="Dim PageToRemove As B4XPageInfo = GetPageFromId(";
Debug.JustUpdateDeviceLine();
_pagetoremove = __ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_getpagefromid" /*RemoteObject*/ ,(Object)(_id));Debug.locals.put("PageToRemove", _pagetoremove);Debug.locals.put("PageToRemove", _pagetoremove);
 BA.debugLineNum = 196;BA.debugLine="If PageToRemove.Id = pi.Id Then Continue";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_pagetoremove.getField(true,"Id" /*RemoteObject*/ ),_pi.getField(true,"Id" /*RemoteObject*/ ))) { 
if (true) continue;};
 BA.debugLineNum = 197;BA.debugLine="PageToRemove.Parent.NativeType.Close";
Debug.JustUpdateDeviceLine();
_pagetoremove.getField(false,"Parent" /*RemoteObject*/ ).getField(false,"NativeType" /*RemoteObject*/ ).runVoidMethod ("Close");
 }
}Debug.locals.put("Id", _id);
;
 BA.debugLineNum = 201;BA.debugLine="mStackOfPageIds.Clear";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_clear" /*RemoteObject*/ );
 BA.debugLineNum = 202;BA.debugLine="mStackOfPageIds.Add(pi.Id)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_add" /*RemoteObject*/ ,(Object)((_pi.getField(true,"Id" /*RemoteObject*/ ))));
 BA.debugLineNum = 203;BA.debugLine="If xui.IsB4A Or xui.IsB4J Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(".",__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"getIsB4A")) || RemoteObject.solveBoolean(".",__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"getIsB4J"))) { 
 BA.debugLineNum = 204;BA.debugLine="ShowPageImpl(pi)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_showpageimpl" /*RemoteObject*/ ,(Object)(_pi));
 };
 BA.debugLineNum = 206;BA.debugLine="TopPageAppear";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_toppageappear" /*RemoteObject*/ );
 BA.debugLineNum = 207;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _showpageimpl(RemoteObject __ref,RemoteObject _pi) throws Exception{
try {
		Debug.PushSubsStack("ShowPageImpl (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,330);
if (RapidSub.canDelegate("showpageimpl")) { return __ref.runUserSub(false, "b4xpagesmanager","showpageimpl", __ref, _pi);}
RemoteObject _jo = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
Debug.locals.put("pi", _pi);
 BA.debugLineNum = 330;BA.debugLine="Private Sub ShowPageImpl (pi As B4XPageInfo)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 332;BA.debugLine="pi.Parent.NativeType.Show";
Debug.JustUpdateDeviceLine();
_pi.getField(false,"Parent" /*RemoteObject*/ ).getField(false,"NativeType" /*RemoteObject*/ ).runVoidMethodAndSync ("Show");
 BA.debugLineNum = 333;BA.debugLine="Dim jo As JavaObject = pi.Parent.NativeType";
Debug.JustUpdateDeviceLine();
_jo = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_jo = RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("anywheresoftware.b4j.object.JavaObject"), _pi.getField(false,"Parent" /*RemoteObject*/ ).getField(false,"NativeType" /*RemoteObject*/ ));Debug.locals.put("jo", _jo);Debug.locals.put("jo", _jo);
 BA.debugLineNum = 334;BA.debugLine="jo.GetFieldJO(\"stage\").RunMethod(\"requestFocus\",";
Debug.JustUpdateDeviceLine();
_jo.runMethod(false,"GetFieldJO",(Object)(RemoteObject.createImmutable("stage"))).runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("requestFocus")),(Object)((b4xpagesmanager.__c.getField(false,"Null"))));
 BA.debugLineNum = 347;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _toppageappear(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("TopPageAppear (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,285);
if (RapidSub.canDelegate("toppageappear")) { return __ref.runUserSub(false, "b4xpagesmanager","toppageappear", __ref);}
RemoteObject _pi = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
 BA.debugLineNum = 285;BA.debugLine="Private Sub TopPageAppear";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 286;BA.debugLine="Dim pi As B4XPageInfo = GetTopPage";
Debug.JustUpdateDeviceLine();
_pi = __ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_gettoppage" /*RemoteObject*/ );Debug.locals.put("pi", _pi);Debug.locals.put("pi", _pi);
 BA.debugLineNum = 287;BA.debugLine="If pi = Null Then Return";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("n",_pi)) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 288;BA.debugLine="pi.Parent.NativeType.Title = pi.Title";
Debug.JustUpdateDeviceLine();
_pi.getField(false,"Parent" /*RemoteObject*/ ).getField(false,"NativeType" /*RemoteObject*/ ).runMethod(true,"setTitle",BA.ObjectToString(_pi.getField(false,"Title" /*RemoteObject*/ )));
 BA.debugLineNum = 289;BA.debugLine="If Not(xui.IsB4i) Then";
Debug.JustUpdateDeviceLine();
if (b4xpagesmanager.__c.runMethod(true,"Not",(Object)(__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"getIsB4i"))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 290;BA.debugLine="If IsForeground Then";
Debug.JustUpdateDeviceLine();
if (__ref.getField(true,"_isforeground" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 291;BA.debugLine="RaiseEvent(pi, \"B4XPage_Appear\", Null)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_raiseevent" /*RemoteObject*/ ,(Object)(_pi),(Object)(BA.ObjectToString("B4XPage_Appear")),(Object)((b4xpagesmanager.__c.getField(false,"Null"))));
 };
 };
 BA.debugLineNum = 300;BA.debugLine="UpdateStackString";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_updatestackstring" /*RemoteObject*/ );
 BA.debugLineNum = 301;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _toppagedisappear(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("TopPageDisappear (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,274);
if (RapidSub.canDelegate("toppagedisappear")) { return __ref.runUserSub(false, "b4xpagesmanager","toppagedisappear", __ref);}
RemoteObject _pi = RemoteObject.declareNull("b4j.example.b4xpagesmanager._b4xpageinfo");
 BA.debugLineNum = 274;BA.debugLine="Private Sub TopPageDisappear";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 275;BA.debugLine="If xui.IsB4J Then Return";
Debug.JustUpdateDeviceLine();
if (__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"getIsB4J").<Boolean>get().booleanValue()) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 276;BA.debugLine="Dim pi As B4XPageInfo = GetTopPage";
Debug.JustUpdateDeviceLine();
_pi = __ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_gettoppage" /*RemoteObject*/ );Debug.locals.put("pi", _pi);Debug.locals.put("pi", _pi);
 BA.debugLineNum = 277;BA.debugLine="If pi = Null Then Return";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("n",_pi)) { 
if (true) return RemoteObject.createImmutable("");};
 BA.debugLineNum = 278;BA.debugLine="If Not(xui.IsB4i) Then";
Debug.JustUpdateDeviceLine();
if (b4xpagesmanager.__c.runMethod(true,"Not",(Object)(__ref.getField(false,"_xui" /*RemoteObject*/ ).runMethod(true,"getIsB4i"))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 279;BA.debugLine="If IsForeground Then";
Debug.JustUpdateDeviceLine();
if (__ref.getField(true,"_isforeground" /*RemoteObject*/ ).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 280;BA.debugLine="RaiseEventWithResult(pi, \"B4XPage_Disappear\", N";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.b4xpagesmanager.class, "_raiseeventwithresult" /*RemoteObject*/ ,(Object)(_pi),(Object)(BA.ObjectToString("B4XPage_Disappear")),(Object)((b4xpagesmanager.__c.getField(false,"Null"))));
 };
 };
 BA.debugLineNum = 283;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _updatestackstring(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("UpdateStackString (b4xpagesmanager) ","b4xpagesmanager",9,__ref.getField(false, "ba"),__ref,644);
if (RapidSub.canDelegate("updatestackstring")) { return __ref.runUserSub(false, "b4xpagesmanager","updatestackstring", __ref);}
RemoteObject _sb = RemoteObject.declareNull("anywheresoftware.b4a.keywords.StringBuilderWrapper");
RemoteObject _id = RemoteObject.createImmutable("");
 BA.debugLineNum = 644;BA.debugLine="Public Sub UpdateStackString";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 645;BA.debugLine="Dim sb As StringBuilder";
Debug.JustUpdateDeviceLine();
_sb = RemoteObject.createNew ("anywheresoftware.b4a.keywords.StringBuilderWrapper");Debug.locals.put("sb", _sb);
 BA.debugLineNum = 646;BA.debugLine="sb.Initialize";
Debug.JustUpdateDeviceLine();
_sb.runVoidMethod ("Initialize");
 BA.debugLineNum = 647;BA.debugLine="sb.Append(\"[\")";
Debug.JustUpdateDeviceLine();
_sb.runVoidMethod ("Append",(Object)(RemoteObject.createImmutable("[")));
 BA.debugLineNum = 648;BA.debugLine="If mStackOfPageIds.Size > 0 Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",__ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_getsize" /*RemoteObject*/ ),BA.numberCast(double.class, 0))) { 
 BA.debugLineNum = 649;BA.debugLine="For Each id As String In mStackOfPageIds.AsList";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group5 = __ref.getField(false,"_mstackofpageids" /*RemoteObject*/ ).runClassMethod (b4j.example.b4xset.class, "_aslist" /*RemoteObject*/ );
final int groupLen5 = group5.runMethod(true,"getSize").<Integer>get()
;int index5 = 0;
;
for (; index5 < groupLen5;index5++){
_id = BA.ObjectToString(group5.runMethod(false,"Get",index5));Debug.locals.put("id", _id);
Debug.locals.put("id", _id);
 BA.debugLineNum = 650;BA.debugLine="sb.Append(id).Append(\", \")";
Debug.JustUpdateDeviceLine();
_sb.runMethod(false,"Append",(Object)(_id)).runVoidMethod ("Append",(Object)(RemoteObject.createImmutable(", ")));
 }
}Debug.locals.put("id", _id);
;
 BA.debugLineNum = 652;BA.debugLine="sb.Remove(sb.Length - 2, sb.Length)";
Debug.JustUpdateDeviceLine();
_sb.runVoidMethod ("Remove",(Object)(RemoteObject.solve(new RemoteObject[] {_sb.runMethod(true,"getLength"),RemoteObject.createImmutable(2)}, "-",1, 1)),(Object)(_sb.runMethod(true,"getLength")));
 };
 BA.debugLineNum = 654;BA.debugLine="sb.Append(\"]\")";
Debug.JustUpdateDeviceLine();
_sb.runVoidMethod ("Append",(Object)(RemoteObject.createImmutable("]")));
 BA.debugLineNum = 655;BA.debugLine="StackString = sb.ToString";
Debug.JustUpdateDeviceLine();
__ref.setField ("_stackstring" /*RemoteObject*/ ,_sb.runMethod(true,"ToString"));
 BA.debugLineNum = 656;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}