###  [XUI] AS Swipe Card - a tinder like swipeable card view [Payware] by Alexander Stolte
### 04/02/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/117415/)

Hello Community,  
  
This library is **not free**, because, it cost a lot of time and gray hair to create such views.  
<https://payhip.com/b/ma7bR>  
Thanks for your understanding. :)  
  
This library is compatible and tested with **B4A**,**B4I** and **B4J**!  
If you have bugs or a wish then tell me it in the comments.  
  
**Features**  

- cross-platform compatible
- enable or disable events
- add and remove cards
- scroll to cards
- animations
- swipe with fingers
- and more…

![](https://www.b4x.com/android/forum/attachments/sc_1-gif.92818/)![](https://www.b4x.com/android/forum/attachments/sc_2-gif.92819/)![](https://www.b4x.com/android/forum/attachments/93452)  
  
On B4J and B4I you need a base panel, only this way the events can be triggered by your other control elements, see the example projects to learn more.  
  
**ASSwipeCard  
Author: Alexander Stolte  
Version: 2.00**  

- **ASSwipeCard**

- **Events:**

- **BaseResize** (Width As Double, Height As Double)
- **IndexChanged** (index As Int)
- **LazyLoadingAddContent** (Parent As B4XView, Value As Object)
- **ReachEnd**
- **SwipeStateChange** (state As Int)
- **SwipeStateChanged** (state As Int)

- **Functions:**

- **AddCard** (xpnl As B4XView, Tag As Object) As String
- **Base\_Resize** (Width As Double, Height As Double) As String
- **Class\_Globals** As String
- **Clear** As String
*Clears all cards*- **Commit** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getBase** As B4XView
- **GetCard** (Index As Int) As B4XView
- **getCardBackground** As B4XView
- **getCurrentIndex** As Int
- **getLazyLoadingExtraSize** As Int
- **getSize** As Int
- **getTag** (Index As Int) As Object
- **IniParent** (parent As B4XView) As String
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NextCard** (swipe\_state As Int)
- **PreviousCard** (swipe\_state As Int)
- **RemoveCard** (Index As Int) As String
- **setCurrentIndex** (index As Int) As String
- **setLazyLoadingExtraSize** (ExtraSize As Int) As String
- **SwipeState\_BOTTOM** As Int
- **SwipeState\_LEFT** As Int
- **SwipeState\_NEUTRAL** As Int
- **SwipeState\_RIGHT** As Int
- **SwipeState\_TOP** As Int
- **SwipeStateRandom** As Int

- **Properties:**

- **Base** As B4XView [read only]
- **CardBackground** As B4XView [read only]
- **CurrentIndex** As Int
- **LazyLoadingExtraSize** As Int
- **Size** As Int [read only]

- **SwipeCardItems**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Tag** As Object
- **xpnl\_cardbase** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
**Changelog**  

- **1.00**

- Release

- **1.01**

- Add Designer Property: EnableLeftRightSwipe -Enabled or Disabled the swipe gesture for left and right swiping
- Add Designer Property: EnableTopBottomSwipe -Enabled or Disabled the swipe gesture for top and bottom swiping

- **1.02**

- Add Event "SwipeStateChange" - Triggers when the card is moved with the finger in one direction e.g. LEFT,RIGHT,TOP,BOTTOM or NEUTRAL
- Event "SwipeStateChanged" - Triggers now only when the user has released the card
- Add Clear - clears all cards

- **1.03**

- get CurrentIndex is now readable

- **1.04**

- Add Designer Properties - If true then the previous card is shown as next card if you swipe in the right direction

- SwipeLeft2Previous
- SwipeRight2Previous
- SwipeTop2Previous
- SwipeBottom2Previous

- **1.05**

- BugFixes for the Features of V1.04

- **1.06**

- BugFix

- **1.07**

- BugFix

- **1.08**

- Add Designer Property Rotation - activates or deactivates the rotation during the movement

- Default: True

- **1.09**

- BugFixes

- **1.10**

- Designer BugFixes

- **1.11**

- BugFixes
- Base\_Resize is now Public

- **2.00**

- Add Designer Property LazyLoading - activates lazy loading

- Default: False

- Add Designer Property LazyLoadingExtraSize - How many pages to load in advance

- Default: 5

- Add Event LazyLoadingAddContent - Add here your layout or views
- Add get and set LazyLoadingExtraSize
- Add Commit - Triggers the LazyLoadingAddContent event

- Call this after you have added the cards

Have Fun :)  
[USER=102342]@Alexander Stolte[/USER]  
<https://payhip.com/b/ma7bR>