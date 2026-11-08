B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.8
@EndOfDesignText@
'SPGenerator 1.0 by T201016
Private Sub Class_Globals
	
	Type MyTypeStrings(AlphaLower As String,AlphaUpper As String,Numeric As String,Special As String,Chars As String,password As String)
	Private mts As MyTypeStrings

	Type MyTypeInteger(PassLen As Int,charsLength As Int,rndNum As Int)
	Private mti As MyTypeInteger
	
	Type MyTypeBoolean(useAlphaLower As Boolean,useAlphaUpper As Boolean,useNumeric As Boolean,useSpecial As Boolean)
	Private mtb As MyTypeBoolean
End Sub

Public Sub Initialize(passLength As Int,lowerAZ As Boolean,upperAZ As Boolean, num09 As Boolean,SpecialChars As Boolean)
	mti.PassLen = passLength
	mtb.useAlphaLower = lowerAZ
	mtb.useAlphaUpper = upperAZ
	mtb.useNumeric = num09
	mtb.useSpecial = SpecialChars

	mts.AlphaLower = "qwertyuioplkjhgfdsazxcvbnm"
	mts.AlphaUpper = "QWERTYUIOPLKJHGFDSAZXCVBNM"
	mts.Numeric = "0987654321"
	mts.Special = "{~`\|&^.-+=_,!@$#*%<>[]/}"
	mts.Chars = ""
End Sub

Public Sub generatePassword As String
	If  mti.PassLen > 0 Then
		If mtb.useAlphaLower = True Then
			mts.Chars = mts.Chars & mts.AlphaLower
		End If
		If mtb.useAlphaUpper = True Then
			mts.Chars = mts.Chars & mts.AlphaUpper
		End If
		If mtb.useNumeric = True Then
			mts.Chars = mts.Chars & mts.Numeric
		End If
		If mtb.useSpecial = True Then
			mts.Chars = mts.Chars & mts.Special
		End If
		mti.PassLen = mti.PassLen
	Else
		mts.Chars = mts.AlphaLower & mts.AlphaUpper & mts.Numeric
		mti.PassLen = 8
	End If

	mti.charsLength = mts.Chars.Length
	mts.password = ""

	For i = 1 To mti.PassLen
		mti.rndNum = Rnd(0,mti.charsLength - 1)
		mts.password =  mts.password & mts.Chars.CharAt(mti.rndNum)
	Next

	Return mts.password
End Sub
