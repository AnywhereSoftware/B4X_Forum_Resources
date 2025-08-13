### NFC - Reading and Writing by Erel
### 08/16/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/64451/)

NFC v2.00 adds support for low level access to the NFC features. This allows reading and writing from NFC tags.  
  
The NFC library provides three features:  
- Reading Ndef tags based intent filters: [Reading NDEF data from NFC tags](https://www.b4x.com/android/forum/threads/14931/#content)  
- Sending data between two devices (Android Beam): <https://www.b4x.com/android/forum/threads/60731/#content>  
- Low level access to the tag.  
  
This tutorial explains how you can use the low level access to read and write Ndef tags. It is also possible to extend it to other types of tags. However you will need to implement the required protocol yourself.  
  
![](https://www.b4x.com/android/forum/attachments/42281)  
  
When a tag is scanned, the system sends an intent. The first step is to call NFC.EnableForegroundDispatch in Activity\_Resume. This will force the system to send the intent to our activity instead of sending it to a different app.  
You should call NFC.DisableForegroundDispatch in Activity\_Pause.  
  
Activity\_Resume will be called when an intent is sent to our activity. We need to check two things:  
1. This intent is related to a tag discovery.  
2. This is a new intent.  
  

```B4X
Sub Activity_Resume  
   'forces all nfc intents to be sent to this activity  
   nfc.EnableForegroundDispatch  
   Dim si As Intent = Activity.GetStartingIntent  
   'check that the intent is a new intent  
   If si.IsInitialized = False Or si = prevIntent Then Return  
   prevIntent = si  
   If si.Action.EndsWith("TECH_DISCOVERED") Or si.Action.EndsWith("NDEF_DISCOVERED") Or si.Action.EndsWith("TAG_DISCOVERED") Then  
      'work with the intent  
     End If  
   End If  
End Sub
```

  
  
Each NFC tag can support multiple types of technologies.  
NFC.GetTechList will return the list of supported technologies.  
You can see the full list of technologies here: <http://developer.android.com/reference/android/nfc/tech/TagTechnology.html>  
  
Assuming that the tag supports a technology that is relevant to our app, we create a TagTechnology object with the technology name and then connect to the tag:  

```B4X
If techs.IndexOf("android.nfc.tech.Ndef") > -1 Then  
   TagTech.Initialize("TagTech", "android.nfc.tech.Ndef" , si)  
   'Connect to the tag  
   TagTech.Connect  
Else
```

  
The technology class sets the actual type of TagTech.  
  
The Connected event will be raised when the connection is established. Make sure to check the success parameter as it can fail if the user moved the device during the connection.  
  
Once connected we can start calling the technology specific APIs. The NFC library doesn't expose these APIs. You should instead use JavaObject or TagTechnology.RunAsync to call these methods.  
You can find the APIs here: <http://developer.android.com/reference/android/nfc/tech/NfcA.html> (for NfcA).  
  
There are two types of methods: blocking (I/O) and non-blocking.  
You should use TagTechnology.RunAsync to call any of the blocking methods. The RunAsync event will be raised when the operation completed (the call itself will be executed on a background thread).  
  
Example of reading Ndef records (API: <http://developer.android.com/reference/android/nfc/tech/Ndef.html>):  

```B4X
Private Sub ReadNdef  
   TagTech.RunAsync("ReadNdef", "getNdefMessage", Null, 0)  
End Sub  
  
Private Sub ReadNdef_RunAsync (Flag As Int, Success As Boolean, Result As Object)  
   Log($"Reading completed. Success=${Success}, Flag=${Flag}"$)  
   ListView1.Clear  
   If Success Then  
     If Result = Null Then  
       ToastMessageShow("No records found.", False)  
     Else  
       Dim message As JavaObject = Result  
       Dim records() As Object = message.RunMethod("getRecords", Null)  
       For Each r As NdefRecord In records  
         Dim b() As Byte = r.GetPayload  
         ListView1.AddSingleLine(BytesToString(b, 0, b.Length, "utf8"))  
       Next  
     End If  
   End If  
End Sub
```

  
  
The attached example shows how to read and write to Ndef tags. This is a popular and simple format.  
  
Similar example based on the "reader API" and without the platform sounds: <https://www.b4x.com/android/forum/threads/nfc-reading-can-the-default-read-notification-sound-be-removed.142345/>