### MarkdownView for Android by hoiketoan95
### 03/01/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/128143/)

MarkdownView is a simple library that helps you display Markdown text or files on Android as a html page just like Github.  
  
This library is based on <https://github.com/mukeshsolanki/MarkdownView-Android>  
  
How to use?  
  

```B4X
'B4AMarkDownView1.MarkDownText="# Hello World\nThis is a simple markdown"  
    Wait For (File.CopyAsync(File.DirAssets, "README.md", File.DirInternal, "README.md")) Complete (Success As Boolean)  
    Log("Success: " & Success)  
    B4AMarkDownView1.loadMarkdownFromFile(File.Combine(File.DirInternal,"README.md"))
```