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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals

	Private Root As B4XView
	Private xui As XUI

	Private KODI As wmKODI
	Private settingValues As Boolean = False
	Private activePlayerId As Int = -1
	Private favList As List
	Private KODImuted As Boolean = False

	' Designer Views
#If B4J
	Private TextFieldPort As TextField
	Private TextFieldURL As TextField
	Private ButtonConnect As Button
	Private PaneDetails As Pane
	Private ChoiceBoxFavourites As ChoiceBox
	Private ChoiceBoxActivePlayers As ChoiceBox
	Private ChoiceBoxSelectSpeed As ChoiceBox
	Private SliderSeekPercentage As Slider
	Private TextArea1 As TextArea
	Private RoundSliderVolume As RoundSlider
#Else
	Private TextFieldPort As EditText
	Private TextFieldURL As EditText
	Private ButtonConnect As Button
	Private PaneDetails As Panel
	Private ChoiceBoxFavourites As Spinner
	Private ChoiceBoxActivePlayers As Spinner
	Private ChoiceBoxSelectSpeed As Spinner
	Private SliderSeekPercentage As SeekBar
	Private TextArea1 As EditText
	Private RoundSliderVolume As RoundSlider
#End If

End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)

	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "wmKODIdemo")

	settingValues = True
#If B4J
	ChoiceBoxSelectSpeed.Items.AddAll(Array As String(-32, -16, -8, -4, -2, -1, 0, 1, 2, 4, 8, 16, 32))
#Else
	ChoiceBoxSelectSpeed.AddAll(Array As String(-32, -16, -8, -4, -2, -1, 0, 1, 2, 4, 8, 16, 32))
#End If
	settingValues = False

	ButtonConnect.RequestFocus ' So that the prompts for both TextFields are visible

End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub ButtonConnect_Click

	KODI.Initialize(TextFieldURL.Text & ":" & TextFieldPort.Text, "wmKODI logging", True, True, True)

	' Test if IP & port are ok
	Wait For (KODI.JSONRPC_Version) Complete (result As Map)
	If result.ContainsKey("error") Then
		Dim sf As Object = xui.Msgbox2Async( "The IP address and/or port doesn't seem to point to KODI", "Error", "", "Cancel", "", Null)
		Wait For (sf) Msgbox_Result (i As Int)
		Return
	Else
		PaneDetails.Visible = True
	End If

	' Get the available Players
	Wait For (KODI.Player_GetPlayers) Complete (result As Map)
	If result.ContainsKey("error") Then
		ReportResult("GET PLAYERS", result, True)
	Else
		TextArea1.Text = ""
		Dim lst As List = result.Get("playerslist")
		If lst.IsInitialized Then
			For Each onePlayer As Map In lst
				AddText("   " & onePlayer.Get("name") & ": " & onePlayer.Get("type") & "; plays audio=" & onePlayer.Get("playsaudio") & "; plays video=" & onePlayer.Get("playsvideo"))
			Next
			AddText("Available Players:")
		Else
			AddText("There are no available Players")
		End If
	End If

	' Get the Favourites
#If B4J
	ChoiceBoxFavourites.Items.Clear
#Else
	ChoiceBoxFavourites.Clear
#End If
	Wait For (KODI.Favourites_GetFavourites) Complete (result As Map)
	If result.ContainsKey("error") Then
		ReportResult("GET FAVOURITES", result, True)
	Else
		favList = result.Get("favourites")
		If favList.IsInitialized Then
			settingValues = True
			For Each oneFavourite As wmKODI_favourite In favList
#If B4J
				ChoiceBoxFavourites.Items.Add(oneFavourite.title)
#Else
				ChoiceBoxFavourites.Add(oneFavourite.title)
#End If
			Next
			settingValues = False
			AddText("Found " & favList.Size & " Favourites")
		Else
			AddText("There are no Favourites")
		End If
	End If

	' Get the active Players
	RefreshActivePlayers

	' Get the current volume
	Wait For (KODI.Application_GetVolume) Complete (result As Map)
	If result.IsInitialized And (result.ContainsKey("error") = False) Then
		RoundSliderVolume.Value = result.GetDefault("volume", 100).As(Int)
	End If

End Sub

#If B4A
Private Sub B4Abutton_Click

	Dim btn As Button = Sender
	If SubExists(Me, "Button" & btn.Tag & "_Click") Then CallSub(Me, "Button" & btn.Tag & "_Click")

End Sub

Private Sub B4Abutton_LongClick

	Dim btn As Button = Sender
	ToastMessageShow(btn.Tag, True)

End Sub
#End If

Private Sub ButtonUp_Click

	Wait For (KODI.Input_Up) Complete (result As Map)
	ReportResult("UP", result, False)

End Sub

Private Sub ButtonSelect_Click

	Wait For (KODI.Input_Select) Complete (result As Map)
	ReportResult("SELECT", result, False)

End Sub

Private Sub ButtonRight_Click

	Wait For (KODI.Input_Right) Complete (result As Map)
	ReportResult("RIGHT", result, False)

End Sub

Private Sub ButtonLeft_Click

	Wait For (KODI.Input_Left) Complete (result As Map)
	ReportResult("LEFT", result, False)

End Sub

Private Sub ButtonDown_Click

	Wait For (KODI.Input_Down) Complete (result As Map)
	ReportResult("DOWN", result, False)

End Sub

Private Sub ButtonBack_Click

	Wait For (KODI.Input_Back) Complete (result As Map)
	ReportResult("BACK", result, False)

End Sub

Private Sub ButtonHome_Click

	Wait For (KODI.Input_Home) Complete (result As Map)
	ReportResult("HOME", result, False)

End Sub

Private Sub ButtonContextMenu_Click

	Wait For (KODI.Input_ContextMenu) Complete (result As Map)
	ReportResult("CONTEXT MENU", result, False)

End Sub

Private Sub ButtonInfo_Click

	Wait For (KODI.Input_Info) Complete (result As Map)
	ReportResult("INFO", result, False)

End Sub

Private Sub ButtonShowOSD_Click

	Wait For (KODI.Input_ShowOSD) Complete (result As Map)
	ReportResult("SHOW OSD", result, False)

End Sub

Private Sub ButtonShowPlayerProcessInfo_Click

	Wait For (KODI.Input_ShowPlayerProcessInfo) Complete (result As Map)
	ReportResult("SHOW PLAYER PROCESS INFO", result, False)

End Sub

Private Sub ButtonRefreshActivePlayers_Click

	RefreshActivePlayers

End Sub

Private Sub RefreshActivePlayers

	activePlayerId = -1 ' No player selected yet
	Wait For (KODI.Player_GetActivePlayers) Complete (result As Map)
	If result.ContainsKey("error") Then
		ReportResult("GET ACTIVE PLAYERS", result, True)
	Else
		settingValues = True
		SliderSeekPercentage.Value = 0
#If B4J
		ChoiceBoxActivePlayers.Items.Clear
#Else
		ChoiceBoxActivePlayers.Clear
#End If
		Dim lstActivePlayers As List = result.Get("playerslist")
		For Each onePlayer As Map In lstActivePlayers
#If B4J
			ChoiceBoxActivePlayers.Items.add(onePlayer.Get("playerid") & ": " & onePlayer.Get("type") & ", " & onePlayer.Get("playertype"))
#Else
			ChoiceBoxActivePlayers.Add(onePlayer.Get("playerid") & ": " & onePlayer.Get("type") & ", " & onePlayer.Get("playertype"))
#End If
		Next
		settingValues = False
	End If

End Sub

#If B4A
Sub ChoiceBoxActivePlayers_ItemClick(Position As Int, Value As Object)
	ChoiceBoxActivePlayers_SelectedIndexChanged(Position, Value)
End Sub
#End If
Private Sub ChoiceBoxActivePlayers_SelectedIndexChanged(Index As Int, Value As Object)

	If settingValues Then Return
	If Index < 0 Then Return

	Dim i As Int = Value.As(String).IndexOf(":")
	activePlayerId = Value.As(String).SubString2(0, i)

	Dim properties As List = Array As String("audiostreams", "canchangespeed", "canmove", _
											"canrepeat", "canrotate", "canseek", _
											"canshuffle", "canzoom", "currentaudiostream", _
											"currentsubtitle", "currentvideostream", "live", _
											"partymode", "percentage", "playlistid", _
											"position", "repeat", "shuffled", _
											"speed", "subtitleenabled", "subtitles", _
											"time", "totaltime", "type", _
											"videostreams")
	Wait For (KODI.Player_GetProperties(activePlayerId, properties)) Complete (result As Map)
	If result.ContainsKey("error") Then
		ReportResult("GET PLAYER PROPERTIES", result, True)
		Return
	End If

	Dim returned As Map = result.Get("properties")
	For Each prop As String In returned.Keys
		AddText("   " & prop & "=" & returned.Get(prop))
	Next

	AddText("Active Player selected: " & activePlayerId & "; properties:")

End Sub

Private Sub ButtonMute_Click

	Wait For (KODI.Application_SetMute(Not(KODImuted))) Complete (result As Map)
	KODImuted = IIf(result.ContainsKey("result"), result.Get("result"), Not(KODImuted))

End Sub

Private Sub RoundSliderVolume_ValueChanged (Value As Int)

	Wait For (KODI.Application_SetVolume(RoundSliderVolume.Value)) Complete (result As Map)

End Sub

Private Sub ButtonStop_Click

	If ActivePlayerSelected = False Then Return

	Wait For (KODI.Player_Stop(activePlayerId)) Complete (result As Map)
	ReportResult("PLAYER STOP", result, False)

End Sub

Private Sub ButtonPlayPause_Click

	If ActivePlayerSelected = False Then Return

	Wait For (KODI.Player_PlayPause(activePlayerId)) Complete (result As Map)
	ReportResult("PLAYER PLAY/PAUSE", result, False)

End Sub

Private Sub ButtonSpeedFwd_Click

	If ActivePlayerSelected = False Then Return

	Wait For (KODI.Player_SetSpeedForward(activePlayerId)) Complete (result As Map)
	ReportResult("PLAYER SET SPEED FWD", result, False)

End Sub

Private Sub ButtonSpeedBackwd_Click

	If ActivePlayerSelected = False Then Return

	Wait For (KODI.Player_SetSpeedBackward(activePlayerId)) Complete (result As Map)
	ReportResult("PLAYER SET SPEED BACKWD", result, False)

End Sub

#If B4A
Sub ChoiceBoxSelectSpeed_ItemClick(Position As Int, Value As Object)
	ChoiceBoxSelectSpeed_SelectedIndexChanged(Position, Value)
End Sub
#End If
Private Sub ChoiceBoxSelectSpeed_SelectedIndexChanged(Index As Int, Value As Object)

	If ActivePlayerSelected = False Then Return

	Wait For (KODI.Player_SetSpeed(activePlayerId, Value)) Complete (result As Map)
	ReportResult("PLAYER SET SPEED", result, False)

End Sub

Private Sub ButtonGetItem_Click

	If ActivePlayerSelected = False Then Return

	Dim properties As List = Array As String("album", "artist", "duration", _
											"episode", "fanart", "file", _
											"season", "showtitle", "streamdetails", _
											"thumbnail", "title", "tvshowid")
	Wait For (KODI.Player_GetItem(activePlayerId, properties)) Complete (result As Map)
	If result.ContainsKey("error") Then
		ReportResult("GET PLAYER ITEM", result, True)
		Return
	End If

	Dim returned As Map = result.Get("properties")
	For Each prop As String In returned.Keys
		AddText("   " & prop & "=" & returned.Get(prop))
	Next

	AddText("Currently playing:")

End Sub

#If B4A
Sub SliderSeekPercentage_ValueChanged (Value As Int, UserChanged As Boolean)
	SliderSeekPercentage_ValueChange(Value)
End Sub
#End If
Private Sub SliderSeekPercentage_ValueChange (Value As Double)
	If settingValues Then Return
	If ActivePlayerSelected = False Then Return

	Wait For (KODI.Player_SeekPercentage(activePlayerId, Value)) Complete (result As Map)
	ReportResult("PLAYER SEEK PERCENTAGE", result, False)

End Sub

#If B4A
Sub ChoiceBoxFavourites_ItemClick(Position As Int, Value As Object)
	ChoiceBoxFavourites_SelectedIndexChanged(Position, Value)
End Sub
#End If
Private Sub ChoiceBoxFavourites_SelectedIndexChanged(Index As Int, Value As Object)

	Dim theFav As wmKODI_favourite

	If settingValues Then Return
	If favList.IsInitialized = False Then Return

	theFav = favList.Get(Index)
	Select Case theFav.favType
		Case "media", "window"
			AddText("Play favourite: " & theFav.title)
			KODI.Favourites_PlayFavourite(theFav)
		Case Else
			AddText("Sorry, I only play 'media' and 'window' favourites")
	End Select

End Sub

Private Sub ActivePlayerSelected As Boolean

	If activePlayerId < 0 Then
		AddText("Select a player first")
		ChoiceBoxActivePlayers.RequestFocus
		Return False
	Else
		Return True
	End If

End Sub

Private Sub ReportResult(action As String, result As Map, onlyIfError As Boolean)

	If result.ContainsKey("error") = False Then
		If onlyIfError = False Then AddText(action & ": completed")
	Else
		AddText(action & " - error: " & result.Get("error"))
	End If

End Sub

Private Sub AddText(txt As String)

	TextArea1.Text = txt & CRLF & TextArea1.Text

End Sub