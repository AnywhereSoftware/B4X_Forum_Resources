### VOSK / STT crash issue by xldaedalus
### 06/03/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/161504/)

Hi, I'm a newbie to B4A / Android.  
  
I'm writing an STT TTS app and I'm having an issue above my current ability. I downloaded and installed the example VOSK app example (1.5?) created so well by BISWAJIT and I've built on that. About 90% of the time, after the has recognized, parsed the words, structured a text string response and reads it as speech, the app crashes on returning to listen  
  
Here I think  
  
  
Sub STT\_ReadyToListen  
 Log("STT ready")  
 STT.stop  
 If STT.startListening(-1) Then  
 StartBtn.Enabled = False  
 StopBtn.Enabled = True  
' Log("Started…")  
 Else  
 Log("Failed to Start…") '<– STT.startlistening is returning as FALSE  
 MsgboxAsync("Failed to Start","")  
 End If  
End Sub  
  
These are the TTS settings  
  
 tts.Initialize("tts")  
 tts.SpeechRate = .8 '1.4  
 tts.Pitch = .90 '1.2  
  
And I'm using the voice model that is part of the Android System\Languages\Install voice data\english\voice VII  
  
The"listening" never starts, STOP button reads "failed to stop" – so I have to recompile to try app again.   
  
I tried adding some delays, as the STT.stop was still busy (the 93 frames?) so STT.startlistening couldn't start?  
  
I can't find what "skipped 93 "frames" means - I assume it has something to do with audio playback?  
  
This is the error message, unfiltered log for full stack trace (I think)  
  
**Skipped 93 frames! The application may be doing too much work on its main thread.**    
Davey! duration=1571ms; Flags=0, FrameTimelineVsyncId=2628745, IntendedVsync=1142975867714645, Vsync=1142977421674802, InputEventId=0, HandleInputStart=1142977431586017, AnimationStart=1142977431589663, PerformTraversalsStart=1142977431592736, DrawStart=1142977432164299, FrameDeadline=1142975884381311, FrameInterval=1142977430893049, FrameStartTime=16709249, SyncQueued=1142977432885653, SyncStart=1142977433000757, IssueDrawCommandsStart=1142977433244455, SwapBuffers=1142977436815549, FrameCompleted=1142977439539299, DequeueBufferDuration=39323, QueueBufferDuration=1307812, GpuCompleted=1142977439539299, SwapBuffersCompleted=1142977439532319, DisplayPresentTime=0, CommandSubmissionCompleted=1142977436815549,   
Estimate():language\_model.cc:142) Estimating language model with ngram-order=2, discount=0.5  
OutputToFst():language\_model.cc:209) Created language model with 54 states and 106 arcs.  
**Unexpected event (missing RaiseSynchronousEvents): stt\_readytolisten**  
Check the unfiltered logs for the full stack trace.  
java.lang.Exception: Stack trace  
 at java.lang.Thread.dumpStack(Thread.java:1615)  
 at anywheresoftware.b4a.shell.Shell.raiseEventImpl(Shell.java:314)  
 at anywheresoftware.b4a.shell.Shell.raiseEvent(Shell.java:255)  
 at java.lang.reflect.Method.invoke(Native Method)  
 at anywheresoftware.b4a.ShellBA.raiseEvent2(ShellBA.java:157)  
 at anywheresoftware.b4a.BA.raiseEvent(BA.java:201)  
 at com.biswajit.vosk.SpeechToText.prepareMicrophone(SpeechToText.java:116)  
 at b4a.example.speechtotext$ResumableSub\_speak\_now.resume(speechtotext.java:664)  
 at anywheresoftware.b4a.shell.DebugResumableSub$DelegatableResumableSub.resumeAsUserSub(DebugResumableSub.java:48)  
 at java.lang.reflect.Method.invoke(Native Method)  
 at anywheresoftware.b4a.shell.Shell.runMethod(Shell.java:732)  
 at anywheresoftware.b4a.shell.Shell.raiseEventImpl(Shell.java:348)  
 at anywheresoftware.b4a.shell.Shell.raiseEvent(Shell.java:255)  
 at java.lang.reflect.Method.invoke(Native Method)  
 at anywheresoftware.b4a.ShellBA.raiseEvent2(ShellBA.java:157)  
 at anywheresoftware.b4a.BA.raiseEvent2(BA.java:205)  
 at anywheresoftware.b4a.BA.raiseEvent(BA.java:201)  
 at anywheresoftware.b4a.shell.DebugResumableSub$DelegatableResumableSub.resume(DebugResumableSub.java:43)  
 at anywheresoftware.b4a.keywords.Common$14.run(Common.java:1748)  
 at android.os.Handler.handleCallback(Handler.java:942)  
 at android.os.Handler.dispatchMessage(Handler.java:99)  
 at android.os.Looper.loopOnce(Looper.java:201)  
 at android.os.Looper.loop(Looper.java:288)  
 at android.app.ActivityThread.main(ActivityThread.java:7920)  
  
Compiling with B4A 12.8 Java 14.0.2, running app on NOKIA C210 Android smart phone running Android 13  
  
Any suggestions / help would be very much appreciated