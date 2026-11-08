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
	Private fx As JFX

	
	Private mForm As Form
	Private v As SVGVectorizer
	Private Potrace As String
	Private OutPath As String = "d:\out"
	
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
		
	mForm = B4XPages.GetNativeParent(Me)
	Potrace = File.Combine(OutPath,"potrace.exe")
	v.Initialize(mForm, Potrace)
	v.SetErrorHandler(Me, "SVG_Error")

End Sub

'========
' To SVG
'========
Private Sub ToSVG_Monochrome_MouseClicked (EventData As MouseEvent)
	Dim bmp As B4XBitmap = xui.LoadBitmap(File.DirAssets, "Monochrome.png")
	Dim svg As String = v.VectorizeBW(bmp, True)
	
	If svg <> "" Then
		File.WriteString(OutPath, "Monochrome.svg", svg)
		Log("Monochrome : Ok")
	End If
	
End Sub

Private Sub ToSVG_SingleColor_MouseClicked (EventData As MouseEvent)
	Dim bmpOneColor As B4XBitmap = xui.LoadBitmap(File.DirAssets, "Singlecolor.png")
	Dim svgOneColor As String = v.VectorizeSingleColor(bmpOneColor, True)
	
	If svgOneColor <> "" Then
		File.WriteString(OutPath, "Singlecolor.svg", svgOneColor)
		Log("Singlecolor : Ok")
	Else
		Log("Error! ")
	End If
End Sub

Private Sub ToSVG_MultiColor_MouseClicked (EventData As MouseEvent)
	Dim bmpColor As B4XBitmap = xui.LoadBitmap(File.DirAssets, "Multicolor.png")
	Dim svgColor As String = v.VectorizeColor(bmpColor, True)

	If svgColor <> "" Then
		File.WriteString(OutPath, "Multicolor.svg", svgColor)
		Log("Multicolor : Ok")
	Else
		Log("Error! ")
	End If
End Sub

'===========
' To BITMAP
'===========
Private Sub To_BMP_MouseClicked (EventData As MouseEvent)
	Dim svgPath As String = File.Combine(OutPath, "Multicolor.svg")
	Dim output As String = File.Combine(OutPath, "Multicolor.png")
	v.SVGToPNG(svgPath,output)
	Log("BMP : Ok")
End Sub


'================
' ERROR Handling
'================
Sub SVG_Error(Message As String)
	Log("SVG ERROR : " & Message)
	xui.MsgboxAsync(Message, "Erreur SVG")
End Sub
