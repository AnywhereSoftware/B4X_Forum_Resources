### [BANanoPhpFileAPI] PHP File Management for BANano by Mashiane
### 10/23/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/135369/)

Ola  
  
Some time ago I published this.  
  
<https://www.b4x.com/android/forum/threads/php-the-ultimate-file-management-php-functions.134401/>  
  
So here is the BANano Version. #Have Fun, Extend.  
  
**BANanoPHP**  

- **Initialize** (sLogFile As String, bIncludeResponses As Boolean) **As BANanoPHP**
initialize the class for use
sLogFile - you can pass it the LogFile name if you want to keep logs of what the library is doing
bIncludeResponses - include the response of the operations of the logs- **FileGetInfo** (fileObj As Map) **As FileInfo**
gets the infor about the file from file input

```B4X
'gets the file info from an input component and save to FileInfo type  
dim fi As FileInfo = FileGetInfo(fileObj)
```

- **FileUploadWait** (fileO As Map, limit As Long, targetDir As String) **As FileInfo**
upload file to server and return success or error
server should have write permissions
targetDir - the target directory, will be created if it does not exist
fo is the file object for file input change event

```B4X
'upload a file to assets folder  
Dim res As String = BANano.Await(FileUploadWait(fo, "./assets"))
```

- **DeleteLogFileWait As String**
delete the log file

```B4X
'delete the log file  
Dim res As String = BANano.Await(bPHP.DeleteLogFile)
```

- **UpdateLogWait** (content As String) **As String**
update a log file with content

```B4X
'update the log file  
Dim res As String = BANano.Await(bPHP.UpdateLogWait("Started BANanoPHP…"))
```

- **FileCreateWait** (fileName As String, content As String) **As String**
write a text file and wait

```B4X
'create a new text file with contents  
Dim res As String = BANano.Await(bPHP.FileCreateWait("./assets/mashy.txt", "Creating a new text file"))
```

- **DirectoryListWait** (directoryPath As String) **As Map**
get the directory listing

```B4X
'get the directory listing  
Dim dl As Map = BANano.Await(bPHP.DirectoryListWait("./"))
```

- **FileExistsWait** (fn As String) **As String**
check file existence and returns yes or no

```B4X
'check file existence  
Dim fe As string = BANano.Await(bPHP.FileExistsWait("./mashy.txt"))  
if fe = "yes" then  
'the file exists  
else  
'the file does not exist  
end if
```

- **DirectoryRenameWait** (oldname As String, newname As String) **As String**
rename / move a directory

```B4X
'rename or move a directory  
Dim res As String = BANano.Await(bPHP.DirectoryRenameWait("./assets1", "./assets2"))
```

- **DirectoryExistsWait** (fn As String) **As String**
check directory existence and returns yes or no

```B4X
'check directory existence  
Dim fe As string = BANano.Await(bPHP.DirectoryExistsWait("./anele"))  
if fe = "yes" then  
'the directory exists  
else  
'the directory does not exist  
end if
```

- **FileReadWait** (fn As String) **As String**
get the file contents

```B4X
'get the file contents  
Dim text As String = BANano.Await(bPHP.FileReadWait("./mashy.txt"))
```

- **FileAppendWait** (fn As String, content As String) **As String**
append text to a file use \n for new lines

```B4X
'append text to a file  
Dim res As String = BANano.Await(bPHP.FileAppendWait("./mashy.txt", "This is new content…"))
```

- **FileAppendNewLineWait** (fn As String) **As String**
append a new line to a file

```B4X
'append a new line to a file  
Dim res As String = BANano.Await(bPHP.FileAppendNewLineWait("./mashy.txt"))
```

- **FileRenameWait** (oldname As String, newname As String) **As String**
rename a file

```B4X
'rename a file to another returns file existence  
dim res as string = BANano.Await(bPHP.FileRenameWait("./mashy.txt", "./mashy1.txt"))
```

- **FileCopyWait** (fn As String, newLocation As String) **As String**
copy a file to another or another directory, it will create folder structure if not existing when copying to another directory
'Example: bPHP.FileCopyWait("./mashy.txt", "./mashy1.txt")
'Example: bPHP.FileCopyWait("./mashy.txt", "./assets/mashy1.txt")

```B4X
'copy the file  
Dim res As String = BANano.Await(bPHP.FileCopyWait("./mashy.txt", "./mashy1.txt"))
```

- **FileDeleteWait** (fn As String) **As String**
delete a file

```B4X
'delete the file  
Dim res As String = BANano.Await(bPHP.FileDeleteWait("./mashy.txt"))
```

- **DirectoryCreateWait** (dirName As String) **As String**
create a directory, this also can create recursively
Example: bPHP.DirectoryCreateWait("./mashy")
Dim res As String = BANano.Await(bPHP.DirectoryCreateWait("./anele/mashy/mbanga/is/enjoying/BANanoPHP"))

```B4X
'create a directory  
bPHP.DirectoryCreateWait("./mashy/1")
```

- **WebsiteGetHTMLWait** (siteURL As String) **As String**
get an html file from site

```B4X
'get the HTML of a website  
Dim res As String = BANano.Await(bPHP.WebsiteGetHTMLWait("http://thedomain.com"))
```

- **GetJSONWait** (siteURL As String) **As String**
get json

```B4X
'get JSON from an API  
Dim res As String = BANano.Await(bPHP.GetJSONWait("http://jsonip.com"))
```

- **GetIPAddressWait As String**
get your internet IP address

```B4X
'get IP Address  
Dim res As String = BANano.Await(bPHP.GetIPAddressWait)
```

- **DirectoryDeleteWait** (dirName As String) **As Boolean**
delete directory completely

```B4X
'delete the directory recursibely  
Dim res As String = BANano.Await(bPHP.DirectoryDeleteWait("./assets/anele"))
```

- **DirectoryListRecursiveWait** (dirName As String) **As List**
directory list recursively

```B4X
'get the directory listing recursively  
Dim res As String = BANano.Await(bPHP.DirectoryListRecursiveWait("./assets/mashy"))
```

- **ZipDirectoryWait** (dirName As String, zipFileName As String) **As String**
zip a directory

```B4X
'zip the directory to a file  
Dim res As String = BANano.Await(bPHP.ZipDirectoryWait("./scripts", "./mashy.zip"))
```

- **UnZipWait** (zipFileName As String, targetFolder As String) **As String**
unzip a file

```B4X
'unzip the file to a target location, target folders will be created if they dont exist  
Dim res As String = BANano.Await(bPHP.UnZipWait("./mashy.zip", "./assets"))
```

- **DirectoryCopyWait** (dirName As String, targetLocation As String) **As String**
directory copy, target location folder is created if it does not exist

```B4X
'copy the directory to a new location, target folders will be created if they dont exist  
Dim res As String = BANano.Await(bPHP.DirectoryCopy("./scripts", "./backup scripts"))
```

- **PathInfoWait** (dirName As String) **As String**
get path info for a file

```B4X
'get path info for a file  
Dim res As String = BANano.Await(bPHP.PathInfoWait("./scripts/file1.txt"))  
Dim pm As Map = BANano.FromJson(pathinfo)  
Dim dirname as string = pm.get("dirname")  
Dim basename as string = pm.get("basename")    'file name with extension  
Dim extension as string = pm.get("extension")  
Dim filename as string = pm.get("filename")    'filename without extension
```

- **SendEmailWait** (fromEmail As String, toEmail As String, ccEmail As String, subject As String, message As String)
send an email
to send email via gmail, you need to set less secure apps on <https://myaccount.google.com/>
1. Click Security

```B4X
'send an email  
bPHP.SendEmailWait("from@gmail.com", "to@gmail.com", "cc@gmail.com", "Test Email", "Have you received this…")
```


  
  
#SharingTheGoodness