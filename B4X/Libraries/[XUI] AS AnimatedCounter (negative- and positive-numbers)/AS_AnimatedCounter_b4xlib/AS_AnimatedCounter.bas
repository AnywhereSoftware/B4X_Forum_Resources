B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
#If Documentation

Updates
V1.00
	-Release
V1.01
	-Some BugFixes
V1.02
	-Add ValueWithoutAnimation - set a value without the animation
V1.03
	-B4I and B4J BugFix - The number "0" was displayed too far down
V2.00
	-Breaking change - lib. renamed to AS_AnimatedCounter - need to be added again in the designer
	-Add get and set Font - Call refresh if you change something
	-Add get and set TextColor - Call refresh if you change something
	-Add Refresh - Refresh the visuals
V2.01
	-BugFixes B4J animation is now visible
#End If

#DesignerProperty: Key: Duration, DisplayName: Animation Duration, FieldType: Int, DefaultValue: 250, Description:

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private ImageViews As List
	Private mdigits As Int = 1
	Private mValue As List
	Private DigitWidth As Int
	Private mDuration As Int
	Private fade As B4XBitmap
	Private xfadeIv As B4XView
	Private number As Int
	Private line As B4XView
	Private lblTemplate As B4XView
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	ImageViews.Initialize
	mValue.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
	mBase.Tag = Me
	mBase.Color = xui.Color_Transparent
	Dim pnl As B4XView = xui.CreatePanel("") 'needed as the passed pane in B4J doesn't crop the child views
	pnl.Tag = Me
	mBase.AddView(pnl, 0, 0, 0, 0)
	'mdigits = Props.Get("Digits")
	mDuration = Props.Get("Duration")
	lblTemplate = lbl
	
	fade = CreateFadeBitmap
	
	For i = 0 To mdigits - 1
		Dim iv As ImageView
		iv.Initialize("")
		ImageViews.Add(iv)
		mBase.GetView(0).AddView(iv, 0, 0, 0, 0)
	Next
	Dim fadeIv As ImageView
	fadeIv.Initialize("")
	xfadeIv = fadeIv
	mBase.GetView(0).AddView(fadeIv, 0, 0, 0, 0)
	setValueWithoutAnimation(0)
	
	#If B4A
		Base_Resize(mBase.Width, mBase.Height)
		setValueWithoutAnimation(getValue)
	#End If
End Sub

Public Sub AddViewByCode(Parent As Object,Label As B4XView,Duration As Int,left As Int,top As Int,width As Int, height As Int)
	Dim parent2 As B4XView = Parent
	
	Dim props As Map
	props.Initialize
	props.Put("Duration",Duration)

	Dim xpnl As B4XView = xui.CreatePanel("")
	parent2.AddView(xpnl,left,top,width,height)
	
	DesignerCreateView(xpnl,Label,props)
	
End Sub

Public Sub getBaseView As B4XView
	Return mBase
End Sub

Private Sub AddNew(animated As Boolean)
	
	mdigits = mdigits +1
	
	Dim iv As ImageView
	iv.Initialize("")
	ImageViews.Add(iv)
	mBase.GetView(0).AddView(iv, 0, 0, 0, 0)
	
	Dim fadeIv As ImageView
	fadeIv.Initialize("")
	xfadeIv = fadeIv
	mBase.GetView(0).AddView(fadeIv, 0, 0, 0, 0)
	
	Values(number,animated)
	Values(getValue,animated)

End Sub

Private Sub RemoveNew(animated As Boolean)
	
	mdigits = mdigits -1
	
	Dim pnl As B4XView = mBase.GetView(0)
	
	pnl.GetView(pnl.NumberOfViews -1).RemoveViewFromParent
	pnl.GetView(pnl.NumberOfViews -1).RemoveViewFromParent
	ImageViews.RemoveAt(ImageViews.Size -1)

	Values(getValue,animated)
	
End Sub

Private Sub CreateFadeBitmap As B4XBitmap
	Dim bc As BitmapCreator
	bc.Initialize(200, 50)
	Dim r As B4XRect
	r.Initialize(0, 0, bc.mWidth, bc.mHeight / 3)
	bc.FillGradient(Array As Int(xui.Color_Transparent,xui.Color_Transparent), r, "TOP_BOTTOM")
	r.Top = bc.mHeight * 2 / 3
	r.Bottom = bc.mHeight
	bc.FillGradient(Array As Int(xui.Color_Transparent, xui.Color_Transparent), r, "BOTTOM_TOP")
	Return bc.Bitmap
End Sub


Private Sub Base_Resize (Width As Double, Height As Double)
	mBase.GetView(0).SetLayoutAnimated(0, 0, 0, Width, Height)
	xfadeIv.SetLayoutAnimated(0, 0, 0, Width, Height)
	xfadeIv.SetBitmap(fade.Resize(Width, Height, False))

	'Dim Columns As Int = mdigits
	
	DigitWidth = MeasureTextWidth("5",lblTemplate.Font)
	
	'DigitWidth = Width / Columns
	lblTemplate.Height = Height
	Dim bmp As B4XBitmap = CreateBitmap(lblTemplate)
	
	Dim left As Int = Width/2 + DigitWidth/2 * mdigits
	For i = 0 To ImageViews.Size - 1
		Dim iv As B4XView = ImageViews.Get(i)
		'from right to left
		left =  left - DigitWidth
		#If B4J
		If i >= mValue.Size Then Continue
		#End If
		iv.SetLayoutAnimated(0, left, TopFromValue(i), bmp.Width, mBase.Height * 10)
		
		iv.SetBitmap(bmp)
	
	Next
	
	If line.IsInitialized = True Then
		
		Dim iv2 As B4XView = ImageViews.Get(mdigits -1)
		line.SetTextAlignment("CENTER","RIGHT")
		line.Left = iv2.Left - line.Width - 2dip
		line.Top = mBase.Height/2 - line.Height/2
	End If
	
End Sub

Private Sub TopFromValue (Digit As Int) As Int
	Dim d As Int = mValue.Get(Digit)

	#If B4A
	If d = 0 Then Return 1
	#End If

	Return -(mBase.Height * d )
End Sub

Private Sub CreateBitmap (lbl As B4XView) As B4XBitmap
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0,  mBase.Width, mBase.Height * 10)
	
	Dim cvs As B4XCanvas
	cvs.Initialize(p)
	For i = 0 To 9
		
		Dim r As B4XRect = cvs.MeasureText(i, lbl.Font)
		Dim BaseLine As Int = mBase.Height/2 - r.Height / 2 - r.Top 

		cvs.DrawText(i, DigitWidth/2 , (mBase.Height * i ) + BaseLine, lbl.Font, lbl.TextColor, "CENTER")
		
	Next
	cvs.Invalidate
	Dim res As B4XBitmap = cvs.CreateBitmap
	cvs.Release

	Return res
End Sub

Public Sub CountAnimatedTo(speed As Int,number2 As Int)
	
	If number2 < number Then
		
		For i = number To number2 Step -1
		
			setValue(i)
		
			Sleep(speed)
		
		Next
		
		Else
			
		For i = number To number2 -1
		
			setValue(i +1)
		
			Sleep(speed)
		
		Next
		
	End If
	
End Sub

Public Sub setValueWithoutAnimation(v As Int)
	Values(v,False)
End Sub

Public Sub setValue(v As Int)
	Values(v,True)
End Sub

Private Sub Values(v As Int,animated As Boolean)
	
	If v <> number Or mValue.Size = 0 Then
	
		mValue.Clear
		number = v

		Dim digitsize As String = v
		If digitsize.Contains("-") = True Then
			v = -(v)
		End If

		'If  Not(v = 0) Then
		digitsize = v
		If digitsize.Length > ImageViews.Size Then
			AddNew(animated)
		else if digitsize.Length < ImageViews.Size Then
			RemoveNew(animated)
		End If
		'End If

		digitsize = number
	
		If digitsize.Contains("-") = True Then
		
			If line.IsInitialized = False Then
		
				line = lblTemplate
				line.Text = "-"
		
				Dim iv2 As B4XView = ImageViews.Get(mdigits -1)
	
				mBase.GetView(0).AddView(line,iv2.Left - line.Width - 2dip,mBase.Height/2 - line.Height/2, 20dip,20dip)
				line.Left = iv2.Left - line.Width - 2dip
				line.Top = mBase.Height/2 - line.Height/2
				line.Visible = True
			Else
		
				line.Visible = True
				Dim iv2 As B4XView = ImageViews.Get(mdigits -1)
				line.Left = iv2.Left - line.Width - 2dip
				line.Top = mBase.Height/2 - line.Height/2
			End If
		
		Else
		
			If line.IsInitialized = True Then
		
				line.Visible = False
		
			End If
			
		End If

		For i = 0 To mdigits - 1
			mValue.Add(v Mod 10)
			v = v / 10
			#If B4J
			If i >= ImageViews.Size Then Continue
			#End If
			Dim iv As B4XView = ImageViews.Get(i)
			Dim duration As Int = 0
			If animated = True Then
				duration = mDuration
			End If
			iv.SetLayoutAnimated(duration, iv.Left, TopFromValue(i), Max(1,iv.Width),Max(1,iv.Height))
			#If B4J
			If duration > 0 Then Sleep(duration)
			#End If
		Next
		
		Base_Resize(mBase.Width, mBase.Height)

	End If
	
End Sub

#Region Properties

Public Sub Refresh
	Base_Resize(mBase.Width,mBase.Height)
End Sub

'Call Refresh if you change something
Public Sub getFont As B4XFont
	Return lblTemplate.Font
End Sub

Public Sub setFont(xFont As B4XFont)
	lblTemplate.Font = xFont
End Sub

'Call Refresh if you change something
Public Sub getTextColor As Int
	Return lblTemplate.TextColor
End Sub

Public Sub setTextColor(TextColor As Int)
	lblTemplate.TextColor = TextColor
End Sub

Public Sub getValue As Int
	Return number	
End Sub

'current value +1
Public Sub AddOne
	setValue(number +1)
	'number = number +1
End Sub

'current value -1
Public Sub RemoveOne
	setValue(number -1)
	'number = number -1
End Sub

#End Region

Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
#If B4A
	Private bmp As Bitmap
	bmp.InitializeMutable(2dip, 2dip)
	Private cvs As Canvas
	cvs.Initialize2(bmp)
	Return cvs.MeasureStringWidth(Text, Font1.ToNativeFont, Font1.Size)
#Else If B4i
    Return Text.MeasureWidth(Font1.ToNativeFont)
#Else If B4J
    Dim jo As JavaObject
    jo.InitializeNewInstance("javafx.scene.text.Text", Array(Text))
    jo.RunMethod("setFont",Array(Font1.ToNativeFont))
    jo.RunMethod("setLineSpacing",Array(0.0))
    jo.RunMethod("setWrappingWidth",Array(0.0))
    Dim Bounds As JavaObject = jo.RunMethod("getLayoutBounds",Null)
    Return Bounds.RunMethod("getWidth",Null)
#End If
End Sub

