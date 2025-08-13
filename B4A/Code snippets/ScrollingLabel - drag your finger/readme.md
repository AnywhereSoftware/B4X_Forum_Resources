### ScrollingLabel - drag your finger by drgottjr
### 06/16/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/161679/)

if i have text to show whose content is too great (or too large) to fit on one screenful,  
i want to be able to scroll the text up and down with my finger (or, optionally, left to  
right and back).  
msgbox can handle this, but it may not be the "look" i'm after. webview is a very  
workable solution, and - if you know html - you can make a very nice-looking document.  
then there is edittext which also scrolls up and down. but if you touch the view the  
wrong way or linger too long on the screen without flinging, the keyboard pops up and  
little thingies appear around that part of the screen where you were caught lingering.  
the more you touch, the more little thingies keep appearing. so annoying.  
  
what about a label - what android calls "textview"? can a label scroll? well, we  
appear to have a scrolling label, implemented as a custom view. but if i understand  
correctlly, it is more a self-scrolling animated view. i want to scroll up and down with  
a finger at my leisure.  
  
maybe we already have this. i searched for "scrolling label". what i saw did not address   
what i was looking for, so implemented it.  
  
a few lines with javaobject sets it up:  
  

```B4X
    Dim label1 as Label  
    label1.Initialize("")  
    Activity.AddView(label1,0%x,0%y,100%x,100%y)  
    label1.Gravity = Gravity.TOP  
  
    Dim labeljo, scrollerjo As JavaObject  
    labeljo = label1  
    scrollerjo.InitializeNewInstance("android.text.method.ScrollingMovementMethod",Null)  
    labeljo.RunMethod("setMovementMethod",Array(scrollerjo))  
    'if you want horizontal scrolling, add this line:  
    labeljo.RunMethod("setHorizontallyScrolling",Array(True))
```

  
  
clean off your pointer, and you're good to go. tested on android 12 and 14