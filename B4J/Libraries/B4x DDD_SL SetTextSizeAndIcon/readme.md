### B4x DDD_SL SetTextSizeAndIcon by stevel05
### 06/24/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/141385/)

This is my first attempt at creating an additional class for the new designer script feature. It allows replacing the smallest (last) string in the list with an Icon and utilizes code from the original DDD class.  
  
Requires B4j 9.80 Beta +  
  
  
[MEDIA=vimeo]723725044[/MEDIA]  
  
  
  
It works best with FontAwesome Icons, MaterialIcons seem to size differently.  
  
Designer Script:  
  

```B4X
'All variants script  
DDD.CollectViewsData  
DDD.SpreadControlsHorizontally(Pane1, 800dip, 10dip)  
TextSize = 16  
DDD.SetTextSizeSteps(1,0.8)  
DDD_SL.SetTextSizeSteps(1,0.8)  
DDD.SetTextAndSize(Button1, TextSize, "Sunday", "Sun", "1")  
DDD.SetTextAndSize(Button2, TextSize, "Monday", "Mon", "2")  
DDD.SetTextAndSize(Button3, TextSize, "Tuesday", "Tue", "3")  
DDD.SetTextAndSize(Button4, TextSize, "Wednesday", "Wed", "4")  
DDD.SetTextAndSize(Button5, TextSize, "Thursday", "Thu", "5")  
DDD.SetTextAndSize(Button6, TextSize, "Friday", "Fri", "6")  
DDD.SetTextAndSize(Button7, TextSize, "Saturday", "Sat", "7")  
DDD_SL.SetTextAndSizeIcon(Button8, TextSize, "True", "14", "Click here", "Click", "0xF245")  
DDD_SL.SetTextAndSizeIcon(Button9, TextSize, "True", "14", "Undo last", "Undo", "0xF0E2")  
SimpleMediaManager.DesignerSetMedia(Pane2, "https://b4x-4c17.kxcdn.com/android/forum/data/avatars/o/51/51832.jpg?1648870462")  
SimpleMediaManager.DesignerSetMedia(Pane3, "https://images.pexels.com/photos/45911/peacock-plumage-bird-peafowl-45911.jpeg?cs=srgb&dl=pexels-pixabay-45911.jpg&fm=jpg")
```

  
  
Documentation:  
  

```B4X
'Extends DDD.SetText with adjustment of the text size and Icon. Note that the second parameter is the base text size.  
'Third parameter should be "True" for Font Awesome or "" for Material Icons  
'Parameters: View, Base text size, Icon Type, Icon size,  One or more strings, Icon hexvalue i.e. "0xF209".
```

  
  
I have only tested on B4j, let me know if there are problems on B4a or B4i (I can't test on B4i when it is available)