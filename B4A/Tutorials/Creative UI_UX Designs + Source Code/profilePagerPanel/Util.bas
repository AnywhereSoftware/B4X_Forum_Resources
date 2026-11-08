B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=11.5
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub makeActivityScrollable(actActivity As Activity)	As ScrollView
	Dim tmpScrollView As ScrollView
	tmpScrollView.Initialize			(actActivity.Height)
	actActivity.AddView			(tmpScrollView,0,0,-1,-1)
	tmpScrollView.Panel.Width	=	actActivity.Width
	tmpScrollView.Panel.Height	=	actActivity.Height
	Return tmpScrollView
End Sub