B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@

#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-Add RemovePageAt
V1.02
	-Add Clear
#End If

#DesignerProperty: Key: SideGap, DisplayName: SideGap, FieldType: Int, DefaultValue: 80, MinRange: 0, Description: The width in dip, how much should the next item be visible. e.g. 80dip left and 80dip right
#DesignerProperty: Key: LazyLoading, DisplayName: Lazy Loading, FieldType: Boolean, DefaultValue: False, Description: activates lazy loading
#DesignerProperty: Key: LazyLoadingExtraSize, DisplayName: Lazy Loading Extra Size, FieldType: Int, DefaultValue: 10, MinRange: 0
#DesignerProperty: Key: LoadingPanelColor, DisplayName: Loading Panel Color, FieldType: Color, DefaultValue: 0xFF131416, Description: The color of the Loading panel if Base_Resize is executed

#Event: PageChanged(OldIndex As Int, NewIndex As int)
#Event: LazyLoadingAddContent(Parent As B4XView, Value As Object)

Sub Class_Globals
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	
	
	#If B4A or B4I
	Private xclv_Main As CustomListView
	#End If
	Private xpnl_Loading As B4XView
	#If B4J
	Private xpnl_Pager As B4XView
	#Else
	Private xpnl_clv_background As B4XView
	#End If
	
		#If B4I 
	Private nome As NativeObject=Me
	Private mView As View
	#end if
	
	'Properties
	Private m_LazyLoading As Boolean
	Private m_LazyLoadingExtraSize As Int
	Private m_LoadingPanelColor As Int

	Private g_CornerRadius As Float

	Private m_Index As Int = 1

	Private m_ItemWidth As Float
	Private m_SideGap As Float
	Private g_x As Float 'Ignore
	Private isfirstmove As Boolean 'Ignore
	Private m_LastIndex As Int
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
	
	ini_props(Props)

	#If B4J
	xpnl_Pager = xui.CreatePanel("xpnl_Pager")
	mBase.AddView(xpnl_Pager,0,0,0,mBase.Height)
	Dim r As Reflector
	r.Target = xpnl_Pager
	r.AddEventFilter("et", "javafx.scene.input.KeyEvent.KEY_PRESSED")
	r.AddEventFilter("et", "javafx.scene.input.KeyEvent.KEY_RELEASED")
	#Else
	xpnl_clv_background = xui.CreatePanel("")
	mBase.AddView(xpnl_clv_background,0,0,0,0)
	#End If
	
	xpnl_Loading = xui.CreatePanel("")
	mBase.AddView(xpnl_Loading,0,0,mBase.Width,mBase.Height)
	xpnl_Loading.Color = m_LoadingPanelColor
	xpnl_Loading.BringToFront
	
	m_ItemWidth = mBase.Width - (m_SideGap*2)

	#If B4A or B4I
	ini_xclv
	#End If

	AddPlaceholder
	AddPlaceholder

	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If

End Sub

Private Sub ini_props(Props As Map)
	m_SideGap = DipToCurrent(Props.GetDefault("SideGap",80dip))
	m_LazyLoading = Props.GetDefault("LazyLoading",False)
	m_LazyLoadingExtraSize = Props.GetDefault("LazyLoadingExtraSize",5)
	m_LoadingPanelColor = xui.PaintOrColorToColor(Props.GetDefault("LoadingPanelColor",xui.Color_Black))
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	mBase.SetLayoutAnimated(0,mBase.Left,mBase.Top,Width,Height)
	mBase.SetColorAndBorder(mBase.Color,0,xui.Color_Transparent,g_CornerRadius)
	SetCircleClip(mBase,g_CornerRadius)
	
  	#If B4J
	xpnl_Pager.Height = Height
	
	xpnl_Pager.GetView(m_Index).Height = Height
	
	For i = 0 To xpnl_Pager.NumberOfViews -1
		xpnl_Pager.GetView(i).Height = Height
	Next
	#Else
	xpnl_clv_background.SetLayoutAnimated(0,0,0,Width,Height)
	#End If
	
 
	'If xpnl_clv_background.Color = 0 Then
	'setBackgroundColor(g_BackgroundColor)
	'End If
	
	Sleep(250)
	xpnl_Loading.SetVisibleAnimated(500,False)
	
End Sub

#If B4A or B4I
Private Sub ini_xclv
	Dim xpnl_base As B4XView = xui.CreatePanel("")
	xpnl_base.Color = xui.Color_Transparent
	xpnl_clv_background.AddView(xpnl_base,0,0,mBase.Width,mBase.Height)
	
	Dim tmplbl As Label
	tmplbl.Initialize("")
 
	Dim tmpmap As Map
	tmpmap.Initialize
	tmpmap.Put("DividerColor",0x00FFFFFF)
	tmpmap.Put("DividerHeight",0)
	tmpmap.Put("PressedColor",0x00FFFFFF)
	tmpmap.Put("InsertAnimationDuration",0)
	tmpmap.Put("ListOrientation","Horizontal")
	tmpmap.Put("ShowScrollBar",False)
	xclv_Main.Initialize(Me,"xclv")
	xclv_Main.DesignerCreateView(xpnl_base,tmplbl,tmpmap)
	
	#IF B4A
	Private objPages As Reflector
	objPages.Target = xclv_Main.sv
	objPages.SetOnTouchListener("xpnl_PageArea2_Touch")
	#Else IF B4I	
	mView=xclv_Main.GetBase
	nome.RunMethod("grPan:::",Array(mView,1,1))
	#Else IF B4J

	#End if
	
'	#If B4I
'	Dim sv As ScrollView = xclv_Main.sv
'	sv.Color = g_BackgroundColor
'	#End If
	
End Sub
#End If

Public Sub AddPage(LayoutPanel As B4XView,Value As Object)
	
	#If B4J
	jPager_AddPageAt(xpnl_Pager.NumberOfViews -1,LayoutPanel,Value)
	If m_LazyLoading Then jPager_LazyLoading
	#Else
	xclv_Main.InsertAt(xclv_Main.Size -1,LayoutPanel,Value)
	#End If
End Sub

Public Sub RemovePageAt(Index As Int)
	
	#If B4J
	xpnl_Pager.GetView(Index +1).RemoveViewFromParent
	
	'Refresh all other panels
	
	xpnl_Pager.Width = 0
	For i = 0 To xpnl_Pager.NumberOfViews -1
		
		xpnl_Pager.GetView(i).Left = IIf(i = 0,0,xpnl_Pager.GetView(i-1).Left + xpnl_Pager.GetView(i-1).Width)
		xpnl_Pager.Width = xpnl_Pager.Width + xpnl_Pager.GetView(i).Width
		
	Next
	
	If m_Index >= Index Then
		m_Index = m_Index -1
		xpnl_Pager.Left =	-(xpnl_Pager.GetView(m_Index).Left - (m_SideGap-10dip))
		PageChanged
	End If
	
	#Else
	xclv_Main.RemoveAt(Index +1)
	#End If
	
End Sub

Public Sub Clear
	
	setItemWidth(m_ItemWidth)
	m_Index = 1
	m_LastIndex = 1
	
	#If B4J
	xpnl_Pager.Left = -(xpnl_Pager.GetView(0).Left - (-10dip))
	#End If
	
End Sub

Private Sub AddPlaceholder
	Dim xpnl_bottom As B4XView = xui.CreatePanel("")
	xpnl_bottom.SetLayoutAnimated(0,0,0,m_SideGap - 0dip,mBase.Height)
	xpnl_bottom.Color = mBase.Color
	#If B4A or B4I
	xclv_Main.Add(xpnl_bottom,"Placeholder")
	#Else
	jPager_AddPage(xpnl_bottom,"Placeholder")
	#End If
End Sub

#If B4A
Private Sub xpnl_PageArea2_Touch(ViewTag As Object, Action As Int, X As Float, y As Float, MotionEvent As Object) As Boolean
	Return HandleTouch(Action,x,y)
End Sub
#End If

#If B4A or B4I
#If B4A
Private Sub HandleTouch(Action As Int,x As Float,y As Float) As Boolean 'ignore
#Else If B4I
Private Sub HandleTouch(Action As Int,x As Float,y As Float) As ResumableSub'ignore
	'Sleep(0)
#End If
	Select Action
		Case 2

			If isfirstmove = False Then
				isfirstmove = True
			g_x=X
			End If

		Case 1

			isfirstmove = False
			m_LastIndex = m_Index
			If g_x < x Then
				m_Index = Max(1,m_Index -1)
			Else
				m_Index = Min(xclv_Main.Size -2, m_Index +1)
			End If	
			SnapCLV
			Return True

	End Select
	Return False
End Sub
#End If

#If B4I

Private Sub uigesture_longpress(state As Int,numtouch As Int, Numtaps As Int, x As Float, y As Float, obj As Object)

	If state = 1 Then'tmp.STATE_Begin Then
		HandleTouch(2,x,y)
	'	Log("longpress")
		'TouchEndEvent
	End If

End Sub

Private Sub uigesture_pan(state As Int,x As Float, y As Float, obj As Object)

	Select state
		Case 2 'STATE_Changed
			HandleTouch(2,x,y)
		Case 3 'STATE_End
			HandleTouch(1,x,y)
	End Select
	
End Sub

#End If

#Region Properties

'sets the corner radius of the view
Public Sub setCornerRadius(Radius As Int)
	mBase.SetColorAndBorder(mBase.Color,0,xui.Color_Transparent,Radius)
	g_CornerRadius = Radius
	SetCircleClip(mBase,g_CornerRadius)
End Sub

'If you set this, then it overrides the SideGap property
'The SideGap is calculated automatically
'Set this,before you add pages
Public Sub getItemWidth As Float
	Return m_ItemWidth
End Sub

Public Sub setItemWidth(Width As Float)
	m_ItemWidth = Width
	m_SideGap = (mBase.Width - m_ItemWidth)/2
	
	#If B4J
	xpnl_Pager.RemoveAllViews
	xpnl_Pager.Width = 0
	xpnl_Pager.Left = 0
	#Else
	xclv_Main.Clear
	#End If
	
	AddPlaceholder
	AddPlaceholder
End Sub

Public Sub NextPage
	#If B4A or B4I
	If m_Index < xclv_Main.Size -2 Then
	#Else
	If m_Index < xpnl_Pager.NumberOfViews -2 Then
	#End If
		m_LastIndex = m_Index
		m_Index = m_Index +1
		SnapCLV
	End If
End Sub

Public Sub PreviousPage
	If m_Index > 1 Then
		m_LastIndex = m_Index
		m_Index = m_Index -1
		SnapCLV
	End If
End Sub

Public Sub Refresh
	Base_Resize(mBase.Width,mBase.Height)
End Sub

#If B4A or B4I
'Refresh the visible area
Public Sub RefreshLite
		For z = 1 To xclv_Main.Size -2
			xclv_Main.GetPanel(z).RemoveAllViews
		Next
		xclv_Main.Refresh
End Sub
#End If

#If B4A or B4I
Public Sub getCustomListView As CustomListView
	Return xclv_Main
End Sub
#End If

'gets the base view (mBase)
Public Sub getBase As B4XView
	Return mBase
End Sub

'gets the selected index
Public Sub getIndex As Int
		Return m_Index -1
End Sub

Public Sub setIndex(Index As Int)
	m_LastIndex = m_Index
	m_Index = Index +1
	SnapCLV
End Sub

Public Sub GetValue(Index As Int) As Object
	Index = Index +1
	#If B4J
	Return xpnl_Pager.GetView(Index).Tag
	#Else
	Return xclv_Main.GetValue(Index)
	#End If
End Sub

Public Sub getSize As Int
	#If B4A or B4I
	Return xclv_Main.Size -2
	#Else
	Return xpnl_Pager.NumberOfViews -2
	#End If
End Sub

'The color of the Loading panel If Base_Resize Is executed
Public Sub setLoadingPanelColor(Color As Int)
	m_LoadingPanelColor = Color
	xpnl_Loading.Color = Color
End Sub

Public Sub getLoadingPanelColor As Int
	Return m_LoadingPanelColor
End Sub

Public Sub setLazyLoadingExtraSize(ExtraSize As Int)
	m_LazyLoadingExtraSize = ExtraSize
End Sub

Public Sub getLazyLoadingExtraSize As Int
	Return m_LazyLoadingExtraSize
End Sub

Public Sub setLazyLoading(Enabled As Boolean)
	m_LazyLoading = Enabled
End Sub

Public Sub GetPanel(Index As Int) As B4XView
	Index = Index +1
	#If B4J
	Return xpnl_Pager.GetView(Index)
	#Else
	Return xclv_Main.GetPanel(Index)
	#End If
End Sub

#End Region

#Region Events

Private Sub LazyLoadingAddContent(Parent As B4XView,Value As Object)
	If xui.SubExists(mCallBack, mEventName & "_LazyLoadingAddContent", 2) Then
		CallSub3(mCallBack, mEventName & "_LazyLoadingAddContent",Parent,Value)
	End If
End Sub

Private Sub PageChanged
	If xui.SubExists(mCallBack, mEventName & "_PageChanged", 2) Then
		CallSub3(mCallBack, mEventName & "_PageChanged",Max(0,m_LastIndex-1).As(Int),(m_Index-1).As(Int))
	End If
End Sub

#End Region

#Region "Functions"

#If B4A or B4I

Private Sub xclv_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	Dim xclv As CustomListView = Sender
	If m_LazyLoading = False Then Return
	For i = 0 To xclv.Size - 1
		Dim p As B4XView = xclv.GetPanel(i)
		If i > FirstIndex - m_LazyLoadingExtraSize And i < LastIndex + m_LazyLoadingExtraSize Then
			'visible+
			If p.NumberOfViews = 0 Then
				If "Placeholder" <> xclv.GetValue(i) Then
					LazyLoadingAddContent(p,xclv.GetValue(i))
				End If
			End If
		Else
			'not visible
			If p.NumberOfViews > 0 Then
				p.RemoveAllViews '<--- remove the layout
			End If
		End If
	Next
End Sub

#End If

Private Sub SnapCLV
	If m_LastIndex <> m_Index Then PageChanged
	#If B4A or B4I
	Dim item As CLVItem	 = xclv_Main.GetRawListItem(m_Index)
	#If B4A
	xclv_Main.sv.As(HorizontalScrollView).ScrollPosition = item.Offset - (m_SideGap-0dip)
	#Else
	xclv_Main.sv.As(ScrollView).ScrollTo(item.Offset - (m_SideGap-0dip),0,True)
	#End If
	#Else
	jPager_SetIndexIntern(m_Index)
	#End if
	
End Sub

Private Sub SetCircleClip (pnl As B4XView,radius As Int)'ignore
#if B4J
Dim jo As JavaObject = pnl
Dim shape As JavaObject
Dim cx As Double = pnl.Width
Dim cy As Double = pnl.Height
shape.InitializeNewInstance("javafx.scene.shape.Rectangle", Array(cx, cy))
If radius > 0 Then
	Dim d As Double = radius
	shape.RunMethod("setArcHeight", Array(d))
	shape.RunMethod("setArcWidth", Array(d))
End If
jo.RunMethod("setClip", Array(shape))
#else if B4A
	Dim jo As JavaObject = pnl
	jo.RunMethod("setClipToOutline", Array(True))
#end if
End Sub

#End Region

#Region jPager

#If B4J

Private Sub jPager_AddPage(PagePanel As B4XView,Value As Object)
	PagePanel.Tag = Value
	xpnl_Pager.Width = xpnl_Pager.Width + PagePanel.Width
	xpnl_Pager.AddView(PagePanel,xpnl_Pager.Width - PagePanel.Width,0,PagePanel.Width,mBase.Height)
End Sub

Private Sub jPager_AddPageAt(Index As Int,PagePanel As B4XView,Value As Object)
	PagePanel.Tag = Value
	xpnl_Pager.Width = xpnl_Pager.Width + PagePanel.Width
	xpnl_Pager.As(Pane).InsertNode(Index,PagePanel,xpnl_Pager.Width - PagePanel.Width - xpnl_Pager.GetView(xpnl_Pager.NumberOfViews -1).Width,0,PagePanel.Width,mBase.Height)
	xpnl_Pager.GetView(xpnl_Pager.NumberOfViews -1).Left = xpnl_Pager.Width - xpnl_Pager.GetView(xpnl_Pager.NumberOfViews -1).Width
End Sub

Private Sub jPager_SetIndexIntern(NewIndex As Int)
	xpnl_Pager.SetLayoutAnimated(250,-(xpnl_Pager.GetView(NewIndex).Left - (m_SideGap-10dip)),xpnl_Pager.Top,xpnl_Pager.Width,xpnl_Pager.Height)
	If m_LazyLoading Then jPager_LazyLoading
End Sub

Private Sub jPager_LazyLoading
	For i = 0 To xpnl_Pager.NumberOfViews - 1
		Dim p As B4XView = xpnl_Pager.GetView(i)
		If i > m_Index - m_LazyLoadingExtraSize And i < m_Index + m_LazyLoadingExtraSize Then
			'visible+
			If p.NumberOfViews = 0 Then
				If i > 0 And i <= getSize Then
					LazyLoadingAddContent(p,xpnl_Pager.GetView(i).Tag)
				End If
			End If
		Else
			'not visible
			If p.NumberOfViews > 0 Then
				p.RemoveAllViews '<--- remove the layout
			End If
		End If
	Next
End Sub

Private Sub xpnl_Pager_MouseClicked (EventData As MouseEvent)
	xpnl_Pager.RequestFocus
End Sub

Private Sub xpnl_Pager_MouseEntered (EventData As MouseEvent)
	xpnl_Pager.RequestFocus
End Sub

Private Sub et_Filter (EventData As Event)
	Dim jo As JavaObject = EventData
	Dim code As String = jo.RunMethod("getCode", Null)
	Dim EventType As String = jo.RunMethod("getEventType", Null)

	If EventType = "KEY_RELEASED" Then
			If code = "RIGHT" Then
				NextPage
			Else If code = "LEFT" Then
				PreviousPage
			End If
	End If
End Sub

#End If

#End Region

#Region GestureRecongnizer

#If OBJC
/////////TAP//////////

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
     return TRUE;
}

-(void)grTap: (int)numtaps :(int)numtouch :(UIView*)v
{
UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
Tap.delegate=self;
[Tap setNumberOfTapsRequired:numtaps];
[Tap setNumberOfTouchesRequired:numtouch];


[v addGestureRecognizer:Tap];
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {  

float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;


	int st =gestureRecognizer.state;
    int numtouch =gestureRecognizer.numberOfTouchesRequired;
    int numtap =gestureRecognizer.numberOfTapsRequired;
    [self.bi raiseEvent:nil event:@"uigesture_tap::::::" params:@[@((int)st),@((int)numtap),@((int)numtouch),@((float)x),@((float)y),(gestureRecognizer)]];

  }  


////////////PINCH/////////////

-(void)grPinch :(UIView*)v
{
UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self  action:@selector(handlePinch:)];
 pinch.delegate=self;
 [v addGestureRecognizer:pinch];

}

- (void)handlePinch:(UIPinchGestureRecognizer *)gestureRecognizer 
{  

float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;

	float sc=gestureRecognizer.scale;
	float vl=gestureRecognizer.velocity;
	int st =gestureRecognizer.state;
    [self.bi raiseEvent:nil event:@"uigesture_pinch::::::" params:@[@((float)sc),@((float)vl),@((int)st),@((float)x),@((float)y),(gestureRecognizer)]];


  }  
  

  
  
//////// ROTATION /////////////

-(void)grRotation :(UIView*)v
{
UIRotationGestureRecognizer *Rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self  action:@selector(handleRotation:)];
 Rotation.delegate=self;
 [v addGestureRecognizer:Rotation];

}

- (void)handleRotation:(UIRotationGestureRecognizer *)gestureRecognizer 
{  

float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;

	float rt=gestureRecognizer.rotation;
	float vl=gestureRecognizer.velocity;
	int st =gestureRecognizer.state;
    [self.bi raiseEvent:nil event:@"uigesture_rotation::::::" params:@[@((float)rt),@((float)vl),@((int)st),@((float)x),@((float)y),(gestureRecognizer)]];


  }  
  
  
///////////// SWIPE //////////////

-(void)grSwipe :(UIView*)v :(int)numtouch :(int)dir
{
UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(handleSwipe:)];
 
// if (dir==1)
// {
  [swipe setDirection:dir];

// }
 
 
 [swipe setNumberOfTouchesRequired:numtouch];
  swipe.delegate=self;
 [v addGestureRecognizer:swipe];

}


- (void)handleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {  

float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;

	int st =gestureRecognizer.state;
	int dir=gestureRecognizer.direction;

    [self.bi raiseEvent:nil event:@"uigesture_swipe:::::" params:@[@((int)st),@((int)dir),@((float)x),@((float)y),(gestureRecognizer)]];

  }  

/////////// PAN ///////////

-(void)grPan :(UIView*)v :(int)mintouch :(int)maxtouch
{
UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self  action:@selector(handlePan:)];
 
 [pan setMaximumNumberOfTouches:maxtouch];
 [pan setMinimumNumberOfTouches:mintouch];
pan.delegate=self;
 [v addGestureRecognizer:pan];

}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {  

	int st =gestureRecognizer.state;
float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;

    [self.bi raiseEvent:nil event:@"uigesture_pan::::" params:@[@((int)st),@((float)x),@((float)y),(gestureRecognizer)]];

  }  

///////////// SCREEN EDGE ///////////

-(void)grScreenEdge :(UIView*)v :(int)dir 
{
UIScreenEdgePanGestureRecognizer *panEdge = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self  action:@selector(handlePanEdge:)];
 
 [panEdge setEdges:dir];
 [v addGestureRecognizer:panEdge];

}

- (void)handlePanEdge:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer {  

float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;

	int st =gestureRecognizer.state;
	int ed =[gestureRecognizer edges];
    [self.bi raiseEvent:nil event:@"uigesture_screenedgepan:::::" params:@[@((int)st),@((int)ed),@((float)x),@((float)y),(gestureRecognizer)]];

  }  
  
  
  
///////////LONG PRESS////////


-(void)grLongPress: (int)numtaps :(int)numtouch :(float)interval :(UIView*)v
{
UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];

[longpress setNumberOfTapsRequired:numtaps];
[longpress setNumberOfTouchesRequired:numtouch];
[longpress setMinimumPressDuration:interval];
longpress.delegate=self;
[v addGestureRecognizer:longpress];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {  

float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;

	int st =gestureRecognizer.state;
	int numtouch =gestureRecognizer.numberOfTouchesRequired;
    int numtap =gestureRecognizer.numberOfTapsRequired;
    [self.bi raiseEvent:nil event:@"uigesture_longpress::::::" params:@[@((int)st),@((int)numtouch),@((int)numtap),@((float)x),@((float)y),(gestureRecognizer)]];
  }  

#End If

#End Region
