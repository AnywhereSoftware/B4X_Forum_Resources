B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub Throw(Throwable As Object)
	Dim MEJO As JavaObject = Me
	MEJO.RunMethod("throwIt",Array(Throwable))
End Sub

'Constructs an IllegalStateException with the specified detail message.
Public Sub NewIllegalStateException(S As String) As Object
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Dim TJo As JavaObject
	Return TJo.InitializeNewInstance("java.lang.IllegalStateException",Array(S))
End Sub

'Constructs an IllegalArgumentException with the specified detail message.
Public Sub NewIllegalArgumentException(S As String) As Object
	Dim TjO As JavaObject
	Return TjO.InitializeNewInstance("java.lang.IllegalArgumentException",Array(S))
End Sub
#if java
import java.lang.Throwable;

public static void throwIt(Throwable throwable) throws Throwable{
	throw throwable;
}
#End If