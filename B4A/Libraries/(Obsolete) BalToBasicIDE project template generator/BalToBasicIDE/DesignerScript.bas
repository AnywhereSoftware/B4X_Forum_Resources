B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

Sub DiscardLine(line As String) As Boolean
	line = line.ToLowerCase
	If line.IndexOf("autoscale") >= 0 Then Return True ' AutoScale, AutoScaleAll and AutoScaleRate
	If line.IndexOf("activitysize") >= 0 Then Return True '
	If line.IndexOf("landscape") >= 0 Then Return True
	If line.IndexOf("portrait") >= 0 Then Return True
	Return False
End Sub


Sub ReformatLine(line As String, scalevarname As String, scalewidthname As String) As String
	' there's probably a better way of doing this with Regex and stuff but I can't get my head round Regex :(
	' we assume that any full stop is a Control.Property separator and don't try to parse anything else
	Dim idx, idx2 As Int, leftpart, rightpart, control, property As String

	' first we replace any 'Control.Property' references with GetProperty('Control')
	' we assume there are no floating point numbers in a designer script
	idx = line.IndexOf(".")
	' there is probably more than one 'Control.Property' reference per line
	Do While idx > 0
		' split line and lose the '.'
		Dim leftpart As  String = line.SubString2(0, idx)
		Dim rightpart As  String = line.SubString(idx+1)
		
		' go back to find non valid name character or start of line
		idx2 = idx - 1
		Do While idx2 >= 0 And IsValid(leftpart.CharAt(idx2))
			idx2 = idx2 - 1
		Loop
		idx2 = idx2 + 1 ' we are pointing to an invalid character
		control = leftpart.SubString(idx2)
		leftpart = leftpart.SubString2(0, idx2)
		
		' go forward to find non valid name character or end of line
		idx2 = 0
		Do While idx2 < rightpart.Length And IsValid(rightpart.CharAt(idx2))
			idx2 = idx2 + 1
		Loop
		If idx2 <> 0 Then idx = idx2 + 1
		property = rightpart.SubString2(0, idx2)
		rightpart = rightpart.SubString(idx2)
		
		' rebuild the property fetch
		line  = leftpart & "get" & property & "('" & control & "')" & rightpart
		' see if there is another to do
		idx = line.IndexOf2(".", idx+1)
	Loop
	' if the line begins with "If" we need to do no more as there are no assignments within a condition
	If line.Length > 1 And line.Trim.ToLowerCase.SubString2(0,2) <> "if" And _
		(line.Length > 8 And line.Trim.ToLowerCase.SubString2(0,7) <> "else if") Then
		' the line now looks like getProperty('Control') = expression'
		' needs to become setProperty('Control', expression)'
		idx = line.IndexOf(")")
		idx2 = line.IndexOf("=")
		If idx > 0 And idx2 > idx Then
			line = line.SubString2(0, idx) & "," & line.SubString(idx2+1)
			idx = line.IndexOf("get")
			line = line.SubString2(0, idx) & "set" & line.SubString(idx+3) & ")"
		End If
	End If
	' replace any dip references with our own scaling
	' we try and identify in a simple way if it realy is a dip reference and not pat of a control or variable name
	' so it is a bit more complicated that just using String.Replace
	idx = 0
	idx = line.IndexOf2("dip", idx)
	' there is probably more than one 'dip' reference per line
	Do While idx > 0
		' split line and lose the 'dip' if the character preceding 'dip' is numeric
		If IsDigit( line.CharAt(idx-1)) Then
			Dim leftpart As  String = line.SubString2(0, idx)
			Dim rightpart As  String = line.SubString(idx+3)
			' rebuild the dip reference
			line  = leftpart & "*" & scalevarname & rightpart
			' see if there is another to do
		End If
		idx = line.IndexOf2("dip", idx+1)
	Loop		
	' finally replace any %x and %y references with our own scaling
	line = line.Replace("%X", "*" &  scalewidthname & "/100")
	line = line.Replace("%x", "*" & scalewidthname & "/100")
	line = line.Replace("%Y", "*" & scalewidthname & "/100")
	line = line.Replace("%y", "*" & scalewidthname & "/100")
	Return line
End Sub


Private Sub IsDigit(character As Char) As Boolean
	Return Asc(character) >= Asc("0") And Asc(character) <= Asc("9")
End Sub

Private Sub IsAlpha(character As Char) As Boolean
	Dim Lcase As Boolean = Asc(character) >= Asc("a") And Asc(character) <= Asc("z")
	Dim Ucase As Boolean = Asc(character) >= Asc("A") And Asc(character) <= Asc("Z")
	Return Lcase Or Ucase
End Sub

Private Sub IsValid(character As Char) As Boolean
	Dim digit As Boolean = IsDigit(character)
	Dim alpha As Boolean = IsAlpha(character)	
	Dim other As Boolean =  Asc(character) = Asc("_") Or Asc(character) = Asc("#")
	Return digit Or alpha Or other
End Sub



