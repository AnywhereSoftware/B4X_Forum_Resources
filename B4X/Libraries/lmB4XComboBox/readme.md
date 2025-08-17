###  lmB4XComboBox by LucaMs
### 01/16/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/116767/)

lmB4XComboBox is a b4x library (<https://www.b4x.com/android/forum/threads/100383/#content>).  
**It works with B4A, B4J and B4i.**  
  
It is a modified version of the Erel's original B4XComboBox and allows you to store in it a value for each text item.  
Not rarely (mainly handling DB data) you need a ComboBox in which an Item is made of a display value and an associated value, i.e. a "description field" of a table and the relative primary key (usually the classic Integer ID).  
Note that the type of the values associated is **object**, not just Int; this means that you can associate any type of value to each item.  
  
**Members added to the original View:  
  
AddItem(Text As String)** - to add a single text item  
**AddItem2(Text As String, Value As Object)** - to add a single item with text and value  
**GetItems** - returns the full list of texts  
**GetItemText(Index As Int)** - returns the text of an item  
**GetItemValue(Index As Int)** - returns the value associated to an item  
**GetValues** - returns all the values associated  
**RemoveItemByIndex(Index as Int)** - removes an item  
**RemoveItemByText(Text As String)** - removes an item  
**RemoveItemByValue(Value As Object)** - removes an item  
**SetItems2(Texts As List, Values as List)** - to set all items with values  
**[SIZE=5]SetItemsFromSQLite(…) - to fill the combo from a SQLite table[/SIZE]**  
**SetValue(Index as Int, Value as Object)** - to set the value of a specific item  
  
  
B4J Example (project attached):  
![](https://www.b4x.com/android/forum/attachments/92483)  
  
To run the example project, you need to download the Chinook\_Sqlite.sqlite database from:  
<https://www.sqlitetutorial.net/sqlite-sample-database/>  
(and place it in the files folder, of course).  
  
**Version: 2.03** 01/16/2023  
Fixed: bug in RaiseEvent Sub  
  
**Version: 2.02** 07/18/2022  
Fixed: bugs related to B4I code (read from [post #32](https://www.b4x.com/android/forum/threads/b4x-lmb4xcombobox.116767/post-898851))  
  
**Version: 2.01** 06/15/2021  
Added: Method SetItems3(Data As Map)  
  
**Version: 2.00** 03/05/2021  
Fixed: a bug in InsertAt (B4A version only).  
  
**Version: 1.06** 02/11/2021  
Changed: SetItemsFromSQLiteSorted method - Added CaseSensitive parameter.  
  
**Version: 1.05** 02/06/2021  
Added: SetItemsFromSQLiteSorted method.  
  
*[I was wrong to remove the previous versions of the library, now I don't know how many times it has been downloaded ??  
However I see that so far the example has been downloaded 185 times, so I can guess that]*  
  
**Version: 1.04** 02/03/2021  
Added: InsertItemAt and InsertItemAt2 methods.  
  
**Version: 1.03** 02/03/2021  
Fixed a (small) bug.  
  
**Version: 1.02** 4/25/2020  
Ammended B4i errors (reported by [USER=95454]@Andrew (Digitwell)[/USER] ; thanks)