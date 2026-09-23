### [b4j] PD_KeyboardLanguage by behnam_tr
### 09/15/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/172074/)

KeyboardLanguage changer (windows only)  
  
how use :  

```B4X
    Private kb As PD_KeyboardLanguage  
    Private LanguageCodes As PD_LanguageCodes  
   
    kb.changeLanguage(LanguageCodes.PERSIAN)  
  
    kb.changeLanguage(LanguageCodes.ENGLISH_US)  
   
    Log(kb.CurrentLanguage.toString)  
    
    Log(kb.isLanguageInstalled(LanguageCodes.PERSIAN))  
    
    For Each lang As PD_LanguageInfo In kb.InstalledLanguages  
        Log(lang.Code)  
        Log(lang.Name)  
    Next
```

  
  
**download lib+jar (**[**Download link**](https://drive.google.com/file/d/1UF66VjlNw7zfp_3oEVLEdF17cLHWmJeC/view?usp=sharing)**)**