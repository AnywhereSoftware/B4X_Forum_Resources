### Firebase RemoteConfig by DonManfred
### 02/25/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/67801/)

This library allows you to use [Firebase RemoteConfig](https://firebase.google.com/docs/remote-config/) to your app.  
  
Requirements:  
- B4A 6+  
- To use this library you need to [Setup your app to use Firebase-Services first](https://www.b4x.com/android/forum/threads/integrating-firebase-services.67692/).  
  
Go to the [Firebase console](https://console.firebase.google.com) and setup remoteconfig  
  
![](http://snapshots.basic4android.de/remoteconfig5557.png)  
  
  
**RemoteConfig  
Author:** DonManfred (wrapper)  
**Version:** 2.50  

- **RemoteConfig**
Events:

- **onFetchComplete** (success As Boolean)

- **Fields:**

- **DEFAULT\_VALUE\_FOR\_BOOLEAN As Boolean**
- **DEFAULT\_VALUE\_FOR\_DOUBLE As Double**
- **DEFAULT\_VALUE\_FOR\_LONG As Long**
- **DEFAULT\_VALUE\_FOR\_STRING As String**
- **LAST\_FETCH\_STATUS\_FAILURE As Int**
- **LAST\_FETCH\_STATUS\_NO\_FETCH\_YET As Int**
- **LAST\_FETCH\_STATUS\_SUCCESS As Int**
- **LAST\_FETCH\_STATUS\_THROTTLED As Int**
- **VALUE\_SOURCE\_DEFAULT As Int**
- **VALUE\_SOURCE\_REMOTE As Int**
- **VALUE\_SOURCE\_STATIC As Int**

- **Methods:**

- **Defaults** (defaults As Map)
- **Initialize** (EventName As String)
- **IsInitialized As Boolean**
- **activateFetched As Boolean**
*Fetches parameter values for your app. Parameter values may be from the  
Default Config (local cache), or from the Remote Config Server,  
depending on how much time has elapsed since parameter values were last  
fetched from the Remote Config server. This method uses the default  
cache expiration of 12 hours.  
 Return type: @return:*- **fetch** (cacheExpiration As Int)
- **getBoolean** (key As String) **As Boolean**
*Gets the value corresponding to the specified key,  
 as a boolean.*- **getBoolean2** (key As String, namespace As String) **As Boolean**
*Gets the value corresponding to the specified key,  
 as a boolean, in the specified namespace.*- **getByteArray** (key As String) **As Byte[]**
*Gets the value corresponding to the specified  
key as a byte array.  
Returns Value as a byte array if a value  
corresponding to the look up key was present;  
 default (if set) or static default value otherwise.*- **getByteArray2** (key As String, namespace As String) **As Byte[]**
*Gets the value corresponding to the specified  
key, in the specified namespace, as a byte array.  
Returns Value as a byte array if a value  
corresponding to the look up key was present;  
 default (if set) or static default value otherwise.*- **getDouble** (key As String) **As Double**
*Gets the value corresponding to the specified  
key, in the specified namespace, as a double.  
Returns Value as a double if a value corresponding  
to the look up key was present and could be  
converted to a double; default (if set) or  
 static default value otherwise.*- **getDouble2** (key As String, namespace As String) **As Double**
*Gets the value corresponding to the specified  
key as a double.  
Returns Value as a double if a value corresponding  
to the look up key was present and could be  
converted to a double; default (if set) or  
 static default value otherwise.*- **getLong** (key As String) **As Long**
*Gets the value corresponding to the  
specified key, as a long.  
  
returns Value as a long if a value corresponding  
to the look up key was present and could be  
converted to a long; default (if set) or  
 static default value otherwise.*- **getLong2** (key As String, namespace As String) **As Long**
*Gets the value corresponding to the specified  
 key, in the specified namespace, as a long.*- **getString** (key As String) **As String**
*Gets the value corresponding to  
the specified key, as a string.  
  
returns alue as a string if a value corresponding  
to the look up key was present and could be converted  
to a string; default (if set) or  
 static default value otherwise.*- **getString2** (key As String, namespace As String) **As String**
*Gets value as a string corresponding  
to the specified key in the specified namespace.  
returns alue as a string if a value corresponding  
to the look up key was present and could be converted  
to a string; default (if set) or  
 static default value otherwise.*- **getValue** (key As String) **As FirebaseRemoteConfigValue**
*Gets the FirebaseRemoteConfigValue  
 corresponding to the specified key.*- **getValue2** (key As String, namespace As String) **As FirebaseRemoteConfigValue**
- **setDefaults2** (defaults As Map, namespace As String)

- **Properties:**

- **ConfigSettings As FirebaseRemoteConfigSettings** *[write only]*
Changes the settings for the FirebaseRemoteConfig
object's operations, such as turning the developer mode on.- **Info As FirebaseRemoteConfigInfo** *[read only]*
Gets the current state of the
FirebaseRemoteConfig singleton object.
returns A FirebaseRemoteConfigInfo wrapping the current state.
- **RemoteConfigValue**
Methods:

- **Initialize** (cfg As FirebaseRemoteConfigValue)
- **IsInitialized As Boolean**
- **asBoolean As Boolean**
- **asByteArray As Byte[]**
- **asDouble As Double**
- **asLong As Long**
- **asString As String**

- **Properties:**

- **Source As Int** *[read only]*
VALUE\_SOURCE\_REMOTE if the value was retrieved
from the server, VALUE\_SOURCE\_DEFAULT if the
value was set as a default, or VALUE\_SOURCE\_STATIC
if no value was found and a static default
value was returned instead.
  
  

```B4X
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Dim cfg As RemoteConfig  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    'Activity.LoadLayout("Layout1")  
    cfg.Initialize("Config")  
    cfg.Defaults(CreateMap("Month": 1, "loading_phrase": "Hallo world!"))  
    Log("loading_phrase="&cfg.getString("loading_phrase"))  
    Log("Fetching")  
    cfg.fetch(86400)  
End Sub  
  
Sub Activity_Resume  
End Sub  
Sub Activity_Pause (UserClosed As Boolean)  
End Sub  
  
Sub Config_onFetchComplete(success As Boolean)  
    Log($"Config_onFetchComplete(${success})"$)  
    If success Then  
        Log("Activate fetched values")  
        cfg.activateFetched  
        Log("loading_phrase="&cfg.getString("loading_phrase"))  
    End If  
  
End Sub
```

  
  
> LogCat connected to: 9885e6514556383552  
> ——— beginning of system\*\* Service (starter) Create \*\*  
> \*\* Activity (main) Create, isFirst = true \*\*  
> Hallo world!  
> Fetching  
> \*\* Service (starter) Start \*\*  
> \*\* Activity (main) Create, isFirst = true \*\*  
> \*\* Activity (main) Resume \*\*  
> Fetch Succeeded  
> lib:Raising.. config\_onfetchcomplete()  
> Config\_onFetchComplete(true)  
> Activate fetched values  
> loading\_phrase=DonManfred presents

  
  
SETUP:  
- Use V2.5+ of the Library.  
- Follow the Firebaseintegration Tutorial  
  
Replace in the Manifesteditor the line  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.Firebase)
```

  
  
with  
  

```B4X
CreateResourceFromFile(Macro, FirebaseRemoteConfig.Firebase)
```

  
  
NOTES:  
- If you ran into an Error  
[SIZE=6]**protobuf-lite Maven artifact not found**[/SIZE]  
then please copy the file com.google.protobuf-protobuf-lite.jar to your additional library folder