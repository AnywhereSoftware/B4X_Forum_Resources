###  MacroPlay Library by Magma
### 01/20/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/145590/)

Hi there to all…  
  
Before some weeks created a MACRO-Recorder for Licensed Members…  
<https://www.b4x.com/android/forum/threads/utility-magma-macro-recorder-0.145139/#post-919986>  
  
![](https://www.b4x.com/android/forum/attachments/138312)  
  
This Library comes to "cover" the developer side to use macros at his app.  
  
Need to add the following at your project:  

```B4X
    #AdditionalJar: jna-5.2.0  
    #AdditionalJar: jna-platform-5.2.0  
  
Sub Process_Globals  
    Type MacroRecord(TIME1 As Long, KEYCODE1 As String, KEYPRESS1 As Int, KEYRELEASE1 As Int, MBP As Int, MBR As Int, MBPWamount As Int,MBPWtype As Int , MBPWrot As Int, X1 As Int,Y1 As Int)
```

  
  
An example of code:  

```B4X
    Dim macrosplayer As macroplay  
    macrosplayer.Initialize  
    macrosplayer.MacroPlayinWin(Me,Array As String("Run","Notepad",B4XPages.GetNativeParent(Me).Title),"D:/test4.rec",3)  
'this will repeat for 3 times the same moves-keys-clicks recorded at test4.rec / clicks and keys will only made if Run, Notepad or your App-B4XPage is on top  
'so the MacroPlayinWin limits where will run… the "keystroke, clicks"… this is good if you want to be sure… where typing and clicking ! :)   
'if you don't want to limit and you are sure what you are doing, just use:  
macrosplayer.MacroPlay(Me,"D:/test4.rec",1)  
'This will run one time… the moves, clicks, keypressing… but will not check where all these will be…
```

  
  
It has the following Functions:  
***MacroPlayinWin(B4Xview, Array("window1","window2","window3"… etc), "recorded-file.rec", repeats)  
MacroPlay(B4Xview, "recorded-file.rec", repeats)***  
  
[You can check, download MACRO Recorder Utility from here !](https://www.b4x.com/android/forum/threads/utility-magma-macro-recorder-0.145139/#post-919986)  
  
**ver.0.0.1 (20/01/2023)**  
  
So, you can donate anything you want to support me! And you will take the Library and full source code for Library and Macro-Recorder !  
  
[![](https://www.b4x.com/android/forum/attachments/138314)](https://www.paypal.com/donate/?hosted_button_id=WX7LZ94QEY6UC)  
  
\* I think that this working only at Windows… because of jna…