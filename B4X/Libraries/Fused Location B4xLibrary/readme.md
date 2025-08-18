###  Fused Location B4xLibrary by hatzisn
### 10/26/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/116055/)

Hey everyone,  
  
I created this B4X library to avoid the different implementations of GPS Locating in B4A and B4i.  
  
In B4A it uses the FusedLocationProvider and in B4i it uses the iLocation Library. The code for the FusedLocationProvider in B4A is taken and changed slighly from this thread:  
  
<https://www.b4x.com/android/forum/threads/fusedlocationprovider.50614/page-8#post-717726>  
  
  
  
Implementation in B4A  
  
1) Add the following code to the manifest  

```B4X
'Manifest  
'=============================================================  
'Fused Location Provider  
'*************************************************************  
AddPermission(android.permission.ACCESS_FINE_LOCATION)  
AddPermission(android.permission.ACCESS_COARSE_LOCATION)  
AddApplicationText(<meta-data  
    android:name="com.google.android.gms.version"  
    android:value="[USER=21225]@Integer[/USER]/google_play_services_version" />)  
'*************************************************************
```

  
  
Edit: [ USER=21225][USER=21225]@Integer[/USER][/USER ] is just "at" integer but it is changed automatically.  
  
  
  
2) Add the following to the Main Activity  

```B4X
'Main  
'=============================================================  
'*************************************************************  
#AdditionalJar: com.android.support:support-v4  
#AdditionalJar: com.google.android.gms:play-services-location  
'*************************************************************  
  
Sub Process_Globals  
    Dim rp as RuntimePermissions  
    Dim fl As FusedLocation  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    'Activity.LoadLayout("Layout1")  
    rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)  
    wait for Activity_PermissionResult(Permission As String, Result As Boolean)  
    rp.CheckAndRequest(rp.PERMISSION_ACCESS_COARSE_LOCATION)  
    wait for Activity_PermissionResult(Permission As String, Result As Boolean)  
  
    If Result = False Then Activity.Finish  
  
    fl.Initialize("fl", Me)  
    fl.StartFLP  
End Sub  
  
Public Sub fl_LocationChanged(Location1 As Location)  
    Log(Location1.Latitude & "," &  Location1.Longitude)  
    fl.StopFLP  
End Sub
```

  
  
  
Implementation in B4i  
  
Add the following to Module Main  
  

```B4X
'Main  
'=============================================================  
'*************************************************************  
#PlistExtra:<key>NSLocationWhenInUseUsageDescription</key><string>This application is used to display the current navigation data.</string>  
#PlistExtra:<key>NSLocationUsageDescription</key><string>This application is used to display the current navigation data.</string>  
'*************************************************************  
Sub Process_Globals  
  
    Dim fl As FusedLocation  
End Sub  
  
Private Sub Application_Start (Nav As NavigationController)  
    'SetDebugAutoFlushLogs(True) 'Uncomment if program crashes before all logs are printed.  
    NavControl = Nav  
    Page1.Initialize("Page1")  
    Page1.Title = "Page 1"  
    Page1.RootPanel.Color = Colors.White  
    NavControl.ShowPage(Page1)  
    fl.Initialize("fl", Me)  
    fl.StartFLP  
End Sub  
  
Public Sub fl_LocationChanged(Location1 As Location)  
    Log(Location1.Latitude & "," &  Location1.Longitude)  
    fl.StopFLP  
End Sub
```