###  CSBuilder marking based on regex pattern by Erel
### 12/25/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/83002/)

CSBuilder is supported by B4A and B4J. There are some differences in the supported properties.  
A more powerful cross platform alternative: [[B4X] BCTextEngine / BBCodeView - Text engine + BBCode parser + Rich Text View](https://www.b4x.com/android/forum/threads/106207/#content)  
  
This sub searches for matches and uses CSBuilder to mark the matches.  
  
![](https://www.b4x.com/android/forum/attachments/157518)  
  

```B4X
Private Sub MarkPattern(Input As String, Pattern As String, GroupNumber As Int) As CSBuilder  
    Dim cs As CSBuilder  
    cs.Initialize  
    'this section applies to all text  
    cs.Color(xui.Color_Black)  
    #if B4i  
    cs.Font(xui.CreateDefaultBoldFont(14))  
    #else if B4A  
    cs.Bold  
    #end if  
    Dim lastMatchEnd As Int = 0  
    Dim m As Matcher = Regex.Matcher(Pattern, Input)  
    Do While m.Find  
        Dim currentStart As Int = m.GetStart(GroupNumber)  
        cs.Append(Input.SubString2(lastMatchEnd, currentStart))  
        lastMatchEnd = m.GetEnd(GroupNumber)  
        'apply match styling here  
        cs.Underline  
        cs.Color(xui.Color_Blue)  
        cs.Append(m.Group(GroupNumber))  
        cs.Pop.Pop 'number should match number of stylings set.  
    Loop  
    If lastMatchEnd < Input.Length Then cs.Append(Input.SubString(lastMatchEnd))  
    cs.PopAll  
    Return cs  
End Sub
```

  
  
Usage example:  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    
    Dim s As String = $"#Hello, this is a #Nice Day!  
#nice test#test  
#day"$  
    Dim cs As CSBuilder = MarkPattern(s, "\B(#\w+)\b", 1)  
    XUIViewsUtils.SetTextOrCSBuilderToLabel(Label1, cs)  
End Sub
```