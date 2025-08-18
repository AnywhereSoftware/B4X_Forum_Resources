### CheckWin11 by aeric
### 05/05/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/139831/)

Just a simple trick I use to detect Windows 11 using Shell. This Sub returns True if the version is larger or equals to 22000.493  
There is a [**known bug in JDK**](https://bugs.openjdk.java.net/browse/JDK-8274840) to detect Windows 11 version.  
  

```B4X
Public Sub CheckWin11 As ResumableSub  
    Try  
        Dim shl As Shell  
        shl.Initialize("shl", "cmd", Array As String("/C", "ver"))  
        shl.Run(3000) 'set a timeout of 3 seconds  
        Wait For (shl) shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
        If Success And ExitCode = 0 Then  
            'Log(StdOut) ' Microsoft Windows [Version 10.0.22000.652]  
            Dim out As String = StdOut.Trim  
            If out.Contains("Microsoft Windows") And out.Contains("10.0.") Then  
                out = out.SubString2(out.IndexOf("10.0.") + 5, out.Length - 1)  
                Dim version As Double = out  
                Return version >= 22000.493  
            End If  
        Else  
            Log("Error: " & StdErr)  
        End If  
    Catch  
        Log(LastException)  
    End Try  
    Return False  
End Sub
```

  
  
Usage:  
Here is a sample how I use in my application.  

```B4X
Sub ShowOS  
    LblPOSName.Text = Main.PRODUCT_NAME & " running on " & OSName  
    If OSName = "Windows 10" Then  
        Wait For (CheckWin11) Complete (Result As Boolean)  
        If Result Then  
            LblPOSName.Text = Main.PRODUCT_NAME & " running on Windows 11"  
        End If  
    End If  
End Sub  
  
Sub OSName As String  
    Return GetSystemProperty("os.name", "")  
End Sub
```

  
  
Edit: Code updated