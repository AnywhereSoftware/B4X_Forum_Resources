###  [XUI] BMPopUp v1.2 by Brian Michael
### 05/05/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/145817/)

[UPDATED V1.2]  
  
Hello everyone, it is a pleasure for me to show you my first library for B4A.  
BMPopUp is a library that will allow you to create PopUp messages in your applications. You can change the look as you like.  
  
Thanks in advance for visiting I hope you like it.  
  
  
![](https://www.b4x.com/android/forum/attachments/138726)  
  
  
Normal PopUp: PopUp With Accept Button:  
![](https://www.b4x.com/android/forum/attachments/138720)![](https://www.b4x.com/android/forum/attachments/138721)  
  
Collapsed Notification:  
![](https://www.b4x.com/android/forum/attachments/139137)  
  
Expanded Notification:  
![](https://www.b4x.com/android/forum/attachments/139138)  
  
Multiples notifications:  
  
![](https://www.b4x.com/android/forum/attachments/153447)  
  
Notification Glass Effect:  
  
![](https://www.b4x.com/android/forum/attachments/153446)  
  
  
[SPOILER="Library Reference"]  
**BMPopUp  
Version:** 1.2  

- **BMPopUp**
Events:

- **Click** (PopUp As BMPopUp)
- **Show** (PopUp As BMPopUp)
- **Hide** (PopUp As BMPopUp, Manual as Boolean) As Boolea)
- **Answer** (PopUp As BMPopUp, Answer As Int)
- **Ticks** (PopUp As BMPopUp, Ticks as Long As )
- **CustomAnimation** (PopUp As BMPopUp, Ticks as Long As )
- **Expanded** (PopUp As BMPopUp)
- **Collapsed** (PopUp As BMPopUp)
- **Click** (PopUp As BMPopUp, Btn as Button As )
- **LongClick** (PopUp As BMPopUp, Btn as Button As )
- **Click** (PopUp As BMPopUp, lbl as Label As )
- **LongClick** (PopUp As BMPopUp, lbl as Label As )
- **TextChanged** (PopUp As BMPopUp, Text as String As )
- **TextChanged** (PopUp As BMPopUp, Text as String As )
- **EnterPressed** (PopUp As BMPopUp)
- **FocusChanged** (PopUp As BMPopUp, HasChanged as Boolean As )
- Fields:
- **\_isswipeable As boolean**
- **\_mView As anywheresoftware.b4a.objects.B4XViewWrapper**
- **\_mParent As anywheresoftware.b4a.objects.ActivityWrapper**
- **\_meventname As String**
- **\_mcallback As Object**
- **\_mtag As Object**
- **\_progress As int**
- **\_iscustom As boolean**
- **\_isvisible As boolean**
- **\_isstop As boolean**
- **\_lblicon As anywheresoftware.b4a.objects.LabelWrapper**
- **\_lblcontent As anywheresoftware.b4a.objects.LabelWrapper**
- **\_lbltitle As anywheresoftware.b4a.objects.LabelWrapper**
- **\_lblclose As anywheresoftware.b4a.objects.LabelWrapper**
- **\_pnlbackground As anywheresoftware.b4a.objects.PanelWrapper**
- **\_lblaccept As anywheresoftware.b4a.objects.LabelWrapper**
- **\_lblcancel As anywheresoftware.b4a.objects.LabelWrapper**
- **\_lblneutral As anywheresoftware.b4a.objects.LabelWrapper**
- **\_swipeable\_vertical As int**
- **\_swipeable\_horizontal As int**
- **\_h\_top As int**
- **\_h\_center As int**
- **\_h\_bottom As int**
- **\_answer\_accept As int**
- **\_answer\_cancel As int**
- **\_answer\_neutral As int**
- **\_style\_normal As int**
- **\_style\_accept As int**
- **\_style\_acceptcancel As int**
- **\_style\_acceptcancelneutral As int**
- **\_style\_custom As int**
- **\_animation\_flat As int**
- **\_animation\_fadein As int**
- **\_animation\_fadeout As int**
- **\_animation\_bouncedown As int**
- **\_animation\_bounceup As int**
- **\_animation\_shake As int**
- **\_animation\_carddown As int**
- **\_animation\_cardup As int**
- **\_animation\_alert As int**
- **\_animation\_carnival As int**
- **\_animation\_smoothdown As int**
- **\_animation\_smoothup As int**
- **\_animation\_vertical As int**
- **\_animation\_verticalclose As int**
- **\_animation\_bouncein As int**
- **\_animation\_bounceout As int**
- **\_animation\_custom As int**
- **\_customviews As anywheresoftware.b4a.objects.collections.List**
- **\_isexpanded As boolean**
- **\_lst As anywheresoftware.b4a.objects.collections.List**
- Methods:
- **IsInitialized As boolean**
*Prueba si acaso el objeto ha sido inicializado.*- **\_add** (PopUp As b4a.insidecode.bmpopup) **As String**
*Add PopUp for show Multiples PopUp DropDown effect.*- **\_addbottomanchorview** (oView As anywheresoftware.b4a.objects.B4XViewWrapper) **As String**
*Only for CustomsPopUp  
 Attach a view to parent size Top-Bottom, if parent Height change, your view Height will change too.*- **\_addbottompositionviews** (oView As anywheresoftware.b4a.objects.B4XViewWrapper) **As String**
*Only for CustomsPopUp  
 Attach a view to Bottom side of a parent, if parent height change, your view top will change too.*- **\_addbutton** (EventName As String, X As int, Y As int) **As anywheresoftware.b4a.objects.ButtonWrapper**
*Create a Button and add it into the PopUp*- **\_addcentralizeview** (oView As anywheresoftware.b4a.objects.B4XViewWrapper) **As String**
- **\_addcustomview** (oView As anywheresoftware.b4a.objects.B4XViewWrapper, EventName As String, X As int, Y As int) **As anywheresoftware.b4a.objects.B4XViewWrapper**
*Create a CustomView and add it into the PopUp*- **\_addedittext** (EventName As String, X As int, Y As int) **As anywheresoftware.b4a.objects.EditTextWrapper**
*Create a ImageView and add it into the PopUp*- **\_addimageview** (EventName As String, X As int, Y As int) **As anywheresoftware.b4a.objects.ImageViewWrapper**
*Create a ImageView and add it into the PopUp*- **\_addlabel** (EventName As String, X As int, Y As int) **As anywheresoftware.b4a.objects.LabelWrapper**
*Create a Label and add it into the PopUp*- **\_addrightanchorview** (oView As anywheresoftware.b4a.objects.B4XViewWrapper) **As String**
*Only for CustomsPopUp  
 Attach a view to parent size Left-Right, if parent width change, your view width will change too.*- **\_addrightpositionviews** (oView As anywheresoftware.b4a.objects.B4XViewWrapper) **As String**
*Only for CustomsPopUp  
 Attach a view to Right side of a parent, if parent width change, your view left will change too.*- **\_border** (Radius As int, BorderWidth As int, ColorBorder As int) **As String**
*Set Custom PopUp Border*- **\_bouncein** (Duration As int) **As anywheresoftware.b4a.keywords.Common.ResumableSubWrapper**
- **\_bounceout** (Duration As int) **As anywheresoftware.b4a.keywords.Common.ResumableSubWrapper**
- **\_changesize** (Width As int, Height As int) **As String**
*Change size of a popup.  
 May use it after Show*- **\_class\_globals As String**
- **\_collapse** (Interval As int) **As anywheresoftware.b4a.keywords.Common.ResumableSubWrapper**
*Collapse the PopUp to original Height Size*- **\_converttickstoseconds** (t As long) **As int**
*Convert Milliseconds to Seconds*- **\_customanimation** (SubName As String, Interval As int) **As String**
*Set Custom PopUp Animation Sub*- **\_expand** (Cant As int, Interval As int) **As anywheresoftware.b4a.keywords.Common.ResumableSubWrapper**
*Expand the PopUp to any Height Size*- **\_fillimagetoview** (bmp As anywheresoftware.b4a.objects.B4XViewWrapper.B4XBitmapWrapper, ImageView As anywheresoftware.b4a.objects.B4XViewWrapper) **As anywheresoftware.b4a.objects.B4XViewWrapper**
- **\_fitimagetoview** (bmp As anywheresoftware.b4a.objects.B4XViewWrapper.B4XBitmapWrapper, ImageView As anywheresoftware.b4a.objects.B4XViewWrapper) **As String**
- **\_getappheader As boolean**
- **\_getbackcolor As int**
- **\_getblureffect As boolean**
- **\_getblurscale As int**
- **\_getclose As boolean**
- **\_getcustomviewbyeventname** (EventName As String) **As anywheresoftware.b4a.objects.B4XViewWrapper**
*Get a CustomView by EventName*- **\_getcustomviewbyindex** (Index As int) **As anywheresoftware.b4a.objects.B4XViewWrapper**
*Get a CustomView by Index  
 getCustomViewbyEventName(EventName As String) is better recommended*- **\_getduration As int**
- **\_getheight As int**
- **\_getisswipeable As boolean**
- **\_getleft As int**
- **\_getmessage As String**
- **\_getmessagecolor As Object**
- **\_getstyle As int**
- **\_getswipeorientation As int**
- **\_gettag As Object**
- **\_gettitle As String**
- **\_gettitlecolor As Object**
- **\_gettop As int**
- **\_getwidth As int**
- **\_glasseffect** (GlassScale As int, Mode As String) **As b4a.insidecode.bmpopup**
*Set Glass Effect  
 Glass Scale (0 - 255) Opacity  
 GlassColor = [ligth, dark, dominant]*- **\_glasseffectdominantgradient** (GlassScale As int, Orientation As String) **As b4a.insidecode.bmpopup**
- **\_glasseffectgradient** (GlassScale As int, ColorList As int[], Orientation As String) **As b4a.insidecode.bmpopup**
*Set Glass Effect  
 Glass Scale (0 - 255) Opacity  
 ColorList = Array as Int()  
 Orientation = [TOP\_BOTTOM,LEFT\_RIGHT, ETC…)*- **\_hide** (Manual As boolean) **As anywheresoftware.b4a.keywords.Common.ResumableSubWrapper**
*Hide the PopUp.*- **\_initialize** (ba As anywheresoftware.b4a.BA, Parent As anywheresoftware.b4a.objects.ActivityWrapper, EventName As String, CallBack As Object) **As String**
*Initialize PopUp parameters needed.*- **\_inttodip** (Integer As int) **As int**
- **\_reset As String**
*Reset the PopUp Timer.*- **\_resume As String**
*Continuous PopUp Timer at the moment of Stop*- **\_scalebitmap** (Image As anywheresoftware.b4a.objects.drawable.CanvasWrapper.BitmapWrapper, Width As int, Height As int, Filter As boolean) **As anywheresoftware.b4a.objects.drawable.CanvasWrapper.BitmapWrapper**
- **\_setanimationin** (Animation As int) **As String**
- **\_setanimationout** (Animation As int) **As String**
*Set the PopUpOut Animation.  
 Options:  
 -ANIMATION\_FLAT = 0  
 -ANIMATION\_FADEIN = 1  
 -ANIMATION\_FADEOUT = 2  
 -ANIMATION\_BOUNCEDOWN = 3  
 -ANIMATION\_BOUNCEUP = 4  
 -ANIMATION\_SHAKE = 5  
 -ANIMATION\_CARDDOWN = 6  
 -ANIMATION\_CARDUP = 7  
 -ANIMATION\_ALERT = 8  
 -ANIMATION\_CARNIVAL = 9*- **\_setappheader** (Header As boolean) **As String**
*Set or Get if you project have header*- **\_setbackcolor** (Color As int) **As String**
*Set or Get the PopUp Background Color*- **\_setbackgroundimage** (Background As anywheresoftware.b4a.objects.B4XViewWrapper.B4XBitmapWrapper) **As String**
*Set or Get the PopUp Background Image*- **\_setblureffect** (Blur As boolean) **As String**
*Set or Get Blur Effect*- **\_setblurscale** (Scale As int) **As String**
*Set or Get Blur Scale Effect*- **\_setclose** (Close As boolean) **As String**
*Set / Get if the PopUp have a close button*- **\_setduration** (Seconds As int) **As String**
*Set the PopUp Duration (Seconds).*- **\_setgradientbackground** (pnl As anywheresoftware.b4a.objects.B4XViewWrapper, Clrs As int[], Orientation As String) **As String**
- **\_setheight** (Height As int) **As String**
*Set or Get Height of a Custom PopUp*- **\_seticon** (Icon As String) **As String**
*Set the PopUp Icon*- **\_seticoncolor** (Color As int) **As String**
*Set the PopUp Icon Color*- **\_setisswipeable** (ItIs As boolean) **As String**
*Set or Get isSwipeable*- **\_setleft** (Left As int) **As String**
*Set or Get Left of a Custom PopUp*- **\_setmessage** (Text As String) **As String**
*Set or Get the PopUp Message*- **\_setmessagecolor** (Color As Object) **As String**
*Set or Get the PopUp Message Color*- **\_setposition** (Position As int) **As String**
*Set the PopUp Position.  
 Options:  
 -H\_TOP (DEFAULT) = 0 : Top of the Parent  
 -H\_CENTER = 1 : Center of the Parent  
 -H\_BOTTOM = 2 : Bottom of the Parent*- **\_setshadow** (oView As anywheresoftware.b4a.objects.B4XViewWrapper, Offset As double, Color As int) **As String**
- **\_setstyle** (Style As int) **As String**
*Set the PopUp Style.  
 The Event  
 -STYLE\_NORMAL (DEFAULT) : Normal Style.  
 -STYLE\_ACCEEPT : With accept button.  
 -STYLE\_ACCEEPTCANCEL : With accept and cancel button.  
 -STYLE\_ACCEEPTCANCELNEUTRAL : With accept, cancel and neutral buttton.*- **\_setswipeorientation** (Orientation As int) **As String**
*Set or Get Swipe Orientation*- **\_settag** (Tag As Object) **As String**
*Set / Get the PopUp Tag*- **\_settitle** (Title As String) **As String**
*Set or Get the PopUp Title*- **\_settitlecolor** (Color As Object) **As String**
*Set or Get the PopUp Title Color*- **\_settop** (Top As int) **As String**
*Set or Get Top of a Custom PopUp*- **\_setwidth** (Width As int) **As String**
*Set or Get Width of a Custom PopUp*- **\_show As void**
*Show the PopUp.*- **\_show2 As anywheresoftware.b4a.keywords.Common.ResumableSubWrapper**
*Show the Custom PopUp.*- **\_show3** (WaitTime As int) **As void**
*Show Multiples Custom PopUp DropDown effect.*- **\_size As int**
- **\_stop As String**
*Stop the PopUp Timer.*- **\_updateviews As String**
*Update all CustomViews positions and anchors*- **\_view As anywheresoftware.b4a.objects.B4XViewWrapper**
*Get the PopUp View*- **\_vscreenadjust As String**
*Adjust popup to vertical center.  
 May use it after Show*- **\_vscreencentralize As String**
*Adjust popup to vertical center.  
 May use it after Show*- Properties:
- **\_appheader As boolean**
*Set or Get if you project have header*- **\_backcolor As int**
*Set or Get the PopUp Background Color*- **\_blureffect As boolean**
*Set or Get Blur Effect*- **\_blurscale As int**
*Set or Get Blur Scale Effect*- **\_close As boolean**
*Set / Get if the PopUp have a close button*- **\_duration As int**
*Set the PopUp Duration (Seconds).*- **\_height As int**
*Set or Get Height of a Custom PopUp*- **\_left As int**
*Set or Get Left of a Custom PopUp*- **\_message As String**
*Set or Get the PopUp Message*- **\_messagecolor As Object**
*Set or Get the PopUp Message Color*- **\_style As int**
*Set the PopUp Style.  
 The Event  
 -STYLE\_NORMAL (DEFAULT) : Normal Style.  
 -STYLE\_ACCEEPT : With accept button.  
 -STYLE\_ACCEEPTCANCEL : With accept and cancel button.  
 -STYLE\_ACCEEPTCANCELNEUTRAL : With accept, cancel and neutral buttton.*- **\_swipeorientation As int**
*Set or Get Swipe Orientation*- **\_tag As Object**
*Set / Get the PopUp Tag*- **\_title As String**
*Set or Get the PopUp Title*- **\_titlecolor As Object**
*Set or Get the PopUp Title Color*- **\_top As int**
*Set or Get Top of a Custom PopUp*- **\_width As int**
*Set or Get Width of a Custom PopUp*- **\_animationin As void**
*Example:  
 <code>  
 PopUp.Animation = PopUp.ANIMATION\_FLAT</code>*- **\_animationout As void**
*Set the PopUpOut Animation.  
 Options:  
 -ANIMATION\_FLAT = 0  
 -ANIMATION\_FADEIN = 1  
 -ANIMATION\_FADEOUT = 2  
 -ANIMATION\_BOUNCEDOWN = 3  
 -ANIMATION\_BOUNCEUP = 4  
 -ANIMATION\_SHAKE = 5  
 -ANIMATION\_CARDDOWN = 6  
 -ANIMATION\_CARDUP = 7  
 -ANIMATION\_ALERT = 8  
 -ANIMATION\_CARNIVAL = 9*- **\_backgroundimage As void**
*Set or Get the PopUp Background Image*- **\_icon As void**
*Set the PopUp Icon*- **\_iconcolor As void**
*Set the PopUp Icon Color*- **\_position As void**
*Set the PopUp Position.  
 Options:  
 -H\_TOP (DEFAULT) = 0 : Top of the Parent  
 -H\_CENTER = 1 : Center of the Parent  
 -H\_BOTTOM = 2 : Bottom of the Parent*
[\*]**addCustomView** (oView As B4XView, EventName As String, X As Int, Y As Int) As B4XView  
*Create a CustomView and add it into the PopUp*  
[\*]**addEditText** (EventName As String, X As Int, Y As Int) As EditText  
*Create a ImageView and add it into the PopUp*  
[\*]**addImageView** (EventName As String, X As Int, Y As Int) As ImageView  
*Create a Label and add it into the PopUp*  
[\*]**addLabel** (EventName As String, X As Int, Y As Int) As Label  
*Create a Label and add it into the PopUp*  
[\*]**addRightAnchorView** (oView As B4XView) As String  
*Only for CustomsPopUp*  
 *Attach a view to parent size Left-Right, if parent width change, your view width will change too.*  
[\*]**addRightPositionViews** (oView As B4XView) As String  
*Only for CustomsPopUp*  
 *Attach a view to Right side of a parent, if parent width change, your view left will change too.*  
[\*]**Border** (Radius As Int, BorderWidth As Int, ColorBorder As Int) As String  
*Set Custom PopUp Border*  
[\*]**BounceIn** (Duration As Int) As ResumableSub  
[\*]**BounceOut** (Duration As Int) As ResumableSub  
[\*]**changeSize** (Width As Int, Height As Int) As String  
*Change size of a popup.*  
 *May use it after Show*  
[\*]**Class\_Globals** As String  
[\*]**Collapse** (Interval As Int) As ResumableSub  
*Collapse the PopUp to original Height Size*  
[\*]**ConvertTicksToSeconds** (t As Long) As Int  
*Convert Milliseconds to Seconds*  
[\*]**CustomAnimation** (SubName As String, Interval As Int) As String  
*Set Custom PopUp Animation Sub*  
[\*]**Expand** (Cant As Int, Interval As Int) As ResumableSub  
*Expand the PopUp to any Height Size*  
[\*]**getAppHeader** As Boolean  
[\*]**getBackColor** As Int  
[\*]**getBlurEffect** As Boolean  
[\*]**getBlurScale** As Int  
[\*]**getClose** As Boolean  
[\*]**getCustomViewbyEventName** (EventName As String) As B4XView  
*Get a CustomView by EventName*  
[\*]**getCustomViewbyIndex** (Index As Int) As B4XView  
*Get a CustomView by Index*  
[\*]**getDuration** As Int  
[\*]**getHeight** As Int  
[\*]**getIsSwipeable** As Boolean  
[\*]**getLeft** As Int  
[\*]**getMessage** As String  
[\*]**getMessageColor** As Object  
[\*]**getStyle** As Int  
[\*]**getSwipeOrientation** As Int  
[\*]**getTag** As Object  
[\*]**getTitle** As String  
[\*]**getTitleColor** As Object  
[\*]**getTop** As Int  
[\*]**getWidth** As Int  
[\*]**Hide** (Manual As Boolean)  
*Hide the PopUp.*  
[\*]**Initialize** (Parent As Activity, EventName As String, CallBack As Object) As String  
*Initialize PopUp parameters needed.*  
[\*]**IsInitialized** As Boolean  
*Prueba si acaso el objeto ha sido inicializado.*  
[\*]**Reset** As String  
*Reset the PopUp Timer.*  
[\*]**Resume** As String  
*Continuous PopUp Timer at the moment of Stop*  
[\*]**setAnimationIn** (Animation As Int) As String  
[\*]**setAnimationOut** (Animation As Int) As String  
*Set the PopUpOut Animation.*  
 *Options:*  
 *-ANIMATION\_FLAT = 0*  
 *-ANIMATION\_FADEIN = 1*  
 *-ANIMATION\_FADEOUT = 2*  
 *-ANIMATION\_BOUNCEDOWN = 3*  
 *-ANIMATION\_BOUNCEUP = 4*  
 *-ANIMATION\_SHAKE = 5*  
 *-ANIMATION\_CARDDOWN = 6*  
 *-ANIMATION\_CARDUP = 7*  
 *-ANIMATION\_ALERT = 8*  
 *-ANIMATION\_CARNIVAL = 9*  
 *Example:*  
   
 *Notif.Animation = Notif.ANIMATION\_FLAT*  
[\*]**setAppHeader** (Header As Boolean) As String  
*Set or Get if you project have header*  
[\*]**setBackColor** (Color As Int) As String  
*Set or Get the PopUp Background Color*  
[\*]**setBackgroundImage** (Background As B4XBitmap) As String  
*Set or Get the PopUp Background Image*  
[\*]**setBlurEffect** (Blur As Boolean) As String  
*Set or Get Blur Effect*  
[\*]**setBlurScale** (Scale As Int) As String  
*Set or Get Blur Scale Effect*  
[\*]**setClose** (Close As Boolean) As String  
*Set / Get if the PopUp have a close button*  
[\*]**setDuration** (Seconds As Int) As String  
*Set the PopUp Duration (Seconds).*  
[\*]**setHeight** (Height As Int) As String  
*Set or Get Height of a Custom PopUp*  
[\*]**setIcon** (Icon As String) As String  
*Set the PopUp Icon*  
[\*]**setIconColor** (Color As Int) As String  
*Set the PopUp Icon Color*  
[\*]**setIsSwipeable** (ItIs As Boolean) As String  
*Set or Get isSwipeable*  
[\*]**setLeft** (Left As Int) As String  
*Set or Get Left of a Custom PopUp*  
[\*]**setMessage** (Text As String) As String  
*Set or Get the PopUp Message*  
[\*]**setMessageColor** (Color As Object) As String  
*Set or Get the PopUp Message Color*  
[\*]**setPosition** (Position As Int) As String  
*Set the PopUp Position.*  
 *Options:*  
 *-H\_TOP (DEFAULT) = 0 : Top of the Parent*  
 *-H\_CENTER = 1 : Center of the Parent*  
 *-H\_BOTTOM = 2 : Bottom of the Parent*  
[\*]**setStyle** (Style As Int) As String  
*Set the PopUp Style.*  
 *The Event*  
 *-STYLE\_NORMAL (DEFAULT) : Normal Style.*  
 *-STYLE\_ACCEEPT : With accept button.*  
 *-STYLE\_ACCEEPTCANCEL : With accept and cancel button.*  
 *-STYLE\_ACCEEPTCANCELNEUTRAL : With accept, cancel and neutral buttton.*  
[\*]**setSwipeOrientation** (Orientation As Int) As String  
*Set or Get Swipe Orientation*  
[\*]**setTag** (Tag As Object) As String  
*Set / Get the PopUp Tag*  
[\*]**setTitle** (Title As String) As String  
*Set or Get the PopUp Title*  
[\*]**setTitleColor** (Color As Object) As String  
*Set or Get the PopUp Title Color*  
[\*]**setTop** (Top As Int) As String  
*Set or Get Top of a Custom PopUp*  
[\*]**setWidth** (Width As Int) As String  
*Set or Get Width of a Custom PopUp*  
[\*]**Show**  
*Show the PopUp.*  
[\*]**Show2**  
*Show the Custom PopUp.*  
[\*]**Stop** As String  
*Stop the PopUp Timer.*  
[\*]**UpdateViews** As String  
*Update all CustomViews positions and anchors*  
[\*]**View** As B4XView  
*Get the PopUp View*  
[\*]**VScreenAdjust** As String  
*Adjust popup to vertical center.*  
 *May use it after Show*  
[\*]**VScreenCentralize** As String  
*Adjust popup to vertical center.*  
 *May use it after Show*  
  
[\*]**Properties:**  

- **AnimationIn**
*Example:  
   
 Notif.Animation = Notif.ANIMATION\_FLAT*- **AnimationOut**
*Set the PopUpOut Animation.  
 Options:  
 -ANIMATION\_FLAT = 0  
 -ANIMATION\_FADEIN = 1  
 -ANIMATION\_FADEOUT = 2  
 -ANIMATION\_BOUNCEDOWN = 3  
 -ANIMATION\_BOUNCEUP = 4  
 -ANIMATION\_SHAKE = 5  
 -ANIMATION\_CARDDOWN = 6  
 -ANIMATION\_CARDUP = 7  
 -ANIMATION\_ALERT = 8  
 -ANIMATION\_CARNIVAL = 9  
 Example:  
   
 Notif.Animation = Notif.ANIMATION\_FLAT*- **AppHeader** As Boolean
*Set or Get if you project have header*- **BackColor** As Int
*Set or Get the PopUp Background Color*- **BackgroundImage**
*Set or Get the PopUp Background Image*- **BlurEffect** As Boolean
*Set or Get Blur Effect*- **BlurScale** As Int
*Set or Get Blur Scale Effect*- **Close** As Boolean
*Set / Get if the PopUp have a close button*- **Duration** As Int
*Set the PopUp Duration (Seconds).*- **Height** As Int
*Set or Get Height of a Custom PopUp*- **Icon**
*Set the PopUp Icon*- **IconColor**
*Set the PopUp Icon Color*- **Left** As Int
*Set or Get Left of a Custom PopUp*- **Message** As String
*Set or Get the PopUp Message*- **MessageColor** As Object
*Set or Get the PopUp Message Color*- **Position**
*Set the PopUp Position.  
 Options:  
 -H\_TOP (DEFAULT) = 0 : Top of the Parent  
 -H\_CENTER = 1 : Center of the Parent  
 -H\_BOTTOM = 2 : Bottom of the Parent  
 Example:  
   
 Notif.Position = Notif.H\_TOP*- **Style** As Int
*Set the PopUp Style.  
 The Event  
 -STYLE\_NORMAL (DEFAULT) : Normal Style.  
 -STYLE\_ACCEEPT : With accept button.  
 -STYLE\_ACCEEPTCANCEL : With accept and cancel button.  
 -STYLE\_ACCEEPTCANCELNEUTRAL : With accept, cancel and neutral buttton.  
 Example:  
   
 Notif.Style = Notif.STYLE\_NORMAL*- **SwipeOrientation** As Int
*Set or Get Swipe Orientation*- **Tag** As Object
*Set / Get the PopUp Tag*- **Title** As String
*Set or Get the PopUp Title*- **TitleColor** As Object
*Set or Get the PopUp Title Color*- **Top** As Int
*Set or Get Top of a Custom PopUp*- **Width** As Int
*Set or Get Width of a Custom PopUp*
  
[/SPOILER]  
  
Examples:  
[SPOILER="Examples"]  

```B4X
Public Sub NormalPopUp  
    Public Notif As BMPopUp  
    Notif.Initialize(Activity, "Notif", Me)  
    Notif.Title = "Normal PopUp"  
    Notif.Message ="Test message!"  
    Notif.BackColor = Colors.ARGB(150,Rnd(0,255),Rnd(0,255),Rnd(0,255))  
    Notif.MessageColor = Colors.White  
    Notif.TitleColor = Colors.White  
    Notif.Icon = Chr(0xF209)  
    Notif.IconColor = Colors.White  
    Notif.Position = Rnd(0,3)  
    Notif.Duration = 5  
    Notif.Close = True  
    Notif.Style = Notif.STYLE_NORMAL  
    Notif.Tag = "Helow message!"  
   
    Notif.Show  
End Sub  
  
Public Sub PopUpAccept  
    Public Notif2 As BMPopUp  
    Notif2.Initialize(Activity, "Notif2", Me)  
    Notif2.Title = "Accept PopUp"  
    Notif2.Message ="Test message!"  
    Notif2.BackColor = Colors.ARGB(150,Rnd(0,255),Rnd(0,255),Rnd(0,255))  
    Notif2.MessageColor = Colors.White  
    Notif2.TitleColor = Colors.White  
    Notif2.Icon = Chr(0xF209)  
    Notif2.IconColor = Colors.White  
    Notif2.Position = Rnd(0,3)  
    Notif2.Duration = 5  
    Notif2.Close = True  
    Notif2.Style = Notif2.STYLE_ACCEPT  
    Notif2.Tag = "Accept Tag!"  
   
    Notif2.Show  
End Sub  
  
Public Sub PopUpAcceptCancel  
    Public Notif2 As BMPopUp  
    Notif2.Initialize(Activity, "Notif2", Me)  
    Notif2.Title = "AcceptCancel PopUp"  
    Notif2.Message ="Test message!"  
    Notif2.BackColor = Colors.ARGB(150,Rnd(0,255),Rnd(0,255),Rnd(0,255))  
    Notif2.MessageColor = Colors.White  
    Notif2.TitleColor = Colors.White  
    Notif2.Icon = Chr(0xF209)  
    Notif2.IconColor = Colors.White  
    Notif2.Position = Rnd(0,3)  
    Notif2.Duration = 5  
    Notif2.Close = True  
    Notif2.Style = Notif2.STYLE_ACCEPTCANCEL  
    Notif2.Tag = "AcceptCancel Tag!"  
   
    Notif2.Show  
End Sub  
  
Public Sub PopUpAcceptCancelNeutral  
    Public Notif2 As BMPopUp  
    Notif2.Initialize(Activity, "Notif2", Me)  
    Notif2.Title = "AcceptCancelNeutral PopUp"  
    Notif2.Message ="Test message!"  
    Notif2.BackColor = Colors.ARGB(150,Rnd(0,255),Rnd(0,255),Rnd(0,255))  
    Notif2.MessageColor = Colors.White  
    Notif2.TitleColor = Colors.White  
    Notif2.Icon = Chr(0xF209)  
    Notif2.IconColor = Colors.White  
    Notif2.Position = Rnd(0,3)  
    Notif2.Duration = 5  
    Notif2.Close = True  
    Notif2.Style = Notif2.STYLE_ACCEPTCANCELNEUTRAL  
    Notif2.Tag = "AcceptCancelNeutral Tag!"  
   
    Notif2.Show  
End Sub
```

  
  

```B4X
Private Sub Notif_Click (Popup As BMPopUp)  
   
    Popup.BackColor =  Colors.Green  
    Popup.Icon = Chr(0xF00C)  
    Popup.Title = "Success!"  
    Popup.Message = "You click this message!"  
    Popup.Update  
    Log(Popup.Tag)  
  
End Sub
```

  
  

```B4X
Private Sub Notif2_Answer(PopUp As BMPopUp, Answer As Int)  
  
    Dim Icon As String = ""  
    Dim Color As Int = Colors.Black  
    Dim Title As String = ""  
   
    Select Answer  
        Case PopUp.ANSWER_ACCEPT  
            Icon = Chr(0xF00C)  
            Color = 0xFF359427  
            Title = "ACCEPT!"  
        Case PopUp.ANSWER_CANCEL  
            Icon = Chr(0xF00D)  
            Color = 0xFF943228  
            Title = "CANCEL!"  
        Case PopUp.ANSWER_NEUTRAL  
            Icon = Chr(0xF209)  
            Color = 0xFF897521  
            Title = "NEUTRAL!"  
    End Select  
   
    PopUp.BackColor =  Color  
    PopUp.Icon = Icon  
    PopUp.Title = Title  
    PopUp.Message = "You choose your option"  
   
    PopUp.Update  
  
End Sub
```

[/SPOILER]  
  
  
PopUp with expand effect:  
  
![](https://www.b4x.com/android/forum/attachments/139137)  
  
![](https://www.b4x.com/android/forum/attachments/139138)  
  
[SPOILER="Code"]  

```B4X
    Public PopUp As BMPopUp  
    PopUp.Initialize(Activity, "PopUp", Me)  
    PopUp.Style = PopUp.STYLE_CUSTOM  
    PopUp.Width = 100%x  
    PopUp.Height = 110dip  
    PopUp.Duration = 7  
    PopUp.isSwipeable = True  
    PopUp.AnimationIn = PopUp.ANIMATION_SMOOTHDOWN  
    PopUp.AnimationOut = PopUp.ANIMATION_SMOOTHUP  
    PopUp.BackColor = 0xE1275A75  
    PopUp.Border(0,1,Colors.Transparent)  
   
    Dim Logo As ImageView = PopUp.addImageView("Logo", 40%x,5)  
    Dim img As Bitmap  
    img.Initialize(File.DirAssets,"logo.png")  
    Logo.SetBackgroundImage(img)  
    Logo.Gravity = Gravity.FILL  
    Logo.Width = 24dip  
    Logo.Height = 24dip  
   
   
    Dim CustomLabel As Label = PopUp.addLabel("CustomLabel",Logo.Left / 1.5,25dip)  
    CustomLabel.Text = "Welcome B4X Forum"  
    CustomLabel.Width = PopUp.Width  
    CustomLabel.Height = 35dip  
    CustomLabel.Left = CustomLabel.Left - CustomLabel.Width  
    CustomLabel.TextColor = Colors.White  
    CustomLabel.TextSize = 14  
   
    Dim CustomText As Label = PopUp.addLabel("CustomText",5%x,60dip)  
    CustomText.Text = $"  
    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.  
    "$  
    CustomText.Width = PopUp.Width * .90  
    CustomText.TextColor = Colors.White  
    CustomText.TextSize = 12  
    CustomText.Height = PopUp.Height - CustomText.tOP  
    CustomText.SingleLine = True  
    PopUp.addRightAnchorView(CustomText)  
    PopUp.addBottomAnchorView(CustomText)  
   
    Dim ViewMore As B4XView = PopUp.addLabel("ViewMore2",PopUp.Width - (16%X),20dip)  
    Private tf As Typeface  
    tf = tf.CreateNew(Typeface.FONTAWESOME, Typeface.STYLE_BOLD)  
    Dim fnt As B4XFont=xui.CreateFont(tf,17)  
    ViewMore.Font= fnt  
  
    ViewMore.Text = Chr(0xF107) & " View More"  
    ViewMore.Width = 120dip  
    ViewMore.Height = 35dip  
    ViewMore.TextColor = Colors.Cyan  
    ViewMore.TextSize = 10  
   
    PopUp.Show2
```

  
  

```B4X
Sub ViewMore_Click(PopUp As BMPopUp, lbl As Label)  
  
    Dim text As Label = PopUp.getCustomViewbyEventName("CustomText")  
  
    If Not(PopUp.isExpanded) Then  
        lbl.Text = Chr(0xF106) & " View Less"  
        text.SingleLine = False  
        Wait For (PopUp.expand(15dip,2)) Complete(R As Boolean)  
        PopUp.Stop  
    Else  
        Wait For (PopUp.collapse(1)) Complete(R As Boolean)  
     
        lbl.Text = Chr(0xF107) & " View More"  
        text.SingleLine = True  
        PopUp.Resume  
    End If  
   
  
End Sub
```

[/SPOILER]  
  
  
PopUp with EditText:  
  
![](https://www.b4x.com/android/forum/attachments/139140)![](https://www.b4x.com/android/forum/attachments/139141)  
  
  
[SPOILER="Code"]  

```B4X
    Public PopUp As BMPopUp  
    PopUp.Initialize(Activity, "PopUp", Me)  
    PopUp.BackColor = Colors.ARGB(225,13,51,59)  
    PopUp.Position = PopUp.H_TOP  
    PopUp.Duration = 0  
    PopUp.AnimationIn = PopUp.ANIMATION_BOUNCEDOWN  
    PopUp.Style = PopUp.STYLE_CUSTOM  
    PopUp.Border(10,2,Colors.LightGray)  
    PopUp.Tag = "Custom PopUp Tag!"  
    PopUp.Height = 150dip  
   
    Dim Name As EditText = PopUp.addEditText("Name",30%x,5%y)  
    Name.Hint = "Name"  
    Name.TextSize = 12  
    Name.Width = 200dip  
    Name.Height = 35dip  
    Name.TextColor = Colors.White  
    Name.HintColor = Colors.LightGray  
    Name.Color = Colors.ARGB(50,31,99,114)  
   
    Dim LastName As EditText = PopUp.addEditText("LastName",30%x,10%y)  
    LastName.Hint = "Last Name"  
    LastName.TextSize = 12  
    LastName.Width = 200dip  
    LastName.Height = 35dip  
    LastName.TextColor = Colors.White  
    LastName.HintColor = Colors.LightGray  
    LastName.Color = Colors.ARGB(50,31,99,114)  
   
    Dim Btn As Button = PopUp.addButton("Btn", 33%x, 16%y)  
    Btn.Width = 175dip  
    Btn.Height = 35dip  
    Btn.Text = "Enter"  
    Btn.Color = Colors.ARGB(50,255,255,255)  
    Btn.TextColor = Colors.White  
  
    PopUp.Show2
```

  
  

```B4X
Private Sub Btn_Click (Popup As BMPopUp, Btn As Button)  
    Dim Name As EditText = Popup.getCustomViewbyEventName("Name")  
    Dim LastName As EditText = Popup.getCustomViewbyEventName("LastName")  
   Log("Name: " & Name.Text & CRLF & "Last Name: " & LastName.Text)  
    Popup.Hide(False)  
End Sub
```

  
  
[/SPOILER]