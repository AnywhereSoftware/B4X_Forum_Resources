B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.3
@EndOfDesignText@
'Code module

Private Sub Process_Globals
	Private kvs As KeyValueStore
	Private xui As XUI
	Private IsInitialized As Boolean = False
	Private DefaultValueMap As Map
End Sub

Public Sub Initialize
	If DefaultValueMap.IsInitialized = False Then DefaultValueMap.Initialize
	If IsInitialized Then Return
		#If B4J
	kvs.Initialize(File.DirApp,"as_settings.db")
	#Else
	kvs.Initialize(xui.DefaultFolder,"as_settings.db")
	#End If
	'kvs.DeleteAll
	IsInitialized = True
End Sub

Public Sub GetProperty(PropertyName As String) As Object
	Initialize
	If DefaultValueMap.ContainsKey(PropertyName) Then
		Return kvs.GetDefault(PropertyName,DefaultValueMap.Get(PropertyName))
	Else
		Return kvs.Get(PropertyName)
	End If
End Sub

Public Sub GetPropertyDisplayValueText(PropertyName As String) As Object
	Initialize	
	Return kvs.GetDefault(PropertyName & "_DisplayValueText","")
End Sub

'Gets a property value, if no value has been stored by this property yet, the default value is returned
Public Sub GetPropertyDefault(PropertyName As String,DefaultValue As Object) As Object
	Initialize
	Return kvs.GetDefault(PropertyName,DefaultValue)
End Sub

Public Sub PutProperty(PropertyName As String,Value As Object)
	Initialize
	kvs.Put(PropertyName,Value)
End Sub

Public Sub PutPropertyDisplayValueText(PropertyName As String,DisplayValueText As Object)
	Initialize
	kvs.Put(PropertyName & "_DisplayValueText",DisplayValueText)
End Sub

Public Sub RemoveProperty(PropertyName As String)
	Initialize
	kvs.Remove(PropertyName)
	kvs.Remove(PropertyName & "_DisplayValueText")
End Sub
'Deletes all data from the store
Public Sub DeleteAllProperties
	Initialize
	kvs.DeleteAll
End Sub

Public Sub getKeyValueStore As KeyValueStore
	Return kvs
End Sub

'Defines the default value globally for this property
'You can call GetProperty and this specified value is taken as the default value
'No need to call GetPropertyDefault anymore
'<code>
'AS_Properties.SetDefaultValue("MyTestProp","DefaultValue3")
'Log(AS_Properties.GetProperty("MyTestProp"))
'</code>
Public Sub SetDefaultValue(PropertyName As String,DefaultValue As Object)
	Initialize
	DefaultValueMap.Put(PropertyName,DefaultValue)
End Sub

'Returns the default value that was set with SetDefaultValue
Public Sub GetDefaultValue(PropertyName As String) As Object
	Return DefaultValueMap.Get(PropertyName)
End Sub
