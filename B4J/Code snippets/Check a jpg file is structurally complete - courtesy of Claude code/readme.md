### Check a jpg file is structurally complete - courtesy of Claude code by JackKirk
### 08/07/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171738/)

```B4X
'************************************************************************************  
'  
'This procedure checks a jpg file is structurally complete - courtesy of Claude code  
'  
'Input parameters are:  
'  
'       Directory = directory holding jpg file  
'       Filename = name of jpg file  
'  
'Returns:  
'  
'       True if jpg opens with a SOI marker (FFD8) and closes with an EOI marker  
'       (FFD9), False otherwise  
'  
'Notes on this procedure:  
'  
'       o Only 2 bytes are read from head of file and 2 from tail - RandomAccessFile  
'         seeks straight to a supplied position, so cost does not grow with file  
'         size (jRandomAccessFile must be available to project)  
'  
'       o Bytes are masked with 0xFF because B4X bytes are signed  
'  
'************************************************************************************  
Private Sub Is_Complete_JPG(Directory As String, Filename As String) As Boolean     
  
    'If file has gone missing or is too small to be a jpg…  
    If Not(File.Exists(Directory, Filename)) Or File.Size(Directory, Filename) < 4 Then Return False  
  
    Private wrk_raf As RandomAccessFile  
    Private wrk_marker(2) As Byte  
    Private wrk_soi, wrk_eoi As Boolean  
  
    Try  
  
        'Open read only  
        wrk_raf.Initialize(Directory, Filename, True)  
  
        'Check for SOI marker at head of file  
        If wrk_raf.ReadBytes(wrk_marker, 0, 2, 0) = 2 Then  
            wrk_soi = (Bit.And(wrk_marker(0), 0xFF) = 0xFF And Bit.And(wrk_marker(1), 0xFF) = 0xD8)  
        End If  
  
        'Check for EOI marker at tail of file  
        If wrk_raf.ReadBytes(wrk_marker, 0, 2, wrk_raf.Size - 2) = 2 Then  
            wrk_eoi = (Bit.And(wrk_marker(0), 0xFF) = 0xFF And Bit.And(wrk_marker(1), 0xFF) = 0xD9)  
        End If  
  
        wrk_raf.Close  
  
    Catch  
  
        Log(LastException)  
  
        Try  
            wrk_raf.Close  
        Catch  
            Log(LastException)  
        End Try  
  
        Return False  
  
    End Try  
  
    'Complete only if it opened with SOI and closed with EOI  
    Return wrk_soi And wrk_eoi  
  
End Sub
```