B4J=True
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	Private mParentOf As List
	Private mSpousePartnerOf As List
	Private mSiblingOf As List
	Private mChildOf As List
End Sub
	
Public Sub Initialize
End Sub
	
Public Sub New As clsLifeRoles
	Dim newItem As clsLifeRoles
	newItem.Initialize
	newItem.mParentOf.Initialize
	newItem.mSpousePartnerOf.Initialize
	newItem.mSiblingOf.Initialize
	newItem.mChildOf.Initialize
	Return newItem
End Sub
	
Public Sub getParentOf As List
	Return mParentOf
End Sub
	
Public Sub getSpousePartnerOf As List
	Return mSpousePartnerOf
End Sub
	
Public Sub getSiblingOf As List
	Return mSiblingOf
End Sub
	
Public Sub getChildOf As List
	Return mChildOf
End Sub
	
'Add Class-specific Subs and Calls to other Class Public Subs Here_________________________________________
	
'__________________________________________________________________________________________________________
	
#Region Delegate Subs
	
#End Region
	
