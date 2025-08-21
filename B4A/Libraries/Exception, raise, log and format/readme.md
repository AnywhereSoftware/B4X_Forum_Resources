### Exception, raise, log and format by spsp
### 05/22/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/118074/)

Hello,  
  
Sometimes you need to stop a piece of code and explain why you have to do it.  
  
A good way is to raise an exception and to give information about the reason why.  
  
This little class offers you a pratical way to do this :  
1) Add the class to your project  
  

```B4X
Public fException As clsException
```

  
Declare the instance in the starter module is a good idea  
  

```B4X
Starter.fException.raise("Main","fButton_Click",1,$"Too big : (${i})"$,True)
```

  
You pass the module, the method, an erorr number, an error message and say if you want to log the exception.  
  

```B4X
wait for (fXUI.MsgboxAsync(Starter.fException.info,"Exception")) msgbox_result(result As Int)
```

  
![](https://www.b4x.com/android/forum/attachments/94528)  
  
Class and example in the zip archive  
  
SPSP