B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#Event: TabChanged(tabIndex as int)
#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private listTab As List
	Private tabHeader As Panel
	Private tabBody As Panel
	Private tabHeaderHeight As Int = 30dip	
	Private tabWidth As Int
	Private tabHeight As Int
	Private tabHeaderItem(5) As Label
	Private tabPage(5) As Panel
	Private currentTab As Int = 0
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	'mBase.Initialize("mBase")
	listTab.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
  	Dim clr As Int = xui.PaintOrColorToColor(Props.Get("TextColor")) 'Example of getting a color value from Props
	listTab.Initialize
	tabHeader.Initialize("")
	tabBody.Initialize("")
	
	tabWidth = 100%x - 10dip
	tabHeight = mBase.Height - tabHeaderHeight
	
	tabHeader.As(B4XView).SetColorAndBorder(Colors.ARGB(255,235,236,240), 0, Colors.White,4dip)
	mBase.AddView(tabHeader,5dip,5dip, tabWidth,tabHeaderHeight)
	mBase.AddView(tabBody, 5dip, tabHeaderHeight + 5dip, tabWidth, tabHeight)
	
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Public Sub AddTab(tabName As String)
	listTab.Add(tabName)
		
End Sub

Public Sub DrawTab()
	tabHeader.RemoveAllViews
	Dim length As Int = listTab.Size
	Dim tabHeaderItem(length) As Label
	Dim tabPage(length) As Panel
	Dim baseWidth As Int = (tabWidth / length) - 2dip
	Dim positionX As Int = 3dip
	
	For i=0 To listTab.Size - 1
		tabHeaderItem(i).Initialize("tabItem")
		tabHeader.AddView(tabHeaderItem(i), positionX, 3dip,baseWidth,24dip)
		tabHeaderItem(i).Text = listTab.Get(i)
		tabHeaderItem(i).Tag = i
		tabHeaderItem(i).Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL
		' ----------------------
		' Add page
		tabPage(i).Initialize("")
		tabBody.AddView(tabPage(i), 5dip, 5dip, tabBody.Width - 10dip, tabBody.Height - 10dip)
		tabPage(i).Visible = False
		
		tabPage(i).Color = Colors.White
		
		positionX = positionX + baseWidth
		If i = currentTab Then
			tabHeaderItem(i).As(B4XView).SetColorAndBorder(Colors.White, 0, Colors.White,4dip)
			tabPage(i).Visible = True
		End If
	Next
End Sub

Private Sub ClearSelected()
	For i=0 To listTab.Size - 1
		tabHeaderItem(i).Color = Colors.Transparent
		tabPage(i).Visible = False
	Next
End Sub

Public Sub SetLayout(tabIndex As Int, panelItem As Panel)
	tabPage(tabIndex).AddView(panelItem, 0,0,tabWidth, tabHeight)
End Sub

Private Sub ActiveTab(index As Int)
	tabHeaderItem(index).As(B4XView).SetColorAndBorder(Colors.White, 0, Colors.White,4dip)
	tabPage(index).Visible = True
End Sub

Public Sub GetView() As Panel
	Return mBase
End Sub

Sub tabItem_Click
	Dim item As Label = Sender
	Dim position As Int = item.Tag
	ClearSelected
	ActiveTab(position)
	CallSub2(mCallBack, mEventName & "_TabChanged", position)
End Sub