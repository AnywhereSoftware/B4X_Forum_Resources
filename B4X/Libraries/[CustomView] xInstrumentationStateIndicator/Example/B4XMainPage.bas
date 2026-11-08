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
'See list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	'
	Private xStateIndicator1 As xInstrumentationStateIndicator
	'PumpStation
	Private isiPumpStation As xInstrumentationStateIndicator
	Private lblPumpStationMsg As B4XView
	'
	Private btnChangeState As B4XView
	Private isiCompressor As xInstrumentationStateIndicator
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = False	'True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "B4X CV xInstrumentationStateIndicator")
	CallSubDelayed(Me, "SetProperties")
End Sub

Private Sub SetProperties
	xStateIndicator1.Title = "Indicators"
	xStateIndicator1.Touchable = True
	xStateIndicator1.SetIndicatorColorTrue(0, xui.color_blue)
	xStateIndicator1.SetIndicatorStrokeColor(2, xui.Color_Transparent)
	xStateIndicator1.SetIndicatorState(0, True)
	btnChangeState_Click
	
	'PumpStation: Set some pump states - pump 3 (index 2) is blinking = error state
	isiPumpStation.SetAllIndicatorsState(False)
	isiPumpStation.SetIndicatorState(1, True)
	isiPumpStation.SetIndicatorBlinking(2, True)
	isiPumpStation.SetIndicatorVisible(3, True)
	Log($"PumpStation State Indicator monitors ${isiPumpStation.IndicatorList.Size} pumps."$)

	'Compressor: Has a single indicator with index 0
	isiCompressor.Title = "Compressor"
	isiCompressor.SetBorderColor(xui.Color_Blue)
	isiCompressor.SetIndicatorSize(0, 20)		'Ensure to set the designer property to 0 first else designer property size is used
	isiCompressor.SetIndicatorName(0, IIf(isiCompressor.SetIndicatorStateReverse(0), $"running"$, $"stopped"$))
	isiCompressor.FontSize = 10
	isiCompressor.FontColor = xui.Color_Blue
	isiCompressor.BackgroundColor = xui.Color_White
End Sub

'xStateIndicator1: Handle touch / click state changes. Change state from true to false v.v.
Private Sub xStateIndicator1_TouchStateChanged(id As Int)
	xStateIndicator1.SetIndicatorState(id, Not(xStateIndicator1.GetIndicatorState(id)))
	Log($"xStateIndicator1_TouchStateChanged: ${id}, Changed state to ${xStateIndicator1.GetIndicatorState(id)}"$)
	'Action depending indicator ID
End Sub

'xStateIndicator1: Button to change indicator 1 touchability
Private Sub btnChangeState_Click
	' Test Touchable True Or False
	Dim id As Int = 0
	xStateIndicator1.SetIndicatorTouchable(id, Not(xStateIndicator1.GetIndicatorTouchable(id)))
	btnChangeState.Text = $"Indicator1 Touchable=${xStateIndicator1.GetIndicatorTouchable(id)}"$
	Log($"btnChangeState_Click: Indicator=${id}${CRLF}touchable=${xStateIndicator1.GetIndicatorTouchable(id)}"$)
End Sub

'
'PUMPSTATION
'

'PumpStation: Handle touch / click state changes. Touch changes the state which can taken action upon.
Private Sub isiPumpStation_TouchStateChanged(id As Int)
	'Change the indicator state, log and set msg followed by pump actions
	isiPumpStation.SetIndicatorState(id, Not(isiPumpStation.GetIndicatorState(id)))
	Log($"PumpStation_TouchStateChanged: ${id}, Changed to ${isiPumpStation.GetIndicatorState(id)}"$)
	lblPumpStationMsg.Text = $"${isiPumpStation.GetIndicatorName(id)} turned ${IIf(isiPumpStation.GetIndicatorState(id), "ON", "OFF")}"$

	'Action depending indicator ID
	'Pump 1 (id 0) has changed.
	If id == 0 Then
		lblPumpStationMsg.Text = $"${lblPumpStationMsg.Text}${CRLF}${IIf(isiPumpStation.GetIndicatorState(id) == True, $"ACTION:${CRLF}Check oil level."$, "")}"$
	End If
	'Pump 2 (id 1) has changed.
	If id == 1 Then
		'No action
	End If
	'Pump 3 (id 2) has an error and is blinking. Action: Reset state and stop blinking.
	If id == 2 Then
		'Check if blinking
		If isiPumpStation.GetIndicatorBlinking(id) Then
			lblPumpStationMsg.Text = $"${isiPumpStation.GetIndicatorName(id)} has an error.${CRLF}Pump is turned off.${CRLF}ACTION:${CRLF}Check pump."$
			isiPumpStation.SetIndicatorState(id, False)
			isiPumpStation.SetIndicatorBlinking(id, False)
		Else
			isiPumpStation.SetIndicatorBlinking(id, True)
			lblPumpStationMsg.Text = $"${lblPumpStationMsg.Text}${CRLF}Pump has an error.${CRLF}ACTION:${CRLF}Turn pump OFF."$
		End If
	End If
End Sub

'PumpStation: Handle indicator state changes. 
Private Sub isiPumpStation_StateChanged(id As Int, state As Boolean)
	Log($"PumpStation_StateChanged: id=${id} (${isiPumpStation.GetIndicatorName(id)}), State changed to ${state}"$)
End Sub

Private Sub isiCompressor_TouchStateChanged(id As Int)
	isiCompressor.SetIndicatorName(id, IIf(isiCompressor.SetIndicatorStateReverse(0), $"running"$, $"stopped"$))
	Log($"Compressor_TouchStateChanged: id=${id} (${isiCompressor.GetIndicatorName(id).Replace(CRLF,"")}), State changed to ${isiCompressor.GetIndicatorState(id)}"$)
End Sub
