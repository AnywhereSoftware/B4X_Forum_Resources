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
'---------------- Class Globals ----------------
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

	Private camex As CamEx2
	Private rp As RuntimePermissions

	Private pnlPreview As Panel
	Private overlayPanel As Panel

	Private Timebitma As Timer
	Private MyTaskIndex As Int

	Private Yolo8 As YOLOv8ANPR
	Private recognizer As TextRecognizer

	Private LblResult As B4XView

	Private OcrBusy As Boolean = False

	' ===== TRACKING =====
	Private TrackedBox As Map
	Private StableBoxCount As Int
	Private OCR_DONE As Boolean
End Sub




Public Sub Initialize As Object
	Return Me
End Sub



Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	overlayPanel.SetLayoutAnimated(0, _
	        pnlPreview.Left, pnlPreview.Top, _
	        pnlPreview.Width, pnlPreview.Height)
	LblResult.TextColor = Colors.Yellow
	LblResult.TextSize = 22
	LblResult.BringToFront
	LblResult.Visible = True

	overlayPanel.Color = Colors.Transparent
	overlayPanel.Enabled = False
	overlayPanel.BringToFront

	Yolo8.Initialize("best_float16.tflite")
	recognizer.Initialize("Latin")

	Timebitma.Initialize("TimBtmap", 350)
	rp.CheckAndRequest(rp.PERMISSION_CAMERA)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result Then
Log("OK")
		StartCamera
	Else
		ToastMessageShow("No Permessi!!!", True)
	End If
	

End Sub


'---------------- Camera ----------------
Private Sub StartCamera
	camex.Initialize(pnlPreview)
	Wait For (camex.OpenCamera(False)) Complete (TaskIndex As Int)
	If TaskIndex > 0 Then
		MyTaskIndex = TaskIndex
		Wait For (camex.PrepareSurface(MyTaskIndex)) Complete (Success As Boolean)
		If Success Then
			camex.StartPreview(MyTaskIndex, False)
			Timebitma.Enabled = True
		End If
	End If
End Sub



'---------------- Timer Tick ----------------
Sub TimBtmap_Tick
	If OcrBusy Then Return

	Dim frame As Bitmap = camex.GetPreviewBitmap(640, 640)
	If frame.IsInitialized = False Then Return

	Timebitma.Enabled = False
	CallSubDelayed2(Me, "YoloRun", frame)
End Sub




'---------------- YOLO + Overlay ----------------
Sub YoloRun(frame As Bitmap)
	Try
		Dim results As List = Yolo8.Run(frame)
		DrawOverlay(frame, results)
	Catch
		Log(LastException)
	End Try
	Timebitma.Enabled = True
End Sub



Sub DrawOverlay(frame As Bitmap, BoxList As List)

	Dim cvs As Canvas
	cvs.Initialize(overlayPanel)
	cvs.DrawColor(Colors.Transparent)

	Dim scaleX As Float = overlayPanel.Width / frame.Width
	Dim scaleY As Float = overlayPanel.Height / frame.Height
	Dim scale As Float = Min(scaleX, scaleY)

	Dim dx As Float = (overlayPanel.Width - frame.Width * scale) / 2
	Dim dy As Float = (overlayPanel.Height - frame.Height * scale) / 2

	For Each box As Map In BoxList

		Dim cx As Float = box.Get("x")
		Dim cy As Float = box.Get("y")
		Dim w  As Float = box.Get("w")
		Dim h  As Float = box.Get("h")

		Dim left   As Float = (cx - w / 2) * scale + dx
		Dim top    As Float = (cy - h / 2) * scale + dy
		Dim right  As Float = (cx + w / 2) * scale + dx
		Dim bottom As Float = (cy + h / 2) * scale + dy

		Dim r As Rect
		r.Initialize(left, top, right, bottom)
		cvs.DrawRect(r, Colors.Red, False, 4dip)

		' ===== TRACKING =====
		If IsSameBox(box, TrackedBox) Then
			StableBoxCount = StableBoxCount + 1
		Else
			TrackedBox = box
			StableBoxCount = 1
			OCR_DONE = False
		End If

		Log($"STABLE=${StableBoxCount} OCR_DONE=${OCR_DONE}"$)

		If StableBoxCount >= 2 And OCR_DONE = False Then
			OCR_DONE = True
			Log(">>> AVVIO OCR <<<")
			Dim plate As Bitmap = CropPlate(frame, box)
			If plate.IsInitialized Then StartOCR(plate)
		End If

		Exit

	Next

	overlayPanel.Invalidate
End Sub


Sub IsSameBox(b1 As Map, b2 As Map) As Boolean
	If b1.IsInitialized = False Or b2.IsInitialized = False Then Return False

	Dim dx As Float = Abs(b1.Get("x") - b2.Get("x"))
	Dim dy As Float = Abs(b1.Get("y") - b2.Get("y"))

	Return dx < 40 And dy < 40   ' <<< PRIMA ERA 15
End Sub


Sub StartOCR(plate As Bitmap)
	If OcrBusy Then Return
	OcrBusy = True

	Log("OCR START")

	Dim plate2 As Bitmap = plate.Resize(360, plate.Height * 360 / plate.Width, True)

	Wait For (recognizer.Recognize(plate2)) Complete (res As TextRecognizerResult)

	Log("OCR DONE SUCCESS=" & res.Success)
	Log("OCR TEXT=" & res.Text)

	If res.Success Then
		Dim txt As String = res.Text.Replace(" ", "")
		LblResult.Text = txt
	End If

	OcrBusy = False
End Sub




'---------------- Ritaglio targa ----------------
Sub CropPlate(frame As Bitmap, box As Map) As Bitmap
	Dim cx As Float = box.Get("x")
	Dim cy As Float = box.Get("y")
	Dim w  As Float = box.Get("w")
	Dim h  As Float = box.Get("h")

	Dim left   As Int = Max(0, cx - w / 2)
	Dim top    As Int = Max(0, cy - h / 2)
	Dim right  As Int = Min(frame.Width, cx + w / 2)
	Dim bottom As Int = Min(frame.Height, cy + h / 2)

	Dim bw As Int = right - left
	Dim bh As Int = bottom - top
	If bw <= 0 Or bh <= 0 Then Return Null

	Dim bmp As Bitmap
	bmp.InitializeMutable(bw, bh)

	Dim cvs As Canvas
	cvs.Initialize2(bmp)

	Dim src, dst As Rect
	src.Initialize(left, top, right, bottom)
	dst.Initialize(0, 0, bw, bh)

	cvs.DrawBitmap(frame, src, dst)
	Return bmp
End Sub




