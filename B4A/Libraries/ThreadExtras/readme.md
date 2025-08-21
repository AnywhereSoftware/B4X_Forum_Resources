### ThreadExtras by warwound
### 11/01/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/111009/)

ThreadExtras  
  
This is a simple library i want to share.  
It wraps three thread related java classes:  

- [AsyncTask](https://developer.android.com/reference/android/os/AsyncTask)
**Events:**

- **Cancelled** (Result As Object)
- **DoInBackground** (Params() As Object)
- **PostExecute** (Result As Object)
- **PreExecute**
- **ProgressUpdate** (Progress() As Object)

**Fields:**

- **STATUS\_PENDING As android.os.AsyncTask.Status**
*Indicates that the task has not been executed yet.*- **STATUS\_FINISHED As android.os.AsyncTask.Status**
*Indicates that event 'PostExecute' has been raised and has completed execution.*- **STATUS\_RUNNING As android.os.AsyncTask.Status**
*Indicates that the task is running.*
**Methods:**

- **Execute** (Params() As Object)
*Executes the task with the specified parameters.*- **Cancel** (MayInterruptIfRunning As Boolean) **As Boolean**
*Attempts to cancel execution of this task.  
 This attempt will fail if the task has already completed, already been cancelled, or could not be cancelled for some other reason.  
 If successful, and this task has not started when cancel is called, this task should never run.  
 If the task has already started, then the MayInterruptIfRunning parameter determines whether the thread executing this task should be interrupted in an attempt to stop the task.  
  
 Calling this method will result in the 'Cancelled' event being raised once your 'DoInBackground' callback has completed.  
 Your 'DoInBackground' callback can call the IsCancelled method to determine if the task has been cancelled whilst in progress.  
 Calling this method ensures that the 'PostExecute' event is never raised.  
  
 Cancel returns True if the task was cancelled, otherwise False.*- **IsCancelled As Boolean**
*Returns True if the task was cancelled before it completed normally.*- **GetThread As Thread**
*Provides access to the java Thread.*- **IsInitialized As Boolean**
- **Initialize** (EventName As String)
*Initialize the AsyncTask.  
 A MissingCallbackException will be raised if no callback sub is found for the 'DoInBackground' event.*- **PublishProgress** (Progress() As Object)
*This method can be invoked from the 'DoInBackground' callback to publish updates on the UI thread while the background computation is still running.  
 The 'ProgressUpdate' callback will be called on the UI thread and passed the Progress array.*- **Get As Object**
*Waits if necessary for the computation to complete, and then retrieves its result.*- **SetSynchronizedObject** (SynchronizedObject As Object)
*Sets an Object to synchronize the background thread to.  
 Default value is Null.*- **Get2** (TimeoutMillis As long) **As Object**
*Waits if necessary for at most the given time for the computation to complete, and then retrieves its result.*- **GetStatus As android.os.AsyncTask.Status**
*Returns the current status of this task.*
- [Process](https://docs.oracle.com/javase/8/docs/api/java/lang/Process.html)
**Fields:**

- **THREAD\_PRIORITY\_LESS\_FAVORABLE As Int**
*Minimum increment to make a priority less favorable.*- **THREAD\_PRIORITY\_FOREGROUND As Int**
*Standard priority of threads that are currently running a user interface that the user is interacting with.  
 Applications can not normally change to this priority; the system will automatically  
 adjust your application threads as the user moves through the UI.*- **THREAD\_PRIORITY\_URGENT\_AUDIO As Int**
*Standard priority of the most important audio threads. Applications can not normally change to this priority.*- **THREAD\_PRIORITY\_DEFAULT As Int**
*Standard priority of application threads.*- **THREAD\_PRIORITY\_DISPLAY As Int**
*Standard priority of system display threads, involved in updating the user interface.  
 Applications can not normally change to this priority.*- **THREAD\_PRIORITY\_MORE\_FAVORABLE As Int**
*Minimum increment to make a priority more favorable.*- **THREAD\_PRIORITY\_AUDIO As Int**
*Standard priority of audio threads. Applications can not normally change to this priority.*- **THREAD\_PRIORITY\_LOWEST As Int**
*Lowest available thread priority. Only for those who really, really don't want to run if anything else is happening.*- **THREAD\_PRIORITY\_URGENT\_DISPLAY As Int**
*Standard priority of the most important display threads, for compositing the screen and retrieving input events.  
 Applications can not normally change to this priority.*- **THREAD\_PRIORITY\_BACKGROUND As Int**
*Standard priority background threads. This gives your thread a slightly lower than normal priority,  
 so that it will have less chance of impacting the responsiveness of the user interface.*
**Methods:**

- **SetThreadPriority** (Priority As Int)
*Set the priority of the calling thread.  
 Priority - A Linux priority level, from -20 for highest scheduling priority to 19 for lowest scheduling priority.*
- [Runnable](https://docs.oracle.com/javase/7/docs/api/java/lang/Runnable.html)
**Events:**

- **Complete** (Result As Object)

**Methods:**

- **IsInterrupted As Boolean**
- **Start**
- **IsInitialized As Boolean**
- **Initialize** (EventName As String, ClassInstance As Object, SubName As String, Args() As Object)
- **Interrupt**

**Properties:**

- **StopFlag As Boolean**

  
An example using AsyncTask can be found in this thread:  
<https://www.b4x.com/android/forum/threads/asynctask.84109/#content>  
This updated version of AsyncTask should be compatible with the example for the old version.  
  
And an example which uses Runnable can be found in this thread:  
<https://www.b4x.com/android/forum/threads/namedpipe.111010/#post-692512>