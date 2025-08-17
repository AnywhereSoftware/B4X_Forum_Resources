### jtokkit - Java Tokenizer Kit by DonManfred
### 10/05/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/163440/)

This is a wrap for this [Github-Project](https://github.com/knuddelsgmbh/jtokkit)   
  
JTokkit is a Java tokenizer library designed for use with OpenAI models.  
[jtokkit.knuddels.de/](https://jtokkit.knuddels.de/)  
  
Download the jar from <https://mvnrepository.com/artifact/com.knuddels/jtokkit/1.1.0> and put it into your additional library folder.  
Same for the files in Attachment.  
  
[HEADING=1] Introduction[/HEADING]  
JTokkit aims to be a fast and efficient tokenizer designed for use in natural language processing tasks using the OpenAI models. It provides an easy-to-use interface for tokenizing input text, for example for counting required tokens in preparation of requests to the GPT-3.5 model. This library resulted out of the need to have similar capacities in the JVM ecosystem as the library [tiktoken](https://github.com/openai/tiktoken) provides for Python.  
[HEADING=1]? Features[/HEADING]  
✅ Implements encoding and decoding via r50k\_base, p50k\_base, p50k\_edit, cl100k\_base and o200k\_base  
✅ Easy-to-use API  
✅ Easy extensibility for custom encoding algorithms  
✅ **Zero** Dependencies  
✅ Supports Java 8 and above  
✅ Fast and efficient performance