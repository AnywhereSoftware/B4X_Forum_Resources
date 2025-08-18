### HTMLEditorWrapper - Edit HTML by stevel05
### 04/07/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/139491/)

I got fed up looking for a simple solution to be able to add tables to the HTML editor, so in the vein of keeping it simple I decided just to make it super easy and edit the HTML source from the Editor instead.  
  
This wrapper just adds a code button ![](https://www.b4x.com/android/forum/attachments/127213) to the Editors toolbar and when selected displays a text area with the code from the editor which you can then edit and style with inline <style></style> tags.  
  

![](https://www.b4x.com/android/forum/attachments/127209) ![](https://www.b4x.com/android/forum/attachments/127210)

  
There is also a designer property that allows reducing the space between lines as in this [post](https://www.b4x.com/android/forum/threads/solved-reduce-space-between-the-two-lines-in-htmleditor.125862/post-786368) If your target output is not the editor, you will need to make sure that the same css for the p tag is somewhere in your styles to maintain the look.  
  
The attached project contains the code, and there is also a b4xlib.  
  
The HTML editor is basic and based on some online editors. It only handles a limited amount of tags and styles, but does what I require of it : Quickly setting up simple tables.  
  
To use, open the code editor window and place the cursor where you want the table inserted and click the Table button. To edit a table click anywhere within the table code, then click the table button. It will autoselect the table code and try to parse the tags.  
  
I have tried to make it warn if anything is likely to be lost, and occasionally it may refuse to parse a table if it doesn't recognise the tags or style formats.  
  
I wouldn't use the JavaFX HTMLeditor in a commercial situation as it quite often does strange things, especially when trying to do more than just basic editing. Not that I can find anything better that doesn't cost a fortune. But it is great for a programmers utility.  
  
Enjoy.  
  
  
**Dependencies**  
  
Requires jSoup jar 1.14.3, download from their [website](https://jsoup.org/download)  
  
**Updates:**  
  
V 1.1  

- Added Indent HTML with jsoup currently 1.14.3. download from their [website](https://jsoup.org/download)
- Added Indent Style tags - Custom code.
- Added mini table generator to the editor toolbar
- Added HTML table editor to the code area
- Added B4xPlusMinus click to edit (Numeric only)
- Added SL\_B4xColorTemplate to allow entry of values. Accepts hex and web format color codes and optionally returns an appropriate color string.

  
  

[MEDIA=youtube]\_ahSDdcU9NA[/MEDIA]

  
V 1.2  
  

- Bugfixes
- Restored table data remembers html styling from within the cells.
- Added Print to Job (Requires jFX8Print library and is commented out in the demo project code so you only need the lib if you want to use it.)
- Added PasteHTML to HTMLEW\_Utils
- Added getWebview to HTMLEditorWrapper (Needed to turn off the context menu)
- Added insert link. If an external link is followed it is not normally possible to use a back method as the HTMLtext update is not registered in the browser history I've added an extra reload HTML button that will re-load a snapshot of the html from just before the link was followed.
- Added insert Image

- Urls strings are not validated for insert link or insert image.

- Added edit link as a menu item.

- The whole link needs to be manually selected by the user and although this is validated, the validation can fail if there are two links with the same href, and the text in a second link matches the selected text from the first. It shouldn't happen often, but it can screw up the html if/when it does. I guess a proper undo should be implemented but therein lies other issues.

- Added edit image as a menu item. The image must be selected prior to clicking the edit option.
- Added OpenExternal as menu item. Will open an image or link in your default external viewer. Target must be selected as above.

There are No additional external dependencies.  
  

[MEDIA=youtube]LgFL8oROSJc[/MEDIA]