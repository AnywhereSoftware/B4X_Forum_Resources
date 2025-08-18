### IME2 Library by agraham
### 08/21/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/121451/)

I have been having a lot of trouble lately with layouts being corrupted when rotating a device with the soft keyboard open.  
  
The problem stems from trying to use the IME library HeightChanged event. Unfortunately Android provides no direct way to determine whether the soft keyboard is shown or not so the IME.HeightChanged event uses a bit of a hack. to detect this. The problem that I have found is that, particularly when rotating a device with the keyboard is open, different soft keyboards and different devices produce different erroneous layouts after rotation, particularly in split mode. In some devices it works well, others produce poor results.  
  
The IME2 library provides some extra methods to help sort this problem and the KeyboardTest app uses them to demonstrate obtaining the correct layout after device rotation with the keyboard open in all normal and split mode combinations in portrait and landscape. This app works on all my devices but may not work on yours.  
  
Erel posted a different possible workaround here.  
<https://www.b4x.com/android/forum/threads/layout-corrupted-if-device-is-rotated-with-ime-open.121234/#post-758036>  
It is worth trying that first to see if it works for you but it didn't work for me in all circumstances - basically because you can get multiple spurious HeightChanged events during/after rotation and his solution just accepts the first one.  
  
If anyone has something simpler to solve this problem I would welcome trying it.  
  
From the XML for the IME2 library.  
  
> It is a strict superset of the original IME library but includes the following additional methods.  
>   
> IsActive  
> IsAcceptingText  
> IsSplitMode  
> GetDisplayRectangle  
> GetKeyboardRectangle  
> GetWindowRectangle  
> ChangeKeyboard  
>    
> IsActive is True if there are any editable views (such as EditText) inflated.  
>    
> IsAcceptingText is True if an inflated editable view (such as EditText) has the focus.  
> It's possible for an editable view to have focus while the keyboard is not displayed.  
> For example having tapped on an EditText and then pressing Back to close the keyboard.  
>   
> IsSplitMode returns True if the activity is running in split screen mode.  
> Many of these methods are not valid to use if the activity is running in split screen mode.  
> Those that are not valid in split screen mode are indicated in the method comment.  
> Unless absolutely necessary it is probably best to ignore HeightChanged events in split mode.  
>   
> Inexplicably Android provides no direct way to determine whether the soft keyboard is shown or not.  
> GetKeyboardRectangle provides a way of determining whether it is shown or not without waiting for an event.  
> GetKeyboardRectangle compares the display size to the current window size in order to determine what  
> the size and location of the keyboard could be. Checking the height of this Rect is an alternative way  
> of determining if the keyboard is shown than comparing NewHeight and OldHeight in the HeightChanged event.  
> Note that although termed 'Height' the HeightChanged event parameters appear to actually be the Top value of the keyboard location.  
>   
> GetDisplayRectangle gets the dimensions of the Display on which the activity is being drawn as a Rect.  
> These values are absolute pixel values, Left and Top are always 0.  
> When not in split screen mode these values reflect those of the full physical display of the device.  
> In split mode they define the size of a smaller logical display hosting the activity.  
>   
> GetWindowRectangle gets the location and dimensions of the Activity's window as a Rect.  
> These values are absolute pixel values relative to the physical display screen.  
> They define the size and location on screen of the visible portion of the activity.  
>   
> ChangeKeyboard shows the IME selection popup to select one of the input methods available to the system.  
> Invoking this allows a user to quickly select a keyboard.