### Advertising id by Erel
### 09/03/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/101050/)

1. Add a reference to FirebaseAdMob2.  
2. Add to manifest editor:  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase)  
AddPermission(com.google.android.gms.permission.AD_ID)
```

  
3. Add:  

```B4X
Private Sub GetAdvertisingId As ResumableSub  
   Dim jo As JavaObject = Me  
   jo.RunMethod("GetAdvertisingId", Null)  
   Wait For AdvertisingId_Ready (Success As Boolean, Id As String)  
   Return Id  
End Sub
```

  
  
4a. B4XPages project (in the relevant page):  

```B4X
#if Java  
import java.util.concurrent.Callable;  
import com.google.android.gms.ads.identifier.AdvertisingIdClient;  
import com.google.android.gms.ads.identifier.AdvertisingIdClient.Info;  
  
public void GetAdvertisingId() {  
   BA.runAsync(ba, mostCurrent, "advertisingid_ready", new Object[] {false, ""}  
       , new Callable<Object[]>() {  
                   @Override  
                   public Object[] call() throws Exception {  
                       String id = AdvertisingIdClient.getAdvertisingIdInfo(ba.context).getId();  
                       return new Object[] {true, id};  
                   }  
               }); }  
#End If
```

  
  
4b. Non-B4XPages project - in the Activity:  

```B4X
#if Java  
import java.util.concurrent.Callable;  
import com.google.android.gms.ads.identifier.AdvertisingIdClient;  
import com.google.android.gms.ads.identifier.AdvertisingIdClient.Info;  
  
public static void GetAdvertisingId() {  
   BA.runAsync(processBA, mostCurrent, "advertisingid_ready", new Object[] {false, ""}  
       , new Callable<Object[]>() {  
                   @Override  
                   public Object[] call() throws Exception {  
                       String id = AdvertisingIdClient.getAdvertisingIdInfo(mostCurrent).getId();  
                       return new Object[] {true, id};  
                   }  
               }); }  
#End If
```

  
  
Usage example:  

```B4X
Private Sub Button1_Click  
    Wait For (GetAdvertisingId) Complete (Id As String)  
    If Id <> "" Then  
        Log(Id)  
    Else  
        Log("Error retreiving key")  
        Log(LastException)  
    End If  
End Sub
```

  
  
Q: What is the advertising id?  
  
A: <https://support.google.com/googleplay/android-developer/answer/6048248?hl=en>  
  
The IDE will show a warning about FirebaseAdMob not being used. You can discard this warning with:  

```B4X
#IgnoreWarnings: 32
```