package b4j.HTMLEditorFix;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class b4xpagesdelegator extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.HTMLEditorFix", "b4j.HTMLEditorFix.b4xpagesdelegator", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.HTMLEditorFix.b4xpagesdelegator.class).invoke(this, new Object[] {null});
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
public b4j.HTMLEditorFix.main _main = null;
public b4j.HTMLEditorFix.b4xpages _b4xpages = null;
public b4j.HTMLEditorFix.b4xcollections _b4xcollections = null;
public String  _mainform_closed(b4j.HTMLEditorFix.b4xpagesdelegator __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesdelegator";
if (Debug.shouldDelegate(ba, "mainform_closed", true))
	 {return ((String) Debug.delegate(ba, "mainform_closed", null));}
RDebugUtils.currentLine=5046272;
 //BA.debugLineNum = 5046272;BA.debugLine="Public Sub MainForm_Closed";
RDebugUtils.currentLine=5046273;
 //BA.debugLineNum = 5046273;BA.debugLine="B4XPages.GetManager.MainForm_Closed";
_b4xpages._getmanager /*b4j.HTMLEditorFix.b4xpagesmanager*/ ()._mainform_closed /*String*/ (null);
RDebugUtils.currentLine=5046274;
 //BA.debugLineNum = 5046274;BA.debugLine="End Sub";
return "";
}
public String  _mainform_closerequest(b4j.HTMLEditorFix.b4xpagesdelegator __ref,anywheresoftware.b4j.objects.NodeWrapper.ConcreteEventWrapper _eventdata) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesdelegator";
if (Debug.shouldDelegate(ba, "mainform_closerequest", true))
	 {return ((String) Debug.delegate(ba, "mainform_closerequest", new Object[] {_eventdata}));}
RDebugUtils.currentLine=5111808;
 //BA.debugLineNum = 5111808;BA.debugLine="Public Sub MainForm_CloseRequest (EventData As Eve";
RDebugUtils.currentLine=5111809;
 //BA.debugLineNum = 5111809;BA.debugLine="B4XPages.GetManager.MainForm_CloseRequest (EventD";
_b4xpages._getmanager /*b4j.HTMLEditorFix.b4xpagesmanager*/ ()._mainform_closerequest /*String*/ (null,_eventdata);
RDebugUtils.currentLine=5111810;
 //BA.debugLineNum = 5111810;BA.debugLine="End Sub";
return "";
}
public String  _mainform_focuschanged(b4j.HTMLEditorFix.b4xpagesdelegator __ref,boolean _hasfocus) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesdelegator";
if (Debug.shouldDelegate(ba, "mainform_focuschanged", true))
	 {return ((String) Debug.delegate(ba, "mainform_focuschanged", new Object[] {_hasfocus}));}
RDebugUtils.currentLine=4980736;
 //BA.debugLineNum = 4980736;BA.debugLine="Public Sub MainForm_FocusChanged (HasFocus As Bool";
RDebugUtils.currentLine=4980737;
 //BA.debugLineNum = 4980737;BA.debugLine="B4XPages.GetManager.MainForm_FocusChanged (HasFoc";
_b4xpages._getmanager /*b4j.HTMLEditorFix.b4xpagesmanager*/ ()._mainform_focuschanged /*String*/ (null,_hasfocus);
RDebugUtils.currentLine=4980738;
 //BA.debugLineNum = 4980738;BA.debugLine="End Sub";
return "";
}
public String  _mainform_iconifiedchanged(b4j.HTMLEditorFix.b4xpagesdelegator __ref,boolean _iconified) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesdelegator";
if (Debug.shouldDelegate(ba, "mainform_iconifiedchanged", true))
	 {return ((String) Debug.delegate(ba, "mainform_iconifiedchanged", new Object[] {_iconified}));}
RDebugUtils.currentLine=5177344;
 //BA.debugLineNum = 5177344;BA.debugLine="Public Sub MainForm_IconifiedChanged (Iconified As";
RDebugUtils.currentLine=5177345;
 //BA.debugLineNum = 5177345;BA.debugLine="B4XPages.GetManager.MainForm_IconifiedChanged(Ico";
_b4xpages._getmanager /*b4j.HTMLEditorFix.b4xpagesmanager*/ ()._mainform_iconifiedchanged /*String*/ (null,_iconified);
RDebugUtils.currentLine=5177346;
 //BA.debugLineNum = 5177346;BA.debugLine="End Sub";
return "";
}
public String  _mainform_resize(b4j.HTMLEditorFix.b4xpagesdelegator __ref,double _width,double _height) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesdelegator";
if (Debug.shouldDelegate(ba, "mainform_resize", true))
	 {return ((String) Debug.delegate(ba, "mainform_resize", new Object[] {_width,_height}));}
RDebugUtils.currentLine=5242880;
 //BA.debugLineNum = 5242880;BA.debugLine="Public Sub MainForm_Resize(Width As Double, Height";
RDebugUtils.currentLine=5242881;
 //BA.debugLineNum = 5242881;BA.debugLine="B4XPages.GetManager.MainForm_Resize(Width, Height";
_b4xpages._getmanager /*b4j.HTMLEditorFix.b4xpagesmanager*/ ()._mainform_resize /*String*/ (null,_width,_height);
RDebugUtils.currentLine=5242882;
 //BA.debugLineNum = 5242882;BA.debugLine="End Sub";
return "";
}
public String  _initialize(b4j.HTMLEditorFix.b4xpagesdelegator __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="b4xpagesdelegator";
if (Debug.shouldDelegate(ba, "initialize", true))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=4915200;
 //BA.debugLineNum = 4915200;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=4915202;
 //BA.debugLineNum = 4915202;BA.debugLine="End Sub";
return "";
}
public String  _activity_pause(b4j.HTMLEditorFix.b4xpagesdelegator __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesdelegator";
RDebugUtils.currentLine=5373952;
 //BA.debugLineNum = 5373952;BA.debugLine="Public Sub Activity_Pause";
RDebugUtils.currentLine=5373953;
 //BA.debugLineNum = 5373953;BA.debugLine="B4XPages.GetManager.Activity_Pause";
_b4xpages._getmanager /*b4j.HTMLEditorFix.b4xpagesmanager*/ ()._activity_pause /*String*/ (null);
RDebugUtils.currentLine=5373954;
 //BA.debugLineNum = 5373954;BA.debugLine="End Sub";
return "";
}
public String  _activity_resume(b4j.HTMLEditorFix.b4xpagesdelegator __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesdelegator";
if (Debug.shouldDelegate(ba, "activity_resume", true))
	 {return ((String) Debug.delegate(ba, "activity_resume", null));}
RDebugUtils.currentLine=5308416;
 //BA.debugLineNum = 5308416;BA.debugLine="Public Sub Activity_Resume";
RDebugUtils.currentLine=5308417;
 //BA.debugLineNum = 5308417;BA.debugLine="B4XPages.GetManager.Activity_Resume";
_b4xpages._getmanager /*b4j.HTMLEditorFix.b4xpagesmanager*/ ()._activity_resume /*String*/ (null);
RDebugUtils.currentLine=5308418;
 //BA.debugLineNum = 5308418;BA.debugLine="End Sub";
return "";
}
public String  _class_globals(b4j.HTMLEditorFix.b4xpagesdelegator __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="b4xpagesdelegator";
RDebugUtils.currentLine=4849664;
 //BA.debugLineNum = 4849664;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=4849665;
 //BA.debugLineNum = 4849665;BA.debugLine="End Sub";
return "";
}
}