B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13
@EndOfDesignText@
'Custom View class 
'Author Jerryk
'version 1.31

#DesignerProperty: Key: PreferHeight, DisplayName: PreferHeight, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: MaxSize, DisplayName: MaxSize, FieldType: Int, DefaultValue: 0,  MaxRange: 80, Description: Maximum font size. 0 - no limit
#DesignerProperty: Key: SingleLine, DisplayName: SingleLine, FieldType: Boolean, DefaultValue: False

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As Panel
	Public Tag As Object
	
	Private cvs As Canvas
	Private mLbl As Label
	Private su As StringUtils
	Private xui As XUI
	Private mSingleLine As Boolean
	Private mMaxSize As Int
	Private mPreferHeight As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (dBase As Panel, Lbl As Label, Props As Map)
	mBase = dBase
	Tag = mBase.Tag
	mBase.Tag = Me
	Dim bmp As Bitmap
	bmp.InitializeMutable(1,1) 'ignore
	cvs.Initialize2(bmp)

	mLbl = Lbl
	mBase.AddView(mLbl, 0, 0, mBase.Width, mBase.Height)
	mPreferHeight = Props.GetDefault("PreferHeight", False)
	mMaxSize = Props.GetDefault("MaxSize", 0)
	mSingleLine = Props.GetDefault("SingleLine", False)
	mLbl.SingleLine = mSingleLine
	
	Dim pads() As Int = mLbl.Padding
	Dim cd As ColorDrawable
	Dim bor As Int
	If mBase.Background <> Null And GetType(mBase.Background) = "anywheresoftware.b4a.objects.drawable.ColorDrawable$GradientDrawableWithCorners" Then
		cd = mBase.Background
		Dim jo As JavaObject = cd
		bor = jo.GetField("borderWidth")
	Else	
		bor = 0
	End If

	mLbl.Padding = Array As Int(pads(0) + bor, pads(1)+ bor, pads(2)+ bor, pads(3)+ bor)
	Dim jo As JavaObject = mLbl
	jo.RunMethod("setIncludeFontPadding", Array(False))
	setText(mLbl.Text)
End Sub

Public Sub GetBase As Panel
	Return mBase
End Sub

Public Sub setText(value As Object)
	mLbl.Text = value
	Dim multipleLines As Boolean = mLbl.Text.Contains(CRLF)
	If mSingleLine And multipleLines Then
		Dim s As String = value
		mLbl.Text = s.Replace(Chr(10), "").Replace(Chr(13), " ")
		multipleLines = False
	End If
	Dim size As Float
	For size = 2 To 80
		If CheckSize(size, multipleLines) Then Exit
	Next
	size = size - 0.5
	If CheckSize(size, multipleLines) Then 
		size = size - 0.5
	End If
	mLbl.TextSize = size
	If mMaxSize > 0 And mLbl.TextSize > mMaxSize Then
		mLbl.TextSize = mMaxSize
	End If
End Sub

'returns True If the size Is too large
Private Sub CheckSize(size As Float, MultipleLines As Boolean) As Boolean
	Dim excl_width, excl_hight As Int
	
	excl_width = mLbl.Padding(0) + mLbl.Padding(2)
	excl_hight = mLbl.Padding(1) + mLbl.Padding(3)

	mLbl.TextSize = size
	If MultipleLines Or mPreferHeight Then
		Return su.MeasureMultilineTextHeight(mLbl, mLbl.Text) > mLbl.Height - excl_hight
	Else
		Return cvs.MeasureStringWidth(mLbl.Text, mLbl.Typeface, size) > mLbl.Width - excl_width Or _
			su.MeasureMultilineTextHeight(mLbl, mLbl.Text) > mLbl.Height - excl_hight
	End If
End Sub

Public Sub getText As Object
	Return mLbl.Text
End Sub

Public Sub Base As Label
	Return mLbl
End Sub

Public Sub setSingleLine(value As Object)
	mSingleLine = value
	mLbl.SingleLine = value
End Sub

Public Sub setMaxSize(value As Object)
	mMaxSize = value
End Sub

Public Sub getMaxSize As Object
	Return mMaxSize
End Sub






