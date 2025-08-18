### Vertical Text Engine by xulihang
### 10/15/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/123168/)

Words in Chinese, Japanese and Korean (CJK) can be arranged vertically and I didn't find a good vertical text engine for B4X. In the previous [thread](https://www.b4x.com/android/forum/posts/681136/) I posted, Erel gave a workground solution but it cannot display multiline text and punctuations correctly, The BCTextEngine does not have this support yet, too. So I decided to make one.  
  
I just use Canvas to draw text and use B4XCanvas to measure text.  
  
Example:  
  
text:  
  

```B4X
今日から  
みんなと勉強  
する事になった、  
灰原哀さん  
です！
```

  
  
result:  
  
![](https://www.b4x.com/android/forum/attachments/101017)  
  
Update 2020/10/07  
  
1. Support Text Wrap  
2. Bug fixes