B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private TempCounter As Int
'	Private TrackerIndex As Int
	Private xui As XUI
End Sub

Public Sub Initialize
	
End Sub

Public Sub  DownloadAndSaveFile (Link As String, folder As String, name As String, RequestTimeoutSeconds As Int) As ResumableSub
	Dim j As HttpJob
	j.Initialize("", Me)
'	j.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds '  1500 '1.5 Seg de espera
	j.Download(Link)
	j.GetRequest.Timeout=  DateTime.TicksPerSecond * RequestTimeoutSeconds '  1500 '1.5 Seg de espera
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		Dim out As OutputStream = File.OpenOutput(folder, name, False)
		File.Copy2(j.GetInputStream, out)
		out.Close '<------ very important
	End If
	j.Release
	Return j.Success
End Sub

Public Sub CreateMultipartJob(Callback As Object, Link As String, NameValues As Map, Files As List) As HttpJob	
	Dim boundary As String = "---------------------------1461124740692"
	TempCounter = TempCounter + 1
	Dim TempFileName As String = "post-" & TempCounter
	Dim stream As OutputStream = File.OpenOutput(xui.DefaultFolder, TempFileName, False)
	Dim b() As Byte
	Dim eol As String = Chr(13) & Chr(10)
	Dim empty As Boolean = True
	If NameValues <> Null And NameValues.IsInitialized Then
		For Each key As String In NameValues.Keys
			Dim value As String = NameValues.Get(key)
			empty = MultipartStartSection (stream, empty)
			Dim s As String = _
$"--${boundary}
Content-Disposition: form-data; name="${key}"

${value}"$
			b = s.Replace(CRLF, eol).GetBytes("UTF8")
			stream.WriteBytes(b, 0, b.Length)
		Next
	End If
	If Files <> Null And Files.IsInitialized Then
		For Each fd As MultipartFileData In Files
			empty = MultipartStartSection (stream, empty)
			Dim s As String = _
$"--${boundary}
Content-Disposition: form-data; name="${fd.KeyName}"; filename="${fd.FileName}"
Content-Type: ${fd.ContentType}

"$
			b = s.Replace(CRLF, eol).GetBytes("UTF8")
			stream.WriteBytes(b, 0, b.Length)
			Dim in As InputStream = File.OpenInput(fd.Dir, fd.FileName)
			File.Copy2(in, stream)
		Next
	End If
	empty = MultipartStartSection (stream, empty)
	s = _
$"--${boundary}--
"$
	b = s.Replace(CRLF, eol).GetBytes("UTF8")
	stream.WriteBytes(b, 0, b.Length)
	Dim job As HttpJob
	job.Initialize("", Callback)
	stream.Close
	
	#If B4A or B4J
	Dim length As Int = File.Size(xui.DefaultFolder, TempFileName)
	Dim inp As InputStream = File.OpenInput(xui.DefaultFolder, TempFileName)
	Dim cin As CountingInputStream
	cin.Initialize(inp)
	Dim req As OkHttpRequest = job.GetRequest
	req.InitializePost(Link, cin, length)
	req.SetContentType("multipart/form-data; boundary=" & boundary)
	req.SetContentEncoding("UTF8")
'	TrackProgress(cin, length)
	#Else
	Dim req As HttpRequest = job.GetRequest
	req.InitializePost(Link, xui.DefaultFolder, TempFileName)
	req.SetContentType("multipart/form-data; boundary=" & boundary)
	#End If
	job.Tag = TempFileName
	CallSubDelayed2(HttpUtils2Service, "SubmitJob", job)
	Return job	
End Sub

Private Sub MultipartStartSection (stream As OutputStream, empty As Boolean) As Boolean
	If empty = False Then
		stream.WriteBytes(Array As Byte(13, 10), 0, 2)
	Else
		empty = False
	End If
	Return empty
End Sub

'Private Sub TrackProgress (cin As CountingInputStream, length As Int)
'	TrackerIndex = TrackerIndex + 1
'	Dim MyIndex As Int = TrackerIndex
'	Do While MyIndex = TrackerIndex
'		Log($"$1.2{cin.Count * 100 / length}%"$)
'		If cin.Count = length Then Exit
'		Sleep(10)
'	Loop
'	
'End Sub

Public Sub GetMimeTypeByExtension(Extension As String) As String
	Extension = Extension.Replace(".","").ToLowerCase
	Select Extension
		Case "png","bmp","ico"
			Return "image/" & Extension
		Case "mp4", "wmv", "mov", "flv",  "mkv"
			Return "video/" & Extension
		Case "mp3",   "m4a",  "flac", "wma", "aiff"
			Return "audio/" & Extension			
		Case "aac" 'Archivo de audio AAC
			Return "audio/aac"
		Case "abw" 'Documento AbiWord
			Return "application/x-abiword"
		Case "arc" 'Documento de Archivo (múltiples archivos incrustados)
			Return "application/octet-stream"
		Case "avi" 'AVI: Audio Video Intercalado
			Return "video/x-msvideo"
		Case "azw" 'Formato eBook Amazon Kindle
			Return "application/vnd.amazon.ebook"
		Case "bin" 'Cualquier tipo de datos binarios
			Return "application/octet-stream"
		Case "bz" 'Archivo BZip
			Return "application/x-bzip"
		Case "bz2" 'Archivo BZip2
			Return "application/x-bzip2"
		Case "csh" 'Script C-Shell
			Return "application/x-csh"
		Case "css" 'Hojas de estilo (CSS)
			Return "text/css"
		Case "csv" 'Valores separados por coma (CSV)
			Return "text/csv"
		Case "doc" 'Microsoft Word
			Return "application/msword"
		Case "epub" 'Publicación Electrónica (EPUB)
			Return "application/epub+zip"
		Case "gif" 'Graphics Interchange Format (GIF)
			Return "image/gif"
		Case "htm, html" 'Hipertexto (HTML)
			Return "text/html"
		Case "ico" 'Formato Icon
			Return "image/x-icon"
		Case "ics" 'Formato iCalendar
			Return "text/calendar"
		Case "jar" 'Archivo Java (JAR)
			Return "application/java-archive"
		Case "jpeg","jpg" 'Imágenes JPEG
			Return "image/jpeg"
		Case "js" 'JavaScript (ECMAScript)
			Return "application/javascript"
		Case "json" 'Formato JSON
			Return "application/json"
		Case "mid","midi" 'Interfaz Digital de Instrumentos Musicales (MIDI)
			Return "audio/midi"
		Case "mpeg" 'Video MPEG
			Return "video/mpeg"
		Case "mpkg" 'Paquete de instalación de Apple
			Return "application/vnd.apple.installer+xml"
		Case "odp" 'Documento de presentación de OpenDocument
			Return "application/vnd.oasis.opendocument.presentation"
		Case "ods" 'Hoja de Cálculo OpenDocument
			Return "application/vnd.oasis.opendocument.spreadsheet"
		Case "odt" 'Documento de texto OpenDocument
			Return "application/vnd.oasis.opendocument.text"
		Case "oga" 'Audio OGG
			Return "audio/ogg"
		Case "ogv" 'Video OGG
			Return "video/ogg"
		Case "ogx" 'OGG
			Return "application/ogg"
		Case "pdf" 'Adobe Portable Document Format (PDF)
			Return "application/pdf"
		Case "ppt" 'Microsoft PowerPoint
			Return "application/vnd.ms-powerpoint"
		Case "rar" 'Archivo RAR
			Return "application/x-rar-compressed"
		Case "rtf" 'Formato de Texto Enriquecido (RTF)
			Return "application/rtf"
		Case "sh" 'Script Bourne shell
			Return "application/x-sh"
		Case "svg" 'Gráficos Vectoriales (SVG)
			Return "image/svg+xml"
		Case "swf" 'Small web format (SWF) o Documento Adobe Flash
			Return "application/x-shockwave-flash"
		Case "tar" 'Aerchivo Tape (TAR)
			Return "application/x-tar"
		Case "tif","tiff" 'Formato de archivo de imagen etiquetado (TIFF)
			Return "image/tiff"
		Case "ttf" 'Fuente TrueType
			Return "font/ttf"
		Case "vsd" 'Microsft Visio
			Return "application/vnd.visio"
		Case "wav" 'Formato de audio de forma de onda (WAV)
			Return "audio/x-wav"
		Case "weba" 'Audio WEBM
			Return "audio/webm"
		Case "webm" 'Video WEBM
			Return "video/webm"
		Case "webp" 'Imágenes WEBP
			Return "image/webp"
		Case "woff" 'Formato de fuente abierta web (WOFF)
			Return "font/woff"
		Case "woff2" 'Formato de fuente abierta web (WOFF)
			Return "font/woff2"
		Case "xhtml" 'XHTML
			Return "application/xhtml+xml"
		Case "xls" 'Microsoft Excel
			Return "application/vnd.ms-excel"
		Case "xml" 'XML
			Return "application/xml"
		Case "xul" 'XUL
			Return "application/vnd.mozilla.xul+xml"
		Case "zip" 'Archivo ZIP
			Return "application/zip"
		Case "3gp" 'Contenedor de audio/video 3GPP
			Return "video/3gpp audio/3gpp if it doesn't contain video"
		Case "3g2" 'Contenedor de audio/video 3GPP2
			Return "video/3gpp2 audio/3gpp2 if it doesn't contain video"
		Case "7z" 'Archivo 7-zip
			Return "application/x-7z-compressed"
			
		Case Else
			Log("unknown mime type")
			Return ""
	End Select
End Sub