### Create a widgit in B4XPages for the Win11 Desktop by Mark Read
### 07/01/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/171421/)

I havn't been very active in the forum for a while, so here is my latest offering.  
  
Here is a B4X example which creates a widgit to display Thingspeak cloud data directly on the windows desktop. There is no icon in the takbar which is why I have included a close button. The widgit updates every 15 minutes with real-time data from where I work. The widgit displays in the center of the screen (at least on my monitor).  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 300  
    #MainFormHeight: 180  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
     
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
     
    'Form1 is the standard window  
    'We use an invisible help window to hide the task bar icon  
    Form1.SetFormStyle("UTILITY")  
    Form1.WindowWidth = 0  
    Form1.WindowHeight = 0  
    Form1.WindowLeft = -2000 ' Move the window outside of the visible area  
    Form1.Show  
         
    'Now we create the widgit window  
    MainForm.Initialize("MainForm", 300, 180)  
         
    ' Make the window completely frameless and clear  
    MainForm.SetFormStyle("TRANSPARENT")  
     
    'Bind the widgit to the hidden help window  
    Dim joMain As JavaObject = MainForm  
    Dim joOwner As JavaObject = Form1  
    Dim stageMain As JavaObject = joMain.GetField("stage")  
    Dim stageOwner As JavaObject = joOwner.GetField("stage")  
    stageMain.RunMethod("initOwner", Array(stageOwner))  
     
    'Initialise our B4XPages in our widgit window    
    Dim PagesManager As B4XPagesManager  
    PagesManager.Initialize(MainForm)  
    MainForm.Show  
     
    'Make background transparent  
    Dim scene As JavaObject = stageMain.RunMethod("getScene", Null)  
    If scene.IsInitialized Then  
        scene.RunMethod("setFill", Array(Null)) ' Remove the JavaFX-Grey  
    End If  
    MainForm.RootPane.Style = "-fx-background-color: transparent;"  
  
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
#Region Shared Files  
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"  
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True  
#End Region  
  
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip  
  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private LinkURL As String  
    Private ChannelNumber As Int=1545308  
    Private MyRoot As Map  
    Private lbl_H As B4XView  
    Private lbl_P As B4XView  
    Private lbl_T As B4XView  
    Private txt_H As B4XView  
    Private txt_P As B4XView  
    Private txt_T As B4XView  
    Private txt_lastdate As B4XView  
    Private txt_lasttime As B4XView  
    Private tmrUpdate As Timer  
    Private btnClose As B4XView  
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
     
    'Overwrite standard color of panel  
    Root.Color = xui.Color_Transparent  
           
    ' Start an automatic update timer (e.g., every 5 seconds)  
    tmrUpdate.Initialize("tmrUpdate", 15*60*1000)  
    tmrUpdate.Enabled = True  
     
    LinkURL=$"https://api.thingspeak.com/channels/${ChannelNumber}/feeds.json?results=1"$  
         
    Wait For (GetData(LinkURL)) Complete (Resp As String)  
End Sub  
  
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.  
  
Sub tmrUpdate_Tick  
    Wait For (GetData(LinkURL)) Complete (Resp As String)    
End Sub  
  
Sub ConverttoMEZ (s As String) As String  
    'Log(s)  
    Dim t As Long  
    t=DateTime.TimeParse(s)  
    t=t+(DateTime.TimeZoneOffset*DateTime.TicksPerHour)  
    Return DateTime.Time(t)  
End Sub  
  
'Download the last data entry  
private Sub GetData(GetLink As String) As ResumableSub  
    Dim j As HttpJob  
    j.Initialize("", Me)  
    j.Download(GetLink)  
    Wait For (j) JobDone(j As HttpJob)  
    If j.Success Then  
        'Log(j.GetString)  
        Log($"Job ${j.JobName} was a success"$)  
        ParseJSON(j.GetString)  
        j.Release  
        Return j.JobName & " parsed"  
    Else  
        j.Release  
        Return j.JobName & " failed"  
    End If  
End Sub  
  
'Parse the JSON reply to get the data  
Private Sub ParseJSON(text As String)  
    Dim parser As JSONParser  
    parser.Initialize(text)  
    MyRoot = parser.NextObject  
     
    Dim i As Int=0    'counters  
    Dim feeds As List = MyRoot.Get("feeds")  
    For Each colfeeds As Map In feeds  
         
        Dim created_at As String = colfeeds.Get("created_at")  
        Dim cTime As String  
        cTime=created_at.SubString2(0,10) & " " &ConverttoMEZ(created_at.SubString2(11,19)) 'remove T and Z. Add space. Convert to MEZ  
        created_at=ReformatDateTime(cTime)    'reformat to yyyy.dd.mm hh:mm  
         
        'read data fo each field  
        Dim field1, field2, field3 As Double  
         
        ' Trying to read a NAN into a double will cause a crash, hence Try  
        Try  
            field1=colfeeds.Get("field1")  
        Catch  
            field1=0  
        End Try  
                 
        Try  
            field2=colfeeds.Get("field2")  
        Catch  
            field2=0  
        End Try  
         
        Try  
            field3=colfeeds.Get("field3")  
        Catch  
            field3=0  
        End Try  
         
                 
        txt_lastdate.Text=created_at.SubString2(0,10)  
        'txt_lasttime.Text=ConverttoMEZ(created_at.SubString(11))    ' Time is UTC format and we need MEZ  
        txt_lasttime.Text=created_at.SubString(11)  
                 
        txt_T.Text=field1  
        txt_P.Text=field2  
        txt_H.Text=field3        
        i=i+1  
    Next  
End Sub  
  
Sub ReformatDateTime(s As String) As String  
    Dim cYear, cDay, cMonth, cHour, cMinute As String  
    '2023-09-27 14:10:48  
    cYear=s.SubString2(0,4)  
    cDay=s.SubString2(8,10)  
    cMonth=s.SubString2(5,7)  
    cHour=s.SubString2(11,13)  
    cMinute=s.SubString2(14,16)  
     
    'Reformat to yyyy.dd.MM HH:mm  
    Return cYear & "." & cDay & "." & cMonth & " " & cHour & ":" & cMinute  
End Sub  
  
'CLose the exe file with a right mouse click on the widgit  
'Private Sub Root_Touch (Action As Int, X As Float, Y As Float)  
'    #If B4J  
'    Dim joEvent As JavaObject = Sender  
'    Dim button As String = joEvent.RunMethod("getButton", Null)  
'    If button = "PRIMARY" Then ' SECONDARY = Rechtsklick  
'        ExitApplication  
'    End If  
'    #End If  
'End Sub  
  
Private Sub btnClose_Click  
    ExitApplication  
End Sub
```

  
  
Or if you prefer to download, here is the zip file.  
  
Feel free to use the code as required.  
  
![](https://www.b4x.com/android/forum/attachments/172122)