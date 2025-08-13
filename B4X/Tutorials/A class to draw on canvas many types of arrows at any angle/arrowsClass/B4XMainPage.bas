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
	Private arrow As arrows
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	
	'square drawing surface made to fit screen for demo, landscape / portrait
	Dim wh As Float = Min(Root.width, Root.height)
	Dim xoffset, yoffset As Float
	If wh = Root.height Then xoffset = Root.Width/2 - wh / 2 Else yoffset = Root.Height/2 - wh / 2
	Dim surface As B4XView = xui.CreatePanel("")
	Root.AddView(surface, xoffset, yoffset, wh, wh)
	
	Dim cv As B4XCanvas: cv.Initialize(surface)
	Dim rx As B4XRect: rx.Initialize(0, 0, wh, wh)
	cv.DrawRect(rx, xui.Color_Black, False, 1)
	
	arrow.Initialize(cv)
	Dim arrowSpec As Map
	
	'Arrow 1	specified by the two end points, style dashed
	arrowSpec = CreateMap("Color": xui.Color_Black, "Filled": False, "DashColor": xui.Color_White, "Thickness": 10, "TipWidth": 25, "TipHeight": 30)
	arrow.draw(rx.Right - 100, rx.Bottom - 100, rx.Left + 100, rx.top + 100, arrowSpec)

	'Arrow 2	specified as a portion of a vector
	arrowSpec = CreateMap("Color": xui.Color_Blue, "Filled": True, "Thickness": 10, "TipWidth": 25, "TipHeight": 30)
	arrow.draw2(rx.Left, rx.Bottom, rx.Right, rx.top, 20, 70, arrowSpec)

	'Arrows 3, 4, 5	specified as a start point plus length and angle - start point is a circle
	arrowSpec = CreateMap("Color": xui.Color_Red, "Filled": True, "Thickness": 5, "TipWidth": 12, "TipHeight": 15)
	arrow.draw3(rx.CenterX, rx.CenterY + 80, 200, 25, arrowSpec)
	arrow.draw3(rx.CenterX, rx.CenterY + 80, 200, -25, arrowSpec)
	arrow.draw3(rx.CenterX, rx.CenterY + 80, 200, 145, arrowSpec)
	cv.DrawCircle(rx.CenterX, rx.CenterY + 80, 10, xui.Color_White, True, 0)
	cv.DrawCircle(rx.CenterX, rx.CenterY + 80, 10, xui.Color_Black, False, 1)

	'Arrow 6	specified as a start point plus length and angle - will be outlined
	Dim lineLength As Float = surface.Width / 3
	arrowSpec = CreateMap("Color": xui.Color_RGB(220, 220, 255), "Filled": True, "Thickness": 10, "TipWidth": 25, "TipHeight": 30)
	arrow.draw3(rx.CenterX, rx.CenterY - 50, lineLength, -90, arrowSpec)
	arrowSpec = CreateMap("Color": xui.Color_Black, "Filled": False, "Thickness": 10, "TipWidth": 25, "TipHeight": 30)
	arrow.draw3(rx.CenterX, rx.CenterY - 50, lineLength, -90, arrowSpec)

	'Arrow 7, 8	specified as a start point plus length and angle - will have a caption, two similar arrows
	arrowSpec = CreateMap("Color": xui.Color_Black, "Filled": False, "Thickness": 20, "TipWidth": 30, "TipHeight": 40)
	arrowSpec.Put("Caption", "Go There")
	arrowSpec.Put("Font", xui.CreateDefaultBoldFont(16))
	arrowSpec.Put("FontColor", xui.Color_Blue)
	arrow.draw3(rx.Left + 100, rx.Bottom - 50, lineLength, 0, arrowSpec)
	arrow.draw3(rx.right - 100, rx.Bottom - 50, lineLength, -160, arrowSpec)
	
	'Arrow 9	specified as a start point plus length and angle - will be skinny and filled and dashed
	arrowSpec = CreateMap("Color": xui.Color_Black, "Filled": True, "DashColor": xui.Color_White, "Thickness": 2, "TipWidth": 7, "TipHeight": 10)
	arrow.draw3(rx.CenterX, rx.CenterY + lineLength / 1.5, lineLength / 2, 90, arrowSpec)

	'Arrow 10	specified as a start point plus length and angle - filled WITHOUT an arrow tip - looks simply like an angled line
	arrowSpec = CreateMap("Color": xui.Color_Black, "Filled": True, "Thickness": 2, "TipWidth": 0, "TipHeight": 0)
	arrow.draw3(rx.Left + lineLength / 5, rx.CenterX, lineLength / 2, -70, arrowSpec)
	
	
End Sub

