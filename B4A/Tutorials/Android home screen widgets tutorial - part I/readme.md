### Android home screen widgets tutorial - part I by Erel
### 01/10/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/10166/)

**Edit: widgets are handled with receivers now. See the attached example.**  
  
This tutorial will explain how to implement your own home screen widgets (also named App Widgets).  
  
It is important to understand that the widgets are created and managed in another process, different than the process that your application is running in. The home screen application is hosting your widgets.  
This means that it is not possible to directly access the widgets views. Instead we are using a special object named RemoteViews which gives us indirect access to the widget views.  
  
Widgets do not support all views types. The following views are supported:  
- Button (default drawable)  
- Label (ColorDrawable or GradientDrawable)  
- Panel (ColorDrawable or GradientDrawable)  
- ImageView  
- ProgressBar (both modes)  
  
All views support the Click event and no other event.  
  
The widget layout and configuration must be defined with XML files. During compilation Basic4android reads the layout file created with the designer and generates the required XML files.  
  
Each widget is tied to a Service module. Through this module the widget is created and updated.  
  
**Creating a widget - step by step guide**  
  
- Add a Service module. Note that the service module handling the widget is a standard service.  
- Design the widget layout with the designer. First add a Panel and then add the other views to this Panel.  
The widget layout will be made from this panel.  
- Add code similar to the following code the service module:  

```B4X
Sub Process_Globals  
    Dim rv As RemoteViews  
End Sub  
  
Sub Service_Create  
    rv = ConfigureHomeWidget("LayoutFile", "rv", 0, "Widget Name")  
End Sub  
  
Sub Service_Start (StartingIntent As Intent)  
     RV.HandleWidgetEvents(StartingIntent)  
    Sleep(0)  
    Service.StopAutomaticForeground  
End Sub  
  
Sub rv_RequestUpdate  
    rv.UpdateWidget  
End Sub  
  
Sub rv_Disabled  
    StopService("")  
End Sub  
  
Sub Service_Destroy  
  
End Sub
```

- Compile and run your application. Go to the home screen, long press on the screen and you will see your widget listed on the widgets list.  
  
**ConfigureHomeWidget** is a special keyword. At runtime it creates the RemoteViews object from the layout and set the events. At compile time the compiler generates the required files based on the arguments of this keyword.  
The four parameters are: layout file, event name, update interval and the widget name.  
Event name sets the subs that will handle the RequestUpdate and Disabled events.  
The widget can be configured to update itself automatically. The interval, measured in minutes, defines how often will the widget request to update itself. Set to 0 to disable automatic updates. Updating the widget too often will have a bad impact on the battery. The minimum value is 30 minutes.  
Widget name - the name that will appear in the widgets list.  
  
As these arguments are read by the compiler, only strings or numbers are accepted.  
  
**Events:**  

```B4X
Sub Service_Start (StartingIntent As Intent)  
    If rv.HandleWidgetEvents(StartingIntent) Then Return  
End Sub
```

The above code checks the Intent message that caused this service to start and is responsible for raising the events related to the widget. It returns true if an event was raised.  
The widget raises two events. RequestUpdate is raised when the widget needs to update itself. It will fire after adding the widget to the screen, after the device has booted, based on the scheduled updating interval (if set) or after the application was updated.  
The Disabled event is raised when the last instance of our widget is removed from the screen.  
  
As mentioned above all views support the Click event. All that needs to be done in order to handle the click event of a button named Button1 is to add a sub named Button1\_Click (the sub name should actually match the EventName property which is by default the same as the name).  
  
**Modifying the widget:**  
It is not possible to directly access the widget views. Instead we need to use one of the RemoteView.Set methods.  
If we want to change the text of a label named Label1 then we need to write the following code:  

```B4X
rv.SetText("Label1", "This is the new text.")  
'do more changes if needed  
rv.UpdateWidget
```

After writing all the changes we call rv.UpdateWidget to send the updates to the widget.  
  
A simple example is attached.  
The example adds a simple widget. The widget doesn't do anything useful.  
![](http://www.b4x.com/basic4android/images/SS-2011.07.11-12.55.04.png)  
Note that it is recommended to test widgets in Release mode (the widget will fail in debug mode when the process is started by the OS).