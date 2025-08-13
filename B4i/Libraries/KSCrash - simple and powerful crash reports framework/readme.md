### KSCrash - simple and powerful crash reports framework by Erel
### 01/23/2025
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/120644/)

KSCrash is an open source crash reports framework: <https://github.com/kstenerud/KSCrash>  
  
It is simple to use and looks like it works very good.  
The app collects the crash reports and tries to send them when the app is started again. There are several ways to send the crash reports, including sending to a http server and sending an email.  
  
The following code uses the email method.  
  
![](https://www.b4x.com/android/forum/attachments/97724)  
  
The report includes a stack trace with the sub names.  
  
How to use?  
  
1.

```B4X
#AdditionalLib: KSCrash.framework.3  
#AdditionalLib: MessageUI.framework  
#AdditionalLib: SystemConfiguration.framework  
#AdditionalLib: libc++.dylib  
#AdditionalLib: libz.dylib  
'Add a reference to iCPP library!  
#IgnoreWarnings: 32
```

  
  
2.  
In Process\_Globals:  

```B4X
Private xui As XUI  
Private reporter As NativeObject
```

  
  
3. In Application\_Start:  

```B4X
Dim KSCrashVersion As Double = Me.as(NativeObject).RunMethod("getVersion", Null).AsNumber  
Log($"KSCrash version: $1.2{KSCrashVersion}"$)  
#if RELEASE  
If App.IsSimulator = False Then  
    CreateReporter  
    SendReportsIfNeeded  
End If  
#end if
```

  
  
As you can see in the code above, it will only be activated in release mode on a real device.  
  
4.  

```B4X
Sub SendReportsIfNeeded As ResumableSub  
    Dim no As NativeObject  
    no = no.Initialize("KSCrash").RunMethod("sharedInstance", Null)  
    Dim reports As Int = no.GetField("reportCount").AsNumber  
    Log($"Number of reports: ${reports}"$)  
    'Page1.Title = reports  
    If reports > 0 Then  
        Sleep(0)  
        Dim sf As Object = xui.Msgbox2Async("The app crashed last time it was launched. Please help us improve and send a crash report?", _  
            "", "Yes", "No", "", Null)  
        Wait For (sf) Msgbox_Result (Result As Int)  
        If Result = xui.DialogResponse_Positive Then  
            Dim nme As NativeObject = Me  
            nme.RunMethod("sendReports:", Array(reporter))  
        Else  
            no.RunMethod("deleteAllReports", Null)  
        End If  
    End If  
    Return True  
End Sub  
  
Sub CreateReporter  
    reporter = reporter.Initialize("KSCrashInstallationEmail").RunMethod("sharedInstance", Null)  
    Dim recipients As List = Array("ereluziel@gmail.com") '<——————————————-  change!!!!!!!!!!!!!  
    reporter.SetField("recipients", recipients)  
    reporter.SetField("reportStyle", 1) 'KSCrashEmailReportStyleApple  
    reporter.SetField("subject", "Crash Report")  
    reporter.SetField("message", "This Is a crash report")  
    reporter.SetField("filenameFmt", "crash-report-%d.txt.gz")  
    reporter.RunMethod("install", Null)  
End Sub  
  
#if OBJC  
#import <KSCrash/KSCrashFramework.h>  
- (double) getVersion {  
    return KSCrashFrameworkVersionNumber;  
}  
- (void) sendReports:(KSCrashInstallation*)installation {  
[installation sendAllReportsWithCompletion:^(NSArray* reports, BOOL completed, NSError* error)  
     {  
         if(completed)  
         {  
             NSLog(@"Sent %d reports", (int)[reports count]);  
         }  
         else  
         {  
             NSLog(@"Failed to send reports: %@", error);  
         }  
     }];  
}  
#End If
```

  
  
If you are using a local Mac then you need to download the framework and copy it to the libs folder: [www.b4x.com/b4i/files/KSCrash.zip](https://www.b4x.com/b4i/files/KSCrash.zip)  
  
**Don't forget to change the email address.**  
  
Example of handling the reports programmatically: <https://www.b4x.com/android/forum/threads/kscrash-simple-and-powerful-crash-reports-framework.120644/post-842685>