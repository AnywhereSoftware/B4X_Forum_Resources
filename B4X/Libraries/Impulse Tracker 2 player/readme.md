###  Impulse Tracker 2 player by mazezone
### 10/23/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/172356/)

**Impulse Tracker 2 player on B4J and B4A.**  
  
This is a direct port of the original C99 source codes.  
C99 source git: <https://github.com/8bitbubsy/it2play>  
  
*Notes:  
Removed: S3M support, original mixer, all unnecessary sound drivers.  
  
This was quite a complex job, as Java (B4X) does not have unsigned variables.  
Also, some algorithms were rewritten.  
However, the behavior and sound should be exactly like   
the original asm code from Jeffrey Lim.(<https://en.wikipedia.org/wiki/Impulse_Tracker>)  
  
Support for B4A and B4J. Perhaps someone will add support for B4I (section '+++++ Mixer')*  
  

```B4X
Dim it2 As it2play  
it2.Initialize  
  
If it2.Music_Init(48000, 1024) Then  
    Select it2.Music_LoadFromData(File.ReadBytes(File.DirAssets, "secretly.it"))  
        Case 0  
            Log("Success")  
            Log(it2.Song.Header.SongName)  
            it2.Music_PlaySong(0)  
        Case 1  
            Log("Error: general IO")  
        Case 2  
            Log("Error: MMCMP compressed not support")  
        Case 3  
            Log("Error: incompatible")  
    End Select  
End If
```