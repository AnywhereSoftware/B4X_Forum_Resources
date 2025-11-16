### [Pakai] Creating a Blog by aeric
### 11/12/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/169296/)

[HEADING=1]**Introduction**[/HEADING]  
This tutorial is a continuous to [**[Tutorial] Pakai framework v6**](https://www.b4x.com/android/forum/threads/pakai-framework-v6.169286/)  
I assume you already have the default project successfully running on development.  
In this tutorial, we will continue to work with 2 libraries, **MiniHtml** and **MiniORMUtils**.  
[HEADING=1]Let's Start[/HEADING]  

1. So far, we have 2 entities or I will call them models. They are **Categories** and **Products**.
2. Let's leave Categories as it is.
3. We will remove Products and create a new model call **Articles**.
4. You can name it as Posts if you like but I don't want to confuse with the HTTP POST method.
5. Right click on the ProductsHandler and click Remove.
![](https://www.b4x.com/android/forum/attachments/168278)6. Then we right click on the Handlers group and add a **Server Handler**.
![](https://www.b4x.com/android/forum/attachments/168279)7. Give it a name ArticlesHandler and click Ok.
![](https://www.b4x.com/android/forum/attachments/168280)8. You will see a new handler class is created.
9. Inside Class\_Globals sub, start typing pakai until you see a dialog pops up showing the (code snippets) Pakai handler Globals v6.00.
![](https://www.b4x.com/android/forum/attachments/168282)10. Press enter and you will get the code added as showed below.
![](https://www.b4x.com/android/forum/attachments/168283)11. Now delete the code after line #9.
12. Start typing pakai again and this time we select the second code snippet.
![](https://www.b4x.com/android/forum/attachments/168284)13. Now there are more code added for you and the word plural is highlighted in amber colour.
![](https://www.b4x.com/android/forum/attachments/168285)14. Press Backspace and type the word **articles**. Press Tab to go to next highlighted word.
![](https://www.b4x.com/android/forum/attachments/168287)15. Press Tab and now it is highlighting on the word Model.
![](https://www.b4x.com/android/forum/attachments/168288)16. Change it to Articlesand press Tab.
![](https://www.b4x.com/android/forum/attachments/168289)17. Press Tab to skip on the word SERVER\_URL.
![](https://www.b4x.com/android/forum/attachments/168290)18. Similarly, change the dbtable to tbl\_articles and singular to article.
![](https://www.b4x.com/android/forum/attachments/168291)19. When the cursor returns to top of page, you know you can confirm the changes by pressing Enter.
20. Now you have a new server handler for Articles.