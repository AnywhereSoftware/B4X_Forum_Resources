### CheckBoxes / RadioButtons - **Warning** this code may smell by Robert Valentino
### 04/22/2022
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/140050/)

I have a large B4A bal that has about 40 checkboxes and 10 radiobuttons that I am thinking of converting to B4i  
Now B4i doesn't have checkboxes (has switches) and doesn't have radiobuttons.  
  
When copying the fields from designer in B4A to B4i All my checkboxes are made into switches and all my radiobuttons are lost.  
  
So I looked at the program Bal2Bil (<https://www.b4x.com/android/forum/threads/tool-bal2bil-b4a-layouts-converter.50197/#content>) and changed it to make checkboxes & RadioButtons into ImageViews (attaching modified code)  
  
Then I wrote these 2 classes CheckBox & RadioButtons and that I am including in the test example.  
  
This is just a look and feel. (example is made for iPad - Landscape)  
  
I'm not sure how much this code smells. But it does work  
  
![](https://www.b4x.com/android/forum/attachments/128304)