package b4j.example;

import anywheresoftware.b4a.debug.*;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.B4AClass;

public class controllerinicio extends B4AClass.ImplB4AClass implements BA.SubDelegator{
    public static java.util.HashMap<String, java.lang.reflect.Method> htSubs;
    private void innerInitialize(BA _ba) throws Exception {
        if (ba == null) {
            ba = new  anywheresoftware.b4a.shell.ShellBA("b4j.example", "b4j.example.controllerinicio", this);
            if (htSubs == null) {
                ba.loadHtSubs(this.getClass());
                htSubs = ba.htSubs;
            }
            ba.htSubs = htSubs;
             
        }
        if (BA.isShellModeRuntimeCheck(ba))
                this.getClass().getMethod("_class_globals", b4j.example.controllerinicio.class).invoke(this, new Object[] {null});
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
public br.com.oaksoftware.easyhtml.pagebuilderhtml _page = null;
public br.com.oaksoftware.easyhtml.easyhtml _container = null;
public br.com.oaksoftware.easyhtml.easyhtml _btn1 = null;
public br.com.oaksoftware.easyhtml.easyhtml _input1 = null;
public br.com.oaksoftware.easyhtml.easyhtml _div1 = null;
public br.com.oaksoftware.easyhtml.easyhtml _h1 = null;
public br.com.oaksoftware.easyhtml.easyhtml _divtasks = null;
public b4j.example.main _main = null;
public String  _class_globals(b4j.example.controllerinicio __ref) throws Exception{
__ref = this;
RDebugUtils.currentModule="controllerinicio";
RDebugUtils.currentLine=1179648;
 //BA.debugLineNum = 1179648;BA.debugLine="Sub Class_Globals";
RDebugUtils.currentLine=1179649;
 //BA.debugLineNum = 1179649;BA.debugLine="Private Page As PageBuilderHTML";
_page = new br.com.oaksoftware.easyhtml.pagebuilderhtml();
RDebugUtils.currentLine=1179651;
 //BA.debugLineNum = 1179651;BA.debugLine="Private Container As EasyHTML";
_container = new br.com.oaksoftware.easyhtml.easyhtml();
RDebugUtils.currentLine=1179652;
 //BA.debugLineNum = 1179652;BA.debugLine="Private Btn1 As EasyHTML";
_btn1 = new br.com.oaksoftware.easyhtml.easyhtml();
RDebugUtils.currentLine=1179653;
 //BA.debugLineNum = 1179653;BA.debugLine="Private Input1 As EasyHTML";
_input1 = new br.com.oaksoftware.easyhtml.easyhtml();
RDebugUtils.currentLine=1179654;
 //BA.debugLineNum = 1179654;BA.debugLine="Private Div1 As EasyHTML";
_div1 = new br.com.oaksoftware.easyhtml.easyhtml();
RDebugUtils.currentLine=1179655;
 //BA.debugLineNum = 1179655;BA.debugLine="Private H1 As EasyHTML";
_h1 = new br.com.oaksoftware.easyhtml.easyhtml();
RDebugUtils.currentLine=1179656;
 //BA.debugLineNum = 1179656;BA.debugLine="Private DivTasks As EasyHTML";
_divtasks = new br.com.oaksoftware.easyhtml.easyhtml();
RDebugUtils.currentLine=1179657;
 //BA.debugLineNum = 1179657;BA.debugLine="End Sub";
return "";
}
public String  _handle(b4j.example.controllerinicio __ref,anywheresoftware.b4j.object.JServlet.ServletRequestWrapper _req,anywheresoftware.b4j.object.JServlet.ServletResponseWrapper _resp) throws Exception{
__ref = this;
RDebugUtils.currentModule="controllerinicio";
if (Debug.shouldDelegate(ba, "handle", false))
	 {return ((String) Debug.delegate(ba, "handle", new Object[] {_req,_resp}));}
RDebugUtils.currentLine=1310720;
 //BA.debugLineNum = 1310720;BA.debugLine="Sub Handle(req As ServletRequest, resp As ServletR";
RDebugUtils.currentLine=1310722;
 //BA.debugLineNum = 1310722;BA.debugLine="Container.Initialize(\"main\").AddClass(\"container\"";
__ref._container /*br.com.oaksoftware.easyhtml.easyhtml*/ ._initialize(ba,"main")._addclass("container");
RDebugUtils.currentLine=1310724;
 //BA.debugLineNum = 1310724;BA.debugLine="Div1.Initialize(\"div\")";
__ref._div1 /*br.com.oaksoftware.easyhtml.easyhtml*/ ._initialize(ba,"div");
RDebugUtils.currentLine=1310726;
 //BA.debugLineNum = 1310726;BA.debugLine="H1.Initialize(\"h1\").AddElement(\"To-Do App\")";
__ref._h1 /*br.com.oaksoftware.easyhtml.easyhtml*/ ._initialize(ba,"h1")._addelement("To-Do App");
RDebugUtils.currentLine=1310728;
 //BA.debugLineNum = 1310728;BA.debugLine="Input1.Initialize(\"input\").AddId(\"task\").AddAttri";
__ref._input1 /*br.com.oaksoftware.easyhtml.easyhtml*/ ._initialize(ba,"input")._addid("task")._addattribute("name","task")._addattribute("placeholder","Type here...");
RDebugUtils.currentLine=1310730;
 //BA.debugLineNum = 1310730;BA.debugLine="Btn1.Initialize(\"button\").AddId(\"btn1\").AddElemen";
__ref._btn1 /*br.com.oaksoftware.easyhtml.easyhtml*/ ._initialize(ba,"button")._addid("btn1")._addelement("Add task")._hx_target("#divTasks")._hx_include("[name='task'], [name='task2']")._hx_post("/add")._addattribute("hx-encoding","application/json");
RDebugUtils.currentLine=1310733;
 //BA.debugLineNum = 1310733;BA.debugLine="DivTasks.Initialize(\"div\").AddId(\"divTasks\").HX_T";
__ref._divtasks /*br.com.oaksoftware.easyhtml.easyhtml*/ ._initialize(ba,"div")._addid("divTasks")._hx_target("this")._hx_get("/get")._hx_trigger("load")._hx_swap("innerHTML");
RDebugUtils.currentLine=1310735;
 //BA.debugLineNum = 1310735;BA.debugLine="Div1.AddElement(H1.Mount)";
__ref._div1 /*br.com.oaksoftware.easyhtml.easyhtml*/ ._addelement(__ref._h1 /*br.com.oaksoftware.easyhtml.easyhtml*/ ._mount());
RDebugUtils.currentLine=1310736;
 //BA.debugLineNum = 1310736;BA.debugLine="Div1.AddElement(Input1.Mount)";
__ref._div1 /*br.com.oaksoftware.easyhtml.easyhtml*/ ._addelement(__ref._input1 /*br.com.oaksoftware.easyhtml.easyhtml*/ ._mount());
RDebugUtils.currentLine=1310737;
 //BA.debugLineNum = 1310737;BA.debugLine="Div1.AddElement(Btn1.Mount)";
__ref._div1 /*br.com.oaksoftware.easyhtml.easyhtml*/ ._addelement(__ref._btn1 /*br.com.oaksoftware.easyhtml.easyhtml*/ ._mount());
RDebugUtils.currentLine=1310738;
 //BA.debugLineNum = 1310738;BA.debugLine="Div1.AddElement(DivTasks.Mount)";
__ref._div1 /*br.com.oaksoftware.easyhtml.easyhtml*/ ._addelement(__ref._divtasks /*br.com.oaksoftware.easyhtml.easyhtml*/ ._mount());
RDebugUtils.currentLine=1310740;
 //BA.debugLineNum = 1310740;BA.debugLine="Container.AddElement(Div1.Mount)";
__ref._container /*br.com.oaksoftware.easyhtml.easyhtml*/ ._addelement(__ref._div1 /*br.com.oaksoftware.easyhtml.easyhtml*/ ._mount());
RDebugUtils.currentLine=1310742;
 //BA.debugLineNum = 1310742;BA.debugLine="Page.Initialize";
__ref._page /*br.com.oaksoftware.easyhtml.pagebuilderhtml*/ ._initialize(ba);
RDebugUtils.currentLine=1310743;
 //BA.debugLineNum = 1310743;BA.debugLine="Page.SetPathHTMLX(\"/js/htmlx.min.js\")";
__ref._page /*br.com.oaksoftware.easyhtml.pagebuilderhtml*/ ._setpathhtmlx("/js/htmlx.min.js");
RDebugUtils.currentLine=1310744;
 //BA.debugLineNum = 1310744;BA.debugLine="Page.AddStyle(\"https://cdn.jsdelivr.net/npm/@pico";
__ref._page /*br.com.oaksoftware.easyhtml.pagebuilderhtml*/ ._addstyle("https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css");
RDebugUtils.currentLine=1310745;
 //BA.debugLineNum = 1310745;BA.debugLine="Page.AddElement(Container.Mount)";
__ref._page /*br.com.oaksoftware.easyhtml.pagebuilderhtml*/ ._addelement(__ref._container /*br.com.oaksoftware.easyhtml.easyhtml*/ ._mount());
RDebugUtils.currentLine=1310747;
 //BA.debugLineNum = 1310747;BA.debugLine="resp.Write(Page.Mount)";
_resp.Write(__ref._page /*br.com.oaksoftware.easyhtml.pagebuilderhtml*/ ._mount());
RDebugUtils.currentLine=1310749;
 //BA.debugLineNum = 1310749;BA.debugLine="End Sub";
return "";
}
public String  _initialize(b4j.example.controllerinicio __ref,anywheresoftware.b4a.BA _ba) throws Exception{
__ref = this;
innerInitialize(_ba);
RDebugUtils.currentModule="controllerinicio";
if (Debug.shouldDelegate(ba, "initialize", false))
	 {return ((String) Debug.delegate(ba, "initialize", new Object[] {_ba}));}
RDebugUtils.currentLine=1245184;
 //BA.debugLineNum = 1245184;BA.debugLine="Public Sub Initialize";
RDebugUtils.currentLine=1245186;
 //BA.debugLineNum = 1245186;BA.debugLine="End Sub";
return "";
}
}