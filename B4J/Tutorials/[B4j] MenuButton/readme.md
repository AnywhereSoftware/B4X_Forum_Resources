### [B4j] MenuButton by stevel05
### 09/18/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/151950/)

I wanted to add a menu to a form that is to be used in a narrow portrait orientation. I have dealt with this before using a normal button and a popup menu. but as there is a MenuButton control in JavafX I thought I'd wrap it.  
  
  

![](https://www.b4x.com/android/forum/attachments/146015)

  
  
Nothing spectacular to see, but functional.  
  
There are a few custom options which are pretty self explanatory:  
  

![](https://www.b4x.com/android/forum/attachments/146016)

  
  
As most of my projects are now incorporating dark and light themes I have started adding a Use Stylesheet option where appropriate. Selecting this will clear the styles added by the designer and add appropriate Styleclasses :  

![](https://www.b4x.com/android/forum/attachments/146017)

  
  
For this view, the styleclasses are added regardless of selecting the option as there is a small css file in the library that hides the arrow and sorts out centring of the label as a graphic in the button.  
  
You can set the fonts for the menu items and the tooltip separately. The label is used as a graphic for the menubutton, so any font set in the designer will be kept.  
  
Menu Items are added in the same manner as for a Menubar, using a JSON string, or In code using the MenuButtonCV.Items method.  
  
Full code is in the project and there is a B4xlib as well.  
  
**Update V1.02** 17-Sep-2023  
[INDENT]Removed Logs and added more comments.[/INDENT]  
[INDENT]Added Image for the button.[/INDENT]  
[INDENT]Added Shortcut - Accelerator keys[/INDENT]  
  
Let me know how you get on with it and if you encounter any issues.  
  
Enjoy.