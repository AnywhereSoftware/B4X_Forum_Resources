### [Server] Online Json Tree Example by Erel
### 07/06/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/39048/)

This example is a port of the following desktop example: <http://www.b4x.com/android/forum/threads/jsontree-tool-to-help-with-json-parsing-b4a-b4j.35963/>  
  
![](http://www.b4x.com/basic4android/images/SS-2014-03-20_11.43.42.png)  
  
You can try it online: <https://b4x.com:51041/json/index.html>  
  
The server parses the JSON string and returns the tree representation and also the B4A / B4J code you need in order to parse it.  
  
The code is similar to the desktop solution code. The main difference is that the tree is built with standard HTML lists, so instead of adding the elements to a real TreeView we need to build a string.  
  
The tree style is based on this blog: <http://odyniec.net/articles/turning-lists-into-trees/>  
The HTML divs are scrollable. This is done with this plugin: <http://www.jacklmoore.com/autosize/>