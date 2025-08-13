### Basic Calendar custom view using designer script extension by stevel05
### 07/24/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/149082/)

  
This is a very basic calendar view which is drawn using a designer script extension. Just based on my experience with this project, the result feels a little more fluid than doing it in the normal code flow.  
  

![](https://www.b4x.com/android/forum/attachments/143977)  
**V1.02**

  
  
  
It is very simple to use. There is a Callback to the parent class / module that requests text describing entries for each day as they are displayed, keyed on a long date. So when you match a date it should contain no time information. Other than that, how you collect and store the data is up to you.  
  
Attached are an example project and a b4xlib version. **To use the b4xlib you will need to copy the 3 layout files from the example to your project (not Layout1.bjl)**. I didn't include them in the library as it is very unlikely that you would use it without wanting to modify the layouts in some way so it's just easier to deal with them separately.  
  
For ease of use, I have incorporated scrolling with a mouse wheel, press control to scroll through years (there's a song in there somewhere), and a drop down selector for each. You can limit the years in the dropdown, but it does not stop moving outside of the range with the buttons.  
  
You can also choose to start the week on a Sunday or a Monday, and set the month and day names.  
  
There are no external dependencies.  
  
**Updates**  
[INDENT]V1.00 initial version[/INDENT]  
[INDENT]V1.01 19 Jul 2023[/INDENT]  
[INDENT=3]Update to change internal date parsing from text to numbers, and set the month and day names.[/INDENT]  
[INDENT]V1.02 24 Jul 2023[/INDENT]  
[INDENT=2]Added LineColor to allow for dark mode[/INDENT]  
[INDENT=2]Added Today button (Displays current month) [/INDENT]  
[INDENT=3]Download at least the B4xlib and caledarlayout.zip file. I've zipped the calendarlayout file , if it doesn't unzip correctly, grab the layout from the project file.[/INDENT]  
Enjoy