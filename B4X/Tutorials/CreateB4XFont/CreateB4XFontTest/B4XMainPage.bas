B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#If B4i
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files\Special"
#Else
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
#End If
#Macro: Title, B4XPages Export, ide://run?File=%B4X%\Zipper.jar&Args=CreateB4XFont.zip
#Macro: Title, GitHub Desktop, ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=github&Args=..\..\
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

Sub Class_Globals
	Private Root As B4XView
	#If B4J
	Private fx As JFX
	#End If
	Private xui As XUI
	Private Label1 As B4XView
	Private xLBL As B4XView
	Private mCurrentFont As B4XFont
	Private mFontSize As Float
	Private mFontStyle As String
	Private mFontName As String
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

Private Sub Button1_Click
	#If B4i
	Label1.Font = CreateB4XFont("D3-Biscuitism-Bold", 30, 30)
	#Else
	Label1.Font = CreateB4XFont("D3_Biscuitism_Bold.ttf", 30, 30)
	#End If
	
	#If B4A
	SetFontSize(60)
	SetFontName("FONTAWESOME")
	SetFontStyle("BOLD_ITALIC")
	CreateFont
	xLBL.Text = Chr(0xF1BB)
	xLBL.TextColor = xui.Color_Green
	#End If
End Sub

'NativeFontSize is needed only for B4J or B4i
'Of course you have to pass a dummy-not-used value if you are developing in B4A.
Public Sub CreateB4XFont (FontFileName As String, FontSize As Float, NativeFontSize As Float) As B4XFont
	Dim NewFont As B4XFont
	#If B4A
		NewFont = xui.CreateFont(Typeface.LoadFromAssets(FontFileName), FontSize)
	#Else If B4i
		NewFont = xui.CreateFont(Font.CreateNew2(FontFileName, NativeFontSize), FontSize)
	#Else	' B4J
		Dim NativeFont As Font = fx.LoadFont(File.DirAssets, FontFileName, NativeFontSize)
		NewFont = xui.CreateFont(NativeFont, FontSize)
	#End If
	Return NewFont
End Sub

Public Sub SetFontSize (FontSize As Float)
	mFontSize = FontSize
End Sub

Public Sub SetFontName (FontName As String)
	mFontName = FontName
End Sub

Public Sub SetFontStyle (FontStyle As String)
	mFontStyle = FontStyle
End Sub

Public Sub CreateFont
	Try
		Dim TypeFaceName As Typeface
		Dim TypeFaceStyle As Int
		Select mFontName.ToUpperCase
			Case "SERIF"
				TypeFaceName = Typeface.SERIF
			Case "DEFAULT", ""
				TypeFaceName = Typeface.DEFAULT
			Case "MONOSPACE"
				TypeFaceName = Typeface.MONOSPACE
			Case "SANS_SERIF"
				TypeFaceName = Typeface.SANS_SERIF
			Case "FONTAWESOME"
				TypeFaceName = Typeface.FONTAWESOME
			Case "MATERIALICONS"
				TypeFaceName = Typeface.MATERIALICONS
			Case Else
				TypeFaceName = Typeface.LoadFromAssets(mFontName)
		End Select
		Select mFontStyle.ToUpperCase
			Case "BOLD"
				TypeFaceStyle = Typeface.STYLE_BOLD
			Case "ITALIC"
				TypeFaceStyle = Typeface.STYLE_ITALIC
			Case "BOLD_ITALIC"
				TypeFaceStyle = Typeface.STYLE_BOLD_ITALIC
			Case Else
				TypeFaceStyle = Typeface.STYLE_NORMAL
		End Select
		TypeFaceName = Typeface.CreateNew(TypeFaceName, TypeFaceStyle)
		mCurrentFont = xui.CreateFont(TypeFaceName, mFontSize)
	Catch
		Log("Error creating font, using default")
		mCurrentFont = xui.CreateDefaultFont(mFontSize)
	End Try
	If xLBL.IsInitialized Then
		xLBL.Font = mCurrentFont
	End If
End Sub