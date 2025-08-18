### [BANano] Why it is important to use unique names for your elements when not using AutoID? by Mashiane
### 06/29/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/132107/)

Ola  
  
I just spent some time nearly sweating as to why my app was not working properly. Turns out that my element names are not unique and as such a conflict arose.  
  
![](https://www.b4x.com/android/forum/attachments/115646)  
  
**Background**  
  
In one of my layouts i have a VFooter with a VFooter1 name. Then In another layout I put a footer with the same name ! Big mistake.  
  
In the new layout, my VFooter1 component was empty however when I went to inspect elements on browser, it had content. Scratch head!!!  
  
So the first layout with VFooter1 was loaded with all the elements inside, then the second layout with the second VFooter1 was also loaded. As much as this one was empty, but because these have the same names and identifier name VFooter1, they are treated as the same element. Children replicated across.  
  
So if you are not using AutoID in your elements, be careful to name your controls properly.   
  
After renaming the other footer to some unique name, my app works.  
  
Ta!