package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class modeldeletetask extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.modeldeletetask", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.modeldeletetask.class).invoke(this, new Object[] {null});
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
public b4j.example.main _main = null;
public String  _class_globals(b4j.example.modeldeletetask __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="modeldeletetask";
RDebugUtils.currentLine=1572864;
 //BA.debugLineNum = 1572864;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=1572866;
 //BA.debugLineNum = 1572866;BA.debugLine="End Sub";
return "";
}
public String  _handle(b4j.example.modeldeletetask __ref,anywheresoftware.b4j.object.JServlet.ServletRequestWrapper _req,anywheresoftware.b4j.object.JServlet.ServletResponseWrapper _resp) throws Exception{
__ref = this;
RDebugUtils.currentModule="modeldeletetask";
if (Debug.shouldDelegate(ba, "handle", false))
	 {return ((String) Debug.delegate(ba, "handle", new Object[] {_req,_resp}));}
String _method = "";
String _id = "";
RDebugUtils.currentLine=1703936;
 //BA.debugLineNum = 1703936;BA.debugLine="Sub Handle(req As ServletRequest, resp As ServletR";
RDebugUtils.currentLine=1703937;
 //BA.debugLineNum = 1703937;BA.debugLine="Dim Method As String = req.Method";
_method = _req.getMethod();
RDebugUtils.currentLine=1703938;
 //BA.debugLineNum = 1703938;BA.debugLine="Dim Id As String = req.GetParameter(\"id\")";
_id = _req.GetParameter("id");
RDebugUtils.currentLine=1703939;
 //BA.debugLineNum = 1703939;BA.debugLine="Log(\"Method: \"&Method)";
__c.LogImpl("61703939","Method: "+_method,0);
RDebugUtils.currentLine=1703940;
 //BA.debugLineNum = 1703940;BA.debugLine="Log(\"[ID Task] \"&Id)";
__c.LogImpl("61703940","[ID Task] "+_id,0);
RDebugUtils.currentLine=1703941;
 //BA.debugLineNum = 1703941;BA.debugLine="If Method == \"POST\" Then";
if ((_method).equals("POST")) { 
RDebugUtils.currentLine=1703942;
 //BA.debugLineNum = 1703942;BA.debugLine="Try";
try {RDebugUtils.currentLine=1703943;
 //BA.debugLineNum = 1703943;BA.debugLine="Main.OpenDB";
_main._opendb /*String*/ ();
RDebugUtils.currentLine=1703944;
 //BA.debugLineNum = 1703944;BA.debugLine="Main.db.ExecNonQuery2(\"DELETE FROM tasks WHERE";
_main._db /*anywheresoftware.b4j.objects.SQL*/ .ExecNonQuery2("DELETE FROM tasks WHERE id = ?",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(_id)}));
RDebugUtils.currentLine=1703945;
 //BA.debugLineNum = 1703945;BA.debugLine="Main.db.Close";
_main._db /*anywheresoftware.b4j.objects.SQL*/ .Close();
 } 
       catch (Exception e11) {
			ba.setLastException(e11);RDebugUtils.currentLine=1703947;
 //BA.debugLineNum = 1703947;BA.debugLine="Log(LastException)";
__c.LogImpl("61703947",BA.ObjectToString(__c.LastException(ba)),0);
 };
 };
RDebugUtils.currentLine=1703952;
 //BA.debugLineNum = 1703952;BA.debugLine="resp.Write(Main.GetListTask)";
_resp.Write(_main._getlisttask /*String*/ ());
RDebugUtils.currentLine=1703953;
 //BA.debugLineNum = 1703953;BA.debugLine="End Sub";
return "";
}
public String  _initialize(b4j.example.modeldeletetask __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="modeldeletetask";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=1638400;
 //BA.debugLineNum = 1638400;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=1638402;
 //BA.debugLineNum = 1638402;BA.debugLine="End Sub";
return "";
}
}