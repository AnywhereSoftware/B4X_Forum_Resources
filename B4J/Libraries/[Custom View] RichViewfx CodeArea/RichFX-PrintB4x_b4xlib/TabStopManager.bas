B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4.19
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
		Public SpaceChar As String = Chr(0x00A0)		'No Breaking Space
End Sub
	Public Sub ReplaceTabs(Text As String,Count As Int) As String
		Dim SpaceStr As String
		For i = 0 To Count - 1
			SpaceStr = SpaceStr & SpaceChar
		Next
		Return Text.Replace(TAB,SpaceStr)
	End Sub

	Public Sub ReplaceSpaces(Text As String,Count As Int) As String
		Dim SpaceStr As String
		For i = 0 To Count - 1
			SpaceStr = SpaceStr & SpaceChar
		Next
		Return Text.Replace(SpaceStr,TAB)
	End Sub
	
	Public Sub ReplaceExisting(Text As String,Value As Int) As String
		Dim CurrVal As String = Main.KVS.GetDefault("TabSpaces",4)
		
		Dim SpaceStr As String = ""
		For i = 0 To CurrVal - 1
			SpaceStr = SpaceStr & SpaceChar
		Next
		
		Dim NewSpaceStr As String
		For i = 0 To Value - 1
			NewSpaceStr = NewSpaceStr & SpaceChar
		Next
		Main.KVS.Put("TabSpaces",Value)
		
		Return Text.Replace(SpaceStr, NewSpaceStr)
End Sub