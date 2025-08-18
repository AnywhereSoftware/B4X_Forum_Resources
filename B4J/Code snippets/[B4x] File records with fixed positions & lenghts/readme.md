### [B4x] File records with fixed positions & lenghts by KMatle
### 03/17/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/128739/)

I had some projects where I needed fixed locations & lengths inside a record e.g. a field has a fixed length of 30 "chars". It's a pain to write such a file. Here's a snippet to make it easier:  
  
FileRecord defines the varname, the length and the alignment (left or right). "Michael" is 7 chars long. So 23 spaces are added (30-7=23).  
  
VarMap could be an array, too (just change it) and contains the var name (to be matched with FileRecord) and the data.  
  
Nice side effect: You can sort the output/sequence of the data by just changing the order in FileRecord or adding new fields.  
  

```B4X
'Varname, fixed length, alignement  
    Dim FileRecord() As String = Array As String("var1","4","L","var2","9","L","var3","1","L","var4","30","R","var5","30","L")  
      
    'Input as a map (can be anything else, too)  
    Dim VarMap As Map=CreateMap("var1":"123","var2":"abcdef","var3":"h","var4":"Michael","var5":"Miller")  
      
    Dim RecordLength,VarLength,StartVarPos,EndVarPos As Int  
    Dim Alignment,VarName,VarContent As String  
    Dim Record As String  
    For i=0 To FileRecord.Length-3 Step 3  
        VarName=FileRecord(i)  
        VarLength=FileRecord(i+1)  
        Alignment=FileRecord(i+2)  
        EndVarPos=StartVarPos+VarLength-1  
        RecordLength=RecordLength+VarLength  
        Log("Var: " & FileRecord(i) &", Length: " & VarLength &", Start: " & StartVarPos & ", End: " & EndVarPos &", Alignement: " & Alignment)  
        VarContent=VarMap.Get(VarName)  
        For l= 0 To VarLength-VarContent.length-1  
            If Alignment="L" Then  
               VarContent=VarContent & " " 'add spaces behind (align left)  
            Else  
                VarContent=" " & VarContent 'add spaces before (align right)  
            End If  
        Next  
        Record=Record&VarContent  
        StartVarPos=EndVarPos+1  
    Next  
    Log("Total recordlength: " & RecordLength)  
    Log("Record: " & Record)
```