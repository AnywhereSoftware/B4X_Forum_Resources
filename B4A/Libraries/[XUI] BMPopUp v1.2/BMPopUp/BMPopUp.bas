B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.2
@EndOfDesignText@
#Event:Click (Tag As Object)
#RaisesSynchronousEvents: Click

Sub Class_Globals
	Dim xui As XUI
	
	Public mView As B4XView
	Public mParent As Activity
	Public mEventName As String
	Public mCallBack As Object
		
	Public isVisible As Boolean = False
	
	Private sText As String = ""
	Private sTitle As String = ""
	Private sIcon As String = ""
	
	Public 	mTag As Object
	Private pBgColor As Int = Colors.White
	Private oTitleColor As Int = Colors.Black
	Private oMessageColor As Int = Colors.Black
	Private oIconColor As Int = Colors.Black
	Private oPosition As Int = 0
	Private oAppHeader As Boolean = False
	Private oDuration As Int = 0
	Private oCanClose As Boolean = True
	Private lblIcon As Label
	Private lblContent As Label
	Private lblTitle As Label
	Private lblClose As Label
	Private pnlBackground As Panel
	
	Public H_TOP As Int = 0
	Public H_CENTER As Int = 1
	Public H_BOTTOM As Int = 2
	
	Private tmr As Timer
	Private StartTime As Long
	Private pnlTouch As Panel
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Parent As Activity, EventName As String, CallBack As Object)

	'Save the variables:
	mParent = Parent
	mEventName = EventName
	mView = xui.CreatePanel(mEventName)
	mView.LoadLayout("layout_PopUp")
	mCallBack = CallBack
	
End Sub

Public Sub Show
	Dim pos As Float = 0
	
	Select oPosition
		Case 0: pos = IIf(oAppHeader,5%y,0)
		Case 1: pos = 35%y
		Case 2: pos = 85%y
		Case Else:
			pos = oPosition
	End Select
	
	
	mView.SetVisibleAnimated(700, True)
	mView.SetLayoutAnimated(700,0,0,(mParent.Width*85%x),110dip)
	mView.Tag = mEventName
	mView.BringToFront
	mView.As(Panel).Elevation = 3dip
	
	If isVisible = False Then mParent.AddView(mView,0,pos,(mParent.Width*85%x),110dip)
	
	lblContent.Text = sText
	lblContent.TextColor = oMessageColor
	lblTitle.Text = sTitle
	lblTitle.TextColor = oTitleColor
	pnlBackground.Color = pBgColor
	lblIcon.Text = sIcon
	lblIcon.TextColor = oIconColor
	isVisible = True
	StartTime = DateTime.Now
	lblClose.Visible = oCanClose
	
	tmr.Initialize("tmr",1000)
	
	If Not(oDuration = 0) Then tmr.Enabled = True
End Sub

Public Sub Hide
	mView.SetVisibleAnimated(300, False)
	isVisible = False
End Sub

Public Sub Update
	If isVisible Then
		lblContent.Text = sText
		lblContent.TextColor = oMessageColor
		lblTitle.Text = sTitle
		lblTitle.TextColor = oTitleColor
		pnlBackground.Color = pBgColor
		lblIcon.Text = sIcon
		lblIcon.TextColor = oIconColor
		isVisible = True
		StartTime = DateTime.Now
		lblClose.Visible = oCanClose
	End If
End Sub

Private Sub lblClose_Click
	Hide
End Sub

Private Sub tmr_Tick
	
	Dim S As Int = ConvertMillisecondsToSeconds(DateTime.Now - StartTime)
	
	If S = oDuration Then
		Hide
	End If
End Sub

Private Sub ConvertMillisecondsToSeconds(t As Long) As Int
	Dim Seconds As Int
	Seconds = (t Mod DateTime.TicksPerMinute) / DateTime.TicksPerSecond
	Return Seconds
End Sub

#Region ////////////////////////Methods///////////////////////////
Public Sub setBackColor(Color As Int)
	pBgColor = Color
End Sub

Public Sub getBackColor As Int
	Return pBgColor
End Sub

Public Sub setTitleColor(Color As Object)
	oTitleColor = Color
End Sub

Public Sub setAppHeader(Header As Boolean)
	oAppHeader = Header
End Sub

Public Sub getAppHeader As Boolean
	Return oAppHeader
End Sub

Public Sub getTitleColor As Object
	Return oTitleColor
End Sub

Public Sub setMessageColor(Color As Object)
	oMessageColor = Color
End Sub

Public Sub getMessageColor As Object
	Return oMessageColor
End Sub

Public Sub View As B4XView
	Return mView
End Sub

Public Sub setMessage(Text As String)
	sText = Text
End Sub

Public Sub getMessage As String
	Return sText
End Sub

Public Sub setTitle(Title As String)
	sTitle = Title
End Sub

Public Sub getTitle As String
	Return sTitle
End Sub

Public Sub setIcon(Icon As String)
	sIcon = Icon
End Sub

Public Sub setIconColor(Color As Int)
	oIconColor = Color
End Sub

Public Sub setPosition(Position As Int)
	oPosition = Position
End Sub

Public Sub setDuration(Seconds As Int)
	oDuration = Seconds
End Sub

Public Sub getDuration As Int
	Return oDuration
End Sub

Public Sub setClose(Close As Boolean)
	oCanClose = Close
End Sub

Public Sub getClose As Boolean
	Return oCanClose
End Sub

Public Sub setTag(Tag As Object)
	mTag = Tag
End Sub

Public Sub getTag As Object
	Return mTag
End Sub

#End Region

Private Sub pnlTouch_Click
	If SubExists(mCallBack, mEventName & "_Click") Then
		CallSub2(mCallBack, mEventName & "_Click", mTag)
	End If
End Sub

' if a callback routine exists in the calling module we call it
