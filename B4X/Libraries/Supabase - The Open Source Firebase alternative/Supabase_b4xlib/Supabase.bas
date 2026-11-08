B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-BugFixes
	-Add InitializeEvents
	-Add Event AuthStateChange
		-StateType
			-passwordRecovery, signedIn, signedOut, tokenRefreshed, userUpdated
V1.02
	-General
		-BugFixes
	-Auth
		-Add SignInWithOAuth - Signs the user in using third party OAuth providers
			-Adds Google
		-Add Enum Provider_Google
			-so you always know which providers are already implemented
			-xSupabase.Auth.Provider_Google
V1.03
	-General
		-BugFixes
	-Auth
		-Add SignInWithOAuth with the Apple Provider
		-Add xSupabase.Auth.Provider_Apple - B4I only
V1.04
	-General
		-BugFixes
	-Auth
		-Add isUserLoggedIn - Checks if the user is logged in, renews the access token if it has expired
V1.05
	-Storage
		-CRUD operations with buckets can now be performed
		-CRUD operations with files can now be performed
V1.06
	-Storage
		-BugFixes
		-Add DownloadFileProgress - Download large files with a progress indicator
			-DownloadFileProgress uses http range feature to download the file in chunks. It will resume the download from the previous point, even if the app was previously killed.
			-It first sends a HEAD request to test whether this feature is supported.
			-Note that you need to delete the target file if you want to restart the download.
V1.07
	-Storage
		-Add DownloadOptions_Transform...
			-height, width, resize,format,quality
V1.08
	-BugFixes
V1.09
	-Add SupabaseRealtime
		-You can now subscribe to topics and get database changes in real time
V1.10
	-Database
		-RLS and Auth error message removed when no rows are present
		-Removed unnecessary log messages
	-Realtime
		-Add get isConnected - Returns true if the websocket is connected to the database
		-Removed unnecessary log messages
		-BugFixes
V1.11
	-Auth
		-Add the "Options" parameter to the SignUp function
			-sign up with additional user metadata
		-Add "Metadata" to SupabaseUser
		-BugFixes
	-Database
		-Select - Joins are now supportet
V1.12
	-Realtime
		-Complete workflow redesigned to be closer to the official libraries
		-Add Filters
			-Filter_Equal,Filter_NotEqual,Filter_GreatherThan,Filter_GreatherThanOrEqual,Filter_LessThan,Filter_LessThanOrEqual,Filter_In
		-Add SubscribeType - Broadcast
			-Send ephemeral messages from client to clients with low latency.
		-Add SubscribeType - Presence
			-Track and synchronize shared state between clients.
		-Add SubscribeType - PostgresChanges
			-Listen to Postgres database changes and send them to authorized clients.
V1.13
	-General
		-Add get and set LogEvents - If true then you get debugging infos in the log
		-Add Some infos to log messages
	-Auth
		-BugFix
	-Database
		-Add OrderBy
		-Add Limit
		-Add Offset
V1.14
	-Compatibility for server applications
V1.15
	-Realtime
		-Add support for Presence and Broadcast
			-Presence: Share state between users with Realtime Presence.
			-Broadcast: Send and receive messages using Realtime Broadcast
		-Add new enums
			-get Event_Sync - Presence only
			-get Event_Join - Presence only
			-get Event_Leave - Presence only
		-Add support for multi event subscribe
		-Add SendBroadcast
		-Add Event BroadcastDataReceived
		-Add Event PresenceDataReceived
V1,16
	-Auth
		-BugFixes
	-Realtime
		-Add Event Disconnected
V1.17
	-Removes the dependency of the xui library so that the library can also work in server apps (non ui)
V1.18
	-Database
		-Filter Ilike BugFix
V1.19
	-Database
		-Add SelectData to INSERT - Create a record and return it
		-Add SelectData to UPDATE - Update a record and return it
		-BreakingChange on Supabase_DatabaseInsert
			-The return value for execute is no longer of type SupabaseError it is now SupabaseDatabaseResult
		-BreakingChange on Supabase_DatabaseUpdate
			-The return value for execute is no longer of type SupabaseError it is now SupabaseDatabaseResult
V1.20
	-Database
		-Support for json columns
			-the json string of the column must look like this to be recognized: [{"name":"Volleyball","id":1}]
				-Important that it starts with [ and ends with ]
V1.21
	-Auth
		-BugFix - in GetUser, if the retrieval was successful, the data set was still marked as "False" in the error object
V1.22
	-Auth
		-BugFixes on SignUp
		-Add LogIn_Anonymously - Allow your users to sign up without requiring users to enter an email address, password
		-Add isAnonymous to SupabaseUser
		-BugFixes on oAuth
V1.23
	-Database
		-Add rpc support - Call a Postgres function
		-BugFixes
V1.24
	-Database
		-The RPC FunctionName is now automatically set to lowercase
	-Auth
		-BugFixes on LogIn_Anonymously
			-User is now automatically logged out if they are still logged in with a real account
			-A new anonymous account is now not created each time this function is called up, the existing anonymous account is used
V1.25
	-Database
		-BugFix - RPC filters now work
V1.26
	-Supabase_Functions
		-Better Error Handling on the GenerateResult function
V1.27
	-Storage
		-BugFixes
#End IF

#Event: AuthStateChange(StateType As String)
#Event: RangeDownloadTracker(Tracker As SupabaseRangeDownloadTracker)

Sub Class_Globals
	Private m_SUPABASE_URL As String
	Private m_SUPABASE_ANNON_KEY As String
	
	Type SupabaseUser(Id As String,Aud As String,Role As String,Email As String,isAnonymous As Boolean,Phone As String,ConfirmationSentAt As Long,EmailConfirmedAt As Long,ConfirmedAt As Long,LastSignInAt As Long,CreatedAt As Long,UpdatedAt As Long,json As JSON,Error As SupabaseError,Metadata As Map)
	Type SupabaseDatabaseResult(Tag As Object,Columns As Map,Rows As List,Error As SupabaseError)
	Type SupabaseRpcResult(Tag As Object,Data As Object,Error As SupabaseError)
	Type SupabaseStorageResult(Error As SupabaseError)
	Type SupabaseError(Success As Boolean,StatusCode As Int,ErrorMessage As String)
	
	Type SupabaseStorageBucket(Id As String,Name As String,isPublic As Boolean,FileSizeLimit As Int,AllowedMimeTypes As List,Owner As String,CreatedAt As Long,UpdatedAt As Long,Error As SupabaseError)
	Type SupabaseStorageFile(Id As String,Key As String,FileBody() As Byte,PublicUrl As String,SignedURL As String,Error As SupabaseError)
	
	Type SupabaseRealtime_Data(Schema As String,CommitTimestamp As Long,Columns As List,Records As Map,OldRecord As Map,EventType As String,DatabaseError As SupabaseError,Table As String)
	Type SupabaseRealtime_BroadcastData(Event As String,Payload As Map,DatabaseError As SupabaseError)
	Type SupabaseRealtime_PresenceData(Event As String,Joins As Map,Leaves As Map,DatabaseError As SupabaseError)
	
	Private m_Authentication As Supabase_Authentication
	Private m_Database As Supabase_Database
	Private m_Storage As Supabase_Storage
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private m_LogEvents As Boolean = False
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(URL As String,AnonKey As String)
	m_SUPABASE_URL = URL
	m_SUPABASE_ANNON_KEY = AnonKey
	
	m_Authentication.Initialize(Me,"Supabase")
	m_Database.Initialize(Me)
	m_Storage.Initialize(Me)

End Sub

Public Sub InitializeEvents(Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub setLogEvents(Enabled As Boolean)
	m_LogEvents = Enabled
End Sub

Public Sub getLogEvents As Boolean
	Return m_LogEvents
End Sub

Public Sub getURL As String
	Return m_SUPABASE_URL
End Sub

Public Sub getApiKey As String
	Return m_SUPABASE_ANNON_KEY
End Sub

Public Sub getAuth As Supabase_Authentication
	Return m_Authentication
End Sub

Public Sub getDatabase As Supabase_Database
	Return m_Database
End Sub

Public Sub getStorage As Supabase_Storage
	Return m_Storage
End Sub

#Region Events

Private Sub Supabase_AuthStateChange(StateType As String)
	If Supabase_Functions.SubExists2(mCallBack,mEventName & "_AuthStateChange",1) Then
		CallSub2(mCallBack,mEventName & "_AuthStateChange",StateType)
	End If
End Sub

#End Region