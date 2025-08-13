### [Web][SithasoDaisy] How to create a sticky Bottom Navigation Bar & navigate your app pages by Mashiane
### 03/15/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/159916/)

Hi Fam  
  
Your app can have a bottom navigation which will help you navigate from one page to another. The navigation bar can be linked to the drawer of your app. This bottom navigation bar will be available across your app and you will be able to navigate to each page.  
  
![](https://www.b4x.com/android/forum/attachments/151839)  
  
1. Ensure that in the baselayout, the "Has BottomNav" property is checked. When you app runs a bottom navigation bar named "appbottomnavbar" will be created.  
2. In Process\_Globals of your app, define the BottomNav component. This should be in pgIndex  
  

```B4X
Private appbottomnavbar As SDUIBottomNav            'ignore
```

  
  
3. Then build up your Bottom Nav Bar. We will build ours by adding page links to it.  
3.1 We have added this sub call to pgIndex.Initialize  
  

```B4X
'create the bottom nav content  
    CreateDrawerBottomNav
```

  
  
3.2 We added this sub to pgIndex  

```B4X
Sub CreateDrawerBottomNav  
    'get the footer inside the drawer  
    appbottomnavbar = appdrawer.BottomNav  
    'turn off animation  
    appbottomnavbar.animate = False  
    'add links to the various pages  
    appbottomnavbar.AddItemPage(pgHome)  
    appbottomnavbar.AddItemPage(pgServices)  
    appbottomnavbar.AddItemPage(pgContactUs)  
End Sub
```

  
  
4. In the code where the menu items are clicked in the drawer, we add code to "sync" the clicked page link in the drawer with the bottom nav bar. This should be done before the app.ShowPage call  
  

```B4X
'ensure we sync the clicked page to the bottom nav  
    appbottomnavbar.ActivePage = item
```

  
  
5. Each time an item in the bottom navigation is clicked, we want to open the respective page in our app  
  

```B4X
Private Sub appbottomnavbar_Click (item As String)  
    'the item starts with page_  
    If app.ShowPage(item) Then Return  
    '  
    Select Case item  
          
    End Select  
End Sub
```

  
  
PS: In the attached example, the images have been removed.