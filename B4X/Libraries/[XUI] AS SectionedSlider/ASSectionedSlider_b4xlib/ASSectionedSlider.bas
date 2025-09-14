B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
#End If

#DesignerProperty: Key: Sections, DisplayName: Sections, FieldType: Int, DefaultValue: 10, MinRange: 2

#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF000000
#DesignerProperty: Key: SelectedSectionColor, DisplayName: Selected Section Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: DividerColor, DisplayName: Divider Color, FieldType: Color, DefaultValue: 0xFFA9A9A9

#DesignerProperty: Key: DividerHeight, DisplayName: Divider Height, FieldType: Int, DefaultValue: 2, MinRange: 0
#DesignerProperty: Key: Round, DisplayName: Round, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: CornerRadius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 20, MinRange: 0

#Event: ValueChanged(Section as Int)
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private mSelectedSection As Int = 0
	Private mSections As Int
	Private mVertical As Boolean
	Private mDividerHeight As Float
	Private mBackgroundColor As Int
	Private mSelectedSectionColor As Int
	Private mDividerColor As Int
	
	Private mRound As Boolean
	Private mCornerRadius As Float
	
	Private cvs As B4XCanvas
	Private TouchPanel As B4XView
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
	mBackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	mSelectedSectionColor = xui.PaintOrColorToColor(Props.Get("SelectedSectionColor"))
	mDividerColor = xui.PaintOrColorToColor(Props.Get("DividerColor"))
	mDividerHeight = Props.Get("DividerHeight")
	mSections = Props.Get("Sections")
	mRound = Props.Get("Round")
	mCornerRadius = Props.Get("CornerRadius")
	
	mBase.Color = xui.Color_Transparent'mBackgroundColor
	
	TouchPanel = xui.CreatePanel("TouchPanel")
	mBase.AddView(TouchPanel, 0, 0, mBase.Width, mBase.Height)
	cvs.Initialize(TouchPanel)
	#If B4A
	Base_Resize(mBase.Width, mBase.Height)
	#End If
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	cvs.Resize(Width, Height)
	TouchPanel.SetLayoutAnimated(0,0,0, Width, Height)
	mVertical = mBase.Height > mBase.Width
	Update
	SetCircleClip(mBase,IIf(mRound = True,IIf(mVertical = True,Width/2,Height/2),mCornerRadius))
	
End Sub

'Redraws the control
Public Sub Update
	cvs.ClearRect(cvs.TargetRect)
	
	Dim xRect As B4XRect

	xRect.Initialize(0,0,mBase.Width,mBase.Height)
	cvs.DrawRect(xRect,mBackgroundColor,True,0)

	If mVertical = True Then	
		Dim CurrentSectionHeight As Float = mBase.Height - (mBase.Height/mSections)*mSelectedSection
		xRect.Initialize(0,CurrentSectionHeight,mBase.Width,mBase.Height)
	Else
		cvs.DrawLine(0,0,mBase.Width,0,mBackgroundColor,mBase.Height)
		Dim CurrentSectionWidth As Float = (mBase.Width/mSections)*mSelectedSection
		xRect.Initialize(0,0,CurrentSectionWidth,mBase.Height)
	End If
	cvs.DrawRect(xRect,mSelectedSectionColor,True,0)
	
	If mVertical = True Then
		For i = 0 To (mSections -1) -1
			If (i +1) <> mSelectedSection Then
				cvs.DrawLine(0,mBase.Height - (mBase.Height/mSections)*(i+1) - mDividerHeight/2,mBase.Width,mBase.Height - (mBase.Height/mSections)*(i+1) - mDividerHeight/2,mDividerColor,mDividerHeight)
			End If
		Next
	Else
		For i = 0 To (mSections -1) -1
			If (i +1) <> mSelectedSection Then
				cvs.DrawLine((mBase.Width/mSections)*(i+1) - mDividerHeight/2,0,(mBase.Width/mSections)*(i+1) - mDividerHeight/2,mBase.Height,mDividerColor,mDividerHeight)
			End If
		Next
	End If
	
	cvs.Invalidate
	
End Sub


Private Sub TouchPanel_Touch (Action As Int, X As Float, Y As Float)
	If Action = TouchPanel.TOUCH_ACTION_DOWN Then
		SetValueBasedOnTouch(X, Y)
	Else If Action = TouchPanel.TOUCH_ACTION_MOVE Then
			SetValueBasedOnTouch(x, Y)
	Else If Action = TouchPanel.TOUCH_ACTION_UP Then
	End If
	If Action <> TouchPanel.TOUCH_ACTION_MOVE_NOTOUCH Then Update
End Sub

Private Sub SetValueBasedOnTouch(x As Int, y As Int)
	Dim LegacyValue As Int = mSelectedSection
	If mVertical = True Then
		mSelectedSection = (mBase.Height-y)/(mBase.Height/mSections) +1
	Else
		mSelectedSection = x/(mBase.Width/mSections) +1
	End If
	If LegacyValue <> mSelectedSection Then ValueChanged(mSelectedSection)
End Sub

Private Sub ValueChanged(Section As Int)
	If xui.SubExists(mCallBack, mEventName & "_ValueChanged", 1) Then
		CallSubDelayed2(mCallBack, mEventName & "_ValueChanged", Section)
	End If
End Sub

Public Sub setSelectedSection(Section As Int)
	mSelectedSection = Section
	Update
End Sub

Public Sub getSelectedSection As Int
	Return mSelectedSection
End Sub

Public Sub setSections(SectionCount As Int)
	mSections = SectionCount
	Update
End Sub

Public Sub getSections As Int
	Return mSections
End Sub

Public Sub setDividerHeight(Height As Float)
	mDividerHeight = Height
	Update
End Sub

Public Sub getDividerHeight As Float
	Return mDividerHeight
End Sub

Public Sub setBackgroundColor(Color As Int)
	mBackgroundColor = Color
	mBase.Color = Color
End Sub

Public Sub getBackgroundColor As Int
	Return mBackgroundColor
End Sub

Public Sub setSelectedSectionColor(Color As Int)
	mSelectedSectionColor = Color
	Update
End Sub

Public Sub getSelectedSectionColor As Int
	Return mSelectedSectionColor
End Sub

Public Sub setDividerColor(Color As Int)
	mDividerColor = Color
	Update
End Sub

Public Sub getDividerColor As Int
	Return mDividerColor
End Sub

Public Sub setCornerRadius(Radius As Float)
	mCornerRadius = Radius
	SetCircleClip(mBase,Radius)
End Sub

Public Sub getCornerRadius As Float
	Return mCornerRadius
End Sub

Private Sub SetCircleClip (pnl As B4XView,radius As Float)'ignore
#if B4J
Dim jo As JavaObject = pnl
Dim shape As JavaObject
Dim cx As Double = pnl.Width
Dim cy As Double = pnl.Height
shape.InitializeNewInstance("javafx.scene.shape.Rectangle", Array(cx, cy))
If radius > 0 Then
	Dim d As Double = radius
	shape.RunMethod("setArcHeight", Array(d))
	shape.RunMethod("setArcWidth", Array(d))
End If
jo.RunMethod("setClip", Array(shape))
#else if B4A
	Dim jo As JavaObject = pnl
	jo.RunMethod("setClipToOutline", Array(True))
	pnl.SetColorAndBorder(pnl.Color,0,0,radius)
	#Else If B4I
	mBase.SetColorAndBorder(mBackgroundColor,0,0,IIf(mRound = True,IIf(mVertical = True,mBase.Width/2,mBase.Height/2),mCornerRadius))
'	Dim NaObj As NativeObject = pnl
'	Dim BorderWidth As Float = NaObj.GetField("layer").GetField("borderWidth").AsNumber
'	' *** Get border color ***
'	Dim noMe As NativeObject = Me
'	Dim BorderUIColor As Int = noMe.UIColorToColor (noMe.RunMethod ("borderColor:", Array (pnl)))
'	pnl.SetColorAndBorder(pnl.Color,BorderWidth,BorderUIColor,radius)
#end if
End Sub