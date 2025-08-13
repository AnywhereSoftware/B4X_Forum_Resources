### Check Internet connection + Know connection type (WiFi/Cell) by Sergio Haurat
### 06/22/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/161621/)

SOLUTION HERE  
<https://www.b4x.com/android/forum/threads/b4x-sp-inetstatus-check-if-internet-is-available-type-wifi-cell-lan.161750/>  
  
  
**[SIZE=6][FONT=book antiqua]Please do not use the following code in your projects.[/FONT][/SIZE]**  
  
Below I share a function that returns if the Internet connection exists and what type of connection is available.  
  
**Warning: [USER=31245]@drgottjr[/USER] wrote to me: The classes and methods used for b4a have all been deprecated for some time (since sdk 28/29)**  
  

```B4X
Sub Process_Globals  
  Type tpeCheckInternet(blnIsOnline As Boolean, strType As String)  
End Sub  
  
Public Sub CheckInternet() As tpeCheckInternet  
  Dim ci As tpeCheckInternet  
  ci.Initialize  
  ci.strType = "NONE"  
  ci.blnIsOnline = False  
  Dim jo As JavaObject  
  jo.InitializeContext  
  Dim cm As JavaObject = jo.RunMethod("getSystemService", Array("connectivity"))  
  Dim activeNetwork As JavaObject = cm.RunMethod("getActiveNetworkInfo", Null)  
  If activeNetwork.IsInitialized Then  
    If activeNetwork.RunMethod("isConnected", Null).As (Boolean) = True Then  
      ci.blnIsOnline = True  
      If activeNetwork.RunMethod("getType", Null).As (Int) = 1 Then  
        ci.strType = "WIFI"  
      Else  
        ci.strType = "CELL"  
      End If  
    End If  
  End If  
  Return ci  
End Sub
```

  
  

```B4X
Sub Class_Globals  
  Dim tpeInet As tpeCheckInternet  
End Sub  
  
Public Sub Initialize  
  tpeInet.Initialize  
End Sub  
  
Private Sub B4XPage_Appear  
  'Check if the connection is active  
  If tpeInet.blnIsOnline Then  
    If tpeInet.strType = "WIFI" Then  
      'Download the large file automatically  
    Else  
      'Wait for user approval to use cellular network data  
    End If  
  Else  
    'No internet connection available  
  End If  
End Sub
```