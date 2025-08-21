B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private cache As Map
	Type X2SpriteGraphicData (Name As String, MapsOfCompressedBCs As List, AntiAlias As Boolean, AngleInterval As Int, _
		OriginalBCs As List, SizeOfAllCompressed As Int, LastUsed As Long, VerticalSymmetry As Boolean, HorizontalSymmetry As Boolean)
	Private CVS(6) As B4XCanvas
	Private CVSPanel(6) As B4XView
	Private CVSProxy(6) As BitmapCreator
	Public MAX_SIZE_FOR_ANTIALIAS As Int = 300
	Private WorkingSpace As BitmapCreator
	Private X2 As X2Utils
	Private MAX_SIZE_OF_ALL_COMPRESSEDBCS As Int = 30 * 1024 * 1024
	Private TotalSize As Int
	Private Transform As B2Transform
	Private RectShape As B2PolygonShape
	Private OutputAABB As B2AABB
	Private TempId As Int
	Public Const TempPrefix As String = "~temp"
	Public CBCCache As InternalCompressedBCCache
	Private AABuffer As InternalAntiAliasingBuffer
End Sub

Public Sub Initialize (vX2 As X2Utils)
	CBCCache.Initialize
	CBCCache.ColorsMap.Initialize
	cache.Initialize
	WorkingSpace.Initialize(300, 300)
	Dim b(WorkingSpace.SAME_COLOR_LENGTH_FOR_CACHE * 4 * WorkingSpace.MAX_SAME_COLOR_SIZE + 4) As Byte
	CBCCache.mBuffer = b
	X2 = vX2
	Transform.Initialize
	RectShape.Initialize
	OutputAABB.Initialize
	InitializeIntsArray
End Sub

Private Sub InitializeIntsArray
	AABuffer.Initialize
	#if B4i
	Dim IntsArray(WorkingSpace.mWidth * WorkingSpace.mHeight * 5 * 4) As Byte
	#else
	Dim IntsArray(WorkingSpace.mWidth * WorkingSpace.mHeight * 5) As Int
	#End If
	AABuffer.IntsArray = IntsArray
End Sub

Public Sub GetTempName As String
	TempId = TempId + 1
	Return TempPrefix & TempId
End Sub

'Returns a vector with the graphic size in meters.
Public Sub GetGraphicSizeMeters (Name As String, Index As Int) As B2Vec2
	Dim data As X2SpriteGraphicData = cache.Get(Name.ToLowerCase)
	Dim bc As BitmapCreator = data.OriginalBCs.Get(Index)
	Dim vec As B2Vec2
	vec.X = bc.mWidth / X2.mBCPixelsPerMeter
	vec.Y = bc.mHeight / X2.mBCPixelsPerMeter
	Return vec
End Sub
'Returns the number of graphic frames mapped to the given name.
Public Sub GetGraphicsCount(Name As String) As Int
	Dim data As X2SpriteGraphicData = cache.Get(Name.ToLowerCase)
	If data = Null Then Return 0
	Return data.OriginalBCs.Size
End Sub

'Adds to the cache all the rotated frames. This can be useful if you see a slowdown because of rotations.
'Use carefully. In most cases it is better to let the frames added when needed.
Public Sub WarmGraphic (Name As String)
	Dim n As Long = DateTime.Now
	Name = Name.ToLowerCase
	Dim data As X2SpriteGraphicData = cache.Get(Name)
	For i = 0 To data.MapsOfCompressedBCs.Size - 1
		For degrees = 0 To 359 Step data.AngleInterval
			X2.GraphicCache.GetGraphic2(Name, i, degrees, False, False)
		Next
	Next
	#if Not (X2SkipLogs)
	Log($"Warm graphic: ${Name}, ${DateTime.Now - n} ms"$)
	#End If
End Sub

'Name - Key
'X2ScaledBitmaps - List or array with the ScaledBitmaps objects.
Public Sub PutGraphic(Name As String, X2ScaledBitmaps As List) As X2SpriteGraphicData
	Dim sb As X2ScaledBitmap = X2ScaledBitmaps.Get(0)
	Dim antialias As Boolean = sb.Bmp.Width / sb.Scale * sb.Bmp.Height / sb.Scale < 3000
	If Name.StartsWith(TempPrefix) Then antialias = False
	Return PutGraphic2(Name, X2ScaledBitmaps, antialias, 5)
End Sub

'Name - Key
'X2ScaledBitmaps - List or array with the ScaledBitmaps objects.
'AntiAlias - Whether to use antialiasing when rotating the images. Can have a large impact on performace.
'AngleInterval - Default value is 5 degrees. 
Public Sub PutGraphic2(Name As String, X2ScaledBitmaps As List, AntiAlias As Boolean, AngleInterval As Int) As X2SpriteGraphicData
	#if Not (X2SkipLogs)
	Log($"New graphic: ${Name}"$)
	#end if
	Dim data As X2SpriteGraphicData
	data.Initialize
	data.Name = Name
	data.MapsOfCompressedBCs.Initialize
	data.OriginalBCs.Initialize
	data.LastUsed = DateTime.Now
	For Each sb As X2ScaledBitmap In X2ScaledBitmaps
		Dim bc As BitmapCreator
		bc.Initialize(sb.Bmp.Width / sb.Scale, sb.bmp.Height / sb.Scale)
		bc.CopyPixelsFromBitmap(sb.bmp)
		data.OriginalBCs.Add(bc)
		Dim m As Map
		m.Initialize
		Dim cbc As CompressedBC = bc.ExtractCompressedBC(bc.TargetRect, CBCCache)
		m.Put(0, cbc)
		data.MapsOfCompressedBCs.Add(m)
		data.SizeOfAllCompressed = data.SizeOfAllCompressed + cbc.mBuffer.Length
	Next
	data.AngleInterval = AngleInterval
	data.AntiAlias = AntiAlias
	cache.Put(data.Name.ToLowerCase, data)
	TotalSize = TotalSize + data.SizeOfAllCompressed
	Return data
End Sub

'Similar to PutGraphic. Allows adding a list of BitmapCreators directly.
'The list is not copied. Don't modify it.
Public Sub PutGraphicBCs(Name As String, BCs As List, AntiAlias As Boolean, AngleInterval As Int) As X2SpriteGraphicData
	#if Not (X2SkipLogs)
	Log($"New graphic: ${Name}"$)
	#end if
	Dim data As X2SpriteGraphicData
	data.Initialize
	data.Name = Name
	data.MapsOfCompressedBCs.Initialize
	data.OriginalBCs.Initialize
	data.LastUsed = DateTime.Now
	data.OriginalBCs = BCs
	For Each bc As BitmapCreator In BCs
		Dim m As Map
		m.Initialize
		Dim cbc As CompressedBC = bc.ExtractCompressedBC(bc.TargetRect, CBCCache)
		m.Put(0, cbc)
		data.MapsOfCompressedBCs.Add(m)
		data.SizeOfAllCompressed = data.SizeOfAllCompressed + cbc.mBuffer.Length
	Next
	data.AngleInterval = AngleInterval
	data.AntiAlias = AntiAlias
	cache.Put(data.Name.ToLowerCase, data)
	TotalSize = TotalSize + data.SizeOfAllCompressed
	Return data
End Sub


'Gets a graphic frame from the cache.
Public Sub GetGraphic(Name As String, Index As Int) As CompressedBC
	Return GetGraphic2(Name, Index, 0, False, False)
End Sub

Public Sub GetGraphic2(Name As String, Index As Int, Degrees As Int, FlipHorizontally As Boolean, FlipVertically As Boolean) As CompressedBC
	Dim data As X2SpriteGraphicData = cache.Get(Name.ToLowerCase)
	If data = Null Then
		Log($"Error: graphic not found: ${Name}"$)
	End If
	data.LastUsed = DateTime.Now
	Dim m As Map = data.MapsOfCompressedBCs.Get(Index)
	Degrees = Degrees Mod 360
	If Degrees < 0 Then Degrees = 360 + Degrees
	Dim delta As Int = Degrees Mod data.AngleInterval
	If delta > data.AngleInterval / 2 Then
		Degrees = (Degrees - delta + data.AngleInterval) Mod 360
	Else
		Degrees = Degrees - delta
	End If
	Dim key As Int = Degrees
	If FlipHorizontally Then key = key + 1000
	If FlipVertically Then key = key + 2000
	If m.ContainsKey(key) Then Return m.Get(key)
'	Dim n As Long = DateTime.Now
	Dim TempBC As CompressedBC
	If FlipHorizontally <> FlipVertically Then
		Dim NonFlippedCbc As CompressedBC = GetGraphic2(Name, Index, -Degrees, False, False)
		TempBC = WorkingSpace.FlipCompressedBitmap(NonFlippedCbc, FlipHorizontally, FlipVertically)
	Else If FlipHorizontally And FlipVertically Then
		TempBC = GetGraphic2(Name, Index, Degrees + 180, False, False)
	Else If Degrees > 90 And (data.VerticalSymmetry Or data.HorizontalSymmetry) Then
		Dim quarter As Int = Degrees / 90
		Select quarter
			Case 1 '90 - 180
				TempBC = GetGraphic2(Name, Index, 180 - Degrees, False, False)
				TempBC = WorkingSpace.FlipCompressedBitmap(TempBC,Not(data.HorizontalSymmetry) , data.HorizontalSymmetry)
			Case 2 '180 - 270
				TempBC = GetGraphic2(Name, Index, Degrees - 180, False, False)
				TempBC = WorkingSpace.FlipCompressedBitmap(TempBC, True, True)
			Case 3 '270 - 360
				TempBC = GetGraphic2(Name, Index, 360 - Degrees, False, False)
				TempBC = WorkingSpace.FlipCompressedBitmap(TempBC, Not(data.VerticalSymmetry) , data.VerticalSymmetry)
		End Select
	Else If Degrees >= 180 Then
		TempBC = GetGraphic2(Name, Index, Degrees - 180, False, False)
		TempBC = WorkingSpace.FlipCompressedBitmap(TempBC, True, True)
	Else
		Dim OriginalBC As BitmapCreator = data.OriginalBCs.Get(Index)
		Dim r As B4XRect = FindRotatedRect(OriginalBC, Degrees)
		Dim dt As DrawTask = WorkingSpace.CreateDrawTask(OriginalBC, OriginalBC.TargetRect, r.Width / 2, r.Height / 2, True)
		dt.Degrees = Degrees
		If r.Width > WorkingSpace.mWidth Or r.Height > WorkingSpace.mHeight Then
			Log("Increasing WorkingSpace size.")
			Dim WorkingSpace As BitmapCreator
			WorkingSpace.Initialize(r.Width * 1.4, r.Height * 1.4)
			InitializeIntsArray
		Else
			WorkingSpace.FillRect(xui.Color_Transparent, r)
		End If
		If data.AntiAlias And Degrees Mod 90 <> 0 Then
			WorkingSpace.DrawRotatedCBC(m.Get(0), Degrees, r.Width, r.Height, AABuffer)
		Else
			WorkingSpace.DrawBitmapCreatorTransformed(dt)
		End If
		TempBC = WorkingSpace.ExtractCompressedBC(r, CBCCache)
	End If
	
	m.Put(key, TempBC)
'	Log($"Create new graphic: ${Name} - ${Degrees} ${FlipHorizontally} / ${FlipVertically} (${ (DateTime.Now - n)})"$)
	data.SizeOfAllCompressed = data.SizeOfAllCompressed + TempBC.mBuffer.Length
	TotalSize = TotalSize + TempBC.mBuffer.Length
	If TotalSize > MAX_SIZE_OF_ALL_COMPRESSEDBCS Then
		TrimCache
	End If
	'Log(TotalSize & ". " & CBCCache.ColorsMap.Size)
	Return TempBC
End Sub

Private Sub TrimCache
	Log("Trim Cache")
	Log($"Before: ${TotalSize}"$)
	Dim dates As List
	dates.Initialize
	For Each data As X2SpriteGraphicData In cache.Values
		If data.SizeOfAllCompressed > 0 Then dates.Add(data)
	Next
	dates.SortType("LastUsed", True)
	For i = 0 To dates.Size / 2
		Dim data As X2SpriteGraphicData = dates.Get(i)
		For Each m As Map In data.MapsOfCompressedBCs
			Dim zero As CompressedBC = m.Get(0)
			m.Clear
			m.Put(0, zero)
		Next
		TotalSize = TotalSize - data.SizeOfAllCompressed
		data.SizeOfAllCompressed = 0
	Next
	Log($"After: ${TotalSize}"$)
End Sub

'Remove graphics from the cache. Call when the graphic is no longer needed.
Public Sub RemoveGraphics (Name As String)
	#if Not (X2SkipLogs)
	Log("Remove graphic: " & Name)
	#end if
	Dim data As X2SpriteGraphicData = cache.Get(Name.ToLowerCase)
	TotalSize = TotalSize - data.SizeOfAllCompressed
	cache.Remove(Name.ToLowerCase)
End Sub

'Creates a DrawTask.
Public Sub GetDrawTask (Name As String, Index As Int, Degrees As Int, FlipH As Boolean, FlipV As Boolean, TargetX As Int, TargetY As Int) As DrawTask
	Dim sprite As CompressedBC = GetGraphic2(Name, Index, Degrees, FlipH, FlipV)
	Dim dt As DrawTask = WorkingSpace.CreateDrawTask(sprite, Null, 0, 0, False)
	dt.TargetX = TargetX - sprite.mWidth / 2
	dt.TargetY = TargetY - sprite.mHeight / 2
	dt.SrcRect = sprite.TargetRect
	dt.IsCompressedSource = True
	Return dt
End Sub

'Returns a square canvas larger than the specified size. Canvas.TargetView.Tag will return a BitmapCreator with the same non-smoothed size.
'The canvas size is multiplied by X2.BmpSmoothScale. 
'Maximum size is MAX_SIZE_FOR_ANTIALIAS (300).
Public Sub GetCanvas(Size As Int) As B4XCanvas
	Dim interval As Int = MAX_SIZE_FOR_ANTIALIAS / CVSPanel.Length
	Dim i As Int = Min(CVSPanel.Length - 1,  Size / interval)
	If CVSPanel(i).IsInitialized = False Then
		Dim MaxSize = (i + 1) * interval As Int
		If xui.IsB4J Then
			CVSPanel(i) = xui.CreatePanel("")
		Else
			Dim iv As ImageView
			iv.Initialize("")
			CVSPanel(i) = iv
		End If
		CVSPanel(i).SetLayoutAnimated(0, 0, 0, MaxSize * X2.BmpSmoothScale, _
			 MaxSize * X2.BmpSmoothScale)
		CVS(i).Initialize(CVSPanel(i))
		CVSProxy(i).Initialize(MaxSize, MaxSize)
		CVSPanel(i).Tag = CVSProxy(i)
	End If
	Return CVS(i)
End Sub

'Returns a BitmapCreator larger than the specified size. Maximum size is MAX_SIZE_FOR_ANTIALIAS (300).
Public Sub GetBitmapCreator(Size As Int) As BitmapCreator
	Return GetCanvas(Size).TargetView.Tag
End Sub

Private Sub FindRotatedRect(Input As BitmapCreator, Degrees As Int) As B4XRect
	Transform.Angle = X2.DegreesToB2Angle(Degrees)
	RectShape.SetAsBox(Input.mWidth / 2, Input.mHeight / 2)
	RectShape.ComputeAABB(OutputAABB, Transform)
	Dim r As B4XRect
	r.Initialize(0, 0, Ceil(OutputAABB.TopRight.X - OutputAABB.BottomLeft.X), Ceil(OutputAABB.TopRight.Y - OutputAABB.BottomLeft.Y))
	Return r
End Sub



#Region Extension to BitmapCreator to draw flipped BCs
Public Sub DrawBitmapCreatorFlipped (bc As BitmapCreator, Source As BitmapCreator, SrcScaleX As Float, SrcScaleY As Float, SrcRect1 As B4XRect _
	, FlipHorizontally As Boolean, FlipVertically As Boolean, FlipDiagonally As Boolean)
	Dim SrcRectWidth As Int = SrcRect1.Width
	Dim SrcRectHeight As Int = SrcRect1.Height
	Dim dx As Float = 1 / SrcScaleX
	Dim dy As Float = 1 / SrcScaleY
	Dim StartSrcX As Float
	Dim EndSrcX As Int
	Dim StartSrcY As Float
	Dim EndSrcY As Int
	If FlipDiagonally And FlipHorizontally And FlipVertically = False Then
		FlipHorizontally = False
		FlipVertically = True
	Else if FlipDiagonally And FlipVertically And FlipHorizontally = False Then
		FlipHorizontally = True
		FlipVertically = False
	End If
	If FlipHorizontally Then
		StartSrcX = SrcRect1.Right - dx
		EndSrcX = SrcRect1.Left
		dx = -dx
	Else
		EndSrcX = SrcRect1.Right - dx
		StartSrcX = SrcRect1.Left
	End If
	If FlipVertically Then
		StartSrcY = SrcRect1.Bottom - dy
		EndSrcY = SrcRect1.Top
		dy = -dy
	Else
		StartSrcY = SrcRect1.Top
		EndSrcY = SrcRect1.Bottom - dy
	End If
	
	Dim TargetX As Int = 0
	Dim TargetY As Int = 0
	Dim TargetYStart As Int = TargetY
	Dim TargetYEnd As Int = Round((TargetY + SrcRectHeight) * SrcScaleY) - 1
	Dim TargetXStart As Int = TargetX
	Dim TargetXEnd As Int = Round((TargetX + SrcRectWidth) * SrcScaleX) - 1
	#if B4i
	Dim mbuffer() As Byte = bc.Buffer
	Dim SourceBuffer() As Byte = Source.Buffer
	#End If
	Dim SrcX, SrcY As Float
	Dim SSrcX, SSrcY As Int
	SrcY = StartSrcY
	If FlipDiagonally Then
		For y = TargetYStart To TargetYEnd - 1
			SrcX = StartSrcX
			SSrcY = SrcY
			For x = TargetXStart To TargetXEnd - 1
				SSrcX = SrcX
				bc.CopyPixelIgnoreSemiTransparent(Source, SSrcX, SSrcY, y, x , True)
				SrcX = SrcX + dx
			Next
			bc.CopyPixelIgnoreSemiTransparent(Source, EndSrcX, SSrcY, y, x , True)
			SrcY = SrcY + dy
		Next
		SrcX = StartSrcX
		For x = TargetXStart To TargetXEnd - 1
			SSrcX = SrcX
			bc.CopyPixelIgnoreSemiTransparent(Source, SSrcX, EndSrcY, y, x , True)
			SrcX = SrcX + dx
		Next
		bc.CopyPixelIgnoreSemiTransparent(Source, EndSrcX, EndSrcY, y, x , True)
	Else
		For y = TargetYStart To TargetYEnd - 1
			SrcX = StartSrcX
			SSrcY = SrcY
			For x = TargetXStart To TargetXEnd - 1
				SSrcX = SrcX
				#if B4i
				Dim SourceCP As Int = SSrcX * 4 + SSrcY * Source.mWidth * 4
				If Bit.FastArrayGetByte(SourceBuffer, SSrcX * 4 + SSrcY * Source.mWidth * 4 + 3) > 0 Then
					Dim TargetCP As Int = x * 4 + y * bc.mWidth * 4
					Bit.FastArraySetByte(mbuffer, TargetCP, Bit.FastArrayGetByte(SourceBuffer, SourceCP))
					Bit.FastArraySetByte(mbuffer, TargetCP + 1, Bit.FastArrayGetByte(SourceBuffer, SourceCP + 1))
					Bit.FastArraySetByte(mbuffer, TargetCP + 2, Bit.FastArrayGetByte(SourceBuffer, SourceCP + 2))
					Bit.FastArraySetByte(mbuffer, TargetCP + 3, Bit.FastArrayGetByte(SourceBuffer, SourceCP + 3))
				End If
				#else
				bc.CopyPixelIgnoreSemiTransparent(Source, SSrcX, SSrcY, x, y , True)
				#end if
				SrcX = SrcX + dx
			Next
			bc.CopyPixelIgnoreSemiTransparent(Source, EndSrcX, SSrcY, x, y , True)
			SrcY = SrcY + dy
		Next
		SrcX = StartSrcX
		For x = TargetXStart To TargetXEnd - 1
			SSrcX = SrcX
			bc.CopyPixelIgnoreSemiTransparent(Source, SSrcX, EndSrcY, x, y , True)
			SrcX = SrcX + dx
		Next
		bc.CopyPixelIgnoreSemiTransparent(Source, EndSrcX, EndSrcY, x, y , True)
	End If
End Sub
#End Region

