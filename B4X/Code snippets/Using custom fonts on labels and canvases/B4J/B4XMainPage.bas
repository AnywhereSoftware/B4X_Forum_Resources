B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=DrawText.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Dim xCanvas As B4XCanvas
	Private Label1 As B4XView
	Private Label2 As B4XView
	Private Label3 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	xCanvas.Initialize(Root)

	Dim TextFont As B4XFont = GetTypeFont("Icip-AL3D2.ttf", 48)
	DrawTextWithOutline("Hello, World!", 100, 100, 1, xui.Color_Red, xui.Color_Blue, TextFont)
	
	Label1.Text = "Hello, World!"
	Label1.Font = TextFont
	Label1.TextColor = xui.Color_Blue
	
	Dim TextFont As B4XFont = GetTypeFont("KumarOneOutline-Regular.ttf", 48)
	DrawTextWithOutline("Hello, World!", 100, 180, 1, xui.Color_Black, xui.Color_Blue, TextFont)
	
	Label2.Text = "Hello, World!"
	Label2.Font = TextFont
	Label2.TextColor =  xui.Color_Blue
	
	Dim TextFont As B4XFont = xui.CreateDefaultFont(48)
	DrawTextWithOutline("Hello, World!", 100, 260, 2, xui.Color_Blue, xui.Color_White, TextFont)
	
	Label3.Text = "Hello, World!"
	Label3.Font = TextFont
	Label3.TextColor =  xui.Color_Blue
	
End Sub


'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Public Sub DrawTextWithOutline(text As String, x As Float, y As Float, Thickness As Int, OutlineColor As Int, TextColor As Int, TextFont As B4XFont)
	xCanvas.DrawText(text, x - Thickness, y, TextFont, OutlineColor, "LEFT")
	xCanvas.DrawText(text, x + Thickness, y, TextFont, OutlineColor, "LEFT")
	xCanvas.DrawText(text, x, y - Thickness, TextFont, OutlineColor, "LEFT")
	xCanvas.DrawText(text, x, y + Thickness, TextFont, OutlineColor, "LEFT")
	xCanvas.DrawText(text, x - Thickness, y - Thickness,  TextFont, OutlineColor, "LEFT")
	xCanvas.DrawText(text, x + Thickness, y - Thickness,  TextFont, OutlineColor, "LEFT")
	xCanvas.DrawText(text, x - Thickness, y + Thickness,  TextFont, OutlineColor, "LEFT")
	xCanvas.DrawText(text, x + Thickness, y + Thickness,  TextFont, OutlineColor, "LEFT")
	xCanvas.DrawText(text, x, y,  TextFont, TextColor, "LEFT")
	xCanvas.Invalidate
End Sub

Public Sub GetTypeFont(FontName As String, FontSize As Int) As B4XFont
    'Add in main APP B4i
    '#AppFont: <Font name>.ttf
    Dim FontCustom As B4XFont
    #If B4A
    FontCustom = xui.CreateFont(Typeface.LoadFromAssets(FontName),FontSize)
    #Else If B4J
    Dim fx As JFX
	FontCustom = xui.CreateFont(fx.LoadFont(File.DirAssets, FontName, FontSize), FontSize)
    #Else
    FontCustom = xui.CreateFont(Font.CreateNew2(FontName, FontSize), FontSize)
    #End If
    Return FontCustom
End Sub
