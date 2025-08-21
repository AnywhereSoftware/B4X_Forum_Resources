B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
#Event: ColorSet (ColorValue As Int)
Sub Class_Globals
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private SelectedAlpha As Int = 255
	Private bcColors As BitmapCreator
	Private selectedH = 60, selectedS = 0.5, selectedV = 0.5 As Float
	Private DeviceScale, ColorScale As Float
	Private const DONT_CHANGE As Int = -999999999
	Private HueBar, ColorPicker, AlphaBar As ColorPickerPart
	Private BordersColor As Int = xui.Color_White
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public Tag As Object
	Private lstColors As CustomListView
	Private ByteConverter As ByteConverter
	Private CurrentSelectedHex As String
	Private TextChangedIndex As Int
	Public txtNewValue As B4XFloatTextField
	Private ColorPanel As B4XView
	Private ColorLabel As B4XView
	Private MapOfNamedColors As Map
	Private CSelections As CLVSelections
	Private pnlPreview As B4XView
	Public pnlPrevValue As B4XView
End Sub


Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	DeviceScale = 100dip / 100
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	
	HueBar = CreatePanelForBitmapCreator("hueBar", False)
	ColorPicker = CreatePanelForBitmapCreator("colors", True)
	AlphaBar = CreatePanelForBitmapCreator("alpha", True)
	Sleep(0)
	mBase.LoadLayout("BCColorPicker")
	CSelections.Initialize(lstColors)
	CSelections.Mode = CSelections.MODE_SINGLE_ITEM_PERMANENT
	CreateListOfColorsLayout
	mBase.SetColorAndBorder(BordersColor, 2dip, BordersColor, 2dip)
	For Each t As B4XFloatTextField In Array(txtNewValue)
		t.LargeLabelTextSize = 14
		t.SmallLabelTextSize = 10
		t.Update
		t.TextField.SetColorAndBorder(xui.Color_Transparent, 1, 0xFFD2D2D2, 0)
	Next
	Base_Resize(mBase.Width, mBase.Height)
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
	Dim w As Int = Max(10dip, Width - r - 314dip)
	If xui.IsB4i Then
		r = r - 1
		w = w + 1
	End If
	AlphaBar.pnl.SetLayoutAnimated(0, r, Height - 31dip,w, 30dip)
	ColorPicker.pnl.SetLayoutAnimated(0, r, 1dip, w, Height - 3dip - AlphaBar.pnl.Height)
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
	If txtNewValue.IsInitialized Then
		Dim SelectedColor As Int = getSelectedColor
		pnlPreview.Color = SelectedColor
		CurrentSelectedHex = ColorToHex(SelectedColor)
		txtNewValue.Text = CurrentSelectedHex
		If MapOfNamedColors.ContainsKey(SelectedColor) Then
			Dim ItemIndex As Int = MapOfNamedColors.Get(SelectedColor)
			CSelections.SelectAndMakeVisible(ItemIndex)
		Else
			CSelections.Clear
		End If
	End If
End Sub

Public Sub ColorToHex(clr As Int) As String
	Return ByteConverter.HexFromBytes(ByteConverter.IntsToBytes(Array As Int(clr)))
End Sub

Public Sub HexToColor(Hex As String) As Int
	If Hex.StartsWith("#") Then 
		Hex = Hex.SubString(1)
	Else If Hex.StartsWith("0x") Then 
		Hex = Hex.SubString(2)
	Else If Hex.Length = 6 Then
		Hex = "FF" & Hex
	End If
	Dim ints() As Int = ByteConverter.IntsFromBytes(ByteConverter.HexToBytes(Hex))
	Return ints(0)
End Sub

Public Sub getSelectedColor As Int
	Dim HSV() As Object = getSelectedHSVColor
	Return HSVToColor(SelectedAlpha, HSV(0), HSV(1), HSV(2))
End Sub

Private Sub HSVToColor(alpha As Int, h As Float, s As Float, v As Float) As Int
	Dim r, g, b As Float
	Dim hi As Float = Floor(h / 60)
	Dim hbucket As Int =  hi Mod 6
	Dim f As Float = h / 60 - hi
	Dim p As Float = v * (1 - s)
	Dim q As Float = v  * (1 - f * s)
	Dim t As Float = v * (1 - (1 - f) * s)
	Select hbucket
		Case 0
			r = v
			g = t
			b = p
		Case 1
			r = q
			g = v
			b = p
		Case 2
			r = p
			g = v
			b = t
		Case 3
			r = p
			g = q
			b = v
		Case 4
			r = t
			g = p
			b = v
		Case 5
			r = v
			g = p
			b = q
	End Select
	Return xui.Color_ARGB(alpha, Round(r * 255), Round(g * 255), Round(b * 255))
End Sub

Public Sub setSelectedColor(i As Int)
	setSelectedHSVColor(ColorToHSV(i))
End Sub

'Gets or sets the selected color. The value is an array with: H, S, V and Alpha.
Public Sub getSelectedHSVColor As Object()
	Return Array (selectedH, selectedS, selectedV, SelectedAlpha)
End Sub

Public Sub setSelectedHSVColor (HSV() As Object)
	selectedH = HSV(0)
	selectedS = HSV(1)
	selectedV = HSV(2)
	SelectedAlpha = HSV(3)
	HueBarSelectedChanged(selectedH / 360 * HueBar.pnl.Height)
	AlphaBarSelectedChange(SelectedAlpha / 255 * AlphaBar.pnl.Width)
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


Private Sub Colors_Touch (Action As Int, X As Float, Y As Float)
	If Action = mBase.TOUCH_ACTION_MOVE_NOTOUCH Then Return
	HandleSelectedColorChanged(X, Y)
End Sub

Private Sub HueBar_Touch (Action As Int, X As Float, Y As Float)
	If Action = mBase.TOUCH_ACTION_MOVE_NOTOUCH Then Return
	HueBarSelectedChanged(Y)
End Sub

Private Sub Alpha_Touch (Action As Int, X As Float, Y As Float)
	If Action = mBase.TOUCH_ACTION_MOVE_NOTOUCH Then Return
	AlphaBarSelectedChange(x)
End Sub


Sub txtNewValue_TextChanged (Old As String, New As String)
	TextChangedIndex = TextChangedIndex + 1
	Dim MyIndex As Int = TextChangedIndex
	Sleep(100)
	If MyIndex <> TextChangedIndex Then Return
	If txtNewValue.Text <> CurrentSelectedHex Then
		If IsValidColorString(New) Then
			Dim tf As TextField = txtNewValue.TextField
			Dim s As Int = tf.SelectionStart
			setSelectedColor(HexToColor(New))
			tf.SetSelection(s, s)
		End If
	End If
End Sub

Private Sub txtNewValue_EnterPressed
	btnSetNew_Click
End Sub

Private Sub IsValidColorString(s As String) As Boolean
	Return Regex.IsMatch2("[0-9a-f]{8}", Regex.CASE_INSENSITIVE, s)
End Sub

Sub lstColors_ItemClick (Index As Int, Value As Object)
	CSelections.ItemClicked(Index)
	Dim NameAndValue() As Object = Value
	setSelectedColor(NameAndValue(1))
End Sub

Sub CreateListOfColorsLayout
	lstColors.sv.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	MapOfNamedColors.Initialize
	For Each line As String In File.ReadList(File.DirAssets, "colors.txt")
		Dim s() As String = Regex.Split(":", line)
		Dim Name As String = s(0)
		Dim Color As Int = HexToColor(s(1))
		Dim item As B4XView = xui.CreatePanel("")
		item.SetLayoutAnimated(0, 0, 0, lstColors.AsView.Width, 30dip)
		lstColors.Add(item, Array(Name,Color))
		If MapOfNamedColors.ContainsKey(Color) Then
			Log("Duplicate color: " & Name)
		End If
		MapOfNamedColors.Put(Color, MapOfNamedColors.Size)
	Next
End Sub

'lazy creation of the items.
Sub lstColors_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	For i = Max(0, FirstIndex - 5) To Min(lstColors.Size - 1, LastIndex + 5)
		Dim p As B4XView = lstColors.GetPanel(i)
		If p.NumberOfViews = 0 Then
			p.LoadLayout("ListOfColors")
			Dim NameAndValue() As Object = lstColors.GetValue(i)
			ColorLabel.Text = NameAndValue(0)
			ColorPanel.Color = NameAndValue(1)
		End If
	Next
	CSelections.VisibleRangeChanged(FirstIndex, LastIndex)
End Sub

Sub btnSetNew_Click
	RaiseEvent(txtNewValue.Text)
End Sub

Private Sub RaiseEvent (clr As String)
	If IsValidColorString(clr) Then CallSub2(mCallBack, mEventName & "_ColorSet", HexToColor(clr))
End Sub


Sub pnlPrevValue_MouseClicked (EventData As MouseEvent)
	setSelectedColor(pnlPrevValue.Color)
	EventData.Consume	
End Sub