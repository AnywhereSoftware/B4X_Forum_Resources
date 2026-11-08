B4J=True
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	Private mFullName As String
	Private mPreferredGender As String
	Private mBirthdate As Long
End Sub
	
Public Sub Initialize
End Sub
	
Public Sub New(FullName_ As String, PreferredGender_ As String, Birthdate_ As Long) As clsVitalStats
	Dim newItem As clsVitalStats
	newItem.Initialize
	newItem.mFullName = FullName_
	newItem.mPreferredGender = PreferredGender_
	newItem.mBirthdate = Birthdate_
	Return newItem
End Sub
	
Public Sub getFullName As String
	Return mFullName
End Sub
	
Public Sub setFullName(newValue As String)
	mFullName = newValue
End Sub
	
Public Sub getPreferredGender As String
	Return mPreferredGender
End Sub
	
Public Sub setPreferredGender(newValue As String)
	mPreferredGender = newValue
End Sub
	
Public Sub getBirthdate As Long
	Return mBirthdate
End Sub
	
Public Sub setBirthdate(newValue As Long)
	mBirthdate = newValue
End Sub
	
'Add Class-specific Subs and Calls to other Class Public Subs Here_________________________________________
	
'__________________________________________________________________________________________________________
	
#Region Delegate Subs
	
#End Region
	
