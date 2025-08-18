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
	Private xl As XLUtils
	Private Workbook As XLWorkbookWriter
	Private CustomListView1 As CustomListView
	Private FileChooser As FileChooser
	Private txtItem As B4XFloatTextField
	Private txtAmount As B4XFloatTextField
	Private AnotherProgressBar1 As AnotherProgressBar
End Sub

Public Sub Initialize
	xl.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "Pie Creator")
	FileChooser.Initialize
	FileChooser.setExtensionFilter("Excel Workbook", Array As String("*.xlsx"))
End Sub

Private Sub txtItem_EnterPressed
	If txtItem.Text = "" Then
		txtItem.RequestFocusAndShowKeyboard
	Else
		txtAmount.RequestFocusAndShowKeyboard
	End If
End Sub

Private Sub txtAmount_EnterPressed
	If IsNumber(txtAmount.Text) = False Then
		txtAmount.RequestFocusAndShowKeyboard
	Else
		CustomListView1.AddTextItem($"${txtItem.Text}: ${txtAmount.Text}"$, Array(txtItem.Text, txtAmount.Text)) 'using an UI element as a data store is not very elegant...
		txtItem.RequestFocusAndShowKeyboard
	End If
End Sub

Private Sub btnCreate_Click
	If CustomListView1.Size = 0 Then Return
	AnotherProgressBar1.Visible = True
	Workbook = xl.CreateWriterFromTemplate(File.DirAssets, "Template.xlsx")
	Dim sheet As XLSheetWriter = Workbook.CreateSheetWriterByName("Sheet1")
	For i = 0 To CustomListView1.Size - 1
		Dim item() As Object = CustomListView1.GetValue(i)
		sheet.PutString(xl.AddressOne("B", 4 + i), item(0))
		sheet.PutNumber(xl.AddressOne("C", 4 + i), item(1))
	Next
	Dim LastRow1 As Int = sheet.LastAccessed.Row0Based + 1
	Workbook.AddNamedRange("Item", xl.CreateXLRangeWithSheet(xl.AddressName("B4"), xl.AddressOne("B", LastRow1), sheet.PoiSheet))
	Workbook.AddNamedRange("Amount", xl.CreateXLRangeWithSheet(xl.AddressName("C4"), xl.AddressOne("C", LastRow1), sheet.PoiSheet))
	sheet.PrintArea = xl.CreateXLRange(xl.AddressName("A1"), xl.AddressName("L24"))
	sheet.SetFitToPage(1, 1) 'scale it to fit a single page
	sheet.PutString(xl.AddressName("A24"), $"Created at $DateTime{DateTime.Now}"$)
	
	Dim f As String = FileChooser.ShowSave(B4XPages.GetNativeParent(Me))
	If f <> "" Then
		f = Workbook.SaveAs(f, "", True)
		Wait For (xl.PowerShellConvertToPdf(f, f.Replace(".xlsx", ".pdf"), 0, True)) Complete (Success As Boolean)
		If Success = False Then
			xui.MsgboxAsync("Failed to create pdf file", "")
		Else
			CustomListView1.Clear
		End If
	End If
	AnotherProgressBar1.Visible = False
End Sub

