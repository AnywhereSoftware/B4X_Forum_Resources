### INI files windows style class by FabioAlbaneseTv
### 04/13/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/116285/)

Hi,  
I've written this class to manage INI-likes files.  
It expose three main methods  
  
Initialize(pPath As String, pFilename As String ) - to init the object and create a INI file  
AddKey(pSection As String,pKey As String,pValue As String) As Int - to add or update a key with a new value - return 0=updated; 1=added; -1=no more space  
GetKey(pSection As String,pKey As String) As String - to get the content of a key