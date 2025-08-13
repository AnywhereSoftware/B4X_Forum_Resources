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
	Private BBCodeView1 As BBCodeView
	Private SMM As SimpleMediaManager
	Private TextEngine As BCTextEngine
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	TextEngine.Initialize(Root)
	SMM.Initialize
	BBCodeView1.Text = $"[b]Title[/b]
j fkselfj wlek fjwklefj klwefj klwef jklwef jklwe f
 sdfjklsjfd ${Media(100dip, 100dip, "https://b4x-4c17.kxcdn.com/android/forum/data/avatars/m/109/109282.jpg?1520253241")}
 Animated gif (do not forget to add SMM_GIF): ${Media(100dip, 100dip, "https://www.b4x.com/android/forum/attachments/anywhere-sw-gif.87363/")}
 And a video (SMM_VIDEO): ${Media(200dip, 300dip, "https://player.vimeo.com/external/354886143.hd.mp4?s=2e182d1b22282a63a9533ffda5bb0b2295cdb8e6&profile_id=175")}
"$
End Sub

Private Sub Media(Width As Int, Height As Int, URL As String) As String
	Dim pnl As B4XView = xui.CreatePanel("")
	pnl.SetLayoutAnimated(0, 0, 0, Width, Height)
	SMM.SetMedia(pnl, URL)
	Dim name As String = "view" & BBCodeView1.Views.Size
	BBCodeView1.Views.Put(name, pnl)
	Return $"[View=${name}/]"$
End Sub