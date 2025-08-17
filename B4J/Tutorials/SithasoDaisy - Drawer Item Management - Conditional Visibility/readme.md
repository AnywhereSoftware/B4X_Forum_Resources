### SithasoDaisy - Drawer Item Management - Conditional Visibility by Mashiane
### 06/10/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/148436/)

Ola  
  
![](https://www.b4x.com/android/forum/attachments/142829)  
  
The issue of drawer item visibility becomes interesting when you want to control which drawer items should be visible or not depending on user group permissions.  
As an example we want to hide and show some of these items on condition.  
  
  
We have defined our dawer & pages like this  
  

```B4X
'NB: use this to add pages that are not added to the side nav bar  
Sub AddPages  
    'example  
    app.AddPage(pgSignIn)        'ignore  
    app.AddPage(pgSignUp)        'ignore  
End Sub
```

  
  
Our sign in / sign up page, we want them to be in the page stack but not show in the drawer.  
  

```B4X
'define the menu items fo dawe  
Sub CreateDrawerMenu  
    'clear the menu  
    appdrawer.Clear("")  
    'add a page link to the drawer  
    appdrawer.AddItemPage(pgcustomer)  
    appdrawer.AddItemPage(pgemails)  
    appdrawer.AddItemPage(pgreminders)  
    appdrawer.AddItemPage(pgcommunication)  
    appdrawer.AddItemPage(pgappointment)  
    appdrawer.AddItemPage(pgtasks)  
    appdrawer.AddItemPage(pgdocs)  
    '  
    appdrawer.AddItem("paypal", "Paypal")  
    appdrawer.AddItemChildPage("paypal", pgtrans)  
    appdrawer.AddItemChildPage("paypal", pgsummaryperyear)  
    appdrawer.AddItemChildPage("paypal", pgsummarypertranfrom)  
    appdrawer.AddItemChildPage("paypal", pgsummarypername)  
    appdrawer.AddItemChildPage("paypal", pgsummarypertype)  
    appdrawer.AddItemChildPage("paypal", pgsummaryperstatus)  
    appdrawer.AddItemChildPage("paypal", pgsummarypercountry)  
    appdrawer.AddItemChildPage("paypal", pgsummarypercurrency)  
    appdrawer.AddItemChildPage("paypal", pgsummaryperimpact)  
    '  
    appdrawer.AddItem("settings", "Settings")  
    appdrawer.AddItemChildPage("settings", pgemailtemplates)  
    appdrawer.AddItemChildPage("settings", pgForgotPassword)  
    'appdrawer.AddItemChildPage("settings", )  
End Sub
```

  
  
Now, depending on authentication of the user, we can control which items are visible or not, by updating the IsAuthenticated sub. Here is the update.  
  

```B4X
'show/hide drawer  
Sub IsAuthenticated(b As Boolean)  
    appdrawer.Close  
    If b Then  
        appdrawer.ShowPageLink(pgcustomer)  
        appdrawer.ShowPageLink(pgemails)  
        appdrawer.ShowPageLink(pgreminders)  
        appdrawer.ShowPageLink(pgcommunication)  
        appdrawer.ShowPageLink(pgappointment)  
        appdrawer.ShowPageLink(pgtasks)  
        appdrawer.ShowPageLink(pgdocs)  
  
        appdrawer.ShowItem("paypal")  
        appdrawer.ShowItem("settings")  
        appdrawer.Show  
        appdrawer.AdjustClippedLeft(True)  
        appnavbar.Show  
    Else  
         
        appdrawer.HidePageLink(pgcustomer)  
        appdrawer.HidePageLink(pgemails)  
        appdrawer.HidePageLink(pgreminders)  
        appdrawer.HidePageLink(pgcommunication)  
        appdrawer.HidePageLink(pgappointment)  
        appdrawer.HidePageLink(pgtasks)  
        appdrawer.HidePageLink(pgdocs)  
         
        appdrawer.HideItem("paypal")  
        appdrawer.HideItem("settings")  
        appdrawer.AdjustClippedLeft(False)  
        appdrawer.Hide  
        appnavbar.hide  
    End If  
End Sub
```

  
  
Because we can call these visibility controlling functions, we will add some helper functions on pgIndex  
  

```B4X
Sub ShowMenuItem(itemID As String)  
    appdrawer.ShowItem(itemID)  
End Sub  
  
Sub HideMenuItem(itemID As String)  
    appdrawer.HideItem(itemID)  
End Sub  
  
Sub HidePageLink(pgObj As Object)  
    appdrawer.HidePageLink(pgObj)  
End Sub  
  
Sub ShowPageLink(pgObj As Object)  
    appdrawer.ShowPageLink(pgObj)  
End Sub
```

  
  
These can be called from any code module.  
  
Happy coding…