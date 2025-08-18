### [BANanoCodeHandler] A B4X Source Code Handling Class by Mashiane
### 04/20/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/139994/)

Hi there  
  
In case anyone needs something similar. I am using this to maintain my BANano Custom Views and whilst its BANano related code, it is just b4x code after-all and can be adopted for any scenario.  
  
Use For  
  
1. Format b4x source code (beautify)  
2. Insert #Event declarations  
3. Insert #DesignerProperty  
4. Insert Code on any Subroutine e.g. Class\_Globals / Initialize  
5. Code Stock taking  
6. Insert Code between [If Props <> Null Then] and [End If] in DesignerCreateView  
7. Insert code after [End If] in DesignerCreateView  
8. DesignerProperty returned as a Map  
etc  
etc  
  
**Example Usage - SourceCode is the contents of your source code e.g. bas file.**  
  

```B4X
Dim sch As BANanoCodeHandler  
ch.Initialize  
BANano.Await(ch.ScanWait(sourceCode))  
BANano.Await(ch.BeautifyWait)  
return ch.Transactions  
  
log(sch.Properties)  
log(sch.Signatures)  
log(sch.Events)  
log(sch.ClassGlobalsCode)  
log(sch.InitializeCode)  
log(sch.CreateViewCode)  
log(sch.DesignerKeys)  
log(sch.Comments)  
log(sch.Lines)
```