### ElevateUI Demo in B4XPage and Activity by AnandGupta
### 01/23/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/164985/)

Check Elevate UI Demo 3 at [post#6](https://www.b4x.com/android/forum/threads/elevateui-demo-in-b4xpage-and-activity.164985/#post-1012998)  
  
I have purchased the fantastic ElevateUI library and was trying to add the views in my project. Since the library comes without any demo or manual, I was having tough time.  
[USER=115811]@fernando1987[/USER] helped me by giving tips in dm, still many more help was needed.  
  
So I decided to go through the codes in the library and try to create a demo, as far as I could using the code snippets from the main thread,  
<https://www.b4x.com/android/forum/threads/elevateui-improve-the-graphic-interface-of-your-b4a-applications.162072/>  
  
Though not perfect, I have put the demo here and will request [USER=115811]@fernando1987[/USER] guide on it as I will add more views from the library.  
**Please note that no code of the library is in the demo source. One has to purchase ElevateUI library to run the demo.**  
  
This demo is to help all members who have purchased the library but are struggling for want of any demo or manual.  
  
I will remove this demo if not allowed by owner of the library.  
  
Sample codes from the demo  

```B4X
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
'    Root.LoadLayout("MainPage")  
   
    'Initialize the drawer component with the following parameters:  
    ' - Me: The current activity  
    ' - "Drawer": The name of the drawer component  
    ' - Activity: The current activity  
    ' - 85%x: The width of the drawer  
    ' - 25%y: The height of the drawer  
    ' - xui.Color_White: The background color of the drawer  
    D.Initialize(Me, "Drawer", Root, 85%x,25%y,xui.Color_White)  
  
    'Initialize the iconfont, valsend, valcontacts, valgroup, and valtemplates components.  
    tbar.Initialize(d.CenterPanel,xui.Color_RGB(99, 160, 180),xui.Color_RGB(99, 160, 180),xui.CreateFontAwesome(32),Chr(0xF039),True,"DailyTaskMaster",xui.CreateDefaultBoldFont(20),Colors.White,10,Me)  
  
    menu  
   
    load.Initialize("", "")  
    load.AddToParent(d.Centerpanel,100,100,200,200,Colors.Red,"PacMan",500)  
    Sleep(1000)  
    load.AddToParent(d.Centerpanel,100,300,200,200,Colors.Yellow,"BouncingBall",500)  
    Sleep(1000)  
    load.AddToParent(d.Centerpanel,100,600,200,200,Colors.Green,"RainbowCircle",500)  
    Sleep(1000)  
   
    Dim act As PageLoadingFinished  
   
    ' Initialize the PageLoadingFinished instance.  
    act.Initialize(Root,Me,xui.Color_RGB(192, 157, 133))  
   
    ' Start the animation.  
    act.Start_Animation  
    Sleep(1000)  
   
    ' Add the title image and title text to the animation.  
    act.Add_TitleImage(File.DirAssets,"address-book@512px.png","Contacts",xui.Color_White)  
    Sleep(1000)  
   
    ' Add the second page to the animation.  
    act.Add_SecondPage(contacts_activity,4000)  
    Sleep(1000)  
  
  
End Sub
```

  
  

```B4X
Sub menu  
    ' This sub creates the main menu of the application.  
    d.addpanel_title( Colors.Green,xui.LoadBitmap(File.DirAssets, "BULK-SMS.png"),"BULK SMS", xui.CreateDefaultBoldFont(16) ,16,Colors.RGB(245, 227, 179))  
    ' Adds menu items to the main menu.  
    d.AddMenuImageItem("SendSms",File.DirAssets, "icons8_paper_plane_480px.png","Send sms",xui.Color_DarkGray,"Send bulk SMS to your group contacts",xui.Color_Gray)  
    d.AddMenuImageItem("TemplatesApp",File.DirAssets, "icons8_messaging_480px_1.png","Templates",xui.Color_DarkGray,"Create and manage sms templates for your mailings",xui.Color_Gray)  
    d.AddMenuImageItem("ContactApp",File.DirAssets, "address-book@512px.png","Contacts",xui.Color_DarkGray,"Manage, add and delete your contacts",xui.Color_Gray)  
    d.AddMenuImageItem("GroupApp",File.DirAssets, "united.png","Groups",xui.Color_DarkGray,"Manage, add and remove your contact  groups",xui.Color_Gray)  
    d.AddMenuImageItem("AboutApp",File.DirAssets, "icons8_info_480px.png","About",xui.Color_DarkGray,"information about the app",xui.Color_Gray)  
    d.AddMenuImageItem("ExitApp",File.DirAssets, "icons8_close_window_480px.png","Close",xui.Color_DarkGray,"Exit the application",xui.Color_Gray)  
End Sub
```

  
  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
  
    btfloating1.Initialize(Me,"btfloating1")  
    btfloating1.AddToParent(Activity,85%x,57%y,6%y,6%y,xui.Color_RGB(99, 160, 180))  
    btmenu.Initialize(Me,"btmenu",False,False,True,btfloating1.mBase,Activity)  
    btmenu.additemIcon("Create new list",xui.Color_White,14,Chr(0xf14e),xui.CreateDefaultBoldFont(16),xui.Color_White,xui.Color_RGB(143, 145, 206))  
    btmenu.additemIcon("New item",xui.Color_White,14,Chr(0xf64f),xui.CreateDefaultBoldFont(16),xui.Color_White,xui.Color_RGB(255, 209, 121))  
    btmenu.additemIcon("Clear list",xui.Color_White,14,Chr(0xf6cb),xui.CreateDefaultBoldFont(16),xui.Color_White,xui.Color_RGB(231, 140, 151))  
    btmenu.additemIcon("Reload list",xui.Color_White,14,Chr(0xf6af),xui.CreateDefaultBoldFont(16),xui.Color_White,xui.Color_RGB(140, 206, 239))  
  
    btfloating1.Color = xui.Color_RGB(99, 160, 180)  
    btfloating1.lcon(xui.CreateFontAwesome(22),Chr(0xF067))  
    btfloating1.mBase.BringToFront  
  
    Dim TabMenuAnimated As UITabMenuAnimated  
    TabMenuAnimated.Initialize(Me,Activity,5,"menu4",85%y)  
    TabMenuAnimated.Add_Menu("menu1",Chr(0xF015),xui.CreateFontAwesome(20),0xFFC95AFC,"Main",TabMenuAnimated.AnimationBlink)  
    TabMenuAnimated.Add_Menu("menu2",Chr(0xF17B),xui.CreateFontAwesome(20),0xFF519649,"Android",TabMenuAnimated.AnimationFadeIn)  
    TabMenuAnimated.Add_Menu("menu3",Chr(0xF179),xui.CreateFontAwesome(20),0xFF6C6969,"Ios",TabMenuAnimated.AnimationShake)  
    TabMenuAnimated.Add_Menu("menu4",Chr(0xF0F3),xui.CreateFontAwesome(20),0xFFF4CF4B,"alerts",TabMenuAnimated.AnimationSlide)  
    TabMenuAnimated.Add_Menu("menu5",Chr(0xF129),xui.CreateFontAwesome(20),0xFF8EA7F2,"Info",TabMenuAnimated.AnimationNone)  
  
  
  
End Sub
```

  
  
All above are taken from the main ElevateUI library thread.