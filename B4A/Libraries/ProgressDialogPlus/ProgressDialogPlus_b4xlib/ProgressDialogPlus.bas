B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.1
@EndOfDesignText@
'Class module: ProgressDialogPlus
'Stephan's native Android ProgressDialog wrapper with full control

Sub Class_Globals
	Private ctxt As JavaObject
	Private dialog As JavaObject
	Private IsShown As Boolean = False
End Sub

Public Sub Initialize
	ctxt.InitializeContext
End Sub

'Create and show the ProgressDialog 
'Style: "SPINNER" or "HORIZONTAL"
Public Sub Show(Message As String, Cancelable As Boolean, Title As String, Style As String)
	dialog.InitializeNewInstance("android.app.ProgressDialog", Array(ctxt))
	dialog.RunMethod("setMessage", Array(Message))
	dialog.RunMethod("setCancelable", Array(Cancelable))

	If Title <> "" Then
		dialog.RunMethod("setTitle", Array(Title))
	End If

	Select Case Style.ToUpperCase
		Case "HORIZONTAL"
			dialog.RunMethod("setProgressStyle", Array(1)) ' 1 = STYLE_HORIZONTAL
			dialog.RunMethod("setIndeterminate", Array(False))
			dialog.RunMethod("setMax", Array(100)) ' default max
		Case "SPINNER"
			dialog.RunMethod("setProgressStyle", Array(0)) ' 0 = STYLE_SPINNER
			dialog.RunMethod("setIndeterminate", Array(True))
	End Select

	dialog.RunMethod("show", Null)
	IsShown = True
End Sub

'Update the message text
Public Sub SetMessage(Message As String)
	If IsShown Then dialog.RunMethod("setMessage", Array(Message))
End Sub

'Update the title
Public Sub SetTitle(Title As String)
	If IsShown Then dialog.RunMethod("setTitle", Array(Title))
End Sub

'Only for HORIZONTAL style: update progress
Public Sub SetProgress(Value As Int)
	If IsShown Then dialog.RunMethod("setProgress", Array(Value))
End Sub

'Only for HORIZONTAL style: update max value
Public Sub SetMax(Maximum As Int)
	If IsShown Then dialog.RunMethod("setMax", Array(Maximum))
End Sub

'Cancel the dialog (can be called even if cancelable = false)
Public Sub Cancel
	If IsShown Then
		dialog.RunMethod("cancel", Null)
		IsShown = False
	End If
End Sub

'Dismiss the dialog (clean close)
Public Sub Dismiss
	If IsShown Then
		dialog.RunMethod("dismiss", Null)
		IsShown = False
	End If
End Sub

'Check if currently showing
Public Sub IsShowing As Boolean
	Return IsShown
End Sub
