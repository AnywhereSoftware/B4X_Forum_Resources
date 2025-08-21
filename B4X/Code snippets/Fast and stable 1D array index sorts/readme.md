###  Fast and stable 1D array index sorts by RB Smissaert
### 05/01/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/117134/)

These are for 1D arrays, type specific and stable sorts. There are 4 sets for Int, Double, Long and String arrays.  
They are converted from C code I found here:  
[https://www.javatpoint.com/tim-sort](https://www.google.com/url?q=https%3A%2F%2Fwww.javatpoint.com%2Ftim-sort&sa=D&sntz=1&usg=AFQjCNGwirzUvut81pCtCCNFHACTkvzT1w)  
I had some trouble getting this to work, but thanks to Jordi CP, this has all been sorted.  
Using this is simple, just pass the array to the appropriate starter function: Sub TimSort(DataType)\_IDX and an  
integer index array will be returned. Note that the passed array will remain unaltered.  
  

```B4X
Sub TimSortInt_IDX(arrInt() As Int) As Int()  
  
Dim i As Int  
Dim n As Int  
Dim lSize As Int  
Dim lBegin As Int  
Dim lEnd As Int  
Dim lMid As Int  
Dim iConstRun As Int = 32  
Dim arrIndex(arrInt.Length) As Int  
  
n = arrInt.Length  
  
For i = 0 To arrInt.Length - 1  
arrIndex(i) = i  
Next  
  
For i = 0 To n - 1 Step iConstRun  
TimInsertionInt_IDX(arrInt, arrIndex, i, Min(i + iConstRun - 1, n - 1))  
Next  
  
lSize = iConstRun  
  
Do While lSize <= n-1  
For lBegin = 0 To n - 1 Step 2 * lSize  
lEnd = Min(lBegin + 2 * lSize - 1, n - 1)  
lMid = lBegin + lSize - 1  
If lMid < lEnd Then  
TimMergeInt_IDX(arrInt, arrIndex, lBegin, lMid, lEnd)  
End If  
Next  
lSize = lSize * 2  
Loop  
  
Return arrIndex  
  
End Sub  
Sub TimSortDouble_IDX(arrDouble() As Double) As Int()  
  
Dim i As Int  
Dim n As Int  
Dim lSize As Int  
Dim lBegin As Int  
Dim lEnd As Int  
Dim lMid As Int  
Dim iConstRun As Int = 32  
Dim arrIndex(arrDouble.Length) As Int  
  
n = arrDouble.Length  
  
For i = 0 To arrDouble.Length - 1  
arrIndex(i) = i  
Next  
  
For i = 0 To n - 1 Step iConstRun  
TimInsertionDouble_IDX(arrDouble, arrIndex, i, Min(i + iConstRun - 1, n - 1))  
Next  
  
lSize = iConstRun  
  
Do While lSize <= n-1  
For lBegin = 0 To n - 1 Step 2 * lSize  
lEnd = Min(lBegin + 2 * lSize - 1, n - 1)  
lMid = lBegin + lSize - 1  
If lMid < lEnd Then  
TimMergeDouble_IDX(arrDouble, arrIndex, lBegin, lMid, lEnd)  
End If  
Next  
lSize = lSize * 2  
Loop  
  
Return arrIndex  
  
End Sub  
Sub TimSortLong_IDX(arrLong() As Long) As Int()  
  
Dim i As Int  
Dim n As Int  
Dim lSize As Int  
Dim lBegin As Int  
Dim lEnd As Int  
Dim lMid As Int  
Dim iConstRun As Int = 32  
Dim arrIndex(arrLong.Length) As Int  
  
n = arrLong.Length  
  
For i = 0 To n - 1  
arrIndex(i) = i  
Next  
  
For i = 0 To n - 1 Step iConstRun  
TimInsertionLong_IDX(arrLong, arrIndex, i, Min(i + iConstRun - 1, n - 1))  
Next  
  
lSize = iConstRun  
  
Do While lSize <= n-1  
For lBegin = 0 To n - 1 Step 2 * lSize  
lEnd = Min(lBegin + 2 * lSize - 1, n - 1)  
lMid = lBegin + lSize - 1  
If lMid < lEnd Then  
TimMergeLong_IDX(arrLong, arrIndex, lBegin, lMid, lEnd)  
End If  
Next  
lSize = lSize * 2  
Loop  
  
Return arrIndex  
  
End Sub  
Sub TimSortString_IDX(arrString() As String, bCaseInsensitive As Boolean) As Int()  
  
Dim i As Int  
Dim n As Int  
Dim lSize As Int  
Dim lBegin As Int  
Dim lEnd As Int  
Dim lMid As Int  
Dim iConstRun As Int = 32  
Dim arrIndex(arrString.Length) As Int  
  
n = arrString.Length  
  
For i = 0 To n - 1  
arrIndex(i) = i  
Next  
  
For i = 0 To n - 1 Step iConstRun  
TimInsertionString_IDX(arrString, arrIndex, i, Min(i + iConstRun - 1, n - 1), bCaseInsensitive)  
Next  
  
lSize = iConstRun  
  
Do While lSize <= n-1  
For lBegin = 0 To n - 1 Step 2 * lSize  
lEnd = Min(lBegin + 2 * lSize - 1, n - 1)  
lMid = lBegin + lSize - 1  
If lMid < lEnd Then  
TimMergeString_IDX(arrString, arrIndex, lBegin, lMid, lEnd, bCaseInsensitive)  
End If  
Next  
lSize = lSize * 2  
Loop  
  
Return arrIndex  
  
End Sub  
Sub TimInsertionInt_IDX(arrInt() As Int, arrIndex() As Int, lBegin As Int, lEnd As Int)  
  
Dim i As Int  
Dim j As Int  
Dim lTemp As Int  
  
For i = lBegin + 1 To lEnd  
lTemp = arrInt(arrIndex(i))  
j = i - 1  
Do While CheckWhileInt(j, lBegin, arrInt, arrIndex, lTemp)  
arrIndex(j + 1) = arrIndex(j)  
j = j - 1  
Loop  
arrIndex(j + 1) = i  
Next  
  
End Sub  
Sub TimInsertionDouble_IDX(arrDouble() As Double, arrIndex() As Int, lBegin As Int, lEnd As Int)  
  
Dim i As Int  
Dim j As Int  
Dim dTemp As Double  
  
For i = lBegin + 1 To lEnd  
dTemp = arrDouble(arrIndex(i))  
j = i - 1  
Do While CheckWhileDouble(j, lBegin, arrDouble, arrIndex, dTemp)  
arrIndex(j + 1) = arrIndex(j)  
j = j - 1  
Loop  
arrIndex(j + 1) = i  
Next  
  
End Sub  
Sub TimInsertionLong_IDX(arrLong() As Long, arrIndex() As Int, lBegin As Int, lEnd As Int)  
  
Dim i As Int  
Dim j As Int  
Dim lTemp As Long  
  
For i = lBegin + 1 To lEnd  
lTemp = arrLong(arrIndex(i))  
j = i - 1  
Do While CheckWhileLong(j, lBegin, arrLong, arrIndex, lTemp)  
arrIndex(j + 1) = arrIndex(j)  
j = j - 1  
Loop  
arrIndex(j + 1) = i  
Next  
  
End Sub  
Sub TimInsertionString_IDX(arrString() As String, arrIndex() As Int, lBegin As Int, lEnd As Int, bCaseInsensitive As Boolean)  
  
Dim i As Int  
Dim j As Int  
Dim strTemp As String  
  
If bCaseInsensitive Then  
strTemp = arrString(arrIndex(i)).ToLowerCase  
j = i - 1  
Do While CheckWhileString(j, lBegin, arrString, arrIndex, strTemp, True)  
arrIndex(j + 1) = arrIndex(j)  
j = j - 1  
Loop  
arrIndex(j + 1) = i  
Else  
For i = lBegin + 1 To lEnd  
strTemp = arrString(arrIndex(i))  
j = i - 1  
Do While CheckWhileString(j, lBegin, arrString, arrIndex, strTemp, False)  
arrIndex(j + 1) = arrIndex(j)  
j = j - 1  
Loop  
arrIndex(j + 1) = i  
Next  
End If  
  
End Sub  
Sub CheckWhileInt(j As Int, lBegin As Int, arrInt() As Int, arrIndex() As Int, lTemp As Int) As Boolean  
  
If j < 0 Then  
Return False  
End If  
  
If j >= lBegin Then  
If arrInt(arrIndex(j)) > lTemp Then  
Return True  
End If  
End If  
  
Return False  
End Sub  
Sub CheckWhileDouble(j As Int, lBegin As Int, arrDouble() As Double, arrIndex() As Int, dTemp As Double) As Boolean  
  
If j < 0 Then  
Return False  
End If  
  
If j >= lBegin Then  
If arrDouble(arrIndex(j)) > dTemp Then  
Return True  
End If  
End If  
  
Return False  
End Sub  
Sub CheckWhileLong(j As Int, lBegin As Int, arrLong() As Long, arrIndex() As Int, lTemp As Long) As Boolean  
  
If j < 0 Then  
Return False  
End If  
  
If j >= lBegin Then  
If arrLong(arrIndex(j)) > lTemp Then  
Return True  
End If  
End If  
  
Return False  
End Sub  
Sub CheckWhileString(j As Int, lBegin As Int, arrString() As String, arrIndex() As Int, strTemp As String, bcaseInsensitive As Boolean) As Boolean  
  
If j < 0 Then  
Return False  
End If  
  
If bcaseInsensitive Then  
If j >= lBegin Then  
If arrString(arrIndex(j)).ToLowerCase.CompareTo(strTemp) > 0 Then  
Return True  
End If  
End If  
Else  
If j >= lBegin Then  
If arrString(arrIndex(j)).CompareTo(strTemp) > 0 Then  
Return True  
End If  
End If  
End If  
  
Return False  
End Sub  
Sub TimMergeInt_IDX(arrInt() As Int, arrIndex() As Int, lLeft As Int, lMid As Int, lRight As Int)  
  
Dim i As Int  
Dim j As Int  
Dim k As Int  
Dim Len1 As Int  
Dim Len2 As Int  
Len1 = lMid - lLeft + 1  
Len2 = lRight - lMid  
Dim arrBegin(Len1) As Int  
 Dim arrEnd(Len2) As Int  
 For i = 0 To Len1 - 1  
arrBegin(i) = arrIndex(lLeft + i)  
Next  
  
For i = 0 To Len2 - 1  
arrEnd(i) = arrIndex(lMid + 1 + i)  
Next  
  
i = 0  
j = 0  
k = lLeft  
  
Do While i < Len1 And j < Len2  
If arrInt(arrBegin(i)) <= arrInt(arrEnd(j)) Then  
arrIndex(k) = arrBegin(i)  
i = i + 1  
Else  
arrIndex(k) = arrEnd(j)  
j = j + 1  
End If  
k = k + 1  
 Loop  
   
Do While i < Len1  
arrIndex(k) = arrBegin(i)  
k = k + 1  
i = i + 1  
Loop  
  
Do While j < Len2  
arrIndex(k) = arrEnd(j)  
k = k + 1  
j = j + 1  
Loop  
  
End Sub  
Sub TimMergeDouble_IDX(arrDouble() As Double, arrIndex() As Int, lLeft As Int, lMid As Int, lRight As Int)  
  
Dim i As Int  
Dim j As Int  
Dim k As Int  
Dim Len1 As Int  
Dim Len2 As Int  
  
Len1 = lMid - lLeft + 1  
Len2 = lRight - lMid  
  
Dim arrBegin(Len1) As Int  
 Dim arrEnd(Len2) As Int  
 For i = 0 To Len1 - 1  
arrBegin(i) = arrIndex(lLeft + i)  
Next  
  
For i = 0 To Len2 - 1  
arrEnd(i) = arrIndex(lMid + 1 + i)  
Next  
  
i = 0  
j = 0  
k = lLeft  
  
Do While i < Len1 And j < Len2  
If arrDouble(arrBegin(i)) <= arrDouble(arrEnd(j)) Then  
arrIndex(k) = arrBegin(i)  
i = i + 1  
Else  
arrIndex(k) = arrEnd(j)  
j = j + 1  
End If  
k = k + 1  
 Loop  
   
Do While i < Len1  
arrIndex(k) = arrBegin(i)  
k = k + 1  
i = i + 1  
Loop  
  
Do While j < Len2  
arrIndex(k) = arrEnd(j)  
k = k + 1  
j = j + 1  
Loop  
  
End Sub  
Sub TimMergeLong_IDX(arrLong() As Long, arrIndex() As Int, lLeft As Int, lMid As Int, lRight As Int)  
  
Dim i As Int  
Dim j As Int  
Dim k As Int  
Dim Len1 As Int  
Dim Len2 As Int  
  
Len1 = lMid - lLeft + 1  
Len2 = lRight - lMid  
  
Dim arrBegin(Len1) As Int  
 Dim arrEnd(Len2) As Int  
 For i = 0 To Len1 - 1  
arrBegin(i) = arrIndex(lLeft + i)  
Next  
  
For i = 0 To Len2 - 1  
arrEnd(i) = arrIndex(lMid + 1 + i)  
Next  
  
i = 0  
j = 0  
k = lLeft  
  
Do While i < Len1 And j < Len2  
If arrLong(arrBegin(i)) <= arrLong(arrEnd(j)) Then  
arrIndex(k) = arrBegin(i)  
i = i + 1  
Else  
arrIndex(k) = arrEnd(j)  
j = j + 1  
End If  
k = k + 1  
Loop  
  
Do While i < Len1  
arrIndex(k) = arrBegin(i)  
k = k + 1  
i = i + 1  
Loop  
  
Do While j < Len2  
arrIndex(k) = arrEnd(j)  
k = k + 1  
j = j + 1  
Loop  
  
End Sub  
Sub TimMergeString_IDX(arrString() As String, arrIndex() As Int, lLeft As Int, lMid As Int, lRight As Int, bCaseInsensitive As Boolean)  
  
Dim i As Int  
Dim j As Int  
Dim k As Int  
Dim Len1 As Int  
Dim Len2 As Int  
Len1 = lMid - lLeft + 1  
Len2 = lRight - lMid  
Dim arrBegin(Len1) As Int  
 Dim arrEnd(Len2) As Int  
 For i = 0 To Len1 - 1  
arrBegin(i) = arrIndex(lLeft + i)  
Next  
  
For i = 0 To Len2 - 1  
arrEnd(i) = arrIndex(lMid + 1 + i)  
Next  
  
i = 0  
j = 0  
k = lLeft  
  
If bCaseInsensitive Then  
Do While i < Len1 And j < Len2  
If arrString(arrBegin(i)).ToLowerCase.CompareTo(arrString(arrEnd(j)).ToLowerCase) <= 0 Then  
arrIndex(k) = arrBegin(i)  
i = i + 1  
Else  
arrIndex(k) = arrEnd(j)  
j = j + 1  
End If  
k = k + 1  
Loop  
Else  
Do While i < Len1 And j < Len2  
If arrString(arrBegin(i)).CompareTo(arrString(arrEnd(j))) <= 0 Then  
arrIndex(k) = arrBegin(i)  
i = i + 1  
Else  
arrIndex(k) = arrEnd(j)  
j = j + 1  
End If  
k = k + 1  
Loop  
 End If  
   
Do While i < Len1  
arrIndex(k) = arrBegin(i)  
k = k + 1  
i = i + 1  
Loop  
  
Do While j < Len2  
arrIndex(k) = arrEnd(j)  
k = k + 1  
j = j + 1  
Loop  
  
End Sub
```

  
  
RBS