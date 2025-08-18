### [BANano] Support for B4Xs 'Wait For' by alwaysbusy
### 02/01/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/138100/)

The next release of BANano (v7.15+) will support B4Xs cool 'Wait For' feature! BANano already has such a system with BANanoPromise, but it is a lot 'JavaScript' like and not 'B4X' like.  
  
As I always strive to make BANano's syntax to get as close as possible to normal B4X code (and hence make the code more 'cross platform'), it will be possible to use Wait For too for async operations.  
  
Some Examples:  

```B4X
Sub WelcomePageButton_Click (event As BANanoEvent)  
  
    ' wait for an event from another control like here the first KeyUp of an SKTextBox  
    
    Log("Waiting for a key up…")  
    ' the code will stop here until I have done a Key Up in the WelcomePageName SKTextBox  
    Wait For WelcomePageName_KeyUp (event As BANanoEvent)  
    Log("Got a Key Up: " & event.KeyCode)  
   
    ' simple wait with a sleep  
    wait for LogSleepJos  
   
    ' wait for a long method and return the result  
    Wait For (DoSum(10,20)) Complete(Result As Int)  
    Log(Result)  
   
    ' alternative way also supported  
    Dim Sum As ResumableSub = DoSumSleep(30,50)  
    wait for (Sum) complete(Result As Int)  
    Log(Result)  
   
    ' getting the json from a file on the server  
    wait for (GetFile) Complete(Json As Object)  
    Log(Json)  
   
    ' or an alternative without a seperate sub  
    Dim GetFileDirect As ResumableSub = BANano.GetFileAsJSON("https://127.0.0.1:8080/manifest.json", Null)  
    wait for (GetFileDirect) Complete (Json As Object)  
    Log(Json)  
   
    Log("Done")  
End Sub  
  
Sub LogSleepJos()  
    Log("Sleeping…")  
    Sleep(1000)  
    Log("Jos")  
End Sub  
  
Sub DoSum(a As Int, b As Int) As ResumableSub  
    Return a + b  
End Sub  
  
Sub DoSumSleep(a As Int, b As Int) As ResumableSub  
    Log("Sleeping Sum…")  
    Sleep(1000)  
    Return a + b  
End Sub  
  
Sub GetFile() As ResumableSub  
    Return BANano.GetFileAsJSON("https://127.0.0.1:8080/manifest.json", Null)  
End Sub
```

  
  
Result:  
  
![](https://www.b4x.com/android/forum/attachments/125001)  
  
Alwaysbusy