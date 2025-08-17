### B4J Shell commands list and launch tool by PaulMeuris
### 08/24/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/142532/)

In my previous tutorial i gave a hint to what the next project would be like.  
In this tutorial you can compose shell command lines.  
Each line consists of an Executable entry, a Working directory entry and an Arguments entry.  
Sometimes you don’t need to provide arguments for the command.  
In the case of the PDFbox\_test application we have added some code for this application to accept an argument (see the previous tutorial).  
This is what it looks like when you start the application:  
![](https://www.b4x.com/android/forum/attachments/132937)  
The application has 2 layout variants: one wide screen width and one half screen width.  
![](https://www.b4x.com/android/forum/attachments/132938)  
The layout is kept simple and strait forward. Copy and paste the information from an application in the text areas and press the launch button at the end of the command line. The waste bucket in the beginning of the command line allows you to delete the line.  
The blue Add button allows you to add a command line in the first row.  
The yellow Load button presents an open dialog to select a commands text file. If you cancel that dialog the default text file (commands.txt) will be used if there is one.  
The green Save button presents a save dialog to select a path and type a filename. If you cancel the dialog and the commands.txt file is present then you can overwrite that file (if you answer yes)!  
The orange Clear button clears the contents of the message bar and the commands list. A new empty command line is presented.  
Let’s look at some examples:  
![](https://www.b4x.com/android/forum/attachments/132939)  
![](https://www.b4x.com/android/forum/attachments/132940)  
![](https://www.b4x.com/android/forum/attachments/132941)  
![](https://www.b4x.com/android/forum/attachments/132942)  
As always you can find the code in the attached zip-file.  
Hope you like this tool.  
Happy coding!  
Paul.  
P.S.: if you have made a really cool list with this application maybe you like to share it?