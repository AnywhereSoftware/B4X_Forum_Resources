###  [XUI] AS FeatureRequest [Payware] by Alexander Stolte
### 11/28/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/163524/)

AS FeatureRequest is a lightweight, easy-to-integrate library that allows you to present a list of potential features to your users, enabling them to vote on the ones they find most valuable. By collecting and prioritizing user feedback, you can accelerate the development of the most desired features. The library is flexible and can be connected to your own backend.  
  
This library is **not free**, because, it cost a lot of time and gray hair to create such views.  
<https://payhip.com/b/YeGOL>  
Thanks for your understanding. :)  
  
![](https://www.b4x.com/android/forum/attachments/157617) ![](https://www.b4x.com/android/forum/attachments/157618) ![](https://www.b4x.com/android/forum/attachments/157620)  
  
**Libraries that are needed:**  

- [AS\_AnimatedCounter](https://www.b4x.com/android/forum/threads/b4x-xui-as-animatedcounter-negative-and-positive-numbers.98107/#content) V2.0+
- [AS\_ScrollingChips](https://www.b4x.com/android/forum/threads/b4x-xui-as-scrollingchips-based-on-xcustomlistview-display-your-hashtags-or-categories.123425/)

**Examples**  

```B4X
AS_FeatureRequest1.AddItem("Feature #1","Feature Description #1",Null,AS_FeatureRequest1.UserVoteStatus_None,0,"RowId")  
AS_FeatureRequest1.AddItem("Feature #2","Feature Description #2",Null,AS_FeatureRequest1.UserVoteStatus_Upvoted,5,"RowId")  
AS_FeatureRequest1.AddItem("Feature #3","Feature Description #3",Null,AS_FeatureRequest1.UserVoteStatus_Downvoted,-10,"RowId")
```

  
  
**Chips**  
![](https://www.b4x.com/android/forum/attachments/157619)  
Chips can show the user whether it is a premium feature, for example, or how far along the development of this feature is. Any number of chips can be added.  
  
3 Ways to add chips:  

```B4X
AS_FeatureRequest1.AddItem("Feature #1","Feature Description #1",Array As String("Chip1","Chip2","Chip3"),AS_FeatureRequest1.UserVoteStatus_None,0,"RowId")
```

  

```B4X
Dim lstChips As List  
lstChips.Initialize  
lstChips.Add(AS_FeatureRequest1.CreateItemChip("Chip1",xui.Color_Magenta,xui.Color_White))  
lstChips.Add(AS_FeatureRequest1.CreateItemChip("Chip2",xui.Color_Magenta,xui.Color_Black))  
lstChips.Add(AS_FeatureRequest1.CreateItemChip("Chip3",xui.Color_Blue,xui.Color_White))  
   
AS_FeatureRequest1.AddItem("Feature #2","Feature Description #2",lstChips,AS_FeatureRequest1.UserVoteStatus_None,0,"RowId")
```

  

```B4X
Dim lstChips As List  
lstChips.Initialize  
lstChips.Add(AS_FeatureRequest1.CreateItemChip("Chip1",xui.Color_Magenta,xui.Color_White))  
lstChips.Add("Chip2")  
lstChips.Add("Chip3")  
   
AS_FeatureRequest1.AddItem("Feature #3","Feature Description #3",lstChips,AS_FeatureRequest1.UserVoteStatus_None,0,"RowId")
```

  
  
**Dark and Light mode**  
There is a built-in light and dark mode that can be changed smoothly on the fly.  

```B4X
AS_FeatureRequest1.Theme = AS_FeatureRequest1.Theme_Dark
```

  

```B4X
AS_FeatureRequest1.Theme = AS_FeatureRequest1.Theme_Light
```

  
  
**Backend examples**  
<https://www.b4x.com/android/forum/threads/b4x-as-featurerequest-supabase-as-backend.163525/>  
  
**Loading Indicator**  

```B4X
AS_FeatureRequest1.ShowLoadingIndicator  
Sleep(4000)  
AS_FeatureRequest1.HideLoadingIndicator
```

  
![](https://www.b4x.com/android/forum/attachments/157678)  
**Approved and implemented requests Example**  
  
![](https://www.b4x.com/android/forum/attachments/158246)  
<https://www.b4x.com/android/forum/threads/b4x-as-featurerequest-approved-and-implemented-requests.163905/>  
  
**AS\_FeatureRequestSFloatingActionButton  
Author: Alexander Stolte  
Version: 1.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **AS\_FeatureRequest**

- **Events:**

- **Voted** (isUpvote As Boolean, Value As Object)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddItem** (Title As String, Description As String, ItemChips As List, UserVoteStatus As String, VoteCount As Int, Value As Object) As AS\_FeatureRequest\_Item
*ItemChips - List of AS\_FeatureRequest\_ItemChip or a list of string  
 UserVoteStatus - None, Upvoted or Downvoted*- **Class\_Globals** As String
- **Clear** As String
*Clears the list*- **CreateItemChip** (Text As String, BackgroundColor As Int, TextColor As Int) As AS\_FeatureRequest\_ItemChip
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getBackgroundColor** As Int
- **getCardBackgroundColor** As Int
- **getDescriptionTextColor** As Int
- **getHapticFeedback** As Boolean
- **getTheme\_Dark** As AS\_FeatureRequest\_Theme
- **getTheme\_Light** As AS\_FeatureRequest\_Theme
- **getThemeChangeTransition** As String
- **getTitleTextColor** As Int
- **getVoteButtonActiveColor** As Int
- **getVoteButtonDeactiveColor** As Int
- **getVoteCountTextColor** As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Refresh** As String
*Creates the item layouts new*- **setBackgroundColor** (BackgroundColor As Int) As String
 *BackgroundColor Property*- **setCardBackgroundColor** (CardBackgroundColor As Int) As String
 *CardBackgroundColor Property*- **setDescriptionTextColor** (DescriptionTextColor As Int) As String
 *DescriptionTextColor Property*- **setHapticFeedback** (HapticFeedback As Boolean) As String
*Haptic feedback for upvote or downvote button press*- **setTheme** (Theme As AS\_FeatureRequest\_Theme)
- **setThemeChangeTransition** (ThemeChangeTransition As String) As String
 *ThemeChangeTransition Property*- **setTitleTextColor** (TitleTextColor As Int) As String
 *TitleTextColor Property*- **setVoteButtonActiveColor** (VoteButtonActiveColor As Int) As String
 *VoteButtonActiveColor Property*- **setVoteButtonDeactiveColor** (VoteButtonDeactiveColor As Int) As String
 *VoteButtonDeactiveColor Property*- **setVoteCountTextColor** (VoteCountTextColor As Int) As String
 *VoteCountTextColor Property*- **UserVoteStatus2Text** (VoteStatus As Int) As String
*-1 = None  
 0 = Downvoted  
 1 = Upvoted*- **UserVoteStatus\_Downvoted** As String
- **UserVoteStatus\_None** As String
- **UserVoteStatus\_Upvoted** As String

- **Properties:**

- **BackgroundColor** As Int
 *BackgroundColor Property*- **CardBackgroundColor** As Int
 *CardBackgroundColor Property*- **DescriptionTextColor** As Int
 *DescriptionTextColor Property*- **HapticFeedback** As Boolean
*Haptic feedback for upvote or downvote button press*- **Theme**
- **Theme\_Dark** As AS\_FeatureRequest\_Theme [read only]
- **Theme\_Light** As AS\_FeatureRequest\_Theme [read only]
- **ThemeChangeTransition** As String
 *ThemeChangeTransition Property*- **TitleTextColor** As Int
 *TitleTextColor Property*- **VoteButtonActiveColor** As Int
 *VoteButtonActiveColor Property*- **VoteButtonDeactiveColor** As Int
 *VoteButtonDeactiveColor Property*- **VoteCountTextColor** As Int
 *VoteCountTextColor Property*
- **AS\_FeatureRequest\_Item**

- **Fields:**

- **Description** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ItemChips** As List
- **Title** As String
- **UserVoteStatus** As String
- **Value** As Object
- **VoteCount** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_FeatureRequest\_ItemChip**

- **Fields:**

- **BackgroundColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Text** As String
- **TextColor** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_FeatureRequest\_Theme**

- **Fields:**

- **BackgroundColor** As Int
- **CardBackgroundColor** As Int
- **ChipBackgroundColor** As Int
- **ChipTextColor** As Int
- **DescriptionTextColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TitleTextColor** As Int
- **VoteButtonActiveColor** As Int
- **VoteButtonDeactiveColor** As Int
- **VoteCountTextColor** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
[/SPOILER]  
**Changelog**  

- **1.00**

- Release

- **1.01**

- Add ShowLoadingIndicator
- Add HideLoadingIndicator
- Add Designer Property LoadingIndicatorColor

- Default: Black

- **1.02**

- Add get Size - Returns the number of items
- Add Designer Property CanUpVote

- Default: True

- **1.03**

- The title can now also be multline text

Have Fun :)  
<https://payhip.com/b/YeGOL>