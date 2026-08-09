### Check an mp4 file is structurally complete - courtesy of Claude code by JackKirk
### 08/07/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171739/)

```B4X
'************************************************************************************  
'  
'This procedure checks an mp4 file is structurally complete - courtesy of Claude code  
'  
'Input parameters are:  
'  
'       Directory = directory holding mp4 file  
'       Filename = name of mp4 file  
'  
'Returns:  
'  
'       True if a moov box is present, False otherwise - top level boxes are also  
'       checked to see if they tile file exactly, but that is currently reported  
'       rather than enforced (see notes)  
'  
'Notes on this procedure:  
'  
'       o An mp4 is a chain of top level boxes, each of form:  
'             4 bytes big endian box size (includes this 8 byte header)  
'             4 bytes box type, e.g. ftyp, free, mdat, moov  
'         a box size of 1 means real size is a 64 bit value following box type, a  
'         box size of 0 means box runs to end of file (only legal for last box)  
'  
'       o A truncated mp4 is caught because its last box (typically mdat, which  
'         holds video data and is by far largest) claims a size that overruns end  
'         of file - ffmpeg output typically carries moov last, so a truncated file  
'         also loses moov and is unplayable  
'  
'       o Tiling test is deliberately not enforced - it is stricter than moov test  
'         and a valid file carrying trailing padding after its last box would fail  
'         it - any shortfall is logged instead, so Run log can be checked over  
'         time before deciding to enforce it  
'  
'       o Box size is read a byte at a time and accumulated into a Long because it  
'         is an unsigned 32 bit value - ReadInt would return it signed and mdat  
'         exceeds 2GB on long videos  
'  
'       o jRandomAccessFile must be available to project  
'  
'************************************************************************************  
Private Sub Is_Complete_MP4(Directory As String, Filename As String) As Boolean  
  
    'If file has gone missing…  
    If Not(File.Exists(Directory, Filename)) Then Return False  
  
    Private wrk_size As Long = File.Size(Directory, Filename)  
  
    'If too small to hold even one box header…  
    If wrk_size < 8 Then Return False  
  
    Private wrk_raf As RandomAccessFile  
    Private wrk_type(4) As Byte  
    Private wrk_pos As Long  
    Private wrk_boxsize As Long  
    Private wrk_moov As Boolean  
    Private wrk_tiles As Boolean  
  
    Try  
  
        'Open read only - default byte order is big endian, which is what mp4 uses  
        wrk_raf.Initialize(Directory, Filename, True)  
  
        'Walk top level boxes while a full box header remains…  
        Do While wrk_pos + 8 <= wrk_size  
  
            'Get box size  
            wrk_boxsize = wrk_raf.ReadUnsignedByte(wrk_pos)  
            wrk_boxsize = wrk_boxsize * 256 + wrk_raf.ReadUnsignedByte(wrk_pos + 1)  
            wrk_boxsize = wrk_boxsize * 256 + wrk_raf.ReadUnsignedByte(wrk_pos + 2)  
            wrk_boxsize = wrk_boxsize * 256 + wrk_raf.ReadUnsignedByte(wrk_pos + 3)  
  
            'Get box type  
            wrk_raf.ReadBytes(wrk_type, 0, 4, wrk_pos + 4)  
  
            'If box size is 1, real size is 64 bit value following box type…  
            If wrk_boxsize = 1 Then  
  
                'If that 64 bit size is not all there then file is truncated  
                If wrk_pos + 16 > wrk_size Then Exit  
  
                wrk_boxsize = wrk_raf.ReadLong(wrk_pos + 8)  
  
            'Otherwise, if box size is 0, box runs to end of file…  
            Else If wrk_boxsize = 0 Then  
  
                wrk_boxsize = wrk_size - wrk_pos  
  
            End If  
  
            'If box is impossibly small or overruns end of file then file is  
            'truncated or corrupt…  
            If wrk_boxsize < 8 Or wrk_pos + wrk_boxsize > wrk_size Then Exit  
  
            'Note moov - without it file is unplayable  
            If BytesToString(wrk_type, 0, 4, "ISO-8859-1") = "moov" Then wrk_moov = True  
  
            'Step to next box  
            wrk_pos = wrk_pos + wrk_boxsize  
  
        Loop  
  
        'Boxes should tile file exactly - reported rather than enforced, see notes  
        wrk_tiles = (wrk_pos = wrk_size)  
  
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
  
    'Log any tiling shortfall so it can be seen whether test is safe to enforce  
    If wrk_moov And Not(wrk_tiles) Then  
        Log("mp4 " & Filename & " accepted with moov but top level boxes stop at " & wrk_pos & " of " & wrk_size & " bytes")  
    End If  
  
    'Complete if moov was present - to also enforce tiling, change this to  
    '[Return wrk_tiles And wrk_moov]  
    Return wrk_moov  
  
End Sub
```