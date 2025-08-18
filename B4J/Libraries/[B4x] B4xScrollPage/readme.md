### [B4x] B4xScrollPage by stevel05
### 02/04/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/124554/)

Scroll between pages of data for any view.  
  
When the page scrolls update the data for the next page and it is scrolled into place.  
  
  
[MEDIA=youtube]nOecIVZdrcM[/MEDIA]  
  
  
The attached B4xScrollPage.zip contains a B4XPages project has examples (and full code) for B4j and B4a.   
  
**B4i :** It should also work with B4i but you will need to copy the layouts, and provide the B4xScrollPage layout for the library.  
  
Vertical and Horizontal scrolling is supported. In the B4j version you can scroll with the mouse wheel when the mouse pointer is over the B4xPlusMinus label.  
  
**When you load the project, don't forget to click 'Ctrl + click to sync files: at the top of the MainPage.**  
  
Take a few minutes to read the code to understand how it works:  
  
You are required to make two calls to the B4xScrollPage, one to set the layout which can contain any view. And one to tell the B4xScrollPage how many pages are available and set the first page to display.  
  
You also need one sub \_SetPageData in which you set the data for the specified page.  
  
There will be a limit on the amount of data that can be held in the view, only in the time required to render it during the scrolling. If it is too large, the scrolling will be slow. If you are using a customlistview with a large amount of data, you will need to implement lazy loading.  
  
Let me know how you get on with it.  
  
**Update: 1.1 Library**  

- added SetPageNames to allow a named list to be passed rather than a numeric range.
- added optional layout to designer properties and auto selection of a no button layout if ShowPageControl = False
- added LoadPage1(Name As String, Direction As Int)
- added LoadPage2(Index As Int,Direction As Int)
- added Constants DIRECTION\_NEXT and DIRECTION\_PREV

Update Example:  

- Added example of saving page data

The optional layout is intended for use f you want to move the B4xPlus and Minus buttons. The new layout MUST contain all of the existing views. If you just want to hide the B4xPlusMinus and add your own control, you can deselect Show Page Control in the designer. The Content pane will then fill the Base pane and you can add your own control in the layout that contains the B4xPageScroll.