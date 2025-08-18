### Cancelling 'Sleep' Awakening Events by William Lancee
### 12/02/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/125143/)

Inspired by <https://www.b4x.com/android/forum/threads/b4x-resumable-subs-and-the-index-pattern.111487/>  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private cancelTimes As Map  
    Private ProgramStart As Long = DateTime.Now        'In this example it is used for Logging times  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    
    cancelTimes.Initialize  
    Dim tripIds() As String = Array As String("*", "A", "B", "C", "D", "E")  
    For Each id In tripIds  
        cancelTimes.Put(id, DateTime.Now)  
    Next  
    
    'Note that time points (in msecs) have been artificially shortened to see results within 15 seconds.  
    startTripInFuture(0, "A")  
    startTripInFuture(5000, "B")  
    startTripInFuture(7500, "C")  
    startTripInFuture(10000, "D")  
    startTripInFuture(12500, "E")  
    
    'Halfway into Trip A, a time conflict results in the cancellation of "C"  
    Sleep(2500)  
    Log("Cancellation of Trip C occurs at " & (DateTime.now - ProgramStart))  
    cancelTimes.Put("C", DateTime.Now)  
        
    'Trip B is started but during the trip, a crisis occurs, all trips have to be cancelled  
    Sleep(6000)  
    Log("Crisis event occurs at " & (DateTime.now - ProgramStart))  
    cancelTimes.Put("*", DateTime.Now)  
  
End Sub  
  
Private Sub startTripInFuture(delay As Long, tripId As String)  
    Dim timeScheduled As Long = DateTime.now  
    Sleep(delay)  
    If timeScheduled < Max(cancelTimes.Get(tripId), cancelTimes.Get("*")) Then  
        Log("Trip " & tripId & " is aborted at " & (DateTime.now - ProgramStart))  
        Return  
    End If  
    
    Log("Trip " & tripId & " is started at " & (DateTime.now - ProgramStart))  
    'pack suitcase  
    'book transportation to  airport  
    
    Sleep(7500)  
    'the same method can be used to exit loops and pending sub calls  
    If timeScheduled < Max(cancelTimes.Get(tripId), cancelTimes.Get("*")) Then  
        Log("Trip " & tripId & " is aborted at " & (DateTime.now - ProgramStart))  
        Return  
    End If  
    'get up early  
    'travel to airport  
    'etc.  
End Sub
```