B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
#Event: Clicked(Event As MouseEvent, PM as B4xPlusMinus)

Sub Class_Globals
	Private fx As JFX
	Private PM As B4XPlusMinus
	Private TF As TextField
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(PlusMinus As B4XPlusMinus)
	PM = PlusMinus
	TF.Initialize("TF")
	PM.mBase.AddView(TF,0,0,PM.mBase.Width,PM.mBase.Height)
	TF.Visible = False
	Dim O As Object = PM.MainLabel.As(JavaObject).CreateEventFromUI("javafx.event.EventHandler","PMClicked",Null)
	PM.MainLabel.As(JavaObject).RunMethod("setOnMouseClicked",Array(O))
End Sub

Private Sub PMClicked_Event (MethodName As String, Args() As Object)
	TF.Text =  PM.Formatter.Format(PM.SelectedValue)
	TF.Visible = True
	TF.RequestFocus
End Sub

Private Sub TF_Action
	TF.Visible = False
	If IsNumber(TF.Text) Then PM.SelectedValue = TF.Text
End Sub

Private Sub TF_FocusChanged (HasFocus As Boolean)
	If HasFocus = False Then
		TF.Visible = False
		If IsNumber(TF.Text) Then PM.SelectedValue = TF.Text
	End If
End Sub