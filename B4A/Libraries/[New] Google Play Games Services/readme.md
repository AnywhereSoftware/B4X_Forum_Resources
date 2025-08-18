### [New] Google Play Games Services by Biswajit
### 11/29/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/128464/)

Hi everyone,  
  
This is a complete wrapper of the latest Google Play Games Services (v17.2.1). I made this for [USER=10835]@Jack Cole[/USER] and he allowed me to post it on the forum to help other users.  
  
Though the functionalities are almost the same but the implementation is a little different than the [old wrapper](https://www.b4x.com/android/forum/threads/google-play-game-services.45245/) made by [USER=22203]@Informatix[/USER] . There are many methods that have been removed from the new version of GPGS libraries. For more details check this [reference](https://developers.google.com/android/reference/com/google/android/gms/games/package-summary).  
  
**Important:** The main difference is you cannot store the list of the achievements, events, leaderboards, scores, players and snapshots retrieved from their respective clients. When you want the list you have to call the load method to populate the buffer and **after using the data you must have to release the buffer** else you will get errors while accessing different classes. For example, if you fetch the achievement list and forgot to release the buffer and after that if you fetch the leaderboard list you will get an error.  
  
The wrapper contains almost all (99%) the functionalities and methods that the new GPGS SDK has. Though not all the functionalities are tested. If you encounter any issue please post the complete log.  
  
As the wapper has a huge number of functionalities it's not possible to publish the entire library reference here. I have attached an HTML file in the zip file for reference.  
  
**Classes:**  

- GPGSAbstractDataBuffer
- GPGSAchievement
- GPGSAchievementsClient
- GPGSEvent
- GPGSEventsClient
- GPGSGame
- GPGSGames
- GPGSGamesClient
- GPGSGamesMetadataClient
- GPGSLeaderboard
- GPGSLeaderboardScore
- GPGSLeaderboardVariant
- GPGSLeaderboardsClient
- GPGSNearbyConnections
- GPGSNetworkInfo
- GPGSPlayGamesService
- GPGSPlayer
- GPGSPlayerLevel
- GPGSPlayerLevelInfo
- GPGSPlayerStats
- GPGSPlayerStatsClient
- GPGSPlayersClient
- GPGSScoreSubmissionData
- GPGSScoreSubmissionDataResult
- GPGSSnapshot
- GPGSSnapshotContents
- GPGSSnapshotMetadata
- GPGSSnapshotMetadataChange
- GPGSSnapshotsClient
- GPGSUserAccount
- GPGSVideoCapabilities
- GPGSVideoCaptureState
- GPGSVideosClient

  
**Installation:**  

1. Download latest IDE and Android SDK (Skip if already using the latest ones)
2. Copy the attached jar and xml file to the additional libs folder.
3. Open B4A SDK Manager and wait for the list to load.
4. Deselect all.
5. Only install these following libraries (**installing other libraries may cause compilation error, do it at your own risk**),

1. firebase-abt
2. play-services-games
3. play-services-location
4. play-services-tasks

6. Now close the SDK Manager
7. If you are going to integrate this to an existing project then remember to clean the project.
IDE > Tools > Clean project.
  
**Setup GPGS:** Check this [documentation](https://developers.google.com/games/services/android/quickstart) to set up and configure the GPGS.  
  
**Manifest Code:**  

```B4X
'GAMES SERVICES  
AddApplicationText(  
<meta-data android:name="com.google.android.gms.games.APP_ID" android:value="@string/app_id" />  
<meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version" />  
<activity android:name="com.google.android.gms.auth.api.signin.internal.SignInHubActivity" android:windowSoftInputMode="stateHidden|adjustPan"/>  
)  
'The xml file content generated from play console  
CreateResource(values, game-ids.xml,  <?xml version="1.0" encoding="utf-8"?>  
<resources>  
  <string name="app_id" translatable="false">******</string>  
  ….  
</resources>  
)
```

  
**Usage:**  

```B4X
Sub Class_Globals  
    Public GPlayGamesService As GPGSPlayGamesService 'This is the main entry point  
    Public GGames As GPGSGames 'will be auto initialized on successful signin  
  
    Public gc As GPGSGamesClient  
    Public lbc As GPGSLeaderboardsClient  
    Public pc As GPGSPlayersClient  
    Public ac As GPGSAchievementsClient  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    …  
    GPlayGamesService.Initialize("GPGS") 'this eventname prefix will be used for all the classes for this library.  
    GPlayGamesService.SilentSignIn("",False)  
End Sub  
  
Sub GPGS_Connected  
    Log($"GPGS_Connected"$)  
    'After login get all the clients required from GPGSGames  
    gc = GGames.GetGamesClient  
    lbc = GGames.GetLeaderboardsClient  
    pc = GGames.GetPlayersClient  
    ac = GGames.GetAchievementsClient  
End Sub  
  
Sub GPGS_OnGPGSActivityResult(RequestCode As String, ResultCode As Int, ResultIntent As Intent)   
    If ResultCode = GPlayGamesService.RESULT_RECONNECT_REQUIRED Then  
        'signed out from popup activity  
        'internally it will clear the user login session so you dont have to call SignOut again.  
        'you can signin again or do any other activity related to signout event  
    End If  
End Sub  
  
Sub GPGS_SignInFailed(code As Int, status As String)  
    Log($"GPGS_SignInFailed(code=${code}, status=${status})"$)  
End Sub
```

  
  

```B4X
Private Sub Button_UnlockAchievement_Click  
    ac.Load(False)  
    Wait For GPGS_AchievementsLoaded(count As Int, statusCode As Int)  
    'check if the process was successful or not  
    If statusCode  = GPlayGamesService.RESULT_SUCCESS Then  
        'the buffer will be accessible from ac.GetAchievementsBuffer  
        Dim achd As GPGSAchievement = ac.GetAchievementFromBuffer(0)  
        If achd.GetState = achd.STATE_HIDDEN Then  
            ac.RevealImmediate(achd.GetAchievementId)  
            ac.UnlockImmediate(achd.GetAchievementId)  
        End If  
        If achd.GetState = achd.TYPE_INCREMENTAL And achd.GetCurrentSteps<achd.GetTotalSteps Then  
            ac.SetStepsImmediate(achd.GetAchievementId, achd.GetCurrentSteps+1)  
        End If  
  
        'Important: if you are done with the buffer then release it  
        ac.GetAchievementsBuffer.Release '<- Important  
    Else  
        Log(GPlayGamesService.GetStatusCodeString(statusCode))  
    End If  
End Sub
```

  
  
  
**Update 1.01:** Fixed an issue related to the sign-out event triggered from popup activities (Achievements/Leaderboard) You can check the resultCode received from OnGPGSActivityResult event. If the resultCode = RESULT\_RECONNECT\_REQUIRED, then it means the user clicked on the sign-out button from the popup activities. Check the example code.  
  
**Update 1.02:** Added StatusCode to almost all the events to check whether the task was successful or not. Check the attached HTML file for event signature changes.  
  
**Update 1.03:**   

1. Added **IsSignedIn** method to check if the user is signed in or not.
2. Added **GetLastSignedInAccount** method that will return a **GPGSUserAccount** object or null if not signed in.

**Update 1.04:**   

1. Fixed **IsSignedIn** and **GetLastSignedInAccount** method where those were returning null when using SnapshotAPI.
2. Fixed crashing issue while creating a snapshot with existing snapshot name. Update your project's **SnapshotConflictOccurred** event signature. It has been changed.

**Update 1.05:** Fixed unused permission issue when using **GPGSGamesClient**.