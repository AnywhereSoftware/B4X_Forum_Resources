### [B4j] Javax print wrapper for UI and non-UI apps. by stevel05
### 10/31/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/143865/)

This is a wrap of the Javax print API. It is more complex to use than the Javafx print API but does have a few benefits such as being usable in non-UI apps and access to java Swing printable interface which makes it easy to print the content of swing nodes. The main example app contains an example of printing text from a swing jTextArea, which is automatically split into pages. There is a separate example of printing a pdf from a file which contains a minimal wrapper for Apache pdfbox and also utilises a swing node.  
   
This is a large library and contains a fair amount of wrapper code that I hope will make it a little easier to use, but there is so much in it that it is not possible to make it simple. So if you want to try it, please read up on how it is supposed to work. I don't have the time to write a full tutorial, that would probably take a good few days on its own, but the wrapper is here if you want to try it out. As the library is so large, I cannot guarantee that everything will work first time, I have tested most of it while writing the example apps, so probably about 80% of it has been tested. Please report any errors that you find and I will try to fix them as quickly as possible.  
   
You can take the code from the examples if it provides a function you want to use.  
   
A big benefit of writing this wrapper was that it made me rethink the use of the Javafx print library, which is where the recent [Textflow](https://www.b4x.com/android/forum/threads/printer-example-print-text-with-the-jfx8-printer-library.143690/#post-910679) example came from. Also when digging and researching I found that the Javafx print library is already a wrapper for the javax print API, so using javax print classes in a Javafx app shouldn't use any more resources than using the Javafx print library.  
   
The main print functions run on a thread, so cannot be used in debug mode and will raise an error if you try to do so, but there are non threaded versions if you really want to use it in debug mode and the example apps demonstrate how to do this. The printer dialogs are modal, so they will hold the UI thread and make it unresponsive. The use of threading can't do anything about this, but if your print takes a long time to finish, it will return control of the UI as soon as the last dialog is displayed, rather than holding it until the print has actually finished.  
   
You will notice in one of the examples that a different print dialog is displayed, this is the 'Common' print dialog. I have not been able to force the display of the 'native' dialog (on windows at least) even though there is an option to do so.  
   
As usual, I have only tested on a Windows PC, if you use it on Mac or Linux, let me know how it goes.  
   
There are 2 example apps in this post, one is a UI app that uses Pane and buttons to provide selection, the other is a non-UI app, which has a minimal swing UI, just to make it easier to navigate. This is most definitely not required to use the library. I may post some more examples if I come across something interesting. The actual class code contained in the example apps are identical (I hope), just the methods of accessing them differ slightly from UI to non-UI.  
   
Example apps additional dependencies:  

- none

  
**Setup**  
  

- Download the b4xlib file and copy it to your B4x additional libraries.
- Download and unzip one or both of the example projects,
- Download the zipped image files from my [Googledrive](https://drive.google.com/file/d/1v6ota0CG3FRgaI14GZxnT2DP0si5WpKY/view?usp=sharing) and unzip them into the files folder of the project (both projects use the same files so copy them to both if you download both projects). Don't forget to sync the files folder once copied.

  
**The example projects print to the system default printer so make sure that a virtual PDF printer is selected to save paper.** Or see the commented code in the sub PrintImagePrinterJobDo to set the attributes to print to a specific printer.