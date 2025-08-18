### Reading the app logs directly on the device by Erel
### 07/29/2021
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/132979/)

iReleaseLogger was built to allow reading the logs in release mode: [iReleaseLogger - Read the logs in release mode](https://www.b4x.com/android/forum/threads/51164/#content)    
It sends the logs to the PC, over the local network.  
  
There are however cases where there is no PC or no network. You can follow these instructions to display the logs inside your app. It depends on iReleaseLogger, which is based on private APIs so don't submit your app with this library checked.  
  
Instructions:  
1. Add a TextView to the layout. Better to set its Editable property to False. The logs will appear in the TextView. Name it TextViewLogs (you can change it):  
2. Add a reference to iReleaseLogger and iNetwork.  
3. Add this code at the end of Main:  

```B4X
Private Sub Log_Log(Message As String)  
    If Message.Contains("recvfrom") Then Return  
    TextViewLogs .Text = TextViewLogs .Text & CRLF & Message  
    TextViewLogs .As(TextView).ScrollTo(TextViewLogs .Text.Length)  
End Sub  
  
#if OBJC  
@end  
@interface b4i_main (logger) <B4ILogger>  
@end  
@implementation b4i_main (logger)  
- (void) Log:(NSString *)message :(NSString*)prefix {  
    [self.bi raiseEventFromDifferentThread:nil event:@"log_log:" params:@[message]];  
}  
- (void) test {  
    NSLog(@"this is a test");  
}  
#End If
```

  
4. Add in Application\_Start:  

```B4X
Logger.Initialize("127.0.0.1", 5000)  
Dim no As NativeObject  
no.Initialize("B4I").RunMethod("shared", Null).SetField("logger", Me)  
Me.As(NativeObject).RunMethod("test", Null)
```

  
  
  
A B4XPages example is attached.