B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@

'Click to build b4xlib: ide://run?file=%JAVABIN%\jar.exe&WorkingDirectory=..&Args=-cMf&Args=LibraryNameHere.b4xlib&&Args=..&Args=*.bas&Args=manifest.txt

#DesignerProperty: Key: AnimationDuration, DisplayName: Animation Duration, FieldType: Float, DefaultValue: 150, Description: Duration of the button's animation
#DesignerProperty: Key: AnimationGravity, DisplayName: Animation Gravity, FieldType: String, DefaultValue: Custom, List:From Left & Right|From Top & Bottom|From Both|Custom, Description: Type of the button's animation
#DesignerProperty: Key: CustomGravity, DisplayName: Custom Gravity, FieldType: String, DefaultValue: 4dip;1dip;4dip;1dip, Description: To use this method you should set "Animation Gravity" to "Custom"

#DesignerProperty: Key: OnPressedTextSise, DisplayName: OnPressed TextSise, FieldType: Int, DefaultValue: 13, Description: The textsize of the button when pressed

#Event: Click

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	
	Public mBase As B4XView
	Public mLbl As B4XView
	Private mPnlClick As B4XView
	
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Public Animation_Duration As Float
	Public Animation_Gravity As String
	Public Animation_Gravitys() As Float
	
	Public OnPressedTextSise As Float
	Private NormalTextSise As Float
	
	Public Duration_Slow As Float = 250
	Public Duration_Normal As Float = 150
	Public Duration_Fast As Float = 50
	
	Public Gravity_LeftAndRight As String = "From Left & Right"
	Public Gravity_TopAndBottom As String = "From Top & Bottom"
	Public Gravity_Both As String = "From Both"
	
	Public Enabled As Boolean = True
	
	Private Left1 As String
	Private Top1 As String
	Private Width1 As String
	Private Height1 As String
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
	mLbl = Lbl
	
	mLbl.Color = 0x00FFFFFF
	
	mPnlClick = xui.CreatePanel("mPnlClick")
	mPnlClick.Color = 0x00FFFFFF
	
	'Add Views
	mBase.AddView(mLbl,0,0,mBase.Width,mBase.Height)
	mBase.AddView(mPnlClick,0,0,mBase.Width,mBase.Height)
	
	'Get Values From Designer
	Animation_Duration = Props.Get("AnimationDuration")

	'Get Values From Designer
	Dim left As String = Regex.Split(";",Props.Get("CustomGravity"))(0)
	Dim top As String = Regex.Split(";",Props.Get("CustomGravity"))(1)
	Dim right As String = Regex.Split(";",Props.Get("CustomGravity"))(2)
	Dim bottom As String = Regex.Split(";",Props.Get("CustomGravity"))(3)
	
	'convert dip values
	If left.Contains("dip") Then
		left = DipToCurrent(left.Replace("dip",""))
	End If
	
	If top.Contains("dip") Then
		top = DipToCurrent(top.Replace("dip",""))
	End If
	
	If right.Contains("dip") Then
		right = DipToCurrent(right.Replace("dip",""))
	End If
	
	If bottom.Contains("dip") Then
		bottom = DipToCurrent(bottom.Replace("dip",""))
	End If
	
	'change % values to int values
	If left.Contains("%") Or top.Contains("%") Or right.Contains("%") Or bottom.Contains("%") Then
		Log("If you want to use % set the gravity values by code.")
		
		left = left.Replace("%x","").Replace("%X","").Replace("%y","").Replace("%Y","")
		top = top.Replace("%x","").Replace("%X","").Replace("%y","").Replace("%Y","")
		right = right.Replace("%x","").Replace("%X","").Replace("%y","").Replace("%Y","")
		bottom = bottom.Replace("%x","").Replace("%X","").Replace("%y","").Replace("%Y","")
		
	End If
	
	Animation_Gravitys = Array As Float(left,top,right,bottom)
	
	'Get Values From Designer
	Animation_Gravity = Props.Get("AnimationGravity")
	
	'Get Values From Designer
	OnPressedTextSise = Props.Get("OnPressedTextSise")
	
	NormalTextSise = mLbl.TextSize
	
	Left1  = mBase.Left
	Top1 = mBase.Top
	Width1 = mBase.Width
	Height1 = mBase.Height
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	mLbl.SetLayoutAnimated(0, 0, 0, Width, Height)
	mPnlClick.SetLayoutAnimated(0, 0, 0, Width, Height)
End Sub

'Touch Event
Private Sub mPnlClick_Touch (Action As Int, X As Float, Y As Float)
	Dim Inside As Boolean = x > 0 And x < mBase.Width And y > 0 And y < mBase.Height
	If Enabled = False Then Return
	
	Dim Left2 As String = mBase.Left
	Dim Top2 As String = mBase.Top
	Dim Width2 As String = mBase.Width
	Dim Height2 As String = mBase.Height
	
	Select Action
		Case 0 'Down
			If Animation_Gravity = Gravity_LeftAndRight Then
				Left2 = Left2 + 10dip
				Width2 = Width2 - 20dip
				
			else if Animation_Gravity = Gravity_TopAndBottom Then
				Top2 = Top2 + 10dip
				Height2 = Height2 - 20dip
				
			else if Animation_Gravity = Gravity_Both Then
				Left2 = Left2 + 10dip
				Top2 = Top2 + 10dip
				Width2 = Width2 - 20dip
				Height2 = Height2 - 20dip
				
			Else if Animation_Gravity = "Custom" Then
				Left2 = mBase.Left + Animation_Gravitys(0)
				Top2 = mBase.Top + Animation_Gravitys(1)
				Width2 = mBase.Width - (2*Animation_Gravitys(2))
				Height2 = mBase.Height - (2*Animation_Gravitys(3))
				
			End If
			
			mBase.SetLayoutAnimated(Animation_Duration,Left2,Top2,Width2,Height2)
			mLbl.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Height)
			mPnlClick.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Height)
			mLbl.TextSize = OnPressedTextSise
			
		Case 1 'Up
			
			mBase.SetLayoutAnimated(Animation_Duration,Left1,Top1,Width1,Height1)
			
			mLbl.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Height)
			mPnlClick.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Height)
			
			If NormalTextSise > OnPressedTextSise Then
				mLbl.TextSize = OnPressedTextSise + (NormalTextSise - OnPressedTextSise)
			Else
				mLbl.TextSize = OnPressedTextSise + (OnPressedTextSise - NormalTextSise)
			End If
			
			If Inside Then
				CallSubDelayed(mCallBack, mEventName & "_Click")
			End If
			
	End Select
	
End Sub

#Region Animation

Public Sub SetCustomAnimationGravity(left As Float, top As Float, right As Float, bottom As Float)
	Animation_Gravity = "Custom"
	Animation_Gravitys = Array As Float(left,top,right,bottom)
End Sub

#End Region