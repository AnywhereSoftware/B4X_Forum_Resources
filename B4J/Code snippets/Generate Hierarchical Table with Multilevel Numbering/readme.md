### Generate Hierarchical Table with Multilevel Numbering by epiCode
### 03/15/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/146812/)

I had a list of categories from Amazon which were stored in a csv like this (semicolon separated 25234 entries):  
  

```B4X
Main Category;Subcat 1;Subcat 2;Subcat 3;Subcat 4;Subcat 5;Subcat 6;Subcat 7;Subcat 8  
Appliances  
Appliances;Dishwashers  
Appliances;Dishwashers;Built-In Dishwashers  
Appliances;Dishwashers;Countertop Dishwashers  
Appliances;Dishwashers;Portable Dishwashers  
Appliances;Laundry Appliances  
Appliances;Laundry Appliances;Washers & Dryers
```

  
  
I wanted output like this to create a hierarchical tree:  
  

```B4X
ParentID; ID; Category  
0; 1; Appliances  
1; 1.1; Dishwashers  
1.1; 1.1.1; Built-In Dishwashers  
1.1; 1.1.2; Countertop Dishwashers  
1.1; 1.1.3; Portable Dishwashers  
1; 1.2; Laundry Appliances  
1.2; 1.2.1; Washers & Dryers  
1.2.1; 1.2.1.1; Clothes Dryers
```

  
  
You can use the code snippet to convert any similar data to Multilevel Numbering (1.1.1.1 kind of notation).  
  
Please note:  
1. It skips first row as header  
2. Assigns "0" as parent ID for all top Level items.  
3. It supports 10 levels of branches. (It can easily be increased or decreased in code)  
  
Here is the code snippet which does the job:  
  
[SPOILER="C"]  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
#End Region  
  
Sub Process_Globals  
  
    Dim counters(9) As Int   ' Modify 9 here to change branch levels  
    Dim lastCat(9) As String ' Modify 9 here to change branch levels  
    Dim outdata As List  
    Dim parts() As String  
End Sub  
  
Sub AppStart (Args() As String)  
    outdata.Initialize  
    ProcessCategories  
End Sub  
  
Sub ProcessCategories  
    Dim inputData As List= File.ReadList(File.DirAssets, "AmazonCategories.txt")     
    Dim t As Long = DateTime.Now  
    For z = 1 To inputData.Size-1  
        SplitAndProcessString( inputData.Get(z))  
    Next  
  
    ' Prepare to save  
    Dim cs As StringBuilder  
    cs.Initialize  
    Log("Total records processed: " & outdata.Size)  
    For Each row() As String In outdata  
        cs.Append(row(0))  
        For i = 1 To row.Length - 1  
            cs.Append(";").Append(row(i))  
        Next  
        cs.Append(CRLF)  
    Next  
  
    File.WriteString(File.DirTemp, "output.txt", cs.ToString)  
    Log("Total Time taken: " & ((DateTime.Now-t)/1000))  
End Sub  
  
Sub FillArray(arrLength As Int)  
        Dim tempArr(9) As String  ' Modify this number 9 to increase branches  
        For i = 0 To arrLength - 1  
            tempArr(i) = parts(i)  
        Next  
        parts = tempArr  
End Sub  
  
  
private Sub SplitAndProcessString(inputString As String)  
    ' Split the input string by semicolon  
    parts = Regex.Split(";+", inputString)  
    ' Fillempty array  
    FillArray(parts.Length)  
    ' Loop through the parts and process each one  
    For part = 0 To parts.Length - 1  
        If lastCat(part) <> parts(part) Then  
            If part = 0 Then  
                counters(part) = counters(part) + 1  
                outdata.add(Array As String("0",counters(part),parts(part)))  
                resetRestCounters(part)  
                Exit  
            Else  
                counters(part) = counters(part) + 1  
                resetRestCounters(part)  
                Dim p As String = getcounter(part-1)  
                outdata.add(Array As String(p,p & "." & counters(part),parts(part)))  
                Exit  
            End If  
        End If  
    Next  
    lastCat = parts  
End Sub  
  
Sub resetRestCounters(level As Int)  
    For y = level + 1 To counters.Length-1  
        counters(y) = 0  
    Next  
End Sub  
  
Private Sub getcounter(level As Int) As String  
    If level < 0 Then Return counters(0)  
    Dim sb As String  
    For i = 0 To level  
        sb= sb & (counters(i))  
        If i < level Then sb=sb & "."  
    Next  
    Return sb  
End Sub
```

  
[/SPOILER]