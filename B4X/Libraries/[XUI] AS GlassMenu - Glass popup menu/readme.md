###  [XUI] AS GlassMenu - Glass popup menu by Alexander Stolte
### 11/10/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/172532/)

This view makes it easy to add a glass popup menu to your app. Add your actions, check items or radio groups and the view takes care of the rest.  
  
Inspired by [expo-glass-custom-menu](https://github.com/rit3zh/expo-glass-custom-menu).  
  
![](https://www.b4x.com/android/forum/attachments/174770) ![](https://www.b4x.com/android/forum/attachments/174771)  
  
**You need:**  
[AS\_LiquidGlass](https://www.b4x.com/android/forum/threads/b4x-xui-as-liquidglass-cross-platform-liquid-glass-panel.172530/)  
  
**Features**  

- Written in B4X for B4A, B4i and B4J
- Easy to use - the view handles opening, closing and positioning
- Icons, subtitles, section labels and separators
- Check items and radio groups with automatic state management
- Disabled and destructive actions
- Light and dark themes
- Automatic background capture
- Custom row layouts and trigger buttons

  
**Example**  

```B4X
Private Menu As AS_GlassMenu  
  
Menu.Initialize(Me, "Menu")  
Menu.CreateViewPerCode(Root, 24dip, 24dip, 120dip, 44dip)  
Menu.TriggerText = "Options"  
Menu.AddRadioItem("grid", "Grid", "grid", "layout", True)  
Menu.AddRadioItem("list", "List", "list", "layout", False)  
Menu.AddSeparator  
Menu.AddCheckItem("favorite", "Favorite", "heart", False)  
Menu.AddAction("share", "Share", "share")  
Menu.AddDestructiveAction("delete", "Delete", "trash")  
  
Private Sub Menu_ItemClick(Index As Int, Item As AS_GlassMenu_Item)  
    Log(Item.Id)  
End Sub
```

  
  
The checked state is updated automatically. You only need the ItemClick event for your own actions.  
B4i and B4J have not yet been verified.  
  
[SPOILER="Properties, Functions, Events, etc."]  
**AS\_GlassMenu  
  
Author:** Alexander Stolte  
**Version:** 1.00  

- **AS\_GlassMenu**

- **Events:**

- **ItemClick** (Index As Int, Item As AS\_GlassMenu\_Item)
- **ItemFocusChanged** (Index As Int)
- **OpenChanged** (IsOpen As Boolean)

- **Fields:**

- **AnimationDuration** As Int
- **CloseOnOutsideTap** As Boolean
- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddAction** (Id As String, Title As String, IconName As String) As AS\_GlassMenu\_Item
*Standard action without a separate Value argument.*- **AddCheckItem** (Id As String, Title As String, IconName As String, Checked As Boolean) As AS\_GlassMenu\_Item
*Checked state toggles automatically when selected. No host refresh/state code needed.*- **AddDestructiveAction** (Id As String, Title As String, IconName As String) As AS\_GlassMenu\_Item
- **AddItem** (Id As String, Title As String, IconName As String, Value As Object) As AS\_GlassMenu\_Item
*Returns a mutable item. After editing returned fields, call RefreshMenu.*- **AddLabel** (Text As String) As String
- **AddRadioItem** (Id As String, Title As String, IconName As String, GroupId As String, Checked As Boolean) As AS\_GlassMenu\_Item
*Exactly one selected row per GroupId. Selecting a row updates its whole group.*- **AddSeparator** As String
- **Clear** As String
- **Close** As String
- **CloseImmediately** As String
*Close immediately before parent resize or page navigation; cancels pending transitions.*- **CreateTriggerButton** (Parent As B4XView, Left As Float, Top As Float, Width As Float, Height As Float) As B4XView
*Creates a dedicated touch target inside a larger custom trigger/pill.  
 Add custom artwork to this panel. With OpenOnPress=False only these subbuttons open.*- **CreateViewPerCode** (Parent As B4XView, Left As Float, Top As Float, Width As Float, Height As Float) As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
- **Dispose** As String
- **GetItem** (Index As Int) As AS\_GlassMenu\_Item
- **HandleBack** As Boolean
*For keyboard/back-button integration by the host page.*- **HandleKey** (Key As String) As Boolean
*Host keyboard integration; B4J overlay handles these automatically.*- **Initialize** (Callback As Object, EventName As String) As String
- **Refresh** As String
- **RefreshMenu** As String
*Redraw after changing item fields or MenuProperties. Geometry changes reset selection.*- **RemoveItem** (Index As Int) As String
- **Resize** (Width As Float, Height As Float) As String
- **ScrollBy** (Delta As Float) As String
- **SelectItem** (Index As Int) As String
*Selects enabled action rows only. Labels/separators count toward Index.*- **SetBackdropView** (Source As B4XView) As String
*A separate scene panel behind the trigger/menu. Never use their common ancestor.*- **SetItemCallback** (Index As Int, Callback As Object, EventName As String) As String
*The named event receives (Index As Int, Item As AS\_GlassMenu\_Item).*- **SetItemContent** (Index As Int, Content As B4XView, Height As Float) As String
*Custom content replaces the built-in icon/title/subtitle; metadata stays available.  
 The supplied panel is reparented on opening. Custom controls keep their own events.*- **SetItemIconView** (Index As Int, IconView As B4XView) As String
*Arbitrary B4X icon view, including your own SVG/image/custom control.*- **SetOverlayParent** (Parent As B4XView) As String
*Use a root panel to cover the whole page when the trigger is nested.  
 Call while closed. Anchor/source coordinates must be descendants of this parent.*- **Show** As String
- **ShowAt** (Left As Float, Top As Float, Width As Float, Height As Float) As String
*Anchor rectangle in OverlayParent coordinates. Width/height also define close origin.*- **ShowOnView** (Anchor As B4XView) As String
*Anchors to a view within OverlayParent. Its visible bounds are the morph origin.  
 Untransformed panel hierarchies are supported; scrolling offsets are not inferred.*
- **Properties:**

- **Alignment** As String
*Auto picks the near screen edge; Start/Center/End are relative to the anchor.*- **AutoBackdrop** As Boolean
- **IsOpen** As Boolean [read only]
- **ItemCount** As Int [read only]
- **MenuProperties** As AS\_GlassMenu\_MenuProperties [read only]
- **MotionProperties** As AS\_GlassMenu\_MotionProperties [read only]
- **OpenOnPress** As Boolean
- **SystemTheme** As String
*Fallback supplied by the host on B4J; Android/iOS query their system appearance.*- **Theme** As String
- **TriggerContentPanel** As B4XView [read only]
- **TriggerProperties** As AS\_GlassMenu\_TriggerProperties [read only]
- **TriggerText** As String

- **AS\_GlassMenu\_Item**

- **Fields:**

- **AccessibilityLabel** As String
- **Callback** As Object
- **CheckBehavior** As String
- **Checked** As Boolean
- **Content** As B4XView
- **ContentHeight** As Float
- **ContentWidth** As Float
- **Destructive** As Boolean
- **Enabled** As Boolean
- **EventName** As String
- **GroupId** As String
- **Icon** As B4XBitmap
- **IconName** As String
- **IconView** As B4XView
- **Id** As String
- **KeepOpen** As Boolean
- **Kind** As String
- **ShowCheck** As Boolean
- **Subtitle** As String
- **Title** As String
- **Value** As Object

- **AS\_GlassMenu\_MenuProperties**

- **Fields:**

- **BevelWidth** As Float
- **BlurRadius** As Float
- **CornerRadius** As Float
- **DestructiveColor** As Int
- **DispersionStrength** As Float
- **Gap** As Float
- **GlassTint** As Int
- **HeaderFont** As B4XFont
- **HeaderHeight** As Float
- **HighlightColor** As Int
- **IconSize** As Float
- **Margin** As Float
- **Padding** As Float
- **RefractionHeight** As Float
- **RowHeight** As Float
- **Saturation** As Float
- **SeparatorColor** As Int
- **SeparatorHeight** As Float
- **SubtitleColor** As Int
- **SubtitleFont** As B4XFont
- **SubtitleRowHeight** As Float
- **TextColor** As Int
- **TitleFont** As B4XFont
- **Width** As Float

- **AS\_GlassMenu\_MotionProperties**

- **Fields:**

- **AutoWidth** As Boolean
- **Damping** As Float
- **HighlightOpacity** As Float
- **Jelly** As Float
- **MaxWidth** As Float
- **MinWidth** As Float
- **MorphBlur** As Float
- **OverlayColor** As Int
- **ReduceMotion** As Boolean
- **Rim** As Float
- **Shine** As Float
- **Speed** As Float

- **AS\_GlassMenu\_TriggerProperties**

- **Fields:**

- **AbsorbDamping** As Float
- **AbsorbDuration** As Int
- **AccessibilityLabel** As String
- **BlurRadius** As Float
- **CornerRadius** As Float
- **Glass** As Boolean
- **GlassTint** As Int
- **Jelly** As Float
- **MorphOrigin** As String
- **RefractionHeight** As Float
- **Rim** As Float
- **Saturation** As Float
- **Shine** As Float
- **ShrinkDamping** As Float
- **ShrinkDuration** As Int
- **ShrinkScale** As Float

[/SPOILER]  
  
**Changelog**  

- **1.00**

- Release

  
Have fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)