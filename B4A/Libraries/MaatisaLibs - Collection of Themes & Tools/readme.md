### MaatisaLibs - Collection of Themes & Tools by Mohsen Torabi
### 06/29/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/119573/)

[FONT=trebuchet ms]Hi to all.  
First of all, My English is bad so i am sorry.[/FONT]  
I am using B4A for long time, and I am thankful to B4X community and Erel, Because it changes my programming life.  
This is my first semi-pro;) library, So i hope it will be useful for you.  
  
This lib contains 4 Classes and one manifest attribute for changing theme in ***version 1.00***.  
1- ***MaatisaScaleFont v1.00*** Class: Balanced [ICODE]FontSize[/ICODE] in any Devices.  
[INDENT]How to work:[/INDENT]  

```B4X
Sub Globals  
  Dim msp1 As MSP  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
  msp1.Initialize(Activity.Width)  'Initialize lib object with width of your Activity  
  Dim lbl As Label  
  lbl.Initialize("")  
  lbl.Text = $"Maatisa ScaleFont [sp] Library${CRLF}Written by Mohsen Torabi"$  
  lbl.Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL  
  lbl.SingleLine = False  
  lbl.Textsize = msp1.sp(15)    'Set best font size to Label  
  Activity.AddView(lbl , 0 , 0 , 100%x , 10%y)  
  Log(msp1.About)  
End Sub
```

  
  
2- ***MaatisaLinkSupport v1.00*** Class: Labels with Link Support.  
[INDENT]How to work:[/INDENT]  

```B4X
Dim lbl1 as Label  
Dim mls1 As MaatisaLinkSupport  
mls1.LinkSupport(lbl1)
```

  
  
3- ***MaatisaCustomToast v1.00*** Class: A custom toast message with custom *FontFamily, FontColor, FontSize, Shape Color and Shape's border radius*.  
[INDENT]How to work:[/INDENT]  

```B4X
Dim mct1 As MaatisaCustomToast  
mct1.Initialize("Welcome to Maatisa products", Typeface.DEFAULT_BOLD, Colors.Black, 16, Colors.Yellow, 20dip)  
mct1.Show("" , True)
```

  
In *"Initialize"* method you can set your default *msg*, Or change it for once time in *"Show"* method, That means if *msg* in *"Show"* method be *empty* it uses default *msg.*  
  
4- ***MaatisaPersianNumber v1.00*** Class: Converts any digits to ***Persian*** digits. (It is useful to Middle-East users, Persian, Arabic and…)  
[INDENT]How to work:[/INDENT]  

```B4X
Dim mpn1 As MaatisaPersianNumber  
Activity.Title = mpn1.PerNumber("1234567890")
```

  
  
Source Codes and Documents are available in zip file to download.  
  
5- ***Available themes in Library:*** *[Contains 20 Themes]*  

```B4X
Dark [Default dark theme]  
Light [Default light theme]  
Blue [Dark parent]  
Orange [Light parent]  
Pink [Light parent]  
Purple [Light parent]  
Cyan [Light parent]  
Brown [Dark parent]  
Yellow [Dark parent]  
Darkness [Dark parent]  
Maatisa1 [Dark parent]  
Maatisa2 [Dark parent]  
Maatisa3 [Dark parent]  
Maatisa4 [Dark parent]  
Maatisa5 [Dark parent]  
Maatisa6 [Dark parent]  
Maatisa7 [Light parent]  
Maatisa8 [Dark parent]  
Maatisa9 [Dark parent]  
Maatisa10 [Dark parent]
```

  
  
***How it Works:** [use this line in manifest]:*  

```B4X
CreateResourceFromFile(Macro, MaatisaLibs.Blue)
```

  
  
***Image of Theme colors:***  
![](https://www.b4x.com/android/forum/attachments/96354)  
  
***Some screenshots:***  
![](http://s13.picofile.com/file/8401115392/Maatisa10.png)![](http://s13.picofile.com/file/8401115350/Maatisa8.png)![](http://s12.picofile.com/file/8401115276/Maatisa4.png)![](http://s13.picofile.com/file/8401115268/Maatisa3.png)![](http://s13.picofile.com/file/8401115384/Maatisa9.png)![](http://s13.picofile.com/file/8401115426/Yellow.png)  
  
***MaatisaLibs v1.00***  
  
I hope you Enjoy!