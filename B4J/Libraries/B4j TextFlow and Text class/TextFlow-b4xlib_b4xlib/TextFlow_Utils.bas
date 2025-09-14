B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

'Is the passed object part of this Library / Application
Public Sub IsPackageObject(O As Object) As Boolean
	Return GetType(O).StartsWith(GetPackageName)
End Sub

'Return the current PackageName
Public Sub GetPackageName As String
	Dim JO As JavaObject
	JO.InitializeStatic("anywheresoftware.b4a.BA")
	Return JO.GetField("packageName")
End Sub

