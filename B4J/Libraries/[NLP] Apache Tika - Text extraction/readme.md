### [NLP] Apache Tika - Text extraction by Erel
### 08/22/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/133494/)

<https://tika.apache.org/>  
Apache license 2.0  
  
![](https://www.b4x.com/basic4android/images/CmRAxqdCG6.gif)  
  
As I wrote [here](https://www.b4x.com/android/forum/threads/new-feature-is-coming-opennlp-text-analysis.133313/), I intend to focus on text analysis / natural language processing in the near future. The first step to analyze text, is to be able to extract it.  
Apache Tika is an open source project that allows extracting text and meta data from many formats: <https://tika.apache.org/1.27/formats.html>  
  
It is based on many other open source projects and provides a simple and consistent API.  
  
**Instructions**  
  
1. Download the dependencies jars: [www.b4x.com/b4j/files/Tika.zip](http://www.b4x.com/b4j/files/Tika.zip) (70mb).  
2. Copy the Tika folder to the additional libraries folder. **Make sure to keep the Tika folder.**  
3. Download Tika.b4xlib and put it in the additional libraries folder.  
  
Parsing is a matter of calling:  

```B4X
Wait For (Tik.Parse(File.OpenInput(dir, filename))) Complete (Res As TikaParseResult)
```

  
See the attached example. The example depends on DragAndDrop2.b4xlib: <https://www.b4x.com/android/forum/threads/jdraganddrop2-drag-and-drop.76168/post-636391>  
  
**Notes**  
  
1. Develop in debug mode. If you want to develop in release mode then set #MergeLibraries: False. Otherwise it will slow down compilation as building the single jar can take a while.  
It is possible to build a single jar, it just takes some time to build it.  
2. Tika will not work with the standalone package (which is the same as B4JPackager11).  
3. You will see a red warning in the logs about a missing dependency (jai-image-io). Ignore it.  
4. This library requires Java 11+: <https://www.b4x.com/b4j.html>