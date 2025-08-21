###  [B4XPages] What exactly does it solve? by Erel
### 07/22/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/119078/)

B4XPages makes many things simple and even trivial.  
As Android developers, we are dealing with these challenges for many years now so it might take us a while to understand how simple things can be.  
  
As explained in [B4XPages tutorial](https://www.b4x.com/android/forum/threads/b4x-b4xpages-cross-platform-and-simple-framework-for-managing-multiple-pages.118901/), there are two purposes for B4XPages:  

1. Provide a cross platform layer.
2. Make it simple to develop B4A apps.

The advantages of the cross platform layer are clear. B4XPages hides many of the differences between B4A activities, B4i pages and B4J forms. With B4XPages it is trivial to create a multiple "pages" app where all of the code is shared (except of the template code which is just pasted to the main module).  
With activities, it requires creating an activity + shared class + page / form module for each page. A lot of work.  
  
Even if you are only interested in B4A development, B4XPages can help you a lot. I will list here all kinds of challenges that become simple with B4XPages.  
  
The three most important things regarding the B4XPage classes are:  

1. The page classes are 100% regular classes. They don't have a special life cycle and you can do whatever you like with them. There are some B4XPages events but they don't affect the state of the class itself. This is not the case with activity modules.
2. The page classes are never paused. Nothing special happens when a page is no longer visible or when the app moves to the background. Eventually of course, the whole process will be killed when the app is in the background.
3. The page classes are never destroyed separately. The class global variables and views state will never be reset (until the process is killed).

The 3 points above make many things simple. Some of them are:  

1. Events are never missed or queued.
2. Sleep calls are never cancelled. For example, no longer do we need to restart animations in Activity\_Resume.
3. The UI state is kept as long as the process lives.
4. In most cases we don't need to use the starter service.
5. We can directly call public methods of other pages. No need to use CallSub or CallSubDelayed.
6. We can directly access public global variables of other pages.
7. We can directly access and manipulate views of other pages.
8. We can decide whether to create the layouts immediately when a page is created (B4XPages.AddPageAndCreate).
9. We can move views between pages.
10. No need to worry from cases where CallSubDelayed starts the previous activity unexpectedly (usually happens with HttpJobs).
11. We can use the same page class to create many page instances.
12. A single place with a single and simple behavior for the global variables.
13. No need to think what should be initialized when FirstTime = True and what needs to be initialized every time.
14. No need to handle cases where a different activity, other than Main, is started first.
15. Better control over the pages stack as it is implemented in B4X code.
16. Automatic handling of the up indicator. No need to use AppCompat library for this.
17. Very simple and flexible way to handle the back key.
18. Background / Foreground events that are raised in all pages when the app moves to the background and to the foreground (not so simple to get with activities and required in many cases).
19. No distinguish between classes with "activity context" which must be declared in Globals to other classes that can be declared in Process\_Global.
20. No need to split the implementation between a stateless UI layer and a stateful non-UI layer.

  
You can see how the Bluetooth chat example became much simpler  
  
Old: <https://www.b4x.com/android/forum/threads/android-bluetooth-bluetoothadmin-tutorial.14768/#content>  
New: <https://www.b4x.com/android/forum/threads/b4xpages-bluetooth-chat-example.119014/#content>  
  
With that said, no one is forced to switch to B4XPages. Everything will continue to work exactly as before. It is too soon to rush and convert large working projects.  
B4XPages also has some limitations, especially regarding to the locked orientation (in B4A only) and it is still in a preliminary version.