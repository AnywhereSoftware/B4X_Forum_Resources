###  SD_ImageView by Star-Dust
### 04/05/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/105559/)

I created a custom ImageView view that allows you to upload an image from the web.  
Just pass the URL as a parameter  
***This class is B4X but does not depend on the XUI library***  
  
**NOTE**: *You can use this library for personal and commercial use. Include it in your projects.. Attention, even if it is a **B4XLib** library, it is not allowed to decompress it, modify it, change its name or redistribute it without the permission of the author  
  
**SD\_ImageView  
  
Author**: Star-Dust  
**Version**: 0.03*  

- ***SD\_ImageView***

- ***Events**:*

- *LongClick*
- *OneClick*

- ***Fields**:*

- *NatObject As ImageView*
- *Zoom As Boolean*

- ***Functions**:*

- *BringToFront*
- *DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)*
- *GetBase*
- *Initialize (Callback As Object, EventName As String)*
- *RemoveViewFromParent*
- *RequestFocus*
- *SendToBack*

- ***Properties**:*

- *Bitmap As Bitmap [write only]*
- *Enable As Boolean [write only]*
- *Gravity As Int [write only]*
- *Height As Float [write only]*
- *Left As Float [write only]*
- *PreserveRatio As Boolean [write only]*
- *Tag As Object [write only]*
- *Top As Float [write only]*
- *UrlBitmap As String [write only]*
- *Visible As Boolean [write only]*
- *Width As Float [write only]*

  
*SAMPLE  

```B4X
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Private SD_ImageView1 As SD_ImageView  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("Layout1")  
    Sleep(1000)  
    SD_ImageView1.Gravity=Gravity.FILL  
    SD_ImageView1.UrlBitmap="https://b4x-4c17.kxcdn.com/android/forum/data/avatars/l/0/1.jpg?1469350209"  
End Sub  
  
Sub SD_ImageView1_OneClick  
  
End Sub  
  
Sub SD_ImageView1_LongClick  
  
End Sub
```

  
**![](https://www.b4x.com/android/forum/attachments/80154)***