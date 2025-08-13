### Service Modules by Erel
### 02/07/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/7542/)

**This is an old tutorial. Most of the information here is no longer correct.**  
  
[MEDIA=vimeo]255402345[/MEDIA]  
  
  
Basic4android v1.2 adds support for Service modules.  
Service modules play an important role in the application and process life cycle.  
Start with this tutorial if you haven't read it before: [Android Process and activities life cycle](http://www.b4x.com/forum/basic4android-getting-started-tutorials/6487-android-process-activities-life-cycle.html)  
Code written in an activity module is paused once the activity is not visible.  
So by only using activities it is not possible to run any code while your application is not visible.  
Services life cycle is (almost) not affected by the current visible activity. This allows you to run tasks in the background.  
Services usually use the status bar notifications to interact with the user. Services do not have any other visible elements. Services also cannot show any dialog (except of toast messages).  
Note that when an error occurs in a service code you will not see the "Do you want to continue?" dialog. Android's regular "Process has crashed" message will appear instead.  
  
Before delving into the details I would like to say that **using services is simpler than it may first sound. In fact for many tasks it is easier to work with a service instead of an activity** as a service is not paused and resumed all the time and services are not recreated when the user rotates the screen. There is nothing special with code written in service.  
Code in a service module runs in the same process and the same thread as all other code.  
  
It is important to understand how Android chooses which process to kill when it is low on memory (a new process will later be created as needed).  
A process can be in one of the three following states:  
- Foreground - The user currently sees one of the process activities.  
- Background - None of the activities of the process are visible, however there is a started service.  
- Paused - There are no visible activities and no started services.  
  
Paused processes are the first to be killed when needed. If there is still not enough memory, background processes will be killed.  
Foreground processes will usually not be killed.  
  
As you will soon see a service can also bring a process to the foreground.  
  
Adding a service module is done by choosing Project - Add New Module - Service Module.  
The template for new services is:  

```B4X
Sub Process_Globals  
  
End Sub  
  
Sub Service_Create  
  
End Sub  
  
Sub Service_Start (StartingIntent As Intent)  
  
End Sub  
  
Sub Service_Destroy  
  
End Sub
```

**Sub Process\_Globals** is the place to declare the service global variables. There is no other Globals sub like in Activity as Service doesn't support Activity objects.  
Sub process globals should only be used to declare variables. It should not run any other code as it might fail. This is true for other modules as well.  
Note that Process\_Global variables are kept as long as the process runs and are accessible from other modules.  
  
**Sub Service\_Create** is called when the service is first started. This is the place to initialize and set the process global variables. Once a service is started it stays alive until you call StopService or until the whole process is destroyed.  
**Sub Service\_Start** is called **each time** you call StartService (or StartServiceAt). When this subs runs the process is moved to the foreground state. Which means that the OS will not kill your process until this sub finishes running. If you want to run some code every couple of minutes / hours you should schedule the next task with StartServiceAt inside this sub.  
  
**Sub Service\_Destroy** is called when you call StopService. The service will not be running after this sub until you call StartService again (which will run Sub Service\_Create followed by Sub Service\_Start).  
**Service use cases**  
  
As I see it there are four main use cases for services.  
- Separating UI code with "business" or logic code. Writing the non-UI code in a service is easier than implementing it inside an Activity module as the service is not paused and resumed and it is usually will not be recreated (like an Activity).  
You can call StartService during Activity\_Create and from now on work with the service module.  
A good design is to make the activity fetch the required data from the service in Sub Activity\_Resume. The activity can fetch data stored in a process global variable or it can call a service Sub with CallSub method.  
  
- Running a long operation. For example downloading a large file from the internet. In this case you can call Service.StartForeground (from the service module). This will move your activity to the foreground state and will make sure that the OS doesn't kill it. Make sure to eventually call Service.StopForeground.  
  
- Scheduling a repeating task. By calling StartServiceAt you can schedule your service to run at a specific time. You can call StartServiceAt in Sub Service\_Start to schedule the next time and create a repeating task (for example a task that checks for updates every couple of minutes).  
  
- Run a service after boot. By setting the #StartAtBoot attribute to True, our service will run after boot is completed.  
**Notifications**  
  
Status bar notifications can be displayed by activities and services.  
Usually services use notifications to interact with the user. The notification displays an icon in the status bar. When the user pulls the status bar they see the notification message.  
  
Example of a notification (using the default icon):  
  
![](http://www.b4x.com/basic4android/images/notification_1.png)  
  
  
![](http://www.b4x.com/basic4android/images/notification_2.png)  
  
The user can press on the message, which will open an activity as configured by the Notification object.  
  
The notification icon is an image file which you should manually put in the following folder: <project folder>\Object\res\drawable.  
**Accessing other modules**  
  
Process global objects are public and can be accessed from other modules.  
Using CallSub method you can also call a sub in a different module.  
It is however limited to non-paused modules. This means that one activity can never access a sub of a different activity as there could only be one running activity.  
However an activity can access a running service and a service can access a running activity.  
Note that if the target component is paused then an empty string returns.  
No exception is thrown.  
You can use IsPause to check if the target module is paused.  
  
For example if a service has downloaded some new information it can call:  

```B4X
CallSub(Main, "RefreshData")
```

If the Main activity is running it will fetch the data from the service process global variables and will update the display.  
It is also possible to pass the new information to the activity sub. However it is better to keep the information as a process global variable. This allows the activity to call RefreshData whenever it want and fetch the information (as the activity might be paused when the new information arrived).  
  
Note that it is not possible to use CallSub to access subs of a Code module.  
  
Examples:  
[Downloading a file using a service module](http://www.b4x.com/forum/basic4android-getting-started-tutorials/7572-downloading-files-using-service-module.html)  
[Periodically checking Twitter feeds](http://www.b4x.com/forum/basic4android-getting-started-tutorials/7618-twitter-feed-reader.html#post43332)