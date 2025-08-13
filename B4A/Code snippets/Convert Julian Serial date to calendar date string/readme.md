### Convert Julian Serial date to calendar date string by WimS
### 12/08/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/144692/)

This function works correct over whole the year!  
  

```B4X
Sub JulianSerialToDate(JulianSerial As Double) As String  
      
     
      
    Try  
          
        Dim Z As Int = JulianSerial+0.5  
        Dim F As Double = JulianSerial+0.5-Z  
  
  
        Dim A As Double  
        Dim alpha As Double  
        If (Z < 2299161) Then A = Z  
        If (Z >= 2299161) Then  
            alpha = Floor((Z-1867216.25)/36524.25)  
            A = Z + 1 + alpha - Floor(alpha/4)  
        End If  
  
          
        Dim B As Double = A + 1524  
        Dim C As Double = Floor((B-122.1)/365.25)  
        Dim D As Double = Floor( 365.25*C )  
        Dim E As Double = Floor((B-D)/30.6001)  
  
  
        Dim day As Int = Floor(B - D - Floor(30.6001*E))  
        Dim month As Int  
        Dim year As Int  
          
        If (E < 13.5) Then month = E - 1  
        If (E > 13.5) Then month = E - 13  
        If (month > 2.5) Then year = C - 4716  
        If month < 2.5 Then year = C - 4715  
          
          
        Dim Str As String = day & "-" & month & "-" & year  
        DateTime.DateFormat = "dd-MM-yyyy"  
        Dim l As Long = DateTime.DateParse(Str)  
        DateTime.DateFormat = "dd-MM-yyyy"  
        Str = DateTime.Date(l)  
        Return Str  
      
    Catch  
        Log(LastException)  
    End Try  
  
End Sub
```