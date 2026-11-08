B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1.0
@EndOfDesignText@
'
'Customizable B4X step slider with labels, touch selection, and full appearance control.
'
'Version: 1.20
'Date: 2026/07/25
'Author: Grinaute
'Dépendences: XUI
'
'<code>
''In Class_Globals:
'   'cSliderMulti
'	Private Slider1, Slider2 As cSliderMulti 'Horizontal
'	Private Slider3, Slider4 As cSliderMulti 'Vertical
'End Sub
'
''In B4XPage_Created (Root1 As B4XView)
'   'cSliderMulti
'	Create_Slider1_2
'	Create_Slider3_4
''End Sub
'
''cSliderMulti
'#Region Slider Multi
'' Creating Horizontal Slider
'Private Sub Create_Slider1_2
'	Dim PanelWidth As Int = 300dip
'	Dim PanelHeight As Int = 60dip
'	
'	' Creating Centered Horizontal Slider
'	Dim SliderPanel1 As Panel
'	SliderPanel1.Initialize("SliderPanel1")
'	Root.AddView(SliderPanel1, 0, 25dip, PanelWidth, PanelHeight)
'	Slider1.Initialize(SliderPanel1, Me, -1, "Slider1")
'	Slider1.LineColor = Colors.LightGray
'	Slider1.PointColor = Colors.Gray
'	Slider1.CursorColor = Colors.RGB(0,120,255)
'	Slider1.TextColor = Colors.Black
'	Slider1.ActiveLineColor = Colors.RGB(0,120,255)
'	Slider1.SetItems(Array As String("Min","3","Default","5","6","Max"), 2)
'	
'	' Creating Left-Aligned Horizontal Slider
'	Dim SliderPanel2 As Panel
'	SliderPanel2.Initialize("SliderPanel2")
'	PnlBlack.AddView(SliderPanel2, 0, 25dip, PanelWidth, PanelHeight)
'	Slider2.Initialize(SliderPanel2, Me, 90dip, "Slider2")
'	Slider2.LineColor = Colors.LightGray
'	Slider2.PointColor = Colors.Gray
'	Slider2.CursorColor = Colors.RGB(0,120,255)
'	Slider2.TextColor = Colors.White
'	Slider2.ActiveLineColor = Colors.RGB(0,120,255)
'	Slider2.SetItems(Array As String("2","3","4","5","6","7"), 4)
'End Sub
'
'' Creating Vertical Sliders
'Private Sub Create_Slider3_4
'	Dim PanelWidth As Int = 120dip
'	Dim PanelHeight As Int = 300dip
'	Dim Slider3_Left As Int = 80dip
'	Dim Slider3_Top As Int = 240dip
'	Dim Slider4_Left As Int = 180dip
'	Dim Slider4_Top As Int = 340dip
'	
'	'Left vertical slider: Top -> Bottom
'	Dim SliderPanel3 As Panel
'	SliderPanel3.Initialize("SliderPanel3")
'	Root.AddView(SliderPanel3,Slider3_Left,Slider3_Top,PanelWidth,PanelHeight)
'	Slider3.Initialize(SliderPanel3,Me,Slider3_Left,"Slider3")
'	Slider3.SetVertical(True)
'	Slider3.SetReverseVertical(False)
'	Slider3.LineColor = Colors.LightGray
'	Slider3.PointColor = Colors.Gray
'	Slider3.CursorColor = Colors.RGB(0,120,255)
'	Slider3.TextColor = Colors.Black
'	Slider3.ActiveLineColor = Colors.RGB(0,120,255)
'	Slider3.SetItems(Array As String("Min","25","50","75","Max"),2)
'	'disables touch selection
'	Slider3.mTouchEnabled = False
'	
'	'Right vertical slider: Bottom -> Top
'	Dim SliderPanel4 As Panel
'	SliderPanel4.Initialize("SliderPanel4")
'	Root.AddView(SliderPanel4,Slider4_Left,Slider4_Top,PanelWidth,PanelHeight)
'	Slider4.Initialize(SliderPanel4,Me,Slider4_Left,"Slider4")
'	Slider4.SetVertical(True)
'	Slider4.SetReverseVertical(True)
'	Slider4.LineColor = Colors.LightGray
'	Slider4.PointColor = Colors.Gray
'	Slider4.CursorColor = Colors.RGB(255,80,0)
'	Slider4.TextColor = Colors.Black
'	Slider4.ActiveLineColor = Colors.RGB(255,80,0)
'	Slider4.SetItems(Array As String("Min","25","50","75","Max"),2)
'End Sub
'
'Sub Value_Changed(Data() As Object)
'	Dim ID As String = Data(0)
'	Dim Index As Int = Data(1)
'	Dim Label As String = Data(2)
'	Log(ID & " -> Index = " & Index & ", Valeur = " & Label)
'End Sub
'
'Private Sub SliderPanel1_Touch(Action As Int, X As Float, Y As Float)
'	Slider1.Touch(Action, X, Y)
'End Sub
'
'Private Sub SliderPanel2_Touch(Action As Int, X As Float, Y As Float)
'	Slider2.Touch(Action, X, Y)
'End Sub
'
'Private Sub SliderPanel3_Touch(Action As Int, X As Float, Y As Float)
'	Slider3.Touch(Action,X,Y)
'End Sub
'
'Private Sub SliderPanel4_Touch(Action As Int, X As Float, Y As Float)
'	Slider4.Touch(Action,X,Y)
'End Sub
'#End Region
'</code>
Sub Class_Globals
	Private xui As XUI
	Private cvs As Canvas
	Private pnl, mParent As Panel
	Private mLeft, SelectedIndex, LastSentIndex As Int
	Private mTarget As Object
	Private Labels(), mID As String
	Private Positions(), Radius, LineWidth, TextSize As Float
	Private IsInitialized As Boolean = False
	Private mLineColor As Int = Colors.Gray
	Private mPointColor As Int = Colors.DarkGray
	Private mCursorColor As Int = Colors.Cyan
	Private mActiveLineColor As Int = Colors.Blue
	Private mTextColor As Int = Colors.Black
	Private mVertical, mReverseVertical As Boolean = False
	Public mTouchEnabled As Boolean = True
End Sub

#Region initialization
' Slider initialization
Public Sub Initialize(Parent As Panel, Callback As Object, Left As Int, ID As String)
	pnl = Parent
	mTarget = Callback
	mID = ID
	mParent = pnl.Parent
	mLeft = Left
	If mLeft = -1 Then
		pnl.Left = (mParent.Width - pnl.Width) / 2
	Else
		pnl.Left = mLeft
	End If
	SelectedIndex = 0
	LineWidth = 5dip
	Radius = 10dip
	TextSize = 14
	LastSentIndex = -1
	cvs.Initialize(pnl)
End Sub
#End Region

#Region Orientation
' Defines the orientation
Public Sub SetVertical(Value As Boolean)
	mVertical = Value
	If IsInitialized Then
		Calculate_Positions
		Draw
	End If
End Sub

' Returns the orientation
Public Sub GetVertical As Boolean
	Return mVertical
End Sub

' Defines the direction of the vertical slider. False = Top to Bottom, True = Bottom to Top
Public Sub SetReverseVertical(Value As Boolean)
	mReverseVertical = Value
	If IsInitialized Then
		Calculate_Positions
		Draw
	End If
End Sub

' Returns the direction of the vertical slider
Public Sub GetReverseVertical As Boolean
	Return mReverseVertical
End Sub
#End Region

#Region Items / Selection
' Defines the slider elements
Public Sub SetItems(ItemLabels() As String, StartIndex As Int)
	Labels = ItemLabels
	If StartIndex < 0 Then StartIndex = 0
	If StartIndex > Labels.Length - 1 Then StartIndex = Labels.Length - 1
	SelectedIndex = StartIndex
	Positions = CreateFloatArray(Labels.Length)
	Calculate_Positions
	IsInitialized = True
	Draw
End Sub

' Returns the selected index
Public Sub GetSelectedIndex As Int
	Return SelectedIndex
End Sub

' Sets the selected index
Public Sub SetSelectedIndex(Index As Int)
	If Index < 0 Then Index = 0
	If Index > Labels.Length - 1 Then Index = Labels.Length - 1
	SelectedIndex = Index
	LastSentIndex = Index
	Draw
End Sub

' Returns the text of the selected item
Public Sub GetSelectedLabel As String
	If Labels.Length = 0 Then Return ""
	Return Labels(SelectedIndex)
End Sub
#End Region

#Region Appearance
' Defines the main colors
Public Sub SetColors(Line As Int, Point As Int, Cursor As Int, Text As Int)
	mLineColor = Line
	mPointColor = Point
	mCursorColor = Cursor
	mTextColor = Text
	If IsInitialized Then Draw
End Sub

'Defines the element sizes
Public Sub SetSizes(PointRadius As Float, BarWidth As Float, FontSize As Float)
	Radius = PointRadius
	LineWidth = BarWidth
	TextSize = FontSize
	If IsInitialized Then
		Calculate_Positions
		Draw
	End If
End Sub

' Defines the inactive line color
Public Sub setLineColor(Color As Int)
	mLineColor = Color
	If IsInitialized Then Draw
End Sub

' Returns the inactive line color
Public Sub getLineColor As Int
	Return mLineColor
End Sub

' Defines the point color
Public Sub setPointColor(Color As Int)
	mPointColor = Color
	If IsInitialized Then Draw
End Sub

' Returns the point color
Public Sub getPointColor As Int
	Return mPointColor
End Sub

' Defines the cursor color
Public Sub setCursorColor(Color As Int)
	mCursorColor = Color
	If IsInitialized Then Draw
End Sub

' Returns the cursor color
Public Sub getCursorColor As Int
	Return mCursorColor
End Sub

' Defines the text color
Public Sub setTextColor(Color As Int)
	mTextColor = Color
	If IsInitialized Then Draw
End Sub

' Returns the text color
Public Sub getTextColor As Int
	Return mTextColor
End Sub

' Defines the active section color
Public Sub setActiveLineColor(Color As Int)
	mActiveLineColor = Color
	If IsInitialized Then Draw
End Sub

' Returns the active section color
Public Sub getActiveLineColor As Int
	Return mActiveLineColor
End Sub
#End Region

#Region calculations
' Calculates the positions of the points according to the orientation
Private Sub Calculate_Positions
	Dim f As Typeface = Typeface.DEFAULT
	If mVertical = False Then
		Dim LeftMargin, RightMargin As Float = 20dip
		If Labels.Length > 0 Then
			Dim w As Float
			w = cvs.MeasureStringWidth(Labels(0), f, TextSize)
			LeftMargin = Max(LeftMargin, w / 2 + Radius + 5dip)
			w = cvs.MeasureStringWidth(Labels(Labels.Length - 1), f, TextSize)
			RightMargin = Max(RightMargin, w / 2 + Radius + 5dip)
		End If
		If Labels.Length = 1 Then
			Positions(0) = pnl.Width / 2
			Return
		End If
		Dim StepX As Float = (pnl.Width - LeftMargin - RightMargin) / (Labels.Length - 1)
		For i = 0 To Labels.Length - 1
			Positions(i) = LeftMargin + i * StepX
		Next
	Else
		Dim TopMargin, BottomMargin As Float = 20dip
		Dim h As Float = cvs.MeasureStringHeight("Ag", f, TextSize)
		TopMargin = Max(TopMargin, h / 2 + Radius + 5dip)
		BottomMargin = Max(BottomMargin, h / 2 + Radius + 5dip)
		If Labels.Length = 1 Then
			Positions(0) = pnl.Height / 2
			Return
		End If
		Dim StepY As Float = (pnl.Height - TopMargin - BottomMargin) / (Labels.Length - 1)
		For i = 0 To Labels.Length - 1
			If mReverseVertical Then
				Positions(i) = pnl.Height - BottomMargin - i * StepY
			Else
				Positions(i) = TopMargin + i * StepY
			End If
		Next
	End If
End Sub

' Creates a Float array
Private Sub CreateFloatArray(Size As Int) As Float()
	Dim a(Size) As Float
	Return a
End Sub
#End Region

#Region Rendering
' Draws the slider
Private Sub Draw
	If IsInitialized = False Then Return
	cvs.DrawColor(Colors.Transparent)
	Dim f As Typeface = Typeface.DEFAULT
	If mVertical = False Then
		Dim cy As Float = pnl.Height / 2
		cvs.DrawLine(Positions(0), cy, Positions(Positions.Length - 1), cy, mLineColor, LineWidth)
		If SelectedIndex > 0 Then
			cvs.DrawLine(Positions(0), cy, Positions(SelectedIndex), cy, mActiveLineColor, LineWidth)
		End If
		For i = 0 To Labels.Length - 1
			cvs.DrawText(Labels(i), Positions(i), cy - Radius - 4dip, f, TextSize, mTextColor, "CENTER")
		Next
		For i = 0 To Positions.Length - 1
			cvs.DrawCircle(Positions(i), cy, Radius, mPointColor, True, 1)
		Next
		cvs.DrawCircle(Positions(SelectedIndex), cy, Radius, mCursorColor, True, 1)
	Else
		Dim cx As Float = pnl.Width / 2
		Dim cy As Float = pnl.Height / 2
		Dim topY As Float = Positions(0)
		Dim bottomY As Float = Positions(Positions.Length - 1)
		cvs.DrawLine(cx, topY, cx, bottomY, mLineColor, LineWidth)
		If SelectedIndex > 0 Then
			cvs.DrawLine(cx, Positions(0), cx, Positions(SelectedIndex), mActiveLineColor, LineWidth)
		End If
		For i = 0 To Positions.Length - 1
			cvs.DrawCircle(cx, Positions(i), Radius, mPointColor, True, 1)
		Next
		cvs.DrawCircle(cx, Positions(SelectedIndex), Radius, mCursorColor, True, 1)
		For i = 0 To Labels.Length - 1
			cvs.DrawText(Labels(i), cx + Radius + 8dip, Positions(i) + TextSize / 3, f, TextSize, mTextColor, "LEFT")
		Next
	End If
	pnl.Invalidate
End Sub
#End Region

#Region User interaction
' Enables or disables touch selection
Public Sub SetTouchEnabled(Value As Boolean)
	mTouchEnabled = Value
End Sub

' Returns whether touch selection is enabled
Public Sub GetTouchEnabled As Boolean
	Return mTouchEnabled
End Sub

' Touch handling
Public Sub Touch(Action As Int, X As Float, Y As Float)
	If mTouchEnabled = False Then Return
	If Action = 0 Or Action = 2 Then
		Dim p As Float
		If mVertical Then
			p = Y
		Else
			p = X
		End If
		Dim nearest As Int = 0
		Dim dist As Float = Abs(p - Positions(0))
		For i = 1 To Positions.Length - 1
			If Abs(p - Positions(i)) < dist Then
				nearest = i
				dist = Abs(p - Positions(i))
			End If
		Next
		SelectedIndex = nearest
		Draw
		If SelectedIndex <> LastSentIndex Then
			LastSentIndex = SelectedIndex
			If SubExists(mTarget, "Value_Changed") Then
				Dim Data(3) As Object
				Data(0) = mID
				Data(1) = SelectedIndex
				Data(2) = Labels(SelectedIndex)
				CallSubDelayed2(mTarget, "Value_Changed", Data)
			End If
		End If
	End If
End Sub

#End Region
