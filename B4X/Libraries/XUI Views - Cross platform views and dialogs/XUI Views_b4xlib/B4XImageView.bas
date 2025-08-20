B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
#DesignerProperty: Key: ResizeMode, DisplayName: Resize Mode, FieldType: String, List: FIT|FILL|FILL_NO_DISTORTIONS|FILL_WIDTH|FILL_HEIGHT|NONE, DefaultValue: FIT
#DesignerProperty: Key: Round, DisplayName: Round, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: CornersRadius, DisplayName: Corners Radius, FieldType: Int, DefaultValue: 0
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFAAAAAA
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private iv As B4XView
	Private mResizeMode As String
	Private mRound As Boolean
	Private mBitmap As B4XBitmap
	Public mBackgroundColor As Int
	Private mCornersRadius As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	Dim iiv As ImageView
	iiv.Initialize("")
	iv = iiv
	mRound =Props.Get("Round")
	mResizeMode = Props.Get("ResizeMode")
	mBackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	mCornersRadius = DipToCurrent(Props.GetDefault("CornersRadius", 0))
	mBase.AddView(iv, 0, 0, mBase.Width, mBase.Height)
	Update
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	Update
End Sub

'Gets or sets whether to make the rounded image.
Public Sub getRoundedImage As Boolean
	Return mRound
End Sub

Public Sub setRoundedImage (b As Boolean)
	If b = mRound Then Return
	mRound = b
	UpdateClip
End Sub

'Gets or sets whether to make the image rounded.
Public Sub getCornersRadius As Int
	Return mCornersRadius
End Sub

Public Sub setCornersRadius (i As Int)
	mCornersRadius = i
	UpdateClip
End Sub

'Gets or sets the resize mode. One of the following values: FIT, FILL, FILL_NO_DISTORTIONS, FILL_WIDTH, FILL_HEIGHT, NONE
'All modes except of FILL respect the image ratio. In most cases it is better not to use FILL.
Public Sub getResizeMode As String
	Return mResizeMode
End Sub

Public Sub setResizeMode(s As String)
	If s = mResizeMode Then Return
	mResizeMode = s
	Update
End Sub

Public Sub Update
	If mBitmap.IsInitialized = False Then Return
	UpdateClip
	Dim ImageViewWidth, ImageViewHeight As Float
	Dim bmpRatio As Float = mBitmap.Width / mBitmap.Height
	Select mResizeMode
		Case "FILL"
			ImageViewWidth = mBase.Width
			ImageViewHeight = mBase.Height
		Case "FIT"
			Dim r As Float = Min(mBase.Width / mBitmap.Width, mBase.Height / mBitmap.Height)
			ImageViewWidth = mBitmap.Width * r
			ImageViewHeight = mBitmap.Height * r		
		Case "FILL_WIDTH"
			ImageViewWidth = mBase.Width
			ImageViewHeight = ImageViewWidth / bmpRatio
		Case "FILL_HEIGHT"
			ImageViewHeight = mBase.Height
			ImageViewWidth = ImageViewHeight * bmpRatio
		Case "FILL_NO_DISTORTIONS"
			Dim r As Float = Max(mBase.Width / mBitmap.Width, mBase.Height / mBitmap.Height)
			ImageViewWidth = mBitmap.Width * r
			ImageViewHeight = mBitmap.Height * r
		Case "NONE"
			ImageViewWidth = mBitmap.Width
			ImageViewHeight = mBitmap.Height
		Case Else
			Log("Invalid resize mode: "  & mResizeMode)
	End Select
	iv.SetLayoutAnimated(0, Round(mBase.Width / 2 - ImageViewWidth / 2), Round(mBase.Height / 2 - ImageViewHeight / 2), Round(ImageViewWidth), Round(ImageViewHeight))
End Sub

'Loads a bitmap. It uses LoadBitmapSample in B4A to avoid loading larger than necessary images.
Public Sub Load (Dir As String, FileName As String)
	#if B4A
	setBitmap(LoadBitmapSample(Dir, FileName, mBase.Width, mBase.Height))
	#Else
	setBitmap(xui.LoadBitmap(Dir, FileName))
	#End If
End Sub

'Removes the bitmap.
Public Sub Clear
	mBitmap = Null
	iv.SetBitmap(Null)
End Sub

Public Sub setBitmap(Bmp As B4XBitmap)
	mBitmap = Bmp
	XUIViewsUtils.SetBitmapAndFill(iv, Bmp)
	Update
End Sub

Public Sub getBitmap As B4XBitmap
	Return mBitmap
End Sub


Private Sub UpdateClip
	If mRound Then
		mBase.SetColorAndBorder(mBackgroundColor, 0, 0, Min(mBase.Width / 2, mBase.Height / 2))
	Else
		mBase.SetColorAndBorder(mBackgroundColor, 0, 0, mCornersRadius)
	End If
#if B4J
	Dim jo As JavaObject = mBase
	Dim shape As JavaObject
	If mRound Then
		Dim radius As Double = Min(mBase.Width / 2, mBase.Height / 2)
		Dim cx As Double = mBase.Width / 2
		Dim cy As Double = mBase.Height / 2
		shape.InitializeNewInstance("javafx.scene.shape.Circle", Array(cx, cy, radius))
	Else
		Dim cx As Double = mBase.Width
		Dim cy As Double = mBase.Height
		shape.InitializeNewInstance("javafx.scene.shape.Rectangle", Array(cx, cy))
		If mCornersRadius > 0 Then
			Dim d As Double = mCornersRadius
			shape.RunMethod("setArcHeight", Array(d))
			shape.RunMethod("setArcWidth", Array(d))
		End If
	End If
	jo.RunMethod("setClip", Array(shape))
#else if B4A
	Dim jo As JavaObject = mBase
	jo.RunMethod("setClipToOutline", Array(mRound Or mCornersRadius > 0))
#end if
End Sub

