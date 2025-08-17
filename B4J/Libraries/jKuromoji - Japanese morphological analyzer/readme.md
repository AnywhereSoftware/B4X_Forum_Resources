### jKuromoji - Japanese morphological analyzer by xulihang
### 08/19/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/149692/)

This is a simple wrapper of this library: <https://github.com/atilika/kuromoji>  
  
Usage:  
  

```B4X
#AdditionalJar: kuromoji-core-0.9.0.jar  
#AdditionalJar: kuromoji-ipadic-0.9.0.jar  
  
Public Sub Analyse  
    Dim tokenizer As KuromojiTokenizer  
    tokenizer.Initialize  
    Dim tokens As List = tokenizer.tokenize("あの人のことが気になる。")  
    For Each token As KuromojiToken In tokens  
        Log(token.Surface &"    "& token.AllFeatures)  
    Next  
End Sub
```

  
  
Output:  
  

```B4X
あの    連体詞,*,*,*,*,*,あの,アノ,アノ  
人    名詞,一般,*,*,*,*,人,ヒト,ヒト  
の    助詞,連体化,*,*,*,*,の,ノ,ノ  
こと    名詞,非自立,一般,*,*,*,こと,コト,コト  
が    助詞,格助詞,一般,*,*,*,が,ガ,ガ  
気    名詞,一般,*,*,*,*,気,キ,キ  
に    助詞,格助詞,一般,*,*,*,に,ニ,ニ  
なる    動詞,自立,*,*,五段・ラ行,基本形,なる,ナル,ナル  
。    記号,句点,*,*,*,*,。,。,。
```