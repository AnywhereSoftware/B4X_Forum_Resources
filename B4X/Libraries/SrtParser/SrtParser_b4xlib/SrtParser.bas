B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Type SpeechLine (number As Int,startTime As String,endTime As String, text As String)
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub Parse(content As String) As List
	content = Regex.Replace2("\r\n",32,content,CRLF)
	Dim lines As List
	lines.Initialize
	Dim strLines As List = Regex.Split2(CRLF,32,content)
	Dim index As Int = 0
	Dim sb As StringBuilder
	sb.Initialize
	For Each line As String In strLines
		If Regex.IsMatch("\d+",line) Then 'new speech line
		    Dim lineNumber As Int = line
			If lineNumber - index = 1 Then
				index = lineNumber
				
				If lines.Size > 0 Then
					Dim lastSpeech As SpeechLine
					lastSpeech = lines.Get(lines.Size - 1)
					lastSpeech.text = sb.ToString.Trim
				End If
				
				Dim speech As SpeechLine
				speech.Initialize
				speech.number = lineNumber
				sb.Initialize
				lines.Add(speech)
			End If
		else if Regex.IsMatch("\d{2}:\d{2}:\d{2},\d{3} --> \d{2}:\d{2}:\d{2},\d{3}",line) Then
			Dim speech As SpeechLine = lines.Get(lines.Size - 1)
			Dim timeMatcher As Matcher = Regex.Matcher("\d{2}:\d{2}:\d{2},\d{3}",line)
			Dim isStart As Boolean = True
			Do While timeMatcher.Find
				If isStart Then
					speech.startTime = timeMatcher.Match
					isStart = False
				Else
					speech.endTime = timeMatcher.Match
				End If
			Loop
		Else
			sb.Append(line)
			sb.Append(CRLF)
		End If
	Next
	Dim textLeft As String = sb.ToString
	If textLeft <> "" Then
		If lines.Size > 0 Then
			Dim speech As SpeechLine = lines.Get(lines.Size - 1)
			speech.text = textLeft
		End If 
	End If
	Return lines
End Sub

Public Sub GetMillisecondsFromTime(str As String) As Long
	Dim totalMilliseconds As Long
	Dim hours As Int = str.SubString2(0,2)
	Dim minutes As Int = str.SubString2(3,5)
	Dim seconds As Int = str.SubString2(6,8)
	Dim milliseconds As Int = str.SubString2(9,12)
	totalMilliseconds = hours*60*60*1000 + minutes*60*1000 + seconds*1000 + milliseconds
	Return totalMilliseconds
End Sub
