### Firebase RemoteConfig by Biswajit
### 01/12/2022
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/117624/)

This is a wrapper of Firebase RemoteConfig library for B4i. You can find the B4A version [here](https://www.b4x.com/android/forum/threads/new-firebase-remoteconfig.137574/). I made this for [USER=10835]@Jack Cole[/USER] and he gave me permission to post this in forum to help other users.  
  
**iFirebaseRemoteConfig  
  
Wrapper:** [USER=100215]@Biswajit[/USER]  
**Version:** 1.1  

- **FirebaseRemoteConfig**

- **Events:**

- **ActivatedWithCompletion** (error As String)
- **FetchedAndActivatedWithCompletion** (status As Int, error As String)
- **FetchedWithCompletion** (status As Int, error As String)
- **FetchedWithExpirationDuration** (status As Int, error As String)
- **InitializationFailed** (error As String)
- **Initialized**

- **Fields:**

- **FIRRemoteConfigError\_InternalError** As Int
- **FIRRemoteConfigError\_Throttled** As Int
- **FIRRemoteConfigError\_Unknown** As Int
- **FIRRemoteConfigFetchAndActivateStatus\_Error** As Int
- **FIRRemoteConfigFetchAndActivateStatus\_SuccessFetchedFromRemote** As Int
- **FIRRemoteConfigFetchAndActivateStatus\_SuccessUsingPreFetchedData** As Int
- **FIRRemoteConfigFetchStatus\_Failure** As Int
- **FIRRemoteConfigFetchStatus\_NoFetchYet** As Int
- **FIRRemoteConfigFetchStatus\_Success** As Int
- **FIRRemoteConfigFetchStatus\_Throttled** As Int
- **FIRRemoteConfigSource\_Default** As Int
- **FIRRemoteConfigSource\_Remote** As Int
- **FIRRemoteConfigSource\_Static** As Int

- **Functions:**

- **ActivateWithCompletionHandler**
*Applies Fetched Config data to the Active Config, causing updates to the behavior and  
 appearance of the app to take effect (depending on how config data is used in the app).  
 This will raise <b>Eventname\_ActivatedWithCompletion</b> event.  
 Error message will be empty if activation succeeded.*- **AllKeysFromSource** (source As Int) As List
*Gets all the parameter keys from a given source.  
 The source can be any constant value from FIRRemoteConfigSource.*- **ConfigValueForKey** (key As String) As FirebaseRemoteConfigValue
*Gets the config value.*- **ConfigValueForKeySource** (key As String, source As Int) As FirebaseRemoteConfigValue
*Gets the config value of a given source. The source can be any constant value from FIRRemoteConfigSource.*- **DefaultValueForKey** (key As String) As FirebaseRemoteConfigValue
*Returns the default value of a given key from the default config.*- **EnsureInitializedWithCompletionHandler**
*Ensures initialization is complete and clients can begin querying for Remote Config values.  
 This will raise <b>Eventname\_Initialized</b> event if initialization succeeded. Else <b>Eventname\_InitializationFailed</b>.*- **FetchAndActivateWithCompletionHandler**
*Fetches Remote Config data and if successful, activates fetched data. Optional completion handler callback  
 is invoked after the attempted activation of data, if the fetch call succeeded.  
 This will raise <b>Eventname\_FetchedAndActivatedWithCompletion</b> event.  
 Error message will be empty if fetching succeeded.  
 Status can be any constant value from FIRRemoteConfigFetchAndActivateStatus.*- **FetchWithCompletionHandler**
*Fetches Remote Config data with a callback.  
 This will raise <b>Eventname\_FetchedWithCompletion</b> event.  
 Error message will be empty if fetching succeeded.  
 Status can be any constant value from FIRRemoteConfigFetchStatus.*- **FetchWithExpirationDuration** (expirationDuration As Long)
*Fetches Remote Config data and sets a duration that specifies how long config data lasts.  
 Override the (default or optionally set minimumFetchInterval property in FIRRemoteConfigSettings) minimumFetchInterval  
 for only the current request, in seconds. Setting a value of 0 seconds will force a fetch to the backend.  
 This will raise <b>Eventname\_FetchedWithExpirationDuration</b> event.  
 Error message will be empty if fetching succeeded.  
 Status can be any constant value from FIRRemoteConfigFetchStatus.*- **Initialize** (eventname As String, callback As Object)
*Initializes the library inside the Application\_Start function.  
 <b>You should initialize FirebaseAnalytics before initializing this library.</b>*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **KeysWithPrefix** (prefix As String) As List
*Returns the set of parameter keys that start with the given prefix, from the default namespace in the active config.  
 If prefix is nil or empty, returns all the keys.*- **ObjectForKeyedSubscript** (key As String) As FirebaseRemoteConfigValue
*Gets the config value by using object subscripting syntax.*
- **Properties:**

- **ConfigSettings** As FirebaseRemoteConfigSettings
*Set custom config settings.*- **Defaults** As Map
*Sets config defaults for parameter keys and values in the default namespace config.*- **LastFetchStatus** As Int [read only]
*Last fetch status. The status can be any constant value from FIRRemoteConfigFetchStatus.*- **LastFetchTime** As Long [read only]
*Last successful fetch completion time.*
- **FirebaseRemoteConfigSettings**
*Firebase Remote Config settings*

- **Functions:**

- **Initialize**
*Initialize Firebase Remote Config settings.*- **isDeveloperModeEnabled** As Boolean
*Indicates whether Developer Mode is enabled.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Properties:**

- **FetchTimeout** As Long
*Indicates the default value in seconds to abandon a pending fetch request made to the backend. This value is set for outgoing requests as the timeoutIntervalForRequest as well as the timeoutIntervalForResource on the NSURLSession’s configuration.*- **MinimumFetchInterval** As Long
*Indicates the default value in seconds to set for the minimum interval that needs to elapse before a fetch request can again be made to the Remote Config backend. After a fetch request to the backend has succeeded, no additional fetch requests to the backend will be allowed until the minimum fetch interval expires.  
 <b>Note:</b> you can override this default on a per-fetch request basis using RemoteConfig.fetchWithExpirationDuration. For E.g. setting the expiration duration to 0 in the fetch request will override the minimumFetchInterval and allow the request to the backend.*
- **FirebaseRemoteConfigValue**
*This class provides a wrapper for Remote Config parameter values, with methods to get parameter values as different data types.*

- **Functions:**

- **Initialize** (value As Object)
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Properties:**

- **BoolValue** As Boolean [read only]
*Gets the value as a boolean.*- **DataValue** As Byte() [read only]
*Gets the value as a NSData object.*- **DoubleValue** As Double [read only]
*Gets the value as a double value.*- **IntValue** As Int [read only]
*Gets the value as an int value.*- **JSONValueAsList** As List [read only]
*Gets a foundation object (NSArray / List) by parsing the value as JSON.  
 This method uses NSJSONSerialization’s JSONObjectWithData method with an options value of 0.*- **JSONValueAsMap** As Map [read only]
*Gets a foundation object (NSDictionary / Map) by parsing the value as JSON.  
 This method uses NSJSONSerialization’s JSONObjectWithData method with an options value of 0.*- **LongValue** As Long [read only]
*Gets the value as a long value.*- **Source** As Int [read only]
*Identifies the source of the fetched value. One of the FIRRemoteConfigSource constant.*- **StringValue** As String [read only]
*Gets the value as a string.*
  
**Installation:**  

1. Download the latest libraries from [here](https://www.b4x.com/android/forum/threads/firebase-february-2021-local-mac.127643/#content).
2. Download the attached ZIP file.
3. Copy the **.framework,** **.a and .h** file to the local build server's **Libs** folder.
4. Then copy the **XML** file to the B4i **library** folder.

**Usage:**  

1. Create a new B4i project.
2. Follow firebase integration tutorial from [here](https://www.b4x.com/android/forum/threads/firebase-integration.68623/)
3. After initializing the Firebase Analytic library initialize this RemoteConfig library.
4. Please check the RemoteConfig throttling documentation from [here](https://firebase.google.com/docs/remote-config/use-config-ios#throttling).

**Update:**  

1. V1.1 - Fixed compilation issue with the newer firebase framework.

  
[**[SIZE=5]Click Here to Download[/SIZE]**](https://drive.google.com/file/d/1sQemuy0pCxZQN2eochl5BCMxy9eNTPfI/view?usp=sharing)