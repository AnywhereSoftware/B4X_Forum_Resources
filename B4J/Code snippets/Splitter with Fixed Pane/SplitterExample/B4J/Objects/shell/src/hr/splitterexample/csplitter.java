
package hr.splitterexample;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class csplitter {
    public static RemoteObject myClass;
	public csplitter() {
	}
    public static PCBA staticBA = new PCBA(null, csplitter.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _fx = RemoteObject.declareNull("anywheresoftware.b4j.objects.JFX");
public static RemoteObject _xui = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");
public static RemoteObject _spldefault = RemoteObject.createImmutable(0);
public static RemoteObject _splleft = RemoteObject.createImmutable(0);
public static RemoteObject _splright = RemoteObject.createImmutable(0);
public static RemoteObject _spltop = RemoteObject.createImmutable(0);
public static RemoteObject _splbottom = RemoteObject.createImmutable(0);
public static RemoteObject _optkey = RemoteObject.createImmutable("");
public static RemoteObject _fsplittertype = RemoteObject.createImmutable(0);
public static RemoteObject _fminfixedsize = RemoteObject.createImmutable(0);
public static RemoteObject _fminflexsize = RemoteObject.createImmutable(0);
public static RemoteObject _sizing = RemoteObject.createImmutable(false);
public static RemoteObject _parent = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _panbase = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _fixedpanel = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _flexpanel = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _sizer = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static hr.splitterexample.main _main = null;
public static hr.splitterexample.b4xpages _b4xpages = null;
public static hr.splitterexample.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"FixedPanel",_ref.getField(false, "_fixedpanel"),"FlexPanel",_ref.getField(false, "_flexpanel"),"FMinFixedSize",_ref.getField(false, "_fminfixedsize"),"FMinFlexSize",_ref.getField(false, "_fminflexsize"),"FSplitterType",_ref.getField(false, "_fsplittertype"),"fx",_ref.getField(false, "_fx"),"OptKey",_ref.getField(false, "_optkey"),"panBase",_ref.getField(false, "_panbase"),"Parent",_ref.getField(false, "_parent"),"Sizer",_ref.getField(false, "_sizer"),"Sizing",_ref.getField(false, "_sizing"),"splBottom",_ref.getField(false, "_splbottom"),"splDefault",_ref.getField(false, "_spldefault"),"splLeft",_ref.getField(false, "_splleft"),"splRight",_ref.getField(false, "_splright"),"splTop",_ref.getField(false, "_spltop"),"xui",_ref.getField(false, "_xui")};
}
}