
package hr.splitterexample;

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
public static RemoteObject _spldefault = RemoteObject.createImmutable(0);
public static RemoteObject _splleft = RemoteObject.createImmutable(0);
public static RemoteObject _splright = RemoteObject.createImmutable(0);
public static RemoteObject _spltop = RemoteObject.createImmutable(0);
public static RemoteObject _splbottom = RemoteObject.createImmutable(0);
public static RemoteObject _kvs = RemoteObject.declareNull("hr.splitterexample.keyvaluestore");
public static RemoteObject _verticalsplitter = RemoteObject.declareNull("hr.splitterexample.csplitter");
public static RemoteObject _horizontalsplitter = RemoteObject.declareNull("hr.splitterexample.csplitter");
public static hr.splitterexample.main _main = null;
public static hr.splitterexample.b4xpages _b4xpages = null;
public static hr.splitterexample.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"HorizontalSplitter",_ref.getField(false, "_horizontalsplitter"),"KVS",_ref.getField(false, "_kvs"),"Root",_ref.getField(false, "_root"),"splBottom",_ref.getField(false, "_splbottom"),"splDefault",_ref.getField(false, "_spldefault"),"splLeft",_ref.getField(false, "_splleft"),"splRight",_ref.getField(false, "_splright"),"splTop",_ref.getField(false, "_spltop"),"VerticalSplitter",_ref.getField(false, "_verticalsplitter"),"xui",_ref.getField(false, "_xui")};
}
}