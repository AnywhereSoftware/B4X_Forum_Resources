B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Public xl As XLUtils
End Sub

Public Sub Initialize
	xl.Initialize
		
End Sub

Public Sub CreateDocument As WordDocument
	Dim doc As JavaObject
	doc.InitializeNewInstance("org.apache.poi.xwpf.usermodel.XWPFDocument", Null)
	Dim wd As WordDocument
	wd.Initialize(Me, doc)
	Return wd
End Sub

'Windows only!
'Opens MS Word if it is installed.
'<code>Wait For (wd.OpenWord(FilePath)) Complete (Success As Boolean)</code>
Public Sub OpenWord (FilePath As String) As ResumableSub
	Wait For (xl.OpenExcel(FilePath)) Complete (Success As Boolean)
	Return Success
End Sub

'Windows only and requires Word to be installed!
'Uses PowerShell to convert the document to a pdf.
Public Sub PowerShellConvertToPdf (InputFile As String, OutputFile As String, OpenPdf As Boolean) As ResumableSub
	File.Delete(OutputFile, "")
	If File.Exists(OutputFile, "") Then
		Log("Cannot delete output file")
		Return False
	End If
	
	Dim s As String = $"
	& {$objWord = New-Object -ComObject word.application
$document  = $objWord.Documents.open('${InputFile}')
  $document.SaveAs([ref] '${OutputFile}', [ref] 17)
    $document.Close()
$objWord.Quit()}"$
	Wait For (xl.PowerShellScript(s)) Complete (Result As ShellSyncResult)
	If Result.ExitCode <> 0 Then Return False
	If OpenPdf Then
		Wait For (xl.PowerShellScript($"& {Invoke-Item '${OutputFile}'}"$)) Complete (Result As ShellSyncResult)
		Return Result.ExitCode = 0
	End If
	Return True
End Sub