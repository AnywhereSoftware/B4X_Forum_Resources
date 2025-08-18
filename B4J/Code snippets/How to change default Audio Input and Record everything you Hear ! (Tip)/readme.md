### How to change default Audio Input and Record everything you Hear ! (Tip) by Magma
### 07/21/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/141918/)

Hi there…  
  
Well I 've read it at least 20 times here in forum - how will be possible to record what we hear ?  
  
For example - i think that last time I was the "person" asking for that… :) here:  
<https://www.b4x.com/android/forum/threads/record-what-hear-output-from-pc-and-send-with-mqtt.141555/>  
  
**First**, of all… let's talk about the reason why old days was hidden or not showing (and now)… in front of us… because of Copyrights reasons… (Sony and other companies don't want to copy what we hear)…  
  
**Second**… is it possible for all Sound Cards and PC's to do that… hmm… 90%… i think with downloading latest Driver from Manufacturer…  
  
**And third**… How works…? simple, you must go at your Windows Sound Settings.. at Board Control of Sound… at Record… and Select Stereo Mix as default input device… it is not there… ?  
Hmm… try this [**registry trick**](https://drive.google.com/file/d/1k2tHzqdp5b1_6qD_QhV_RdWj1QnotcVj/view?usp=sharing) (but **CAUTION!** if this create problem at your pc - **I am not responsible**) - double click and run it - reboot your system and try… (Most times no need for registry trick)  
So… now if you record from windows sound recorder - you will record anything playing your pc + system sounds… everything…  
  
**Now the solution - How will make our program - change programmatically the default record input**… in that point I must say tried many things… but nirsoft.net has a cmd line utility that make it more simple (I ve think will found sometime a wmic option or a powershell command to do that… but need a lot of searching)…  
  
So download **[**NIRCMD**](https://www.nirsoft.net/utils/nircmd-x64.zip)** and in zip file you will found nircmdc.exe… now copy at **Files** at your project…  
  
and use this piece of code (you can add more languages but you must see in control of sound how "Stereo Mix" it is written in your lang):  

```B4X
…  
    If File.Exists(File.DirApp,"nircmdc.exe")=False Then  
        File.Copy(File.DirAssets,"nircmdc.exe",File.DirApp,"nircmdc.exe")  
    End If  
  
        Dim js As Shell  
        Dim params As List  
        params.Initialize  
        
        Dim sst(3) As String 'english/italian/german - greek - spanish  
        sst(0)="Stereo Mix" 'english/italian/german  
        sst(1)="Στερεοφωνική μείξη" 'greek  
        sst(2)="Mezcla estéreo" 'spanish  
        
        For k=0 To 2  
        params.Clear  
        params.Add("setdefaultsounddevice")  
        params.Add(QUOTE & sst(k) & QUOTE)  
        params.Add("1")  
        js.Initialize("js", "NIRCMDC.exe", params)  
        js.WorkingDirectory=File.DirApp.Replace("/","\")  
        js.Run(-1)  
        Wait for (js) js_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
        Next  
        'wait extra..little  
        Sleep(1200)
```

  
  
So now any audio record b4j library like [**jAudioTrack**](https://www.b4x.com/android/forum/threads/jaudiotrack.37973/) or [**jAudioRecord**](https://www.b4x.com/android/forum/threads/jaudiorecord.37930/) will record from **Stereo Mix**…  
  
[**I have to say that I using this solution at my new Project RAviaMQTT (Remote Administration via MQTT - for transfersing sound from remote host pc to client-pc) and works super good !**](https://www.b4x.com/android/forum/threads/remote-administration-via-mqtt-19-eur.141558/)  
  
  
  
*\*\*\* How can we make it better ? Find an inline java that will select the Stereo Mix as default input sound… but first getting the default sound input… and when app stops run retun to the user's default… as I ve search inline java must use JNA…*  
<https://docs.microsoft.com/en-us/windows/win32/api/mmdeviceapi/nn-mmdeviceapi-immdeviceenumerator>