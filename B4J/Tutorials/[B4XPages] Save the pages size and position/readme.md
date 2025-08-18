### [B4XPages] Save the pages size and position by Erel
### 08/22/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/133639/)

Add to B4XMainPage:  

```B4X
Type PagePosition (Left As Int, Top As Int, Width As Int, Height As Int, IsIconified As Boolean)  
Private kvs As KeyValueStore
```

  
And:  

```B4X
Public Sub SavePagePosition (Page As Object)  
    Dim f As Form = B4XPages.GetNativeParent(Page)  
    If f = Null Or f.IsInitialized = False Then Return  
    kvs.Put(B4XPages.GetPageId(Page), FormToPP(f))      
End Sub  
  
Public Sub LoadPagePosition (Page As Object)  
    Dim f As Form = B4XPages.GetNativeParent(Page)  
    Dim pp As PagePosition = kvs.Get(B4XPages.GetPageId(Page))  
    If pp = Null Then Return  
    SetFormFromMap(pp, f)  
End Sub  
  
Private Sub FormToPP (f As Form) As PagePosition  
    Return CreatePagePosition(f.WindowLeft, f.WindowTop, f.WindowWidth, f.WindowHeight, f.As(JavaObject).GetFieldJO("stage").RunMethod("isIconified", Null))  
End Sub  
  
  
Private Sub SetFormFromMap(pp As PagePosition, f As Form)  
    f.WindowLeft = pp.Left  
    f.WindowTop = pp.Top  
    f.WindowWidth = pp.Width  
    f.WindowHeight = pp.Height  
    Dim iconified As Boolean = pp.IsIconified  
    If iconified Then  
        Dim jo As JavaObject = f  
        jo.GetFieldJO("stage").RunMethod("setIconified", Array(iconified))  
    End If  
    'check that left and top are in screen boundaries  
    Dim goodLeft, goodTop As Boolean  
    Dim fx As JFX  
    For Each screen As Screen In fx.Screens  
        If f.WindowLeft >= screen.MinX And f.WindowLeft <= screen.MaxX Then  
            goodLeft = True  
        End If  
        If f.WindowTop >= screen.MinY And f.WindowTop <= screen.MaxY Then  
            goodTop = True  
        End If  
    Next  
    If Not(goodLeft) Then f.WindowLeft = 0  
    If Not(goodTop) Then f.WindowTop = 0  
End Sub  
  
Private Sub CreatePagePosition (Left As Int, Top As Int, Width As Int, Height As Int, IsIconified As Boolean) As PagePosition  
    Dim t1 As PagePosition  
    t1.Initialize  
    t1.Left = Left  
    t1.Top = Top  
    t1.Width = Width  
    t1.Height = Height  
    t1.IsIconified = IsIconified  
    Return t1  
End Sub
```

  
  
Add to each page:  

```B4X
'at the end of B4XPage_Created  
B4XPages.MainPage.LoadPagePosition(Me)  
'And:  
Private Sub B4XPage_Background  
    B4XPages.MainPage.SavePagePosition(Me)  
End Sub
```