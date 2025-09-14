B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	Private tokenizer As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	tokenizer.InitializeNewInstance("com.atilika.kuromoji.ipadic.Tokenizer",Null)
End Sub

Public Sub tokenize(text As String) As List
	Dim tokens As List = tokenizer.RunMethod("tokenize",Array(text))
	Dim wrappedTokens As List
	wrappedTokens.Initialize
	For Each token As JavaObject In tokens
		Dim wrappedToken As KuromojiToken
		wrappedToken.Initialize(token)
		wrappedTokens.Add(wrappedToken)
	Next
	Return wrappedTokens
End Sub

Public Sub HiraganaToKatakana(kana As String) As String
	
End Sub