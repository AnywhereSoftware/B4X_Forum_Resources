### Using OBJC to find the values of native constants by Erel
### 03/10/2024
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/159793/)

Apple documentation doesn't list the actual values of the various constants.  
These values are needed when calling native methods with NativeObject.  
  
You can use OBJC code to log these values:  

```B4X
#if OBJC  
-(void) test {  
    NSLog(@"%@", NSForegroundColorAttributeName);  
    NSLog(@"%@", NSUnderlineColorAttributeName);  
    NSLog(@"%@", NSUnderlineStyleAttributeName);  
    NSLog(@"%@", @(NSTextAlignmentRight)); //non-string values should be wrapped with @(…)  
}  
#End If
```

  
  

```B4X
Me.As(NativeObject).RunMethod("test", Null)
```