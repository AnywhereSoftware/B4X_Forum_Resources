B4J=True
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	Private mEmployers As List
End Sub
	
Public Sub Initialize
End Sub
	
Public Sub New As clsEmployment
	Dim newItem As clsEmployment
	newItem.Initialize
	newItem.mEmployers.Initialize
	Return newItem
End Sub
	
Public Sub getEmployers As List
	Return mEmployers
End Sub
	
'Add Class-specific Subs and Calls to other Class Public Subs Here_________________________________________
	
'__________________________________________________________________________________________________________
	
#Region Delegate Subs
	
#End Region
	
