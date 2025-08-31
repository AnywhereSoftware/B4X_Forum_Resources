### Checking device volume in Android by Matt S.
### 08/25/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/168388/)

Using GetVolume() returns your device volume value, but the scale may vary due to your device model. Scaling this value in the range of (0 to 1) may be like this:  

```B4X
Public Sub GetVolumeScaled() As Float '0 to 1  
    Dim myPhone As Phone  
    Return myPhone.GetVolume(myPhone.VOLUME_MUSIC) / myPhone.GetMaxVolume(myPhone.VOLUME_MUSIC)  
End Sub
```