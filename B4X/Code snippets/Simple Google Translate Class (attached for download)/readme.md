###  Simple Google Translate Class (attached for download) by TILogistic
### 12/12/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/164544/)

Translation of texts from the source language to the target language with Google Translate (free)  
  
**Sorry, the class and example are now attached for download.**  
  

```B4X
    Dim Translate As clsGoogleTranslate  
    Translate.Initialize  
    'Local to engles  
    Wait For (Translate.Target("en").Text(B4XFloatTextField1.Text)) Complete (Result As String)  
    'Engles to italian  
    Wait For (Translate.Source("en").Target("it").Text(B4XFloatTextField1.Text)) Complete (Result As String)  
    B4XFloatTextField2.Text = Result
```

  
  
![](https://www.b4x.com/android/forum/attachments/159362)  
  
**SAMPLES:**  
Local to Engles  
  

```B4X
    Wait For (Translate.Target("en").Text(B4XFloatTextField1.Text)) Complete (Result As String)
```

  
![](https://www.b4x.com/android/forum/attachments/159360)  
  
Engles to italian  

```B4X
    Wait For (Translate.Source("en").Target("it").Text(B4XFloatTextField1.Text)) Complete (Result As String)
```

  
  
![](https://www.b4x.com/android/forum/attachments/159361)  
  
Regards