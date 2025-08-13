###  [XUI] New Library - HaloAdvanced by T201016
### 08/19/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/142422/)

Hello,  
**[SIZE=4]HaloAdvanced 1.01[/SIZE]**[SIZE=4] - This is a useful new library.  
It allows you to enrich almost every list with the HALO EFFECT, which sometimes lacks this visual effect.  
So, meeting possible needs, I made this contribution:  
  
An example of calling it up in the menu (aspm\_adva) by entering only two lines of code:[/SIZE]  
  
![](https://www.b4x.com/android/forum/attachments/132720)  

```B4X
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    aspm_halo.initialize  
End Sub  
  
Private Sub aspm_adva_ItemClick(Index As Int,Tag As Object)  
    Try  
    
    aspm_halo.CreateHaloEffect(aspm_adva.CustomListView.GetPanel(Index),aspm_adva.CustomListView.GetPanel(Index).Width/2,aspm_adva.CustomListView.GetPanel(Index).Height/2,0x9BFFFFFF)  
    Select Index  
        Case 0  
            Return  
        Case 1  
            If Starter.loc.UsrLng.EqualsIgnoreCase("en") Or Starter.loc.Locale.EqualsIgnoreCase("en") Then Return  
            Starter.loc.UsrLng = "en"  
            Starter.loc.ForceLocale("en")  
        Case 3  
            If Starter.loc.UsrLng.EqualsIgnoreCase("pl") Or Starter.loc.Locale.EqualsIgnoreCase("pl") Then Return  
            Starter.loc.UsrLng = "pl"  
            Starter.loc.ForceLocale("pl")  
        Case 5  
            If Starter.loc.UsrLng.EqualsIgnoreCase(Starter.loc.FindLocale) Then Return  
            Starter.loc.UsrLng = Starter.loc.FindLocale  
            Starter.loc.ForceLocale(Starter.loc.UsrLng)  
        Case Else  
            'more …  
    End Select  
  
    Main.pmr.SetString("lang", Starter.loc.UsrLng)  
    Starter.loc.LocalizeLayout(svMainScrollView.Panel)  
    If SubExists(Main, "RestartActivity") Then CallSub(Main, "RestartActivity")  
    
    Catch  
        Return  
    End Try  
End Sub
```

  
  

---

  
[FONT=trebuchet ms][SIZE=3]If any of my posts were helpful, please consider a donation of any amount   
[![](https://www.b4x.com/android/forum/attachments/132723)](https://www.paypal.me/T201016)… or clicking the Like button would be appreciated too.[/SIZE][/FONT]