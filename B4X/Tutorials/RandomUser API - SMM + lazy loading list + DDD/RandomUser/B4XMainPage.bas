B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private dd As DDD
	Private CustomListView1 As CustomListView
	Private btnRefresh As B4XView
	Private AnotherProgressBar1 As AnotherProgressBar
	Private smm As SimpleMediaManager
	Type UserData (Name As String, Location As String, Email As String, Phone As String, Id As String, PictureUrl As String)
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	B4XPages.SetTitle(Me, "RandomUser Example")
	dd.Initialize
	xui.RegisterDesignerClass(dd)
	smm.Initialize
	Root.LoadLayout("MainPage")
	RefreshItems
End Sub

Private Sub btnRefresh_Click
	RefreshItems
End Sub

Private Sub RefreshItems
	btnRefresh.Enabled = False
	AnotherProgressBar1.Visible = True
	Wait For (LoadUsers) Complete (Result As List)
	Log($"Result size: ${Result.Size}"$)
	AnotherProgressBar1.Visible = False
	btnRefresh.Enabled = True
	CustomListView1.Clear
	CustomListView1.sv.ScrollViewOffsetY = 0
	For Each user As UserData In Result
		Dim pnl As B4XView = xui.CreatePanel("")
		pnl.SetLayoutAnimated(0, 0, 0, CustomListView1.AsView.Width, 100dip)
		CustomListView1.Add(pnl, user)
	Next
End Sub

Private Sub LoadUsers As ResumableSub
	Dim res As List = B4XCollections.CreateList(Null)
	Dim j As HttpJob
	j.Initialize("", Me)
	j.Download("https://randomuser.me/api/?results=150&inc=name,location,picture,id,cell,email")
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		Dim json As Map = j.GetString.As(JSON).ToMap
		For Each item As Map In json.Get("results").As(List)
			res.Add(CreateUserDataFromJson(item))
		Next
	Else
		xui.MsgboxAsync("Error: " & j.ErrorMessage, "")
	End If
	j.Release
	Return res
End Sub


Private Sub CreateUserDataFromJson(item As Map) As UserData
	Dim u As UserData
	u.Initialize
	Dim name As Map = item.Get("name")
	u.Name = $"${name.Get("title")} ${name.Get("first")} ${name.Get("last")}"$
	Dim location As Map = item.Get("location")
	Dim street As Map = location.Get("street")
	u.Location = $"${street.Get("name")}, ${street.Get("number")}
${location.Get("city")} ${location.Get("state")} ${location.Get("city")}"$
	u.PictureUrl = item.Get("picture").As(Map).Get("medium")
	Dim id As Map = item.Get("id")
	Dim id_value As String = id.Get("name") & " " & IIf(id.Get("value") <> Null, id.Get("value"), "")
	u.Id = id_value
	u.Email = item.Get("email")
	u.Phone = item.Get("cell")
	Return u
End Sub

Private Sub CustomListView1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	For i = FirstIndex To LastIndex
		Dim pnl As B4XView = CustomListView1.GetPanel(i)
		If pnl.NumberOfViews > 0 Then Continue
		pnl.LoadLayout("UserCard")
		Dim user As UserData = CustomListView1.GetValue(i)
		dd.GetViewByName(pnl, "lblName").Text = user.Name
		dd.GetViewByName(pnl, "lblLocation").Text = user.Location
		dd.GetViewByName(pnl, "lblID").Text = user.Id
		dd.GetViewByName(pnl, "lblEmail").Text = user.Email
		dd.GetViewByName(pnl, "lblPhone").Text = user.Phone
		smm.SetMedia(dd.GetViewByName(pnl, "pnlImage"), user.PictureUrl)
	Next
End Sub

