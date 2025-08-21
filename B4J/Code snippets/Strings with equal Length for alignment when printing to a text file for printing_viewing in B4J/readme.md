### Strings with equal Length for alignment when printing to a text file for printing/viewing in B4J by Elby dev
### 02/27/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/114392/)

Could not find code to add spaces to a string in an array so they all become the same length. This makes the print output line up the columns of strings.  
I publish this to help others or if this is not efficient help me to do better. Thanks. ps has been a while since I posted, Sorry if I did something not right. Thanks  

```B4X
Sub AddSp(s1 As String,n1 As Int) As String    'Enter the sub with a string of various lengths ie  line = addsp(str1,15) & addsp(str2,20) etc. Multiple lines will line up nicely.  
    s1 = s1 & "                              "   'Add a fixed number of spaces  
    s1 = s1.SubString2(0,n1)              'Trim the string back to the required length  as set by n1  
    Return(s1)                                       ' return the result.    
End Sub
```