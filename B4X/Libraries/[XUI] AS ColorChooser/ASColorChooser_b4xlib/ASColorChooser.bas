B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.5
@EndOfDesignText@
'ASColorChooser
'Author: Alexander Stolte
'Version: 1.2

#DesignerProperty: Key: Orientation, DisplayName: Scroll Orientation, FieldType: String, DefaultValue: Automatic, List: Automatic|Horizontal|Vertical
#DesignerProperty: Key: ShowAddButton, DisplayName: Show Add Button, FieldType: Boolean, DefaultValue: True, Description: Shows a extra button, with a + 
#DesignerProperty: Key: Shape, DisplayName: Shape Form, FieldType: String, DefaultValue: Round, List: Round|Square
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF2A3137
#DesignerProperty: Key: SpaceBetweenItems, DisplayName: Space Between Items, FieldType: Int, DefaultValue: 5, Description: The Space between the items
#DesignerProperty: Key: ExtendedLineOnClick, DisplayName: Extended Line On Click, FieldType: Boolean, DefaultValue: True, Description: Shows a Line with space between the choosen color

#Event: ColorClicked(color as int)
#Event: AddClicked

'Updates
'V1
'	-Release
'V1.1
'	-Add SelectByColor propertie
'V1.2
'	-Add New Property "ExtendedLineOnClick"

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private mCLV As CustomListView 'ignore
	Private xui As XUI 'ignore
	
	'Properties
	Private orientation As String
	Private showaddbutton As Boolean
	Private shape As String
	Private backgroundcolor As Int
	Private spacebetweenitems As Int
	Private extendedlineonclick As Boolean
	
	Private lst_colors As List
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
 
	ini_properties(Props)
	ini_xclv_mCLV
	ini_views
 
 #If B4A
 
	Base_Resize(mBase.Width,mBase.Height)
 
#End If
 
 
 
End Sub

Private Sub ini_views
	
	mBase.Color = backgroundcolor
	
	lst_colors.Initialize
	
End Sub

Private Sub ini_properties (Props As Map)
	
	orientation = Props.Get("Orientation")
	showaddbutton = Props.Get("ShowAddButton")
	shape = Props.Get("Shape")
	backgroundcolor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	spacebetweenitems = Props.Get("SpaceBetweenItems")
	extendedlineonclick = Props.Get("ExtendedLineOnClick")
	
End Sub

Private Sub ini_xclv_mCLV
	
	Dim tmplbl As Label
	tmplbl.Initialize("")
 
	Dim tmpmap As Map
	tmpmap.Initialize
	tmpmap.Put("DividerColor",backgroundcolor)'0xFFD9D7DE)
	tmpmap.Put("DividerHeight",spacebetweenitems)
	tmpmap.Put("PressedColor",0xFF7EB4FA)
	tmpmap.Put("InsertAnimationDuration",300)
	
	If orientation = getAutomatic Then
		
		If mBase.Width >= mBase.Height Then
			tmpmap.Put("ListOrientation",getHorizontal)
			Else
			tmpmap.Put("ListOrientation",getVertical)
		End If
		
		Else 
		tmpmap.Put("ListOrientation",getVertical)
	End If
		
	tmpmap.Put("ShowScrollBar",False)
	
	mCLV.Initialize(Me,"xclv_mCLV")
	mCLV.DesignerCreateView(mBase,tmplbl,tmpmap)
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
	
  
End Sub

Private Sub AddColorItem(color As Int)
	
	Private xpnl_colors As B4XView
	xpnl_colors = xui.CreatePanel("xpnl_colors")
	xpnl_colors.Tag = color
	
	
	If orientation = getAutomatic Then
		
		If mBase.Width >= mBase.Height Then
	
			xpnl_colors.SetLayoutAnimated(0,0,0,mBase.Height,mBase.Height)
		Else
			xpnl_colors.SetLayoutAnimated(0,0,0,mBase.Width,mBase.Width)
		End If
		
	Else
		xpnl_colors.SetLayoutAnimated(0,0,0,mBase.Width,mBase.Width)
	End If
	
	xpnl_colors.Color = backgroundcolor
	
	mCLV.Add(xpnl_colors,lst_colors.Size)
	
	xpnl_colors.Color = color
	
	NormalMode(xpnl_colors,False)
	
	If showaddbutton = True Then
		Dim tmp_index As Int
		For i = 0 To mCLV.Size -1
			Dim tmpstr As String = mCLV.GetValue(i)
			If tmpstr = "additem" Then
				tmp_index = i
				
			End If
			
		Next
		mCLV.RemoveAt(tmp_index)
		AddPlusItem(xui.Color_White)
		
	End If
	
	
	
End Sub

Private Sub NormalMode(xpnl_colors As B4XView,Clicked As Boolean)
	Dim BorderColor As Int 
	If Clicked = True And extendedlineonclick = True And xpnl_colors.Tag <> "textlabel" Then
	Dim xpnl_extendedcircle As B4XView = xui.CreatePanel("")
		xpnl_colors.AddView(xpnl_extendedcircle,5dip,5dip,xpnl_colors.Width - 10dip,xpnl_colors.Height - 10dip)
	End If

			BorderColor = xui.Color_White	
	
	If shape = getRound Then
		If Clicked = True Then
			If extendedlineonclick = True And xpnl_colors.Tag <> "textlabel" Then
			xpnl_extendedcircle.SetColorAndBorder(xpnl_colors.Color,0,xui.Color_Transparent,xpnl_extendedcircle.Height/2)
				xpnl_colors.SetColorAndBorder(xui.Color_Transparent,2dip,xpnl_colors.Color,xpnl_colors.Height/2)
			Else
			
				xpnl_colors.SetColorAndBorder(xpnl_colors.Color,2dip,BorderColor,xpnl_colors.Height/2)
			End If
			
			Else

			If extendedlineonclick = True And xpnl_colors.Tag <> "textlabel" Then
				If xpnl_colors.Tag <> "textlabel" And xpnl_colors.NumberOfViews > 0 Then
					xpnl_colors.RemoveAllViews
					xpnl_colors.SetLayoutAnimated(0,0,0,xpnl_colors.Parent.Width,xpnl_colors.Parent.Height)
					xpnl_colors.SetColorAndBorder(xpnl_colors.Tag,0,xui.Color_Transparent,xpnl_colors.Height/2)
					Else
					xpnl_colors.SetColorAndBorder(xpnl_colors.Color,0,xui.Color_Transparent,xpnl_colors.Height/2)
				End If
				Else
				xpnl_colors.SetColorAndBorder(xpnl_colors.Color,0,xui.Color_Transparent,xpnl_colors.Height/2)
			End If
				
			
		End If
		
		Else
		If Clicked = True Then
		
			If extendedlineonclick = True And xpnl_colors.Tag <> "textlabel" Then
				xpnl_extendedcircle.SetColorAndBorder(xpnl_colors.Color,0,xui.Color_Transparent,0)
				xpnl_colors.SetColorAndBorder(xui.Color_Transparent,2dip,xpnl_colors.Color,0)
			Else
				xpnl_colors.SetColorAndBorder(xpnl_colors.Color,2dip,BorderColor,0)
			End If
		
		Else
			
			If extendedlineonclick = True And xpnl_colors.Tag <> "textlabel" Then
				If xpnl_colors.Tag <> "textlabel" And xpnl_colors.NumberOfViews > 0 Then
					xpnl_colors.RemoveAllViews
					xpnl_colors.SetLayoutAnimated(0,0,0,xpnl_colors.Parent.Width,xpnl_colors.Parent.Height)
					xpnl_colors.SetColorAndBorder(xpnl_colors.Tag,0,xui.Color_Transparent,0)
				Else
					xpnl_colors.SetColorAndBorder(xpnl_colors.Color,0,xui.Color_Transparent,0)
				End If
			Else
				xpnl_colors.SetColorAndBorder(xpnl_colors.Color,0,xui.Color_Transparent,0)
				
			End If
			
		End If
	
	End If
	
End Sub

Private Sub AddPlusItem(color As Int)
	
	Private xlbl_add As B4XView
	xlbl_add = CreateLabel("xlbl_add")
	xlbl_add.Tag = "textlabel"
	
	
	If orientation = getAutomatic Then
		
		If mBase.Width >= mBase.Height Then
	
			xlbl_add.SetLayoutAnimated(0,0,0,mBase.Height,mBase.Height)
		Else
			xlbl_add.SetLayoutAnimated(0,0,0,mBase.Width,mBase.Width)
		End If
		
	Else
		xlbl_add.SetLayoutAnimated(0,0,0,mBase.Width,mBase.Width)
	End If
	
	xlbl_add.Color = backgroundcolor
	
	mCLV.Add(xlbl_add,"additem")
	
	NormalMode(xlbl_add,False)
	
	xlbl_add.Color = color
	xlbl_add.Font = xui.CreateFontAwesome(20)
	xlbl_add.Text = Chr(0xF067)
	xlbl_add.TextColor = xui.Color_Black
	xlbl_add.SetTextAlignment("CENTER","CENTER")
	
End Sub

#Region Events

Private Sub xpnl_colors_Click
	
	Private xpnl_colors As B4XView = Sender
	
	For i = 0 To mCLV.Size -1
		
	Dim tmp_background As B4XView =	mCLV.GetPanel(i)
		NormalMode(tmp_background,False)
	Next
	NormalMode(xpnl_colors,True)
	
	Dim color As Int = 0
	If extendedlineonclick = True Then
		color = xpnl_colors.GetView(0).Color
		Else
		color = xpnl_colors.Color
	End If
	
	If xui.SubExists(mCallBack, mEventName & "_ColorClicked", 0) Then
		CallSub2(mCallBack, mEventName & "_ColorClicked",color)
	End If
	
End Sub

Private Sub xlbl_add_Click
	
	If xui.SubExists(mCallBack, mEventName & "_AddClicked", 0) Then
		CallSub(mCallBack, mEventName & "_AddClicked")
	End If
	
End Sub

#End Region

#Region Properties

Public Sub AddColor(color As Int)
	
	lst_colors.add(color)
	AddColorItem(color)
	
End Sub

Public Sub getAutomatic As String
	
	Return "Automatic"
	
End Sub

Public Sub getHorizontal As String
	
	Return "Horizontal"
	
End Sub

Public Sub getVertical As String
	
	Return "Vertical"
	
End Sub

Public Sub getRound As String
	
	Return "Round"
	
End Sub

Public Sub getSquare As String
	
	Return "Square"
	
End Sub

'Fire not the _ColorClicked Event
Public Sub SelectByColor(color As Int)
	
	For i = 0 To mCLV.Size -1
		
		Dim tmp_panel As B4XView = mCLV.GetPanel(i)
		If tmp_panel.Color = color Then
			
			For i = 0 To mCLV.Size -1
		
				Dim tmp_background As B4XView =	mCLV.GetPanel(i)
				NormalMode(tmp_background,False)
			Next
			NormalMode(tmp_panel,True)
				
		End If
			
	Next
	
End Sub

#End Region




#Region Functions

Private Sub CreateLabel(EventName As String) As B4XView
	
	Dim tmp_label As Label
	tmp_label.Initialize(EventName)
	Return tmp_label
	
End Sub

'https://www.b4x.com/android/forum/threads/b4x-check-if-color-is-dark-or-light.110463/
'Private Sub isColorDark(color As Int) As Boolean
'	
'	Dim darkness As Int = 1 - (0.299 * GetARGB(color)(1) + 0.587 * GetARGB(color)(2) + 0.114 * GetARGB(color)(3))/255
'	
'	If darkness <= 0.5 Then
'		Return	False 'It's a light color
'	Else
'		Return	True 'It's a dark color
'	End If
'	
'End Sub
'
'Sub GetARGB(Color As Int) As Int()
'	Dim res(4) As Int
'	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
'	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
'	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
'	res(3) = Bit.And(Color, 0xff)
'	Return res
'End Sub

#End Region
