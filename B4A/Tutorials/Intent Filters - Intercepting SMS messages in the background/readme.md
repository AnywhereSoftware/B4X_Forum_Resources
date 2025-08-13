### Intent Filters - Intercepting SMS messages in the background by Erel
### 01/13/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/20103/)

**Old tutorial. Don't use services. Use receivers.**  
Broadcast receivers are program components that can handle broadcasted messages. These messages usually notify about a system event.  
  
There are two types of receivers in Android: statically registered receivers and dynamically registered receivers.  
  
Static registered receivers are receivers that are declared in the manifest file.  
Dynamic registered receivers are registered at runtime by calling the Java registerReceiver method.  
  
In Basic4android you can register dynamic receivers with the BroadcastReceiver library. PhoneEvents and SmsInterceptor objects from the Phone library also use dynamic registration to listen for common intents.  
  
**Difference between static and dynamic receivers**  
The main difference between the two types of receivers is that dynamic receivers listen to intents as long as the process is running.  
  
Static receivers always work. If the process is not running then it will be created.  
  
Normal processes eventually get killed. This means that you cannot rely on dynamic receivers to intercept intents when your application is in the background. A possible workaround is to call Service.StartForeground in the service. This will prevent the process from being killed. However this will also add an ongoing notification icon (see the [Services tutorial](http://www.b4x.com/forum/showthread.php?p=42973) for more information).  
  
So if you need to always listen for a specific type of intents then you may prefer to use a static receiver. Note that some intents can only be intercepted with dynamic receivers.  
  
**Static receivers**  
Each service module in Basic4android is made of two components. The service and a receiver. The receiver responsibility is to delegate broadcast intents to the service. For example when you call StartServiceAt, it is the receiver that actually intercepts the intent and wakes the service.  
  
If we want to listen for intents we need to define an intent filter in the manifest file. See this [link](http://developer.android.com/intl/fr/guide/components/intents-filters.html) for more information about intent filters.  
  
For example if we want to listen for intents with the action: android.provider.Telephony.SMS\_RECEIVED we will need to add the following manifest editor code:  

```B4X
AddPermission(android.permission.RECEIVE_SMS)  
AddReceiverText(s1,  
<intent-filter>  
    <action android:name="android.provider.Telephony.SMS_RECEIVED" />  
</intent-filter>)
```

  
s1 is the name of the service module that the intent will be delegated to.  
We also add the RECEIVE\_SMS permission which is required in this case.  
  
Once this program is installed the service will be started each time that an Sms message arrives. It doesn't matter whether the process is running or not.  
  
In our Service\_Start event we check the intent action. If it fits then the messages will be parsed from the intent. This is done with the help of the Reflection library:  

```B4X
'Service module  
Sub Process_Globals  
   Type Message (Address As String, Body As String)  
End Sub  
Sub Service_Create  
  
End Sub  
  
Sub Service_Start(startingIntent As Intent)  
   If startingIntent.Action = "android.provider.Telephony.SMS_RECEIVED" Then  
      Dim messages() As Message  
      messages = ParseSmsIntent(startingIntent)  
      For i = 0 To messages.Length - 1  
         Log(messages(i))  
      Next  
   End If  
   Service.StopAutomaticForeground  
End Sub  
  
'Parses an SMS intent and returns an array of messages  
Sub ParseSmsIntent (in As Intent) As Message()  
   Dim messages() As Message  
   If in.HasExtra("pdus") = False Then Return messages  
   Dim pdus() As Object  
   Dim r As Reflector  
   pdus = in.GetExtra("pdus")  
   If pdus.Length > 0 Then  
      Dim messages(pdus.Length) As Message  
      For i = 0 To pdus.Length - 1  
         r.Target = r.RunStaticMethod("android.telephony.SmsMessage", "createFromPdu", _  
            Array As Object(pdus(i)), Array As String("[B"))  
         messages(i).Body = r.RunMethod("getMessageBody")  
         messages(i).Address = r.RunMethod("getOriginatingAddress")  
      Next  
   End If  
   Return messages  
End Sub
```

  
  
**Update 2018:** Static intent filters will cause the service to start while the app is not in the foreground. This means that on newer devices it will only work with B4A v8+ and that we need to call Service.StopAutomaticForeground once the task has completed.  
<https://www.b4x.com/android/forum/threads/automatic-foreground-mode.90546/#post-572424>