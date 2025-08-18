### Easy way to run threads by Semen Matusovskiy
### 09/07/2020
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/122021/)

If to forget about locking access to common variables, it's enough to use, for example, following OBJC subroutines:  

```B4X
#IF OBJC  
- (void) createThread: (NSObject *) someObject { [self performSelectorInBackground: @selector(threadBody:) withObject: someObject]; }  
- (void) threadBody:   (NSObject *) someObject { @autoreleasepool { [self _threadbody]; } }  
- (void) threadInfo:   (NSObject *) someObject { [self performSelectorOnMainThread: @selector (_threadinfo:) withObject: someObject waitUntilDone: NO]; }  
#End If
```

  
  
In Basic code you need to add subroutines:  
a) ThreadBody - runs in additional thread; when exit from this subroutine, a thread will be finished  
b) ThreadInfo - runs in main thread and receives information from additional thread.  
To start a new thread, add (for example, in Application\_Start):  

```B4X
    Dim noMe As NativeObject = Me  
    noMe.RunMethod ("createThread:", Array ("Something"))
```

  
  
A sample is attached. As you can see, you can click "Variant #1" or "Variant #2" (this is a main thread). In the same moment another thread is working and changes Label1.Text.