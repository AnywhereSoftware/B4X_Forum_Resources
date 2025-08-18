B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4XOpenMap.zip

Sub Class_Globals
	Private Root As B4XView
	Private fxui As XUI
	Private fcvMap As cvMap
	Private fMap As TMap
	Private fDlg As B4XDialog
	Private fPrefDlg As PreferencesDialog
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("main")
	
	fPrefDlg.Initialize(Root,"Map",500,500)
	fDlg.Initialize(Root)
	
	Dim shapes As List
	shapes.Initialize
	shapes.Add(coMapUtilities.instanceShapeCircle(fcvMap,coMapUtilities.initShapeCircle(coMapUtilities.initLatLng(51.5073509,-0.1277583),10dip,fxui.Color_ARGB(128,255,0,255),True,1dip,"London")))
	shapes.Add(coMapUtilities.instanceShapeLine(fcvMap,coMapUtilities.initShapeLine(coMapUtilities.initLatLng(51.5073509,-0.1277583),coMapUtilities.initLatLng(48.856614,2.3522219),fxui.Color_ARGB(128,255,0,255),1dip,"London to Paris")))
	shapes.Add(coMapUtilities.instanceShapeCircle(fcvMap,coMapUtilities.initShapeCircle(coMapUtilities.initLatLng(48.856614,2.3522219),15dip,fxui.Color_ARGB(128,0,255,255),True,1dip,"Paris")))
	shapes.Add(coMapUtilities.instanceShapeLine(fcvMap,coMapUtilities.initShapeLine(coMapUtilities.initLatLng(48.856614,2.3522219),coMapUtilities.initLatLng(31.630000,-8.008889),fxui.Color_ARGB(128,255,0,255),1dip,"Paris to Marrakech")))
	shapes.Add(coMapUtilities.instanceShapeCircle(fcvMap,coMapUtilities.initShapeCircle(coMapUtilities.initLatLng(31.630000,-8.008889),7dip,fxui.Color_ARGB(128,255,255,0),True,1dip,"Marrakech")))
	shapes.Add(coMapUtilities.instanceShapeLine(fcvMap,coMapUtilities.initShapeLine(coMapUtilities.initLatLng(31.630000,-8.008889),coMapUtilities.initLatLng(14.7645042,-17.3660286),fxui.Color_ARGB(128,255,0,255),1dip,"Marrakech to Dakar")))
	shapes.Add(coMapUtilities.instanceShapeCircle(fcvMap,coMapUtilities.initShapeCircle(coMapUtilities.initLatLng(14.7645042,-17.3660286),20dip,fxui.Color_ARGB(128,0,255,0),True,1dip,"Dakar")))

	Dim polygonPoints As List
	polygonPoints.Initialize
	polygonPoints.add(coMapUtilities.initLatLng(43.09296067711627,5.855712890625))
	polygonPoints.add(coMapUtilities.initLatLng(43.54456658436355,10.30517578125))
	polygonPoints.add(coMapUtilities.initLatLng(47.394630761906456,8.52813720703125))
	shapes.Add(coMapUtilities.instanceShapePolygon(fcvMap,coMapUtilities.initShapePolygon(polygonPoints,fxui.Color_ARGB(128,128,128,128),True,1dip,"Polygon Toulon Livorno, Zurich")))
		
	shapes.Add(coMapUtilities.instanceShapeImage(fcvMap,coMapUtilities.initShapeImage(coMapUtilities.initLatLng(43.296482,5.36978),fxui.LoadBitmapResize(File.DirAssets,"marker.png",25dip,33dip,True),0,"Marseille")))
	
	'init fmap with lat/lng, direction, zoom level, options and some shapes
	fMap=coMapUtilities.initMap(coMapUtilities.initLatLng(48,2),5,0,False,True,True,True,False,True,True,True,True,True, _
	                            shapes, _
								True,False,coMapUtilities.initGPS(coMapUtilities.initLatLng(0,0),0))
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
Private Sub B4XPage_Appear
	#IF B4A
	If Not(Starter.fGPS.GPSEnabled) Then
		wait for (fxui.MsgboxAsync("Please, enable GPS","Information")) MsgBox_Result (R As Int)
		StartActivity(Starter.fGPS.LocationSettingsIntent)
	Else
		Starter.frp.CheckAndRequest(Starter.frp.PERMISSION_ACCESS_FINE_LOCATION)
		Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
		If Result Then
			CallSubDelayed(Starter,"Start_GPS")
			CallSub2(Starter,"setGPSCallback",fcvMap)
		End If
	End If
	Dim pws As PhoneWakeState
	pws.KeepAlive(False)
	#END IF
End Sub

Private Sub B4XPage_Disappear
	#if b4A
		CallSub2(Starter,"setGPSCallback",Null)
		CallSubDelayed(Starter,"Stop_GPS")
		Dim pws As PhoneWakeState
		pws.ReleaseKeepAlive
	#end if
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	
End Sub

'Private Sub B4XPage_PermissionResult 
'	
'End Sub

private Sub fcvmap_ready
	'set values
	fcvMap.Map=fMap
	'draw the map
	fcvMap.draw
End Sub

Private Sub fcvMap_compassDirectionChanged(aDirection As Double)
	Log("compass changed: " & aDirection)
End Sub

Private Sub fcvMap_CenterLatLngChanged(aLatLng As TMapLatLng)
	Log("lat/Lng changed : " & aLatLng)
End Sub

Private Sub fcvMap_zoomLevelChanged(aZoomLevel As Int)
	Log("zoom level changed : " & aZoomLevel)
End Sub

Private Sub fcvMap_MenuClicked
	fPrefDlg.Clear
	fPrefDlg.LoadFromJson(File.ReadString(File.DirAssets,"menu.json"))
	fPrefDlg.Title="Settings"
	Dim d As Map=CreateMap("offlineMode":fcvMap.OfflineMode,"showGrid":fcvMap.ShowGrid, _
	                       "showCenter":fcvMap.ShowCenter,"showLandmark":fcvMap.ShowLandmark, _
						   "showCenterLatLng":fcvMap.ShowCenterLatLng,"showZoom":fcvMap.ShowZoom, _
						   "showScale":fcvMap.ShowScale,"showCompass":fcvMap.ShowCompass, _
						   "showShapes":fcvMap.ShowShapes,"showGPS":fcvMap.ShowGPS,"followGPS":fcvMap.followGPS)
	wait for (fPrefDlg.ShowDialog(d,"OK","CANCEL")) complete (result As Int)
	If result=fxui.DialogResponse_Positive Then
		fcvMap.OfflineMode=d.Get("offlineMode")
		fcvMap.ShowGrid=d.Get("showGrid")
		fcvMap.ShowCenter=d.Get("showCenter")
		fcvMap.ShowLandmark=d.Get("showLandmark")
		fcvMap.ShowCenterLatLng=d.Get("showCenterLatLng")
		fcvMap.ShowZoom=d.Get("showZoom")
		fcvMap.ShowScale=d.Get("showScale")
		fcvMap.ShowCompass=d.Get("showCompass")
		fcvMap.ShowShapes=d.Get("showShapes")
		fcvMap.ShowGPS=d.Get("showGPS")
		fcvMap.FollowGPS=d.Get("followGPS")
	End If
End Sub

Private Sub fcvMap_gpsClicked(aGPS As TMapGPS)
	'center the map on GPS
	fcvMap.CenterLatLng=aGPS.fLatLng
	fcvMap.draw
End Sub

Private Sub fcvMap_compassClicked(adegres As Double)
	'reset compass to 0°
	fcvMap.CompassDirection=0
End Sub

Private Sub fcvMap_ScaleClicked(aScale As Double)
	Log("128px = 	" & (aScale/2) & " meters")
End Sub

Private Sub fcvMap_CenterlatlngClicked(alatLng As TMapLatLng)
	fPrefDlg.Clear
	fPrefDlg.LoadFromJson(File.ReadString(File.DirAssets,"latlng.json"))
	fPrefDlg.Title="goto Lat/Lng"
	Dim d As Map=CreateMap("lat":alatLng.fLat,"lng":alatLng.fLng)
	wait for (fPrefDlg.ShowDialog(d,"OK","CANCEL")) complete (result As Int)
	If result=fxui.DialogResponse_Positive Then
		fcvMap.CenterLatLng=coMapUtilities.initLatLng(d.Get("lat"),d.Get("lng"))
		fcvMap.draw
	End If
End Sub

private Sub fcvmap_ShapesClicked(aLatLng As TMapLatLng,aList As List)
	'event contains
	Dim s As String=""
	For i=0 To aList.Size-1
		s=s & $"[${CallSub(aList.Get(i),"getShape_Type")}] : ${CallSub(aList.Get(i),"getShape_Data")}${CRLF}"$
	Next
	Dim sf As Object = fxui.Msgbox2Async($" ${s}"$, $" $1.5{aLatLng.flat} | $1.5{aLatLng.fLng} | Remove ${aList.Size} shape(s)"$, "Yes", "", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = fxui.DialogResponse_Positive Then
		For Each o As Object In aList
			fcvMap.removeShape(o)
		Next
		fcvMap.draw
	End If
End Sub

private Sub fcvmap_mapClicked(aLatLng As TMapLatLng)
	Dim sf As Object = fxui.Msgbox2Async("What do you want to do ?", "Question", "Add shape image", "Cancel", "Search",Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	Select Case Result
		Case  fxui.DialogResponse_Positive
			fcvMap.addShapeImage(coMapUtilities.initShapeImage(aLatLng,fxui.LoadBitmapResize(File.DirAssets,"marker.png",25dip,33dip,True),0,CreateMap("name":"New shape")))
			fcvMap.draw
		Case fxui.DialogResponse_Negative
			search
	End Select
End Sub

private Sub search
	Dim input As B4XInputTemplate
	input.Initialize
	input.lblTitle.Text = "Search address"
	Wait For (fDlg.ShowTemplate(input, "OK", "", "CANCEL")) Complete (Result As Int)
	If Result = fxui.DialogResponse_Positive Then
		SearchGeocoding(input.Text)
	End If
End Sub

private Sub SearchGeocoding(aquery As String)
	Dim su As StringUtils
	Dim q As String=su.EncodeUrl(aquery,"UTF8")
	Dim s As String=$"https://nominatim.openstreetmap.org/?addressdetails=1&q=${q}&format=json"$
	Dim j As HttpJob
	Try
		j.Initialize("", Me)
		j.Download(s)
		Wait For (j) JobDone(j As HttpJob)
		If j.Success Then
			Try
				parseGeocoding(j.GetString)
			Catch
				Log(LastException.Message)
			End Try
		End If
	Catch
		Log(LastException.Message)
	End Try
	If j.IsInitialized Then
		j.Release
	End If
End Sub

private Sub parseGeocoding(ajson As String)
	Dim jp As JSONParser
	jp.Initialize(ajson)
	Dim l As List=jp.NextArray
	If l.Size>0 Then
		Dim results As List
		results.Initialize
		For i=0 To l.size-1
			Dim m As Map=l.Get(i)
			results.Add(m.Get("display_name"))
		Next
		fPrefDlg.Clear
		fPrefDlg.LoadFromJson(File.ReadString(File.DirAssets,"search.json"))
		fPrefDlg.SetOptions("results",results)
		Dim d As Map=CreateMap("results":"","color":fxui.Color_Black,"radius":15)
		wait for (fPrefDlg.ShowDialog(d,"OK","CANCEL")) complete (result As Int)
		If result=fxui.DialogResponse_Positive Then
			For i=0 To l.size-1
				Dim m As Map=l.Get(i)
				If d.Get("results")=m.Get("display_name") Then
					Dim ll As TMapLatLng=coMapUtilities.initLatLng(m.Get("lat"),m.Get("lon"))
					fcvMap.addShapeCircle(coMapUtilities.initShapeCircle(ll,15dip,d.Get("color"),True,d.Get("radius")*1dip,m.Get("display_name")))
					fcvMap.CenterLatLng=ll
					fcvMap.draw
					Return
				End If
			Next
		End If
	Else
		wait for (fxui.MsgboxAsync("not found","Error")) MsgBox_Result (R As Int)
	End If
End Sub

