B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#DesignerProperty: Key: itemHeight, DisplayName: Item height, FieldType: float, DefaultValue: 35
#Event:click(anode as spjsonnode)
#Event:longlick(anode as spjsonnode)
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private fxui As XUI 'ignore
	Public Tag As Object
	Private fPanelTouch As B4XView
	Private fLabelScrollBar As B4XView
	Private fPanelScrollBarTouch As B4XView
	Private fGestureDetector As GestureDetector
	Private fItemHeight As Float
	Private fTypeRadius As Float
	Private fTypeCenterX As Float
	Private fTypeCenterY As Float
	Private fTextLeftMargin As Float
	Private fFontSize As Float
	Private fIndentSize As Float
	Private fNode As spJsonNode
	Private fTypes As List
	Private fFirstRow As Int
	Private fB4XCanvas As B4XCanvas
	Private fCount As Int
	Private fIndex As Int
	Private fOdd As Boolean
	Private fTop As Float
	Private fInertie As Boolean=False
	Private fLabelLoading As B4XView
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	Sleep(0)
	mBase.LoadLayout("spjson")
	Sleep(0)
	fB4XCanvas.Initialize(fPanelTouch)
	fNode=createNode(Null,True,"Root",0,Null)
	fTypes.Initialize
	fItemHeight=Props.Get("itemHeight")*1dip
	calcSizes
	fGestureDetector.SetOnGestureListener(fPanelTouch,"gd")
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

'calc differents size according item height
private Sub calcSizes
	fTypeRadius=fItemHeight/2-2dip
	fTypeCenterX=fItemHeight/2
	fTypeCenterY=fItemHeight/2
	fTextLeftMargin=fItemHeight/4
	fFontSize=fItemHeight/3/1dip
	fIndentSize=fItemHeight/3
End Sub

public Sub s_itemHeight(avalue As Float) As spJson
	fItemHeight=avalue*1dip
	calcSizes
	draw
	Return Me
End Sub

public Sub g_itemHeight As Float
	Return fItemHeight/1dip
End Sub

'draw type in circle
private Sub draw_type(atop As Float,anode As spJsonNode,atext As String)
	Dim fd As B4XFont=fxui.CreateDefaultFont(fFontSize)
	Dim s As String=atext
	Dim r As B4XRect=fB4XCanvas.MeasureText(s,fd)
	Dim BaseLine As Float=fTypeCenterY-r.Height/2-r.Top
	fB4XCanvas.DrawText(s,anode.g_indent*fIndentSize+fTypeCenterX-r.Width/2,atop+BaseLine,fd,fxui.Color_white,"LEFT")
End Sub

'draw symbole expanded/collapsed in circle
private Sub draw_expandable(atop As Float,anode As spJsonNode)
	Dim fa As B4XFont=fxui.CreateFontAwesome(fFontSize)
	Dim s As String=IIf(anode.g_Expanded,Chr(0xF0DD),Chr(0xF0DA))
	Dim r As B4XRect=fB4XCanvas.MeasureText(s,fa)
	Dim BaseLine As Float=fTypeCenterY-r.Height/2-r.Top
	fB4XCanvas.DrawText(s,anode.g_indent*fIndentSize+fTypeCenterX-r.Width/2,atop+BaseLine,fa,fxui.Color_White,"LEFT")
End Sub

'draw type integer in circle
private Sub draw_integer(atop As Float,anode As spJsonNode)
	draw_type(atop,anode,"123")
End Sub

'draw type decimal in circle
private Sub draw_decimal(atop As Float,anode As spJsonNode)
	draw_type(atop,anode,"1.2")
End Sub

'draw type string in circle
private Sub draw_string(atop As Float,anode As spJsonNode)
	draw_type(atop,anode,"Abc")
End Sub

'draw type null in circle
private Sub draw_null(atop As Float,anode As spJsonNode)
	draw_type(atop,anode,"null")
End Sub

'draw type boolean in circle
private Sub draw_boolean(atop As Float,anode As spJsonNode)
	Dim fa As B4XFont=fxui.CreateFontAwesome(fFontSize)
	Dim s As String=Chr(0xF046)
	Dim r As B4XRect=fB4XCanvas.MeasureText(s,fa)
	Dim BaseLine As Float=fTypeCenterY-r.Height/2-r.Top
	fB4XCanvas.DrawText(s,anode.g_indent*fIndentSize+fTypeCenterX-r.Width/2,atop+BaseLine,fa,fxui.Color_white,"LEFT")
End Sub

'draw type array in circle
private Sub draw_Array(atop As Float,anode As spJsonNode)
	draw_type(atop,anode,"[   ]")
	draw_expandable(atop,anode)
End Sub

'draw type object in circle
private Sub draw_Object(atop As Float,anode As spJsonNode)
	draw_type(atop,anode,"{   }")
	draw_expandable(atop,anode)
End Sub

'draw name and value
private Sub draw_namevalue(atop As Float,anode As spJsonNode)
	Dim fd As B4XFont=fxui.CreatedefaultFont(fFontSize)
	Dim s As String=anode.g_name
	Dim r As B4XRect=fB4XCanvas.MeasureText(s,fd)
	Dim BaseLine As Float=fTypeCenterY/2-r.Height/2-r.Top
	fB4XCanvas.DrawText(s,anode.g_indent*fIndentSize+fTypeCenterX+fTypeRadius+fTextLeftMargin,atop+BaseLine,fd,fxui.Color_Black,"LEFT")
	Dim fb As B4XFont=fxui.CreatedefaultboldFont(fFontSize)
	Dim s As String=anode.g_value
	Dim r As B4XRect=fB4XCanvas.MeasureText(s,fb)
	Dim BaseLine As Float=fItemHeight/4*3-r.Height/2-r.Top
	fB4XCanvas.DrawText(s,anode.g_indent*fIndentSize+fTypeCenterX+fTypeRadius+fTextLeftMargin,atop+BaseLine,fb,fxui.Color_Black,"LEFT")
End Sub

'draw name
private Sub draw_name(atop As Float,anode As spJsonNode)
	Dim fd As B4XFont=fxui.CreatedefaultFont(fFontSize)
	Dim s As String=anode.g_name
	Dim r As B4XRect=fB4XCanvas.MeasureText(s,fd)
	Dim BaseLine As Float=fTypeCenterY-r.Height/2-r.Top
	fB4XCanvas.DrawText(s,anode.g_indent*fIndentSize+fTypeCenterX+fTypeRadius+fTextLeftMargin,atop+BaseLine,fd,fxui.Color_Black,"LEFT")
End Sub

'draw a node
private Sub draw_node(anode As spJsonNode)
	Dim r As B4XRect
	r.Initialize(0,fTop,fPanelTouch.Width,fTop+fItemHeight)
	fB4XCanvas.DrawRect(r,IIf(fOdd,fxui.Color_ARGB(255,230,230,230),fxui.Color_ARGB(255,250,250,250)),True,0)
	Dim x As Float=anode.g_indent*fIndentSize+fTypeCenterX
	Dim y As Float=fTop+fTypeCenterY
	Dim s As Float=fTypeRadius
	fB4XCanvas.DrawCircle(x,y,s,anode.g_color,True,0)
	fTypes.Add(CreateMap("x":x,"y":y,"s":s,"node":anode))
	CallSub3(Me,"draw_"&anode.g_Type,fTop,anode)
	CallSub3(Me,"draw_"&IIf(anode.g_hasValue,"namevalue","name"),fTop,anode)
	fTop=fTop+fItemHeight
	fIndex=fIndex+1
	fOdd=Not(fOdd)
End Sub

private Sub drawItem(anode As spJsonNode)
	If (fIndex>=fFirstRow) And (fTop<fPanelTouch.Height) Then
		draw_node(anode) 
	End If
	If anode.g_IsExpandable And anode.g_Expanded Then
		For Each n As spJsonNode In anode.g_children
			fIndex=fIndex+1
			drawItem(n)
		Next
	End If
End Sub

private Sub draw
	fB4XCanvas.ClearRect(fB4XCanvas.TargetRect)
	If fCount>0 Then
		fOdd=False
		fTypes.clear
		fIndex=0
		fTop=0
		drawItem(fNode)
		fLabelScrollBar.Top=fFirstRow*(fPanelScrollBarTouch.Height-fLabelScrollBar.Height)/fCount
	End If
	fB4XCanvas.invalidate
End Sub

public Sub load(ajson As String) As ResumableSub
	fLabelLoading.Visible=True
	fFirstRow=0
	Try
		Dim m As Map=ajson.As(JSON).ToMap
		fNode=createNode(Null,True,"Root",0,m)
	Catch
		Try
			Dim l As List=ajson.As(JSON).Tolist
			fNode=createNode(Null,True,"Root",0,l)
		Catch
			fLabelLoading.Visible=False
			Return False
		End Try
	End Try
	Try
		wait for (CallSub2(Me,"loadNode_"&fNode.g_Type,fNode)) complete(rb As Boolean)
		fCount=count(fNode)
		draw
		fLabelLoading.Visible=False
		Return rb
	Catch
		fLabelLoading.Visible=False
		Return False
	End Try
End Sub

private Sub loadNode_array(anode As spJsonNode) As ResumableSub
	Dim v As List=anode.G_value
	For i=0 To v.Size-1
		Dim o As Object=v.Get(i)
		Dim n As spJsonNode=createNode(anode,False,i,anode.G_indent+1,o)
		anode.g_children.Add(n)
		If n.g_IsExpandable Then
			wait for (CallSub2(Me,"loadNode_"&n.g_Type,n)) complete(rb As Boolean)
		End If
		Sleep(0)
	Next
	Return True
End Sub

private Sub loadNode_object(anode As spJsonNode) As ResumableSub
	Dim v As Map=anode.G_value
	For Each s As String In v.keys
		Dim o As Object=v.Get(s)
		Dim n As spJsonNode=createNode(anode,False,s,anode.g_indent+1,o)
		anode.g_children.Add(n)
		If n.g_IsExpandable Then
			wait for (CallSub2(Me,"loadNode_"&n.g_Type,n)) complete(rb As Boolean)
		End If
		Sleep(0)
	Next
	Return True
End Sub

'create a node (spJsonNode)
private Sub createNode(aparent As spJsonNode,aexpanded As Boolean,aname As String,aindent As Int,avalue As Object) As spJsonNode
	Dim n As spJsonNode
	Return n.Initialize.s_Parent(aparent).s_Expanded(aexpanded).s_Name(aname).s_Indent(aindent).s_Value(avalue)
End Sub

'count visible nodes
private Sub count(anode As spJsonNode) As Int
	Dim c As Int=1
	If anode.g_IsExpandable And anode.g_Expanded Then
		For Each n As spJsonNode In anode.g_children
			c=c+count(n)
		Next
	End If
	Return c
End Sub

private Sub collapseAll(anode As spJsonNode)
	anode.s_Expanded(False)
	For Each n As spJsonNode In anode.g_children
		If n.g_IsExpandable Then
			collapseAll(n)
		End If
	Next
End Sub

private Sub expandAll(anode As spJsonNode)
	anode.s_Expanded(True)
	For Each n As spJsonNode In anode.g_children
		If n.g_IsExpandable Then
			expandAll(n)
		End If
	Next
End Sub

'toggle expanded/collapsed
private Sub toggle(anode As spJsonNode)
	anode.s_Expanded(Not(anode.g_Expanded))
End Sub

'click/lonclick on a circle, toggle/expandAll/CollapseAll
private Sub touchOnCircle(anode As spJsonNode,alongclick As Boolean)
	If anode.g_IsExpandable Then
		If alongclick Then
			If anode.g_Expanded Then
				collapseAll(anode)
			Else
				expandAll(anode)
			End If
		Else
			toggle(anode)
		End If
		fCount=count(fNode)
		draw
	End If
End Sub

Private Sub touchOnName(anode As spJsonNode,alongclick As Boolean)
	Dim s As String=mEventName&"_"&IIf(alongclick,"longclick","click")
	If SubExists(mCallBack,s) Then
		CallSub2(mCallBack,s,anode)
	End If
End Sub

private Sub checkTouchXY(ax As Float,ay As Float,alongclick As Boolean)
	For i=0 To fTypes.Size-1
		Dim m As Map=fTypes.Get(i)
		Dim x As Float=m.Get("x")
		Dim y As Float=m.Get("y")
		Dim s As Float=m.Get("s")
		
		'touch on a circle
		If  (ax>=x-s) And (ax<=x+s) And (ay>=y-s) And (ay<=y+s) Then
			touchOnCircle(m.Get("node"),alongclick)
			Return
		End If
		
		'touch on name/value
		If  (ax>=x+s*2) And (ay>=y-s) And (ay<=y+s) Then
			touchOnName(m.Get("node"),alongclick)
			Return
		End If
	Next
End Sub

Private Sub gd_onTouch(Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean
	fInertie=False
	Return True
End Sub

private Sub gd_onSingleTapConfirmed(X As Float, Y As Float, MotionEvent As Object)
	checkTouchXY(X,Y,False)
End Sub

private Sub gd_onLongPress(X As Float, Y As Float, MotionEvent As Object)
	Dim v As PhoneVibrate
	v.Vibrate(150)
	checkTouchXY(X,Y,True)
End Sub

Private Sub gd_onScroll(distanceX As Float, distanceY As Float, MotionEvent1 As Object, MotionEvent2 As Object)
	If Abs(distanceY)<5dip Then
		Return
	End If
	fFirstRow=Max(0,Min(fCount-1,fFirstRow+IIf(distanceY>0,1,-1)))
	draw
End Sub

Private Sub gd_onFling(velocityX As Float, velocityY As Float, MotionEvent1 As Object, MotionEvent2 As Object)
	fInertie=True
	Do While fInertie And Abs(velocityY)>1dip
		fFirstRow=Max(0,Min(fCount-1,fFirstRow+IIf(velocityY<0,1,-1)))
		draw
		velocityY=velocityY*0.75
		Sleep(10)
	Loop
	fInertie=False
End Sub

Private Sub fPanelScrollBarTouch_Touch(Action As Int, X As Float, Y As Float)
	Select Case Action
		Case 0
			fLabelScrollBar.Top=Min(Max(0,Y),fPanelScrollBarTouch.Height-fLabelScrollBar.Height)
			fFirstRow=fCount*fLabelScrollBar.Top/(fPanelScrollBarTouch.Height-fLabelScrollBar.Height)
			draw
		Case 2
			fLabelScrollBar.Top=Min(Max(0,Y),fPanelScrollBarTouch.Height-fLabelScrollBar.Height)
			fFirstRow=(fCount-1)*fLabelScrollBar.Top/(fPanelScrollBarTouch.Height-fLabelScrollBar.Height)
			draw
	End Select
End Sub