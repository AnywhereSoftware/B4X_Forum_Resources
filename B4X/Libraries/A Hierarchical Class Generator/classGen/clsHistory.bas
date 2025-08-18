B4J=True
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	Private mEducationStages As List
	Private mHealthConditions As List
	Private mPastEmployements As List
	Private mLegalSituations As List
End Sub
	
Public Sub Initialize
End Sub
	
Public Sub New As clsHistory
	Dim newItem As clsHistory
	newItem.Initialize
	newItem.mEducationStages.Initialize
	newItem.mHealthConditions.Initialize
	newItem.mPastEmployements.Initialize
	newItem.mLegalSituations.Initialize
	Return newItem
End Sub
	
Public Sub getEducationStages As List
	Return mEducationStages
End Sub
	
Public Sub getHealthConditions As List
	Return mHealthConditions
End Sub
	
Public Sub getPastEmployements As List
	Return mPastEmployements
End Sub
	
Public Sub getLegalSituations As List
	Return mLegalSituations
End Sub
	
'Add Class-specific Subs and Calls to other Class Public Subs Here_________________________________________
	
'__________________________________________________________________________________________________________
	
#Region Delegate Subs
	
#End Region
	
