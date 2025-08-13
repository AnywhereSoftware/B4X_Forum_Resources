package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;

public class httputils2service extends Object{
public static httputils2service mostCurrent = new httputils2service();

public static BA ba;
static {
		ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.httputils2service", null);
		ba.loadHtSubs(httputils2service.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			
			ba.raiseEvent2(null, true, "SHELL", false);
			ba.raiseEvent2(null, true, "CREATE", true, "b4j.example.httputils2service", ba);
		}
	}
    public static Class<?> getObject() {
		return httputils2service.class;
	}

 
public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4h.okhttp.OkHttpClientWrapper _hc = null;
public static anywheresoftware.b4a.objects.collections.Map _taskidtojob = null;
public static String _tempfolder = "";
public static int _taskcounter = 0;
public static b4j.example.cssutils _cssutils = null;
public static b4j.example.main _main = null;
public static b4j.example.ccxt _ccxt = null;
public static b4j.example.calc _calc = null;
public static b4j.example.test_ui _test_ui = null;
public static String  _completejob(int _taskid,boolean _success,String _errormessage) throws Exception{
RDebugUtils.currentModule="httputils2service";
if (Debug.shouldDelegate(ba, "completejob", true))
	 {return ((String) Debug.delegate(ba, "completejob", new Object[] {_taskid,_success,_errormessage}));}
b4j.example.httpjob _job = null;
RDebugUtils.currentLine=5505024;
 //BA.debugLineNum = 5505024;BA.debugLine="Sub CompleteJob(TaskId As Int, success As Boolean,";
RDebugUtils.currentLine=5505028;
 //BA.debugLineNum = 5505028;BA.debugLine="Dim job As HttpJob = TaskIdToJob.Get(TaskId)";
_job = (b4j.example.httpjob)(_taskidtojob.Get((Object)(_taskid)));
RDebugUtils.currentLine=5505029;
 //BA.debugLineNum = 5505029;BA.debugLine="If job = Null Then";
if (_job== null) { 
RDebugUtils.currentLine=5505030;
 //BA.debugLineNum = 5505030;BA.debugLine="Log(\"HttpUtils2Service: job completed multiple t";
anywheresoftware.b4a.keywords.Common.LogImpl("95505030","HttpUtils2Service: job completed multiple times - "+BA.NumberToString(_taskid),0);
RDebugUtils.currentLine=5505031;
 //BA.debugLineNum = 5505031;BA.debugLine="Return";
if (true) return "";
 };
RDebugUtils.currentLine=5505033;
 //BA.debugLineNum = 5505033;BA.debugLine="TaskIdToJob.Remove(TaskId)";
_taskidtojob.Remove((Object)(_taskid));
RDebugUtils.currentLine=5505034;
 //BA.debugLineNum = 5505034;BA.debugLine="job.success = success";
_job._success /*boolean*/  = _success;
RDebugUtils.currentLine=5505035;
 //BA.debugLineNum = 5505035;BA.debugLine="job.errorMessage = errorMessage";
_job._errormessage /*String*/  = _errormessage;
RDebugUtils.currentLine=5505037;
 //BA.debugLineNum = 5505037;BA.debugLine="job.Complete(TaskId)";
_job._complete /*String*/ (null,_taskid);
RDebugUtils.currentLine=5505041;
 //BA.debugLineNum = 5505041;BA.debugLine="End Sub";
return "";
}
public static String  _hc_responseerror(anywheresoftware.b4h.okhttp.OkHttpClientWrapper.OkHttpResponse _response,String _reason,int _statuscode,int _taskid) throws Exception{
RDebugUtils.currentModule="httputils2service";
if (Debug.shouldDelegate(ba, "hc_responseerror", true))
	 {return ((String) Debug.delegate(ba, "hc_responseerror", new Object[] {_response,_reason,_statuscode,_taskid}));}
b4j.example.httpjob _job = null;
RDebugUtils.currentLine=5439488;
 //BA.debugLineNum = 5439488;BA.debugLine="Sub hc_ResponseError (Response As OkHttpResponse,";
RDebugUtils.currentLine=5439489;
 //BA.debugLineNum = 5439489;BA.debugLine="Log($\"ResponseError. Reason: ${Reason}, Response:";
anywheresoftware.b4a.keywords.Common.LogImpl("95439489",("ResponseError. Reason: "+anywheresoftware.b4a.keywords.Common.SmartStringFormatter("",(Object)(_reason))+", Response: "+anywheresoftware.b4a.keywords.Common.SmartStringFormatter("",(Object)(_response.getErrorResponse()))+""),0);
RDebugUtils.currentLine=5439490;
 //BA.debugLineNum = 5439490;BA.debugLine="Response.Release";
_response.Release();
RDebugUtils.currentLine=5439491;
 //BA.debugLineNum = 5439491;BA.debugLine="Dim job As HttpJob = TaskIdToJob.Get(TaskId)";
_job = (b4j.example.httpjob)(_taskidtojob.Get((Object)(_taskid)));
RDebugUtils.currentLine=5439492;
 //BA.debugLineNum = 5439492;BA.debugLine="If job = Null Then";
if (_job== null) { 
RDebugUtils.currentLine=5439493;
 //BA.debugLineNum = 5439493;BA.debugLine="Log(\"HttpUtils2Service (hc_ResponseError): job c";
anywheresoftware.b4a.keywords.Common.LogImpl("95439493","HttpUtils2Service (hc_ResponseError): job completed multiple times - "+BA.NumberToString(_taskid),0);
RDebugUtils.currentLine=5439494;
 //BA.debugLineNum = 5439494;BA.debugLine="Return";
if (true) return "";
 };
RDebugUtils.currentLine=5439496;
 //BA.debugLineNum = 5439496;BA.debugLine="job.Response = Response";
_job._response /*anywheresoftware.b4h.okhttp.OkHttpClientWrapper.OkHttpResponse*/  = _response;
RDebugUtils.currentLine=5439497;
 //BA.debugLineNum = 5439497;BA.debugLine="If Response.ErrorResponse <> \"\" Then";
if ((_response.getErrorResponse()).equals("") == false) { 
RDebugUtils.currentLine=5439498;
 //BA.debugLineNum = 5439498;BA.debugLine="CompleteJob(TaskId, False, Response.ErrorRespons";
_completejob(_taskid,anywheresoftware.b4a.keywords.Common.False,_response.getErrorResponse());
 }else {
RDebugUtils.currentLine=5439500;
 //BA.debugLineNum = 5439500;BA.debugLine="CompleteJob(TaskId, False, Reason)";
_completejob(_taskid,anywheresoftware.b4a.keywords.Common.False,_reason);
 };
RDebugUtils.currentLine=5439502;
 //BA.debugLineNum = 5439502;BA.debugLine="End Sub";
return "";
}
public static String  _hc_responsesuccess(anywheresoftware.b4h.okhttp.OkHttpClientWrapper.OkHttpResponse _response,int _taskid) throws Exception{
RDebugUtils.currentModule="httputils2service";
if (Debug.shouldDelegate(ba, "hc_responsesuccess", true))
	 {return ((String) Debug.delegate(ba, "hc_responsesuccess", new Object[] {_response,_taskid}));}
b4j.example.httpjob _job = null;
anywheresoftware.b4a.objects.streams.File.OutputStreamWrapper _out = null;
RDebugUtils.currentLine=5308416;
 //BA.debugLineNum = 5308416;BA.debugLine="Sub hc_ResponseSuccess (Response As OkHttpResponse";
RDebugUtils.currentLine=5308417;
 //BA.debugLineNum = 5308417;BA.debugLine="Dim job As HttpJob = TaskIdToJob.Get(TaskId)";
_job = (b4j.example.httpjob)(_taskidtojob.Get((Object)(_taskid)));
RDebugUtils.currentLine=5308418;
 //BA.debugLineNum = 5308418;BA.debugLine="If job = Null Then";
if (_job== null) { 
RDebugUtils.currentLine=5308419;
 //BA.debugLineNum = 5308419;BA.debugLine="Log(\"HttpUtils2Service (hc_ResponseSuccess): job";
anywheresoftware.b4a.keywords.Common.LogImpl("95308419","HttpUtils2Service (hc_ResponseSuccess): job completed multiple times - "+BA.NumberToString(_taskid),0);
RDebugUtils.currentLine=5308420;
 //BA.debugLineNum = 5308420;BA.debugLine="Return";
if (true) return "";
 };
RDebugUtils.currentLine=5308422;
 //BA.debugLineNum = 5308422;BA.debugLine="job.Response = Response";
_job._response /*anywheresoftware.b4h.okhttp.OkHttpClientWrapper.OkHttpResponse*/  = _response;
RDebugUtils.currentLine=5308423;
 //BA.debugLineNum = 5308423;BA.debugLine="Dim out As OutputStream = File.OpenOutput(TempFol";
_out = new anywheresoftware.b4a.objects.streams.File.OutputStreamWrapper();
_out = anywheresoftware.b4a.keywords.Common.File.OpenOutput(_tempfolder,BA.NumberToString(_taskid),anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=5308427;
 //BA.debugLineNum = 5308427;BA.debugLine="Response.GetAsynchronously(\"response\", out , _";
_response.GetAsynchronously(ba,"response",(java.io.OutputStream)(_out.getObject()),anywheresoftware.b4a.keywords.Common.True,_taskid);
RDebugUtils.currentLine=5308429;
 //BA.debugLineNum = 5308429;BA.debugLine="End Sub";
return "";
}
public static String  _response_streamfinish(boolean _success,int _taskid) throws Exception{
RDebugUtils.currentModule="httputils2service";
if (Debug.shouldDelegate(ba, "response_streamfinish", true))
	 {return ((String) Debug.delegate(ba, "response_streamfinish", new Object[] {_success,_taskid}));}
RDebugUtils.currentLine=5373952;
 //BA.debugLineNum = 5373952;BA.debugLine="Private Sub Response_StreamFinish (Success As Bool";
RDebugUtils.currentLine=5373953;
 //BA.debugLineNum = 5373953;BA.debugLine="If Success Then";
if (_success) { 
RDebugUtils.currentLine=5373954;
 //BA.debugLineNum = 5373954;BA.debugLine="CompleteJob(TaskId, Success, \"\")";
_completejob(_taskid,_success,"");
 }else {
RDebugUtils.currentLine=5373956;
 //BA.debugLineNum = 5373956;BA.debugLine="CompleteJob(TaskId, Success, LastException.Messa";
_completejob(_taskid,_success,anywheresoftware.b4a.keywords.Common.LastException(ba).getMessage());
 };
RDebugUtils.currentLine=5373958;
 //BA.debugLineNum = 5373958;BA.debugLine="End Sub";
return "";
}
public static String  _service_create() throws Exception{
RDebugUtils.currentModule="httputils2service";
if (Debug.shouldDelegate(ba, "service_create", true))
	 {return ((String) Debug.delegate(ba, "service_create", null));}
RDebugUtils.currentLine=5177344;
 //BA.debugLineNum = 5177344;BA.debugLine="Sub Service_Create";
RDebugUtils.currentLine=5177356;
 //BA.debugLineNum = 5177356;BA.debugLine="TempFolder = File.DirTemp";
_tempfolder = anywheresoftware.b4a.keywords.Common.File.getDirTemp();
RDebugUtils.currentLine=5177358;
 //BA.debugLineNum = 5177358;BA.debugLine="If hc.IsInitialized = False Then";
if (_hc.IsInitialized()==anywheresoftware.b4a.keywords.Common.False) { 
RDebugUtils.currentLine=5177363;
 //BA.debugLineNum = 5177363;BA.debugLine="hc.Initialize(\"hc\")";
_hc.Initialize("hc");
 };
RDebugUtils.currentLine=5177371;
 //BA.debugLineNum = 5177371;BA.debugLine="TaskIdToJob.Initialize";
_taskidtojob.Initialize();
RDebugUtils.currentLine=5177373;
 //BA.debugLineNum = 5177373;BA.debugLine="End Sub";
return "";
}
public static String  _submitjob(b4j.example.httpjob _job) throws Exception{
RDebugUtils.currentModule="httputils2service";
if (Debug.shouldDelegate(ba, "submitjob", true))
	 {return ((String) Debug.delegate(ba, "submitjob", new Object[] {_job}));}
int _taskid = 0;
RDebugUtils.currentLine=5242880;
 //BA.debugLineNum = 5242880;BA.debugLine="Public Sub SubmitJob(job As HttpJob)";
RDebugUtils.currentLine=5242881;
 //BA.debugLineNum = 5242881;BA.debugLine="If TaskIdToJob.IsInitialized = False Then Service";
if (_taskidtojob.IsInitialized()==anywheresoftware.b4a.keywords.Common.False) { 
_service_create();};
RDebugUtils.currentLine=5242885;
 //BA.debugLineNum = 5242885;BA.debugLine="taskCounter = taskCounter + 1";
_taskcounter = (int) (_taskcounter+1);
RDebugUtils.currentLine=5242886;
 //BA.debugLineNum = 5242886;BA.debugLine="Dim TaskId As Int = taskCounter";
_taskid = _taskcounter;
RDebugUtils.currentLine=5242888;
 //BA.debugLineNum = 5242888;BA.debugLine="TaskIdToJob.Put(TaskId, job)";
_taskidtojob.Put((Object)(_taskid),(Object)(_job));
RDebugUtils.currentLine=5242889;
 //BA.debugLineNum = 5242889;BA.debugLine="If job.Username <> \"\" And job.Password <> \"\" Then";
if ((_job._username /*String*/ ).equals("") == false && (_job._password /*String*/ ).equals("") == false) { 
RDebugUtils.currentLine=5242890;
 //BA.debugLineNum = 5242890;BA.debugLine="hc.ExecuteCredentials(job.GetRequest, TaskId, jo";
_hc.ExecuteCredentials(ba,_job._getrequest /*anywheresoftware.b4h.okhttp.OkHttpClientWrapper.OkHttpRequest*/ (null),_taskid,_job._username /*String*/ ,_job._password /*String*/ );
 }else {
RDebugUtils.currentLine=5242892;
 //BA.debugLineNum = 5242892;BA.debugLine="hc.Execute(job.GetRequest, TaskId)";
_hc.Execute(ba,_job._getrequest /*anywheresoftware.b4h.okhttp.OkHttpClientWrapper.OkHttpRequest*/ (null),_taskid);
 };
RDebugUtils.currentLine=5242894;
 //BA.debugLineNum = 5242894;BA.debugLine="End Sub";
return "";
}
}