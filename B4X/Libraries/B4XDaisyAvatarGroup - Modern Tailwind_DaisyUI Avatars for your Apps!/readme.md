###   B4XDaisyAvatarGroup - Modern Tailwind/DaisyUI Avatars for your Apps! by Mashiane
### 02/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170402/)

Hi Fam  
  
I’m excited to share a versatile new set of UI components for your applications: **B4XDaisyAvatarGroup (uses B4XDaisyAvatar)**. If you've ever admired the sleek, responsive design of TailwindCSS and DaisyUI, you can now bring those exact styling principles straight to your B4X views!  
  
![](https://www.b4x.com/android/forum/attachments/170161) ![](https://www.b4x.com/android/forum/attachments/170162)  
  
These custom views give you an incredible amount of flexibility when designing user profiles, chat interfaces, and dashboards.  
  
**✨ Key Features:**  
• **Massive Mask Selection:** Choose from over 20 shapes for your avatar mask, including circle, squircle, rounded-full, hexagon, star, diamond, and heart.  
• **Three Content Types:** Avatars can render an image, default to an svg, or display a text placeholder. Text placeholders are perfect for user initials and auto-scale beautifully.  
• **DaisyUI/Tailwind Tokens:** Define your dimensions, padding, and margins using familiar Tailwind tokens like 10, text-sm, p-2, or explicitly using CSS pixel values.  
• **Online/Offline Status:** Easily add online or offline indicator dots. The colors can be mapped to DaisyUI variants (like success or warning) or overridden with custom hex values.  
• **Rich Borders & Shadows:** Add elevation shadows using standard Tailwind scales (sm, md, xl, etc.) and create beautiful ring borders with customizable widths and offsets.  
**👥 Grouping Avatars with B4XDaisyAvatarGroup:** You aren't just limited to single images! The B4XDaisyAvatarGroup component allows you to stack multiple avatars together.  
• **Overlap & Gap Styling:** Use spacing utilities like -space-x-6 to create overlapping avatars, or space-x-4 to add gaps.  
• **Automatic Overflow Handling:** Set a LimitTo property (for example, limit to 5 avatars). If you add more avatars than the limit allows, the component automatically creates a neat +N text placeholder pill at the end of the stack!  
  

```B4X
Dim group3 As B4XDaisyAvatarGroup  
group3.Initialize(Me, "avatar_group_mixed")  
Dim groupView3 As B4XView = group3.AddToParent(card3, 0, 0, 120dip, 120dip)  
  
' Limit the group to show only 2 user images, and an overflow placeholder  
group3.setLimitTo(2)  
  
For Each img As String In Array As String("face22.jpg", "face23.jpg", "face24.jpg")  
    Dim av As B4XDaisyAvatar  
    av.Initialize(Me, "grp_av_img")  
    av.CreateView(48dip, 48dip)  
    av.SetImage(img)  
    av.SetAvatarMask("rounded-full")  
    group3.AddAvatar(av)  
Next
```

  
  
  
[MEDIA=youtube]Gu4V24hVUuY[/MEDIA]  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>