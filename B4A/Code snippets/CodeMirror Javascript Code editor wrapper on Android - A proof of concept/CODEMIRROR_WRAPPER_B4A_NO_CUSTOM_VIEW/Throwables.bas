B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
Sub Class_Globals
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub Throw(Throwable As Object)
	Dim MEJO As JavaObject = Me
	MEJO.RunMethod("throwIt",Array(CallSub(Throwable,"getObject")))
End Sub

#if java
import java.lang.Throwable;

public static void throwIt(Throwable throwable) throws Throwable{
	throw throwable;
}
#End If