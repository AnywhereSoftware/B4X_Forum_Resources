### HOW YOU CAN USE ScrollView by modiran_ghaneipour
### 03/11/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/166065/)

hello  
if you have a panel and you want scroll this panel then you use this source.  
  
at first create scrollview in source code  
then cut views in your panel and paste in scrollview panel  
now show this  
  
  

```B4X
'  ______________________________________  
    If scvSetup.IsInitialized = False Then  
        scvSetup.Initialize(0)  
        Activity.AddView(scvSetup, 1%x, 0%y, 98%x, 100%y)  
        For Each myItem As View In pnlServer.GetAllViewsRecursive  
            Try  
                If  myItem.As(View) <> Null Then  
                    Dim Items As View = myItem.As(View)  
                     
                    myItem.As(View).RemoveView  
                    scvSetup.panel.AddView(Items, Items.As(View).Left, Items.As(View).Top, Items.As(View).Width, Items.As(View).Height)  
                End If  
            Catch  
                Log(LastException)  
            End Try  
        Next  
        'scvSetup.Panel.Height = 1000dip'pnlSetup.Height  
        scvSetup.Panel.Height = 170%y'pnlSetup.Height  
        scvSetup.Panel.Width = 100%x'pnlSetup.Width  
    End If  
    scvSetup.ScrollPosition = 0  
    scvSetup.Visible =  True  
    '_____________________________________________
```

  
  
  
and for b4xpages:  
  

```B4X
'  ______________________________________  
    If scvSetup.IsInitialized = False Then  
        scvSetup.Initialize(0)  
        root.AddView(scvSetup, 1%x, 0%y, 98%x, 100%y)  
        For Each myItem As View In pnlServer.GetAllViewsRecursive  
            Try  
                If  myItem.As(View) <> Null Then  
                    Dim Items As View = myItem.As(View)  
                     
                    myItem.As(View).RemoveView  
                    scvSetup.panel.AddView(Items, Items.As(View).Left, Items.As(View).Top, Items.As(View).Width, Items.As(View).Height)  
                End If  
            Catch  
                Log(LastException)  
            End Try  
        Next  
        'scvSetup.Panel.Height = 1000dip'pnlSetup.Height  
        scvSetup.Panel.Height = 170%y'pnlSetup.Height  
        scvSetup.Panel.Width = 100%x'pnlSetup.Width  
    End If  
    scvSetup.ScrollPosition = 0  
    scvSetup.Visible =  True  
    '_____________________________________________
```

  
  
  
use variable in global  

```B4X
Sub Globals  
    Private scvSetup As ScrollView  
    'These global variables will be redeclared each time the activity is created.  
    Private pnlServer As Panel  
End Sub
```