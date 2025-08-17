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
#If B4J
	Private fx As JFX
#End If
	Private Root As B4XView			'ignore
	Private xui As XUI
	Private netDia As WiLNetChart
	Private myFont As B4XFont
End Sub

Public Sub Initialize
	'actual font sizes are computed programatically based on the screen width - adjusted for readability
#If B4J
	Dim tf As Font = fx.CreateFont("Arial", 10, True, True)
	myFont = xui.CreateFont( tf, 10)
#Else If B4A
	Dim tf As Typeface = Typeface.CreateNew(Typeface.SANS_SERIF, Typeface.STYLE_BOLD_ITALIC)
	myFont = xui.CreateFont(tf, 10)
#End If
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	netDia.Initialize(Me)
	B4XPages.AddPageAndCreate("netDia", netDia)
	
	'specification string ^ delimiter; ~ indicates "same as last"; * indicates "last plus spacing"; units are in mils = .001 * root.width
	Dim netString As String = $"
		Root^Center,100,400,125^RT\[Alignment=Center][TextSize=22][Color=Red][b]The Company[/b][/Color][/TextSize][/Alignment]
		CEO^75,*,220,90^Hans DeVoort
		VP-Finance^Center,~,220,90^Michael Rocher
		VP-HR^*,~,220,90^Emelia Hartman

		Root=CEO,VP-Finance,VP-HR
	"$		'ignore
	
	Dim connections As String =$"
		Root=CEO,VP-Finance,VP-HR
		VP-HR=HR-Assistant,HR-Recruitment
	"$		'ignore
	
	Dim contentMap As Map = CreateMap("Root": "The Company", "CEO": "Hans DeVoort", "VP-Finance": "Michael Rocher", _
						"VP-HR": "Emelia Hartman", "HR-Assistant": "Alice Smart", "HR-Recruitment": "George Jones")		'ignore

'	netDia.nodeSpec.Put("Font", myFont)		'overrides default font

	netDia.fromLayout("netLayout1")
'	netDia.fromNetString(netString, Root.Width / 10, Root.Height / 5)
'	netDia.fromConnections(connections, contentMap, 3, 4)

	netDia.renderNetChart
	Sleep(0)
	B4XPages.ShowPage("netDia")

	netDia.draggable = True
	
	'After five seconds this node should change to red italics
'	Sleep(5000)
'	netDia.ChangeNode("HR-Assistant", Null, CreateMap("Font": myFont, "TextColor": xui.Color_Red))
End Sub

Public Sub netChartClicked(partName As String, coords() As Object)
	Dim part As NetPart = netDia.register.Get(partName)
	If part.isNode Then
		If part.specMap.Get("Color").As(Int) = xui.Color_Blue Then
			Dim customSpec As Map = CreateMap("Color": xui.Color_White, "TextColor": xui.Color_Black)
		Else
			Dim customSpec As Map = CreateMap("Color": xui.Color_Blue, "TextColor": xui.Color_White)
		End If
		netDia.ChangeNode(partName, part.Content, customSpec)
	Else
		If part.specMap.Get("Color").As(Int) = xui.Color_Red Then
			Dim customSpec As Map = CreateMap("Color": xui.Color_Black, "Filled": True, "Thickness": 2, "TipWidth": 10, "TipHeight": 13)
		Else
			Dim customSpec As Map = CreateMap("Color": xui.Color_Red, "Filled": False, "Thickness": 5, "TipWidth": 10, "TipHeight": 13)
		End If
		
		netDia.ChangeConnector(partName, customSpec, 0, 0)
	End If
End Sub

Public Sub netNodeMoved(partName As String, coords() As Object)
	Log(partName & " has moved to " & TAB & coords(0) & TAB & coords(1))
End Sub
