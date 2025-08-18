[B]xInstrumentationStateIndicator[/B] is an open source B4X Library.
The xInstrumentationStateIndicator (Custom View) purpose is to display a device state or to set a device state via touch or mouse click.
A device could be basically anything which can have a state true or false.

[ATTACH type="full" alt="1636912207831.png"]121680[/ATTACH]
See code example below.

[B]Features[/B]
[LIST]
[*]Define one or more indicators - one for each devices state.
[*]Show device state (set by code only, not touchable).
[*]Set device state (set by code or touchable).
[*]Set device state blinking to indicate for example error/warning (set by code).
[*]Indicators are displayed in a single row (horizontal mode) or single columns (vertical mode).
[*]Indicator size (radius) can be fixed or variable (calculated depending instrument size, might need to experiment with the panels size for proper fit).
[*]Text color & size set by the customview label property.
[*]Many instrument and indicator properties can be set either in the visual designer or via methods (code).
[*]Indicator ID's set by the custom view and can not be changed. The first indicator has ID = 0, the last ID = number of indicators - 1.
[*]Hint: Use as "Display Only" by setting the custom view common property Enabled to false.
[*]Hint: Use an indicator as a simple switch with one or two indicators.
[*]Written in B4X, source code included in the b4xlib file (zip format).
[/LIST]
[B]Attached[/B]
The [B]xInstrumentationStateIndicator-NNN.zip[/B](NNN version number) archive contains
[LIST]
[*]B4X library xInstrumentationStateIndicator.b4xlib.
[*]B4XPages sample project for B4A (tested with v11.0) & B4J (tested with v9.30).
[*]NOTE: The B4i code is not developed.
[/LIST]

[B]Install[/B]
Copy the b4xlib file to the respective B4X additional libraries folder.

[B]Methods[/B]
See the B4XPages sample below or lookup the source source.

[B]B4XPages Sample B4XMainPage.bas[/B]
The Pumpstation is an example to handle device states including error.
[CODE=b4x]
Sub Class_Globals
    Private Root As B4XView
    Private xui As XUI
    Private xStateIndicator1 As xInstrumentationStateIndicator
    Private btnChangeState As B4XView
    Private isiPumpStation As xInstrumentationStateIndicator
    Private lblPumpStationMsg As B4XView
End Sub

Public Sub Initialize
    B4XPages.GetManager.LogEvents = True
End Sub

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
    Log($"PumpStation State Indicator monitors ${isiPumpStation.IndicatorList.Size} pumps."$)
End Sub

'xStateIndicator1: Handle touch / click state changes. Change state from true to false v.v.
Private Sub xStateIndicator1_TouchStateChanged(id As Int)
    xStateIndicator1.SetIndicatorState(id, Not(xStateIndicator1.GetIndicatorState(id)))
    Log($"xStateIndicator1_TouchStateChanged: ${id}, Changed state to ${xStateIndicator1.GetIndicatorState(id)}"$)
    'Action depending indicator ID
End Sub

'xStateIndicator1: Button to change indicator 1 touchability
Private Sub btnChangeState_Click
    Dim id As Int = 0
    xStateIndicator1.SetIndicatorTouchable(id, Not(xStateIndicator1.GetIndicatorTouchable(id)))
    btnChangeState.Text = $"Indicator1 Touchable=${xStateIndicator1.GetIndicatorTouchable(id)}"$
    Log($"btnChangeState_Click: Indicator=${id}${CRLF}touchable=${xStateIndicator1.GetIndicatorTouchable(id)}"$)
End Sub

'PumpStation: Handle touch / click state changes. Touch changes the state which can taken action upon.
Private Sub isiPumpStation_TouchStateChanged(id As Int)
    'Change the indicator state, log and set msg followed by pump actions
    isiPumpStation.SetIndicatorState(id, Not(isiPumpStation.GetIndicatorState(id)))
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
    Log($"PumpStation_StateChanged: id=${id} (${isiPumpStation.GetIndicatorName(id)}), Changed to ${state}"$)
End Sub
[/CODE]

[B]Licence[/B]
GNU General Public License v3.0.
Developed for personal use only.

[B]ToDo[/B]
See file TODO.md.

[B]Last Change[/B]
v1.20 (20211204) - Packed as B4XLib.
See file CHANGELOG.md.
