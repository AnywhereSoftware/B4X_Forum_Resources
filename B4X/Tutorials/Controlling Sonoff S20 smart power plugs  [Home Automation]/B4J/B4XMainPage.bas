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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals

	Private Root As B4XView
	Private xui As XUI
	Private ButtonOff As Button
	Private ButtonOn As Button
	Private ButtonStatus As Button
	Private ButtonToggle As Button
	Private LabelStatus As Label
#If B4J
	Private TextFieldIP As TextField
#Else If B4A
	Private TextFieldIP As EditText
#End If

End Sub

Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)

	Root = Root1
	Root.LoadLayout("MainPage")

End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
Sub Btn_Click

	Dim btn As Button = Sender
	Dim uri As String = "http://" & TextFieldIP.Text & "/cm?cmnd=Power"

	Select Case btn.Tag
		Case ""
			' Status request - uri is already ok
		Case Else ' Button tags (set in Designer) are: On, Off, Toggle
			uri = uri & "%20" & btn.Tag
	End Select

	Try
		Dim Job As HttpJob
		Job.Initialize("ActOnSonoffS20", Me)
		Job.Download(uri)
		Wait For (Job) JobDone(Job As HttpJob)
		If Job.Success Then
			Dim parser As JSONParser
			parser.Initialize(Job.GetString)
			Dim m As Map = parser.NextObject
			LabelStatus.Text = m.GetDefault("POWER", Job.GetString)
		Else
			LabelStatus.Text = Job.ErrorMessage
		End If
		Job.Release
	Catch
		LabelStatus.Text = LastException
	End Try

End Sub

Sub TextFieldIP_TextChanged (Old As String, New As String)

	EnableButtons(IsValidIp(New))

End Sub

Sub IsValidIp(ip As String) As Boolean

	' Code from https://www.b4x.com/android/forum/threads/using-regex-to-validate-an-ip-address.15642/

	Dim m As Matcher
	m = Regex.Matcher("^(\d+)\.(\d+)\.(\d+)\.(\d+)$", ip)
	If m.Find = False Then Return False
	For i = 1 To 4
		If m.Group(i) > 255 Or m.Group(i) < 0 Then Return False
	Next
	Return True

End Sub

Sub EnableButtons(enab As Boolean)

	ButtonOff.Enabled = enab
	ButtonOn.Enabled = enab
	ButtonStatus.Enabled = enab
	ButtonToggle.Enabled = enab

End Sub