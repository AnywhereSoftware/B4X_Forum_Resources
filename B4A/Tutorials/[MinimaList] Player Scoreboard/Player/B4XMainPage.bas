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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Dialog1 As B4XDialog
	Private AllPlayers As MinimaList
	Private LblPlayer1 As B4XView
	Private LblPlayer2 As B4XView
	Private LblPlayer3 As B4XView
	Private LblScore1 As B4XView
	Private LblScore2 As B4XView
	Private LblScore3 As B4XView
	Private LblResults As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Page1")
	B4XPages.SetTitle(Me, "Player")
	Dialog1.Initialize(Root)

	LblPlayer1.Text = "Player A"
	LblPlayer2.Text = "Player B"
	LblPlayer3.Text = "Player C"
	LblScore1.Text = 6
	LblScore2.Text = 41
	LblScore3.Text = 14
	
	AllPlayers.Initialize
	AllPlayers.Add(CreateMap("Name": LblPlayer1.Text, "Score": LblScore1.Text.As(Int)))
	AllPlayers.Add(CreateMap("Name": LblPlayer2.Text, "Score": LblScore2.Text.As(Int)))
	AllPlayers.Add(CreateMap("Name": LblPlayer3.Text, "Score": LblScore3.Text.As(Int)))
	ShowResult
End Sub

#If B4J
Private Sub LblPlayer_MouseClicked (EventData As MouseEvent)
#Else
Private Sub LblPlayer_Click
#End If
	Dim lbl As Label = Sender
	Wait For (ShowInputNameDialog(lbl)) Complete (Name As String)
	AllPlayers.Find(lbl.Tag).Put("Name", Name)
	lbl.Text = Name
	ShowResult
End Sub

#If B4J
Private Sub LblScore_MouseClicked (EventData As MouseEvent)
#Else
Private Sub LblScore_Click
#End If
	Dim lbl As Label = Sender
	Wait For (ShowInputScoreDialog(lbl)) Complete (Score As Int)
	AllPlayers.Find(lbl.Tag).Put("Score", Score)
	lbl.Text = Score
	ShowResult
End Sub

Private Sub ShowResult
	AllPlayers.SortByKey("Score", False)
	Dim HighestScore As Int = AllPlayers.First.Get("Score")
	Dim LowestScore As Int = AllPlayers.Last.Get("Score")
	If HighestScore = LowestScore Then
		LblResults.Text = "Currently no winner."
	Else
		LblResults.Text = $"The winner is ${AllPlayers.First.Get("Name")}."$
	End If
End Sub

'Private Sub B4XPage_Resize (Width As Double, Height As Double)
'	If Dialog1.Visible Then Dialog1.Resize(Width, Height)
'End Sub

Private Sub ShowInputNameDialog (Lbl As B4XView) As ResumableSub
	Dim res As String = Lbl.Text
	Dim input As B4XInputTemplate
	input.Initialize
	input.lblTitle.Text = $"Enter Name for Player ${Lbl.Tag}:"$
	input.RegexPattern = "^(?!\s+$).+" 'disallow empty spaces
	input.Text = res
	Wait For (Dialog1.ShowTemplate(input, "OK", "", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		res = input.Text
		'Log(res)
	End If
	Return res
End Sub

Private Sub ShowInputScoreDialog (Lbl As B4XView) As ResumableSub
	Dim res As Int = Lbl.Text
	Dim input As B4XInputTemplate
	input.Initialize
	input.lblTitle.Text = $"Enter Score for Player ${Lbl.Tag}:"$
	input.ConfigureForNumbers(False, False) 'AllowDecimals, AllowNegative
	input.Text = res
	Wait For (Dialog1.ShowTemplate(input, "OK", "", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		res = input.Text 'no need to check with IsNumber
		'Log(res)
	End If
	Return res
End Sub