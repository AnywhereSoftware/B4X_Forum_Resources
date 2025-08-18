
package b4a.example;

import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RemoteObject;

public class wobblemenu {
    public static RemoteObject myClass;
	public wobblemenu() {
	}
    public static PCBA staticBA = new PCBA(null, wobblemenu.class);

public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _meventname = RemoteObject.createImmutable("");
public static RemoteObject _mcallback = RemoteObject.declareNull("Object");
public static RemoteObject _mbase = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _xui = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper.XUI");
public static RemoteObject _backgroundcolor = RemoteObject.createImmutable(0);
public static RemoteObject _iconcolor = RemoteObject.createImmutable(0);
public static RemoteObject _iconsize = RemoteObject.createImmutable(0);
public static RemoteObject _textcolor = RemoteObject.createImmutable(0);
public static RemoteObject _textsize = RemoteObject.createImmutable(0);
public static RemoteObject _selectediconcolor = RemoteObject.createImmutable(0);
public static RemoteObject _circleradius = RemoteObject.createImmutable(0);
public static RemoteObject _animduration = RemoteObject.createImmutable(0);
public static RemoteObject _tabcontainer = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _tabcurve = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _tabcircle = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _tab1 = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _tab2 = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _tab3 = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _tab4 = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _tab5 = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static RemoteObject _tabs = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static RemoteObject _iconlist = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static RemoteObject _menuheight = RemoteObject.createImmutable(0);
public static RemoteObject _absolutewidth = RemoteObject.createImmutable(0);
public static RemoteObject _tabcount = RemoteObject.createImmutable(0);
public static RemoteObject _currenttab = RemoteObject.createImmutable(0);
public static RemoteObject _animation_type_elastic_out = RemoteObject.createImmutable(0);
public static RemoteObject _animation_type_elastic_in = RemoteObject.createImmutable(0);
public static RemoteObject _animation_type_ease_out = RemoteObject.createImmutable(0);
public static RemoteObject _animation_type_ease_in = RemoteObject.createImmutable(0);
public static RemoteObject _animation_type_none = RemoteObject.createImmutable(0);
public static RemoteObject _animationtype = RemoteObject.createImmutable(0);
public static RemoteObject _icon_appear_from_center = RemoteObject.createImmutable(0);
public static RemoteObject _icon_appear_from_edge = RemoteObject.createImmutable(0);
public static RemoteObject _icon_appear_fade_in = RemoteObject.createImmutable(0);
public static RemoteObject _icon_appear_no_animation = RemoteObject.createImmutable(0);
public static RemoteObject _iconappearstyle = RemoteObject.createImmutable(0);
public static RemoteObject _shadowcolor = RemoteObject.createImmutable("");
public static RemoteObject _badge = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static RemoteObject _enabled = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
public static RemoteObject _designerlbl = RemoteObject.declareNull("anywheresoftware.b4a.objects.B4XViewWrapper");
public static b4a.example.main _main = null;
public static b4a.example.starter _starter = null;
public static b4a.example.b4xpages _b4xpages = null;
public static b4a.example.b4xcollections _b4xcollections = null;
public static Object[] GetGlobals(RemoteObject _ref) throws Exception {
		return new Object[] {"AbsoluteWidth",_ref.getField(false, "_absolutewidth"),"ANIMATION_TYPE_EASE_IN",_ref.getField(false, "_animation_type_ease_in"),"ANIMATION_TYPE_EASE_OUT",_ref.getField(false, "_animation_type_ease_out"),"ANIMATION_TYPE_ELASTIC_IN",_ref.getField(false, "_animation_type_elastic_in"),"ANIMATION_TYPE_ELASTIC_OUT",_ref.getField(false, "_animation_type_elastic_out"),"ANIMATION_TYPE_NONE",_ref.getField(false, "_animation_type_none"),"AnimationType",_ref.getField(false, "_animationtype"),"animDuration",_ref.getField(false, "_animduration"),"BackgroundColor",_ref.getField(false, "_backgroundcolor"),"badge",_ref.getField(false, "_badge"),"circleRadius",_ref.getField(false, "_circleradius"),"CurrentTab",_ref.getField(false, "_currenttab"),"designerLbl",_ref.getField(false, "_designerlbl"),"enabled",_ref.getField(false, "_enabled"),"ICON_APPEAR_FADE_IN",_ref.getField(false, "_icon_appear_fade_in"),"ICON_APPEAR_FROM_CENTER",_ref.getField(false, "_icon_appear_from_center"),"ICON_APPEAR_FROM_EDGE",_ref.getField(false, "_icon_appear_from_edge"),"ICON_APPEAR_NO_ANIMATION",_ref.getField(false, "_icon_appear_no_animation"),"IconAppearStyle",_ref.getField(false, "_iconappearstyle"),"IconColor",_ref.getField(false, "_iconcolor"),"IconList",_ref.getField(false, "_iconlist"),"IconSize",_ref.getField(false, "_iconsize"),"mBase",_ref.getField(false, "_mbase"),"mCallBack",_ref.getField(false, "_mcallback"),"MenuHeight",_ref.getField(false, "_menuheight"),"mEventName",_ref.getField(false, "_meventname"),"SelectedIconColor",_ref.getField(false, "_selectediconcolor"),"ShadowColor",_ref.getField(false, "_shadowcolor"),"Tab1",_ref.getField(false, "_tab1"),"Tab2",_ref.getField(false, "_tab2"),"Tab3",_ref.getField(false, "_tab3"),"Tab4",_ref.getField(false, "_tab4"),"Tab5",_ref.getField(false, "_tab5"),"TabCircle",_ref.getField(false, "_tabcircle"),"TabContainer",_ref.getField(false, "_tabcontainer"),"TabCount",_ref.getField(false, "_tabcount"),"TabCurve",_ref.getField(false, "_tabcurve"),"Tabs",_ref.getField(false, "_tabs"),"TextColor",_ref.getField(false, "_textcolor"),"TextSize",_ref.getField(false, "_textsize"),"xui",_ref.getField(false, "_xui")};
}
}