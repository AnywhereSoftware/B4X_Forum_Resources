###  CSVParser - CSV parser and generator by Erel
### 06/29/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/110901/)

CSV - comma separated values format.  
  
The various StringUtils libraries include methods for loading and saving CSV files.  
  
However these methods have a few drawbacks:  
  
- They work with files instead of strings. This is especially problematic if the input is not UTF8 encoded.  
- As they are implemented inside a native library it is not possible to modify their behavior. Some [CSV](https://www.b4x.com/glossary/csv/) files are not 100% valid and will not work with these methods.  
  
CSVParser is a class that allows parsing and generating CSV strings:  

```B4X
Dim parser As CSVParser  
parser.Initialize  
Dim table As List = parser.Parse(File.ReadString(File.DirAssets, "1.csv"), ",", False)  
For Each row() As String In table  
   'work with row  
Next  
Dim s As String = parser.GenerateString(table, ",")  
File.WriteString(File.DirApp, "1.csv", s)
```