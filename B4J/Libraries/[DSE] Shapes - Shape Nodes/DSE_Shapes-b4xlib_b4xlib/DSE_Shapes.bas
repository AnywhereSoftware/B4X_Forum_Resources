B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private LastResizeFactorMap As Map
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	LastResizeFactorMap.Initialize	
End Sub


'Parameters: Points as int, InnerRadius Factor, 1 or more views
'Designer Script : DSE_Shapes.StarView(5,"0.5",Button1)
Public Sub StarView(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		Dim Points As Int = DesignerArgs.Arguments.Get(0)
		Dim InnerRadiusFactor As Double = DesignerArgs.Arguments.Get(1)
'		Dim AlignText As String = DesignerArgs.Arguments.Get(2)
		For i = 2 To DesignerArgs.Arguments.Size - 1
			Dim View As B4XView = DesignerArgs.GetViewFromArgs(i)
			Dim W As Double = View.Width
			Dim H As Double = View.Height
			Dim OuterRadius As Double = Min(H,W) / 2
			Dim InnerRadius As Double = OuterRadius * InnerRadiusFactor
			Dim Path(Points * 4) As Double
			Dim ThetaInc As Double = cPI / Points
			Dim Theta As Double = IIf(Points Mod 2 = 0,ThetaInc , -cPI / 2)
			Dim X,Y As Double
			For j = 0 To Points * 2 - 1
'				Dim AndgleRad As Double = j * DeltaAngleRad
				If j Mod 2 <> 0 Then
					X =  W / 2 + InnerRadius * Cos(Theta)
					Y = H / 2 +  InnerRadius * Sin(Theta)
				Else
					X = W / 2 + OuterRadius * Cos(Theta)
					Y = H / 2 + OuterRadius * Sin(Theta)
				End If
			
				Path(j * 2) = X
				Path(j * 2 + 1) = Y
				Theta = Theta + ThetaInc
			Next
		
			Dim Poly As JavaObject
			Poly.InitializeNewInstance("javafx.scene.shape.Polygon",Array(Path))
			View.As(JavaObject).RunMethod("setShape",Array(Poly))
			View.As(JavaObject).RunMethod("setPickOnBounds",Array(False))
			
			SetTextAlignment(View)
			
		Next
	End If
End Sub

Private Sub SetTextAlignment(View As B4XView)
	Dim TA As String
	If View Is Button Then
		TA = View.As(Button).Alignment
	Else If View Is Label Then
		TA = View.As(Label).Alignment
	Else If View Is RadioButton Then
		TA = View.As(RadioButton).Alignment
	Else if View Is CheckBox Then
		TA = View.As(CheckBox).Alignment
	End If
	If TA <> "" Then
		View.As(JavaObject).RunMethod("setAlignment",Array(TA))
		Dim Pos As Int = TA.IndexOf("_")
		If Pos > -1 Then TA = TA.SubString(Pos+1)
		View.As(JavaObject).RunMethod("setTextAlignment",Array(TA))
	End If
End Sub


'Create an oval or round view
'Parameters: 1 or more buttons
'Designer Script : DSE_Shapes.OvalView(Button1)
Public Sub OvalView(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		For i = 0 To DesignerArgs.Arguments.Size - 1
			Dim View As B4XView = DesignerArgs.GetViewFromArgs(i)
			Dim W As Double = View.Width
			Dim H As Double = View.Height
			Dim R As Double = Min(H,W) / 2
			Dim Circle As JavaObject
			Circle.InitializeNewInstance("javafx.scene.shape.Circle",Array(W / 2, H / 2, R))
	
			View.As(JavaObject).RunMethod("setShape",Array(Circle))
			View.As(JavaObject).RunMethod("setPickOnBounds",Array(False))
			
			SetTextAlignment(View)
		Next
	End If
End Sub


'Create a Polygon view with any number of Vertices
'Parameters: Vertices as Int, RotationInDegress As Double, 1 or more views
'Designer Script : DSE_Shapes.VertexView(5,0,Button1, Button2)
Public Sub VertexView(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		Dim N As Int = DesignerArgs.Arguments.Get(0)
		Dim RotationRad As Double = DesignerArgs.Arguments.Get(1).As(Double) * (cPI / 180)
		For i = 2 To DesignerArgs.Arguments.Size - 1
			Dim View As B4XView = DesignerArgs.GetViewFromArgs(i)
			Dim W As Double = View.Width
			Dim H As Double = View.Height
			Dim R As Double = Min(H,W) / 2
			Dim Path(N * 2) As Double
			Dim ThetaInc As Double = 2 * cPI / N
			Dim Theta As Double = IIf(N Mod 2 = 0,ThetaInc , -cPI / 2)
			Dim X,Y As Double
			For j = 0 To N - 1
				X =  W / 2 + R * Cos(Theta + RotationRad)
				Y =  H / 2 + R * Sin(Theta + RotationRad)
				Path(j * 2) = X
				Path(j * 2 + 1) = Y
				Theta = Theta + ThetaInc
			Next
	
			Dim Poly As JavaObject
			Poly.InitializeNewInstance("javafx.scene.shape.Polygon",Array(Path))
			View.As(JavaObject).RunMethod("setShape",Array(Poly))
			View.As(JavaObject).RunMethod("setPickOnBounds",Array(False))
			
			SetTextAlignment(View)
		Next
	End If
End Sub

'Create a Polygon views with any number of Vertices from all views on a pane
'Parameters: Vertices as Int, RotationInDegrees as Double, Pane as B4xView
'Designer Script : DSE_Shapes.VertexViewAll(5,90,Pane1)
Public Sub VertexViewAll(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		Dim N As Int = DesignerArgs.Arguments.Get(0)
		Dim RotationRad As Double = DesignerArgs.Arguments.Get(1).As(Double) * (cPI / 180)
		Dim P As B4XView = DesignerArgs.GetViewFromArgs(2)
		For i = 0 To P.NumberOfViews - 1
			Dim View As B4XView = P.GetView(i)
			Dim W As Double = View.Width
			Dim H As Double = View.Height
			Dim R As Double = Min(H,W) / 2
			Dim Path(N * 2) As Double
			Dim ThetaInc As Double = 2 * cPI / N 
			Dim Theta As Double = IIf(N Mod 2 = 0,ThetaInc , -cPI / 2)
			Dim X,Y As Double
			For j = 0 To N - 1
				X =  W / 2 + R * Cos(Theta + RotationRad)
				Y =  H / 2 + R * Sin(Theta + RotationRad)
				Path(j * 2) = X
				Path(j * 2 + 1) = Y
				Theta = Theta + ThetaInc
			Next
	
			Dim Poly As JavaObject
			Poly.InitializeNewInstance("javafx.scene.shape.Polygon",Array(Path))
			View.As(JavaObject).RunMethod("setShape",Array(Poly))
			View.As(JavaObject).RunMethod("setPickOnBounds",Array(False))
			
			SetTextAlignment(View)
		Next
	End If
End Sub

'Parameters: Rotation as Double, AndText As string, 1 Or More Views
'Designer Script : DSE_Shapes.RotateView(90, "False", Button1)
'Avoid rotating Text input fields, or Panes that contain them.  It gets messy very quickly.
Public Sub RotateView(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		Dim Rotation As Double = DesignerArgs.Arguments.Get(0)
		Dim AndText As Boolean = DesignerArgs.Arguments.Get(1).As(String).ToLowerCase = "true"
		For i = 2 To DesignerArgs.Arguments.Size - 1
			Dim View As B4XView = DesignerArgs.GetViewFromArgs(i)
			RotateView_Impl(View,Rotation,AndText)
		Next
	End If
End Sub

Private Sub RotateView_Impl(View As B4XView,Rotation As Double,AndText As Boolean)
	View.Rotation = Rotation
	If AndText = False Then
		Sleep(0)
		Dim Arr() As Object = View.As(JavaObject).RunMethodJO("lookupAll",Array(".text")).RunMethod("toArray",Null)
		For Each Lbl As B4XView In Arr
			If Lbl.IsInitialized Then
				Lbl.Rotation = -Rotation
			End If
		Next
		If View Is CheckBox Then
			Dim Mark As B4XView = View.As(JavaObject).RunMethod("lookup",Array(".mark"))
			Mark.Rotation = -Rotation
		End If
	End If
End Sub

'Parameters: CheckBox As B4xView, Color As String
'Designer Script : DSE_Shapes.SetBackgroundColor(CheckBox1, FFFF0000)
'Useful to set the Background color for CheckBox and RadioButtons, where the designer sets the background for the mark and radio nodes respectively.
Public Sub SetBackgroundColor(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		Dim View As B4XView = DesignerArgs.GetViewFromArgs(0)
		Dim ColorStr As String = DesignerArgs.Arguments.Get(1).As(String).Replace("#","").Replace("0x","")
		Dim BC As ByteConverter
		Dim Color As Int = BC.IntsFromBytes(BC.HexToBytes(ColorStr))(0)
		View.Color = Color
	End If
End Sub

'Parameters: Pane as B4xView, Columns As int, Margin As int, ScaleFont as String ("True"/"", "False"), Adjust As String ("True"/"", "False") 
'Designer Script : DSE_Shapes.LayoutHexagonsHorizontal(Pane1,5,5,"True","True")
'By default if there are not 2 full rows of views the layout will be adjusted to take the smallest space that fits the number of columns. 
'Set Adjust to False to override this behaviour.
'Views modified with VertexViewAll(6,0,Pane1)
'Vertical Hexagons are flat side up.  Scale adjustment is driven by x axis only.
Public Sub LayoutHexagonsVertical(DesignerArgs As DesignerArgs)
	Dim P As B4XView = DesignerArgs.GetViewFromArgs(0)
	Dim PaneBorderWidth As Double = CSSUtils.GetStyleProperty(P,"-fx-border-width")
	Dim Columns As Int = DesignerArgs.Arguments.Get(1)
	Dim Margin As Double = DesignerArgs.Arguments.Get(2)
	Dim ScaleFont As Boolean = DesignerArgs.Arguments.Get(3).As(String).ToLowerCase <> "false"
	Dim Adjust As Boolean = DesignerArgs.Arguments.Get(4).As(String).ToLowerCase <> "false"
	Dim HalfPix As Double = 0.5
	Dim X As Double = Margin + PaneBorderWidth + HalfPix
	Dim Y As Double = Margin + PaneBorderWidth + HalfPix
	Dim ViewWidth As Double = P.GetView(0).As(B4XView).Width
	Dim WidthRequired As Double
	Dim LastResizeFactor As Double = LastResizeFactorMap.GetDefault(P,1)
	If Adjust Then
		If P.NumberOfViews <= Columns Then
			WidthRequired = 2 + PaneBorderWidth * 2 + Margin * 2 + Columns * ViewWidth
		Else If P.NumberOfViews < Columns * 2 Then
			WidthRequired = 2 + PaneBorderWidth * 2 + Margin * 2 + Columns * ViewWidth + (P.NumberOfViews Mod Columns) * ViewWidth * 0.5
		Else
			WidthRequired =  2 + PaneBorderWidth * 2 + Margin * 2 + Columns * (ViewWidth * 1.50) + ViewWidth * 0.25
		End If
	Else
		WidthRequired =  2 + PaneBorderWidth * 2 + Margin * 2 + Columns * (ViewWidth * 1.50) + ViewWidth * 0.25
	End If
	Dim ResizeFactor As Double = P.Width / WidthRequired
	
	Dim Row As Int = 0
	For i = 0 To P.NumberOfViews - 1
		Dim View As B4XView = P.GetView(i)
		View.Width = View.Width * ResizeFactor
		View.Height = View.height * ResizeFactor
		If ScaleFont And IsLabelled(View) Then View.TextSize = (View.TextSize / LastResizeFactor) * ResizeFactor
		If i > 0 And I Mod Columns = 0 Then
			Row = Row + 1
			If Row Mod 2 = 0 Then
				X = Margin + PaneBorderWidth + HalfPix
				Y = Y + View.Height * 0.5
			Else
				X = View.Width * 0.75 + Margin + PaneBorderWidth + HalfPix
				Y = Y + View.Height * 0.5
			End If
		End If
		
		View.Left = X
		View.Top = Y
		
		If Adjust Then
			If P.NumberOfViews <= Columns Then
				X = X + View.Width
			Else If P.NumberOfViews <= Columns * 2 Then
				If i Mod Columns  < P.NumberOfViews - Columns Then
					X = X + View.Width * 1.5
				Else
					X = X + View.Width
				End If
			Else
				X = X + View.Width * 1.5
			End If
		Else
			X = X + View.Width * 1.5
		End If
	Next
	LastResizeFactorMap.Put(P,ResizeFactor)
End Sub

'Parameters: Pane as B4xView, Columns As int, Margin As int, ScaleFont As string ("True"/"", "False")
'Designer Script : DSE_Shapes.LayoutHexagonsVertical(Pane1,5,5,"True")
'Views modified with VertexViewAll(6,90,Pane1)
'Horzontal Hexagons are Pointy side up. Scale adjustment is driven by x axis only.
Public Sub LayoutHexagonsHorizontal(DesignerArgs As DesignerArgs)
	Dim P As B4XView = DesignerArgs.GetViewFromArgs(0)
	Dim PaneBorderWidth As Double = CSSUtils.GetStyleProperty(P,"-fx-border-width")
	Dim Columns As Int = DesignerArgs.Arguments.Get(1)
	Dim Margin As Double = DesignerArgs.Arguments.Get(2)
	Dim ScaleFont As Boolean = DesignerArgs.Arguments.Get(3).As(String).ToLowerCase <> "false"
	Dim View As B4XView = P.GetView(0).As(B4XView)
	Dim HalfPix As Double = 0.5
	Dim LastResizeFactor As Double = LastResizeFactorMap.GetDefault(P,1)
	
	'Views will be rotated 90deg, so we have to consider width as height and height as width.
	Dim WidthRequired As Double
	If P.NumberOfViews >= Columns * 2 Then
		WidthRequired =  2 + PaneBorderWidth * 2 + Margin * 2 + Columns * View.Width + View.width * 0.5
	Else
		WidthRequired =  2 + PaneBorderWidth * 2 + Margin * 2 + Columns * View.Width
	End If
	Dim ResizeFactor As Double = P.Width / WidthRequired
	
	Dim X As Int = Margin + PaneBorderWidth + HalfPix
	Dim Y As Int = Margin + PaneBorderWidth + HalfPix

	Dim Row As Int = 0
	For i = 0 To P.NumberOfViews - 1
		Dim View As B4XView = P.GetView(i)
		View.Width = View.Width * ResizeFactor
		View.Height = View.Height * ResizeFactor
		If ScaleFont And IsLabelled(View) Then View.TextSize = (View.TextSize / LastResizeFactor) * ResizeFactor
		
		If i > 0 And I Mod Columns = 0 Then
			Row = Row + 1
			If Row Mod 2 = 0 Then
				X = Margin + PaneBorderWidth + HalfPix
				Y = Y + View.Height * 0.75
			Else
				X = View.Width / 2 + Margin + PaneBorderWidth
				Y = Y + View.Height * 0.75
			End If
		End If
		View.Top = Y
		View.Left = X

		X = X + View.Width
	Next
	LastResizeFactorMap.Put(P,ResizeFactor)
End Sub

Private Sub IsLabelled(View As B4XView) As Boolean
	If View Is Label Or View Is Button Or View Is CheckBox Or View Is RadioButton Then Return True
	Return False
End Sub