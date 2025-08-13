B4A=true
Group=Pages
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private fx As JFX
	Private LblCategory As Label
	Public size As Int
	Public pnbuttons As Pane
	Public sp1 As ScrollPane
	Public sp1dragged As Boolean
	Private tooltipstyle As String
End Sub
Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")				
	B4XPages.SetTitle(Me, "Main Title")
	pnbuttons.Initialize("pnbuttons")
	sp1.Initialize("")
	sp1.Pannable = True
	sp1.SetHScrollVisibility("NEVER")
	sp1.SetVScrollVisibility("NEVER")
	sp1.FitToHeight = True			' no vertical dragging or mouse wheel scrolling!
'	size = 4
	size = 10
	LoadButtons
	pnbuttons.PrefWidth = 152 * size
	sp1.InnerNode = pnbuttons
	Root.AddView(sp1,5,50,590,60)	' Pane1 in the design reserves the place for the sp1
	sp1.TooltipText = "Click or drag to select." & CRLF & _
					  "Move the mouse after dragging to click."
	tooltipstyle = File.ReadString(File.DirAssets,"tooltipstyle.css")
	set_tooltip_style(sp1)
End Sub
Sub LoadButtons
	For i = 0 To size-1
		Dim pn As Pane = CreateButtonCategory("Sample Category" & (i+1))
		pnbuttons.AddNode(pn,1+(152*i),0,150,60)
	Next
End Sub
Private Sub CreateButtonCategory (ButtonText As String) As Pane
	Dim p As B4XView = xui.CreatePanel("")
	p.Color = xui.Color_Transparent
	p.LoadLayout("BtnCategory")
	p.SetLayoutAnimated(0, 0, 0, 150, pnbuttons.Height)
	p.Color = xui.Color_White
	LblCategory.Text = ButtonText
	CSSUtils.SetStyleProperty(LblCategory,"-fx-text-alignment","CENTER")
	Return p
End Sub
Private Sub category_MouseClicked (EventData As MouseEvent)
	If sp1dragged = True Then Return
	Dim lbl As Label = Sender
	xui.MsgboxAsync(lbl.Text & " clicked.","Category")
	EventData.Consume
End Sub
Private Sub category_MouseDragged (EventData As MouseEvent)
	sp1dragged = True
End Sub
Private Sub category_MouseMoved (EventData As MouseEvent)
	sp1dragged = False
	EventData.Consume
End Sub
Private Sub set_tooltip_style(vw As B4XView)
	Dim jo As JavaObject = vw
	Dim tooltip As JavaObject = jo.RunMethodJO("getTooltip",Null)
	tooltip.RunMethod("setStyle",Array As Object(tooltipstyle))
End Sub
