### [NEW] Firebase RemoteConfig by Biswajit
### 01/12/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/137574/)

This is a wrapper of the Firebase RemoteConfig library for B4A. You can find the B4I version [here](https://www.b4x.com/android/forum/threads/firebase-remoteconfig.117624/). I made this for [USER=38882]@tufanv[/USER] and he gave me permission to post this in forum to help other users.  
  
**FirebaseRemoteConfig  
  
Author:** [USER=100215]@Biswajit[/USER]  
**Version:** 1.0  

- **FirebaseRemoteConfig**

- **Events:**

- **Activated** (activated As Boolean)
- **ConfigInfoReceived** (info As FirebaseRemoteConfigInfo)
- **DefaultsAdded**
- **Error** (message As String)
- **Fetched**
- **FetchedAndActivated** (activated As Boolean)
- **Initialized**
- **ResetComplete**

- **Fields:**

- **DEFAULT\_VALUE\_FOR\_BOOLEAN** As Boolean
*The static default boolean value for any given key.*- **DEFAULT\_VALUE\_FOR\_BYTE\_ARRAY** As Byte()
*The static default byte array value for any given key.*- **DEFAULT\_VALUE\_FOR\_DOUBLE** As Double
*The static default double value for any given key.*- **DEFAULT\_VALUE\_FOR\_LONG** As Long
*The static default long value for any given key.*- **DEFAULT\_VALUE\_FOR\_STRING** As String
*The static default string value for any given key.*- **LAST\_FETCH\_STATUS\_FAILURE** As Int
*Indicates that the most recent attempt to fetch parameter values from the Firebase Remote Config Server has failed.*- **LAST\_FETCH\_STATUS\_NO\_FETCH\_YET** As Int
*Indicates that the FirebaseRemoteConfig singleton object has not yet attempted to fetch parameter values from the Firebase Remote Config Server.*- **LAST\_FETCH\_STATUS\_SUCCESS** As Int
*Indicates that the most recent fetch of parameter values from the Firebase Remote Config Server was completed successfully.*- **LAST\_FETCH\_STATUS\_THROTTLED** As Int
*Indicates that the most recent attempt to fetch parameter values from the Firebase Remote Config Server was throttled.*- **VALUE\_SOURCE\_DEFAULT** As Int
*Indicates that the value returned was retrieved from the defaults set by the client.*- **VALUE\_SOURCE\_REMOTE** As Int
*Indicates that the value returned was retrieved from the Firebase Remote Config Server.*- **VALUE\_SOURCE\_STATIC** As Int
*Indicates that the value returned is the static default value.*
- **Functions:**

- **Activate**
*Asynchronously activates the most recently fetched configs, so that the fetched key value pairs take effect.  
 Task with a true result if the current call activated the fetched configs; if the fetched configs were already activated by a previous call, returns a Task with a false result.  
 On success Eventname\_Activated event will be raised.*- **EnsureInitialized**
*Returns an object representing the initialization status of this Firebase Remote Config instance.  
 On success Eventname\_ConfigInfoReceived will be raised.*- **Fetch**
*Starts fetching configs, adhering to the default minimum fetch interval.  
 On success Eventname\_Fetched will be raised.  
 The fetched configs only take effect after the next activate() call.  
 Depending on the time elapsed since the last fetch from the Firebase Remote Config backend, configs are either served from local storage, or fetched from the backend. The default minimum fetch interval can be set while initializing the library; the static default is 12 hours.  
 Note: Also initializes the Firebase installations SDK that creates installation IDs to identify Firebase installations and periodically sends data to Firebase servers. Remote Config requires installation IDs for Fetch requests. To stop the periodic sync, call delete(). Sending a Fetch request after deletion will create a new installation ID for this Firebase installation and resume the periodic sync.*- **Fetch2** (minimumFetchIntervalInSeconds As Long)
*Starts fetching configs, adhering to the specified minimum fetch interval.  
 The fetched configs only take effect after the next activate() call.  
 Depending on the time elapsed since the last fetch from the Firebase Remote Config backend, configs are either served from local storage, or fetched from the backend. The default minimum fetch interval can be set while initializing the library; the static default is 12 hours.  
 Note: Also initializes the Firebase installations SDK that creates installation IDs to identify Firebase installations and periodically sends data to Firebase servers. Remote Config requires installation IDs for Fetch requests. To stop the periodic sync, call delete(). Sending a Fetch request after deletion will create a new installation ID for this Firebase installation and resume the periodic sync.  
 minimumFetchIntervalInSeconds: If configs in the local storage were fetched more than this many seconds ago, configs are served from the backend instead of local storage.*- **FetchAndActivate**
*Asynchronously fetches and then activates the fetched configs.  
 On success Eventname\_FetchedAndActivated event will be raised.  
 If the time elapsed since the last fetch from the Firebase Remote Config backend is more than the default minimum fetch interval, configs are fetched from the backend.  
 After the fetch is complete, the configs are activated so that the fetched key value pairs take effect.  
 Task with a true result if the current call activated the fetched configs; if no configs were fetched from the backend and the local fetched configs have already been activated, returns a Task with a false result.*- **GetAll** As Map
*Returns a Map of Firebase Remote Config key value pairs.  
 Evaluates the values of the parameters in the following order:  
 1. The activated value, if the last successful activate() contained the key.  
 2. The default value, if the key was set with setDefaultsAsync.*- **GetBoolean** (key As String) As Boolean
*Returns the parameter value for the given key as a boolean.  
 Evaluates the value of the parameter in the following order:  
 1. The activated value, if the last successful activate() contained the key, and the value can be converted into a boolean.  
 2. The default value, if the key was set with setDefaultsAsync, and the value can be converted into a boolean.  
 3. DEFAULT\_VALUE\_FOR\_BOOLEAN.  
 "1", "true", "t", "yes", "y", and "on" are strings that are interpreted (case insensitive) as true, and "0", "false", "f", "no", "n", "off", and empty string are interpreted (case insensitive) as false.  
 key: A Firebase Remote Config parameter key with a boolean parameter value.*- **GetDouble** (key As String) As Double
*Returns the parameter value for the given key as a double.  
 Evaluates the value of the parameter in the following order:  
 1. The activated value, if the last successful activate() contained the key, and the value can be converted into a double.  
 2. The default value, if the key was set with setDefaultsAsync, and the value can be converted into a double.  
 3. DEFAULT\_VALUE\_FOR\_DOUBLE.  
 key: A Firebase Remote Config parameter key with a double parameter value.*- **GetKeysByPrefix** (prefix As String) As List
*Returns a list of all Firebase Remote Config parameter keys with the given prefix.  
 prefix: The key prefix to look for. If the prefix is empty, all keys are returned.*- **GetLong** (key As String) As Long
*Returns the parameter value for the given key as a long.  
 Evaluates the value of the parameter in the following order:  
 1. The activated value, if the last successful activate() contained the key, and the value can be converted into a long.  
 2. The default value, if the key was set with setDefaultsAsync, and the value can be converted into a long.  
 3. DEFAULT\_VALUE\_FOR\_LONG.  
 key: A Firebase Remote Config parameter key with a long parameter value.*- **GetString** (key As String) As String
*Returns the parameter value for the given key as a String.  
 Evaluates the value of the parameter in the following order:  
 1. The activated value, if the last successful activate() contained the key.  
 2. The default value, if the key was set with setDefaultsAsync.  
 3. DEFAULT\_VALUE\_FOR\_STRING.  
 key: A Firebase Remote Config parameter key.*- **GetValue** (key As String) As FirebaseRemoteConfigValue
*Returns the parameter value for the given key as a FirebaseRemoteConfigValue.  
 Evaluates the value of the parameter in the following order:  
 1. The activated value, if the last successful activate() contained the key.  
 2. The default value, if the key was set with setDefaultsAsync.  
 3. A FirebaseRemoteConfigValue that returns the static value for each type.  
 key: A Firebase Remote Config parameter key.*- **Initialize** (eventName As String, MinimumFetchInterval As Long, FetchTimeout As Long)
*Initialize the object. On success Eventname\_Initialize event will be raised.  
 eventName: The event name prefix.  
 MinimumFetchInterval: Sets the minimum interval between successive fetch calls.  
 FetchTimeout: Sets the connection and read timeouts for fetch requests to the Firebase Remote Config servers in seconds.*- **Reset**
*Deletes all activated, fetched and defaults configs and resets all Firebase Remote Config settings.  
 On success Eventname\_ResetComplete event will be raised.*- **SetDefaults** (defaults As Map)
*Asynchronously sets default configs using the given Map.  
 The values in defaults must be one of the following types: byte[], Boolean, Double, Long, String  
 On success Eventname\_DefaultsAdded event will be raised.  
 defaults: Map of key value pairs representing Firebase Remote Config parameter keys and values.*
- **Properties:**

- **Info** As FirebaseRemoteConfigInfo [read only]
*Returns the state of this FirebaseRemoteConfig instance as a FirebaseRemoteConfigInfo.*
- **FirebaseRemoteConfigInfo**

- **Functions:**

- **GetFetchTimeMillis** As Long
*Gets the timestamp (milliseconds since epoch) of the last successful fetch, regardless of whether the fetch was activated or not.*- **GetFetchTimeoutInSeconds** As Long
*Returns the fetch timeout in seconds.*- **GetLastFetchStatus** As Int
*Gets the status of the most recent fetch attempt.*- **GetMinimumFetchIntervalInSeconds** As Long
*Returns the minimum interval between successive fetches calls in seconds.*
- **FirebaseRemoteConfigValue**

- **Functions:**

- **AsBoolean** As Boolean
- **AsByteArray** As Byte()
- **AsDouble** As Double
- **AsLong** As Long
- **AsString** As String
- **GetSource** As Int
*Indicates at which source this value came from.  
 One of VALUE\_SOURCE constant*
  
**Installation:**  

1. Download the latest Android SDK as per [B4A Installation instructions](https://www.b4x.com/b4a.html)
2. Install "**firebase-abt**" \*ONLY\* from SDK manager. Then close B4A.
3. Extract the attached ABT.zip to **<sdk>\extras\b4a\_remote\com\google\firebase\firebase-abt\** folder
4. Check if there is one **20.0.0** folder no nested **20.0.0** folder
5. Then open this file, **<sdk>\extras\b4a\_remote\installed-components.txt**
6. Find **com.google.firebase\:firebase-abt=** and change the version to **20.0.0**
7. Download the attached wrapper ZIP file.
8. Remove any old Firebase RemoteConfig wrapper if you already have one.
9. Copy the files to the B4A **Additional library** folder.

**Usage:** Check the attached example project.