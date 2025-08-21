### AXEmojiView by User242424
### 08/17/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/121321/)

***[SIZE=6]Hello World![/SIZE]***  
  

**AXEmojiView** is an advanced Android Library   
which adds emoji,sticker,… support to your Android application ?   
[Demo](https://github.com/Aghajari/AXEmojiView/blob/master/README.md#download-apk) • [GitHub](https://github.com/Aghajari/AXEmojiView)  
![](https://raw.githubusercontent.com/Aghajari/AXEmojiView/master/images/header.png)

  
[SIZE=7]**AXEmojiView 1.2.0  
Screenshots :  
  
![](https://raw.githubusercontent.com/Aghajari/AXEmojiView/master/images/main.png)** [/SIZE] ![](https://raw.githubusercontent.com/Aghajari/AXEmojiView/master/images/dark.png)  
  
[SIZE=7]**Usage**[/SIZE]  
  
[SIZE=6]**Install Emoji Provider**[/SIZE]  
First step, you should install EmojiView with your EmojiProvider!   

```B4X
Dim EmojiManager As AX_EmojiManager  
Dim Provider As AX_IOSEmojiProvider  
Provider.Initialize  
EmojiManager.Install(Provider)
```

  
  
[SIZE=5]**Custom Emoji Provider**[/SIZE]  
  
If you wanna display your own Emojis you can create your own implementation of EmojiProvider and pass it to AXEmojiManager.install.  
  
  
[![](https://github.com/Aghajari/AXEmojiView/raw/master/images/google.jpg)](https://github.com/Aghajari/AXEmojiView/blob/master/images/google.jpg) [![](https://github.com/Aghajari/AXEmojiView/raw/master/images/Twitter.jpg)](https://github.com/Aghajari/AXEmojiView/blob/master/images/Twitter.jpg) [![](https://github.com/Aghajari/AXEmojiView/raw/master/images/one.jpg)](https://github.com/Aghajari/AXEmojiView/blob/master/images/one.jpg)  
  
[SIZE=6]**Basic Usage**[/SIZE]  
  
Create an AXEmojiEditText in your layout.  
  
you should create a Page. Current pages are :  

- EmojiView
- SingleEmojiView
- StickerView

Let's try EmojiView first :  

```B4X
Dim EmojiView As AX_EmojiView  
EmojiView.Initialize("Amir")  
EmojiView.EditText = YourEditText
```

  
  
And add this page to AXEmojiPopup :  

```B4X
Dim EmojiPopup As AXEmojiPopup  
EmojiPopup.Initialize(EmojiView,"Amir")  
  
EmojiPopup.Toggle ' Toggles visibility of the Popup.  
EmojiPopup.Show ' Shows the Popup.  
EmojiPopup.Dismiss ' Dismisses the Popup.  
EmojiPopup.IsShowing ' Returns true when Popup is showing.
```

  
  
And we are done! ? Result :  
  
[![](https://github.com/Aghajari/AXEmojiView/raw/master/images/ios.jpg)](https://github.com/Aghajari/AXEmojiView/blob/master/images/ios.jpg)  
  
[SIZE=5]**AXEmojiPopupLayout**[/SIZE]  
  
you can also create an AXEmojiPopupLayout instead of AXEmojiPopup! i believe that AXEmojiPopupLayout has a better performance.  
  
  

1. create an AXEmojiPopupLayout in your layout. (Using FrameLayout - See Sample Code)

1. add the created page to AXEmojiPopupLayout.

```B4X
Layout.InitPopupView(EmojiView)  
  
Layout.Toggle ' Toggles visibility of the Popup.  
Layout.Show ' Shows the Popup.  
Layout.Dismiss ' Dismisses the Popup.  
Layout.HideAndOpenKeyboard ' Hides the popup  
Layout.IsShowing ' Returns true when Popup is showing.
```

  
  
Result is just same as AXEmojiPopup result!  
  
[SIZE=5]**Single Emoji View**[/SIZE]  
  
SingleEmojiView is a RecyclerView and all emojis will load in one page (Same As Telegram Inc)  

```B4X
Dim SingleEmojiView As AX_SingleEmojiView  
SingleEmojiView.Initialize("")  
SingleEmojiView.EditText = YourEditText
```

  
  
Result :  
  
[![](https://github.com/Aghajari/AXEmojiView/raw/master/images/SingleEmojiView.png)](https://github.com/Aghajari/AXEmojiView/blob/master/images/SingleEmojiView.png)  
  
[SIZE=5]**StickerView**[/SIZE]  
  
StickerView : you have to create your StickerProvider and load all your Stickers (from Url,Res,Bitmap or anything you want!) see example  

```B4X
Dim StickerView As AX_StickerView  
Dim StickerProvider As MyStickerProvider  
StickerProvider.Initialize  
StickerView.Initialize("Sticker","Stickers",StickerProvider.Provider)
```

  
  
Result :  
  
[![](https://github.com/Aghajari/AXEmojiView/raw/master/images/sticker.png)](https://github.com/Aghajari/AXEmojiView/blob/master/images/sticker.png)  
  
  
Also you can create your custom pages in StickerProvider . see example : ShopStickers  
  
Result :  
  
[![](https://github.com/Aghajari/AXEmojiView/raw/master/images/shop_sticker.png)](https://github.com/Aghajari/AXEmojiView/blob/master/images/shop_sticker.png)  
  
[SIZE=6]**AXEmojiPager - Use Multiple Pages Together!**[/SIZE]  
  
you can create an AXEmojiPager and add all your pages (EmojiView,StickerView,…) to the EmojiPager  
  
Result :  
  
[![](https://github.com/Aghajari/AXEmojiView/raw/master/images/emojipager.png)](https://github.com/Aghajari/AXEmojiView/blob/master/images/emojipager.png)  
  
[SIZE=5]**Create Your Custom Pages**[/SIZE]  
  
Create an AXEmojiBase (ViewGroup) and load your page layout And add your CustomPage to emojiPager  
  
Result :  
[![](https://github.com/Aghajari/AXEmojiView/raw/master/images/loading.png)](https://github.com/Aghajari/AXEmojiView/blob/master/images/loading.png)  
  
[SIZE=6]**Customization**[/SIZE]  
  
Customize theme with AXEmojiTheme.  

```B4X
EmojiManager.EmojiViewTheme.FooterEnabled = true  
EmojiManager.EmojiViewTheme.SelectionColor = 0xFFFF4081  
EmojiManager.EmojiViewTheme.FooterSelectedItemColor = 0xFFFF4081  
EmojiManager.EmojiViewTheme.SelectionColor = Colors.Transparent  
EmojiManager.EmojiViewTheme.SelectedColor = 0xFFFF4081  
EmojiManager.EmojiViewTheme.CategoryColor = Colors.White  
EmojiManager.EmojiViewTheme.FooterBackgroundColor = Colors.White  
EmojiManager.EmojiViewTheme.AlwaysShowDivider = True  
          
EmojiManager.StickerViewTheme.SelectionColor = 0xFFFF4081  
EmojiManager.StickerViewTheme.SelectedColor = 0xFFFF4081  
EmojiManager.StickerViewTheme.CategoryColor = Colors.White  
EmojiManager.StickerViewTheme.AlwaysShowDivider = True
```

  
  
Result :  
  
[![](https://github.com/Aghajari/AXEmojiView/raw/master/images/theme.png)](https://github.com/Aghajari/AXEmojiView/blob/master/images/theme.png)  
  
[SIZE=5]**Custom Footer**[/SIZE]  
  
Result :  
[![](https://github.com/Aghajari/AXEmojiView/raw/master/images/custom_footer_1.png)](https://github.com/Aghajari/AXEmojiView/blob/master/images/custom_footer_1.png) [![](https://github.com/Aghajari/AXEmojiView/raw/master/images/custom_footer_2.png)](https://github.com/Aghajari/AXEmojiView/blob/master/images/custom_footer_2.png)  
  
[SIZE=5]**DarkMode**[/SIZE]  
  
[![](https://github.com/Aghajari/AXEmojiView/raw/master/images/dark1.png)](https://github.com/Aghajari/AXEmojiView/blob/master/images/dark1.png) [![](https://github.com/Aghajari/AXEmojiView/raw/master/images/dark2.png)](https://github.com/Aghajari/AXEmojiView/blob/master/images/dark2.png)   
  
[SIZE=6]**Views**[/SIZE]  

- AXEmojiPopupLayout
- AXEmojiBase / AXEmojiLayout
- AXEmojiView
- AXSingleEmojiView
- AXStickerView
- AXEmojiEditText
- AXEmojiMultiAutoCompleteTextView
- AXEmojiButton
- AXEmojiImageView
- AXEmojiTextView
- AXEmojiCheckBox

  
[SIZE=6]**Replace String With Emojis**[/SIZE]  
![](https://raw.githubusercontent.com/Aghajari/AXEmojiView/master/images/actionbar.jpg)  
  
[SIZE=6]**RecentManager And VariantManager**[/SIZE]  
  
you can add your custom recentManager for emojis and stickers . implements to RecentEmoji/RecentSticker  
  
[SIZE=6]**Variant View**[/SIZE]  
you can also create your own VariantPopupView ! but you don't need to, the default one is also nice :)  
  
The Default Variant:  
  
![](https://raw.githubusercontent.com/Aghajari/AXEmojiView/master/images/variants.png)  
  
[[SIZE=7]**Download Lib+Sample** [/SIZE]](https://www.dropbox.com/s/3by0a6pr5zylzgv/ax_emojiview.zip?dl=0)  
FileSize : 6MB  
[[SIZE=7]See more in GitHub[/SIZE]](https://github.com/Aghajari/AXEmojiView)