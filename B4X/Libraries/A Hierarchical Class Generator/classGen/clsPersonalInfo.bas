B4J=True
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	Private mVitalStats As clsVitalStats
	Private mContact As clsContact
	Private mFinancial As clsFinancial
	Private mEmployment As clsEmployment
	Private mHistory As clsHistory
End Sub
	
Public Sub Initialize
End Sub
	
Public Sub New(VitalStats_ As clsVitalStats, Contact_ As clsContact, Financial_ As clsFinancial, Employment_ As clsEmployment, History_ As clsHistory) As clsPersonalInfo
	Dim newItem As clsPersonalInfo
	newItem.Initialize
	newItem.mVitalStats = VitalStats_
	newItem.mContact = Contact_
	newItem.mFinancial = Financial_
	newItem.mEmployment = Employment_
	newItem.mHistory = History_
	Return newItem
End Sub
	
Public Sub getVitalStats As clsVitalStats
	Return mVitalStats
End Sub
	
Public Sub setVitalStats(newValue As clsVitalStats)
	mVitalStats = newValue
End Sub
	
Public Sub getContact As clsContact
	Return mContact
End Sub
	
Public Sub setContact(newValue As clsContact)
	mContact = newValue
End Sub
	
Public Sub getFinancial As clsFinancial
	Return mFinancial
End Sub
	
Public Sub setFinancial(newValue As clsFinancial)
	mFinancial = newValue
End Sub
	
Public Sub getEmployment As clsEmployment
	Return mEmployment
End Sub
	
Public Sub setEmployment(newValue As clsEmployment)
	mEmployment = newValue
End Sub
	
Public Sub getHistory As clsHistory
	Return mHistory
End Sub
	
Public Sub setHistory(newValue As clsHistory)
	mHistory = newValue
End Sub
	
'Add Class-specific Subs and Calls to other Class Public Subs Here_________________________________________
	
'__________________________________________________________________________________________________________
	
#Region Delegate Subs
	
Public Sub getFullName As String
	Return mVitalStats.FullName
End Sub
	
Public Sub setFullName(newValue As String)
	mVitalStats.FullName = newValue
End Sub
	
Public Sub getPreferredGender As String
	Return mVitalStats.PreferredGender
End Sub
	
Public Sub setPreferredGender(newValue As String)
	mVitalStats.PreferredGender = newValue
End Sub
	
Public Sub getBirthdate As Long
	Return mVitalStats.Birthdate
End Sub
	
Public Sub setBirthdate(newValue As Long)
	mVitalStats.Birthdate = newValue
End Sub
	
Public Sub getAddress As String
	Return mContact.Address
End Sub
	
Public Sub setAddress(newValue As String)
	mContact.Address = newValue
End Sub
	
Public Sub getPhones As List
	Return mContact.Phones
End Sub
	
Public Sub getEmails As List
	Return mContact.Emails
End Sub
	
Public Sub getIncomes As List
	Return mFinancial.Incomes
End Sub
	
Public Sub getBanks As List
	Return mFinancial.Banks
End Sub
	
Public Sub getCreditCards As List
	Return mFinancial.CreditCards
End Sub
	
Public Sub getAssets As List
	Return mFinancial.Assets
End Sub
	
Public Sub getEmployers As List
	Return mEmployment.Employers
End Sub
	
Public Sub getEducationStages As List
	Return mHistory.EducationStages
End Sub
	
Public Sub getHealthConditions As List
	Return mHistory.HealthConditions
End Sub
	
Public Sub getPastEmployements As List
	Return mHistory.PastEmployements
End Sub
	
Public Sub getLegalSituations As List
	Return mHistory.LegalSituations
End Sub
	
#End Region
	
