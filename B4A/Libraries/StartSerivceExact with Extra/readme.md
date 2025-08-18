### StartSerivceExact with Extra by somed3v3loper
### 07/19/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/141868/)

Hello all ,  
In one of my personal applications , I needed to schedule a service but I needed also to know which sql row it was scheduled for . and for this reason and probably other reasons , this small library was born .  
It is a modified version of the internal method used in b4a.  

```B4X
package smm.StartSerivceExactbapackage;  
  
import android.content.Intent;  
import android.content.Context;  
import android.net.Uri;  
import android.os.Environment;  
  
  
import anywheresoftware.b4a.BA;  
import anywheresoftware.b4a.BA.Events;  
import anywheresoftware.b4a.BA.Hide;  
import anywheresoftware.b4a.BA.Pixel;  
import anywheresoftware.b4a.BA.ShortName;  
import anywheresoftware.b4a.BA.Version;  
import anywheresoftware.b4a.AbsObjectWrapper;  
  
import anywheresoftware.b4a.BA.Author;  
import anywheresoftware.b4a.BA.DependsOn;  
import anywheresoftware.b4a.BA.ActivityObject;  
  
import android.app.PendingIntent;  
import android.os.Build;  
import android.app.AlarmManager;  
import java.lang.ClassNotFoundException;  
  
@Version(0.07f)  
@ShortName("StartSerivceExact")  
@Author("SMM")  
  
public class StartSerivceExactba   {  
  
        
    public static void StartServiceAtExact(BA mine, Object Service, long Time, boolean DuringSleep,String Extra) throws Exception {  
        AlarmManager am = (AlarmManager) BA.applicationContext.getSystemService(Context.ALARM_SERVICE);  
        PendingIntent pi = createPendingIntentForAlarmManager(mine, Service,Extra);  
        if (Build.VERSION.SDK_INT >= 23 && DuringSleep)  
            am.setExactAndAllowWhileIdle (AlarmManager.RTC_WAKEUP, Time, pi);  
        else if (Build.VERSION.SDK_INT >= 19)  
            am.setExact(DuringSleep ? AlarmManager.RTC_WAKEUP : AlarmManager.RTC, Time, pi);  
        else  
            am.set(DuringSleep ? AlarmManager.RTC_WAKEUP : AlarmManager.RTC, Time, pi);  
    }  
    private static PendingIntent createPendingIntentForAlarmManager(BA mine, Object Service,String Extra) throws ClassNotFoundException {  
        Intent in = new Intent(BA.applicationContext, getComponentClass(mine, Service, true));  
        in.putExtra("BAExtra", Extra);  
        int flags = PendingIntent.FLAG_UPDATE_CURRENT;  
        if (Build.VERSION.SDK_INT >= 31)  
            flags |= 33554432; //FLAG_MUTABLE  
        return PendingIntent.getBroadcast(mine.context, 1, in,  
                flags);  
    }  
        public static void CancelScheduledService(BA mine, Object Service) throws ClassNotFoundException {  
        AlarmManager am = (AlarmManager) BA.applicationContext.getSystemService(Context.ALARM_SERVICE);  
        am.cancel(createPendingIntentForAlarmManager(mine, Service,""));  
    }  
    @Hide  
    public static Class<?> getComponentClass(BA mine, Object component, boolean receiver) throws ClassNotFoundException {  
        Class<?> resClass = null;  
        if (component instanceof Class<?>) { //default case  
            resClass = (Class<?>) component;  
        }  
        else if (component == null || component.toString().length() == 0) {  
            resClass = Class.forName(mine.className);  
        }  
        else if (component instanceof String) {  
            resClass = Class.forName(BA.packageName + "." +  
                    ((String)component).toLowerCase(BA.cul));  
        }  
        if (resClass == null)  
            return null;  
        if (receiver) {  
            String serviceName = resClass.getName().substring(resClass.getName().lastIndexOf(".") + 1);  
            resClass = Class.forName(resClass.getName() + "$" + serviceName + "_BR");  
        }  
        return resClass;  
    }  
    
    
}
```

  
  
  

```B4X
Sub Service_Start (StartingIntent As Intent)  
If StartingIntent.HasExtra("BAExtra") Then  
        Dim id As String =StartingIntent.GetExtra("BAExtra") …..
```