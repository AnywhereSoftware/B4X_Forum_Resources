B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
Sub Class_Globals
	Private txtNumber As B4XFloatTextField
	Private btnGuess As SwiftButton
	Private ImageView1 As B4XView
	Private xui As XUI
	Private MyNumber As Int
	Private toast As BCToast
End Sub

Public Sub Initialize (Parent As B4XView)
	Parent.LoadLayout("1")
	
	btnGuess.Enabled = False
	ImageView1.SetBitmap(xui.LoadBitmapResize(File.DirAssets, "logo.png", ImageView1.Width, ImageView1.Height, True))
	MyNumber = Rnd(1, 101)
	toast.Initialize(Parent)
	txtNumber.NextField = txtNumber
End Sub

Private Sub txtNumber_EnterPressed
	btnGuess_Click
	txtNumber.RequestFocusAndShowKeyboard
End Sub

Private Sub txtNumber_TextChanged (Old As String, New As String)
	btnGuess.Enabled = IsNumber(New)
End Sub

Private Sub btnGuess_Click
	If btnGuess.Enabled = False Then Return
	Dim number As Int = txtNumber.Text
	If number > MyNumber Then
		toast.Show("My number is smaller")
	Else If number < MyNumber Then
		toast.Show("My number is larger")
	Else
		toast.Show("You are correct!!!")
	End If
	toast.pnl.Top = txtNumber.mBase.Top + 150dip
	SelectText
End Sub

Private Sub SelectText
	'for some strange reason B4XFloatTextField doesn't include a select all feature.
	'so we need to add it ourselves...
	#if B4J or B4i
	Dim tf As TextField = txtNumber.TextField
	tf.SelectAll
	#else if B4A
	Dim et As EditText = txtNumber.TextField
	et.SelectAll
	#End If
End Sub

