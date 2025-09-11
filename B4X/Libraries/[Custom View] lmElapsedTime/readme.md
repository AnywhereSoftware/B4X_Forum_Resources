###  [Custom View] lmElapsedTime by LucaMs
### 09/10/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/166301/)

**This custom view is cross-platform, works for B4A, B4J and should work also for B4I.**  
  
Ok, I'm publishing it (remember: I have to drink coffee, so **use now** the link in my signature 😁).  
  
You can see the description of this library in the next ("older") lines of this post.  
I later added the ability to activate (/resume) /pause the counter by clicking (or tapping) on the View (it's optional, it's a property (\*)).  
  
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

  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
  
I am undecided whether to publish this custom view or not (I am also undecided about its name). If you like it, if you find it useful.  
  
It is a time counter or "elapsed time".  
  
You can:  
decide whether to display the milliseconds / hours numbers or not;  
change the colors;  
border and corners;  
pause and resume.  
  
Oops, I almost forgot something important (not done yet): the font property. Later.  
  
![](https://www.b4x.com/android/forum/attachments/162909)  
  
  
BTW, used for a (famous) little game created for testing (to test ChatGPT capabilities).  
![](https://www.b4x.com/android/forum/attachments/162910)