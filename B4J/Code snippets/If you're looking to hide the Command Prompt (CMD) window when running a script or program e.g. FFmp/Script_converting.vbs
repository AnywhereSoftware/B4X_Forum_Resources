option explicit
If WScript.Arguments.Count = 0 Then
   Wscript.Echo "Copyright (C) 2025 SecutekMedia Free Software"
   Wscript.Echo "Usage: Script_converting.vbs with parameters."
   WScript.Quit
Else
   CreateObject("Wscript.Shell").Run WScript.Arguments(0) & "\Script_converting.cmd " & WScript.Arguments(1) & " " & WScript.Arguments(2) & " " & WScript.Arguments(3), 0, False
End If



