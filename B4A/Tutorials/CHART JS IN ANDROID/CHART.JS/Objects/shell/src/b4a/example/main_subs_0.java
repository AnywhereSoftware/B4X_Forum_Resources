package b4a.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _activity_create(RemoteObject _firsttime) throws Exception{
try {
		Debug.PushSubsStack("Activity_Create (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,23);
if (RapidSub.canDelegate("activity_create")) { return b4a.example.main.remoteMe.runUserSub(false, "main","activity_create", _firsttime);}
Debug.locals.put("FirstTime", _firsttime);
 BA.debugLineNum = 23;BA.debugLine="Sub Activity_Create(FirstTime As Boolean)";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 24;BA.debugLine="If FirstTime Then";
Debug.ShouldStop(8388608);
if (_firsttime.<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 25;BA.debugLine="template2 = File.ReadString(File.DirAssets, \"cha";
Debug.ShouldStop(16777216);
main._template2 = main.mostCurrent.__c.getField(false,"File").runMethod(true,"ReadString",(Object)(main.mostCurrent.__c.getField(false,"File").runMethod(true,"getDirAssets")),(Object)(RemoteObject.createImmutable("chart.html")));
 };
 BA.debugLineNum = 28;BA.debugLine="Activity.LoadLayout(\"1\")";
Debug.ShouldStop(134217728);
main.mostCurrent._activity.runMethodAndSync(false,"LoadLayout",(Object)(RemoteObject.createImmutable("1")),main.mostCurrent.activityBA);
 BA.debugLineNum = 29;BA.debugLine="WebView1.ZoomEnabled = False";
Debug.ShouldStop(268435456);
main.mostCurrent._webview1.runMethod(true,"setZoomEnabled",main.mostCurrent.__c.getField(true,"False"));
 BA.debugLineNum = 30;BA.debugLine="CreateNewLine";
Debug.ShouldStop(536870912);
_createnewline();
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
public static RemoteObject  _activity_pause(RemoteObject _userclosed) throws Exception{
try {
		Debug.PushSubsStack("Activity_Pause (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,38);
if (RapidSub.canDelegate("activity_pause")) { return b4a.example.main.remoteMe.runUserSub(false, "main","activity_pause", _userclosed);}
Debug.locals.put("UserClosed", _userclosed);
 BA.debugLineNum = 38;BA.debugLine="Sub Activity_Pause (UserClosed As Boolean)";
Debug.ShouldStop(32);
 BA.debugLineNum = 40;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _activity_resume() throws Exception{
try {
		Debug.PushSubsStack("Activity_Resume (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,34);
if (RapidSub.canDelegate("activity_resume")) { return b4a.example.main.remoteMe.runUserSub(false, "main","activity_resume");}
 BA.debugLineNum = 34;BA.debugLine="Sub Activity_Resume";
Debug.ShouldStop(2);
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
public static RemoteObject  _createdatesets(RemoteObject _data,RemoteObject _label,RemoteObject _bordercolor,RemoteObject _fill) throws Exception{
try {
		Debug.PushSubsStack("createDateSets (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,55);
if (RapidSub.canDelegate("createdatesets")) { return b4a.example.main.remoteMe.runUserSub(false, "main","createdatesets", _data, _label, _bordercolor, _fill);}
RemoteObject _str = RemoteObject.createImmutable("");
int _i = 0;
Debug.locals.put("data", _data);
Debug.locals.put("label", _label);
Debug.locals.put("borderColor", _bordercolor);
Debug.locals.put("fill", _fill);
 BA.debugLineNum = 55;BA.debugLine="Private Sub createDateSets(data As List, label As";
Debug.ShouldStop(4194304);
 BA.debugLineNum = 56;BA.debugLine="Dim str As String = \"{\"";
Debug.ShouldStop(8388608);
_str = BA.ObjectToString("{");Debug.locals.put("str", _str);Debug.locals.put("str", _str);
 BA.debugLineNum = 57;BA.debugLine="str = str & \"data:[\"";
Debug.ShouldStop(16777216);
_str = RemoteObject.concat(_str,RemoteObject.createImmutable("data:["));Debug.locals.put("str", _str);
 BA.debugLineNum = 58;BA.debugLine="For i = 0 To data.Size - 1";
Debug.ShouldStop(33554432);
{
final int step3 = 1;
final int limit3 = RemoteObject.solve(new RemoteObject[] {_data.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step3 > 0 && _i <= limit3) || (step3 < 0 && _i >= limit3) ;_i = ((int)(0 + _i + step3))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 59;BA.debugLine="str = str & data.Get(i)";
Debug.ShouldStop(67108864);
_str = RemoteObject.concat(_str,_data.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))));Debug.locals.put("str", _str);
 BA.debugLineNum = 60;BA.debugLine="If Not(i = (data.Size - 1)) Then";
Debug.ShouldStop(134217728);
if (main.mostCurrent.__c.runMethod(true,"Not",(Object)(BA.ObjectToBoolean(RemoteObject.solveBoolean("=",RemoteObject.createImmutable(_i),BA.numberCast(double.class, (RemoteObject.solve(new RemoteObject[] {_data.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1))))))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 61;BA.debugLine="str = str & \",\"";
Debug.ShouldStop(268435456);
_str = RemoteObject.concat(_str,RemoteObject.createImmutable(","));Debug.locals.put("str", _str);
 };
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 64;BA.debugLine="str = str & \"],\"";
Debug.ShouldStop(-2147483648);
_str = RemoteObject.concat(_str,RemoteObject.createImmutable("],"));Debug.locals.put("str", _str);
 BA.debugLineNum = 66;BA.debugLine="str = str & $\"label:\"${label}\",\"$";
Debug.ShouldStop(2);
_str = RemoteObject.concat(_str,(RemoteObject.concat(RemoteObject.createImmutable("label:\""),main.mostCurrent.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_label))),RemoteObject.createImmutable("\","))));Debug.locals.put("str", _str);
 BA.debugLineNum = 67;BA.debugLine="str = str & $\"borderColor:\"${borderColor}\",\"$";
Debug.ShouldStop(4);
_str = RemoteObject.concat(_str,(RemoteObject.concat(RemoteObject.createImmutable("borderColor:\""),main.mostCurrent.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_bordercolor))),RemoteObject.createImmutable("\","))));Debug.locals.put("str", _str);
 BA.debugLineNum = 68;BA.debugLine="str = str & $\"fill:${fill}\"$";
Debug.ShouldStop(8);
_str = RemoteObject.concat(_str,(RemoteObject.concat(RemoteObject.createImmutable("fill:"),main.mostCurrent.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)((_fill))),RemoteObject.createImmutable(""))));Debug.locals.put("str", _str);
 BA.debugLineNum = 69;BA.debugLine="str = str & \"}\"";
Debug.ShouldStop(16);
_str = RemoteObject.concat(_str,RemoteObject.createImmutable("}"));Debug.locals.put("str", _str);
 BA.debugLineNum = 70;BA.debugLine="Return str";
Debug.ShouldStop(32);
if (true) return _str;
 BA.debugLineNum = 71;BA.debugLine="End Sub";
Debug.ShouldStop(64);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createlabels(RemoteObject _lst) throws Exception{
try {
		Debug.PushSubsStack("createLabels (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,44);
if (RapidSub.canDelegate("createlabels")) { return b4a.example.main.remoteMe.runUserSub(false, "main","createlabels", _lst);}
RemoteObject _str = RemoteObject.createImmutable("");
int _i = 0;
Debug.locals.put("lst", _lst);
 BA.debugLineNum = 44;BA.debugLine="Private Sub createLabels(lst As List) As String";
Debug.ShouldStop(2048);
 BA.debugLineNum = 45;BA.debugLine="Dim str As String = \"\"";
Debug.ShouldStop(4096);
_str = BA.ObjectToString("");Debug.locals.put("str", _str);Debug.locals.put("str", _str);
 BA.debugLineNum = 46;BA.debugLine="For i = 0 To lst.Size - 1";
Debug.ShouldStop(8192);
{
final int step2 = 1;
final int limit2 = RemoteObject.solve(new RemoteObject[] {_lst.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1).<Integer>get().intValue();
_i = 0 ;
for (;(step2 > 0 && _i <= limit2) || (step2 < 0 && _i >= limit2) ;_i = ((int)(0 + _i + step2))  ) {
Debug.locals.put("i", _i);
 BA.debugLineNum = 47;BA.debugLine="str = str & $\"\"${lst.Get(i)}\"\"$";
Debug.ShouldStop(16384);
_str = RemoteObject.concat(_str,(RemoteObject.concat(RemoteObject.createImmutable("\""),main.mostCurrent.__c.runMethod(true,"SmartStringFormatter",(Object)(BA.ObjectToString("")),(Object)(_lst.runMethod(false,"Get",(Object)(BA.numberCast(int.class, _i))))),RemoteObject.createImmutable("\""))));Debug.locals.put("str", _str);
 BA.debugLineNum = 48;BA.debugLine="If Not(i = (lst.Size - 1)) Then";
Debug.ShouldStop(32768);
if (main.mostCurrent.__c.runMethod(true,"Not",(Object)(BA.ObjectToBoolean(RemoteObject.solveBoolean("=",RemoteObject.createImmutable(_i),BA.numberCast(double.class, (RemoteObject.solve(new RemoteObject[] {_lst.runMethod(true,"getSize"),RemoteObject.createImmutable(1)}, "-",1, 1))))))).<Boolean>get().booleanValue()) { 
 BA.debugLineNum = 49;BA.debugLine="str = str & \",\"";
Debug.ShouldStop(65536);
_str = RemoteObject.concat(_str,RemoteObject.createImmutable(","));Debug.locals.put("str", _str);
 };
 }
}Debug.locals.put("i", _i);
;
 BA.debugLineNum = 52;BA.debugLine="Return str";
Debug.ShouldStop(524288);
if (true) return _str;
 BA.debugLineNum = 53;BA.debugLine="End Sub";
Debug.ShouldStop(1048576);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createnewline() throws Exception{
try {
		Debug.PushSubsStack("CreateNewLine (main) ","main",0,main.mostCurrent.activityBA,main.mostCurrent,74);
if (RapidSub.canDelegate("createnewline")) { return b4a.example.main.remoteMe.runUserSub(false, "main","createnewline");}
RemoteObject _labels = RemoteObject.createImmutable("");
RemoteObject _datasets = RemoteObject.createImmutable("");
RemoteObject _html = RemoteObject.createImmutable("");
 BA.debugLineNum = 74;BA.debugLine="Private Sub CreateNewLine";
Debug.ShouldStop(512);
 BA.debugLineNum = 75;BA.debugLine="Dim labels As String : labels = createLabels(Arra";
Debug.ShouldStop(1024);
_labels = RemoteObject.createImmutable("");Debug.locals.put("labels", _labels);
 BA.debugLineNum = 75;BA.debugLine="Dim labels As String : labels = createLabels(Arra";
Debug.ShouldStop(1024);
_labels = _createlabels(main.mostCurrent.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("String",new int[] {5},new Object[] {BA.ObjectToString("JAN"),BA.ObjectToString("FEB"),BA.ObjectToString("MAR"),BA.ObjectToString("APR"),RemoteObject.createImmutable("MAY")}))));Debug.locals.put("labels", _labels);
 BA.debugLineNum = 76;BA.debugLine="Dim datasets As String";
Debug.ShouldStop(2048);
_datasets = RemoteObject.createImmutable("");Debug.locals.put("datasets", _datasets);
 BA.debugLineNum = 78;BA.debugLine="datasets = createDateSets(Array As String(\"10\",\"1";
Debug.ShouldStop(8192);
_datasets = RemoteObject.concat(_createdatesets(main.mostCurrent.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("String",new int[] {5},new Object[] {BA.ObjectToString("10"),BA.ObjectToString("11"),BA.ObjectToString("20"),BA.ObjectToString("15"),RemoteObject.createImmutable("18")}))),BA.ObjectToString("SALES 1"),BA.ObjectToString("#3e95cd"),main.mostCurrent.__c.getField(true,"False")),RemoteObject.createImmutable(","));Debug.locals.put("datasets", _datasets);
 BA.debugLineNum = 79;BA.debugLine="datasets = datasets & createDateSets(Array As Str";
Debug.ShouldStop(16384);
_datasets = RemoteObject.concat(_datasets,_createdatesets(main.mostCurrent.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("String",new int[] {5},new Object[] {BA.ObjectToString("20"),BA.ObjectToString("16"),BA.ObjectToString("30"),BA.ObjectToString("35"),RemoteObject.createImmutable("10")}))),BA.ObjectToString("SALES 2"),BA.ObjectToString("#3e20cd"),main.mostCurrent.__c.getField(true,"False")));Debug.locals.put("datasets", _datasets);
 BA.debugLineNum = 81;BA.debugLine="Dim html As String = template2";
Debug.ShouldStop(65536);
_html = main._template2;Debug.locals.put("html", _html);Debug.locals.put("html", _html);
 BA.debugLineNum = 83;BA.debugLine="html = html.Replace(\"$TITLE$\", \"'MONTHS SALES'\")";
Debug.ShouldStop(262144);
_html = _html.runMethod(true,"replace",(Object)(BA.ObjectToString("$TITLE$")),(Object)(RemoteObject.createImmutable("'MONTHS SALES'")));Debug.locals.put("html", _html);
 BA.debugLineNum = 84;BA.debugLine="html = html.Replace(\"$LABELS$\", \"[\" & labels & \"]";
Debug.ShouldStop(524288);
_html = _html.runMethod(true,"replace",(Object)(BA.ObjectToString("$LABELS$")),(Object)(RemoteObject.concat(RemoteObject.createImmutable("["),_labels,RemoteObject.createImmutable("]"))));Debug.locals.put("html", _html);
 BA.debugLineNum = 86;BA.debugLine="html = html.Replace(\"$DATASETS$\",\"[\" & datasets &";
Debug.ShouldStop(2097152);
_html = _html.runMethod(true,"replace",(Object)(BA.ObjectToString("$DATASETS$")),(Object)(RemoteObject.concat(RemoteObject.createImmutable("["),_datasets,RemoteObject.createImmutable("]"))));Debug.locals.put("html", _html);
 BA.debugLineNum = 87;BA.debugLine="Log(html)";
Debug.ShouldStop(4194304);
main.mostCurrent.__c.runVoidMethod ("LogImpl","32228237",_html,0);
 BA.debugLineNum = 88;BA.debugLine="WebView1.LoadHtml(html)";
Debug.ShouldStop(8388608);
main.mostCurrent._webview1.runVoidMethod ("LoadHtml",(Object)(_html));
 BA.debugLineNum = 90;BA.debugLine="End Sub";
Debug.ShouldStop(33554432);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _globals() throws Exception{
 //BA.debugLineNum = 19;BA.debugLine="Sub Globals";
 //BA.debugLineNum = 20;BA.debugLine="Private WebView1 As WebView";
main.mostCurrent._webview1 = RemoteObject.createNew ("anywheresoftware.b4a.objects.WebViewWrapper");
 //BA.debugLineNum = 21;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}

public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main_subs_0._process_globals();
main.myClass = BA.getDeviceClass ("b4a.example.main");
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 15;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 16;BA.debugLine="Private template2 As String";
main._template2 = RemoteObject.createImmutable("");
 //BA.debugLineNum = 17;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
}