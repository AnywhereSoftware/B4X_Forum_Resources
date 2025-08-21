B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.28
@EndOfDesignText@
'version 1.60
Sub Class_Globals
	Private xui As XUI
	Public cvs As B4XCanvas
	Private ModuleSize As Int
	Private GFSize As Int = 256
	Private ExpTable(GFSize) As Int
	Private LogTable(GFSize) As Int
	Private PolyZero() As Int = Array As Int(0)
	Private Generator1L() As Int = Array As Int(1, 127, 122, 154, 164, 11, 68, 117)
	Private Generator4L() As Int = Array As Int(1, 152, 185, 240, 5, 111, 99, 6, 220, 112, 150, 69, 36, 187, 22, 228, 198, 121, 121, 165, 174) '4L
	Private Generator4H() As Int = Array As Int(1, 59, 13, 104, 189, 68, 209, 30, 8, 163, 65, 41, 229, 98, 50, 36, 59)
	Private Generator9L() As Int = Array As Int(1, 212, 246, 77, 73, 195, 192, 75, 98, 5, 70, 103, 177, 22, 217, 138, 51, 181, 246, 72, 25, 18, 46, 228, 74, 216, 195, 11, 106, 130, 150)
	Private TempBB As B4XBytesBuilder
	Private Matrix(0, 0) As Boolean
	Private Reserved(0, 0) As Boolean
	Private NumberOfModules As Int
	Private mBitmapSize As Int
	Type QRVersionData (Format() As Byte, Generator() As Int, MaxSize As Int, Version As Int, MaxUsableSize As Int, Alignments() As Int, _
		Group1Size As Int, Group2Size As Int, Block1Size As Int, Block2Size As Int, VersionName As String, VersionInformation() As Byte)
	Private versions As List
End Sub


Public Sub Initialize (BitmapSize As Int)
	TempBB.Initialize
	mBitmapSize = BitmapSize
	PrepareTables
	versions.Initialize
	Dim l0() As Byte = Array As Byte(1,1,1,0,1,1,1,1,1,0,0,0,1,0,0)
	Dim h0() As Byte = Array As Byte(0,0,1,0,1,1,0,1,0,0,0,1,0,0,1)
	versions.Add(CreateVersionData(1, "1L", Generator1L, l0, 19 * 8, 17, Array As Int(), 1, 0, 19, 0, Null))
	versions.Add(CreateVersionData(4, "4H", Generator4H, h0 , 36 * 8, 34, Array As Int(6, 26), 4, 0, 9, 0, Null))
	versions.Add(CreateVersionData(4, "4L", Generator4L, l0 , 80 * 8, 78, Array As Int(6, 26), 1, 0, 80, 0, Null))
	versions.Add(CreateVersionData(9, "9L", Generator9L, l0, 232 * 8, 230, Array As Int(6, 26, 46), 2, 0, 116, 0, Array As Byte(0,0,1,0,0,1,1,0,1,0,1,0,0,1,1,0,0,1)))
	versions.Add(CreateVersionData(23, "23H", Generator9L, h0, 464 * 8, 461, Array As Int(6, 30, 54, 78, 102), 16, 14, 15, 16, _
		Array As Byte(0,1,0,1,1,1,0,1,1,1,1,1,1,0,1,1,0,0)))
	versions.Add(CreateVersionData(40, "40H", Generator9L, h0, 1276 * 8, 1273, Array As Int(6, 30, 58, 86, 114, 142, 170), 20, 61, 15, 16, _
		Array As Byte(1,0,1,0,0,0,1,1,0,0,0,1,1,0,1,0,0,1)))
	versions.Add(CreateVersionData(40, "40L", Generator9L, l0, 2956 * 8, 2953, Array As Int(6, 30, 58, 86, 114, 142, 170), 19, 6, 118, 119, _
		Array As Byte(1,0,1,0,0,0,1,1,0,0,0,1,1,0,1,0,0,1)))
End Sub

Private Sub CreateVersionData (Version As Int, Name As String, Generator() As Int, Format() As Byte, MaxSize As Int, MaxUsableSize As Int, Alignments() As Int, _
		Group1Size As Int, Group2Size As Int, Block1Size As Int, Block2Size As Int, VersionInformation() As Byte) As QRVersionData
	Dim v As QRVersionData
	v.Initialize
	v.Version = Version
	v.VersionName = Name
	v.Generator = Generator
	v.Format = Format
	v.MaxSize = MaxSize
	v.MaxUsableSize = MaxUsableSize
	v.Alignments = Alignments
	v.Group1Size = Group1Size
	v.Group2Size = Group2Size
	v.Block1Size = Block1Size
	v.Block2Size = Block2Size
	v.VersionInformation = VersionInformation
	Return v
End Sub

Public Sub Create(Text As String) As B4XBitmap
	Dim Bytes() As Byte = Text.GetBytes("utf8") 'non-standard but still recommended
	Dim vd As QRVersionData
	For Each version As QRVersionData In versions
		If version.MaxUsableSize >= Bytes.Length Then
			vd = version
			Exit
		End If
	Next
	If vd.IsInitialized = False Then
		
		Log("Too long!")
		Return Null
	End If
	Log(vd.VersionName & ", Size: " & Bytes.Length)
	
	NumberOfModules = 17 + vd.Version * 4
	ModuleSize = mBitmapSize / (NumberOfModules + 8)
	
	mBitmapSize = ModuleSize * (NumberOfModules + 8)
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, mBitmapSize, mBitmapSize)
	cvs.Initialize(p)
	
	
	Dim Matrix(NumberOfModules, NumberOfModules) As Boolean
	Dim Reserved(NumberOfModules, NumberOfModules) As Boolean
	
	Dim Mode() As Byte = Array As Byte(0, 1, 0, 0) 'byte mode
	Dim ContentCountIndicator() As Byte
	If vd.Version >= 10 Then
		ContentCountIndicator = IntTo16Bits(Bytes.Length)
	Else
		ContentCountIndicator = UnsignedByteToBits(Bytes.Length)
	End If
	Dim EncodedData As B4XBytesBuilder
	EncodedData.Initialize
	EncodedData.Append(Mode)
	EncodedData.Append(ContentCountIndicator)
	For Each b As Byte In Bytes
		EncodedData.Append(UnsignedByteToBits(Bit.And(0xff, b)))
	Next
	'add terminator
	Dim PadSize As Int = Min(4, vd.MaxSize - EncodedData.Length)
	Dim pad(PadSize) As Byte
	EncodedData.Append(pad)
	Do While EncodedData.Length Mod 8 <> 0 
		EncodedData.Append(Array As Byte(0))
	Loop
	
	Do While EncodedData.Length < vd.MaxSize
		EncodedData.Append(Array As Byte(1,1,1,0,1,1,0,0))
		If EncodedData.Length < vd.MaxSize Then EncodedData.Append(Array As Byte(0,0,0,1,0,0,0,1))
	Loop
	VersionWithTwoGroups(vd.Generator, vd.Group1Size, vd.Group2Size, vd.Block1Size, vd.Block2Size, EncodedData)
	AddFinders (vd)
	AddDataToMatrix(EncodedData.ToArray, vd)
	DrawMatrix
	cvs.Invalidate
	Dim bmp As B4XBitmap = cvs.CreateBitmap
	cvs.Release
	Return bmp
End Sub

Private Sub VersionWithTwoGroups (generator() As Int, Group1Size As Int, Group2Size As Int, Block1Size As Int, Block2Size As Int, EncodedData As B4XBytesBuilder)
	Dim ecs As List
	ecs.Initialize
	Dim dataBlocks As List
	dataBlocks.Initialize
	Dim PrevIndex As Int
	For block1 = 0 To Group1Size + Group2Size - 1
		Dim BlockSize As Int
		If block1 < Group1Size Then BlockSize = Block1Size Else BlockSize = Block2Size
		Dim Data() As Byte = EncodedData.SubArray2(PrevIndex * 8, (PrevIndex + BlockSize) * 8)
		PrevIndex = PrevIndex + BlockSize
		Dim DataAsInts(Data.Length / 8) As Int
		Dim i As Int
		For i = 0 To Data.Length - 1 Step 8
			DataAsInts(i / 8) = BitsToUnsignedByte(Data, i)
		Next
		dataBlocks.Add(DataAsInts)
		Dim ec() As Int = CalcReedSolomon(DataAsInts, generator)
		If ec.Length < generator.Length - 1 Then
			Dim ec2(generator.Length - 1) As Int
			IntArrayCopy(ec, 0, ec2,  generator.Length - 1 - ec.Length, ec.Length)
			ec = ec2
		End If
		ecs.Add(ec)
	Next
	Dim Interleaved As B4XBytesBuilder
	Interleaved.Initialize
	For i = 0 To Max(Block1Size, Block2Size) - 1
		For block1 = 0 To dataBlocks.Size - 1
			Dim ii() As Int = dataBlocks.Get(block1)
			If ii.Length > i Then
				Interleaved.Append(UnsignedByteToBits(ii(i)))
			End If
		Next
	Next
	For i = 0 To generator.Length - 2
		For block1 = 0 To dataBlocks.Size - 1
			Dim ii() As Int = ecs.Get(block1)
			Interleaved.Append(UnsignedByteToBits(ii(i)))
		Next
	Next
	EncodedData.Clear
	EncodedData.Append(Interleaved.ToArray)
End Sub



Private Sub AddDataToMatrix (Encoded() As Byte, vd As QRVersionData)
	Dim format() As Byte = vd.Format
	Dim order As List = CreateOrder
	'mask 0: (row + column) mod 2 == 0
	For Each b As Byte In Encoded
		Dim xy() As Int = GetNextPosition(order)
		Matrix(xy(0), xy(1)) = (b = 1)
		If (xy(1) + xy(0)) Mod 2 = 0 Then Matrix(xy(0), xy(1)) = Not(Matrix(xy(0), xy(1)))
	Next
	For i = 0 To 5
		Matrix(i, 8) = format(i) = 1
		Matrix(8, NumberOfModules - 1 - i) = format(i) = 1
	Next
	Matrix(7, 8) = format(6) = 1
	Matrix(8, NumberOfModules - 1 - 6) = format(6) = 1
	Matrix(8, 8) = format(7) = 1
	Matrix(8, 7) = format(8) = 1
	For i = 0 To 5
		Matrix(8, 5 - i) = format(i + 9) = 1
	Next
	For i = 0 To 7
		Matrix(NumberOfModules - 1 - 7 + i, 8) = format(7 + i) = 1
	Next
	If vd.Version >= 7 Then
		Dim VersionInformation() As Byte = vd.VersionInformation
		Dim c As Int = 18
		For x = 0 To 5
			For y = 0 To 2
				c = c - 1
				Matrix(x, NumberOfModules - 11 + y) = VersionInformation(c) = 1
				Matrix(NumberOfModules - 11 + y, x) = VersionInformation(c) = 1
			Next
		Next
	End If
End Sub

Private Sub GetNextPosition (order As List) As Int()
	Do While True
		Dim xy() As Int = order.Get(0)
		order.RemoveAt(0)
		If Reserved(xy(0), xy(1)) = False Then Return xy
	Loop
	Return Null
End Sub

Private Sub CreateOrder As List
	Dim Order As List
	Order.Initialize
	Dim x As Int = NumberOfModules - 1
	Dim y As Int = NumberOfModules - 1
	Dim dy As Int = -1
	Do While x >= 0 And y >= 0
		Order.Add(Array As Int(x, y))
		Order.Add(Array As Int(x - 1, y))
		y = y + dy
		If y = -1 Then
			x = x - 2
			y = 0
			dy = 1
		Else If y = NumberOfModules Then
			x = x - 2
			y = NumberOfModules - 1
			dy = -1
		End If
		If x = 6 Then x = x - 1
	Loop
	Return Order
End Sub

Private Sub DrawMatrix
	cvs.DrawRect(cvs.TargetRect, xui.Color_White, True, 0)
	Dim r As B4XRect
	For y = 0 To NumberOfModules - 1
		For x = 0 To NumberOfModules - 1
			r.Initialize((x + 4) * ModuleSize, (y + 4) * ModuleSize, 0, 0)
			r.Width = ModuleSize 
			r.Height = ModuleSize
			Dim clr As Int
			If Matrix(x, y) Then 
				clr = xui.Color_Black
				'cvs.DrawCircle(r.CenterX, r.CenterY, r.Width / 2, clr, True, 0)
				cvs.DrawRect(r, clr, True, 0)
			End If
		Next
	Next
End Sub



Private Sub BitsToUnsignedByte (b() As Byte, Offset As Int) As Int
	Dim res As Int
	For i = 0 To 7
		Dim x As Int = Bit.ShiftLeft(1, 7 - i)
		res = res + b(i + Offset) * x
	Next
	Return res
End Sub

Private Sub UnsignedByteToBits (Value As Int) As Byte()
	TempBB.Clear
	For i = 7 To 0 Step - 1
		Dim x As Int = Bit.ShiftLeft(1, i)
		Dim ii As Int = Bit.And(Value, x)
		If ii <> 0 Then
			TempBB.Append(Array As Byte(1))
		Else
			TempBB.Append(Array As Byte(0))
		End If
	Next

	Return TempBB.ToArray
End Sub

Private Sub IntTo16Bits (Value As Int) As Byte()
	TempBB.Clear
	For i = 15 To 0 Step - 1
		Dim x As Int = Bit.ShiftLeft(1, i)
		Dim ii As Int = Bit.And(Value, x)
		If ii <> 0 Then
			TempBB.Append(Array As Byte(1))
		Else
			TempBB.Append(Array As Byte(0))
		End If
	Next

	Return TempBB.ToArray
End Sub

Private Sub AddFinders (vd As QRVersionData)
	AddFinder(0, 0, 6)
	AddFinder(NumberOfModules - 7, 0, 6)
	AddFinder(0, NumberOfModules - 7, 6)
	AddAlignments(vd.Alignments)
	If vd.Version >= 7 Then
		For x = 0 To 2
			For y = 0 To 5
				Reserved(y, NumberOfModules - 11 + x) = True
				Reserved(NumberOfModules - 11 + x, y) = True
			Next
		Next
	End If
	
	For i = 8 To NumberOfModules - 8
		Matrix(i, 6) = (i Mod 2 = 0)
		Matrix(6, i) = (i Mod 2 = 0)
		Reserved(i, 6) = True
		Reserved(6, i) = True
	Next
	Matrix(8, NumberOfModules - 1 - 7) = True
	Reserved(8, NumberOfModules - 1 - 7) = True
	For i = 0 To 7
		Reserved(7, i) = True
		Reserved(7, NumberOfModules - 1 - i) = True
		Reserved(8, NumberOfModules - 1 - i) = True
		Reserved(NumberOfModules -1 - 7, i) = True
		Reserved(i, 7) = True
		Reserved(i,NumberOfModules -1 - 7) = True
		Reserved(NumberOfModules -1 - i, 7) = True
		Reserved(NumberOfModules -1 - i, 8) = True
	Next
	For i = 0 To 8
		Reserved(8, i) = True
		Reserved(i, 8) = True
	Next
End Sub

Private Sub AddAlignments (Positions() As Int)
	For Each left As Int In Positions
		For Each top As Int In Positions
			AddFinder (left - 2, top - 2, 4)
		Next
	Next
End Sub

Private Sub AddFinder (Left As Int, Top As Int, SizeMinOne As Int)
	For y = 0 To SizeMinOne
		For x = 0 To SizeMinOne
			If Reserved(Left + x, Top + y) Then 
				Return
			End If
		Next
	Next
	For y = 0 To SizeMinOne
		For x = 0 To SizeMinOne
			Dim value As Boolean
			If x = 0 Or x = SizeMinOne Or y = 0 Or y = SizeMinOne Then
				value = True
			Else if x <> 1 And y <> 1 And x <> SizeMinOne - 1 And y <> SizeMinOne - 1 Then
				value = True
			End If
			Matrix(Left + x, Top + y) = value
			Reserved(Left + x, Top + y) = True
		Next
	Next
End Sub

#Region ReedSolomon

Private Sub CalcReedSolomon (Input() As Int, Generator() As Int) As Int()
	Dim ecBytes As Int = Generator.Length - 1
	Dim InfoCoefficients(Input.Length) As Int
	IntArrayCopy(Input, 0, InfoCoefficients, 0, Input.Length)
	InfoCoefficients = CreateGFPoly(InfoCoefficients)
	InfoCoefficients = PolyMultiplyByMonomial(InfoCoefficients, ecBytes, 1)
	Dim remainder() As Int = PolyDivide(InfoCoefficients, Generator)
	Return remainder
End Sub


Private Sub PrepareTables
	Dim x = 1 As Int
	Dim Primitive As Int = 285
	For i = 0 To GFSize - 1
		ExpTable(i) = x
		x = x * 2
		If x >= GFSize Then
			x = Bit.Xor(Primitive, x)
			x = Bit.And(GFSize - 1, x)
		End If
	Next
	For i = 0 To GFSize - 2
		LogTable(ExpTable(i)) = i
	Next
End Sub

Private Sub CreateGFPoly(Coefficients() As Int) As Int()
	If Coefficients.Length > 1 And Coefficients(0) = 0 Then
		Dim FirstNonZero As Int = 1
		Do While FirstNonZero < Coefficients.Length And Coefficients(FirstNonZero) = 0
			FirstNonZero = FirstNonZero + 1
		Loop
		If FirstNonZero = Coefficients.Length Then
			Return Array As Int(0)
		End If
		Dim res(Coefficients.Length - FirstNonZero) As Int
		IntArrayCopy(Coefficients, FirstNonZero, res, 0, res.Length)
		Return res
	End If
	Return Coefficients
End Sub

Private Sub PolyAddOrSubtract(This() As Int, Other() As Int) As Int()
	If This(0) = 0 Then Return Other
	If Other(0) = 0 Then Return This
	Dim Small() As Int = This
	Dim Large() As Int = Other
	If Small.Length > Large.Length Then
		Dim temp() As Int = Small
		Small = Large
		Large = temp
	End If
	Dim SumDiff(Large.Length) As Int
	Dim LengthDiff As Int = Large.Length - Small.Length
	IntArrayCopy(Large, 0, SumDiff, 0, LengthDiff)
	For i = LengthDiff To Large.Length - 1
		SumDiff(i) = Bit.Xor(Small(i - LengthDiff), Large(i))
	Next
	Return CreateGFPoly(SumDiff)
End Sub

Private Sub IntArrayCopy(Src() As Int, SrcOffset As Int, Dest() As Int, DestOffset As Int, Count As Int)
	For i = 0 To Count - 1
		Dest(DestOffset + i) = Src(SrcOffset + i)
	Next
End Sub



Private Sub PolyMultiplyByMonomial (This() As Int, Degree As Int, Coefficient As Int) As Int()
	If Coefficient = 0 Then Return PolyZero
	Dim product(This.Length + Degree) As Int
	For i = 0 To This.Length - 1
		product(i) = GFMultiply(This(i), Coefficient)
	Next
	Return CreateGFPoly(product)
End Sub

Private Sub PolyDivide (This() As Int, Other() As Int) As Int()
	Dim quotient() As Int = PolyZero
	Dim remainder() As Int = This
	Dim denominatorLeadingTerm As Int = Other(0)
	Dim inverseDenominatorLeadingTerm As Int = GFInverse(denominatorLeadingTerm)
	Do While remainder.Length >= Other.Length And remainder(0) <> 0
		Dim DegreeDifference As Int = remainder.Length - Other.Length
		Dim scale As Int = GFMultiply(remainder(0), inverseDenominatorLeadingTerm)
		Dim term() As Int = PolyMultiplyByMonomial(Other, DegreeDifference, scale)
		Dim iterationQuotient() As Int = GFBuildMonomial(DegreeDifference, scale)
		quotient = PolyAddOrSubtract(quotient, iterationQuotient)
		remainder = PolyAddOrSubtract(remainder, term)
	Loop
	Return remainder
End Sub

Private Sub GFInverse(a As Int) As Int
	Return ExpTable(GFSize - LogTable(a) - 1)
End Sub

Private Sub GFMultiply(a As Int, b As Int) As Int
	If a = 0 Or b = 0 Then
		Return 0
	End If
	Return ExpTable((LogTable(a) + LogTable(b)) Mod (GFSize - 1))
End Sub

Private Sub GFBuildMonomial(Degree As Int, Coefficient As Int) As Int()
	If Coefficient = 0 Then Return PolyZero
	Dim c(Degree + 1) As Int
	c(0) = Coefficient
	Return c
End Sub

#End Region