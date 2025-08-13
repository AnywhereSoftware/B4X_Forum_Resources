B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private XUI As XUI
	Public Const DOC_ABBREVIATION As String = "abbreviation"
	Public Const DOC_CITY As String = "city"
	Public Const DOC_CONTINENT As String = "continent"
	Public Const DOC_COUNTRY As String = "country"
	Public Const DOC_CURRENCY_NAME As String = "currency_name"
	Public Const DOC_POPULATION As String = "population"
	Public Const DOC_TEMPERATURE As String = "temperature"
	Public Const DOC__ID As String = "_id"
	Public Const DOC__REVISION As String = "_revision"
	Public Const DOC__MODIFIED As String = "_modified"

	Public DB As Nitrite
End Sub

Public Sub Initialize
	DB = Nitrite_Static.Builder _
	.FilePath(XUI.DefaultFolder,"countries.db") _
	.OpenOrCreate
End Sub
