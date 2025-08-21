B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.5
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

'' ref: https://www.b4x.com/android/forum/threads/b4x-downloadandsave.102598/
'Sub DownloadAndSave (Url As String, Dir As String, FileName As String) As ResumableSub
'	Dim j As HttpJob
'	j.Initialize("", Me)
'	j.Download(Url)
'	Wait For (j) JobDone(j As HttpJob)
'	If j.Success Then
'		Dim out As OutputStream = File.OpenOutput(Dir, FileName, False)
'		File.Copy2(j.GetInputStream, out)
'		out.Close
'	End If
'	j.Release
'	Return j.Success
'End Sub
'
