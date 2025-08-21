package starchild.osm.test;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.*;

public class main_subs_0 {


public static RemoteObject  _appstart(RemoteObject _form1,RemoteObject _args) throws Exception{
try {
		Debug.PushSubsStack("AppStart (main) ","main",0,main.ba,main.mostCurrent,30);
if (RapidSub.canDelegate("appstart")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","appstart", _form1, _args);
Debug.locals.put("Form1", _form1);
Debug.locals.put("Args", _args);
 BA.debugLineNum = 30;BA.debugLine="Sub AppStart (Form1 As Form, Args() As String)";
Debug.ShouldStop(536870912);
 BA.debugLineNum = 31;BA.debugLine="MainForm = Form1";
Debug.ShouldStop(1073741824);
main._mainform = _form1;
 BA.debugLineNum = 32;BA.debugLine="MainForm.Title=\"Open Street Map - Demo\"";
Debug.ShouldStop(-2147483648);
main._mainform.runMethod(true,"setTitle",BA.ObjectToString("Open Street Map - Demo"));
 BA.debugLineNum = 33;BA.debugLine="InfoWindow.Initialize(\"\")";
Debug.ShouldStop(1);
main._infowindow.runVoidMethod ("Initialize",main.ba,(Object)(RemoteObject.createImmutable("")));
 BA.debugLineNum = 34;BA.debugLine="InfoWindow.LoadLayout(\"InfoWindow\")";
Debug.ShouldStop(2);
main._infowindow.runMethodAndSync(false,"LoadLayout",main.ba,(Object)(RemoteObject.createImmutable("InfoWindow")));
 BA.debugLineNum = 37;BA.debugLine="OsmTileSource.Initialize";
Debug.ShouldStop(16);
main._osmtilesource.runVoidMethod ("Initialize");
 BA.debugLineNum = 39;BA.debugLine="OSM.Initialize3(\"OSM\", OsmTileSource.Create(OsmTi";
Debug.ShouldStop(64);
main._osm.runVoidMethod ("Initialize3",main.ba,(Object)(BA.ObjectToString("OSM")),(Object)((main._osmtilesource.runMethod(false,"Create",(Object)(main._osmtilesource.getField(false,"TS_MAPNIK_STD"))).getObject())),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 640)),(Object)(BA.numberCast(int.class, 480)),(Object)(BA.numberCast(int.class, 13)));
 BA.debugLineNum = 42;BA.debugLine="Pin1.Initialize2(\"PerthMarker\",MapIcons.PIN_RED,7";
Debug.ShouldStop(512);
main._pin1.runVoidMethod ("Initialize2",main.ba,(Object)(BA.ObjectToString("PerthMarker")),(Object)(main._mapicons.getField(true,"PIN_RED")),(Object)(BA.numberCast(int.class, 75)),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, 5)),(Object)(BA.numberCast(double.class, -31.92)),(Object)(BA.numberCast(double.class, 115.83)));
 BA.debugLineNum = 43;BA.debugLine="Pin1.SetCursor(fx.Cursors.HAND)";
Debug.ShouldStop(1024);
main._pin1.runVoidMethod ("SetCursor",(Object)(main._fx.getField(false,"Cursors").getField(false,"HAND")));
 BA.debugLineNum = 44;BA.debugLine="Pin1.Title=\"Perth Marker\"";
Debug.ShouldStop(2048);
main._pin1.runMethod(true,"setTitle",BA.ObjectToString("Perth Marker"));
 BA.debugLineNum = 45;BA.debugLine="Pin1.Description = \"This is the description.\"";
Debug.ShouldStop(4096);
main._pin1.runMethod(true,"setDescription",BA.ObjectToString("This is the description."));
 BA.debugLineNum = 46;BA.debugLine="OSM.AddMarker(Pin1)";
Debug.ShouldStop(8192);
main._osm.runVoidMethod ("AddMarker",(Object)((main._pin1.getObject())));
 BA.debugLineNum = 48;BA.debugLine="Spot1.Initialize2(\"CairoSpot\", 10, fx.Colors.RGB(";
Debug.ShouldStop(32768);
main._spot1.runVoidMethod ("Initialize2",main.ba,(Object)(BA.ObjectToString("CairoSpot")),(Object)(BA.numberCast(int.class, 10)),(Object)(main._fx.getField(false,"Colors").runMethod(false,"RGB",(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 120)),(Object)(BA.numberCast(int.class, 0)))),(Object)(BA.numberCast(double.class, 2)),(Object)(BA.numberCast(double.class, 30.1)),(Object)(BA.numberCast(double.class, 31.2)));
 BA.debugLineNum = 49;BA.debugLine="Spot1.SetCursor(fx.Cursors.HAND)";
Debug.ShouldStop(65536);
main._spot1.runVoidMethod ("SetCursor",(Object)(main._fx.getField(false,"Cursors").getField(false,"HAND")));
 BA.debugLineNum = 50;BA.debugLine="Spot1.Title=\"Cairo Spot\"";
Debug.ShouldStop(131072);
main._spot1.runMethod(true,"setTitle",BA.ObjectToString("Cairo Spot"));
 BA.debugLineNum = 51;BA.debugLine="Spot1.Description = \"This is draggable.\"";
Debug.ShouldStop(262144);
main._spot1.runMethod(true,"setDescription",BA.ObjectToString("This is draggable."));
 BA.debugLineNum = 52;BA.debugLine="OSM.AddSpot(Spot1)";
Debug.ShouldStop(524288);
main._osm.runVoidMethod ("AddSpot",(Object)((main._spot1.getObject())));
 BA.debugLineNum = 57;BA.debugLine="InfoWindow.RemoveNodeFromParent";
Debug.ShouldStop(16777216);
main._infowindow.runVoidMethod ("RemoveNodeFromParent");
 BA.debugLineNum = 58;BA.debugLine="MapNodeHost1.Initialize(InfoWindow, 0, 0, 0, 0)";
Debug.ShouldStop(33554432);
main._mapnodehost1.runVoidMethod ("Initialize",(Object)((main._infowindow.getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)));
 BA.debugLineNum = 59;BA.debugLine="OSM.AddNodeHost(MapNodeHost1)";
Debug.ShouldStop(67108864);
main._osm.runVoidMethod ("AddNodeHost",(Object)((main._mapnodehost1.getObject())));
 BA.debugLineNum = 61;BA.debugLine="MainForm.RootPane.AddNode(OSM, 0, 0, 640, 480)";
Debug.ShouldStop(268435456);
main._mainform.runMethod(false,"getRootPane").runVoidMethod ("AddNode",(Object)((main._osm.getObject())),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, 0)),(Object)(BA.numberCast(double.class, 640)),(Object)(BA.numberCast(double.class, 480)));
 BA.debugLineNum = 63;BA.debugLine="TileSourceSelector.Initialize(\"TileSourceSelector";
Debug.ShouldStop(1073741824);
main._tilesourceselector.runVoidMethod ("Initialize",main.ba,(Object)(RemoteObject.createImmutable("TileSourceSelector")));
 BA.debugLineNum = 64;BA.debugLine="TileSourceSelector.TooltipText=\"Select tile sourc";
Debug.ShouldStop(-2147483648);
main._tilesourceselector.runMethod(true,"setTooltipText",BA.ObjectToString("Select tile source"));
 BA.debugLineNum = 65;BA.debugLine="TileSourceSelector.Items.AddAll(Array As String(\"";
Debug.ShouldStop(1);
main._tilesourceselector.runMethod(false,"getItems").runVoidMethod ("AddAll",(Object)(main.__c.runMethod(false, "ArrayToList", (Object)(RemoteObject.createNewArray("String",new int[] {8},new Object[] {BA.ObjectToString("Mapnik STD"),BA.ObjectToString("Mapnik BW"),BA.ObjectToString("Open Street Map"),BA.ObjectToString("BaseMaps Light"),BA.ObjectToString("BaseMaps Dark"),BA.ObjectToString("Stamen BW"),BA.ObjectToString("Stamen Terrain"),RemoteObject.createImmutable("My Custom TS")})))));
 BA.debugLineNum = 66;BA.debugLine="MainForm.RootPane.AddNode(TileSourceSelector, 530";
Debug.ShouldStop(2);
main._mainform.runMethod(false,"getRootPane").runVoidMethod ("AddNode",(Object)((main._tilesourceselector.getObject())),(Object)(BA.numberCast(double.class, 530)),(Object)(BA.numberCast(double.class, 10)),(Object)(BA.numberCast(double.class, 135)),(Object)(BA.numberCast(double.class, 25)));
 BA.debugLineNum = 68;BA.debugLine="PerthButton.Initialize(\"PerthButton\")";
Debug.ShouldStop(8);
main._perthbutton.runVoidMethod ("Initialize",main.ba,(Object)(RemoteObject.createImmutable("PerthButton")));
 BA.debugLineNum = 69;BA.debugLine="PerthButton.Text=\"Perth\"";
Debug.ShouldStop(16);
main._perthbutton.runMethod(true,"setText",BA.ObjectToString("Perth"));
 BA.debugLineNum = 70;BA.debugLine="MainForm.RootPane.AddNode(PerthButton, 420, 10, 7";
Debug.ShouldStop(32);
main._mainform.runMethod(false,"getRootPane").runVoidMethod ("AddNode",(Object)((main._perthbutton.getObject())),(Object)(BA.numberCast(double.class, 420)),(Object)(BA.numberCast(double.class, 10)),(Object)(BA.numberCast(double.class, 75)),(Object)(BA.numberCast(double.class, 25)));
 BA.debugLineNum = 72;BA.debugLine="CairoButton.Initialize(\"CairoButton\")";
Debug.ShouldStop(128);
main._cairobutton.runVoidMethod ("Initialize",main.ba,(Object)(RemoteObject.createImmutable("CairoButton")));
 BA.debugLineNum = 73;BA.debugLine="CairoButton.Text=\"Cairo\"";
Debug.ShouldStop(256);
main._cairobutton.runMethod(true,"setText",BA.ObjectToString("Cairo"));
 BA.debugLineNum = 74;BA.debugLine="MainForm.RootPane.AddNode(CairoButton, 420, 10, 7";
Debug.ShouldStop(512);
main._mainform.runMethod(false,"getRootPane").runVoidMethod ("AddNode",(Object)((main._cairobutton.getObject())),(Object)(BA.numberCast(double.class, 420)),(Object)(BA.numberCast(double.class, 10)),(Object)(BA.numberCast(double.class, 75)),(Object)(BA.numberCast(double.class, 25)));
 BA.debugLineNum = 77;BA.debugLine="WorldButton.Initialize(\"WorldButton\")";
Debug.ShouldStop(4096);
main._worldbutton.runVoidMethod ("Initialize",main.ba,(Object)(RemoteObject.createImmutable("WorldButton")));
 BA.debugLineNum = 78;BA.debugLine="WorldButton.Text=\"World\"";
Debug.ShouldStop(8192);
main._worldbutton.runMethod(true,"setText",BA.ObjectToString("World"));
 BA.debugLineNum = 79;BA.debugLine="MainForm.RootPane.AddNode(WorldButton, 420, 10, 7";
Debug.ShouldStop(16384);
main._mainform.runMethod(false,"getRootPane").runVoidMethod ("AddNode",(Object)((main._worldbutton.getObject())),(Object)(BA.numberCast(double.class, 420)),(Object)(BA.numberCast(double.class, 10)),(Object)(BA.numberCast(double.class, 75)),(Object)(BA.numberCast(double.class, 25)));
 BA.debugLineNum = 81;BA.debugLine="MainForm.Show";
Debug.ShouldStop(65536);
main._mainform.runVoidMethodAndSync ("Show");
 BA.debugLineNum = 83;BA.debugLine="WorldButton_Action";
Debug.ShouldStop(262144);
_worldbutton_action();
 BA.debugLineNum = 84;BA.debugLine="TileSourceSelector.SelectedIndex = 0";
Debug.ShouldStop(524288);
main._tilesourceselector.runMethod(true,"setSelectedIndex",BA.numberCast(int.class, 0));
 BA.debugLineNum = 86;BA.debugLine="ShowTestPolygon";
Debug.ShouldStop(2097152);
_showtestpolygon();
 BA.debugLineNum = 87;BA.debugLine="OSM.WorkOffline(False)";
Debug.ShouldStop(4194304);
main._osm.runVoidMethod ("WorkOffline",(Object)(main.__c.getField(true,"False")));
 BA.debugLineNum = 88;BA.debugLine="OSM.SetGeoCoordinateLabelVisible(True)";
Debug.ShouldStop(8388608);
main._osm.runVoidMethod ("SetGeoCoordinateLabelVisible",(Object)(main.__c.getField(true,"True")));
 BA.debugLineNum = 89;BA.debugLine="OSM.SetAttributionOffset(0)";
Debug.ShouldStop(16777216);
main._osm.runVoidMethod ("SetAttributionOffset",(Object)(BA.numberCast(int.class, 0)));
 BA.debugLineNum = 90;BA.debugLine="End Sub";
Debug.ShouldStop(33554432);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _cairobutton_action() throws Exception{
try {
		Debug.PushSubsStack("CairoButton_Action (main) ","main",0,main.ba,main.mostCurrent,99);
if (RapidSub.canDelegate("cairobutton_action")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","cairobutton_action");
 BA.debugLineNum = 99;BA.debugLine="Sub CairoButton_Action";
Debug.ShouldStop(4);
 BA.debugLineNum = 100;BA.debugLine="Log(\"CairoButton_Action\")";
Debug.ShouldStop(8);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("CairoButton_Action")));
 BA.debugLineNum = 101;BA.debugLine="InfoWindow.Visible=False";
Debug.ShouldStop(16);
main._infowindow.runMethod(true,"setVisible",main.__c.getField(true,"False"));
 BA.debugLineNum = 102;BA.debugLine="OSM.SetDisplayPositionByLatLon2(30.1,31.2,8)";
Debug.ShouldStop(32);
main._osm.runVoidMethod ("SetDisplayPositionByLatLon2",(Object)(BA.numberCast(double.class, 30.1)),(Object)(BA.numberCast(double.class, 31.2)),(Object)(BA.numberCast(int.class, 8)));
 BA.debugLineNum = 103;BA.debugLine="End Sub";
Debug.ShouldStop(64);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _cairospot_mouseclicked(RemoteObject _spot,RemoteObject _mouseevent1) throws Exception{
try {
		Debug.PushSubsStack("CairoSpot_MouseClicked (main) ","main",0,main.ba,main.mostCurrent,224);
if (RapidSub.canDelegate("cairospot_mouseclicked")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","cairospot_mouseclicked", _spot, _mouseevent1);
Debug.locals.put("Spot", _spot);
Debug.locals.put("MouseEvent1", _mouseevent1);
 BA.debugLineNum = 224;BA.debugLine="Sub CairoSpot_MouseClicked(Spot As MapSpot, MouseE";
Debug.ShouldStop(-2147483648);
 BA.debugLineNum = 225;BA.debugLine="Log(\"CairoSpot_MouseClicked: \"& Spot.GetLat & \",";
Debug.ShouldStop(1);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.concat(RemoteObject.createImmutable("CairoSpot_MouseClicked: "),_spot.runMethod(true,"GetLat"),RemoteObject.createImmutable(", "),_spot.runMethod(true,"GetLon"))));
 BA.debugLineNum = 226;BA.debugLine="ShowHostedNode(Spot.GetLat,Spot.GetLon,Spot.Title";
Debug.ShouldStop(2);
_showhostednode(_spot.runMethod(true,"GetLat"),_spot.runMethod(true,"GetLon"),_spot.runMethod(true,"getTitle"),_spot.runMethod(true,"getDescription"));
 BA.debugLineNum = 227;BA.debugLine="End Sub";
Debug.ShouldStop(4);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _cairospot_mousedragged(RemoteObject _spot,RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("CairoSpot_MouseDragged (main) ","main",0,main.ba,main.mostCurrent,236);
if (RapidSub.canDelegate("cairospot_mousedragged")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","cairospot_mousedragged", _spot, _eventdata);
RemoteObject _dragpoint = RemoteObject.declareNull("starchild.b4j.jfxtras.labs.map.Coordinate");
Debug.locals.put("Spot", _spot);
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 236;BA.debugLine="Sub CairoSpot_MouseDragged(Spot As MapSpot, EventD";
Debug.ShouldStop(2048);
 BA.debugLineNum = 238;BA.debugLine="Dim DragPoint As Coordinate=OSM.GetCoordinate(Spo";
Debug.ShouldStop(8192);
_dragpoint = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.Coordinate");
_dragpoint = main._osm.runMethod(false,"GetCoordinate",(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_spot.runMethod(true,"X"),_eventdata.runMethod(true,"getX")}, "+",1, 0))),(Object)(BA.numberCast(int.class, RemoteObject.solve(new RemoteObject[] {_spot.runMethod(true,"Y"),_eventdata.runMethod(true,"getY")}, "+",1, 0))));Debug.locals.put("DragPoint", _dragpoint);Debug.locals.put("DragPoint", _dragpoint);
 BA.debugLineNum = 239;BA.debugLine="Log(\"CairoSpot_MouseDragged: \" & EventData.X & \"";
Debug.ShouldStop(16384);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.concat(RemoteObject.createImmutable("CairoSpot_MouseDragged: "),_eventdata.runMethod(true,"getX"),RemoteObject.createImmutable("   "),_eventdata.runMethod(true,"getY"))));
 BA.debugLineNum = 240;BA.debugLine="Spot.MoveTo(DragPoint.GetLatitude,DragPoint.GetLo";
Debug.ShouldStop(32768);
_spot.runVoidMethod ("MoveTo",(Object)(_dragpoint.runMethod(true,"GetLatitude")),(Object)(_dragpoint.runMethod(true,"GetLongitude")));
 BA.debugLineNum = 241;BA.debugLine="End Sub";
Debug.ShouldStop(65536);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _cairospot_mousepressed(RemoteObject _spot,RemoteObject _mouseevent1) throws Exception{
try {
		Debug.PushSubsStack("CairoSpot_MousePressed (main) ","main",0,main.ba,main.mostCurrent,228);
if (RapidSub.canDelegate("cairospot_mousepressed")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","cairospot_mousepressed", _spot, _mouseevent1);
Debug.locals.put("Spot", _spot);
Debug.locals.put("MouseEvent1", _mouseevent1);
 BA.debugLineNum = 228;BA.debugLine="Sub CairoSpot_MousePressed(Spot As MapSpot, MouseE";
Debug.ShouldStop(8);
 BA.debugLineNum = 229;BA.debugLine="Log(\"CairoSpot_MousePressed: \")";
Debug.ShouldStop(16);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("CairoSpot_MousePressed: ")));
 BA.debugLineNum = 230;BA.debugLine="OSM.MapDraggable = False";
Debug.ShouldStop(32);
main._osm.runMethod(true,"setMapDraggable",main.__c.getField(true,"False"));
 BA.debugLineNum = 231;BA.debugLine="End Sub";
Debug.ShouldStop(64);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _cairospot_mousereleased(RemoteObject _spot,RemoteObject _mouseevent1) throws Exception{
try {
		Debug.PushSubsStack("CairoSpot_MouseReleased (main) ","main",0,main.ba,main.mostCurrent,232);
if (RapidSub.canDelegate("cairospot_mousereleased")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","cairospot_mousereleased", _spot, _mouseevent1);
Debug.locals.put("Spot", _spot);
Debug.locals.put("MouseEvent1", _mouseevent1);
 BA.debugLineNum = 232;BA.debugLine="Sub CairoSpot_MouseReleased(Spot As MapSpot, Mouse";
Debug.ShouldStop(128);
 BA.debugLineNum = 233;BA.debugLine="Log(\"CairoSpot_MouseReleased: \")";
Debug.ShouldStop(256);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("CairoSpot_MouseReleased: ")));
 BA.debugLineNum = 234;BA.debugLine="OSM.MapDraggable = True";
Debug.ShouldStop(512);
main._osm.runMethod(true,"setMapDraggable",main.__c.getField(true,"True"));
 BA.debugLineNum = 235;BA.debugLine="End Sub";
Debug.ShouldStop(1024);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _createmycustomtilesource() throws Exception{
try {
		Debug.PushSubsStack("CreateMyCustomTileSource (main) ","main",0,main.ba,main.mostCurrent,176);
if (RapidSub.canDelegate("createmycustomtilesource")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","createmycustomtilesource");
RemoteObject _cs = RemoteObject.declareNull("starchild.b4j.jfxtras.labs.map.tile.CustomTileSource");
 BA.debugLineNum = 176;BA.debugLine="Sub CreateMyCustomTileSource As TileSource";
Debug.ShouldStop(32768);
 BA.debugLineNum = 177;BA.debugLine="Dim cs As MapCustomTileSource";
Debug.ShouldStop(65536);
_cs = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.tile.CustomTileSource");Debug.locals.put("cs", _cs);
 BA.debugLineNum = 178;BA.debugLine="OSM.ClearMapCache2(\"My-Custom-TS\")";
Debug.ShouldStop(131072);
main._osm.runVoidMethod ("ClearMapCache2",(Object)(RemoteObject.createImmutable("My-Custom-TS")));
 BA.debugLineNum = 179;BA.debugLine="cs.Initialize2(\"My-Custom-TS\",\"http://cartodb-bas";
Debug.ShouldStop(262144);
_cs.runVoidMethod ("Initialize2",(Object)(BA.ObjectToString("My-Custom-TS")),(Object)(BA.ObjectToString("http://cartodb-basemaps-a.global.ssl.fastly.net/light_all")),(Object)(BA.numberCast(int.class, 1)),(Object)(BA.numberCast(int.class, 18)));
 BA.debugLineNum = 181;BA.debugLine="cs.SetAttributionText(\"My Custom Tile Source\")";
Debug.ShouldStop(1048576);
_cs.runVoidMethod ("SetAttributionText",(Object)(RemoteObject.createImmutable("My Custom Tile Source")));
 BA.debugLineNum = 182;BA.debugLine="cs.SetTermsOfUseText(\"Custom Terms of Use\")";
Debug.ShouldStop(2097152);
_cs.runVoidMethod ("SetTermsOfUseText",(Object)(RemoteObject.createImmutable("Custom Terms of Use")));
 BA.debugLineNum = 183;BA.debugLine="cs.SetTermsOfUseURL(\"www.b4x.com\")";
Debug.ShouldStop(4194304);
_cs.runVoidMethod ("SetTermsOfUseURL",(Object)(RemoteObject.createImmutable("www.b4x.com")));
 BA.debugLineNum = 184;BA.debugLine="cs.SetAttributionColor(fx.Colors.Black)";
Debug.ShouldStop(8388608);
_cs.runVoidMethod ("SetAttributionColor",(Object)((main._fx.getField(false,"Colors").getField(false,"Black"))));
 BA.debugLineNum = 185;BA.debugLine="Return cs";
Debug.ShouldStop(16777216);
if (true) return RemoteObject.declareNull("anywheresoftware.b4a.AbsObjectWrapper").runMethod(false, "ConvertToWrapper", RemoteObject.createNew("starchild.b4j.jfxtras.labs.map.tile.TileSource"), _cs.getObject());
 BA.debugLineNum = 186;BA.debugLine="End Sub";
Debug.ShouldStop(33554432);
return RemoteObject.createImmutable(null);
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _mainform_resize(RemoteObject _width,RemoteObject _height) throws Exception{
try {
		Debug.PushSubsStack("MainForm_Resize (main) ","main",0,main.ba,main.mostCurrent,146);
if (RapidSub.canDelegate("mainform_resize")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","mainform_resize", _width, _height);
Debug.locals.put("Width", _width);
Debug.locals.put("Height", _height);
 BA.debugLineNum = 146;BA.debugLine="Private Sub MainForm_Resize (Width As Double, Heig";
Debug.ShouldStop(131072);
 BA.debugLineNum = 147;BA.debugLine="Log(\"MainForm_Resize\")";
Debug.ShouldStop(262144);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("MainForm_Resize")));
 BA.debugLineNum = 148;BA.debugLine="OSM.SetMapWidth(Width)";
Debug.ShouldStop(524288);
main._osm.runVoidMethod ("SetMapWidth",(Object)(_width));
 BA.debugLineNum = 149;BA.debugLine="OSM.SetMapHeight(Height)";
Debug.ShouldStop(1048576);
main._osm.runVoidMethod ("SetMapHeight",(Object)(_height));
 BA.debugLineNum = 150;BA.debugLine="TileSourceSelector.Left = Width - TileSourceSelec";
Debug.ShouldStop(2097152);
main._tilesourceselector.runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {_width,main._tilesourceselector.runMethod(true,"getWidth"),RemoteObject.createImmutable(10)}, "--",2, 0));
 BA.debugLineNum = 151;BA.debugLine="PerthButton.Left = TileSourceSelector.Left - Pert";
Debug.ShouldStop(4194304);
main._perthbutton.runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {main._tilesourceselector.runMethod(true,"getLeft"),main._perthbutton.runMethod(true,"getWidth"),RemoteObject.createImmutable(10)}, "--",2, 0));
 BA.debugLineNum = 152;BA.debugLine="CairoButton.Left = PerthButton.Left - CairoButton";
Debug.ShouldStop(8388608);
main._cairobutton.runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {main._perthbutton.runMethod(true,"getLeft"),main._cairobutton.runMethod(true,"getWidth"),RemoteObject.createImmutable(10)}, "--",2, 0));
 BA.debugLineNum = 153;BA.debugLine="WorldButton.Left = CairoButton.Left - WorldButton";
Debug.ShouldStop(16777216);
main._worldbutton.runMethod(true,"setLeft",RemoteObject.solve(new RemoteObject[] {main._cairobutton.runMethod(true,"getLeft"),main._worldbutton.runMethod(true,"getWidth"),RemoteObject.createImmutable(10)}, "--",2, 0));
 BA.debugLineNum = 154;BA.debugLine="End Sub";
Debug.ShouldStop(33554432);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _osm_mouseclicked(RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("OSM_MouseClicked (main) ","main",0,main.ba,main.mostCurrent,192);
if (RapidSub.canDelegate("osm_mouseclicked")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","osm_mouseclicked", _eventdata);
RemoteObject _clickpoint = RemoteObject.declareNull("starchild.b4j.jfxtras.labs.map.Coordinate");
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 192;BA.debugLine="Sub OSM_MouseClicked(EventData As MouseEvent)";
Debug.ShouldStop(-2147483648);
 BA.debugLineNum = 193;BA.debugLine="Dim ClickPoint As Coordinate=OSM.GetCoordinate(Ev";
Debug.ShouldStop(1);
_clickpoint = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.Coordinate");
_clickpoint = main._osm.runMethod(false,"GetCoordinate",(Object)(BA.numberCast(int.class, _eventdata.runMethod(true,"getX"))),(Object)(BA.numberCast(int.class, _eventdata.runMethod(true,"getY"))));Debug.locals.put("ClickPoint", _clickpoint);Debug.locals.put("ClickPoint", _clickpoint);
 BA.debugLineNum = 194;BA.debugLine="Log(\"OSM_MouseClicked: \"&ClickPoint.GetLatitude&\"";
Debug.ShouldStop(2);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.concat(RemoteObject.createImmutable("OSM_MouseClicked: "),_clickpoint.runMethod(true,"GetLatitude"),RemoteObject.createImmutable(", "),_clickpoint.runMethod(true,"GetLongitude"))));
 BA.debugLineNum = 195;BA.debugLine="InfoWindow.Visible=False";
Debug.ShouldStop(4);
main._infowindow.runMethod(true,"setVisible",main.__c.getField(true,"False"));
 BA.debugLineNum = 196;BA.debugLine="End Sub";
Debug.ShouldStop(8);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _osm_mousedragged(RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("OSM_MouseDragged (main) ","main",0,main.ba,main.mostCurrent,202);
if (RapidSub.canDelegate("osm_mousedragged")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","osm_mousedragged", _eventdata);
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 202;BA.debugLine="Sub OSM_MouseDragged(EventData As MouseEvent)";
Debug.ShouldStop(512);
 BA.debugLineNum = 203;BA.debugLine="Log(\"OSM_MouseDragged\")";
Debug.ShouldStop(1024);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("OSM_MouseDragged")));
 BA.debugLineNum = 204;BA.debugLine="End Sub";
Debug.ShouldStop(2048);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _osm_mousemoved(RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("OSM_MouseMoved (main) ","main",0,main.ba,main.mostCurrent,198);
if (RapidSub.canDelegate("osm_mousemoved")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","osm_mousemoved", _eventdata);
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 198;BA.debugLine="Sub OSM_MouseMoved(EventData As MouseEvent)";
Debug.ShouldStop(32);
 BA.debugLineNum = 199;BA.debugLine="Log(\"OSM_MouseMoved\")";
Debug.ShouldStop(64);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("OSM_MouseMoved")));
 BA.debugLineNum = 200;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _osm_mousepressed(RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("OSM_MousePressed (main) ","main",0,main.ba,main.mostCurrent,188);
if (RapidSub.canDelegate("osm_mousepressed")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","osm_mousepressed", _eventdata);
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 188;BA.debugLine="Sub OSM_MousePressed(EventData As MouseEvent)";
Debug.ShouldStop(134217728);
 BA.debugLineNum = 189;BA.debugLine="Log(\"OSM_MousePressed\")";
Debug.ShouldStop(268435456);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("OSM_MousePressed")));
 BA.debugLineNum = 190;BA.debugLine="End Sub";
Debug.ShouldStop(536870912);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _osm_mousereleased(RemoteObject _eventdata) throws Exception{
try {
		Debug.PushSubsStack("OSM_MouseReleased (main) ","main",0,main.ba,main.mostCurrent,206);
if (RapidSub.canDelegate("osm_mousereleased")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","osm_mousereleased", _eventdata);
Debug.locals.put("EventData", _eventdata);
 BA.debugLineNum = 206;BA.debugLine="Sub OSM_MouseReleased(EventData As MouseEvent)";
Debug.ShouldStop(8192);
 BA.debugLineNum = 207;BA.debugLine="Log(\"OSM_MouseReleased\")";
Debug.ShouldStop(16384);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("OSM_MouseReleased")));
 BA.debugLineNum = 208;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _osm_ready() throws Exception{
try {
		Debug.PushSubsStack("OSM_Ready (main) ","main",0,main.ba,main.mostCurrent,210);
if (RapidSub.canDelegate("osm_ready")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","osm_ready");
 BA.debugLineNum = 210;BA.debugLine="Sub OSM_Ready()";
Debug.ShouldStop(131072);
 BA.debugLineNum = 211;BA.debugLine="Log(\"OSM_Ready\")";
Debug.ShouldStop(262144);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("OSM_Ready")));
 BA.debugLineNum = 212;BA.debugLine="End Sub";
Debug.ShouldStop(524288);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _osm_rendered() throws Exception{
try {
		Debug.PushSubsStack("OSM_Rendered (main) ","main",0,main.ba,main.mostCurrent,214);
if (RapidSub.canDelegate("osm_rendered")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","osm_rendered");
 BA.debugLineNum = 214;BA.debugLine="Sub OSM_Rendered()";
Debug.ShouldStop(2097152);
 BA.debugLineNum = 215;BA.debugLine="Log(\"OSM_Rendered\")";
Debug.ShouldStop(4194304);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("OSM_Rendered")));
 BA.debugLineNum = 216;BA.debugLine="End Sub";
Debug.ShouldStop(8388608);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _perthbutton_action() throws Exception{
try {
		Debug.PushSubsStack("PerthButton_Action (main) ","main",0,main.ba,main.mostCurrent,93);
if (RapidSub.canDelegate("perthbutton_action")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","perthbutton_action");
 BA.debugLineNum = 93;BA.debugLine="Sub PerthButton_Action";
Debug.ShouldStop(268435456);
 BA.debugLineNum = 94;BA.debugLine="Log(\"PerthButton_Action\")";
Debug.ShouldStop(536870912);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("PerthButton_Action")));
 BA.debugLineNum = 95;BA.debugLine="InfoWindow.Visible=False";
Debug.ShouldStop(1073741824);
main._infowindow.runMethod(true,"setVisible",main.__c.getField(true,"False"));
 BA.debugLineNum = 96;BA.debugLine="OSM.SetDisplayPositionByLatLon2(-31.92,115.83,13)";
Debug.ShouldStop(-2147483648);
main._osm.runVoidMethod ("SetDisplayPositionByLatLon2",(Object)(BA.numberCast(double.class, -31.92)),(Object)(BA.numberCast(double.class, 115.83)),(Object)(BA.numberCast(int.class, 13)));
 BA.debugLineNum = 97;BA.debugLine="End Sub";
Debug.ShouldStop(1);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _perthmarker_mouseclicked(RemoteObject _marker,RemoteObject _mouseevent1) throws Exception{
try {
		Debug.PushSubsStack("PerthMarker_MouseClicked (main) ","main",0,main.ba,main.mostCurrent,218);
if (RapidSub.canDelegate("perthmarker_mouseclicked")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","perthmarker_mouseclicked", _marker, _mouseevent1);
Debug.locals.put("Marker", _marker);
Debug.locals.put("MouseEvent1", _mouseevent1);
 BA.debugLineNum = 218;BA.debugLine="Sub PerthMarker_MouseClicked(Marker As MapMarker,";
Debug.ShouldStop(33554432);
 BA.debugLineNum = 219;BA.debugLine="Log(\"PerthMarker_MouseClicked: \"& Marker.GetLat&\"";
Debug.ShouldStop(67108864);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.concat(RemoteObject.createImmutable("PerthMarker_MouseClicked: "),_marker.runMethod(true,"GetLat"),RemoteObject.createImmutable(", "),_marker.runMethod(true,"GetLon"))));
 BA.debugLineNum = 220;BA.debugLine="ShowHostedNode(Marker.GetLat,Marker.GetLon,Marker";
Debug.ShouldStop(134217728);
_showhostednode(_marker.runMethod(true,"GetLat"),_marker.runMethod(true,"GetLon"),_marker.runMethod(true,"getTitle"),_marker.runMethod(true,"getDescription"));
 BA.debugLineNum = 222;BA.debugLine="End Sub";
Debug.ShouldStop(536870912);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}

private static boolean processGlobalsRun;
public static void initializeProcessGlobals() {
    
    if (main.processGlobalsRun == false) {
	    main.processGlobalsRun = true;
		try {
		        main_subs_0._process_globals();
main.myClass = BA.getDeviceClass ("starchild.osm.test.main");
		
        } catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}public static RemoteObject  _process_globals() throws Exception{
 //BA.debugLineNum = 6;BA.debugLine="Sub Process_Globals";
 //BA.debugLineNum = 7;BA.debugLine="Private fx As JFX";
main._fx = RemoteObject.createNew ("anywheresoftware.b4j.objects.JFX");
 //BA.debugLineNum = 9;BA.debugLine="Private InfoWindow As AnchorPane";
main._infowindow = RemoteObject.createNew ("anywheresoftware.b4j.objects.PaneWrapper.AnchorPaneWrapper");
 //BA.debugLineNum = 10;BA.debugLine="Private InfoWindowDescLabel As Label";
main._infowindowdesclabel = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");
 //BA.debugLineNum = 11;BA.debugLine="Private InfoWindowTitleLabel As Label";
main._infowindowtitlelabel = RemoteObject.createNew ("anywheresoftware.b4j.objects.LabelWrapper");
 //BA.debugLineNum = 12;BA.debugLine="Private MainForm As Form";
main._mainform = RemoteObject.createNew ("anywheresoftware.b4j.objects.Form");
 //BA.debugLineNum = 13;BA.debugLine="Private OsmTileSource As OsmTileSource";
main._osmtilesource = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.tile.osm.OsmTileSourceFactory");
 //BA.debugLineNum = 14;BA.debugLine="Private TileSourceSelector As ComboBox";
main._tilesourceselector = RemoteObject.createNew ("anywheresoftware.b4j.objects.ComboBoxWrapper");
 //BA.debugLineNum = 16;BA.debugLine="Private OSM As OpenStreetMaps";
main._osm = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.MapPane");
 //BA.debugLineNum = 17;BA.debugLine="Private MapNodeHost1 As MapNodeHost";
main._mapnodehost1 = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.render.MapNodeHost");
 //BA.debugLineNum = 19;BA.debugLine="Private MapIcons As MapIcons";
main._mapicons = RemoteObject.createNew ("starchild.b4j.extras.DefaultMapIcons");
 //BA.debugLineNum = 20;BA.debugLine="Private Pin1 As MapMarker";
main._pin1 = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.render.ImageMapMarker");
 //BA.debugLineNum = 21;BA.debugLine="Private Spot1 As MapSpot";
main._spot1 = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.render.SimpleMapMarker");
 //BA.debugLineNum = 23;BA.debugLine="Private P As MapPolygon";
main._p = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.render.DefaultMapPolygon");
 //BA.debugLineNum = 25;BA.debugLine="Private PerthButton As Button";
main._perthbutton = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");
 //BA.debugLineNum = 26;BA.debugLine="Private CairoButton As Button";
main._cairobutton = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");
 //BA.debugLineNum = 27;BA.debugLine="Private WorldButton As Button";
main._worldbutton = RemoteObject.createNew ("anywheresoftware.b4j.objects.ButtonWrapper");
 //BA.debugLineNum = 28;BA.debugLine="End Sub";
return RemoteObject.createImmutable("");
}
public static RemoteObject  _setmaximized(RemoteObject _frm) throws Exception{
try {
		Debug.PushSubsStack("SetMaximized (main) ","main",0,main.ba,main.mostCurrent,170);
if (RapidSub.canDelegate("setmaximized")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","setmaximized", _frm);
RemoteObject _joform = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
RemoteObject _jostage = RemoteObject.declareNull("anywheresoftware.b4j.object.JavaObject");
Debug.locals.put("frm", _frm);
 BA.debugLineNum = 170;BA.debugLine="Public Sub SetMaximized(frm As Form)";
Debug.ShouldStop(512);
 BA.debugLineNum = 171;BA.debugLine="Dim joForm As JavaObject = frm";
Debug.ShouldStop(1024);
_joform = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_joform.setObject(_frm);Debug.locals.put("joForm", _joform);
 BA.debugLineNum = 172;BA.debugLine="Dim joStage As JavaObject = joForm.GetField(\"stag";
Debug.ShouldStop(2048);
_jostage = RemoteObject.createNew ("anywheresoftware.b4j.object.JavaObject");
_jostage.setObject(_joform.runMethod(false,"GetField",(Object)(RemoteObject.createImmutable("stage"))));Debug.locals.put("joStage", _jostage);
 BA.debugLineNum = 173;BA.debugLine="joStage.RunMethod(\"setMaximized\", Array(True))";
Debug.ShouldStop(4096);
_jostage.runVoidMethod ("RunMethod",(Object)(BA.ObjectToString("setMaximized")),(Object)(RemoteObject.createNewArray("Object",new int[] {1},new Object[] {(main.__c.getField(true,"True"))})));
 BA.debugLineNum = 174;BA.debugLine="End Sub";
Debug.ShouldStop(8192);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _showhostednode(RemoteObject _latitude,RemoteObject _longitude,RemoteObject _text,RemoteObject _description) throws Exception{
try {
		Debug.PushSubsStack("ShowHostedNode (main) ","main",0,main.ba,main.mostCurrent,111);
if (RapidSub.canDelegate("showhostednode")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","showhostednode", _latitude, _longitude, _text, _description);
Debug.locals.put("Latitude", _latitude);
Debug.locals.put("Longitude", _longitude);
Debug.locals.put("Text", _text);
Debug.locals.put("Description", _description);
 BA.debugLineNum = 111;BA.debugLine="Sub ShowHostedNode(Latitude As Double, Longitude A";
Debug.ShouldStop(16384);
 BA.debugLineNum = 112;BA.debugLine="MapNodeHost1.SetLat(Latitude)";
Debug.ShouldStop(32768);
main._mapnodehost1.runVoidMethod ("SetLat",(Object)(_latitude));
 BA.debugLineNum = 113;BA.debugLine="MapNodeHost1.SetLon(Longitude)";
Debug.ShouldStop(65536);
main._mapnodehost1.runVoidMethod ("SetLon",(Object)(_longitude));
 BA.debugLineNum = 114;BA.debugLine="InfoWindowTitleLabel.Text=Text";
Debug.ShouldStop(131072);
main._infowindowtitlelabel.runMethod(true,"setText",_text);
 BA.debugLineNum = 115;BA.debugLine="InfoWindowDescLabel.Text=Description";
Debug.ShouldStop(262144);
main._infowindowdesclabel.runMethod(true,"setText",_description);
 BA.debugLineNum = 116;BA.debugLine="InfoWindow.Visible=True";
Debug.ShouldStop(524288);
main._infowindow.runMethod(true,"setVisible",main.__c.getField(true,"True"));
 BA.debugLineNum = 117;BA.debugLine="MapNodeHost1.Render(OSM)";
Debug.ShouldStop(1048576);
main._mapnodehost1.runVoidMethod ("Render",(Object)((main._osm.getObject())));
 BA.debugLineNum = 118;BA.debugLine="End Sub";
Debug.ShouldStop(2097152);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _showtestpolygon() throws Exception{
try {
		Debug.PushSubsStack("ShowTestPolygon (main) ","main",0,main.ba,main.mostCurrent,156);
if (RapidSub.canDelegate("showtestpolygon")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","showtestpolygon");
RemoteObject _l = RemoteObject.declareNull("anywheresoftware.b4a.objects.collections.List");
RemoteObject _c = RemoteObject.declareNull("starchild.b4j.jfxtras.labs.map.Coordinate");
 BA.debugLineNum = 156;BA.debugLine="Private Sub ShowTestPolygon";
Debug.ShouldStop(134217728);
 BA.debugLineNum = 157;BA.debugLine="Dim l As List";
Debug.ShouldStop(268435456);
_l = RemoteObject.createNew ("anywheresoftware.b4a.objects.collections.List");Debug.locals.put("l", _l);
 BA.debugLineNum = 158;BA.debugLine="l.Initialize";
Debug.ShouldStop(536870912);
_l.runVoidMethod ("Initialize");
 BA.debugLineNum = 159;BA.debugLine="Dim c As Coordinate";
Debug.ShouldStop(1073741824);
_c = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.Coordinate");Debug.locals.put("c", _c);
 BA.debugLineNum = 160;BA.debugLine="c.Initialize(-10,-10)";
Debug.ShouldStop(-2147483648);
_c.runVoidMethod ("Initialize",(Object)(BA.numberCast(double.class, -(double) (0 + 10))),(Object)(BA.numberCast(double.class, -(double) (0 + 10))));
 BA.debugLineNum = 161;BA.debugLine="l.Add(c)";
Debug.ShouldStop(1);
_l.runVoidMethod ("Add",(Object)((_c.getObject())));
 BA.debugLineNum = 162;BA.debugLine="c.Initialize(10,10)";
Debug.ShouldStop(2);
_c.runVoidMethod ("Initialize",(Object)(BA.numberCast(double.class, 10)),(Object)(BA.numberCast(double.class, 10)));
 BA.debugLineNum = 163;BA.debugLine="l.Add(c)";
Debug.ShouldStop(4);
_l.runVoidMethod ("Add",(Object)((_c.getObject())));
 BA.debugLineNum = 164;BA.debugLine="c.Initialize(-10,20)";
Debug.ShouldStop(8);
_c.runVoidMethod ("Initialize",(Object)(BA.numberCast(double.class, -(double) (0 + 10))),(Object)(BA.numberCast(double.class, 20)));
 BA.debugLineNum = 165;BA.debugLine="l.Add(c)";
Debug.ShouldStop(16);
_l.runVoidMethod ("Add",(Object)((_c.getObject())));
 BA.debugLineNum = 166;BA.debugLine="P.Initialize2(\"Test Polygon\",fx.Colors.Gray,2,fx.";
Debug.ShouldStop(32);
main._p.runVoidMethod ("Initialize2",(Object)(BA.ObjectToString("Test Polygon")),(Object)((main._fx.getField(false,"Colors").getField(false,"Gray"))),(Object)(BA.numberCast(double.class, 2)),(Object)(main._fx.getField(false,"Colors").runMethod(false,"ARGB",(Object)(BA.numberCast(int.class, 50)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 0)),(Object)(BA.numberCast(int.class, 255)))),(Object)(_l));
 BA.debugLineNum = 167;BA.debugLine="OSM.AddPolygon(P)";
Debug.ShouldStop(64);
main._osm.runVoidMethod ("AddPolygon",(Object)((main._p.getObject())));
 BA.debugLineNum = 168;BA.debugLine="End Sub";
Debug.ShouldStop(128);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _tilesourceselector_selectedindexchanged(RemoteObject _index,RemoteObject _value) throws Exception{
try {
		Debug.PushSubsStack("TileSourceSelector_SelectedIndexChanged (main) ","main",0,main.ba,main.mostCurrent,120);
if (RapidSub.canDelegate("tilesourceselector_selectedindexchanged")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","tilesourceselector_selectedindexchanged", _index, _value);
RemoteObject _name = RemoteObject.createImmutable("");
RemoteObject _ts = RemoteObject.declareNull("starchild.b4j.jfxtras.labs.map.tile.TileSource");
Debug.locals.put("Index", _index);
Debug.locals.put("Value", _value);
 BA.debugLineNum = 120;BA.debugLine="Sub TileSourceSelector_SelectedIndexChanged(Index";
Debug.ShouldStop(8388608);
 BA.debugLineNum = 121;BA.debugLine="Dim Name As String = Value";
Debug.ShouldStop(16777216);
_name = BA.ObjectToString(_value);Debug.locals.put("Name", _name);Debug.locals.put("Name", _name);
 BA.debugLineNum = 122;BA.debugLine="Select Name";
Debug.ShouldStop(33554432);
switch (BA.switchObjectToInt(_name,BA.ObjectToString("Mapnik STD"),BA.ObjectToString("Mapnik BW"),BA.ObjectToString("Open Street Map"),BA.ObjectToString("BaseMaps Light"),BA.ObjectToString("BaseMaps Dark"),BA.ObjectToString("Stamen BW"),BA.ObjectToString("Stamen Terrain"),BA.ObjectToString("My Custom TS"))) {
case 0: {
 BA.debugLineNum = 124;BA.debugLine="Dim ts As TileSource = OsmTileSource.Create(Osm";
Debug.ShouldStop(134217728);
_ts = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.tile.TileSource");
_ts = main._osmtilesource.runMethod(false,"Create",(Object)(main._osmtilesource.getField(false,"TS_MAPNIK_STD")));Debug.locals.put("ts", _ts);Debug.locals.put("ts", _ts);
 break; }
case 1: {
 BA.debugLineNum = 126;BA.debugLine="Dim ts As TileSource = OsmTileSource.Create(Osm";
Debug.ShouldStop(536870912);
_ts = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.tile.TileSource");
_ts = main._osmtilesource.runMethod(false,"Create",(Object)(main._osmtilesource.getField(false,"TS_MAPNIK_BW")));Debug.locals.put("ts", _ts);Debug.locals.put("ts", _ts);
 break; }
case 2: {
 BA.debugLineNum = 128;BA.debugLine="Dim ts As TileSource = OsmTileSource.Create(Osm";
Debug.ShouldStop(-2147483648);
_ts = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.tile.TileSource");
_ts = main._osmtilesource.runMethod(false,"Create",(Object)(main._osmtilesource.getField(false,"TS_OPEN_STREET_MAP")));Debug.locals.put("ts", _ts);Debug.locals.put("ts", _ts);
 break; }
case 3: {
 BA.debugLineNum = 130;BA.debugLine="Dim ts As TileSource = OsmTileSource.Create(Osm";
Debug.ShouldStop(2);
_ts = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.tile.TileSource");
_ts = main._osmtilesource.runMethod(false,"Create",(Object)(main._osmtilesource.getField(false,"TS_BASEPAKS_LIGHT")));Debug.locals.put("ts", _ts);Debug.locals.put("ts", _ts);
 break; }
case 4: {
 BA.debugLineNum = 132;BA.debugLine="Dim ts As TileSource = OsmTileSource.Create(Osm";
Debug.ShouldStop(8);
_ts = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.tile.TileSource");
_ts = main._osmtilesource.runMethod(false,"Create",(Object)(main._osmtilesource.getField(false,"TS_BASEMAPS_DARK")));Debug.locals.put("ts", _ts);Debug.locals.put("ts", _ts);
 break; }
case 5: {
 BA.debugLineNum = 134;BA.debugLine="Dim ts As TileSource = OsmTileSource.Create(Osm";
Debug.ShouldStop(32);
_ts = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.tile.TileSource");
_ts = main._osmtilesource.runMethod(false,"Create",(Object)(main._osmtilesource.getField(false,"TS_STAMEN_BW")));Debug.locals.put("ts", _ts);Debug.locals.put("ts", _ts);
 break; }
case 6: {
 BA.debugLineNum = 136;BA.debugLine="Dim ts As TileSource = OsmTileSource.Create(Osm";
Debug.ShouldStop(128);
_ts = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.tile.TileSource");
_ts = main._osmtilesource.runMethod(false,"Create",(Object)(main._osmtilesource.getField(false,"TS_STAMEN_TERRAIN")));Debug.locals.put("ts", _ts);Debug.locals.put("ts", _ts);
 break; }
case 7: {
 BA.debugLineNum = 138;BA.debugLine="Dim ts As TileSource = CreateMyCustomTileSource";
Debug.ShouldStop(512);
_ts = RemoteObject.createNew ("starchild.b4j.jfxtras.labs.map.tile.TileSource");
_ts = _createmycustomtilesource();Debug.locals.put("ts", _ts);Debug.locals.put("ts", _ts);
 break; }
default: {
 BA.debugLineNum = 140;BA.debugLine="Log(\"TileSourceSelector_SelectedIndexChanged: U";
Debug.ShouldStop(2048);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.concat(RemoteObject.createImmutable("TileSourceSelector_SelectedIndexChanged: Unknown Type("),_name,RemoteObject.createImmutable(")"))));
 BA.debugLineNum = 141;BA.debugLine="Return";
Debug.ShouldStop(4096);
if (true) return RemoteObject.createImmutable("");
 break; }
}
;
 BA.debugLineNum = 143;BA.debugLine="OSM.SetTileSource(ts)";
Debug.ShouldStop(16384);
main._osm.runVoidMethod ("SetTileSource",(Object)((_ts.getObject())));
 BA.debugLineNum = 144;BA.debugLine="End Sub";
Debug.ShouldStop(32768);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
public static RemoteObject  _worldbutton_action() throws Exception{
try {
		Debug.PushSubsStack("WorldButton_Action (main) ","main",0,main.ba,main.mostCurrent,105);
if (RapidSub.canDelegate("worldbutton_action")) return starchild.osm.test.main.remoteMe.runUserSub(false, "main","worldbutton_action");
 BA.debugLineNum = 105;BA.debugLine="Sub WorldButton_Action";
Debug.ShouldStop(256);
 BA.debugLineNum = 106;BA.debugLine="Log(\"WorldButton_Action\")";
Debug.ShouldStop(512);
main.__c.runVoidMethod ("Log",(Object)(RemoteObject.createImmutable("WorldButton_Action")));
 BA.debugLineNum = 107;BA.debugLine="InfoWindow.Visible=False";
Debug.ShouldStop(1024);
main._infowindow.runMethod(true,"setVisible",main.__c.getField(true,"False"));
 BA.debugLineNum = 108;BA.debugLine="OSM.SetDisplayPositionByLatLon2(12,67,3)";
Debug.ShouldStop(2048);
main._osm.runVoidMethod ("SetDisplayPositionByLatLon2",(Object)(BA.numberCast(double.class, 12)),(Object)(BA.numberCast(double.class, 67)),(Object)(BA.numberCast(int.class, 3)));
 BA.debugLineNum = 109;BA.debugLine="End Sub";
Debug.ShouldStop(4096);
return RemoteObject.createImmutable("");
}
catch (Exception e) {
			throw Debug.ErrorCaught(e);
		} 
finally {
			Debug.PopSubsStack();
		}}
}