###  Canvas - ensure free mouse drawing without gaps (smooth continuous drawing) by moster67
### 04/26/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/116886/)

**EDIT: see posts #2 and #4 for better solutions thanks to Erel.**  
  
There might be better ways but I have used DrawRect() method of the Canvas in the past when I want to do free mouse/hand drawing on the screen.  
However, very often DrawRect() skips some points, i.e., leaves gaps if one tries to draw a continuous line. The gapping intensifies as pointer speed increases.  
  
I found this [thread on SO](https://stackoverflow.com/questions/43429251/how-to-draw-a-continuous-line-with-mouse-on-javafx-canvas/43429354#43429354) which suggested the following code to resolve it and indeed it seems to work very well.  
  

```B4X
Dim jo As JavaObject = Canvas1  
Dim jocan As JavaObject = jo.RunMethod("getGraphicsContext2D",Null)  
jocan.RunMethod("setStroke",Array(fx.Colors.Blue))  
jocan.RunMethod("setLineWidth",Array(5.0))  
jocan.RunMethod("lineTo",Array(EventData.X,EventData.Y))  
jocan.RunMethod("stroke",Null)  
jocan.RunMethod("closePath",Null)  
jocan.RunMethod("beginPath",Null)  
jocan.RunMethod("moveTo",Array(EventData.X,EventData.Y))
```

  
  
This image shows the difference.  
The first canvas at the top with blue drawings is using the above-posted code while the canvas below with red drawings shows the unsatisfying result when using DrawRect():  
  
![](https://www.b4x.com/android/forum/attachments/92614)  
  
I am attaching a sample project so you can try it out for yourself.  
  
I hope someone might find it useful. Happy coding.