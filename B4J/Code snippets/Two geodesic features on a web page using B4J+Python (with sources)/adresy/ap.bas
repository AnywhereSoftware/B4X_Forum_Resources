B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8
@EndOfDesignText@

Sub Process_Globals

End Sub

Public Sub find(adres As String)As ResumableSub
	Log(adres)
	Dim shl As Shell
	#if release
	shl.Initialize("shl", "python3", _
     Array As String("adres.py", adres))
	#else
	shl.Initialize("shl", "python", _
     Array As String("adres.py", adres))
	#end if
	shl.WorkingDirectory = File.DirApp
	shl.Run(10000) 'set a timeout of 10 seconds
	Wait For shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)

	Dim j As JSONParser
	j.Initialize(StdOut)
	Dim m As Map
	m.Initialize
	m = j.NextObject
	Dim out As StringBuilder
	out.Initialize

	out.Append("Adres: "&m.Get("adres")).Append(CRLF).Append(CRLF)
	m.Remove("adres")
	
	For i=0 To m.Size-1

		Dim m1 As Map = m.GetValueAt(i)

		out.Append("{B}"&m.GetKeyAt(i)&"{/B}").Append(" :     ").Append(m1.GetValueAt(0)).Append(" , ").Append(m1.GetValueAt(1)).Append(CRLF)
	Next
	Dim jj As JSONGenerator
	jj.Initialize(m)
	If StdErr <> "" Then
		Return StdErr
	Else
		Return out.ToString
		
	End If
End Sub


'src- uklad z ktorego jest konwersja
'out - uklad na ktory ma byc dokonana zamiana
'zamiana - zamiana X z Y
public Sub convertData(value As String, src As String, out As String, zamiana As String) As ResumableSub
	Dim nazwa As String = Rnd(10000,50000)
	File.WriteString(File.DirApp, nazwa,value)
	Dim shl As Shell
	
	Dim paramerty As String = """"& nazwa & "," & src & "," & out & "," &zamiana &""""

	#if release
	shl.Initialize("shl", "python3", _
     Array As String("convert.py", paramerty))
	#else
	shl.Initialize("shl", "python", Array As String("convert.py", paramerty ))
'	shl.Initialize("shl", "python", Array As String("convert.py", paramerty))
	#end if
	shl.WorkingDirectory = File.DirApp
	shl.Run(10000) 'set a timeout of 10 seconds
	Wait For shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)

'	
	Return StdOut

End Sub

