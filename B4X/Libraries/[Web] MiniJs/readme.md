### [Web] MiniJS by aeric
### 02/11/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/169204/)

Version 0.30  
  
Generate Js with B4X code.  
  
GitHub: <https://github.com/pyhoon/MiniJs-B4X>  
  
Example:  

```B4X
Dim details As Map  
details.Initialize  
details.Put("entity", entity)  
details.Put("action", action)  
details.Put("message", message)  
details.Put("status", status)  
  
Dim script1 As MiniJs  
script1.Initialize  
script1.AddCustomEventDispatch("entity:changed", details)  
Response.Write(script1.Generate)
```

  
Output:  

```B4X
document.dispatchEvent(new CustomEvent('entity:changed', {  
    detail: {  
        entity: 'Product',  
        action: 'updated',  
        message: 'Product updated successfully!',  
        status: 'info'  
    }  
}));
```