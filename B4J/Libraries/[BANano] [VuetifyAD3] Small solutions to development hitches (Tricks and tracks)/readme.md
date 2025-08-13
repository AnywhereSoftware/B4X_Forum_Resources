### [BANano] [VuetifyAD3] Small solutions to development hitches (Tricks and tracks) by Star-Dust
### 11/23/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/137667/)

At the request of several friends, I opened this Thread which explains some problems encountered when developing with Banano and VuetiiFy.  
  
Obviously I will propose the solutions that I have experimented, perhaps they will not be the best, but they are those obtainable with the documentation available at the moment.  
  
**INDEX**  

1. [MAKE A VTextField visible or invisible](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches.137667/post-871268)
2. [CHANGE NUMBER OF COLUMNS AND NAMES IN A TABLE BY CODE](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches.137667/post-871269)
3. [SIDE MENU](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches.137667/post-871270)
4. CARD, ITERATIVE CYCLES AND …. ELECTRONIC SHOWCASE ( [Part-1](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches.137667/post-871525) , [Part-2](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches.137667/post-871530) , [Part-3](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches.137667/post-871532) , [Part-4](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches.137667/post-871541) , [SOURCE CODE](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches.137667/post-871547) )
5. [IN-LINE PHP](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches.137667/post-871644)
6. [LOCAL storage of data or variables](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches.137667/post-871652)
7. [Change properties of vLabel and VTextField from code](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches.137667/post-871931)
8. [VUETABLE- How to insert MinusPlus columns and editable fields](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches.137667/post-871970)
9. [Button inside a VTABLE and event raised](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches.137667/post-872527)
10. [MESSAGE box, INPUTDIALOG and ToastMessage](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-872575)
11. [REGEX SPLIT](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-872577)
12. [From http to https](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-872579) (insecure to secure)
13. [How can I cast form String to number?](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-885165)
14. [Upload file to DB](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-890642)
15. [Viewer image from DB](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-890643)
16. [Upload a file and save it in a folder](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-890726)
17. [List of file](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-890729)
18. [USE the php code from an external application](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-912978)
19. [Using MQTT from Banano VAD3 with a ListView](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-931625)
20. [Cast string into integer](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-966227)
21. [Set and remove focus](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-967006)
22. [Call a JavaScript function from your injected JS source](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-967007)
23. [Calls a sub from JavaScript source](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-967008)
24. [Example of mobile panel and GoogleMaps without Vuetify](https://www.b4x.com/android/forum/threads/banano-vuetifyad3-small-solutions-to-development-hitches-tricks-and-tracks.137667/post-967138)

  
  
[SIZE=5]**PLEASE DO NOT WRITE IN THIS THREAD**. If you have any questions or comments, open a dedicated threads, but don't post your posts here.[/SIZE]  
[SIZE=5]If you want to propose some other solution, open your specific tutorial[/SIZE]