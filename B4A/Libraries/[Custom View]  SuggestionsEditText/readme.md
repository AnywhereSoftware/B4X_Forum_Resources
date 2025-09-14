### [Custom View]  SuggestionsEditText by LucaMs
### 09/12/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/77776/)

[UPDATE V. 2.2 09/12/2025]  
So many unnecessary (old) file attachments! Just download the latest one, SuggestionEditText\_2\_2.zip  
This new version has just one new feature, based on [this request](https://www.b4x.com/android/forum/threads/autocomplete-edittext.168611/post-1033568).  
It's easier to press "Enter" on the virtual keyboard; it already had the same effect.  
Added ConfirmWord method.  
  
  
I needed an EditText like [SearchView](https://www.b4x.com/android/forum/threads/large-searchable-list-with-searchview-b4xserializator.61872/#content) but without the list shown (without ListView), to use it on a smartphone in landscape mode (you know, in this situation the keyboard takes up almost the available space).  
  
This view uses a SQLite DB to store the words and to retrieve them typing the first characters.  
  
To be able to delete all the old and unneeded db files, you must call the DeleteAllWordsDBs method once, before doing anything else with the custom view. With this method you also set the DB's directory.  
  
After this, you must initialize the SuggestionsEditText DB calling its method InitWordsDB.  
  
  
I'll update soon this post with details about methods and properties ;) but they are documented and easy to understand.  
  
Don't forget that this is a TOTALLY FREE library, so… don't be too bad with your comments and too stingy to click on "Like" :D  
  
  
![](https://www.b4x.com/android/forum/attachments/54144)  
  
**Members**: <https://www.b4x.com/android/forum/threads/custom-view-suggestionsedittext.77776/#post-493565>  
  
  
**Added V. 1.1**  
  
 **Method: InitWordsDB2(SuggET As SuggestionsEditText)**  
 To use the same DB of another SuggestionsEditText view.  
  
 **Property: DB**  
 To get the words DB associated.  
  
  
  
**Added V. 1.3**  
  
 **Method: AddAllAsync (lstWords As List)**  
  
 **Properties: HintText, KBSuggestions**  
  
 **Event:** **AddAllAsyncComplete  
  
  
  
Version 2.0  
  
Previous versions use internally:**  
**<https://developer.android.com/reference/android/view/inputmethod/EditorInfo.html#IME_FLAG_NO_EXTRACT_UI>**  
  
**![](https://www.b4x.com/android/forum/attachments/54630)**  
  
  
**I saw this now only, so v. 2.0 uses:**  
  
**![](https://www.b4x.com/android/forum/attachments/54631)**  
  
**[Note that IME\_FLAG\_NO\_FULLSCREEN needs API 11 and above]  
  
Also, added:**  
  
****Property: KBFullScreen****