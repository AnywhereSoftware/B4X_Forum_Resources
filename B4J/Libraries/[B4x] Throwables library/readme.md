### [B4x] Throwables library by stevel05
### 12/21/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/125771/)

This is a simple b4xlib library that just allows throwing an IllegalArgumentException or a NumberFormatException.  
  
Sometimes a Toast or Dialog is not enough of an alert that something is going to break if the data passed is incorrect, especially in libraries.  
  
Compatible with B4a and B4j.  
  
**Usage:**  
  

```B4X
Dim TH as Throwables  
TH.Initialize  
TH.Throw(Throwables_Static.NewIllegalArgumentException("Invalid Argument"))  
  
or  
  
TH.Throw(Throwables_Static.NewNumberFormatException("Invalid Number"))
```

  
  
The exceptions can be caught in the normal way with a try .. catch block.  
  
Version 1  
  
Tags: throw exception