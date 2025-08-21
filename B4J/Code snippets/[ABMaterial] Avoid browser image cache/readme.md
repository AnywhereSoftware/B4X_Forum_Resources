### [ABMaterial] Avoid browser image cache by Xandoca
### 05/22/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/118092/)

Straight to the point:  
  
Just add a random number after image path then browser will never use the cache for that image. Actually is a "new" image every time for the browser.  

```B4X
page.CellR(1,1).AddComponent(ABMShared.BuildImage(page, "logoempresa","../uploads/logo.png" & "?" & DateTime.Now,1,"",187,106,False))
```

  
  
I've used DateTime.Now to generate the random number.  
  
Details:  
A page, from my ABMaterial application, allows the user upload an image that will be used as company logo.   
I've noticed that if image uploaded with same name (old image) browser will cache that file and even is a different image browser still use the cached image.   
I've found the workaround over [here](https://stackoverflow.com/questions/126772/how-to-force-a-web-browser-not-to-cache-images).  
As I'm not a html expert I took a while to understand what's going on and find a solution.