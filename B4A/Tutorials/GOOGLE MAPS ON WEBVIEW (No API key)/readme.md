### GOOGLE MAPS ON WEBVIEW (No API key) by Tayfur
### 07/08/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/70308/)

**Edit by Erel:** Don't use WebView for this. Unlike Google Maps SDK, it is not free, more difficult to implement and Google Maps SDK will work better.  
<https://www.b4x.com/android/forum/threads/63930/#content>  
  
**As of June 11, 2018 all websites need an API key to use Google maps. Without it, you will see this: "This page can't load Google Maps correctly” and the map will display “For development purposes only"**  
  
Hello Guys;  
  
I needed to route calc on maps. and Completed it.  
it no need GOOGLE API KEY, it used Webview with HTML+JS.  
  
  
You need on Desinger mode;  

- Webview1
- Button1
- Button2
- Button3
- Button4
- Button5
- Button6

You need external lib.  

- WebViewExtras
- (Thanks [USER=11161]@warwound[/USER] nice lib. >>> <https://www.b4x.com/android/forum/threads/webviewextras.12453/#content>)

  
The sample has:  

- show map your lat-lag
- add poi/marker on map with your lat-lag
- delete your last marker
- Draw route on map for your destination on map for 2 point
- calculate distance your route
- set /get center value of map

![](https://www.b4x.com/android/forum/attachments/47239) ![](https://www.b4x.com/android/forum/attachments/47240) ![](https://www.b4x.com/android/forum/attachments/47241)  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: GOOGLE MAPS ON WEBVIEW  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Private WebView_ex As WebViewExtras  
    Private WebView1 As WebView  
    Private Button1 As Button  
    Private Button2 As Button  
    Private Button3 As Button  
    Private Button4 As Button  
    Private Button5 As Button  
    Private Button6 As Button  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("L1")  
    Dim x As String  
    'mymap.Initialize2(Me,"mymap",WebView1)  
    x=File.ReadString(File.DirAssets,"YOUR_HTML_FILE.txt")  
    WebView1.LoadHtml(x)  
    WebView_ex.addJavascriptInterface(WebView1, "B4A")  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
  
  
  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
  
Sub WebView1_PageFinished (Url As String)  
    Log("Map loaded on Page")  
End Sub'  
  
'initilize action s for new map  
'initialize2(CenterLat,CenterLag,zoom)  
Sub Button1_Click  
    Dim lat1,lat2,lag1,lag2 As Double  
    Dim zoom As Int  
    lat1=41.022222  
    lag1=28.751112  
    zoom=15  
    WebView_ex.executeJavascript(WebView1, "initialize2("&lat1&","&lag1&","&zoom&")")  
End Sub  
  
' calculate and draw for 2 points  
'center>>"Lat,Lag"  
'poiadd2(Center1,Center2)  
Sub Button2_Click  
    Log("Route drawing…")  
    Dim lat1,lat2,lag1,lag2 As Double  
    lat1=0'41.026742  
    lat2=0'41.073524  
    lag1=28.805635  
    lag2=28.913170  
    WebView_ex.executeJavascript(WebView1, "calcRoute2('"&lat1&", "&lag1&"','"&lat2&", "&lag2&"')")  
End Sub  
  
  
Sub Button6_Click  
    Log("settding Center…")  
  
Dim lat1,lat2,lag1,lag2 As Double  
    Dim zoom As Int  
    lat1=41.011111  
    lag1=28.705635  
    zoom=14  
    Log("Marker adding…")  
  
    WebView_ex.executeJavascript(WebView1, "SetCenter("&lat1&","&lag1&")")  
End Sub  
  
Sub Button5_Click  
    Log("reading Center…")  
    WebView_ex.executeJavascript(WebView1, "ReadCenter()")  
End Sub  
  
'delete last marker/poi  
Sub Button3_Click  
    Log("Marker deleting…")  
    WebView_ex.executeJavascript(WebView1, "poidelete()")  
End Sub  
  
' add MARKER/POİ on map with animated  
' poiadd2(Lat,Lag,zoom)  
Sub Button4_Click  
    Dim lat1,lat2,lag1,lag2 As Double  
    Dim zoom As Int  
    lat1=41.011111  
    lag1=28.705635  
    zoom=14  
    Log("Marker adding…")  
    WebView_ex.executeJavascript(WebView1, "poiadd2("&lat1&","&lag1&","&zoom&")")  
End Sub  
  
'***********************************************************************************  
'***************** THESE SUBS RETURN FROM GOOGLE MAP ON WEBVIEW**********************************************  
'***********************************************************************************  
Sub MyMap_initialized(Statuts As String)  
    Log("Map initilazed and showed map")  
    ToastMessageShow("Map initilazed and showed map",True)  
End Sub  
  
  
Sub MyMap_Poi_Added(Statuts As String)  
    Log("NEw poi addded on map")  
    ToastMessageShow("NEw poi addded on map",True)  
End Sub  
  
Sub MyMap_Poi_Deleted(Statuts As String)  
    Log("Last poi deleted on map")  
    ToastMessageShow("Last poi deleted on map",True)  
End Sub  
  
Sub MyMap_Calc_Distance(Statuts As String)  
    Log ("Distance for between A - B :" &Statuts)  
    ToastMessageShow("Distance for between A - B :" &Statuts,True)  
End Sub  
  
Sub MyMap_Calc_Distance_Err(Statuts As String)  
    Log("Route error, No way…")  
    ToastMessageShow("Route error, No way…",True)  
  
End Sub  
Sub MyMap_ReadCenter(Statuts As String)  
    Log("center:" & Statuts)  
    ToastMessageShow("center:"&Statuts,True)  
End Sub  
Sub MyMap_SetCenter(Statuts As String)  
    Log("Setcenter:" & Statuts)  
    ToastMessageShow("Set center:"&Statuts,True)  
End Sub
```

  
  
  
  
  
HTML code For webview; Write TXT file and save project file. File.Dirasset  
  
[HTML]  
<html>  
<head>  
 <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>  
 <title>Distance Calculator</title>  
 <script type="text/javascript" src="<http://maps.google.com/maps/api/js?sensor=false>"></script>  
 <style type="text/css">  
body {  
 margin: 0;  
}  
 #map\_canvas {  
 height: 100%;  
 }  
 </style>  
 <script type="text/javascript">  
 var directionDisplay;  
 var directionsService = new google.maps.DirectionsService();  
 var map;  
  
var markerX;  
  
 //————————————————————————–  
 function initialize2(enlem,boylam,zoomx) {  
 directionsDisplay = new google.maps.DirectionsRenderer();  
 var melbourne = new google.maps.LatLng(enlem,boylam);  
 var myOptions = {  
 zoom:zoomx,  
 mapTypeId: google.maps.MapTypeId.ROADMAP,  
 center: melbourne  
 }  
  
 map = new google.maps.Map(document.getElementById("map\_canvas"), myOptions);  
 directionsDisplay.setMap(map);  
 B4A.CallSub('MyMap\_initialized', true,true);  
  
 }  
 //————————————————————————–  
  
//————————————————————————–  
 function calcRoute2(EB1,EB2) {  
 //var start = document.getElementById("start").value;  
 //var end = document.getElementById("end").value;  
 var distanceInput = document.getElementById("distance");  
  
 var request = {  
 origin:EB1,  
 destination:EB2,  
 travelMode: google.maps.DirectionsTravelMode.DRIVING  
 };  
//————resize and reload map—————  
google.maps.event.trigger(map,'resize');  
 map.setZoom(map.getZoom());  
//——————–  
 directionsService.route(request, function(response, status) {  
 if (status == google.maps.DirectionsStatus.OK) {  
 directionsDisplay.setDirections(response);  
 //distanceInput.value =response.routes[0].legs[0].distance.value / 1000;  
 B4A.CallSub('MyMap\_Calc\_Distance', true,response.routes[0].legs[0].distance.value / 1000);  
 } else {  
 //distanceInput.value ="NO WAY!!!";  
 B4A.CallSub('MyMap\_Calc\_Distance\_Err', true,true);  
}  
 });  
 }  
  
function poiadd2(enlem,boylam,zoom) {  
//var enlem = document.getElementById("enlem").value;  
//var boylam = document.getElementById("boylam").value;  
  
var myCenter = new google.maps.LatLng(enlem, boylam);  
marker=new google.maps.Marker({  
 position:myCenter,  
center: myCenter,  
 animation:google.maps.Animation.BOUNCE  
 });  
  
marker.setMap(map);  
map.panTo(marker.getPosition());  
map.setZoom(zoom);  
poivar=true;  
B4A.CallSub('MyMap\_Poi\_Added', true,true);  
}  
//————————————————————————–  
//————————————————–  
  
//————————————————————————–  
//————————————————–  
function poidelete() {  
marker.setMap(null);  
marker=""  
B4A.CallSub('MyMap\_Poi\_Deleted', true,true);  
}  
//————————————————————————–  
//————————————————–  
function ReadCenter() {  
B4A.CallSub('MyMap\_ReadCenter', true,' '+map.getCenter());  
}  
//————————————————————————–  
  
function SetCenter(enlem,boylam) {  
map.setCenter(new google.maps.LatLng(enlem,boylam));  
B4A.CallSub('MyMap\_SetCenter', true,true);  
}  
  
  
  
 </script>  
  
</head>  
<body>  
 <div id="map\_canvas"></div>  
</body>  
</html>  
[/HTML]