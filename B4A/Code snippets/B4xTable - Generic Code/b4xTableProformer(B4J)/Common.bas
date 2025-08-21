B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@

Sub Process_Globals
	Private fx As JFX
	Public SQL As SQL
 
	Public DBName As String
	Public TotColNumber As Int
	Public FrozenCols As Int
	Public ColNames(60) As String                        'Could be a list
	Public ColDataTypes(60) As String					 'Could be a list
End Sub


Sub FullScreen(Form1 As Form)
	Dim joForm As JavaObject = Form1
	Dim joStage As JavaObject = joForm.GetField("stage")
	joStage.RunMethod("setMaximized",Array(True))
End Sub

