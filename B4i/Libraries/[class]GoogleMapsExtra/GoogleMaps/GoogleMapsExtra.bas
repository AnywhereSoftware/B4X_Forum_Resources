B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.38
@EndOfDesignText@
'version 2.15
Sub Class_Globals
	Private gm As GoogleMap
	Private no As NativeObject
End Sub

Public Sub Initialize (Gmap As GoogleMap)
	gm = Gmap
	no = Me
End Sub

Public Sub AddPolygon (Points As List, FillColor As Int, StrokeColor As Int)
	Dim path As NativeObject = no.RunMethod("createPath:", Array(Points))
	Dim polygon As NativeObject
	polygon = polygon.Initialize("GMSPolygon").RunMethod("polygonWithPath:", Array(path))
	polygon.SetField("map", gm)
	polygon.SetField("strokeWidth", 5)
	polygon.SetField("fillColor", polygon.ColorToUIColor(FillColor))
	polygon.SetField("strokeColor", polygon.ColorToUIColor(StrokeColor))
End Sub

'Adds a circle at the given point.
'Radius is measured in meters.
Public Sub AddCircle (Lat As Double, Lon As Double, Radius As Double, Color As Int) As NativeObject
	Dim circle As NativeObject = no.RunMethod("createCircle:::", Array(Lat, Lon, Radius))
	circle.SetField("map", gm)
	circle.SetField("strokeWidth", 5)
	circle.SetField("fillColor", circle.ColorToUIColor(Color))
	circle.SetField("strokeColor", circle.ColorToUIColor(Color))
	Return circle
End Sub

Public Sub AnimateCameraWithDuration(NewPosition As CameraPosition, DurationMs As Int)
	Dim transaction As NativeObject
	transaction.Initialize("CATransaction").RunMethod("setValue:forKey:", Array(DurationMs / 1000, "animationDuration"))
	gm.AnimateCamera(NewPosition)
	transaction.RunMethod("commit", Null)
End Sub

'List of LatLng objects
Public Sub ZoomToPoints(Points As List)
	Dim bounds As Object = no.RunMethod("createBoundsIncluding:", Array(Points))
	Dim update As NativeObject
	update = update.Initialize("GMSCameraUpdate").RunMethod("fitBounds:withPadding:", Array(bounds, 10))
	Dim gmapNo As NativeObject = gm
	gmapNo.RunMethod("animateWithCameraUpdate:", Array(update))
	
End Sub

public Sub CreateBounds (NorthEast As LatLng, SouthWest As LatLng) As Object
	Return no.RunMethod("createBounds::", Array(NorthEast, SouthWest))
End Sub

public Sub AddGroundOverlay(Bounds As Object, Image As Bitmap)
	Dim overlay As NativeObject
	overlay = overlay.Initialize("GMSGroundOverlay").RunMethod( _
		"groundOverlayWithBounds:icon:", Array(Bounds, Image))
	overlay.SetField("map", gm)
End Sub
Public Sub SetSelectedMarker(Marker As Marker)
	Dim ngm As NativeObject = gm
   	ngm.SetField("selectedMarker", Marker)
End Sub

Public Sub UnselectMarkers
	Dim ngm As NativeObject = gm
   	ngm.SetField("selectedMarker", Null)
End Sub

Public Sub SetMarkerRotation(Marker As Marker, Rotation As Double)
	Dim m As NativeObject = Marker
	m.SetField("rotation", Rotation)
End Sub
'Sets the icon anchor. Both values should be between 0 to 1.
Public Sub SetGroundAnchor(Marker As Marker, X As Double, Y As Double)
	Dim m As NativeObject = Marker
	m.RunMethod("setGroundAnchor:", Array(m.MakePoint(X, Y)))
End Sub

Public Sub GetProjection As NativeObject
	Dim ngm As NativeObject = gm
	Return ngm.GetField("projection")
End Sub

Public Sub GetVisibleBounds As NativeObject
	Dim Bounds As NativeObject
	Bounds = no.RunMethod("coordinateBoundsFromProjection:", Array(GetProjection))
	Return Bounds
End Sub

Public Sub BoundsContain(Bounds As NativeObject, LatLng As LatLng) As Boolean
	Return no.RunMethod("boundsContain::", Array(Bounds, LatLng)).AsBoolean
End Sub

Public Sub MapStyle (json As String)
	Dim ngm As NativeObject = gm
	Dim style As Object = no.RunMethod("createMapStyle:", Array(json))
	ngm.SetField("mapStyle", style)
End Sub

Public Sub ScreenToCoordinate(X As Double, Y As Double) As LatLng
	Return no.RunMethod("screenToCoordinate:::", Array(GetProjection, X, Y))
End Sub

'Returns x, y
Public Sub CoordinateToScreen(ll As LatLng) As Double()
	Dim arr As NativeObject = no.RunMethod("coordinateToScreen::", Array(GetProjection, ll))
	Return Array As Double(arr.RunMethod("objectAtIndex:", Array(0)).AsNumber, _
		arr.RunMethod("objectAtIndex:", Array(1)).AsNumber)
End Sub

Public Sub GetBoundsNE_SW (bounds As Object) As LatLng()
	Dim ne, sw As LatLng
	no.RunMethod("getLatLngFromBounds:::", Array(bounds, ne, sw))
	Return Array As LatLng(ne, sw)
End Sub



#If OBJC
#import "iGoogleMaps.h"
#import <GoogleMaps/GoogleMaps.h>
- (NSArray*) coordinateToScreen:(GMSProjection*)projection :(B4ILatLng*)ll {
	CGPoint p = [projection pointForCoordinate:CLLocationCoordinate2DMake(ll.Latitude, ll.Longitude)];
	return @[@(p.x), @(p.y)];
}
- (B4ILatLng*) screenToCoordinate:(GMSProjection*)projection :(double)x :(double)y {
	CLLocationCoordinate2D c = [projection coordinateForPoint:CGPointMake(x, y)];
	B4ILatLng* ll = [B4ILatLng new];
	[ll Initialize:c.latitude :c.longitude];
	return ll;
}
- (NSObject*) createMapStyle:(NSString*)json {
	return [GMSMapStyle styleWithJSONString:json error:nil];
}
- (NSObject*)createCircle:(double)lat :(double)lon :(double)radius {
	return [GMSCircle circleWithPosition:CLLocationCoordinate2DMake(lat, lon) radius:(CLLocationDistance)radius];
}
- (NSObject*)createBounds:(B4ILatLng*)ne :(B4ILatLng*)sw {
	return [[GMSCoordinateBounds alloc] 
		initWithCoordinate:CLLocationCoordinate2DMake(ne.Latitude, ne.Longitude)
		coordinate:CLLocationCoordinate2DMake(sw.Latitude, sw.Longitude)];
}
- (BOOL)boundsContain:(GMSCoordinateBounds*) bounds :(B4ILatLng*) ll {
	return [bounds containsCoordinate:CLLocationCoordinate2DMake(ll.Latitude, ll.Longitude)];
}
- (NSObject*)createBoundsIncluding:(NSArray*)points {
	GMSCoordinateBounds* bounds = [GMSCoordinateBounds new];
	for (B4ILatLng* ll in points) {
		 bounds = [bounds includingCoordinate:CLLocationCoordinate2DMake(ll.Latitude, ll.Longitude)];
	}
	return bounds;
}
- (NSObject*)createPath:(NSArray*)points {
	GMSMutablePath* p = [GMSMutablePath new];
	for (B4ILatLng* ll in points) {
		 [p addCoordinate:CLLocationCoordinate2DMake(ll.Latitude, ll.Longitude)];
	}
	return p;
}
- (NSObject*)coordinateBoundsFromProjection:(GMSProjection*) p {
	return [[GMSCoordinateBounds alloc]initWithRegion: [p visibleRegion]];
}
- (void)getLatLngFromBounds:(GMSCoordinateBounds*) bounds :(B4ILatLng*) northEast :(B4ILatLng*) southWest {
	[northEast Initialize:bounds.northEast.latitude :bounds.northEast.longitude];
	[southWest Initialize:bounds.southWest.latitude :bounds.southWest.longitude];
}
@end
@implementation B4IMapDelegate (override)
- (UIView*)mapView:(GMSMapView*)mapView markerInfoWindow:(GMSMarker*)marker {
	return [B4IObjectWrapper raiseEvent:mapView :@"_markerinfowindow:" :@[marker]];
}

#End If