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
	Private B4XTable1 As B4XTable
	Private XL As XLUtils
End Sub

Public Sub Initialize
	
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	XL.Initialize
	Dim result As XLReaderResult = XL.Reader.ReadRange(File.DirAssets, "Countries of the world.xlsx", "Sheet1!B3:E1000")
'	Dim result As XLReaderResult = XL.Reader.ReadRange(File.DirAssets, "Countries of the world.xlsx", "Countries") 'named range
'	Dim result As XLReaderResult = XL.Reader.ReadSheetByName(File.DirAssets, "Countries of the world.xlsx", "Sheet1") 'complete sheet
	result.LogResult(True)

	B4XTable1.AddColumn(result.Get(XL.AddressName("B4")), B4XTable1.COLUMN_TYPE_TEXT)
	B4XTable1.AddColumn(result.Get(XL.AddressName("D4")), B4XTable1.COLUMN_TYPE_NUMBERS)
	B4XTable1.AddColumn(result.Get(XL.AddressName("E4")), B4XTable1.COLUMN_TYPE_NUMBERS)

	Dim TableData As List
	TableData.Initialize
	For Row1Based = 6 To result.BottomRight.Row0Based + 1
		Dim Country As String = result.Get(XL.AddressOne("B", Row1Based))
		If Country = "" Then Exit 'Not really needed in this case, but it is good practice.
		Dim Population As Int = result.Get(XL.AddressOne("D", Row1Based))
		Dim Area As Int = result.Get(XL.AddressOne("E", Row1Based))
		TableData.Add(Array(Country, Population, Area))
	Next
	B4XTable1.SetData(TableData)
End Sub
