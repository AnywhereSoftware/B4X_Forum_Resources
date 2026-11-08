B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Type PNGChunk (StartIndex As Int, DataLength As Int, ChunkType As String)
	Type PNGFrame (Bmp As B4XBitmap, DelayMs As Int, SeqNumber As Int, Width As Int, Height As Int, XOffset As Int, YOffset As Int, DisposeOp As Int, BlendOp As Int)
	Private raf As RandomAccessFile
	Private mData() As Byte
	Private NumberOfFrames As Int
	Private FrameBuilder As B4XBytesBuilder
	Private chunks As List
	Private ChunkIndex As Int
	#if B4i
	Private nme As NativeObject
	#else
	Private CRC32 As JavaObject
	#End If
	Private IDAT() As Byte
	Private PlayIndex As Int
	Private Frames As List
	Public ImageWidth, ImageHeight As Int
	Private ImageViewFullWidth, ImageViewFullHeight, ImageViewFullLeft, ImageViewFullTop As Int
	Private NumberOfChunksBeforeFirstFrame As Int
	Private NoAnimatedBitmap As B4XBitmap
	Private Const DISPOSE_NONE = 0, DISPOSE_BACKGROUND = 1, DISPOSE_PREVIOUS = 2 As Int
	Private Const BLEND_OP_SOURCE = 0, BLEND_OP_OVER = 1 As Int 'ignore
	Private Buffer As BitmapCreator
	Private iv As B4XView
	Private TransparentBrush As BCBrush
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	FrameBuilder.Initialize
	chunks.Initialize
	IDAT = "IDAT".GetBytes("ASCII")
	Frames.Initialize
	#if B4i
	nme = Me
	#else
	CRC32.InitializeNewInstance("java.util.zip.CRC32", Null)
	#End If
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
	mBase.Tag = Me
	iv = CreateImageView
	mBase.AddView(iv, 0, 0, 0, 0)
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	Stop
	Play
End Sub

'Returns false if the image is invalid
Public Sub SetData (data() As Byte) As Boolean
	Stop
	mData = data
	chunks.Clear
	NumberOfFrames = 0
	ChunkIndex = 0
	Frames.Clear
	NoAnimatedBitmap = Null
	Dim raf As RandomAccessFile
	Dim FirstFCTLFound As Boolean
	raf.Initialize3(data, False)
	If raf.ReadLong(raf.CurrentPosition) <> -8552249625308161526 Then
		Log("invalid data")
		Return False
	End If
	Do While raf.CurrentPosition < mData.Length
		Dim Ch As PNGChunk = ReadChunk(raf.CurrentPosition)
		chunks.Add(Ch)
'		Log(Ch.ChunkType)
		If Ch.ChunkType = "IHDR" Then
			ImageWidth = raf.ReadInt(Ch.StartIndex + 8)
			ImageHeight = raf.ReadInt(raf.CurrentPosition)
		Else If Ch.ChunkType = "acTL" Then
			chunks.RemoveAt(chunks.Size - 1)
			NumberOfFrames = raf.ReadInt(Ch.StartIndex + 8)
		End If
		If Ch.ChunkType = "IDAT" Then
			If NumberOfFrames <= 1 Then
				Exit
			Else If FirstFCTLFound = False Then
				chunks.RemoveAt(chunks.Size - 1)
			End If
		End If
		If Ch.ChunkType = "fcTL" And FirstFCTLFound = False Then
			FirstFCTLFound = True
			NumberOfChunksBeforeFirstFrame = chunks.Size - 1
		End If
		If Ch.ChunkType = "IEND" Then Exit
		raf.CurrentPosition = Ch.StartIndex + Ch.DataLength + 12
	Loop
	If NumberOfFrames > 0 Then
		LoadFrames
	Else
		NotAnimated
	End If
	raf.Close
	Play
	Return True
End Sub

Private Sub CreateImageView As B4XView
	Dim iiv As ImageView
	iiv.Initialize("")
	Return iiv
End Sub

Public Sub Play
	Dim bmpRatio As Float = ImageWidth / ImageHeight
	Dim viewRatio As Float = mBase.Width / mBase.Height
	If viewRatio > bmpRatio Then
		ImageViewFullHeight = mBase.Height
		ImageViewFullWidth = mBase.Height * bmpRatio
	Else
		ImageViewFullWidth = mBase.Width
		ImageViewFullHeight = mBase.Width / bmpRatio
	End If
	ImageViewFullLeft = mBase.Width / 2 - ImageViewFullWidth / 2
	ImageViewFullTop = mBase.Height / 2 - ImageViewFullHeight / 2
	iv.SetLayoutAnimated(0, ImageViewFullLeft, ImageViewFullTop, ImageViewFullWidth, ImageViewFullHeight)
	If NumberOfFrames = 0 Then
		If NoAnimatedBitmap.IsInitialized Then
			SetBitmap(NoAnimatedBitmap)
		End If
	Else
		PlayIndex = PlayIndex + 1
		Dim MyIndex As Int = PlayIndex
		Dim FrameIndex As Int = 0
		Do While MyIndex = PlayIndex
			Dim frame As PNGFrame = Frames.Get(FrameIndex)
			SetFrame(frame)
			Sleep(Max(16, frame.DelayMs))
			FrameIndex = (FrameIndex + 1) Mod Frames.Size
		Loop
	End If
End Sub

Private Sub SetFrame (frame As PNGFrame)
	SetBitmap(frame.Bmp)
End Sub



Private Sub SetBitmap(bmp As B4XBitmap)
	iv.SetBitmap(bmp)
	#if B4A
	Dim iiv As ImageView = iv
	iiv.Gravity = Gravity.FILL
	#End If
End Sub

Public Sub Stop
	PlayIndex = PlayIndex + 1
End Sub

Private Sub LoadFrames
	Buffer.Initialize(ImageWidth, ImageHeight)
	TransparentBrush = Buffer.CreateBrushFromColor(xui.Color_Transparent)
	Do While ChunkIndex < chunks.Size - 1
		Dim chunk As PNGChunk = chunks.Get(ChunkIndex)
		If chunk.ChunkType = "fcTL" Then
			Dim fr As PNGFrame = LoadFrame
			If Frames.Size = 0 And fr.DisposeOp = DISPOSE_PREVIOUS Then fr.DisposeOp = DISPOSE_BACKGROUND
			Frames.Add(fr)
			DrawLastFrameToBuffer
		End If
		ChunkIndex = ChunkIndex + 1
	Loop
	
End Sub

Private Sub DrawLastFrameToBuffer
	Dim fr As PNGFrame = Frames.Get(Frames.Size - 1)
	If fr.DisposeOp = DISPOSE_PREVIOUS Then
		Dim prev As B4XBitmap = Buffer.Bitmap.Crop(0, 0, Buffer.mWidth, Buffer.mHeight)
	End If
	Dim bc As BitmapCreator
	bc.Initialize(fr.Bmp.Width, fr.Bmp.Height)
	bc.CopyPixelsFromBitmap(fr.Bmp)
	Buffer.DrawBitmapCreator(bc, bc.TargetRect, fr.XOffset, fr.YOffset, fr.BlendOp = BLEND_OP_SOURCE)
	fr.Bmp = Buffer.Bitmap.Crop(0, 0, Buffer.mWidth, Buffer.mHeight)
	Select fr.DisposeOp
		Case DISPOSE_NONE
		Case DISPOSE_BACKGROUND
			Dim r As B4XRect
			r.Initialize(fr.XOffset, fr.YOffset, fr.XOffset + fr.Width, fr.YOffset + fr.Height)
			Buffer.DrawRect2(r, TransparentBrush, True, 0)
		Case DISPOSE_PREVIOUS
			Buffer.CopyPixelsFromBitmap(prev)
	End Select
'	Dim out As OutputStream = File.OpenOutput(File.DirApp, Frames.Size & ".png", False)
'	fr.Bmp.WriteToStream(out, 100, "PNG")
'	out.Close
End Sub

Private Sub LoadFrame As PNGFrame
	Dim frame As PNGFrame
	frame.Initialize
	FrameBuilder.Clear
	Dim fcTL As PNGChunk = chunks.Get(ChunkIndex)
	ChunkIndex = ChunkIndex + 1
	raf.CurrentPosition = fcTL.StartIndex + 8
	frame.SeqNumber = raf.ReadInt(fcTL.StartIndex + 8)
	frame.Width = raf.ReadInt(raf.CurrentPosition)
	frame.Height = raf.ReadInt(raf.CurrentPosition)
	frame.XOffset = raf.ReadInt(raf.CurrentPosition)
	frame.YOffset = raf.ReadInt(raf.CurrentPosition)
	Dim numerator As Int = raf.ReadShort(raf.CurrentPosition)
	Dim denominator As Int = raf.ReadShort(raf.CurrentPosition)
	frame.DisposeOp = raf.ReadUnsignedByte(raf.CurrentPosition)
	frame.BlendOp = raf.ReadUnsignedByte(raf.CurrentPosition)
	
	If denominator = 0 Then denominator = 100 
	frame .DelayMs = numerator / denominator * 1000
	frame.Bmp = LoadImage (frame)
	Return frame
End Sub

Private Sub LoadImage (frame As PNGFrame) As B4XBitmap
	Dim ch As PNGChunk = chunks.Get(ChunkIndex)
	FrameBuilder.Clear
	Dim hdr As PNGChunk = chunks.Get(0)
	FrameBuilder.Append2(mData, 0, 16) 'PNG + length + IHDR
	WriteInt(frame.Width)
	WriteInt(frame.Height)
	FrameBuilder.Append2(mData, hdr.StartIndex + 16, hdr.DataLength - 8)
	WriteInt(CalcCRC(FrameBuilder, 12))
	For i = 1 To NumberOfChunksBeforeFirstFrame - 1
		Dim ch2 As PNGChunk = chunks.Get(i)
		FrameBuilder.Append2(mData, ch2.StartIndex, ch2.DataLength + 12)
	Next
	Dim IDATStart As Int = FrameBuilder.Length
	If ch.ChunkType = "IDAT" Then
		WriteInt(ch.DataLength)
		FrameBuilder.Append(IDAT) 'type
		FrameBuilder.Append2(mData, ch.StartIndex + 8, ch.DataLength) 'data
	Else
		WriteInt(ch.DataLength - 4)
		FrameBuilder.Append(IDAT) 'type
		FrameBuilder.Append2(mData, ch.StartIndex + 12, ch.DataLength - 4) 'data without sequence
	End If
	WriteInt(CalcCRC(FrameBuilder, IDATStart + 4))
	Dim iend As PNGChunk = chunks.Get(chunks.Size - 1)
	FrameBuilder.Append2(mData, iend.StartIndex, iend.DataLength + 12) 'IEND
'	File.WriteBytes(File.DirApp,  ChunkIndex & ".png", FrameBuilder.ToArray)
	Dim in As InputStream
	in.InitializeFromBytesArray(FrameBuilder.ToArray, 0, FrameBuilder.Length)
	Return LoadBitmapFromStream(in)
End Sub

Private Sub WriteInt (v As Int)
	Dim b(1) As Byte
	For i = 3 To 0 Step - 1
		b(0) = Bit.And(0xff, Bit.ShiftRight(v, i * 8))
		FrameBuilder.Append(b)
	Next
End Sub

Private Sub NotAnimated
	Log("not animated")
	Dim in As InputStream
	in.InitializeFromBytesArray(mData, 0, mData.Length)
	NoAnimatedBitmap = LoadBitmapFromStream(in)
End Sub

Private Sub ReadChunk (Position As Int) As PNGChunk
	Dim Ch As PNGChunk
	Ch.Initialize
	Ch.StartIndex = Position
	Ch.DataLength = raf.ReadInt(Position)
	Ch.ChunkType = BytesToString(mData, raf.CurrentPosition, 4, "ASCII")
	raf.CurrentPosition = raf.CurrentPosition + 4
	raf.CurrentPosition = raf.CurrentPosition + Ch.DataLength + 4
	Return Ch
End Sub
#if B4i
Private Sub CalcCRC (Buffer1 As B4XBytesBuilder, Start As Int) As Long
	return nme.RunMethod("crc32:::", Array(Buffer1.InternalBuffer, Start, Buffer1.Length - Start)).AsNumber
End Sub
#else
Private Sub CalcCRC (Buffer1 As B4XBytesBuilder, Start As Int) As Long
	CRC32.RunMethod("reset", Null)
	CRC32.RunMethod("update", Array(Buffer1.InternalBuffer, Start, Buffer1.Length - Start))
	Return CRC32.RunMethod("getValue", Null)
End Sub
#End If

Private Sub LoadBitmapFromStream (in As InputStream) As B4XBitmap
	#if B4J
	Dim bmp As Image
	#else
	Dim bmp As Bitmap
	#end if
	bmp.Initialize2(in)
	in.Close
	Return bmp
End Sub

#If OBJC
#import <zlib.h>
- (long long) crc32: (B4IArray*) data :(int)start :(int)length {
long long result = crc32(0, data.bytesData.bytes + start, length);
return result;
}
#end if