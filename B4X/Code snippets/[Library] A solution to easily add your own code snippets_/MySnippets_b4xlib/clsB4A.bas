B4A=true
Group=CLASSES\B4A
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Public Views As clsB4AViews
	Public DateAndTime As clsB4ADateTime
	Public Strings As clsB4AStrings
	Public DB As clsB4ADB
End Sub

Public Sub Initialize
	Views.Initialize
	DateAndTime.Initialize
	Strings.Initialize
	DB.Initialize
End Sub