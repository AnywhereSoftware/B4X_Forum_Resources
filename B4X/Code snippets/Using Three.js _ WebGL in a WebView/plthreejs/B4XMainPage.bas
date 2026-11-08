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
	
	#If B4A
	Private WebView As WebView
	#End If

	#If B4I
	Private WebView As WKWebView
	#End If
	
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	#If B4I
	Dim no As NativeObject = WebView
	no.GetField("scrollView").SetField("bounces", False)
	#End If

	' Create an instance of the plthreejs class and initializes it with the WebView/WKWebView (should be added with the Designer)
	Dim pl As plthreejs
	pl.Initialize(WebView)
	
	' Specify the options
	pl.BackgroundColor = xui.Color_ARGB(255, 30, 30, 30)
	pl.Filename = "index.html"
	pl.RequestAnimationFrame = False
	
	' Create the basic HTML file with the above options
	pl.PrepareHTML
	
	' Loads the created HTML file
	pl.LoadHTML
	
	#If B4A
	Wait For WebView_PageFinished(Url As String)
	#End If
	
	#If B4I
	Wait For WebView_PageFinished (Success As Boolean, Url As String)
	#End If
	
	' Create a geometry and add it to the viewport
	pl.CreateTorusKnotGeometry(10, 3, 100, 16, 2, 3, pl.MaterialType_MeshStandardMaterial, xui.Color_ARGB(255, 255, 128, 0))
	
	' Set the camera position
	pl.SetCameraPosition(0, 0, 180)
	
	' Add a light
	pl.AddPointLight(100, 100, 200, xui.Color_White, 2, True)

	' Render the scene
	pl.render
		
End Sub
