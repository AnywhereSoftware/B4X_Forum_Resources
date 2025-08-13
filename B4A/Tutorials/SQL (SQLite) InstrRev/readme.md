### SQL (SQLite) InstrRev by RB Smissaert
### 01/12/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/165074/)

SQLite has the string function Instr, which finds the first occurrence of a specified string in another string.  
There is no InstrRev function though to find the last occurrence of a string within another string.  
As I needed this I made another custom SQL function (I have several of these) to do this.  
  
This is the code part that goes through the SQL and find these custom SQL functions and replaces them with different SQL.  
All the variables are local variables and I think the code explains itself.  
I added a slight variation to find the last occurrence of a number.  
Maybe somebody may find this useful:  
  

```B4X
            'select xinstrrev(street, ' ')  
            '—————————–  
            strError = "Error in function xinstrrev"  
            iFunctionConvertPos = strSQL.ToLowerCase.IndexOf("xinstrrev(")  
            Do While iFunctionConvertPos > -1 And strSQL.CharAt(iFunctionConvertPos - 1) <> Chr(39)  
                iFunctionConvertEndPos = cMP.GetPosOfClosingBracket(strSQL, iFunctionConvertPos)  
                strStringToReplace = strSQL.SubString2(iFunctionConvertPos, iFunctionConvertEndPos + 1)  
                iCommaPos = strStringToReplace.IndexOf(",")  
                strField = strStringToReplace.SubString2(10, iCommaPos)  
                strFindString = strStringToReplace.SubString2(iCommaPos + 2, strStringToReplace.Length - 1)  
                strReplace = $"length(rtrim(${strField}, replace(${strField}, ${strFindString}, '')))"$  
                strSQL = strSQL.Replace(strStringToReplace, strReplace)  
                iFunctionConvertPos = strSQL.ToLowerCase.IndexOf("xinstrrev(")  
            Loop  
              
            'select xlastnumberpos(street)  
            '—————————–  
            iFunctionConvertPos = strSQL.ToLowerCase.IndexOf("xlastnumberpos(")  
            strError = "Error in function xlastnumberpos"  
            Do While iFunctionConvertPos > -1 And strSQL.CharAt(iFunctionConvertPos - 1) <> Chr(39)  
                iFunctionConvertEndPos = cMP.GetPosOfClosingBracket(strSQL, iFunctionConvertPos) + 1  
                strField = strSQL.SubString2(iFunctionConvertPos + 15, iFunctionConvertEndPos - 1)  
                strStringToReplace = strSQL.SubString2(iFunctionConvertPos, iFunctionConvertEndPos)  
                        
                strSQL = strSQL.Replace(strStringToReplace, _  
                $"max(length(rtrim(${strField}, replace(${strField}, '0', ''))),   
                      length(rtrim(${strField}, replace(${strField}, '1', ''))),    
                      length(rtrim(${strField}, replace(${strField}, '2', ''))),    
                      length(rtrim(${strField}, replace(${strField}, '3', ''))),    
                      length(rtrim(${strField}, replace(${strField}, '4', ''))),   
                      length(rtrim(${strField}, replace(${strField}, '5', ''))),   
                      length(rtrim(${strField}, replace(${strField}, '6', ''))),  
                      length(rtrim(${strField}, replace(${strField}, '7', ''))),   
                      length(rtrim(${strField}, replace(${strField}, '8', ''))),   
                      length(rtrim(${strField}, replace(${strField}, '9', ''))))"$)  
                'Log(strSQL)  
                iFunctionConvertPos = strSQL.ToLowerCase.IndexOf("xlastnumberpos(")  
            Loop
```

  
  
RBS