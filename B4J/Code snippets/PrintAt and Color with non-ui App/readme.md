### PrintAt and Color with non-ui App by Knoppi
### 07/17/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171583/)

In a server-side non-UI application, the only output option is "Log".  
It is possible to create colored and positioned output using escape sequences.  
I have tested this with Windows CMD.exe, Windows PowerShell, and the Linux terminal.  
  
![](https://www.b4x.com/android/forum/attachments/172455)  

```B4X
Sub Process_Globals  
    Dim ESC As String = Chr(27)  
     
    Public BLACK As Int = 0  
    Public RED As Int = 1  
    Public GREEN As Int = 2  
    Public YELLOW As Int = 3  
    Public BLUE As Int = 4  
    Public MAGENTA As Int = 5  
    Public CYAN As Int = 6  
    Public WHITE As Int = 7  
  
    Public LIGHTBLACK As Int = 40  
    Public LIGHTRED As Int = 41  
    Public LIGHTGREEN As Int = 42  
    Public LIGHTYELLOW As Int = 43  
    Public LIGHTBLUE As Int = 44  
    Public LIGHTMAGENTA As Int = 45  
    Public LIGHTCYAN As Int = 46  
    Public LIGHTWHITE As Int = 47  
     
    Dim mTextColor As Int = 30  
    Dim mBackColor As Int = 40  
     
    Dim mLightTextColor As Int = 50  
    Dim mLightBackColor As Int = 60  
     
    Dim OneUP As String = $"${ESC}[1A"$  
     
End Sub  
  
Public Sub Clear  
    Log( $"${ESC}[2J"$)  
End Sub  
  
Public Sub Reset  
    Log(  $"${ESC}[0m${OneUP}"$)  
End Sub  
  
Public Sub Color( TextColor As Int, BackColor As Int)  
    Dim TextAdd As Int = 0  
    If (TextColor >= BLACK And TextColor <= WHITE)  Then  
         TextAdd = mTextColor  
    else If (TextColor >= LIGHTBLACK And TextColor <= LIGHTWHITE) Then  
        TextAdd = mLightTextColor  
    Else  
        Return  
    End If  
     
    Dim BackAdd As Int = 0  
    If (BackColor >= BLACK And BackColor <= WHITE)  Then  
        BackAdd = mBackColor  
    else If (BackColor >= LIGHTBLACK And BackColor <= LIGHTWHITE) Then  
        BackAdd = mLightBackColor  
    Else  
        Return  
    End If  
     
    Log( $"${ESC}[${TextColor + TextAdd};${BackColor + BackAdd}m${OneUP}"$)  
End Sub  
  
Public Sub FormatBold  
    Log( $"${ESC}[1m${OneUP}"$)  
End Sub  
  
Public Sub FormatFaint  
    Log( $"${ESC}[2m${OneUP}"$)  
End Sub  
  
Public Sub FormatItalic  
    Log( $"${ESC}[3m${OneUP}"$)  
End Sub  
  
Public Sub FormatUnderline  
    Log( $"${ESC}[4m${OneUP}"$)  
End Sub  
  
Public Sub FormatSlowBlink  
    Log( $"${ESC}[5m${OneUP}"$)  
End Sub  
  
'can be SlowBlink in some Terminals  
Public Sub FormatRapidBlink  
    Log( $"${ESC}[6m${OneUP}"$)  
End Sub  
  
Public Sub FormatInverse  
    Log( $"${ESC}[7m${OneUP}"$)  
End Sub  
  
Public Sub FormatHidden  
    Log( $"${ESC}[8m${OneUP}"$)  
End Sub  
  
Public Sub FormatStrikethrough  
    Log( $"${ESC}[9m${OneUP}"$)  
End Sub  
  
Public Sub CursorUP  
    Log( $"${ESC}[2A"$)    '2 rows  
End Sub  
  
Public Sub CursorHome  
    Log( $"${ESC}[H"$)  
End Sub  
  
  
Public Sub PrintAt( Row As Int, Col As Int, Text As String)  
    Dim toPrint As String = $"${ESC}[${Row};${Col}H${Text}"$  
    Log( toPrint)  
End Sub  
  
Public Sub Print( Text As String)  
    Log( Text)  
End Sub
```

  
  

```B4X
    Terminal.Clear  
    Terminal.Color( Terminal.RED, Terminal.WHITE)  
    Terminal.PrintAt( 5,20," H A L L O ")  
    Terminal.PrintAt( 6,20," H A L L O ")  
    Terminal.Reset  
  
    Terminal.Print( "Default")  
    Terminal.FormatBold  
    Terminal.Print( "FormatBold")  
    Terminal.Reset  
  
    Terminal.FormatUnderline  
    Terminal.Print( "Underline")  
    Terminal.Reset  
  
    Terminal.FormatSlowBlink  
    Terminal.Print( "SlowBLINK")  
    Terminal.Reset  
  
    Terminal.FormatStrikethrough  
    Terminal.Color( Terminal.CYAN, Terminal.BLACK)  
    Terminal.Print( "Strikethrough")  
    '    Terminal.Reset  
  
    Terminal.Color( Terminal.LIGHTBLUE, Terminal.LIGHTBLACK)  
    Terminal.FormatInverse  
    Terminal.Print( "Inverse")  
    Terminal.Reset  
  
    Terminal.FormatRapidBlink  
    Terminal.FormatItalic  
    Terminal.Color( Terminal.YELLOW, Terminal.BLACK)  
    Terminal.PrintAt( 20, 20, "RapidBLINK Italic")  
    Terminal.Reset    
  
    For z=1 To 10  
        Terminal.Color( Rnd( Terminal.BLACK, Terminal.WHITE+1) , Rnd( Terminal.LIGHTBLACK, Terminal.LIGHTWHITE+1))  
        Dim row As Int = 5+z  
        Dim col As Int = 50+z  
        Terminal.PrintAt( row, col, $"PrintAt: ${row},${col}"$ )  
    Next  
    Terminal.Reset  
  
    Terminal.Printat( 25, 0, "END")
```