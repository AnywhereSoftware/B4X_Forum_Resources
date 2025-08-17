###  Xml2Map - Simple way to parse XML documents by Erel
### 07/16/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/74848/)

Nobody likes to parse XML.  
  
Parsing JSON is simple and fun. Parsing XML is tedious and boring.  
  
That is the reason behind the Xml2Map class. It internally parses the XML document and returns a Map with the parsed data. It is similar to parsing JSON.  
Tip: You can use this tool to help you with parsing JSON: <https://b4x.com:51041/json/index.html>  
  
So instead of the code explained in the old tutorial: <https://www.b4x.com/android/forum/threads/xml-parsing-with-the-xmlsax-library.6866/#content>  
  
We can achieve the same thing with this code:  

```B4X
Sub Process_Globals  
   Private ParsedData As Map  
End Sub  
  
Sub Globals  
   Private ListView1 As ListView  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   If FirstTime Then  
     Dim xm As Xml2Map  
     xm.Initialize  
     xm.StripNamespaces = True '<— new in v1.01  
     ParsedData = xm.Parse(File.ReadString(File.DirAssets, "rss.xml"))  
   End If  
   Activity.LoadLayout("1")  
   ListView1.SingleLineLayout.ItemHeight = 60dip  
   Dim rss As Map = ParsedData.Get("rss")  
   Dim channel As Map = rss.Get("channel")  
   Dim items As List = channel.Get("item")  
   For Each item As Map In items  
     Dim title As String = item.Get("title")  
     Dim link As String = item.Get("link")  
     ListView1.AddSingleLine2(title, link)  
   Next  
End Sub  
  
Sub ListView1_ItemClick (Position As Int, Value As Object)  
   Dim pi As PhoneIntents  
   StartActivity(pi.OpenBrowser(Value))  
End Sub
```

  
  
You can use the JSON library to convert the Map to a json string, this is useful for understanding how to access the data:  

```B4X
Dim jg As JSONGenerator  
jg.Initialize(ParsedData)  
Log(jg.ToPrettyString(4))
```

  
  
The result in this case will look like:  
> "rss": {  
>  "Attributes": {  
>  "version": "2.0"  
>  },  
>  "channel": {  
>  "title": "Basic4ppc \/ Basic4android - Android programming",  
>  "link": "http:\/\/[www.b4x.com\/forum](http://www.b4x.com\/forum)",  
>  "description": "Basic4android - android programming and development",  
>  "language": "en",  
>  "lastBuildDate": "Sun, 12 Dec 2010 10:19:27 GMT",  
>  "generator": "vBulletin",  
>  "ttl": "60",  
>  "image": {  
>  "url": "http:\/\/[www.b4x.com\/forum\/images\/misc\/rss.jpg](http://www.b4x.com\/forum\/images\/misc\/rss.jpg)",  
>  "title": "Basic4ppc \/ Basic4android - Android programming",  
>  "link": "http:\/\/[www.b4x.com\/forum](http://www.b4x.com\/forum)"  
>  },  
>  "item": [  
>  {  
>  "title": "Phone library was updated - V1.10",  
>  "link": "http:\/\/[www.b4x.com\/forum\/additional-libraries-official-updates\/6859-phone-library-updated-v1-10-a.html](http://www.b4x.com\/forum\/additional-libraries-official-updates\/6859-phone-library-updated-v1-10-a.html)",  
>  "pubDate": "Sun, 12 Dec 2010 09:27:38 GMT",  
>  "description": "An Intent object was added. This allows creating custom intents for interacting with external applications and services.\n\nInstallation…",  
>  "encoded": "<div>An Intent object was added…",  
>  "category": {  
>  "Attributes": {  
>  "domain": "http:\/\/[www.b4x.com\/forum\/additional-libraries-official-updates\/](http://www.b4x.com\/forum\/additional-libraries-official-updates\/)"  
>  },  
>  "Text": "Additional libraries and official updates"  
>  },  
>  "creator": "Erel",  
>  "guid": {  
>  "Attributes": {  
>  "isPermaLink": "true"  
>  },  
>  "Text": "http:\/\/[www.b4x.com\/forum\/additional-libraries-official-updates\/6859-phone-library-updated-v1-10-a.html](http://www.b4x.com\/forum\/additional-libraries-official-updates\/6859-phone-library-updated-v1-10-a.html)"  
>  }  
>  MORE ITEMS HERE

  
Note that attributes are added under the Attributes key. In such cases the text will be available under the Text key.  
  
**This module is compatible with B4A, B4J and B4i.**  
It depends on XmlSax library (which is included in the IDE).  
  
![](https://www.b4x.com/android/forum/attachments/51651)  
  
**Edit (October 2017):  
  
Common pitfall**  
  
Consider this xml:  

```B4X
<root>  
<book>  
   <title>Book 1</title>  
</book>  
<book>  
   <title>Book 2</title>  
</book>  
</root>
```

  
  
There could be any number of book elements.  
You can parse it with:  

```B4X
Dim root As Map = ParsedData.Get("root")  
For Each book As Map In root.Get("book")  
Dim title As String = book.Get("title")  
Next
```

  
However this code will fail in two cases:  
1. There is only one book in the xml so root.Get("book") will return a Map instead of a List.  
2. There are no books at all so root.Get("book") will return Null.  
  
To solve this issue you can use this sub:  

```B4X
Sub GetElements (m As Map, key As String) As List  
   Dim res As List  
   If m.ContainsKey(key) = False Then  
     res.Initialize  
     Return res  
   Else  
     Dim value As Object = m.Get(key)  
     If value Is List Then Return value  
     res.Initialize  
     res.Add(value)  
     Return res  
   End If  
End Sub
```

  
It will return a list in all cases.  
You can safely use it with:  

```B4X
Dim root As Map = ParsedData.Get("root")  
For Each book As Map In GetElements(root, "book"))  
Dim title As String = book.Get("title")  
Next
```

  
  
  
**Map2Xml - New class!**  
  
Map2Xml converts the map created with Xml2Map to a Xml string. It uses XmlBuilder library and it is compatible with B4A, B4i and B4J.  
It can be used to modify existing XML documents. You read the document with Xml2Map, make the changes in the returned map and write it back with Map2Xml.  
  
**It is an internal library now.**  
  
Updates:  
  
- v1.01 - New StripNamespaces property. When set to true the namespaces from keys and attributes are stripped. It is recommend to set it true. The behavior regarding namespaces, between B4A, B4J and B4i is different when namespaces are kept.