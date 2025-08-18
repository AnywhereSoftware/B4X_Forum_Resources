### Read And Write NFC Tags ! by Justcooldev
### 05/10/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/140435/)

***(NFCRW has been Updated !)***  
In this project You can scan and write your Ndef or NFC tags Very simply,  
(This project is for B4XPages)  
  
The Principal codes :  

```B4X
nfc.EnableForegroundDispatch  
    Dim si As Intent = B4XPages.GetNativeParent(Me).GetStartingIntent  
    If si.IsInitialized = False Or si = prevIntent Then Return  
    prevIntent = si  
    If si.Action.EndsWith("TECH_DISCOVERED") Or si.Action.EndsWith("NDEF_DISCOVERED") Or si.Action.EndsWith("TAG_DISCOVERED") Then  
        Dim techs As List = nfc.GetTechList(si)  
        Log($"Techs: ${techs}"$)  
        'in this case we are only accessing Ndef tags.  
        If techs.IndexOf("android.nfc.tech.Ndef") > -1 Then  
            TagTech.Initialize("TagTech", "android.nfc.tech.Ndef" , si)  
            'Connect to the tag  
            TagTech.Connect  
        Else  
            toast.Show("Tag does not support Ndef.")  
        End If  
    End If
```

  

```B4X
Private Sub TagTech_Connected (Success As Boolean)  
    Log($"Connected: ${Success}"$)  
    If Success = False Then  
        toast.Show("Error connecting to tag")  
        Log(LastException)  
    Else  
        WriteNdef(Array(nfc.CreateMimeRecord("text/plain", Ignore.Text.GetBytes("UTF8")), _  
                      nfc.CreateMimeRecord("text/plain", Record.Text.GetBytes("UTF8"))))  
    End If  
End Sub  
  
Private Sub WriteNdef (Records() As Object)  
    Dim RecordsJO As JavaObject  
    RecordsJO.InitializeArray("android.nfc.NdefRecord", Records)  
    Dim message As JavaObject  
    message.InitializeNewInstance("android.nfc.NdefMessage", Array(RecordsJO))  
    TagTech.RunAsync("WriteNdef", "writeNdefMessage", Array(message), 0)  
    Label1.Text = "Tag Writed With Text : " & Record.Text  
    Sleep(1000)  
    Label1.Text = "Awaiting for a Ndef tag scanned"  
End Sub
```

  
  
The phone needs NFC Reading possibility.  
  
Enjoy it.