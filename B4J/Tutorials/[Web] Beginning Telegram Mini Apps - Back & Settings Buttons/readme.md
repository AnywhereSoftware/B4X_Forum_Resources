### [Web] Beginning Telegram Mini Apps - Back & Settings Buttons by Mashiane
### 07/26/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/162271/)

Hi Fam  
  
The back button controls the visibility & navigation when the back button is active. This is like the normal back button in an app.  
The settings buttons show on the right menu of the bot. This is demonstrated below.  
  
[Demo](https://t.me/SithasoHoldingsBot)  
  
<https://youtube.com/shorts/oGRG9_XRXCY>  
  
  
We define the buttons  
  

```B4X
Private BB As TMABackButton  
    Private SB As TMASettingsButton
```

  
  
we then get the buttons and then add events to them  
  

```B4X
BB = pgIndex.TMA.WebApp.BackButton  
    SB = pgIndex.TMA.WebApp.SettingsButton  
    'add event  
    BB.OnClick(Me)  
    SB.OnClick(Me)
```

  
  
When we click the buttons, we can toggle the back & settings buttons  
  

```B4X
Sub btntoggleback_click (e As BANanoEvent)  
    e.PreventDefault  
    If BB.IsVisible Then  
        BB.Hide  
        btntoggleback.Caption = "Show Back Button"  
    Else  
        BB.Show  
        btntoggleback.Caption = "Hide Back Button"      
    End If  
End Sub  
'  
Sub btnsettings_click (e As BANanoEvent)  
    e.PreventDefault  
    If SB.IsVisible Then  
        SB.Hide  
        btnsettings.Caption = "Show Settings Button"  
    Else  
        SB.Show  
        btnsettings.Caption = "Hide Settings Button"  
    End If  
End Sub
```