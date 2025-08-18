###  Array with Redim Preserve by LucaMs
### 09/17/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/122472/)

**IMPORTANT NOTE: it is** **almost always** **better to use a List which contains many methods to simplify everything.**  
Also, not fully tested.  
  
**Uses:** [IsArray and ArrayType](https://www.b4x.com/android/forum/threads/checks-on-arrays.39374/post-233874)  
  

```B4X
Public Sub RedimPreserve(ObjArray As Object, NewSize As Int) As Object  
    Dim Result As Object  
     
    If IsArray(ObjArray) Then  
  
        Select ArrayType(ObjArray)  
             
            Case "String"  
                Dim StringSource() As String = ObjArray  
                Dim StringNew(NewSize) As String  
                For i = 0 To Min(NewSize, StringSource.Length) - 1  
                    StringNew(i) = StringSource(i)  
                Next  
                Result = StringNew  
            Case "Int"  
                Dim IntSource() As Int = ObjArray  
                Dim IntNew(NewSize) As Int  
                For i = 0 To Min(NewSize, IntSource.Length) - 1  
                    IntNew(i) = IntSource(i)  
                Next  
                Result = IntNew  
            Case "Long"  
                Dim LongSource() As Long = ObjArray  
                Dim LongNew(NewSize) As Long  
                For i = 0 To Min(NewSize, LongSource.Length) - 1  
                    LongNew(i) = LongSource(i)  
                Next  
                Result = LongNew  
            Case "Byte"  
                Dim ByteSource() As Byte = ObjArray  
                Dim ByteNew(NewSize) As Byte  
                For i = 0 To Min(NewSize, ByteSource.Length) - 1  
                    ByteNew(i) = ByteSource(i)  
                Next  
                Result = ByteNew  
            Case "Short"  
                Dim ShortSource() As Short = ObjArray  
                Dim ShortNew(NewSize) As Short  
                For i = 0 To Min(NewSize, ShortSource.Length) - 1  
                    ShortNew(i) = ShortSource(i)  
                Next  
                Result = ShortNew  
            Case "Float"  
                Dim FloatSource() As Float = ObjArray  
                Dim FloatNew(NewSize) As Float  
                For i = 0 To Min(NewSize, FloatSource.Length) - 1  
                    FloatNew(i) = FloatSource(i)  
                Next  
                Result = FloatNew  
            Case "Double"  
                Dim DoubleSource() As Double = ObjArray  
                Dim DoubleNew(NewSize) As Double  
                For i = 0 To Min(NewSize, DoubleSource.Length) - 1  
                    DoubleNew(i) = DoubleSource(i)  
                Next  
                Result = DoubleNew  
            Case "Byte"  
                Dim ByteSource() As Byte = ObjArray  
                Dim ByteNew(NewSize) As Byte  
                For i = 0 To Min(NewSize, ByteSource.Length) - 1  
                    ByteNew(i) = ByteSource(i)  
                Next  
                Result = ByteNew  
            Case "String"  
                Dim StringSource() As String = ObjArray  
                Dim StringNew(NewSize) As String  
                For i = 0 To Min(NewSize, StringSource.Length) - 1  
                    StringNew(i) = StringSource(i)  
                Next  
                Result = StringNew  
            Case "Char"  
                Dim CharSource() As Char = ObjArray  
                Dim CharNew(NewSize) As Char  
                For i = 0 To Min(NewSize, CharSource.Length) - 1  
                    CharNew(i) = CharSource(i)  
                Next  
                Result = CharNew  
            Case "Object"  
                Dim ObjectSource() As Object = ObjArray  
                Dim ObjectNew(NewSize) As Object  
                For i = 0 To Min(NewSize, ObjectSource.Length) - 1  
                    ObjectNew(i) = ObjectSource(i)  
                Next  
                Result = ObjectNew  
  
        End Select  
  
    End If  
     
    Return Result  
End Sub
```

  
  
**Usage:**  

```B4X
Sub Test  
    Dim arr(10) As Int  
  
    For i = 0 To 9  
        arr(i) = i + 1  
    Next  
  
    arr = RedimPreserve(arr, 15)  
     
    For i = 0 To arr.Length - 1  
        Log("Item #" & i & TAB & arr(i))  
    Next  
End Sub
```

  
  
**Log:**  
Item #0 1  
Item #1 2  
Item #2 3  
Item #3 4  
Item #4 5  
Item #5 6  
Item #6 7  
Item #7 8  
Item #8 9  
Item #9 10  
Item #10 0  
Item #11 0  
Item #12 0  
Item #13 0  
Item #14 0