###  Custom GoogleMaps by MarcoRome
### 07/17/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/120281/)

This is an example of how you can customize a Map.  
Through the B4XCanvas functions it is possible to create the map with photos, text, etc.  
The classes used are MapScale + GoogleMapsExtra (<https://www.b4x.com/android/forum/threads/class-googlemapsextra.56871/>)  
  
The following code is an example for B4i but can also be extended to B4A and B4J.  
  
[MEDIA=youtube]k6hoCFFcbYE[/MEDIA]  
  

```B4X
'Code module  
#Region  Project Attributes  
    #ApplicationLabel: B4i custom Maps  
    #Version: 1.0.0  
    'Orientation possible values: Portrait, LandscapeLeft, LandscapeRight and PortraitUpsideDown  
    #iPhoneOrientations: Portrait, LandscapeLeft, LandscapeRight  
    #iPadOrientations: Portrait, LandscapeLeft, LandscapeRight, PortraitUpsideDown  
    #PlistExtra:<key>NSLocationWhenInUseUsageDescription</key><string>Used to display the current navigation data.</string>  
    #PlistExtra:<key>NSLocationUsageDescription</key><string>Used to display the current navigation data.</string>  
#End Region  
  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public App As Application  
    Public NavControl As NavigationController  
    Private Page1 As Page  
    Private gmap As GoogleMap  
    Private ApiKey As String = "xxxx"  
      
    Private MapScale1 As MapScale  
    Private Panel1 As Panel  
    Private CameraChangedIndex As Int  
    Dim xui As XUI  
      
End Sub  
  
Private Sub Application_Start (Nav As NavigationController)  
    NavControl = Nav  
    Page1.Initialize("Page1")  
    Page1.RootPanel.LoadLayout("1")  
    Page1.Title = "Sicilia Map - Devil"  
    NavControl.ShowPage(Page1)  
    AddMap  
    Dim no As NativeObject  
    Log("Version: " & no.Initialize("GMSServices").RunMethod("SDKVersion", Null).AsString)  
End Sub  
  
Private Sub AddMap  
    gmap.Initialize("gmap", ApiKey)  
    Panel1.AddView(gmap, 0, 0, 100%X, 100%y)  
    gmap.MapType = gmap.MAP_TYPE_HYBRID  
    gmap.GetUiSettings.CompassEnabled = True  
    gmap.GetUiSettings.MyLocationButtonEnabled = True  
    gmap.MyLocationEnabled = True  
      
    'add three markers  
    gmap.AddMarker3(37.098396, 13.928318, $"Baia del Pirata${CRLF}Offerta Speciale|baia0"$,  LoadBitmap(File.DirAssets, "sailing.png"))  
    gmap.AddMarker3(37.099458, 13.921323, "Baia Roccella|baia1", LoadBitmap(File.DirAssets, "scubadiving.png"))  
    gmap.AddMarker3(37.097489, 13.913918, "Baia della Dama|baia2", LoadBitmap(File.DirAssets, "scubadiving.png"))  
  
    'change the camera position  
    Dim c As CameraPosition  
    c.Initialize(37.10, 13.92, 14)  
    gmap.AnimateCamera©  
  
      
End Sub  
  
Sub gmap_LongClick (Point As LatLng)  
    Log(Point)  
End Sub  
  
Sub CreateBitmap(text As String) As B4XBitmap  
    Dim xui As XUI  
    Dim p As B4XView = xui.CreatePanel("")  
    p.SetLayoutAnimated(0, 0, 0, 125dip, 20dip)  
    Dim c As B4XCanvas  
    c.Initialize(p)  
    c.DrawRect(c.TargetRect, xui.Color_White, True, 0)  
    c.DrawText(text, c.TargetRect.CenterX, c.TargetRect.CenterY + 9dip, xui.CreateDefaultBoldFont(16), xui.Color_Black, "CENTER")  
    c.Invalidate  
    Return c.CreateBitmap  
End Sub  
  
Sub CreateRoundBitmap (Input As B4XBitmap, Size As Int) As B4XBitmap  
    If Input.Width <> Input.Height Then  
        'if the image is not square then we crop it to be a square.  
        Dim l As Int = Min(Input.Width, Input.Height)  
        Input = Input.Crop(Input.Width / 2 - l / 2, Input.Height / 2 - l / 2, l, l)  
    End If  
    Dim c As B4XCanvas  
    Dim xview As B4XView = xui.CreatePanel("")  
    xview.SetLayoutAnimated(0, 0, 0, Size, Size)  
    c.Initialize(xview)  
    Dim path As B4XPath  
    path.InitializeOval(c.TargetRect)  
    c.ClipPath(path)  
    c.DrawBitmap(Input.Resize(Size, Size, False), c.TargetRect)  
    c.RemoveClip  
    c.DrawCircle(c.TargetRect.CenterX, c.TargetRect.CenterY, c.TargetRect.Width / 2 - 2dip, xui.Color_White, False, 5dip) 'comment this line to remove the border  
    c.Invalidate  
    Dim res As B4XBitmap = c.CreateBitmap  
    c.Release  
    Return res  
End Sub  
  
Sub CreateRoundRectBitmap (Input As B4XBitmap, Radius As Float) As B4XBitmap  
    Dim BorderColor As Int = xui.Color_White  
    Dim BorderWidth As Int = 4dip  
    Dim c As B4XCanvas  
    Dim xview As B4XView = xui.CreatePanel("")  
    xview.SetLayoutAnimated(0, 0, 0, Input.Width, Input.Height)  
    c.Initialize(xview)  
    Dim path As B4XPath  
    path.InitializeRoundedRect(c.TargetRect, Radius)  
    c.ClipPath(path)  
    c.DrawRect(c.TargetRect, BorderColor, True, BorderWidth) 'border  
    c.RemoveClip  
    Dim r As B4XRect  
    r.Initialize(BorderWidth, BorderWidth, c.TargetRect.Width - BorderWidth, c.TargetRect.Height - BorderWidth)  
    path.InitializeRoundedRect(r, Radius - 0.7 * BorderWidth)  
    c.ClipPath(path)  
    c.DrawBitmap(Input, r)     
    c.RemoveClip  
    c.Invalidate  
    Dim res As B4XBitmap = c.CreateBitmap  
    c.Release  
    Return res  
End Sub  
  
Sub gmap_InfoWindowClick (SelectedMarker As Marker)  
    Log("InfoWindow clicked: " & SelectedMarker)  
    Log(SelectedMarker.Title)  
      
End Sub  
  
'Return Null for the default marker layout  
Sub gmap_MarkerInfoWindow (OMarker As Object) As Object  
  
    Dim SelectedMarker As Marker = OMarker  
      
    Dim splitta() As String = Regex.Split("\|", SelectedMarker.Title)  
      
    Dim p As Panel  
    p.Initialize("")  
    p.Color = Colors.White  
    p.SetBorder(1,Colors.Black,20)  
    p.SetLayoutAnimated(0, 1, 0, 0, 200, 200)  
'    'Carico Foto  
  
    Dim img As B4XBitmap = xui.LoadBitmapResize(File.DirAssets, splitta(1)&".jpg", 200dip, 150dip, True)  
    Dim photo As ImageView  
    photo.Initialize("")  
    photo.Bitmap = CreateRoundRectBitmap(img, 20dip)  
    p.AddView(photo, 0,0, 200, 150)  
    'Carico Title Marker  
    Dim lbl As TextView  
    lbl.Initialize("")  
    'lbl.Text = SelectedMarker.Title  
    lbl.Text = splitta(0)  
    lbl.TextColor = Colors.Black  
      
    p.AddView(lbl, 10, photo.Height, 200, 80)  
    Return p  
End Sub  
  
  
  
Private Sub Page1_Resize(Width As Int, Height As Int)  
    If gmap.IsInitialized Then gmap.SetLayoutAnimated(0, 1, 0, 0, Width, Height)  
End Sub  
  
Sub gmap_CameraChange (Position As CameraPosition)  
    MapScale1.Update(Position.Zoom, Position.Target.Latitude)  
    CameraChangedIndex = CameraChangedIndex + 1  
    Dim MyIndex As Int = CameraChangedIndex  
    Sleep(200)  
    If MyIndex = CameraChangedIndex Then  
        Log("Finished moving for now!")  
    End If  
End Sub  
  
  
Sub gmap_MarkerClick (SelectedMarker As Marker) As Boolean 'Return True to consume the click  
    Dim ngm As NativeObject = gmap  
    Dim infoWindowVisible As Boolean = True  
    If ngm.GetField("selectedMarker").IsInitialized Then  
        Dim current As Marker = ngm.GetField("selectedMarker")  
        If current.Title = SelectedMarker.Title Then infoWindowVisible = False  
    End If  
    If infoWindowVisible Then  
        Log("Snippet is shown")  
    Else  
        Log("Snippet is hidden")  
    End If  
    Return False  
End Sub
```

  
  
A nice day with B4X