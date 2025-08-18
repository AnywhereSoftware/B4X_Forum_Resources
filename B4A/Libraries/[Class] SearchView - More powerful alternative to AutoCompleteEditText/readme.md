### [Class] SearchView - More powerful alternative to AutoCompleteEditText by Erel
### 09/30/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/19379/)

**Edit: better to use B4XDialog + B4XSearchTemplate**  
  
SearchView is made of an EditText and ListView. When the user enters text into the EditText the ListView shows the items that start with this text or that contain the text (in this order).  
  
This view is useful for allowing the user to select an item from many items.  
  
Advantages over AutoCompleteEditText:  

- SearchView uses an internal index that is built when you call SetItems. This allows it to quickly find the matches.
- SearchView also shows items that contain the input text (not just prefixes).
- The class code can be further customized as needed.

  
![](https://www.b4x.com/android/forum/attachments/53072)  
  
Tutorial about handling large, searchable lists: <https://www.b4x.com/android/forum/threads/large-searchable-list-with-searchview-b4xserializator.61872/>