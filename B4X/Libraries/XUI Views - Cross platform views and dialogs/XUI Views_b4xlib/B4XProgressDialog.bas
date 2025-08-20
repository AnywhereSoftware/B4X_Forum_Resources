B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.12
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Public mBase As B4XView
	Private mText As Object
	Public LoadingIndicator As B4XLoadingIndicator
	Public Label1 As B4XView
	Public mDialog As B4XDialog
End Sub

'Initializes the dialog. Parent - usually the Root view.
Public Sub Initialize (Parent As B4XView)
	mBase = xui.CreatePanel("mBase")
	mBase.SetLayoutAnimated(0, 0, 0, 300dip, 60dip)
	mBase.LoadLayout("XV_ProgressTemplate")
	mBase.SetColorAndBorder(xui.Color_White, 0, 0, 5dip)
	LoadingIndicator.Hide
	mDialog.Initialize(Parent)
	mDialog.ButtonsHeight = -2dip
	mDialog.BorderWidth = 0
	mDialog.BorderCornersRadius = 5dip
End Sub

'Gets or sets the dialog text. Can be string or CSBuilder.
Public Sub setText(t As Object)
	XUIViewsUtils.SetTextOrCSBuilderToLabel(Label1, t)
End Sub

Public Sub getText As Object
	Return mText
End Sub

'Internal method.
Public Sub GetPanel (Dialog As B4XDialog) As B4XView
	Return mBase
End Sub

'Shows the progress dialog.
'Text - String or CSBuilder.
Public Sub ShowDialog (Text As Object)
	setText(Text)
	If mDialog.Visible = False Then
		mDialog.ShowTemplate(Me, "", "", "")
	End If
End Sub

'Closes the dialog.
Public Sub Hide
	mDialog.Close(0)
End Sub

Private Sub Show (Dialog As B4XDialog) 'ignore
	LoadingIndicator.Show
End Sub

Private Sub DialogClosed(Result As Int) 'ignore
	LoadingIndicator.Hide
End Sub