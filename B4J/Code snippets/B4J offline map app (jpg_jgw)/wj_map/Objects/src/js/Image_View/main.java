package js.Image_View;


import anywheresoftware.b4a.BA;

public class main extends javafx.application.Application{
public static main mostCurrent = new main();

public static BA ba;
static {
		ba = new  anywheresoftware.b4j.objects.FxBA("js.Image_View", "js.Image_View.main", null);
		ba.loadHtSubs(main.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			
			ba.raiseEvent2(null, true, "SHELL", false);
			ba.raiseEvent2(null, true, "CREATE", true, "js.Image_View.main", ba);
		}
	}
    public static Class<?> getObject() {
		return main.class;
	}

 
    public static void main(String[] args) {
    	launch(args);
    }
    public void start (javafx.stage.Stage stage) {
        try {
            if (!false)
                System.setProperty("prism.lcdtext", "false");
            anywheresoftware.b4j.objects.FxBA.application = this;
		    anywheresoftware.b4a.keywords.Common.setDensity(javafx.stage.Screen.getPrimary().getDpi());
            anywheresoftware.b4a.keywords.Common.LogDebug("Program started.");
            initializeProcessGlobals();
            anywheresoftware.b4j.objects.Form frm = new anywheresoftware.b4j.objects.Form();
            frm.initWithStage(ba, stage, 600, 600);
            ba.raiseEvent(null, "appstart", frm, (String[])getParameters().getRaw().toArray(new String[0]));
        } catch (Throwable t) {
            BA.printException(t, true);
            System.exit(1);
        }
    }
public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4j.objects.JFX _fx = null;
public static anywheresoftware.b4j.objects.Form _mainform = null;
public static anywheresoftware.b4j.objects.ImageViewWrapper _imageview1 = null;
public static anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper _p_map = null;
public static int _startleft = 0;
public static int _starttop = 0;
public static int _startx = 0;
public static int _starty = 0;
public static anywheresoftware.b4j.objects.LabelWrapper _l_sob_pix = null;
public static anywheresoftware.b4j.objects.LabelWrapper _l_vob_pix = null;
public static anywheresoftware.b4j.objects.LabelWrapper _l_xsur_pix = null;
public static anywheresoftware.b4j.objects.LabelWrapper _l_ysur_pix = null;
public static anywheresoftware.b4j.objects.LabelWrapper _l_zoom = null;
public static float _c_zoom = 0f;
public static float _sob_pix = 0f;
public static anywheresoftware.b4j.objects.CanvasWrapper _canvas1 = null;
public static anywheresoftware.b4j.objects.LabelWrapper _lbllat = null;
public static anywheresoftware.b4j.objects.LabelWrapper _lbllon = null;
public static double _xobr = 0;
public static double _yobr = 0;
public static double _xpixsize = 0;
public static double _ypixsize = 0;
public static double _xcoor = 0;
public static double _ycoor = 0;
public static double _pix_lat = 0;
public static double _pix_lon = 0;
public static double _kde_lat_pix = 0;
public static double _kde_lon_pix = 0;
public static anywheresoftware.b4a.objects.collections.List _list1b = null;
public static boolean  _application_error(anywheresoftware.b4a.objects.B4AException _error,String _stacktrace) throws Exception{
 //BA.debugLineNum = 48;BA.debugLine="Sub Application_Error (Error As Exception, StackTr";
 //BA.debugLineNum = 49;BA.debugLine="Return True";
if (true) return anywheresoftware.b4a.keywords.Common.True;
 //BA.debugLineNum = 50;BA.debugLine="End Sub";
return false;
}
public static String  _appstart(anywheresoftware.b4j.objects.Form _form1,String[] _args) throws Exception{
anywheresoftware.b4j.object.JavaObject _jo = null;
anywheresoftware.b4j.object.JavaObject _scrollevent = null;
 //BA.debugLineNum = 38;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
 //BA.debugLineNum = 39;BA.debugLine="MainForm = Form1";
_mainform = _form1;
 //BA.debugLineNum = 40;BA.debugLine="MainForm.RootPane.LoadLayout(\"Layout1\")";
_mainform.getRootPane().LoadLayout(ba,"Layout1");
 //BA.debugLineNum = 41;BA.debugLine="MainForm.Show";
_mainform.Show();
 //BA.debugLineNum = 43;BA.debugLine="Dim jo As JavaObject = P_map";
_jo = new anywheresoftware.b4j.object.JavaObject();
_jo = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_p_map.getObject()));
 //BA.debugLineNum = 44;BA.debugLine="Dim ScrollEvent As JavaObject = jo.CreateEventFro";
_scrollevent = new anywheresoftware.b4j.object.JavaObject();
_scrollevent = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_jo.CreateEventFromUI(ba,"javafx.event.EventHandler","ScrollChanged",anywheresoftware.b4a.keywords.Common.Null)));
 //BA.debugLineNum = 45;BA.debugLine="jo.RunMethod(\"setOnScroll\", Array(ScrollEvent))";
_jo.RunMethod("setOnScroll",new Object[]{(Object)(_scrollevent.getObject())});
 //BA.debugLineNum = 46;BA.debugLine="End Sub";
return "";
}
public static String  _button1_click() throws Exception{
anywheresoftware.b4j.objects.ImageViewWrapper.ImageWrapper _bmp = null;
anywheresoftware.b4a.objects.collections.List _list1 = null;
 //BA.debugLineNum = 54;BA.debugLine="Sub Button1_Click";
 //BA.debugLineNum = 55;BA.debugLine="c_zoom = 1";
_c_zoom = (float) (1);
 //BA.debugLineNum = 56;BA.debugLine="L_zoom.Text = Round2(c_zoom,2)";
_l_zoom.setText(BA.NumberToString(anywheresoftware.b4a.keywords.Common.Round2(_c_zoom,(int) (2))));
 //BA.debugLineNum = 58;BA.debugLine="Dim bmp As Image = fx.LoadImage(File.DirAssets,\"w";
_bmp = new anywheresoftware.b4j.objects.ImageViewWrapper.ImageWrapper();
_bmp = _fx.LoadImage(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"w.jpg");
 //BA.debugLineNum = 60;BA.debugLine="Dim List1 As List";
_list1 = new anywheresoftware.b4a.objects.collections.List();
 //BA.debugLineNum = 61;BA.debugLine="List1 = File.ReadList(File.DirAssets,\"w.jgw\")";
_list1 = anywheresoftware.b4a.keywords.Common.File.ReadList(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"w.jgw");
 //BA.debugLineNum = 62;BA.debugLine="xpixsize = Abs(List1.Get(0))";
_xpixsize = anywheresoftware.b4a.keywords.Common.Abs((double)(BA.ObjectToNumber(_list1.Get((int) (0)))));
 //BA.debugLineNum = 63;BA.debugLine="ypixsize = Abs(List1.Get(3))";
_ypixsize = anywheresoftware.b4a.keywords.Common.Abs((double)(BA.ObjectToNumber(_list1.Get((int) (3)))));
 //BA.debugLineNum = 64;BA.debugLine="xcoor = List1.Get(4)";
_xcoor = (double)(BA.ObjectToNumber(_list1.Get((int) (4))));
 //BA.debugLineNum = 65;BA.debugLine="ycoor = List1.Get(5)";
_ycoor = (double)(BA.ObjectToNumber(_list1.Get((int) (5))));
 //BA.debugLineNum = 67;BA.debugLine="ImageView1.SetImage(bmp)";
_imageview1.SetImage((javafx.scene.image.Image)(_bmp.getObject()));
 //BA.debugLineNum = 68;BA.debugLine="ImageView1.SetSize(bmp.Width, bmp.Height)";
_imageview1.SetSize(_bmp.getWidth(),_bmp.getHeight());
 //BA.debugLineNum = 69;BA.debugLine="ImageView1.Left = 0";
_imageview1.setLeft(0);
 //BA.debugLineNum = 70;BA.debugLine="ImageView1.Top = 0";
_imageview1.setTop(0);
 //BA.debugLineNum = 71;BA.debugLine="Canvas1.Width = ImageView1.Width";
_canvas1.setWidth(_imageview1.getWidth());
 //BA.debugLineNum = 72;BA.debugLine="Canvas1.Height = ImageView1.Height";
_canvas1.setHeight(_imageview1.getHeight());
 //BA.debugLineNum = 73;BA.debugLine="Canvas1.Left = ImageView1.Left";
_canvas1.setLeft(_imageview1.getLeft());
 //BA.debugLineNum = 74;BA.debugLine="Canvas1.Top = ImageView1.Top";
_canvas1.setTop(_imageview1.getTop());
 //BA.debugLineNum = 76;BA.debugLine="L_sob_pix.Text = bmp.Width";
_l_sob_pix.setText(BA.NumberToString(_bmp.getWidth()));
 //BA.debugLineNum = 77;BA.debugLine="L_vob_pix.Text = bmp.Height";
_l_vob_pix.setText(BA.NumberToString(_bmp.getHeight()));
 //BA.debugLineNum = 78;BA.debugLine="sob_pix = bmp.Width";
_sob_pix = (float) (_bmp.getWidth());
 //BA.debugLineNum = 80;BA.debugLine="draw_vector";
_draw_vector();
 //BA.debugLineNum = 81;BA.debugLine="End Sub";
return "";
}
public static String  _canvas1_mousemoved(anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
 //BA.debugLineNum = 95;BA.debugLine="Sub Canvas1_MouseMoved (EventData As MouseEvent)";
 //BA.debugLineNum = 96;BA.debugLine="If L_zoom.Text = \"zoom\" Then Return";
if ((_l_zoom.getText()).equals("zoom")) { 
if (true) return "";};
 //BA.debugLineNum = 98;BA.debugLine="L_xsur_pix.Text =	EventData.X / c_zoom";
_l_xsur_pix.setText(BA.NumberToString(_eventdata.getX()/(double)_c_zoom));
 //BA.debugLineNum = 99;BA.debugLine="L_ysur_pix.Text =	EventData.Y / c_zoom";
_l_ysur_pix.setText(BA.NumberToString(_eventdata.getY()/(double)_c_zoom));
 //BA.debugLineNum = 101;BA.debugLine="xobr =	EventData.X / c_zoom";
_xobr = _eventdata.getX()/(double)_c_zoom;
 //BA.debugLineNum = 102;BA.debugLine="yobr =	EventData.Y / c_zoom";
_yobr = _eventdata.getY()/(double)_c_zoom;
 //BA.debugLineNum = 104;BA.debugLine="pix_to_coor";
_pix_to_coor();
 //BA.debugLineNum = 105;BA.debugLine="End Sub";
return "";
}
public static String  _draw_vector() throws Exception{
 //BA.debugLineNum = 167;BA.debugLine="Sub draw_vector ()";
 //BA.debugLineNum = 168;BA.debugLine="Canvas1.ClearRect(0,0,Canvas1.Width, Canvas1.Heig";
_canvas1.ClearRect(0,0,_canvas1.getWidth(),_canvas1.getHeight());
 //BA.debugLineNum = 169;BA.debugLine="open_points";
_open_points();
 //BA.debugLineNum = 170;BA.debugLine="End Sub";
return "";
}
public static String  _imageview1_mousemoved(anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
 //BA.debugLineNum = 83;BA.debugLine="Sub ImageView1_MouseMoved (EventData As MouseEvent";
 //BA.debugLineNum = 84;BA.debugLine="If L_zoom.Text = \"zoom\" Then Return";
if ((_l_zoom.getText()).equals("zoom")) { 
if (true) return "";};
 //BA.debugLineNum = 86;BA.debugLine="L_xsur_pix.Text =	EventData.X / c_zoom";
_l_xsur_pix.setText(BA.NumberToString(_eventdata.getX()/(double)_c_zoom));
 //BA.debugLineNum = 87;BA.debugLine="L_ysur_pix.Text =	EventData.Y / c_zoom";
_l_ysur_pix.setText(BA.NumberToString(_eventdata.getY()/(double)_c_zoom));
 //BA.debugLineNum = 89;BA.debugLine="xobr =	EventData.X / c_zoom";
_xobr = _eventdata.getX()/(double)_c_zoom;
 //BA.debugLineNum = 90;BA.debugLine="yobr =	EventData.Y / c_zoom";
_yobr = _eventdata.getY()/(double)_c_zoom;
 //BA.debugLineNum = 92;BA.debugLine="pix_to_coor";
_pix_to_coor();
 //BA.debugLineNum = 93;BA.debugLine="End Sub";
return "";
}
public static String  _open_points() throws Exception{
String _nazovbodu = "";
int _i = 0;
String[] _str = null;
float _tx = 0f;
float _ty = 0f;
 //BA.debugLineNum = 172;BA.debugLine="Sub open_points ()";
 //BA.debugLineNum = 173;BA.debugLine="Dim nazovbodu As String";
_nazovbodu = "";
 //BA.debugLineNum = 174;BA.debugLine="List1b = File.ReadList(File.DirAssets, \"info.txt\"";
_list1b = anywheresoftware.b4a.keywords.Common.File.ReadList(anywheresoftware.b4a.keywords.Common.File.getDirAssets(),"info.txt");
 //BA.debugLineNum = 176;BA.debugLine="For i = 0 To List1b.Size-1";
{
final int step3 = 1;
final int limit3 = (int) (_list1b.getSize()-1);
_i = (int) (0) ;
for (;_i <= limit3 ;_i = _i + step3 ) {
 //BA.debugLineNum = 177;BA.debugLine="Dim str() As String";
_str = new String[(int) (0)];
java.util.Arrays.fill(_str,"");
 //BA.debugLineNum = 178;BA.debugLine="str = Regex.split(\":\", List1b.Get(i))";
_str = anywheresoftware.b4a.keywords.Common.Regex.Split(":",BA.ObjectToString(_list1b.Get(_i)));
 //BA.debugLineNum = 181;BA.debugLine="kde_lon_pix = ((str(2) - xcoor)/xpixsize) * c_zo";
_kde_lon_pix = (((double)(Double.parseDouble(_str[(int) (2)]))-_xcoor)/(double)_xpixsize)*_c_zoom;
 //BA.debugLineNum = 182;BA.debugLine="kde_lat_pix = ((ycoor - str(1))/ypixsize) * c_zo";
_kde_lat_pix = ((_ycoor-(double)(Double.parseDouble(_str[(int) (1)])))/(double)_ypixsize)*_c_zoom;
 //BA.debugLineNum = 185;BA.debugLine="nazovbodu = str(0)";
_nazovbodu = _str[(int) (0)];
 //BA.debugLineNum = 186;BA.debugLine="Dim tx As Float = kde_lon_pix '+ bod_radius*1.2";
_tx = (float) (_kde_lon_pix);
 //BA.debugLineNum = 187;BA.debugLine="Dim ty As Float = kde_lat_pix + 4*4";
_ty = (float) (_kde_lat_pix+4*4);
 //BA.debugLineNum = 188;BA.debugLine="Canvas1.DrawText(nazovbodu,tx,ty,fx.DefaultFont(";
_canvas1.DrawText(_nazovbodu,_tx,_ty,(javafx.scene.text.Font)(_fx.DefaultFont(10).getObject()),_fx.Colors.Blue,BA.getEnumFromString(javafx.scene.text.TextAlignment.class,"CENTER"));
 //BA.debugLineNum = 191;BA.debugLine="Canvas1.DrawCircle(kde_lon_pix, kde_lat_pix, 4,";
_canvas1.DrawCircle(_kde_lon_pix,_kde_lat_pix,4,_fx.Colors.Blue,anywheresoftware.b4a.keywords.Common.False,2);
 }
};
 //BA.debugLineNum = 193;BA.debugLine="End Sub";
return "";
}
public static String  _p_map_mousedragged(anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
 //BA.debugLineNum = 114;BA.debugLine="Sub P_map_MouseDragged (EventData As MouseEvent)";
 //BA.debugLineNum = 115;BA.debugLine="ImageView1.Left = Min(0.5 * P_map.Width, StartLef";
_imageview1.setLeft(anywheresoftware.b4a.keywords.Common.Min(0.5*_p_map.getWidth(),_startleft+1.2*(_eventdata.getX()-_startx)));
 //BA.debugLineNum = 116;BA.debugLine="Canvas1.Left = ImageView1.Left";
_canvas1.setLeft(_imageview1.getLeft());
 //BA.debugLineNum = 117;BA.debugLine="ImageView1.Left = Max(-(ImageView1.Width - 0.5 *";
_imageview1.setLeft(anywheresoftware.b4a.keywords.Common.Max(-(_imageview1.getWidth()-0.5*_p_map.getWidth()),_imageview1.getLeft()));
 //BA.debugLineNum = 118;BA.debugLine="Canvas1.Left = ImageView1.Left";
_canvas1.setLeft(_imageview1.getLeft());
 //BA.debugLineNum = 119;BA.debugLine="ImageView1.Top = Min(0.5 * P_map.Height, StartTop";
_imageview1.setTop(anywheresoftware.b4a.keywords.Common.Min(0.5*_p_map.getHeight(),_starttop+1.2*(_eventdata.getY()-_starty)));
 //BA.debugLineNum = 120;BA.debugLine="Canvas1.Top = ImageView1.Top";
_canvas1.setTop(_imageview1.getTop());
 //BA.debugLineNum = 121;BA.debugLine="ImageView1.Top = Max(-(ImageView1.Height - 0.5 *";
_imageview1.setTop(anywheresoftware.b4a.keywords.Common.Max(-(_imageview1.getHeight()-0.5*_p_map.getHeight()),_imageview1.getTop()));
 //BA.debugLineNum = 122;BA.debugLine="Canvas1.Top = ImageView1.Top";
_canvas1.setTop(_imageview1.getTop());
 //BA.debugLineNum = 123;BA.debugLine="End Sub";
return "";
}
public static String  _p_map_mousepressed(anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
 //BA.debugLineNum = 107;BA.debugLine="Sub P_map_MousePressed (EventData As MouseEvent)";
 //BA.debugLineNum = 108;BA.debugLine="StartLeft = ImageView1.Left";
_startleft = (int) (_imageview1.getLeft());
 //BA.debugLineNum = 109;BA.debugLine="StartTop = ImageView1.Top";
_starttop = (int) (_imageview1.getTop());
 //BA.debugLineNum = 110;BA.debugLine="StartX = EventData.X";
_startx = (int) (_eventdata.getX());
 //BA.debugLineNum = 111;BA.debugLine="StartY = EventData.Y";
_starty = (int) (_eventdata.getY());
 //BA.debugLineNum = 112;BA.debugLine="End Sub";
return "";
}
public static String  _pix_to_coor() throws Exception{
 //BA.debugLineNum = 160;BA.debugLine="Sub pix_to_coor";
 //BA.debugLineNum = 161;BA.debugLine="pix_lon = xcoor + Round2((Round2(xobr,6)*xpixsize";
_pix_lon = _xcoor+anywheresoftware.b4a.keywords.Common.Round2((anywheresoftware.b4a.keywords.Common.Round2(_xobr,(int) (6))*_xpixsize),(int) (6));
 //BA.debugLineNum = 162;BA.debugLine="pix_lat = ycoor - Round2((Round2(yobr,6)*ypixsize";
_pix_lat = _ycoor-anywheresoftware.b4a.keywords.Common.Round2((anywheresoftware.b4a.keywords.Common.Round2(_yobr,(int) (6))*_ypixsize),(int) (6));
 //BA.debugLineNum = 163;BA.debugLine="lblLat.Text = Round2(pix_lat,6)";
_lbllat.setText(BA.NumberToString(anywheresoftware.b4a.keywords.Common.Round2(_pix_lat,(int) (6))));
 //BA.debugLineNum = 164;BA.debugLine="lblLon.Text = Round2(pix_lon,6)";
_lbllon.setText(BA.NumberToString(anywheresoftware.b4a.keywords.Common.Round2(_pix_lon,(int) (6))));
 //BA.debugLineNum = 165;BA.debugLine="End Sub";
return "";
}

private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main._process_globals();
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static String  _process_globals() throws Exception{
 //BA.debugLineNum = 9;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 10;BA.debugLine="Private fx As JFX";
_fx = new anywheresoftware.b4j.objects.JFX();
 //BA.debugLineNum = 11;BA.debugLine="Private MainForm As Form";
_mainform = new anywheresoftware.b4j.objects.Form();
 //BA.debugLineNum = 12;BA.debugLine="Private ImageView1 As ImageView";
_imageview1 = new anywheresoftware.b4j.objects.ImageViewWrapper();
 //BA.debugLineNum = 13;BA.debugLine="Private P_map As Pane";
_p_map = new anywheresoftware.b4j.objects.PaneWrapper.ConcretePaneWrapper();
 //BA.debugLineNum = 14;BA.debugLine="Private StartLeft, StartTop, StartX, StartY As In";
_startleft = 0;
_starttop = 0;
_startx = 0;
_starty = 0;
 //BA.debugLineNum = 15;BA.debugLine="Private L_sob_pix As Label";
_l_sob_pix = new anywheresoftware.b4j.objects.LabelWrapper();
 //BA.debugLineNum = 16;BA.debugLine="Private L_vob_pix As Label";
_l_vob_pix = new anywheresoftware.b4j.objects.LabelWrapper();
 //BA.debugLineNum = 17;BA.debugLine="Private L_xsur_pix As Label";
_l_xsur_pix = new anywheresoftware.b4j.objects.LabelWrapper();
 //BA.debugLineNum = 18;BA.debugLine="Private L_ysur_pix As Label";
_l_ysur_pix = new anywheresoftware.b4j.objects.LabelWrapper();
 //BA.debugLineNum = 19;BA.debugLine="Private L_zoom As Label";
_l_zoom = new anywheresoftware.b4j.objects.LabelWrapper();
 //BA.debugLineNum = 20;BA.debugLine="Private c_zoom As Float";
_c_zoom = 0f;
 //BA.debugLineNum = 21;BA.debugLine="Private sob_pix As Float";
_sob_pix = 0f;
 //BA.debugLineNum = 22;BA.debugLine="Private Canvas1 As Canvas";
_canvas1 = new anywheresoftware.b4j.objects.CanvasWrapper();
 //BA.debugLineNum = 23;BA.debugLine="Private lblLat As Label";
_lbllat = new anywheresoftware.b4j.objects.LabelWrapper();
 //BA.debugLineNum = 24;BA.debugLine="Private lblLon As Label";
_lbllon = new anywheresoftware.b4j.objects.LabelWrapper();
 //BA.debugLineNum = 25;BA.debugLine="Private xobr As Double";
_xobr = 0;
 //BA.debugLineNum = 26;BA.debugLine="Private yobr As Double";
_yobr = 0;
 //BA.debugLineNum = 27;BA.debugLine="Private xpixsize As Double";
_xpixsize = 0;
 //BA.debugLineNum = 28;BA.debugLine="Private ypixsize As Double";
_ypixsize = 0;
 //BA.debugLineNum = 29;BA.debugLine="Private xcoor As Double";
_xcoor = 0;
 //BA.debugLineNum = 30;BA.debugLine="Private ycoor As Double";
_ycoor = 0;
 //BA.debugLineNum = 31;BA.debugLine="Private pix_lat As Double";
_pix_lat = 0;
 //BA.debugLineNum = 32;BA.debugLine="Private pix_lon As Double";
_pix_lon = 0;
 //BA.debugLineNum = 33;BA.debugLine="Private kde_lat_pix As Double";
_kde_lat_pix = 0;
 //BA.debugLineNum = 34;BA.debugLine="Private kde_lon_pix As Double";
_kde_lon_pix = 0;
 //BA.debugLineNum = 35;BA.debugLine="Private List1b As List";
_list1b = new anywheresoftware.b4a.objects.collections.List();
 //BA.debugLineNum = 36;BA.debugLine="End Sub";
return "";
}
public static Object  _scrollchanged_event(String _methodname,Object[] _args) throws Exception{
anywheresoftware.b4j.object.JavaObject _ev = null;
float _delta = 0f;
float _zoom = 0f;
 //BA.debugLineNum = 126;BA.debugLine="Private Sub ScrollChanged_Event (MethodName As Str";
 //BA.debugLineNum = 127;BA.debugLine="If MethodName = \"handle\" Then";
if ((_methodname).equals("handle")) { 
 //BA.debugLineNum = 128;BA.debugLine="Dim ev As JavaObject = Args(0)";
_ev = new anywheresoftware.b4j.object.JavaObject();
_ev = (anywheresoftware.b4j.object.JavaObject) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), (java.lang.Object)(_args[(int) (0)]));
 //BA.debugLineNum = 129;BA.debugLine="Dim delta As Float = ev.RunMethod(\"getDeltaY\", N";
_delta = (float)(BA.ObjectToNumber(_ev.RunMethod("getDeltaY",(Object[])(anywheresoftware.b4a.keywords.Common.Null))));
 //BA.debugLineNum = 130;BA.debugLine="Dim Zoom As Float";
_zoom = 0f;
 //BA.debugLineNum = 131;BA.debugLine="If delta > 0 And c_zoom < 4 Then";
if (_delta>0 && _c_zoom<4) { 
 //BA.debugLineNum = 132;BA.debugLine="Zoom = 1.1";
_zoom = (float) (1.1);
 }else {
 //BA.debugLineNum = 134;BA.debugLine="Zoom = 0.9";
_zoom = (float) (0.9);
 };
 //BA.debugLineNum = 136;BA.debugLine="ZoomChanged(ev.RunMethod(\"getX\", Null), ev.RunMe";
_zoomchanged((int)(BA.ObjectToNumber(_ev.RunMethod("getX",(Object[])(anywheresoftware.b4a.keywords.Common.Null)))),(int)(BA.ObjectToNumber(_ev.RunMethod("getY",(Object[])(anywheresoftware.b4a.keywords.Common.Null)))),_zoom);
 };
 //BA.debugLineNum = 138;BA.debugLine="Return Null";
if (true) return anywheresoftware.b4a.keywords.Common.Null;
 //BA.debugLineNum = 139;BA.debugLine="End Sub";
return null;
}
public static String  _zoomchanged(int _x,int _y,float _zoomdelta) throws Exception{
float _ivx = 0f;
float _ivy = 0f;
 //BA.debugLineNum = 141;BA.debugLine="Private Sub ZoomChanged (x As Int, y As Int, ZoomD";
 //BA.debugLineNum = 142;BA.debugLine="Dim ivx As Float = x - ImageView1.Left";
_ivx = (float) (_x-_imageview1.getLeft());
 //BA.debugLineNum = 143;BA.debugLine="Dim ivy As Float = y - ImageView1.Top";
_ivy = (float) (_y-_imageview1.getTop());
 //BA.debugLineNum = 144;BA.debugLine="ZoomDelta = Max(ZoomDelta, P_map.Width / ImageVie";
_zoomdelta = (float) (anywheresoftware.b4a.keywords.Common.Max(_zoomdelta,_p_map.getWidth()/(double)_imageview1.getWidth()));
 //BA.debugLineNum = 145;BA.debugLine="ImageView1.SetLayoutAnimated(0, x - ivx * ZoomDel";
_imageview1.SetLayoutAnimated((int) (0),_x-_ivx*_zoomdelta,_y-_ivy*_zoomdelta,_imageview1.getWidth()*_zoomdelta,_imageview1.getHeight()*_zoomdelta);
 //BA.debugLineNum = 149;BA.debugLine="Canvas1.Left = ImageView1.Left";
_canvas1.setLeft(_imageview1.getLeft());
 //BA.debugLineNum = 150;BA.debugLine="Canvas1.Top = ImageView1.Top";
_canvas1.setTop(_imageview1.getTop());
 //BA.debugLineNum = 151;BA.debugLine="Canvas1.Width = ImageView1.Width";
_canvas1.setWidth(_imageview1.getWidth());
 //BA.debugLineNum = 152;BA.debugLine="Canvas1.Height = ImageView1.Height";
_canvas1.setHeight(_imageview1.getHeight());
 //BA.debugLineNum = 154;BA.debugLine="c_zoom = (ImageView1.Width)/sob_pix";
_c_zoom = (float) ((_imageview1.getWidth())/(double)_sob_pix);
 //BA.debugLineNum = 155;BA.debugLine="L_zoom.Text = Round2(c_zoom,2)";
_l_zoom.setText(BA.NumberToString(anywheresoftware.b4a.keywords.Common.Round2(_c_zoom,(int) (2))));
 //BA.debugLineNum = 156;BA.debugLine="draw_vector";
_draw_vector();
 //BA.debugLineNum = 157;BA.debugLine="End Sub";
return "";
}
}
