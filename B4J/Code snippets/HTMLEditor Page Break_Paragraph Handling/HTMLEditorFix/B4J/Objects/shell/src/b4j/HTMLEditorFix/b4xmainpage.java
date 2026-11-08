
package b4j.HTMLEditorFix;

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
public static RemoteObject _robot = RemoteObject.declareNull("butt.droid.awtRobot.AWTRobot");
public static RemoteObject _edhtml = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _jckeyevt = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
public static RemoteObject _jokeyevtkeypressed = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
public static RemoteObject _jokeyevtkeyreleased = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
public static RemoteObject _jokeyevtkeytyped = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
public static RemoteObject _crcoming = RemoteObject.createImmutable(false);
public static RemoteObject _delneeded = RemoteObject.createImmutable(false);
public static b4j.HTMLEditorFix.main _main = null;
public static b4j.HTMLEditorFix.b4xpages _b4xpages = null;
public static b4j.HTMLEditorFix.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"CRComing",_ref.getField(false, "_crcoming"),"DelNeeded",_ref.getField(false, "_delneeded"),"edHTML",_ref.getField(false, "_edhtml"),"jcKeyEvt",_ref.getField(false, "_jckeyevt"),"joKeyEvtKeyPressed",_ref.getField(false, "_jokeyevtkeypressed"),"joKeyEvtKeyReleased",_ref.getField(false, "_jokeyevtkeyreleased"),"joKeyEvtKeyTyped",_ref.getField(false, "_jokeyevtkeytyped"),"Robot",_ref.getField(false, "_robot"),"Root",_ref.getField(false, "_root"),"xui",_ref.getField(false, "_xui")};
}
}