B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
Sub Class_Globals
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private SelectedAlpha As Int = 255
	Private bcColors As BitmapCreator
	Private selectedH = 60, selectedS = 0.5, selectedV = 0.5 As Float
	Private DeviceScale, ColorScale As Float
	Private tempBC As BitmapCreator
	Private const DONT_CHANGE As Int = -999999999
'	Type ColorPickerPart (cvs As B4XCanvas, pnl As B4XView, iv As B4XView, checkersCanvas As B4XCanvas, DrawCheckers As Boolean)
	Private HueBar, ColorPicker, AlphaBar As ColorPickerPart
	Private BordersColor As Int
	Private xDialog As B4XDialog
	Private InitialColor() As Object
	Private ColorTextPnl As B4XView
	Private ColorTextLbl As Label
	Private ColorTextField As TextField
	Private mNoAlpha,mWebColors As Boolean
End Sub

Public Sub Initialize
	tempBC.Initialize(1, 1)
	DeviceScale = 100dip / 100
	mBase = xui.CreatePanel("")
	mBase.SetLayoutAnimated(0, 0, 0, 300dip, 280dip)		'+30 for text area
	BordersColor = xui.Color_Black
	mBase.SetColorAndBorder(BordersColor, 1dip, BordersColor, 2dip)
	HueBar = CreatePanelForBitmapCreator("hueBar", False)
	ColorPicker = CreatePanelForBitmapCreator("colors", True)
	AlphaBar = CreatePanelForBitmapCreator("alpha", True)
	
	ColorTextPnl = xui.CreatePanel("")
	ColorTextPnl.SetLayoutAnimated(0,0,0,0,0)
	
	
	ColorTextLbl.Initialize("ColorLabel")
	ColorTextLbl.SetLayoutAnimated(0,0,0,0,0)
	ColorTextLbl.Alignment = "CENTER"
	ColorTextLbl.As(B4XView).Color = xui.Color_ARGB(0xFF,0X05,0x05,0x05)
	ColorTextLbl.As(B4XView).TextColor = xui.Color_LightGray
	ColorTextLbl.Text = "0x000000"
	ColorTextLbl.TooltipText = "Click to enter color"
	SetTooltipTextSize(ColorTextLbl,12)
	ColorTextPnl.AddView(ColorTextLbl,0,0,0,0)
	
	Dim W As Double = 150
	Dim H As Double = 30
	
	ColorTextField.Initialize("ColorTextField")
	ColorTextField.SetLayoutAnimated(0,0,0,W,H)
	ColorTextField.As(B4XView).Color = xui.Color_RGB(0x20,0x20,0x20)
	ColorTextField.As(B4XView).TextColor = xui.Color_LightGray
	ColorTextField.As(B4XView).TextColor = xui.Color_LightGray
	ColorTextField.Visible = False
	ColorTextPnl.AddView(ColorTextField,0,0,0,0)
	mBase.AddView(ColorTextPnl,0,0,0,0)
	Base_Resize(mBase.Width, mBase.Height)
	
	
	Dim O As Object = mBase.As(JavaObject).CreateEventFromUI("javafx.event.EventHandler","BaseMousePressed",Null)
	mBase.As(JavaObject).RunMethod("setOnMousePressed",Array(O))
End Sub

Private Sub CreatePanelForBitmapCreator (EventName As String, WithCheckers As Boolean) As ColorPickerPart
	Dim cpp As ColorPickerPart
	cpp.Initialize
	cpp.pnl = xui.CreatePanel("")
	cpp.pnl.SetColorAndBorder(BordersColor, 1dip, BordersColor, 0)
	cpp.pnl.SetLayoutAnimated(0, 1dip, 1dip, 1dip, 1dip)
	If WithCheckers Then
		cpp.checkersCanvas.Initialize(cpp.pnl)
		cpp.DrawCheckers = True
	End If
	Dim iv As ImageView
	iv.Initialize("")
	cpp.iv = iv
	Dim overlay As B4XView = xui.CreatePanel(EventName)
	cpp.pnl.AddView(iv, 0, 0, 0, 0)
	cpp.pnl.AddView(overlay, 1dip, 1dip, 1dip, 1dip)
	cpp.cvs.Initialize(overlay)
	mBase.AddView(cpp.pnl, 0, 0, 0, 0)
	Return cpp
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	'color scale is used to decrease the surface size and improve the performance
	ColorScale = Max(1, Max(Width, Height) / 100 / DeviceScale)
	HueBar.pnl.SetLayoutAnimated(0, 1dip, 1dip, 30dip, Height - 2dip)
	Dim r As Int = HueBar.pnl.Width + HueBar.pnl.Left + 1dip
	Dim w As Int = Width - r - 1dip
	If xui.IsB4i Then
		r = r - 1
		w = w + 1
	End If
	
	If mNoAlpha Then
		AlphaBar.pnl.SetLayoutAnimated(0, r, Height - 31dip ,w, 30dip)								'Changed 31 to 62
		ColorTextPnl.SetLayoutAnimated(0,r, Height - 31dip,w,30dip)

		ColorTextPnl.BringToFront
	Else

		AlphaBar.pnl.SetLayoutAnimated(0, r, Height - 62dip,w, 30dip)								'Changed 31 to 62
		ColorTextPnl.SetLayoutAnimated(0,r, Height - 31dip,w,30dip)
	End If
	
	ColorTextLbl.SetLayoutAnimated(0,0, 0,w,30dip)
	Dim L As Int = (w -150dip) / 2
	ColorTextField.SetLayoutAnimated(0,L,0,150dip,ColorTextPnl.Height)
	Dim Adj As Int = ColorTextPnl.Height + AlphaBar.pnl.Height
	If mNoAlpha Then Adj = Adj - ColorTextPnl.Height
	ColorPicker.pnl.SetLayoutAnimated(0, r, 1dip, w, Height - 3dip - Adj)
	bcColors.Initialize(ColorPicker.pnl.Width / ColorScale, ColorPicker.pnl.Height / ColorScale)
	For Each cpp As ColorPickerPart In Array(HueBar, ColorPicker, AlphaBar)
		For i = 0 To cpp.pnl.NumberOfViews - 1
			cpp.pnl.GetView(i).SetLayoutAnimated(0, 0, 0, cpp.pnl.Width, cpp.pnl.Height)
		Next
		cpp.cvs.Resize(cpp.pnl.Width, cpp.pnl.Height)
		If cpp.DrawCheckers Then
			DrawCheckers(cpp)
		End If
	Next
	DrawHueBar
	DrawAlphaBar
	HueBarSelectedChanged (selectedH / 360 * HueBar.pnl.Height)
	AlphaBarSelectedChange (SelectedAlpha / 255 * AlphaBar.pnl.Width)
	

End Sub

Private Sub DrawCheckers (cpp As ColorPickerPart)
	cpp.checkersCanvas.Resize(cpp.pnl.Width, cpp.pnl.Height)
	cpp.checkersCanvas.ClearRect(cpp.checkersCanvas.TargetRect)
	Dim size As Int = 10dip
	Dim clrs() As Int = Array As Int(0xFFC0C0C0, 0xFF757575)
	Dim clr As Int = 0
	Dim r As B4XRect
	For x = 0 To cpp.checkersCanvas.TargetRect.Right - 1dip Step size
		Dim xx As Int = x / size
		clr = xx Mod 2
		For y = 0 To cpp.checkersCanvas.TargetRect.Bottom - 1dip Step size
			clr = (clr + 1) Mod 2
			r.Initialize(x, y, x + size, y + size)
			cpp.checkersCanvas.DrawRect(r, clrs(clr), True, 0)
		Next
	Next
	cpp.checkersCanvas.Invalidate
End Sub

Private Sub DrawHueBar
	Dim bcHue As BitmapCreator
	bcHue.Initialize(HueBar.pnl.Width / DeviceScale, HueBar.pnl.Height / DeviceScale)
	For y = 0 To bcHue.mHeight - 1
		For x = 0 To bcHue.mWidth - 1
			bcHue.SetHSV(x, y, 255, 360 / bcHue.mHeight * y, 1, 1)
		Next
	Next
	HueBar.iv.SetBitmap(bcHue.Bitmap)
End Sub

Private Sub DrawAlphaBar
	Dim bc As BitmapCreator
	bc.Initialize(AlphaBar.pnl.Width / DeviceScale, AlphaBar.pnl.Height / DeviceScale)
	Dim argb As ARGBColor
	argb.r = 0xcc
	argb.g = 0xcc
	argb.b = 0xcc
	
	For y = 0 To bc.mHeight - 1
		For x = 0 To bc.mWidth - 1
			argb.a = x / bc.mWidth * 255
			bc.SetARGB(x, y, argb)
		Next
	Next
	AlphaBar.iv.SetBitmap(bc.Bitmap)
End Sub

Private Sub DrawColors
	For x = 0 To bcColors.mWidth - 1
		For y = 0 To bcColors.mHeight - 1
			bcColors.SetHSV(x, y, SelectedAlpha, selectedH, _
				x / bcColors.mWidth, (bcColors.mHeight - y) / bcColors.mHeight)
		Next
	Next
	ColorPicker.iv.SetBitmap(bcColors.Bitmap.Resize(ColorPicker.iv.Width, ColorPicker.iv.Height, False))
End Sub

Private Sub HueBarSelectedChanged (y As Float)
	selectedH = Max(0, Min(360, 360 * y / HueBar.pnl.Height))
	y = selectedH * HueBar.pnl.Height / 360
	HueBar.cvs.ClearRect(HueBar.cvs.TargetRect)
	Dim r As B4XRect
	r.Initialize(0, y - 3dip, HueBar.cvs.TargetRect.Right, y + 3dip)
	HueBar.cvs.DrawRect(r, xui.Color_White, False, 2dip)
	HueBar.cvs.Invalidate
	Update
End Sub

Private Sub AlphaBarSelectedChange(x As Float)
	SelectedAlpha = 255 * Max(0, Min(1, x / AlphaBar.pnl.Width))
	x = SelectedAlpha / 255 * AlphaBar.pnl.Width
	AlphaBar.cvs.ClearRect(AlphaBar.cvs.TargetRect)
	Dim r As B4XRect
	r.Initialize(x - 3dip, 1dip, x + 3dip, AlphaBar.cvs.TargetRect.Bottom - 1dip)
	AlphaBar.cvs.DrawRect(r, xui.Color_Black, True, 2dip)
	AlphaBar.cvs.Invalidate
	Update
End Sub

Private Sub Update
	DrawColors
	HandleSelectedColorChanged(DONT_CHANGE, DONT_CHANGE)
	ColorChanged(getSelectedColor)
End Sub

Private Sub HandleSelectedColorChanged (x As Int, y As Int)
	If x <> DONT_CHANGE Then
		selectedS = Max(0, Min(1, x / ColorPicker.pnl.Width))
		selectedV = Max(0, Min(1, (ColorPicker.pnl.Height - y) / ColorPicker.pnl.Height))
	End If
	ColorPicker.cvs.ClearRect(ColorPicker.cvs.TargetRect)
	ColorPicker.cvs.DrawCircle(selectedS * ColorPicker.pnl.Width, ColorPicker.pnl.Height - selectedV * ColorPicker.pnl.Height, _
		 10dip, xui.Color_White, False, 2dip)
	ColorPicker.cvs.Invalidate
	UpdateBarColor
End Sub

'Returns the selected color in the appropriate Hex format
Public Sub getSelectedColorString As String
	Return (ColorToHex(getSelectedColor))
End Sub

Public Sub getSelectedColor As Int
	Dim hsv() As Object = getSelectedHSVColor
	tempBC.SetHSV(0, 0, SelectedAlpha, hsv(0), hsv(1), hsv(2))
	Return tempBC.GetColor(0, 0)
End Sub

Public Sub setSelectedColor(i As Int)
	If mNoAlpha Then i = Bit.Or(i,0xFF000000)
	setSelectedHSVColor(ColorToHSV(i))
	ColorChanged(getSelectedColor)
End Sub

'Gets or sets the selected color. The value is an array with: H, S, V and Alpha.
Public Sub getSelectedHSVColor As Object()
	Return Array (selectedH, selectedS, selectedV, SelectedAlpha)
End Sub

Public Sub setSelectedHSVColor (HSV() As Object)
	selectedH = HSV(0)
	selectedS = HSV(1)
	selectedV = HSV(2)
	Dim Alpha As Int = HSV(3)
	If mNoAlpha Then Alpha = 255
	SelectedAlpha = Alpha
	HueBarSelectedChanged(selectedH / 360 * HueBar.pnl.Height)
	AlphaBarSelectedChange(SelectedAlpha / 255 * AlphaBar.pnl.Width)
	ColorChanged(getSelectedColor)
End Sub

Public Sub ColorToHSV(clr As Int) As Object()
	Dim a As Int = Bit.And(0xff, Bit.UnsignedShiftRight(clr, 24))
	Dim r As Int = Bit.And(0xff, Bit.UnsignedShiftRight(clr, 16)) 
	Dim g As Int = Bit.And(0xff, Bit.UnsignedShiftRight(clr, 8))
	Dim b As Int = Bit.And(0xff, Bit.UnsignedShiftRight(clr, 0)) 
	Dim h, s, v As Float
	Dim cmax As Int = Max(Max(r, g), b)
	Dim cmin As Int = Min(Min(r, g), b)
	v = cmax / 255
	If cmax <> 0 Then
		s = (cmax - cmin) / cmax
	End If
	If s = 0 Then
		h = 0
	Else
		Dim rc As Float = (cmax - r) / (cmax - cmin)
		Dim gc As Float = (cmax - g) / (cmax - cmin)
		Dim bc As Float = (cmax - b) / (cmax - cmin)
		If r = cmax Then
			h = bc - gc
		Else If g = cmax Then
			h = 2 + rc - bc
		Else
			h = 4 + gc - rc
		End If
		h = h / 6
		If h < 0 Then h = h + 1
	End If
	Return Array (h * 360, s, v, a)		
End Sub

Public Sub GetPanel (Dialog As B4XDialog) As B4XView
	Return mBase
End Sub

Private Sub Show (Dialog As B4XDialog)
	InitialColor = getSelectedHSVColor
	xDialog = Dialog
'	If mNoAlpha Then
'		mBase.GetView(mBase.NumberOfViews-2).Visible = False
'		AlphaBar.pnl.Visible = False
'	Else
'		AlphaBar.pnl.Visible = True
'		mBase.GetView(mBase.NumberOfViews-2).Visible = True
'	End If
	Sleep(0)
	UpdateBarColor
End Sub

Private Sub DialogClosed(Result As Int)
	If Result <> xui.DialogResponse_Positive Then
		setSelectedHSVColor(InitialColor)	
	End If
End Sub

Private Sub UpdateBarColor
	If xDialog.IsInitialized And xDialog.TitleBar.IsInitialized Then
		xDialog.TitleBar.Color = getSelectedColor
	End If
End Sub

Private Sub Colors_Touch (Action As Int, X As Float, Y As Float)
	If Action = mBase.TOUCH_ACTION_MOVE_NOTOUCH Then Return
	HandleSelectedColorChanged(X, Y)
	
	ColorChanged(getSelectedColor)
	
End Sub

Private Sub HueBar_Touch (Action As Int, X As Float, Y As Float)
	If Action = mBase.TOUCH_ACTION_MOVE_NOTOUCH Then Return
	HueBarSelectedChanged(Y)
	
	ColorChanged(getSelectedColor)
End Sub

Private Sub Alpha_Touch (Action As Int, X As Float, Y As Float)
	If Action = mBase.TOUCH_ACTION_MOVE_NOTOUCH Then Return
	AlphaBarSelectedChange(x)
	
	ColorChanged(getSelectedColor)
End Sub


'
'
'			Modifications
'
'

Public Sub setNoAlpha(Ignore As Boolean)
	mNoAlpha = Ignore
	setSelectedColor(Bit.Or(getSelectedColor,0xFF000000))
	Base_Resize(mBase.Width,mBase.Height)
End Sub

Public Sub setWebColors(On As Boolean)
	mWebColors = On
	setNoAlpha(On)
End Sub

Private Sub ColorChanged(Color As Int)
'	If ColorTextLbl.IsInitialized Then
		ColorTextLbl.Text = $"${ColorToHex(Color)}"$
		If xDialog.IsInitialized Then xDialog.TitleBar.GetView(0).TextColor = ContrastColor(Color)
'	End If
End Sub

Private Sub BaseMousePressed_Event (MethodName As String, Args() As Object)
	Sleep(0)
	If ColorTextField.Visible Then
		ColorTextField.Text = ""
		ColorValid(ColorTextField)
		Args(0).As(JavaObject).RunMethod("consume",Null)
	End If
End Sub

Public Sub ColorToHex(clr As Int) As String
	Dim bc As ByteConverter
	Dim ColorString As String =  bc.HexFromBytes(bc.IntsToBytes(Array As Int(clr)))
	If mWebColors Then
		Return ("#" & ColorString.SubString(2))
	Else
		Return ("0x" & ColorString)
	End If
End Sub

Public Sub ContrastColor(Color As Int) As Int
	'From https://stackoverflow.com/a/41335343
	'Counting the perceptive luminance - human eye favors green color...
	'                                        Red                                           Green                                       Blue
	Dim A As Double = 1 - (0.299 * Bit.And(Bit.ShiftRight(Color,16),0xFF) + 0.587 * Bit.And(Bit.ShiftRight(Color,8),0XFF) + 0.114 * Bit.And(Color,0xFF)) / 255
	If A < 0.5 Then
		Return xui.Color_Black
	Else
		Return xui.Color_White
	End If
End Sub

Public Sub SetTooltipTextSize(N As B4XView, Size As Double)
	Try
		Dim F As B4XFont = xui.CreateFont(N.Font,Size)
		Dim Tooltip As JavaObject = N.As(JavaObject).RunMethod("getTooltip",Null)
		Tooltip.RunMethod("setFont",Array(F))
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub ColorValid(TTF As B4XView) As Boolean
	If TTF.Text = "" Then
		TTF.Visible = False
		Return True
	End If
	Dim Colorstr As String = TTF.Text
'	Log(Colorstr)
	
	Select True
		Case Regex.IsMatch($"^(?:[0-9a-fA-F]{3})$"$,Colorstr)
'			Log("type 1 fff")
			Colorstr = "#" & Colorstr
			
		Case Regex.IsMatch($"^0x(?:[0-9a-fA-F]{3})$"$,Colorstr)
'			Log("type 2 0xfff")
			Colorstr = "#" & Colorstr.SubString(2)

		Case Regex.IsMatch($"^(?:[0-9a-fA-F]{4})$"$,Colorstr)
'			Log("Type 3 afff")
			Colorstr = $"#${Colorstr.SubString(1)}${Colorstr.SubString2(0,1)}"$
			
		Case Regex.IsMatch($"^0x(?:[0-9a-fA-F]{4})$"$,Colorstr)
'			Log("Type 4  0xafff")
			Colorstr = $"#${Colorstr.SubString(3)}${Colorstr.SubString2(2,3)}"$
		
		Case Regex.IsMatch($"^(?:[0-9a-fA-F]{3})$"$,Colorstr)
'			Log("Type 5 ffffff" )
			Colorstr = "#" & Colorstr
			
		Case Regex.IsMatch($"^0x(?:[0-9a-fA-F]{3})$"$,Colorstr)
'			Log("Type 6 ffffff" )
			Colorstr = "#" & Colorstr.SubString(2)
			
		Case Regex.IsMatch($"^(?:[0-9a-fA-F]{4}){2}$"$,Colorstr)
'			Log("Type 7 aaffffff" )
			Colorstr = $"#${Colorstr.SubString(2)}${Colorstr.SubString2(0,2)}"$
			
		Case Regex.IsMatch($"^0x(?:[0-9a-fA-F]{4}){2}$"$,Colorstr)
'			Log("Type 8 0xaaffffff")
			Colorstr = $"#${Colorstr.SubString(4)}${Colorstr.SubString2(2,4)}"$
	End Select
'	Log(Colorstr)
	
	Dim ColorClass As JavaObject
	ColorClass.InitializeStatic("javafx.scene.paint.Color")
	Try
		TTF.SetColorAndBorder(TTF.Color,0,xui.Color_Red,0)
		Dim Color As Int = xui.PaintOrColorToColor(ColorClass.RunMethod("web",Array(Colorstr)))
	Catch
		TTF.SetColorAndBorder(TTF.Color,1,xui.Color_Red,0)
		TTF.RequestFocus
		TTF.RequestFocus
		Return False
	End Try
	setSelectedColor(Color)
	TTF.SetColorAndBorder(TTF.Color,0,xui.Color_Red,0)
	TTF.Visible = False
	Return True
End Sub

Private Sub ColorTextField_Action
	'Force validation through Focus changed so it doesn't happen twice
	mBase.RequestFocus
End Sub

Private Sub ColorTextField_FocusChanged (HasFocus As Boolean)
	If HasFocus = False Then ColorValid(ColorTextField)
End Sub

Private Sub ColorLabel_MousePressed (EventData As MouseEvent)
	EventData.Consume
	If ColorTextField.Visible Then
		ColorTextField.Text = ""
		ColorValid(ColorTextField)
	Else
		ColorTextField.Visible = True
		ColorTextField.Text = ColorTextLbl.Text
		ColorTextField.RequestFocus
	End If
End Sub