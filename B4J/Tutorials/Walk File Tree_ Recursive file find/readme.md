### Walk File Tree: Recursive file find by jkhazraji
### 10/10/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/163501/)

This library has one class which finds files that match the specified glob pattern in any selected path, then they are returned in a list.  
It was adopted from Oracle Java [Tutorials](https://docs.oracle.com/javase/tutorial/essential/io/walk.html).  
It uses the powerful Files method "walkFileTree" and "FileVisitor" class to achieve this goal.  
The files or directories that match the pattern and the number of matches are printed.  
If no match is found, the list will be empty, and number of matches is zero.  
Download the \*.jar and \*.xml files and put them in the additional libraries folder. when refreshed, the "Libraries"  
list will show findFiles . Choose it. The class name will be 'walkFileTree'.  
Usage:  

```B4X
     Dim ff As walkFileTree  
    'You must initialize the class  
    ff.Initialize  
    'Create a list to contain the results  
    Dim foundFiles As List  
    foundFiles.Initialize  
    'Do the work  
    foundFiles= ff.search(rootPath,searchPattern)  
    If foundFiles.Size > 0 Then  
           For i = 0 To  foundFiles.Size -1  
            log(foundFiles.Get(i))  
           Next  
     End If
```

  
The included example also lists the system accessible hard drives in a combobox.