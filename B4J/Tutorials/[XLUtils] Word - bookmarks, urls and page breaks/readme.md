### [XLUtils] Word - bookmarks, urls and page breaks by Erel
### 06/21/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/131826/)

![](https://www.b4x.com/android/forum/attachments/115274)  
  
XLUtils v2.02 adds support for urls, bookmarks and page breaks.  
  
A **p**aragraph tag with the PageBreak attribute will start on a new page.  

```B4X
$"[p PageBreak=True]This will appear at the top of the page[/p]"$
```

  
  
The **url** tag can be used to create external or internal links.  
External link:  

```B4X
$"[p]www.b4x.com[/p]"$
```

  
Adding internal links is done in two steps: create a bookmark, add one or more links to this bookmark.  
  
Create **bookmark** and set its anchor to "top". Note that it is a self closed tag.  

```B4X
$"[p alignment=center][bookmark=top/][TextSize=22]Table Of Contents[/TextSize]"$
```

  
  
Create a link to this bookmark:  

```B4X
$"[p][TextSize=25]?[/TextSize][/p]"$
```