### Get Clock Emoji from a Timestamp (UTF-16 safe & 30-min rounding) by Serge Bertet
### 10/19/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/172320/)

```B4X
' Description: Returns a clock emoji (🕛 to 🕦) for any given timestamp, rounded to the nearest 30 minutes.  
' Tip: Uses a direct String array to avoid UTF-16 surrogate pair splitting issues inherent to emojis.  
Private Sub GetClockEmoji(time As Long = DateTime.Now) As String  
    ' Direct array declaration prevents string splitting issues on 4-byte UTF-16 surrogate characters  
    Dim clockIcons() As String = Array As String( _  
        "🕛", "🕧", "🕐", "🕜", "🕑", "🕝", "🕒", "🕞", "🕓", "🕟", "🕔", "🕠", _  
        "🕕", "🕡", "🕖", "🕢", "🕗", "🕣", "🕘", "🕤", "🕙", "🕥", "🕚", "🕦")  
  
    Dim h As Int = DateTime.GetHour(time) Mod 12  
    Dim m As Int = DateTime.GetMinute(time)  
  
    ' Nearest 30-minute rounding calculation in a single line  
    Dim stepIndex As Int = (h * 2 + (m + 15) / 30) Mod 24  
  
    Return clockIcons(stepIndex)  
End Sub  
' Note: A trailing comment is sometimes necessary right after End Sub  
' to prevent IDE source file encoding/parser glitches with raw UTF-16 emoji literals.
```

  
Usage:

```B4X
' Add the resulting icon in a label text  
myLabel.Text = GetClockEmoji() ' For the current time  
' Or for a specific timestamp (e.g. 2 hours and 30 minutes ago)  
myLabel.Text = GetClockEmoji(DateTime.Now - (2.5 * DateTime.TicksPerHour))
```