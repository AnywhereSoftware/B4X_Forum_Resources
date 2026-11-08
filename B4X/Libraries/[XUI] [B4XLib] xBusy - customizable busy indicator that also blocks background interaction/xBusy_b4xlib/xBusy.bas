B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.5
@EndOfDesignText@
'Version 1.01
'Nathan Segaloff
Sub Class_Globals
	Private xui As XUI		
	Private ParentPanel As B4XView 'Ignore
	Private tmrRotate As Timer
'Variables	
	Private iRotation As Int	
'Properties
	Public SpinnerImage As B4XBitmap
	Public BackgroundImage As B4XBitmap
	Public TextColor As Int=xui.Color_White
	Public BackgroundAlpha As Int=220
	Public TapToClose As Boolean=False
'Views
	Private imgBackground As B4XView
	Private pnlBlock As B4XView
	Private lblBusyText As B4XView
	Private imgBusyIcon As B4XView
End Sub

Public Sub Initialize (Parent As B4XView)
	ParentPanel = Parent
	ParentPanel.LoadLayout("xBusyLayout")
	ParentPanel.Visible=True
	tmrRotate.Initialize("tmrRotate", 30)
	SpinnerImage=imgBusyIcon.GetBitmap
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	If pnlBlock.IsInitialized Then
		pnlBlock.SetLayoutAnimated(0,0,0,Width,Height)
		UpdateImageviews
	End If
End Sub

Public Sub Hide()
	pnlBlock.SetVisibleAnimated(100,False)
	Sleep(100)
	tmrRotate.Enabled=False
End Sub

'ABSORB ANY TOUCH/CLICK EVENTS
#If B4J
Private Sub pnlBlock_MouseClicked (EventData As MouseEvent)
#else
Private Sub pnlBlock_Touch (Action As Int, X As Float, Y As Float)
	If TapToClose Then Hide
	Return
#End If
End Sub

Public Sub Show
	ShowWithText("")
End Sub

Public Sub IsActive As Boolean
	Return pnlBlock.Visible
End Sub

Public Sub ShowWithText(DisplayText As String)
	If pnlBlock.Visible Then
		lblBusyText=DisplayText
		Return
	End If
	
	UpdateImageviews
	
	imgBackground.Visible=BackgroundImage.IsInitialized	
	imgBusyIcon.Visible=SpinnerImage.IsInitialized

	iRotation=0	
	pnlBlock.Color=xui.Color_ARGB(BackgroundAlpha,0,0,0)	
	lblBusyText.Text=DisplayText
	lblBusyText.TextColor=TextColor
	tmrRotate.Enabled=True
	pnlBlock.BringToFront
	pnlBlock.SetVisibleAnimated(0,True)
End Sub

Private Sub UpdateImageviews
	If BackgroundImage.IsInitialized Then imgBackground.SetBitmap(BackgroundImage.Resize(imgBackground.Width,imgBackground.Height,False))	
	If SpinnerImage.IsInitialized Then imgBusyIcon.SetBitmap(SpinnerImage.Resize(imgBusyIcon.Width,imgBusyIcon.Height,True))
End Sub

Public Sub UpdateText(DisplayText As String)
	lblBusyText.Text=DisplayText
End Sub

Sub tmrRotate_Tick
	iRotation=IIf(iRotation<350,iRotation+10,0)
	imgBusyIcon.As(B4XView).Rotation=iRotation
End Sub


