### Google Maps by Erel
### 07/07/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/63930/)

![](https://www.b4x.com/android/forum/attachments/41895)  
  
  
Installation instructions:  
  
- Register your app in Google developer console: <https://console.developers.google.com>  
You need to enable Google Maps Android API.  
Then click on Credentials -> Create Credentials -> API Key -> Android Key.  
You should get a key that looks like: AIzaSyCmFHamGE0O0BvxxxxxxxxXbTCSrjFVg-Q  
  
- Add this to the manifest editor (replace the value with your key):  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase)  
  
AddApplicationText(  
<meta-data  
  android:name="com.google.android.geo.API_KEY"  
  android:value="xxxxxxxxxxxxxx"/>  
)
```

  
  
  
- Add a MapFragment with the visual designer. It will appear under the CustomView menu. If you don't see it then make sure that the GoogleMaps library is selected.  
You can change the properties from the designer.  
Set the anchors to BOTH so the map will fill the activity:  
  
![](https://www.b4x.com/basic4android/images/SS-2016-02-24_12.13.18.png)  
  
  
Implement the Ready event to get a reference to the GoogleMap object.  
Complete code:  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private MapFragment1 As MapFragment  
    Private gmap As GoogleMap  
    Private rp As RuntimePermissions  
End Sub  
  
Public Sub Initialize  
      
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    Wait For MapFragment1_Ready  
    gmap = MapFragment1.GetMap  
    rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)  
    Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)  
    If Result Or rp.Check(rp.PERMISSION_ACCESS_COARSE_LOCATION) Then  
        gmap.MyLocationEnabled = True  
    Else  
        Log("No permission!")  
    End If  
End Sub
```

  
  
  
**Updates  
  
-** v2.50 - Required dependencies were added to the library.  
 My Location Enabled property was removed from the designer as it needs to be set after the permission is granted.  
- v2.02 EXTERNAL\_STORAGE permission removed. It is no longer required.  
GetOpenSourceLicenseInfo returns an empty string.  
Fixes an issue with the ready event being lost if the activity is paused before the map is ready.  
  
Note that you will need to update the package name and api key in the attached example.