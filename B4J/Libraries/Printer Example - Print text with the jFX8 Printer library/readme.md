### Printer Example - Print text with the jFX8 Printer library by stevel05
### 05/16/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/143690/)

This is an example of printing text using the jFX8 Print library with TextFlow and Text class objects.  
  
By parsing the text and measuring and creating text classes per line as required by wrapping it creates multiple pages and prints them to one print job.  
  
There are also options to break on word, highlight alternate rows with color, underline rows solid or dashed, remove double empty lines and add audit columns to enable simple auditing tasks.  
  
Provided that the textflow is the top most view in the printed node, the text is selectable in a PDF viewer.  
  

![](https://www.b4x.com/android/forum/attachments/135145)  
  
This example was printed to PDF and the annotations added with Foxit pdf reader. I am all in favour of saving paper.  
  
  
![](https://www.b4x.com/android/forum/attachments/135144) ![](https://www.b4x.com/android/forum/attachments/135160)  
  
A straight forward print of text from a String variable. It will also print from a file.

  
  
**Dependencies:**  
[jFX8Print Library](https://www.b4x.com/android/forum/threads/b4j-print-javafx8.49836/#content) - B4xlib  
[TextFlow Library](https://www.b4x.com/android/forum/threads/b4j-textflow-and-text-class.143689/#content) - B4xlib  
[jReflection](https://www.b4x.com/android/forum/threads/jreflection-library.35448/#content)  
  
I haven't created a gui for it I may do it later but if anyone fancies it, feel free.  
  
Let me know how you get on with it.