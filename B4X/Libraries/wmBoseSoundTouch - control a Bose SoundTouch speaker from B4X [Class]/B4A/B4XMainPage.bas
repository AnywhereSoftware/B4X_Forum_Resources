B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'Ctrl + click to export as zip: ide://run?File=%ADDITIONAL%\ZipperWm.jar&Args=|target|%PROJECT_NAME%_%YYYY%-%MM%-%DD%.zip|exclude|%ADDITIONAL%\zipperwmexclusions.txt|movedown|includemodules|explorerwine|/usr/bin/nemo

Sub Class_Globals

	Private Root As B4XView
	Private xui As XUI

	Private wmBoseSoundTouch1 As wmBoseSoundTouch
	Private settingValues As Boolean = False

	' Designer Views
#If B4J
	Private TextFieldIP As TextField
	Private ButtonConnect As Button
	Private PaneDetails As Pane
	Private ChoiceBoxGet As ChoiceBox
	Private ChoiceBoxKey As ChoiceBox
	Private TextArea1 As TextArea
#Else
	Private TextFieldIP As EditText
	Private ButtonConnect As Button
	Private PaneDetails As Panel
	Private ChoiceBoxGet As Spinner
	Private ChoiceBoxKey As Spinner
	Private TextArea1 As EditText
#End If

End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)

	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "wmBoseSoundTouchDemo")

	settingValues = True
#If B4J
	ChoiceBoxGet.Items.AddAll(Array As String("Bass", "BassCapabilities", "Info", "NowPlaying", "Presets", "Sources", "Volume"))
#Else
	ChoiceBoxGet.AddAll(Array As String("Bass", "BassCapabilities", "Info", "NowPlaying", "Presets", "Sources", "Volume"))
#End If
	settingValues = False

	ButtonConnect.RequestFocus ' So that the prompts for the TextField is visible

End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub ButtonConnect_Click

	wmBoseSoundTouch1.Initialize(TextFieldIP.Text, "wmBoseSoundTouch logging", True, True, True)

	' Test if IP is ok
	Wait For (wmBoseSoundTouch1.GetInfo) Complete (result As Map)
	If result.ContainsKey("error") Then
		Dim sf As Object = xui.Msgbox2Async("The IP address doesn't seem to point to a Bose SoundTouch device", "Error", "", "Cancel", "", Null)
		Wait For (sf) Msgbox_Result (i As Int)
		Return
	Else
		PaneDetails.Visible = True
	End If

	' Populate ChoiceBoxKey
	
#If B4J
	ChoiceBoxKey.Items.Clear
	ChoiceBoxKey.Items.AddAll(Array As String(wmBoseSoundTouch1.KEY_PLAY, wmBoseSoundTouch1.KEY_PAUSE, wmBoseSoundTouch1.KEY_STOP, wmBoseSoundTouch1.KEY_PREV_TRACK, wmBoseSoundTouch1.KEY_NEXT_TRACK, wmBoseSoundTouch1.KEY_THUMBS_UP, wmBoseSoundTouch1.KEY_THUMBS_DOWN, wmBoseSoundTouch1.KEY_BOOKMARK, wmBoseSoundTouch1.KEY_POWER, wmBoseSoundTouch1.KEY_MUTE, wmBoseSoundTouch1.KEY_VOLUME_UP, wmBoseSoundTouch1.KEY_VOLUME_DOWN, wmBoseSoundTouch1.KEY_PRESET_1, wmBoseSoundTouch1.KEY_PRESET_2, wmBoseSoundTouch1.KEY_PRESET_3, wmBoseSoundTouch1.KEY_PRESET_4, wmBoseSoundTouch1.KEY_PRESET_5, wmBoseSoundTouch1.KEY_PRESET_6, wmBoseSoundTouch1.KEY_AUX_INPUT, wmBoseSoundTouch1.KEY_SHUFFLE_OFF, wmBoseSoundTouch1.KEY_SHUFFLE_ON, wmBoseSoundTouch1.KEY_REPEAT_OFF, wmBoseSoundTouch1.KEY_REPEAT_ONE, wmBoseSoundTouch1.KEY_REPEAT_ALL, wmBoseSoundTouch1.KEY_PLAY_PAUSE, wmBoseSoundTouch1.KEY_ADD_FAVORITE, wmBoseSoundTouch1.KEY_REMOVE_FAVORITE))
#Else
	ChoiceBoxKey.Clear
	ChoiceBoxKey.AddAll(Array As String(wmBoseSoundTouch1.KEY_PLAY, wmBoseSoundTouch1.KEY_PAUSE, wmBoseSoundTouch1.KEY_STOP, wmBoseSoundTouch1.KEY_PREV_TRACK, wmBoseSoundTouch1.KEY_NEXT_TRACK, wmBoseSoundTouch1.KEY_THUMBS_UP, wmBoseSoundTouch1.KEY_THUMBS_DOWN, wmBoseSoundTouch1.KEY_BOOKMARK, wmBoseSoundTouch1.KEY_POWER, wmBoseSoundTouch1.KEY_MUTE, wmBoseSoundTouch1.KEY_VOLUME_UP, wmBoseSoundTouch1.KEY_VOLUME_DOWN, wmBoseSoundTouch1.KEY_PRESET_1, wmBoseSoundTouch1.KEY_PRESET_2, wmBoseSoundTouch1.KEY_PRESET_3, wmBoseSoundTouch1.KEY_PRESET_4, wmBoseSoundTouch1.KEY_PRESET_5, wmBoseSoundTouch1.KEY_PRESET_6, wmBoseSoundTouch1.KEY_AUX_INPUT, wmBoseSoundTouch1.KEY_SHUFFLE_OFF, wmBoseSoundTouch1.KEY_SHUFFLE_ON, wmBoseSoundTouch1.KEY_REPEAT_OFF, wmBoseSoundTouch1.KEY_REPEAT_ONE, wmBoseSoundTouch1.KEY_REPEAT_ALL, wmBoseSoundTouch1.KEY_PLAY_PAUSE, wmBoseSoundTouch1.KEY_ADD_FAVORITE, wmBoseSoundTouch1.KEY_REMOVE_FAVORITE))
#End If
	
End Sub

Private Sub ButtonAux_Click

	Wait For (wmBoseSoundTouch1.SelectAux) Complete (result As Map)
	ReportResult("SelectAux", result, False)

End Sub

Private Sub ButtonBluetooth_Click

	Wait For (wmBoseSoundTouch1.SelectBluetooth) Complete (result As Map)
	ReportResult("SelectBluetooth", result, False)

End Sub

Private Sub ButtonMute_Click

	Wait For (wmBoseSoundTouch1.Mute) Complete (result As Map)
	ReportResult("Mute", result, False)

End Sub

Private Sub ButtOnOff_Click

	Wait For (wmBoseSoundTouch1.PowerOff) Complete (result As Map)
	ReportResult("PowerOff", result, False)

End Sub

Private Sub ButtonOn_Click

	Wait For (wmBoseSoundTouch1.PowerOn) Complete (result As Map)
	ReportResult("PowerOn", result, False)

End Sub

Private Sub ButtonUnmute_Click

	Wait For (wmBoseSoundTouch1.Unmute) Complete (result As Map)
	ReportResult("Unmute", result, False)

End Sub

Private Sub ButtonVol10_Click

	Wait For (wmBoseSoundTouch1.SetVolume(10)) Complete (result As Map)
	ReportResult("SetVolume 10", result, False)

End Sub

Private Sub ButtonVol20_Click

	Wait For (wmBoseSoundTouch1.SetVolume(20)) Complete (result As Map)
	ReportResult("SetVolume 20", result, False)

End Sub

#If B4A
Sub ChoiceBoxGet_ItemClick(Position As Int, Value As Object)
	ChoiceBoxGet_SelectedIndexChanged(Position, Value)
End Sub
#End If
Private Sub ChoiceBoxGet_SelectedIndexChanged(Index As Int, Value As Object)

	If settingValues Then Return
	If Index < 0 Then Return

	Select Case Value
		Case "Bass"
			Wait For (wmBoseSoundTouch1.GetBass) Complete (result As Map)
		Case "BassCapabilities"
			Wait For (wmBoseSoundTouch1.GetBassCapabilities) Complete (result As Map)
		Case "Info"
			Wait For (wmBoseSoundTouch1.GetInfo) Complete (result As Map)
		Case "NowPlaying"
			Wait For (wmBoseSoundTouch1.GetNowPlaying) Complete (result As Map)
		Case "Presets"
			Wait For (wmBoseSoundTouch1.GetPresets) Complete (result As Map)
		Case "Sources"
			Wait For (wmBoseSoundTouch1.GetSources) Complete (result As Map)
		Case "Volume"
			Wait For (wmBoseSoundTouch1.GetVolume) Complete (result As Map)
	End Select

	ReportResult(Value, result, True)
	ChoiceBoxGet.SelectedIndex = -1

End Sub

#If B4A
Sub ChoiceBoxKey_ItemClick(Position As Int, Value As Object)
	ChoiceBoxKey_SelectedIndexChanged(Position, Value)
End Sub
#End If
Private Sub ChoiceBoxKey_SelectedIndexChanged(Index As Int, Value As Object)

	If settingValues Then Return
	If Index < 0 Then Return

	Wait For (wmBoseSoundTouch1.KeyPress(Value, True)) Complete (result As Map)
	ReportResult(Value, result, True)
	ChoiceBoxKey.SelectedIndex = -1

End Sub

Private Sub ReportResult(action As String, result As Map, showResult As Boolean)

	AddText("--------------------")
	If result.ContainsKey("error") = False Then
		AddText(action & ": completed")
		If showResult Then AddText(MapToText(result, "=", CRLF))
	Else
		AddText(action & " - error: " & result.Get("error"))
	End If

End Sub

Private Sub MapToText(m As Map, delimBetweenKeyAndValue As String, delimBetweenEntries As String) As String

	Dim sb As StringBuilder
	sb.Initialize
	For Each key As String In m.Keys
		sb.Append(key).Append(delimBetweenKeyAndValue).Append(m.Get(key)).Append(delimBetweenEntries)
	Next
	Return sb.ToString

End Sub

Private Sub AddText(txt As String)

	TextArea1.Text = TextArea1.Text & CRLF & txt

End Sub