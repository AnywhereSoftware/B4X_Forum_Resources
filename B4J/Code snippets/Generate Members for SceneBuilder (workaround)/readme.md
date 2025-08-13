### Generate Members for SceneBuilder (workaround) by jmon
### 09/17/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/157992/)

Hi,  
  
This is a workaround to kind of restore the old **"Generate Members"** behavior, for UI generated with **JavaFX Scene Builder**. I understand that using Scene Builder is not recommended anymore, but this will be useful for people like me who are still supporting programs created using SB.  
  
I created an AUTOIT script that help with that. Attached to this post are the original AutoIt Script, and the compiled exe file.  

1. Download the attached Script.zip, extract "GenerateMembersFXML.exe"
2. Copy "GenerateMembersFXML.exe" somewhere, in my case I put it in AdditionalLibraries.
3. in B4J IDE, ****right click on a fxml file**** and select **"Configure External Editors"**:

1. ![](https://www.b4x.com/android/forum/attachments/148667)

4. Paste the full path to "GenerateMembersFXML.exe", then press "Ok"

1. ![](https://www.b4x.com/android/forum/attachments/148668)

5. Now right click on the fxml again, select **"Open with GenerateMembersFXML"**. This will copy the variables to your **ClipBoard**

1. ![](https://www.b4x.com/android/forum/attachments/148669)

6. Paste the Variables to B4J (CTRL+V):

1. ![](https://www.b4x.com/android/forum/attachments/148670)

  
Note that it's not a complete replacement to the old behavior, but it's enough to save time.  
  
The compiled script shared here is free of virus, but you can compile it by yourself using AutoIt if you like. Here is the script below. The source code is also included in the .zip file:  

```B4X
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
```