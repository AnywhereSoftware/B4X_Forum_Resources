### [B4x] B4xListManager by stevel05
### 10/07/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/123023/)

This is a simple utility to manage a text list using XUI Views Custom Dialog. Useful for user management of options for example in a B4xComboBox or similar, or any other text list.  
  
![](https://www.b4x.com/android/forum/attachments/100813)  
  
You can pass a list from code, including an empty list. Add, remove and rename options in real time and manually order the items.  
  
**Features:** (see the example programs).  

- A callback is made to the sub {EventName}\_ReservedItem(Text As String) whenever a request to remove or edit an item is made, you can disallow the remove or edit of that item by returning True from that sub.
- The revised list is available once the dialog has closed and should be obtained using the method {B4xListManager1}.List.
- The custom dialogs are layout based, so they are straightforward to change.
- The list you pass is cloned, so it will not be changed directly by B4xListManager.

  
**DependsOn:** XUI, XUI Views  
  
**B4i:** I don't have access to B4i, but as B4xListManager uses the XUI Views framework it should work. You will have to:  

- unpack the b4xlib with a zip program
- Edit the manifest.txt file - add b4i to the supported platforms, and a B4i.DependsOn attribute
- add b4i layouts (copy and paste from the designer of b4a or b4j)
- repack the b4xlib
- **Caveat**: there may be processing issues I don't know about with B4i, but it shouldn't be difficult to resolve if there are.

  
**Usage:**  

- Download the b4xlib file and copy it to your B4x additional library directory.
- Download the example app for the platform you are interested in.

  
All the code is in the B4xlib, unpack it and change as you like.  
  
The attached examples show it's use with a B4xComboBox, but you can use it for any Text List.  
  
Let me know how you get on with it.