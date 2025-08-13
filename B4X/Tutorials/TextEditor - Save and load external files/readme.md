###  TextEditor - Save and load external files by Erel
### 09/10/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/132731/)

This is a B4i and B4A example, which demonstrates various external files related tasks.  
  
![](https://www.b4x.com/android/forum/attachments/116714) ![](https://www.b4x.com/android/forum/attachments/116715)  
  
The behavior is not exactly the same as the platforms capabilities and behavior are different.  
  
B4A  

- Load external files, including online files, using ContentChooser.
- Save to an external target, using SaveAs: <https://www.b4x.com/android/forum/threads/saveas-let-the-user-select-a-target-folder-list-of-other-related-methods.129897/#content>
- Allow other apps to view text files using this app : [Receiving shared images from other apps](https://www.b4x.com/android/forum/threads/81041/#content)
- Extract information from the passed uri.

Note that no permission is needed. The minimum version was set to 7 (API 24), though it will probably work in older versions as well.  
Don't miss the manifest editor additions and ime in the main module.  
  
B4i  

- Load external files, including online files, using DocumentPickerViewController: <https://www.b4x.com/android/forum/threads/picking-external-documents-with-documentpickerviewcontroller.99365>
- Share the text with ActivityViewController: <https://www.b4x.com/android/forum/threads/share-data-from-your-app-with-activityviewcontroller.73159/#content>
This also allows saving the text with the Files app.- Allow other apps to view text files using this app: <https://www.b4x.com/android/forum/threads/open-external-files-with-your-app.50525/#content>

Don't miss the main module PListExtra attributes and OpenUrl event.  
  
A bit related B4J example: <https://www.b4x.com/android/forum/threads/class-recent-files-manager.104633/post-822842>  
  
  
**Updates:**  
  
- 9/2023 - Fixed an issue in B4A where overwriting existing files didn't trim file. Thanks [USER=112855]@noeleon[/USER] for reporting!