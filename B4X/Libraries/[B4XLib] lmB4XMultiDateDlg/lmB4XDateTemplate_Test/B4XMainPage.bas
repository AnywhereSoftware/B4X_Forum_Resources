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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=\%PROJECT_NAME%.zip

'B4A ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4A\%PROJECT_NAME%.b4a
'B4i ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4i\%PROJECT_NAME%.b4i
'B4J ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4J\%PROJECT_NAME%.b4j

'Opens the project folder.
'Project folder: ide://run?file=%WINDIR%\SysWOW64\explorer.exe&Args=%PROJECT%

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

	Private mDlg As B4XDialog
	Private mDateTempl As lmB4XDateTemplate
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	If Not(modDB.InitDB("test.db", "lmB4XDateTemplate_Test", False)) Then
		Dim sf As Object = xui.MsgboxAsync("Error opening the DB.", "")
		Wait For (sf) Msgbox_Result (Result As Int)
		#IF B4J
			ExitApplication
		#End If
	End If

	mDlg.Initialize(Root)
	mDateTempl.Initialize(Me, "DateTempl")
	mDateTempl.SetMinAndMaxYear(1800, DateTime.GetYear(DateTime.Now))

'Try.	
'	mDateTempl.SetLightTheme

'Try.
'	mDateTempl.AllDaysClickable = True
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	Wait For (mDlg.ShowTemplate(mDateTempl, "", "", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Dim Note As String
		Dim Title As String
		Title = DateTime.Date(mDateTempl.Date)
		Note = modDB.GetNote(mDateTempl.Date)
		If Note <> Null Then
			Dim sf As Object = xui.MsgboxAsync(Note, Title)
			Wait For (sf) Msgbox_Result (Result As Int)
		End If
	End If
End Sub

Private Sub DateTempl_EnabledDays(Year As Int, Month As Int) As List
	Dim lstEnabledDays As List
	lstEnabledDays = modDB.GetNoteDays(Year, Month)
	Return lstEnabledDays
End Sub
