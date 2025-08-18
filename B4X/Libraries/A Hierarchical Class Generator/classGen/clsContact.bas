B4J=True
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	Private mAddress As String
	Private mPhones As List
	Private mEmails As List
End Sub
	
Public Sub Initialize
End Sub
	
Public Sub New(Address_ As String) As clsContact
	Dim newItem As clsContact
	newItem.Initialize
	newItem.mAddress = Address_
	newItem.mPhones.Initialize
	newItem.mEmails.Initialize
	Return newItem
End Sub
	
Public Sub getAddress As String
	Return mAddress
End Sub
	
Public Sub setAddress(newValue As String)
	mAddress = newValue
End Sub
	
Public Sub getPhones As List
	Return mPhones
End Sub
	
Public Sub getEmails As List
	Return mEmails
End Sub
	
'Add Class-specific Subs and Calls to other Class Public Subs Here_________________________________________
	
'__________________________________________________________________________________________________________
	
#Region Delegate Subs
	
#End Region
	
