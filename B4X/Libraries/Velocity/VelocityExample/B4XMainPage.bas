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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=VelocityExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Button1 As B4XView
	Private WebView1 As WebView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

Sub Button1_Click
	Dim TemplateDir As String
	Dim TemplateFile As String = "test.vm"

	#If B4A
	TemplateDir = File.DirInternal
	#Else If B4J
	TemplateDir = File.DirApp
	#End If
	
	If File.Exists(TemplateDir, TemplateFile) = False Then
		Wait For (File.CopyAsync(File.DirAssets, TemplateFile, TemplateDir, TemplateFile)) Complete (Success As Boolean)
		Log("Success: " & Success)
	End If
	
	#If B4A
	If File.Exists(TemplateDir, TemplateFile) Then
		TemplateFile = File.Combine(TemplateDir, TemplateFile)
	End If
	#End If
	
	Dim VTL As Velocity
	VTL.Initialize("")
	
	VTL.put("name", "Velocity")
	
	DateTime.DateFormat = "dd/MM/yyyy HH:mm:ss a"
	VTL.put("now", DateTime.Date(DateTime.Now))
	
	Dim Products As List
	Products.Initialize
	For i = 1 To 10
		Products.Add("Product " & i)
	Next
	VTL.put("Products", Products)
	
	#If B4A
	VTL.evaluate("", $"#set( $platform = "B4A" )"$)
	#Else If B4J
	VTL.evaluate("", $"#set( $platform = "B4J" )"$)
	#End If
	
	VTL.evaluate("", $"#set( $color = "lightgreen" )"$)
	
	' First method
	'VTL.Template = TemplateFile
	'VTL.merge

	' Second method
	VTL.mergeTemplate(TemplateFile, "UTF-8")
	
	WebView1.LoadHtml(VTL.ToString)
End Sub