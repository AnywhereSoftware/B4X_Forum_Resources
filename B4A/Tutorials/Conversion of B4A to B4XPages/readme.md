### Conversion of B4A to B4XPages by Cliff McKibbin
### 11/26/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/136366/)

**Introduction**  
  
The conversion of the first of my B4A Apps to the newer B4XPages structure was not trivial and involved over 20 hours of research, overcoming misunderstandings, and finding answers to many questions. This document is intended to be a reference for anyone that undertakes the task. Hopefully, it will help speed up the process.  
  
Some of the steps are very short and most are quite mechanical so don’t be dismayed by the number of steps. After the first conversion you will get faster and any shared modules will help a lot. My own learning curve and this doc reduced the conversion time from over 20 hours to around 6 hours for most apps. Now all my apps have the same B4XPages structure, use the new Title Bar Menus, and use B4XViews. I have not bitten off B4I yet, but hopefully I will be better positioned to do it.   
  
You may run into a library or other situation that can add time to your conversion. The GPS and Blue Tooth mods mentioned below added hours to my effort and weren’t solved without Erel’s help.   
  
You can use the checklist at the end of the doc to document your own progress.  
  
This pdf illustrates the level of my knowledge and I will not be able to answer any questions related to other issues.  
  
**References**  
  
Primary reference: [[B4X] B4XPages - Cross platform and simple framework for managing multiple pages | B4X Programming Forum](https://www.b4x.com/android/forum/threads/b4x-b4xpages-cross-platform-and-simple-framework-for-managing-multiple-pages.118901/)  
XUI views reference: [[B4X] [XUI] Cross platform & native UI library | B4X Programming Forum](https://www.b4x.com/android/forum/threads/b4x-xui-cross-platform-native-ui-library.84359/)  
Methods to avoid: [[B4X] Features that Erel recommends to avoid | B4X Programming Forum](https://www.b4x.com/android/forum/threads/b4x-features-that-erel-recommends-to-avoid.133280/)  
Code ‘Smells’: [[B4X] "Code Smells" - common mistakes and other tips | B4X Programming Forum](https://www.b4x.com/android/forum/threads/b4x-code-smells-common-mistakes-and-other-tips.116651/#content)  
  
**The pdf documents (attached) include:**  
  
Section 1. Introduction and references.  
Section 2. Choose the Basic Approach.  
Section 3. The Conversion  
 Step 1. Create the new project with an 'X' name.  
 Step 2. Copy your existing infrastructure.  
 Step 3. Modify 'Main'.  
 Step 4. Add your 'Files' to the app.  
 Step 5. Add your libraries.  
 Step 6. Replace your manifest.  
 Step 7. Load Starter and other classes.  
 Step 8. Modify B4XMainPage.  
 Step 9. Compile the project and load any database.  
 Step 10. Load any shared modules.  
 Step 11. Modify Activities to Classes.  
 Step 12. Handle additional problems.  
 Step 13. Convert menus to the title bar.  
 Step 14. Transition to the use of B4XViews.  
 Step 15. Update any Help files.  
 Step 16. Transition the app back to the original app name.  
Section 4. Common Errors.  
Section 5. Checklist for App Conversion.  
  
Sorry, I had to break up the pdfs so they could be uploaded.  
  
If you have comments/corrections on anything please let me know and I will certainly fix it.  
  
If this doc saves you time and you want to help, please feel free to download 'Rate My Shows' from the Play Store. It is free without ads at present but does include an optional $2.99 annual subscription if you care to donate. If you watch Netflix, Amazon Prime, HBO, etc. and can't keep up with what you've watched and not watched, this app might help. If you have a spreadsheet already, you can import it.  
  
Just downloading it will give me some customer counts and I hope you like it. Tell your friends as well.