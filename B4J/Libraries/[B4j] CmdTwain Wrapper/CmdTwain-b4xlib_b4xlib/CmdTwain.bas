B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'Wrapper for CmdTwain
'CmdTwain help and full explaination of the parameters can be found <link>here|http://www.gssezisoft.com/Products/CmdTwain/Help/cmdtwain.html </link>
'Not all parameters are supported on all scanners.
Sub Class_Globals
	Public Const COLOR_RGB As String = "RGB"
	Public Const COLOR_BW As String = "BW"
	Public Const COLOR_GRAYSCALE As String = "GRAY"
	
	Public Const PAPER_A3 As String = "A3"
	Public Const PAPER_A4 As String = "A4"
	Public Const PAPER_A5 As String = "A5"
	Public Const PAPER_A6 As String = "A6"
	Public Const PAPER_B3 As String = "B3"
	Public Const PAPER_B4 As String = "B4"
	Public Const PAPER_B5 As String = "B5"
	Public Const PAPER_B6 As String = "B6"
	Public Const PAPER_C4 As String = "C4"
	Public Const PAPER_C5 As String = "C5"
	Public Const PAPER_C6 As String = "C6"
	Public Const PAPER_LEGAL As String = "LEGAL"
	Public Const PAPER_LETTER As String = "LETTER"
	
	Public Const DPI_150 As String = "150"
	Public Const DPI_200 As String = "200"
	Public Const DPI_300 As String = "300"
	Public Const DPI_600 As String = "600"
	
	Public Const OUTPUT_PDF_A4 As String = "PDF"
	Public Const OUTPUT_PDF_LETTER As String = "PDF2"
	Public Const OUTPUT_PDF_LEGAL As String = "PDF3"
	
	Public Const OUTPUT_JPG_25 As String = "25"
	Public Const OUTPUT_JPG_50 As String = "50"
	Public Const OUTPUT_JPG_75 As String = "75"
	Public Const OUTPUT_JPG_100 As String = "100"
	
	Public Const OUTPUT_BMP As String = "BMP"
	Public Const OUTPUT_75_8 As String = "75.8"
	
	Public Const UNIT_IN As String = "IN"
	Public Const UNIT_CM As String = "CM"
	Public Const UNIT_PX As String = "PX"
	Public Const UNIT_PX As String = "TW"
	
	Private fx As JFX
	Private mOutputFullPath As String
	Private mDirectory As String
	Private mScanTwainPath As String = "C:\Program Files (x86)\GssEziSoft\CmdTwain"
	Private mOpenAfterScan As Boolean
	
	'Scanner Settings
	Private mPaper As String
	Private mDPI As String
	Private mColor As String
	Private mQuiet As Boolean
	Private mOutput As String = "75"
	Dim mAutoMatchPDF As Boolean
	Private mUnits As String
	Private mPartScan As Boolean
	Private mWidthHeight As Boolean
	Private mScanX As Double
	Private mScanY As Double
	Private mScanWidth As Double
	Private mScanHeight As Double
	
	'Scanner setting additional functions
	Private mBrightNess As String
	Private mContrast As String
	Private mAudoDocFeeder As String
	Private mDuplex As String
	Private mAutoFeed As String
	Private mAutoScan As String
	Private mAutoBrightness As String
	Private mGamma As String
	Private mBitsPerPixel As String
	Private mFilm As String
	Private mNegative As String
	
	Private mArgs As List
End Sub


'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	mArgs.Initialize
End Sub

Public Sub SelectScanner As ResumableSub
	Dim mArgs As List
	mArgs.Initialize
	mArgs.Add("/SOURCE")
	Dim SH As Shell
	SH.Initialize("SH1",File.Combine(mScanTwainPath,"cmdtwain.exe"),mArgs)
	If mDirectory <> "" Then SH.WorkingDirectory = mDirectory
	
	SH.Run(-1)
	
	Wait For SH1_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	If Success = False Then
		Log("StdOut " & StdOut)
		Log("Stderr " & StdErr)
		Return False
	End If
	Return True
End Sub

Public Sub Scan As ResumableSub
	
	If mOutputFullPath = "" Then
		Log("FileName not set")
		Return False
	End If
	
	If mDirectory = "" Then mDirectory = GetSystemProperty("user.home","C:\")
	
	Dim mArgs As List
	mArgs.Initialize
	
	If mQuiet Then
		mArgs.add("-q")
	End If
	
	Dim Settings As StringBuilder = ProcessSettings
	
	mArgs.add(" -c "$)
	If Settings.Length = 0 Then
		mArgs.Add($""""$)
	Else
		mArgs.Add(QUOTE & Settings.ToString.SubString(1) & QUOTE)
	End If
	
	mArgs.Add(mOutput)
	mArgs.Add(mOutputFullPath)
	
	Dim SH As Shell
	SH.InitializeDoNotHandleQuotes("SH",File.Combine(mScanTwainPath,"cmdtwain.exe"),mArgs)
	If mDirectory <> "" Then SH.WorkingDirectory = mDirectory
	
	SH.Run(-1)
	
	Wait For SH_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	
	If Success = False Then
		Log("StdOut " & StdOut)
		Log("Stderr " & StdErr)
		Return False
	End If
	
	If mOpenAfterScan Then
		fx.ShowExternalDocument(File.GetUri(mOutputFullPath,""))
	End If
	
	Return True
End Sub

Private Sub ProcessSettings As StringBuilder
	Dim Args As List
	Args.Initialize
	
	'ScannerSettings
	Dim Settings As StringBuilder
	Settings.Initialize
	
	If mDPI <> "" Then
		Settings.Append(" DPI ")
		Settings.Append(mDPI)
	End If
		
	If mColor <> "" Then
		Settings.Append(" ")
		Settings.Append(mColor)
	End If
	
	If mBitsPerPixel <> "" Then
		Settings.Append(" BPP ")
		Settings.Append(mBitsPerPixel)
	End If
	
	If mPartScan Then
		Settings.Append(" ")
		Settings.Append(mUnits)
		Settings.Append(" XYWH ")
		Settings.Append(mScanX)
		Settings.Append(" ")
		Settings.Append(mScanY)
		Settings.Append(" ")
		Settings.Append(mScanWidth)
		Settings.Append(" ")
		Settings.Append(mScanHeight)
	End If
	
	If mWidthHeight Then
		Settings.Append(" ")
		Settings.Append(mUnits)
		Settings.Append(" WH ")
		Settings.Append(mScanWidth)
		Settings.Append(" ")
		Settings.Append(mScanHeight)
	End If
	
	If mBrightNess <> "" Then
		Settings.Append(" BR ")
		Settings.Append(mBrightNess)
	End If
	
	If mContrast <> "" Then
		Settings.Append(" CO ")
		Settings.Append(mContrast)
	End If
	
	If mAudoDocFeeder <> "" Then
		Settings.Append(" ADF ")
		Settings.Append(mAudoDocFeeder)
	End If
	
	If mDuplex <> "" Then
		Settings.Append(" DPX ")
		Settings.Append(mDuplex)
	End If
	
	If mAutoFeed <> "" Then
		Settings.Append(" AF ")
		Settings.Append(mAutoFeed)
	End If
	
	If mAutoScan <> "" Then
		Settings.Append(" AS ")
		Settings.Append(mAutoScan)
	End If
	
	If mAutoBrightness <> "" Then
		Settings.Append(" AUTOBR ")
		Settings.Append(mAutoBrightness)
	End If
	
	If mGamma <> "" Then
		Settings.Append(" GAMMA ")
		Settings.Append(mGamma)
	End If
	
	If mFilm <> "" Then
		Settings.Append(" FILM ")
		Settings.Append(mFilm)
	End If
	
	If mNegative <> "" Then
		Settings.Append(" NEG ")
		Settings.Append(mNegative)
	End If
	
	'Deal with matching output to Paper and add paper to start of settings
	'Output is a separate parameter See sub Scan
	If mOutput <> "" Then
		If mOutput.Contains("PDF") Then
			If mAutoMatchPDF Then
				Select mOutput
					Case OUTPUT_PDF_A4
						Settings.Insert(0,PAPER_A4)
						Settings.Insert(0," PAPER ")
						
					Case OUTPUT_PDF_LEGAL
						Settings.Insert(0,PAPER_LEGAL)
						Settings.Insert(0," PAPER ")
					Case OUTPUT_PDF_LETTER
						Settings.Insert(0,PAPER_LETTER)
						Settings.Insert(0," PAPER ")
				End Select
			Else
				If mPaper <> "" Then
					Settings.Insert(0,mPaper)
					Settings.Insert(0," PAPER ")
				End If
			End If
		Else
			If mPaper <> "" Then
				Settings.Insert(0,mPaper)
				Settings.Insert(0," PAPER ")
			End If
		End If
	Else
		If mPaper <> "" Then
			Settings.Insert(0,mPaper)
			Settings.Insert(0," PAPER ")
		End If
	End If
	
	Return Settings
End Sub

Public Sub GetLastCommandLineArgs As List
	Return mArgs
End Sub

'To write to a drives root folder a double backslash may be required i.e. d:\\test.jpg
Public Sub setOutputFullPath(FullPath As String)
	mOutputFullPath = FullPath
End Sub

Public Sub getOutputFullPath As String
	Return mOutputFullPath
End Sub

'Working directory for jShell. 
Public Sub setWorkingDirectory(Directory As String)
	mDirectory = Directory
End Sub

'Set the path to the CmdTwain program. Default is C:\Program Files (x86)\GssEziSoft\CmdTwain
Public Sub setScanTwainPath(Path As String)
	mScanTwainPath = Path
End Sub

'Attempt to open the document with the systems default viewer.
Public Sub setOpenAfterScan(Open As Boolean)
	mOpenAfterScan = Open
End Sub

Public Sub getPaper As String
	Return mPaper
End Sub

'One of the Paper constants
Public Sub setPaper(Paper As String)
	mPaper = Paper
End Sub

'One of the DPI Constants
Public Sub getDPI As String
	Return mDPI
End Sub

'Use one of the DPI constants or enter a value if your scanner supports something else i.e. 1200.
Public Sub setDPI(DPI As String)
	mDPI = DPI
End Sub

Public Sub getColor As String
	Return mColor
End Sub

'One of the Color Constants
Public Sub setColor(Color As String)
	mColor = Color
End Sub

Public Sub getQuiet As Boolean
	Return mQuiet
End Sub

'Set quiet mode
Public Sub setQuiet(Quiet As Boolean)
	mQuiet = Quiet
End Sub

Public Sub getOutput As String
	Return mOutput
End Sub

'Default = 75 (Jpeg 75% quality)
'If using PDF, use AutoMatchPDF to force the paper size to match if required.
Public Sub setOutput(Output As String)
	mOutput = Output
End Sub

Public Sub getPaperAutoMatchPDF As Boolean
	Return mAutoMatchPDF
End Sub

'If True paper will be selected based on the PDF selected output
Public Sub setPaperAutoMatchPDF(AutoMatchPDF As Boolean)
	mAutoMatchPDF = AutoMatchPDF
End Sub

Public Sub getUnit As String
	Return mUnits
End Sub

'Set the units to use with SetWidthAndHeight.  One of the Unit Constants
Public Sub setUnit(Unit As String)
	mUnits = Unit
End Sub

'Setup for a partial page scan.  Units are one of the Unit constants
Public Sub ScanPartialPage(Units As String,X As Double,Y As Double,Width As Double,Height As Double)
	mWidthHeight = False
	mPartScan = True
	mUnits = Units
	mScanX = X
	mScanY = Y
	mScanWidth = Width
	mScanHeight = Height
End Sub

'Setup for page width and height scan. Units are one of the Unit constants
Public Sub ScanWidthAndHeight(Units As String,Width As Double,Height As Double)
	mWidthHeight = True
	mPartScan = False
	mUnits = Units
	mScanWidth = Width
	mScanHeight = Height
End Sub

Public Sub getPartScanX As String
	Return mScanX
End Sub

Public Sub getPartScanY As String
	Return mScanY
End Sub

Public Sub getPartScanWidth As String
	Return mScanWidth
End Sub

Public Sub getPartScanHeight As String
	Return mScanHeight
End Sub

Public Sub getBrightNess As String
	Return mBrightNess
End Sub

'Get/Set the scan brightness.
Public Sub setBrightNess(BrightNess As String)
	mBrightNess = BrightNess
End Sub

Public Sub getContrast As String
	Return mContrast
End Sub
'Get/Set the scan contrast.
Public Sub setContrast(Contrast As String)
	mContrast = Contrast
End Sub

Public Sub getAutoDocFeeder As Boolean
	Return IIf(mAudoDocFeeder = "1",True,False)
End Sub
'Get/Set the autofeed state
Public Sub setAutoDocFeeder(On As Boolean)
	If On Then
		mAudoDocFeeder = "1"
	Else
		mAudoDocFeeder = "0"
	End If
End Sub

Public Sub getDuplex As Boolean
	Return IIf(mDuplex = "1",True,False)
End Sub

'Get/Set the duplex state.
Public Sub setDuplex(On As Boolean)
	If On Then
		mDuplex = "1"
	Else
		mDuplex = "0"
	End If
End Sub

'Get/Set the autofeed state
Public Sub getAutoFeed As Boolean
	Return IIf(mAutoFeed = "1",True,False)
End Sub

Public Sub setAutoFeed(On As Boolean)
	If On Then
		mAutoFeed = "1"
	Else
		mAutoFeed = "0"
	End If

End Sub

Public Sub getAutoScan As Boolean
	Return IIf(mAutoScan = "1",True,False)
End Sub

'Get/Set the autoScan state.  Gets additional pages from the feed hopper.
'Requires Autofeed = On
Public Sub setAutoScan(On As Boolean)
	If On Then
		mAutoScan = "1"
	Else
		mAutoScan = "0"
	End If
End Sub

Public Sub getAutoBrightness As Boolean
	Return IIf(mAutoBrightness = "1",True,False)
End Sub

'Get/Set the AutoBrightness state
Public Sub setAutoBrightness(On As Boolean)
	If On Then
		mAutoBrightness = "1"
	Else
		mAutoBrightness = "0"
	End If
End Sub

Public Sub getGamma As Double
	Return mGamma
End Sub

'Get/Set the Gamma Value
Public Sub setGamma(Gamma As Double)
	mGamma = Gamma
End Sub

Public Sub getBitsPerPixel As Int
	Return mBitsPerPixel
End Sub

'Get/Set Bits per pixel. Typically 1, 8 or 24.
Public Sub setBitsPerPixel(BitsPerPixel As Int)
	mBitsPerPixel = BitsPerPixel
End Sub

Public Sub getFilm As Boolean
	Return IIf(mFilm = "1",True,False)
End Sub

'Select Film Scanning
Public Sub setFilm(On As Boolean)
	If On Then
		mFilm = "1"
	Else
		mFilm = "0"
	End If
End Sub

Public Sub getNegative As Boolean
	Return IIf(mNegative = "1",True,False)
End Sub

'Select Negative scanning
Public Sub setNegative(On As Boolean)
	If On Then
		mNegative = "1"
	Else
		mNegative = "0"
	End If
End Sub


