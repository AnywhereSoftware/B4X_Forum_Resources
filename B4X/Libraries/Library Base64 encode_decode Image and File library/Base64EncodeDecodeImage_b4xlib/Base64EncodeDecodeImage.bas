B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
End Sub


Sub Base64StringToImage(s As String) As B4XBitmap
	Dim su As StringUtils
	Dim bytes() As Byte = su.DecodeBase64(s)
	Dim In As InputStream
	In.InitializeFromBytesArray(bytes, 0, bytes.Length)
   #if B4A or B4i
	Dim bmp As Bitmap
	bmp.Initialize2(In)
	In.Close
	Return bmp
   #else if B4J
 	Dim bmp As Image
	bmp.Initialize2(In)
	In.Close
	Return bmp
   #end if
	
End Sub


Sub Base64ImageToString(Dir As String, Filename As String) As String 
	Dim convert As StringUtils
	'Return convert.EncodeBase64(Bit.InputStreamToBytes(File.OpenInput(Dir, Filename)))
	Return convert.EncodeBase64(File.ReadBytes(Dir, Filename))
End Sub


Sub Base64AnyFileToString(Dir As String, Filename As String) As String 
	Dim convert As StringUtils
	'Return convert.EncodeBase64(Bit.InputStreamToBytes(File.OpenInput(Dir, Filename)))
	Return convert.EncodeBase64(File.ReadBytes(Dir, Filename))
End Sub

Sub Base64StringToAnyFile(s As String, Dir As String , FileName As String)
	Dim su As StringUtils
	Dim bytes() As Byte = su.DecodeBase64(s)
	Dim out As OutputStream = File.OpenOutput(Dir, FileName, False)
	out.WriteBytes(bytes, 0, bytes.Length)
	out.Close
End Sub

Sub Base64ImageToString2(Filename As B4XBitmap) As String 
	Dim convert As StringUtils
	Return convert.EncodeBase64(BitmapToBMP(Filename))
End Sub

Sub BitmapToBMP (img As B4XBitmap) As Byte()
	Dim larg As Int = img.Width
	Dim Padding1 As Int = 4 - ((larg * 3) Mod 4)
	Dim Padding1 As Int = 4 - ((30 * 3) Mod 4)
	If Padding1 = 4 Then Padding1 = 0
	Dim HeaderSize As Int = 40
	Dim offset As Int = HeaderSize + 14
	Dim size As Int = offset + img.Width * img.Height * 3 + img.Height * Padding1
	Dim raf As RandomAccessFile
	Dim buffer(size) As Byte
	raf.Initialize3(buffer, True)
	raf.WriteBytes(Array As Byte(Asc("B"), Asc("M")), 0, 2, raf.CurrentPosition)
	raf.WriteInt(size, raf.CurrentPosition)
	raf.CurrentPosition = raf.CurrentPosition + 4
	raf.WriteInt(offset, raf.CurrentPosition)
   
	raf.WriteInt(HeaderSize, raf.CurrentPosition)
	raf.WriteInt(img.Width, raf.CurrentPosition)
	raf.WriteInt(img.Height, raf.CurrentPosition)
	raf.WriteShort(1, raf.CurrentPosition)
	raf.WriteShort(24, raf.CurrentPosition)
	raf.WriteInt(0, raf.CurrentPosition)
	raf.WriteInt(0, raf.CurrentPosition)
	raf.WriteInt(0, raf.CurrentPosition)
	raf.WriteInt(0, raf.CurrentPosition)
	raf.WriteInt(0, raf.CurrentPosition)
	raf.WriteInt(0, raf.CurrentPosition)
	Dim bc As BitmapCreator
	bc.Initialize(img.Width, img.Height)
	bc.CopyPixelsFromBitmap(img)
	Dim a As ARGBColor
	For y = bc.mHeight - 1 To 0 Step -1
		For x = 0 To bc.mWidth - 1
			bc.GetARGB(x, y, a)
			raf.WriteByte(a.b, raf.CurrentPosition)
			raf.WriteByte(a.g, raf.CurrentPosition)
			raf.WriteByte(a.r, raf.CurrentPosition)
		Next
		For i = 0 To Padding1 - 1
			raf.WriteByte(0, raf.CurrentPosition)
		Next
	Next
	raf.Close
	Return buffer
End Sub


Sub ValidBase64(text As String) As Boolean
	If Regex.IsMatch("^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$", text.Trim) And text.Length > 3  Then
		Return True
	Else
		Return False
	End If
End Sub