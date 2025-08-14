B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=13.1
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim Notif1 As Notification
End Sub

Sub NotifB4XPages(Content As String, Insistent As Boolean, Sound As Boolean, B4XPage_Name As String)
	If Notif1.IsInitialized = False Then
		Notif1.Initialize
	End If

	Dim n As Notification
	If Sound Then
		n.Initialize2(n.IMPORTANCE_DEFAULT)
	Else
		n.Initialize2(n.IMPORTANCE_LOW)
	End If
	
	n.Sound = Sound
	n.Vibrate = Sound
	n.Insistent = Insistent
	If Content <> "" Then
		n.Icon = "icon"
	Else
		n.Icon = ""
	End If
	n.AutoCancel = True
	n.Light = Sound
	If B4XPage_Name = "" Then
		n.SetInfo("", Content, Main)
	Else
		n.SetInfo2("", Content, B4XPage_Name, Main)   'The single Activity is always Main
	End If
	Notif1 = n
	Notif1.Notify(1)	'notification id
End Sub

Sub OpenPage(id As String)
	B4XPages.ShowPage(id)
End Sub
