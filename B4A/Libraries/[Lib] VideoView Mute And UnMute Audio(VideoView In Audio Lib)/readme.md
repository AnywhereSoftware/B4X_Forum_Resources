### [Lib] VideoView Mute And UnMute Audio(VideoView In Audio Lib) by AmirPYTHON
### 05/19/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/167060/)

***Note: [SIZE=7]This Lib Need Reflection Library[/SIZE]***  
Hi guys,  
 there is a VideoView in the audio library that does not have a mute mode. I tried to fix it. I hope it is useful.  
  
  
How To Use:  
  
  

```B4X
    Dim vv As VideoView  
    vv.Initialize("vv")  
    Activity.AddView(vv, 10dip, 10dip, 250dip, 250dip)  
    vv.LoadVideo(File.DirRootExternal, "somefile.mp4")  
    vv.Play  
      
    Dim KVM As KDB_VV_Mute  
    KVM.MuteVideo(VV)   '   Or KVM.UnMuteVideo(VV)
```