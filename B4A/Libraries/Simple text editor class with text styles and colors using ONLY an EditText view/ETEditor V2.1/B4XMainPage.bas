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
	Dim Panel1 As Panel
	Dim ET As EtEditor
	Dim Button1, Button2, Button3, Button4 As Button
	Dim rp As RuntimePermissions
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	ET.Initialize(Panel1,0, 10%y,100%x,90%y, 0)					'Initialize class with size, position and scale (normally set to 0)
	ET.CreateStyleSpinner(Panel1,100%x - 8%x,2%y,Colors.Black)	' Create Style spinner (If using the inbuilt one)
	ET.CreateColorSpinner(Panel1,100%x - 17%x,2%y,Colors.Black)	' Create Color spinner (If using the inbuilt one) 	
	ET.CreateZoomSlider(Panel1,100%x - 42%x,1%y,23%x,8%y)

	'ET.EditText.Text = "Welcome to ETEditor"					' Set a default text if required	
	If File.Exists(File.DirAssets,"Sample.et") Then				' Or read from a file	
		Wait for (ET.ReadFromFile(File.DirAssets,"Sample.et")) Complete (bResult As Boolean)
	End If
	
	Button1.textsize = 30 * ET.GetScale : Button2.textsize = 30 * ET.getscale : Button3.Textsize = 30 * ET.getscale : Button4.Textsize = 30 * ET.getscale
	Button1.SetLayout(1%x, 1%y,18%x,8%y)
	Button2.SetLayout(Button1.Left + Button1.Width + 1%x, 1%y, 15%x, 8%y)
	Button3.SetLayout(Button2.Left + Button2.Width + 1%x, 1%y, 9%x, 8%y)
	Button4.SetLayout(Button3.Left + Button3.Width + 1%x, 1%y, 9%x, 8%y)
	
	' copy the icon to the projects files folder, so we can use it to demonstrate inserting images.
	' This image will automatically resize if the EditText is zoomed.
	If File.Exists(rp.GetSafeDirDefaultExternal(""),"ETEditor.png") = False Then
		File.Copy(File.DirAssets,"ETEditor.png",rp.GetSafeDirDefaultExternal(""),"ETEditor.png")
	End If
	' The [NZ] in the file name stands for NonZoom. It means that this image will not resize if the EditText is zoomed.
	If File.Exists(rp.GetSafeDirDefaultExternal(""),"ETEditor[NZ].png") = False Then
		File.Copy(File.DirAssets,"ETEditor.png",rp.GetSafeDirDefaultExternal(""),"ETEditor[NZ].png")
	End If
End Sub	

Private Sub Button1_Click
	Dim rs As ResumableSub = ET.ReadFromFile(rp.GetSafeDirDefaultExternal(""),"Test.et")
 	  Wait For (rs) Complete (bResult As Boolean)
End Sub

Private Sub Button2_Click
	ET.SaveToFile(rp.GetSafeDirDefaultExternal(""),"Test.et")
End Sub

Private Sub Button3_Click
	' enabled / disabled 
	If ET.GetReadOnly = False Then
		ET.SetReadOnly(True,Colors.RGB(230,230,230))
		Button3.Text = "Enable" 
	Else
		ET.SetReadOnly(False,Colors.White)
		Button3.Text = "Disable"
	End If
End Sub

Private Sub Button4_Click
	' demo of how to insert an image
	If 1 = 0 Then
		' nonZoom image
		Dim rs As ResumableSub = ET.InsertImage(rp.GetSafeDirDefaultExternal(""),"ETEditor[NZ].png",50dip,0)
		Wait For (rs) Complete (bResult As Boolean)
	Else
		'Zoomable image
		Dim rs As ResumableSub = ET.InsertImage(rp.GetSafeDirDefaultExternal(""),"ETEditor.png",50dip,0)
		Wait For (rs) Complete (bResult As Boolean)
	End If
End Sub



