B4A=true
Group=CLASSES\B4X
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Public Views As clsB4XViews
	Public DateAndTime As clsB4XDateTime
	Public Strings As clsB4XStrings
	Public DB As clsB4XDB
End Sub

Public Sub Initialize
	Views.Initialize
	DateAndTime.Initialize
	Strings.Initialize
	DB.Initialize
End Sub