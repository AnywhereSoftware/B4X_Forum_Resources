B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.51
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	
End Sub

Public Sub New(WV As WebView) As WebEngine
	Dim WVJO As JavaObject = WV
	Dim WE As WebEngine
	WE.Initialize
	WE.SetObject(WVJO.RunMethod("getEngine",Null))
	Return WE
End Sub
