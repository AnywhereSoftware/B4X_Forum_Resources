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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Anchors2.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private BBCodeView1 As BBCodeView
	Private TextEngine As BCTextEngine
	Type Politician (Name As String, TwitterUserName As String, Birthday As Long, Party As String)
	Private politicians As List
	Private dialog As B4XDialog
	Private SearchTemplate As B4XSearchTemplate
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	TextEngine.Initialize(Root)
	politicians = LoadPolitiansDataSet
	dialog.Initialize(Root)
	dialog.Title = "Anchors Example"
	B4XPages.SetTitle(Me, dialog.Title)
	Sleep(400) 'let the layout load before the heavy stuff
	SearchTemplate.Initialize
	SearchTemplate.PrefixOnly = False
	Dim Names As List
	Names.Initialize
	For Each pol As Politician In politicians
		Names.Add(pol.Name)
	Next
	SearchTemplate.SetItems(Names)

	Dim n As Long = DateTime.Now
	BBCodeView1.Text = CreateBBCode
	Log($"parsing took: ${DateTime.Now - n}ms"$)
End Sub

Private Sub CreateBBCode As String
	DateTime.DateFormat = "MM/dd/yyyy"
	Dim sb As StringBuilder
	sb.Initialize
	For Each pol As Politician In politicians
		sb.Append($"
[a="${pol.Name}"][b][TextSize=18]${pol.Name}[/TextSize][/b][/a]
	Twitter: [url]@${pol.TwitterUserName}[/url]
	Birthday: $Date{pol.Birthday}
	${pol.Party}
"$)
	Next
	Return sb.ToString
End Sub

Private Sub LoadPolitiansDataSet As List
	DateTime.DateFormat = "yyyy-MM-dd'T'HH:mm:ssX"
	Dim su As StringUtils
	Dim res As List
	res.Initialize
	Dim data As List = su.LoadCSV(File.DirAssets, "dataset.csv", ",")
	Dim CheckForDuplicateNames As B4XSet
	CheckForDuplicateNames.Initialize
	For i = 1 To data.Size - 1 'skipping first row (0)
		Dim row() As String = data.Get(i)
		Dim name As String = row(0)
		If CheckForDuplicateNames.Contains(name) Then Continue
		CheckForDuplicateNames.Add(name)
		Dim twitter As String = row(1)
		Dim birthdayString As String = row(6)
		If birthdayString = "" Then Continue
		Dim birthday As Long = DateTime.DateParse(birthdayString)
		Dim party As String = row(9)
		res.Add(CreatePolitician(name, twitter, birthday, party))
		#if debug
		If res.Size = 500 Then Exit 'it can be a bit too slow in debug mode.
		#End If
	Next
	Return res
End Sub

Private Sub BBCodeView1_LinkClicked (URL As String)
	URL = "https://twitter.com/" & URL
	#if b4j
	Dim fx As JFX
	fx.ShowExternalDocument(URL)
	#else if B4i
	Main.App.OpenURL(URL)
	#Else If B4A
	Dim in As Intent
	in.Initialize(in.ACTION_VIEW, URL)
	StartActivity(in)
	#End If
End Sub

Private Sub btnJumpTo_Click
	Wait For (dialog.ShowTemplate(SearchTemplate, "", "", "Cancel")) Complete (result As Int)
	If result = xui.DialogResponse_Positive Then
		BBCodeView1.ScrollToAnchor(SearchTemplate.SelectedItem)
	End If
End Sub

Public Sub CreatePolitician (Name As String, TwitterUserName As String, Birthday As Long, Party As String) As Politician
	Dim t1 As Politician
	t1.Initialize
	t1.Name = Name
	t1.TwitterUserName = TwitterUserName
	t1.Birthday = Birthday
	t1.Party = Party
	Return t1
End Sub