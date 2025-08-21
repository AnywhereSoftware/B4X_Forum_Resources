### [BANano] - Creating a News Website / WebApp in less than 100 lines of code by Mashiane
### 06/22/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/119262/)

Ola  
  
[Download](https://www.b4x.com/android/forum/threads/banano-creating-a-news-website-webapp-in-less-than-100-lines-of-code.119262/post-746328)  
  
First get yourself an API from NewsApi, this is free for non-commercial apps, **<https://newsapi.org>  
  
![](https://www.b4x.com/android/forum/attachments/95936)**  
  
The API provides one with latest top news in batches of 10 items at a time and also sources of those news..  
  
![](https://www.b4x.com/android/forum/attachments/95928)  
  
For this I could have used BANanoFetch, you can too, but I wanted to test my BANanoPHP lib in getting json files from the net, so I ran this.  
  

```B4X
Dim fKey As String = $"https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=${apiKey}"$  
    ' we will use php getjson  
    Dim bPHP As BANanoPHP  
    bPHP.Initialize  
    Dim articlesJSON As String = BANano.CallInlinePHPWait(bPHP.FILE_GETJSON, bPHP.BuildFileGetJSON(fKey))  
    Dim articlesMAP As Map = BANano.FromJson(articlesJSON)  
    Dim items As List = MyApp.newlist  
    Dim articles As List = articlesMAP.getdefault("articles", items)
```

  
  
We convert this to a simple card.  
  
![](https://www.b4x.com/android/forum/attachments/95932)  
  
  
Next we need a way to loop though each article and then display it in our page. With the abstract designer, this is rather easy. We design out card outline.  
Each card with an article will be rendered inside an RC (i.e. row column). Each column should span 8 spaces. We place various elements into our stage depending on where stuff should be..  
  
![](https://www.b4x.com/android/forum/attachments/95933)  
  
Of course the social media buttons are just for show. We have a chip, a spacer, some buttons with icons inside and then a spacer and another button.  
  
In the definition of the "Read More" button, we **bind** its HREF to the article url.  
  
![](https://www.b4x.com/android/forum/attachments/95934)  
  
So when one clicks the URL, it will open up the page that has that news article.  
  
We needed a way to list all the top articles via a loop. As earlier indicated, the card definition sits on an RC, this RC is inside the div. We need to tell our app that we will create a new card for each new article we have. In VueJS this is rather easy with a v-for directive,  
  
![](https://www.b4x.com/android/forum/attachments/95935)  
  
See the Key and VFor properties in the bag for the div.