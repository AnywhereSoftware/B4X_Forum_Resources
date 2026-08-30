B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.5
@EndOfDesignText@
'Static code module
Sub Process_Globals
	' LOcals
	
	' Font file located in the files folder (ensure to add to the Files
	Private FONT_FILE As String = "digital.ttf"
	' XML markup font base64 placeholder
	Private FONT_BASE64_PLACEHOLDER As String = "#FONT_BASE64_PLACEHOLDER#"
	' Min and max values to display
	Private MIN_VALUE As Int = 0
	Private MAX_VALUE As Int = 9999

	Public TEXT_COLOR As String = "#cbd5e1"
	
End Sub

' LoadTemplate
' Loads your local asset font file, base64 encodes it, and prepares the target SVG content string
Public Sub LoadTemplate(template As String) As String
	' 1. Load the raw binary bytes from your B4X project asset directory folder
	Dim fontBytes() As Byte = Bit.InputStreamToBytes(File.OpenInput(File.DirAssets, FONT_FILE))
    
	' 2. Convert the byte array into a standard clean web base64 string
	Dim su As StringUtils
	Dim base64String As String = su.EncodeBase64(fontBytes)
    
	' 3. Read your base raw SVG code file template string out from your library container layout
	Dim rawSvgCode As String = template
    
	' 4. Inject the compiled base64 data directly into your styling headers tag placeholder
	Dim finalizedSvgContent As String = rawSvgCode.Replace(FONT_BASE64_PLACEHOLDER, base64String)
    
	Return finalizedSvgContent
End Sub

' SetTile
' Set all tile properties.
Public Sub SetTile(Header As String, _
				   Footer As String, _
				   ColorHex As String, _
				   Value As String) As String
	
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
	
	' Validate range limits. Switch color to alarm red if out of bounds.
	If IsNumber(Value) Then
		Dim numValue As Double = Value
		If numValue < MIN_VALUE Or numValue > MAX_VALUE Then
			Value = "Err"
			ColorHex = "#ef4444" ' ISA-101 Alarm Red for active faults
		Else
			' Value Formatter: Isolate decimal fractions to ensure clean leading zero placement
			Dim dotIndex As Int = Value.IndexOf(".")
			Dim baseDigits As String = Value
			Dim decimalPart As String = ""
	
			If dotIndex > -1 Then
				baseDigits = Value.SubString2(0, dotIndex)
				decimalPart = Value.SubString(dotIndex)
			End If
	
			' Standardize padding using zeros instead of whitespace characters
			Do While (baseDigits.Length + decimalPart.Replace(".", "").Length) < 4
				baseDigits = "0" & baseDigits
			Loop
	
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
			txt.setAttribute("fill", "${ColorHex}");
			txt.style.filter = "drop-shadow(0px 0px 2px ${ColorHex})";
		};
    "$
	Return js
End Sub
