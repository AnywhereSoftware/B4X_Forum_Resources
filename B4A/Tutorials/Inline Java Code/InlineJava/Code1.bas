Type=StaticCode
Version=4.1
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
'Code module
Sub Process_Globals
	Private nativeMe As JavaObject
End Sub

Public Sub Init
	'lower cased module name
	nativeMe.InitializeStatic(Application.PackageName & ".code1") 
	nativeMe.RunMethod("Test", Null)
End Sub

#If JAVA
public static void Test() { //static!!!
	BA.Log("Test");
}
#End If