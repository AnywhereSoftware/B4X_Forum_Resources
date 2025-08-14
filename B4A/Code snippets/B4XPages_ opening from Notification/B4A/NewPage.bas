B4J=true
Group=Pages
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private OldIntent As Intent
	Private xui As XUI 'ignore
End Sub

Public Sub Initialize As Object
	Return Me
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("NewPage")
	B4XPages.SetTitle(Me, "2nd page")
End Sub

Sub B4XPage_Appear
	If B4XPages.GetNativeParent(Me).GetStartingIntent.HasExtra("Notification_Tag") Then
		Dim intent1 As Intent = B4XPages.GetNativeParent(Me).GetStartingIntent
		If IsRelevantIntent(intent1) Then
			Dim page_ID As String = intent1.GetExtra("Notification_Tag")
			others.OpenPage(page_ID)
		End If
	End If
	others.NotifB4XPages("Tap for MainPage", False, False, "MainPage")
End Sub

Private Sub BtnClose_Click
	B4XPages.ClosePage(Me)
	B4XPages.ShowPage("MainPage")
End Sub

Private Sub IsRelevantIntent(in As Intent) As Boolean
	If in.IsInitialized And in <> OldIntent Then
		OldIntent = in
		Return True
	End If
	Return False
End Sub