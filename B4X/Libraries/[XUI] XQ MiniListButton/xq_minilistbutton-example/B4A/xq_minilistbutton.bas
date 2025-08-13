B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
#DesignerProperty: Key: Text, DisplayName: Title Text, FieldType: String, DefaultValue: Title
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color
#DesignerProperty: Key: TextSize, DisplayName: Text Size, FieldType: Int, DefaultValue: 14, MinRange: 0
#DesignerProperty: Key: TextWidth, DisplayName: Text Width, FieldType: Int, DefaultValue: 30, MinRange: 0, Description: Text field width
#DesignerProperty: Key: IconSize, DisplayName: Icon Size, FieldType: Int, DefaultValue: 24, MinRange: 0, Description: Width/Height of icon
#DesignerProperty: Key: IconPadding, DisplayName: View Padding, FieldType: Int, DefaultValue: 5, MinRange: 0, Description: Padding from the edges
#DesignerProperty: Key: CornerRadius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 0, Description: Corner Radius for main panel
#DesignerProperty: Key: Elevation, DisplayName: Elevation, FieldType: Int, DefaultValue: 0, Description: Elevation/Adds shadow
#DesignerProperty: Key: Background, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF60CFF1, Description: Background color
#DesignerProperty: Key: ItemIndex, DisplayName: Item Index, FieldType: Int, DefaultValue: 0, Description: Selected item in list
#DesignerProperty: Key: Reversed, DisplayName: Reversed, FieldType: Boolean, DefaultValue: False, Description: Show icon/text in reverse order

#Event: Change

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Public Text As B4XView
	Public Icon As B4XView
	
	Private abackground As Int = xui.Color_Transparent
	Private aradius As Int
	Private areverse As Boolean
	Private apadding As Int
	Private awidth As Int
	Private atextcolor As Int = xui.Color_White
	Private atextsize As Int = 16
	Private aiconsize As Int = 24dip
	Private atext As String = "Title"
	Private aselection As String = ""
	Private aelevation As Int
	Public ChangeChar As Char
	Public Items As List
	Private aindex As Int = 0
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	ChangeChar = Chr(0xF079)
	Items.Initialize
	Items.Add("EN")
	Items.Add("GR")
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
  	
	atextsize = Props.Get("TextSize")
	aiconsize = DipToCurrent(Props.GetDefault("IconSize",24dip))
	atext = Props.Get("Text")
	abackground = xui.PaintOrColorToColor(Props.GetDefault("Background",0xff343434))
	atextcolor = xui.PaintOrColorToColor(Props.GetDefault("TextColor",0xffffffff))
	areverse = Props.GetDefault("Reversed",False)
	apadding = Props.GetDefault("IconPadding",5dip)
	awidth = Props.GetDefault("TextWidth",30dip)
	aradius = Props.GetDefault("CornerRadius",0dip)
	aindex = Props.GetDefault("ItemIndex",0)
	aelevation = Props.GetDefault("Elevation",0)
	
	Redraw
End Sub


Public Sub Redraw
	Dim cs As CSBuilder
	Dim p As Panel
	
	mBase.RemoveAllViews
	mBase.SetColorAndBorder(abackground,0,0x00ffffff,aradius)
	p = mBase
	p.Elevation = aelevation
	
	Text = CreateLabel("ltext")
	Text.TextColor = xui.PaintOrColorToColor(atextcolor)
	Text.Color = xui.Color_Transparent
	Text.TextSize = atextsize
	Text.Text = Items.Get(aindex)
	Text.SetTextAlignment("CENTER","CENTER")
	
	Icon = CreateLabel("licon")
	Icon.TextColor = xui.PaintOrColorToColor(atextcolor)
	Icon.Color = xui.Color_Transparent
	Icon.TextSize = aiconsize
	Icon.Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(atextsize).Append(ChangeChar).PopAll
	Icon.SetTextAlignment("CENTER","CENTER")
	
	If areverse Then
		mBase.AddView(Text,mBase.Width-awidth-apadding,apadding,awidth,mBase.Height-(2*apadding))
		mBase.AddView(Icon,apadding,apadding,aiconsize,mBase.Height-(2*apadding))
	Else
		mBase.AddView(Text,apadding,apadding,awidth,mBase.Height-(2*apadding))
		mBase.AddView(Icon,mBase.Width-aiconsize-apadding,apadding,aiconsize,mBase.Height-(2*apadding))
	End If
End Sub

public Sub Refresh
	Dim cs As CSBuilder
	Dim p As Panel
	
	p = mBase
	p.Elevation = aelevation

	mBase.SetColorAndBorder(abackground,0,0x00ffffff,aradius)

	Text.TextColor = xui.PaintOrColorToColor(atextcolor)
	Text.Color = xui.Color_Transparent
	Text.TextSize = atextsize
	Text.Text = Items.Get(aindex)
	Text.SetTextAlignment("CENTER","CENTER")
	
	Icon.TextColor = xui.PaintOrColorToColor(atextcolor)
	Icon.Color = xui.Color_Transparent
	Icon.TextSize = aiconsize
	Icon.Text = cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(atextsize).Append(ChangeChar).PopAll
	Icon.SetTextAlignment("CENTER","CENTER")
	
	If areverse Then
		Text.SetLayoutAnimated(0,mBase.Width-awidth-apadding,apadding,awidth,mBase.Height-(2*apadding))
		Icon.SetLayoutAnimated(0,apadding,apadding,aiconsize,mBase.Height-(2*apadding))
	Else
		Text.SetLayoutAnimated(0,apadding,apadding,awidth,mBase.Height-(2*apadding))
		Icon.SetLayoutAnimated(0,mBase.Width-aiconsize-apadding,apadding,aiconsize,mBase.Height-(2*apadding))
	End If
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  mBase.Width = Width
  mBase.Height = Height
End Sub

Private Sub CreateLabel(event As String) As B4XView
	Dim LH As Label
	LH.Initialize(event)
	LH.Ellipsize = "END"
	LH.SingleLine=True
	Return LH
End Sub

private Sub change As Boolean
	If Items.Size = 0 Then Return False
	aindex = aindex + 1 
	If aindex > Items.Size-1 Then 
		aindex = 0
	End If
	atext = Items.Get(aindex)
	aselection = atext
	Refresh
	Return True
End Sub

#Region Properties

public Sub setItemIndex(i As Int)
	If i>Items.Size-1 Then Return
	aindex = i
	Refresh
End Sub

public Sub getItemIndex As Int
	Return aindex
End Sub

public Sub getSelection As String
	Return aselection
End Sub

public Sub setCornerRadius(i As Int)
	aradius = i
	mBase.SetColorAndBorder(abackground,0,0x00ffffff,aradius)
End Sub

public Sub getCornerRadius As Int
	Return aradius
End Sub

public Sub setPadding(i As Int)
	apadding = i
	Redraw
End Sub

public Sub getPadding As Int
	Return apadding
End Sub

public Sub setElevation(i As Int)
	aelevation = i
	Redraw
End Sub

public Sub getElevation As Int
	Return aelevation
End Sub

public Sub setBackground(i As Int)
	abackground = i
	Refresh
End Sub

public Sub getBackground As Int
	Return abackground
End Sub

public Sub setReverse(i As Boolean)
	areverse = i
	Redraw
End Sub

public Sub getReverse As Boolean
	Return areverse
End Sub
#End Region

#Region Event
Private Sub licon_Click
	If change Then
		If xui.SubExists(mCallBack,mEventName & "_Change",0) Then CallSub(mCallBack,mEventName & "_Change")
	End If
End Sub

Private Sub ltext_Click
	If change Then
		If xui.SubExists(mCallBack,mEventName & "_Change",0) Then CallSub(mCallBack,mEventName & "_Change")
	End If
End Sub
#End Region