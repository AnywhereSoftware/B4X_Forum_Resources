### GPSGNSS Library by Ivica Golubovic
### 11/01/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/157158/)

After discovering several problems in the operation of **GPS** and **GNSS** libraries on **SDK32** and **SDK33**, I decided to make one library that will be compatible with almost all versions of android (from **SDK less than 24** to **SDK33** and above). This library combines deprecated **GPS classes** with still up-to-date **GNSS classes** and, based on the android version, decides which one to use. Basically, if used on SDK less than 24, library will use **GPS set of classes**, otherwise **GNSS set of classes**. This allows developers to use one library to create an application which will work on almost all android **SDK** versions.  
  
The working principle of this library is almost exactly the same as that of the native **GPS library**. The library contains the same methods and the same events. Of course, there are a few additional methods, properties and events, but the basic ones have remained unchanged.  
  
The only major change is that instead of the "**Location**" class that is part of the **GPS library**, this library uses the "**ALocation**" class that is in a separate library called "**ALocation**" which is packaged together with the **GPSGNSS library**. The **"ALocation" library must be checked together with the GPSGNSS library** (picture below). This was done to avoid accidental class conflicts with the **GPS or GNSS libraries**. So your old project that uses the **GPS library** needs to be reworked so that wherever class "**Location**" is used, **just put an "A" in front of "Location" = "ALocation"**. It shouldn't be that hard ;) .  
  
![](https://www.b4x.com/android/forum/attachments/147466)  
  
Also, the "**GPSEnabled**" property has been replaced with "**IsLocationEnabledInSettings**" relative to the **GPS library**. Everything else is the same with a few added methods, events and properties.  
  
An addition in this library compared to the old ones is a class called **NETPOS** (**NET**work **POS**itioning). This class uses the network provider to determine the location (can be used when the GPS or GNSS signal is weak or unavailable). Both classes can be used in parallel so that locating is always available. The **NETPOS** class uses the same methods and properties as the **GPSGNSS** class, with the exception of events such as **GpsStatus** and **NMEA**, which are unavailable when using a network provider.  
  
  
The **METHODS** contained in the **GPSGNSS** and **NETPOS** classes are:  

- **GetCurrentLocation** (new method) - This method asynchronously determines the current location. At the end of the procedure, the "**CurrentLocationResult** (**Location1** As ALocation)" event is activated.
- **Initialize** (the same as in **GPS library**).
- **IsInitialized** (the same as in **GPS library**).
- **Start** (the same as in **GPS library**).
- **Stop** (the same as in **GPS library**).

  
The **PROPERTIES** contained in the **GPSGNSS** and **NETPOS** classes are:  

- **IsLocationEnabledInSettings** (Equivalent to the **GPSEnabled** property in the **GPS library**).
- **IsStarted** (new property) - returns true if **GPSGNSS** or **NETPOS** is started and listening for events, otherwise false.
- **LastKnownLocation** (new property) - returns the last remembered location without calculating the current location.
- **LocationSettingsIntent** (the same as in **GPS library**).

  
The **EVENTS** contained in the **GPSGNSS** and **NETPOS** classes are:  

- **LocationChanged** (**Location1** As ALocation) - (the same as in **GPS library**).
- **LocationChanged2** (**Locations()** As ALocation) 'Works on **SDK31** and up - (new event).
- **UserEnabled** (**Enabled** As Boolean) - (the same as in **GPS library**).
- **GpsStatus** (**Satellites** As List) - (the same as in **GPS library**) available only in **GPSGNSS** class.
- **NMEA** (**TimeStamp** As Long, **Sentence** As String) - (the same as in **GPS library**) available only in **GPSGNSS** class.
- **Started** - (new event) will bi fired when **GPSGNSS** or **NETPOS** is started and starts to listening for events (**Start** method called).
- **Stopped** - (new event) will bi fired when **GPSGNSS** or **NETPOS** stops to listening for events (**Stop** method called).
- **CurrentLocationResult** (**Location1** As ALocation) - (new event) will bi fired after calling **GetCurrentLocation** method.

  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private GPS As GPSGNSS  
    Private rp As RuntimePermissions  
    Private lblNumOfSattelites As Label  
    Private lblAverageSignal As Label  
    Private lblLatitude As Label  
    Private lblLongitude As Label  
End Sub  
  
Public Sub Initialize  
    B4XPages.GetManager.LogEvents = True  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
     
    'Requesting Location's runtime permissions  
    rp.CheckAndRequest(rp.PERMISSION_ACCESS_COARSE_LOCATION)  
    Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)  
    If Result=False Then  
        ExitApplication  
    End If  
    rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)  
    Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)  
    If Result=False Then  
        ExitApplication  
    End If  
     
    If GPS.IsInitialized=False Then  
        GPS.Initialize("GPS")  
    End If  
End Sub  
  
Private Sub B4XPage_Disappear  
    If GPS.IsInitialized Then  
        If GPS.IsStarted Then  
            GPS.Stop  
        End If  
    End If  
    ExitApplication  
End Sub  
  
Private Sub btnStartGPSGNSS_Click  
     
    If GPS.IsStarted=False Then  
        GPS.Start(0,0)  
    End If  
End Sub  
  
Private Sub btnStopGPSGNSS_Click  
    If GPS.IsStarted=True Then  
        GPS.Stop  
    End If  
End Sub  
  
Private Sub Msgbox_Result (Result As Int)  
     
End Sub  
  
Private Sub btnGetLastKnownLocation_Click  
    Dim loc As ALocation=GPS.LastKnownLocation  
    If loc.IsInitialized Then  
        MsgboxAsync("Your last known location is:" & CRLF & "Latitude=" & loc.Latitude & CRLF & "Longitude=" & loc.Longitude,"Last Known Location")  
    End If  
End Sub  
  
Private Sub btnCurrentLocation_Click  
    ProgressDialogShow("Collecting information…")  
    Sleep(20)  
    GPS.GetCurrentLocation  
    Wait For GPS_CurrentLocationResult (Location1 As ALocation)  
    ProgressDialogHide  
    If Location1.IsInitialized Then  
        MsgboxAsync("Your current location is:" & CRLF & "Latitude=" & Location1.Latitude & CRLF & "Longitude=" & Location1.Longitude,"Current Location")  
    End If  
End Sub  
  
Private Sub GPS_GpsStatus (Satellites As List)  
    If GPS.IsStarted Then  
        Dim NumOfSat As Int=0  
        Dim Signal As Float=0  
        For Each sat As GPSSatellite In Satellites  
            If sat.UsedInFix Then  
'            Log("——–SATTELITE " & Satellites.IndexOf(sat) & "———————–")  
'            Log("Azimuth=" & sat.Azimuth)  
'            Log("Elevation=" & sat.Elevation)  
'            Log("Prn=" & sat.Prn)  
'            Log("Snr=" & sat.Snr)  
'            Log("HasAlmanac=" & sat.HasAlmanac)  
'            Log("HasEphemeris=" & sat.HasEphemeris)  
'            Log("UsedInFix=" & sat.UsedInFix)  
'            Log("————————————————————————-")  
                NumOfSat=NumOfSat+1  
                Signal=Signal+sat.Snr  
            End If  
        Next  
        lblNumOfSattelites.Text="Satelites in use: " & NumOfSat  
        lblAverageSignal.Text="Average signal: " & Round2(Signal/NumOfSat,2)  
    End If  
End Sub  
  
Private Sub GPS_LocationChanged (Location1 As ALocation)  
    If GPS.IsStarted Then  
        lblLatitude.Text="Latitude: " & Round2(Location1.Latitude,8)  
        lblLongitude.Text="Longitude: " & Round2(Location1.Longitude,8)  
    End If    
End Sub  
  
Private Sub GPS_UserEnabled (Enabled As Boolean)  
    Log("LocationEnabled = " & Enabled)  
'    If Enabled=False Then  
'        StartActivity(GPS.LocationSettingsIntent)  
'    End If  
End Sub  
  
Private Sub GPS_NMEA (TimeStamp As Long, Sentence As String)  
    'Log("NMEA: Sentence=" & Sentence & "    TimeStamp=" & TimeStamp)  
End Sub  
  
Private Sub GPS_LocationChanged2 (Locations() As ALocation) 'Works on SDK31 and up  
    'Log(Locations.Length)  
End Sub  
  
Private Sub GPS_Started  
    Log("GPS_Started    GPS.IsStarted=" & GPS.IsStarted)  
    lblNumOfSattelites.Text="Satelites in use: calculting"  
    lblAverageSignal.Text="Average signal: calculting"  
    lblLatitude.Text="Latitude: calculting"  
    lblLongitude.Text="Longitude: calculting"  
End Sub  
  
Private Sub GPS_Stopped  
    Log("GPS_Stopped    GPS.IsStarted=" & GPS.IsStarted)  
    lblNumOfSattelites.Text="Satelites in use: unknown"  
    lblAverageSignal.Text="Average signal: unknown"  
    lblLatitude.Text="Latitude: unknown"  
    lblLongitude.Text="Longitude: unknown"  
End Sub
```

  
  
**This library was tested on devices with SDK23, SDK27, SDK28, SDK29, SDK31 and SDK33.**  
  
If this library makes your work easier and saves time in creating your application, please make a donation.  
<https://www.paypal.com/donate?hosted_button_id=HX7GS8H4XS54Q>