### [B4j] [B4a] ZT-Zip by stevel05
### 06/03/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/99595/)

Here is another Zip iibrary for B4j/B4a. It wraps this zt-zip project from github : <https://github.com/zeroturnaround/zt-zip>. zt-zip licence is **[SIZE=3]Apache License 2.0[/SIZE]**  
  
The advantages of this one are that it can insert, replace and remove files without having to unpack and repack the zip file, and you can add and extract items from/to byte arrays.  
  
There are two main classes:  
  
Zips, which wraps the fluent API and provides most of the day to day operations, and a static module ZIPUTILS which is slightly more complex to use but provides greater control.  
  
I have wrapped most of the Methods available (but haven't tested them all) if there are any in the documentation that you need but can't wrap them, let me know and I'll take a look.  
  
**Zips**  
*Class Module  
A FluentAPI for zip handling*  
  

- **Events:**

- **Item**(ZEntry As ZipEntry)

- **Functions:**

- **AddEntries** (Entries As Object()) As Zips
*Specifies entries to add or change to the output when this Zips executes.  
 Entries is an object array containing either FileSource or ByteSource or both.*- **AddEntry** (Entry As Object) As Zips
*Specifies an entry to add or change to the output when this Zips executes.  
 Entry can be either a FileSource or a ByteSource*- **AddFile** (DirName As String, FileName As String) As Zips
*Adds a file entry.*- **AddFile2** (DirName As String, FileName As String, PreserveRoot As Boolean) As Zips
*Adds a file entry.*- **AsJavaObject** As JavaObject
*Returns the wrapped object as JavaObject*- **Charset** (TCharset As String) As Zips
*Specifies charset for this Zips execution*- **Class\_Globals** As String
- **ContainsEntry** (Name As String) As Boolean
*Checks for the existence of the specified path/name*- **Create** As Zips
*Static factory method to obtain an instance of Zips without source file.*- **Destination** (DirName As String, FileName As String) As Zips
*Specifies destination file for this Zips execution, if destination is null (default value), then source file will be overwritten.  
 Will create a new file if it doesn't exist*- **Get** (DirName As String, FileName As String) As Zips
*Static factory method to obtain an instance of Zips.*- **GetEntry** (Name As String) As Byte()
Get an entry by path/name as an array of bytes- **GetObject** As Object
*Returns the wrapped object as Object*- **Initialize** As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Iterate** (Module As Object, EventName As String) As String
*Scans the source ZIP file and executes the given callback for each entry. As Sub {EventName}\_Item(ZEntry As ZipEntry)*- **PreserveTimestamps** As Zips
*Enables timestamp preserving for this Zips execution*- **Process** As String
*Iterates through source Zip entries removing or changing them according to set parameters.*- **RemoveEntries** (Entries As String()) As Zips
*Specifies entries to remove to the output when this Zips executes.  
 Entries is String Array of Paths / Names*- **RemoveEntry** (Entry As String) As Zips
*Specifies an entry to remove to the output when this Zips executes.*- **SetObject** (Obj As Object) As String
*Set the underlying Object, must be of correct type*- **SetPreserveTimestamps** (Preserve As Boolean) As Zips
*Specifies timestamp preserving for this Zips execution*- **Unpack** As Zips
*\**
  
  
**Depends On:**  

- zt-zip-1,13.jar
- slf4j-api-1.7.25.jar
- slf4j-jdk14-1.7.25.jar

zt-zip Download and javadoc can be found here : <https://search.maven.org/artifact/org.zeroturnaround/zt-zip/1.13/jar>  
If you don't already have the slf4j (logging api) files you can get them from here: <https://www.slf4j.org/download.html>  
  
Download those required, and copy the jars to your additional libraries folder.  
  
Please report any bugs.  
  
Source code is attached, you can compile it to a library if you prefer. There are also some examples in the Main module.  
  
**Update:** Found that it works with B4a with 1 very minor change (As with all new libraries, please test it before use on important zip files).  
  
**B4xlib available in post 3**. Thanks [USER=55689]@walt61[/USER]