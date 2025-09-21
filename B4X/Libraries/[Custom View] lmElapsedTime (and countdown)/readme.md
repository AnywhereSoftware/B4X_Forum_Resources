###  [Custom View] lmElapsedTime (and countdown) by LucaMs
### 09/16/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/166301/)

**This custom view is cross-platform, works for B4A, B4J and should work also for B4I.  
  
UPDATE: V. 2.00 09/15/2025**  
Added: **ActAsCountDown**. As the property name suggests, you can now use it as both a countdown timer and an elapsed time counter.  
![](https://www.b4x.com/android/forum/attachments/166894)  
  
It is a time counter or "elapsed time" (v. 2 - also countdown timer).  
  
You can:  
decide whether to display the milliseconds / hours numbers or not;  
change the colors;  
border and corners;  
pause and resume.  
  
![](https://www.b4x.com/android/forum/attachments/162909)  
  
  
**UPDATE: V. 1.10**  
Added two properties and two methods to start counting with an initial value (methods) or to set the initial value (properties).  
**You should thank [USER=77305]@Sagenut[/USER] for these new features.**  
  
**PROPERTIES:**  

- ActOnClick (\*)
- BGColor - Background color
- BorderColor
- BorderWidth
- ElapsedTime
- ElapsedTimeString
- **CounterByString V. 1.10**
- **CounterByLong V. 1.10**
- CornerRadius
- FontSize
- LabelFont
- Paused
- ShowMilliseconds
- ShowHours

  
**METHODS:**  

- StartCounter
- **StartCounterFromString V. 1.10**
- **CounterFromLong V. 1.10**
- StopCounter
- PauseCounter
- ResumeCounter

  
**EVENTS:**  

- Click
- ElapsedTimeChanged
- StateChanged

  
  
  
BTW, used for a (famous) little game created for testing (to test ChatGPT capabilities).  
![](https://www.b4x.com/android/forum/attachments/162910)