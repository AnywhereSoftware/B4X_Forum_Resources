### SithasoDaisy2: Let's create a Libs.json Generator for Aeric's Additional Libraries Downloader by Mashiane
### 08/27/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/168361/)

Hi Fam  
  
[Use Tool hosted on PocketHost](https://oneplace.pockethost.io/libjson2/index.html)  
  
Aeric has created an amazing tool to download Additional Libraries. This however needs a **libs.json** file for it to work. A sample of that file has been created on his post.  
  
<https://www.b4x.com/android/forum/threads/tool-additional-libraries-downloader.166880/#content>  
  
I was thinking about how this file can be generated from the already existing [libraries list](https://docs.google.com/spreadsheets/d/1qFvc3Q70RriJS3m_ywBoJvZ47gSTVAuN_X04SI0_XBw/edit?gid=0#gid=0) created by Erel. The source code of this app will be made available when completed.  
  
So let's create the tool.  
  
1. One will be able to import Erel's libraries list using an excel file. We will convert the google sheet to an Excel file and import it to the tool  
2. We will then be able to generate the libs.json file we need from the list of available libraries.  
  
**Step 1**  
  
We have a table that will list all the libraries available.  
  
![](https://www.b4x.com/android/forum/attachments/166281)  
  
We will be able to edit a record from the list, in case something has a typo or whatever. The only thing about the google sheet currently is no clear indication of whether a file is a .jar or a b4xlib, however the latter will always be assumed.  
  
![](https://www.b4x.com/android/forum/attachments/166282)  
  
The following YT shows how one can upload the b4x libraries to the tool.  
  
  
[MEDIA=youtube]bkxYukx8iCg[/MEDIA]