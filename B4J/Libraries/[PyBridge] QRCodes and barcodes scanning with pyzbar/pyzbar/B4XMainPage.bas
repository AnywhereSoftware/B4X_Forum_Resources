B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
'Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe


'requirements:
'pip install pyzbar
'pip install Pillow

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Py As PyBridge
	Private pyzbar As PyWrapper
	Private PILImage As PyWrapper
	Type DecodedBarcode (Data() As Byte, BarcodeType As String, Rect As B4XRect, pnl As B4XView, lbl as B4XView)
	Private CurrentResult As List
	Private TextArea1 As B4XView
	Private ImageView1 As B4XView
	Private FileChooser1 As FileChooser
	Private Pane1 As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Py.Initialize(Me, "Py")
	Dim opt As PyOptions = Py.CreateOptions("Python/python/python.exe")
	Py.Start(opt)
	Wait For Py_Connected (Success As Boolean)
	If Success = False Then
		LogError("Failed to start Python process.")
		Return
	End If
	pyzbar = Py.ImportModule("pyzbar.pyzbar")
	PILImage = Py.ImportModuleFrom("PIL", "Image")
	FileChooser1.Initialize
	FileChooser1.setExtensionFilter("Image", Array As String("*.jpg", "*.png"))
	CurrentResult = B4XCollections.CreateList(Null)
End Sub

Private Sub Button1_Click
	Dim img As String = FileChooser1.ShowOpen(B4XPages.GetNativeParent(Me))
	If img <> "" Then
		TextArea1.Text = ""
		ImageView1.SetBitmap(xui.LoadBitmap(img, ""))
		For Each bar As DecodedBarcode In CurrentResult
			bar.pnl.RemoveViewFromParent
		Next
		CurrentResult.Clear
		Wait For (Decode(img)) Complete (Result As List)
		CurrentResult = Result
		If Result.Size > 0 Then
			Dim sb As StringBuilder
			sb.Initialize
			Dim counter As Int = 1
			For Each bar As DecodedBarcode In Result
				sb.Append(counter).Append(": (").Append(bar.BarcodeType).Append(") ").Append(BytesToString(bar.Data, 0, bar.Data.Length, "utf8")).Append(CRLF)
				bar.lbl.Text = counter
				counter = counter + 1
			Next
			TextArea1.Text = sb.ToString
			DrawBarcodes
		End If
	End If
End Sub

Private Sub Pane1_Resize (Width As Double, Height As Double)
	DrawBarcodes
End Sub

Private Sub DrawBarcodes
	If NotInitialized(ImageView1.GetBitmap) Then Return
	Dim imgwidth As Double = ImageView1.GetBitmap.Width
	Dim imgheight As Double = ImageView1.GetBitmap.Height
	Dim ImgRatio As Double = imgheight / imgwidth
	Dim ViewRatio As Double = Pane1.Height / Pane1.Width
	Dim Scale As Double
	Dim Left = 0, Top = 0 As Double
	If ViewRatio > ImgRatio Then
		Scale = imgwidth / Pane1.Width
	Else
		Scale = imgheight / Pane1.Height
	End If
	For Each bar As DecodedBarcode In CurrentResult
		bar.pnl.SetLayoutAnimated(0, Left + bar.Rect.Left / Scale, Top + bar.Rect.Top / Scale, bar.Rect.Width / Scale, bar.Rect.Height / Scale)
		bar.lbl.SetLayoutAnimated(0, 0, 0, bar.pnl.Width, bar.pnl.Height)
	Next
End Sub

Private Sub Decode(ImagePath As String) As ResumableSub
	Dim img As PyWrapper = PILImage.Run("open").Arg(ImagePath)
	Dim decoded As PyWrapper = pyzbar.Run("decode").Arg(img)
	Dim decoded2 As PyWrapper = Py.Map_(Py.Lambda("d: (d.type, d.data, (d.rect.left, d.rect.top, d.rect.width, d.rect.height))"), decoded).ToList
	decoded.Print
	Wait For (decoded2.Fetch) Complete (decoded2 As PyWrapper)
	Dim res As List = B4XCollections.CreateList(Null)
	If decoded2.IsSuccess Then
		For Each d() As Object In decoded2.Value.As(List)
			Dim r() As Object = d(2)
			res.Add(CreateDecodedBarcode(d(1), d(0), r(0), r(1), r(2), r(3)))
		Next
		If res.Size = 0 Then
			TextArea1.Text = "No codes found!"
		End If
	Else
		TextArea1.Text = "Error: " & decoded2.ErrorMessage
	End If
	Return res
End Sub


Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub


Public Sub CreateDecodedBarcode (Data() As Byte, BarcodeType As String, Left As Double, Top As Double, Width As Double, Height As Double) As DecodedBarcode
	Dim t1 As DecodedBarcode
	t1.Initialize
	t1.Data = Data
	t1.BarcodeType = BarcodeType
	Dim r As B4XRect
	r.Initialize(Left, Top, Left + Width, Top + Height)
	t1.Rect = r
	t1.pnl = xui.CreatePanel("")
	t1.pnl.SetColorAndBorder(xui.Color_Transparent, 2dip, xui.Color_Red, 2dip)
	t1.lbl = XUIViewsUtils.CreateLabel
	t1.lbl.SetTextAlignment("CENTER", "CENTER")
	t1.lbl.Font = xui.CreateDefaultBoldFont(28)
	t1.lbl.TextColor = xui.Color_Red
	t1.pnl.AddView(t1.lbl, 0, 0, 0, 0)
	Pane1.AddView(t1.pnl, 0, 0, 0, 0)
	Return t1
End Sub


