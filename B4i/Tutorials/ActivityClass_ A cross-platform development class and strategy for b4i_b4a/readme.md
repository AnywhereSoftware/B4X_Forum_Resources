### ActivityClass: A cross-platform development class and strategy for b4i/b4a by Jack Cole
### 06/16/2020
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/109253/)

This is not an official tutorial and is just one option for developing cross platform apps with b4x. I have found it to work very well in creating cross platform apps that share their code base almost entirely. I have developed cross platform apps with other frameworks, but I am the most satisfied with the b4a/b4i solution. If you are designing a new app, you may want to use [B4XPages](https://www.b4x.com/android/forum/threads/b4x-b4xpages-cross-platform-and-simple-framework-for-managing-multiple-pages.118901/) to make a cross platform app. This ActivityClass is best used for migrating existing (large) Android apps to b4i. Advanced Android developers who understand and are comfortable with the Activity lifecycle may also prefer ActivityClass. Additionally, ActivityClass fully supports multiple orientations.   
  
The b4x development system keeps getting better for allowing the sharing of code in cross platform apps. The ultimate wish of most cross-platform developers is to share one code base. You can share a fair amount of code between iOS and Android on the b4x system currently, but it is generally limited to classes and code modules.  
  
I wanted to be able to share more code between b4i and b4a, and the path to porting a b4a app to b4i was not clear to me. As a result, I developed a class in b4i that allows you to run an Android activity module in b4i. I also developed a strategy for developing and maintaining the apps. In b4i, the ActivityClass handles the execution of the relevant Android activity life-cycle subs. It uses a NavigationController in the Main b4i module to handle the UI for the b4a Activity module.  
  

**Recommended strategy for developing new cross-platform apps using the ActivityClass for b4i.**

  
  
1). Start developing with your Android app. For new apps, you could use the b4a starter example that is attached. Keep the code in your Main Activity to a minimum. I recommend using the Main Activity as a splash screen and starting Main2 as your true main Activity. This will allow you to share the code of your Main2 Activity between platforms. On both platforms, use Activity.Width and Activity.Height when adding UI elements in Activity modules rather than the 100%x approach. You can use the % approach in layouts, but you might have problems on iOS if you try to use it in code for adding UI elements.  
  
2). Use the cross-platform XUI views where possible in your layouts. Use SwiftButton instead of the standard button.  
  
3). Try to stay away from libraries or UI classes that are b4a only. Some libraries are OK to use if they are substantially similar across platforms (consider libraries like Firebase, StringUtils, SQL).  
  
4). Use conditional compilation to turn the Activity Process\_Globals and Globals into a single sub (see example below). That way, all of your variables will be appropriately available to your code. You will need to add a duplicate of Globals and use it like you do in b4a. Also, make a copy of all variables in Globals to Process\_Globals. Globals will be called to reset these variables like when b4a does it (like changing orientation).  
  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
#if b4a  
End Sub  
  
Sub Globals  
#end if  
    'These global variables will be re-declared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Private AccountButton As Button  
    Private ClearDataButton As Button  
#if b4i  
    Private Activity As ActivityClass  
    Private ActivityPanel As Panel  
#End If  
End Sub  
  
#if b4i  
Sub Globals  
    'These global variables will be re-declared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Private AccountButton As Button  
    Private ClearDataButton As Button  
    Private Activity As ActivityClass  
    Private ActivityPanel As Panel  
End Sub  
#end if
```

  
  
5). After the Globals sub in shared Activities, add the following code. This code is needed to ensure that the UI events will occur in the Activity module on b4i. This code is called from the ActivityClass. **You shouldn't need to modify this for most projects. Collapse the region so you won't be tempted. :)**  
  

```B4X
#Region Android Compatibility Helpers for b4i  
#if b4i  
'shouldn't need to modify this code block in most cases  
Sub Set_Activity(ParentActivityClass As ActivityClass)  
    Activity=ParentActivityClass  
    ActivityPanel.Initialize("")  
    Activity.ActivityView.RootPanel.AddView(ActivityPanel,0,0,Activity.Width,Activity.Height)  
End Sub  
Sub AddView_To_ActivityPanel(ParameterMap As Map)  
    ActivityPanel.AddView(ParameterMap.Get("View"), ParameterMap.Get("Left"), ParameterMap.Get("Top"), ParameterMap.Get("Width"), ParameterMap.Get("Height"))  
End Sub  
Sub LoadLayout(Layout As String)  
    ActivityPanel.LoadLayout(Layout)  
End Sub  
Sub RemoveAllViews  
'    LogColor("Main2 RemoveAllViews",Colors.Magenta)  
    ActivityPanel.RemoveAllViews  
End Sub  
Sub TestLog(str As String)  
    Log("testlog: "&str)  
End Sub  
Sub ExitApplication  
    Main.ExitApplication  
End Sub  
#End If  
#End Region
```

  
  
6). Add conditional compilation around the Activity Attributes of activity modules. Do the same for service modules.  
  

```B4X
#if b4a  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
#end if
```

  
  
7). I have not done a lot with handling the service modules. The current example only executes the Service\_Create event. *You will probably need to put a conditional compilation around the Service\_Start event to make it specific to b4a.* I may do more with this in the future.  
  
8). After you write a significant portion of your b4a app, open b4i. In b4i, go to Projects and Add Existing Modules (or select and copy modules and paste them into b4i). You'll want everything except modules that you know are b4a only. **I usually link them using a relative path.** You want to link rather than copy the files. That way when you make changes to one platform, it will be available for the other automatically.  
  
9). You'll need to replicate the layouts in b4i that you use in b4a. Have the Designers in b4a and b4i open at the same time. Select all the views in b4a (Ctrl-A) and copy them (Ctrl-C). Paste them in the b4i designer (Ctrl-V). You can copy and paste your variant code and compare properties of the views.  
  
10). You'll need to resolve compatibility issues in the linked code modules by replacing incompatible code with code that will work on both platforms or use conditional compilation to exclude incompatible code (like #if b4a). My preference is to use code that will work on both platforms, but that is not always possible.  
  
**Example Project Description:** The TableExample\_cross\_platform.zip contains b4a and b4i projects. For the example project, I took an example presented by Erel for b4a for creating a [table view based on a scrollview](https://www.b4x.com/android/forum/threads/creating-a-table-view-based-on-scrollview.6946/). I moved the code from Main to TableViewActivity so it could be shared with b4i. I added a Main2 activity so you could see how navigation works with multiple activities. The Main activity is used for a splash screen, and to initialize the ActivityClass to start Main2. The example b4i project will automatically start the Starter "service" and Main2 "activity." In b4i, these are now just code modules.  
  
**Other notes:** The Map\_B4X class is used in b4i for keeping an ordered stack of the Activities. I have modified this class from the original (OrderedMap).  
  
**Ongoing Development of Your App:** Consider that the b4a project is *primary* and the b4i project is *dependent* on the b4a project. As such, new modules and features should be added to the b4a project first.  
  
Please let me know if you encounter any issues or if you have ideas for improvement.  
  
Update: 9/19/19 - Revised example and starter project to include new code. These changes make the apps mimic the activity life cycle of Android very closely. See the table example for restoring the activity state on rotation or returning to the TableActivity (click a cell and rotate or leave the activity and return). I renamed the OrderMap class to Map\_B4X since I have made so many changes to it.  
  
Update: 9/21/19 - Added handling of Activity\_Pause when opening a new activity or calling Activity.Finish. Improved handling of Activity\_Create (with the FirstTime variable). Fixed a bug in Map\_B4X.  
  
Update: 9/25/19 - Added B4XDrawer starter examples. This will give you a starter app using the B4XDrawer class. Added screenshots for this.  
  
Update: 12/10/19 - Added Color property to the Activity class. Fixed some bugs with the Map\_B4X class. Added RemoveAllViews to the code that is included in each activity module (see code for Step 5 above).  
  
Update: 12/29/19 - Added ActivityClass.bas to be downloaded directly on this post. I made a change to have it remove all views when the device changes orientation like Android does. The example projects have an older version of this file that does not have this feature.  
  
Here is a tabber [starter project](https://www.b4x.com/android/forum/threads/b4xeasytabber-cross-platform-tabber.112113/) using this class and strategy.  
  
![](https://www.b4x.com/android/forum/attachments/83599) ![](https://www.b4x.com/android/forum/attachments/83603)