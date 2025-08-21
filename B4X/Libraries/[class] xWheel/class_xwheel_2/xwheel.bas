B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
#Event: scroll(Index As Int, value As String)

#DesignerProperty: Key: ItemHeight, DisplayName: item height, FieldType: Int, DefaultValue: 25, Description : item height
#DesignerProperty: Key: nbitem, DisplayName: number of items, FieldType: Int, DefaultValue: 7,MinRange: 1, Description : number of visible items.
#DesignerProperty: Key: Itemtextsize, DisplayName: items textsize, FieldType: Int, DefaultValue: 14, Description : 
#DesignerProperty: Key: borderwidth, DisplayName: border width, FieldType: Int, DefaultValue: 5,MinRange: 0, Description
#DesignerProperty: Key: bordercolor, DisplayName: border Color, FieldType: Color, DefaultValue: 0xD3D3D3, Description: 
#DesignerProperty: Key: textcolor, DisplayName: items text Color, FieldType: Color, DefaultValue: 0x000000, Description: 

Sub Class_Globals
	Private mCallback As Object
	Private mEventName As String
	Private xui As XUI
	Private mBase As B4XView
	
	Private panel3,panel1,panel2 As B4XView
	
	Private xwh As Int
	Private npos As Double
	Private pos As Double
	Private find As Int
	
	Private xwhd As Int
	Private nbd As Int
	
	Private timer1 As Timer
	Private sv1 As ScrollView
	Private mxwlist As List
	
	Private CLV1 As CustomListView

	Private mItemHeight As Int
	Private mnbitem As Int	
	Private mborderw As Int
	Private mTextSize As Int
	Private mborderColor As Int
	Private mtextcolor As Int
	
	Private xwleft As Int,xwtop As Int,xwwidth As Int
	
	Private mitem As xwtlist
	
	Type xwtlist(text As String,val As String)
End Sub

Public Sub  Initialize (Callback As Object, EventName As String)
		
	mCallback=Callback
	mEventName=EventName
	
End Sub

Public Sub DesignerCreateView (Base As Panel, lbl As Label , Props As Map)
	mBase = Base
	Sleep(0)
	mBase.LoadLayout("xwheeltemplate")
	
	CLV1.PressedColor=xui.Color_Transparent
	CLV1.AnimationDuration=300
	
	Dim devicescale As Double =100dip/100	
	mItemHeight =Props.Get("ItemHeight")*devicescale
	mnbitem=Props.get("nbitem")
	xwh=mItemHeight*mnbitem
	mTextSize=Props.Get("Itemtextsize")
	mborderw= Props.Get("borderwidth")*devicescale
	mborderColor= xui.PaintOrColorToColor(Props.Get("bordercolor"))
	mtextcolor= xui.PaintOrColorToColor(Props.Get("textcolor"))
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	If CLV1.IsInitialized Then
		CLV1.AsView.SetLayoutAnimated(300, mborderw,mborderw, Width-2*mborderw, Height)
		CLV1.Base_Resize(Width-2*mborderw, Height)
	End If
	
End Sub

Public Sub initxwheel(xwlist As List)
	Sleep(0)
	mxwlist=xwlist
	timer1.initialize("timer1", 200)
	timer1.Enabled = False
	
	
	nbd= Floor(mnbitem/2)
	xwh=mItemHeight*mnbitem
	xwhd=mItemHeight*nbd
	
	xwwidth=mBase.Width-2*mborderw
	xwleft=mborderw
	xwtop=mborderw
		
	panel3 = xui.CreatePanel("")
	panel3.SetColorAndBorder(mborderColor,2dip,xui.Color_Black,5dip)
	CLV1.AsView.Parent.AddView(panel3,xwleft-mborderw,xwtop-mborderw,xwwidth+2*mborderw,xwh+2*mborderw)
	'mBase.AddView(panel3,xwleft-mborderw,xwtop-mborderw,xwwidth+2*mborderw,xwh+2*mborderw)
	
	panel1 = xui.CreatePanel("")
	panel3.AddView(panel1,mborderw,mborderw,xwwidth,xwh)
	Dim colorgris As Int= xui.Color_RGB(96,96,96)'RGB(80,80,80)
	Dim clr() As Int = Array  As Int(colorgris,xui.Color_white,colorgris)
	SetGradientBackground(panel1, clr, "TOP_BOTTOM")
		
	CLV1.AsView.RemoveViewFromParent
	panel1.AddView(CLV1.AsView,0,0,xwwidth,xwh)
	sv1=CLV1.sv
	sv1.Panel.Color = xui.Color_Transparent
	sv1.Height=xwh
	
	panel2=xui.CreatePanel("")
	panel1.AddView(panel2,1dip,xwhd,panel1.Width-2dip,mItemHeight)
	panel2.SetColorAndBorder(xui.Color_ARGB(32,0,0,255),2dip,xui.Color_Black,5dip)
	panel3.SendToBack
	panel2.BringToFront
	
	updateitems(mxwlist)
End Sub

Sub SetGradientBackground(pnl As B4XView, Clrs() As Int, Orientation As String)
	Dim bc As BitmapCreator
	bc.Initialize(pnl.Width / xui.Scale, pnl.Height / xui.Scale)
	bc.FillGradient(Clrs, bc.TargetRect, Orientation)
	Dim iv As ImageView
	iv.Initialize("")
	Dim xiv As B4XView = iv
	pnl.AddView(xiv, 0, 0, pnl.Width, pnl.Height)
	xiv.SendToBack
	bc.SetBitmapToImageView(bc.Bitmap, xiv)
End Sub

private Sub CreateListItem(Text As String, Width As Int, Height As Int) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	Dim l As Label
	l.Initialize("L")
	Dim xl As B4XView = l
	p.SetLayoutAnimated(0, 0, 0, Width, Height)
	p.Color=xui.Color_Transparent
	'l.Initialize("L")
	xl.SetTextAlignment("CENTER", "CENTER")
	p.AddView(xl, 0, 0, Width, Height)
	xl.color=xui.Color_Transparent
	xl.TextColor=mtextcolor
	xl.TextSize=mTextSize
	xl.Text = Text
	Return p
End Sub

'update the items
Public Sub updateitems( nlist As List)
	If CLV1.Size<>0 Then CLV1.Clear
	For i = 1 To nbd
		CLV1.Add(CreateListItem("", CLV1.AsView.Width,mItemHeight), "0")
	Next
	
	For i=0 To nlist.Size-1
		mitem.Initialize
		mitem=nlist.Get(i)
		CLV1.Add(CreateListItem(mitem.text, CLV1.AsView.Width, mItemHeight),mitem.val)
	Next
	
	For i = 1 To nbd
		CLV1.Add(CreateListItem("", CLV1.AsView.Width,mItemHeight),"0")
	Next
End Sub


public Sub CLV1_ScrollChanged (offset As Int)
	pos=offset
	npos =mItemHeight* Floor((pos/mItemHeight)+0.5)
	timer1.Enabled=True
End Sub

private Sub timer1_tick
	Dim indc As Int
	Dim val As String
	CLV1.sv.ScrollViewOffsetY=npos
	find=CLV1.FindIndexFromOffset(npos)
	indc=find+nbd
	val=CLV1.GetValue(indc)
	timer1.Enabled =  False
	If xui.SubExists(mCallback,mEventName & "_scroll",2) Then
		CallSub3(mCallback, mEventName & "_scroll", find+1, val)
	End If
End Sub

'jump to item index (base 1)
Public Sub setItemIndex(index As Int)
	Sleep(0)
	If index<1 Or index>CLV1.Size Then Return
	CLV1.JumpToItem(index-1)
End Sub


'