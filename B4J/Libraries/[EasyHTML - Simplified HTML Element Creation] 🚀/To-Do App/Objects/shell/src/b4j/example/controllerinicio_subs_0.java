package b4j.example;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class controllerinicio_subs_0 {


public static RemoteObject  _class_globals(RemoteObject __ref) throws Exception{
 //BA.debugLineNum = 2;BA.debugLine="Sub Class_Globals";
 //BA.debugLineNum = 3;BA.debugLine="Private Page As PageBuilderHTML";
controllerinicio._page = RemoteObject.createNew ("br.com.oaksoftware.easyhtml.pagebuilderhtml");__ref.setField("_page",controllerinicio._page);
 //BA.debugLineNum = 5;BA.debugLine="Private Container As EasyHTML";
controllerinicio._container = RemoteObject.createNew ("br.com.oaksoftware.easyhtml.easyhtml");__ref.setField("_container",controllerinicio._container);
 //BA.debugLineNum = 6;BA.debugLine="Private Btn1 As EasyHTML";
controllerinicio._btn1 = RemoteObject.createNew ("br.com.oaksoftware.easyhtml.easyhtml");__ref.setField("_btn1",controllerinicio._btn1);
 //BA.debugLineNum = 7;BA.debugLine="Private Input1 As EasyHTML";
controllerinicio._input1 = RemoteObject.createNew ("br.com.oaksoftware.easyhtml.easyhtml");__ref.setField("_input1",controllerinicio._input1);
 //BA.debugLineNum = 8;BA.debugLine="Private Div1 As EasyHTML";
controllerinicio._div1 = RemoteObject.createNew ("br.com.oaksoftware.easyhtml.easyhtml");__ref.setField("_div1",controllerinicio._div1);
 //BA.debugLineNum = 9;BA.debugLine="Private H1 As EasyHTML";
controllerinicio._h1 = RemoteObject.createNew ("br.com.oaksoftware.easyhtml.easyhtml");__ref.setField("_h1",controllerinicio._h1);
 //BA.debugLineNum = 10;BA.debugLine="Private DivTasks As EasyHTML";
controllerinicio._divtasks = RemoteObject.createNew ("br.com.oaksoftware.easyhtml.easyhtml");__ref.setField("_divtasks",controllerinicio._divtasks);
 //BA.debugLineNum = 11;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _handle(RemoteObject __ref,RemoteObject _req,RemoteObject _resp) throws Exception{
try {
		Debug.PushSubsStack("Handle (controllerinicio) ","controllerinicio",1,__ref.getField(false, "ba"),__ref,17);
if (RapidSub.canDelegate("handle")) { return __ref.runUserSub(false, "controllerinicio","handle", __ref, _req, _resp);}
Debug.locals.put("req", _req);
Debug.locals.put("resp", _resp);
 BA.debugLineNum = 17;BA.debugLine="Sub Handle(req As ServletRequest, resp As ServletR";
Debug.ShouldStop(65536);
 BA.debugLineNum = 19;BA.debugLine="Container.Initialize(\"main\").AddClass(\"container\"";
Debug.ShouldStop(262144);
__ref.getField(false,"_container" /*RemoteObject*/ ).runMethod(false,"_initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("main"))).runVoidMethod ("_addclass",(Object)(RemoteObject.createImmutable("container")));
 BA.debugLineNum = 21;BA.debugLine="Div1.Initialize(\"div\")";
Debug.ShouldStop(1048576);
__ref.getField(false,"_div1" /*RemoteObject*/ ).runVoidMethod ("_initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("div")));
 BA.debugLineNum = 23;BA.debugLine="H1.Initialize(\"h1\").AddElement(\"To-Do App\")";
Debug.ShouldStop(4194304);
__ref.getField(false,"_h1" /*RemoteObject*/ ).runMethod(false,"_initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("h1"))).runVoidMethod ("_addelement",(Object)(RemoteObject.createImmutable("To-Do App")));
 BA.debugLineNum = 25;BA.debugLine="Input1.Initialize(\"input\").AddId(\"task\").AddAttri";
Debug.ShouldStop(16777216);
__ref.getField(false,"_input1" /*RemoteObject*/ ).runMethod(false,"_initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("input"))).runMethod(false,"_addid",(Object)(RemoteObject.createImmutable("task"))).runMethod(false,"_addattribute",(Object)(BA.ObjectToString("name")),(Object)(RemoteObject.createImmutable("task"))).runVoidMethod ("_addattribute",(Object)(BA.ObjectToString("placeholder")),(Object)(RemoteObject.createImmutable("Type here...")));
 BA.debugLineNum = 27;BA.debugLine="Btn1.Initialize(\"button\").AddId(\"btn1\").AddElemen";
Debug.ShouldStop(67108864);
__ref.getField(false,"_btn1" /*RemoteObject*/ ).runMethod(false,"_initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("button"))).runMethod(false,"_addid",(Object)(RemoteObject.createImmutable("btn1"))).runMethod(false,"_addelement",(Object)(RemoteObject.createImmutable("Add task"))).runMethod(false,"_hx_target",(Object)(RemoteObject.createImmutable("#divTasks"))).runMethod(false,"_hx_include",(Object)(RemoteObject.createImmutable("[name='task'], [name='task2']"))).runMethod(false,"_hx_post",(Object)(RemoteObject.createImmutable("/add"))).runVoidMethod ("_addattribute",(Object)(BA.ObjectToString("hx-encoding")),(Object)(RemoteObject.createImmutable("application/json")));
 BA.debugLineNum = 30;BA.debugLine="DivTasks.Initialize(\"div\").AddId(\"divTasks\").HX_T";
Debug.ShouldStop(536870912);
__ref.getField(false,"_divtasks" /*RemoteObject*/ ).runMethod(false,"_initialize",__ref.getField(false, "ba"),(Object)(RemoteObject.createImmutable("div"))).runMethod(false,"_addid",(Object)(RemoteObject.createImmutable("divTasks"))).runMethod(false,"_hx_target",(Object)(RemoteObject.createImmutable("this"))).runMethod(false,"_hx_get",(Object)(RemoteObject.createImmutable("/get"))).runMethod(false,"_hx_trigger",(Object)(RemoteObject.createImmutable("load"))).runVoidMethod ("_hx_swap",(Object)(RemoteObject.createImmutable("innerHTML")));
 BA.debugLineNum = 32;BA.debugLine="Div1.AddElement(H1.Mount)";
Debug.ShouldStop(-2147483648);
__ref.getField(false,"_div1" /*RemoteObject*/ ).runVoidMethod ("_addelement",(Object)(__ref.getField(false,"_h1" /*RemoteObject*/ ).runMethod(true,"_mount")));
 BA.debugLineNum = 33;BA.debugLine="Div1.AddElement(Input1.Mount)";
Debug.ShouldStop(1);
__ref.getField(false,"_div1" /*RemoteObject*/ ).runVoidMethod ("_addelement",(Object)(__ref.getField(false,"_input1" /*RemoteObject*/ ).runMethod(true,"_mount")));
 BA.debugLineNum = 34;BA.debugLine="Div1.AddElement(Btn1.Mount)";
Debug.ShouldStop(2);
__ref.getField(false,"_div1" /*RemoteObject*/ ).runVoidMethod ("_addelement",(Object)(__ref.getField(false,"_btn1" /*RemoteObject*/ ).runMethod(true,"_mount")));
 BA.debugLineNum = 35;BA.debugLine="Div1.AddElement(DivTasks.Mount)";
Debug.ShouldStop(4);
__ref.getField(false,"_div1" /*RemoteObject*/ ).runVoidMethod ("_addelement",(Object)(__ref.getField(false,"_divtasks" /*RemoteObject*/ ).runMethod(true,"_mount")));
 BA.debugLineNum = 37;BA.debugLine="Container.AddElement(Div1.Mount)";
Debug.ShouldStop(16);
__ref.getField(false,"_container" /*RemoteObject*/ ).runVoidMethod ("_addelement",(Object)(__ref.getField(false,"_div1" /*RemoteObject*/ ).runMethod(true,"_mount")));
 BA.debugLineNum = 39;BA.debugLine="Page.Initialize";
Debug.ShouldStop(64);
__ref.getField(false,"_page" /*RemoteObject*/ ).runVoidMethod ("_initialize",__ref.getField(false, "ba"));
 BA.debugLineNum = 40;BA.debugLine="Page.SetPathHTMLX(\"/js/htmlx.min.js\")";
Debug.ShouldStop(128);
__ref.getField(false,"_page" /*RemoteObject*/ ).runVoidMethod ("_setpathhtmlx",(Object)(RemoteObject.createImmutable("/js/htmlx.min.js")));
 BA.debugLineNum = 41;BA.debugLine="Page.AddStyle(\"https://cdn.jsdelivr.net/npm/@pico";
Debug.ShouldStop(256);
__ref.getField(false,"_page" /*RemoteObject*/ ).runVoidMethod ("_addstyle",(Object)(RemoteObject.createImmutable("https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css")));
 BA.debugLineNum = 42;BA.debugLine="Page.AddElement(Container.Mount)";
Debug.ShouldStop(512);
__ref.getField(false,"_page" /*RemoteObject*/ ).runVoidMethod ("_addelement",(Object)(__ref.getField(false,"_container" /*RemoteObject*/ ).runMethod(true,"_mount")));
 BA.debugLineNum = 44;BA.debugLine="resp.Write(Page.Mount)";
Debug.ShouldStop(2048);
_resp.runVoidMethod ("Write",(Object)(__ref.getField(false,"_page" /*RemoteObject*/ ).runMethod(true,"_mount")));
 BA.debugLineNum = 46;BA.debugLine="End Sub";
Debug.ShouldStop(8192);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _initialize(RemoteObject __ref,RemoteObject _ba) throws Exception{
try {
		Debug.PushSubsStack("Initialize (controllerinicio) ","controllerinicio",1,__ref.getField(false, "ba"),__ref,13);
if (RapidSub.canDelegate("initialize")) { return __ref.runUserSub(false, "controllerinicio","initialize", __ref, _ba);}
__ref.runVoidMethodAndSync("innerInitializeHelper", _ba);
Debug.locals.put("ba", _ba);
 BA.debugLineNum = 13;BA.debugLine="Public Sub Initialize";
Debug.ShouldStop(4096);
 BA.debugLineNum = 15;BA.debugLine="End Sub";
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