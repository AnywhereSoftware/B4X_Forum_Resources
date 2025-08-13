### SoftOrientation Library for Activitiy and B4XPages based projects by Ivica Golubovic
### 11/12/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/143896/)

After a lot of searching and unsuccessful attempts to find a method or library that will allow changing the screen orientation without killing the activity, I decided to make the library myself. As is known, in the Android operating system, after changing the orientation of the screen, the activity is killed and all views are redrawn. This can have a very negative impact on certain views that cannot save their current instance (eg WebView, ListView, etc.). The content of these objects must be rewritten and repopulated (refreshed). In some cases this may not be a problem, but in a certain number of cases it is a big problem (e.g. a filled form in a WebView will be deleted, a filled ListView with several hundred rows will return the scroll position to the beginning and lose the complete content that must be filled again, CheckBox will reset its status, also RadioButton etc.)  
  
Also, one of the best features of B4X, B4XPages, is limited to the fact that each B4X page must use the same screen orientation (landscape or portrait) because when the screen orientation is changed, the activity and all its views (like the B4X page Panels) are reset and the whole application restarts.  
  
Using the SoftOrientation library provides the following possibilities:  

- Prevents killing the activity and redrawing all views with their initial instances.
- Instances of all views remain as they were before the orientation change.
- Activity\_Create and Activity\_Resume subs are not called after orientation change
- Allows defining the screen orientation for each B4X page in the B4XPages project

  
The working principle of the library is based on the fact that when the screen orientation is changed, the library changes the size of the activity to the size of the free space for displaying the activity in the current orientation. Also, in parallel with changing the size of the activity, an invisible Panel is created whose size is the same as the new size of the activity. After that, the Layout is loaded into the invisible panel in relation to the current orientation. Then each view in the activity is resized to the size of the same view in the invisible Panel. After that the invisible Panel is killed and the activity is adjusted for the current screen orientation. The principle is the same in B4XPages, with the fact that in addition to changing the size of the Activity, the size of the Root panel also changes.  
  
**So the library can be used in projects that are based on Activities, and also in projects that are based on B4X pages.**  
  
It is necessary to add the following line to the Manifest. For an activity-based project, you need to add a line to the Manifest for each Activity that will use Soft Orientation.  

```B4X
SetActivityAttribute(Main, android:configChanges, "orientation|keyboardHidden|screenSize|screenLayout")
```

  
  
Below are examples of how to use the library:  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private xui As XUI  
   
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Private SoftOrientationMain As SoftOrientationForActivities  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    SoftOrientationMain.Initialize(Me,"SoftOrientationMain",Activity,"Layout")  
    SoftOrientationMain.Orientation=SoftOrientationMain.SCREEN_ORIENTATION_SENSOR  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
'This event will be activated when the orientation change procedure is completed.  
Private Sub SoftOrientationMain_ActivityConfigurationChanged (NewConfiguration As AndroidContentResConfiguration)  
    If NewConfiguration.Orientation=NewConfiguration.Constants.ORIENTATION_PORTRAIT Then  
        Log("portrait")  
    Else if NewConfiguration.Orientation=NewConfiguration.Constants.ORIENTATION_LANDSCAPE Then  
        Log("landscape")  
    End If  
End Sub  
  
'Do not forget to add line in Manifest for your future projects: SetActivityAttribute(Main, android:configChanges, "orientation|keyboardHidden|screenSize|screenLayout")  
'Do not forget to create single Layout file for portrait and landscape mode in Designer in your future projects. Recommended to use variants, designer script and anchors.  
'********************Copy this part of codes to your future project Main activity, including Java code*********************************  
Public Sub onConfigurationChanged (NewConfig As Object)  
    SoftOrientationMain.OnConfigurationChanged(NewConfig)  
End Sub  
  
#If Java  
  
import android.content.res.Configuration;  
  
@Override  
public void onConfigurationChanged (Configuration newConfig) {  
    super.onConfigurationChanged(newConfig);  
    processBA.raiseEvent(null, "onconfigurationchanged", newConfig);  
}  
#End If  
'************************************End of code*********************************************************************************************
```

  
  

```B4X
Sub Process_Globals  
   
End Sub  
  
Sub Globals  
   
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Dim pm As B4XPagesManager  
    pm.Initialize(Activity)  
End Sub  
  
'Template version: B4A-1.0  
  
#Region Delegates  
  
Sub Activity_ActionBarHomeClick  
    B4XPages.Delegate.Activity_ActionBarHomeClick  
End Sub  
  
Sub Activity_KeyPress (KeyCode As Int) As Boolean  
    Return B4XPages.Delegate.Activity_KeyPress(KeyCode)  
End Sub  
  
Sub Activity_Resume  
    B4XPages.Delegate.Activity_Resume  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
    B4XPages.Delegate.Activity_Pause  
End Sub  
  
Sub Activity_PermissionResult (Permission As String, Result As Boolean)  
    B4XPages.Delegate.Activity_PermissionResult(Permission, Result)  
End Sub  
  
Sub Create_Menu (Menu As Object)  
    B4XPages.Delegate.Create_Menu(Menu)  
End Sub  
  
'Do not forget to add line in Manifest for your future projects: SetActivityAttribute(Main, android:configChanges, "orientation|keyboardHidden|screenSize|screenLayout")  
'Do not forget to create single Layout file for portrait and landscape mode in Designer for each B4XPage in your future projects. Recommended to use variants, designer script and anchors.  
'********************Copy this part of codes to your B4XPages future project Main activity, including Java code*********************************  
Public Sub onConfigurationChanged (NewConfig As Object)  
    'SoftOrientationMain is variable name for SoftOrientationForB4XPages in B4XMainPage. Change it depending on your variable name in your future projects.  
    If B4XPages.MainPage.SoftOrientationMain.IsInitialized Then  
        B4XPages.MainPage.SoftOrientationMain.OnConfigurationChanged(NewConfig,B4XPages.GetManager.GetTopPage.Id)  
        'Or  
        'B4XPages.MainPage.SoftOrientationMain.OnConfigurationChanged(NewConfig,B4XPages.MainPage.SoftOrientationMain.CurrentlyActiveB4XPage.PageID)  
        'Or  
        'B4XPages.MainPage.SoftOrientationMain.OnConfigurationChanged2(NewConfig,B4XPages.MainPage.SoftOrientationMain.CurrentlyActiveB4XPage)  
    End If  
End Sub  
  
#If Java  
  
import android.content.res.Configuration;  
  
@Override  
public void onConfigurationChanged (Configuration newConfig) {  
    super.onConfigurationChanged(newConfig);  
    processBA.raiseEvent(null, "onconfigurationchanged", newConfig);  
}  
#End If  
'************************************End of code*********************************************************************************************
```

  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView 'ignore  
    Private xui As XUI 'ignore  
    Public txtUser As B4XFloatTextField  
    Private btnLogin As B4XView  
    Public Page2 As B4XPage2  
    Public Page3 As B4XPage3  
    Public SoftOrientationMain As SoftOrientationForB4XPages  
    Public SoftOrientationMainPage As SoftOrientationB4XPage  
End Sub  
  
'You can add more parameters here.  
Public Sub Initialize  
  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    'load the layout to Root  
    Root.LoadLayout("Login")  
    Page2.Initialize  
    B4XPages.AddPage("Page 2", Page2)  
    Page3.Initialize  
    B4XPages.AddPage("Page 3", Page3)  
   
    SoftOrientationMain.Initialize(B4XPages.GetNativeParent(Me))  
    SoftOrientationMainPage.Initialize(Me,"SoftOrientationMainPage",B4XPages.GetPageId(Me),"Login",SoftOrientationMain.SCREEN_ORIENTATION_SENSOR,Root)  
    SoftOrientationMain.AddB4XPage2(SoftOrientationMainPage)  
End Sub  
  
Sub B4XPage_Appear  
    txtUser.Text = ""  
   
    SoftOrientationMain.ApplyB4XPageDefaultOrientation(B4XPages.GetPageId(Me))  
    'Or  
    'SoftOrientationMain.ApplyB4XPageDefaultOrientation2(SoftOrientationMainPage)  
End Sub  
  
'This event will be activated when the orientation change procedure is completed.  
Sub SoftOrientationMainPage_ActivityConfigurationChanged (NewConfiguration As AndroidContentResConfiguration)  
    If NewConfiguration.Orientation=NewConfiguration.Constants.ORIENTATION_PORTRAIT Then  
        Log("SoftOrientationMainPage orientation PORTRAIT")  
    Else If NewConfiguration.Orientation=NewConfiguration.Constants.ORIENTATION_LANDSCAPE Then  
        Log("SoftOrientationMainPage orientation LANDSCAPE")  
    End If  
End Sub  
  
Sub btnLogin_Click  
    B4XPages.ShowPageAndRemovePreviousPages("Page 2")  
End Sub  
  
Sub txtUser_TextChanged (Old As String, New As String)  
    btnLogin.Enabled = New.Length > 0  
End Sub  
  
Sub txtUser_EnterPressed  
    If btnLogin.Enabled Then btnLogin_Click  
End Sub
```

  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView 'ignore  
    Private xui As XUI 'ignore  
    Private lblHello As B4XView  
    Private ImageView1 As B4XView  
    Private Page3 As B4XPage3  
    Public SoftOrientationPage2 As SoftOrientationB4XPage  
End Sub  
  
'You can add more parameters here.  
Public Sub Initialize  
  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    'load the layout to Root  
    Root.LoadLayout("Page2")  
    Page3 = B4XPages.GetPage("Page 3")  
   
    SoftOrientationPage2.Initialize(Me,"SoftOrientationPage2",B4XPages.GetPageId(Me),"Page2",B4XPages.MainPage.SoftOrientationMain.SCREEN_ORIENTATION_PORTRAIT,Root)  
    B4XPages.MainPage.SoftOrientationMain.AddB4XPage2(SoftOrientationPage2)  
End Sub  
  
Private Sub B4XPage_Appear  
    lblHello.Text = $"Hello ${B4XPages.MainPage.txtUser.Text}!"$  
    UpdateImage  
   
    B4XPages.MainPage.SoftOrientationMain.ApplyB4XPageDefaultOrientation(B4XPages.GetPageId(Me))  
    'Or  
    'B4XPages.MainPage.SoftOrientationMain.ApplyB4XPageDefaultOrientation2(SoftOrientationPage2)  
End Sub  
  
'This event will be activated when the orientation change procedure is completed.  
Sub SoftOrientationPage2_ActivityConfigurationChanged (NewConfiguration As AndroidContentResConfiguration)  
    If NewConfiguration.Orientation=NewConfiguration.Constants.ORIENTATION_PORTRAIT Then  
        Log("SoftOrientationPage2 orientation PORTRAIT")  
    Else If NewConfiguration.Orientation=NewConfiguration.Constants.ORIENTATION_LANDSCAPE Then  
        Log("SoftOrientationPage2 orientation LANDSCAPE")  
    End If  
End Sub  
  
Sub btnDraw_Click  
    B4XPages.ShowPage("Page 3")  
End Sub  
  
Sub UpdateImage  
    If Page3.Panel1.IsInitialized Then  
        ImageView1.SetBitmap(Page3.cvs.CreateBitmap)  
    End If  
End Sub  
  
Sub btnSignOut_Click  
    Page3.ClearImage  
    UpdateImage  
    B4XPages.ShowPageAndRemovePreviousPages("MainPage")  
End Sub
```

  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView 'ignore  
    Private xui As XUI 'ignore  
    Public cvs As B4XCanvas  
    Public Panel1 As B4XView  
    Public SoftOrientationPage3 As SoftOrientationB4XPage  
End Sub  
  
'You can add more parameters here.  
Public Sub Initialize  
  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    'load the layout to Root  
    Root.LoadLayout("Page3")  
    cvs.Initialize(Panel1)  
    B4XPages.SetTitle(Me, "Draw Something")  
    #if B4A  
    B4XPages.AddMenuItem(Me, "Random Background")  
    #End If  
   
    SoftOrientationPage3.Initialize(Me,"SoftOrientationPage3",B4XPages.GetPageId(Me),"Page3",B4XPages.MainPage.SoftOrientationMain.SCREEN_ORIENTATION_SENSOR,Root)  
    B4XPages.MainPage.SoftOrientationMain.AddB4XPage2(SoftOrientationPage3)  
End Sub  
  
  
Sub B4XPage_Appear  
    B4XPages.MainPage.SoftOrientationMain.ApplyB4XPageDefaultOrientation(B4XPages.GetPageId(Me))  
    'Or  
    'B4XPages.MainPage.SoftOrientationMain.ApplyB4XPageDefaultOrientation2(SoftOrientationPage3)  
End Sub  
  
'This event will be activated when the orientation change procedure is completed.  
Sub SoftOrientationPage3_ActivityConfigurationChanged (NewConfiguration As AndroidContentResConfiguration)  
    cvs.Resize(Root.Width,Root.Height)  
    If NewConfiguration.Orientation=NewConfiguration.Constants.ORIENTATION_PORTRAIT Then  
        Log("SoftOrientationPage3 orientation PORTRAIT")  
    Else If NewConfiguration.Orientation=NewConfiguration.Constants.ORIENTATION_LANDSCAPE Then  
        Log("SoftOrientationPage3 orientation LANDSCAPE")  
    End If  
End Sub  
  
Sub Panel1_Touch (Action As Int, X As Float, Y As Float)  
    If Action <> Panel1.TOUCH_ACTION_MOVE_NOTOUCH Then  
        cvs.DrawCircle(X, Y, 10dip, Rnd(xui.Color_Black, xui.Color_White), True, 0)  
        cvs.Invalidate  
    End If  
End Sub  
  
Private Sub btnClear_Click  
    ClearImage  
End Sub  
  
Public Sub ClearImage  
    If Panel1.IsInitialized Then  
        cvs.ClearRect(cvs.TargetRect)  
        cvs.Invalidate  
    End If  
End Sub  
  
Sub btnSet_Click  
    B4XPages.ClosePage(Me)  
End Sub  
  
Sub B4XPage_Resize (Width As Int, Height As Int)  
    ClearImage  
    cvs.Resize(Width, Height)  
End Sub  
  
Sub B4XPage_MenuClick (Tag As String)  
    If Tag = "Random Background" Then  
        cvs.DrawRect(cvs.TargetRect, Rnd(xui.Color_Black, xui.Color_White), True, 0)  
        cvs.Invalidate  
    End If  
End Sub  
  
#if B4J  
'Delegate the native menu action to B4XPage_MenuClick.  
Sub MenuBar1_Action  
    Dim mi As MenuItem = Sender  
    Dim t As String  
    If mi.Tag = Null Then t = mi.Text.Replace("_", "") Else t = mi.Tag  
    B4XPage_MenuClick(t)  
End Sub  
#End If
```

  
  
For the B4XPages example, the ThreePagesExample from [USER=1]@Erel[/USER] was used.  
  
***As [USER=1]@Erel[/USER] has mentioned several times, and it is also Google's recommendation that the onConfigurationChanged principle should not be used if it is not necessary. So, if the use of this library is not necessary for your project, do not use it. Use the library if you really need it.***  
  
The library and the htm file with methods and properties are packed in the zip file SoftOrientation\_Lib.zip. There are also two example projects, one for an Activity-based project, the other for B4XPages.  
  
The following libraries are necessary for the library to work:  

- [JavaObject](https://www.b4x.com/android/forum/threads/javaobject-library.34486/)
- [Reflection](https://www.b4x.com/android/forum/threads/reflection-library.6767/)
- [B4XPages](https://www.b4x.com/android/forum/threads/b4x-b4xpages-cross-platform-and-simple-framework-for-managing-multiple-pages.118901/) (only for B4XPages based project)

  
If this library makes your work easier and saves time in creating your application, please make a donation.  
<https://www.paypal.com/donate?hosted_button_id=HX7GS8H4XS54Q>