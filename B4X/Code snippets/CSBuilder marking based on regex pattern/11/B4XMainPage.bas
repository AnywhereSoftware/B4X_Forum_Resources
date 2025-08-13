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
	Private Label1 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	Dim s As String = $"#Hello, this is a #Nice Day!
#nice test#test
#day"$
	Dim cs As CSBuilder = MarkPattern(s, "\B(#\w+)\b", 1)
	XUIViewsUtils.SetTextOrCSBuilderToLabel(Label1, cs)
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	xui.MsgboxAsync("Hello world!", "B4X")
End Sub

Private Sub MarkPattern(Input As String, Pattern As String, GroupNumber As Int) As CSBuilder
	Dim cs As CSBuilder
	cs.Initialize
	'this section applies to all text
	cs.Color(xui.Color_Black)
	#if B4i
	cs.Font(xui.CreateDefaultBoldFont(14))
	#else if B4A
	cs.Bold
	#end if
	Dim lastMatchEnd As Int = 0
	Dim m As Matcher = Regex.Matcher(Pattern, Input)
	Do While m.Find
		Dim currentStart As Int = m.GetStart(GroupNumber)
		cs.Append(Input.SubString2(lastMatchEnd, currentStart))
		lastMatchEnd = m.GetEnd(GroupNumber)
		'apply match styling here
		cs.Underline
		cs.Color(xui.Color_Blue)
		cs.Append(m.Group(GroupNumber))
		cs.Pop.Pop 'number should match number of stylings set.
	Loop
	If lastMatchEnd < Input.Length Then cs.Append(Input.SubString(lastMatchEnd))
	cs.PopAll
	Return cs
End Sub