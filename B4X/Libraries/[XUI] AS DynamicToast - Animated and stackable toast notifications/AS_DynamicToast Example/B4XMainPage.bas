B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
    Private Root As B4XView
    Private xui As XUI
    Public Toast As AS_DynamicToast
    Private buttons As List
    Private loadingId As Object
End Sub
Public Sub Initialize
End Sub
Private Sub B4XPage_Created (Root1 As B4XView)
    Root = Root1
    Root.Color = 0xFF000000
    B4XPages.SetTitle(Me, "AS DynamicToast")
    buttons.Initialize
    Dim heading As Label
    heading.Initialize("")
    Dim h As B4XView = heading
    h.Text = "Dynamic Toast"
    h.Font = xui.CreateDefaultBoldFont(28)
    h.TextColor = xui.Color_White
    Root.AddView(h, 24dip, 24dip, Root.Width - 48dip, 48dip)
    Dim names() As String = Array As String("Default", "Success", "Error", "Info", "Warning", "Loading / update", "Stack (5)", "Top + bottom", "Action + cancel", "Custom content", "Promise", "Dismiss all")
    For i = 0 To names.Length - 1
        Dim b As Button
        b.Initialize("Demo")
        Dim v As B4XView = b
        v.Text = names(i)
        v.Tag = i
        v.TextColor = 0xFFF5F5F7
        v.SetColorAndBorder(0xFF252528, 0, 0, 12dip)
        Root.AddView(v, 0, 0, 1dip, 1dip)
        buttons.Add(v)
    Next
    Toast.Initialize(Me, "Toast")
    Toast.CreateViewPerCode(Root, 0, 0, Root.Width, Root.Height)
    Toast.Configure(CreateMap("closeButton": True))
    B4XPage_Resize(Root.Width, Root.Height)
End Sub
Private Sub B4XPage_Resize (Width As Int, Height As Int)
    If buttons.IsInitialized = False Then Return
    For i = 0 To buttons.Size - 1
        Dim v As B4XView = buttons.Get(i)
        v.SetLayoutAnimated(0, 24dip + (i Mod 2) * (Width - 36dip) / 2, 92dip + Floor(i / 2) * 58dip, (Width - 60dip) / 2, 46dip)
    Next
    Toast.Resize(Width, Height)
End Sub
Private Sub Demo_Click
    Dim v As B4XView = Sender
    Select v.Tag
        Case 0: Toast.Show("Hey, Alex", CreateMap("description": "Welcome back"))
        Case 1: Toast.Success("Task completed", CreateMap("description": "Your weekly recap is ready."))
        Case 2: Toast.Error("Something went wrong", CreateMap("description": "Please try again."))
        Case 3: Toast.Info("Switch workspace", CreateMap())
        Case 4: Toast.Warning("Storage almost full", CreateMap())
        Case 5
            loadingId = Toast.Loading("Uploading...", CreateMap("id": "upload"))
            Sleep(1800)
            Toast.Success("Upload complete", CreateMap("id": loadingId, "duration": 4000))
        Case 6
            For i = 1 To 5
                Toast.Show("Notification " & i, CreateMap("description": "Tap to expand. Swipe to dismiss.", "duration": 12000))
                Sleep(150)
            Next
        Case 7
            Toast.Success("At the top", CreateMap("position": "top"))
            Toast.Info("At the bottom", CreateMap("position": "bottom"))
        Case 8
            Toast.Show("Mara's birthday", CreateMap("description": "All day - Today", "action": CreateMap("label": "Open", "Callback": Me, "EventName": "Toast_OpenBirthday"), "cancel": CreateMap("label": "Later")))
        Case 9
            Toast.Custom(CreateMap("Callback": Me, "EventName": "Toast_CustomBody"), CreateMap("duration": 6000))
        Case 10
            Toast.Promise(FakeWork, CreateMap("loading": "Saving...", "success": CreateMap("Callback": Me, "EventName": "Toast_SavedTitle"), "error": "Save failed"))
        Case 11: Toast.DismissAll
    End Select
End Sub
Public Sub Toast_OpenBirthday (Id As Object) 'ignore - Callback signature requires the toast ID.
    Toast.Success("Opening...", CreateMap())
End Sub
Public Sub Toast_CustomBody (Id As Object, Body As B4XView)
    Body.Height = 64dip
    Body.SetColorAndBorder(0xFF292249, 0, 0, 12dip)
    Dim l As Label
    l.Initialize("")
    Dim v As B4XView = l
    v.Text = "Your own B4X layout" & CRLF & "Toast ID: " & Id
    v.TextColor = xui.Color_White
    v.Font = xui.CreateDefaultBoldFont(15)
    Body.AddView(v, 12dip, 8dip, Body.Width - 24dip, 48dip)
End Sub
Private Sub FakeWork As ResumableSub
    Sleep(1500)
    Return CreateMap("success": True, "data": "Everything saved")
End Sub
Public Sub Toast_SavedTitle (Value As Object) As Object
    Return Value
End Sub
Private Sub Toast_Dismiss (Item As Map)
    Log("Dismiss: " & Item.Get("id"))
End Sub
Private Sub Toast_AutoClose (Item As Map)
    Log("AutoClose: " & Item.Get("id"))
End Sub
Private Sub B4XPage_Disappear
    Toast.Pause
End Sub
Private Sub B4XPage_Appear
    Toast.Resume
End Sub
