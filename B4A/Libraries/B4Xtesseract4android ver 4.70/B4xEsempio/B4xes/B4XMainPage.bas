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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private tessapi47 As B4Xtesseract4android
	Private rp As RuntimePermissions
	
	Dim Pathtraineddata As String
	Dim tessDataPath1 As String
	Private EditText1 As B4XView
	Private ImgOriginale As B4XView
	Private Imgpix As B4XView
	Private Button3 As B4XView

	Private ProgressBar1 As ProgressBar
	Private LblSec As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True

	End Sub


'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	rp.CheckAndRequest(rp.PERMISSION_WRITE_EXTERNAL_STORAGE)
	rp.CheckAndRequest(rp.PERMISSION_READ_EXTERNAL_STORAGE)
	Wait For B4XPage_PermissionResult (permission As String, Result As Boolean)
	If Result = False Then
		ToastMessageShow("No permission!", True)
		Return
	End If
	ProgressBar1.Initialize("")
	
	Pathtraineddata   = File.DirInternal&"/tesseract/"
	tessDataPath1  = File.DirInternal&"/tesseract//tessdata/"
	tessapi47.DEFAULT_LANGUAGE="eng"
	tessapi47.TESSERACT_PATH = tessDataPath1
	tessapi47.TESSERACT_TRAINED_DATA_FOLDER =Pathtraineddata
	tessapi47.Initliaze("tessapi")
	
	
	If tessapi47.InittessApi = True Then
		Log("Successo")
	End If
	
	
End Sub


'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	
	tessapi47.Versione
	tessapi47.Library
	Dim Bitmap1 As Bitmap
	Bitmap1.Initialize(File.DirAssets, "sample.jpg")
	Bitmap1 = tessapi47.Btmpix(Bitmap1,1)
	
	Imgpix.SetBitmap(Bitmap1)
	Dim Strs As  String
	tessapi47.getTextFromBitmap(Bitmap1,1,2)
	EditText1.Text = ""
	EditText1.Text = Strs
	
End Sub


Private Sub Button2_Click
	Dim Strs As  String
	EditText1.Text = ""
	Dim Bitmap1 As Bitmap
	Bitmap1.Initialize(File.DirAssets, "sample.jpg")
	ImgOriginale.SetBitmap(Bitmap1)
	tessapi47.getTextFromBitmap(xui.LoadBitmap(File.DirAssets, "sample.jpg"),1,6)
	
	EditText1.Text = Strs
End Sub



Private Sub Button3_Click
	Dim CHAR_BLACKLIST As String = "abe"
	ProgressBar1.Progress =tessapi47.mProgressIndicator
	tessapi47.CharBlacklist(xui.LoadBitmap(File.DirAssets, "sample.jpg"),CHAR_BLACKLIST,7)
	ProgressBar1.Progress =tessapi47.mProgressIndicator
End Sub

Private Sub tessapi_result(result As String)
	EditText1.Text = ""
	LblSec.Text =tessapi47.duration&"s"
	Log(result)
	EditText1.Text = result
End Sub

Private Sub BuWHITELIST_Click
	Dim CHAR_WHITELIST As String = "ABC"
	ProgressBar1.Progress =tessapi47.mProgressIndicator
	tessapi47.CharWitelist(xui.LoadBitmap(File.DirAssets, "sample.jpg"),CHAR_WHITELIST,6)
	
End Sub






'pageSegMode
'       <item>PSM_OSD_ONLY</item> = 0
'        <item>PSM_AUTO_OSD</item> = 1
'        <item>PSM_AUTO_ONLY</item> = 2
'        <item>PSM_AUTO</item> = 3
'        <item>PSM_SINGLE_COLUMN</item> = 4
'        <item>PSM_SINGLE_BLOCK_VERT_TEXT</item> = 5
'        <item>PSM_SINGLE_BLOCK</item> = 6
'        <item>PSM_SINGLE_LINE</item> = 7
'        <item>PSM_SINGLE_WORD</item> = 8
'        <item>PSM_CIRCLE_WORD</item> = 9
'        <item>PSM_SINGLE_CHAR</item> = 10
'        <item>PSM_SPARSE_TEXT</item> = 11
'        <item>PSM_SPARSE_TEXT_OSD</item> = 12
'        <item>PSM_RAW_LINE</item> = 13
   
'
' ocringine
'   	OEM_TESSERACT_ONLY	0	Run Tesseract only - fastest; deprecated.
'OEM_LSTM_ONLY	1	
'OEM_TESSERACT_LSTM_COMBINED	2
'OEM_DEFAULT	3	

'*/      

'
'Private static int KEY_CONTRAST = 0 ;
'    Private static int KEY_UN_SHARP_MASKING = 1;
'    Private static int KEY_OTSU_THRESHOLD = 2;
'    Private static int KEY_FIND_SKEW_AND_DESKEW = 3;