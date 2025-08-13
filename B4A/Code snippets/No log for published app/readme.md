### No log for published app by toby
### 09/03/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/150012/)

Since it's not recommended for your published apps to write logs, the code below will do that for you.  

```B4X
#If Release_obfuscated=""  
        #BridgeLogger: True  
 #End If
```

  
  
Note: Release\_obfuscated is a [wished](https://www.b4x.com/android/forum/threads/compiler-directive-release_obfuscated.139352/) built-in conditional symbol, and until the wish comes true you need to define it manually.