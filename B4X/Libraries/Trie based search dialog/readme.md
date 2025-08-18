###  Trie based search dialog by Erel
### 09/28/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/134220/)

![](https://www.b4x.com/android/forum/attachments/119022)  
  
This started as an educational project but it can be useful in some cases.  
Trie is an interesting data structure that allows fast lookup of prefix matches. It is a tree of prefixes.  
  
![](https://www.b4x.com/android/forum/attachments/119024)  
Source: <https://en.wikipedia.org/wiki/Trie>  
  
In the B4X implementation, each node holds a character, a list of child nodes and a list of full values. The tree depth is configurable and in most cases it should be 2 or 3.  
The child nodes are sorted. This later allows us to quickly find the path in the tree using binary search.  
**The items list is expected to be sorted in ascending order.** This allows to build the tree very fast. It takes about 45 milliseconds to build a tree made of 37,500 items on my Android device.  
  
The example project builds a trie from a list of cities. Database source: <https://simplemaps.com/data/world-cities>  
The trie is implemented in a separate class and can be used without the search template.  
  
While testing it on B4i, I've encountered a strange issue that required deep investigation. B4i uses the default sorting and string comparison options. I'm not sure whether it is a bug or not (in the underlying framework) but it doesn't sort non-ascii characters as expected.  
The solution is to add a [flag](https://developer.apple.com/documentation/foundation/nsstringcompareoptions/nsliteralsearch) to these methods. It will be implemented in the next version of B4i.