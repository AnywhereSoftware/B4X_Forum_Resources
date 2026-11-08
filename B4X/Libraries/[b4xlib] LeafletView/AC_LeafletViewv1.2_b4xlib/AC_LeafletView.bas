B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
'#region Events
#Event: MarkerClick (Data As Map)
#Event: MarkerPopupClick (Data As Map)
#Event: MarkerAdded (Data As Map)
#Event: MapClick (Data As Map)
#Event: ZoomChanged (Data As Map)
#Event: RoutingFound (Data As Map)
#Event: RouteClick (Data As Map)
'#endregion

#DesignerProperty: Key: CenterLat, DisplayName: Center Latitude, FieldType: Float, DefaultValue: -25.9653
#DesignerProperty: Key: CenterLon, DisplayName: Center Longitude, FieldType: Float, DefaultValue: 32.5892
#DesignerProperty: Key: DefaultZoom, DisplayName: Default Zoom, FieldType: Int, DefaultValue: 13
#DesignerProperty: Key: ShowMarkerPopup, DisplayName: Show Marker Popup, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: ShowRoutePopup, DisplayName: Show Route Popup, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: ShowPersistentRoutePopup, DisplayName: Show Persistent KM, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: ShowZoomControls, DisplayName: Show Zoom Controls, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: ShowAttribution, DisplayName: Show Leaflet Watermark, FieldType: Boolean, DefaultValue: True

Sub Class_Globals
	Private mEventName As String
	Private mCallBack As Object
	Public mBase As B4XView
	Private xui As XUI
	Public WebView1 As WebView
	Private isReady As Boolean = False
    
	' Internal Settings
	Private dLat As Double, dLon As Double, dZoom As Int
	Public ShowMarkerPopup As Boolean, ShowRoutePopup As Boolean, ShowPersistentRoutePopup As Boolean
	Public ShowZoomControls As Boolean, ShowAttribution As Boolean
    
	' State Sync
	Public CurrentZoom As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	dLat = Props.Get("CenterLat")
	dLon = Props.Get("CenterLon")
	dZoom = Props.Get("DefaultZoom")
	CurrentZoom = dZoom
    
	ShowMarkerPopup = Props.GetDefault("ShowMarkerPopup", True)
	ShowRoutePopup = Props.GetDefault("ShowRoutePopup", True)
	ShowPersistentRoutePopup = Props.GetDefault("ShowPersistentRoutePopup", False)
	ShowZoomControls = Props.GetDefault("ShowZoomControls", True)
	ShowAttribution = Props.GetDefault("ShowAttribution", True)
    
    #If B4A
	WebView1.Initialize("wv")
    #Else If B4J
    WebView1.Initialize("wv")
    #End If
    
	mBase.AddView(WebView1, 0, 0, mBase.Width, mBase.Height)
	Dim jo As JavaObject = Me
	jo.RunMethod("setupNativeBridge", Array(WebView1))
	WebView1.LoadHtml(buildhtml)
End Sub

' --- PUBLIC API ---

Public Sub SetZoom(Level As Int)
	ExecuteJS("map.setZoom(" & Level & ");")
End Sub

Public Sub GetZoom  As Int
	Return CurrentZoom
End Sub

Public Sub SetPosition(Lat As Double, Lon As Double, Animated As Boolean)
	If Animated Then
		ExecuteJS("map.panTo([" & Lat & ", " & Lon & "]);")
	Else
		ExecuteJS("map.setView([" & Lat & ", " & Lon & "], map.getZoom());")
	End If
End Sub

Public Sub AddMarker(ID As String, Lat As Double, Lon As Double, Title As String, ExtraData As Map)
	Dim jg As JSONGenerator : jg.Initialize(ExtraData)
	ExecuteJS("addMarkerNative('" & ID & "', " & Lat & ", " & Lon & ", '" & Title & "', '" & jg.ToString & "');")
End Sub

Public Sub DrawRoadRoute(RouteID As String, StartLat As Double, StartLon As Double, EndLat As Double, EndLon As Double, Color As String)
	ExecuteJS("jsDrawRoadRoute('" & RouteID & "', " & StartLat & ", " & StartLon & ", " & EndLat & ", " & EndLon & ", '" & Color & "');")
End Sub

Public Sub RemoveMarker(ID As String)
	ExecuteJS("jsRemoveItem('marker', '" & ID & "');")
End Sub

Public Sub RemoveRoute(RouteID As String)
	ExecuteJS("jsRemoveItem('route', '" & RouteID & "');")
End Sub

Public Sub ClearAllMarkers
	ExecuteJS("jsClearLayers('markers');")
End Sub

Public Sub ClearAllRoutes
	ExecuteJS("jsClearLayers('routes');")
End Sub

' --- INTERNAL ENGINE ---

Private Sub ExecuteJS(Script As String)
    #If B4A
	Dim jo As JavaObject = WebView1 : jo.RunMethod("evaluateJavascript", Array(Script, Null))
	#Else If B4J
    Dim jo As JavaObject = WebView1 : Dim engine As JavaObject = jo.RunMethod("getEngine", Null) : engine.RunMethod("executeScript", Array(Script))
    #End If
End Sub

Public Sub NativeBridgeHandler(Message As String)
	If Message = "MAP_READY" Then : isReady = True : Return : End If
		Try
			Dim parser As JSONParser : parser.Initialize(Message)
			Dim root As Map = parser.NextObject
			Dim eventType As String = root.Get("event")
			Dim eventData As Map = root.Get("data")
			
			If eventType = "ZoomChanged" Then CurrentZoom = eventData.Get("zoom")
			
			If SubExists(mCallBack, mEventName & "_" & eventType) Then
				CallSub2(mCallBack, mEventName & "_" & eventType, eventData)
			End If
		Catch : Log("Bridge Error") : End Try
		End Sub

Private Sub buildhtml As String
	Dim bridgeScript As String
    #If B4A
	bridgeScript = "function sendToB4X(evt, data) { console.log(JSON.stringify({event: evt, data: data})); }"
    #Else If B4J
    bridgeScript = "function sendToB4X(evt, data) { if(window.b4x) window.b4x.NativeBridgeHandler(JSON.stringify({event: evt, data: data})); }"
    #End If

	' Configuração dinâmica de CSS
	Dim attributionCSS As String = "block"
	If ShowAttribution = False Then attributionCSS = "none"

	Return $"
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.js"></script>
    <style>
        html, body, #map { margin:0; height:100%; width:100%; background:#eee; font-family: sans-serif; }
        .leaflet-routing-container { display:none; }
        .persistent-label { background: white; padding: 2px 5px; border: 1px solid #333; font-weight: bold; font-size: 11px; border-radius:3px; box-shadow: 1px 1px 3px rgba(0,0,0,0.3); }
        .leaflet-control-attribution { display: ${attributionCSS} !important; }
    </style>
</head>
<body>
    <div id="map"></div>
    <script>
        var map, markersDict = {}, routesDict = {}, persistentDict = {};
        ${bridgeScript}

        function getFullMapData() { return { zoom: map.getZoom(), lat: map.getCenter().lat, lon: map.getCenter().lng }; }

        window.onload = function() {
            map = L.map('map', {
                zoomControl: ${ShowZoomControls}
            }).setView([${dLat}, ${dLon}], ${dZoom});
            
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
            
            map.on('zoomend', function() { sendToB4X('ZoomChanged', getFullMapData()); });
            map.on('click', function(e) { sendToB4X('MapClick', {lat: e.latlng.lat, lon: e.latlng.lng}); });
            sendToB4X('MAP_READY', {});
        };

        function addMarkerNative(id, lat, lon, title, jsonInfo) {
            if (markersDict[id]) map.removeLayer(markersDict[id]);
            var info = JSON.parse(jsonInfo);
            var m = L.marker([lat, lon]).addTo(map);
            
            if(${ShowMarkerPopup} && title) {
                m.bindPopup('<div onclick="window.pClick(\''+id+'\')" style="cursor:pointer"><b>'+title+'</b><br>Click for details</div>');
            }
            m.on('click', function() { sendToB4X('MarkerClick', {id: id, extra: info}); });
            window.pClick = function(mid) { sendToB4X('MarkerPopupClick', {id: mid, extra: info}); };
            markersDict[id] = m;
        }

        function jsDrawRoadRoute(id, sLat, sLon, eLat, eLon, color) {
            if (routesDict[id]) return; 

            var rc = L.Routing.control({
                waypoints: [L.latLng(sLat, sLon), L.latLng(eLat, eLon)],
                lineOptions: { styles: [{color: color || '#1a73e8', weight: 6, opacity: 0.7}], addWaypoints: false },
                createMarker: function() { return null; }
            }).on('routesfound', function(e) {
                var route = e.routes[0];
                var distKm = (route.summary.totalDistance / 1000).toFixed(1);
                var timeSec = route.summary.totalTime || 0;
                
                var arrivalDate = new Date(new Date().getTime() + (timeSec * 1000));
                var carEta = arrivalDate.getHours().toString().padStart(2, '0') + ":" + 
                             arrivalDate.getMinutes().toString().padStart(2, '0');

                if(${ShowPersistentRoutePopup}) {
                    var mid = route.coordinates[Math.floor(route.coordinates.length / 2)];
                    persistentDict[id] = L.popup({autoClose:false, closeOnClick:false, closeButton:false, className:'persistent-label'})
                             .setLatLng(mid).setContent(distKm + ' km').openOn(map);
                }

                if(${ShowRoutePopup}) {
                    var poly = L.polyline(route.coordinates, {color: 'transparent', weight: 20}).addTo(map);
                    poly.bindPopup('<b>Route Details</b><br>Dist: ' + distKm + ' km<br>ETA: ' + carEta);
                    poly.on('click', function() { sendToB4X('RouteClick', {id: id, distance: distKm, car_eta: carEta}); });
                }
                sendToB4X('RoutingFound', {id: id, distance: distKm, car_eta: carEta});
            }).addTo(map);
            routesDict[id] = rc;
        }

        function jsRemoveItem(type, id) {
            if (type === 'marker' && markersDict[id]) { map.removeLayer(markersDict[id]); delete markersDict[id]; }
            if (type === 'route' && routesDict[id]) { 
                map.removeControl(routesDict[id]); delete routesDict[id]; 
                if(persistentDict[id]) { map.removeLayer(persistentDict[id]); delete persistentDict[id]; }
            }
        }

        function jsClearLayers(type) {
            if (type === 'markers') { for (var k in markersDict) jsRemoveItem('marker', k); }
            if (type === 'routes') { for (var k in routesDict) jsRemoveItem('route', k); }
        }
    </script>
</body>
</html>"$
End Sub

#If B4A
#If JAVA
import android.webkit.*;
public void setupNativeBridge(WebView wv) {
    WebSettings s = wv.getSettings();
    s.setJavaScriptEnabled(true);
    s.setDomStorageEnabled(true);
    final anywheresoftware.b4a.BA b = ba; 
    wv.setWebChromeClient(new WebChromeClient() {
        @Override
        public boolean onConsoleMessage(ConsoleMessage consoleMessage) {
            b.raiseEventFromDifferentThread(null, null, 0, "nativebridgehandler", true, new Object[] {consoleMessage.message()});
            return true;
        }
    });
}
#End If
#End If

 #If B4J
#If JAVA
import javafx.scene.web.WebView;
import javafx.scene.web.WebEngine;
import netscape.javascript.JSObject;
import javafx.concurrent.Worker;

public void setupNativeBridge(WebView wv) {
    WebEngine engine = wv.getEngine();
    engine.getLoadWorker().stateProperty().addListener((obs, oldState, newState) -> {
        if (newState == Worker.State.SUCCEEDED) {
            JSObject window = (JSObject) engine.executeScript("window");
            window.setMember("b4x", this);
        }
    });
}

// Alterado de _ba para ba
public void NativeBridgeHandler(String msg) {
    ba.raiseEventFromDifferentThread(null, null, 0, "nativebridgehandler", true, new Object[] {msg});
}
#End If
#End If