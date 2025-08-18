B4J=True
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	Private mPersonalInfo As clsPersonalInfo
	Private mLifeRoles As clsLifeRoles
End Sub
	
Public Sub Initialize
End Sub
	
Public Sub New(PersonalInfo_ As clsPersonalInfo, LifeRoles_ As clsLifeRoles) As clsPersonHood
	Dim newItem As clsPersonHood
	newItem.Initialize
	newItem.mPersonalInfo = PersonalInfo_
	newItem.mLifeRoles = LifeRoles_
	Return newItem
End Sub
	
Public Sub getPersonalInfo As clsPersonalInfo
	Return mPersonalInfo
End Sub
	
Public Sub setPersonalInfo(newValue As clsPersonalInfo)
	mPersonalInfo = newValue
End Sub
	
Public Sub getLifeRoles As clsLifeRoles
	Return mLifeRoles
End Sub
	
Public Sub setLifeRoles(newValue As clsLifeRoles)
	mLifeRoles = newValue
End Sub
	
'Add Class-specific Subs and Calls to other Class Public Subs Here_________________________________________
	
'__________________________________________________________________________________________________________
	
#Region Delegate Subs
	
Public Sub getVitalStats As clsVitalStats
	Return mPersonalInfo.VitalStats
End Sub
	
Public Sub getFullName As String
	Return mPersonalInfo.VitalStats.FullName
End Sub
	
Public Sub setFullName(newValue As String)
	mPersonalInfo.VitalStats.FullName = newValue
End Sub
	
Public Sub getPreferredGender As String
	Return mPersonalInfo.VitalStats.PreferredGender
End Sub
	
Public Sub setPreferredGender(newValue As String)
	mPersonalInfo.VitalStats.PreferredGender = newValue
End Sub
	
Public Sub getBirthdate As Long
	Return mPersonalInfo.VitalStats.Birthdate
End Sub
	
Public Sub setBirthdate(newValue As Long)
	mPersonalInfo.VitalStats.Birthdate = newValue
End Sub
	
Public Sub getContact As clsContact
	Return mPersonalInfo.Contact
End Sub
	
Public Sub getAddress As String
	Return mPersonalInfo.Contact.Address
End Sub
	
Public Sub setAddress(newValue As String)
	mPersonalInfo.Contact.Address = newValue
End Sub
	
Public Sub getPhones As List
	Return mPersonalInfo.Contact.Phones
End Sub
	
Public Sub getEmails As List
	Return mPersonalInfo.Contact.Emails
End Sub
	
Public Sub getFinancial As clsFinancial
	Return mPersonalInfo.Financial
End Sub
	
Public Sub getIncomes As List
	Return mPersonalInfo.Financial.Incomes
End Sub
	
Public Sub getBanks As List
	Return mPersonalInfo.Financial.Banks
End Sub
	
Public Sub getCreditCards As List
	Return mPersonalInfo.Financial.CreditCards
End Sub
	
Public Sub getAssets As List
	Return mPersonalInfo.Financial.Assets
End Sub
	
Public Sub getEmployment As clsEmployment
	Return mPersonalInfo.Employment
End Sub
	
Public Sub getEmployers As List
	Return mPersonalInfo.Employment.Employers
End Sub
	
Public Sub getHistory As clsHistory
	Return mPersonalInfo.History
End Sub
	
Public Sub getEducationStages As List
	Return mPersonalInfo.History.EducationStages
End Sub
	
Public Sub getHealthConditions As List
	Return mPersonalInfo.History.HealthConditions
End Sub
	
Public Sub getPastEmployements As List
	Return mPersonalInfo.History.PastEmployements
End Sub
	
Public Sub getLegalSituations As List
	Return mPersonalInfo.History.LegalSituations
End Sub
	
Public Sub getParentOf As List
	Return mLifeRoles.ParentOf
End Sub
	
Public Sub getSpousePartnerOf As List
	Return mLifeRoles.SpousePartnerOf
End Sub
	
Public Sub getSiblingOf As List
	Return mLifeRoles.SiblingOf
End Sub
	
Public Sub getChildOf As List
	Return mLifeRoles.ChildOf
End Sub
	
#End Region
	
