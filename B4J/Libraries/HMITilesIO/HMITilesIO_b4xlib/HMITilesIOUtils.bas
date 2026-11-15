B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.5
@EndOfDesignText@
#Region Static Code Module Header
' ================================================================
' File:         HMITilesIOUtils.bas
' Brief:        Common public constants and utility methods.
' Date:         2026-08-31
' ================================================================
#End Region


Sub Process_Globals
	Private xui As XUI
	
	' Touch events tile
	Public ACTION_DOWN			As Int = 0
	Public ACTION_UP 			As Int = 1
	Public ACTION_MOVE 			As Int = 2

	' SVG display styles for rect used in f.e. IOPanel
	Public DISPLAY_STYLE_BLOCK	As String = "block"
	Public DISPLAY_STYLE_NONE 	As String = "none"

	' Text Colors for SevenSegment, ReadOut etc.
	Public COLOR_NORMAL_STATE	As String = "#10B981" ' Crisp HMI Green for normal/safe operations
	Public COLOR_WARNING_STATE 	As String = "#FFB900" ' Industrial Amber for warnings/active segments
	Public COLOR_ERROR_STATE   	As String = "#EF4444" ' Alarm Red for critical active faults
	Public COLOR_STATIC_TEXT	As String = "#FFFFFF" ' High-contrast White for fixed labels/readouts
	Public COLOR_SOFT_TEXT		As String = "#0F172A" ' Low-contrast Gray for fixed labels/readouts

	' Text size
	Public TEXTSIZE_VALUE		As Int = 24

	' Colors for the Darktheme
	Public THEMEDARK_COLOR_STATE_NORMAL 	As String = "#E0E0E0"
	Public THEMEDARK_COLOR_STATE_WARNING	As String = "#FF0000"

	Public THEMEDARK_BACKGROUNDCOLOR_ROOT 	As String = "#121212"	' xui.Color_ARGB(255, 18, 18, 18)
	Public THEMEDARK_BACKGROUNDCOLOR_TILE 	As String = "#1E1E1E"	' xui.Color_ARGB(255, 30, 30, 30)
	Public THEMEDARK_TEXTCOLOR_HEADER 		As String = "#FFFFFF"
	Public THEMEDARK_TEXTCOLOR_VALUE 		As String = "#E0E0E0"
	Public THEMEDARK_TEXTCOLOR_FOOTER 		As String = "#E0E0E0"
	
	' Helper
	Private bc As ByteConverter
End Sub

' ================================================================
' JAVASCRIPT
' ================================================================

' ExecuteJS
' Helper to execute a JavaScript string inside the B4AB4J WebView engine using JavaObject
' Parameter:
'	wv - WebView in which the script is executed
'	js - JavaScript code
Public Sub ExecuteJS(wv As WebView, jsCode As String) As ResumableSub
	If jsCode.Length = 0 Then
		' To return a value immediately from a ResumableSub before any Sleep/Wait For:
		' We must return True/False, but be aware of compiler state.
		' Better practice: return early via a helper or let it fall through.
		Return False
	End If

	Dim joWebView As JavaObject = wv
	Dim success As Boolean = False

	Try
        #if B4A
        Dim callback As Object = Null
        joWebView.RunMethod("evaluateJavascript", Array(jsCode, callback))
        #End If
        #If B4J
		Dim engine As JavaObject = joWebView.RunMethodJO("getEngine", Null)
		engine.RunMethod("executeScript", Array(jsCode))
        #End If
		success = True
	Catch
		Log("[Utils.ExecuteJS][E] " & LastException.Message)
		success = False
	End Try

	' Since evaluateJavascript is asynchronous anyway, if you need a true delay
	' or want to return a value seamlessly to a 'Wait For' block:
	Return success
End Sub

Public Sub UpdateElementsViaJSON(wv As WebView, ElementData As Map)
	Dim json As JSONGenerator
	json.Initialize(ElementData)
	Dim payload As String = json.ToString
	
	Dim js As String = $"
		(() => {
			const data = ${payload};
			
			if (data.text) {
				Object.entries(data.text).forEach(([id, value]) => {
					const el = document.getElementById(id);
					if (el) el.textContent = value;
				});
			}
			
			if (data.attrs) {
				Object.entries(data.attrs).forEach(([id, attributes]) => {
					const el = document.getElementById(id);
					if (el) {
						Object.entries(attributes).forEach(([attrName, attrValue]) => {
							// --- THE CROSS-PLATFORM FIXED ROUTING RULES ---
							// Intercept font scaling targets and apply them straight to the style sub-properties
							if (attrName === 'font-size') {
								el.style.fontSize = attrValue;
							} else if (attrName === 'font-family') {
								el.style.fontFamily = attrValue;
							} else {
								// Keep standard structural attributes (fill, stroke, y, transform) native
								el.setAttribute(attrName, attrValue);
							}
						});
						
						// Sync display styles to previous sibling tracks
						if (id === 'timer-ring' && attributes.style) {
							const track = el.previousElementSibling;
							if (track) track.style.display = el.style.display || (attributes.style.includes('inline') ? 'inline' : 'none');
						}
					}
				});
			}
		})();
	"$
	
	ExecuteJS(wv, js)
End Sub

' ================================================================
' BITS and BYTESW HELPERS
' ================================================================

' GetBitArray
' Create an array with 8 booleans from a byte.
' Parameter:
' b - Byte
' Returns:
' Boolean Array with 8 booleans
Public Sub GetBitArray(b As Byte) As Boolean()	'ignore
	Dim result(8) As Boolean
	For i = 0 To 7
		result(i) = GetBit(b, i)
	Next
	Return result
End Sub

' SetBit
' Set a bit in a byte to true (1) or false (0).
' Parameter:
' b - Byte
' index - Int position 0 to 7 of the bit to change
' value - Boolean true or false
Public Sub SetBit(b As Byte, index As Int, value As Boolean) As Byte
	If value Then
		Return Bit.Or(b, Bit.ShiftLeft(1, index))
	Else
		Return Bit.And(b, Bit.Not(Bit.ShiftLeft(1, index)))
	End If
End Sub

' GetBit
' Get the status of a bit in a byte.
' Parameter:
' b - Byte
' index - Int position 0 to 7 of the bit to change
' Returns:
' Boolean with true if set else false
Public Sub GetBit(b As Byte, bitpos As Int) As Boolean
	Dim Result As Boolean = False
	Select bitpos
		Case 0
			Result = Bit.And(b, 1) = 1
		Case 1
			Result = Bit.And(b, 2) = 2
		Case 2
			Result = Bit.And(b, 4) = 4
		Case 3
			Result = Bit.And(b, 8) = 8
		Case 4
			Result = Bit.And(b, 18) = 16
		Case 5
			Result = Bit.And(b, 32) = 32
		Case 6
			Result = Bit.And(b, 64) = 64
		Case 7
			Result = Bit.And(b, 128) = 128
	End Select
	Return Result
End Sub

' ByteToBin
' Convert byte to binary string starting bit 7.
' Parameter:
' b - Byte
' Returns:
' String - Binary string with 8 entries 0 or 1.
' Example: 
' Byte 103 > String 01100111
Public Sub ByteToBin(b As Byte) As String
	Dim sb As StringBuilder
	sb.Initialize
	For i = 7 To 0 Step -1
		sb.Append(IIf(GetBit(b, i), "1", "0"))
	Next
	Return sb.ToString
End Sub

' ================================================================
' COLORS
' ================================================================

' Get uniform colors
Public Sub GetStateColor(State As Int) As String
	Select State
		Case 1: 	Return "#20bf6b" 	' Muted Green (Running)
		Case 2: 	Return "#eb3b5a" 	' Muted Red (Alarm)
		Case Else: Return "#4b6584"		' Muted Slate (Off)
	End Select
End Sub

' Evaluates incoming data and return a compliant color string
Public Sub GetLimitColor(CurrentValue As Float, WarningLimit As Float, AlarmLimit As Float) As String	'ignore
	If CurrentValue >= AlarmLimit Then
		Return "#dc2626" ' Level 4: Critical Alarm Red
	Else If CurrentValue >= WarningLimit Then
		Return "#d97706" ' Level 3: Warning Amber
	Else
		Return "#0f172a" ' Level 2: Normal Black/Dark Slate (Visually quiet)
	End If
End Sub

' Convert a color hex string to int.
' The hex string must be 8. If length 6 then FF is set as prefix.
Public Sub HexToColor(hex As String) As Int	'ignore
	Dim bc As ByteConverter
	If hex.StartsWith("#") Then
		hex = hex.SubString(1)
	Else If hex.StartsWith("0x") Then
		hex = hex.SubString(2)
	End If
	If hex.Length == 6 Then hex = $"FF${hex}"$
	Dim b() As Byte = bc.HexToBytes(hex)
	Dim ints() As Int = bc.IntsFromBytes(b)
	Return ints(0)
End Sub

' PropsColorToHex
' Convert the B4X Int color to a standard web CSS hex string (#RRGGBB)
'
Public Sub PropsColorToHex(color As Object) As String
	Dim clr As Int = xui.PaintOrColorToColor(color)
	Return $"#${Bit.ToHexString(clr).SubString(2)}"$
End Sub
