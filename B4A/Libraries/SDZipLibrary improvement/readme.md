### SDZipLibrary improvement by Alain75
### 10/23/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/163717/)

Thanks to [USER=101440]@Star-Dust[/USER], I have been able to see contain of apk file and moreover to extract files ! I improved a little his code in order to :  

1. Get the possible error of zip/unzip instructions into BA log,
2. Add the ability to extract a selection of files without creating subfolders,
3. Suppress the WRITE\_EXTERNAL\_STORAGE permission which is not usefull for non image files.

Here is the new version of the class.  
  

```B4X
…  
} catch(Exception e) {  
    ba.Log(e.toString());  
    ba.raiseEvent(null, "zip_error");  
}  
…
```

  
  

```B4X
public void unZipDecompress(String zipFile, String outputFolder, String fileSel) {  
            …  
            String fileEntry    = ze.getName();  
            String fileName     = fileEntry;  
            // Don't create sub folder(s) when file(s) selection  
            if (fileSel!="" && fileName.contains("/")) fileName = fileName.substring(fileName.lastIndexOf("/")+1);  
            File newFile         = new File(outputFolder + File.separator + fileName);  
            new File(newFile.getParent()).mkdirs();  
            if (!fileEntry.endsWith("/") && fileEntry.contains(fileSel)) {  
                …
```