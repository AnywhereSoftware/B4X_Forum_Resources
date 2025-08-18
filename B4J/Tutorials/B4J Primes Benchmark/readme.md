### B4J Primes Benchmark by Erel
### 07/28/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/132951/)

I found this [benchmark](https://github.com/cmplopes/count-primes) that tests the same algorithm in multiple programming languages and decided to test it in B4J.  
  
I've implemented the two algorithms.  
  

```B4X
Sub Process_Globals  
  
End Sub  
  
Sub AppStart (Args() As String)  
    #if debug  
    Log("Never test performance in debug mode!!!")  
    ExitApplication  
    #End If  
   
    Dim start As Long = DateTime.Now  
   
    'Algorithm #1  
    Dim counter As Int = GetAllPrimesLessThan1(20000000) '20,000,000  
    'Algorithm #2  
'    Dim counter As Int = GetAllPrimesLessThan2(200000000) '200,000,000  
    Dim EndTime As Long = DateTime.Now  
    Log($"number of primes: ${NumberFormat2(counter, 0, 0, 0, True)}"$)  
    Log($"Time: $1.4{(EndTime - start) / 1000}"$)  
End Sub  
  
Private Sub GetAllPrimesLessThan1 (MaxPrime As Int) As Int  
    Dim counter As Int  
    For i = 2 To MaxPrime - 1  
        If IsPrime(i) Then counter = counter + 1  
    Next  
    Return counter  
End Sub  
  
Private Sub IsPrime(Num As Int) As Boolean  
    If Num <= 1 Then Return False  
    If Num <= 3 Then Return True  
    If ((Num Mod 2) = 0 Or (Num Mod 3) = 0) Then Return False  
    For c = 5 To Sqrt(Num) Step 6  
        If ((Num Mod c) = 0 Or Num Mod (c + 2) = 0) Then Return False  
    Next  
    Return True  
End Sub  
  
Private Sub GetAllPrimesLessThan2 (MaxPrime As Int) As Int  
    Dim Count As Int = 0  
    Dim MaxSquareRoot As Int = Sqrt(MaxPrime)  
    Dim eliminated As B4XBitSet 'B4XCollections (collections implemented in B4A)  
    eliminated.Initialize(MaxPrime + 1)  
    For i = 2 To MaxPrime  
        If eliminated.Get(i) = False Then  
            Count = Count + 1  
            If i <= MaxSquareRoot Then  
                For j = i * i To MaxPrime Step i  
                    eliminated.Set(j, True)  
                Next  
            End If  
        End If  
    Next  
    Return Count  
End Sub
```

  
  
And the results (measured in seconds):  
  
**Algorithm #1**  
  
B4J: 2.78  
Java: 3.07  
Java with the limit calculated before the loop (as in B4J): 2.91  
C#: 2.69  
  
**Algorithm #2 - sieve**  
  
The C# code was fixed to only return the count of primes without collecting the primes, and the maximum was set to 200M.  
B4J - same algorithm as the C# algorithm: 1.80  
Java: 1.90  
C#: 2.50  
  
  
**What does it mean?**  
  
The exact numbers aren't important. Small changes in the code can affect the results in unexpected ways due to the underlying compiler optimizations.  
It does show that B4J, Java and C# have similar core performance.