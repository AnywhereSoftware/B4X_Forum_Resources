B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
#DesignerProperty: Key: FirstColor, DisplayName: First Color, FieldType: Color, DefaultValue: 0xFFFF5700
#DesignerProperty: Key: SecondColor, DisplayName: Second Color, FieldType: Color, DefaultValue: 0xFFFFB600
#DesignerProperty: Key: StrokeWidth, DisplayName: StrokeWidth, FieldType: Int, DefaultValue: 30

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Public iv1, iv2 As B4XView
	Private bmpBC, bc As BitmapCreator
	Private bmp As B4XBitmap
	Private highlightBC As BitmapCreator
	Private cbc As CompressedBC
	Private LoopIndex As Int
	Private TransparentBrush As BCBrush
	Private StrokeWidth As Int
	Private c1, c2 As Int	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	Dim niv As ImageView
	niv.Initialize("")
	iv1 = niv
	Dim niv As ImageView
	niv.Initialize("")
	iv2 = niv
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mBase.AddView(iv1, 0, 0, 1dip, 1dip)
	mBase.AddView(iv2, 0, 0, 1dip, 1dip)
	StrokeWidth = Props.Get("StrokeWidth")
	c1 = xui.PaintOrColorToColor(Props.Get("FirstColor"))
	c2 = xui.PaintOrColorToColor(Props.Get("SecondColor"))
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
 	Update
End Sub

Private Sub Update
	If bmp.IsInitialized = False Or mBase.Width * mBase.Height = 0 Then Return
	iv1.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Height)
	iv2.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Height)
	bmpBC.Initialize(iv1.Width / xui.Scale, iv1.Height / xui.Scale)
	bmp = bmp.Resize(bmpBC.mWidth, bmpBC.mHeight, False)
	bc.SetBitmapToImageView(bmp, iv1)
	bmpBC.CopyPixelsFromBitmap(bmp)
	bc.Initialize(bmpBC.mWidth, bmpBC.mHeight)
	highlightBC.Initialize(StrokeWidth, 5)
	highlightBC.FillGradient(Array As Int(c1, c2, c1), highlightBC.TargetRect, "LEFT_RIGHT")
	TransparentBrush = bc.CreateBrushFromColor(xui.Color_Transparent)
	Dim cache As InternalCompressedBCCache
	cache.Initialize
	cache.ColorsMap = CreateMap()
	bmpBC.MAX_SAME_COLOR_SIZE = 0
	cbc = bmpBC.ExtractCompressedBC(bmpBC.TargetRect, cache)
	MainLoop
End Sub

Private Sub MainLoop
	LoopIndex = LoopIndex + 1
	Dim MyIndex As Int = LoopIndex
	Dim Offset As Int
	Dim delta As Int = Ceil(bc.mWidth / 40)
	Do While MyIndex = LoopIndex And mBase.Visible
		DrawThroughCBC (Offset)
		Offset = Offset + delta
		If Offset >= 1.5 * bc.mWidth Then 
			delta = -Abs(delta)
		Else if Offset <= 0 Then
			delta = Abs(delta)
		End If
		bc.SetBitmapToImageView(bc.Bitmap, iv2)
		Sleep(20)
	Loop
End Sub


Private Sub DrawThroughCBC (OffsetX As Int)
	Dim width As Int = highlightBC.mWidth
	Dim highlight() As Byte = highlightBC.Buffer
	Dim buffer() As Byte = bc.Buffer
	bc.DrawRect2(bc.TargetRect, TransparentBrush, True, 0)
	Dim delta As Float = 0.5 * bc.mWidth / bc.mHeight
	Dim foffset As Float = OffsetX - 0.5 * bc.mWidth
	For y = 0 To bc.mHeight - 1
		foffset = foffset + delta
		OffsetX = foffset
		Dim RowSize As Int
		#if B4i
		Dim Row() As Byte = cbc.Rows.Get(y)
		RowSize = Row.Length / 4
		#else
		Dim row As List = cbc.Rows.Get(y)
		RowSize = row.Size
		#End If
		Dim x As Int = 0
		For i = 1 To RowSize - 1 Step 2
			#if B4i
			Dim state As Byte = Bit.FastArrayGetInt(Row, i)
			Dim count As Int = Bit.FastArrayGetInt(Row, i + 1)
			#else
			Dim state As Byte = row.Get(i)
			Dim count As Int = row.Get(i + 1)
			#End If
			If state = 1 Then
				If x > OffsetX + width Then Exit
				If x + count >= OffsetX Then
					If x >= OffsetX Then
						Dim DeltaInSource As Int = x - OffsetX
						Bit.ArrayCopy(highlight, DeltaInSource * 4, buffer, x * 4 + y * bc.mWidth * 4, Min(count, width - DeltaInSource) * 4)
					Else
						Dim FixedCount As Int = count - (OffsetX - x)
						Bit.ArrayCopy(highlight, 0, buffer,  OffsetX * 4 + y * bc.mWidth * 4, Min(FixedCount, width) * 4)
					End If
				End If
			End If
				
			x = x + count
		Next
	Next
End Sub

Public Sub setBitmap (b As B4XBitmap)
	bmp = b
	Update
End Sub

Public Sub getVisible As Boolean
	Return mBase.Visible
End Sub

Public Sub setVisible (b As Boolean)
	mBase.Visible = b
	Update
End Sub

