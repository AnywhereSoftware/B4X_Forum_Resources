### B4A Y2038 proof ready by toby
### 01/22/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/137842/)

[The Y2038 problem](https://en.wikipedia.org/wiki/Year_2038_problem) is getting closer and closer, which is something we can't ignore. So far Linux/Unix haven't solved the problem yet.   

```B4X
SELECT unix_timestamp("2042-01-22 18:25:30");
```

  
  
I'm amazed and surprised to discover that B4A is Y2038 proof already! Below is the code I tried.  

```B4X
    Dim y2042 As Long=DateTime.Now+DateTime.TicksPerDay * 365 * 20 'add 20 years to current time  
    Log(y2042)  
    DateTime.DateFormat="EEEE yyyy-MM-dd hh:mm:ss"  
    Log(DateTime.Date(y2042))
```

  

```B4X
2273603328237  
Friday 2042-01-17 03:28:48
```

  
Long live the B4X!