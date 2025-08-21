Type=Class
Version=7.01
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
'v1.20
'Custom View class 
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As Panel
	Private Const DefaultColorConstant As Int = -984833 'ignore
	Private WorkIndex As Int
	Private BDGravity As Int
	Private bitmaps As List
	Type BitmapAndDelay (bmp As Bitmap, Delay As Int)
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	mBase = Base
	mBase.Visible = False
End Sub

Public Sub SetGif (Dir As String, FileName As String)
	If Dir = File.DirAssets Then
		File.Copy(File.DirAssets, FileName, File.DirInternal, FileName)
		Dir = File.DirInternal
	End If
	Dim path As String = File.Combine(Dir, FileName)
	If Main.GifsCache.IsInitialized = False Then Main.GifsCache.Initialize
	If Main.GifsCache.ContainsKey(path) Then
		bitmaps = Main.GifsCache.Get(path)
	Else
		Dim gd As GifDecoder
		gd.Load(Dir, FileName)
		bitmaps.Initialize
		For i = 0 To gd.FrameCount - 1
			Dim bd As BitmapAndDelay
			bd.Initialize
			bd.bmp = gd.Frame(i)
			bd.Delay = gd.Delay(i)
			bitmaps.Add(bd)
		Next
		Main.GifsCache.Put(path, bitmaps)
	End If

	Dim FirstFrame As BitmapAndDelay = bitmaps.Get(0)
	Dim FirstBmp As Bitmap = FirstFrame.bmp
	If FirstBmp.Width < mBase.Width Or FirstBmp.Height < mBase.Height Then
		BDGravity = Gravity.CENTER
	Else
		BDGravity = Gravity.FILL
	End If
	
End Sub

Public Sub Start
	mBase.Visible = True
	WorkIndex = WorkIndex + 1
	ShowImpl(WorkIndex)
End Sub

Public Sub Stop
	mBase.Visible = False
	WorkIndex = WorkIndex + 1
End Sub

Public Sub CallFromResume
	If mBase.Visible Then Start
End Sub

Private Sub ShowImpl(MyWorkIndex As Int)
	Dim FrameIndex As Int = 0
	Do While MyWorkIndex = WorkIndex
		FrameIndex = (FrameIndex + 1) Mod bitmaps.Size
		Dim bdrawable As BitmapDrawable
		Dim bd As BitmapAndDelay = bitmaps.Get(FrameIndex)
		bdrawable.Initialize(bd.bmp)
		bdrawable.Gravity = BDGravity
		mBase.Background = bdrawable
		Sleep(bd.Delay)
	Loop
End Sub

Public Sub GetBase As Panel
	Return mBase
End Sub