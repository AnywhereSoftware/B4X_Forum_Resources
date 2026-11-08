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

'Version 1.01 March 2 2024
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI
	Private htree As horizontalTree
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	
	Private targetPanel As B4XView = xui.CreatePanel("")
	targetPanel.SetLayoutAnimated(0, 0dip, 0dip, Root.width, Root.height)
	Private styles As Map = CreateMap()
	'targetPanel.SetColorAndBorder(xui.Color_Transparent, 1, xui.Color_RGB(220, 220, 220), 0)

	styles.Put("Title", CreateMap("text": "A Flexible Horizontal Tree Chart", "textColor": xui.Color_RGB(0, 160, 0), "textSize": 25, "align": "center"))
	styles.Put("Notes", CreateMap("noteHeight": 25, "lines": CreateList(Array( _
			CreateMap("text": "Note 1: Red on gray are 'Special'", "textColor": xui.Color_RGB(100, 100, 100), "textSize": 15, "align": "left"), _
			CreateMap("text": "Note 2: Others are defaults", "textColor": xui.Color_RGB(100, 100, 100), "textSize": 15, "align": "left") _
	))))
	styles.Put("Connectors", CreateMap("color": xui.Color_RGB(160, 160, 160), "width": 2))
	styles.Put("Default", CreateMap("color": xui.Color_Blue, "bold": False, "textSize": 18, "borderColor": xui.Color_Blue))
	styles.Put("StyleA", CreateMap("color": xui.Color_Red, "bold": True, "textSize": 20, _
	"backgroundColor": xui.Color_RGB(200, 200, 200), "borderColor": xui.Color_Black, "borderWidth": 2, "borderRadius": 5))
	
	
	'Column index = level = number of leading tabs; | specifies row position; styles see above
	Dim spec As String = $"
Item 1|10, StyleA
	Item 1-1|7
		Item 1-1-1|3
		Item 1-1-2|4
		Item 1-1-3|5
			Item 1-1-3|7
	Item 1-2|9
		Item 1-2-1|9  
		Item 1-2-2|10, StyleA
			Item 1-1-3|12
	Item 1-3|10
		Item 1-3-1|15
    "$
	'The width of the panel and number of columns determine the width of each box
	'The height of the panel and number of rows determine the height of each box
	htree.Initialize(targetPanel, 17, 4, False, styles, spec)
	B4XPages.AddPageAndCreate("htree", htree)
	Sleep(0)
	B4XPages.ShowPage("htree")

	'grab and resize chart	
#if B4J	
	Dim im As ImageView
	im.Initialize("")
	Root.AddView(im, 100, 100, 600, 400)
	im.SetImage(htree.getBitmap)
#End if

End Sub

Private Sub CreateList(items() As Object) As List
	Dim result As List
	result.Initialize
	result.AddAll(items)
	Return result
End Sub

