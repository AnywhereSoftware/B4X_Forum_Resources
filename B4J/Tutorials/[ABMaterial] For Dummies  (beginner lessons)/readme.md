### [ABMaterial] For Dummies  (beginner lessons) by Harris
### 05/03/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/88346/)

**[SIZE=6]ABMaterial For Dummies[/SIZE]**

  
  
[SIZE=4]*[SIZE=4]This has often *been* asked for - so it is high time to produce a simple set of guidelines to help get you across the short learning curve. Take your time and see what you have been missing in simplifying web app creation with **ABMaterial**![/SIZE]*[/SIZE]  
  
**[SIZE=6]IMPORTANT UPDATE[/SIZE]**  
**——————————————————————————————————————**  
[SIZE=5]**[USER=974]@alwaysbusy[/USER] created THIS wonderful and simple tutorial on May 3rd, 2020**[/SIZE]**.**    
[SIZE=7]**[ABMaterial] Mini Template for absolute beginners**[/SIZE]  
<https://b4x.com/android/forum/threads/abmaterial-mini-template-for-absolute-beginners.117237/>  
**——————————————————————————————————————**  
  
[SIZE=4]\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*[/SIZE]  
[FONT=Georgia][SIZE=5]Having problems with your great understanding ABM?   
Check the links with lessons 8 and 9 below for solutions..[/SIZE][/FONT]  
[SIZE=4]\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
  
***[SIZE=4]PLEASE - DO NOT Post QUESTIONS here![/SIZE]  
[SIZE=4]It only serves to muddy the waters of a clean flow.[/SIZE]*  
  
PLEASE** - Post any questions / comments in the **B4J Questions forum** (title - ABM for dummies).[/SIZE]  
[SIZE=4]If you have a request for something not covered here - please post it. We shall try to accomodate.[/SIZE]  
  
**Lesson 1** - Master Template Project (covers Grids, BuildPage and ConnectPage). **Required**! - Contains all files for ABMaterial projects  
**Lesson 1a** - More on ABM Grids ( Rows and Cells )  
  
**Lesson 2** - Simple ABMLogin with Public / Private Pages  
  
**Lesson 3** - MySQL and CRUD / ABMTables  
**Lesson 3a** - More about ABMTables  
  
**Lesson 4** - Working With Containers  
  
**Lesson 5** - ABMGenerator  
**Lesson 5a** - Report Setup  
  
**Lesson 6** - Sample Next Reports  
  
**Lesson 7** - ABMGenerator revisited (includes ABMTable)  
  
**Lesson 8** - Deployment Problems (Local Development vs Server Differences)  
[**<https://www.b4x.com/android/forum/threads/abmaterial-for-dummies-beginner-lessons.88346/#post-609895>**](https://www.b4x.com/android/forum/threads/abmaterial-for-dummies-beginner-lessons.88346/#post-609895)  
  
**Lesson 9** - Tips and Tricks  
[**<https://www.b4x.com/android/forum/threads/abmaterial-for-dummies-beginner-lessons.88346/page-2#post-611983>**](https://www.b4x.com/android/forum/threads/abmaterial-for-dummies-beginner-lessons.88346/page-2#post-611983)  
  
On the surface, ABMaterial appears to be a complex framework - which in fact, it is. However, through the series of specific topics (new posts), we will expose how easy it is to use - and construct beautiful / functional web apps.  
  
The first post in this series (ok, the second) will have a **complete project** based on [USER=974]@alwaysbusy[/USER] (empty) **Template project** included in each version he releases. It shall use ABM version 4.03 which is available to everyone. This well documented example will expose the Template page (populated with controls), a simple About page and the ABMShared code module containing the navigation bar and component themes. *This is generally enough to get a newcomer started - since it actually does something!*  
  
We encourage others who are proficient with ABM to contribute **well documented** examples to this tutorial. Usually, this will be in the form of a **stand alone "page"** that can be added to the project, and any support methods needed which should go into the ABMShared code module.  
For the pupil, he/she will download your .bas and add it to the project, create a menu item in the nav bar, add requirements in Main to initialize and any methods for ABMShared.  
  
Many lessons (new posts) will be added with simple sections - as not to over-complicate matters.  
  
Here is a small sample of what to expect:  

```B4X
public Sub ConnectPage()  
    ' connecting the navigation bar - now that we have built one above…  
    ' examine the code in ABMShared to see how this works…  
    ABMShared.ConnectNavigationBar(page)  
  
  
    ' Let's add some components to the page - labels (with text), buttons and other controls…  
    ' page.Cell(1,1).AddComponent(ABMShared.BuildLabel - here we add a label component to Row 1 / Cell 1, using a single statement  
    ' and a method found in ABMShared Code Module.  
    ' page.Cell(1,1).AddComponent(ABMShared.BuildLabel(page, "basic1",  - each component MUST have a Unique ID ("basic1" in this case)  
    ' Notice that the text is right-justified…  How???  Using a theme - "lbltheme1"  
    ' I will let you discover what the other parameters are for this method…  
    page.Cell(1,1).AddComponent(ABMShared.BuildLabel(page, "basic1",   "See the faint green dot above in title bar?  This means your websocket is connected! {BR} All of this page's code is explained in the source file! {BR}{NBSP}",  ABM.SIZE_H4, "lbltheme1", 0, "25px"))  
  
    ' Here we add another component in Row 2, Cell 1 - It is essentially a label with block quote  
    page.Cell(2,1).AddComponent(ABMShared.BuildParagraphBQWithZDepth(page, "basic13",   "Hi There!  I am in Row 2 of this page!   {BR}{BR} I Have 'Flow Text' Applied. What does that mean? Resize this browser window and watch THIS text size shrink and grow accordingly!" ))  
  
    ' Lets do something different in Row 3…  
'………………………………………
```

  
  
![](https://www.b4x.com/android/forum/attachments/63718)  
  
The second post will have a link to download the base project - since it is much too large to attach here.  
  
  
Thanks