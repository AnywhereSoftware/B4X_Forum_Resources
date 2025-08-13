### Convert a big Activity project to B4XPages by asales
### 12/09/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/157898/)

For years is scare me to convert a big project from Activities to B4XPages, mainly because the app is only for Android (and I don't have plans to IOS or desktop), but in several issues the answer from Erel is "switch to B4XPages".  
  
The other problem is because I have many apps in the Play Store and I always release updates. It would take a long time to made a full convert and other apps would be outdated.  
  
So, based in the answers to [this my question](https://www.b4x.com/android/forum/threads/b4xpages-and-activities-in-the-same-project.140811/#content), I started to convert it, creating a mix of b4xpages and activities in the same project, until the full convert.  
  
This is not my top big project, but it has dozens of libs, layouts and activities.  
  
We have this [great post](https://www.b4x.com/android/forum/threads/conversion-of-b4a-to-b4xpages.136366/) about convertion, which Cliff McKibbin says that it tooks more the 6-20 hours to full convert.  
I tooks me less than a hour to create this first mixed project.  
  
The project is in the Play Store for the last weeks, without any critical issue in Firebase Crashlytics.  
  
Keep in mind this is not a full convertion and, in some cases, will not get all the benefits of a B4XPages project, but it's a beginning and in the future will get it.  
  
This are the steps that I used:  
**1** - create a new B4XPages project  
**2** - change the package name  
**3** - copy all code from manisfest  
**4** - import all modules .BAS from the Activity project  
**5** - copy all files (include layouts) from the Files folder  
**6** - copy google-services.json file, because I use Firebase  
**7** - check all libs that is used in the Activities project  
**8** - copy subfolder /icon, that I use to adaptive icon  
**9** - copy all lines and references from Project Attributes region from Main module in Activity project to B4XMainPage in B4XPages project  
**10** - copy Process\_Globals e Globals variables (Main) to Class\_Globals (B4XMainPage)  
**11** - change references (in B4XPages):  
- Activity -> Root  
- Activity.Finish -> B4XPages.ClosePage(Me)  
- mainpage layout to your main page layout: Root.LoadLayout("mystartpage")  
**12** - change Admob ads to show and update in B4XPages format  
**13** - new modules will be included in the B4XPages format  
**14** - Priority activities to change to B4XPages:  
[due this issue](https://www.b4x.com/android/forum/threads/solved-open-b4xpage-from-a-activity-module.157382/), I need to change the activity module to B4XPage format to interact with the new b4xpage module.   
  
Any insigths, suggestions or tips to this post are welcome.