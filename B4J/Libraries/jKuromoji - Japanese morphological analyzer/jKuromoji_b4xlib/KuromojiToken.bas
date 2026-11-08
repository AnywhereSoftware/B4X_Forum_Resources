B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	Private mToken As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(token As JavaObject)
	mToken=token
End Sub

Public Sub getSurface As String
	Return mToken.RunMethod("getSurface",Null)
End Sub

Public Sub getAllFeatures As String
	Return mToken.RunMethod("getAllFeatures",Null)
End Sub

Public Sub getPartOfSpeechLevel1 As String
	Return mToken.RunMethod("getPartOfSpeechLevel1",Null)
End Sub

Public Sub getPartOfSpeechLevel2 As String
	Return mToken.RunMethod("getPartOfSpeechLevel2",Null)
End Sub

Public Sub getPartOfSpeechLevel3 As String
	Return mToken.RunMethod("getPartOfSpeechLevel3",Null)
End Sub

Public Sub getPartOfSpeechLevel4 As String
	Return mToken.RunMethod("getPartOfSpeechLevel4",Null)
End Sub

Public Sub getConjugationType As String
	Return mToken.RunMethod("getConjugationType",Null)
End Sub

Public Sub getConjugationForm As String
	Return mToken.RunMethod("getConjugationForm",Null)
End Sub

Public Sub getBaseForm As String
	Return mToken.RunMethod("getBaseForm",Null)
End Sub

Public Sub getReading As String
	Return mToken.RunMethod("getReading",Null)
End Sub

Public Sub getPronunciation As String
	Return mToken.RunMethod("getPronunciation",Null)
End Sub
