B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOSevenSegment.bas
' Brief:    	Display number 0-9999 in 4 digits, LED-Seven-Segment, format.
' Date:			2026-10-29
' Description:	This is a 40px local font that is completely self-contained, 
'				offline-safe, and visually centered.
'				Depends on digital.ttf font located in the assets (files) folder.
'				The digital font size is set in the SVG file sevensegments.svg:
'				<defs>... .digital-led-display {font-size: 40px;...
' Usage:		
'				TileSevenSegment.Value = 1958
' ================================================================

Private Sub Class_Globals
	Private xui As XUI
	
	' Font file located in the files folder (ensure to add to the Files
	Private FONT_FILE As String = "digital.ttf"

	' XML markup font base64 placeholder
	Private FONT_BASE64_PLACEHOLDER As String = "#FONT_BASE64_PLACEHOLDER#"
	
	' Error conditions
	Private ERR_TEXT 		As String = "Err"

	' Min and max values to display
	Private MAX_DIGITS		As Int = 5
	Private MIN_VALUE 		As Int = -99999
	Private MAX_VALUE 		As Int = 99999

	' Mandatory class globals	
	Private mState			As Boolean
	Private mValue			As String
	Private mParentPanel 	As B4XView		'ignore Local panel holding the webview
	Private mWebView		As WebView		'ignore Local WebView reference handle container
	Private mEventName 		As String
	Private mCallBack 		As Object
	Private mParentTile 	As HMITilesIO

	' Private class globals
	Private mTextColor 		As String
	Private mContainerColor As String
End Sub

' Initializes the instance
Public Sub Initialize(parent As HMITilesIO, pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
	mParentTile = parent
	mTextColor = HMITilesIOUtils.COLOR_NORMAL_STATE
End Sub

' GetParent
' Get the parent tile HMITilesIO to access public methods & fields.
Public Sub GetParent As HMITilesIO
	Return mParentTile
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
	
	mValue = Value
	
	Dim textcolor As String = mTextColor
	
	' Validate range limits
	If IsNumber(Value) Then
		Dim numValue As Double = Value.As(Double)

		' Double check min and max range limits safely
		If MinValue < MIN_VALUE Then MinValue = MIN_VALUE
		If MaxValue > MAX_VALUE Then MaxValue = MAX_VALUE
    
		' Validate value against min and max thresholds
		If numValue < MinValue Or numValue > MaxValue Then
			Value = ERR_TEXT
			textcolor = HMITilesIOUtils.COLOR_ERROR_STATE
		Else
			' Automatically calculate the required display digits based on MaxValue limits
			Dim NumberOfDigits As Int = MAX_DIGITS
			If MaxValue < 10 Then
				NumberOfDigits = 1
			Else If MaxValue < 100 Then
				NumberOfDigits = 2
			Else If MaxValue < 1000 Then
				NumberOfDigits = 3
			Else If MaxValue < 10000 Then
				NumberOfDigits = 4
			End If

			' Isolate decimal fractions exactly like your original logic
			Dim dotIndex As Int = Value.IndexOf(".")
			Dim baseDigits As String = Value
			Dim decimalPart As String = ""

			If dotIndex > -1 Then
				baseDigits = Value.SubString2(0, dotIndex)
				decimalPart = Value.SubString(dotIndex)
			End If

			' Pad leading zeros using a single-line calculation.
			' This replicates original padding precisely but completely eliminates the thread-freezing 'Do While' loop.
			Dim requiredZeros As Int = Max(0, NumberOfDigits - baseDigits.Length)
			Dim padding As String = "00000000".SubString2(0, requiredZeros) ' Pulls exact number of required zeros
            
			Value = padding & baseDigits & decimalPart
		End If	
	End If
    
	' 3. Group all standard text content mappings
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer, _
		"tile-value":  Value _
	)
	
	' 4. Map presentation attributes and high-contrast glow filters safely
	Dim attrUpdates As Map = CreateMap( _
		"tile-value": CreateMap( _
			"fill": textcolor, _
			"style": "filter: drop-shadow(0px 0px 2px " & textcolor & ");" _
		) _
	)
	
	' 5. Bundle everything up and push to your central utility engine
	Dim updatePayload As Map = CreateMap( _
		"text": textUpdates, _
		"attrs": attrUpdates _
	)
	
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
End Sub

Public Sub setTextColor(value As String)
	mTextColor = value
End Sub
Public Sub getTextColor As String
	Return mTextColor
End Sub

' Set or get the inner value container bezel fill color dynamically at runtime.
' Parameter:
'	value - Target fill color as HEX string with # prefix, like #05131a
Public Sub setContainerColor(value As String)
	mContainerColor = value
	' <rect id="tile-value-container" x="10" y="38" width="100" height="46" rx="4" fill="#090d16" stroke="#1e293b" stroke-width="1" />
	' 1. Formulate the precise target element property layout change
	Dim elementProperties As Map = CreateMap("fill": value, "stroke": value)
	
	' 2. CRITICAL FIX: Nest your target map configuration cleanly inside
	' an explicit "attrs" parent payload folder matching your central engine schema layout!
	Dim attrUpdates As Map = CreateMap("tile-value-container": elementProperties)
	Dim updatePayload As Map = CreateMap("attrs": attrUpdates)
	
	' 3. Transmit securely down your unified JSON channel line
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
End Sub

Public Sub getContainerColor As String
	Return mContainerColor
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
