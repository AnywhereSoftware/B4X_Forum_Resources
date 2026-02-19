###  B4XDaisyChat - Full-Featured Native Chat Engine by Mashiane
### 02/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170350/)

Hi Fam  
  
I am pleased to introduce **B4XDaisyChat**, the centerpiece of the **B4X Daisy UI Kit** series.  
  
This is a comprehensive "Controller" component that manages a scrollable list of messages. It handles the heavy lifting of chat interfaces: message alignment (Start/End), timestamp formatting, avatar caching, and dynamic updates. It relies on the internal B4XDaisyChatBubble class to draw native, vector-based speech bubbles.  
  
![](https://www.b4x.com/android/forum/attachments/169981)  
  
**The "Glue": B4XDaisyVariants** B4XDaisyChat utilizes **B4XDaisyVariants** to standardize Date/Time formats (converting "H:i" tokens to native Java formats) and to apply shape masks (like Squircles or Pentagons) to the avatars inside the chat stream.  
  
🌟 Key Features  
• **Data-Driven:** Add messages simply by passing a Map of key/value pairs (text, side, header, footer, timestamp).  
• **Smart Timestamps:** Built-in UseTimeAgo feature converts timestamps to relative text (e.g., "10m ago") for today's messages, while keeping full dates for older ones.  
• **Theming:** Includes a built-in theme engine. Easily map semantic variants (primary, neutral, success) to bubble backgrounds and text colors.  
• **Message Updates:** Supports updating specific properties of a sent message (e.g., changing status from "Sent" to "Read") by ID, without reloading the list.  
• **Native Drawing:** Bubbles are drawn using B4XCanvas paths, supporting "Rounded" or "Block" styles with vector tails.  
  
🛠 Dependencies  
1. **B4XDaisyChatBubble.bas** (Class) - *Included in attachment*  
2. **B4XDaisyAvatar.bas** (Class) - *Included in attachment*  
3. **B4XDaisyVariants.bas** (Static Code) - *Included in attachment*  
  
💻 Usage Example  
**1. Designer Configuration:** Add B4XDaisyChat to your layout.  
• **Theme:** light  
• **UseTimeAgo:** True  
• **AvatarMask:** squircle  
  

```B4X
Sub Globals  
    Private Chat As B4XDaisyChat  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("MainLayout")  
      
    ' 1. Incoming Message (Start)  
    Dim m1 As Map = CreateMap( _  
        "id": "msg_1", _  
        "text": "Hey! Did you check the new update?", _  
        "side": "start", _  
        "header": "Alice", _  
        "avatar": "alice.png", _  
        "timestamp": DateTime.Now - 300000 ' 5 mins ago _  
    )  
    Chat.AddMessage(m1, False)  
      
    ' 2. Outgoing Message (End) with Variant Color  
    Dim m2 As Map = CreateMap( _  
        "id": "msg_2", _  
        "text": "Yes, it looks amazing! I love the new bubbles.", _  
        "side": "end", _  
        "variant": "primary", _   
        "status_mode": "read", _ ' Adds checkmarks  
        "timestamp": DateTime.Now _  
    )  
    Chat.AddMessage(m2, True) ' True = Scroll to bottom  
End Sub  
  
' Handle Avatar Clicks  
Sub Chat_AvatarClick(Tag As Object)  
    Log("Clicked avatar for user: " & Tag)  
End Sub
```

  
  
  
**Related Content:**  
  
[MEDIA=youtube]LOv12F12rVM[/MEDIA]