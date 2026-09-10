B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOSevenSegment.bas
' Brief:    	Display number 0-9999 in 4 digits, LED-Seven-Segment, format.
' Date:			2026-09-06
' Description:	This is a 40px local font that is completely self-contained, 
'				offline-safe, and visually centered.
'				Depends on digital.ttf font located in the assets (files) folder.
'				The digital font size is set in the SVG file sevensegments.svg:
'				<defs>... .digital-led-display {font-size: 40px;...
' Usage:		
'				TileSevenSegment.Value = 1958
' ================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI
	
	' Font file located in the files folder (ensure to add to the Files
	Private FONT_FILE 	As String = "digital.ttf"

	' XML markup font base64 placeholder
	Private FONT_BASE64_PLACEHOLDER As String = "#FONT_BASE64_PLACEHOLDER#"

	' Instance-specific configuration variables (completely isolated for each tile)
	Public TEXT_COLOR 	As String = "#cbd5e1"
	Public TEXT_SIZE 	As Int = 24

	' Error conditions
	Private ERR_TEXT 	As String = "Err"
	Private ERR_COLOR	As String = "#ef4444" ' Alarm Red for active faults

	' Min and max values to display - 4 digits
	Private MIN_VALUE 	As Int = 0
	Private MAX_VALUE 	As Int = 9999
	
	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object
End Sub

' Initializes the instance
Public Sub Initialize(pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
End Sub

' LoadTemplate
' Loads your local asset font file, base64 encodes it, and prepares the target SVG content string
Public Sub LoadTemplate(template As String) As String
	' Load the raw binary bytes from your B4X project asset directory folder
	Dim fontBytes() As Byte = Bit.InputStreamToBytes(File.OpenInput(File.DirAssets, FONT_FILE))
    
	' Convert the byte array into a standard clean web base64 string
	Dim su As StringUtils
	Dim base64String As String = su.EncodeBase64(fontBytes)
    
	' Read your base raw SVG code file template string out from your library container layout
	Dim rawSvgCode As String = template
    
	' Inject the compiled base64 data directly into your styling headers tag placeholder
	Dim finalizedSvgContent As String = rawSvgCode.Replace(FONT_BASE64_PLACEHOLDER, base64String)
    
	Return finalizedSvgContent
End Sub

' SetTile
' Set all tile properties.
' Parameter:
'	Header - String set text at tile top
'	Footer - String set text at tile bottom
' 	TextColor - String HTML HEX format for the digital numbers
' 	Value - Float current value or String in case error or just short text
Public Sub SetTile(Header As String, _
				   Footer As String, _
				   MinValue As Float, _
				   MaxValue As Float, _
				   Value As String)
	
	Dim textcolor As String = TEXT_COLOR
	
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
	
	' Validate range limits.
	' Switch color to alarm red if out of bounds.
	If IsNumber(Value) Then
		' Cast value
		Dim numValue As Double = Value

		' Double check min and max range limits safely
		If MinValue < MIN_VALUE Then MinValue = MIN_VALUE
		If MaxValue > MAX_VALUE Then MaxValue = MAX_VALUE
    
		' Validate value against min and max
		If numValue < MinValue Or numValue > MaxValue Then
			Value = ERR_TEXT
			textcolor = ERR_COLOR
		Else
			Dim NumberOfDigits As Byte = 4
			' Automatically calculate the required display digits based on MaxValue limits
			If MaxValue < 10 Then
				NumberOfDigits = 1
			Else If MaxValue < 100 Then
				NumberOfDigits = 2
			Else If MaxValue < 1000 Then
				NumberOfDigits = 3
			Else
				NumberOfDigits = 4 ' Standard default cap for your 4-digit telemetry array matrix
			End If

			' Value Formatter: Isolate decimal fractions
			Dim dotIndex As Int = Value.IndexOf(".")
			Dim baseDigits As String = Value
			Dim decimalPart As String = ""

			If dotIndex > -1 Then
				baseDigits = Value.SubString2(0, dotIndex)
				decimalPart = Value.SubString(dotIndex)
			End If

			' SAFE FIX: Calculate targeted length dynamically using your variable (e.g., 1 or 4)
			' This prevents the infinite loop if the value is already longer than the target digits
			Dim targetLength As Int = NumberOfDigits
			Dim currentDigitsLength As Int = baseDigits.Length + decimalPart.Replace(".", "").Length

			' Only pad if we are actually under the required length limit
			If currentDigitsLength < targetLength Then
				Do While (baseDigits.Length + decimalPart.Replace(".", "").Length) < targetLength
					baseDigits = "0" & baseDigits
				Loop
			End If

			Value = baseDigits & decimalPart
		End If
	End If
    
	' Compile JavaScript string payload
	Dim js As String = $"
        var head = document.getElementById("tile-header");
        var foot = document.getElementById("tile-footer");
        var txt = document.getElementById("seg-text");
        
        if(head) { head.textContent = "${Header}"; };
        if(foot) { foot.textContent = "${Footer}"; };
        if(txt)  { 
			txt.textContent = "${Value}"; 
			txt.setAttribute("fill", "${textcolor}");
			txt.style.filter = "drop-shadow(0px 0px 2px ${textcolor})";
		};
    "$
	UpdateTile(js)
End Sub

' UpdateTile
' Change the state using JavaScript.
' Parameters:
'	js - JavaScript to update the tile elements.
Private Sub UpdateTile(js As String)
	Wait for (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[SevenSegment.UpdateTile][E] Can not update the tile."$)
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
		' Trigger the event if it exists in the parent module
		If xui.SubExists(mCallBack, mEventName & "_Click", 1) Then
			CallSubDelayed3(mCallBack, mEventName & "_Click", mState, mValue)
		End If
	End If
    
	' Simplify result creation using standard B4X Type initialization shorthand
	Dim result As HMITouchResult
	result.Initialize
	result.State = mState
	result.Value = mValue
	Return result
End Sub
