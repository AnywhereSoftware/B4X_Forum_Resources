###  B4XPassword b4xlib (B4A, B4i, B4J) by ThRuST
### 07/02/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/141511/)

**B4XPassword Library v1.3**  
Hi, I wanted to share this library that I made.  
EDIT: I have updated it to v1.2 which corrects the ASCII table values. rnd uses one value higher for the second value.  
v1.3 now generates a password between interval min and max. so 1 means 1 char and 10 means 10. ThRuST Logic :)  
  
Example: If Randy = 1 Then RandChar1 = Rnd(49, 58) since ASCII 57 = 9  
Enough science!! Download and play :)  
  
Usage: (pass min and max lenght)  

```B4X
' Use it like this  
    Dim MyPassword As String  
    MyPassword = B4XPassword.Randomize_Password(3, 10)
```

  
  
Hopefully someone finds it useful.  
  
Here's is B4XPasswords v1.3 code module  

```B4X
' B4XPassword Generator Library by ThRuST  
' v1.2     2022-06-30    Corrected the ASCII table chars.  
' v1.3     2022-06-31     The generator now uses a min and max value for varied lenght.  
' Random lenght should work between the intervals now.  
  
' Reference: https://hscboards.fandom.com/wiki/ASCII_Codes  
  
' Shared with the B4X community.  
' Play around with the GUI min and max to find the parameter you prefer.  
' Have fun :-)  
  
Sub Process_Globals  
    Private fx As JFX  
   
    Private Randy As Int  
    Private RandChar1, RandChar2 , RandChar3, RandChar4, RandChar5 As Int  
    Private PassStr(5000) As String  
    Private MyPass As String  
   
End Sub  
  
' Randomize a password with min and max parameter.  
' A randomized password between the min and max range will be generated.  
' Example usage: string = B4XPassword.Randomize_Password(3,10)  
' This will randomize a password with lenght between 3 and 10  
Public Sub Randomize_Password(PassMin As Int, PassMax As Int)  
   
    ' Reset result string  
    MyPass = ""  
    ' Randomize ASCII int  
    Dim Randy As Int  
    Dim PassLgt As Int = Rnd(PassMin, PassMax + 1)  
   
    ' Loop begins  
    For i = 1 To PassLgt  
   
        Randy = Rnd(1, 6)  
   
        If Randy = 1 Then RandChar1 = Rnd(49, 58)  
        If Randy = 2 Then RandChar2 = Rnd(69, 91)  
        If Randy = 3 Then RandChar3 = Rnd(97, 123)  
        If Randy = 4 Then RandChar4 = 45 ' -  
        If Randy = 5 Then RandChar5 = 33 ' !  
   
        If Randy = 1 Then PassStr(i) = Chr(RandChar1)  
        If Randy = 2 Then PassStr(i) = Chr(RandChar2)  
        If Randy = 3 Then PassStr(i) = Chr(RandChar3)  
        If Randy = 4 Then PassStr(i) = Chr(RandChar4)  
        If Randy = 5 Then PassStr(i) = Chr(RandChar5)  
   
        ' Store char array in string  
        MyPass = MyPass & PassStr(i)  
   
    Next  
   
    ' Pass it back  
    Return MyPass  
   
End Sub
```

  
  
Note about this files:  
v1.3 is now available as device specific libraries for B4A and B4J. (B4A version also works with B4i but shows as v1.0) :)?  
EDIT: The b4xlib version is uploaded anew since it works. The last file is the b4xlib so that's all you need for all platforms.  
  
Credits to [USER=9800]@stevel05[/USER] for the solution to how to make a b4xlib.  
  
/ThRuST