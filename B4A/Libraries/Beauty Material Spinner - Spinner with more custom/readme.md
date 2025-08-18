### Beauty Material Spinner - Spinner with more custom by hoiketoan95
### 03/12/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/128545/)

I want to custom more spinner because i dont like default spinner  
So i wrapper this library to better and nice spinner (<https://github.com/jaredrummler/MaterialSpinner>)  
  
Features:  
- Custom font, colors, animation, change arrow down,….  

![](https://www.b4x.com/android/forum/attachments/109508)

  
  
  
  
  

```B4X
Activity.LoadLayout("Layout")  
    B4ADropDownView1.FontText=Typeface.CreateNew(Typeface.LoadFromAssets("caviardreams.ttf"),Typeface.STYLE_BOLD)  
'    B4ADropDownView1.DropdownHeight=160dip  
'    B4ADropDownView1.DropdownMaxHeight=250dip  
    B4ADropDownView1.ArrowColor= Colors.White'Colors.RGB(37,99,147)  
    B4ADropDownView1.BackgroundColor=Colors.RGB(222,74,62)  
    Dim poCD As ColorDrawable  
    poCD.Initialize2(Colors.RGB(222,74,62),5dip,1dip,Colors.RGB(161,58,51))  
    B4ADropDownView1.Background = poCD  
    B4ADropDownView1.TextColor=Colors.White  
  
  
    Dim listitem As List  
    listitem.Initialize  
    listitem.AddAll(Array As String("One", "Two", "Three","Four","Five","Love <3 B4X"))  
    B4ADropDownView1.ItemsList=listitem  
    B4ADropDownView1.SelectedIndex=1  
  
'COMPARE WITH DEFAULT SPINNER  
    Spinner1.AddAll(Array As String("One", "Two", "Three","Four","Five","Love <3 B4X"))  
    'Spinner1.Background=poCD  
    Spinner1.TextSize=14  
    Spinner1.TextColor=Colors.Black  
    Spinner1.DropdownBackgroundColor=Colors.RGB(222,74,62)
```