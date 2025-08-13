###  Arabic Numbers To Words by Hamied Abou Hulaikah
### 08/21/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/142469/)

This is a wrapper for this [github](https://github.com/bluemix/NumberToArabicWords).  
It transliterates numbers to arabic words.  
Usage:  

```B4X
Sub Button1_Click  
    Dim i As NumberToWords      
    xui.MsgboxAsync(i.n2w("4863294"), "B4X")  
End Sub
```