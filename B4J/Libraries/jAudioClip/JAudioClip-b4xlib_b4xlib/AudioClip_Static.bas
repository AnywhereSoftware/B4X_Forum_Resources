B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.51
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

'When cycleCount is set to this value, the AudioClip will loop continuously until stopped.
Public Sub INDEFINITE As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.scene.media.AudioClip")
	Return TJO.GetField("INDEFINITE")
End Sub
'Create an AudioClip loaded from the supplied source URL.
Public Sub NewAudioClip(Source As String) As AudioClip
	Dim TObj As AudioClip
	TObj.Initialize
	TObj.Create(Source)
	Return TObj
End Sub

'Create an AudioClip loaded from the supplied source Folder and FileName.
Public Sub NewAudioClip2(Folder As String, Filename As String) As AudioClip
	Dim TObj As AudioClip
	TObj.Initialize
	TObj.Create(File.GetUri(Folder,Filename))
	Return TObj
End Sub