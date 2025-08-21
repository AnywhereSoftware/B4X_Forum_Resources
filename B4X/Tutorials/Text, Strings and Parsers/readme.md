###  Text, Strings and Parsers by Erel
### 05/19/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/83510/)

This guide is relevant for B4A, B4i and B4J.  
  
There are all kinds of tools and libraries available for the different text based formats. The purpose of this guide is to organize the available resources.  
  
**JSON**  
  
JSON (B4X) library supports parsing and generating JSON strings.  
This online tool will help you with the parsing code: <https://b4x.com:51041/json/index.html>  
  
**XML**  
  
XmlSax (B4X) - SAX parser for XML documents. SAX = event based parser.  
Tutorial: <https://www.b4x.com/android/forum/threads/6866/#content>  
[Xml2Map class](https://www.b4x.com/android/forum/threads/74848/#content) (B4X) - Parses XML documents and returns a Map with the parsed data. Similar to working with JSON strings. This is the recommend parsing method.  
XOM (B4A) - DOM parser library created by [USER=11161]@warwound[/USER].  
  
XmlBuilder (B4A, B4J) / iXmlBuilder (B4i) - XML generator.  
  
**HTML**  
  
jTidy (B4A, B4J) - Converts a html document to valid XML.  
jSoup (B4A, B4J) - HTML parser. Library developed by [USER=29590]@TheJinJ[/USER].  
  
**CSV** (comma separated values)  
  
StringUtils (B4X) - Reads and writes CSV files.  
[CSVParser](https://www.b4x.com/android/forum/threads/b4x-csvparser-csv-parser-and-generator.110901/#content) (B4X) - B4X class that reads and writes CSV files. It can handle non-UTF8 encoding and can be customized to better handle errors.  
  
**Base64 encoding**  
  
It is a common mistake to treat raw bytes as strings. It doesn't work.  
If you want to convert raw bytes to a string then you need to use the Base64 encoding.  
StringUtils library supports converting bytes to base64 string and vice versa.  
  
**String to bytes**  
  

```B4X
'string to bytes  
Dim s As String = "abc"  
Dim b() As Byte = s.GetBytes("UTF8")  
'bytes to string:  
s = BytesToString(b, 0, b.Length, "UTF8")
```

  
BytesConverter library written by [USER=448]@agraham[/USER] also supports similar methods.  
  
**Regular Expression (regex)**  
  
Regex from the core library allows using regular expressions to parse strings.  
Tutorial: <https://www.b4x.com/android/forum/threads/7123/#content>  
Online tool to test regex: <https://b4x.com:51041/regex_ws/index.html>  
New builder to help with building regex patterns: <https://www.b4x.com/android/forum/threads/83495/#content>  
  
**StringFunctions library**  
  
A relatively popular library named StringFunctions is available. It was written by [USER=11599]@margret[/USER].  
I don't recommend using it as it is not maintained and all its features are already available in the core library.