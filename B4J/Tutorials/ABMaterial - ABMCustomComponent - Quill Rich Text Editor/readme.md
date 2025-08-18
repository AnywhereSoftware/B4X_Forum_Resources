### ABMaterial - ABMCustomComponent - Quill Rich Text Editor by Harris
### 03/23/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/139305/)

In **ABMaterial** version **4.95**, [USER=974]@alwaysbusy[/USER] introduced me to a **new** method of handling **Rich Text Editing** - in the form of an **ABMCustomComponent** called **CompQuillEditor** (and likely, much to his chagrin)… **Anyway**, the cat's out of the bag, so here goes my novice attempt to implement it…. (It isn't all that bad… lot's of good!).  
  
**[SIZE=7]NOTE[/SIZE]**[SIZE=5]: **DO NOT** **POST** ANY **QUESTIONS** OR **COMMENTS** HERE! (other than likes)[/SIZE] This tutorial is a work in progress ( me learning this ). **When completed, I shall remove this restriction.**.. ( by removing this line ).  
  
There are many sections to this learning process, so hang tough and stay with me….  
  
**Why Use This (CompQuillEditor )?**  
There are many advantages as I have found. They shall be exposed in upcoming sections of this tutorial!  
Microsoft Word - this is **not**! BUT, it is all you **may need** for your **ABM** app ( very powerful )…  
Quill is a free and powerful JavaScript and well adopted RTE. As you shall see…  
Check it out at: <https://quilljs.com/>  
   
  
**A Brief Tickler…**  
  
This image shows a **CompQuillEditor** without a toolbar **(read only).** Scroll within to view contents.  
Note: One can adjust the height of the editor view (more later).  
  
![](https://www.b4x.com/android/forum/attachments/126856)  
  
This image is where one can edit the contents. One can add links or images which is embedded into the text content (it's HTML).  
**Note**: A toolbar is exposed where you can format the text.  
There are times where I won't allow adding IMAGES (and size of) into the text stream. The toolbar can be controlled to prevent this!  
  
![](https://www.b4x.com/android/forum/attachments/126857)  
  
  
All of my understanding of this was a result of studying the underlying code.  
[USER=974]@alwaysbusy[/USER] is an expert coder and helped me see how all the parts work.  
  
Next sections shall break this all down so you can implement this into your projects (rather complex - for me anyway - not for you JS experts).  
( baby steps )…  
  
Thx