package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class modeladdtask extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.modeladdtask", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.modeladdtask.class).invoke(this, new Object[] {null});
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
public String  _class_globals(b4j.example.modeladdtask __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="modeladdtask";
RDebugUtils.currentLine=1376256;
 //BA.debugLineNum = 1376256;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=1376258;
 //BA.debugLineNum = 1376258;BA.debugLine="End Sub";
return "";
}
public String  _handle(b4j.example.modeladdtask __ref,anywheresoftware.b4j.object.JServlet.ServletRequestWrapper _req,anywheresoftware.b4j.object.JServlet.ServletResponseWrapper _resp) throws Exception{
__ref = this;
RDebugUtils.currentModule="modeladdtask";
if (Debug.shouldDelegate(ba, "handle", false))
	 {return ((String) Debug.delegate(ba, "handle", new Object[] {_req,_resp}));}
String _method = "";
String _task = "";
RDebugUtils.currentLine=1507328;
 //BA.debugLineNum = 1507328;BA.debugLine="Sub Handle(req As ServletRequest, resp As ServletR";
RDebugUtils.currentLine=1507329;
 //BA.debugLineNum = 1507329;BA.debugLine="Dim Method As String = req.Method";
_method = _req.getMethod();
RDebugUtils.currentLine=1507332;
 //BA.debugLineNum = 1507332;BA.debugLine="Dim Task As String = req.GetParameter(\"task\")";
_task = _req.GetParameter("task");
RDebugUtils.currentLine=1507333;
 //BA.debugLineNum = 1507333;BA.debugLine="Log(\"Method: \"&Method)";
__c.LogImpl("61507333","Method: "+_method,0);
RDebugUtils.currentLine=1507334;
 //BA.debugLineNum = 1507334;BA.debugLine="If Method == \"POST\" Then";
if ((_method).equals("POST")) { 
RDebugUtils.currentLine=1507335;
 //BA.debugLineNum = 1507335;BA.debugLine="Try";
try {RDebugUtils.currentLine=1507336;
 //BA.debugLineNum = 1507336;BA.debugLine="Main.OpenDB";
_main._opendb /*String*/ ();
RDebugUtils.currentLine=1507337;
 //BA.debugLineNum = 1507337;BA.debugLine="Main.db.ExecNonQuery2(\"INSERT INTO tasks (task)";
_main._db /*anywheresoftware.b4j.objects.SQL*/ .ExecNonQuery2("INSERT INTO tasks (task) VALUES (?)",anywheresoftware.b4a.keywords.Common.ArrayToList(new Object[]{(Object)(_task)}));
RDebugUtils.currentLine=1507338;
 //BA.debugLineNum = 1507338;BA.debugLine="Main.db.Close";
_main._db /*anywheresoftware.b4j.objects.SQL*/ .Close();
 } 
       catch (Exception e10) {
			ba.setLastException(e10);RDebugUtils.currentLine=1507340;
 //BA.debugLineNum = 1507340;BA.debugLine="Log(LastException)";
__c.LogImpl("61507340",BA.ObjectToString(__c.LastException(ba)),0);
 };
 };
RDebugUtils.currentLine=1507344;
 //BA.debugLineNum = 1507344;BA.debugLine="resp.Write(Main.GetListTask)";
_resp.Write(_main._getlisttask /*String*/ ());
RDebugUtils.currentLine=1507345;
 //BA.debugLineNum = 1507345;BA.debugLine="End Sub";
return "";
}
public String  _initialize(b4j.example.modeladdtask __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="modeladdtask";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=1441792;
 //BA.debugLineNum = 1441792;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=1441794;
 //BA.debugLineNum = 1441794;BA.debugLine="End Sub";
return "";
}
}