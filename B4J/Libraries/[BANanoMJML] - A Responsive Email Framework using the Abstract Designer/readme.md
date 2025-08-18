### [BANanoMJML] - A Responsive Email Framework using the Abstract Designer by Mashiane
### 09/06/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/121539/)

Ola  
  
[Download](https://github.com/Mashiane/BANanoMJML)  
  
[Complete Youtube Playlist](https://www.youtube.com/playlist?list=PLXw1ldc5AxBP8q3V4NPkSzUPcP-57YZI-)  
  
Get details of latest tutorial projects [here](https://www.b4x.com/android/forum/threads/bananomjl-responsive-email-projects.121921/)  
  
***NB: Ensure that you have unique names for the components on the designer***  
  
In other news: This library has been purely created with the [BANanoCVC (CustomViewCreator)](https://www.b4x.com/android/forum/threads/banano-creating-banano-custom-views-with-the-banano-custom-view-creator-webapp.120086/#post-757025)  
  
This has been one of my bucket list things, the ability to create response emails. We will take a step by step approach into creating a variety of responsive emails that you can send to customers etc. This library is based on [MJML](https://mjml.io/), we will build it as we go along and then release it.  
  
Whilst there are tools like this on the interweb, some cost money (whilst based on the original MJML framework) and some not. So I wondered if this could be done.  
  
I managed to find another library created by someone else that helps wrap MJML inside a browser as its built for NodeJS.  
  
**The first project.**  
  
![](https://www.b4x.com/android/forum/attachments/99064)  
  
For our first project, we will create some basic components which we will later compile to HTML for sending via email. To do this we fire our abstract designer and drag and drop some components to it.  
  
![](https://www.b4x.com/android/forum/attachments/99033)  
  
**Reproduction**  
  
1. Drop a MJApp on a new layout, give it a name of emailapp.  
2. Drop a MJBody inside the MJApp, give it a name of emailbody.  
3. Drop 6 MJSections inside the MJBody, these will will name companyheader, imageheader, introductiontext, twocolumnsection, icons and socialicons.  
4. These will have a background-color of #f0f0f0, #f0f0f0, #fafafa, white, #fbfbfb and #f0f0f0 respectively  
5. Save the layout as myemail.  
  
[Creating Company Header](https://www.b4x.com/android/forum/threads/bananomjml-a-responsive-email-framework-using-the-abstract-designer.121539/post-759763)  
[Creating the Image Header](https://www.b4x.com/android/forum/threads/bananomjml-a-responsive-email-framework-using-the-abstract-designer.121539/post-759780)  
[Creating the Intro Text](https://www.b4x.com/android/forum/threads/bananomjml-a-responsive-email-framework-using-the-abstract-designer.121539/post-759784)  
[Creating the 2 columns Section](https://www.b4x.com/android/forum/threads/bananomjml-a-responsive-email-framework-using-the-abstract-designer.121539/post-759789)  
[Creating Icons](https://www.b4x.com/android/forum/threads/bananomjml-a-responsive-email-framework-using-the-abstract-designer.121539/post-759794)  
[Creating Social Sharing Buttons](https://www.b4x.com/android/forum/threads/bananomjml-a-responsive-email-framework-using-the-abstract-designer.121539/post-759801)  
  
#FirstProjectConcluded