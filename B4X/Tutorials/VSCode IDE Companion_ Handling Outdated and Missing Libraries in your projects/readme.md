###  VSCode IDE Companion: Handling Outdated and Missing Libraries in your projects by Mashiane
### 05/14/2026
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/171011/)

Hi Fam  
  
**Update Libraries**  
  
When you execute "Open B4X Project" using the B4X IDE Companion, it will scan the internal and external libraries, build a library catalog from Erels github library mapping and the google sheet library index. For all your libraries on dist that are outdated, you are provided with an **Update** button and a counter that indicates how many libraries should be downloaded.  
  
If there are no download links for your libraries needed by your project, the extension will open the b4x threads with those libraries as indicated in the google sheet library index.  
  
Clicking Update will download your outstanding libraries into the Internal & External Libraries of your active platform project.  
  
![](https://www.b4x.com/android/forum/attachments/171501)  
  
**Missing Libraries**  
  
It happens at times that you open a project and its libraries are not in your internal / external libraries. The extension will download those libraries, if their download links are found in the library mapping json file. If not, one is able to have the b4x thread that has that library or perform a b4x search.  
  
One can hover on each of the library names and activate the b4x threads.  
  
#SharingTheGoodness