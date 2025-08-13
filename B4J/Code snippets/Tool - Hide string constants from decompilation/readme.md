### Tool - Hide string constants from decompilation by tchart
### 01/31/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/145807/)

Use this simple tool to "hide" string constants from decompilation.  
  
Obviously nothing is immune to decompilation this is just a simple way to hide sensitive strings in your code.  
  
Based on this code; <https://github.com/shamanland/simple-string-obfuscator>  
  
The dialog in the app generates a randomish set of bytes as a sub that you can call.  
  
**NOTE: Remove or change the JavaCompilerPath setting in the project attributes.**  
  
So given below, instead of;  
  

```B4X
Sub SomeSub  
  Dim MySecret as String = "Hello World"  
End Sub
```

  
  
You can do this;  
  

```B4X
Sub SomeSub  
  Dim MySecret as string = X 'This sub will return "Hello World"  
End Sub  
  
Private Sub X() as String  
Dim b(12) as Byte  
b(0) = Bit.ShiftRight(75505855,20)  
b(1) = Bit.ShiftRight(25389,3)  
b(2) = Bit.ShiftRight(223082,11)  
b(3) = Bit.ShiftRight(3550668,15)  
b(4) = Bit.ShiftRight(458321,12)  
b(5) = Bit.ShiftRight(268466875,23)  
b(6) = Bit.ShiftRight(10938,3)  
b(7) = Bit.ShiftRight(58206654,19)  
b(8) = Bit.ShiftRight(58848,9)  
b(9) = Bit.ShiftRight(14167173,17)  
b(10) = Bit.ShiftRight(6579261,16)  
b(11) = Bit.ShiftRight(4353155,17)  
return BytesToString(b, 0, 12, "UTF8")  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/138708)