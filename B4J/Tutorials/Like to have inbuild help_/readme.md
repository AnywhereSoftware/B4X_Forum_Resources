### Like to have inbuild help? by Guenter Becker
### 07/07/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/171484/)

Hello,  
for all those who like to have a build in help in their application and don't know how to do I like to publish my solution  
used in my B4J/Windows Apps.  
  
The way is easy.  
  
1st create an application **manual with MS Word** and save it as Word file.  
![](https://www.b4x.com/android/forum/attachments/172287)  
2nd Download an Install the free app **chmProcessor**.  
3rd Open the App and **Add the Word file** and klick **Generate** a **chm file is generated**.  
4th In your App place a **button to open the help file** and use **fx.ShowExternalDocument(File.GetUri("<Folder>",<filename>))  
  
EXAMPLE**  
Button code: fx.ShowExternalDocument(File.GetUri(file.DirAssets,"Manual.chm"))  
Result by clicking on the Button opens the Windows Help System Dialog like this.  
![](https://www.b4x.com/android/forum/attachments/172288)  
If you like to serve with help in different languages do it the same way and place .chm file for each language.  
I detect the device language in the *Main Sub App\_Created*. And if the chm file for the detected language is not found I switch to use my allways placed english.chm file.  
  
Have Fun….