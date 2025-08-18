###  Shared Folders , sync subfolders click by a6000000
### 10/21/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/123689/)

a short note how add   
 /e  
to sync subfolders:  
  

```B4X
#Region Shared Files  
' top in B4XMainPage  
' press Sync in Files Manager  
' if not exist Shared Files Then robocopy error  
  
  
    #If txttxtnote  
    folder structure:  
    ProjectName  
      B4A  
        Files  
        ..  
      B4i  
        Files  
        ..  
      B4J  
        Files  
        ..  
      Shared Files  
        NameSharedFilesSubfolderwww  
        ..  
    #End If  
      
  
    'original: #CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"  
    ' for subfolders add /e  
    ' change line-end to:  ../Files" /e  
    #CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files" /e  
  
    ' add &args=/e change line-end to:  &args=/e&FilesSync=True  
    'Ctrl + click to sync files & subfolder: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&args=/e&FilesSync=True  
    'B4J Ctrl + click to sync files & subfolder: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\..\B4J\Files&args=/e&FilesSync=True  
    'B4A Ctrl + click to sync files & subfolder: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\..\B4A\Files&args=/e&FilesSync=True  
    'B4i Ctrl + click to sync files & subfolder: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\..\B4i\Files&args=/e&FilesSync=True  
  
  
    'original: 'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True  
#End Region
```