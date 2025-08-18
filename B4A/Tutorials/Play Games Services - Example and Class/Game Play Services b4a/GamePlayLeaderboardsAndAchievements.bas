B4A=true
Group=Default Group\Classes
ModulesStructureVersion=1
Type=Class
Version=10.66
@EndOfDesignText@
#Event: Connected 
#Event: Disconnected
#Event: LeaderboardScoreSubmitted(NewBest As Boolean, Score As String)
#Event: AchievementIncremented(Achievement As AchievementIncrementalType, NumSteps As Int)
#Event: AchievementUnlockedOrRevealed(AchievementId As String, statusCode As Int)

Sub Class_Globals
	Type AchievementIncrementalType (AchievementId As String, CurrentSteps As Int, AchievementDescription As String, FormattedCurrentSteps As String, FormattedTotalSteps As String, LastUpdatedTimestamp As Long, AchievementName As String, Player As GPGSPlayer, RevealedImageUri As String, RevealedBitmap As Bitmap, State As Int, TotalSteps As Int, TypeOfAchievement As Int, UnlockedImageUri As String, UnlockedBitmap As Bitmap, XpValue As Long)
	
	
	Public GPlayGamesService As GPGSPlayGamesService 'This is the main entry point
	
	Public GGames As GPGSGames 'will be auto initialized on successful signin
	
	Public gc As GPGSGamesClient
	Public lbc As GPGSLeaderboardsClient
	Public pc As GPGSPlayersClient
	Public ac As GPGSAchievementsClient
	
	Dim arrAchievement() As GPGSAchievement
	Dim arrLeaderboards() As GPGSLeaderboard
	
	Public LeaderBoardMapB4X As Map_B4X
	Public AchievementsMapB4X As Map_B4X
	Public AchievementsStandardTypeMapB4X As Map_B4X
	Public AchievementsIncrementalTypeMapB4X As Map_B4X
	Private EventPrefix As String
	Public SignedIn As Boolean
	Private LoadLoaderboardsOnConnect, LoadAchievementsOnConnect, UsingSnapshotAPI As Boolean
	Private ParentModule As Object
	Private xui As XUI

	Private Toast As BCToast
	'prevent this from going into a loop with the SignInFailed event
	Private AutoSignInAttemptCount As Int
	Private KVS As KeyValueStore
	'used with StartActivityForResult
	Private ion As Object
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallingModule As Object, Event As String, SilentSignIn As Boolean, UseSnapshotAPI As Boolean, LoadLeaderboardsOnInit As Boolean, LoadAchievementsOnInit As Boolean)
	'set globals from parameters
	EventPrefix=Event
	LoadLoaderboardsOnConnect=LoadLeaderboardsOnInit
	LoadAchievementsOnConnect=LoadAchievementsOnInit
	ParentModule=CallingModule
	UsingSnapshotAPI=UseSnapshotAPI
	
	AchievementsMapB4X.Initialize
	AchievementsStandardTypeMapB4X.Initialize
	AchievementsIncrementalTypeMapB4X.Initialize
	LeaderBoardMapB4X.Initialize

	'init and sign in to game play services
	GPlayGamesService.Initialize("GPGS") 'this eventname prefix will be used for all the classes for this library.
	KVS.Initialize(File.DirInternal, "settings")
	SilentSignIn=KVS.GetDefault("SilentSignIn", True)
	
	If SilentSignIn Then 
		AutoSignInAttemptCount=1
		GPlayGamesService.SilentSignIn("", UsingSnapshotAPI)
	End If
End Sub

#Region Methods
Sub LoadLeaderBoards As ResumableSub
	'load all the leaderboard data
	lbc.LoadLeaderboardMetadata(True)
	Wait For GPGS_AllLeaderboardMetadataLoaded(count As Int, statusCode As Int)
	'below is just for debugging information purposes
	Dim arrLeaderboards(count) As GPGSLeaderboard
	For i=0 To count-1
		arrLeaderboards(i)=lbc.GetLeaderboardFromBuffer(i)
		Dim lbdata As GPGSLeaderboard = arrLeaderboards(i)
'		Dim lbdata As GPGSLeaderboard = lbc.GetLeaderboardFromBuffer(i)
'		LogColor($"lbdata.GetDisplayName=${lbdata.GetDisplayName}, lbdata.GetLeaderboardId=${lbdata.GetLeaderboardId}"$, Colors.red)
		LeaderBoardMapB4X.Put(lbdata.GetLeaderboardId, lbdata.GetDisplayName)
		
	Next
	lbc.GetLeaderboardsBuffer.Release '<- Important
	Return
End Sub

Sub LoadAchievements As ResumableSub
	'load achievement data
	ac.Load(True)
	Wait For GPGS_AchievementsLoaded(count As Int, statusCode As Int)
	'below is just for debugging information purposes
	Dim arrAchievement(count) As GPGSAchievement	
	For i=0 To count-1
		arrAchievement(i) = ac.GetAchievementFromBuffer(i)
		Dim ach As GPGSAchievement = arrAchievement(i)
'		Dim ach As GPGSAchievement = ac.GetAchievementFromBuffer(i)
		If ach.GetType = ach.TYPE_INCREMENTAL Then
'			LogColor($"ach.GetAchievementId=${ach.GetAchievementId}, ach.GetDescription=${ach.GetDescription}, ach.GetCurrentSteps=${ach.GetCurrentSteps}, ach.GetFormattedTotalSteps=${ach.GetFormattedTotalSteps}"$, Colors.Green)
		
			wait for (GetIncrementalAchievementData(ach)) complete (achdata As AchievementIncrementalType)
			AchievementsIncrementalTypeMapB4X.Put(ach.GetAchievementId, achdata)
		Else
			LogColor($"ach.GetAchievementId=${ach.GetAchievementId}, ach.GetDescription=${ach.GetDescription}"$, Colors.Yellow)
			AchievementsStandardTypeMapB4X.Put(ach.GetAchievementId, ach.GetName)
		End If
		
'		AchievementsList.Add(ach.GetAchievementId)
	Next
	'Important: if you are done with the buffer then release it
'	ac.GetAchievementsBuffer.Release '<- Important
	Return
End Sub

Sub GetIncrementalAchievementData(ach As GPGSAchievement) As ResumableSub
	Dim RetAch As AchievementIncrementalType
	RetAch.Initialize
	RetAch.AchievementId = ach.GetAchievementId
	RetAch.CurrentSteps = ach.GetCurrentSteps
	RetAch.AchievementDescription = ach.GetDescription
	RetAch.FormattedCurrentSteps = ach.GetFormattedCurrentSteps
	RetAch.FormattedTotalSteps = ach.GetFormattedTotalSteps
	RetAch.LastUpdatedTimestamp = ach.GetLastUpdatedTimestamp
	RetAch.AchievementName = ach.GetName
	RetAch.Player = ach.GetPlayer
	RetAch.RevealedImageUri = ach.GetRevealedImageUri
	RetAch.State = ach.GetState
	RetAch.TotalSteps = ach.GetTotalSteps
	RetAch.TypeOfAchievement = ach.GetType
	RetAch.UnlockedImageUri = ach.GetUnlockedImageUri
	RetAch.XpValue = ach.GetXpValue

'	Wait For (wwwHelper.DownloadImage(RetAch.RevealedImageUri)) Complete (RevealedBitmap As Bitmap)
'	Log("got revealed bitmap")
'	RetAch.RevealedBitmap=RevealedBitmap
'	
'	Wait For (wwwHelper.DownloadImage(RetAch.UnlockedImageUri)) Complete (UnlockedBitmap As Bitmap)
'	Log("got unlocked bitmap")
'	RetAch.UnlockedBitmap=UnlockedBitmap
	Return RetAch
End Sub

Sub ShowAllLeaderboards
	lbc.GetAllLeaderboardsIntent
End Sub

Sub ShowLeaderboardByTitle(LeaderBoardTitle As String)
	lbc.GetLeaderboardIntent(LeaderBoardMapB4X.GetByValue(LeaderBoardTitle))
End Sub

Sub GPGS_ReceivedLeaderboardsIntent(intent As Intent, statusCode As Int)
	Log("GPGS_ReceivedLeaderboardsIntent StatusCode="&statusCode)
'	CallSubDelayed2(Main, "StartActivityForResult", intent)
	StartActivityForResult(intent)
End Sub

Sub ion_Event (MethodName As String, Args() As Object) As Object
	If -1 = Args(0) Then 'resultCode = RESULT_OK
		Dim i As Intent = Args(1)
		Dim jo As JavaObject = i
		Dim uri As String = jo.RunMethod("getParcelableExtra", _
       Array As Object("android.intent.extra.ringtone.PICKED_URI"))
		Log(uri)
	End If
	Return Null
End Sub

Sub StartActivityForResult(i As Intent)
	Dim jo As JavaObject = GetBA
	ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)
	jo.RunMethod("startActivityForResult", Array As Object(ion, i))
End Sub

Sub GetBA As Object
	Dim jo As JavaObject = Me
	Return jo.RunMethod("getBA", Null)
End Sub


'
'Sub StartActivityForResult(i As Intent)
'	Dim jo As JavaObject = GetBA
'	'Application.PackageName&".IOnActivityResult"
'	Main.ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)
'	jo.RunMethod("startActivityForResult", Array As Object(Main.ion, i))
'End Sub
'
'Sub GetBA As Object
'	Dim jo As JavaObject
'	Dim cls As String = Me
'	Dim cls As String = Application.PackageName & ".main"
'	LogColor("cls = "&cls, Colors.Magenta)
''	Log("Me = "&Me)
''	cls = cls.SubString("class ".Length)
'	jo.InitializeStatic(cls)
'	Return jo.GetField("processBA")
'End Sub


Sub ShowAllAchievements
	Log("ShowAllAchievements")
	ac.GetAchievementsIntent
'	Wait For (GPGS_ReceivedAchievementsIntent) Complete (intent As Intent)
'	Log("Received--should try to show")
'	GGames.StartActivityForResult(intent, "acintent")
End Sub

Sub SignIn(UseSnapshotApi As Boolean)
	GPlayGamesService.ManualSignIn("", UseSnapshotApi)
End Sub

Sub SignOut
	GPlayGamesService.SignOut
End Sub

Sub UnlockAllAchievementsAndIncrement
	LogColor($"Button_UnlockAchievement_Click"$, Colors.Magenta)
	ac.Load(False)
	Wait For GPGS_AchievementsLoaded(count As Int, statusCode As Int)
	LogColor($"GPGS_AchievementsLoaded in Button_UnlockAchievement_Click count=${count}, statusCode=${statusCode}"$, Colors.Magenta)
	
	'	Log(achd.GetCurrentSteps)
	'	Log(achd.GetTotalSteps)
	'	LogColor($"achd.GetState = achd.STATE_HIDDEN ${(achd.GetState = achd.STATE_HIDDEN)}, achd.GetState = achd.TYPE_INCREMENTAL ${(achd.GetState = achd.TYPE_INCREMENTAL)}, achd.GetCurrentSteps=${achd.GetCurrentSteps}, achd.GetTotalSteps=${achd.GetTotalSteps}"$, Colors.Yellow)
	
	For x = 0 To count-1
		Dim achd As GPGSAchievement = ac.GetAchievementFromBuffer(x)
		Log("STATE="&achd.GetState)
		Log(achd.STATE_HIDDEN)
		Log(achd.STATE_REVEALED)
		Log(achd.STATE_UNLOCKED)
		Log("TYPE="&achd.GetType)
		Log(achd.TYPE_STANDARD)
		Log(achd.TYPE_INCREMENTAL)
		
		Select achd.GetType
			Case achd.TYPE_STANDARD
				ac.RevealImmediate(achd.GetAchievementId)
				ac.UnlockImmediate(achd.GetAchievementId)
			Case achd.TYPE_INCREMENTAL
				Log($"achd.GetName=${achd.GetName}, achd.GetCurrentSteps=${achd.GetCurrentSteps}, achd.GetTotalSteps=${achd.GetTotalSteps}"$)
				If achd.GetCurrentSteps<achd.GetTotalSteps-1 Then
					LogColor("Setting steps to "&(achd.GetCurrentSteps+1), Colors.Yellow)
					ac.SetStepsImmediate(achd.GetAchievementId, achd.GetCurrentSteps+1)
				End If
		End Select
	
	Next
	
	ac.GetAchievementsBuffer.Release
End Sub

Sub Leaderboard_Send_Score(CallBackModule As Object, LeaderboardId As String, Score As Int)
	lbc.SubmitScoreImmediate(LeaderboardId, Score)
	Wait For GPGS_ScoreSubmitted(submissionData As GPGSScoreSubmissionData, statusCode As Int)
	Log("After submitted event triggered.")
	LogColor($"submissiondata.GetLeaderboardId=${submissionData.GetLeaderboardId}, submissiondata.GetScoreResult=${submissionData.GetScoreResult(submissionData.TIME_SPAN_DAILY).FormattedScore}, StatusCode=${statusCode}, submissionData.GetScoreResult(submissionData.TIME_SPAN_ALL_TIME).ToString=${submissionData.GetScoreResult(submissionData.TIME_SPAN_ALL_TIME).ToString}"$, Colors.red)
	Log("Callback exists? "&SubExists(CallBackModule, $"${EventPrefix}_LeaderboardScoreSubmitted"$))
	CallSubDelayed3(CallBackModule, $"${EventPrefix}_LeaderboardScoreSubmitted"$, submissionData.GetScoreResult(submissionData.TIME_SPAN_ALL_TIME).NewBest, Score)
End Sub

Sub Leaderboard_Send_Score_ByTitle(CallBackModule As Object, LeaderboardTitle As String, Score As Int)
	Leaderboard_Send_Score(CallBackModule, LeaderBoardMapB4X.GetByValue(LeaderboardTitle), Score)
End Sub

Sub Achievement_Increment(CallbackModule As Object, Achievement As AchievementIncrementalType, NumSteps As Int)
	Log("--->Achievement_Increment")
	ac.IncrementImmediate(Achievement.AchievementId, NumSteps)
	Wait For GPGS_AchievementIncrementCompleted(AchievementId As String, unlocked As Boolean, statusCode As Int)
	LogColor($"AchievementId=${AchievementId}, Name=${AchievementsIncrementalTypeMapB4X.Get(AchievementId)}, unlocked=${unlocked}, statusCode=${statusCode}"$, Colors.Green)
	Log(Achievement.UnlockedImageUri)
	CallSubDelayed3(CallbackModule, $"${EventPrefix}_AchievementIncremented"$, Achievement, NumSteps)
	
	
'	If ShowAchievement Then
		'[img url="${GetPathFromContentResult(Achievement.UnlockedImageUri)}" width=50 height=60/]

'		Dim Intent1 As Intent
'		Intent1.Initialize(Intent1.ACTION_MAIN, Achievement.RevealedBitmap)
'		StartActivity(Intent1)

'		Dim bmp As Bitmap = LoadBitmap("ContentDir", Achievement.UnlockedImageUri)
'		Dim Intent1 As Intent
'		Intent1.Initialize(Intent1.ACTION_MAIN, Achievement.UnlockedImageUri)
'		StartActivity(Intent1)
'	End If
	
End Sub

'this one might need work
Sub Achievement_UnlockAndReveal(CallbackModule As Object, AchievementId As String)
	ac.UnlockImmediate(AchievementId)
	ac.RevealImmediate(AchievementId)
	Wait For GPGS_AchievementUnlocked(AchievementId As String, statusCode As Int)
	LogColor($"AchievementId=${AchievementId}, Name=${AchievementsIncrementalTypeMapB4X.Get(AchievementId)}, statusCode=${statusCode}"$, Colors.Green)
	CallSubDelayed3(CallbackModule, $"${EventPrefix}_AchievementUnlockedOrRevealed"$, AchievementId, statusCode)
End Sub

#End Region

#Region Misc
'Sub GetPathFromContentResult(UriString As String) As String
'	If UriString.StartsWith("/") Then Return UriString 'If the user used a file manager to choose the image
'	Dim Cursor1 As Cursor
'	Dim Uri1 As Uri
'	Dim Proj() As String = Array As String("_data")
'	Dim cr As ContentResolver
'	cr.Initialize("")
'	If UriString.StartsWith("content://com.android.providers.media.documents") Then
'		Dim i As Int = UriString.IndexOf("%3A")
'		Dim id As String = UriString.SubString(i + 3)
'		Uri1.Parse("content://media/external/images/media")
'		Cursor1 = cr.Query(Uri1, Proj, "_id = ?", Array As String(id), "")
'	Else
'		Uri1.Parse(UriString)
'		Cursor1 = cr.Query(Uri1, Proj, "", Null, "")
'	End If
'	Cursor1.Position = 0
'	Dim res As String
'	res = Cursor1.GetString("_data")
'	Cursor1.Close
'	Return res
'End Sub

Sub IfGreaterThan_MakeEqual(Value As Long, UpperBound As Long) As Long
	If Value>UpperBound Then
		Return UpperBound
	Else
		Return Value
	End If
End Sub

Sub IfLessThan_MakeEqual(Value As Long, LowerBound As Long) As Long
	If Value<LowerBound Then
		Return LowerBound
	Else
		Return Value
	End If
End Sub

#end region


#Region Play Game Services Events


Sub GPGS_ReceivedAchievementsIntent(intent As Intent, statusCode As Int)
	Log("Received--should try to show")
	
	GGames.StartActivityForResult(intent, "acintent")
End Sub


Sub GPGS_AppIdReceived(appId As String, statusCode As Int)
	Log($"GPGS_AppIdReceived(id=${appId})"$)
End Sub

Sub GPGS_AccountNameReceived(name As String, statusCode As Int)
	Log($"GPGS_AccountNameReceived(name=${name})"$)
End Sub

Sub GPGS_Connected
	Log($"GPGS_Connected"$)
	KVS.Put("SilentSignIn", True)
	SignedIn=True
	'After login get all the clients required from GPGSGames
	gc = GGames.GetGamesClient
	lbc = GGames.GetLeaderboardsClient
	pc = GGames.GetPlayersClient
	ac = GGames.GetAchievementsClient
	
	gc.GetAppId 'example: get the app id from gamesclient
	
	If LoadLoaderboardsOnConnect Then
		Wait For (LoadLeaderBoards) complete ()
	End If
	If LoadAchievementsOnConnect Then 
		Wait For (LoadAchievements) complete ()
	End If
	Log($"Event exists? ${EventPrefix}_Connected=${xui.SubExists(ParentModule, $"${EventPrefix}_Connected"$, 0)}"$)
	CallSubDelayed(ParentModule, $"${EventPrefix}_Connected"$)
End Sub

Sub GPGS_OnGPGSActivityResult(RequestCode As String, ResultCode As Int, ResultIntent As Intent)
'	If RequestCode = "lbintent" Then
'		MsgboxAsync("Leaderboard closed","")
'	End If
End Sub


Sub GPGS_ReceivedAllLeaderboardsIntent(intent As Intent, statusCode As Int)
	GGames.StartActivityForResult(intent,"lbintent")
End Sub

Sub GPGS_ResolutionResult(result As String)
	Log($"GPGS_ResolutionResult(result=${result})"$)
End Sub

Sub GPGS_ServiceUnavailable(userResolveable As Boolean)
	Log($"GPGS_ServiceUnavailable(userResolveable=${userResolveable})"$)
End Sub

Sub GPGS_SignInFailed(code As Int, status As String)
	Log($"GPGS_SignInFailed(code=${code}, status=${status}, AutoSignInAttemptCount=${AutoSignInAttemptCount})"$)
	AutoSignInAttemptCount=AutoSignInAttemptCount+1
	If GPlayGamesService.HasResolution Then 
		Log("trying to resolve issue")
		If AutoSignInAttemptCount<3 Then GPlayGamesService.StartResolutionForResult
	Else
		Log("GPGS_SignInFailed - No automatic resolution")
		KVS.Put("SilentSignIn", False)
'		If AutoSignInAttemptCount<3 Then SignIn(UsingSnapshotAPI)
	End If
End Sub

Sub GPGS_SignOutComplete
	Log($"GPGS_SignOutComplete"$)
	SignedIn=False
	If SubExists(ParentModule, EventPrefix & "_Disconnected") Then CallSubDelayed(ParentModule, EventPrefix & "_Disconnected")
End Sub

'Sub GPGS_ScoreSubmitted(submissionData As GPGSScoreSubmissionData, statusCode As Int)
'	LogColor($"submissiondata.GetLeaderboardId=${submissionData.GetLeaderboardId}, submissiondata.GetScoreResult=${submissionData.GetScoreResult(submissionData.TIME_SPAN_DAILY).FormattedScore}, StatusCode=${statusCode}, submissionData.GetScoreResult(submissionData.TIME_SPAN_ALL_TIME).ToString=${submissionData.GetScoreResult(submissionData.TIME_SPAN_ALL_TIME).ToString}"$, Colors.red)
'	
'	If submissionData.GetScoreResult(submissionData.TIME_SPAN_ALL_TIME).NewBest Then
'		ToastMessageShow("New high score for you!  Your score is "&submissionData.GetScoreResult(submissionData.TIME_SPAN_ALL_TIME).FormattedScore, True)
'	Else
'		ToastMessageShow($"Your score was submitted to the leaderboard.  Score = ${submissionData.GetScoreResult(submissionData.TIME_SPAN_DAILY).FormattedScore}"$, True)
'	End If
'End Sub


Sub GPGS_AchievementRevealed(achievementId As String, statusCode As Int)
	Log($"achievement revealed. ID:${achievementId}"$)
End Sub

Sub GPGS_AchievementStepsChanged(achievementId As String, changed As Boolean, statusCode As Int)
	Log($"achievement step changed. ID:${achievementId}", changed:${changed}"$)
End Sub
#End Region
