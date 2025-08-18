Type=Class
Version=2.75
ModulesStructureVersion=1
B4J=true
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private fx As JFX
	Private NativeMe As JavaObject
End Sub

Public Sub Initialize
	NativeMe = Me
	Log(NativeMe.RunMethod("Test", Null))
End Sub

#If JAVA
public String Test() {
	return "Hello world from class!";
}
#End If