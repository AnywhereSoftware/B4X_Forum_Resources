### Activity_Click and Activity_KeyPress in B4XPages by hatzisn
### 10/12/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/143482/)

I figured out a way to tweak Activity\_Click and Activity\_KeyPress in B4XPages.  
The first thing you will do is make in the B4XPage the controls you want to use public. Then in Main Activity you just add this. The code is created for Activity\_Click but it can be easily manipulated to handle the keycodes in each page if this code is placed in Activity\_KeyPress and change the handling code in each case.  
  

```B4X
Sub Activity_Click  
     
    Dim b4xpinfo As B4XPageInfo  
    b4xpinfo.Initialize  
     
    b4xpinfo = B4XPages.GetManager.GetTopPage  
         
    Log(b4xpinfo.Id)  
    Select Case b4xpinfo.Id  
        Case "mainpage"  
            If B4XPages.MainPage.pnlLegal.Visible = True Then  
                B4XPages.MainPage.cmdLegal.Visible = True  
                B4XPages.MainPage.pnlLegal.Visible = False  
            End If  
         
    End Select  
     
End Sub
```