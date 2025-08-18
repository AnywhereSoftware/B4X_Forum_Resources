
package b4a.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class b4xmainpage {
    public static RemoteObject myClass;
	public b4xmainpage() {
	}
    public static PCBA staticBA = new PCBA(null, b4xmainpage.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _root = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _xui = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");
public static RemoteObject _ahviewpager1 = RemoteObject.declareNull("de.amberhome.viewpager.AHViewPager");
public static RemoteObject _wobblemenu1 = RemoteObject.declareNull("b4a.example.wobblemenu");
public static RemoteObject _pagecont = RemoteObject.declareNull("de.amberhome.viewpager.AHPageContainer");
public static b4a.example.main _main = null;
public static b4a.example.starter _starter = null;
public static b4a.example.b4xpages _b4xpages = null;
public static b4a.example.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"AHViewPager1",_ref.getField(false, "_ahviewpager1"),"pagecont",_ref.getField(false, "_pagecont"),"Root",_ref.getField(false, "_root"),"WobbleMenu1",_ref.getField(false, "_wobblemenu1"),"xui",_ref.getField(false, "_xui")};
}
}