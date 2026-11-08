B4A=true
Group=CLASSES\B4J
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Public Views As clsB4JViews
	Public DateAndTime As clsB4JDateTime
	Public Strings As clsB4JStrings
	Public DB As clsB4JDB
End Sub

Public Sub Initialize
	Views.Initialize
	DateAndTime.Initialize
	Strings.Initialize
	DB.Initialize
End Sub