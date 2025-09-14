B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1.8
@EndOfDesignText@
'Class module


'''' VERSION : 1.1


Sub Class_Globals
	Private mEventName As String
	Private mHandler As Object
	Public mView As View
	Private nome As NativeObject=Me
	Private Const mSwipeDirectionLeft As Int = 2
	Private Const mSwipeDirectionRight As Int =1
	Private Const mSwipeDirectionUp As Int =4
	Private Const mSwipeDirectionDown As Int =8
	
	Private Const mEDGE_Left As Int =2
	Private Const mEDGE_Top As Int =1
	Private Const mEDGE_Right As Int =8
	Private Const mEDGE_Bottom As Int =4
	
	Private Const mSTATE_Begin As Int =1
	Private Const mSTATE_Changed As Int =2
	Private Const mSTATE_End As Int =3

	Type Pan_AttributesMultiColumnCustomListView(X As Float,Y As Float, Obj As Object)
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(EventName As String,Handler As Object,V As View)
mEventName=EventName
mHandler=Handler
mView=V
End Sub

Public Sub AddTapGesture(NumberOfTaps As Int,NumberOfTouch As Int)
nome.RunMethod("grTap:::",Array(NumberOfTaps,NumberOfTouch,mView))
End Sub

Public Sub AddPinchGesture
nome.RunMethod("grPinch:",Array(mView))
End Sub

Public Sub AddRotationGesture
nome.RunMethod("grRotation:",Array(mView))
End Sub

Public Sub AddSwipeGesture(NumberOfTouch As Int,Direction As Int)
nome.RunMethod("grSwipe:::",Array(mView,NumberOfTouch,Direction))
End Sub

Public Sub AddScreenEdgePanGesture(Edge As Int)
nome.RunMethod("grScreenEdge::",Array(mView,Edge))
End Sub

Public Sub AddLongPressGesture(NumberOfTaps As Int, NumberOfTouch As Int,Duration As Float)
nome.RunMethod("grLongPress::::",Array(NumberOfTaps,NumberOfTouch,Duration,mView))
End Sub

Public Sub AddPanGesture(MinimumTouch As Int, MaximumTouch As Int)
nome.RunMethod("grPan:::",Array(mView,MinimumTouch,MaximumTouch))
End Sub

Sub getSWIPE_Direction_Left As Int
Return mSwipeDirectionLeft
End Sub

Sub getSWIPE_Direction_Right As Int
Return mSwipeDirectionRight
End Sub

Sub getSWIPE_Direction_Up As Int
Return mSwipeDirectionUp
End Sub

Sub getSWIPE_Direction_Down As Int
Return mSwipeDirectionDown
End Sub

Sub getEDGE_Top As Int
Return mEDGE_Top
End Sub

Sub getEDGE_Left As Int
Return mEDGE_Left
End Sub

Sub getEDGE_Right As Int
Return mEDGE_Right
End Sub

Sub getEDGE_Bottom As Int
Return mEDGE_Bottom
End Sub

Sub getSTATE_Begin As Int
Return mSTATE_Begin
End Sub

Sub getSTATE_Changed As Int
Return mSTATE_Changed
End Sub

Sub getSTATE_End As Int
Return mSTATE_End
End Sub

Private Sub uigesture_pan(state As Int,x As Float, y As Float, obj As Object)
	Dim att As  Pan_AttributesMultiColumnCustomListView
	att.x=x
	att.y=y
	att.obj=obj
	If SubExists(mHandler,mEventName & "_Pan",2) Then
		CallSub3(mHandler,mEventName & "_Pan",state,att)
	End If
End Sub




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