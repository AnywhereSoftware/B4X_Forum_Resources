### Share Text File Between 2 Apps by aeric
### 06/01/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/161459/)

This is just another example based on the ManageExternalStorage class provided by [USER=448]@agraham[/USER].  
It is a response to [this question](https://www.b4x.com/android/forum/threads/sharing-info-between-3-apps.161442/).  
  
B4ARepositoryWriter - writes a text file to an "external" directory (you can view using File Explorer).  
B4ARepositoryReader - reads the text file in this directory if it exist.  
  
I guess if we are able to read a text file then it should be possible to read keyvaluestore or sqlite files.   
  
Note: I have modified slightly the class by modify the package name by reading Application.PackageName  
Credit to Andrew Graham  
  
![](https://www.b4x.com/android/forum/attachments/154224)