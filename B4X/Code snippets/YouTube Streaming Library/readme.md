###  YouTube Streaming Library by Sergio Haurat
### 06/23/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/161762/)

I want to clarify that my language is Spanish, I understand English without problems but I don't speak it fluently and to write this post I am using Google Translate. That explains some grammatical inconsistencies.  
  
I need to integrate streaming capability into an application, similar to [SportCam](https://play.google.com/store/apps/details?id=com.rankedin.video&hl=es_AR), for streaming to YouTube. I already have OAuth2 authentication implemented (developed by [USER=1]@Erel[/USER]) and I have made progress in these methods.  

- CreateLiveStream
- CreateLiveBroadcast
- ListLiveBroadcasts
- BindLiveStreamToBroadcast
- StartLiveBroadcast

The next methods are not complete; they are just a sample.  

```B4X
Public Sub CreateLiveStream(title As String, description As String, scheduledStartTime As String) As ResumableSub  
  Dim streamData As Map  
  streamData.Initialize  
  streamData.Put("snippet", CreateSnippet(title, description, scheduledStartTime))  
  streamData.Put("status", CreateStatus("public"))  
  streamData.Put("cdn", CreateCdn("1080p"))  
  Dim objHJ As HttpJob  
  objHJ.Initialize("", Me)  
  objHJ.PostString(STREAM_URL, CreateJson(streamData))  
  objHJ.GetRequest.SetContentType("application/json")  
  objHJ.GetRequest.SetHeader("Authorization", "Bearer " & Token)  
  Wait For (objHJ) JobDone(objHJ As HttpJob)  
  If objHJ.Success Then  
    Log("Live Stream Created: " & objHJ.GetString)  
    Return objHJ.GetString  
  Else  
    Log("Error: " & objHJ.ErrorMessage)  
    Return ""  
  End If  
End Sub
```

  

```B4X
Public Sub ListLiveBroadcasts(status As String, part As String, maxResults As Int, broadcastType As String, id As String, mine As Boolean, pageToken As String) As ResumableSub  
  Dim objHJ As HttpJob  
  objHJ.Initialize("", Me)  
  objHJ.Download(url)  
  objHJ.GetRequest.SetHeader("Authorization", "Bearer " & Token)  
  Wait For (objHJ) JobDone(objHJ As HttpJob)  
  If objHJ.Success Then  
    Log("Live Broadcasts: " & objHJ.GetString)  
    Return ParseBroadcasts(objHJ.GetString)  
  Else  
    Log("Error: " & objHJ.ErrorMessage)  
    Return ""  
  End If  
End Sub
```

  
  
In the case of ListLiveBroadcasts, this is the result of a query for one record.  

```B4X
Private Sub Button1_Click  
'    mOAuth2.ResetToken  
    mOAuth2.GetAccessToken  
    Wait For OAuth2_AccessTokenAvailable (Success As Boolean, Token As String)  
    If Not (Success) Then  
        Log("Error accessing account.")  
        Return  
    End If  
    mYouTubeAPI.Initialize  
    mYouTubeAPI.API_KEY = "AIza****************************cfwRG9o"  
    mYouTubeAPI.SetToken(Token)  
    Wait For (mYouTubeAPI.ListLiveBroadcasts("all", "contentDetails", 1, "", "", False, "")) Complete (StreamResponse As JSON)  
    Log("List of Broadcast: " & CRLF & StreamResponse)  
End Sub
```

  
  

```B4X
{  
  "kind": "youtube#liveBroadcastListResponse",  
  "etag": "tgzQi_e3c2YOIsxzLEpnFyyEePk",  
  "nextPageToken": "CAEQAA",  
  "pageInfo": {  
    "totalResults": 485,  
    "resultsPerPage": 1  
  },  
  "items": [  
    {  
      "kind": "youtube#liveBroadcast",  
      "etag": "4Ya1PyMGwBND7YfLvGYSGKQJRJs",  
      "id": "F5HZAAVqmGg",  
      "snippet": {  
        "publishedAt": "2024-03-02T16:46:53Z",  
        "channelId": "UCJXh-TMEuZbsmPTHzWp-fxw",  
        "title": "Handball Femenino (primera) 02/03/2024 - ASAMBAL vs. Argentinos Juniors (vivo)",  
        "description": "#PasSportsAr\n\n#Handball #Håndbold #Håndball #Handboll #Kézilabda #Rokomet #Rukomet #Handebol #PiłkaRęczna #Handbolti #Balonmano #Pallamano #كرة_اليد #Handbol #Handbold #Гандбол #Χάντμπολ #ハンドボール #핸드볼 #手球 #Håndbold #Hándbol\n\n#Sport #Šport #Esporte #Íþrótt #رياضة #Спорт #Αθλητισμός #スポーツ #스포츠 #运动 #Deporte",  
        "thumbnails": {  
          "default": {  
            "url": "https://i.ytimg.com/vi/F5HZAAVqmGg/default.jpg",  
            "width": 120,  
            "height": 90  
          },  
          "medium": {  
            "url": "https://i.ytimg.com/vi/F5HZAAVqmGg/mqdefault.jpg",  
            "width": 320,  
            "height": 180  
          },  
          "high": {  
            "url": "https://i.ytimg.com/vi/F5HZAAVqmGg/hqdefault.jpg",  
            "width": 480,  
            "height": 360  
          },  
          "standard": {  
            "url": "https://i.ytimg.com/vi/F5HZAAVqmGg/sddefault.jpg",  
            "width": 640,  
            "height": 480  
          },  
          "maxres": {  
            "url": "https://i.ytimg.com/vi/F5HZAAVqmGg/maxresdefault.jpg",  
            "width": 1280,  
            "height": 720  
          }  
        },  
        "scheduledStartTime": "2024-03-02T18:30:00Z",  
        "actualStartTime": "2024-03-02T18:31:48Z",  
        "actualEndTime": "2024-03-02T19:55:17Z",  
        "isDefaultBroadcast": false,  
        "liveChatId": "KicKGFVDSlhoLVRNRXVaYnNtUFRIeldwLWZ4dxILRjVIWkFBVnFtR2c"  
      },  
      "status": {  
        "lifeCycleStatus": "complete",  
        "privacyStatus": "public",  
        "recordingStatus": "recorded",  
        "madeForKids": false,  
        "selfDeclaredMadeForKids": false  
      },  
      "contentDetails": {  
        "boundStreamId": "JXh-TMEuZbsmPTHzWp-fxw1684655197397122",  
        "boundStreamLastUpdateTimeMs": "2024-03-02T19:55:04Z",  
        "monitorStream": {  
          "enableMonitorStream": true,  
          "broadcastStreamDelayMs": 0,  
          "embedHtml": "\u003ciframe width=\"425\" height=\"344\" src=\"https://www.youtube.com/embed/F5HZAAVqmGg?autoplay=1&livemonitor=1\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" referrerpolicy=\"strict-origin-when-cross-origin\" allowfullscreen\u003e\u003c/iframe\u003e"  
        },  
        "enableEmbed": true,  
        "enableDvr": true,  
        "enableContentEncryption": false,  
        "recordFromStart": true,  
        "enableClosedCaptions": false,  
        "closedCaptionsType": "closedCaptionsDisabled",  
        "enableLowLatency": false,  
        "latencyPreference": "normal",  
        "projection": "rectangular",  
        "enableAutoStart": false,  
        "enableAutoStop": false  
      }  
    }  
  ]  
}
```

  
  
If you've read this far and are interested in developing this library together, I'd be happy to do so. My intention is not to sell the library; of course, donations will be accepted. The most challenging part for me right now is opening the camera, capturing the video, and streaming it to YouTube.  
  

```B4X
Public Sub SendFileToLiveStream(filePath As String, streamId As String) As ResumableSub  
    Dim objHJ As HttpJob  
    objHJ.Initialize("", Me)  
    Dim rtmpServerUrl As String = "rtmp://example.com/live"  
    Dim fileUrl As String = "file://" & filePath  
    Dim command As String = $"ffmpeg -re -i ${fileUrl} -c:v copy -c:a aac -strict experimental -f flv ${rtmpServerUrl}/${streamId}"$  
    Dim shell As Shell  
    shell.Initialize  
    shell.RunNativeCommand(command, Null, Null)  
    Return "Streaming file to live stream"  
End Sub  
  
' Clase FFmpegWrapper  
Sub Class FFmpegWrapper  
  Private ffmpegPath As String  
  Public Sub Initialize  
    ffmpegPath = File.Combine(File.DirAssets, "ffmpeg")  
  End Sub  
   
  Public Sub ExecuteFFmpegCommand(Command As String, Callback As Object, EventName As String)  
    Dim p As Phone  
    Dim cmd As String = $"${ffmpegPath} ${Command}"$  
    Dim output As StringBuilder  
    Dim success As Boolean  
    output.Initialize  
    success = p.Shell(cmd, Null, output, output)  
    If success Then  
      CallSubDelayed(Callback, EventName & "_Success", output.ToString)  
    Else  
      CallSubDelayed(Callback, EventName & "_Failure", output.ToString)  
    End If  
  End Sub  
End Class
```