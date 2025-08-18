B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private const Server_KEY As String = ""
	
	Private EditTextMsg As B4XView
	
	Public FUser As FirebaseUser
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub ButtonSend_Click
	SendMessage("ios_general",FUser.DisplayName,EditTextMsg.Text)
	EditTextMsg.Text=""
End Sub

Private Sub SendMessage(Topic As String, Title As String, Body As String)
	Dim Job As HttpJob
	Job.Initialize("fcm", Me)
	Dim m As Map = CreateMap("to": $"/topics/${Topic}"$)
	Dim data As Map = CreateMap("title": Title, "body": Body)
	If Topic.StartsWith("ios_") Then
		Dim iosalert As Map =  CreateMap("title": Title, "body": Body, "sound": "default")
		m.Put("notification", iosalert)
		m.Put("priority", 10)
	End If
	m.Put("data", data)
	Dim jg As JSONGenerator
	jg.Initialize(m)
	Job.PostString("https://fcm.googleapis.com/fcm/send", jg.ToString)
	Job.GetRequest.SetContentType("application/json;charset=UTF-8")
	Job.GetRequest.SetHeader("Authorization", "key=" & Server_KEY)
End Sub


Sub JobDone(job As HttpJob)
	'Log(job)
	If job.Success Then
		Log("Success: " & job.GetString)
	End If
	job.Release
	'ExitApplication '!
End Sub


Public Sub setUser(User As FirebaseUser)
	FUser=User
	B4XPages.SetTitle(Me,User.DisplayName)
End Sub

