$f = @ScriptDir & "..\..\..\Files\myfile.fxml"

if $cmdline[0] > 0 then $f = $cmdline[1]

$hwnd = FileOpen($f, 0)
$s = FileRead($hwnd)
FileClose($hwnd)

Local $sID = StringRegExp($s, '(\w+)\s+id="([^"]+)"', 3) ; Extracting ID using regex

If IsArray($sID) Then

    ConsoleWrite("Extracted IDs: ")
    Local $result = ""
	local $index = 0
    For $i = 0 To UBound($sID) - 1
		if Mod($index, 2) = 0 then
			If $result <> "" then $result &= @CRLF
			$result &= "Private " & $sID[$i + 1] & " As " & $sID[$i] ; Append each ID to the result string
		EndIf
		$index +=1
    Next
    ConsoleWrite(@CRLF)
    ConsoleWrite("Result String: " & $result & @CRLF)

	ClipPut($result)

	if ClipGet() = $result Then
		MsgBox(1, "B4J", "Variables copied to clipboard", 1)
	Else
		MsgBox(1, "B4J", "Copy didn't work", 1)
	EndIf

Else
    ConsoleWrite("ID not found!" & @CRLF)
EndIf





