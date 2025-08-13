### Programaticaly suppress divider in customlistview by Alain75
### 05/26/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/148157/)

Hi everybody  
  
I wasted time unsuccessfully to suppress divider seted in designer for customlistview : I wanted the last items to be without. And finally the solution is quite simple. As I am not the only one to search for, here are the 2 «magic» lines where clv is the name of your customlistview of course :  

```B4X
… Just after having added a new item…  
clv.GetPanel(clv.Size-1).Parent.Top    = clv.GetPanel(clv.Size-1).Parent.Top - 1dip  
clv.GetPanel(clv.Size-1).Parent.Height = clv.GetPanel(clv.Size-1).Parent.Height + 1dip
```

  
Just change the value **1dip** with the height of your divider set in designer