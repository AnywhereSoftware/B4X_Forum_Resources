### [module] GlobalStore - Global objects storage by Erel
### 07/22/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/73863/)

As explained in the tutorial about memory management in B4R: <https://www.b4x.com/android/forum/threads/65672/#content> it is not trivial to assign the value of a local, non-numeric, variable to a global variable.  
  
The reason behind this limitation is that the memory is statically allocated during compilation. It is therefore only possible to set fixed-size values (such as numbers).  
  
GlobalStore allows storing arrays of bytes or strings.  

```B4X
GlobalStore.Put(0, "A String") 'store value in slot #0  
Log(GlobalStore.Slot0) 'get the value from slot #0
```

  
There are 5 slots by default. Note that the data is stored internally in a single array of bytes and it takes care of maintaining the indices and lengths of the slots arrays.  
  
Notes & Tips:  
  
- The data is saved in a global buffer. Its size is set to 100. You can increase it if you encounter out of arrays exceptions.  
- Always set the values with the Put method and get them from the SlotX fields.  
- If you want to store items longer than 255 bytes then you should also change the type of "lengths" array from Byte to UInt.  
  
  
It depends on rRandomAccessFile library.  
  
**Library is included as an internal b4xlib library.**