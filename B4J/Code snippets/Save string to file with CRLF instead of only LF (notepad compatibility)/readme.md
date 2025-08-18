### Save string to file with CRLF instead of only LF (notepad compatibility) by Coldrestart
### 04/11/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/129607/)

Hello all,  
  
As in this topic already discussed: <https://www.b4x.com/android/forum/threads/crlf-strangeness.58632/#content>  
Linux only supports the LF, so in B4X, when you export a string with File.WriteString, you will export the string with only LF's at the end.  
Now, you could use notepad++, instead of notepad of windows, as it doesn't support only LF's.  
In standard notepad, you won't get a list.  
  
The problem is that sometimes regular users (not aware of notepad++) will open your file with notepad, so it must be compatible.  
  
As a workaround for this, here a simple code snippet to replace the LF's to CRLF's.  
The TXTLIST.text as a textarea is to be saved.  
  

```B4X
Dim txtAsBytes() As Byte = TXTLIST.Text.GetBytes("UTF8")  
      
        Dim bb As B4XBytesBuilder  
        bb.Initialize  
          
        For Each b As Byte  In txtAsBytes  
            'If we see a LF line feed  
            If b = 0x0A Then  
                'add a CR to the LF to get a CRLF  
                bb.Append(Array As Byte(0x0D))  
                bb.Append(Array As Byte(0x0A))  
            Else  
                'all the other bytes, just copy them  
                bb.Append(Array As Byte(b))     
            End If     
        Next
```

  
   
 'Write the bytes to file.  
 File.WriteBytes("",SelectedPad,bb.ToArray)  
  
I was wrong, look at the code of Erel.