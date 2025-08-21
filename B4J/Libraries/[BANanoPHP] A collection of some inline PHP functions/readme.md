### [BANanoPHP] A collection of some inline PHP functions by Mashiane
### 06/13/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/118778/)

Ola  
  
[**Download**](https://github.com/Mashiane/BANanoPHP)  
  
With intentions to do some PHP related functions, i've thought why not make a class with all functions that could be used. Besides uploading files, sending emails, we can do other things too. This is based on some stuff I have been using..  
  
Will sectionalize the examples… and all follow the INLINE PHP approach.  
  
In AppStart, ensure that your PHP settings are done properly..  
  

```B4X
'set php settings  
    BANano.PHP_NAME = $"${AppName}.php"$  
    BANano.PHPHost = $"http://${ServerIP}:${Port}/${AppName}/"$  
    BANano.PHPAddHeader("Access-Control-Allow-Origin: *")
```

  
  
We will keep the list updated as we find more stuff..