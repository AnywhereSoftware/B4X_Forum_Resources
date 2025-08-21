### Java to the rescue: Creating a B4x app to help me beef up my library documentation by Mashiane
### 08/16/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/121293/)

Ola  
  
After some manual work on trying to document my BANanoVueMaterial library, I realized that I could do this better and also in a less error prone matter.  
  
**What is the problem?**  
  
I need to show the source code in a prism highlighter for each component in my library. So this means after each component, I need to show a prism component showing how that component was built using the library. Most of the work will be done via code.  
  
**What does this solve?**  
  
One will easier see and learn from the code how each component is created. One is also able to copy and or download the source code to use in their own apps.  
  
**How is this actually done? with some manual intervention…**  
  
Step1 - Copy code from the IDE  
Step2 - Paste the code to the java b4x app  
Step3 - Specify some parameters & Convert the code  
Step4 - Copy the code from the java app  
Step5 - Paste the code back to the IDE.  
  
This needs to cover each component that I want to prism highlight.  
  
**Huh?**  
  
Basically, we use existing code, convert it to code that will create a prism component, add the newly generated prism code back to the ide. This will show on our documentation.  
  
![](https://www.b4x.com/android/forum/attachments/98661)  
  
The output of this app is just the bottom part that we paste to our IDE code as an addition, it produces. I could have opted to use a single $""$ however, the simplified version helps with Sub and End Sub.  
  
![](https://www.b4x.com/android/forum/attachments/98662)  
  
**Lets rather watch this..**  
  
[MEDIA=youtube]aHWyqaQiyl8[/MEDIA]