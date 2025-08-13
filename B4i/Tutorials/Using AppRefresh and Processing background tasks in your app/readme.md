### Using AppRefresh and Processing background tasks in your app by Mr.Coder
### 05/29/2025
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/167179/)

**Hi,  
  
This is a tutorial explaining how to use AppRefresh and Processing background tasks in your app.  
  
- First you need to add the UIBackgroundModes and the tasks identifiers **for each task** in B4iProject-Info.plist file :**  
  

```B4X
#PlistExtra: <key>UIBackgroundModes</key>  
#PlistExtra: <array>  
#PlistExtra:     <string>fetch</string>  
#PlistExtra:     <string>processing</string>  
#PlistExtra: </array>  
#PlistExtra: <key>BGTaskSchedulerPermittedIdentifiers</key>  
#PlistExtra: <array>  
#PlistExtra:   <string>com.yourcompany.apprefresh</string>  
#PlistExtra:   <string>com.yourcompany.processing</string>  
#PlistExtra: </array>
```

  
  
**BackgroundMode "fetch" is for** **AppRefresh background task and "com.yourcompany.apprefresh" is the AppRefresh background task id.  
BackgroundMode "processing" is for Processing background task and "com.yourcompany.processing" is the Processing background task id.  
  
- Add this inline objective-c code to your project :**  
  

```B4X
#if OBJC  
  
    #import <BackgroundTasks/BackgroundTasks.h>  
   
    // Background Processing Task  
    //*******************************************************************************************************//  
  
    - (void) registerBackgroundProcessingTask {  
  
       @try {  
  
            // Registering the task  
            BOOL success = [[BGTaskScheduler sharedScheduler] registerForTaskWithIdentifier:@"com.yourcompany.processing"  
                                                                  usingQueue:nil  
                                                               launchHandler:^(BGTask *task) {          
  
                [self handleBackgroundProcessingTask:task];  
  
            }];  
  
            [self.bi raiseUIEvent:nil event:@"registeringbackgroundprocessingtask_done::" params:@[@(NO),(@"")]];  
  
       } @catch (NSException *exception) {  
  
            [self.bi raiseUIEvent:nil event:@"registeringbackgroundprocessingtask_done::" params:@[@(NO),([exception reason])]];  
  
       }  
  
    }  
  
  
    - (void) scheduleBackgroundProcessingTask {  
  
       @try {  
  
            NSError *error = NULL;  
  
            // Cancel existing task (if any)  
            [BGTaskScheduler.sharedScheduler cancelTaskRequestWithIdentifier:@"com.yourcompany.processing"];  
  
            // New task  
            BGProcessingTaskRequest *request = [[BGProcessingTaskRequest alloc] initWithIdentifier:@"com.yourcompany.processing"];  
  
            // Specifying if the processing task requires a device connected to power.  
            request.requiresExternalPower = NO;  
  
            // Specifying if the processing task requires network connectivity.  
            request.requiresNetworkConnectivity = NO;  
  
            // The earliest date and time at which to run the task.  
            // Setting the property indicates that the background task shouldn’t start any earlier than this date.  
            // However, the system doesn’t guarantee launching the task at the specified date, but only that it won’t  
            // begin sooner.  
            // 900 seconds = 15 minutes  
            request.earliestBeginDate = [NSDate dateWithTimeIntervalSinceNow:900];  
  
            // Scheduling the task      
            BOOL success = [[BGTaskScheduler sharedScheduler] submitTaskRequest:request error:&error];  
  
            if (!success) {  
                [self.bi raiseUIEvent:nil event:@"schedulingbackgroundprocessingtask_done::" params:@[@(NO),([error localizedDescription])]];  
            } else {  
                [self.bi raiseUIEvent:nil event:@"schedulingbackgroundprocessingtask_done::" params:@[@(YES),(@"")]];  
            }  
  
       } @catch (NSException *exception) {  
  
            [self.bi raiseUIEvent:nil event:@"schedulingbackgroundprocessingtask_done::" params:@[@(NO),([exception reason])]];  
  
       }  
  
    }  
  
  
    - (void) handleBackgroundProcessingTask:(BGTask *)task {  
  
       @try {  
  
            [self scheduleBackgroundProcessingTask];  
  
            // Create an operation (or use your own logic)  
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];  
  
            queue.maxConcurrentOperationCount = 1;  
  
            __block NSString* taskResult = @"";  
  
            __weak typeof(self) weakSelf = self;  
  
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{              
  
                taskResult = [weakSelf _dobackgroundprocessingtask];  
  
            }];  
  
            task.expirationHandler = ^{      
                [operation cancel];                  
            };  
  
            operation.completionBlock = ^{  
  
                if (operation.isCancelled) {  
                    [self.bi raiseUIEvent:nil event:@"backgroundprocessingtask_done::" params:@[@(NO),(@"Background task expired.")]];  
                } else {  
                    if ([taskResult isEqualToString:@"Done."]) {  
                        [self.bi raiseUIEvent:nil event:@"backgroundprocessingtask_done::" params:@[@(YES),(@"")]];  
                    } else {  
                        [self.bi raiseUIEvent:nil event:@"backgroundprocessingtask_done::" params:@[@(NO),(taskResult)]];  
                    }  
                }  
  
                [task setTaskCompletedWithSuccess:!operation.isCancelled];  
  
            };  
  
            [queue addOperation:operation];  
  
       } @catch (NSException *exception) {  
  
            [self.bi raiseUIEvent:nil event:@"backgroundprocessingtask_done::" params:@[@(NO),([exception reason])]];  
  
            [task setTaskCompletedWithSuccess:NO];  
  
       }  
  
    }  
  
    //*******************************************************************************************************//  
  
    // Background App Refresh Task  
    //*******************************************************************************************************//  
  
    - (void) registerBackgroundAppRefreshTask {  
  
       @try {  
  
            // Registering the task  
            BOOL success = [[BGTaskScheduler sharedScheduler] registerForTaskWithIdentifier:@"com.yourcompany.apprefresh"  
                                                                  usingQueue:nil  
                                                               launchHandler:^(BGTask *task) {          
  
                [self handleBackgroundAppRefreshTask:task];  
  
            }];  
  
            [self.bi raiseUIEvent:nil event:@"registeringbackgroundapprefreshtask_done::" params:@[@(success),(@"")]];  
  
       } @catch (NSException *exception) {  
  
            [self.bi raiseUIEvent:nil event:@"registeringbackgroundapprefreshtask_done::" params:@[@(NO),([exception reason])]];  
  
       }  
  
    }  
  
  
    - (void) scheduleBackgroundAppRefreshTask {  
  
       @try {  
  
            NSError *error = NULL;  
  
            // Cancel existing task (if any)  
            [BGTaskScheduler.sharedScheduler cancelTaskRequestWithIdentifier:@"com.yourcompany.apprefresh"];  
  
            // New task  
            BGAppRefreshTaskRequest *request = [[BGAppRefreshTaskRequest alloc] initWithIdentifier:@"com.yourcompany.apprefresh"];  
  
            // The earliest date and time at which to run the task.  
            // Setting the property indicates that the background task shouldn’t start any earlier than this date.  
            // However, the system doesn’t guarantee launching the task at the specified date, but only that it won’t  
            // begin sooner.  
            // 900 seconds = 15 minutes  
            request.earliestBeginDate = [NSDate dateWithTimeIntervalSinceNow:900];  
  
            // Scheduling the task  
            BOOL success = [[BGTaskScheduler sharedScheduler] submitTaskRequest:request error:&error];  
  
            if (!success) {  
                [self.bi raiseUIEvent:nil event:@"schedulingbackgroundapprefreshtask_done::" params:@[@(NO),([error localizedDescription])]];  
            } else {  
                [self.bi raiseUIEvent:nil event:@"schedulingbackgroundapprefreshtask_done::" params:@[@(YES),(@"")]];  
            }  
  
       } @catch (NSException *exception) {  
  
            [self.bi raiseUIEvent:nil event:@"schedulingbackgroundapprefreshtask_done::" params:@[@(NO),([exception reason])]];  
  
       }  
  
    }  
  
  
    - (void) handleBackgroundAppRefreshTask:(BGTask *)task {  
  
       @try {  
  
            [self scheduleBackgroundAppRefreshTask];  
  
            // Create an operation (or use your own logic)  
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];  
  
            queue.maxConcurrentOperationCount = 1;  
  
            __block NSString* taskResult = @"";  
  
            __weak typeof(self) weakSelf = self;  
  
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{              
  
                taskResult = [weakSelf _dobackgroundapprefreshtask];  
  
            }];  
  
            task.expirationHandler = ^{      
                [operation cancel];                  
            };  
  
            operation.completionBlock = ^{  
  
                if (operation.isCancelled) {  
                    [self.bi raiseUIEvent:nil event:@"backgroundapprefreshtask_done::" params:@[@(NO),(@"Background task expired.")]];  
                } else {  
                    if ([taskResult isEqualToString:@"Done."]) {  
                        [self.bi raiseUIEvent:nil event:@"backgroundapprefreshtask_done::" params:@[@(YES),(@"")]];  
                    } else {  
                        [self.bi raiseUIEvent:nil event:@"backgroundapprefreshtask_done::" params:@[@(NO),(taskResult)]];  
                    }  
                }  
  
                [task setTaskCompletedWithSuccess:!operation.isCancelled];  
  
            };  
  
            [queue addOperation:operation];  
  
       } @catch (NSException *exception) {  
  
            [self.bi raiseUIEvent:nil event:@"backgroundapprefreshtask_done::" params:@[@(NO),([exception reason])]];  
  
            [task setTaskCompletedWithSuccess:NO];  
  
       }  
  
    }  
  
    //*******************************************************************************************************//  
  
#End If
```

  
  
**The 900 number inside handleBackgroundProcessingTask and handleBackgroundAppRefreshTask methods in the inline code :**  
  

```B4X
request.earliestBeginDate = [NSDate dateWithTimeIntervalSinceNow:900];
```

  
  
**is the number of seconds that indicates that the background task shouldn’t start any earlier than this number of seconds, however, the system doesn’t guarantee launching the task after this number of seconds, but only that it won’t begin sooner.  
  
Do not forget to change the tasks IDs in plist file and in the inline code with your tasks IDs.  
  
- Use this sub to register the AppRefresh background task :**  
  

```B4X
Private Sub RegisterBackgroundAppRefreshTask As ResumableSub  
   
    Try  
  
        Dim oMe As NativeObject = Me  
       
        oMe.RunMethod("registerBackgroundAppRefreshTask", Null)  
  
        Wait For RegisteringBackgroundAppRefreshTask_Done (Success As Boolean, Error As String)  
       
'        Log("AppRefresh Register Success=" & Success)  
'        Log("AppRefresh Register Error=" & Error)  
               
        Return Error  
       
    Catch  
       
        Log(LastException)  
       
        Return LastException.Message  
       
    End Try  
   
End Sub
```

  
  
**And you can call this sub in the Application\_Start event like this :**  
  

```B4X
RegisterBackgroundAppRefreshTask
```

  
  
**or like this :**  
  

```B4X
Wait For (RegisterBackgroundAppRefreshTask) Complete (RegisteringStatus As String)
```

  
  
**- Use this sub schedule the AppRefresh background task :**  
  

```B4X
Private Sub ScheduleBackgroundAppRefreshTask As ResumableSub  
   
    Try  
  
        Dim oMe As NativeObject = Me  
       
        oMe.RunMethod("scheduleBackgroundAppRefreshTask", Null)  
       
        Wait For SchedulingBackgroundAppRefreshTask_Done (Success As Boolean, Error As String)  
  
'        Log("Schedule AppRefresh Success=" & Success)  
'        Log("Schedule AppRefresh Error=" & Error)  
                       
        Return Error  
       
    Catch  
       
        Log(LastException)  
       
        Return LastException.Message  
       
    End Try  
   
End Sub
```

  
  
**And you can call this sub in Application\_Background event like this :**  
  

```B4X
ScheduleBackgroundAppRefreshTask
```

  
  
**or like this :**  
  

```B4X
Wait For (ScheduleBackgroundAppRefreshTask) Complete (SchedulingStatus As String)
```

  
  
**- Put your code that you want to execute in the AppRefresh background task inside this sub :**  
  

```B4X
Private Sub DoBackgroundAppRefreshTask As String  
  
    Try  
  
        'your AppRefresh background task code here.  
       
        Return "Done."  
       
    Catch  
               
        Return LastException.Message  
       
    End Try  
       
End Sub
```

  
  
**- You can check the result or the status of executing the AppRefresh background task code in this sub :**  
  

```B4X
Private Sub BackgroundAppRefreshTask_Done (Success As Boolean, Error As String)  
   
    Try  
  
'        Log("AppRefreshBackgroundTask Success=" & Success)  
'        Log("AppRefreshBackgroundTask Error=" & Error)  
  
        Return  
       
    Catch  
       
        Log(LastException)  
               
        Return  
       
    End Try  
   
End Sub
```

  
  
**- Use this sub to register the Processing background task :**  
  

```B4X
Private Sub RegisterBackgroundProcessingTask As ResumableSub  
   
    Try  
  
        Dim oMe As NativeObject = Me  
       
        oMe.RunMethod("registerBackgroundProcessingTask", Null)  
  
        Wait For RegisteringBackgroundProcessingTask_Done (Success As Boolean, Error As String)  
       
'        Log("Processing Register Success=" & Success)  
'        Log("Processing Register Error=" & Error)  
               
        Return Error  
       
    Catch  
       
        Log(LastException)  
       
        Return LastException.Message  
       
    End Try  
   
End Sub
```

  
  
**And you can call this sub in the Application\_Start event like this :**  
  

```B4X
RegisterBackgroundProcessingTask
```

  
  
**or like this :**  
  

```B4X
Wait For (RegisterBackgroundProcessingTask) Complete (RegisteringStatus As String)
```

  
  
**- Use this sub schedule the Processing background task :**  
  

```B4X
Private Sub ScheduleBackgroundProcessingTask As ResumableSub  
   
    Try  
  
        Dim oMe As NativeObject = Me  
       
        oMe.RunMethod("scheduleBackgroundProcessingTask", Null)  
       
        Wait For SchedulingBackgroundProcessingTask_Done (Success As Boolean, Error As String)  
  
'        Log("Schedule Processing Success=" & Success)  
'        Log("Schedule Processing Error=" & Error)  
                       
        Return Error  
       
    Catch  
       
        Log(LastException)  
       
        Return LastException.Message  
       
    End Try  
   
End Sub
```

  
  
**And you can call this sub in Application\_Background event like this :**  
  

```B4X
ScheduleBackgroundProcessingTask
```

  
  
**or like this :**  
  

```B4X
Wait For (ScheduleBackgroundProcessingTask) Complete (SchedulingStatus As String)
```

  
  
**- Put your code that you want to execute in the Processing background task inside this sub :**  
  

```B4X
Private Sub DoBackgroundProcessingTask As String  
  
    Try  
  
        'your Processing background task code here.  
       
        Return "Done."  
       
    Catch  
               
        Return LastException.Message  
       
    End Try  
       
End Sub
```

  
  
**- You can check the result or the status of executing the Processing background task code in this sub :**  
  

```B4X
Private Sub BackgroundProcessingTask_Done (Success As Boolean, Error As String)  
   
    Try  
  
'        Log("ProcessingBackgroundTask Success=" & Success)  
'        Log("ProcessingBackgroundTask Error=" & Error)  
  
        Return  
       
    Catch  
       
        Log(LastException)  
               
        Return  
       
    End Try  
   
End Sub
```

  
  
**In case if you use "Wait For" or "Sleep" or Loops inside the sub that doing the background work and it changed to ResumableSub then you can make this changes to make it work.  
  
- The changes in the inline objective-c code will be in **handleBackgroundProcessingTask** **and** **handleBackgroundAppRefreshTask** **methods only** :**  
  

```B4X
#if OBJC  
    
// Background Processing Task  
//*******************************************************************************************************//   
  
- (void) handleBackgroundAppRefreshTask:(BGTask *)task {  
  
   @try {  
         
        [self scheduleBackgroundAppRefreshTask];  
         
        [self _backgroundapprefreshtask_controller:task];  
  
        task.expirationHandler = ^{         
            [self _backgroundapprefreshtask_expired];                     
        };  
  
   } @catch (NSException *exception) {  
                         
        [self _backgroundapprefreshtask_expired];  
          
   }  
  
}  
  
- (void) handleBackgroundProcessingTask:(BGTask *)task {  
  
   @try {  
         
        [self scheduleBackgroundProcessingTask];  
         
        [self _backgroundprocessingtask_controller:task];  
  
        task.expirationHandler = ^{         
            [self _backgroundprocessingtask_expired];                     
        };  
  
   } @catch (NSException *exception) {  
                         
        [self _backgroundprocessingtask_expired];  
          
   }  
  
}  
  
//*******************************************************************************************************//   
  
#End If
```

  
  
**- The changes in b4i will be in the DoBackgroundAppRefreshTask and DoBackgroundProcessingTask subs and BackgroundAppRefreshTask\_Done and BackgroundProcessingTask\_Done subs will be replaced with another subs and we need two boolen variables with names "IsAppRefreshTaskExpired" and **"IsProcessingTaskExpired" in Process\_Globals and** we will use it to know when the system make the task expired and if the task expired we should stop the background work quickly like in seconds or the system will kill the app :**  
  

```B4X
Private Sub DoBackgroundAppRefreshTask  
  
    Try  
         
        'your sub code here  
         
        Sleep(10)  
         
        'Or  
         
        For I = 1 To 5  
         
        Next  
         
        If IsAppRefreshTaskExpired = False Then  
           CallSubDelayed(Me, "BackgroundAppRefreshTask_Done")  
        End If  
         
        Return  
         
    Catch  
         
        Log(LastException)  
  
        If IsAppRefreshTaskExpired = False Then  
           CallSubDelayed(Me, "BackgroundAppRefreshTask_Done")  
        End If  
                         
        Return  
         
    End Try  
         
End Sub
```

  
  

```B4X
Private Sub BackgroundAppRefreshTask_Controller (AppRefreshTask As Object)  
         
        Dim oAppRefreshTask As NativeObject = AppRefreshTask  
         
        IsAppRefreshTaskExpired = False  
         
        DoBackgroundAppRefreshTask  
         
        Wait For BackgroundAppRefreshTask_Done  
  
        If IsAppRefreshTaskExpired = True Then  
           oAppRefreshTask.RunMethod("setTaskCompletedWithSuccess:", Array(False))  
        Else  
           oAppRefreshTask.RunMethod("setTaskCompletedWithSuccess:", Array(True))  
        End If  
                 
        Return  
         
End Sub
```

  
  

```B4X
Private Sub DoBackgroundProcessingTask  
  
    Try  
         
        'your sub code here  
         
        Sleep(10)  
         
        'Or  
         
        For I = 1 To 5  
         
        Next  
         
        If IsProcessingTaskExpired = False Then  
           CallSubDelayed(Me, "BackgroundProcessingTask_Done")  
        End If  
         
        Return  
         
    Catch  
         
        Log(LastException)  
  
        If IsProcessingTaskExpired = False Then  
           CallSubDelayed(Me, "BackgroundProcessingTask_Done")  
        End If  
                         
        Return  
         
    End Try  
         
End Sub
```

  
  

```B4X
Private Sub BackgroundProcessingTask_Controller (ProcessingTask As Object)  
         
        Dim oProcessingTask As NativeObject = ProcessingTask  
         
        IsProcessingTaskExpired = False  
         
        DoBackgroundProcessingTask  
         
        Wait For BackgroundProcessingTask_Done  
  
        If IsProcessingTaskExpired = True Then  
           oProcessingTask.RunMethod("setTaskCompletedWithSuccess:", Array(False))  
        Else  
           oProcessingTask.RunMethod("setTaskCompletedWithSuccess:", Array(True))  
        End If  
                 
        Return  
         
End Sub
```

  
  

```B4X
Private Sub BackgroundProcessingTask_Expired  
         
        IsProcessingTaskExpired = True  
         
        CallSubDelayed(Me, "BackgroundProcessingTask_Done")        
         
        Return  
     
End Sub
```

  
  
**- I have tested the two ways and I found it working without problems, but the tasks it may not be started with the number of times you expect because the system is the one who decides when the task should start, relying on several factors.  
  
- I hope this tutorial is useful to you.**