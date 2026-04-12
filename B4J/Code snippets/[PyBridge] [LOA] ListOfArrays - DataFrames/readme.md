### [PyBridge] [LOA] ListOfArrays - DataFrames by Erel
### 04/08/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/170772/)

DataFrame is a core type in many Python libraries. The following subs make it simple to convert LOAs to DataFrames and vice versa.  
  

```B4X
'Adds a converter that converts dataframes to a list of arrays (not LOA yet) when a dataframe is fetched.  
Private Sub AddDataFrameConverter  
    Dim Pandas As PyWrapper = Py.ImportModule("pandas")  
    Dim converters As PyWrapper = Py.Bridge.GetField("comm").GetField("serializator").GetField("converters")  
    converters.Set(Pandas.GetField("DataFrame"), Py.Lambda("df: [tuple(df.columns)] + list(df.itertuples(index=False, name=None))"))  
End Sub  
  
'Converts a LOA to DataFrame.  
Public Sub LOAToDataFrame (LOA As ListOfArrays) As PyWrapper  
    Dim Code As String = $"  
def LOAToDataFrame (LOA):  
    df = pandas.DataFrame(LOA[1:], columns=LOA[0])  
    return df  
"$  
    Return Py.RunCode("LOAToDataFrame", Array(LOA.mInternalArray), Code)  
End Sub
```

  
  
Call AddDataFrameConverter once when the program starts.  
  
To fetch a DataFrame:  

```B4X
Wait For (df.Fetch) Complete (df As PyWrapper)  
Dim table2 As ListOfArrays = LOAUtils.WrapWithHeader(df.Value)
```

  
  
To convert a LOA to DataFrame:  

```B4X
Dim df As PyWrapper = LOAToDataFrame(table)  
df.Print
```

  
  
Example:  

```B4X
AddDataFrameConverter  
  
Dim table As ListOfArrays = LOAUtils.CreateEmpty((Array("Id", "Animal type", "Name", "Age", "Weight")))  
table.AddRow(Array(1, "Rabbit", "Coco", 3, 2.4))  
table.AddRow(Array(2, "Cat", "Luna", 2, 4.1))  
table.AddRow(Array(3, "Dog", "Rocky", 8, 25.6))  
table.AddRow(Array(4, "Parrot", "Kiwi", 7, 0.9))  
table.AddRow(Array(5, "Hamster", "Nibbles", 1, 0.2))  
table.AddRow(Array(6, "Goat", "Daisy", 4, 35.0))  
table.AddRow(Array(7, "Cat", "Shadow", 9, 5.2))  
  
Dim df As PyWrapper = LOAToDataFrame(table)  
df.Print  
Wait For (df.Fetch) Complete (df As PyWrapper)  
Dim table2 As ListOfArrays = LOAUtils.WrapWithHeader(df.Value)  
Log(table2.ToString(0))
```