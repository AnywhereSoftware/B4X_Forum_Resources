B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region VERSIONS
'	1.0.0	04/27/2026	Initial release — Android + iOS
#End Region

'
' WebViewPdfExport — Silent PDF generation from a WebView
'
' Cross-platform (B4A + B4i + B4J) library for generating full-content PDFs
' from a WebView and sharing via the system share sheet (mobile) or
' saving as HTML for browser printing (desktop).
'
' ANDROID:
'   Uses createPrintDocumentAdapter + PdfPrint.jar for full-page paginated PDF.
'   Shares via FileProvider + Intent share sheet.
'
' iOS:
'   Uses WKWebView.createPDF (iOS 14+) for native PDF generation.
'   Shares via UIActivityViewController (AirDrop, Mail, Messages, Files, etc.)
'
' B4J:
'   Extracts HTML via WebEngine.executeScript, saves via FileChooser,
'   and opens in the default browser for printing/save-as-PDF.
'
' REQUIREMENTS:
'   Android:
'     1. PdfPrint.jar in your B4A additional libraries folder
'     2. #AdditionalJar: PdfPrint.jar in Main.bas
'     3. Manifest Editor entries (see SetupInstructions)
'   iOS:
'     No additional setup required. iOS 14+ only.
'   B4J:
'     No additional setup required.
'
' USAGE:
'   Dim pdfExport As WebViewPdfExport
'   pdfExport.Initialize(webView)
'   Wait For (pdfExport.ExportAndShare("MyDocument.pdf", "Share")) Complete (success As Boolean)
'

Sub Class_Globals
	Private TAG As String = "WebViewPdfExport"
	Private mWebView As WebView
	#if B4A
	Private mProvider As FileProvider
	#End If
	#if B4i
	Private mPdfData As Object
	Private mPdfSuccess As Boolean = False
	Private mPdfReady As Boolean = False
	Private mShareDone As Boolean = False
	#End If
End Sub

'Initializes the exporter with a WebView.
'On Android, FileProvider is managed internally.
'On iOS, no additional setup is needed.
Public Sub Initialize(WebView As WebView)
	mWebView = WebView
	#if B4A
	mProvider.Initialize
	#End If
End Sub

'Returns setup instructions for the current platform.
Public Sub SetupInstructions As String
	Dim sb As StringBuilder
	sb.Initialize
	#if B4A
	sb.Append("=== WebViewPdfExport — Android Setup ===").Append(CRLF)
	sb.Append("1. Place PdfPrint.jar in B4A additional libraries folder").Append(CRLF)
	sb.Append("2. Add to Main.bas: #AdditionalJar: PdfPrint.jar").Append(CRLF)
	sb.Append("3. Add to Manifest Editor:").Append(CRLF)
	sb.Append("   AddApplicationText(").Append(CRLF)
	sb.Append("     <provider").Append(CRLF)
	sb.Append("     android:name=""android.support.v4.content.FileProvider""").Append(CRLF)
	sb.Append("     android:authorities=""$PACKAGE$.provider""").Append(CRLF)
	sb.Append("     android:exported=""false""").Append(CRLF)
	sb.Append("     android:grantUriPermissions=""true"">").Append(CRLF)
	sb.Append("     <meta-data").Append(CRLF)
	sb.Append("     android:name=""android.support.FILE_PROVIDER_PATHS""").Append(CRLF)
	sb.Append("     android:resource=""@xml/provider_paths""/>").Append(CRLF)
	sb.Append("     </provider>").Append(CRLF)
	sb.Append("   )").Append(CRLF)
	sb.Append("   CreateResource(xml, provider_paths,").Append(CRLF)
	sb.Append("      <files-path name=""name"" path=""shared"" />").Append(CRLF)
	sb.Append("   )").Append(CRLF)
	#Else If B4i
	sb.Append("=== WebViewPdfExport — iOS Setup ===").Append(CRLF)
	sb.Append("No additional setup required. Requires iOS 14+.").Append(CRLF)
	#End If
	Return sb.ToString
End Sub

'Generates a PDF from the WebView and opens the system share sheet.
'FileName: The output PDF filename (e.g., "My Reading.pdf")
'ShareTitle: The title shown on the share sheet (e.g., "Share your reading")
'Returns True if the PDF was generated and share sheet opened successfully.
'B4J: Saves HTML via FileChooser and opens in default browser (ShareTitle is ignored).
Public Sub ExportAndShare(FileName As String, ShareTitle As String) As ResumableSub
	Log($"📤 ${TAG}: ExportAndShare - ${FileName}"$)
	Sleep(0)
	
	Dim success As Boolean = False
	#if B4A
	Try
		Wait For (GeneratePDF_Android(FileName)) Complete (success As Boolean)
		If success Then SharePDF_Android(FileName, ShareTitle)
	Catch
		Log($"❌ ${TAG}: ExportAndShare error - ${LastException}"$)
		success = False
	End Try
	#Else If B4i
	Try
		success = False
		mPdfReady = False
		mPdfSuccess = False
		mPdfData = Null
		
		Dim no As NativeObject = Me
		no.RunMethod("CreatePDF::", Array(mWebView, "export"))
		
		Dim maxWait As Int = 33
		Dim waitCount As Int = 0
		Do While Not(mPdfReady) And waitCount < maxWait
			Sleep(300)
			waitCount = waitCount + 1
		Loop
		
		If mPdfSuccess And mPdfData <> Null Then
			Dim noData As NativeObject = mPdfData
			Dim arr() As Byte = noData.NSDataToArray(mPdfData)
			File.WriteBytes(File.DirLibrary, FileName, arr)
			Log($"✅ ${TAG}: PDF saved (${arr.Length} bytes) - ${FileName}"$)
			
			Dim filePath As String = File.Combine(File.DirLibrary, FileName)
			mShareDone = False
			no.RunMethod("SharePDF:", Array(filePath))
			
			Do While Not(mShareDone)
				Sleep(300)
			Loop
			success = True
		Else
			Log($"❌ ${TAG}: iOS PDF creation failed"$)
		End If
	Catch
		Log($"❌ ${TAG}: ExportAndShare error - ${LastException}"$)
		success = False
	End Try
	#Else If B4J
	Try
		PrintViaDialog_B4J
		success = True
	Catch
		Log($"❌ ${TAG}: ExportAndShare error - ${LastException}"$)
		success = False
	End Try
	#End If
	Return success
End Sub

'Generates a PDF and saves it locally without opening the share sheet.
'FileName: The output PDF filename (e.g., "My Reading.pdf")
'Returns True if the PDF was generated successfully.
'Android: File saved to File.DirInternal
'iOS: File saved to File.DirLibrary
'B4J: Saves HTML via FileChooser and opens in default browser
Public Sub ExportToFile(FileName As String) As ResumableSub
	Log($"📤 ${TAG}: ExportToFile - ${FileName}"$)
	Sleep(0)
	
	Dim success As Boolean = False
	#if B4A
	Try
		Wait For (GeneratePDF_Android(FileName)) Complete (success As Boolean)
	Catch
		Log($"❌ ${TAG}: ExportToFile error - ${LastException}"$)
		success = False
	End Try
	#Else If B4i
	Try
		mPdfReady = False
		mPdfSuccess = False
		mPdfData = Null
		
		Dim no As NativeObject = Me
		no.RunMethod("CreatePDF::", Array(mWebView, "export"))
		
		Dim maxWait As Int = 33
		Dim waitCount As Int = 0
		Do While Not(mPdfReady) And waitCount < maxWait
			Sleep(300)
			waitCount = waitCount + 1
		Loop
		
		If mPdfSuccess And mPdfData <> Null Then
			Dim noData As NativeObject = mPdfData
			Dim arr() As Byte = noData.NSDataToArray(mPdfData)
			File.WriteBytes(File.DirLibrary, FileName, arr)
			Log($"✅ ${TAG}: PDF saved (${arr.Length} bytes) - ${FileName}"$)
			success = True
		Else
			Log($"❌ ${TAG}: iOS PDF creation failed"$)
		End If
	Catch
		Log($"❌ ${TAG}: ExportToFile error - ${LastException}"$)
		success = False
	End Try
	#Else If B4J
	Try
		PrintViaDialog_B4J
		success = True
	Catch
		Log($"❌ ${TAG}: ExportToFile error - ${LastException}"$)
		success = False
	End Try
	#End If
	Return success
End Sub

' ============================================================
' ANDROID IMPLEMENTATION (private helpers)
' ============================================================
#if B4A

Private Sub GeneratePDF_Android(FileName As String) As ResumableSub
	Log($"📤 ${TAG}: Creating PDF via PdfPrint - ${FileName}"$)
	
	' Delete any existing file first — prevents returning a stale PDF from a previous export
	If File.Exists(File.DirInternal, FileName) Then
		File.Delete(File.DirInternal, FileName)
	End If
	
	' 1. Get PrintDocumentAdapter from WebView
	Dim joWebView As JavaObject = mWebView
	Dim printAdapter As JavaObject = joWebView.RunMethod("createPrintDocumentAdapter", Array As Object("PDF Export"))
	
	' 2. Build PrintAttributes: A4, 300dpi, no margins
	Dim builderClass As JavaObject
	builderClass.InitializeNewInstance("android.print.PrintAttributes.Builder", Null)
	
	Dim mediaSize As JavaObject
	mediaSize.InitializeStatic("android.print.PrintAttributes.MediaSize")
	builderClass.RunMethod("setMediaSize", Array(mediaSize.GetField("ISO_A4")))
	
	Dim resolution As JavaObject
	resolution.InitializeNewInstance("android.print.PrintAttributes.Resolution", Array As Object("pdf", "pdf", 300, 300))
	builderClass.RunMethod("setResolution", Array(resolution))
	
	Dim margins As JavaObject
	margins.InitializeStatic("android.print.PrintAttributes.Margins")
	builderClass.RunMethod("setMinMargins", Array(margins.GetField("NO_MARGINS")))
	
	Dim printAttrs As JavaObject = builderClass.RunMethod("build", Null)
	
	' 3. Create PdfPrint instance and generate
	Dim pdfPrint As JavaObject
	pdfPrint.InitializeNewInstance("android.print.PdfPrint", Array(printAttrs))
	
	Dim outputDir As JavaObject
	outputDir.InitializeNewInstance("java.io.File", Array(File.DirInternal))
	
	pdfPrint.RunMethod("print", Array(printAdapter, outputDir, FileName, Null))
	
	' 4. Poll for file (300ms intervals, max 10 seconds)
	Dim maxAttempts As Int = 33
	Dim attempt As Int = 0
	
	Do While attempt < maxAttempts
		Sleep(300)
		attempt = attempt + 1
		
		If File.Exists(File.DirInternal, FileName) Then
			Dim fileSize As Long = File.Size(File.DirInternal, FileName)
			If fileSize > 0 Then
				Log($"✅ ${TAG}: PDF ready after ${attempt * 300}ms (${fileSize} bytes)"$)
				Return True
			End If
		End If
	Loop
	
	Log($"❌ ${TAG}: PDF not ready after 10 seconds"$)
	Return False
End Sub

Private Sub SharePDF_Android(FileName As String, ShareTitle As String)
	Log($"📤 ${TAG}: Opening share sheet - ${FileName}"$)
	
	File.Copy(File.DirInternal, FileName, mProvider.SharedFolder, FileName)
	
	Dim uri As Object = mProvider.GetFileUri(FileName)
	
	Dim intent As Intent
	intent.Initialize(intent.ACTION_SEND, "")
	intent.SetType("application/pdf")
	intent.PutExtra("android.intent.extra.STREAM", uri)
	intent.Flags = 1 'FLAG_GRANT_READ_URI_PERMISSION
	intent.WrapAsIntentChooser(ShareTitle)
	StartActivity(intent)
	
	Log($"✅ ${TAG}: Share sheet opened"$)
End Sub

#End If

' B4J IMPLEMENTATION
' ============================================================
' B4J saves the WebView HTML to a user-chosen file via FileChooser,
' then opens it in the default browser where the user can print/save as PDF
' with full CSS support.
'
' Note: JavaFX PrinterJob crashes B4XPages due to nested event loops.
' The FileChooser (B4J native wrapper) + browser approach avoids this
' and gives better PDF quality than JavaFX's print renderer.
' ============================================================
#if B4J

Private Sub PrintViaDialog_B4J
	Log($"📤 ${TAG}: Opening save dialog (B4J)"$)
	
	' Get the HTML content from the WebView
	Dim joWebView As JavaObject = mWebView
	Dim engine As JavaObject = joWebView.RunMethod("getEngine", Null)
	Dim html As String = engine.RunMethod("executeScript", Array("document.documentElement.outerHTML"))
	
	' Show file save dialog using B4J's native FileChooser
	Dim fc As FileChooser
	fc.Initialize
	fc.Title = "Save as HTML"
	fc.InitialDirectory = File.DirApp
	fc.InitialFileName = "export.html"
	fc.SetExtensionFilter("HTML File", Array As String("*.html"))
	
	Dim f As String = fc.ShowSave(B4XPages.GetNativeParent(B4XPages.MainPage))
	
	If f <> "" Then
		' Parse directory and filename from the full path
		Dim separator As String = "/"
		If f.Contains("\") Then separator = "\"
		Dim iLastSlash As Int = f.LastIndexOf(separator)
		Dim fDir As String = f.SubString2(0, iLastSlash)
		Dim fFile As String = f.SubString(iLastSlash + 1)
		
		File.WriteString(fDir, fFile, html)
		Log($"✅ ${TAG}: HTML saved to ${f}"$)
		
		' Open in default browser for printing
		Dim fx As JFX
		fx.ShowExternalDocument(f)
		Log($"📤 ${TAG}: Opened in browser"$)
	Else
		Log($"📤 ${TAG}: Save cancelled"$)
	End If
End Sub

#End If

' ============================================================
' iOS CALLBACKS (from Objective-C native code)
' ============================================================
#if B4i
Private Sub PDF_Created(Data As Object, ReadingType As String, Success As Boolean)
	Log($"📤 ${TAG}: PDF_Created callback - Success: ${Success}"$)
	mPdfData = Data
	mPdfSuccess = Success
	mPdfReady = True
End Sub

Private Sub Share_Completed(Success As Boolean)
	Log($"📤 ${TAG}: Share_Completed - ${Success}"$)
	mShareDone = True
End Sub

#End If

' ============================================================
' iOS NATIVE CODE (Objective-C)
' ============================================================
#if OBJC
#import <WebKit/WebKit.h>

// Generate PDF from WKWebView content (iOS 14+)
- (void) CreatePDF:(WKWebView*)wv :(NSString*)readingType {
	if (@available(iOS 14, *)) {
		WKPDFConfiguration *config = [[WKPDFConfiguration alloc] init];
		
		[wv createPDFWithConfiguration:config completionHandler:^(NSData* data, NSError* error) {
			if (error != nil) {
				NSLog(@"PDF creation error: %@", error);
				[self.bi raiseUIEvent:nil event:@"pdf_created:::" params:@[[NSNull null], readingType, @(NO)]];
			} else {
				[self.bi raiseUIEvent:nil event:@"pdf_created:::" params:@[data, readingType, @(YES)]];
			}
		}];
	} else {
		NSLog(@"createPDF requires iOS 14+");
		[self.bi raiseUIEvent:nil event:@"pdf_created:::" params:@[[NSNull null], readingType, @(NO)]];
	}
}

// Share PDF file via system share sheet
- (void) SharePDF:(NSString*)filePath {
	NSURL *fileURL = [NSURL fileURLWithPath:filePath];
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		NSLog(@"PDF file not found at path: %@", filePath);
		[self.bi raiseUIEvent:nil event:@"share_completed:" params:@[@(NO)]];
		return;
	}
	
	UIActivityViewController *avc = [[UIActivityViewController alloc]
		initWithActivityItems:@[fileURL]
		applicationActivities:nil];
	
	avc.excludedActivityTypes = @[
		UIActivityTypeAssignToContact,
		UIActivityTypeAddToReadingList
	];
	
	avc.completionWithItemsHandler = ^(UIActivityType activityType, BOOL completed, NSArray *returnedItems, NSError *error) {
		[self.bi raiseUIEvent:nil event:@"share_completed:" params:@[@(completed)]];
	};
	
	UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
	while (vc.presentedViewController) {
		vc = vc.presentedViewController;
	}
	
	// iPad popover support
	if (avc.popoverPresentationController) {
		avc.popoverPresentationController.sourceView = vc.view;
		avc.popoverPresentationController.sourceRect = CGRectMake(vc.view.bounds.size.width / 2, 50, 0, 0);
		avc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
	}
	
	[vc presentViewController:avc animated:YES completion:nil];
}

#End If
