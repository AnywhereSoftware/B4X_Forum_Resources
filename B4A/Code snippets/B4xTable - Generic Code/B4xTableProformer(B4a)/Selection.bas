B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.801
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: true
	#IncludeTitle: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	Private btnEquipment As Button
	Private btnCables As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("Selection")
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub btnEquipment_Click
	'Log("btnEquipment Click")
	EquipInfo.EquipmentHeaders            'Gets headers for table and places in common variables
	StartActivity("DBShow")
End Sub

Sub BtnCables_Click
	'Log("btnCables Click")
	CableInfo.CableHeaders				 	'Gets headers for table and places in common variables
	StartActivity("DBShow")
End Sub