### [Solution] Increase B4XSearchTemplate without losing title bar (.bas changes) by AnandGupta
### 02/11/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/138373/)

Well my problem of 'title missing' , refer below thread, is solved by changing the.bal file and adding a title label, thanks to Mahares.  
<https://www.b4x.com/android/forum/threads/solved-how-to-increase-the-b4xsearchtemplate-to-nearly-full-screen-size-and-also-show-title-bar.138318/#post-875725>  
  
But the programmer in me could not sleep as 'why the title vanishes' if .resize() even 50% of screen !  
So I extracted and renamed (as advised always) 'gB4XSearchTemplate.bas' and debugged it.  
  
Lo ! and behold !! I found the code which was acting up.  

```B4X
Private Sub Show (Dialog As B4XDialog)  
    xDialog = Dialog  
'    xDialog.PutAtTop = xui.IsB4A Or xui.IsB4i                               '<– this is harcoded and reason of removing title  
    CustomListView1.AsView.Color = xui.Color_Transparent  
    CustomListView1.sv.Color = xui.Color_Transparent  
    mBase.Color = xui.Color_Transparent  
    Sleep(20)  
    Update("", True)  
    CustomListView1.JumpToItem(0)  
    SearchField.Text = ""  
    SearchField.TextField.RequestFocus  
    #if B4A  
'    IME.ShowKeyboard(SearchField.TextField)                        '<– auto opened keyboard unnecessarily hides half of small list  
    #end if  
End Sub
```

  
   
Then the code in 'B4XMainPage.bas' does not require and special code for title and the original .bal file remains as it is.  

```B4X
Private Sub Button1_Click  
    B4XDialog1.Title = "Tittle"  
    B4XDialog1.TitleBarHeight = 80  
     
    B4XSearchTemplate1.Resize(90%x, 80%y)                                  ' No problem in resize with whatever size required  
    Wait For (B4XDialog1.ShowTemplate(B4XSearchTemplate1, "", "", "Close")) Complete (Result As Int)  
    If Result = xui.DialogResponse_Positive Then  
        Log(B4XSearchTemplate1.SelectedItem)  
    End If     
     
End Sub
```

  
   
![](https://www.b4x.com/android/forum/attachments/125381)  
  
Since this requires changes in bas file so I wish Erel to give options to disable them, keep it true by default.  
We can change nearly all aspects of B4XSearchTemplate, except these two. So giving options for them is easier than making changes by programmer in .bas file.  
Hope he grants our wish, when he is free.  
  
Also attached the full project.