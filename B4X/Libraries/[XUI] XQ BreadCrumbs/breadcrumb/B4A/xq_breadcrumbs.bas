B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color
#DesignerProperty: Key: TextSize, DisplayName: Text Size, FieldType: Int, DefaultValue: 14, MinRange: 0
#DesignerProperty: Key: IconSize, DisplayName: Icon Size, FieldType: Int, DefaultValue: 20, MinRange: 0
#DesignerProperty: Key: Background, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF60CFF1, Description: Background color
#DesignerProperty: Key: Pressed, DisplayName: Pressed Color, FieldType: Color, DefaultValue: 0xFF60CFF1, Description: Pressed color
#DesignerProperty: Key: Padding, DisplayName: Padding, FieldType: Int, DefaultValue: 2, MinRange: 0, Description: Padding between items
#DesignerProperty: Key: Elevation, DisplayName: Elevation, FieldType: Int, DefaultValue: 0, Description: Elevation/Adds shadow
#DesignerProperty: Key: Active, DisplayName: Active in Bold, FieldType: Boolean, DefaultValue: False, Description: Sets the text to bold for active item
#DesignerProperty: Key: Remove, DisplayName: Remove Items, FieldType: Boolean, DefaultValue: False, Description: Remove crumbs after the one clicked


#Event: Click(Index As Int, Value As Object)
#Event: LongClick(Index As Int, Value As Object)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	
	Public Tag As Object
	Public clv As CustomListView
	Public RootChar As Char
	Public SeperatorChar As Char
	
	Private lastactive As Int = -1
	Private atypeface As Typeface
	Private aactive As Boolean = False
	Private apadding As Int = 5dip
	Private atextcolor As Int = xui.Color_Black
	Private atextsize As Int = 16
	Private aiconsize As Int = 16
	Private abackground As Int = xui.Color_Blue
	Private apressedcolor As Int = xui.Color_Magenta
	Private aelevation As Int = 10dip
	Private aremove As Boolean = False
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	RootChar = Chr(0xe88a)
	SeperatorChar = Chr(0xF142)
	
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
  Tag = mBase.Tag
  mBase.Tag = Me 
	iniproperties(Props)
	inixclv
	'Redraw
End Sub

private Sub iniproperties(Props As Map)
	atextsize = Props.GetDefault("TextSize",14)
	aiconsize = Props.GetDefault("IconSize",20)
	abackground = xui.PaintOrColorToColor(Props.GetDefault("Background",abackground))
	apressedcolor = xui.PaintOrColorToColor(Props.GetDefault("Pressed",apressedcolor))
	apadding = DipToCurrent(xui.PaintOrColorToColor(Props.GetDefault("Padding",2dip)))
	atextcolor = xui.PaintOrColorToColor(Props.GetDefault("TextColor",atextcolor))
	aelevation = Props.GetDefault("Elevation",10dip)
	aactive = Props.GetDefault("Active",False)
	aremove = Props.GetDefault("Remove",False)
	
End Sub

Private Sub inixclv
	Dim tmplbl As Label
	tmplbl.Initialize("")
 
	Dim tmpmap As Map
	tmpmap.Initialize
	tmpmap.Put("DividerColor",abackground)'0xFFD9D7DE)
	tmpmap.Put("DividerHeight",0)
	tmpmap.Put("PressedColor",apressedcolor)'0xFF7EB4FA
	tmpmap.Put("InsertAnimationDuration",0)
	tmpmap.Put("ListOrientation","Horizontal")
	tmpmap.Put("ShowScrollBar",xui.IsB4J)
	
	clv.Initialize(Me,"xclv")
	clv.DesignerCreateView(mBase,tmplbl,tmpmap)
End Sub

Public Sub Redraw
	Dim p As Panel
	p = mBase
	p.Elevation = aelevation
	atypeface = Typeface.CreateNew(Typeface.DEFAULT,Typeface.STYLE_NORMAL)
	mBase.Color = abackground
	clv.DefaultTextBackgroundColor = xui.Color_Transparent
	clv.DefaultTextColor = atextcolor
	clv.DefaultTextBackgroundColor = xui.Color_Transparent
	clv.sv.Color = abackground
	lastactive = -1
	Base_Resize(mBase.Width,mBase.Height)
End Sub


Private Sub Base_Resize (Width As Double, Height As Double)
  mBase.Width = Width
	mBase.Height = Height
	clv.sv.SetLayoutAnimated(0,0,0,Width,Height)
	For i = 0 To clv.Size -1
		clv.GetPanel(i).Height = Height
	Next	
End Sub

Public Sub Clear
	clv.Clear
	lastactive = -1
	iAddicon(RootChar)
End Sub

public Sub stringwidth(txt As String) As Int
	Dim canvas As Canvas
	Dim bmp As Bitmap
	Dim tf As Typeface
	
	tf=Typeface.CreateNew(Typeface.DEFAULT_BOLD,Typeface.STYLE_BOLD)
	bmp.InitializeMutable(2dip, 2dip)
	canvas.Initialize2(bmp)
	Return canvas.MeasureStringWidth(txt,tf,atextsize)
End Sub

Private Sub CreateLabel(text As Object, event As String) As B4XView
	Dim LH As Label
	LH.Initialize(event)
	LH.Ellipsize = "END"
	LH.SingleLine=True
	LH.Typeface = atypeface
	LH.TextColor = atextcolor
	LH.TextSize = atextsize
	LH.Color = xui.Color_Transparent	
	LH.Gravity = Bit.Or(Gravity.CENTER_HORIZONTAL, Gravity.CENTER_VERTICAL)
	LH.Width = (2* apadding) + stringwidth(text)
	LH.Text = text
	Return LH
End Sub

Private Sub CreatePanel(event As String) As B4XView
	Dim p As Panel
	p.Initialize(event)
	p.Height = clv.sv.Height
	p.Width = 56dip
	p.Color = xui.Color_Transparent
	Return p
End Sub

Public Sub FontToBitmap (text As Char, FontSize As Float, color As Int) As B4XBitmap
	Dim IsMaterialIcons As Boolean
	If Asc(text)>61439 Then 
		IsMaterialIcons = False 
	Else 
		IsMaterialIcons = True
	End If
	Dim xui As XUI
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(p)
	Dim fnt As B4XFont
	If IsMaterialIcons Then fnt = xui.CreateMaterialIcons(FontSize) Else fnt = xui.CreateFontAwesome(FontSize)
	Dim r As B4XRect = cvs1.MeasureText(text, fnt)
	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
	cvs1.DrawText(text, cvs1.TargetRect.CenterX, BaseLine, fnt, color, "CENTER")
	Dim b As B4XBitmap = cvs1.CreateBitmap
	cvs1.Release
	Return b
End Sub

Private Sub iAddTextItem(txt As Object, iTag As Object)
	Dim lbl As B4XView = CreateLabel(txt,"")
	Dim p As B4XView = CreatePanel("")
	lbl.Text = txt
	'p.Width = 2*apadding+lbl.Width
	p.Width = lbl.Width+(2*apadding)
	p.AddView(lbl,apadding,0,lbl.Width,mBase.Height)
	p.Color=abackground
	clv.Add(p, iTag)
End Sub

Private Sub iAddItem(v As B4XView, iTag As Object)
	Dim p As B4XView = CreatePanel("")
	p.Width = v.Width+(2*apadding)
	p.AddView(v,apadding,0,v.Width,mBase.Height)
	p.Color=abackground
	clv.Add(p, iTag)
End Sub

Private Sub iAddTextItemWidth(txt As Object, iTag As Object,width As Int)
	Dim lbl As B4XView = CreateLabel(txt,"")
	Dim p As B4XView = CreatePanel("")
	lbl.Text = txt
	'p.Width = 2*apadding+lbl.Width
	lbl.Width = width
	p.Width = lbl.Width+(2*apadding)
	p.AddView(lbl,apadding,0,lbl.Width,mBase.Height)
	p.Color=abackground
	clv.Add(p, iTag)
End Sub

Private Sub iAddicon(ch As Char)
	Dim iv As ImageView
	iv.Initialize("")
	iv.bitmap = FontToBitmap(ch,aiconsize,atextcolor)
	Dim p As B4XView = CreatePanel("")
	p.Width = 2*apadding+iv.Width
	p.AddView(iv,0,0,p.Width,p.Height)
	p.Color = abackground
	If clv.Size = 0 Then 
		clv.Add(p, -2)
	Else
		clv.Add(p, -1)
	End If
End Sub

'Adds a new text item
Public Sub AddTextItem(txt As Object, iTag As Object)
	If clv.Size > 1 Then
		iAddicon(SeperatorChar)
	End If
	iAddTextItem(txt, iTag)
End Sub

'Adds a new item, with custom View
Public Sub AddItem(v As B4XView, iTag As Object)
	If clv.Size > 1 Then
		iAddicon(SeperatorChar)
	End If
	iAddItem(v, iTag)
End Sub

'Add a new text item, with specific width size
Public Sub AddTextItemWidth(txt As Object, iTag As Object, Width As Int)
	If clv.Size > 1 Then
		iAddicon(SeperatorChar)
	End If
	iAddTextItemWidth(txt, iTag, Width)
End Sub

'Scrolls the list to the last item
Public Sub ScrollToEnd
	clv.ScrollToItem(clv.Size-1)
End Sub

'Scrolls the list to the first item
Public Sub ScrollToStart
	clv.ScrollToItem(0)
End Sub

Private Sub SetStyle(index As Int,bold As Boolean)
	Dim p As Panel
	p = clv.GetPanel(index)
	Dim lbl As Label
	lbl = p.GetView(0)
	If bold Then
		lbl.Typeface = Typeface.CreateNew(Typeface.DEFAULT_BOLD,Typeface.STYLE_BOLD)
	Else
		lbl.Typeface = Typeface.CreateNew(Typeface.DEFAULT,Typeface.STYLE_NORMAL)
	End If
End Sub

Private Sub iRemoveItemsFromIndex(index As Int)
	If index*2 = clv.Size-1 Then
		Log("nothing to delete")
		Return
	End If
	If index=-1 Then 'home button
		Clear
		Return
	End If
	
	Dim ind As Int = clv.Size - 1
	Do While ind > index
		Log($"index: ${index*2}, ind: ${ind}"$)
		clv.RemoveAt(ind)
		ind = ind-1
	Loop
	If clv.Size = 0 Then Clear
End Sub

'Removes items from the given index and up
Public Sub RemoveItemsFromIndex(index As Int)

	If index*2 = clv.Size-1 Then 
		Log("nothing to delete")
		Return
	End If
	If index=-1 Then 'home button
		Clear
		Return
	End If
	
	Dim ind As Int = clv.Size - 1
	Do While ind > (index * 2) + 1
		Log($"index: ${index*2}, ind: ${ind}"$)
		clv.RemoveAt(ind)
		ind = ind-1
	Loop
	If clv.Size = 0 Then Clear
	
End Sub

'Returns the Value of the item with index (seperators are ignored)
Public Sub GetValueAt(Index As Int) As Object
	If Index <0 Then Return -2
	Return clv.GetValue((Index * 2)+1)
End Sub

#Region Properties
Public Sub setBackground(i As Int)
	abackground = i
	mBase.Color = abackground
	clv.sv.Color = abackground
	Redraw
End Sub

Public Sub setPressed(i As Int)
	apressedcolor = i
	clv.PressedColor = apressedcolor
	Redraw
End Sub

Public Sub setTextColor(i As Int)
	atextcolor = i
	Redraw
End Sub

Public Sub getBackground As Int
	Return abackground
End Sub

Public Sub getPressed As Int
	Return apressedcolor
End Sub

Public Sub getTextColor As Int
	Return atextcolor
End Sub

Public Sub getPadding As Int
	Return apadding
End Sub

public Sub setPadding(i As Int)
	apadding = i
	Redraw
End Sub

Public Sub getElevation As Int
	Return aelevation
End Sub

public Sub setElevation(i As Int)
	aelevation = i
	Redraw
End Sub

public Sub setRemoveItems(b As Boolean)
	aremove = b
End Sub

Public Sub getRemoveItems As Boolean
	Return aremove
End Sub

public Sub setActive(b As Boolean)
	aactive = b
	lastactive = -1
End Sub

Public Sub getActive As Boolean
	Return aactive
End Sub

Public Sub getActiveItemIndex As Int
	Return lastactive
End Sub

Public Sub getIconSize As Int
	Return aiconsize
End Sub

public Sub setIconSize(i As Int)
	aiconsize = i
	Redraw
End Sub
#End Region

#Region Event
'Index -1 is Home/Root button, 0 is the first item, 1 the second item...
Private Sub xclv_ItemClick(Index As Int, Value As Object)
	If aremove Then iRemoveItemsFromIndex(Index)
	Try
		Dim i As Int = Value
		If i>=0 Or i=-2 Then 
			If aactive Then
				If lastactive>0 Then
					SetStyle(lastactive,False)
				End If
				SetStyle(Index,True)
				lastactive=Index
			End If
			i = Floor((Index -1)  / 2)
			If xui.SubExists(mCallBack,mEventName & "_Click",2) Then CallSub3(mCallBack,mEventName & "_Click",i,Value)
		
		End If
	Catch
		i = Floor((Index -1)  / 2)
		If xui.SubExists(mCallBack,mEventName & "_Click",2) Then CallSub3(mCallBack,mEventName & "_Click",i,Value)
		
	End Try
End Sub

Private Sub xclv_ItemLongClick(Index As Int, Value As Object)
	Try
		Dim i As Int = Value
		If i>=0 Or i=-2 Then 
			i = Floor((Index -1)  / 2)
			If xui.SubExists(mCallBack,mEventName & "_Click",2) Then CallSub3(mCallBack,mEventName & "_LongClick",i,Value)
		
		End If
	Catch
		i = Floor((Index -1)  / 2)
		If xui.SubExists(mCallBack,mEventName & "_Click",2) Then CallSub3(mCallBack,mEventName & "_LongClick",i,Value)
		
	End Try
End Sub
#End Region