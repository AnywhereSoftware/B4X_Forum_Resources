B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	#if B4J
	Private iv As ImageView
	#Else If B4A
	Private iv As ImageView
	Public GifDrawable As JavaObject
	#Else If B4i
	Private AnimatedImageView As B4XView
	#End If
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	#if B4J
	iv.Initialize("")
	mBase.AddView(iv, 0, 0, mBase.Width, mBase.Height)
	#Else If B4i
	Dim no As NativeObject
	AnimatedImageView = no.Initialize("FLAnimatedImageView").RunMethod("new", Null)
	mBase.AddView(AnimatedImageView, 0, 0, mBase.Width, mBase.Height)
	Dim iv As ImageView = AnimatedImageView
	iv.ContentMode = iv.MODE_FIT
	#Else If B4A
	iv.Initialize("")
	mBase.AddView(iv, 0, 0, mBase.Width, mBase.Height)
	#End If
End Sub

Public Sub SetGif(Dir As String, FileName As String)
	#if B4i
	SetGif2(File.ReadBytes(Dir, FileName))
	#Else if B4J
	SetBitmap(xui.LoadBitmap(Dir, FileName))
	#Else is B4A
	If Dir = File.DirAssets Then
		SetGif2(File.ReadBytes(Dir, FileName))
	Else
		SetBitmap(File.Combine(Dir, FileName))
	End If
	#End If
End Sub

Public Sub SetGif2 (Data() As Byte)
	#if B4i
	Dim image As NativeObject
	image = image.Initialize("FLAnimatedImage").RunMethod("animatedImageWithGIFData:", Array(image.ArrayToNSData(Data)))
	Dim no As NativeObject = AnimatedImageView
	no.RunMethod("setAnimatedImage:", Array(image))
	#Else if B4J
	Dim img As Image
	Dim in As InputStream
	in.InitializeFromBytesArray(Data, 0, Data.Length)
	img.Initialize2(in)
	in.Close
	SetBitmap(img)
	#Else is B4A
	SetBitmap(Data)
	#End If
End Sub

#if B4J
Private Sub SetBitmap(bmp As B4XBitmap)
	iv.SetImage(bmp)
	iv.PreserveRatio = True
	Dim bmp As B4XBitmap = iv.GetImage
	ResizeBasedOnImage(iv, bmp.Width / bmp.Height)
End Sub
#else if B4A
Private Sub SetBitmap(obj As Object)
	Dim GifDrawable As JavaObject
	GifDrawable.InitializeNewInstance("pl.droidsonroids.gif.GifDrawable", Array(obj))
	iv.Background = GifDrawable
	Dim jo As JavaObject = GifDrawable
	Dim w As Int = jo.RunMethod("getIntrinsicWidth", Null)
	Dim h As Int = jo.RunMethod("getIntrinsicHeight", Null)
	ResizeBasedOnImage(iv, w / h)
End Sub

#End If

Private Sub ResizeBasedOnImage(xiv As B4XView, BmpRatio As Float)
	Dim viewRatio As Float = mBase.Width / mBase.Height
	Dim Height, Width As Int
	If viewRatio > BmpRatio Then
		Height = mBase.Height
		Width = mBase.Height * BmpRatio
	Else
		Width = mBase.Width
		Height = mBase.Width / BmpRatio
	End If
	xiv.SetLayoutAnimated(0, mBase.Width / 2 - Width / 2, mBase.Height / 2 - Height / 2, Width, Height)
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
  	#if B4A
	iv.SetLayoutAnimated(0, 0, 0, Width, Height)
	#Else If B4J
	If iv.GetImage.IsInitialized Then
		Dim bmp As B4XBitmap = iv.GetImage
		ResizeBasedOnImage(iv, bmp.Width / bmp.Height)
	End If
	#Else If B4i
	AnimatedImageView.SetLayoutAnimated(0, 0, 0, Width, Height)
	#End If
End Sub