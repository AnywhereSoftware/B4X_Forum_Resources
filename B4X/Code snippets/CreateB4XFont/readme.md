###  CreateB4XFont by LucaMs
### 02/10/2022
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/138325/)

Function to create custom B4XFont for all platforms.  
  
I don't know if it is the best possible nor if it works perfectly with B4I, as I cannot test it, therefore suggestions/improvements will certainly be welcome.  
  
B4XPages test project attached.  
  

```B4X
'NativeFontSize is needed only for B4J or B4I.  
'Of course you have to pass a dummy-not-used value if you are developing in B4A.  
'It uses XUI (also FX in B4J) which must be declared at module level.  
Public Sub CreateB4XFont(FontFileName As String, FontSize As Float, NativeFontSize As Float) As B4XFont  
    #IF B4A  
        Return xui.CreateFont(Typeface.LoadFromAssets(FontFileName), FontSize)  
    #ELSE IF B4I  
        Return xui.CreateFont(Font.CreateNew2(FontFileName, NativeFontSize), FontSize)  
    #ELSE ' B4J  
        Return xui.CreateFont(FX.LoadFont(File.DirAssets, FontFileName, NativeFontSize), FontSize)  
    #END IF  
End Sub
```