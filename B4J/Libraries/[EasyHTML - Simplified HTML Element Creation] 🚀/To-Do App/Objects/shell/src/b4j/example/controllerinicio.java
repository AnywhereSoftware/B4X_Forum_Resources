
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class controllerinicio {
    public static RemoteObject myClass;
	public controllerinicio() {
	}
    public static PCBA staticBA = new PCBA(null, controllerinicio.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _page = RemoteObject.declareNull("br.com.oaksoftware.easyhtml.pagebuilderhtml");
public static RemoteObject _container = RemoteObject.declareNull("br.com.oaksoftware.easyhtml.easyhtml");
public static RemoteObject _btn1 = RemoteObject.declareNull("br.com.oaksoftware.easyhtml.easyhtml");
public static RemoteObject _input1 = RemoteObject.declareNull("br.com.oaksoftware.easyhtml.easyhtml");
public static RemoteObject _div1 = RemoteObject.declareNull("br.com.oaksoftware.easyhtml.easyhtml");
public static RemoteObject _h1 = RemoteObject.declareNull("br.com.oaksoftware.easyhtml.easyhtml");
public static RemoteObject _divtasks = RemoteObject.declareNull("br.com.oaksoftware.easyhtml.easyhtml");
public static b4j.example.main _main = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"Btn1",_ref.getField(false, "_btn1"),"Container",_ref.getField(false, "_container"),"Div1",_ref.getField(false, "_div1"),"DivTasks",_ref.getField(false, "_divtasks"),"H1",_ref.getField(false, "_h1"),"Input1",_ref.getField(false, "_input1"),"Page",_ref.getField(false, "_page")};
}
}