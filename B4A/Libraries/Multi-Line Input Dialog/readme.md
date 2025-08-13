### Multi-Line Input Dialog by drgottjr
### 12/18/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/158045/)

i was looking for a multi-line inputdialog. having not seen one, and at the risk of re-inventing the wheel, i made one.  
  
it's relatively configurable: title, text size and color, background color, icon, dialog theme (dark/light), number of visible lines before scrolling. it scrolls vertically (even if you set its number of visible lines to 1, like an old-timey pager), and it comes with a discreet border. there is no horizontal scrolling; text just wraps around and scrolls (if applicable). of course, manual newlines are permitted. adding an icon is simple. it has, i believe, reasonable defaults, taking into account its intended purpose.  
  

```B4X
' declare:  
    Dim etdialog As Editdialog  
' initialize:  
    etdialog.Initialize("et")  
  
' usage:  
'    no settings gets you 5 visible scrolling lines,  
'    black text of a standard size on a white background  
'    or mix and match some settings,eg.:  
  
'    etdialog.Title = "Input goes here:"  
'    etdialog.Background = Colors.Yellow  
'    etdialog.TextColor = Colors.Green  
'    etdialog.MaxLines = 3     ' default is 5, unless you set otherwise  
'    etdialog.TextSize = 30    ' you don't have to set a text size  
'    etdialog.DarkTheme = true  ' default is false  
  
' invoke:  
    etdialog.build(bitmap)  ' or pass null for no icon  
    wait for et_dialogdone( userinput As String )
```

  
  
it seems to behave as expected. input area shrinks or expands in accordance with number of lines you expect and text size specified (if any). unzip attached archive and save the .jar and .xml files to your additional libraries folder, and select etdialog from the additional libraries tab in the ide. declare and initialize as per above. if you want an icon on your dialog, you need to load a bitmap in your app and pass it as per above. otherwise pass null when invoking your pop-up. i looked at a number of so-called "themes" before settling on 2: one dark, one light. default is light. set DarkTheme to true to activate it. i realize it's possible to implement something similar with an edittext on a transparent panel, but i didn't want buttons among other design headaches. i prefer the look of a pop-up.  
  
some sample use cases are attached.  
  
update:  
Version 1.8 attached. dialog opens with focus set and keyboard ready to go (amazingly, if you're using a bt keyboard, the system knows not to bring up the soft keyboard!)