B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
'Author: Alexander Stolte
'Version: V0.2 BETA

#IF Documentation

Updates:
V0.1 BETA
-Release
V0.2 BETA
-Add Property "Automatic Layout Duplicate"
-Add Background_Color_Of_Shape_Array
-BugFixes


#End If

#DesignerProperty: Key: AnimationDuration, DisplayName: Animation Duration, FieldType: Int, DefaultValue: 1000, MinRange: 1, Description: The Animation Duration Interval
#DesignerProperty: Key: BackgroundColorOfShape, DisplayName: Background color of shapes, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: The Color of Shapes
#DesignerProperty: Key: AnimationType, DisplayName: Animation Type, FieldType: String, DefaultValue: TRANSITION, List: NONE|TRANSITION

#DesignerProperty: Key: AutomaticDuplicates, DisplayName: Enable Automatic Layout Duplicate, FieldType: Boolean, DefaultValue: True, Description: Duplicate the shape and put it under the first shape and so on to the bottom of the view.

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private animationisrunning As Boolean = False
	
	'Properties
	Private AnimationDuration As Int 
	Private BackgroundColorOfShape As Int
	Private AnimationType As String
	Private AutomaticDuplicates As Boolean
	
	
	Private MyColors As List
	Private ColorIndex As Int = -1
End Sub

Private Sub IniProperties(Props As Map)
	
	AnimationDuration = Props.Get("AnimationDuration")
	BackgroundColorOfShape = xui.PaintOrColorToColor(Props.Get("BackgroundColorOfShape"))
	AnimationType = Props.Get("AnimationType")
	AutomaticDuplicates = Props.Get("AutomaticDuplicates")
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	MyColors.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
  	mBase.Color = xui.Color_Transparent
  
	IniProperties(Props)
  
  	#IF B4A
  
	Base_Resize(mBase.Width,mBase.Height)
  
	#End If
  
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
  
  
End Sub

Public Sub Placeholder(ParentView As B4XView)

	If AutomaticDuplicates = True Then

	Dim tmp_int As Int = (mBase.Height/ParentView.Height)
	
	Else
		
		Dim tmp_int As Int = 1
		
		End If
	
	For i = 0 To tmp_int -1
	
		Dim baseview As B4XView = xui.CreatePanel("")
		baseview.SetLayoutAnimated(0,0,0,ParentView.Width,ParentView.Height)
	
		Dim backARGB() As Int = GetRightColor
	
		For Each v As B4XView In ParentView.GetAllViewsRecursive
		
			Dim tmp_shape As B4XView = xui.CreatePanel("")
			tmp_shape.SetColorAndBorder(xui.Color_ARGB(155,backARGB(1),backARGB(2),backARGB(3)),0,xui.Color_Transparent,5dip)
			baseview.AddView(tmp_shape,v.Left,v.Top,v.Width,v.Height)
		
		Next
	
		mBase.AddView(baseview,0,baseview.Height * i,baseview.Width,baseview.Height)
	
	Next
	
End Sub

#Region UserProperties

Public Sub setBackground_Color_Of_Shape_Array(Color() As Int)

	MyColors.Clear

For i = 0 To Color.Length -1
	
		MyColors.Add(Color(i))
	
Next
	
End Sub

Public Sub getANIMATION_TYPE_NONE As String
	
	Return "NONE"
	
End Sub

Public Sub getANIMATION_TYPE_TRANSITION As String
	
	Return "TRANSITION"
	
End Sub

Public Sub setAnimation_Duration(Duration As Int)
	
	AnimationDuration = Duration
	
End Sub

Public Sub getAnimation_Duration As Int
	
	Return AnimationDuration 
	
End Sub

Public Sub setBackground_Color_Of_Shape(Color As Int)
	
	BackgroundColorOfShape = Color
	
End Sub

Public Sub getBackground_Color_Of_Shape As Int
	
	Return BackgroundColorOfShape
	
End Sub

Public Sub setAnimation_Type(Animation As String)
	
	If Animation = "NONE" Or Animation = "TRANSITION" Then
		
		AnimationType = Animation
		If Animation = "NONE" Then animationisrunning = False
		Else
			
			AnimationType = "NONE"
		animationisrunning = False
	End If
	
End Sub

Public Sub getAnimation_Type As String
	
		Return	AnimationType 
	
End Sub

Public Sub Start
	
	animationisrunning = True
	animationloop
	
End Sub

Public Sub Stop
	
	animationisrunning = False
	
End Sub

Public Sub Show
	
	mBase.Visible = True
	
End Sub

'Stops the animation
Public Sub Hide
	
	mBase.Visible = False
	animationisrunning = False
	
End Sub

#End Region

#Region Animations

Private Sub animationloop
	
If Not(AnimationType = "NONE") = True Then
	
	Do While animationisrunning = True
		
		For Each v As B4XView In mBase.GetAllViewsRecursive
			
			ColorTransitionAnimationTransparent(v)
				
		Next
		Sleep(AnimationDuration/2)
		For Each v As B4XView In mBase.GetAllViewsRecursive
			
			ColorTransitionAnimationNotTransparent(v)
					
		Next
		Sleep(AnimationDuration/2)
		
	Loop
	
	End If
	
End Sub

Private Sub ColorTransitionAnimationTransparent(xparent As B4XView)
	
	
	
	For Each v As B4XView In xparent.GetAllViewsRecursive
		Dim backARGB() As Int = GetARGB(v.Color)
		
		v.SetColorAnimated(250,xui.Color_ARGB(152,backARGB(1),backARGB(2),backARGB(3)),xui.Color_ARGB(255,backARGB(1),backARGB(2),backARGB(3)))
	
	Next
	
End Sub

Private Sub GetRightColor As Int()
	
	If MyColors.Size > 0 Then
		
		For i = 0 To MyColors.Size -1
			
			ColorIndex = (ColorIndex + 1) Mod MyColors.Size
			Return GetARGB(MyColors.Get(ColorIndex))
			
			
		Next
		
		Else
			
		Return GetARGB(BackgroundColorOfShape)
			
	End If
	
End Sub

Private Sub ColorTransitionAnimationNotTransparent(xparent As B4XView)
	

	
	For Each v As B4XView In xparent.GetAllViewsRecursive
		
		Dim backARGB() As Int = GetARGB(v.Color)
		v.SetColorAnimated(250,xui.Color_ARGB(255,backARGB(1),backARGB(2),backARGB(3)),xui.Color_ARGB(152,backARGB(1),backARGB(2),backARGB(3)))
		
	Next
	
End Sub

#End Region

#Region Functions

'int ot argb
Private Sub GetARGB(Color As Int) As Int()
	Private res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

#End Region



