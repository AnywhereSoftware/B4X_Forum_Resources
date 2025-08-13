### Torch in CamEx2 by b4x-de
### 05/07/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/160997/)

For some reason there is no support for the torch feature in CamEx2. Add this Sub to CamEx2 (v1.31) to have a torch:  
  

```B4X
Public Sub setTorch(pbolOn As Boolean, pbolVideoRecording As Boolean)  
    SetBothMaps("FLASH_MODE", FLASH_MODE.IndexOf(IIf(pbolOn, "TORCH", "OFF")))  
    StartPreview(TaskIndex, pbolVideoRecording)  
End Sub
```