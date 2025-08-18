package b4j.HTMLEditorFix;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class b4xpagesmanager extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.HTMLEditorFix", "b4j.HTMLEditorFix.b4xpagesmanager", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.HTMLEditorFix.b4xpagesmanager.class).invoke(this, new Object[] {null});
        else
            ba.raiseEvent2(null, true, "class_globals", false);
    }

 
    public void  innerInitializeHelper(anywheresoftware.b4a.BA _ba) throws Exception{
        innerInitialize(_ba);
    }
    public Object callSub(String sub, Object sender, Object[] args) throws Exception {
        return BA.SubDelegator.SubNotFound;
    }
public static class _b4xpageparent{
public boolean IsInitialized;
public anywheresoftware.b4j.objects.Form NativeType;
public void Initialize() {
IsInitialized = true;
NativeType = new anywheresoftware.b4j.objects.Form();
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public static class _b4xpageinfo{
public boolean IsInitialized;
public Object B4XPage;
public String Id;
public boolean Created;
public Object Title;
public anywheresoftware.b4a.objects.B4XViewWrapper Root;
public boolean IsFirst;
public b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent Parent;
public void Initialize() {
IsInitialized = true;
B4XPage = new Object();
Id = "";
Created = false;
Title = new Object();
Root = new anywheresoftware.b4a.objects.B4XViewWrapper();
IsFirst = false;
Parent = new b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent();
}
@Override
		public String toString() {
			return BA.TypeToString(this, false);
		}}
public anywheresoftware.b4a.keywords.Common __c = null;
public b4j.HTMLEditorFix.b4xorderedmap _idtob4xpage = null;
public b4j.HTMLEditorFix.b4xorderedmap _rootb4xtopage = null;
public b4j.HTMLEditorFix.b4xset _mstackofpageids = null;
public anywheresoftware.b4a.objects.B4XViewWrapper.XUI _xui = null;
public anywheresoftware.b4j.objects.Form _mmainform = null;
public boolean _isforeground = false;
public int _transitionanimationduration = 0;
public b4j.HTMLEditorFix.b4xmainpage _mainpage = null;
public String _stackstring = "";
public boolean _logevents = false;
public b4j.HTMLEditorFix.main _main = null;
public b4j.HTMLEditorFix.b4xpages _b4xpages = null;
public b4j.HTMLEditorFix.b4xcollections _b4xcollections = null;
public String  _initialize(b4j.HTMLEditorFix.b4xpagesmanager __ref,anywheresoftware.b4a.BA _ba,anywheresoftware.b4j.objects.Form _mainform) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "initialize", true))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba,_mainform}));}
boolean _nonmainpagewasadded = false;
RDebugUtils.currentLine=5505024;
 //BA.debugLineNum = 5505024;BA.debugLine="Public Sub Initialize (MainForm As Form)";
RDebugUtils.currentLine=5505030;
 //BA.debugLineNum = 5505030;BA.debugLine="IdToB4XPage.Initialize";
__ref._idtob4xpage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._initialize /*String*/ (null,ba);
RDebugUtils.currentLine=5505031;
 //BA.debugLineNum = 5505031;BA.debugLine="RootB4XToPage.Initialize";
__ref._rootb4xtopage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._initialize /*String*/ (null,ba);
RDebugUtils.currentLine=5505032;
 //BA.debugLineNum = 5505032;BA.debugLine="mStackOfPageIds.Initialize";
__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._initialize /*String*/ (null,ba);
RDebugUtils.currentLine=5505034;
 //BA.debugLineNum = 5505034;BA.debugLine="mMainForm = MainForm";
__ref._mmainform /*anywheresoftware.b4j.objects.Form*/  = _mainform;
RDebugUtils.currentLine=5505045;
 //BA.debugLineNum = 5505045;BA.debugLine="B4XPages.InternalSetPagesManager(Me)";
_b4xpages._internalsetpagesmanager /*String*/ (this);
RDebugUtils.currentLine=5505046;
 //BA.debugLineNum = 5505046;BA.debugLine="MainPage.Initialize";
__ref._mainpage /*b4j.HTMLEditorFix.b4xmainpage*/ ._initialize /*String*/ (null,ba);
RDebugUtils.currentLine=5505047;
 //BA.debugLineNum = 5505047;BA.debugLine="Dim NonMainPageWasAdded As Boolean = IdToB4XPage.";
_nonmainpagewasadded = __ref._idtob4xpage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._getsize /*int*/ (null)>0;
RDebugUtils.currentLine=5505048;
 //BA.debugLineNum = 5505048;BA.debugLine="IdToB4XPage.Put(\"~~~~~temp~~~~\", CreateB4XPageInf";
__ref._idtob4xpage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._put /*String*/ (null,(Object)("~~~~~temp~~~~"),(Object)(__ref._createb4xpageinfo /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null,(Object)(__ref._mainpage /*b4j.HTMLEditorFix.b4xmainpage*/ ),"",__c.False,(Object)(""))));
RDebugUtils.currentLine=5505049;
 //BA.debugLineNum = 5505049;BA.debugLine="BackgroundStateChanged(True)";
__ref._backgroundstatechanged /*String*/ (null,__c.True);
RDebugUtils.currentLine=5505050;
 //BA.debugLineNum = 5505050;BA.debugLine="IdToB4XPage.Remove(\"~~~~~temp~~~~\")";
__ref._idtob4xpage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._remove /*String*/ (null,(Object)("~~~~~temp~~~~"));
RDebugUtils.currentLine=5505051;
 //BA.debugLineNum = 5505051;BA.debugLine="AddPageAndCreate(\"MainPage\", MainPage)";
__ref._addpageandcreate /*String*/ (null,"MainPage",(Object)(__ref._mainpage /*b4j.HTMLEditorFix.b4xmainpage*/ ));
RDebugUtils.currentLine=5505052;
 //BA.debugLineNum = 5505052;BA.debugLine="If LogEvents = False Then";
if (__ref._logevents /*boolean*/ ==__c.False) { 
RDebugUtils.currentLine=5505053;
 //BA.debugLineNum = 5505053;BA.debugLine="Log(\"Call B4XPages.GetManager.LogEvents = True t";
__c.LogImpl("95505053","Call B4XPages.GetManager.LogEvents = True to enable logging B4XPages events.",0);
 };
RDebugUtils.currentLine=5505055;
 //BA.debugLineNum = 5505055;BA.debugLine="If NonMainPageWasAdded Then";
if (_nonmainpagewasadded) { 
RDebugUtils.currentLine=5505056;
 //BA.debugLineNum = 5505056;BA.debugLine="If Not(xui.IsB4i) Then";
if (__c.Not(__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .getIsB4i())) { 
RDebugUtils.currentLine=5505057;
 //BA.debugLineNum = 5505057;BA.debugLine="RaiseEvent(GetTopPage, \"B4XPage_Appear\", Null)";
__ref._raiseevent /*String*/ (null,__ref._gettoppage /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null),"B4XPage_Appear",(Object[])(__c.Null));
 };
 };
RDebugUtils.currentLine=5505060;
 //BA.debugLineNum = 5505060;BA.debugLine="End Sub";
return "";
}
public String  _addpage(b4j.HTMLEditorFix.b4xpagesmanager __ref,String _id,Object _b4xpage) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "addpage", true))
	 {return ((String) Debug.delegate(ba, "addpage", new Object[] {_id,_b4xpage}));}
String _idtolower = "";
RDebugUtils.currentLine=5570560;
 //BA.debugLineNum = 5570560;BA.debugLine="Public Sub AddPage (Id As String, B4XPage As Objec";
RDebugUtils.currentLine=5570561;
 //BA.debugLineNum = 5570561;BA.debugLine="Dim IdToLower As String = Id.ToLowerCase";
_idtolower = _id.toLowerCase();
RDebugUtils.currentLine=5570562;
 //BA.debugLineNum = 5570562;BA.debugLine="If IdToB4XPage.ContainsKey(IdToLower) Then";
if (__ref._idtob4xpage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._containskey /*boolean*/ (null,(Object)(_idtolower))) { 
RDebugUtils.currentLine=5570563;
 //BA.debugLineNum = 5570563;BA.debugLine="Log($\"Page with this id already exists: ${IdToLo";
__c.LogImpl("95570563",("Page with this id already exists: "+__c.SmartStringFormatter("",(Object)(_idtolower))+"!"),0);
RDebugUtils.currentLine=5570564;
 //BA.debugLineNum = 5570564;BA.debugLine="Return";
if (true) return "";
 };
RDebugUtils.currentLine=5570566;
 //BA.debugLineNum = 5570566;BA.debugLine="IdToB4XPage.Put(IdToLower, CreateB4XPageInfo(B4XP";
__ref._idtob4xpage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._put /*String*/ (null,(Object)(_idtolower),(Object)(__ref._createb4xpageinfo /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null,_b4xpage,_idtolower,__c.False,(Object)(_id))));
RDebugUtils.currentLine=5570567;
 //BA.debugLineNum = 5570567;BA.debugLine="If IdToB4XPage.Size = 1 Then ShowPage(IdToLower)";
if (__ref._idtob4xpage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._getsize /*int*/ (null)==1) { 
__ref._showpage /*String*/ (null,_idtolower);};
RDebugUtils.currentLine=5570568;
 //BA.debugLineNum = 5570568;BA.debugLine="End Sub";
return "";
}
public String  _addpageandcreate(b4j.HTMLEditorFix.b4xpagesmanager __ref,String _id,Object _b4xpage) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "addpageandcreate", true))
	 {return ((String) Debug.delegate(ba, "addpageandcreate", new Object[] {_id,_b4xpage}));}
RDebugUtils.currentLine=5636096;
 //BA.debugLineNum = 5636096;BA.debugLine="Public Sub AddPageAndCreate (Id As String, B4XPage";
RDebugUtils.currentLine=5636097;
 //BA.debugLineNum = 5636097;BA.debugLine="AddPage (Id, B4XPage)";
__ref._addpage /*String*/ (null,_id,_b4xpage);
RDebugUtils.currentLine=5636098;
 //BA.debugLineNum = 5636098;BA.debugLine="CreatePageIfNeeded(GetPageFromId(Id))";
__ref._createpageifneeded /*String*/ (null,__ref._getpagefromid /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null,_id));
RDebugUtils.currentLine=5636099;
 //BA.debugLineNum = 5636099;BA.debugLine="End Sub";
return "";
}
public String  _closepage(b4j.HTMLEditorFix.b4xpagesmanager __ref,Object _b4xpage) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "closepage", true))
	 {return ((String) Debug.delegate(ba, "closepage", new Object[] {_b4xpage}));}
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi = null;
RDebugUtils.currentLine=5832704;
 //BA.debugLineNum = 5832704;BA.debugLine="Public Sub ClosePage (B4XPage As Object)";
RDebugUtils.currentLine=5832705;
 //BA.debugLineNum = 5832705;BA.debugLine="Dim pi As B4XPageInfo = FindPIFromB4XPage(B4XPage";
_pi = __ref._findpifromb4xpage /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null,_b4xpage);
RDebugUtils.currentLine=5832706;
 //BA.debugLineNum = 5832706;BA.debugLine="If mStackOfPageIds.Contains(pi.Id) = False Then R";
if (__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._contains /*boolean*/ (null,(Object)(_pi.Id /*String*/ ))==__c.False) { 
if (true) return "";};
RDebugUtils.currentLine=5832707;
 //BA.debugLineNum = 5832707;BA.debugLine="If xui.IsB4i And GetTopPage <> pi Then";
if (__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .getIsB4i() && (__ref._gettoppage /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null)).equals(_pi) == false) { 
RDebugUtils.currentLine=5832708;
 //BA.debugLineNum = 5832708;BA.debugLine="Log(\"Only top page can be closed\")";
__c.LogImpl("95832708","Only top page can be closed",0);
RDebugUtils.currentLine=5832709;
 //BA.debugLineNum = 5832709;BA.debugLine="Return";
if (true) return "";
 }else 
{RDebugUtils.currentLine=5832710;
 //BA.debugLineNum = 5832710;BA.debugLine="Else If xui.IsB4i And mStackOfPageIds.Size = 1 Th";
if (__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .getIsB4i() && __ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._getsize /*int*/ (null)==1) { 
RDebugUtils.currentLine=5832711;
 //BA.debugLineNum = 5832711;BA.debugLine="Log(\"First page cannot be closed\")";
__c.LogImpl("95832711","First page cannot be closed",0);
RDebugUtils.currentLine=5832712;
 //BA.debugLineNum = 5832712;BA.debugLine="Return";
if (true) return "";
 }}
;
RDebugUtils.currentLine=5832714;
 //BA.debugLineNum = 5832714;BA.debugLine="ClosePageImpl(pi)";
__ref._closepageimpl /*String*/ (null,_pi);
RDebugUtils.currentLine=5832715;
 //BA.debugLineNum = 5832715;BA.debugLine="If GetTopPage = pi Then";
if ((__ref._gettoppage /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null)).equals(_pi)) { 
RDebugUtils.currentLine=5832716;
 //BA.debugLineNum = 5832716;BA.debugLine="TopPageDisappear";
__ref._toppagedisappear /*String*/ (null);
 };
RDebugUtils.currentLine=5832718;
 //BA.debugLineNum = 5832718;BA.debugLine="If xui.IsB4A And mStackOfPageIds.Size = 1 Then Re";
if (__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .getIsB4A() && __ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._getsize /*int*/ (null)==1) { 
if (true) return "";};
RDebugUtils.currentLine=5832719;
 //BA.debugLineNum = 5832719;BA.debugLine="mStackOfPageIds.Remove(pi.Id)";
__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._remove /*String*/ (null,(Object)(_pi.Id /*String*/ ));
RDebugUtils.currentLine=5832720;
 //BA.debugLineNum = 5832720;BA.debugLine="If xui.IsB4A Then ShowPageImpl(GetTopPage)";
if (__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .getIsB4A()) { 
__ref._showpageimpl /*String*/ (null,__ref._gettoppage /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null));};
RDebugUtils.currentLine=5832721;
 //BA.debugLineNum = 5832721;BA.debugLine="TopPageAppear";
__ref._toppageappear /*String*/ (null);
RDebugUtils.currentLine=5832722;
 //BA.debugLineNum = 5832722;BA.debugLine="End Sub";
return "";
}
public b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo  _findpifromb4xpage(b4j.HTMLEditorFix.b4xpagesmanager __ref,Object _page) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "findpifromb4xpage", true))
	 {return ((b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo) Debug.delegate(ba, "findpifromb4xpage", new Object[] {_page}));}
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi = null;
RDebugUtils.currentLine=6029312;
 //BA.debugLineNum = 6029312;BA.debugLine="Public Sub FindPIFromB4XPage (Page As Object) As B";
RDebugUtils.currentLine=6029313;
 //BA.debugLineNum = 6029313;BA.debugLine="For Each pi As B4XPageInfo In IdToB4XPage.Values";
{
final anywheresoftware.b4a.BA.IterableList group1 = __ref._idtob4xpage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._getvalues /*anywheresoftware.b4a.objects.collections.List*/ (null);
final int groupLen1 = group1.getSize()
;int index1 = 0;
;
for (; index1 < groupLen1;index1++){
_pi = (b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo)(group1.Get(index1));
RDebugUtils.currentLine=6029314;
 //BA.debugLineNum = 6029314;BA.debugLine="If pi.B4XPage = Page Then";
if ((_pi.B4XPage /*Object*/ ).equals(_page)) { 
RDebugUtils.currentLine=6029315;
 //BA.debugLineNum = 6029315;BA.debugLine="Return pi";
if (true) return _pi;
 };
 }
};
RDebugUtils.currentLine=6029318;
 //BA.debugLineNum = 6029318;BA.debugLine="Return Null";
if (true) return (b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo)(__c.Null);
RDebugUtils.currentLine=6029319;
 //BA.debugLineNum = 6029319;BA.debugLine="End Sub";
return null;
}
public Object  _getpage(b4j.HTMLEditorFix.b4xpagesmanager __ref,String _id) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "getpage", true))
	 {return ((Object) Debug.delegate(ba, "getpage", new Object[] {_id}));}
RDebugUtils.currentLine=6422528;
 //BA.debugLineNum = 6422528;BA.debugLine="Public Sub GetPage (Id As String) As Object";
RDebugUtils.currentLine=6422529;
 //BA.debugLineNum = 6422529;BA.debugLine="Return GetPageFromId(Id).B4XPage";
if (true) return __ref._getpagefromid /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null,_id).B4XPage /*Object*/ ;
RDebugUtils.currentLine=6422530;
 //BA.debugLineNum = 6422530;BA.debugLine="End Sub";
return null;
}
public String  _settitle(b4j.HTMLEditorFix.b4xpagesmanager __ref,Object _b4xpage,Object _title) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "settitle", true))
	 {return ((String) Debug.delegate(ba, "settitle", new Object[] {_b4xpage,_title}));}
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi = null;
RDebugUtils.currentLine=6291456;
 //BA.debugLineNum = 6291456;BA.debugLine="Public Sub SetTitle (B4XPage As Object, Title As O";
RDebugUtils.currentLine=6291457;
 //BA.debugLineNum = 6291457;BA.debugLine="Dim pi As B4XPageInfo = FindPIFromB4XPage(B4XPage";
_pi = __ref._findpifromb4xpage /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null,_b4xpage);
RDebugUtils.currentLine=6291458;
 //BA.debugLineNum = 6291458;BA.debugLine="pi.Title = Title";
_pi.Title /*Object*/  = _title;
RDebugUtils.currentLine=6291459;
 //BA.debugLineNum = 6291459;BA.debugLine="pi.Parent.NativeType.Title = Title";
_pi.Parent /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent*/ .NativeType /*anywheresoftware.b4j.objects.Form*/ .setTitle(BA.ObjectToString(_title));
RDebugUtils.currentLine=6291460;
 //BA.debugLineNum = 6291460;BA.debugLine="End Sub";
return "";
}
public String  _showpage(b4j.HTMLEditorFix.b4xpagesmanager __ref,String _id) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "showpage", true))
	 {return ((String) Debug.delegate(ba, "showpage", new Object[] {_id}));}
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi = null;
RDebugUtils.currentLine=5701632;
 //BA.debugLineNum = 5701632;BA.debugLine="Public Sub ShowPage (Id As String)";
RDebugUtils.currentLine=5701633;
 //BA.debugLineNum = 5701633;BA.debugLine="Dim pi As B4XPageInfo = GetPageFromId(Id)";
_pi = __ref._getpagefromid /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null,_id);
RDebugUtils.currentLine=5701634;
 //BA.debugLineNum = 5701634;BA.debugLine="If pi = GetTopPage Then Return";
if ((_pi).equals(__ref._gettoppage /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null))) { 
if (true) return "";};
RDebugUtils.currentLine=5701635;
 //BA.debugLineNum = 5701635;BA.debugLine="CreatePageIfNeeded(pi)";
__ref._createpageifneeded /*String*/ (null,_pi);
RDebugUtils.currentLine=5701636;
 //BA.debugLineNum = 5701636;BA.debugLine="TopPageDisappear";
__ref._toppagedisappear /*String*/ (null);
RDebugUtils.currentLine=5701650;
 //BA.debugLineNum = 5701650;BA.debugLine="mStackOfPageIds.Remove(pi.Id)";
__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._remove /*String*/ (null,(Object)(_pi.Id /*String*/ ));
RDebugUtils.currentLine=5701651;
 //BA.debugLineNum = 5701651;BA.debugLine="ShowPageImpl(pi)";
__ref._showpageimpl /*String*/ (null,_pi);
RDebugUtils.currentLine=5701652;
 //BA.debugLineNum = 5701652;BA.debugLine="mStackOfPageIds.Add(pi.Id)";
__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._add /*String*/ (null,(Object)(_pi.Id /*String*/ ));
RDebugUtils.currentLine=5701653;
 //BA.debugLineNum = 5701653;BA.debugLine="TopPageAppear";
__ref._toppageappear /*String*/ (null);
RDebugUtils.currentLine=5701654;
 //BA.debugLineNum = 5701654;BA.debugLine="End Sub";
return "";
}
public String  _showpageandremovepreviouspages(b4j.HTMLEditorFix.b4xpagesmanager __ref,String _id) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "showpageandremovepreviouspages", true))
	 {return ((String) Debug.delegate(ba, "showpageandremovepreviouspages", new Object[] {_id}));}
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi = null;
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pagetoremove = null;
RDebugUtils.currentLine=5767168;
 //BA.debugLineNum = 5767168;BA.debugLine="Public Sub ShowPageAndRemovePreviousPages (Id As S";
RDebugUtils.currentLine=5767169;
 //BA.debugLineNum = 5767169;BA.debugLine="If GetTopPage = Null Then";
if (__ref._gettoppage /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null)== null) { 
RDebugUtils.currentLine=5767170;
 //BA.debugLineNum = 5767170;BA.debugLine="ShowPage(Id)";
__ref._showpage /*String*/ (null,_id);
RDebugUtils.currentLine=5767171;
 //BA.debugLineNum = 5767171;BA.debugLine="Return";
if (true) return "";
 };
RDebugUtils.currentLine=5767173;
 //BA.debugLineNum = 5767173;BA.debugLine="Dim pi As B4XPageInfo = GetPageFromId(Id)";
_pi = __ref._getpagefromid /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null,_id);
RDebugUtils.currentLine=5767174;
 //BA.debugLineNum = 5767174;BA.debugLine="CreatePageIfNeeded(pi)";
__ref._createpageifneeded /*String*/ (null,_pi);
RDebugUtils.currentLine=5767175;
 //BA.debugLineNum = 5767175;BA.debugLine="TopPageDisappear";
__ref._toppagedisappear /*String*/ (null);
RDebugUtils.currentLine=5767179;
 //BA.debugLineNum = 5767179;BA.debugLine="For Each Id As String In mStackOfPageIds.AsList";
{
final anywheresoftware.b4a.BA.IterableList group8 = __ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._aslist /*anywheresoftware.b4a.objects.collections.List*/ (null);
final int groupLen8 = group8.getSize()
;int index8 = 0;
;
for (; index8 < groupLen8;index8++){
_id = BA.ObjectToString(group8.Get(index8));
RDebugUtils.currentLine=5767180;
 //BA.debugLineNum = 5767180;BA.debugLine="Dim PageToRemove As B4XPageInfo = GetPageFromId(";
_pagetoremove = __ref._getpagefromid /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null,_id);
RDebugUtils.currentLine=5767184;
 //BA.debugLineNum = 5767184;BA.debugLine="If PageToRemove.Id = pi.Id Then Continue";
if ((_pagetoremove.Id /*String*/ ).equals(_pi.Id /*String*/ )) { 
if (true) continue;};
RDebugUtils.currentLine=5767185;
 //BA.debugLineNum = 5767185;BA.debugLine="PageToRemove.Parent.NativeType.Close";
_pagetoremove.Parent /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent*/ .NativeType /*anywheresoftware.b4j.objects.Form*/ .Close();
 }
};
RDebugUtils.currentLine=5767189;
 //BA.debugLineNum = 5767189;BA.debugLine="mStackOfPageIds.Clear";
__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._clear /*String*/ (null);
RDebugUtils.currentLine=5767190;
 //BA.debugLineNum = 5767190;BA.debugLine="mStackOfPageIds.Add(pi.Id)";
__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._add /*String*/ (null,(Object)(_pi.Id /*String*/ ));
RDebugUtils.currentLine=5767191;
 //BA.debugLineNum = 5767191;BA.debugLine="If xui.IsB4A Or xui.IsB4J Then";
if (__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .getIsB4A() || __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .getIsB4J()) { 
RDebugUtils.currentLine=5767192;
 //BA.debugLineNum = 5767192;BA.debugLine="ShowPageImpl(pi)";
__ref._showpageimpl /*String*/ (null,_pi);
 };
RDebugUtils.currentLine=5767194;
 //BA.debugLineNum = 5767194;BA.debugLine="TopPageAppear";
__ref._toppageappear /*String*/ (null);
RDebugUtils.currentLine=5767195;
 //BA.debugLineNum = 5767195;BA.debugLine="End Sub";
return "";
}
public String  _activity_pause(b4j.HTMLEditorFix.b4xpagesmanager __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
RDebugUtils.currentLine=7602176;
 //BA.debugLineNum = 7602176;BA.debugLine="Public Sub Activity_Pause";
RDebugUtils.currentLine=7602177;
 //BA.debugLineNum = 7602177;BA.debugLine="RaiseEventWithResult(GetTopPage, \"B4XPage_Disappe";
__ref._raiseeventwithresult /*Object*/ (null,__ref._gettoppage /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null),"B4XPage_Disappear",(Object[])(__c.Null));
RDebugUtils.currentLine=7602178;
 //BA.debugLineNum = 7602178;BA.debugLine="BackgroundStateChanged(False)";
__ref._backgroundstatechanged /*String*/ (null,__c.False);
RDebugUtils.currentLine=7602179;
 //BA.debugLineNum = 7602179;BA.debugLine="End Sub";
return "";
}
public String  _activity_resume(b4j.HTMLEditorFix.b4xpagesmanager __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "activity_resume", true))
	 {return ((String) Debug.delegate(ba, "activity_resume", null));}
boolean _shouldraise = false;
RDebugUtils.currentLine=7471104;
 //BA.debugLineNum = 7471104;BA.debugLine="Public Sub Activity_Resume";
RDebugUtils.currentLine=7471105;
 //BA.debugLineNum = 7471105;BA.debugLine="Dim ShouldRaise As Boolean = IsForeground = False";
_shouldraise = __ref._isforeground /*boolean*/ ==__c.False;
RDebugUtils.currentLine=7471106;
 //BA.debugLineNum = 7471106;BA.debugLine="BackgroundStateChanged(True)";
__ref._backgroundstatechanged /*String*/ (null,__c.True);
RDebugUtils.currentLine=7471107;
 //BA.debugLineNum = 7471107;BA.debugLine="If ShouldRaise Then";
if (_shouldraise) { 
RDebugUtils.currentLine=7471108;
 //BA.debugLineNum = 7471108;BA.debugLine="RaiseEvent(GetTopPage, \"B4XPage_Appear\", Null)";
__ref._raiseevent /*String*/ (null,__ref._gettoppage /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null),"B4XPage_Appear",(Object[])(__c.Null));
 };
RDebugUtils.currentLine=7471110;
 //BA.debugLineNum = 7471110;BA.debugLine="End Sub";
return "";
}
public String  _mainform_closed(b4j.HTMLEditorFix.b4xpagesmanager __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "mainform_closed", true))
	 {return ((String) Debug.delegate(ba, "mainform_closed", null));}
anywheresoftware.b4j.objects.Form _frm = null;
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi = null;
RDebugUtils.currentLine=6815744;
 //BA.debugLineNum = 6815744;BA.debugLine="Public Sub MainForm_Closed";
RDebugUtils.currentLine=6815745;
 //BA.debugLineNum = 6815745;BA.debugLine="Dim frm As Form = Sender";
_frm = (anywheresoftware.b4j.objects.Form)(__c.Sender(ba));
RDebugUtils.currentLine=6815746;
 //BA.debugLineNum = 6815746;BA.debugLine="Dim pi As B4XPageInfo = GetPageInfoFromRoot(frm.R";
_pi = __ref._getpageinfofromroot /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null,(anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(_frm.getRootPane().getObject())));
RDebugUtils.currentLine=6815747;
 //BA.debugLineNum = 6815747;BA.debugLine="RaiseEventWithResult(pi, \"B4XPage_Disappear\", Nul";
__ref._raiseeventwithresult /*Object*/ (null,_pi,"B4XPage_Disappear",(Object[])(__c.Null));
RDebugUtils.currentLine=6815748;
 //BA.debugLineNum = 6815748;BA.debugLine="mStackOfPageIds.Remove(pi.Id)";
__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._remove /*String*/ (null,(Object)(_pi.Id /*String*/ ));
RDebugUtils.currentLine=6815749;
 //BA.debugLineNum = 6815749;BA.debugLine="If mStackOfPageIds.Size = 0 Then";
if (__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._getsize /*int*/ (null)==0) { 
RDebugUtils.currentLine=6815750;
 //BA.debugLineNum = 6815750;BA.debugLine="BackgroundStateChanged(False)";
__ref._backgroundstatechanged /*String*/ (null,__c.False);
 };
RDebugUtils.currentLine=6815752;
 //BA.debugLineNum = 6815752;BA.debugLine="UpdateStackString";
__ref._updatestackstring /*String*/ (null);
RDebugUtils.currentLine=6815753;
 //BA.debugLineNum = 6815753;BA.debugLine="End Sub";
return "";
}
public String  _mainform_closerequest(b4j.HTMLEditorFix.b4xpagesmanager __ref,anywheresoftware.b4j.objects.NodeWrapper.ConcreteEventWrapper _eventdata) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "mainform_closerequest", true))
	 {return ((String) Debug.delegate(ba, "mainform_closerequest", new Object[] {_eventdata}));}
anywheresoftware.b4j.objects.Form _frm = null;
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi = null;
RDebugUtils.currentLine=6946816;
 //BA.debugLineNum = 6946816;BA.debugLine="Public Sub MainForm_CloseRequest (EventData As Eve";
RDebugUtils.currentLine=6946817;
 //BA.debugLineNum = 6946817;BA.debugLine="Dim frm As Form = Sender";
_frm = (anywheresoftware.b4j.objects.Form)(__c.Sender(ba));
RDebugUtils.currentLine=6946818;
 //BA.debugLineNum = 6946818;BA.debugLine="Dim pi As B4XPageInfo = GetPageInfoFromRoot(frm.R";
_pi = __ref._getpageinfofromroot /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null,(anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(_frm.getRootPane().getObject())));
RDebugUtils.currentLine=6946819;
 //BA.debugLineNum = 6946819;BA.debugLine="If pi <> Null And CloseRequestExists (pi) Then";
if (_pi!= null && __ref._closerequestexists /*boolean*/ (null,_pi)) { 
RDebugUtils.currentLine=6946820;
 //BA.debugLineNum = 6946820;BA.debugLine="EventData.Consume";
_eventdata.Consume();
RDebugUtils.currentLine=6946821;
 //BA.debugLineNum = 6946821;BA.debugLine="HandleCloseRequest (pi)";
__ref._handlecloserequest /*void*/ (null,_pi);
 };
RDebugUtils.currentLine=6946823;
 //BA.debugLineNum = 6946823;BA.debugLine="End Sub";
return "";
}
public String  _mainform_focuschanged(b4j.HTMLEditorFix.b4xpagesmanager __ref,boolean _hasfocus) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "mainform_focuschanged", true))
	 {return ((String) Debug.delegate(ba, "mainform_focuschanged", new Object[] {_hasfocus}));}
anywheresoftware.b4j.objects.Form _frm = null;
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi = null;
RDebugUtils.currentLine=6750208;
 //BA.debugLineNum = 6750208;BA.debugLine="Public Sub MainForm_FocusChanged (HasFocus As Bool";
RDebugUtils.currentLine=6750209;
 //BA.debugLineNum = 6750209;BA.debugLine="Dim frm As Form = Sender";
_frm = (anywheresoftware.b4j.objects.Form)(__c.Sender(ba));
RDebugUtils.currentLine=6750210;
 //BA.debugLineNum = 6750210;BA.debugLine="Dim pi As B4XPageInfo = GetPageInfoFromRoot(frm.R";
_pi = __ref._getpageinfofromroot /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null,(anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(_frm.getRootPane().getObject())));
RDebugUtils.currentLine=6750211;
 //BA.debugLineNum = 6750211;BA.debugLine="If pi = Null Then Return";
if (_pi== null) { 
if (true) return "";};
RDebugUtils.currentLine=6750212;
 //BA.debugLineNum = 6750212;BA.debugLine="If HasFocus Then";
if (_hasfocus) { 
RDebugUtils.currentLine=6750213;
 //BA.debugLineNum = 6750213;BA.debugLine="MovePageToTop(pi)";
__ref._movepagetotop /*String*/ (null,_pi);
 };
RDebugUtils.currentLine=6750215;
 //BA.debugLineNum = 6750215;BA.debugLine="End Sub";
return "";
}
public String  _mainform_iconifiedchanged(b4j.HTMLEditorFix.b4xpagesmanager __ref,boolean _iconified) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "mainform_iconifiedchanged", true))
	 {return ((String) Debug.delegate(ba, "mainform_iconifiedchanged", new Object[] {_iconified}));}
anywheresoftware.b4j.objects.Form _frm = null;
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi = null;
RDebugUtils.currentLine=6881280;
 //BA.debugLineNum = 6881280;BA.debugLine="Public Sub MainForm_IconifiedChanged (Iconified As";
RDebugUtils.currentLine=6881281;
 //BA.debugLineNum = 6881281;BA.debugLine="Dim frm As Form = Sender";
_frm = (anywheresoftware.b4j.objects.Form)(__c.Sender(ba));
RDebugUtils.currentLine=6881282;
 //BA.debugLineNum = 6881282;BA.debugLine="Dim pi As B4XPageInfo = GetPageInfoFromRoot(frm.R";
_pi = __ref._getpageinfofromroot /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null,(anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(_frm.getRootPane().getObject())));
RDebugUtils.currentLine=6881283;
 //BA.debugLineNum = 6881283;BA.debugLine="RaiseEvent(pi, \"B4XPage_IconifiedChanged\", Array(";
__ref._raiseevent /*String*/ (null,_pi,"B4XPage_IconifiedChanged",new Object[]{(Object)(_iconified)});
RDebugUtils.currentLine=6881284;
 //BA.debugLineNum = 6881284;BA.debugLine="End Sub";
return "";
}
public String  _mainform_resize(b4j.HTMLEditorFix.b4xpagesmanager __ref,double _width,double _height) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "mainform_resize", true))
	 {return ((String) Debug.delegate(ba, "mainform_resize", new Object[] {_width,_height}));}
int _w = 0;
int _h = 0;
RDebugUtils.currentLine=7274496;
 //BA.debugLineNum = 7274496;BA.debugLine="Public Sub MainForm_Resize(Width As Double, Height";
RDebugUtils.currentLine=7274497;
 //BA.debugLineNum = 7274497;BA.debugLine="Dim w As Int = Width";
_w = (int) (_width);
RDebugUtils.currentLine=7274498;
 //BA.debugLineNum = 7274498;BA.debugLine="Dim h As Int = Height";
_h = (int) (_height);
RDebugUtils.currentLine=7274499;
 //BA.debugLineNum = 7274499;BA.debugLine="RaiseEvent(GetPageInfoFromRoot(Sender), \"B4XPage_";
__ref._raiseevent /*String*/ (null,__ref._getpageinfofromroot /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null,(anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(__c.Sender(ba)))),"B4XPage_Resize",new Object[]{(Object)(_w),(Object)(_h)});
RDebugUtils.currentLine=7274500;
 //BA.debugLineNum = 7274500;BA.debugLine="End Sub";
return "";
}
public Object  _raiseeventwithresult(b4j.HTMLEditorFix.b4xpagesmanager __ref,b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _targetpage,String _subname,Object[] _params) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "raiseeventwithresult", true))
	 {return ((Object) Debug.delegate(ba, "raiseeventwithresult", new Object[] {_targetpage,_subname,_params}));}
int _length = 0;
RDebugUtils.currentLine=7208960;
 //BA.debugLineNum = 7208960;BA.debugLine="Public Sub RaiseEventWithResult (TargetPage As B4X";
RDebugUtils.currentLine=7208961;
 //BA.debugLineNum = 7208961;BA.debugLine="If TargetPage = Null Then Return Null";
if (_targetpage== null) { 
if (true) return __c.Null;};
RDebugUtils.currentLine=7208962;
 //BA.debugLineNum = 7208962;BA.debugLine="Dim length As Int";
_length = 0;
RDebugUtils.currentLine=7208963;
 //BA.debugLineNum = 7208963;BA.debugLine="If Params = Null Then length = 0 Else length = Pa";
if (_params== null) { 
_length = (int) (0);}
else {
_length = _params.length;};
RDebugUtils.currentLine=7208964;
 //BA.debugLineNum = 7208964;BA.debugLine="LogEvent(TargetPage, SubName)";
__ref._logevent /*String*/ (null,_targetpage,_subname);
RDebugUtils.currentLine=7208965;
 //BA.debugLineNum = 7208965;BA.debugLine="If xui.SubExists(TargetPage.B4XPage, SubName, len";
if (__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .SubExists(ba,_targetpage.B4XPage /*Object*/ ,_subname,_length)==__c.False) { 
if (true) return __c.Null;};
RDebugUtils.currentLine=7208966;
 //BA.debugLineNum = 7208966;BA.debugLine="Select length";
switch (_length) {
case 0: {
RDebugUtils.currentLine=7208968;
 //BA.debugLineNum = 7208968;BA.debugLine="Return CallSub(TargetPage.B4XPage, SubName)";
if (true) return __c.CallSubNew(ba,_targetpage.B4XPage /*Object*/ ,_subname);
 break; }
case 1: {
RDebugUtils.currentLine=7208970;
 //BA.debugLineNum = 7208970;BA.debugLine="Return CallSub2(TargetPage.B4XPage, SubName, Pa";
if (true) return __c.CallSubNew2(ba,_targetpage.B4XPage /*Object*/ ,_subname,_params[(int) (0)]);
 break; }
case 2: {
RDebugUtils.currentLine=7208972;
 //BA.debugLineNum = 7208972;BA.debugLine="Return CallSub3(TargetPage.B4XPage, SubName, Pa";
if (true) return __c.CallSubNew3(ba,_targetpage.B4XPage /*Object*/ ,_subname,_params[(int) (0)],_params[(int) (1)]);
 break; }
default: {
RDebugUtils.currentLine=7208974;
 //BA.debugLineNum = 7208974;BA.debugLine="Log(\"Too many parameters\")";
__c.LogImpl("97208974","Too many parameters",0);
 break; }
}
;
RDebugUtils.currentLine=7208976;
 //BA.debugLineNum = 7208976;BA.debugLine="Return Null";
if (true) return __c.Null;
RDebugUtils.currentLine=7208977;
 //BA.debugLineNum = 7208977;BA.debugLine="End Sub";
return null;
}
public b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo  _gettoppage(b4j.HTMLEditorFix.b4xpagesmanager __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "gettoppage", true))
	 {return ((b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo) Debug.delegate(ba, "gettoppage", null));}
RDebugUtils.currentLine=7340032;
 //BA.debugLineNum = 7340032;BA.debugLine="Public Sub GetTopPage As B4XPageInfo";
RDebugUtils.currentLine=7340033;
 //BA.debugLineNum = 7340033;BA.debugLine="If mStackOfPageIds.Size = 0 Then Return Null";
if (__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._getsize /*int*/ (null)==0) { 
if (true) return (b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo)(__c.Null);};
RDebugUtils.currentLine=7340034;
 //BA.debugLineNum = 7340034;BA.debugLine="Return IdToB4XPage.Get(mStackOfPageIds.AsList.Get";
if (true) return (b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo)(__ref._idtob4xpage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._get /*Object*/ (null,__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._aslist /*anywheresoftware.b4a.objects.collections.List*/ (null).Get((int) (__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._getsize /*int*/ (null)-1))));
RDebugUtils.currentLine=7340035;
 //BA.debugLineNum = 7340035;BA.debugLine="End Sub";
return null;
}
public String  _backgroundstatechanged(b4j.HTMLEditorFix.b4xpagesmanager __ref,boolean _newstate) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "backgroundstatechanged", true))
	 {return ((String) Debug.delegate(ba, "backgroundstatechanged", new Object[] {_newstate}));}
String _ev = "";
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi = null;
RDebugUtils.currentLine=7536640;
 //BA.debugLineNum = 7536640;BA.debugLine="Private Sub BackgroundStateChanged (NewState As Bo";
RDebugUtils.currentLine=7536641;
 //BA.debugLineNum = 7536641;BA.debugLine="If IsForeground = NewState Then Return";
if (__ref._isforeground /*boolean*/ ==_newstate) { 
if (true) return "";};
RDebugUtils.currentLine=7536642;
 //BA.debugLineNum = 7536642;BA.debugLine="IsForeground = NewState";
__ref._isforeground /*boolean*/  = _newstate;
RDebugUtils.currentLine=7536643;
 //BA.debugLineNum = 7536643;BA.debugLine="Dim ev As String";
_ev = "";
RDebugUtils.currentLine=7536644;
 //BA.debugLineNum = 7536644;BA.debugLine="If IsForeground Then ev = \"B4XPage_Foreground\" El";
if (__ref._isforeground /*boolean*/ ) { 
_ev = "B4XPage_Foreground";}
else {
_ev = "B4XPage_Background";};
RDebugUtils.currentLine=7536645;
 //BA.debugLineNum = 7536645;BA.debugLine="For Each pi As B4XPageInfo In IdToB4XPage.Values";
{
final anywheresoftware.b4a.BA.IterableList group5 = __ref._idtob4xpage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._getvalues /*anywheresoftware.b4a.objects.collections.List*/ (null);
final int groupLen5 = group5.getSize()
;int index5 = 0;
;
for (; index5 < groupLen5;index5++){
_pi = (b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo)(group5.Get(index5));
RDebugUtils.currentLine=7536646;
 //BA.debugLineNum = 7536646;BA.debugLine="If xui.SubExists(pi.B4XPage, ev, 0) Then";
if (__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .SubExists(ba,_pi.B4XPage /*Object*/ ,_ev,(int) (0))) { 
RDebugUtils.currentLine=7536647;
 //BA.debugLineNum = 7536647;BA.debugLine="LogEvent(pi, ev)";
__ref._logevent /*String*/ (null,_pi,_ev);
RDebugUtils.currentLine=7536648;
 //BA.debugLineNum = 7536648;BA.debugLine="If IsForeground Then";
if (__ref._isforeground /*boolean*/ ) { 
RDebugUtils.currentLine=7536649;
 //BA.debugLineNum = 7536649;BA.debugLine="CallSubDelayed(pi.B4XPage, ev)";
__c.CallSubDelayed(ba,_pi.B4XPage /*Object*/ ,_ev);
 }else {
RDebugUtils.currentLine=7536651;
 //BA.debugLineNum = 7536651;BA.debugLine="CallSub(pi.B4XPage, ev)";
__c.CallSubNew(ba,_pi.B4XPage /*Object*/ ,_ev);
 };
 };
 }
};
RDebugUtils.currentLine=7536655;
 //BA.debugLineNum = 7536655;BA.debugLine="End Sub";
return "";
}
public String  _raiseevent(b4j.HTMLEditorFix.b4xpagesmanager __ref,b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _targetpage,String _subname,Object[] _params) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "raiseevent", true))
	 {return ((String) Debug.delegate(ba, "raiseevent", new Object[] {_targetpage,_subname,_params}));}
int _length = 0;
RDebugUtils.currentLine=7143424;
 //BA.debugLineNum = 7143424;BA.debugLine="Public Sub RaiseEvent (TargetPage As B4XPageInfo,";
RDebugUtils.currentLine=7143425;
 //BA.debugLineNum = 7143425;BA.debugLine="If TargetPage = Null Then Return";
if (_targetpage== null) { 
if (true) return "";};
RDebugUtils.currentLine=7143426;
 //BA.debugLineNum = 7143426;BA.debugLine="Dim length As Int";
_length = 0;
RDebugUtils.currentLine=7143427;
 //BA.debugLineNum = 7143427;BA.debugLine="If Params = Null Then length = 0 Else length = Pa";
if (_params== null) { 
_length = (int) (0);}
else {
_length = _params.length;};
RDebugUtils.currentLine=7143428;
 //BA.debugLineNum = 7143428;BA.debugLine="LogEvent(TargetPage, SubName)";
__ref._logevent /*String*/ (null,_targetpage,_subname);
RDebugUtils.currentLine=7143429;
 //BA.debugLineNum = 7143429;BA.debugLine="If xui.SubExists(TargetPage.B4XPage, SubName, len";
if (__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .SubExists(ba,_targetpage.B4XPage /*Object*/ ,_subname,_length)==__c.False) { 
if (true) return "";};
RDebugUtils.currentLine=7143430;
 //BA.debugLineNum = 7143430;BA.debugLine="Select length";
switch (_length) {
case 0: {
RDebugUtils.currentLine=7143432;
 //BA.debugLineNum = 7143432;BA.debugLine="CallSubDelayed(TargetPage.B4XPage, SubName)";
__c.CallSubDelayed(ba,_targetpage.B4XPage /*Object*/ ,_subname);
 break; }
case 1: {
RDebugUtils.currentLine=7143434;
 //BA.debugLineNum = 7143434;BA.debugLine="CallSubDelayed2(TargetPage.B4XPage, SubName, Pa";
__c.CallSubDelayed2(ba,_targetpage.B4XPage /*Object*/ ,_subname,_params[(int) (0)]);
 break; }
case 2: {
RDebugUtils.currentLine=7143436;
 //BA.debugLineNum = 7143436;BA.debugLine="CallSubDelayed3(TargetPage.B4XPage, SubName, Pa";
__c.CallSubDelayed3(ba,_targetpage.B4XPage /*Object*/ ,_subname,_params[(int) (0)],_params[(int) (1)]);
 break; }
default: {
RDebugUtils.currentLine=7143438;
 //BA.debugLineNum = 7143438;BA.debugLine="Log(\"Too many parameters\")";
__c.LogImpl("97143438","Too many parameters",0);
 break; }
}
;
RDebugUtils.currentLine=7143440;
 //BA.debugLineNum = 7143440;BA.debugLine="End Sub";
return "";
}
public b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo  _createb4xpageinfo(b4j.HTMLEditorFix.b4xpagesmanager __ref,Object _b4xpage,String _id,boolean _created,Object _title) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "createb4xpageinfo", true))
	 {return ((b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo) Debug.delegate(ba, "createb4xpageinfo", new Object[] {_b4xpage,_id,_created,_title}));}
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _t1 = null;
RDebugUtils.currentLine=6684672;
 //BA.debugLineNum = 6684672;BA.debugLine="Private Sub CreateB4XPageInfo (B4XPage As Object,";
RDebugUtils.currentLine=6684673;
 //BA.debugLineNum = 6684673;BA.debugLine="Dim t1 As B4XPageInfo";
_t1 = new b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo();
RDebugUtils.currentLine=6684674;
 //BA.debugLineNum = 6684674;BA.debugLine="t1.Initialize";
_t1.Initialize();
RDebugUtils.currentLine=6684675;
 //BA.debugLineNum = 6684675;BA.debugLine="t1.B4XPage = B4XPage";
_t1.B4XPage /*Object*/  = _b4xpage;
RDebugUtils.currentLine=6684676;
 //BA.debugLineNum = 6684676;BA.debugLine="t1.Id = Id";
_t1.Id /*String*/  = _id;
RDebugUtils.currentLine=6684677;
 //BA.debugLineNum = 6684677;BA.debugLine="t1.Created = Created";
_t1.Created /*boolean*/  = _created;
RDebugUtils.currentLine=6684678;
 //BA.debugLineNum = 6684678;BA.debugLine="t1.Title = Title";
_t1.Title /*Object*/  = _title;
RDebugUtils.currentLine=6684679;
 //BA.debugLineNum = 6684679;BA.debugLine="Return t1";
if (true) return _t1;
RDebugUtils.currentLine=6684680;
 //BA.debugLineNum = 6684680;BA.debugLine="End Sub";
return null;
}
public String  _createpageifneeded(b4j.HTMLEditorFix.b4xpagesmanager __ref,b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "createpageifneeded", true))
	 {return ((String) Debug.delegate(ba, "createpageifneeded", new Object[] {_pi}));}
RDebugUtils.currentLine=6225920;
 //BA.debugLineNum = 6225920;BA.debugLine="Private Sub CreatePageIfNeeded(pi As B4XPageInfo)";
RDebugUtils.currentLine=6225921;
 //BA.debugLineNum = 6225921;BA.debugLine="If pi.Created Then Return";
if (_pi.Created /*boolean*/ ) { 
if (true) return "";};
RDebugUtils.currentLine=6225922;
 //BA.debugLineNum = 6225922;BA.debugLine="pi.IsFirst = IdToB4XPage.Size = 1";
_pi.IsFirst /*boolean*/  = __ref._idtob4xpage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._getsize /*int*/ (null)==1;
RDebugUtils.currentLine=6225923;
 //BA.debugLineNum = 6225923;BA.debugLine="CreatePageImpl (pi)";
__ref._createpageimpl /*String*/ (null,_pi);
RDebugUtils.currentLine=6225924;
 //BA.debugLineNum = 6225924;BA.debugLine="pi.Created = True";
_pi.Created /*boolean*/  = __c.True;
RDebugUtils.currentLine=6225925;
 //BA.debugLineNum = 6225925;BA.debugLine="RootB4XToPage.Put(pi.Root, pi)";
__ref._rootb4xtopage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._put /*String*/ (null,(Object)(_pi.Root /*anywheresoftware.b4a.objects.B4XViewWrapper*/ .getObject()),(Object)(_pi));
RDebugUtils.currentLine=6225926;
 //BA.debugLineNum = 6225926;BA.debugLine="LogEvent(pi, \"B4XPage_Created\")";
__ref._logevent /*String*/ (null,_pi,"B4XPage_Created");
RDebugUtils.currentLine=6225927;
 //BA.debugLineNum = 6225927;BA.debugLine="CallSub2(pi.B4XPage, \"B4XPage_Created\", pi.root)";
__c.CallSubDebug2(ba,_pi.B4XPage /*Object*/ ,"B4XPage_Created",(Object)(_pi.Root /*anywheresoftware.b4a.objects.B4XViewWrapper*/ ));
RDebugUtils.currentLine=6225929;
 //BA.debugLineNum = 6225929;BA.debugLine="End Sub";
return "";
}
public b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo  _getpagefromid(b4j.HTMLEditorFix.b4xpagesmanager __ref,String _id) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "getpagefromid", true))
	 {return ((b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo) Debug.delegate(ba, "getpagefromid", new Object[] {_id}));}
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi = null;
RDebugUtils.currentLine=6488064;
 //BA.debugLineNum = 6488064;BA.debugLine="Private Sub GetPageFromId (id As String) As B4XPag";
RDebugUtils.currentLine=6488065;
 //BA.debugLineNum = 6488065;BA.debugLine="Dim pi As B4XPageInfo = IdToB4XPage.Get(id.ToLowe";
_pi = (b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo)(__ref._idtob4xpage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._get /*Object*/ (null,(Object)(_id.toLowerCase())));
RDebugUtils.currentLine=6488066;
 //BA.debugLineNum = 6488066;BA.debugLine="If pi = Null Then";
if (_pi== null) { 
RDebugUtils.currentLine=6488067;
 //BA.debugLineNum = 6488067;BA.debugLine="Log(\"Error: page id not found: \" & id)";
__c.LogImpl("96488067","Error: page id not found: "+_id,0);
RDebugUtils.currentLine=6488068;
 //BA.debugLineNum = 6488068;BA.debugLine="Log(\"Ids: \" & IdToB4XPage.Keys) 'ignore";
__c.LogImpl("96488068","Ids: "+BA.ObjectToString(__ref._idtob4xpage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._getkeys /*anywheresoftware.b4a.objects.collections.List*/ (null)),0);
 };
RDebugUtils.currentLine=6488070;
 //BA.debugLineNum = 6488070;BA.debugLine="Return pi";
if (true) return _pi;
RDebugUtils.currentLine=6488071;
 //BA.debugLineNum = 6488071;BA.debugLine="End Sub";
return null;
}
public String  _logevent(b4j.HTMLEditorFix.b4xpagesmanager __ref,b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi,String _ev) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "logevent", true))
	 {return ((String) Debug.delegate(ba, "logevent", new Object[] {_pi,_ev}));}
String _msg = "";
RDebugUtils.currentLine=7667712;
 //BA.debugLineNum = 7667712;BA.debugLine="Private Sub LogEvent (pi As B4XPageInfo, ev As Str";
RDebugUtils.currentLine=7667713;
 //BA.debugLineNum = 7667713;BA.debugLine="If LogEvents Then";
if (__ref._logevents /*boolean*/ ) { 
RDebugUtils.currentLine=7667714;
 //BA.debugLineNum = 7667714;BA.debugLine="Dim msg As String = $\"*** ${pi.Id}: ${ev} ${Stac";
_msg = ("*** "+__c.SmartStringFormatter("",(Object)(_pi.Id /*String*/ ))+": "+__c.SmartStringFormatter("",(Object)(_ev))+" "+__c.SmartStringFormatter("",(Object)(__ref._stackstring /*String*/ ))+"");
RDebugUtils.currentLine=7667715;
 //BA.debugLineNum = 7667715;BA.debugLine="Log(msg)";
__c.LogImpl("97667715",_msg,0);
 };
RDebugUtils.currentLine=7667717;
 //BA.debugLineNum = 7667717;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4j.HTMLEditorFix.b4xpagesmanager __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
RDebugUtils.currentLine=5439488;
 //BA.debugLineNum = 5439488;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=5439489;
 //BA.debugLineNum = 5439489;BA.debugLine="Private IdToB4XPage As B4XOrderedMap";
_idtob4xpage = new b4j.HTMLEditorFix.b4xorderedmap();
RDebugUtils.currentLine=5439490;
 //BA.debugLineNum = 5439490;BA.debugLine="Private RootB4XToPage As B4XOrderedMap";
_rootb4xtopage = new b4j.HTMLEditorFix.b4xorderedmap();
RDebugUtils.currentLine=5439496;
 //BA.debugLineNum = 5439496;BA.debugLine="Type B4XPageParent (NativeType As Form)";
;
RDebugUtils.currentLine=5439500;
 //BA.debugLineNum = 5439500;BA.debugLine="Type B4XPageInfo (B4XPage As Object, Id As String";
;
RDebugUtils.currentLine=5439504;
 //BA.debugLineNum = 5439504;BA.debugLine="Public mStackOfPageIds As B4XSet";
_mstackofpageids = new b4j.HTMLEditorFix.b4xset();
RDebugUtils.currentLine=5439505;
 //BA.debugLineNum = 5439505;BA.debugLine="Private xui As XUI 'ignore";
_xui = new anywheresoftware.b4a.objects.B4XViewWrapper.XUI();
RDebugUtils.currentLine=5439507;
 //BA.debugLineNum = 5439507;BA.debugLine="Private mMainForm As Form";
_mmainform = new anywheresoftware.b4j.objects.Form();
RDebugUtils.currentLine=5439515;
 //BA.debugLineNum = 5439515;BA.debugLine="Public IsForeground As Boolean";
_isforeground = false;
RDebugUtils.currentLine=5439516;
 //BA.debugLineNum = 5439516;BA.debugLine="Public TransitionAnimationDuration As Int = 100";
_transitionanimationduration = (int) (100);
RDebugUtils.currentLine=5439517;
 //BA.debugLineNum = 5439517;BA.debugLine="Public MainPage As B4XMainPage";
_mainpage = new b4j.HTMLEditorFix.b4xmainpage();
RDebugUtils.currentLine=5439518;
 //BA.debugLineNum = 5439518;BA.debugLine="Private StackString As String";
_stackstring = "";
RDebugUtils.currentLine=5439519;
 //BA.debugLineNum = 5439519;BA.debugLine="Public LogEvents As Boolean = False";
_logevents = __c.False;
RDebugUtils.currentLine=5439520;
 //BA.debugLineNum = 5439520;BA.debugLine="End Sub";
return "";
}
public String  _closepageimpl(b4j.HTMLEditorFix.b4xpagesmanager __ref,b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "closepageimpl", true))
	 {return ((String) Debug.delegate(ba, "closepageimpl", new Object[] {_pi}));}
RDebugUtils.currentLine=6094848;
 //BA.debugLineNum = 6094848;BA.debugLine="Private Sub ClosePageImpl (pi As B4XPageInfo) 'ign";
RDebugUtils.currentLine=6094860;
 //BA.debugLineNum = 6094860;BA.debugLine="pi.Parent.NativeType.Close";
_pi.Parent /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent*/ .NativeType /*anywheresoftware.b4j.objects.Form*/ .Close();
RDebugUtils.currentLine=6094864;
 //BA.debugLineNum = 6094864;BA.debugLine="End Sub";
return "";
}
public String  _toppagedisappear(b4j.HTMLEditorFix.b4xpagesmanager __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "toppagedisappear", true))
	 {return ((String) Debug.delegate(ba, "toppagedisappear", null));}
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi = null;
RDebugUtils.currentLine=5898240;
 //BA.debugLineNum = 5898240;BA.debugLine="Private Sub TopPageDisappear";
RDebugUtils.currentLine=5898241;
 //BA.debugLineNum = 5898241;BA.debugLine="If xui.IsB4J Then Return";
if (__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .getIsB4J()) { 
if (true) return "";};
RDebugUtils.currentLine=5898242;
 //BA.debugLineNum = 5898242;BA.debugLine="Dim pi As B4XPageInfo = GetTopPage";
_pi = __ref._gettoppage /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null);
RDebugUtils.currentLine=5898243;
 //BA.debugLineNum = 5898243;BA.debugLine="If pi = Null Then Return";
if (_pi== null) { 
if (true) return "";};
RDebugUtils.currentLine=5898244;
 //BA.debugLineNum = 5898244;BA.debugLine="If Not(xui.IsB4i) Then";
if (__c.Not(__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .getIsB4i())) { 
RDebugUtils.currentLine=5898245;
 //BA.debugLineNum = 5898245;BA.debugLine="If IsForeground Then";
if (__ref._isforeground /*boolean*/ ) { 
RDebugUtils.currentLine=5898246;
 //BA.debugLineNum = 5898246;BA.debugLine="RaiseEventWithResult(pi, \"B4XPage_Disappear\", N";
__ref._raiseeventwithresult /*Object*/ (null,_pi,"B4XPage_Disappear",(Object[])(__c.Null));
 };
 };
RDebugUtils.currentLine=5898249;
 //BA.debugLineNum = 5898249;BA.debugLine="End Sub";
return "";
}
public String  _showpageimpl(b4j.HTMLEditorFix.b4xpagesmanager __ref,b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "showpageimpl", true))
	 {return ((String) Debug.delegate(ba, "showpageimpl", new Object[] {_pi}));}
anywheresoftware.b4j.object.JavaObject _jo = null;
RDebugUtils.currentLine=6160384;
 //BA.debugLineNum = 6160384;BA.debugLine="Private Sub ShowPageImpl (pi As B4XPageInfo)";
RDebugUtils.currentLine=6160386;
 //BA.debugLineNum = 6160386;BA.debugLine="pi.Parent.NativeType.Show";
_pi.Parent /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent*/ .NativeType /*anywheresoftware.b4j.objects.Form*/ .Show();
RDebugUtils.currentLine=6160387;
 //BA.debugLineNum = 6160387;BA.debugLine="Dim jo As JavaObject = pi.Parent.NativeType";
_jo = new anywheresoftware.b4j.object.JavaObject();
_jo = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_pi.Parent /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent*/ .NativeType /*anywheresoftware.b4j.objects.Form*/ ));
RDebugUtils.currentLine=6160388;
 //BA.debugLineNum = 6160388;BA.debugLine="jo.GetFieldJO(\"stage\").RunMethod(\"requestFocus\",";
_jo.GetFieldJO("stage").RunMethod("requestFocus",(Object[])(__c.Null));
RDebugUtils.currentLine=6160401;
 //BA.debugLineNum = 6160401;BA.debugLine="End Sub";
return "";
}
public String  _toppageappear(b4j.HTMLEditorFix.b4xpagesmanager __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "toppageappear", true))
	 {return ((String) Debug.delegate(ba, "toppageappear", null));}
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi = null;
RDebugUtils.currentLine=5963776;
 //BA.debugLineNum = 5963776;BA.debugLine="Private Sub TopPageAppear";
RDebugUtils.currentLine=5963777;
 //BA.debugLineNum = 5963777;BA.debugLine="Dim pi As B4XPageInfo = GetTopPage";
_pi = __ref._gettoppage /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo*/ (null);
RDebugUtils.currentLine=5963778;
 //BA.debugLineNum = 5963778;BA.debugLine="If pi = Null Then Return";
if (_pi== null) { 
if (true) return "";};
RDebugUtils.currentLine=5963779;
 //BA.debugLineNum = 5963779;BA.debugLine="pi.Parent.NativeType.Title = pi.Title";
_pi.Parent /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent*/ .NativeType /*anywheresoftware.b4j.objects.Form*/ .setTitle(BA.ObjectToString(_pi.Title /*Object*/ ));
RDebugUtils.currentLine=5963780;
 //BA.debugLineNum = 5963780;BA.debugLine="If Not(xui.IsB4i) Then";
if (__c.Not(__ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .getIsB4i())) { 
RDebugUtils.currentLine=5963781;
 //BA.debugLineNum = 5963781;BA.debugLine="If IsForeground Then";
if (__ref._isforeground /*boolean*/ ) { 
RDebugUtils.currentLine=5963782;
 //BA.debugLineNum = 5963782;BA.debugLine="RaiseEvent(pi, \"B4XPage_Appear\", Null)";
__ref._raiseevent /*String*/ (null,_pi,"B4XPage_Appear",(Object[])(__c.Null));
 };
 };
RDebugUtils.currentLine=5963791;
 //BA.debugLineNum = 5963791;BA.debugLine="UpdateStackString";
__ref._updatestackstring /*String*/ (null);
RDebugUtils.currentLine=5963792;
 //BA.debugLineNum = 5963792;BA.debugLine="End Sub";
return "";
}
public boolean  _closerequestexists(b4j.HTMLEditorFix.b4xpagesmanager __ref,b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "closerequestexists", true))
	 {return ((Boolean) Debug.delegate(ba, "closerequestexists", new Object[] {_pi}));}
RDebugUtils.currentLine=7012352;
 //BA.debugLineNum = 7012352;BA.debugLine="Private Sub CloseRequestExists (pi As B4XPageInfo)";
RDebugUtils.currentLine=7012353;
 //BA.debugLineNum = 7012353;BA.debugLine="Return xui.SubExists(pi.B4XPage, \"B4XPage_CloseRe";
if (true) return __ref._xui /*anywheresoftware.b4a.objects.B4XViewWrapper.XUI*/ .SubExists(ba,_pi.B4XPage /*Object*/ ,"B4XPage_CloseRequest",(int) (0));
RDebugUtils.currentLine=7012354;
 //BA.debugLineNum = 7012354;BA.debugLine="End Sub";
return false;
}
public b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent  _createb4xpageparent(b4j.HTMLEditorFix.b4xpagesmanager __ref,anywheresoftware.b4j.objects.Form _nativetype) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "createb4xpageparent", true))
	 {return ((b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent) Debug.delegate(ba, "createb4xpageparent", new Object[] {_nativetype}));}
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent _t1 = null;
RDebugUtils.currentLine=7405568;
 //BA.debugLineNum = 7405568;BA.debugLine="Private Sub CreateB4XPageParent (NativeType As For";
RDebugUtils.currentLine=7405572;
 //BA.debugLineNum = 7405572;BA.debugLine="Dim t1 As B4XPageParent";
_t1 = new b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent();
RDebugUtils.currentLine=7405573;
 //BA.debugLineNum = 7405573;BA.debugLine="t1.Initialize";
_t1.Initialize();
RDebugUtils.currentLine=7405574;
 //BA.debugLineNum = 7405574;BA.debugLine="t1.NativeType = NativeType";
_t1.NativeType /*anywheresoftware.b4j.objects.Form*/  = _nativetype;
RDebugUtils.currentLine=7405575;
 //BA.debugLineNum = 7405575;BA.debugLine="Return t1";
if (true) return _t1;
RDebugUtils.currentLine=7405576;
 //BA.debugLineNum = 7405576;BA.debugLine="End Sub";
return null;
}
public String  _createpageimpl(b4j.HTMLEditorFix.b4xpagesmanager __ref,b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "createpageimpl", true))
	 {return ((String) Debug.delegate(ba, "createpageimpl", new Object[] {_pi}));}
anywheresoftware.b4j.objects.Form _f = null;
RDebugUtils.currentLine=6356992;
 //BA.debugLineNum = 6356992;BA.debugLine="Private Sub CreatePageImpl (pi As B4XPageInfo)";
RDebugUtils.currentLine=6356994;
 //BA.debugLineNum = 6356994;BA.debugLine="If pi.IsFirst Then";
if (_pi.IsFirst /*boolean*/ ) { 
RDebugUtils.currentLine=6356995;
 //BA.debugLineNum = 6356995;BA.debugLine="pi.Parent = CreateB4XPageParent(mMainForm)";
_pi.Parent /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent*/  = __ref._createb4xpageparent /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent*/ (null,__ref._mmainform /*anywheresoftware.b4j.objects.Form*/ );
 }else {
RDebugUtils.currentLine=6356997;
 //BA.debugLineNum = 6356997;BA.debugLine="Dim f As Form";
_f = new anywheresoftware.b4j.objects.Form();
RDebugUtils.currentLine=6356998;
 //BA.debugLineNum = 6356998;BA.debugLine="f.Initialize(\"MainForm\", mMainForm.RootPane.Widt";
_f.Initialize(ba,"MainForm",__ref._mmainform /*anywheresoftware.b4j.objects.Form*/ .getRootPane().getWidth(),__ref._mmainform /*anywheresoftware.b4j.objects.Form*/ .getRootPane().getHeight());
RDebugUtils.currentLine=6356999;
 //BA.debugLineNum = 6356999;BA.debugLine="pi.Parent = CreateB4XPageParent(f)";
_pi.Parent /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent*/  = __ref._createb4xpageparent /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent*/ (null,_f);
 };
RDebugUtils.currentLine=6357001;
 //BA.debugLineNum = 6357001;BA.debugLine="pi.Root = pi.Parent.NativeType.RootPane";
_pi.Root /*anywheresoftware.b4a.objects.B4XViewWrapper*/  = (anywheresoftware.b4a.objects.B4XViewWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.B4XViewWrapper(), (java.lang.Object)(_pi.Parent /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent*/ .NativeType /*anywheresoftware.b4j.objects.Form*/ .getRootPane().getObject()));
RDebugUtils.currentLine=6357002;
 //BA.debugLineNum = 6357002;BA.debugLine="pi.Parent.NativeType.Title = pi.Title";
_pi.Parent /*b4j.HTMLEditorFix.b4xpagesmanager._b4xpageparent*/ .NativeType /*anywheresoftware.b4j.objects.Form*/ .setTitle(BA.ObjectToString(_pi.Title /*Object*/ ));
RDebugUtils.currentLine=6357015;
 //BA.debugLineNum = 6357015;BA.debugLine="End Sub";
return "";
}
public b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo  _getpageinfofromroot(b4j.HTMLEditorFix.b4xpagesmanager __ref,anywheresoftware.b4a.objects.B4XViewWrapper _root) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "getpageinfofromroot", true))
	 {return ((b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo) Debug.delegate(ba, "getpageinfofromroot", new Object[] {_root}));}
RDebugUtils.currentLine=6553600;
 //BA.debugLineNum = 6553600;BA.debugLine="Public Sub GetPageInfoFromRoot (Root As B4XView) A";
RDebugUtils.currentLine=6553601;
 //BA.debugLineNum = 6553601;BA.debugLine="Return RootB4XToPage.Get(Root)";
if (true) return (b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo)(__ref._rootb4xtopage /*b4j.HTMLEditorFix.b4xorderedmap*/ ._get /*Object*/ (null,(Object)(_root.getObject())));
RDebugUtils.currentLine=6553602;
 //BA.debugLineNum = 6553602;BA.debugLine="End Sub";
return null;
}
public void  _handlecloserequest(b4j.HTMLEditorFix.b4xpagesmanager __ref,b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi) throws Exception{
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "handlecloserequest", true))
	 {Debug.delegate(ba, "handlecloserequest", new Object[] {_pi}); return;}
ResumableSub_HandleCloseRequest rsub = new ResumableSub_HandleCloseRequest(this,__ref,_pi);
rsub.resume(ba, null);
}
public static class ResumableSub_HandleCloseRequest extends BA.ResumableSub {
public ResumableSub_HandleCloseRequest(b4j.HTMLEditorFix.b4xpagesmanager parent,b4j.HTMLEditorFix.b4xpagesmanager __ref,b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi) {
this.parent = parent;
this.__ref = __ref;
this._pi = _pi;
this.__ref = parent;
}
b4j.HTMLEditorFix.b4xpagesmanager __ref;
b4j.HTMLEditorFix.b4xpagesmanager parent;
b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi;
anywheresoftware.b4a.keywords.Common.ResumableSubWrapper _rs = null;
boolean _shouldclose = false;

@Override
public void resume(BA ba, Object[] result) throws Exception{
RDebugUtils.currentModule="b4xpagesmanager";

    while (true) {
        switch (state) {
            case -1:
return;

case 0:
//C
this.state = 1;
RDebugUtils.currentLine=7077889;
 //BA.debugLineNum = 7077889;BA.debugLine="LogEvent(pi, \"B4XPage_CloseRequest\")";
__ref._logevent /*String*/ (null,_pi,"B4XPage_CloseRequest");
RDebugUtils.currentLine=7077890;
 //BA.debugLineNum = 7077890;BA.debugLine="Dim rs As ResumableSub = CallSub(pi.B4XPage, \"B4X";
_rs = new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper();
_rs = (anywheresoftware.b4a.keywords.Common.ResumableSubWrapper) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.keywords.Common.ResumableSubWrapper(), (anywheresoftware.b4a.BA.ResumableSub)(parent.__c.CallSubDebug(ba,_pi.B4XPage /*Object*/ ,"B4XPage_CloseRequest")));
RDebugUtils.currentLine=7077891;
 //BA.debugLineNum = 7077891;BA.debugLine="Wait For (rs) Complete (ShouldClose As Boolean)";
parent.__c.WaitFor("complete", ba, new anywheresoftware.b4a.shell.DebugResumableSub.DelegatableResumableSub(this, "b4xpagesmanager", "handlecloserequest"), _rs);
this.state = 5;
return;
case 5:
//C
this.state = 1;
_shouldclose = (boolean) result[1];
;
RDebugUtils.currentLine=7077892;
 //BA.debugLineNum = 7077892;BA.debugLine="If ShouldClose Then";
if (true) break;

case 1:
//if
this.state = 4;
if (_shouldclose) { 
this.state = 3;
}if (true) break;

case 3:
//C
this.state = 4;
RDebugUtils.currentLine=7077893;
 //BA.debugLineNum = 7077893;BA.debugLine="ClosePage(pi.B4XPage)";
__ref._closepage /*String*/ (null,_pi.B4XPage /*Object*/ );
 if (true) break;

case 4:
//C
this.state = -1;
;
RDebugUtils.currentLine=7077895;
 //BA.debugLineNum = 7077895;BA.debugLine="End Sub";
if (true) break;

            }
        }
    }
}
public String  _updatestackstring(b4j.HTMLEditorFix.b4xpagesmanager __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "updatestackstring", true))
	 {return ((String) Debug.delegate(ba, "updatestackstring", null));}
anywheresoftware.b4a.keywords.StringBuilderWrapper _sb = null;
String _id = "";
RDebugUtils.currentLine=7733248;
 //BA.debugLineNum = 7733248;BA.debugLine="Public Sub UpdateStackString";
RDebugUtils.currentLine=7733249;
 //BA.debugLineNum = 7733249;BA.debugLine="Dim sb As StringBuilder";
_sb = new anywheresoftware.b4a.keywords.StringBuilderWrapper();
RDebugUtils.currentLine=7733250;
 //BA.debugLineNum = 7733250;BA.debugLine="sb.Initialize";
_sb.Initialize();
RDebugUtils.currentLine=7733251;
 //BA.debugLineNum = 7733251;BA.debugLine="sb.Append(\"[\")";
_sb.Append("[");
RDebugUtils.currentLine=7733252;
 //BA.debugLineNum = 7733252;BA.debugLine="If mStackOfPageIds.Size > 0 Then";
if (__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._getsize /*int*/ (null)>0) { 
RDebugUtils.currentLine=7733253;
 //BA.debugLineNum = 7733253;BA.debugLine="For Each id As String In mStackOfPageIds.AsList";
{
final anywheresoftware.b4a.BA.IterableList group5 = __ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._aslist /*anywheresoftware.b4a.objects.collections.List*/ (null);
final int groupLen5 = group5.getSize()
;int index5 = 0;
;
for (; index5 < groupLen5;index5++){
_id = BA.ObjectToString(group5.Get(index5));
RDebugUtils.currentLine=7733254;
 //BA.debugLineNum = 7733254;BA.debugLine="sb.Append(id).Append(\", \")";
_sb.Append(_id).Append(", ");
 }
};
RDebugUtils.currentLine=7733256;
 //BA.debugLineNum = 7733256;BA.debugLine="sb.Remove(sb.Length - 2, sb.Length)";
_sb.Remove((int) (_sb.getLength()-2),_sb.getLength());
 };
RDebugUtils.currentLine=7733258;
 //BA.debugLineNum = 7733258;BA.debugLine="sb.Append(\"]\")";
_sb.Append("]");
RDebugUtils.currentLine=7733259;
 //BA.debugLineNum = 7733259;BA.debugLine="StackString = sb.ToString";
__ref._stackstring /*String*/  = _sb.ToString();
RDebugUtils.currentLine=7733260;
 //BA.debugLineNum = 7733260;BA.debugLine="End Sub";
return "";
}
public String  _movepagetotop(b4j.HTMLEditorFix.b4xpagesmanager __ref,b4j.HTMLEditorFix.b4xpagesmanager._b4xpageinfo _pi) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesmanager";
if (Debug.shouldDelegate(ba, "movepagetotop", true))
	 {return ((String) Debug.delegate(ba, "movepagetotop", new Object[] {_pi}));}
RDebugUtils.currentLine=6619136;
 //BA.debugLineNum = 6619136;BA.debugLine="Private Sub MovePageToTop (pi As B4XPageInfo)";
RDebugUtils.currentLine=6619137;
 //BA.debugLineNum = 6619137;BA.debugLine="mStackOfPageIds.Remove(pi.Id)";
__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._remove /*String*/ (null,(Object)(_pi.Id /*String*/ ));
RDebugUtils.currentLine=6619138;
 //BA.debugLineNum = 6619138;BA.debugLine="mStackOfPageIds.Add(pi.Id)";
__ref._mstackofpageids /*b4j.HTMLEditorFix.b4xset*/ ._add /*String*/ (null,(Object)(_pi.Id /*String*/ ));
RDebugUtils.currentLine=6619139;
 //BA.debugLineNum = 6619139;BA.debugLine="UpdateStackString";
__ref._updatestackstring /*String*/ (null);
RDebugUtils.currentLine=6619140;
 //BA.debugLineNum = 6619140;BA.debugLine="End Sub";
return "";
}
}