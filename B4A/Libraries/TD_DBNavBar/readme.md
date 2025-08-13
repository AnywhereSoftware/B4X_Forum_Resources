### TD_DBNavBar by Guenter Becker
### 04/29/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/166170/)

  
**Status:**  UPDATE  
**Name:** TD\_DBNavBar  
**Code:** B4A  
**Type:** b4xlib  
**Version:** 2.6  
**License**: Royalty free for personal and commercial use  
**External License:** Usage of BR\_Button (C) [USER=96517]Lucas Siqueira[/USER]   
**Author:** TechDoc G. Becker  
  
**Attached: [Download Link](https://drive.google.com/file/d/1-2x6Pw4Hn64WzrFGpRYvQHSdsLhE4OCV/view?usp=sharing)  
  
Update:**  

- **mRS** Resultset as public object added
- **mID** String as public variable added
- ID Property added to each button to hold the button name for later identification
- Some Bugfixes done

  
**TD\_DBNavBar** is a user Interface (GUI) to choose and activate datamangement functions to be needed to mange stored data in an SQLite or SQLCipher Database. The Datamangement functions are not included (except movement of cursor position). They can be taken from DBUtils or TD\_DBUtils (comming soon).  
To interact with the User the view has 2 toolbars. *BR\_Button* is used as Button View. The *BR\_Button* View Class is included.  
  
**The Datanavigation Bar**  
![](https://www.b4x.com/android/forum/attachments/163742)  
Buttons goto First, Previous, Next, Last record of the Resultset.  
At last right hand position button *Find* to position cursor by a given column value (TD\_DBUtils).  
In the middle the button *PosInfo* which displays the current cursor position (first is 1) and the row count of the selected rows in the resultset. A short click will switch the toolbar to the Database bar.  
  
**and the Databasebar.**  
![](https://www.b4x.com/android/forum/attachments/163743)  
Buttons insert, update, reload and delete. Insert, update, delete may call functions to manage the databasetable data. Button reload will be used to recall a given Select Command to reload the data from the database to the resultset.  
In the middle button *DBInfo* database information may be shown. If pressed by a long click a Dialog of all Database, Table and column details is shown (TD\_DBUtils). A short click will switch the toolbar to Datanavigation bar.  
  
Both bars are part of a customlistview. to show the desired bar you may scroll up or down as well.  
  
**Custom Properties:  
setButtonText** to set the text to the middle button.  
**markButton** to change/reset the Bordercolor of a button (except middle button)  
**KeyClick** to turn key click on/off  
  
There are some custom **Designer Properties** as well to customize the Buttons GUI.  
  
**The download link** will lead you to a google drive cloud where you can download the **example project (**b4a). Please notice that you will find the **b4xlib** in the *libs* folder.  
The example project shows all the needed steps to install and use the view.