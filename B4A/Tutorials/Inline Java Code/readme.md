### Inline Java Code by Erel
### 02/24/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/50141/)

The next versions of B4A (4.30) and B4J (2.80) will allow you to embed Java code inside your B4X code. B4i supports similar feature with Objective C.  
  
The purpose of this feature is to make it easier to access third party SDKs and also to allow developers to add existing Java code snippets to their projects.  
  
Adding Java code is done with an #If Java block:  

```B4X
#If JAVA  
public String FirstMethod() {  
   return "Hello World!";  
}  
#End If
```

  
  
You need an instance of JavaObject to access the Java methods:  

```B4X
Sub Process_Globals  
   Private NativeMe As JavaObject  
End Sub  
  
Sub Globals  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   If FirstTime Then  
     NativeMe.InitializeContext  
   End If  
   Dim s As String = NativeMe.RunMethod("FirstMethod", Null)  
   Log(s) 'will print Hello World!  
End Sub
```

  
The Java code can also include imports. The compiler will find these imports and add them at the top of the class.  
  
The Java code will be added at the end of the class. Right before the closing bracket.  
  
Methods added to Activity or Service modules will be executed with the component context ('this' will be the activity or service instance).  
  
**Hooks**  
  
Hooks are similar to the standard events but they run Java methods. Hooks are mainly used by SDKs that require you to add code in the various Activity events.  
Note that there are no hooks in B4J implementation.  
  
For example the following code will run in the standard Activity onCreate method (before the call to setContentView):  

```B4X
#If JAVA  
public void _onCreate() {  
   requestWindowFeature(Window.FEATURE_INDETERMINATE_PROGRESS);  
}  
#End If
```

  
  
Activity hooks:  
\_onCreate()  
\_onResume()  
\_onPause()  
\_onDestroy()  
\_onStop()  
\_onStart()  
\_onPrepareOptionsMenu (android.view.Menu menu)  
\_onnewintent (android.content.Intent intent)  
boolean \_onCreateOptionsMenu (android.view.Menu menu) <— If you return true from this method then the standard B4A code in onCreateOptionsMenu will not run.  
boolean \_onkeydown (int keyCode, android.view.KeyEvent event) <– Return true from this method to return true from the native onKeyDown (and skip Activity\_KeyPress event).  
boolean \_onkeyup (int keyCode, android.view.KeyEvent event) <– same comment as above  
  
Service hooks:  
\_onCreate()  
\_onStartCommand(Intent intent, int flags, int startId)  
\_onDestroy()  
  
**Tips**  
  
- The methods you add should be public methods.  
- Methods in static code modules should be public static.  
- See the attached project. It shows how to call Java methods in all types of modules.  
  
**Don't misuse this feature. There are no performance advantages for using it and it can make your project more difficult to debug and maintain.**