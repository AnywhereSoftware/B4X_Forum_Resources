B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.801
@EndOfDesignText@
'v1 (27/4/2020)
'kZero
#Event: PageChanged(Index As Int)
#Event: PanelRequested(Index As Int)
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As Panel
	Private Const DefaultColorConstant As Int = -984833 'ignore
	Private HSV As ScrollView
	Private ListPages As List
	Type TPage(Top As Int,PanelLoaded As Boolean,Value As Object)
	Public OffscreenPages As Int  = 1
	Private SX,DV,AD As Float
	Private MS As Long
	Private CurrentPageIndex As Int =-1	
End Sub
'Get List items count
Public Sub GetPagesCount As Int
	Return ListPages.Size
End Sub
Public Sub GetCurrentPageIndex As Int
	Return CurrentPageIndex
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	HSV.Initialize(0)
	HSV.Color=Colors.Gray
	ListPages.Initialize
	Private ref As Reflector
	ref.Target = HSV
	ref.SetOnTouchListener("Page_Touch")

	HideScrollBar
End Sub
'Load panel into visible item.
Public Sub LoadPanel(Pnl As Panel,Index As Int)
	Dim Page As TPage
	Page = ListPages.Get(Index)
	If Page.PanelLoaded=False Then
		Page.PanelLoaded=True
		Pnl.Tag=Index
		HSV.Panel.AddView(Pnl,0, Page.Top, HSV.Width, HSV.Height)
	End If
End Sub
'Unload panel from not-visible item.
Private Sub UnloadPanel(Index As Int)
	Dim Page As TPage
	Dim Tag As Int = HSV.Panel.GetView(Index).Tag
	Page = ListPages.Get(Tag)
	If Page.PanelLoaded=True Then
		HSV.Panel.RemoveViewAt(Index)
		Page.PanelLoaded=False
	End If
End Sub
Public Sub isPanelLoaded(Index As Int) As Boolean
	Dim Page As TPage
	If Index < ListPages.Size Then
		Page = 	ListPages.Get(Index)
		Return Page.PanelLoaded
	Else
		Return(False)
	End If
End Sub
Public Sub GetLoadedPanel(Index As Int) As Panel
	Dim Page As TPage
	If Index < ListPages.Size Then
		Page = 	ListPages.Get(Index)
		If Page.PanelLoaded Then
			For i =0 To HSV.Panel.NumberOfViews - 1
				
				If HSV.Panel.GetView(i).Tag=Index Then
					Return( HSV.Panel.GetView(i))
				End If
			Next
		Else
			Return(Null)
		End If
	Else
		Return(Null)
	End If
	Return(Null)
End Sub
'Clear the list
Public Sub Clear
	ListPages.Clear
	RemoveAll
	HSV.Panel.Width = 0
End Sub
Private Sub RemoveAll
	For i = HSV.Panel.NumberOfViews-1 To 0 Step -1
		HSV.Panel.RemoveViewAt(i)
	Next
End Sub
Public Sub ScrollToPage(Index As Int)
	HSV.ScrollPosition=HSV.Width*Index
	EventTrigger(Index)
End Sub
'Add empty item then load panel into it.
Public Sub NewPage(Value As Object)
	Dim Page As TPage
	Page.Initialize
	Page.top=ListPages.Size*HSV.Height
	Page.Value=Value
	HSV.Panel.Height=HSV.Panel.Height + HSV.Height
	ListPages.Add(Page)
End Sub
Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	mBase = Base
	mBase.AddView(HSV, 0, 0, Base.Width, Base.Height)
End Sub
Private Sub HideScrollBar
	Dim r As Reflector
	r.Target = HSV
	r.RunMethod2("setVerticalScrollBarEnabled", False, "java.lang.boolean")
End Sub
Public Sub Refresh
	Sleep(0)
	Dim cIndex As Int = CurrentPageIndex
	CurrentPageIndex=-1
	If cIndex=-1 Then cIndex=0
	EventTrigger(cIndex)
End Sub

Public Sub Page_Touch(SenderTag As Object, Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean
	Select Action
		Case 0
			MS=DateTime.Now
			SX=Y
			DV = (HSV.Height)/2
			AD = 0
		Case 1
			If ((DateTime.Now-MS)<300)  And (Abs(Y - SX) > (1dip)) Then 
				DV =1dip
				If Y < SX Then AD = 1
			End If
				
			For i = 0 To ListPages.Size -1
				If (((i+1)*HSV.Height) - HSV.ScrollPosition) > (DV) Then 
					HSV.ScrollPosition = (i+AD)*HSV.Height

					If   (i+AD) > ListPages.Size-1 Then Return False
					EventTrigger(i+AD)
					Return True
				End If
			Next

			Return False
	End Select
	Return False
End Sub

Sub EventTrigger(Index As Int)
	If CurrentPageIndex=Index Or Index > ListPages.Size-1 Then Return Else CurrentPageIndex=Index

	Dim FirstIndex,LastIndex As Int
	FirstIndex = Max(0,Index -OffscreenPages)
	LastIndex = Min(Index+OffscreenPages, ListPages.Size-1)
	
	
	For i = HSV.Panel.NumberOfViews-1 To 0 Step -1
		If HSV.Panel.GetView(i).Tag<FirstIndex Or HSV.Panel.GetView(i).Tag>LastIndex Then
			UnloadPanel(i)
		End If
	Next

	For i = FirstIndex To LastIndex
		If isPanelLoaded(i)=False Then
			If SubExists(mCallBack, mEventName & "_PanelRequested") Then CallSub2(mCallBack, mEventName & "_PanelRequested", i )
		End If 
	Next

	If SubExists(mCallBack, mEventName & "_PageChanged") Then
		CallSub2(mCallBack, mEventName & "_PageChanged", Index)
	End If
End Sub
Public Sub GetValue(Index As Int) As Object
	Dim Page As TPage
	Page = ListPages.Get(Index)
	Return Page.Value
End Sub
Public Sub SetValue(Index As Int,Value As Object)
	Dim Page As TPage
	Page = ListPages.Get(Index)
	Page.Value=Value
End Sub
'Returns a view object that holds the pages.
Public Sub AsView As View
	Return HSV
End Sub

Public Sub GetBase As Panel
	Return mBase
End Sub