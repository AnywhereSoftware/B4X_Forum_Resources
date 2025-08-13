###  [XUI] BR_Button by Lucas Siqueira
### 07/28/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/149289/)

BR\_Button you are free to modify as you wish.  
  
Was created with the intention of leaving the button working equally in the 3 ides (b4a, b4i and b4j).  
  
![](https://www.b4x.com/android/forum/attachments/144144)  
  
  
With the possibility to define a custom font directly in the designer (b4a already does this, but in b4i it is a little more complicated)  
  
You can also add an icon, along with the text on the button.  
(adding icons to buttons costs loading time)  
  
You have three statuses for the button enabled, disabled and pressed (in the b4a this already exists, but in the b4i it does not exist).  
  
In the background I used the panel and canvas to draw the text and the icon.  
  
  
  
  
in b4i it is necessary that you add each font name to the main, in addition to adding the files inside the .\Files\Special folder  
#AppFont: Inter-Black.ttf  
  
in the designer you must inform exactly the name of the font Inter-Black.ttf, there are some cases that the file name is not the name of the font, you must rename the file name to be exactly the same name as the font, to work correctly on b4i. (Custom Fonts: <https://www.b4x.com/android/forum/threads/custom-fonts.46461/>)  
if you still have difficulties finding the exact name of the font in b4i, use the code to discover the name (<https://www.b4x.com/android/forum/threads/customfont-problem.65538/post-415157>).  

```B4X
For Each s As String In Font.AvailableNames  
 Log(s)  
Next
```