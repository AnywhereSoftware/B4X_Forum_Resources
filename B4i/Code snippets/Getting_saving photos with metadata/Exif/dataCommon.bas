B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6
@EndOfDesignText@
'Code module

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.

	Public  booleanIsLocationValid                                              As Boolean
	Public  doubleLastMagneticHeading                                           As Double
	Public  doubleLastTrueHeading                                               As Double
	Public  locationCurrent                                                     As Location

End Sub