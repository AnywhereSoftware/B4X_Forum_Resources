### [B4Xpages] maintaining the page during a split-screen size change by swChef
### 03/31/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/129239/)

The default B4Xpages B4A template doesn't maintain the 'current page' when resizing the splits.  
  
I worked around this issue by  
- adding a Main Process\_Globals variable, for example Public sIDLastPageName As String  
- in Main Activity\_Create add the following  

```B4X
If Not(FirstTime) Then  
    B4XPages.ShowPage(sIDLastPageName)  
End If
```

  
- in each B4XPage add the following into the B4XPage\_Appear  

```B4X
Sub B4XPage_Appear  
    Main.sIDLastPageName = "MainPage"  
End Sub
```

  
For the B4Xpages template example, you would need to use a Select in the Main Activity\_Create to use the method ShowPageAndRemovePreviousPages for case "Page 2", to reproduce the 'hide Login' action.