### Exoplayer track video resolutions by zedapp
### 08/01/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/162349/)

Hello friends, i wanna share with you a code that can you use it to get video resolutions avilables in played video (m3u8,mp4 …) and show it in listview to select one of this qualities; :  
do not forget to add in "Main" layout : SimpleExoPlayerView1, a button named showqualities,  
  
'\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
Sub Class\_Globals  
 Public SimpleExoPlayerView1 As SimpleExoPlayerView  
 Public Player As SimpleExoPlayer  
End Sub  
  
Private Sub B4XPage\_Created (Root1 As B4XView)  
Root = Root1  
 Root.LoadLayout("MainPage")  
  
 Player.Initialize("Player")  
  
 Player.Prepare(Player.CreateHLSSource("<https://cdn1.skygo.mn/live/disk1/Cartoon_Network/HLS-FTA/Cartoon_Network.m3u8>"))  
 SimpleExoPlayerView1.Player = Player  
 SimpleExoPlayerView1.ResizeMode="FIXED\_WIDTH"  
 Player.Play  
   
End Sub  
Private Sub showqualities\_Click  
 PopulateVideoQualities  
end sub  
Sub PopulateVideoQualities  
  
 Dim jo As JavaObject =Player  
 TrackGroups = jo.GetFieldJO("player").RunMethod("getCurrentTrackGroups", Null)  
  
 Dim videoQualities As List  
 videoQualities.Initialize  
  
 For i = 0 To TrackGroups.GetField("length") - 1  
 Dim TrackGroup As JavaObject = TrackGroups.RunMethod("get", Array(i))  
 For j = 0 To TrackGroup.GetField("length") - 1  
 Dim Format As JavaObject = TrackGroup.RunMethodJO("getFormat", Array(j))  
 Dim mime As String = Format.GetField("sampleMimeType")  
 If mime.StartsWith("video") Then  
 Dim width As Int = Format.GetField("width")  
 Dim height As Int = Format.GetField("height")  
 If width > 0 And height > 0 Then  
 Dim quality As String = width & ", " & height  
 videoQualities.Add(quality)  
 End If  
 End If  
 Next  
 Next  
  
 ' Populate ListView with video qualities  
 For Each quality As String In videoQualities  
 lvQualities.AddSingleLine(quality)  
 Next  
End Sub  
  
Sub lvQualities\_ItemClick (Position As Int, Value As Object)  
 Dim quality As String = Value  
 Dim parts() As String = Regex.Split(", ", quality)  
 Dim width As Int = parts(0)  
 Dim height As Int = parts(1)  
 SetVideoResolution(width, height)  
End Sub  
  
Private Sub SetVideoResolution(x As Int, y As Int)  
 Dim mp As B4XMainPage = B4XPages.MainPage  
 Dim jo As JavaObject = mp.Player  
 Dim trackSelector As JavaObject = jo.GetField("trackSelector")  
 trackSelector.RunMethod("setParameters", Array(trackSelector.RunMethodJO("buildUponParameters", Null).RunMethod("setMaxVideoSize", Array(x, y))))  
End Sub