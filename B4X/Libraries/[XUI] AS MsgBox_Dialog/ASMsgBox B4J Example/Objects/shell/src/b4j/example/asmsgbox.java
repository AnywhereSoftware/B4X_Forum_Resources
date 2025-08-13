
package b4j.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class asmsgbox {
    public static RemoteObject myClass;
	public asmsgbox() {
	}
    public static PCBA staticBA = new PCBA(null, asmsgbox.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _meventname = RemoteObject.createImmutable("");
public static RemoteObject _mcallback = RemoteObject.declareNull("Object");
public static RemoteObject _mbase = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
public static RemoteObject _xui = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper.XUI");
public static RemoteObject _back_color = RemoteObject.createImmutable(0);
public static RemoteObject _showx = RemoteObject.createImmutable(false);
public static RemoteObject _header_clr = RemoteObject.createImmutable(0);
public static RemoteObject _bottom_crl = RemoteObject.createImmutable(0);
public static RemoteObject _iconvisible = RemoteObject.createImmutable(false);
public static RemoteObject _icondirection = RemoteObject.createImmutable("");
public static RemoteObject _border_width = RemoteObject.createImmutable(0);
public static RemoteObject _showheader = RemoteObject.createImmutable(false);
public static RemoteObject _showbottom = RemoteObject.createImmutable(false);
public static RemoteObject _headerfontsize = RemoteObject.createImmutable(0);
public static RemoteObject _headertext = RemoteObject.createImmutable("");
public static RemoteObject _xpnl_close = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
public static RemoteObject _xline_1 = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
public static RemoteObject _xline_2 = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
public static RemoteObject _xiconfont = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper.B4XFont");
public static RemoteObject _fx = RemoteObject.declareNull("anywheresoftware.b4j.objects.JFX");
public static RemoteObject _lbl_header = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
public static RemoteObject _xlbl_header = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
public static RemoteObject _xpnl_header = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
public static RemoteObject _xpnl_bottom = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
public static RemoteObject _xiv_icon = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
public static RemoteObject _xpnl_content = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
public static RemoteObject _xlbl_action_1 = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
public static RemoteObject _xlbl_action_2 = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
public static RemoteObject _xlbl_action_3 = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
public static RemoteObject _xpnl_actionground = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
public static RemoteObject _xlbl_text = RemoteObject.declareNull("anywheresoftware.b4j.objects.B4XViewWrapper");
public static RemoteObject _dragable = RemoteObject.createImmutable(0);
public static RemoteObject _donwx = RemoteObject.createImmutable(0);
public static RemoteObject _downy = RemoteObject.createImmutable(0);
public static b4j.example.main _main = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"back_color",_ref.getField(false, "_back_color"),"border_width",_ref.getField(false, "_border_width"),"bottom_crl",_ref.getField(false, "_bottom_crl"),"donwx",_ref.getField(false, "_donwx"),"downy",_ref.getField(false, "_downy"),"dragable",_ref.getField(false, "_dragable"),"fx",_ref.getField(false, "_fx"),"header_clr",_ref.getField(false, "_header_clr"),"headerFontSize",_ref.getField(false, "_headerfontsize"),"headerText",_ref.getField(false, "_headertext"),"iconDirection",_ref.getField(false, "_icondirection"),"iconVisible",_ref.getField(false, "_iconvisible"),"lbl_header",_ref.getField(false, "_lbl_header"),"mBase",_ref.getField(false, "_mbase"),"mCallBack",_ref.getField(false, "_mcallback"),"mEventName",_ref.getField(false, "_meventname"),"showBottom",_ref.getField(false, "_showbottom"),"showHeader",_ref.getField(false, "_showheader"),"showX",_ref.getField(false, "_showx"),"xIconFont",_ref.getField(false, "_xiconfont"),"xiv_icon",_ref.getField(false, "_xiv_icon"),"xlbl_action_1",_ref.getField(false, "_xlbl_action_1"),"xlbl_action_2",_ref.getField(false, "_xlbl_action_2"),"xlbl_action_3",_ref.getField(false, "_xlbl_action_3"),"xlbl_header",_ref.getField(false, "_xlbl_header"),"xlbl_text",_ref.getField(false, "_xlbl_text"),"xline_1",_ref.getField(false, "_xline_1"),"xline_2",_ref.getField(false, "_xline_2"),"xpnl_actionground",_ref.getField(false, "_xpnl_actionground"),"xpnl_bottom",_ref.getField(false, "_xpnl_bottom"),"xpnl_close",_ref.getField(false, "_xpnl_close"),"xpnl_content",_ref.getField(false, "_xpnl_content"),"xpnl_header",_ref.getField(false, "_xpnl_header"),"xui",_ref.getField(false, "_xui")};
}
}