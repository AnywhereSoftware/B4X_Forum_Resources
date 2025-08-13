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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

'https://www.b4x.com/android/forum/threads/b4x-comment-links.119897/

'B4A ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4A\%PROJECT_NAME%.b4a
'B4i ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4i\%PROJECT_NAME%.b4i
'B4J ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4J\%PROJECT_NAME%.b4j


'https://www.b4x.com/android/forum/threads/b4x-comment-link-to-build-b4xlib.119934/
'Ctrl + click to build b4xlib: ide://run?file=%JAVABIN%\jar.exe&WorkingDirectory=%PROJECT%\..&Args=-cMf&Args=%PROJECT_NAME%.b4xlib&&Args=..&Args=*.bas&Args=manifest.txt

'open the b4xlib manifest file with notepad++ ide://run?file=%COMSPEC%&args=/c&args=%PROJECT%\manifest.txt

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private BR_Button1 As BR_Button
End Sub

Public Sub Initialize	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	
	Root.LoadLayout("1")
	

	
	B4XPages.SetTitle(Me,"BR_Button")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	B4XPage_Resize(Width,Height)
	#End If
	
End Sub

#If B4I
Private Sub B4XPage_Resize (Width As Int, Height As Int)
End Sub
#End If

Sub B4XPage_Appear
End Sub

Private Sub BR_Button1_Click
	BR_Button1.Icon = xui.LoadBitmap(File.DirAssets, "iconaviso.png")
	BR_Button1.m_EnabledUpdateColorIcon = True
	BR_Button1.m_DisabledUpdateColorIcon = True
	BR_Button1.m_PressedUpdateColorIcon = True
	BR_Button1.Font = BR_Button1.CreateB4XFont("Inter-ExtraBold.ttf", 16)
	BR_Button1.Refresh
End Sub