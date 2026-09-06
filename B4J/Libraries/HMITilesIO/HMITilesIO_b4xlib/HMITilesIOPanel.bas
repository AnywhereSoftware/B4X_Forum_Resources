B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:         HMITilesIOPanel.bas
' Brief:        Independent Input/Output Panel Matrix (4x2 layout).
' Date:         2026-08-30
' Description:  An 8-channel bidirectional control dashboard layout tracking a 
'               binary string state (e.g. "1010"). Automatically scales its physical 
'               density dynamically based on input string lengths, handling up to 8 
'               independent operational switch or status channels seamlessly.
' ================================================================
#End Region

#Region Class Variables
Sub Class_Globals
	Private xui As XUI
	
	' Channel range configurations
	Private Const MIN_CHANNEL_INDEX			As Byte = 0
	Private Const MAX_CHANNEL_INDEX			As Byte = 7
	Private Const TOTAL_CHANNEL_COUNT		As Byte = 8

	' Clean, high-visibility industrial operational states
	Public Const STATE_OFF					As Int = 0      ' Channel active, current layout color = Red
	Public Const STATE_ON					As Int = 1      ' Channel active, current layout color = Green
	Public Const STATE_DISABLED				As Int = 2 		' Channel hidden/inactive, current layout color = Gray
	Public Const STATE_ERROR				As Int = 3		' Error flag fallback in case index is out of bounds

	' Locals
	Private mChannels(TOTAL_CHANNEL_COUNT)	As Int			' Internal state tracking bank array mapping
	' Locals consistent across all tiles
	Private mState							As Boolean		' Holds state
	Private mValue							As String       ' Holds the raw active binary layout string (e.g., "0101")
	Private mParentPanel 					As B4XView		' Local panel holding the webview
	Private mWebView						As WebView		' Local WebView reference handle container
	Private mEventName 						As String 'ignore
	Private mCallBack 						As Object 'ignore
End Sub
#End Region

' Initialize the class with 8 channels state set to disabled
Public Sub Initialize(pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb

	' Default all 8 channels to Disabled (2) until a value string is received
	For i = MIN_CHANNEL_INDEX To MAX_CHANNEL_INDEX
		mChannels(i) = STATE_DISABLED
	Next
	mValue = ""
End Sub

Public Sub setChannels(values() As Int)
	mChannels = values
	For i = MIN_CHANNEL_INDEX To MAX_CHANNEL_INDEX
		SetChannelVisibility(i, IIf(mChannels(i) = 1, True, False))
	Next
End Sub
Public Sub getmChannels As Int()
	Return mChannels
End Sub

' SetTile (Binary String Version)
' Parameter:
'	Header - Tile header text
'	Footer - Tile footer text (If left empty "", displays the binary string directly)
'	Value - Binary content string matching channel states (e.g. "11111111" or "0101")
' Returns:
'	String - JavaScript DOM alteration payload bundle text
Public Sub SetTile(Header As String, Footer As String, Value As String) As String
	mValue = Value
	
	' 1. Parse the incoming string length to automatically configure density layouts
	Dim ActiveCount As Int = mValue.Length
	
	For i = MIN_CHANNEL_INDEX To MAX_CHANNEL_INDEX
		If i < ActiveCount Then
			' Extract individual character ("1" or "0") linearly from left to right
			Dim CharState As String = mValue.CharAt(i)
			If CharState = "1" Then
				mChannels(i) = STATE_ON
			Else
				mChannels(i) = STATE_OFF
			End If
		Else
			' Beyond string length limit: Mark channel as permanently disabled
			mChannels(i) = STATE_DISABLED
		End If
	Next

	' 2. Compile base structural text adjustments
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"
		var head = document.getElementById("tile-header");
		if(head) { head.textContent = "${Header}"; };
	"$)
	
	' 3. Append visual layout color update matrix strings
	sb.Append(UpdateLayout)
	
	' 4. Handle footer display tracking fallback mechanisms smoothly
	Dim DeterminedFooter As String = Footer
	If DeterminedFooter = "" Then DeterminedFooter = mValue
	sb.Append($"
		var foot = document.getElementById("tile-footer");
		if(foot) { foot.textContent = "${DeterminedFooter}"; };
	"$)
	
	Return sb.ToString
End Sub

' Generates layout commands by evaluating the simple channel state integer array directly
Public Sub UpdateLayout As String
	Dim displaystyle As String
	Dim sb As StringBuilder

	sb.Initialize

	For i = MIN_CHANNEL_INDEX To MAX_CHANNEL_INDEX
		Dim UrlFill As String
		Select mChannels(i)
			Case STATE_OFF
				UrlFill = "url(#stateOff)"
				displaystyle = HMITilesIOUtils.DISPLAY_STYLE_BLOCK
			Case STATE_ON
				UrlFill = "url(#stateOn)"
				displaystyle = HMITilesIOUtils.DISPLAY_STYLE_BLOCK
			Case STATE_DISABLED
				UrlFill = "url(#stateDisabled)"
				displaystyle = HMITilesIOUtils.DISPLAY_STYLE_NONE
			Case Else
				UrlFill = "url(#stateDisabled)"
				displaystyle = HMITilesIOUtils.DISPLAY_STYLE_BLOCK
		End Select
		
		sb.Append($"
			var el${i} = document.getElementById("ch${i}"); 
			if(el${i}){
				el${i}.setAttribute("fill", "${UrlFill}");
				el${i}.parentElement.style.display = "${displaystyle}"; 
			};
		"$)
	Next
	
	Return sb.ToString
End Sub

' Direct Setter Method modifying individual operational channels at runtime
Public Sub SetChannelState(channel As Byte, newstate As Int)
	' Check ranges and disabled state configurations
	If channel < MIN_CHANNEL_INDEX Or channel > MAX_CHANNEL_INDEX Then Return
	If mChannels(channel) = STATE_DISABLED Then Return ' Do not alter disabled slots

	If mChannels(channel) <> newstate Then
		mChannels(channel) = newstate
		
		' Rebuild the binary tracking value string dynamically up to active length bounds
		mValue = GetState
							
		' Compile full structural sync update layout string via your rendering engine
		Dim js As String = UpdateLayout
		
		' Sync footer tracker output string text node change synchronously to match visual conversions
		js = js & $"var foot = document.getElementById("tile-footer"); if(foot){foot.textContent = "${mValue}";};"$
					
		' Execute asynchronously using your reliable Wait For architecture utility wrappers
		Wait For (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
		If Not(result) Then
			Log($"[SetChannelState][E] Can not set the channel for tile IOPanel"$)
		End If
	End If
End Sub

' Direct Getter Method returning current state integer values
Public Sub GetChannelState(channel As Byte) As Int
	If channel < MIN_CHANNEL_INDEX Or channel > MAX_CHANNEL_INDEX Then Return STATE_ERROR
	Return mChannels(channel)
End Sub

' GetState
' Get the iopanel full active state composite as a clean packed binary character string
' Returns:
'	String - Binary sequence profile representation like 01010101
Public Sub GetState As String
	Dim state As Int
	Dim sb As StringBuilder
	sb.Initialize
	
	For i = MIN_CHANNEL_INDEX To MAX_CHANNEL_INDEX
		state = mChannels(i)
		If state <> STATE_DISABLED Then
			sb.Append(state)
		End If
	Next
	Return sb.ToString
End Sub

' Sets a custom short alphanumeric descriptor (max 3 characters) for a specific channel box slot layout node.
' Parameter:
'	channelnr - Byte 0-7 tracking indicator index layout mapping
'	text - The shorthand text string to print inside the box (e.g. "PMP", "ERR", "VAL")
Public Sub SetChannelText(channelnr As Byte, text As String)
	' Boundary guard check to prevent layout DOM injection failures
	If channelnr < MIN_CHANNEL_INDEX Or channelnr > MAX_CHANNEL_INDEX Then
		Log("[SetChannelText][E] Invalid channel layout index. Must be 0-7.")
		Return
	End If
	
	' Safety bounds limitation adjustment ensuring string fits inside the visual node boundaries
	Dim CleansedText As String = text
	If CleansedText.Length > 3 Then
		CleansedText = CleansedText.SubString2(0, 3)
	End If
	
	' Generate dynamic JavaScript targeting your specific text ID tags
	Dim js As String = $"
		var txtEl = document.getElementById("ch-txt${channelnr}");
		if (txtEl) { txtEl.textContent = "${CleansedText}"; };
	"$
	
	' Execute layout adjustment change synchronously using JavaScript Wait For architecture
	Wait For (HMITilesIOUtils.ExecuteJS(mWebView, js.Replace(Chr(10), " ").Replace(Chr(13), " "))) complete (result As Boolean)
	If Not(result) Then
		Log($"[SetChannelText][E] Can not set the channel text for tile IOPanel"$)
	End If
End Sub

' SetChannelVisibility
' Set the visibility of a Channel incl text
Public Sub SetChannelVisibility(channelnr As Byte, visible As Boolean)
	' Boundary guard check to prevent layout DOM injection failures
	If channelnr < MIN_CHANNEL_INDEX Or channelnr > MAX_CHANNEL_INDEX Then
		Log("[SetStateVisibility][E] Invalid channel layout index. Must be 0-7.")
		Return
	End If
	
	' Determine display property value based on visibility flag
	Dim displayStyle As String = "block"
	If Not(visible) Then displayStyle = "none"
	
	' Targets the rect, then jumps up to the parent <g> group to hide everything inside
	Dim js As String = $"
		var rectEl = document.getElementById("ch${channelnr}");
		if (rectEl) { 
			rectEl.parentElement.style.display = "${displayStyle}"; 
		};
	"$
	
	' Execute layout adjustment change synchronously using JavaScript Wait For architecture
	Wait For (HMITilesIOUtils.ExecuteJS(mWebView, js.Replace(Chr(10), " ").Replace(Chr(13), " "))) complete (result As Boolean)
	If Not(result) Then
		Log($"[SetStateVisibility][E] Can not alter visibility for tile IOPanel"$)
	End If
End Sub


' ProcessTouchHandler
' Process the tile touch event.
' Parameter:
'	Data - Type with all touch properties
Public Sub ProcessTouchHandler(Data As HMITouchData) As HMITouchResult
	' Update internal class state
	mState = Data.State
	mValue = Data.Value

	' Only trigger interactions on the initial touch down event
	If Data.Action = HMITilesIOUtils.ACTION_DOWN Then
		' Natively extract the concrete layout canvas constraints without parameter passing
		Dim PanelWidth As Float = mParentPanel.Width
		Dim PanelHeight As Float = mParentPanel.Height
	
		' Translate physical screen pixels into your 120-unit SVG matrix grid space
		Dim svgTouchX As Float = (Data.X / PanelWidth) * 120
		Dim svgTouchY As Float = (Data.Y / PanelHeight) * 120
	
		' Track which independent visual block channel index was touched (0 to 7)
		Dim SelectedChannel As Int = -1
	
		' Coordinate tracking detection (Exact matching layout bounding boundaries)
		If svgTouchY >= 32 And svgTouchY <= 57 Then
			If svgTouchX >= 12 And svgTouchX <= 32 Then SelectedChannel = 0
			If svgTouchX >= 38 And svgTouchX <= 58 Then SelectedChannel = 1
			If svgTouchX >= 64 And svgTouchX <= 84 Then SelectedChannel = 2
			If svgTouchX >= 90 And svgTouchX <= 110 Then SelectedChannel = 3
		Else If svgTouchY >= 64 And svgTouchY <= 89 Then
			If svgTouchX >= 12 And svgTouchX <= 32 Then SelectedChannel = 4
			If svgTouchX >= 38 And svgTouchX <= 58 Then SelectedChannel = 5
			If svgTouchX >= 64 And svgTouchX <= 84 Then SelectedChannel = 6
			If svgTouchX >= 90 And svgTouchX <= 110 Then SelectedChannel = 7
		End If
	
		' Process interaction if a valid block area was tapped
		If SelectedChannel >= 0 Then
			' Log($"[IOPanel.Touch] selectedchannel=${SelectedChannel} state=${GetChannelState(SelectedChannel)}"$)
		
			' CLEAN GUARD CHECK: If disabled, ignore touch entirely!
			If GetChannelState(SelectedChannel) <> STATE_DISABLED Then

				' Get the current clean state code
				Dim CurrentState As Int = GetChannelState(SelectedChannel)
				Dim NewState As Int = STATE_OFF
		
				' TOGGLE LOGIC: Cleanly flip between active states 0 and 1
				NewState = IIf(CurrentState = STATE_OFF, STATE_ON, STATE_OFF)
		
				' Apply the update directly to the class array via your setter method
				' (This handles string recompilation and asynchronous UI painting safely)
				SetChannelState(SelectedChannel, NewState)

				' Update locals
				mState = IIf(NewState = STATE_ON, True, False)
				mValue = GetState
		
				' Bubble up single-parameter callback execution data structure safely using local references
				If xui.SubExists(mCallBack, mEventName & "_Click", 1) Then
					CallSubDelayed3(mCallBack, mEventName & "_Click", mState, SelectedChannel.As(String))
				End If
			End If
		End If
		
	End If
    
	' Simplify result creation using standard B4X Type initialization shorthand
	Dim result As HMITouchResult
	result.Initialize
	result.State = mState
	result.Value = mValue
	' Log($"[IOPanel.Touch] currentstate=${CurrentState} newstate=${result.State} mvalue=${result.Value}"$)
	Return result
End Sub

