### [BANanoZUI] Creating Zoomable User Interfaces with ZircleUI by Mashiane
### 07/27/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/120514/)

Ola  
  
[Download](https://github.com/Mashiane/BANanoZUI)  
  
[Playlist on YouTube](https://www.youtube.com/playlist?list=PLXw1ldc5AxBOaIQ-wSGWAMH6m6vN8DjMj)  
  
IMPORTANT: You will find [tutorials using LiveSwapping to develop BANanoZU interfaces](https://www.b4x.com/android/forum/threads/bananozui-having-a-blast-with-liveswapping-whilst-creating-zui-zoomable-user-interfaces.120568/#post-753759), here  
  
[MEDIA=youtube]COr6GAfsKOo[/MEDIA]  
  
  
  
Well I have been wanting to create something like this for a very long time eversince I saw [Prezi](https://prezi.com). So I decided that during my breaks I will explore this. Fortunately its such a small lib so we will finish it within a couple of hours. Let's say an hour a day. :)  
  
So I found this nifty library and decided to test it out. Its called [ZircleUI](https://zircleui.github.io/docs/) The nice thing is its very simple and you can also use your imagination here. This is a VueJS based library. As a first lesson, we will just create a "Hello World" application.  
  
This is what we will do… and we will add to this as we go along. Let's have an open mind..  
  
![](https://www.b4x.com/android/forum/attachments/97542)  
  
**Reproduction**. (We will follow the examples in the websites to create this)  
  
1. Drop a VHTML on the designer and give it a tag of "div" and a name of "app" - THIS IS A COMPULSORY NAME.  
2. Drop another VHTML inside it and give it a "z-canvas" tag, you can name it whatever you want. Update the "attributes" to be  
  

```B4X
:views=$options.components
```

  
  
3. Drop another VHTML inside the "app", div, give it a tag of "div", set VShow to "placeholder", we want this hidden when the app runs. Save the layout as pagezircle.