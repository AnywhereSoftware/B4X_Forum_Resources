### Firebase Notifications select user / FirebaseAuth error by Duck
### 04/14/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/147437/)

I made a test app with Erel's video for Firebase Notifications which is running fine.  
Now i need to send message to a specific user off my app, so I need to know how to identify that user.  
I thought of using FirebaseAuth and went through the tutorial on <https://www.b4x.com/android/forum/threads/firebaseauth-authenticate-your-users.67875/>  
Is this the proper way to solve my problem?  
If so, i added the SHA1 fingerprint and added the code to the main page.  
I used the built-in FirebaseAuth library on b4a v.12(64bit)  
No error at 'auth.SignOutWithGoogle' but the app crashes on 'auth.SignInWithGoogle' with error:  
  
*java.lang.NoClassDefFoundError: Failed resolution of: Landroidx/arch/core/executor/ArchTaskExecutor;  
 at androidx.lifecycle.LifecycleRegistry.enforceMainThreadIfNeeded(LifecycleRegistry.java:322)  
 at androidx.lifecycle.LifecycleRegistry.addObserver(LifecycleRegistry.java:178)  
 at androidx.activity.ComponentActivity.<init>(ComponentActivity.java:277)  
 at androidx.fragment.app.FragmentActivity.<init>(FragmentActivity.java:108)  
 at com.google.android.gms.auth.api.signin.internal.SignInHubActivity.<init>(com.google.android.gms:play-services-auth@@20.3.0:1)  
 at java.lang.Class.newInstance(Native Method)  
 at android.app.AppComponentFactory.instantiateActivity(AppComponentFactory.java:95)  
 at androidx.core.app.CoreComponentFactory.instantiateActivity(CoreComponentFactory.java:45)  
 at android.app.Instrumentation.newActivity(Instrumentation.java:1273)  
 at android.app.ActivityThread.performLaunchActivity(ActivityThread.java:3520)  
 at android.app.ActivityThread.handleLaunchActivity(ActivityThread.java:3780)  
 at android.app.servertransaction.LaunchActivityItem.execute(LaunchActivityItem.java:85)  
 at android.app.servertransaction.TransactionExecutor.executeCallbacks(TransactionExecutor.java:135)  
 at android.app.servertransaction.TransactionExecutor.execute(TransactionExecutor.java:95)  
 at android.app.ActivityThread$H.handleMessage(ActivityThread.java:2251)  
 at android.os.Handler.dispatchMessage(Handler.java:106)  
 at android.os.Looper.loop(Looper.java:233)  
 at android.app.ActivityThread.main(ActivityThread.java:8068)  
 at java.lang.reflect.Method.invoke(Native Method)  
 at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:631)  
 at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:978)  
Caused by: java.lang.ClassNotFoundException: androidx.arch.core.executor.ArchTaskExecutor  
 … 21 more*  
  
  
Code on Main page:  
  

```B4X
Sub Process_Globals  
    Private auth As FirebaseAuth  
End Sub  
  
Sub Globals  
    Private Button1 As Button  
    Private Button2 As Button  
    Private Button3 As Button  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    auth.Initialize("auth")  
    Activity.LoadLayout("Layout")  
    If auth.CurrentUser.IsInitialized Then Auth_SignedIn(auth.CurrentUser)  
End Sub  
  
Sub Button1_Click  'Send notification  
    SendMessage("general", "title", "Text")  
End Sub  
  
Sub Button2_Click  'SignInWithGoogle  
    auth.SignInWithGoogle  
End Sub  
  
Sub Button3_Click  'SignOutWithGoogle  
    auth.SignOutFromGoogle  
    ToastMessageShow("Goodbye!",False)  
End Sub  
  
Sub Auth_SignedIn (User As FirebaseUser)  
    Log("SignedIn: " & User.DisplayName)  
    ToastMessageShow("Hello: " & User.DisplayName,False)  
End Sub
```