### jXmlSaxEnhanced by xulihang
### 06/22/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/148641/)

The current jXmlSax library cannot parse the following xml:

```B4X
<g id="1">Styles like <g id="2">bold</g> is supported.</g>
```

  
  
It lacks the character event as discussed here: <https://www.b4x.com/android/forum/threads/xmlsax-cannot-parse-correctly-when-elements-and-text-are-mixed.121134/#post-757245>  
  
I modify the jXmlSax library to add the characters event and rename it as jXmlSaxEnhanced.  
  
Code modified: <https://github.com/xulihang/B4J_XmlSax/commit/96f0e2b4ad743bb0dbd62e0a3c8288c9d166f941>