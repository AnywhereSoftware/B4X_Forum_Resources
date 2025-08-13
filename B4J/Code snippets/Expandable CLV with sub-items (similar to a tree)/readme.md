###   Expandable CLV with sub-items (similar to a tree) by walt61
### 10/09/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/155113/)

I needed this and didn't find an existing solution: a CLV whose items  
- can be expanded/collapsed (available in [USER=1]@Erel[/USER]'s CLVExpandable)  
- and can have sub-items that can be shown or hidden  
  
In the screenshot below, you'll see the arrows that can be used to expand/collapse, and the +/- signs to show/hide sub-items; B4A and B4J projects attached.  
  
Some notes:  
- module 'wmCLVEpandable2' is [USER=1]@Erel[/USER]'s with a couple of slight modifications  
- to avoid mysterious errors etc, do read the comments in the source code  
- I couldn't find a way to make the pane(l)s indent (spent quite some time trying to figure it out), so I worked around that by using multiple layout files  
- no external libraries required  
  
Tested with B4A and B4J, no idea what B4I would do or if it even would compile :)  
  
Enjoy !  
  
EDIT: example with a SQLite db attached, which is a lot more meaningful (thanks for asking, [USER=16350]@Mahares[/USER] )  
  
![](https://www.b4x.com/android/forum/attachments/146689)