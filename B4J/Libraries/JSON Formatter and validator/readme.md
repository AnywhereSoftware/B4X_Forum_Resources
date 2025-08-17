### JSON Formatter and validator by stevel05
### 08/07/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/149175/)

I am working on an app that needs to be able to manipulate JSON strings. They are stored in a compact format then prettified for display and editing.  
  
The main problem I have found is that if the json is invalid, it can't be prettified with the existing JSON lib. I found [this](https://github.com/Aftaab99/JSONFormatter/tree/master) project on github and ported the format class to B4j with a few additions.  
  
  

![](https://www.b4x.com/android/forum/attachments/143956) ![](https://www.b4x.com/android/forum/attachments/143957)

  
  
  
The class also has methods to compact the string and validate the JSON.  
  
The FormatJSON method should be able to be used with B4a feel free to copy it over. I don't know if the JSON libraries are compatible to enable use of the validation.  
  
Attached are an Example project and a B4xlib  
  
There are no external dependencies.  
  
I hope you find it useful. Please let me know if you find any issues.