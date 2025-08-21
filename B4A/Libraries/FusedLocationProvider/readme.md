### FusedLocationProvider by warwound
### 03/12/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/50614/)

**FusedLocationProvider** is Android's latest attempt to improve the location services available to your applications.  
  
Official documentation can be found here: <https://developer.android.com/google/play-services/location.html>.  
  
This library depends on the **Google Play Services** library, **android-support-v4** library and the **GPS** library.  
The GPS library is required in order to use it's Location object.  
  
**FusedLocationProvider  
Events:**  

- **ConnectionFailed** (ConnectionResult1 As Int)
- **ConnectionSuccess**
- **ConnectionSuspended** (SuspendedCause1 As Int)
- **LocationChanged** (Location1 As Location)
- **LocationSettingsChecked** (LocationSettingsResult1 As LocationSettingsResult)

**Fields:**  

- **ConnectionResult As ConnectionResult**
*Contains the various ConnectionResult constants.*- **SuspendedCause As SuspendedCause**
*Contains the various SuspendedCause constants.*
**Methods:**  

- **CheckLocationSettings** (LocationSettingsRequest1 As LocationSettingsRequest)
*Checks if the relevant system settings are enabled on the device to carry out the desired location requests.  
Raises the event:  
 LocationSettingsChecked(LocationSettingsResult1 As LocationSettingsResult)*- **Connect**
*Attempt to connect to the Location Services.  
Will raise either event:  
ConnectionFailed(ConnectionResult1 As Int)  
 ConnectionSuccess*- **Disconnect**
*Disconnect from the Location Services.*- **GetLastKnownLocation As Location**
*Returns the best most recent location currently available.   
Can only be called if the FusedLocationProvider is connected.  
 The returned Location object will not be initialized if no last known location is available.*- **Initialize** (EventName As String)
*Initialize the FusedLocationProvider object.*- **IsConnected As Boolean**
*Returns whether the FusedLocationProvider is connected to the Location Services.*- **IsConnecting As Boolean**
*Returns whether the FusedLocationProvider is trying to connect to the Location Services.*- **IsInitialized As Boolean**
- **RemoveLocationUpdates**
*Remove all requests for location updates.*- **RequestLocationUpdates** (LocationRequest1 As LocationRequest)
*Request for location updates.  
 The LocationRequest object defines the criteria for which location updates are requested.*
  
This is the main library object.  
You call the FusedLocationProvider Initialize method and then it's **Connect** method.  
It will then raise the **ConnectionFailed** event or the **ConnectionSuccess** event.  
Assuming the ConnectionSuccess event is raised you can now call:  

- **GetLastKnownLocation As Location**
- **RequestLocationUpdates** (LocationRequest1 As LocationRequest)

  
So you could connect, get the last known location and then disconnect.  
There is no *requirement* to request location updates.  
This is a quick and simple way to get the device location.  
  
Or you could connect then initialize and configure a **LocationRequest** object and then request location updates.  
The LocationRequest object has various methods you can call to configure the request for location updates:  
  
**LocationRequest  
Fields:**  

- **Priority As Priority**
*Contains the various priority constants.*
**Methods:**  

- **GetExpirationTime As Long**
*Get the request expiration time, in milliseconds since boot.*- **GetFastestInterval As Long**
*Get the fastest interval of this request, in milliseconds.*- **GetInterval As Long**
*Get the desired interval of this request, in milliseconds.*- **GetNumUpdates As Int**
*Get the number of updates requested.*- **GetPriority As Int**
*Get the quality of the request.*- **GetSmallestDisplacement As Float**
*Get the minimum displacement between location updates in meters.  
 By default this is 0.*- **Initialize**
*Initialize the LocationRequest with default parameters.  
 Default parameters are for a block accuracy, slowly updated location.*- **IsInitialized As Boolean**
- **SetExpirationDuration** (Millis As Long) **As LocationRequest**
*Set the duration of this request, in milliseconds.*- **SetExpirationTime** (Millis As Long) **As LocationRequest**
*Set the request expiration time, in millisecond since boot.*- **SetFastestInterval** (Millis As Long) **As LocationRequest**
*Explicitly set the fastest interval for location updates, in milliseconds.*- **SetInterval** (Millis As Long) **As LocationRequest**
*Set the desired interval for active location updates, in milliseconds.*- **SetNumUpdates** (NumUpdates As Int) **As LocationRequest**
*Set the number of location updates.*- **SetPriority** (Priority As Int) **As LocationRequest**
*Set the priority of the request.*- **SetSmallestDisplacement** (SmallestDisplacementMeters As Float) **As LocationRequest**
*Set the minimum displacement between location updates in meters.  
 By default this is 0.*
  
It is important to note that part of the criteria that defines your request for a location is the **location permission** that you **(manually)** set in the manifest file.  
*This library does **not** automatically add any permission to your manifest and this library will fail to work if you do not manually add a required permission to your manifest file.*  
  
You can add one of two permissions to your manifest:  

- android.permission.ACCESS\_FINE\_LOCATION
- android.permission.ACCESS\_COARSE\_LOCATION

  
See: <https://developer.android.com/training/location/retrieve-current.html>  
> Apps that use location services must request location permissions.  
> Android offers two location permissions: ACCESS\_COARSE\_LOCATION and ACCESS\_FINE\_LOCATION.  
> The permission you choose determines the accuracy of the location returned by the API.  
> If you specify ACCESS\_COARSE\_LOCATION, the API returns a location with an accuracy approximately equivalent to a city block.

  
Also note that as this library uses the Google Play Services library, you must also add this entry to your manifest:  
  

```B4X
AddApplicationText(<meta-data  
    android:name="com.google.android.gms.version"  
    android:value="@integer/google_play_services_version" />)
```

  
  
Two versions of the library are attached.  

- If you're using a version of Google Play Services older than version 27 then you need to use FusedLocationProvider version 1.10.
- If you're using Google Play Services version 27 or newer then you need to use FusedLocationProvider version 1.30 or newer

  
Martin.  
  
**Edit by Erel:**  
Add these two lines if using with B4A v6+:  

```B4X
#AdditionalJar: com.android.support:support-v4  
#AdditionalJar: com.google.android.gms:play-services-location
```

  
New example where FLP is managed from the starter service: <https://www.b4x.com/android/forum/threads/fusedlocationprovider.50614/post-717726>