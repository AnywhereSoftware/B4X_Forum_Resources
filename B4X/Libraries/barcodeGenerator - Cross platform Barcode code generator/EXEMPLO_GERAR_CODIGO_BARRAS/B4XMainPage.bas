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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=barcodeGenerator.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Button1 As B4XView
	Private Button2 As B4XView
	Private B4XImageView1 As B4XImageView
	Private B4XFloatTextField1 As B4XFloatTextField
	Private B4XFloatTextField2 As B4XFloatTextField
	Private barcode As barcodeGenerator
	Private B4XFloatTextField3 As B4XFloatTextField
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	barcode.Initialize
	
	B4XFloatTextField1.Text = "7891268101799"
	B4XFloatTextField2.Text = "075678164125"
	B4XFloatTextField3.Text = "0123456789 abcABC"
End Sub

Private Sub B4XFloatTextField1_EnterPressed
	Button1_Click
End Sub

Private Sub Button1_Click	
	B4XImageView1.Bitmap = barcode.EAN13(B4XFloatTextField1.Text)
End Sub

Private Sub Button2_Click
	B4XImageView1.Bitmap = barcode.UPCA(B4XFloatTextField2.Text)
End Sub

Private Sub Button3_Click
	B4XImageView1.Bitmap = barcode.CODE128(B4XFloatTextField3.Text)
End Sub