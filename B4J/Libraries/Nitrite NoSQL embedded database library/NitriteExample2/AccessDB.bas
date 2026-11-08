B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private XUI As XUI


	Public Const COLLECTION_NAME As String = "Addresses"
	
	Public Const DOC_FIRST_NAME As String = "first_name"
	Public Const DOC_LAST_NAME As String = "last_name"
	Public Const DOC_COMPANY_NAME As String = "company_name"
	Public Const DOC_ADDRESS As String = "address"
	Public Const DOC_CITY As String = "city"
	Public Const DOC_COUNTY As String = "county"
	Public Const DOC_POSTCODE As String = "postcode"
	Public Const DOC_PHONE1 As String = "phone1"
	Public Const DOC_PHONE2 As String = "phone2"
	Public Const DOC_EMAIL As String = "email"
	Public Const DOC_WEB As String = "web"

	Public Const DOC__ID As String = "_id"
	Public Const DOC__REVISION As String = "_revision"
	Public Const DOC__MODIFIED As String = "_modified"


	Public DB As Nitrite
End Sub

Public Sub Initialize
	DB = Nitrite_Static.Builder _
	.FilePath(XUI.DefaultFolder,"Addresses.db") _
	.OpenOrCreate
End Sub
