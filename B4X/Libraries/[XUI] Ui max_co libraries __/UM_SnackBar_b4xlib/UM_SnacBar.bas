B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'Version: 1.20
'Ui max_co


Sub Class_Globals
	
	Type XViewese(pnl As B4XView,Text As B4XView)
	Type Varients(TextSize As Int,Text As String,TextColor As Int,Color As Int,Height As Int,Fonts As B4XFont,Time As Int)
	
	Private xui As XUI
	Private Xview As XViewese
	Private var As Varients	
	
	Private mCallback As B4XView
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	Xview.Initialize
	var.Initialize
	
	var.Color = xui.PaintOrColorToColor(0xffFFC107)
	var.Fonts = xui.CreateDefaultFont(19)
	var.Height = 70dip
	var.Text = "Ui max_co"
	var.TextColor = xui.PaintOrColorToColor(0xff12153D)
	var.TextSize = 19
	var.time = 2500
	
End Sub

Private Sub Design(callBack As B4XView)
	mCallback = callBack
''''panel	
	Xview.pnl=xui.CreatePanel("")
	Xview.pnl.SetColorAndBorder(var.Color,0,0,0)
	callBack.AddView(Xview.pnl,0,mCallback.Top-var.Height,mCallback.Width,var.Height)
	Xview.pnl.Visible=False
	
''''Text
	Xview.Text = CreateLabel
	Xview.Text.Font = var.Fonts
	Xview.Text.Text = var.Text
	Xview.Text.TextColor = var.TextColor
	Xview.Text.TextSize = var.TextSize
	Xview.Text.SetTextAlignment("CENTER","CENTER")
	Xview.pnl.AddView(Xview.Text,20dip,0,Xview.pnl.Width-40dip,Xview.pnl.Height)
	
	Animation(callBack)
	
End Sub

Private Sub CreateLabel As B4XView

	Private l As Label
	l.Initialize("")
	#if B4A
	l.Ellipsize="END"
	#End If
	
	Return l
End Sub

Public Sub Show(Callback As B4XView)
	If Xview.pnl.IsInitialized Then
		Animation(Callback)
	Else	
		Design(Callback)
	End If
	
End Sub

Private Sub Animation(callback As B4XView)
	Xview.pnl.Left = callback.Left
	Xview.pnl.Width = callback.Width
	Xview.Text.Left = 20dip
	Xview.Text.Width = Xview.pnl.Width-40dip
	
	Xview.pnl.SetLayoutAnimated(600,Xview.pnl.Left,mCallback.Top,Xview.pnl.Width,Xview.pnl.Height)
	Xview.pnl.SetVisibleAnimated(600,True)
	
	Sleep(600+var.Time)
	
	Xview.pnl.SetLayoutAnimated(500,Xview.pnl.Left,-var.Height,Xview.pnl.Width,Xview.pnl.Height)
	Xview.pnl.SetVisibleAnimated(500,False)
	
End Sub

#Region SETTER

Public Sub Text(texte As String)
	var.Text = texte
	
	If Xview.Text.IsInitialized Then
		Xview.Text.Text = var.Text
	End If
	
End Sub

Public Sub TextSize(size As Int)
	var.TextSize = size
	
	If Xview.Text.IsInitialized Then
		Xview.Text.TextSize = var.TextSize
	End If
End Sub

Public Sub TextColor(color As Int)
	var.TextColor = color
	
	If Xview.Text.IsInitialized Then
		Xview.Text.TextColor = var.TextColor
	End If
End Sub

Public Sub BackgroundColor(color As Int)
	var.Color = color
	
	If Xview.pnl.IsInitialized Then
		Xview.pnl.Color = var.Color
	End If
	
End Sub

Public Sub SetHeight(height As Int)
	var.Height = height
	
	If Xview.pnl.IsInitialized=False Then Return
	
	Xview.pnl.Height = var.Height
	
	If Xview.pnl.Visible Then
		Xview.pnl.Top = 0
	Else	
		Xview.pnl.Top = -height
	End If
End Sub

Public Sub Fonts(setFont As B4XFont)
	var.Fonts = setFont
	
	If Xview.Text.IsInitialized Then
		Xview.Text.Font = var.Fonts
	End If

End Sub

'Millisecond
Public Sub Time(AnimTime As Int)
	var.time = AnimTime
End Sub

#End Region

Public Sub Gettext As String
	Return var.Text
End Sub