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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=DigitalInk.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private recognizer As DigitalInk
	Private Panel1 As B4XView
	Private cvs As B4XCanvas
	Private strokes As List
	Private points As List
	Private px, py As Float
	Private AnotherProgressBar1 As AnotherProgressBar
	Private btnRecognize As B4XView
	Private Label1 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "DigitalInk Recognition Example")
	recognizer.Initialize("en")
	cvs.Initialize(Panel1)
	strokes.Initialize
	DownloadModel
End Sub

Private Sub DownloadModel
'	Wait For (recognizer.DeleteModel) Complete (Success As Boolean)
	Wait For (recognizer.IsModelDownloaded) Complete (Downloaded As Boolean)
	If Downloaded Then
		Log("model already downloaded")
		Return
	End If
	btnRecognize.Enabled = False
	AnotherProgressBar1.Visible = True
	Wait For (recognizer.DownloadModel) Complete (Success As Boolean)
	ToastMessageShow("Model downloaded? " & Success, True)
	AnotherProgressBar1.Visible = False
	btnRecognize.Enabled = True
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	cvs.Resize(Panel1.Width, Panel1.Height)
End Sub

Private Sub btnRecognize_Click
	If strokes.Size = 0 Then Return
	Wait For (recognizer.Recognize(Panel1, strokes)) Complete (Result As DigitalInkRecognizerResult)
	If Result.Success = False Then
		Label1.Text = "Error!"
	Else
		Log(Result.Texts)
		Label1.Text = ""
		For Each t As String In Result.Texts
			Label1.Text = Label1.Text & t & CRLF
		Next
	End If
End Sub

Private Sub Panel1_Touch(Action As Int, X As Float, Y As Float)
	Select Action
		Case Panel1.TOUCH_ACTION_DOWN
			Dim points As List
			points.Initialize
		Case Panel1.TOUCH_ACTION_MOVE
			cvs.DrawLine(px, py, X, Y, xui.Color_Black, 2dip)
			points.Add(recognizer.CreateInkPoint(X, Y))
		Case Panel1.TOUCH_ACTION_UP
			strokes.Add(recognizer.CreateStrokeFromPoints(points))
	End Select
	cvs.Invalidate
	py = Y
	px = X
End Sub

Private Sub btnClear_Click
	cvs.ClearRect(cvs.TargetRect)
	cvs.Invalidate
	strokes.Clear
End Sub