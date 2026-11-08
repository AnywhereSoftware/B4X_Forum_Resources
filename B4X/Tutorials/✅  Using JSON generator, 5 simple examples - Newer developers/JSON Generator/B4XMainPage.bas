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
	Private Root As B4XView
	Private XUI As XUI

	Private JSONGenerator As JSONGenerator
End Sub

Public Sub Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	'Working with JSON tutorial link below for JSON Structure and Arrays as JSON
	'https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/JSON

	GenerateJSON
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub GenerateJSON
#If Basic_JSON_1
'	Dim MapMain As Map
'		MapMain.Initialize
'		MapMain.Put("Name", "Peter Simpson")
'		MapMain.Put("age", 99)
'		MapMain.Put("Occupation", "Programmer")
'		MapMain.Put("Location", "B91, Solihull")
'		MapMain.Put( "Phone", "+44 121 705 0000")

	'The 1 line below gives the exact same result as the 7 commented out lines above
	Dim MapMain As Map = CreateMap("Name": "Peter Simpson", "Age": 99, "Occupation": "Programmer", "Location": "B91, Solihull", "Phone": "+44 121 705 0000")

	JSONGenerator.Initialize(MapMain)
#Else If Basic_JSON_2
	'Dim Phones As List = Array As String ("Nexus 4", "Nexus 5", "Nexus 6P", "Pixel 2 XL"  ,"Pixel 3 XL", "Pixel 4 XL", "Pixel 5")

	'The line directly below gives the exact same result as the commented out line above
	Dim Phones() As String = Array As String ("Nexus 4", "Nexus 5", "Nexus 6P", "Pixel 2 XL"  ,"Pixel 3 XL", "Pixel 4 XL", "Pixel 5")
	Dim MapMain As Map = CreateMap("Name": "Peter Simpson", "Age": 99, "Occupation": "Programmer", "Location": "B91, Solihull", "Phone": "+44 121 705 0000", "\Phones": Phones) 'You can remove the '\' backslash in \Phones

	JSONGenerator.Initialize(MapMain)
#Else If Basic_JSON_3
	Dim MapMain As Map = CreateMap("version": "1.0.1", "title": "Sample Pet Store App", "description": "This is a sample server for a pet store.", "termsOfService": "http://example.com/terms/")
		MapMain.Put("license", CreateMap("name": "Apache 2.0", "url": "https://www.apache.org/licenses/LICENSE-2.0.html"))
		MapMain.Put("contact", CreateMap("name": "API Support", "url": "http://www.example.com/support", "email": "support@example.com"))

	JSONGenerator.Initialize(MapMain)
#Else If JSONStructure
	Dim MapMain As Map = CreateMap("Squad name": "Super hero squad", "\Home town": "Metro city", "Formed": 2016, "Secret base": "Super tower", "Active": True) 'You can remove the '\' backslash in \Home town

	Dim MapMembers As Map
		MapMembers.Initialize

	Dim LstMembersInfo As List
		LstMembersInfo.Initialize

	MapMembers = CreateMap("name": "Molecule Man", "\age": 29, "secretIdentity": "Dan Jukes") 'You can remove the '\' backslash in \age
	MapMembers.Put("Powers", Array As String ("Radiation resistance", "Turning tiny", "Radiation blast"))
	LstMembersInfo.Add(MapMembers)

	MapMembers = CreateMap("name": "Madame Uppercut", "\age": 39, "secretIdentity": "Jane Wilson") 'You can remove the '\' backslash in \age
	MapMembers.Put("Powers", Array As String ("Million tonne punch", "Damage resistance", "Superhuman reflexes"))
	LstMembersInfo.Add(MapMembers)

	MapMembers = CreateMap("name": "Eternal Flame", "\age": 1000000, "secretIdentity": "Unknown") 'You can remove the '\' backslash in \age
	MapMembers.Put("Powers", Array As String ("Immortality", "Heat Immunity", "Inferno", "Teleportation", "Interdimensional travel"))
	LstMembersInfo.Add(MapMembers)

	MapMain.Put("Members", LstMembersInfo)

	JSONGenerator.Initialize(MapMain)
#Else If ArraysJSON
	Dim MapMembers As Map
		MapMembers.Initialize

	Dim LstMembersInfo As List
		LstMembersInfo.Initialize

	Dim LstMain As List
		LstMain.Initialize

	MapMembers = CreateMap("name": "Molecule Man", "\age": 29, "secretIdentity": "Dan Jukes") 'You can remove the '\' backslash in \age
	MapMembers.Put("powers", Array As String ("Radiation resistance", "Turning tiny", "Radiation blast"))
	LstMain.Add(MapMembers)

	MapMembers = CreateMap("name": "Madame Uppercut", "\age": 39, "secretIdentity": "Jane Wilson") 'You can remove the '\' backslash in \age
	MapMembers.Put("powers", Array As String ("Million tonne punch", "Damage resistance", "Superhuman reflexes"))
	LstMain.Add(MapMembers)

	JSONGenerator.Initialize2(LstMain)
#End If

	Log(JSONGenerator.ToPrettyString(5).Replace("\", "")) 'PLEASE NOTE: The output is valid with or without the escaped '\'
End Sub

'******************************************************************************************
'*       THE ACTIVE CODE ABOVE WILL CREATE A JSON OUTPUT THAT MATCHED THE FOLLOWING       *
'*     EVERYTING BELOW CAN BE DELETED AS IT'S ONLY THERE FOR VISUAL MATCHING PURPOSES     *
'*     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^     *
'******************************************************************************************

#If Basic_JSON_1
Dim Basic_JSON_1_DIM_NOT_USED As String = _ 
$"
{
  "Name": "Peter Simpson",
  "Age": 99,
  "Location": "B91, Solihull",  
  "Occupation": "Programmer",
  "Phone": "+44 121 705 0000"
}
"$
#Else If Basic_JSON_2
Dim Basic_JSON_2_DIM_NOT_USED As String = _ 
$"
{
  "Occupation": "Programmer",
  "Phone": "+44 121 705 0000",
  "Age": 99,
  "Name": "Peter Simpson",
  "Location": "B91, Solihull",
  "Phones": [
       "Nexus 4",
       "Nexus 5",
       "Nexus 6P",
       "Pixel 2 XL",
       "Pixel 3 XL",
       "Pixel 4 XL",
       "Pixel 5"
  ]
}
"$
#ELSE If Basic_JSON_3
Dim Basic_JSON_3_DIM_NOT_USED As String = _ 
$"
{
  "title": "Sample Pet Store App",
  "description": "This is a sample server for a pet store.",
  "termsOfService": "http://example.com/terms/",
  "contact": {
    "name": "API Support",
    "url": "http://www.example.com/support",
    "email": "support@example.com"
  },
  "license": {
    "name": "Apache 2.0",
    "url": "https://www.apache.org/licenses/LICENSE-2.0.html"
  },
  "version": "1.0.1"
}
"$
#Else If JSONStructure
Dim JSONStructure_DIM_NOT_USED As String = _ 
$"
{
  "Squad name": "Super hero squad",
  "Home town": "Metro city",
  "Formed": 2016,
  "Secret base": "Super tower",
  "Active": true,
  "Members": [
    {
      "name": "Molecule Man",
      "age": 29,
      "secretIdentity": "Dan Jukes",
      "Powers": [
        "Radiation resistance",
        "Turning tiny",
        "Radiation blast"
      ]
    },
    {
      "name": "Madame Uppercut",
      "age": 39,
      "secretIdentity": "Jane Wilson",
      "Powers": [
        "Million tonne punch",
        "Damage resistance",
        "Superhuman reflexes"
      ]
    },
    {
      "name": "Eternal Flame",
      "age": 1000000,
      "secretIdentity": "Unknown",
      "Powers": [
        "Immortality",
        "Heat Immunity",
        "Inferno",
        "Teleportation",
        "Interdimensional travel"
      ]
    }
  ]
}
"$
#Else If ArraysJSON
Dim ArraysJSON_DIM_NOT_USED As String = _ 
$"
[
  {
    "name": "Molecule Man",
    "age": 29,
    "secretIdentity": "Dan Jukes",
    "Powers": [
      "Radiation resistance",
      "Turning tiny",
      "Radiation blast"
    ]
  },
  {
    "name": "Madame Uppercut",
    "age": 39,
    "secretIdentity": "Jane Wilson",
    "Powers": [
      "Million tonne punch",
      "Damage resistance",
      "Superhuman reflexes"
    ]
  }
]
"$
#End If
