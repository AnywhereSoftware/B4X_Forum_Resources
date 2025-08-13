### Solving a system of linear equations using Gaussian Elimination by grafsoft
### 10/31/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/143862/)

Some will remember Tasks like this one from school:  
  
2x + y = 7  
x + 4y = 6  
  
The following code will solve this, with 1..n unknown quantities, like x, y, z …  
  

```B4X
Sub gauss  
    ' flowchart in  
    ' https://www.bragitoff.com/2015/10/gaussian-elimination-lab-write-up-with-algorithm-and-flowchart/  
      
    ' example with  
    ' 2x + 3y + z = 5  
    ' x + 4y + 2z = 3  
    ' 4x + y + 3z = 17  
          
    Private n,i,j,k As Int  
    ' number of unknown values, equations and results  
    n = 3  
      
    Private a (n,n+1) As Double  
    Private x (n) As Double  
    Private temp,t As Double  
      
    ' data  
    a (0,0) = 2  
    a (0,1) = 3  
    a (0,2) = 1  
    a (0,3) = 5  
    a (1,0) = 1  
    a (1,1) = 4  
    a (1,2) = 2  
    a (1,3) = 3  
    a (2,0) = 4  
    a (2,1) = 1  
    a (2,2) = 3  
    a (2,3) = 17  
      
    ' pivoting  
    For i=0 To n-1  
        For k=i+1 To n-1  
            If a (i,i) < a (k,i) Then  
                For j=0 To n  
                    temp = a (i,j)  
                    a (i,j) = a (k,j)  
                    a (k,j) = temp  
                Next  
            End If  
        Next  
    Next  
    ' Gaussian Eliminatio  
    For i=0 To n-2  
        For k=i+1 To n-1  
            t=a (k,i)/a(i,i)  
            For j=0 To n  
                a (k,j)=a (k,j)-t*a (i,j)  
            Next  
        Next  
    Next  
    ' Back-substitution:  
    For i=n-1 To 0 Step -1  
        x (i) = a (i,n)  
        For j=0 To n-1  
            If j <> i Then  
                x (i)  = x (i) - a (i,j) * x (j)  
            End If  
        Next  
        x (i) = x (i) / a (i,i)  
    Next  
    For i=0 To n-1  
        Log (x (i))  
        ' shows the values for x, y and z = 3, -1, 2  
    Next  
End Sub
```