B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Public ToDir, ToFile As String
	Dim XUI As XUI
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private lvFiles As ListView
	Private TravPic As B4XImageView
	Private TravPicPnlForClick As B4XView
	Private TravPicPnl As B4XView
	Private WinDir As String
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("LayoutFiles")

End Sub
Sub Loadfiles(filelist As List)
	lvFiles.Clear
	If filelist.IsInitialized And filelist.Size > 0 Then
		For i=0 To filelist.Size-1
			Dim f As SMBFile = filelist.Get(i)
			'FILE CanonicalPath = smb://192.168.192.168/GeoTIFs/koeln/ (0)
			Log($"FILE CanonicalPath = ${f.CanonicalPath} (${f.length})"$)
			lvFiles.AddTwoLines2(f.Name, f.CanonicalPath,f)
		Next
	End If
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


Sub lvFiles_ItemClick (Position As Int, Value As Object)

	Log(Value)
	TravPicPnl.Visible = True
'	Dim credentials As SMBCred
	Main.credentials.Share = Value
	ToDir = File.DirInternal
	ToFile = Value.As(String).SubString(Value.As(String).LastIndexOf("/") + 1)
	WinDir = Value.As(String).SubString2(0, Value.As(String).LastIndexOf("/") + 1)  'MAKE SUER YOU INCLUDE THE /
	Log(WinDir)
	Log(ToDir)
	Log(ToFile)
'	MsgboxAsync(File.Exists(ToDir, ToFile), "File Exists")
	Starter.OP = "CopyHere"
	CallSub2(Starter, "SMBInit", Main.credentials)
	Sleep(500)
	
'	MsgboxAsync(File.Exists(ToDir, ToFile), "File Exists")
'    Dim Buffer() As Byte  = TMap.Get("Picture")
'    Dim InputStream1 As InputStream
'    InputStream1.InitializeFromBytesArray(Buffer, 0, Buffer.Length)
'    Dim Bmp As Bitmap
'    Bmp.Initialize2(InputStream1)
'    InputStream1.Close

End Sub

Private Sub TravPicPnlForClick_Click
	TravPicPnl.Visible = False
End Sub

Sub SetImg(BMP As Bitmap)
	TravPic.Bitmap = BMP
End Sub


Private Sub CopyToWindows_Click

Starter.OP = "CopyThere"
Dim Out As OutputStream
Out = File.OpenOutput(XUI.DefaultFolder, "Test.png", False)
TravPic.Bitmap.WriteToStream(Out, 100, "PNG")
Out.Close
Main.credentials.Share = WinDir

CallSub2(Starter, "SMBInit", Main.credentials)
Sleep(500)
	
End Sub


