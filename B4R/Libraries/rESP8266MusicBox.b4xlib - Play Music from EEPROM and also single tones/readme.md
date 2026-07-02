### rESP8266MusicBox.b4xlib - Play Music from EEPROM and also single tones. by hatzisn
### 06/30/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/171315/)

With this library you can play music from the eeprom and download music to save it to eeprom (in order to play it) - code for downloading is not included because of course it is site dependant (music plays in a passive buzzer). The music must be in the form byte(ii)=0-89 and byte(ii+1)\*40 = milliseconds of duration. This pattern repeats for all notes. The 0 to 89 value is the note where 47 has the frequency of 440Hz and going down the frequency is [2^(-x/12)] \* 440 and going up the frequency is [2^(x/12)] \* 440Hz where x=1,2,3,4…. Frequency 440 corresponds to note A above middle C. The frequencies correspond to the note button if we start with A above middle C and going down, we press the next closer button no matter the color (going down). The same is valid when we are going up. A value of 0 for the note means it is pause. Also byte(0) and byte(1) in EEPROM is the length of the track which Length = byte(0)\*255+byte(1). Then from byte(2) and above are the notes in the previous mentioned format. The music can be saved in any position of the EEPROM and then byte(0) is saved in this position - so it is {position in EEPROM}+0. You just have to pass the initial position as a parameter.  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 300  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public Serial1 As Serial  
    Dim D2 As Pin  
    Public wifi As ESP8266WiFi  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(9600)  
    Log("AppStart")  
    ESP8266MusicBox.InitializeMusicBox  
  
    D2.Initialize(15, D2.MODE_OUTPUT)  
    D2.DigitalWrite(False)  
    Log("Waiting 3 seconds")  
    'CallSubPlus("RockAroundTheClock", 10, 0)  
  
  
    If wifi.Connect2("SSID", "SSIDKey") Then  
        Log("Connected")  
    Else  
        Log("Not connected. Abording…")  
        Return  
    End If  
    Log(AvailableRAM)  
    HttpJob.Initialize("song")  
    HttpJob.Download("https://mysite.com/download/song.dat")  
         
'    For t = 1 To 3  
'        Log("Playing_Tone")  
'        ESP8266MusicBox.Play(D2, 1100, 600)  
'        Delay (1000)  
'    Next  
     
    Log("Playing_Music")  
'    ESP8266MusicBox.PlayMusic(400, D2)  
End Sub  
  
Sub JobDone(Job As JobResult)  
    Dim rEpr As EEPROM  
    rEpr.WriteBytes(Job.Response, 10)  
    Log(rEpr.Size)  
    Log("Done")  
    Log(AvailableRAM)  
    CallSubPlus("PlayFromEEPROM", 10, 0)  
End Sub  
  
  
  
Sub PlayFromEEPROM(u As Byte)  
    Delay(3000)  
    Log(ESP8266MusicBox.CheckIfThereIsMusic(10))  
    ESP8266MusicBox.PlayMusic(10, D2)  
    Log(AvailableRAM)  
    CallSubPlus("PlayFromEEPROM", 10, 0)  
End Sub  
  
  
  
  
Sub RockAroundTheClock(u As Byte)  
    Delay(3000)  
    ESP8266MusicBox.Play(D2, 1047, 240)  
    Delay(248)  
    ESP8266MusicBox.Play(D2, 1319, 240)  
    Delay(297)  
    ESP8266MusicBox.Play(D2, 1568, 240)  
    Delay(784)  
    ESP8266MusicBox.Play(D2, 1047, 240)  
    Delay(263)  
    ESP8266MusicBox.Play(D2, 1319, 240)  
    Delay(224)  
    ESP8266MusicBox.Play(D2, 1568, 240)  
    Delay(784)  
    ESP8266MusicBox.Play(D2, 1047, 240)  
    Delay(256)  
    ESP8266MusicBox.Play(D2, 1319, 240)  
    Delay(282)  
    ESP8266MusicBox.Play(D2, 1568, 240)  
    Delay(254)  
    ESP8266MusicBox.Play(D2, 1760, 240)  
    Delay(233)  
    ESP8266MusicBox.Play(D2, 1865, 240)  
    Delay(264)  
    ESP8266MusicBox.Play(D2, 1760, 240)  
    Delay(247)  
    ESP8266MusicBox.Play(D2, 1568, 240)  
    Delay(849)  
    ESP8266MusicBox.Play(D2, 1568, 240)  
    Delay(270)  
    ESP8266MusicBox.Play(D2, 1397, 240)  
    Delay(234)  
    ESP8266MusicBox.Play(D2, 1319, 240)  
    Delay(352)  
    ESP8266MusicBox.Play(D2, 1047, 240)  
    Delay(240)  
    ESP8266MusicBox.Play(D2, 1568, 240)  
    Delay(208)  
    ESP8266MusicBox.Play(D2, 1397, 240)  
    Delay(278)  
    ESP8266MusicBox.Play(D2, 1319, 240)  
    Delay(521)  
    ESP8266MusicBox.Play(D2, 1568, 240)  
    Delay(17)  
    ESP8266MusicBox.Play(D2, 1568, 240)  
    Delay(288)  
    ESP8266MusicBox.Play(D2, 1397, 240)  
    Delay(264)  
    ESP8266MusicBox.Play(D2, 1319, 240)  
    Delay(319)  
    ESP8266MusicBox.Play(D2, 1047, 240)  
    Delay(264)  
    ESP8266MusicBox.Play(D2, 1568, 240)  
    Delay(216)  
    ESP8266MusicBox.Play(D2, 1397, 240)  
    Delay(232)  
    ESP8266MusicBox.Play(D2, 1319, 240)  
    Delay(257)  
    ESP8266MusicBox.Play(D2, 1568, 240)  
    Delay(216)  
    ESP8266MusicBox.Play(D2, 1397, 240)  
    Delay(247)  
    ESP8266MusicBox.Play(D2, 1397, 240)  
    Delay(231)  
    ESP8266MusicBox.Play(D2, 1397, 240)  
    Delay(378)  
    ESP8266MusicBox.Play(D2, 1319, 240)  
    Delay(95)  
    ESP8266MusicBox.Play(D2, 1568, 240)  
    Delay(249)  
    ESP8266MusicBox.Play(D2, 1397, 240)  
    Delay(279)  
    ESP8266MusicBox.Play(D2, 1319, 240)  
    Delay(441)  
    ESP8266MusicBox.Play(D2, 1047, 240)  
    Delay(24)  
    ESP8266MusicBox.Play(D2, 1047, 240)  
  
    Log(AvailableRAM)  
    CallSubPlus("RockAroundTheClock", 10, 0)  
     
End Sub
```

  
  
  
  
You can also play single tones.  
  

```B4X
ESP8266MusicBox.Play(D2, 440, 1000)
```