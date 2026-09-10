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

	' Touch events tile
	Public ACTION_DOWN			As Int = 0
	Public ACTION_UP 			As Int = 1
	Public ACTION_MOVE 			As Int = 2

	' SVG display styles for rect used in f.e. IOPanel
	Public DISPLAY_STYLE_BLOCK	As String = "block"
	Public DISPLAY_STYLE_NONE 	As String = "none"


End Sub

' ================================================================
' JAVASCRIPT
' ================================================================

' ExecuteJS
' Helper to execute a JavaScript string inside the B4AB4J WebView engine using JavaObject
' Parameter:
'	wv - WebView in which the script is executed
'	js - JavaScript code
Public Sub ExecuteJS(wv As WebView, js As String) As ResumableSub
	' Check js length and do nothing if empty
	If js.Length == 0 Then
		Return False
	End If

	' Standard flattening to safeguard single-line delivery execution
	js = js.Replace(CRLF, " ").Replace(Chr(10), " ").Replace(Chr(13), " ")
	' Log($"[Utils.ExecuteJS] ${js}"$)

	' Short sleep
	Sleep(1)

	' Initialize a JavaObject pointing directly to the WebView instance wrapper
	Dim joWebView As JavaObject = wv

	' Try executing the JavaScript
	Try
		#if B4A
		' Define a null callback object since we are pushing data outwards (Fire-and-forget)
		Dim callback As Object = Null
		' Invoke the native android.webkit.WebView.evaluateJavascript method
		joWebView.RunMethod("evaluateJavascript", Array(js, callback))
		#End If

		#If B4J
		Dim engine As JavaObject = joWebView.RunMethodJO("getEngine", Null)
		engine.RunMethod("executeScript", Array(js))
		#End If

		Return True
	Catch
		Log("[Utils.ExecuteJS][E] " & LastException.Message)
		Return False
	End Try
End Sub

' ================================================================
' BITS and BYTESW HELPERS
' ================================================================

' GetBitArray
' Create an array with 8 booleans from a byte.
' Parameter:
'	b -Byte
' Returns:
'	Boolean Array
Public Sub GetBitArray(b As Byte) As Boolean()	'ignore
	Dim result(8) As Boolean
	For i = 0 To 7
		result(i) = GetBit(b, i)
	Next
	Return result
End Sub

Public Sub SetBit(b As Byte, index As Int, value As Boolean) As Byte	'ignore
	If value Then
		Return Bit.Or(b, Bit.ShiftLeft(1, index))
	Else
		Return Bit.And(b, Bit.Not(Bit.ShiftLeft(1, index)))
	End If
End Sub

Public Sub GetBit(b As Byte, bitpos As Int) As Boolean	'ignore
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
'	b - Byte
' Returns:
'	String - Binary string with 8 entries 0 or 1.
' Example: 
'	Byte 103 > String 01100111
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
Public Sub GetStateColor(State As Int) As String	'ignore
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
