### Get a size of structure by max123
### 07/12/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/167761/)

Hi all,  
  
for peoples have requested it in past, here a code to get a size in bytes of a structure created with a Type command.  
I'm not sure all this is ok, but worked for me and it returns the right size (in bytes) of all elements inside the structure, that is 80 bytes.  
  
This can be simplified if there's a way to iterate all structure elements like an array.  
  
Here my code:  

```B4X
Sub Process_Globals  
    Dim fx As JFX  
    Dim MainForm As Form  
   
    Type RawVideoHeader ( _  
        Signature As Int, _         ' "RVIF"  
        FileSize As Long, _         ' Size of file in bytes  
        HeaderSize As Short, _      ' Size of this header structure in bytes  
        DataChunkStart As Short, _  ' Byte offset to the data chunk containing all contiguos frames (point To a first frame) (this is by default 100 bytes from a begin of File)  
        VideoBlockSize As Int, _    ' The len (in bytes) of a full data chunk containing jpeg frame. Note this contains padding zeroes to fill the frame module to the largest image size in the video.  
        AudioBlockSize As Int, _    ' The len (in bytes) of a full data chunk containing audio for current frame. The size depends on many factors, the most importants are the audio samplerate and the video framerate.  
        FrameBlockSize As Int, _    ' The len (in bytes) of a full frame, video + audio  
        FramePixelCount As Int, _   ' The count of pixels in a single frame inside a data chunk (that is equal to width * height)  
        Width As Short, _           ' Width of images in pixels  
        Height As Short, _          ' Height of images in pixels  
        FrameCount As Int, _        ' The total number of frames  
        FrameRate As Float, _  
        Duration As Float, _  
        DurationInMs As Long, _  
        AudioChannels As Short, _  
        AudioSampleRate As Int, _  
        AudioByteRate As Int, _  
        BlockAlign As Short, _  
        AudioBitsPerSample As Short, _  
        AudioNumSamples As Long, _  
        HasAudio As Short _        ' Denotes if the video has audio  
    )  
   
    Dim HEADER_SIZE As Byte  ' Or Int  
    Dim VideoFileHeader As RawVideoHeader  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("1") 'Load the layout file.  
   
    HEADER_SIZE = SizeOf(VideoFileHeader.Signature) _  
                + SizeOf(VideoFileHeader.FileSize) _  
                + SizeOf(VideoFileHeader.HeaderSize) _  
                + SizeOf(VideoFileHeader.DataChunkStart) _  
                + SizeOf(VideoFileHeader.VideoBlockSize) _  
                + SizeOf(VideoFileHeader.AudioBlockSize) _  
                + SizeOf(VideoFileHeader.FrameBlockSize) _  
                + SizeOf(VideoFileHeader.FramePixelCount) _  
                + SizeOf(VideoFileHeader.Width) _  
                + SizeOf(VideoFileHeader.Height) _  
                + SizeOf(VideoFileHeader.FrameCount) _  
                + SizeOf(VideoFileHeader.FrameRate) _  
                + SizeOf(VideoFileHeader.Duration) _  
                + SizeOf(VideoFileHeader.DurationInMs) _  
                + SizeOf(VideoFileHeader.AudioChannels) _  
                + SizeOf(VideoFileHeader.AudioSampleRate) _  
                + SizeOf(VideoFileHeader.AudioByteRate) _  
                + SizeOf(VideoFileHeader.BlockAlign) _  
                + SizeOf(VideoFileHeader.AudioBitsPerSample) _  
                + SizeOf(VideoFileHeader.AudioNumSamples) _  
                + SizeOf(VideoFileHeader.HasAudio)  
           
    Log("The header of file is " & HEADER_SIZE & " Bytes")  
End Sub  
  
Sub SizeOf(dataType As Object) As Int  
  
    If (dataType = Null) Then Return 0  
  
    If (dataType Is Boolean) Then Return 1  
    If (dataType Is Byte)   Then Return 1  
    If (dataType Is Char)   Then Return 2  
    If (dataType Is Short)  Then Return 2  
    If (dataType Is Int)    Then Return 4  
    If (dataType Is Float)  Then Return 4  
    If (dataType Is Long)   Then Return 8  
    If (dataType Is Double) Then Return 8  
'    If (dataType Is String) Then Return 12  ???  
 ' ………………………  
 ' ………………………  
  
    '   Return 8 ' 32-Bit memory pointer…  
    '            ' (I'm not sure how this works on a 64-bit OS)  
    Return 0  
End Sub
```