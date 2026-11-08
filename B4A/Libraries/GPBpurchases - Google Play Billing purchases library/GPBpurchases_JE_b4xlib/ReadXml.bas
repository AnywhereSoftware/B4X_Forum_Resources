B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private nativeMe As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(EventName As String)
	nativeMe = Me
End Sub

Sub Locale(item As String) As String
'	nativeMe.InitializeContext
	Dim id As Int = nativeMe.RunMethod("getResourceId", Array("string", item))
	If id > 0 Then
		Return nativeMe.RunMethod("GetString", Array(id))
	Else
		Return item
	End If
End Sub

Sub Plural(item As String, count As Int) As String
	Dim id As Int = nativeMe.RunMethod("getResourceId", Array("plurals", item))
	If id > 0 Then
		Return nativeMe.RunMethod("FormatPlural", Array(id, count))
	Else
		Return item
	End If
End Sub

#If JAVA

public int getResourceId(String type, String name) {
        return BA.applicationContext.getResources().getIdentifier(name, type, BA.packageName);
    }
public String FormatPlural(int id, int count) {
        return BA.applicationContext.getResources().getQuantityString(id, count, count);
    }
public String GetString(int id) {
        return BA.applicationContext.getResources().getString(id);
    }
#End If