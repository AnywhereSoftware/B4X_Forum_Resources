B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private VelocityObj As JavaObject
	Private ContextObj As JavaObject
	Private TemplateObj As JavaObject
	Private StringWriterObj As JavaObject
	Private PropertiesObj As JavaObject
	Private Content As String
End Sub

'Initializes the object. You can pass a default directory inside Objects directory
Public Sub Initialize (Directory As String)
	VelocityObj.InitializeStatic("org.apache.velocity.app.Velocity")
	ContextObj.InitializeNewInstance("org.apache.velocity.VelocityContext", Null)
	TemplateObj.InitializeNewInstance("org.apache.velocity.Template", Null)
	StringWriterObj.InitializeNewInstance("java.io.StringWriter", Null)
	If Directory.Length > 0 Then
		PropertiesObj.InitializeNewInstance("java.util.Properties", Null)
		PropertiesObj.RunMethod("setProperty", Array("resource.loader.file.path", Directory))
		VelocityObj.RunMethod("init", Array(PropertiesObj))
	Else
		VelocityObj.RunMethod("init", Null)
	End If
End Sub

' Put Context with Key Value pair 
Public Sub put (Key As Object, Value As Object)	
	ContextObj.RunMethod("put", Array(Key, Value))
End Sub

' Put Context by passing a Map
Public Sub putMap (m As Map)
	For Each key In m.Keys
		ContextObj.RunMethod("put", Array(key, m.Get(key)))
	Next
End Sub

' Get the Context by Key
Public Sub get (Key As String) As Object
	Return ContextObj.RunMethod("get", Array(Key))
End Sub

' Load a Template file
Public Sub setTemplate (TemplateFile As String)
	TemplateObj = VelocityObj.RunMethod("getTemplate", Array(TemplateFile))
End Sub

' Merge Template with Context and pass to StringWriter
Public Sub merge
	TemplateObj.RunMethodJO("merge", Array(ContextObj, StringWriterObj))
End Sub

' Merge a Template with Context and pass to StringWriter
Public Sub mergeTemplate (TemplateFile As String, Encoding As String)
	VelocityObj.RunMethod("mergeTemplate", Array As Object(TemplateFile, Encoding, ContextObj, StringWriterObj))
End Sub

' Evaluate TemplateString
Public Sub evaluate (Tag As String, TemplateString As String)
	VelocityObj.RunMethodJO("evaluate", Array(ContextObj, StringWriterObj, Tag, TemplateString))
End Sub

' Return StringWriter as String
Public Sub getToString As String
	Content = StringWriterObj.RunMethod("toString", Null)
	StringWriterObj.RunMethod("close", Null)
	Return Content
End Sub