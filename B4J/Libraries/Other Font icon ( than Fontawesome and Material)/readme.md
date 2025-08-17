### Other Font icon ( than Fontawesome and Material) by jkhazraji
### 10/20/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/156060/)

There are more than 30 icon fonts , I am familiar ( and possibly others) with Fontawesome and Material design only.  
I came a cross a project (IKONLI) that uses these fonts and it states that:  
"…(they) integrate so seamlessly with the existing 'controls'. An icon is simply an extension of the “Text” node (duh!) and it comes with styleable properties. There are properties for the  
icon itself, the icon “code”, for its color and for its size. The names of these properties in CSS files also follows convention. There they are called -fx-icon-code, -fx-icon-color, and -fx-icon-size". I decided to work on it and as a start I used one font called (elusive).   
  
***-The properties*** of the integrated icon whether in a button or a label are:  
  
***-Icon code*:** *taken* from an icon browser. it always starts with a prefix denoting the font name  
***-Icon color***: *is* set manually at the time being. simple colors as red, blue, green, black.., etc.  
***-Icon size***: *Which* is scalable and fills the container space accordingly.  
***-Container type***: *usually* a button or a label hosting the font icon.  
***-Text attributes*** *(picked in the designer)*: Text, color, font, size, alignment.  
  
***-Events:***  
*only one* ***(btn\_click\_Event)*** *to make the button of use for the sake of the user. It generates the button name(that is what I can do now).*  
![](https://www.b4x.com/android/forum/attachments/147020)