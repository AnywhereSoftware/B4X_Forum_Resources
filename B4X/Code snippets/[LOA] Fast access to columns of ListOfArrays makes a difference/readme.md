### [LOA] Fast access to columns of ListOfArrays makes a difference by William Lancee
### 05/28/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/171139/)

If you need frequent access to different columns of a large List Of Arrays, it will be beneficial to first transform the LOA to a Map of Lists (MOL).  
  
Note: Table created with wLOAExtras…  
<https://www.b4x.com/android/forum/threads/b4x-listofarrays-wloaextras-b4xlib-for-evaluating-expressions-of-columns-in-listofarrays-and-more.170728/>  
  
Edit: This post is not related to [USER=1]@Erel[/USER] 's challenge which was posted while I was working on this one. That challenge requires a different approach.   
<https://www.b4x.com/android/forum/threads/time-for-a-loa-quiz.171138/>  
  

```B4X
'A 1000000 x 3 table of random numbers between 0 and 360 ('LOA4' in code below)  
'c_1                 c_2                 c_3              
'――――――――――――――――――――――――  
'112.068         333.947         40.493        
'175.982         251.892         315.090      
'77.418           348.905         199.868      
'65.135           277.855         243.007      
'198.994         260.251         232.114      
'―――first 5 rows―― #rows=1000000 #cols=3  
  
'Transform to MOL  
    Dim markTime As Long = DateTime.Now  
    Dim MOL As Map = wLOAtoMOL(LOA4)  
    Log(DateTime.Now - markTime)     '41 msecs  
  
'Test without tranformation: 100 accesses to 1000000 rows  
    Dim markTime As Long = DateTime.Now  
    For i = 1 To 100  
        Dim j As Int = 1 + i Mod 3  
        Dim c_j As List = LOA4.GetColumn("c_" & j)  
    Next  
    Log(DateTime.Now - markTime)     '1509 msecs  
  
'Test with MOL: 100 accesses to 1000000 rows  
    Dim markTime As Long = DateTime.Now  
    For i = 1 To 100  
        Dim j As Int = 1 + i Mod 3  
        Dim c_j As List = MOL.Get("c_" & j)  
    Next  
    Log(DateTime.Now - markTime)    '<1 msec
```

  
  

```B4X
Public Sub wLOAtoMOL (LOA As ListOfArrays) As Map  
    Dim mp As Map  
    mp.Initialize  
    For Each s As String In LOA.Header  
        mp.put(s, LOA.GetColumn(s))  
    Next  
    Return mp    
End Sub
```