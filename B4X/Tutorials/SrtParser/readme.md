###  SrtParser by xulihang
### 12/30/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/164874/)

A library to parse subtitle files (srt).  
  
It will parse the following srt:  
  
  

```B4X
1  
00:00:44,410 –> 00:00:46,880  
枪 他有一把枪  
Gun! He's got a gun!  
  
2  
00:00:50,960 –> 00:00:52,260  
不…怎么会这样  
No, no! What the fuck?  
  
3  
00:01:15,320 –> 00:01:16,530  
糟糕  
Oh, fuck!
```

  
  
In to a list of SpeechLine:  
  

```B4X
(ArrayList) [  
[IsInitialized=true, number=1, startTime=00:00:44,410  
, endTime=00:00:46,880, text=枪 他有一把枪  
Gun! He's got a gun!],  
[IsInitialized=true, number=2, startTime=00:00:50,960  
, endTime=00:00:52,260, text=不…怎么会这样  
No, no! What the fuck?],  
[IsInitialized=true, number=3, startTime=00:01:15,320  
, endTime=00:01:16,530, text=糟糕  
Oh, fuck!  
]]  
[/CODE]
```