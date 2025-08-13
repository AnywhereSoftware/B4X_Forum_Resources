### New b4x library compiler tool - like Simple Library Compiler - [open source] by tummosoft
### 08/14/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/158440/)

![](https://www.b4x.com/android/forum/attachments/149305)  
  
I am a fan of the B4X family, and I want to create many libraries for B4X versions like B4J, B4A… However, the obstacle that makes me lazy is the time-consuming process of searching for .jar libraries. BAdoclet is outdated and only works with Java 8, while SLC does not support Unicode.  
  
Therefore, I want to develop another version of Simple Library Compiler to compile .jar libraries. It should be compatible with newer SDKs, generate doclet documentation, and download necessary libraries from Maven. My ideas are plentiful, but completion requires time. This tool is written in B4J, allowing users to download, customize, and add options as they see fit.  
  
I use Apache Ant as the compiler and package manager for this tool. Here are the features that Tummo Compiler Pro has completed:  
  

- Compile libraries with any JDK.
- Support Unicode.
- Compile doclet XML with Java 8 without installing Java 8, as it is included in the compressed file.
- Help download all repositories from Maven.
- Compile libraries for B4J.

[Source Code in Github](https://github.com/tummosoft/TummoCompilerPro/tree/main)  
  
Wishing everyone a peaceful and happy New Year!  
  
[MEDIA=youtube]v5Uj1Xth8IA[/MEDIA]