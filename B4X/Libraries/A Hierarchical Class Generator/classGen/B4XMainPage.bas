B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Type classNode(name As String, index As Int, parent As String, children As List, level As Int, displayRect As B4XRect)
	Private Root As B4XView
	Private xui As XUI
	Private cG As classGenerator

'Place the following in B4XMainPage: Sub Class_Globals
	Private PersonHood As clsPersonHood
	Private PersonalInfo As clsPersonalInfo
	Private LifeRoles As clsLifeRoles
	Private VitalStats As clsVitalStats
	Private Contact As clsContact
	Private Financial As clsFinancial
	Private Employment As clsEmployment
	Private History As clsHistory
End Sub

Public Sub Initialize
	DateTime.DateFormat = "yyyy-MM-dd"
	
	'Place the following in B4XMainPage: Public Sub Initialize
	PersonHood.Initialize
	PersonalInfo.Initialize
	LifeRoles.Initialize
	VitalStats.Initialize
	Contact.Initialize
	Financial.Initialize
	Employment.Initialize
	History.Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1

	generateClasses		'not needed after first time, but it won't hurt much if you forget to comment it out
						'you can also use it to see the class tree 
	
	Dim WiL As clsPersonHood = PersonHood.New(PersonalInfo.New( _
			VitalStats.New("William Lancee", "Male", DateTime.DateParse("1946-11-19")), _
			Contact.New("205 XXXXXX St., Toronto, ON, Canada"), _
			Financial.New, Employment.New, History.New), LifeRoles.New)
	WiL.Phones.Add("1-(xxx) xxx-xxx1")
	WiL.Phones.Add("1-(xxx) xxx-xxx2")
	WiL.Phones.Add("1-(xxx) xxx-xxx3")	
			
	Log(WiL.FullName)								'	William Lancee
	Log(WiL.PersonalInfo.FullName)					'	William Lancee
	Log(WiL.PersonalInfo.VitalStats.FullName)		'	William Lancee
	
	WiL.FullName = "WiL"
	Log(WiL.FullName)								'	WiL
	Log(WiL.PersonalInfo.FullName)					'	WiL
	Log(WiL.PersonalInfo.VitalStats.FullName)		'	WiL
	
	WiL.Phones.Add("1-(xxx) xxx-xxx4")
	Log(WiL.Phones.Get(WiL.Phones.Size - 1))		'	1-(xxx) xxx-xxx4
	WiL.Phones.RemoveAt(WiL.Phones.Size - 1)
	Log(WiL.Phones.Get(WiL.Phones.Size - 1))		'	1-(xxx) xxx-xxx3

	Log(DateTime.Date(WiL.Birthdate))				'	1946-11-19				'fake

	
End Sub

'_________________Class Generator__When not needed anymore this section can be collapsed__________________________________
#Region Class Generator	
Private Sub generateClasses			'ignore
	Dim tree As String = _
		$"
			PersonHood
				PersonalInfo
					VitalStats
						FullName.String
						PreferredGender.String
						Birthdate.Long
					Contact
						Address.String
						Phones.List
						Emails.List
					Financial
						Incomes.List
						Banks.List
						CreditCards.List
						Assets.List
					Employment
						Employers.List
					History
						EducationStages.List
						HealthConditions.List
						PastEmployements.List
						LegalSituations.List
				LifeRoles
					ParentOf.List
					SpousePartnerOf.List
					SiblingOf.List
					ChildOf.List
		"$
	cG.Initialize(Root)
	cG.parseTree(tree)
	cG.displayTree
#if B4J
	cG.generateClasses
#End If
End Sub
#End Region

