### [MinimaList] Player Scoreboard by aeric
### 11/14/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/164122/)

![](https://www.b4x.com/android/forum/attachments/158593)  
This example is a response to [this thread](https://www.b4x.com/android/forum/threads/mind-as-crumbled-need-to-find-the-easiest-way-to-get-winning-player.164073/#post-1006470).  
  
You can click the labels to edit Player's name and score.  
The results will be showed after click on OK.  
  
Player's name cannot be empty.  
Player's score only allow positive numbers.  
If all players' score are same then there is no winner.  
  
Note: If more than 1 winners then only show 1 winner (previously set).  
  
Take note on the Label's **Tag** and **Event Name** in Layout Designer.  
  
MinimaList internally assign an incremental id to the Map item when it is added which can be use to Find it.  
E.g  

```B4X
AllPlayers.Find(lbl.Tag).Put("Name", Name)
```

  
This means when a user click on a label with Tag = 3 then it finds for item with id = 3 inside AllPlayers and update the Name.