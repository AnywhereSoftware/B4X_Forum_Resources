### Generate Unique Id on Android No permissions Needed. by Addo
### 03/17/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/128388/)

Based on This StackOverflow  
  
[alternatives of IME](https://stackoverflow.com/questions/58103580/android-10-imei-no-longer-available-on-api-29-looking-for-alternatives)  
  

```B4X
Sub GETUniqueID As String  
Dim JO As JavaObject  
Dim ID As String  
JO.InitializeContext  
ID = JO.RunMethod("getUniqueID", Null)  
Log(ID)  
Return ID  
End Sub  
  
#If Java  
import android.media.MediaDrm;  
import android.os.Build;  
import android.content.*;  
import java.util.*;  
  
//private final Context context;  
private String initialVal = "";  
  
  
public String getUniqueID() {  
   UUID wideVineUuid = new UUID(-0x121074568629b532L, -0x5c37d8232ae2de13L);  
   try {  
      MediaDrm wvDrm = new MediaDrm(wideVineUuid);  
      byte[] wideVineId = wvDrm.getPropertyByteArray(MediaDrm.PROPERTY_DEVICE_UNIQUE_ID);  
      Base64.Encoder enc = Base64.getEncoder();  
      String encodedUid = enc.encodeToString(wideVineId);  
      return encodedUid;  
   } catch (Exception e) {  
      return initialVal;  
   }  
}  
  
#End If
```

  
  
Tested On Factory Reset And it keeps the same Value, Any Suggestions are welcome. Good Luck