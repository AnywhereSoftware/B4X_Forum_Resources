### ISBN Number generator by jkhazraji
### 01/20/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/137792/)

*[FONT=trebuchet ms]Hi everybody,[/FONT]*  
[FONT=trebuchet ms]***ISBN***stands for the ***International Standard Book Number***that is carried by almost each every book.   
The following B4J short program is with a class that generate an ISBN number and an inline Java code that check if the number is ISBN.   
The code can be used in all B4X platforms..  
I hope you like it ..[/FONT]  

```B4X
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
#End Region  
  
Sub Process_Globals  
      
End Sub  
  
Sub AppStart (Args() As String)  
    Log("Generating an ISBN number:")  
    Dim isbnx As isbn  
    isbnx.Initialize  
    Log(isbnx.makeISBNNumber())  
    Dim jo As JavaObject =Me  
    Log(jo.RunMethod("checkISBNNumber",Array(7771233457)))  
    StartMessageLoop  
End Sub  
#if JAVA  
  
  public static boolean checkISBNNumber(long number)   
   {   
   int sum = 0;   
   int i, t, intNumber, dNumber;   
   String strNumber;   
          
   strNumber = ""+number;   
          
   if (strNumber.length() != 10) {   
                   return false;   
           }   
          
           for (i = 0; i < strNumber.length(); i++) {   
                   intNumber = Integer.parseInt(strNumber.substring(i, i+1));   
                   dNumber = i + 1;   
                   t = dNumber * intNumber;   
                   sum = sum + t;   
           }   
   
           // check whether the sum is divisible by 11 or not   
        
           if ((sum % 11) == 0) {   
                   return true;   
           }   
          
   return false;   
          
   }   
#End If
```

  
  

```B4X
Sub Class_Globals  
      
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize  
    '  
End Sub  
  
Public Sub makeISBNNumber() As String  
   
    Dim isbn, a, b, c, d, e, f, g, h, i, j As Int  
    Private x, n As Int  
    For x = 0 To 99  
      
    a = Rnd(1,9)  
    b = Rnd(1,9)  
    c = Rnd(1,9)  
    d = Rnd(1,9)  
    e = Rnd(1,9)  
    f = Rnd(1,9)  
    g = Rnd(1,9)  
    h = Rnd(1,9)  
    i = Rnd(1,9)  
    j = Rnd(1,9)  
    isbn = (a + (b * 2) + (c * 3) + (d * 4) + (e * 5) + (f * 6) + (g * 7) + (h * 8) + (i * 9) + (j * 10))  
      
    If isbn Mod 11 = 0 Then  
              
        Return ($"${a}${b}${c}${d}${e}${f}${g}${h}${i}${j}"$)  
      n = n + 1  
    End If  
    Next  
  
      
End Sub
```