### [BANano] Creating BANano Custom Views with the BANano Custom View Creator WebApp by Mashiane
### 09/29/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/120086/)

Ola  
  
[Download](https://github.com/Mashiane/BANano-Custom-View-Creator)  
  
**Why the BANano Custom View Creator?**  
  
The beauty of [BANano](https://www.b4x.com/android/forum/threads/banano-website-app-pwa-library-with-abstract-designer-support.99740/#content) is that it enables one to use any front-end framework they want. This means that you can pick any framework like Bootstrap, VueJS, Pure, Bulma, Skeleton etc to use.  
  
Luckily, the Skeleton framework comes built in and I have done some interesting wraps too along VueJS. VueJS on the other hand meant that set BANano terms and conditions were broken to make it work. With that said, a proud moment with a lot of pleasure is realising this project.  
  
The **BANano Custom View Creator** is built using the BANanoVueDesigner i.e. VueJS+Vuetify on top of BANano. I opted for that approach because the designer generates most of the source code needed for CRUD. For the backend MySQL is being used. So the less code that was written to make this work was the advantage.  
  
If you don't want to use the built in BANanoSkeleton library, and for example need to use Bootstrap for your BANano Website / WebApp, you need to create custom views built following BANano's outline that will use Bootstrap. At least building the Bootstrap library will be done once. Hopefully when someone does that, they can make it available here in the forum. ;)  
  
To regress a little, when building [BANAnoVueMaterial](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-complete-opensource-vuejs-ux-based-framework-for-banano.113789/#content), I realized that I needed some extensions that I will use that will extend the core functionality of what I need. Each time I have to add an extension I have to follow the same methodology in ensuring that the extension works with BANAno. This means the same repetitive tasks. So I created some functions in my designer to make this work. Fortunately most vue libraries come up with everything that is needed i.e some JSON files that have all the attributes per component and this I imported to create the custom views that the [BANanoVuetifyAD (BETA)](https://www.b4x.com/android/forum/threads/bananovuead-beta-create-vuejs-vuetify-based-websites-webapps-using-the-abstract-designer.119772/) is using. This was tested with an [Online Store](https://www.b4x.com/android/forum/threads/banano-creating-an-online-store-website-webapp.119356/#content) and a [News App](https://www.b4x.com/android/forum/threads/banano-creating-a-news-website-webapp-in-less-than-100-lines-of-code.119262/#content). That went well.  
  
**The BANano Custom View Creator is framework independent**. Its purpose is to enable anyone to built custom views for any framework they need. Thing is, frameworks work differently and one needs to at least study the framework first and understand its workings before one starts creating the custom views.  
  
**Let's journey ahead.**  
  
To demonstrate this, we have gone to the basics, we will take a basic anchor tag as explained in W3Schools and then define its attributes using this tool and then peek at the generated source code that will be acceptable for our BANano Library. So we speak pure HTML5 here as a start. We will here with this 4 part series demonstrate how one can attempt to create a custom view that they can use in their library.  
  
Here is the complete playlist for this tutorial  
  
[BANano Custom View Creator on YouTube - Part 1 (Attributes)](https://youtu.be/3JZHLlq8bLo)  
  
[BANano Custom View Creator on YouTube - Part 2 (Styles)](https://youtu.be/WDfGkes5RAc)  
  
[BANano Custom View Creator on YouTube - Part 3 (Classes)](https://youtu.be/7oBbsAOi2hc)  
  
[BANano Custom View Creator on YouTube - Part 4 (Events)](https://youtu.be/zCpLPw2sAPs)  
  
**Part 1: Creating Attributes  
  
Let's watch a video a little so we can get our heads around this concept.**  
  
  
[MEDIA=youtube]3JZHLlq8bLo[/MEDIA]  
  
  
  
**Running the WebApp Locally.**  
  
1. Create a MySQL database called **bananocvc**  
2. In the 0. MySQL Backend folder, you will find a SQL file. Import this with phpMyAdmin.  
3. In the /assets folder find config.php and then update your connection settings to MySQL  
4. Run the app from your web server.  
  
Enjoy.  
  
PS: Many moons ago this was [MashSkeletor](https://www.b4x.com/android/forum/threads/mashskeletor-class-customview-sqlite-code-helper.91423/#content)