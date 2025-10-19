###  RandomUser API - SMM + lazy loading list + DDD by Erel
### 10/15/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/169044/)

![](https://www.b4x.com/android/forum/attachments/167847)  
  
Cross platform example of showing a list of users, retrieved from <https://randomuser.me/>  
  
The API returns a list with the data of 150 random users. The list is parsed and added to a lazy loaded CLV. The images are downloaded using SMM. Note the usage of the useful DDD (<https://www.b4x.com/android/forum/threads/b4x-dse-designer-script-extensions.141312/#content>) and the call to DDD.CollectViewsData in the UserCard designer script.  
  
The list performs excellent in Release mode.  
  
The code is short and simple where the most interesting part is:  

```B4X
Private Sub CustomListView1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)  
    For i = FirstIndex To LastIndex  
        Dim pnl As B4XView = CustomListView1.GetPanel(i)  
        If pnl.NumberOfViews > 0 Then Continue  
        pnl.LoadLayout("UserCard")  
        Dim user As UserData = CustomListView1.GetValue(i)  
        dd.GetViewByName(pnl, "lblName").Text = user.Name  
        dd.GetViewByName(pnl, "lblLocation").Text = user.Location  
        dd.GetViewByName(pnl, "lblID").Text = user.Id  
        dd.GetViewByName(pnl, "lblEmail").Text = user.Email  
        dd.GetViewByName(pnl, "lblPhone").Text = user.Phone  
        smm.SetMedia(dd.GetViewByName(pnl, "pnlImage"), user.PictureUrl)  
    Next  
End Sub
```

  
  
The layout is based on [USER=27692]@yiankos1[/USER] code (<https://www.b4x.com/android/forum/threads/smm-simplemediamanager-images-disappear.169036/>)