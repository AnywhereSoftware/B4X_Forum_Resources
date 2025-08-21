###  B4XPages - Converting to B4XPages by Alessandro71
### 07/29/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/120610/)

I'm opening this thread to collect tricks and caveats I'm coming across while converting my projects to B4XPages  
  
**CallSub from Service**  
Looks like a service that is started at boot may execute before the Main activity is created.  
This was not a problem with CallSub, since it just won't be executed  

```B4X
CallSub(Main, "PopulateCLV")
```

  
Using B4XPages, a direct call to the MainPage sub will result in an exception.  
I added some check before actually calling it  

```B4X
If (B4XPages.IsInitialized) Then  
    If (B4XPages.MainPage.IsInitialized) Then  
        B4XPages.MainPage.PopulateCLV  
    End If  
End If
```

  
  
**Activity Attributes in the Manifest file**  
Since there's only one Activity in the B4XPages framework, and I was using the B4XPreferences dialog in a secondary activity, I had to change manifest from  

```B4X
SetActivityAttribute(Dash, android:windowSoftInputMode, adjustResize|stateHidden)
```

  
to  

```B4X
SetActivityAttribute(Main, android:windowSoftInputMode, adjustResize|stateHidden)
```

  
  
**Closing**  
Looks like  

```B4X
B4XPages.ClosePage(Me)
```

  
behaves differently from  

```B4X
Activity.Finish
```

  
Finish actually calls Activity\_Pause, while ClosePage does not call CloseRequest: keep in mind when converting Activity\_Pause subs