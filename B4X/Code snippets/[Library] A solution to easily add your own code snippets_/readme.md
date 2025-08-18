### [Library] A solution to easily add your own code snippets? by LucaMs
### 01/29/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/126994/)

**EDIT:**   
> How wonderful, can you please give us an full example with b4xpages?

**Attached MySnippets.b4xlib and instructions about how you can add your own code snippets (see them after the line of asterisks in this post)**  
Watch the animated gif in post #7 to see how to use this library.  
  
—————————————————————————————————————————————————————–  
  
A little while ago I wrote:  
  
> A great feature: you can add comment lines to your methods (Subs) that contain code that you can copy and paste; even many lines of code.  
>   
>
> ```B4X
> ' This routine is useful to…  
> ' Example:  
> '<code>  
> ' here many "ready" code lines that can be easily copied and pasted by just one click.  
> '</code>  
> Public Sub DoSomething  
> End Sub
> ```
>
>   
>   
> I love it!

  
An idea is coming to my mind (on which to study a little) …  
  
If I developed a library (B4Xlib?) that contained fake methods (Subs) for the sole purpose of getting source code from them, code snippets?  
  
I might have a class for each category of snippets.  
  
In case my headache goes away and I don't decide to go and buy a guillotine to get rid of the cervical headache problem once and for all ?:mad: , I'll do some implementation tests.  
  
**\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
  
How to add snippets to this MySnippets.b4xlib library.**  
  
  
Method A:  
  
Directly using 7zip (or similar), without the need to unzip the library.  
Just open the library with 7zip, double-click on a class file name, your default text editor will open, add/modify this file and save it.  
**(\*)** You can also create a new "category class" (using your text editor or one B4X IDE) and then drag it on 7zip - again having it open as just written.  
  
  
Method B:  
  
Using the B4XPages project attached, MySnippetsClasses. Edit its classes, add snippet-routines (take as example Erel's Sub TextToBitmap, which is in clsB4XViews class),  
**(\*)** add a new "category class".  
  
  
**(\*)** If you create a new "category class", you must declare and create an instance of it in the "platform main class", as in:  
  
![](https://www.b4x.com/android/forum/attachments/107098)  
  
**clsB4A** is one of the four "platform main class" (there are: clsB4J, clsB4I and clsB4X).  
For example, if you create a "category class" that contains animation snippets, you could create a **clsAnimations** class, then you should:  
  
Add to Sub Class\_Globals:  
**Public Animations As clsAnimations**  
  
Add to Public Sub Intialize:  
**Animations.Initialize**  
  
  
Note that I haven't B4i. If you open B4i MySnippetsClasses project, you should add (menu Project - Add Existing Modules) to it the clsB4I\*.bas (select "Copy to project folder") and the clsB4X\*.bas (select "Link - relative path").  
  
  
///////////////////////////////////////////  
Note:  
if you use 7zip as suggested in "method A", this (MySnippets.b4xlib) can be a useful library, but a well done tool, perhaps developed with B4J, with which to manage a SQLite database of snippets would probably be a better choice. I think some already exist on this site.  
///////////////////////////////////////////  
  
  
It is not unlikely that this is all a bit too abstruse and that I will attach the wrong files. After all it's late at night, it's about 2:30 A.M. and… I'm already sleeping, while typing ??  
  
If you want, you can also throw everything in your trash: luckily for you it's free :)