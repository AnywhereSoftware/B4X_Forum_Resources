
package starchild.osm.test;

import java.io.IOException;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.pc.PCBA;
import anywheresoftware.b4a.pc.RDebug;
import anywheresoftware.b4a.pc.RemoteObject;
import anywheresoftware.b4a.pc.RDebug.IRemote;
import anywheresoftware.b4a.pc.Debug;
import anywheresoftware.b4a.pc.B4XTypes.B4XClass;
import anywheresoftware.b4a.pc.B4XTypes.DeviceClass;

public class main implements IRemote{
	public static main mostCurrent;
	public static RemoteObject ba;
    public static boolean processGlobalsRun;
    public static RemoteObject myClass;
    public static RemoteObject remoteMe;
	public main() {
		mostCurrent = this;
	}
    public RemoteObject getRemoteMe() {
        return remoteMe;    
    }
    
public boolean isSingleton() {
		return true;
	}
    static {
		mostCurrent = new main();
		remoteMe = RemoteObject.declareNull("starchild.osm.test.main");
        anywheresoftware.b4a.pc.RapidSub.moduleToObject.put(new B4XClass("main"), "starchild.osm.test.main");
	}
    public static void main (String[] args) throws Exception {
		new RDebug(args[0], Integer.parseInt(args[1]), Integer.parseInt(args[2]), args[3]);
		RDebug.INSTANCE.waitForTask();

	}
    private static PCBA pcBA = new PCBA(null, main.class);
	public static RemoteObject runMethod(boolean notUsed, String method, Object... args) throws Exception{
		return (RemoteObject) pcBA.raiseEvent(method.substring(1), args);
	}
    public static void runVoidMethod(String method, Object... args) throws Exception{
		runMethod(false, method, args);
	}
    public static RemoteObject getObject() {
		return myClass;
	 }
	public PCBA create(Object[] args) throws ClassNotFoundException{
		ba = (RemoteObject) args[1];
		pcBA = new PCBA(this, main.class);
        main_subs_0.initializeProcessGlobals();
		return pcBA;
	}
public static RemoteObject __c = RemoteObject.declareNull("anywheresoftware.b4a.keywords.Common");
public static RemoteObject _fx = RemoteObject.declareNull("anywheresoftware.b4j.objects.JFX");
public static RemoteObject _infowindow = RemoteObject.declareNull("anywheresoftware.b4j.objects.PaneWrapper.AnchorPaneWrapper");
public static RemoteObject _infowindowdesclabel = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
public static RemoteObject _infowindowtitlelabel = RemoteObject.declareNull("anywheresoftware.b4j.objects.LabelWrapper");
public static RemoteObject _mainform = RemoteObject.declareNull("anywheresoftware.b4j.objects.Form");
public static RemoteObject _osmtilesource = RemoteObject.declareNull("starchild.b4j.jfxtras.labs.map.tile.osm.OsmTileSourceFactory");
public static RemoteObject _tilesourceselector = RemoteObject.declareNull("anywheresoftware.b4j.objects.ComboBoxWrapper");
public static RemoteObject _osm = RemoteObject.declareNull("starchild.b4j.jfxtras.labs.map.MapPane");
public static RemoteObject _mapnodehost1 = RemoteObject.declareNull("starchild.b4j.jfxtras.labs.map.render.MapNodeHost");
public static RemoteObject _mapicons = RemoteObject.declareNull("starchild.b4j.extras.DefaultMapIcons");
public static RemoteObject _pin1 = RemoteObject.declareNull("starchild.b4j.jfxtras.labs.map.render.ImageMapMarker");
public static RemoteObject _spot1 = RemoteObject.declareNull("starchild.b4j.jfxtras.labs.map.render.SimpleMapMarker");
public static RemoteObject _p = RemoteObject.declareNull("starchild.b4j.jfxtras.labs.map.render.DefaultMapPolygon");
public static RemoteObject _perthbutton = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
public static RemoteObject _cairobutton = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
public static RemoteObject _worldbutton = RemoteObject.declareNull("anywheresoftware.b4j.objects.ButtonWrapper");
  public Object[] GetGlobals() {
		return new Object[] {"CairoButton",main._cairobutton,"fx",main._fx,"InfoWindow",main._infowindow,"InfoWindowDescLabel",main._infowindowdesclabel,"InfoWindowTitleLabel",main._infowindowtitlelabel,"MainForm",main._mainform,"MapIcons",main._mapicons,"MapNodeHost1",main._mapnodehost1,"OSM",main._osm,"OsmTileSource",main._osmtilesource,"P",main._p,"PerthButton",main._perthbutton,"Pin1",main._pin1,"Spot1",main._spot1,"TileSourceSelector",main._tilesourceselector,"WorldButton",main._worldbutton};
}
}