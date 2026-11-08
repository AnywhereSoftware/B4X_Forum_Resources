B4J=true
Group=PrintJobs
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private mWidth As Double
	Private mHeight As Double
End Sub

'Width and Height In PPI
Public Sub Initialize(Width As Double, Height As Double)
	mWidth = Width
	mHeight = Height
	
End Sub

Public Sub getWidth As Double
	Return mWidth
End Sub

Public Sub setWidth(Width As Double)
	mWidth = Width
End Sub

Public Sub getHeight As Double
	Return mHeight
End Sub

Public Sub setHeight(Height As Double)
	mHeight = Height
End Sub