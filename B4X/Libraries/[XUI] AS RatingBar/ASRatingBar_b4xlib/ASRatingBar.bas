B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'Author: Alexander Stolte
'Version: 1.03

#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-Add getBase
	-Add public variable Tag
V1.02
	-B4X Example
	-Custom Props explained
V1.03
	-Add set Enabled - enabled or disabled the touch gesture
V1.04
	-Fix names in designer
	-Add set MaximumRating
V1.05
	-Add TouchStateChanged
V1.06
	-Better click handling
#End If

#DesignerProperty: Key: MaxRating, DisplayName: MaxRating, FieldType: Int, DefaultValue: 10, MinRange: 1
#DesignerProperty: Key: CurrentRating, DisplayName: CurrentRating, FieldType: Int, DefaultValue: 0, MinRange: 0

#Event: RatingChange(rating as int)
#Event: RatingChanged(rating as int)
#Event: TouchStateChanged (Pressed As Boolean)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private xBackgroundView As B4XView
	Private xbmp_image ,xbmp_grey_image As B4XBitmap
	Private current_ranking As Int
	Private Pressed As Boolean
	
	Private g_enabled As Boolean = True
	
	Private g_MaxRating As Int
	Public Tag As Object
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mBase.Tag = Me
	ini_props(Props)
	xBackgroundView = xui.CreatePanel("xBackgroundView")
	mBase.AddView(xBackgroundView,0,0,mBase.Width,mBase.Height)
	AddRanking
	#If B4A
	Private objPages As Reflector
	objPages.Target = xBackgroundView
	objPages.SetOnTouchListener("xBackgroundView_Touch")
	#End If

	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If

End Sub
'gets mBase
Public Sub getBase As B4XView
	Return mBase
End Sub

Private Sub ini_props(props As Map)
	g_MaxRating = props.Get("MaxRating")
	current_ranking = props.Get("CurrentRating")
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
	xBackgroundView.SetLayoutAnimated(0,0,0,Width,Height)
	
	If xbmp_image.IsInitialized = True Then
		
		Dim tmp_bmp_width As Float = xbmp_image.Resize(Width/g_MaxRating,Height,True).Width
		Dim tmp_bmp_height As Float = xbmp_image.Resize(Width/g_MaxRating,Height,True).Height
		
	For i = 0 To g_MaxRating -1
		Dim ximg_image As B4XView = xBackgroundView.GetView(i)
			ximg_image.SetLayoutAnimated(0,((Width/g_MaxRating) * i) + Width/g_MaxRating/2 - tmp_bmp_width/2,Height/2 - tmp_bmp_height/2,tmp_bmp_width,tmp_bmp_height)
	Next
	End If
	
	BuildRanking
  
End Sub

#Region InternFunctions

Private Sub AddRanking
	xBackgroundView.RemoveAllViews
	For i = 0 To g_MaxRating -1
		Dim ximg_image As B4XView = CreateImageView("xiv_Rank")
		xBackgroundView.AddView(ximg_image,0,0,0,0)
	Next
	Base_Resize(mBase.Width,mBase.Height)
End Sub

Private Sub BuildRanking
	
	If xbmp_image.IsInitialized = True Then
		
		Dim tmp_bmp_normal As B4XBitmap = xbmp_image.Resize(mBase.Width/g_MaxRating,mBase.Height,True)
		Dim tmp_bmp_greyed As B4XBitmap = xbmp_grey_image.Resize(mBase.Width/g_MaxRating,mBase.Height,True)
		
		For i = 0 To g_MaxRating -1
			Dim ximg_image As B4XView = xBackgroundView.GetView(i)
			If (i +1) <= current_ranking Then
				ximg_image.SetBitmap(tmp_bmp_normal)
			Else
				ximg_image.SetBitmap(tmp_bmp_greyed)
			End If
		Next
	End If
	
End Sub

Private Sub CheckRanting(x As Float)
	
	For i = 0 To g_MaxRating -1
		If x >= (mBase.Width/g_MaxRating)*i And x <= ((mBase.width/g_MaxRating) * i) + mBase.Width/g_MaxRating Then
			If current_ranking <> i +1 Then
				current_ranking = i	+1
				RatingChange(i +1)
				BuildRanking
			End If
			Return
		End If
	Next
	
	If current_ranking <> g_MaxRating And  current_ranking <> 0 Then
		current_ranking = 0
		RatingChange(0)
		BuildRanking
	End If
End Sub

#End Region

#Region Properties

'gets and sets the rating
Public Sub setCurrentRating(Rating As Int)	
	current_ranking = Rating
	BuildRanking	
End Sub

Public Sub getCurrentRating As Int
	Return current_ranking
End Sub

Public Sub setMaximumRating(Rating As Int)
	g_MaxRating = Rating
	AddRanking
	BuildRanking
End Sub

Public Sub SetImages(active_image As B4XBitmap,inactive_image As B4XBitmap)
	xbmp_image = active_image
	xbmp_grey_image = inactive_image
	Base_Resize(mBase.Width,mBase.Height)
End Sub

'gets the active image
Public Sub getActiveImage As B4XBitmap
	Return xbmp_image
End Sub

'gets the inactive image
Public Sub getInactiveImage As B4XBitmap
	Return xbmp_grey_image
End Sub

Public Sub setEnabled(enable As Boolean)
	g_enabled = enable
End Sub

#End Region

#Region ViewEvents

Private Sub xiv_Rank_Click
	Dim xiv_Rank As B4XView = Sender
	CheckRanting(xiv_Rank.Left + xiv_Rank.Width/2)
End Sub

#If B4A
Private Sub xBackgroundView_Touch(ViewTag As Object, Action As Int, X As Float, y As Float, MotionEvent As Object) As Boolean
#Else
Private Sub xBackgroundView_Touch (Action As Int, X As Float, Y As Float)
#End IF
	If g_enabled = False Then Return False'ignore
	If Action = xBackgroundView.TOUCH_ACTION_DOWN Then
		Pressed = True
		RaiseTouchStateEvent
		CheckRanting(X)
		
	Else If Action = xBackgroundView.TOUCH_ACTION_MOVE Then
		
		CheckRanting(X)
		
	Else If Action = xBackgroundView.TOUCH_ACTION_UP Then
		Pressed = False
		CheckRanting(X)
		RatingChanged
		RaiseTouchStateEvent
	End If
	
	
	#If B4A
	Return True
	#End If
	
End Sub

#End Region

#Region Events

Private Sub RatingChange (rating As Int)
	If xui.SubExists(mCallBack, mEventName & "_RatingChange", 1) Then
		CallSub2(mCallBack, mEventName & "_RatingChange",rating)
	End If
End Sub

Private Sub RatingChanged
	If xui.SubExists(mCallBack, mEventName & "_RatingChanged", 1) Then
		CallSub2(mCallBack, mEventName & "_RatingChanged",current_ranking)
	End If
End Sub

Private Sub RaiseTouchStateEvent
	If xui.SubExists(mCallBack, mEventName & "_TouchStateChanged", 1) Then
		CallSubDelayed2(mCallBack, mEventName & "_TouchStateChanged", Pressed)
	End If
End Sub


#End Region

#Region Functions
'https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250
Public Sub FontToBitmap (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
	Dim xui As XUI
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(p)
	Dim fnt As B4XFont
	If IsMaterialIcons Then fnt = xui.CreateMaterialIcons(FontSize) Else fnt = xui.CreateFontAwesome(FontSize)
	Dim r As B4XRect = cvs1.MeasureText(text, fnt)
	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
	cvs1.DrawText(text, cvs1.TargetRect.CenterX, BaseLine, fnt, color, "CENTER")
	Dim b As B4XBitmap = cvs1.CreateBitmap
	cvs1.Release
	Return b
End Sub

Private Sub CreateImageView(EventName As String) As B4XView
	Dim tmp_iv As ImageView
	tmp_iv.Initialize(EventName)
	Return tmp_iv
End Sub

#End Region
