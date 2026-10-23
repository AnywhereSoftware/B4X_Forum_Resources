###   Removing accents from a string in an optimized way by GeoT
### 10/18/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/172314/)

Removing accents and converting text to lowercase in the output helps sort text strings logically and create efficient dictionaries or search indices.  
  
In Process\_Globals or Globals:  

```B4X
Private staticNormalizer As JavaObject  
Private nfdEnum As JavaObject
```

  
  
During initialization (e.g., AppStart in B4J or Service\_Create / Activity\_Create in B4A or B4XPage\_Created with B4XPages ):  

```B4X
' Initialize heavy Java objects ONLY ONCE  
staticNormalizer.InitializeStatic("java.text.Normalizer")  
Dim nfdForm As JavaObject  
nfdForm.InitializeStatic("java.text.Normalizer$Form")  
nfdEnum = nfdForm.GetFieldJO("NFD")
```

  
  
Subroutine:  

```B4X
Public Sub RemoveAccents(s As String) As String  
    If s = "" Then Return ""  
   
    ' 1. Normalize to NFD (Separate the accent marks)  
    Dim normalized As String = staticNormalizer.RunMethod("normalize", Array(s, nfdEnum))  
    Dim joStr As JavaObject = normalized  
  
    ' Example: The word "été" is broken down internally into: e + ´ + t + e + ´.  
  
    ' 2. Replace diacritics (Store the result in a clean String variable)  
    ' A single slash \p{M}+ for JavaObject  
    Dim result As String = joStr.RunMethod("replaceAll", Array("\p{M}+", ""))  
  
    ' Delete all those stray accent marks that ended up separated.  
   
    ' 3. Return according to the use case  
    Return result.Trim.ToLowerCase  
End Sub
```

  
  
'Call:  

```B4X
Private Sub Button1_Click  
    xui.MsgboxAsync(RemoveAccents("«Bonjour ! Ce matin, l’été était déjà là. Une légère brise soufflait à travers les arbres, tandis que les oiseaux chantaient près de la rivière. Après quelques minutes de marche, j’ai aperçu un magnifique château entouré de fleurs et de vieux chênes.»"), "Title")  
End Sub
```

  
  
Note: Special characters such as the French quotation marks « » or the apostrophe are preserved because they are not part of the diacritical marks \p{M}+).