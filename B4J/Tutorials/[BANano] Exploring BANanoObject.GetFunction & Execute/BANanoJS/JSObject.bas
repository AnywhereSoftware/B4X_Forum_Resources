B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
Sub Class_Globals
	Private obj As BANanoObject
	Private BANano As BANano  'ignore
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize As JSObject
	'var obj = new Object;
	obj.Initialize2("Object", Null)
	Return Me
End Sub

'set item
Sub set(k As String, v As Object) As JSObject
	obj.SetField(k, v)
	Return Me
End Sub

'get item
Sub get(k As String) As Object
	Dim res As Object = obj.GetField(k)
	Return res
End Sub

'set a callback
Sub setCallBack(k As String, module As Object, methodname As String, params As List)
	Dim cb As BANanoObject = BANano.CallBack(module, methodname, params)
	obj.SetField(k, cb)
End Sub

'get callback
Sub getCallBack(k As String) As BANanoObject
	Dim cb As BANanoObject = obj.GetFunction(k)
	Return cb.Execute(Null)
End Sub

'convert to json
Sub ToJSON As String
	Return BANano.ToJson(obj)
End Sub

'return the object
Sub It As BANanoObject
	Return obj
End Sub