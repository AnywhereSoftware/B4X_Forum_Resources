### extended editText view by Guenter Becker
### 03/02/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/137730/)

**Notice! This is obsolete it will no longer developed. There is a better substitute. Look in the Forum at:**   
[HEADING=2]TDSLinput (masked extended EditText)[/HEADING]  
  
**Name**: *TDeditTextExt*  
**Type**: B4Xlib  
**Code**: B4A  
**Version**: Beta2 -early access-  
**Lib Name:** TDeditTextExt.b4xlib  
**(C):** TechDoc G.Becker, free to use only for forum members  
  
**You need to activated this libraries for *TDeditTextExt*:**  
*Core, AppCompat, IME, JavaObject, XUI,TDeditTextExt*  
  
In some situations we need an *editText* view with horizontal and vertical scrolling capability and extra features. ***TDeditTextExt*** is a custom control that is desginerable and it is based on the native *editText* view..  

- **In SingleLine Mode text is scrolled in horizontal direction.**
- **In Multiline Mode text is scrolled in vertical and horizontal direction.**

[SIZE=5]In addition of the scrolling possibility *TDeditTextExt* has this features:[/SIZE]  

- Preset and **check Input length**.
- Set Input **Spellchecking** On/Off.
- Show/Hide a **Border (Tint)** if the view is focused or not. Set **Bordercolor** and **width**.
- Preset a **Mask** and check the input against it.
- Give **Access to all native properties** of the inbuild *editTextView*.

To set the **properties values by code** follow this example:  

```B4X
Sub setStandardProperties  
    TDeditTextExt1.edt.TextColor=Colors.Red  
End Sub  
Sub SetExtendedProperties  
    TDeditTextExt1.Length=5  
    TDeditTextExt1.Mask = "###.##"  
    TDeditTextExt1.Tint=True  
    TDeditTextExt1.SpellChecking=True  
End Sub
```

  
  
**For the use in the Designer the** native *editText* and the extended properties are shown in the **Custom Properties Section** (see attached picture).  
  
**Length:**  
The minimum input length is 0. If you set the length value every text change the current input length ich ckecked. If you pass the limit the just added character is stripped of.  
  
**Spellchecking:**  
If SellChecking is True than the phones in build spellchecking is turned on. Wrong or not recognized text is underlind by a red waveline.  
  
**Tint:**  
IF Tint is True than a border around the view is shown. You are able to set a different color for the focus state and the the border width.  
  
**Mask:**  
The *Mask* is usefull and only working if SingleLine property is 'True'.  
Use 'A' for Character and '#' for Digit Place like: TDeditTextExt1.Mask = "AA##B" or TDeditTextExt1.Mask = "#,###.##"  
Working with a **Mask seperator** depends on the used *editText.InputType.*  
  
[TABLE]  
[TR]  
[TD]**Inputtype**[/TD]  
[TD]**Seperator**[/TD]  
[/TR]  
[TR]  
[TD]NUMBERS[/TD]  
[TD]None[/TD]  
[/TR]  
[TR]  
[TD]DECIMAL\_NUMBERS[/TD]  
[TD]comma (,) dot (.)[/TD]  
[/TR]  
[TR]  
[TD]PHONE[/TD]  
[TD]( ) + - , . ; / N[/TD]  
[/TR]  
[TR]  
[TD]TEXT / NONE[/TD]  
[TD]not used[/TD]  
[/TR]  
[/TABLE]  
  
**If you set a Mask** the Input length is set automatically equal to mask length and extended Length property is not used.  
If there is an **input violation** like a not allowed digit or char at the mask/ input position or the input length is less mask length than the background of the view is flashing in red color and an error message is shown. To set the **message text and title of the error message** use the designer custom properties.  
  
**The complete Mask check is started by pressing the ENTER Button at the end of the input.** After checking the result is reported by the **Event "InputError"** to the parent object of *TDeditTextExt view*.  
  
If you like to look into the ***TDeditTextExt***  **code** please examine the module in the attached example project.  
  
**[SIZE=4]Notice: [/SIZE]**  
This project is in **Beta Status at present****.** In some situations errors may occure. If you find and error feel free to report them by replying to this article.  
If you have ideas or whishes for optimization please let me know.