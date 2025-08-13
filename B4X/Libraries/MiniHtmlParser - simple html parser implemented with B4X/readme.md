###  MiniHtmlParser - simple html parser implemented with B4X by Erel
### 02/06/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/118590/)

MiniHtmlParser is a cross platform class that parses html strings and creates a tree with the various elements.  
It is a less powerful alternative to jTidy or jSoup, however it is simple to use, cross platform and as it is implemented in B4X it can be extended quite easily.  
Note that many real-world html pages are not 100% valid. The parser tries to handle a few cases, far from browsers which can handle many common html problems.  
  
The example demonstrates how to use the parser.  
It parses the html saved from: <https://www.x-rates.com/table/?from=USD&amount=1> and finds the rates from the top 10 currencies. This is only done as an example.  
  
Depends on B4XCollections.  
  
  
Updates:  
  
- 0.95 - Fixes an issue with attributes keys containing dashes. Thank you [USER=74499]@aeric[/USER] for the fix!  
- 0.94 - New FindDirectNodes method. Returns a list with the direct child nodes that match the tag name and optionally the attribute.  
New IsNodeMatches methods - tests whether the given node matches the tag name and optionally the attribute.  
Example was updated. It was broken by the change in v0.93. It is now built using FindDirectNodes and is more robust than the previous implementation.  
  
- 0.93 - Fixes an issue with whitespace characters being removed too aggressively.  
- 0.92 - Unescapes more entities including entities written with the unicode code point, e.g. &#8501;  
- 0.91 - Fixes an issue with text after the last element.