B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
#If Documentation
'ASViewPagerNative
'Author: Alexander Stolte
'Version: V1.00

Todo:
-AddPageAt
-RemovePage
-Clear
-setIgnorePageChangedEvent 

Changelog:
V1.00
	-Add Event ReachEnd - Triggers if the last page is selected
	-Add get NativeViewPager - Gets the native ViewPager View in B4A: AHViewPager B4I: iTabstrip
	-Add get CurrentIndex - Gets the current index
	-Add set CurrentIndexAnimated - Sets the current index animated
	-BreakingChange set CurrentPage renamed to set CurrentIndex
	-Add get Size - Gets the number of pages 
	-Base_Resize is now Public
	-Add NextPage - Smooth goes to next page
	-Add PreviousPage - Smooth goes to previous page
V1.01
	-AddPages - Remove "Text" Parameter
#End If

'#DesignerProperty: Key: ShowTabs, DisplayName: Show Tabs, FieldType: Boolean, DefaultValue: False

#Event: PageChanged(Index as int)
#Event: ReachEnd

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private mCurrentIndex As Int = 0
	
	Private lst_Pages As List
	
	#If B4A
	Private AHPageContainer1 As AHPageContainer
	Private AHViewPager1 As AHViewPager
	#Else If B4I
	Private TabStrip1 As TabStrip
	#End If
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	lst_Pages.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	IniProps(Props)
	'Sleep(0)
	
	#If B4i
	mBase.LoadLayout("frm_ASViewPagerNative_Tabstrip")
	#Else If B4A
	AHViewPager1.Initialize("AHViewPager1")
	mBase.AddView(AHViewPager1,0,0,mBase.Width,mBase.Height)
	#End If
	
	
End Sub

Private Sub IniProps(Props As Map)'ignore
	'm_ShowTabs = Props.Get("ShowTabs")
	
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	mBase.SetLayoutAnimated(0,mBase.Left,mBase.Top,Width,Height)
	
	#If B4A
	AHViewPager1.Width = Width
	AHViewPager1.Height = Height
	#Else If B4I
	Dim no As NativeObject = TabStrip1
	Dim Container As View = no.GetField("containerView")
     Sleep(50)
    Container.Width = Width
    Container.Height = Height
	#End If
	
End Sub

Public Sub AddPages(ListOfPanels As List)
	
	#If B4A
	AHPageContainer1.Initialize
	
	For i = 0 To ListOfPanels.Size -1	
		lst_Pages.Add("") 'Just a placeholder for future features
		AHPageContainer1.AddPage(ListOfPanels.Get(i).As(Panel),"")	
	Next

	AHViewPager1.PageContainer = AHPageContainer1
	#Else If B4I
	
	For i = 0 To ListOfPanels.Size -1
		lst_Pages.Add("") 'Just a placeholder for future features
	Next
	
	ChangePageNoAnimation(0)
	TabStrip1.SetPages(ListOfPanels)
	#End If
End Sub

'Smooth goes to next page
Public Sub NextPage
	If (mCurrentIndex +1) < lst_Pages.Size Then 
		#If B4A
		AHViewPager1.GotoPage(mCurrentIndex +1,True)
		#Else If B4I
		setCurrentIndex(mCurrentIndex +1)
		#End If	
	End If
End Sub

'Smooth goes to previous page
Public Sub PreviousPage
	If (mCurrentIndex -1) > -1 Then
		#If B4A
		AHViewPager1.GotoPage(mCurrentIndex -1,True)
		#Else If B4I
		setCurrentIndex(mCurrentIndex -1)
		#End If
	End If
End Sub

#If B4A
Public Sub getNativeViewPager As AHViewPager
	Return AHViewPager1
End Sub
#Else If B4I
Public Sub getNativeViewPager As TabStrip
	Return TabStrip1
End Sub
#End If

#If B4A

Private Sub AHViewPager1_PageChanged (Position As Int)
	PageChanged(Position)
End Sub

#Else If B4I

Private Sub ChangePageNoAnimation (Index As Int)
	Dim no As NativeObject = TabStrip1
	no.RunMethod("moveToViewControllerAtIndex:animated:", Array(Index, False))
End Sub

Private Sub TabStrip1_PageSelected (Position As Int)
	PageChanged(Position)
End Sub

#End If

'gets or sets the current index
Public Sub setCurrentIndex(Index As Int)
	#If B4A
	AHViewPager1.GotoPage(Index,False)
	#Else
	ChangePageNoAnimation(Index)
	#End If
End Sub

'sets the current index animated
Public Sub setCurrentIndexAnimated(Index As Int)
	#If B4A
	AHViewPager1.GotoPage(Index,True)
	#Else
	TabStrip1.CurrentPage = Index
	#End If
End Sub

'gets or sets the current index
Public Sub getCurrentIndex As Int
	Return mCurrentIndex
End Sub

'Gets the number of pages 
Public Sub getSize As Int
	Return lst_Pages.Size
End Sub

#Region Events

Private Sub PageChanged(Index As Int)
	If Index = -1 Or Index = mCurrentIndex Then Return
	mCurrentIndex = Index
	If xui.SubExists(mCallBack, mEventName & "_PageChanged", 1) Then
		CallSub2(mCallBack, mEventName & "_PageChanged",Index)
	End If
	
	If Index = (lst_Pages.Size -1) Then ReachEnd
End Sub

Private Sub ReachEnd
	
	If xui.SubExists(mCallBack, mEventName & "_ReachEnd", 0) Then
		CallSub(mCallBack, mEventName & "_ReachEnd")
	End If
	
End Sub

#End Region
