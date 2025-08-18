###  Functional Implementation of vb.Net style Enum by William Lancee
### 07/07/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/132325/)

In a recent thread, <https://www.b4x.com/android/forum/threads/the-power-of-b4x.132226/>  
there was mention of the 'Enum' construct in vb.Net.  
  
<https://docs.microsoft.com/en-us/dotnet/visual-basic/language-reference/statements/enum-statement>  
  
I did use it in vb but I hadn't really missed it in B4X. However, I thought I would explore the many ways it can be implemented in B4X.  
You will probbaly have your own favorite method, but here is the one I like most.  
  
I timed it and it takes about 5 minutes to create a new Enum.  
It uses a SmartString and a copy and paste to get the Enumeration of variable names and values.  
No need for Reflection or JavaObject.  
  
This as a standard class 'EggSizeEnum' Other examples are in the attached .zip file.  
  

```B4X
Sub Class_Globals  
    Public names As List  
    Public values As List  
  
    Public Jumbo As Int = 0  
    Public ExtraLarge As Int = 1  
    Public Large As Int = 2  
    Public Medium As Int = 3  
    Public Small As Int = 4  
    
    'copy above lines to inside the SmartString below - the names and values will be extracted  
    Private def As String = $"  
    Public Jumbo As Int = 0  
    Public ExtraLarge As Int = 1  
    Public Large As Int = 2  
    Public Medium As Int = 3  
    Public Small As Int = 4  
    "$  
End Sub  
  
'The following can be used (copied) for each Enum - it initializes and loads 'names()' and 'values()' without having to retype these  
Public Sub Initialize  
    names.Initialize  
    values.Initialize  
    Dim v() As String = Regex.Split(CRLF, def)  
    For Each t As String In v  
        t = t.Trim  
        If t.contains("Public") Then  
            names.Add(t.SubString2(t.IndexOf("Public") + 7, t.IndexOf2(" ", 7)))  
            values.Add(t.SubString(t.IndexOf("=") + 2).trim.Replace(QUOTE, ""))  
        End If  
    Next  
End Sub
```

  
  

```B4X
Sub Process_Globals  
    Public eggSize As EggSizeEnum  
End Sub  
  
Sub AppStart (Args() As String)  
    eggSize.Initialize  
    
    'After the above line, the Enum work pretty much like the vb.Net version  
    'The items aren't Constants - not supercritical with current memory and processor speed  
    'The items aren't read only - which in some cases may be an advantage  
    'To manage many Enums, you can put them all in a custom B4X Library  
    
    Dim size As Int = 2  
    Select size  
        Case eggSize.Jumbo: Log("Jumbo")  
        Case eggSize.ExtraLarge: Log("ExtraLarge")  
        Case eggSize.Large: Log("Large")  
        Case eggSize.Medium: Log("Medium")  
        Case eggSize.Small: Log("Small")  
        Case Else: Log("Error - Invalid size")  
    End Select  
  
    For i = 0 To eggSize.Names.Size - 1  
        Log(eggSize.Names.Get(i) & TAB & eggSize.Values.Get(i))  
    Next  
End Sub
```