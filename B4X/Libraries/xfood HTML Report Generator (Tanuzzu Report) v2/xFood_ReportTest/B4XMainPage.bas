B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Pagina di esempio per B4XReport (xReport.b4xlib).
'Demo B4X minimale e senza layout Designer: all'avvio carica Report.json,
'popola dei record di esempio, genera sia l'HTML sia il PDF nativo, li salva
'su disco e mostra un riepilogo. Nessun controllo creato via xui.Create*.
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

	Private rep As B4XReport
	Private Records As List
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub


'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created(Root1 As B4XView)
	Root = Root1

	Records.Initialize
	rep.Initialize

	If File.Exists(File.DirApp, "Report.json") = False Then
		xui.MsgboxAsync("Report.json non trovato in:" & CRLF & File.DirApp, "xReportTest")
		Return
	End If

	Dim ok As Boolean = rep.LoadTemplate(File.ReadString(File.DirApp, "Report.json"))
	If ok = False Then
		xui.MsgboxAsync("Errore nel parsing del template JSON.", "xReportTest")
		Return
	End If

	CreaRecordDiEsempio
	rep.SetDataRecordsDettail(Records)

	'Dati aziendali (banda reportHdr): una singola Map
	Dim titolo As Map
	titolo.Initialize
	titolo.Put("azienda", "Mobilificio Rossi S.r.l.")
	titolo.Put("indirizzo", "Via delle Industrie 12, 20100 Milano")
	titolo.Put("piva", "IT01234567890")
	rep.SetDataRecordsTitolo(titolo)

	'Totalizzatori per pagina (banda pageFtr): una singola Map
'	Dim pie As Map
'	pie.Initialize
'	pie.Put("prezzo_totale", 4999.50)
'	rep.SetDataRecordsPie(pie)

	'Dati di fine report (banda reportFtr): una singola Map
	Dim fine As Map
	fine.Initialize
	'fine.Put("totale_finale", 4999.50)
	fine.Put("num_articoli", Records.Size)
	rep.SetDataRecordsFooter(fine)

	'Genera l'HTML (per anteprima/stampa via browser)
	Dim html As String = rep.RenderToHTML
	File.WriteString(File.DirApp, "ReportOutput.html", html)

	'Genera il PDF nativo
	Dim pdf As String = rep.RenderToPDF
	File.WriteString(File.DirApp, "ReportOutput.pdf", pdf)

'	'Copie facili da trovare sul Desktop (se disponibile)
'	Try
'		File.WriteString(File.DirApp, "ReportOutput.html", html)
'		File.WriteString(File.DirApp, "ReportOutput.pdf", pdf)
'	Catch
'		'DirDesktop non disponibile: si ignorano le copie sul desktop
'		Log("errore")
'	End Try
	OpenPDF(File.DirApp, "ReportOutput.pdf")
End Sub

'Crea i record di esempio. In una applicazione reale si leggono dal database,
'dalla rete o da un file: la libreria accetta una List di Map.
Private Sub CreaRecordDiEsempio
	Records.Clear
	Dim dati As List
	dati.Initialize
	dati.Add(Riga("ART001", "Tavolo rotondo in legno", 99.99, 15))
	dati.Add(Riga("ART002", "Sedia ergonomica nera", 89.50, 32))
	dati.Add(Riga("ART003", "Scrivania panoramica 180cm", 49.00, 8))
	dati.Add(Riga("ART004", "Monitor 27 4K LED", 59.00, 24))
	dati.Add(Riga("ART005", "Tastiera wireless bluetooth", 9.90, 50))
	dati.Add(Riga("ART006", "Mouse ottico ergonomico", 9.90, 65))
	dati.Add(Riga("ART007", "Scaffale modulare 5 ripiani", 99.00, 12))
	dati.Add(Riga("ART008", "Lampada da scrivania LED", 49.90, 40))
	dati.Add(Riga("ART009", "Contenitore plastica trasparente", 12.50, 200))
	dati.Add(Riga("ART010", "Etichettatrice portatile", 89.00, 18))
	dati.Add(Riga("ART011", "Carta A4 rame 500 fogli", 8.90, 150))
	dati.Add(Riga("ART012", "Penna stilografica blu", 25.00, 35))
	dati.Add(Riga("ART013", "Quaderno A4 96 fogli rigati", 4.50, 100))
	dati.Add(Riga("ART014", "Toner compatibile HP", 35.00, 28))
	dati.Add(Riga("ART015", "Scrivania regolabile elettrica", 199.00, 5))

	For Each r As List In dati
		Dim m As Map
		m.Initialize
		m.Put("codice", r.Get(0))
		m.Put("descrizione", r.Get(1))
		m.Put("prezzo", r.Get(2))
		m.Put("quantita", r.Get(3))
		Records.Add(m)
	Next
End Sub

Private Sub Riga(codice As String, descrizione As String, prezzo As Double, quantita As Int) As List
	Dim r As List
	r.Initialize
	r.Add(codice)
	r.Add(descrizione)
	r.Add(prezzo)
	r.Add(quantita)
	Return r
End Sub


Sub OpenPDF(dirFile As String, nameFile As String)
	Try
        #If B4A
		' Platform: Android
        Dim provider As FileProvider
        provider.Initialize
      
		' Copy the file to the shared directory
        Wait For (File.CopyAsync(dirFile, nameFile, provider.SharedFolder, nameFile)) Complete (Success As Boolean)
        Log("Android - File copy successful: " & Success)
      
        If Success = False Then
            Log("Android - Error: Failed to copy the file to the shared directory.")
            Return
        End If

		' Configure the Intent to open the PDF
        Dim docIntent As Intent
        docIntent.Initialize(docIntent.ACTION_VIEW, "")
        provider.SetFileUriAsIntentData(docIntent, nameFile)
        docIntent.SetType("application/pdf")
        docIntent.Flags = Bit.Or(1, 2) ' FLAG_GRANT_READ_URI_PERMISSION
        StartActivity(docIntent)
      
        #Else If B4I
		' Platform: iOS
		' Check if the file exists
        If File.Exists(dirFile, nameFile) = False Then
            Log("iOS - Error: PDF file not found in " & dirFile & "/" & nameFile)
            Return
        End If

		' Initialize DocumentInteraction to open the PDF
        Dim docInteraction As DocumentInteraction
        docInteraction.Initialize("docInteraction", dirFile, nameFile)
		'docInteraction.OpenFile(B4XPages.GetNativeParent(Me).RootPanel) ' shared file
        docInteraction.PreviewFile(B4XPages.GetNativeParent(Me)) ' view file
        Log("iOS - PDF opened successfully.")
      
        #Else If B4J
		' Platform: Desktop
		' Check if the file exists
		If File.Exists(dirFile, nameFile) = False Then
			Log("B4J - Error: PDF file not found in " & dirFile & "/" & nameFile)
			Return
		End If

		' Open the PDF using JFX
		Private fx As JFX
		fx.ShowExternalDocument(File.GetUri(dirFile, nameFile))
		Log("B4J - PDF opened successfully.")
        #End If
	Catch
		Log("Error while opening the PDF: " & LastException)
	End Try
End Sub
