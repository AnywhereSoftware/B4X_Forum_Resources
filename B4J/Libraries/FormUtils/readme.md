### FormUtils by stevel05
### 10/02/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/84460/)

Here are some formutilities that I find useful pretty often. So I put them all in one static class And I thought I'd share it.  
  
The most important one, I just found (GetIcons in the lib) allows you to add an icon to display it in the taskbar when the form is minimized (Iconified), I've been looking for that for a while. It has the bonus of also adding the Icon to the form.  
  
The attached Is the source code, plus a FUtils\_KeyCombinations class that can be used with the SetFullScreenExitKeyCode. Did I mention that it also has methods To set full screen (And a method To display a hint For how To get out of it) and Set Iconified. There are other methods that I use regularly too.  
  
Being a static code module, you need To pass the Target Form object To each method along with any other required parameters.  
  
Documentation Courtesy of Informatix LibDoc  
[SPOILER="Documentation"]  
**jFormUtils  
  
Author:** Stevel05  
**Version:** 0.1  

- **FUtils\_KeyCombinations**

- **Fields:**

- **KC\_ALT** As String
- **KC\_CONTROL** As String
- **KC\_SHIFT** As String
- **KC\_SHORTCUT** As String

- **Functions:**

- **GetKeyCombination** (Combination As String()) As Object
- **Process\_Globals** As String

- **FormUtils**

- **Functions:**

- **GetIcons** (F As Form) As List
*Gets the icon images to be used in the window decorations and when minimized.  
Also adds the icon to the form  
<code>Dim Img As Image = fx.LoadImage(File.DirAssets,"icon.png")  
 FormUtils.GetIcons(MainForm).Add(Img)</code>*- **GetMinHeight** (F As Form) As Double
*Gets the value of the property minHeight.*- **GetMinWidth** (F As Form) As Double
*Gets the value of the property minWidth.*- **IsAlwaysOnTop** (F As Form) As Boolean
*Gets the value of the property alwaysOnTop.*- **IsFullScreen** (F As Form) As Boolean
*Gets the value of the property fullScreen.*- **IsIconified** (F As Form) As Boolean
*Gets the value of the property iconified.*- **IsMaximized** (F As Form) As Boolean
*Gets the value of the property maximized.*- **IsResizable** (F As Form) As Boolean
*Gets the value of the property resizable.*- **Process\_Globals** As String
- **SetFullScreen** (F As Form, Value As Boolean) As String
*Sets the value of the property fullScreen.*- **SetFullScreenExitHint** (F As Form, Value As String) As String
*Specifies the text to show when a user enters full screen mode, usually used to indicate the way a user should go about exiting out of full screen mode.*- **SetFullScreenExitKeyCombination** (F As Form, TKeyCombination As Object) As String
*Specifies the KeyCombination that will allow the user to exit full screen mode.*- **SetIconified** (F As Form, Value As Boolean) As String
*Sets the value of the property iconified.*- **SetMaxHeight** (F As Form, Value As Double) As String
*Sets the value of the property maxHeight.*- **SetMaximized** (F As Form, Value As Boolean) As String
*Sets the value of the property maximized.*- **SetMaxWidth** (F As Form, Value As Double) As String
*Sets the value of the property maxWidth.*- **SetMinHeight** (F As Form, Value As Double) As String
*Sets the value of the property minHeight.*- **SetMinWidth** (F As Form, Value As Double) As String
*Sets the value of the property minWidth.*- **ToBack** (F As Form) As String
*Send the Window to the background.*- **ToFront** (F As Form) As String
*Bring the Window to the foreground.*
[/SPOILER]  
  
Requires JavaObject