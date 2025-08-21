### B4XTable Tricks by William Lancee
### 02/19/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/114134/)

Recently I started to use B4XTable and required some modification. I searched the Forum and found quite a few solutions.  
However there were still some things I needed change. I found them tricky and I thought I would share my experience.  
  

```B4X
'Customize tricky elements of B4XTable1: Dim B4XTable1 as B4XTable  
Sleep(0)    'To allow B4XTable1 to be ready  
    
'1) Find navigation panel and switch positions with search filed   
Dim pnlNav As B4XView = B4XTable1.lblNumber.Parent  
pnlNav.Left = 80%x  
pnlNav.Top = -5  
B4XTable1.SearchField.mBase.left = 0  
  
'2) Add click event to page number, the pageButton event will open a dialog    to specify a target page  
'       (you need to add a B4XDialog and set B4XTable1.CurrentPage = InputTemplate.Text)  
Dim pageButton As Button  
pageButton.Initialize("pageButton")  
pageButton.Color = xui.Color_Transparent    'Transparent button fits exactly over Number label  
pnlNav.AddView(pageButton, B4XTable1.lblNumber.Left, B4XTable1.lblNumber.Top, _  
                B4XTable1.lblNumber.Width, B4XTable1.lblNumber.Height)  
  
Edit: B4XTable V1.18 released - lblSort (sort arrow) is now public.  
'3) Change color of sort direction icon which is not added to the panel until  
'   panel is clicked - this is a workaround and there might be better ways  
'Go to internal libraries, unzip B4XTable, extract B4XTable.bas and B4XTable.bal (in Files)  
'Copy B4XTable.bal to project Files and B4XTable.bas to project root folder  
'Disable the B4XTable library reference, add existing module B4XTable.bas to project  
'Change Private lblSort to Public lblSort to expose this label in order to set its colors  
B4XTable1.lblSort.TextColor = xui.Color_Black  
  
'4) Light theme for search field  
B4XTable1.SearchField.mBase.Color = xui.Color_White  
B4XTable1.SearchField.TextField.TextColor = xui.Color_Black  
B4XTable1.SearchField.TextField.TextSize = 20   
B4XTable1.SearchField.lblClear.TextColor = xui.Color_Black  
B4XTable1.SearchField.lblV.TextColor = xui.Color_Black
```

  
  
![](https://www.b4x.com/android/forum/attachments/88889)