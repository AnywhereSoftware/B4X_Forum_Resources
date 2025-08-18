B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.5
@EndOfDesignText@
'StateManager - derived from original posted on B4X.com
'Code module
Sub Process_Globals
	Dim settingsFileName As String = "BTscanner.properties"
	Dim settings As Map
	Dim ourDir As String
End Sub

Public Sub GetDir As String
#if B4A
	Return File.DirInternal
#Else If B4I
	Return File.DirDocuments
#Else If B4J
	Return File.DirData("BTscanner")
#Else
	Return ""
#End If
End Sub

Public Sub GetSetting2(Key As String, DefaultValue As String) As String
	If settings.IsInitialized = False Then
		'load the stored settings
		ourDir = GetDir
		If File.Exists(ourDir, settingsFileName) Then
			settings = File.ReadMap(ourDir, settingsFileName)
		Else
			Return DefaultValue
		End If
	End If
	Dim v As String
	v = settings.GetDefault(Key.ToLowerCase, DefaultValue)
	Return v
End Sub

Public Sub GetSetting(Key As String) As String
	Return GetSetting2(Key, "")
End Sub

Public Sub SetSetting(Key As String, Value As String)
	If settings.IsInitialized = False Then
		'load the stored settings
		ourDir = GetDir
		If File.Exists(ourDir, settingsFileName) Then
			settings = File.ReadMap(ourDir, settingsFileName)
		Else
			settings.Initialize
		End If
	End If
	settings.Put(Key.ToLowerCase, Value)
End Sub

'Store the settings in a file
Public Sub SaveSettings
	If settings.IsInitialized Then
		File.WriteMap(ourDir, settingsFileName, settings)
	End If
End Sub
