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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Dialog As B4XDialog
	Private cvs As B4XCanvas
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Dialog.Initialize(Root)
	Dialog.Title = "Testing buttons widths"
	Dialog.ButtonsColor = 0xFF0045CA
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 5dip, 5dip)
	cvs.Initialize(p)
End Sub

Private Sub Button1_Click
	Dim rs As Object = Dialog.Show("Testing", "abcde abc", "fg gf", "hk")
	ArrangeButtons(Dialog, cvs)
	Wait For (rs) Complete (Result As Int)
End Sub

Private Sub ArrangeButtons(Dialog1 As B4XDialog, Canvas1 As B4XCanvas)
	Dim offset As Int = Dialog1.Base.Width - 2dip
	Dim gap As Int = 4dip
	For Each BtnType As Int In Array(xui.DialogResponse_Cancel, xui.DialogResponse_Negative, xui.DialogResponse_Positive)
		For Each btn As B4XView In Dialog1.Base.GetAllViewsRecursive
			If Initialized(btn.Tag) And btn.Tag = BtnType Then 'ignore
				Dim r As B4XRect = Canvas1.MeasureText(btn.Text, btn.Font)
				Dim width As Float = r.Width + 30dip 'change padding as needed
				btn.SetLayoutAnimated(0, offset - width - gap, btn.Top, width, btn.Height)
				offset = offset - width - gap
			End If
		Next
	Next
End Sub

