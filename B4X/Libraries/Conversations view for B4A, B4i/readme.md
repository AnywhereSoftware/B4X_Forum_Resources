### Conversations view for B4A, B4i by John Naylor
### 08/02/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/149365/)

Provides a view to display a conversations panel like various messenger systems.  
  
Add/update messages, avatars or automatic initials, long press to select conversation(s), preview latest message option, number of unread messages view, modify colours, borders etc etc.  
  
Demo is straight forward.  
  
![](https://www.b4x.com/android/forum/attachments/144335)  
  
[HEADING=2]**Events:**[/HEADING]  
**PreviewConversation**(conv As convoEntry)  
**OpenConversation**(conv As convoEntry)  
**EditContact**(id As string)  
**DeleteConversations**(ids As list)  
  
[HEADING=2]**Methods:**[/HEADING]  
**UpdateConversation**(id As String, WithWho As String, dt As Long, UnreadCount As Int, avImg As B4XBitmap) As Boolean  
**SetMessagePreview**(id As String, previewText As String)  
**RemoveConversation**(id As String)