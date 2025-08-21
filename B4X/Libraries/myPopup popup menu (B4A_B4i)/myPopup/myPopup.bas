B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.3
@EndOfDesignText@
' Popup menu class by Kevin Stainsby 2019.
' Works in b4a and b4i
' Needs JavaObject library for Android
' v1.1
	
Sub Class_Globals
	Private Callback As Object
	Private Event As String
	Private btnList As List 
	Private anchorView As View 
	Private maxWidth, maxHeight As Int = 0
	Dim borderWidth As Int = 1
	Dim btnPadding As Int = 5dip
	Dim btnSpacing As Int = 3dip
	Dim btnBorderColour As Int = Colors.white
	Private pnl As Panel
	Private sv As ScrollView
	Private maxX, maxY As Int 
	Private const ANCHOR_BOTTOMMIDDLE As Int = 1
	Private const ANCHOR_TOPLEFT As Int = 2
	Private showingMenu As Boolean 
	Dim btnTextColour As Int = Colors.black
	Private btnHeight As Int = 45dip
	Private btnRadius As Int = 5dip
#if b4i
	Private myPanel As Panel
	Dim btnColour As Int = Colors.white
	Private const animTime As Int = 1000
	Private useThisFont As Font
#else if b4a
	Dim myActivity As Activity
	Dim btnBackgroundColour As Int = Colors.LightGray
	Dim btnFontSize As Float = 18.0
	Private const animTime As Int = 300
	Dim useThisTypeFace As Typeface
#End If
End Sub

'Initializes the popup. Pass a list of strings for the buttons text.
#if b4i
Public Sub Initialize( rootPnl As Panel, CallbackModule As Object, EventName As String, btnText As List, mX As Int, mY As Int, theFont As Font )
	useThisFont = theFont
#else if b4A
Public Sub Initialize( anActivity As Activity, CallbackModule As Object, EventName As String, btnText As List, mX As Int, my As Int, theTypeface As Typeface )
	useThisTypeFace = theTypeface
#End If

	maxX = mX
	maxY = my
	Callback = CallbackModule
	Event = EventName
	
#if b4i
	myPanel = rootPnl
#else if b4A
	myActivity = anActivity 
#End If	

	btnList.Initialize
	pnl.Initialize("Pnl")
	pnl.Color = Colors.Transparent
	
#if b4i
	sv.Initialize("sv", 1, 1)
#else if b4A
	sv.Initialize(1)
#End If

	sv.Color = Colors.Transparent
	
	For Each s As String In btnText
		Dim aBtn As Button
#if b4i
		aBtn.Initialize("Btn",aBtn.STYLE_SYSTEM)
		aBtn.CustomLabel.Font = useThisFont
		aBtn.Text = s 
		aBtn.SetBorder( borderWidth, btnBorderColour, btnRadius )
		aBtn.SetShadow(Colors.black,3dip,3dip,0.7,False)
		aBtn.SizeToFit
		aBtn.Color = btnColour
		SetButtonTextColor(aBtn, btnTextColour )
#else if b4A
		aBtn.Initialize("Btn")
		setBorder(aBtn, borderWidth, btnRadius, btnBorderColour, btnBackgroundColour)
		aBtn.TextSize = btnFontSize
		aBtn.SingleLine = True
		aBtn.Ellipsize = "END"
		aBtn.Gravity = Gravity.CENTER_VERTICAL
		aBtn.Padding = Array As Int (btnPadding, btnPadding, btnPadding, btnPadding)
		aBtn.Typeface = theTypeface
		SetButtonTextColor(aBtn, btnTextColour )
		aBtn.Text = s
		sv.Panel.AddView( aBtn, 0,0,1,btnHeight)
		setButtonWidth( aBtn )
#End If
		If aBtn.Width + (btnPadding*2) > maxWidth Then maxWidth = aBtn.Width + (btnPadding *2)
		If aBtn.Height + (btnPadding*2) > maxHeight Then maxHeight = aBtn.Height + (btnPadding *2)
		btnList.Add(aBtn)
	Next

#if b4i
	For Each b As Button In btnList
		sv.Panel.AddView( b, 0,0,1,btnHeight)
		b.SizeToFit
	Next	
#End If
	'Resize to same width (max)..
	For Each b As Button In btnList
		If b.Width < maxWidth Then b.Width = maxWidth
		If b.Height < maxHeight Then b.Height = maxHeight
	Next
	
	Dim currY As Int = 0
	For Each b As Button In btnList
		b.Left = btnSpacing
		b.Width = maxWidth
		
		currY = currY + btnSpacing
		b.Top = currY
		b.Height = maxHeight
		currY = currY + maxHeight
	Next
	currY = currY + btnSpacing

#if b4i
	sv.ContentHeight = currY
	sv.ContentWidth = maxWidth + 2*btnSpacing
#else if b4a
	sv.panel.Height = currY
	sv.panel.Width = maxWidth + 2*btnSpacing
#End If

End Sub

'Call in page resize event, to reset the screen coordinates
public Sub Resize(screenX As Int, screenY As Int)
	maxX = screenX
	maxY = screenY
	pnl.Width = maxX
	pnl.Height = maxY
End Sub

'Shows the popup menu, anchored to the parent view
'If already displaying, calling it show again will hide the menu.
public Sub Show(parent As View )
	showPopup(parent, ANCHOR_BOTTOMMIDDLE)
End Sub
	
'Same as show, but popup anchored to top left corner of view instead.
'If already displaying, calling it show again will hide the menu.
Public Sub Show2(parent As View)
	showPopup(parent, ANCHOR_TOPLEFT) 
End Sub

private Sub showPopup(parent As View, anchorPoint As Int)
	If showingMenu Then
		Hide
		Return
	End If
	
	anchorView = parent		
	Dim anchorViewTop, anchorViewLeft, anchorViewHeight, anchorViewWidth As Int

	anchorViewHeight = anchorView.Height 'Take a copy b4 abs coord call (problem in b4i)
	anchorViewWidth = anchorView.Width
	Dim leftTop() As Float = GetPageLeftAndTop( anchorView )
#if b4i
	Dim leftTop2() As Float = GetPageLeftAndTop( myPanel )
#else
	Dim leftTop2() As Float = GetPageLeftAndTop( myActivity )
#End If
	anchorViewLeft = leftTop(0) - leftTop2(0)
	anchorViewTop = leftTop(1) - leftTop2(1)

	Dim left, top As Int
	Select anchorPoint
		Case ANCHOR_BOTTOMMIDDLE
			left = anchorViewLeft + (anchorViewWidth / 2)
			If left + maxWidth + 2*btnSpacing > maxX Then left = maxX - maxWidth - 2*btnSpacing
	
			If anchorViewTop > 0.5*maxY Then
#if b4i
				top = anchorViewTop - sv.ContentHeight
#else if b4a				
				top = anchorViewTop - sv.panel.Height
#End If
				If top < 0 Then top = 0
			Else
				top = anchorViewTop + anchorViewHeight
				If top + maxHeight > maxY Then top = Max(maxY - maxHeight, 0)
			End If
		Case ANCHOR_TOPLEFT
			left = anchorViewLeft
			If left + maxWidth > maxX Then left = maxX - maxWidth
	
			If anchorViewTop > 0.5*maxY Then
#if b4i
				top = anchorViewTop - sv.ContentHeight
#else if b4a
				top = anchorViewTop - sv.panel.Height
#End If
				If top < 0 Then top = 0
			Else
				top = anchorViewTop + anchorViewHeight
				If top + maxHeight > maxY Then top = Max(maxY - maxHeight, 0)
			End If
	End Select
#if b4i
	myPanel.AddView(pnl, 0, 0, maxX, maxY)
#else if b4A
	pnl.RemoveView
	myActivity.AddView(pnl, 0, 0, maxX, maxY)
	pnl.Elevation = 99.0
#End If
	
	pnl.BringToFront
	pnl.Color = Colors.ARGB(80,255,255,255)
	
	'Start of animation point in top left of anchorview..	
	pnl.AddView(sv, anchorViewLeft, anchorViewTop, 1, 1)
	pnl.Visible = True
	sv.Visible = True
	sv.Color = Colors.ARGB(170,255,255,255)

#if b4i
	If top + sv.ContentHeight <= maxY Then
		sv.SetLayoutAnimated(animTime, 0.5, left, top, sv.ContentWidth, sv.ContentHeight )
	Else
		sv.SetLayoutAnimated(animTime, 0.5, left, top, sv.ContentWidth, maxY - top )
	End If
#else if b4a
	If top + sv.panel.Height <= maxY Then
		sv.SetLayoutAnimated(animTime,  left, top, sv.panel.Width, sv.panel.Height )
	Else
		sv.SetLayoutAnimated(animTime, left, top, sv.panel.Width, maxY - top )
	End If
	sv.BringToFront
#End If
	showingMenu = True
End Sub

' Hides the popup menu
public Sub Hide
	pnl.SendToBack
	pnl.RemoveAllViews
#if b4A
	pnl.RemoveView
#End If
	showingMenu = False
End Sub

Private Sub Btn_Click
	Dim b As Button = Sender
	Dim txt As String = b.Text
#if b4i
	If SubExists(Callback, Event & "_BtnClick", 1) Then
		CallSub2(Callback, Event & "_BtnClick", txt )
	End If
#else if b4a	
	If SubExists(Callback, Event & "_BtnClick") Then
		CallSub2(Callback, Event & "_BtnClick", txt )
	End If
#End If	
	Hide 
End Sub

private Sub Pnl_Click
	Hide
End Sub

private Sub SetButtonTextColor(btn As Button, clr As Int)
#if b4i
	Dim no As NativeObject = btn
	no.RunMethod("setTitleColor:forState:", Array(no.ColorToUIColor(clr), 1))
#else if b4a
	btn.TextColor = clr
#End If
End Sub

#if b4i
#else if b4A
'Sets the button to be wide enough to fit its text.
private Sub setButtonWidth(btn As Button)
	Dim w As Int
	Dim wMargin As Int = Max( btn.Width * 0.1, 10 ) 'say
	Dim bmpTest As Bitmap
	bmpTest.InitializeMutable(1, 1)
	Dim cvsTest As Canvas
	cvsTest.Initialize2(bmpTest)
	w = cvsTest.MeasureStringWidth(btn.Text, useThisTypeFace, btn.TextSize)
	btn.Width = w + 2* wMargin
End Sub
#End If

Sub GetPageLeftAndTop(v As View) As Float()
#if b4i
	Dim tl(2) As Float
	Do While GetType(v) <> "B4IMainView"
''		Log("View type = " & GetType(v))
''		Dim no As NativeObject = v
		tl(0) = tl(0) + v.Left
		If v Is ScrollView Then
			Dim s As ScrollView = v
			tl(1) = tl(1) + v.Top - s.ScrollOffsetY
		Else
			tl(1) = tl(1) + v.Top
		End If
''		v = no.GetField("superview")			
		''v = v.Parent
		If v.Parent.IsInitialized Then
			v = v.Parent
		Else
			Exit
		End If
	Loop
	Return tl
#else if b4A
	Dim leftTop(2) As Int
	Dim JO As JavaObject = v
	JO.RunMethod("getLocationOnScreen", Array As Object(leftTop))
	Dim ret(2) As Float
	ret(0) = leftTop(0)
	ret(1) = leftTop(1)
	Return ret
#End If
End Sub

#if b4A
Sub setBorder(v As View, width As Int, cornerRadius As Int, borderColor As Int, backgroundColor As Int)
	Dim c As ColorDrawable
	c.Initialize2(backgroundColor,cornerRadius,width,borderColor)
	v.Background = c
End Sub
#End If

