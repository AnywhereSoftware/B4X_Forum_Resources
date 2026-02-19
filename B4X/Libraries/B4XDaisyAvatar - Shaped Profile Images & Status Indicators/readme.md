###  B4XDaisyAvatar - Shaped Profile Images & Status Indicators by Mashiane
### 02/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170347/)

Hi Fam  
  
I am pleased to introduce **B4XDaisyAvatar**, a versatile image component part of the **B4X Daisy UI Kit** series.  
  
Inspired by the DaisyUI avatar utility, this component simplifies the creation of user profile pictures. It handles complex shape masking, status indicators (online/offline), and border rings automatically, drawing directly to a native canvas for high performance.  
  
![](https://www.b4x.com/android/forum/attachments/169976) ![](https://www.b4x.com/android/forum/attachments/169977)  
  
**The "Glue": B4XDaisyVariants** B4XDaisyAvatar is heavily powered by **B4XDaisyVariants**. The variants module calculates the complex geometry for shapes like Squircles and Hexagons and resolves abstract size tokens (e.g., "12" or "20") into native dip values.  
  
🌟 Key Features  
• **Shape Masks:** Supports over 20 built-in shapes including circle, squircle, hexagon, heart, star, and decagon.  
• **Status Indicators:** Built-in "Online" (green dot) and "Offline" modes. The component automatically draws the status dot and a contrasting ring border around the avatar.  
• **Smart Cropping:** Implements "Object-Fit: Cover" logic to ensure images fill the shape without distortion.  
• **Theme Aware:** Can derive ring and status colors from your app's semantic palette (Primary, Secondary, Accent, etc.).  
  
🛠 Dependencies  
1. **B4XDaisyVariants.bas** (Static Code Module) - *Included in the attachment*  
**1. Designer Configuration:** Add B4XDaisyAvatar to your layout.  
• **Mask:** squircle  
• **Width/Height:** 16 (Tailwind size token)  
• **ShowOnline:** True  
  

```B4X
Sub Globals  
    Private Avatar1 As B4XDaisyAvatar  
    Private Avatar2 As B4XDaisyAvatar  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("MainLayout")  
     
    ' Set image from assets  
    Avatar1.SetAvatar("user_profile.jpg")  
     
    ' Change status to Online (shows green dot + ring)  
    Avatar1.SetStatus("online")  
     
    ' Dynamic configuration for a second avatar  
    Avatar2.SetAvatar("colleague.png")  
    Avatar2.SetAvatarMask("hexagon")  
    Avatar2.SetRingColor(xui.Color_Blue)  
    Avatar2.SetRingWidth(3dip)  
End Sub  
  
' Handle Clicks  
Sub Avatar1_AvatarClick(Payload As Object)  
    Log("User clicked avatar!")  
End Sub
```

  
  
🎨 Designer Properties  
• **Image:** Path to the image file (Assets or full path).  
• **Mask:** The shape of the avatar (circle, square, squircle, hexagon, heart, etc.).  
• **Status:** Sets the initial state (none, online, offline).  
• **ShowOnline:** Toggles the visibility of the status dot.  
• **RingWidth:** Width of the border ring (useful for separating the avatar from the background).  
• **Shadow:** Apply a drop shadow depth (xs to 2xl).  
  
**Related Content**  
  
[MEDIA=youtube]GTs4BI5HRq8[/MEDIA]