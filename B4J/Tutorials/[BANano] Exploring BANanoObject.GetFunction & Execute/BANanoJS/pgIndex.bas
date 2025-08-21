B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private BANano As BANano  'ignore
	Private obj As JSObject
End Sub


Sub Init
	obj.Initialize
	obj.set("living", True)
	obj.set("age", 33)
	obj.set("gender", "male")
	obj.setCallBack("getGender", Me, "getGender", Null)
	
	Log(obj.It)
	Log(obj.ToJSON) 
	Log(obj.getCallBack("getGender"))
End Sub


Sub getGender As String
	Return obj.get("gender")
End Sub