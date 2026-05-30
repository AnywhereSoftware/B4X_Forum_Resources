### [SithasoDaisy5] How to use a Vue Inspired Bottom Navigation? by Mashiane
### 05/23/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/171094/)

Hi Fam  
  
With the help of AI, i managed to convert this MIT based Vue component to a fully working web component.  
  
  
![](https://www.b4x.com/android/forum/attachments/171608)  
  
Whilst working towards finalizing the [B4XDaisyUIKit](https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/) without the use of exorbitant fees, I was wondering if it could be possible to convert a VueJS based component to a fully javascript one. Yeah. this took a lot of tokens.  
  
Step 1: Initialization..  
  

```B4X
Private botNav As SDUI5BottomNavigation
```

  
  
Step 2: Setup  
  

```B4X
    botNav.Initialize(Me, "botNav", "botNav")  
    botNav.ParentID = app.PageView  
    BANano.Await(botNav.AddComponent)  
    '  
    botNav.AddButton("home", "fa-solid fa-house", "Home", "")  
    botNav.AddButtonItem("home", "products", "fas fa-tshirt", "Products", "")  
    botNav.AddButtonItem("home", "discount", "fas fa-tag", "Discount", "")  
    botNav.AddButtonItem("home", "gifts", "fas fa-gifts", "Gifts", "7")  
  
    botNav.AddButton("search", "fa-solid fa-magnifying-glass", "Search", "")  
  
    botNav.AddButton("setting", "fa-solid fa-plus", "Setting", "")  
    botNav.AddButtonItem("setting", "bookmarks", "fas fa-bookmark", "Bookmarks", "")  
    botNav.AddButtonItem("setting", "tasks", "fas fa-tasks", "Tasks", "")  
    botNav.AddButtonItem("setting", "tickets", "fas fa-ticket-alt", "Tickets", "")  
  
    botNav.AddButton("notification", "fas fa-bell", "Notification", "15")  
  
    botNav.AddButton("config", "fa-solid fa-gear", "Setting", "")  
    botNav.ModelValue = "home"
```

  
  
Step 3: Trapping Events  
  

```B4X
Private Sub botNav_Change (value As String)  
    app.ShowSwalInfoToast(value, 1000)  
    Select Case value  
    Case "notification"  
        lastBadge = app.UI.increment(lastBadge)  
        botNav.UpdateBadge("notification", lastBadge)  
    Case "gifts"  
        lastGift = app.UI.increment(lastGift)  
        botNav.UpdateBadge("gifts", lastGift)  
    End Select  
End Sub
```

  
  
That's it.  
  
#SharingTheGoodness