### Dark TitleBar - unwanted effect of bright pixels in the corners of the form by T201016
### 11/20/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/169382/)

If in the designer the Main form has the default setting for the background: ![](https://www.b4x.com/android/forum/attachments/168480)  
Change the background color to dark to get rid of the unwanted effect  
of light pixels at the corner points of the form:  
  
![](https://www.b4x.com/android/forum/attachments/168481)  
  
**You will find everything in the completed .ZIP code :)**  
  

```B4X
#Region Project Attributes  
    #MainFormWidth:  600  
    #MainFormHeight: 600  
#End Region  
  
#AdditionalJar: jna-5.0.0  
#AdditionalJar: jna-platform-5.0.0  
  
Sub Process_Globals  
    Dim xu As XUI  
    Dim fx As JFX  
    Public MainForm As Form  
    Public AppName,Videos As String = "B4XPages"  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("MainPage")  
    MainForm.Title = AppName  
     
    Videos = File.DirData(AppName)  
    Videos = Videos.SubString2(0,File.DirData(AppName).IndexOf("\AppData\")+1) & "Videos\Captures\"  
     
    MainForm.Show  
    DarkTitleBar.SetDarkMode(MainForm, True, xu.Color_Black) '—————————————————————————————————————– >>>>>>> ADD!  
     
    Dim PagesManager As B4XPagesManager  
    PagesManager.Initialize(MainForm)  
     
End Sub  
  
Private Sub Button1_Click  
    If B4XPages.MainPage.pg.IsInitialized Then  
        If B4XPages.MainPage.pg.MediaView1.IsInitialized Then B4XPages.MainPage.pg.MediaView1.Stop  
        B4XPages.GetManager.ClosePage(B4XPages.MainPage.pg)  
    End If  
     
    Dim ffplay As String = ""  
    Private fc As FileChooser  
  
    fc.Initialize  
    fc.Title = "Open in the internal media player"  
  
    fc.InitialDirectory = File.GetFileParent(Videos)  
    fc.setExtensionFilter("Multimedia Files", Array As String("*.acc","*.mp3","*.pcm","*.avc","*.aif","*.aiff","*.fxm","*.flv","*.mp4","*.m4a","*.m4v","*.wav"))  
    ffplay = fc.ShowOpen(MainForm)  
  
    If ffplay = "" Then  
        Return  
    Else  
        B4XPages.MainPage.pg.pth = File.GetFileParent(ffplay)  
        B4XPages.MainPage.pg.filename = File.GetName(ffplay)  
        B4XPages.ShowPage("PageMediaView")  
        DarkTitleBar.SetDarkMode(B4XPages.GetNativeParent(B4XPages.GetPage("PageMediaView")),True, xu.Color_Black) '———————————————————- >>>>>>> ADD!  
    End If  
End Sub  
  
'Template version: B4J-1.0  
#Region Delegates  
Sub MainForm_FocusChanged (HasFocus As Boolean)  
    B4XPages.Delegate.MainForm_FocusChanged(HasFocus)  
End Sub  
  
Sub MainForm_Resize (Width As Double, Height As Double)  
    B4XPages.Delegate.MainForm_Resize(Width, Height)  
End Sub  
  
Sub MainForm_Closed  
    B4XPages.Delegate.MainForm_Closed  
End Sub  
  
Sub MainForm_CloseRequest (EventData As Event)  
    B4XPages.Delegate.MainForm_CloseRequest(EventData)  
End Sub  
  
Public Sub MainForm_IconifiedChanged (Iconified As Boolean)  
    B4XPages.Delegate.MainForm_IconifiedChanged(Iconified)  
End Sub  
#End Region
```

  
  

```B4X
'Apply the whole values to the RootPane style.  
Public Sub SetDarkMode(Target As Form, Dark As Boolean, WholeColor As Int)  
    mDark = Dark  
'   If Target.Showing And mDark Then Target.RootPane.Style = "-fx-background-color: #000000;" '——————————————————————————— >>>>>>> ADD!  
    If Target.Showing And mDark Then Target.RootPane.As(B4XView).Color = WholeColor '—————————————————————————————— >>>>>>> ADD!  
    Dim hwnd As JavaObject = Me.As(JavaObject).RunMethod("getActiveWindow",Null)  
    Me.As(JavaObject).RunMethod("setDarkMode",Array(GetStage(Target),mDark,hwnd))  
End Sub
```