B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
#IF B4J
#Event: MouseClicked(EventData As MouseEvent)
#Else
#Event: Click
#End If
#Event: LongClick

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private FullEventName As String
	
	Public Const STATE_DISABLED As Int = 0
	Public Const STATE_ENABLED As Int = 1
	Public Const STATE_PRESSED As Int = 2
	
	Private mlstBmps As List
	
	Private mState As Int
	Private xivBase As B4XImageView
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	mlstBmps.Initialize
	mlstBmps.Add("")
	mlstBmps.Add("")
	mlstBmps.Add("")
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	'  	Dim clr As Int = xui.PaintOrColorToColor(Props.Get("TextColor")) 'Example of getting a color value from Props
	mBase.LoadLayout("layB4XThreeState")
	mlstBmps.Set(STATE_DISABLED, xui.LoadBitmapResize(File.DirAssets, "threestatedisabled.png", mBase.Width, mBase.Height, True))
	mlstBmps.Set(STATE_ENABLED, xui.LoadBitmapResize(File.DirAssets, "threestateenabled.png", mBase.Width, mBase.Height, True))
	mlstBmps.Set(STATE_PRESSED, xui.LoadBitmapResize(File.DirAssets, "threestatepressed.png", mBase.Width, mBase.Height, True))
	setState(STATE_ENABLED)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)

End Sub

#Region PROPERTIES 

Public Sub setEnabledBmp(xBmp As B4XBitmap)
	mlstBmps.Set(STATE_ENABLED, xBmp)
	UpdateState
End Sub
Public Sub getEnabledBmp As B4XBitmap
	Return mlstBmps.Get(STATE_ENABLED)
End Sub

Public Sub setDisabledBmp(xBmp As B4XBitmap)
	mlstBmps.Set(STATE_DISABLED, xBmp)
	UpdateState
End Sub
Public Sub getDisabledBmp As B4XBitmap
	Return mlstBmps.Get(STATE_DISABLED)
End Sub

Public Sub setPressedBmp(xBmp As B4XBitmap)
	mlstBmps.Set(STATE_PRESSED, xBmp)
	UpdateState
End Sub
Public Sub getPressedBmp As B4XBitmap
	Return mlstBmps.Get(STATE_PRESSED)
End Sub

'Pass one of the three constants provided.
Public Sub setState(State As Int)
	mState = State
	UpdateState
End Sub
Public Sub getState As Int
	Return mState
End Sub

Public Sub getWidth As Int
	Return mBase.Width
End Sub

Public Sub getHeight As Int
	Return mBase.Height
End Sub

Public Sub getImgView As B4XImageView
	Return xivBase
End Sub

#End Region

#Region PRIVATE METHODS 

Private Sub UpdateState
	xivBase.Bitmap = mlstBmps.Get(mState)
	xivBase.Update
End Sub

#End Region

#IF B4J
Private Sub pnlOver_MouseClicked (EventData As MouseEvent)
	Select mState
		Case STATE_ENABLED
			setState(STATE_PRESSED)
		Case STATE_DISABLED
			Return
		Case STATE_PRESSED
			setState(STATE_ENABLED)
	End Select
	FullEventName = mEventName & "_MouseClicked"
	If SubExists(mCallBack, FullEventName) Then
		CallSubDelayed2(mCallBack, FullEventName, EventData)
	End If
End Sub
#Else
Private Sub pnlOver_Click
	Select mState
		Case STATE_ENABLED
			setState(STATE_PRESSED)
		Case STATE_DISABLED
			Return
		Case STATE_PRESSED
			setState(STATE_ENABLED)
	End Select
	FullEventName = mEventName & "_Click"
	If SubExists(mCallBack, FullEventName) Then
		CallSubDelayed(mCallBack, FullEventName)
	End If
End Sub

Private Sub pnlOver_LongClick
	Select mState
		Case STATE_ENABLED
			setState(STATE_PRESSED)
		Case STATE_DISABLED
			Return
		Case STATE_PRESSED
			setState(STATE_ENABLED)
	End Select
	FullEventName = mEventName & "_LongClick"
	If SubExists(mCallBack, FullEventName) Then
		CallSubDelayed(mCallBack, FullEventName)
	End If
End Sub
#End If
