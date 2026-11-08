package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class httpjob_subs_0 {


public static RemoteObject  _addscheme(RemoteObject __ref,RemoteObject _link) throws Exception{
try {
		Debug.PushSubsStack("AddScheme (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,43);
if (RapidSub.canDelegate("addscheme")) { return __ref.runUserSub(false, "httpjob","addscheme", __ref, _link);}
Debug.locals.put("Link", _link);
 BA.debugLineNum = 43;BA.debugLine="Private Sub AddScheme (Link As String) As String";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 44;BA.debugLine="If DefaultScheme = \"\" Or Link.Contains(\":\") Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",__ref.getField(true,"_defaultscheme" /*RemoteObject*/ ),BA.ObjectToString("")) || RemoteObject.solveBoolean(".",_link.runMethod(true,"contains",(Object)(RemoteObject.createImmutable(":"))))) { 
if (true) return _link;};
 BA.debugLineNum = 45;BA.debugLine="Return DefaultScheme & \"://\" & Link";
Debug.JustUpdateDeviceLine();
if (true) return RemoteObject.concat(__ref.getField(true,"_defaultscheme" /*RemoteObject*/ ),RemoteObject.createImmutable("://"),_link);
 BA.debugLineNum = 46;BA.debugLine="End Sub";
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
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 3;BA.debugLine="Public JobName As String";
httpjob._jobname = RemoteObject.createImmutable("");__ref.setField("_jobname",httpjob._jobname);
 //BA.debugLineNum = 4;BA.debugLine="Public Success As Boolean";
httpjob._success = RemoteObject.createImmutable(false);__ref.setField("_success",httpjob._success);
 //BA.debugLineNum = 5;BA.debugLine="Public Username, Password As String";
httpjob._username = RemoteObject.createImmutable("");__ref.setField("_username",httpjob._username);
httpjob._password = RemoteObject.createImmutable("");__ref.setField("_password",httpjob._password);
 //BA.debugLineNum = 6;BA.debugLine="Public ErrorMessage As String";
httpjob._errormessage = RemoteObject.createImmutable("");__ref.setField("_errormessage",httpjob._errormessage);
 //BA.debugLineNum = 7;BA.debugLine="Private target As Object";
httpjob._target = RemoteObject.createNew ("Object");__ref.setField("_target",httpjob._target);
 //BA.debugLineNum = 13;BA.debugLine="Private taskId As String";
httpjob._taskid = RemoteObject.createImmutable("");__ref.setField("_taskid",httpjob._taskid);
 //BA.debugLineNum = 15;BA.debugLine="Private req As OkHttpRequest";
httpjob._req = RemoteObject.createNew ("anywheresoftware.b4h.okhttp.OkHttpClientWrapper.OkHttpRequest");__ref.setField("_req",httpjob._req);
 //BA.debugLineNum = 16;BA.debugLine="Public Response As OkHttpResponse";
httpjob._response = RemoteObject.createNew ("anywheresoftware.b4h.okhttp.OkHttpClientWrapper.OkHttpResponse");__ref.setField("_response",httpjob._response);
 //BA.debugLineNum = 25;BA.debugLine="Public Tag As Object";
httpjob._tag = RemoteObject.createNew ("Object");__ref.setField("_tag",httpjob._tag);
 //BA.debugLineNum = 26;BA.debugLine="Type MultipartFileData (Dir As String, FileName A";
;
 //BA.debugLineNum = 28;BA.debugLine="Private fx As JFX";
httpjob._fx = RemoteObject.createNew ("anywheresoftware.b4j.objects.JFX");__ref.setField("_fx",httpjob._fx);
 //BA.debugLineNum = 30;BA.debugLine="Private Const InvalidURL As String = \"https://inv";
httpjob._invalidurl = BA.ObjectToString("https://invalid-url/");__ref.setField("_invalidurl",httpjob._invalidurl);
 //BA.debugLineNum = 31;BA.debugLine="Public DefaultScheme As String = \"https\"";
httpjob._defaultscheme = BA.ObjectToString("https");__ref.setField("_defaultscheme",httpjob._defaultscheme);
 //BA.debugLineNum = 32;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _complete(RemoteObject __ref,RemoteObject _id) throws Exception{
try {
		Debug.PushSubsStack("Complete (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,306);
if (RapidSub.canDelegate("complete")) { return __ref.runUserSub(false, "httpjob","complete", __ref, _id);}
Debug.locals.put("id", _id);
 BA.debugLineNum = 306;BA.debugLine="Public Sub Complete (id As Int)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 307;BA.debugLine="taskId = id";
Debug.JustUpdateDeviceLine();
__ref.setField ("_taskid" /*RemoteObject*/ ,BA.NumberToString(_id));
 BA.debugLineNum = 308;BA.debugLine="CallSubDelayed2(target, \"JobDone\", Me)";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)(__ref.getField(false,"_target" /*RemoteObject*/ )),(Object)(BA.ObjectToString("JobDone")),(Object)(__ref));
 BA.debugLineNum = 309;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _delete(RemoteObject __ref,RemoteObject _link) throws Exception{
try {
		Debug.PushSubsStack("Delete (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,252);
if (RapidSub.canDelegate("delete")) { return __ref.runUserSub(false, "httpjob","delete", __ref, _link);}
Debug.locals.put("Link", _link);
 BA.debugLineNum = 252;BA.debugLine="Public Sub Delete(Link As String)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 253;BA.debugLine="Try";
Debug.JustUpdateDeviceLine();
try { BA.debugLineNum = 254;BA.debugLine="Link = AddScheme(Link)";
Debug.JustUpdateDeviceLine();
_link = __ref.runClassMethod (b4j.example.httpjob.class, "_addscheme" /*RemoteObject*/ ,(Object)(_link));Debug.locals.put("Link", _link);
 BA.debugLineNum = 255;BA.debugLine="req.InitializeDelete(Link)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializeDelete",(Object)(_link));
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e5) {
			BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e5.toString()); BA.debugLineNum = 257;BA.debugLine="Log($\"Invalid link: ${Link}\"$)";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("LogImpl","96619141",(RemoteObject.concat(RemoteObject.createImmutable("Invalid link: "),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_link))),RemoteObject.createImmutable(""))),0);
 BA.debugLineNum = 258;BA.debugLine="req.InitializeDelete(InvalidURL)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializeDelete",(Object)(__ref.getField(true,"_invalidurl" /*RemoteObject*/ )));
 };
 BA.debugLineNum = 260;BA.debugLine="CallSubDelayed2(HttpUtils2Service, \"SubmitJob\", M";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)((httpjob._httputils2service.getObject())),(Object)(BA.ObjectToString("SubmitJob")),(Object)(__ref));
 BA.debugLineNum = 261;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _delete2(RemoteObject __ref,RemoteObject _link,RemoteObject _parameters) throws Exception{
try {
		Debug.PushSubsStack("Delete2 (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,263);
if (RapidSub.canDelegate("delete2")) { return __ref.runUserSub(false, "httpjob","delete2", __ref, _link, _parameters);}
Debug.locals.put("Link", _link);
Debug.locals.put("Parameters", _parameters);
 BA.debugLineNum = 263;BA.debugLine="Public Sub Delete2(Link As String, Parameters() As";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 264;BA.debugLine="Try";
Debug.JustUpdateDeviceLine();
try { BA.debugLineNum = 265;BA.debugLine="Link = AddScheme(Link)";
Debug.JustUpdateDeviceLine();
_link = __ref.runClassMethod (b4j.example.httpjob.class, "_addscheme" /*RemoteObject*/ ,(Object)(_link));Debug.locals.put("Link", _link);
 BA.debugLineNum = 266;BA.debugLine="req.InitializeDelete(escapeLink(Link, Parameters";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializeDelete",(Object)(__ref.runClassMethod (b4j.example.httpjob.class, "_escapelink" /*RemoteObject*/ ,(Object)(_link),(Object)(_parameters))));
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e5) {
			BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e5.toString()); BA.debugLineNum = 268;BA.debugLine="Log($\"Invalid link: ${Link}\"$)";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("LogImpl","96684677",(RemoteObject.concat(RemoteObject.createImmutable("Invalid link: "),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_link))),RemoteObject.createImmutable(""))),0);
 BA.debugLineNum = 269;BA.debugLine="req.InitializeDelete(escapeLink(InvalidURL, Para";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializeDelete",(Object)(__ref.runClassMethod (b4j.example.httpjob.class, "_escapelink" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_invalidurl" /*RemoteObject*/ )),(Object)(_parameters))));
 };
 BA.debugLineNum = 271;BA.debugLine="CallSubDelayed2(HttpUtils2Service, \"SubmitJob\", M";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)((httpjob._httputils2service.getObject())),(Object)(BA.ObjectToString("SubmitJob")),(Object)(__ref));
 BA.debugLineNum = 272;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _download(RemoteObject __ref,RemoteObject _link) throws Exception{
try {
		Debug.PushSubsStack("Download (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,210);
if (RapidSub.canDelegate("download")) { return __ref.runUserSub(false, "httpjob","download", __ref, _link);}
Debug.locals.put("Link", _link);
 BA.debugLineNum = 210;BA.debugLine="Public Sub Download(Link As String)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 211;BA.debugLine="Try";
Debug.JustUpdateDeviceLine();
try { BA.debugLineNum = 212;BA.debugLine="Link = AddScheme(Link)";
Debug.JustUpdateDeviceLine();
_link = __ref.runClassMethod (b4j.example.httpjob.class, "_addscheme" /*RemoteObject*/ ,(Object)(_link));Debug.locals.put("Link", _link);
 BA.debugLineNum = 213;BA.debugLine="req.InitializeGet(Link)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializeGet",(Object)(_link));
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e5) {
			BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e5.toString()); BA.debugLineNum = 215;BA.debugLine="Log($\"Invalid link: ${Link}\"$)";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("LogImpl","96422533",(RemoteObject.concat(RemoteObject.createImmutable("Invalid link: "),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_link))),RemoteObject.createImmutable(""))),0);
 BA.debugLineNum = 216;BA.debugLine="req.InitializeGet(InvalidURL)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializeGet",(Object)(__ref.getField(true,"_invalidurl" /*RemoteObject*/ )));
 };
 BA.debugLineNum = 218;BA.debugLine="CallSubDelayed2(HttpUtils2Service, \"SubmitJob\", M";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)((httpjob._httputils2service.getObject())),(Object)(BA.ObjectToString("SubmitJob")),(Object)(__ref));
 BA.debugLineNum = 219;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _download2(RemoteObject __ref,RemoteObject _link,RemoteObject _parameters) throws Exception{
try {
		Debug.PushSubsStack("Download2 (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,226);
if (RapidSub.canDelegate("download2")) { return __ref.runUserSub(false, "httpjob","download2", __ref, _link, _parameters);}
Debug.locals.put("Link", _link);
Debug.locals.put("Parameters", _parameters);
 BA.debugLineNum = 226;BA.debugLine="Public Sub Download2(Link As String, Parameters()";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 227;BA.debugLine="Try";
Debug.JustUpdateDeviceLine();
try { BA.debugLineNum = 228;BA.debugLine="Link = AddScheme(Link)";
Debug.JustUpdateDeviceLine();
_link = __ref.runClassMethod (b4j.example.httpjob.class, "_addscheme" /*RemoteObject*/ ,(Object)(_link));Debug.locals.put("Link", _link);
 BA.debugLineNum = 229;BA.debugLine="req.InitializeGet(escapeLink(Link, Parameters))";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializeGet",(Object)(__ref.runClassMethod (b4j.example.httpjob.class, "_escapelink" /*RemoteObject*/ ,(Object)(_link),(Object)(_parameters))));
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e5) {
			BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e5.toString()); BA.debugLineNum = 231;BA.debugLine="Log($\"Invalid link: ${Link}\"$)";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("LogImpl","96488069",(RemoteObject.concat(RemoteObject.createImmutable("Invalid link: "),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_link))),RemoteObject.createImmutable(""))),0);
 BA.debugLineNum = 232;BA.debugLine="req.InitializeGet(escapeLink(InvalidURL, Paramet";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializeGet",(Object)(__ref.runClassMethod (b4j.example.httpjob.class, "_escapelink" /*RemoteObject*/ ,(Object)(__ref.getField(true,"_invalidurl" /*RemoteObject*/ )),(Object)(_parameters))));
 };
 BA.debugLineNum = 234;BA.debugLine="CallSubDelayed2(HttpUtils2Service, \"SubmitJob\", M";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)((httpjob._httputils2service.getObject())),(Object)(BA.ObjectToString("SubmitJob")),(Object)(__ref));
 BA.debugLineNum = 235;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _escapelink(RemoteObject __ref,RemoteObject _link,RemoteObject _parameters) throws Exception{
try {
		Debug.PushSubsStack("escapeLink (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,237);
if (RapidSub.canDelegate("escapelink")) { return __ref.runUserSub(false, "httpjob","escapelink", __ref, _link, _parameters);}
RemoteObject _sb = RemoteObject.declareNull("anywheresoftware.b4a.keywords.StringBuilderWrapper");
RemoteObject _su = RemoteObject.declareNull("anywheresoftware.b4a.objects.StringUtils");
int _i = 0;
Debug.locals.put("Link", _link);
Debug.locals.put("Parameters", _parameters);
 BA.debugLineNum = 237;BA.debugLine="Private Sub escapeLink(Link As String, Parameters(";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 238;BA.debugLine="Dim sb As StringBuilder";
Debug.JustUpdateDeviceLine();
_sb = RemoteObject.createNew ("anywheresoftware.b4a.keywords.StringBuilderWrapper");Debug.locals.put("sb", _sb);
 BA.debugLineNum = 239;BA.debugLine="sb.Initialize";
Debug.JustUpdateDeviceLine();
_sb.runVoidMethod ("Initialize");
 BA.debugLineNum = 240;BA.debugLine="sb.Append(Link)";
Debug.JustUpdateDeviceLine();
_sb.runVoidMethod ("Append",(Object)(_link));
 BA.debugLineNum = 241;BA.debugLine="If Parameters.Length > 0 Then sb.Append(\"?\")";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",_parameters.getField(true,"length"),BA.numberCast(double.class, 0))) { 
_sb.runVoidMethod ("Append",(Object)(RemoteObject.createImmutable("?")));};
 BA.debugLineNum = 242;BA.debugLine="Dim su As StringUtils";
Debug.JustUpdateDeviceLine();
_su = RemoteObject.createNew ("anywheresoftware.b4a.objects.StringUtils");Debug.locals.put("su", _su);
 BA.debugLineNum = 243;BA.debugLine="For i = 0 To Parameters.Length - 1 Step 2";
Debug.JustUpdateDeviceLine();
{
final int step6 = 2;
final int limit6 = RemoteObject.solve(new RemoteObject[] {_parameters.getField(true,"length"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step6 > 0 && _i <= limit6) || (step6 < 0 && _i >= limit6) ;_i = ((int)(0 + _i + step6))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 244;BA.debugLine="If i > 0 Then sb.Append(\"&\")";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean(">",RemoteObject.createImmutable(_i),BA.numberCast(double.class, 0))) { 
_sb.runVoidMethod ("Append",(Object)(RemoteObject.createImmutable("&")));};
 BA.debugLineNum = 245;BA.debugLine="sb.Append(su.EncodeUrl(Parameters(i), \"UTF8\")).A";
Debug.JustUpdateDeviceLine();
_sb.runMethod(false,"Append",(Object)(_su.runMethod(true,"EncodeUrl",(Object)(_parameters.getArrayElement(true,BA.numberCast(int.class, _i))),(Object)(RemoteObject.createImmutable("UTF8"))))).runVoidMethod ("Append",(Object)(RemoteObject.createImmutable("=")));
 BA.debugLineNum = 246;BA.debugLine="sb.Append(su.EncodeUrl(Parameters(i + 1), \"UTF8\"";
Debug.JustUpdateDeviceLine();
_sb.runVoidMethod ("Append",(Object)(_su.runMethod(true,"EncodeUrl",(Object)(_parameters.getArrayElement(true,RemoteObject.solve(new RemoteObject[] {RemoteObject.createImmutable(_i),RemoteObject.createImmutable(1)}, "+",1, 1))),(Object)(RemoteObject.createImmutable("UTF8")))));
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 248;BA.debugLine="Return sb.ToString";
Debug.JustUpdateDeviceLine();
if (true) return _sb.runMethod(true,"ToString");
 BA.debugLineNum = 249;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getbitmap(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("GetBitmap (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,313);
if (RapidSub.canDelegate("getbitmap")) { return __ref.runUserSub(false, "httpjob","getbitmap", __ref);}
RemoteObject _b = RemoteObject.declareNull("anywheresoftware.b4j.objects.ImageViewWrapper.ImageWrapper");
 BA.debugLineNum = 313;BA.debugLine="Public Sub GetBitmap As Image";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 314;BA.debugLine="Dim b As Image";
Debug.JustUpdateDeviceLine();
_b = RemoteObject.createNew ("anywheresoftware.b4j.objects.ImageViewWrapper.ImageWrapper");Debug.locals.put("b", _b);
 BA.debugLineNum = 315;BA.debugLine="b = fx.LoadImage(HttpUtils2Service.TempFolder, ta";
Debug.JustUpdateDeviceLine();
_b = __ref.getField(false,"_fx" /*RemoteObject*/ ).runMethod(false,"LoadImage",(Object)(httpjob._httputils2service._tempfolder /*RemoteObject*/ ),(Object)(__ref.getField(true,"_taskid" /*RemoteObject*/ )));Debug.locals.put("b", _b);
 BA.debugLineNum = 316;BA.debugLine="Return b";
Debug.JustUpdateDeviceLine();
if (true) return _b;
 BA.debugLineNum = 317;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getinputstream(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("GetInputStream (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,338);
if (RapidSub.canDelegate("getinputstream")) { return __ref.runUserSub(false, "httpjob","getinputstream", __ref);}
RemoteObject _in = RemoteObject.declareNull("anywheresoftware.b4a.objects.streams.File.InputStreamWrapper");
 BA.debugLineNum = 338;BA.debugLine="Public Sub GetInputStream As InputStream";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 339;BA.debugLine="Dim In As InputStream";
Debug.JustUpdateDeviceLine();
_in = RemoteObject.createNew ("anywheresoftware.b4a.objects.streams.File.InputStreamWrapper");Debug.locals.put("In", _in);
 BA.debugLineNum = 340;BA.debugLine="In = File.OpenInput(HttpUtils2Service.TempFolder,";
Debug.JustUpdateDeviceLine();
_in = httpjob.__c.getField(false,"File").runMethod(false,"OpenInput",(Object)(httpjob._httputils2service._tempfolder /*RemoteObject*/ ),(Object)(__ref.getField(true,"_taskid" /*RemoteObject*/ )));Debug.locals.put("In", _in);
 BA.debugLineNum = 341;BA.debugLine="Return In";
Debug.JustUpdateDeviceLine();
if (true) return _in;
 BA.debugLineNum = 342;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getrequest(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("GetRequest (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,301);
if (RapidSub.canDelegate("getrequest")) { return __ref.runUserSub(false, "httpjob","getrequest", __ref);}
 BA.debugLineNum = 301;BA.debugLine="Public Sub GetRequest As OkHttpRequest";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 302;BA.debugLine="Return req";
Debug.JustUpdateDeviceLine();
if (true) return __ref.getField(false,"_req" /*RemoteObject*/ );
 BA.debugLineNum = 303;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getstring(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("GetString (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,282);
if (RapidSub.canDelegate("getstring")) { return __ref.runUserSub(false, "httpjob","getstring", __ref);}
 BA.debugLineNum = 282;BA.debugLine="Public Sub GetString As String";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 283;BA.debugLine="Return GetString2(\"UTF8\")";
Debug.JustUpdateDeviceLine();
if (true) return __ref.runClassMethod (b4j.example.httpjob.class, "_getstring2" /*RemoteObject*/ ,(Object)(RemoteObject.createImmutable("UTF8")));
 BA.debugLineNum = 284;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _getstring2(RemoteObject __ref,RemoteObject _encoding) throws Exception{
try {
		Debug.PushSubsStack("GetString2 (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,287);
if (RapidSub.canDelegate("getstring2")) { return __ref.runUserSub(false, "httpjob","getstring2", __ref, _encoding);}
RemoteObject _tr = RemoteObject.declareNull("anywheresoftware.b4a.objects.streams.File.TextReaderWrapper");
RemoteObject _res = RemoteObject.createImmutable("");
Debug.locals.put("Encoding", _encoding);
 BA.debugLineNum = 287;BA.debugLine="Public Sub GetString2(Encoding As String) As Strin";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 291;BA.debugLine="Dim tr As TextReader";
Debug.JustUpdateDeviceLine();
_tr = RemoteObject.createNew ("anywheresoftware.b4a.objects.streams.File.TextReaderWrapper");Debug.locals.put("tr", _tr);
 BA.debugLineNum = 292;BA.debugLine="tr.Initialize2(File.OpenInput(HttpUtils2Service.T";
Debug.JustUpdateDeviceLine();
_tr.runVoidMethod ("Initialize2",(Object)((httpjob.__c.getField(false,"File").runMethod(false,"OpenInput",(Object)(httpjob._httputils2service._tempfolder /*RemoteObject*/ ),(Object)(__ref.getField(true,"_taskid" /*RemoteObject*/ ))).getObject())),(Object)(_encoding));
 BA.debugLineNum = 293;BA.debugLine="Dim res As String = tr.ReadAll";
Debug.JustUpdateDeviceLine();
_res = _tr.runMethod(true,"ReadAll");Debug.locals.put("res", _res);Debug.locals.put("res", _res);
 BA.debugLineNum = 294;BA.debugLine="tr.Close";
Debug.JustUpdateDeviceLine();
_tr.runVoidMethod ("Close");
 BA.debugLineNum = 295;BA.debugLine="Return res";
Debug.JustUpdateDeviceLine();
if (true) return _res;
 BA.debugLineNum = 297;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _head(RemoteObject __ref,RemoteObject _link) throws Exception{
try {
		Debug.PushSubsStack("Head (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,110);
if (RapidSub.canDelegate("head")) { return __ref.runUserSub(false, "httpjob","head", __ref, _link);}
Debug.locals.put("Link", _link);
 BA.debugLineNum = 110;BA.debugLine="Public Sub Head(Link As String)";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 111;BA.debugLine="Try";
Debug.JustUpdateDeviceLine();
try { BA.debugLineNum = 112;BA.debugLine="Link = AddScheme(Link)";
Debug.JustUpdateDeviceLine();
_link = __ref.runClassMethod (b4j.example.httpjob.class, "_addscheme" /*RemoteObject*/ ,(Object)(_link));Debug.locals.put("Link", _link);
 BA.debugLineNum = 113;BA.debugLine="req.InitializeHead(Link)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializeHead",(Object)(_link));
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e5) {
			BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e5.toString()); BA.debugLineNum = 115;BA.debugLine="Log($\"Invalid link: ${Link}\"$)";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("LogImpl","96160389",(RemoteObject.concat(RemoteObject.createImmutable("Invalid link: "),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_link))),RemoteObject.createImmutable(""))),0);
 BA.debugLineNum = 116;BA.debugLine="req.InitializeHead(InvalidURL)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializeHead",(Object)(__ref.getField(true,"_invalidurl" /*RemoteObject*/ )));
 };
 BA.debugLineNum = 118;BA.debugLine="CallSubDelayed2(HttpUtils2Service, \"SubmitJob\", M";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)((httpjob._httputils2service.getObject())),(Object)(BA.ObjectToString("SubmitJob")),(Object)(__ref));
 BA.debugLineNum = 119;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba,RemoteObject _name,RemoteObject _targetmodule) throws Exception{
try {
		Debug.PushSubsStack("Initialize (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,38);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "httpjob","initialize", __ref, _ba, _name, _targetmodule);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
Debug.locals.put("Name", _name);
Debug.locals.put("TargetModule", _targetmodule);
 BA.debugLineNum = 38;BA.debugLine="Public Sub Initialize (Name As String, TargetModul";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 39;BA.debugLine="JobName = Name";
Debug.JustUpdateDeviceLine();
__ref.setField ("_jobname" /*RemoteObject*/ ,_name);
 BA.debugLineNum = 40;BA.debugLine="target = TargetModule";
Debug.JustUpdateDeviceLine();
__ref.setField ("_target" /*RemoteObject*/ ,_targetmodule);
 BA.debugLineNum = 41;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _multipartstartsection(RemoteObject __ref,RemoteObject _stream,RemoteObject _empty) throws Exception{
try {
		Debug.PushSubsStack("MultipartStartSection (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,170);
if (RapidSub.canDelegate("multipartstartsection")) { return __ref.runUserSub(false, "httpjob","multipartstartsection", __ref, _stream, _empty);}
Debug.locals.put("stream", _stream);
Debug.locals.put("empty", _empty);
 BA.debugLineNum = 170;BA.debugLine="Private Sub MultipartStartSection (stream As Outpu";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 171;BA.debugLine="If empty = False Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_empty,httpjob.__c.getField(true,"False"))) { 
 BA.debugLineNum = 172;BA.debugLine="stream.WriteBytes(Array As Byte(13, 10), 0, 2)";
Debug.JustUpdateDeviceLine();
_stream.runVoidMethod ("WriteBytes",(Object)(RemoteObject.createNewArray("byte",new int[] {2},new Object[] {BA.numberCast(byte.class, 13),BA.numberCast(byte.class, 10)})),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 2)));
 }else {
 BA.debugLineNum = 174;BA.debugLine="empty = False";
Debug.JustUpdateDeviceLine();
_empty = httpjob.__c.getField(true,"False");Debug.locals.put("empty", _empty);
 };
 BA.debugLineNum = 176;BA.debugLine="Return empty";
Debug.JustUpdateDeviceLine();
if (true) return _empty;
 BA.debugLineNum = 177;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable(false);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _patchbytes(RemoteObject __ref,RemoteObject _link,RemoteObject _data) throws Exception{
try {
		Debug.PushSubsStack("PatchBytes (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,88);
if (RapidSub.canDelegate("patchbytes")) { return __ref.runUserSub(false, "httpjob","patchbytes", __ref, _link, _data);}
Debug.locals.put("Link", _link);
Debug.locals.put("Data", _data);
 BA.debugLineNum = 88;BA.debugLine="Public Sub PatchBytes(Link As String, Data() As By";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 89;BA.debugLine="Link = AddScheme(Link)";
Debug.JustUpdateDeviceLine();
_link = __ref.runClassMethod (b4j.example.httpjob.class, "_addscheme" /*RemoteObject*/ ,(Object)(_link));Debug.locals.put("Link", _link);
 BA.debugLineNum = 97;BA.debugLine="Try";
Debug.JustUpdateDeviceLine();
try { BA.debugLineNum = 98;BA.debugLine="req.InitializePatch2(Link, Data)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializePatch2",(Object)(_link),(Object)(_data));
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e5) {
			BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e5.toString()); BA.debugLineNum = 100;BA.debugLine="Log($\"Invalid link: ${Link}\"$)";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("LogImpl","96094860",(RemoteObject.concat(RemoteObject.createImmutable("Invalid link: "),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_link))),RemoteObject.createImmutable(""))),0);
 BA.debugLineNum = 101;BA.debugLine="req.InitializePatch2(InvalidURL, Data)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializePatch2",(Object)(__ref.getField(true,"_invalidurl" /*RemoteObject*/ )),(Object)(_data));
 };
 BA.debugLineNum = 105;BA.debugLine="CallSubDelayed2(HttpUtils2Service, \"SubmitJob\", M";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)((httpjob._httputils2service.getObject())),(Object)(BA.ObjectToString("SubmitJob")),(Object)(__ref));
 BA.debugLineNum = 106;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _patchstring(RemoteObject __ref,RemoteObject _link,RemoteObject _text) throws Exception{
try {
		Debug.PushSubsStack("PatchString (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,83);
if (RapidSub.canDelegate("patchstring")) { return __ref.runUserSub(false, "httpjob","patchstring", __ref, _link, _text);}
Debug.locals.put("Link", _link);
Debug.locals.put("Text", _text);
 BA.debugLineNum = 83;BA.debugLine="Public Sub PatchString(Link As String, Text As Str";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 84;BA.debugLine="PatchBytes(Link, Text.GetBytes(\"UTF8\"))";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.httpjob.class, "_patchbytes" /*RemoteObject*/ ,(Object)(_link),(Object)(_text.runMethod(false,"getBytes",(Object)(RemoteObject.createImmutable("UTF8")))));
 BA.debugLineNum = 85;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _postbytes(RemoteObject __ref,RemoteObject _link,RemoteObject _data) throws Exception{
try {
		Debug.PushSubsStack("PostBytes (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,54);
if (RapidSub.canDelegate("postbytes")) { return __ref.runUserSub(false, "httpjob","postbytes", __ref, _link, _data);}
Debug.locals.put("Link", _link);
Debug.locals.put("Data", _data);
 BA.debugLineNum = 54;BA.debugLine="Public Sub PostBytes(Link As String, Data() As Byt";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 55;BA.debugLine="Try";
Debug.JustUpdateDeviceLine();
try { BA.debugLineNum = 56;BA.debugLine="Link = AddScheme(Link)";
Debug.JustUpdateDeviceLine();
_link = __ref.runClassMethod (b4j.example.httpjob.class, "_addscheme" /*RemoteObject*/ ,(Object)(_link));Debug.locals.put("Link", _link);
 BA.debugLineNum = 57;BA.debugLine="req.InitializePost2(Link, Data)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializePost2",(Object)(_link),(Object)(_data));
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e5) {
			BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e5.toString()); BA.debugLineNum = 59;BA.debugLine="Log($\"Invalid link: ${Link}\"$)";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("LogImpl","95832709",(RemoteObject.concat(RemoteObject.createImmutable("Invalid link: "),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_link))),RemoteObject.createImmutable(""))),0);
 BA.debugLineNum = 60;BA.debugLine="req.InitializePost2(InvalidURL, Data)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializePost2",(Object)(__ref.getField(true,"_invalidurl" /*RemoteObject*/ )),(Object)(_data));
 };
 BA.debugLineNum = 62;BA.debugLine="CallSubDelayed2(HttpUtils2Service, \"SubmitJob\", M";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)((httpjob._httputils2service.getObject())),(Object)(BA.ObjectToString("SubmitJob")),(Object)(__ref));
 BA.debugLineNum = 63;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _postfile(RemoteObject __ref,RemoteObject _link,RemoteObject _dir,RemoteObject _filename) throws Exception{
try {
		Debug.PushSubsStack("PostFile (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,181);
if (RapidSub.canDelegate("postfile")) { return __ref.runUserSub(false, "httpjob","postfile", __ref, _link, _dir, _filename);}
RemoteObject _length = RemoteObject.createImmutable(0);
RemoteObject _in = RemoteObject.declareNull("anywheresoftware.b4a.objects.streams.File.InputStreamWrapper");
RemoteObject _out = RemoteObject.declareNull("anywheresoftware.b4a.objects.streams.File.OutputStreamWrapper");
Debug.locals.put("Link", _link);
Debug.locals.put("Dir", _dir);
Debug.locals.put("FileName", _filename);
 BA.debugLineNum = 181;BA.debugLine="Public Sub PostFile(Link As String, Dir As String,";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 182;BA.debugLine="Link = AddScheme(Link)";
Debug.JustUpdateDeviceLine();
_link = __ref.runClassMethod (b4j.example.httpjob.class, "_addscheme" /*RemoteObject*/ ,(Object)(_link));Debug.locals.put("Link", _link);
 BA.debugLineNum = 187;BA.debugLine="Dim length As Int";
Debug.JustUpdateDeviceLine();
_length = RemoteObject.createImmutable(0);Debug.locals.put("length", _length);
 BA.debugLineNum = 188;BA.debugLine="If Dir = File.DirAssets Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("=",_dir,httpjob.__c.getField(false,"File").runMethod(true,"getDirAssets"))) { 
 BA.debugLineNum = 189;BA.debugLine="Log(\"Cannot send files from the assets folder.\")";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("LogImpl","96357000",RemoteObject.createImmutable("Cannot send files from the assets folder."),0);
 BA.debugLineNum = 190;BA.debugLine="Return";
Debug.JustUpdateDeviceLine();
if (true) return RemoteObject.createImmutable("");
 };
 BA.debugLineNum = 192;BA.debugLine="length = File.Size(Dir, FileName)";
Debug.JustUpdateDeviceLine();
_length = BA.numberCast(int.class, httpjob.__c.getField(false,"File").runMethod(true,"Size",(Object)(_dir),(Object)(_filename)));Debug.locals.put("length", _length);
 BA.debugLineNum = 193;BA.debugLine="Dim In As InputStream";
Debug.JustUpdateDeviceLine();
_in = RemoteObject.createNew ("anywheresoftware.b4a.objects.streams.File.InputStreamWrapper");Debug.locals.put("In", _in);
 BA.debugLineNum = 194;BA.debugLine="In = File.OpenInput(Dir, FileName)";
Debug.JustUpdateDeviceLine();
_in = httpjob.__c.getField(false,"File").runMethod(false,"OpenInput",(Object)(_dir),(Object)(_filename));Debug.locals.put("In", _in);
 BA.debugLineNum = 195;BA.debugLine="If length < 1000000 Then '1mb";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("<",_length,BA.numberCast(double.class, 1000000))) { 
 BA.debugLineNum = 198;BA.debugLine="Dim out As OutputStream";
Debug.JustUpdateDeviceLine();
_out = RemoteObject.createNew ("anywheresoftware.b4a.objects.streams.File.OutputStreamWrapper");Debug.locals.put("out", _out);
 BA.debugLineNum = 199;BA.debugLine="out.InitializeToBytesArray(length)";
Debug.JustUpdateDeviceLine();
_out.runVoidMethod ("InitializeToBytesArray",(Object)(_length));
 BA.debugLineNum = 200;BA.debugLine="File.Copy2(In, out)";
Debug.JustUpdateDeviceLine();
httpjob.__c.getField(false,"File").runVoidMethod ("Copy2",(Object)((_in.getObject())),(Object)((_out.getObject())));
 BA.debugLineNum = 201;BA.debugLine="PostBytes(Link, out.ToBytesArray)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.httpjob.class, "_postbytes" /*RemoteObject*/ ,(Object)(_link),(Object)(_out.runMethod(false,"ToBytesArray")));
 }else {
 BA.debugLineNum = 203;BA.debugLine="req.InitializePost(Link, In, length)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializePost",(Object)(_link),(Object)((_in.getObject())),(Object)(_length));
 BA.debugLineNum = 204;BA.debugLine="CallSubDelayed2(HttpUtils2Service, \"SubmitJob\",";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)((httpjob._httputils2service.getObject())),(Object)(BA.ObjectToString("SubmitJob")),(Object)(__ref));
 };
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
public static RemoteObject  _postmultipart(RemoteObject __ref,RemoteObject _link,RemoteObject _namevalues,RemoteObject _files) throws Exception{
try {
		Debug.PushSubsStack("PostMultipart (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,124);
if (RapidSub.canDelegate("postmultipart")) { return __ref.runUserSub(false, "httpjob","postmultipart", __ref, _link, _namevalues, _files);}
RemoteObject _boundary = RemoteObject.createImmutable("");
RemoteObject _stream = RemoteObject.declareNull("anywheresoftware.b4a.objects.streams.File.OutputStreamWrapper");
RemoteObject _b = null;
RemoteObject _eol = RemoteObject.createImmutable("");
RemoteObject _empty = RemoteObject.createImmutable(false);
RemoteObject _key = RemoteObject.createImmutable("");
RemoteObject _value = RemoteObject.createImmutable("");
RemoteObject _s = RemoteObject.createImmutable("");
RemoteObject _fd = RemoteObject.declareNull("b4j.example.httpjob._multipartfiledata");
RemoteObject _in = RemoteObject.declareNull("anywheresoftware.b4a.objects.streams.File.InputStreamWrapper");
Debug.locals.put("Link", _link);
Debug.locals.put("NameValues", _namevalues);
Debug.locals.put("Files", _files);
 BA.debugLineNum = 124;BA.debugLine="Public Sub PostMultipart(Link As String, NameValue";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 125;BA.debugLine="Dim boundary As String = \"-----------------------";
Debug.JustUpdateDeviceLine();
_boundary = BA.ObjectToString("---------------------------1461124740692");Debug.locals.put("boundary", _boundary);Debug.locals.put("boundary", _boundary);
 BA.debugLineNum = 126;BA.debugLine="Dim stream As OutputStream";
Debug.JustUpdateDeviceLine();
_stream = RemoteObject.createNew ("anywheresoftware.b4a.objects.streams.File.OutputStreamWrapper");Debug.locals.put("stream", _stream);
 BA.debugLineNum = 127;BA.debugLine="stream.InitializeToBytesArray(0)";
Debug.JustUpdateDeviceLine();
_stream.runVoidMethod ("InitializeToBytesArray",(Object)(BA.numberCast(int.class, 0)));
 BA.debugLineNum = 128;BA.debugLine="Dim b() As Byte";
Debug.JustUpdateDeviceLine();
_b = RemoteObject.createNewArray ("byte", new int[] {0}, new Object[]{});Debug.locals.put("b", _b);
 BA.debugLineNum = 129;BA.debugLine="Dim eol As String = Chr(13) & Chr(10)";
Debug.JustUpdateDeviceLine();
_eol = RemoteObject.concat(httpjob.__c.runMethod(true,"Chr",(Object)(BA.numberCast(int.class, 13))),httpjob.__c.runMethod(true,"Chr",(Object)(BA.numberCast(int.class, 10))));Debug.locals.put("eol", _eol);Debug.locals.put("eol", _eol);
 BA.debugLineNum = 130;BA.debugLine="Dim empty As Boolean = True";
Debug.JustUpdateDeviceLine();
_empty = httpjob.__c.getField(true,"True");Debug.locals.put("empty", _empty);Debug.locals.put("empty", _empty);
 BA.debugLineNum = 131;BA.debugLine="If NameValues <> Null And NameValues.IsInitialize";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("N",_namevalues) && RemoteObject.solveBoolean(".",_namevalues.runMethod(true,"IsInitialized"))) { 
 BA.debugLineNum = 132;BA.debugLine="For Each key As String In NameValues.Keys";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group8 = _namevalues.runMethod(false,"Keys");
final int groupLen8 = group8.runMethod(true,"getSize").<Integer>get()
;int index8 = 0;
;
for (; index8 < groupLen8;index8++){
_key = BA.ObjectToString(group8.runMethod(false,"Get",index8));Debug.locals.put("key", _key);
Debug.locals.put("key", _key);
 BA.debugLineNum = 133;BA.debugLine="Dim value As String = NameValues.Get(key)";
Debug.JustUpdateDeviceLine();
_value = BA.ObjectToString(_namevalues.runMethod(false,"Get",(Object)((_key))));Debug.locals.put("value", _value);Debug.locals.put("value", _value);
 BA.debugLineNum = 134;BA.debugLine="empty = MultipartStartSection (stream, empty)";
Debug.JustUpdateDeviceLine();
_empty = __ref.runClassMethod (b4j.example.httpjob.class, "_multipartstartsection" /*RemoteObject*/ ,(Object)(_stream),(Object)(_empty));Debug.locals.put("empty", _empty);
 BA.debugLineNum = 135;BA.debugLine="Dim s As String = _ $\"--${boundary} Content-Dis";
Debug.JustUpdateDeviceLine();
_s = (RemoteObject.concat(RemoteObject.createImmutable("--"),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_boundary))),RemoteObject.createImmutable("\n"),RemoteObject.createImmutable("Content-Disposition: form-data; name=\""),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_key))),RemoteObject.createImmutable("\"\n"),RemoteObject.createImmutable("\n"),RemoteObject.createImmutable(""),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_value))),RemoteObject.createImmutable("")));Debug.locals.put("s", _s);Debug.locals.put("s", _s);
 BA.debugLineNum = 140;BA.debugLine="b = s.Replace(CRLF, eol).GetBytes(\"UTF8\")";
Debug.JustUpdateDeviceLine();
_b = _s.runMethod(true,"replace",(Object)(httpjob.__c.getField(true,"CRLF")),(Object)(_eol)).runMethod(false,"getBytes",(Object)(RemoteObject.createImmutable("UTF8")));Debug.locals.put("b", _b);
 BA.debugLineNum = 141;BA.debugLine="stream.WriteBytes(b, 0, b.Length)";
Debug.JustUpdateDeviceLine();
_stream.runVoidMethod ("WriteBytes",(Object)(_b),(Object)(BA.numberCast(int.class, 0)),(Object)(_b.getField(true,"length")));
 }
}Debug.locals.put("key", _key);
;
 };
 BA.debugLineNum = 144;BA.debugLine="If Files <> Null And Files.IsInitialized Then";
Debug.JustUpdateDeviceLine();
if (RemoteObject.solveBoolean("N",_files) && RemoteObject.solveBoolean(".",_files.runMethod(true,"IsInitialized"))) { 
 BA.debugLineNum = 145;BA.debugLine="For Each fd As MultipartFileData In Files";
Debug.JustUpdateDeviceLine();
{
final RemoteObject group17 = _files;
final int groupLen17 = group17.runMethod(true,"getSize").<Integer>get()
;int index17 = 0;
;
for (; index17 < groupLen17;index17++){
_fd = (group17.runMethod(false,"Get",index17));Debug.locals.put("fd", _fd);
Debug.locals.put("fd", _fd);
 BA.debugLineNum = 146;BA.debugLine="empty = MultipartStartSection (stream, empty)";
Debug.JustUpdateDeviceLine();
_empty = __ref.runClassMethod (b4j.example.httpjob.class, "_multipartstartsection" /*RemoteObject*/ ,(Object)(_stream),(Object)(_empty));Debug.locals.put("empty", _empty);
 BA.debugLineNum = 147;BA.debugLine="Dim s As String = _ $\"--${boundary} Content-Dis";
Debug.JustUpdateDeviceLine();
_s = (RemoteObject.concat(RemoteObject.createImmutable("--"),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_boundary))),RemoteObject.createImmutable("\n"),RemoteObject.createImmutable("Content-Disposition: form-data; name=\""),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_fd.getField(true,"KeyName" /*RemoteObject*/ )))),RemoteObject.createImmutable("\"; filename=\""),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_fd.getField(true,"FileName" /*RemoteObject*/ )))),RemoteObject.createImmutable("\"\n"),RemoteObject.createImmutable("Content-Type: "),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_fd.getField(true,"ContentType" /*RemoteObject*/ )))),RemoteObject.createImmutable("\n"),RemoteObject.createImmutable("\n"),RemoteObject.createImmutable("")));Debug.locals.put("s", _s);Debug.locals.put("s", _s);
 BA.debugLineNum = 153;BA.debugLine="b = s.Replace(CRLF, eol).GetBytes(\"UTF8\")";
Debug.JustUpdateDeviceLine();
_b = _s.runMethod(true,"replace",(Object)(httpjob.__c.getField(true,"CRLF")),(Object)(_eol)).runMethod(false,"getBytes",(Object)(RemoteObject.createImmutable("UTF8")));Debug.locals.put("b", _b);
 BA.debugLineNum = 154;BA.debugLine="stream.WriteBytes(b, 0, b.Length)";
Debug.JustUpdateDeviceLine();
_stream.runVoidMethod ("WriteBytes",(Object)(_b),(Object)(BA.numberCast(int.class, 0)),(Object)(_b.getField(true,"length")));
 BA.debugLineNum = 155;BA.debugLine="Dim in As InputStream = File.OpenInput(fd.Dir,";
Debug.JustUpdateDeviceLine();
_in = RemoteObject.createNew ("anywheresoftware.b4a.objects.streams.File.InputStreamWrapper");
_in = httpjob.__c.getField(false,"File").runMethod(false,"OpenInput",(Object)(_fd.getField(true,"Dir" /*RemoteObject*/ )),(Object)(_fd.getField(true,"FileName" /*RemoteObject*/ )));Debug.locals.put("in", _in);Debug.locals.put("in", _in);
 BA.debugLineNum = 156;BA.debugLine="File.Copy2(in, stream)";
Debug.JustUpdateDeviceLine();
httpjob.__c.getField(false,"File").runVoidMethod ("Copy2",(Object)((_in.getObject())),(Object)((_stream.getObject())));
 }
}Debug.locals.put("fd", _fd);
;
 };
 BA.debugLineNum = 159;BA.debugLine="empty = MultipartStartSection (stream, empty)";
Debug.JustUpdateDeviceLine();
_empty = __ref.runClassMethod (b4j.example.httpjob.class, "_multipartstartsection" /*RemoteObject*/ ,(Object)(_stream),(Object)(_empty));Debug.locals.put("empty", _empty);
 BA.debugLineNum = 160;BA.debugLine="s = _ $\"--${boundary}-- \"$";
Debug.JustUpdateDeviceLine();
_s = (RemoteObject.concat(RemoteObject.createImmutable("--"),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_boundary))),RemoteObject.createImmutable("--\n"),RemoteObject.createImmutable("")));Debug.locals.put("s", _s);
 BA.debugLineNum = 163;BA.debugLine="b = s.Replace(CRLF, eol).GetBytes(\"UTF8\")";
Debug.JustUpdateDeviceLine();
_b = _s.runMethod(true,"replace",(Object)(httpjob.__c.getField(true,"CRLF")),(Object)(_eol)).runMethod(false,"getBytes",(Object)(RemoteObject.createImmutable("UTF8")));Debug.locals.put("b", _b);
 BA.debugLineNum = 164;BA.debugLine="stream.WriteBytes(b, 0, b.Length)";
Debug.JustUpdateDeviceLine();
_stream.runVoidMethod ("WriteBytes",(Object)(_b),(Object)(BA.numberCast(int.class, 0)),(Object)(_b.getField(true,"length")));
 BA.debugLineNum = 165;BA.debugLine="PostBytes(Link, stream.ToBytesArray)";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.httpjob.class, "_postbytes" /*RemoteObject*/ ,(Object)(_link),(Object)(_stream.runMethod(false,"ToBytesArray")));
 BA.debugLineNum = 166;BA.debugLine="req.SetContentType(\"multipart/form-data; boundary";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("SetContentType",(Object)(RemoteObject.concat(RemoteObject.createImmutable("multipart/form-data; boundary="),_boundary)));
 BA.debugLineNum = 167;BA.debugLine="req.SetContentEncoding(\"UTF8\")";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("SetContentEncoding",(Object)(RemoteObject.createImmutable("UTF8")));
 BA.debugLineNum = 168;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _poststring(RemoteObject __ref,RemoteObject _link,RemoteObject _text) throws Exception{
try {
		Debug.PushSubsStack("PostString (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,49);
if (RapidSub.canDelegate("poststring")) { return __ref.runUserSub(false, "httpjob","poststring", __ref, _link, _text);}
Debug.locals.put("Link", _link);
Debug.locals.put("Text", _text);
 BA.debugLineNum = 49;BA.debugLine="Public Sub PostString(Link As String, Text As Stri";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 50;BA.debugLine="PostBytes(Link, Text.GetBytes(\"UTF8\"))";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.httpjob.class, "_postbytes" /*RemoteObject*/ ,(Object)(_link),(Object)(_text.runMethod(false,"getBytes",(Object)(RemoteObject.createImmutable("UTF8")))));
 BA.debugLineNum = 51;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _putbytes(RemoteObject __ref,RemoteObject _link,RemoteObject _data) throws Exception{
try {
		Debug.PushSubsStack("PutBytes (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,71);
if (RapidSub.canDelegate("putbytes")) { return __ref.runUserSub(false, "httpjob","putbytes", __ref, _link, _data);}
Debug.locals.put("Link", _link);
Debug.locals.put("Data", _data);
 BA.debugLineNum = 71;BA.debugLine="Public Sub PutBytes(Link As String, Data() As Byte";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 72;BA.debugLine="Try";
Debug.JustUpdateDeviceLine();
try { BA.debugLineNum = 73;BA.debugLine="Link = AddScheme(Link)";
Debug.JustUpdateDeviceLine();
_link = __ref.runClassMethod (b4j.example.httpjob.class, "_addscheme" /*RemoteObject*/ ,(Object)(_link));Debug.locals.put("Link", _link);
 BA.debugLineNum = 74;BA.debugLine="req.InitializePut2(Link, Data)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializePut2",(Object)(_link),(Object)(_data));
 Debug.CheckDeviceExceptions();
} 
       catch (Exception e5) {
			BA.rdebugUtils.runVoidMethod("setLastException",__ref.getField(false, "ba"), e5.toString()); BA.debugLineNum = 76;BA.debugLine="Log($\"Invalid link: ${Link}\"$)";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("LogImpl","95963781",(RemoteObject.concat(RemoteObject.createImmutable("Invalid link: "),httpjob.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_link))),RemoteObject.createImmutable(""))),0);
 BA.debugLineNum = 77;BA.debugLine="req.InitializePut2(InvalidURL, Data)";
Debug.JustUpdateDeviceLine();
__ref.getField(false,"_req" /*RemoteObject*/ ).runVoidMethod ("InitializePut2",(Object)(__ref.getField(true,"_invalidurl" /*RemoteObject*/ )),(Object)(_data));
 };
 BA.debugLineNum = 79;BA.debugLine="CallSubDelayed2(HttpUtils2Service, \"SubmitJob\", M";
Debug.JustUpdateDeviceLine();
httpjob.__c.runVoidMethod ("CallSubDelayed2",__ref.getField(false, "ba"),(Object)((httpjob._httputils2service.getObject())),(Object)(BA.ObjectToString("SubmitJob")),(Object)(__ref));
 BA.debugLineNum = 80;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _putstring(RemoteObject __ref,RemoteObject _link,RemoteObject _text) throws Exception{
try {
		Debug.PushSubsStack("PutString (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,66);
if (RapidSub.canDelegate("putstring")) { return __ref.runUserSub(false, "httpjob","putstring", __ref, _link, _text);}
Debug.locals.put("Link", _link);
Debug.locals.put("Text", _text);
 BA.debugLineNum = 66;BA.debugLine="Public Sub PutString(Link As String, Text As Strin";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 67;BA.debugLine="PutBytes(Link, Text.GetBytes(\"UTF8\"))";
Debug.JustUpdateDeviceLine();
__ref.runClassMethod (b4j.example.httpjob.class, "_putbytes" /*RemoteObject*/ ,(Object)(_link),(Object)(_text.runMethod(false,"getBytes",(Object)(RemoteObject.createImmutable("UTF8")))));
 BA.debugLineNum = 68;BA.debugLine="End Sub";
Debug.JustUpdateDeviceLine();
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _release(RemoteObject __ref) throws Exception{
try {
		Debug.PushSubsStack("Release (httpjob) ","httpjob",5,__ref.getField(false, "ba"),__ref,275);
if (RapidSub.canDelegate("release")) { return __ref.runUserSub(false, "httpjob","release", __ref);}
 BA.debugLineNum = 275;BA.debugLine="Public Sub Release";
Debug.JustUpdateDeviceLine();
 BA.debugLineNum = 277;BA.debugLine="File.Delete(HttpUtils2Service.TempFolder, taskId)";
Debug.JustUpdateDeviceLine();
httpjob.__c.getField(false,"File").runVoidMethod ("Delete",(Object)(httpjob._httputils2service._tempfolder /*RemoteObject*/ ),(Object)(__ref.getField(true,"_taskid" /*RemoteObject*/ )));
 BA.debugLineNum = 279;BA.debugLine="End Sub";
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