### Convert Complex Structures of Lists and Maps to YAML Strings: can also be used to convert JSON to YAML. by William Lancee
### 09/13/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/163074/)

[B4X]Convert Complex Stuctures of Lists and Maps to YAML Strings: can also be used to convert JSON to YAML.  
  
In my endless pursuit of knowledge, I have been experimenting with VPS servers.  
I came across various API standards. The OpenAPI web site has examples of JSON API strings that could be used in a standard way.  
The interesting part is that they display the protocol strings in JSON format but also in YAML format - something I was not familiar with.  
   
 <https://spec.openapis.org/oas/latest.html> (scroll down to relevant section)  
  
Coming from struggling with the myriad of nested brackets of Java and Javascript to the beauty of B4X code,  
I was happy to see that the brackets of JSON are gone in the equivalent YAML! YAML format is a pleasure to read.  
[USER=1]@Erel[/USER] wrapped a YAML parser:  
  
 <https://www.b4x.com/android/forum/threads/b4x-YAML-parser.129461/>  
 <https://github.com/EsotericSoftware/YAMLbeans>  
  
While the YAML writer is part of the github source, the writer part is not exposed in the wrapper.  
However, once you have a B4X structure of maps and lists it is not hard to render it in YAML format.  
  
This is what I did. There were some gotchas, but it didn't take long.  
In general you can use it to display any complex structure in a (this) human readable format.  
  
To convert JSON to YAML, you parse the JSON, and then use the "structureToYAML" sub to convert the map/list structure to YAML.  
The gotcha is that the JSON parser preserves order in lists but not in keys - look at the code to see how I restored key order.  
While key order does not affect the functionality of JSON, it makes it much easier to compare JSON with YAML strings.  
  
As a bonus, I have included in the attached file a .bjl .bal .bil reader that converts these files to YAML format.  
It is based on the BalConverter written by [USER=1]@Erel[/USER]. I modified it slightly to return a map object which is then converted into a YAML string.  
  
 <https://www.b4x.com/android/forum/threads/b4x-balconverter-convert-the-layouts-files-to-json-and-vice-versa.41623/>  
   
The converter sub (structureToYAML) does all the work and is not splatform specific.  
The demo in the attached .zip file has 5 examples that can be viewed.  
The demo app can also be used as a standalone app to paste JSON from the clipboard and copy the YAML to the clipboard.  
  
I have tested the demo in B4J and B4A but it needs modification to work in B4i.  
The layout file example relies on BalConverter, which only works in B4j. I disabled the example in B4A.  
  
In a recent post by [USER=74499]@aeric[/USER] I saw a large, unusual JSON string. It was very difficult to understand its structure.  
After converting this JSON to YAML preserving key order, the structure becomes clear. I added it as an example in the demo.  
  
If you try it and find errors or omissions, let me now in this thread. I'll make corrections.  
  
![](https://www.b4x.com/android/forum/attachments/156891)