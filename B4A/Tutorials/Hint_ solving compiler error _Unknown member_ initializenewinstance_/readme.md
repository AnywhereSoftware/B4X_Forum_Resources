### Hint: solving compiler error "Unknown member: initializenewinstance" by walt61
### 01/25/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/126934/)

I ran into this one today and fortunately my penny dropped rather quickly, though I didn't find anything on the forum about this error; hence this post as it might be useful for others. I was changing a standard app into a B4Xpages one, and this error showed up:  

```B4X
Unknown member: initializenewinstance  
Current declaration does not match previous one.  
Previous: {Type=Listener,Rank=0, RemoteObject=False}  
Current: {Type=JavaObject,Rank=0, RemoteObject=True}
```

  
  
My original app contained a service called 'Listener', and I assume the B4Xpages environment introduces an object also called 'Listener'. I changed the name of my service (and, obviously, all references to it) and the error was gone.