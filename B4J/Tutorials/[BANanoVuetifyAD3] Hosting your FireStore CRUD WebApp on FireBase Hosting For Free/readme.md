### [BANanoVuetifyAD3] Hosting your FireStore CRUD WebApp on FireBase Hosting For Free by Mashiane
### 10/05/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/143033/)

Hi there  
  
Ok granted, when it comes to creating WebApps that has to be hosted on Firebase, one has to be very careful about costs. A good friend of mine reminded me this again.  
I guess for simple MVPs, proof of concepts and other things, the free tier from firebase comes very handy.  
  
They call is the **Spark Plan**, it still look too good to be true for a $0/cost per month platform. These are some of the things it offererd.  
  
![](https://www.b4x.com/android/forum/attachments/133830)  
  
So after I optimized my concept BVAD3 WebApp, I ran some simple scripts to get it hosted. It has some CRUD forms and also a leaflet map.  
  
The deployment was easier than what I thought. Just go to hosting and follow the instructions as they are). Also when installing the Firebase CLI on your PC, just use the default parameters provided.  
  
![](https://www.b4x.com/android/forum/attachments/133831)  
  
1. First build you app in B4J and then follow the instructions about hosting above.  
2. After all that, copy all the BANano generated i.e content (assets/scripts/styles/[index.html/favicon/manifest](http://index.html/favicon/manifest)) to the **public folder**  
3. execute firebase deploy  
  
There is also functionality to set Github Actions and other things.  
  
  
![](https://www.b4x.com/android/forum/attachments/133832)  
  
Related Content  
  
[**BANanoVuetifyAD3 - Full Stack WebApp using Vuetify & FireStore (No PHP)**](https://www.b4x.com/android/forum/threads/mashy-teaches-webapp-website-development-with-bananovuetifyad3-the-new-series.132305/post-880400)  
  
Happy BVAD3 Coding.  
  
**Update:  
  
Related Content**  
  
[MEDIA=youtube]id=UFLvSp4Mh9k;list=PL4cUxeGkcC9itfjle0ji1xOZ2cjRGY\_WB[/MEDIA]