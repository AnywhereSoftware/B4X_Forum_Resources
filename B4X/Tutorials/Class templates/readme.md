###  Class templates by LucaMs
### 09/21/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/168700/)

\*\*\* This is a trick, a discovery **[SIZE=6]by [USER=74499]@aeric[/USER][/SIZE]**, really very useful \*\*\*  
  
**[B4A-B4J-B4i]**  
  
**[This is a long post but the process is much simpler than it seems].**  
  
  
As you know, you can create your own project templates:  
<https://www.b4x.com/android/forum/threads/b4x-projects-templates.119901/#content>  
  
Creating your own class templates to add to your projects is an unknown feature, as far as I know. [USER=74499]@aeric[/USER] managed to do it!  
  
  
In this image you can see **which class templates** you can add to a B4J (or B4A/B4i) project:  
![](https://www.b4x.com/android/forum/attachments/167041)  
  
  
but here you can see that I now have two more class templates: "Aeric's B4XPage" and "Aeric's Sample Class":  
![](https://www.b4x.com/android/forum/attachments/167042)  
  
You might have your own class templates in that list.  
  
But how is that possible?  
  

1. Prepare your class templates; for example, you might have your own B4XPage template for log in/sign in (**MyLoginPage.bas**) and a class containing your utility functions (**MyUtils.bas**).
2. Change the extensions of the two .bas files to .b4x\_excluded:
**MyLoginPage.b4x\_excluded and MyUtils.b4x\_excluded**3. Create a .b4xlib library. It's very simple: create a zip file (for example, "**MyClassTemplates.zip**"), add the two classes and a text file, "**manifest.txt**" to it. Change the extension of this zip file: **MyClassTemplates.b4xlib**, which now contains:
![](https://www.b4x.com/android/forum/attachments/167043)4. The manifest.txt must contain the statement **CustomClassTemplates**.
The format of CustomClassTemplates is as follows:
CustomClassTemplates=<Menu class name>|<Class name (without extension) >, … (here other <Menu class name>|<Class name (without extension) >).
In this example it could be:
**CustomClassTemplates=lm Login B4XPage|MyLoginPage,lm Utils|MyUtils**
Add to the manifest file everything that this type of file can normally contain. In particular, indicate the type of projects supported:
Supported Platforms=B4A,B4i,B4J
or
Supported Platforms=B4A
etc.
  
(I chose terrible names, I hope this is clear anyway).  
  
Once this is done, place the library in the additional libraries folders, depending on the type of project you support. For example, if the classes work on all three "platforms," place the library in the B4X additional libraries folder.  
  
Import (select) the library (MyClassTemplates.b4xlib) into your project and yours will be among the class templates you can add.  
  
  
![](https://www.b4x.com/android/forum/attachments/167045)  
  
Now I could add a new "lmLoginB4XPage" or "lmUtils" class, not only "Standard Class"…  
![](https://www.b4x.com/android/forum/attachments/167046)  
  
  
Another way to add a new class (here is B4J - the same in B4A/B4i): mouse right click on the tab Modules:  
![](https://www.b4x.com/android/forum/attachments/167047)  
  
  
[SIZE=6]Once you have added the classes to your project, you can (**should**) remove your library (in this example: MyClassTemplates).[/SIZE]