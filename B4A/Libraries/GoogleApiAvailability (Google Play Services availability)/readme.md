### GoogleApiAvailability (Google Play Services availability) by Ivica Golubovic
### 11/12/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/157361/)

**GoogleApiAvailability** (Google Play Services availability) is a small library that serves as an aid in establishing the existence and correctness of the installation of google play services. With the help of this library, it is possible to detect whether the device is supported by Google, whether play services are installed, whether the latest version of play services is installed and whether play services are not disabled.  
  
One of my applications on the play store was reporting crashes related to Google services irregularities. It took me quite some time to figure out what the source of the problem was. Because of this, the application received a small number of negative comments because the users themselves were not aware of why the application crashes for them, while it works correctly for other users. In most cases, the problem was in an outdated version of play services, and in a smaller percentage, play services were disabled in the past by users.  
  
In order to help myself, and now also other B4A developers, I made a small library that will allow the application not to crash if there are any irregularities related to google services and also instruct the user how to solve the problem if there is a user-friendly solution for that problem. If your application uses one or several parts (classes) of google services (eg **GoogleMaps**, **Firebase**, **FusedLocation**, **Cast**, **Geofence** and many others), before initializing the object it is necessary to check whether everything is OK with google services.  
  
There are several ways to perform the verification process with the help of this library. The simplest way, and likely to be used by most B4A developers, is as follows:  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
          
    Dim Google As GoogleApiAvailability  
    Google.CheckAndMakeGooglePlayServicesAvailable("Google",True) 'True to show error dialog first  
    Wait For Google_OnMakeGooglePlayServicesAvailableResult (Available As Boolean)  
    If Available = False Then  
        MsgboxAsync("This device does not have the correct installation of Google Play Services and the application is unable to continue working. For this reason the application will be shut down.","Google Play Services error")  
        Wait For Msgbox_Result (Result As Int)  
        ExitApplication  
    End If  
      
    Root.LoadLayout("MainPage")  
    'Continue with aplication and play services objects initialization…  
End Sub
```

  
  
In this case, the library will check if everything is fine with google services on the device. If everything is fine, the **OnMakeGooglePlayServicesAvailableResult** event will be fired with **Available = True**. If there are irregularities, in a large number of cases a localized dialogue predefined by Google will be displayed (if you pass **ShowInfoDialog** as **True** like in example). In this dialog, it will be stated which problem is related to google services. If the problem is solvable for the user and when the user presses the positive button on the dialog, a new activity related to the solution of the specified problem will be started (Play Store or Settings). When the user completes the procedure and closes the offered activity, the **OnMakeGooglePlayServicesAvailableResult** event will be triggered. If the problem is unsolvable by the user and when the user presses the positive button on the dialog, the dialog will close and after that the **OnMakeGooglePlayServicesAvailableResult** event will fire. Also, if the user presses the negative button or cancel, the **OnMakeGooglePlayServicesAvailableResult** event will be fired. If you pass **ShowInfoDialog** as **False** (The opposite as in the example), if error is user resolvable, solution activity will be started without displaying the info dialog.  
  
In the above procedure, the process is completely automated. It is also possible to perform a manual check and, if desired, display manually defined MsgBoxes, or without them. An example of this case is shown below:  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
          
    Dim Google As GoogleApiAvailability  
    If Google.IsGooglePlayServicesAvailable=False Then  
        Dim AvailabilityInt As Int = Google.IsGooglePlayServicesAvailable2  
        Select AvailabilityInt  
            Case Google.CONNECTION_RESULT_SERVICE_DISABLED  
                MsgboxAsync("[Your text]","[Your title]")  
                Wait For Msgbox_Result (Result As Int)  
            Case Google.CONNECTION_RESULT_SERVICE_INVALID  
                MsgboxAsync("[Your text]","[Your title]")  
                Wait For Msgbox_Result (Result As Int)  
            Case Google.CONNECTION_RESULT_SERVICE_MISSING  
                MsgboxAsync("[Your text]","[Your title]")  
                Wait For Msgbox_Result (Result As Int)  
            Case Google.CONNECTION_RESULT_SERVICE_UPDATING  
                MsgboxAsync("[Your text]","[Your title]")  
                Wait For Msgbox_Result (Result As Int)  
            Case Google.CONNECTION_RESULT_SERVICE_VERSION_UPDATE_REQUIRED  
                MsgboxAsync("[Your text]","[Your title]")  
                Wait For Msgbox_Result (Result As Int)  
            Case Else 'Play services unsolvable error  
                MsgboxAsync("This device does not have the correct installation of Google Play Services and the application is unable to continue working. For this reason the application will be shut down.","Google Play Services error")  
                Wait For Msgbox_Result (Result As Int)  
                ExitApplication  
        End Select  
        Google.MakeGooglePlayServicesAvailable("Google",False,AvailabilityInt) 'Pass False to not show google predefined dialog (only solution activity will be started if available)  
        Wait For Google_OnMakeGooglePlayServicesAvailableResult (Available As Boolean)  
        If Available = False Then  
            MsgboxAsync("This device does not have the correct installation of Google Play Services and the application is unable to continue working. For this reason the application will be shut down.","Google Play Services error")  
            Wait For Msgbox_Result (Result As Int)  
            ExitApplication  
        End If  
    End If  
    Root.LoadLayout("MainPage")  
    'Continue with aplication and play services objects initialization…  
End Sub
```

  
  
This library also contains several additional properties that can provide additional information about the state of the play service and the play store if needed.  
  
It is also necessary to add the following line to the manifest to be able to use **GoogleApiAvailability** library. Otherwise library will not function and error exception will be thrown.  

```B4X
AddApplicationText(<meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version" />)
```

  
  
**GoogleApiAvailability**  
  
**Author:** Ivica Golubovic  
**Version:** 1.0  

- **GoogleApiAvailability**
*IMPORTANT! Add next line to manifest:  
<code>AddApplicationText(<meta-data android:name="com.google.android.gms.version" android:value="[USER=21225]@Integer[/USER]/google\_play\_services\_version" />)</code>*

- **Events:**

- **OnMakeGooglePlayServicesAvailableResult** (Available As Boolean)

- **Fields:**

- **CONNECTION\_RESULT\_SERVICE\_DISABLED** As Int
*The installed version of Google Play services has been disabled on this device. This is an user resolvable error.  
Constant Value: 3*- **CONNECTION\_RESULT\_SERVICE\_INVALID** As Int
*The version of the Google Play services installed on this device is not authentic. This is not an user resolvable error but error dialog will be shown if you call MakeGooglePlayServicesAvailable with ShowInfoDialog=True.  
Constant Value: 9*- **CONNECTION\_RESULT\_SERVICE\_MISSING** As Int
*Google Play services is missing on this device. This is an user resolvable error.  
Constant Value: 1*- **CONNECTION\_RESULT\_SERVICE\_UPDATING** As Int
*Google Play service is currently being updated on this device. This is not an user resolvable error but error dialog will be shown if you call MakeGooglePlayServicesAvailable with ShowInfoDialog=True.  
Constant Value: 18*- **CONNECTION\_RESULT\_SERVICE\_VERSION\_UPDATE\_REQUIRED** As Int
*The installed version of Google Play services is out of date. This is an user resolvable error.  
Constant Value: 2*- **CONNECTION\_RESULT\_SUCCESS** As Int
*The connection was successful and Google Play Services are available.  
Constant Value: 0*
- **Functions:**

- **CheckAndMakeGooglePlayServicesAvailable** (EventName As String, ShowInfoDialog As Boolean)
*Checks and attempts to make Google Play services available on this device if it is not available. Event OnMakeGooglePlayServicesAvailableResult will be fired when fixing procedure is finished by user or if fixing procedure is not required.  
EventName: name of event to be fired.  
ShowInfoDialog: True to show dialog which displays a localized message about the error and upon user confirmation (by tapping on dialog) will direct them to the Play Store if Google Play services is out of date or missing, or to system settings if Google Play services is disabled on the device. False to start solution activity without showing error dialog.*- **MakeGooglePlayServicesAvailable** (EventName As String, ShowInfoDialog As Boolean, ConnectionResult As Int)
*Attempts to make Google Play services available on this device if it is not available. Event OnMakeGooglePlayServicesAvailableResult will be fired when fixing procedure is finished by user or if fixing procedure is not required.  
EventName: name of event to be fired.  
ShowInfoDialog: True to show dialog which displays a localized message about the error and upon user confirmation (by tapping on dialog) will direct them to the Play Store if Google Play services is out of date or missing, or to system settings if Google Play services is disabled on the device. False to start solution activity without showing error dialog.  
ConnectionResult: integer value returned by IsGooglePlayServicesAvailable2 call. If it is equal CONNECTION\_RESULT\_SUCCESS then OnMakeGooglePlayServicesAvailableResult event will be fired immediately with True result.*- **ShowErrorNotification**
*Displays a notification for an error code returned from IsGooglePlayServicesAvailable2, if it is resolvable by the user.*
- **Properties:**

- **ErrorResolutionIntent** As Intent [read only]
*Returns the intent which will direct the user to either the Play Store if Google Play services is out of date or missing, or system settings if Google Play services is disabled on the device.*- **GooglePlayServicesPackageName** As String [read only]
*Returns package name for Google Play services.*- **GooglePlayServicesSettingsIntent** As Intent [read only]
*Returns Google Play Services settings intent.*- **GooglePlayServicesUpdateIntent** As Intent [read only]
*Returns Google Play Services install or update intent.*- **GooglePlayServicesVersionCode** As Int [read only]
*Returns Google Play services client library version code.*- **GooglePlayStorePackageName** As String [read only]
*Returns package name for Google Play Store application.*- **IsGooglePlayServicesAvailable** As Boolean [read only]
*Returns True if Google Play services is installed and enabled on this device, and if the version installed on this device is no older than the one required by this client. Otherwise returns False.*- **IsGooglePlayServicesAvailable2** As Int [read only]
*Verifies that Google Play services is installed and enabled on this device, and that the version installed on this device is no older than the one required by this client.  
Returns one of following int values: CONNECTION\_RESULT\_SUCCESS, CONNECTION\_RESULT\_SERVICE\_MISSING, CONNECTION\_RESULT\_SERVICE\_UPDATING, CONNECTION\_RESULT\_SERVICE\_VERSION\_UPDATE\_REQUIRED, CONNECTION\_RESULT\_SERVICE\_DISABLED and CONNECTION\_RESULT\_SERVICE\_INVALID.*- **IsPlayServicesPossiblyUpdating** As Boolean [read only]
*Returns True if Google Play Service can be updated and if a new version exists. Otherwise False.*- **IsPlayStorePossiblyUpdating** As Boolean [read only]
*Returns True if Google Play Store can be updated and if a new version exists. Otherwise False.*- **IsUserResolvableError** As Boolean [read only]
*Returns True whether an error can be resolved via user action or if Google Play Services are available.*
  
If this libraries makes your work easier and saves time in creating your application, please make a donation.  
<https://www.paypal.com/donate?hosted_button_id=HX7GS8H4XS54Q>