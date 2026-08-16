B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@

#If Documentation

Updates:
	V1.00 (Last Update)
		-Release
#End If
Sub Class_Globals
	#if DEBUG
	Private LogColor_info As Int = 0xFF03C206
	Private LogColor_Error As Int = 0xFFDD003A
	Private LogColor_Warning As Int = 0xFFBA8C03
	#END if
	Private mParentActivity As B4XView
	Private SideInpuLists As List
	Private PanelInpuLists As List
	Private MenuInpuLists As List
	Private ScrollWidth As Int
	Private isIconAbove As Boolean
	Private xui As XUI
	Private PopUpTag As Object
	Type ActionLbl_Type (LabelOnly,PopUpLabel ,DialogLabel  As String)
	Private ActionLblType As ActionLbl_Type
	ActionLblType.LabelOnly="ActionBar_Label"
	ActionLblType.PopUpLabel="PopUpMenu_Label"
	ActionLblType.DialogLabel="DialogMenu_Label"
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ParentActivity As B4XView)
	mParentActivity = ParentActivity
	SideInpuLists.Initialize
	PanelInpuLists.Initialize
	MenuInpuLists.Initialize
	ScrollWidth=0
	isIconAbove=False	
End Sub

#Region ActionPanel (Depend On Global SideInpuLists as ListMap_Checks)

public Sub Add_SideAction(IconChar_Empty As Char,Text As String,vEvent As String)
	SideInpuLists.Add(Array(IconChar_Empty,Text,vEvent))
End Sub
public Sub Add_SidePopUP(IconChar_Empty As Char,Title As String,PopUpList As List, vEvent As String)
	SideInpuLists.Add(Array(IconChar_Empty,Title, vEvent,PopUpList))
End Sub
public Sub Add_SideEmpty(EmptyNo As Int)
	For i=1 To EmptyNo
		SideInpuLists.Add(Null)
	Next
End Sub
public Sub Add_SideContinue(ContNo As Int)
	For i=1 To ContNo
		SideInpuLists.Add(ContNo)
	Next
End Sub

'[TextSize_0orMinusAuto] Example :
'Positive 	=  14 	⇒ TextSize = 14 (Width Fill) (Set_ExtraForScroll is activate)
'0	=  0 	⇒ TextSize = 12 (Auto Scroll) (Set_ExtraForScroll NOT activate)
'Minus 	= -14 	⇒ TextSize = 14 (Auto Scroll) (Set_ExtraForScroll NOT activate)
public Sub Show_SideBar(ParentView As B4XView,Top_Bottom_Left_Right As Char,TextSize_0orMinusAuto As Int, TextColor As Int, iconColor As Int, Color As Int) As Panel
	Dim pnl As B4XView=get_SideBar(Top_Bottom_Left_Right,TextSize_0orMinusAuto, TextColor, iconColor, Color)
	If pnl.IsInitialized And pnl.NumberOfViews>0 Then
		pnl.SetLayoutAnimated(300,0,0,pnl.width,pnl.Height)
		Dim tags() As Object=pnl.tag
		ParentView.AddView(pnl,tags(0).As(Int),tags(1).As(Int),pnl.Width,pnl.Height)
	End If
	Return pnl
End Sub
public Sub get_SideBar(Top_Bottom_Left_Right As Char,TextSize_0orMinusAuto As Int, TextColor As Int, iconColor As Int, BgColor As Int) As Panel ', Top As Int, height As In,tLabelBGcolor As Int, Panel
	Dim Panel1 As B4XView = xui.CreatePanel("")
	If SideInpuLists.Size=0 Then
		#if DEBUG 
		LogColor("No Items Found",LogColor_Error)
		#End If	
		Return Panel1
	End If
	Dim ActLists As List =SideInpuLists

	Dim cols As List=get_LabelSize(ActLists)

	Dim Lwidth As Int
	Dim Width_Sc As Int
	Dim TextSize As Int
	If TextSize_0orMinusAuto<=0 And ScrollWidth<=0 Then
		TextSize=Max(-TextSize_0orMinusAuto,IIf(TextSize_0orMinusAuto=0,12,0))
		Dim MaxTextwidth As Float
		For i =0 To ActLists.Size-1
			If ActLists.get(i)<> Null And IsNumber(ActLists.get(i))=False Then
				Dim Lst1() As Object = ActLists.get(i)'.As(Object)
				MaxTextwidth=Max(MaxTextwidth,MeasureTextWidth_dip(Lst1(2),TextSize,Typeface.DEFAULT))
			End If
		Next
	Else
		TextSize=TextSize_0orMinusAuto
	End If
	
	Dim LblHeight As Int=IIf(isIconAbove, 1.38,1)*TextSize*2.5*1dip
	Dim Left,top,width As Int
	Dim rot As Float
	Select Top_Bottom_Left_Right.As(String).ToUpperCase
		Case "B"
			Left=0
			top=100%y-LblHeight
			width=100%x
			rot=0
		Case "L"
			Left=LblHeight
			top=0
			width=100%y
			rot=90.0
		Case "R"
			Left=100%x-LblHeight
			top=100%y
			width=100%y
			rot=-90.0
		Case Else
			Left=0
			top=0
			width=100%x
			rot=0
	End Select	
'-------------------
	If TextSize_0orMinusAuto<=0 And ScrollWidth<=0 Then
		Lwidth=MaxTextwidth +TextSize'*(3.2*1dip)
		Width_Sc=Lwidth*ActLists.size
	Else
		Width_Sc =IIf(ScrollWidth<=0,width,width+ScrollWidth)
		Lwidth = Width_Sc/ActLists.size
	End If
	'---------------------------------
	Dim Sview As HorizontalScrollView
	Sview.Initialize(LblHeight,"")
	Sview.SetLayoutAnimated(300,0,0,Width_Sc,LblHeight)
	Sview.panel.Width=Width_Sc
	Panel1.AddView(Sview,0,0,width,LblHeight)
	
	For i=0 To SideInpuLists.Size-1
		If ActLists.get(i)<> Null And IsNumber(ActLists.get(i))=False Then
			Dim Lst1() As Object= SideInpuLists.Get(i)
'			Dim iconchar As Char=Lst1(0)
'			Dim Text As String=Lst1(1)
			Dim iconchar As Char=Lst1(0)
			Dim Text As Object=Lst1(1)
			Dim MainLabelSub As String=Lst1(2)
			
			Dim Lbl As Label
			Dim MyList As Object
			Dim LocalLblClick As String = ActionLblType.LabelOnly'"ActionBar_Label"
			If Lst1.Length=4 Then
				MyList=Lst1(3)
				LocalLblClick=ActionLblType.PopUpLabel'"PopUpMenu_Label"
			else if Lst1.Length=5 Then
				MyList=Array(Lst1(3),Lst1(4))
				LocalLblClick=ActionLblType.DialogLabel'"DialogMenu_Label"
			else If GetType(Text).EndsWith(".String") Then
				MyList=Null
			End If
			If GetType(Text).EndsWith(".String") Or Lst1.Length>=4 Then
				Lbl=CreateLabel(MainLabelSub,iconchar, iconColor, Text, TextSize, TextColor,"C", BgColor,Lwidth*cols.get(i),LblHeight,MyList,LocalLblClick)
				If Lbl.IsInitialized Then Sview.panel.AddView(Lbl,i*Lwidth, 0, Lwidth*cols.get(i),LblHeight)
			End If
		End If
	Next
	Panel1.Tag=Array(Left, top)'"actionbarnize_" & Top_Bottom_Left_Right.As(String).ToUpperCase
	Panel1.Color=BgColor
	Panel1.Rotation=rot
	Panel1.SetLayoutAnimated(300,0, 0, width,LblHeight)
'	ActivityView.AddView(Panel1,Left,top,width, LblHeight)
	SetView_Elevation(Panel1,9.0)

	SideInpuLists.Initialize
	ScrollWidth=0
	isIconAbove=False
	Return Panel1
End Sub

#Region ActionPanel
public Sub Add_PanelAction(IconChar_Empty As Char,IconCharColor_0Non As Int,Text As String,TextColor_0Non As Int,vEvent As String)
	PanelInpuLists.Add(Array(IconChar_Empty,IconCharColor_0Non,Text,TextColor_0Non,vEvent))
End Sub
public Sub Add_PanelPopUP(IconChar_Empty As Char,IconCharColor_0Non As Int,Title As String,PopUpList As List,TextColor_0Non As Int,vEvent As String)
	PanelInpuLists.Add(Array(IconChar_Empty,IconCharColor_0Non,Title,TextColor_0Non,vEvent,PopUpList))
End Sub
public Sub Add_PanelEmpty(EmptyNo As Int)
	For i=1 To EmptyNo
		PanelInpuLists.Add(Null)
	Next
End Sub
public Sub Add_PanelContinue(ContNo As Int)
	For i=1 To ContNo
		PanelInpuLists.Add(ContNo)
	Next
End Sub

'[TextSize_0orMinusAuto] Example :
'Positive 	=  14 	⇒ TextSize = 14 (Width Fill) (Set_ExtraForScroll is activate)
'0	=  0 	⇒ TextSize = 12 (Auto Scroll) (Set_ExtraForScroll NOT activate)
'Minus 	= -14 	⇒ TextSize = 14 (Auto Scroll) (Set_ExtraForScroll NOT activate)
public Sub Show_PanelBar(ParentView As B4XView,TextSize_0orMinusAuto As Int,left As Int,top As Int,Width As Int,Height_0Auto As Int,BgColor As Int) As Panel
	Dim pnl As B4XView=get_PanelBar(TextSize_0orMinusAuto, Width,Height_0Auto, BgColor)
	If pnl.IsInitialized And pnl.NumberOfViews>0 Then
		pnl.SetLayoutAnimated(300,0,0,Width,pnl.Height)
		ParentView.AddView(pnl,left,top,Width,pnl.Height)
	End If
	Return pnl
End Sub

public Sub get_PanelBar(TextSize_0orMinusAuto As Int,Width As Int,Height_0Auto As Int,BgColor As Int)As Panel ',ActLists As List
	Dim Panel1 As B4XView=xui.CreatePanel("")
	If PanelInpuLists.Size=0 Then
		#if DEBUG 
		LogColor("No Items Found",LogColor_Error)
		#End If	
		Return Panel1
	End If
	Dim ActLists As List =PanelInpuLists

	Dim Lwidth As Int
	Dim Width_Sc As Int
	Dim textSize As Int

	If TextSize_0orMinusAuto<=0 And ScrollWidth<=0 Then
		textSize=Max(-TextSize_0orMinusAuto,IIf(TextSize_0orMinusAuto=0,12,0))
		Dim MaxTextwidth As Float
		For i =0 To ActLists.Size-1
			If ActLists.get(i)<> Null And IsNumber(ActLists.get(i))=False Then
				Dim Lst1() As Object = ActLists.get(i)
				MaxTextwidth=Max(MaxTextwidth,MeasureTextWidth_dip(Lst1(2),textSize,Typeface.DEFAULT))
			End If
		Next
		Lwidth=MaxTextwidth + textSize'*(3.2*1dip)
		Width_Sc=Lwidth*ActLists.size
	Else
		Width_Sc =IIf(ScrollWidth<=0,Width,Width+ScrollWidth)
		Lwidth = Width_Sc/ActLists.size
		textSize = TextSize_0orMinusAuto
	End If
	Dim Height As Int=IIf(Height_0Auto<=0,textSize*2.5*1dip*IIf(isIconAbove,1.38,1),Height_0Auto)

	Panel1.Color=BgColor'0xFFFFFFFF
	Panel1.SetLayoutAnimated(300,0,0,Width,Height)
	
	Dim Sview As HorizontalScrollView
	Sview.Initialize(Height,"")
	Sview.SetLayoutAnimated(300,0,0,Width_Sc,Height)
	Sview.panel.Width=Width_Sc
	Panel1.AddView(Sview,0,0,Width,Height)

	Dim textColor As Int
	Dim iconchar As Char
	Dim iconColor As Int
	Dim Text As Object
	Dim textColor As Int
	Dim MainLabelSub As String

	Dim cols As List=get_LabelSize(ActLists)

	For i =0 To ActLists.Size-1
		If ActLists.get(i)<> Null And IsNumber(ActLists.get(i))=False Then
			Dim Lst1() As Object = ActLists.get(i)'.As(Object)
			iconchar= Lst1(0)
			iconColor= Lst1(1)
			Text= Lst1(2)
			textColor= Lst1(3)
			MainLabelSub= Lst1(4)
			
			Dim Lbl As Label
			Dim MyList As Object
			Dim LocalLblClick As String = ActionLblType.LabelOnly
			If Lst1.Length=6 Then
				MyList=Lst1(5)
				LocalLblClick=ActionLblType.PopUpLabel
			else if Lst1.Length=7 Then
				MyList=Array(Lst1(5),Lst1(6))
				LocalLblClick=ActionLblType.DialogLabel
			else If GetType(Text).EndsWith(".String") Then
				MyList=Null
			End If
			If GetType(Text).EndsWith(".String") Or Lst1.Length>=6 Then
				Lbl=CreateLabel(MainLabelSub,iconchar, iconColor, Text, textSize, textColor,"c", BgColor,Lwidth*cols.get(i),Height,MyList,LocalLblClick)
				If Lbl.IsInitialized Then Sview.panel.AddView(Lbl,i*Lwidth, 0, Lwidth*cols.get(i),Height)
			End If
		End If
	Next
	SetView_Elevation(Panel1,9.0)
	PanelInpuLists.Initialize
	ScrollWidth=0
	isIconAbove=False
	Return Panel1
End Sub

#End Region

#Region Action MenuInpuLists

public Sub Add_MenuAction(IconChar_Empty As Char,IconCharColor_0Non As Int,Text As String,TextColor_0Non As Int,vEvent As String)
	MenuInpuLists.Add(Array(IconChar_Empty,IconCharColor_0Non,Text,TextColor_0Non,vEvent))
End Sub
public Sub Add_MenuPopUP(IconChar_Empty As Char,IconCharColor_0Non As Int,Title As String,PopUpList As List,TextColor_0Non As Int,vEvent As String)
	MenuInpuLists.Add(Array(IconChar_Empty,IconCharColor_0Non,Title,TextColor_0Non,vEvent,PopUpList))
End Sub
public Sub Add_MenuEmpty(EmptyNo As Int)
	For i=1 To EmptyNo
		MenuInpuLists.Add(Null)
	Next
End Sub
public Sub Add_MenuContinue(ContNo As Int)
	For i=1 To ContNo
		MenuInpuLists.Add(ContNo)
	Next
End Sub

'[TextSize_0orMinusAuto] Example :
'Positive 	=  14 	⇒ TextSize = 14 (Height Fill) (Set_ExtraForScroll is activate)
'0	=  0 	⇒ TextSize = 12 (Auto Scroll) (Set_ExtraForScroll NOT activate)
'Minus 	= -14 	⇒ TextSize = 14 (Auto Scroll) (Set_ExtraForScroll NOT activate)
public Sub Show_PanelMenu(ParentView As B4XView,TextSize_0orMinusAuto As Int,left As Int,top As Int,Width As Int,Height As Int,BgColor As Int) As Panel
	Dim pnl As B4XView=get_PanelMenu(TextSize_0orMinusAuto, Width,Height, BgColor)
	If pnl.IsInitialized And pnl.NumberOfViews>0 Then
		pnl.SetLayoutAnimated(300,0,0,Width,pnl.Height)
		ParentView.AddView(pnl,left,top,Width,pnl.Height)
	End If
	Return pnl
End Sub

public Sub get_PanelMenu(TextSize_0orMinusAuto As Int,Width As Int,Height As Int,BgColor As Int)As Panel ',ActLists As List
	Dim Panel1 As B4XView=xui.CreatePanel("")
	If MenuInpuLists.Size=0 Then
		#if DEBUG 
		LogColor("No Items Found",LogColor_Error)
		#End If	
		Return Panel1
	End If
	
	Dim ActLists As List =MenuInpuLists
	
	Dim Height_Sc As Int
	Dim Lheight As Int
	Dim textSize As Int
	If TextSize_0orMinusAuto<=0 And ScrollWidth<=0 Then
		textSize=Max(-TextSize_0orMinusAuto,IIf(TextSize_0orMinusAuto=0,12,0))
		Lheight=textSize*(3.2*1dip)
		Height_Sc=Lheight*ActLists.size
	Else
		textSize=TextSize_0orMinusAuto
		Height_Sc=IIf(ScrollWidth<=0,Height,Height+ScrollWidth)
		Lheight= Height/ActLists.size 
	End If
	'---------------------
	
	Panel1.Color=BgColor'0xFFFFFFFF
	Panel1.SetLayoutAnimated(300,0,0,Width,Height)
	
	Dim Sview As ScrollView
	Sview.Initialize(Height)
	Sview.SetLayoutAnimated(300,0,0,Width,Height_Sc)
	Sview.panel.Height=Height_Sc
	Panel1.AddView(Sview,0,0,Width,Height)

	Dim textColor As Int
	Dim iconchar As Char
	Dim iconColor As Int
	Dim Text As Object
	Dim textColor As Int
	Dim MainLabelSub As String

	Dim cols As List=get_LabelSize(ActLists)

	For i =0 To ActLists.Size-1
		If ActLists.get(i)<> Null And IsNumber(ActLists.get(i))=False Then
			Dim Lst1() As Object = ActLists.get(i)'.As(Object)
			iconchar= Lst1(0)
			iconColor= Lst1(1)
			Text= Lst1(2)
			textColor= Lst1(3)
			MainLabelSub= Lst1(4)
			
			Dim Lbl As Label
			Dim MyList As Object
			Dim LocalLblClick As String =ActionLblType.LabelOnly
			If Lst1.Length=6 Then
				MyList=Lst1(5)
				LocalLblClick=ActionLblType.PopUpLabel 
			else if Lst1.Length=7 Then
				MyList=Array(Lst1(5),Lst1(6))
				LocalLblClick=ActionLblType.DialogLabel
			else If GetType(Text).EndsWith(".String") Then
				MyList=Null
			End If
			If GetType(Text).EndsWith(".String") Or Lst1.Length>=6 Then
				Lbl=CreateLabel(MainLabelSub,iconchar, iconColor, Text, textSize, textColor,"L", BgColor,Width,Lheight*cols.get(i),MyList,LocalLblClick)
				If Lbl.IsInitialized Then Sview.panel.AddView(Lbl, 0,i*Lheight, Width,Lheight*cols.get(i))
			End If
		End If
	Next
	
	SetView_Elevation(Panel1,9.0)
	MenuInpuLists.Initialize
	ScrollWidth=0
	isIconAbove=False
	Return Panel1
End Sub


#End Region

#Region Sub Routains for this class

public Sub Set_isIconAbove(above As Boolean)
	isIconAbove=above
End Sub

public Sub Set_ExtraForScroll(width As Int)
	ScrollWidth=width
End Sub
#Region view Click Color

private Sub SetView_PressColor(v As View, NormalColor As Int, PressedColor As Int, DurationMs As Int)
	Dim pColor As Object = CreateColorDrawable(PressedColor)
	Dim nColor As Object = CreateColorDrawable(NormalColor)
    
	Dim sld As JavaObject
	sld.InitializeNewInstance("android.graphics.drawable.StateListDrawable", Null)
    
	Dim pressedState() As Int = Array As Int(16842919)
	sld.RunMethod("addState", Array(pressedState, pColor))
    
	Dim wildState() As Int = Array As Int()
	sld.RunMethod("addState", Array(wildState, nColor))
    
	If DurationMs > 0 Then
		sld.RunMethod("setEnterFadeDuration", Array(DurationMs))
		sld.RunMethod("setExitFadeDuration", Array(DurationMs))
	End If
    
	Dim joView As JavaObject = v
	joView.RunMethod("setBackground", Array(sld))
End Sub

Private Sub CreateColorDrawable(Color As Int) As JavaObject
	Dim cd As JavaObject
	cd.InitializeNewInstance("android.graphics.drawable.ColorDrawable", Array(Color))
	Return cd
End Sub
#End Region

'(Elevation 5 Above 3)
Public Sub SetView_Elevation(Target As B4XView, Elevation_Positive As Float)
    #If B4A
	Dim jo As JavaObject = Target
	jo.RunMethod("setStateListAnimator", Array(Null))
	jo.RunMethod("setElevation", Array As Object(Elevation_Positive))
    #End If
End Sub
#End Region

private Sub get_LabelSize(AnyActLists As List) As List
	Dim cols As List
	cols.Initialize
	For i =0 To AnyActLists.Size-1
		If IsNumber(AnyActLists.get(i)) Then
			If i>0 Then
				cols.Set(i-1,cols.Get(i-1)+AnyActLists.get(i))
				cols.Add(1)
			Else
				cols.Add(1)
			End If
		Else
			cols.Add(1)
		End If
	Next
	Return cols
End Sub

private Sub CreateLabel(MainLabelSub As String,IconChar As Char,iconColor As Int, _
	Text As String,TextSize As Int, TextColor As Int,Alighnm As String, _
	LabelBGcolor As Int, Width As Int, height As Int, PopList As Object,LocalLblClick As String) As Label
	If LocalLblClick.Trim="" Then LocalLblClick=ActionLblType.LabelOnly
	Dim align As Int
	Dim pad() As Int 
	Select Alighnm.ToUpperCase.CharAt(0)
		Case "R"
			align=Gravity.RIGHT
			pad=Array As Int (5dip, 1dip, 5dip, 1dip)
		Case "L"
			align=Gravity.LEFT
			pad=Array As Int (5dip, 1dip, 5dip, 1dip)
		Case Else
			align=Gravity.CENTER_HORIZONTAL
			pad=Array As Int (1dip, 1dip, 1dip, 1dip)
	End Select
	Dim ActivityView As B4XView=mParentActivity
	If (IconChar & Text.trim & MainLabelSub.trim) <> "" Then
		If iconColor=0 Then iconColor=TextColor
		If TextColor=0 Then TextColor=iconColor
		If IconChar =0  And Text ="" Then IconChar= Chr(0xF0A3)

		Private Lbl As Label
		Lbl.Initialize(IIf(MainLabelSub.Trim="","",LocalLblClick))'"ActionBar_Label"))
		Lbl.SetLayout(0,0,Width,height)
		If PopList=Null Then
			Lbl.tag=Array(MainLabelSub,ActivityView)
		Else if LocalLblClick.ToUpperCase.StartsWith("POP") Then
			Lbl.tag=Array(MainLabelSub,ActivityView,PopList,TextSize)',IconChar,iconColor,TextColor)
		Else if LocalLblClick.ToUpperCase.StartsWith("DIA") Then
			Lbl.tag=Array(MainLabelSub,ActivityView,PopList,TextColor)',IconChar,iconColor,TextSize)'PopList.As(List).Get(6))
		End If
		Lbl.Padding = pad 
		Lbl.Text=Text
		Lbl.TextSize=TextSize
		Lbl.Gravity=Gravity.CENTER_VERTICAL+Gravity.CENTER_HORIZONTAL
		Lbl.Color= LabelBGcolor
		Dim cs As CSBuilder
		cs.Initialize
		
		cs.Size(TextSize*IIf(Text="",2,1.8))
		
		If IconChar<>"" Then
			cs.Typeface(IIf(Asc(IconChar)<61440 ,Typeface.MATERIALICONS,Typeface.FONTAWESOME))
			cs.Color(iconColor).VerticalAlign(IIf(Text="",0,0.4)*TextSize).Append(IconChar).Pop
		End If
		If Text<>"" Then
			If IconChar<>"" Then
				If isIconAbove Then cs.Append(Chr(10)).Pop 'Else cs.Append(TAB)
			End If
			cs.Typeface(Typeface.DEFAULT).Size(TextSize).Color(TextColor).VerticalAlign(IIf(IconChar="",0,-0.75)*TextSize).Append(Text)
		End If
		cs.PopAll
		Lbl.Text =cs
		Lbl.Gravity=Gravity.CENTER_VERTICAL + align 'Gravity.CENTER_HORIZONTAL
		
		If MainLabelSub.Trim<>"" Then
			Dim LblPressColor As Int=IIf(LabelBGcolor<0x77777777 And LabelBGcolor<-1 ,xui.Color_ARGB(150,255,255,255),xui.Color_ARGB(30,0,0,0))
			SetView_PressColor(Lbl,LabelBGcolor,LblPressColor,300)
		End If
		Return Lbl
	End If
	Return Null
End Sub



private Sub MeasureTextWidth_dip(Text As String, TextSize As Float, FontFace As Typeface) As Float
	Dim Bmp As Bitmap
	Bmp.InitializeMutable(1dip, 1dip)
	Dim Cvs As Canvas
	Cvs.Initialize2(Bmp)
	Return Cvs.MeasureStringWidth(Text, FontFace, TextSize)
End Sub
private Sub ActionBar_Label_Click
	LabelEvent(Sender,"_Click")
End Sub
private Sub ActionBar_Label_LongClick
	LabelEvent(Sender,"_LongClick")
End Sub

Private Sub LabelEvent(Labl As Label,Event_Ext As String)
	Dim tags() As Object=Labl.tag
	Dim Event As String=tags(0)
	Dim view As B4XView=tags(1)
	Private jo As JavaObject = view
	Dim MeView As Object = GetType(jo.RunMethod("getContext", Null))
	Dim MainName As String=MeView.as(String).SubString2(MeView.as(String).LastIndexOf(".")+1,MeView.as(String).Length)
	If Event.As(String).trim<>"" Then
		Dim Main_ItemClick As String =Event & Event_Ext'"_LongClick"
		If SubExists(MainName, Main_ItemClick) Then
			CallSub(MainName, Main_ItemClick)
		Else
			#if DEBUG 
			LogColor("Private Sub " & Main_ItemClick &" '⚠ --- " & " NOT found in " & MainName,LogColor_Warning)
			#End If
		End If
	End If
End Sub
#End Region


private Sub PopUpMenu_LAbel_Click
	ShowMenuOnLabel(Sender)
End Sub

private Sub ShowMenuOnLabel (TargetLabel As View)
	Dim ctxt As JavaObject
	ctxt.InitializeContext
    
	Dim popup As JavaObject
	popup.InitializeNewInstance("android.widget.PopupMenu", Array(ctxt, TargetLabel))
    
	Dim menu As JavaObject = popup.RunMethod("getMenu", Null)
	PopUpTag=TargetLabel.Tag
	Dim tags() As Object=TargetLabel.Tag
	Dim poplist As List =tags(2)
	Dim TextSize As Int =tags(3)
	Dim Text As String
	
	Dim cs As CSBuilder
	For i=0 To poplist.size-1
		cs.Initialize
		Text=poplist.get(i).As(String)
		If Text<>"" Then
			cs.Typeface(Typeface.DEFAULT).Size(TextSize).Append(Text) '.Color(TextColor)
		End If
		cs.PopAll
		menu.RunMethod("add", Array As Object(0, i, 0, cs))
	Next
    
	Dim listener As Object = popup.CreateEventFromUI("android.widget.PopupMenu$OnMenuItemClickListener", "MenuClick", False)
	popup.RunMethod("setOnMenuItemClickListener", Array(listener))
    
	popup.RunMethod("show", Null)
End Sub

private Sub MenuClick_Event (MethodName As String, Args() As Object) As Boolean
	If MethodName = "onMenuItemClick" Then
		Dim menuItem As JavaObject = Args(0)
        
		Dim selectedText As String = menuItem.RunMethod("getTitle", Null)
		Dim selectedIndex As Int = menuItem.RunMethod("getItemId", Null)
        
		Dim tags() As Object=PopUpTag
		Dim Event As String=tags(0)
		Dim view As B4XView=tags(1)
		Private jo As JavaObject = view
		Dim MeView As Object = GetType(jo.RunMethod("getContext", Null))
		Dim MainName As String=MeView.as(String).SubString2(MeView.as(String).LastIndexOf(".")+1,MeView.as(String).Length)
		If Event.As(String).trim<>"" Then
			Dim Main_ItemClick As String =Event & "_SelectedIndexChanged"
			If SubExists(MainName, Main_ItemClick) Then
				CallSub3(MainName, Main_ItemClick, selectedIndex,selectedText)
			Else
			#if DEBUG 
				LogColor("Private Sub " & Main_ItemClick &" (Index As Int, Value As String) '⚠ --- " & " NOT found in " & MainName,LogColor_Warning)
			#End If
			End If
		End If        
		Return True
	End If
    
	Return False
End Sub
