B4A=true
Group=CLASSES
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	#IF B4A
		Public B4A As clsB4A
	#ELSE IF B4J
		Public B4J As clsB4J
	#ELSE IF B4I
		Public B4i As clsB4i
	#End If
	Public B4X As clsB4X
End Sub

Public Sub Initialize
	#IF B4A
		B4A.Initialize
	#ELSE IF B4J
		B4J.Initialize
	#ELSE IF B4I
		B4i.Initialize
	#End If
	B4X.Initialize
End Sub