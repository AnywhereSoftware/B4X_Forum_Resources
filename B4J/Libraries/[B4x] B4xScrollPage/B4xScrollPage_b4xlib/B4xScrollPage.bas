B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
#Event : SetPageData(Index as Int)
#Event : SetPageComplete(LastIndex As Int)
#DesignerProperty: Key: ShowPageControl, DisplayName: Show Page Control, FieldType: Boolean, DefaultValue: True, Description: Show the page control
#DesignerProperty: Key: AnimDuration, DisplayName: Animation Duration, FieldType: Int, DefaultValue: 105, Description: Animation Duration
#DesignerProperty: Key: AnimInterval, DisplayName: Animation Interval, FieldType: Int, DefaultValue: 15,  Description: Animation Interval
#DesignerProperty: Key: AnimDirection, DisplayName: Anumation Direction, FieldType: String, DefaultValue: Horizontal, List: Horizontal|Vertical
#DesignerProperty: Key: LayoutName, DisplayName: Optional Layout Name, FieldType: String, DefaultValue: b4xscrollpage


'V1.1	added SetPageNames
		'added optional layout to designer properties and auto selection of a no button layout if ShowPageControl = False
		'added allow list of page names
		'added LoadPage1(Name As String, Direction As Int)
		'added LoadPage2(Index As Int,Direction As Int)
		'added Constants DIRECTION_NEXT and DIRECTION_PREV
		
Sub Class_Globals
	
	Public Tag As Object
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	
	Public Const DIRECTION_NEXT As Int = 1
	Public Const DIRECTION_PREV As Int = -1
	
	Private IV1,IV2,IVSBV,IVSBH As B4XImageView				'ignore
	Public B4XPlusMinus1 As B4XPlusMinus
	
	Public pnContent As B4XView
	Private mPageCount As Int
	Private CurrentIndex As Int = 0
	Private mAnimationDuration As Int
	Private mAnimationInterval As Int
	Private Horizontal As Boolean
	Private mNames As List
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	Dim ShowButtons As Boolean = Props.GetDefault("ShowPageControl",True)
	
	mAnimationDuration = Props.GetDefault("AnimDuration",105)
	B4XPlusMinus1.RapidPeriod1 = mAnimationDuration * 1.5
	B4XPlusMinus1.RapidPeriod2 = mAnimationDuration * 1.5
	mAnimationInterval = Props.GetDefault("AnimInterval",15)
	Horizontal = Props.GetDefault("AnimDirection","Horizontal") = "Horizontal"
	
	Dim LayoutName As String = Props.GetDefault("LayoutName","b4xscrollpage")
	If LayoutName = "b4xscrollpage" And ShowButtons = False Then LayoutName = "b4xscrollpage_nobtn"
	
#if b4a or b4i
	Sleep(0)
#end if

	mBase.LoadLayout(LayoutName)
	If ShowButtons = False Then B4XPlusMinus1.mBase.Visible = False

	#If B4j
	Dim JO As JavaObject = B4XPlusMinus1.MainLabel
	Dim o As Object = JO.CreateEventFromUI("javafx.event.EventHandler","B4xPlusMinusScroll",Null)
	JO.RunMethod("setOnScroll",Array(o))
	#End If
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  	IV1.mBase.SetLayoutAnimated(0,0,0,pnContent.Width,pnContent.Height)
	IV2.mBase.SetLayoutAnimated(0,0,0,pnContent.Width,pnContent.Height)
End Sub


Private Sub B4xPlusMinus1_ValueChanged (Value As Object)
	If mNames.IsInitialized Then
		Value = mNames.IndexOf(Value) + 1
	End If
	Dim Direction As Int
	If 1 = Value And CurrentIndex = mPageCount - 1 Then
		Direction = 1
	else If mPageCount = Value And CurrentIndex = 0 Then
		Direction = -1
	Else If Value - 1 > CurrentIndex Then
		Direction = 1
	Else
		Direction = -1
	End If
	
	LoadPage(Value,Direction)
End Sub

#If B4j

Private Sub B4xPlusMinusScroll_Event (MethodName As String, Args() As Object)
	Dim E As JavaObject = Args(0)
	
	Dim Direction As Int = E.RunMethod("getDeltaY",Null) / 40
	
	Dim PageNo As Int
	If Direction = 1 Then
		If CurrentIndex = mPageCount - 1 Then
			PageNo = 1
		Else
			PageNo = CurrentIndex + 2
		End If
	Else
		If CurrentIndex = 0 Then
			PageNo = mPageCount
		Else
			PageNo = CurrentIndex
		End If
	End If
	
	LoadPage(PageNo,Direction)
	
	If mNames.IsInitialized Then
		B4XPlusMinus1.SelectedValue = mNames.Get(CurrentIndex)
	Else
		B4XPlusMinus1.SelectedValue = PageNo
	End If
End Sub

#End If

'Time in Milliseconds
Public Sub setRepeatTime(Time As Int)
	'Make the animation time shorter than the repeat time so that it completes before the next call.
	mAnimationDuration = Time * 0.75
	B4XPlusMinus1.RapidPeriod1 = Time
	B4XPlusMinus1.RapidPeriod2 = Time
End Sub

'Set page names as opposed to a numeric range.
Public Sub SetPageNames(Names As List, InitialIndex As Int)
	mNames.Initialize
	mNames.AddAll(Names)
	mPageCount = mNames.Size
	B4XPlusMinus1.SetStringItems(Names)
	CurrentIndex = InitialIndex
	B4XPlusMinus1.SelectedValue = mNames.Get(InitialIndex)
	CallSub2(mCallBack,mEventName & "_SetPageData",CurrentIndex)
End Sub

'Specufy the toal number of pages and the required starting data index
Public Sub SetPageCount(Count As Int,InitialIndex As Int)
	Dim mNames As List
	mPageCount = Count
	B4XPlusMinus1.SetNumericRange(1,Count,1)
	CurrentIndex = InitialIndex
	B4XPlusMinus1.SelectedValue = InitialIndex + 1
	CallSub2(mCallBack,mEventName & "_SetPageData",CurrentIndex)
End Sub

'Specify the data index (Not the displayed PageNo) and the required direction of scroll as One of the DIRECTION constants
Public Sub LoadPage2(Index As Int,Direction As Int)
	LoadPage(Index + 1, Direction)
End Sub

'Specify the PageName if you have set string values, and the required direction of scroll as One of the DIRECTION constants
Public Sub LoadPage1(Name As String, Direction As Int)
	LoadPage(mNames.IndexOf(Name) + 1, Direction)
End Sub

'Specify the PageNo (not the data index) and the required direction of scroll as One of the DIRECTION constants
Public Sub LoadPage(PageNo As Int, Direction As Int)
	Dim Steps As Double = (mAnimationDuration / mAnimationInterval)
	Dim MoveX As Double
	
	Dim LastIndex As Int = CurrentIndex
	CurrentIndex = PageNo - 1
	
	Dim Img As B4XBitmap = pnContent.Snapshot
	IV1.mBase.SetLayoutAnimated(0,0,0,pnContent.Width,pnContent.Height)
	IV1.SetBitmap(Img.Crop(0,0,IV1.mBase.Width ,IV1.mBase.Height))
	IV1.mBase.BringToFront
	IV1.mBase.Visible = True
	
	CallSub2(mCallBack,mEventName & "_SetPageData",CurrentIndex)

	Dim Img2 As B4XBitmap = pnContent.Snapshot
	
	Dim VScrollBarWidth, HScrollBarHeight As Double		'ignore
	
#If B4j
	VScrollBarWidth = GetScrollBarSize("VERTICAL")
	If VScrollBarWidth > 0 Then
		IVSBV.mBase.SetLayoutAnimated(0,Img2.Width - VScrollBarWidth,0,VScrollBarWidth ,Img2.Height)
		IVSBV.SetBitmap(Img2.Crop(Img2.Width - VScrollBarWidth,0,VScrollBarWidth ,Img2.Height))
		IVSBV.mBase.Visible = True
		
	End If
	
	
	HScrollBarHeight = GetScrollBarSize("HORIZONTAL")
	If HScrollBarHeight > 0 Then
		IVSBH.mBase.SetLayoutAnimated(0,Img2.Width,Img2.Height - HScrollBarHeight,Img2.Width,HScrollBarHeight)
		IVSBH.SetBitmap(Img2.Crop(0,Img2.Height - HScrollBarHeight,Img2.Width,HScrollBarHeight))
		IVSBH.mBase.Visible = True
	End If

	
	IV1.mBase.Width = pnContent.Width - VScrollBarWidth
	IV1.mBase.Height = pnContent.Height - HScrollBarHeight
	
#End If

	IV2.mBase.Width = IV1.mBase.Width
	IV2.mBase.Height = IV1.mBase.Height
	
	IV1.SetBitmap(Img.Crop(1,1,IV1.mBase.Width - 1 ,IV1.mBase.Height - 1))
	IV2.SetBitMap(Img2.Crop(1,1,IV2.mBase.Width -1 ,IV2.mBase.Height - 1))
	
	
	mBase.RequestFocus
	If Horizontal Then
		MoveX = IV1.mBase.Width / Steps
		Select Direction
	
			Case 1					'Next
				IV1.mBase.Left = 0
				IV2.mBase.Left = IV1.mBase.Width
				
				IV2.mBase.Visible = True
				IV2.mBase.BringToFront
				IVSBV.mBase.BringToFront
				IVSBH.mBase.BringToFront

				Do While IV2.mBase.Left > 0
					IV1.mBase.Left = IV1.mBase.Left - MoveX
					IV2.mBase.Left = IV2.mBase.Left - MoveX
					Sleep(mAnimationInterval)
				Loop
			
			Case -1					'Prev
			
				IV1.mBase.Left = 0
				IV2.mBase.Left = - IV2.mBase.Width
			
				IV2.mBase.Visible = True
				IV2.mBase.BringToFront
				IVSBV.mBase.BringToFront
				IVSBH.mBase.BringToFront

				Do While IV2.mBase.Left < 0
					IV1.mBase.Left = IV1.mBase.Left + MoveX
					IV2.mBase.Left = IV2.mBase.Left + MoveX
					Sleep(mAnimationInterval)
				Loop
			
		End Select
	
	Else
		MoveX = IV1.mBase.Height / Steps
		
		Select Direction
	
			Case 1					'Next
				
				IV1.mBase.Top = 0
				IV2.mBase.Top = -IV2.mBase.height
				
				IV2.mBase.Visible = True
				IV2.mBase.BringToFront
				IVSBV.mBase.BringToFront
				IVSBH.mBase.BringToFront

				Do While IV2.mBase.Top < 0
					IV1.mBase.Top = IV1.mBase.Top + MoveX
					IV2.mBase.Top = IV2.mBase.Top + MoveX
					Sleep(mAnimationInterval)
				Loop
			
			Case -1					'Prev
				IV1.mBase.Top = 0
				IV2.mBase.Top = IV2.mBase.Height
			
				IV1.mBase.Visible = True
				IV2.mBase.Visible = True
				IV2.mBase.BringToFront
				IVSBV.mBase.BringToFront
				IVSBH.mBase.BringToFront

				Do While IV2.mBase.Top > 0
					IV1.mBase.Top = IV1.mBase.Top - MoveX
					IV2.mBase.Top = IV2.mBase.top - MoveX
					Sleep(mAnimationInterval)
				Loop
			
		End Select
		
		
		
	End If
	
	IV1.mBase.Visible = False
	IV2.mBase.Visible = False
	IVSBV.mBase.Visible = False
	IVSBH.mBase.Visible = False
	IV1.SetBitmap(Img.Crop(0,0,1,1))
	IV2.SetBitmap(Img.Crop(0,0,1,1))
	IVSBV.SetBitmap(Img.Crop(0,0,1,1))
	IVSBH.SetBitmap(Img.Crop(0,0,1,1))
	IV1.mBase.Left = pnContent.Left
	IV2.mBase.Left = pnContent.Left
	IV1.mBase.Width = pnContent.Left
	IV2.mBase.Width = pnContent.Left
	
	If SubExists(mCallBack,mEventName & "_SetPageComplete") Then CallSub2(mCallBack,mEventName & "_SetPageComplete",LastIndex)
	
End Sub

#If B4j
'Parent - The Node that ontains a scrollbar i.e. ListView, TableView etc.
'Orientation - can be VERTICAL, HORIZONTAL or BOTH
Private Sub GetScrollbar(Parent As JavaObject, Orientation As String) As JavaObject
	'Get a Set that contains the scrollbars attached to the parent and convert it to an array
	Dim Arr() As Object = Parent.RunMethodJO("lookupAll",Array(".scroll-bar")).RunMethod("toArray",Null)

	For Each N As Node In Arr

		'Check this object is a scrolbar
		If GetType(N) = "com.sun.javafx.scene.control.skin.VirtualScrollBar" Or GetType(N) = "javafx.scene.control.ScrollBar" Then
			Dim SB As JavaObject = N

			'Get the orientation of the scrollbar as a string
			Dim BarOrientation As String = SB.RunMethodJO("getOrientation",Null).RunMethod("toString",Null)

			'Required Orientation is VERTICAL or BOTH
			If BarOrientation = "VERTICAL" And (Orientation  = BarOrientation) Then
				Return N
			End If

			'Required Orientation is HORIZONTAL or BOTH
			If BarOrientation = "HORIZONTAL" And (Orientation = BarOrientation) Then
				Return N
			End If
		End If
	Next
	Dim P As B4XView = xui.CreatePanel("")
	P.Visible = False
	Return P
End Sub

Private Sub GetScrollBarSize(Orientation As String) As Double
	Dim SB As B4XView = GetScrollbar(pnContent,Orientation)
'	If SB.IsInitialized And SB.RunMethod("isVisible",Null) Then
	If SB.IsInitialized And SB.Visible Then
		Dim Bounds As JavaObject = SB
		Bounds = Bounds.RunMethod("getLayoutBounds",Null)
		If Orientation = "VERTICAL" Then
			Return Bounds.RunMethod("getMaxX",Null)
		Else
			Return Bounds.RunMethod("getMaxY",Null)
		End If
	Else
		Return 0
	End If
End Sub
#End if