###  CLVItemToolbox - custom view. by LucaMs
### 02/23/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/139304/)

**Updated to v. 1.40** 02/23/2026  
' Fixed: icons layout was incorrect when ShowCheck / ShowEdit / ShowRemove were disabled in the Designer.  
  
**Updated to v. 1.31** 03/30/2022  
Fixed: ItemRemoved declaration correct.  
  
****Updated to v. 1.30****  
Added internal dialog (optional) to ask for confirmation of removal and many properties about this, included one to choose whether to use this dialog or not.  
Added the CLVItemToolbox1\_ItemRemoved (Value As Object) event; this will be triggered if the internal dialog is used, otherwise the other event will trigger, CLVItemToolbox1\_Click.  
See [post #13](https://www.b4x.com/android/forum/threads/b4x-clvitemtoolbox-custom-view.139304/post-882341) and next.  
  
**UPDATED TO V. 1.20**  
*Added the ability to blink icons (being able to set which ones) and temporarily disable blinking of the entire item.  
You can also set how many times an icon should blink and the duration of the single blink.  
The attached sample project has also been updated.*  
  
> I'm thinking maybe a custom view like this would be useful:  
>   
> ![](https://www.b4x.com/android/forum/attachments/126852)  
>   
> to be added to each item of a CustomListView.  
>   
> The icons would serve, in order, to:  
>   
> - select the item  
> - modify the item  
> - delete the item.

  
I was thinking… then I developed it.  
  
**It's free but don't forget I need coffee to live** ;)  
  
  
It's a custom view for B4A, B4J, B4I; a B4XLib that you should add to the Additional Libraries folder.  
  
  
*I shouldn't be doing these things overnight; in fact, I shouldn't do them at all ?*  
![](https://www.b4x.com/android/forum/attachments/126942)  
  
B4A-Android  
[MEDIA=youtube]d5jXALJI47o[/MEDIA]  
  
[Another example and discussion [here](https://www.b4x.com/android/forum/threads/b4x-clvitemtoolbox.139256/post-881689)]  
  
I think its purpose and use are simple; when you create an item layout for your xCustomListView in the Designer, add this CLVItemToolbox like any other view.  
  
You can choose which of the 3 icons to display (Check, Edit, Remove) and change the images if you don't like them.  
![](https://www.b4x.com/android/forum/attachments/126858)  
  
By clicking/tapping on the CLVItemToolbox the Click event will be triggered, which will receive as parameters the type of action (CHECKED, UNCHECKED, EDIT, REMOVE) and the base of the custom view, which will be useful for obtaining the index of the relative item:  

```B4X
Private Sub CLVItemToolbox1_Click(Action As String, Base As B4XView)  
    Dim ItemIndex As Int  
    ItemIndex = CustomListView1.GetItemFromView(Base)  
  
    Select Action  
        Case CLVItemToolbox1.CHECKED  
        Case CLVItemToolbox1.UNCHECKED  
        Case CLVItemToolbox1.EDIT  
        Case CLVItemToolbox1.REMOVE  
    End Select  
End Sub
```

  
  
Library and sample project are attached.