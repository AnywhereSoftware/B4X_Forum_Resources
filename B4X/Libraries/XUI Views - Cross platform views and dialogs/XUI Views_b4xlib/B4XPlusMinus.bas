B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.31
@EndOfDesignText@
#DesignerProperty: Key: Orientation, DisplayName: Formation, FieldType: String, List: Horizontal|Vertical|Bottom, DefaultValue: Horizontal
#DesignerProperty: Key: Cyclic, DisplayName: Cyclic, FieldType: Boolean, DefaultValue: True, Description: Whether to move to the first item after the last item.
#DesignerProperty: Key: Rapid, DisplayName: Rapid Change, FieldType: Boolean, DefaultValue: True, Description: Whether to allow rapid changes with long click.
#DesignerProperty: Key: HapticFeedback, DisplayName: Haptic Feedback, FieldType: Boolean, DefaultValue: True, Description: Whether to make a haptic feedback when the user clicks on the control.
#Event: ValueChanged (Value As Object)
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
	Public pnlPlus, pnlMinus As B4XView
	Public lblPlus, lblMinus As B4XView
	Public Formation As String
	Public mCyclic As Boolean
	Public mRapid As Boolean
	Public MainLabel As B4XView
	Public ArrowsSize As Int = 30dip
	Private mStringItems As List
	Private mStartRange, mInterval, mEndRange As Double
	Private mSelectedIndex As Int = -1
	Private LoopIndex As Int
	Public RapidPeriod1 As Int = 1000
	Public RapidPeriod2 As Int = 30
	Public Formatter As B4XFormatter
	Private StringMode As Boolean
	Private Size As Int
	Public mHaptic As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	Formatter.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	MainLabel = lbl
	MainLabel.SetTextAlignment("CENTER", "CENTER")
	Dim pnl As B4XView = Props.Get("page")
	#if B4i
	pnlPlus = xui.CreatePanel("")
	pnlMinus = xui.CreatePanel("")
	Dim nme As NativeObject = Me
	For Each p As Panel In Array(pnlPlus, pnlMinus)
		Dim no As NativeObject = p
		no.RunMethod("addGestureRecognizer:", Array(nme.RunMethod("CreateRecognizer", Null)))
	Next
	#else
	pnlPlus = xui.CreatePanel("pnlArrow")
	pnlMinus = xui.CreatePanel("pnlArrow")
	#End If
	pnlPlus.Tag = True
	pnlMinus.Tag = False
	Formation = Props.Get("Orientation")
	mCyclic = Props.Get("Cyclic")
	mRapid = Props.Get("Rapid")
	mHaptic = Props.GetDefault("HapticFeedback", False)
	Formatter.GetDefaultFormat.FormatFont = MainLabel.Font
	Formatter.GetDefaultFormat.TextColor = MainLabel.TextColor
	If Formation = "Horizontal" Then
		lblPlus = CreateLabel(Chr(0xE315))
		lblMinus = CreateLabel(Chr(0xE314))
	Else
		lblPlus = CreateLabel(Chr(0xE316))
		lblMinus = CreateLabel(Chr(0xE313))
	End If
	lblMinus.SetTextAlignment("CENTER", "CENTER")
	lblPlus.SetTextAlignment("CENTER", "CENTER")
	MainLabel.SetTextAlignment("CENTER", "CENTER")
	mBase.AddView(MainLabel, 0, 0, 0, 0)
	mBase.AddView(pnlPlus, 0, 0, 0, 0)
	mBase.AddView(pnlMinus, 0, 0, 0, 0)
	pnlPlus.AddView(lblPlus, 0, 0, 0, 0)
	pnlMinus.AddView(lblMinus, 0, 0, 0, 0)
	SetIndex(-1, False)
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	If Formation = "Horizontal" Then
		pnlMinus.SetLayoutAnimated(0, 0, 0, ArrowsSize, Height)
		pnlPlus.SetLayoutAnimated(0, Width - ArrowsSize, 0, ArrowsSize, Height)
		MainLabel.SetLayoutAnimated(0, 0, 0, Width, Height)
	Else if Formation = "Vertical" Then
		pnlPlus.SetLayoutAnimated(0, 0, 0, Width, ArrowsSize)
		pnlMinus.SetLayoutAnimated(0, 0, Height - ArrowsSize , Width, ArrowsSize)
		MainLabel.SetLayoutAnimated(0, 0, 0, Width, Height)
	Else
		pnlMinus.SetLayoutAnimated(0, 0, Height - ArrowsSize, Width / 2, ArrowsSize)
		pnlPlus.SetLayoutAnimated(0, Width / 2, pnlMinus.Top, pnlMinus.Width, pnlMinus.Height)
		MainLabel.SetLayoutAnimated(0, 0, 0, Width, Height - ArrowsSize + 5dip)
	End If
	lblMinus.SetLayoutAnimated(0, 0, 0, pnlMinus.Width, pnlMinus.Height)
	lblPlus.SetLayoutAnimated(0, 0, 0, pnlPlus.Width, pnlPlus.Height)
End Sub

Public Sub SetStringItems (list As List)
	mStringItems = list
	StringMode = True
	Size = mStringItems.Size
	SetIndex(-1, False)
End Sub

Public Sub SetNumericRange (StartRange As Double, EndRange As Double, Interval As Double)
	Size = Ceil((EndRange - StartRange) / Interval) + 1
	mStartRange = StartRange
	mEndRange = EndRange
	mInterval = Interval
	StringMode = False
	SetIndex(0, False)
End Sub

Public Sub getSelectedValue As Object
	Return GetValueImpl (mSelectedIndex)
End Sub

Public Sub setSelectedValue (v As Object)
	If StringMode Then
		SetIndex(mStringItems.IndexOf(v), False)
	Else
		Dim n As Double = v
		SetIndex(Min(Size - 1, Max(0, Round((n - mStartRange) / mInterval))), False)
	End If
End Sub

Private Sub GetValueImpl (Index As Int) As Object
	If StringMode Then
		Return mStringItems.Get(Index)
	Else
		If Index = Size - 1 Then
			Return mEndRange
		Else
			Return mStartRange + Index * mInterval
		End If
	End If
End Sub

Private Sub SetIndex(i As Int, RaiseEvent As Boolean)
	If i >= Size Then i = -1
	mSelectedIndex = i
	If mSelectedIndex = -1 Then
		MainLabel.Text = ""
	Else
		Dim value As Object = GetValueImpl (mSelectedIndex)
		If StringMode Then
			InternalSetTextOrCSBuilderToLabel(MainLabel, value)
		Else
			MainLabel.Text = Formatter.Format(value)
		End If
		If RaiseEvent And xui.SubExists(mCallBack, mEventName & "_valuechanged", 1) Then
			CallSub2(mCallBack, mEventName & "_valuechanged", value)
		End If
	End If
	lblPlus.Enabled = Size > 0 And (mCyclic Or mSelectedIndex < Size - 1)
	lblMinus.Enabled = Size > 0 And (mCyclic Or mSelectedIndex > 0)
End Sub

Public Sub Increment
	If mSelectedIndex = Size - 3 And StringMode = False Then
		Dim v1 As Double = GetValueImpl(mSelectedIndex + 1)
		Dim v2 As Double = GetValueImpl(mSelectedIndex + 2)
		If Formatter.Format(v1) = Formatter.Format(v2) Then
			mSelectedIndex = mSelectedIndex + 1
		End If
	End If
	If mSelectedIndex >= Size - 1 Then
		If mCyclic Then
			mSelectedIndex = -1
		Else
			mSelectedIndex = Size - 1
			LoopIndex = LoopIndex + 1
			Return
		End If
	End If
	SetIndex(mSelectedIndex + 1, True)
End Sub

Public Sub Decrement
	If mSelectedIndex <= 0 Then
		If mCyclic Then
			mSelectedIndex = Size
		Else
			mSelectedIndex = 0
			LoopIndex = LoopIndex + 1
			Return
		End If
	End If
	SetIndex(mSelectedIndex - 1, True)
End Sub

Private Sub pnlArrow_Touch (Action As Int, X As Float, Y As Float)
	Touch(Action = lblPlus.TOUCH_ACTION_DOWN, Action <> lblPlus.TOUCH_ACTION_MOVE, Sender)
End Sub

Private Sub Touch (Start As Boolean, Stop As Boolean, pnl As B4XView)
	If pnl.GetView(0).Enabled = False Then Return
	If Start Then
		If mHaptic Then XUIViewsUtils.PerformHapticFeedback(pnl)
		If pnl.Tag = True Then
			Increment
			StartDownLoop(True)
		Else
			Decrement
			StartDownLoop(False)
		End If
	Else If Stop Then
		LoopIndex = LoopIndex + 1
	End If
End Sub

#if B4i
Private Sub Tap_Event (rrec As Object)
	Dim rec As NativeObject = rrec
	Dim state As Int = rec.GetField("state").AsNumber
	Touch(state = 1, state <> 2, rec.GetField("view"))
End Sub
#End If

#if OBJC
- (NSObject*) CreateRecognizer{
 	 UILongPressGestureRecognizer *rec = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
	 rec.minimumPressDuration = 0;
	return rec;
}
-(void) action:(UIGestureRecognizer*)rec {
	[self.bi raiseEvent:nil event:@"tap_event:" params:@[rec]];
}
#End If

Private Sub StartDownLoop (Up As Boolean)
	LoopIndex = LoopIndex + 1
	If mRapid = False Then Return
	Dim MyIndex As Int = LoopIndex
	Sleep(RapidPeriod1)
	Do While MyIndex = LoopIndex
		If Up Then Increment Else Decrement
		Sleep(RapidPeriod2)
	Loop
End Sub



Private Sub CreateLabel (text As String) As B4XView
	Dim lbl As Label
	lbl.Initialize("")
	Dim xlbl As B4XView = lbl
	xlbl.Font = xui.CreateMaterialIcons(30)
	xlbl.Text = text
	xlbl.TextColor = MainLabel.TextColor
	Return xlbl
End Sub

Private Sub InternalSetTextOrCSBuilderToLabel(xlbl As B4XView, Text As Object)
	#if B4A or B4J
	xlbl.Text = Text
	#else if B4i
	If Text Is CSBuilder And xlbl Is Label Then
		Dim lbl As Label = xlbl
		lbl.AttributedText = Text
	Else 
		If GetType(Text) = "__NSCFNumber" Then Text = "" & Chr(Text)
		xlbl.Text = Text
	End If
	#end if
End Sub

#if B4J
Private Sub pnlArrow_MousePressed (EventData As MouseEvent)
	EventData.Consume
End Sub

Private Sub pnlArrow_MouseClicked(EventData As MouseEvent)
	EventData.Consume
End Sub

Private Sub pnlArrow_MouseReleased(EventData As MouseEvent)
	EventData.Consume
End Sub
#End If