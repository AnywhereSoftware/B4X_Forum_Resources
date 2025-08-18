### B4xpage custom transition by Marvel
### 01/19/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/126711/)

This is my attempt to try out custom transitions between B4xpages.  
Since the current b4xpage doesn't allow for simple transitions like "slide-in" without the previous page disappearing first, I decided to try out a custom transition.  
  
- I had to make use of the **AnimationPlus** library because the result was smoother than using setlayoutanimated with sleep  
- I added another sub in the transition class that makes use of **setlayoutanimated.** You can call that instead  
- There are still some issues like screen flickering at the end of the animation  
- Pages need to have been created first before using the transition  
- For the transition, you need to pass the root of the current page, the root of the page to navigate to, the destination page as object and the destination page ID  
- This is just a test and it is not anywhere near polished  
- I really don't know how it will perform in a larger project.  
  
![](https://www.b4x.com/android/forum/attachments/106530)