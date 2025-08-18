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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=CreateB4XFontTest.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Label1 As B4XView
	Private FX As JFX
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	Label1.Font = CreateB4XFont("D3_Biscuitism_Bold.ttf", 30, 30)
End Sub

'NativeFontSize is needed only for B4J or B4I.
'Of course you have to pass a dummy-not-used value if you are developing in B4A.
'It uses xui (also FX in B4J) which must be declared at the module level.
Public Sub CreateB4XFont(FontFileName As String, FontSize As Float, NativeFontSize As Float) As B4XFont
	#IF B4A
		Return xui.CreateFont(Typeface.LoadFromAssets(FontFileName), FontSize)
	#ELSE IF B4I
		Return xui.CreateFont(Font.CreateNew2(FontFileName, NativeFontSize), FontSize)
	#ELSE ' B4J
		Return xui.CreateFont(FX.LoadFont(File.DirAssets, FontFileName, NativeFontSize), FontSize)
	#END IF
End Sub

