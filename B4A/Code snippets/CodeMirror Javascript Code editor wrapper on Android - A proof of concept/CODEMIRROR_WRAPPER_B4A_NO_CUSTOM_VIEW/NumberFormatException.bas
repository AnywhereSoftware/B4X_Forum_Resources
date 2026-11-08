B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@

'Class Module

#IgnoreWarnings: 12

Sub Class_Globals
	Private TJO As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

'Constructs an IllegalArgumentException with the specified detail message.
Public Sub Create(S As String)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("java.lang.NumberFormatException",Array As Object(S))
End Sub

'Appends the specified exception to the exceptions that were suppressed in order to deliver this exception.
Public Sub AddSuppressed(Exception As JavaObject)
	TJO.RunMethod("addSuppressed",Array As Object(Exception))
End Sub
'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub
'Fills in the execution stack trace.
Public Sub FillInStackTrace As JavaObject
	Return TJO.RunMethod("fillInStackTrace",Null)
End Sub
'Returns the cause of this throwable or null if the cause is nonexistent or unknown.
Public Sub GetCause As JavaObject
	Return TJO.RunMethod("getCause",Null)
End Sub
'Creates a localized description of this throwable.
Public Sub GetLocalizedMessage As String
	Return TJO.RunMethod("getLocalizedMessage",Null)
End Sub
'Returns the detail message string of this throwable.
Public Sub GetMessage As String
	Return TJO.RunMethod("getMessage",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return TJO
End Sub
'Provides programmatic access to the stack trace information printed by printStackTrace().
Public Sub GetStackTrace As JavaObject
	Return TJO.RunMethod("getStackTrace",Null)
End Sub
'Returns an array containing all of the exceptions that were suppressed, typically by the try-with-resources statement, in order to deliver this exception.
Public Sub GetSuppressed As JavaObject
	Return TJO.RunMethod("getSuppressed",Null)
End Sub
'Initializes the cause of this throwable to the specified value.
Public Sub InitCause(Cause As JavaObject) As JavaObject
	Return TJO.RunMethod("initCause",Array As Object(Cause))
End Sub
'Prints this throwable and its backtrace to the standard error stream.
Public Sub PrintStackTrace
	TJO.RunMethod("printStackTrace",Null)
End Sub
'Prints this throwable and its backtrace to the specified print stream.
Public Sub PrintStackTrace2(S As JavaObject)
	TJO.RunMethod("printStackTrace",Array As Object(S))
End Sub
'Prints this throwable and its backtrace to the specified print writer.
Public Sub PrintStackTrace3(S As JavaObject)
	TJO.RunMethod("printStackTrace",Array As Object(S))
End Sub
'Sets the stack trace elements that will be returned by getStackTrace() and printed by printStackTrace() and related methods.
Public Sub SetStackTrace(StackTrace() As JavaObject)
	TJO.RunMethod("setStackTrace",Array As Object(StackTrace))
End Sub
'Returns a short description of this throwable.
Public Sub ToString As String
	Return TJO.RunMethod("toString",Null)
End Sub

'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub

