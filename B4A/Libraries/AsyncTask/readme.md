### AsyncTask by warwound
### 11/01/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/84109/)

This library wraps the android [AsyncTask](https://developer.android.com/reference/android/os/AsyncTask.html) class.  
  
> AsyncTask enables proper and easy use of the UI thread.  
> This class allows you to perform background operations and publish results on the UI thread without having to manipulate threads and/or handlers.  
>   
> An asynchronous task is defined by a computation that runs on a background thread and whose result is published on the UI thread.  
> An asynchronous task is defined by 3 generic types, called **Params**, **Progress** and **Result**, and 4 steps, called **PreExecute**, **DoInBackground**, **ProgressUpdate** and **PostExecute**.

  
Here's the documentation for my b4a implementation of AsyncTask:  
  
**AsyncTask  
Author:** Martin Pearman  
**Version:** 1  

- **AsyncTask**
Events:

- **Cancelled** (Result As Object)
- **DoInBackground** (Params() As Object) As Object
- **PostExecute** (Result As Object)
- **PreExecute**
- **ProgressUpdate** (Progress() As Object)

**Fields:**

- **STATUS\_FINISHED As Status**
*Indicates that event 'PostExecute' has been raised and has completed execution.*- **STATUS\_PENDING As Status**
*Indicates that the task has not been executed yet.*- **STATUS\_RUNNING As Status**
*Indicates that the task is running.*
**Methods:**

- **Cancel** (MayInterruptIfRunning As Boolean) **As Boolean**
*Attempts to cancel execution of this task.  
 This attempt will fail if the task has already completed, already been cancelled, or could not be cancelled for some other reason.  
 If successful, and this task has not started when cancel is called, this task should never run.  
 If the task has already started, then the MayInterruptIfRunning parameter determines whether the thread executing this task should be interrupted in an attempt to stop the task.  
  
 Calling this method will result in the 'Cancelled' event being raised once your 'DoInBackground' callback has completed.  
 Your 'DoInBackground' callback can call the IsCancelled method to determine if the task has been cancelled whilst in progress.  
 Calling this method ensures that the 'PostExecute' event is never raised.  
  
 Cancel returns True if the task was cancelled, otherwise False.*- **Execute** (Params() As Object)
*Executes the task with the specified parameters.*- **Get As Object**
*Waits if necessary for the computation to complete, and then retrieves its result.*- **Get2** (TimeoutMillis As Long) **As Object**
*Waits if necessary for at most the given time for the computation to complete, and then retrieves its result.*- **GetStatus As Status**
*Returns the current status of this task.*- **Initialize** (EventName As String)
*Initialize the AsyncTask.  
 A MissingCallbackException will be raised if no callback sub is found for the 'DoInBackground' event.*- **IsCancelled As Boolean**
*Returns True if the task was cancelled before it completed normally.*- **IsInitialized As Boolean**
- **PublishProgress** (Progress() As Object)
*This method can be invoked from the 'DoInBackground' callback to publish updates on the UI thread while the background computation is still running.  
 The 'ProgressUpdate' callback will be called on the UI thread and passed the Progress array.*
  
For anyone that's interested, here's the source code for the library's only class:  
  

```B4X
import java.util.concurrent.ExecutionException;  
import java.util.concurrent.TimeUnit;  
import java.util.concurrent.TimeoutException;  
  
import anywheresoftware.b4a.AbsObjectWrapper;  
import anywheresoftware.b4a.BA;  
  
@BA.Events(values={  
  "Cancelled(Result As Object)",  
  "DoInBackground(Params() As Object) As Object",  
  "PostExecute(Result As Object)",  
  "PreExecute",  
  "ProgressUpdate(Progress() As Object)"  
})  
@BA.ShortName("AsyncTask")  
public class AsyncTask extends AbsObjectWrapper<AsyncTask.AsyncTaskImpl> {  
  
  /**  
  * Indicates that event 'PostExecute' has been raised and has completed execution.  
  */  
  public static final android.os.AsyncTask.Status STATUS_FINISHED=android.os.AsyncTask.Status.FINISHED;  
  
  /**  
  * Indicates that the task has not been executed yet.  
  */  
  public static final android.os.AsyncTask.Status STATUS_PENDING=android.os.AsyncTask.Status.PENDING;  
  
  /**  
  * Indicates that the task is running.  
  */  
  public static final android.os.AsyncTask.Status STATUS_RUNNING=android.os.AsyncTask.Status.RUNNING;  
  
  /**  
  * Attempts to cancel execution of this task.  
  * This attempt will fail if the task has already completed, already been cancelled, or could not be cancelled for some other reason.  
  * If successful, and this task has not started when cancel is called, this task should never run.  
  * If the task has already started, then the MayInterruptIfRunning parameter determines whether the thread executing this task should be interrupted in an attempt to stop the task.  
  *  
  * Calling this method will result in the 'Cancelled' event being raised once your 'DoInBackground' callback has completed.  
  * Your 'DoInBackground' callback can call the IsCancelled method to determine if the task has been cancelled whilst in progress.  
  * Calling this method ensures that the 'PostExecute' event is never raised.  
  *  
  * Cancel returns True if the task was cancelled, otherwise False.  
  */  
  public boolean Cancel(boolean MayInterruptIfRunning){  
  return getObject().cancel(MayInterruptIfRunning);  
  }  
  
  /**  
  * Executes the task with the specified parameters.  
  */  
  public void Execute(Object[] Params){  
  getObject().execute(Params);  
  }  
  
  /**  
  * Waits if necessary for the computation to complete, and then retrieves its result.  
  */  
  public Object Get() throws ExecutionException, InterruptedException {  
  return getObject().get();  
  }  
  
  /**  
  * Waits if necessary for at most the given time for the computation to complete, and then retrieves its result.  
  */  
  public Object Get2(long TimeoutMillis) throws InterruptedException, ExecutionException, TimeoutException {  
  return getObject().get(TimeoutMillis, TimeUnit.MILLISECONDS);  
  }  
  
  /**  
  * Returns the current status of this task.  
  */  
  public android.os.AsyncTask.Status GetStatus(){  
  return getObject().getStatus();  
  }  
  
  /**  
  * Initialize the AsyncTask.  
  * A MissingCallbackException will be raised if no callback sub is found for the 'DoInBackground' event.  
  */  
  public void Initialize(BA ba, String EventName) throws MissingCallbackException {  
  setObject(new AsyncTaskImpl(ba, EventName));  
  }  
  
  /**  
  * Returns True if the task was cancelled before it completed normally.  
  */  
  public boolean IsCancelled(){  
  return getObject().isCancelled();  
  }  
  
  /**  
  * This method can be invoked from the 'DoInBackground' callback to publish updates on the UI thread while the background computation is still running.  
  * The 'ProgressUpdate' callback will be called on the UI thread and passed the Progress array.  
  */  
  public void PublishProgress(Object[] Progress){  
  getObject().publishProgress2(Progress);  
  }  
  
  @BA.Hide  
  public static final class AsyncTaskImpl extends android.os.AsyncTask<Object, Object, Object>{  
  
  private static final String EVENT_NAME_CANCELLED="Cancelled";  
  private static final String EVENT_NAME_DO_IN_BACKGROUND="DoInBackground";  
  private static final String EVENT_NAME_POST_EXECUTE="PostExecute";  
  private static final String EVENT_NAME_PRE_EXECUTE="PreExecute";  
  private static final String EVENT_NAME_PROGRESS_UPDATE="ProgressUpdate";  
  
  private static final String EXCEPTION_MESSAGE_MISSING_CALLBACK="DoInBackground callback sub not found: ";  
  
  private final BA ba;  
  
  private final String eventNameCancelled;  
  private final String eventNameDoInBackground;  
  private final String eventNamePostExecute;  
  private final String eventNamePreExecute;  
  private final String eventNameProgressUpdate;  
  
  private final boolean subExistsCancelled;  
  private final boolean subExistsPostExecute;  
  private final boolean subExistsPreExecute;  
  private final boolean subExistsProgressUpdate;  
  
  public AsyncTaskImpl(BA ba, String EventName) throws MissingCallbackException {  
  super();  
  this.ba=ba;  
  
  eventNameCancelled=getEventName(EventName, EVENT_NAME_CANCELLED);  
  subExistsCancelled=ba.subExists(eventNameCancelled);  
  
  eventNameDoInBackground=getEventName(EventName, EVENT_NAME_DO_IN_BACKGROUND);  
  
  eventNamePostExecute=getEventName(EventName, EVENT_NAME_POST_EXECUTE);  
  subExistsPostExecute=ba.subExists(eventNamePostExecute);  
  
  eventNamePreExecute=getEventName(EventName, EVENT_NAME_PRE_EXECUTE);  
  subExistsPreExecute=ba.subExists(eventNamePreExecute);  
  
  eventNameProgressUpdate=getEventName(EventName, EVENT_NAME_PROGRESS_UPDATE);  
  subExistsProgressUpdate=ba.subExists(eventNameProgressUpdate);  
  
  if(ba.subExists(eventNameDoInBackground)==false){  
  throw new MissingCallbackException(new StringBuilder(EXCEPTION_MESSAGE_MISSING_CALLBACK).append(eventNameDoInBackground).toString());  
  }  
  }  
  
  private String getEventName(String baseEventName, String event){  
  return new StringBuilder(baseEventName).append('_').append(event).toString().toLowerCase(BA.cul);  
  }  
  
  @Override  
  protected Object doInBackground(Object… params) {  
  return ba.raiseEvent(AsyncTaskImpl.this, eventNameDoInBackground, new Object[]{params});  
  }  
  
/*  @Override  
  protected void onCancelled() {}*/  
  
  @Override  
  protected void onCancelled(Object result) {  
  if(subExistsCancelled) {  
  ba.raiseEvent(AsyncTaskImpl.this, eventNameCancelled, new Object[]{result});  
  }  
  }  
  
  @Override  
  protected void onPostExecute(Object result) {  
  if(subExistsPostExecute) {  
  ba.raiseEvent(AsyncTaskImpl.this, eventNamePostExecute, new Object[]{result});  
  }  
  }  
  
  @Override  
  protected void onPreExecute() {  
  if(subExistsPreExecute){  
  ba.raiseEvent(AsyncTaskImpl.this, eventNamePreExecute, new Object[0]);  
  }  
  }  
  
  
  @Override  
  protected void onProgressUpdate(Object… progress) {  
  if(subExistsProgressUpdate) {  
  ba.raiseEvent(AsyncTaskImpl.this, eventNameProgressUpdate, new Object[]{progress});  
  }  
  }  
  
  public void publishProgress2(Object[] values){  
  publishProgress(values);  
  }  
  
  }  
  
  @BA.Hide  
  public static final class MissingCallbackException extends Exception{  
  public MissingCallbackException(String message){  
  super(message);  
  }  
  }  
}
```

  
  
I implement AsyncTask as AsyncTaskImpl and then wrap instances of AsyncTaskImpl in the library.  
AsyncTaskImpl simply relays the android callbacks to b4a by raising it's various events.  
  
I've put together a basic usage example, here i created a class named MyAsyncTask:  
  

```B4X
#Event: TaskCancelled(ValueReached as Long)  
#Event: TaskComplete(ValueReached as Long)  
#Event: TaskProgress(PercentProgress as Int)  
  
Sub Class_Globals  
   Private mAsyncTask As AsyncTask  
   Private mEventName As String  
   Private mParent As Object  
End Sub  
  
public Sub Cancel(MayInterruptIfRunning As Boolean)  
   mAsyncTask.Cancel(MayInterruptIfRunning)  
End Sub  
  
Public Sub Initialize(Parent As Object, EventName As String)  
   mAsyncTask.Initialize("mAsyncTask")  
   mEventName=EventName  
   mParent=Parent  
End Sub  
  
'   execute the async task, start counting from zero up to the Target value  
public Sub Execute(Target As Long, PublishProgress As Boolean)  
   mAsyncTask.Execute(Array As Object(Target, PublishProgress))  
End Sub  
  
private Sub mAsyncTask_Cancelled(Result As Object)  
   '   this sub is called on the Main UI thread  
   '   adding this callback sub is optional  
   Log("mAsyncTask_Cancelled")  
   
   Dim ValueReached As Long=Result  
   RaiseEvent("TaskCancelled", ValueReached)  
End Sub  
  
private Sub mAsyncTask_DoInBackground(Params() As Object) As Object  
   '   this sub is called on a background thread  
   '   any other methods called from this method will execute in the same background thread  
   '   do not attempt to update the UI from this sub  
   '   adding this callback sub is NOT optional  
   Log("mAsyncTask_DoInBackground")  
   
   Dim PercentProgress As Int=0  
   Dim PublishProgress As Boolean=Params(1)  
   Dim Start As Long=0  
   Dim Stop As Long=Params(0)  
   
   Do While Start<Stop And Not(mAsyncTask.IsCancelled)  
     Start=Start+1  
     Dim NewPercentProgress As Int=(Start/Stop)*100  
     If PublishProgress And PercentProgress<>NewPercentProgress Then  
       '   publish periodical progress  
       PercentProgress=NewPercentProgress  
       mAsyncTask.PublishProgress(Array As Object(PercentProgress))  
     End If  
   Loop  
   
   Dim Result As Object=Start  
   Return Result  
End Sub  
  
private Sub mAsyncTask_PostExecute(Result As Object)  
   '   this sub is called on the Main UI thread  
   '   adding this callback sub is optional  
   Log("mAsyncTask_PostExecute")  
   
   '   the AsyncTask library is compatible with android API 13+  
   '   if you are targetting older versions of the API then apply this (commented out) workaround before executing any further code in this sub:  
   
'   If mAsyncTask.IsCancelled Then  
'     mAsyncTask_Cancelled(Result)  
'     Return  
'   End If  
   
   Dim ValueReached As Long=Result  
   RaiseEvent("TaskComplete", ValueReached)  
End Sub  
  
private Sub mAsyncTask_PreExecute  
   '   this sub is called on the Main UI thread  
   '   adding this callback sub is optional  
   Log("mAsyncTask_PreExecute")  
End Sub  
  
private Sub mAsyncTask_ProgressUpdate(Progress() As Object)  
   '   this sub is called on the Main UI thread  
   '   adding this callback sub is optional  
   Log("mAsyncTask_ProgressUpdate")  
   
   Dim PercentProgress As Int=Progress(0)  
   RaiseEvent("TaskProgress", PercentProgress)  
End Sub  
  
private Sub RaiseEvent(Event As String, Value As Object)  
   Dim EventName As String=mEventName&"_"&Event  
   If SubExists(mParent, EventName) Then  
     CallSub2(mParent, EventName, Value)  
   Else  
     Log("Ignoring event "&EventName&" as no callback sub SubExists")  
   End If  
End Sub
```

  
  
Then in my activity:  
  

```B4X
Sub Process_Globals  
   Private COUNT_TO_VALUE As Long=99000000  
   Private PUBLISH_PROGRESS As Boolean=True  
   Private MyAsyncTask1 As MyAsyncTask  
End Sub  
  
Sub Globals  
   
   Private LabelProgress As Label  
   Private LabelResult As Label  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   Activity.LoadLayout("Layout1")  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub ButtonCancel_Click  
   If MyAsyncTask1.IsInitialized Then  
     MyAsyncTask1.Cancel(True)  
   End If  
End Sub  
  
Sub ButtonStart_Click  
   LabelProgress.Text=""  
   LabelResult.Text=""  
   If Not(MyAsyncTask1.IsInitialized) Then  
     MyAsyncTask1.Initialize(Me, "MyAsyncTask1")  
     MyAsyncTask1.Execute(COUNT_TO_VALUE, PUBLISH_PROGRESS)  
   End If  
End Sub  
  
Sub MyAsyncTask1_TaskCancelled(ValueReached As Long)  
   LabelResult.Text="The task was cancelled, a value of "&ValueReached&" was reached, target was "&COUNT_TO_VALUE  
   Dim MyAsyncTask1 As MyAsyncTask  
End Sub  
  
Sub MyAsyncTask1_TaskComplete(ValueReached As Long)  
   LabelResult.Text="The task completed, a value of "&ValueReached&" was reached, target was "&COUNT_TO_VALUE  
   Dim MyAsyncTask1 As MyAsyncTask  
End Sub  
  
Sub MyAsyncTask1_TaskProgress(PercentProgress As Int)  
   LabelProgress.Text = PercentProgress & "%"  
End Sub
```

  
  
I click start and my class starts counting from zero to 99000000.  
A label displays the current percentage counted from zero to 99000000.  
I can let the task complete or i can cancel it.  
Upon completion or cancellation another label shows how far the task counted to.  
  
Let the task complete and the log will show something like:  
> mAsyncTask\_PreExecute  
> mAsyncTask\_DoInBackground  
> mAsyncTask\_ProgressUpdate (repeated 100 times)  
> mAsyncTask\_PostExecute

  
Cancel the task and you'll see:  
> mAsyncTask\_PreExecute  
> mAsyncTask\_DoInBackground  
> mAsyncTask\_ProgressUpdate (repeated ? times)  
> mAsyncTask\_Cancelled

  
Adding callback subs for the library's events is optional except for DoInBackground - you must implement a callback for this event.  
I'll put together another (more useful) example and post that shortly.  
  
Library files and b4a example project are attached.  
  
**Check out my new [ThreadExtras](https://www.b4x.com/android/forum/threads/threadextras.111009/) to get the AsyncTask library.**  
  
Martin.