### Pin Lock Full Source Code with Ripple Effect by ganezha
### 07/31/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/171698/)

### 📱 Features:  
  
✅ \*\*Digital Clock\*\* (WIB Timezone - UTC+7)  
✅ \*\*6-Digit PIN Input\*\* with Visual Dots (● / ○)  
✅ \*\*Ripple Effect\*\* on all buttons (Touch Feedback)  
✅ \*\*Gradient Buttons\*\* with Rounded Corners  
✅ \*\*Delete\*\* (←) and \*\*Clear\*\* (×) functionality  
✅ \*\*PIN Validation\*\* with Correct/Incorrect feedback  
✅ \*\*Automatic Timezone\*\* restore on app close  
✅ \*\*Responsive Layout\*\* (works on all screen sizes)  
  
—  
  
### 📦 Libraries Used:  
  
- \*\*RippleView\*\* (by [USER=102342]@Alexander Stolte[/USER]) - For ripple effect animation  
- \*\*XUI\*\* - For cross-platform views  
- \*\*B4XPages\*\* - For modern page management  
  
—  
  
### 🔧 How to Use:  
  
1. \*\*Clone/Download\*\* the source code  
2. \*\*Add\*\* the following files:  
 - `RippleView.bas` (download from [this thread](<https://www.b4x.com/android/forum/threads/ripple-effect-animation.141501/>))  
 - `digital.ttf` (optional, for digital clock font)  
3. \*\*Change\*\* the default PIN in `B4XPage\_Created`:  
 ```b4a  
 Private CorrectPin As String = "123456" ' ← Change this!  
  
[HEADING=2]⚠️ Requirements:[/HEADING]  

- **B4A version**: 11.0+
- **Android API**: 21+
- **Libraries**: XUI, RippleView

[HEADING=2]🙏 Credits:[/HEADING]  

- **RippleView** by [USER=102342]@Alexander Stolte[/USER]
- **XUI** by [USER=1]@Erel[/USER] (B4X)
- **Digital Font** by (source)

  
  
  
![](https://www.b4x.com/android/forum/attachments/172717)