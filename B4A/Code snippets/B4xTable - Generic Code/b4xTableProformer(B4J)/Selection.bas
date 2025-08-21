B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.3
@EndOfDesignText@

Sub Process_Globals
	Private fx As JFX
	Dim Frm As Form
	Private btnEquipment As Button
	Private btnCables As Button
End Sub

Public Sub Show
'Log("Selection Show")
	If Frm.IsInitialized = False Then
		Frm.Initialize("frm", 1250, 800)
		Frm.RootPane.LoadLayout("Selection")
	End If
	Common.FullScreen(Frm)
	Frm.Show
End Sub

Sub btnEquipment_Click
'Log("btnEquipment Click")
	EquipInfo.EquipmentHeaders            'Gets headers for table and places in common variables
	Frm.Close
	DBShow.show
End Sub

Sub BtnCables_Click
'Log("btnCables Click")
	CableInfo.CableHeaders				 	'Gets headers for table and places in common variables
	Frm.Close
	DBShow.show
End Sub

