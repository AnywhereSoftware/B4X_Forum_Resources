### A general solution to blocking screen capture (snapshot) by JackKirk
### 06/09/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/131489/)

I decided to have another go at finding a general solution to this.  
  
By "general" I mean the ability to turn snapshot blocking on and off at will when the code in the Activity module is running.  
  
If you search the forums for "snapshot" and "screen capture" there are pretty limited suggestions as to how to block it - all solutions basically end up at:  
  
<https://www.b4x.com/android/forum/threads/disable-screen-capture-functionality.35753/#content> (last post)  
  
which judging by the post dates is referencing:  
  
<https://www.b4x.com/android/forum/threads/how-to-block-ban-screen-shots-of-app.52075/#post-326475>(post #6 by NJDude)  
  
I reproduce NJDude's code here:  

```B4X
#If Java  
import android.annotation.TargetApi;  
import android.content.Context;  
import android.view.WindowManager.*;  
public void _onCreate() {  
    this.getWindow().setFlags(LayoutParams.FLAG_SECURE, LayoutParams.FLAG_SECURE);  
}  
#End If
```

  
Put this code in your Activity module and it will automatically run at Activity\_Create - no calls required.  
  
This works but is making the implicit assumption that you want your activity to **never be able to be snapshot**.  
  
Unfortunately my circumstance is that I only want to prevent snapshots until the user completes a registration process (its a long story).  
  
After considerable mucking around with this code and googling (my substitute for any real knowledge or understanding of Android and java) I managed to come up with:  

```B4X
'This code can be anywhere in the Activity module:  
  
……….  
  
'Block screenshots  
Private wrk_jo As JavaObject  
wrk_jo.InitializeContext  
wrk_jo.RunMethod("securescreen", Null)  
  
……….  
  
'Allow screenshots  
Private wrk_jo As JavaObject  
wrk_jo.InitializeContext  
wrk_jo.RunMethod("unsecurescreen", Null)  
  
……….  
  
#If Java  
import android.annotation.TargetApi;  
import android.content.Context;  
import android.view.WindowManager.*;  
public void securescreen() {  
    this.getWindow().setFlags(LayoutParams.FLAG_SECURE, LayoutParams.FLAG_SECURE);  
}  
public void unsecurescreen() {  
    this.getWindow().clearFlags(LayoutParams.FLAG_SECURE);  
}  
#End If
```

  
This is not restricted to Activity\_Create - you can turn it on and off wherever you like.  
  
I have incorporated this in my app and tested it on:  
  
Android–SDK  
6.0.1–23  
7.0–24  
10.0–29  
11–30  
  
I'd be interested in someone giving it a test on the missing Android/SDK levels and reporting back.  
  
Happy coding…