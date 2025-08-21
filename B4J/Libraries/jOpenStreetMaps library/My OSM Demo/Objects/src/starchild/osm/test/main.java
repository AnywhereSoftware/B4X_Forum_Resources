package starchild.osm.test;


import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.debug.*;

public class main extends javafx.application.Application{
public static main mostCurrent = new main();

public static BA ba;
static {
		ba = new  anywheresoftware.b4a.ShellBA("starchild.osm.test", "starchild.osm.test.main", null);
		ba.loadHtSubs(main.class);
        if (ba.getClass().getName().endsWith("ShellBA")) {
			anywheresoftware.b4a.ShellBA.delegateBA = new anywheresoftware.b4j.objects.FxBA("starchild.osm.test", null, null);
			ba.raiseEvent2(null, true, "SHELL", false);
			ba.raiseEvent2(null, true, "CREATE", true, "starchild.osm.test.main", ba);
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
            frm.initWithStage(ba, stage, 640, 480);
            ba.raiseEvent(null, "appstart", frm, (String[])getParameters().getRaw().toArray(new String[0]));
        } catch (Throwable t) {
            BA.printException(t, true);
            System.exit(1);
        }
    }


private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static anywheresoftware.b4a.keywords.Common __c = null;
public static anywheresoftware.b4j.objects.JFX _fx = null;
public static anywheresoftware.b4j.objects.PaneWrapper.AnchorPaneWrapper _infowindow = null;
public static anywheresoftware.b4j.objects.LabelWrapper _infowindowdesclabel = null;
public static anywheresoftware.b4j.objects.LabelWrapper _infowindowtitlelabel = null;
public static anywheresoftware.b4j.objects.Form _mainform = null;
public static starchild.b4j.jfxtras.labs.map.tile.osm.OsmTileSourceFactory _osmtilesource = null;
public static anywheresoftware.b4j.objects.ComboBoxWrapper _tilesourceselector = null;
public static starchild.b4j.jfxtras.labs.map.MapPane _osm = null;
public static starchild.b4j.jfxtras.labs.map.render.MapNodeHost _mapnodehost1 = null;
public static starchild.b4j.extras.DefaultMapIcons _mapicons = null;
public static starchild.b4j.jfxtras.labs.map.render.ImageMapMarker _pin1 = null;
public static starchild.b4j.jfxtras.labs.map.render.SimpleMapMarker _spot1 = null;
public static starchild.b4j.jfxtras.labs.map.render.DefaultMapPolygon _p = null;
public static anywheresoftware.b4j.objects.ButtonWrapper _perthbutton = null;
public static anywheresoftware.b4j.objects.ButtonWrapper _cairobutton = null;
public static anywheresoftware.b4j.objects.ButtonWrapper _worldbutton = null;
public static String  _appstart(anywheresoftware.b4j.objects.Form _form1,String[] _args) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "appstart"))
	return (String) Debug.delegate(ba, "appstart", new Object[] {_form1,_args});
RDebugUtils.currentLine=65536;
 //BA.debugLineNum = 65536;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
RDebugUtils.currentLine=65537;
 //BA.debugLineNum = 65537;BA.debugLine="MainForm = Form1";
_mainform = _form1;
RDebugUtils.currentLine=65538;
 //BA.debugLineNum = 65538;BA.debugLine="MainForm.Title=\"Open Street Map - Demo\"";
_mainform.setTitle("Open Street Map - Demo");
RDebugUtils.currentLine=65539;
 //BA.debugLineNum = 65539;BA.debugLine="InfoWindow.Initialize(\"\")";
_infowindow.Initialize(ba,"");
RDebugUtils.currentLine=65540;
 //BA.debugLineNum = 65540;BA.debugLine="InfoWindow.LoadLayout(\"InfoWindow\")";
_infowindow.LoadLayout(ba,"InfoWindow");
RDebugUtils.currentLine=65543;
 //BA.debugLineNum = 65543;BA.debugLine="OsmTileSource.Initialize";
_osmtilesource.Initialize();
RDebugUtils.currentLine=65545;
 //BA.debugLineNum = 65545;BA.debugLine="OSM.Initialize3(\"OSM\", OsmTileSource.Create(OsmTi";
_osm.Initialize3(ba,"OSM",(jfxtras.labs.map.tile.TileSource)(_osmtilesource.Create(_osmtilesource.TS_MAPNIK_STD).getObject()),(int) (0),(int) (0),(int) (640),(int) (480),(int) (13));
RDebugUtils.currentLine=65548;
 //BA.debugLineNum = 65548;BA.debugLine="Pin1.Initialize2(\"PerthMarker\",MapIcons.PIN_RED,7";
_pin1.Initialize2(ba,"PerthMarker",_mapicons.PIN_RED,(int) (75),0,5,-31.92,115.83);
RDebugUtils.currentLine=65549;
 //BA.debugLineNum = 65549;BA.debugLine="Pin1.SetCursor(fx.Cursors.HAND)";
_pin1.SetCursor(_fx.Cursors.HAND);
RDebugUtils.currentLine=65550;
 //BA.debugLineNum = 65550;BA.debugLine="Pin1.Title=\"Perth Marker\"";
_pin1.setTitle("Perth Marker");
RDebugUtils.currentLine=65551;
 //BA.debugLineNum = 65551;BA.debugLine="Pin1.Description = \"This is the description.\"";
_pin1.setDescription("This is the description.");
RDebugUtils.currentLine=65552;
 //BA.debugLineNum = 65552;BA.debugLine="OSM.AddMarker(Pin1)";
_osm.AddMarker((jfxtras.labs.map.render.MapMarkable)(_pin1.getObject()));
RDebugUtils.currentLine=65554;
 //BA.debugLineNum = 65554;BA.debugLine="Spot1.Initialize2(\"CairoSpot\", 10, fx.Colors.RGB(";
_spot1.Initialize2(ba,"CairoSpot",(int) (10),_fx.Colors.RGB((int) (0),(int) (120),(int) (0)),2,30.1,31.2);
RDebugUtils.currentLine=65555;
 //BA.debugLineNum = 65555;BA.debugLine="Spot1.SetCursor(fx.Cursors.HAND)";
_spot1.SetCursor(_fx.Cursors.HAND);
RDebugUtils.currentLine=65556;
 //BA.debugLineNum = 65556;BA.debugLine="Spot1.Title=\"Cairo Spot\"";
_spot1.setTitle("Cairo Spot");
RDebugUtils.currentLine=65557;
 //BA.debugLineNum = 65557;BA.debugLine="Spot1.Description = \"This is draggable.\"";
_spot1.setDescription("This is draggable.");
RDebugUtils.currentLine=65558;
 //BA.debugLineNum = 65558;BA.debugLine="OSM.AddSpot(Spot1)";
_osm.AddSpot((jfxtras.labs.map.render.MapMarkable)(_spot1.getObject()));
RDebugUtils.currentLine=65563;
 //BA.debugLineNum = 65563;BA.debugLine="InfoWindow.RemoveNodeFromParent";
_infowindow.RemoveNodeFromParent();
RDebugUtils.currentLine=65564;
 //BA.debugLineNum = 65564;BA.debugLine="MapNodeHost1.Initialize(InfoWindow, 0, 0, 0, 0)";
_mapnodehost1.Initialize((javafx.scene.Node)(_infowindow.getObject()),0,0,(int) (0),(int) (0));
RDebugUtils.currentLine=65565;
 //BA.debugLineNum = 65565;BA.debugLine="OSM.AddNodeHost(MapNodeHost1)";
_osm.AddNodeHost((jfxtras.labs.map.render.MapNodeHost)(_mapnodehost1.getObject()));
RDebugUtils.currentLine=65567;
 //BA.debugLineNum = 65567;BA.debugLine="MainForm.RootPane.AddNode(OSM, 0, 0, 640, 480)";
_mainform.getRootPane().AddNode((javafx.scene.Node)(_osm.getObject()),0,0,640,480);
RDebugUtils.currentLine=65569;
 //BA.debugLineNum = 65569;BA.debugLine="TileSourceSelector.Initialize(\"TileSourceSelector";
_tilesourceselector.Initialize(ba,"TileSourceSelector");
RDebugUtils.currentLine=65570;
 //BA.debugLineNum = 65570;BA.debugLine="TileSourceSelector.TooltipText=\"Select tile sourc";
_tilesourceselector.setTooltipText("Select tile source");
RDebugUtils.currentLine=65571;
 //BA.debugLineNum = 65571;BA.debugLine="TileSourceSelector.Items.AddAll(Array As String(\"";
_tilesourceselector.getItems().AddAll(anywheresoftware.b4a.keywords.Common.ArrayToList(new String[]{"Mapnik STD","Mapnik BW","Open Street Map","BaseMaps Light","BaseMaps Dark","Stamen BW","Stamen Terrain","My Custom TS"}));
RDebugUtils.currentLine=65572;
 //BA.debugLineNum = 65572;BA.debugLine="MainForm.RootPane.AddNode(TileSourceSelector, 530";
_mainform.getRootPane().AddNode((javafx.scene.Node)(_tilesourceselector.getObject()),530,10,135,25);
RDebugUtils.currentLine=65574;
 //BA.debugLineNum = 65574;BA.debugLine="PerthButton.Initialize(\"PerthButton\")";
_perthbutton.Initialize(ba,"PerthButton");
RDebugUtils.currentLine=65575;
 //BA.debugLineNum = 65575;BA.debugLine="PerthButton.Text=\"Perth\"";
_perthbutton.setText("Perth");
RDebugUtils.currentLine=65576;
 //BA.debugLineNum = 65576;BA.debugLine="MainForm.RootPane.AddNode(PerthButton, 420, 10, 7";
_mainform.getRootPane().AddNode((javafx.scene.Node)(_perthbutton.getObject()),420,10,75,25);
RDebugUtils.currentLine=65578;
 //BA.debugLineNum = 65578;BA.debugLine="CairoButton.Initialize(\"CairoButton\")";
_cairobutton.Initialize(ba,"CairoButton");
RDebugUtils.currentLine=65579;
 //BA.debugLineNum = 65579;BA.debugLine="CairoButton.Text=\"Cairo\"";
_cairobutton.setText("Cairo");
RDebugUtils.currentLine=65580;
 //BA.debugLineNum = 65580;BA.debugLine="MainForm.RootPane.AddNode(CairoButton, 420, 10, 7";
_mainform.getRootPane().AddNode((javafx.scene.Node)(_cairobutton.getObject()),420,10,75,25);
RDebugUtils.currentLine=65583;
 //BA.debugLineNum = 65583;BA.debugLine="WorldButton.Initialize(\"WorldButton\")";
_worldbutton.Initialize(ba,"WorldButton");
RDebugUtils.currentLine=65584;
 //BA.debugLineNum = 65584;BA.debugLine="WorldButton.Text=\"World\"";
_worldbutton.setText("World");
RDebugUtils.currentLine=65585;
 //BA.debugLineNum = 65585;BA.debugLine="MainForm.RootPane.AddNode(WorldButton, 420, 10, 7";
_mainform.getRootPane().AddNode((javafx.scene.Node)(_worldbutton.getObject()),420,10,75,25);
RDebugUtils.currentLine=65587;
 //BA.debugLineNum = 65587;BA.debugLine="MainForm.Show";
_mainform.Show();
RDebugUtils.currentLine=65589;
 //BA.debugLineNum = 65589;BA.debugLine="WorldButton_Action";
_worldbutton_action();
RDebugUtils.currentLine=65590;
 //BA.debugLineNum = 65590;BA.debugLine="TileSourceSelector.SelectedIndex = 0";
_tilesourceselector.setSelectedIndex((int) (0));
RDebugUtils.currentLine=65592;
 //BA.debugLineNum = 65592;BA.debugLine="ShowTestPolygon";
_showtestpolygon();
RDebugUtils.currentLine=65593;
 //BA.debugLineNum = 65593;BA.debugLine="OSM.WorkOffline(False)";
_osm.WorkOffline(anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=65594;
 //BA.debugLineNum = 65594;BA.debugLine="OSM.SetGeoCoordinateLabelVisible(True)";
_osm.SetGeoCoordinateLabelVisible(anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=65595;
 //BA.debugLineNum = 65595;BA.debugLine="OSM.SetAttributionOffset(0)";
_osm.SetAttributionOffset((int) (0));
RDebugUtils.currentLine=65596;
 //BA.debugLineNum = 65596;BA.debugLine="End Sub";
return "";
}
public static String  _worldbutton_action() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "worldbutton_action"))
	return (String) Debug.delegate(ba, "worldbutton_action", null);
RDebugUtils.currentLine=262144;
 //BA.debugLineNum = 262144;BA.debugLine="Sub WorldButton_Action";
RDebugUtils.currentLine=262145;
 //BA.debugLineNum = 262145;BA.debugLine="Log(\"WorldButton_Action\")";
anywheresoftware.b4a.keywords.Common.Log("WorldButton_Action");
RDebugUtils.currentLine=262146;
 //BA.debugLineNum = 262146;BA.debugLine="InfoWindow.Visible=False";
_infowindow.setVisible(anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=262147;
 //BA.debugLineNum = 262147;BA.debugLine="OSM.SetDisplayPositionByLatLon2(12,67,3)";
_osm.SetDisplayPositionByLatLon2(12,67,(int) (3));
RDebugUtils.currentLine=262148;
 //BA.debugLineNum = 262148;BA.debugLine="End Sub";
return "";
}
public static String  _showtestpolygon() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "showtestpolygon"))
	return (String) Debug.delegate(ba, "showtestpolygon", null);
anywheresoftware.b4a.objects.collections.List _l = null;
starchild.b4j.jfxtras.labs.map.Coordinate _c = null;
RDebugUtils.currentLine=524288;
 //BA.debugLineNum = 524288;BA.debugLine="Private Sub ShowTestPolygon";
RDebugUtils.currentLine=524289;
 //BA.debugLineNum = 524289;BA.debugLine="Dim l As List";
_l = new anywheresoftware.b4a.objects.collections.List();
RDebugUtils.currentLine=524290;
 //BA.debugLineNum = 524290;BA.debugLine="l.Initialize";
_l.Initialize();
RDebugUtils.currentLine=524291;
 //BA.debugLineNum = 524291;BA.debugLine="Dim c As Coordinate";
_c = new starchild.b4j.jfxtras.labs.map.Coordinate();
RDebugUtils.currentLine=524292;
 //BA.debugLineNum = 524292;BA.debugLine="c.Initialize(-10,-10)";
_c.Initialize(-10,-10);
RDebugUtils.currentLine=524293;
 //BA.debugLineNum = 524293;BA.debugLine="l.Add(c)";
_l.Add((Object)(_c.getObject()));
RDebugUtils.currentLine=524294;
 //BA.debugLineNum = 524294;BA.debugLine="c.Initialize(10,10)";
_c.Initialize(10,10);
RDebugUtils.currentLine=524295;
 //BA.debugLineNum = 524295;BA.debugLine="l.Add(c)";
_l.Add((Object)(_c.getObject()));
RDebugUtils.currentLine=524296;
 //BA.debugLineNum = 524296;BA.debugLine="c.Initialize(-10,20)";
_c.Initialize(-10,20);
RDebugUtils.currentLine=524297;
 //BA.debugLineNum = 524297;BA.debugLine="l.Add(c)";
_l.Add((Object)(_c.getObject()));
RDebugUtils.currentLine=524298;
 //BA.debugLineNum = 524298;BA.debugLine="P.Initialize2(\"Test Polygon\",fx.Colors.Gray,2,fx.";
_p.Initialize2("Test Polygon",(javafx.scene.paint.Color)(_fx.Colors.Gray),2,_fx.Colors.ARGB((int) (50),(int) (0),(int) (0),(int) (255)),_l);
RDebugUtils.currentLine=524299;
 //BA.debugLineNum = 524299;BA.debugLine="OSM.AddPolygon(P)";
_osm.AddPolygon((jfxtras.labs.map.render.MapPolygonable)(_p.getObject()));
RDebugUtils.currentLine=524300;
 //BA.debugLineNum = 524300;BA.debugLine="End Sub";
return "";
}
public static String  _cairobutton_action() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "cairobutton_action"))
	return (String) Debug.delegate(ba, "cairobutton_action", null);
RDebugUtils.currentLine=196608;
 //BA.debugLineNum = 196608;BA.debugLine="Sub CairoButton_Action";
RDebugUtils.currentLine=196609;
 //BA.debugLineNum = 196609;BA.debugLine="Log(\"CairoButton_Action\")";
anywheresoftware.b4a.keywords.Common.Log("CairoButton_Action");
RDebugUtils.currentLine=196610;
 //BA.debugLineNum = 196610;BA.debugLine="InfoWindow.Visible=False";
_infowindow.setVisible(anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=196611;
 //BA.debugLineNum = 196611;BA.debugLine="OSM.SetDisplayPositionByLatLon2(30.1,31.2,8)";
_osm.SetDisplayPositionByLatLon2(30.1,31.2,(int) (8));
RDebugUtils.currentLine=196612;
 //BA.debugLineNum = 196612;BA.debugLine="End Sub";
return "";
}
public static String  _cairospot_mouseclicked(starchild.b4j.jfxtras.labs.map.render.SimpleMapMarker _spot,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _mouseevent1) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "cairospot_mouseclicked"))
	return (String) Debug.delegate(ba, "cairospot_mouseclicked", new Object[] {_spot,_mouseevent1});
RDebugUtils.currentLine=1245184;
 //BA.debugLineNum = 1245184;BA.debugLine="Sub CairoSpot_MouseClicked(Spot As MapSpot, MouseE";
RDebugUtils.currentLine=1245185;
 //BA.debugLineNum = 1245185;BA.debugLine="Log(\"CairoSpot_MouseClicked: \"& Spot.GetLat & \",";
anywheresoftware.b4a.keywords.Common.Log("CairoSpot_MouseClicked: "+BA.NumberToString(_spot.GetLat())+", "+BA.NumberToString(_spot.GetLon()));
RDebugUtils.currentLine=1245186;
 //BA.debugLineNum = 1245186;BA.debugLine="ShowHostedNode(Spot.GetLat,Spot.GetLon,Spot.Title";
_showhostednode(_spot.GetLat(),_spot.GetLon(),_spot.getTitle(),_spot.getDescription());
RDebugUtils.currentLine=1245187;
 //BA.debugLineNum = 1245187;BA.debugLine="End Sub";
return "";
}
public static String  _showhostednode(double _latitude,double _longitude,String _text,String _description) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "showhostednode"))
	return (String) Debug.delegate(ba, "showhostednode", new Object[] {_latitude,_longitude,_text,_description});
RDebugUtils.currentLine=327680;
 //BA.debugLineNum = 327680;BA.debugLine="Sub ShowHostedNode(Latitude As Double, Longitude A";
RDebugUtils.currentLine=327681;
 //BA.debugLineNum = 327681;BA.debugLine="MapNodeHost1.SetLat(Latitude)";
_mapnodehost1.SetLat(_latitude);
RDebugUtils.currentLine=327682;
 //BA.debugLineNum = 327682;BA.debugLine="MapNodeHost1.SetLon(Longitude)";
_mapnodehost1.SetLon(_longitude);
RDebugUtils.currentLine=327683;
 //BA.debugLineNum = 327683;BA.debugLine="InfoWindowTitleLabel.Text=Text";
_infowindowtitlelabel.setText(_text);
RDebugUtils.currentLine=327684;
 //BA.debugLineNum = 327684;BA.debugLine="InfoWindowDescLabel.Text=Description";
_infowindowdesclabel.setText(_description);
RDebugUtils.currentLine=327685;
 //BA.debugLineNum = 327685;BA.debugLine="InfoWindow.Visible=True";
_infowindow.setVisible(anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=327686;
 //BA.debugLineNum = 327686;BA.debugLine="MapNodeHost1.Render(OSM)";
_mapnodehost1.Render((jfxtras.labs.map.MapControlable)(_osm.getObject()));
RDebugUtils.currentLine=327687;
 //BA.debugLineNum = 327687;BA.debugLine="End Sub";
return "";
}
public static String  _cairospot_mousedragged(starchild.b4j.jfxtras.labs.map.render.SimpleMapMarker _spot,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "cairospot_mousedragged"))
	return (String) Debug.delegate(ba, "cairospot_mousedragged", new Object[] {_spot,_eventdata});
starchild.b4j.jfxtras.labs.map.Coordinate _dragpoint = null;
RDebugUtils.currentLine=1441792;
 //BA.debugLineNum = 1441792;BA.debugLine="Sub CairoSpot_MouseDragged(Spot As MapSpot, EventD";
RDebugUtils.currentLine=1441794;
 //BA.debugLineNum = 1441794;BA.debugLine="Dim DragPoint As Coordinate=OSM.GetCoordinate(Spo";
_dragpoint = new starchild.b4j.jfxtras.labs.map.Coordinate();
_dragpoint = _osm.GetCoordinate((int) (_spot.X()+_eventdata.getX()),(int) (_spot.Y()+_eventdata.getY()));
RDebugUtils.currentLine=1441795;
 //BA.debugLineNum = 1441795;BA.debugLine="Log(\"CairoSpot_MouseDragged: \" & EventData.X & \"";
anywheresoftware.b4a.keywords.Common.Log("CairoSpot_MouseDragged: "+BA.NumberToString(_eventdata.getX())+"   "+BA.NumberToString(_eventdata.getY()));
RDebugUtils.currentLine=1441796;
 //BA.debugLineNum = 1441796;BA.debugLine="Spot.MoveTo(DragPoint.GetLatitude,DragPoint.GetLo";
_spot.MoveTo(_dragpoint.GetLatitude(),_dragpoint.GetLongitude());
RDebugUtils.currentLine=1441797;
 //BA.debugLineNum = 1441797;BA.debugLine="End Sub";
return "";
}
public static String  _cairospot_mousepressed(starchild.b4j.jfxtras.labs.map.render.SimpleMapMarker _spot,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _mouseevent1) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "cairospot_mousepressed"))
	return (String) Debug.delegate(ba, "cairospot_mousepressed", new Object[] {_spot,_mouseevent1});
RDebugUtils.currentLine=1310720;
 //BA.debugLineNum = 1310720;BA.debugLine="Sub CairoSpot_MousePressed(Spot As MapSpot, MouseE";
RDebugUtils.currentLine=1310721;
 //BA.debugLineNum = 1310721;BA.debugLine="Log(\"CairoSpot_MousePressed: \")";
anywheresoftware.b4a.keywords.Common.Log("CairoSpot_MousePressed: ");
RDebugUtils.currentLine=1310722;
 //BA.debugLineNum = 1310722;BA.debugLine="OSM.MapDraggable = False";
_osm.setMapDraggable(anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=1310723;
 //BA.debugLineNum = 1310723;BA.debugLine="End Sub";
return "";
}
public static String  _cairospot_mousereleased(starchild.b4j.jfxtras.labs.map.render.SimpleMapMarker _spot,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _mouseevent1) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "cairospot_mousereleased"))
	return (String) Debug.delegate(ba, "cairospot_mousereleased", new Object[] {_spot,_mouseevent1});
RDebugUtils.currentLine=1376256;
 //BA.debugLineNum = 1376256;BA.debugLine="Sub CairoSpot_MouseReleased(Spot As MapSpot, Mouse";
RDebugUtils.currentLine=1376257;
 //BA.debugLineNum = 1376257;BA.debugLine="Log(\"CairoSpot_MouseReleased: \")";
anywheresoftware.b4a.keywords.Common.Log("CairoSpot_MouseReleased: ");
RDebugUtils.currentLine=1376258;
 //BA.debugLineNum = 1376258;BA.debugLine="OSM.MapDraggable = True";
_osm.setMapDraggable(anywheresoftware.b4a.keywords.Common.True);
RDebugUtils.currentLine=1376259;
 //BA.debugLineNum = 1376259;BA.debugLine="End Sub";
return "";
}
public static starchild.b4j.jfxtras.labs.map.tile.TileSource  _createmycustomtilesource() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "createmycustomtilesource"))
	return (starchild.b4j.jfxtras.labs.map.tile.TileSource) Debug.delegate(ba, "createmycustomtilesource", null);
starchild.b4j.jfxtras.labs.map.tile.CustomTileSource _cs = null;
RDebugUtils.currentLine=655360;
 //BA.debugLineNum = 655360;BA.debugLine="Sub CreateMyCustomTileSource As TileSource";
RDebugUtils.currentLine=655361;
 //BA.debugLineNum = 655361;BA.debugLine="Dim cs As MapCustomTileSource";
_cs = new starchild.b4j.jfxtras.labs.map.tile.CustomTileSource();
RDebugUtils.currentLine=655362;
 //BA.debugLineNum = 655362;BA.debugLine="OSM.ClearMapCache2(\"My-Custom-TS\")";
_osm.ClearMapCache2("My-Custom-TS");
RDebugUtils.currentLine=655363;
 //BA.debugLineNum = 655363;BA.debugLine="cs.Initialize2(\"My-Custom-TS\",\"http://cartodb-bas";
_cs.Initialize2("My-Custom-TS","http://cartodb-basemaps-a.global.ssl.fastly.net/light_all",(int) (1),(int) (18));
RDebugUtils.currentLine=655365;
 //BA.debugLineNum = 655365;BA.debugLine="cs.SetAttributionText(\"My Custom Tile Source\")";
_cs.SetAttributionText("My Custom Tile Source");
RDebugUtils.currentLine=655366;
 //BA.debugLineNum = 655366;BA.debugLine="cs.SetTermsOfUseText(\"Custom Terms of Use\")";
_cs.SetTermsOfUseText("Custom Terms of Use");
RDebugUtils.currentLine=655367;
 //BA.debugLineNum = 655367;BA.debugLine="cs.SetTermsOfUseURL(\"www.b4x.com\")";
_cs.SetTermsOfUseURL("www.b4x.com");
RDebugUtils.currentLine=655368;
 //BA.debugLineNum = 655368;BA.debugLine="cs.SetAttributionColor(fx.Colors.Black)";
_cs.SetAttributionColor((javafx.scene.paint.Color)(_fx.Colors.Black));
RDebugUtils.currentLine=655369;
 //BA.debugLineNum = 655369;BA.debugLine="Return cs";
if (true) return (starchild.b4j.jfxtras.labs.map.tile.TileSource) anywheresoftware.b4a.AbsObjectWrapper.ConvertToWrapper(new starchild.b4j.jfxtras.labs.map.tile.TileSource(), (jfxtras.labs.map.tile.TileSource)(_cs.getObject()));
RDebugUtils.currentLine=655370;
 //BA.debugLineNum = 655370;BA.debugLine="End Sub";
return null;
}
public static String  _mainform_resize(double _width,double _height) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "mainform_resize"))
	return (String) Debug.delegate(ba, "mainform_resize", new Object[] {_width,_height});
RDebugUtils.currentLine=458752;
 //BA.debugLineNum = 458752;BA.debugLine="Private Sub MainForm_Resize (Width As Double, Heig";
RDebugUtils.currentLine=458753;
 //BA.debugLineNum = 458753;BA.debugLine="Log(\"MainForm_Resize\")";
anywheresoftware.b4a.keywords.Common.Log("MainForm_Resize");
RDebugUtils.currentLine=458754;
 //BA.debugLineNum = 458754;BA.debugLine="OSM.SetMapWidth(Width)";
_osm.SetMapWidth(_width);
RDebugUtils.currentLine=458755;
 //BA.debugLineNum = 458755;BA.debugLine="OSM.SetMapHeight(Height)";
_osm.SetMapHeight(_height);
RDebugUtils.currentLine=458756;
 //BA.debugLineNum = 458756;BA.debugLine="TileSourceSelector.Left = Width - TileSourceSelec";
_tilesourceselector.setLeft(_width-_tilesourceselector.getWidth()-10);
RDebugUtils.currentLine=458757;
 //BA.debugLineNum = 458757;BA.debugLine="PerthButton.Left = TileSourceSelector.Left - Pert";
_perthbutton.setLeft(_tilesourceselector.getLeft()-_perthbutton.getWidth()-10);
RDebugUtils.currentLine=458758;
 //BA.debugLineNum = 458758;BA.debugLine="CairoButton.Left = PerthButton.Left - CairoButton";
_cairobutton.setLeft(_perthbutton.getLeft()-_cairobutton.getWidth()-10);
RDebugUtils.currentLine=458759;
 //BA.debugLineNum = 458759;BA.debugLine="WorldButton.Left = CairoButton.Left - WorldButton";
_worldbutton.setLeft(_cairobutton.getLeft()-_worldbutton.getWidth()-10);
RDebugUtils.currentLine=458760;
 //BA.debugLineNum = 458760;BA.debugLine="End Sub";
return "";
}
public static String  _osm_mouseclicked(anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "osm_mouseclicked"))
	return (String) Debug.delegate(ba, "osm_mouseclicked", new Object[] {_eventdata});
starchild.b4j.jfxtras.labs.map.Coordinate _clickpoint = null;
RDebugUtils.currentLine=786432;
 //BA.debugLineNum = 786432;BA.debugLine="Sub OSM_MouseClicked(EventData As MouseEvent)";
RDebugUtils.currentLine=786433;
 //BA.debugLineNum = 786433;BA.debugLine="Dim ClickPoint As Coordinate=OSM.GetCoordinate(Ev";
_clickpoint = new starchild.b4j.jfxtras.labs.map.Coordinate();
_clickpoint = _osm.GetCoordinate((int) (_eventdata.getX()),(int) (_eventdata.getY()));
RDebugUtils.currentLine=786434;
 //BA.debugLineNum = 786434;BA.debugLine="Log(\"OSM_MouseClicked: \"&ClickPoint.GetLatitude&\"";
anywheresoftware.b4a.keywords.Common.Log("OSM_MouseClicked: "+BA.NumberToString(_clickpoint.GetLatitude())+", "+BA.NumberToString(_clickpoint.GetLongitude()));
RDebugUtils.currentLine=786435;
 //BA.debugLineNum = 786435;BA.debugLine="InfoWindow.Visible=False";
_infowindow.setVisible(anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=786436;
 //BA.debugLineNum = 786436;BA.debugLine="End Sub";
return "";
}
public static String  _osm_mousedragged(anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "osm_mousedragged"))
	return (String) Debug.delegate(ba, "osm_mousedragged", new Object[] {_eventdata});
RDebugUtils.currentLine=917504;
 //BA.debugLineNum = 917504;BA.debugLine="Sub OSM_MouseDragged(EventData As MouseEvent)";
RDebugUtils.currentLine=917505;
 //BA.debugLineNum = 917505;BA.debugLine="Log(\"OSM_MouseDragged\")";
anywheresoftware.b4a.keywords.Common.Log("OSM_MouseDragged");
RDebugUtils.currentLine=917506;
 //BA.debugLineNum = 917506;BA.debugLine="End Sub";
return "";
}
public static String  _osm_mousemoved(anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "osm_mousemoved"))
	return (String) Debug.delegate(ba, "osm_mousemoved", new Object[] {_eventdata});
RDebugUtils.currentLine=851968;
 //BA.debugLineNum = 851968;BA.debugLine="Sub OSM_MouseMoved(EventData As MouseEvent)";
RDebugUtils.currentLine=851969;
 //BA.debugLineNum = 851969;BA.debugLine="Log(\"OSM_MouseMoved\")";
anywheresoftware.b4a.keywords.Common.Log("OSM_MouseMoved");
RDebugUtils.currentLine=851970;
 //BA.debugLineNum = 851970;BA.debugLine="End Sub";
return "";
}
public static String  _osm_mousepressed(anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "osm_mousepressed"))
	return (String) Debug.delegate(ba, "osm_mousepressed", new Object[] {_eventdata});
RDebugUtils.currentLine=720896;
 //BA.debugLineNum = 720896;BA.debugLine="Sub OSM_MousePressed(EventData As MouseEvent)";
RDebugUtils.currentLine=720897;
 //BA.debugLineNum = 720897;BA.debugLine="Log(\"OSM_MousePressed\")";
anywheresoftware.b4a.keywords.Common.Log("OSM_MousePressed");
RDebugUtils.currentLine=720898;
 //BA.debugLineNum = 720898;BA.debugLine="End Sub";
return "";
}
public static String  _osm_mousereleased(anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _eventdata) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "osm_mousereleased"))
	return (String) Debug.delegate(ba, "osm_mousereleased", new Object[] {_eventdata});
RDebugUtils.currentLine=983040;
 //BA.debugLineNum = 983040;BA.debugLine="Sub OSM_MouseReleased(EventData As MouseEvent)";
RDebugUtils.currentLine=983041;
 //BA.debugLineNum = 983041;BA.debugLine="Log(\"OSM_MouseReleased\")";
anywheresoftware.b4a.keywords.Common.Log("OSM_MouseReleased");
RDebugUtils.currentLine=983042;
 //BA.debugLineNum = 983042;BA.debugLine="End Sub";
return "";
}
public static String  _osm_ready() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "osm_ready"))
	return (String) Debug.delegate(ba, "osm_ready", null);
RDebugUtils.currentLine=1048576;
 //BA.debugLineNum = 1048576;BA.debugLine="Sub OSM_Ready()";
RDebugUtils.currentLine=1048577;
 //BA.debugLineNum = 1048577;BA.debugLine="Log(\"OSM_Ready\")";
anywheresoftware.b4a.keywords.Common.Log("OSM_Ready");
RDebugUtils.currentLine=1048578;
 //BA.debugLineNum = 1048578;BA.debugLine="End Sub";
return "";
}
public static String  _osm_rendered() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "osm_rendered"))
	return (String) Debug.delegate(ba, "osm_rendered", null);
RDebugUtils.currentLine=1114112;
 //BA.debugLineNum = 1114112;BA.debugLine="Sub OSM_Rendered()";
RDebugUtils.currentLine=1114113;
 //BA.debugLineNum = 1114113;BA.debugLine="Log(\"OSM_Rendered\")";
anywheresoftware.b4a.keywords.Common.Log("OSM_Rendered");
RDebugUtils.currentLine=1114114;
 //BA.debugLineNum = 1114114;BA.debugLine="End Sub";
return "";
}
public static String  _perthbutton_action() throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "perthbutton_action"))
	return (String) Debug.delegate(ba, "perthbutton_action", null);
RDebugUtils.currentLine=131072;
 //BA.debugLineNum = 131072;BA.debugLine="Sub PerthButton_Action";
RDebugUtils.currentLine=131073;
 //BA.debugLineNum = 131073;BA.debugLine="Log(\"PerthButton_Action\")";
anywheresoftware.b4a.keywords.Common.Log("PerthButton_Action");
RDebugUtils.currentLine=131074;
 //BA.debugLineNum = 131074;BA.debugLine="InfoWindow.Visible=False";
_infowindow.setVisible(anywheresoftware.b4a.keywords.Common.False);
RDebugUtils.currentLine=131075;
 //BA.debugLineNum = 131075;BA.debugLine="OSM.SetDisplayPositionByLatLon2(-31.92,115.83,13)";
_osm.SetDisplayPositionByLatLon2(-31.92,115.83,(int) (13));
RDebugUtils.currentLine=131076;
 //BA.debugLineNum = 131076;BA.debugLine="End Sub";
return "";
}
public static String  _perthmarker_mouseclicked(starchild.b4j.jfxtras.labs.map.render.ImageMapMarker _marker,anywheresoftware.b4j.objects.NodeWrapper.MouseEventWrapper _mouseevent1) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "perthmarker_mouseclicked"))
	return (String) Debug.delegate(ba, "perthmarker_mouseclicked", new Object[] {_marker,_mouseevent1});
RDebugUtils.currentLine=1179648;
 //BA.debugLineNum = 1179648;BA.debugLine="Sub PerthMarker_MouseClicked(Marker As MapMarker,";
RDebugUtils.currentLine=1179649;
 //BA.debugLineNum = 1179649;BA.debugLine="Log(\"PerthMarker_MouseClicked: \"& Marker.GetLat&\"";
anywheresoftware.b4a.keywords.Common.Log("PerthMarker_MouseClicked: "+BA.NumberToString(_marker.GetLat())+", "+BA.NumberToString(_marker.GetLon()));
RDebugUtils.currentLine=1179650;
 //BA.debugLineNum = 1179650;BA.debugLine="ShowHostedNode(Marker.GetLat,Marker.GetLon,Marker";
_showhostednode(_marker.GetLat(),_marker.GetLon(),_marker.getTitle(),_marker.getDescription());
RDebugUtils.currentLine=1179652;
 //BA.debugLineNum = 1179652;BA.debugLine="End Sub";
return "";
}
public static String  _setmaximized(anywheresoftware.b4j.objects.Form _frm) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "setmaximized"))
	return (String) Debug.delegate(ba, "setmaximized", new Object[] {_frm});
anywheresoftware.b4j.object.JavaObject _joform = null;
anywheresoftware.b4j.object.JavaObject _jostage = null;
RDebugUtils.currentLine=589824;
 //BA.debugLineNum = 589824;BA.debugLine="Public Sub SetMaximized(frm As Form)";
RDebugUtils.currentLine=589825;
 //BA.debugLineNum = 589825;BA.debugLine="Dim joForm As JavaObject = frm";
_joform = new anywheresoftware.b4j.object.JavaObject();
_joform.setObject((java.lang.Object)(_frm));
RDebugUtils.currentLine=589826;
 //BA.debugLineNum = 589826;BA.debugLine="Dim joStage As JavaObject = joForm.GetField(\"stag";
_jostage = new anywheresoftware.b4j.object.JavaObject();
_jostage.setObject((java.lang.Object)(_joform.GetField("stage")));
RDebugUtils.currentLine=589827;
 //BA.debugLineNum = 589827;BA.debugLine="joStage.RunMethod(\"setMaximized\", Array(True))";
_jostage.RunMethod("setMaximized",new Object[]{(Object)(anywheresoftware.b4a.keywords.Common.True)});
RDebugUtils.currentLine=589828;
 //BA.debugLineNum = 589828;BA.debugLine="End Sub";
return "";
}
public static String  _tilesourceselector_selectedindexchanged(int _index,Object _value) throws Exception{
RDebugUtils.currentModule="main";
if (Debug.shouldDelegate(ba, "tilesourceselector_selectedindexchanged"))
	return (String) Debug.delegate(ba, "tilesourceselector_selectedindexchanged", new Object[] {_index,_value});
String _name = "";
starchild.b4j.jfxtras.labs.map.tile.TileSource _ts = null;
RDebugUtils.currentLine=393216;
 //BA.debugLineNum = 393216;BA.debugLine="Sub TileSourceSelector_SelectedIndexChanged(Index";
RDebugUtils.currentLine=393217;
 //BA.debugLineNum = 393217;BA.debugLine="Dim Name As String = Value";
_name = BA.ObjectToString(_value);
RDebugUtils.currentLine=393218;
 //BA.debugLineNum = 393218;BA.debugLine="Select Name";
switch (BA.switchObjectToInt(_name,"Mapnik STD","Mapnik BW","Open Street Map","BaseMaps Light","BaseMaps Dark","Stamen BW","Stamen Terrain","My Custom TS")) {
case 0: {
RDebugUtils.currentLine=393220;
 //BA.debugLineNum = 393220;BA.debugLine="Dim ts As TileSource = OsmTileSource.Create(Osm";
_ts = new starchild.b4j.jfxtras.labs.map.tile.TileSource();
_ts = _osmtilesource.Create(_osmtilesource.TS_MAPNIK_STD);
 break; }
case 1: {
RDebugUtils.currentLine=393222;
 //BA.debugLineNum = 393222;BA.debugLine="Dim ts As TileSource = OsmTileSource.Create(Osm";
_ts = new starchild.b4j.jfxtras.labs.map.tile.TileSource();
_ts = _osmtilesource.Create(_osmtilesource.TS_MAPNIK_BW);
 break; }
case 2: {
RDebugUtils.currentLine=393224;
 //BA.debugLineNum = 393224;BA.debugLine="Dim ts As TileSource = OsmTileSource.Create(Osm";
_ts = new starchild.b4j.jfxtras.labs.map.tile.TileSource();
_ts = _osmtilesource.Create(_osmtilesource.TS_OPEN_STREET_MAP);
 break; }
case 3: {
RDebugUtils.currentLine=393226;
 //BA.debugLineNum = 393226;BA.debugLine="Dim ts As TileSource = OsmTileSource.Create(Osm";
_ts = new starchild.b4j.jfxtras.labs.map.tile.TileSource();
_ts = _osmtilesource.Create(_osmtilesource.TS_BASEPAKS_LIGHT);
 break; }
case 4: {
RDebugUtils.currentLine=393228;
 //BA.debugLineNum = 393228;BA.debugLine="Dim ts As TileSource = OsmTileSource.Create(Osm";
_ts = new starchild.b4j.jfxtras.labs.map.tile.TileSource();
_ts = _osmtilesource.Create(_osmtilesource.TS_BASEMAPS_DARK);
 break; }
case 5: {
RDebugUtils.currentLine=393230;
 //BA.debugLineNum = 393230;BA.debugLine="Dim ts As TileSource = OsmTileSource.Create(Osm";
_ts = new starchild.b4j.jfxtras.labs.map.tile.TileSource();
_ts = _osmtilesource.Create(_osmtilesource.TS_STAMEN_BW);
 break; }
case 6: {
RDebugUtils.currentLine=393232;
 //BA.debugLineNum = 393232;BA.debugLine="Dim ts As TileSource = OsmTileSource.Create(Osm";
_ts = new starchild.b4j.jfxtras.labs.map.tile.TileSource();
_ts = _osmtilesource.Create(_osmtilesource.TS_STAMEN_TERRAIN);
 break; }
case 7: {
RDebugUtils.currentLine=393234;
 //BA.debugLineNum = 393234;BA.debugLine="Dim ts As TileSource = CreateMyCustomTileSource";
_ts = new starchild.b4j.jfxtras.labs.map.tile.TileSource();
_ts = _createmycustomtilesource();
 break; }
default: {
RDebugUtils.currentLine=393236;
 //BA.debugLineNum = 393236;BA.debugLine="Log(\"TileSourceSelector_SelectedIndexChanged: U";
anywheresoftware.b4a.keywords.Common.Log("TileSourceSelector_SelectedIndexChanged: Unknown Type("+_name+")");
RDebugUtils.currentLine=393237;
 //BA.debugLineNum = 393237;BA.debugLine="Return";
if (true) return "";
 break; }
}
;
RDebugUtils.currentLine=393239;
 //BA.debugLineNum = 393239;BA.debugLine="OSM.SetTileSource(ts)";
_osm.SetTileSource((jfxtras.labs.map.tile.TileSource)(_ts.getObject()));
RDebugUtils.currentLine=393240;
 //BA.debugLineNum = 393240;BA.debugLine="End Sub";
return "";
}
}