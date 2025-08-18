### TDDBUtils Functions to handle SQLite and SQLCipher by Guenter Becker
### 06/29/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/141094/)

Library: TDDBUtils.b4xlib  
Language: B4A  
Version 1.8  
**Manual: Version 1.5.2 (did some checks and improvements, added SQLCipher tutorial)**  
Status: Work in Process  
(C) This library is free for non commercial use other use see manual.  
  
New to 1.8:  

- optimized code
- fixed some errors
- Added grouping and sorting of records to select1
- Added new function 'findRecord' to return cursor position by select condition
- Updated lib attached

  
This library supports the development of database driven Application (SQLite3/SQLCipher 4) with a growing (Work in Process) list of handy functions to make developers life easier. All the functions are explained in the attached manual. The lib code is well documented. To examin or modify the code rename TDDBUtils.b4xlib to TDDBUtils.zip uncompress it and get a readable .bas file.  
  
**Please report any error or whish or proposal via a reply to this post or direct to [EMAIL]techdoc@gbecker.de[/EMAIL].**   
  
See also brand new library [extended Nativ Views](https://www.b4x.com/android/forum/threads/extended-native-views.141438/#post-896466) working well together with this library in case of development of database driven apps.  
  
List of Functions:  
  
***Manage Database***  

- OpenDB
- CloseDB
- startTransaction
- commitTransaction
- setDBcompactMode
- compactDB
- gettableNames
- getColumnsInfo
- findColumnInfo
- catch and identify SQLError

***Manage records***  

- insert
- update
- delete
- save
- select1, simple select with grouping and sorting
- select2, select spread 2 joined tables
- select3, select based on a date
- select4, report Max/Min,Avg,Sum,Count values
- dateDifference, select between 2 dates
- find a record
- checkDBNull
- checkExists

***Manage individual encryption for column values***  

- EncryptText
- DecryptText

***Manage data bound Form views:***  
supported views: EditText, Label, RadioButton, CheckBox, ImageView  

- clearViews
- Views2Columns
- Columns2Views