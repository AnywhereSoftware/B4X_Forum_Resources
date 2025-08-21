### Expanded CLV inside an Expanded CLV by wes58
### 08/15/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/121229/)

This is not really a code snippet, but a working example (work in progress) showing how to create and use expanded CLV inside an expanded CLV - see attached picture. Both CLVs are scroll-able.  
I was looking for a solution like this, but only saw an example of CLVnested, which wasn't really what I wanted.  
After seeing a thread of [USER=2074]@tsteward[/USER] in the Questions forum, I decided to try to help him and do even more what he wanted. And attached is an example.  
  
This example shows how to (how I did it!)  
- clicking on buttons on the first clv1 updates imageviews in all items of clv2 for this clv1 item.  
- clicking on clv1, expands it, and fills the second clv2 - which can be scrolled.  
- only one item can be expanded at the time  
- clicking on clv2 or any other "clickable" items (there are two image views that can be clicked on in this example) expands clv2  
- clicking on the buttons in the expanded clv2, updates imageviews on clv2 and collapses clv2 item  
  
If anyone has any other ideas how to make it better/simpler please share it here.