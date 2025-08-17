### [Web][SithasoDaisy] Navigating between differerent pages of your app by Mashiane
### 03/14/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/159908/)

Hi Fam.  
  
The attached gif bears reference. Here one is able via a click of a button to navigate from one page to another.  
  
![](https://www.b4x.com/android/forum/attachments/151812)  
  
Remember, each page is created as a code module, thus one is able to reference the module and then call a method. There are 2 important subs in each page, (1) BuildPage and (2) Show.  
  
BuildPage is used to build your page using layouts or code, as we are using the "pageviewer" div to show each page of our page, each time we navigate to a page, we clear the pageviewer and then write the content to it again, creating a multi page application. We are not using a router here.  
  
Each Show sub, calls BuildPage, which will then clear the pageviewer and then inject the HTML needed for our page.  
  
We have different pages in our apps defined by different code modules, so we can just call .Show of each page to navigate to it as demonstrated in the gif.  
  
Enjoy  
  

```B4X
Private Sub btnServices_Click (e As BANanoEvent)  
    pgServices.Show(app)  
End Sub
```

  
  
PS: In the attached example, Ive removed the images, they might be reported as errors when you open the project.